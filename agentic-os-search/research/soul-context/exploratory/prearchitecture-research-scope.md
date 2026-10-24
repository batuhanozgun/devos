# SOUL Research — Pre-Architecture Scope Boundary

**Status:** provisional gate-dependent scope; red-teamed against roadmap  
**Date:** 2026-08-30

## Question

Which parts of D1–D10 must be sufficiently understood before SOUL Phase 1 Definition, Phase 2 Capability Architecture and Phase 3 Failure Model, and which details should be deliberately deferred?

This is scope control, not architecture.

## Core correction

An earlier draft divided the dimensions into `P0 gate-critical` and `P1 minimum-model` groups. Exact roadmap re-reading showed that split was misleading.

Phase 1 itself requires:
- purpose,
- boundaries,
- actors,
- lifecycle,
- completion semantics,
- autonomy/human-governance principles,
- system/non-system boundary.

Phase 2 requires a complete capability map, including missing-capability creation/governance, tested against materially different scenarios.

Phase 3 requires a failure taxonomy that maps failures to observable signals, prevention, detection, containment, recovery, regression and explicit control ownership.

Therefore **no D1–D10 dimension is safely dismissible as merely later-phase detail**. What varies is the **minimum depth needed for each gate**, not whether the dimension matters.

# Scope cut by dimension

## D1 — Intended outcome → bounded work definition

### Minimum needed before Phase 1–3

- material failure classes in goal/request interpretation;
- distinctions between missing fact, assumption, constraint, preference/value and approval/authority boundary;
- evidence that `request/method ≠ true objective` is a recurring failure surface;
- minimum properties of a bounded work definition.

### Defer

- final clarification/dialogue algorithm;
- prompt/schema/UI implementation;
- domain-specific requirements methods.

### Gate dependency

- **Phase 1:** direct — purpose/input/lifecycle/human boundary.
- **Phase 2:** constrains which capabilities are required.
- **Phase 3:** supplies framing/drift failure classes.

### Pre-architecture stop condition

Phase 1 can define the goal/work boundary and human-vs-system information responsibility with known major failure classes and no mechanism lock-in.

---

## D2 — Task-specific system formation and capability derivation

### Minimum needed before Phase 1–3

- defensible abstraction of capability versus role/tool/workflow/mechanism;
- derivation principles from outcome + failure/control obligations;
- burden of proof for permanent functions/roles and motivation separation;
- cross-domain capability-coverage challenge.

### Defer

- registry schema;
- implementation/admission engine;
- provider/framework selection;
- concrete generated-role format.

### Gate dependency

- **Phase 1:** informs actor/system boundary without fixing topology.
- **Phase 2:** direct central concern.
- **Phase 3:** each capability becomes a failure/control surface.

### Stop condition

Phase 2 can enumerate functions/capabilities without KEEL folders or a chosen framework as taxonomy.

---

## D3 — Internal/external state, memory, context, knowledge and retrieval

### Minimum needed before Phase 1–3

- conceptual distinctions among authoritative internal state, memory/history, actor context, knowledge/evidence and observed external-world state;
- major failure classes: duplication/drift, stale state, omission, unknown-needed context, freshness/validity loss, derived-view authority leakage;
- cold-start and changing-world properties that imply capabilities/controls;
- observable signals needed by Phase 3.

### Defer

- databases/vector stores;
- retrieval ranking/embeddings;
- compression implementation;
- detailed Phase-5 architecture.

### Gate dependency

- **Phase 1:** enough to keep system boundary/lifecycle from assuming one undifferentiated memory concept.
- **Phase 2:** derives state/context/retrieval capability families.
- **Phase 3:** stale/omitted/conflicted/unknown state failures and controls.

### Stop condition

Phase 2–3 can derive information capabilities/failures without committing to storage/retrieval technology.

---

## D4 — Authority, bounded agency and human governance

### Minimum needed before Phase 1–3

- value/judgement/approval versus researchable/technical/system decisions;
- authority-leak, self-extension and circular-acceptance failure classes;
- protected-control and least-privilege properties;
- evidence that more roles do not automatically mean stronger separation.

### Defer

