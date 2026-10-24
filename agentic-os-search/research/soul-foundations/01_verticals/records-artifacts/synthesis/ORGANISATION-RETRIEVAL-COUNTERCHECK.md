# Organisation / Derived Views / Retrieval Semantics — Adversarial Counter-Check

**Status:** adversarial supplement to `ORGANISATION-RETRIEVAL-SEMANTICS.md`  
**Date:** 2026-09-01  
**Scope:** challenge the pass's own organisation/retrieval model; not independent verification.

## Purpose

The main synthesis separates context-preserving organisation, descriptive/knowledge organisation, access/retrieval projections, source/standing binding, and several retrieval contracts. This file tests whether that result:

- over-separates functions that can legitimately coincide;
- silently prescribes graph/multi-index architecture;
- treats derived views as epistemically inferior by definition;
- overstates retrieval-miss uncertainty;
- overfits archival sources;
- turns `retrieval contract` into an implementation/API requirement;
- mishandles stale-but-intentional historical views;
- assumes currentness must always be revalidated at an origin source.

---

# C1 — Are the organisation functions over-separated?

## Challenge

A simple bounded system may use one maintained structure to satisfy context, description and access simultaneously. For example, one small case hierarchy may preserve workflow context and also be the primary browse path.

## Counterexample to mandatory separation

If provenance order, user browse order and retrieval predicates genuinely coincide for the protected use, physically or logically splitting them adds no semantic value.

## Counterexample to universal collapse

The prior source set shows cases where they diverge materially:

- provenance/original order versus subject reclassification;
- one RiC Record participating in several Record Sets;
- SKOS topic organisation independent of archival provenance;
- derived indexes/finding aids optimized for access.

## Revision

Do **not** require separate components or stores.

The stronger rule is:

> **Keep semantic roles distinguishable when they can vary independently or when collapsing them loses context, coverage or lineage.**

A profile may implement several roles through one structure when no protected distinction is lost.

---

# C2 — Does plural organisation imply graph architecture?

## Challenge

Multiple memberships, typed relations and provenance can make a graph model look natural.

## Test

The same semantics could be represented through:

- relational join tables;
- hierarchical structures plus cross-references;
- document metadata;
- edge lists;
- graph stores;
- external registries;
- materialized lookup tables.

## Revision

The requirement is **recoverable typed relations and memberships**, not graph storage.

RiC/RDF/SKOS are evidence that non-exclusive relation models exist, not architecture prescriptions.

---

# C3 — Is `source-bearing` falsely a physical/object class?

## Challenge

The synthesis uses `source-bearing information` as shorthand. This could imply one physical object is intrinsically the source while all other representations are derivative.

## Test

Prior research already established:

- recordkeeping/current standing can be context/role scoped;
- multiple copies can each be records for different purposes;
- a derived output can itself become a record;
- an access collection can later become independently preserved.

## Revision

`source-bearing` must be read as a **role/relation scoped to a use/context**, not an ontological superclass.

The model should ask:

> `source for which claim/use/standing, and at which version/representation?`

Authority to establish that role remains deferred.

---

# C4 — Can an index/derived view itself be designated as the recordkeeping source?

## Challenge

The main synthesis warns against treating indexes as source-of-truth. But some systems intentionally persist an output/projection as the official record for a bounded purpose.

## Evidence/counterexample

NARA allows query results, reports and extracts to themselves be records depending on use. Recordkeeping copy is a designation/purpose distinction rather than a universal physical type.

## Revision

Do not state `index/projection can never be authoritative`.

The stronger rule is:

> a derived object's **derivation relation** does not determine its **recordkeeping/designation role**.

If a derived output is formally designated for a role, it must then be managed as a resource/record with its own identity, standing, provenance and preservation closure. The authority to make that designation is outside this pass.

---

# C5 — Is the hit/miss model too pessimistic about absence?

## Challenge

`Retrieval miss does not prove absence` can become ritual caution even when a search surface is deterministic and complete.

## Strong-miss case

A lookup by exact immutable identifier against a bounded, complete, current registry whose domain is known can support a strong absence/non-registration conclusion for **that registry/domain**.

Likewise an exhaustive query over a closed authoritative relation set can support stronger absence than a semantic search index.

## Weak-miss case

Semantic search, partial catalogues, stale indexes, distributed archives or unknown aliases can miss extant resources.

## Revision

Absence confidence should scale with:

- bounded corpus/domain;
- completeness/coverage;
- matching sensitivity;
- identity/alias coverage;
- freshness/as-of alignment;
- recall/error sensitivity.

Therefore `miss ≠ absence` is a default anti-overclaim, not an absolute prohibition on absence inference.

---

# C6 — Is a stale view always unsafe?

## Challenge

A historical snapshot is intentionally stale relative to the present. HTTP caching also permits controlled stale use. Memento explicitly serves fixed prior representations.

## Revision

Staleness is not itself an error.

The actual failure is:

> **freshness/as-of semantics do not match the claim being answered.**

A fixed 2025 snapshot is correct for an `as-of 2025` query and incorrect if silently presented as current 2026 standing.

---

# C7 — Must current-sensitive retrieval always validate against the origin resource?

## Challenge

The synthesis uses source validation as a safe pattern. That could imply every lookup must call an origin/original object.

## Countermodels

Current standing can be reliably supplied by:

- a replicated standing registry;
- a transactionally maintained projection;
- a signed/current metadata feed;
- a strongly consistent local materialization;
- another controlled authoritative relation store.

## Revision

The requirement is an **assurance path to sufficiently current standing**, not necessarily an origin round-trip.

