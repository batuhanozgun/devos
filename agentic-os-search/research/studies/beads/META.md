# Beads — Study Metadata

## Identity and status

- **Study ID:** `beads`
- **Title:** Beads — Agent-Native Dependency Graph, Ready Frontier and Recoverable Claims
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U03 of `work-management-project-control` completed as a source-bounded agent-native graph/work-coordination study; no live multi-agent swarm campaign, distributed failure injection or adoption evaluation was performed.
- **Research object:** `gastownhall/beads` as a persistent distributed issue/work graph for AI agents and humans, with computed ready work, typed dependencies, atomic claims, liveness leases, reopening/reblocking and Dolt-backed synchronization/history.
- **Canonical external target:** https://github.com/gastownhall/beads
- **Observed default branch:** `main`
- **Pinned research ref:** `71c4cd08b9991e7ba4e53822769c78337e0f4ee4`
- **Observed latest release:** `v1.3.0` (published 2026-09-15)
- **Research date:** 2026-09-17
- **License observed:** MIT
- **Freshness risk:** high. The dependency vocabulary, ready-work semantics, leases/claim protocol and orchestration types are actively changing; current source is richer than some repository documentation.

## Primary question / purpose

How does an agent-native tracker turn an issue graph into an **actionable frontier** and safely allocate that frontier to concurrent agents across sessions/machines while preserving work history and recovering work abandoned by dead workers?

This unit is the explicit dependency/readiness/claim contrast to OpenProject's classical project control and Flowable's durable execution engine.

## Source-bounded synthesis

Beads uses a durable `Issue`/bead record with type, status, priority, acceptance criteria, assignment, timing, metadata, dependency edges, comments/events and coordination fields. Dolt is the authoritative persistence/sync substrate; JSONL is interchange/view material, not the source of truth.

The system derives **ready work** rather than treating all open issues as equally actionable. At the pinned source, ready-work selection applies status-category eligibility, pinned/infra exclusions, persisted derived `is_blocked`, defer times, hierarchy/dependency propagation and user filters. `bd ready` intentionally differs from `bd list --status open`.

Current source has a richer relation/control vocabulary than the simplified dependency guide. Built-in edges include `blocks`, `parent-child`, `conditional-blocks`, `waits-for`, related/provenance and a wider set of knowledge/authority links. `AffectsReadyWork()` currently includes `blocks`, `parent-child`, `conditional-blocks` and `waits-for`; parent-child participates because a blocked parent propagates blocked standing to its children. This directly contradicts the repository's older/simplified `DEPENDENCIES.md` statement that parent-child is structural-only and does not affect `bd ready`. Current source therefore outranks that derived documentation for load-bearing semantics.

Claim is stronger than assignment: a ready issue can be selected and claimed in the same transaction; claim uses compare-and-swap/row-version semantics, moves the issue to `in_progress`, sets assignee, records events and grants a liveness lease. A dead worker stops heartbeating; `bd reclaim` can return a stale-leased `in_progress` issue to ready. Reopening a done-category issue atomically restores it to open and recomputes blocked projections for affected graph neighbors.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong for dependency-frontier computation, issue lifecycle, progressive discovery, deferral, reopen and durable work state.
- **Actors:** very strong for race-safe claims, pools, assignees, leases, heartbeats and dead-worker recovery.
- **Information:** strong for acceptance criteria/notes/spec references, provenance edges, events/journals, persistent project memory and graph history.
- **Environment:** strong/conditional for embedded versus multi-writer Dolt modes, remote synchronization, replica lease provenance and agent integrations.
- **Relations / control:** very strong for typed readiness-affecting versus informational/provenance/authority edges, derived blocked standing and fan-out gates.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- derive “what can be done now?” from work state and constraints rather than asking an agent to choose among all open items;
- distinguish graph relation identity from whether/how it changes readiness;
- represent discovered work without forcing it to block the work that revealed it;
- use atomic claim + liveness semantics when multiple agents can race for work;
- recover abandoned work without assuming an `in_progress` label means a live actor still owns it;
- keep work graph/history durable across context compaction, sessions and machines;
- pressure-test how much prerequisite discovery must come from reasoning versus an already-authored graph.

No SOUL work-graph architecture is authorised or implied.

## Potential Development OS relevance

- persistent issue/dependency substrate;
- actionable-frontier queries with explanations;
- race-safe `ready → claimed/in_progress` transitions;
- lease/heartbeat/reclaim for agent liveness;
- defer-until and priority/ordering policies;
- reopen with derived readiness recomputation;
- graph-cycle/livelock detection;
- provenance for work discovered during execution;
- distributed sync and source-of-truth separation.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- agent-native actionable-frontier reference;
- ownership/liveness coordination mechanism source;
- counterexample to flat backlog/open-item selection;
- dependency/source-drift falsifier;
- comparison target for `recursive-prerequisite-discovery`, OpenSpec, Spec Kit and Gas Town;
- test-case source for graph cycles, reblocking, dead-worker recovery and concurrent claiming.

## What should not be inferred

- Beads does not prove that an agent can correctly discover the prerequisite graph in the first place.
- `bd ready` readiness is readiness **under Beads' recorded graph/status/deferral model**, not proof that the external world actually permits or justifies the work.
- Closing an issue does not independently verify that its acceptance criteria or business outcome are true.
- Lease expiry is a liveness heuristic/control mechanism, not proof that work effects were or were not performed before a worker died.
- Dolt/versioned storage does not by itself resolve semantic conflicts between competing planning decisions.
- The simplified dependency documentation is not current enough to be treated as authoritative for parent-child/readiness semantics at the pinned ref.

## Freshness / revalidation

Re-check current main/release before load-bearing reuse, especially dependency types, ready-work predicates, claim/lease protocol, status categories, synchronization and Gas Town-adjacent orchestration primitives.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; Beads is U03
- `../recursive-prerequisite-discovery/` — prerequisite/actionable-frontier reasoning; conceptually related but not equivalent
- `../openproject/` — U01 classical project-control contrast
- `../flowable/` — U02 durable workflow/case execution contrast
- `../mattpocock-skills/` — Wayfinder/frontier/fog-of-war work planning
