# Change / Status / Temporal Semantics — Source Ledger

**Pass:** change, status, and temporal semantics  
**Access date:** 2026-09-01 unless noted otherwise  
**Status:** source ledger; not synthesis

## Source-selection rule

This pass compares independent semantic traditions rather than treating a temporal database, event log, publishing workflow, preservation system, or records lifecycle as the natural ontology of change.

Priority is given to standards/recommended practices, primary specifications, current professional guidance, archival/public-sector guidance, and foundational temporal-data literature. A source is used only for the distinctions it actually supports.

---

## 1. NISO RP-8-2008 — Journal Article Versions (JAV)

- Authority: NISO / ALPSP.
- URLs:
  - https://www.niso.org/publications/niso-rp-8-2008-jav
  - https://www.niso.org/sites/default/files/2017-08/RP-8-2008.pdf
- Relevant observations:
  - Defines Author's Original, Submitted Manuscript Under Review, Accepted Manuscript, Proof, Version of Record (VoR), Corrected Version of Record (CVoR), and Enhanced Version of Record (EVoR).
  - The model is driven by meaningful **status change**, not raw content diff.
  - A VoR can exist in multiple locations and formats while remaining one version.
  - CVoR means the VoR contained errors that were corrected.
  - EVoR means the VoR was subsequently enhanced/updated; the prior VoR need not have been erroneous.
  - Metadata accompanying an updated VoR should make the nature/history of the change recoverable.
- Research use:
  - Strong counterexample to `change = content diff` and `new file = new version`.
  - Supports `correction ≠ generic revision/enhancement` and `representation copy ≠ version`.
- Limitation:
  - Scholarly-journal version nomenclature. Not a universal lifecycle vocabulary for all persistent information.

## 2. NISO RP-45-2024 — Communication of Retractions, Removals, and Expressions of Concern (CREC)

- Authority: NISO.
- URL: https://www.niso.org/publications/rp-45-2024-crec
- DOI: 10.3789/niso-rp-45-2024
- Relevant observations:
  - Treats retraction, removal, and expression of concern as distinct editorial statuses/actions requiring explicit metadata communication to humans and machines.
  - A retraction notice is a separate publication that identifies/relates to the original publication.
  - Retraction changes editorial/reliance standing; it does not imply that the original publication ceases to exist.
  - `Removal` is reserved for rare cases where full text is made unavailable; identifying metadata is preserved.
  - For complex version/status histories, transparency is needed so the scholarly record can be reconstructed and citation integrity retained.
- Research use:
  - Strong counterexample to `retraction = removal = deletion`.
  - Shows standing/status can change while identity/history remains.
  - Supports propagation of current status into discovery/metadata systems without rewriting history.
- Limitation:
  - Scholarly publishing; terminology is explicitly practice-sensitive and should not be universalised unchanged.

## 3. ICMJE Recommendations — Corrections and Version Control / Retractions

- Authority: International Committee of Medical Journal Editors.
- Current recommendations updated January 2026.
- URLs:
  - https://www.icmje.org/recommendations/browse/publishing-and-editorial-issues/corrections-and-version-control.html
  - https://icmje.org/recommendations/browse/publishing-and-editorial-issues/scientific-misconduct-expressions-of-concern-and-retraction.html
- Relevant observations:
  - Corrections address errors of fact that should have been recognised at publication; evolving science/debate is not automatically an error.
  - A correction should be accompanied by a new article version and change dates/details.
  - Prior versions should remain archived; earlier electronic versions should indicate that newer versions exist.
  - Errors invalidating results/conclusions may require retraction.
  - Retracted articles should remain publicly available and clearly labelled as retracted; original and retraction should be bidirectionally linked.
- Research use:
  - Supports `correction ≠ ordinary revision` and `retraction ≠ deletion`.
  - Strong evidence that current standing and historical versions should coexist.
- Limitation:
  - Medical journal guidance; not a generic Records ontology.

## 4. Crossref — Version control, updates, Crossmark

- Authority: Crossref.
- URLs:
  - https://www.crossref.org/documentation/principles-practices/best-practices/versioning/
  - https://www.crossref.org/documentation/crossmark/
  - https://www.crossref.org/documentation/crossmark/participating-in-crossmark/
  - https://www.crossref.org/documentation/register-maintain-records/maintaining-your-metadata/registering-updates/
