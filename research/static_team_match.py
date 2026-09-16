#!/usr/bin/env python3
"""Grade a local system against remote Brill using a harvest — no network.

    python3 research/static_team_match.py \
        --traces data/brill_traces_holdout555.jsonl \
        --system system/brill_distilled.dsl

WHY
---
Every harvest in this repo already contains something more valuable than
training data: **complete auctions played by remote Brill in all four
seats**. Each trace is (deal, seat, ctx, call), so grouping by deal and
ordering by `ctx` length reconstructs the exact auction Brill would reach
on that board.

That means Brill's half of a team match can be *replayed from disk*. The
other half is the local system, played normally. Both are then scored by
the same `BiddingArena` and differenced board by board on identical cards.

The payoff is that attributing the ~2.6 IMP/board gap to remote Brill
costs **zero HTTP requests** instead of the ~12,000 a live
`team_match.py --remote-a` run would need (~2 h sequential). It also makes
every future harvest reusable as a benchmark: grade any system against a
fixed Brill reference without re-harvesting.

WHAT IT IS AND IS NOT
---------------------
A real team match puts A at NS on one table and EW on the other, so A's
net is s1 - s2. Here each side plays all four seats, and the comparison is
between the contract Brill's self-play reached and the contract the local
system's self-play reached — then scored. That is a *paired* comparison on
identical cards, which is what gives it statistical power, but it isolates
system strength rather than duplicating the two-table design. Numbers here
are therefore comparable to each other, not to `team_match.py`'s.

PASS OUTS AND INCOMPLETE AUCTIONS
---------------------------------
Some recorded auctions are truncated (the harvest caps at 20 calls). Those
boards are reported and excluded by default rather than silently scored,
because a truncated auction is not a contract.
"""
import argparse
import json
import math
import os
import sys
from collections import Counter
from typing import Any, Dict, List, Optional, Tuple

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))
sys.path.insert(0, REPO)

from bid.models import (Hand, Card, Suit, Rank, Seat, Call, CallType,      # noqa: E402
                        Strain)
from bid.sampling import Deal, PartialState                                # noqa: E402
from bid.arena import BiddingArena                                         # noqa: E402
from bid.pidm import PIDMEngine                                            # noqa: E402
from bid.eval_vs_dds import load_decision_net_dsl, seed_board              # noqa: E402
from bid.scoring import diff_to_imps                                       # noqa: E402
from team_match import to_imps, contested, passed_out                      # noqa: E402

SUIT_ORDER = (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS)
_RANK = {str(r): r for r in Rank}


def hand_from_pbn(s: str) -> Hand:
    return Hand([Card(su, _RANK[c])
                 for su, part in zip(SUIT_ORDER, s.split("."))
                 for c in part])


def deal_from_pbn(deal_str: str, vuln: int = 0) -> Deal:
    head, _, body = str(deal_str).partition(":")
    parts = body.split()
    if len(parts) != 4:
        raise ValueError("deal needs 4 hands: %r" % deal_str)
    hands = {seat: hand_from_pbn(p)
             for seat, p in zip((Seat.NORTH, Seat.EAST, Seat.SOUTH,
                                 Seat.WEST), parts)}
    dealer = {"N": Seat.NORTH, "E": Seat.EAST,
              "S": Seat.SOUTH, "W": Seat.WEST}[head.strip()[:1] or "N"]
    return Deal(hands, dealer, vuln)


class ReplayBrill:
    """Answer from the recorded auction instead of from the network.

    Within one board the auction is deterministic, so a position is fully
    identified by how many calls have been made. Keying on call count
    avoids any dependency on how `ctx` is serialised.
    """

    def __init__(self, seq: List[str]):
        self.seq = seq
        self.name = "remote_brill"
        self.missed = 0

    def actions(self, hand: Any, history: List[Any], seat: Any,
                dealer: Any, vuln: int) -> List[Any]:
        i = len(history)
        if i < len(self.seq):
            return [self.seq[i]]
        # Ran past the recorded auction: pass, and let the caller notice.
        self.missed += 1
        return [Call(CallType.PASS)]


