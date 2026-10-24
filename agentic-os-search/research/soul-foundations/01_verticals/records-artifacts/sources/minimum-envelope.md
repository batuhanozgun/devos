# Source Ledger — Minimum Persistent-Information / Record Envelope

**Status:** pass-specific source ledger  
**Date:** 2026-09-01  
**Scope:** Records / persistent-information vertical only.

This ledger records the primary/authoritative sources used to test what information obligations must survive with, or remain recoverably linked to, persistent information resources. It is not itself a primary source.

## S1 — ISO 23081-1:2017 — Metadata for records — Principles

**Source:** International Organization for Standardization, ISO 23081-1:2017.  
**URL:** https://www.iso.org/standard/73172.html  
**Supplementary ISO committee description:** https://committee.iso.org/sites/tc46sc11/home/projects/published/iso-23081-metadata-for-records.html

### Direct observations

- The standard covers principles governing records-management metadata for records, processes affecting them, systems in which they reside, and responsible organizations.
- ISO committee guidance describes the key requirement as retaining enough metadata to show that an electronic object has been managed as a record through events affecting its existence and to interpret it in the context of business and people.
- The same guidance links record metadata to assertions concerning integrity, authenticity, reliability, and usability.

### Relevance

Supports a **context/history obligation** broader than static descriptive fields. It also warns against treating metadata solely as description of payload content.

### Limit

The public ISO page does not expose the full normative text. Exact clause-level claims require the standard itself; this research uses only public abstract/committee guidance for load-bearing statements.

---

## S2 — CCSDS 650.0-M-3 / ISO 14721:2025 — OAIS Reference Model

**Primary public source:** CCSDS 650.0-M-3, Issue 3, December 2024.  
**URL:** https://ccsds.org/Pubs/650x0m3.pdf  
**ISO landing page:** https://www.iso.org/standard/87471.html

### Direct observations

- OAIS separates Content Data Object from **Representation Information** needed to interpret/understand the data.
- Representation Information can include structure, semantics, software, algorithms, encryption information, instructions, and recursive dependencies; the required extent depends on the Designated Community and its Knowledge Base.
- For an Archival Information Package, all classes of Preservation Description Information (PDI) must be present: **Reference, Provenance, Context, Fixity, Access Rights**. The specific contents of each class are left to the individual Archive.
- OAIS states that a provenance statement such as creator unknown can be adequate in one archive while another may require deeper research.
- OAIS introduces explicit **Preservation Objectives** and notes that their definition can change as the Designated Community/knowledge base changes.
- It also calls for preserving Transformational Information Properties relevant to checking whether preservation objectives survive transformations.
- Representation Information may be referenced rather than physically embedded, but the archive must obtain it or track availability so it remains understandable.

### Relevance

Strong evidence that:

1. interpretability is relative to a future audience/knowledge base;
2. preservation requires several obligation families rather than one metadata list;
3. the **detail** needed inside each family is context-dependent;
4. external linkage can satisfy an obligation only while the linked information remains reliably recoverable;
5. preservation objectives/significant properties are a missing framing variable in a simple envelope model.

### Limit

OAIS is deliberately an archival long-term reference model. It should not be used to require archival-level metadata for all session/project-scale information.

---

## S3 — PREMIS Data Dictionary for Preservation Metadata 3.0

**Source:** Library of Congress PREMIS Preservation Metadata Maintenance Activity.  
**Landing page:** https://www.loc.gov/standards/premis/v3/  
**Hierarchical semantic units:** https://www.loc.gov/standards/premis/v3/premis-hierarchical-3-0.html  
**Data Dictionary:** https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf

### Direct observations

- PREMIS models Objects, Events, Agents, and Rights and records relationships among them.
- Object identifier and object category are mandatory; for file/bitstream objects object characteristics include mandatory format knowledge, while fixity is optional.
- Relationships and event links are explicitly modeled, but many are optional because relevance depends on the object/repository situation.
- PREMIS defines mandatory as information a preservation repository **needs to know**, not necessarily a value that must be redundantly stored on every object. It may be known through business rules or another mechanism.
- Descriptive metadata may be stored inside a repository or linked from outside it; PREMIS intentionally focuses on preservation metadata rather than duplicating all descriptive metadata.
- PREMIS's practical definition of `core` is what most working preservation repositories are likely to need, not metadata absolutely required under every circumstance.

### Relevance

Directly challenges `minimum envelope = fields physically attached to every record`.

It supports separating:

- **semantic obligation / need-to-know** from
- **storage location / serialization / repeated field**.

