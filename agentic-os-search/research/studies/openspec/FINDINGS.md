# OpenSpec — Work-Control Findings

Pinned source: `Fission-AI/OpenSpec@bae58cf61479986431bb798acbe5a688a591c18c` (`main`), observed 2026-09-17. Latest observed release: `v1.13.1`.

## 1. OpenSpec manages a change through durable artifacts, not one mutable task record

OpenSpec separates:

- `openspec/specs/` — the current behavior/source-of-truth representation;
- `openspec/changes/<change>/` — proposed change package;
- artifacts inside the change, commonly proposal, delta specs, design and tasks;
- archive history after the change is reconciled.

The change folder bundles different epistemic roles rather than treating all planning information as task metadata:

- proposal = intent/scope/high-level approach;
- spec delta = changed behavior/requirements;
- design = technical approach;
- tasks = implementation checklist.

### Research consequence

A work system can model **artifacts produced by reasoning and planning** as first-class work-state, not only executable tasks.

## 2. Artifact dependencies form a configurable DAG

A workflow schema defines artifact entries with:

- stable artifact ID;
- generated output path/glob;
- template/instruction;
- `requires` dependencies.

OpenSpec validates that dependencies point to known artifact IDs and that the graph contains no cycles. The `ArtifactGraph` computes a topological order and ready artifacts.

An artifact is ready when every required artifact is in the completed set. Sibling artifacts that become ready simultaneously are ordered by their declaration order in the schema.

### Contrast with Beads

Both systems have a graph and a ready set, but the meaning differs:

- **Beads ready:** the work item is actionable under the current work graph/lifecycle/deferral state.
- **OpenSpec artifact ready:** the information/artifacts declared necessary to produce this planning artifact exist.

Graph shape alone does not make two frontier systems equivalent.

## 3. Artifact completion is intentionally weak evidence

For ordinary schema artifacts, completion detection is primarily output existence:

- a declared file is complete if it exists;
- a glob artifact is complete when at least one matching file exists.

The system does not read ordinary artifact content to establish that the proposal/spec/design is semantically adequate before marking that artifact done.

`ArtifactStatus` explicitly carries `done`, `skipped`, `ready` or `blocked`; source comments note that even a `done` artifact can still expose its `requires`, because file-existence status does not imply its dependencies currently exist.

### Research consequence

At least three standings must be kept separate:

1. artifact materialized;
2. artifact semantically acceptable/current;
3. artifact dependencies/context still valid.

A filename on disk is not an epistemic approval.

## 4. Planning readiness and implementation readiness are separate

The schema's artifact-level `requires` controls artifact generation order.

A separate `apply.requires` list controls when implementation/apply instructions become ready. The default is that all artifacts are required before apply, but a custom schema may choose a subset.

If `apply.tracks` points at a task Markdown file, OpenSpec derives an additional apply progress state:

- `blocked` — task file missing/no recognized task checkbox;
- `ready` — at least one tracked task remains pending;
- `all_done` — every tracked task checked.

### Research consequence

“Planning complete”, “implementation may start”, “implementation has unfinished tasks” and “tasks all checked” are different state dimensions.

This parallels the parent study's growing pattern that one generic `done`/`ready` status is too coarse.

## 5. Dependencies guide progression but do not freeze the workflow

OpenSpec describes itself as fluid rather than phase-gated. Artifact dependencies determine what the system recommends/is ready to produce, but artifacts are plain Markdown and can be revised at any point.

The instruction system can even return instructions for a currently blocked artifact with a warning about missing dependencies rather than making the file physically impossible to create.

### Research consequence

A dependency can be an **advisory/generation-readiness constraint** rather than an absolute authorization boundary.

This distinction should be preserved in later systems:

`not recommended/ready` ≠ `technically forbidden`.

## 6. A living plan permits backtracking without phase reversal

The editing guide explicitly rejects a locked sequence. If implementation reveals the design is wrong, the user/agent edits `design.md` and continues. Proposal/spec/tasks may also be revised mid-flight.

There is no separate “return to planning state”; planning artifacts remain accessible and editable throughout execution.

This is a different model of backward movement from:

- OpenProject reopening a status;
- Flowable migrating/compensating a running execution;
- Beads reopening a completed graph node.

Here, “go back” often means **revise the current artifact representation in place** and continue from its new content.

## 7. Task decomposition is expected to evolve during implementation

`tasks.md` is documented as a living checklist. During apply, tasks may be:

- checked off;
- added when new work is discovered;
- removed when unnecessary;
- reordered.

The apply workflow resumes from pending tasks rather than requiring the initial task list to remain fixed.

### Research consequence

OpenSpec gives a concrete counterexample to “a good plan must completely decompose the work before execution begins.”

However, it does not provide Beads-like dependency/claim semantics between checklist items in the default task representation.

## 8. Change versus new change is an intent-boundary decision

The editing guidance differentiates:

- same goal, better approach → revise existing change;
- narrower scope/MVP → revise then possibly create later follow-up;
- fundamentally different problem/intent → create a new change.

This gives “identity of work” an explicit conceptual boundary: work remains the same change while the underlying intent remains sufficiently stable.

### Research consequence

Replanning may preserve work identity only up to an intent/scope threshold. Beyond that, superseding/new work may be cleaner than mutating history.

## 9. Code/artifact drift is reconciled bidirectionally

