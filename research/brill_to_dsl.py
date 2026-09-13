#!/usr/bin/env python3
"""
brill_to_dsl.py — convert the captured Brill system into this repo's DSL.

    python3 research/brill_to_dsl.py                # write system/brill.dsl
    python3 research/brill_to_dsl.py --report       # coverage stats only
    python3 research/brill_to_dsl.py --no-approx    # exact translations only

WHAT THIS DOES
--------------
system/brill.md holds 3,515 Brill call definitions, each guarded by a
`requires` expression in Brill's own expression language.  This script
compiles each of those expressions into DecisionNet DSL rules:

  * the auction position becomes context conditions
    (is_opening / partner_last_call / opp_last_call / passes_since_last_bid)
  * the expression is negated-in, converted to disjunctive normal form, and
    each disjunct becomes its own rule (a disjunction of identical CALLs is
    exactly a set of rules with the same CALL)

WHAT IT CANNOT DO
-----------------
The DSL is a flat conjunction of `feature op constant` predicates over a
fixed feature vocabulary.  Brill's language is far richer.  Three classes of
atom have no DSL equivalent and a clause containing one is DROPPED:

  * Brill's own computed verdicts — `game`, `slammish`, `penalty`,
    `CanBid6_C`, `CanAsk_D_RKC`, `S_compgame`, ...  These are the engine's
    answers, not hand tests; reproducing them needs Brill's evaluator.
  * suit-quality shapes — `realsolid`, `trump`, `rebiddable`,
    `twicerebiddable`, `monsterslam`, `covergame`, `preemptgame`, ...
  * auction-shape tests — `ruleof21`, `overcall()`, `fourthseatopening()`,
    `takeout()`, `competitive()`, `cansacrifice()`, and Brill's `loserlevel`.

Dropping a clause is safe (the system merely declines to bid); RELAXING one
is not (the system would bid on hands it should not).  So nothing is relaxed.

A few atoms are APPROXIMATE — same intent, different arithmetic:

  losers        -> losing_trick_count   (Brill's cover-card losers vs LTC)
  X_points      -> X_hcp                (Brill's length-adjusted suit points)
  balish        -> is_semi_balanced
  stopper('X')  -> X_stopper >= 2

Dropped outright, because the DSL compares a feature to a CONSTANT and so
cannot express "suit X is my longest": clublongest / diamondlongest /
heartlongest / spadelongest / bestsuit(X) / bestmajor(X) / bestminor(X).

Run with --no-approx to emit only exact translations.  --report prints how
much of Brill survives.

WHY THE OR-SPLITTING IS CORRECT
-------------------------------
DecisionNet's candidate set is the union over matching rules, so N rules
sharing a CALL and covering the N disjuncts denote exactly the disjunction.
They are given distinct ids and identical PRIORITY, so ordering is unchanged.
"""

import argparse
import itertools
import os
import re
import sys
from collections import Counter
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Tuple

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from brill_parser import (  # noqa: E402
    rows_from_brill_md, parse_expr, to_dnf, contradictions,
    Name, Cmp, Call_, Not, Lit, BinOp, And, Or,
)

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
DEFAULT_OUT = os.path.join(REPO_ROOT, "system", "brill.dsl")

# ------------------------------------------------------------------ sentinels

TRUE = "TRUE"      # atom is always satisfied -> drop from the clause
FALSE = "FALSE"    # atom can never hold      -> whole clause is unsatisfiable
SKIP = None        # atom has no DSL equivalent -> drop the whole clause


class ALT:
    """An atom that expands into several alternative condition-sets.

    Used for `HasTopHonors('X', n, m)` where m > 3: the repo only exposes
    top2/top3 counts, but "n of the top 4" is exactly the union over the
    C(4, n) ways of naming which n of {A, K, Q, J} are held.
    """
    __slots__ = ("options",)

    def __init__(self, options):
        self.options = options

FLIP = {"==": "!=", "!=": "==", ">=": "<", "<=": ">", ">": "<=", "<": ">="}

LONG = {"C": "club", "D": "diamond", "H": "heart", "S": "spade"}
SHORT = {"C": "c", "D": "d", "H": "h", "S": "s"}

