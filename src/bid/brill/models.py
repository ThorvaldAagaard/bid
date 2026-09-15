"""Typed results and errors for the Brill service connector.

Every field here was read off the live service — the published OpenAPI
document (``/swagger/v1/swagger.json``) declares no response schemas at all
(``/dd`` is typed as ``Void``), so these shapes were recovered by calling the
endpoints. Unknown/undocumented JSON keys are preserved on ``.raw`` rather
than dropped, so a service change shows up as a missing attribute, not as
silent data loss.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional


# --------------------------------------------------------------------- errors
class BrillError(Exception):
    """Base class for every connector failure."""


class BrillUnavailable(BrillError):
    """Transport-level failure after all retries were exhausted."""


class BrillBadRequest(BrillError):
    """The service rejected the request (HTTP 400 / 404 / 422...)."""

    def __init__(self, status: int, body: str, url: str = ""):
        self.status = status
        self.body = body
        self.url = url
        super().__init__("HTTP %s for %s: %s" % (status, url, body[:300]))


class BrillContractError(BrillError):
    """The service answered, but not in a shape we recognise."""


# ------------------------------------------------------------------ utilities
def _get(d: Any, *names, default=None):
    """First present key wins — Brill is inconsistent across endpoints."""
    if not isinstance(d, dict):
        return default
    for n in names:
        if n in d and d[n] is not None:
            return d[n]
    return default


@dataclass
class BidResult:
    """``GET /bid`` — the call Brill's engine makes for one hand."""

    bid: Optional[str] = None
    alert: bool = False
    explanation: str = ""
    requires: str = ""
    means: str = ""
    analysis: List[str] = field(default_factory=list)
    timings: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @property
    def fired_realsolid(self) -> bool:
        """True when the winning rule was a ``realsolid`` slam rule."""
        return "realsolid" in (self.requires or "")

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "BidResult":
        return cls(
            bid=d.get("bid"),
            alert=bool(d.get("alert", False)),
            explanation=d.get("explanation") or "",
            requires=d.get("requires") or "",
            means=d.get("means") or "",
            analysis=list(d.get("analysis") or []),
            timings=d.get("timings") or "",
            raw=d,
        )


@dataclass
class AvailableBid:
    """``GET /bids`` — every call that is legal/available in an auction."""

    bid: str = ""
    description: str = ""
    requires: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "AvailableBid":
        return cls(bid=d.get("bid") or "",
                   description=d.get("description") or "",
                   requires=d.get("requires") or "",
                   raw=d)


@dataclass
class Response:
    """``GET /getresponses`` (authored) and ``/inferresponses`` (inferred).

    The two endpoints return the same shape; ``inferred`` distinguishes them.
    """

    bid: str = ""
    display_bid: str = ""
    means: str = ""
    requires: str = ""
    convention: Optional[str] = None
    post_condition: Optional[str] = None
    artificial: bool = False
    priority: int = 0
    rule: Optional[str] = None
    auction: Optional[str] = None
    inferred: bool = False
    bindings: Dict[str, Any] = field(default_factory=dict)
    raw: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "Response":
        return cls(
            bid=d.get("bid") or "",
            display_bid=d.get("displayBid") or d.get("bid") or "",
            means=d.get("means") or "",
            requires=d.get("requires") or "",
            convention=d.get("convention"),
            post_condition=d.get("postCondition"),
            artificial=bool(d.get("artificial", False)),
            priority=int(d.get("priority") or 0),
            rule=d.get("rule"),
            auction=d.get("auction"),
            inferred=bool(d.get("inferred", False)),
            bindings=dict(d.get("bindings") or {}),
            raw=d,
        )


@dataclass
class Explanation:
    """One entry of ``GET /explain``.

    ``/explain`` buries the useful text two levels down::

        [{"bid": "1C", "player": "N", "explanation": [
            {"explainingRuleSetName": "Opening Bid",
             "rawRuleMeans": "12-21 HCP, 3+ clubs",
             "rawRuleRequires": "...",
             "explainingRuleInstance": {"resolvedMeans": "...", ...}}]}]

    so ``means``/``requires`` are lifted from there.
    """

    bid: str = ""
    player: str = ""
    means: str = ""
    requires: str = ""
    rule_set: str = ""
    priority: Optional[int] = None
    artificial: bool = False
    post_condition: Optional[str] = None
    denies: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "Explanation":
        inner = d.get("explanation")
        first = {}
        if isinstance(inner, list) and inner and isinstance(inner[0], dict):
            first = inner[0]
        elif isinstance(inner, dict):
            first = inner
        inst = first.get("explainingRuleInstance")
        inst = inst if isinstance(inst, dict) else {}

        means = (d.get("means") or first.get("rawRuleMeans")
                 or inst.get("resolvedMeans") or inst.get("originalMeans")
                 or first.get("means") or "")
        requires = (d.get("requires") or first.get("rawRuleRequires")
                    or inst.get("resolvedRequiresString")
                    or inst.get("originalRequires") or "")

        prio = inst.get("priority")
        return cls(
            bid=d.get("bid") or first.get("bidMade") or "",
            player=d.get("player") or "",
            means=means,
            requires=requires,
            rule_set=first.get("explainingRuleSetName") or "",
            priority=int(prio) if isinstance(prio, int) else None,
            artificial=bool(inst.get("artificial", False)),
            post_condition=(inst.get("resolvedPostCondition")
                            or inst.get("originalPostCondition")),
            denies=first.get("denialDescription") or "",
            raw=d,
        )


