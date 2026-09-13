#!/usr/bin/env python3
"""
Evaluate every bidding system in the repo against native DDS par results.
Loads champion_system.dsl / improved_system.dsl back into DecisionNets,
plays full auctions for each system on a fixed deal set, scores final
contracts with exact DDS tricks, ranks systems by regret vs par.
"""

import argparse
import os
import random
import re
import time
from collections import Counter
from typing import Any, Dict, List, Tuple

from bid.models import Seat, Strain, Call, CallType
from bid.sampling import Deal, PartialState
from bid.experience import StratifiedDealGenerator
from bid.dds import DDSolver
from bid.arena import BiddingArena
from bid.pidm import PIDMEngine
from bid.sampling import RBMBMCSampler
from bid.invention import BidInventionEngine
from bid.optimizer import SystemOptimizer
from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition
from bid.diagnostics import ParDiagnosticEngine
from bid.scoring import score_to_imp

STRAIN_STR = ['C', 'D', 'H', 'S', 'NT']
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SYSTEM_DIR = os.path.join(REPO_ROOT, "system")


def parse_call(s: str) -> Call:
    s = s.strip()
    if s in ("X", "DBL"):
        return Call(CallType.DOUBLE)
    if s == "XX":
        return Call(CallType.REDOUBLE)
    if s.upper() in ("P", "PASS"):
        return Call(CallType.PASS)
    level = int(s[0])
    strain_s = s[1:].upper()
    strain = {"C": Strain.CLUBS, "D": Strain.DIAMONDS, "H": Strain.HEARTS,
              "S": Strain.SPADES, "NT": Strain.NT}[strain_s]
    return Call(CallType.BID, level, strain)


def _split_conditions(text: str) -> List[str]:
    parts, depth, quote, cur = [], 0, None, ""
    for ch in text:
        if quote:
            cur += ch
            if ch == quote:
                quote = None
            continue
        if ch in "'\"":
            quote = ch
            cur += ch
        elif ch == "[":
            depth += 1
            cur += ch
        elif ch == "]":
            depth -= 1
            cur += ch
        elif ch == "," and depth == 0:
            parts.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        parts.append(cur.strip())
    return [p for p in parts if p]


def _parse_value(tok: str) -> Any:
    tok = tok.strip()
    if tok.startswith("["):
        inner = tok[1:-1].strip()
        if not inner:
            return []
        return [_parse_value(t) for t in _split_conditions(inner)]
    if (tok.startswith("'") and tok.endswith("'")) or (tok.startswith('"') and tok.endswith('"')):
        return tok[1:-1]
    if tok == "True":
        return True
    if tok == "False":
        return False
    try:
        return int(tok)
    except ValueError:
        pass
    try:
        return float(tok)
    except ValueError:
        pass
    return tok


def parse_condition(text: str) -> RuleCondition:
    m = re.match(r"^(\w+)\s*(==|!=|>=|<=|>|<|not_in|in)\s*(.+)$", text.strip())
    if not m:
        raise ValueError(f"Bad condition: {text!r}")
    key, op, val = m.group(1), m.group(2), m.group(3)
    return RuleCondition(key, op, _parse_value(val))


class ResolvedCallClassifier:
    def __init__(self, call: Call):
        self.call = call

    def predict(self, features: Dict[str, Any]) -> Call:
        return self.call


def load_decision_net_dsl(path: str) -> DecisionNet:
    """Loads both exported formats:
    one-line:  RULE <id> PRIORITY <n> ACTION <call> WHEN c1, c2, ...
    block:     RULE <id>: / CALL: / PRIORITY: / CONDITION: (+ INTERSECTION trees)
    """
    name = os.path.splitext(os.path.basename(path))[0]
    net = DecisionNet(name)
    with open(path) as f:
        lines = f.readlines()

    i = 0
    while i < len(lines):
        line = lines[i].rstrip("\n")
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            i += 1
            continue

        one_line = re.match(r"^RULE\s+(\S+)\s+PRIORITY\s+(-?\d+)\s+ACTION\s+(\S+)\s+WHEN\s+(.+)$", stripped)
        if one_line:
            rid, prio, action, conds = one_line.groups()
            conditions = [parse_condition(c) for c in _split_conditions(conds)]
            net.add_rule(DecisionNetRule(rid, parse_call(action), conditions, priority=int(prio)))
            i += 1
            continue

        block_rule = re.match(r"^RULE\s+(.+?):$", stripped)
        if block_rule:
            rid = block_rule.group(1).strip()
            call, prio, conditions = None, 10, []
            is_neg = False
            i += 1
            while i < len(lines):
                sub = lines[i].rstrip("\n").strip()
                if sub.startswith("RULE ") or sub.startswith("INTERSECTION"):
                    break
                if sub.startswith("CALL:"):
                    call = parse_call(sub.split("CALL:", 1)[1])
                elif sub.startswith("PRIORITY:"):
                    prio = int(sub.split("PRIORITY:", 1)[1].strip())
                elif sub.startswith("NEGATIVE:"):
                    is_neg = sub.split("NEGATIVE:", 1)[1].strip() == "True"
                elif sub.startswith("CONDITION:"):
                    conditions.append(parse_condition(sub.split("CONDITION:", 1)[1]))
                i += 1
            if call is not None:
                net.add_rule(DecisionNetRule(rid, call, conditions,
                                             is_negative=is_neg, priority=prio))
            continue

        inter = re.match(r"^INTERSECTION\s+(.+?):$", stripped)
        if inter:
            rule_ids = [t.strip() for t in inter.group(1).split("^")]
            resolved = None
            tree = None
            i += 1
            while i < len(lines):
                raw = lines[i].rstrip("\n")
                sub = raw.strip()
                if sub.startswith("RULE ") or sub.startswith("INTERSECTION"):
                    break
                if sub == "TREE:":
                    # consume the indented SPLIT/LEAF block that follows
                    block = []
                    i += 1
                    while i < len(lines):
                        r2 = lines[i].rstrip("\n")
                        if not r2.strip():
                            i += 1
                            continue
                        if (len(r2) - len(r2.lstrip())) >= 4:
                            block.append(r2)
                            i += 1
                        else:
                            break
                    tree = parse_id3_tree(block)
                    continue
                if sub.startswith("RESOLVED_CALL:"):
                    resolved = parse_call(sub.split("RESOLVED_CALL:", 1)[1])
                i += 1
            if len(rule_ids) > 1:
                if tree is not None:
                    net.attach_refinement(tuple(rule_ids), tree)
                elif resolved is not None:
                    net.attach_refinement(tuple(rule_ids),
                                          ResolvedCallClassifier(resolved))
            continue

        i += 1

    if not net.rules:
        # Check if the DSL file is in SystemTranslator format (e.g., gib.dsl)
        try:
            from bid.translator import SystemTranslator
            translator = SystemTranslator()
            sys = translator.load_system_with_conventions(path)
            if sys and sys.rules:
                net.attach_system(sys)
        except Exception:
            pass

    return net


