# Domain Structure Finding 04 — Third-Child and Cross-Cutting Audit

**Status:** bounded adversarial finding  
**Date:** 2026-09-03

## Purpose

Try to break the two-child candidate:

```text
Domain Structure
    ├─ Constituent Composition / Membership
    └─ Relational Organization / Topology
```

by promoting a recurrent third Structure-local region.

## Candidate A — Spatial Arrangement / Containment

**Not promoted.**

Spatial organization is decision-critical in physical, geographic, biological and experimental domains, but it is not universal and behaves as a family of structural relations.

OGC GeoSPARQL formalizes multiple topological spatial relations—equality, disconnection, external connection, overlap and proper-part variants. This demonstrates the richness of spatial structure but not a separate universal project problem.

Project treatment:
- spatial containment/placement/contact/overlap → `Relational Organization / Topology` when arrangement is the protected question;
- part-of/nested membership → `Constituent Composition / Membership` when constitution of the whole is the protected question.

The same physical relation can support both readings in some domains; branch membership is analytical, not exclusive ontology.

**F3:** rejected as universal child.

## Candidate B — Hierarchy / Nesting versus Network / Topology

**Not promoted as separate children.**

NIST SP 800-160v1r1 explicitly states that its hierarchical model is general but not all systems—networks in particular—are hierarchical, and that non-hierarchical systems require representations of relations among constituent elements. The same source also allows a system element to itself be a system, yielding recursive nesting.

Therefore hierarchy/nesting and network/non-hierarchical topology are different structural forms:
- hierarchical/nested composition may exercise both children;
- network structure often stresses relational organization;
- neither form is universally required.

**F4:** rejected.

## Candidate C — Interfaces / Boundaries / Couplings

**Not promoted as a universal child.**

An interface is structurally load-bearing when it identifies a realized connection/boundary through which constituents or systems meet. That fits Relational Organization.

But the same vocabulary can shift role:
- exchange/interaction across interface → Dynamics;
- availability/health/capacity of interface → Condition;
- interface specification/architecture contract → Information/architecture representation;
- selected system/scope boundary → cross-cutting reference frame.

`Coupling` can likewise refer to extant connection, interaction strength, causal dependence or design property. A dedicated child would collapse multiple roles.

**F5:** rejected.

## Candidate D — Identity / Continuity

**Not promoted.**

Snapshot membership requires constituent identity, but persistence through replacement/change is inherently through-time. The 2026 SEP `Identity Over Time` revision again frames the problem as whether one and the same object persists through change and distinguishes identity-preserving from identity-ending changes.

Identity therefore:
- supports Composition membership judgments;
- can affect whether a structural change preserves the same whole;
- crosses Condition bearer identity;
- crosses State into Dynamics.

**F7:** rejected as Structure-local child; retained as explicit cross-cutting prerequisite/reopen trigger.

## Candidate E — Constraints / Invariants

**Not promoted.**

Constraints can limit:
- which constituents may participate;
- which structural relations are admissible;
- which Conditions may hold;
- which transitions are possible.

The constraint itself is not generally identical to the current realized structure that satisfies or violates it. A currently realized structural restriction can be described within the relevant child, while the rule/invariant remains cross-cutting.

**F8:** rejected.

## Candidate F — Multi-scale / Level / Granularity

**Not promoted.**

Nested systems and biological organization make scale indispensable, but scale determines reference/scope and can recurse within both children:
- membership/part-whole at one level;
- relations among constituents at the same or another level.

NIST system recursion and biological multi-level structure both support explicit level handling without establishing a separate universal structural child.

**F9:** rejected.

## Candidate G — Physical / Digital / Social / Institutional types

**Not promoted.**

Type branches repeatedly reproduce the same two structural questions. CPS material is especially useful as a counterexample because one system can combine logical, physical, transducing and human components while still requiring composition and interaction/relationship characterization.

**F10:** rejected.

## Candidate H — Structural Integrity / Unity of the Whole

**Not promoted.**

Whether the selected constituents and relations still constitute the relevant whole depends on:
- composition/membership;
- relational organization;
- cross-cutting identity/boundary criteria.

No independent recovery question remains after those are made explicit.

## Audit result

No third universal immediate Structure child survives current testing.

The two surviving children are not claimed to be mutually exclusive fact buckets. They are the smallest current split that preserves independently recurring structural failure/recovery questions without turning the research tree into a relation taxonomy or domain ontology.
