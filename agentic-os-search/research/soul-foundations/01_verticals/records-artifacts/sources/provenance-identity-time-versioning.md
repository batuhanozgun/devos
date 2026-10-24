# Source Ledger — Provenance, Identity, Time and Versioning

**Research role:** separate logical identity, versions, content identity, provenance and temporal semantics; examine mechanisms that preserve history without assuming one storage technology.

## 1. W3C PROV Data Model

Source:
- https://www.w3.org/TR/prov-dm/

Observed:
- PROV models provenance with entities, activities and agents plus relations such as usage, generation, derivation, attribution, association and delegation.
- Derivation makes the relation between a later entity and an earlier entity explicit rather than treating the newer object as an unexplained replacement.
- PROV supports provenance bundles and provenance-of-provenance.
- Its specialization/alternate relations distinguish a general thing from a more specific time/context-bound entity and allow multiple entities to represent aspects/variants of the same broader thing.
- The specification gives examples where a generic evolving resource has date-specific versions with separate identifiers.

Research implication:
- Provenance is naturally relational/graph-like and may itself require provenance.
- `the thing`, `a particular version/aspect of the thing`, and `a provenance description about the thing` should not be silently collapsed into one identity.

Caveat:
- PROV is a generic provenance interchange model. It does not by itself define what a `record` must be.

## 2. Temporal database theory — valid time vs transaction time

Source:
- Christian S. Jensen and Richard T. Snodgrass, `Temporal Database`, Encyclopedia of Database Systems: https://doi.org/10.1007/978-0-387-39940-9_395

Observed:
- Temporal database literature distinguishes transaction time, which tracks past/current database states, from valid time, which tracks states of the reality represented by the data.
- A bitemporal model carries both.

Research implication:
- One timestamp is often semantically insufficient.
- At minimum, `when this was true in the represented world` and `when the system recorded/knew this` are different questions.
- Additional record-specific times may exist (creation, receipt, capture, modification, supersession, disposition); these must not be automatically mapped to valid/transaction time without checking semantics.

## 3. Git data model — immutable objects and mutable references

Source:
- https://github.com/git/git/blob/master/Documentation/gitdatamodel.adoc

Observed:
- Git objects do not change after creation.
- An object ID is a cryptographic hash of object type and contents; the exact contents can be recovered from the ID while the object remains retained.
- Commits point to parent commits, encoding history/lineage.
- Git references such as branches/tags are a different data kind from objects. References can name objects while branch references move as history advances.

Research implication:
- A useful identity separation appears in a mature versioned system:
  - immutable content/version identity,
  - mutable logical/current reference.
- A stable human/logical name does not have to be the identifier of a specific immutable representation.
- Content-addressing solves a particular identity/fixity problem; it does not by itself solve semantic identity, provenance, authority or retention.

## 4. Amazon S3 Versioning — stable key, multiple version IDs

Source:
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html

Observed:
- With versioning enabled, overwriting an object creates a new version and retains the previous version.
- A key can therefore address a current object while distinct version IDs address historical variants.
- Deletion can create a delete marker as the current version while older versions remain, and lifecycle rules can later permanently remove versions.

Research implication:
- Version history and logical naming can be separated even without content-addressing.
- `delete` itself has multiple semantics: hide/current-delete marker, retention of historical versions, or permanent removal.

Caveat:
- S3 is an implementation example, not evidence that versioned object storage is the right general architecture.

## 5. Event Sourcing — event history as primary state source

Source:
- Martin Fowler, `Event Sourcing`: https://www.martinfowler.com/eaaDev/EventSourcing.html

Observed:
- Event Sourcing stores application state changes as a sequence of events.
- Past/current state can be reconstructed by replaying events; current-state snapshots can be treated as derived/cached state.
- The approach enables temporal queries and explicit handling of retroactive corrections, at the cost of additional complexity.

Research implication:
- There are at least two materially different persistence strategies:
  - persist current state and optionally history,
  - persist change/event history and derive current state.
- This is a design trade-off, not evidence that event sourcing should be the universal record model.

## Working identity decomposition

The sources support keeping several identity questions distinct:

1. **Logical/resource identity** — the continuing thing concept users refer to across time.
2. **Version/manifestation identity** — a particular state/representation of that thing.
3. **Content identity** — identity determined from exact content/representation, e.g. a hash.
4. **Locator/reference** — a name/path/pointer used to reach an object or current version.
5. **Aggregate/relationship identity** — membership in a collection, series, graph or record set.

This decomposition is provisional. It exists to prevent a single `id` field from silently carrying incompatible meanings.

## Working time decomposition

Candidate temporal semantics that must be kept distinguishable during later research:

- occurrence / valid time,
- creation time,
- receipt or observation time,
- capture/registration time,
- system / transaction time,
- modification / derivation time,
- supersession / invalidation time,
- retention cutoff / disposition time.

Not every record needs all of these. The key finding is that `timestamp` is not a sufficient semantic model by itself.