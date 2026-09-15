#!/usr/bin/env python3
"""What is the best fidelity ANY feature-based model could reach?

    python3 research/brill_ceiling.py --traces data/brill_traces.jsonl

WHY
---
Distillation (`brill_distill.py`) fits a DecisionNet over the 121-key
`extract_all` vector. When it plateaus at ~70% agreement with Brill the two
candidate causes look identical from the outside:

  * not enough traces  -> more data will help, go harvest more
  * not enough signal  -> the feature vector does not determine Brill's call,
                          and NO amount of data will help

They are told apart by a *label collision* count. Bucket traces by their
feature vector. If every bucket is unanimous, a big enough model can in
principle be 100% faithful and the gap is purely data. If buckets disagree
with themselves, the disagreement is irreducible given that feature set:
the model literally cannot distinguish the two cases.

    ceiling = sum(max label count in each bucket) / n_traces

That is the accuracy of the Bayes-optimal classifier over those features.

The second question is *what* is missing. Sig+ctx adds the raw auction
string to the signature; the jump in ceiling is exactly the information
the feature vector throws away. If that jump is large, the fix is feature
engineering (encode auction identity), not a longer harvest.

This is cheap and deterministic — run it before commissioning any large
trace harvest.
"""
import argparse
import json
import os
import sys
from collections import Counter, defaultdict
from typing import Any, Dict, List

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.brill.convert import hand_from_pbn, parse_call, seat_from_letter  # noqa: E402
from bid.features import BridgeFeatures                        # noqa: E402


def sig(feats: Dict[str, Any], extra: str = "") -> str:
    """Hashable identity of a position as the model sees it."""
    body = "|".join("%s=%s" % (k, feats[k]) for k in sorted(feats))
    return body + ("|#ctx=" + extra if extra else "")


def ceiling(sigs: List[str], y: List[str]) -> Dict[str, Any]:
    """Bayes-optimal accuracy + where the irreducible loss lives."""
    buckets: Dict[str, Counter] = defaultdict(Counter)
    for s, lab in zip(sigs, y):
        buckets[s][lab] += 1
    best = sum(c.most_common(1)[0][1] for c in buckets.values())
    conflict = {s: c for s, c in buckets.items() if len(c) > 1}
    # Traces sitting in a bucket that disagrees with itself.
    in_conflict = sum(sum(c.values()) for c in conflict.values())
    return {
        "ceiling": 100.0 * best / max(1, len(y)),
        "buckets": len(buckets),
        "conflicting": len(conflict),
        "traces_in_conflict": in_conflict,
        "worst": sorted(
            ((s, c) for s, c in conflict.items()),
            key=lambda kv: -sum(kv[1].values()))[:5],
    }


def main():
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--traces",
                    default=os.path.join("data", "brill_traces.jsonl"))
    ap.add_argument("--per-depth", action="store_true",
                    help="break the ceiling down by auction length")
    args = ap.parse_args()

    rows = [json.loads(l) for l in open(args.traces) if l.strip()]

    sig_f, sig_c, y, lens = [], [], [], []
    skipped = 0
    for r in rows:
        try:
            hand = hand_from_pbn(r["hand"])
            history = [parse_call(t) for t in (r.get("ctx") or "").split("-")
                       if t.strip()]
            feats = BridgeFeatures.extract_all(
                hand, history, seat_from_letter(r["seat"]),
                seat_from_letter(r["dealer"]), int(r.get("vul", 0)))
        except Exception:                                       # noqa: BLE001
            skipped += 1
            continue
        sig_f.append(sig(feats))
        sig_c.append(sig(feats, r.get("ctx") or ""))
        y.append(str(parse_call(r["call"])))
        lens.append(len(history))
    print("traces %d (skipped %d)" % (len(y), skipped))

    maj = Counter(y).most_common(1)[0]
    print("majority-class baseline %.1f%% (%s)"
          % (100.0 * maj[1] / len(y), maj[0]))

    for label, sigs in (("features only  ", sig_f),
                        ("features + ctx ", sig_c)):
        c = ceiling(sigs, y)
        print("%s ceiling %.1f%% | %d distinct positions, %d of them "
              "self-contradictory (%d traces)"
              % (label, c["ceiling"], c["buckets"], c["conflicting"],
                 c["traces_in_conflict"]))

    if args.per_depth:
        print("\nper auction length (features-only signature):")
        print("  %4s %6s %8s %8s %8s" % ("len", "n", "ceiling", "base",
                                         "gain"))
        by: Dict[int, List[int]] = defaultdict(list)
        for i, L in enumerate(lens):
            by[L].append(i)
        for L in sorted(by):
            idx = by[L]
            if len(idx) < 20:
                continue
            sub_y = [y[i] for i in idx]
            c = ceiling([sig_f[i] for i in idx], sub_y)
            b = 100.0 * Counter(sub_y).most_common(1)[0][1] / len(sub_y)
            print("  %4d %6d %7.1f%% %7.1f%% %+7.1f"
                  % (L, len(idx), c["ceiling"], b, c["ceiling"] - b))
    return 0


if __name__ == "__main__":
    sys.exit(main())
