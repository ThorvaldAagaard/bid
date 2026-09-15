"""Offline tests for the Brill connector.

There is **no network here**. Everything goes through ``BrillClient(transport=)``
with a fake that records the URLs it was handed and replies with canned
bodies, so the suite is fast, deterministic and safe to run in CI.

The endpoint contracts locked in below (``played`` having no separator,
``hand`` needing all 13 cards, card 1 belonging to declarer's LHO) were
recovered from the live service's 400 bodies — see
:mod:`bid.brill.play` for the write-up.
"""
import json
import os
import unittest
import urllib.parse

from bid.brill import (BrillClient, PlayState, contract_of, card_str,
                       played_str, trick_winner)
from bid.brill.client import normalize_call
from bid.brill.convert import (deal_pbn, hand_from_pbn, hand_pbn, parse_ctx,
                               parse_played, parse_hand_pbn, seat_letter,
                               vul_str)
from bid.brill.models import (BidResult, BrillBadRequest, BrillUnavailable,
                              DDTable, Explanation, PlayResult)
from bid.models import Call, CallType, Hand, Seat, Strain


# --------------------------------------------------------------------- fakes
class FakeTransport:
    """Records requests, replays canned replies keyed by path prefix."""

    def __init__(self, replies=None, status=200):
        self.replies = replies or {}
        self.status = status
        self.calls = []

    def __call__(self, method, url, body):
        self.calls.append((method, url, body))
        path = urllib.parse.urlsplit(url).path
        for prefix, reply in self.replies.items():
            if path.endswith(prefix):
                if isinstance(reply, Exception):
                    raise reply
                if callable(reply):
                    reply = reply(url)
                text = reply if isinstance(reply, str) else json.dumps(reply)
                return self.status, text
        return 200, "{}"

    @property
    def urls(self):
        return [u for _, u, _ in self.calls]

    def query(self, path="/play"):
        """Parsed query dict of the last request to ``path``."""
        for _, u, _ in reversed(self.calls):
            if urllib.parse.urlsplit(u).path.endswith(path):
                return dict(urllib.parse.parse_qsl(urllib.parse.urlsplit(u).query))
        raise AssertionError("no call to %s" % path)


def client(replies=None, **kw):
    t = FakeTransport(replies)
    c = BrillClient(transport=t, **kw)
    c.transport = t
    return c


DEAL_HANDS = {
    "N": "QT8.AKQ7.JT9.AT9",
    "E": "K97.JT84.72.KJ42",
    "S": "A2.965.AKQ854.83",
    "W": "J6543.32.63.Q765",
}


# --------------------------------------------------------------- conversions
class TestConvert(unittest.TestCase):

    def test_hand_pbn_is_suit_ordered_no_letters(self):
        self.assertEqual(hand_pbn(Hand.from_string("SAKQ32 HK32 DA32 C43")),
                         "AKQ32.K32.A32.43")

    def test_deal_pbn_is_always_compass_order(self):
        # East deals, but the hands still come out N-E-S-W.
        self.assertEqual(deal_pbn(DEAL_HANDS, "E"),
                         "E:%s" % " ".join(DEAL_HANDS[s] for s in "NESW"))

    def test_card_str_accepts_both_spellings(self):
        self.assertEqual(card_str("SA"), "SA")      # suit-first
        self.assertEqual(card_str("AS"), "SA")      # rank-first
        self.assertEqual(card_str("as"), "SA")
        self.assertEqual(card_str("10S"), "ST")     # ten, rank-first
        self.assertEqual(card_str("S10"), "ST")     # ten, suit-first

    def test_card_str_from_repo_card(self):
        from bid.models import Card, Rank, Suit
        self.assertEqual(card_str(Card(Suit.HEARTS, Rank.ACE)), "HA")

    def test_card_str_rejects_nonsense(self):
        for bad in ("X", "QQ", "S1", "SAX", ""):
            with self.assertRaises(ValueError):
                card_str(bad)

    def test_parse_ctx_roundtrip(self):
        calls = parse_ctx("1C-P-1H-X-XX-P")
        self.assertEqual([c.type for c in calls],
                         [CallType.BID, CallType.PASS, CallType.BID,
                          CallType.DOUBLE, CallType.REDOUBLE, CallType.PASS])
        self.assertEqual(calls[0].level, 1)
        self.assertEqual(calls[0].strain, Strain.CLUBS)

    def test_vul_spellings(self):
        self.assertEqual(vul_str(0), "None")
        self.assertEqual(vul_str(3), "All")
        self.assertEqual(vul_str("both"), "All")
        with self.assertRaises(ValueError):
            vul_str("nonsense")

    def test_hand_from_pbn_roundtrips(self):
        h = Hand.from_string("SAKQ32 HK32 DA32 C43")
        pbn = hand_pbn(h)
        self.assertEqual(pbn, "AKQ32.K32.A32.43")
        back = hand_from_pbn(pbn)
        self.assertEqual(len(back.cards), 13)
        self.assertEqual(hand_pbn(back), pbn)   # exact same 13 cards

    def test_hand_from_pbn_handles_ten(self):
        # 'T' must parse as the ten, and survive the round trip (13 cards:
        # 5 spades + 4 hearts + 3 diamonds + 1 club).
        h = hand_from_pbn("AKQJT.AKQJ.AKQ.A")
        self.assertEqual(len(h.cards), 13)
        self.assertEqual(hand_pbn(h), "AKQJT.AKQJ.AKQ.A")

    def test_hand_from_pbn_rejects_a_short_hand(self):
        with self.assertRaises(ValueError):
            hand_from_pbn("K97.JT84.72.KJ4")     # 12 cards

    def test_parse_hand_pbn(self):
        self.assertEqual(parse_hand_pbn("K97.JT84.72.KJ42"),
                         ["SK", "S9", "S7", "HJ", "HT", "H8", "H4",
                          "D7", "D2", "CK", "CJ", "C4", "C2"])


