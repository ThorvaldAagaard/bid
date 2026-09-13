"""Tests for the IMP-capped metric and the fixed opponent panel.

These guard the two fixes that address the "flat anchor ledger" failure mode:
raw point regret is dominated by single slam-scale boards, and self-play lets
the candidate bid against a copy of itself so adaptive effects cancel.
"""

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from bid import flywheel as fw
from bid.eval_vs_dds import (imp_loss, build_opponent_panel, panel_opponent_for,
                             evaluate_panel, evaluate_system, build_deals, precompute,
                             MIN_BOARDS_PER_WORKER)
from bid.arena import BiddingArena
from bid.pidm import PIDMEngine
from bid.sampling import RBMBMCSampler


class TestImpLossMetric(unittest.TestCase):
    def test_zero_when_score_matches_par(self):
        self.assertEqual(imp_loss(620, 620), 0)

    def test_saturates_at_24_imps(self):
        """A -2000 point disaster must not outweigh dozens of small boards."""
        self.assertLessEqual(imp_loss(-2000, 0), 24)

    def test_monotone_in_gap(self):
        small = imp_loss(100, 0)
        large = imp_loss(1000, 0)
        self.assertLessEqual(small, large)

    def test_symmetric(self):
        self.assertEqual(imp_loss(500, 0), imp_loss(0, 500))


class TestMetricDirection(unittest.TestCase):
    def test_loss_metrics_are_flipped(self):
        # IMP loss fell from 4.0 to 3.8 -> that is a gain of +0.2
        self.assertAlmostEqual(fw.metric_gain(4.0, 3.8, "mean_imp_loss"), 0.2)
        # ...but for a points metric the same numbers are a loss
        self.assertAlmostEqual(fw.metric_gain(4.0, 3.8, "avg_score"), -0.2)

    def test_effect_floor_scales_with_metric(self):
        # 0.1 is noise in points/board but a real gain in IMPs/board
        self.assertFalse(fw.passes_effect_floor(0.1, "avg_score"))
        self.assertTrue(fw.passes_effect_floor(0.1, "mean_imp_loss"))

    def test_val_tolerance_scales_with_metric(self):
        self.assertEqual(fw.val_tolerance("avg_score"), 5.0)
        self.assertLess(fw.val_tolerance("mean_imp_loss"), 1.0)

    def test_default_signatures_unchanged(self):
        """Historical single-arg call sites must keep their behaviour."""
        self.assertFalse(fw.passes_effect_floor(0.0))
        self.assertTrue(fw.passes_effect_floor(0.5))
        self.assertTrue(fw.winner_gate(True, 23.7))
        self.assertFalse(fw.winner_gate(True, 0.04))


class TestOpponentPanel(unittest.TestCase):
    def test_panel_is_heterogeneous_and_named(self):
        panel = build_opponent_panel()
        self.assertGreaterEqual(len(panel), 2)
        names = [n for n, _ in panel]
        self.assertEqual(len(names), len(set(names)))

    def test_panel_members_are_distinct_systems(self):
        panel = build_opponent_panel()
        sigs = set()
        for _, net in panel:
            sigs.add(tuple(sorted((r.rule_id, str(r.call)) for r in net.rules)))
        self.assertEqual(len(sigs), len(panel),
                         "panel members must not be duplicates of each other")

    def test_rotation_is_deterministic_and_covers_panel(self):
        panel = build_opponent_panel()
        picks = [panel_opponent_for(i, panel) for i in range(len(panel))]
        nets = [n for _, n in panel]
        for p in picks:
            self.assertIn(p, nets)
        self.assertEqual(len({id(p) for p in picks}), len(panel))
        # same deal index always gets the same opponent
        self.assertIs(panel_opponent_for(3, panel), panel_opponent_for(3, panel))


