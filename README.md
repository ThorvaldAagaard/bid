# Bid: Autonomous Self-Improving Contract Bridge Bidding Engine

**Bid** is a contract bridge AI and research platform designed to **continuously discover, refine, and invent bidding conventions**. 

Rather than relying on static, brittle rule tables or black-box policies, `bid` implements a closed-loop **continuous improvement pipeline**: it starts from baseline bidding rules, actively hunts for ambiguous or unhandled states, uses high-budget model-conditioned Monte Carlo search (RBMBMC + PIDM) as a teacher, distills those insights into localized decision-net refinements (ID3), co-trains the partnership in parallel, and synthesizes new communication protocols using Value of Information (VOI) and adversarial signaling theory.

---

### 🎓 Learning Curriculum & System Design Guides
Whether you are designing a custom bidding system or studying the computer science behind bridge AI:
- 📖 **[Bidding System Design Guide](docs/DESIGNING_A_BID_SYSTEM.md)**: Step-by-step tutorial on drafting DSL rules, diagnosing gaps, A/B benchmarking, SDS two-hand validation, and neural distillation.
- ♟️ **[Track 1: Game Theory & Signaling](docs/LEARNING_GAME_THEORY.md)**: Imperfect information, Bayesian updating, cooperative-adversarial signaling, competitive VOI, and scoring math.
- 🌲 **[Track 2: Machine Learning & Search](docs/LEARNING_MACHINE_LEARNING.md)**: RBMBMC Monte Carlo sampling, PIDM lookahead, ID3 speedup learning, and active learning.
- 🧠 **[Track 3: LLMs & Chain-of-Thought](docs/LEARNING_LLM_AND_COT.md)**: Decoder-only Transformers from scratch, knowledge distillation, CoT reasoning, batched decoding, and neuro-symbolic verification.
- ⚡ **[Double Dummy Solver (DDS) Guide](docs/BUILDING_AND_USING_DDS.md)**: Building and using Bo Haglund's native C++ solver (`libdds`) for exact trick calculations and par analysis.
- 🗺️ **[Full Curriculum Roadmap](docs/CURRICULUM.md)**: Complete learning track index and code walkthroughs.

---
## 🔄 The Continuous Improvement Pipeline

The core goal of `bid` is to run an autonomous flywheel that iteratively improves both bidding policy and belief-state inference:

```
                            ┌─────────────────────────────────┐
                            │    1. Active State Discovery    │
                            │  • Rule Ambiguities (|φ(s)| > 1)│
                            │  • Rare/Stratified Distributions│
                            │  • Policy-Search Disagreements  │
                            └────────────────┬────────────────┘
                                             │
                                             ▼
┌──────────────────────────────┐   ┌─────────────────────────────────┐
│  3. Speedup Rule Refinement  │   │   2. Expensive PIDM Teacher     │
│  • ID3 Information Gain      │◄──┤ • RBMBMC World Sampling         │
│  • Local Intersection Nodes  │   │ • Nested Opponent/Partner Sims  │
│  • Fast O(1) Policy Execution│   │ • Duplicate Bridge / DD Scoring │
└──────────────┬───────────────┘   └─────────────────────────────────┘
               │
               ▼
┌──────────────────────────────┐   ┌─────────────────────────────────┐
│   4. Partner Co-Training     │   │   5. Convention Invention & VOI │
│ • Parallel Model Exchange    │──►│ • Protocol State Machines       │
│ • Tighter Belief Filtering   │   │ • Value of Information (VOI)    │
│ • Speed & Accuracy Feedback  │   │ • Adversarial Signal Concealment│
└──────────────────────────────┘   └─────────────────────────────────┘
```

---

## 🌟 How the Pipeline Works

### 1. Active State Discovery & Stratified Generation
Standard random dealing rarely encounters critical rare shapes (e.g. 9-card suits, 22+ HCP, extreme singletons). The pipeline actively finds states worth learning:
- **`StratifiedDealGenerator`**: Deliberately samples underrepresented hand strata (suit length, HCP bands, freak distributions).
- **`ExperienceBuffer`**: Prioritizes states where rules disagree, policy confidence is low, or high-value utility gaps exist.
- **`ExploratoryCandidateGenerator`**: Expands candidate actions beyond expert rules with adaptive exploration ($\epsilon$).

### 2. Model-Conditioned Teacher: RBMBMC + PIDM
When a decision is uncertain ($|\phi(s)| > 1$), the engine launches a high-budget search:
- **Resource-Bounded Model-Based Monte Carlo (RBMBMC)**: Replays the auction backwards, filtering out worlds that are inconsistent with historical calls according to player behavioral models.
- **Partial Information Decision Making (PIDM)**: Recursively simulates partner and opponent reactions in each sampled world, evaluating outcomes with double-dummy trick estimation and duplicate bridge scoring.

### 3. Local Speedup Learning & Exception Refinement
The expensive search acts as a teacher to refine the fast rule net:
- **`ID3DecisionTree`**: Calculates Shannon Information Gain across 250+ bridge features (HCP, suit lengths, controls, LTC, honor topology) to find the exact feature that separates competing actions.
- **Intersection Nodes**: The learned classifier is attached *locally* to the intersection of the conflicting rules (e.g., $R_{\text{1NT}} \cap R_{\text{1H}}$ for 16 HCP 5-heart balanced hands). The general rules outside the conflict remain intact.

### 4. Partner Co-Training Loop
North and South learn in parallel and periodically exchange their refined decision nets:
- When South learns a more precise rule, South's refined model constrains North's RBMBMC world sampling.
- Fewer inconsistent worlds mean North's search becomes both **faster** and **more accurate**, creating a compounding feedback loop.

### 5. Convention Invention & Information Protocols
The system treats bridge conventions as **imperative communication programs**:
- **Semantic Primitives**: Synthesizes sequences using `SHOW`, `ASK`, `COMMAND`, `TRANSFER`, `ENCODE`, `CONCEAL`, `AMBIGUATE`, and `POOL`.
- **Value of Information (VOI)**: Evaluates whether a question (like Stayman major query or Blackwood ace ask) provides positive expected payoff:
  $$\text{VOI}(Q) = \mathbb{E}[\max_a V(a \mid Q)] - \max_a \mathbb{E}[V(a)]$$
- **Adversarial Signaling**: Measures net information payoff against defenders $(\Delta V_{\text{partner}} - \Delta V_{\text{opponent}})$, allowing the system to discover strategic pooling, concealment, and gambling bids.

### 6. Opponent-Aggressiveness Awareness
Competitiveness is conditioned on **how the opponents behave**, not merely whether they have bid. `BridgeFeatures.extract_auction_features` computes a seat-correct opponent-style profile on every decision:

| Feature | Meaning |
|---|---|
| `opp_bid_count`, `competition_level` | intensity of the contested auction |
| `opp_preempted`, `opp_first_bid_level` | opponents opened pre-emptively (weak-hand signal; first opp bid at level ≥ 3, or a 2-suit opening early in the auction) |
| `opp_strength_class` | `weak` / `unknown` / `strong`, inferred from opponents' bidding shape |
| `auction_altitude`, `auction_contested` | how high the auction has escalated and whether both sides are in |
| `opp_fit_shown`, `our_fit_shown` | fit inference: a side is "shown a fit" when **both** of its members bid the same suit |
| `is_unfavorable_vuln`, `vuln_pressure` | the previously missing unfavorable-vulnerability case (`favorable` / `unfavorable` / `equal`) |
| `partner_rebid` | partner voluntarily re-entered the auction |
| `opp_suit_stoppers`, `has_stopper` | NT stopper quality (A=2.0, guarded K=1.0, guarded Q=0.5) in every suit the opponents have bid |
| `partner_last_bid_strain`, `support_in_partner_suit` | partner's most recent suit bid and my holding length in it — the basis for support raises |

These feed the symbolic system two ways:

1. **Curated rules** — the flywheel's `AGGRESSION` patch family (`flywheel.py`) uses them for vuln-gated preempt pushes (`FW_PREEMPT_PUSH_*`), altitude discipline against strong opponents at unfavorable vulnerability (`FW_ALTITUDE_DISCIPLINE`), and light competition against detected weak pre-empters with a shown fit (`FW_VS_WEAK_COMPETE`).
2. **Automatic propagation** — `serialize_features` copies all of them into every trace row, so the CoT student's tokenizer vocabulary and training distribution pick them up on the next `refresh_student` cycle with zero extra work; the threshold values themselves are auto-tuned by the flywheel's `tighten`/`loosen` mutation operators like any other numeric bound.


