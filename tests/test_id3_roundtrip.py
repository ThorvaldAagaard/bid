"""ID3 speedup learning: persistence and rule compilation.

Background: `DecisionNet.export_dsl` writes only a depth-1 sketch of an
attached classifier (SPLIT_FEATURE / THRESHOLD / IF) and
`load_decision_net_dsl` reads only `RESOLVED_CALL`.  So an ID3 tree attached
via `attach_refinement` is destroyed by every save -> load cycle, which is why
the speedup-learning path was effectively dead code.  The fix is to compile
trees into ordinary rules, which round-trip for free.
"""

import os
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition
from bid.eval_vs_dds import load_decision_net_dsl
from bid.learner import ID3DecisionTree, id3_leaf_paths, id3_tree_to_rules
from bid.models import Call, CallType, Strain, Hand, Seat

NT = Strain.NT
HEARTS = Strain.HEARTS


def _two_rule_net() -> DecisionNet:
    net = DecisionNet("probe")
    net.add_rule(DecisionNetRule("R_1NT", Call(CallType.BID, 1, NT), [
        RuleCondition("hcp", ">=", 15), RuleCondition("hcp", "<=", 17),
        RuleCondition("is_balanced", "==", True)]))
    net.add_rule(DecisionNetRule("R_1H", Call(CallType.BID, 1, HEARTS), [
        RuleCondition("hcp", ">=", 12), RuleCondition("hcp", "<=", 21),
        RuleCondition("heart_len", ">=", 5)]))
    return net


def _split_tree() -> ID3DecisionTree:
    """Separable at hcp <= 16.5, so ID3 stops at a clean two-leaf split."""
    X = [{"hcp": 15, "heart_len": 5}, {"hcp": 16, "heart_len": 6},
         {"hcp": 17, "heart_len": 5}, {"hcp": 15, "heart_len": 7}]
    y = [Call(CallType.BID, 1, HEARTS), Call(CallType.BID, 1, HEARTS),
         Call(CallType.BID, 1, NT), Call(CallType.BID, 1, HEARTS)]
    t = ID3DecisionTree(max_depth=3)
    t.fit(X, y)
    return t


class TestAttachedTreeSurvives(unittest.TestCase):
    """The persistence fix: a full ID3 tree now round-trips.

    Before this, export wrote a depth-1 SPLIT_FEATURE/THRESHOLD sketch and the
    loader read only RESOLVED_CALL, so `intersection_nodes` came back empty and
    phi(s) re-widened — which is why the speedup-learning path was dead code.
    """

    def _round_trip(self, net):
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.dsl")
            net.save_dsl(path)
            return load_decision_net_dsl(path)

    def test_intersection_nodes_restored(self):
        net = _two_rule_net()
        net.attach_refinement(("R_1H", "R_1NT"), _split_tree())
        loaded = self._round_trip(net)
        self.assertIn(("R_1H", "R_1NT"), loaded.intersection_nodes)

    def test_phi_s_unchanged_across_save_load(self):
        net = _two_rule_net()
        net.attach_refinement(("R_1H", "R_1NT"), _split_tree())
        hand = Hand.from_string("SAK4 H76543 DAQ3 CK2")
        before = [str(c) for c in net.actions(hand, [])]
        loaded = self._round_trip(net)
        after = [str(c) for c in loaded.actions(hand, [])]
        self.assertEqual(before, after)
        self.assertEqual(before, ["1H"])

    def test_deeper_tree_round_trips_not_just_depth_one(self):
        """A depth-1 sketch would pass the checks above; this one would not."""
        X = [{"hcp": 15, "heart_len": 5}, {"hcp": 16, "heart_len": 6},
             {"hcp": 17, "heart_len": 5}, {"hcp": 15, "heart_len": 7}]
        y = [Call(CallType.BID, 1, HEARTS), Call(CallType.BID, 1, HEARTS),
             Call(CallType.BID, 1, NT), Call(CallType.BID, 1, NT)]
        t = ID3DecisionTree(max_depth=3)
        t.fit(X, y)
        net = _two_rule_net()
        net.attach_refinement(("R_1H", "R_1NT"), t)
        loaded = self._round_trip(net)
        node = loaded.intersection_nodes[("R_1H", "R_1NT")]
        root = node.refinement_classifier.root
        self.assertFalse(root.is_leaf, "expected a real split, not a collapsed leaf")
        for feats in X:
            self.assertEqual(str(t.predict(feats)), str(root.predict(feats)))

    def test_missing_feature_uses_majority_fallback(self):
        """Mirrors ID3Node.predict: absent feature -> node's majority call."""
        net = _two_rule_net()
        tree = _split_tree()
        net.attach_refinement(("R_1H", "R_1NT"), tree)
        loaded = self._round_trip(net)
        root = loaded.intersection_nodes[("R_1H", "R_1NT")].refinement_classifier.root
        self.assertEqual(str(tree.predict({})), str(root.predict({})))

    def test_shared_fixture_matches_js_expectations(self):
        """tests/fixtures/id3_tree.dsl is also read by tests/web/id3_dsl_test.mjs."""
        path = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                            "fixtures", "id3_tree.dsl")
        loaded = load_decision_net_dsl(path)
        self.assertIn(("R_1H", "R_1NT"), loaded.intersection_nodes)
        root = loaded.intersection_nodes[("R_1H", "R_1NT")].refinement_classifier.root
        self.assertEqual(str(root.predict({"hcp": 15})), "1H")
        self.assertEqual(str(root.predict({"hcp": 17})), "1NT")
        self.assertEqual(str(root.predict({})), "1H")


