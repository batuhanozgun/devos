# U10 — Native context selector diagnostic, fixed before execution

Scope: full unmodified cron/scheduler_prompt.py at c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a, expected Git blob 91d673649d6dca8ba3120d10671a8966e67a01ce. Invoke only _inject_context_from. Real pathlib/glob/stat/read/mtime and local files. No full scheduler, AIAgent, provider, SessionDB, HTTP, network, credentials, plugin, subprocess or upstream suite. The cron.jobs output-root resolver and unused import namespaces are explicit synthetic seams; no seam selects files or decides injection.

Predeclared cases (artificial but source-shaped run documents, distinct fixed mtimes):
C01 normal: two substantive files; latest content injected, older not injected, self framing present; job dict unchanged.
C02 silent replacement: latest no_change audit document injected; prior substantive report remains on disk but not selected.
C03 empty replacement: latest whitespace-only file suppresses injection; older substantive report is not retried.
C04 prefix truncation: a full run document whose Prompt precedes Response and exceeds 8000 characters loses the final response token from the injected prefix; raw file retains it; truncation marker present.
C05 error context: newest FAILED/Error document injected, not older success; this is not success-only selection.
C06 missing predecessor: no output directory/file leaves the current prompt usable and unmodified, injected=False; this helper does not wait for a producer or form a dependency barrier.

Expectations are source-bound descriptions, not evidence of desirable product behavior. Every case records exact files/mtimes and full output. Read-back fixtures are independently hashed; oracle uses sentinel membership and explicit booleans, never the target function to construct expected output. One run, no statistical rates.

Negative controls, predeclared: N00 changed bytes fail normal identity loader before import. N01 reverse=True replaced with reverse=False must fail the C01 latest-output oracle. N02 truncate to 8000 replaced with 16000 must fail the C04 response-absence/truncation oracle. Mutants are labelled and loaded only through explicit test override; not upstream fixes or independent replications. No criteria changes after outcomes.

Audit rejects socket/process creation/system execution. Persistence consists only of generated evidence under this workspace. Same researcher and runtime, not independent replication. Historical U04–U09 diagnostics not rerun.
