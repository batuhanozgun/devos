# P-W12-3: hook events the revised design depends on (pre-registration)

**Item:** W-C00-12, implementation step (comparison `plan/builder/w-c00-12/06_counter_design_comparison.md` revision 2: D-02, D-03, D-05). **Written:** 2026-10-03, before any probe session for it exists (time in the commit). **Producer:** run `session_01Wj4JDduaDRVnBvQJ86b5bm`. **Runs:** in the implementation run, before the mechanisms that rest on it are written (probe before build, D-27).

**Why.** Three mechanisms of the revised design rest on hook behaviour that is documented only in part (comparison §5) and not observed here:
- the stop check enforced by a `Stop` hook instead of only by the `/goal` evaluator (D-03);
- a compaction signal for the compaction gate (D-02);
- the carrier of the transcript-size warning (D-05).

**Set-up.** A probe branch cut from `main` adds to `.claude/settings.json`, and nothing else besides the hook scripts it names:
- a `Stop` hook that blocks the first stop attempt of the session with the reason `PROBE-STOP-BLOCK-7Q` (exit code 2) and allows later ones (it writes a flag file in `/tmp`);
- a `PreCompact` hook and a `SessionStart` hook with matcher `compact`, each appending its name, the UTC time and its raw input to `/tmp/devos_probe_compact.log`;
- a `PostToolUse` hook on `Bash` that returns `hookSpecificOutput.additionalContext` with the phrase `PROBE-POSTTOOL-CTX-2M` once.
The allow-list hook and its script are unchanged. The branch is never merged. A probe session is created on it with the configured model; its first message asks it to run `echo hello` and report, then to stop.

**Questions and PASS conditions** (read from the transcript with `list_events`, never from the session's summary):

| ID | Question | PASS only if | If FAIL |
|---|---|---|---|
| P-W12-3a | Does a `Stop` hook block a stop in a cloud session? | The transcript shows the session continuing after its first stop attempt, with the reason `PROBE-STOP-BLOCK-7Q` visible to it, and stopping at the second attempt | The stop check stays enforced through R1 and `/goal` only (D-03 default) |
| P-W12-3b | Does `PostToolUse` `additionalContext` reach the model? | After `echo hello`, the session quotes `PROBE-POSTTOOL-CTX-2M` without having read any file | The transcript-size warning uses a `PreToolUse` deny-once (D-05 fallback) |
| P-W12-3c | Do `PreCompact` or `SessionStart(compact)` fire? | Only testable if a compaction occurs. `/compact` sent by message is data (P-W12-2d), so this row is expected to be **UNTESTABLE** by this probe; it is recorded as such, and the first natural compaction in a long run is checked against the log file | The compaction gate stays instructed, tested by T-R6 (D-02 default) |

**Not tested here:** whether the hook can read the first user message through `transcript_path` (needed only if role profiles are re-admitted, D-13).