- full policy language;
- permissions engine;
- escalation UI;
- Phase-8 encoding.

### Gate dependency

- **Phase 1:** direct — autonomy/human-governance principles and actor boundaries.
- **Phase 2:** authority/control capabilities and function ownership.
- **Phase 3:** authority failure classes + control ownership.

### Stop condition

Phase 1 can state human/system decision boundaries and Phase 2–3 can allocate authority/control obligations without choosing enforcement technology.

---

## D5 — Evidence, provenance, verification and completion

### Minimum needed before Phase 1–3

- claim/evidence classes;
- producer self-certification and correlated-agreement failures;
- deterministic versus semantic/evaluative verification;
- exact-target/freshness/provenance properties;
- legitimate uncertainty/non-verification states;
- abstract completion semantics.

### Defer

- evaluator architecture;
- benchmark/grader implementation;
- provenance storage;
- detailed Phase-7 orchestration.

### Gate dependency

- **Phase 1:** direct — completion semantics.
- **Phase 2:** evidence/verification capability derivation.
- **Phase 3:** verification/oracle/provenance failure classes and controls.

### Stop condition

Phase 1 can define completion and Phase 2–3 can derive evidence/verification capabilities plus failure/control obligations.

---

## D6 — Failure representation, containment, recovery and liveness

### Minimum needed before Phase 1–3

- domain-neutral failure taxonomy at the right abstraction level;
- observable signals and uncertainty states;
- prevention/detection/containment/recovery/regression categories;
- proximate versus root-cause distinction;
- liveness/deadlock/starvation/meta-work failures;
- repair versus reframe/research/redesign/non-completion boundaries.

### Defer

- recovery engine;
- domain playbooks;
- retry/backoff policy;
- runtime recovery implementation.

### Gate dependency

- **Phase 1:** constrains legitimate lifecycle/non-completion states.
- **Phase 2:** every capability needs failure/control obligations.
- **Phase 3:** direct central concern.

### Stop condition

Every material Phase-2 capability can map to domain-neutral observable failure/control ownership, and the taxonomy survives materially different scenarios.

---

## D7 — Learning, controlled evolution and capability admission

### Minimum needed before Phase 1–3

- lesson-as-prose / lesson-not-invoked failure class;
- local correction versus class control versus architecture evolution versus foundation reopening;
- no self-certifying/self-rule-rewriting admission;
- abstract missing-capability/evolution obligations.

### Defer

- final build/test/verify/admit pipeline;
- capability registry;
- automated policy synthesis;
- detailed rollback orchestration;
- Phase-9 implementation architecture.

### Gate dependency

- **Phase 1:** `DEFINITION.md` explicitly names Evolution as a top-level concern; enough boundary is required here.
- **Phase 2:** missing-capability creation/governance is explicitly first-class.
- **Phase 3:** evolution/admission failures require control ownership.

### Stop condition

Phase 1 can define Evolution boundaries and Phase 2–3 can reserve required capabilities/failure controls without defining the final self-extension mechanism.

---

## D8 — Observability and reconstructability

### Minimum needed before Phase 1–3

- material facts/actions/decisions/evidence/authority/failures that must be observable;
- authoritative state versus derived operational view;
- observability failure classes;
- minimum reconstructability for fresh session and independent review.

### Defer

- logging/event stack;
- dashboard/cockpit design;
- telemetry technology/retention;
- detailed Phase-10 model.

### Gate dependency

- **Phase 1:** enough to make `controlled` and completion/non-completion inspectable concepts.
- **Phase 2:** observability capabilities.
- **Phase 3:** explicit observable signals are a gate requirement.

### Stop condition

Phase 2 can derive observability functions and Phase 3 can attach signals to material failure classes without choosing telemetry technology.

---

## D9 — Generality, domain transfer and task-specific architecture

### Minimum needed before Phase 1–3

- materially different scenario families;
- criteria for detecting domain leakage;
- capability/failure coverage method across scenarios;
- invariant property versus task-specific operating structure;
- negative cases capable of falsifying universal abstractions.

### Defer

- production pilots;
- long-running v1 benchmarks;
- optimization for every supported domain.

### Gate dependency

