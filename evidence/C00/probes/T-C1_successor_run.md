# T-C1: a run starts its own successor with nobody typing (result)

**Test:** pre-registered in `plan/builder/w-c00-12/05_continuity.md` §5 (merged in PR #53 before the call). **Claim:** a run can start its own successor with nobody typing (U-4 of `01_goal_down.md`). **PASS only if:** the call is allowed, the successor's `get_session` shows `parent_session_id` = the run and the R1 goal, and the successor takes the lease in a record PR.

**Observer:** the successor itself, `session_01Wj4JDduaDRVnBvQJ86b5bm`, at 2026-10-03T17:52Z. It is the test's subject, not a separate role; every element below is a field or a merged PR that anyone can re-read, so the result does not rest on its judgement. Independence level: deterministic observation, recorded by the subject.

| Element | Observation | Source |
|---|---|---|
| The call was allowed | The session exists, created 2026-10-03T17:51:34Z, `origin` `claude_code_mcp_seed`, model `claude-opus-5-5` | `get_session` (no argument) on this session |
| Parent | `parent_session_id` = `session_0143r88Vc9e5RbsQmqjYWgwa` (the run that stopped at S4, L-039) | same |
| R1 goal | The goal condition begins with the Appendix R1 text verbatim and appends one scope sentence (W-C00-12 only; starters disabled; read `RUN_BRIEF.md`, L-039 and the design files first) | same, `external_metadata.goal.condition` |
| Recorder | The predecessor's recorder appended this session's ID to `.claude/hooks/owned_ids.txt`; PR #54 carried that one line and was merged by this run at boot | PR #54, merge `0b2a46c` |
| Lease taken in a record PR | PR #55 changed only the state file's Run lock row to name this session (hand-over from its parent, operating model §2.2), merged as `c1e43cb` | PR #55 |

**Context in the same chain (added 2026-10-03 after review R-W12-1, m6 and B1):** the `create_session` call itself was made by the predecessor with nobody typing, but the predecessor had been restarted by a human between 17:46:47Z and the call (17:51Z): its turn aborted at 17:46:47Z (`error_during_execution`, an account subscription problem) and resumed only after Batu wrote "Sorun çözüldü devam et" (L-039). "Nobody typing" therefore holds for the successor call, not for the chain. Record change: annotate.

**Result: PASS, observed once.** A single pass is not a property: the permission classifier's decisions vary with context (operating model §2.3), and one denial occurred in this same boot on a different action (L-040, F-7 of `plan/builder/w-c00-12/06_counter_design_comparison.md`).

**Second observation (annotate; added 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, L-042):** this run was created by `session_01Wj4JDduaDRVnBvQJ86b5bm` at its S4 stop (L-041). Its own `get_session` (read at boot, created_at 2026-10-03T18:22:03Z) shows `parent_session_id` = `session_01Wj4JDduaDRVnBvQJ86b5bm`, model `claude-opus-5-5`, and a goal condition that begins with the Appendix R1 text and adds the W-C00-12 scope sentence. The predecessor's recorder line for this session reached `main` in PR #58 (merge `1da5518`, one line in `owned_ids.txt`, checked at boot), and this run took the lease in record PR #59 (state file only, merge `d69d7c6`). Nothing in the log records a human restart of the predecessor between L-040 and its S4 stop. Limit: the observer is the subject; every element above is a re-readable field or commit. **Result: PASS, observed twice.**
