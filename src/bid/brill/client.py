"""HTTP client for the Brill bidding service.

    from bid.brill import BrillClient
    c = BrillClient()
    print(c.version().version)          # 0.1.0+20260913.1018.g5039e2b-dirty
    print(c.bid("AKQ2.J54.T98.762", ctx="1H-P", seat="S").bid)

DESIGN NOTES
------------
* **stdlib only.** ``urllib`` — this project ships with torch/numpy and
  nothing else, and a connector should not drag in ``requests``.
* **Offline-testable.** ``transport=`` takes any callable
  ``(method, url, body) -> (status, text)``. Tests inject a fake and never
  touch the network.
* **Cacheable.** ``cache_path=`` gives a persistent JSON cache keyed by
  request. Brill's rule set changes between builds, so pair it with
  :meth:`version` (whose ``version`` string is the right invalidation key).
* **Typed results, no silent loss.** Undocumented JSON keys stay on ``.raw``.

The live surface is 25 paths; all of them are covered here.
"""
from __future__ import annotations

import json
import os
import time
import urllib.error
import urllib.parse
import urllib.request
from typing import Any, Callable, Dict, List, Optional, Sequence, Union

from bid.models import Seat
from .convert import (auction_ctx, deal_pbn, hand_pbn, played_str,
                      seat_from_letter, seat_letter, vul_str)
from .models import (AutobidResult, AvailableBid, BidResult, BrillBadRequest,
                     BrillUnavailable, DDTable, Explanation, JobStatus,
                     PlayResult, Response, VersionInfo)

__all__ = ["BrillClient", "DEFAULT_BASE_URL", "normalize_call"]

DEFAULT_BASE_URL = "https://brillservice.aalborgdata.dk"
_UA = "bid-connector/0.1 (+https://github.com/)"


def normalize_call(call: Any) -> str:
    """Normalise a call to Brill's spelling so the two sides compare.

    ``"1NT" -> "1N"``, ``"Pass" -> "P"``, ``"Dbl" -> "X"``, ``"XX" -> "XX"``.
    """
    s = str(call).strip().upper().rstrip("*")
    if s in ("PASS", "P", "PA", "PASSOUT"):
        return "P"
    if s in ("X", "DBL", "DOUBLE"):
        return "X"
    if s in ("XX", "RDBL", "REDOUBLE"):
        return "XX"
    return s.replace("NT", "N")


# Bools that are the service default when absent. Dropping them instead of
# sending `false` keeps URLs short and cache keys stable.
_DROP_FALSE = frozenset({"details", "verbose", "nosave", "constraints",
                         "external", "suitc", "carding", "strategyFusion",
                         "weightedSamples", "hcpWeighting", "nnOpeningLead",
                         "nnBidInfo", "diagDealOrder"})


def _qs(params: Dict[str, Any]) -> str:
    """urlencode, dropping None and rendering bools as true/false."""
    clean = []
    for k, v in params.items():
        if v is None:
            continue
        if v is False and k in _DROP_FALSE:
            continue
        if isinstance(v, bool):
            v = "true" if v else "false"
        clean.append((k, v))
    return urllib.parse.urlencode(clean)


def _auction_len(x: Any) -> int:
    """Length of an auction given as a list of Calls or a ctx string."""
    if x is None:
        return 0
    if isinstance(x, str):
        return len([t for t in x.split("-") if t.strip()])
    return len(list(x))


