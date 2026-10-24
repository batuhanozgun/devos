# Records / Artifacts — Foundational Source Ledger

**Pass:** foundational recordhood / persistent-information pass  
**Access date:** 2026-09-01 unless noted otherwise  
**Status:** source ledger; not synthesis

## Source-selection rule

This pass deliberately spans independent disciplines so that `record` is not defined by one inherited software or archival frame. Priority is given to standards bodies, national archives, international archival bodies, primary specifications, foundational technical literature, and public research institutions.

A source's inclusion means it is evidence/prior art for a concept or failure surface. It does not mean its domain mechanism should be copied into SOUL.

## A. Records management / archival science

### ISO 15489-1:2016 — Records management: concepts and principles

- Authority: ISO / ISO TC 46 SC 11.
- URL: https://www.iso.org/standard/62542.html
- Relevant observations:
  - treats creation, capture and management of records independently of structure/form and across technological environments over time;
  - distinguishes records, metadata for records, records systems, controls, and management processes;
  - authoritative-record framing centres authenticity, reliability, integrity and usability.
- Research use: strongest standards anchor for recordhood as a managed evidential/information object rather than a storage format.
- Limitation: organisational/business-record context; not proof that every persistent information object is a record.

### ISO 18128 / ISO 30300 terminology surfaced by ISO

- URL: https://www.iso.org/obp/ui?_escaped_fragment_=iso%3Astd%3Aiso%3A18128%3Adis%3Aed-1%3Av1%3Aen
- Relevant observation: record is information created or received and maintained as evidence and as an asset in pursuit of obligations or business; authoritative record possesses authenticity, reliability, integrity and usability.
- Research use: compact formal definition and authoritative-record property set.

### NARA — Records Basics

- Authority: U.S. National Archives and Records Administration.
- URL: https://www.archives.gov/records-mgmt/scheduling/basics
- Relevant observation: federal recordhood depends on information being created/received in business and preserved (or appropriate for preservation) for evidential or informational value; reference/library/museum material is explicitly excluded from federal-record status.
- Research use: strong counterexample to `record = any stored information`.
- Limitation: legal/federal definition; scope-specific.

### NARA — Records Management FAQ

- URL: https://www.archives.gov/records-mgmt/faqs/general.html
- Relevant observation: records management is systematic control of creation, maintenance, use and disposition; NARA describes a lifecycle while records are in agency custody.
- Research use: lifecycle/control frame.

### NARA Bulletin 2015-04 — Metadata guidance

- URL: https://www.archives.gov/records-mgmt/bulletins/2015/2015-04.html
- Relevant observation: metadata supplies administrative, descriptive, technical and contextual information about structure/content, creation/use/management, and relationships to other records; this enables management, preservation and access over time.
- Research use: content alone is insufficient for durable interpretability/management.

### Society of American Archivists Dictionary — `record`

- URL: https://dictionary.archivists.org/entry/record.html
- Relevant observations:
  - terminology is historically plural rather than singular;
  - record can be framed as stored information/data extending memory/accountability;
  - archival synthesis cited there associates records with action/transaction/event and with contextual metadata.
- Research use: evidence that `record` is contested and relational/contextual definitions coexist.
- Limitation: dictionary aggregates historical usages; individual quotations are not one normative definition.

### SAA Dictionary — `archival record`

- URL: https://dictionary.archivists.org/entry/archival-record.html
- Relevant observation: materials created/received in conduct of affairs and preserved for enduring informational/evidential value; can take many formats.
- Research use: record versus archival-record distinction; retention/value is not identical to initial recordhood.

### SAA Dictionary — provenance / original order / archival integrity / authenticity

- URLs:
  - https://dictionary.archivists.org/entry/provenance.html
  - https://dictionary.archivists.org/entry/original-order.html
  - https://dictionary.archivists.org/entry/archival-integrity.html
  - https://dictionary.archivists.org/entry/authenticity.html
- Relevant observations:
  - significance can depend on context of creation, not subject/content alone;
  - creator-established order can itself carry evidential context;
  - integrity can apply to a body/aggregation of related records, not only bits of an individual object;
  - authenticity (being what it purports to be / untampered) does not imply truth/reliability of content.
