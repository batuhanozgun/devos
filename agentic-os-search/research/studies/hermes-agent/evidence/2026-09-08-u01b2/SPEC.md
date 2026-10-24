# U01B2 — pre-execution observation criteria

Prepared on 2026-09-08 after static source inspection, before the first execution of this harness. These are exploratory component observations, not a holdout, independent researcher verification, upstream conformance suite or installed-product test.

Only archived, hash-checked `skill_manager_batch.py` and `write_approval.py` are real HERMES modules. Config, profile/origin resolver, approval callback, guard, single-operation mutator, registry helper and the adapter joining the modules are synthetic. All files are disposable fixtures. No provider, account, real user profile, network or external process is used.

G01: Gate off allows; gate on skills/background stages without inline callback; foreground memory accepts once/session, blocks deny, stages no channel/unknown/callback exception. Distinguish config failure from callback failure. A decision alone is not persistent staging.
T01: Explicit-name batch stages a single durable record with no mutation/snapshot. A test-side JSON round trip and bypass-context re-entry applies the explicit-name operations. This is NOT the real apply_skill_pending caller.
T02: With gate off, default_name supplies a missing per-operation name and the stub mutator receives it.
T03: With gate on, the same default-name input is accepted for staging; inspect whether the actual serialized payload retains a replayable name. Re-entry using only recorded payload must be compared with T02, not assumed equivalent.
T04: A fixture-side intervention that writes explicit operation names before staging distinguishes missing serialized data from a broken writer. No upstream code is modified.
T05: Invalid batch shape is rejected before gate, pending store, snapshot or mutation.
T06: Gate bypass must not skip the batch preflight call; a rejecting synthetic guard prevents mutation. This tests routing, not the real guard's policy.
D01: With one pending edit record unchanged, edit the live skill file between two previews. Compare the resulting diff and serialized record bytes. This is a live-preview binding test, not an applied-write or UI experiment.
R01: Inject snapshot copy failure. Check error, zero mutation, original file, cleaned temporary snapshot root.
R02: Inject ordinary second-operation failure. Check first change restored, no snapshots, gate bypass reset, structured error.
R03: Inject a raised second-operation exception. Check propagation versus compensation, actual disk, snapshot cleanup and bypass reset.
R04: Insert a deterministic external fixture write between the first operation and the second-operation ordinary failure. Check whether rollback preserves it. This schedule tests component isolation boundaries, NOT reachability under actual production locks or worker scheduling.

A fulfilled observation assertion may expose a limitation; it never means 'HERMES passed'. Preserve raw observations, dependency substitutions, source hashes, script/spec hashes and execution identity. Do not silently change a failed criterion to make a run pass.