def build_deals(num_random: int, seed: int = 42, include_stratified: bool = True,
                vuln_mode: str = "random") -> List[Deal]:
    """vuln_mode: 'random' rotates vulnerability across boards (realistic);
    'none' keeps every board non-vulnerable (legacy behaviour)."""
    import random
    random.seed(seed)
    from bid.models import Suit
    vrng = random.Random(seed * 31 + 7)

    def _assign(d):
        if vuln_mode == "random":
            d.vuln = vrng.randrange(4)
        return d

    deals = [_assign(Deal.random_deal(dealer=Seat.NORTH)) for _ in range(num_random)]
    if not include_stratified:
        return deals
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.SOUTH, suit_stratum=(Suit.SPADES, 8))))
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.NORTH, suit_stratum=(Suit.HEARTS, 8))))
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.SOUTH, suit_stratum=(Suit.DIAMONDS, 7))))
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.SOUTH, hcp_stratum=(22, 25))))
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.NORTH, hcp_stratum=(16, 18))))
    deals.append(_assign(StratifiedDealGenerator.generate_stratified_deal(Seat.SOUTH, hcp_stratum=(0, 4))))
    return deals


def precompute(deals: List[Deal]) -> List[Tuple[int, str, dict]]:
    out = []
    for deal in deals:
        par_score, par_contract = DDSolver.calculate_par(deal, deal.vuln)
        dd_table = DDSolver.solve_dd_table(deal)
        out.append((par_score, par_contract, dd_table))
    return out


def contract_string(pstate: PartialState) -> str:
    c = pstate.get_contract()
    if not c:
        return "Pass"
    lvl, strain, decl, dbl = c
    x = "X" if dbl == 1 else ("XX" if dbl == 2 else "")
    return f"{lvl}{STRAIN_STR[strain.value]} by {decl.name}"


# Below this many boards per worker, spawn overhead (~2.5 s each) outweighs the
# parallel gain, so evaluate_system falls back to serial.
MIN_BOARDS_PER_WORKER = 8


def seed_board(seed, board_index) -> None:
    """Seed the world sampler for one board, deterministically.

    `Deal.completion_from_known` shuffles with the GLOBAL `random` module, so
    the worlds PIDM searches are drawn from whatever state the RNG happens to
    be in. Seeding once per run means board i's worlds depend on how many draws
    boards 0..i-1 consumed — and that differs between two systems, because a
    different rule set makes a different number of calls. Consequence: two runs
    of the *same* configuration disagreed (measured: 0.0123 IMP/board between
    two identical 818-board runs), and base/candidate quietly compared systems
    playing different worlds, which inflates the paired sd.

    Seeding per board index makes board i's worlds a function of (seed, i)
    alone, so the same board is scored against the same worlds in every run.
    """
    if seed is None:
        return
    random.seed(int(seed) * 1000003 + int(board_index))


def imp_loss(score: float, par_score: float) -> float:
    """IMP loss for a single board (24-band scale, so it saturates).

    Raw point regret is dominated by slam-level swings: one -910 board moves a
    38-board mean by ~24 pts, which is larger than the entire spread between a
    good and a bad system.  Converting the difference to IMPs before averaging
    caps any single board at 24, so the mean tracks how often you are wrong
    and by how much in scoring terms, not how big the biggest accident was.

    **This is an ABSOLUTE deviation, not a loss.** The `abs()` means beating
    par scores exactly as badly as falling short of it. Measured on champion
    (830 boards, §6.28): 45.3% of boards beat par for +2,900 IMP against
    −2,378 IMP of genuine shortfall, so **54.9% of the reported "loss" is
    actually out-performing par**, and the mean signed value is *+0.63*
    IMP/board while this metric reports 6.36.

    Kept as-is deliberately: it is the metric behind 28 recorded flywheel
    versions and the leaderboard, and silently flipping its sign would
    invalidate that history. Use `mean_imp_diff` (signed, higher is better)
    when you mean "am I winning". See §6.28.
    """
    return abs(score_to_imp(int(round(score - par_score))))


def imp_diff(score: float, par_score: float) -> float:
    """Signed IMP difference from par for one board. POSITIVE = beat par.

    Counterpart to `imp_loss`. Averaging this measures whether a system is
    ahead of or behind double-dummy par, instead of merely how far from it.
    """
    return score_to_imp(int(round(score - par_score)))


# Metrics where a smaller number is better (used by the flywheel to flip the
# sign of a "gain" and by the leaderboard to decide sort direction).
LOWER_IS_BETTER = {"avg_imp_loss", "mean_imp_loss"}

# Smaller-is-better metrics need a much smaller acceptance floor because their
# natural scale is ~1-5 units/board rather than ~100s of points.
# `mean_imp_diff` is deliberately NOT in LOWER_IS_BETTER: it is signed, so
# higher is better (§6.28).
MIN_DELTA_BY_METRIC = {"avg_score": 0.5, "avg_score_sds": 0.5,
                       "mean_imp_loss": 0.03, "mean_imp_diff": 0.03}

# Empirical screening noise, measured 2026-09-11.
#
# The same system scored on N independent 96-deal sets does NOT return the
# same number. Measured over 5 sets (seeds 11/22/33/44/55), 96 deals each,
# fixed opponent panel, metric mean_imp_loss:
#
#     champion_system  mean 6.569  sd 0.316  range 0.853
#     improved_system  mean 7.082  sd 0.437  range 1.137
#     paired (improved - champion)
#                      mean +0.529  sd 0.422  sem 0.189   n=5, t=2.81
#
# So one 96-deal measurement carries a roughly +/-0.6 to +/-0.85 95% interval,
# and even a *paired* comparison across deal sets has sd ~0.42.
#
# MIN_DELTA_BY_METRIC above is a train-set EFFECT SIZE floor: on the fixed
# training set the baseline/candidate comparison is paired and exact, so it
# answers "is this change worth bothering with", not "does it generalise".
# Do not read it as a significance threshold — 0.03 is ~20x below the noise.
SCREENING_NOISE_SD = {"mean_imp_loss": 0.42,    # sd of a paired 96-deal delta
                      "mean_imp_diff": 0.61}   # §6.28 calibration, see below
