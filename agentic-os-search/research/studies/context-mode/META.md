# Context Mode — Study Metadata

## Identity and status

- **Study ID:** `context-mode`
- **Title:** Context Mode — Context Control, Retrieval and Session Continuity
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, pinned source corpus, findings, synthesis, benchmark reproduction or adoption work has begun.
- **Research object:** `mksglu/context-mode` as an implemented context-control layer for AI coding agents: tool-output routing, out-of-context computation, retrieval/indexing, session continuity and cross-host enforcement/adaptation.
- **Canonical external target:** https://github.com/mksglu/context-mode
- **Observed default branch during preliminary qualification:** `main`
- **Discovery / qualification date:** 2026-09-17
- **Observed upstream snapshot during qualification:** `5bca2948959a7fb538e895d9a032c1a19b8685a5` / package version `1.0.169`. This is a qualification observation, not the pinned corpus of a completed or active study.
- **Pinned research ref:** none. Revalidate upstream and deliberately choose a research snapshot when detailed research is authorised.
- **Freshness risk:** high; the target is actively changing and host integrations, routing rules, benchmarks and compatibility surfaces are time-sensitive.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- tool-output routing/interception intended to keep large raw outputs outside model-visible context;
- a “think in code” pattern that moves some information processing into executable computation and returns only selected results to the model;
- SQLite/FTS5 content indexing and BM25-style selective retrieval for exact source chunks;
- a separate persistent session-event store and compact/resume reconstruction path;
- snapshot reconstruction of active files, errors, decisions, rules, tasks, environment, subagents, skills, roles, goals and recent user messages;
- multiple host adapters and hook/instruction surfaces that expose a portability-versus-enforcement-equivalence question;
- security/permission/routing logic that should be distinguished from the product’s broader “sandbox” terminology;
- benchmark and byte-savings instrumentation that create a concrete verification target rather than a purely conceptual context-engineering claim.

These observations justify later investigation; they do not establish that the mechanisms work as documented, preserve task-relevant information, improve reasoning quality, are secure, are generally applicable or should be adopted.

## Candidate primary question / purpose

If this study is later authorised, investigate how Context Mode separates information persistence, retrieval, computation and model-visible context; how it restores work continuity across compaction/resume; how equivalent or non-equivalent control is implemented across different agent hosts; and what quality, security, latency and benchmark trade-offs result.

A central SOUL-facing comparison question is whether context should be treated as an actively governed runtime resource — where some information is persisted or computed outside the model and only selectively materialised into model-visible context — rather than as a passive container filled by tools and conversation history.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially strong for persistence versus availability versus retrieval versus model visibility; FTS5/BM25 retrieval; compaction/resume representation; provenance and selection failure modes.
- **Work:** potentially strong for long-running work continuity, active-goal/task reconstruction, compaction recovery, tool-output processing and return-to-work behavior.
- **Actors:** conditional/strong where host, model, user, hooks, subagents and tool-routing authority differ; especially instruction versus enforcement.
- **Environment:** potentially strong for MCP/hook capabilities, host-specific adapters, executable analysis, process access, permission surfaces and runtime constraints.
- **Relations / control:** potentially strong for routing, interception, materialisation, persistence-to-retrieval transitions, host portability and control-equivalence questions.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- pressure-testing the distinction between information that exists and information that should enter model context;
- studying whether deterministic computation should process some data before model reasoning rather than making the model consume raw data;
- treating context budget, retrieval and materialisation as runtime-governed resources;
- testing the difference between persisted information, retrievable information, selected information, model-visible information and information actually used;
- examining cross-host control composition without assuming all hook/instruction surfaces provide equivalent enforcement;
- comparing Context Mode with future harness-composition work such as `deepseek-harness` without collapsing the two systems into one layer.

No SOUL architecture decision is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- long-running work continuity and post-compaction recovery;
- deriving compact working state from activity/event history;
- preserving active objectives, pending tasks and recent decisions without replaying the entire historical record;
- progressive retrieval of detailed evidence on demand;
- host-dependent deterministic control versus procedural guidance;
- comparison between repository-canonical continuity and runtime/session-event continuity as potentially complementary mechanisms;
- measurable context-cost and retrieval-quality evaluation ideas.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- implementation-learning reference;
- context/memory/continuity pressure test or falsifier;
- candidate mechanism source;
- failure-mode and boundary case source;
- cross-host control/enforcement comparison target;
- benchmark/test-case and measurement-pattern source.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- deepening context engineering, memory, retrieval or persistence questions;
- designing or evaluating compaction/resume continuity;
- deciding what information should enter model-visible context versus stay external;
- examining deterministic computation as a preprocessing/analysis layer for agent work;
- comparing host-portable instructions, hooks and actual enforcement;
- studying context-budget governance or context-quality benchmarks;
- comparing SOUL/Development OS continuity with runtime/session-event approaches.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- No source ledger, full topology coverage, local installation, live host campaign, benchmark reproduction, security test, task-quality evaluation, independent verification or closure audit exists for this package.
- Preliminary observations must not be cited as established study findings without re-entering the authoritative external source.
- The target’s documentation and source code can establish intended/implemented mechanisms at inspected paths; they do not by themselves establish end-to-end efficacy across supported hosts.
- Repository benchmark claims are not treated as independently verified. During qualification, `BENCHMARK.md` referenced some reproduction scripts not present under the same names in the observed `package.json`; a future study should explicitly resolve benchmark/version drift before relying on headline savings claims.
- The product’s “sandboxed execution” terminology must not be silently equated with strong process/security isolation. Qualification source inspection showed temporary-script execution with project-root working context plus separate security/routing controls; exact containment properties require dedicated investigation.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, dependency selection or implementation policy.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check current upstream HEAD, package version and supported-host surface;
2. deliberately choose and record a pinned source commit/ref;
3. establish an explicit source-first research method and bounded questions;
4. separate documented claims, source-observed mechanisms, reproduced behavior and independent verification;
5. reproduce or otherwise revalidate benchmark/test claims before using them as load-bearing evidence;
6. distinguish context containment, process execution, permissions and security isolation rather than inheriting product terminology uncritically;
7. keep preliminary qualification observations separate from later source-grounded findings.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, `INDEX.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../context-memory-harness-engineering/` — focused-topic context, memory and harness boundaries;
- `../ai-knowledge-strategies/` — retrieval, long-context and external knowledge mechanism boundaries;
- `../superpowers/` — host portability, procedural control and instruction-versus-enforcement questions;
- `../hermes-agent/` — persistence, retrieval, continuation and agent-runtime mechanisms;
- `../deepseek-harness/` — composable agent-harness runtime architecture;
- `../the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/` — memory functions, temporal state and context-materialisation questions.

These relations are discovery hints, not corroboration or evidence.