class BrillClient:
    """Thin, typed, cacheable client for Brill.

    Args:
        base_url: service root.
        timeout: per-request socket timeout, seconds.
        retries: attempts on transport failure / 5xx.
        backoff: base seconds for exponential backoff between attempts.
        cache_path: optional JSON file used as a persistent response cache.
        transport: optional ``(method, url, body) -> (status, text)`` callable
            that replaces the network entirely (used by the tests).
    """

    def __init__(self,
                 base_url: str = DEFAULT_BASE_URL,
                 timeout: float = 30.0,
                 retries: int = 3,
                 backoff: float = 0.5,
                 user_agent: str = _UA,
                 cache_path: Optional[str] = None,
                 transport: Optional[Callable[[str, str, Optional[bytes]],
                                              Any]] = None):
        self.base_url = base_url.rstrip("/")
        self.timeout = timeout
        self.retries = max(1, int(retries))
        self.backoff = backoff
        self.user_agent = user_agent
        self.cache_path = cache_path
        self._transport = transport
        self._cache: Dict[str, Any] = {}
        self.cache_hits = 0
        self.cache_misses = 0
        if cache_path and os.path.exists(cache_path):
            try:
                with open(cache_path) as fh:
                    self._cache = json.load(fh)
            except Exception:                                # noqa: BLE001
                self._cache = {}

    # ------------------------------------------------------------- transport
    def _urlopen(self, method: str, url: str, body: Optional[bytes]) -> Any:
        req = urllib.request.Request(url, data=body, method=method)
        req.add_header("User-Agent", self.user_agent)
        if body is not None:
            req.add_header("Content-Type", "application/json")
        with urllib.request.urlopen(req, timeout=self.timeout) as r:
            return r.status, r.read().decode("utf-8", "replace")

    def _request(self, method: str, path: str,
                 params: Optional[Dict[str, Any]] = None,
                 body: Any = None) -> Any:
        # Empty strings are dropped too: no endpoint here treats `ctx=` as
        # different from omitting it, and `/play` 400s on `played=`.
        params = {k: v for k, v in (params or {}).items()
                  if v is not None and v != ""}
        url = self.base_url + path
        if params:
            url += "?" + _qs(params)

        raw_body: Optional[bytes] = None
        if body is not None:
            raw_body = (body if isinstance(body, (bytes, str))
                        else json.dumps(body)).encode("utf-8")
            cache_key = "%s %s %s" % (method, url, raw_body.decode("utf-8"))
        else:
            cache_key = "%s %s" % (method, url)

        if cache_key in self._cache:
            self.cache_hits += 1
            return self._cache[cache_key]
        self.cache_misses += 1

        last: Optional[Exception] = None
        for attempt in range(self.retries):
            try:
                if self._transport is not None:
                    status, text = self._transport(method, url, raw_body)
                else:
                    status, text = self._urlopen(method, url, raw_body)
                if 400 <= status < 500:
                    raise BrillBadRequest(status, text, url)
                if status >= 500:
                    raise BrillUnavailable("HTTP %s from %s" % (status, url))
                parsed = json.loads(text) if text else None
                self._cache[cache_key] = parsed
                return parsed
            except BrillBadRequest:
                raise
            except Exception as exc:                         # noqa: BLE001
                last = exc
                if attempt + 1 < self.retries:
                    time.sleep(self.backoff * (2 ** attempt))
        raise BrillUnavailable("%s %s failed after %d attempts: %s"
                               % (method, url, self.retries, last))

    def flush_cache(self) -> None:
        """Persist the in-memory cache to ``cache_path`` (if set)."""
        if not self.cache_path:
            return
        tmp = self.cache_path + ".tmp"
        with open(tmp, "w") as fh:
            json.dump(self._cache, fh)
        os.replace(tmp, self.cache_path)

    # ------------------------------------------------------------- plumbing
    def version(self) -> VersionInfo:
        return VersionInfo.from_json(self._request("GET", "/version") or {})

    def systems(self, conventions: bool = False) -> List[str]:
        p = {"conventions": True} if conventions else None
        return self._request("GET", "/systems", p) or []

    def health(self) -> Dict[str, Any]:
        return self._request("GET", "/health") or {}

    def ready(self) -> Dict[str, Any]:
        return self._request("GET", "/ready") or {}

    # ----------------------------------------------------------------- bids
    def bid(self, hand: Any, ctx: Any = None, seat: Any = None,
            dealer: Any = "N", vul: Any = 0, details: bool = False,
            board: Any = None, meanings: Any = None,
            ns_system: Any = None, ew_system: Any = None) -> BidResult:
        """``GET /bid`` — the call Brill makes for one hand in an auction.

        ``hand`` may be a ``Hand`` or a PBN string; ``ctx`` may be a list of
        ``Call`` or an auction string; ``seat``/``dealer`` a ``Seat`` or a
        letter; ``vul`` a ``Vulnerability`` code or a name.
        """
        return BidResult.from_json(self._request("GET", "/bid", {
            "hand": hand_pbn(hand),
            "ctx": auction_ctx(ctx) if not isinstance(ctx, str) else ctx,
            "seat": seat_letter(seat) if seat is not None else None,
            "dealer": seat_letter(dealer) if dealer is not None else None,
            "vul": vul_str(vul),
            "details": details,
            "board": board,
            "meanings": meanings,
            "nsSystem": ns_system,
            "ewSystem": ew_system,
        }) or {})

    def bid_for_hand(self, hand: Any, history: Optional[Sequence[Any]] = None,
                     my_seat: Any = None, dealer: Any = "N",
                     vul: Any = 0, **kw) -> BidResult:
        """Convenience: bid a repo ``Hand`` sitting at ``my_seat``.

        ``my_seat`` defaults to the seat on lead after ``history`` assuming
        ``dealer`` opened — which is what Brill's ``ctx`` implies.
        """
        calls = auction_ctx(history)
        if my_seat is None:
            dealer_seat = (dealer if isinstance(dealer, Seat)
                           else seat_from_letter(dealer))
            my_seat = Seat((dealer_seat.value + _auction_len(history)) % 4)
        return self.bid(hand, ctx=calls, seat=my_seat, dealer=dealer,
                        vul=vul, **kw)

    def bids(self, ctx: Any = None) -> List[AvailableBid]:
        """``GET /bids`` — legal/available calls in an auction."""
        p = {"ctx": auction_ctx(ctx) if not isinstance(ctx, str) else ctx}
        return [AvailableBid.from_json(d)
                for d in (self._request("GET", "/bids", p) or [])
                if isinstance(d, dict)]

    def bid_old(self, hand: Any, auction: Any = None, dealer: Any = "N",
                vul: Any = 0) -> Any:
        """``GET /bidold`` — original parameter style."""
        return self._request("GET", "/bidold", {
            "hand": hand_pbn(hand),
            "auction": auction_ctx(auction) if not isinstance(auction, str)
                       else auction,
            "dealer": seat_letter(dealer) if dealer is not None else None,
            "vul": vul_str(vul),
        })

    # ------------------------------------------------------------- responses
    def get_responses(self, auction: Any = None,
                      system: Any = None) -> List[Response]:
        """``GET /getresponses`` — rules Brill *authors* at this position."""
        p = {"auction": auction_ctx(auction) if not isinstance(auction, str)
                        else auction,
             "system": system}
        return [Response.from_json(d)
                for d in (self._request("GET", "/getresponses", p) or [])
                if isinstance(d, dict)]

    def infer_responses(self, bids: Any, auction: Any = None,
                        system: Any = None, dealer: Any = "N",
                        vul: Any = 0) -> List[Response]:
        """``GET /inferresponses`` — meaning of calls Brill does NOT define."""
        if not isinstance(bids, str):
            bids = ",".join(auction_ctx(bids).split("-")) if bids else ""
        return [Response.from_json(d)
                for d in (self._request("GET", "/inferresponses", {
                    "auction": auction_ctx(auction)
                                if not isinstance(auction, str) else auction,
                    "bids": bids,
                    "system": system,
                    "dealer": seat_letter(dealer) if dealer is not None
                              else None,
                    "vul": vul_str(vul),
                }) or []) if isinstance(d, dict)]

    def explain(self, auction: Any, vul: Any = 0) -> List[Explanation]:
        """``GET /explain`` — a whole auction explained call by call."""
        return [Explanation.from_json(d)
                for d in (self._request("GET", "/explain", {
                    "auction": auction_ctx(auction)
                                if not isinstance(auction, str) else auction,
                    "vul": vul_str(vul),
                }) or []) if isinstance(d, dict)]

    # ---------------------------------------------------------------- deals
    def dd(self, deal: Any) -> DDTable:
        """``GET /dd`` — double-dummy table. ``deal`` is a PBN deal string."""
        return DDTable.from_json(self._request("GET", "/dd", {"deal": deal})
                                 or {})

    def dd_for(self, hands: Dict[Any, Any],
               dealer: Any = "N") -> DDTable:
        """``GET /dd`` from ``{Seat: Hand}``."""
        return self.dd(deal_pbn(hands, dealer))

    def autobid(self, deal: Any, dealer: Any = "N", vul: Any = 0,
                board: Any = None, verbose: bool = False,
                ns_system: Any = None,
                ew_system: Any = None) -> AutobidResult:
        """``GET /autobid`` — bid a whole board with Brill, no play."""
        return AutobidResult.from_json(self._request("GET", "/autobid", {
            "deal": deal,
            "board": board,
            "dealer": seat_letter(dealer) if dealer is not None else None,
            "vul": vul_str(vul),
            "verbose": verbose,
            "nsSystem": ns_system,
            "ewSystem": ew_system,
        }) or {})

    def autobid_hands(self, hands: Dict[Any, Any], dealer: Any = "N",
                      vul: Any = 0, **kw) -> AutobidResult:
        """``GET /autobid`` from ``{Seat: Hand}``."""
        return self.autobid(deal_pbn(hands, dealer), dealer=dealer,
                            vul=vul, **kw)

    def autoplay(self, deal: Any, **kw: Any) -> Dict[str, Any]:
        """``GET /autoplay`` — bid *and* play a complete board (slow)."""
        params: Dict[str, Any] = {"deal": deal}
        params.update(kw)
        return self._request("GET", "/autoplay", params) or {}

    def autoplay_start(self, deal: Any, **kw: Any) -> Dict[str, Any]:
        """``GET /autoplay/start`` — queue a board, return a job id."""
        params: Dict[str, Any] = {"deal": deal}
        params.update(kw)
        return self._request("GET", "/autoplay/start", params) or {}

    def autoplay_status(self, job_id: str) -> JobStatus:
        """``GET /autoplay/status/{jobId}``."""
        path = "/autoplay/status/" + urllib.parse.quote(str(job_id))
        return JobStatus.from_json(self._request("GET", path) or {}, job_id)

    def wait_for_autoplay(self, job_id: str, poll: float = 2.0,
                          limit: int = 60) -> JobStatus:
        """Poll :meth:`autoplay_status` until it reports done."""
        st = self.autoplay_status(job_id)
        n = 0
        while not st.done and n < limit:
            time.sleep(poll)
            st = self.autoplay_status(job_id)
            n += 1
        return st

    def autobid_pbn(self, pbn: Union[str, bytes], **kw: Any) -> Dict[str, Any]:
        """``POST /autobidpbn`` — bid every board of a posted PBN."""
        return self._request("POST", "/autobidpbn", kw, body=pbn) or {}

    # ------------------------------------------------------------ card play
    def lead(self, hand: Any, ctx: Any = None, seat: Any = None,
             dealer: Any = "N", vul: Any = 0, **kw: Any) -> PlayResult:
        """``GET /lead`` — choose an opening lead.

        This is the endpoint for *zero* cards played; :meth:`play` refuses
        that position outright.
        """
        params: Dict[str, Any] = {
            "hand": hand_pbn(hand),
            "ctx": auction_ctx(ctx) if not isinstance(ctx, str) else ctx,
            "seat": seat_letter(seat) if seat is not None else None,
            "dealer": seat_letter(dealer) if dealer is not None else None,
            "vul": vul_str(vul),
        }
        params.update(kw)
        return PlayResult.from_json(self._request("GET", "/lead", params) or {})

    def play(self, hand: Any, played: Any, dummy: Any = None,
             ctx: Any = None, seat: Any = None, dealer: Any = "N",
             vul: Any = 0, **kw: Any) -> PlayResult:
        """``GET /play`` — choose a card in the current trick.

        Three constraints the service enforces and the swagger does not
        document. All three were read off its 400 bodies:

        * ``hand`` is the seat's **original 13 cards** — Brill subtracts
          ``played`` itself. A 12-card remainder is rejected outright.
        * ``played`` is **separator-free**, two characters per card
          (``"S7SA"``). It accepts a list here and flattens it.
        * Card 1 belongs to **declarer's LHO**, and the rest follow the real
          play order — the winner of each trick leads the next one, so the
          sequence is not a repeating N-E-S-W cycle. Brill checks every card
          against the hand it thinks owns that position and names the seat
          in its error, which is handy when debugging.

        With nothing played it answers *"use the /lead endpoint instead"*, so
        :meth:`play` raises locally rather than spending a round trip.

        See :mod:`bid.brill.play` for a :class:`~bid.brill.play.PlayState`
        that maintains ``played`` ordering for you.
        """
        flat = played_str(played)
        if not flat:
            raise ValueError(
                "GET /play needs at least one card in `played`; "
                "for an opening lead use .lead()")
        params: Dict[str, Any] = {
            "hand": hand_pbn(hand),
            "played": flat,
            "dummy": hand_pbn(dummy) if dummy is not None else None,
            "ctx": auction_ctx(ctx) if not isinstance(ctx, str) else ctx,
            "seat": seat_letter(seat) if seat is not None else None,
            "dealer": seat_letter(dealer) if dealer is not None else None,
            "vul": vul_str(vul),
        }
        params.update(kw)
        return PlayResult.from_json(self._request("GET", "/play", params) or {})

    def play_position(self, state: Any, **kw: Any) -> PlayResult:
        """``GET /play`` (or ``/lead``) straight from a :class:`PlayState`.

        Equivalent to ``state.ask(self, **kw)``; provided so the client reads
        as the entry point.
        """
        return state.ask(self, **kw)

    def claim(self, tricks: int, **kw: Any) -> Dict[str, Any]:
        """``GET /claim`` — validate and record a claim."""
        params: Dict[str, Any] = {"tricks": tricks}
        params.update(kw)
        return self._request("GET", "/claim", params) or {}

    # ------------------------------------------------------------- POST bodies
    def evaluate(self, body: Any) -> Dict[str, Any]:
        """``POST /evaluate`` — evaluate one hand in an auction (raw body)."""
        return self._request("POST", "/evaluate", None, body=body) or {}

    def suitc(self, body: Any) -> Dict[str, Any]:
        """``POST /suitc`` — analyse a suit combination."""
        return self._request("POST", "/suitc", None, body=body) or {}

    def suggest_bid(self, body: Any) -> Dict[str, Any]:
        """``POST /suggestbid`` — propose what an undefined call should mean."""
        return self._request("POST", "/suggestbid", None, body=body) or {}

    def report_bid(self, body: Any) -> Dict[str, Any]:
        """``POST /reportbid`` — report an authored rule reading a call wrongly."""
        return self._request("POST", "/reportbid", None, body=body) or {}

    def finalize_pbn(self, ctx: Any, **kw: Any) -> Dict[str, Any]:
        """``GET /pbn/finalize`` — save the finished board."""
        params: Dict[str, Any] = {
            "ctx": auction_ctx(ctx) if not isinstance(ctx, str) else ctx}
        params.update(kw)
        return self._request("GET", "/pbn/finalize", params) or {}

    def finalize_pbn_post(self, body: Any, **kw: Any) -> Dict[str, Any]:
        """``POST /pbn/finalize`` — save the finished board (JSON body)."""
        return self._request("POST", "/pbn/finalize", kw, body=body) or {}
