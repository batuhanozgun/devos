# E02 — Local work-item claim/move semantics

**Unit/date:** U03-A / 2026-09-17. This is a source-informed, pre-execution-criterion probe by the same assistant. It is not blind replication or an ECC product test campaign.

The unmodified upstream file `scripts/lib/control-pane/work-item-mutations.js` at ECC commit `8321021c54d670126ce3b2969d5deb880b4b0c2a` was materialized from the GitHub connector and verified as Git blob `c82a26196432b1cc0a95aee023354fe285c9bbdd` (3588 bytes). No upstream changes or report were made.

The runner supplies a new in-memory store implementing the three helper-facing operations. It does not instantiate SQLite, enforce database schemas/FKs, authenticate users or launch a process. Input ordering in C5 represents the newest-first query order read in the real source; it is not a SQL execution.

[Plan](PROBE-PLAN.json) was written before running the probe. Its SHA-256 was `62f233df0053fae3540c5eebe98ee297ad5f12830ad32f739bae51c7e8aaeaa6`. [Raw result](RESULTS.json) was produced by the [runner](run-probe.js) on Node v22.16.0 / Linux x64. Six criteria matched; inspect actual outcomes rather than treating that number as a safety score. C3 was a real refusal with zero writes; C1/C2/C4/C5 expose policy boundaries rather than successful protection against them.

Actual command (transient source location is historical, not a future prerequisite):

```sh
node /mnt/data/ecc-u03-a/evidence/run-probe.js /mnt/data/ecc-u03-a/source/work-item-mutations.js /mnt/data/ecc-u03-a/evidence/RESULTS.json
```

Reproduce with a separately acquired exact upstream file:

```sh
node run-probe.js /path/to/pinned/ECC/scripts/lib/control-pane/work-item-mutations.js results.json
```

The runner verifies the source Git blob and refuses different bytes. It performs no source acquisition and requires no package installation. Upstream source is linked by immutable identity rather than vendored into this research package.

Local evidence Git blobs: runner `70b085de4e53ca56952cd223d6ee55125c233165`; plan `f85e0407f0fa558bc2f6f1f1854e02412b8e7bfb`; results `48b4a5e6f3bd4b399731937947ab51c25e4937da`. Output timestamps are actual probe observations, not timing or effectiveness measurements.

**Limits:** no live board, provider, CLI, real home/config/cache, credential, remote change, concurrent claim, SQL/FK persistence or task-quality experiment. The session fallback and GitHub sync counter-paths in Note 04 were not executed here. The synthetic `blockedBy` metadata is illustrative, not a claim of a supported ECC dependency schema.