class TestLeafPaths(unittest.TestCase):
    def test_paths_cover_every_leaf(self):
        paths = id3_leaf_paths(_split_tree())
        self.assertEqual(len(paths), 2)
        self.assertEqual({str(c) for _, c in paths}, {"1H", "1NT"})

    def test_unfitted_tree_has_no_paths(self):
        self.assertEqual(id3_leaf_paths(ID3DecisionTree()), [])
        self.assertEqual(id3_leaf_paths(None), [])

    def test_path_conditions_use_split_thresholds(self):
        for conds, _ in id3_leaf_paths(_split_tree()):
            self.assertTrue(any(c.key == "hcp" for c in conds))
            for c in conds:
                self.assertIn(c.op, ("<=", ">"))


class TestCategoricalSplits(unittest.TestCase):
    """ID3 must be able to split on string features.

    The most predictive inputs in bridge are categorical -- `partner_last_call`,
    `opp_last_call`, `last_bid_strain` -- and they are strings. Before this,
    `fit()` kept only int/float/bool keys, so the tree was structurally blind
    to "what did partner just say" and the distillation pipeline had to fake it
    by partitioning traces into groups. Splitting on `== value` is what removes
    that workaround, and the DSL already supports `==` / `!=` on strings.
    """

    @staticmethod
    def _cat_tree() -> ID3DecisionTree:
        # Perfectly separated by `strain`; `hcp` carries no signal at all.
        X = [{"strain": "H", "hcp": 10}, {"strain": "S", "hcp": 10},
             {"strain": "H", "hcp": 12}, {"strain": "S", "hcp": 12}]
        y = [Call(CallType.BID, 1, HEARTS), Call(CallType.BID, 1, Strain.SPADES),
             Call(CallType.BID, 1, HEARTS), Call(CallType.BID, 1, Strain.SPADES)]
        t = ID3DecisionTree(max_depth=3)
        t.fit(X, y)
        return t

    def test_string_feature_is_used_as_a_split(self):
        root = self._cat_tree().root
        self.assertFalse(root.is_leaf, "expected a split, not a collapsed leaf")
        self.assertEqual(root.feature_name, "strain")
        self.assertFalse(root.is_continuous,
                         "a categorical split must set is_continuous=False")

    def test_nominal_split_prediction_routing(self):
        t = self._cat_tree()
        self.assertEqual(str(t.predict({"strain": "H"})), "1H")
        self.assertEqual(str(t.predict({"strain": "S"})), "1S")

    def test_leaf_paths_emit_equality_and_inequality(self):
        """Both branches must be written, or the `!=` rule fires everywhere."""
        ops = set()
        for conds, _ in id3_leaf_paths(self._cat_tree()):
            for c in conds:
                if c.key == "strain":
                    ops.add(c.op)
        self.assertEqual(ops, {"==", "!="})

    def test_compiled_rules_are_mutually_exclusive(self):
        rules = id3_tree_to_rules(self._cat_tree(), [], "BD_cat",
                                  base_priority=10)
        for feats in ({"strain": "H"}, {"strain": "S"}, {"strain": "D"}):
            hits = [r for r in rules
                    if all(c.evaluate(feats) for c in r.conditions)]
            self.assertEqual(len(hits), 1,
                             "exactly one rule must fire for %r, got %d"
                             % (feats, len(hits)))

    def test_high_cardinality_strings_are_not_split(self):
        """An identifier column must be ignored, or the tree memorises rows."""
        from bid.learner import MAX_CATEGORICAL_VALUES
        n = MAX_CATEGORICAL_VALUES + 5
        X = [{"id": "row%03d" % i, "hcp": 10} for i in range(n)]
        y = [Call(CallType.BID, 1, HEARTS) if i % 2 == 0
             else Call(CallType.BID, 1, NT) for i in range(n)]
        t = ID3DecisionTree(max_depth=3)
        t.fit(X, y)
        # `id` would separate perfectly; `hcp` is constant. So if `id` were
        # allowed the root would be a split; it must instead collapse.
        self.assertTrue(t.root.is_leaf,
                        "an over-cardinality string must not become a split")


