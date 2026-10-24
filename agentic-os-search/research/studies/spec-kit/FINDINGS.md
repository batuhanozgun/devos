# GitHub Spec Kit — Work-Control Findings

Pinned source: `github/spec-kit@0ced2885af4b90266c11feb598c7425cdc706aea` (`main`), observed 2026-09-17. Latest observed release: `v1.0.7`.

## 1. Spec Kit separates multiple kinds of work artifact and authority

The core SDD process uses distinct artifacts/roles:

- **constitution** — project principles/governance constraints;
- **specification** — what/why, user stories, requirements and acceptance scenarios;
- **plan** — implementation architecture/technical decisions;
- **tasks** — executable work decomposition;
- **code** — realized implementation;
- **convergence findings/tasks** — newly discovered remaining work after implementation.

This separation matters because each mismatch is supposed to return to the artifact that owns it instead of letting later artifacts silently redefine earlier intent.

## 2. The process has an intended order but is not one hard runtime state machine

The reference orders:

`constitution → specify → clarify → plan → checklist → tasks → analyze → implement → converge`

but explicitly states that only `specify` is strictly required before `plan`; clarify/checklist/analyze are optional quality gates.

The actual control is a mixture of:

- prerequisite scripts/checks;
- agent skill instructions;
- optional/mandatory extension hooks;
- human review/confirmation;
- durable Markdown artifacts.

### Research consequence

A process can be procedurally sequenced without having Flowable-style engine-enforced lifecycle state. Later design should distinguish:

`recommended/agent-procedural order` from `deterministically enforced transition`.

## 3. Task decomposition is user-story-centric and explicitly dependency-aware

`/speckit.tasks` requires spec + plan and generates:

- Phase 1 Setup;
- Phase 2 Foundational blocking prerequisites;
- one phase per prioritized user story;
- final Polish/cross-cutting phase.

Tasks have strict IDs, paths, story labels and optional `[P]` parallel markers. The generator must create a user-story dependency graph, independent test criteria and parallel examples.

The stated objective is that each story phase is a **complete, independently testable increment**.

### Research consequence

Spec Kit decomposes toward **value/behavior slices**, not only architecture layers. This gives us a different decomposition objective than WBS or generic task trees.

## 4. “Foundational” and story-local prerequisites are intentionally different

Shared tasks that block every user story are moved into Foundational. Story-specific setup stays with the story. Shared entities may be placed into the earliest story or setup/foundational location depending on their use.

### Research consequence

A dependency model can distinguish:

- global prerequisites that gate the whole frontier;
- local prerequisites internal to one deliverable slice.

This is relevant to large jobs where premature centralization of every dependency can serialize otherwise independent work.

## 5. Parallelism is declared at task granularity

A task receives `[P]` only when it can execute in parallel — typically different files and no dependency on unfinished tasks.

The method therefore turns decomposition into an execution hint:

`task identity + dependency + touched artifact/file → possible concurrency`.

However, `[P]` is generated/advisory metadata. This bounded slice did not establish a race-safe scheduler/claim protocol comparable to Beads.

## 6. Checklists distinguish reviewer-owned requirement quality from implementation completion

`/speckit.checklist` creates requirements-quality checks described as “unit tests for requirements.” The current reference explicitly says custom checklist items are reviewer-owned: an agent can help evaluate them only when asked; implementation must not silently self-approve them.

`/speckit.implement` reads checkbox state and asks before proceeding when checklist items remain unchecked, but must not change those markers.

### Research consequence

This is a concrete actor/authority split:

- implementation task progress can be agent-owned;
- requirements-quality acceptance can remain reviewer-owned.

The same checkbox syntax therefore does **not** imply the same semantics across artifacts.

## 7. Analyze sends defects back to their owning source

`/speckit.analyze` is read-only. It compares spec, plan and tasks for gaps/conflicts and recommends returning to:

- specify/clarify for requirement defects;
- plan for design defects;
- tasks for decomposition defects.

It does not automatically mutate them.

### Research consequence

Backward movement can be **source-directed repair**: fix the upstream artifact responsible for the inconsistency, then regenerate/re-evaluate downstream representation.

This is stronger than editing whichever downstream artifact is easiest, because it preserves provenance of intent.

## 8. Implement can be deliberately staged for long work

The reference explicitly recommends scoped implementation calls for large features so one agent context is not overwhelmed. A run can implement Setup+Foundational, stop, validate, then continue with one user story.

### Research consequence

The plan can define the entire feature while **execution admission is bounded per session**. Long-work management therefore needs a distinction between the whole remaining plan and the work slice admitted into the current actor/context.

## 9. Convergence turns observed implementation gaps into new work

`/speckit.converge` treats constitution/spec/plan/tasks as the intent inventory and examines current code. It classifies findings:

- missing;
- partial;
- contradicts;
- unrequested.

Findings have source refs and severity. If actionable findings exist, Converge appends a new `Phase N: Convergence` with new task IDs to the bottom of `tasks.md`. Existing tasks are never reordered, renumbered, deleted or rewritten.

