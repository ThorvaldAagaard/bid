#!/usr/bin/env python3
"""What is system/brill.dsl actually WORTH, measured against double-dummy par?

    python3 research/brill_dsl_value.py --boards 100
    python3 research/brill_dsl_value.py --boards 200 --jobs 4

WHY THIS EXISTS
---------------
Everything measured about brill.dsl so far has been *agreement*: does it make
the same call Brill's engine makes (`research/brill_live_check.py`, 71.1%).
That number says nothing about whether the converted system is any good, and
§6.54 already showed the two are different currencies — the biggest recovered
atom bought ~0 fidelity because its clause almost never fires.

This scores brill.dsl the way every other system in the repo is scored: play
full auctions, take the final contract, score it with native DDS, compare to
par. That is the §6.48 route past the "agreement" wall.

THE FINDING THIS WAS BUILT TO CHECK
-----------------------------------
brill.dsl is a *first-call-only* system. All 1,932 rules carry
``my_last_call == 'NONE'``, so once a hand has bid, no rule can match and the
DecisionNet default (PASS) takes over. Auctions therefore die after one round
and boards get passed out at par-7N. The file header calls this "underbid
rather than overbid, which is the safe direction" — that assumption is
exactly what this script measures.

`--hybrid` isolates whether the *part that did convert* has value: use
brill.dsl wherever any of its positive rules match, and a working repo system
everywhere else. If the hybrid beats the fallback alone, Brill's opening logic
is worth having and the gap is a capture-depth problem. If it does not, the
conversion is not a system, and no amount of atom recovery will make it one.

Resolution: BOARD_IMP_LOSS_SD is 4.0 IMP/board, so se = 4/sqrt(n) —
100 boards resolves ~0.78 IMP/board, 400 resolves ~0.39.
"""
import argparse
import json
import os
import random
import sys
import time
from typing import Any, Dict, List

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.arena import BiddingArena                                # noqa: E402
from bid.decision_net import DecisionNet                          # noqa: E402
from bid.eval_vs_dds import (BOARD_IMP_LOSS_SD, build_deals,     # noqa: E402
                             imp_diff, imp_loss, load_decision_net_dsl,
                             paired_imp_test, precompute, resolution_of,
                             seed_board)
from bid.features import BridgeFeatures                          # noqa: E402
from bid.models import Seat                                      # noqa: E402

SYSTEM_DIR = os.path.join(REPO, "system")


class FallbackNet:
    """Use `primary` where any of its positive rules match, else `fallback`.

    The distinction that matters: a system that legitimately chooses PASS is
    NOT the same as a system with no rule for the position. brill.dsl's
    default when nothing matches is also PASS, so a naive "fall back whenever
    it passes" would replace Brill's disciplined passes with the fallback's
    bids. Instead we test rule matching directly and only defer on a genuine
    miss.

    Duck-types DecisionNet as far as the arena is concerned: `actions()` is
    the only method `PIDMEngine.decide` calls.
    """

    def __init__(self, primary: DecisionNet, fallback: DecisionNet,
                 name: str = ""):
        self.primary = primary
        self.fallback = fallback
        self.name = name or "hybrid(%s->%s)" % (
            getattr(primary, "name", "?"), getattr(fallback, "name", "?"))
        # Coverage instrumentation: how much of a real auction can `primary`
        # actually call? This is the number fidelity hides.
        self.hits = 0
        self.misses = 0
        self.miss_by_turn: Dict[int, int] = {}      # hand's Nth turn -> misses

    @property
    def rules(self):
        return list(self.primary.rules) + list(self.fallback.rules)

    def actions(self, hand, history, my_seat, dealer, vuln):
        features = BridgeFeatures.extract_all(hand, history, my_seat,
                                              dealer, vuln)
        matched = any(r.matches(features) and not r.is_negative
                      for r in self.primary.rules)
        turn = sum(1 for j in range(len(history))
                   if (int(dealer) + j) % 4 == int(my_seat))
        if matched:
            self.hits += 1
            return self.primary.actions(hand, history, my_seat, dealer, vuln)
        self.misses += 1
        self.miss_by_turn[turn] = self.miss_by_turn.get(turn, 0) + 1
        return self.fallback.actions(hand, history, my_seat, dealer, vuln)

    def coverage(self) -> str:
        total = self.hits + self.misses
        if not total:
            return "n/a"
        pct = 100.0 * self.hits / total
        by_turn = ", ".join(
            "%s call: %d missed" % (("1st", "2nd", "3rd", "4th",
                                     "5th", "6th")[k] if k < 6
                                    else "%dth" % (k + 1), v)
            for k, v in sorted(self.miss_by_turn.items()))
        return "%.1f%% of %d decisions (%s)" % (pct, total, by_turn)


