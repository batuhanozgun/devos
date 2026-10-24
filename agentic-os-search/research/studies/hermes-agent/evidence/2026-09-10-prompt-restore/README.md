# U01-M4 — selected prompt restoration, not a full request test

Read [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [SPEC](SPEC.md), then [RESULT](RESULT.json). New probe: [probe.py](probe.py). Manual selected definitions are under `selected/`; LICENSE preserves the upstream attribution. The five full upstream dependencies and setup script are reused from canonical sibling `../2026-09-09-memory-pending/`, not silently reconstructed.

From a checkout containing both packages, run in a fresh disposable Python process:

```sh
python probe.py --output /tmp/hermes-m4-result-new.json
```

Existing output is refused. An alternate checked-out M2 location can be supplied with `--m2-root`. The recorded Linux run uses the standard library. No prior experiment suite is rerun, no provider is called, and network creation is blocked during cases.

A passing run means the limited source-informed expectations matched. It does not validate the manual selections against full-parent bytes, real SQLite, full prompt builder, actual CLI/gateway/compression/request assembly, model behavior or learning quality. V04 is a harness-selected order, not a discovered product caller sequence. See SOURCE/RESEARCH boundaries before reuse.

[MANIFEST](MANIFEST.json) binds the published local files. The original RESULT and stdout/stderr stay immutable; a later rerun must produce a new file. Publication is separately checked through commit/ref and remote tree readback.