# ----------------------------------------------------------- played encoding
class TestPlayedEncoding(unittest.TestCase):

    def test_list_joins_with_no_separator(self):
        self.assertEqual(played_str(["S7", "SA"]), "S7SA")
        self.assertEqual(played_str([]), "")

    def test_repo_cards_are_suit_first(self):
        from bid.models import Card, Rank, Suit
        cards = [Card(Suit.SPADES, Rank.SEVEN), Card(Suit.SPADES, Rank.ACE)]
        self.assertEqual(played_str(cards), "S7SA")

    def test_flat_string_passthrough(self):
        self.assertEqual(played_str("S7SA"), "S7SA")

    def test_comma_string_is_repaired_not_rejected(self):
        # The service rejects commas; we normalise them away.
        self.assertEqual(played_str("S7,SA"), "S7SA")

    def test_odd_length_raises_locally(self):
        with self.assertRaises(ValueError):
            played_str("S7S")

    def test_parse_played_is_inverse(self):
        self.assertEqual(parse_played("S7SAS3SQ"), ["S7", "SA", "S3", "SQ"])


# ------------------------------------------------------------------ contract
class TestContract(unittest.TestCase):

    def test_1n_by_north(self):
        c = contract_of("1N-P-P-P", "N")
        self.assertEqual((c.level, c.strain, c.declarer), (1, "N", "N"))
        self.assertIsNone(c.trump)
        self.assertEqual(c.lho, "E")          # opening leader
        self.assertEqual(c.dummy, "S")

    def test_4s_by_south_with_east_west_silent(self):
        # P-P-1S-P-4S-P-P-P: South opens 1S, North raises to 4S.
        # EW never bid spades but they are not the declaring side; the
        # declarer is the *first of the NS pair* to name spades -> South.
        c = contract_of("P-P-1S-P-4S-P-P-P", "N")
        self.assertEqual((c.level, c.strain, c.declarer), (4, "S", "S"))
        self.assertEqual(c.trump, "S")
        self.assertEqual(c.lho, "W")
        self.assertEqual(c.dummy, "N")
        self.assertEqual(c.declarer_side, "NS")

    def test_declarer_is_first_of_side_to_name_strain(self):
        # N opens 1H, S raises to 4H -> North declares, not South.
        self.assertEqual(contract_of("1H-P-4H-P-P-P", "N").declarer, "N")
        # W opens 1H, E raises -> West declares.
        self.assertEqual(contract_of("1H-P-P-2H-P-P-P", "N").declarer, "W")
        # E opens 1H, W raises -> East declares (E named hearts first).
        self.assertEqual(contract_of("P-1H-P-2H-P-P-P", "N").declarer, "E")

    def test_doubled_and_redoubled(self):
        self.assertEqual(contract_of("4S-X-P-P-P", "N").doubled, 1)
        self.assertEqual(contract_of("4S-XX-P-P-P", "N").doubled, 2)
        self.assertEqual(contract_of("4S-P-P-P", "N").doubled, 0)

    def test_passed_out(self):
        c = contract_of("P-P-P-P", "N")
        self.assertTrue(c.passed_out)
        self.assertEqual(str(c), "Passed out")

    def test_dealer_rotates_the_contract(self):
        # Same auction, different dealer -> different declarer.
        self.assertEqual(contract_of("1N-P-P-P", "N").declarer, "N")
        self.assertEqual(contract_of("1N-P-P-P", "E").declarer, "E")

    def test_str(self):
        self.assertEqual(str(contract_of("4S-X-P-P-P", "N")), "4SX by N")
        self.assertEqual(str(contract_of("4S-XX-P-P-P", "N")), "4SXX by N")


