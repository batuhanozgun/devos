# Relational Binding — B4 Rival Internal Decompositions / Child-Discovery Pressure

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Decision question

Should Relational Binding decompose into immediate children, or should it close as one bounded child with:

- a reusable binding-signature grammar;
- cross-cutting semantic family profiles;
- no further universal child split at current Foundation depth?

## 2. Candidate R1 — pairwise ground children

```text
Relational Binding
├─ Environment ↔ Information
├─ Environment ↔ Work
├─ Environment ↔ Actors
├─ Information ↔ Work
├─ Information ↔ Actors
└─ Work ↔ Actors
```

### Strength

Coverage is obvious and complete over four grounds.

### Failure

The same binding family recurs across pairs:
- reference/targeting;
- participation/position;
- dependency/support;
- provenance/attribution.

A pairwise hierarchy duplicates the Binding signature six times and makes multi-ground qualified relations awkward.

It also encourages pair ownership for semantics that may require a third anchor.

### Judgment

**REJECT as child structure.** Keep pair matrix as discovery/testing surface.

---

## 3. Candidate R2 — four semantic-family children

```text
Relational Binding
├─ Reference / Targeting
├─ Participation / Position
├─ Dependency / Support
└─ Provenance / Attribution
```

### Strength

These are the strongest recurring family pressures from B2.

They have recognizable failure modes:
- wrong referent/target;
- wrong participant role;
- omitted/mis-scoped dependency;
- wrong source/derivation/attribution.

### Attack A — overlap

Examples:
- `Actor A is source of Information I` = Participation/Position + Provenance/Attribution;
- `Evidence E is about target T and derived from Work W` = Reference + Provenance;
- `Actor A is required reviewer for Work W` = Participation + Dependency + later Control;
- `Work W targets Environment E using resource R` = Reference/Targeting + Dependency/Support;
- measurement result ↔ referent ↔ procedure/source = Reference + Provenance + Work binding.

A diagnostic hierarchy may tolerate overlap, so overlap alone is not fatal.

### Attack B — protected-question independence

Deep questions inside each family substantially inherit semantics from accepted grounds:
- reference/aboutness is already rooted in Information referent/scope semantics and Work target semantics;
- participation roles depend heavily on Actors standing/participation distinctions;
- dependency/support inherits Work dependency plus Environment Work-Conditions semantics;
- provenance inherits Information Dynamics plus Actor/Work participation and Transition/generation semantics.

A child pass under Binding would risk **re-researching ground-local semantics** instead of investigating cross-ground binding structure.

### Attack C — residual relations

The four families do not cleanly place:
- situation/location;
- access/interface;
- ownership/stewardship;
- beneficiary/affected-party;
- specification/criterion linkage;
- representation of Actor standing;
- exact-version traceability;
without overlap or an `other binding` bucket.

### Judgment

**DO NOT PROMOTE as universal immediate children at current evidence.**

Retain them as high-value relation-family profiles under the Binding signature.

---

## 4. Candidate R3 — Reference vs Participation vs Dependency vs Attribution, with residual profiles

This softens R2 by explicitly allowing `other/cross-cutting` profiles.

### Strength

Operationally useful retrieval index.

### Failure

A structural child hierarchy that knowingly needs a residual bucket at inception is weak evidence of natural first-order decomposition.

The family boundaries still depend on which protected question is foregrounded rather than on stable exclusive semantic regions.

### Judgment

**Useful findings map, not child hierarchy.**

---

## 5. Candidate R4 — Direct / Binary vs Qualified / N-ary Binding

```text
Relational Binding
├─ Direct / Binary
└─ Qualified / N-ary
```

### Strength

B3 demonstrated real semantic loss from naive binary decomposition.

### Failure

Binary vs n-ary is **structural shape**, not distinct semantic problem domain.

The same Reference, Participation, Dependency or Provenance relation may be binary in one case and qualified/n-ary in another.

Failure correction remains: preserve all semantic positions/qualifiers in one binding instance.

### Judgment

**REJECT as child split.** Keep arity/qualification as cross-cutting Binding dimension.

---

## 6. Candidate R5 — Structural/Descriptive vs Intentional/Normative Binding

Possible split:

```text
Relational Binding
├─ Descriptive / realized connection
└─ Intentional / institutional / normative connection
```

### Strength

Highlights difference between:
- actual source/participation/reference/dependency;
- intended target, assignment, delegation or obligation.

### Failure

Normativity quickly belongs Control/Actor standing rather than Binding.

Intentional relations may still be Work/Information representations or plans rather than actual bindings.

Many relations do not fit cleanly:
- provenance can be descriptive but contested;
- participation can be actual or assigned;
- target can be intended while referent is descriptive;
- dependency can be realized or specified.

### Judgment

**REJECT.** Modality/normativity is a cross-ground boundary issue, not stable Binding child structure.

---

## 7. Candidate R6 — Anchor-role / applicability / relation-type structural children

Possible grammar hierarchy:

```text
Relational Binding
├─ Anchor / Position Structure
├─ Applicability / Qualification
└─ Relation-Type / Inference Semantics
```

### Strength

Directly reflects B1/B3 findings.

### Failure

These are **dimensions of every binding**, not separate problem regions. Researching one without the others would repeatedly revisit the same binding instance.

They do not have independent domain referents; they form one semantic signature.

### Judgment

**REJECT as children. Retain as internal constitution dimensions.**

---

## 8. Candidate R7 — provenance/traceability-centered decomposition

A standards-driven alternative might place:
- source/derivation;
- target/reference;
- actor association;
- activity use/generation;
under a provenance/traceability hierarchy.

### Strength

Rich formal traditions and practical auditability.

### Failure

Not all cross-ground binding is provenance:
- current dependency/support;
- beneficiary/affected-party relation;
- target/intended-object relation;
- situated access;
- Work role/acceptance position.

Making provenance the parent would force non-lineage relations into an information-history lens.

### Judgment

**REJECT as universal Binding decomposition.**

---

## 9. Candidate R8 — relation-type taxonomy by verbs

Examples:
- uses;
- produces;
- owns;
- targets;
- depends-on;
- represents;
- participates-in;
- authorizes;
- verifies.

### Failure

Lexical verbs are scope- and domain-sensitive and often collapse neighbouring composition regions.

Examples:
- `authorizes` may describe actual Actor authority, represented policy, decision outcome or control rule;
- `verifies` may mean Work activity, evidence relation or composite `verified` standing;
- `produces` may mean Work output binding or Transition/generation event.

### Judgment

**Strongly reject as Foundation child method.**

---

# 10. Why bounded-leaf structure currently wins

The B1/B3 signature explains all tested relation families without manufacturing duplicate branches:

```text
Relational Binding
    binding meaning / type semantics
    exact anchors in typed semantic positions
    applicability frame
    conditional temporal validity
    qualified / n-ary structure when needed
    relation-instance individuation
    inference-profile distinctions when load-bearing

    Family profiles:
      - Reference / Representation / Targeting
      - Participation / Position
      - Dependency / Support
      - Provenance / Attribution
      - Situation / Access / Interface
      - Specification / Evidence / Traceability
```

This model permits one real binding episode to be inspected through several family lenses without forcing duplicate identity or artificial ownership.

## Distinctive Binding-local failure family

Across all profiles, the correction remains recognizably Binding-local:
- wrong anchor;
- wrong semantic position/role;
- wrong relation meaning;
- lost scope/reference frame;
- stale/wrong temporal applicability;
- qualifier cross-combination;
- invalid inverse/transitive/symmetry inference;
- generic-link semantic loss;
- represented link mistaken for actual binding.

These failure modes are more stable than the relation-family taxonomy.

---

# 11. Duplication test against accepted grounds

A proposed Binding child should add cross-ground semantics rather than repeat an existing ground.

### Reference child risk

Could re-research Informational State referent/scope and Work target semantics.

### Participation child risk

Could re-research Actors role/participation/standing.

### Dependency child risk

Could re-research Work dependency/coordination and Environment Work Conditions.

### Provenance child risk

Could re-research Information Dynamics/Records and Transition/Effect.

### Result

At current depth, **family-specific deepening has lower information value than preserving one shared cross-ground binding grammar**.

A later domain may justify profile-specific specialization, but current universal Foundation evidence does not.

---

# 12. Child-promotion test

Criteria:
- distinct protected question;
- distinct failure family;
- stable across materially different domains;
- not adequately represented as dimension/profile;
- does not mainly duplicate accepted ground semantics.

| Candidate | Protected question | Distinct failures | Cross-domain | Not just profile | Avoids ground duplication | Current verdict |
|---|---|---|---|---|---|---|
| Pairwise ground children | weak | mixed | yes | no | no | reject |
| Reference/Targeting | moderate | yes | yes | uncertain | weak | profile |
| Participation/Position | moderate | yes | yes | uncertain | weak | profile |
| Dependency/Support | moderate | yes | yes | uncertain | weak | profile |
| Provenance/Attribution | moderate | yes | yes | uncertain | weak | profile |
| Qualified/N-ary | structural | yes | yes | no | yes | dimension |
| Direct/Normative | weak | mixed | mixed | no | weak | reject |
| Signature dimensions | shared grammar | yes collectively | yes | no | yes | internal map |

No candidate clears all promotion gates.

---

# 13. B4 provisional judgment

Strongest current structure:

> **Relational Binding is likely a bounded leaf at current Foundation depth, with a reusable semantic signature and overlapping relation-family profiles rather than universal immediate children.**

This remains provisional until external authoritative/candidate holdouts in B5 attack it.

B5 should especially test:
- qualified relation semantics;
- n-ary association;
- role/time/scope qualification;
- representation/reference targeting;
- whether provenance/annotation standards reveal a stable child split absent from internal evidence.

Proceed to B5.