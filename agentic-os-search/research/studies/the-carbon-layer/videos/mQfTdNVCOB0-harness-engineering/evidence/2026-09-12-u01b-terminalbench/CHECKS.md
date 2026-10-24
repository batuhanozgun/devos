# U01-B — Executed local diagnostics and open verification limits

**Date:** 2026-09-12. **Result:** eight scenario groups executed; five deliberately changed local controls discriminated. Two runs produced byte-identical stable RESULT.json. This is source-informed mechanical evidence, **not** a live benchmark, independent replication or a claim that the product passed 13 reliability tests.

## Execution boundary

The pre-execution [SPEC](checks/SPEC.md) identified fixtures, expected distinctions, exclusions and negative controls before the first run. The same researcher had already read the source and then authored fixtures/oracles: this is not blinded confirmatory testing. No criterion was relaxed after an unfavorable result. No failed run or source-copy correction was recorded in these two attempts.

Python 3.13.5/Linux executed selected function ASTs copied from pinned GitHub reads; parent-file byte identity for the Python sources was not independently established locally. Six optimizer functions and one artifact method were compiled without upstream module imports. Explicit fake environment objects replaced remote execution. The full shell wrapper's 3,139 bytes matched Git blob `54b511590818b4cc703288ccbca0f78036792d5f`; fake uv recorded its arguments and performed no validation/model/Harbor operation. B08 used a fake failing ls and Bash builtins only after the short-circuit.

The full-project manifest requires Python 3.12. These standard-library diagnostics on 3.13.5 do not validate installation or runtime compatibility. No credentials, real project dotenv, paid calls, new packages, live tmux, remote resources or benchmark tasks were used.

## Results and what each oracle distinguishes

| Group | Observed result | Supported distinction / limit |
|---|---|---|
| B01 | Four existing trial dirs, one success, missing/corrupt/empty records: rate 0.25. Metrics population two, recorded cost 2.0. | Existing failed records count zero; readable usage population differs. No real cost estimate. |
| B02 | Remove one failed dir: 1/3. Remove all dirs of taskB: 1.0; no warning naming wholly absent task. Native frontier chooses incomplete candidate over 0.75 baseline. | Missing materialization changes population without adding success. Does not establish real Harbor omission frequency. |
| B03 | Three rewards 0.01 with expected count two: success rate 1.0, warning but included. Top-level score ignored. JSON array raised AttributeError. | Positivity, warning versus admission, and schema bounds. Normal task rewards may be binary. |
| B04 | Prior 0.60, candidate 0.75, updated-frontier summary delta 0.0. Same-name later 0.10 retains archived best 0.75. | Comparator identity and historical-best versus current artifact. No actual candidate quality test. |
| B05 | Nonzero-return partial PWD/LS output became `/app contents: (empty directory)`; later sections absent. Exec argument timeout 15, outer wrapper 20. | Unavailable listing can be represented as empty; timeout values are captured/source values, not elapsed-time tests. |
| B06 | No session and exec exception returned empty snapshot. Normal sections parsed. Thirty synthetic listing rows retained twenty and an omission label. | Positive fallback/normal/truncation paths; no actual first-model consumption. |
| B07 | Exact shell emitted inherited synthetic model; isolated dotenv changed it to synthetic override. Invalid environment exited before uv calls. | Effective configuration precedence and a real shell rejection. Fake uv is not a real class/Harbor validator. |
| B08 | Native compound command with fake ls exit2 produced compound exit0 and only PWD/LS markers. Native parser labeled it empty. | Actual local short-circuit→partial representation chain. Not an assertion about historical `/app` state. |

## Negative controls

N01 changed missing-result defaults to one; N02 changed positive-reward comparison to nonnegative; N03 changed the summary's comparator to the declared old 0.60; N04 suppressed the empty listing label; N05 removed dotenv sourcing. Each altered the corresponding observation and was discriminated. Mutations were local in-memory strings or an isolated shell copy, never upstream edits. They test sensitivity to those specified changes, not every failure class or oracle correctness.

## Stable artifacts and exact identity

| Artifact | SHA-256 |
|---|---|
| checks/SPEC.md | 19b895062323b8f8cec5869ee2528768c168a83c05ae6c68b1c9d57071707cf7 |
| checks/probes.py | cc3f747968ae56fc0eac20190bd4240d2f7c277fac4c84feba58a5a9d76fcf3a |
| checks/EXCERPT-IDENTITIES.json | 1b603b66a5168aa4e40e005293ca3cb8fc6271d0a5e3216a4f97d1bd6c0bfc2d |
| checks/RESULT.json | 7020914bd0e6fd95b5eeccff1116f03ef2a033586fd8ef2f9cacd41653d960ac |

The second output had the same bytes/hash. Temporary absolute paths were normalized before serialization; timestamps/runtime were not included in the stable JSON. This is deterministic repetition of the same diagnostics, not another independent verifier. A manifest binds the published files; identity does not establish semantic validity.

## Reperformance route

Recover T03, A01 and T04 using the exact source refs/blobs in SOURCES. Do not install their projects or execute their module initializers. With the pinned files saved locally, the supplied runner checks full-file Git blobs and the selected function AST hashes, then runs only those functions and the fake-command shell path:

```bash
python probes.py --optimizer-source /path/to/T03-meta_harness.py \
  --artifact-source /path/to/A01-agent.py --shell-source /path/to/T04-run_eval.sh \
  --identities EXCERPT-IDENTITIES.json --output RESULT-rerun.json
```

This full-file recovery route is supported by the runner but was not exercised here; the actual two runs used the recorded local excerpts. Their hashes/ASTs, provenance and resulting execution mode remain visible. Source excerpts existed in this turn's sandbox and are not guaranteed durable attachments; do not invent their contents from a summary in a new session. Reopen the pinned full source instead. Full-source versus excerpt modes yield different identity fields even if case observations agree.

The preserved SPEC's instruction to store excerpts was fulfilled locally, not by republishing third-party source here. The durable package contains the diagnostic runner, source identities, spec and exact result. Local excerpt-container hash checks plus same-reader source comparison are weaker than independent parent-file byte verification, and that limit remains open.

## Not executed / not established

First-party test suite; real timeout caller branches and remote process cleanup; whole-job expected task materialization; actual verifier production; held-out transfer; historical raw runs; full dependency compatibility; live model/first-request visibility; budget/quality effects; containment and independent replication. U01-A's original unexecuted queue remains unchanged. Probes of result consumers do not prove properties of an unread producer.

The bounded unit can advance without waiting for every residual runtime debt, provided later claims keep these boundaries. The next unit should broaden operational understanding, not turn this research into unauthorized upstream repair.
