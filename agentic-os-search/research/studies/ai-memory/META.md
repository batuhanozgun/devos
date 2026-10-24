# AI Memory — Study Metadata

## Identity and status

- **Study ID:** `ai-memory`
- **Title:** AI Memory — Cross-Agent Long-Term Memory, Handoffs and File-First Knowledge Lifecycle
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, pinned research corpus, findings, benchmark replication or adoption work has begun.
- **Research object:** `akitaonrails/ai-memory` as an implemented long-term-memory and work-continuity system for AI coding agents, spanning automatic lifecycle capture, markdown-backed durable knowledge, derived retrieval indexes, cross-agent handoffs, multi-user ownership, forgetting/retention and optional provider-backed consolidation/auto-improvement.
- **Canonical external target:** https://github.com/akitaonrails/ai-memory
- **Observed default branch during preliminary qualification:** `main`
- **Discovery / qualification date:** 2026-09-17
- **Observed upstream snapshot during qualification:** `a200127c5866e23f6068823091111c01de8f49d5` / release and workspace version `2.3.0`. This is a qualification observation, not the pinned corpus of a completed or active study.
- **Pinned research ref:** none. Revalidate upstream and deliberately choose a research snapshot when detailed research is authorised.
- **Freshness risk:** high; the target is actively released and its supported harnesses, workstream semantics, retrieval stack, security/privacy behavior and benchmark results are time-sensitive.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- a file-first memory architecture where a git-versioned markdown wiki is declared the durable source of truth and SQLite/FTS/entity/graph/vector structures are derived indexes rather than the authoritative memory store;
- automatic lifecycle-hook capture of prompts, tool use and session boundaries, with a typed sanitization/privacy boundary before durable storage;
- an explicit memory lifecycle spanning capture, session-end consolidation, retrieval, handoff, reinforcement, decay/forgetting and backup/restore;
- cross-agent and cross-machine memory sharing across many coding-agent harnesses rather than a single host-local memory implementation;
- typed cross-agent handoffs with ownership/claim semantics and separate managed-workstream continuity intended to carry bounded portable history between harness-native sessions;
- separation between shared project knowledge and personal/operator-owned handoffs in multi-user/team operation, with attribution and audit surfaces;
- zero-LLM default operation for capture/search/handoff, with optional LLM consolidation, embeddings, reranking and auto-improvement layered above the core path;
- explicit authority/trust handling for automatically injected memory, including the principle that current instructions and checkout state remain authoritative over remembered material;
- retention/forgetting semantics that distinguish wiki pages, raw observations, version ancestry and irreversible information-loss boundaries;
- an in-repository evaluation surface including a real-stack LongMemEval retrieval harness and provider/prompt A/B tooling, giving later research a reproducible verification target rather than documentation claims alone.

These observations justify later investigation; they do not establish that the mechanisms work as documented, that the source-of-truth choice is generally superior, that handoff/forgetting semantics are correct, or that benchmark claims should be adopted without replication.

## Candidate primary question / purpose

If this study is later authorised, investigate how ai-memory represents and governs the full long-term-memory lifecycle for agentic work: what is captured, sanitized, consolidated, made authoritative, indexed, retrieved, injected, handed off, reinforced, forgotten and shared; how these semantics survive switching agents, sessions, machines and operators; and which parts are deterministic infrastructure versus provider/model-dependent behavior.

A central SOUL-facing question is whether durable agent memory should be modeled as a governed, versioned knowledge/work substrate with explicit source authority, ownership, retention, retrieval and handoff semantics rather than as an opaque vector store or host-local note feature.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially very strong for source-of-truth vs derived index, persistence, provenance, retrieval fusion, temporal/version semantics, reinforcement, decay, forgetting and memory-to-context materialization.
- **Work:** potentially strong for session-end state capture, explicit handoffs, workstream continuation, unfinished-work recovery and cross-session/cross-harness continuity.
- **Actors:** potentially strong for operator ownership, shared project knowledge versus personal handoffs, multi-user attribution, claim/accept semantics and agent-to-agent transfer.
- **Environment:** potentially strong for host adapters, MCP/hooks, local/server deployment, cross-machine operation, optional provider/embedding/reranker dependencies and security/privacy boundaries.
- **Relations / control:** potentially strong for authority precedence, version/supersession chains, handoff ownership, idempotency, retention transitions, auditability and automatic-improvement approval/eval gates.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- pressure-testing memory as a governed lifecycle rather than a single storage/retrieval mechanism;
- examining the separation of canonical durable knowledge from derived retrieval/index structures;
- studying when remembered information should become model-visible context and how current instructions/state override stale memory;
- comparing automatic capture with explicit authored memory and examining provenance/authority loss during consolidation;
- understanding cross-agent/cross-machine handoff semantics as a first-class protocol rather than a summary convention;
- studying shared versus personal memory, ownership, audit and multi-user isolation in a central service;
- examining forgetting as an explicit controlled transition with recoverability and irreversible-loss boundaries;
- evaluating whether optional LLM consolidation and auto-improvement can safely sit above a deterministic zero-LLM substrate.

