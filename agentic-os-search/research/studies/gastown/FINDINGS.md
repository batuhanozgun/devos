# Gas Town — Work-Control Findings

Pinned source: `gastownhall/gastown@649b832b7672bc7a2dbef26f5983aba6198b819b` (`main`), observed 2026-09-17. Latest observed release: `v1.2.1`.

## 1. Gas Town is an orchestration layer around a durable Beads work substrate

Gas Town's README is explicit that work state is stored in the Beads ledger. Convoys track bead IDs, `gt sling` dispatches bead work, scheduler readiness joins against `bd ready`, and source wrappers call `bd close`/other bead operations.

### Research consequence

A work system can separate:

- **work substrate** — identity, dependency, readiness, status/history;
- **orchestration substrate** — actor allocation, capacity, runtime lifecycle, monitoring, handoff and integration.

These do not have to be the same component.

## 2. Actor identity and execution session have different lifetimes

Gas Town distinguishes:

- Mayor — town-level coordinator;
- Polecat — worker with persistent identity/history but ephemeral execution sessions;
- Crew — longer-lived named collaborator;
- Witness — per-rig worker lifecycle monitor;
- Deacon/Dogs — background watchdog/maintenance roles;
- Refinery — merge/integration queue role.

Polecats work in isolated git worktrees. Sessions can end/restart while the persistent actor bead and work history remain.

### Research consequence

For agents, identity should not automatically equal one model process/session. An actor may have durable standing/history while its runtime instances are replaceable.

This extends the Beads finding `claim ≠ liveness` into:

`actor identity ≠ current runtime session`.

## 3. Hooks turn durable actor assignment into a local work queue

Each agent has a Hook, described as a special pinned bead and primary work queue. `gt sling` places work on that Hook. The GUPP principle instructs an agent with work on its Hook to run it without waiting for another user prompt.

### Research consequence

A multi-agent system may benefit from an explicit **actor-local admitted-work surface** derived from the global work graph.

This is another instance of:

`whole work graph ≠ work currently admitted to one actor`.

But GUPP itself is an instruction/policy; this slice does not establish deterministic enforcement that an arbitrary agent will always obey it.

## 4. Convoys aggregate work without replacing the underlying task graph

Convoys are work orders that track multiple beads via `tracks` relations. They can be created manually, automatically by sling or from formula runs.

Convoy progress/completion is derived from tracked bead status rather than storing a separate independent decomposition. Source and current lifecycle docs show:

- closing an issue triggers convoy completion checks;
- if not all tracked issues are closed, the manager may feed next ready work;
- when all tracked issues close, the convoy closes and notifications can fire;
- adding new work can reopen a closed convoy;
- force close/land can override normal completion requirements.

### Research consequence

A higher-level work order can be a **tracking aggregation** over lower-level work rather than a parent that owns their lifecycle/dependency semantics.

This is similar to Leantime goal↔milestone traceability in one respect: relationship/aggregation need not imply ownership of underlying state semantics.

## 5. Initial dispatch and graph readiness are not equivalent

The current convoy lifecycle doc records an important behavior:

- batch `gt sling` initially dispatches all beads in the batch even if one Beads issue blocks another;
- dependency-aware `isIssueBlocked` filtering applies to subsequent daemon-driven convoy feeding.

### Research consequence

Gas Town has at least two meanings of “dispatchable” depending on path:

- explicitly/directly slung work;
- daemon-fed ready work.

Thus:

`actor received work` ≠ `underlying graph says this work is currently ready`

in every path.

This is not merely implementation trivia; it is an authority distinction. Explicit orchestration can override or bypass graph-derived admission semantics.

## 6. Scheduler adds environment capacity to work readiness

When scheduler capacity control is enabled, `gt sling` creates a separate ephemeral **sling context bead** rather than modifying the work bead.

The scheduler:

1. collects open sling contexts;
2. queries `bd ready` across rig databases;
3. keeps contexts whose work bead is ready;
4. computes available polecat capacity;
5. applies batch size;
6. dispatches selected work;
7. closes the context on success or updates failure state.

Active capacity counts all polecats, including direct-dispatch workers, because API/memory/CPU limits are shared environmental constraints.

### Research consequence

Work readiness and **dispatch admissibility under current environment capacity** are different standings.

A future work manager may need:

`logically ready` + `environment resources available` + `actor available/authorized`

