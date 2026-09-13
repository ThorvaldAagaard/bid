#!/usr/bin/env python3
"""Can Brill's `penalty` be fitted from hand features? (Spoiler: not safely.)

    python3 research/brill_fit_penalty.py --hands 40
    python3 research/brill_fit_penalty.py --from-cache /tmp/penalty_probe2.json

WHY THIS EXISTS
---------------
§6.44 found that `penalty` is the single biggest blocker in the Brill
conversion — 7 % of all comparisons, more than any other atom — and that it
gates the penalty doubles that dominate the most-missed calls. It is also
the one blocker that looked like it *might* be a hand feature rather than a
deal-level verdict, because a penalty double is classically a trump-stack
decision: length and strength in their suit.

So this fits it. At 28 positions Brill has exactly two options — a double
gated solely on `penalty` at priority 90, and a pass below it — so Brill
bids X if and only if `penalty` is true, which gives clean labels from
`/bid` with no inference.

RESULT
------
The ranking is good and the decision rule is not. Held-out over 336 samples
(1,120 labelled in total, 24 % positive), decision tree:

    depth  AUC    precision @ recall ~0.6   best high-precision point
      3    0.93        0.61                 0.70 @ 0.49
      4    0.93        0.61                 0.86 @ 0.27
      5    0.91        0.64                 0.75 @ 0.46
      6    0.90        0.63                 0.75 @ 0.42

So the two ends of the trade-off are both bad: at usable recall the rule
adds one wrong double for every two right ones, and to reach 0.86 precision
you have to give up three quarters of the doubles. The residual is not
noise — a penalty double genuinely depends on partner's hand and the play,
so it cannot be recovered from our thirteen cards.

Encoding a 0.6-precision rule would RELAX brill.dsl, which is the one thing
§6.40's "drop a clause, never relax one" rule exists to prevent, so
`penalty` is deliberately left untranslated. Expect `cansacrifice`, `game`
and `*_compgame` to behave the same way — the whole verdict class is
probably unfittable, and it is ~72 % of the remaining gap (§6.44).

The 6- and 7-level positions are excluded: there the double sits at
priority -900, i.e. it is a fallback rather than a winner, so "X iff
penalty" does not hold.
"""
import argparse
import json
import os
import random
import sys
import urllib.parse
import urllib.request
from collections import Counter
from concurrent.futures import ThreadPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, ".."))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.models import Card, Hand, Rank, Suit                        # noqa: E402
from bid.features import BridgeFeatures                              # noqa: E402

API = "https://brillservice.aalborgdata.dk"
UA = {"User-Agent": "Mozilla/5.0 (compatible; research)"}

# positions where X:penalty (pri 90) beats every other row, so X <=> penalty
POSITIONS = ["2C-2D", "2H-2N", "2S-2N", "2H-3S", "3C-3N", "3D-3N",
             "2N-4H", "2N-4S", "3C-4H", "3C-4S", "3D-4H", "3D-4S", "4H-4S",
             "4D-5C", "4H-5C", "4H-5D", "4H-5S", "4S-5C", "4S-5D", "4S-5H",
             "5C", "5C-5H", "5C-5S", "5D", "5D-5H", "5D-5S", "5H", "5S"]
FULL = {"S": "spade", "H": "heart", "D": "diamond", "C": "club"}
SHORT = {"S": "s", "H": "h", "D": "d", "C": "c"}


def _get(url, tries=3):
    for _ in range(tries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=30) as r:
                return json.loads(r.read().decode("utf-8", "replace"))
        except Exception:                                    # noqa: BLE001
            pass
    return None


def pbn(hand):
    order = (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS)
    return ".".join(
        "".join(str(c.rank) for c in sorted((c for c in hand.cards
                                             if c.suit == s),
                                            key=lambda c: -c.rank.value))
        for s in order)


def hand_from_pbn(pbn_str):
    order = (Suit.SPADES, Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS)
    ch = {str(r): r for r in Rank}
    return Hand([Card(s, ch[c]) for s, part in zip(order, pbn_str.split("."))
                 for c in part])


def collect(hands, workers, cache, cache_path):
    rng = random.Random(2026)
    deck = [Card(s, r) for s in Suit for r in Rank]
    jobs = []
    for a in POSITIONS:
        seat = "E" if len(a.split("-")) == 1 else "S"
        for _ in range(hands):
            rng.shuffle(deck)
            jobs.append((a, seat, pbn(Hand(deck[:13]))))
    todo = [j for j in jobs if "|".join(j) not in cache]
    if todo:
        print(f"fetching {len(todo)} live bids ...", flush=True)
        with ThreadPoolExecutor(max_workers=workers) as ex:
            for j, got in zip(todo, ex.map(
                    lambda j: _get(API + "/bid?" + urllib.parse.urlencode(
                        {"hand": j[2], "ctx": j[0], "seat": j[1],
                         "dealer": "N", "vul": "None"})), todo)):
                cache["|".join(j)] = got
        json.dump(cache, open(cache_path, "w"))
        print(f"cached -> {cache_path}")
    out = []
    for a, seat, h in jobs:
        g = cache.get("|".join((a, seat, h)))
        if not g or not g.get("bid"):
            continue
        last = a.split("-")[-1]
        out.append(dict(auction=a, hand=h, level=int(last[0]),
                        strain=last[-1], lab=1 if g["bid"] == "X" else 0))
    return out


