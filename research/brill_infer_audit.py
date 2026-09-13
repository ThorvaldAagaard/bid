#!/usr/bin/env python3
"""How much would Brill's `/inferresponses` endpoint add to system/brill.dsl?

    python3 research/brill_infer_audit.py --cache /tmp/brill_rules_v2.json
    python3 research/brill_infer_audit.py --limit 40        # quick sample

WHY THIS EXISTS
---------------
`GET /getresponses?auction=X` lists the calls the Brill system *defines* at X.
There is a second endpoint, `GET /inferresponses?auction=X&bids=...`, which
returns a meaning for calls it does NOT define. It needs an explicit `bids=`
list (an empty value is a 400), so nothing about it is discoverable by
crawling — you have to know to ask.

The question this answers: is the ~12% of Brill that `getresponses` never
shows worth capturing? The answer is measured, not argued — every inferred
expression is pushed through the same converter path `brill_to_dsl.build()`
uses, and we count how many would actually emit a DSL rule.

The inferred rows are flagged `[Inferred]` by the service itself and are
built from the same atoms the converter already has to drop (`C_game`,
`monsterslam`, `twicerebiddable`, `competitivevalues`, `preference`), so the
expected answer is "almost none". Run it to confirm that is still true.
"""
import argparse
import json
import os
import sys
import urllib.parse
import urllib.request
from collections import Counter
from concurrent.futures import ThreadPoolExecutor

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import brill_to_dsl as conv                                    # noqa: E402
from brill_parser import parse_expr, to_dnf, contradictions    # noqa: E402

# push_neg lives with the converter (it is only needed there)
push_neg = conv.push_neg                                       # noqa: E402

API = "https://brillservice.aalborgdata.dk"
UA = {"User-Agent": "Mozilla/5.0 (compatible; research)"}


def _get(url, tries=3, timeout=30):
    last = None
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as r:
                return json.loads(r.read().decode("utf-8", "replace"))
        except Exception as e:                                  # noqa: BLE001
            last = e
    print(f"  ! {url}: {last}", file=sys.stderr)
    return None


def all_bids():
    b = _get(API + "/bids") or []
    return [x["bid"] for x in b if x.get("bid")]


def infer(auction, bids):
    """Meanings for the calls in `bids` that Brill does not define at `auction`."""
    if not bids:
        return []
    q = urllib.parse.urlencode({"auction": auction, "bids": ",".join(bids)})
    return _get(API + "/inferresponses?" + q) or []


def would_emit(auction, requires):
    """True if this expression yields >=1 DSL rule, using build()'s own path."""
    ctx = conv.auction_context(auction)
    if not ctx:
        return False, "no_context"
    expr = parse_expr(requires)
    if expr is None:
        return False, "unparseable"
    clauses = to_dnf(push_neg(expr))
    if not clauses or len(clauses) > 64:
        return False, "too_many_clauses"
    for clause in clauses:
        if contradictions(clause):
            continue
        ok = True
        for lit in clause:
            t = conv.translate_literal(lit, True)
            if t is conv.SKIP or t is conv.FALSE:
                ok = False
                break
        if ok:
            return True, "emits"
    return False, "all_clauses_dropped"


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cache", default="/tmp/brill_rules_v2.json")
    ap.add_argument("--limit", type=int, default=0, help="only first N auctions")
    ap.add_argument("--workers", type=int, default=4)
    args = ap.parse_args()

    rules = json.load(open(args.cache))
    bids = all_bids()
    print(f"{len(rules)} auctions in cache, {len(bids)} legal calls")

    # The md heading is the cache key with the trailing '-*' stripped; the
    # converter keys its auction context off that heading.
    auctions = sorted(rules)
    todo = []
    for a in auctions:
        heading = "*" if a == "*" else a.rstrip("-*")
        defined = {r.get("bid") for r in (rules[a] or [])}
        ask = [b for b in bids if b not in defined]
        if ask:
            todo.append((a, heading, ask))
    if args.limit:
        todo = todo[:args.limit]
    print(f"{len(todo)} auctions have at least one undefined call")

    stats = Counter()
    emitted = []

    def work(item):
        a, heading, ask = item
        return a, heading, infer(a, ask)

    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        for a, heading, got in ex.map(work, todo):
            for r in got:
                stats["inferred_rows"] += 1
                req = r.get("requires") or ""
                yes, why = would_emit(heading, req)
                stats[why] += 1
                if yes:
                    emitted.append((heading, r.get("bid"), req))

    print()
    print(f"inferred rows            : {stats['inferred_rows']}")
    print(f"  would emit a DSL rule  : {stats['emits']} "
          f"({100 * stats['emits'] / max(1, stats['inferred_rows']):.1f}%)")
    for k in ("all_clauses_dropped", "unparseable", "no_context",
              "too_many_clauses"):
        if stats[k]:
            print(f"  {k:24s}: {stats[k]}")
    print()
    if emitted:
        print("rows that WOULD convert (first 15):")
        for h, b, req in emitted[:15]:
            print(f"  {h:10s} {b:4s} {req[:70]}")
    else:
        print("No inferred row converts. /inferresponses would add nothing to "
              "system/brill.dsl — every inferred expression is built from "
              "atoms the DSL cannot express.")


if __name__ == "__main__":
    main()