before launching work.

## 7. Scheduling intent is separated from the work object

The sling context bead stores target rig, formula, args, merge strategy, convoy, agent/runtime, failure counter and other dispatch parameters. The scheduler design explicitly preserves the work bead as pristine.

### Research consequence

This is a useful separation of concerns:

- durable business/work identity;
- transient scheduling/execution request.

A failed/cancelled dispatch does not need to corrupt the underlying work item's meaning or description.

This resembles Flowable separating runtime job state from process definition and OpenSpec separating change artifacts from task application state, though the mechanisms differ.

## 8. Circuit breaking turns repeated dispatch failure into explicit scheduler standing

Sling contexts track dispatch failures. After the configured threshold (documented as 3 in the pinned design), the context closes as `circuit-broken`; the original work bead remains untouched and requires later intervention/rescheduling.

### Research consequence

A work item can remain valid/unfinished while one **execution attempt/admission object** reaches terminal failure.

Again, `execution-attempt state ≠ work state`.

## 9. Molecules separate reusable procedure from work instance and persistence cost

Gas Town's Formula → Protomolecule → Molecule/Wisp design defines reusable multi-step procedures.

Two materialization choices matter:

- **root-only wisp** — only one ephemeral root record; detailed steps are presented inline to the agent and not persisted as individual rows;
- **poured wisp** — substeps materialized as separate tracked wisps, preserving checkpoints across session death.

The documented heuristic is explicitly based on the **cost of losing progress**: cheap/high-frequency procedures stay inline; expensive/low-frequency procedures should persist checkpoints.

### Research consequence

Durability can be **selective per workflow** rather than every step always becoming a durable work object.

The design choice trades:

`storage/coordination overhead` against `recovery granularity`.

## 10. Persistent workflow state allows execution context to be disposable

Poured workflows preserve completed substeps so replacement sessions continue from the last checkpoint. Polecat work instructions tell workers to persist findings to the bead before session death, and completion/checkpoint mechanisms were added specifically for recovery from interrupted `gt done` flows.

Current HEAD itself fixes `await-event` so a backoff deadline survives context-yield/re-entry rather than restarting the wait window.

### Research consequence

Long work may need **continuation state for waits/backoff/procedure checkpoints**, not only task completion status.

A fresh agent process can continue if the system persists the execution-relevant state outside the context window.

## 11. Monitoring is a separate actor/control topology

Witness, Deacon and Dogs exist to observe worker/system health rather than execute the primary product task. Current source assigns recovery/escalation policy to these roles, while some Go handlers intentionally expose cleanup data and leave judgment to the monitoring agent.

### Research consequence

A multi-agent work system may require **control-plane actors** whose work object is the health/progress of other actors, not the project's deliverable itself.

This should not be conflated with ordinary project task hierarchy.

## 12. Convoy completion uses multiple detection/recovery paths

Current convoy lifecycle combines:

- issue-close propagation at the close command/source;
- daemon event polling across Beads stores;
- periodic stranded-convoy scanning as crash/restart safety net.

The manager is intended to be idempotent; duplicated close observation should not double-complete a convoy.

### Research consequence

Important aggregate transitions may require **reconciliation loops** in addition to event-driven happy paths. Event delivery can be missed; periodic derivation from durable truth repairs missed effects.

This is a broader pattern that may matter for SOUL: derived work state should sometimes be recomputable from authoritative lower-level state.

## 13. Stranded work is a first-class liveness condition

Search/source surfaces define a stranded convoy as open work with conditions such as ready/unassigned issues but no workers, or other lost-progress shapes. Recovery scans can feed work again.

This extends Beads' stale-lease concept from one work item to a higher-level **work-order liveness** concept.

### Research consequence

A large-work manager should distinguish:

- blocked by legitimate dependency;
- waiting intentionally;
- assigned to a live worker;
- ready but unstaffed;
- worker disappeared;
- aggregate container open despite all underlying work done.

All can look superficially like “not progressing.”

## 14. Worker done, convoy done and integrated done are distinct standings

Gas Town introduces several completion surfaces:

- Polecat says/submits `gt done`;
- underlying bead closes;
- all tracked beads closing can complete convoy;
- Refinery can then verify/merge changes into main;
- failed merge requests may be isolated/fixed/re-dispatched.

### Research consequence

This is a strong implementation of the general distinction:

`actor says work complete`
≠ `work item lifecycle closed`
≠ `aggregate work order complete`
≠ `result integrated/accepted in authoritative environment`.

For Development OS, this hierarchy of standings is likely more valuable than a single Done column.

## 15. Refinery adds integration/verification after execution

README describes a per-rig merge queue that batches merge requests, runs verification gates, uses Bors-style bisecting and handles failing changes by isolation/fix/re-dispatch.

This means completion is not necessarily directly written to the main integration target by the worker.

### Research consequence

Actor autonomy can be high during execution while **integration authority** remains centralized/separate.

This relates directly to gstack's authority/capability/review/ship findings.

## 16. Explicit override paths preserve human/coordinator authority

Gas Town includes force close, owned convoys, direct/mr/local merge strategies, scheduler pause/resume and other control-plane overrides.

Current convoy lifecycle states that force-close/land bypass the normal all-tracked-work-closed check.

### Research consequence

Derived standing is not always sovereign. A work system may need explicit privileged overrides, but overrides should preserve reason/provenance because they change the meaning of completion.

## 17. Federation extends work coordination beyond one workspace

The Wasteland model (not source-deepened in U07) adds cross-town wanted work, remote claims/completion evidence and reputation. This demonstrates the intended scalability of the ontology beyond one local team.

U07 does not treat those claims as validated runtime semantics; Wasteland remains a future deep-dive candidate only if cross-organization delegation becomes load-bearing.

## 18. Matrix snapshot

| Dimension | Gas Town bounded observation |
|---|---|
| Work identity | Beads remain atomic work; Convoy aggregates tracked beads; Formula/Molecule represents reusable procedure/runtime workflow |
| Decomposition | Beads/epics from underlying substrate; molecule steps optionally materialized |
| Dependency | largely delegated to Beads; convoy `tracks` relation is aggregation; procedure order in formulas |
| Readiness | Beads `bd ready` for scheduler/feeding; explicit direct batch sling can bypass dependency-aware initial admission |
| State | bead/work state + sling-context state + convoy state + actor/runtime state + merge/integration state |
| Ownership | work slung to actor Hook; persistent actor identity; lower-level Beads assignment/claim semantics |
| Planning regime | Mayor/convoy orchestration + formulas; underlying work graph can evolve |
| Uncertainty | escalation/discovered beads handled through underlying system; no separate strategic fog object established |
| Change | convoys can gain work/reopen; scheduler contexts can be cleared/recreated; workflows/formulas version separately |
| Backtracking | re-dispatch, recover/respawn, convoy reopen/force close, merge failure rework; delegated bead reopen beneath |
| Scheduling | capacity governor/batch dispatch/backoff; not calendar/CPM project scheduling |
| Resources | explicit concurrency/API/CPU capacity limits; actor/runtime pool |
| Verification | Refinery/merge verification gates after worker completion; exact quality oracle configuration not deepened |
| History | Beads/Dolt work ledger + actor history + convoy/completion events + session logs/seance |
| Coordination | Mayor, Polecats, Crew, Witness, Deacon/Dogs, Refinery with Hook/mail/handoff surfaces |
| Recovery | watch/restart, stranded scans, checkpoints, persistent identities, seance and durable work state |
| Portfolio | Town→Rigs gives multi-project workspace, but not strategic program/portfolio methodology |
| Execution coupling | high orchestration coupling; dispatches actor runtimes and integration work, but underlying task graph remains Beads |

## 19. Method learnings after U07

U07 adds six distinctions:

1. **work substrate ≠ orchestration substrate**;
2. **actor identity ≠ runtime session**;
3. **logical readiness ≠ dispatch admissibility under capacity**;
4. **work state ≠ scheduling/execution-attempt state**;
5. **worker completion ≠ aggregate completion ≠ integrated/verified standing**;
6. **event-driven transition ≠ reconciled derived state** — durable reconciliation may be needed after missed events/restarts.

## 20. Open questions intentionally outside U07

- empirical correctness/throughput at 20–30 concurrent agents;
- exact Refinery gate/bisect guarantees under real conflicts;
- Wasteland federation and reputation semantics;
- current Gas Town compatibility with Beads v1.x after the pinned July main state;
- full checkpoint/`gt done` recovery state machine;
- economic/token/API capacity optimization;
- human supervision and error-amplification behavior in real complex projects.
