# U08 — Async bridge cancellation versus delivery evidence

Pre-execution specification, 2026-09-12. Target: complete unmodified `agent/async_utils.py` at Hermes pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, Git blob `2bc558fad21eeec736c0283cb7df86304349f222`. No Hermes installation, full gateway, provider, credential, network send, subprocess, SessionDB or queue run.

## Question and criterion fixed before execution

Can the concurrent Future returned by the actual Hermes bridge safely use `cancel()` to distinguish "coroutine never started" from "already delivered"? The source consumer is `cron/scheduler_delivery.py::_live_send_text`, but that enclosing consumer is NOT executed in this diagnostic. Its timeout remains a source observation (60 seconds). This diagnostic uses a short/zero wait only to select the same Future timeout API, not to measure real 60-second transport timing.

B01 normal receipt: run a synthetic coroutine on a real second-thread asyncio loop, append an exact record to a local test file, return a tagged receipt; result matches event and file, cancellation after completion returns False.

B02 already-started effect: coroutine writes and fsyncs an exact local record, signals a threading barrier, then awaits an unset asyncio Event. Only after the barrier, call result(timeout=0), require TimeoutError, then call cancel(). Record cancel return, coroutine cancellation observation and file before/after. A True return with the record present falsifies "cancel=True means never started". The file is a real local observable but substitutes for a transport side effect; it is NOT evidence of real external delivery or actual product duplication.

B03 timeout-to-terminal-error race: coroutine reaches a controlled wait; caller observes TimeoutError, then permits the coroutine to raise a tagged error and waits for the returned Future to be done before cancelling. Record cancel=False together with the exact exception and no output file. This tests whether cancel=False by itself establishes success; it does not estimate race frequency or run the Hermes fallback.

No case counts imply product reliability. No completion probabilities or end-to-end verdict. Preserve unexpected results rather than revising oracles to pass. Stop/join all loop threads in finally; no asynchronous work after this command ends. All effects stay under the diagnostic output directory. Network and subprocess audit events are forbidden.

## Falsification controls

N00 flip one source byte before the identity gate: import must be rejected. N01 feed a fabricated contradictory B02 record to the observation validator: validator must reject it. N02 likewise feed a B03 record without terminal-error evidence. These are validator sensitivity controls, not source mutation or independent replication.

Preserve source, specification, probe, inputs, runtime source fingerprints/excerpts, stdout/stderr, result and local effect files. Pin source/spec/probe hashes before the run. One recorded run; no hidden retry. Runtime timestamp may reflect the container clock and must be recorded verbatim separately from the project calendar date.
