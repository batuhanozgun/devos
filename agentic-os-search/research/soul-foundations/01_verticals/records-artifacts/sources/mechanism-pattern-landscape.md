# Source Ledger — Records Mechanism Pattern Landscape

**Pass:** mechanism-pattern landscape  
**Access date:** 2026-09-01  
**Status:** source ledger; not synthesis

## Source-selection rule

Use primary specifications/product documentation and established technical references to understand each mechanism's **native semantics**, not marketing labels. Mechanisms are compared only against Records-relevant requirements; this ledger does not recommend a SOUL stack.

---

## 1. Mutable current-state / MVCC — PostgreSQL

Sources:
- https://www.postgresql.org/docs/current/mvcc-intro.html
- https://www.postgresql.org/docs/current/routine-vacuuming.html

Observed:
- PostgreSQL MVCC gives statements/transactions consistent snapshots while concurrent writes occur.
- UPDATE/DELETE create old row versions for concurrency visibility, but obsolete/dead row versions are eventually reclaimed by VACUUM.
- MVCC's primary purpose is transaction isolation/concurrency, not durable application-level history.

Research use:
- `database version` / MVCC must not be confused with durable Records version/history semantics;
- current-state relational stores can satisfy current operational state well while requiring separate history/provenance structures when historical reconstruction matters.

---

## 2. System-versioned temporal tables — Microsoft SQL Server

Sources:
- https://learn.microsoft.com/en-us/sql/relational-databases/tables/temporal/overview
- https://learn.microsoft.com/en-us/sql/relational-databases/tables/temporal-table-considerations-and-limitations
- https://learn.microsoft.com/en-us/sql/relational-databases/tables/manage-retention-of-historical-data-in-system-versioned-temporal-tables
- https://learn.microsoft.com/en-us/sql/relational-databases/tables/stopping-system-versioning-on-a-system-versioned-temporal-table

Observed:
- system-versioned tables maintain current and history tables correlated by primary key and SYSTEM_TIME periods;
- support historical/as-of querying at system-time level;
- history retention is a separate policy and may be finite;
- while SYSTEM_VERSIONING is enabled direct history modification is blocked, but when disabled history can be modified or deleted by sufficiently privileged users;
- system-time columns are engine-maintained recording periods, not automatically domain-effective/valid time or semantic change types.

Research use:
- temporal tables natively support a useful class of system-known/as-of history;
- they do not by themselves provide bitemporal effective-time semantics, correction/supersession meaning, provenance, authority, or indefinite preservation.

---

## 3. Event Sourcing — Martin Fowler

Source:
- https://www.martinfowler.com/eaaDev/EventSourcing.html

Observed:
- Event Sourcing makes state changes originate in stored event objects and can rebuild application state by replay;
- supports temporal queries and replay/correction scenarios in principle;
- Fowler explicitly notes that adequate history can also be provided by other approaches, such as history fields/logs; history alone is not unique to event sourcing.

Research use:
- append-only event/change models naturally preserve transition facts and replayability when events are semantically complete/stable;
- event sourcing is not required merely because historical reconstruction is required;
- stored events still need identity, schema/semantic evolution, provenance, effective-time/currentness and retention semantics as demanded by the profile.

Limitation:
- architecture pattern article, not records-management standard.

---

## 4. Versioned object storage — Amazon S3 Versioning / Object Lock

Sources:
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html

Observed:
- versioning stores multiple versions under one key with generated version IDs;
- overwrite produces a new version; simple DELETE creates a delete marker while older versions remain;
- a specific version can be permanently deleted if authorized and not protected;
- Object Lock adds version-specific retention/legal-hold/WORM protections but does not prevent creation of new versions or delete markers above protected versions.

Research use:
- strong mechanism for representation/object-version retention and recovery from overwrite/delete;
- key/current-version semantics are storage currentness, not automatically record/business currentness;
- delete marker ≠ destruction and Object Lock/WORM ≠ authenticity/truth/provenance;
- retention protection is a separate layer from versioning itself.

---

## 5. Content-addressed snapshot/DAG — Git

Sources:
- https://git-scm.com/book/en/v2/Git-Internals-Git-Objects.html
- https://git-scm.com/docs/gitrepository-layout
- https://git-scm.com/docs/git-gc
- https://git-scm.com/docs/git-reflog.html
- https://git-scm.com/docs/git-history
- https://git-scm.com/docs/git-replace

