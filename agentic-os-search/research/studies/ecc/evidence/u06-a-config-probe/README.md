# E05 — Config guard decision-chain evidence

Single local run: **2026-09-18T04:48:43.248Z–04:48:43.684Z**, Linux, Node v22.16.0. Command: `node probe.cjs <source-root>`. Probe exit 0; captured probe stderr empty. Each child exit/stdout/stderr is retained. Fifteen predeclared expectations matched, not fifteen proofs of system security.

Original modules: config-protection `2da5358c2f2e7711194580df96241cf9d55d1979`; run-with-flags `9f6de372212d5c3ba20502b5e05711431f1a0053`; hook-flags `69d3f25d6ba5d49acdebed943352674f87caa5c3`; pretooluse-visible-output `dc48119099f6206e6011174a62ad9912d7af9a25`. All matched before/after. Reconstituted connector bytes, not a full checkout. No target dependency stubs or installs.

| Case | Observation |
|---|---|
| C00 ordinary file | 0 |
| C01 same contents at existing protected file | 2 |
| C02 stronger proposed rule at that file | 2 |
| C03 absent protected filename | 0 |
| C04 dangling link at protected filename | 2 |
| C05 unprotected-name alias to same target | 0; realpath and inode equality both true |
| C06 ENOTDIR under regular-file parent | 2 |
| C07 malformed JSON | 0 |
| C08 non-string path | 0 plus wrapper run-error diagnostic |
| C09 oversized input | 2, empty stdout |
| C10 minimal / C11 hooks-off / C12 dry-run | 0; C12 preview present |
| C13 managed minimal / C14 explicit standard override | 0 / 2 |

The probe never performs the proposed Write/Edit. Existing protected contents remained identical; proposed new files were absent afterward. Temporary files/symlinks were cleaned. Alias output is a predicate contrast, not a proven host-level bypass. Invalid payloads are fault injections, not demonstrated real host events. Full bootstrap, concurrent changes, permissions, case-insensitive platforms, other hooks, live models and original upstream test suite were not run. E01–E04 were not rerun.

## Exact recovery

PLAN.md SHA-256: `1baea7e8e97f492487a0c3c33c8f76952bce2dbe4ae955e71a5c06c041686348`; Git blob `66a89a78dd1a58f94483addac7a15f3d15f0f0e4`.

probe.cjs SHA-256: `100fe467893e6d5cd90d793c50e958ac2dc22ddd5afdbe7cb8960ee3b99a3c4c`; Git blob `7d855c5960636925e97da6b2cbffa9c20b673bea`.

results.json.xz is lossless XZ of exact 1,065,861-byte stdout, including every input, all outputs and source identities. Decompressed SHA-256 `a63c2e5b624463c1c16af2cb6931c68b78f9232edcfb3339795bd58dacd3f6d0`; compressed SHA-256 `0c8d7947ff27614ceaebcd432852571a8d8c42ede4d33b0fa22e493ee37783f9`; compressed Git blob `e2838d28f0a3a6bf6e36561569f8bc03215792d9`. Read with `xz -dc results.json.xz` or `lzma.decompress`. The large ASCII input was compressed, not dropped. The table is a derived view.

For a deliberate rerun, obtain the four pinned paths under scripts/hooks and scripts/lib and pass their root. The runner refuses wrong blobs. Do not rerun merely to recover research state. [Note09](../../notes/09-CONFIGURATION-PROTECTION-AND-ENFORCEMENT.md) owns interpretation and limitations.
