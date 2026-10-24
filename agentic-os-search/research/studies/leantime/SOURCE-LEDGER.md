# Leantime — SOURCE LEDGER

Research ref: `Leantime/leantime@056835f1c29cf1f587415e6c45ddaf8d69f8d24c` (`master`)  
Observed: 2026-09-17  
Latest observed release: `v3.9.8` (2026-07-08; target `32be54edfc5fd33f35ea178f9d51b86276599069`)

## Load-bearing surfaces inspected

| Surface | Role in U06 |
|---|---|
| `README.md` | strategy/planning/execution positioning; OSS feature inventory; goals/metrics, milestones, subtasks/dependencies, sprints, time, risk, retrospectives; AGPL-3.0 badge |
| `app/Domain/Tickets/Repositories/Tickets.php` | ticket types/statuses, semantic NEW/INPROGRESS/DONE categories, project-custom status labels, cross-project semantic normalization |
| `app/Domain/Tickets/Models/Tickets.php` + ticket tools/search surfaces | ticket dependency/parent pointer (`dependingTicketId`), story points, milestone/sprint/task fields |
| roadmap/timeline templates | milestone dependencies and progress rendering |
| `app/Domain/Tickets/Services/Tickets.php` / report search surfaces | milestone progress computation and cross-project milestone views |
| `app/Domain/Goalcanvas/Repositories/Goalcanvas.php` | goal metric/state fields, KPI/parent links, many-to-many goal↔milestone `tracked_by` edges, goal value history/snapshots |
| goal dashboard/tools/report search surfaces | goal metric percentage and display of linked milestone progress as a separate measure |
| `app/Domain/Projects/Repositories/Projects.php` | project states/types (`project`, `strategy`, `program`), budgets, access/team surfaces |
| current v3.9.8 release notes | program board/cross-project work, milestone progress fixes, MCP and goal-related current behavior |
| current master HEAD | plugin-submodule movement toward 3.10.0; freshness and subsystem-boundary warning |

## Evidence class

Source/documentation-bounded external-target study. Leantime was not installed or used with a live team/project by this research project.

## Boundary note

Resource Allocation and some enterprise/project features live in or depend on `app/Plugins`, a separate pinned submodule. U06 did not independently pin/read that plugin repository, so plugin-specific resource/capacity semantics are excluded from load-bearing findings.

## Revalidation triggers

Re-enter current core + paired plugin source before relying on:

- resource allocation/capacity;
- current program-board rollups;
- goal/milestone linking and history;
- task/milestone progress formulas;
- MCP/agent tools;
- financial/project reporting;
- strategy/risk/retro automation.
