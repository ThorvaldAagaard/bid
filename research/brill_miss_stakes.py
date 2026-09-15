#!/usr/bin/env python3
"""WHERE does the distilled system disagree with Brill, and does it matter?

    python3 research/brill_miss_stakes.py --traces data/brill_traces_huge.jsonl

WHY
---
§6.64 established that fidelity and IMP have separated: on identical data a
depth-12 model is the better model of Brill (81.1% vs 80.3%) and the worse
player (-0.80 vs -0.10). So "raise agreement with Brill" is the wrong
objective, and the obvious repair is to ask *which* disagreements cost
anything.

Roughly 20% of positions are mispredicted. If they are spread evenly the
residual is irreducible noise and no reweighting will help. If they are
concentrated on game- and slam-level decisions -- where a single call is
worth 6-13 IMP -- then a training objective weighted by stakes should beat
plain agreement, cheaply, without any new data.

This measures the concentration. It reports held-out agreement bucketed by:

  * **the level of Brill's call** (PASS / 1 / 2 / 3 / 4+),
  * **how deep the auction already is** (opening vs later rounds),

and, for each bucket, how many traces it has and how much of the total
disagreement mass it carries.

SPLIT IS BY DEAL, NOT BY TRACE
------------------------------
`brill_distill.py` shuffles traces, so several calls from one board can land
in both train and test. That is mild leakage and makes its CV figure slightly
optimistic as an estimate of performance on unseen *boards*. Here the split
is by deal, so no board appears on both sides.
"""
import argparse
import json
import os
import random
import sys
from collections import Counter
from typing import Any, Dict, List, Tuple

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition  # noqa: E402
from bid.learner import ID3DecisionTree, id3_tree_to_rules    # noqa: E402

from brill_distill import featurise, group_key, guard_for, key_label  # noqa: E402


def call_level(call: Any) -> str:
    """Bucket a call by how much is at stake: level of a suit/NT bid."""
    s = str(call).strip()
    if s in ("PASS", "X", "XX"):
        return s
    if s and s[0].isdigit():
        return "level %s" % s[0] if s[0] in "123" else "level 4+"
    return "other"


def auction_stage(n_calls: int) -> str:
    if n_calls <= 1:
        return "opening (0-1)"
    if n_calls <= 3:
        return "early (2-3)"
    if n_calls <= 5:
        return "middle (4-5)"
    return "late (6+)"


def build(X, y, group="opening", max_depth=10, min_samples=25) -> DecisionNet:
    """The production fit, minus the CLI."""
    net = DecisionNet("probe")
    groups: Dict[Any, Tuple[List[Dict[str, Any]], List[Any]]] = {}
    for x, yy in zip(X, y):
        k = group_key(x, group)
        gx, gy = groups.setdefault(k, ([], []))
        gx.append(x)
        gy.append(yy)
    for k in sorted(groups, key=lambda v: (isinstance(v, str), v)):
        gx, gy = groups[k]
        maj = Counter(gy).most_common(1)[0][0]
        guard = guard_for(k, group)
        if len(gx) < min_samples or len(set(map(str, gy))) < 2:
            conds = [RuleCondition(c.key, c.op, c.value)
                     for r in guard for c in r.conditions]
            net.add_rule(DecisionNetRule(
                "BD_%s_maj" % key_label(k), maj, conds, priority=1,
                description="majority (n=%d)" % len(gx)))
            continue
        tree = ID3DecisionTree(max_depth=max_depth)
        tree.fit(gx, gy)
        for rule in id3_tree_to_rules(tree, guard, "BD_%s" % key_label(k),
                                      base_priority=10,
                                      description="stakes probe"):
            net.add_rule(rule)
    return net


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--traces", default=os.path.join("data",
                                                     "brill_traces_huge.jsonl"))
    ap.add_argument("--max-depth", type=int, default=10)
    ap.add_argument("--holdout", type=float, default=0.2)
    ap.add_argument("--seed", type=int, default=0)
    args = ap.parse_args()

    rows = [json.loads(l) for l in open(args.traces) if l.strip()]
    X, y, skipped, ctxs = featurise(rows)
    print("traces %d | featurised %d | skipped %d" % (len(rows), len(X),
                                                      len(skipped)))
    if len(rows) != len(X):
        print("WARNING: %d rows skipped; deal-level split may be misaligned "
              "with X" % len(skipped))

    # Split by DEAL so no board appears on both sides.
    by_deal: Dict[str, List[int]] = {}
    for i, r in enumerate(rows):
        by_deal.setdefault(r.get("deal", ""), []).append(i)
    deal_ids = sorted(by_deal)
    random.Random(args.seed).shuffle(deal_ids)
    cut = int(len(deal_ids) * (1 - args.holdout))
    hold = set(deal_ids[cut:])
    va = sorted(i for d in hold for i in by_deal[d] if i < len(X))
    va_set = set(va)
    tr = [i for i in range(len(X)) if i not in va_set]
    print("train %d | held out %d  (split by deal: %d deals, %d held out)"
          % (len(tr), len(va), len(deal_ids), len(hold)))

    net = build([X[i] for i in tr], [y[i] for i in tr],
                max_depth=args.max_depth)

    def bucket_report(name, keyfn):
        tot: Counter = Counter()
        ok: Counter = Counter()
        for i in va:
            pred = net.actions(*ctxs[i])
            p = pred[0] if pred else None
            k = keyfn(i)
            tot[k] += 1
            if p is not None and str(p) == str(y[i]):
                ok[k] += 1
        n = sum(tot.values())
        hits = sum(ok.values())
        total_miss = n - hits
        print("\n--- by %s ---  overall held-out agreement %.1f%% (n=%d)"
              % (name, 100.0 * hits / max(n, 1), n))
        print("  %-14s %7s %8s %11s" % ("bucket", "n", "agree", "miss mass"))
        for k in sorted(tot, key=lambda v: -tot[v]):
            miss = tot[k] - ok[k]
            print("  %-14s %7d %7.1f%% %10.1f%%"
                  % (k, tot[k], 100.0 * ok[k] / tot[k],
                     100.0 * miss / max(total_miss, 1)))

    bucket_report("level of Brill's call", lambda i: call_level(y[i]))
    bucket_report("auction depth",
                  lambda i: auction_stage(
                      len([c for c in (rows[i].get("ctx") or "").split("-")
                           if c])))
    return 0


if __name__ == "__main__":
    sys.exit(main())
