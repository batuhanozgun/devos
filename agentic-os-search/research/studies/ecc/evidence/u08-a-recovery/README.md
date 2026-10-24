# U08-A — Quarantined interrupted-publication objects

**Status:** NOT VALIDATED EXPERIMENT EVIDENCE. See [recovery diagnosis](../../RECOVERY-U08-A-20260918.md), [check results](CHECK-RESULTS.json), and [actual publication receipt](../../PUBLICATION-U08-A-RECOVERY.md). The recovery reached main through PR #22 / merge 1a2aa91b04fc1d2ad06e0007c2a48a7f409ddfc5. This closes the repository correspondence repair, not U08-A research or E06 evidence recovery.

These exact stored bytes are retained for provenance, not approved as research results or executable inputs.

| Stored object | Actual check |
|---|---|
| [9c36feb87bdedbbbd51a2a7126f81b51ce6b3e8c.gz](objects/9c36feb87bdedbbbd51a2a7126f81b51ce6b3e8c.gz) | 8,758 bytes; local Git hash matches; complete gzip decompression FAILS in Python and gzip -t |
| [4b6af43bcce99fceb6be677f4239c14cb6d7b660.gz](objects/4b6af43bcce99fceb6be677f4239c14cb6d7b660.gz) | 136,188 bytes in GitHub metadata; preserved, full content/integrity NOT VERIFIED |

The first object's SHA-256 is e7d668e2af5a1418d1ed567f61000299ad938676b80d2edbf93713f65c312c49. Matching the Git hash establishes correspondence with the uploaded object, not correspondence with the old local original or correctness of its contents. Text-reader UTF-8 errors are separate from actual compressed-stream invalidity.

The original files are not available in this turn's active runtime. A prefix from the first invalid archive contains a parseable E06 plan and the beginning of its runner, not complete verified results. No candidate byte repair succeeded and neither original object was altered. No E06 rerun occurred.

For a binary-aware read, fetch a committed path with encoding=base64, decode the complete returned content, then check its Git blob hash and decompression. Do not rely on a UTF-8 blob reader or tool-display truncation. Diagnostic commands for the first object: `gzip -t <file>` and Python `gzip.decompress(Path(file).read_bytes())`; both failed in this recovery. This is artifact-integrity maintenance, not an ECC safety/effectiveness experiment.
