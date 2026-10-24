# Domain Structure Finding 06 — Boundary and Anti-Collapse Rules

**Status:** bounded boundary finding  
**Date:** 2026-09-03

## Purpose

Test whether deeper Structure research causes leakage into Condition, Dynamics, Information, Actors or architecture/modeling.

## 1. Structure ↔ Condition / Status

The parent distinction survives.

```text
wrong/missing constituent or wrong structural organization
≠
present constituent/whole with wrong current condition/status
```

Decision rule:
- structural membership/organization is at issue → Structure;
- health, availability, quantitative/qualitative property, mode or standing is at issue → Condition.

A relation can be Condition if it expresses current standing rather than organization. Vocabulary/graph arity is not decisive.

## 2. Structure ↔ Dynamics

Keep:

```text
current realized structural relation
≠
interaction/change/process unfolding through time
```

Examples:
- connection exists → Structure;
- traffic/flow/exchange occurs through connection → Dynamics;
- connection is created/removed → Dynamics event plus before/after Structure snapshots.

## 3. Actual Structure ↔ Information / representation

The boundary strengthens rather than weakens.

NASA configuration-management guidance requires configuration audits that compare actual work product configuration with documented configuration. That operational need directly falsifies identity between actual structure and its baseline/documentation.

Likewise:
- Kubernetes Service/EndpointSlice objects describe/control endpoint membership and access but can abstract changing runtime members;
- BOMs, architecture diagrams, topology maps, supply-chain ontologies and digital models represent structure but do not establish the realized structure by identity.

Keep:

```text
actual Domain Structure
≠ architecture/design structure
≠ inventory/BOM/configuration baseline
≠ graph/topology cache/model
≠ digital twin representation
≠ Record asserting membership or connection
```

The representation can be correct, wrong, stale, partial or prospective.

## 4. Structure ↔ Actors

Institutional and socio-technical cases create real overlap pressure.

A role/organizational relation can be Domain Structure when the protected question is the realized institutional organization. But:
- who the Actor is;
- what authority/capability/responsibility the Actor has;
- whether an action is authorized;
remain Actors semantics unless the relation itself is being studied as Domain structure.

Do not create a separate `social structure` child merely to absorb Actor semantics.

## 5. Structure ↔ Work

Work can inspect, construct, reconfigure or repair Domain Structure. The task/workflow used to do so is not part of the structure by identity.

```text
Work that changes structure ≠ resulting structure
```

## 6. Structure ↔ architecture / ontology / schema

This hierarchy is not a design prescription.

Do not infer:
- two database tables;
- graph nodes and edges as mandatory representation;
- two SOUL modules;
- a CMDB schema;
- an ontology class hierarchy;
- event-sourcing design;
- architecture components.

The research hierarchy exists because it protects different failure/recovery questions.

## 7. Boundary / scope itself

A selected domain boundary determines which membership and external/interface relations matter. Boundary selection is cross-cutting reference framing, not a third Structure child.

A boundary can also be a realized structural feature in some physical/institutional domain. In that role it belongs under the relevant child, while the analyst's choice of scope remains distinct.

## 8. Causality

Structure can causally affect Condition and Dynamics, but a structural difference does not by itself establish causal attribution.

```text
wrong topology observed
≠ proof that topology caused the failure
```

Root-cause claims require additional causal evidence.

## Boundary verdict

No tested leakage requires reopening the Domain State parent. The deeper two-child Structure split is compatible with the existing Structure-versus-Condition and State-versus-Dynamics distinctions, provided semantic ownership and actual-versus-represented boundaries remain explicit.

**F11:** rejected.  
**F12:** rejected with institutional/Actor guardrail.  
**F13:** rejected; no tested domain forces collapse or type-based split.  
**F14:** not triggered; no missing co-equal Domain State region exposed by this pass.
