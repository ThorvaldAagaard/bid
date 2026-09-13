#!/usr/bin/env python3
"""Measure system/brill.dsl against Brill's own engine, hand by hand.

    python3 research/brill_live_check.py --hands 20 --positions 12
    python3 research/brill_live_check.py --from-cache /tmp/brill_live.json

WHY THIS EXISTS
---------------
Every other check of the conversion is indirect: does a rule parse, does a
condition key exist in the feature vocabulary, do eight hand-picked smoke
cases come out right. None of those says how often brill.dsl agrees with
Brill.

Brill's `/bid` endpoint answers that directly. Give it a hand and an auction
and it returns the call its engine would make, plus the winning rule:

    GET /bid?hand=AKQ2.J54.T98.762&ctx=1H-P&seat=S&dealer=N
    -> {"bid": "1S", "requires": "totalpoints >= 6 and spades >= 4
        and (spadelongest or hcp < 12)", "means": "4+ spades, 5+ hcp"}

So for every captured position we can take N random hands, ask Brill what it
would bid, ask brill.dsl the same question through DecisionNet.actions(), and
count agreements. That is a fidelity number, and the per-position breakdown
says where the conversion is losing the most.

It also makes Brill's unpublished atoms *measurable*. `spadelongest`,
`ruleof21`, `loserlevel` and the suit-quality tests are not documented
anywhere, but the `requires` returned here is the exact expression that
fired, so sampling enough hands lets you fit each one instead of guessing.

SEATS
-----
Dealer is fixed at North. Brill anchors every position on the hand to act,
so with k calls already made that hand is N+k: the opener is North, the
second seat is East, the third is South. That is also what the DSL expects,
since `auction_context()` reads the call before the hole as an opponent's
and the one before that as partner's.
"""
import argparse
import json
import os
import random
import re
import sys
import urllib.parse
import urllib.request
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, ".."))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, HERE)

from bid.eval_vs_dds import load_decision_net_dsl                    # noqa: E402
from bid.models import Card, Hand, Rank, Seat, Suit, Strain, Call, CallType  # noqa: E402
from bid.scoring import Vulnerability                                # noqa: E402
from brill_parser import (rows_from_brill_md, parse_expr, to_dnf,    # noqa: E402
                          Name, Call_, Cmp, Not)
import brill_to_dsl as conv                                          # noqa: E402

API = "https://brillservice.aalborgdata.dk"
UA = {"User-Agent": "Mozilla/5.0 (compatible; research)"}
SEATS = ["N", "E", "S", "W"]
_STRAIN = {"C": Strain.CLUBS, "D": Strain.DIAMONDS, "H": Strain.HEARTS,
           "S": Strain.SPADES, "N": Strain.NT}


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


def live_bid(hand_pbn, ctx, seat):
    q = urllib.parse.urlencode({"hand": hand_pbn, "ctx": ctx, "seat": seat,
                                "dealer": "N", "vul": "None"})
    return _get(API + "/bid?" + q)


# ------------------------------------------------------------------ conversion
def parse_calls(heading):
    """'1H-P' -> [Call(1H), Call(Pass)] ; '*' (the empty auction) -> []."""
    if heading.strip() in ("*", ""):
        return []
    out = []
    for tok in heading.split("-"):
        tok = tok.strip().rstrip("*")
        if not tok:
            continue
        if tok in ("P", "PASS"):
            out.append(Call(CallType.PASS))
        elif tok in ("X", "DBL"):
            out.append(Call(CallType.DOUBLE))
        else:
            m = re.match(r"^(\d)([SHDCN])$", tok)
            if not m:
                return None
            out.append(Call(CallType.BID, int(m.group(1)), _STRAIN[m.group(2)]))
    return out


def norm(call_str):
    """Normalise a call to Brill's spelling so the two sides compare."""
    s = str(call_str).strip().upper().rstrip("*")
    if s in ("PASS", "P", "PA"):
        return "P"
    if s in ("X", "DBL", "DOUBLE"):
        return "X"
    if s in ("XX", "RDBL", "REDOUBLE"):
        return "XX"
    s = s.replace("NT", "N")
    return s


def hand_pbn(hand):
    """PBN order S.H.D.C, ranks descending (Rank.__str__ gives the PBN char)."""
    order = (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS)
    out = []
    for s in order:
        rs = sorted((c.rank for c in hand.cards if c.suit == s),
                    key=lambda r: r.value, reverse=True)
        out.append("".join(str(r) for r in rs))
    return ".".join(out)


def random_hand(rng, deck):
    rng.shuffle(deck)
    return Hand(deck[:13])


