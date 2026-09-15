# Bid: Research Foundations & Implementation Status

*Current implementation status, empirical results, and open issues for this repo. Complements [`bid-invention.md`](bid-invention.md) (BIDI theory reconstruction) and [`sds-explained.md`](sds-explained.md) (SDS deep-dive).*

---

## 1. Mission

An autonomous, self-improving contract bridge **bidding** platform that reconstructs and extends Amit & Markovitch's BIDI architecture ("Learning to Bid in Bridge", MLJ 2006):

> rule-based candidate pruning → model-conditioned world sampling (RBMBMC) → recursive search (PIDM) → expensive-search-as-teacher speedup learning (ID3 on rule intersections) → parallel partner co-training → convention invention scored by Value of Information.

Extensions beyond the 2006 paper: stratified rare-state discovery, structural bidding diagnostics against native DDS par, a continuous-improvement flywheel with auto-generated patches and versioned persistence, single-dummy (SDS) scoring, and a strategy-fusion-correct card-play search core.

---

## 2. Architecture map

```
                    ┌────────────────────────────────────────────┐
                    │            improvement flywheel             │
                    │  flaws → patches → paired confirm → save    │
                    └───────▲────────────────────────▲───────────┘
                            │                        │
     ┌──────────────────────┴─────────┐   ┌──────────┴────────────┐
     │        evaluation harness      │   │  diagnostics engine   │
     │  eval_vs_dds.py (--sds dual)   │   │ ParDiagnosticEngine   │
     │  arena.py tournaments          │   │ structural-first      │
     └──────────────┬─────────────────┘   └──────────┬────────────┘
                    │                                │
     ┌──────────────▼────────────────────────────────▼────────────┐
     │                   bidding / play engines                   │
     │  DecisionNet (rules+ID3) → PIDM (RBMBMC + lookahead)       │
     │  SDSScorer (two-hand contract scoring)                     │
     │  PlaySearcher (PIMC M=1 / αμ M≥2 card-play search)         │
     └──────────────┬─────────────────────────────────────────────┘
                    │
     ┌──────────────▼──────────────┐   ┌────────────────────────────┐
     │  native DDS (dds3 binding)  │   │ domain models / features   │
     │  dd tables · par · leaves   │   │ models · features · scoring│
     └─────────────────────────────┘   └────────────────────────────┘
```

---

## 3. Implemented & verified

Test suite: **256 tests green, 3 skipped** (1 `expectedFailure` = tracked
deep-M issue, §6). Run with `.venv/bin/python -m unittest discover -s tests`
(~170 s). The web engine is checked separately and outside Python:
`node tests/web/engine_test.mjs` (387 checks) and `node tests/web/id3_dsl_test.mjs`
(12 Python/JS parity checks).

| Layer | Module(s) | Status |
| --- | --- | --- |
| Domain models, 250+ bridge features, duplicate/IMP scoring | `models.py` `features.py` `scoring.py` | stable |
| Native DDS: double-dummy tables (20 strains×declarers), par | `dds.py` via BEN's libdds (`CalcDDtablePBN`, `Par`) | stable |
| Native DDS: mid-play leaf solving | `dds.py` via dds3 `SolverContext.solve_board_pbn` | new, verified |
| RBMBMC auction-consistent world sampling | `sampling.py` | stable |
| PIDM bidding search (sample → nested model rollout → DD leaf) | `pidm.py` | stable; rollout-to-terminal fix landed (see §5) |
| DecisionNet selection strategy φ(s), legality filter, ID3 intersection refinements | `decision_net.py` `learner.py` | stable |
| Partner co-training loop | `cotrain.py` | stable |
| Stratified deal generation, experience buffer, exploration | `experience.py` | stable |
| Convention synthesis + VOI evaluator | `protocol.py` | stable |
| Traditional rule engine + DSL translator + system corpus (BlueClub, Precision, GIB, SAYC, cuebid library) | `engine.py` `system.py` `translator.py` `system/` | stable |
| Structural par diagnostics (flaw taxonomy below) + corrective-rule synthesis | `diagnostics.py` | upgraded this cycle |
| Tournament arena + head-to-head comparisons | `arena.py` | stable |
| Evaluation harness vs native DDS par, seeded/paired protocol | `eval_vs_dds.py` | stable |
| **SDS two-hand contract scoring** (PIMC over sampled opponent layouts) | `sds.py::SDSScorer` | new, verified |
| **True play search**: trick mechanics, `OutcomeVector`, PIMC (M=1), αμ M≥2 with fusion-forbidden Max commitments | `sds.py::PlaySearcher` | experimental (§6) |
| Flywheel: auto-generated patch pools, paired hill-climb, validation gates, state cache, versioned history | `flywheel.py` (+ `improve_*.py` lineage) | stable |

### 3.1 Diagnostics flaw taxonomy

Structural checks run **before** any score comparison, so lucky results cannot mask bad auctions:

