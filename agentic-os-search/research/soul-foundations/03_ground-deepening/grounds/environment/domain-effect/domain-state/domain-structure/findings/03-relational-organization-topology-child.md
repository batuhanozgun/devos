# Domain Structure Finding 03 — Relational Organization / Topology

**Status:** bounded child-promotion finding  
**Date:** 2026-09-03

## Question

Does realized structural organization among the relevant constituents deserve a distinct immediate child from constituent composition/membership?

## Result

**Yes. `Relational Organization / Topology` passes the immediate-child test.**

Primary question:

> **How are the relevant constituents actually structurally related, connected, arranged, contained or interfaced at the selected scope/time?**

## What belongs here when material

- realized connections/dependencies/linkages;
- network topology;
- adjacency and routing-relevant structural relations;
- realized internal/external interfaces as structural relations;
- placement/arrangement/geometry when structurally load-bearing;
- spatial containment/contact/overlap when the protected question is arrangement rather than part-membership;
- organizational/market/supply-network relation structure;
- coupling relation as a structural fact when it describes an extant linkage rather than the interaction event/strength dynamics itself.

## Distinct failure surface

Examples:
- the correct deployed services exist, but a dependency points to the wrong service;
- the correct machine components are installed, but two components are connected/positioned incorrectly;
- the correct suppliers participate, but routing/flow links are wrong;
- the correct market venues exist, but interconnection/routing structure differs from the assumed structure;
- the correct species are present, but realized interaction-network topology differs;
- the correct institutional units exist, but the structurally relevant relation among them is wrong.

Recovery begins by reconstructing **how the relevant constituents are organized**, not by asking whether the constituent set itself is complete.

## External discrimination

- Current SEBoK definitions explicitly include relationships/connections within Structure.
- NIST SP 800-160v1r1 warns that not all systems are hierarchical and that non-hierarchical systems need models reflecting relations among constituent elements; it also treats interfaces with external/interoperating systems as explicit relations.
- Supply-chain research represents organizations and links/flows separately.
- Market-structure material emphasizes venues, fragmentation, routing and interconnection.
- Ecological-network work distinguishes species composition from interaction-network organization.
- OGC GeoSPARQL demonstrates that spatial/topological structure contains a rich family of relations such as disconnected, connected, overlap, within and contains.

No source is treated as defining the project tree. Together they falsify the idea that composition/membership alone exhausts Structure.

## Why this is not merely a graph `edge` primitive

The branch is promoted because wrong organization produces a recurrent and independently recoverable real-world failure even when the constituent set is correct. A graph is only one possible representation of that structure.

The relation family is semantic and open-ended: dependency, connection, containment, position, interface, routing and institutional relation can all be structurally relevant without sharing one data-model encoding.

## Dynamics boundary

Keep separate:

```text
realized structural relation / interface
≠ event of interaction/exchange through that relation
≠ trajectory/change of that relation over time
```

For example, `A is connected to B` can be Structure; the packet flow, shipment, collision, conversation or causal interaction across that connection is Dynamics when the unfolding is the protected question.

## Condition boundary

A relational fact can instead be Condition/Status if its semantic role is a current standing/property rather than structural organization. Relation arity does not decide branch ownership.

## Falsifier judgment

- **F2 split of membership and topology:** supported.
- **F3 spatial arrangement as separate child:** weakened/rejected; spatial relations fit here when structurally material.
- **F5 interfaces/boundaries/couplings as missing child:** rejected as universal child; structurally realized interfaces fit here, with scope boundary/cross-ground qualifications.
