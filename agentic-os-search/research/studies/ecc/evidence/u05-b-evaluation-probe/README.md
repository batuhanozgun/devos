# E04 — Executed evaluator-boundary evidence

One local run on 2026-09-17 at 20:44:57Z, Linux / Node v22.16.0. Command: `node probe.cjs <source-root>`. Exit 0; captured probe stderr empty. The surrounding shell printed a separate TERM diagnostic after the command; it is not an ECC result. No upstream suite, host, model or user environment was exercised.

Three original modules were recovered from complete connector responses because auxiliary raw download failed at DNS. Their bytes matched pinned Git blobs before execution and afterward: health `8aba59861e9bfc4c1e4263f103808c7999632663`, amendify `c95f0e91481b4a20d13107923f502258e7375391`, evaluate `f45023d549b0fc5ad0ac96ac1fef3eb5306bd5d9`. No target logic was rewritten and no target dependency was stubbed. This is not a full clean checkout; the three modules form the executed target dependency closure, alongside Node built-ins.

## Observed outputs

| Case | Actual output |
|---|---|
| C00 no input | evaluation insufficient-data; proposal insufficient-evidence |
| C01 one record per variant | insufficient-data |
| C02 paired synthetic tasks, 1/2 vs 2/2 | promote-amendment, delta 0.5 |
| C03 regression, 2/2 vs 0/2 | keep-baseline |
| C04 tie, 1/2 vs 1/2 | keep-baseline |
| C05 two records duplicated to four rows | promote-amendment; two counted per variant, only two unique observation IDs overall |
| C06 unrelated amended-task labels, unchanged outcomes | promote-amendment, delta 0.5; no task difficulty measured |
| C07 two different amendment IDs | unfiltered promote-amendment; selecting amend-A insufficient-data |
| C08 one failure, also minFailureCount=10 | proposed in both; rationale still says repeated failed runs |

All nine predeclared expectations matched. That is **not** nine passing product-quality tests: the adverse fixtures characterize the limit of the predicates. Positive/rejection controls show the implemented counter and selector do work. Synthetic recorded outcomes are stipulated, not independently verified task successes. This run does not establish that invalid inputs occur in production or that another caller cannot validate them.

## Exact artifacts and recovery

`PLAN.md` was written and hashed before execution; SHA-256 `274e96f46426c40f6b8f09e1a7b095cb98d4e5acd1652ffd7f8882e2483d3af2`. `probe.cjs` SHA-256 `c9a4dcb701e96cedffd28fba60f8d8c35505fbde137a557f8b4216eae4051fa2`.

`results.json.gz` is deterministic gzip (mtime 0) of the **exact original 29,810-byte stdout**, not a summary or rerun. Decompressed SHA-256: `38c73adf0f4b57df3f98876bc58180cf5feb677fe9e8a8522d1c6716e57a6ad4`. Compressed Git blob: `8a3796d5523276ea9366a1cc1535d9e127985dfe`; compressed SHA-256: `146bf000882a9433d1c95ad720619bd453153d7ef879506381d7549c92450a1a`. Local decompress equality was checked before publication. Every input, output, timestamp and source identity is retained.

Read with `gzip -dc results.json.gz` or Python `gzip.decompress`. A text-only connector may require fetching the blob as base64 and decompressing locally; the table is a derived view, not replacement evidence. For a deliberate rerun, obtain the three paths from ECC at the pin under `scripts/lib/skill-improvement/`, then provide that source root to the script. It refuses mismatched blobs. No package installation is needed. Do not rerun just to reconstruct the completed research.

The observation writer/reader, hook tracker, analytics, snapshots/rollback and native installation remain source-only in U05-B. [Note08](../../notes/08-SKILL-OUTCOMES-EVALUATION-AND-CHANGE.md) explains those distinct paths.
