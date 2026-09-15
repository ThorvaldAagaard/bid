#!/usr/bin/env python3
"""How big is Brill's authored position tree? Can we capture it deeper?

    python3 research/brill_tree_size.py --sample 12
    python3 research/brill_tree_size.py --sample 12 --cache data/brill_tree.json

WHY
---
§6.56 found `system/brill.dsl` is first-call-only: every rule requires
`my_last_call == 'NONE'`, so it can make 0% of second-and-later calls. That is
a *capture* limit — the source crawl went 2 calls deep — not a Brill limit.
Probing confirms Brill authors rules at second-call positions:

    GET /getresponses?auction=1H-P-1S-P   -> 24 rules   (North's 2nd turn)

So the data exists. The question is whether capturing enough of it is
feasible. This estimates the tree size by sampling the branching factor at
each depth and extrapolating, which bounds the cost before anyone starts a
crawl that cannot finish.

Output is an estimate, not a census: branching is position-dependent and many
branches terminate early (a pass-out ends the auction), so the extrapolation
is an UPPER bound.
"""
import argparse
import os
import random
import sys
import time
from collections import Counter

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.brill import BrillClient                                  # noqa: E402

# Auctions are joined with '-' in Brill's ctx spelling; pass is 'P'.
SEP = "-"


def children(client, ctx, rng=None, sample=None):
    """Distinct calls Brill defines at `ctx`, and how many rules it holds."""
    resp = client.get_responses(ctx)
    calls = sorted({(r.bid or "").strip() for r in resp if r.bid})
    return calls, len(resp)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--sample", type=int, default=12,
                    help="positions sampled per depth to estimate branching")
    ap.add_argument("--depth", type=int, default=5,
                    help="how deep to extrapolate")
    ap.add_argument("--cache", default="/tmp/brill_tree.json")
    ap.add_argument("--seed", type=int, default=7)
    args = ap.parse_args()

    rng = random.Random(args.seed)
    c = BrillClient(timeout=60, cache_path=args.cache, retries=4)
    t0 = time.time()

    # Depth 0 is a single position and fully enumerated. Deeper counts are
    # EXTRAPOLATED: n(d+1) = n(d) * mean_branching(d). Do not use
    # len(frontier) for this — the frontier only ever holds the children of
    # the *sampled* parents, so it understates the real width by the sampling
    # ratio and made depth 3+ look smaller than depth 2.
    frontier = [""]
    print("%-6s %-12s %-11s %-11s %s" % ("depth", "positions", "mean calls",
                                         "mean rules", "est. rules"))
    print("%-6s %-12s %-11s %-11s %s" % ("", "(extrapolated)", "at depth",
                                         "per pos", "at depth"))
    total_est = 0
    n_true = 1.0
    for depth in range(args.depth + 1):
        if not frontier:
            break
        sampled = frontier if len(frontier) <= args.sample \
            else rng.sample(frontier, args.sample)
        calls_list, rules_list = [], []
        nxt = []
        for ctx in sampled:
            calls, nrules = children(c, ctx)
            calls_list.append(len(calls))
            rules_list.append(nrules)
            for b in calls:
                nxt.append(b if not ctx else ctx + SEP + b)
        mc = sum(calls_list) / len(calls_list)
        mr = sum(rules_list) / len(rules_list)
        est = n_true * mr
        total_est += est
        print("%-6d ~%-11s %-11.1f %-11.1f %s" % (
            depth, "{:,.0f}".format(n_true), mc, mr, "{:,.0f}".format(est)))
        n_true *= mc
        frontier = nxt if depth < args.depth else []
        if len(frontier) > 4000:            # cap memory; counts are estimates
            frontier = rng.sample(frontier, 4000)

    print("\nrequests: %d in %.1fs | cumulative rule estimate through depth "
          "%d: ~%s" % (c.cache_misses, time.time() - t0, args.depth,
                       "{:,.0f}".format(total_est)))
    print("NOTE: branching is position-dependent and many branches terminate, "
          "\n      so this is an upper bound and the error compounds with "
          "depth.")
    c.flush_cache()
    return 0


if __name__ == "__main__":
    sys.exit(main())
