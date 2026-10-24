# E07 — Bounded SQLite/Git mechanism probe

**2026-09-18 / U09-A2. EXECUTED once, source-derived fixture.** This is not a compiled ECC/Rust test, a Tokio/process-supervision test, a model run or independent verification. Historical E06 is unchanged and excluded; E07 does not recover or replace it.

[Plan](PROBE-PLAN.md) → [runner](run_probe.py) → [raw results and command transcript](RESULTS.json). [Source bindings](../U09-A2-SOURCES.md), [interpretation](../../notes/14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md). STATE owns current work/publication.

## Prerecorded question and actual results

The plan reached main as `b61879501ed5124acf4487b27c6a1916773b858b` before execution. It specified four discriminators and their counter-controls, not a target-product pass threshold. The single run used Linux, Python 3.13.5, SQLite 3.46.1 and Git 2.47.3. Parameters and criteria were not revised after results.

| Case | Observation | Scope |
|---|---|---|
| C01 bounded persistence | Reopened database contained exactly 1,000 labels, line-0003 through line-1002 after 1,002 appends | Inspected SQL ordering/retention in a schema subset; not full transcript retention or power-loss durability |
| C02 later failure | Injected prune ABORT left the new inserted row in autocommit; explicit transaction plus rollback left only the seed | Partial method effects are possible under this statement contract; trigger is a deliberate fixture fault, not an asserted upstream trigger or observed outage |
| C03 stale guarded write | Prescribed two-connection schedule ended Running after an id-only write based on earlier Pending; expected-state control affected zero rows and retained Stopped | SQL-level interleaving, not a reproduced ECC concurrent-process race or frequency estimate |
| C04 resource identity | Removed worktree path was recreated for a log but absent from Git worktree registration; Git identity query exited 128 and uncommitted marker was absent. Retained control kept its registration and marker | Actual local Git commands, not running ECC Stop/Resume; no claim of permanent committed-object loss |

All planned discriminators were observed. That is not a product-success or product-failure score. The deliberate SQL error and Git exit 128 are the observed contrasts, not unreported failed runs. No earlier failed version of this fixture or hidden criterion revision is being omitted.

## Reproduction and isolation

With Python and Git available, run `python run_probe.py` from a writable directory containing the runner. It writes RESULTS.json next to itself and uses a temporary directory below that directory. The temporary database and repositories are removed on normal/exceptional exit by TemporaryDirectory. Reproduction will create new timestamp-dependent Git commit identities; exact commit stdout is an original-run record, not a stable expected value.

The runner uses standard-library sqlite3 in autocommit mode and an explicitly limited compatible schema. SQL/command semantics were transcribed from the pinned sources; the full original Rust implementation was not extracted or executed. The explicit-transaction and expected-state versions are counter-controls, not upstream patches or adopted designs. SQLite 3.46.1 is the local fixture engine, not a claim about ECC's bundled library version.

Git commands use an isolated temporary HOME/XDG configuration, disable system/global Git configuration and hooks, and initialize without templates. No network, model, provider, user-home/config/cache, installation or upstream mutation occurs. No arbitrary live pid is targeted. The synthetic uncommitted marker is disposable fixture data.

## Published correspondence actually checked

| Artifact | Bytes | SHA-256 | Git blob |
|---|---:|---|---|
| Executed run_probe.py | 8918 | 172731836fb21273f5d48ecdbb0f2fac3ba41f8618e8a895a595ac1bf9db3391 | 14c412072e934d53bec562522e269b812ff97ee2 |
| Actual RESULTS.json | 5989 | fceeab87f6d316a670adb493b1bbaea18f122d65fb98fbeeaaa3ef12f1aca9ef | d9378183b902eabcfc19d0ef7fc8674378fe9a1c |

Runner publication commit: `499af0bc1812d214ae91559b92aeb48de8c266c3`; results commit: `2b4c6e8afb9e3ad33bd5d3815fb283809e12ddc7`. The connector returned the runner's matching blob identity when its first three lines were read; this was not a full textual reread. RESULTS.json was read back in full and its returned blob matched the local result. Local files were checked again for byte count, SHA-256/Git hashes and parseable JSON. The results also embed the executed runner's SHA-256. These checks establish publication correspondence, not independent validation of the analysis.

No compressed/binary evidence transport or reconstructed outcome was used. Source and test limitations remain in Note14 and the ledger. The remaining U09-A execution-attempt ownership question needs its own source/dependency closure; rerunning E07 merely to recover context is unnecessary.
