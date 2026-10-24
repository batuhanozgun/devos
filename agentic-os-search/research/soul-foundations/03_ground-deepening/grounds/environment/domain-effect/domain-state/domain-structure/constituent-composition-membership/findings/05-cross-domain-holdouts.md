# Constituent Composition Finding 05 — Cross-Domain Holdouts

**Status:** bounded child-pass finding  
**Date:** 2026-09-04

## Question

Does the refined `Constituent Composition` node survive materially different domains without forced fit, and do any holdouts expose a stable missing immediate child?

## Result

**The node survives the current holdouts. No recurrent third/internal child was forced.**

The stable cross-domain question is:

> Which actual constituents count as making up or participating in this selected structural whole at this scope/time, under the correct constituent relation semantics?

## Holdout 1 — integral physical assembly

Examples:
- vehicle / machine / instrument assemblies;
- components, subassemblies, replaceable parts.

Load-bearing issues:
- actual part inclusion;
- nested decomposition;
- structural cardinality when number of part instances matters;
- actual product versus BOM/design baseline.

Result:
- fits Constituent Composition;
- nesting/multiplicity do not require separate children;
- connection/placement remains Relational Organization.

## Holdout 2 — deployed software / services

Examples:
- deployed service backends;
- Pods/endpoints selected for a Service;
- installed software components.

Load-bearing issues:
- which live instances/components participate;
- present-but-not-ready versus absent;
- declared/SBOM/inventory versus actual deployment;
- rolling replacement through time.

Result:
- membership-set question remains distinct from endpoint health/Condition and network/topology;
- representation objects do not become actual composition by identity.

## Holdout 3 — system of systems / open systems

Constituent systems can:
- retain operational/managerial independence;
- participate in more than one SoS;
- participate temporarily for a coordinated purpose.

Result:
- integral parthood is too narrow as a universal relation;
- autonomous participation remains contained by Constituent Composition when scoped correctly;
- temporary/multiple membership is not a separate child.

## Holdout 4 — ecology / biological communities

Community evidence challenges assumptions that:
- membership requires direct interaction;
- boundaries are always crisp;
- species presence and abundance are the same analytical question.

Result:
- constituent membership can be separated from relational interaction/topology;
- boundary/scale remains reference-relative;
- abundance/quantitative characteristics do not force a Structure-local child under the project semantics.

## Holdout 5 — mixtures / materials

Chemical/material systems expose:
- constituents/components;
- continuous amount/fraction descriptions;
- phases/material composition.

Result:
- constituent identity remains meaningful;
- fraction/concentration vocabulary forces careful Condition boundary rather than a new Structure child;
- mixture relation semantics are another reason not to reduce all constituency to strict parthood.

## Holdout 6 — organizations / institutions

Organizational structures expose:
- membership/affiliation;
- role/post distinctions;
- membership duration;
- group persistence through membership change.

Result:
- membership fits the constituent question;
- Actor role/authority is not absorbed;
- time and identity remain cross-cutting.

## Holdout 7 — supply / market networks

Network models distinguish:
- participating firms/nodes;
- transaction/flow links and topology.

A selected network boundary may itself be inferred from relational evidence, but the recovery questions remain separable:
- who is included in this selected network?
- how are included firms connected?

Result:
- no merge into Relational Organization is forced.

## Holdout 8 — scientific setup / specimen

Experiments can depend on:
- specimen/sample constituents;
- apparatus/components in the selected experimental system;
- materials/reagents;
- setup documentation and configuration records.

Result:
- actual inclusion is separable from documentation;
- whether an instrument is target-system constituent or Work Condition depends on selected reference/focal Work, reinforcing cross-ground role switching rather than a new child.

## Holdout 9 — hybrid cyber-physical / socio-technical system

SEBoK's heterogeneous system-element frame allows hardware, software, data, humans, processes, facilities, materials and natural entities to participate in one system description.

Result:
- object-type taxonomy does not generalize as immediate children;
- relation semantics and scope are more important than physical/digital/human type branches.

## Cross-domain judgment

The strongest recurring internal needs are dimensions, not child regions:
- correct constituent relation semantics;
- current inclusion at selected scope/time;
- nesting/granularity;
- structural cardinality where load-bearing;
- identity/continuity boundary;
- actual-versus-represented composition.

None currently supports a separate recursive research program strongly enough to defeat the leaf candidate.

## Falsifier judgment

- F17 cross-domain breakage → **rejected**.
- F18 parent reopen → **rejected**; no third Domain Structure region and no Composition/Relational-Organization collapse was forced.
