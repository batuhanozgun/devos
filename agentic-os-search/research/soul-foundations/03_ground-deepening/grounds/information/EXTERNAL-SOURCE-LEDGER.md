# Information / Representation — External Source Ledger

**Status:** top-level node external source ledger COMPLETE for bounded N1–N6 pass  
**Date:** 2026-09-04

This ledger records why each external source was used. It does **not** make any source taxonomy authoritative for SOUL Foundations.

| Source | Tradition / role | Decision-relevant use |
|---|---|---|
| Kaelbling, Littman & Cassandra (1998), *Planning and acting in partially observable stochastic domains*, DOI `10.1016/S0004-3702(98)00023-X` | decision/control theory | independent separation of underlying state, observation and belief/state estimate |
| Kaelbling, POMDP state-estimator discussion, https://www.cs.cmu.edu/afs/cs/project/jair/pub/volume4/kaelbling96a-html/node56.html | control/agent modelling | accessible explanation of belief state as estimate over environment states from observations/history |
| Cassandra et al. POMDP retrospective, https://cassandra.org/arc/talks/aaai2013/index.html | control/agent modelling | action/observation/belief distinctions; observation may inform without directly changing state |
| JCGM/BIPM VIM 3, 2.1 `measurement`, https://jcgm.bipm.org/vim/en/2.1.html | metrology | measurement as a process; external structural support for formation/process distinction |
| JCGM/BIPM VIM 3, 2.3 `measurand`, https://jcgm.bipm.org/vim/en/2.3.html | metrology | distinguishes quantity intended to be measured from the measurement/result |
| JCGM/BIPM VIM 3, 2.9 `measurement result`, https://jcgm.bipm.org/vim/en/2.9.html | metrology | measurement result as values attributed to measurand plus relevant information such as uncertainty; supports process != result |
| OGC Timeseries Profile of Observations & Measurements, https://docs.ogc.org/is/15-043r3/15-043r3.html | measurement / observation standards | distinguishes feature/property, observation act/procedure and result estimate; supports actual-vs-observation-vs-result boundary |
| W3C PROV-DM, https://www.w3.org/TR/prov-dm/ | provenance / data modelling | provenance as structured relations among entities, activities and agents; entity/activity/generation/derivation distinction |
| W3C PROV Constraints, https://www.w3.org/TR/prov-constraints/ | provenance / consistency | temporal/identity/derivation constraints; provenance information has validity/ordering structure |
| Buneman, Khanna & Tan (2001), *Why and Where: A Characterization of Data Provenance*, DOI `10.1007/3-540-44503-X_20` | database provenance | output data vs source/transformation lineage; supports state/output != derivation history |
| Stanford Encyclopedia of Philosophy, *Evidence*, https://plato.stanford.edu/entries/evidence/ | epistemology | evidence/support is target-relative; supports role/relation treatment rather than peer content subtype |
| Stanford Encyclopedia of Philosophy, *Logic of Belief Revision*, https://plato.stanford.edu/entries/logic-belief-revision/ | epistemic logic / belief change | belief state/base vs operations such as expansion/contraction/revision; independent state/change structural support |
| Stanford Encyclopedia of Philosophy, *Mental Representation*, https://plato.stanford.edu/entries/mental-representation/ | philosophy of mind / cognitive representation | representation is not equivalent to causal information; attitudes can differ while representational content relations are shared |
| Claude Shannon (1948), *A Mathematical Theory of Communication* | information theory | falsifier for overbroad `Information` label: engineering information may abstract away semantic meaning |
| Stanford Encyclopedia of Philosophy, *Semantic Conceptions of Information*, https://plato.stanford.edu/entries/information-semantic/ | philosophy of information | multiple information conceptions; supports parent-label polysemy warning |
| W3C Web Annotation Data Model, https://www.w3.org/TR/annotation-model/ | annotation / web data model | body/target, role/purpose/motivation and source constraints show aboutness/purpose as relations rather than intrinsic peer types |
| Anind K. Dey (2001), *Understanding and Using Context*, https://kilthub.cmu.edu/articles/journal_contribution/Understanding_and_Using_Context/6470603 | HCI / context-aware computing | context as broad entity/use-relative information; supports selected-view/use-relation treatment rather than intrinsic child |
| Endsley (1995), *Toward a Theory of Situation Awareness in Dynamic Systems*, DOI `10.1518/001872095779049543` | human factors / situation awareness | domain-specific perception/comprehension/projection pipeline used as holdout; maps structurally to state + formation/transformation rather than forcing universal stages |
| Wang & Strong (1996), *Beyond Accuracy: What Data Quality Means to Data Consumers*, https://www.jmis-web.org/articles/1002 | information systems / data quality | intrinsic/contextual/representational/accessibility categories as consumer/fitness quality views; anti-taxonomy falsifier |
| ISO/IEC 25012:2008, https://www.iso.org/standard/35736.html | data quality standard | data-quality characteristics and system-dependent perspectives; quality dimensions are not automatically ontology branches |
| W3C Data Quality Vocabulary, https://www.w3.org/TR/vocab-dqv/ | data quality / web standards | quality dimensions, measurements and annotations; no single universal objective quality taxonomy; supports cross-cutting assessment treatment |
| W3C Data on the Web Best Practices, https://www.w3.org/TR/dwbp/ | data publishing / stewardship | provenance, version, quality, access and reuse concerns as cross-resource practices rather than disjoint information types |
| Wilkinson et al. (2016), *FAIR Guiding Principles*, DOI `10.1038/sdata.2016.18` | scientific data stewardship | findability/accessibility/interoperability/reusability as stewardship/use desiderata crossing resources, metadata and infrastructure |
| NIST FAIR summary, https://www.nist.gov/itl/ssd/information-systems-group/configurable-data-curation-system-cdcs/cdcs-help-and-resources-1 | scientific data stewardship | public restatement of FAIR dimensions and provenance/identifier/access relations |
| W3C Dataset Usage Vocabulary, https://www.w3.org/TR/vocab-duv/ | dataset use / feedback | usage, feedback and citation as relations around datasets and consumers; use does not require a universal Information child |
| `HandsOnLLM/Hands-On-Large-Language-Models`, target `main` observed at `ea3390819997999a51983677b80b3aac4dc50ada`, https://github.com/HandsOnLLM/Hands-On-Large-Language-Models | executable LLM pedagogy / operational falsifier corpus | tokenizer/model identity, embeddings/retrieval, model/API drift and fine-tuning cases pressure representation identity, derivation, context selection and learned-state boundaries. Candidate study route: `../../../../studies/hands-on-large-language-models/META.md` |