@dataclass
class VersionInfo:
    """``GET /version`` — also the right cache-invalidation key."""

    version: str = ""
    assembly_version: str = ""
    commit: str = ""
    build_time: str = ""
    system_name: str = ""
    rule_count: int = 0
    timestamp: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "VersionInfo":
        if isinstance(d, str):
            return cls(version=d, raw={"version": d})
        return cls(version=d.get("version") or "",
                   assembly_version=d.get("assemblyVersion") or "",
                   commit=d.get("commit") or "",
                   build_time=d.get("buildTime") or "",
                   system_name=d.get("systemName") or "",
                   rule_count=int(d.get("ruleCount") or 0),
                   timestamp=d.get("timestamp") or "",
                   raw=d)


@dataclass
class DDTable:
    """``GET /dd`` — double-dummy tricks, per strain per declarer.

    Shape on the wire is ``{strain: {seat: tricks}}`` with strain keys in
    "N","S","H","D","C" (NT is spelled "N").
    """

    by_strain: Dict[str, Dict[str, int]] = field(default_factory=dict)
    deal: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "DDTable":
        table = d.get("dd") if isinstance(d, dict) else None
        if table is None:
            table = d if isinstance(d, dict) else {}
        return cls(by_strain={k: dict(v) for k, v in table.items()
                              if isinstance(v, dict)},
                   deal=(d.get("deal") or "") if isinstance(d, dict) else "",
                   raw=d if isinstance(d, dict) else {"dd": d})

    def tricks(self, strain: str, seat: str) -> Optional[int]:
        """Tricks available to ``seat`` (N/E/S/W) declaring ``strain``."""
        row = self.by_strain.get(str(strain).upper())
        return row.get(str(seat).upper()) if row else None

    def best_contract(self) -> Optional[Any]:
        """(strain, seat, tricks) maximising tricks, ties broken low-to-high.

        Needs ``bid.scoring``; imported lazily so the connector stays
        importable without it.
        """
        best = None
        order = ["C", "D", "H", "S", "N"]
        for strain in order:
            row = self.by_strain.get(strain) or {}
            for seat in ("N", "E", "S", "W"):
                t = row.get(seat)
                if t is None:
                    continue
                key = (t, -order.index(strain))
                if best is None or key > best[0]:
                    best = (key, (strain, seat, t))
        return best[1] if best else None


@dataclass
class AutobidResult:
    """``GET /autobid`` — a whole board auctioned by Brill, no play."""

    board_number: Optional[int] = None
    deal: str = ""
    dealer: str = ""
    vulnerability: str = ""
    auction: str = ""
    explanations: List[Explanation] = field(default_factory=list)
    raw: Dict[str, Any] = field(default_factory=dict)

    @property
    def calls(self) -> List[str]:
        """The auction as a list of call tokens (``['1N','P','P','P']``)."""
        return [c for c in (self.auction or "").split("-") if c]

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "AutobidResult":
        ex = d.get("auction_with_explanations") or []
        return cls(
            board_number=d.get("boardNumber"),
            deal=d.get("deal") or "",
            dealer=d.get("dealer") or "",
            vulnerability=d.get("vulnerability") or "",
            auction=d.get("auction") or "",
            explanations=[Explanation.from_json(x) for x in ex
                          if isinstance(x, dict)],
            raw=d,
        )


@dataclass
class PlayResult:
    """``GET /lead`` and ``GET /play`` — one card chosen by Brill.

    Both endpoints answer the same shape::

        {"card": "DQ", "quality": 0.36, "matchpoint": false,
         "player": 1, "who": "BRILL",
         "tieBreakInfo": "[EQUALISE] S: DA -> DQ (touching group)"}

    ``player`` is the position *within the current trick* (1 = the hand that
    led it), not a seat. ``who`` is absent when ``quality`` is 1.0 — Brill
    omits it for double-dummy-exact answers rather than reporting a
    meaningless attribution.
    """

    card: str = ""
    quality: Optional[float] = None
    player: Optional[int] = None
    who: str = ""
    matchpoint: bool = False
    tie_break_info: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @property
    def suit(self) -> str:
        return self.card[:1]

    @property
    def rank(self) -> str:
        return self.card[1:2]

    @classmethod
    def from_json(cls, d: Dict[str, Any]) -> "PlayResult":
        q = d.get("quality")
        p = d.get("player")
        return cls(card=d.get("card") or "",
                   quality=float(q) if isinstance(q, (int, float)) else None,
                   player=int(p) if isinstance(p, (int, float)) else None,
                   who=d.get("who") or "",
                   matchpoint=bool(d.get("matchpoint", False)),
                   tie_break_info=d.get("tieBreakInfo") or "",
                   raw=d)


@dataclass
class JobStatus:
    """``GET /autoplay/status/{jobId}``."""

    job_id: str = ""
    state: str = ""
    raw: Dict[str, Any] = field(default_factory=dict)

    @property
    def done(self) -> bool:
        return str(self.state).lower() in ("done", "completed", "complete",
                                           "finished", "succeeded", "success")

    @classmethod
    def from_json(cls, d: Dict[str, Any], job_id: str = "") -> "JobStatus":
        return cls(job_id=d.get("jobId") or job_id,
                   state=(d.get("state") or d.get("status") or ""),
                   raw=d)