It also shows that preservation-relevant categories have applicability conditions by object type and preservation strategy.

### Limit

PREMIS is focused on digital preservation repositories. Its mandatory/optional designations should not be promoted directly to general-purpose Records requirements.

---

## S4 — NARA Bulletin 2015-04 — Minimum metadata for permanent electronic records

**Source:** U.S. National Archives and Records Administration.  
**Bulletin:** https://www.archives.gov/records-mgmt/bulletins/2015/2015-04.html  
**Appendix A:** https://www.archives.gov/records-mgmt/bulletins/2015/2015-04-appendix-a.html  
**Current compiled requirements page:** https://www.archives.gov/records-mgmt/policy/metadata-compiled

### Direct observations

NARA defines a minimum transfer-level/file-item metadata profile for **permanent** electronic records because documentation must remain adequate to identify, service, and interpret them for as long as needed.

The common file/item minimum includes:

- File Name;
- Record ID;
- Title;
- Description;
- Creator;
- Creation Date;
- Rights.

Coverage and Relation are mandatory when applicable.

NARA explicitly states metadata may be:

- embedded in individual files;
- held in a records-management application;
- or both.

The bulletin also says additional documentation/metadata is required for specific record types.

### Relevance

Provides a concrete operational `minimum`, but only for a defined objective/horizon: permanent-record transfer to NARA.

It provides direct evidence that:

- minimum profiles are purpose-specific;
- relation metadata is conditional;
- metadata does not have to be intrinsic to the payload/object.

### Limit

A U.S. federal transfer profile is not a universal record ontology or minimum for all persistent information.

---

## S5 — NARA Bulletin 2025-01 — Classified-record metadata

**Source:** U.S. National Archives and Records Administration.  
**URL:** https://www.archives.gov/records-mgmt/bulletins/2025/2025-01

### Direct observation

Permanent classified electronic records need additional classification/security metadata beyond the general transfer minimum so NARA can preserve, protect, review, and declassify them appropriately.

### Relevance

A direct counterexample to a universal fixed minimum: the same archival horizon receives additional obligations because resource/control class differs.

### Limit

Classified federal records are a special high-control case.

---

## S6 — National Archives of Australia — Minimum metadata set

**Source:** National Archives of Australia (NAA), Australian Government Recordkeeping Metadata Standard (AGRkMS) minimum metadata set.  
**URL:** https://www.naa.gov.au/information-management/standards/australian-government-recordkeeping-metadata-standard/minimum-metadata-set

### Direct observations

NAA explicitly makes its minimum set **cumulative** and says the value and expected longevity of information determine how much metadata must be kept.

Its levels are:

- **Core — all records:** Identifier, Creator, Date Created.
- **Additional — higher-value / long-term:** Title, Protective Marking, Disposal Class, Format.
- **Transfer — archival value or transfer:** Rights, Integrity Check.

NAA also says common metadata can sometimes be represented at aggregate/system governance level rather than redundantly against each individual record.

Examples:

- one disposal class for all information in a system can live in governance documentation or an information asset register;
- identifiers can preserve older IDs after migration for cross-referencing;
- creation date should not be overwritten by later closure/migration/modification dates.

### Relevance

This is the strongest direct evidence in the pass for a **profiled minimum**:

- some obligations apply broadly;
- others grow with expected longevity/value/transfer needs;
- common metadata can live externally at an aggregate/system level if the linkage/context is reliable.

### Limit

NAA's minimum serves Australian Government business records and policy obligations; it is not automatically the minimum for other persistent-information classes.

---

## S7 — DataCite Metadata Schema 4.7

**Source:** DataCite Metadata Working Group, Schema 4.7 (released 3 March 2026).  
**Schema:** https://schema.datacite.org/meta/kernel-4/  
**Property overview:** https://datacite-metadata-schema.readthedocs.io/en/4.7/properties/overview/

### Direct observations

DataCite describes its core metadata as supporting accurate/consistent **identification, citation, and retrieval** of research resources.

Mandatory properties in 4.7 are:

- Identifier;
- Creator;
- Title;
- Publisher;
- PublicationYear;
- ResourceType.

Many other properties important to richer reuse/provenance/relations are recommended or optional.

### Relevance

A strong counterexample to universalizing any particular metadata minimum. DataCite has a valid minimum for **citation/identification**, but that minimum omits many things an archival preservation system needs (e.g. fixity and full representation information).

`Minimum` is therefore relative to the protected capability.

### Limit

DataCite is a citation/registration schema, not a records-management or long-term preservation standard.

