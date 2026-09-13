#!/usr/bin/env python3
"""
Continuous improvement flywheel for system/improved_system.dsl.

Every round:
  1. Play the deal set vs native DDS par (paired, seeded), dump worst flaws
  2. Auto-generate a patch pool from ALL improvement approaches:
       - curated anti-flaw rule patches (overcalls, takeouts, raises, ...)
       - ParDiagnosticEngine corrective families
       - ungated-rule scan  -> gated variants (is_opening=False / partner!=NONE)
       - broad-match ("junk") rule scan -> single-rule removal candidates
       - threshold mutations (tighten / loosen HCP & length bounds)
  3. Greedy paired hill-climb on the train set with guardrails
  4. Confirm on disjoint validation sets; versioned save on success

Persistent state (system/flywheel_state.json) caches failed patch signatures,
tracks the version number, and archives each accepted version under
system/history/, so the flywheel can be re-run continually without repeating work.

Usage: PYTHONPATH=.. python3 flywheel.py [--deals 48] [--rounds 3] [--pool-cap 14]
"""

import argparse
import copy
import hashlib
import json
import os
import random
import re
import shutil
import time
from typing import Callable, Dict, List, Optional, Tuple

from bid.models import Strain, Seat, Call, CallType
from bid.decision_net import DecisionNetRule, RuleCondition, DecisionNet
from bid.arena import BiddingArena
from bid.pidm import PIDMEngine
from bid.sampling import RBMBMCSampler, PartialState, Deal
from bid.diagnostics import ParDiagnosticEngine

from bid.eval_vs_dds import (build_deals, evaluate_system, load_decision_net_dsl,
                             min_detectable_effect, paired_imp_test, resolution_of,
                             SYSTEM_DIR, precompute, build_opponent_panel,
                             LOWER_IS_BETTER, MIN_DELTA_BY_METRIC)

TARGET = os.path.join(SYSTEM_DIR, "improved_system.dsl")
STATE_PATH = os.path.join(SYSTEM_DIR, "flywheel_state.json")
HISTORY_DIR = os.path.join(SYSTEM_DIR, "history")
TRAIN_SEED = 42
VAL_SEEDS = (7, 13)
EVAL_SEED = 777
FAIL_EXPIRY_VERSIONS = 8  # failed patches become retryable after this many saved versions
MIN_PATCH_DELTA = 0.5     # min avg-score gain (pts/board) to accept a patch


# ------------- persistent patch-state helpers (shared with autoloop) -------------

def normalize_state(st: dict) -> dict:
    """Heal legacy/corrupted flywheel_state.json contents.

    One autoloop revision stored [sig, name] tuples in `failed`; JSON
    round-trips them as lists that never match generated string signatures,
    so those patches were re-screened forever.  Flatten to bare signatures,
    dedupe, and backfill per-signature failure versions so expiry has data
    to work with (legacy entries get a full grace period)."""
    cur = int(st.get("version", 0))
    seen, failed = set(), []
    for e in st.get("failed", []):
        sig = e[0] if isinstance(e, (list, tuple)) else e
        if isinstance(sig, str) and sig and sig not in seen:
            seen.add(sig)
            failed.append(sig)
    st["failed"] = failed
    fam = st.get("failed_at", {})
    st["failed_at"] = {s: int(fam.get(s, cur)) for s in failed}
    return st


def mark_failed(state: dict, sig: str) -> None:
    """Record a failed patch signature together with the version it failed at."""
    if sig not in state["failed"]:
        state["failed"].append(sig)
    state.setdefault("failed_at", {})[sig] = int(state.get("version", 0))


def passes_effect_floor(delta: float, metric: str = "avg_score") -> bool:
    """Reject noise-level 'improvements'.

    The PIDM sampler has wall-clock timeouts, so re-scoring an identical net
    is not perfectly repeatable; a +0.04 mean with near-zero variance can
    otherwise pass the z-test and burn a saved version on a no-op.

    `delta` is always a *gain* (higher is better) — see `metric_gain`.  The
    floor scales with the metric: IMPs/board run ~1-5 units, points/board run
    in the hundreds, so a single 0.5 threshold is meaningless across them.
    """
    return delta >= MIN_DELTA_BY_METRIC.get(metric, MIN_PATCH_DELTA)


def metric_gain(current: float, new: float, metric: str) -> float:
    """Signed improvement of `new` over `current`, normalised so positive == better.

    Point-regret metrics are higher-is-better; the IMP-loss metrics are
    lower-is-better, so their sign is flipped here rather than at every call
    site (it is easy to get that backwards and silently select *worse* patches).
    """
    d = new - current
    return -d if metric in LOWER_IS_BETTER else d


def val_tolerance(metric: str) -> float:
    """How much validation regression to tolerate before rejecting a round.

    Scaled to the metric for the same reason as the effect floor: -5 is a
    rounding error in points/board but an unrecoverable collapse in IMPs/board.
    """
    return 0.15 if metric in LOWER_IS_BETTER else 5.0


