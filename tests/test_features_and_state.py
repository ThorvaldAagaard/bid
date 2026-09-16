import unittest
from bid.models import Hand, Card, Suit, Strain, Rank, Seat, Call, CallType
from bid.features import BridgeFeatures
from bid.sampling import Deal, PartialState

class TestFeaturesAndState(unittest.TestCase):

    def test_hand_feature_extraction(self):
        # 16 HCP, 5 spades, 3 hearts, 3 diamonds, 2 clubs, balanced, 4 controls (A=2, K=1, K=1)
        hand = Hand.from_string("SAKQ32 HK32 DA32 C43")
        feats = BridgeFeatures.extract_hand_features(hand)

        self.assertEqual(feats["hcp"], 16)
        self.assertEqual(feats["spade_len"], 5)
        self.assertEqual(feats["heart_len"], 3)
        self.assertEqual(feats["diamond_len"], 3)
        self.assertEqual(feats["club_len"], 2)
        self.assertTrue(feats["is_balanced"])
        self.assertFalse(feats["has_void"])
        self.assertFalse(feats["has_singleton"])
        self.assertEqual(feats["controls"], 6) # SA=2, SK=1, HK=1, DA=2
        self.assertEqual(feats["ace_count"], 2)
        self.assertEqual(feats["king_count"], 2)
        self.assertEqual(feats["queen_count"], 1)

    def test_realsolid_matches_brills_measured_table(self):
        """`realsolid('X')` is Brill's suit-quality gate on 256 slam rows.

        It is NOT "AKQ and 6+". Fitted by probing Brill's own engine with
        `losers` pinned at 1 and only the target suit varying (status §6.53);
        350/350 held-out hands. Lock the whole table so a later "obvious"
        simplification cannot silently turn it into an over-bid.
        """
        # (spade holding, side suits, expected s_realsolid)
        cases = [
            ("SAKQJ32",     "HAKQ DAK CAQ",   True),   # AKQJ, 6  -> 6+  ok
            ("SAKQT32",     "HAKQ DAK CAQ",   False),  # AKQT, 6  -> needs 7
            ("SAKQ432",     "HAKQ DAK CAQ",   False),  # AKQ,  6  -> needs 8
            ("SAKQT543",    "HAKQ DAK CA",    True),   # AKQT, 7
            ("SAKQ5432",    "HAKQ DAK CA",    False),  # AKQ,  7
            ("SAKJ5432",    "HAKQ DAK CA",    False),  # AKJ,  7  -> needs 9
            ("SAKQ65432",   "HAK DAK CK",     True),   # AKQ,  8
            ("SAKJ98765",   "HAKQ DA CA",     False),  # AKJ,  8
            ("SAKJ987654",  "HAK DA CA",      True),   # AKJ,  9
            ("SAKT98765",   "HAKQ DA CA",     False),  # AKT,  8  -> never
            ("SAQJ987654",  "HAK DA CA",      False),  # no king -> never
            ("SAKQJ",       "HAKQ DAKQ32 CA", False),  # 4 cards -> never
            ("SAKT9876543", "HA DA CA",       False),  # AKT, 10 -> never
        ]
        for spades, rest, expected in cases:
            hand = Hand.from_string(spades + " " + rest)
            feats = BridgeFeatures.extract_hand_features(hand)
            self.assertEqual(len(hand.cards), 13, spades)
            self.assertEqual(feats["s_realsolid"], expected,
                             "spades=%s expected realsolid=%s" % (spades, expected))

        # ... and the same predicate is exposed per suit, not just spades.
        hand = Hand.from_string("HAKQJ32 SAKQ DAK CAQ")
        feats = BridgeFeatures.extract_hand_features(hand)
        self.assertTrue(feats["h_realsolid"])
        self.assertFalse(feats["s_realsolid"])   # 3-card spade suit

    def test_auction_feature_extraction(self):
        history = [
            Call(CallType.BID, 1, Strain.HEARTS),
            Call(CallType.PASS),
            Call(CallType.BID, 2, Strain.HEARTS),
            Call(CallType.PASS)
        ]
        # South is deciding next
        feats = BridgeFeatures.extract_auction_features(history, my_seat=Seat.SOUTH, dealer=Seat.NORTH)
        self.assertEqual(feats["auction_len"], 4)
        self.assertFalse(feats["is_opening"])
        self.assertEqual(feats["last_bid_level"], 2)
        self.assertEqual(feats["last_bid_strain"], "H")

    def test_partner_hcp_window_inversion(self):
        """partner's bids must invert to the range they promised."""
        from bid.features import _partner_hcp_window
        B = lambda l, s: Call(CallType.BID, l, s)
        P = Call(CallType.PASS)
        cases = [
            ([], (0, 37)),                                  # nothing said
            ([P], (0, 37)),                                 # passes are not invertible
            ([B(1, Strain.NT)], (15, 17)),                  # precise
            ([B(2, Strain.NT)], (20, 21)),
            ([B(1, Strain.SPADES)], (11, 21)),              # wide
            ([B(2, Strain.CLUBS)], (22, 37)),               # strong/artificial
            ([B(2, Strain.HEARTS)], (5, 10)),               # weak two
            ([B(4, Strain.SPADES)], (5, 10)),               # preempt
            ([B(1, Strain.HEARTS), B(2, Strain.NT)], (20, 21)),   # narrows
            ([B(1, Strain.HEARTS), B(3, Strain.HEARTS)], (11, 21)),  # keeps the earlier
        ]
        for calls, expected in cases:
            self.assertEqual(_partner_hcp_window(calls), expected,
                             "calls=%s" % [str(c) for c in calls])

    def test_partner_hcp_window_ignores_non_bids(self):
        from bid.features import _partner_hcp_window
        calls = [Call(CallType.PASS),
                 Call(CallType.DOUBLE),
                 Call(CallType.REDOUBLE),
                 Call(CallType.BID, 1, Strain.NT)]
        # A takeout double says "values" but so does a penalty double say
        # something else; neither is safe to invert, so 1NT alone decides.
        self.assertEqual(_partner_hcp_window(calls), (15, 17))

    def test_combined_hcp_uses_my_hand_not_zero(self):
        """Regression: the combined features used to read `hcp` from the
        auction-features dict, which has no such key, silently making
        combined == partner's window."""
        # 16 HCP
        hand = Hand.from_string("SAKQ32 HK32 DA32 C43")
        history = [Call(CallType.BID, 1, Strain.NT), Call(CallType.PASS)]
        feats = BridgeFeatures.extract_all(hand, history, Seat.SOUTH,
                                           Seat.NORTH, 0)
        self.assertEqual(feats["hcp"], 16)
        self.assertEqual(feats["partner_hcp_min"], 15)
        self.assertEqual(feats["partner_hcp_max"], 17)
        self.assertEqual(feats["combined_hcp_min"], 31)
        self.assertEqual(feats["combined_hcp_max"], 33)

    def test_combined_hcp_max_never_exceeds_the_deck(self):
        hand = Hand.from_string("SAKQ32 HK32 DA32 C43")
        # No information about partner -> the honest upper bound is "any",
        # but it must still be clamped to 40 or the tree can split on
        # combined totals no deal can produce.
        feats = BridgeFeatures.extract_all(hand, [], Seat.SOUTH,
                                           Seat.NORTH, 0)
        self.assertEqual(feats["partner_hcp_min"], 0)
        self.assertEqual(feats["partner_hcp_max"], 37)
        self.assertEqual(feats["combined_hcp_min"], 16)
        self.assertEqual(feats["combined_hcp_max"], 40)

    def test_bitmask_representation_and_caching(self):
        hand = Hand.from_string("SAKQ32 HK32 DA32 C43")
        # Check that suit_masks has bits set correctly (bit 0 = 2, bit 12 = Ace)
        # Spades: A(12), K(11), Q(10), 3(1), 2(0)
        expected_spades_mask = (1 << 12) | (1 << 11) | (1 << 10) | (1 << 1) | (1 << 0)
        self.assertEqual(hand.suit_masks[Suit.SPADES], expected_spades_mask)

        # Verify caching
        self.assertIsNone(hand._cached_features)
        feats1 = BridgeFeatures.extract_hand_features(hand)
        self.assertIsNotNone(hand._cached_features)
        self.assertIs(hand._cached_features, hand._cached_features)
        feats2 = BridgeFeatures.extract_hand_features(hand)
        self.assertEqual(feats1, feats2)

        # Check LTC and quick tricks
        self.assertEqual(feats1["losing_trick_count"], 6)  # S: 0, H: 2, D: 2, C: 2 = 6
        self.assertEqual(feats1["quick_tricks"], 3.5)      # S: AK(2.0), H: Kxx(0.5), D: Axx(1.0) = 3.5

    def test_partial_state_contract_determination(self):
        # North 1H - East Pass - South 4H - West Pass - North Pass - East Pass (Over!)
        history = [
            Call(CallType.BID, 1, Strain.HEARTS),
            Call(CallType.PASS),
            Call(CallType.BID, 4, Strain.HEARTS),
            Call(CallType.PASS),
            Call(CallType.PASS),
            Call(CallType.PASS)
        ]
        hand = Hand.random()
        ps = PartialState(Seat.SOUTH, hand, history, dealer=Seat.NORTH)

        self.assertTrue(ps.is_auction_over())
        contract = ps.get_contract()
        self.assertIsNotNone(contract)
        level, strain, declarer, doubled = contract
        self.assertEqual(level, 4)
        self.assertEqual(strain, Strain.HEARTS)
        self.assertEqual(declarer, Seat.NORTH) # First bidder of hearts
        self.assertEqual(doubled, 0)

if __name__ == "__main__":
    unittest.main()
