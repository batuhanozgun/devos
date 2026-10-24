# Beads — Work-Control Findings

Pinned source: `gastownhall/beads@71c4cd08b9991e7ba4e53822769c78337e0f4ee4` (`main`), observed 2026-09-17. Latest observed release: `v1.3.0`.

## 1. Native work object and durable substrate

The primary tracked object is an `Issue` / bead. Current source separates:

- title/description/design/acceptance criteria/notes/spec reference;
- status, priority and issue type;
- assignee and human owner;
- timestamps including started/closed and close reason/session;
- due/defer timing;
- dependencies, labels, comments/events;
- optimistic row version;
- claim lease/heartbeat provenance;
- source-system and metadata fields;
- several agent-coordination constructs such as gates/molecules/work types.

Dolt is the durable database and synchronization substrate. In embedded mode it is a single-writer local database; server mode supports multiple concurrent writers. Cross-machine synchronization uses Dolt remotes. `.beads/issues.jsonl` is an export/interchange/view surface, explicitly not the source of truth or backup.

### Research consequence

Work continuity is separated from conversation continuity. A new actor can recover the graph from the shared durable work store rather than reconstructing tasks from chat history.

## 2. Ready work is a derived standing, not a status synonym

Beads explicitly distinguishes:

- `bd list --status open` — open items;
- `bd ready` — work that currently satisfies ready-work predicates.

Current source builds ready predicates from several dimensions:

- status eligibility (`open` plus custom statuses in the `active` category for ready semantics);
- `is_blocked = 0` derived standing;
- pinned/infra type exclusions;
- defer-until time and deferred-parent propagation;
- optional assignment/label/type/parent filters;
- priority/order policy.

The `Issue.IsBlocked` field is documented as a **persisted readiness projection** used in journal snapshots, not merely a manually entered status. The issue can also have a `blocked` status, so status and derived blocking are distinct concepts.

### Research consequence

A future work system should distinguish at least:

`lifecycle status` from `derived readiness/standing`.

Calling a work item `open` does not mean it is actionable.

## 3. Dependency vocabulary and control effects are richer than the simplified docs

A repository dependency guide describes four concepts:

- `blocks` — hard prerequisite;
- `related` — informational soft link;
- `parent-child` — hierarchy;
- `discovered-from` — provenance.

That guide says only `blocks` affects `bd ready` and parent-child is structural-only.

However, current pinned source has a wider built-in dependency vocabulary, including:

- `blocks`;
- `parent-child`;
- `conditional-blocks`;
- `waits-for`;
- `related` / `relates-to`;
- `discovered-from`;
- `replies-to`;
- `duplicates`;
- `supersedes`;
- `authored-by`, `assigned-to`, `approved-by`, `attests`;
- `tracks`, `until`, `caused-by`, `validates`, `delegated-from`;
- plus custom dependency strings within the storage limit.

Current code says `AffectsReadyWork()` is true for:

- `blocks`;
- `parent-child`;
- `conditional-blocks`;
- `waits-for`.

It separately says `IsBlockingEdge()` excludes parent-child. Parent-child nevertheless participates in ready-work/cycle semantics because a **blocked parent propagates blocking standing to children**. The source even warns that mixed blocks/parent-child chains can form a logical livelock leaving nothing ready.

`waits-for` is different again: it affects readiness through a dynamic fan-out gate over a spawner's children and deliberately does not belong to the static scheduling/cycle set.

### Research consequence

This is a strong source-view fidelity case:

- relation type;
- human-facing “blocking edge” label;
- whether it affects ready computation;
- whether it participates in static cycle detection;

are four different properties.

Do not collapse them.

## 4. `discovered-from` preserves emergence without imposing order

The repository's dependency guide treats `discovered-from` as provenance: a new issue discovered during another issue can record where it came from without becoming a prerequisite by default.

This is useful for exploratory work:

`current work → discovers new work`

does not automatically imply:

`new work blocks current work`.

If the newly discovered item truly blocks the origin work, a separate blocking edge can be added.

### Comparison to recursive prerequisite discovery

This is structurally compatible with progressive discovery, but Beads does not itself determine whether a discovered item is a true prerequisite. It stores and computes over the graph supplied to it. The reasoning problem remains external.

## 5. Parent/child decomposition and readiness interact

Beads supports hierarchical epic/task/subtask IDs and explicit parent-child edges. The simplified guide presents hierarchy as independent from order: siblings can all be ready unless blocks edges order them.

Current implementation adds an important complication: if a parent is blocked/deferred, descendants can be removed from ready work. Thus hierarchy has both a structural role and a propagated control consequence in the current source.

### Research consequence

Even a decomposition edge that is not itself a hard prerequisite can affect actionable standing through inherited/container policy.

## 6. Claim is atomic allocation, not passive assignment

`bd update <id> --claim` uses compare-and-swap semantics. The source path:

1. reads the current issue inside the transaction;
2. validates that status is claimable (`open` plus custom active-category statuses);
3. checks assignee slot / claim-pool eligibility;
4. CASes against an opaque row-version;
5. sets assignee + `in_progress` (and initial `started_at`);
6. records claim/update events;
7. grants a liveness lease.

A re-claim by the same actor is explicitly idempotent. If another actor won the claim, the caller receives conflict state rather than silently stealing it.

`ClaimReadyIssueInTx` goes further: it **computes ready work and claims one in the same transaction**, continuing past transiently unclaimable/raced candidates.

### Research consequence

For concurrent agents, “select next work” and “own next work” cannot safely be two unrelated operations without race handling.

## 7. Lease separates ownership record from actor liveness

A durable issue may say `in_progress` and carry an assignee, but current Beads adds an ephemeral/node-local lease with expiry and heartbeat.

