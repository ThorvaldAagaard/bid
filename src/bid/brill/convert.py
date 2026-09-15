"""Conversions between this repo's types and Brill's wire formats.

Brill takes everything as strings on the query string, and three of those
formats are easy to get silently wrong:

* **PBN hands** carry no suit letters — ``AKQJ.AKQ.AK.AKQJ`` is spades,
  hearts, diamonds, clubs, ranks descending.
* **PBN deals** are ``"<dealer>:<N> <E> <S> <W>"`` — hands are always in
  compass order, *not* starting from the dealer. Verified against ``/dd``:
  a deal whose North holds ``AKQJ.AKQ.AKQ.AKQ`` returns ``NT: N 13``.
* **Vulnerability** is spelled ``None | NS | EW | All``. ``Both`` is accepted
  and echoed back as ``All``; anything else is an HTTP 400.

Everything here accepts either a repo object or its plain string/number
equivalent, so callers can use whichever they have to hand.
"""
from __future__ import annotations

from typing import Any, Dict, Iterable, List, Optional, Sequence

from bid.models import Call, CallType, Hand, Rank, Seat, Strain, Suit

__all__ = [
    "SEAT_LETTERS", "hand_pbn", "deal_pbn", "auction_ctx", "parse_ctx",
    "call_str", "seat_letter", "seat_from_letter", "vul_str", "vul_from_str",
    "strain_letter", "SEAT_ORDER",
    "card_str", "parse_card", "played_str", "parse_played", "parse_hand_pbn",
    "hand_from_pbn", "STRAIN_LETTERS",
]

# Compass order. Deal strings always use this order; only the letter before
# the colon changes with the dealer.
SEAT_ORDER = (Seat.NORTH, Seat.EAST, Seat.SOUTH, Seat.WEST)
SEAT_LETTERS = {Seat.NORTH: "N", Seat.EAST: "E",
                Seat.SOUTH: "S", Seat.WEST: "W"}
_LETTER_SEAT = {v: k for k, v in SEAT_LETTERS.items()}

_VUL_OUT = {0: "None", 1: "NS", 2: "EW", 3: "All"}
_VUL_IN = {"none": 0, "ns": 1, "ew": 2,
           "both": 3, "all": 3, "n-s": 1, "e-w": 2}

_RANK_ORDER = "AKQJT98765432"


def _rank_key(card):
    return card.rank.value


# ------------------------------------------------------------------- hands
def hand_pbn(hand: Any) -> str:
    """``Hand`` -> PBN ``"S.H.D.C"``. Also accepts a PBN string (no-op)."""
    if isinstance(hand, str):
        return hand
    cards = getattr(hand, "cards", None)
    if cards is None:
        raise TypeError("hand_pbn needs a Hand or a PBN string, got %r"
                        % type(hand).__name__)
    out = []
    for suit in (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS):
        rs = sorted((c.rank for c in cards if c.suit == suit),
                    key=lambda r: r.value, reverse=True)
        out.append("".join(str(r) for r in rs))
    return ".".join(out)


def hand_from_pbn(pbn: str) -> Any:
    """Inverse of :func:`hand_pbn`: ``"K97.JT84.72.KJ42"`` -> ``Hand``.

    Needed to feed Brill's answers back into the repo (distillation traces
    carry hands as PBN, but the feature extractor wants a ``Hand``).
    """
    from bid.models import Card
    cards = []
    for suit, chunk in zip((Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS,
                            Suit.CLUBS), str(pbn).strip().split(".")):
        for ch in chunk.strip():
            if ch in ("-", ""):
                continue
            rank = {"A": Rank.ACE, "K": Rank.KING, "Q": Rank.QUEEN,
                    "J": Rank.JACK, "T": Rank.TEN}.get(ch.upper())
            if rank is None:
                rank = Rank(int(ch))
            cards.append(Card(suit, rank))
    if len(cards) != 13:
        raise ValueError("hand_from_pbn needs 13 cards, got %d: %r"
                         % (len(cards), pbn))
    return Hand(cards)


def deal_pbn(hands: Dict[Any, Any], dealer: Any = Seat.NORTH) -> str:
    """``{Seat: Hand}`` + dealer -> PBN deal ``"N:... ... ... ..."``.

    Hands are emitted in N-E-S-W order whatever the dealer is. ``hands`` may
    be keyed by ``Seat`` or by letter.
    """
    norm: Dict[Seat, Any] = {}
    for k, v in hands.items():
        seat = k if isinstance(k, Seat) else seat_from_letter(k)
        norm[seat] = v
    missing = [s for s in SEAT_ORDER if s not in norm]
    if missing:
        raise ValueError("deal_pbn missing hands for %s"
                         % ", ".join(SEAT_LETTERS[s] for s in missing))
    dealer_seat = dealer if isinstance(dealer, Seat) else seat_from_letter(dealer)
    body = " ".join(hand_pbn(norm[s]) for s in SEAT_ORDER)
    return "%s:%s" % (SEAT_LETTERS[dealer_seat], body)


