#!/usr/bin/env python3
"""Distil remote Brill into a compact DSL system from /bid traces.

    python3 research/brill_distill.py --traces data/brill_traces_train.jsonl
    python3 research/brill_distill.py --group none --max-depth 10
    python3 research/brill_distill.py --no-eval

WHY
---
§6.57 established that remote Brill beats champion_system by +0.98 abs
IMP/board (t 3.74), while the rule-capture conversion (`system/brill.dsl`) is
1.03 abs *worse* than champion — a ~2.0 IMP/board loss. Capturing the tree
deeper would need ~26k positions (§6.57) and would still emit rule-shaped
output the DSL cannot express.

Distillation avoids both problems: `/bid` answers ANY position, so a trace is
just (position -> the call a strong engine makes). Fit ID3 to those pairs and
emit ordinary DSL rules. No unpublished atoms, no tree crawl, and the result
round-trips through the repo's own `export_dsl` / `load_decision_net_dsl`.

HOW
---
1. Featurise each trace with `BridgeFeatures.extract_all` — the same 121-key
   vector `DecisionNet.actions()` uses, so learned rules are directly
   executable.
2. Group by `auction_len` (number of calls already made) by default. ID3
   splits only on numeric/bool features, so it cannot partition on the *call
   identity* features (`opp_last_call`, `my_last_call` are strings).
   `auction_len` is the cheapest proxy that separates "opener" from
   "responder" from "opener's second turn" — which is exactly the distinction
   the rule capture lost.
3. Fit an ID3 tree per group and compile it with `id3_tree_to_rules`, using
   `auction_len == k` as the guard. The guard is what stops a tree trained on
   openings from firing in a competitive auction (see that function's note).
4. Write DSL, then optionally score it against DDS par and champion.

DATA
----
Traces come from `brill_remote_eval.py --traces`. Keep the training seed
different from the evaluation seed or the distilled system is scored on
boards it trained on.
"""
import argparse
import json
import os
import random
import sys
from collections import Counter
from typing import Any, Dict, List, Optional, Tuple

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(REPO, "src"))

from bid.brill.convert import (deal_pbn as deal_pbn_of, hand_from_pbn,  # noqa: E402
                               parse_call, seat_from_letter)
from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition  # noqa: E402
from bid.features import BridgeFeatures                        # noqa: E402
from bid.learner import ID3DecisionTree, id3_tree_to_rules    # noqa: E402

SYSTEM_DIR = os.path.join(REPO, "system")


def featurise(rows: List[Dict[str, Any]]) -> Tuple[List[Dict[str, Any]],
                                                   List[Any], List[str],
                                                   List[Tuple]]:
    """(features, target calls, skip reasons, contexts) for each trace.

    `contexts` keeps the raw (hand, history, seat, dealer, vuln) so a fitted
    net can be scored against held-out traces later.
    """
    X, y, skipped, ctxs = [], [], [], []
    for r in rows:
        try:
            hand = hand_from_pbn(r["hand"])
            history = [parse_call(t) for t in (r.get("ctx") or "").split("-")
                       if t.strip()]
            call = parse_call(r["call"])
            seat = seat_from_letter(r["seat"])
            dealer = seat_from_letter(r["dealer"])
            vuln = int(r.get("vul", 0))
            feats = BridgeFeatures.extract_all(hand, history, seat, dealer,
                                               vuln)
        except Exception as exc:                                # noqa: BLE001
            skipped.append("%s: %s" % (type(exc).__name__, exc))
            continue
        X.append(feats)
        y.append(call)
        ctxs.append((hand, history, seat, dealer, vuln))
    return X, y, skipped, ctxs


def fidelity(net: DecisionNet, ctxs: List[Tuple],
             y: List[Any]) -> Tuple[float, int]:
    """How often the distilled net reproduces Brill's call on held-out traces.

    This is the same question `brill_live_check.py` asks of the rule capture
    (71.1%), so it is directly comparable — and unlike the board-level
    evaluation it is not dominated by deal-to-deal variance, which is why it
    is reported even when the board sample is too small to resolve.
    """
    if not ctxs:
        return 0.0, 0
    ok = 0
    for (hand, history, seat, dealer, vuln), want in zip(ctxs, y):
        acts = net.actions(hand, history, seat, dealer, vuln)
        pred = acts[0] if acts else None
        if pred is not None and str(pred) == str(want):
            ok += 1
    return 100.0 * ok / len(ctxs), len(ctxs)