def winner_gate(ok: bool, delta: float, metric: str = "avg_score") -> bool:
    """Stage-2 winner decision: surviving the escalation ladder is not
    enough — the final delta must also clear the effect floor.  Kept as a
    pure function so the no-op-patch regression stays unit-tested: ok=True
    with a noise delta must NOT produce a winner."""
    return bool(ok) and passes_effect_floor(delta, metric)


def expire_failed(state: dict, expiry_versions: int = FAIL_EXPIRY_VERSIONS) -> int:
    """Drop failure signatures that have not recurred for `expiry_versions`
    saved versions.  The system underneath a failed patch changes with every
    saved version, so old failures stop being informative; keeping them
    forever empties the candidate pool and halts the loop ("converged" when
    it is really out of ideas).  Returns the number of expired entries."""
    cur = int(state.get("version", 0))
    fam = state.get("failed_at", {})
    keep = [s for s in state.get("failed", [])
            if cur - int(fam.get(s, cur)) < expiry_versions]
    dropped = len(state.get("failed", [])) - len(keep)
    state["failed"] = keep
    live = set(keep)
    state["failed_at"] = {s: v for s, v in fam.items() if s in live}
    return dropped

CONTEXT_KEYS = {"partner_last_call", "opp_last_call", "my_last_call", "is_opening",
                "is_balancing", "is_competitive", "last_bid_strain"}
NUMERIC_KEYS = {"hcp", "spade_len", "heart_len", "diamond_len", "club_len",
                "controls", "total_points"}


def B(level, strain):
    return Call(CallType.BID, level, strain)


# ---------------- patch primitives ----------------

def add_rules(net, rules):
    existing = {r.rule_id for r in net.rules}
    for r in rules:
        if r.rule_id not in existing:
            net.add_rule(r)
            # track as we go: the set is only correct for the first rule
            # otherwise, so a batch carrying duplicate ids (e.g. two ID3
            # intersections hashed to the same name) would all be inserted.
            existing.add(r.rule_id)


def replace_rule(net, new_rule):
    net.rules = [r for r in net.rules if r.rule_id != new_rule.rule_id]
    net.add_rule(new_rule)


def remove_ids(ids):
    def patch(net):
        net.rules = [r for r in net.rules if r.rule_id not in ids]
    return patch


# ---------------- curated patches ----------------

def p_overcalls(net):
    add_rules(net, [
        DecisionNetRule("FW_OVERCALL_1H", B(1, Strain.HEARTS), [
            RuleCondition("opp_last_call", "in", ["1C", "1D", "1S"]),
            RuleCondition("heart_len", ">=", 5), RuleCondition("hcp", ">=", 8)], description="", priority=22),
        DecisionNetRule("FW_OVERCALL_1S", B(1, Strain.SPADES), [
            RuleCondition("opp_last_call", "in", ["1C", "1D", "1H"]),
            RuleCondition("spade_len", ">=", 5), RuleCondition("hcp", ">=", 8)], description="", priority=22),
    ])


def p_balancing(net):
    add_rules(net, [
        DecisionNetRule("FW_BAL_1H", B(1, Strain.HEARTS), [
            RuleCondition("is_balancing", "==", True),
            RuleCondition("heart_len", ">=", 5), RuleCondition("hcp", ">=", 8)], description="", priority=23),
        DecisionNetRule("FW_BAL_1S", B(1, Strain.SPADES), [
            RuleCondition("is_balancing", "==", True),
            RuleCondition("spade_len", ">=", 5), RuleCondition("hcp", ">=", 8)], description="", priority=23),
    ])


def p_tko_shape(net):
    add_rules(net, [
        DecisionNetRule("FW_TKO_VS_S", Call(CallType.DOUBLE), [
            RuleCondition("is_competitive", "==", True),
            RuleCondition("last_bid_strain", "==", "S"),
            RuleCondition("spade_len", "<=", 2), RuleCondition("hcp", ">=", 11),
            RuleCondition("heart_len", ">=", 4)], description="", priority=25),
        DecisionNetRule("FW_TKO_VS_H", Call(CallType.DOUBLE), [
            RuleCondition("is_competitive", "==", True),
            RuleCondition("last_bid_strain", "==", "H"),
            RuleCondition("heart_len", "<=", 2), RuleCondition("hcp", ">=", 11),
            RuleCondition("spade_len", ">=", 4)], description="", priority=25),
    ])


def p_force_raise(net):
    add_rules(net, [
        DecisionNetRule("FW_2NT_FORCE", B(2, Strain.NT), [
            RuleCondition("partner_last_call", "in", ["1H", "1S"]),
            RuleCondition("hcp", ">=", 11)], description="", priority=24),
        DecisionNetRule("FW_2NT_ACCEPT_H", B(4, Strain.HEARTS), [
            RuleCondition("partner_last_call", "==", "2NT"),
            RuleCondition("heart_len", ">=", 5), RuleCondition("hcp", ">=", 13)], description="", priority=26),
        DecisionNetRule("FW_2NT_ACCEPT_S", B(4, Strain.SPADES), [
            RuleCondition("partner_last_call", "==", "2NT"),
            RuleCondition("spade_len", ">=", 5), RuleCondition("hcp", ">=", 13)], description="", priority=26),
        DecisionNetRule("FW_2NT_DECLINE", B(3, Strain.NT), [
            RuleCondition("partner_last_call", "==", "2NT"),
            RuleCondition("hcp", "<=", 12)], description="", priority=20),
    ])


