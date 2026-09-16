"""Tests for `research/brill_harvest.py`.

Only `auction_to_traces` is covered: it is the one piece of new logic in
the bulk harvester, and its failure modes are silent. A wrong seat, a
wrong `ctx`, or a `P` left where `PASS` belongs produces a trace file that
looks entirely plausible and trains a model on positions Brill never
actually faced.
"""
import os
import sys

import pytest

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, os.path.join(REPO, "research"))

from bid.models import Card, Hand, Rank, Seat, Suit                 # noqa: E402
from brill_harvest import auction_to_traces                          # noqa: E402


class _Expl:
    def __init__(self, bid, player, means="", requires=""):
        self.bid = bid
        self.player = player
        self.means = means
        self.requires = requires


_BY_CHAR = {str(r): r for r in Rank}


def _hand(spec):
    return Hand([Card(s, _BY_CHAR[c])
                 for s, cards in zip((Suit.SPADES, Suit.HEARTS,
                                      Suit.DIAMONDS, Suit.CLUBS),
                                     spec.split("."))
                 for c in cards])


HANDS = {Seat.NORTH: _hand("AKQJ.AKQ.AK.AKQ"),
         Seat.EAST: _hand("T987.T98.T9.T98"),
         Seat.SOUTH: _hand("6543.765.8765.76"),
         Seat.WEST: _hand("2.432.QJ432.J543")}


def test_seats_rotate_from_the_dealer():
    tr = auction_to_traces("N:x", "N", 0, HANDS, "1C-P-1H",
                           [_Expl("1C", "N"), _Expl("P", "E"),
                            _Expl("1H", "S")])
    assert [t["seat"] for t in tr] == ["N", "E", "S"]
    assert [t["call"] for t in tr] == ["1C", "PASS", "1H"]


def test_ctx_is_the_prefix_joined_with_dashes():
    tr = auction_to_traces("N:x", "N", 0, HANDS, "1C-P-1H",
                           [_Expl("1C", "N"), _Expl("P", "E"),
                            _Expl("1H", "S")])
    assert [t["ctx"] for t in tr] == ["", "1C", "1C-P"]


def test_pass_is_spelled_out_not_abbreviated():
    """The distiller's `parse_call` expects PASS, not Brill's `P`."""
    tr = auction_to_traces("N:x", "N", 0, HANDS, "P-P",
                           [_Expl("P", "N"), _Expl("P", "E")])
    assert [t["call"] for t in tr] == ["PASS", "PASS"]


def test_hand_matches_the_seat_not_a_fixed_one():
    tr = auction_to_traces("N:x", "N", 0, HANDS, "1C-P",
                           [_Expl("1C", "N"), _Expl("P", "E")])
    assert tr[0]["hand"] != tr[1]["hand"]
    assert tr[1]["hand"] == "T987.T98.T9.T98"


def test_vulnerability_is_recorded_as_an_int():
    tr = auction_to_traces("N:x", "N", 2, HANDS, "1C", [_Expl("1C", "N")])
    assert tr[0]["vul"] == 2


def test_seat_falls_back_to_rotation_when_explanations_are_missing():
    """Short explanation lists must not silently drop or mis-seat calls."""
    tr = auction_to_traces("N:x", "N", 0, HANDS, "1C-P-1H-P", [])
    assert [t["seat"] for t in tr] == ["N", "E", "S", "W"]
    assert [t["ctx"] for t in tr] == ["", "1C", "1C-P", "1C-P-1H"]


def test_empty_auction_yields_no_traces():
    assert auction_to_traces("N:x", "N", 0, HANDS, "", []) == []