def group_key(feats: Dict[str, Any], mode: str) -> Any:
    """Partition traces into positions a single ID3 tree can model.

    ID3 here splits only on numeric/bool features, so it cannot partition on
    call *identity* (`opp_last_call` is a string). These keys are the numeric
    proxies. Finer keys separate more positions but need proportionally more
    traces — `bid` is only usable once the trace set is in the tens of
    thousands.
    """
    if mode == "none":
        return "all"
    if mode == "opening":
        return bool(feats.get("is_opening"))
    if mode == "bid":
        # last_bid_strain is a STRING ('NONE'/'C'/'D'/'H'/'S'/'NT'), so key on
        # it directly — RuleCondition handles string equality fine (brill.dsl
        # is full of `partner_last_call == 'NONE'`).
        return (_num(feats.get("auction_len")),
                _num(feats.get("last_bid_level")),
                str(feats.get("last_bid_strain", "NONE")))
    return _num(feats.get("auction_len"))


def guard_for(key: Any, mode: str) -> List[DecisionNetRule]:
    """Conditions that pin a learned tree to the position it was trained on."""
    if mode == "none":
        return []
    if mode == "opening":
        conds = [RuleCondition("is_opening", "==", bool(key))]
    elif mode == "bid":
        conds = [RuleCondition("auction_len", "==", int(key[0])),
                 RuleCondition("last_bid_level", "==", int(key[1])),
                 RuleCondition("last_bid_strain", "==", str(key[2]))]
    else:
        conds = [RuleCondition("auction_len", "==", int(key))]
    return [DecisionNetRule("guard", None, conds)]


def _num(v: Any, default: int = 0) -> int:
    try:
        return int(v)
    except (TypeError, ValueError):
        return default


