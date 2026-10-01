# R-C00-BOM-7 · Review of operating model v1.7 (T-A2 failure fixes)

- **Target:** `git diff 8d2c622..6d95709`, branch `claude/epic-hamilton-9tisc4` (8 files, +67/−19).
- **Reviewer:** independent session on `claude/review-R-C00-BOM-7`. I did not produce the target and did not see the producer's conversation.
- **Date:** 2026-10-01.

## Verdict: PASS-WITH-CONDITIONS

The direction is right: allowing `ReadNotifications` is needed and narrow; "live until expiry" is strictly more conservative than the rule it replaces; the T-A2r pre-registration came before any retest. Two findings must be fixed before merge (B1, B2). Both are small.

**Conditions (all before merge):**
1. **B1.** Correct the record of the "merge denied" observation in EV-C00-005 (T-A2 row), C00-log L-029 (F2 and "Merge denied") and operating model §2.3 ("observed, T-A2"). Say what happened: the classifier let the merge call through, the call failed on a short SHA, and the classifier then blocked the steps that pursued the merge.
2. **B2.** Limit what a run may merge from `claude/dispatcher` at boot (§2.3, §3.2, Appendix R2). It may merge only the `DURUM.md` heartbeat line and appended lines in the current stage log. Any other change stays unmerged and is logged as a finding.
3. **m1.** Make the T-A2r setup say that the heartbeat routine's stored prompt is replaced with the v1.7 Appendix R2 text.

The minor findings m2–m7 are recommended but not required.

## Checks I re-ran

| Check | Result |
|---|---|
| `tools/test_tool_allowlist.sh` at `6d95709`, scratch clone, checked out as `claude/epic-hamilton-9tisc4` with `origin` pointing at GitHub | **ALLOWLIST_TEST PASS** (111 `ok` lines) |
| The same test in a detached scratch clone whose `origin` is a local path | FAIL on two `create_session` branch controls. The baseline `8d2c622` fails the same way. This is the test's environment requirement ("T-H4 counts only on a pushed branch"), not a defect of the change. |
| `tools/check_service_names.sh` at `6d95709` | **SERVICE_NAMES CLEAN** (pattern derived from `3cd686a`; 12 terms) |
| Negative controls for unlisted non-MCP tools after `ReadNotifications` was removed from them | Still present: `SendMessage`, `ListAgents`, `SomeFutureTool`, `Artifact`, `DesignSync`, MCP resource readers, `EnterWorktree`, `SuggestPluginInstall`, `Workflow`. Block-path coverage is not lost. `ReadNotifications` is now a positive control, so removing it from the allow list would fail the test. |
| PR #9 (`pull_request_read`) | `state: closed`, `merged: false`, closed 20:15:59Z, head `claude/dispatcher` `70c41d1`. Matches L-029. |
| Heartbeat routine `trig_01D8eBZEmGsHvijrs4dQxNc8` (`get_trigger`) | `enabled: false`, updated 20:15:58Z, bound to `session_01FTnQrWv6hTTZyUV7zrJRBh`, no connectors. Matches L-029. Its stored prompt is still the **v1.6** R2 text (m1). |
| Dispatcher transcript `session_01FTnQrWv6hTTZyUV7zrJRBh` (`list_events`, kinds user/assistant/result; read in full by searching the saved output for tool calls and their results) | See B1 and the criterion 1 table. |
| Pre-registration timing (`git log`) | `6d95709` committed 2026-10-01T20:17:42Z. The only later commit on the branch is `736ce7e` (20:18:28Z), which adds this review's session ID to `owned_ids.txt`. No retest exists, and none could, because v1.7 is not merged. |

## Findings by criterion

### Criterion 1: F1–F4 are real, follow from the evidence, and are fixed

| ID | Real? | Evidence in the dispatcher transcript | Fix in the diff |
|---|---|---|---|
| F1 | **Yes** | Two `ReadNotifications` calls blocked by the hook (`non_execution_kind: permission-rule`). `list_triggers` was also blocked. The dispatcher's own reply says it could not read the notification. | Hook allow list, test moved to a positive control, §9 rows, over-blocking list. Correct. |
| F2 | **Partly. The record is inaccurate (B1).** | See B1. | The design consequence is conservative and consistent (criterion 4). |
| F3 | **Yes** | The dispatcher's log line reads: "`get_session` shows it idle between turns, waiting on its own 23:14Z reminder". It names the rule gap itself. | §2.2, `CLAUDE.md` step 3, R2, §11 failure table, §2.3 failure table. All consistent. |
| F4 | **Yes** (a premise that has not been tested) | Not applicable | Stated in §2.3 and Appendix M; tested by T-A2r condition 2. The statement is incomplete (m4). |

**B1 · Blocking · The "merge denied" observation is misreported.** Locations: EV-C00-005 T-A2 row (3); C00-log L-029 "Merge denied" and F2; operating model §2.3 "The dispatcher does not merge (observed, T-A2)"; Appendix M is not affected.

