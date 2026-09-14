#!/usr/bin/env python3
"""Price the remaining untranslated Brill atoms by how often they CAN fire.

    python3 research/brill_atom_value.py [--hands 200] [--top 20]
    python3 research/brill_atom_value.py --calibrate

WHY THIS EXISTS
---------------
`brill_atom_cost.py` ranks atoms by CLAUSES FREED, which is a coverage
measure. §6.53 showed coverage and fidelity are different currencies:
`realsolid` was the single largest item on that board (256 clauses) and bought
**exactly 0** measured fidelity, because `realsolid and losers == 1` happens
once in 33,333 hands. Clause count cannot see that.

This prices atoms in the currency that actually moves the fidelity number. For
every DNF clause blocked by exactly one atom, it translates the REST of the
clause and Monte-Carlos how often those co-conditions hold on random hands at
that row's auction position.

That is an UPPER BOUND, and deliberately so:

  * it assumes the unknown atom is TRUE whenever the co-conditions hold;
  * it ignores whether a higher-priority Brill rule fires first;
  * `ALT` co-conditions are treated as satisfied.

So a clause priced at 0 cannot be worth implementing at any fidelity
resolution, whatever the atom turns out to mean. That is the number worth
having before spending another probing session.

CALIBRATION
-----------
`--calibrate` re-runs the pricer while pretending `realsolid` is still
untranslated. §6.53 measured that recovering it changed fidelity by 0/6,320,
so the pricer must report an upper bound near 0 for it. If it does not, the
pricer is wrong.
"""
import argparse
import os
import random
import sys
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, ".."))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, HERE)

from bid.decision_net import RuleCondition                      # noqa: E402
from bid.features import BridgeFeatures                         # noqa: E402
from bid.models import Card, Hand, Rank, Seat, Suit             # noqa: E402
from bid.scoring import Vulnerability                           # noqa: E402
from brill_atom_cost import atom_name                           # noqa: E402
from brill_live_check import parse_calls                        # noqa: E402
from brill_parser import rows_from_brill_md, parse_expr         # noqa: E402
import brill_to_dsl as conv                                     # noqa: E402

SEATS = [Seat.NORTH, Seat.EAST, Seat.SOUTH, Seat.WEST]

# brill_live_check's standard sample: 20 hands per position.
HANDS_PER_POSITION = 20


def clause_plan(clause, skip_names=()):
    """-> (sole blocker or None, list of (key,op,value) | None, is_dead)."""
    bad, conds = [], []
    for lit in clause:
        name = atom_name(lit)
        if name in skip_names:
            bad.append(name)
            continue
        t = conv.translate_literal(lit, True)
        if t is conv.SKIP:
            bad.append(name)
        elif t == conv.FALSE:
            return None, None, True
        elif t == conv.TRUE:
            continue
        elif isinstance(t, conv.ALT) or (isinstance(t, tuple) and t[2] is None):
            conds.append(None)          # unknown shape -> permissive
        else:
            conds.append(t)
    if len(set(bad)) != 1:
        return None, None, False
    return bad[0], conds, False


def collect(skip_names=()):
    """-> heading -> [(atom, conds)] for clauses blocked by exactly one atom."""
    rows = rows_from_brill_md(os.path.join(REPO, "system", "brill.md"))
    by_heading = defaultdict(list)
    n_clauses = 0
    for r in rows:
        expr = parse_expr(getattr(r, "requires", None) or "")
        if expr is None:
            continue
        for clause in conv.to_dnf(conv.push_neg(expr)):
            n_clauses += 1
            atom, conds, dead = clause_plan(clause, skip_names)
            if dead or atom is None:
                continue
            by_heading[r.auction].append((atom, conds))
    return by_heading, n_clauses


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--hands", type=int, default=200,
                    help="random hands sampled per auction position")
    ap.add_argument("--seed", type=int, default=20260913)
    ap.add_argument("--top", type=int, default=20)
    ap.add_argument("--calibrate", action="store_true",
                    help="pretend realsolid is still untranslated and price it")
    args = ap.parse_args()

    skip = ("realsolid()",) if args.calibrate else ()
    by_heading, n_clauses = collect(skip)
    print(f"{n_clauses} clauses; {sum(len(v) for v in by_heading.values())} "
          f"are blocked by exactly one atom")
    if args.calibrate:
        print("CALIBRATION: treating realsolid() as untranslated. §6.53 "
              "measured its true fidelity gain as 0/6,320.\n")

    rng = random.Random(args.seed)
    deck = [Card(s, r) for s in Suit for r in Rank]

    # atom -> list of (probability co-conditions hold, heading)
    hits = defaultdict(list)
    n_head = 0
    for heading, items in sorted(by_heading.items()):
        hist = parse_calls(heading)
        if hist is None:
            continue
        seat = SEATS[len(hist) % 4]
        feats = []
        for _ in range(args.hands):
            rng.shuffle(deck)
            hd = Hand(deck[:13])
            feats.append(BridgeFeatures.extract_all(
                hd, list(hist), seat, Seat.NORTH, Vulnerability.NONE))
        n_head += 1
        for atom, conds in items:
            n = 0
            for f in feats:
                ok = True
                for c in conds:
                    if c is None:
                        continue
                    if not RuleCondition(c[0], c[1], c[2]).evaluate(f):
                        ok = False
                        break
                if ok:
                    n += 1
            hits[atom].append((n / len(feats), heading))

    print(f"sampled {n_head} positions x {args.hands} hands\n")

    rows = []
    for atom, obs in hits.items():
        # A clause with NO co-conditions is "free": its bound is just
        # hands-per-position, and tells us nothing except clause count.
        gated = [p for p, _ in obs if p < 1.0]
        free = len(obs) - len(gated)
        rows.append((
            atom,
            len(obs),
            free,
            HANDS_PER_POSITION * sum(gated),   # bound from gated rows only
            HANDS_PER_POSITION * free,         # bound from free rows
            max((p for p, _ in obs), default=0.0),
        ))
    rows.sort(key=lambda r: -(r[3] + r[4]))

    print(f"{'atom':28s} {'rows':>5s} {'free':>5s} {'gated max':>10s} "
          f"{'free max':>9s} {'best p':>8s}")
    print("-" * 72)
    for atom, n, free, g, fr, best_p in rows[:args.top]:
        print(f"{atom:28s} {n:5d} {free:5d} {g:9.2f} {fr:9.2f} {best_p:8.4f}")
    print()
    print("Bounds are agreements out of the 6,320-comparison sample, assuming")
    print("the atom is true whenever its co-conditions hold.")
    print("  'free'  clauses carry no co-conditions, so their bound is only")
    print("          clause count x 20 - it says nothing about the atom.")
    print("  'gated' clauses are throttled by a co-condition we CAN measure;")
    print("          a small number there is a real verdict, not a loose bound.")
    print("  gated max of ~0 means the clause can never move fidelity, whatever")
    print("  the atom turns out to mean.")


if __name__ == "__main__":
    main()
