# Source Ledger — Organisation, Retrieval, Lifecycle and Storage Patterns

**Research role:** examine how persistent information is organised, found, accessed, retained and disposed; distinguish canonical/context structure from access indexes and compare storage/state patterns without choosing a SOUL technology.

## 1. FAIR Data Principles — NIST summary

Source:
- https://www.nist.gov/itl/ssd/information-systems-group/configurable-data-curation-system-cdcs/cdcs-help-and-resources-1

Observed:
- Findability includes globally unique persistent identifiers, rich metadata, explicit linkage between metadata and the described data, and searchable indexing.
- Accessibility requires retrieval by identifier through a defined protocol and may include authentication/authorization.
- FAIR explicitly allows metadata to remain available even when the underlying data are no longer available.
- Reusability calls for detailed provenance and domain-relevant standards.

Research implication:
- Persistence and findability are different guarantees.
- Metadata/indexes can have a lifecycle partly independent from the underlying content.
- A stored object that cannot be found or interpreted later is operationally lost even if its bytes remain.

Caveat:
- FAIR is a data-stewardship framework, not a records ontology or storage architecture.

## 2. NARA — records management tools and disposition

Sources:
- https://www.archives.gov/records-mgmt/faqs/general.html
- https://www.archives.gov/records-mgmt/scheduling/instructions

Observed:
- Records maintenance/use includes file plans, indexes, controlled vocabularies, taxonomies, data dictionaries and access/security procedures.
- Disposition is a first-class management process, with explicit permanent or temporary status and concrete retention/cutoff rules.
- Temporary records should have specific destroy/delete conditions rather than vague `when no longer needed` rules.
- Permanent retention is not the default; long retention is not the same as permanent preservation.

Research implication:
- `keep everything forever` is not a neutral records strategy. It can be a failure to govern retention, cost, privacy, legal obligations and discoverability.
- Deletion/disposition needs explicit semantics and authority, not accidental garbage collection or ad hoc user cleanup.

## 3. SKOS — knowledge organisation systems

Source:
- https://www.w3.org/TR/skos-reference/

Observed:
- SKOS provides a common model for representing knowledge-organisation systems such as thesauri, classification schemes, subject-heading systems and taxonomies.
- Concepts can have preferred/alternative labels and semantic relations.

Research implication:
- Organising information for discovery may use controlled conceptual structures that are distinct from the records' intrinsic/provenance relationships.
- Taxonomy is one access/organisation mechanism, not the ontology of the records themselves.

## 4. Dublin Core Metadata Element Set

Source:
- https://www.dublincore.org/specifications/dublin-core/dces/

Observed:
- Dublin Core provides generic descriptive terms such as identifier, creator, date, subject, source, relation, rights and type.
- `relation` and `source` explicitly connect the described resource to related/derived resources.

Research implication:
- Descriptive metadata can provide broad discovery/context hooks, but generic element sets do not encode the full provenance, temporal or preservation semantics found in specialised models.

## 5. RDF — graph representation as an organisation model

Source:
- W3C RDF 1.1/1.2 concepts publication family: https://www.w3.org/TR/rdf-concepts/all/

Observed:
- RDF models information as graphs of subject-predicate-object statements; datasets can contain collections of graphs.

Research implication:
- Graph representation is a natural option when relationships are central and heterogeneous, but this says nothing by itself about record immutability, authority, transaction history, preservation or search quality.
- `graph database` / RDF should therefore be treated as an organisation/representation pattern, not as a complete records-management solution.

## 6. Current-state / multiversion database pattern

Source example:
- PostgreSQL MVCC documentation: https://www.postgresql.org/docs/current/mvcc-intro.html

Observed:
- MVCC exposes transactionally consistent snapshots while concurrent updates occur.
- Multiple internal row versions are used to provide transaction isolation.

Research implication:
- `version` can exist for concurrency implementation without constituting durable business/history records.
- A database offering MVCC does not imply that historical versions are retained as an application-level audit/provenance model.

## 7. Event-history pattern

Source:
- https://www.martinfowler.com/eaaDev/EventSourcing.html

Observed:
- Event-sourced systems can make a durable event sequence the principal source from which current state is derived.
- Snapshots/current projections can be caches or derived views.

Research implication:
- A system must choose what it treats as authoritative: current state, immutable versions, events, or some composition. These are different information architectures.

## 8. Content-addressed/versioned object pattern

Sources:
- Git data model: https://github.com/git/git/blob/master/Documentation/gitdatamodel.adoc
- S3 Versioning: https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html

Observed:
- Git separates immutable content-addressed objects from mutable references.
- S3 versioning separates a stable object key/current version from opaque historical version IDs.

Research implication:
- Version preservation can be implemented through materially different identity mechanisms.
- `immutable data` does not imply `immutable logical record`; a mutable reference or state pointer may sit above immutable versions.

## Organisation layers — bounded synthesis

The source set suggests keeping at least three organisational functions separate:

1. **Context-preserving organisation** — provenance, archival bond, creator/function/series relationships that help explain why a record exists and how it relates to activity.
2. **Descriptive organisation** — metadata describing the record/resource itself.
3. **Access organisation** — indexes, taxonomies, search fields, controlled vocabularies, graph traversals, search/ranking structures used to find material.

A fourth category may be needed for **canonical state/source-of-truth organisation**, but that concept needs more direct research before promotion.

A derived index or search result should not silently become the authoritative record merely because it is easier to retrieve.

## Storage/state pattern landscape — not a selection

Current research has identified these reusable pattern families:

- current-state mutable store,
- multiversion current-state store,
- immutable/versioned object store,
- content-addressed object graph,
- append-only event/change log with derived current state,
- graph-oriented relationship representation,
- document/file collections with metadata and indexes,
- separate search/access indexes derived from canonical content.

These patterns solve different problems. Later work must compare them against required record properties rather than selecting one by familiarity or convenience.