What the transcript shows, in order:
1. At 20:10:06Z, `mcp__github__merge_pull_request` was called with `expectedHeadSha: "70c41d1"`. The classifier did **not** block it. It failed at the GitHub API: "The sha parameter must be exactly 40 characters".
2. At 20:10:15Z, `Bash git rev-parse HEAD` was blocked by the auto-mode classifier with "[Merge Without Review]". The dispatcher needed the full SHA to retry the merge.
3. At 20:10:49Z, `Bash git fetch origin main && git log … && git show origin/main:…` was blocked with the same reason. This is the "read of `main`" that L-029 mentions.

So the classifier allowed the merge call once, then blocked actions that pursued the merge, including a plain read. "Denied the dispatcher's merge of its own record PR" is close in substance but not accurate. The record also omits two facts that matter for the design:
- the classifier's decisions on the same action differ within one session, depending on context;
- the classifier also blocked a harmless read once it had settled on "merge without review".

Both facts weaken any inference from a single T-A2r pass (see m4). The project treats evidence wording as binding, so this is blocking, but the fix is text only.

**Fix:** rewrite the three locations with the sequence above, and drop or qualify "observed" in §2.3.

### Criterion 2: `ReadNotifications` scope and the §9 threat model

- **Scope.** The tool takes no input. It returns this session's queued notifications and marks them delivered. It cannot reach other sessions, write anywhere or change scope. The claim "widens nothing beyond reading this session's own queue" holds for tool capability. Its one side effect, consuming the queue, affects only this session.
- **Content is a wider injection surface than the text implies (m2).** The queue holds text from:
  - routines bound to the session. Any routine on the account can bind to it, including ones Batu or his other, unhooked sessions create, not only the builder's.
  - `send_later` messages;
  - **messages from other Claude sessions on the account**;
  - GitHub activity on subscribed PRs. `devos` is public, so **any GitHub user** can write a comment that lands there.

  Before v1.7, PR events already woke sessions, so that part is not new. The new reading surface is other account sessions' messages and routine prompts.
- **What an injected notification could make the builder do.** Under the hook, everything on the allow list:
  - push branches and open or merge PRs on `devos`, including `.claude/**` changes, which are protected from merging only by instruction;
  - create sessions on `devos` `main` or its own branch (usage cost; more writers);
  - create triggers into owned sessions;
  - send `PushNotification` to Batu's devices, which could deliver social-engineering text through his trusted second channel;
  - comment on issue #6 (not counted as Batu's answers, so low impact);
  - `WebFetch` arbitrary URLs;
  - through Bash, if the text names the mechanism: the residual routes in §9 (session-ingress token, local messaging socket, `claude` program, push to the library clone).
- **The threat model still holds.** The hook bounds tools, not content. Content-level defence was already instruction-only, and the stated residual risks cover the worst routes. The R2 rule "acts only when the text is the Appendix R2 check" bounds the dispatcher well: a forged R2 text triggers only a check the dispatcher would make anyway.
- **The gap is for runs.** §9 says "contents are untrusted data" but gives runs, which also receive `send_later` wake-ups at S5, no rule like the dispatcher's.
- The real new risk is B2: notifications reach the dispatcher, and the dispatcher's branch is now merged routinely by another session.

**B2 · Blocking · The dispatcher's standing PR is merged by runs with no scope check.** Locations: §2.3 "every run merges that PR at boot … after reading it"; §3.2 boot check; R2.

Failure scenario:
1. Text in the dispatcher's queue (another account session's message, or a forged R2 text with extra lines) leads the dispatcher to commit more than the heartbeat to `claude/dispatcher`, for example a change to `.claude/hooks/tool_allowlist.py` or to the work list.
2. The next run "reads and merges" it at boot. "After reading it" has no criterion.
3. The change reaches `main` without the review that §3.2 and §5 require for high-impact changes.

The boot check that merges every `claude/` branch existed before v1.7. v1.7 turns it into a standing, expected channel from the one session whose job is to read untrusted notifications. "That is a merge by another session that has read the change" presents this as review, but it is not an independent review.

**Fix:** a run merges the dispatcher PR only if its diff changes the `DURUM.md` "Son nabız" line and appends lines to `plan/ledger/<stage>-log.md`, and nothing else. A `git diff --name-only` plus a check that every changed log line is an addition is enough. Otherwise it leaves the PR open and logs a finding. Optionally add this to `builder_check.sh`.

### Criterion 3: the new lease rule

- **Old rule:** live means unexpired **and** working. **New rule:** live means unexpired. The new set of live leases is a superset of the old one, so every takeover the new rule allows, the old rule allowed too. No new wrong-takeover mode appears.
- **The cost is delay.** A dead holder now blocks until expiry, at most about 3h, plus up to 6h until the next heartbeat. That is up to about 9h15m, which the §2.3 failure table states correctly. The old failure mode was two writers, which breaks the single-writer rule. Delay is the better failure.
- **m3 (minor):**
  - "At most 3h15m" is not enforced by anything; a holder could write any expiry. A check in `builder_check.sh` would be cheap (expiry ≤ last checkpoint + 3h15m).
  - A holder still working past its expiry without a checkpoint can be taken over. Both rules allow this, so it is not a regression, but it is the remaining two-writer case.
  - §2.2 has no explicit **release** at a clean stop (S2, S3, S5). T-A2r improvises one ("the expiry is set in the past"). Without it, every clean stop delays the dispatcher by up to 3h.
