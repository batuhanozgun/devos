# Relational Organization Finding 05 — Cross-Domain Holdouts

**Status:** bounded finding  
**Date:** 2026-09-04

## Question

Does the refined `Relational Organization` node survive materially different domains without forcing a universal child split or collapsing neighbouring boundaries?

## Result

**Yes. The node survives the required holdouts. Relation semantics vary sharply, but the same first-order recovery question remains usable.**

## 1. Physical / mechanical assemblies

Typical structural organization facts:
- relative position/orientation;
- joints, mates and constraints;
- contact / concentric / tangent / aligned relations;
- fixed versus permitted relative degrees of freedom when treated as structural relation constraints.

Failure with correct composition:
- all required parts are present, but a component is misaligned, connected to the wrong mate or constrained incorrectly.

Result:
- spatial/constraint semantics fit Relational Organization;
- no separate spatial child required.

## 2. Deployed software / service systems

Typical organization facts:
- service dependency;
- endpoint connectivity;
- upstream/downstream relation;
- zone/region placement when structurally relevant to routing.

Failure with correct composition:
- all expected services are deployed, but Service A calls the wrong dependency or the realized dependency chain differs from assumption.

Boundary:
- latency/error/availability metrics → Condition when the metric/standing is protected;
- request flow/trace event → Dynamics when unfolding is protected;
- dependency map → representation/evidence.

## 3. Infrastructure / system-of-systems

Typical organization facts:
- one-way/bidirectional interface relations;
- interoperability links;
- external/interfacing system relations;
- hierarchy or non-hierarchical network form.

NIST explicitly warns that not all systems are hierarchical.

Result:
- hierarchy/network are forms of organization rather than mandatory child branches.

## 4. Spatial / geographic systems

Typical organization facts:
- within / contains;
- touches / crosses / overlaps / intersects;
- adjacency/separation;
- relative placement.

OGC GeoSPARQL demonstrates a rich spatial relation family.

Result:
- spatial semantics fit the node;
- their domain richness does not create a universal spatial sibling.

## 5. Ecology / biology

Typical organization facts:
- predator–prey / mutualistic / competitive interaction structure when treated as extant relation pattern;
- potential versus realized links;
- pairwise and higher-order relations;
- network backbone/periphery organization.

Failure with correct composition:
- the same species are present but interaction structure differs.

Boundary:
- interaction event/process and rewiring over time → Dynamics;
- interaction strength may be Condition when current value is protected.

Result:
- pairwise/higher-order and interaction-type distinctions remain relation forms, not immediate project children.

## 6. Supply / market networks

Typical organization facts:
- supplier/customer or transport arcs;
- venue interconnection;
- fragmentation, alternate routes and bottleneck structure;
- directed dependency chains.

Failure with correct composition:
- all firms/venues/facilities exist, but the realized links/routing structure differs.

Result:
- relational organization remains distinct from node membership and from material/order/trade flows.

## 7. Institutions / organizations

Typical organization facts:
- reporting relations;
- grouping/hierarchy;
- cross-unit coordination structure;
- formal/informal network position.

Boundary:
- authority, obligation, delegation, competence and permission semantics can require Actors analysis.

Result:
- institutional structure does not force an `authority relations` Structure child.

## 8. Scientific setup / specimen / experimental system

Typical organization facts:
- apparatus connection;
- channel/cable/tube/interface relation;
- relative placement/orientation;
- specimen-container/sensor arrangement where arrangement is materially structural.

Failure with correct composition:
- all instruments are present, but the connection or placement is wrong.

Result:
- fits Relational Organization without new child.

## 9. Hybrid cyber-physical / socio-technical systems

Typical organization facts combine:
- physical interfaces;
- software/data dependencies;
- human/system interfaces;
- spatial placement;
- cross-system relations.

NIST/NASA systems traditions explicitly accommodate heterogeneous system elements and interfaces.

Result:
- heterogeneous relation semantics coexist under one recovery question.

## Holdout conclusion

Across all holdouts:

```text
correct constituent set
+
wrong structurally material relation/arrangement
=
Relational Organization failure
```

No materially recurrent third Structure problem was forced, and no candidate immediate split reproduced robustly enough across domains.

## Falsifier impact

- F19 cross-domain breakage → **rejected**.
- F20 Domain Structure parent reopen → **rejected by holdouts**.