def auction_coverage(net: DecisionNet, deal, history, dealer, vuln) -> tuple:
    """Of the calls ACTUALLY made in `history`, how many could `net` make?

    Needed because `PIDMEngine.decide` calls `actions()` far more often than
    there are calls in an auction — it searches the candidate frontier and
    looks ahead, and the sampler draws opponent worlds. Counting inside the
    wrapper therefore measures PIDM's *consultation* pattern (37 `actions()`
    calls per board, vs ~8 real calls), not the system's reach. This replays
    the finished auction and asks the question once per real decision.
    """
    hits = 0
    miss_by_turn: Dict[int, int] = {}
    for j, _call in enumerate(history):
        seat = Seat((int(dealer) + j) % 4)
        feats = BridgeFeatures.extract_all(deal.hands[seat], list(history[:j]),
                                           seat, dealer, vuln)
        if any(r.matches(feats) and not r.is_negative for r in net.rules):
            hits += 1
        else:
            turn = sum(1 for k in range(j) if (int(dealer) + k) % 4 == int(seat))
            miss_by_turn[turn] = miss_by_turn.get(turn, 0) + 1
    return hits, len(history), miss_by_turn


def first_call_only(net: DecisionNet) -> bool:
    """True when every rule in `net` requires the hand to be unbidden."""
    keys = [c.key for r in net.rules for c in r.conditions]
    return "my_last_call" in keys and all(
        any(c.key == "my_last_call" and str(c.value) == "NONE"
            for c in r.conditions)
        for r in net.rules)


def evaluate(arena, name, net, deals, dd_data, seed):
    """Score one system. Returns per-board signed IMP diffs (higher = better)."""
    diffs, losses, auctions, passed = [], [], [], []
    for i, deal in enumerate(deals):
        par_score, _par_contract, _dd = dd_data[i]
        seed_board(seed, i)
        history, score = arena.play_board(deal, net, net)
        diffs.append(imp_diff(score, par_score))
        losses.append(imp_loss(score, par_score))
        auctions.append(" ".join(str(c) for c in history))
        passed.append(not any(str(c) != "PASS" for c in history))
    n = len(deals)
    return {"name": name, "mean_imp_diff": sum(diffs) / n,
            "mean_imp_loss": sum(losses) / n,
            "passed_out": sum(passed), "imp_losses": losses,
            "imp_diffs": diffs, "auctions": auctions, "passed": passed}


def paired(base: List[float], cand: List[float],
           higher_is_better: bool) -> Dict[str, float]:
    """Paired per-board test. POSITIVE mean_diff == candidate better.

    Deliberately explicit about direction, because the two metrics used here
    point opposite ways: `imp_loss` is an absolute deviation (lower better),
    `imp_diff` is signed (higher better). Getting the sign wrong is exactly
    the mistake §6.28 exists to prevent.
    """
    n = min(len(base), len(cand))
    if n < 2:
        return {"n": n, "mean_diff": 0.0, "se": 0.0, "t": 0.0,
                "ci_lo": 0.0, "ci_hi": 0.0}
    d = [cand[i] - base[i] for i in range(n)] if higher_is_better \
        else [base[i] - cand[i] for i in range(n)]
    mean = sum(d) / n
    var = sum((x - mean) ** 2 for x in d) / (n - 1)
    sd = var ** 0.5
    se = sd / (n ** 0.5)
    return {"n": n, "mean_diff": mean, "se": se,
            "t": (mean / se) if se else 0.0,
            "ci_lo": mean - 1.96 * se, "ci_hi": mean + 1.96 * se}


