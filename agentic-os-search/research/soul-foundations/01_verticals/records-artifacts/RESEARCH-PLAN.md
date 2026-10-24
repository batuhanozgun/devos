# Records / Artifacts — Foundational Research Pass

**Status:** completed at user-return gate  
**Date opened:** 2026-09-01  
**Return condition met:** 2026-09-01

## Research question

What is a record, independently of a particular environment, storage medium, software architecture, or agent system; and what must be preserved and managed so information can be found, interpreted, trusted, changed appropriately, and reused later?

## Why this is not a storage-technology survey

A database row, file, Git object, event, document, archive item, knowledge-graph node, vector embedding, or prompt-memory entry may instantiate or represent parts of the problem. None is assumed to define the natural unit of analysis.

The pass therefore begins with concepts/properties and only later uses technologies as comparative evidence.

## Research lenses

1. **Archival science / records management** — recordhood, context, provenance, original order, authenticity, reliability, integrity, usability, lifecycle/continuum.
2. **Information/data management** — data/information distinctions, metadata, identifiers, schemas, data quality, governance.
3. **Database / temporal / event models** — state versus history, transactions, immutability, bitemporal time, event logs, derived state.
4. **Provenance / reproducibility** — entities, activities, derivation, lineage, source and method trace.
5. **Digital preservation** — fixity, representation information, format/technology change, authenticity over long horizons.
6. **Information retrieval / knowledge organisation** — organisation, indexing, search, discovery, entity/representation distinctions, retrieval failure.
7. **Version/configuration management** — identity across change, version versus revision, branching, supersession, correction.

These are lenses, not presumed components of SOUL.

## Core probes

- What distinguishes data, information, document, record, artifact, state, event, fact, claim, evidence, knowledge, memory, and derived view?
- Is recordhood intrinsic to an object, or relational/contextual (e.g. created/received and kept as evidence/information of activity)?
- What properties must survive for a persistent object to remain intelligible and trustworthy later?
- How do identity and meaning survive copying, migration, transformation, aggregation, summarisation, or format change?
- Which changes should mutate an object, create a new version, supersede a prior object, append an event, or preserve both?
- What temporal semantics matter: event time, transaction/recording time, validity interval, observation freshness?
- What does provenance need to capture, and what does provenance not establish by itself?
- How should authoritative source, derived representation, index, cache, summary, and search result differ epistemically?
- How do organisation and retrieval interact with preservation? Can information be preserved yet operationally lost because it cannot be found or re-contextualised?
- Which failure modes recur across disciplines despite different mechanisms?

## Evidence strategy

Prefer authoritative standards, public-sector archival/records guidance, standards bodies, primary specifications, and foundational technical literature. Use secondary sources for orientation or contested terminology, not as sole support for load-bearing claims.

For each material claim, distinguish:

- direct source observation,
- cross-source synthesis,
- inference/hypothesis,
- unresolved disagreement or scope limitation.

## Counter-frame / falsification checks

The completed pass actively tested at least these alternatives:

- `record = stored information` may be too broad;
- `record = immutable historical event` may be too narrow;
- `record = document` may fail for structured/event/state records;
- `all persistent information needs record-level governance` may be false;
- archival/records-management concepts may overfit accountability/institutional evidence and not generalise to all operational information;
- database/event-sourcing concepts may preserve machine state while losing semantic/contextual record properties;
- search/retrieval success may not imply authority, truth, freshness, or completeness;
- `Record` may not be one universally fixed object class: contextual/managed-status and emergent-recordness counter-frames remain live.

## Vertical-isolation rule

When a question materially requires Work or Actors (e.g. 'who is authorised to alter this record?' or 'which work produced it?'), record the relation and the minimum fact needed to understand the Records side, but defer the other vertical's model.

Material relations discovered during the pass are persisted in `DEFERRED-RELATIONS.md`.

## Return condition

The foundational pass was ready to return to the user when:

1. major competing definitions/frames of `record` had been compared rather than one selected by convenience;
2. load-bearing distinctions among the core information categories were explicit enough to guide the next records research;
3. persistent-information properties and lifecycle/failure surfaces were supported across multiple independent disciplines;
4. counter-evidence and scope limits were explicit;
5. source trace was persisted in the repository;
6. unresolved questions were concrete and prioritised by information value;
7. no storage technology or SOUL architecture had been silently selected.

**Verdict:** MET. See `synthesis/RETURN-CONDITION-REVIEW.md`.

Meeting this return condition does **not** mean the entire Records / Artifacts vertical is complete. It means the foundational pass has produced enough ground to decide its next internal research step. Per the parent guardrail, the adjoining deepening pass is not silently opened in the same turn.