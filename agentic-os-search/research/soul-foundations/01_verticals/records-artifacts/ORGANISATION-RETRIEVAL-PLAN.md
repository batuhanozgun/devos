# Organisation / Derived Views / Retrieval Semantics — Research Plan

**Status:** active approved research plan  
**Date opened:** 2026-09-01

## Direction re-check

This pass remains inside the Records / persistent-information vertical.

Four prior bounded passes established:

1. persistent-resource / recordhood and object boundaries;
2. resource/version/representation/derivation/aggregation distinctions;
3. minimum preservation closure rather than one universal metadata envelope;
4. typed change, standing and temporal semantics needed for reconstruction.

The next unresolved Records problem is reachability: persistence is insufficient if the intended resource/version/standing/context cannot later be found and reconstructed.

However, the pre-pass phrase `organisation + canonical/derived views + retrieval` contains three drift risks:

- treating all organisation as one hierarchy/taxonomy;
- treating `canonical` as an authority decision that Records can solve alone;
- jumping from retrieval requirements to search/vector/database architecture.

The pass therefore uses the narrower architecture-neutral frame below.

## Refined purpose

Determine the **organisation and retrieval semantics** required so a persistent-information system can reach the intended resource, version, standing and context later while keeping source-bearing resources distinguishable from derived access/discovery views.

The pass will not decide who/what has authority to designate a source as canonical/current. It will instead study what Records-side bindings and semantics must survive once such a source/version/standing exists.

## Organisation functions to keep separate unless evidence permits merging

1. **Context-preserving organisation** — provenance, archival bond, creator/function/activity context, aggregation, order and relations needed to interpret/reconstruct records.
2. **Descriptive / knowledge organisation** — labels, subjects, taxonomies, thesauri, classifications and other descriptive structures used to describe or navigate information.
3. **Access / retrieval organisation** — indexes, catalogues, search fields, semantic indexes, caches, projections and other structures optimised for reaching information.
4. **Source/standing binding** — the relation that lets a derived/access view identify the exact resource/version/standing from which it was produced or which it describes. This is not an authority assignment mechanism.

These are research functions, not proposed SOUL components.

## Core questions

1. Which organisation relations carry constitutive context/meaning, and which are merely access conveniences?
2. When can one resource legitimately participate in multiple organisations/taxonomies without creating multiple sources of truth?
3. What must a derived view/index/catalogue/summary/cache preserve about its source resource, version, standing and derivation?
4. What failure semantics arise when derived access structures are stale, incomplete, lossy, or independently editable?
5. Which materially different retrieval modes require different closure:
   - known-item lookup;
   - attribute/filter retrieval;
   - semantic/topical discovery;
   - exhaustive/high-recall retrieval;
   - current-standing retrieval;
   - historical/as-of retrieval;
   - system-known-as-of retrieval;
   - version/derivation/provenance traversal;
   - aggregation/case/thread reconstruction?
6. What does a retrieval hit prove, and what does it not prove about identity, relevance, currentness, authority/standing, completeness or truth?
7. What does a retrieval miss prove, and under what coverage/recall conditions can absence be inferred?
8. How should correction, supersession, retraction, removal or other standing changes propagate semantically to derived/access views without assuming synchronous implementation?
9. Which metadata/relations are preservation-critical for reachability versus only ranking/discovery enhancements?
10. Does `canonical vs derived` survive as the right frame, or should the result use a more precise source-bearing / derived-access / projection model?

## Research lenses

- archival organisation, provenance/original order, ICA Records in Contexts;
- knowledge organisation / SKOS and classification systems;
- information retrieval theory and evaluation (precision, recall, relevance, known-item vs discovery distinctions where supported);
- FAIR findability/accessibility and metadata↔resource binding;
- provenance / W3C PROV for derivation and source binding;
- temporal/version retrieval from prior temporal-data evidence;
- database/materialized-view and search-index behaviour only as concrete counterexamples for stale/derived views, not architecture recommendations;
- preservation/access models where dissemination/access representations differ from preserved information objects.

## Counter-frames / falsifiers

Actively challenge:

- one hierarchy/taxonomy should be the intrinsic organisation of all records;
- richer indexing always improves retrieval without epistemic cost;
- a search hit can stand in for the source record;
- a search miss implies absence;
- all derived views must update synchronously to be semantically safe;
- one `canonical` source relation is sufficient for all versions/standings/contexts;
- a cache/index/summary is always non-authoritative and can never become a record in its own right;
- semantic discovery and exhaustive retrieval have the same sufficiency criteria;
- preservation of source identity automatically preserves retrievability;
- graph/hierarchy/taxonomy are mutually exclusive organisation models.

## Scope exclusions

Do not select/design:

- search engine or ranking algorithm;
- embedding model/vector database;
- graph database;
- relational/document schema;
- cache topology or invalidation implementation;
- filesystem/Git/object-store architecture;
- concrete SOUL memory/retrieval architecture;
- Work/Actors/authority model;
- who may designate canonical/current/authoritative standing;
- evidence sufficiency or factual truth.

If a derived view itself becomes a new record/work output, preserve the Records-side observation and defer the Work/authority boundary where necessary.

## Evidence discipline

For each proposed distinction:

- identify the protected retrieval/reconstruction capability;
- identify failure if the distinction is absent;
- distinguish source observation from synthesis;
- test whether another organisation/retrieval relation can substitute;
- test stale/incomplete/duplicate/ambiguous cases;
- test current vs historical/versioned resources;
- preserve retrieval miss vs absence and hit vs authority/relevance boundaries.

## Operational return condition

Return to the user only when, sufficiently for this pass:

1. context-preserving, descriptive/knowledge, and access/retrieval organisation have been compared and their load-bearing boundaries tested;
2. source-bearing resources versus derived/access views have an evidence-supported architecture-neutral relationship model;
3. materially different retrieval modes have distinct sufficiency requirements where evidence supports them, rather than one generic `search` notion;
4. stale/incomplete/lossy/duplicate/independently-editable derived-view failure modes have been tested;
5. retrieval hit/miss epistemic limits are explicit;
6. change/standing propagation to derived views is semantically specified without prescribing synchronous infrastructure;
7. at least one adversarial pass challenges taxonomy lock-in, canonicality assumptions, retrieval completeness and architecture contamination;
8. source trace, bounded synthesis, counterexamples and residual questions are persisted;
9. the next Records direction is re-derived from the result rather than inherited from the pre-pass queue;
10. no search/storage/vector/graph/database or SOUL architecture has been selected.

Meeting this condition does not complete the Records vertical.