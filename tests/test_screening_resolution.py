"""The screening-resolution constants added after the §6.16 calibration.

The point of these is that the flywheel must be able to say "this gain is
smaller than the measurement can see" instead of treating every non-negative
validation delta as a validated improvement.
"""
import math
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from bid.eval_vs_dds import (SCREENING_NOISE_SD, min_detectable_effect,
                             MIN_DELTA_BY_METRIC, BOARD_IMP_LOSS_SD,
                             paired_imp_test, boards_needed, resolution_of,
                             seed_board, imp_loss, imp_diff, LOWER_IS_BETTER)
from bid.flywheel import Flywheel, VAL_SEEDS, STATE_PATH


class TestSignedImpMetric(unittest.TestCase):
    """§6.28: imp_loss is abs(), so it cannot tell winning from losing. 54.9% of
    the reported 'loss' was actually out-performing par."""

    def test_imp_loss_is_absolute(self):
        """The defect, pinned: beating par scores identically to missing it."""
        self.assertEqual(imp_loss(500, 0), imp_loss(-500, 0))

    def test_imp_diff_preserves_sign(self):
        self.assertGreater(imp_diff(500, 0), 0)    # beat par
        self.assertLess(imp_diff(-500, 0), 0)      # lost to par

    def test_imp_diff_zero_at_par(self):
        self.assertEqual(imp_diff(0, 0), 0)

    def test_signed_is_not_lower_is_better(self):
        """Higher is better for the signed metric. If it were added to
        LOWER_IS_BETTER the flywheel would hill-climb in the wrong direction."""
        self.assertNotIn("mean_imp_diff", LOWER_IS_BETTER)
        self.assertIn("mean_imp_loss", LOWER_IS_BETTER)

    def test_signed_has_an_acceptance_floor(self):
        self.assertIn("mean_imp_diff", MIN_DELTA_BY_METRIC)

    def test_signed_noise_is_calibrated_and_larger(self):
        """§6.28: the signed metric swings more across deal sets (its level
        depends on how many boards are 'E/W declares par'), so its noise sd is
        LARGER than the abs metric's. Anyone switching metrics must not assume
        the same tolerance applies."""
        self.assertIn("mean_imp_diff", SCREENING_NOISE_SD)
        self.assertGreater(SCREENING_NOISE_SD["mean_imp_diff"],
                           SCREENING_NOISE_SD["mean_imp_loss"])

    def test_uncalibrated_metric_still_reports_inf(self):
        self.assertEqual(min_detectable_effect(4, "avg_score"), float("inf"))


class TestPerBoardSeeding(unittest.TestCase):
    """§6.26: the world sampler drew from an unseeded global RNG, so two runs
    of the same configuration disagreed (measured: 0.0123 IMP/board between two
    identical 818-board runs). Boards must be seeded by index."""

    def setUp(self):
        # These tests reseed and consume the GLOBAL `random` module. Leaving it
        # in a new state silently changes the worlds drawn by any later test
        # that evaluates without a seed — which is exactly how one downstream
        # assertion started comparing two things that had become equal.
        import random as _r
        self._rng = _r
        self._rng_state = _r.getstate()

    def tearDown(self):
        self._rng.setstate(self._rng_state)

    def test_same_board_gets_same_worlds(self):
        """The actual defect: two calls to the sampler differed."""
        import random
        from bid.sampling import Deal
        from bid.models import Seat
        deal = Deal.random_deal(dealer=Seat.NORTH)
        hand = deal.hands[Seat.SOUTH]

        def sample():
            d = Deal.completion_from_known(Seat.SOUTH, hand, deal.dealer, deal.vuln)
            return sorted(str(c) for c in d.hands[Seat.EAST].cards)

        seed_board(99, 7)
        first = sample()
        seed_board(99, 7)
        self.assertEqual(first, sample())

    def test_different_boards_get_different_worlds(self):
        import random
        from bid.sampling import Deal
        from bid.models import Seat
        deal = Deal.random_deal(dealer=Seat.NORTH)
        hand = deal.hands[Seat.SOUTH]

        def sample():
            d = Deal.completion_from_known(Seat.SOUTH, hand, deal.dealer, deal.vuln)
            return sorted(str(c) for c in d.hands[Seat.EAST].cards)

        seed_board(99, 1)
        a = sample()
        seed_board(99, 2)
        self.assertNotEqual(a, sample())

    def test_seed_none_is_a_no_op(self):
        """Callers that pass no seed keep the previous behaviour."""
        import random
        random.seed(1234)
        before = random.random()
        random.seed(1234)
        seed_board(None, 0)
        self.assertEqual(before, random.random())

    def test_index_is_global_not_chunk_local(self):
        """Board 0 of chunk 2 must not replay board 0 of chunk 1."""
        import random

        def state_after(seed, idx):
            random.seed(0)
            seed_board(seed, idx)
            return random.random()

        self.assertNotEqual(state_after(5, 0), state_after(5, 100))