# -------------------------------------------------------------- trick winner
class TestTrickWinner(unittest.TestCase):

    def test_highest_of_led_suit_wins_in_nt(self):
        trick = [("E", "S7"), ("S", "SA"), ("W", "S3"), ("N", "SQ")]
        self.assertEqual(trick_winner(trick, None), "S")

    def test_ruff_beats_the_led_suit(self):
        trick = [("E", "HA"), ("S", "H2"), ("W", "S3"), ("N", "HQ")]
        self.assertEqual(trick_winner(trick, "S"), "W")   # the ruff

    def test_higher_ruff_wins(self):
        trick = [("E", "HA"), ("S", "S5"), ("W", "S3"), ("N", "HQ")]
        self.assertEqual(trick_winner(trick, "S"), "S")

    def test_a_void_hand_ruffing_beats_the_led_ace(self):
        trick = [("E", "SA"), ("S", "S2"), ("W", "H3"), ("N", "S4")]
        self.assertEqual(trick_winner(trick, "H"), "W")

    def test_the_higher_of_two_ruffs_wins(self):
        trick = [("E", "SA"), ("S", "H9"), ("W", "H3"), ("N", "S4")]
        self.assertEqual(trick_winner(trick, "H"), "S")

    def test_partial_trick(self):
        self.assertEqual(trick_winner([("E", "S7"), ("S", "SA")], None), "S")

    def test_empty(self):
        self.assertIsNone(trick_winner([], None))


