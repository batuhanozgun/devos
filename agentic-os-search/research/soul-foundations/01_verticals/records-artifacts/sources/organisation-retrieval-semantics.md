# Source Ledger — Organisation / Derived Views / Retrieval Semantics

**Pass:** organisation / derived views / retrieval semantics  
**Access date:** 2026-09-01  
**Status:** source ledger; not synthesis

## Source-selection rule

Prefer standards, current archival/records guidance, primary specifications and foundational information-retrieval literature. Technical products are used only as concrete counterexamples for stale/derived-view semantics, not as architecture recommendations.

---

## 1. ICA Records in Contexts Ontology (RiC-O) 1.1

Source:
- https://www.ica.org/standards/RiC/RiC-O_1-1.html

Observed:
- A `RecordSet` is a contextual grouping based on shared attributes or relations.
- Grouping can reflect formal classification, archival arrangement, or another purpose such as a researcher's selection.
- A Record or Record Set may simultaneously belong to more than one Record Set and may belong to an indeterminate number of Record Sets over time and across contexts.
- Records/sets may be ordered using different criteria.
- RiC models explicit relations among Record Resources, Instantiations and contextual entities.

Research use:
- Strong counterexample to `one record = one exclusive hierarchy/location`.
- Supports treating grouping/membership/order as contextual relations rather than assuming one intrinsic navigation tree.
- Some groupings preserve provenance/evidential context; others are purpose-specific access organisations.

Limitation:
- Archival-description ontology, not a universal search/retrieval architecture.

---

## 2. SAA Dictionary — provenance / original order / archival bond / arrangement

Sources:
- https://dictionary.archivists.org/entry/provenance.html
- https://dictionary.archivists.org/entry/original-order.html
- https://dictionary.archivists.org/entry/archival-bond.html
- https://dictionary.archivists.org/entry/arrangement.html

Observed:
- Provenance and original order protect contextual relationships of records.
- Archival bond concerns interrelationships among records arising from the same activity.
- Original order can reveal significance and usability but is not treated as sacrosanct in every situation.
- Archival practice can preserve original/contextual organisation while adding catalogues, indexes or alternative descriptions for access.

Research use:
- Context-preserving organisation and access organisation must not be collapsed.
- Reorganisation for subject/access purposes can obscure provenance if treated as replacement rather than an additional view.

Limitation:
- Dictionary synthesises archival usage and historical quotations; individual citations are not one normative standard.

---

## 3. SAA Dictionary — description / finding aid / intellectual access

Sources:
- https://dictionary.archivists.org/entry/description.html
- https://dictionary.archivists.org/entry/finding-aid.html
- https://dictionary.archivists.org/entry/intellectual-access.html
- https://dictionary.archivists.org/entry/multilevel-description.html

Observed:
- Archival description is a representation of an archival resource used to identify it and explain context.
- A finding aid is an access tool / representation or surrogate of the material being described.
- Multiple kinds of finding aids/access tools can exist for different purposes/audiences.
- Multilevel description can describe whole and parts without repeating all information at every level.

Research use:
- Access descriptions are derived representations/surrogates, not automatically the described resource itself.
- Access information can be intentionally selective/coarse and therefore a retrieval miss at one descriptive level cannot imply resource absence.
- Inheritance/linked descriptions can satisfy access needs without duplicating all context on each item.

---

## 4. W3C SKOS Reference

Source:
- https://www.w3.org/TR/skos-reference/

Observed:
- Knowledge-organisation systems can use concept schemes, preferred/alternative labels, hierarchical and associative relations, collections and ordered collections.
- Concepts can be mapped across different schemes using exact/close/broader/narrower mapping relations.
- Transitive broader/narrower relations can be used for query expansion to improve recall.
- SKOS distinguishes concepts from collections and does not imply that one concept scheme is the intrinsic structure of described resources.

Research use:
- Descriptive/knowledge organisation is a separate layer from record provenance/context relations.
- Multiple schemes and mappings can coexist.
- Organisational inference/query expansion can improve recall but also changes retrieval behaviour; inferred access relations should not be confused with original record relations.

---