class TestMinDetectableEffect(unittest.TestCase):
    def test_calibrated_metric_scales_with_set_count(self):
        one = min_detectable_effect(1, "mean_imp_loss")
        four = min_detectable_effect(4, "mean_imp_loss")
        self.assertAlmostEqual(four, one / 2.0, places=6)

    def test_matches_the_published_figure(self):
        """2 validation sets is the flywheel default; reproduce its resolution."""
        mde = min_detectable_effect(2, "mean_imp_loss")
        expected = 1.96 * SCREENING_NOISE_SD["mean_imp_loss"] / math.sqrt(2)
        self.assertAlmostEqual(mde, expected, places=6)
        self.assertGreater(mde, 0.5)

    def test_uncalibrated_metric_never_looks_resolvable(self):
        """An unmeasured metric must not silently pass as significant."""
        self.assertEqual(min_detectable_effect(2, "avg_score"), float("inf"))
        self.assertEqual(min_detectable_effect(99, "avg_score"), float("inf"))

    def test_zero_sets_is_infinite(self):
        self.assertEqual(min_detectable_effect(0, "mean_imp_loss"), float("inf"))

    def test_more_sets_always_helps(self):
        prev = float("inf")
        for n in (1, 2, 4, 8, 16, 64):
            cur = min_detectable_effect(n, "mean_imp_loss")
            self.assertLess(cur, prev)
            prev = cur


class TestFloorVersusNoise(unittest.TestCase):
    """The documented relationship: the acceptance floor is far below noise.

    If someone 'fixes' this by raising MIN_DELTA_BY_METRIC to the noise level,
    the train-set gate stops being an effect-size filter and starts rejecting
    every real but small change. This test documents the gap, it does not
    assert that either number is wrong.
    """

    def test_effect_floor_is_below_screening_noise(self):
        floor = MIN_DELTA_BY_METRIC["mean_imp_loss"]
        noise = SCREENING_NOISE_SD["mean_imp_loss"]
        self.assertLess(floor, noise / 10.0)

    def test_two_val_sets_cannot_resolve_a_floor_sized_gain(self):
        floor = MIN_DELTA_BY_METRIC["mean_imp_loss"]
        self.assertGreater(min_detectable_effect(2, "mean_imp_loss"), floor * 10)

    def test_resolving_a_floor_sized_gain_needs_many_sets(self):
        """Sanity anchor for the 'underpowered' conclusion in §6.16."""
        floor = MIN_DELTA_BY_METRIC["mean_imp_loss"]
        n = 1
        while min_detectable_effect(n, "mean_imp_loss") > floor:
            n *= 2
            self.assertLess(n, 100000)
        # resolving 0.03 IMP/bd needs hundreds of 96-deal sets, i.e. far more
        # than the 2 the flywheel uses
        self.assertGreater(n, 200)


if __name__ == "__main__":
    unittest.main()