def p_aggression(net):
    """Opponent-aggressiveness aware competition rules (#feature-addition).

    Uses the new auction features (opp_preempted, opp_strength_class,
    auction_altitude, vuln_pressure, opp_bid_count, opp_fit_shown,
    our_fit_shown) so competitiveness adapts to HOW the opponents behave
    instead of only whether they have bid at all."""
    add_rules(net, [
        # push into a preemption war only at favorable vulnerability
        DecisionNetRule("FW_PREEMPT_PUSH_S", B(3, Strain.SPADES), [
            RuleCondition("opp_preempted", "==", True),
            RuleCondition("is_favorable_vuln", "==", True),
            RuleCondition("hcp", ">=", 9),
            RuleCondition("spade_len", ">=", 6)], priority=23),
        DecisionNetRule("FW_PREEMPT_PUSH_H", B(3, Strain.HEARTS), [
            RuleCondition("opp_preempted", "==", True),
            RuleCondition("is_favorable_vuln", "==", True),
            RuleCondition("hcp", ">=", 9),
            RuleCondition("heart_len", ">=", 6)], priority=23),
        # discipline: don't stretch into game zone at unfavorable vul
        # against opponents who have shown strength
        DecisionNetRule("FW_ALTITUDE_DISCIPLINE", Call(CallType.PASS), [
            RuleCondition("auction_altitude", ">=", 3),
            RuleCondition("is_unfavorable_vuln", "==", True),
            RuleCondition("hcp", "<=", 11)], priority=25),
        # opponents preempts => their hands are weak: compete light with fit
        DecisionNetRule("FW_VS_WEAK_COMPETE", B(2, Strain.HEARTS), [
            RuleCondition("opp_strength_class", "==", "weak"),
            RuleCondition("our_fit_shown", "==", True),
            RuleCondition("hcp", ">=", 7),
            RuleCondition("heart_len", ">=", 3)], priority=21),
    ])


def p_nt_safety(net):
    """Stopper-aware NT bidding + slam controls discipline.

    Targets the OVERBID_DOWN diagnostic family: 3NT/6NT contracts reached
    without a stopper in the opponents' bid suit, and slam bids made with
    insufficient controls."""
    add_rules(net, [
        # negative guard: don't drive 3NT with no stopper against an
        # opponent suit auction at equal/unfavorable vulnerability
        DecisionNetRule("FW_3NT_NO_STOPPER", B(3, Strain.NT), [
            RuleCondition("opp_bid_count", ">=", 1),
            RuleCondition("opp_suit_stoppers", "<=", 0.0),
            RuleCondition("is_balanced", "==", True),
            RuleCondition("hcp", "<=", 18)],
            is_negative=True, priority=27),
        # penalty double of a weak preempt when strong with their suit stopped
        DecisionNetRule("FW_X_WEAK_PREEMPT", Call(CallType.DOUBLE), [
            RuleCondition("opp_preempted", "==", True),
            RuleCondition("hcp", ">=", 15),
            RuleCondition("opp_suit_stoppers", ">=", 2.0),
            RuleCondition("is_unfavorable_vuln", "==", False)], priority=26),
        # slam discipline: 6NT needs controls; keep 5-level exploration
        # instead when controls are short
        DecisionNetRule("FW_6NT_CONTROLS", B(6, Strain.NT), [
            RuleCondition("auction_altitude", ">=", 3),
            RuleCondition("controls", ">=", 6),
            RuleCondition("hcp", ">=", 22)], priority=28),
    ])


def p_support(net):
    """Support-raise competition rules using support_in_partner_suit.

    Classic competitive decisions that per-hand features cannot express:
    mixed raises (3+ support, 6-10 HCP), preemptive raises (4+ support,
    light, favorable vulnerability), and a guard against 2-trump raises."""
    add_rules(net, [
        DecisionNetRule("FW_MIXED_RAISE_H", B(2, Strain.HEARTS), [
            RuleCondition("partner_last_bid_strain", "==", "H"),
            RuleCondition("support_in_partner_suit", ">=", 3),
            RuleCondition("hcp", ">=", 6),
            RuleCondition("hcp", "<=", 10)], priority=21),
        DecisionNetRule("FW_MIXED_RAISE_S", B(2, Strain.SPADES), [
            RuleCondition("partner_last_bid_strain", "==", "S"),
            RuleCondition("support_in_partner_suit", ">=", 3),
            RuleCondition("hcp", ">=", 6),
            RuleCondition("hcp", "<=", 10)], priority=21),
        DecisionNetRule("FW_PRE_RAISE_H", B(3, Strain.HEARTS), [
            RuleCondition("partner_last_bid_strain", "==", "H"),
            RuleCondition("support_in_partner_suit", ">=", 4),
            RuleCondition("hcp", "<=", 8),
            RuleCondition("is_favorable_vuln", "==", True)], priority=22),
        DecisionNetRule("FW_NO_2_TRUMP_RAISE", B(2, Strain.HEARTS), [
            RuleCondition("partner_last_bid_strain", "==", "H"),
            RuleCondition("support_in_partner_suit", "<=", 2),
            RuleCondition("hcp", "<=", 10)],
            is_negative=True, priority=24),
    ])


