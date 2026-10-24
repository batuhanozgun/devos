# M5 checks — pre-execution specification

**Date:** 2026-09-14. Written after targeted primary reading and before first execution of m5_checks.py.
**Research input:** `185669845dc558b76fbcfb0264b413a0afc19adf`; resumption published separately.

## Contract and source extent

Five finite checks supplement, not replace, the original twelve-case/eight-control suite. D01 reproduces the text-defined ranks and operator in Schwind, Konieczny and Pino Perez, KR2022, Definition 7 / Example 8, pp.325–326. D02 reconstructs Delgrande and Schaub, arXiv:cs/0003052v3, Definition 1–2 and the worked paragraph following equation (1). D03–D05 are our further counterexamples under those explicit definitions, not published experiments.

Sources: https://proceedings.kr.org/2022/32/kr2022-0032-schwind-et-al.pdf and https://arxiv.org/pdf/cs/0003052v3 . The new KR Figure 2 and arXiv tables were not visually recovered: screenshot attempts failed. Use explicit parsed equations/prose and disclose that representation limit; do not claim figure transcription or complete paper replication. No source theorem or hierarchy is certified by these checks.

## Fixed expected outcomes

World bits follow the stated atom order; rank tuples are ordered 00,01,10,11, with rank zero giving current belief models.

| ID | Construction and expected result |
|---|---|
| D01 | Same KR operator on k=(0,1,1,2) and pi=(0,1,1,4). For all 15 nonempty two-atom model sets, one-step belief models agree. After p, ranks are (1,2,0,2) and (1,2,0,4). After subsequent q, ranks are (2,0,1,0) and (2,0,1,4): models {01,11} versus {01}. Fixed policy, not a comparison of two different operators. |
| D02 | Old p-and-q, new not-both. Enumerate all old/new pairs and inclusion-maximal retained atom equivalences. Exactly {p} and {q} survive, yielding separate extensions with models {10} and {01}. Skeptical theory has model union {01,10}, not empty model intersection; a choice needs an additional selector. |
| D03 | Old a, unconstrained b. Under Definition 1, a consistency-only V={b} permits all equivalences but the projected extension still has models {10,11}; entailment U={b} has only {11}. Repeat with the explicitly declared mixed-time condition old-a implies new-b: placing it only in the consistency filter still permits 10 in the resulting extension; placing it in the retained premises excludes 10. This second construction tests a literal extrapolation, not a proof of the authors' intended dynamic semantics. |
| D04 | Old a-and-b-and-c. Admissible new worlds are {100,011}. Inclusion-maximal equivalence sets are {a} and {b,c}, of different cardinalities. Maximum-cardinality filtering discards the first legitimate inclusion-maximal choice. The two optimization criteria are not interchangeable. |
| D05 | Under the D01 operator, pi after one p is (1,2,0,4), after three p inputs (3,4,0,4). Current belief models stay {10}; subsequent q yields {01} versus {01,11}. A duplicate-delivery policy that admits event e only once leaves the one-input state; three separately admitted inputs yield the three-input state. No claim that repeated messages constitute independent evidence. |

## Failure sensitivity and limits

Reject five named false rules: equal complete one-step answers imply equal future behavior; skeptical combination intersects model sets; consistency with a condition means entailment; inclusion-maximal means maximum-cardinality; unchanged current answer makes repeated admitted input behaviorally inert.

Each negative control uses the same fixture as its positive check. They are not independent experiments or a broad mutation campaign. The program must write failures and exit nonzero. Expected tuples, sets and rules above must not be silently revised after observing results. Repeat the unchanged program for byte stability; runtime identities are part of the result.

The checks concern finite semantics only: no live SOUL/LLM, human beliefs, empirical confidence, actual concurrent system, universal revision policy, complete DP/AGM conformance or independent taxonomy validation. The leaf/split verdict requires a separate comparative argument.
