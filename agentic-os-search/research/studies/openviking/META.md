# OpenViking — Study Metadata

## Identity and status

- **Study ID:** `openviking`
- **Title:** OpenViking — Context Database, Progressive Context Loading and Agent Memory
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, pinned research corpus, findings, benchmark replication or adoption work has begun.
- **Research object:** `volcengine/OpenViking` as an implemented context database for AI agents that unifies resources, memories and skills in a virtual filesystem; supports progressive L0/L1/L2 context loading, hierarchical retrieval, session-to-memory extraction, multi-tenant identity/ACL boundaries and cross-agent integrations.
- **Canonical external target:** https://github.com/volcengine/OpenViking
- **Observed default branch during preliminary qualification:** `main`
- **Discovery / qualification date:** 2026-09-17
- **Observed upstream snapshot during qualification:** `a5aae16d0b7dde038b3a49d2e41a5ea515186b42`; latest observed release `v0.4.20` (2026-09-14). This is a qualification observation, not the pinned corpus of a completed or active study.
- **Observed project maturity / license:** package metadata marks the project Alpha; repository license is AGPL-3.0.
- **Pinned research ref:** none. Revalidate upstream and deliberately choose a research snapshot when detailed research is authorised.
- **Freshness risk:** high. The repository is changing rapidly across memory extraction, context compilation, retrieval, agent plugins, tenancy/ACL and server/runtime behavior.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- a unified `viking://` context namespace that treats **Resource**, **Memory** and **Skill** as distinct but jointly searchable context types;
- a three-level context representation where directory-level L0 abstracts and L1 overviews guide relevance/navigation before L2 original detail is loaded;
- explicit sidecar provenance/freshness metadata and known-staleness signaling (`pending_child_changes`) rather than treating generated summaries as timeless truth;
- a dual-layer storage model where AGFS/RAGFS content is the declared content source and the vector index stores retrieval references/metadata rather than authoritative file bodies;
- retrieval that separates simple `find` from session-aware `search`, with optional LLM intent analysis, typed queries, directory-recursive search and reranking;
- session commit semantics that archive messages synchronously and perform summary generation plus long-term-memory extraction asynchronously;
- memory policies and typed memory categories, including profile/preferences/entities/events/identity/soul/cases/trajectories/experiences, with custom types and agent-experience paths;
- a memory update pipeline that compares extracted candidates with existing memory and can skip, create, merge or delete, while writing `memory_diff.json` audit material for each commit;
- multi-tenant `account` / `user` / `peer` boundaries, shared-resource ACL behavior and the explicit goal that searchable content align with readable content;
- skill privacy handling that extracts sensitive values into versioned config and stores placeholders in `SKILL.md`, restoring active values on read;
- multiple agent integrations (including Claude Code, Codex, Cursor, OpenClaw, Hermes, OpenCode, DSH and others) with differing hook/MCP/native integration shapes;
- first-party benchmark infrastructure spanning LoCoMo, LongMemEval, tau2, retrieval, RAG and other suites, giving later research a concrete replication target rather than documentation claims alone.

These observations justify later investigation; they do not establish that the mechanisms work as documented, that generated L0/L1 summaries preserve the right information, that memory extraction/deduplication is reliable, that privacy/tenancy controls are complete, or that published benchmark gains should be accepted without replication.

## Candidate primary question / purpose

If this study is later authorised, investigate how OpenViking turns heterogeneous agent context into a governed database: how resources, memories and skills are represented; how L0/L1/L2 summaries and directory structure control progressive context materialization; how retrieval moves from intent to hierarchy to detail; how sessions become durable memories and experience; how authority, freshness, privacy and tenant boundaries are represented; and which behaviors depend on VLM/embedding/rerank providers versus deterministic infrastructure.

A central SOUL-facing question is whether an agent system benefits from a unified **context substrate** in which durable resources, learned memory and callable skills share navigable/retrievable structure, while still preserving different lifecycles, authorities and visibility boundaries.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially very strong for context type separation, progressive representation (L0/L1/L2), source-vs-index authority, retrieval hierarchy, freshness metadata, memory extraction/deduplication, audit and context materialization.
- **Work:** potentially strong for session lifecycle, commit/background processing, task-managed context compilation, cases/trajectories/experiences and session-to-future-task reuse.
- **Actors:** potentially strong for account/user/peer identities, user versus peer memory, agent-defined capabilities, multi-user isolation and shared-resource access.
- **Environment:** potentially strong for VLM/embedding/rerank dependencies, storage backends, HTTP/SDK/MCP/plugin integrations, deployment modes and provider-specific runtime behavior.
- **Relations / control:** potentially strong for ACL inheritance/restriction, privacy placeholder/config binding, memory create/merge/delete decisions, freshness propagation, transaction/locking semantics and retrieval/read authorization alignment.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- pressure-testing the idea of a unified context substrate without assuming that Resource, Memory and Skill should collapse into one ontology;
- studying progressive context loading as an explicit runtime policy: quick relevance representation first, then navigational overview, then full detail;
- separating canonical content from derived retrieval indexes and generated semantic sidecars;
- examining how stale or partially refreshed derived context should advertise its own uncertainty/freshness;
- comparing user, peer and shared-agent context scopes and their authority/visibility boundaries;
- studying whether memory extraction should produce typed durable artifacts and auditable diffs rather than opaque embeddings alone;
- examining session-derived cases, trajectories and experiences as candidate forms of reusable work knowledge;
- evaluating how privacy/configuration material can remain outside durable skill text yet be restored at consumption time.