If no gaps remain, tasks are byte-for-byte unchanged and the command reports Converged.

### Research consequence

The method models incomplete initial planning as normal. Rather than rewriting history, it creates a **monotonic remediation ledger**:

`original plan → implementation → evidence of gap → appended work`.

## 10. Convergence is based on present state, not change history

The current convergence prompt explicitly says it is not a diff tool and does not use git/branch history. It compares **present code** against intent.

This means it answers:

> “What remains inconsistent now?”

not:

> “How/why did we get here?”

### Research consequence

Convergence and provenance/history are separate concerns. A state-based reconciliation loop may need an additional decision/change log when causal history matters.

## 11. Convergence preserves traceability to source intent

Each appended remediation task includes a source reference such as:

- FR-003;
- SC-002;
- US1/AC2;
- plan decision;
- constitution article.

Constitution MUST violations receive highest severity.

### Research consequence

Newly discovered work need not be orphaned from original intent. A large-work system can attach **why this task exists** as a durable edge back to requirement/decision authority.

This is different from Beads' `discovered-from`, which records work-discovery provenance rather than normative requirement provenance.

## 12. Implement→converge is an explicit iterative completion loop

README says repeat `implement → converge` until convergence reports Converged.

The intended trajectory is:

1. execute known work;
2. assess realized state against intent;
3. materialize missing work as tasks;
4. execute the new work;
5. reassess.

### Research consequence

Completion can be an iterative fixed-point search rather than “finish initial task list.”

But it is only a useful fixed point if the convergence assessment is sufficiently complete/correct.

## 13. “Converged” remains a model judgment, not an independent oracle

The convergence command uses the agent to inspect bounded code scope and intent artifacts. It has structured inventory/gap/severity instructions, but source reading does not establish an independent evaluator.

Thus:

`convergence procedure` ≠ `proof of correctness`.

It can improve closure discipline while still sharing the implementation agent/model's blind spots unless independently separated by runtime/actor choices.

## 14. Task-to-issue transport is optional and increasingly modular

`/speckit.taskstoissues` can convert tasks to GitHub Issues, but is not required for implementation/convergence. Current v1.0.7 release notes say the GitHub-specific command is planned to move out of core into a bundled extension.

### Research consequence

The work methodology and the **external work-tracker substrate** are separable. One can derive tasks in local artifacts and later materialize them into another coordination system.

This is relevant if Development OS needs swappable work backends.

## 15. Extensions/hooks add control without changing core artifacts

Current command templates include before/after extension hooks. Some can be marked mandatory, causing the agent workflow to invoke them and wait; others are optional suggestions.

### Research consequence

A procedural work method can acquire additional policy/check/effect layers through extension hooks. But whether those hooks are deterministically guaranteed depends on the host/agent invocation path, not merely their declaration in Markdown.

## 16. Matrix snapshot

| Dimension | Spec Kit bounded observation |
|---|---|
| Work identity | feature/process artifacts plus derived task checklist and convergence remediation tasks |
| Decomposition | Setup → Foundational → independent prioritized story phases → Polish; task IDs and parallel markers |
| Dependency | phase/story/task ordering generated from artifacts; foundational global blockers; no persistent general dependency DB in core slice |
| Readiness | process preconditions + task phase/dependency semantics; session may admit subset of plan |
| State | artifact/process progression largely procedural; task checkboxes; convergence outcome |
| Ownership | agent implementation + reviewer-owned quality checklists; no CAS work claim found |
| Planning regime | spec-driven staged derivation with optional back-loops and later remediation |
| Uncertainty | clarify before planning; convergence captures missed work after implementation |
| Change | edit owning source artifact/regenerate downstream; convergence append-only for realized gaps |
| Backtracking | return to specify/plan/tasks for source defects; append remediation instead of rewriting completed task history |
| Scheduling | no classical calendar/CPM scheduling in core SDD |
| Resources | not a capacity/resource manager in this slice |
| Verification | optional analyze/checklists; converge structured reconciliation; not independent truth oracle |
| History | artifacts + append-only convergence tasks; convergence ignores git history by design |
| Coordination | artifact/skill workflow; optional task→GitHub issues; no built-in liveness lease |
| Recovery | durable artifacts/tasks; rerun implement on pending work and converge on current state |
| Portfolio | feature-level process; extensions/bundles not a program/portfolio model |
| Execution coupling | agent procedure invokes code work; not a durable external execution engine |

## 17. Method learnings after U05

U05 adds four distinctions:

1. **whole-plan state ≠ current-session admitted work slice**;
2. **requirements-quality approval ≠ implementation task completion**;
3. **source-directed repair ≠ arbitrary downstream patching**;
4. **initial-plan completion ≠ convergence with realized state**.

## 18. Open questions intentionally outside U05

- live quality/effect of convergence across different agents/models;
- whether repeated converge passes empirically approach correctness;
- how multi-agent concurrent implementation interacts with one tasks.md;
- deterministic enforcement of mandatory extension hooks across hosts;
- extension/preset/bundle ecosystem as a general work-method composition system;
- non-software applicability of SDD decomposition.