def pass_out_cost(res: Dict[str, Any]) -> str:
    """IMP/board on boards this system passed out vs the rest.

    Separates "the system is thin" from "the system is wrong": a pass-out is
    a structural failure, and it is worth knowing how much of the deficit is
    those boards alone.
    """
    diffs = res["imp_diffs"]
    out = [d for d, p in zip(diffs, res["passed"]) if p]
    rest = [d for d, p in zip(diffs, res["passed"]) if not p]
    if not out:
        return "no boards passed out"
    return ("%d passed-out boards: %+.2f IMP/board | %d others: %+.2f"
            % (len(out), sum(out) / len(out), len(rest),
               sum(rest) / len(rest) if rest else 0.0))


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--boards", type=int, default=100)
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument("--fallback", default="champion_system",
                    help="repo system used where brill.dsl has no rule")
    ap.add_argument("--show", type=int, default=0,
                    help="print this many auctions per system")
    ap.add_argument("--out", help="dump per-board results to this JSON file")
    ap.add_argument("--coverage-only", action="store_true",
                    help="skip DDS par; just measure what fraction of real "
                         "decisions brill.dsl has a rule for (fast)")
    args = ap.parse_args()

    deals = build_deals(args.boards, seed=args.seed, include_stratified=False)
    print("boards: %d (seed %d) | resolution ~%.2f IMP/board"
          % (len(deals), args.seed, resolution_of(len(deals))))

    brill = load_decision_net_dsl(os.path.join(SYSTEM_DIR, "brill.dsl"))
    fb = load_decision_net_dsl(
        os.path.join(SYSTEM_DIR, "%s.dsl" % args.fallback))
    brill.name = "brill.dsl"
    fb.name = args.fallback

    if first_call_only(brill):
        print("NOTE: brill.dsl is first-call-only (every rule requires "
              "my_last_call == 'NONE') -> auctions cannot continue past one "
              "round on any seat.")

    if args.coverage_only:
        # No par needed: coverage is a property of the auctions alone.
        # Measured on the calls actually made (see auction_coverage), with the
        # wrapper's own counter reported alongside as a cross-check.
        hybrid = FallbackNet(brill, fb, "hybrid")
        arena = BiddingArena()
        t0 = time.time()
        hits = total = 0
        by_turn: Dict[int, int] = {}
        for i, deal in enumerate(deals):
            seed_board(args.seed, i)
            hist, _score = arena.play_board(deal, hybrid, hybrid)
            h, t, bt = auction_coverage(brill, deal, hist, deal.dealer,
                                        deal.vuln)
            hits += h
            total += t
            for k, v in bt.items():
                by_turn[k] = by_turn.get(k, 0) + v
        print("\ncoverage over %d boards (%.1fs)" % (len(deals),
                                                     time.time() - t0))
        print("  calls actually made : %d" % total)
        print("  brill.dsl could make: %d (%.1f%%)"
              % (hits, 100.0 * hits / total if total else 0.0))
        print("  misses by the hand's Nth turn: %s"
              % ", ".join("%s=%d" % (k + 1, v) for k, v in sorted(by_turn.items())))
        print("  cross-check, PIDM's own actions() calls: %s" % hybrid.coverage())
        return 0

    systems = [
        ("brill.dsl", brill),
        (args.fallback, fb),
        ("hybrid brill->%s" % args.fallback,
         FallbackNet(brill, fb, "hybrid brill->%s" % args.fallback)),
    ]

    t0 = time.time()
    arena = BiddingArena()
    dd_data = precompute(deals)
    print("par computed in %.1fs" % (time.time() - t0))

    results = []
    for name, net in systems:
        t = time.time()
        res = evaluate(arena, name, net, deals, dd_data, args.seed)
        res["rules"] = len(getattr(net, "rules", []) or [])
        results.append(res)
        print("\n%-28s %5d rules  mean_imp_diff %+6.2f  |imp| %5.2f  "
              "passed_out %3d/%d  (%.1fs)"
              % (name, res["rules"], res["mean_imp_diff"],
                 res["mean_imp_loss"], res["passed_out"], len(deals),
                 time.time() - t))
        if args.show:
            for a in res["auctions"][:args.show]:
                print("      %s" % a)
        if isinstance(net, FallbackNet):
            print("      coverage: brill.dsl had a rule for %s"
                  % net.coverage())

    base = results[0]
    # BOTH metrics, because they disagree and the disagreement is the point:
    # imp_loss is an absolute deviation from par (§6.28: 55% of it is
    # out-performing par), imp_diff is signed. brill.dsl underbids, so it is
    # far from par (bad on the abs metric) while landing at a similar signed
    # total (it also avoids overbidding). Report both or the story is wrong.
    print("\n--- paired vs brill.dsl (positive = other better) ---")
    print("  %-28s %18s %18s" % ("", "abs dev from par", "signed vs par"))
    for res in results[1:]:
        a = paired(base["imp_losses"], res["imp_losses"], False)
        s = paired(base["imp_diffs"], res["imp_diffs"], True)
        print("  %-28s %+7.2f (t %5.2f) %+10.2f (t %5.2f)" % (
            res["name"], a["mean_diff"], a["t"], s["mean_diff"], s["t"]))
        print("  %-28s   CI [%+.2f,%+.2f]    CI [%+.2f,%+.2f]" % (
            "", a["ci_lo"], a["ci_hi"], s["ci_lo"], s["ci_hi"]))

    print("\n--- where brill.dsl's deficit comes from ---")
    for res in results:
        print("  %-28s %s" % (res["name"], pass_out_cost(res)))

    if args.out:
        with open(args.out, "w") as fh:
            json.dump([{k: v for k, v in r.items() if k != "auctions"}
                       for r in results], fh, indent=1)
        print("\nwrote %s" % args.out)

    print("\nsd assumption %.1f IMP/board -> to resolve 1.0 IMP/board needs "
          "%d boards" % (BOARD_IMP_LOSS_SD,
                         int((1.96 * BOARD_IMP_LOSS_SD / 1.0) ** 2)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