CURATED = {
    "OVERCALLS": p_overcalls,
    "BALANCING": p_balancing,
    "TKO_SHAPE": p_tko_shape,
    "FORCE_RAISE_2NT": p_force_raise,
    "AGGRESSION": p_aggression,
    "NT_SAFETY": p_nt_safety,
    "SUPPORT": p_support,
}


# ---------------- auto-generated patches ----------------

def scan_ungated(net: DecisionNet) -> List[DecisionNetRule]:
    out = []
    for r in net.rules:
        if r.call.type != CallType.BID or r.call.level < 2:
            continue
        keys = {c.key for c in r.conditions}
        if not (keys & CONTEXT_KEYS):
            out.append(r)
    return out


def scan_broad_rules(net: DecisionNet) -> List[DecisionNetRule]:
    out = []
    for r in net.rules:
        keys = {c.key for c in r.conditions}
        if not (keys & CONTEXT_KEYS):
            out.append(r)
    return out


def gate_variant(rule: DecisionNetRule, mode: str) -> DecisionNetRule:
    conds = list(rule.conditions)
    if mode == "not_opening":
        conds.append(RuleCondition("is_opening", "==", False))
    else:
        conds.append(RuleCondition("partner_last_call", "!=", "NONE"))
    return DecisionNetRule(rule.rule_id, rule.call, conds,
                           description=rule.description, priority=rule.priority)


def mutate_bounds(rule: DecisionNetRule, direction: str) -> Optional[DecisionNetRule]:
    conds = []
    changed = False
    for c in rule.conditions:
        c2 = RuleCondition(c.key, c.op, c.value)
        if c.key in NUMERIC_KEYS and isinstance(c.value, (int, float)):
            if direction == "tighten":
                if c.op == ">=":
                    c2.value += 1
                    changed = True
                elif c.op == "<=":
                    c2.value -= 1
                    changed = True
            else:
                if c.op == ">=":
                    c2.value -= 1
                    changed = True
                elif c.op == "<=":
                    c2.value += 1
                    changed = True
        conds.append(c2)
    if not changed:
        return None
    return DecisionNetRule(rule.rule_id, rule.call, conds,
                           description=rule.description, priority=rule.priority)


# ---------------- flywheel ----------------

