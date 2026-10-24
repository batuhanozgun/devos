# Domain State Finding 07 — Cross-Domain Holdouts

**Status:** active-node holdout finding  
**Date:** 2026-09-02

## Purpose

Challenge the provisional two-child map across materially different domains rather than illustrating it with repeated software examples.

Candidate under attack:

```text
Domain State
    ├─ Domain Structure / Composition
    └─ Domain Condition / Status
```

---

## H1 — SOUL / Development OS acting on a deployed software product

### Structure / Composition
- which services/processes/containers are actually present;
- actual deployed versions/components when version identifies a realized component;
- actual dependency/network/topology relations;
- which endpoints/resources are actually attached.

### Condition / Status
- current health/readiness;
- current runtime property/settings/value where it is a realized domain condition;
- current load/resource/availability condition in the product-domain role;
- current service/application status.

Failure separation:
- correct health readings over the wrong topology do not establish correct Structure;
- correct deployed topology does not establish healthy/correct current Condition.

Boundary:
- repository/configuration manifests remain Information/Records unless the realized deployed product itself is the focal Domain role.
- Kubernetes desired `spec` and reported `status` are not actual runtime reality by identity.

**Result:** two-child split survives.

---

## H2 — Manufacturing / physical asset

NIST asset-condition-management work separately uses hierarchical component/system relationships and current/future health state.

### Structure
- installed machine/component composition;
- assembly/hierarchical relationships;
- realized interfaces/placement.

### Condition
- wear/health;
- vibration/temperature/operating condition;
- current diagnostic status.

A machine can have the correct installed structure and poor health, or healthy observed components can be organized/installed incorrectly.

**Result:** two-child split survives strongly.

---

## H3 — Ecological system

EPA ecological-condition framing describes ecosystems through living/nonliving constituents, characteristics and the interactions/processes connecting them.

For a State-only snapshot:

### Structure
- which species/physical constituents are present;
- composition/distribution and load-bearing relations where material.

### Condition
- current physical/chemical/biological characteristics;
- current population/resource/quality levels.

Ecological processes/evolution belong to the Dynamics sibling, not this State pass.

**Result:** split survives, with strong warning that domain vocabularies often bundle composition, condition and process under one term such as `ecological condition`.

---

## H4 — Social / institutional domain

Current social-institution literature treats institutions as structures of positions/roles/norms/relationships and recognizes current status functions/standing that depend on institutional rules and collective practices.

### Structure
- realized positions/roles/organizational relations in the selected institutional-domain role;
- current composition of a functioning institution where materially at issue.

### Condition
- current standing/status/validity of the institution or relevant domain fact;
- current realized state of compliance, authorization or institutional condition **only in the Domain role**.

Boundary:
- Actor identity/authority remains Actors semantics;
- rule texts and assertions remain Information semantics;
- the institutional reality may be constituted through those practices without being identical to one representation.

**Result:** split survives without forcing institutional ontology into Environment.

---

## H5 — Financial/market domain

SEC material distinguishes market **structure** questions such as fragmentation/venues from current market-quality/condition measures such as liquidity, spreads, depth and volatility.

At a selected snapshot:

### Structure
- venues/participants/market organization and relevant routing/interconnection structure.

### Condition
- current price/liquidity/depth/volatility or other material market condition.

Market evolution/order-flow mechanisms belong to Dynamics.

**Result:** two-child split survives.

---

## H6 — Scientific specimen / experimental system

### Structure
- specimen/system composition;
- arrangement/geometry/interfaces where material.

### Condition
- current physical/chemical/biological properties and statuses.

A specimen can retain composition while condition changes; conversely nominal property values do not establish that the correct specimen/composition is being examined.

Observed measurements remain Information-side representations of actual condition.

**Result:** split survives.

---

## H7 — Hybrid physical/digital system / digital twin target

National Academies digital-twin work explicitly treats virtual information constructs as models of the structure/context/behavior of a real counterpart.

### Structure
- realized counterpart composition/organization/interconnections.

### Condition
- realized current quantities/properties/health.

Virtual twin structure/state/parameters are representations and may have fit-for-purpose fidelity limits.

**Result:** split survives and actual-vs-model boundary remains necessary.

---

## H8 — Identity-through-replacement case

Example pattern: a system remains the protected `same` system while components are replaced.

This stresses Identity/Continuity but does not create a third State child:
- replacement changes Structure/Composition;
- current Condition can remain nominal;
- whether continuity is preserved is required to compare states and later trajectories.

Because this problem necessarily spans before/after comparison and domain-specific identity criteria, it remains cross-cutting across State and Dynamics.

**Result:** Identity remains explicit but unpromoted.

---

## H9 — Snapshot insufficient without history

Example pattern: two domains look identical at the selected current variables but differ in relevant future behavior because of hidden history/path dependence.

This does not force a new State child. It exposes one of two issues:
- the selected state representation was insufficient and omitted a load-bearing current fact/history-carried variable; or
- path dependence is genuinely Dynamics-local.

The actual-domain research tree therefore should not manufacture a `History` State child merely to make a selected representation Markov-sufficient.

**Result:** granularity/sufficiency remains cross-cutting to representation and Dynamics.

---

# Holdout judgment

Across the tested domains, no recurrent third State-local immediate region is forced beyond:

```text
Domain Structure / Composition
Domain Condition / Status
```

Late holdouts mainly clarify boundaries and cross-cutting dimensions rather than changing child count.

This is bounded evidence, not proof of universal completeness.
