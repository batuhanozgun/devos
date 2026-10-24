# Relational Binding — B3 Qualification / Arity / Scope / Time / Reference-Frame Audit

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Test whether qualified/n-ary Binding deserves its own immediate child, or whether qualification/arity/scope/time are structural dimensions that recur across all binding families.

Required hard cases were chosen to expose semantic loss from naive binary decomposition.

---

## 2. Hard case A — same Actor, same Work, different roles/times

Case:

```text
Actor A performs Work W during t1
Actor A verifies Work W during t2
```

Naive independent binary links:

```text
A —participates-in→ W
A —role→ performer
A —role→ verifier
A —time→ t1
A —time→ t2
```

permit false recombinations:
- verifier at t1;
- performer at t2;
- both roles simultaneously.

### Semantic requirement

The semantic unit must preserve which:
- Actor;
- Work;
- participation role;
- temporal applicability;

belong to the **same binding instance**.

### Result

N-ary/qualified structure is real semantic pressure, not merely storage syntax.

It does not yet imply a child. It appears as a property of Participation bindings.

---

## 3. Hard case B — representation about scoped/time-indexed Environment state

Case:

```text
Information I represents temperature of system S
at location L
for interval T
under measurement/reference frame F
```

Binary `I about S` is insufficient if:
- S has several characteristics;
- the same information applies only to one location/time;
- frame/calibration/reference assumptions change interpretation.

### Semantic requirement

The relation must preserve the **specific referential target** and applicability frame, not merely the persistent Environment entity.

The target may effectively be:

```text
S-as-characteristic-C-at-location-L-during-T-under-frame-F
```

without requiring Foundation to choose whether that is represented as one composite target, several qualifiers or an n-ary relation object.

### Result

Reference/Representation bindings routinely require qualification. This is not unique to a `Qualified Binding` family.

---

## 4. Hard case C — Work depends on resource only for one method/stage

Case:

```text
Work W depends on Environment resource R
only when using method M during stage S
```

A generic:

```text
W depends-on R
```

can cause false conclusions:
- R is required for every method;
- Work is globally blocked when R is unavailable;
- alternative method M2 is impossible.

### Semantic requirement

Dependency applicability must preserve:
- Work anchor;
- resource anchor;
- method/stage/reference path;
- potentially time or condition.

### Result

Dependency/Support binding is frequently **path-/method-relative**. Qualification is part of the binding signature when it changes feasibility semantics.

---

## 5. Hard case D — delegation with scoped authority

Binding-relevant portion of a later Control problem:

```text
Delegator A
→ Delegatee B
for operation O
on Work/target W/T
for scope S
possibly on behalf of principal P
```

A binary:

```text
A delegates-to B
```

is dangerously incomplete.

It can silently imply:
- broader authority than intended;
- authority over wrong Work/operation;
- wrong principal;
- wrong duration/environment.

### Binding/control boundary

Binding owns the exact anchors/positions/scope that define **what delegation relation is being referred to**.

Control owns whether that delegation validly authorizes an action, what policy permits it, and whether enforcement honors it.

### Result

Qualified/n-ary binding is necessary to state the delegation relation precisely, but its normative effect remains outside Binding.

---

## 6. Hard case E — evidence bound to exact target/version

Case:

```text
Evidence E supports result/claim about target artifact T@v7
under criterion C
```

If the target later becomes `T@v8`, the evidence relation does not automatically transfer.

A binary:

```text
E evidence-for T
```

can erase:
- exact version;
- claim/criterion;
- verification target;
- time/currentness.

### Binding/Standing boundary

Binding owns exact evidence ↔ claim/target/version/criterion association.

Composite Standing later asks whether that evidence is sufficient/current enough to justify `verified`, `accepted`, etc.

### Result

Version/equivalence constraints can be part of Binding semantics even when the same persistent logical artifact identity is retained.

---

## 7. Hard case F — qualified provenance

A result/entity may be related to:
- source entity;
- generating/using activity;
- Actor/agent association;
- role;
- time;
- derivation path.

A generic provenance edge can hide whether the claim concerns:
- generation;
- use;
- derivation;
- attribution;
- association;
- delegation.

### Result

Provenance pressure again requires relation-specific positions and qualification. It does not prove provenance is a Binding child; it demonstrates the general Binding signature strongly.

---

# 8. Relation-instance individuation is semantically necessary

The hard cases share one deeper structure:

> When the same anchors can be connected more than once under different roles, times, scopes or qualifiers, Binding needs a way to distinguish **relation instances/occurrences** semantically.

This does **not** require relation objects in an ontology/database.

It means reasoning must preserve that:

```text
(A, W, performer, t1)
```

and

```text
(A, W, verifier, t2)
```

are different binding claims, not one bag of edge metadata.

## Judgment

**Binding-instance individuation is a universal conceptual requirement whenever multiple qualified bindings would otherwise cross-combine.**

---

# 9. Scope, reference frame and qualifier are related but not synonymous

## Scope

Defines the subset/domain/application within which the relation claim applies.

