# Records — Current Mechanism Landscape Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `MECHANISM-PATTERN-LANDSCAPE.md` and `MECHANISM-PATTERN-COUNTERCHECK.md`.

## Current bounded result

No reviewed mechanism pattern is a complete Records answer by label alone.

Different patterns naturally emphasize different capabilities, such as:

- mutable current state;
- system-time history;
- typed event/change history;
- representation/version recovery;
- content/snapshot lineage;
- preservation-oriented rebuildability;
- heterogeneous relation traversal;
- discovery/ranking/filtering.

A mechanism should be judged as a **partial satisfier of an explicit Records requirement profile**.

## Native semantics are not technology ceilings

`External/companion concern` means `not guaranteed by the pattern label itself`, not `the technology can never do it` or `another product is required`.

A relational store can also hold events/provenance; a graph can represent history; an object store can carry rich metadata; Git can be hardened; a search index can be retained as a record. Those additional semantics and controls must be explicit and verified rather than inferred from the product/category name.

## Pattern families are lenses, not mutually exclusive product classes

One concrete system can instantiate several patterns at once. Conversely, several physical systems can jointly implement one logical Records role.

Semantic role separation does not imply microservices or several databases.

## Important anti-collapse rules

- MVCC/version internals ≠ durable Records history by default;
- `temporal` ≠ effective-time/bitemporal semantics automatically;
- event history ≠ complete provenance automatically;
- object version ≠ business/current standing;
- immutable/content-addressed/WORM ≠ authenticity, truth or complete compliance;
- graph structure ≠ provenance/authority merely by being a graph;
- search-index version ≠ source-resource version;
- preservation layout ≠ complete Records system.

These are narrow default/native-semantic statements, not hard product limits.

## Hybrid/composition

Composition is often rational because obligations are heterogeneous, but hybrid is not universally required or automatically better.

Composition introduces its own failure surfaces:

- stale views;
- identifier/version mismatch;
- conflicting editable duplicates;
- inconsistent retention/deletion;
- incomplete dependency transfer;
- unclear standing responsibility.

A single platform may internally compose the required roles and still satisfy the profile.

## Selection order

Use:

`context/appraisal → Records requirement profile → observable failures/acceptance conditions → mechanism comparison → concrete technology/configuration`.

The reverse order is storage-first design.

## Boundary

Replication, disaster recovery, distributed consistency, encryption/key lifecycle, deletion guarantees and product-specific configuration are critical implementation-assurance questions. They do not add a new first-order Records semantic dimension by themselves.

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.