## Internal candidate-study falsifier route

Relevant bounded candidate study:

`../../../../studies/context-memory-harness-engineering/`

Use:

- distinguishes persistence, managed memory lifecycle and model-visible current context;
- shows context/memory/harness are engineering/failure-surface classifications rather than a Foundation hierarchy;
- supports persistence as a strong specialization condition crossing State and Dynamics rather than an automatic peer child.

Start with:

- `../../../../studies/context-memory-harness-engineering/META.md`
- `../../../../studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md`

This study carries no Foundation-tree authority.

## Structural conclusions supported by the source set

Across materially different traditions, the strongest recurring structural distinction is:

> **informational products/states/results can require semantics distinct from the processes/operations that acquire, generate, derive, select or revise them.**

The source set also repeatedly pressures these as cross-cutting rather than peer-child defaults:

- source/provenance;
- uncertainty/confidence;
- freshness/time;
- evidence role;
- context relevance;
- accessibility;
- quality/fitness;
- persistence horizon.

No external taxonomy is promoted merely because it names these concerns.

## Source-use rule

Use these sources for structural falsification and problem discovery only within the claims they support.

Do not:

- import POMDP probability structure as universal epistemology;
- import metrology/O&M classes as SOUL classes;
- import PROV as final relation schema;
- import philosophical evidence/belief theories as one mandatory evidential calculus;
- import data-quality/FAIR dimensions as Information children;
- import situation-awareness stages as a universal information pipeline;
- import candidate-study engineering classifications as Foundation hierarchy;
- import the Hands-On LLM chapter structure, terminology or implementation stack as SOUL hierarchy/ontology/architecture;
- infer architecture or implementation choices from any source above.

## Verification note

This ledger supports source recovery and falsifier coverage. The top-level synthesis remains a bounded research judgment and same-model adversarial closure, not independent verification.