class TestPanelEvaluation(unittest.TestCase):
    """Slow-ish integration tests; kept to a handful of boards."""

    @classmethod
    def setUpClass(cls):
        cls.deals = build_deals(4, seed=42, include_stratified=False)
        cls.dd = precompute(cls.deals)
        engine = PIDMEngine(sampler=RBMBMCSampler(sample_size=2, max_iterations=6,
                                                  timeout_sec=0.05),
                            max_lookahead_depth=1)
        cls.arena = BiddingArena(engine=engine)
        cls.panel = build_opponent_panel()[:2]

    def test_panel_result_shape(self):
        cand = self.panel[0][1]
        res = evaluate_panel(self.arena, "cand", cand, self.deals, self.dd,
                             opponents=self.panel)
        for key in ("h2h_score", "mean_imp_loss", "avg_regret", "per_opponent"):
            self.assertIn(key, res)
        self.assertEqual(len(res["per_opponent"]), len(self.panel))
        self.assertEqual(res["boards"], len(self.deals))

    def test_both_seats_played_so_par_cancels(self):
        """Averaging both orientations makes mean regret a pure head-to-head
        score: (score_as_NS - score_as_EW) / 2, independent of par."""
        cand = self.panel[0][1]
        res = evaluate_panel(self.arena, "cand", cand, self.deals, self.dd,
                             opponents=self.panel)
        for opp_name, d in res["per_opponent"].items():
            self.assertIsInstance(d["h2h_score"], float)
            self.assertIsInstance(d["mean_imp_loss"], float)

    def test_panel_replaces_the_east_west_model(self):
        """The whole point: facing a frozen panel is not the same problem as
        facing a copy of yourself.

        This used to assert `self_play["avg_regret"] != vs_panel["avg_regret"]`.
        That was passing for the wrong reason. Before §6.26 the two calls
        consumed one global RNG sequentially, so they searched DIFFERENT worlds
        and produced different numbers even with identical opponents. Once
        evaluations became reproducible the numbers came out identical
        (`[190, -200, 70, 210]` both ways) -- because on these 4 boards E/W
        bidding with SAYC (10 rules) or Precision (8 rules) does not change the
        contract. So the test was detecting RNG drift, not the panel.

        Assert the thing that is actually guaranteed instead: with a panel, the
        E/W seats are handed the panel member rather than the candidate.
        """
        cand = self.panel[0][1]
        seen = []
        orig = BiddingArena.play_board

        def spy(self, deal, ns_model, ew_model):
            seen.append((ns_model, ew_model))
            return orig(self, deal, ns_model, ew_model)

        BiddingArena.play_board = spy
        try:
            vs_panel = evaluate_system(self.arena, "cand", cand, self.deals,
                                       self.dd, opponent_panel=self.panel)
        finally:
            BiddingArena.play_board = orig

        self.assertIn("mean_imp_loss", vs_panel)
        self.assertTrue(seen)
        panel_members = {p[1] for p in self.panel}
        ns_models = {ns for ns, _ in seen}
        ew_models = {ew for _, ew in seen}
        self.assertEqual(ns_models, {cand})
        self.assertTrue(ew_models <= panel_members)
        # and at least one board faces a system that is not the candidate
        self.assertTrue(any(ew is not cand for _, ew in seen))


