#!/usr/bin/env python3
"""Concatenate the per-slice DSL files produced by `--only-group`.

    python3 research/merge_dsl.py /tmp/g_*.dsl --out system/big.dsl

WHY
---
`brill_distill.py --only-group` fits one slice of the grouping per run.
Slices are fitted independently, so splitting the fit across processes is
*exact* — the merged system is the one a single-process fit would have
produced — but it keeps peak memory proportional to the largest slice
instead of the whole trace set. That is what makes a 330k-trace fit
possible on a 16 GB machine.

The pieces then have to go back together. The DSL is a flat list of
`RULE` blocks under a comment header, so merging is: take one header,
then every rule block from every file in order.

WHAT IT CHECKS
--------------
1. Every input has the same header (same generator, same format).
2. No rule id appears twice. Ids are `BD_<slice>_...`, so a collision
   means two files were produced for the same slice — the merged system
   would then silently depend on file order.
"""
import argparse
import os
import sys


def split_header(text: str):
    """(header lines, list of rule blocks) for one DSL file."""
    lines = text.splitlines()
    first = next((i for i, ln in enumerate(lines)
                  if ln.startswith("RULE ")), len(lines))
    header = lines[:first]
    blocks, cur = [], []
    for ln in lines[first:]:
        if ln.startswith("RULE ") and cur:
            blocks.append(cur)
            cur = [ln]
        else:
            cur.append(ln)
    if cur:
        blocks.append(cur)
    return header, blocks


def rule_id(block):
    return block[0].strip().rstrip(":").split(None, 1)[1]


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("inputs", nargs="+")
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    headers, blocks = None, []
    seen = {}
    for path in args.inputs:
        with open(path) as fh:
            header, blks = split_header(fh.read())
        # A slice can come back empty (below --min-samples), and its file is
        # then just a header — or nothing. Take the first *real* header.
        if headers is None and any(h.strip() for h in header):
            headers = header
        elif headers is not None and (header != headers
                                      and any(h.strip() for h in header)):
            print("WARNING: %s has a different header than the first file"
                  % path)
        for b in blks:
            rid = rule_id(b)
            if rid in seen:
                sys.exit("duplicate rule id %s in %s and %s — the slices "
                         "overlap, so the merge would be order-dependent"
                         % (rid, seen[rid], path))
            seen[rid] = path
            blocks.append(b)
        print("  %-46s %5d rules" % (os.path.basename(path), len(blks)))

    if not blocks:
        sys.exit("no rules found in %s" % " ".join(args.inputs))

    out = list(headers or [])
    if out and out[-1].strip():
        out.append("")
    for b in blocks:
        out.extend(b)
        if b[-1].strip():
            out.append("")
    text = "\n".join(out).rstrip() + "\n"
    with open(args.out, "w") as fh:
        fh.write(text)
    print("merged %d files -> %d rules -> %s"
          % (len(args.inputs), len(blocks), args.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())