def contract_of_history(deal: Deal, history: List[Call]) -> Optional[Tuple]:
    """(level, strain, declarer) or None if passed out."""
    if not history or passed_out(history):
        return None
    try:
        ps = PartialState(deal.dealer, deal.hands[deal.dealer], history,
                          deal.dealer, deal.vuln)
        c = ps.get_contract()
    except Exception:                                          # noqa: BLE001
        return None
    if not c:
        return None
    return (c[0], c[1], c[2])


def _level_bucket(c: Optional[Tuple]) -> str:
    if c is None:
        return "passed out"
    lvl = c[0]
    return "partscore (1-3)" if lvl <= 3 else (
        "game (4-5)" if lvl <= 5 else "slam (6-7)")


def _stats(xs: List[float]) -> Dict[str, float]:
    n = len(xs)
    if n == 0:
        return {"n": 0, "mean": 0.0, "se": 0.0, "t": 0.0, "total": 0}
    m = sum(xs) / n
    sd = math.sqrt(sum((x - m) ** 2 for x in xs) / (n - 1)) if n > 1 else 0.0
    se = sd / math.sqrt(n)
    return {"n": n, "mean": m, "se": se, "t": (m / se) if se else 0.0,
            "total": int(round(sum(xs)))}


def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--traces", required=True,
                    help="a Brill harvest; must contain complete auctions")
    ap.add_argument("--system", default="system/brill_distilled.dsl")
    ap.add_argument("--seed", type=int, default=7)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--keep-truncated", action="store_true")
    ap.add_argument("--dump")
    args = ap.parse_args()

    rows = [json.loads(l) for l in open(args.traces) if l.strip()]

    # ---- group by deal, reconstruct each auction ----------------------
    by_deal: Dict[str, List[dict]] = {}
    for r in rows:
        by_deal.setdefault(r["deal"], []).append(r)

    boards: List[Tuple[str, Deal, List[str], int]] = []
    truncated = 0
    for deal_str, rs in by_deal.items():
        rs.sort(key=lambda r: len([c for c in (r.get("ctx") or "").split("-")
                                   if c]))
        calls = [r["call"] for r in rs]
        # A finished auction: 4 passes, or a bid followed by 3 passes.
        finished = (len(calls) >= 4 and all(c == "PASS" for c in calls[-3:])
                    and (any(c != "PASS" for c in calls)
                         or len(calls) == 4))
        if not finished:
            truncated += 1
            if not args.keep_truncated:
                continue
        try:
            deal = deal_from_pbn(deal_str, int(rs[0].get("vul", 0)))
        except Exception as exc:                                # noqa: BLE001
            print("  skip unparseable deal: %s" % exc)
            continue
        boards.append((deal_str, deal, calls, int(rs[0].get("vul", 0))))

    boards.sort(key=lambda b: b[0])
    if args.limit:
        boards = boards[:args.limit]

    print("traces      : %d over %d deals" % (len(rows), len(by_deal)))
    print("usable boards: %d  (truncated auctions skipped: %d)"
          % (len(boards), 0 if args.keep_truncated else truncated))
    print("system      : %s" % args.system)

    net = load_decision_net_dsl(args.system)
    arena = BiddingArena(PIDMEngine())

    diffs: List[int] = []
    per_board: List[Dict[str, Any]] = []
    cont: List[int] = []
    uncont: List[int] = []
    bucket_tot: Counter = Counter()
    bucket_imp: Counter = Counter()
    lvl_us: Counter = Counter()
    lvl_them: Counter = Counter()
    replay_miss = 0

    for i, (deal_str, deal, calls, _v) in enumerate(boards):
        seq = [parse_call_token(c) for c in calls]
        replay = ReplayBrill(seq)

        seed_board(args.seed, i)
        h_brill, s_brill = arena.play_board(deal, replay, replay)
        replay_miss += replay.missed

        seed_board(args.seed, i)
        h_local, s_local = arena.play_board(deal, net, net)

        # Positive = the local system did better (NS perspective, same cards).
        d = int(round(s_local - s_brill))
        imp = to_imps(d)
        diffs.append(imp)

        c_us = contract_of_history(deal, h_local)
        c_them = contract_of_history(deal, h_brill)
        is_cont = contested(h_brill, deal.dealer)
        (cont if is_cont else uncont).append(imp)

        b = _level_bucket(c_them)
        bucket_tot[b] += 1
        bucket_imp[b] += imp
        lvl_us[_level_bucket(c_us)] += 1
        lvl_them[b] += 1

        per_board.append({"board": i, "deal": deal_str, "net": d, "imp": imp,
                          "contested": bool(is_cont),
                          "ours": str(c_us[:2]) if c_us else "PASS_OUT",
                          "brill": str(c_them[:2]) if c_them else "PASS_OUT"})

    s = _stats([float(x) for x in diffs])
    print()
    print("STATIC TEAM MATCH vs remote Brill (positive = %s better)"
          % os.path.basename(args.system))
    print("  boards      %d" % s["n"])
    print("  net         %+.3f IMP/board   se %.3f   t %+.2f   total %+d"
          % (s["mean"], s["se"], s["t"], s["total"]))
    lo, hi = s["mean"] - 1.96 * s["se"], s["mean"] + 1.96 * s["se"]
    print("  95%% CI      [%+.3f, %+.3f]  -> %s"
          % (lo, hi, "significant" if abs(s["t"]) >= 1.96 else "not significant"))
    for name, xs in (("contested", cont), ("uncontested", uncont)):
        st = _stats([float(x) for x in xs])
        print("  %-12s n=%-4d %+7.3f  se %.3f  t %+6.2f  total %+5d"
              % (name, st["n"], st["mean"], st["se"], st["t"], st["total"]))
    if replay_miss:
        print("  WARNING: replay ran past the recorded auction on %d calls"
              % replay_miss)

    print()
    print("Where the IMPs go, bucketed by the contract BRILL reached:")
    print("  %-18s %6s %10s %12s" % ("bucket", "n", "IMP/board", "total IMP"))
    for b in sorted(bucket_tot, key=lambda v: -abs(bucket_imp[v])):
        print("  %-18s %6d %+10.3f %12d"
              % (b, bucket_tot[b], bucket_imp[b] / bucket_tot[b],
                 bucket_imp[b]))

    print()
    print("Contract level reached:")
    print("  %-18s %8s %8s" % ("", "ours", "Brill"))
    for b in ("passed out", "partscore (1-3)", "game (4-5)", "slam (6-7)"):
        print("  %-18s %8d %8d" % (b, lvl_us.get(b, 0), lvl_them.get(b, 0)))

    if args.dump:
        with open(args.dump, "w") as fh:
            json.dump({"contested": _stats([float(x) for x in cont]),
                       "uncontested": _stats([float(x) for x in uncont]),
                       "boards": per_board}, fh, indent=1)
        print("\ndumped per-board results to %s" % args.dump)
    return 0


def parse_call_token(tok: str) -> Call:
    """'1NT' / 'P' / 'X' -> Call. Mirrors bid.brill.convert.parse_call."""
    t = (tok or "").strip()
    if t in ("P", "PASS"):
        return Call(CallType.PASS)
    if t == "X":
        return Call(CallType.DOUBLE)
    if t == "XX":
        return Call(CallType.REDOUBLE)
    m = {"C": Strain.CLUBS, "D": Strain.DIAMONDS, "H": Strain.HEARTS,
         "S": Strain.SPADES, "NT": Strain.NT}
    return Call(CallType.BID, int(t[0]), m[t[1:].upper()])


if __name__ == "__main__":
    sys.exit(main())
