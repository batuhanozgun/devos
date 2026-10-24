# OpenSpec — SOURCE LEDGER

Research ref: `Fission-AI/OpenSpec@bae58cf61479986431bb798acbe5a688a591c18c` (`main`)  
Observed: 2026-09-17  
Latest observed release: `v1.13.1` (2026-09-17; release target `634c557bd0470eec37861b46172c3f503d283c1b`)

## Load-bearing surfaces inspected

| Surface | Role in U04 |
|---|---|
| `README.md` | artifact-guided change loop, source-of-truth/spec vs change separation, fluid/iterative philosophy, cross-repo Stores, MIT license |
| `docs/concepts.md` | native ontology: specs, changes, proposal/design/spec/tasks, delta specs and artifact flow |
| `docs-lab/reference/schemas/schema-yaml.md` | schema fields, artifact `requires`, graph validation, readiness, `apply.requires`, tracked-task states and file-existence completion semantics |
| `src/core/artifact-graph/graph.ts` | exact topological build order, ready-artifact computation, blocked dependency reporting and declaration-order tie break |
| `src/core/artifact-graph/instruction-loader.ts` | artifact status (`done/skipped/ready/blocked`), requires/unlocks, planning-complete/apply requirements and source comment separating file existence from dependency truth |
| `docs/editing-changes.md` | living artifact plan, mid-implementation revision, bidirectional code/spec reconciliation, update-vs-new-change boundary, living tasks |
| `openspec/specs/cli-artifact-workflow/spec.md` search surfaces | blocked-artifact instruction warnings and schema/status behavior |
| current `v1.13.1` release notes | exact Next action in status, safer archive/validation, task-progress parsing, apply.requires validation and current freshness |
| current main HEAD | documentation changes newer than release; freshness signal |

## Evidence class

Source/documentation-bounded external-target study. OpenSpec was not installed or driven through an actual coding-agent change by this research project.

## Revalidation triggers

Re-enter current source before relying on:

- artifact completion/status rules;
- `apply.requires` and task-progress parsing;
- archive/sync semantics;
- Stores behavior and cross-repo bindings;
- custom schema resolution/versioning;
- generated agent-workflow handoffs;
- security/trust behavior for repository-provided config/instructions.