class Flywheel:
    def __init__(self, arena, n_deals, pool_cap, rng_seed=123, sds_scorer=None, sds_primary=False,
                 metric="avg_score", panel=False, target=TARGET, id3=False,
                 jobs=1, val_seeds=VAL_SEEDS, state_path=STATE_PATH):
        self.arena = arena
        # Validation sets are the only defence against a patch that merely
        # overfits the training deals. Two sets can only resolve ~0.58 IMP/bd
        # (§6.16), so this is configurable: --val-seeds 7,13,21,29,35 buys
        # real resolution at linear cost.
        self.val_seeds = tuple(val_seeds)
        # Redirection exists so an experiment cannot bump the real version
        # counter or archive into system/history/ by accident.
        self.state_path = state_path
        self.sds_scorer = sds_scorer
        # Boards are independent, so screening parallelises near-linearly.
        # This is what makes a statistically meaningful deal budget affordable.
        self.jobs = max(1, int(jobs or 1))
        # BIDI speedup learning: let ID3 invent splits instead of only nudging
        # thresholds on rules a human already wrote.
        self.id3 = id3
        # Which DSL the hill-climb starts from and writes back to.  It matters:
        # local patches cannot close a structural gap, so seeding from the
        # strongest known system compounds much better than seeding from a weak
        # one and hoping 28 rounds of threshold nudges catch up.
        self.target = target
        self.sds_primary = sds_primary and sds_scorer is not None
        # `metric` selects what the hill-climb maximises.  "avg_score" is the
        # historical raw-points objective; "mean_imp_loss" is IMP-capped and
        # therefore far less dominated by single slam-level disasters.
        self.metric = "avg_score_sds" if self.sds_primary else metric
        # Scoring against a frozen heterogeneous panel instead of a copy of
        # itself stops the loop optimising a self-play fixed point.
        self.panel = build_opponent_panel() if panel else None
        self.rng = random.Random(rng_seed)
        self.train_deals = build_deals(n_deals, seed=TRAIN_SEED)
        self.dd_train = precompute(self.train_deals)
        self.val_sets = {}
        for s in self.val_seeds:
            d = build_deals(n_deals, seed=s)
            self.val_sets[s] = (d, precompute(d))
        self.state = self._load_state()
        self.n_deals = n_deals
        self.pool_cap = pool_cap

    def _load_state(self) -> dict:
        if os.path.exists(self.state_path):
            with open(self.state_path) as f:
                return normalize_state(json.load(f))
        return normalize_state({"version": 5, "failed": [], "applied": []})

    def _save_state(self):
        with open(self.state_path, "w") as f:
            json.dump(self.state, f, indent=2)

    def evl(self, net, deals, dd):
        return evaluate_system(self.arena, "cand", net, deals, dd,
                               run_diagnostics=True, seed=EVAL_SEED,
                               sds_scorer=self.sds_scorer,
                               opponent_panel=self.panel, jobs=self.jobs)

    def sig_failed(self, sig) -> bool:
        return sig in self.state["failed"]

    def fail(self, sig):
        mark_failed(self.state, sig)

    def build_pool(self, net: DecisionNet, diagnostics: List) -> List[Tuple[str, str, Callable]]:
        entries: List[Tuple[str, str, Callable]] = []

        for name, fn in CURATED.items():
            entries.append((f"curated:{name}", name, fn))

        if self.id3:
            entries.extend(self.build_id3_patches(net))

        fams: Dict[str, List] = {}
        for r in ParDiagnosticEngine.generate_corrective_rules_for_diagnostics(diagnostics):
            fams.setdefault(r.rule_id.split("_")[0], []).append(r)
        for fam, rules in sorted(fams.items()):
            entries.append((f"diag:{fam}", f"DIAG_{fam}",
                            (lambda rl: (lambda n: add_rules(n, rl)))(rules)))

        for r in scan_ungated(net)[:6]:
            for mode in ("not_opening", "partner"):
                g = gate_variant(r, mode)
                entries.append((
                    f"gate:{r.rule_id}:{mode}", f"GATE_{r.rule_id}_{mode}",
                    (lambda rr: (lambda n: replace_rule(n, rr)))(g)))

        for r in scan_broad_rules(net)[:6]:
            entries.append((
                f"drop:{r.rule_id}", f"DROP_{r.rule_id}",
                (lambda rid: (lambda n: remove_ids({rid})))(r.rule_id)))

        mutatable = [r for r in net.rules
                     if any(c.key in NUMERIC_KEYS for c in r.conditions)]
        self.rng.shuffle(mutatable)
        for r in mutatable[:6]:
            m = mutate_bounds(r, "tighten")
            if m is not None:
                entries.append((
                    f"tighten:{r.rule_id}", f"TIGHTEN_{r.rule_id}",
                    (lambda rr: (lambda n: replace_rule(n, rr)))(m)))
        for r in mutatable[:4]:
            m = mutate_bounds(r, "loosen")
            if m is not None:
                entries.append((
                    f"loosen:{r.rule_id}", f"LOOSEN_{r.rule_id}",
                    (lambda rr: (lambda n: replace_rule(n, rr)))(m)))

        seen, capped = set(), []
        for sig, name, fn in entries:
            if sig in seen:
                continue
            seen.add(sig)
            if self.sig_failed(sig):
                continue
            capped.append((sig, name, fn))
            if len(capped) >= self.pool_cap:
                break
        return capped

    @staticmethod
    def harvest_ambiguous_states(net: DecisionNet, deals: List[Deal], limit: int):
        """Walk real auctions and collect every decision where |phi(s)| > 1.

        The previous version only ever built opening states (`history=[]`), so
        every tree was fitted on opening hands: it could never learn a
        refinement for the far more common case of an ambiguity that only
        appears *after* partner has bid, and the auction-context features were
        constant across the whole training set.  Replaying actual auctions
        yields roughly an order of magnitude more states and — more importantly
        — states that carry real history.
        """
        states = []
        for deal in deals:
            if len(states) >= limit:
                break
            history: List[Call] = []
            curr = deal.dealer
            while True:
                ps = PartialState(curr, deal.hands[curr], history,
                                  deal.dealer, deal.vuln)
                if ps.is_auction_over() or len(history) >= 20:
                    break
                try:
                    acts = net.actions(ps.my_hand, ps.history, ps.my_seat,
                                       ps.dealer)
                except Exception:
                    break
                if len(acts) > 1:
                    # snapshot: history is mutated as the auction advances
                    states.append(PartialState(curr, deal.hands[curr],
                                               list(history), deal.dealer,
                                               deal.vuln))
                    if len(states) >= limit:
                        break
                history.append(acts[0])
                curr = Seat((curr.value + 1) % 4)
        return states

    def build_id3_patches(self, net: DecisionNet, n_states: int = 60,
                          min_examples: int = 3):
        """The BIDI speedup-learning step: discover ambiguous states on the
        seeded training deals, label them with PIDM, fit an ID3 tree per
        intersection, and compile each tree to rules.

        This is the missing capability.  Every other family in the pool is a
        hand-authored rule or a perturbation of one (tighten/loosen, gating,
        drops), so the hill-climb can only move thresholds inside a structure a
        human already wrote — it cannot close a structural gap.  ID3 invents
        the discriminating split itself.

        Cost is one PIDM call per ambiguous state, so it is capped and gated
        behind --id3.  States come from `self.train_deals` (already seeded)
        rather than `Deal.random_deal` so rounds are reproducible.
        """
        from bid.learner import DecisionNetLearner, ID3DecisionTree

        teacher = PIDMEngine(sampler=RBMBMCSampler(sample_size=4, max_iterations=12,
                                                   timeout_sec=0.25),
                             max_lookahead_depth=1)
        learner = DecisionNetLearner(teacher)
        models = {s: net for s in Seat}

        states = self.harvest_ambiguous_states(net, self.train_deals, n_states)
        if not states:
            return []

        labeled = learner.tag_states(states, models)
        groups: Dict[Tuple[str, ...], Tuple[list, list]] = {}
        for features, call, key in labeled:
            groups.setdefault(key, ([], []))
            groups[key][0].append(features)
            groups[key][1].append(call)

        variants: Dict[str, list] = {}
        for r in net.rules:
            variants.setdefault(r.rule_id, []).append(r)
        # A reused rule id (lint reports these as warnings, not errors) makes
        # the guard ambiguous: we would silently compile against whichever
        # variant landed last in the dict.  Refuse those intersections.
        ambiguous_ids = {rid for rid, rs in variants.items() if len(rs) > 1}

        by_id = {r.rule_id: r for r in net.rules}
        fitted = []
        for key, (X, y) in sorted(groups.items()):
            if any(rid in ambiguous_ids for rid in key):
                continue
            key_rules = [by_id[rid] for rid in key if rid in by_id]
            if not key_rules:
                continue
            # A tree fitted on one or two labelled examples is a leaf that just
            # memorises the teacher on those boards. Require enough mass that
            # the split is a generalisation, not a lookup.
            if len(X) < min_examples:
                continue
            tree = ID3DecisionTree(max_depth=3)
            tree.fit(X, y)
            fitted.append((key, tree))

        if not fitted:
            return []

        sig = "curated:ID3"
        if self.sig_failed(sig):
            return []

        def patch(n):
            # Attach rather than compile.  A refinement fires only when the
            # matched rule set is EXACTLY the intersection key, whereas
            # compiled rules (AND of the key rules' conditions) fire on a
            # superset and measurably overrode unrelated auctions.  Trees now
            # survive save->load, so this is both exact and persistent.
            for key, tree in fitted:
                n.attach_refinement(key, tree)

        return [(sig, "ID3", patch)]

    @staticmethod
    def flaw_dump(res, max_boards=6) -> List[str]:
        lines = []
        diags = sorted(res["diagnostics"], key=lambda d: -d.severity_pts)[:max_boards]
        for d in diags:
            auction = " ".join(str(c) for c in d.actual_history)
            lines.append(f"      Bd {d.board_id:<3} [{d.flaw_type.value:<15}] "
                         f"{d.par_contract:<14} loss {d.severity_pts:5.0f} | {auction}")
        return lines

    def run_round(self, round_no: int, current: DecisionNet, cur_train) -> Tuple[DecisionNet, object, List[str]]:
        metric = self.metric
        print(f"\n{'='*92}\n ROUND {round_no} | train {metric} "
              f"{cur_train[metric]:+.3f} | flaws {dict(cur_train['flaws'])}\n{'='*92}")
        print("   Worst boards:")
        for line in self.flaw_dump(cur_train):
            print(line)

        pool = self.build_pool(current, cur_train["diagnostics"])
        newly_failed = []
        applied = []

        for pass_no in (1, 2):
            if not pool:
                break
            print(f"\n   [pass {pass_no}] testing {len(pool)} generated patches:")
            best_sig, best_name, best_fn, best_delta, best_res = None, None, None, 0.0, None
            tested: List[Tuple[str, float]] = []
            for sig, name, fn in pool:
                cand = current.clone()
                fn(cand)
                res = self.evl(cand, self.train_deals, self.dd_train)
                delta = metric_gain(cur_train[metric], res[metric], metric)
                tested.append((sig, delta))
                # Paired, board-by-board significance of this candidate. The
                # effect floor alone cannot say whether a delta is real: with
                # ~4.0 IMP per-board sd, 96 boards resolve only ~0.8 IMP/board.
                self.last_paired = paired_imp_test(cur_train, res) \
                    if metric in LOWER_IS_BETTER else None
                ok = (passes_effect_floor(delta, metric)
                      and res["par_accuracy"] >= cur_train["par_accuracy"] - 5
                      and res["avg_imp_loss"] <= cur_train["avg_imp_loss"] + 0.15)
                if ok and delta > best_delta:
                    best_sig, best_name, best_fn, best_delta, best_res = sig, name, fn, delta, res
                p = self.last_paired
                if p and p.get("n"):
                    flag = "sig" if abs(p["t"]) > 1.96 else "   "
                    print(f"     {name:<34} {delta:+8.3f}  "
                          f"[{p['mean_diff']:+.3f} +/-{1.96*p['se']:.3f} "
                          f"t{p['t']:+5.2f} {flag} n~{p['n_needed']:.0f}]")
                else:
                    print(f"     {name:<34} {delta:+8.3f}")
            for sig, delta in tested:
                if delta <= 0:
                    newly_failed.append(sig)
            if best_sig is None:
                print("     no improving patch this pass")
                break
            best_fn(current)
            precision = 3 if metric in LOWER_IS_BETTER else 1
            applied.append({"sig": best_sig, "name": best_name,
                            "delta": round(best_delta, precision)})
            pool = [p for p in pool if p[0] != best_sig]
            cur_train = best_res
            print(f"     APPLIED {best_name} ({best_delta:+.{precision}f}) | rules {len(current.rules)}")

        for sig in dict.fromkeys(newly_failed):
            self.fail(sig)
        return current, cur_train, applied

    def validate_and_save(self, original, orig_train, orig_val, current, cur_train, applied):
        metric = self.metric
        tol = val_tolerance(metric)
        final_val = {s: self.evl(current, *self.val_sets[s]) for s in self.val_seeds}
        train_gain = metric_gain(orig_train[metric], cur_train[metric], metric)
        print(f"\n   VALIDATION ({metric}): train {train_gain:+.3f}", end="")
        val_ok = True
        val_deltas = []
        for s in self.val_seeds:
            d = metric_gain(orig_val[s][metric], final_val[s][metric], metric)
            val_ok = val_ok and d > -tol
            val_deltas.append(d)
            print(f" | val{s} {d:+.3f}", end="")
        print()

        # The gate above is one-sided: it rejects a clear regression but
        # accepts anything neutral, including a no-op. Say so explicitly when
        # the gain is smaller than the screening can resolve, otherwise a
        # noise-level round looks identical to a validated one in the log.
        mde = min_detectable_effect(len(self.val_seeds), metric)
        mean_val = sum(val_deltas) / len(val_deltas)
        if mean_val < mde:
            if mde == float("inf"):
                print(f"   NOTE: mean validation gain {mean_val:+.3f} — no noise "
                      f"calibration for metric '{metric}', resolvability unknown.")
            else:
                print(f"   WARNING: mean validation gain {mean_val:+.3f} is below "
                      f"the resolution of {len(self.val_seeds)} deal set(s) "
                      f"(~+/-{mde:.3f} at 95%). Not distinguishable from "
                      f"resampling noise — treat this round as unproven, not "
                      f"as an improvement. More --val-seeds buys resolution; "
                      f"see research/status.md S6.16.")

        sds_delta = None
        if self.sds_scorer is not None:
            o = self.evl(original, self.train_deals, self.dd_train)
            c = self.evl(current, self.train_deals, self.dd_train)
            sds_delta = c["avg_score_sds"] - o["avg_score_sds"]
            print(f"   SDS two-hand check: {o['avg_score_sds']:+.1f} -> {c['avg_score_sds']:+.1f} "
                  f"({sds_delta:+.1f})")
            if sds_delta < -5:
                print("   REJECTED: DD gain is luck-based (SDS realistic-info score regressed)")
                for a in applied:
                    self.fail(a["sig"])
                return False

        if applied and train_gain > 0 and val_ok:
            v = self.state["version"]
            stem = os.path.splitext(os.path.basename(self.target))[0]
            os.makedirs(HISTORY_DIR, exist_ok=True)
            shutil.copy(self.target, os.path.join(HISTORY_DIR, f"{stem}_v{v}.dsl"))
            self.state["version"] = v + 1
            n_expired = expire_failed(self.state)
            current.name = f"{stem}_v{self.state['version']}"
            current.save_dsl(self.target)
            self.state["applied"].extend(applied)
            self._save_state()
            print(f"   SAVED v{self.state['version']} -> {self.target} (archived v{v})"
                  + (f", expired {n_expired} stale failure sigs" if n_expired else ""))
            return True
        print("   NOT SAVED (validation failed or no patches)")
        for a in applied:
            self.fail(a["sig"])
        return False


