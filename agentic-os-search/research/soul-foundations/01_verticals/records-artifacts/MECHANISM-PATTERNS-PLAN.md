# Records Mechanism Pattern Landscape — Research Plan

**Status:** active research plan; continued automatically within authorised Records vertical  
**Date opened:** 2026-09-01

## Direction

The first six Records passes now provide context-specific requirement derivation. This makes it possible to study storage/history/organisation/retrieval mechanisms without letting a familiar technology define the Records semantics.

## Purpose

Compare major **mechanism/pattern families** against the Records requirements and failure modes established by prior passes.

The goal is not to choose a SOUL architecture or winner. It is to determine:

- what each pattern makes easy/natural;
- what it leaves external or implicit;
- which failure modes it introduces;
- which requirement profiles it fits poorly or well;
- what combinations/hybrids are structurally common because no single pattern covers all obligations.

## Pattern families to examine

At minimum:

1. mutable current-state stores;
2. multiversion / temporal current-state stores;
3. append-only event/change-history models;
4. versioned immutable object stores;
5. content-addressed snapshot/DAG models;
6. archival/versioned object-layout/package patterns;
7. graph/relationship representations;
8. derived search/index/projection structures;
9. hybrid/source-plus-derived patterns.

## Questions

For each pattern:

- natural identity model;
- current-state model;
- historical reconstruction model;
- correction/supersession/retraction semantics available or absent;
- provenance/derivation support;
- integrity/fixity support;
- aggregation/relation support;
- retrieval modes naturally supported;
- transfer/portability/preservation characteristics;
- deletion/disposition semantics;
- derived-view/canonical-source failure risks;
- hidden assumptions about authority/currentness;
- whether history is semantic history or merely implementation/concurrency history.

## Counter-frames

Actively challenge:

- immutable = trustworthy records;
- versioning = sufficient history;
- event sourcing = complete provenance;
- temporal DB = bitemporal recordkeeping;
- graph = knowledge/record semantics solved;
- object storage versioning = archival preservation;
- Git = universal durable record store;
- search index = acceptable source of truth;
- one mechanism should satisfy all Records profiles;
- hybrid = automatically better.

## Scope exclusions

Do not:

- select SOUL's database/storage/search stack;
- benchmark vendor products;
- design deployment topology;
- choose specific cloud provider;
- design Work/Actors/governance;
- turn this into generic distributed-systems research beyond Records-relevant semantics.

## Operational return condition

Continue until:

1. major pattern families are source-grounded and compared;
2. each pattern's native semantics vs external obligations are explicit;
3. at least several cross-pattern scenarios use the requirement-profile method;
4. important mechanism myths are adversarially tested;
5. hybrid necessity is assessed rather than assumed;
6. no implementation winner is selected;
7. source ledger, synthesis and counter-check are persisted;
8. the next Records frontier is re-derived from findings.

This pass does not complete the Records vertical.