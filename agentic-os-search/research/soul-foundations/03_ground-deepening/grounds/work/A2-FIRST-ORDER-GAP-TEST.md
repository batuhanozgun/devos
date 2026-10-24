# Work Ground Audit — A2 First-Order Gap / Omission Test

**Status:** COMPLETE  
**Date:** 2026-09-05  
**Dependency:** `A1-FOUR-GROUND-BOUNDARY-COVERAGE.md`

## 1. Question

After the four-ground boundary corrections, is there a common Work phenomenon that cannot be expressed through the current Work distinctions without systematic information loss?

A2 does not ask whether more Work terminology exists. It asks whether a **new first-order protected question** is needed.

## 2. Current Work map under test

The prior twelve families are treated as analytical dimensions/problem families, not an accepted child hierarchy:

1. purpose/outcome vs action/task vs method;
2. plural units/levels;
3. candidate/eligible/admitted/executing;
4. plan/prescription vs situated execution/adaptation;
5. control-regime plurality;
6. dependency/coordination/concurrency;
7. item state vs system flow/capacity relation;
8. multidimensional Work standing/state;
9. effort/duration/waiting/elapsed/recurrence;
10. completion vs verification/validation/acceptance;
11. termination/failure/recovery/compensation/retry;
12. bounded vs continuing/supporting Work.

A2 attacks the main live omissions from A0/A1.

---

# 3. H5 — Sensemaking / investigation / decision as missing first-order Work

## Challenge

Research, diagnosis, investigation and decision can have no immediate external-world product. Their immediate effect may be changed information, uncertainty or choice.

If Work is implicitly “transformation of the world”, these cases would be missing.

## Existing coverage

The prior Work corpus already states:

- Work may include investigation, evaluation, diagnosis, decision and discovery;
- not all Work is deterministic input→output transformation;
- the Work definition can evolve as information changes;
- monitoring/evaluation can generate adaptive replanning or new Work.

The accepted Information ground now improves the boundary:

- the informational state produced by investigation belongs to Information;
- the **activity/pursuit of investigating, evaluating or deciding** can still be Work.

## Reduction test

Cases tested conceptually:

- research whose output is a hypothesis/evidence set;
- diagnosis whose output is a narrowed cause set;
- design exploration whose output is a selected option;
- approval review whose output is a decision;
- incident triage whose output is the next Work package.

Each case still requires the ordinary Work questions:

- why/what outcome is sought;
- whether/when the work is admitted;
- how it is structured and controlled;
- what dependencies/evidence it needs;
- how execution/evaluation progresses;
- what closes or redirects it.

The fact that the immediate result is informational changes the **object/result**, not the first-order semantics of Work.

### H5 verdict

**No new first-order Work family.** Sensemaking/investigation is a significant Work form whose immediate outcome is often Information; it is not currently a separate Work-ground branch.

---

# 4. H6 — Learning / discovery-driven Work

## Challenge

Some Work does not merely execute a known plan. The work discovers what the work should become.

Potentially missing semantics:

- unknown scope becoming known;
- hypotheses causing new branches;
- criteria/plan/decomposition changing after learning;
- experiments determining subsequent Work.

## Existing coverage

Current Work already preserves:

- progressive elaboration;
- event/situation-driven control;
- planned vs situated actual Work;
- adaptive replanning;
- candidate generation/selection;
- feedback/evaluation loops;
- failure-generated new Work.

Information Dynamics separately explains how new/selected information becomes available; Work explains how that information changes the pursuit/plan/admission decisions.

### Discovery topology

```text
current purpose
→ exploratory/investigative Work
→ new information / reduced uncertainty
→ revised candidates/plan/dependencies
→ selected next Work
```

This topology composes existing Work + Information distinctions without a missing Work-local protected question.

### H6a verdict — discovery-driven Work

**Covered.** No new first-order family.

---

# 5. H6b — Meta-work / Work that changes the working system

## Challenge

SOUL / Development OS may perform Work whose target is:

- workflow/control rules;
- agent configuration;
- verification process;
- tooling/runtime;
- future Work-generation mechanism;
- the operating system itself.

Could this require a new `meta-work` category?

## Role-switch test

The same analytical structure applies when the object changes:

- refactor a workflow rule;
- update an instruction/control file;
- create a new capability;
- improve the verifier;
- redesign a coordination policy.

The target may be Information, Environment or later control/composition structure, but the pursuit still has purpose, admission, method, dependencies, execution, evaluation, closure and possible recovery.

`Meta` indicates **what the Work targets / its level of reflexivity**, not a distinct first-order Work semantics.

### H6b verdict

**Meta-work is a level/object relation, not a missing Work family.** The plural-unit/level and purpose/action/method distinctions already permit Work about Work systems.

---

# 6. H7 — Multi-agent integration / verification as missing Work

## Challenge

Agentic systems introduce:

- decomposition across agents;
- parallel execution;
- handoff;
- merge/integration;
- review;
- verification;
- adversarial challenge;
- repair loops;
- hidden human orchestration.

Could these be a new Work family absent from older process/project frames?

