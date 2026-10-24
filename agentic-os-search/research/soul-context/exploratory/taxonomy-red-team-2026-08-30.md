# SOUL Research Dimension Taxonomy — adversarial red team

**Status:** active synthesis; taxonomy challenge, not architecture
**Date:** 2026-08-30

## Question

Are the current research dimensions genuinely discriminating protected properties, or are some broad enough to absorb almost any new problem after the fact?

This round applies:

1. omission testing against external holdouts,
2. internal-overlap / distinguishing-counterexample testing,
3. an alternative control-loop/lifecycle frame,
4. roadmap-leak checks against direct SOUL foundation/roadmap sources,
5. a fourth external holdout that includes physical-world operation and safety risk.

## Source status

### Canonical SOUL project sources

- `batuhanozgun/soul`, `phase0/development-os`:
  - `development/00_foundation/DEFINITION.md`
  - `development/00_foundation/NON_NEGOTIABLES.md`
  - `development/03_plan/ROADMAP.md`

### Existing research holdouts

- NASA decision analysis — analytical decision support under uncertainty.
- Cochrane / PRISMA — open-ended evidence synthesis.
- NIST / FEMA — dynamic incident and operations work.

### New holdout S4 — aviation safety management / physical operations

Primary authoritative web sources inspected 2026-08-30:

- FAA Safety Management System overview: `https://www.faa.gov/about/initiatives/sms`
- FAA SMS components: `https://www.faa.gov/about/initiatives/sms/explained/components`
- FAA SMS basis: `https://www.faa.gov/about/initiatives/sms/explained/basis`
- FAA active Safety Risk Management policy landing page, Order 8040.4C: `https://www.faa.gov/regulations_policies/orders_notices/index.cfm/go/document.current/documentNumber/8040.4`

The FAA sources are domain prior art / property evidence, not proof that FAA mechanisms are optimal for agentic systems.

# S4 properties observed before mapping

The physical-operations holdout exposes these properties:

1. Safety management is integrated into operational decision-making rather than treated as a detached after-the-fact review.
2. Hazards and safety risk are identified and assessed **before** an accident/failure occurs.
3. Risk controls/mitigations are designed when risk is unacceptable.
4. Separate safety-assurance activity checks whether implemented controls continue to achieve their intended objectives.
5. Operational/environment changes can reveal new hazards or make existing controls inadequate.
6. Accountability, authority, responsibility and communication across interfaces are explicit safety properties.
7. Training/competency and dissemination of lessons are part of maintaining the operating system, not only post-incident documentation.
8. Safety depth and controls exist in relation to consequence/risk, not as maximum-process-by-default.

# Omission test against current dimensions

## Prospective hazard/risk is not cleanly named

The current D6 is titled around `failure representation / containment / recovery / liveness` and its text is dominated by failure states and failure taxonomy.

S4 shows a materially different state:

- a **hazard / risk exposure can be material before a failure occurs**;
- the system may need to act before there is a failed state to recover from;
- later assurance must monitor whether controls remain effective as operations/environment change.

Forcing this entirely into a post-hoc `failure` concept would be semantic stretching.

### Provisional correction

Do **not** add a separate safety subsystem dimension yet.

Instead revise D6's protected surface from a post-hoc failure model toward:

> **Hazard / failure representation, prevention, containment, recovery and liveness**

This keeps the same control/failure family while making prospective risk precursors explicit.

`V2 — risk/materiality/proportionality/value of information` remains the cross-cutting axis controlling how much research/control is justified by consequence, uncertainty and reversibility. V2 is not itself the home of a specific hazard or failure state.

### Roadmap counter-evidence

SOUL Roadmap Phase 3 currently says `Failure Model` and asks for failure classes mapped to prevention/detection/containment/recovery/regression. The physical-operations holdout suggests Phase-3 research may need to test whether **hazard/risk precursor classes** must also be represented before failure. This is research counter-evidence to route through the normal SOUL decision path; it is not an automatic roadmap edit.

# Internal discrimination test

## D10 fails atomic discrimination in its current form

Current D10 combines:

- substantive next-work selection,
- decomposition/prioritisation/depth,
- execution/orchestration,
- handoff/continuity,
- replanning,
- resource/time/concurrency constraints,
- lifecycle progression.

Two protected properties inside this bundle can fail independently.

### Counterexample A — correct work choice, broken progression

A system can correctly determine the next substantive work but then:

- lose responsibility at handoff,
- fail to advance state,
- execute in the wrong dependency order,
- fail to replan after assumption invalidation.

Work selection passed; lifecycle/orchestration failed.

### Counterexample B — robust progression, wrong work choice

A system can reliably execute, hand off and track lifecycle state while repeatedly routing every material finding into repair-shaped work when research/reframe/owner decision is actually needed.

Lifecycle/orchestration passed; work selection failed.

### Independent evidence split

This distinction is not invented only from labels:

- historical corpus: `material result auto-routes to repair-shaped work` is a work-selection failure;
- historical corpus: `static state survives but movement/responsibility/next action does not` is a lifecycle/continuity failure;
- NASA holdout supports decision-sensitive selection of additional analytical work and depth;
- FEMA/NIST holdout supports repeated plan → execute → evaluate → revise, operational-period validity and replanning;
- SOUL `DEFINITION.md` separately names Genesis and Runtime concerns;
- SOUL Roadmap Phase 6 itself bundles task lifecycle, planning, decomposition, scheduling, handoff, dependencies, stopping, budgets and concurrency, so roadmap similarity cannot be used as the sole reason to keep the research bundle intact.

### Provisional correction

Split the current D10 into two protected-property dimensions:

- **D10 — Work selection / decomposition / prioritisation / reasoning depth**
  - asks *what substantive work should happen next, why, at what granularity and depth?*