- **m5 (minor, accuracy):** EV-C00-005 says the dispatcher decided "with the right reasons: lease unexpired". Under the v1.6 rule in force at the time, the idle holder made the lease *not* live. The dispatcher applied the v1.7 reading ahead of the rule, and only the usage clause made "start nothing" correct under v1.6. L-029 should say so; it is the concrete evidence for F3.

### Criterion 4: "the dispatcher never merges; a run merges at boot"

- **Consistent across sections.** §2.3, §3.2, R2, Appendix M, L-029 F2 and the T-A2r setup and condition 4 all agree. The stated cost (the heartbeat on `main` lags while no run is active) is real and disclosed.
- **Not a route around the denial, in my judgement:**
  - PR #9 was closed, not merged from the builder session.
  - The content was copied into L-029.
  - The new design moves merging to sessions whose stated job includes merging (R1: "merging into main at every checkpoint").
  - T-A2r states that a `create_session` denial is not routed around.

  Two caveats:
  - The rationale "a merge by another session that has read the change" relabels the action as review. It is a record PR merged under §3.2's "merged at once" rule, and it should be described that way. Without B2's scope check it is a weak control.
  - The "do not route around" rule is written only for `create_session`. A run's own merge can be denied too: a dispatcher-started run was not started by Batu, and the classifier's behaviour depends on context (B1). Add a general rule: any classifier denial in any session is recorded and treated as S3, never retried through another tool or session.

### Criterion 5: the T-A2r pre-registration

- **Written before any retest:** yes (git timing above).
- **Testable:**
  - condition 1: the transcript shows a `ReadNotifications` call that succeeds, with no user turn typed;
  - condition 2: the `create_session` arguments, model and first message can be checked in the transcript;
  - condition 3: the PR state;
  - condition 4: merge commits on `main`.
- **m4 (minor, adequacy):**
  - **(a)** Add the run's merge-ability as a stated untested premise in §2.3 and Appendix M, next to `create_session`. Condition 4 tests it, but the documents list only `create_session`.
  - **(b)** Say what happens if the classifier blocks the run's merge of the lease PR or the dispatcher PR: S3, not routed around.
  - **(c)** One pass is weak evidence for a classifier whose decisions vary within a session (B1). Record it as "observed once", not as a property.
  - **(d)** Add a check that the run applied B2's scope check before it merged.
  - **(e)** Optionally add a negative control: a non-R2 notification that the dispatcher must ignore.
- **m1 (condition 3):**
  - The routine's stored prompt still holds the v1.6 R2 text ("Check the lease holder with get_session … through a record PR").
  - The T-A2r setup says the routine is "re-bound … and re-enabled" but not that its prompt is updated.
  - The dispatcher's first message would carry the v1.7 rules while every heartbeat delivers the v1.6 rules, which conflict on liveness and on merging.
  - Fix: add "its prompt is replaced with the v1.7 Appendix R2 text" to the setup.

### Criterion 6: PR #9 closure and heartbeat disabling

Both are verified against live state (table above): PR #9 is closed and unmerged, and the routine is disabled. The times are consistent with L-029 being written at 20:17Z. One inaccuracy remains: the cause of the failed merge (B1).

### Criterion 7: public-repository safety

- Both scripts pass (see the table above).
- The diff adds:
  - session, trigger and PR identifiers, which match existing practice in the log;
  - a Turkish status line in `DURUM.md`.
- It adds no secrets, no library text and no transcript text. The dispatcher's findings are paraphrased, not quoted.
- This review quotes only tool error strings and tool names from the dispatcher transcript.

## Minor findings not covered above

- **m6 · §9 "Every tool call" row.** "That tool has been allowed since v1.7" is correct. However, this row's live block evidence was the only *live* evidence for a non-MCP block. The remaining live evidence for the non-MCP block path is the `list_triggers` block in the dispatcher (a session tool). Suggest citing a live block of `SendMessage` or another unlisted non-MCP tool when one next occurs.
- **m7 · DURUM.md.** The new line says the fix is "bağımsız incelemede". That is accurate. Batu may read "kendi engelim bu aracı kapatıyordu" (my own block was shutting this tool off) as a bug that has now been fixed. The line does not say that the merge path changed (the heartbeat on `main` now lags). Optional.

## What I could not check

- The one-shot routine that fired at 20:08:36Z: its trigger ID is not in the target, so I did not read its `last_run`. I relied on the dispatcher transcript showing a notification arrived.
- Whether the classifier's "Merge Without Review" denials would also fall on a run's merges. That can only be tested live (T-A2r).
- The contents of the notification the dispatcher could not read. They were never read by anyone.
- Who can enqueue notifications into a session, and the exact set of sources. I took this from the tool's own description, not from observation.
- I did not run `tools/builder_check.sh` and did not read sections outside those the criteria name.