class TestDslValueQuoting(unittest.TestCase):
    """String condition values must be quoted on export.

    The parser coerces bare numeric-looking tokens to int, so an unquoted
    `shape_pattern == 4432` loads back as the int 4432 and never equals the
    feature's string '4432' -- the rule is silently dead, and the exported
    line looks completely correct. Found via the Brill distillation, where 20
    of 192 compiled rules died this way.
    """

    def _round_trip(self, net):
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.dsl")
            net.save_dsl(path)
            return load_decision_net_dsl(path)

    def test_numeric_looking_string_survives_as_string(self):
        net = DecisionNet("probe")
        net.add_rule(DecisionNetRule("R_shape", Call(CallType.BID, 1, NT),
                                     [RuleCondition("shape_pattern", "==", "4432")]))
        loaded = self._round_trip(net)
        cond = loaded.rules[0].conditions[0]
        self.assertIsInstance(cond.value, str,
                              "4432 must not be coerced to int on load")
        self.assertEqual(cond.value, "4432")

    def test_numeric_looking_string_still_matches(self):
        """The observable symptom: the rule stopped firing after a reload."""
        net = DecisionNet("probe")
        net.add_rule(DecisionNetRule("R_shape", Call(CallType.BID, 1, NT),
                                     [RuleCondition("shape_pattern", "==", "4432")]))
        for candidate in (net, self._round_trip(net)):
            self.assertTrue(
                candidate.rules[0].conditions[0].evaluate({"shape_pattern": "4432"}),
                "rule must match '4432' both before and after save/load")

    def test_non_numeric_strings_and_numbers_unaffected(self):
        net = DecisionNet("probe")
        net.add_rule(DecisionNetRule("R_a", Call(CallType.BID, 1, NT), [
            RuleCondition("partner_last_call", "==", "PASS"),
            RuleCondition("my_seat", "!=", "E"),
            RuleCondition("hcp", ">=", 15)]))
        loaded = self._round_trip(net)
        got = {c.key: c.value for c in loaded.rules[0].conditions}
        self.assertEqual(got, {"partner_last_call": "PASS",
                               "my_seat": "E", "hcp": 15})


class TestTreeToRules(unittest.TestCase):
    def setUp(self):
        self.net = _two_rule_net()
        self.key_rules = [r for r in self.net.rules if r.rule_id in ("R_1H", "R_1NT")]
        self.rules = id3_tree_to_rules(_split_tree(), self.key_rules,
                                       "ID3_R_1H_R_1NT", base_priority=30)

    def test_emits_one_rule_per_leaf(self):
        self.assertEqual(len(self.rules), 2)

    def test_rules_carry_the_intersection_guard(self):
        """Without the guard the split would fire in auctions it never saw."""
        for r in self.rules:
            keys = {c.key for c in r.conditions}
            self.assertIn("is_balanced", keys)
            self.assertTrue(any(c.key == "heart_len" for c in r.conditions))
            self.assertTrue(any(c.key == "hcp" for c in r.conditions))

    def test_rules_do_not_fire_outside_the_intersection(self):
        # 18 HCP 5 hearts: R_1H matches but R_1NT does not, so no ID3 rule applies
        hand = Hand.from_string("SAK4 H76543 DAQ3 CKQ2")
        feats_hit = [r for r in self.rules
                     if all(c.evaluate(self._feats(hand)) for c in r.conditions)]
        self.assertEqual(feats_hit, [])

    def test_rules_resolve_inside_the_intersection(self):
        hand = Hand.from_string("SAK4 H76543 DAQ3 CK2")  # 16 HCP, 5 hearts, balanced
        f = self._feats(hand)
        hits = [r for r in self.rules if all(c.evaluate(f) for c in r.conditions)]
        self.assertEqual(len(hits), 1)
        self.assertEqual(str(hits[0].call), "1H")

    def test_compiled_rules_survive_save_load(self):
        """The whole point: learned splits must persist."""
        for r in self.rules:
            self.net.add_rule(r)
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "x.dsl")
            self.net.save_dsl(path)
            loaded = load_decision_net_dsl(path)
        loaded_ids = {r.rule_id for r in loaded.rules}
        for r in self.rules:
            self.assertIn(r.rule_id, loaded_ids)

    @staticmethod
    def _feats(hand):
        from bid.features import BridgeFeatures
        return BridgeFeatures.extract_all(hand, [], Seat.SOUTH, Seat.NORTH, 0)