The path must have appropriate binding, freshness/consistency and provenance guarantees for the use.

---

# C8 — Does high-recall retrieval drift from Records into generic IR?

## Challenge

Precision/recall are information-retrieval concepts and could expand this vertical into search engineering.

## Boundary test

Records needs these notions only because user/system claims such as:

- `find all records relevant to X`;
- `there is no record matching Y`;
- `reconstruct the complete case/thread`

depend on retrieval coverage and false-negative behaviour.

Records does **not** need to select ranking models, embeddings, query-expansion algorithms or evaluation datasets in this pass.

## Revision

Retain precision/recall as **retrieval-contract semantics / epistemic coverage variables**, not search-algorithm design work.

---

# C9 — Does `retrieval contract` become an API/schema requirement?

## Challenge

The term could be misread as a concrete interface with mandatory fields.

## Revision

`Retrieval contract` is a local research abstraction meaning:

> the assumptions and guarantees needed to interpret a retrieval result for a given information need.

It may be explicit policy, query metadata, system invariant, documentation, or inferred from a tightly bounded operation. No API or serialization is implied.

---

# C10 — Are archival sources biasing the model toward context/provenance?

## Challenge

SAA/RiC/OAIS strongly emphasize archival context and preservation.

## Cross-domain counterbalance

The pass also includes:

- SKOS for knowledge organisation;
- IR theory for precision/recall and navigational/informational needs;
- FAIR for metadata→resource binding and findability;
- Memento for historical web retrieval;
- HTTP caching/materialized-view/search-index documentation for derived-view freshness.

These independent domains converge on plural organisation/access functions and bounded retrieval guarantees without relying on archival theory alone.

## Revision

Keep archival context as one organisation function, not the universal organisation frame.

---

# C11 — Are OAIS Access Collections being promoted to a universal class?

## Challenge

OAIS's Access Collection is archive-specific terminology.

## Revision

Use it only as a counterexample demonstrating that:

- purpose-specific derived collections can be transient/selective/inferred;
- an access-derived object can later acquire preservation value.

Do not create an `AccessCollection` universal Records primitive.

---

# C12 — Can knowledge-organisation inference distort retrieval?

## Challenge

SKOS transitive relations/query expansion can improve recall, but inferred broader/narrower relationships can expand results beyond the user's intended specificity and reduce precision.

## Revision

Inferred/mapped access relations must remain distinguishable from source/context relations where the distinction matters.

Query expansion is a view/query operation, not evidence that the underlying records are directly related in provenance or identity.

---

# C13 — Is retrievability always a baseline preservation obligation?

## Challenge

Some records are intentionally inaccessible to ordinary users because of classification, embargo or privacy.

## Revision

`Retrievable` means **reachable under the authorised future-use profile**, not universally public/searchable.

A resource may be correctly preserved and intentionally undiscoverable to a particular requester while still having an internal controlled retrieval path for authorised use/preservation operations.

Authority/access policy remains outside this pass; Records preserves enough constraints/path semantics to avoid confusing inaccessible with nonexistent.

---

# C14 — Freshness is more than elapsed time

## Challenge

A recently rebuilt view can still be semantically stale if:

- it used the wrong source version;
- its schema/vocabulary mapping is outdated;
- historical membership/context was flattened;
- it omitted a standing change due to coverage gaps.

## Revision

Freshness/currentness of a derived view is multidimensional:

- generation/as-of time;
- source version/standing coverage;
- schema/vocabulary version;
- corpus coverage;
- derivation rule version where material.

Do not reduce safe retrieval to one `last_refreshed_at` timestamp.

---

# C15 — Is independent editability of a derived view always a failure?

## Challenge

A curator may legitimately annotate, enrich or correct a catalogue/finding aid independently of the described resource.

## Revision

Independent editability is not inherently wrong.

The failure is **silent semantic conflation**:

- view-local assertions are treated as source assertions;
- source-derived fields diverge without provenance;
- current-standing fields are duplicated without a controlled designation relation.

If a view gains independent assertions, those assertions need their own provenance/status rather than being forbidden.

---

# C16 — Could one master hierarchy be sufficient?

## Challenge

The research strongly rejects one universal hierarchy, but a bounded domain can legitimately have one hierarchy that is sufficient for its use.

## Revision

Do not require plural structures by principle.

The rule is:

> **Allow plural organisations where needed; do not force multiplicity where one structure preserves all load-bearing relations and retrieval needs.**

---

# Final adversarial verdict

The main organisation/retrieval frame survives with these constraints:

1. organisation roles are semantic functions, not mandatory components/stores;
2. multiple organisation is permitted, not required;
3. plural relations do not imply graph architecture;
4. `source-bearing`, `derived`, `record`, `recordkeeping/designated` are relational/status dimensions, not a fixed class hierarchy;
5. a derived view can itself become/designate a record for a role;
6. retrieval miss can support absence when corpus/coverage/sensitivity/freshness are sufficiently bounded;
7. stale is safe when `as-of` semantics match the query; mismatch is the error;
8. currentness requires an adequate assurance path, not necessarily origin resolution;
9. precision/recall remain epistemic retrieval requirements, not search-engine design;
10. freshness includes version/schema/coverage, not only time;
11. independent annotations/enrichment are legitimate if provenance and source/view semantics remain explicit;
12. the pass remains architecture-neutral.

No counterexample found requires abandoning the organisation/retrieval framing.

The strongest remaining problem is still **profile/requirement derivation**: when a particular resource/use/horizon/risk needs which preservation, history, organisation, retrieval and assurance semantics, and which distinctions can safely be merged.