## 5. OAIS Reference Model — CCSDS 650.0-M-3 (December 2024)

Primary source:
- https://ccsds.org/Pubs/650x0m3.pdf

Relevant locations reviewed:
- 2.3.4 Information Package Variants, p. 2-7;
- 4.3.3 access/package-description material, especially pp. 4-44–4-45;
- Access Collections, p. 4-53;
- Access functional entity / federated finding-aid discussion.

Observed:
- OAIS explicitly distinguishes information preserved by the archive (AIP) from dissemination packages (DIP); dissemination may omit some preservation information and can be organised differently.
- Descriptive Information is used to discover the package containing the object of interest.
- Package Descriptions can have multiple Associated Descriptions for different Access Aids.
- Finding Aids help locate information; Retrieval Aids retrieve identified content; these are different functions.
- Package Description is needed for visibility/access but is not itself required for long-term preservation of the Content Information.
- Access Collections can be transient/purpose-specific and may even be based on unverified pattern-recognition/data-mining results.
- If an Access Collection becomes valuable for long-term preservation, additional Content Information/PDI can be stored to create a new preserved collection.

Research use:
- Strongest primary-source counterexample to `preserved representation = access view`.
- Supports multiple access descriptions over the same preserved information.
- Derived/access organisation can remain ephemeral, or can later become independently preserved information; `derived` is not a permanent non-record status.
- Finding, retrieving, ordering and disseminating are separable access functions.

Limitation:
- Long-term archive reference model; not a general operational search specification.

---

## 6. FAIR Data Principles — NIST summary

Source:
- https://www.nist.gov/itl/ssd/information-systems-group/configurable-data-curation-system-cdcs/cdcs-help-and-resources-1

Observed:
- Findability includes persistent identifiers, rich metadata, explicit metadata→data identifier binding and registration/indexing in searchable resources.
- Accessibility requires retrieval by identifier through a protocol.
- Metadata should remain accessible even when underlying data are no longer available.
- Qualified references support interoperability.

Research use:
- Source identity/binding, indexing and actual accessibility are different guarantees.
- Discovery metadata may have a lifecycle distinct from the underlying content.

Limitation:
- Research-data stewardship principles, not recordkeeping ontology; does not establish authority/currentness/truth.

---

## 7. Manning, Raghavan, Schütze — Introduction to Information Retrieval

Sources:
- https://nlp.stanford.edu/IR-book/
- https://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-unranked-retrieval-sets-1.html
- relevant web-search query-needs material in chapter 19.

Observed:
- Precision measures the proportion of retrieved items that are relevant; recall measures the proportion of relevant items that are retrieved.
- False negatives are inherent in imperfect retrieval; high-recall tasks tolerate lower precision.
- Different uses value precision/recall differently: ordinary web search often emphasises precision at top results, while professional searchers may require high recall.
- Navigational queries target a specific known destination; informational queries seek broader information.
- Relevance is an evaluation relation to an information need, not a statement of record authority, currentness or factual truth.

Research use:
- `search` is not one retrieval requirement.
- A retrieval miss cannot establish absence unless coverage/recall is strong enough for the claim.
- A retrieval hit establishes, at most, retrieval under the mechanism/relevance criterion; identity/currentness/standing still require separate checks.

Limitation:
- General IR textbook; not records-management guidance.

---

## 8. Library of Congress Catalog search guidance

Source:
- https://guides.loc.gov/c.php?g=1472768&p=10988945

Observed:
- Basic search is particularly suited to known author/title/identifier cases.
- Keyword/subject/faceted search supports different discovery needs.

Research use:
- Concrete current example that known-item and exploratory/attribute retrieval are operationally distinct user intents.

---

## 9. RFC 7089 — Memento

Source:
- https://www.rfc-editor.org/rfc/rfc7089.html

Observed:
- Separates an Original Resource, fixed Mementos of prior states, a TimeGate for datetime negotiation and a TimeMap listing known prior states.
- A TimeMap enumerates Mementos known to the responding server; distributed archives may each know only versions they hold.
- Historical retrieval is explicitly a different access question from dereferencing the resource's present state.

