# Informational State / Representational Constitution — N2 First-Principles Problem Inventory

**Status:** COMPLETE; problem inventory only, not a child hierarchy  
**Date:** 2026-09-05  
**Dependency:** `N1-NODE-COHERENCE-ATTACK.md`

## 1. Method

N2 asks:

> If an informational result/representation already exists, what distinct questions must be answerable for a later system or Actor to identify, interpret, compare and use that state without silently changing what it means?

The inventory starts from failure cases rather than familiar object nouns or imported ontology classes.

Every problem family remains structurally unclassified until N3.

---

## P1 — Referent / subject binding

Core question:

> **What is this informational state about?**

Failure cases:

- wrong entity/version is bound to otherwise correct content;
- a property value is detached from the entity/property it qualifies;
- proxy/sample/model object is silently treated as the underlying target;
- a representation refers to a class/aggregate while the consumer assumes one instance;
- ambiguous identifier resolution changes the target without changing visible content.

Decision-critical distinction:

`20°C` alone is not the same informational state as `room A temperature = 20°C`.

Potential structural role: constituent of meaning/constitution; child status unresolved.

---

## P2 — Applicability / scope / reference-frame binding

Core question:

> **Under what spatial, temporal, population, quantifier, scenario or other applicability boundary does the content hold?**

Failure cases:

- a 2025 observation is treated as current;
- one region/sample is generalized to all regions;
- historical, forecast and current-state scopes are collapsed;
- `some`, `most` and `all` distinctions disappear in a summary;
- an estimate conditioned on scenario X is used under scenario Y;
- a value is valid in one unit/reference frame but interpreted in another.

Why separate from P1 for inventory purposes:

The target can remain the same while the applicable slice/frame changes materially.

Potential structural role: semantic/applicability qualifier; may merge with P1/P3 later.

---

## P3 — Representational content / semantic interpretation

Core question:

> **What does the state express under the interpretation convention being used?**

Failure cases:

- the same symbol/string receives different interpretations;
- vocabulary/schema semantics are missing or stale;
- summary wording silently strengthens/weakens content;
- content is syntactically valid but semantically underdetermined;
- units, categories or relation semantics are misread;
- encoded value is preserved but the mapping needed to understand it is lost.

Questions:

- proposition, description, value, distribution, graph, model, image-derived feature or other content?
- which interpretation maps representation to meaning?
- which distinctions are explicit versus implied by external conventions?

Potential structural role: central constitution problem.

---

## P4 — Representation form / encoding / realization binding

Core question:

> **Which concrete representation/form carries the state, and which properties of that realization matter for interpretation or identity?**

Failure cases:

- same semantic content in JSON/XML/text is double-counted as independent information;
- two byte-identical values are interpreted under different schemas;
- lossy encoding removes decision-critical precision;
- canonicalization/normalization changes comparison behavior;
- rendered view hides distinctions present in source representation.

This family exists because semantic equivalence and representation identity are not the same question.

Potential structural role: State constitution dimension; may merge with P3/P6.

---

## P5 — Mode / stance / representational commitment

Core question:

> **In what mode is the content presented or held?**

Examples:

- observation result;
- assertion/report;
- assumption;
- hypothesis;
- estimate;
- forecast;
- simulation output;
- plan representation;
- normative/policy statement;
- question or candidate alternative.

Failure cases:

- forecast treated as realised fact;
- hypothesis treated as accepted conclusion;
- quoted assertion treated as system endorsement;
- simulated value treated as observed value;
- normative representation confused with actual binding authority.

Potential structural role: qualification/interpretation dimension; not automatically a content subtype hierarchy.

---

## P6 — Informational identity / granularity / equivalence / composition

Core question:

> **When are two instances the same informational state for the protected purpose, and when are they copies, versions, projections, specializations, aggregates, fragments or materially different states?**

Failure cases:

- same content from two independent sources is collapsed into one evidence item;
- one copied artifact is counted as independent corroboration;
- different versions share an identifier and are silently conflated;
- aggregate and constituent states are treated as interchangeable;
- a projection/view is mistaken for the complete source;
- semantically equivalent encodings are treated as different facts;
- same bytes under different scope/schema are treated as the same state.

Records research strongly confirms this problem but also shows identity criteria depend on protected use and surrounding bindings.

Potential structural role: comparison/individuation relation over constitution; child status unresolved.

---

## P7 — Source / holder / perspective / attribution

Core question:

> **Who/what originated, asserted, observed, derived, currently holds or presents the state, and from which perspective?**

Failure cases:

- one Actor's belief becomes implicit system belief;
- source and current holder are conflated;
- quoted content is attributed to the transmitter rather than originator;
- derived system estimate is presented as direct external-source statement;
- shared store content is assumed to be known/accepted by every Actor.

