# Relational Binding — B6 Synthesis / Immediate-Child Decision

**Status:** COMPLETE / PROVISIONAL BOUNDED-LEAF DECISION  
**Date:** 2026-09-05

## 1. Executive result

Relational Binding is a coherent and load-bearing immediate region of Cross-Ground Composition.

At the current Foundation depth, however, **no stable universal immediate child survives**.

Strongest current judgment:

> **Relational Binding is a bounded leaf whose internal structure is a reusable binding-semantic signature plus overlapping relation-family profiles.**

This result is provisional until B7 adversarial closure.

---

# 2. What Relational Binding is

Protected formulation:

> Relational Binding concerns what accepted-ground anchors are connected, in what semantic positions and under what applicability conditions, such that replacing the connection with a generic link would lose decision-critical meaning.

The result is not a relation vocabulary and not a graph model.

---

# 3. Internal binding-semantic signature

## 3.1 Binding meaning / relation-type semantics

A binding must preserve the protected semantic question of the connection.

Examples:
- representation-about;
- participation-as;
- depends-on / supported-by;
- source/derivation/attribution;
- targets;
- situated-in / accesses.

Generic `related-to` is insufficient when relation-specific failure/remedy differs.

Where decision-critical, the relation type also needs an **inference profile**:
- symmetric or not;
- inverse reading;
- direct versus indirect;
- transitive/closure semantics or explicit non-transitivity.

Graph reachability alone cannot determine this.

## 3.2 Exact anchors in typed semantic positions

The same anchor may occupy multiple roles in the same broader episode.

Binding must preserve:
- exact identity/version/equivalence needed by the claim;
- which semantic position each anchor occupies.

Examples:

```text
performer != verifier != authorizer
source != holder != asserter != recipient
Work target != Environment support resource
```

A generic arrow direction is weaker than role-labeled/typed positions.

## 3.3 Applicability structure

The binding may apply only relative to:
- scope;
- focal Work;
- analytical/reference frame;
- operation;
- method/stage;
- target version/state;
- use/purpose;
- location/population/source universe;
- effective/reference time.

Rule:

> If changing an omitted frame/qualifier changes whether the relation meaningfully holds, that information is part of the binding semantics.

## 3.4 Relation-instance individuation

When identical anchors/relation type recur with different roles, scopes, times or qualifiers, the separate binding claims must not cross-combine.

Example:

```text
A performs W at t1
A verifies W at t2
```

must not become one undifferentiated bag of:

```text
A ↔ W + performer + verifier + t1 + t2
```

This is a semantic requirement, not a database reification decision.

## 3.5 Qualified / n-ary structure when needed

Some bindings are safely binary. Others require additional semantic positions.

Examples:
- Actor ↔ Work as Role at Time;
- evidence ↔ claim about exact target/version under criterion;
- delegation among delegator/delegatee/principal/operation/scope;
- Work dependency on resource only for method/stage.

The requirement is:

> preserve all arguments/qualifiers belonging to the same binding instance.

No RDF/graph/object representation is prescribed.

## 3.6 Temporal applicability

Distinguish:
- effective time of relation;
- reference/as-of time;
from:
- assertion/record creation time;
- event time that established/removed relation.

The latter may belong Information/Transition.

---

# 4. Relation-family profiles retained

These are retrieval/research profiles, not children.

## 4.1 Reference / Representation / Targeting

Questions:
- what is this Information about?
- what exact referent/state/version/time?
- what does this Work target?
- what specification/evidence binds to what target?

Typical failures:
- wrong referent;
- broad target instead of specific segment/state/version;
- stale/time-misaligned reference;
- intended target mistaken for realized effect.

## 4.2 Participation / Position

Questions:
- in what capacity is an Actor/bearer related to Work/Information/Environment?

Typical positions:
- performer;
- requester;
- decider;
- verifier;
- source;
- holder;
- recipient;
- beneficiary;
- accountable party.

Typical failure:
- role/position collapse.

## 4.3 Dependency / Support

Questions:
- what does Work/Actor/operation rely on or receive support from?
- under what method/stage/path is dependency real?

Typical failures:
- omitted dependency;
- optional support treated as prerequisite;
- availability treated as sufficiency;
- indirect support mistaken for direct dependency.

## 4.4 Provenance / Attribution

Questions:
- what source/activity/Actor/path is this Information/result/contribution derived from or attributed to?

Typical failures:
- wrong source;
- wrong generation/use/derivation/association relation;
- contribution mistaken for responsibility;
- provenance record mistaken for authentic/authoritative truth.

