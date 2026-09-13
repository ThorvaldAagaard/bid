"""Legacy-dialect systems must survive pickling (§6.34).

`system/gib.dsl`, `precision.dsl` and `blue_club.dsl` are a LEGACY dialect
(`OPEN 1C:` / `HCP:` / `SHAPE:`), loaded by `SystemTranslator().parse()` rather
than by the DecisionNet loader. They are 159/166/183 rules — an order of
magnitude bigger than the 10/8/15-rule panel in `build_opponent_panel()` — but
they could not be used as evaluation opponents, because
`SystemTranslator._add_rule_from_data` built each rule's trigger as a CLOSURE:

    AttributeError: Can't get local object
    'SystemTranslator._add_rule_from_data.<locals>.trigger'

Python cannot pickle a nested function by reference, so any wrapped
`BiddingSystem` failed the moment it was sent to a `spawn` worker, which is what
`evaluate_system(jobs>1)` must use. That confined every legacy system to
single-process evaluation and is why the panel was built from skeletons instead.

The fix replaces the closure with the module-level callable object
`bid.translator.LegacyTrigger`. These tests lock that in: pickling must work,
and a pickled system must bid exactly like a fresh one.

Note: comparing `str(rule)` is WRONG here — `Rule` has no `__str__`, so it
renders as `<bid.system.Rule object at 0x...>` and every comparison fails.
Compare `rule.call`.
"""
import os
import pickle
import random
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from bid.translator import SystemTranslator, LegacyTrigger
from bid.models import Call, CallType, Seat, Strain
from bid.sampling import Deal

SYSTEM_DIR = os.path.join(os.path.dirname(__file__), "..", "system")
LEGACY = ["gib.dsl", "precision.dsl", "blue_club.dsl"]


def _load(name):
    with open(os.path.join(SYSTEM_DIR, name)) as f:
        return SystemTranslator().parse(f.read())


class TestLegacyTriggerIsPicklable(unittest.TestCase):
    def test_trigger_is_not_a_closure(self):
        """The regression itself: trigger must be a picklable callable object."""
        for name in LEGACY:
            sys_ = _load(name)
            for rule in sys_.rules:
                self.assertIsInstance(
                    rule.trigger, LegacyTrigger,
                    f"{name}: rule trigger is {type(rule.trigger).__name__}, "
                    "not LegacyTrigger — it will not pickle")

    def test_systems_pickle(self):
        for name in LEGACY:
            sys_ = _load(name)
            blob = pickle.dumps(sys_)
            self.assertEqual(len(pickle.loads(blob).rules), len(sys_.rules))


class TestPickledSystemBidsIdentically(unittest.TestCase):
    """A pickled system must be behaviourally indistinguishable from a fresh one."""

    def setUp(self):
        self._rng = random.getstate()
        random.seed(7)
        self.cases = []
        for _ in range(120):
            hand = Deal.random_deal().hands[Seat.SOUTH]
            hist = []
            for _ in range(random.randint(0, 5)):
                if random.random() < 0.4:
                    hist.append(Call(CallType.PASS))
                else:
                    hist.append(Call(CallType.BID, random.randint(1, 4),
                                     random.choice(list(Strain))))
            self.cases.append((hand, hist))

    def tearDown(self):
        random.setstate(self._rng)

    def _call_of(self, system, hand, hist):
        rule = system.get_bid(hist, hand)
        return None if rule is None else str(rule.call)

    def test_round_trip_preserves_bids(self):
        for name in LEGACY:
            fresh = _load(name)
            round_tripped = pickle.loads(pickle.dumps(fresh))
            for hand, hist in self.cases:
                self.assertEqual(self._call_of(fresh, hand, hist),
                                 self._call_of(round_tripped, hand, hist),
                                 f"{name}: bid changed after pickling")

    def test_get_bid_is_deterministic(self):
        """Guards the comparison above: if get_bid were random it would prove nothing."""
        fresh = _load("precision.dsl")
        for hand, hist in self.cases[:40]:
            self.assertEqual(self._call_of(fresh, hand, hist),
                             self._call_of(fresh, hand, hist))

    def test_wrapped_decision_net_pickles(self):
        """The actual use: a legacy system as a DecisionNet opponent."""
        from bid.decision_net import DecisionNet
        for name in LEGACY:
            net = DecisionNet(name[:-4])
            net.wrapped_system = _load(name)
            revived = pickle.loads(pickle.dumps(net))
            self.assertIsNotNone(revived.wrapped_system)
            self.assertEqual(len(revived.wrapped_system.rules),
                             len(net.wrapped_system.rules))


class TestPanelSelection(unittest.TestCase):
    """`build_panel(kind)` resolves the --panel flag (§6.34)."""

    def test_default_panel_is_unchanged(self):
        """28 recorded versions were scored against this; it must not move."""
        from bid.eval_vs_dds import build_panel
        panel = build_panel("default")
        self.assertEqual([n for n, _ in panel], ["SAYC", "Precision", "2/1 GF"])
        self.assertEqual([len(net.rules) for _, net in panel], [10, 8, 15])

    def test_legacy_panel_is_much_bigger(self):
        from bid.eval_vs_dds import build_panel
        panel = build_panel("legacy")
        self.assertEqual([n for n, _ in panel],
                         ["blue_club", "precision", "gib"])
        sizes = [len(net.wrapped_system.rules) for _, net in panel]
        self.assertEqual(sizes, [183, 166, 159])
        # the whole point: an order of magnitude more than the default panel
        self.assertGreater(min(sizes), 10 * max(10, 8, 15))

    def test_legacy_panel_survives_pickling(self):
        """The §6.35 fix, at the level the CLI actually uses it."""
        from bid.eval_vs_dds import build_panel
        panel = build_panel("legacy")
        revived = pickle.loads(pickle.dumps(panel))
        self.assertEqual(len(revived), len(panel))
        for (n1, net1), (n2, net2) in zip(panel, revived):
            self.assertEqual(n1, n2)
            self.assertEqual(len(net1.wrapped_system.rules),
                             len(net2.wrapped_system.rules))


if __name__ == "__main__":
    unittest.main()