#
# mean_imp_diff calibration (2026-09-12), same protocol, 5 x 96-deal sets:
#
#     champion_system  signed mean +0.357  sd 0.760  range 1.882
#     improved_system  signed mean -1.033  sd 0.803  range 2.216
#     paired (champion - improved)
#                      mean +1.390  sd 0.608  sem 0.272   n=5, t=5.11
#
# Two things follow, and they pull in OPPOSITE directions:
#
#   * The signed metric is NOISIER per system across deal sets (sd 0.76-0.80
#     vs 0.32-0.44 for the abs metric). Its absolute level swings with how many
#     boards in the set happen to be "E/W declares par" (§6.28), so never
#     compare signed LEVELS across different deal sets.
#   * But the paired DELTA is ~2.6x larger (+1.390 vs +0.529) for only ~1.4x
#     more noise, so a paired comparison is better powered: t 5.11 vs 2.81 on
#     the same 480 boards.
#
# Hence 0.61 = the paired-delta sd, matching the convention of the 0.42 above.
# The abs metric's pooled per-system sd was reproduced at 0.426 (published
# 0.42), which validates the original calibration.

# Per-board sd of the *difference* between two systems, measured directly from
# paired per-board IMP losses (champion vs improved, seeds 42/7/13, 96 boards):
#   3.99, 3.20, 3.59  -> ~4.0
#
# This is the number that actually sets the budget, because it is the unit the
# standard error scales from: se = BOARD_IMP_LOSS_SD / sqrt(n_boards).
# Note it is close to the per-board sd of the metric itself (~3.1-4.3), i.e.
# the two systems' losses are only weakly correlated and *pairing buys less
# than you would hope* — they go wrong on largely different boards.
BOARD_IMP_LOSS_SD = 4.0


