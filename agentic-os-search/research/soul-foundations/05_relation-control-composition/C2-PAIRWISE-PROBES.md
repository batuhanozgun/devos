# Relation / Control / Composition — C2 Pairwise Cross-Ground Probes

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Use all six ground pairs to expose stable boundary semantics and determine where a third/fourth ground becomes necessary.

Pairwise coverage is a probe, not a presumption that the final composition model is a 6-cell matrix.

---

## 2. Environment ↔ Information

### Stable relational bindings

- representation-about / referent-of;
- observes / measures / senses;
- model/forecast/estimate about realized condition;
- evidence of a past/current condition;
- temporal/as-of binding.

### Transition semantics

```text
Environment event/condition
→ observation/acquisition activity
→ informational state/result
```

The Environment state need not change when Information changes, and Information may change while remaining wrong/stale/incomplete.

### Derived-standing pressure

- `evidence supports Environment claim at time T`;
- `representation is current enough for use U`;
- `measurement result valid for referent/scope S`.

These standings often require Work criteria/procedure and/or Actor/source standing; the pair alone is frequently insufficient.

### Control pressure

Source eligibility, access and disclosure may involve Actor authority and Work purpose. Therefore control is not safely owned by this pair.

### Pair verdict

Pairwise binding is strong and irreducible; higher-order standing/control commonly requires other grounds.

---

## 3. Environment ↔ Work

### Stable relational bindings

- Work targets / affects / maintains / accommodates Environment condition;
- Work depends on / is enabled or blocked by Work Conditions;
- Environment provides resource/interface/capacity used by Work;
- one Work product/effect becomes another Work's Environment condition.

### Transition/effect semantics

```text
Work attempt/execution
→ possible Environment change
```

Critical non-collapse:

```text
Work occurred
!= intended effect occurred
!= desired Environment condition attained
```

### Derived-standing pressure

- Work ready/blocked/degraded relative to conditions;
- target outcome attained;
- support sufficient for Work method.

Outcome attainment requires Information criteria/specification and often Actor acceptance/value authority.

### Control pressure

A realized Environment condition can physically/technically block action, but this is not the same as normative prohibition. Actor authority and policy information may be needed.

### Pair verdict

Strong target/support/effect relations exist, but goal attainment and control cannot be closed pairwise.

---

## 4. Environment ↔ Actors

### Stable relational bindings

- Actor situated in / exposed to / able to access Environment resources/interfaces;
- Actor capability encounters actual affordance/constraint;
- Actor causes/contributes to Environment condition;
- Environment condition affects Actor feasibility/safety.

### Derived-standing pressure

The key example is situated actionability:

```text
Actor capability
+ Environment access/affordance
+ relevant Work path/requirement
(+ authority/control where applicable)
→ actionable-now standing
```

The pair cannot determine actionability if the action/Work being considered is unspecified.

### Control pressure

Runtime enforcement can block an Actor even if institutionally authorized; institutional authority can forbid an action that is technically reachable.

```text
technical reachability != legitimate authority
```

Information about policy/credential/current state and Work transition scope are often required.

### Transition pressure

Environment access changes can alter actionable standing without changing Actor competence; authority revocation can alter legitimate action paths without changing Environment access.

### Pair verdict

Pair is essential but **decisively insufficient** for actionability/effective-authority composition.

---

## 5. Information ↔ Work

### Stable relational bindings

- Information defines/specifies/plans Work;
- Work consumes/produces/transforms/selects Information;
- Information represents Work status/history;
- evidence/results are produced by verification/validation Work;
- handoff/context information supports Work continuity.

### Protected distinction

```text
representation of Work state != actual Work state
```

### Derived-standing pressure

- exact-target/version verification standing;
- evidence sufficient for Work decision;
- current context sufficient for Work;
- specification satisfied.

Verification/validation requires actual target conditions and verifier/acceptance authority in many cases; pairwise closure is insufficient.

### Control pressure

Information can encode policy/gates/criteria, but a policy document is not itself authority or enforcement. Actor and Environment anchors are required for many controls.

### Transition pressure

Work can generate/update Information; Information changes can trigger/reconfigure Work. But an informational status update does not itself move actual Work unless a Work/control transition occurs.

### Pair verdict

Rich pairwise semantics, especially specification/evidence/context, but load-bearing assurance/control is multi-ground.

---

## 6. Information ↔ Actors

### Stable relational bindings

- Actor is source/holder/asserter/transmitter/recipient of Information;
- Information represents Actor identity/role/authority/delegation standing;
- attribution/provenance links Information to Actors;
- Actor believes/accepts/disputes Information where that state matters.

### Protected distinction

```text
representation says standing X
!= actual Actor standing X
```

### Derived-standing pressure

- source authoritative for role R;
- trusted expert for question Q;
- evidence attributable/reliable enough for use U.

These standings often require Work purpose/criterion and actual Environment/source access or independent evidence.

### Control pressure

Actors may have authority over access/disclosure/decision, while Information carries the policy/credential/decision record. The pair still does not capture technical enforcement or Work transition being controlled.

### Transition pressure

Delegation/role changes may be represented informationally, but representation update and actual standing change are separate events.

### Pair verdict

Strong source/holder/standing-representation relations; epistemic and authority uses quickly become multi-ground.

---

## 7. Work ↔ Actors

### Stable relational bindings

- Actor participates/performs/requests/initiates Work;
- Actor is assigned to Work;
- Actor decides/authorizes/reviews/verifies/integrates/accepts Work;
- Actor obligation/commitment may concern Work;
- delegation/reassignment relates Actors to Work while Work identity persists;
- accountability/ownership may continue beyond one episode.

### Protected distinctions

```text
Work admission != Actor obligation
participant != performer != decider != authorizer != accountable party
Work acceptance state != authority to accept
```

### Derived-standing pressure

- Actor authorized to execute this Work transition;
- Work has required authorized participation;
- Work can legitimately close;
- duty fulfilled/breached.

These may require policy/criteria Information and Environment conditions/effects.

### Control pressure

This pair carries much normative semantics, but technical enforcement and policy representation remain outside it. A manager role does not itself prove authority; a gate label does not enforce anything.

### Transition pressure

Assignment, authorization, delegation and acceptance can change Work standing and Actor standing at different times.

### Pair verdict

This pair is central but not self-sufficient for governance/control or completion legitimacy.

---

## 8. Cross-pair findings

### 8.1 Pairwise relation semantics are real

The six pairs are not arbitrary. Each exposes stable protected questions that cannot be erased by saying `everything is multi-ground`.

### 8.2 Pairwise-only composition is falsified

Recurring high-value questions require at least three anchors:

- actionability/effective power;
- verification/validation/acceptance;
- goal/outcome attainment;
- governance/enforcement;
- accountability;
- feedback/evolution.

A pairwise-only model would either:
- smuggle missing ground facts into relation attributes;
- create opaque composite edges;
- or project derived standings onto one endpoint.

### 8.3 The provisional four-region frame survives

Across all six pairs:

- **Relational Binding** captures stable endpoint/role semantics;
- **Derived Standing** appears whenever the pair must be evaluated relative to additional criteria/anchors;
- **Control** appears where allowed/required/blocked transitions matter;
- **Transition/Effect** appears where actual change/propagation matters.

### 8.4 Evidence/provenance and causation remain cross-cutting

Neither required a fifth immediate composition region in pairwise probes.

## 9. C2 judgment

The six-pair matrix is necessary for coverage but inadequate as the parent research structure.

Proceed to C3 with multi-ground hard cases as first-class units of analysis.