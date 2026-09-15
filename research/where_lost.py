#!/usr/bin/env python3
"""Attribute a head-to-head IMP loss to concrete contract differences.

    python3 research/where_lost.py --a system/brill_distilled.dsl \
        --b system/champion_system.dsl --boards 400 --seed 7

WHY
---
`team_match.py` says *that* A loses to B, not *where*. A ~1 IMP/board
deficit could be two very different things:

  * diffuse  — thousands of slightly-worse partscore decisions, which no
               targeted fix will change;
  * concentrated — a few recurring catastrophes, e.g. failing to bid games
               that make, each worth ~10 IMP, which absolutely is fixable.

Those have completely different remedies, so they must be told apart before
spending effort.

HOW
---
The team match deliberately mixes the systems (A on NS, B on EW) so the
resulting contract belongs to neither one cleanly. For attribution each
system instead plays **itself** on the same deal, which yields the contract
that system reaches on its own:

    (A, A) -> contract_A, NS score_A
    (B, B) -> contract_B, NS score_B

Then score_A - score_B is an IMP difference on identical cards, and every
board can be labelled by *how* the two contracts differ.

The headline breakdown is by contract class (passed out / partscore / game /
slam), and specifically the "game gap" — boards where one side bids a game
and the other stops in a partscore. Missing a making game costs about
10 IMP in a single board, so a handful of these can dominate a whole match.
"""
import argparse
import os
import sys
from collections import Counter
from typing import Any, Dict, List, Optional, Tuple

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.arena import BiddingArena                               # noqa: E402
from bid.eval_vs_dds import build_deals, load_decision_net_dsl, seed_board  # noqa: E402
from bid.models import CallType, Strain                         # noqa: E402
from bid.scoring import diff_to_imps                            # noqa: E402

SYSTEM_DIR = os.path.join(REPO, "system")
MAJORS = (Strain.HEARTS, Strain.SPADES)


def to_imps(net: float) -> int:
    n = int(round(net))
    mag = diff_to_imps(n)
    return -mag if n < 0 else mag


def final_contract(history: List[Any]) -> Optional[Tuple[int, Any]]:
    """(level, strain) of the last bid, or None if the board was passed out."""
    for c in reversed(history):
        if c.type == CallType.BID and getattr(c, "strain", None) is not None:
            return (c.level, c.strain)
    return None


def contract_str(ct: Optional[Tuple[int, Any]]) -> str:
    if ct is None:
        return "PASS_OUT"
    lvl, st = ct
    return "%d%s" % (lvl, "NT" if st == Strain.NT else st.name[0]
                     if hasattr(st, "name") else str(st))


def contract_class(ct: Optional[Tuple[int, Any]]) -> str:
    if ct is None:
        return "passed_out"
    lvl, st = ct
    if lvl >= 6:
        return "slam"
    if st == Strain.NT:
        return "game" if lvl >= 3 else "partscore"
    if st in MAJORS:
        return "game" if lvl >= 4 else "partscore"
    return "game" if lvl >= 5 else "partscore"


