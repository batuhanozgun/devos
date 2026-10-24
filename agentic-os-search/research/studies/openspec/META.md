# OpenSpec — Study Metadata

## Identity and status

- **Study ID:** `openspec`
- **Title:** OpenSpec — Artifact Dependency Graph, Living Plan and Apply Readiness
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U04 of `work-management-project-control` completed as a source-bounded artifact/spec workflow study; no live coding-agent campaign, team/store deployment or outcome evaluation was performed.
- **Research object:** `Fission-AI/OpenSpec` as an artifact-guided specification/workflow system where planning artifacts form a configurable dependency DAG, implementation readiness is separately defined, task checkboxes track apply progress, and change artifacts remain editable throughout execution.
- **Canonical external target:** https://github.com/Fission-AI/OpenSpec
- **Observed default branch:** `main`
- **Pinned research ref:** `bae58cf61479986431bb798acbe5a688a591c18c`
- **Observed latest release:** `v1.13.1` (published 2026-09-17)
- **Research date:** 2026-09-17
- **License observed:** MIT
- **Freshness risk:** high. OpenSpec's artifact graph, schemas, stores, profiles, archive/validation rules and generated agent workflows are changing rapidly; current HEAD is newer than the observed v1.13.1 release target.

## Primary question / purpose

What does work control look like when the graph is not primarily a graph of executable tasks, but a graph of **planning artifacts** whose completion progressively unlocks more planning and eventually implementation?

This unit contrasts artifact-generation readiness and a living plan with Beads' executable-work frontier, OpenProject's project control and Flowable's durable execution engine.

## Source-bounded synthesis

OpenSpec separates durable current behavior (`openspec/specs/`) from proposed changes (`openspec/changes/<change>/`). A change is a self-contained set of artifacts such as proposal, delta specs, design and tasks; archiving reconciles/merges deltas into the current-spec source of truth while preserving the change history.

A workflow schema defines a DAG of artifacts. Each artifact has an ID, output path/glob, template, instruction and `requires` list. An artifact is **ready** once all required artifact IDs are complete; invalid dependency IDs and cycles fail schema validation. Multiple ready artifacts are ordered by schema declaration order. `apply.requires` is a separate gate for implementation instructions, and an optional tracked tasks file adds apply states such as `blocked`, `ready` and `all_done`.

Artifact completion is deliberately lightweight: for ordinary artifacts OpenSpec checks whether the declared output exists (or a glob matches at least one file). It does not establish semantic quality simply by declaring the artifact `done`. The instruction/status layer keeps dependency IDs even for already-done artifacts and can warn when an artifact is requested while dependencies are missing.

The planning model is intentionally **fluid** rather than phase-locked. Proposal/design/spec/tasks are plain Markdown and may be edited after implementation has started. `tasks.md` is a living checklist: tasks may be added, removed or reordered as work reveals new information. Code and artifacts can drift in either direction; the documented reconciliation rule is to make artifacts honest about implemented behavior before archive. `/opsx:verify` is a check surface, not a mandatory state gate.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** strong for artifact-producing work, progressive planning, living task lists, implementation handoff and revision.
- **Actors:** conditional/strong for human review versus agent drafting/applying and explicit confirmation surfaces.
- **Information:** very strong for current-spec truth versus change deltas, proposal/design/task separation, archive/history and cross-repo planning stores.
- **Environment:** conditional for agent-tool integration, schema resolution and external planning stores.
- **Relations / control:** very strong for artifact dependency DAG, planning readiness, separate apply readiness and archive/sync semantics.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- distinguish prerequisites needed to **form a trustworthy plan** from dependencies between executable work items;
- make work products/artifacts first-class nodes rather than reducing everything to tasks;
- separate “artifact exists” from “artifact is correct/accepted” and “implementation is complete”;
- allow planning artifacts to remain living representations during execution rather than freezing a waterfall handoff;
- support custom workflow schemas selected by the kind of work rather than one universal document sequence;
- preserve proposed deltas separately until they are reconciled into an authoritative current-state representation.

No SOUL specification/workflow architecture is authorised or implied.

## Potential Development OS relevance

- artifact dependency graph and progressive planning readiness;
- current-state specification versus proposed-delta packages;
- separate planning-complete and implementation/apply state;
- living tasks with resume from unfinished checklist items;
- explicit edit/reconcile/archive loop;
- custom workflow schemas and project/user/package resolution;
- cross-repository planning stores as a candidate work-information substrate.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- artifact-workflow reference;
- counterexample to task-only work graphs;
- planning-readiness versus execution-readiness pressure test;
- living-plan revision mechanism source;
- comparison target for Spec Kit and Beads;
- source of verification/archive consistency test cases.

## What should not be inferred

- Artifact `done` does not establish semantic correctness; ordinary completion is primarily file-existence based.
- A ready artifact means its declared planning dependencies are satisfied, not that the change is approved or safe to implement.
- An unchecked/checked task list is not independent evidence that code is correct.
- Fluid editability does not itself solve downstream invalidation: editing proposal/design/tasks can make previously produced artifacts stale even if their files still exist.
- `/opsx:verify` existing as a command does not mean every workflow run actually invokes it before archive.
- Source reading does not establish that OpenSpec improves engineering outcomes or that its artifact sequence is optimal for non-software work.

## Freshness / revalidation

Re-check current main/release before load-bearing reuse, especially artifact completion rules, `apply.requires`, tracked task parsing, archive safety, stores and custom schema behavior.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; OpenSpec is U04
- `../beads/` — work-item readiness graph contrast
- `../mattpocock-skills/` — living issue-tracker/Wayfinder work artifacts
- `../superpowers/` — approval/spec/plan artifact handoffs
