# P-W12-6: what create_session returns at the lineage limit (N-052)

**Written:** 2026-10-03T23:10Z by run `session_011NtZnNGjojkTcmuzMRLtvL`. **Pre-registration:** `plan/builder/w-c00-12/16_tranche_1c_intent.md` §4 on branch `claude/run-w12-1c` (commit `644fb20`, before the call): the run's first `create_session` is the probe, and its full response is recorded.

**Observation before the call.** `get_session` on this run (22:38Z and 23:08Z): `"lineage":{"depth":8,"limit":8}`; its parent `session_01Gfj3M4MjrMb4YcRHwsA1X8` was at depth 7 and created two Verifiers and this run at depth 8 without refusal (L-053, L-054).

**Call** (after the S4 stop check passed at 23:09Z): `create_session` with `source_url` devos, `source_revision` main, model `claude-opus-5-5`, `environment_id` the builder environment, and the R1 goal plus the run brief as the first message.

**Response, verbatim (the whole tool result):**

```text
create_session: this session is at lineage depth 8 (limit 8), so it cannot start sessions, or create, fire or re-arm routines and reminders. No user or organization setting changes this limit; finish the work in this session or ask the user to start a new session.
```

**Result.** A session at depth equal to the limit cannot create sessions; by the message's own words it also cannot create, fire or re-arm routines or `send_later` reminders (not tried: that would be another route to a refused goal). A session at depth limit minus one could create sessions (depth 7 created depth 8). **Consequences for the design** (to weigh in 1c, N-052): every S4 hand-over and every Verifier adds one level, so a chain of runs exhausts the limit; C-R10 needs a restart from a session near the root (R-R17), and C-R2, C-R3 and C-R5 (wakes into the run itself) do not work at the limit either.