- Research use: separates semantic/contextual integrity from mere bit fixity and separates authenticity from factual correctness.

### InterPARES terminology — `record`, `authentic record`

- Authority: International Research on Permanent Authentic Records in Electronic Systems.
- URLs:
  - https://www.interpares.org/ip2/ip2_terminology_db/record/1121
  - https://www.interpares.org/ip2/ip2_terminology_db/authentic-record/179
- Relevant observations:
  - record: document made/received in practical activity as instrument/by-product and set aside for action/reference;
  - authentic record: what it purports to be and free from tampering/corruption.
- Research use: diplomatics/activity-based counter-frame to generic `stored information`.

### InterPARES — Reliability, Accuracy, Authenticity of Digital Records

- URL: https://www.interpares.org/display_file/ip1-2_dissemination_ss_duranti_bog-ubc_2007.pdf
- Relevant observations:
  - reliability concerns trustworthiness as a statement of fact and creation procedure/completeness;
  - accuracy concerns correctness/precision of content;
  - authenticity concerns trustworthiness as a record, grounded in identity/integrity and freedom from tampering/corruption.
- Research use: critical separation of `authentic` from `true/correct`.
- Limitation: InterPARES/diplomatics framework is a specific archival theoretical tradition, so cross-frame support is required before generalising.

### International Council on Archives — Records in Contexts (RiC-CM / RiC-O)

- URLs:
  - https://www.ica.org/ica-network/expert-groups/egad/records-in-contexts-ric/
  - https://www.ica.org/ica-network/expert-groups/egad/records-in-contexts-conceptual-model/
  - https://www.ica.org/standards/RiC/ontology
- Relevant observations:
  - current archival conceptual model explicitly describes record resources together with contextual entities and relations;
  - focuses on identifying/describing records, their creators/users and activities they facilitate/document;
  - ontology supports graph-like relational description rather than only hierarchical arrangement.
- Research use: evidence that context/relations can be first-class descriptive structure; challenges a purely folder/hierarchy model.
- Vertical-isolation note: agent/activity semantics are evidence that records have relations, not authority to solve Actors/Work here.

## B. Information / metadata / identity

### Michael Buckland — `Information as Thing` (1991)

- Primary/preprint URL: https://people.ischool.berkeley.edu/~buckland/thing.html
- Publication record: https://asistdl.onlinelibrary.wiley.com/doi/abs/10.1002/%28SICI%291097-4571%28199106%2942%3A5%3C351%3A%3AAID-ASI5%3E3.0.CO%3B2-3
- Relevant observation: distinguishes information-as-process, information-as-knowledge and information-as-thing; `information-as-thing` can include data, text, documents, objects and events.
- Research use: warns against treating `information` as one ontological category and helps separate cognitive knowledge from storable/retrievable representations.

### Dublin Core Metadata Terms

- Authority: Dublin Core Metadata Initiative.
- URL: https://www.dublincore.org/specifications/dublin-core/dcmi-terms/
- Relevant observations: separates identifier, creator, created, modified, source, relation and provenance; identifier is an unambiguous reference within a context; provenance concerns significant ownership/custody changes affecting authenticity/integrity/interpretation.
- Research use: metadata dimensions needed to identify and contextualise resources are separable properties, not one generic metadata blob.

### RFC 8141 — Uniform Resource Names

- Authority: IETF.
- URL: https://datatracker.ietf.org/doc/rfc8141/
- Relevant observation: URNs are intended as persistent, location-independent resource identifiers.
- Research use: identity should not be conflated with storage location/address.
- Limitation: identifier persistence is an institutional/operational property as well as syntax; the RFC does not guarantee resource availability.

### DataCite — Versioning guidance

- URL: https://support.datacite.org/docs/versioning
- Relevant observation: minor changes may retain DOI with metadata update; major changes should receive a new DOI linked to the previous one; stewards decide major/minor boundaries.
- Research use: there is no universal identity/version boundary even in mature PID infrastructure; version semantics require policy/domain judgment.