# ----------------------------------------------------------------- auction
def call_str(call: Any) -> str:
    """``Call`` -> ``"1H"`` / ``"P"`` / ``"X"`` / ``"XX"``."""
    if isinstance(call, str):
        return call
    t = call.type
    if t == CallType.PASS:
        return "P"
    if t == CallType.DOUBLE:
        return "X"
    if t == CallType.REDOUBLE:
        return "XX"
    return "%d%s" % (call.level, str(call.strain))


def auction_ctx(calls: Optional[Sequence[Any]]) -> str:
    """``[Call, ...]`` -> ``"1C-P-1H"``. Empty/None -> ``""``."""
    if not calls:
        return ""
    return "-".join(call_str(c) for c in calls)


def parse_ctx(ctx: Any) -> List[Call]:
    """``"1C-P-1H"`` -> ``[Call, ...]``. Inverse of :func:`auction_ctx`."""
    if not ctx:
        return []
    if isinstance(ctx, (list, tuple)):
        return [c if isinstance(c, Call) else parse_call(c) for c in ctx]
    out = []
    for tok in str(ctx).replace("PASS", "P").split("-"):
        tok = tok.strip().rstrip("*")
        if tok:
            out.append(parse_call(tok))
    return out


def parse_call(tok: str) -> Call:
    """One Brill call token -> ``Call``."""
    s = str(tok).strip().upper().rstrip("*")
    if s in ("P", "PASS", "PA", "-"):
        return Call(CallType.PASS)
    if s in ("X", "DBL", "DOUBLE"):
        return Call(CallType.DOUBLE)
    if s in ("XX", "RDBL", "REDOUBLE"):
        return Call(CallType.REDOUBLE)
    s = s.replace("NT", "N")
    level = int(s[0])
    strain = {"C": Strain.CLUBS, "D": Strain.DIAMONDS, "H": Strain.HEARTS,
              "S": Strain.SPADES, "N": Strain.NT}[s[1]]
    return Call(CallType.BID, level, strain)


# ---------------------------------------------------------------- seats/vul
def seat_letter(seat: Any) -> str:
    """``Seat.NORTH`` or ``"north"`` or ``0`` -> ``"N"``."""
    if isinstance(seat, Seat):
        return SEAT_LETTERS[seat]
    if isinstance(seat, int):
        return SEAT_LETTERS[Seat(seat)]
    s = str(seat).strip().upper()
    if s in _LETTER_SEAT:
        return s
    for name, letter in (("NORTH", "N"), ("EAST", "E"),
                         ("SOUTH", "S"), ("WEST", "W")):
        if s.startswith(name):
            return letter
    raise ValueError("unknown seat %r" % (seat,))


def seat_from_letter(letter: Any) -> Seat:
    """``"N"`` -> ``Seat.NORTH``."""
    if isinstance(letter, Seat):
        return letter
    s = str(letter).strip().upper()
    if s in _LETTER_SEAT:
        return _LETTER_SEAT[s]
    for name, seat in (("NORTH", Seat.NORTH), ("EAST", Seat.EAST),
                       ("SOUTH", Seat.SOUTH), ("WEST", Seat.WEST)):
        if s.startswith(name):
            return seat
    raise ValueError("unknown seat letter %r" % (letter,))


def vul_str(vul: Any) -> str:
    """``Vulnerability.BOTH`` (3) or ``"both"`` -> ``"All"``.

    Brill accepts ``None | NS | EW | All`` (``Both`` is an accepted alias for
    ``All``). An unrecognised value from *us* raises rather than letting the
    service 400 on it.
    """
    try:
        from bid.scoring import Vulnerability
        if vul in (Vulnerability.NONE, Vulnerability.NS,
                   Vulnerability.EW, Vulnerability.BOTH):
            return _VUL_OUT[int(vul)]
    except Exception:                                       # noqa: BLE001
        pass
    if isinstance(vul, bool):
        raise ValueError("vul must not be a bool")
    if isinstance(vul, int):
        if vul in _VUL_OUT:
            return _VUL_OUT[vul]
        raise ValueError("unknown vulnerability code %r" % (vul,))
    s = str(vul).strip()
    if not s:
        return "None"
    key = s.lower()
    if key in _VUL_IN:
        return _VUL_OUT[_VUL_IN[key]]
    raise ValueError("unknown vulnerability %r (use None/NS/EW/All)" % (vul,))


