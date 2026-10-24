# DeepSeek Harness — Study Metadata

## Identity and status

- **Study ID:** `deepseek-harness`
- **Title:** DeepSeek Harness — Composable Agent Harness Runtime
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, source corpus, findings, synthesis or adoption work has begun.
- **Research object:** `deepseek-ai/deepseek-harness` as an implemented general-purpose agent harness and as a repository that exposes an agent-oriented development discipline around that harness.
- **Canonical external target:** https://github.com/deepseek-ai/deepseek-harness
- **Observed default branch during preliminary qualification:** `master`
- **Discovery / qualification date:** 2026-09-17
- **Pinned research ref:** none. A source snapshot must be revalidated and pinned when detailed research is actually authorised.
- **Freshness risk:** high. The target described itself during preliminary qualification as developer-preview software with compatibility-breaking changes expected.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- an explicit "everything is a plugin" harness architecture;
- replaceable/composable runtime surfaces including model, tools, session, prompt and agent-loop concerns;
- profile/bundle/patch composition of running harness instances;
- append-only session/event sourcing and reconstruction of model-visible history;
- capability, policy, sandbox, approval and tool-execution seams;
- continuable subagent/delegation mechanisms and agent-lifecycle questions;
- repository-native agent instructions, notes and skills that may provide a separate Development OS comparison surface.

These observations justify later investigation; they do not establish that the mechanisms work as documented, are well designed, are generally applicable or should be adopted.

## Candidate primary question / purpose

If this study is later authorised, investigate how DeepSeek Harness decomposes an agent harness into composable runtime primitives, lifecycle/state mechanisms, capability and policy seams, context/session surfaces and delegation structures; then separately examine how the repository governs agent-assisted development of that system.

A central comparison question is whether this implemented system materially informs or falsifies the idea that SOUL should be capable of constructing or composing task-appropriate harnesses rather than itself being one fixed harness.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially strong for event-sourced interaction state, model-visible context reconstruction, prompt assembly, persistence, replay and provenance questions.
- **Work:** potentially strong for turn/step lifecycle, cancellation, background work, continuation and runtime execution control.
- **Actors:** potentially strong for agents, subagents, delegation, parent/child authority, human approval and coordination surfaces.
- **Environment:** potentially strong for capability composition, tools, filesystem/process/sandbox/provider seams and runtime configuration.
- **Relations / control:** potentially strong cross-cutting relevance for composition, scoping, registration, policy interception, lifecycle ownership and reversible effects.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- pressure-testing the distinction between a fixed harness and a system capable of composing harnesses;
- identifying candidate harness primitives and checking whether they are actually separable in a working implementation;
- studying task-/scope-conditioned capability, context, policy and runtime composition;
- comparing persistent interaction state, live runtime state and model-visible state;
- examining delegation and continuation without assuming the DeepSeek decomposition is correct.

No SOUL architecture decision is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- a large implemented agent-runtime repository as a comparison target for development-system controls;
- repository-local agent instructions, skills and architecture/decision notes;
- mechanically checked invariants, test/snapshot/e2e discipline and documentation synchronization;
- source/artifact, persistence and lifecycle rules that may provide comparison cases for repository-mediated agent work.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- implementation-learning reference;
- real-system pressure test / falsifier;
- candidate mechanism source;
- failure-mode and boundary case source;
- comparison target for harness/runtime architecture;
- benchmark/test-case or verification-pattern source.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- investigating harness architecture or harness composition;
- examining whether SOUL should create/compose task-specific harnesses;
- studying runtime capability/policy/context composition;
- deepening session, persistence, replay or model-visible state questions;
- comparing subagent/delegation/continuation architectures;
- comparing agent-native repository/development disciplines.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- No source ledger, full topology coverage, code-path validation, local execution, test campaign, runtime verification, independent verification or closure audit exists for this package.
- Preliminary observations must not be cited as established study findings without re-entering the authoritative external source.
- The target's documentation describes intended/current repository design but does not by itself prove runtime behavior or efficacy.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, dependency selection or implementation policy.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check the current upstream repository and default branch;
2. choose and record a pinned source commit/ref;
3. compare material changes since this qualification date when useful;
4. establish an explicit research method and scope before accumulating findings;
5. keep preliminary qualification observations separate from later source-grounded findings.

Because the target is fast-moving developer-preview software, current operational or adoption claims require fresh authoritative-source validation even after a future bounded study is completed.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, `INDEX.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../context-memory-harness-engineering/` — focused-topic context/memory/harness boundaries;
- `../gstack/` — implemented agentic software factory and runtime/control case;
- `../hermes-agent/` — agent runtime, persistence, learning and delegation mechanisms;
- `../superpowers/` — portable procedural skills and host-conditioned workflow behavior;
- `../the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering/` — harness composition/evolution investigation.

These relations are discovery hints, not corroboration or evidence.