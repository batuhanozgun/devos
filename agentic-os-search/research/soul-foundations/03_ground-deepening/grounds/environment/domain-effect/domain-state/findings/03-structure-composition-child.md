# Domain State Finding 03 — Domain Structure / Composition

**Status:** active-node child candidate finding  
**Date:** 2026-09-02

## Question

Does realized structure/composition deserve promotion to an immediate Domain-State child, or can it remain an undifferentiated aspect of State?

## Current finding

**Yes, `Domain Structure / Composition` currently passes the child-promotion test.**

Primary question:

> **What materially relevant constituents are actually present, and how are they actually composed, arranged, connected or otherwise structurally related at the selected scope/time?**

This is the realized domain side, not a design diagram, inventory Record or desired architecture.

## What belongs here when material

- constituent/member presence;
- part–whole composition;
- realized connections/interfaces;
- topology/network organization;
- containment/placement/arrangement;
- structural relations that make the selected domain whole/situation materially different;
- actual installed/deployed/assembled composition.

## Distinct failure surface

Structural failure can occur while condition/status facts are otherwise correct:
- a service is healthy but connected to the wrong dependency;
- all components are individually operational but one required component is absent;
- current measurements are correct for the observed items but the analysis omitted a load-bearing constituent;
- an asset contains the wrong installed component even if measured operating values are nominal;
- an institutional arrangement contains the wrong or missing role/relationship even if individual actors' current statuses are correctly represented.

The protected error is therefore not merely `some property value is wrong`; it can be **the wrong set or organization of relata**.

## Why constituent presence and relations/topology stay together

A three-way child split—`Constituents`, `Relations/Topology`, `Properties/Status`—was tested.

Current evidence does not justify separating the first two at this level:
- systems definitions repeatedly characterize structure through **elements plus relationships**;
- a topology without its nodes/constituents and a constituent set without the relevant organizing relationships are incomplete versions of the same structural question;
- cross-domain reasoning commonly needs their combination to define the realized organization;
- splitting them primarily mirrors graph/data-model primitives rather than exposing a reliably different first-order project problem.

Thus:

```text
constituents + structural relations/topology → one Structure / Composition child
```

for the current level.

## External discrimination

Current SEBoK separately describes system structure as elements and relationships, while its state glossary emphasizes values of qualities/properties at a time. The exact SEBoK taxonomy is not adopted as project ontology, but the distinction exposes a recurrent problem separation.

Systems modeling and Work Domain Analysis also preserve decomposition/part–whole organization as a distinct analytical concern. Again, these are counterframes and discrimination evidence, not hierarchy-by-authority.

## Reality / representation boundary

Configuration-management baselines, architecture diagrams, inventories and digital models can describe structure, but they do not establish actual structure by identity.

The actual deployed/installed/constituted structure can diverge from:
- desired configuration;
- documented baseline;
- inventory;
- architecture model;
- cached/reported topology.

Therefore this child remains on the realized Domain side; provenance/currentness of structural representations is deferred to Information/composition.

## Child-promotion judgment

Current basis:
- distinct first-order question;
- distinct omission/error class;
- repeated cross-domain usefulness;
- repeated external structure/composition distinction;
- material later reasoning consequences when omitted.

**Provisional promotion: PASS**, subject to final omission/rival audit.