Research use:
- Strong primary counterexample to `one current URI/search result is enough for historical retrieval`.
- Historical/as-of retrieval requires explicit state/time binding and coverage awareness.
- A list of known historical states is not automatically proof that no other historical state exists outside the server's knowledge.

Limitation:
- HTTP web-resource framework; semantically useful countermodel, not mandatory Records implementation.

---

## 10. W3C PROV Primer

Source:
- https://www.w3.org/TR/prov-primer/

Observed:
- Provenance represents entities and their derivation/revision relations.
- Derivation says an entity's existence/content/characteristics are partly due to another entity.
- Revision is a specialised derivation and produces a new entity in PROV.

Research use:
- Provenance traversal is a different retrieval operation from text/topic search.
- Derived views/resources need source/version binding and derivation semantics if lineage matters.

Boundary:
- Agent/activity ownership remains cross-vertical where necessary.

---

## 11. NARA — Records Basics / GRS output-record guidance

Sources:
- https://www.archives.gov/records-mgmt/scheduling/basics
- https://www.archives.gov/records-mgmt/grs/faqs.html
- https://www.archives.gov/records-mgmt/grs/faqs-for-grs-5-1

Observed:
- Recordkeeping copy/status is not identical to uniqueness or byte identity; copies can be records for different purposes.
- Agencies distinguish recordkeeping copies from non-recordkeeping copies even when both are records.
- Query results, reports and data extracts can themselves be output records depending on purpose/use; some are transitory, some require separate scheduling.

Research use:
- `canonical/source-bearing` should not be modeled as `the only record`.
- A derived output can be an access view relative to its source and simultaneously be a record in its own right.
- Source relation, recordkeeping designation and independent recordhood are separate axes.

Limitation:
- U.S. federal recordkeeping context.

---

## 12. RFC 9111 — HTTP Caching

Source:
- https://www.rfc-editor.org/rfc/rfc9111.html

Observed:
- Cache responses have explicit freshness/staleness semantics and may require validation against origin.
- Stale responses can be served only under controlled conditions.
- `Age` signals time since origin generation/validation.

Research use:
- Concrete architecture-independent lesson: a derived access representation can intentionally lag while remaining semantically safe if freshness/validation semantics are explicit.
- `must update synchronously` is not the only safe model.

Limitation:
- HTTP caching semantics, not records-management semantics.

---

## 13. PostgreSQL materialized-view documentation

Sources:
- https://www.postgresql.org/docs/current/sql-creatematerializedview.html
- https://www.postgresql.org/docs/current/rules-materializedviews.html
- https://www.postgresql.org/docs/current/sql-refreshmaterializedview.html

Observed:
- Materialized views persist the result of a query and remember the defining query.
- Their contents are regenerated by explicit refresh and can therefore differ temporally from source tables between refreshes.
- PostgreSQL materialized views are not directly updated.

Research use:
- Concrete example of a persisted derived projection whose derivation definition and refresh semantics matter.
- Non-editability can prevent one divergence class, but is a mechanism choice, not a universal requirement.

---

## 14. Elasticsearch near-real-time search documentation

Source:
- https://www.elastic.co/docs/manage-data/data-store/near-real-time-search

Observed:
- Stored/indexed changes do not become visible to search immediately; refresh controls visibility.
- Search is explicitly near-real-time rather than necessarily real-time.

Research use:
- Concrete independent example showing `source changed` and `search view reflects change` are separate moments.
- Retrieval/currentness semantics need an explicit freshness/visibility contract where the use depends on current standing.

Limitation:
- Product documentation; used only to demonstrate a general failure surface.

---

## Cross-source observation — provisional

The source set supports at least four distinct organisation/access roles:

1. **context relations** that preserve provenance, aggregation/order and interpretive structure;
2. **descriptive/knowledge organisation** that supplies labels, subjects, taxonomies and conceptual mappings;
3. **access projections/views** that are optimised for finding, filtering, ranking or navigating information;
4. **source/recordkeeping binding** that identifies the exact resource/version/standing to which a description/view refers.

The evidence also indicates that a derived access object may later acquire independent recordhood. Therefore these roles are relational/status dimensions, not mutually exclusive object classes.