No SOUL memory architecture, storage choice, retention policy or adoption decision is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- durable work/session continuity across tools and machines;
- repository/worktree-aware handoffs and managed workstreams;
- canonical artifact versus derived-index design;
- provenance, audit, idempotency and retry semantics for captured agent activity;
- shared team knowledge versus operator-specific continuation state;
- bounded startup briefs and progressive retrieval instead of replaying full history;
- privacy/sanitization rules at capture time;
- retrospective/auto-improvement pipelines with approval and executable evaluation gates;
- benchmark and evaluation design for memory retrieval and consolidation behavior.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- implemented memory-system reference;
- pressure test / falsifier for memory and continuity models;
- candidate mechanism source for capture, retrieval, handoff, retention and ownership;
- security/privacy/authority boundary case;
- cross-host portability and team-memory case;
- benchmark/evaluation methodology reference;
- failure-mode source for consolidation, stale memory, information loss and automatic improvement.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- deepening Information around memory, retrieval, provenance, temporal state or forgetting;
- studying cross-session or cross-agent work continuity and handoff protocols;
- designing SOUL/Development OS memory, team-knowledge or persistent-work substrates;
- comparing file-first memory with fact stores, vector stores, graph memory or host-native memory;
- studying multi-user agent systems where shared knowledge and personal state need different ownership rules;
- designing memory benchmarks, consolidation evals or retrieval-quality tests;
- comparing `context-mode`, `hermes-agent`, Carbon Layer memory research or other memory-oriented systems.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- Architecture/docs describe intended/current repository behavior but do not independently prove runtime correctness, reliability, security, cross-host equivalence or efficacy.
- The repository's comparison of itself with Mem0, Zep/Graphiti, Letta, Hindsight, OpenViking and other systems is first-party analysis and must not be treated as neutral comparative evidence without recovering the underlying sources.
- The published LongMemEval-S numbers and competitor comparisons are first-party benchmark claims. The repo provides a reproducible harness and provenance-oriented design, but this research project has not reproduced those runs or validated cross-system metric equivalence.
- The repo's broader claims that external research or industry systems "validate" its design are interpretations that require independent source recovery if they become load-bearing.
- No live installation, multi-user deployment, cross-machine campaign, privacy audit, handoff race test, forgetting/recovery test, benchmark replication or provider-quality evaluation has been performed by this research project.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, memory taxonomy or implementation requirements.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check the current upstream repository, default branch, release and support matrix;
2. choose and record a pinned source commit/ref;
3. inventory the native memory model before projecting it onto our Foundation or prior memory vocabulary;
4. separate source-of-truth, capture, consolidation, retrieval, handoff/workstream, ownership/auth, retention/forgetting and auto-improvement as distinct mechanism surfaces;
5. recover primary sources behind external-comparison and research-landscape claims before relying on them;
6. reproduce or independently challenge benchmark/eval claims before using them as efficacy evidence;
7. establish an explicit research method and scope before accumulating findings.

Current operational, security, compatibility and benchmark claims require fresh authoritative-source validation before load-bearing reuse.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../context-memory-harness-engineering/` — focused-topic context, memory and harness boundary research;
- `../context-mode/` — model-visible context shaping, session continuity and selective retrieval;
- `../hermes-agent/` — agent runtime, persistent knowledge, continuation and learning mechanisms;
- `../the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/` — memory-function, temporal-state, conflict and forgetting pressure cases;
- `../ai-knowledge-strategies/` — retrieval/representation/adaptation mechanism boundaries;
- `../deepseek-harness/` — agent-runtime composition, durable session state and capability seams.

These relations are discovery hints, not corroboration or evidence.