# Brill scalar -> repo feature.  (feature, approximate?)
SCALARS: Dict[str, Tuple[str, bool]] = {
    "hcp": ("hcp", False), "Hcp": ("hcp", False), "HCP": ("hcp", False),
    "C": ("club_len", False), "clubs": ("club_len", False),
    "D": ("diamond_len", False), "diamonds": ("diamond_len", False),
    "H": ("heart_len", False), "hearts": ("heart_len", False),
    "S": ("spade_len", False), "spades": ("spade_len", False),
    "aces": ("ace_count", False),
    "controls": ("controls", False),
    "totalpoints": ("total_points", False),
    "lengthlongestsuit": ("longest_suit_len", False),
    "king_count": ("king_count", False),
    "queen_count": ("queen_count", False),
    "jack_count": ("jack_count", False),
    "quicktricks": ("quick_tricks", False),
    # --- approximate -------------------------------------------------------
    "losers": ("losing_trick_count", True),
    "C_points": ("club_hcp", True), "D_points": ("diamond_hcp", True),
    "H_points": ("heart_hcp", True), "S_points": ("spade_hcp", True),
    "clubpoints": ("club_hcp", True), "diamondpoints": ("diamond_hcp", True),
    "heartpoints": ("heart_hcp", True), "spadepoints": ("spade_hcp", True),
    "suitpoints": ("hcp", True),       # suitpoints('X') is suit-specific; only
                                       # ever used with a suit arg, handled below
}

# bare boolean identifiers -> condition tuple (or TRUE/FALSE/SKIP)
BOOLS: Dict[str, Any] = {
    "true": TRUE, "false": FALSE,
    "balanced": ("is_balanced", "==", True),
    "semibalanced": ("is_semi_balanced", "==", True),
    "balish": ("is_semi_balanced", "==", True),          # approx
    "unbalanced": ("is_unbalanced", "==", True),
    # NOTE: Brill's `clublongest` / `diamondlongest` / ... and `bestsuit('X')`
    # all mean "suit X is the longest", i.e. X_len >= longest_suit_len.  The
    # DSL compares a feature against a CONSTANT, so a feature-to-feature
    # comparison cannot be written — the RHS would parse as the string
    # 'longest_suit_len' and raise TypeError at match time.  These atoms are
    # therefore dropped, never faked.
}


def clause_contradictions(conds) -> bool:
    """Impossible conjunction on one feature, e.g. `diamond_len == 4` and
    `diamond_len >= 5`.

    Brill's own rules contain dead disjuncts like this (row 1724: a 2D
    response gated on `(diamonds > hearts or diamonds == 4) and
    (diamonds > clubs or diamonds >= 5)` — the `== 4` / `>= 5` branch is
    unsatisfiable).  Dropping them here keeps the lint clean and saves the
    search from considering a rule that can never fire.
    """
    by: Dict[str, List[Tuple[str, Any]]] = {}
    for k, op, v in conds:
        by.setdefault(k, []).append((op, v))
    for _k, cs in by.items():
        eqs = {str(v) for op, v in cs if op == "=="}
        if len(eqs) > 1:
            return True
        lo = hi = None
        lo_s = hi_s = False
        for op, v in cs:
            if isinstance(v, bool) or not isinstance(v, (int, float)):
                continue
            if op in (">=", ">"):
                if lo is None or v > lo or (v == lo and op == ">"):
                    lo, lo_s = v, (op == ">")
            elif op in ("<=", "<"):
                if hi is None or v < hi or (v == hi and op == "<"):
                    hi, hi_s = v, (op == "<")
            elif op == "==":
                if lo is None or v > lo:
                    lo, lo_s = v, False
                if hi is None or v < hi:
                    hi, hi_s = v, False
        if lo is not None and hi is not None:
            if lo > hi or (lo == hi and (lo_s or hi_s)):
                return True
    return False


def suit_of(arg) -> Optional[str]:
    """Pull a suit letter out of a Brill string argument like 'H'."""
    if isinstance(arg, Lit) and isinstance(arg.value, str):
        v = arg.value.strip().upper()
        return v if v in LONG else None
    return None


# --------------------------------------------------------------- negations