Observed:
- Git is a content-addressable object store with blob, tree and commit objects; commits link snapshots to parents and carry author/time/message information;
- refs provide mutable names/tips over immutable-ish content-addressed objects;
- reachability from refs controls persistence; unreachable objects/reflog history may be expired/pruned by garbage collection;
- Git supports history rewriting and replacement refs; the visible history is therefore not inherently an immutable regulatory/audit history.

Research use:
- content addressing + snapshot DAG naturally supports exact content identity, branching/version lineage and deduplication;
- mutable refs show that immutable content does not imply immutable logical currentness;
- Git history is not by itself a retention/authority/provenance/audit guarantee;
- reachability/GC policies are Records-relevant when using Git for durable history.

---

## 6. Preservation-oriented versioned object layout — OCFL 1.1

Sources:
- https://ocfl.io/
- https://ocfl.io/1.1/spec/
- https://ocfl.io/1.1/implementation-notes/
- https://ocfl.io/1.1/spec/validation-codes.html

Observed:
- OCFL is application-independent and explicitly aimed at long-term object management;
- objects store a sequence of versions with inventory/digest information; created version directories are expected to remain immutable;
- goals include completeness/rebuildability, parsability, robustness, versioning and storage diversity;
- implementation notes recommend storing enough data/metadata so repository objects can be rebuilt without additional information resources, while connecting this to OAIS preservation metadata.

Research use:
- stronger fit than generic object versioning for preserved object-version history, structural inventory, validation and repository rebuildability;
- still does not itself define recordhood, business currentness, evidential truth, semantic derivation, rich contextual graphs or search quality;
- preservation-oriented layout is not the same as a complete Records system.

---

## 7. Graph/relationship representation — RDF 1.2 / RDF datasets

Source:
- https://www.w3.org/TR/rdf12-concepts/

Observed:
- RDF represents information as subject-predicate-object graph statements;
- datasets can contain a default graph and multiple named graphs;
- graph names are syntactically paired with graphs and are not by themselves formal provenance/authority semantics.

Research use:
- graph representations naturally express heterogeneous relationships, provenance/derivation/aggregation links and multiple organisational views;
- RDF alone does not supply record identity policy, temporal change history, assertion authority, fixity, retention or truth semantics;
- named graphs are not automatically provenance or source-of-truth containers.

---

## 8. Derived search/index structure — Apache Lucene

Source:
- https://lucene.apache.org/core/10_5_0/core/org/apache/lucene/index/IndexWriter.html

Observed:
- IndexWriter creates/maintains an index via add/delete/update operations;
- updateDocument is implemented as delete + add;
- readers can remain on point-in-time snapshots until reopened;
- default index deletion policy keeps only the last commit, while custom policies can retain prior commits;
- sequence numbers are transient to one IndexWriter and not durable record identifiers.

Research use:
- search indexes are optimized access structures whose version/currentness lifecycle is independent from source-record history;
- index commits/snapshots can support controlled retrieval consistency but do not inherently preserve canonical record history;
- staleness and source/version binding must be managed explicitly;
- the index may intentionally retain or discard older indexed states depending on policy.

---

## 9. Prior Records sources used for mechanism evaluation

The following established prior-pass sources remain controlling for requirements, not mechanism selection:

- OAIS 3rd Edition — preservation objectives, information packages, representation/PDI;
- PREMIS — preservation semantic units/events/objects/rights;
- ICA RiC — contextual/record-set relations;
- W3C PROV — entity/activity/derivation/revision semantics;
- ISO/NARA/NAA — records requirements/appraisal/metadata/lifecycle;
- Pass 1–6 syntheses and failure modes in this package.

---

# Cross-source signals

The mechanism sources expose several recurring anti-collapse rules:

- implementation MVCC version ≠ durable Records version;
- system-time history ≠ effective-time history or semantic change type;
- append-only event log ≠ complete provenance/authority/retention semantics;
- object version ≠ business/record version or standing;
- content-addressed immutable object ≠ immutable logical history/currentness;
- WORM ≠ authenticity/truth;
- graph relation ≠ provenance/authority merely because it is a graph;
- index snapshot/version ≠ source-record version;
- preservation layout ≠ complete Records semantics.

No mechanism family natively satisfies all obligation families from the Records Requirement Profile method.