---

## 🔁 Operating the Teacher ↔ Student Loops (Runbook)

This section documents the *actual* self-improvement loops as implemented —
exact commands, what each stage does automatically, which decisions stay with
a human, and where every artifact lands.

### The loops at a glance

```
   ┌─────────────────────────── TEACHER (symbolic) ───────────────────────────┐
   │  flywheel.py / autoloop.py                                               │
   │  patch pool → paired hill-climb vs DDS par → val-seed gate → SDS gate    │
   │  → SAVED v(n+1) in system/improved_system.dsl (+ archive, state JSON)    │
   └──────────────┬───────────────────────────────────────────▲───────────────┘
                  │ new DSL hash                               │ arb_student_right
                  ▼                                            │ (student found a
   ┌─────────────────────────── STUDENT (neural) ─────────────┴───────────┐   │
   │  refresh_student.py                                                  │   │
   │  trace_factory → build_cot_dataset (merged w/ disagreements)         │   │
   │  → train candidate → eval-val gate vs incumbent → promote/archive    │   │
   └──────────────┬───────────────────────────────────────────────────────┘   │
                  │ disagreements.jsonl ──────────────────────────────────────┘
   ┌──────────────▼──────────── RL / SEARCH (break the imitation ceiling) ───┐
   │  rl_finetune.py        (REINFORCE on DDS-scored self-play, gated)       │
   │  convention_search.py  (protocol mutation hill-climb, report only)      │
   │  player_model.py       (soft P(call|ctx) for RBMBMC world filtering)    │
   └─────────────────────────────────────────────────────────────────────────┘
```

### Loop A — improve the teacher (symbolic DSL)

```bash
python3 -m bid.flywheel --deals 96 --rounds 2 --sds
# or CLI script: bid-flywheel --deals 96 --rounds 2 --sds
```

Per round, automatically:
1. Plays the deal set vs native DDS par, dumps worst flaws (`OVERBID_DOWN`,
   `MISSED_SLAM`, `SOFT_DEFENSE`, ...) via `ParDiagnosticEngine`.
2. Builds a patch pool: curated families (`CURATED` dict in `flywheel.py`),
   diagnostic-corrective rules, ungated-rule gating variants, broad-rule
   drops, and `tighten`/`loosen` threshold mutations of every numeric bound.