# ----------------------------------------------------------------- playstate
class TestPlayState(unittest.TestCase):

    def make(self):
        return PlayState(DEAL_HANDS, ctx="1N-P-P-P", dealer="N", vul="None")

    def test_opening_leader_is_declarers_lho(self):
        st = self.make()
        self.assertEqual(st.declarer, "N")
        self.assertEqual(st.leader(), "E")

    def test_rotation_within_a_trick(self):
        st = self.make()
        order = []
        for card in ("S7", "SA", "S3", "SQ"):
            order.append(st.leader())
            st.push(card)
        self.assertEqual(order, list("ESWN"))

    def test_trick_winner_leads_the_next_trick(self):
        # This is the rule the service enforces and swagger omits.
        st = self.make()
        for card in ("S7", "SA", "S3", "SQ"):
            st.push(card)                      # SA wins -> S leads trick 2
        self.assertEqual(st.leader(), "S")
        self.assertEqual(st.played_str(), "S7SAS3SQ")

    def test_leader_after_thirteen_cards(self):
        st = self.make()
        self.assertEqual(st.trick_no, 1)
        st.push("S7")
        self.assertEqual(st.trick_no, 1)
        st.push("SA"); st.push("S3"); st.push("SQ")
        self.assertEqual(st.trick_no, 2)

    def test_played_str_is_flat_and_in_play_order(self):
        st = self.make()
        st.push("S7"); st.push("SA"); st.push("S3"); st.push("SQ")
        st.push("D4")                      # S won trick 1 and leads a diamond
        self.assertEqual(st.played_str(), "S7SAS3SQD4")

    def test_remaining_subtracts_only_that_seats_cards(self):
        st = self.make()
        st.push("S7")
        self.assertNotIn("S7", st.remaining("E"))
        self.assertEqual(len(st.remaining("E")), 12)
        self.assertEqual(len(st.remaining("N")), 13)
        self.assertEqual(len(st.remaining("S")), 13)

    def test_legal_forces_follow_suit(self):
        st = self.make()
        st.push("S7")                      # E led a spade
        legal = st.legal()                 # S to play
        self.assertTrue(legal)
        self.assertTrue(all(c[0] == "S" for c in legal))

    def test_legal_is_whole_hand_when_void(self):
        st = self.make()
        # W is void in clubs? W = J6543.32.63.Q765 -> has clubs. Use hearts.
        st.push("S7"); st.push("SA"); st.push("S3"); st.push("SQ")
        st.push("H9")                      # S won trick 1; S hearts are 965
        self.assertEqual(st.leader(), "W")
        self.assertEqual(st.legal(), ["H3", "H2"])   # W hearts are 32

    def test_push_rejects_a_card_the_seat_does_not_hold(self):
        st = self.make()
        with self.assertRaises(ValueError):
            st.push("SA")                  # it is E's lead; E has no SA

    def test_push_rejects_revoking(self):
        st = self.make()
        st.push("S7")                      # E led a spade, S has spades
        with self.assertRaises(ValueError):
            st.push("D2")

    def test_tricks_and_result(self):
        st = self.make()
        self.assertEqual(st.result(), None)
        self.assertEqual(st.tricks(), (0, 0))

    def test_complete_after_52(self):
        st = self.make()
        self.assertFalse(st.complete)
        st.played = [("N", "SA")] * 52
        self.assertTrue(st.complete)

    def test_play_params_carry_full_hands(self):
        st = self.make()
        st.push("S7")
        p = st.play_params()
        self.assertEqual(p["hand"], DEAL_HANDS["S"])      # all 13, not 12
        self.assertEqual(p["dummy"], DEAL_HANDS["S"])     # dummy of N
        self.assertEqual(p["played"], "S7")
        self.assertEqual(p["seat"], "S")
        self.assertEqual(p["dealer"], "N")
        self.assertTrue(p["deal"].startswith("N:"))
        self.assertEqual(len(parse_hand_pbn(p["hand"])), 13)

    def test_lead_params_drop_played_and_dummy(self):
        st = self.make()
        p = st.lead_params()
        self.assertNotIn("played", p)
        self.assertNotIn("dummy", p)

    def test_from_deal(self):
        st = PlayState.from_deal(deal_pbn(DEAL_HANDS, "N"), ctx="1N-P-P-P")
        self.assertEqual(st.hands["E"], DEAL_HANDS["E"])
        self.assertEqual(st.dealer, "N")


# -------------------------------------------------------------------- models
class TestModels(unittest.TestCase):

    def test_bid_result_keeps_raw(self):
        r = BidResult.from_json({"bid": "1N", "somethingNew": 7})
        self.assertEqual(r.bid, "1N")
        self.assertEqual(r.raw["somethingNew"], 7)

    def test_realsolid_helper(self):
        self.assertTrue(BidResult.from_json(
            {"requires": "realsolid('S') and losers == 1"}).fired_realsolid)
        self.assertFalse(BidResult.from_json({"requires": "hcp >= 15"}
                                             ).fired_realsolid)

    def test_explanation_lifts_nested_text(self):
        d = {"bid": "1C", "player": "N", "explanation": [
            {"explainingRuleSetName": "Opening Bid",
             "rawRuleMeans": "12-21 HCP, 3+ clubs",
             "rawRuleRequires": "hcp between 12 and 21",
             "explainingRuleInstance": {"resolvedMeans": "12-21 HCP"}}]}
        e = Explanation.from_json(d)
        self.assertEqual(e.means, "12-21 HCP, 3+ clubs")
        self.assertEqual(e.requires, "hcp between 12 and 21")
        self.assertEqual(e.rule_set, "Opening Bid")
        self.assertEqual(e.bid, "1C")

    def test_play_result_fields(self):
        p = PlayResult.from_json({"card": "DQ", "quality": 0.36, "player": 1,
                                  "who": "BRILL",
                                  "tieBreakInfo": "[EQUALISE] ..."})
        self.assertEqual((p.card, p.suit, p.rank), ("DQ", "D", "Q"))
        self.assertAlmostEqual(p.quality, 0.36)
        self.assertTrue(p.tie_break_info.startswith("[EQUALISE]"))

    def test_play_result_without_who(self):
        # quality 1.0 answers omit `who` entirely.
        p = PlayResult.from_json({"card": "SA", "quality": 1, "player": 1})
        self.assertEqual(p.who, "")
        self.assertEqual(p.quality, 1.0)

    def test_dd_table(self):
        t = DDTable.from_json({"deal": "N:...", "dd": {"N": {"N": 9, "S": 9},
                                                        "S": {"N": 11}}})
        self.assertEqual(t.tricks("N", "N"), 9)
        self.assertEqual(t.tricks("S", "N"), 11)
        self.assertIsNone(t.tricks("H", "N"))
        self.assertEqual(t.best_contract()[2], 11)