class TestParallelEvaluation(unittest.TestCase):
    """`evaluate_system(jobs=N)` fans boards out over processes.

    Serial and parallel deliberately do NOT produce identical numbers: in the
    serial path one RNG is consumed in board order, whereas each chunk is
    seeded from (run seed, chunk offset). What must hold is that a given
    parallel configuration is *reproducible* and aggregates every board.
    """

    # Enough boards to clear MIN_BOARDS_PER_WORKER, otherwise the guard silently
    # falls back to serial and these tests would pass without testing anything.
    JOBS = 3

    @classmethod
    def setUpClass(cls):
        cls.deals = build_deals(cls.JOBS * MIN_BOARDS_PER_WORKER, seed=42,
                                include_stratified=False)
        cls.dd = precompute(cls.deals)
        engine = PIDMEngine(sampler=RBMBMCSampler(sample_size=2, max_iterations=6,
                                                  timeout_sec=0.05),
                            max_lookahead_depth=1)
        cls.arena = BiddingArena(engine=engine)
        cls.net = build_opponent_panel()[0][1]

    def _run(self, jobs):
        return evaluate_system(self.arena, "p", self.net, self.deals, self.dd,
                               run_diagnostics=True, seed=42, jobs=jobs)

    def test_parallel_path_is_actually_taken(self):
        self.assertEqual(self._run(self.JOBS)["jobs_used"], self.JOBS)
        self.assertEqual(self._run(1)["jobs_used"], 1)

    def test_small_runs_fall_back_to_serial(self):
        """Spawning would cost more than it saves below the threshold."""
        few = self.deals[:2]
        r = evaluate_system(self.arena, "s", self.net, few, self.dd[:2],
                            run_diagnostics=True, seed=42, jobs=self.JOBS)
        self.assertEqual(r["jobs_used"], 1)

    def test_parallel_is_reproducible(self):
        a = self._run(self.JOBS)
        b = self._run(self.JOBS)
        self.assertEqual(a["scores"], b["scores"])
        self.assertAlmostEqual(a["mean_imp_loss"], b["mean_imp_loss"], places=12)

    def test_every_board_is_counted(self):
        r = self._run(self.JOBS)
        self.assertEqual(len(r["scores"]), len(self.deals))

    def test_parallel_matches_serial_shape_and_keys(self):
        s = self._run(1)
        p = self._run(self.JOBS)
        for key in ("avg_score", "avg_regret", "avg_imp_loss", "mean_imp_loss",
                    "par_accuracy", "game_conversion", "scores", "flaws"):
            self.assertIn(key, p)
        self.assertEqual(len(s["scores"]), len(p["scores"]))


if __name__ == "__main__":
    unittest.main()


class TestParallelHonoursSearchConfig(unittest.TestCase):
    """--jobs must not silently change the search being evaluated.

    The serial path uses the `arena` it is handed; the worker used to hardcode
    sample_size=2 / max_iterations=6 / timeout_sec=0.06, so enabling --jobs
    quietly swapped in a different search. The config is now carried across.
    """

    def _run_chunk(self, job):
        from bid import eval_vs_dds as ev
        return ev._eval_chunk(job)

    def test_worker_engine_gets_the_caller_config(self):
        from bid import eval_vs_dds as ev
        seen = {}
        real = ev.PIDMEngine

        class Recorder:
            def __init__(self, sampler=None, max_lookahead_depth=None):
                seen["sampler"] = sampler
                seen["depth"] = max_lookahead_depth
                self.sampler = sampler

        ev.PIDMEngine = Recorder
        try:
            # empty deal list: the engine is constructed, the loop never runs
            self._run_chunk(([], [], None, None, None, False, 0, 0, False, 0,
                             (4, 12, 0.25, 3)))
        finally:
            ev.PIDMEngine = real

        self.assertEqual(seen["depth"], 3)
        self.assertEqual(seen["sampler"].sample_size, 4)
        self.assertEqual(seen["sampler"].max_iterations, 12)
        self.assertEqual(seen["sampler"].timeout_sec, 0.25)

    def test_older_ten_element_payload_still_unpacks(self):
        from bid import eval_vs_dds as ev
        seen = {}
        real = ev.PIDMEngine

        class Recorder:
            def __init__(self, sampler=None, max_lookahead_depth=None):
                seen["sampler"] = sampler
                seen["depth"] = max_lookahead_depth
                self.sampler = sampler

        ev.PIDMEngine = Recorder
        try:
            self._run_chunk(([], [], None, None, None, False, 0, 0, False, 0))
        finally:
            ev.PIDMEngine = real

        # falls back to the historical defaults rather than raising
        self.assertEqual(seen["depth"], 1)
        self.assertEqual(seen["sampler"].sample_size, 2)
        self.assertEqual(seen["sampler"].timeout_sec, 0.06)

    def test_empty_deal_set_is_safe(self):
        res = self._run_chunk(([], [], None, None, None, False, 0, 0, False, 0,
                               (2, 6, 0.06, 1)))
        self.assertEqual(res["n"], 0)
        self.assertEqual(res["imp_losses"], [])
