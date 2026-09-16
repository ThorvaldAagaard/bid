#!/usr/bin/env python3
"""Is the distilled system systematically UNDER-bidding game?

    python3 research/brill_rate_bias.py --system system/brill_distilled.dsl \
        --traces data/brill_traces_holdout.jsonl

WHY
---
§6.65 measured that agreement with Brill is 96.5% on PASS and 92.6% on
1-level calls but 22-27% on game and slam. That is usually read as "the hard
decisions are hard". But there is a second, much more actionable reading:
the model might be under-bidding game *on average*, and low agreement on
game-level calls would then be a rate bias, not an inability.

The two are indistinguishable from an accuracy number and trivially
distinguishable from a rate. If Brill bids game on 8% of positions and the
model bids game on 4%, that is a bias with an obvious knob, and it costs
real IMPs: missing a cold game is -6 to -10, while bidding one that fails
is only -3 to -5 at favourable vulnerability.

This reports, on held-out traces:

  * the call-level distribution of Brill vs the model (side by side),
  * recall/precision on "bids game or higher",
  * the net bias: (model game rate) - (Brill game rate), with an se,
  * where the two differ by how much (under/over by level).

HELD-OUT DATA IS REQUIRED
-------------------------
Grading a system on the traces it was distilled from measures memorisation.
Pass traces from boards that were not in the training set. Nothing here
checks that for you.
"""
import argparse
import json
import math
import os
import sys
from collections import Counter

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, REPO)

from bid.eval_vs_dds import load_decision_net_dsl          # noqa: E402
from brill_distill import featurise                        # noqa: E402


def level_of(call) -> int:
    """0 for PASS/X/XX, else the level of the bid."""
    s = str(call).strip()
    if s and s[0].isdigit():
        return int(s[0])
    return 0


def bucket(call) -> str:
    s = str(call).strip()
    if s in ("PASS", "X", "XX", "None"):
        return s if s != "None" else "?"
    lvl = level_of(call)
    if lvl == 0:
        return "other"
    return "L%d" % lvl if lvl <= 3 else "L4+"


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--system", default="system/brill_distilled.dsl")
    ap.add_argument("--traces", required=True)
    ap.add_argument("--game-level", type=int, default=4,
                    help="level counted as 'game' in a suit (default 4)")
    args = ap.parse_args()

    net = load_decision_net_dsl(args.system)
    rows = [json.loads(l) for l in open(args.traces) if l.strip()]
    _X, y, skipped, ctxs = featurise(rows)
    if skipped:
        print("skipped %d unfeaturisable rows" % len(skipped))

    n = len(y)
    tb: Counter = Counter()      # Brill's bucket counts
    mb: Counter = Counter()      # model's bucket counts
    agree = 0

    # Game-bid rates, treated as a paired Bernoulli: for each position we
    # know both whether Brill bid game and whether the model did.
    brill_game = []
    model_game = []

    for i in range(n):
        pred = net.actions(*ctxs[i])
        p = pred[0] if pred else None
        b = y[i]
        tb[bucket(b)] += 1
        mb[bucket(p)] += 1
        if p is not None and str(p) == str(b):
            agree += 1
        bg = level_of(b) >= args.game_level
        mg = level_of(p) >= args.game_level if p is not None else False
        brill_game.append(1 if bg else 0)
        model_game.append(1 if mg else 0)

    print("system : %s" % args.system)
    print("traces : %d held-out" % n)
    print("agreement with Brill: %.1f%%" % (100.0 * agree / max(n, 1)))
    print()

    keys = ["PASS", "X", "XX", "L1", "L2", "L3", "L4+", "other", "?"]
    keys = [k for k in keys if k in tb or k in mb]
    print("  %-7s %10s %10s %10s" % ("bucket", "Brill", "model", "diff"))
    for k in keys:
        a, b = tb[k], mb[k]
        print("  %-7s %6d %5.2f%% %6d %5.2f%% %+6.2fpp"
              % (k, a, 100.0 * a / n, b, 100.0 * b / n,
                 100.0 * (b - a) / n))

    tp = sum(1 for i in range(n) if brill_game[i] and model_game[i])
    fp = sum(1 for i in range(n) if not brill_game[i] and model_game[i])
    fn = sum(1 for i in range(n) if brill_game[i] and not model_game[i])
    prec = tp / max(tp + fp, 1)
    rec = tp / max(tp + fn, 1)

    d = [model_game[i] - brill_game[i] for i in range(n)]
    m = sum(d) / n
    var = sum((x - m) ** 2 for x in d) / max(n - 1, 1)
    se = math.sqrt(var / n)

    print()
    print("game-or-higher (level >= %d), treated as a detection problem:"
          % args.game_level)
    print("  Brill bids game on %d/%d positions (%.2f%%)"
          % (sum(brill_game), n, 100.0 * sum(brill_game) / n))
    print("  model bids game on %d/%d positions (%.2f%%)"
          % (sum(model_game), n, 100.0 * sum(model_game) / n))
    print("  precision %.3f   recall %.3f" % (prec, rec))
    print()
    print("  NET BIAS (model rate - Brill rate): %+.2f pp  se %.2f  t %+.2f"
          % (100.0 * m, 100.0 * se, (m / se) if se > 0 else 0.0))
    if abs(m / se if se > 0 else 0) >= 1.96:
        direction = "UNDER-bids" if m < 0 else "OVER-bids"
        print("  -> significant: the model systematically %s game."
              % direction)
    else:
        print("  -> not significant: no overall game-rate bias detectable.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
