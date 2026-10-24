# GitHub Spec Kit — Study Metadata

## Identity and status

- **Study ID:** `spec-kit`
- **Title:** GitHub Spec Kit — Spec-Driven Decomposition and Implement→Converge Work Loop
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U05 of `work-management-project-control` completed as a source-bounded agentic SDD/work-decomposition study; no live feature implementation, multi-agent campaign or outcome evaluation was performed.
- **Research object:** `github/spec-kit` as an agentic software-development work method that separates constitution, specification, planning, task decomposition, implementation and convergence, with optional requirements-quality and consistency gates.
- **Canonical external target:** https://github.com/github/spec-kit
- **Observed default branch:** `main`
- **Pinned research ref:** `0ced2885af4b90266c11feb598c7425cdc706aea`
- **Observed latest release:** `v1.0.7` (published 2026-09-15)
- **Research date:** 2026-09-17
- **License observed:** MIT
- **Freshness risk:** high. Core skills, convergence, extensions/presets/bundles and task→issue boundaries are actively evolving; current main is newer than v1.0.7.

## Primary question / purpose

How can a large software feature be progressively transformed from intent into independently executable work, then repeatedly checked against its original intent so implementation gaps become **new explicit work** rather than silently accepted drift?

This unit contrasts a procedural agent-driven methodology with OpenSpec's artifact DAG, Beads' persistent work frontier and Flowable's runtime execution engine.

## Source-bounded synthesis

Spec Kit's SDD process is:

`constitution → specify → [clarify] → plan → [checklist] → tasks → [analyze] → implement → converge`

The commands are intended to run in order, but the reference explicitly says only specification is strictly required before planning; several stages are optional quality gates rather than one hard engine state machine.

`/speckit.tasks` translates spec/plan/design material into a dependency-ordered `tasks.md`: Setup, Foundational blocking prerequisites, one independently testable phase per prioritized user story, and final cross-cutting polish. Tasks carry sequential IDs, optional parallel markers, story labels and concrete file paths; the generated plan includes story dependency/parallelism and an MVP-first implementation strategy.

`/speckit.implement` executes the task phases and can be scoped to a subset for large features. Requirements-quality checklists can act as a human/reviewer gate: unchecked checklist items prompt before proceeding, and implement must not self-mark them approved.

`/speckit.converge` is the most distinctive control mechanism. It treats the constitution + spec + plan + tasks as intent, inspects current code, classifies missing/partial/contradictory/unrequested gaps and either reports `Converged` or **appends** a new Convergence phase to `tasks.md`. It does not rewrite earlier tasks/spec/plan or code. The intended loop is therefore:

`implement → converge → append missing work → implement → converge → ...`

until no actionable gaps are found.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong for staged decomposition, blocking foundations, independent slices, progressive execution and convergence-generated rework.
- **Actors:** strong/conditional for reviewer-owned checklist gates, agent execution and optional human supervision.
- **Information:** very strong for constitution/spec/plan/task separation, source-ref traceability and consistency analysis.
- **Environment:** conditional for coding-agent integrations, extensions/hooks and task→issue transport.
- **Relations / control:** strong for phase/task dependency, optional gates, parallel markers, source→remediation traceability and convergence loop.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- transform a high-level job into success-oriented slices while preserving traceability to requirements and governing constraints;
- use a convergence/reconciliation loop when initial decomposition is inevitably incomplete;
- distinguish foundational prerequisites from story-local work and parallelizable work;
- let newly observed implementation gaps become additional explicit work rather than retroactively pretending the original plan was complete;
- keep reviewer-owned acceptance surfaces separate from agent-owned implementation progress;
- pressure-test whether a procedural agent method needs a stronger durable work substrate for long/multi-actor work.

No SOUL development methodology is authorised or implied.

## Potential Development OS relevance

- requirement → plan → task derivation;
- independent user-story slices and MVP-first progression;
- phase-level prerequisite structure and parallel markers;
- read-only cross-artifact analysis before execution;
- implement→converge iterative recovery;
- append-only remediation tasks with source references;
- optional transport from tasks into external issue trackers;
- constitution/governance constraints that remain visible across the process.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- agentic decomposition methodology reference;
- convergence/rework loop source;
- reviewer-vs-agent authority case;
- procedural-control versus runtime-enforcement contrast;
- comparison target for OpenSpec, Beads and gstack;
- test-case source for traceability, missed work and plan/code drift.

## What should not be inferred

- The command sequence is not equivalent to a durable engine-enforced state machine.
- A generated task graph is not proof that the decomposition is complete or causally correct.
- `Converged` is an agent assessment against selected artifacts/code scope, not an independent verification oracle.
- Repeated convergence is not proven to monotonically reach correctness; newly appended tasks can themselves be wrong/incomplete.
- The constitution's stated authority is mediated by the agent/workflow instructions unless reinforced by deterministic tooling/extensions.
- Source reading does not establish that SDD outperforms other development methods or generalizes to non-software project management.

## Freshness / revalidation

Re-check current main/release before load-bearing reuse, especially converge semantics, checklist authority, extensions/hooks, task generation, issue-tracker integration and process customization.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; Spec Kit is U05
- `../openspec/` — U04 artifact-DAG/living-plan contrast
- `../beads/` — durable ready-work/claim graph contrast
- `../gstack/` — broader implemented agentic software-factory comparison
- `../superpowers/` — procedure/approval/plan artifact handoffs