def boards_needed(target: float, sd: float = BOARD_IMP_LOSS_SD,
                  z: float = 1.96) -> int:
    """Boards required to resolve a true difference of `target` IMP/board.

    Answers "is my deal budget big enough?" directly, which is the question the
    flywheel's fixed effect floor cannot answer.
    """
    if not target or target <= 0 or sd <= 0:
        return -1
    return int(-(-(z * sd / target) ** 2 // 1))


def resolution_of(n_boards: int, metric: str = "mean_imp_loss",
                  z: float = 1.96) -> float:
    """Smallest difference `n_boards` can resolve, in metric units.

    The companion to `boards_needed`: that one sizes a run, this one grades the
    run you already configured.
    """
    sd = BOARD_IMP_LOSS_SD if metric in LOWER_IS_BETTER else None
    if sd is None or n_boards < 1:
        return float("inf")
    return z * sd / (n_boards ** 0.5)


def paired_imp_test(base_res: Dict[str, Any], cand_res: Dict[str, Any],
                    z: float = 1.96) -> Dict[str, float]:
    """Paired significance test for two systems scored on the SAME boards.

    `mean_imp_loss` averages a per-board quantity, so the two systems can be
    compared board-by-board rather than mean-to-mean. That pairing is worth a
    great deal: the board-to-board variation (which deals happen to be slam
    hands) is shared and largely cancels, leaving only the variation in how the
    two systems actually differ.

    Sign convention follows `metric_gain`: **positive == candidate better**
    (here, candidate loses fewer IMPs).

    Returns mean difference, its sd/se/CI, t, and `n_needed` — how many boards
    would be required to resolve this difference at 95%, which is the number
    that tells you whether a screening budget is adequate.
    """
    a = list(base_res.get("imp_losses") or [])
    b = list(cand_res.get("imp_losses") or [])
    n = min(len(a), len(b))
    if n == 0:
        return {"n": 0, "mean_diff": 0.0, "sd": 0.0, "se": 0.0,
                "ci_lo": 0.0, "ci_hi": 0.0, "t": 0.0, "n_needed": float("inf")}
    diffs = [a[i] - b[i] for i in range(n)]          # positive => candidate better
    mean = sum(diffs) / n
    var = sum((d - mean) ** 2 for d in diffs) / (n - 1) if n > 1 else 0.0
    sd = var ** 0.5
    se = sd / (n ** 0.5) if n else float("inf")
    t = (mean / se) if se else (0.0 if mean == 0 else float("inf"))
    # boards needed for the CI half-width to fall below |mean|
    if se and mean:
        n_needed = (z * sd / abs(mean)) ** 2
    else:
        n_needed = float("inf")
    return {"n": n, "mean_diff": mean, "sd": sd, "se": se,
            "ci_lo": mean - z * se, "ci_hi": mean + z * se,
            "t": t, "n_needed": n_needed}


def min_detectable_effect(n_sets: int, metric: str = "mean_imp_loss",
                          z: float = 1.96) -> float:
    """Smallest true gain that `n_sets` deal sets can resolve at ~95%.

    Used to warn when a "validated" gain is smaller than the measurement can
    actually see. Returns inf for metrics we have not calibrated, so an
    uncalibrated metric never silently looks resolvable.
    """
    sd = SCREENING_NOISE_SD.get(metric)
    if not sd or n_sets < 1:
        return float("inf")
    return z * sd / (n_sets ** 0.5)


def parse_id3_tree(block: List[str]):
    """Rebuild an ID3DecisionTree from the indented SPLIT/LEAF block written by
    `DecisionNet.export_tree_lines`.

    Lazily imports learner to avoid a cycle (learner imports decision_net).
    Returns None for an empty or malformed block, in which case the caller
    falls back to any RESOLVED_CALL present.
    """
    rows = [b for b in block if b.strip()]
    if not rows:
        return None
    from bid.learner import ID3Node, ID3DecisionTree

    depth = lambda s: len(s) - len(s.lstrip())
    base = depth(rows[0])
    pos = [0]

    def build(expect: int):
        if pos[0] >= len(rows):
            return None
        line = rows[pos[0]]
        if depth(line) != expect:
            return None
        text = line.strip()
        pos[0] += 1
        if text.startswith("LEAF"):
            try:
                return ID3Node(is_leaf=True,
                               prediction=parse_call(text[len("LEAF"):].strip()))
            except Exception:
                return None
        m = re.match(r"^SPLIT\s+(\w+)\s*<=\s*(-?[\d.]+)"
                     r"(?:\s+fallback\s+(\S+))?$", text)
        if not m:
            return None
        fallback = None
        if m.group(3):
            try:
                fallback = parse_call(m.group(3))
            except Exception:
                fallback = None
        node = ID3Node(feature_name=m.group(1), threshold=float(m.group(2)),
                       is_continuous=True, prediction=fallback)
        node.left_child = build(expect + 2)
        node.right_child = build(expect + 2)
        return node

    root = build(base)
    if root is None:
        return None
    tree = ID3DecisionTree()
    tree.root = root
    return tree


def build_opponent_panel() -> List[Tuple[str, DecisionNet]]:
    """A fixed, heterogeneous panel of opponents for evaluation.

    Self-play (candidate vs itself) is a mirror: both sides run the same rules,
    so any adaptive behaviour cancels out and the loop converges to a fixed
    point of the system rather than to actual bidding strength.  Scoring
    against a *frozen* panel of unrelated archetypes breaks that symmetry —
    the panel never adapts, so a real improvement shows up as a real gain.

    The panel is deliberately not the evolving system and never changes
    between runs, so numbers stay comparable across versions.
    """
    opt = SystemOptimizer()
    return [
        ("SAYC", opt.create_sayc_baseline()),
        ("Precision", opt.create_precision_system()),
        ("2/1 GF", opt.create_modern_2over1()),
    ]


LEGACY_PANEL_FILES = ("blue_club.dsl", "precision.dsl", "gib.dsl")


def build_legacy_panel() -> List[Tuple[str, "DecisionNet"]]:
    """Opponent panel from the three hand-authored legacy-dialect systems (§6.34).

    `system/blue_club.dsl`, `precision.dsl` and `gib.dsl` are 183, 166 and 159
    rules, but they are written in the LEGACY dialect (`OPEN 1C:` / `HCP:` /
    `SHAPE:`) and parse to 0 rules under the DecisionNet loader. They load via
    `SystemTranslator().parse()` into a `BiddingSystem`, which `DecisionNet`
    reaches through its `wrapped_system` hook.

    `build_opponent_panel()` uses 10/8/15-rule `SystemOptimizer` skeletons
    instead, which is why every §6 number is weak-opponent-dependent: against
    these three, the champion->improved gap falls from +1.266 to +0.465 and
    MISSED_GAME drops by a third.

    They are only picklable because of the `LegacyTrigger` fix (§6.35); without
    it this raises on `jobs>1`. Each system is ~44 KB pickled.

    Prefer `--panel legacy` for new work and keep `--panel` (the default) for
    anything that must stay comparable with the 28 recorded versions of
    `improved_system.dsl`, which were all scored against the default panel.
    """
    from bid.translator import SystemTranslator

    out = []
    for fname in LEGACY_PANEL_FILES:
        path = os.path.join(SYSTEM_DIR, fname)
        if not os.path.exists(path):
            continue
        with open(path) as f:
            system = SystemTranslator().parse(f.read())
        net = DecisionNet(fname[:-4])
        net.wrapped_system = system
        out.append((fname[:-4], net))
    return out


def build_panel(kind: str = "default") -> List[Tuple[str, "DecisionNet"]]:
    """Resolve a panel name to a panel. `kind` is 'default', 'legacy' or 'none'."""
    if kind == "legacy":
        return build_legacy_panel()
    return build_opponent_panel()


def panel_opponent_for(deal_index: int, panel) -> DecisionNet:
    """Deterministic per-deal opponent assignment (deal i -> panel[i % n]).

    Rotating rather than fixed-per-run keeps the cost identical to self-play
    while still ensuring the candidate never faces a copy of itself.
    """
    return panel[deal_index % len(panel)][1]


def _eval_chunk(job) -> Dict[str, Any]:
    """Score one contiguous slice of the deal set (worker side of --jobs).

    Boards are independent, so this is embarrassingly parallel.

    Each board seeds the world sampler from `(seed, global board index)` — see
    `seed_board`. The offset matters: a chunk-local index would give board 0 of
    every chunk the same worlds, so a different `jobs` splitting would silently
    score a different set of random worlds.
    """
    # search_cfg was appended later; tolerate the older 10-tuple payload so an
    # out-of-tree caller does not break on unpacking.
    if len(job) >= 11:
        (deals, dd, net, opponent_panel, seed, run_diagnostics,
         sds_num_worlds, sds_seed, sds_condition, offset, search_cfg) = job[:11]
    else:
        (deals, dd, net, opponent_panel, seed, run_diagnostics,
         sds_num_worlds, sds_seed, sds_condition, offset) = job[:10]
        search_cfg = None

    import random as _rnd
    if seed is not None:
        _rnd.seed(seed * 7919 + offset)

    if sds_num_worlds:
        from bid.sds import SDSScorer
        sds_scorer = SDSScorer(num_worlds=sds_num_worlds, seed=sds_seed,
                               condition_factor=4 if sds_condition else 0)
    else:
        sds_scorer = None

    # Honour the caller's search config: the serial path uses the arena it is
    # given, so hardcoding here would make --jobs evaluate a different search.
    # search_cfg is (sample_size, max_iterations, timeout_sec, lookahead).
    if search_cfg:
        ss, mi, to, depth = search_cfg
    else:
        ss, mi, to, depth = 2, 6, 0.06, 1
    engine = PIDMEngine(sampler=RBMBMCSampler(sample_size=ss, max_iterations=mi,
                                              timeout_sec=to),
                        max_lookahead_depth=depth)
    arena = BiddingArena(engine=engine)

    acc = {"n": len(deals), "total_score": 0.0, "total_par": 0.0,
           "total_imp_loss": 0.0, "total_mean_imp_loss": 0.0,
           "total_imp_diff": 0.0,
           "total_sds": 0.0, "sds_boards": 0, "par_hits": 0,
           "makable_games": 0, "games_reached": 0, "scores": [],
           "imp_losses": [], "imp_diffs": [],
           "worst": [], "flaws": {}, "diagnostics": []}

    for i, deal in enumerate(deals):
        par_score, par_contract, dd_table = dd[i]
        # per-board, keyed on the GLOBAL board index so a chunk boundary does
        # not change which worlds a board is scored against
        seed_board(seed, offset + i)
        ew_net = panel_opponent_for(offset + i, opponent_panel) if opponent_panel else net
        history, score = arena.play_board(deal, net, ew_net)
        board_imp_loss = imp_loss(score, par_score)
        acc["total_mean_imp_loss"] += board_imp_loss
        # signed counterpart: imp_loss() is abs(), so it cannot tell winning
        # from losing (§6.28). kept per board for the same pairing reason.
        board_imp_diff = imp_diff(score, par_score)
        acc["total_imp_diff"] += board_imp_diff
        acc["imp_diffs"].append(board_imp_diff)
        # kept per board so two systems can be compared PAIRED on identical
        # deals — see paired_imp_test. Averaging first and comparing means
        # afterwards throws away the correlation and needs ~an order of
        # magnitude more boards to reach the same resolution.
        acc["imp_losses"].append(board_imp_loss)
        acc["scores"].append(score)
        acc["total_score"] += score
        acc["total_par"] += par_score
        regret = score - par_score
        if score >= par_score - 10:
            acc["par_hits"] += 1
        else:
            acc["total_imp_loss"] += abs(score_to_imp(int(regret)))

        ns_can_make_game = (
            dd_table.get((Strain.SPADES, Seat.NORTH), 0) >= 10 or
            dd_table.get((Strain.SPADES, Seat.SOUTH), 0) >= 10 or
            dd_table.get((Strain.HEARTS, Seat.NORTH), 0) >= 10 or
            dd_table.get((Strain.HEARTS, Seat.SOUTH), 0) >= 10 or
            dd_table.get((Strain.NT, Seat.NORTH), 0) >= 9 or
            dd_table.get((Strain.NT, Seat.SOUTH), 0) >= 9)
        pstate = PartialState(Seat.SOUTH, deal.hands[Seat.SOUTH], history,
                              deal.dealer, deal.vuln)
        c = pstate.get_contract()
        if sds_scorer is not None and c:
            lvl, strain, decl, dbl = c
            sds_res = sds_scorer.score_contract(deal, lvl, strain, decl, dbl,
                                                deal.vuln, history=history,
                                                models={s: net for s in Seat})
            sign = 1.0 if decl in (Seat.NORTH, Seat.SOUTH) else -1.0
            acc["total_sds"] += sign * sds_res.mean_score
            acc["sds_boards"] += 1
        if ns_can_make_game:
            acc["makable_games"] += 1
            if c:
                lvl, strain, decl, dbl = c
                if decl in (Seat.NORTH, Seat.SOUTH):
                    if (strain in (Strain.SPADES, Strain.HEARTS) and lvl >= 4) or \
                       (strain == Strain.NT and lvl >= 3) or lvl >= 5:
                        acc["games_reached"] += 1
        if run_diagnostics and regret < -10:
            diag = ParDiagnosticEngine.diagnose_board(offset + i + 1, deal,
                                                      history, score)
            acc["flaws"][diag.flaw_type.value] = \
                acc["flaws"].get(diag.flaw_type.value, 0) + 1
            acc["worst"].append((regret, offset + i + 1, contract_string(pstate),
                                 par_contract, par_score, diag.flaw_type.value))
            acc["diagnostics"].append(diag)
    return acc


def evaluate_system(arena: BiddingArena, name: str, net: DecisionNet, deals: List[Deal],
                    dd_data: List[Tuple[int, str, dict]], run_diagnostics: bool = False,
                    seed: int = None, sds_scorer=None,
                    opponent_panel: List[Tuple[str, DecisionNet]] = None,
                    jobs: int = 1):
    """Score a system on a deal set.

    With `opponent_panel=None` (the default, and the historical behaviour) the
    system plays both sides of the table.  Passing a panel makes E/W play the
    panel member selected by `panel_opponent_for`, which breaks the
    self-play mirror — see `build_opponent_panel`.

    `jobs > 1` scores the deal set in parallel across processes.  This is what
    makes a large-budget evaluation affordable — screening resolution is the
    binding constraint on whether a measured gain is real.

    Two caveats, both measured:

    * **Speedup is ~2.2x, not linear.** Workers use `spawn` (forking a process
      that has already initialised native DDS deadlocks inside libdds), and each
      spawned worker pays ~2.5 s to re-import the package and re-init DDS. That
      overhead is paid on *every* call, so parallelism is only worth it on large
      deal sets — hence the `MIN_BOARDS_PER_WORKER` guard below, which silently
      falls back to serial on small runs rather than making them slower.
    * ~~**Numbers are not comparable to a serial run.**~~ RESOLVED: both paths
      now seed the world sampler per board from the global board index
      (`seed_board`), so serial and parallel draw the same worlds for the same
      board and the figures agree. Before this, each path consumed one global
      RNG in its own order and two runs of the same configuration disagreed.
    """
    if jobs and jobs > 1 and len(deals) >= jobs * MIN_BOARDS_PER_WORKER:
        return _evaluate_system_parallel(arena, name, net, deals, dd_data,
                                         run_diagnostics, seed, sds_scorer,
                                         opponent_panel, jobs)
    if seed is not None:
        random.seed(seed)
    total_score = 0.0
    total_par = 0.0
    total_imp_loss = 0.0
    total_mean_imp_loss = 0.0
    total_imp_diff = 0.0
    total_sds = 0.0
    sds_boards = 0
    par_hits = 0
    makable_games = 0
    games_reached = 0
    flaws = Counter()
    worst = []
    diagnostics = []
    scores = []
    imp_losses = []
    imp_diffs = []

    _rng_state = random.getstate()
    try:
        for i, deal in enumerate(deals):
            par_score, par_contract, dd_table = dd_data[i]
            seed_board(seed, i)
            ew_net = panel_opponent_for(i, opponent_panel) if opponent_panel else net
            history, score = arena.play_board(deal, net, ew_net)
            board_imp_loss = imp_loss(score, par_score)
            total_mean_imp_loss += board_imp_loss
            imp_losses.append(board_imp_loss)
            # signed counterpart to the abs() metric above (§6.28)
            board_imp_diff = imp_diff(score, par_score)
            total_imp_diff += board_imp_diff
            imp_diffs.append(board_imp_diff)
            scores.append(score)
            total_score += score
            total_par += par_score
            regret = score - par_score
            if score >= par_score - 10:
                par_hits += 1
            else:
                total_imp_loss += abs(score_to_imp(int(regret)))

            ns_can_make_game = (
                dd_table.get((Strain.SPADES, Seat.NORTH), 0) >= 10 or
                dd_table.get((Strain.SPADES, Seat.SOUTH), 0) >= 10 or
                dd_table.get((Strain.HEARTS, Seat.NORTH), 0) >= 10 or
                dd_table.get((Strain.HEARTS, Seat.SOUTH), 0) >= 10 or
                dd_table.get((Strain.NT, Seat.NORTH), 0) >= 9 or
                dd_table.get((Strain.NT, Seat.SOUTH), 0) >= 9
            )
            pstate = PartialState(Seat.SOUTH, deal.hands[Seat.SOUTH], history, deal.dealer, deal.vuln)
            c = pstate.get_contract()
            if sds_scorer is not None and c:
                lvl, strain, decl, dbl = c
                sds_res = sds_scorer.score_contract(deal, lvl, strain, decl, dbl, deal.vuln,
                                                    history=history,
                                                    models={s: net for s in Seat})
                sign = 1.0 if decl in (Seat.NORTH, Seat.SOUTH) else -1.0
                total_sds += sign * sds_res.mean_score
                sds_boards += 1
            if ns_can_make_game:
                makable_games += 1
                if c:
                    lvl, strain, decl, dbl = c
                    if decl in (Seat.NORTH, Seat.SOUTH):
                        if (strain in (Strain.SPADES, Strain.HEARTS) and lvl >= 4) or (strain == Strain.NT and lvl >= 3) or lvl >= 5:
                            games_reached += 1

            if run_diagnostics and regret < -10:
                diag = ParDiagnosticEngine.diagnose_board(i + 1, deal, history, score)
                flaws[diag.flaw_type.value] += 1
                worst.append((regret, i + 1, contract_string(pstate), par_contract, par_score, diag.flaw_type.value))
                diagnostics.append(diag)
    finally:
        random.setstate(_rng_state)

    n = len(deals)
    return {
        "name": name,
        "avg_score": total_score / n,
        "avg_par": total_par / n,
        "avg_regret": (total_score - total_par) / n,
        "avg_imp_loss": total_imp_loss / n,
        "mean_imp_loss": total_mean_imp_loss / n,
        "mean_imp_diff": total_imp_diff / n,
        "par_accuracy": par_hits / n * 100.0,
        "game_conversion": (games_reached / makable_games * 100.0) if makable_games else 100.0,
        "makable_games": makable_games,
        "flaws": flaws,
        "worst": sorted(worst)[:3],
        "diagnostics": diagnostics,
        "avg_score_sds": (total_sds / sds_boards) if sds_boards else 0.0,
        "sds_boards": sds_boards,
        "scores": scores,
        "imp_losses": imp_losses,
        "imp_diffs": imp_diffs,
        "jobs_used": 1,
    }


def _evaluate_system_parallel(arena: BiddingArena, name: str, net: DecisionNet,
                              deals: List[Deal],
                              dd_data, run_diagnostics: bool, seed: int,
                              sds_scorer, opponent_panel, jobs: int) -> Dict[str, Any]:
    """Fan a single `evaluate_system` call out over `jobs` processes.

    `arena` is taken in purely so the caller's search configuration can be
    forwarded to the workers. Without it the workers hardcode their own engine
    and `--jobs` silently evaluates a different search than `--jobs 1` does.
    """
    import multiprocessing as mp
    from concurrent.futures import ProcessPoolExecutor

    n = len(deals)
    jobs = min(jobs, n)
    bounds = [(n * k // jobs, n * (k + 1) // jobs) for k in range(jobs)]

    sds_num_worlds = getattr(sds_scorer, "num_worlds", 0) or 0
    sds_seed = getattr(sds_scorer, "seed", 2024) or 2024
    sds_condition = bool(getattr(sds_scorer, "condition_factor", 0))

    # Carry the caller's search configuration into the workers. The serial path
    # uses the `arena` it is handed, so a worker that hardcodes its own engine
    # makes --jobs silently CHANGE the search being evaluated. Read scalars
    # (not the engine object) so the payload stays trivially picklable; any
    # missing attribute falls back to the historical default.
    eng = getattr(arena, "engine", None)
    samp = getattr(eng, "sampler", None)
    search_cfg = (
        int(getattr(samp, "sample_size", 2) or 2),
        int(getattr(samp, "max_iterations", 6) or 6),
        float(getattr(samp, "timeout_sec", 0.06) or 0.06),
        int(getattr(eng, "max_lookahead_depth", 1) or 1),
    )

    payload = []
    for lo, hi in bounds:
        if lo >= hi:
            continue
        payload.append((deals[lo:hi], dd_data[lo:hi], net, opponent_panel,
                        seed, run_diagnostics, sds_num_worlds, sds_seed,
                        sds_condition, lo, search_cfg))

    # Spawn, not fork.  precompute() runs before we fan out, so the parent is
    # already holding initialised native DDS state (solver contexts, transposition
    # tables); forking a process in that state deadlocks inside libdds.  Spawn
    # gives each worker a fresh interpreter and a clean DDS init.
    ctx = mp.get_context("spawn") if "spawn" in mp.get_all_start_methods() \
        else mp.get_context()
    # Spawned children would otherwise each get a random hash seed, making runs
    # irreproducible (see research/status.md §4.4 on cross-process noise).
    os.environ.setdefault("PYTHONHASHSEED", "0")
    with ProcessPoolExecutor(max_workers=jobs, mp_context=ctx) as ex:
        parts = list(ex.map(_eval_chunk, payload))

    tot = {k: 0.0 for k in ("total_score", "total_par", "total_imp_loss",
                            "total_mean_imp_loss", "total_imp_diff",
                            "total_sds")}
    tot["sds_boards"] = tot["par_hits"] = tot["makable_games"] = 0
    tot["games_reached"] = 0
    scores, worst, diagnostics = [], [], []
    imp_losses = []
    flaws = Counter()
    imp_diffs = []
    n_done = 0
    for p in parts:
        for k in ("total_score", "total_par", "total_imp_loss",
                  "total_mean_imp_loss", "total_imp_diff", "total_sds"):
            tot[k] += p.get(k, 0.0)
        for k in ("sds_boards", "par_hits", "makable_games", "games_reached"):
            tot[k] += p[k]
        scores.extend(p["scores"])
        imp_losses.extend(p.get("imp_losses", []))
        imp_diffs.extend(p.get("imp_diffs", []))
        worst.extend(p["worst"])
        diagnostics.extend(p["diagnostics"])
        flaws.update(p["flaws"])
        n_done += p["n"]

    n = max(n_done, 1)
    return {
        "name": name,
        "avg_score": tot["total_score"] / n,
        "avg_par": tot["total_par"] / n,
        "avg_regret": (tot["total_score"] - tot["total_par"]) / n,
        "avg_imp_loss": tot["total_imp_loss"] / n,
        "mean_imp_loss": tot["total_mean_imp_loss"] / n,
        "mean_imp_diff": tot["total_imp_diff"] / n,
        "par_accuracy": tot["par_hits"] / n * 100.0,
        "game_conversion": (tot["games_reached"] / tot["makable_games"] * 100.0)
                           if tot["makable_games"] else 100.0,
        "makable_games": tot["makable_games"],
        "flaws": flaws,
        "worst": sorted(worst)[:3],
        "diagnostics": diagnostics,
        "avg_score_sds": (tot["total_sds"] / tot["sds_boards"])
                         if tot["sds_boards"] else 0.0,
        "sds_boards": tot["sds_boards"],
        "scores": scores,
        "imp_losses": imp_losses,
        "imp_diffs": imp_diffs,
        "jobs_used": jobs,
    }


def evaluate_panel(arena: BiddingArena, name: str, net: DecisionNet, deals: List[Deal],
                   dd_data: List[Tuple[int, str, dict]],
                   opponents: List[Tuple[str, DecisionNet]] = None,
                   seed: int = None) -> Dict[str, Any]:
    """Evaluate a system against a fixed opponent panel over BOTH seat orientations.

    Every board is played twice per opponent: once with the candidate at N/S
    and once at E/W.  Two things fall out of that:

    * Dealer and seat bias cancel, so a system that only looks good because it
      happens to open first stops looking good.
    * The par term cancels in the averaged regret, leaving a pure head-to-head
      score: mean regret == (score_as_NS - score_as_EW) / 2.  That is a direct
      measure of beating that opponent, not of beating a theoretical par.

    Costs 2 * len(opponents) auctions per board, so this is for the
    leaderboard and validation gates, not for inner-loop patch screening
    (use `opponent_panel=` on `evaluate_system` for that — same cost as
    self-play).
    """
    if seed is not None:
        random.seed(seed)
    if opponents is None:
        opponents = build_opponent_panel()

    per_opponent: Dict[str, Dict[str, float]] = {}
    tot_regret = tot_imp = tot_h2h = 0.0
    tot_impd = 0.0
    tot_par = 0.0

    for opp_name, opp_net in opponents:
        o_regret = o_imp = o_h2h = o_impd = 0.0
        for i, deal in enumerate(deals):
            par_score, _, _ = dd_data[i]
            tot_par += par_score
            _, s_ns = arena.play_board(deal, net, opp_net)
            _, s_ew = arena.play_board(deal, opp_net, net)
            # candidate at N/S: its score is s_ns, par for N/S is par_score
            r_ns = s_ns - par_score
            # candidate at E/W: its score is -s_ew, par for E/W is -par_score
            r_ew = -s_ew - (-par_score)
            o_regret += (r_ns + r_ew) / 2.0
            o_imp += (imp_loss(s_ns, par_score) + imp_loss(-s_ew, -par_score)) / 2.0
            # signed: POSITIVE means we beat par. imp_loss is abs(), so it
            # scores beating par exactly like missing it (§6.28).
            o_impd += (imp_diff(s_ns, par_score) + imp_diff(-s_ew, -par_score)) / 2.0
            o_h2h += (s_ns - s_ew) / 2.0

        k = len(deals)
        per_opponent[opp_name] = {
            "avg_regret": o_regret / k,
            "mean_imp_loss": o_imp / k,
            "mean_imp_diff": o_impd / k,
            "h2h_score": o_h2h / k,
        }
        tot_regret += o_regret / k
        tot_imp += o_imp / k
        tot_h2h += o_h2h / k
        tot_impd += o_impd / k

    n = len(opponents)
    return {
        "name": name,
        "avg_regret": tot_regret / n,
        "mean_imp_loss": tot_imp / n,
        "mean_imp_diff": tot_impd / n,
        "h2h_score": tot_h2h / n,
        "avg_par": tot_par / (len(deals) * n),
        "per_opponent": per_opponent,
        "opponents": [o[0] for o in opponents],
        "boards": len(deals),
    }


def _print_panel_table(results: List[Dict[str, Any]], metric: str, elapsed: float) -> None:
    reverse = metric not in LOWER_IS_BETTER
    results.sort(key=lambda r: r[metric], reverse=reverse)

    print()
    print("=" * 96)
    print(" PANEL RANKING — fixed opponents, both seat orientations")
    print("=" * 96)
    print(f" {'#':<3} | {'System':<24} | {'H2H pts/bd':<11} | {'IMP loss/bd':<12} | "
          f"{'IMP diff/bd':<12} | {'Regret vs par':<14}")
    print("-" * 110)
    for idx, r in enumerate(results, 1):
        crown = "*" if idx == 1 else " "
        print(f" {crown}{idx:<2} | {r['name']:<24} | {r['h2h_score']:<+11.1f} | "
              f"{r['mean_imp_loss']:<12.2f} | {r.get('mean_imp_diff', 0.0):<+12.2f} | "
              f"{r['avg_regret']:<+14.1f}")
    print("-" * 110)
    print(" IMP diff/bd is SIGNED: positive = beating double-dummy par. IMP loss/bd is")
    print(" abs(deviation from par), so it scores beating par like missing it (§6.28).")
    print(f" Ranked by {metric} | opponents: {', '.join(results[0]['opponents'])} | "
          f"boards: {results[0]['boards']} | total {elapsed:.1f}s")

    best = results[0]
    print(f"\n BEST ON PANEL: {best['name']}")
    for opp, d in best["per_opponent"].items():
        print(f"   vs {opp:<10} h2h {d['h2h_score']:+7.1f} pts/bd   imp_loss {d['mean_imp_loss']:5.2f}")


def main():
    parser = argparse.ArgumentParser(description="Rank all repo bidding systems vs native DDS par")
    parser.add_argument("--boards", type=int, default=30, help="Number of random boards (default 30)")
    parser.add_argument("--no-stratified", action="store_true", help="Skip the 6 stratified deals")
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--dsl", action="append", default=[], help="Extra DSL files to load")
    parser.add_argument("--sds", action="store_true", help="Also score contracts with SDS two-hand view")
    parser.add_argument("--sds-condition", action="store_true", help="RBMBMC-conditioned SDS worlds (auction-aware sampling)")
    parser.add_argument("--panel", nargs="?", const="default", default=None,
                        choices=["default", "legacy"],
                        help="Score vs a fixed heterogeneous opponent panel over both seats "
                             "(breaks the self-play mirror; 2x opponents cost). "
                             "Bare --panel = 'default' (10/8/15-rule skeletons, the panel all "
                             "28 recorded versions were scored against). --panel legacy uses the "
                             "183/166/159-rule hand-authored systems in system/ (see §6.34); "
                             "against them the champion->improved gap is ~1/3 as large.")
    parser.add_argument("--metric", default="h2h_score",
                        choices=["h2h_score", "mean_imp_loss", "mean_imp_diff", "avg_regret"],
                        help="Panel ranking metric (default h2h_score). Prefer mean_imp_diff: "
                             "mean_imp_loss is abs(deviation from par), so beating par scores "
                             "like missing it (§6.28).")
    parser.add_argument("--jobs", type=int, default=1,
                        help="Score deals across N processes (default 1)")
    args = parser.parse_args()

    # Safety cap on parallelism. Each worker runs a native DDS solve, so --jobs N
    # pins N cores at 100% for the whole run. Sustained all-core load on a
    # thermally limited laptop hard-resets the machine: this repo is developed on
    # a MacBookPro15,1 (Intel, 12 threads, 16 GB, **no swap**), and back-to-back
    # 8-worker runs drove load to ~40 on 12 CPUs and brought it down twice
    # (2026-09-11 19:11 and 2026-09-12 18:00 — both logged as bare `reboot time`
    # with no shutdown record and no .panic, i.e. hard resets).
    #
    # Leave headroom by default. This applies to the CLI only — `evaluate_system`
    # keeps the exact jobs it is given, because tests assert jobs_used == jobs.
    _cap = int(os.environ.get("BID_EVAL_MAX_JOBS", "0") or 0)
    if _cap <= 0:
        _cap = max(1, (os.cpu_count() or 4) // 3)
    if args.jobs > _cap:
        print(f"capping --jobs {args.jobs} -> {_cap}: sustained all-core DDS "
              f"runs can hard-reset a thermally limited machine. "
              f"Set BID_EVAL_MAX_JOBS={args.jobs} to override.")
        args.jobs = _cap

    t0 = time.time()
    deals = build_deals(args.boards, seed=args.seed, include_stratified=not args.no_stratified)
    strat = "" if args.no_stratified else " + 6 stratified"
    print(f"Deals: {len(deals)} ({args.boards} random{strat}, seed {args.seed})")

    opt = SystemOptimizer()

    def _sig(net):
        return tuple(sorted(
            (r.rule_id, str(r.call),
             tuple(sorted((c.key, c.op, str(c.value)) for c in r.conditions)))
            for r in net.rules))

    archetypes = {
        "SUP (archetype)": opt.create_singularity_ultra_precision(),
        "AOP (archetype)": opt.create_apex_omega_precision(),
        "ARP (archetype)": opt.create_alpha_relay_precision(),
        "QRP (archetype)": opt.create_quantum_relay_precision(),
        "Modern 2/1 GF": opt.create_modern_2over1(),
        "Precision StrongClub": opt.create_precision_system(),
        "SAYC Baseline": opt.create_sayc_baseline(),
    }
    archetype_sigs = {name: _sig(n) for name, n in archetypes.items()}

    systems: List[Tuple[str, DecisionNet]] = [
        ("Pipeline Baseline", BidInventionEngine().models[Seat.SOUTH]),
        ("improved_system.dsl", load_decision_net_dsl(os.path.join(SYSTEM_DIR, "improved_system.dsl"))),
        # Hand-written 2/1 + conventions archetype. Previously labelled
        # "Autonomous Evolved", which implied it was output of the improvement
        # loop; it is not — see SystemOptimizer.create_autonomous_evolved_system.
        ("2/1 + conventions", opt.create_autonomous_evolved_system()),
    ] + [(name, archetypes[name]) for name in archetypes]
    # champion snapshot: skip if byte-equivalent to a listed archetype
    champ_path = os.path.join(SYSTEM_DIR, "champion_system.dsl")
    if os.path.exists(champ_path):
        champ_net = load_decision_net_dsl(champ_path)
        champ_sig = _sig(champ_net)
        dup_of = next((n for n, s in archetype_sigs.items() if s == champ_sig), None)
        if dup_of:
            print(f"  (champion_system.dsl is identical to {dup_of}; skipping duplicate evaluation)")
        else:
            systems.insert(1, ("champion_system.dsl", champ_net))
    # Evaluation order only — results are sorted by metric before printing.
    # Previously "keep improved_system.dsl first", which read as a claim of
    # priority; §6.30 measures it losing to SAYC by 37.7 pts/board head-to-head,
    # so if anything belongs first it is the champion snapshot. Guarded: the
    # champion entry is skipped when the file is absent or a duplicate.
    _ci = next((i for i, (n, _) in enumerate(systems)
                if "champion_system" in n), None)
    if _ci:
        systems.insert(0, systems.pop(_ci))
    for extra in args.dsl:
        systems.append((os.path.basename(extra), load_decision_net_dsl(extra)))

    print(f"Precomputing DDS par + double-dummy tables for {len(deals)} deals...")
    dd_data = []
    for deal in deals:
        par_score, par_contract = DDSolver.calculate_par(deal, deal.vuln)
        dd_table = DDSolver.solve_dd_table(deal)
        dd_data.append((par_score, par_contract, dd_table))

    engine = PIDMEngine(sampler=RBMBMCSampler(sample_size=2, max_iterations=6, timeout_sec=0.06), max_lookahead_depth=1)
    arena = BiddingArena(engine=engine)

    sds_scorer = None
    if args.sds:
        from bid.sds import SDSScorer
        sds_scorer = SDSScorer(num_worlds=20, seed=2024,
                               condition_factor=4 if args.sds_condition else 0)
        mode = "auction-conditioned" if args.sds_condition else "uniform"
        print(f"SDS two-hand scoring enabled ({mode}, 20 worlds per played contract)")

    # Build the panel ONCE: --panel legacy parses three ~900-line DSLs, which
    # is far too slow to repeat per system.
    panel = build_panel(args.panel) if args.panel else None
    if panel is not None:
        print(f"Opponent panel ({args.panel}): "
              + ", ".join(f"{n} ({len(net.wrapped_system.rules) if getattr(net, 'wrapped_system', None) else len(net.rules)} rules)"
                          for n, net in panel))

    results = []
    for name, net in systems:
        t = time.time()
        if args.panel:
            res = evaluate_panel(arena, name, net, deals, dd_data,
                                 opponents=panel, seed=args.seed)
        else:
            res = evaluate_system(arena, name, net, deals, dd_data, run_diagnostics=True,
                                  sds_scorer=sds_scorer, jobs=args.jobs)
        res["elapsed"] = time.time() - t
        results.append(res)
        if args.panel:
            print(f"  evaluated {name:<28} h2h {res['h2h_score']:+7.1f}  "
                  f"imp_loss {res['mean_imp_loss']:5.2f}  ({res['elapsed']:.1f}s)")
        else:
            print(f"  evaluated {name:<28} avg_regret {res['avg_regret']:+7.1f}  ({res['elapsed']:.1f}s)")

    if args.panel:
        _print_panel_table(results, args.metric, time.time() - t0)
        return

    results.sort(key=lambda r: (r["avg_regret"], r["avg_imp_loss"]), reverse=True)

    print()
    print("=" * 118)
    print(" SYSTEM RANKING vs NATIVE DDS PAR (best first)")
    print("=" * 118)
    hdr = (f" {'#':<3} | {'System':<24} | {'Avg NS Score':<12} | {'Avg DDS Par':<11} | "
           f"{'Regret':<9} | {'IMP Loss/Bd':<11} | {'Par Acc':<8} | {'Game Conv':<9}")
    if args.sds:
        hdr += " | SDS Score"
    print(hdr)
    print("-" * 118)
    for idx, r in enumerate(results, 1):
        crown = "👑" if idx == 1 else "  "
        line = (f" {crown}{idx:<2} | {r['name']:<24} | {r['avg_score']:<+12.1f} | {r['avg_par']:<+11.1f} | "
                f"{r['avg_regret']:<+9.1f} | {r['avg_imp_loss']:<11.2f} | {r['par_accuracy']:<7.1f}% | {r['game_conversion']:<8.1f}%")
        if args.sds:
            line += " | {:+.1f}".format(r['avg_score_sds'])
        print(line)
    print("-" * 118)
    print(f" Makable NS games in deal set: {results[0]['makable_games']} | Total eval time: {time.time() - t0:.1f}s")

    best = results[0]
    print(f"\n 🏆 BEST SYSTEM: {best['name']}")
    print(f"    Flaw breakdown: " + (", ".join(f"{k} x{v}" for k, v in best['flaws'].most_common()) or "none"))
    if best["worst"]:
        print("    Worst boards:")
        for regret, board, actual, par_c, par_s, flaw in best["worst"]:
            print(f"      Board {board:<3} {actual:<14} vs Par {par_c:<16} ({par_s:+d})  regret {regret:+.0f} pts  [{flaw}]")


if __name__ == "__main__":
    main()
