# Relation / Control / Composition — C7 Adversarial Closure

**Status:** COMPLETE / BOUNDED PARENT CLOSURE  
**Date:** 2026-09-05  
**Verification class:** same-model adversarial review; NOT independent replication

## 1. Target under attack

Current parent hypothesis:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Composite Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

Claim being tested:

> These four regions form the strongest current immediate research decomposition for systematic composition across Environment, Information, Work and Actors.

---

## 2. Attack A — `Cross-Ground Composition` is only a residual bucket

### Attack

Perhaps every relation should remain inside one of the four grounds, and `composition` merely collects leftovers.

### Test

Hard cases require correctness conditions distributed across multiple grounds:
- verification/validation/acceptance;
- actionability/effective power;
- goal/outcome attainment;
- policy/authority/enforcement;
- accountability;
- feedback/evolution.

No one ground can own these without boundary theft.

### Result

The parent is not defined as `everything between grounds`; it has a protected question about **cross-ground semantic correctness**.

**Attack rejected.**

---

## 3. Attack B — Relational Binding is too generic

### Attack

`Binding` may recreate a generic `relations` bucket.

### Test

Binding has a narrower protected question:
- endpoints/anchors;
- typed role;
- directionality;
- scope/reference/time;
- cardinality/participation where material.

Its distinct failures are wrong endpoint/role/scope/time and generic-link semantic loss.

Standing/control/transition questions are explicitly excluded when the central issue is not simply how anchors are connected.

### Result

Binding remains broad but bounded enough for a child research pass.

**Attack rejected, with reopen condition if child research becomes relation-name accumulation without stable internal structure.**

---

## 4. Attack C — Composite Standing is only a relation in disguise

### Attack

Any standing can be represented as another relation, e.g. `Work verifiedBy Verifier` or `Actor authorizedFor Action`.

### Test

Such edges erase decision-critical anchors:
- criterion;
- exact target/version;
- evidence;
- time/currentness;
- intended use;
- authority;
- Environment conditions;
- Work context.

`verified`, `validated`, `accepted`, `actionable`, `goal attained` and `evidence sufficient` each have failure modes based on omitted anchors/criteria and stale evaluation.

The issue is not storage representation; it is the **multi-anchor evaluation semantics**.

### Result

Composite Standing has a distinct protected question and failure family.

**Attack rejected.**

---

## 5. Attack D — Control is only relation + transition precondition

### Attack

Mathematically, a control might be modeled as a predicate over transitions; no separate research region is needed.

### Test

Foundation research must distinguish:

```text
policy representation
!= legitimate authority
!= authorization decision
!= obligation
!= technical enforcement
!= observed compliance
```

It must also handle:
- bypass/alternate path;
- separation of duty;
- escalation/human gate;
- delegated authority;
- environment-specific enforcement;
- permitted vs required behavior.

These failures remain meaningful even if one later formalism encodes them as predicates/guards.

### Result

Control/Constraint is a distinct **problem region**, not a commitment to a formalism.

**Attack rejected.**

---

## 6. Attack E — Transition / Effect / Feedback belongs entirely to Work

### Attack

Change/action is Work; therefore a separate composition transition child duplicates Work.

### Test

Cross-ground transitions include:
- exogenous Environment change with no focal Work;
- observation/acquisition creating Information from Environment;
- Actor role/authority/delegation standing change;
- Information correction invalidating a prior composite standing;
- Work Conditions changing readiness;
- feedback cycles where one Work's effect becomes another Work's Environment.

The transition problem asks how **ground states and composite standings change and propagate**, not what Work itself is.

### Result

**Attack rejected.**

---

## 7. Attack F — Evidence / Provenance must be a fifth child

### Attack

Evidence/provenance is pervasive and externally standardized; it may deserve peer status.

### Test

Its protected questions decompose without loss:
- source/derivation/attribution → Binding;
- evidential sufficiency/currentness → Composite Standing;
- verification/evidence gate → Control;
- generation/derivation/invalidation → Transition.

W3C PROV itself contains several distinct relation/event kinds rather than proving one provenance-level composition kind.

### Result

**No fifth child forced.** Retain provenance/evidence as mandatory cross-cutting family.

---

## 8. Attack G — Causation must be a fifth child

### Attack

Causation is too important to leave cross-cutting.

### Test

The load-bearing distinction is already preserved:

```text
sequence != causation
intended effect != realized effect
evidence of effect != effect itself
```

Causal questions concentrate in Binding + Transition/Effect and require evidential qualification.

Current parent-level evidence does not show a stable child whose scope is not mostly those regions.

### Result

**No fifth child currently justified.** Reopen if Transition/Effect deepening cannot preserve causal semantics without residualization.

---

## 9. Attack H — Pairwise relations are sufficient after all

### Attack

Any multi-ground composite can be decomposed into pairwise edges and recomposed by query.

### Test

The query may reconstruct anchors but still requires semantics for the evaluated result:
- actionability;
- authorization for a request;
- verification/validation standing;
- acceptance;
- goal attainment.

If those are encoded only as pairwise edges, their criteria/reference/evaluation semantics migrate into opaque edge attributes or application logic.

### Result

Pairwise graph connectivity is not equivalent to Foundation composition semantics.

**Attack rejected.**

---

## 10. Attack I — Overlap makes the four regions a bad hierarchy

### Attack

One verification episode contains all four regions; therefore they are not valid siblings.

### Test

The project already accepts diagnostic problem regions that are not mutually exclusive event classes when protected questions/failure modes differ.

For one verification episode:
- Binding asks target/criterion/evidence/verifier connections;
- Standing asks whether `verified` actually holds;
- Control asks what gate/authority/independence rules apply;
- Transition asks what verification activity occurred and what state/standing changed.

Different questions and remedies survive on the same episode.

### Result

Overlap is expected and does not falsify sibling **research regions**.

**Attack rejected.**

---

## 11. Attack J — The four regions smuggle architecture/ontology

### Attack

The decomposition may imply graph edges, status objects, policy engines and state machines.

### Test

No region requires a representation mechanism:
- Binding can be stored/reasoned in many ways;
- Standing may be explicit, computed, asserted or inferred;
- Control may be human/institutional/procedural/technical;
- Transition may be modeled through events, state change, logs, causal models or other formalisms.

### Result

The structure is semantic research routing, not component/schema design.

**Attack rejected.**

---

## 12. Attack K — A fifth Foundation ground has reappeared

### Attack

Perhaps Control or Composite Standing is really a new top-level ground.

### Test

Both are defined by how existing ground anchors compose. They do not have an independent referent/problem locus analogous to Environment, Information, Work or Actors.

Control requires authority/Actors, represented policy/Information, controlled Work/transition and realized enforcement/Environment.

Composite Standing requires multiple ground facts/relations/criteria.

### Result

They remain composition regions, not peer Foundation grounds.

**Adequacy not reopened.**

---

## 13. Attack L — Proposed child sequencing is overdetermined

### Attack

`Binding → Standing → Control → Transition` may impose false linear dependency.

### Test

Only one dependency is robust:
- later cross-ground semantics require precise anchor/role/binding distinctions, so Relational Binding has the highest value as first child.

The remaining regions are mutually informative:
- Standing research may expose control prerequisites;
- Control research may expose transition semantics;
- Transition research may reveal missing binding types.

### Result

Revise sequencing claim:

> **Relational Binding should be first. After its closure, re-select among Composite Standing, Control and Transition rather than pre-committing to a fixed full sequence.**

**Attack partially succeeds; sequencing recommendation corrected.**

---

## 14. Final adversarial judgment

Parent coherence: **SURVIVES**.

Immediate research regions:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Composite Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

Status:
- boundedly supported at current Foundation depth;
- no fifth composition region forced;
- no upstream adequacy falsifier survives;
- no stronger rival organizing frame found;
- no child is active until user evaluation/transition.

## 15. Verification boundary

C7 is same-model adversarial review.

Evidence includes:
- accepted Foundation grounds and adequacy result;
- six pairwise probes;
- multi-ground hard cases;
- serious rival frames;
- authoritative external holdouts (W3C PROV, NIST ABAC, NASA systems V&V);
- candidate-study falsifiers.

**No independent second-researcher/model replication has validated the exact parent decomposition. No external standard publishes this exact four-child research frame.**

User evaluation may close the parent sequencing gate but does not change verification independence.

## 16. Closure recommendation

Return the parent result for user evaluation.

If accepted:
- activate **Relational Binding** as the first child pass;
- do not automatically activate the other three children;
- after Binding closure, re-evaluate the next child based on what Binding exposes.

Do not proceed to architecture, ontology/data model or implementation.