3. Greedy hill-climb: applies the best measured patch, re-screens, repeats.
4. **Validation gate** on two disjoint val seeds (7 and 13): any val
   regression → the round is *not saved* and the failed patch signature is
   cached (won't be retried).
5. **SDS two-hand gate** (`--sds`): re-scores accepted auctions from the
   declarer+dummy two-hand view; rejects patches whose realistic-info score
   regressed.
6. On success: `improved_system.dsl` saved, previous version archived to
   `system/history/improved_system_vN.dsl`, `flywheel_state.json` bumped
   (version, applied list, failed-signature cache).

Variants:
```bash
python3 -m bid.autoloop --tiers 24,96,384        # long-running:
# tiered screening with statistical escalation, automatic champion
# promotion to system/champion_system.dsl, progress JSON under debug/
python3 -m bid.flywheel --deals 96 --rounds 2 --sds-primary
# hill-climb directly on the SDS objective instead of DDS-par score
python3 -m bid.autoloop --policy-prior data/cot_model/ckpt.pt
# policy-guided PIDM pruning using the trained student as a prior
python3 -m bid.flywheel --deals 96 --rounds 2 --metric mean_imp_loss --panel
# IMP-capped objective, scored against a frozen opponent panel (recommended)
```

**Two objective switches** (`--metric`, `--panel`) address the failure mode where
the version counter advances without the anchor ledger moving:

- `--metric mean_imp_loss` — hill-climbs IMPs lost per board instead of raw
  points. The IMP scale saturates at 24, so one −910 slam swing can no longer
  outweigh thirty ordinary boards (raw regret spans +23…−174 while IMP
  loss/board spans only 2.7…4.6). The acceptance floor and validation
  tolerance scale with the metric automatically (`MIN_DELTA_BY_METRIC`,
  `val_tolerance`); `metric_gain()` flips the sign so positive always means
  *better*.
- `--panel` — E/W is played by a frozen panel of unrelated archetypes
  (SAYC, Precision, 2/1 GF) rotated per deal, instead of a copy of the
  evolving system. In self-play both sides share one rule set, so any
  adaptive behaviour cancels and the loop converges to a fixed point of the
  system rather than to bidding strength. Cost is unchanged versus self-play.

For reporting rather than screening, `eval_vs_dds --panel` plays every system
against the panel over **both seat orientations** and ranks by
`--metric h2h_score`; because par cancels when both orientations are averaged,
that score is a pure head-to-head result rather than a par-relative one:

```bash
python3 -m bid.eval_vs_dds --boards 32 --panel --metric h2h_score
```

### `--id3`: the speedup-learning family

`--id3` adds the BIDI speedup-learning step to the patch pool: PIDM labels
ambiguous states ($|\varphi(s)| > 1$) sampled from the seeded training deals,
ID3 fits a tree per rule intersection, which is attached to the net as a
refinement.

This is the only family that **invents new structure**. Everything else —
curated families, threshold `tighten`/`loosen`, gating variants, drops — can
only move thresholds inside a structure a human already wrote, which is why
28 versions of hill-climbing never closed the gap to the champion archetype.

**Refinements now persist — this was the bug that killed the whole path.**
`export_dsl` used to write only a depth-1 sketch of an attached classifier
(`SPLIT_FEATURE` / `THRESHOLD` / `IF`) and `load_decision_net_dsl` read only
`RESOLVED_CALL`, so an attached ID3 tree was silently destroyed by every
save → load cycle: `intersection_nodes` came back empty and $\varphi(s)$
re-widened. That is why speedup learning was dead code even before it went
unreferenced — and why the live DSLs contained **zero** `INTERSECTION` blocks.

Trees are now serialized in full:

```
INTERSECTION R_1H ^ R_1NT:
  TREE:
    SPLIT hcp <= 16.5 fallback 1H
      LEAF 1H
      LEAF 1NT
```

`SPLIT` carries a `fallback` (the node's majority call) so a missing feature
degrades the way `ID3Node.predict` does instead of picking a direction at
random. The block is parsed by `eval_vs_dds.parse_id3_tree` and by the same
indentation grammar in `web/bid_dsl.js`, which registers the tree into the
existing `net.refinements` hook — so the browser engine resolves intersections
identically to Python. `tests/web/id3_dsl_test.mjs` asserts that parity.

**Attach, don't compile.** `id3_tree_to_rules` (also in `learner.py`) can
compile a tree into ordinary rules, which is useful for engines that cannot
parse `TREE:` blocks. It is *not* what `--id3` uses, because it is only an
approximation: a refinement fires when the matched rule set is **exactly** the
intersection key, whereas ANDing the key rules' conditions matches a
**superset** — including states where other rules also fire. Several rules are
named `NO_x_WITH_MAJOR_y` and fire on little more than `heart_len >= 3`, so
compiled rules came out as broad as `is_opening AND heart_len >= 3 AND
spade_len >= 4 -> 1C` at priority 40. Measured on 24 held-out boards
(seed 7, SAYC/Precision panel, both seats):

| variant | h2h pts/bd | IMP loss/bd |
| --- | --- | --- |
| no ID3 | −10.2 | 6.68 |
| compiled to rules | −14.0 | 6.94 |
| **attached tree** | **+0.1** | 6.89 |

The attached tree is ~14 pts/board better than compiling, which is the whole
gap between "fires only at the intersection" and "fires anywhere the guard
holds". Attach is what `--id3` uses.

**Does it actually improve bidding? No — not measurably.** The 24-board
head-to-head above (+10.3 pts/bd) does not survive a larger sample. At 96
deals, 60 harvested states, on two independent bases, with two held-out
validation seeds:

| base | baseline | +ID3 | train Δ | val 1 | val 2 | verdict |
| --- | --- | --- | --- | --- | --- | --- |
| improved | 6.804 | 6.873 | −0.069 | −0.098 | +0.176 | does not transfer |
| champion | 5.735 | 5.824 | −0.088 | −0.196 | +0.029 | does not transfer |

(IMP/board, lower is better.) Both bases get worse on train and the validation
seeds disagree in sign — noise, not a generalising patch. The root cause is
data, not machinery: 60 ambiguous states collapse to **1** patch, because a
hand-authored system has already disambiguated by hand anything it hits often.
What remains is a long tail of intersections seen once or twice, which
`min_examples=3` now correctly refuses to fit.

`--id3` is therefore **off by default and should be treated as
infrastructure, not as an improvement**. The persistence fix is real and worth
keeping — trees no longer vanish on save — but do not expect `--id3` to raise
the score. Full analysis in `research/status.md` §6.14.

```bash
python3 -m bid.flywheel --deals 96 --rounds 2 --id3 --panel --metric mean_imp_loss --jobs 8
```

### `--jobs`: buying evaluation resolution

Screening resolution is the binding constraint on whether a measured gain is
real (§6.12: at 16–48 deals nothing transfers to the validation seeds). Boards
are independent, so `--jobs N` scores the deal set across processes. Measured
on 96 deals: **60.5 s → 27.7 s (2.2x)**.

Two honest caveats:

- **2.2x, not linear.** Workers must use `spawn` — forking a process that has
  already initialised native DDS deadlocks inside `libdds` — and each worker
  pays ~2.5 s to re-import the package and re-init DDS, on *every* call. Small
  deal sets are therefore faster serially, so `MIN_BOARDS_PER_WORKER` (8) makes
  `evaluate_system` fall back to serial below the threshold rather than silently
  getting slower. The result dict reports `jobs_used` so this is visible.
- **Not comparable to serial numbers.** Serial consumes one RNG in board order;
  parallel seeds per chunk. Absolute figures differ between modes, but a given
  parallel configuration is reproducible and base/candidate stay paired, which
  is what the gates rely on. Pick one mode per experiment.

> ### ⚠️ Read this before trusting any flywheel result
>
> **The screening is too coarse to resolve the changes it is judging.** Scoring
> the *same* system on five independent 96-deal sets does not give the same
> answer:
>
> | system | 11 | 22 | 33 | 44 | 55 | mean | sd | range |
> | --- | --- | --- | --- | --- | --- | --- | --- | --- |
> | champion | 6.529 | 6.735 | 6.971 | 6.118 | 6.490 | 6.569 | 0.316 | 0.853 |
> | improved | 7.304 | 7.618 | 6.843 | 6.480 | 7.167 | 7.082 | 0.437 | 1.137 |
>
> One 96-deal measurement carries a **±0.62 to ±0.86** 95% interval. Two
> consequences:
>
> 1. `--metric`'s acceptance floor of `0.03` IMP/board is **~20x below the
>    noise**. It is a train-set *effect size* filter (there the base/candidate
>    comparison is paired and exact), **not** a significance threshold. Do not
>    read a cleared floor as evidence of improvement.
> 2. The validation gate is **one-sided**: with `VAL_SEEDS = (7, 13)` it accepts
>    when `d > -tol`, i.e. it rejects clear regressions but *accepts anything
>    neutral — including a no-op*. Resolving a gain needs it to exceed
>    `1.96 × 0.42 / √2 ≈ 0.58` IMP/board; confirming one at the 0.03 floor would
>    need hundreds of 96-deal sets.
>
> This is the mechanism behind the project's headline failure:
> `improved_system.dsl` is at **v28** — twenty-eight rounds of patches that each
> passed a gate unable to reject noise — and ended up *worse* than the
> hand-authored champion. **The loop did not fail to find improvements; it was
> never able to tell whether it had found one.**
>
> **What to do about it.** Per-board pairing was measured and buys less than
> hoped — the per-board sd of the *difference* between two systems is ~4.0
> versus ~3.1–4.3 for the metric itself, because the systems go wrong on
> largely different boards. So the budget is set almost entirely by board
> count: `se = 4.0 / sqrt(n_boards)`.
>
> | to resolve | boards |
> | --- | --- |
> | 0.5 IMP/bd | 246 |
> | 0.3 | 683 |
> | 0.1 | 6,147 |
> | 0.03 (current floor) | 68,296 |
>
> At ~0.29 s/board with `--jobs 8`, **~6,000 boards costs about 30 minutes**.
> Resolving 0.1 IMP/board is genuinely affordable — the 96-deal default
> resolves only ~0.8, which is a configuration choice, not a hardware limit.
> Use `boards_needed(target)` to size a run before trusting its verdict.
>
> **The gap the loop needed to see was smaller than its own screen.** Measured
> at 2,054 boards (§6.18), champion beats `improved_system.dsl` by
> **+0.275 ± 0.084 IMP/board** (t = 3.26) — significant, but below the 0.8 that
> 96 boards can resolve. The flywheel could not tell the system it was
> producing from the one it should have been producing. An earlier figure of
> 1.069 for this gap was a training-seed artifact, inflated ~4x.
>
> **Acting on it.** Every run prints its own resolution up front, so a 48-deal
> run no longer looks like a well-powered one:
>
> ```bash
> # ~750 boards resolves 0.29 IMP/board — enough to see the real gap.
> # --state keeps the experiment from bumping the real version counter.
> python3 -m bid.flywheel --deals 750 --rounds 2 \
>     --metric mean_imp_loss --panel --jobs 8 \
>     --val-seeds 7,13,21,29,35 \
>     --target system/champion_evolved.dsl \
>     --state /tmp/flywheel_experiment.json
> ```
>
> `--val-seeds` buys generalisation resolution linearly (2 sets → 0.58 IMP/bd,
> 5 sets → 0.37); `--deals` buys screening resolution as `1/sqrt(n)`.
>
> **But resolution is not the only problem.** Re-tested at 806 boards where
> 0.276 *is* visible, **0 of 7 curated families reached significance, and 3
> (BALANCING, NT_SAFETY, OVERCALLS) had exactly zero effect** — identical score
> on all 806 boards. Not because their guards never fire: they match 51–288
> times at N/S seats, usually proposing a call not already in φ(s). It is
> because of how the two components interact — see §6.19 and §6.21.
>
> **The search barely runs.** `PIDMEngine.decide` short-circuits on a single
> candidate (`if len(actions) == 1: return action`) — no worlds sampled, no
> lookahead, no DDS. And φ(s) is a singleton at **92.8%** of champion's
> decisions (87.1% for `improved_system.dsl`):
>
> | system | \|φ\|=1 | 2 | 3+ | search runs |
> | --- | --- | --- | --- | --- |
> | champion | 92.8% | 6.7% | 0.5% | **7.2%** |
> | improved | 87.1% | 11.4% | 1.6% | **12.9%** |
>
> So the DecisionNet is the decision procedure ~93% of the time, and the
> expensive machinery (RBMBMC sampling, lookahead, native DDS) is exercised on
> ~7%. Consistent with that, **strengthening the search does nothing**:
> sampling 2/6/0.06 → 4/12/0.25 gives −0.030 ± 0.082 (t = −0.36) and costs 1.7x;
> lookahead depth 1 → 2 gives *exactly* 0.000 in the same wall-clock (§6.20).
>
> **And ablating the search changes nothing.** A `NoSearchEngine` that always
> takes the fast path scores 6.2039 vs 6.2209 with search — the search is worth
> **−0.017 ± 0.013 IMP/board** (t = −1.30, CI upper +0.009). The ambiguous 7%
> is also not where the value is: boards containing one lose 0.677 IMP/board
> *less* than unambiguous ones, and are 26.0% of boards but 23.9% of IMP lost
> (§6.22–§6.23).
>
> **Bottom line.** Every lever measured at 400–2,054 boards is
> indistinguishable from zero — rule families (+0.03, CI upper +0.09), stronger
> sampling (−0.030), deeper lookahead (exactly 0.000), ID3 (negative), and the
> search itself (−0.017). The one thing that has ever moved this system is a
> human writing better rules: champion beats 28 rounds of automated patches by
> **+0.275 ± 0.084**. That is a structural conclusion about the approach, not a
> tuning problem.
>
> **So where should a human work?** Champion loses 6.458 IMP/board, and only
> 12.4% of boards are at par — the worst decile holds just 22.8% of the loss,
> so this is a broad shortfall, not a fixable tail. Of the attributed loss:
>
> | flaw | boards | share | ≈IMP/case |
> | --- | --- | --- | --- |
> | MISSED_SLAM | 43 | 33.7% | 14 |
> | MISSED_GAME | 98 | 32.6% | 9 |
> | OVERBID_DOWN | 123 | 25.1% | 6 |
> | SOFT_DEFENSE | 79 | 8.6% | 4 |
>
> **Underbidding is ~66% of it** (slam + game), from 41% of flagged boards —
> note `severity_pts` is in *points*, not IMP, and diagnostics only fire below
> −10 points, so 463 boards with loss carry no label at all.
>
> **Ablation then sharpened the target (§6.25).** Deleting champion's 32
> game-or-higher rules costs **+0.1835 ± 0.178 IMP/board** — the largest effect
> any rule group has shown — but those same rules also account for 58 of the
> 116 overbids. The lever is **discrimination, not aggression**. Two more
> findings change the plan:
>
> - **Slam is structurally unreachable.** Champion's only 5-level calls are two
>   sacrifice rules that never fire, so there is no cue-bid/Blackwood route to
>   6: **0 slams in 206 boards** where par wanted 14. Its 6-level rules fire
>   only inside search continuations.
> - **Do not read the par gap as timidity.** Champion stops at 1–2 on 67.3% of
>   boards it should declare, vs par's 24.8% — but SAYC stops on **93.1%** and
>   improved on 76.2%. Par is double-dummy; everyone falls short. What matters
>   is the ranking, and it matches the scoreboard: champion bids game 31.7%,
>   improved 18.8%, SAYC 2.0%.
>
> Highest-value concrete work: a live 5-level ladder, and closing the responder
> coverage hole (34.3% of underbid boards are *one bid then three passes* at
> 22–25 combined HCP).
>
> **Priced, and the answer is "not yet" (§6.27).** Every one of those passes is
> a fallback — φ(s) = {PASS}, no rule matched, 41 of 41 — so it really is a
> coverage hole. But filling it with `improved_system`'s answer measures
> **−0.027 ± 0.145 IMP/board** (824 boards, paired): it removes 20 missed games
> and slams and adds **45 overbids**. Underbids become overbids, ~1:2.6. The
> hole is worth ~0 until something supplies better *discrimination*, which is
> the same wall §6.19–§6.25 keep hitting.
>
> **The hole is not the cause, and it is now closed (§6.33).** Filling the same
> hole with a *conservative* donor — only the 16 level-1 rules of
> `improved_system`, so underbids become live auctions rather than overbids —
> is significantly **worse**: **−0.098 ± 0.042 IMP/board (t −2.36)** on 836
> boards, ~209 interventions producing **0 extra games** and +12 overbids,
> about −0.39 IMP each. So the two donors span the trade-off and neither
> produces games: the aggressive one buys them by overbidding, the conservative
> one buys nothing at all. Bidding on hands champion chose to pass is worse
> than passing, however meek the bid.
>
> (An earlier version of this experiment used champion's *own* level-1 rules as
> donor and reported 0 fills. That result was vacuous:
> `DecisionNet.actions()` falls back to PASS only when **no** rule matched, so a
> donor that is a **subset** of champion's rules provably cannot fire there. A
> null is only evidence once the patch is confirmed to have fired *and* the
> contrast is not impossible by construction.)
>
> **Corrected by §6.39: the ladder to game already exists; the 5 level does
> not.** Inspecting the rules (rather than inferring from behaviour) shows
> champion has **29 raise rules** and **21 level-4 rules**, including
> `1S→2S`, `1S→3S` (limit), `2S/3S→4S` and `1M→4M` — so "build a ladder" is
> the wrong instruction. What is absent is the 5 level: exactly two level-5
> rules, both non-vulnerable sacrifices over the opponents' 4M, and six level-6
> rules that jump straight to 6 on 20–23+ HCP. No Blackwood, no 5-level cue bid,
> no slam try — which is why §6.25 measured 0 slams in 206 boards and §6.38
> finds MISSED_SLAM the largest and most stable category (34.4%). The concrete
> work is a 4NT ace-asking bid with 5-level responses (or 5-level cue bids):
> small, well-understood, currently absent. Champion's residual game shortfall
> is guard thresholds, not structure — `SUP_GAME_4S_AFTER_RAISE` needs hcp 16–22
> *and* 5+ spades, so a 15-count opener has no rule and stops at 2S.
>
> (Earlier text, superseded:) ~~**What is actually missing is a bidding
> ladder.**~~ Champion stops at 1–2 on
> 67.3% of boards *with* its rules firing (§6.25), and inserting a call where
> no rule fires does not reach game either (§6.33) — because the rest of the
> ladder still stops low. Every mechanism here — candidate generation, PIDM
> search, ID3, co-training, convention invention — optimises **one decision in
> isolation**. Reaching game requires a *sequence*. That is the most economical
> explanation for why 28 automated rounds added nothing and one human writing
> 90 rules added +0.275.
>
> **The headline metric is not a loss — and fixing it is nearly free (§6.28).**
> `mean_imp_loss` is `abs(deviation from double-dummy par)`, so beating par
> scores exactly like missing it. Measured on champion (830 boards): 45.3% of
> boards **beat** par (+2,900 IMP) against 41.8% that lost (−2,378), so
> **54.9% of the reported "loss" is actually gain**, and the mean signed value
> is *+0.63* IMP/board. Half of that is artifact: par belongs to E/W on 51.5%
> of boards, and the panel opponents (SAYC 10 rules, Precision 8, 2/1 GF 15 —
> `gib.dsl`/`precision.dsl`/`blue_club.dsl` all parse to 0 rules, so nothing
> stronger exists) cannot bid their own games, giving us phantom +18 IMP boards.
> Worse, `abs()` cancels the signal exactly where two systems disagree in sign.
> The new signed metric `mean_imp_diff` measures the champion→improved gap at
> **+1.267 ± 0.318 (t 7.81) on 836 boards**, where the abs metric gives a
> non-significant +0.071 on the same boards and needed 2,054 to reach t 3.26.
>
> **But two thirds of that gap is artifact — the opponents are 10–20× too weak
> (§6.34).** The panel is built from 10/8/15-rule skeletons, while `system/`
> already contains three hand-authored systems that have never been used as
> opponents: `blue_club.dsl` (183 rules), `precision.dsl` (166) and `gib.dsl`
> (159) — 2,328 lines that parse to **0 rules** under the DecisionNet loader
> because they are a *legacy* dialect (`OPEN 1C:` / `HCP:` / `SHAPE:`), reachable
> only via `SystemTranslator` + `DecisionNet.wrapped_system`. Scored against
> those instead (606 boards, paired):
>
> | panel | champion signed | improved signed | champion − improved |
> |---|---|---|---|
> | current skeletons | +0.2756 | −0.9901 | **+1.2657 (t 6.55)** |
> | legacy systems | +0.3812 | −0.0842 | **+0.4653 (t 1.78)** |
>
> The gap shrinks to about a third. **Measured properly at 2,006 boards (§6.37)
> the gap is +0.732 (t 5.41) against the legacy systems — smaller than +1.246
> (t 11.85) against the skeletons, a 41% reduction, but still significant.** The
> 606-board figure above was underpowered, not null. The artifact is
> asymmetric: champion's own score is stable (−0.106 ± 0.327), while
> `improved`'s moves by −0.906 ± 0.455 — the weak panel made the *worse* system
> look far worse. It also **reclassifies flaws**: MISSED_GAME falls 80→54 for
> champion and 107→40 for improved, while SOFT_DEFENSE rises 54→82 and 59→111,
> with no change in our own bidding — when opponents bid competently they buy
> the contract and the board becomes a defensive one. So the loss attribution
> behind §6.24/§6.25/§6.31 is opponent-dependent too. At 2,006 boards (§6.37)
> the effect is stark: improved's MISSED_GAME falls from **352 to 161** while
> champion's falls 230→166 — so under competent opponents the two miss
> essentially the same number of games (161 vs 166), and improved's remaining
> 0.73 IMP/board deficit is overbidding (322 vs 254) and defence (350 vs 286),
> not underbidding.
>
> **Champion's own score is panel-invariant; improved's is not.** Signed +0.6281
> vs +0.6291 for champion across the two panels (a difference of 0.001), against
> −0.6176 vs −0.1027 for improved (a swing of 0.515). Champion's strength does
> not depend on who it is playing.
>
> **Re-derived under competent opponents (§6.38) — where to author survives, why
> does not.** The method reproduces §6.24 on the skeleton panel (missed slam
> 37.5% + missed game 29.8% = 67.3%), so the shift is real. Against the legacy
> systems:
>
> | flaw | skeleton share | legacy share | legacy boards |
> |---|---|---|---|
> | MISSED_SLAM | 37.5% | 34.4% | 116 |
> | OVERBID_DOWN | 24.1% | 23.5% | 256 |
> | MISSED_GAME | 29.8% | **20.8%** | 167 |
> | SOFT_DEFENSE | 8.5% | **19.9%** | **286** |
>
> Missed game + missed slam falls from **67.3% to 55.2%**; failing to compete
> over the contract more than doubles and becomes the **most frequent** flaw.
> But the §6.31 ordering is confirmed: per board slam is worth about twice game
> (−6.30 vs −3.19), while in total game is worth about twice slam (−1,699 vs
> −844 IMP) because there are 4× as many game boards — a 2.0× ratio against
> §6.31's 2.3×. So **do game accuracy first**, and treat competition/defence as a
> large region the default panel hid entirely — **but not yet as a proven
> target**: `SOFT_DEFENSE` is a catch-all (`diagnostics.py:191` tags every board
> the opponents declare; `:221` is the fallback for any unmatched loss), and its
> severity is the board's whole shortfall rather than what competing would have
> recovered. Since double-dummy par already prices the sacrifice option, boards
> whose par belongs to E/W are ones where bidding on was not profitable by
> construction. Split the category before spending effort there — especially as
> §6.33 (−0.098/board) and §6.27 (−0.027) both found that bidding more actively
> *loses* IMPs.
>
> Adopt the signed metric because `abs()` is not a loss — not because it is
> cheaper, since the "~3× resolution" figure is calibrated on the weak panel
> and disappears under a strong one. Fix the opponents as well: add a
> `--panel legacy` option rather than replacing the panel (28 recorded versions
> are scored against the current one), and make the legacy systems picklable
> first — their rule tests were closures, so they could not be sent to `spawn`
> workers and every strong-panel number above had to run with `jobs=1`.
>
> **Both are now available from the CLI (§6.36).**
>
> ```bash
> # strong opponents (183/166/159 rules instead of 10/8/15), ranked by the
> # signed metric; bare --panel still means the original skeletons
> PYTHONPATH=src python3 -m bid.eval_vs_dds --boards 48 --panel legacy \
>     --metric mean_imp_diff
> ```
>
> `--panel` accepts `default` or `legacy` (plain `--panel` = `default`, unchanged
> behaviour), and `--metric` accepts `mean_imp_diff`, which is signed — positive
> means beating double-dummy par. `evaluate_panel` previously did not compute it,
> so selecting it would have raised `KeyError`; it now prints an **IMP diff/bd**
> column next to the unsigned IMP loss/bd. Regression tests in
> `tests/test_legacy_pickling.py` lock the default panel at exactly
> `[SAYC, Precision, 2/1 GF]` / `[10, 8, 15]` rules, since 28 recorded versions
> were scored against it.
>
> **That blocker is now fixed (§6.35).** The closure captured only picklable
> data, so `SystemTranslator._add_rule_from_data` now builds a module-level
> callable object `LegacyTrigger` carrying the same five values, instead of a
> nested function. Verified behaviour-preserving: 1,500 call comparisons between
> fresh and pickled systems, **0 mismatches**; 39 legacy-system tests pass; and
> 96 boards against the strong panel give bit-identical results at `jobs=1`
> (19.9 s) and `jobs=8` (10.2 s). Regression tests in
> `tests/test_legacy_pickling.py`.
> Use `--metric mean_imp_diff`. `imp_loss` is left as-is: 28 recorded versions
> depend on it.
>
> **Calibrated, with a correction (§6.28).** On 5 independent 96-deal sets the
> signed metric is *noisier per system* (sd 0.76–0.80 vs 0.32–0.44) because its
> level depends on how many boards are "E/W declares par" — **never compare
> signed levels across different deal sets**. But the paired delta is ~2.6×
> larger for only ~1.4× more noise: **t 5.11 vs 2.81 on the same 480 boards**.
> So the real gain is **~3× fewer boards**, not the ~14× a single unstable abs
> point estimate suggests; the defensible claim is that it turns a marginal or
> null result into a decisive one. (The abs noise sd was reproduced at 0.426
> vs the published 0.42, validating §6.16.)
>
> **The clearest single number (§6.30).** Head-to-head (each system plays both
> seats against the same opponent, so no par and no opponent-side artifact):
> **champion beats SAYC by 26.5 pts/board; `improved_system.dsl` LOSES to SAYC
> by 37.7.** SAYC is a 10-rule skeleton that reaches game on 2% of boards.
> Twenty-eight rounds of "validated" patches produced a system that cannot beat
> it. Power: abs t +0.54, signed t +7.81, head-to-head t +10.72 — but h2h costs
> 2 plays/board, so per unit compute it ties the signed metric (7.58 vs 7.81).
> Use h2h where the *level* must be stable across deal sets, `mean_imp_diff` for
> routine paired screening.
>
> **Reproducibility note (§6.26).** Evaluations used to be non-deterministic:
> the world sampler drew from an unseeded global RNG, so two runs of the same
> config differed. `seed_board()` now seeds per board from the board index, in
> both the serial and parallel paths — runs are bit-identical, serial and
> parallel agree, and the paired sd dropped 2.59 → 2.13 (~1.5× fewer boards for
> the same resolution).
>
> `SCREENING_NOISE_SD`, `BOARD_IMP_LOSS_SD`, `min_detectable_effect()` and
> `paired_imp_test()` in `eval_vs_dds.py` encode the measurements; the
> hill-climb prints each candidate's paired diff, 95% CI and t, and
> `validate_and_save` warns when a round's gain is below what the screen can
> resolve. Full analysis: `research/status.md` §6.16–§6.17.

Long-run hygiene (both `flywheel.py` and `autoloop.py`):
- **Eval-seed rotation** — screening/validation seeds derive from the current
  system version, so different saved versions are gated on different random
  draws (within one cycle base and candidate still share a seed, keeping the
  paired deltas honest).
- **Anchor ledger** — every version is also scored on a frozen, never-reused
  anchor deal set (`anchor` map in `flywheel_state.json`); a flat or falling
  anchor ledger means gains were seed-fitting, not real.
- **Failure-signature expiry** — failed patch candidates are cached with the
  version they failed at and become retryable after `FAIL_EXPIRY_VERSIONS`
  (8) saved versions; the system underneath them changed, so the pool never
  permanently empties.

**Human involvement:** choosing the deal budget (24 deals ≈ 10 min,
96 deals + SDS ≈ 3.3 h); occasionally re-running with fresh eval seeds to
confirm gains generalize; writing *new idea families* (see
"Adding an idea to the teacher" below).

---

### Loop B — refresh the student (neural CoT model)

```bash
python3 -m bid.refresh_student                  # auto-detects changes
python3 -m bid.refresh_student --boards 500 --epochs 5   # production scale
```

Automatically, in order:
1. **Freshness check**: `sha256(improved_system.dsl)` vs
   `data/traces/traces.meta.json` (→ regenerate traces when the teacher
   changed) and corpus sha vs `dataset.json` meta (→ rebuild dataset when
   mined rows arrived). Skips cleanly when nothing changed.
2. **Regenerate** the corpus with `trace_factory.py` (PIDM-labeled auctions
   of the *current* DSL; constraint-invariant asserted per row), then merge
   `data/traces/disagreements.jsonl` (Loop C output) into
   `corpus_combined.jsonl` and build the tokenized dataset.
3. **Train a candidate** (`python3 -m bid.cot_model train`, MPS/CUDA auto) — the
   incumbent `ckpt.pt` is never touched during training.
4. **Gate**: eval-val the candidate *and* the incumbent on the new val
   split; promote only if BID accuracy doesn't regress beyond
   `--tolerance`. Incompatible incumbent (vocab change) → the absolute
   `--min-bid` floor (default 25%) decides; weaker candidates are archived
   instead of promoted.
5. Record every decision in `data/cot_model/student_state.json`
   (hashes, scores, promoted/rejected, elapsed).

Typical durations: 200 boards end-to-end ≈ 12 min; 500 boards + 5 epochs ≈ 32 min.
Artifacts: `ckpt.pt` (+`.vocab.json`), `rejected/…` archives,
`refresh_last.log`, `student_state.json`.

**Human involvement:** choosing scale (`--boards`, `--epochs`); interpreting
a promotion that happened via the "no comparable incumbent" fallback
(vocabulary grew — old scores aren't comparable; spot-check with
`python3 -m bid.cot_model eval-val` or an arena h2h).

### Loop C — mine student ↔ teacher disagreements (feedback into both)

```bash
python3 -m bid.mine_disagreements --boards 200
```

Automatically: replays DSL-system auctions, queries the student at every
non-forced decision, and where they disagree runs a **high-budget PIDM
referee**; the verdict is written as a schema-identical trace row (tagged
`ARB_SYSTEM` / `ARB_STUDENT_LEGAL` / `ARB_THIRD` in `all_matched`), deduped
and appended to `data/traces/disagreements.jsonl` with stats in
`disagreements.meta.json`.

How to read the stats:
- `arb_system_right` — student was wrong; the row relabels it (better-than-
  corpus labels: the referee has a bigger search budget than the corpus
  labeler).
- `arb_student_right` — **the student flagged a position where the deep
  search agrees with it against the DSL** → a candidate *teacher bug*;
  feed those boards to the flywheel (or add a curated patch family) for the
  next teacher round.
- `arb_new_call` — neither player's choice survived deeper search; these
  labels are new information.

Rows are consumed automatically by `refresh_student.py` on the next cycle.
**Human involvement:** sizing the run; inspecting `arb_student_right` boards
(`explanation.all_matched` tag) for teacher improvements.

### Loop D — RL fine-tuning (student beyond its teacher)

```bash
python3 -m bid.rl_finetune --boards 64 --epochs 3 --tolerance 0.5
```

Automatically: student plays N/S against the DSL's E/W; each decision is
*samples* (temperature) with a legality check (illegal → teacher fallback,
no gradient); terminal contracts are scored by native DDS from N/S's
perspective and converted to IMPs; REINFORCE updates
(`loss = -advantage · Σ log π`) with batch-normalized advantages; the
resulting candidate is **eval-val gated** against the base checkpoint
(`--tolerance`, `--no-gate` to skip) and archived under `rejected_rl/` on
failure.

**Human involvement:** this is the only loop whose output *intentionally
diverges* from the teacher — always A/B the gated checkpoint in
`arena.py`/`ab_engine.py` at 100+ boards before adopting it as `ckpt.pt`.

### Loop E — convention invention search

```bash
python3 -m bid.convention_search --boards 96 --rounds 3
```

Automatically: mutates seed protocols (Stayman, Transfers, Blackwood, ...) —
feature retargeting, range shifts, response swaps, step drops — compiles each
candidate into DSL clones, hill-climbs on a train tier, and confirms on a
disjoint validation seed. Writes `data/conventions/search_report.json`.

**Human involvement (required):** accepted conventions are **never**
auto-installed into `improved_system.dsl`. Review the report (watch the
validation z-score — small boards produce inconclusive `escalate` verdicts),
then either promote the rules by hand, or express them as a curated flywheel
family so the standard gates apply.

### Loop F — unattended continuous operation (the meta-loop)

```bash
python3 -m bid.continuous                      # run until stopped
python3 -m bid.continuous --max-cycles 5 --sds-gate --rl-every 3
```

`continuous.py` chains the loops above into one repeating cycle — this is
what makes improvement actually *continuous* instead of five scripts a human
must schedule:

1. **teacher**: a bounded `autoloop` run (`--teacher-cycles` screening cycles).
2. **student**: `refresh_student` (auto-detects the new DSL hash, regenerates
   corpus/dataset, retrains + gates the student, and retrains the player
   model when the corpus changed).
3. **mine**: `mine_disagreements` — its `disagreements.jsonl` is merged into
   the *next* student corpus by step 2, closing the loop.
4. every `--rl-every` cycles: `rl_finetune` (off-teacher; A/B before adopting).

Each stage runs as a subprocess of the runbook script, so every per-loop gate
still applies. State persists in `system/continuous_state.json`
(`{"cycle", "next_stage"}`); a crash or Ctrl-C resumes at the interrupted
stage, and a stage failing `--max-stage-fails` consecutive cycles aborts the
loop so nothing spins unattended. Consolidated log: `debug/continuous.log`.

**Human involvement:** only budgets (`--boards`, `--tiers`, `--rl-every`),
and watching the mining summary — when `arb_student_right > 0` the student
found a position where deep search contradicts the teacher (candidate
teacher bug worth a curated patch family).

### Supporting tooling

```bash
python3 -m bid.player_model train    # soft P(call|ctx) -> data/player_models/
# auto-attached to the RBMBMC sampler by autoloop.py when present;
# refresh_student.py re-trains it automatically whenever the corpus changes
# (recorded corpus sha in call_model.json meta drives the freshness check)
```

### Human review UI (static browser app)

```bash
python3 -m bid.web_export          # snapshot repo state -> web/review_data.js
python3 -m http.server 8765 -d web # then open http://127.0.0.1:8765/
```

`web/` is a fully static, no-build review UI (pattern follows `../dds/web`
and `../ben/web`): vanilla JS modules, no framework, no server-side logic.

- **Auction Review** — generate a deal, **paste your own four hands**
  (`Load board…` accepts `SAK2 HKQJ DQJ9 C432`, dotted `AKQJ.T98.765.432`,
  or the corpus `S : A K 2 …` format, with 13-card/duplicate validation), or
  step through every decision of the *current* DSL system in the browser.
  **Pick the bidding system per team** (`N/S system` / `E/W system` selects:
  the evolved Improved system, the auto-evolved Champion, Precision, Blue
  Club, GIB — **or the neural student**) and review partnerships against
  each other, arena-style. Student seats are explained like every other
  engine: the inspector shows the full **bid-probability ranking** with
  bridge-legality marks, the legality-constrained choice, and any vetoed
  call — the student picks among the same rule-based table with its
  reasoning visible; trained/loaded students register automatically as
  selectable systems. **Every bid in the auction table is clickable** —
  after (or during) an auction, clicking a call re-opens that decision's
  full explanation (features, rules, candidate set). Completed auctions
  also get an **SDS panel** (port of `sds.py`): opponents are sampled from
  the declarer+dummy view and each world is double-dummy solved with the
  WASM DDS, reporting mean tricks vs the full-deck DD result, P(make), and
  expected duplicate score — revealing contracts that rely on favourable
  splits.
  The inspector shows the extracted
  features, every matched rule with per-condition ✓/✗, the candidate set
  φ(s), legality filtering, and the deterministic system pick; you can bid
  manually from the bidding box (any bridge-legal call) to probe the system.
  Both engine families are ported: the DecisionNet DSL (improved/champion)
  and the legacy translator engine with its constraint matcher and SEQUENCE
  trigger algorithm (precision/blue_club/gib, conventions inlined by the
  exporter); JS rule counts are asserted equal to Python's own parsers in
  `tests/web/engine_test.mjs`.
- **Replay review** — load any sampled corpus board or student↔teacher
  disagreement; each recorded call is re-verified live against the re-computed
  candidate set and feature values (`in φ(s) ✓`, `features match Python ✓`),
  with `ARB_STUDENT_LEGAL` teacher-bug rows one click away.
- **Rules Editor** — view and edit any embedded system's DSL in the browser,
  apply the edited version to a team (the auction review restarts with your
  rules, so you can probe behaviour changes decision-by-decision), and
  **download the edited DSL as a `.dsl` file** to drop into `system/` — a
  human-in-the-loop path back into the flywheel. Edits are validated by the
  same parsers; broken DSL is reported, never applied.
- **Student Lab** — an in-browser student loop at demo scale: generate a
  corpus by letting any loaded (or hand-edited) system bid N boards with the
  JS engine, train a small seeded MLP (27 features → 64 → 32 → bid vocab,
  pure JS, no dependencies) to imitate the teacher, inspect held-out accuracy
  vs the majority baseline, and **save the student locally** as
  `student.json`. A **default student ships with the UI**
  (`web/student_default.js`, auto-loaded at boot, ~74% vs 61% baseline on the
  snapshot teacher) — regenerate it against a refreshed snapshot with
  `node web/build_default_student.mjs`. Saved students can be reloaded and
  evaluated against fresh corpora at any time. An **A/B button** auctions 20
  boards with the teacher and the student respectively and reports
  contract-agreement statistics — the end-to-end complement of per-decision
  accuracy. This complements (not
  replaces) the production 5.5M-param CoT student, which still trains via
  `refresh_student.py` (Loop B).
- **Loop Data** — the teacher's anchor ledger and applied patches, the
  student's gate history, and mining statistics.
- **Double-dummy tables** come from the vendored WASM DDS
  (`../dds/web` build, MIT) — solved live in ~0.4 s per deal; the snapshot
  also embeds export-time native-`libdds` tables as a fallback for
  environments where the WASM module can't load (no `SharedArrayBuffer`).

The browser engine (`web/objects.js`, `features.js`, `bid_dsl.js`,
`bid_net.js`, `auction.js`) is a hand-ported, behaviour-exact copy of
`src/bid`'s DSL parser, feature extractor, DecisionNet evaluation, and
auction rules. It is cross-validated against Python-recorded ground truth by
`tests/web/engine_test.mjs` (feature parity + candidate-set equality on every
recorded corpus row), so what you review in the browser is what the Python
loops actually compute.

### Adding an idea to the teacher

The flywheel can only hill-climb over rules that are *expressible* and
*families that exist*. New capability enters the loop in two steps:

1. **Feature** (agent/human): add a deterministic computation to
   `BridgeFeatures.extract_auction_features` in `bid/features.py`
   (e.g., `support_in_partner_suit`, `opp_suit_stoppers`). Sanity-check it
   against a synthetic auction and `tests/test_features_and_state.py`.
   Features propagate to traces/dataset automatically.
2. **Patch family** (agent/human): write a `p_<name>(net)` function in
   `flywheel.py` that emits `DecisionNetRule`s gated on the new features,
   and register it in the `CURATED` dict. From then on the flywheel
   screens, tunes thresholds, and val/SDS-gates it like any other patch.

Campaign record so far: `SUPPORT` accepted (v23, +23.7), `NT_SAFETY`
rejected (−40.4), `AGGRESSION` positive standalone but subsumed by TKO
patches — every rejection is cached by signature and never retried.

### What stays with a human

| Decision | Why |
|---|---|
| Run budgets (deals/rounds/tiers, hours) | statistics-vs-time tradeoff |
| New features & curated families | domain judgment; the loop can't invent features itself |
| Fresh-eval-seed spot checks | guards against seed-fitting across many saved versions |
| Convention promotions from `search_report.json` | statistical gate is the script's, but adoption is a system-design choice |
| RL checkpoint adoption | intentionally off-teacher; A/B in the arena first |
| Interpreting "no comparable incumbent" promotions | vocab changed → run an arena h2h to confirm |

### Command cheat sheet

| Script | Loop | Purpose | Typical run | Key artifacts |
|---|---|---|---|---|
| `continuous.py` | F | unattended A→B→C chaining with stage resume | days/weeks | `continuous_state.json`, `debug/continuous.log` |
| `flywheel.py --deals N --rounds R --sds` | A | patch hill-climb on the DSL | 10 min – 3.3 h | `improved_system.dsl`, `history/`, `flywheel_state.json` |
| `autoloop.py --tiers 24,96,384 [--policy-prior ckpt]` | A | unattended staged loop + champion promotion | hours | `champion_system.dsl`, `debug/progress.json` |
| `refresh_student.py [--boards B --epochs E]` | B | regen corpus/dataset, train + gate student | 12–32 min | `ckpt.pt`, `student_state.json` |
| `mine_disagreements.py --boards N` | C | student-vs-teacher arbitration rows | ~3 s/board | `disagreements.jsonl` |
| `rl_finetune.py --boards N [--tolerance t]` | D | REINFORCE beyond the teacher | ~1 min/4 boards | `ckpt_rl.pt` + gate |
| `convention_search.py --boards N` | E | protocol mutation search | ~2 min/12 boards | `search_report.json` |
| `player_model.py train` | support | soft world-consistency model | seconds | `call_model.json` |
| `web_export.py [--boards N]` | review | snapshot repo state for the browser UI | ~1–2 min (native DD solves) | `web/review_data.js` |

---

## 🚀 Quick Start

### Installation

Python 3.9+ is required. Clone the repository and install in editable mode:

```bash
git clone https://github.com/ed2k/bid.git
cd bid
python3 -m venv .venv && source .venv/bin/activate
pip install -e .
```

This installs all dependencies (`torch`, `numpy<2`) and registers CLI console scripts (`bid-flywheel`, `bid-autoloop`, `bid-continuous`, `bid-refresh-student`, `bid-mine-disagreements`, `bid-rl-finetune`, `bid-convention-search`).

You can execute any loop using `python3 -m bid.<module>` or directly via CLI aliases:

```bash
python3 -m bid.flywheel --deals 96 --rounds 2 --sds
# or CLI script:
bid-flywheel --deals 96 --rounds 2 --sds
```

### The self-improvement loops

The primary workflow is the six-loop system documented in the
**[Runbook](#-operating-the-teacher--student-loops-runbook)** above:
`continuous.py` (unattended chaining of everything below) or manually:
flywheel (teacher) → `refresh_student` (student) →
`mine_disagreements` (feedback) → `rl_finetune` /
`convention_search` (beyond-imitation). Start there.

### Legacy: co-training pipeline demo

`main.py` drives the older invention/co-training path directly:

```bash
python3 -m bid.main --iterations 10 --duration 120 --states 8 --deals 25
```

This demonstrates `BidInventionEngine` co-training and diagnostic refinement
in one process, but the runbook loops supersede it for real improvement
work (they add validation gates, versioning, and the neural student).

### Finding the Best Bidding System (World Championship Tournament)

Run a multi-board round-robin tournament (evaluating competing archetypes like Precision Strong Club, Modern 2/1 GF, SAYC, and a 2/1 + conventions archetype) to find the champion system:

```bash
python3 -m bid.main --tournament --boards 50
```

The champion bidding system code is automatically persisted to `system/champion_system.dsl`.

---

## 🧪 Pipeline Usage Examples

These are **component-level API examples** — the building blocks the runbook
loops orchestrate. For the full automated workflow, use the runbook scripts
(`flywheel.py`, `refresh_student.py`, `mine_disagreements.py`, ...).

### 1. Running the Continuous Co-Training Loop

> Loop A (`flywheel.py`/`autoloop.py`) automates this at system scale with
> validation gates; the API below shows the underlying mechanism.

```python
from bid.invention import BidInventionEngine

# Initialize engine with RBMBMC sampler and PIDM lookahead
engine = BidInventionEngine(sample_size=3, max_lookahead_depth=2)

# Run iterative parallel co-training rounds between North and South
results = engine.run_co_training(rounds=3, states_per_round=10)

for round_info in results["rounds"]:
    print(f"Round {round_info['round']}: "
          f"North refined {round_info['north_refinements']} conflict nodes, "
          f"South refined {round_info['south_refinements']} conflict nodes.")
```

### 2. Active Ambiguity Discovery and ID3 Refinement

```python
from bid.decision_net import DecisionNet, DecisionNetRule, RuleCondition
from bid.learner import DecisionNetLearner, ID3DecisionTree
from bid.pidm import PIDMEngine
from bid.models import Seat, Call, CallType, Strain, Hand

# 1. Base Decision Net with overlapping rules (1NT vs 1H on 15-17 HCP 5-heart balanced)
net = DecisionNet("PartnerNet")
net.add_rule(DecisionNetRule("R_1NT", Call(CallType.BID, 1, Strain.NT), [
    RuleCondition("hcp", ">=", 15), RuleCondition("hcp", "<=", 17), RuleCondition("is_balanced", "==", True)
]))
net.add_rule(DecisionNetRule("R_1H", Call(CallType.BID, 1, Strain.HEARTS), [
    RuleCondition("hcp", ">=", 12), RuleCondition("hcp", "<=", 21), RuleCondition("heart_len", ">=", 5)
]))

# 2. Learner finds ambiguous states where |φ(s)| > 1 and tags with expensive PIDM teacher
teacher = PIDMEngine()
learner = DecisionNetLearner(teacher)
models = {s: net for s in Seat}

ambiguous_states = learner.find_ambiguous_states(net, target_count=15)
tagged_data = learner.tag_states(ambiguous_states, models)

# 3. ID3 builds local decision tree and attaches directly to intersection node
learner.refine_decision_net(net, tagged_data)

# Now ambiguous hands evaluate in O(1) time without search!
hand = Hand.from_string("SAK4 H76543 DAQ3 CK2")
resolved_call = net.actions(hand, history=[])
print(f"Resolved call: {resolved_call}")
```

### 3. Stratified Rare-Hand Sampling & Experience Buffer

```python
from bid.experience import StratifiedDealGenerator, ExperienceBuffer, PrioritizedExperience
from bid.models import Suit, Seat, Call, CallType, Strain
from bid.sampling import PartialState

# Generate a rare 9-card spade hand directly to avoid Monte Carlo blindspots
rare_hand = StratifiedDealGenerator.generate_hand_with_suit_length(Suit.SPADES, min_length=9)

buffer = ExperienceBuffer(max_capacity=500)
ps = PartialState(Seat.SOUTH, rare_hand, [])

# Calculate priority based on rarity and search disagreement
priority, reason = buffer.calculate_priority(
    rare_hand,
    policy_actions={Call(CallType.BID, 1, Strain.SPADES)},
    teacher_call=Call(CallType.BID, 4, Strain.SPADES),
    value_gap=120.0
)

buffer.add(PrioritizedExperience(ps, {Call(CallType.BID, 1, Strain.SPADES)}, Call(CallType.BID, 4, Strain.SPADES), priority, reason))
print(f"Added state to replay buffer (priority={priority}, reason={reason})")
```

### 4. Synthesizing Conventions & Measuring Value of Information (VOI)

> Loop E (`convention_search.py`) automates search over this protocol space
> with paired arena evaluation; the API below measures a single protocol.

```python
from bid.protocol import ConventionProtocol, ValueOfInformationEvaluator
from bid.pidm import PIDMEngine
from bid.models import Seat, Call, CallType, Strain
from bid.sampling import Deal, PartialState
from bid.eval_vs_dds import load_decision_net_dsl

# Compile a synthesized Stayman protocol (2C ask -> 2D/2H/2S step responses)
stayman = ConventionProtocol.create_stayman()
rules = stayman.compile_to_rules()

# Sample decision points for the opener after partner's Stayman 2C ask:
#   W passes, N opens 1NT, E passes, S bids 2C  ->  it's North's turn
engine = PIDMEngine()
net = load_decision_net_dsl("system/improved_system.dsl")
models = {s: net for s in Seat}
sample_states = []
for _ in range(20):
    deal = Deal.random_deal(dealer=Seat.WEST)
    hist = [Call(CallType.PASS),
            Call(CallType.BID, 1, Strain.NT),     # North opens 1NT
            Call(CallType.PASS),
            Call(CallType.BID, 2, Strain.CLUBS)]  # South asks Stayman
    sample_states.append(PartialState(
        Seat.NORTH, deal.hands[Seat.NORTH], hist,
        deal.dealer, deal.vuln))

voi_eval = ValueOfInformationEvaluator(engine)
voi_score = voi_eval.evaluate_voi(stayman.steps[0], sample_states, models)
print(f"Stayman query VOI: +{voi_score:.2f} IMP-equivalent")
```

---

## 🧪 Running Tests

Install the package in editable mode:
```bash
pip install -e .
```

Run the complete test suite:
```bash
python3 -m unittest discover tests
```

Individual test suites:
```bash
python3 -m unittest tests/test_features_and_state.py
python3 -m unittest tests/test_scoring.py
python3 -m unittest tests/test_rbmbmc_sampling.py
python3 -m unittest tests/test_pidm_lookahead.py
python3 -m unittest tests/test_id3_refinement.py
python3 -m unittest tests/test_cotraining.py
python3 -m unittest tests/test_experience_and_stratified.py
python3 -m unittest tests/test_protocol_synthesis_and_voi.py
python3 -m unittest tests/test_bid_invention_e2e.py
python3 -m unittest tests/test_cot_bidder.py
python3 -m unittest tests/test_sds_scoring.py
python3 -m unittest tests/test_trace_manifest.py
```

> Note: the loop scripts (`bid.flywheel`, `bid.refresh_student`,
> `bid.mine_disagreements`, `bid.rl_finetune`, `bid.convention_search`) are
> validated by their built-in gates (val-seed, SDS, eval-val) rather than
> unit tests; `tests/test_autoloop.py` and `tests/test_trace_manifest.py`
> cover their state/manifest plumbing.

---

## 📂 Project Structure

```
bid/
├── pyproject.toml       # Modern Python packaging & CLI console scripts
├── README.md            # Comprehensive architecture guide & runbook
├── system/              # Bidding system definitions & DSL files (SAYC, Precision, Improved)
├── data/                # traces/, cot_dataset/, cot_model/, player_models/, conventions/
├── web/                 # Static browser review UI (JS engine port + WASM DDS + snapshot)
├── tests/               # Unit and integration test suite (256 tests)
├── tests/web/           # JS engine checks, run with node (387 + 12 checks)
├── research/
│   ├── bid-invention.md # Research document on BIDI, RBMBMC, VOI, and CoT distillation
│   └── experiments/     # Archived diagnostic and one-off experimental scripts
│
└── src/bid/             # Core Python package
    ├── __init__.py
    ├── models.py        # Core domain models: Hand, Card, Call, Seat, Strain, Rank
    ├── features.py      # BridgeFeatures extractor (250+ numerical & auction features)
    ├── scoring.py       # Contract scoring, 24-band IMP scale, trick estimators
    ├── decision_net.py  # DecisionNet, RuleCondition, IntersectionNode, legality filtering
    ├── sampling.py      # Deal, PartialState, RBMBMCSampler, inconsistency scoring
    ├── pidm.py          # PIDMEngine with Monte Carlo lookahead & nested player simulation
    ├── learner.py       # ID3DecisionTree, DecisionNetLearner, intersection refinement
    ├── cotrain.py       # CoTrainer for parallel partner learning & model exchange
    ├── experience.py    # StratifiedDealGenerator, ExperienceBuffer, exploration generator
    ├── protocol.py      # ConventionProtocol, bidirectional & competitive VOI
    ├── invention.py     # BidInventionEngine facade
    ├── engine.py        # Traditional rule-matching engine
    ├── system.py        # BiddingSystem rule engine & convention manager
    ├── translator.py    # DSL rule parser & compiler
    ├── lin.py           # BBO LIN file parser
    ├── constraints.py   # HandConstraints representation
    ├── eval_vs_dds.py   # Deal generation, DSL loading, arena-vs-par evaluation
    ├── diagnostics.py   # ParDiagnosticEngine flaw classification
    ├── sds.py / dds.py  # SDS two-hand scorer & native double-dummy solver interface
    │
    │   # --- Neural Student & Active Learning (CoT) ---
    ├── cot_model.py     # 5.5M decoder-only CoT transformer reasoner
    ├── cot_tokenizer.py # Field-level tokenizer for CoT traces
    ├── cot_bidder.py    # Constrained decoding + verification
    ├── trace_factory.py # PIDM-labeled trace generator from current DSL
    ├── build_cot_dataset.py # Trace corpus -> tokenized dataset
    ├── player_model.py  # Learned soft P(call|ctx) for RBMBMC world filtering
    │
    │   # --- Self-Improvement Loops (Orchestrators) ---
    ├── flywheel.py      # Loop A: DSL patch hill-climb (curated/diag/gate/mutation pool)
    ├── autoloop.py      # Loop A: unattended staged loop + champion promotion
    ├── continuous.py    # Loop F: meta-orchestrator chaining A→B→C with stage resume
    ├── refresh_student.py # Loop B: freshness -> regen -> train -> gate -> promote
    ├── mine_disagreements.py # Loop C: student-vs-teacher disputes arbitrated by heavy PIDM
    ├── rl_finetune.py   # Loop D: REINFORCE self-play fine-tuning with eval gate
    ├── convention_search.py # Loop E: protocol mutation hill-climb
    └── web_export.py    # Human-review UI snapshot exporter (repo state -> web/)
```

---

## 📚 References & Background

- **Amit & Markovitch (2006)**: *"Learning to Bid in Bridge"*, Machine Learning 63(3), 287–327.
- **[research/bid-invention.md](file:///Users/admin/Documents/GitHub/bid/research/bid-invention.md)**: In-depth analysis of BIDI reconstruction, RBMBMC vs PIMC, speedup learning, active/stratified state discovery, and convention protocol synthesis.
