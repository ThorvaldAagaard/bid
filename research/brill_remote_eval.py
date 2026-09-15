#!/usr/bin/env python3
"""Is REMOTE Brill any good? Score it against DDS par, same as any system.

    python3 research/brill_remote_eval.py --boards 60
    python3 research/brill_remote_eval.py --boards 200 --cache data/brill_bid.json

WHY THIS IS THE DECISIVE QUESTION
---------------------------------
§6.56 showed the converted `system/brill.dsl` is a first-call-only fragment:
it can make 0% of second-and-later calls, and grafting its converted rules
onto champion changed nothing. `research/brill_tree_size.py` then showed the
missing data *exists* — Brill authors 24 rules at `1H-P-1S-P` — but capturing
down to the second calls needs ~26k positions at depth 4 (~5 h of requests).

Before spending that: is Brill's bidding actually better than what we have?
This answers it directly, using `/bid` as an oracle instead of converting
rules. Every seat asks Brill for its call, the final contract is scored with
native DDS, and the result is compared to par and to champion_system.

If remote Brill beats champion clearly, a deeper capture (or distillation
from these same /bid traces) is worth doing. If it does not, the answer is
to stop, and it is cheap to find out.

COST
----
One HTTP request per call made (~8/board), because this drives the auction
directly rather than through PIDMEngine.decide — `decide` probes the
candidate frontier and looks one seat ahead, which multiplies requests by
~3x for no benefit here. All requests are cached, so re-runs are free.
"""
import argparse
import json
import os
import sys
import time

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.brill import BrillClient                                  # noqa: E402
from bid.brill.convert import (auction_ctx, deal_pbn as deal_pbn_of,  # noqa: E402
                               hand_pbn, parse_call, seat_letter)
from bid.eval_vs_dds import (imp_diff, imp_loss, load_decision_net_dsl,  # noqa: E402
                             build_deals, precompute, seed_board,
                             resolution_of)
from bid.arena import BiddingArena                                 # noqa: E402
from bid.pidm import PIDMEngine                                    # noqa: E402
from bid.models import Call, CallType, Seat                        # noqa: E402
from bid.sampling import PartialState                              # noqa: E402

SYSTEM_DIR = os.path.join(REPO, "system")
MAX_CALLS = 20