### DataCite — connecting versions / related identifiers

- URL: https://support.datacite.org/docs/connecting-versions-with-related-identifiers
- Relevant observation: identical content at multiple locations and changed/versioned content are different identification problems.
- Research use: `same bytes/content`, `same resource`, `same version`, and `same location` must not be silently collapsed.

### NIST Research Data Framework (RDaF)

- Authority: NIST.
- URL: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/1500-18/NIST.SP.1500-18r2.html
- Relevant observations: provenance, chain of custody, persistent identifiers, versioning and metadata are distinct data-lifecycle concerns; poor metadata can render otherwise valuable data unusable after creators disappear.
- Research use: cross-domain support for provenance/context/findability as operational preservation properties.

## C. Provenance / derivation

### W3C PROV Primer

- Authority: W3C Recommendation family.
- URL: https://www.w3.org/TR/prov-primer/
- Relevant observations:
  - provenance describes origins and the entities/activities involved in producing/influencing an object;
  - provenance can support interpretation, trust judgement, compliance and reproducibility;
  - an evolving document, a particular version, and a stored instance can be modelled as distinct entities;
  - revision is derivation and can yield a new entity.
- Research use: formal counterexample to treating provenance as a free-text `source` field or treating all versions/representations as one entity.
- Vertical-isolation note: PROV includes agents/activities; only record-side implications are used here.

### NIST CSRC — provenance glossary

- URL: https://csrc.nist.gov/glossary/term/provenance
- Relevant observation: provenance can include chronology of origin, development, ownership, location and changes, plus personnel/processes modifying the object.
- Research use: independent security/data-management support for provenance as history/lineage rather than mere attribution.

## D. Digital preservation

### OAIS Reference Model (CCSDS 650.0)

- Authority: Consultative Committee for Space Data Systems; basis of ISO 14721.
- Accessible source used: https://pds-engineering.jpl.nasa.gov/wp-content/uploads/documents/pds2010/study/data_model/oais_reference_model_blue_book.pdf
- Additional CCSDS historical PDF: https://ccsds.org/Pubs/650x0b1s.pdf
- Relevant observations:
  - preserving a data object alone is insufficient; Representation Information is required to make it understandable to a designated community;
  - Preservation Description Information distinguishes Reference, Context, Provenance and Fixity information;
  - context includes why content was created and relations to other information;
  - provenance includes origin, changes and custody;
  - fixity detects undocumented alteration.
- Research use: strongest cross-disciplinary evidence that durable preservation is `bits + interpretation/context/history/integrity`, not storage alone.
- Limitation: long-term archival preservation frame; operational systems may need less metadata depending on horizon/risk.

### PREMIS Data Dictionary v3 — Library of Congress

- Authority: PREMIS Editorial Committee / Library of Congress maintenance activity.
- URLs:
  - https://www.loc.gov/standards/premis/v3/
  - https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf
- Relevant observations:
  - preservation model distinguishes Objects, Events, Rights and Agents;
  - object characteristics include fixity, size, format, creating application, significant properties;
  - fixity is information used to determine undocumented/unauthorised alteration.
- Research use: demonstrates preservation metadata needs object/event/history semantics and that bit-level integrity is only one preservation property.

### Library of Congress — Data Integrity Management

- URL: https://www.loc.gov/programs/digital-collections-management/inventory-and-custody/data-integrity-management/
- Relevant observation: fixity is generated early and checked over time to verify bit-level preservation.
- Research use: concrete distinction between bit fixity and broader authenticity/reliability/context.

## E. Findability / retrieval / reuse

### FAIR Guiding Principles (Wilkinson et al., 2016)

- Primary publication: https://www.nature.com/articles/sdata201618
- NIST summary: https://www.nist.gov/itl/ssd/information-systems-group/configurable-data-curation-system-cdcs/cdcs-help-and-resources-1
- Relevant observations:
  - findability requires persistent identifiers, rich metadata and registration/indexing in searchable resources;
  - accessibility is distinct from findability;
  - interoperability requires shared representation/vocabularies and qualified references;
  - reuse requires rich description, provenance and domain standards;
  - principles explicitly precede implementation choice.
