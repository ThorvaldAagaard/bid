#!/usr/bin/env python3
"""DAgger traces: label the states the STUDENT actually reaches.

    python3 research/brill_dagger.py --student system/brill_distilled.dsl \
        --opponent system/champion_system.dsl --boards 400 --seed 7 \
        --out data/brill_traces_dagger.jsonl

WHY
---
`brill_remote_eval.py` harvests by having Brill bid all four seats. Every
training context is therefore a *Brill-vs-Brill* auction. The distilled
system is then deployed against a different opponent, is only ~78% faithful,
and so drifts into states that never appear in its training set -- where it
has no data at all and plays badly, which pushes it further off
distribution. That is compounding error, the standard failure mode of
imitation learning, and it fits what §6.60 measured: the distilled system is
fine in self-play (+0.20, n.s.) and loses head-to-head (-0.98), i.e. it is
good on-distribution and bad off it.

DAgger is the textbook fix: let the **student drive** the auction and have
the **expert label** the states it visits. Then the training distribution is
the deployment distribution by construction.

HOW
---
Student sits NS, opponent EW. At each student turn we ask Brill what *it*
would bid and record (position -> Brill's call) -- but we append the
student's own call to the auction, so the trajectory is the student's. One
HTTP request per student turn (~4/board), not per seat.

The opponent plays normally, so the student also sees the competitive
pressure it will actually face.

Output format matches `brill_traces*.jsonl`, so the files concatenate and
`brill_distill.py` reads them unchanged.
"""
import argparse
import json
import os
import sys
import time
from typing import Any, Dict, List

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.brill import BrillClient                                  # noqa: E402
from bid.brill.convert import (auction_ctx, deal_pbn as deal_pbn_of,  # noqa: E402
                               hand_pbn, parse_call, seat_letter)
from bid.eval_vs_dds import build_deals, load_decision_net_dsl, seed_board  # noqa: E402
from bid.arena import BiddingArena                                 # noqa: E402
from bid.models import Call, CallType, Seat                        # noqa: E402
from bid.sampling import PartialState                              # noqa: E402

SYSTEM_DIR = os.path.join(REPO, "system")
MAX_CALLS = 20


def main():
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--student", default=os.path.join(SYSTEM_DIR,
                                                      "brill_distilled.dsl"))
    ap.add_argument("--opponent", default=os.path.join(SYSTEM_DIR,
                                                       "champion_system.dsl"))
    ap.add_argument("--boards", type=int, default=400)
    ap.add_argument("--seed", type=int, default=7,
                    help="deal seed for the trajectories; these boards are "
                         "then TRAINED on, so keep it distinct from any seed "
                         "used to score the result")
    ap.add_argument("--out", default=os.path.join("data",
                                                  "brill_traces_dagger.jsonl"))
    ap.add_argument("--cache", default="/tmp/brill_dagger.json")
    ap.add_argument("--flush-every", type=int, default=25)
    args = ap.parse_args()

    student = load_decision_net_dsl(args.student)
    opponent = load_decision_net_dsl(args.opponent)
    student.name = os.path.splitext(os.path.basename(args.student))[0]
    opponent.name = os.path.splitext(os.path.basename(args.opponent))[0]

    deals = build_deals(args.boards, seed=args.seed, include_stratified=False)
    arena = BiddingArena()
    # Cache is loaded by the constructor; only flushing is explicit.
    client = BrillClient(timeout=60, cache_path=args.cache, retries=4)

    models = {Seat.NORTH: student, Seat.SOUTH: student,
              Seat.EAST: opponent, Seat.WEST: opponent}
    student_seats = (Seat.NORTH, Seat.SOUTH)

    traces: List[Dict[str, Any]] = []
    calls = 0
    t0 = time.time()
    print("DAgger: student %s (NS) vs opponent %s (EW), %d boards, seed %d"
          % (student.name, opponent.name, len(deals), args.seed))

    for i, deal in enumerate(deals):
        seed_board(args.seed, i)
        deal_pbn = deal_pbn_of(dict(deal.hands), deal.dealer)
        history: List[Any] = []
        curr = deal.dealer
        while True:
            ps = PartialState(curr, deal.hands[curr], history, deal.dealer,
                              deal.vuln)
            if ps.is_auction_over() or len(history) >= MAX_CALLS:
                break
            if curr in student_seats:
                # Expert labels the state the student is about to act in.
                ctx = auction_ctx(history)
                try:
                    res = client.bid(deal.hands[curr], ctx=ctx, seat=curr,
                                     dealer=deal.dealer, vul=deal.vuln)
                    calls += 1
                    bid = getattr(res, "bid", None)
                    traces.append({
                        "deal": deal_pbn, "dealer": seat_letter(deal.dealer),
                        "vul": int(deal.vuln), "seat": seat_letter(curr),
                        "ctx": ctx, "hand": hand_pbn(deal.hands[curr]),
                        "call": str(parse_call(bid)) if bid else "PASS",
                        "means": getattr(res, "means", "") or "",
                        "requires": getattr(res, "requires", "") or "",
                    })
                except Exception:                                  # noqa: BLE001
                    pass
            call, _ = arena.engine.decide(ps, models)
            history.append(call)
            curr = Seat((curr.value + 1) % 4)

        if args.flush_every and (i + 1) % args.flush_every == 0:
            client.flush_cache()
            tmp = args.out + ".tmp"
            with open(tmp, "w") as fh:
                for t in traces:
                    fh.write(json.dumps(t) + "\n")
            os.replace(tmp, args.out)
            print("  [%d/%d] %d traces, %.0fs"
                  % (i + 1, len(deals), len(traces), time.time() - t0),
                  flush=True)

    client.flush_cache()
    with open(args.out, "w") as fh:
        for t in traces:
            fh.write(json.dumps(t) + "\n")
    print("wrote %s (%d traces, %d Brill calls, %.0fs)"
          % (args.out, len(traces), calls, time.time() - t0))
    return 0


if __name__ == "__main__":
    sys.exit(main())