def key_label(key: Any) -> str:
    if not isinstance(key, tuple):
        return str(key)
    return "L%d/%d/%s" % (key[0], key[1], key[2])


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--traces", default=os.path.join("data",
                                                     "brill_traces_train.jsonl"))
    ap.add_argument("--out", default=os.path.join(SYSTEM_DIR,
                                                  "brill_distilled.dsl"))
    ap.add_argument("--group", default="auction_len",
                    choices=["auction_len", "bid", "opening", "none"])
    ap.add_argument("--max-depth", type=int, default=8)
    ap.add_argument("--min-samples", type=int, default=25,
                    help="below this a group gets a single majority rule")
    ap.add_argument("--holdout", type=float, default=0.2,
                    help="fraction held out when --folds 1")
    ap.add_argument("--folds", type=int, default=1,
                    help="k-fold CV for the fidelity estimate (1 = single "
                         "holdout). Use >1 before comparing configurations: "
                         "a 488-trace holdout carries ~2pp of noise.")
    ap.add_argument("--eval-boards", type=int, default=250)
    ap.add_argument("--eval-seed", type=int, default=101,
                    help="was 42, which is ALSO a harvest seed, so 250 of "
                         "600 eval boards were in the training set and the "
                         "headline number was quietly optimistic. Use a seed "
                         "no harvest has ever used; the run now warns anyway.")
    ap.add_argument("--no-eval", action="store_true")
    ap.add_argument("--stakes-boost", type=float, default=0.0,
                    help="duplicate high-stakes calls (level 2/3/4+, doubles) "
                         "by their IMP-at-stake weight. Trades raw agreement "
                         "-- which the tree maximises by acing PASS -- for "
                         "accuracy on the game and slam decisions that "
                         "actually decide boards. See brill_miss_stakes.py.")
    ap.add_argument("--stakes-scope", default="all",
                    choices=["all", "uncontested"],
                    help="with 'uncontested', amplify only auctions the "
                         "opponents have not entered (opponents_bid false)")
    ap.add_argument("--pass-cap", type=float, default=0.0,
                    help="keep at most this many PASS traces per non-PASS "
                         "trace (0 = off). Trades fidelity for willingness "
                         "to bid; see cap_passes().")
    ap.add_argument("--learning-curve", action="store_true",
                    help="fidelity vs training size; answers 'is another "
                         "harvest worth it?' — a still-rising curve says "
                         "data-limited, a flat one says model-limited")
    args = ap.parse_args()

    if not os.path.exists(args.traces):
        sys.exit("no traces at %s — run:\n  python3 research/"
                 "brill_remote_eval.py --boards N --traces %s"
                 % (args.traces, args.traces))

    rows = [json.loads(l) for l in open(args.traces) if l.strip()]
    print("traces: %d" % len(rows))
    X, y, skipped, ctxs = featurise(rows)
    if skipped:
        print("skipped %d (%s)" % (len(skipped), skipped[0]))
    print("featurised: %d" % len(X))

    # Deterministic holdout for fidelity. Board-level evaluation is far too
    # noisy to grade a fit on small samples (60 boards resolves ~1.0 IMP),
    # so this is the primary signal until the trace set is large.
    #
    # With k-fold the estimate is averaged over folds; a single 20% holdout of
    # 2,442 traces is only ~488 examples, i.e. ~2.1pp of standard error at
    # 70% accuracy — wide enough that the spread between groupings could be
    # noise, so do not tune on it without folds.
    folds = max(1, int(args.folds))
    order = list(range(len(X)))
    random.Random(0).shuffle(order)
    fold_of = {}
    for pos, i in enumerate(order):
        fold_of[i] = pos % folds

    def cap_passes(idx: List[int]) -> List[int]:
        """Thin out PASS traces so the tree cannot win by always passing.

        PASS is ~61% of every trace set and by far the easiest label, so a
        tree scored on plain accuracy reaches for it constantly -- leaves
        collapse to PASS and the distilled system lets auctions die that a
        real system would open. That is expensive: a passed-out board scores
        0 against a par that is usually worth 9+ IMP.

        Capping at `r` keeps at most r PASS traces per non-PASS trace. It
        trades fidelity (which falls, and should be reported as falling)
        for a willingness to bid.
        """
        r = args.pass_cap
        if not r or r <= 0:
            return idx
        passes = [i for i in idx if str(y[i]) == "PASS"]
        others = [i for i in idx if str(y[i]) != "PASS"]
        keep = int(r * len(others))
        if keep >= len(passes):
            return idx
        random.Random(1).shuffle(passes)
        return sorted(others + passes[:keep])

    def stakes_weight(call: Any) -> int:
        """Rough IMP at stake in getting this call right.

        Measured, not guessed: `brill_miss_stakes.py` shows held-out
        agreement is 96.5% on PASS and 92.6% on 1-level calls but **22-27%
        on level 3 / 4+** -- game and slam decisions, worth 6-13 IMP. 84% of
        all disagreement mass sits on level-2+ calls, which are only 25% of
        the data. The tree is excellent at the cheap decisions and wrong
        four times out of five on the expensive ones, because plain accuracy
        weights a PASS exactly as much as a slam bid.
        """
        s = str(call).strip()
        if s in ("X", "XX"):
            return 2
        if s and s[0].isdigit():
            return {"1": 1, "2": 2, "3": 3}.get(s[0], 4)
        return 1

    def boost_stakes(idx: List[int]) -> List[int]:
        """Duplicate high-stakes traces so they are not outvoted by PASS.

        Deliberately NOT the same as --pass-cap: that thins PASS everywhere,
        including openings where passing is simply correct, and it made
        things much worse (-1.91). This leaves PASS alone and only amplifies
        the calls whose errors are expensive.

        `--stakes-scope uncontested` restricts the amplification to auctions
        the opponents have not entered. Unrestricted boosting cost -1.31 to
        -2.10 IMP/board and the damage was almost entirely in contested
        auctions (+1.23 -> -2.49), while the diagnosed weakness -- under-
        bidding game -- is an UNcontested problem. So the two effects may be
        separable: bid more when nobody is competing, bid as before when
        they are.
        """
        b = args.stakes_boost
        if not b or b <= 0:
            return idx
        out: List[int] = []
        for i in idx:
            w = stakes_weight(y[i])
            if args.stakes_scope == "uncontested" and X[i].get("opponents_bid"):
                w = 1
            out.extend([i] * max(1, int(round(1 + (w - 1) * b))))
        return out

    def fit_net(train_idx: List[int]) -> DecisionNet:
        net = DecisionNet("brill_distilled")
        train_idx = boost_stakes(cap_passes(train_idx))
        groups: Dict[Any, Tuple[List[Dict[str, Any]], List[Any]]] = {}
        for i in train_idx:
            k = group_key(X[i], args.group)
            gx, gy = groups.setdefault(k, ([], []))
            gx.append(X[i])
            gy.append(y[i])
        for k in sorted(groups, key=lambda v: (isinstance(v, str), v)):
            gx, gy = groups[k]
            maj_call = Counter(gy).most_common(1)[0][0]
            guard = guard_for(k, args.group)
            if len(gx) < args.min_samples or len(set(map(str, gy))) < 2:
                conds = [RuleCondition(c.key, c.op, c.value)
                         for r in guard for c in r.conditions]
                net.add_rule(DecisionNetRule(
                    "BD_%s_maj" % key_label(k), maj_call, conds, priority=1,
                    description="majority call (n=%d)" % len(gx)))
                continue
            tree = ID3DecisionTree(max_depth=args.max_depth)
            tree.fit(gx, gy)
            for r in id3_tree_to_rules(tree, guard, "BD_%s" % key_label(k),
                                       base_priority=10,
                                       description="distilled from Brill /bid"):
                net.add_rule(r)
        return net

    if args.learning_curve:
        # Fixed 20% test pool, trained on increasing fractions of the rest.
        # A curve still climbing at 100% says buy more traces; a flat one
        # says the model (depth / grouping / features) is binding and a
        # bigger harvest is a waste of wall-clock.
        n_test = max(1, len(order) // 5)
        test = order[:n_test]
        pool = order[n_test:]
        print("\nlearning curve (held-out %d traces):" % len(test))
        print("  %8s %6s %10s %8s" % ("train", "frac", "fidelity", "rules"))
        prev = None
        for frac in (0.1, 0.2, 0.4, 0.6, 0.8, 1.0):
            k = max(1, int(len(pool) * frac))
            n = fit_net(pool[:k])
            acc, _ = fidelity(n, [ctxs[i] for i in test],
                              [y[i] for i in test])
            delta = "" if prev is None else "   (%+.1f)" % (acc - prev)
            prev = acc
            print("  %8d %5.0f%% %9.1f%% %8d%s"
                  % (k, 100.0 * frac, acc, len(n.rules), delta))
        return 0

    if folds > 1:
        accs = []
        for f in range(folds):
            tr = [i for i in order if fold_of[i] != f]
            te = [i for i in order if fold_of[i] == f]
            n = fit_net(tr)
            acc, _ = fidelity(n, [ctxs[i] for i in te], [y[i] for i in te])
            accs.append(acc)
        base = Counter(str(c) for c in y).most_common(1)[0]
        mean = sum(accs) / len(accs)
        sd = (sum((a - mean) ** 2 for a in accs) / (len(accs) - 1)) ** 0.5 \
            if len(accs) > 1 else 0.0
        print("%d-fold CV agreement with Brill: %.1f%% (fold sd %.1f, "
              "folds %s)" % (folds, mean, sd,
                             " ".join("%.0f" % a for a in accs)))
        print("  majority-class baseline %.1f%% (%s)"
              % (100.0 * base[1] / len(y), base[0]))
        print("  NOTE: sd across folds measures fold variance, not the "
              "standard error of the mean; se ~= sd/sqrt(%d)." % folds)

    # Final model: train on everything (or the holdout split if requested).
    n_test = int(len(X) * args.holdout) if folds == 1 else 0
    test_idx = set(range(len(X))[-n_test:]) if n_test else set()
    train_idx = [i for i in range(len(X)) if i not in test_idx]
    net = fit_net(train_idx)
    if n_test:
        print("train %d / held-out %d" % (len(train_idx), n_test))

    # (the per-group fit now lives in fit_net above, so it can be re-run
    #  once per CV fold; this is the single final fit on all training data)

    print("\ndistilled rules: %d" % len(net.rules))
    if n_test:
        test_ctx = [ctxs[i] for i in sorted(test_idx)]
        test_y = [y[i] for i in sorted(test_idx)]
        acc, n = fidelity(net, test_ctx, test_y)
        base = Counter(str(c) for c in test_y).most_common(1)[0]
        print("held-out agreement with Brill: %.1f%% (%d traces); "
              "majority-class baseline %.1f%% (%s)"
              % (acc, n, 100.0 * base[1] / n, base[0]))
    with open(args.out, "w") as fh:
        fh.write(net.export_dsl())
    print("wrote %s" % args.out)

    if args.no_eval or args.eval_boards <= 0:
        return 0

    # Score the distilled system exactly like any other system.
    from bid.arena import BiddingArena
    from bid.eval_vs_dds import (build_deals, imp_diff, imp_loss,
                                 load_decision_net_dsl, precompute,
                                 resolution_of, seed_board)
    distilled = load_decision_net_dsl(args.out)
    distilled.name = "brill_distilled"
    champ = load_decision_net_dsl(os.path.join(SYSTEM_DIR,
                                               "champion_system.dsl"))
    champ.name = "champion_system"

    deals = build_deals(args.eval_boards, seed=args.eval_seed,
                        include_stratified=False)
    arena = BiddingArena()
    dd = precompute(deals)
    print("\nevaluating on %d boards (seed %d, resolution ~%.2f)"
          % (len(deals), args.eval_seed, resolution_of(len(deals))))

    # A board-level evaluation is only meaningful on boards the model has
    # never seen. This is easy to get wrong: the harvest seed and the eval
    # seed look like unrelated knobs, and --eval-seed used to default to 42,
    # which is also a harvest seed -- so 250 of 600 eval boards were in the
    # training set and the headline number was quietly optimistic. Fail loud.
    train_boards = set()
    for _r in rows:
        _d = _r.get("deal", "")
        if ":" in _d:
            train_boards.add(_d.split(":", 1)[1])
    eval_boards = {deal_pbn_of(dict(d.hands), d.dealer).split(":", 1)[1]
                   for d in deals}
    overlap = train_boards & eval_boards
    if overlap:
        print("  !! CONTAMINATED: %d/%d eval boards are in the training set "
              "-- this number is optimistic, use a different --eval-seed"
              % (len(overlap), len(deals)))

    res = {}
    for name, netx in (("brill_distilled", distilled),
                       ("champion_system", champ)):
        diffs, losses, passed = [], [], 0
        live_losses = []        # boards that actually produced a contract
        for i, deal in enumerate(deals):
            par_score, _pc, _ddt = dd[i]
            seed_board(args.eval_seed, i)
            hist, score = arena.play_board(deal, netx, netx)
            diffs.append(imp_diff(score, par_score))
            losses.append(imp_loss(score, par_score))
            if not any(str(c) != "PASS" for c in hist):
                passed += 1
            else:
                live_losses.append(imp_loss(score, par_score))
        n = len(deals)
        res[name] = (diffs, losses)
        # A passed-out board scores 0 against a par that is often hundreds,
        # so it is worth ~9 IMP on its own. Reporting the pass-out-free
        # average separates "the system bids badly" from "the system never
        # bids" — two failures with very different fixes.
        live = sum(live_losses) / len(live_losses) if live_losses else 0.0
        print("  %-18s signed %+6.2f | abs %5.2f | passed_out %d/%d "
              "| abs excl. pass-outs %5.2f"
              % (name, sum(diffs) / n, sum(losses) / n, passed, n, live))

    d_diffs, d_losses = res["brill_distilled"]
    c_diffs, c_losses = res["champion_system"]

    def paired(base, cand, higher_is_better):
        d = [cand[i] - base[i] for i in range(len(base))] if higher_is_better \
            else [base[i] - cand[i] for i in range(len(base))]
        m = sum(d) / len(d)
        sd = (sum((x - m) ** 2 for x in d) / (len(d) - 1)) ** 0.5
        se = sd / (len(d) ** 0.5)
        return m, se, (m / se if se else 0.0)

    a_m, a_se, a_t = paired(c_losses, d_losses, False)
    s_m, s_se, s_t = paired(c_diffs, d_diffs, True)
    print("\n  distilled vs champion (positive = distilled better):")
    print("    abs dev from par : %+.2f  se %.2f  t %+.2f" % (a_m, a_se, a_t))
    print("    signed vs par    : %+.2f  se %.2f  t %+.2f" % (s_m, s_se, s_t))
    return 0


if __name__ == "__main__":
    sys.exit(main())
