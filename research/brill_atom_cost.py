#!/usr/bin/env python3
"""Rank Brill atoms by how many clauses each one currently blocks.

    python3 research/brill_atom_cost.py [--top 25]

Answers "which missing feature should I add next?" with a number instead of
a hunch. For every row in system/brill.md it converts the Requires
expression to DNF, then for each clause asks: which literals fail to
translate?  A clause is credited to an atom when that atom is the ONLY thing
stopping it — so the count is "clauses freed by implementing exactly this
one atom", which is the honest unit for prioritising.

(§6.42 measured this by hand, re-running the converter with each atom
temporarily made translatable. This does it in one pass.)
"""
import argparse
import os
import sys
from collections import Counter

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, ".."))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, HERE)

from brill_parser import rows_from_brill_md, parse_expr, Name, Call_, Cmp, Not  # noqa: E402
import brill_to_dsl as conv                                                     # noqa: E402


def atom_name(lit):
    if isinstance(lit, Not):
        return atom_name(lit.part)
    if isinstance(lit, Name):
        return lit.name
    if isinstance(lit, Call_):
        return lit.name + "()"
    if isinstance(lit, Cmp):
        if isinstance(lit.left, Name):
            return lit.left.name
        if isinstance(lit.left, Call_):
            return lit.left.name + "()"
        return "<expr>"
    return type(lit).__name__


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--top", type=int, default=25)
    args = ap.parse_args()

    rows = rows_from_brill_md(os.path.join(REPO, "system", "brill.md"))
    solo = Counter()        # atom was the ONLY blocker in the clause
    present = Counter()     # atom blocked this clause (with company)
    clauses = 0

    for r in rows:
        expr = parse_expr(getattr(r, "requires", None) or "")
        if expr is None:
            continue
        for clause in conv.to_dnf(conv.push_neg(expr)):
            clauses += 1
            bad = []
            for lit in clause:
                if conv.translate_literal(lit, True) is conv.SKIP:
                    bad.append(atom_name(lit))
            if not bad:
                continue
            for a in set(bad):
                present[a] += 1
            if len(set(bad)) == 1:
                solo[bad[0]] += 1

    print(f"{clauses} clauses in {len(rows)} rows\n")
    print(f"{'atom':30s} {'solo':>6s} {'with others':>12s}")
    print("-" * 50)
    for a, n in solo.most_common(args.top):
        print(f"{a:30s} {n:6d} {present[a]:12d}")


if __name__ == "__main__":
    main()