def vul_from_str(s: Any) -> int:
    """``"All"`` -> ``Vulnerability.BOTH`` (3)."""
    key = str(s).strip().lower()
    if key in _VUL_IN:
        return _VUL_IN[key]
    raise ValueError("unknown vulnerability %r" % (s,))


def strain_letter(strain: Any) -> str:
    """``Strain.NT`` -> ``"N"`` (Brill spells notrump "N", not "NT")."""
    if isinstance(strain, Strain):
        return str(strain)
    s = str(strain).strip().upper().replace("NT", "N")
    return s


# ------------------------------------------------------------------- cards
STRAIN_LETTERS = "SHDCN"          # suit letters, plus N for notrump
_SUIT_LETTERS = "SHDC"
_RANK_CHARS = "AKQJT98765432"


def card_str(card: Any) -> str:
    """Normalise a card to Brill's **suit-first** spelling (``"SA"``).

    Accepts a repo :class:`~bid.models.Card` (whose ``repr`` is rank-first,
    ``"AS"``), ``"SA"``, ``"AS"``, ``"s a"`` and ``"10S"``. Raises on
    anything else rather than silently sending garbage to the service.
    """
    if card is None:
        raise ValueError("card is None")
    if not isinstance(card, str):
        suit = getattr(card, "suit", None)
        rank = getattr(card, "rank", None)
        if suit is None or rank is None:
            raise TypeError("card_str needs a Card or a 2-char string, got %r"
                            % type(card).__name__)
        return "%s%s" % (str(suit), str(rank))

    s = card.strip().upper().replace("10", "T").replace(" ", "")
    if len(s) != 2:
        raise ValueError("bad card %r: need 2 characters" % (card,))
    a, b = s[0], s[1]
    if a in _SUIT_LETTERS and b in _RANK_CHARS:
        return a + b                                  # already suit-first
    if b in _SUIT_LETTERS and a in _RANK_CHARS:
        return b + a                                  # rank-first, swap
    raise ValueError("bad card %r: expected e.g. 'SA' or 'AS'" % (card,))


def parse_card(tok: str) -> Any:
    """``"SA"`` -> :class:`~bid.models.Card`. Inverse of :func:`card_str`."""
    s = card_str(tok)
    suit = {"S": Suit.SPADES, "H": Suit.HEARTS,
            "D": Suit.DIAMONDS, "C": Suit.CLUBS}[s[0]]
    rank = {"T": Rank.TEN, "J": Rank.JACK, "Q": Rank.QUEEN,
            "K": Rank.KING, "A": Rank.ACE}.get(s[1]) or Rank(int(s[1]))
    from bid.models import Card
    return Card(suit, rank)


def played_str(cards: Any) -> str:
    """Card sequence -> the ``played`` query value.

    Brill wants **no separator at all** — a flat run of two-character cards:
    ``["S7", "SA"]`` -> ``"S7SA"``. Passing ``"S7,SA"`` is an HTTP 400
    ("has odd length"). Also accepts an already-flat string, which is
    validated and returned normalised.
    """
    if cards is None:
        return ""
    if isinstance(cards, str):
        flat = cards.strip().upper().replace(",", "").replace(" ", "")
        flat = flat.replace("10", "T")
        if len(flat) % 2:
            raise ValueError("bad played string %r: odd length" % (cards,))
        return "".join(card_str(flat[i:i + 2]) for i in range(0, len(flat), 2))
    return "".join(card_str(c) for c in cards)


def parse_played(s: Any) -> List[str]:
    """``"S7SA"`` -> ``["S7", "SA"]``. Inverse of :func:`played_str`."""
    flat = played_str(s)
    return [flat[i:i + 2] for i in range(0, len(flat), 2)]


def parse_hand_pbn(hand: Any) -> List[str]:
    """PBN ``"K97.JT84.72.KJ42"`` -> ``["SK","S9",...,"C2"]`` (suit-first)."""
    out: List[str] = []
    for suit, chunk in zip((Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS,
                            Suit.CLUBS), str(hand).split(".")):
        for ch in chunk:
            if ch == "-" or ch.isspace():
                continue
            out.append("%s%s" % (suit, ch.upper()))
    return out
