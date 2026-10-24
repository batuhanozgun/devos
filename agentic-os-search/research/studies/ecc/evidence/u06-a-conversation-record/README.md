# U06-A — Conversation/repository evidence reconciliation

**Date:** 2026-09-18. **Kind:** continuity maintenance and historical artifact check, not new research, new execution or independent replication. Current work remains [STATE](../../STATE.md): U06-A published, U06-B next, METHOD 0.1 / PLAN 0.10.

## Why this record exists

The user asked whether research and repository progress were staying aligned, and clarified that branch/merge timing belongs to the assistant. A check against main `a8c9de4e413562b9cdd0312857926c41b124f2ff` confirmed current publication and continuation, but found a specific evidence identity mismatch: the conversation's U06-A delivery described a 16-case Python-driven E05, whereas main held a 15-case Node-driven E05. The earlier publication-status correction did not explain this distinction. Neither record should silently overwrite the other.

## Two qualified historical identities

| Record | Driver / recorded time / scope | Exact outcome identity |
|---|---|---|
| Existing main-path E05 | `probe.cjs`; 2026-09-18T04:48:43.248Z–04:48:43.684Z; 15 cases | Decompressed stdout SHA-256 `a63c2e5b624463c1c16af2cb6931c68b78f9232edcfb3339795bd58dacd3f6d0`; see [existing README](../u06-a-config-probe/README.md) |
| Conversation-bundle E05, retained here | `probe.py`; 2026-09-18T04:49:24.591128+00:00–04:49:25.047114+00:00; 16 cases | `results.json` SHA-256 `76b143e595519c8c556e8027dd7307d4a13437d2bd5265bd06fbdcca4c13f99a` |

These qualifiers distinguish evidence sets; the original files still contain the historical label E05. Case IDs are local to their own driver. For example, main C05 tests an unprotected-name alias, while conversation C05 concerns pyproject.toml. The conversation set also tests oversized/minimal input, hook-ID exclusion and invalid-profile fallback. Main includes a strengthening proposal and ENOTDIR. Do not combine the counts into a larger validation score or silently attach one set's result to the other set's case number.

Both records bind the same four upstream source blobs and synthetic inner-runner boundary. Neither is a real host/tool-write/security certificate. Overlapping cases are not independent evidence merely because drivers differ. This maintenance turn checked stored artifacts, not their historical execution environment, and ran neither probe.

## Preserved bytes and checks

The source attachment is `ECC_U06-A_Arastirma_ve_Yayin_Paketi.zip`, SHA-256 `8c911660bb78fec434037f69c35838b42b078b74346ebca93e100a7361f46170`. Only its five original experiment files are re-containerized here. No evidence member was edited:

| Member inside original-evidence.tar.xz | Bytes | SHA-256 |
|---|---:|---|
| PLAN.md | 3544 | d3c58cf3dbb7faaf31da04efaab3beece4841cbbc080f9805f7f5008968f8d3b |
| README.md | 3478 | 15f48449d103e6dd8463a2fe27b2c3fe33127abf0a9029c16450ca42ac26bbff |
| probe.py | 7300 | 66e342e528a33008f06180543d589ef92a334f50dfa960669ad11d8d2a779eee |
| results.json | 15950 | 76b143e595519c8c556e8027dd7307d4a13437d2bd5265bd06fbdcca4c13f99a |
| stderr.txt | 0 | e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 |

Archive: 7,116 bytes; SHA-256 `c12d0603d952bfe33c027c6a3bf5f804ebc0063a27d454516fce2627519f5275`; Git blob `3257a0c22d9a4809b0291e3678389182c29675d0`. Read members with a tar/XZ reader, for example `tar -xOf original-evidence.tar.xz results.json`. Source acquisition and deliberate replication instructions remain inside; do not rerun merely to recover the history.

Local checks established exact archive-member equality with the attachment, the plan/runner hashes recorded in results, 16 recorded matched cases, matching before/after source identities and fixture checks. Both oversized-input recipes were reconstructed as bytes and checked against their recorded sizes/digests. This is an integrity/consistency check, not re-performance of the target or proof that a historical timestamp was independently authenticated. The GitHub blob-create response matched the prepared archive identity before a tree or ref used it.

The source ZIP's other draft documents and stale application instructions are not applied by this repair. Current Note09 and the published U06-A state remain canonical. Main's existing raw evidence and all previous notes/rounds/publication receipts remain untouched. This record supplies the missing correspondence for the conversation's experimental claims rather than pretending the whole ZIP was published verbatim.

## Work disposition

Research progress is not a backlog of unpublished units: U06-A is published and U06-B is selected. The targeted repair is the explicit evidence identity/recovery link above. Branch cleanup is not a prerequisite to further research. Branches or delayed merges must remain traceable, but their timing is not a user chore. The comprehensive joint research discussion remains deferred until completed research.

Only this directory and the ECC STATE reconciliation section are in the repair scope. No shared catalog, other study, Foundation, agent-control, upstream file or research plan changes are needed. Publication must still be checked against the fresh main head and read back before reporting the repair complete.