## Reduction against current Work

### Decomposition / parallel execution

Maps to:

- plural units/levels;
- alternative methods/refinements;
- dependency/partial order/concurrency;
- system flow/capacity relations.

### Handoff / merge / integration

Maps to:

- coordination/articulation Work;
- producer/consumer dependencies;
- synchronization;
- parent-level outcome criteria;
- possible recovery/rework when integration fails.

### Review / verification / adversarial challenge

Maps to:

- evaluation/verification/validation distinctions;
- separate Work units whose authority/evidence semantics cross Actors/Information;
- failure-generated remediation/reverification.

### Human orchestration

If a human must route, merge, clarify or resolve dependencies, that activity is **real coordination Work**, not invisible overhead. The prior Work corpus explicitly preserves articulation/coordination Work.

### H7 verdict

**No new first-order Work family.** Multi-agent systems make existing coordination, concurrency, evaluation and recovery semantics more operationally visible; they do not currently require a distinct Work-ground branch.

---

# 7. Interrupted / resumed / migrated Work

## Challenge

Fresh-session agent systems repeatedly suspend and resume Work across:

- sessions;
- agents;
- models;
- repositories/worktrees;
- execution environments.

## Existing coverage

The prior Work corpus already distinguishes suspension/resumption and recognizes context-reconstruction / coordination cost after interruption.

The four-ground frame adds:

- persisted handoff/state representation → Information/Records;
- new performer/authority → Actors;
- runtime/workspace capability → Environment;
- continuation/resumption pursuit semantics → Work.

No new Work family is required.

---

# 8. Policy/gate-generated Work

A failed gate can create:

- diagnosis;
- repair;
- evidence generation;
- re-review;
- escalation;
- alternate Work.

This maps to:

- admission/requiredness;
- verification/acceptance;
- failure-generated Work/recovery;
- event/situation-driven control.

Policy content/authority lives elsewhere; Work semantics remain covered.

---

# 9. Opportunistic / unplanned / interrupt-driven Work

Emergency or newly discovered Work can enter without a pre-existing planned item.

Current coverage:

- candidate identification;
- event/situation-driven activation;
- reprioritization/admission under scarcity;
- interruption/recoordination;
- adaptive replanning.

No new first-order family survives.

---

# 10. H9 — Is the twelve-family map an incoherent grab-bag?

The twelve families are not clean disjoint children, so A2 does **not** promote them as hierarchy.

However they can be oriented around one coherent Work-local trajectory without forcing sequence:

```text
WHY / WHAT PURSUIT?
  purpose / outcome direction

WHICH WORK EXISTS / IS TAKEN ON?
  units / candidates / eligibility / admission / priority

HOW IS THE PURSUIT ORGANIZED AND ENACTED?
  methods / plan-vs-actual / control regime / dependencies / coordination / concurrency

HOW DOES IT EVOLVE IN TIME AND SYSTEM FLOW?
  state / readiness / suspension / effort / duration / waiting / capacity relation / recurrence

HOW IS IT JUDGED, CLOSED OR RECOVERED?
  completion / verification / validation / acceptance / termination / repair / retry / continuing responsibility
```

These are **orientation clusters**, not a proposed child tree. The same Work can involve several clusters simultaneously.

The common protected object is the **organized pursuit over time**, not a collection of unrelated domain nouns.

### H9 verdict

**The map is plural but not currently residual/incoherent.** Forcing a clean child hierarchy would likely create false disjointness; retaining a coherent Work ground with multiple load-bearing dimensions is better supported at this depth.

---

# 11. Additional omission probes

## Multiple competing purposes

Covered by purpose/outcome plurality + candidate/priority/admission + system-level tradeoffs; authority/value choice crosses Actors/governance.

## Reversible vs irreversible Work

Important risk property, but depends primarily on Environment effect/recovery possibility and control/authority. Work already preserves compensation/recovery distinctions.

## Work whose success is maintaining a condition

Covered by continuing/recurring Work and outcome criteria; actual maintained condition belongs Environment.

## Work that intentionally decides not to act

Covered by candidate/eligibility/admission/rejection/deferral and deliberate non-execution; Actor omission/authority semantics remain separate.

## Work generated by other Work

Covered by decomposition, feedback, failure-generated Work and discovery-generated candidate Work.

---

# 12. A2 verdict

No tested omission hypothesis forces a new first-order Work family.

### Hypothesis status after A2

- H5 sensemaking/decision → **covered as Work form with Information outcome**;
- H6 discovery-driven Work → **covered by elaboration/adaptation + Information transition**;
- H6 meta-work → **level/object relation, not new Work family**;
- H7 multi-agent integration/verification → **covered by coordination + evaluation + recovery**;
- H9 incoherent grab-bag → **not supported; coherent protected pursuit question survives**.

A2 therefore shifts the audit from `possible missing Work family` toward `candidate-study falsification of the no-gap result`.

## 13. Next

A3: newer candidate-study holdouts. The purpose is to try to break the A2 no-gap result using post-vertical agentic-system evidence rather than merely confirming it.
