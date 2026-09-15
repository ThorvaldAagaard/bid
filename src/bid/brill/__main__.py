"""Command-line front end for the Brill connector.

    python3 -m bid.brill version
    python3 -m bid.brill systems
    python3 -m bid.brill bid "SAKQ32 HK32 DA32 C43" --ctx 1H-P --seat S
    python3 -m bid.brill bids --ctx 1C
    python3 -m bid.brill responses --auction 1C
    python3 -m bid.brill explain 1C-1H-2H
    python3 -m bid.brill dd "N:AQJ2.AK3.QJ4.432 KT8.QJT9.K85.AQ7 9753.876.732.J98 64.542.AT96.KT65"
    python3 -m bid.brill autobid "N:... ... ... ..." --dealer N --vul None
    python3 -m bid.brill play "N:... ... ... ..." --ctx 1N-P-P-P --dealer N
"""
from __future__ import annotations

import argparse
import json
import sys

from .client import BrillClient
from .play import PlayState


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="bid.brill", description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--base", default=BrillClient.__init__.__defaults__[0])
    ap.add_argument("--timeout", type=float, default=30.0)
    ap.add_argument("--cache")
    sub = ap.add_subparsers(dest="cmd", required=True)

    sub.add_parser("version")
    sub.add_parser("systems")
    sub.add_parser("health")

    p = sub.add_parser("bid")
    p.add_argument("hand")
    p.add_argument("--ctx")
    p.add_argument("--seat")
    p.add_argument("--dealer", default="N")
    p.add_argument("--vul", default="None")
    p.add_argument("--details", action="store_true")

    p = sub.add_parser("bids")
    p.add_argument("--ctx")

    p = sub.add_parser("responses")
    p.add_argument("--auction")

    p = sub.add_parser("infer")
    p.add_argument("bids")
    p.add_argument("--auction")

    p = sub.add_parser("explain")
    p.add_argument("auction")
    p.add_argument("--vul", default="None")

    p = sub.add_parser("dd")
    p.add_argument("deal")

    p = sub.add_parser("autobid")
    p.add_argument("deal")
    p.add_argument("--dealer", default="N")
    p.add_argument("--vul", default="None")

    p = sub.add_parser("play", help="play a board card by card against Brill")
    p.add_argument("deal")
    p.add_argument("--ctx", default="", help="auction, e.g. 1N-P-P-P")
    p.add_argument("--dealer", default="N")
    p.add_argument("--vul", default="None")
    p.add_argument("--tricks", type=int, default=52,
                   help="stop after this many cards (default 52)")

    args = ap.parse_args(argv)
    c = BrillClient(base_url=args.base, timeout=args.timeout,
                    cache_path=args.cache)
    try:
        if args.cmd == "version":
            v = c.version()
            print(json.dumps({"version": v.version, "commit": v.commit,
                              "rules": v.rule_count,
                              "buildTime": v.build_time}, indent=1))
        elif args.cmd == "systems":
            print(json.dumps(c.systems(), indent=1))
        elif args.cmd == "health":
            print(json.dumps(c.health(), indent=1))
        elif args.cmd == "bid":
            r = c.bid(args.hand, ctx=args.ctx, seat=args.seat,
                      dealer=args.dealer, vul=args.vul, details=args.details)
            print(json.dumps({"bid": r.bid, "alert": r.alert,
                              "means": r.means, "requires": r.requires,
                              "explanation": r.explanation,
                              "analysis": r.analysis}, indent=1))
        elif args.cmd == "bids":
            print(json.dumps([b.__dict__ for b in c.bids(args.ctx)], indent=1))
        elif args.cmd == "responses":
            print(json.dumps([r.__dict__ for r in c.get_responses(args.auction)],
                             indent=1))
        elif args.cmd == "infer":
            print(json.dumps([r.__dict__ for r in
                              c.infer_responses(args.bids, args.auction)],
                             indent=1))
        elif args.cmd == "explain":
            print(json.dumps([e.__dict__ for e in c.explain(args.auction,
                                                            args.vul)], indent=1))
        elif args.cmd == "dd":
            t = c.dd(args.deal)
            print(json.dumps(t.by_strain, indent=1))
            print("best:", t.best_contract())
        elif args.cmd == "autobid":
            a = c.autobid(args.deal, dealer=args.dealer, vul=args.vul)
            print(json.dumps({"auction": a.auction, "dealer": a.dealer,
                              "vulnerability": a.vulnerability}, indent=1))
            for e in a.explanations:
                if e.means:
                    print("  %-4s %-2s %s" % (e.bid, e.player, e.means))
        elif args.cmd == "play":
            state = PlayState.from_deal(args.deal, ctx=args.ctx,
                                        dealer=args.dealer, vul=args.vul)
            print("contract:", state.contract)
            for i in range(args.tricks):
                if state.complete:
                    break
                r = state.ask(c)
                state.push(r.card)
                print("  T%-2d %s %-3s q=%.2f%s" % (
                    (len(state.played) - 1) // 4 + 1, state.played[-1][0],
                    r.card, r.quality or 0.0,
                    "  " + r.tie_break_info if r.tie_break_info else ""))
            ns, ew = state.tricks()
            print("tricks: NS %d  EW %d" % (ns, ew))
            if state.complete:
                print("result: %+d" % state.result())
    finally:
        c.flush_cache()
    return 0


if __name__ == "__main__":
    sys.exit(main())