If a worker dies and stops heartbeating, `bd reclaim` can revert stale-leased `in_progress` work back to ready and clear the assignee. Lease provenance records which replica granted the lease; foreign-replica liveness is treated cautiously because its view may be stale.

### Research consequence

This introduces another important distinction:

`assigned/claimed ownership` ≠ `currently live holder`.

A work manager for agents needs an explicit policy for abandoned work instead of assuming `in_progress` is self-healing.

## 8. Reopen recomputes downstream standing

Reopen applies only to statuses in the configured **done category**. It atomically:

- returns the issue to `open`;
- clears close metadata and defer-until;
- deletes the lease;
- records a reopen event/comment;
- recomputes derived `is_blocked` standing for affected issues/wisps;
- journals the update.

Thus reopening a prerequisite can re-block work that had become ready after it was closed.

### Research consequence

Backtracking in a dependency graph is not only changing one node's status. It may invalidate derived readiness across the graph.

## 9. Status categories decouple custom vocabulary from work behavior

Built-in statuses include:

- `open`;
- `in_progress`;
- `blocked`;
- `deferred`;
- `closed`;
- `pinned`;
- `hooked`.

Custom statuses can be mapped to behavioral categories:

- `active` — eligible for ready/default list;
- `wip` — not ready, still visible;
- `done` — not ready/default list;
- `frozen` — not ready/default list.

This lets a domain-specific word such as `ready-for-agent` or `review` acquire a system behavior without making the engine hard-code every vocabulary.

### Research consequence

Lifecycle labels and lifecycle **behavior categories** can be separated.

## 10. Time and deferral are not full project scheduling

Issues support `due_at` and `defer_until`. `defer_until` directly gates ready work; descendants of deferred parents can also be filtered from readiness.

This is useful work admission/time gating, but it is not the same as OpenProject's predecessor/date propagation, calendars or critical-project scheduling. Beads is a frontier/coordination system, not a classical CPM scheduler in this bounded slice.

## 11. Graph integrity is an operational requirement

Beads exposes cycle detection/checks. Current source explicitly treats certain mixed dependency edge families as a combined cycle set because they can produce readiness livelocks.

This means a bad work graph can make the actionable frontier empty even though unfinished work remains.

### Research consequence

“no ready work” can mean at least:

- legitimate waiting;
- everything complete;
- external condition not met;
- actor claims consumed frontier;
- a malformed/cyclic/livelocked work graph.

A work system should diagnose these separately.

## 12. Persistence/history and compaction

Dolt supplies versioned synchronization/history. Beads also journals issue updates and records claim/reopen/close events. Old closed issues can be compacted into summaries to reduce context load; compaction is described as permanent graceful decay, with recovery through snapshots/history when available.

This introduces a trade-off between detailed historical work evidence and compact agent context.

## 13. Verification / completion boundary

Issues can carry `AcceptanceCriteria`, and different issue types recommend success/acceptance/decision rationale/findings sections. However `bd close` is still a state mutation. This slice did not establish an independent validator that proves criteria are satisfied before closure.

The work graph can therefore be structurally correct while completion truth is wrong.

## 14. Execution coupling

Beads governs work selection/allocation and can represent gates/coordination primitives, but it is not generally the engine that performs the underlying work. It sits between tracker and orchestrator:

- stronger causal coordination than a flat backlog because readiness/claim/liveness are enforced;
- weaker execution ownership than Flowable, which executes modeled process transitions and jobs.

Gas Town later becomes the stronger multi-agent orchestration comparison.

## 15. Matrix snapshot

| Dimension | Beads bounded observation |
|---|---|
| Work identity | Issue/bead; many work/decision/gate/message types |
| Decomposition | parent-child epics/subtasks; hierarchy can propagate blocking/defer |
| Dependency | rich typed graph; readiness effect is an explicit property, not all edges |
| Readiness | derived ready frontier from status category + blocked projection + defer + filters/graph |
| State | built-in/custom status with behavioral categories |
| Ownership | CAS claim, assignee/pools, row version, lease/heartbeat |
| Planning regime | graph authored/expanded over time; discovered-from supports emergent work |
| Uncertainty | spike/decision types + discovered-from; no first-class “unspecified fog” object established |
| Change | graph/status/metadata mutable; derived blocking recomputed |
| Backtracking | reopen done→open with downstream reblocking; unclaim/reclaim for ownership recovery |
| Scheduling | due/defer and frontier ordering; not classical dependency date scheduling |
| Resources | actors/pools/estimates; no classical capacity/resource leveling in this slice |
| Verification | acceptance criteria fields/issue-type templates; closure not independently verified |
| History | Dolt history + journals/events/comments + close/reopen reasons |
| Coordination | race-safe multi-agent claim and Dolt sync; server mode for multi-writer |
| Recovery | stale lease reclaim; durable graph across sessions/machines |
| Portfolio | epics/hierarchy; no project/program/portfolio method comparable to OpenProject established |
| Execution coupling | enforced readiness/allocation/liveness; underlying business/code work external |

## 16. Method learnings after U03

U03 adds three distinctions to the parent program:

1. **lifecycle status ≠ derived actionable standing**;
2. **claim/assignment ≠ holder liveness**;
3. **work discovery provenance ≠ prerequisite/blocking relation**.

These should remain explicit in later artifact/spec and multi-agent systems.

## 17. Open questions intentionally outside U03

- live multi-agent race tests across several machines/replicas;
- exact operational behavior of newer gate/molecule/formula features;
- Gas Town integration and higher-level swarm allocation;
- semantic conflict resolution when two planners change the graph differently;
- effectiveness of compaction for agent performance;
- quality of agent-generated dependency graphs;
- organizational/PM suitability beyond coding-agent workflows.
