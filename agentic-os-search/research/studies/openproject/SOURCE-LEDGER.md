# OpenProject — SOURCE LEDGER

Research ref: `opf/openproject@f531cc348d6920dd6d02f9b395f90878db57b3d3` (`dev`)  
Observed: 2026-09-17

## Current-source pin

- GitHub `dev` HEAD via commit API: `f531cc348d6920dd6d02f9b395f90878db57b3d3`, commit timestamp 2026-09-17.
- Repository default branch: `dev`.

## Load-bearing surfaces inspected

| Surface | Role in U01 |
|---|---|
| `README.md` | product scope; projects/portfolios/tasks/agile/Gantt/time-cost collaboration overview; GPL-3.0 statement |
| `app/models/work_package.rb` | native work object; project/type/status/author/assignee/responsible; hierarchy, relations, scheduling, cost/time, history mixins; blocker query |
| `app/models/relation.rb` | exact relation vocabulary, canonical direction, predecessor/successor and lag semantics |
| `app/models/work_package/status_transitions.rb` | explicit closing/reopening detection |
| `docs/user-guide/work-packages/work-package-relations-hierarchies/README.md` | source-level user semantics for hierarchy, predecessor/successor, lag, blocks, duplicates, includes/requires and their effects |
| `docs/system-admin-guide/manage-work-packages/work-package-types/workflows/README.md` | type × role status-transition matrix; author/assignee-conditioned transitions |
| `docs/user-guide/work-packages/set-change-dates/README.md` | manual vs automatic scheduling, predecessor/child date derivation, working-day and propagation semantics |
| `docs/user-guide/portfolios/README.md` | Project/Program/Portfolio composition and strategic-vs-operational distinction |
| `app/models/journal.rb` + work-package activity source search | durable change/activity history surface |
| scheduling model/spec search surfaces | corroboration that parent/child and predecessor relations participate in automatic scheduling logic |

## Evidence class

This U01 unit is a **source/documentation bounded external-target study**. No live OpenProject instance was installed or exercised. Documentation was checked against selected current source/model surfaces where control semantics mattered.

## Revalidation triggers

Re-enter current source before relying on:

- active workflow/type-variant semantics (the pinned HEAD itself contains current changes in this area);
- scheduling behavior beyond the inspected manual/automatic relation model;
- MCP/AI-agent support;
- portfolio/project-life-cycle enterprise behavior;
- current license/edition packaging;
- performance, scale, concurrency or security claims.