- Relevant observations:
  - Version control is used for traceability, identifiability and distinguishing current/latest versions.
  - Editorially significant post-publication changes should normally be represented by a separate update/correction/retraction notice with its own DOI rather than silently rewriting the original.
  - Crossmark exposes current status, including corrections/retractions/updates, even from downloaded static formats.
  - Current Crossmark update vocabulary contains distinct types including correction, expression of concern, new version, partial retraction, removal, retraction and withdrawal.
  - In-situ significant updates are discouraged because they obscure the scholarly record.
  - Minor formatting/spelling changes can remain direct content changes without a status update.
- Research use:
  - Supports significance threshold: not every edit is a new semantic status/version.
  - Status/update relation can be represented by a separate resource rather than mutation.
  - Discovery copies require a route to current standing.
- Limitation:
  - Crossref update types are a publishing interoperability vocabulary, not a universal status enum.

## 5. DataCite — Versioning and related identifiers

- Authority: DataCite.
- URLs:
  - https://support.datacite.org/docs/versioning
  - https://support.datacite.org/docs/connecting-versions-with-related-identifiers
  - https://datacite-metadata-schema.readthedocs.io/en/4.7/appendices/appendix-1/relationType/
- Relevant observations:
  - Minor changes may retain the same DOI with updated metadata; major changes are recommended to receive a new DOI.
  - The major/minor threshold is steward/domain dependent.
  - `IsPreviousVersionOf` / `IsNewVersionOf` express sequential version relations.
  - `HasVersion` / `IsVersionOf` distinguish canonical resource identity from version-specific resources.
  - Relation vocabulary separately includes `IsDerivedFrom`, `IsSourceOf`, `Obsoletes`, and `IsObsoletedBy`.
- Research use:
  - Supports identity family ≠ version identity.
  - Supports version/supersession/derivation as distinct relations rather than one status value.
- Limitation:
  - DOI/data stewardship practice; does not define correctness, authority, or records disposition.

## 6. W3C PROV — revision, derivation, generation, invalidation

- Authority: W3C Provenance Working Group.
- URLs:
  - https://www.w3.org/ns/prov
  - https://www.w3.org/TR/prov-o/
- Relevant observations:
  - `wasRevisionOf`: a revision is a derivation whose result is a revised version of an original entity.
  - Therefore revision is a more specific relation than generic derivation.
  - PROV invalidation denotes the start of destruction, cessation, or expiry: after invalidation an entity is no longer available for use.
  - Generation/invalidation have explicit temporal semantics.
- Research use:
  - Supports `revision ⊂ derivation`, not `all derivation = versioning`.
  - Provides a terminology collision: PROV `invalidation` is materially different from scholarly `retraction`, where the publication commonly remains available but its reliance/editorial status changes.
- Limitation:
  - Provenance ontology, not a complete Records lifecycle/status ontology.

## 7. PREMIS Data Dictionary v3 / Preservation Events

- Authority: Library of Congress / PREMIS Editorial Committee.
- URLs:
  - https://www.loc.gov/standards/premis/v3/
  - https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf
  - https://www.loc.gov/standards/premis/pif-presentations/rebecca-SKOS/preservationEvents.html
- Relevant observations:
  - PREMIS treats preservation Events separately from Objects, Agents and Rights.
  - `eventType` categorises preservation events; examples include creation, capture, migration, normalization, replication, validation, deletion and deaccession.
  - Event-type granularity is implementation-specific; detailed event information is preferred over endlessly granular eventType values.
  - Migration/normalization/replication are preservation operations; their occurrence does not by itself establish a semantic content revision or new higher-level resource.
- Research use:
  - Strong counterexample to conflating preservation-operation history with resource standing/version semantics.
  - Supports typed event history but not a universal event vocabulary.
- Limitation:
  - Digital preservation context; operational record status/currentness may require different semantics.

## 8. Jensen & Snodgrass — temporal database semantics

- Sources:
  - Christian S. Jensen & Richard T. Snodgrass, `Temporal Database`: https://www2.cs.arizona.edu/~rts/pubs/TRmerged.pdf
  - `Temporal Data Management`: https://www2.cs.arizona.edu/~rts/pubs/TKDEJan99.pdf
  - Jensen & Dyreson (eds.), Consensus Glossary of Temporal Database Concepts: https://www2.cs.arizona.edu/~rts/pubs/LNCS1399.pdf
