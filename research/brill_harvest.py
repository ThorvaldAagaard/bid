#!/usr/bin/env python3
"""Harvest Brill traces through the bulk `/autobid` endpoint.

    python3 research/brill_harvest.py --boards 20000 --seed 9001 \
        --workers 4 --out data/brill_traces_ab

WHY THIS EXISTS
---------------
The original harvester (`brill_dagger.py`) asks Brill for **one call at a
time**: `client.bid(hand, ctx, ...)` per position. An average deal produces
9.9 traces, so it costs ~10 round trips to harvest one board, and the
requests are inherently serial because each `ctx` depends on the previous
answer.

`/autobid` bids a **whole board** in a single request, returning the
complete auction plus a per-call explanation:

    {"deal": "N:...", "dealer": "N", "vulnerability": "None",
     "auction": "P-P-1D-X-P-1H-2D-4S-P-P-P",
     "explanations": [{bid, player, means, requires}, ...]}

That is the same ~9.9 traces for one round trip — roughly a 10x reduction
in requests per trace — and, crucially, the requests are now independent,
so they can be issued in parallel. The economics of every experiment that
depends on data volume change accordingly.

The output is schema-identical to the existing harvests
(`data/brill_traces_*.jsonl`), so it is a drop-in for `brill_distill.py`
and `static_team_match.py`.

DEAL SOURCE AND DISJOINTNESS
----------------------------
Deals come from `build_deals(boards, seed)`, which pins the dealer to
North and rotates vulnerability 0-3 exactly as the existing harvest does.
It is NOT prefix-stable: `build_deals(50) != build_deals(100)[:50]`. So
every shard must be given the same `--boards` and `--seed` and only
differs by `--shard`/`--shards`. Use a seed that no existing harvest used
so the boards are fresh; `--check-overlap` verifies this against a file of
known deals.
"""
import argparse
import json
import os
import sys
import time
from typing import Any, Dict, List, Optional

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, REPO)

from bid.models import Seat                                            # noqa: E402
from bid.eval_vs_dds import build_deals                                # noqa: E402
from bid.brill import BrillClient                                      # noqa: E402
from bid.brill.convert import deal_pbn, hand_pbn                       # noqa: E402

SEAT_LETTER = {Seat.NORTH: "N", Seat.EAST: "E",
               Seat.SOUTH: "S", Seat.WEST: "W"}
_VUL_IN = {"None": 0, "NS": 1, "EW": 2, "All": 3, "Both": 3}


def auction_to_traces(deal_str: str, dealer: str, vul: int,
                      hands: Dict[Seat, Any], auction: str,
                      explanations: List[Any]) -> List[dict]:
    """Split one finished auction into (seat, ctx, call) training traces."""
    calls = [c for c in str(auction or "").split("-") if c not in ("", None)]
    out: List[dict] = []
    for i, call in enumerate(calls):
        # Prefer Brill's own player attribution; fall back to rotation.
        seat = None
        if i < len(explanations):
            seat = getattr(explanations[i], "player", None)
        if not seat:
            seat = SEAT_LETTER[Seat((int(dealer) if str(dealer).isdigit()
                                     else 0) + i) % 4]
        seat = str(seat)[-1].upper()
        expl = explanations[i] if i < len(explanations) else None
        h = None
        for s, letter in SEAT_LETTER.items():
            if letter == seat:
                h = hands.get(s)
                break
        out.append({
            "deal": deal_str,
            "dealer": dealer,
            "seat": seat,
            "ctx": "-".join(calls[:i]),
            "hand": hand_pbn(h) if h is not None else "",
            "call": "PASS" if call == "P" else call,
            "means": getattr(expl, "means", "") or "",
            "requires": getattr(expl, "requires", "") or "",
            "vul": vul,
        })
    return out


def run_shard(args, shard: int) -> int:
    deals = build_deals(args.boards, seed=args.seed, include_stratified=False)
    mine = deals[shard::args.shards]
    # Every worker builds the *whole* board list before slicing — 20k Deal
    # objects is several GB when six workers do it at once. Drop the shards
    # this worker does not own before making a single request.
    del deals
    out_path = "%s_%d.jsonl" % (args.out, shard)
    cache = "%s_%d.json" % (args.cache, shard)
    client = BrillClient(cache_path=cache, timeout=args.timeout,
                         retries=3)

    written = 0
    errors = 0
    t0 = time.time()
    with open(out_path, "w") as fh:
        for n, deal in enumerate(mine):
            if args.limit and n >= args.limit:
                break
            pbn = deal_pbn(deal.hands, deal.dealer)
            vul = int(getattr(deal, "vuln", 0) or 0)
            try:
                res = client.autobid(pbn, dealer=deal.dealer, vul=vul)
            except Exception as exc:                        # noqa: BLE001
                errors += 1
                if errors <= 5:
                    print("  [shard %d] autobid failed: %s"
                          % (shard, str(exc)[:160]), flush=True)
                continue
            auc = getattr(res, "auction", "") or ""
            if not auc:
                continue
            for tr in auction_to_traces(pbn, "N", vul, deal.hands, auc,
                                        getattr(res, "explanations", []) or []):
                fh.write(json.dumps(tr) + "\n")
                written += 1
            if (n + 1) % args.flush_every == 0:
                fh.flush()
                client.flush_cache()
                el = time.time() - t0
                print("  [shard %d] %d/%d deals, %d traces, %.1f/s"
                      % (shard, n + 1, len(mine), written,
                         (n + 1) / el), flush=True)
    client.flush_cache()
    print("  [shard %d] DONE %d traces, %d errors, %.1fs -> %s"
          % (shard, written, errors, time.time() - t0, out_path), flush=True)
    return written


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--boards", type=int, default=1000,
                    help="number of deals to build (before sharding)")
    ap.add_argument("--seed", type=int, default=9001,
                    help="deal seed; must differ from every existing harvest")
    ap.add_argument("--shard", type=int, default=0)
    ap.add_argument("--shards", type=int, default=1)
    ap.add_argument("--workers", type=int, default=1,
                    help="run this many shards in parallel (forks)")
    ap.add_argument("--out", default=os.path.join("data", "brill_traces_ab"))
    ap.add_argument("--cache", default="/tmp/brill_harvest")
    ap.add_argument("--timeout", type=float, default=60.0)
    ap.add_argument("--flush-every", type=int, default=100)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--check-overlap", default="",
                    help="a .jsonl of known traces; refuse to run if any "
                         "generated deal already appears there")
    args = ap.parse_args()

    if args.check_overlap:
        known = set()
        for line in open(args.check_overlap):
            line = line.strip()
            if line:
                known.add(json.loads(line).get("deal"))
        deals = build_deals(args.boards, seed=args.seed,
                            include_stratified=False)
        mine = {deal_pbn(d.hands, d.dealer) for d in deals}
        both = mine & known
        print("overlap check: %d new deals, %d known, %d shared"
              % (len(mine), len(known), len(both)))
        if both:
            print("REFUSING: this seed collides with the existing harvest.")
            return 1

    if args.workers > 1:
        from multiprocessing import Process
        procs = []
        for s in range(args.workers):
            a = argparse.Namespace(**vars(args))
            a.shard = s
            a.shards = args.workers
            p = Process(target=run_shard, args=(a, s))
            p.start()
            procs.append(p)
        for p in procs:
            p.join()
        return 0

    run_shard(args, args.shard)
    return 0


if __name__ == "__main__":
    sys.exit(main())
