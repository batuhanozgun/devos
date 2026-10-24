# SOUL Research Dimensions — property-first remap and negative-boundary test

**Status:** active adversarial check; revised D1–D11 not yet canonical
**Date:** 2026-08-30

## Purpose

Test whether the Stage-5 D1–D11 map is genuinely discriminating after the D10 split and hazard-aware D6 revision.

A dimension fails this gate if:

- an external property can only fit through semantic stretching,
- the same property can be assigned to several dimensions with no principled discriminator,
- a dimension has no meaningful negative boundary and can absorb almost anything,
- its pre-architecture stopping obligation is indistinguishable from a neighbour.

# Part A — property-first remap of S1–S4

The property is named before the dimension. Mapping is secondary.

## S1 — NASA analytical decision support

### Properties first

1. intended decision/outcome and decision context,
2. explicit criteria/preferences,
3. alternatives,
4. uncertainty/sensitivity,
5. distinct decision authority,
6. analysis depth proportional to consequence/risk,
7. value of additional information versus cost/delay.

### Revised mapping

- intended outcome/context → **D1**
- preferences/value boundary + decision authority → **D4**
- uncertainty/sensitivity + evidential support → **D5**
- deciding whether more analysis is the right next work and at what depth → **D10**
- alternative-evaluation method itself → candidate task-specific capability under **D2**, not a core property
- risk/consequence proportionality → **V2**

### D11?

NASA decision-analysis guidance used here does not itself require D11. Selecting additional analysis is a D10 question; a separate execution-lifecycle property would need evidence about continuity/handoff/progression of that analysis.

### Stretch flag

No material stretch after D10/D11 split.

D2 remains safe only if `alternative evaluation` is treated as a task-specific capability candidate and not as proof of a stable core role/process.

---

## S2 — Cochrane / PRISMA systematic evidence synthesis

### Properties first

1. explicit review/eligibility boundary,
2. source entity versus multiple reports/representations,
3. search-space coverage and selection trace,
4. iterative search development,
5. method-specific stopping/completeness tests,
6. update/freshness,
7. documented residual uncertainty and rationale.

### Revised mapping

- review/eligibility boundary → **D1**
- entity/report distinction + retrieval/freshness → **D3**
- evidence selection, limitations, completion justification → **D5**
- reconstructable search/selection trace → **D8**
- whether to continue searching / which search action has highest information value → **D10**
- continuity of an update cycle or assumption-triggered rerun, when it becomes an operational progression problem → **D11**
- source/view fidelity → **V3**
- risk/value-of-information depth → **V2**

### Stretch flag

The earlier map put most iterative search work under old D10. The split improves discrimination:

- `should we search more / what next?` → D10;
- `can a selected search/update cycle progress, resume and replan correctly?` → D11.

No new dimension forced.

---

## S3 — NIST / FEMA dynamic incident operations

### Properties first

1. changing external-world state,
2. ongoing situational awareness,
3. time-bounded objective/plan validity,
4. objective/resource prioritisation,
5. repeated plan → execute → evaluate → revise,
6. containment/recovery,
7. lessons can feed improvement while operations continue,
8. command/delegation/accountability,
9. status/resource tracking.

### Revised mapping

- changing external state / plan assumption freshness → **D3**
- objective boundary → **D1**
- choosing priorities/resources/next response work → **D10**
- plan execution, responsibility, handoff, operational-period progression and replanning → **D11**
- containment/recovery → **D6**
- lessons/evolution → **D7**
- command/accountability → **D4**
- status/resource visibility → **D8**
- consequence/risk proportionality → **V2**

### Stretch flag

The D10/D11 split materially reduces stretching. FEMA/NIST was previously making one D10 carry both selection and dynamic progression.

No new dimension forced.

---

## S4 — FAA aviation safety management / physical operations

### Properties first

1. safety risk is part of operational decision-making,
2. hazards can be material before failure occurs,
3. unacceptable risk triggers controls/mitigations,
4. assurance monitors whether controls remain effective,
5. operational/environment change can expose new hazards or invalidate controls,
6. risk acceptance and accountability are explicit,
7. competency/training/lesson dissemination matter,
8. interfaces require authority/responsibility/communication clarity.

