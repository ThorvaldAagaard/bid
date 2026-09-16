#!/usr/bin/env python3
"""Paired difference between two `team_match.py --dump` files.

    python3 research/paired_diff.py /tmp/candidate.json /tmp/control.json

WHY
---
Every intervention in this project has to be graded on the team match, and
the team match is a *paired* design: both systems bid the same cards on the
same board. Comparing two independent means throws that away. Differencing
board by board removes the board's own difficulty from the comparison, which
is worth roughly a 5-10x reduction in the number of boards needed for the
same resolution.

Doing this by hand each time is how arithmetic mistakes get published, so
it is a script.

Both dumps must come from the same `--boards` and `--seed`. `build_deals` is
NOT prefix-stable (build_deals(50)[:50] != build_deals(100)[:50]), so two
runs that differ in board count are not comparable at all and this refuses
to difference them.

Positive mean = the FIRST file's system is better.
"""
import argparse
import json
import math
import sys


def _mean(xs):
    return sum(xs) / len(xs) if xs else 0.0


def _sd(xs):
    if len(xs) < 2:
        return 0.0
    m = _mean(xs)
    return math.sqrt(sum((x - m) ** 2 for x in xs) / (len(xs) - 1))


def _stats(xs):
    """mean, se, t for a list of per-board values."""
    n = len(xs)
    if n == 0:
        return {"n": 0, "mean": 0.0, "se": 0.0, "t": 0.0, "total": 0}
    m = _mean(xs)
    se = _sd(xs) / math.sqrt(n)
    return {"n": n, "mean": m, "se": se,
            "t": (m / se) if se > 0 else 0.0, "total": int(round(sum(xs)))}


def _fmt(name, s):
    return ("  %-14s n=%-4d mean %+7.3f  se %.3f  t %+6.2f  total %+5d%s"
            % (name, s["n"], s["mean"], s["se"], s["t"], s["total"],
               "  *" if abs(s["t"]) >= 1.96 else ""))


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("candidate")
    ap.add_argument("control")
    ap.add_argument("--verbose", action="store_true",
                    help="list the boards that moved the most")
    args = ap.parse_args()

    a = json.load(open(args.candidate))
    b = json.load(open(args.control))
    ba = a.get("boards") or []
    bb = b.get("boards") or []

    if len(ba) != len(bb):
        sys.exit("board counts differ (%d vs %d) -- these runs are not "
                 "comparable; build_deals is not prefix-stable so both must "
                 "use the same --boards and --seed"
                 % (len(ba), len(bb)))

    # Pair by board index. Both runs seed_board identically, so index i is
    # the same deal in both.
    ia = {r["board"]: r["imp"] for r in ba}
    ib = {r["board"]: r["imp"] for r in bb}
    common = sorted(set(ia) & set(ib))
    if len(common) != len(ba):
        sys.exit("only %d of %d board indices match" % (len(common), len(ba)))

    diffs = [ia[i] - ib[i] for i in common]
    cont = {r["board"]: bool(r.get("contested")) for r in ba}

    print("candidate: %s" % args.candidate)
    print("control  : %s" % args.control)
    print("boards   : %d (paired)" % len(common))
    print()
    print("Paired IMP/board, positive = candidate better:")
    print(_fmt("ALL", _stats(diffs)))
    cd = [ia[i] - ib[i] for i in common if cont[i]]
    ud = [ia[i] - ib[i] for i in common if not cont[i]]
    print(_fmt("contested", _stats(cd)))
    print(_fmt("uncontested", _stats(ud)))
    print()
    for name, s in (("all", _stats(diffs)), ("contested", _stats(cd)),
                    ("uncontested", _stats(ud))):
        lo, hi = s["mean"] - 1.96 * s["se"], s["mean"] + 1.96 * s["se"]
        verdict = ("significant" if abs(s["t"]) >= 1.96 else "NOT significant")
        print("  %-12s 95%% CI [%+.3f, %+.3f]  -> %s"
              % (name, lo, hi, verdict))

    if args.verbose:
        ranked = sorted(common, key=lambda i: -(ia[i] - ib[i]))
        print()
        print("  biggest candidate wins:")
        for i in ranked[:5]:
            print("    board %-4d %+3d  (cand %+d vs ctrl %+d) %s"
                  % (i, ia[i] - ib[i], ia[i], ib[i],
                     "contested" if cont[i] else ""))
        print("  biggest candidate losses:")
        for i in ranked[-5:]:
            print("    board %-4d %+3d  (cand %+d vs ctrl %+d) %s"
                  % (i, ia[i] - ib[i], ia[i], ib[i],
                     "contested" if cont[i] else ""))


if __name__ == "__main__":
    main()