class TestPairedImpTest(unittest.TestCase):
    def _res(self, losses):
        return {"imp_losses": list(losses)}

    def test_sign_convention_matches_metric_gain(self):
        """Positive == candidate better, i.e. candidate loses fewer IMPs."""
        base = self._res([5.0, 5.0, 5.0, 5.0])
        better = self._res([4.0, 4.0, 4.0, 4.0])
        self.assertGreater(paired_imp_test(base, better)["mean_diff"], 0)
        self.assertLess(paired_imp_test(better, base)["mean_diff"], 0)

    def test_identical_systems_are_exactly_zero(self):
        """A no-op patch must give exactly 0, not a small positive number."""
        base = self._res([1.0, 7.0, 3.0, 9.0])
        st = paired_imp_test(base, self._res([1.0, 7.0, 3.0, 9.0]))
        self.assertEqual(st["mean_diff"], 0.0)
        self.assertEqual(st["sd"], 0.0)
        self.assertEqual(st["t"], 0.0)

    def test_paired_variance_is_lower_than_unpaired(self):
        """The whole point of pairing: shared board difficulty cancels."""
        base = self._res([0.0, 10.0, 0.0, 10.0])
        # candidate tracks base closely -> small paired variance
        cand = self._res([1.0, 11.0, 1.0, 11.0])
        self.assertLess(paired_imp_test(base, cand)["sd"], 0.5)

    def test_unpaired_noise_has_high_variance(self):
        base = self._res([0.0, 10.0, 0.0, 10.0])
        cand = self._res([10.0, 0.0, 10.0, 0.0])
        self.assertGreater(paired_imp_test(base, cand)["sd"], 5.0)

    def test_truncates_to_the_shorter_series(self):
        st = paired_imp_test(self._res([1.0, 2.0, 3.0]), self._res([2.0, 3.0]))
        self.assertEqual(st["n"], 2)

    def test_empty_input_is_safe(self):
        st = paired_imp_test({}, {})
        self.assertEqual(st["n"], 0)
        self.assertEqual(st["n_needed"], float("inf"))

    def test_ci_brackets_the_mean(self):
        base = self._res([2.0, 8.0, 3.0, 9.0, 4.0, 7.0])
        cand = self._res([1.0, 6.0, 2.0, 8.0, 3.0, 6.0])
        st = paired_imp_test(base, cand)
        self.assertLess(st["ci_lo"], st["mean_diff"])
        self.assertGreater(st["ci_hi"], st["mean_diff"])


class TestBoardsNeeded(unittest.TestCase):
    def test_matches_the_hand_formula(self):
        for target in (0.5, 0.3, 0.1):
            want = (1.96 * BOARD_IMP_LOSS_SD / target) ** 2
            self.assertAlmostEqual(boards_needed(target), want, delta=1.0)

    def test_monotone_in_target(self):
        self.assertLess(boards_needed(1.0), boards_needed(0.5))
        self.assertLess(boards_needed(0.5), boards_needed(0.1))

    def test_the_documented_budget_figure(self):
        """~6000 boards resolves 0.1 IMP/board — the affordable target."""
        self.assertGreater(boards_needed(0.1), 5000)
        self.assertLess(boards_needed(0.1), 8000)

    def test_degenerate_targets_are_flagged(self):
        self.assertEqual(boards_needed(0.0), -1)


class TestResolutionOf(unittest.TestCase):
    def test_matches_inverse_of_boards_needed(self):
        for target in (0.5, 0.3, 0.1):
            n = boards_needed(target)
            self.assertAlmostEqual(resolution_of(n), target, delta=0.01)

    def test_decreases_with_more_boards(self):
        self.assertGreater(resolution_of(96), resolution_of(768))

    def test_the_documented_default_is_too_coarse(self):
        """96 boards resolve ~0.8, far above the 0.275 gap of §6.18."""
        self.assertGreater(resolution_of(96), 0.6)
        self.assertLess(resolution_of(750), 0.3)

    def test_uncalibrated_metric_is_infinite(self):
        self.assertEqual(resolution_of(96, "avg_score"), float("inf"))

    def test_zero_boards_is_infinite(self):
        self.assertEqual(resolution_of(0), float("inf"))


class TestFlywheelConfigSurface(unittest.TestCase):
    """The §6.16/§6.18 fix is only usable if the budget is configurable."""

    def test_val_seeds_are_configurable(self):
        fw = Flywheel(None, 8, pool_cap=4, val_seeds=(7, 13, 21, 29))
        self.assertEqual(fw.val_seeds, (7, 13, 21, 29))
        self.assertEqual(sorted(fw.val_sets), [7, 13, 21, 29])

    def test_default_val_seeds_unchanged(self):
        fw = Flywheel(None, 8, pool_cap=4)
        self.assertEqual(fw.val_seeds, VAL_SEEDS)

    def test_state_path_is_redirectable(self):
        """So an experiment cannot bump the real version counter."""
        fw = Flywheel(None, 8, pool_cap=4, state_path="/tmp/scratch_state.json")
        self.assertEqual(fw.state_path, "/tmp/scratch_state.json")
        self.assertNotEqual(fw.state_path, STATE_PATH)

    def test_state_defaults_to_the_real_path(self):
        fw = Flywheel(None, 8, pool_cap=4)
        self.assertEqual(fw.state_path, STATE_PATH)