No SOUL context, memory, skill, tenancy or retrieval architecture is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- progressive retrieval/navigation for large repository and work contexts;
- explicit freshness metadata for generated summaries and derived views;
- session commit and background processing boundaries;
- auditable before/after memory mutation records;
- cross-agent context integration through hooks/MCP/native extensions;
- account/user/peer separation for shared company context versus personal working state;
- ACL-aware retrieval so discovery and read authority stay aligned;
- context compilation into maintained artifacts such as wikis/reports/graphs;
- benchmark/evaluation design for memory, retrieval and task-success effects.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- implemented context-database reference;
- pressure test / falsifier for context, memory and skill separation;
- progressive-loading and hierarchical-retrieval mechanism source;
- multi-tenant/privacy/ACL boundary case;
- memory-extraction and audit mechanism case;
- cross-host integration comparison target;
- benchmark/evaluation methodology reference;
- counterpoint to file-first/zero-LLM memory systems.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- deepening Information around context representation, retrieval, memory or freshness;
- designing SOUL/Development OS context or memory substrates;
- comparing progressive context-loading strategies with ordinary RAG/long-context approaches;
- studying multi-user or company-wide AI systems where shared resources and private memories need distinct boundaries;
- examining session-to-experience learning and reusable trajectories;
- designing retrieval/memory benchmarks or task-quality evaluations;
- comparing `ai-memory`, `context-mode`, `hermes-agent`, `deepseek-harness` or other context/memory systems.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- Architecture/docs describe intended/current repository behavior but do not independently prove runtime correctness, security, tenancy isolation, privacy restoration, cross-host equivalence, retrieval quality or memory efficacy.
- The repository's simplified mapping to human cognition and its memory taxonomy are design choices, not accepted psychological or cognitive-science findings.
- The repository's published LoCoMo/tau2 and other benchmark claims are first-party evidence. Reproduction scripts exist, but this research project has not reproduced the runs, validated model/config equivalence, or independently checked all comparison baselines.
- The L0/L1 model may reduce model-visible context while introducing summary omission, staleness and navigation-selection failure; those trade-offs are unverified here.
- Memory extraction and deduplication use model-dependent decisions; successful persistence does not establish semantic correctness or future retrieval/use.
- No live installation, multi-tenant security test, ACL bypass test, privacy-restoration test, long-session memory campaign, cross-agent integration campaign or benchmark replication has been performed by this research project.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, context taxonomy or implementation requirements.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check the current upstream repository, release, architecture docs and integration matrix;
2. choose and record a pinned source commit/ref;
3. inventory OpenViking's native context model before projecting it onto our Foundation or prior memory/context vocabulary;
4. separate Resource/Memory/Skill, L0/L1/L2, storage/index authority, retrieval, session/memory extraction, compile, privacy and multi-tenancy as distinct mechanism surfaces;
5. recover benchmark methodology/configuration and reproduce or independently challenge load-bearing claims;
6. test model-dependent versus deterministic paths separately where runtime verification becomes useful;
7. establish an explicit research method and scope before accumulating findings.

Current operational, compatibility, security/privacy and benchmark claims require fresh authoritative-source validation before load-bearing reuse.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../ai-memory/` — file-first cross-agent long-term memory, handoffs, ownership, forgetting and benchmarkable retrieval;
- `../context-memory-harness-engineering/` — focused-topic context, memory and harness boundary research;
- `../context-mode/` — model-visible context control, selective retrieval and continuity;
- `../hermes-agent/` — runtime, persistent knowledge, continuation and skill-library mechanisms;
- `../deepseek-harness/` — agent-runtime composition, session state, skills/capabilities and cross-host runtime seams;
- `../ai-knowledge-strategies/` — RAG / long-context / retrieval / representation mechanism boundaries;
- `../the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/` — memory-function, temporal-state, conflict and forgetting pressure cases.

These relations are discovery hints, not corroboration or evidence.