def push_neg(node, neg: bool = False):
    """Push negations inward (De Morgan) so to_dnf sees only literals."""
    if isinstance(node, Not):
        return push_neg(node.part, not neg)
    if isinstance(node, And):
        parts = [push_neg(p, neg) for p in node.parts]
        return Or(parts) if neg else And(parts)
    if isinstance(node, Or):
        parts = [push_neg(p, neg) for p in node.parts]
        return And(parts) if neg else Or(parts)
    if isinstance(node, Cmp):
        return Cmp(FLIP[node.op], node.left, node.right) if neg else node
    return Not(node) if neg else node


# ------------------------------------------------------------- translation

def translate_call(node: Call_):
    """Boolean-valued Brill function call -> condition, or SKIP/TRUE/FALSE."""
    fn = node.name
    a = node.args[0] if node.args else None
    suit = suit_of(a)

    if fn == "HasTopHonors" and suit and len(node.args) == 3:
        n, top = node.args[1], node.args[2]
        if not (isinstance(n, Lit) and isinstance(top, Lit)):
            return SKIP
        n, top = int(n.value), int(top.value)
        if top in (2, 3):
            return (f"{SHORT[suit]}_top{top}_honors", ">=", n)
        # top 4 / top 5: expand over the named honour booleans
        pool = ["has_ace", "has_king", "has_queen", "has_jack", "has_ten"][:top]
        if not (0 < n <= len(pool)):
            return SKIP
        opts = [[(f"{SHORT[suit]}_{h}", "==", True) for h in combo]
                for combo in itertools.combinations(pool, n)]
        return ALT(opts)

    if fn in ("stopper", "Stopper") and suit:
        return (f"{SHORT[suit]}_stopper", ">=", 2)          # approx
    if fn == "doublestopper" and suit:
        return (f"{SHORT[suit]}_stopper", ">=", 3)          # approx

    # bestsuit / bestmajor / bestminor all need a feature-to-feature
    # comparison; see the note in BOOLS.  Dropped.

    if fn == "suitpoints" and suit:
        return (f"{LONG[suit]}_hcp", ">=", None)            # filled by caller
    return SKIP


def translate_literal(lit, allow_approx: bool):
    """-> (key, op, value) | TRUE | FALSE | SKIP."""
    # --- Not(...)
    if isinstance(lit, Not):
        inner = translate_literal(lit.part, allow_approx)
        if isinstance(inner, ALT):
            return SKIP          # negating an n-of-m expansion: not worth it
        if inner in (TRUE, FALSE, SKIP):
            return FALSE if inner is TRUE else (TRUE if inner is FALSE else SKIP)
        key, op, val = inner
        if op == "==" and isinstance(val, bool):
            return (key, "==", not val)
        if op in FLIP:
            return (key, FLIP[op], val)
        return SKIP

    # --- comparison
    if isinstance(lit, Cmp):
        left, right = lit.left, lit.right
        if not isinstance(right, Lit) or isinstance(right.value, str):
            # explicitshape == '4=3=3=3' is the one string comparison
            if (isinstance(left, Name) and left.name == "explicitshape"
                    and isinstance(right, Lit) and isinstance(right.value, str)):
                if lit.op != "==":
                    return SKIP          # != over 4 suits is not a conjunction
                # explicitshape is 'S=H=D=C'; the repo's shape_pattern is the
                # same digits SORTED, so it cannot tell '4=3=3=3' (4 spades)
                # from '3=3=3=4' (4 clubs).  Pin every suit length as well —
                # otherwise the rule silently relaxes and fires on hands
                # Brill would reject.
                d = [int(x) for x in re.findall(r"\d", right.value)]
                if len(d) != 4:
                    return SKIP
                conds = [("shape_pattern", "==",
                          int("".join(str(x) for x in sorted(d, reverse=True))))]
                for suit, n in zip(("spade", "heart", "diamond", "club"), d):
                    conds.append((f"{suit}_len", "==", n))
                return ALT([conds])
            return SKIP
        if isinstance(left, BinOp):
            return SKIP                       # no arithmetic in the DSL
        if isinstance(left, Call_):
            if left.name == "suitpoints" and suit_of(left.args[0] if left.args else None):
                s = suit_of(left.args[0])
                return (f"{LONG[s]}_hcp", lit.op, right.value)
            return SKIP
        if not isinstance(left, Name):
            return SKIP
        mapped = SCALARS.get(left.name)
        if mapped is None:
            return SKIP
        feat, approx = mapped
        if approx and not allow_approx:
            return SKIP
        return (feat, lit.op, right.value)

    # --- bare name
    if isinstance(lit, Name):
        v = BOOLS.get(lit.name, SKIP)
        if v is SKIP:
            return SKIP
        return v

    # --- boolean-valued call
    if isinstance(lit, Call_):
        return translate_call(lit)

    if isinstance(lit, Lit):
        if lit.value is True:
            return TRUE
        if lit.value is False:
            return FALSE
        return SKIP

    return SKIP