### Revised mapping

- hazard/risk representation + prevention/control + failure/recovery surface → **D6**
- control-effectiveness evidence / assurance / closure → **D5**
- risk acceptance / authority / accountability → **D4**
- operational-environment freshness → **D3**
- selected corrective/mitigation work → **D10**
- implemented control progression and change-triggered re-evaluation/replanning → **D11**
- competency/capability sufficiency → **D2**
- lesson dissemination / controlled future change → **D7**
- monitoring/reconstructability → **D8**
- physical consequence / irreversibility / proportionality → **V2**

### Stretch flag

The holdout required a real wording change to D6. Treating prospective hazard as only `failure` was too post-hoc.

After the hazard-aware revision, no separate safety dimension is forced.

# Part B — explicit negative boundaries

## D2 — capability/function necessity, coverage and task-specific composition requirements

### D2 owns

- what function/capability is necessary for the intended outcome and control obligations,
- whether an existing capability is sufficient, must be adapted or is genuinely missing,
- whether a proposed durable function is justified across task/system requirements,
- task-specific composition requirements at a property/function level.

### D2 must NOT absorb

- **what work should happen next** → D10
- **how selected work executes, hands off, schedules or replans** → D11
- **whether a capability's result is sufficiently evidenced/correct** → D5
- **whether a durable capability may be admitted/changed after learning** → D7
- **who is authorised to use/approve it** → D4
- **what belongs to stable core versus generated task system** → D9
- a domain method merely because it is useful; usefulness only makes it a candidate task-specific capability, not a core invariant.

### Boundary falsifier

If future analyses repeatedly require D2 to decide work priority, runtime progression, evidence sufficiency or core placement, D2 remains a catch-all and must be split/reframed again.

---

## D6 — hazard/failure representation, prevention, containment, recovery and liveness

### D6 owns

- prospective hazards/risk exposures relevant to system control,
- failure/uncertainty/non-completion states,
- prevention/detection/containment/recovery/regression obligations,
- proximate/root-cause control analysis,
- liveness failure such as deadlock/starvation/oscillation when it is a failure property.

### D6 must NOT absorb

- **stale or missing information as an information-integrity problem** → D3, unless analysing its hazard/failure consequence
- **wrong substantive next-work choice** → D10
- **routine execution sequencing/handoff/progression** → D11, unless analysing its failure/recovery path
- **whether a claim is proven or completion evidence is valid** → D5
- **long-term lesson/capability admission** → D7
- **authority to accept risk or approve action** → D4
- every negative outcome in the system; a problem belongs in D6 only when the research question is about hazard/failure representation or control/recovery semantics.

### Boundary falsifier

If `hazard` makes D6 the default home for any uncertainty, risk or undesirable outcome, the revision failed. D6 needs a control/failure semantics question, not merely a bad consequence.

---

## D11 — work lifecycle, orchestration, continuity and replanning

### D11 owns

- progression of already-selected work through states/dependencies,
- responsibility continuity and handoff,
- scheduling/concurrency/resource execution constraints,
- continuation after fresh session or actor change,
- replanning when current plan assumptions/state become invalid,
- execution-level orchestration without presupposing agent topology.

### D11 must NOT absorb

- **what objective/work definition is correct** → D1
- **what substantive work should be selected next / what depth is justified** → D10
- **what capabilities/functions the system needs** → D2
- **who may act/approve** → D4
- **whether output is sufficiently verified/complete** → D5
- **hazard/failure containment or recovery policy** → D6
- **future-system evolution/admission** → D7
- **what should be stable core** → D9

### Boundary falsifier

If every process or sequence problem is automatically called orchestration, D11 is too broad. It should require a question about progression/continuity of selected work, not merely ordering of ideas or conceptual dependencies.

# Part C — overlap / distinguishing-counterexample matrix