- Research use: independent evidence that `stored` is far weaker than `findable/retrievable/reusable` and that these are distinct properties.
- Limitation: research-data stewardship goals; FAIR does not establish truth, authority, confidentiality or recordhood.

### Manning, Raghavan, Schütze — Introduction to Information Retrieval

- Stanford source: https://nlp.stanford.edu/IR-book/information-retrieval-book.html
- Relevant observation: IR is a separate discipline concerned with retrieval/indexing/ranking/evaluation; search systems are evaluated against information needs/relevance rather than mere storage availability.
- Research use: supports treating discoverability/retrieval as a distinct failure surface from preservation.

## F. State/history/time/version counter-frames

### Richard T. Snodgrass — Temporal Databases

- University of Arizona PDF: https://rts.cs.arizona.edu/pubs/LNCS639.pdf
- Relevant observation: valid time (when something holds in the modelled world) and transaction time (when it is stored/known to the database) can diverge; systems can need both.
- Research use: demonstrates that one `timestamp` is often semantically insufficient; correction of past knowledge differs from change in the world.

### Event Sourcing — Martin Fowler

- URL: https://www.martinfowler.com/eaaDev/EventSourcing.html
- Relevant observation: application state can be represented as current state or reconstructed from a sequence of events; storing change events supports historical reconstruction and replay.
- Research use: useful technical counter-frame for `state` versus `history/event record`.
- Limitation: software architecture pattern, not records theory and not evidence that event sourcing is universally preferable.

### SQL Server system-versioned temporal tables

- URL: https://learn.microsoft.com/en-us/sql/relational-databases/tables/temporal/overview
- Relevant observation: updates/deletes can preserve prior row values with system-time intervals and enable `AS OF` queries.
- Research use: concrete example showing current value and recorded history can coexist as different representations.
- Limitation: system/transaction time is not automatically real-world valid time, provenance, or record authenticity.

## G. Version-of-record / correction counterexample

### NISO RP-8-2008 Journal Article Versions

- Authority: NISO.
- URL: https://www.niso.org/publications/niso-rp-8-2008-jav
- Relevant observation: scholarly articles have named version states including Version of Record, Corrected Version of Record and Enhanced Version of Record.
- Research use: `authoritative` does not necessarily mean `never changes`; correction can preserve lineage while establishing a new authoritative version.

### Crossref — Version control, corrections and retractions

- URL: https://www.crossref.org/documentation/principles-practices/best-practices/versioning/
- Relevant observation: version control exists to distinguish drafts/versions and link corrections/retractions.
- Research use: correction/supersession should not be collapsed into destructive overwrite.

## H. Deliberate counter-evidence / limits

### Persistent identifiers are not magic persistence

- RFC 8141 defines persistent, location-independent naming intent, while empirical work such as Klein & Balakireva (2020) shows real-world DOI resolution/content consistency can still vary.
- Paper: https://arxiv.org/abs/2004.03011
- Research implication: identifier semantics and operational persistence/availability must be separated.

### Metadata can change and remain incomplete

- Strecker (2024), DataCite metadata change study: https://arxiv.org/abs/2412.05128
- Relevant observation: metadata records change incrementally and metadata completeness does not automatically improve through maintenance.
- Research implication: metadata is itself versioned/managed information; it should not be treated as timeless truth about an object.

### More metadata is not automatically more useful

- NIST RDaF notes richer metadata generally aids curation/findability/reuse, but actual usefulness depends on quality and context.
- A recent RAG study (2026) also reports that richer context/metadata can reduce model accuracy when not processable/aligned; this is retained only as a modern counter-signal, not a foundation claim: https://arxiv.org/abs/2606.29645
- Research implication: the goal is sufficient, trustworthy, interpretable metadata for a use/risk horizon—not maximal metadata accumulation.

## Coverage note

This ledger is deliberately not an exhaustive bibliography. The foundational pass seeks discriminating conceptual coverage across independent frames. Additional sources should be added when they can change a load-bearing distinction, resolve a contradiction, or attack a remaining frame risk—not merely increase source count.
