# Worker-policy challenge — before execution

Date: 2026-09-08. Research base 36f1b7e6ae07da5c1d9d57ff9633d48473c42537. Upstream c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a.

This is source-extracted function integration, NOT the full application or the complete large modules. Executor/whitelist excerpts are manually transcribed selections from the canonical GitHub blob responses. They are not whole-module hash-verified copies. The complete thread_context and daemon_pool modules ARE Git-blob verified before imports. No production fix is applied.

## Fixed diagnostic cases

Direct parent denial; allowed direct control; sequential worker with parent-only whitelist; allowed worker; clarify direct-thread branch; explicit worker-local whitelist sensitivity control; independent scope block; independent guardrail block; lifecycle block; lifecycle exception; approval transport exception; duplicate middleware callback; post-probe parent state/worker cleanup; modified full-source rejection.

Read back actual handler count (harmless marker), selected policy's real thread-local list, hook/thread trace, context markers, blocked/dispatched flags and cleanup. Scope/guardrail negatives must still block. Compare lifecycle exceptions to approval exceptions. Callback multiplicity must use handler count, not the dispatched flag as oracle.

All external state, hooks/Relay/middleware/profile/approval transport/guardrail object/UI/deadline config are declared test fixtures. No installed Hermes, model/provider, credentials, real user profile, actual network, dangerous command, production lock or complete PluginManager. Sources are read first; specification before first run; exploratory, not holdout. Failures in harness setup must be recorded separately, not counted as product observations. Matching predictions do not mean product conformance PASS. The integration doesn't establish all ordinary-loop or alternative transport entry paths.

GitHub create_file discovery returned a schema but the invocation returned Resource not found before this local experiment. This is not evidence that a remote specification was published. Publication is a separate closure obligation.

Before the first run, two argument-transform controls are added: modify then block must not call the handler; modify then allow must pass changed arguments to the marker. These test the selected consumer's directive composition, not the whole plugin lifecycle.