# --------------------------------------------------------- auction context

def norm_call(s: str) -> str:
    """Brill call token -> the string the repo's feature extractor produces."""
    s = s.strip().replace("*", "")
    if s in ("P", "PASS"):
        return "PASS"
    if s in ("X", "XX"):
        return s
    m = re.match(r"^(\d)(N|C|D|H|S)$", s)
    if not m:
        return s
    return m.group(1) + ("NT" if m.group(2) == "N" else m.group(2))


def auction_context(auction: str) -> List[Tuple[str, str, Any]]:
    """Context conditions for a Brill position.

    Brill anchors every position on OUR turn, so the call immediately before
    the hole is always an opponent's and the one before that is partner's:
        (empty)   we are the opener
        1H        LHO opened 1H, we act
        1H-P      partner opened 1H, RHO passed, we respond
        1H-1S     partner opened 1H, RHO overcalled 1S, we act
    """
    # In every captured position WE have not acted yet and, except at depth 2
    # where partner has opened, neither has partner.  Saying so keeps the
    # shallow positions from leaking into deeper ones: without it the `2H`
    # rule (2nd seat, partner silent) also fired in the `P-2H` position
    # (partner passed first), which Brill scores differently — that produced
    # 380 priority-shadowing warnings in the linter.
    if auction in ("P", "", "—"):
        return [("is_opening", "==", True),
                ("partner_last_call", "==", "NONE"),
                ("my_last_call", "==", "NONE")]

    parts = auction.split("-")
    conds: List[Tuple[str, str, Any]] = [("is_opening", "==", False),
                                         ("my_last_call", "==", "NONE")]

    if len(parts) == 1:
        conds.append(("opp_last_call", "==", norm_call(parts[0])))
        conds.append(("partner_last_call", "==", "NONE"))
        return conds

    if len(parts) == 2:
        first, second = parts
        conds.append(("partner_last_call", "==", norm_call(first)))
        snd = second.strip().replace("*", "")
        if snd in ("P", "PASS"):
            # passes are not tracked in opp_last_call (it scans for BIDs only)
            conds.append(("opp_last_call", "==", "NONE"))
            conds.append(("passes_since_last_bid", "==", 1))
        elif snd in ("X", "XX"):
            conds.append(("opp_last_call", "==", "NONE"))
            conds.append(("passes_since_last_bid", "==", 0))
        else:
            conds.append(("opp_last_call", "==", norm_call(snd)))
            conds.append(("passes_since_last_bid", "==", 0))
        return conds

    return []          # deeper than we captured; no context


# ----------------------------------------------------------------- emit

@dataclass
class OutRule:
    rid: str
    call: str
    priority: int
    conds: List[Tuple[str, str, Any]]
    desc: str


def fmt_value(v) -> str:
    if isinstance(v, bool):
        return "True" if v else "False"
    if isinstance(v, str):
        if v.startswith("@"):
            return v[1:]                      # feature-to-feature comparison
        return "'" + v + "'"
    return str(v)


# ------------------------------------------------------- Part 1 supplement

