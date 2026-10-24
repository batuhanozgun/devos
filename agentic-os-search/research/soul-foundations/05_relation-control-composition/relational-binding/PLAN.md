# Relational Binding — Research Plan

**Status:** active child-pass plan  
**Date:** 2026-09-05

## Objective

Research the Foundation semantics of cross-ground **binding** among Environment, Information, Work and Actors after the composition parent established that precise bindings are a prerequisite for later Composite Standing, Control and Transition research.

The aim is not to produce a graph edge vocabulary. The aim is to discover:

- what makes one cross-ground binding semantically different from another;
- what information a correct binding must preserve;
- when pairwise links are insufficient;
- which binding families are stable enough to deserve deeper research;
- where Binding must stop so it does not absorb standing, control or transition semantics.

## Core constraints

### 1. Binding correctness before relation enumeration

For every candidate binding ask:
- what are the anchors?
- what role does each anchor play?
- is order/direction semantically meaningful?
- what scope/reference frame applies?
- what time/validity interval applies?
- what cardinality/arity matters?
- is a qualifier/context/criterion required?
- is the binding actual, asserted, inferred, planned, historical or hypothetical?
- what evidence supports the claim that it holds?
- what failure follows if any of this is erased?

The last two questions do not move evidence/standing into Binding; they test source/view fidelity and validity of the relation claim.

### 2. Representation != represented binding

An informational state may assert that `A relates-to B`; that representation is not automatically the actual cross-ground relation.

### 3. Pairwise != necessarily binary

Use the six accepted-ground pairs as coverage probes, but allow relation instances to require role/qualifier/time/context anchors beyond two endpoints.

### 4. No architecture leakage

Do not infer RDF/graph schema, reification strategy, relational database design, object model, event model or runtime service architecture.

External data-model standards may be used only as semantic counterframes/falsifiers.

## B0 — Canonical / evidence recovery

Recover:
- accepted parent composition result and C2/C6/C7;
- all four ground deferred-relation/open-question surfaces relevant to binding;
- exact current manifests;
- candidate-study catalog and selected META surfaces only when material.

Output:
- exact evidence inventory;
- live binding hypotheses;
- explicit upstream/child-boundary falsifiers.

## B1 — Binding object / minimum semantic signature

Attack the idea that a relation is adequately specified by `type + endpoint A + endpoint B`.

Test candidate signature dimensions:
- anchor identity / exact target;
- anchor role/position;
- direction/order;
- arity/cardinality/participation multiplicity;
- scope/reference frame;
- time/effective/currentness interval;
- qualifier/context/condition;
- modality/standing of the binding claim: actual/asserted/planned/inferred/historical/hypothetical;
- provenance/evidence of the relation claim where decision-critical.

Determine which are universal dimensions, conditional dimensions or semantics belonging to neighbouring children.

## B2 — Six-pair binding-family discovery

Use all six ground pairs:

1. Environment ↔ Information
2. Environment ↔ Work
3. Environment ↔ Actors
4. Information ↔ Work
5. Information ↔ Actors
6. Work ↔ Actors

For each:
- recover parent candidate bindings;
- group by protected semantic question rather than verb vocabulary;
- identify relation-name collisions;
- test symmetry/inverse and role direction;
- identify cases needing additional anchors/qualifiers;
- distinguish binding from standing/control/transition.

Candidate families to attack include:
- representation/reference;
- participation/role;
- dependency/support;
- provenance/attribution;
- target/reference/intended-object;
- access/situation/interface;
- source/holder/recipient;
- specification/evidence binding.

Do not promote families by frequency alone.

## B3 — Qualification / arity / scope / time / reference-frame audit

Required hard cases:
- qualified provenance relation with role/time/activity;
- same Actor participating in the same Work in different roles/times;
- representation about a scoped/time-indexed Environment condition;
- Work depending on a resource only for one method/stage/reference frame;
- delegation/authorization relation whose scope differs by operation/environment;
- target/evidence binding to exact version or past state;
- one n-ary episode that cannot be decomposed into binary links without losing which qualifier belongs to which relation instance.

Ask whether n-ary/qualified binding is a separate child or a structural property of Binding generally.

## B4 — Rival internal decompositions / child-discovery pressure

Test serious alternatives:
- no children; one Binding leaf with signature dimensions;
- pairwise ground children;
- Referential vs Participatory vs Dependency vs Provenance families;
- Structural/Descriptive vs Intentional/Normative bindings;
- Direct vs Qualified/N-ary bindings;
- Role/Participation vs Reference/Representation vs Dependency/Support vs Attribution/Provenance;
- relation-domain traditions such as provenance/authorization/traceability as primary branches.

Compare on:
- protected-question clarity;
- false disjointness;
- cross-domain stability;
- relation-family overlap;
- boundary with Standing/Control/Transition;
- architecture neutrality;
- whether a residual `other relations` bucket remains.

## B5 — External authoritative / candidate-study holdouts

Use only materially different sources that test live hypotheses.

Likely authoritative holdouts:
- W3C PROV-DM / PROV-O — qualified influence, role, time, generation/use/association/attribution/delegation;
- W3C note on n-ary relations — cases where binary property representation loses arguments/qualification;
- W3C Web Annotation Data Model — body/target, SpecificResource, selector/state/scope qualification;
- NIST ABAC only if subject/object/operation/environment binding pressure remains decision-relevant;
- NASA traceability/V&V only if exact target/criterion/evidence binding remains decision-relevant.

Candidate studies:
- Anthropic AI-native SDLC — exact artifact/version/role/gate/delegation bindings;
- multi-agent patterns — role/participation/handoff/delegation topology;
- context-memory-harness — context/source/Work binding and current-view scope.

External sources pressure semantics; they do not define the Foundation taxonomy.

## B6 — Synthesis / immediate-child decision

Determine whether Relational Binding is:

### Outcome A — bounded leaf

No stable child split survives; preserve a binding-signature model + cross-cutting family map.

### Outcome B — bounded parent with stable children

Promote only families with distinct protected questions/failure modes and stable cross-domain evidence.

### Outcome C — boundary correction

Revise Binding scope relative to Standing/Control/Transition without reopening parent unless necessary.

### Outcome D — upstream falsifier

Reopen minimum parent/ground adequacy research.

## B7 — Adversarial closure

Attack the result by trying to show:
- Binding is still a generic relation bucket;
- a two-endpoint edge is sufficient if qualifiers become attributes;
- n-ary/qualified relations are only modeling artifacts;
- one proposed child merely names a domain-specific relation family;
- provenance/reference/participation/dependency should be children but were wrongly collapsed;
- representation of a relation and actual relation were conflated;
- direction/inverse/role semantics are overstated;
- time/scope belong wholly to other grounds;
- the result smuggles graph/ontology architecture;
- a neighbouring composition child was absorbed.

Verification must distinguish same-model adversarial review from independent replication.

## Closure boundary

Return Relational Binding for user evaluation before activating any discovered grandchild or another composition child.