Boundary:

Actor identity/authority is not State-local. State owns attribution/perspective only insofar as the relation changes interpretation, provenance or standing of the representation.

Potential structural role: relational qualification, likely cross-cutting.

---

## P8 — Uncertainty / reliability / epistemic-evidential standing

Core question:

> **What uncertainty, confidence, reliability or evidential standing legitimately accompanies this state, relative to what basis or target?**

Failure cases:

- point estimate loses uncertainty interval/distribution;
- confidence number survives but its basis/model does not;
- authoritative source status is mistaken for guaranteed truth;
- one claim's evidence role is generalized to unrelated questions;
- retrieval result existence becomes `fact` status;
- repeated copies are mistaken for independent evidence.

Boundary:

- actual truth depends on relation to reality, not merely state metadata;
- evidence is target-relative;
- authority partly belongs to Actors/policy/control;
- verification/evaluation processes may belong to Dynamics/Work.

Potential structural role: high-value state standing/qualification family, but strongly relational.

---

## P9 — Temporal standing / freshness / known-time vs applicable-time

Core question:

> **When does the state apply, when did it become known/recorded, and what current/historical standing does it have?**

Failure cases:

- old but correctly preserved state treated as current;
- correction/retraction exists but old state retains `current` interpretation;
- effective time and recorded/known time are collapsed;
- valid-at-the-time report is judged against later facts without temporal qualification;
- source is fresh but underlying referred condition is historical.

Potential structural role: scope/qualification dimension plus change relation to Dynamics. Records deepens the persistent history case.

---

## P10 — Plurality / compatibility / conflict relations

Core question:

> **When multiple states overlap, are they genuinely contradictory, merely different in scope/time/perspective/granularity, or compatible rival hypotheses?**

Failure cases:

- scope mismatch mistaken for contradiction;
- real contradiction hidden as versioning;
- consensus mistaken for truth;
- one state silently overwrites a competing hypothesis;
- uncertainty intervals overlap but point estimates are treated as categorical conflict.

Important structural warning:

Conflict does not exist inside one isolated state; it is a relation over at least two states plus comparison conditions.

Potential structural role: cross-state relation/condition, unlikely immediate child.

---

## P11 — Availability / visibility / persistence status

Core question:

> **Does the state exist in a source, remain available across a horizon, and/or currently appear in the consumer-visible working set?**

Failure cases:

- source exists but current context omits it;
- information persists but is not retrievable;
- current visible copy is stale relative to source;
- transient result is assumed recoverable later;
- persistence itself is mistaken for authority/currentness.

Structural warning:

This family spans State conditions, Informational Dynamics (retrieval/exposure/context formation), Records persistence and Environment/Actors access dependencies.

Potential structural role: boundary/cross-cutting status; not likely State child.

---

# 12. Failure-pair tests

N2 deliberately seeks cases where one family can fail while another remains correct.

| Case | Correct | Wrong |
|---|---|---|
| right value, wrong room | P3 content value | P1 referent |
| right target, wrong historical period | P1 referent | P2/P9 applicability |
| same meaning in two encodings | P3 semantics | naive P4/P6 identity |
| exact copy counted as second witness | P3 content | P6 identity + P7 attribution |
| accurate quotation treated as system belief | P3 quoted content | P5/P7 standing |
| correct estimate with uncertainty omitted | P1/P3 | P8 qualification |
| two scoped claims called contradictory | individual P1/P3 | P10 comparison |
| persistent false claim | persistence | P3/standing/truth relation |

The table shows genuine separable failure questions, but separability alone does not prove hierarchy.

---

# 13. Emerging structural observation

Most families do not describe disjoint populations of informational states. Instead they answer mutually constraining questions about the **same state**:

```text
What is it about?                 P1
Under what scope/frame?           P2/P9
What does it express?             P3
How is it represented?            P4
In what mode/stance?              P5
What makes it same/different?     P6
Whose/from what perspective?      P7
With what standing/uncertainty?   P8
How does it compare to others?    P10
Where/for how long is it visible? P11
```

This is strong evidence that N3 must distinguish **constitution dimensions/relations** from actual child problem regions.

---

# 14. N2 verdict

The inventory exposes eleven load-bearing problem families without requiring a vocabulary-driven taxonomy.

Strongest current conclusion:

> **Informational State is not exhausted by `content`; a usable state may depend on reference/applicability, interpretation/form, mode, identity, attribution, standing and cross-state relations. But these concerns appear highly interdependent and do not yet form clean immediate children.**

N3 must compare rival decompositions, including the serious possibility that Informational State is a bounded leaf whose internal map is dimensional/relational rather than hierarchical.
