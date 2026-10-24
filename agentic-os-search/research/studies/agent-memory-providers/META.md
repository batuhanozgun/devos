# Agent Memory Providers — Study Metadata

## Identity and status

- **Study ID:** `agent-memory-providers`
- **Title:** Agent Memory Providers / Persistence Substrates — Provider–Management Boundary
- **Study type:** `focused-topic`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package records an authorised future research topic and its initial source corpus only. No detailed methodology, findings, benchmark replication, architecture decision or implementation work has begun.
- **Research object:** the role of a **memory provider / persistence substrate** in agentic systems, especially the boundary between storage/query capabilities and the higher-level memory-management decisions that determine what is written, retained, retrieved, exposed, updated, superseded or forgotten.
- **Registration date:** 2026-09-18
- **Freshness risk:** high; provider APIs, repository behavior, database integrations and practitioner terminology are changing quickly.

## Initial paired source corpus

### 1. Richmond Alake talk / MongoDB framing

- **Source:** https://www.youtube.com/watch?v=W2HVdB4Jbjs
- **Role in future research:** starting source for the claim/framing that MongoDB can act as a memory provider for agentic systems and for the provider-versus-memory-management distinction.
- **Current status:** source identified and preliminarily discussed; no durable transcript-level source study has been completed in this package.

### 2. RichmondAlake/memorizz

- **Canonical repository:** https://github.com/RichmondAlake/memorizz
- **Observed default branch:** `main`
- **Preliminary qualification date:** 2026-09-18
- **Observed current-main commit:** `b6bd856ec863cff886ca48dd22e2e27a39fb9df6`
- **Observed package version:** `0.10.0`
- **License observed in package metadata / README:** PolyForm Noncommercial 1.0.0
- **Pinned research ref:** none. Revalidate and deliberately pin a research snapshot when detailed work begins.

Preliminary source reading found a materially relevant separation:

```text
MemAgent = model + memory provider + runtime policies + optional capabilities
```

The repository describes memory types as semantic/functional categories while providers implement persistence and query behavior. Its provider surface currently includes local filesystem, MongoDB and Oracle options, while runtime policy controls retrieval/exposure/context/learning behavior.

These are **qualification observations, not research findings**.

## Why this candidate is registered

Existing research already treats agent memory as a cross-time lifecycle rather than storage alone. The new question is lower-level and complementary:

> **What contract should a memory provider / persistence substrate actually satisfy, and where should provider responsibility stop so that memory-management, context-assembly, authority, temporal validity, retention and forgetting remain explicit higher-level concerns?**

MongoDB is the initial concrete database case because the supplied talk and Memorizz repository both expose this boundary. The research should not assume that MongoDB is uniquely suitable or that a vector/database backend itself constitutes a complete memory system.

## Candidate primary questions

If this study is later authorised, investigate at least:

1. What is the minimum provider contract for agent memory: persistence, identity, scope, query, delete, update, transactions, versioning, metadata, indexes, degradation semantics?
2. Which responsibilities belong to the provider versus memory-management/runtime policy?
3. Are execution checkpoints, conversation history, semantic knowledge, procedural memory and shared coordination state genuinely the same persistence problem?
4. How should tenant / agent / user / thread / work scope be represented and enforced?
5. Where should temporal validity, supersession, provenance, epistemic status and authority live?
6. What does semantic/vector search provide, and what does it fail to establish about relevance, freshness, truth or applicability?
7. What is infrastructure-level deletion/retention versus policy-level forgetting?
8. How do document, relational, graph, file-first and vector-oriented substrates change guarantees and failure modes?
9. When provider degradation occurs, can the system distinguish “no memory exists” from “retrieval failed”?
10. Which provider properties materially affect downstream memory correctness and actual Work quality?

## Potential Foundation relevance — provisional retrieval hints

