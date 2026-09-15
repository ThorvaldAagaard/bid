"""Connector for the Brill bidding service (``brillservice.aalborgdata.dk``).

Lets the local engine talk to a remote Brill: ask it what it would bid, pull
its authored rule table, double-dummy a deal, or auction a whole board.

    from bid.brill import BrillClient
    from bid.models import Hand

    c = BrillClient(cache_path="/tmp/brill_cache.json")
    r = c.bid(Hand.from_string("SAKQ32 HK32 DA32 C43"), ctx="1H-P", seat="S")
    print(r.bid, "|", r.means)

Everything is stdlib-only and offline-testable — pass ``transport=`` to
replace the network (see :mod:`bid.brill.client`). Response shapes are in
:mod:`bid.brill.models`; repo-type conversions in :mod:`bid.brill.convert`.

The published OpenAPI document declares no response schemas, so the dataclasses
here were recovered by calling the live service. Undocumented keys survive on
``.raw``.
"""
from .client import DEFAULT_BASE_URL, BrillClient, normalize_call
from .convert import (SEAT_LETTERS, SEAT_ORDER, auction_ctx, call_str,
                      card_str, deal_pbn, hand_pbn, parse_call, parse_ctx,
                      played_str, seat_letter, seat_from_letter,
                      strain_letter, vul_from_str, vul_str)
from .models import (AutobidResult, AvailableBid, BidResult, BrillBadRequest,
                     BrillContractError, BrillError, BrillUnavailable,
                     DDTable, Explanation, JobStatus, PlayResult, Response,
                     VersionInfo)
from .play import Contract, PlayState, contract_of, trick_winner

__all__ = [
    "BrillClient", "DEFAULT_BASE_URL", "normalize_call",
    "BidResult", "AvailableBid", "Response", "Explanation", "VersionInfo",
    "DDTable", "AutobidResult", "JobStatus", "PlayResult",
    "BrillError", "BrillUnavailable", "BrillBadRequest", "BrillContractError",
    "PlayState", "Contract", "contract_of", "trick_winner",
    "hand_pbn", "deal_pbn", "auction_ctx", "parse_ctx", "parse_call",
    "call_str", "card_str", "played_str",
    "seat_letter", "seat_from_letter", "vul_str", "vul_from_str",
    "strain_letter", "SEAT_LETTERS", "SEAT_ORDER",
]
