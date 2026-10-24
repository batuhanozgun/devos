# M5 — Source and execution addendum

**Date:** 2026-09-14. **Input:** `185669845dc558b76fbcfb0264b413a0afc19adf`.
**Role:** evidence trace for the resumed synthesis; original SOURCE-LEDGER and M0–M4 are unchanged.

## 1. Recovery and source IDs

[M5-RESUMPTION](M5-RESUMPTION.md) records the actual canonical full reads and same-conversation reuse before fresh primary reading. Original S1–S7 and C01–C12 retain their original reading/execution scopes. The following P identifiers belong only to this continuation.

### P1 — Reiter and de Kleer, Foundations of Assumption-Based Truth Maintenance Systems: Preliminary Report

https://www.dekleer.org/Publications/Foundations%20of%20Assumption-Based%20Truth%20Maintenance%20Systems.pdf

Fresh targeted reading: sections 1–2 and the start of section 3, especially the reasoner/CMS contract, relative knowledge boundary and minimal-support definition. PDF pages 0–2 were visually inspected earlier in this continuation. This is not a new full-paper or ATMS implementation replication. The original ledger's earlier six-page reading is a separate historical observation.

Use: conditional support relative to the clauses actually communicated; an available support/context does not itself choose an endorsed assumption set. The source's architecture is not adopted as a Foundation taxonomy. No search-performance counts are imported.

### P2 — Schwind, Konieczny and Pino Perez, KR2022, pp.320–330

On the Representation of Darwiche and Pearl's Epistemic States for Iterated Belief Revision.

https://proceedings.kr.org/2022/32/kr2022-0032-schwind-et-al.pdf

Fresh reading concentrated on epistemic-state definitions, translation/strong-equivalence conditions, selected propositions through section 4, Definition 7 and Example 8. Page 2 / Figure 1 was visually recovered. Attempts to render pages 5–6 / Figure 2 failed with internal/cache errors. D01 therefore reconstructs the explicit parsed formula and rank values, not an inspected Figure 2. Later sections and all general representation theorems were not independently audited.

Use: a fixed operator can distinguish states with identical initial total preorders and identical one-step belief answers. This is stronger than original C12's comparison of two different operators. The paper's OCF/canonical-representation conclusions are not turned into a SOUL storage or confidence prescription.

### P3 — Delgrande and Schaub, arXiv:cs/0003052v3, 3 April 2000

A Consistency-Based Model for Belief Change: Preliminary Report.

https://arxiv.org/pdf/cs/0003052v3

Fresh targeted reading: abstract/introduction, Definitions 1–4, explicit worked revision/contraction prose, selected properties/iteration discussion and integrity-constraint/implementation passages. Screenshots of pages 2 and 4 failed. D02 uses the explicit derivation after equation (1), not a claimed visual transcription of Tables 1–2. No whole-paper proof, complexity verification or production operator implementation was performed.

Use: distinguish consistency-only requirements from entailed requirements, choice from skeptical revision, and inclusion-maximal from maximum-cardinality preservation. D03/D04 are our small constructions under the stated definitions.

## 2. A source tension retained, not silently resolved

P3 Definition 1 includes V in the consistency test but omits it from the resulting deductive closure. Its dynamic-constraint paragraph later places a mixed old/new implication in V while describing the new consequent as required. Under the literal mixed-time interpretation tested in D03, that compatibility filter alone does not establish the consequent: the output still allows a countermodel. Retaining the implication among the output premises changes that outcome.

This is a bounded source-contract tension, not a declaration that the full theory is wrong. The mixed-alphabet paragraph extends the original setting, its intended additional semantics were not recovered, and the relevant PDF page was not visually verified. Do not import its prose as a universal enforcement guarantee. The independently explicit static U/V distinction already supports the narrower Foundation result without resolving this tension.

## 3. Discovery and access that did not become full evidence

Doyle's reason-maintenance/belief-revision chapter was located through publisher metadata and the author's MIT publication index. Only publisher/author-uploaded abstract material was available; PostScript/download attempts failed. No full Doyle chapter, proof of equivalence between entire traditions or new mechanism result is claimed. Other search hits were discovery, not read primary evidence.

Local outbound requests/downloads also failed. This did not prevent GitHub publication or the text-defined finite calculations. No offline primary PDF archive was obtained. Sources P1–P3 are observed documents at the URLs/versions above, not locally hashed raw-source files.

The selected harness study's Note10 is reused as an explicitly analytical counterexample about persisted progress, replay, external effects and current authorization. Its runtime documentation and original video were not freshly validated here. No study adoption, study update or fresh LangGraph behavior claim follows.

## 4. Executed checks and reproducibility

The new [SPEC](checks/m5/SPEC.md) was published at `c2987d88ca08f53323244ed8d7d3250ce5499510` before execution. Its local bytes matched GitHub blob `5464adec44bcd050e949eb0c87da9d51a2b68294`.

The first execution of [m5_checks.py](checks/m5/m5_checks.py), Python 3.13.5 / standard library, passed all five cases and rejected all five named false rules. No expectation, case or script was changed after observing that result. An unchanged repeat exited zero and produced byte-identical RESULT.json.

| Artifact | Git blob | SHA256 |
|---|---|---|
| SPEC.md | `5464adec44bcd050e949eb0c87da9d51a2b68294` | `b8ae998a9795c31e020537943a85389791d0bb558381cb631ab5b561374da6ea` |
| m5_checks.py | `98112b81887afc2718048bcc8f0db9f101f894f6` | `ced15d02d34f93b16ad5ec8215ba5ee8d85da61777c1838785b215e178e30eb6` |
| RESULT.json | `819857d78e91e797a41de7244bca137e436f8c3f` | `ec7034caf62cbc44c15851d43c15ffec351a79797d9424b01a458527cfd99fcc` |

A separate GitHub tree read at `23cb6e52103f27d59bafb066f1f6e80ffdde2e66` matched all three published identities and sizes to the executed local files. Original checks/SPEC, revision_checks.py and RESULT were not changed or newly rerun. A local file-creation command reported a transport timeout before execution; inspection found the two complete input files and no result file. Their identities were checked before the actual first run. This was not a failed scientific run hidden from the record.

## 5. What the checks do not establish

D01/D05 share one operator; D02–D04 share one finite extension routine. Negative controls inspect the same fixtures, not independent samples or a broad code-mutation campaign. Expected truth tables/ranks were specified by the same author from equations/prose. Exhaustive enumeration is confined to two or three atoms; no complete DP/AGM theorem or general dynamic-constraint treatment is proved by the program.

Five cases plus five controls are not ten independent experiments. Original twelve/eight and new five/five belong to different checkpoints; they are not an accumulated live-system score. No live SOUL/LLM, human study, empirical belief calibration, actual concurrency, distributed recovery or independent researcher/model verification occurred. File identity and repeatability do not decide the leaf/split question.
