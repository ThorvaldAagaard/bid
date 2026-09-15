"""Drive a full card-by-card play against the remote Brill engine.

``/play`` is the only endpoint in the service whose contract is not obvious
from its parameter list, and getting it wrong gives a bare HTTP 400. The
rules below were recovered by probing the live service; the error bodies it
returns are unusually good teachers:

* **``played`` has no separator.** ``["S7", "SA"]`` -> ``"S7SA"``. A comma
  is an HTTP 400 (*"has odd length"*).
* **Position 1 is declarer's LHO**, i.e. the opening leader. Every position
  after that is the *real* play order, so after trick one the winner of the
  previous trick leads — the list is **not** a repeating N-E-S-W cycle.
  Sending a flat cycle makes the service complain that card N is "assigned to
  X but not in X's hand", which is how you can read its internal assignment
  back.
* **``hand`` must be the seat's original 13 cards.** The service subtracts
  ``played`` itself; passing a 12-card remainder is an HTTP 400
  (*"has 12 cards (expected exactly 13)"*).
* **Zero cards played is not this endpoint.** It answers *"No cards played.
  For opening lead, use the /lead endpoint instead of /play."*

:class:`PlayState` tracks all of that so callers only push cards::

    from bid.brill import BrillClient, PlayState

    c = BrillClient()
    st = PlayState(hands, ctx="1N-P-P-P", dealer="N", vul="None")
    while not st.complete:
        st.push(st.ask(c).card)          # /lead for card 0, then /play
    print(st.tricks())                   # (NS, EW)

``PlayState`` does its own trick-winner and follow-suit bookkeeping, so it
can also be used standalone with a local engine.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Sequence, Tuple

from bid.models import CallType

from .convert import (card_str, deal_pbn, hand_pbn, parse_ctx,
                      parse_hand_pbn, played_str, seat_letter)

__all__ = ["Contract", "PlayState", "trick_winner", "contract_of"]

# Clockwise. Index arithmetic on this tuple is the whole seat model.
_SEATS = ("N", "E", "S", "W")
_RANK_VALUE = {"A": 14, "K": 13, "Q": 12, "J": 11, "T": 10,
               "9": 9, "8": 8, "7": 7, "6": 6, "5": 5,
               "4": 4, "3": 3, "2": 2}


def _idx(seat: Any) -> int:
    return _SEATS.index(seat_letter(seat))


def _letter(i: int) -> str:
    return _SEATS[i % 4]


def _partner(seat: Any) -> str:
    return _letter(_idx(seat) + 2)


def _lho(seat: Any) -> str:
    """Left-hand opponent: the seat that leads, clockwise."""
    return _letter(_idx(seat) + 1)


def _rank(card: str) -> int:
    return _RANK_VALUE[card_str(card)[1]]


def _suit(card: str) -> str:
    return card_str(card)[0]


# ------------------------------------------------------------------ contract
@dataclass
class Contract:
    """The final contract of an auction."""

    level: int = 0
    strain: str = ""            # "N" | "S" | "H" | "D" | "C"
    declarer: str = ""          # "N" | "E" | "S" | "W"
    doubled: int = 0            # 0 none, 1 doubled, 2 redoubled

    @property
    def passed_out(self) -> bool:
        return not self.strain

    @property
    def trump(self) -> Optional[str]:
        """Trump suit letter, or ``None`` for notrump."""
        return None if self.strain in ("N", "") else self.strain

    @property
    def dummy(self) -> str:
        return _partner(self.declarer)

    @property
    def lho(self) -> str:
        """Opening leader — the seat ``played`` position 1 belongs to."""
        return _lho(self.declarer)

    @property
    def declarer_side(self) -> str:
        return "NS" if _idx(self.declarer) % 2 == 0 else "EW"

    def __str__(self) -> str:
        if self.passed_out:
            return "Passed out"
        return "%d%s%s%s" % (self.level, self.strain,
                             "XX" if self.doubled == 2
                             else "X" if self.doubled == 1 else "",
                             "" if not self.declarer
                             else " by " + self.declarer)


def contract_of(ctx: Any, dealer: Any = "N") -> Contract:
    """Work out the final contract from a Brill auction string.

    ``dealer`` sets which seat made call 0 (the first call in ``ctx``), so
    getting it wrong moves the contract to the wrong hand — Brill uses the
    same convention.
    """
    calls = parse_ctx(ctx)
    if not calls:
        return Contract()
    first = _idx(dealer)

    bids: List[Tuple[int, int, str]] = []       # (index, level, strain)
    for i, c in enumerate(calls):
        if c.type == CallType.BID:
            bids.append((i, c.level, str(c.strain).replace("NT", "N")))
    if not bids:
        return Contract()                        # passed out

    last_i, level, strain = bids[-1]
    declaring_side = (first + last_i) % 2        # 0 = N/S, 1 = E/W
    # Declarer is the first member of that side to have named the strain.
    declarer_i = next(i for i, lv, st in bids
                      if st == strain and (first + i) % 2 == declaring_side)

    doubled = 0
    for c in calls[last_i + 1:]:
        if c.type == CallType.DOUBLE:
            doubled = 1
        elif c.type == CallType.REDOUBLE:
            doubled = 2

    return Contract(level=level, strain=strain,
                    declarer=_letter(first + declarer_i), doubled=doubled)


# --------------------------------------------------------------- trick logic
def trick_winner(trick: Sequence[Tuple[Any, Any]],
                 trump: Optional[str] = None) -> Optional[str]:
    """Seat that wins a partial or complete trick.

    ``trick`` is ``[(seat, card), ...]`` in play order. Highest card of the
    led suit wins unless someone ruffs, in which case the highest trump does.
    Returns ``None`` for an empty trick.
    """
    if not trick:
        return None
    led = _suit(trick[0][1])
    best_seat, best_card = trick[0][0], trick[0][1]
    for seat, card in trick[1:]:
        suit = _suit(card)
        if trump and suit == trump:
            if (_suit(best_card) != trump) or (_rank(card) > _rank(best_card)):
                best_seat, best_card = seat, card
        elif _suit(best_card) != trump and suit == led \
                and _rank(card) > _rank(best_card):
            best_seat, best_card = seat, card
    return seat_letter(best_seat)


# ---------------------------------------------------------------- play state
@dataclass
class PlayState:
    """Track one board's card play and turn it into Brill query values.

    Args:
        hands: ``{seat: Hand|PBN}`` — must be the **original 13-card** hands;
            the service subtracts the played cards itself.
        ctx: auction string (or a list of ``Call``).
        dealer: seat that made the first call of ``ctx``.
        vul: vulnerability, any spelling :func:`vul_str` accepts.
    """

    hands: Dict[str, Any]
    ctx: str = ""
    dealer: str = "N"
    vul: Any = 0
    played: List[Tuple[str, str]] = field(default_factory=list)

    @classmethod
    def from_deal(cls, deal: str, ctx: str = "", vul: Any = 0,
                  dealer: Any = None) -> "PlayState":
        """Build from a PBN deal ``"N:<N> <E> <S> <W>"``.

        The letter before the colon is the dealer — PBN deals always list the
        hands in compass order, so it is the only thing that rotates. Pass
        ``dealer`` explicitly to override it (useful when the deal string is
        hand-rolled and the prefix is wrong).
        """
        head, _, body = str(deal).partition(":")
        parts = body.split()
        if len(parts) != 4:
            raise ValueError("deal needs 4 hands, got %d: %r" % (len(parts),
                                                                 deal))
        if dealer is None:
            dealer = head.strip() or "N"
        return cls(hands=dict(zip(("N", "E", "S", "W"), parts)),
                   ctx=ctx, dealer=dealer, vul=vul)

    def __post_init__(self) -> None:
        self.hands = {seat_letter(k): hand_pbn(v)
                      for k, v in dict(self.hands).items()}
        self.dealer = seat_letter(self.dealer)

    # ------------------------------------------------------------ basics
    @property
    def contract(self) -> Contract:
        return contract_of(self.ctx, self.dealer)

    @property
    def trump(self) -> Optional[str]:
        return self.contract.trump

    @property
    def declarer(self) -> str:
        return self.contract.declarer

    @property
    def dummy(self) -> str:
        return self.contract.dummy

    @property
    def trick_no(self) -> int:
        """Tricks fully or partly played (1..13)."""
        return len(self.played) // 4 + 1 if self.played else 1

    @property
    def current_trick(self) -> List[Tuple[str, str]]:
        return self.played[-(len(self.played) % 4 or 4):] if self.played else []

    @property
    def complete(self) -> bool:
        return len(self.played) >= 52

    def leader(self) -> str:
        """Seat that plays next."""
        if not self.played:
            return self.contract.lho
        if len(self.played) % 4 == 0:
            return trick_winner(self.played[-4:], self.trump)   # won the trick
        return _letter(_idx(self.played[-1][0]) + 1)

    # ------------------------------------------------------------- cards
    def remaining(self, seat: Any) -> List[str]:
        """Cards the seat still holds, suit-first (``["SK", "S9", ...]``)."""
        seat = seat_letter(seat)
        gone = {c for s, c in self.played if s == seat}
        return [c for c in parse_hand_pbn(self.hands[seat]) if c not in gone]

    def legal(self, seat: Any = None) -> List[str]:
        """Follow-suit-filtered cards for ``seat`` (default: next to play)."""
        seat = seat_letter(seat) if seat is not None else self.leader()
        held = self.remaining(seat)
        trick = self.current_trick
        if not trick:
            return held
        led = _suit(trick[0][1])
        same = [c for c in held if _suit(c) == led]
        return same or held

    def push(self, card: Any, seat: Any = None) -> "PlayState":
        """Record a card. Validates suit-following; returns ``self``."""
        card = card_str(card)
        seat = seat_letter(seat) if seat is not None else self.leader()
        if card not in self.remaining(seat):
            raise ValueError("%s does not hold %s" % (seat, card))
        if len(self.played) % 4 and self.current_trick:
            led = _suit(self.current_trick[0][1])
            if _suit(card) != led and any(_suit(c) == led
                                          for c in self.remaining(seat)):
                raise ValueError("%s must follow suit (%s), cannot play %s"
                                 % (seat, led, card))
        self.played.append((seat, card))
        return self

    # ------------------------------------------------------------ scoring
    def tricks(self) -> Tuple[int, int]:
        """``(NS tricks, EW tricks)`` over completed tricks."""
        ns = ew = 0
        for i in range(0, len(self.played) - len(self.played) % 4, 4):
            w = trick_winner(self.played[i:i + 4], self.trump)
            if _idx(w) % 2 == 0:
                ns += 1
            else:
                ew += 1
        return ns, ew

    def result(self) -> Optional[int]:
        """Tricks made by declarer minus ``level + 6``; ``None`` if unfinished.

        Negative is down, zero is made, positive is overtricks.
        """
        if not self.complete or self.contract.passed_out:
            return None
        ns, ew = self.tricks()
        made = ns if self.contract.declarer_side == "NS" else ew
        return made - (self.contract.level + 6)

    # ----------------------------------------------------------- Brill I/O
    def played_str(self) -> str:
        """The ``played`` query value for the next call."""
        return played_str([c for _, c in self.played])

    def play_params(self, seat: Any = None) -> Dict[str, Any]:
        """Everything ``GET /play`` needs for the current position."""
        seat = seat_letter(seat) if seat is not None else self.leader()
        return {
            "hand": self.hands[seat],
            "dummy": self.hands.get(self.dummy, ""),
            "played": self.played_str(),
            "ctx": self.ctx,
            "seat": seat,
            "dealer": self.dealer,
            "vul": self.vul,
            "deal": deal_pbn(self.hands, self.dealer),
            "north": self.hands.get("N", ""),
            "east": self.hands.get("E", ""),
            "south": self.hands.get("S", ""),
            "west": self.hands.get("W", ""),
        }

    def lead_params(self) -> Dict[str, Any]:
        """Everything ``GET /lead`` needs for the opening lead."""
        p = self.play_params()
        p.pop("played", None)
        p.pop("dummy", None)
        p.pop("deal", None)
        return p

    def ask(self, client: Any, seat: Any = None, **kw: Any) -> Any:
        """Ask Brill for the next card (``/lead`` for card 0, else ``/play``).

        Returns the client's result object; ``.card`` is the two-character
        card string. The returned card is **not** pushed — callers decide.
        """
        if not self.played:
            p = self.lead_params()
            p.update(kw)
            return client.lead(**p)
        p = self.play_params(seat)
        p.update(kw)
        return client.play(**p)

    def play_out(self, client: Any, limit: int = 52, **kw: Any) -> "PlayState":
        """Let Brill play every remaining card. Returns ``self``."""
        n = 0
        while not self.complete and n < limit:
            res = self.ask(client, **kw)
            card = getattr(res, "card", None) or (res or {}).get("card")
            if not card:
                raise RuntimeError("Brill returned no card at trick %d: %r"
                                   % (self.trick_no, res))
            self.push(card)
            n += 1
        return self

    def pbn(self) -> str:
        """The deal as a PBN string, for logging."""
        return deal_pbn(self.hands, self.dealer)

    def __str__(self) -> str:
        return "<PlayState %s | %s | trick %d, %d played, on lead %s>" % (
            self.contract, self.pbn()[:24] + "...",
            self.trick_no, len(self.played), self.leader())
