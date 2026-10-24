# Domain Structure Finding 05 — Cross-Domain Holdouts

**Status:** bounded cross-domain falsification finding  
**Date:** 2026-09-03

## Candidate under attack

```text
Domain Structure
    ├─ Constituent Composition / Membership
    └─ Relational Organization / Topology
```

The purpose is not to illustrate a chosen answer. Each case asks whether the split forces material facts, creates a stable third child, or collapses into another ground.

---

## H1 — Deployed software / service system

Kubernetes provides a useful realized-system counterframe:
- the actual backend Pod set can change over time;
- a Service abstracts a logical set of endpoints and access policy;
- endpoint membership and routing/access relations are not the same question;
- health/readiness remains a separate Condition issue.

Mapping:
- Composition / Membership → which services/pods/endpoints actually participate at the selected realized scope;
- Relational Organization → dependencies, service-to-backend relations, routing/network attachments.

Failure separation survives.

Representation warning: Service/EndpointSlice API objects are representations/control surfaces, not actual runtime reality by identity.

**Result:** survives strongly.

---

## H2 — Physical assembly / manufacturing product

Manufacturing sources model product/subassembly/component nesting via BOM/assembly structures, while engineering systems material separately treats interfaces and interconnections.

Mapping:
- Composition → what parts/subassemblies are installed and part of what;
- Relational Organization → how those parts are connected, interfaced, placed or assembled.

The correct component set can be assembled incorrectly; correct connections among installed items do not prove the correct item set.

**Result:** survives strongly.

---

## H3 — Infrastructure / facility / system-of-systems

NIST system material explicitly distinguishes hierarchical constituent decomposition from non-hierarchical networks and external/interoperating-system relations.

Mapping:
- Composition → constituent systems/facilities/elements in the selected system-of-systems;
- Relational Organization → interdependencies, interfaces and network relations.

A hierarchy-only child model would fail on networked infrastructure; a topology-only model would under-protect constituent-system membership/nesting.

**Result:** survives.

---

## H4 — Biological / ecological system

Current biological and ecological sources describe structure through arrangements of components/species and their interactions/networks across levels.

A 2025 Nature Reviews Biodiversity perspective explicitly distinguishes node aggregation from link information in ecological interaction networks; 2026 ecological-network work discusses topology and interaction strength as separable aspects of network structure.

Mapping:
- Composition → which species/components/aggregates constitute the selected community/system;
- Relational Organization → interaction-network structure, physical connections and arrangement.

Multi-level biological organization stresses granularity but does not force a third child.

**Result:** survives.

---

## H5 — Social / institutional organization

The current SEP Social Institutions entry distinguishes institutions from simpler roles/rules and discusses institutions as structured unitary entities or systems of organizations.

Mapping:
- Composition → which organizational units/roles/groups participate in the selected institutional structure;
- Relational Organization → structurally realized relations among those units/positions.

Boundary pressure:
- authority, capability, responsibility and agency semantics can be Actor-owned even when the institutional structure depends on role relations;
- rules/assertions/documents remain Information when they represent/constitute the institution but are not the realized structural relation by identity.

No stable institutional-only third Structure child appears.

**Result:** survives with strong Actors/Information boundary warning.

---

## H6 — Market / supply network

SEC market-structure material discusses fragmented trading across many venues and interconnection/routing among them. NIST-linked supply-chain ontology work represents participating organizations as network nodes and material/information flows as links.

Mapping:
- Composition → which venues/suppliers/participants are in the selected market/supply structure;
- Relational Organization → routing, interconnections, supply links and topology.

Flow occurrence itself can be Dynamics; a standing route/link can be Structure.

**Result:** survives.

---

## H7 — Scientific specimen / experimental setup

A scientific setup can have:
- the right devices/specimen/components but wrong geometry/connection;
- the right geometry among present components but the wrong component/specimen.

Mapping:
- Composition → actual apparatus/specimen/component membership;
- Relational Organization → geometry, placement, optical/fluid/electrical/mechanical connections.

Measurement records and setup schematics are representations, not realized setup by identity.

**Result:** survives.

---

## H8 — Hybrid cyber-physical system

NIST CPS/IoT work characterizes these systems through interacting logical, physical, transducing and human components and separately uses composition and boundaries among its analysis concerns.

Type diversity therefore occurs **inside** the structure rather than requiring type-based universal children.

Mapping:
- Composition → which heterogeneous components participate;
- Relational Organization → their logical/physical/human interactions and linkages insofar as these are structural relations.

**Result:** survives; type-based hierarchy rejected.

---

## H9 — Replacement / continuity case

A component replacement changes concrete membership while the protected whole may or may not remain the same system.

Mapping:
- before/after constituent sets → Composition;
- unchanged or changed connections → Relational Organization;
- whether the whole is the same entity through replacement → Identity/Continuity cross-cutting State/Dynamics.

**Result:** split survives; Identity still not Structure-local child.

---

## H10 — Role-switching case

The same concrete relation can participate differently by protected question:
- `A is structurally connected to B` → Relational Organization;
- `A sends resource to B during interval t` → Dynamics;
- `A is authorized to direct B` → Actor/institutional authority semantics unless Domain-structural role is the protected question;
- `diagram says A connects to B` → Information representation.

This semantic role-switching is expected and does not invalidate Structure.

**Result:** boundary survives if ownership remains problem-role based rather than object-type based.

---

# Holdout judgment

Across materially different cases, the split repeatedly changes failure/recovery behavior and no recurrent third Structure-local region is forced.

The strongest current Structure-specific decomposition remains:

```text
Domain Structure
    ├─ Constituent Composition / Membership
    └─ Relational Organization / Topology
```

This is bounded evidence, not proof of universal completeness.