# ------------------------------------------------------------------------ main
def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--hands", type=int, default=20,
                    help="random hands per position")
    ap.add_argument("--positions", type=int, default=0,
                    help="how many positions to sample (0 = all)")
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--seed", type=int, default=20260913)
    ap.add_argument("--cache", default="/tmp/brill_live.json")
    ap.add_argument("--from-cache", dest="from_cache")
    ap.add_argument("--dsl", default=os.path.join(REPO, "system", "brill.dsl"))
    ap.add_argument("--worst", type=int, default=12,
                    help="how many worst positions to list")
    args = ap.parse_args()

    net = load_decision_net_dsl(args.dsl)
    print(f"loaded {len(net.rules)} rules from {os.path.basename(args.dsl)}")

    headings = sorted({r.auction for r in rows_from_brill_md(
        os.path.join(REPO, "system", "brill.md"))})
    # only positions the DSL can actually see are informative
    usable = []
    for h in headings:
        if parse_calls(h) is None:
            continue
        usable.append(h)
    print(f"{len(headings)} positions in brill.md, {len(usable)} parseable")

    rng = random.Random(args.seed)
    if args.positions:
        rng.shuffle(usable)
        usable = sorted(usable[:args.positions])
    print(f"sampling {len(usable)} positions x {args.hands} hands "
          f"= {len(usable) * args.hands} comparisons")

    deck = [Card(s, r) for s in Suit for r in Rank]
    jobs = []          # (heading, ctx, seat, pbn)
    for h in usable:
        ctx = "" if h == "*" else h
        seat = SEATS[len(parse_calls(h))]
        for _ in range(args.hands):
            hd = random_hand(rng, deck)
            jobs.append((h, ctx, seat, hand_pbn(hd)))

    cache = {}
    if args.from_cache and os.path.exists(args.from_cache):
        cache = json.load(open(args.from_cache))
        print(f"using cache {args.from_cache} ({len(cache)} entries)")
    todo = [j for j in jobs if "|".join((j[1], j[2], j[3])) not in cache]
    if todo:
        print(f"fetching {len(todo)} live bids ...", flush=True)
        done = 0
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            for (h, ctx, seat, pbn), got in zip(
                    todo, ex.map(lambda j: live_bid(j[3], j[1], j[2]), todo)):
                cache["|".join((ctx, seat, pbn))] = got
                done += 1
                if done % 200 == 0:
                    print(f"   {done}/{len(todo)}", flush=True)
        json.dump(cache, open(args.cache, "w"))
        print(f"cached -> {args.cache}")

    # ------------------------------------------------------------- compare
    per_pos = defaultdict(lambda: Counter())
    tot = Counter()
    no_rules = Counter()
    blockers = Counter()
    for h, ctx, seat, pbn in jobs:
        got = cache.get("|".join((ctx, seat, pbn)))
        if not got or not got.get("bid"):
            tot["skipped"] += 1
            continue
        want = norm(got["bid"])
        hist = parse_calls(h)
        hd = _pbn_hand(pbn)
        acts = [norm(a) for a in net.actions(hd, hist, _seat(seat),
                                             Seat.NORTH,
                                             Vulnerability.NONE)]
        tot["compared"] += 1
        per_pos[h]["n"] += 1
        if not acts:
            tot["dsl_silent"] += 1
            per_pos[h]["silent"] += 1
            continue
        if acts[0] == want:
            tot["top1"] += 1
            per_pos[h]["top1"] += 1
        if want in acts[:3]:
            tot["top3"] += 1
            per_pos[h]["top3"] += 1
        if want in acts:
            tot["anywhere"] += 1
            per_pos[h]["anywhere"] += 1
        else:
            no_rules[(h, want)] += 1
            for a in blocker_atoms(got.get("requires", "")):
                blockers[a] += 1

    n = max(1, tot["compared"])
    print()
    print(f"compared          : {tot['compared']}")
    print(f"  exact top-1     : {tot['top1']}  ({100*tot['top1']/n:.1f}%)")
    print(f"  in top 3        : {tot['top3']}  ({100*tot['top3']/n:.1f}%)")
    print(f"  anywhere        : {tot['anywhere']}  ({100*tot['anywhere']/n:.1f}%)")
    print(f"  dsl silent      : {tot['dsl_silent']}  ({100*tot['dsl_silent']/n:.1f}%)")
    if tot["skipped"]:
        print(f"  skipped (no live answer): {tot['skipped']}")

    print(f"\nworst {args.worst} positions by top-1 agreement:")
    rows = sorted(per_pos.items(),
                  key=lambda kv: (kv[1]["top1"] / max(1, kv[1]["n"]), -kv[1]["n"]))
    for h, c in rows[:args.worst]:
        print(f"  {h:12s} n={c['n']:3d}  top1={c['top1']:3d} "
              f"top3={c['top3']:3d} anywhere={c['anywhere']:3d} "
              f"silent={c['silent']:3d}")

    if no_rules:
        print("\nmost-missed calls (Brill bid X, brill.dsl never offers it):")
        for (h, want), c in no_rules.most_common(10):
            print(f"  {h:12s} {want:4s} x{c}")

    if blockers:
        print(f"\nwhy the misses happen — atoms blocking every disjunct "
              f"({tot['compared'] - tot['anywhere']} misses):")
        for a, c in blockers.most_common(18):
            print(f"  {a:28s} {c:4d}  ({100*c/max(1,tot['compared']):.1f}% "
                  f"of all comparisons)")


def _seat(name):
    return {"N": Seat.NORTH, "E": Seat.EAST,
            "S": Seat.SOUTH, "W": Seat.WEST}[name]


# ---------------------------------------------------------------- why-missed
def _atom_name(lit):
    if isinstance(lit, Not):
        return _atom_name(lit.part)
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


def blocker_atoms(requires):
    """Atoms that stop every disjunct of `requires` from translating.

    Empty set means the rule *does* translate, so it is not a blocker at all.
    Otherwise the answer is the atoms common to all disjuncts: fixing any one
    of them is necessary, and fixing all of them frees the rule.
    """
    expr = parse_expr(requires or "")
    if expr is None:
        return {"<unparseable>"}
    clauses = to_dnf(conv.push_neg(expr))
    if not clauses:
        return set()
    per = []
    for cl in clauses:
        bad = set()
        for lit in cl:
            if conv.translate_literal(lit, True) is conv.SKIP:
                bad.add(_atom_name(lit))
        per.append(bad)
    if any(not b for b in per):          # some disjunct already converts
        return set()
    common = set.intersection(*per)
    return common or set.union(*per)


_CHAR_RANK = {str(r): r for r in Rank}


def _pbn_hand(pbn):
    suits = (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS)
    cards = []
    for s, part in zip(suits, pbn.split(".")):
        for ch in part:
            cards.append(Card(s, _CHAR_RANK[ch]))
    return Hand(cards)


if __name__ == "__main__":
    main()