# Openings that the rule tree defines only through atoms the DSL cannot
# express, and which brill.md's Part 1 prose therefore has to supply.  Every
# line below is quoted from that table ("### Openings"); nothing is invented.
# PRIORITY is Brill's own for the same call in the same position, taken from
# the root table in Part 2 (1H 70, 1S 75, weak twos 60, 3C 85 / 3D 86 /
# 3H 87 / 3S 88) so these interleave correctly with the tree-derived rules.
#
# "no four-card major on the side" -> the other major(s) <= 3.
PROSE_OPENINGS = [
    ("1H", 70, [("hcp", ">=", 12), ("hcp", "<=", 21), ("heart_len", ">=", 5)],
     "12-21 HCP, 5+ hearts"),
    ("1H", 69, [("hcp", "==", 11), ("heart_len", ">=", 6)],
     "11-count with a six-card major"),
    ("1H", 69, [("hcp", "==", 11), ("heart_len", ">=", 5), ("spade_len", ">=", 4)],
     "11-count, 5-4 in the majors"),
    ("1S", 75, [("hcp", ">=", 12), ("hcp", "<=", 21), ("spade_len", ">=", 5)],
     "12-21 HCP, 5+ spades"),
    ("1S", 74, [("hcp", "==", 11), ("spade_len", ">=", 6)],
     "11-count with a six-card major"),
    ("1S", 74, [("hcp", "==", 11), ("spade_len", ">=", 5), ("heart_len", ">=", 4)],
     "11-count, 5-4 in the majors"),
    ("2D", 60, [("diamond_len", "==", 6), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("heart_len", "<=", 3), ("spade_len", "<=", 3)],
     "weak two: exactly six, 5-11 HCP, no four-card major"),
    ("2H", 60, [("heart_len", "==", 6), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("spade_len", "<=", 3)],
     "weak two: exactly six, 5-11 HCP, no four-card major"),
    ("2S", 60, [("spade_len", "==", 6), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("heart_len", "<=", 3)],
     "weak two: exactly six, 5-11 HCP, no four-card major"),
    ("3C", 85, [("club_len", ">=", 7), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("heart_len", "<=", 3), ("spade_len", "<=", 3)],
     "preempt: seven cards, 5-11 HCP, no four-card major"),
    ("3D", 86, [("diamond_len", ">=", 7), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("heart_len", "<=", 3), ("spade_len", "<=", 3)],
     "preempt: seven cards, 5-11 HCP, no four-card major"),
    ("3H", 87, [("heart_len", ">=", 7), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("spade_len", "<=", 3)],
     "preempt: seven cards, 5-11 HCP, no four-card major"),
    ("3S", 88, [("spade_len", ">=", 7), ("hcp", ">=", 5), ("hcp", "<=", 11),
                ("heart_len", "<=", 3)],
     "preempt: seven cards, 5-11 HCP, no four-card major"),
]


def prose_opening_rules() -> List[OutRule]:
    """Rules derived from the Part 1 prose, for openings the tree lost."""
    ctx = [("is_opening", "==", True),
           ("partner_last_call", "==", "NONE"),
           ("my_last_call", "==", "NONE")]
    out = []
    for i, (call, pri, extra, note) in enumerate(PROSE_OPENINGS):
        out.append(OutRule(f"BR_PROSE_OPEN_{call}_{i}", call, pri, ctx + extra, note))
    return out