- Relevant observations:
  - Valid time represents when a fact/state holds in the modelled reality.
  - Transaction time represents when the fact/entity is current in the database/system history.
  - These temporal perspectives are independent/orthogonal and can coexist in bitemporal models.
- Research use:
  - Strong counterexample to one generic timestamp for current + historical reconstruction.
  - Provides a semantic lens for separating effective/applicable time from system-known/recorded time.
- Limitation:
  - Database facts/entities differ from records and editorial statuses. The terminology should be borrowed only as a semantic distinction, not as a prescribed bitemporal architecture.

## 9. RFC 5829 — version navigation

- Authority: IETF / RFC Editor; Informational RFC.
- URL: https://www.rfc-editor.org/rfc/rfc5829.html
- Relevant observations:
  - Separates version-history resource, latest-version, working-copy, predecessor-version and successor-version relations.
  - A version can have multiple predecessors (merge) and multiple successors/branches.
  - `latest-version` is defined by the system; in branching systems there may be multiple latest versions.
- Research use:
  - Strong counterexample to `latest/current = max(timestamp)` and to strictly linear version lineage.
  - Supports lineage as a relation/graph question distinct from authority/currentness.
- Limitation:
  - Web version navigation; does not define record authority, correction or retraction.

## 10. ICA Records in Contexts Ontology 1.1 — RecordState

- Authority: International Council on Archives.
- URL: https://www.ica.org/standards/RiC/RiC-O_1-1.html
- Relevant observations:
  - `RecordState` means production/reproduction status of a Record/Record Part.
  - Examples include stage of creation (`draft`) and form of transmission (`copy`).
  - RiC also contains separate legal-status and relationship concepts.
- Research use:
  - Strong evidence against treating the word `status/state` as one universal axis.
  - A `draft/copy` state answers a different question from `retracted/current`, `available/removed`, or `archived/disposed`.
- Limitation:
  - Archival description semantics; not exhaustive of operational/editorial states.

## 11. NARA — records lifecycle and disposition/destruction

- Authority: U.S. National Archives and Records Administration.
- URLs:
  - https://www.archives.gov/records-mgmt/scheduling/basics
  - https://www.archives.gov/records-mgmt/policy/prod6b.html
- Relevant observations:
  - Records lifecycle is commonly described as creation/receipt → maintenance/use → disposition.
  - Disposition includes transfer of permanent records or disposal of temporary records; it is broader than destruction.
  - NARA requirements for records systems call for audit/use-history metadata for records activity.
  - For destruction, records should become irrecoverable while the system can retain a certifiable record of record destructions.
  - Transfer similarly can leave a certifiable record of transfer.
- Research use:
  - Supports `payload destruction ≠ destruction-history erasure`.
  - Supports disposition as a management/action semantic distinct from retraction/removal.
- Limitation:
  - U.S. federal requirements. Authority/policy for disposition remains outside this Records-only pass.

---

# Cross-source anti-collapse observations

The independent sources repeatedly separate different semantic questions:

- **representation change** can occur without semantic version change (JAV, PREMIS, prior object-boundaries evidence);
- **revision** is a version/derivation relation (PROV, DataCite), not automatically a correction;
- **correction** asserts a defect/error in a prior state and preserves a relation to it (JAV, ICMJE, Crossref);
- **supersession** answers which resource/version should replace another for a given role, not why it changed (DataCite, versioning practice);
- **retraction** changes reliance/editorial standing while preserving identity/discoverability (NISO CREC, ICMJE, Crossref);
- **removal** changes availability while retaining metadata (NISO CREC);
- **destruction/disposition** can remove payload irrecoverably while retaining destruction history (NARA);
- **migration** is a preservation event and does not inherently imply revised informational content (PREMIS);
- **latest/current** can be system/role-defined and branch-sensitive, not simply the newest timestamp (RFC 5829);
- **record state/status** is domain-axis-specific, not one universal field (RiC vs Crossmark vs preservation status);
- **effective/valid time** and **system-recorded/known time** can diverge (temporal database literature).

These observations support a multidimensional change/standing model but do not by themselves specify a storage architecture.