def main():
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--a", default=os.path.join(SYSTEM_DIR,
                                                "brill_distilled.dsl"))
    ap.add_argument("--b", default=os.path.join(SYSTEM_DIR,
                                                "champion_system.dsl"))
    ap.add_argument("--boards", type=int, default=400)
    ap.add_argument("--seed", type=int, default=7)
    args = ap.parse_args()

    a = load_decision_net_dsl(args.a)
    b = load_decision_net_dsl(args.b)
    a.name = os.path.splitext(os.path.basename(args.a))[0]
    b.name = os.path.splitext(os.path.basename(args.b))[0]

    deals = build_deals(args.boards, seed=args.seed, include_stratified=False)
    arena = BiddingArena()

    rows: List[Dict[str, Any]] = []
    for i, deal in enumerate(deals):
        seed_board(args.seed, i)
        h_a, s_a = arena.play_board(deal, a, a)
        seed_board(args.seed, i)
        h_b, s_b = arena.play_board(deal, b, b)
        ct_a, ct_b = final_contract(h_a), final_contract(h_b)
        rows.append({
            "i": i, "score_a": s_a, "score_b": s_b,
            "imp": to_imps(s_a - s_b),
            "ct_a": ct_a, "ct_b": ct_b,
            "cls_a": contract_class(ct_a), "cls_b": contract_class(ct_b),
        })

    n = len(rows)
    tot = sum(r["imp"] for r in rows)
    mean = tot / n
    sd = (sum((r["imp"] - mean) ** 2 for r in rows) / (n - 1)) ** 0.5
    se = sd / (n ** 0.5)
    print("%s vs %s, %d boards (seed %d), each playing itself"
          % (a.name, b.name, n, args.seed))
    print("  %s net: %+.2f IMP/board  (se %.2f, t %+.2f), total %+d"
          % (a.name, mean, se, mean / se if se else 0, tot))

    # --- concentration: is the loss diffuse or a few disasters? ----------
    print("\nCONCENTRATION")
    by_loss = sorted(rows, key=lambda r: r["imp"])   # worst for A first
    abs_tot = sum(abs(r["imp"]) for r in rows) or 1
    for pct in (0.01, 0.05, 0.10, 0.25):
        k = max(1, int(n * pct))
        share = sum(abs(r["imp"]) for r in by_loss[:k]) / abs_tot
        print("  worst %2d%% of boards (%3d) carry %4.1f%% of all IMP movement"
              % (pct * 100, k, 100 * share))
    worst = by_loss[:10]
    print("  10 worst boards for %s: %s"
          % (a.name, " ".join("%+d" % r["imp"] for r in worst)))
    for r in worst[:5]:
        print("      board %-4d %s %-7s vs %s %-7s  -> %+d IMP"
              % (r["i"], a.name, contract_str(r["ct_a"]), b.name,
                 contract_str(r["ct_b"]), r["imp"]))

    # --- what contracts does each side reach? ----------------------------
    print("\nCONTRACT CLASS REACHED")
    ca = Counter(r["cls_a"] for r in rows)
    cb = Counter(r["cls_b"] for r in rows)
    print("  %-12s %10s %10s" % ("class", a.name, b.name))
    for cls in ("passed_out", "partscore", "game", "slam"):
        print("  %-12s %10d %10d" % (cls, ca[cls], cb[cls]))

    # --- the game gap ----------------------------------------------------
    print("\nGAME GAP  (one side bids game, the other stops below)")
    a_game_b_part = [r for r in rows
                     if r["cls_a"] == "game" and r["cls_b"] == "partscore"]
    b_game_a_part = [r for r in rows
                     if r["cls_b"] == "game" and r["cls_a"] == "partscore"]
    for label, grp in ((("%s bids game, %s partscore" % (a.name, b.name)),
                        a_game_b_part),
                       (("%s bids game, %s partscore" % (b.name, a.name)),
                        b_game_a_part)):
        if not grp:
            print("  %-46s   none" % label)
            continue
        imp = sum(r["imp"] for r in grp)
        print("  %-46s n=%-4d net %+6d IMP  (%+.2f each)"
              % (label, len(grp), imp, imp / len(grp)))

    a_slam = [r for r in rows if r["cls_a"] == "slam" and r["cls_b"] != "slam"]
    b_slam = [r for r in rows if r["cls_b"] == "slam" and r["cls_a"] != "slam"]
    if a_slam or b_slam:
        print("\nSLAM GAP")
        for label, grp in ((a.name + " alone in slam", a_slam),
                           (b.name + " alone in slam", b_slam)):
            if grp:
                imp = sum(r["imp"] for r in grp)
                print("  %-46s n=%-4d net %+6d IMP  (%+.2f each)"
                      % (label, len(grp), imp, imp / len(grp)))

    print("\nWhere the total comes from (net IMP by contract-class pair):")
    pair: Dict[Tuple[str, str], List[int]] = {}
    for r in rows:
        pair.setdefault((r["cls_a"], r["cls_b"]), []).append(r["imp"])
    for (ka, kb), imps in sorted(pair.items(),
                                 key=lambda kv: -abs(sum(kv[1])))[:8]:
        print("  %-12s / %-12s n=%-4d net %+6d  (%+.2f each)"
              % (ka, kb, len(imps), sum(imps), sum(imps) / len(imps)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