def brill_auction(client, deal, stats, traces=None):
    """Drive a whole auction by asking Brill, one call at a time.

    `traces` (a list) collects one record per call. That is a distillation
    training set — (position -> the call a strong engine makes) — which is
    the alternative to capturing Brill's rule tree: `brill_tree_size.py`
    puts a deeper capture at ~26k positions, whereas these traces come free
    with the evaluation.
    """
    history = []
    seat = deal.dealer
    # deal_pbn wants {Seat: Hand}, not the Deal itself.
    deal_pbn = deal_pbn_of(dict(deal.hands), deal.dealer)
    while True:
        ps = PartialState(seat, deal.hands[seat], history, deal.dealer,
                          deal.vuln)
        if ps.is_auction_over() or len(history) >= MAX_CALLS:
            break
        ctx = auction_ctx(history)
        hand = deal.hands[seat]
        res = client.bid(hand, ctx=ctx, seat=seat, dealer=deal.dealer,
                         vul=deal.vuln)
        stats["calls"] += 1
        try:
            call = parse_call(res.bid) if res.bid else Call(CallType.PASS)
        except Exception:                                          # noqa: BLE001
            call = Call(CallType.PASS)
            stats["unparsed"] += 1
        if traces is not None:
            traces.append({
                "deal": deal_pbn, "dealer": seat_letter(deal.dealer),
                "vul": int(deal.vuln), "seat": seat_letter(seat),
                "ctx": ctx, "hand": hand_pbn(hand), "call": str(call),
                "means": getattr(res, "means", "") or "",
                "requires": getattr(res, "requires", "") or "",
            })
        history.append(call)
        seat = Seat((seat.value + 1) % 4)
    return history


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--boards", type=int, default=60)
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument("--cache", default="/tmp/brill_bid.json")
    ap.add_argument("--out")
    ap.add_argument("--traces",
                    help="write one (position -> Brill's call) record per "
                         "line to this JSONL file, as a distillation set")
    ap.add_argument("--show", type=int, default=0)
    ap.add_argument("--flush-every", type=int, default=50,
                    help="persist cache+traces every N boards (0 = only at "
                         "the end). A 1,200-board harvest is ~2.5 h; without "
                         "this a kill loses everything.")
    args = ap.parse_args()
    traces: list = []

    deals = build_deals(args.boards, seed=args.seed, include_stratified=False)
    print("boards: %d | resolution ~%.2f IMP/board"
          % (len(deals), resolution_of(len(deals))))

    client = BrillClient(timeout=60, cache_path=args.cache, retries=4)
    engine = PIDMEngine()
    arena = BiddingArena()
    t0 = time.time()
    dd_data = precompute(deals)
    print("par computed in %.1fs" % (time.time() - t0))

    def save_traces() -> None:
        """Write what we have so far. Cheap, and makes a kill recoverable."""
        if not args.traces:
            return
        tmp = args.traces + ".tmp"
        with open(tmp, "w") as fh:
            for t in traces:
                fh.write(json.dumps(t) + "\n")
        os.replace(tmp, args.traces)

    stats = {"calls": 0, "unparsed": 0}
    t0 = time.time()
    diffs, losses, auctions, passed = [], [], [], []
    for i, deal in enumerate(deals):
        par_score, _pc, _dd = dd_data[i]
        seed_board(args.seed, i)
        hist = brill_auction(client, deal, stats,
                             traces if args.traces else None)
        score = engine.evaluate_terminal_deal(deal, hist, Seat.SOUTH,
                                              deal.dealer, deal.vuln)
        diffs.append(imp_diff(score, par_score))
        losses.append(imp_loss(score, par_score))
        auctions.append(" ".join(str(c) for c in hist))
        passed.append(not any(str(c) != "PASS" for c in hist))
        if args.show and i < args.show:
            print("  par %+6d | got %+6d | %s"
                  % (par_score, score, auctions[-1]))
        if args.flush_every and (i + 1) % args.flush_every == 0:
            client.flush_cache()
            save_traces()
            print("  [%d/%d] %d calls, %.0fs — checkpointed"
                  % (i + 1, len(deals), stats["calls"], time.time() - t0),
                  flush=True)
    n = len(deals)
    remote = {"name": "REMOTE Brill (/bid)", "mean_imp_diff": sum(diffs) / n,
              "mean_imp_loss": sum(losses) / n, "passed_out": sum(passed),
              "imp_diffs": diffs, "imp_losses": losses,
              "auctions": auctions, "passed": passed}
    print("\n%-24s mean_imp_diff %+6.2f | abs %5.2f | passed_out %d/%d  "
          "(%d calls, %d unparsed, %.1fs)"
          % (remote["name"], remote["mean_imp_diff"], remote["mean_imp_loss"],
             remote["passed_out"], n, stats["calls"], stats["unparsed"],
             time.time() - t0))

    # champion for reference (local, free)
    champ = load_decision_net_dsl(os.path.join(SYSTEM_DIR,
                                               "champion_system.dsl"))
    champ.name = "champion_system"
    c_diffs, c_losses = [], []
    t0 = time.time()
    for i, deal in enumerate(deals):
        par_score, _pc, _dd = dd_data[i]
        seed_board(args.seed, i)
        _hist, score = arena.play_board(deal, champ, champ)
        c_diffs.append(imp_diff(score, par_score))
        c_losses.append(imp_loss(score, par_score))
    print("%-24s mean_imp_diff %+6.2f | abs %5.2f  (%.1fs)"
          % ("champion_system", sum(c_diffs) / n, sum(c_losses) / n,
             time.time() - t0))

    # paired, both metrics (§6.28: the abs metric counts beating par as
    # badly as missing it, so report the signed one too)
    def paired(base, cand, higher_is_better):
        d = [cand[i] - base[i] for i in range(len(base))] if higher_is_better \
            else [base[i] - cand[i] for i in range(len(base))]
        m = sum(d) / len(d)
        sd = (sum((x - m) ** 2 for x in d) / (len(d) - 1)) ** 0.5
        se = sd / (len(d) ** 0.5)
        return m, se, (m / se if se else 0.0)

    a_m, a_se, a_t = paired(c_losses, losses, False)     # champion -> brill
    s_m, s_se, s_t = paired(c_diffs, diffs, True)
    print("\npaired, remote Brill vs champion (positive = Brill better):")
    print("  abs dev from par : %+.2f  se %.2f  t %+.2f" % (a_m, a_se, a_t))
    print("  signed vs par    : %+.2f  se %.2f  t %+.2f" % (s_m, s_se, s_t))

    beat = [x for x in diffs if x > 0.5]
    lost = [x for x in diffs if x < -0.5]
    print("  Brill beats par on %d boards (avg %+.2f), loses on %d (avg %+.2f)"
          % (len(beat), sum(beat) / len(beat) if beat else 0,
             len(lost), sum(lost) / len(lost) if lost else 0))

    if args.traces:
        with open(args.traces, "w") as fh:
            for t in traces:
                fh.write(json.dumps(t) + "\n")
        print("wrote %s (%d position->call records)"
              % (args.traces, len(traces)))

    client.flush_cache()
    if args.out:
        with open(args.out, "w") as fh:
            json.dump({k: v for k, v in remote.items()}, fh, indent=1)
        print("wrote %s" % args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