# -------------------------------------------------------------------- client
class TestClientTransport(unittest.TestCase):

    def test_bid_builds_the_expected_url(self):
        c = client({"/bid": {"bid": "1N", "means": "15-17"}})
        r = c.bid("AKQ2.J54.T98.762", ctx="1H-P", seat="S", vul="NS")
        self.assertEqual(r.bid, "1N")
        q = c.transport.query("/bid")
        self.assertEqual(q["hand"], "AKQ2.J54.T98.762")
        self.assertEqual(q["ctx"], "1H-P")
        self.assertEqual(q["seat"], "S")
        self.assertEqual(q["vul"], "NS")
        self.assertNotIn("details", q)          # false bools are dropped

    def test_bid_accepts_a_repo_hand(self):
        c = client({"/bid": {"bid": "P"}})
        c.bid(Hand.from_string("SAKQ32 HK32 DA32 C43"))
        self.assertEqual(c.transport.query("/bid")["hand"], "AKQ32.K32.A32.43")

    def test_seat_defaults_to_the_seat_on_lead(self):
        c = client({"/bid": {"bid": "P"}})
        c.bid_for_hand("AKQ2.J54.T98.762", history="1C-P", dealer="N")
        self.assertEqual(c.transport.query("/bid")["seat"], "S")

    def test_empty_params_are_dropped(self):
        c = client({"/bid": {"bid": "P"}})
        c.bid("AKQ2.J54.T98.762", ctx="")
        self.assertNotIn("ctx", c.transport.query("/bid"))

    def test_play_flattens_played_and_sends_full_hand(self):
        c = client({"/play": {"card": "SQ", "quality": 0.3, "player": 2}})
        st = PlayState(DEAL_HANDS, ctx="1N-P-P-P", dealer="N")
        st.push("S7")
        r = st.ask(c)
        self.assertEqual(r.card, "SQ")
        q = c.transport.query("/play")
        self.assertEqual(q["played"], "S7")     # no separator
        self.assertEqual(q["hand"], DEAL_HANDS["S"])
        self.assertEqual(q["seat"], "S")

    def test_play_refuses_an_empty_played_locally(self):
        c = client({"/play": {"card": "S7"}})
        with self.assertRaises(ValueError):
            c.play(DEAL_HANDS["E"], played="")
        self.assertEqual(c.transport.calls, [])   # no round trip wasted

    def test_lead_is_used_for_card_zero(self):
        c = client({"/lead": {"card": "D5", "quality": 0.0}})
        st = PlayState(DEAL_HANDS, ctx="1N-P-P-P", dealer="N")
        r = st.ask(c)
        self.assertEqual(r.card, "D5")
        self.assertEqual(c.transport.urls[0].split("?")[0].split("/")[-1],
                         "lead")

    def test_play_out_drives_a_whole_board_on_a_fake(self):
        # Alternating canned cards; just checks the loop and bookkeeping.
        cards = ["S7", "SA", "S3", "SQ"]
        box = {"i": 0}

        def reply(url):
            card = cards[box["i"] % len(cards)]
            box["i"] += 1
            return {"card": card, "quality": 0.5}

        c = client({"/lead": reply, "/play": reply})
        st = PlayState(DEAL_HANDS, ctx="1N-P-P-P", dealer="N")
        st.play_out(c, limit=4)
        self.assertEqual(len(st.played), 4)
        self.assertEqual(st.played_str(), "S7SAS3SQ")
        self.assertEqual(st.leader(), "S")

    def test_retries_then_succeeds(self):
        calls = {"n": 0}

        def flaky(method, url, body):
            calls["n"] += 1
            if calls["n"] < 3:
                raise OSError("boom")
            return 200, '{"version": "1.2.3"}'

        c = BrillClient(transport=flaky, retries=3, backoff=0)
        self.assertEqual(c.version().version, "1.2.3")
        self.assertEqual(calls["n"], 3)

    def test_exhausted_retries_raise_unavailable(self):
        def dead(method, url, body):
            raise OSError("boom")

        c = BrillClient(transport=dead, retries=2, backoff=0)
        with self.assertRaises(BrillUnavailable):
            c.version()

    def test_4xx_is_not_retried_and_raises_bad_request(self):
        t = FakeTransport({"/bid": {}}, status=400)
        c = BrillClient(transport=lambda m, u, b: (400, '{"error":"bad hand"}'),
                        retries=3, backoff=0)
        with self.assertRaises(BrillBadRequest) as ctx:
            c.bid("nonsense")
        self.assertEqual(ctx.exception.status, 400)
        self.assertIn("bad hand", str(ctx.exception))

    def test_cache_avoids_the_second_call(self):
        c = client({"/version": {"version": "1.0"}})
        c.version()
        c.version()
        self.assertEqual(len(c.transport.calls), 1)
        self.assertEqual((c.cache_hits, c.cache_misses), (1, 1))

    def test_cache_roundtrips_to_disk(self):
        import os
        import tempfile
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "cache.json")
            c = client({"/version": {"version": "1.0"}}, cache_path=path)
            c.version()
            c.flush_cache()
            c2 = BrillClient(transport=FakeTransport({"/version": {}}),
                             cache_path=path)
            self.assertEqual(c2.version().version, "1.0")
            self.assertEqual(c2.cache_hits, 1)

    def test_post_body_is_json_encoded(self):
        c = client({"/suitc": {"ok": True}})
        c.suitc({"hand": "AKQ", "suit": "S"})
        method, url, body = c.transport.calls[0]
        self.assertEqual(method, "POST")
        self.assertEqual(json.loads(body.decode()), {"hand": "AKQ",
                                                     "suit": "S"})

    def test_normalize_call(self):
        self.assertEqual(normalize_call("1NT"), "1N")
        self.assertEqual(normalize_call("Pass"), "P")
        self.assertEqual(normalize_call("Dbl"), "X")
        self.assertEqual(normalize_call("1H*"), "1H")

    def test_seat_letter_variants(self):
        self.assertEqual(seat_letter(Seat.NORTH), "N")
        self.assertEqual(seat_letter("north"), "N")
        self.assertEqual(seat_letter(Seat.WEST), "W")


