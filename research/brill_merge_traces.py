#!/usr/bin/env python3
"""Merge parallel harvest shards into one distillation set.

    python3 research/brill_merge_traces.py data/brill_traces_big_*.jsonl \
        --out data/brill_traces_big.jsonl

    python3 research/brill_merge_traces.py a.jsonl b.jsonl --out c.jsonl \
        --also data/brill_traces_all.jsonl

WHY
---
`brill_remote_eval.py --shard K/N` runs N processes over disjoint slices of
the same board list, each writing its own file. This puts them back together
and — more importantly — *checks* that they really were disjoint.

That check matters because sharding is silently wrong if the shards disagree
on `--boards` or `--seed`: `build_deals` is **not prefix-stable**, so
`--boards 3000` and `--boards 6000` produce different deals at the same
index. Two shards run that way still both produce plausible-looking traces,
but the union is a different, unevenly-sampled population — and nothing else
in the pipeline would notice.

WHAT IT CHECKS
--------------
1. **Board overlap across shards.** Each shard should own a set of deals no
   other shard touched. Overlap means the shards shared boards (bad config).
2. **Duplicate positions within/between files.** `(deal, ctx, seat)` uniquely
   identifies a bidding position, so a repeat is a genuine duplicate —
   expected only when merging a partially-completed run with its sharded
   restart, which is exactly the case this was written for.
3. **Complete auctions.** A board whose auction was cut off mid-way (a kill
   between checkpoints) leaves a short tail. Not an error, but reported so a
   truncated shard is not mistaken for a finished one.

Duplicates are dropped (keeping the first), not averaged: Brill is
deterministic given the position, so the records should be identical.
"""
import argparse
import json
import os
import sys
from collections import Counter, defaultdict
from typing import Any, Dict, List, Set, Tuple


def pos_key(t: Dict[str, Any]) -> Tuple[str, str, str]:
    """A bidding position: the deal, the auction so far, and who is to act."""
    return (t.get("deal", ""), t.get("ctx", ""), t.get("seat", ""))


def load(path: str) -> List[Dict[str, Any]]:
    out = []
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if line:
                out.append(json.loads(line))
    return out


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("inputs", nargs="+", help="shard files to merge")
    ap.add_argument("--out", required=True)
    ap.add_argument("--also", nargs="*", default=[],
                    help="extra trace files to fold in (e.g. a previous "
                         "harvest). Duplicates against these are dropped too.")
    args = ap.parse_args()

    sources = [(p, load(p)) for p in list(args.inputs) + list(args.also)]

    # ---- board ownership, to check the shards were actually disjoint -----
    boards_of: Dict[str, Set[str]] = defaultdict(set)
    for path, rows in sources:
        for t in rows:
            boards_of[path].add(t.get("deal", ""))

    rows_of = {p: r for p, r in sources}
    shard_paths = list(args.inputs)
    print("shards: %d, %d boards total"
          % (len(shard_paths),
             sum(len(boards_of[p]) for p in shard_paths)))
    for p in shard_paths:
        print("  %-46s %5d traces %5d boards"
              % (os.path.basename(p), len(rows_of[p]), len(boards_of[p])))

    if len(shard_paths) > 1:
        overlap = Counter()
        for i, a in enumerate(shard_paths):
            for b in shard_paths[i + 1:]:
                shared = boards_of[a] & boards_of[b]
                if shared:
                    overlap[(os.path.basename(a), os.path.basename(b))] = \
                        len(shared)
        if overlap:
            print("\n  WARNING: shards share boards — they were NOT run over "
                  "disjoint slices.")
            for (a, b), n in overlap.most_common(10):
                print("    %s ∩ %s : %d boards" % (a, b, n))
            print("    (almost always means --boards/--seed differed between "
                  "shards; build_deals is not prefix-stable)")
        else:
            print("\n  shards are disjoint: no board appears in two shards")

    # ---------------------------- merge + dedupe ---------------------------
    seen: Set[Tuple[str, str, str]] = set()
    merged: List[Dict[str, Any]] = []
    dups = 0
    for _path, rows in sources:
        for t in rows:
            k = pos_key(t)
            if k in seen:
                dups += 1
                continue
            seen.add(k)
            merged.append(t)

    # --------------------------- auction completeness ----------------------
    calls_per_board: Counter = Counter()
    for t in merged:
        calls_per_board[t.get("deal", "")] += 1
    short = sum(1 for n in calls_per_board.values() if n < 4)
    hist = sorted(Counter(calls_per_board.values()).items())

    print("\nmerged: %d traces, %d boards (%d duplicate positions dropped)"
          % (len(merged), len(calls_per_board), dups))
    print("mean calls/board: %.2f"
          % (len(merged) / max(len(calls_per_board), 1)))
    if short:
        print("  NOTE: %d boards have <4 calls — completed auctions are "
              "usually 4+, so these are probably truncated" % short)
    print("calls-per-board histogram: %s" % (hist[:12],))

    tmp = args.out + ".tmp"
    with open(tmp, "w") as fh:
        for t in merged:
            fh.write(json.dumps(t) + "\n")
    os.replace(tmp, args.out)
    print("\nwrote %s" % args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
