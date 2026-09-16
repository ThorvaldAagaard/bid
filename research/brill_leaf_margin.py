#!/usr/bin/env python3
"""Move the PASS threshold of an already-fitted tree, and sweep it.

    python3 research/brill_leaf_margin.py \
        --traces data/brill_traces_final.jsonl \
        --holdout data/brill_traces_holdout555.jsonl \
        --margins 0,0.5,0.6,0.7,0.8,0.9 --out-prefix /tmp/lm

WHY
---
`research/brill_rate_bias.py` found that the distilled system bids game on
2.83% of held-out positions where remote Brill bids it on 5.39% — a net
bias of **-2.56pp, t -6.83**. Its game decisions are not inaccurate in the
sense of being random: precision is 0.694 against champion's 0.248. It is
a good discriminator with its decision threshold set far too high. That is
the classic signature of a calibration problem, and calibration has a knob.

The knob lives at the leaves. A depth-limited ID3 tree cannot resolve every
region of feature space, so it manufactures a lot of *unresolved* leaves —
55% PASS / 45% 1S, say — and majority vote then files them all under PASS.
`--pass-cap` tried to fix the resulting timidity by deleting PASS traces
before fitting and cost **-1.91 IMP/board**, because deleting traces
destroys the model's knowledge of when passing is genuinely right.

This fixes the same symptom without touching the data: keep every trace,
keep the tree, and change only which call an unresolved leaf emits. A leaf
whose PASS share is below `--margin` emits its most common non-PASS call
instead. Confident PASS leaves are never touched.

SWEEPING IS NEARLY FREE
-----------------------
Fitting on 133k traces costs ~12 minutes; recompiling a fitted tree into
rules costs seconds. So this fits ONCE and exports one system per margin.
That is what makes a dose-response affordable — and a dose-response is the
only honest way to run this, because a single margin that "worked" would be
indistinguishable from a lucky one.

Graded on held-out positions: agreement with Brill, the game rate, and the
net bias with its t-statistic. Agreement is expected to FALL as the margin
rises; that is the point, and it is why agreement is reported rather than
optimised.
"""
import argparse
import json
import math
import os
import sys
from collections import Counter
from typing import Any, Dict, List, Tuple

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, REPO)

from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition  # noqa: E402
from bid.learner import ID3DecisionTree, id3_tree_to_rules            # noqa: E402
from brill_distill import featurise, group_key, guard_for, key_label   # noqa: E402


def level_of(call) -> int:
    s = str(call).strip()
    return int(s[0]) if s and s[0].isdigit() else 0


