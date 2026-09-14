#!/usr/bin/env python3
"""Split brill.dsl's misses into actionable classes and name the failing condition.

    python3 research/brill_miss_classify.py --from-cache /tmp/brill_live.json

`brill_live_check.py` says HOW OFTEN brill.dsl disagrees with Brill. It does
not say what to do about it, because it lumps three very different failures
into one "miss":

  NO_RULE           brill.dsl has no rule bidding that call at that position
                    at all. Either the row was dropped in translation, or the
                    position was never captured.

  CONTEXT_MISMATCH  a rule bidding that call exists, but its auction-context
                    conditions do not hold — it belongs to a different
                    auction. Not fixable at the rule: the position is wrong.

  EMITTED_NOT_FIRED a rule for this exact call and auction exists and its
                    auction conditions hold, but a HAND condition failed.
                    This is the only class that is a translation bug: we
                    emitted a rule that is stricter than Brill's. Dropping
                    clauses during conversion can only ever remove rules, so
                    a rule that fires too rarely was mistranslated, not
                    dropped.

Only the last class is directly repairable, and this script prints the exact
`key op value` that failed, counted — which is the fix list.

Why this matters (status.md 6.46): EMITTED_NOT_FIRED was 239 of 750 misses,
i.e. a third of the gap is our own mistranslation rather than Brill's
untranslatable engine verdicts.
"""
import argparse
import json
import os
import sys
from collections import Counter, defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, ".."))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, HERE)

from bid.eval_vs_dds import load_decision_net_dsl                    # noqa: E402
from bid.features import BridgeFeatures                              # noqa: E402
from bid.models import Seat                                          # noqa: E402
from bid.scoring import Vulnerability                                # noqa: E402
from brill_live_check import (parse_calls, norm, _pbn_hand, _seat,     # noqa: E402
                              blocker_atoms)

# Features that describe the auction rather than the hand. A rule whose
# auction part holds and whose hand part fails is a mistranslation.
AUCTION_KEYS = {
    "is_opening", "partner_last_call", "my_last_call", "opp_last_call",
    "last_bid_level", "last_bid_strain", "last_bid_seat",
    "passes_since_last_bid", "auction_len", "partner_opened",
    "opponents_bid", "is_competitive", "is_balancing",
}