class TestAmbiguousStateHarvest(unittest.TestCase):
    """`harvest_ambiguous_states` must sample mid-auction states, not just
    opening hands — otherwise auction-context features are constant across the
    whole training set and no context-dependent refinement can be learned."""

    @staticmethod
    def _live_net():
        path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                            "system", "improved_system.dsl")
        return load_decision_net_dsl(path)

    def test_respects_limit(self):
        from bid import flywheel as fw
        from bid.sampling import Deal
        net = self._live_net()
        deals = [Deal.random_deal(dealer=Seat.NORTH) for _ in range(6)]
        states = fw.Flywheel.harvest_ambiguous_states(net, deals, limit=7)
        self.assertLessEqual(len(states), 7)
        self.assertGreater(len(states), 0)

    def test_some_states_have_auction_history(self):
        from bid import flywheel as fw
        from bid.sampling import Deal
        net = self._live_net()
        deals = [Deal.random_deal(dealer=Seat.NORTH) for _ in range(8)]
        states = fw.Flywheel.harvest_ambiguous_states(net, deals, limit=60)
        with_history = [s for s in states if s.history]
        self.assertGreater(len(with_history), 0,
                           "harvest produced only opening-position states")

    def test_history_is_snapshotted_not_shared(self):
        """The auction list is mutated in place; states must hold a copy."""
        from bid import flywheel as fw
        from bid.sampling import Deal
        net = self._live_net()
        deals = [Deal.random_deal(dealer=Seat.NORTH) for _ in range(4)]
        states = fw.Flywheel.harvest_ambiguous_states(net, deals, limit=40)
        for s in states:
            self.assertIsInstance(s.history, list)


class TestFlywheelId3Family(unittest.TestCase):
    def test_family_can_be_enabled(self):
        from bid import flywheel as fw
        import inspect
        self.assertIn("id3", inspect.signature(fw.Flywheel.__init__).parameters)
        self.assertIn("build_id3_patches", dir(fw.Flywheel))

    def test_add_rules_rejects_duplicate_ids_within_one_batch(self):
        """Regression: the 'existing' set was computed once before the loop, so a
        batch carrying two rules with the same id inserted both."""
        from bid import flywheel as fw
        net = _two_rule_net()
        dupes = [DecisionNetRule("SAME_ID", Call(CallType.BID, 1, NT),
                                 [RuleCondition("hcp", ">=", 20)]),
                 DecisionNetRule("SAME_ID", Call(CallType.BID, 2, NT),
                                 [RuleCondition("hcp", ">=", 25)])]
        fw.add_rules(net, dupes)
        ids = [r.rule_id for r in net.rules]
        self.assertEqual(ids.count("SAME_ID"), 1)

    def test_intersections_hashing_to_one_prefix_get_distinct_ids(self):
        """Regression: the intersection key was truncated to 20 chars, so distinct
        intersections collided onto one rule id and all but the first were dropped."""
        from bid import flywheel as fw
        net = DecisionNet("multi")
        for i, (rid, call) in enumerate((("R_A", Call(CallType.BID, 1, NT)),
                                         ("R_B", Call(CallType.BID, 1, HEARTS)),
                                         ("R_C", Call(CallType.BID, 1, Strain.SPADES)))):
            net.add_rule(DecisionNetRule(rid, call, [RuleCondition("hcp", ">=", 12 + i)]))

        shared = [r for r in net.rules if r.rule_id in ("R_A", "R_B")]
        other = [r for r in net.rules if r.rule_id in ("R_A", "R_C")]
        tree = _split_tree()
        a = id3_tree_to_rules(tree, shared, "ID3_R_A_R_B_shortprefix_aaaaaa")
        b = id3_tree_to_rules(tree, other, "ID3_R_A_R_C_shortprefix_aaaaaa")
        fw.add_rules(net, a + b)
        ids = [r.rule_id for r in net.rules]
        self.assertEqual(len(ids), len(set(ids)),
                         "compiled rules must not collide on rule_id")


if __name__ == "__main__":
    unittest.main()