---

## S8 — FAIR Guiding Principles

**Primary publication:** Wilkinson et al., Scientific Data 3, 160018 (2016).  
**DOI:** https://doi.org/10.1038/sdata.2016.18  
**Accessible principles:** https://www.go-fair.org/fair-principles/

### Direct observations

FAIR requires, at the principle level:

- persistent/global identifiers;
- rich metadata;
- metadata explicitly linked to the identifier of the described data;
- registration/indexing in a searchable resource;
- standardized retrieval;
- metadata remaining accessible even when the data are gone;
- formal/shared representation languages and qualified references;
- detailed provenance;
- clear usage licenses;
- domain-relevant community standards.

### Relevance

FAIR separates **data**, **metadata**, and **infrastructure** and explicitly allows metadata to outlive the data. It therefore supports treating findability/access/reuse as a system-level closure rather than requiring all information inside one serialized object.

It also shows that reuse metadata must be community/domain relevant rather than universally identical.

### Limit

FAIR is a set of guiding principles for data stewardship, not a record authenticity or archival-preservation standard.

---

## S9 — W3C PROV

**Source:** W3C PROV Model Primer.  
**URL:** https://www.w3.org/TR/prov-primer/

### Direct observations

PROV models entities, activities, and agents and supports generation, usage, derivation, attribution, association, and version/alternate perspectives.

It explicitly notes that provenance can support:

- understanding collection/generation;
- ownership/rights questions;
- trust judgements;
- process-compliance checks;
- reproduction of generation history.

### Relevance

Supports provenance as a **relational/history obligation**, not necessarily payload metadata. Also reinforces that version-specific and evolving-resource identities can be distinct provenance entities.

### Limit

Provenance alone does not establish factual truth, current authority, fixity, or semantic interpretability.

---

## S10 — ICA Records in Contexts (RiC-O 1.1)

**Source:** International Council on Archives, Records in Contexts Ontology 1.1.  
**URL:** https://www.ica.org/standards/RiC/RiC-O_1-1.html

### Direct observations

RiC explicitly models relationships among Record Resources/Instantiations, Agents, Activities, places, dates, and other contextual entities. A record may have many instantiations and provenance may connect record resources/instantiations to agents or activities.

### Relevance

Supports the proposition that essential context may exist in a **relationship graph around a resource**, not as intrinsic fields in the payload.

### Limit

RiC is an archival description/context ontology. It does not define a universal minimum preservation metadata profile.

---

# Cross-source evidence table

| Candidate obligation | Strong supporting lenses | Main qualification |
|---|---|---|
| Reference / identity | OAIS, PREMIS, NARA, NAA, DataCite, FAIR | Identifier scheme/scope may be inherited rather than repeated per object |
| Origin / provenance | ISO 23081, OAIS, NARA, NAA, FAIR, PROV, RiC | Required detail varies; explicit `unknown` can sometimes be adequate |
| Temporal anchor/history | ISO 23081, NARA, NAA, PREMIS Events, PROV | Which time axes matter depends on change/use semantics |
| Interpretability / representation | OAIS, PREMIS, NARA | Explicit representation info increases with horizon/complexity; common knowledge can be inherited/referenced |
| Context / relations | ISO 23081, OAIS, NARA, FAIR, RiC | Relation information is often conditional on actual dependencies/aggregations |
| Integrity / fixity evidence | OAIS, PREMIS, NAA Transfer | Explicit per-object fixity is not universal; may be conditional or supplied by repository controls |
| Rights / access constraints | OAIS, NARA, NAA Transfer, FAIR license | Conditional on legal/access/use situation; nevertheless essential when restrictions/permissions matter |
| Discovery / retrievability | NARA, NAA, DataCite, FAIR | Search metadata depends on retrieval mode; known-item access can need less than semantic discovery |
| Preservation objective / significant properties | OAIS, PREMIS | Becomes critical under long-term preservation/transformation; not ordinary per-object descriptive metadata |
| Lifecycle/disposition | NAA, records-management context | Management requirement, but not always needed for interpreting/reusing the information itself |

# Important source-derived challenge to the original frame

The original candidate list treated `minimum envelope` as if the main question were which properties should accompany each object.

The sources repeatedly show a more general structure:

> **The system must know and preserve enough information to discharge a future-use/preservation obligation; that information may be intrinsic, externally linked, inherited from a stable context, represented at aggregate level, or reconstructed from controlled system state.**

Therefore the pass should evaluate **semantic/preservation closure**, not only object-local metadata fields.