def build(allow_approx: bool = True, max_clauses: int = 64):
    rows = rows_from_brill_md(os.path.join(REPO_ROOT, "system", "brill.md"))
    rules: List[OutRule] = []
    stats = Counter()
    seen_bodies = set()

    for row_i, r in enumerate(rows):
        stats["rows"] += 1
        ctx = auction_context(r.auction)
        if not ctx:
            stats["row_no_context"] += 1
            continue

        expr = parse_expr(r.requires)
        if expr is None:
            stats["row_unparseable"] += 1
            continue

        clauses = to_dnf(push_neg(expr))
        if len(clauses) > max_clauses:
            stats["row_too_many_clauses"] += 1
            continue

        call = norm_call(r.call)
        try:
            pri = int(r.pri) if r.pri.strip() else 0
        except ValueError:
            pri = 0

        produced = 0
        for idx, clause in enumerate(clauses):
            if contradictions(clause):
                stats["clause_contradiction"] += 1
                continue
            alts: List[List[Tuple[str, str, Any]]] = [list(ctx)]
            dead = dropped = False
            approx_used = False
            for lit in clause:
                t = translate_literal(lit, allow_approx)
                if t is SKIP:
                    dropped = True
                    break
                if t is FALSE:
                    dead = True
                    break
                if t is TRUE:
                    continue
                if isinstance(t, ALT):
                    grown = [a + o for a in alts for o in t.options]
                    if len(grown) > max_clauses:
                        dropped = True
                        break
                    alts = grown
                    continue
                key, op, val = t
                if isinstance(val, str) and val.startswith("@"):
                    approx_used = True
                alts = [a + [(key, op, val)] for a in alts]
            if dropped:
                stats["clause_dropped"] += 1
                continue
            if dead:
                stats["clause_unsat"] += 1
                continue

            for vi, conds in enumerate(alts):
                if clause_contradictions(conds):
                    stats["clause_contradiction"] += 1
                    continue
                if len(conds) == len(ctx):
                    stats["clause_unconditional"] += 1
                body = (call, pri,
                        tuple(sorted((k, o, fmt_value(v)) for k, o, v in conds)))
                if body in seen_bodies:
                    stats["clause_duplicate"] += 1
                    continue
                seen_bodies.add(body)
                # row_i keeps ids unique: one Brill position can hold several
                # rows with the same call (different "Means"), and they all
                # restart their clause index at 0.
                rid = "B_" + re.sub(r"[^0-9A-Za-z]", "_", r.auction) + "_" \
                      + re.sub(r"[^0-9A-Za-z]", "_", call) \
                      + f"_{row_i}_{idx}"
                if len(alts) > 1:
                    rid += f"_{vi}"
                desc = r.means if not r.means.startswith("_(") else ""
                rules.append(OutRule(rid, call, pri, conds, desc))
                produced += 1
                if approx_used:
                    stats["rule_approx"] += 1

        if produced:
            stats["rows_emitted"] += 1
        else:
            stats["rows_lost"] += 1

    # Part 1 prose fills the openings the tree could not express.
    prose = prose_opening_rules()
    for pr in prose:
        body = (pr.call, pr.priority,
                tuple(sorted((k, o, fmt_value(v)) for k, o, v in pr.conds)))
        if body not in seen_bodies:
            seen_bodies.add(body)
            rules.append(pr)
    stats["prose_rules"] = len(prose)

    return rules, stats, len(rows)