OpenSpec expects manual code changes and planning edits. When code and artifacts diverge:

- if code is now the intended truth, update the delta spec/tasks;
- if the spec remains authoritative, alter code until it conforms.

The documented archive boundary raises the importance of reconciliation: before archive, specs should honestly represent what the code does because archival merge updates the current spec truth.

### Research consequence

A durable plan is not automatically authoritative forever. A work system needs a rule for **which representation wins when observed reality and planned representation diverge**.

## 10. Verify is an explicit check, but not the workflow's causal gate

The expanded workflow offers `/opsx:verify` to check completeness, correctness and coherence. Documentation recommends using its output to reconcile code/artifacts.

But the system deliberately remains fluid: verify does not become a mandatory phase or universal blocking transition merely by existing.

### Research consequence

Verification capability, recommended verification and enforced verification are separate.

This mirrors findings from Superpowers/gstack and matters for later Development OS control design.

## 11. Archive changes authority/standing

The concepts model distinguishes proposed changes from current specs. When a change is archived, its deltas are reconciled into the main specs and the change moves to archival history.

Recent v1.13.1 release notes add stronger archive preconditions/validation for malformed requirement rename/removal cases and bulk archive target checks.

### Research consequence

Archive is not just “move completed files away”: it is a transition where proposed knowledge can become the maintained source-of-truth representation. That transition deserves stronger qualification than artifact-file existence.

## 12. Custom schemas make the work method configurable

Project/user/package schemas may change:

- artifact types;
- outputs/templates;
- dependency graph;
- implementation prerequisites;
- tracked task file;
- instructions.

The schema itself is therefore a **work-method definition**.

A change records its schema in metadata and can retain that schema even if project defaults later change, protecting in-flight work from silent methodology drift.

### Research consequence

The work system can separate:

`work instance` from `work-method/schema version/selection`.

This becomes important if SOUL later chooses a method dynamically based on work type.

## 13. Cross-repository planning stores separate plan location from execution repositories

OpenSpec Stores are designed so the planning/spec/change repository can live separately and be shared across multiple code repositories. A cross-repo feature can have one change/plan while code is implemented elsewhere.

This is still beta and was not exercised in this study.

### Research consequence

The authoritative work/plan substrate does not have to be colocated with every execution environment, provided bindings to execution targets remain unambiguous.

## 14. Uncertainty is handled through explore + editable artifacts rather than a formal fog object

The `/opsx:explore` flow supports pre-change reasoning before a change is created. Changes can then evolve as understanding deepens.

Unlike Wayfinder, this bounded slice did not identify a persistent first-class “known but not yet specifiable” region inside the change graph. Uncertainty is managed by exploration and artifact revision rather than an explicit fog/frontier object.

## 15. Ownership / actor coordination is comparatively light in the artifact graph

OpenSpec is designed for human+agent collaboration and review, but the artifact DAG itself does not provide Beads-style claim/lease semantics for multiple concurrent agents competing for the next artifact/task.

Team Stores and git provide sharing/history, but this slice did not establish race-safe artifact ownership or actor liveness.

This is a useful negative comparison, not a defect claim: the target's research object is spec/change coordination, not a worker scheduler.

## 16. Matrix snapshot

| Dimension | OpenSpec bounded observation |
|---|---|
| Work identity | Change containing differentiated planning artifacts and implementation tasks |
| Decomposition | artifact DAG + hierarchical Markdown task checklist |
| Dependency | `artifact.requires`; separate `apply.requires`; no generic work dependency ontology |
| Readiness | artifact ready when requirements complete; apply readiness separately derived |
| State | artifact done/skipped/ready/blocked; apply blocked/ready/all_done; change archive state |
| Ownership | human+agent collaboration; no CAS claim/lease found for artifact work |
| Planning regime | iterative/living artifacts; custom schema defines method |
| Uncertainty | explore before/around change; artifacts revised in place; no persistent fog object established |
| Change | freely edit proposal/spec/design/tasks during implementation |
| Backtracking | revise artifact/reconcile reality; new change when intent fundamentally changes |
| Scheduling | no classical date/critical-path scheduling in core artifact model |
| Resources | not a resource/capacity manager in this slice |
| Verification | validation + optional verify; artifact existence not semantic verification |
| History | change folders/archive/git; proposed vs current specs separated |
| Coordination | shared files/stores/agent commands; actor claim/liveness not established |
| Recovery | status computes next artifact/action from durable change files/schema |
| Portfolio | cross-repo planning stores; no project/program/portfolio model established |
| Execution coupling | apply instructions drive agent work, but CLI mostly governs artifacts rather than executing a durable process engine |

## 17. Method learnings after U04

U04 adds four distinctions to the parent program:

1. **work item ≠ work artifact** — some prerequisites exist to create a reliable representation before execution;
2. **materialized artifact ≠ semantically accepted artifact**;
3. **planning readiness ≠ implementation readiness ≠ implementation completion**;
4. **method/schema can be an explicit object distinct from the work instance using it**.

## 18. Open questions intentionally outside U04

- live multi-agent/team coordination over Stores;
- whether editing upstream artifacts automatically flags downstream artifacts stale enough for real workflows;
- efficacy of `/opsx:verify` and archive discipline in practice;
- semantic quality of AI-generated specs/design/tasks;
- custom schema adoption and version migration;
- non-software use cases and whether this artifact model generalizes beyond coding work.
