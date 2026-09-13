#!/usr/bin/env python3
"""
fetch_brill_slam.py — targeted capture of Brill's 4NT (keycard) subtree.

`research/fetch_brill.py` walks the whole tree but stops at 2 calls deep,
which is exactly one call short of the slam layer: partner's ANSWER to our
4NT ask sits at `<prefix>-4N-P-*` (we ask, RHO passes, partner responds).

This script fetches just that one layer for every auction prefix already
captured in system/brill.md, and writes research/brill_slam.md.

    python3 research/fetch_brill_slam.py            # ~1 min, 350 requests
    python3 research/fetch_brill_slam.py --out FILE

WHY IT MATTERS (see research/status.md §6.39 / §6.40)
----------------------------------------------------
§6.39 found the champion's one genuinely missing component is the route to
slam: no ace-asking bid, no 5-level responses.  Unlike Brill's *asking*
rules — which are gated on engine-internal verdicts (`CanAsk_H_RKC`) and
cannot be translated — the ANSWERS to 4NT are pure hand tests:

    5C  (havekeycards == 0 or havekeycards == 3)
    5D  (havekeycards == 1 or havekeycards == 4)
    5H  ((havekeycards == 2 or havekeycards == 5) and not trumpqueen)
    5S  ((havekeycards == 2 or havekeycards == 5) and trumpqueen)
    5N  (havekeycards == 2 and (void in a non-trump suit))
    6x  ((havekeycards == 1 or havekeycards == 3) and x == 0)   [void show]

That is Roman Keycard Blackwood 0314, and it is translatable in structure.

TWO FEATURES BLOCK AN ACTUAL IMPLEMENTATION
-------------------------------------------
  havekeycards  counts 4 aces + the TRUMP king.  The repo's
                `keycard_count_1430` is currently just `ace_count`, so it
                is off by one whenever the hand holds the trump king — for
                a slam convention that is not a rounding error, it is the
                wrong answer.  A correct count needs to know the trump suit.

  trumpqueen    "do I hold the queen of trump?" — no repo feature, and it
                cannot be written as a conjunction of `*_has_queen`
                booleans without knowing which suit is trump.

Both need a notion of the agreed trump suit, which `bid/features.py` does
not currently expose (it has per-suit facts but no auction-agreed strain).
Adding `agreed_trump` would unblock RKCB, Gerber and the GSF in one go —
which is why this capture is recorded rather than converted.
"""

import argparse
import json
import os
import re
import urllib.parse
import urllib.request
from collections import Counter
from concurrent.futures import ThreadPoolExecutor

REPO = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
BASE = "https://brillservice.aalborgdata.dk/getresponses?auction="
DEFAULT_OUT = os.path.join(REPO, "research", "brill_slam.md")


def get(auction, timeout=30):
    try:
        req = urllib.request.Request(BASE + urllib.parse.quote(auction),
                                     headers={"User-Agent": "bid-research"})
        with urllib.request.urlopen(req, timeout=timeout) as r:
            d = json.loads(r.read().decode())
        return d if isinstance(d, list) else None
    except Exception:
        return None


def captured_prefixes(brill_md):
    lines = open(brill_md, encoding="utf-8").read().split("\n")
    p2 = lines[lines.index("## Part 2 — Rule tree"):]
    return [re.findall(r"`([^`]*)`", l)[0]
            for l in p2 if l.startswith("#### `") and l != "#### `P`"]


def call_of(row):
    return str(row.get("bid") or row.get("call") or "").strip()


def req_of(row):
    return str(row.get("requires") or row.get("requirement") or "").strip()


