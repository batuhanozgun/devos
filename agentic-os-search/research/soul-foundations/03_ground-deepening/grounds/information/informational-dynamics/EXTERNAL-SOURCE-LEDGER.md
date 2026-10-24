# Informational Dynamics / Formation–Transformation — External Source Ledger

**Status:** N5 source ledger  
**Date:** 2026-09-05  
**Role:** source routes and bounded structural use; not imported taxonomy

| Source / tradition | Primary source | Dynamics use | Boundary / caution |
|---|---|---|---|
| JCGM/BIPM VIM — measurement | https://jcgm.bipm.org/vim/en/2.1.html | measurement is a process experimentally obtaining values; supports Formation/Acquisition as distinct from result | metrology vocabulary is domain-specific |
| JCGM/BIPM VIM — measurand | https://jcgm.bipm.org/vim/en/2.3.html | intended target may differ from what is actually measured; measurement system can affect phenomenon; strong acquisition-boundary falsifier | actual target remains Environment-side when focal |
| JCGM/BIPM VIM — measurement result | https://jcgm.bipm.org/vim/en/2.9.html | result is values attributed to measurand plus relevant information; process/result distinction | result constitution belongs State |
| W3C PROV-DM | https://www.w3.org/TR/prov-dm/ | entity/activity, generation, use, invalidation and derivation distinctions; strong Formation vs Derivation evidence | PROV `communication` has provenance-specific semantics; do not equate mechanically with Selection/Exposure |
| W3C PROV Constraints | https://www.w3.org/TR/prov-constraints/ | ordering/lifetime constraints among generation, use, derivation and invalidation | provenance formalism is not universal Dynamics ontology |
| Stanford Encyclopedia — Logic of Belief Revision | https://plato.stanford.edu/entries/logic-belief-revision/ | belief state/database vs contraction, expansion, revision, update; strong state-to-state change specialization | epistemic-agent domain; not universal fourth child |
| NIST TREC — How To TREC | https://trec.nist.gov/howto.html | topic/information need → query → ranked retrieval output; strong Selection/Exposure evidence | relevance is task/use-relative rather than intrinsic source type |
| NIST TREC relevance judgments | https://trec.nist.gov/data/reljudge_eng.html | retrieval completeness/relevance relative to topic and collection; omission/coverage pressure | test-collection semantics do not imply production guarantees |
| W3C Web Annotation Data Model | https://www.w3.org/TR/annotation-model/ | Selector identifies segment of source; State helps retrieve intended representation/version; strong source-vs-selected-specific-resource distinction | annotation-specific representation model, not Foundation taxonomy |
| NARA Records Basics | https://www.archives.gov/records-mgmt/scheduling/basics | creation/receipt, maintenance/use, disposition lifecycle; persistence-specific holdout | records lifecycle is explicitly records-management specialization |
| 44 U.S.C. Chapter 29 via NARA | https://www.archives.gov/about/laws/records-management.html | creation, maintenance/use (including retrieval), disposition are legally defined records-management activities | legal/persistence scope; do not universalize |

## Structural evidence summary

The sources are intentionally heterogeneous. Their value is convergence on problem distinctions, not shared vocabulary.

### Formation / Acquisition

VIM independently separates a measurement process from a measurement result and shows that the relation between intended target, procedure, system and observed result can itself fail. This is a strong holdout for a first-order formation/acquisition problem region.

### Derivation / Transformation

PROV distinguishes generation from derivation and activities from entities. Belief-revision theory independently distinguishes a maintained state/base from operations that change it. These traditions support a state-to-state change region without requiring revision itself to be a universal peer child.

### Selection / Exposure

TREC treats an information need/topic, query and ranked retrieval run as distinct surfaces, with relevance judged relative to the topic. Web Annotation separately models a source resource, a Selector that determines a segment, and State information used to retrieve an intended representation. These traditions support a problem region in which source information can remain intact while the selected/exposed representation changes.

### Persistence / lifecycle

NARA's creation/maintenance-use/disposition structure is meaningful precisely within records management. It demonstrates that persistence creates specialized lifecycle obligations but does not establish a universal fourth Dynamics child.

## Freshness / authority note

Standards and archival definitions above are stable structural sources; exact current wording should still be rechecked if later used for normative or implementation-level claims. The 2026 Stanford Encyclopedia revision was current at research time. NIST TREC pages describe evaluation/retrieval conventions, not a universal theory of relevance.