def classify(net, cache, min_count=1):
    rules = net.rules
    by_call = defaultdict(list)
    for r in rules:
        by_call[norm(r.call)].append(r)

    tally = Counter()
    fails = Counter()            # (key, op, value) -> n
    fail_by_pos = defaultdict(Counter)
    examples = {}
    bug_fails = Counter()        # fails only where Brill's clause WAS translatable
    bug_pos = defaultdict(Counter)

    for key, got in cache.items():
        if not got or not got.get("bid"):
            continue
        ctx, seat_s, pbn = key.split("|")
        want = norm(got["bid"])
        hist = parse_calls(ctx)
        if hist is None:
            continue
        hand = _pbn_hand(pbn)
        feats = BridgeFeatures.extract_all(hand, hist, _seat(seat_s),
                                           Seat.NORTH, Vulnerability.NONE)
        acts = [norm(a) for a in net.actions(hand, hist, _seat(seat_s),
                                             Seat.NORTH, Vulnerability.NONE)]
        tally["compared"] += 1
        if want in acts:
            tally["hit"] += 1
            continue
        tally["miss"] += 1

        cands = by_call.get(want, [])
        if not cands:
            tally["NO_RULE"] += 1
            examples.setdefault(("NO_RULE", ctx, want), got.get("requires", ""))
            continue

        reached = False
        failing = []
        for r in cands:
            ctx_ok = True
            bad = []
            for c in r.conditions:
                if c.key in AUCTION_KEYS:
                    if not c.evaluate(feats):
                        ctx_ok = False
                        break
                elif not c.evaluate(feats):
                    bad.append(c)
            if not ctx_ok:
                continue
            reached = True
            for c in bad:
                triple = (c.key, c.op, str(c.value))
                failing.append(triple)
                fails[triple] += 1
                fail_by_pos[ctx or "*"][triple] += 1
        if not reached:
            tally["CONTEXT_MISMATCH"] += 1
            examples.setdefault(("CONTEXT_MISMATCH", ctx, want),
                                got.get("requires", ""))
            continue

        # A rule for this call and auction exists, yet Brill bid it and we
        # did not. Two very different reasons:
        #   * Brill fired one of the disjuncts we DROPPED (an engine verdict).
        #     Nothing to fix here — it is the verdict wall in disguise.
        #   * Brill's own explanation uses only atoms we CAN translate, so
        #     our rule is simply stricter than Brill's. That is a real bug.
        if blocker_atoms(got.get("requires", "")):
            tally["ENF_DROPPED_CLAUSE"] += 1
            examples.setdefault(("ENF_DROPPED_CLAUSE", ctx, want),
                                got.get("requires", ""))
        else:
            tally["ENF_TRUE_BUG"] += 1
            examples.setdefault(("ENF_TRUE_BUG", ctx, want),
                                got.get("requires", ""))
            for triple in set(failing):
                bug_fails[triple] += 1
                bug_pos[ctx or "*"][triple] += 1
    return tally, fails, fail_by_pos, examples, bug_fails, bug_pos


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--from-cache", default="/tmp/brill_live.json")
    ap.add_argument("--dsl", default=os.path.join(REPO, "system", "brill.dsl"))
    ap.add_argument("--top", type=int, default=25)
    ap.add_argument("--positions", type=int, default=10,
                    help="how many worst positions to detail")
    args = ap.parse_args()

    net = load_decision_net_dsl(args.dsl)
    cache = json.load(open(args.from_cache))
    print(f"{len(net.rules)} rules | {len(cache)} cached bids")

    (tally, fails, fail_by_pos, examples,
     bug_fails, bug_pos) = classify(net, cache)
    n = max(1, tally["compared"])
    print(f"\ncomparisons        : {tally['compared']}")
    print(f"  agree            : {tally['hit']} ({100*tally['hit']/n:.1f}%)")
    print(f"  miss             : {tally['miss']} ({100*tally['miss']/n:.1f}%)")
    m = max(1, tally["miss"])
    for k in ("NO_RULE", "CONTEXT_MISMATCH", "ENF_DROPPED_CLAUSE",
              "ENF_TRUE_BUG"):
        print(f"    {k:18s} {tally[k]:5d}  ({100*tally[k]/m:.1f}% of misses)")

    print(f"\nall EMITTED_NOT_FIRED failures (top {args.top}) — "
          f"mixed, mostly dropped disjuncts:")
    for (k, op, v), c in fails.most_common(args.top):
        print(f"    {k:22s} {op:3s} {v:10s} {c:4d}")

    print(f"\nTRUE BUGS only (Brill's clause was translatable, ours was "
          f"stricter) — top {args.top}:")
    if bug_fails:
        for (k, op, v), c in bug_fails.most_common(args.top):
            print(f"    {k:22s} {op:3s} {v:10s} {c:4d}")
    else:
        print("    (none)")

    print(f"\nworst {args.positions} positions by failed-condition count:")
    ranked = sorted(fail_by_pos.items(),
                    key=lambda kv: -sum(kv[1].values()))
    for pos, c in ranked[:args.positions]:
        print(f"  {pos:14s} {sum(c.values()):4d} failed   "
              f"{', '.join(f'{k}{op}{v}x{n}' for (k, op, v), n in c.most_common(3))}")

    if bug_pos:
        print(f"\ntrue-bug positions (top {args.positions}):")
        for pos, c in sorted(bug_pos.items(),
                             key=lambda kv: -sum(kv[1].values()))[:args.positions]:
            print(f"  {pos:14s} {sum(c.values()):4d} failed   "
                  f"{', '.join(f'{k}{op}{v}x{n}' for (k, op, v), n in c.most_common(3))}")

    print("\nsample Brill `requires` for each class (first of each):")
    for cls in ("NO_RULE", "CONTEXT_MISMATCH", "ENF_DROPPED_CLAUSE",
                "ENF_TRUE_BUG"):
        for (c, ctx, want), req in examples.items():
            if c != cls:
                continue
            print(f"  [{cls}] {ctx or '*':14s} want={want:4s} {req[:110]}")
            break


if __name__ == "__main__":
    main()