def main():
    parser = argparse.ArgumentParser(description="Continuous improvement flywheel")
    parser.add_argument("--deals", type=int, default=48)
    parser.add_argument("--rounds", type=int, default=3)
    parser.add_argument("--pool-cap", type=int, default=14)
    parser.add_argument("--sds", action="store_true", help="Gate saves on SDS two-hand score")
    parser.add_argument("--sds-primary", action="store_true",
                        help="Hill-climb directly on the SDS two-hand objective")
    parser.add_argument("--metric", default="avg_score",
                        choices=["avg_score", "mean_imp_loss"],
                        help="Objective to hill-climb. mean_imp_loss is IMP-capped "
                             "(24 max) so one slam disaster cannot decide a round; "
                             "avg_score is raw points/board (historical default)")
    parser.add_argument("--panel", action="store_true",
                        help="Score against a fixed heterogeneous opponent panel "
                             "instead of a copy of the evolving system, so the loop "
                             "cannot converge to a self-play fixed point")
    parser.add_argument("--id3", action="store_true",
                        help="EXPERIMENTAL — measured net-negative so far. Add the BIDI "
                             "speedup-learning family: PIDM labels ambiguous states, ID3 "
                             "finds the discriminating split, and the tree is compiled to "
                             "rules. Measured net-negative at 96 deals (§6.14): "
                        "kept for the persistence fixes, not for the gain")
    parser.add_argument("--jobs", type=int, default=1,
                        help="Score the deal set across N processes (boards are "
                             "independent). Near-linear speedup; use it to afford a "
                             "deal budget large enough for the deltas to be real")
    parser.add_argument("--id3-states", type=int, default=60,
                        help="How many ambiguous states to label with PIDM for the "
                             "ID3 family (default 60). More states = less "
                             "data-starved trees, at ~0.5s each")
    parser.add_argument("--val-seeds", default=",".join(str(s) for s in VAL_SEEDS),
                        help="Comma-separated validation deal seeds. Two sets "
                             "resolve only ~0.58 IMP/board (§6.16); add more to "
                             "buy resolution — cost is linear in the count")
    parser.add_argument("--state", default=STATE_PATH,
                        help="Patch-state file. Point this elsewhere to "
                             "experiment without bumping the real version "
                             "counter or archiving into system/history/")
    parser.add_argument("--target", default=TARGET,
                        help="DSL to improve and write back (default improved_system.dsl). "
                             "Point this at the strongest known system — e.g. "
                             "system/champion_system.dsl — since local patches cannot "
                             "close a large structural gap on their own")
    args = parser.parse_args()

    t0 = time.time()
    engine = PIDMEngine(sampler=RBMBMCSampler(sample_size=2, max_iterations=6, timeout_sec=0.06),
                        max_lookahead_depth=1)
    sds_scorer = None
    if args.sds or args.sds_primary:
        from bid.sds import SDSScorer
        sds_scorer = SDSScorer(num_worlds=20, seed=2024)
        mode = "SDS-primary hill-climb" if args.sds_primary else "SDS save-gate"
        print(f"{mode} enabled")
    try:
        val_seeds = tuple(int(s) for s in args.val_seeds.split(",") if s.strip())
    except ValueError:
        parser.error("--val-seeds must be comma-separated integers")
    if not val_seeds:
        parser.error("--val-seeds needs at least one seed")

    fw = Flywheel(BiddingArena(engine=engine), args.deals, args.pool_cap,
                  sds_scorer=sds_scorer, sds_primary=args.sds_primary,
                  metric=args.metric, panel=args.panel, target=args.target,
                  id3=args.id3, jobs=args.jobs, val_seeds=val_seeds,
                  state_path=args.state)
    if args.panel:
        print(f"opponent panel: {', '.join(n for n, _ in fw.panel)} "
              f"(frozen, not the evolving system)")
    print(f"objective: {fw.metric}")

    # Say up front what this budget can actually see. Without this, a run at
    # the 48-deal default looks exactly like a well-powered one.
    res = resolution_of(args.deals, fw.metric)
    if res == float("inf"):
        print(f"resolution: uncalibrated for '{fw.metric}' — treat deltas as "
              f"unverifiable")
    else:
        print(f"resolution: {args.deals} boards resolve ~{res:.2f} "
              f"(IMP/board at 95%); {len(val_seeds)} val set(s) resolve "
              f"~{min_detectable_effect(len(val_seeds), fw.metric):.2f} on "
              f"generalisation")
        if res > 0.5:
            print(f"  !! a {res:.2f} IMP/board resolution cannot see the "
                  f"~0.28 IMP/board gap measured in §6.18 — raise --deals "
                  f"(~750 boards resolves 0.29)")

    original = load_decision_net_dsl(fw.target)
    orig_train = fw.evl(original, fw.train_deals, fw.dd_train)
    orig_val = {s: fw.evl(original, *fw.val_sets[s]) for s in VAL_SEEDS}
    print(f"Start: train {orig_train['avg_score']:+.1f} | "
          + " | ".join(f"val{s} {orig_val[s]['avg_score']:+.1f}" for s in VAL_SEEDS)
          + f" | state v{fw.state['version']} ({len(fw.state['failed'])} cached failures)")

    current, cur_train = original.clone(), orig_train
    for rnd in range(1, args.rounds + 1):
        current, cur_train, applied = fw.run_round(rnd, current, cur_train)
        if not applied:
            print("\nFlywheel converged: no patch improved this round.")
            break
        if not fw.validate_and_save(original, orig_train, orig_val, current, cur_train, applied):
            break

    final = fw.evl(current, fw.train_deals, fw.dd_train)
    print(f"\n{'='*92}\n SESSION SUMMARY\n{'='*92}")
    print(f"  train : {orig_train['avg_score']:+.1f} -> {final['avg_score']:+.1f} "
          f"({final['avg_score'] - orig_train['avg_score']:+.1f})")
    for s in VAL_SEEDS:
        rv = fw.evl(current, *fw.val_sets[s])
        print(f"  val{s}  : {orig_val[s]['avg_score']:+.1f} -> {rv['avg_score']:+.1f} "
              f"({rv['avg_score'] - orig_val[s]['avg_score']:+.1f})")
    print(f"  state : v{fw.state['version']} | {len(fw.state['failed'])} cached failures "
          f"| {len(fw.state['applied'])} lifetime patches applied")
    print(f"  Done in {time.time() - t0:.1f}s")


if __name__ == "__main__":
    main()
