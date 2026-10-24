# Beads — SOURCE LEDGER

Research ref: `gastownhall/beads@71c4cd08b9991e7ba4e53822769c78337e0f4ee4` (`main`)  
Observed: 2026-09-17  
Latest observed release: `v1.3.0` (2026-09-15)

## Load-bearing surfaces inspected

| Surface | Role in U03 |
|---|---|
| `README.md` | agent-native graph framing, core create→ready→claim→close loop, Dolt source-of-truth/sync modes, essential commands |
| `docs/getting-started/quickstart.md` | explicit `bd ready` versus open-list distinction, dependency graph examples, hierarchy, explainability and sync |
| `internal/types/types.go` | current Issue schema; statuses/status categories; issue types; dependency vocabulary; AffectsReadyWork/IsBlockingEdge/IsSchedulingEdge; waits-for metadata |
| `internal/storage/sqlbuild/ready.go` | current ready-work predicate: status categories, is_blocked, deferred, infra/pinned exclusions, descendant/deferred-parent behavior |
| `internal/storage/issueops/ready_work.go` | current ready query construction/ordering and durable/wisp merge path |
| `internal/storage/issueops/claim.go` | atomic CAS claim, idempotent same-actor retry, row-version conflict handling, lease grant, claim-ready transaction |
| `internal/storage/domain/db/issue.go` | alternate/unit-of-work claim path kept in lockstep with primary CAS/lease semantics |
| `internal/storage/issueops/lease.go` + `cmd/bd/reclaim.go` search surfaces | heartbeat/lease and dead-worker reclaim behavior |
| `internal/storage/issueops/reopen.go` | done-category reopen, close metadata reset, lease deletion, event/comment, graph blocked-state recomputation |
| `internal/storage/issueops/dependencies.go` | parent-block propagation and mixed-edge cycle/livelock rationale |
| `plugins/beads/skills/beads/resources/DEPENDENCIES.md` | simplified/older dependency guide; useful specifically as a documentation-vs-current-source drift case |
| `docs/CLI_REFERENCE.md` and MCP tool search surfaces | dependency/ready/claim/reopen user surfaces |
| `LICENSE` | MIT license |
| current main HEAD + v1.3.0 release | freshness and release baseline |

## Source-view fidelity note

`DEPENDENCIES.md` states that only `blocks` affects `bd ready` and that `parent-child` is structural only. That statement is **not load-bearing for current pinned behavior**: current source's `AffectsReadyWork()` includes `parent-child`, and dependency/cycle code explains parent-block propagation into child readiness. Findings use current source semantics and preserve the documentation drift as evidence.

## Evidence class

Source/documentation-bounded external-target study. Beads was not installed or exercised by this research project; no live concurrent agents or Dolt remote were run.

## Revalidation triggers

Re-enter current source before relying on:

- dependency vocabulary/readiness effect;
- leases/reclaim behavior;
- custom status categories and claimability;
- waits-for/fanout gate behavior;
- Gas Town/molecule/formula coordination;
- Dolt replication/conflict behavior;
- compaction/recovery guarantees;
- performance or multi-agent efficacy claims.
