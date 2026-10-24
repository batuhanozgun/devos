# E03 — Worker completion and handoff extraction probe

**Executed:** 2026-09-17, raw timestamps in RESULTS. **Primary pin:** affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a. **Class:** local execution with a deterministic fake provider, not a live-agent experiment.

## What actually ran

The original Bash worker wrapper and original Node orchestration collector were materialized from the GitHub connector, with exact Git blob checks before execution. They use only built-in system/Node dependencies in the exercised path. Python created a temporary Git repository, fake HOME/TMPDIR and a restricted PATH whose first codex executable was an explicitly authored fake. No real Codex/model/tmux, installation, credentials, network or user configuration was used.

The fake accepts the wrapper's command arguments, records its incoming prompt, writes controlled final output and returns the prescribed exit code. It does not emulate Codex reasoning, options, sandbox, tools or provider execution. Real local Git supplies branch and status information. The collector reads the resulting files; no live pane observation is invoked.

## Files and integrity

- PROBE-PLAN.json: source-informed criteria fixed before execution; SHA-256 `6784dde99b401e783c269038d2190017bc1e453b079c34c18210d3d9cc44b204`, unchanged after execution.
- run-probe.py: exact executed runner; expected Git blob `425eedbeaa78cf1274c94d4dbe38b96b4b31f81e`.
- RESULTS.json: full original output with inputs, commands, fake calls/prompts, stdout/stderr, raw and parsed artifacts; expected Git blob `33d00a3d8653c674ad6d33163875804657d7979f`.
- Original source identities are enforced by the runner and recorded in RESULTS. The two source files are not copied into this evidence directory; recover them at the pin.

## Observations

C0 produced completed and parseable successful-report fields. C1 also produced completed despite controlled failed-verification/incomplete-task text; its negative text survived extraction. C2 produced completed but empty parsed output arrays because the controlled prose/numbered format did not match the collector. C3 produced failed and a generic handoff, while diagnostic stderr remained captured and the partial final output was omitted. C4 failed before invoking the fake provider because the task was missing.

All five criteria matched. That is not a product-safety score. C1 contains synthetic task evidence, not an independently evaluated software task. C2 does not estimate how often actual models use that format. C3/C4 establish real negative-case sensitivity in this local setup. Setup rollback, live dispatch, concurrency, process killing and crash recovery were not tested. E01/E02 were not rerun.

## Reproduction

Obtain the two pinned source files in their original repository-relative paths, then run:

```bash
python run-probe.py --source-root /path/to/pinned-ecc --output /tmp/ecc-e03-new-results.json
```

Keep PROBE-PLAN.json beside the runner. Python, Bash, Git and Node must be available. The runner refuses mismatched source bytes. Use a new output file; do not overwrite the original RESULTS. Execution uses a temporary fixture and removes it on exit. Transient paths in RESULTS are historical evidence, not expected future files. This is a Linux/POSIX-oriented probe; portability to other operating systems was not tested.
