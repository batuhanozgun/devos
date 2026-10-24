# U03 — Recovered source/evidence route

**2026-09-11 recovery companion.** This is not an original source-ledger file recovered from the archive. It records the actual pinned file/symbol reads present in the preceding conversation and the identities embedded in recovered selections. The upstream files were not newly re-fetched or fully executed during publication recovery.

Primary: `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Default-branch search results in the preceding source pass used another ref and are navigation only; they are not evidence for this pin or current release.

| ID | Primary source | Blob | Coverage/status |
|---|---|---|---|
| U03-S01 | [hermes_cli/kanban_db.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/kanban_db.py) | `47fdffc353b1fd432acf5929f56463df07b413ad` | PREVIOUS-TURN SELECTED SOURCE READ: board paths, Task/Run/schema, create_task/_initial_task_status, dependency/claim/open-run, goal_run_status, heartbeat/reclaim, complete_task/artifact helpers, block/review/changes, archive/decompose excerpts, build_worker_context and context helpers. No whole-file FULL-read/whole-module execution claim. |
| U03-S02 | [hermes_cli/kanban_db_connect.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/kanban_db_connect.py) | `9067dfd0e571bc02cb02859c80fb4a551b8f55ce` | PREVIOUS-TURN SELECTED SOURCE READ: open/lock/integrity introduction and complete write_txn/busy-retry tail. Init/migration and corruption-repair closure not established. Recovered selection header records 1100–EOF. |
| U03-S03 | [hermes_cli/kanban_db_dispatch.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/kanban_db_dispatch.py) | `743e91dbb542132a4981ad9225df49612bc68882` | PREVIOUS-TURN SELECTED SOURCE READ: worker exit/liveness, reclaim/timeout/stale/orphan and failure accounting, dispatch_once/lane claim/workspace/spawn, worker argv/environment and daemon. Some helper bodies only partially visible; not FULL or executed. |
| U03-S04 | [tools/kanban_tools.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/kanban_tools.py) | `b776958a55bb5d42ad9c92ec87d6c4ba110f917c` | PREVIOUS-TURN SELECTED SOURCE READ: visibility/ownership/delegated-child guards, run ID, board scope, conditional goal gate, heartbeat/comment bridges, complete/block/review/request_changes handlers. Full tool registry/profile/goal judge not executed. |

## Recorded execution is a different source object

[Original archive](original-evidence.tar.xz), blob `5484ca39caf7ae5a8f6a31b68caeec0f9a44363d`, contains the exact 15-file diagnostic. Full member identities: [RECOVERY-MANIFEST](RECOVERY-MANIFEST.json). The separate original README has blob `64533b4183596c3beaee798c4a165cc31a9510f4` and is preserved as [README.original.txt](README.original.txt).

K01–K08: manually selected transition definitions + selected transaction wrapper + reduced schema + explicit fixtures, actual temporary SQLite connections in the recorded run. Upstream full-file byte/AST matching remains NOT VERIFIED. Selected-function execution is not full original-module execution. No newer-source code is substituted.

The raw RESULT.json inside the archive is the primary recorded-run artifact (SHA-256 `52e859f9a0511fe731958e89096c63be722f05914a257387e4714f46bcad70fb`). [RESULT-SUMMARY](RESULT-SUMMARY.json) is a derived browsing projection with omitted detailed snapshots/mutant observations. It must not replace raw readback for an exact claim. [SPEC](SPEC.md) is an exact member copy, not a relaxed post-hoc criterion.

## Recovery checks, not another execution

The compressed object's Git SHA and 14,096-byte size were matched. All 15 members were safely extracted. The four recorded input hashes and probe hash matched recovered files; initial/corrected script diff was only platform metadata collection. Python sources parsed without executing them. No K suite, old Hermes suite, provider/model, process-launch or upstream test was rerun. These are transfer/consistency checks, not independent corroboration of Hermes behavior.

Earlier comments about clean-exit recovery rates, corruption causes or capability isolation remain target-author claims unless separately verified. Source existence, source interpretation, recorded selected execution, transfer identity and work-quality acceptance are separate evidence levels.