| Pair | Distinguishing counterexample |
|---|---|
| D1 vs D10 | Correct goal definition but system chooses low-value next work; or sophisticated work selection efficiently pursues the wrong goal. |
| D10 vs D11 | Correct next work selected but handoff/progression breaks; or flawless lifecycle repeatedly executes the wrong selected work. |
| D2 vs D10 | Required capability is correctly identified but next work prioritisation is wrong; or next work is right but system lacks a needed capability. |
| D2 vs D11 | Capability set is correct but execution continuity fails; or lifecycle works but a required function is absent. |
| D3 vs D8 | Truth/state is correct but cannot be reconstructed; or trace is rich while authoritative truth is stale/wrong. |
| D4 vs D5 | Correct authority makes an unsupported decision; or evidence is strong but actor lacks authority. |
| D5 vs D6 | Verifier correctly detects unacceptable condition but no hazard/failure response semantics exist. |
| D6 vs D11 | Runtime progresses correctly until a hazard/failure needing containment; or failure is represented correctly but selected normal work cannot progress/handoff. |
| D6 vs D7 | Current hazard/failure is contained but repeated lesson never changes future system; or evolution pipeline works but current incident has no safe recovery. |
| D2 vs D9 | Task capability necessity is clear but stable-core placement is wrong; or core boundary is clean while task capability map is incomplete. |

# Part D — pre-architecture minimum delta caused by Stage 5

Existing `prearchitecture-research-scope.md` remains valid for D1–D9 except where wording is superseded below.

## Revised D6 minimum before Phase 1–3

Need enough evidence to distinguish:

- hazard/risk precursor versus realised failure versus uncertainty/non-completion,
- prevention versus detection versus containment/recovery,
- risk acceptance authority versus technical risk evidence,
- changing environment/control-effectiveness invalidation,
- liveness/control side effects,
- proximate versus root causes.

### Stop condition

Phase 3 can represent material hazard/failure precursors and realised failures with observable control obligations without turning every generic uncertainty into a safety/failure class.

## D10 minimum — work selection/decomposition/prioritisation/depth

Need enough evidence to distinguish:

- result integration from substantive next-work selection,
- repair/research/reframe/design/owner-decision routes,
- granularity/decomposition and dependency implications for selection,
- risk/uncertainty/value-of-information proportional depth,
- premature closure versus unbounded investigation,
- resource/time constraints as selection inputs.

### Stop condition

Given a bounded objective and current evidence, Phase 1–3 can state what properties a valid next-work decision must preserve and what failure classes make selection invalid, without fixing a Planner role or algorithm.

## D11 minimum — work lifecycle/orchestration/continuity/replanning

Need enough evidence to distinguish:

- selected work state transitions,
- responsibility/ownership continuity,
- dependency/scheduling/concurrency execution constraints,
- handoff and fresh-session continuation,
- replanning on external-state/assumption invalidation,
- blocked/partial/stale/conflicted progression,
- progression failure versus hazard/recovery (D6) and versus wrong selection (D10).

### Stop condition

Phase 1 can define lifecycle states and continuity properties, while Phase 2–3 can derive orchestration/handoff capabilities and progression failures without fixing runtime topology or scheduler implementation.

# Part E — current verdict

## Survived

- D1, D3, D4, D5, D7, D8, D9 remain discriminating under this round.
- D2 survives only with a stricter negative boundary.
- D6 survives only with hazard-aware wording and anti-catch-all guard.
- the old D10 does not survive; D10/D11 split is materially better supported.
- V1–V3 still cover the cross-cutting challenges observed in S1–S4.

## Not established

- D1–D11 completeness,
- sufficient holdout diversity,
- causal necessity of any specific mechanism,
- that revised D6 belongs unchanged in SOUL Roadmap Phase 3,
- that D10/D11 imply distinct runtime components or roles.

# Next gate

The revised taxonomy has passed one negative-boundary round. Before freezing a research-question inventory:

1. decide whether a fifth holdout is necessary by identifying a **specific remaining frame risk**, not by source-count habit;
2. if no material uncovered frame exists, consolidate `research-dimension-map.md` and `prearchitecture-research-scope.md` to D1–D11;
3. derive per-dimension research packages with evidence class, strongest falsifier and stopping condition;
4. run a final architecture-leak review: every package must ask a property/failure/evidence question, not name a role/tool/service as the answer.