- **Information:** very strong candidate input for persistence, representation, retrieval, identity/scope, provenance, temporal state, revision, retention and exposure boundaries.
- **Environment:** strong for database/runtime capabilities, indexes, deployment modes, provider availability and operational failure behavior.
- **Work:** conditional/strong where checkpoints, continuity, handoffs and durable execution state are represented through the same persistence substrate.
- **Actors:** conditional/strong for tenant/user/agent ownership, access, isolation and shared-memory boundaries.
- **Relations / control:** strong candidate pressure cases for authority precedence, supersession, deletion, degradation and provider/runtime contract boundaries.

These are retrieval hints only and do not add or reopen Foundation nodes.

## Potential SOUL relevance

Possible future value includes:

- distinguishing governed memory-management logic from interchangeable or non-interchangeable persistence backends;
- deciding what guarantees SOUL would need from a provider before a higher-level memory lifecycle can be trusted;
- avoiding the collapse of storage availability, retrieval success, authority and context usefulness into one “memory works” claim;
- comparing provider-neutral abstractions with cases where substrate semantics leak upward and materially affect correctness;
- identifying whether memory-provider selection should be conditioned by Work, Actor and Environment requirements rather than chosen globally.

No SOUL architecture or provider choice is authorised or implied.

## Potential Development OS relevance

Possible future value includes:

- durable work/checkpoint persistence;
- scoped retrieval and continuity state;
- explicit degraded-retrieval semantics;
- separation of canonical project state from lower-authority learned/derived memory;
- database/file/index trade-offs for inspectability, audit, portability and recovery;
- later provider contracts or benchmark criteria if Development OS requires memory services.

No Development OS design or implementation change is authorised or implied.

## Reuse modes

If researched later, this package may provide:

- focused-topic evidence/reference;
- provider-contract and failure-surface decomposition;
- database/persistence comparison criteria;
- implementation-learning references;
- pressure tests / falsifiers for memory-system designs;
- benchmark/test-case ideas for provider degradation, scoping, deletion and retrieval correctness.

## Related studies

Recover selectively when detailed research begins:

- `../context-memory-harness-engineering/` — existing focused research on context, agent-memory lifecycle and harness boundaries;
- `../ai-memory/` — planned file-first long-term memory and cross-agent continuity target;
- `../openviking/` — planned context-database, progressive retrieval and agent-memory target;
- `../the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/` — memory-function, temporal-state, conflict and forgetting cases;
- `../ai-knowledge-strategies/` — RAG / graph / long-context and adjacent mechanism boundaries.

These relations are discovery hints, not corroborating evidence.

## Epistemic and authority boundary

- No detailed study has begun.
- The Memorizz README, concepts page, package metadata and MongoDB-provider page were read only for preliminary qualification.
- The observed repository behavior is documentation/source-code surface evidence, not independent runtime validation.
- Memorizz is experimental and its README states that it has not undergone production security hardening.
- The provider abstraction, MongoDB behavior, fallback semantics and framework-level memory claims have not been independently executed or benchmarked by this research project.
- The supplied video and repository come from the same author ecosystem and therefore must not be treated as independent corroboration.
- This package does not establish that MongoDB is preferable to PostgreSQL, Redis, Oracle, files, graphs, vector stores or any other substrate.
- This package does not modify Foundation truth, architecture, implementation or agent-control.

## Research-start requirement

Before detailed research begins:

1. re-check the current Memorizz repository/release and deliberately pin a ref;
2. recover the supplied video's transcript/source material at sufficient fidelity;
3. define provider versus manager/runtime responsibilities before comparing technologies;
4. inspect actual provider interfaces and tests, not only README claims;
5. select comparison substrates based on the underlying problem rather than product popularity;
6. distinguish storage/query capability from memory correctness and downstream task benefit;
7. independently challenge first-party claims before using them as efficacy evidence.

## Package entrypoint

- `META.md` — candidate identity, initial source corpus, planned questions and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md` or findings package yet because the research has not started.