def featurise(rows):
    """Add bridge features relative to the suit being doubled."""
    for d in rows:
        f = BridgeFeatures.extract_hand_features(hand_from_pbn(d["hand"]))
        d.update(hcp=f["hcp"], tp=f["total_points"], ctrl=f["controls"],
                 aces=f["ace_count"], ltc=f["losing_trick_count"],
                 qt=f["quick_tricks"], longest=f["longest_suit_len"],
                 second=f["second_longest_len"],
                 semi=int(f["is_semi_balanced"]), bal=int(f["is_balanced"]))
        if d["strain"] != "N":
            fl, t = FULL[d["strain"]], SHORT[d["strain"]]
            d.update(tr_len=f[f"{fl}_len"], tr_hcp=f[f"{fl}_hcp"],
                     tr_top2=f[f"{t}_top2_honors"], tr_top3=f[f"{t}_top3_honors"],
                     tr_stop=f[f"{t}_stopper"])
        else:
            d.update(tr_len=0, tr_hcp=0, tr_top2=0, tr_top3=0, tr_stop=0)
    return rows


KEYS = ["hcp", "tp", "ctrl", "aces", "ltc", "qt", "longest", "second",
        "semi", "bal", "level", "tr_len", "tr_hcp", "tr_top2", "tr_top3",
        "tr_stop"]


# ------------------------------------------------------------- CART (no deps)
def _gini(y):
    if len(y) == 0:
        return 0.0
    p = sum(y) / len(y)
    return 2 * p * (1 - p)


def build(rows, depth):
    if depth == 0 or len(rows) < 20 or _gini([r["lab"] for r in rows]) == 0:
        return ("leaf", sum(r["lab"] for r in rows) / max(1, len(rows)))
    best = None
    for k in KEYS:
        vals = sorted({r[k] for r in rows})[1:]
        for v in vals:
            lo = [r for r in rows if r[k] >= v]
            hi = [r for r in rows if r[k] < v]
            if len(lo) < 8 or len(hi) < 8:
                continue
            g = (len(lo) * _gini([r["lab"] for r in lo])
                 + len(hi) * _gini([r["lab"] for r in hi])) / len(rows)
            if best is None or g < best[0]:
                best = (g, k, v)
    if best is None:
        return ("leaf", sum(r["lab"] for r in rows) / max(1, len(rows)))
    _, k, v = best
    return ("node", k, v,
            build([r for r in rows if r[k] >= v], depth - 1),
            build([r for r in rows if r[k] < v], depth - 1))


def score(tree, row):
    while tree[0] == "node":
        _, k, v, lo, hi = tree
        tree = lo if row[k] >= v else hi
    return tree[1]


def auc(labels, scores):
    pairs = sorted(zip(scores, labels))
    pos = sum(l for _, l in pairs)
    neg = len(pairs) - pos
    if not pos or not neg:
        return float("nan")
    rank = sum(i + 1 for i, (_, l) in enumerate(pairs) if l == 1)
    return (rank - pos * (pos + 1) / 2) / (pos * neg)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--hands", type=int, default=40)
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--cache", default="/tmp/penalty_probe2.json")
    ap.add_argument("--from-cache", dest="from_cache")
    args = ap.parse_args()

    cache = {}
    src = args.from_cache or args.cache
    if os.path.exists(src):
        cache = json.load(open(src))
        print(f"using cache {src} ({len(cache)} entries)")
    rows = collect(args.hands, args.workers, cache, args.cache)
    featurise(rows)
    print(f"labelled {len(rows)}  positives {sum(r['lab'] for r in rows)} "
          f"({100*sum(r['lab'] for r in rows)/max(1,len(rows)):.0f}%)")
    print("  by level:", dict(sorted(Counter(r["level"] for r in rows).items())))

    rng = random.Random(1)
    rng.shuffle(rows)
    cut = int(0.7 * len(rows))
    tr, te = rows[:cut], rows[cut:]
    print(f"\ntrain {len(tr)} (pos {sum(r['lab'] for r in tr)})   "
          f"test {len(te)} (pos {sum(r['lab'] for r in te)})")

    for depth in (3, 4, 5, 6):
        tree = build(tr, depth)
        ps = [score(tree, r) for r in te]
        ys = [r["lab"] for r in te]
        print(f"\ndepth {depth}  held-out AUC {auc(ys, ps):.3f}")
        for thr in (0.5, 0.7, 0.8):
            pred = [1 if p >= thr else 0 for p in ps]
            tp = sum(1 for p, y in zip(pred, ys) if p and y)
            fp = sum(1 for p, y in zip(pred, ys) if p and not y)
            fn = sum(1 for p, y in zip(pred, ys) if not p and y)
            prec = tp / (tp + fp) if tp + fp else 0
            rec = tp / (tp + fn) if tp + fn else 0
            print(f"   thr {thr}: precision {prec:.2f}  recall {rec:.2f} "
                  f" (tp {tp} fp {fp} fn {fn})")

    print("\nVerdict: good ranking, unusable decision rule. A fitted `penalty`")
    print("would add roughly two wrong doubles for every right one, which is a")
    print("relaxation — so it is not encoded.")


if __name__ == "__main__":
    main()