def esc(s):
    return s.replace("|", "\\|")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=DEFAULT_OUT)
    ap.add_argument("--workers", type=int, default=6)
    args = ap.parse_args()

    prefixes = captured_prefixes(os.path.join(REPO, "system", "brill.md"))
    targets = [f"{p}-4N-P-*" for p in prefixes]
    print(f"fetching {len(targets)} 4NT positions ({args.workers} threads) ...")
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        results = list(ex.map(get, targets))

    rows = [(t, r) for t, r in zip(targets, results) if r]
    nonempty = [(t, r) for t, r in rows if len(r) > 0]
    print(f"  {len(rows)} fetched, {len(nonempty)} define calls")

    # Classify: keycard (uses havekeycards) vs quantitative/other.
    keycard, other = [], []
    for t, r in nonempty:
        (keycard if any("havekeycards" in req_of(x) for x in r) else other).append((t, r))

    out = []
    out.append("# Brill — the 4NT layer (keycard responses)")
    out.append("")
    out.append("> Targeted capture of `system/brill.md`'s one missing layer: partner's")
    out.append("> answer to our 4NT ask, which sits at `<prefix>-4N-P-*` — one call")
    out.append("> deeper than the 2-call sweep in `research/fetch_brill.py`.")
    out.append(">")
    out.append("> - **Source:** `GET https://brillservice.aalborgdata.dk/getresponses?auction=<seq>`")
    out.append("> - **Scope:** every auction prefix in `system/brill.md`, extended by `4N-P`")
    out.append(f"> - **Result:** {len(nonempty)} positions define calls — "
               f"**{len(keycard)} keycard (RKCB 0314)**, {len(other)} quantitative/other")
    out.append("> - **Regenerate:** `python3 research/fetch_brill_slam.py`")
    out.append("")
    out.append("## Why this layer is the interesting one")
    out.append("")
    out.append("Brill's *asking* rules are useless to us: they are gated on engine-internal")
    out.append("verdicts (`CanAsk_H_RKC`, `CanBid6_*`) that Brill never publishes, so they")
    out.append("do not survive translation (§6.40). The *answers* are different — they are")
    out.append("pure hand tests, and they spell out Roman Keycard Blackwood 0314:")
    out.append("")
    out.append("| Response | Means |")
    out.append("|---|---|")
    out.append("| 5♣ | 0 or 3 keycards |")
    out.append("| 5♦ | 1 or 4 keycards |")
    out.append("| 5♥ | 2 or 5 keycards, no trump queen |")
    out.append("| 5♠ | 2 or 5 keycards, with trump queen |")
    out.append("| 5NT | 2 keycards and a void somewhere |")
    out.append("| 6x | 1 or 3 keycards and a void in suit x |")
    out.append("")
    out.append("`havekeycards` counts the four aces **plus the king of trump**; `trumpqueen`")
    out.append("is whether the hand holds the queen of trump.")
    out.append("")
    out.append("## What blocks an implementation")
    out.append("")
    out.append("Not the scheme — that is fully captured below. The blocker is two features")
    out.append("that `bid/features.py` does not expose, and both need the same missing")
    out.append("piece of state: **which suit is trump.**")
    out.append("")
    out.append("1. `havekeycards` — the repo's `keycard_count_1430` is currently just")
    out.append("   `ace_count`, so it is **off by one whenever the hand holds the trump")
    out.append("   king**. For a slam convention that is not a rounding error.")
    out.append("2. `trumpqueen` — no feature at all, and it cannot be written as a")
    out.append("   conjunction of `*_has_queen` booleans without knowing the trump suit.")
    out.append("")
    out.append("Adding an `agreed_trump` feature (the auction-agreed strain, or `None`)")
    out.append("would unblock RKCB, Gerber and the Grand Slam Force together. Until then")
    out.append("this file is a spec, not something to convert.")
    out.append("")

    for title, group in (("Keycard positions (RKCB 0314)", keycard),
                         ("Other 4NT positions (quantitative / notrump-ish)", other)):
        out.append("---")
        out.append("")
        out.append(f"## {title} — {len(group)}")
        out.append("")
        for t, r in group:
            prefix = t[:-len("-4N-P-*")]
            out.append(f"### `{prefix}-4N-P`")
            out.append("")
            out.append("| Call | Requires |")
            out.append("|---|---|")
            for x in r:
                out.append(f"| {esc(call_of(x))} | `{esc(req_of(x))}` |")
            out.append("")

    text = "\n".join(out) + "\n"
    with open(args.out, "w") as f:
        f.write(text)
    print(f"wrote {args.out}: {len(text.splitlines())} lines, {len(text)} bytes")
    print(f"  keycard positions: {len(keycard)} | other: {len(other)}")


if __name__ == "__main__":
    main()