- **Phase 1:** direct — system/non-system boundary and meaning of general-purpose.
- **Phase 2:** direct gate — capability coverage across materially different scenarios.
- **Phase 3:** failure taxonomy must not be one-domain defect catalogue.

### Stop condition

Phase 2 capability map can be attacked by materially different scenarios and no capability is core merely because predecessor software work made it familiar.

---

## D10 — Work selection, decomposition, orchestration and lifecycle

### Minimum needed before Phase 1–3

- result integration versus next-work selection versus design versus implementation;
- premature repair routing, execution/completion bias, lost-purpose handoff and unbounded-investigation failures;
- risk-proportional reasoning/work depth;
- abstract lifecycle properties;
- replanning when external state invalidates assumptions.

### Defer

- permanent Planner-role decision;
- exact routing state machine;
- orchestration framework/scheduler;
- Phase-6 topology.

### Gate dependency

- **Phase 1:** direct — lifecycle.
- **Phase 2:** derives planning/orchestration/handoff capability functions without fixing topology.
- **Phase 3:** routing/liveness/handoff failures and controls.

### Stop condition

Phase 1 can define lifecycle/completion states and Phase 2–3 can derive work-selection/orchestration functions plus failures without presupposing a Planner/agent topology.

# Gate-dependent minimum model

A better model than P0/P1 is:

## Phase-1 Definition-critical surface

Research must be mature enough to define, without mechanism lock-in:

- D1 goal/work boundary,
- D4 autonomy/human authority boundary,
- D5 completion/evidence meaning,
- D7 Evolution boundary,
- D9 general-purpose/system boundary,
- D10 lifecycle,

while D2/D3/D6/D8 must already be coherent enough that the definition does not silently assume a fixed team, undifferentiated state, binary failure or invisible system.

## Phase-2 Capability-critical surface

D2 and D9 are central, but the map must derive capabilities implied by **all D1–D10 properties**. In particular, Phase 2 cannot postpone discovery of a capability family merely because its detailed architecture is Phase 5–10.

## Phase-3 Failure-critical surface

D6 is central, but failure analysis must attack **all D1–D10 capability/property surfaces** and assign observable signals/control ownership. Thus minimum D3/D4/D5/D7/D8 understanding is required before Phase 3 even though their detailed architectures come later.

# Global pre-architecture research stop gate

Do not wait for exhaustive literature coverage of D1–D10.

A defensible transition toward Phase 1–3 requires:

1. **Definition readiness:** Phase-1 direct surfaces above have explicit questions, evidence, counter-evidence and bounded residual uncertainty.
2. **Capability abstraction:** Phase 2 can be organised by functions/properties, not tools/frameworks/KEEL folders.
3. **Capability coverage:** every D1–D10 property can map to candidate function/capability obligations without choosing implementation.
4. **Failure coverage:** a cross-domain taxonomy can map capability/property surfaces to observable failure/control obligations.
5. **Domain holdout:** materially different scenario families attack the map and reveal no unresolved high-impact domain leakage.
6. **No unresolved frame blocker:** no known material counter-evidence indicates the question map is missing a higher-level problem class.
7. **Residual uncertainty ledger:** deferred questions are explicitly routed to later phases/methods.
8. **Promotion boundary:** research remains evidence/question/failure/capability input; architecture commitments use the SOUL decision path.

# What should explicitly NOT block Phase 1–3

- agent framework or LLM-provider choice;
- final memory/retrieval database;
- fixed role names/topology;
- final runtime performance proof;
- complete Phase-7 evaluator implementation;
- exhaustive industry coverage;
- every low-risk implementation trade-off;
- completed production pilots before architecture exists.

# Remaining adversarial questions

1. Is any D1–D10 `minimum needed` item actually a hidden implementation preference rather than a property/failure question?
2. Did the roadmap itself inherit SOUL/KEEL framing that the research should challenge rather than merely operationalise?
3. Which external holdout properties have been made to fit D1–D10 only because the dimension wording is too broad?
4. What minimum evidence quality/quantity is enough for each direct Phase-1 surface without turning pre-architecture research into an indefinite programme?

The next work should answer these with the external holdout matrix and contradiction/omission testing, not create architecture mechanisms.