## 4.5 Situation / Access / Interface

Questions:
- what resource/interface/location/channel is Actor/Work situated relative to or technically able to reach?

Boundary:
- reachability/access binding != actionability != authority.

## 4.6 Specification / Evidence / Traceability

Questions:
- what requirement/criterion/claim/evidence/result is bound to which exact Work/target/version?

Boundary:
- evidence-target binding != evidence sufficiency != verified standing.

---

# 5. Why the family profiles are not children

## 5.1 They overlap structurally

Examples:

```text
Actor source of Information
→ participation + provenance

Evidence about target produced by verification Work
→ reference + provenance + Work binding

Actor required as reviewer
→ participation + dependency + later Control
```

## 5.2 Deep semantics are already grounded elsewhere

- Reference/aboutness → Information referent/scope + Work target semantics;
- Participation → Actors;
- Dependency → Work + Environment Work Conditions;
- Provenance → Information Dynamics + Actors/Work + Transition.

Binding's unique cross-ground contribution is the **precise association grammar**, not re-owning those ground-local meanings.

## 5.3 No profile avoids a residual bucket

Other valid bindings include:
- ownership/stewardship;
- beneficiary/affected-party;
- situation/location;
- access/interface;
- representation of standing;
- exact-version traceability.

They can be expressed by the shared signature but do not fit a clean four-family partition without overlap/`other`.

## 5.4 External holdouts support qualification rather than a universal taxonomy

- W3C PROV-O uses multiple specific and qualified influence relations;
- W3C n-ary note shows relation-instance arguments/qualification;
- Web Annotation uses SpecificResource/Selector/State/Scope/Purpose;
- NIST ABAC requires subject/object/operation/environment context before authorization evaluation.

These strengthen the shared binding grammar. None supplies a stable universal Binding child hierarchy.

---

# 6. What is explicitly outside Binding

## Composite Standing

Examples:
- verified;
- accepted;
- actionable;
- evidence sufficient;
- goal attained;
- authorized-for-operation.

Bindings provide anchors; Standing evaluates them with criteria/currentness.

## Control / Constraint

Examples:
- permitted;
- required;
- blocked;
- gated;
- obligation;
- technical enforcement.

Binding states the exact request/delegation/participation/target; Control determines normative/technical effect.

## Transition / Effect / Feedback

Examples:
- generation event;
- delegation/revocation event;
- Work changes Environment;
- observation created from event;
- relation established/removed;
- causal/effect propagation.

Binding can describe before/after relations but does not own the change mechanism.

## Evidence that binding is true/current

An informational assertion of relation does not establish actual relation.

```text
represented/asserted binding
!= actual binding
!= evidence sufficient to establish binding
```

---

# 7. Child-promotion decision

Tested candidates:
- six pairwise ground children;
- Reference / Targeting;
- Participation / Position;
- Dependency / Support;
- Provenance / Attribution;
- Qualified / N-ary;
- Direct vs qualified;
- descriptive vs intentional/normative;
- structural signature dimensions.

No candidate simultaneously achieves:
- distinct protected question;
- stable independent failure family;
- cross-domain stability;
- non-residual coverage;
- low false-disjointness;
- low duplication of accepted ground semantics.

## Decision

```text
Relational Binding
    ← BOUNDED LEAF PROVISIONAL
    ← no immediate child promoted
    ← rich internal signature + family profiles
```

---

# 8. External-evidence interpretation

External standards are **counterframes**, not validation of this exact synthesis.

They support narrower claims:
- qualified relations can carry role/time/additional participants;
- exact target/state/scope can be relation-specific;
- n-ary semantics can be lost by naive binary decomposition;
- operation/environment context can be required before later authorization evaluation.

No source publishes or independently verifies this project's exact bounded-leaf judgment.

---

# 9. Verification limit

B0–B6 are same-researcher synthesis using canonical internal evidence, accepted ground results, parent composition evidence, authoritative external holdouts and selected candidate-study pressure.

B7 remains required as same-model adversarial closure.

Independent second-researcher/model replication has not been performed.

---

# 10. B6 judgment

Relational Binding is **provisionally boundedly complete at current Foundation depth**.

No deeper universal child pass is currently justified.

Proceed to B7 and attempt to falsify:
- bounded-leaf status;
- signature dimensions;
- family non-promotion;
- actual-vs-represented distinction;
- n-ary/instance-individuation claim;
- boundary with Standing/Control/Transition;
- architecture neutrality.