- **D11 — Work lifecycle / orchestration / continuity / replanning**
  - asks *how does selected work progress through execution, dependency handling, responsibility, handoff, state transition and assumption-triggered replanning?*

This produces D1 vs D10 vs D11 as three distinguishable questions:

- D1 — are we pursuing the right bounded objective/work definition?
- D10 — given that objective and current evidence, what should we work on next?
- D11 — once selected, does that work progress correctly and remain live/continuous under change?

D6 retains failure/liveness semantics; D11 does not become the home for all failure recovery.

# D2 elasticity test

D2 currently combines `task-specific system formation` and `capability derivation`.

Its intended elasticity is useful: domain-specific methods should be derivable without becoming core. But this breadth can become unfalsifiable if every unmatched domain property is simply called a `task-specific capability`.

### Guard

Narrow the research use of D2 to:

> **capability/function necessity, coverage and task-specific composition requirements**

D2 may absorb a domain method only as a candidate task-specific capability family. It may not use that classification as evidence that:

- the capability is stable-core,
- a particular role/tool/workflow is required,
- the capability's runtime assembly/orchestration mechanism is known.

Stable-core placement remains D9/V1 territory; execution/progression belongs D11; evidence that a capability actually works belongs D5; controlled admission/evolution belongs D7.

# D8 independence test

D8 remains provisionally independent rather than being demoted to a validation axis.

Distinguishing counterexamples:

- **D3 pass / D8 fail:** authoritative, fresh state can exist while an authorised operator/fresh actor cannot reconstruct why an action occurred, which authority applied or why work stopped.
- **D8-looking pass / D3 fail:** a rich visible trace can faithfully show the sequence of actions while the underlying authoritative state is stale, duplicated or wrong.

SOUL `NON_NEGOTIABLES.md` independently states that observability is part of correctness, strengthening the case that reconstructability is a protected property rather than merely a test technique.

# Validation-axis test

Current axes:

- V1 — domain transfer / scenario diversity,
- V2 — risk/materiality/proportionality/value of information,
- V3 — source/view fidelity and omission awareness.

S4 does **not** yet force V4.

- physical irreversibility/consequence strengthens V2;
- changing environment maps to D3 + D11 and is tested across V1;
- risk-control effectiveness maps to D5/D6;
- competency/lessons map to D2/D7;
- authority/accountability maps to D4.

If future holdouts expose a property that can only fit by turning V2 into a catch-all safety axis, reopen the validation-axis set.

# Counter-frame test

A compact control-loop view can organise the same research surface:

1. **Define / frame** — D1, D2, D9
2. **Observe / maintain state** — D3, D8
3. **Choose / authorise work** — D4, D10
4. **Execute / coordinate / replan** — D11
5. **Assure / handle hazard and failure** — D5, D6
6. **Learn / evolve** — D7

This frame is useful because it exposes D10's former internal split.

It does **not** yet reduce the protected-property count: each paired dimension still has distinguishing counterexamples and different evidence/stopping obligations.

Therefore the counter-frame is a second organisational view, not a replacement taxonomy and not an architecture diagram.

# Roadmap-leak verdict

The red-team does not support the claim that the map is merely a copy of SOUL Roadmap phases:

- D10/D11 split cuts across the single Roadmap Phase-6 bundle rather than mirroring it;
- prospective hazard/risk evidence challenges the current Phase-3 `failure` wording instead of merely adopting it;
- D8 is retained from a foundation property and distinguishing counterexample, not because Phase 10 is named Observability.

However roadmap leakage remains a standing risk: direct roadmap similarity is never sufficient evidence for a research dimension.

# Provisional revised map

1. D1 — Intended outcome → bounded work definition
2. D2 — Capability/function necessity, coverage and task-specific composition requirements
3. D3 — Internal/external state, memory, context, knowledge and retrieval
4. D4 — Authority, bounded agency and human governance
5. D5 — Evidence, provenance, verification and completion
6. D6 — Hazard/failure representation, prevention, containment, recovery and liveness
7. D7 — Learning, controlled evolution and capability admission
8. D8 — Observability and reconstructability
9. D9 — Core invariant ↔ task-specific system / system boundary
10. D10 — Work selection, decomposition, prioritisation and reasoning depth
11. D11 — Work lifecycle, orchestration, continuity and replanning

Cross-cutting validation axes remain provisionally:

- V1 — domain transfer / scenario diversity
- V2 — risk / materiality / proportionality / value of information
- V3 — source/view fidelity / omission awareness

# What this round establishes

- The prior D1–D10 map did **not** survive unchanged.
- D10 contained two independently failing protected properties and should be split provisionally.
- D6's prior wording under-represented prospective hazard/risk states exposed by a physical-operations holdout.
- D2 needs a stronger anti-catch-all guard.
- D8 still has a defensible independent protected property.
- V1–V3 survived this holdout, but completeness remains unproven.

# What this does NOT prove

- D1–D11 completeness.
- that FAA SMS mechanisms should be copied into SOUL.
- that hazard/risk requires a specific safety role, agent or service.
- that D10/D11 imply two runtime components.
- that the control-loop counter-frame is the correct SOUL architecture.
- that four holdout families establish generality.

# Next highest-information gate

1. Apply the revised D1–D11 map back to S1–S4 with **property-first mapping**; flag any new stretching.
2. Derive the minimum pre-Phase1/2/3 question set for the new D10/D11 and revised D6.
3. Test whether D2 and D6 remain too broad by constructing negative examples that should explicitly **not** belong to them.
4. Sample one additional omitted domain only if it attacks a still-uncovered frame (for example embodied resource production / market interaction / social coordination), rather than expanding holdouts by count.
5. If the revised map survives, convert it into bounded research packages with evidence class, strongest falsifier and stopping condition.