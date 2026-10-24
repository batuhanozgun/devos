# CLI Continues — Study Metadata

## Identity and status

- **Study ID:** `cli-continues`
- **Title:** CLI Continues — Cross-Agent Coding Session Continuation and Handoff
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. Candidate registration and preliminary intake only; no detailed research, fidelity test, runtime campaign or adoption work has begun.
- **Research object:** `yigitkonur/cli-continues` as a cross-tool continuation layer that discovers native AI coding sessions, parses heterogeneous session formats, supports same-tool native resume and builds structured handoff context for continuation in another coding agent.
- **Canonical external target:** https://github.com/yigitkonur/cli-continues
- **Observed default branch during intake:** `main`
- **Observed upstream snapshot during intake:** `e486cd22a592d89d890cff056624647fbe9cbe80`
- **Registration / intake date:** 2026-09-20
- **Registration authority:** user requested adding the repository to the studies candidates for later research. This is not authorisation to start detailed research or adopt the tool.
- **Pinned research ref:** none. Revalidate upstream and deliberately select a research snapshot when detailed study is authorised.
- **Freshness risk:** high; supported coding agents, native session schemas, resume mechanisms, flags and destination-client behavior are time-sensitive.

## Why this candidate is registered

The upstream README describes discovery across many AI coding tools, parsing of heterogeneous native formats, extraction of recent conversation/file/tool/work-state information, same-tool native resume and generation/injection of a structured handoff document for cross-tool continuation.

These are source-description signals, not validated findings.

## Candidate primary question / purpose

If later authorised, investigate what information is required to continue coding work across heterogeneous agent harnesses; what can be faithfully reconstructed from native session stores; what is lost or transformed in a generated handoff; how current repository state interacts with historical conversation state; and how source/destination capability, authority and environment differences should be represented.

A key question is whether cross-agent continuation is fundamentally a session-transcoding problem, a work-state handoff problem, or a composition of both.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** potentially very strong for unfinished-work continuation, handoff and resumption semantics.
- **Information:** potentially very strong for session representation, extraction, compression, provenance and source/current-state separation.
- **Environment:** potentially strong for host-specific storage formats, CLI adapters, launch flags and destination capabilities.
- **Actors:** conditional relevance for source/destination agent responsibility and handoff acceptance.
- **Relations / control:** potentially strong for session→handoff→resume transitions, fidelity, authority and freshness.

These are retrieval hints only, not Foundation taxonomy assignments.

## Potential SOUL relevance

Possible future value includes pressure-testing continuation as governed reconstruction rather than transcript transfer and separating durable work state, source session history and destination runtime context. No SOUL continuity architecture is implied.

## Potential Development OS relevance

Possible future value includes cross-harness work portability, resumable work packages, handoff schemas, adapter contracts, repository-state reconciliation, privacy boundaries and verification of handoff completeness. No adoption decision is implied.

## Reuse modes

Potential later roles include implementation-learning reference, work-continuity pressure test, handoff-schema candidate, cross-environment adapter case and failure-mode source.

## Likely revisit triggers

Revisit when studying session continuity, cross-agent handoffs, harness portability, durable work-state reconstruction, coding-agent interoperability, or Development OS handoff/resume mechanisms.

## Epistemic and authority boundary

- Detailed research has not started.
- Upstream documentation is not independent evidence that all supported session formats are parsed completely or that generated handoffs preserve all semantics required for correct continuation.
- No cross-tool matrix test, private-data audit, interrupted-refactor experiment, destination-behavior test or failure-recovery campaign has been performed by this project.
- Current checkout/repository truth must not be assumed equivalent to historical session state.
- Registration does not establish Foundation truth, SOUL / Development OS architecture or approval to use the tool.

## Freshness / research-start requirement

Before detailed research: re-check supported tools and current upstream; pin a commit/ref; inventory native session formats and adapter boundaries; define fidelity/privacy tests; and distinguish same-tool native resume from cross-tool reconstructed handoff.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package because research has not started.
