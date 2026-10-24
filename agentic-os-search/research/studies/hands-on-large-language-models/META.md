# Study Metadata — Hands-On Large Language Models

- **Study ID:** `hands-on-large-language-models`
- **Study type:** `external-target`
- **Status:** durable external-repository research complete; research/reference value established; production adoption not evaluated or recommended
- **Research object:** `HandsOnLLM/Hands-On-Large-Language-Models`
- **Canonical external target:** https://github.com/HandsOnLLM/Hands-On-Large-Language-Models
- **Observed target branch/ref:** `main`; audited research file records observed HEAD `ea3390819997999a51983677b80b3aac4dc50ada` (2026-04-24)
- **Research date:** 2026-09-04
- **Primary purpose:** understand the repository as an executable LLM textbook/notebook corpus and assess which concrete examples/failure surfaces may later inform SOUL or Development OS

## Potential Foundation relevance

- **Information / Representation State:** strong; tokenization, embeddings, classification, retrieval/RAG, multimodal representation, training/fine-tuning and source/model binding cases.
- **Environment / Operating Reality:** conditional; notebook/runtime/dependency/provider/version binding and execution-environment drift.
- **Actors:** conditional; tools/memory/planning/agents bonus material as illustrative evidence, not authoritative agent taxonomy.
- **Work:** conditional; executable workflow examples and reproducibility/verification pressure.

## Potential SOUL relevance

- concrete LLM representation/retrieval/fine-tuning/tool/memory/planning examples;
- falsifiers and implementation-learning examples when reasoning from Foundation findings toward real mechanisms;
- executable examples of hidden model/tokenizer/API/environment binding.

## Potential Development OS relevance

- AI artefact provenance and exact-target verification;
- environment/version-bound replay;
- dependency/API drift handling;
- semantic model/tokenizer binding;
- executable test-case/failure-case corpus.

## Reuse modes

- evidence/reference;
- falsifier/test-case source;
- implementation-learning corpus;
- environment/version failure-case source;
- not a default production dependency.

## Likely revisit triggers

- Information work requiring concrete LLM mechanism examples;
- implementation design after Foundation conclusions become actionable;
- reproducibility/version/provenance/verification work;
- agent/tool/memory examples where a pedagogical corpus is useful as a counter-read.

## Epistemic / authority boundary

The target is an executable teaching corpus, not a production framework and not an authority for Foundation taxonomy, SOUL architecture or Development OS requirements. Notebook examples can drift as libraries, hosted models/APIs and runtimes change.

## Freshness / revalidation

Before reusing executable examples, re-check current target HEAD, dependencies, notebook cells, provider/model contracts and runtime environment. Independently run the exact example or derived test when correctness matters.

## Entry points

1. `REPOSITORY-RESEARCH.md`
2. `SOUL-DEVELOPMENT-OS-ASSESSMENT.md`
