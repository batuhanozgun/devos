# Gas Town — Study Metadata

## Identity and status

- **Study ID:** `gastown`
- **Title:** Gas Town — Multi-Agent Work Allocation, Persistent Identity and Completion Convergence
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U07 of `work-management-project-control` completed as a source-bounded multi-agent orchestration study; no live town, swarm, merge queue or federated Wasteland campaign was run by this research project.
- **Research object:** `gastownhall/gastown` as a multi-agent work-orchestration environment that layers actor roles, convoys, hooks, workflow molecules, capacity scheduling, monitoring/recovery and merge/verification machinery on top of Beads-backed durable work state.
- **Canonical external target:** https://github.com/gastownhall/gastown
- **Observed default branch:** `main`
- **Pinned research ref:** `649b832b7672bc7a2dbef26f5983aba6198b819b`
- **Observed latest release:** `v1.2.1` (published 2026-06-06)
- **Research date:** 2026-09-17
- **License observed:** MIT
- **Freshness risk:** high. Main is materially ahead of the latest release and contains active convoy, molecule, completion, scheduler, refinery and recovery changes.

## Primary question / purpose

What additional control layers are required once a durable work graph exists but **many semi-reliable agents** must be dispatched, monitored, recovered, synchronized and brought to an integrated completion state?

This unit deliberately preserves the boundary between Beads (work-state graph/ready/claim substrate) and Gas Town (multi-agent orchestration and execution environment).

## Source-bounded synthesis

Gas Town does not replace Beads' work graph. Its README explicitly stores work state in the Beads ledger, and much of its orchestration queries/mutates beads. Gas Town adds a topology of durable/ephemeral actors and coordination mechanisms around that substrate.

Key actors/containers include Town, Rigs, Mayor, persistent-identity/ephemeral-session Polecats, Crew, Witness, Deacon/Dogs and Refinery. Each agent has a Hook: a pinned bead that functions as its primary work queue. Slinging work places it onto an actor's Hook. The stated GUPP rule is procedural: work on the Hook should be executed without waiting for another prompt.

**Convoys** are higher-level work orders tracking multiple beads. Convoy completion is derived from tracked issue completion; source and current lifecycle docs show close events trigger completion checks, next-ready feeding and eventual convoy closure. The daemon combines event polling with a stranded scan for crash/restart recovery. Adding work can reopen a closed convoy. Manual force-close/land paths deliberately override normal completion checks.

**Scheduler** is a separate capacity-control layer. It stores scheduling intent in ephemeral sling-context beads linked to untouched work beads. In deferred mode, it joins queued sling contexts with `bd ready`, available polecat capacity and batch-size limits before dispatch. Repeated dispatch failure trips a circuit breaker on the scheduling context while leaving the work bead itself unchanged.

**Molecules/Formulas** add reusable multi-step operating procedures. Root-only wisps keep steps inline and cheap; poured wisps materialize sub-steps for checkpoint recovery when losing intermediate progress would be costly. Polecat identity/work history persist while sessions are disposable, and recovery/restart can use durable Beads state/checkpoints rather than one process context.

The **Refinery** adds post-worker integration standing: work reported done can enter a merge/verification queue before reaching main. README describes Bors-style batching/bisecting and re-dispatch/fix of failed merge requests. Thus worker completion, convoy completion and integrated/verified mainline standing are separate layers.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong for multi-agent dispatch, work-order aggregation, capacity admission, workflow templates, completion convergence and integration queues.
- **Actors:** very strong for coordinator/worker/watchdog/refinery roles, persistent identity versus ephemeral session and escalation/recovery responsibility.
- **Information:** strong for Beads ledger, hooks, convoy history, handoffs, seance/session history and completion/merge evidence.
- **Environment:** very strong for worktrees, tmux/runtime processes, scheduler capacity, merge queues and federated/failure-prone execution environments.
- **Relations / control:** very strong for tracked-work convoys, hook assignment, scheduler contexts, readiness joins, actor monitoring, completion propagation and verification/integration standing.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- separate durable work state from the orchestration layer that allocates it to actors;
- model persistent actor identity independently from disposable execution sessions;
- combine work readiness with environment capacity before dispatch;
- recover from dead/stuck actors without losing the underlying work object;
- distinguish worker-reported completion from convoy/work-order completion and from integrated/verified system state;
- choose cheap inline workflow steps versus durable checkpointed steps according to loss/recovery cost;
- introduce watchdog/escalation roles only where the orchestration environment actually needs them.

No SOUL multi-agent architecture is authorised or implied.

## Potential Development OS relevance

- role topology for coordinator/worker/monitor/integrator;
- Hook-style actor work queues bound to a durable work substrate;
- convoy/work-order aggregation across several tasks;
- capacity-aware dispatch and circuit breakers;
- persistent identity with ephemeral sessions/worktrees;
- workflow formulas/molecules with optional checkpoint materialization;
- stranded-work scans, stuck-agent recovery and escalation;
- merge/verification queue after worker completion;
- separation of work bead, scheduling context and actor runtime state.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- multi-agent orchestration reference;
- actor-lifecycle and failure-recovery mechanism source;
- work-state/orchestration boundary counterexample;
- completion/integration standing pressure test;
- capacity/backpressure reference;
- comparison target for Beads, Flowable, gstack and multi-agent-patterns.

## What should not be inferred

- Gas Town's orchestration does not prove the underlying Beads graph/decomposition is correct.
- Initial batch sling can dispatch tracked beads in parallel even when Beads dependencies exist; dependency-respecting feeding is a later daemon path. Therefore “slinged” must not be equated with “ready under the work graph” in every dispatch mode.
- GUPP and agent role instructions are procedural policies; they are not equivalent to deterministic execution guarantees.
- Worker `gt done`, convoy closed and Refinery/mainline integration are different standings; none alone proves the requested business outcome is correct.
- Watchdog/recovery mechanisms improve liveness but do not prove exactly-once external effects after a crashed agent.
- Source reading does not validate claimed 20–30-agent scalability, cost efficiency or software-quality outcomes.
- Design documents may contain historical/future sections; findings use current source/implemented lifecycle where available rather than treating every roadmap statement as shipped behavior.

## Freshness / revalidation

Re-check current main/release before relying on convoy feed/closure, scheduler context, molecule/wisp checkpointing, role templates, `gt done`, Refinery/MQ and Gas Town↔Beads compatibility.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; Gas Town is U07
- `../beads/` — underlying durable work graph/readiness/claim substrate
- `../multi-agent-patterns/` — coordination/control topology research
- `../gstack/` — broader agentic software-factory comparison
- `../flowable/` — durable execution-engine contrast