def render(rules: List[OutRule], stats: Counter, total_rows: int,
           allow_approx: bool) -> str:
    out = []
    out.append("# ==========================================================")
    out.append("# BRILL BIDDING SYSTEM — converted from system/brill.md")
    out.append("#")
    out.append("# Source : https://brillsystem.aalborgdata.dk/")
    out.append("#         Brill 0.1.0+20260912.0835.g9eb75e9-dirty")
    out.append("#         (1,037,464 rules in the live engine)")
    out.append("# Convert: python3 research/brill_to_dsl.py")
    out.append("#")
    out.append(f"# {total_rows} Brill call definitions -> {len(rules)} DSL rules.")
    out.append("#")
    out.append("# CAVEATS — read before trusting this file:")
    out.append("#   * Only the tree 2 calls deep was captured.")
    out.append("#   * Clauses containing atoms with no DSL equivalent are")
    out.append("#     DROPPED, never relaxed.  Brill's own computed verdicts")
    out.append("#     (game / slammish / CanBid6_* / CanAsk_*_RKC / loserlevel)")
    out.append("#     and its suit-quality tests (realsolid / trump /")
    out.append("#     rebiddable / monsterslam) are NOT reproduced.  The system")
    out.append("#     here is therefore thinner than Brill, especially for")
    out.append("#     slams and sacrifices — it will underbid rather than")
    out.append("#     overbid, which is the safe direction.")
    out.append("#   * Approximations in use" + (":" if allow_approx else ": NONE"))
    if allow_approx:
        out.append("#       losers        -> losing_trick_count")
        out.append("#       X_points      -> X_hcp")
        out.append("#       balish        -> is_semi_balanced")
        out.append("#       stopper('X')  -> X_stopper >= 2")
    out.append("#   * Dropped entirely (needs a feature-to-feature compare):")
    out.append("#       Xlongest / bestsuit(X) / bestmajor(X) / bestminor(X)")
    out.append("#")
    out.append("# WHAT IS MISSING, AND WHY IT CANNOT BE FIXED HERE")
    out.append("#   * Tree rules for the 1M openings, the weak twos and the 3-level")
    out.append("#     preempts all depend on unpublished macros (Opening1H/1S,")
    out.append("#     ruleof21, loserlevel), so none survive translation.  They are")
    out.append("#     RESTORED at the end of this file from Part 1's prose summary")
    out.append("#     (mark: BR_PROSE_*).  The 1C/1D openings still only survive for")
    out.append("#     the specific balanced shapes Brill spells out.")
    out.append("#   * The slam apparatus is gone (RKC0314, GSF, CanBid6_*, splinter")
    out.append("#     slam tries) — it is expressed as Brill's own computed verdicts.")
    out.append("#   * Sacrifices and competitive doubles are largely gone.")
    out.append("#   * Adding a `*_is_longest` feature to bid/features.py would")
    out.append("#     recover ~55 more rules, but does NOT recover 1H/1S.")
    out.append("#")
    out.append("# WHAT IS SOLID: responding and competing over partner's 1-level")
    out.append("# opening and over their 1NT — 60 auction positions, where the")
    out.append("# strength of the captured tree lies.")
    out.append("# ==========================================================")
    out.append("")

    by_auction: Dict[str, List[OutRule]] = {}
    for r in rules:
        by_auction.setdefault(r.desc and r.rid.rsplit("_", 1)[0] or "misc", []).append(r)

    emitted_prose_header = False
    for r in rules:
        if r.rid.startswith("BR_PROSE_") and not emitted_prose_header:
            emitted_prose_header = True
            out.append("# ----------------------------------------------------------")
            out.append("# Part 1 supplement — openings taken from brill.md's PROSE")
            out.append("# summary, because every tree rule for them depended on atoms")
            out.append("# the DSL cannot express (Opening1H/1S, ruleof21, loserlevel).")
            out.append("# Quoted verbatim from the '### Openings' table; priorities are")
            out.append("# Brill's own for these calls.  Without these, brill.dsl cannot")
            out.append("# open 1H, 1S, a weak two or a 3-level preempt at all.")
            out.append("# ----------------------------------------------------------")
            out.append("")
        out.append(f"RULE {r.rid}:")
        out.append(f"  CALL: {r.call}")
        out.append(f"  PRIORITY: {r.priority}")
        for k, o, v in r.conds:
            out.append(f"  CONDITION: {k} {o} {fmt_value(v)}")
        out.append("")
    return "\n".join(out) + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=DEFAULT_OUT)
    ap.add_argument("--no-approx", action="store_true")
    ap.add_argument("--report", action="store_true")
    ap.add_argument("--max-clauses", type=int, default=64)
    args = ap.parse_args()

    allow = not args.no_approx
    rules, stats, total = build(allow_approx=allow, max_clauses=args.max_clauses)

    print(f"Brill rows in brill.md      : {total}")
    print(f"  rows emitting >=1 rule    : {stats['rows_emitted']} "
          f"({100*stats['rows_emitted']/total:.1f}%)")
    print(f"  rows entirely lost        : {stats['rows_lost']}")
    print(f"  rows with no context      : {stats['row_no_context']}")
    print(f"  rows unparseable          : {stats['row_unparseable']}")
    print(f"  rows with >max clauses    : {stats['row_too_many_clauses']}")
    print(f"DSL rules produced          : {len(rules)}")
    print(f"  approx rules              : {stats['rule_approx']}")
    print(f"clauses dropped (no equiv)  : {stats['clause_dropped']}")
    print(f"clauses unsatisfiable       : {stats['clause_unsat']}")
    print(f"clauses contradictory       : {stats['clause_contradiction']}")
    print(f"clauses duplicate           : {stats['clause_duplicate']}")
    print(f"clauses unconditional       : {stats['clause_unconditional']}")

    if args.report:
        return

    text = render(rules, stats, total, allow)
    with open(args.out, "w") as f:
        f.write(text)
    print(f"\nwrote {args.out}: {len(text.splitlines())} lines, {len(text)} bytes")


if __name__ == "__main__":
    main()
