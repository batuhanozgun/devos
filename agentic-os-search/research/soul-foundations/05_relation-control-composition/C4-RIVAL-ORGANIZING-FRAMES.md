# Relation / Control / Composition — C4 Rival Organizing Frames

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Attack the current four-region composition hypothesis with materially different organizing frames.

Current hypothesis:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Derived Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

The comparison is about protected questions and failure coverage, not terminology preference.

---

## 2. Rival R1 — Pairwise relation matrix as the whole answer

```text
E↔I  E↔W  E↔A
I↔W  I↔A  W↔A
```

### Strengths

- exhaustive pair coverage;
- simple retrieval/navigation;
- good boundary discipline;
- useful for discovering stable endpoint relations.

### Failure

C3 hard cases repeatedly require 3–4 grounds. A pairwise-only model must either:
- duplicate one composite fact across several edges;
- hide missing anchors as relation attributes;
- or attach the final standing to one endpoint.

Examples:
- actionability;
- verification/validation/acceptance;
- goal attainment;
- governance/enforcement;
- accountability.

### Verdict

**Rejected as parent structure. Retain as discovery matrix inside Relational Binding and child research.**

---

## 3. Rival R2 — Flat typed-relation graph

Everything is represented as typed nodes/edges; no distinct standing/control/transition research regions.

### Strengths

- maximum representational flexibility;
- no forced hierarchy;
- provenance and path queries can be natural;
- implementation-neutral in abstract graph-theoretic form.

### Failure

A flat graph can *encode* almost anything but does not provide enough research discrimination.

It does not tell us whether:
- `authorized` is an intrinsic attribute, relation or derived standing;
- `verified` requires criterion/evidence/target/version/activity;
- a policy edge is advisory or enforced;
- an edge denotes causation or mere sequence;
- a transition changed real state or only representation;
- a path establishes effect reach or legitimate authority.

The research problem would collapse into relation-name proliferation.

### Verdict

**Rejected as research decomposition.** Possible later representation technique, therefore architecture/ontology-adjacent and out of scope.

---

## 4. Rival R3 — State / Relation / Transition

```text
Composition
├─ State
├─ Relation
└─ Transition
```

### Strengths

- extremely general;
- captures temporal change explicitly;
- resembles established modeling formalisms.

### Failure

`State` collides with the accepted grounds and especially with ground-local State research. Composite standings such as `verified`, `actionable`, `accepted` would either become generic State or relation attributes without preserving why they are multi-anchor evaluations.

Control also disappears into either relation or transition preconditions, losing:
- normative vs technical distinction;
- decision vs enforcement;
- bypass/alternate-path closure;
- obligation vs permission.

### Verdict

**Too abstract for current Foundation research.** Useful meta-model lens, not sufficient problem decomposition.

---

## 5. Rival R4 — Descriptive relations vs Normative controls

```text
Composition
├─ Descriptive / causal relations
└─ Normative / governance relations
```

### Strengths

- sharp warning against confusing `is` with `ought/may/must`;
- strong for authority, policy and obligation.

### Failure

It does not separately expose:
- derived non-normative standings such as actionability/currentness/verification;
- realized technical constraints that are not normative;
- transition/effect/feedback semantics;
- evidential/provenance distinctions.

It also makes many controls falsely `normative`: sandbox/network constraints can mechanically block behavior without defining legitimate authority.

### Verdict

**Useful cross-cutting dimension, not parent split.**

---

## 6. Rival R5 — Semantic-family taxonomy

Example:

```text
provenance
permission/authority
causation
support/dependency
participation
verification
value/risk
```

### Strengths

- close to domain language;
- high practical recognizability;
- each family could support deep literature review.

### Failure

Families are not level-aligned or exhaustive.

Examples:
- verification itself contains binding + standing + control + transition;
- provenance can be binding/transition/evidence standing;
- authority can be Actor-local, binding, derived standing and control;
- causation cuts across transition and evidence;
- risk/value is largely composite evaluation/decision pressure.

New project domains would keep adding families without a principled stop rule.

### Verdict

**Retain as later specializations/holdout themes, not immediate parent children.**

---

## 7. Rival R6 — Control-loop-centered composition

```text
controller → control action → process/environment
       ↑ feedback/observation ←
```

### Strengths

- powerful for feedback, observability, safety, governance and adaptation;
- naturally separates actual process from feedback/representation;
- foregrounds control action and constraint.

### Failure

As universal composition frame it tends to re-cast:
- Actors as controllers;
- Work as control actions/process;
- Information as process model/feedback;
- Environment as controlled process.

This is productive for many cases but not all:
- shared/joint Work;
- provenance without active control;
- stakeholder/beneficiary relations;
- passive descriptive representation;
- non-control-oriented knowledge derivation;
- multiple overlapping purposes/reference frames.

It risks importing architecture/component roles into Foundation.

### Verdict

**Strong holdout/control specialization; rejected as universal parent frame.**

---

## 8. Rival R7 — Goal / commitment-centered composition

```text
intent/goal
→ commitment/assignment
→ action/work
→ evidence/outcome
→ acceptance
```

### Strengths

- strong for Work directedness;
- useful for Actor commitments/obligations;
- connects outcome and acceptance.

### Failure

Over-centers purposive Work and under-explains:
- observations before goals are formed;
- exogenous Environment dynamics;
- Information transformations not tied to a current pursuit;
- passive/affected parties;
- support conditions and technical enforcement;
- provenance/causation independent of explicit commitment.

### Verdict

**Important composite pattern, not parent decomposition.**

---

## 9. Rival R8 — Influence as one universal relation family

Everything that matters is `influence` with specializations.

### Strengths

- elegant high-level unification;
- can subsume generation/use/delegation/causation/support.

### Failure

At Foundation depth this is too weak because materially different failure classes vanish:
- representation vs causal influence;
- obligation vs permission;
- evidence support vs authority;
- target relation vs realized effect;
- policy vs enforcement;
- delegation vs attribution.

A generic influence parent can be useful for querying but cannot replace the protected semantic distinctions.

### Verdict

**Rejected as sufficient research frame.**

---

## 10. Current frame under attack

```text
Relational Binding
Derived Standing / Qualification
Control / Constraint
Transition / Effect / Feedback
```

### Strengths after rival comparison

1. **Protected questions differ.**
   - What is connected to what/how? → Binding.
   - What standing follows from several anchors/criteria? → Standing.
   - What is permitted/required/blocked/gated? → Control.
   - What changes/effects/propagates over time? → Transition.

2. **Failure modes differ.**
   - wrong endpoints/scope/role;
   - false/incomplete derived status;
   - authority/enforcement/bypass failure;
   - sequence/causation/effect/feedback failure.

3. **Multi-ground cases fit without hiding anchors.**

4. **The frame is architecture-neutral.**
   It does not prescribe graph, rules engine, state machine or control-loop component layout.

### Weakness / open challenge

The four regions overlap in real episodes. A verification episode can contain all four.

This is acceptable only if the regions are treated as **research problem regions**, not mutually exclusive event classes.

C5/C7 must still test whether this overlap becomes practically incoherent.

## 11. Naming refinement

Current preferred labels entering C5:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Composite Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

`Composite Standing` is preferred over only `Derived Standing` because the key research problem is a criterion/reference-relative standing composed from multiple anchors; exact derivability/calculation is not always mechanical.

## 12. C4 judgment

No tested rival provides lower semantic loss and better protected failure coverage than the provisional four-region frame.

The frame remains **hypothesis**, not accepted child structure.

Proceed to C5 external/candidate holdouts.