`OPTIMAL_PAR` · `MISSED_SLAM` · `MISSED_GAME` · `SOFT_DEFENSE` · `OVERBID_DOWN` · `TAKEOUT_PASS` (passed partner's takeout double holding 10+) · `LUCKY_MASKED_MISS` · `MISSED_PENALTY_DOUBLE`.

Each family feeds `generate_corrective_rules_for_diagnostics`, closing the loop back into the flywheel.

### 3.2 Bidding system lineage (table current to v11; file is at v28)

> **This table is stale.** `system/improved_system.dsl` is now
> `ImprovedSystem_v28`, and §6.9 below references v19, but the lineage log
> stops at v11 — v12 through v28 were never written up. The intervening
> history is only recoverable from the version archive. Treat the table as a
> record of the early, well-documented progression, not as a complete lineage.

Verified progression on seeded deal sets, all patches accepted only after paired cross-validation:

| Version | Change | Measured effect |
| --- | --- | --- |
| v2 | removed always-firing synthesized "junk" rules | +27 to +52 pts/board |
| v3 | gated contextless 3NT and direct games | −16 → −4.5 regret vs par |
| v4 | isolated + gated the four contextless raise/game rules | +34.6 avg; Boards 21/22 flipped to optimal |
| v5 | shaped takeout doubles, forcing raises (flywheel round) | +20.9 train, +10.1 val |
| v7–v8 | advancer rules over takeout X; sound raise gates (partner-context required) | Board 1 sanity restored; EV cost accepted as policy |
| v9 | slam ladder (strong 6-card rebid → fit drive → 6NT drive) | MISSED_SLAM 17→10; verification case 4S=+450 → 6NT=+1020 |
| v10–v11 | Blackwood ace ask + king ask (RKCB-style verification ladders) | EV-neutral, capability-completing; grand slams now reachable *verified* |

---

## 4. Key empirical findings

1. **DD-par flaw labels ≠ expected value.** Three independent episodes showed "obviously buggy" aggressive rules were EV-positive in self-play, while "obvious" discipline gates lost points. All acceptance decisions therefore run through paired, seeded, within-process confirmation across ≥3 disjoint deal sets.
2. **Perfect-information scoring flatters luck.** Under SDS two-hand scoring the repo's aggressive system drops ≈21 pts/board while conservative archetypes hold steady — contracts that need omniscient declarer play no longer earn full credit. See [`sds-explained.md`](sds-explained.md) §6.
3. **The dead-search bug class is real.** The original lookahead evaluated non-terminal states as literal 0.0, making every multi-candidate decision an arbitrary tie-break. Post-fix, values are real DDS-backed expectations.
4. **Cross-process noise exists** (set-iteration tie-breaks under hash randomization). Protocol: never compare numbers across processes; use within-process paired deltas, or fix `PYTHONHASHSEED`.
5. **Self-play defense is structurally weak** (both sides share one system): penalty doubles print money against mirror-pathologies, so SOFT_DEFENSE/OVERBID_DOWN counts must be read with care.

---

## 5. Notable bugs fixed (patterns worth remembering)

| Bug | Root cause | Fix / guardrail |
| --- | --- | --- |
| All-zero lookahead values | `evaluate_terminal_deal` returned 0.0 for non-terminal states at depth cap | greedy rollout-to-terminal then DD-eval (`pidm.py`) |
| Junk conventions firing everywhere | pipeline-synthesized ENCODE/TRANSFER rules without auction conditions | DROP scan in flywheel; gating generator |
| Contextless raises/games | pipeline rules lost `partner_last_call` guards | auto-gate variants + isolation testing before adoption |
| Suit-order scrambling in PBN | repo enums are alphabetical (C,D,H,S); DDS expects S,H,D,C | explicit order mapping in `_cards_to_pbn_suits` and current-trick arrays (`3 - value`) |
| Cross-world TT pollution (-13 errors) | shared SolverContext transposition table across deals | `mode=2` (clear per solve) per sds.md K6 |
| Phantom 0-trick leaves | `_leaf` invoked on exhausted positions | empty-hands shortcut returning accumulated tricks |

---

## 6. Known issues / experimental status

1. **Deep-M αμ accounting** (`PlaySearcher`, tracked as `expectedFailure` in `tests/test_play_search.py::test_full_depth_single_world_equals_dd`): at M beyond ~remaining tricks, values diverge from native DD because `_finish_trick` grants an uncounted Max commitment at the M-exhaustion boundary. Verified correct for **M ≤ remaining tricks**, which covers the theoretically clean regime. TODO: implement paper-exact `stop()` semantics (Algorithm 3) so M counts every Max node including in-flight tricks.
2. **Strategy fusion analog in bidding rollouts**: PIDM rollouts let each seat act per world. Bounded by shallow depth + shared deterministic models; revisit if rollouts deepen. Full discussion: [`sds-explained.md`](sds-explained.md).
3. ~~champion_system.dsl double-counts~~ — RESOLVED at harness level: `eval_vs_dds` signature-compares the snapshot against archetypes and skips identical entries (logged); the file remains as a historical artifact.
4. **Exported DSL loses ID3 refinements**: `export_dsl` skips classifiers without `.root`; measured impact ≈0 today but blocks faithful round-trip.
5. ~~Uniform SDS worlds ignore the auction~~ — RESOLVED: `SDSScorer(condition_factor=k)` generates a k× pool and keeps the num_worlds layouts least inconsistent with the played auction (elite selection via `calculate_inconsistency` with the system's own models). Wired through `eval_vs_dds --sds --sds-condition`; test `test_conditioned_sampling_prefers_consistent_worlds` proves West's 1S-overcall holding survives conditioning vs uniform.

---

## 6.5 Autonomous loop (`autoloop.py`) — NEW

Long-running driver implementing the agreed policy:
- **Staged funnel, start small**: candidates screen on the smallest tier; escalation to bigger boards happens only when the paired result is statistically inconclusive (`|z| < 2`). 1000-board tier is reachable via `--tiers 24,96,384,1000`.
- **Significance-gated acceptance**: accept requires strictly positive mean delta AND z ≥ 2 (sign guard rejects constant-zero patches that produce |z|=∞).
- **Automatic champion promotion**: accepted versions challenge the incumbent champion head-to-head over both seat orientations at ≥64 boards; a win (positive IMPs, z ≥ 2) auto-replaces `champion_system.dsl` (old archived to `system/history/champion_v*.dsl`).
- **Checkpoints & progress**: report + rolling JSON snapshot (`debug/autoloop_progress.json`, gitignored) every `--progress-secs` (default 300s) and on every major event.
- State/cache shared with flywheel (`flywheel_state.json`: failed-signature cache, version counter, applied log).
- Session log (latest): screened 17, applied `LOOSEN_NO_C_WITH_MAJOR_HEA` (+58.7 @t96, z-gated) -> v20; **SDS save-gate rejected 2 DD-lucky patches** (`LOOSEN_R_1S`, `LOOSEN_NO_D_WITH_MAJOR_HEA`) — gate working as designed. Champion (SUP snapshot) held on head-to-head (-146 imps, z=-1.5): evolved line still trails solid archetypes directly, consistent with §4 finding 2.

### 6.7 Solver silent-failure masking + true diagnosis of reported "missed game" board

**Fixed (permanent)**: `CalcDDtablePBN` failures were silently masked by
`get_tricks`' hardcoded default of 7 — a broken table looked like "down exactly
nothing" or similar nonsense. Now: loud stderr on failure + exact per-contract
fallback via dds3 (`_exact_fallback_table`) + never return magic defaults.
Two independent code paths (ctypes table / dds3 boards) now cross-validate.

**Board diagnosis corrected** (user-reported ♠QJ9652 ♥A ♦KT3 ♣Q96 opposite
♠A3 ♥JT ♦AQ875): dual-solver consensus = NS make **11 tricks in NT**, 7 in
spades. Optimal = 3NT/6NT by N-S. System's failure is NOT "didn't raise
spades" (4♠ is down 3!) — it lacks an **NT-detection path after a minor
opening with a misfit-major responder** (responder's ♦AQ875 + stopperless
hand wants 3NT, not a major race). Logged as next design item rather than
patched blind: candidate = responder 3NT rule over partner's minor opening
when holding 11+ HCP, unbalanced-but-notrump-playable (requires stopper
feature check — `*_stopper` features exist).

Lineage decision: reverted improved_system.dsl to v15 archive (v16's 4♠
attempt scored worse than the passed-out baseline on this board); v16 kept
in history for reference.

### 6.6 Vulnerability awareness — investigated, negative result (kept honest)

**Discovery**: the deal generator never varied vulnerability (`Deal.random_deal` defaults
to NONE) — every prior evaluation ran non-vulnerable only. Fixed: `build_deals(vuln_mode="random")`
now rotates all four cells; new `convention_lab vuln-cells` shows per-cell regret
(unfavorable cell was −158/board, favorable −98 — real pain).

**Three policy variants tested** (paired, seeds 42/7/13 × 64 boards):
| Variant | Result |
| --- | --- |
| Light favorable overcalls (hcp≥7) + discipline | **−12.5 avg, 0/3** (light entries backfired −91→−108) |
| Unfavorable discipline only (red seats need 11+) | **−3.0 avg, 0/3** (neutral) |

**Conclusion**: with *symmetric* self-play opponents, vuln-gating competitive calls is
EV-neutral-to-negative — the mirror system adapts identically, so effects cancel.
Asymmetric value requires heterogeneous opposition (league play, roadmap §7). The
harness vuln fix stands regardless; PIDM's DD leaf scoring was already vuln-aware,
so no engine change was needed.

### 6.9 Core-guard rot + response-side coverage holes — RESOLVED (v19)

Two reported cases, one combined fix (`improve_softresp.py`, saved as v19):

| Case | Symptom | Root cause | Fix |
| --- | --- | --- | --- |
| 19 HCP balanced w/ 5-card minor **passed out** | every opening rule missed | `is_balanced` counts 5-card minors as balanced; rules covered only 12–14 bal / 15–17 NT / unbalanced | `R_1C/D_STRONG_BAL` (15+ bal → longer minor) + `R_2NT_2021` |
| Board 35: 13 HCP + 6-card clubs silent | no competitive/response rule for minors existed at all | response-side coverage hole (minor overcalls/responses never authored) | `MC_OVERCALL_2m` (11+, 6-card), `MC_RESP_2m_OVER_1M` (10+, 5-card), `MC_REBID_3m` ladder |
| (root rot) opponents "opening" our hands | all `is_opening` guards stripped by historical patch cycles | guard-loss during repeated rule replacements | `stage_repair` re-inserts guards idempotently |

**Verification**: reported 19-HCP board now opens 1C and drives to 6NT (DD-consistent:
12 tricks available); board 35 South actively competes to game level.

**Honest cost**: paired deltas −57.0/−2.9/−8.3 (avg −22.7, accepted via
verification-case override per project policy — coverage completeness outranks
short-term EV here; the autoloop will police regressions on future cycles).
Watch seed 42 specifically next cycles.

### 6.10 CoT-Bidder prototype — NEW (P0 complete)

LLM-style explainability for the neural path, per `research/cot-bidder.md`:
- **Trace factory** (`trace_factory.py`): 208 invariant-checked
  `(position → explanation → bid)` triples from self-play (24 boards). Constraints are factory-guaranteed to hold on true features; corpus invariants re-verified by tests.
- **Training data is tracked**: `data/traces/traces.jsonl` + provenance manifest
  (`traces.meta.json`: schema version, seed, boards, n_traces, dsl & corpus sha256)
  committed to git. Tests verify hash/count on every run; regeneration is
  deterministic for a given (seed, dsl-hash, code). Policy: track corpora ≤ ~5 MB;
  larger ones store manifest-only and archive elsewhere.
- **Constrained-decode reasoner** (`cot_bidder.py`, P0 retrieval back-end):
  nearest-neighbour transfer of constraint sentences, verified against real features + auction legality before playing. **0 legality violations, 0 hallucinated constraints** (verifier-gated); 89.3% call-level agreement with DecisionNet, 13/16 boards identical.
- Demo: Board 1 replays the full ace→king verification ladder with per-call constraint sentences (`BW_RESP_H: ace_count==2` …).
- Interface is final for P1/P2: swap retrieval for a small seq2seq trained on this corpus (supervised now, DD-oracle process refinement later). Truncated-PIMC caveat does not apply (bidding leaves never call mid-trick).
- **P1 TRAINED & VALIDATED**: `.venv` (py3.12 + torch 2.2.2) → corpus scaled to
  1,635 traces / 91k tokens / vocab 1,458 (200 boards, sha256-manifested) →
  tier-S model (6×256 ≈ 5M params) trained 40 epochs (loss 0.32).
  Val results: exact CoT sequence match 55.2%, final-BID accuracy 70.6%,
  0 legality violations (verifier-gated decode), deterministic.
  Training curve shows underfitting → next lever: more boards (trace_factory
  scales linearly), then M-tier (19M) if plateau.

### 6.11 Panel evaluation — negative result (kept honest)

Added `--metric mean_imp_loss` and `--panel` to `eval_vs_dds` / `flywheel.py`
plus a both-seat `evaluate_panel()`. Hypothesis under test: the flat anchor
ledger was caused by self-play, because a system bidding against a copy of
itself converges to a fixed point rather than to bidding strength.

**The hypothesis is not supported.** The panel does not reverse the ranking,
it amplifies it (16 deals, panel = SAYC / Precision / 2-1 GF, both seats):

| System | self-play regret | panel h2h | panel IMP loss/bd |
| --- | --- | --- | --- |
| champion_system.dsl | +53.8 | **+85.8** | 6.11 |
| improved_system.dsl | +8.8 | +15.0 | 7.74 |

Direct head-to-head over both seat orientations (24 deals): `improved_system`
loses to `champion_system` by **~72 pts/board** (−70.4 vs +73.5; the ~3 pt
asymmetry between the two independent runs is the noise floor).

**Root cause is not the mirror, it is the starting point.** `champion_system.dsl`
is the hand-authored SUP (Singularity Ultra Precision) archetype from
`optimizer.py` — 90 rules, `SUP_*` ids, **zero rule-id overlap** with
`improved_system.dsl` (75 rules, `R_*`/`FW_*`/`SLAM_*` ids). They are disjoint
rule sets, not two versions of one lineage. The flywheel has spent 28 versions
hill-climbing a system that began ~72 pts/board weaker, using a patch
vocabulary (numeric `tighten`/`loosen`, gating variants, curated families)
that cannot close a structural gap of that size. `champion_swaps: 0,
champion_holds: 8` is therefore not a gate bug — the evolved line is genuinely
behind.

Actionable sub-finding: on the panel `improved_system` **loses to 2/1 GF
(−5.9)** while `champion_system` beats it (+65.3). That is a specific
competitive-auction hole worth a curated patch family.

The panel/IMP switches still land (they are cheaper and lower-variance than
raw regret) but they are hygiene, not the fix.

### 6.12 Patchability of each base system — and why neither gain transfers

Screened the full generated pool (16 train deals, panel on, `--metric
mean_imp_loss`, ID3 family included) against both candidate starting points:

| base system | baseline IMP loss/bd | pool size | patches clearing floor | best patch (train) | val 7 | val 13 |
| --- | --- | --- | --- | --- | --- | --- |
| improved_system.dsl (78 rules) | 7.409 | 10 | 1/10 | ID3 **+0.364** | −0.000 | −0.000 |
| champion_system.dsl (90 rules) | 6.364 | 10 | 1/10 | TIGHTEN_SUP_1H_LIM **+0.136** | −0.000 | −0.000 |

Three things fall out:

1. **Champion starts 1.045 IMP/board ahead and is no harder to patch.** The
   generic operators work fine on the `SUP_*` namespace (the pool built
   `TIGHTEN_SUP_*` variants without trouble), so the flywheel's curated
   families being keyed to improved_system's rule ids is not a blocker.
   Reseeding is supported — it is a pure starting-point gain.
2. **Most patches move nothing at all.** Every `GATE_*` and `DROP_*` variant
   scored exactly ±0.000: on 16 deals those rules are never exercised. The
   pool is mostly inert, which is a second reason the version counter can
   advance without the anchor ledger moving.
3. **Neither "gain" transfers.** Both val seeds came back at exactly −0.000,
   which is the signature of a train-only artefact rather than a real
   improvement. At 16–24 deals the screening budget cannot resolve the size of
   delta this patch vocabulary produces. The effect floor (0.03 IMP/bd) is
   below the noise floor.

Conclusion: reseeding is worth doing, but the binding constraint is
**evaluation budget**, not patch vocabulary. ID3 was the only family that
moved improved_system at all (+0.364 vs −0.000 for everything structural),
which is consistent with §6.11 — the structural families cannot invent
anything, and ID3 can.

### 6.13 The 16-deal "gains" were noise — confirmed at 96 deals

Re-ran the §6.12 screen at 96 deals (+6 stratified), panel on,
`--metric mean_imp_loss`, `--jobs 8`, ID3 family included:

| base system | baseline IMP loss/bd | patches clearing floor | best candidate |
| --- | --- | --- | --- |
| improved_system.dsl | 6.804 | **0/8** | −0.000 |
| champion_system.dsl | 5.735 | **0/8** | −0.020 (TIGHTEN_SUP_1H_LIM) |

**Nothing clears the floor on either system.** The two patches that looked like
gains at 16 deals (ID3 +0.364, TIGHTEN_SUP_1H_LIM +0.136) do not reproduce;
`TIGHTEN_SUP_1H_LIM` is actually −0.020 at 96 deals. Both had already failed to
transfer to the validation seeds, so this was the expected outcome — now
measured rather than inferred. The 16-deal deltas were noise, and the effect
floor (0.03 IMP/bd) is below that noise floor.

**The champion gap is real.** ~~1.069 IMP/board at 96 deals versus 1.045 at 16
deals — two independent estimates agreeing~~ — **this was wrong, and §6.17
explains why**: both figures came from seed 42 / the training seed family,
which §6.17 shows is the most favourable of the seeds tested. The 2,054-board
measurement in §6.18 puts the gap at **+0.275 ± 0.084 IMP/board**. The
direction was right and the recommendation stands; the magnitude quoted here
was inflated roughly 4x by seed selection. Reseeding is a genuine gain, just a
considerably smaller one than this paragraph claimed.

**But reseeding alone does not reopen the loop.** With the threshold/gating/drop
families producing nothing measurable at 96 deals on either base, the
vocabulary is effectively exhausted. Further improvement needs a family that
invents structure — i.e. ID3 with far more labeled states than the current
~20 — or new curated families written by hand. This is the same conclusion as
§6.11/§6.12, now with a sample large enough to trust.

Caveat: this run used the rotating panel (`opponent_panel=`) rather than
`evaluate_panel`'s both-seats protocol, so it is not directly comparable to the
§6.11 ID3 head-to-head measurement (+10.3 pts/bd, 24 deals). That ID3 gain has
**not** been confirmed at scale and should be re-measured at 96+ deals before
being relied on.

### 6.14 ID3 at scale: the +10.3 head-to-head does not survive (96 deals)

§6.13 left one hypothesis standing: the ID3 gain was real but starved of data,
because `harvest_ambiguous_states` only ever produced *opening* hands with
`history=[]`. Fixed and re-measured at 96 deals, 60 harvested states, jobs=8,
both bases, train plus two held-out validation seeds.

The sampler fix worked as intended — states are now mostly mid-auction:

| base | harvested | mid-auction | opening | patches |
| --- | --- | --- | --- | --- |
| improved | 60 | 33 | 27 | 1 |
| champion | 47 | 40 | 7 | 1 |

The result did not:

| base | baseline | +ID3 | train Δ | val seed 1 | val seed 2 | verdict |
| --- | --- | --- | --- | --- | --- | --- |
| improved | 6.804 | 6.873 | −0.069 | −0.098 | +0.176 | does not transfer |
| champion | 5.735 | 5.824 | −0.088 | −0.196 | +0.029 | does not transfer |

(Lower is better; Δ in IMP/board.) Both bases get **worse** on train, and the
validation seeds disagree in sign — the signature of noise, not of a patch that
generalises. So the §6.11 +10.3 pts/board is retracted: it was a 24-board
artifact of a protocol (`evaluate_panel`, both seats, seed 7) that never
reproduced. **ID3 is not the lever that reopens the loop.**

Two things are worth separating here:

1. **The plumbing fix was real and is kept.** Trees now survive save→load
   (§6.11's `TREE:` serialization), states carry auction history, and
   `min_examples=3` stops fitting a leaf that memorises one board. The
   machinery works; it just has nothing to learn from.
2. **Why it has nothing to learn from.** 60 states across 96 deals collapsing
   to **1 patch** is the finding. An intersection that is visited often enough
   to be worth refining is, in a hand-authored system, already disambiguated by
   hand. What is left is a long tail of intersections seen once or twice —
   exactly what `min_examples=3` now correctly refuses to fit. The teacher is
   not the bottleneck; the *distribution of ambiguities* is. ID3 needs a
   vocabulary broad enough to generate ambiguity in the first place, which
   circles back to the §6.13 conclusion: new curated families, or a
   representation that invents structure rather than splitting on 250 fixed
   features.

This closes the last open hypothesis from §6.11–6.13. The loop is not stalled
on sampling, thresholds, or teacher cost. It is stalled on the candidate
vocabulary, which is a hand-authoring problem.

### 6.15 `improved_system.dsl` shipped three self-contradicting rules

The linter reported "rule id reused with different bodies" as a *warning* —
warnings do not fail the lint, so `test_improved_system_lint_clean` passed on a
file that was not clean. The three cases are not a benign variant family:

```
RULE NO_C_WITH_MAJOR_SPA:      RULE NO_C_WITH_MAJOR_SPA:
  CALL: 1C                       CALL: 1C
  PRIORITY: 30                   PRIORITY: 30
  NEGATIVE: True                 (no NEGATIVE line)
  CONDITION: is_opening == True  CONDITION: is_opening == True
  CONDITION: spade_len >= 5      CONDITION: spade_len >= 5
```

Same id, same call, same guard, same priority — one vetoes 1C, the other adds
it. Same for `NO_D_WITH_MAJOR_HEA` and `FW_NO_2_TRUMP_RAISE`. Almost certainly
a patch that re-emitted an existing `rule_id` without carrying `NEGATIVE`
forward.

**Measured impact: zero.** Removing the three positive twins leaves the score
bit-identical — train 6.804 → 6.804, val 7.216 → 7.216 and 7.343 → 7.343
(96 deals, 3 seeds). The reason is `DecisionNet.get_candidates`: negative
rules are an *unconditional* veto (`c not in negative_calls`, applied after
`rule_priority` and independent of priority), so the positive twin can never
win and is dead code. Rule count 78 → 75.

So this is not a hidden source of the champion gap — but it was a live
landmine. It is harmless only because of one specific line's semantics:
- make negative rules priority-ordered, and the three start firing;
- the positive twin still appends to `matched_rule_ids`, so it perturbs
  intersection keys, which is exactly the path ID3 refines (§6.14) — one
  reason `build_id3_patches` skips intersections with ambiguous ids.

Fixed: the three twins are deleted (behaviour-neutral, verified above) and
`lint_rules` now classifies same-id + same-guard + opposite-polarity as a
**hard issue** rather than a warning, so this fails the lint immediately.
Distinct guards with the same polarity remain a warning — negative-rule
families are legitimate and must stay lintable. Regression tests in
`tests/test_lint_dsl.py` cover both directions. All six `system/*.dsl` files
now lint clean with exit 0.

### 6.16 Calibration: the screen cannot resolve the changes it is judging

§6.13 concluded the threshold/drop families "produce nothing measurable", and
§6.14 concluded ID3 does not transfer. This section asks the prior question:
**could the screen have detected anything, even in principle?**

The same system scored on independent 96-deal sets does not return the same
number. Five sets (seeds 11/22/33/44/55), 96 deals each, fixed opponent panel,
`mean_imp_loss`:

| system | seed 11 | 22 | 33 | 44 | 55 | mean | sd | range |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| champion | 6.529 | 6.735 | 6.971 | 6.118 | 6.490 | 6.569 | 0.316 | 0.853 |
| improved | 7.304 | 7.618 | 6.843 | 6.480 | 7.167 | 7.082 | 0.437 | 1.137 |

A single 96-deal measurement therefore carries a **±0.62 to ±0.86** 95%
interval. Paired on the same deal sets the champion/improved difference is
+0.529 ± 0.189 (sem), t = 2.81 on 4 df — significant, but only just, and one
of the five sets (seed 33) has improved *ahead* by 0.127.

Two consequences, and they need separating:

1. **`MIN_DELTA_BY_METRIC['mean_imp_loss'] = 0.03` is ~20x below the noise.**
   It is a *train-set effect size* floor, not a significance threshold — on the
   fixed training set the baseline/candidate comparison is paired and exact, so
   0.03 asks "is this change worth bothering with". It says nothing about
   generalisation and must not be read as evidence.

2. **The validation gate is one-sided and underpowered.**
   `validate_and_save` accepts when `d > -tol` on each of `VAL_SEEDS = (7, 13)`
   — i.e. it rejects a clear regression but *accepts anything neutral,
   including a no-op*. With two seeds the minimum detectable effect is
   `1.96 x 0.42 / sqrt(2) = 0.58` IMP/board, so no patch smaller than that can
   be confirmed either way. Resolving the 0.03 floor would need **hundreds** of
   96-deal sets.

That is the mechanism behind the headline failure. `improved_system.dsl` is at
v28 — twenty-eight rounds of patches that each passed a gate which cannot
reject noise. A gate that accepts no-ops will random-walk, and a walk with a
downward drift in rule quality ends up worse than where it started, which is
exactly the gap versus champion (§6.18: +0.275 ± 0.084). The loop did not fail to find
improvements; **it was never able to tell whether it had found one.**

This reframes §6.13/§6.14: their "no measurable gain" results are not evidence
that the families are worthless. They are equally consistent with the families
producing real gains of ~0.05–0.3 that the screen is simply too coarse to see.
The honest statement is *unresolved*, not *refuted*.

Changes made:
- `eval_vs_dds.SCREENING_NOISE_SD` records the measured sd with provenance;
  `min_detectable_effect(n, metric)` returns the smallest gain n sets can
  resolve, and `inf` for any metric we have not calibrated (so an unmeasured
  metric never looks resolvable).
- `validate_and_save` now prints a WARNING when the mean validation gain is
  below that resolution, instead of logging a noise-level round identically to
  a validated one.
- `tests/test_screening_resolution.py` covers both.

### 6.17 Per-board pairing: measured, and it buys less than hoped

`evaluate_system` now returns per-board `imp_losses`, so two systems scored on
the same boards can be compared board-by-board instead of mean-to-mean. That
should have helped: the board-to-board variation (which deals happen to be slam
hands) is shared and ought to cancel.

It mostly does not. Paired champion vs improved, 96 boards, three seeds
(positive = champion better):

| seed | champion | improved | paired diff | se | 95% CI | t | per-board sd |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 42 | 5.735 | 6.804 | +1.069 | 0.408 | [+0.269, +1.868] | +2.62 | 3.99 |
| 7 | 6.804 | 7.216 | +0.412 | 0.317 | [−0.210, +1.034] | +1.30 | 3.20 |
| 13 | 6.686 | 7.343 | +0.657 | 0.356 | [−0.040, +1.354] | +1.85 | 3.59 |

Per-board sd of the *difference* is ~4.0, versus ~3.1–4.3 for the metric
itself — **the two systems' losses are only weakly correlated, because they go
wrong on largely different boards.** So pairing buys little over comparing
means, and the budget is set almost entirely by board count:
`se = 4.0 / sqrt(n_boards)`.

This also cross-checks §6.16: 4.0/√96 = 0.41 (the paired se above) and
4.0/√480 = 0.18, matching the 0.189 sem from the five-set run. The two
independent methods agree.

**Board budget required** (`boards_needed`, 95%, sd 4.0):

| to resolve | boards |
| --- | --- |
| 0.5 IMP/bd | 246 |
| 0.3 | 683 |
| 0.1 | 6,147 |
| 0.05 | 24,587 |
| 0.03 (the current floor) | 68,296 |

At ~0.29 s/board with `--jobs 8`, **~6,000 boards costs about 30 minutes** —
so resolving 0.1 IMP/board is genuinely affordable, and the 96-deal default
(resolving ~0.8) is not a budget constraint, it is just 60x too small.

Two corrections this forces:

- **Seed 42 is the most favourable of the three** (+1.069 vs +0.412/+0.657).
  It is `TRAIN_SEED`, so the ~1.07 champion gap quoted earlier was measured on
  the seed the flywheel trains on — a selection artifact. Direction is
  consistent (all three seeds favour champion, as did 4 of the 5 sets in
  §6.16), but the magnitude is 0.4–1.1, not a clean 1.07.
- **Only seed 42 is individually significant**; 7 and 13 are not. Pooling is
  what makes the gap credible, not any single run.

Changes: `imp_losses` per board on both the serial and parallel paths;
`paired_imp_test()` and `boards_needed()` in `eval_vs_dds.py`; the hill-climb
now prints each candidate's paired diff, 95% half-width, t, and the board count
needed to resolve it, so a patch that only looks good on 96 boards says so.

### 6.18 The definitive gap: +0.275 ± 0.084 IMP/board (2,054 boards)

§6.17 gave se = 4.0/√n, so 2,048 boards buys se ≈ 0.088 — enough to separate
the 0.4 / 0.7 / 1.1 estimates that had accumulated. One run, seed 2024,
2,054 boards (2054 because `build_deals` rounds), fixed opponent panel:

```
champion 6.3895   improved 6.6641
gap (champion better by)  +0.2746 IMP/board
se 0.0843   95% CI [+0.1094, +0.4398]
t +3.26     per-board sd 3.820
significant at 95%: yes
boards that would have sufficed: 743
```

**The gap is +0.275 ± 0.084 IMP/board.** Significant (t = 3.26), but roughly
**a quarter** of the 1.069 that §6.13 quoted. That earlier figure was a seed-42
artifact — §6.17 shows seed 42 is the most favourable of the three seeds
tested, and it is `TRAIN_SEED`, so it was also the seed the loop trains on.

Consistency check with the earlier estimates, all of which are unbiased but
noisy samples of this same quantity:

| estimate | boards | gap | se |
| --- | --- | --- | --- |
| §6.13 seed 42 | 96 | +1.069 | 0.408 |
| §6.16 five sets | 480 | +0.529 | 0.189 |
| §6.17 three seeds | 288 | +0.713 | 0.236 |
| **§6.18 this run** | **2,054** | **+0.275** | **0.084** |

The 480-board and 2,054-board estimates differ by 0.254 with a combined se of
0.207 — 1.2 se, well inside noise. Everything is consistent with a true gap of
roughly 0.2–0.4 IMP/board; the small-sample estimates were simply too imprecise
to land there.

Calibration validated: measured per-board sd **3.82** against the
`BOARD_IMP_LOSS_SD = 4.0` constant, so the budget table in §6.17 is mildly
conservative (it over-provisions boards by ~9%). Left at 4.0 deliberately:
rounding the budget up is the safe direction, and `boards_needed` accepts an
`sd` override when a run has measured its own.

**The punchline.** The gap the flywheel needed to see — 0.275 IMP/board — is
*smaller than what its own 96-board screen can resolve* (0.8). The tool could
not distinguish the system it was producing from the system it should have been
producing. That is not a bug in the patch families or in ID3; it is the screen
being too coarse for the size of the effect, and it is fixed by a configuration
change (more boards), not by new algorithms.

**What this implies for the roadmap:** buying resolution is a prerequisite for
any of §6.13/§6.14 to be answerable, and it is a throughput problem, not an
algorithmic one. `--jobs` is only 2.2x (§6.11), so an order of magnitude more
boards needs either a much cheaper evaluation (variance reduction: paired
deals, common random numbers, more boards per worker) or abandoning
train/val screening in favour of direct head-to-head against a fixed reference
system over many boards.

### 6.19 Curated families at 806 boards: not noise — they are genuinely inert

§6.16/§6.18 left the §6.13 conclusion ("the families produce nothing
measurable") as *unresolved*, since a 96-board screen resolves only 0.8
IMP/board. This re-tests the seven curated families on **champion_system.dsl**
(the recommended reseed base) at **806 boards**, where resolution is 0.276.
Seed 2024 — deliberately not 42, given §6.18.

| family | rules | IMP/bd | diff | se | 95% CI | t |
| --- | --- | --- | --- | --- | --- | --- |
| SUPPORT | +4 | 6.4268 | +0.0310 | 0.030 | [−0.028, +0.090] | +1.03 |
| FORCE_RAISE_2NT | +4 | 6.4305 | +0.0273 | 0.079 | [−0.127, +0.182] | +0.35 |
| AGGRESSION | +4 | 6.4342 | +0.0236 | 0.019 | [−0.014, +0.061] | +1.24 |
| TKO_SHAPE | +2 | 6.4479 | +0.0099 | 0.023 | [−0.035, +0.055] | +0.43 |
| BALANCING | +2 | 6.4578 | **+0.0000** | 0.000 | [0, 0] | 0.00 |
| NT_SAFETY | +3 | 6.4578 | **+0.0000** | 0.000 | [0, 0] | 0.00 |
| OVERCALLS | +2 | 6.4578 | **+0.0000** | 0.000 | [0, 0] | 0.00 |

Baseline champion: 6.4578. **0 of 7 reach significance.** Three are not merely
small — they are *exactly* zero, scoring identically to baseline on every one
of 806 boards.

**So §6.13 was right, and now for a reason that has nothing to do with
noise.** The upper bounds are what matter: even the most favourable end of any
CI is +0.09 IMP/board. All seven families pooled could not account for the
0.275 champion gap.

#### Why: the flywheel patches a stage the search overrides

The obvious explanation — those guards never match — is **false**. Replaying
real auctions and counting only N/S seats (the candidate plays N/S; E/W is the
frozen panel):

| family | guard matched | matched with a call not already in φ(s) |
| --- | --- | --- |
| BALANCING | 51 | 46 |
| NT_SAFETY | 288 | 283 |
| OVERCALLS | 134 | 63 |
| SUPPORT | 253 | 215 |

The rules fire constantly, and usually propose a call the candidate set did not
already contain. Yet three of them never change a single outcome.

The reason is architectural. `BiddingArena.play_board` does not ask the net
for a bid; it calls `self.engine.decide(ps, models)` — PIDM — which takes
φ(s) from the DecisionNet and **searches over it to pick the argmax**. The
DecisionNet is a *candidate generator*, not a decision procedure.

So editing rules edits the candidate set, and that only changes behaviour when
it changes PIDM's argmax: the new call must actually be judged best, or a
vetoed call must have been the one PIDM was going to make. Mostly it is not.
Hand-authored rules are competing against a search that already explores the
same alternatives.

**This is a more fundamental explanation for the flywheel's failure than
screening noise.** Even with unlimited boards, patching candidate generation
has a small ceiling, because the search discards most of what the rules
propose. The two problems are independent and both are real: the screen cannot
*see* a 0.03 effect (§6.16), and the effect is ~0.03 *because* the search
overrides the rules (this section).

Implication for the roadmap: leverage is in the search — its objective, its
world model, the features it scores candidates on — or in rules derived from
what PIDM actually chooses, not in more hand-authored candidate rules.

Caveat: measured on champion, which is the recommended base. The families were
originally authored against `improved_system.dsl`'s diagnosed gaps, so they may
behave differently there; but champion is where the loop would actually run.

### 6.20 Strengthening the search does not help either

§6.19 recommended looking for leverage in the search. Tested, and **it does not
survive contact**: champion, 406 boards, seed 2024, paired.

| change | Δ IMP/bd | se | 95% CI | t | cost |
| --- | --- | --- | --- | --- | --- |
| sampling 2/6/0.06 → 4/12/0.25 | **−0.0296** | 0.082 | [−0.190, +0.131] | −0.36 | 1.7x slower |
| lookahead depth 1 → 2 | **+0.0000** | 0.000 | [0, 0] | 0.00 | none |

Neither is significant. Depth 2 returned *byte-identical* results in the *same*
wall-clock time (96 s vs 97 s) — the signature of a parameter that never takes
effect, not of a genuinely deeper search.

So the recommendation in §6.19 is **retracted**. It was an inference from
architecture, and the measurement does not support it. Both levers — rules
(+0.03, CI upper +0.09) and search (−0.03 to 0.00) — are indistinguishable from
zero at 400–800 boards.

### 6.21 Why: the search only runs on 7.2% of decisions

`PIDMEngine.decide` (pidm.py ~line 319):

```python
# Fast path: single candidate
if len(actions) == 1:
    single_action = next(iter(actions))
    return single_action, {single_action: 0.0}
```

One candidate means **no worlds sampled, no lookahead, no DDS** — the call is
returned straight from the DecisionNet. Measuring |φ(s)| at the N/S decision
points the candidate actually plays (E/W is the frozen panel), 406 boards:

| system | \|φ\|=1 | 2 | 3 | 4 | search runs |
| --- | --- | --- | --- | --- | --- |
| champion | **92.8%** | 6.7% | 0.4% | 0.1% | **7.2%** |
| improved | **87.1%** | 11.4% | 1.5% | 0.1% | **12.9%** |

Everything falls into place:

- **§6.20** — depth and sampling cannot matter much when the search runs on
  7.2% of decisions.
- **§6.19** — the "candidate generator, not a decision procedure" phrasing was
  wrong in emphasis and is corrected here: the DecisionNet *is* the decision
  procedure 92.8% of the time. Rule patches have small effects because most
  guards fire where the added call does not win, and because a patch that turns
  a singleton into a pair switches the search *on*, where it usually re-selects
  the original call.
- **§6.13/§6.14** — ID3 refines *intersections*, i.e. exactly the 7.2% where
  the search runs. Its entire addressable surface is ~1 decision in 14, which
  is a cleaner explanation for its starvation than data sparsity (§6.14).

A secondary observation, offered as a correlation and not a causal claim: the
stronger system is also the more *decisive* one (7.2% vs 12.9% ambiguity). If
ambiguity is a proxy for rules that fail to discriminate, it may be a cheap
diagnostic — worth checking against the wider leaderboard before trusting it.

**Implication.** The expensive part of this system (RBMBMC sampling, lookahead,
native DDS) is exercised on ~7% of decisions.

### 6.22 The ambiguous 7% is not where the value is

The open question from §6.21 was whether the ambiguous decisions are
disproportionately the expensive ones. They are not — if anything the reverse.
412 boards, champion, boards grouped by how many N/S decision points had
|φ(s)| ≥ 2:

| ambiguous N/S decisions | boards | share | mean IMP loss |
| --- | --- | --- | --- |
| 0 | 305 | 74.0% | 6.397 |
| 1 | 87 | 21.1% | 5.552 |
| 2 | 18 | 4.4% | 6.111 |
| 3 | 2 | 0.5% | 9.500 |

Boards containing at least one ambiguous decision account for **23.9% of all
IMP lost while being 26.0% of the boards** — slightly *under*-represented. They
score 0.677 IMP/board better than unambiguous boards.

So the 7% is not a hidden reservoir of value. Caveat: the grouping replays each
board following `actions[0]`, which approximates but does not exactly reproduce
the played auction, so per-group figures carry some leakage; the whole-set
paired numbers below do not.

### 6.23 Counterfactual: remove the search entirely — nothing happens

Two readings of §6.22 remained: the search helps where it runs, or those boards
are simply easier. Settled by ablation: a `NoSearchEngine` subclass that always
takes the fast path (no worlds, no lookahead, no DDS; deterministic
alphabetical pick among candidates), same boards, same panel.

| | IMP/board |
| --- | --- |
| with search | 6.2209 |
| **without search** | **6.2039** |

Paired over 412 boards: search is worth **−0.017 ± 0.013** (t = −1.30,
95% CI [−0.043, +0.009]). Not significant, and if anything negative. At 95%
confidence the search buys **at most +0.009 IMP/board**.

**The most sophisticated and most expensive component in the system — RBMBMC
world sampling, recursive lookahead, native double-dummy solving — contributes
nothing measurable to bidding strength.** It also runs on only 7.2% of
decisions (§6.21), which is consistent: something invoked that rarely and
worth that little is invisible in the score.

Caveat on the ablation: the no-search control picks the alphabetically-first
candidate, which is a crude policy, so this bounds the *current* search's
contribution rather than proving no possible search could help. It does say the
search as configured is not earning its cost.

### Synthesis

Every lever measured, paired, at 400–2,054 boards:

| lever | effect | 95% CI upper | verdict |
| --- | --- | --- | --- |
| curated rule families (7) | +0.03 best; 3 exactly 0 | +0.09 | no |
| stronger world sampling | −0.030 | +0.13 | no |
| deeper lookahead (1→2) | +0.000 | +0.000 | no-op |
| ID3 speedup learning | negative on train | — | no |
| **the search itself** | **−0.017** | **+0.009** | **no** |
| hand-authored champion vs 28 automated rounds | **+0.275** | +0.44 | **yes** |

The only thing that has moved this system is a human writing better rules. The
automated machinery's entire theory of improvement — generate candidates, let
search resolve them, hill-climb on the result — has no measurable leverage,
because (i) the rules decide 92.8% of calls outright, (ii) the search that
handles the rest is worth ~0, and (iii) patching candidate generation mostly
produces no change at all.

That is a structural conclusion about the approach, not a tuning problem.

**Addendum — §6.26 to §6.31, and the one number that matters most.** After the
table above was written, three things changed the picture:

1. **Every number above was measured with a metric that is not a loss**
   (§6.28). `mean_imp_loss` is `abs(deviation from double-dummy par)`; 54.9% of
   it is out-performing par, and half the boards are ones where par belongs to
   E/W and the job is to defend, not to bid. On the signed metric the
   champion→improved gap is **+1.267 ± 0.318 (t 7.81) at 836 boards**, where the
   abs metric gives a non-significant +0.071. Evaluations were also not
   reproducible at all until §6.26 (unseeded world sampler).
2. **The 28-round output does not beat a toy baseline** (§6.30). Head-to-head
   with each system playing both seats: champion beats SAYC by **+26.5**
   pts/board, `improved_system.dsl` **loses to SAYC by 37.7** — and SAYC is a
   10-rule skeleton that reaches game on 2% of boards.
3. **Where to author, priced** (§6.31): reaching the right **game** contract is
   worth −0.982 IMP/board against a **slam** prize of −0.426 — game is 2.3×
   bigger. Both are unreachable upper bounds, and §6.27 shows the reason they
   are hard to convert: the calls that fix missed contracts create overbids
   ~1:2.6.

4. **The most plausible remaining lever is now closed too** (§6.33). The
   coverage hole looked causal: every fallback pass on an underbid board is a
   genuine hole (§6.27). Filling it with `improved_system`'s aggressive
   judgement buys 17 games by adding 45 overbids (net −0.027); filling it with
   a conservative level-1 donor buys **zero** games and still adds 12 overbids
   (net **−0.098 ± 0.042, t −2.36**). ~209 interventions, 0 games, −0.39 IMP
   each. The hole is where *symptoms* appear, not where the cause is.

So: the approach needs a different theory of improvement, and it also needs a
metric that means something before any replacement can be judged. The metric
half is now fixed and cheap to adopt (`--metric mean_imp_diff`).

The causal half is now narrower than "write better rules": §6.25 shows champion
already stops at the 1–2 level on 67.3% of boards **with** its rules firing, and
§6.33 shows that inserting a call where no rule fires does not reach game either
— because the rest of the ladder still stops low. **What is missing is a bidding
ladder, not a candidate and not a patch.** Every lever in this table operates on
a single decision in isolation; reaching game requires a sequence. That is the
one structural thing no mechanism in this repo currently produces, and it is the
honest explanation for why 28 rounds of automated improvement added nothing.

### 6.24 Where a human should actually work: loss attribution

§6.23 leaves hand-authoring as the only lever, so the useful question is *where*
to author. Champion on 806 boards, seed 2024, mean **6.458 IMP/board**.

**The loss is broad, not a few disasters.** Only 12.4% of boards are at par;
median loss is 6.0. The worst decile of boards holds just **22.8%** of all IMP
lost (a uniform profile would give 10%), so there is no small set of
catastrophes to fix — it is a broad shortfall across ordinary boards.

`ParDiagnosticEngine` flags boards with regret worse than −10 points: 343 of
806. Attributing by `severity_pts`, which is in **points, not IMP** (converting
per-case figures with `score_to_imp` for readability):

| flaw | boards | attributed pts | share | pts/case | ≈IMP/case |
| --- | --- | --- | --- | --- | --- |
| MISSED_SLAM | 43 | 40,820 | **33.7%** | 949 | 14 |
| MISSED_GAME | 98 | 39,410 | **32.6%** | 402 | 9 |
| OVERBID_DOWN | 123 | 30,330 | 25.1% | 247 | 6 |
| SOFT_DEFENSE | 79 | 10,430 | 8.6% | 132 | 4 |

Shares are within attributed points — the only valid ratio, since the metric
totals are in different units. (An earlier draft of this table divided points by
IMP and produced shares above 100%; that was a units error, corrected here.)

Reading it: **MISSED_SLAM and MISSED_GAME together are 66% of attributed loss
from 41% of the flagged boards** — they are the expensive, less frequent
failures. OVERBID_DOWN is the most *frequent* (123 boards) but cheaper per case.
So:

- **Underbidding (missed slam + missed game) is the biggest bucket**, at ~66%.
  That is a coherent target for hand-authored rules, and it matches the
  observation in §6.21 that the champion is already the more *decisive* system
  (7.2% ambiguity vs 12.9%) — decisiveness and reaching the right level look
  related.
- **The tail is not the problem.** Fixing only the worst boards addresses ~23%
  of the loss; the median board losing 6 IMP is where the mass is.

Two caveats. Diagnostics only fire below −10 points, so 463 boards with loss
carry no flaw label and are outside the attribution entirely — the table
describes the *large* losses, not all losses. And this is one system on one
board set; the ranking of categories should be re-checked before committing
effort, though the underbidding concentration is large enough to be a safe bet.

**Made actionable.** The finding was previously only measurable, not fixable
without editing module constants. Now:

- `resolution_of(n_boards, metric)` grades a configured run, and `main()`
  prints it at startup — a 48-deal run reports `resolves ~1.13 IMP/board` and
  is told it cannot see the 0.28 gap. No run looks better-powered than it is.
- `--val-seeds 7,13,21,29,35` buys generalisation resolution linearly
  (2 sets → 0.58 IMP/bd, 5 sets → 0.37). `VAL_SEEDS` is no longer a constant
  you have to edit.
- `--state PATH` redirects the patch-state file, so an experiment cannot bump
  the real version counter or archive into `system/history/`. Previously any
  exploratory run mutated the repo's flywheel state.
- The `--id3` help pointed at a README "Known limitation" section that does
  not exist; it now states the measured result directly.

`tests/test_screening_resolution.py` covers the resolution helpers and the new
configuration surface (28 tests).

Also corrected: the leaderboard entry "Autonomous Evolved" is
`SystemOptimizer.create_autonomous_evolved_system()`, which is hand-authored
(`create_modern_2over1()` plus fixed convention protocols and `AI_RESP_*`
rules) — nothing autonomous or evolved about it, despite the name and its
docstring. Relabelled "2/1 + conventions"; the method name is kept for API
compatibility.

### 6.25 Ablating the underbidding target — and a baseline that overturns the naive reading

§6.24 pointed at underbidding. This tests it directly, three ways: remove the
rules that reach game and slam; count how often they actually fire; and measure
the resulting contract mix **against a baseline**.

**(a) Ablation: the level-reaching rules are worth +0.18 IMP/board.** Removed
all 32 champion rules whose call is game-or-higher (3NT+/4H+/4S+/5m+), 90 → 58
rules. 812 boards, seed 2024, paired, panel opponents:

| | mean IMP loss | MISSED_GAME | MISSED_SLAM | OVERBID_DOWN |
| --- | --- | --- | --- | --- |
| champion | 6.4163 | 103 | 42 | 116 |
| without those 32 | 6.5998 | **173** | 42 | **58** |

Those rules are worth **+0.1835 IMP/board**, se 0.0910, 95% CI
[+0.0052, +0.3618], t = +2.02 — significant, but only just; the lower bound is
+0.005. 36% of the rules carry ~67% of the 0.275 champion→improved gap, which
is the largest effect any rule group has shown anywhere in §6.

**But the two effects partly cancel, and that is the real lesson.** Removing
game rules fixed nothing and broke nothing cleanly: it *added* 70 missed games
and *removed* 58 overbids. The same rules cause both errors. So "underbidding is
66% of the loss" does **not** license "add more game bids" — the lever is
*discrimination* (bid game on the hands that have it), not aggression.

**(b) They barely fire.** Instrumenting `DecisionNet.actions` over 206 boards
(2,088 champion-side decision points): the 32 rules fired **150 times** (7.2%),
and firing is heavily concentrated — the top 8 rules account for 109 of the 150.
Eight rules never fired once:

`SUP_SLAM_6H` `SUP_SLAM_6S` `SUP_GAME_4S_WITH_LONG_SUIT` `SUP_2NT_RESP_6NT`
`SUP_REBID_6S_OVER_1S` `SUP_SACRIFICE_4S_OVER_4H` `SUP_SACRIFICE_5C_OVER_4M`
`SUP_SACRIFICE_5D_OVER_4M`

Caveat: `actions()` is also called at PIDM search nodes, so these counts
include hypothetical continuations — the ranking and the zero set are robust,
the absolute totals overstate real usage.

**(c) Slam is structurally unreachable for champion.** In 206 boards champion
played **zero** slams and zero 5-level contracts; no auction contains a 6-level
call. Par wanted a slam on 14 of the 101 boards N/S should declare. The reason
is in the rule inventory: champion's only 5-level calls are `5C` and `5D`, both
sacrifice rules that never fire. There is no cue bid, no Blackwood response, no
quantitative path — you cannot reach 6 without passing through the 5-level, and
champion has no live 5-level bid. Its 6-level rules fire only inside search
continuations. (`improved_system.dsl` *does* carry a slam vocabulary —
5C/5D/5H/5NT/5S/6C/6D/6H/6NT/6S/7NT — and still scores 0.275 worse, so the
vocabulary is necessary but plainly not sufficient.)

**(d) The baseline overturns the naive reading.** Champion stops at the 1–2
level on 67.3% of boards where N/S declares par, versus par's 24.8% — which
looks catastrophic. It is not, because SAYC stops on **93.1%** and improved on
76.2%:

| system | partscore (1–2) | game (3–5) | slam (6+) | short of par | exact | over |
| --- | --- | --- | --- | --- | --- | --- |
| champion | 67.3% | **31.7%** | 0.0% | 62.4% | 21.5% | 16.1% |
| improved | 76.2% | 18.8% | 5.0% | 72.4% | 16.3% | 11.2% |
| SAYC | 93.1% | 2.0% | 0.0% | 82.9% | 17.1% | 0.0% |
| **par (DD)** | 24.8% | 61.4% | 13.9% | — | — | — |

Par is double-dummy — everyone's cards face up — so *no* real system approaches
it; 62–83% "short of par" is the normal condition, not a champion defect. The
signal is the **ranking**, and it matches the scoreboard exactly: champion bids
game 31.7% of the time, improved 18.8%, SAYC 2.0%. Champion is already the most
aggressive system here and the best. So (i) the earlier instinct to read the
par gap as "champion is timid" was wrong, and (ii) aggression has been the
thing that pays — which is consistent with (a), and with (a)'s warning that it
only pays net because it is discriminating.

**(e) What is left is a coverage hole, not judgement.** Of 35 boards where par
was game-or-better and champion stopped at the 1-level, 34.3% were *one bid
then three passes* — responder holds nothing matching and
`DecisionNet.actions` falls back to PASS. Sample auctions with 22–25 combined
HCP: `1D P P P` (par NS 5D), `1S P P P` (par NS 4S), `1D P 1S P P P` (par NS
3NT). That is §6.9's "response-side coverage holes", reduced but not closed.

**Methodology note — ablation is the cheap design.** The paired sd of the
difference here was 2.59 (se 0.0910 × √812), against ~4.0 for two
independently-authored systems (§6.17). Nested variants are correlated, so an
ablation buys the same resolution with ~2.4× fewer boards. Measure by removing
what exists rather than by comparing two complete systems.

Runs in this section: (a) 812 boards parallel; (b)–(e) 206 boards serial
(`jobs=1`, needed to instrument in-process) — the mix figures are illustrative
and directional, not high-resolution.

### 6.26 Evaluations were not reproducible — the world sampler was unseeded

`Deal.completion_from_known` shuffles with the **global** `random` module, and
`evaluate_system` never seeded it — its `seed=` argument governed deal
generation only. Three consequences:

- **Two runs of the same configuration disagreed.** 818 boards, identical
  config: 6.4487 vs 6.4364 (paired mean +0.0122, sd 0.23).
- **Base and candidate were compared on different worlds.** The RNG stream
  reaching board *i* depended on how many draws boards 0..*i*−1 had consumed,
  and that differs between rule sets. The paired comparison silently carried
  that extra noise.
- Serial and parallel were not comparable (each consumed the stream in its own
  order) — a caveat the code documented rather than fixed.

**Fixed.** `seed_board(seed, board_index)` seeds the sampler per board from the
*global* board index, and is called in both the serial loop and `_eval_chunk`
(keyed on `offset + i`, so re-splitting `jobs` does not change which worlds a
board sees). The serial path saves and restores the global RNG state so other
consumers are unaffected.

Verified: 70 boards, three runs — serial, serial again, and `--jobs 4` — all
bit-identical (`scores` lists equal, means equal to 6 dp).

**Side benefit: this is a variance reduction, not just hygiene.** Paired sd on a
nested variant fell from **2.59 to 2.13**, i.e. (2.59/2.13)² ≈ **1.5× fewer
boards for the same resolution**. The "serial and parallel numbers are not
comparable" caveat in the `evaluate_system` docstring is withdrawn.

Tests: `TestPerBoardSeeding` (4 tests) in `tests/test_screening_resolution.py`.

### 6.27 The coverage hole is real — but filling it with an existing system nets to zero

§6.25(e) found the underbid boards stop at the 1-level. This asks *why*, then
prices the fix.

**Every one of those passes is a fallback.** On the boards where par was game+
and champion stopped at the 1-level, all **41** champion PASS decisions were
φ(s) = {PASS} — no rule matched. Not one was a search choice, and not one was a
rule that said "pass". (The two reconstructions disagree slightly on the board
count — 30 by auction, 35 by final contract — but agree on the cause.) Hand
profile at those fallbacks, 284 non-opening cases over 206 boards:

| HCP at the fallback | count | share |
| --- | --- | --- |
| 13+ (a full opening) | 37 | 13.0% |
| 11–12 | 26 | 9.2% |
| 8–10 | 96 | 33.8% |
| 6–7 | 58 | 20.4% |
| 0–5 (pass is right) | 67 | 23.6% |

So it is a coverage hole and authoring rules is the right *kind* of fix.

**Priced it** by filling the hole with `improved_system`'s answer wherever
champion had none. 824 boards, paired: champion 6.3823 → filled 6.4090, i.e.
**−0.0267 ± 0.145 IMP/board (t = −0.36)** — no effect.

The mechanism worked, though; only the net is zero:

| flaw | champion | hole filled | Δ |
| --- | --- | --- | --- |
| MISSED_GAME | 100 | 83 | **−17** |
| MISSED_SLAM | 41 | 38 | −3 |
| OVERBID_DOWN | 127 | 172 | **+45** |
| SOFT_DEFENSE | 78 | 73 | −5 |

Filling the hole removes 20 missed games and slams and adds 45 overbids — it
converts underbids into overbids about **1 : 2.6** and nets to nothing. Exactly
the two-sided pattern of §6.25(a): the calls that fix missed games are the calls
that create overbids.

Two caveats on the number. The donor had to be `improved_system.dsl`: the three
built-in baselines are 8–15 rule skeletons (SAYC 10, Precision 8, 2/1 GF 15)
and had *nothing* to say on these states — literally 0 fills — so this prices
"fill with an existing system", not "fill with a good system". And the result is
a hybrid that cannot be saved as DSL; it is a measurement, not a deliverable.

**Conclusion.** The hole is worth ~0 at today's judgement quality. It becomes
worth something only with better *discrimination* — which is the same wall
§6.19–§6.25 keep hitting: nothing in this repo generates judgement, so every
route that adds bidding adds overbidding with it.

### 6.28 The headline metric is an absolute deviation, and ~half of it is artifact

> **Correction (§6.34).** The `+1.267 ± 0.318 (t 7.81)` gap quoted below is real
> *against the current panel*, but about **two thirds of it is artifact**: the
> same measurement against competent opponents gives **+0.465 ± 0.513
> (t 1.78)**. The power claim ("~3× fewer boards") is likewise calibrated under
> the weak panel and does not survive a strong one — under it, signed and abs
> have comparable resolution. The reason to adopt the signed metric is
> correctness, not resolution. See §6.34.

Every number in §6.16–§6.27 is measured with `mean_imp_loss`. That function is
`abs(score_to_imp(score - par_score))` — a mean **absolute deviation from
double-dummy par**, not a loss. Beating par by 11 IMP scores exactly like
missing it by 11.

**How much of it is not loss.** Champion, 830 boards:

| | boards | share | total IMP |
| --- | --- | --- | --- |
| we **beat** par | 376 | 45.3% | **+2,900** |
| we lose to par | 347 | 41.8% | −2,378 |
| exactly at par | 107 | 12.9% | 0 |

Mean **signed** value: **+0.63 IMP/board** — champion is net *ahead* of
double-dummy par — while `mean_imp_loss` reports 6.36. **54.9% of the reported
"loss" is actually out-performing par.**

**Why: on half the boards, reaching a contract is not our job.** Par belongs to
N/S on 48.5% of boards and to E/W on 51.5%. Splitting champion's signed score:

| par belongs to | boards | mean signed | mean abs |
| --- | --- | --- | --- |
| N/S (we should declare) | 404 | **−3.52** | 6.09 |
| E/W (we should defend/sacrifice) | 426 | **+4.56** | 6.62 |

The +4.56 is not skill. The largest single "gains" are boards where par is
`EW 7N` (−2,220 for us) and we score −260 because E/W never bids the slam:
**+18 IMP for doing nothing**. And there is no stronger opponent to use —
`gib.dsl`, `precision.dsl` and `blue_club.dsl` all parse to **0 rules**, and
the panel's SAYC / Precision / 2-1 GF are 10 / 8 / 15 rules. So ~half of every
number in this document is measured against opponents that cannot bid their own
contracts.

**And `abs()` destroys exactly the discriminating information.** Where two
systems disagree in *sign*, |a| − |b| = a + b — the terms add instead of
cancelling. That is precisely where the signal lives, which is why the abs
metric has so little power.

**Fix: a signed metric.** Added `imp_diff()` and `mean_imp_diff` to both the
serial and parallel paths. It is deliberately **not** in `LOWER_IS_BETTER`
(higher is better), has a 0.03 acceptance floor, and is left out of
`SCREENING_NOISE_SD` so `min_detectable_effect` reports `inf` rather than
inventing a calibration. `imp_loss` itself is left alone: 28 recorded flywheel
versions and the leaderboard depend on its current meaning.

**What it buys.** champion vs improved, 836 boards, paired, same deals:

| metric | effect (champion better) | 95% CI | t |
| --- | --- | --- | --- |
| `mean_imp_loss` (abs) | +0.0706 | [−0.185, +0.326] | +0.54 |
| `mean_imp_diff` (signed) | **+1.2667** | [+0.949, +1.585] | **+7.81** |
| signed, N/S-par boards only (406) | +1.3350 | [+0.817, +1.853] | +5.05 |
| signed, E/W-par boards only (430) | +1.2023 | [+0.824, +1.581] | +6.23 |

Champion +0.5837 vs improved −0.6830 signed. The published abs gap was
+0.275 ± 0.084 (t 3.26) and needed **2,054 boards**; the signed gap is visible
at t = 7.8 with **836**.

**Calibrated, and the calibration corrects the claim above.** Same protocol as
§6.16 — the same system on 5 independent 96-deal sets:

| | signed mean | sd across sets | paired Δ (champ−impr) |
| --- | --- | --- | --- |
| champion | +0.357 | **0.760** | mean **+1.390** |
| improved | −1.033 | **0.803** | sd 0.608, sem 0.272, **t 5.11** |
| *(abs, for comparison)* | 6.65 / 7.14 | 0.377 / 0.342 | mean +0.529, sd 0.422, t 2.81 |

Two facts pulling in opposite directions, and both matter:

- **The signed metric is noisier per system across deal sets** (sd 0.76–0.80 vs
  0.32–0.44). Its level depends on how many boards in the set happen to be
  "E/W declares par", so **never compare signed levels across different deal
  sets** — only paired differences.
- **The paired delta is ~2.6× larger for only ~1.4× more noise**, so a paired
  comparison is genuinely better powered: **t 5.11 vs 2.81 on the same 480
  boards**.

So the honest power gain is **~3× fewer boards** (t² ratio), not the ~14× that
comparing the signed effect against a single unstable abs point estimate
suggests. The abs effect is itself poorly determined — it measured +0.071 at
836 boards, +0.529 at 480, and +0.275 at 2,054 — which is exactly the problem.
The signed effect is stable and large. **The defensible claim is that the
signed metric turns a marginal or null result into a decisive one** (t 0.54 →
7.81 on identical boards), worth roughly 3–14× in boards depending on which abs
estimate you compare against. `SCREENING_NOISE_SD["mean_imp_diff"] = 0.61`
(the paired-delta sd, matching the 0.42 convention).

The abs calibration was reproduced at **0.426** against the published 0.42,
which validates §6.16.

**This partially re-scopes §6.16.** "Buy screening resolution" was framed as a
throughput problem (more boards, more parallelism). A good part of it is a
*metric* problem: four of the five retracted claims in §6 exist because the
screen could not see the effect. Switching `--metric` to the signed measure buys
a real power improvement for paired comparisons — but it is ~3×, not an order
of magnitude, and it does **not** make the signed *level* comparable across deal
sets. Verified that `metric_gain`, `passes_effect_floor` and `val_tolerance`
all handle it with the correct sign.

**Caveat that matters.** The signed *level* is not a claim about bridge
strength — +4.56 on E/W boards is the weak panel, not us. Only the **paired
difference** between two systems on the same boards is trustworthy. The flywheel
compares candidates against a base on identical deals, so it is exactly the
paired case, and the switch is safe for it.

Tests: `TestSignedImpMetric` (6 tests) in `tests/test_screening_resolution.py`.

### 6.29 The signed metric does not rescue the patches either

§6.28 showed the signed metric is much better powered for whole-system
comparisons. The question that actually matters for the flywheel is whether it
resolves *patches*. It does not — but it is clearly more sensitive, and it
sharpens the diagnosis.

Three curated families applied to champion, 830 boards, paired:

| family | abs effect | abs t | signed effect | signed t |
| --- | --- | --- | --- | --- |
| SUPPORT | +0.0024 | +0.19 | **−0.0239** | **−1.50** |
| BALANCING | +0.0000 | +0.00 | **+0.0000** | +0.00 |
| OVERCALLS | +0.0000 | +0.00 | **+0.0000** | +0.00 |

- **BALANCING and OVERCALLS are exactly zero in both metrics.** They change no
  board's outcome at all. No metric can resolve a patch with no effect; this
  confirms §6.19 by a different route and is a property of the patches, not of
  the measurement.
- **SUPPORT registers ~10× more strongly on the signed metric** (|t| 1.50 vs
  0.19) and leans *negative* — the patch may be mildly harmful, which the abs
  metric was never going to notice. Still not significant at 95%.

Because a small patch changes few boards, the paired sd here is only ~0.46
(versus ~4.7 for whole-system comparisons), so the resolution is ±0.031 — and
the effect is −0.024. Resolving it would need roughly **1,400 boards**. The abs
side is worse, but by an unstable factor: its effect measured +0.0024 here
against +0.031 in §6.19, so the implied budget swings between ~500 and ~88,000
boards depending on which estimate you trust. That instability *is* the finding.

**Conclusion.** Switching `--metric mean_imp_diff` is a free ~3× (system level)
to ~8× (patch level) sensitivity gain and worth doing. It does **not** rescue
the flywheel's core loop: the curated patches are either inert (2 of 3 change
literally nothing) or worth ~0.02 IMP/board, which no metric resolves at the
96-deal default. §6.19's verdict stands — the problem is the patches, and now
also partly the metric.

### 6.30 A par-free head-to-head metric: more power per board, but not per play

§6.28's contamination comes from par. The clean alternative needs no par at all:
play each board twice — candidate at N/S and at E/W, against the **same** fixed
opponent — and take `h2h = (score_as_NS − score_as_EW) / 2`. The opponent's
weakness appears in both orientations and cancels. Against SAYC, 836 boards:

| | as N/S | as E/W | **h2h** |
| --- | --- | --- | --- |
| champion | +27.7 | +25.3 | **+26.50** pts/board |
| improved | −38.7 | −36.8 | **−37.73** pts/board |

Champion beats SAYC by 26.5 points a board. **`improved_system.dsl` loses to
SAYC by 37.7** — and SAYC is a 10-rule skeleton. Twenty-eight rounds of
"validated" flywheel patches produced a system that cannot beat a baseline that
reaches game on 2% of boards. That is the clearest single statement of whether
this approach works.

Power on the same 836 boards, champion vs improved:

| metric | par-based? | plays/board | t |
| --- | --- | --- | --- |
| `mean_imp_loss` | yes | 1 | +0.54 |
| `mean_imp_diff` | yes | 1 | +7.81 |
| head-to-head vs SAYC | **no** | 2 | **+10.72** |

But h2h costs twice the plays, so per unit of compute it is **7.58 against 7.81
for the signed metric — a wash**. The choice between them is not about power:

- Prefer **h2h** where the *level* matters and must be stable across deal sets
  (the flywheel's validation gate, §6.16), because the signed level swings with
  the E/W-declares-par mix (sd 0.76–0.80).
- Prefer **`mean_imp_diff`** for routine paired screening: same efficiency, half
  the compute, already wired into the metric surface.

**Caveat on h2h.** Measuring against one opponent rewards *exploiting that
opponent*. A 64 pts/board spread against a 10-rule skeleton is partly that. Use
a panel of opponents and average if the number is meant to generalise — the
`evaluate_panel` both-seats machinery already exists for it.

### 6.31 Sizing the remaining prizes: game accuracy beats slam 2.3 : 1

§6.25 flagged slam as structurally unreachable (0 slams in 206 boards) and
roadmap 1c pointed there. Before building a slam ladder, price it — using the
**signed** metric, grouped by who declares par and at what level (836 boards):

| par | boards | signed mean | IMP/board |
| --- | --- | --- | --- |
| N/S 1 | 52 | −2.04 | −0.127 |
| N/S 2 | 57 | −3.37 | −0.230 |
| N/S **3** | 102 | −4.35 | **−0.531** |
| N/S **4** | 113 | −3.34 | **−0.451** |
| N/S 5 | 32 | +0.91 | +0.035 |
| N/S 6 | 37 | −7.30 | −0.323 |
| N/S 7 | 13 | −6.62 | −0.103 |

(E/W rows are all positive — +0.64 to +0.72 IMP/board at levels 3/4/6 — and are
the §6.28 weak-panel artifact, not skill.)

**The slam prize is −0.426 IMP/board** (50 boards, 6.0%, −7.12 IMP each). That
is an unreachable upper bound: it assumes bidding every slam double-dummy knows
is there, with no overbidding cost.

**The game prize is more than twice as big.** N/S par at level 3 or 4 — 215
boards, 25.7% of the set — accounts for **−0.982 IMP/board**, against −0.426
for slam. Per-board it is smaller (−4.35 and −3.34 vs −7.30) but it is *four
times as many boards*, and game contracts are far more reliably biddable than
slams, so a much larger fraction of that bound is actually convertible.

For scale: the champion→improved gap is +1.267, removing all 32 game/slam rules
costs +0.184, and the best curated patch family is +0.031.

**This reorders roadmap 1c.** Slam is the more *interesting* defect — it is
totally absent rather than merely imprecise — but it is not the biggest one.
Reaching the right **game** contract on ordinary hands is worth ~2.3× more, and
it is the same discrimination problem §6.25(a) and §6.27 both found: the calls
that fix missed games are the calls that create overbids. Slam also stays hard
for a structural reason §6 already records — multi-step conventions (RKCB
continuations) rely on fragile feature chains, and there is no stateful
convention memory (roadmap item 4).

### 6.32 The whole pipeline defaults to the worst system measured

§6.30: `improved_system.dsl` loses to SAYC by 37.7 pts/board head-to-head.
§6.28: it scores −1.033 signed against champion's +0.357. It is the worst system
in the repo that anyone would take seriously — and it is the hardcoded default
across the codebase:

| role | where |
| --- | --- |
| flywheel target (**loop writes back to it**) | `flywheel.py:46`, `autoloop.py:43`, `convention_search.py:43` |
| engine budget / A-B harness | `engine_budget.py:18`, `ab_engine.py:19` |
| **student's teacher** (trace generation) | `trace_factory.py:154`, `cot_bidder.py:330`, `refresh_student.py:41` |
| pipeline output path | `pipeline.py:76` |
| web UI default | `web_export.py:226` |
| leaderboard, forced first | `eval_vs_dds.py:1040`, `:1057` |
| misc tools | `mine_disagreements.py:145`, `rl_finetune.py:220`, `export_results.py:58`, `explain_board.py` |

Two consequences worth stating plainly. The improvement loop spends every cycle
trying to improve the worst system rather than the best one. And **the neural
student is distilled from it** — Loop B's teacher is a system that cannot beat a
10-rule baseline.

**Changed (safe, verifiable).**
- `web_export.py`: `"Champion (auto-evolved)"` → `"Champion (hand-authored)"`.
  It is 90 hand-written `SUP_*` rules; the label repeated the exact false claim
  corrected in §6.15. `"Improved (current teacher)"` → `"Improved (flywheel
  output)"`, since "teacher" implied a status §6.30 contradicts.
- `eval_vs_dds.py`: the leaderboard forced `improved_system.dsl` first. Now the
  champion snapshot goes first, guarded for the case where that file is absent
  or skipped as a duplicate.

**Not changed — these need your call**, because they alter what gets written or
what the student learns:
- `flywheel.py:46` / `autoloop.py:43` / `convention_search.py:43` (`TARGET`).
  Pointing them at `champion_system.dsl` would make the loop **overwrite the
  best system**. The correct form is a separate target; `champion_evolved.dsl`
  exists as a copy but is currently untracked.
- `trace_factory.py:154`, `cot_bidder.py:330`, `refresh_student.py:41`. Training
  the student on champion instead is almost certainly right, but it changes what
  Loop B learns from, so it should be a deliberate decision.

### 6.33 A donor that is a subset of the failing rule set cannot fire — an ill-posed experiment, retracted

§6.27 found that every one of champion's 41 fallback passes on underbid boards
is a coverage hole (φ(s) = {PASS} because no rule matched), and that filling it
with `improved_system`'s judgement netted −0.0267 ± 0.145: −17 MISSED_GAME and
−3 MISSED_SLAM bought +45 OVERBID_DOWN. The obvious follow-up was to fill the
same hole with a *conservative* donor, so that underbids become live auctions
rather than overbids.

**First attempt: donor = the 22 level-1 rules of champion itself. Result: 0 fills
on 48 boards.** That null is vacuous, and the abort message I printed at the time
("champion's level-1 guards do not match mid-auction") was wrong. The real reason
is structural — `DecisionNet.actions()` (`decision_net.py:128`) evaluates *every*
rule in `self.rules` against the extracted features and falls back to PASS only
when `not rule_priority`, i.e. when no positive rule matched at all. A donor whose
rule set is a **subset** of the system's own rules therefore provably cannot
match where the full set did not. The experiment had no chance of producing a
non-zero result, so it says nothing about champion's guards.

The one loophole is the second fallback path at `decision_net.py:151`, where
positive rules *did* match but all were suppressed by negative rules — a subset
donor could in principle differ there. Empirically it did not fire, so that case
does not arise in practice.

**Second attempt (correct): donor = the 16 level-1 rules of `improved_system.dsl`**,
a genuinely different rule set, restricted to the 1 level so that the fill keeps
the auction alive instead of jumping toward game. It fires: **12 fills on 48
boards** (~25% of boards), so the null above is confirmed as an artefact and not
a property of the hole.

836 boards, paired, panel opponents:

| metric | base champion | + level-1 donor | delta | se | 95% CI | t |
|---|---|---|---|---|---|---|
| `mean_imp_loss` (abs) | 6.3684 | 6.3278 | +0.0407 | 0.0371 | [−0.032, +0.113] | +1.10 |
| `mean_imp_diff` (signed) | +0.5837 | +0.4856 | **−0.0981** | 0.0415 | [−0.179, −0.017] | **−2.36** |

| flaw | base | + donor | shift |
|---|---|---|---|
| MISSED_GAME | 103 | 106 | **+3** |
| MISSED_SLAM | 42 | 42 | 0 |
| OVERBID_DOWN | 129 | 141 | +12 |
| SOFT_DEFENSE | 79 | 72 | −7 |

**The conservative fill is significantly *worse* on the metric that can see
direction** (−0.098 IMP/board, t −2.36, CI excludes zero) and indistinguishable
from no change on the one that cannot (abs t +1.10). Two facts make this the most
informative negative in §6:

1. **It did not reach a single extra game.** The hypothesis was that a live
   auction lets partner rebid into game. MISSED_GAME moved **+3**, i.e. slightly
   the wrong way. Compare §6.27's aggressive donor: −17 MISSED_GAME but
   +45 OVERBID_DOWN. So the two donors span the trade-off and *neither* produces
   games — the aggressive one buys them by overbidding, the conservative one
   buys nothing at all.
2. **It still added overbids (+12).** Roughly 209 interventions on 836 boards
   produce +12 OVERBID_DOWN and 0 games: about **−0.39 IMP per intervention**.
   Bidding on hands champion chose to pass is simply worse than passing, even
   when the bid is the meekest one available.

> **Correction (§6.39).** The inference in the next paragraph — "what is missing
> is a bidding ladder" — is **wrong as stated**, and was corrected by inspecting
> the rules rather than the behaviour. Champion has **29 raise rules** and 21
> level-4 rules, including a complete `1M→2M→3M→4M` chain: the ladder to *game*
> exists. What is missing is the **5 level** — exactly two level-5 rules, both
> non-vulnerable sacrifices, and six level-6 rules that jump straight to 6 on
> 20–23+ HCP. Everything else below stands; only the diagnosis changed.

**Conclusion: the coverage hole is not the binding constraint.** §6.27 showed
that all 41 fallback passes on underbid boards are genuine holes, which made the
hole look causal. It is not. Fill it aggressively and games appear only as a
by-product of overbidding; fill it conservatively and games do not appear at all.
The reason is visible in §6.25: champion already stops at the 1–2 level on 67.3%
of boards, and it does so *with* rules firing, not by falling through them. One
extra call at one decision point does not reach game, because the rest of the
ladder still stops low. **The missing thing is a bidding ladder — a coherent
sequence of raises — not a patch at the pass.** That is a system design problem,
not a candidate-generation or search problem, and it is consistent with §6.19–§6.23
(no lever has leverage) and with the one result that has ever moved this system:
a human writing better rules (+0.275, §6.18).

**Lesson.** Before believing any null result from a patch, assert that the patch
fired — the standing rule from §6.27 — *and* check that the experimental
contrast is not impossible by construction. A subset of the failing rule set is
the clearest form of the latter. Conversely, a null that *does* fire is worth
more than a positive that does not.

### 6.34 The opponent panel is 10–20× too weak, and it inflated the headline gap by 2.7×

§6.28 recommended the signed metric and reported the champion→improved gap as
**+1.267 ± 0.318 (t 7.81)**. §6.28 also warned that the number is contaminated,
because par belongs to E/W on 51.5% of boards and the panel opponents cannot bid
their own games. This section prices that contamination, and the answer is that
it accounts for about **two thirds** of the reported gap.

**Three substantial hand-authored systems are in the repo and have never been
used as opponents.** `system/blue_club.dsl` (953 lines), `precision.dsl` (911)
and `gib.dsl` (464) — 2,328 lines, 54% of the `system/` directory — all parse to
**0 rules** under `load_decision_net_dsl`. They are not broken: they are a
*legacy dialect* (`OPEN 1C:` / `HCP:` / `SHAPE:` rather than `RULE … IF …`),
loaded by `SystemTranslator().parse()` into a `BiddingSystem`. As systems they
are **183, 166 and 159 rules**.

`DecisionNet.wrapped_system` (`decision_net.py:138`) is the bridge, so wrapping
them yields working opponents. Compare against the panel actually in use, which
`build_opponent_panel()` builds from `SystemOptimizer` skeletons:

| panel | members | rules |
|---|---|---|
| current | SAYC / Precision / 2/1 GF | **10 / 8 / 15** |
| available | blue_club / precision / gib | **183 / 166 / 159** |

Note these are two unrelated things that §6.28's parenthetical conflated: the
panel's "Precision" is `create_precision_system()` (8 rules), **not**
`system/precision.dsl` (166 rules). The panel is weak because the programmatic
baselines are skeletons, not because the DSL files are unparseable.

**Result — 606 boards, paired, each system against both panels:**

| panel | champion abs | champion signed | improved abs | improved signed |
|---|---|---|---|---|
| current (weak) | 6.3515 | +0.2756 | 6.4224 | −0.9901 |
| legacy (strong) | 6.5330 | +0.3812 | 6.8300 | −0.0842 |

| panel | champion − improved, abs | signed |
|---|---|---|
| weak | −0.0710 ± 0.308 (t −0.45) | **+1.2657 ± 0.379 (t +6.55)** |
| strong | −0.2970 ± 0.325 (t −1.79) | **+0.4653 ± 0.513 (t +1.78)** |

**A large share of the gap is artifact.** +1.266 → **+0.465**, and t falls from
6.55 to 1.78. Champion is still ahead on both metrics, but the effect is roughly
**one third** of what §6.28 reported.

> **Superseded in two respects by §6.37** (2,006 boards, same design). First,
> t 1.78 here was **underpowered, not null**: at 2,006 boards the legacy-panel
> gap is +0.732 (t 5.41), significant. Second, "two thirds" overstates it — the
> better-powered reduction is **41%** (+1.246 → +0.732). The mechanism and
> direction below stand; the size and the significance claim do not.

**The artifact is asymmetric, and it sits on `improved`, not on champion.**
Champion's own signed score is stable across panels (+0.2756 → +0.3812,
difference −0.106 ± 0.327, not significant). Improved's moves by
**−0.906 ± 0.455** (−0.9901 → −0.0842). So the weak panel made the *worse*
system look far worse rather than making the better one look better — which is
why it inflated the gap rather than shrinking it.

**This also invalidates the flaw taxonomy, and therefore §6.24/§6.25/§6.31.**
Opponent strength does not merely scale the flaws, it reclassifies boards:

| flaw | champion weak→strong | improved weak→strong |
|---|---|---|
| MISSED_GAME | 80 → 54 (**−26**) | 107 → 40 (**−67**) |
| MISSED_SLAM | 33 → 33 | 29 → 27 |
| OVERBID_DOWN | 95 → 90 | 128 → 104 |
| SOFT_DEFENSE | 54 → 82 (**+28**) | 59 → 111 (**+52**) |

When opponents bid competently they often buy the contract, so boards we
"missed game" on become boards we are *defending*. MISSED_GAME falls by a third
and SOFT_DEFENSE rises by half, with no change in our own bidding. The §6.24
attribution (MISSED_SLAM 33.7% + MISSED_GAME 32.6% ≈ 66% of loss) and the §6.31
pricing that reordered roadmap 1c were both measured against the weak panel and
are therefore opponent-dependent, not properties of the system.

**Correction to §6.28's power claim.** The "~3× fewer boards for the same
resolution" figure was calibrated under the weak panel, where signed gives
t 6.55 against abs's t 0.45. Under the strong panel the two give t 1.78 and
t 1.79 — comparable resolution. The recommendation to adopt `mean_imp_diff`
still stands, but on **correctness** grounds: `abs(deviation from par)` is not a
loss function, and it cancels the signal exactly where two systems disagree in
sign. It should not be sold as a resolution win, because that win is
panel-dependent and may not survive a competent panel.

**Blocker: the legacy systems could not be used in parallel evaluation.**
`SystemTranslator._add_rule_from_data` built each rule's test as a **closure**,
and Python cannot pickle a nested function by reference, so a wrapped
`BiddingSystem` failed the moment it was sent to a `spawn` worker — which is
what `evaluate_system(jobs>1)` must use:

```
AttributeError: Can't get local object
'SystemTranslator._add_rule_from_data.<locals>.trigger'
```

Everything above was therefore measured with `jobs=1` (~0.21 s/board, ~19 min
for the four evaluations). **This is now fixed — see §6.35.**

### 6.35 Fixed: the legacy systems are now picklable, so the strong panel can run in parallel

§6.34's blocker was that `SystemTranslator._add_rule_from_data` built each rule's
trigger as a closure, so no legacy system could be sent to a `spawn` worker.
The closure captured only picklable data — `trig_type`, `steps`, `passed_hand`,
`partner_passed_hand`, `opener_seats` — so the fix is to carry that state on a
module-level callable object instead:

- **`src/bid/translator.py`** — added `LegacyTrigger`, a class with `__slots__`
  for the five captured values and a `__call__(history)` holding the original
  body verbatim. `_add_rule_from_data` now builds
  `LegacyTrigger(trig_type, steps, passed_hand, partner_passed_hand, opener_seats)`
  instead of defining a nested function. `Rule` only ever calls
  `trigger(history)`, so a callable object is a drop-in replacement.
- **`tests/test_legacy_pickling.py`** (new, 5 tests) — asserts every legacy rule's
  trigger is a `LegacyTrigger`, that all three systems pickle, that a pickled
  system picks identical calls to a fresh one across 120 random
  (hand, history) cases each, that `get_bid` is deterministic (otherwise the
  comparison would prove nothing), and that a wrapped `DecisionNet` round-trips.

**Verified behaviour-preserving.** 1,500 call comparisons (3 systems × 500
random hand/history pairs) between fresh and pickled systems: **0 mismatches**.
All 39 legacy-system tests pass (`test_precision`, `test_gib_compliance`,
`test_blue_club`, `test_blue_club_slam`, `test_blue_club_defensive`,
`test_convention_options`).

**Verified the blocker is gone.** 96 boards against the strong panel:
`jobs=1` 19.9 s and `jobs=8` 10.2 s, both giving **signed +0.4412 — bit-identical**,
so the §6.26 per-board seeding holds for the strong panel too. (The speedup is
only ~2× at 8 workers, not 8×; this workload is dominated by per-board DDS and
start-up, not by the bidding.)

*Debugging note, so it is not repeated:* comparing `str(rule)` to check for
behaviour change is wrong — `Rule` defines no `__str__`, so it renders as
`<bid.system.Rule object at 0x...>` and **every** comparison fails. That
produced a false alarm of 62–172 "mismatches" per system. Compare `rule.call`.

**Recommendation, implemented as §6.36: add the strong panel as an option, do not
replace the current one.** `build_opponent_panel`'s docstring is explicit that the
panel "never changes between runs, so numbers stay comparable across versions",
and 28 recorded versions of `improved_system.dsl` were scored against it.
Swapping it would reset that record, so `--panel legacy` is additive. Every
number in §6 should be read as *"against 8–15-rule skeletons"* until re-measured.

### 6.36 `--panel legacy` and `mean_imp_diff` are now selectable from the CLI

§6.34 recommended the strong panel as an opt-in flag and §6.28 recommended the
signed metric. Both are now wired into `eval_vs_dds.py`, so neither needs a
custom script any more.

- **`--panel [default|legacy]`** — previously a bare `store_true`; now
  `nargs="?" const="default"`, so plain `--panel` behaves exactly as before
  (SAYC 10 / Precision 8 / 2/1 GF 15). `--panel legacy` uses the 183/166/159-rule
  hand-authored systems via `DecisionNet.wrapped_system`. The chosen panel is
  built **once** before the leaderboard loop — parsing three ~900-line DSLs per
  system was slow enough to time the run out.
- **`build_panel(kind)`** dispatches on the name; `build_legacy_panel()` does the
  `SystemTranslator` work. Both live next to `build_opponent_panel()`.
- **`--metric mean_imp_diff`** is now an accepted choice. `evaluate_panel` did not
  previously compute it, so selecting it would have raised `KeyError`; it now
  accumulates the signed value per opponent (positive = beating par) and the
  leaderboard prints it in a new **IMP diff/bd** column beside the unsigned
  IMP loss/bd, with a footnote saying which is which. Ranking direction is
  handled by the existing `LOWER_IS_BETTER` check.
- **`tests/test_legacy_pickling.py`** gained `TestPanelSelection`: the default
  panel must still be exactly `[SAYC, Precision, 2/1 GF]` at `[10, 8, 15]`
  rules (28 recorded versions depend on it), the legacy panel must be
  `[blue_club, precision, gib]` at `[183, 166, 159]`, and the whole legacy panel
  must survive pickling.

Smoke run, 12 boards, ranked by `mean_imp_diff` against the legacy panel:
champion **+1.24** first of 11, `improved_system.dsl` **−0.15** tenth. Direction
agrees with the 606-board §6.34 result while the magnitude does not — 12 boards
is far too few to read anything into the gap.

**Verification:** 275 Python tests pass (3 skipped).

### 6.37 At 2,006 boards the gap is significant under both panels — §6.34 was underpowered, not null

§6.34 measured the champion→improved gap at 606 boards and found +1.266 (t 6.55)
against the skeletons but only +0.465 (t 1.78) against the legacy systems,
concluding the honest estimate "no longer excludes zero" and that two thirds of
the gap was artifact. **Both of those claims were artefacts of n = 606.** Re-run
at 2,006 boards on identical board sets, paired:

| panel | champion abs | champion signed | improved abs | improved signed |
|---|---|---|---|---|
| default (10/8/15) | 6.4078 | **+0.6281** | 6.6346 | −0.6176 |
| legacy (183/166/159) | 6.5743 | **+0.6291** | 6.9412 | −0.1027 |

| panel | champion − improved, abs | signed |
|---|---|---|
| default | −0.2268 ± 0.168 (t −2.64) | **+1.2458 ± 0.206 (t +11.85)** |
| legacy | −0.3669 ± 0.178 (t −4.04) | **+0.7318 ± 0.265 (t +5.41)** |

**Champion's advantage is real under competent opponents: t 5.41.** §6.34's
t 1.78 was a sample-size problem, not evidence of no effect. At 606 boards
*neither* metric was significant on the legacy panel (abs t −1.79, signed
t 1.78); at 2,006 both are, and they agree in direction.

**But §6.34 overstated the artifact.** The gap shrinks from +1.246 to +0.732 —
**41% smaller, not the ~63% ("two thirds") implied by the noisy 606-board point
estimates.** The direction and the mechanism in §6.34 stand; the size does not.
This is the same mistake as the earlier "14×" claim: quoting a ratio whose
denominator is a point estimate with a wide CI.

**Champion's absolute score is panel-invariant; improved's is not.** Champion's
signed score is +0.6281 against the skeletons and +0.6291 against the legacy
systems — a difference of 0.001. Improved's moves from −0.6176 to −0.1027, a
swing of 0.515. Champion's strength does not depend on who it is playing;
improved's does. That is itself a quality signal, and it confirms §6.34's
asymmetry finding much more sharply than 606 boards could.

**The flaw attribution is even more opponent-dependent than §6.34 showed.**

| flaw | champion default→legacy | improved default→legacy |
|---|---|---|
| MISSED_GAME | 230 → 166 (−64) | 352 → 161 (**−191**) |
| MISSED_SLAM | 120 → 114 | 107 → 99 |
| OVERBID_DOWN | 283 → 254 | 393 → 322 |
| SOFT_DEFENSE | 191 → 286 (**+95**) | 148 → 350 (**+202**) |
| TAKEOUT_PASS | 0 → 6 | 0 → 20 |

The striking entry is MISSED_GAME: under the skeletons improved misses **352**
games to champion's 230, a 53% higher miss rate that would make underbidding the
obvious thing to fix. Under competent opponents the two are **161 vs 166 —
statistically indistinguishable.** Improved still scores 0.73 IMP/board worse
there, so under realistic conditions its deficit is *not* primarily missed
games; it is the 322 vs 254 OVERBID_DOWN and 350 vs 286 SOFT_DEFENSE. The §6.24
attribution and the §6.31 game-first ordering were both derived from the
skeleton-panel column and should be re-derived before being acted on.

**Consequence: the "reseed from champion" recommendation is confirmed on firmer
ground** — it now rests on t 5.41 against opponents that can actually bid, not
on t 11.85 against 10-rule skeletons. §6.34's warning that every §6 number is
opponent-dependent still applies to the *flaw-level* conclusions, which are the
ones that drive authoring priorities.

### 6.38 Re-derived under competent opponents: the game-first ordering survives, the attribution does not

§6.37 showed the flaw taxonomy is opponent-dependent, which put two standing
conclusions in doubt: the §6.24 attribution (missed game + missed slam ≈ 66% of
loss) and the §6.31 pricing (game worth 2.3× slam) that reordered roadmap 1c.
Re-measured for champion at 2,012 boards on both panels, using
`BiddingDiagnostic.severity_pts` for attribution and each board's par contract
for the prizes.

**Method check first.** On the default panel this reproduces §6.24 almost exactly
— MISSED_SLAM 37.5% + MISSED_GAME 29.8% = **67.3%** against the published ~66%.
So the numbers below are comparable to the published ones, and the shift under
the legacy panel is a real effect rather than a change of method.

**Attribution (share of attributed loss in points):**

| flaw | default boards | default share | legacy boards | legacy share |
|---|---|---|---|---|
| MISSED_SLAM | 122 | 37.5% | 116 | **34.4%** |
| MISSED_GAME | 231 | 29.8% | 167 | **20.8%** |
| OVERBID_DOWN | 285 | 24.1% | 256 | **23.5%** |
| SOFT_DEFENSE | 192 | 8.5% | 286 | **19.9%** |
| TAKEOUT_PASS | 0 | — | 6 | 1.4% |

Three things move:

- **Missed game + missed slam falls from 67.3% to 55.2%.** The headline
  "underbidding is two thirds of the loss" is a skeleton-panel result.
- **SOFT_DEFENSE more than doubles, 8.5% → 19.9%**, and at 286 boards it is the
  **most frequent** flaw under competent opponents — more common than any other
  category. Against opponents who cannot bid, there is nothing to compete over,
  so the whole category nearly vanishes. This is the quantified form of §6.27b's
  observation that 53.5% of loss sits on boards where E/W holds par.
- **MISSED_SLAM is the most stable** (37.5% → 34.4%) and remains the largest
  single share, consistent with §6.25's finding that slam is structurally
  unreachable — champion's only 5-level calls are two never-firing sacrifice
  rules, so there is no route to 6.

**Prizes** (mean signed IMP/board on boards where N/S holds par; the board sets
are identical across panels because par depends only on the deal):

| par level | boards | default | legacy | legacy total IMP |
|---|---|---|---|---|
| 3–4 (game) | 532 | −3.449 ± 0.499 | **−3.194 ± 0.552** | −1,699 |
| 6+ (slam) | 134 | −6.716 ± 1.932 | **−6.299 ± 1.954** | −844 |
| 1–2 (partscore) | 239 | −2.556 ± 0.387 | **−2.029 ± 0.494** | −485 |

**The §6.31 ordering survives.** Per board, slam is worth about twice game
(−6.30 vs −3.19); in total, game is worth about twice slam (−1,699 vs −844)
because there are 4× as many game boards. That ratio, 2.0×, is close to §6.31's
2.3× despite the different conditioning, so **roadmap 1c's game-first ordering
is confirmed under competent opponents** and does not need re-deriving.

So the split verdict: **where to author is unchanged (game first), but why is
not.** Under realistic opponents, "fix underbidding" accounts for 55% of loss
rather than 67%, and failing to compete over the contract is a first-class
problem at 20% and the single most common flaw — a target the default panel
hid entirely. Champion's own signed score is again panel-invariant here
(+0.6093 vs +0.6133), the third independent confirmation of §6.37's finding.

**Caveat on the SOFT_DEFENSE number — it is a catch-all, not a diagnosis.**
The category is assigned at `diagnostics.py:191` (`if decl_is_ew or
contract is None`) and again at `diagnostics.py:221` as the **fallback** for any
board that lost more than 10 points and matched no other flaw. Its
`severity_pts` is `abs(regret)` (`diagnostics.py:156`) — the board's entire
shortfall, not an estimate of what competing would have recovered. Since
double-dummy par already prices the sacrifice option, a board whose par belongs
to E/W is by construction one where bidding on was not profitable. The 19.9%
therefore mixes genuine competitive errors with boards where the opponents
simply owned the hand. Treat it as "a large, unmeasured region" — see the
caveat in roadmap 1e — and split it before acting on it.

### 6.39 Structural check: the game ladder EXISTS — what is missing is the 5 level

§6.33 concluded that "what is missing is a bidding ladder — a coherent sequence
of raises". That was inferred from behaviour (hole-filling produced no games;
champion stops at 1–2 on 67.3% of boards). Checking the rules directly **refutes
the general claim**, and localises the real gap much more precisely. Counting
rules that respond to `partner_last_call` with the *same strain at a higher
level* (a raise):

| | champion (90 rules) | improved (75 rules) |
|---|---|---|
| opening rules (guarded on `is_opening`) | 14 | 12 |
| rules requiring `partner_last_call` | 61 | 34 |
| rules with `REBID` in the id | 18 | 8 |
| **raise rules** | **29** | **14** |
| call levels | L1:22 L2:22 L3:16 **L4:21 L5:2 L6:6** | L1:16 L2:20 L3:11 L4:9 L5:6 L6:8 L7:2 |

**Champion already has a raise ladder to game**, and it is not a stub: 29 raises
and 21 level-4 rules, including the full chain `1S→2S` (four separate rules),
`1S→3S` (limit), `2S/3S→4S`, `2S→4S`, `1M→4M`, and `1M→6M`. So "build a ladder"
would have been the wrong instruction — the rungs are there.

**What is genuinely absent is the 5 level.** Champion has exactly **two** rules
at level 5, and both are sacrifices, not slam tools:

```
SUP_SACRIFICE_5C_OVER_4M   IF opp_last_call in ['4H','4S'], club_len >= 6, is_vulnerable == False
SUP_SACRIFICE_5D_OVER_4M   IF opp_last_call in ['4H','4S'], diamond_len >= 6, is_vulnerable == False
```

The six level-6 rules jump **straight to 6** on raw strength —
`SUP_REBID_6S_OVER_1S` (hcp ≥ 20), `SUP_SLAM_6S` (hcp ≥ 23 and 5+ spades),
`SUP_2NT_RESP_6NT` (hcp ≥ 12 over 2NT). There is no Blackwood ask, no 5-level
cue bid, no slam try. `SUP_1NT_RESP_4NT_QUANT` is quantitative, not ace-asking.
Reaching a slam therefore requires holding 20–23+ HCP in one hand and jumping
there unaided, which is why §6.25 measured **0 slams in 206 boards** where par
wanted 14.

This is the structural explanation for the two findings that previously stood
alone: §6.25's "slam is structurally unreachable", and §6.38's MISSED_SLAM being
the **largest and most stable** attribution category (34.4% under competent
opponents, barely moving from 37.5%). It also explains why §6.33's hole-filling
failed: there was no missing rung to add. Champion's remaining game-level
shortfall is not absent structure but **guard thresholds** — e.g.
`SUP_GAME_4S_AFTER_RAISE` needs hcp 16–22 *and* 5+ spades, so a 15-count opener
has no rule and stops at 2S.

Note also that improved has *more* high-level rules (L5:6, L6:8, L7:2) and
*fewer* raises (14), and is 0.73 IMP/board worse — more slam machinery is not
the fix by itself, consistent with §6.25's "discrimination, not aggression".

**Revision to §6.33.** Replace "the missing thing is a bidding ladder" with:
the ladder to **game** exists and is reasonably complete; the route to **slam**
does not exist at all. The concrete, finite work is a 4NT ace-asking bid with
5-level responses (or 5-level cue bids), which is small, well-understood, and
currently absent. Ordering is unchanged — §6.31 and §6.38 still put **game
accuracy first** (total prize −1,699 vs −844 IMP) — but slam is now a specific
missing component rather than a vague one.

### 6.40 The converted Brill system is mid-pack, and fails exactly where the conversion was lossy

`system/brill.dsl` (1,830 rules) was generated from `system/brill.md` by
`research/brill_to_dsl.py`. Scored the same way as everything else — 400
boards, seed 1, `--metric mean_imp_diff`, vs native DD par (no panel):

| # | System | Avg NS | Regret | IMP Loss/Bd | Par Acc | Game Conv |
|---|---|---|---|---|---|---|
| 1 | 2/1 + conventions | +82.5 | +72.4 | 2.99 | 61.1 % | 26.2 % |
| 5 | champion_system.dsl | +1.5 | −8.7 | 3.50 | 55.4 % | 41.0 % |
| 8 | **brill.dsl** | **−2.1** | **−12.3** | **3.86** | 53.7 % | **1.6 %** |
| 12 | improved_system.dsl | −14.0 | −24.2 | 4.04 | 52.0 % | 26.2 % |

**It underbids, structurally.** Game conversion is 1.6 % against a deal set
with 122 makable NS games; champion reaches 41.0 %. Par Accuracy (53.7 %) is
middling, not catastrophic — brill.dsl is not bidding wild contracts, it is
stopping too low. That is precisely the failure mode the conversion predicts:
every clause Brill gated on an untranslatable atom was DROPPED, never
relaxed, so what survives is the constructive/partscore layer with the game
and slam layers removed.

**It is still better than the pipeline's own default.** −2.1 vs −14.0 for
`improved_system.dsl`, which §6.32 shows is what `TARGET` points at. A
first-pass automatic conversion of a published system beats 28 rounds of
flywheel output. Worth sitting with.

**A caution about n.** A 24-board run put brill.dsl **2nd of 12** with the
best Par Accuracy (53.3 %) and the lowest IMP loss (4.27). At 400 boards that
reversed completely — 8th, with the worst game conversion in the field. The
24-board number was noise; recorded, it would have been a false result. This
is the same trap as §6.13, in a new place.

**Consequence for §6.39.** Brill is not the slam donor it first appeared to
be. Its slam apparatus (RKC0314, Grand Slam Force) is expressed as
engine-internal verdicts — `CanBid6_*`, `CanAsk_*_RKC` — that Brill never
publishes, so none of it survives translation. The one component the champion
most needs is the one component Brill will not give up. Any slam work has to
be authored here, not imported.

**If brill.dsl is ever used as an opponent**, exclude it from the systems
being ranked — otherwise it is scored against itself, which is the
self-play mirror §6.34 exists to break.

### 6.41 Brill's keycard ANSWERS are translatable — but they need an agreed-trump feature first

§6.40 concluded Brill cannot be a slam donor because its *asking* rules are
engine-internal. That is only half true, and the other half is the useful
part. `research/fetch_brill.py` stops 2 calls deep, which is exactly one call
short: partner's answer to our 4NT ask sits at `<prefix>-4N-P-*`.

Targeted capture (`research/fetch_brill_slam.py`, ~1 min): **217 positions
define calls — 148 of them true Roman Keycard Blackwood 0314**, 69
quantitative/other. The answers are pure hand tests, not engine verdicts:

    5C  (havekeycards == 0 or havekeycards == 3)
    5D  (havekeycards == 1 or havekeycards == 4)
    5H  ((havekeycards == 2 or havekeycards == 5) and not trumpqueen)
    5S  ((havekeycards == 2 or havekeycards == 5) and trumpqueen)
    5N  (havekeycards == 2 and a void in a non-trump suit)
    6x  ((havekeycards == 1 or havekeycards == 3) and x == 0)   [void-show]

Structurally that is fully convertible. What blocks it is not the scheme —
it is two features, and both need the same missing piece of state:

- **`havekeycards`** counts four aces **plus the king of trump**. The repo's
  `keycard_count_1430` is currently just `ace_count`, so it is **off by one
  whenever the hand holds the trump king**. For a slam convention that is not
  a rounding error, it is the wrong answer.
- **`trumpqueen`** — no feature exists, and it cannot be written as a
  conjunction of `*_has_queen` booleans without knowing which suit is trump.

**This sharpens §6.39.** The route to slam is no longer a vague gap: there is
now an authoritative spec to build against. But the prerequisite is an
`agreed_trump` feature (the auction-agreed strain, or `None`) — not the
convention itself. Adding it would unlock RKCB, Gerber **and** the Grand Slam
Force in one go, and it is a small, self-contained change to
`bid/features.py`. That is a better first step than authoring the convention
against a keycard count that is known to be wrong.

Note this also corrects the framing in §6.40: brill.dsl scores 0 rules for
responding to 4NT not because Brill hides it, but because the sweep stopped
one call short.

### 6.42 How much of Brill is reachable, and what each fix would buy

Measured by re-running the converter with each class of atom temporarily
made translatable (`research/brill_to_dsl.py`).

> **Note (2026-09-13).** The table below was measured on the 3,515-row
> capture. After the de-duplication in §6.43 the same run yields
> **1,552 rules / 1,101 rows / 36.1 %** — the baseline percentages are
> unchanged to within a point, so the conclusions below still hold. The
> absolute columns should be read as "at 3,515 rows"; re-measuring every
> ablation is not worth the compute until one of the fixes is actually
> implemented.

| Cumulative fix | Rules | Rows emitted | |
|---|---|---|---|
| baseline (today) | 1,830 | 1,256 | 35.7 % |
| +A longest-suit | 1,975 | 1,334 | 38.0 % |
| +B `ruleof21` | 2,020 | 1,361 | 38.7 % |
| +C `singlesuited` | 2,048 | 1,381 | 39.3 % |
| **+D suit quality** | **2,461** | **1,775** | **50.5 %** |
| **+E `loserlevel`** | **3,052** | **2,001** | **56.9 %** |
| +F auction-shape | 3,273 | 2,157 | 61.4 % |
| +G sacrifice | 3,438 | 2,296 | 65.3 % |
| +H cover/monster | 3,760 | 2,570 | 73.1 % |
| +I `Fit()` | 3,764 | 2,570 | 73.1 % |
| +K unclassified | 3,950 | 2,669 | **75.9 %** |
| +J verdicts (the wall) | 5,055 | 3,486 | 99.2 % |

So: **~76 % is reachable by adding features to `bid/features.py`.** The last
~23 % is Brill's own computed verdicts — `game`, `slammish`, `CanBid6_*`,
`CanAsk_*_RKC`, `*_compgame` — which are evaluator *outputs*, not hand
tests. Recovering them means reimplementing Brill's evaluator, not adding
features. `Fit()` buys nothing (+0); drop it from consideration.

Rows blocked by exactly one class (i.e. what fixing it alone frees):
verdicts 813, suit quality 367, cover/monster 215, loserlevel 176,
auction-shape 159, sacrifice 106, longest-suit 67, unclassified 55,
ruleof21 15, singlesuited 12.

Two levers are outsized: **suit quality (+394 rows)** and **loserlevel
(+226)**. Both need new features whose exact semantics Brill does not
publish, so they would have to be inferred from usage and then validated —
that is real work with a guessing step, not a mechanical addition.

> **Caveat.** The table ranks by ROW COUNT, not by how often a rule actually
> decides a call. §6.44 re-weights it against Brill's own engine and the order
> changes a lot: `penalty` alone is worth more than every longest-suit atom
> put together, and longest-suit — nominally +78 rows here — turns out to
> decide only 0.4 % of calls. Read this table as "how many rows become
> translatable", not "how much the system improves".

Separately from features, two other ceilings apply:

- **Crawl depth.** Everything above is the 2-call sweep (349 auctions).
  Depth 3 is ~22k auctions; the full engine has 1,040,694 rules, so
  exhaustive capture is impossible regardless of features.
- **Prose not yet used.** Part 1's responding/competing/slam sections
  (Drury, New Minor Forcing, Fourth Suit Forcing, Texas, Gerber,
  Cappelletti, Michaels, Unusual NT, negative doubles) are still
  unencoded — only the openings were taken from prose (§6.40).

### 6.43 Is the capture complete? Three findings — one bug, two non-issues

Asked whether `system/brill.md` really holds everything the service exposes.
Short answer: **yes for authored content, and the JSON's extra columns are
empty.** But chasing the question turned up a genuine bug that had been
silently corrupting the DSL.

**(1) The service ignores leading passes — and that was masking a real bug.**

`GET /getresponses?auction=P-1C-*` and `auction=1C-*` return identical rule
sets, as do `*`, `P-*` and `P-P-*`. Passes that are *not* leading are
significant (`1C-P-P-*` has 16 rows, `1C-P-*` has 27). The old crawler
expanded `P` like any other call, so 35 of its 351 headings (463 rows,
13 %) were aliases of positions already in the file.

Removing them exposed the bug: `auction_context()` handled `""` and `"P"`
but not `"*"` — the spelling `system/brill.md` actually uses for the empty
auction. The 44 opening-bid rows therefore fell through to the generic
branch and were emitted as `opp_last_call == '*'`, which never matches.
The old `brill.dsl` only had correct opening bids **by accident**, because
the duplicate `P` heading supplied them. Fixed in `brill_to_dsl.py`; the
opening seat now contributes 22 real rules (1C, 1D, 1NT, 2C, 2NT, 3NT and
the 6/7-level preempts) and the smoke suite is back to 8/8.

| | old | new |
|---|---|---|
| headings (positions) | 351 | 316 canonical + 83 collapsed |
| captured rows | 3,515 | 3,052 |
| DSL rules | 1,830 | 1,552 |
| smoke cases | 8/8 | 8/8 |

The 83 "collapsed" positions are *different* auctions that happen to return
a byte-identical table — `2H-P-*` == `2H-X-*`, `6C-*` == `7S-*`,
`5C-5H-*` == `5D-5S-*`. `brill.md` prints such a table once and points the
rest at it, but `brill_parser.rows_from_brill_md()` expands the pointers
again, because the table is the same while the *context* guarding it is not.

**(2) The JSON is not richer than the markdown.** `/getresponses` returns 17
fields; the capture uses 6. Measured over 1,470 rows from 151 auctions:
`rule`, `parentName`, `auction`, `bindings`, `resolvedParentName`,
`isDenial` and `denialMeans` are populated **0.0 %** of the time, and
`resolvedMeans` never differs from `means`. `priority` is 91.7 % populated,
`means` 69.3 %, `postCondition` 36.1 %, `convention` 16.6 %, `artificial`
13.1 %. So nothing material was dropped — the markdown is not a lossy
view of a structured original.

**(3) `/inferresponses` is real new content, and it is worthless here.**
This endpoint returns meanings for calls the system does *not* define —
e.g. after `1H-P-*`, Brill does not define `6C`, and infers
`(C_slam and StrongRebiddable('C')) or monsterslam('C')`. It cannot be
crawled: it requires an explicit `bids=` list and 400s without one.
`research/brill_infer_audit.py` asks it about every undefined call at every
captured position and pushes each answer through the converter:

```
inferred rows            : 9,798
  would emit a DSL rule  :    99  (1.0 %)
  all clauses dropped    : 9,699
```

The 99 that convert are all bare suit-length tests with no strength
requirement — `1C-1H` → `2S` inferred as `S >= 4`. Adding them would
*relax* the system, which §6.40's "drop a clause, never relax one" rule
exists to prevent. **Not captured, deliberately.**

**Staleness check.** The engine was rebuilt during this work
(1,037,464 → 1,040,694 rules). A row-level diff of the two captures over all
316 positions found **zero** content changes — the only difference anywhere
is a stray trailing backslash in one expression. The earlier "+23 new rows"
was whitespace.

### 6.44 Measured against Brill's own engine: 69.3 %, and the wall is higher than it looked

Every check until now was indirect — does a rule parse, does a condition key
exist, do eight hand-picked cases come out right. None of them said how often
`brill.dsl` actually agrees with Brill. Brill's `/bid` endpoint does:

```
GET /bid?hand=AKQ2.J54.T98.762&ctx=1H-P&seat=S&dealer=N
-> {"bid": "1S", "requires": "totalpoints >= 6 and spades >= 4
    and (spadelongest or hcp < 12)", "means": "4+ spades, 5+ hcp"}
```

`research/brill_live_check.py` uses it to put the two side by side: for every
captured position, take N random hands, ask Brill, ask `brill.dsl` through
`DecisionNet.actions()`, and compare. Dealer is pinned at North, so the hand
to act is N + (calls already made) — opener North, second seat East, third
seat South, which is also what `auction_context()` assumes.

**2,528 comparisons (316 positions x 8 random hands):**

| | |
|---|---|
| exact top-1 | **69.3 %** |
| in top 3 | 70.3 % |
| anywhere in the candidate list | 70.3 % |
| dsl silent | 0.0 % |

Two things fall out of that. First, the DSL is never mute — it always offers
*something*, it just offers the wrong thing. Second, top-1 and "anywhere" are
within a point of each other: **when the DSL misses, Brill's call is not in
its candidate list at all.** That is the fingerprint of dropped clauses, not
of bad priority ordering, and it is direct confirmation that
"drop a clause, never relax one" is doing what it claims.

**Where the 30 % goes.** Attributing each miss to the atoms that block every
disjunct of the winning `requires` (so this is weighted by how often a rule
actually fires, unlike §6.42):

```
penalty          186      preemptgame()     76
game             141      slammish          54
cansacrifice()    95      *_compgame        86
makessense        79      stoppersOK        24
verdict-shaped: 72 % of all blocker occurrences (79 % counting makessense)
```

**So the wall is bigger than §6.42 measured.** §6.42 said ~23 % of rows are
blocked by Brill's verdicts; by *impact* it is ~72–79 %. And `/bid`'s
`analysis` field shows why it is structural, not merely undocumented: the
engine annotates these answers `(GameEval)` and prints sampled hands
alongside them — `cansacrifice` and the `*_compgame` family are evaluated
against a *deal*, not against our hand. No hand feature can reproduce them.

That reorders the work. §6.42's tiered list is row-count ranked and it
misleads:

- `penalty` — 7 % of all comparisons, the single biggest blocker, and it
  gates the doubles that dominate the most-missed list. Not in §6.42's table
  at all.
- `cansacrifice()` — 3.6 %.
- longest-suit (`clublongest` &c.) — nominally +78 rows, but 0.4 % by
  impact. Not worth doing first.
- `loserlevel` — +226 rows in §6.42, 1 blocker occurrence in 2,528.

**Two semantics pinned empirically**, which `/bid` makes possible because the
answer *is* the engine's verdict rather than a guess:

- `clublongest` is **non-strict** — no other suit longer. A 4=3=2=4 hand with
  13 HCP opens 1C, so clubs merely tying spades is enough. (This matters: the
  strict reading would have been the "safe" guess and it would have been
  wrong.)
- `ruleof21` is `hcp + two longest suits >= 20`, despite the name. At 11 HCP,
  5-4-3-1 (sum 20) opens 1S and 5-3-3-2 (sum 19) passes. One anomaly is
  unresolved: 5-2-2-4 (sum 20) passes, so either the formula has a term I
  have not found or another rule is overriding — do not encode it until that
  is resolved.

**What this does and does not measure.** The hands are uniformly random, so
this is *rule-logic fidelity* — how completely the conversion reproduces
Brill's decisions over the whole hand space. It is not board-level playing
strength, which is what §6.40 measures (brill.dsl finishing 8/12). A position
like `4C-4S` is probed with hands that would never reach it in real play.

### 6.45 `penalty` is the biggest blocker, and it cannot be fitted either

`penalty` is 7 % of all comparisons — more than any other atom — and it gates
the doubles that dominate the most-missed list. It was also the one blocker
that looked like it might be a *hand* feature rather than a deal verdict,
because a penalty double is classically a trump-stack decision: length and
strength in their suit.

At 28 positions Brill offers exactly two options — a double gated solely on
`penalty` at priority 90, and a pass below it — so Brill bids X **iff**
`penalty` is true. That gives clean labels from `/bid` with no inference.
`research/brill_fit_penalty.py` collected 1,120 of them (28 positions x 40
random hands, levels 2–5, 24 % positive) and fitted a decision tree over
hand features plus trump-suit-relative ones.

| depth | held-out AUC | precision @ recall ~0.6 | best high-precision point |
|---|---|---|---|
| 3 | 0.93 | 0.61 | 0.70 @ 0.49 |
| 4 | 0.93 | 0.61 | 0.86 @ 0.27 |
| 5 | 0.91 | 0.64 | 0.75 @ 0.46 |
| 6 | 0.90 | 0.63 | 0.75 @ 0.42 |

The ranking is good; the decision rule is not. Both ends of the trade-off
are bad: **at usable recall the rule adds one wrong double for every two
right ones, and reaching 0.86 precision means giving up three quarters of
the doubles.** The residual is not noise — whether a penalty double is right
genuinely depends on partner's hand and on how the play goes, so it is not
recoverable from our thirteen cards.

So `penalty` is left untranslated. Encoding a 0.6-precision rule would
*relax* brill.dsl, which is exactly what "drop a clause, never relax one"
exists to prevent.

The broader consequence matters more than the atom itself: this is the first
verdict anyone tried to fit, and it failed the same way the §6.44 evidence
predicted — the `(GameEval)` annotations, the sampled hands. `cansacrifice`,
`game` and `*_compgame` should be expected to behave identically. Treat the
~72 % verdict wall as **structural**, and stop planning to climb it with
hand features.

The 6- and 7-level positions are excluded from the fit: there the double
sits at priority −900, i.e. it is a fallback rather than a winner, so
"X iff penalty" does not hold.

### 6.46 The misses split three ways, and only one of them is the wall

§6.44 attributes misses to dropped clauses. That is only part of it. Taking
all 750 misses and asking what actually went wrong:

| class | n | % of misses | reachable? |
|---|---|---|---|
| blocked only by Brill verdicts | 429 | 57 % | no — §6.45 |
| rule *was* emitted, but did not fire | 239 | 32 % | **yes, probably** |
| blocked by a mix incl. non-verdict atoms | 65 | 9 % | partly |
| no rule emitted at all | 17 | 2 % | yes (redoubles at 6X-X) |

The middle class is the interesting one and §6.44 is blind to it. Those
rules translated — brill.dsl contains them — they just do not fire on hands
where Brill's version does, which means the translation is **stricter than
the original**. Dropping clauses cannot do that; only a wrong translation
can.

Two thirds of that class (158 of 239, 6.3 % of all comparisons) contain an
atom the converter marks APPROXIMATE — `X_points`, `losers`, `balish`,
`stopper`, `quicktricks`. Those are the prime suspects.

**`X_points -> X_hcp` is provably wrong.** At `1C-2N`, the 3C rule is
`C >= 4 and C_points >= 7 and C_points <= 11`; Brill bids 3C on
`J3.T4.J765.AQT96`, whose clubs are worth 6 HCP. `club_hcp >= 7` is false,
and brill.dsl duly passes.

**What it might be.** `1H-1N` gives a clean read, because 4H there is top
priority and gated on `H_points >= 11 and H >= 4`. Sweeping heart length
against heart HCP (20 hands):

| heart length | 4 | 5 | 6 | 7 |
|---|---|---|---|---|
| min HCP that bids 4H | never (≤10 tested) | 9 | 7 | 6 |

That is exactly `H_points = suit_hcp + 2 × (suit_len − 4)` — 20/20 hands
fit, including all the near-misses. But it contradicts the `C_points` case
above, where `QJ82` (4 clubs, 3 HCP) would give 3 and cannot reach 7, yet
Brill bids 3C. **Unresolved.**

The reason it is unresolved, and the caveat for anyone using this harness:
**`/bid`'s `requires` is an explanation hint, not a verified firing
condition.** The very first probe returned `requires: H >= 6` for a hand
with three hearts. It is usually right — the 1H-1N sweep is far too
monotone to be noise — but it cannot be treated as ground truth, which is
why the two `X_points` readings disagree.

So `X_points` has deliberately **not** been changed. The mapping that fits
the good data, `suit_hcp + 2*(len-4)`, is *more permissive* than
`suit_hcp`, so adopting it on contested evidence would relax the system —
the one failure mode this project refuses. The next step is to settle it
with `/bid?details=true`, whose `analysis` array names the winning rule and
its requires explicitly, which removes the ambiguity the top-level field
has.

## 7. Roadmap (prioritized)

0. ~~Autonomous staged loop~~ — DONE (§6.5); run with `PYTHONPATH=.. python3 autoloop.py --tiers 24,96 --progress-secs 300`.
1. ~~Fix deep-M αμ accounting~~ — DONE (§6.1): exact boundary-only leaf architecture; searcher == native DD across seed sweeps.
0a. **Buy screening resolution (prerequisite for everything else).** §6.16: the 96-deal screen has a ±0.62–0.86 95% interval and a one-sided gate that accepts no-ops, so 28 rounds of "validated" patches random-walked `improved_system.dsl` to −37.9. **RE-SCOPED by §6.28 — do this first, and it is nearly free:** `mean_imp_loss` is `abs(deviation from par)`, so 54.9% of it is out-performing par and the abs() cancels the signal exactly where two systems disagree in sign. Switching to the signed `mean_imp_diff` measures the champion→improved gap at **+1.267 ± 0.318 (t 7.81) on 836 boards**, where the abs metric gives a non-significant +0.071 on the same boards and needed 2,054 to reach t 3.26. (§6.34 correction: that ~3× resolution figure — an earlier draft said 14×, which divided by an unstable point estimate — is calibrated against the weak panel and does **not** survive a competent one, where signed and abs give t 1.78 and t 1.79. Adopt the signed metric because `abs()` is not a loss, not because it is cheaper.) **Third, and now the real prerequisite: fix the opponents (§6.34).** The panel is 10/8/15-rule skeletons while `system/` contains 183/166/159-rule hand-authored systems that have never been used, because they are a legacy dialect reachable only through `DecisionNet.wrapped_system` and are not picklable (rule tests are closures), so they cannot go to `spawn` workers. Against competent opponents the champion→improved gap falls from +1.266 to +0.465 and MISSED_GAME drops by a third — the flaw taxonomy itself is opponent-dependent. Add a `--panel legacy` option rather than replacing the panel, so the 28-version historical series stays comparable; and make the legacy systems picklable first.
1a. ~~**ID3 speedup learning**~~ — MEASURED AND CLOSED (§6.14): after fixing tree persistence, state harvesting, and `min_examples`, it still does not transfer at 96 deals on either base. Caveat: per §6.16 the screen could not have resolved a small true gain either, so this is "no detectable gain", not "proof of no gain".
1c. **Hand-authoring target: underbidding — refined by ablation** (§6.24, §6.25). Of champion's attributed loss, MISSED_SLAM (33.7%) + MISSED_GAME (32.6%) are ~66%; OVERBID_DOWN is most frequent (123 boards) but only 6 IMP/case. Only 12.4% of boards are at par and the worst decile holds just 22.8% of the loss, so it is a broad shortfall, not a fixable tail. Ablation (§6.25) then sharpened this three ways: (i) the 32 level-reaching rules are worth **+0.1835 ± 0.178 IMP/board** — the largest measured effect of any rule group — but they *also* account for 58 of 116 overbids, so the target is **discrimination, not aggression**; (ii) **slam is structurally unreachable** — champion's only 5-level calls are two never-firing sacrifice rules, so there is no cue-bid/Blackwood route to 6 (0 slams in 206 boards, par wanted 14); (iii) do **not** read the par gap as timidity — SAYC stops at 1–2 on 93.1% and improved on 76.2% vs champion's 67.3%, so champion is already the most aggressive and best of the three. Highest-value concrete work, **priced and reordered by §6.31**: reaching the
right **game** contract on ordinary hands is worth **−0.982 IMP/board** (215
boards at par level 3–4), about **2.3× the slam prize of −0.426** (50 boards,
6.0%) — slam is the more interesting defect but not the biggest. So: (1) game
accuracy at levels 3–4; (2) a live 5-level ladder (cue bids / Blackwood
responses), harder because multi-step conventions need stateful convention
memory (roadmap 4); (3) ~~the responder coverage hole~~ — **CLOSED by §6.33, do
not spend more here.** 34.3% of underbid boards are *one bid then three passes*
with 22–25 combined HCP, which made the hole look causal. It is not. Filling it
aggressively (§6.27) buys 17 games by adding 45 overbids; filling it
conservatively (§6.33) buys **0 games** and still adds 12 overbids
(−0.098 ± 0.042, t −2.36; ~209 interventions, −0.39 IMP each). Bidding on hands
champion chose to pass is worse than passing, however meek the bid.

1e. **Competition and defence are an unexamined first-class target** (§6.38) — **but read the caveat below before acting: `SOFT_DEFENSE` is a catch-all, not a diagnosis.** It is assigned in two places, and neither is a finding that competing was correct:
   - `diagnostics.py:191` — `if decl_is_ew or (contract is None)`. Any board the opponents declare, plus every passed-out board, is tagged SOFT_DEFENSE.
   - `diagnostics.py:221` — the **fallback**, for any board that lost more than 10 points and matched no other flaw.

   Its `severity_pts` is `abs(regret)` (`diagnostics.py:156`), the board's whole shortfall, not an estimate of what competing would have recovered. And because double-dummy par already prices the sacrifice option — par *is* the best result N/S can obtain under optimal bidding by both sides — a board where par belongs to E/W is by construction one where bidding on was not profitable. So the 19.9% conflates (i) genuine competitive errors with (ii) boards where E/W simply owned the hand and defence was always going to lose. Only (i) is actionable, and nothing yet splits them.

   This matters because the two most relevant measurements both point at "bidding more loses": §6.33 filled the coverage hole and got −0.098 IMP/board from ~209 interventions, and §6.27 got −0.027 with overbids rising 1:2.6. Split the category — for example by whether N/S held a makable contract of their own — **before** spending authoring effort here. The honest current reading is that §6.38 establishes defence/competition as a *large and unexamined* region, not as a *proven* one.
Under the default 10/8/15-rule panel, SOFT_DEFENSE is 8.5% of attributed loss
and 192 boards — a minor category. Under the 183/166/159-rule legacy systems it
is **19.9% and 286 boards, the most frequent flaw of any**. Opponents that
cannot bid give us nothing to compete over, so the panel hid the category
entirely. Roughly: missed game + missed slam is 67.3% of loss on the skeleton
panel but **55.2%** on the realistic one. Note this does **not** disturb the
game-first ordering — that was re-derived and survives (§6.38). Any authoring
plan built on the skeleton-panel attribution should be re-read before use.

1d. **The actual gap: slam infrastructure at the 5 level, not a ladder in general** (§6.39, correcting §6.33). ~~"what is missing is a bidding ladder"~~ — refuted by direct inspection: champion has **29 raise rules** and **21 level-4 rules**, including `1S→2S`, `1S→3S` (limit), `2S/3S→4S`, `2S→4S`, `1M→4M` — the ladder to game is already there, so "build a ladder" would have been the wrong instruction. What is absent is the **5 level**: exactly two level-5 rules (`SUP_SACRIFICE_5C/5D_OVER_4M`, both requiring `opp_last_call in ['4H','4S']` and `is_vulnerable == False`), and six level-6 rules that jump straight to 6 on 20–23+ HCP. No Blackwood ask, no 5-level cue bid, no slam try — which is exactly why §6.25 measured 0 slams in 206 boards and §6.38 finds MISSED_SLAM the largest and most stable category (34.4%). **Concrete work:** a 4NT ace-asking bid with 5-level responses, or 5-level cue bids — small, well-understood, currently absent. Champion's residual *game* shortfall is a different problem, guard thresholds rather than structure (e.g. `SUP_GAME_4S_AFTER_RAISE` needs hcp 16–22 *and* 5+ spades, so a 15-count has no rule and stops at 2S). Ordering unchanged: game first (§6.31/§6.38).

1d-old. ~~**The actual gap: a bidding ladder, not a candidate or a patch**~~ (§6.33,
synthesis). Champion stops at the 1–2 level on 67.3% of boards **with** its
rules firing (§6.25), and inserting a call where no rule fires does not reach
game either (§6.33) — because the rest of the ladder still stops low. Every
mechanism in this repo — candidate generation, PIDM search, ID3, co-training,
convention invention — optimises **one decision in isolation**. Reaching game
requires a *sequence*: opener bids, responder raises, opener accepts. Nothing
here produces or evaluates sequences, which is the most economical explanation
for why 28 automated rounds added nothing and one human writing 90 rules added
+0.275. Two concrete consequences: (i) an evaluation metric that scores the
**final contract** rather than per-decision deviation would at least make ladder
work measurable — the h2h harness (§6.30) already plays both seats and is the
natural place; (ii) multi-step conventions need the stateful memory in roadmap
4 before a ladder can be authored at all. Budget this as a design change to the
improvement loop, not as another patch family.

1b. **The improvement approach itself is the problem — no lever has leverage** (§6.19–§6.23). Measured, paired, 400–2,054 boards: curated rule families +0.03 best (3 of 7 exactly zero); stronger sampling −0.030; deeper lookahead exactly 0.000; ID3 negative; **and ablating the search entirely costs −0.017 ± 0.013 (CI upper +0.009)**. φ(s) is a singleton at 92.8% of decisions, so the rules decide and the search barely runs (§6.21); and the ambiguous 7% is *not* where the value is (§6.22). The only thing that has ever moved this system is a human writing better rules (+0.275). Any further work should start by re-examining the premise that candidate generation + search hill-climbing can improve a rule set, rather than by adding families or buying more search.
2. **Flywheel on the SDS objective at scale** — `--sds-primary` exists; needs larger deal sets + faster leaves (batching per design doc K10).
3. ~~RBMBMC-conditioned SDS worlds~~ — DONE (§6.5). Next level: weight worlds by inconsistency (soft posterior) instead of hard elite cut.
4. **Stateful convention memory in DecisionNet** — multi-step conventions (RKCB continuations) currently rely on fragile feature chains; a small protocol-state stack would remove the context-leakage class entirely.
5. ~~DSL round-trip fidelity~~ — DONE: `RESOLVED_CALL` export/import verified.
6. **Defense-side roots** for play search (design-doc open question #1).
7. **Truncated-PIMC speed knob** — needs reliable mid-trick solving (own alpha-beta or upstream dds3 fix); earlier budget sweep was invalidated by the dead-search bug.
8. **Reseed from champion, and retire `improved_system.dsl`.** champion_system.dsl is the strongest known system and is hand-authored; improved_system.dsl is 28 rounds of flywheel output and is worse by **+0.275 ± 0.084 IMP/board** (§6.18). The gain from reseeding is real but ~4x smaller than the 1.069 originally quoted, so treat it as a modest but genuine edge rather than a transformation. Deleting the file is the author's call — the recommendation is to stop improving it and start from champion instead. **Now confirmed against opponents that can actually bid (§6.37):** at 2,006 boards champion leads by **+0.732 ± 0.265 (t 5.41)** on the signed metric against the 183/166/159-rule legacy systems, and by +1.246 (t 11.85) against the default skeletons. A second, independent reason to prefer champion: its signed score is **panel-invariant** (+0.6281 vs +0.6291 across the two panels), while improved's swings by 0.515 — champion's strength does not depend on who it is playing, improved's does. Note also that §6.37 overturns the *reason* usually given for improved's weakness: under competent opponents the two miss essentially the same number of games (161 vs 166), so the deficit is overbidding and defence, not underbidding — which means a "fix the underbidding" effort aimed at improved would be aimed at the wrong thing.

---

## 8. Usage quick reference

```bash
# leaderboard with true-DD and SDS two-hand columns
PYTHONPATH=.. python3 eval_vs_dds.py --boards 48 --no-stratified --sds

# continuous improvement (auto-generates patches, caches failures, versions saves)
PYTHONPATH=.. python3 flywheel.py --deals 48 --rounds 3 --pool-cap 14 --sds
PYTHONPATH=.. python3 flywheel.py --deals 32 --rounds 2 --pool-cap 8 --sds-primary

# board-level report (hands, auctions, DDS par)
PYTHONPATH=.. python3 export_results.py --deals 64 --seed 42 --out report.txt

# targeted board replay
PYTHONPATH=.. python3 show_bids.py 1 16 21 22
```

---

### 6.47 `research/dsl-design.md` reviewed — mostly already built; adopt 2 of 12 sections

The design doc proposes a semantic/intent DSL: bidding operators,
`ACTION(intent, target, constraints)`, an `encode()` slot layer, a semantic
state carried through the auction, and bid equivalence classes for search.
Verdict: **do not rewrite the DSL.** Roughly two-thirds already exists.

- **§2/§6/§7/§10 already exist.** `bid/protocol.py`'s
  `ProtocolStep(op_type, trigger_sequence, target_feature, call_mapping)` *is*
  `ACTION(...)` plus `encode(...)`. `ProtocolOpType` carries
  SHOW/ASK/COMMAND/TRANSFER/ENCODE/CONCEAL/AMBIGUATE/POOL; 11 convention
  factories (Stayman, Jacoby, Texas, Blackwood, Drury, Michaels, Unusual 2NT,
  Cappelletti, Smolen, Gambling).
- **The "invent conventions" payoff already exists.** `convention_search.py`
  hill-climbs protocol space: retarget-the-feature mutates the semantic layer,
  swap `call_mapping` / shift ranges mutates the encoding layer.
- **§4's premise is false here.** The doc assumes search branches over ~30
  legal calls. `DecisionNet.actions()` returns only calls from *matched*
  rules, so φ(s) already banks that compression.
- **§8 was genuinely missing** and is the one real win — see below.

**Latent bug found and fixed.** `ProtocolStep.generate_rules()` built
conditions only from `target_feature`/`val`; `op_type` was cosmetic and
`trigger_sequence` was **never compiled into any condition**. Stayman lowered
to a bare `heart_len >= 4 -> 2H` and Blackwood to `ace_count == 2 -> 5H`, both
firing on every auction including the opening seat. Fixed: the trailing calls
now compile to `partner_last_call` / `my_last_call` / `opp_last_call`
conditions, with an explicit `trigger_seats` where the default inference is
wrong (Michaels, Unusual 2NT and Cappelletti have an opponent's call in the
sequence). Two tests passed only because of the bug and were made seat-correct.
Harmless in practice only because **none of the 11 conventions reach a shipped
system** — grepping `stayman|blackwood|jacoby|texas|smolen|cappelletti` in
`improved_system.dsl` (75 rules) and `championship` (90) returns zero hits.

Also added: `DecisionNetRule.intent`, emitted and parsed as an `INTENT:` line.
Execution stays flat; intent is metadata for convention/explain tooling.

**Adopted (§8):** `agreed_trump`, `agreed_trump_len`, `has_trump_king`,
`has_trump_queen`, `keycard_count_agreed` in `bid/features.py`. `agreed_trump`
is the most recent suit bid by EITHER member of our partnership — not "both
bid it", which is `our_fit_shown` and too strict: after `1C-1H-4N` trump is
hearts even though opener never raised. This is the §6.41 prerequisite, and it
fixes a real off-by-one: `keycard_count_1430` was stubbed to `ace_count`, so
it was wrong whenever the hand held the trump king.

**Not adopted:** the `WHEN/IF/DO` + `ENCODE` surface grammar as the on-disk
format, and §11/§12 (hierarchical intent search, equivalence classes) until
branching is actually a cost. A second language means a second parser for
`lint_dsl.py`, `translator.py`, `eval_vs_dds`, `brill_to_dsl` and `web/`'s
20 JS files — and 72–79% of the fidelity gap is Brill's deal-level verdicts,
which are hand-*evaluation* primitives that no encoding layer touches.

### 6.48 Where the Brill gap actually is: 69% dropped, 30% mistranslated, 1% missing

`research/brill_miss_classify.py` (new) splits every disagreement three ways
using the cached live bids. On 2,564 comparisons (70.2% agreement):

| class | n | % of misses | meaning |
|---|---|---|---|
| `CONTEXT_MISMATCH` | 530 | 69.3 | no rule bids that call at that auction — the row was dropped in translation (verdicts) |
| `ENF_TRUE_BUG` | 230 | 30.1 | a rule for that call and auction exists and its auction conditions hold, but a hand condition failed — *our* rule is stricter than Brill's |
| `NO_RULE` | 5 | 0.7 | nothing at all |

`ENF_DROPPED_CLAUSE` was measured as a separate class (rule exists, but Brill
fired a disjunct we dropped) and came out at **0** — Brill's `/bid` returns the
winning rule's own expression, so when it wins via a verdict the `requires`
says so and the case lands in `CONTEXT_MISMATCH` instead.

Before acting on the 230, two things were checked and both came back clean:
every one of the 1,552 rules fires at exactly **one** captured position (no
dead rules, no cross-position leakage), and 1,080 of 2,459 `(position, call)`
pairs are reachable at all — the other 1,379 are rows dropped for blocker
atoms. So the auction gating is sound; the gap is atoms, not plumbing.

`ruleof21` is now a feature (see §6.49). It bought 9 rules and **zero**
measured agreement: opening passes were already covered by DecisionNet's
default-PASS fallback, and the new 1C/1D rules require an exact 4333/4432
shape. Correct, but not where the loss is.

### 6.49 `ruleof21` is now translatable — and why it is one boolean, not two conditions

Brill emits a single `ruleof21` boolean (23 occurrences), including
`not ruleof21`. It was dropped as an unpublished macro. Per Brill's own
prose: HCP + the two longest suits >= 20 **and** two quick tricks; in 3rd/4th
seat 1½ quick tricks suffice ("the rule of 21 ½").

Implemented in `bid/features.py::extract_all` as `rule_of_21` (bool) plus
`rule20_total` (int), and mapped in `brill_to_dsl.BOOLS`.

It is deliberately **one boolean rather than two conditions**. Brill also
writes `not ruleof21` — its "No opening bid" pass rule and the weak-two
denies. `translate_literal` can only negate a bare boolean
(`x == True` -> `x == False`); a conjunction is returned as `ALT` and
negating an `ALT` is `SKIP`, which would silently drop those clauses. The
seat rule sits inside the feature for the same reason: with no bid yet, the
number of calls in the history is the number of passes, so
`is_opening and len(history) >= 2` identifies 3rd/4th seat.

**The threshold is 21, not the 20 in the prose — measured.** 400 probed
opening hands (`hcp <= 11` so the HCP>=12 route cannot apply, no 6+ suit so
no weak two or preempt can fire, quick tricks held at >= 2):

| total (hcp + two longest) | n | passed | opened |
|---|---|---|---|
| 14–19 | 313 | 313 | 0 |
| 20 | 75 | 64 | 11 |
| 21 | 12 | 0 | 12 |

Every pass came back with `requires` = `hcp < 12 and not ruleof21`. Brill's
own `explanation` prints the condition as `RuleOf >= 21`. So the classic
rule-of-20 *quantity* is compared against **21**. The 11 openings at total 20
are 1H/1S and go through `Opening1H`/`Opening1S`, which we drop anyway.

Caveat: with this quick-trick table (AK=2, AQ=1.5, A=1, KQ=1, guarded K=0.5)
a hand that reaches 21 almost always holds 2 quick tricks anyway, so the
3rd/4th-seat 1½ relaxation rarely binds.

### 6.50 `X_points` could not be fitted — and the tooling traps behind that

`X_points -> X_hcp` is the single largest family in the ENF_TRUE_BUG class
(diamond_hcp>=7 x29, spade_hcp>=10 x23, heart_hcp>=10 x21, spade_hcp>=6 x15,
club_hcp>=6 x10, diamond_hcp>=6 x10). Three attempts to fit the length
adjustment all failed, for reasons worth recording so nobody repeats them:

1. **Probing by returned bid is confounded.** At `1H-1N` (row
   `4H: H_points >= 11 and H >= 4`) the minimum heart HCP that produced a 4H
   bid was **0** at every length from 4 to 6 — weak hands also bid 4H, via a
   different rule entirely. The bid alone never tells you which rule fired.
2. **`requires` is a hint, not ground truth** (§6.46).
3. **`details=true` is not the fix** — its `analysis` array lists candidate
   rules considered, not only the winner, so substring-matching it reports
   `H_points` for ~50% of all hands including ones with 0 heart HCP.

Until Brill exposes the winning rule id unambiguously, `X_points` stays an
approximation. It is documented in the DSL header and errs in the safe
direction (underbids), so it is left in place rather than guessed at.

### 6.51 `*_is_longest` recovered: 1,561 -> 1,676 rules, fidelity 70.2% -> 71.1%

Brill expresses "suit X is the longest" four ways, 171 occurrences in total:
`Xlongest` (42), `bestsuit('X')` (29), `bestmajor('X')` (60),
`bestminor('X')` (40). All were dropped, because the natural translation
`X_len >= longest_suit_len` is a FEATURE-TO-FEATURE comparison and the DSL
only compares a feature against a constant — the RHS would be parsed as the
literal string `'longest_suit_len'`.

`bid/features.py` now precomputes them as booleans:
`{c,d,h,s}_is_longest`, `{h,s}_is_best_major`, `{c,d}_is_best_minor`.

**Ties count as longest**, which is not a guess. Brill's own row

    diamondlongest and not (diamonds >= 5 and (spadelongest or heartlongest))

only has a meaning if a 5-5 tie marks *both* suits longest — that is
precisely the case the `not` clause exists to exclude. `bestmajor`/`bestminor`
are given the same tie convention for consistency.

Measured on the same 2,564 cached comparisons (a fixed, matched sample, so
this is a deterministic delta rather than sampling noise):

| | rules | agree | CONTEXT_MISMATCH | ENF_TRUE_BUG |
|---|---|---|---|---|
| before | 1,561 | 1,799 (70.2%) | 530 | 230 |
| after | 1,676 | **1,823 (71.1%)** | 498 | 238 |

+115 rules, +24 agreements. The header's earlier estimate of "~55 rules" was
low. This does **not** recover the 1H/1S openings, which remain blocked by
`Opening1H`/`Opening1S`.

### 6.52 What is left, ranked by clauses freed (`research/brill_atom_cost.py`)

`brill_atom_cost.py` (new) answers "which feature next?" with a number. For
each DNF clause it finds the literals that fail to translate, and credits an
atom when it is the *only* blocker — so the count is "clauses freed by
implementing exactly this atom". 4,315 clauses in 3,052 rows:

| atom | solo | notes |
|---|---|---|
| `realsolid()` | 256 | suit quality — hand-computable, **probeable** |
| `trump()` | 190 | suit quality — hand-computable, no clean probe row |
| `cansacrifice()` | 151 | deal-level verdict |
| `monsterslam()` | 123 | deal-level verdict |
| `CanBid7NT` | 119 | deal-level verdict |
| `loserlevel` | 115 | LTC-ish; already known low impact (1 hit in 2,528) |
| `slammish` | 99 | strength verdict |
| `monstergrand()` | 95 | deal-level verdict |
| `penalty` | 93 | rejected in §6.45 (AUC 0.93 but precision 0.61) |
| `preemptgame()` | 92 | deal-level verdict |

The list confirms the split in §6.48 from the other direction: the top of the
board is Brill's deal-level verdicts, which depend on partner's hand and the
play and are not reproducible from one hand. That is structural, not a
shortfall in the converter.

**Two of the top three are hand properties and worth attempting**, and both
have rows where the co-conditions are already translatable, which makes them
probeable without the §6.50 traps:

    realsolid     :  1C -> 6D   (realsolid('D') and losers == 1)
    twicerebiddable: 1C-1N -> 2D (twicerebiddable('D') and hcp >= 3 and hcp <= 8)

Hold `losers == 1` (LTC) / the HCP window fixed, vary the suit, and the
returned call says whether the predicate held. `realsolid` alone is 256
clauses — the largest single win still on the table.

These are deliberately **not** guessed at. A wrong `realsolid` would make the
system bid slams on hands that do not have them, which is overbidding — the
one direction this conversion has so far avoided ("it will underbid rather
than overbid, which is the safe direction"). Probe first, or leave dropped.

**First probe attempt failed — record it.** Seven `realsolid` holdings were
constructed at LTC exactly 1 (`AKQx`, `AKQxx`, `AKQxxx`, `AKxx`, `AKxxx`,
`AKxxxx`, `AQxx`) and tried against all four suits at `1C`. Brill answered
**double in every one of the 28 cases.** At that position a penalty double
outranks the 6X rule, so the row is unreachable in practice and the returned
call cannot reveal whether `realsolid` held. A usable probe needs a position
where no double is available — or, better, Brill exposing the winning rule
id directly. Note this also means recovering `realsolid` may buy less than
 256 clauses suggest, since some of those rows are likewise outranked.

### 6.53 `realsolid` recovered — and it buys 0 measured fidelity

**The probe route.** §6.52's first attempt failed because Brill doubled all 28
probes: at `ctx=1C seat=E` a takeout double outranks the 6X rule, so the
returned call cannot say whether `realsolid` held. The fix is to stop reading
the *bid* and read the **`requires`** instead — `/bid` echoes the winning
rule's expression, and the realsolid rule has *higher* priority than the
double. So the position becomes a clean 1-bit readout:

    requires mentions realsolid  -> predicate held
    requires is the double OR    -> predicate was false

**The fitted predicate.** Hold `losers` at exactly 1, pin the three side suits
to a fixed filler, vary only the target suit. 36 structured probes plus 350
randomised held-out hands, 350/350 agreement:

| honours beyond A-K | minimum length |
| --- | --- |
| AKQJ | 6 |
| AKQT | 7 |
| AKQ | 8 |
| AKJ (ten irrelevant) | 9 |
| AK / AKT | never (tested to length 10) |

Ace **and** king are both mandatory — `AQJ987654` (9 cards, no king) and
`KQJ98765` (8 cards, no ace) are both false. The ten only counts when the
queen is present and the jack is not: `AKQT987` is true, `AKJT987` is false.
Spot-card height is irrelevant — `AKQ5432` and `AKQ9876` are both false,
`AKQT543` and `AKQT987` both true.

The obvious guess, "AKQ and 6+", **over-bids**: it accepts `AKQ432`,
`AKQT32` and `AKQ5432`, all of which Brill rejects. It was rejected for that
reason. So was every additive scoring rule tried (any `L + Σhonour-weight`
form contradicts `AKQT` > `AKJT` at length 7 while `AKQJ` > `AKQ` at length
7 demands the opposite ordering). The table above is therefore stored as a
literal decision table, not a formula, and
`tests/test_features_and_state.py::test_realsolid_matches_brills_measured_table`
locks all thirteen cases.

**What it bought.** `research/brill_to_dsl.py` maps `realsolid('X')` to the
precomputed `x_realsolid` boolean. Rules 1,676 -> **1,932** (+256, every
realsolid row now emits). For the 128 rows written `realsolid(X) or trump(X)`,
only the realsolid disjunct translates, so those emit a *subset* of Brill's
condition — the safe direction, it can only underbid. `realsolid()` has
dropped off the §6.52 blocker ranking entirely; `trump()` is now #1 at 190.

**It bought no measured fidelity.** Same 6,320 comparisons, run before and
after from a complete cache:

| | rules | exact top-1 |
| --- | --- | --- |
| before | 1,676 | 4,488 / 6,320 (71.0%) |
| after | 1,932 | 4,488 / 6,320 (71.0%) |

That is not a bug. `realsolid and losers == 1` needs a hand with LTC 1 *and*
a 6+ suit headed by AKQJ: measured at **1 in 33,333 random hands**, so 0.19
expected firings in a 6,320-comparison sample. The 256 clauses were the
largest single item on the §6.52 board and they are worth ~0 on a random-hand
fidelity metric. Coverage and fidelity are different currencies, and §6.52's
own closing caveat ("recovering `realsolid` may buy less than 256 clauses
suggest") is now quantified rather than suspected.

**Side finding, not chased.** Brill's `losers` is not our
`losing_trick_count` for very long suits. Spades `AKJ987654` (9 cards, queen
missing) with `AK / A / A` alongside is LTC 1 by our count, but Brill fired
`realsolid('S') and losers <= 0`, i.e. it scored the hand 0 — it appears to
discount losers in suits longer than about 7. Every `losers`-gated rule
inherits that skew on freak hands. Out of scope here; flagged as follow-up.

### 6.54 Pricing the remaining atoms: `trump()` (#1 by clause count) is worth ~0

§6.53's lesson was that clause count and fidelity are different currencies —
the biggest atom on the board bought 0. `research/brill_atom_value.py`
(`--hands 200 --top N`) turns that into a tool: for every DNF clause blocked
by **exactly one** atom it translates the *rest* of the clause and Monte-Carlos
how often those co-conditions hold at that row's auction position. The result
is an upper bound on the clause's fidelity contribution — it assumes the
unknown atom is true whenever its co-conditions hold, ignores
higher-priority rules, and treats `ALT` as satisfied. A clause priced at 0
cannot be worth implementing whatever the atom means.

**Calibration.** `--calibrate` re-runs the pricer pretending `realsolid` is
still untranslated. It prices at **0.20 agreements out of 6,320**; §6.53
measured the true gain as **0**. (Independent check: 200k random hands put
`realsolid and losers == 1` at 1 in 33,333, i.e. 0.19 expected firings.) The
pricer would have flagged the board's largest item as worthless *before* the
session was spent on it. `trump()` prices at **0.20** too.

That is not a coincidence: **all 190 `trump()` rows contain a `losers` gate**,
so they inherit the same throttle. `trump()` is now #1 on the §6.52 clause
board and is worth ~0. Do not implement it.

| atom | rows | gated bound /6,320 | verdict |
| --- | --- | --- | --- |
| `trump()` | 190 | 0.20 | **do not implement** — all rows gated by `losers` |
| `solid()` | 1 | 0.00 | do not implement |
| `twosuited` | 4 | 0.00 | do not implement |
| `Fit()` | 4 | 0.60 | do not implement |
| `IsGoodSuit()` | 4 | 0.80 | do not implement |
| `Balanced` | 3 | 1.60 | marginal |
| `singlesuited` | 23 | 2.40 | marginal |
| `CombinedHcpMin` | 9 | 3.10 | marginal |
| `TwiceRebiddable()` | 5 | 4.10 | marginal |

**Everything with real headroom is a deal-level verdict.**
`monsterslam()` 510, `monstergrand()` 510, `CanBid7NT` 510, `CanBid6_D` 248,
`CanAsk_D_RKC` 248, `slammish` 231, `diamondslam` 215, `game` 183. These are
§6.48's structural wall: they depend on partner's hand and the play, and are
not computable from one hand. The gated bound cannot rescue them, and the free
bound (clause count x 20) is not evidence either — it only says the clause
carries no co-conditions.

**Conclusion.** At the hand-feature level the Brill conversion is finished.
71.1% is not a plateau that more atom recovery will lift; the remaining 29% is
the deal-level wall plus Brill's own deal verdicts. The two moves that could
still move the number are the ones §6.48 already identified — either accept
71.1%, or route past the wall by scoring candidate systems on deals with
`bin/libdds.dylib` instead of matching Brill call-for-call.

---

### 6.55 Brill API connector (`src/bid/brill`)

A typed, stdlib-only client for `https://brillservice.aalborgdata.dk`, so the
local engine can query remote Brill instead of only comparing against a
converted snapshot. Docs in [`docs/BRILL_CONNECTOR.md`](../docs/BRILL_CONNECTOR.md);
65 offline tests in `tests/test_brill_client.py`.

**The published OpenAPI document declares no response schemas** — `/dd` is
typed as `Void`. Every dataclass in `models.py` was recovered by calling the
live service, and undocumented keys are kept on `.raw`.

**`/play` has three undocumented constraints**, read off its 400 bodies:

* `played` is **separator-free** (`"S7SA"`); a comma is *"has odd length"*.
* `hand` must be the **original 13 cards** — Brill subtracts `played` itself
  (*"has 12 cards (expected exactly 13)"*).
* Card 1 belongs to **declarer's LHO**, and the rest follow the *real* play
  order: the winner of each trick leads the next, so it is **not** a repeating
  N-E-S-W cycle. Brill validates each card against the seat it assigns to that
  position and names the seat in its error, which is how the ordering was
  recovered.
* Zero cards played is rejected outright — *"use the /lead endpoint instead"*.

`PlayState` maintains that ordering plus follow-suit legality and trick
accounting.

**End-to-end validation.** A full 52-card board driven against the live
service completed with no 400s at NS 12 tricks, exactly the `/dd` number for
the same deal (`1N` by N). Because Brill rejects any card whose seat disagrees
with its own assignment, a clean 52-card run is proof that `PlayState`'s
leader sequence matches the service's — this is a check on the connector, not
just a smoke test.

**Why this matters for fidelity work.** §6.53/§6.54 fitted Brill's atoms by
scraping `requires` strings through `/bid`. The connector makes that
repeatable and cacheable, and adds `/dd` for the deal-level ground truth that
§6.48 says is the only remaining route past 71.1%.

---

### 6.56 brill.dsl scored against DDS par — the conversion is not a system

`research/brill_dsl_value.py` (new). Everything measured about brill.dsl until
now was *agreement* with Brill's engine (71.1%, §6.54). That is the wrong
currency, and §6.54 already showed why in the small. This scores brill.dsl the
way every other system in the repo is scored: play full auctions, score the
final contract with native DDS, compare to par. 400 boards, resolution 0.39
IMP/board.

| system | rules | mean_imp_diff | mean abs IMP | passed out |
| --- | --- | --- | --- | --- |
| `brill.dsl` | 1,932 | −0.32 | 7.21 | **120/400 (30%)** |
| `champion_system` | 90 | −0.35 | 6.29 | 2/400 |
| hybrid brill→champion | 2,022 | −0.38 | 6.28 | 2/400 |

**The ranking depends entirely on the metric, and that is the headline.**

| paired vs brill.dsl (positive = other better) | abs dev from par | signed vs par |
| --- | --- | --- |
| champion_system | **+0.92** (t 4.31, CI 0.50–1.34) | −0.03 (t −0.09, CI −0.68–0.62) |
| hybrid brill→champion | **+0.93** (t 4.39) | −0.06 (t −0.18) |

On *absolute deviation from par* (the leaderboard metric, `mean_imp_loss`)
brill.dsl is significantly worse. On the *signed* metric — "am I beating par",
`mean_imp_diff`, which §6.28 recommends for exactly this question — it is a
**dead heat**, and the CI excludes everything beyond ±0.7.

The two disagree because brill.dsl is not worse, it is **wider**:

| | signed | abs | boards beating par | boards losing | boards < −5 IMP |
| --- | --- | --- | --- | --- | --- |
| brill.dsl | −0.32 | 7.21 | **179** (avg +7.70) | 198 | 124 |
| champion | −0.35 | 6.29 | 173 (avg +6.87) | **172** | 119 |

It beats par *more often and by more*, and loses *more often*. An earlier
draft of this section reported only the −0.92 and called brill.dsl worse;
that was metric-dependent and has been corrected here and in the generated
file header.

**brill.dsl is a first-call-only system.** All 1,932 rules carry
`my_last_call == 'NONE'`, so a hand's second turn matches nothing and falls
through to the DecisionNet default (PASS). Measured by replaying 200 boards
(1,727 real calls — `auction_coverage`, which counts calls actually made
rather than PIDM's internal `actions()` probes): it can make **485/800 = 60.6%
of first calls and 0 of the 927 later calls — 28.1% overall**. Auctions die
after one round and 120/400 boards (30%) are passed out.

**The part that did convert is worth ~nothing.** The hybrid uses brill.dsl
wherever a rule matches and champion everywhere else — the fair test, since it
holds continuations fixed. It is indistinguishable from champion alone on
*both* metrics (+0.93 abs / −0.06 signed, i.e. ~0.01–0.06 IMP/board). So the
gap is not "we need to recover more atoms": even the converted portion does
not beat a 90-rule system.

**A retracted claim.** The generated header in `system/brill.dsl` used to say
the system "will underbid rather than overbid, which is the safe direction".
That was an assumption, never a measurement. It is not simply false either —
underbidding here means passing out 30% of boards, but it also means avoiding
overbidding, and the two nearly cancel. The header now carries the measured
numbers with the metric stated explicitly.

**A caveat on the 71.1%.** `brill_live_check.py` samples only positions that
appear in `brill.md` — i.e. only the positions brill.dsl was converted from.
71.1% is therefore an *in-sample, first-call-only* figure. It was never a
claim about auctions, because brill.dsl cannot bid one.

**Confound to keep in mind.** In the hybrid, brill's rules are keyed on
`opp_last_call` / `partner_last_call` but the preceding calls come from
champion, whose 1C opening does not mean what Brill's does. Some incoherence
is expected, so "indistinguishable from champion" could in principle be two
errors cancelling. It does not change the practical answer — dropping brill's
rules into the champion buys nothing — but it is why this is not read as
"brill's opening logic is worthless in the abstract".

**Consequence.** Replaces §6.54's conclusion, but on narrower grounds than
first appeared. The case for retiring brill.dsl as a *system* rests on
structure, not on score:

* it can make 0% of second-and-later calls, so it cannot bid an auction;
* it passes out 30% of boards;
* grafting its converted rules onto a working system changes nothing.

It is *not* the case that it plays badly — on the signed metric it ties the
champion. So: treat brill.dsl as a *position catalogue* — a machine-readable
record of what Brill authors at 2-deep positions, useful for lookup,
comparison and teaching — and not as a candidate system. Atom recovery is not
merely low-value (§6.54); there is no system for it to improve.

If Brill's bidding is wanted as a playable system the only route is to capture
the tree far deeper than 2 calls. The hybrid result says that work cannot be
justified by an expected gain over the current champion — but note the
caveat below, which is the one thing that could still change that verdict.

**Caveat, and the reason not to over-read the hybrid.** In the hybrid,
brill's rules are keyed on `opp_last_call` / `partner_last_call` while the
preceding calls come from champion, whose 1C opening does not mean what
Brill's does. The two halves are therefore talking past each other, and
"indistinguishable from champion" could be coherence loss masking a real gain.
A clean test would let *both* sides bid Brill for the first round — i.e.
capture enough of the tree to run a self-consistent Brill auction — which is
the same-depth problem again. §6.57 runs that clean test by a different route.

---

### 6.57 Remote Brill vs the conversion — the target was worth chasing

`research/brill_remote_eval.py` (new). §6.56 asked whether to abandon the
Brill line. It was the wrong question, because it compared our *conversion*
against our own champion and never checked whether the thing being converted
is any good. This scores **remote Brill itself**: every seat asks `/bid` for
its call, the final contract is scored with native DDS against par.

Same 250 boards, seed 42, as §6.56's set (champion reproduces at −1.05 / 6.13
in both runs, which confirms the deal sets match):

| system | signed IMP vs par | abs dev from par | passed out |
| --- | --- | --- | --- |
| **REMOTE Brill (`/bid`)** | **−0.62** | **5.15** | **1/250** |
| champion_system | −1.05 | 6.13 | 0/250 |
| hybrid brill→champion | −1.04 | 6.37 | 0/250 |
| `brill.dsl` | −1.38 | 7.16 | 75/250 (30%) |

Paired vs champion on the same boards (positive = better than champion):

| | abs dev from par | signed vs par |
| --- | --- | --- |
| REMOTE Brill | **+0.98** (t 3.74, CI 0.51–1.45) | +0.43 (t 1.17) |
| `brill.dsl` | **−1.03** (t 3.81) | −0.33 (t 0.80) |

**Real Brill is better than our champion** — significantly on absolute
deviation from par, and directionally on the signed metric. It plays complete,
coherent auctions (1 pass-out in 250) and bids real sequences
(`1NT-P-2H-P-2S-P-3NT`).

**So the conversion destroyed the value, and the target is worth ~2.0
IMP/board of it.** On one common board set: remote Brill is +0.98 abs vs
champion, brill.dsl is −1.03. The gap between the engine and our rendering of
it is ~2.0 abs / ~0.76 signed. §6.56's "the converted portion adds nothing"
is therefore not evidence that Brill is weak; it is evidence that a 2-deep
rule capture throws away essentially everything that makes Brill good.

**How big a capture would be needed** (`research/brill_tree_size.py`, new).
The data is there — Brill authors 24 rules at `1H-P-1S-P`, North's *second*
turn — but the tree is wide:

| depth | positions (extrapolated) | mean calls | rules at depth |
| --- | --- | --- | --- |
| 0 | 1 | 34.0 | 44 |
| 1 | ~34 | 14.6 | 626 |
| 2 | ~496 | 6.9 | 4,070 |
| 3 | ~3,425 | 7.6 | 30,141 |
| 4 | ~26,031 | 5.0 | 143,172 |
| 5 | ~130,156 | 2.2 | 299,359 |

~477k rules through depth 5, within 2x of Brill's published 1,040,694 — a
sanity check on the extrapolation. Second calls begin at depth 4, so a useful
capture needs ~26k positions (~5 h of requests at 0.7 s each).

**Recommendation: distill, do not capture.** A deeper capture is ~26k requests
and still yields rule-shaped output that the DSL cannot express (§6.53's
dropped atoms). Distillation gets the same signal far cheaper: `/bid` answers
*any* position, so every evaluation run is also a labelled training set.
`--traces` on `brill_remote_eval.py` emits one `(position -> Brill's call)`
record per call, and because the responses are cached the 2,442-call dataset
costs nothing to re-harvest. That is the input for the existing ID3/learner
machinery, which is the natural next step.

**Caveat.** Brill's `/bid` was scored here playing itself on all four seats,
so this is Brill-vs-par, not Brill-vs-our-champion head-to-head at the table.
It says Brill reaches better contracts than champion does against par; it does
not say it would beat champion in a direct match.

---

### 6.58 Distillation pipeline (`research/brill_distill.py`)

§6.57 concluded "distil, do not capture". This is the pipeline that does it.
Traces of `(position -> Brill's call)` from `brill_remote_eval.py --traces`
are featurised with `BridgeFeatures.extract_all` — the same 121-key vector
`DecisionNet.actions()` uses, so learned rules are directly executable — then
fitted with the repo's own `ID3DecisionTree` and compiled with
`id3_tree_to_rules`, whose guard mechanism pins each tree to the position it
was trained on. Output goes through `export_dsl`, so it round-trips through
`load_decision_net_dsl` like any hand-written system. No unpublished atoms,
no tree crawl.

**Grouping is the one real design decision.** ID3 here splits only on
numeric/bool features, so it cannot partition on call *identity*
(`opp_last_call`, `my_last_call` are strings). Four groupings compared with
**5-fold CV** on the 2,442-trace pilot — a single 488-trace holdout carries
~2pp of noise, which is wide enough to manufacture differences, so the
estimate is averaged over folds (se ≈ sd/√5 ≈ 0.6–1.3pp):

| grouping | rules | 5-fold CV agreement with Brill |
| --- | --- | --- |
| none (one global tree) | 203 | **69.8%** (fold sd 1.4) |
| `is_opening` | 229 | 68.9% (sd 1.6) |
| `auction_len` × `last_bid_level` × `last_bid_strain` | 349 | 65.4% (sd 1.6) |
| `auction_len` | 516 | 64.0% (sd 3.0) |
| majority-class baseline | — | 61.0% (PASS) |

**Coarser wins at this data size, and the gap is real:** `none` beats
`auction_len` by 5.8pp against a ~1pp standard error. The finer keys fragment
1,954 examples into groups too small to learn from. This is a small-data
artefact and should be expected to flip once the trace set is in the tens of
thousands, so all four remain available via `--group`.

**Depth matters, and 8 is the sweet spot** (group `none`, 5-fold CV):

| `max_depth` | 3 | 5 | 8 | 12 | 16 |
| --- | --- | --- | --- | --- | --- |
| agreement | 63.0% | 68.3% | **69.8%** | 68.3% | — |

12 overfits; 16 exhausts memory and the process is killed (exit 137).

**The structural fix is confirmed.** The distilled system passed out **0/60
boards**, against brill.dsl's 30%. Whatever its bidding quality, it can hold a
full auction — which is precisely what the rule capture could not do.

**Clean pilot result: the distilled system already matches champion.** The
first board evaluation (60 boards) was contaminated — it trained on seed-42
boards 0–249 and scored seed-42 boards 0–59. Re-scored on **250 unseen boards
(seed 7, resolution 0.50)**, with the model trained only on the 2,442
seed-42 traces:

| | signed vs par | abs dev | passed out |
| --- | --- | --- | --- |
| distilled (207 rules, 2.4k traces) | **−0.48** | 7.16 | 6/250 |
| champion_system (90 rules) | −0.81 | **6.78** | 0/250 |

Paired (positive = distilled better): abs −0.38 (se 0.28, t −1.38), signed
**+0.33** (se 0.46, t 0.71). **Neither significant — i.e. a system distilled
from 2,442 traces is already indistinguishable from the repo's champion**,
which was produced by many flywheel iterations. It reproduces Brill's actual
call only 69.8% of the time, so this is a floor, not a ceiling.

That matters because §6.57 put remote Brill at **+0.98 abs vs champion**: there
is clear headroom above parity, and the only thing between here and it is
trace volume. The 2.4% pass-out rate (vs brill.dsl's 30%) confirms the
structural fix survives at board scale.

**Data is the binding constraint.** 2,442 traces at 62% passes gives +7.8
points over the majority baseline; that is a weak fit, not a broken one. What
is needed is volume, and it is cheap: `/bid` traces cost one request per call
and are cached, so scaling is a matter of wall-clock, not design.

Also added: `hand_from_pbn` in `bid/brill/convert.py` (the missing inverse of
`hand_pbn`, needed to feed Brill's answers back into the repo) with tests, and
incremental checkpointing in `brill_remote_eval.py` — a 1,200-board harvest is
~2.5 h and previously wrote nothing at all until it finished.

---

## 6.59 The distillation plateau, and where the ceiling actually is

§6.58 ended on "data is the binding constraint", promised a 1,200-board
harvest, and predicted that 5× the traces would beat champion. **Two of those
three are wrong.** Measured, in order:

### The learning curve is flat (data is NOT binding)

`brill_distill.py --learning-curve` (fixed 20% holdout, trained on increasing
fractions of the rest, group `none`, depth 8):

| train | 195 (10%) | 390 | 781 (40%) | 1172 | 1563 | 1954 (100%) |
| --- | --- | --- | --- | --- | --- | --- |
| fidelity | 61.5% | 62.9% | 66.2% | 67.2% | 67.0% | **67.4%** |

+4.7pp from 10%→40%, then **+1.2pp from 40%→100%**. Extrapolating to 12k
traces predicts ~+1–2pp, not the jump §6.58 assumed. Volume was the wrong
lever to pull.

### Model capacity is not binding either

Depth sweep, 5-fold CV on all 2,442 traces: depth 8 **70.6%**, 10 **69.9%**,
12 **69.7%** (se ≈ 0.9). Flat and within noise. Earlier, 16 exhausted memory.

### The learner was structurally blind — fixed, and it barely helped

`ID3DecisionTree.fit` kept only int/float/bool keys, so the most predictive
features in bridge — `partner_last_call`, `opp_last_call`, `my_last_call`,
`last_bid_strain` — were **unreachable**; they are strings. `group_key`'s
docstring had documented this and the `--group` machinery existed purely to
work around it.

ID3 now splits on string features: `== value` vs `!= value`, emitted as
`RuleCondition(k, "==", v)` / `("!=", v)`, both of which the DSL already
supports. Over-cardinality strings (> `MAX_CATEGORICAL_VALUES` = 40 distinct)
are refused so an identifier column cannot be memorised. 144 of 192 compiled
rules now use a categorical split, dominated by `partner_last_call` (120) —
exactly the ordering bridge intuition predicts.

Payoff: **70.6% vs 69.8% before (+0.8pp, se 0.89 — not significant).** So the
ceiling is neither data nor capacity nor the string blind spot.

### 400 boards: a dead heat with champion

Seed 7, resolution ~0.39, `group none`, depth 8, categorical splits on,
trained on the 2,442 seed-42 traces:

| | signed | abs | passed out | abs excl. pass-outs |
| --- | --- | --- | --- | --- |
| brill_distilled (199 rules) | −0.45 | 6.75 | 5/400 | 6.77 |
| champion_system (90 rules) | −0.34 | **6.67** | 2/400 | 6.65 |

Paired (positive = distilled better): abs **−0.07** (se 0.23, **t −0.32**),
signed −0.10 (se 0.37, **t −0.29**). Parity, and this time resolved well
enough to say so — §6.58's −0.38 abs gap was noise.

### "Fix the pass-outs" — refuted, and the refutation is the interesting part

Distilled passes out 5/400 vs champion's 2/400, and a passed-out board scores
0 against a par usually worth 9+ IMP, so this looked like most of the deficit.
It is not. Excluding pass-out boards leaves the gap **unchanged** (6.77 vs
6.65). The reason is that our pass-outs occur on deals where par is itself
≈0 — nothing was makeable, so passing cost almost nothing. Worth stating
because the plausible-sounding fix would have been to force openings on weak
deal, which would have cost IMPs.

### Class-balanced training: the §6.28 duality again

`--pass-cap 1.0` (keep at most one PASS trace per non-PASS trace) exists to
stop leaves collapsing to PASS. Seed 7, 400 boards:

| | signed | abs | passed out | vs champ abs | vs champ signed |
| --- | --- | --- | --- | --- | --- |
| default | −0.45 | 6.75 | 5/400 | −0.07 (t −0.32) | −0.10 (t −0.29) |
| `--pass-cap 1.0` | −0.64 | **6.49** | 6/400 | **+0.18 (t +0.75)** | −0.30 (t −0.82) |

Capping makes the system land *closer* to par in absolute terms but beat par
*less* — and neither arm is significant. This is §6.28's duality exactly:
`mean_imp_loss` is an absolute deviation and `mean_imp_diff` is signed, so a
change can improve one and worsen the other with both t-stats under 1. **Do
not report either arm as an improvement.** Note fidelity barely moved (71.5%
vs 71.7%), so capping is not buying faithfulness either — it is trading
variance for a slightly worse mean. Default stays uncapped.

### Where the ceiling probably is

`brill_ceiling.py` (new) buckets traces by feature vector and reports the
Bayes-optimal agreement. At 2,442 traces every position is unique — 2,442
buckets, zero collisions — so the bound is vacuously 100% and says only that
the space is far too high-dimensional to collide at this sample size. **Re-run
it at 12k+ traces**, where collisions start to appear; that is when it becomes
a real measurement of how much Brill's call is determined by what we can see.

Until then, the honest position, **after checking rather than assuming**:

### CORRECTION: 4.9× the traces bought +5.2pp — data was NOT exhausted

The learning curve above predicted +1–2pp from a 5× harvest. The actual
result, on the 11,848-trace set (seed 1234, disjoint from every eval set),
5-fold CV:

| traces | depth 8 | depth 10 | depth 12 |
| --- | --- | --- | --- |
| 2,442 | **70.6%** | 69.9% | 69.7% |
| 11,848 | 75.8% | **76.9%** (sd 0.2) | 76.4% |

At matched depth 8 that is **70.6% → 75.8%, +5.2pp — about 3× more than
predicted**, and depth 10 becomes the better setting (+1.1pp over depth 8),
which is the expected interaction: more data supports more depth. At 2.4k the
depth sweep was flat, so "capacity is not binding" was true *at that n* and
false at 5× it.

**The extrapolation was the error, not the curve.** Learning curves are fitted
inside an observed range; predicting 5× outside it from the last two points
(40%→100%) assumed the flattening would continue indefinitely. It did not.
The flat-looking tail was the onset of a slower regime, not a ceiling.

Also correcting the earlier framing in the other direction: the harvest was
worth running, and "the plateau is structural" was too strong.

### Board result at 11.8k traces: still parity, but a better model

Trained on all 11,848 traces, depth 10, **650 rules**, scored on 600 unseen
boards (seed 7, resolution ~0.32):

| | signed | abs | passed out | abs excl. pass-outs |
| --- | --- | --- | --- | --- |
| brill_distilled (650 rules) | **−0.09** | 6.66 | 12/600 | 6.71 |
| champion_system (90 rules) | −0.34 | 6.61 | 2/600 | 6.60 |

Paired (positive = distilled better): abs **−0.05** (se 0.19, **t −0.25**),
signed **+0.25** (se 0.29, **t +0.87**). Neither significant.

So: fidelity +6.3pp (70.6% → 76.9%) moved signed IMP from −0.45 to −0.09
(+0.36) and left the comparison with champion **statistically unchanged — a
dead heat on both metrics**. That is the honest result: 4.9× the data produced
a measurably better model of Brill and no measurable gain against champion.
Fidelity is not the same currency as IMP.

Note the pass-out rate rose to 12/600 (2.0%) — but remote Brill itself passes
out 25/1200 (2.1%), so the distilled system is now faithfully reproducing the
target's behaviour, pass-outs included. That is improved fidelity showing up
as a nominally worse-looking statistic.

### Re-tuning on 14,290 traces: grouping order FLIPS with scale

Both disjoint trace sets combined (2,442 seed-42 + 11,848 seed-1234 =
`data/brill_traces_all.jsonl`, 14,290; eval boards are seed 7, so all
training data stays unseen). 5-fold CV:

| group | depth 10 | depth 12 |
| --- | --- | --- |
| `none` | 77.6% (sd 1.0) | 77.6% (sd 0.9) |
| `opening` | **78.1% (sd 0.8)** | 78.0% (sd 0.8) |
| `auction_len` | 72.3% (sd 0.8) | — |
| `bid` | 71.3% (sd 1.1) | — |

**`opening` now beats `none`.** At 2,442 traces the order was the other way
(`none` 69.8% > `opening` 68.9%) because the split halved an already-small
set. At 6× the data the split is affordable and the two-position model wins.
Fold-by-fold it is consistent: `opening` 78 78 78 78 79 vs `none`
76 77 77 78 79.

The finer groupings are still **nowhere near** competitive (71–72%, ~6pp
worse). `group_key`'s docstring predicted `bid` would become usable "once the
trace set is in the tens of thousands" — at 14,290 that has not happened, and
the gap is far too large to be a near miss. The prediction looks wrong, not
merely premature: `bid` keys on `(auction_len, last_bid_level,
last_bid_strain)`, which is a large cartesian product, so most cells stay
under `min_samples` and collapse to a majority rule.

### Best configuration scored: still a dead heat

`--group opening --max-depth 10` on all 14,290 traces → **765 rules**, CV
**78.1%**. Scored on 600 unseen boards (seed 7, resolution 0.32):

| | signed | abs | passed out |
| --- | --- | --- | --- |
| brill_distilled (765 rules, 78.1%) | −0.55 | **6.52** | 12/600 |
| previous (650 rules, 76.9%) | −0.09 | 6.66 | 12/600 |
| champion_system (90 rules) | −0.34 | 6.61 | 2/600 |

Paired vs champion: abs **+0.10** (se 0.18, t +0.53), signed **−0.21**
(se 0.28, t −0.74). Neither significant.

Note the trade: +1.2pp fidelity bought +0.14 abs and **cost 0.46 signed**.
Higher fidelity to Brill systematically moves abs toward Brill's 5.00 while
signed does not follow — again because abs rewards *tracking* par and signed
rewards *beating* it (§6.28).

**Every configuration tried now lands at |t| < 1 against champion.** Across
2,442 / 11,848 / 14,290 traces, depths 8–12, and all four groupings, the
distilled system has never significantly beaten or lost to the champion.
That is seven-ish independent comparisons; if there were a real effect of the
size needed, one of them would have cleared t ≈ 2. Distillation is capped at
parity with this representation, and further fidelity gains are not
self-evidently worth paying for.

### The flywheel cannot tune it either (measured, not assumed)

The repo's own improvement engine should be the natural next step: the
distilled system's ID3 thresholds are exactly what the tighten/loosen
operators act on. Pointed at a copy of `brill_distilled.dsl` with a private
`--state` so nothing real was touched, `--metric mean_imp_loss`:

* Smoke run (8 deals, 1 round, 66s): every patch `t +0.00`. The most
  promising one, `SUPPORT`, carries **`n~15924`** — the deal count needed to
  resolve that single delta.
* Real run (96 deals, 3 rounds, 4 jobs, **12m42s**): applied
  `FORCE_RAISE_2NT` (+0.176) and `SUPPORT` (+0.108) during passes, then
  validation rejected them — mean validation gain −0.074 against a
  resolution of ±0.582 — and the round was **NOT SAVED**. **0 lifetime
  patches applied.**

Worth noting the direction of the numbers: train mean_imp_loss went
+68.8 → **+79.1 (worse)** while val7 13.2 → 10.6 and val13 18.0 → 4.9
improved. That is a hill-climb chasing resampling noise, and the flywheel
said so itself: *"treat this round as unproven, not as an improvement."*

So local search is not a cheap way to squeeze this system. Each candidate
patch moves the objective by less than the noise floor of any deal set we
can afford to score, and `--val-seeds` resolution only improves as
1/sqrt(seeds).

### CORRECTION: head-to-head says the distilled system LOSES (§6.60)

Par-based scoring said "dead heat" every time. `research/team_match.py`
asks the question directly instead — each deal is played at two tables,
A on NS at one and EW at the other, and the two NS results are differenced
into IMPs. No par, no absolute-value artefact, no signed/unsigned
ambiguity. It is a paired design on identical cards, which is why it is far
more sensitive.

| match-up | boards | seed | A net IMP/board | t | result |
| --- | --- | --- | --- | --- | --- |
| brill_distilled vs champion | 600 | 7 | **−0.98** (se 0.29) | **−3.36** | champion wins |
| brill_distilled vs champion | 600 | 13 | **−1.37** (se 0.28) | **−4.96** | champion wins |
| brill.dsl vs champion | 400 | 7 | **−1.24** (se 0.31) | **−4.03** | champion wins |

**This reverses the "parity" verdict above.** Seven par-based comparisons
across three trace sizes, four groupings and five depths all returned
\|t\| < 1; the first head-to-head returns t = −3.36 and replicates at
−4.96 on a second deal seed. The two Brill-derived systems are not equal to
the champion — they lose to it by roughly **1.0–1.4 IMP/board**, and the
par-based metrics could not see it.

Why the metrics disagree: two systems can sit the same distance from par
while playing very differently against each other, because *which* boards
they gain on matters head-to-head and is invisible against a fixed
reference. par is a common baseline; it is not a substitute for playing the
boards.

The harness was checked for bias before use: `--swap` runs the mirror
match and returns the exact negation (+1.17 / −1.17, wins 10/12 ↔ 12/10),
so the seating is symmetric. Note also that the distilled system passes out
*less* often than champion here (3 vs 6), so the deficit is not the
pass-out story from earlier.

### The target is excellent: remote Brill beats champion +2.63 (§6.60)

`team_match.py --remote-a`, 200 boards, seed 7, 43 min:

| side | net IMP/board | t | won/lost/tied | passed out |
| --- | --- | --- | --- | --- |
| **remote Brill** vs champion | **+2.63** (se 0.50) | **+5.22** | 95 / 52 / 53 | 0 / 1 |

So the whole programme rests on something true: **Brill really is much
better than the champion — +2.63 IMP/board.** And against that:

| rendering of Brill | vs champion |
| --- | --- |
| remote Brill | **+2.63** |
| `brill_distilled.dsl` (765 rules, 78.1% fidelity) | **−0.98 … −1.37** |
| `brill.dsl` (1,932 rules, rule capture) | **−1.24** |

**The capture gap is ~3.6–4.0 IMP/board.** Both routes to owning Brill
locally destroy the entire advantage and then some. Note how badly this
sits with the fidelity number: 78.1% agreement with Brill and *still* 4 IMP
worse than Brill. That is the signature of a *routing* failure — when you
pick the wrong branch of the convention tree you do not land one call away
from the right contract, you land in a completely different one. Cosmetic
errors would cost far less; these are not cosmetic.

Caveat on the comparison, stated because it matters: a local DecisionNet
gives PIDM a ranked candidate list to search, while Brill's service exposes
only its chosen call, so Brill gets no PIDM lookahead. That handicap is on
the side that *won*, which makes the +2.63 conservative.

### The one live lever: more traces (+1.49 IMP/board for 6×)

Same configuration (`--group opening --max-depth 10`), same 600 boards
(seed 7), differing only in how much Brill data the model saw:

| model | traces | CV fidelity | head-to-head vs champion |
| --- | --- | --- | --- |
| `bd_2k` (355 rules) | 2,442 | 70.7% | **−2.47** (se 0.30, t −8.27) |
| `brill_distilled` (765 rules) | 14,290 | 78.1% | **−0.98** (se 0.29, t −3.36) |

**6× the traces bought +1.49 IMP/board** (difference se ≈ 0.42, so this is
real, not noise). This is the only intervention in the whole session that
moved the head-to-head number, and it moved it a lot. It also puts the
earlier "data is exhausted" conclusion firmly to rest — that was the
extrapolation error, and it was wrong in the direction of giving up too
early.

Rough projection, and it is only that: the two points give ~0.20 IMP per
fidelity point. Parity with champion needs ≈ 83% (another ~5pp); matching
remote Brill's +2.63 needs ≈ 91%. Fidelity gains are diminishing (+7.4pp for
the first 6×), and ~10 traces come per board, so parity is maybe another 4–5×
the current set — on the order of 50k traces, i.e. ~12h of harvesting in the
background. Beating champion outright looks to need more than that.

Two caveats before anyone acts on this. It is a two-point extrapolation, and
the previous two-point extrapolation in this document was wrong. And even at
parity with champion the result is 0, against remote Brill's +2.63.

### Where the loss is NOT: four hypotheses killed

`where_lost.py` (new) attributes the deficit. Each system plays *itself* on
the same deal, so every board can be labelled by how the two contracts
differed.

**The headline is a contradiction worth sitting with:**

| measurement | distilled vs champion |
| --- | --- |
| self-play (each system plays itself) | **+0.20** (t +0.59), **+0.02** (t +0.06) — dead heat |
| team match (head-to-head) | **−0.98** (t −3.36), **−1.37** (t −4.96) |

Same models, same deals, opposite verdicts, ~1.2 IMP/board apart. The
distilled system is fine in its own auctions and loses when the two systems
are in the same auction. Any future evaluation here should use the team
match — self-play cannot see this.

Four candidate causes, all rejected by measurement:

1. **A few catastrophic boards.** No. The worst 10% of boards carry only
   22% of all IMP movement (a uniform spread would be 10%). The loss is
   diffuse, so there is no small set of disasters to fix.
2. **Pass-outs.** No — distilled passes out *less* than champion (3 vs 6
   per 600).
3. **Too passive.** Tested directly with `--pass-cap 1.0` (cap PASS traces
   1:1 so the tree cannot default to passing): fidelity 78.1% → 77.3% and
   head-to-head **−0.98 → −1.91 (t −6.32)**. Forcing bids makes it much
   worse, so it is not simply failing to compete.
4. **Weak in contested auctions.** No — splitting the match:
   contested n=177 **−0.71** (t −1.22, n.s.), uncontested n=423 **−1.09**
   (t −3.27). The loss is in auctions it *bought*, not auctions it fought.

What is left is constructive bidding in its own auctions: it reaches
**136 games per 400 boards vs champion's 173**. Buying the contract and
then stopping too low is consistent with everything above — but note that
in self-play champion's extra games are mildly *losing*, so "bid more
games" is not obviously the fix either. `--pass-cap` is evidence that
crude aggression backfires.

### Attacking the routing gap: auction-identity features (+0.4pp, n.s.)

The measured gap is ~4 IMP/board and the hypothesis is that the model cannot
tell *which branch* of the convention tree it is in. `*_last_call` says what
was said most recently; what selects the branch is how the auction **began**
(Stayman and transfers exist only after 1NT, cue bids only after an
overcall). So four string features were added to `extract_auction_features`:

| feature | meaning |
| --- | --- |
| `opening_bid` | first bid of the auction, else `NONE` |
| `my_first_call` | my first call |
| `partner_first_call` | partner's first call |
| `opp_first_call` | first call by either opponent, in auction order |

They are strings deliberately: ID3 can split on them now that categorical
support exists, and the result reads `opening_bid == '1NT'` alongside the
hand-authored conventions. All four stay under `MAX_CATEGORICAL_VALUES`, so
they are eligible splits rather than memorised identifiers.

**Result: 78.1% → 78.5% (5-fold CV, 14,290 traces). +0.4pp against a fold
se of ~0.4 — not significant.** They do not close the gap. If picking the
wrong branch were the whole story these should have moved it much further,
so either the branch is recoverable from features the model already had, or
the failure is deeper than one missing predicate.

Kept anyway: they are cheap, principled, and cost nothing at inference.

**Gotcha:** `build_frozen_vocab` includes `BridgeFeatures` keys, so adding
features trips `test_frozen_vocab_file_integrity`. That is a tripwire, not a
prohibition — the vocab is designed to be append-only and `_grow_vocab_tensors`
resizes checkpoints to match. Re-froze with a hard assertion that no existing
id moved: 423 → 427, appended `my_first_call`, `opening_bid`,
`opp_first_call`, `partner_first_call` at ids 423–426.

### Summary: three levers, all measured, all closed

| lever | result |
| --- | --- |
| more traces (2.4k → 14.3k) | +7.5pp fidelity (70.6% → 78.1%); board result unchanged, \|t\| < 1 |
| model capacity / grouping | tuned (depth 10, `opening`); no config beats champion |
| flywheel local search | 0 patches saved at 96 deals; needs ~16k deals per patch |

The distilled system is a genuinely good model of Brill (78.1% vs a 61.1%
majority baseline) and it plays at parity with the champion. It does not beat
the champion, and no lever tested here gets it there.

### The "we're missing Brill's atoms" hypothesis is mostly WRONG

Brill's `requires` field (1,510 of 2,442 traces) states its hand predicates
symbolically, so the obvious explanation for the plateau — our 121 features
don't compute Brill's atoms — is directly testable. It does not survive the
test. Diffing the 131 distinct atoms against `extract_all`, weighted by how
often each is used (7,457 atom occurrences):

| | share of atom usage |
| --- | --- |
| covered by an existing feature | **88.9%** |
| Brill *rule references* (`Opening1H`/`Opening1S`) | 1.4% |
| genuinely missing | **9.7%** |

The high-usage atoms are all present under different names —
`clublongest`→`c_is_longest`, `S_points`→`spade_hcp`,
`losers`/`loserlevel`→`losing_trick_count`, `aces`→`ace_count`,
`havekeycards`→`keycard_count_1430`, `explicitshape`→`shape_pattern`,
`semibalanced`→`is_semi_balanced`, `stopper`→`has_stopper`,
`totalpoints`→`total_points`, `ruleof21`→`rule_of_21`.

(A naive string diff says 27% missing. That is wrong — it is inflated by
false positives from the name differences above. Worth stating because that
number is the one that makes the story look tidy.)

What is actually missing is not hand shape but **auction-context and
conventional judgement**: `lightmajoropening` (73), `fourthseatopening` (73),
`slammish` (64), `doublethenovercall` (55), `makessense` (34), `overcall` (32),
`opponentsuit` (27), `balish` (22), `bestmajor` (21), `twosuited` (16).

That reframes the residual. `requires` only ever describes the **hand** half of
a Brill decision; which of its 1,040,694 rules fires is decided by an auction
routing tree that `requires` says nothing about. So the unexplained ~30% is
most likely *"which convention am I in"*, not *"what is my hand"* — a deep
routing problem, and precisely the part a fixed-width feature vector is worst
at. Adding the ~10 genuinely-missing predicates is cheap and worth doing, but
9.7% of atom usage does not account for a 30% fidelity gap, so it should not
be sold as the fix.

### The 1,200-board harvest landed — and re-measured remote Brill properly

`brill_remote_eval.py --boards 1200 --seed 1234` finished in 2h37m, writing
**11,848 position→call records** (vs 2,442 before, 4.9×). It also re-ran the
remote-Brill-vs-champion comparison at **1,200 boards, resolution 0.23** — 25×
the board count of §6.57:

| | signed | abs | passed out |
| --- | --- | --- | --- |
| remote Brill (`/bid`) | −0.04 | **5.00** | 25/1200 |
| champion_system | +0.14 | 6.36 | — |

Paired (positive = Brill better): abs **+1.36 (se 0.13, t +10.81)**, signed
−0.18 (se 0.20, t −0.91).

Two things worth separating. First, the abs advantage is now overwhelming
(t 10.81 vs §6.57's t 3.74) — remote Brill really does land much closer to par,
and the target is confirmably strong. Second, **on the signed metric it is
*slightly worse* than champion and not significant**, while champion is
nominally *beating* par (+0.14). This is §6.28's duality at its starkest:
Brill is more accurate, champion is more optimistic. "Brill is better" is true
of absolute deviation from par and is not true of signed IMP.

Brill passes out 25/1200 (2.1%), so the pass-out rate seen in the distilled
system is inherited from the target, not introduced by distillation.

### Latent bug found and fixed: string condition values were exported unquoted

`DecisionNet.export_dsl` wrote `CONDITION: {key} {op} {value}` with no
quoting, while `load_decision_net_dsl` coerces bare numeric-looking tokens to
**int**. So a rule on the string feature `shape_pattern` exported as

    CONDITION: shape_pattern == 4432

loaded back as the integer 4432 and never equalled the feature's string
`'4432'` — **the rule was silently dead**. The line looks correct, which is
what makes it dangerous; nothing warns you.

Found only because the round-trip was checked directly: fidelity of the
in-memory net vs the reloaded one was 84.40% vs 83.99%. **20 of 192 distilled
rules were dying this way** (every rule splitting on `shape_pattern`;
`PASS`, `E`, `NONE` survived because they are not numeric-looking).

Fixed with `DecisionNet._fmt_cond_value`, which quotes strings on export
(`shape_pattern == '4432'`), matching how hand-written systems already spell
string literals (`partner_last_call == 'NONE'` in brill.dsl). Round-trip is
now bit-identical. Regression tests in `TestDslValueQuoting`.

**General lesson: a save→load cycle is not free. Verify behaviour is
preserved, not just that the file parses.** This is the second time in this
project that a round-trip silently degraded a system (see §6.5x on
`intersection_nodes` being dropped).

### Gotcha: generated systems leak into the frozen CoT vocab

Writing `system/brill_distilled.dsl` broke `test_frozen_vocab_file_integrity`
(423 vs 615). `build_frozen_vocab` globs `system/*.dsl` for `RULE <id>` atoms
and 192 new ids landed in it — the same hazard `_VOCAB_EXCLUDED_DSL` already
existed to prevent for `brill.dsl`. Fixed by adding `brill_distilled.dsl` to
that set. **Any new generated .dsl dropped into `system/` will do this again.**

### 6.61 DAgger: the drift is real and small, and fixing it buys nothing

§6.60 left one mechanism untested. The distilled system is fine in self-play
(+0.20, n.s.) and loses head-to-head (−0.98). That gap is the signature of
**compounding error**: training contexts are all Brill-vs-Brill auctions, but
deployment puts the student in auctions generated by a 78%-faithful model, so
it drifts into states it has never seen. DAgger is the textbook fix — let the
student drive and have the expert label the states it visits.

**Step 1: is there a distribution shift, and how big?** Trained on 80% of
`brill_traces_all.jsonl` and scored two held-out sets:

| test set | n | agreement |
| --- | --- | --- |
| held-out Brill-vs-Brill (on-distribution) | 2,858 | **78.2%** |
| student-visited states, from `brill_dagger.py` (off) | 2,748 | **75.7%** |

Shift = **−2.5pp**, roughly 2.2 standard errors. So the drift is real — but
it accounts for ~2.5 of the ~22 percentage points between us and Brill. It
was never going to be the whole story, and this is the measurement that says
so.

**Step 2: DAgger retrain.** Concatenated 14,290 + 2,748 = 17,038 traces,
same config (`--group opening --max-depth 10 --folds 5`):

| | baseline | +DAgger |
| --- | --- | --- |
| traces | 14,290 | 17,038 |
| CV agreement | 78.1% | **78.6%** (fold sd 0.9) |
| rules | 765 | 815 |
| **team match, 600 boards seed 7** | **−0.98** (t −3.36) | **−1.22** (t −4.35) |
| ├ contested | −0.71 (n.s.) | −1.76 (t −3.10) |
| └ uncontested | −1.09 (t −3.27) | −1.00 (t −3.12) |

**Reading this honestly.** The headline is not "DAgger made it worse" — the
−0.24 difference is not significant against the two runs' standard errors
(≈0.29 and 0.28; if treated as independent, t ≈ 0.6). The headline is
**DAgger bought +0.5pp of fidelity and zero IMP.** That is now the third
intervention where fidelity went up and board results did not follow
(after `--pass-cap` and the auction-identity features), and it is the same
§6.28 duality: per-decision agreement with Brill is not the currency the team
match pays out in.

The one number that does look bad is contested auctions: −0.71 → −1.76. Care
is warranted (n = 177, se 0.57), and I did not run the paired test that would
settle it, because neither version beats champion and so the distinction does
not change any decision. A plausible mechanism is composition, not drift:
DAgger traces are **NS-only by construction** (student sits NS, so every
`ctx` has even length) and are pass-light (54.1% `PASS` vs 61.1% in
Brill-vs-Brill), so 16% of the training set is a slice of the auction tree
the student is already worst at.

**What this closes.** Compounding error was the last cheap hypothesis. It is
measured (−2.5pp), it is real, it is not the dominant term, and the standard
fix does not convert into IMP. Combined with §6.60's four killed hypotheses
and the routing features, the scoreboard is:

| lever | fidelity | IMP/board |
| --- | --- | --- |
| more traces (2.4k → 14.3k) | +7.5pp | **+1.49** |
| auction-identity features | +0.4pp (n.s.) | not measured, ~0 |
| pass-capping | — | −1.91 (worse) |
| DAgger | +0.5pp | −0.24 (n.s., if anything worse) |
| flywheel | — | 0 patches saved |

**Data volume remains the only intervention that has moved the number.**

---

## 9. References

- Amit & Markovitch, *Learning to Bid in Bridge*, MLJ 63(3), 2006 — BIDI/RBMBMC/PIDM/ID3/co-training foundations.
- Cazenave & Ventos, *The αμ Search Algorithm for the Game of Bridge*, arXiv:1911.07960 — PIMC/αμ, strategy fusion, Pareto fronts.
- Frank & Basin, *Search in Games with Incomplete Information* — fusion/non-locality formalization.
- Ginsberg, GIB — PIMC in competitive bridge.
- Bo Haglund & Søren Hein, DDS 3.x — native solver; `SolverContext` lifecycle guidance in `../dds/sds.md` (K5/K6/K10).
- [`research/sds-explained.md`](sds-explained.md) — SDS theory-to-implementation walkthrough and measurements.
