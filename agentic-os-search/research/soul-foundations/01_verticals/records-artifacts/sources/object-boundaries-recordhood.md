# Object Boundaries / Recordhood — Source Ledger

**Pass:** object boundaries  
**Accessed:** 2026-09-01  
**Role:** detailed source observations for the object-boundaries synthesis. This file is not itself a primary source.

## Source-selection logic

The pass deliberately combines traditions that draw object boundaries differently. A source is used for the distinction it can support, not as authority outside its own domain.

---

## S1 — National Archives (NARA), Records Basics

URL: https://www.archives.gov/records-mgmt/scheduling/basics

### Direct observations

- Federal record status is not defined by file format or originality.
- Information is a record when made/received in government business and preserved/appropriate for preservation for evidential or informational value.
- Extra copies kept only for convenience/reference can be non-records.
- A copy can itself be a record when used to conduct business or when it has a distinct function/purpose.
- Working drafts can be records when circulated for official purposes and containing unique substantive information.
- A digitized record can serve in place of a source record when sufficient authenticity, reliability, usability, and integrity are maintained.
- System outputs, including reports/data/query results, can themselves be records unless transitory.

### Relevance

Strong evidence that `record status` is not purely an intrinsic property of bits/content. Purpose, use, institutional control, and context can change record status without uniqueness changing.

### Limitation

This is U.S. federal legal/administrative guidance; it should not define universal record ontology by itself.

---

## S2 — InterPARES 2 Terminology Database, Record

URL: https://interpares.org/ip2/ip2_terminology_db/record/1121

### Direct observations

InterPARES aggregates several record definitions. Its own diplomatics definition describes a record as a document made/received during practical activity and set aside for action or reference. Other included archival definitions emphasize content + context + structure and evidence of activity.

### Relevance

Supports a record/activity/context relation and shows that archival terminology contains competing formulations rather than one uncontested definition.

---

## S3 — InterPARES, Record Characteristic / Archival Bond / Authentic Record

URLs:
- https://www.interpares.org/ip2/ip2_terminology_db/record-characteristic/1126
- https://www.interpares.org/ip2/ip2_terminology_db/archival-bond/109
- https://www.interpares.org/ip2/ip2_terminology_db/authentic-record/179

### Direct observations

- A diplomatics record-characteristics formulation includes fixed documentary form, stable content, archival bond, and identifiable context.
- Archival bond is the network of relationships a record has with records in the same aggregation.
- Authenticity is distinct from reliability: an authentic record is what it purports to be and is free from tampering/corruption; this does not by itself establish factual truth.

### Relevance

Provides the strongest `constitutive properties` counter-frame to a purely status-based definition.

### Limitation

Diplomatics deliberately protects a specific record-evidence tradition and may be too restrictive for some dynamic digital information environments.

---

## S4 — Society of American Archivists (SAA) Dictionary, Record / Recordness / Document

URLs:
- https://dictionary.archivists.org/entry/record.html
- https://dictionary.archivists.org/entry/recordness.html
- https://dictionary.archivists.org/entry/document.html

### Direct observations

- SAA's broad record entry includes information/data stored on a medium and used as memory/accountability support.
- `recordness` literature explicitly treats structural and contextual data as important to the quality of being a record, while also recording critiques of essentialist recordness.
- `document` is broader/ambiguous: information fixed in media can be a document but not necessarily part of an official record; a document may also be a record in evidential/legal contexts.

### Relevance

Shows that `document` and `record` are not safe synonyms and that recordhood is a contested theoretical boundary.

---

## S5 — Society of American Archivists Dictionary, Artifact

URL: https://dictionary.archivists.org/entry/artifact.html

### Direct observations

SAA uses `artifact` principally for:
- a physical human-made/modified object;
- a three-dimensional object in archives;
- a resource whose physical object has value independent of informational content.

The notes explicitly say artifacts may be preserved as records, implying artifact and record are not simple supertype/subtype synonyms.

### Relevance

Counter-evidence to using `artifact` as a neutral broad synonym for persistent information object.

---

## S6 — NIST Glossary, Artifact

URL: https://csrc.nist.gov/glossary/term/artifact

### Direct observations

NIST source-linked definitions include:
- a piece of evidence;
- work products produced/used during a project to capture and convey information, such as models or source code.

A separate NIST/OSAC forensic lexicon uses `artifact` for a by-product, artificial feature, or technical-process change/distortion.

Related URL: https://www.nist.gov/glossary-term/37031

### Relevance

Demonstrates severe cross-domain polysemy. `Artifact` can mean intended work product, evidence, physical object, or unintended technical by-product.

---

## S7 — Geoffrey Yeo, Records and Representations / later record theory synthesis

Primary paper copy surfaced at:
https://www.ucl.ac.uk/infostudies/geoffrey-yeo/representations.pdf

Secondary theoretical synthesis:
https://journal.kci.go.kr/ksas/archive/articleView?artiId=ART002436001

### Direct observations

Yeo's theory characterizes records as persistent representations of activities/other occurrents, created by participants/observers or authorized proxies. The later literature compares evidence, information, and representation frames and treats fixity, materiality, activity/context, and trustworthiness as key questions.

### Relevance

Offers a useful alternative to `record = stored information` and `record = evidence by definition`: record as persistent representation of an occurrence.

### Limitation

This is a theoretical definition, not universally accepted operational law or standard.

---

## S8 — ICA Records in Contexts Ontology (RiC-O) 1.1

URL: https://www.ica.org/standards/RiC/RiC-O_1-1.html

### Direct observations

RiC-O distinguishes:

- **Record Resource:** information produced/acquired and retained by an Agent in life/work activity.
- **Record:** discrete information content formed and inscribed at least once in persistent, recoverable form in life/work activity; always documents/is evidence of Activity.
- **Instantiation:** inscription of information on a physical carrier in persistent, recoverable form that communicates through time/space.

Important boundary notes:

- one Record Resource may have multiple simultaneous or successive Instantiations;
- DOCX, PDF/A, and print may concurrently instantiate one Record;
- a derived Instantiation may count as the same or a new Record depending on context;
- materiality can make a digitized copy functionally equivalent for one user but a different record for another;
- record / record-part / record-set boundaries can require contextual judgement;
- the standard explicitly distinguishes message/content (Record Resource) from physical representation (Instantiation).

### Relevance

This is the strongest current archival model supporting multi-level identity rather than file-level identity.

### Limitation

RiC is a descriptive archival standard; its classes should not be copied directly into a general-purpose system without separate justification.

---

## S9 — W3C Web Architecture / RFC 9110 — Resource vs Representation

URLs:
- https://www.w3.org/TR/webarch/
- https://www.rfc-editor.org/rfc/rfc9110.html

### Direct observations

- Web architecture separates the identified `resource` from transferable `representations` of resource state.
- One resource can have multiple representations.
- Identifiers should be stable across changes in representation/state when they still designate the same resource.
- HTTP representation is information intended to reflect past/current/desired state of a resource.

### Relevance

Independent technical evidence that `thing identity` and `serialized/file representation` need not be the same layer.

### Limitation

HTTP/Web resources are interaction abstractions, not archival records.

---

## S10 — W3C PROV — Revision / Alternate / Specialization

URLs:
- https://www.w3.org/TR/prov-primer/
- https://www.w3.org/TR/2013/REC-prov-o-20130430/
- https://www.w3.org/TR/2012/CR-prov-dm-20121211/Overview.html

### Direct observations

- A revision is a derivation; the result of each revision is a new PROV Entity.
- `specializationOf` can relate a version/time/context-specific entity to a more general entity.
- `alternateOf` can relate different entities that present aspects of the same thing, including different serializations/formats.

### Relevance

Provides a neutral provenance vocabulary showing how `same broader thing` and `distinct version entities` can coexist without collapsing identity.

---

## S11 — DataCite Versioning Guidance

URL: https://support.datacite.org/docs/versioning

### Direct observations

- Minor changes may retain a DOI while updating version metadata.
- Major changes are recommended to receive a new DOI linked to previous versions.
- DataCite distinguishes a canonical DOI representing a resource across versions from version-specific DOIs.

### Relevance

Operational evidence for two identity levels: conceptual/canonical resource identity and version-specific identity.

### Limitation

Major/minor thresholds are steward-defined; DOI practice is policy, not ontology proof.

---

## S12 — Crossref / NISO scholarly version and correction practice

URLs:
- https://www.crossref.org/documentation/principles-practices/best-practices/versioning/
- https://www.niso.org/publications/rp-8-2008-jav
- https://www.niso.org/publications/rp-45-2024-crec

### Direct observations

- Crossref separates preprint, accepted/version-of-record, and materially updated versions and recommends explicit relationships.
- Significant post-publication change should be communicated by a notice; materially updated versions can receive new DOIs.
- NISO JAV distinguishes Version of Record, Corrected Version of Record, and Enhanced Version of Record.
- NISO CREC emphasizes that retraction/removal/concern status must remain visible to both humans and machines rather than allowing an invalidated original to appear silently current.

### Relevance

Supports explicit change/status relations and preserving historical identity instead of silent overwrite when interpretation/status materially changes.

---

## S13 — SAA Digital Object / Information Object

URLs:
- https://dictionary.archivists.org/entry/digital-object.html
- https://dictionary.archivists.org/entry/information-object.html

### Direct observations

- `digital object` is often defined as digital information together with associated metadata and can be simple or complex.
- SAA explicitly notes that drawing boundaries around digital objects is difficult and context-dependent.
- `information object` can be used as a broad digital-object synonym but is also used for archival records in some literature.

### Relevance

Useful neutral-ish candidate family, but the terminology is itself not semantically clean enough to adopt without qualification.

---

## Cross-source observations

### Strong convergence

1. **File/bit identity is not sufficient record identity.** ICA, Web architecture, PROV, DataCite, and scholarly versioning all independently separate some higher-level identity from a specific serialization/copy/version.
2. **Recordhood has contextual semantics.** NARA copy/draft rules and RiC boundary notes make this explicit; Yeo/InterPARES also tie recordhood to activity/context.
3. **Persistence is necessary but insufficient.** Persistent information can be a reference copy, publication stock, museum/library material, web representation, or other non-record depending on the frame.
4. **Change must be typed.** Copy, format representation, revision, correction, retraction, and derivation are not one generic `update` operation.
5. **Aggregation can be meaningful.** Archival bond / Record Set semantics mean ordering/context/relationships can carry meaning beyond member content.

### Material disagreement / unresolved frame

- Some record definitions emphasize evidence/information value and institutional record status; others try to state constitutive record properties; Yeo emphasizes persistent representation of occurrences.
- RiC deliberately allows contextual judgement about same-versus-new record across instantiations; there is no universal content-change threshold in the source corpus.
- DataCite explicitly delegates major/minor version thresholds to stewards, reinforcing that version-identity policy is partly domain-dependent.

## Source-fidelity note

These sources support distinctions and counterexamples. They do not jointly establish a universal ontology or a SOUL schema. The synthesis must preserve where a conclusion is cross-source inference rather than a source definition.