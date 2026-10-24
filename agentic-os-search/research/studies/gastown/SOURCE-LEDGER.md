# Gas Town — SOURCE LEDGER

Research ref: `gastownhall/gastown@649b832b7672bc7a2dbef26f5983aba6198b819b` (`main`)  
Observed: 2026-09-17  
Latest observed release: `v1.2.1` (2026-06-06)

## Load-bearing surfaces inspected

| Surface | Role in U07 |
|---|---|
| `README.md` | current role/topology vocabulary; Mayor/Town/Rig/Polecat/Hook/Convoy/Molecule/Witness/Deacon/Dogs/Refinery/Scheduler/Seance; Beads boundary; basic convoy workflow |
| `docs/glossary.md` | MEOW/GUPP/NDI principles; actor identity/session distinctions; Bead/Formula/Molecule/Wisp/Hook/Sling/Handoff semantics |
| `docs/concepts/molecules.md` | Formula→Protomolecule→Molecule/Wisp lifecycle; root-only versus poured checkpoint materialization; polecat/patrol workflow |
| `docs/design/convoy/convoy-lifecycle.md` | convoy creation/tracks/dispatch/completion/feeding/reopen/force-close; event poll + stranded scan; current explicit note that initial batch sling can ignore dependency blocking while later feed respects it |
| `internal/cmd/close.go` | actual `bd close` wrapper and source-side convoy completion propagation; best-effort recovery reliance on daemon/deacon paths |
| `docs/design/scheduler.md` | capacity governor, sling-context beads, `bd ready` join, dispatch state/circuit breaker, work bead unchanged, concurrency resource semantics |
| `internal/witness/handlers.go` search surfaces | persistent-polecat model and separation between observed cleanup data and witness policy judgement |
| `internal/cmd/done.go` / checkpoint search surfaces | completion path freshness/evidence and recovery mechanisms |
| Refinery README/CHANGELOG search surfaces | merge/verification queue, bisecting/failure isolation and current fixes |
| daemon/convoy-manager search surfaces | stranded scans and convoy reconciliation after missed events/restarts |
| current main HEAD | 2026-07-23 backoff-preservation change showing durable wait/context-yield recovery semantics |
| `LICENSE` | MIT |

## Evidence class

Source/documentation-bounded external-target study. Gas Town was not installed; no Mayor, Polecat, convoy, scheduler, Refinery or Wasteland was exercised by this research project.

## Source-view caution

Several Gas Town documents are design/lifecycle documents that include historical and future sections. Findings rely only on sections corroborated by current source/current README/CHANGELOG where control semantics are load-bearing. Future roadmap items (for example explicit future convoy reopen CLI or Wasteland details not source-deepened) are not promoted to current behavior.

## Revalidation triggers

Re-enter current main/release before relying on:

- current Beads compatibility;
- convoy feeding/closure/reopen behavior;
- `gt sling` dependency/admission rules;
- scheduler sling-context/circuit-breaker semantics;
- molecule/wisp checkpointing;
- `gt done` recovery;
- Refinery/MQ verification/integration;
- actor watchdog/restart policies;
- claimed scaling/cost behavior;
- federated Wasteland work exchange.
