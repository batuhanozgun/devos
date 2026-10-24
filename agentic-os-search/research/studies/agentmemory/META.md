# AgentMemory — Study Metadata

## Identity and status

- **Study ID:** `agentmemory`
- **Title:** AgentMemory — Persistent Cross-Agent Memory, Retrieval and Lifecycle Runtime
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. Candidate registration and preliminary intake only; no detailed research, benchmark replication, runtime validation, security review or adoption work has begun.
- **Research object:** `rohitg00/agentmemory` as an implemented persistent-memory system for multiple AI coding agents and MCP clients, including durable local state, capture/recall workflows, hybrid retrieval/graph surfaces, adapters and lifecycle automation.
- **Canonical external target:** https://github.com/rohitg00/agentmemory
- **Observed default branch during intake:** `main`
- **Observed upstream snapshot during intake:** `e04ba88819c365c9acf9d6661ea802143e728bd6`
- **Registration / intake date:** 2026-09-20
- **Registration authority:** user requested adding the repository to the studies candidates for later research. This is not authorisation to start detailed research or adopt the system.
- **Pinned research ref:** none. Revalidate upstream and deliberately select a research snapshot when detailed study is authorised.
- **Freshness risk:** high; runtime, adapters, storage behavior, benchmarks, dependencies and security properties may change materially.

## Why this candidate is registered

The upstream README presents AgentMemory as persistent memory shared across multiple coding agents and MCP clients, with local durable state, keyword/semantic/graph-oriented retrieval, agent adapters, lifecycle hooks and first-party benchmark claims.

These are source-description signals for later investigation, not findings verified by this project.

## Candidate primary question / purpose

If later authorised, investigate how AgentMemory captures, persists, retrieves, updates and exposes memory across heterogeneous agent harnesses; how it separates authoritative state from derived representations; which lifecycle steps are deterministic versus model/provider-dependent; and how provenance, freshness, retention, conflict, ownership and failure recovery are handled.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially very strong for persistence, retrieval, representation, provenance, semantic/graph indexing and memory-to-context materialization.
- **Work:** potentially strong for session continuity and cross-agent continuation.
- **Actors:** potentially strong for agent interoperability and ownership boundaries.
- **Environment:** potentially strong for MCP/client adapters, local runtime, storage-engine dependencies and deployment constraints.
- **Relations / control:** potentially strong for update/retention semantics, authority precedence, auditability and lifecycle transitions.

These are retrieval hints only, not Foundation taxonomy assignments.

## Potential SOUL relevance

Possible future value includes pressure-testing persistent memory as a governed lifecycle, comparing canonical durable state with derived search structures, and studying cross-agent memory portability. No SOUL memory architecture or adoption decision is implied.

## Potential Development OS relevance

Possible future value includes durable coding-work continuity, shared memory across tools, adapter contracts, recoverability, evaluation design and source-to-memory provenance. No Development OS implementation decision is implied.

## Reuse modes

Potential later roles include implementation-learning reference, memory-system pressure test, candidate mechanism source, benchmark/evaluation reference and failure-mode source.

## Likely revisit triggers

Revisit when studying agent memory, cross-agent continuity, retrieval quality, memory lifecycle, MCP-based persistence, memory benchmarks, or comparisons with `ai-memory`, `llm-wiki`, `openviking` and `agent-memory-providers`.

## Epistemic and authority boundary

- Detailed research has not started.
- README and repository materials do not independently prove reliability, security or efficacy.
- Upstream benchmark and competitor-comparison claims remain first-party claims until independently recovered and tested.
- No live installation, persistence-failure test, interoperability test, benchmark replication, privacy/security audit or adoption evaluation has been performed by this project.
- Registration does not establish Foundation truth, SOUL / Development OS architecture or implementation requirements.

## Freshness / research-start requirement

Before detailed research: re-check current upstream, pin a commit/ref, recover architecture and storage/runtime paths, identify benchmark provenance, separate deterministic storage/retrieval from model-dependent behavior, and define a bounded method before producing findings.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package because research has not started.

## Related studies — discovery hints only

- `../agent-memory-providers/META.md`
- `../ai-memory/META.md`
- `../llm-wiki/META.md`
- `../openviking/META.md`
- `../context-memory-harness-engineering/META.md`