# ------------------------------------------------------------- live (opt-in)
DEAL = "N:QT8.AKQ7.JT9.AT9 K97.JT84.72.KJ42 A2.965.AKQ854.83 J6543.32.63.Q765"


@unittest.skipUnless(os.environ.get("BRILL_LIVE"),
                     "set BRILL_LIVE=1 to hit the network")
class TestLive(unittest.TestCase):
    """End-to-end checks against the real service.

    The strongest one is the 52-card board: Brill rejects any card whose seat
    disagrees with the seat *it* assigns to that position, so a clean run is
    proof that PlayState's leader sequence matches the service's — not just
    that our own bookkeeping is self-consistent.
    """

    def setUp(self):
        self.c = BrillClient(timeout=60, retries=4,
                             cache_path=os.environ.get("BRILL_CACHE"))

    def tearDown(self):
        self.c.flush_cache()

    def test_version(self):
        self.assertTrue(self.c.version().version)

    def test_full_board_play(self):
        st = PlayState.from_deal(DEAL, ctx="1N-P-P-P", vul="None")
        self.assertEqual(st.declarer, "N")
        st.play_out(self.c)
        self.assertTrue(st.complete)
        ns, _ = st.tricks()
        # /dd says North takes 12 tricks in NT on this deal.
        self.assertEqual(ns, self.c.dd(DEAL).tricks("N", "N"))

    def test_bid_and_explain_agree(self):
        r = self.c.bid("AKQ2.J54.T98.762", ctx="1H-P", seat="S")
        self.assertTrue(r.bid)
        ex = self.c.explain("1H-P-1S")
        self.assertTrue(ex)


if __name__ == "__main__":
    unittest.main()
