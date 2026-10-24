# Pre-run diagnostic criteria

These criteria precede this probe's first execution, but follow source inspection. This is exploratory component research, not independent/holdout/product conformance testing.

Use three exact, Git-blob-hash-checked upstream modules: thread_context, daemon_pool, skill_provenance. Synthetic terminal callback API and a synthetic threading.local allowlist are explicit stand-ins. No actual tool, plugin manager, AIAgent, profile directory, provider or network effect runs.

- P01 parent control: background_review origin, synthetic profile marker, both callbacks, allowlist and disallowed harmless name must all be observable on the parent.
- P02 unwrapped standard pool: compare the fresh worker with the parent; this runtime's baseline must not be silently treated as a Hermes result.
- P03 actual daemon pool alone: examine origin/profile ContextVars separately from callback and allowlist TLS.
- P04 actual daemon pool + actual propagation helper: origin/profile and callbacks should be present; inspect independently whether the allowlist is present. Do not infer policy from origin alone.
- P05 explicit worker-local allowlist binding: same harmless-name check should block; this is a sensitivity control, not a proposed production fix.
- P06 callback cleanup on exception: call target raises a diagnostic exception, then inspect the same worker without the helper; callbacks should be cleared. Preserve the distinction between cleanup and restoration of a pre-existing callback.
- P07 parent after all workers: no changed origin/profile/callback/allowlist state.

The harmless name is never executed, only compared with a synthetic allowlist. A missing allowlist here does not itself prove all Hermes caller paths bypass authorization. Real executor and plugin paths are separately traced statically. Any source identity mismatch prevents execution; discrepancies must not be repaired by weakening the hash check. A transcription mismatch caught before the first execution was resolved by fetching the exact canonical blob again.