Examples:
- repository subtree;
- Work phase;
- operational environment;
- population;
- authority scope.

## Reference frame

Defines the analytical/focal perspective under which roles/relations are interpreted.

Examples:
- repository as Work target vs Work Condition;
- person as performer vs beneficiary relative to focal Work;
- same external system as target or support resource.

## Qualifier

Any additional semantic position/value needed to distinguish the binding claim.

Examples:
- role;
- method;
- operation;
- target version;
- location;
- criterion;
- principal.

### Judgment

Do not flatten these into one generic `context` field.

They share the broader **applicability/qualification structure**, but they answer different questions.

---

# 10. Temporal semantics are relation-relative, not just timestamp metadata

Time can matter in at least four ways:

1. **effective interval** — when binding actually holds;
2. **assertion/observation time** — when Information about binding was created;
3. **event time** — when an establishing/removing transition occurred;
4. **reference time** — what time the relation claim is about.

These must not collapse.

Example:
- delegation effective until 17:00;
- record updated at 17:10;
- revocation event occurred at 16:55;
- query asked about authority as-of 16:30.

### Judgment

Binding owns only **effective/reference temporal applicability** needed to state the connection. Assertion/event history belongs Information/Transition where appropriate.

---

# 11. Cardinality, uniqueness and completeness are not the same thing as arity

## Arity

How many semantic positions are required to express one binding instance.

## Cardinality

How many bindings/participants are permitted or expected for a relation type/context.

## Completeness

Whether the known binding set is sufficient/complete for a purpose.

### Example

`Work W requires two independent reviewers`:
- individual participation bindings can remain Actor↔Work qualified relations;
- the requirement for two distinct reviewers is a Control/Standing constraint over a set of bindings.

### Judgment

Do not absorb set-level cardinality requirements into the identity of each binding instance.

---

# 12. Relation-type inference properties are decision-critical but type-level

Graph topology often tempts invalid inference.

## Transitivity

```text
A related-to B
B related-to C
→ A related-to C ?
```

Cannot be assumed.

Examples:
- delegation is not automatically transitively valid;
- `supports` may be indirect but not semantically equivalent to direct support;
- provenance derivation/influence may permit some reachability reasoning but direct and indirect lineage differ;
- participation is not transitive.

## Symmetry

- `collaborates-with` might be symmetric under one definition;
- `represents`, `depends-on`, `source-of`, `targets` are not.

## Inverse

Many relations have useful inverse readings (`source-of` / `has-source`) but inverse labels can still preserve different query orientation without changing semantics.

### Judgment

A **binding type's permitted inference profile**—symmetry, inverse interpretation, transitive/closure semantics, direct-vs-indirect distinction—is conditionally load-bearing Foundation semantics.

It is type-level, not a mandatory property on every binding instance.

Do not infer semantic closure from graph reachability alone.

---

# 13. Is `Qualified / N-ary Binding` a stable child?

### Argument for promotion

It has distinctive failures:
- qualifier cross-combination;
- lost role/time/scope association;
- wrong binary decomposition;
- hidden additional anchor.

### Argument against promotion

The same qualification problem appears inside:
- Reference/Representation;
- Participation/Position;
- Dependency/Support;
- Provenance/Attribution;
- delegation/access/traceability.

The protected question remains:

> What exact binding holds, with which semantic positions and applicability?

Qualification changes the **shape/signature** of any family rather than introducing a distinct kind of cross-ground connection.

### B3 judgment

**DO NOT PROMOTE Qualified/N-ary Binding as an immediate child at current evidence.**

Treat it as a universal structural dimension/pattern of Binding.

---

# 14. Refined Binding signature after B3

```text
Binding semantic instance
├─ binding meaning / type semantics
│   └─ inference profile where load-bearing
├─ semantic positions
│   └─ exact anchors occupying each position
├─ applicability structure
│   ├─ scope
│   ├─ reference frame
│   ├─ effective/reference time where material
│   └─ conditions/qualifiers whose change changes the claim
├─ relation-instance individuation
│   └─ preserve which qualifiers/anchors belong together
└─ optional structural multiplicity
    └─ n-ary positions where binary decomposition loses meaning
```

Outside Binding core:
- evidence sufficiency/confidence;
- composite qualification outcome;
- permission/obligation/enforcement;
- event/transition history;
- storage/reification mechanism.

---

# 15. B3 judgment

Major findings:

1. naive binary-edge semantics are insufficient in recurring decision-critical cases;
2. n-ary/qualified semantics are real, but they are **cross-cutting Binding structure**, not a stable child;
3. relation-instance individuation is necessary to prevent qualifier cross-combination;
4. scope, reference frame, qualifier and time must remain distinguishable;
5. relation-type inference properties cannot be inferred from graph topology;
6. cardinality constraints often belong to set-level Standing/Control rather than one binding instance.

B4 must now compare the strongest internal-decomposition candidates against the alternative that **Relational Binding is a bounded leaf with one signature grammar plus overlapping relation-family profiles**.

Proceed to B4.