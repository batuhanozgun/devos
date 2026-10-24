# U03 — Publication recovery, 2026-09-11

## What was recovered

The prior turn created two explicitly recorded Git objects without completing a main-branch publication: draft README `64533b4183596c3beaee798c4a165cc31a9510f4` and XZ-compressed tar `5484ca39caf7ae5a8f6a31b68caeec0f9a44363d`. The latter is 14,096 bytes and contains 15 original regular files; its complete member inventory is [RECOVERY-MANIFEST](RECOVERY-MANIFEST.json). No byte in these two objects was rewritten.

The prior final reply saying no research progress/usable control response was obtained was too broad: preserved source reads and the recovered original RESULT/probe/logs contradict that blanket description. The narrower operational fact was that no published main checkpoint for this slice had been completed. This record corrects that description without inventing an infrastructure root cause or claiming every possible past artifact was inventoried.

## Recovery method and limits

The objects were first placed in an unreferenced inspection commit `6b448f79ca9e51e2600d220f2823e6303baa8eb6`; no branch was created or moved for inspection. Reading the binary object as UTF-8 failed. The supported base64 file read was decoded locally, and the resulting Git blob hash matched the original. A raw-download attempt was unsuccessful; no user/plugin permission or account setting was changed.

The archive was decompressed and all 15 safe regular members recovered. Recorded input/probe hashes, the initial-versus-corrected metadata-only change and Python parse validity were checked. The behavioral probe was NOT rerun. Original raw results and both invocation logs stay intact inside [original-evidence.tar.xz](original-evidence.tar.xz). The original draft is separately preserved in [README.original.txt](README.original.txt).

RESEARCH.md and SOURCES.md were not members of this recovered tar. Current readable companions and result summary were prepared during recovery from preserved readings and artifacts; they are not passed off as original completed prose. SPEC.md is copied exactly. Readable summary/state/source routes make the material discoverable without the old chat; exact reproduction inputs and full raw snapshots remain in the committed archive.

## Publication contract

Publication is prepared on `25b06521083e2a4ddf7b0dbeb9454804796963b6` (tree `22a09581b89173f1538af65e659148cb4a27ba40`), not the old `26067fc` tree. The intervening comparison showed Foundation and exploration changes; none is in this write scope. Only Hermes study paths and the Hermes catalog row may change. The unreferenced inspection paths are not part of the final tree.

A tree/blob or commit object alone is not success. The publishing turn must compare the candidate diff, recheck the live main parent, move the ref non-force, and read back main plus the artifact tree and current entry files. The actual published commit/ref readback is the publication receipt; this pre-publication document does not predict or fabricate its own commit ID.

## Continuing from the repository

[STATE](../../STATE.md) is current work authority; [17](../../notes/17-KANBAN-TASK-CLAIM-AND-ACCEPTANCE.md) is the research entry. Plan v0.15 records recovery separately from new research. Existing notes 01–16, syntheses 01–02 and old evidence remain unchanged. User-side ZIP uploading is not needed once this tree is on main. The entire Hermes study is still partial; no adoption, architecture or production-quality approval is implied.