def rate_stats(preds: List[Any], truth: List[Any],
               game_level: int = 4) -> Dict[str, float]:
    n = len(truth)
    agree = sum(1 for p, t in zip(preds, truth)
                if p is not None and str(p) == str(t))
    b = [1 if level_of(t) >= game_level else 0 for t in truth]
    m = [1 if level_of(p) >= game_level else 0 for p in preds]
    d = [m[i] - b[i] for i in range(n)]
    mean = sum(d) / n
    var = sum((x - mean) ** 2 for x in d) / max(n - 1, 1)
    se = math.sqrt(var / n)
    tp = sum(1 for i in range(n) if b[i] and m[i])
    return {
        "agree": 100.0 * agree / n,
        "game_rate": 100.0 * sum(m) / n,
        "bias_pp": 100.0 * mean,
        "t": (mean / se) if se > 0 else 0.0,
        "recall": tp / max(sum(b), 1),
        "precision": tp / max(sum(m), 1),
        "pass_rate": 100.0 * sum(1 for p in preds if str(p) == "PASS") / n,
    }


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--traces", default=os.path.join("data",
                                                     "brill_traces_final.jsonl"))
    ap.add_argument("--holdout", required=True,
                    help="held-out traces the training set does not contain")
    ap.add_argument("--group", default="opening")
    ap.add_argument("--max-depth", type=int, default=10)
    ap.add_argument("--min-samples", type=int, default=25)
    ap.add_argument("--margins", default="0,0.5,0.6,0.7,0.8,0.9")
    ap.add_argument("--out-prefix", default="/tmp/lm")
    ap.add_argument("--game-level", type=int, default=4)
    args = ap.parse_args()

    margins = [float(m) for m in args.margins.split(",") if m.strip()]

    print("training set : %s" % args.traces)
    rows = [json.loads(l) for l in open(args.traces) if l.strip()]
    X, y, skipped, _ctxs = featurise(rows)
    print("  %d traces featurised (%d skipped)" % (len(X), len(skipped)))

    hrows = [json.loads(l) for l in open(args.holdout) if l.strip()]
    hX, hy, hskip, hctxs = featurise(hrows)
    print("held-out set : %s" % args.holdout)
    print("  %d traces featurised (%d skipped)" % (len(hX), len(hskip)))

    # ---- fit ONCE ------------------------------------------------------
    groups: Dict[Any, Tuple[List[Dict[str, Any]], List[Any]]] = {}
    for x, yy in zip(X, y):
        k = group_key(x, args.group)
        gx, gy = groups.setdefault(k, ([], []))
        gx.append(x)
        gy.append(yy)

    fitted: List[Tuple[Any, Any, List, Any]] = []
    print("\nfitting %d groups at depth %d ..." % (len(groups), args.max_depth),
          flush=True)
    for k in sorted(groups, key=lambda v: (isinstance(v, str), v)):
        gx, gy = groups[k]
        guard = guard_for(k, args.group)
        if len(gx) < args.min_samples or len(set(map(str, gy))) < 2:
            fitted.append((k, None, guard,
                           Counter(gy).most_common(1)[0][0]))
            continue
        tree = ID3DecisionTree(max_depth=args.max_depth)
        tree.fit(gx, gy)
        fitted.append((k, tree, guard, None))
    print("  fitted %d groups" % len(fitted), flush=True)

    def compile_net(margin: float) -> DecisionNet:
        net = DecisionNet("brill_distilled")
        for k, tree, guard, maj in fitted:
            if tree is None:
                conds = [RuleCondition(c.key, c.op, c.value)
                         for r in guard for c in r.conditions]
                net.add_rule(DecisionNetRule(
                    "BD_%s_maj" % key_label(k), maj, conds, priority=1,
                    description="majority call"))
                continue
            for r in id3_tree_to_rules(
                    tree, guard, "BD_%s" % key_label(k),
                    base_priority=10, leaf_margin=margin,
                    description="distilled from Brill /bid"):
                net.add_rule(r)
        return net

    print("\n%-8s %7s %8s %9s %10s %8s %10s %9s"
          % ("margin", "rules", "agree%", "game%", "bias(pp)", "t",
             "recall", "prec"))
    print("-" * 78)
    for m in margins:
        net = compile_net(m)
        preds = []
        for c in hctxs:
            p = net.actions(*c)
            preds.append(p[0] if p else None)
        s = rate_stats(preds, hy, args.game_level)
        print("%-8s %7d %8.1f %9.2f %10.2f %8.2f %10.3f %9.3f"
              % (m, len(net.rules), s["agree"], s["game_rate"],
                 s["bias_pp"], s["t"], s["recall"], s["precision"]),
              flush=True)
        path = "%s_%s.dsl" % (args.out_prefix, str(m).replace(".", ""))
        with open(path, "w") as fh:
            fh.write(net.export_dsl())
        print("         -> %s" % path, flush=True)

    print("\nBrill's own game rate on this held-out set: %.2f%%"
          % (100.0 * sum(1 for t in hy if level_of(t) >= args.game_level)
             / len(hy)))
    print("Brill's own PASS rate: %.2f%%"
          % (100.0 * sum(1 for t in hy if str(t) == "PASS") / len(hy)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
