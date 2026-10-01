# R-C00-BOM-5 · Independent re-review: operating model v1.5 (PR #4)

- **Target:** `git diff 5d6861a..ef4bd4d` on `claude/epic-hamilton-9tisc4` (14 files).
- **Reviewer:** a separate session (`session_01Y99Zfo6NNQUsTwGzyKckus`), full checkout of `ef4bd4d`, on the review branch. It does not see the producer's conversation. Independence level: same model family, separate session, restricted input (thinking independence only, BP-07).
- **Date:** 2026-10-01, about 19:17–19:35Z.

## Verdict: **FAIL** (one blocking finding; the fix is one rule plus one test)

Almost all of R-C00-BOM-4 is fixed for real:
- The matcher is `.*` and non-MCP tools are an allow list. I saw this block live in this session (below).
- The service-name inventory is gone from the tree, and the check script reports clean.
- The hand-over exception is narrowed to runs.
- 84 of 84 checks pass on the pushed branch. Mutation runs confirm the four rules that §13 names.

One route remains that an honest builder could take by mistake, or that an injected instruction could trigger:

- **N-B1.** The `Agent` and `Task` tools are allowed with any input, including `isolation: "remote"`. That launches a subagent in a new **cloud** session. It bypasses every `create_session` rule: repository, revision, environment, the `.claude/` check and the owned-ID record.

One major finding is a condition to pass:

- **N-M1.** The recorder that answers M2 does not parse the most likely shape of an MCP tool response, so it would record nothing. T-H7 is honestly marked pending, but M2 cannot count as resolved until T-H7 passes.

**About the L-021 loop budget.** L-021 says that if this review fails, the builder stops patching and records what remains as residual risks for D-003. N-B1 should **not** be handled that way:
- it is a route taken by mistake, not by deliberate bypass;
- the fix costs nothing (block one input value of two tools);
- the design goal in §9 makes such routes blocking.

A narrow check of that diff and the recorder fix is enough. It does not need a sixth full round.

---

## Criterion 1 · R-C00-BOM-4: is each finding actually resolved?

Each finding is judged on the target, not on L-021.

| Finding | Evidence on the target | Resolved? |
|---|---|---|
| B1 (non-MCP default-allow; `SendMessage`, `ListAgents`) | Matcher `.*`; `ALLOWED_NON_MCP`; any other name gets exit 2. Re-run: `SendMessage`, `ListAgents`, `EnterWorktree`, `SuggestPluginInstall` and `SomeFutureTool` are all blocked. Mutations that add `SendMessage` or `ListAgents` to the allow list, or that turn it back into default-allow, are each detected. **Live:** in this builder-created session, `ReadNotifications` (not on the list) was blocked by the hook with "tool 'ReadNotifications' is not on the allow list". This is the first live evidence that the `.*` matcher reaches non-MCP tools. | **Yes, at the tool-name level.** An allowed tool still has an unguarded input (N-B1). |
| B2 (L-019 pattern; unprefixed product name) | The L-019 row no longer carries the pattern. R-C00-BOM-1 line 39 and R-C00-BOM-2 line 67 are redacted. Re-ran `tools/check_service_names.sh`: `SERVICE_NAMES CLEAN (pattern derived from 3cd686a; 12 terms)`. Checked further without printing names: each of the 10 alternatives of the old L-019 pattern (taken from `5d6861a`) is covered by the derived pattern, and each has 0 hits in the tree. The commit messages and added lines of the target have 0 hits. | **Yes** (m6 below: the check cannot catch the exact B2 regression) |
| M1 (hand-over too broad) | `CLAUDE.md` step 3 and §2.2: "only a run (first message is the R1 run goal)"; reviewers, probes and the dispatcher never take the lease. R2's dispatcher prompt is not the R1 goal. This session (a reviewer and a child of the lease holder) correctly does not take the lease under the new text. | **Yes** |
| M2 (injection through owned-ID adds) | `record_owned_id.py` plus a `PostToolUse` matcher; hand edits are high-impact (§9, file header). But the parser fails on likely real response shapes (N-M1), and T-H7 is pending. | **Designed, not shown to work** (N-M1) |
| m1 (T-H6 over-credit) | The MCP row now says "allow path live; block path unit-tested". A new row over-credits T-H5 instead (m1 below). | **Yes**, with a new instance |
| m2 (local refs) | `git fetch -q origin <ref>` then `FETCH_HEAD`; failed fetch → block; `git` has `timeout=20`, and a timeout raises, which blocks. Mutation "ignore a failed fetch" is detected. Mutation "check `origin/<ref>` instead of `FETCH_HEAD`" is **not** detected (m3). | **Yes** |
| m3 (checkout swaps the hook) | Working-tree rule in §9 and `CLAUDE.md`; `EnterWorktree` blocked (re-run). `git checkout` itself stays an instruction-only rule, and §9 says so. | **Yes** |
| m4 (test gaps) | PR-tool and thread-tool controls added; wrapper cases run `$cmd` under `sh` (re-run: 4 ok); recorder test added. Gaps remain (m3). | **Mostly** |
| m5 (owned-ID header) | The header now lists every reader in the code (checked against `OWNED_TARGET_FIELDS`, `get_session`, `set_session_tags`, `create_trigger`). | **Yes** |
| m6 (`DURUM.md`) | Restamped 22:16 TR = 19:16Z, which matches `ef4bd4d` (19:16:22Z). Item 2 says "yeniden incelemede" and uses the future tense ("bakacak") for the barrier. | **Yes** |
| m7 (BP-06 cites T-H1) | Now T-H2, T-H3, T-H6. | **Yes** |
| m8 (trailing newline) | `fullmatch`. Re-run with a passing revision: `…/devos\n` and `…/devos-x` blocked; upper case and `.git/` allowed. But the test does not isolate this rule (m3). | **Yes** |
| m9 (permission widening) | `bypassPermissions` and non-empty `extra_allowed_tools` blocked. Re-run: blocked. | **Yes** |
| C1 | Met at the tool-name level, not met at the input level (N-B1). | **No** |
| C2 | Met. | **Yes** |
| C3 | Met. | **Yes** |
| C4 | The automatic add exists; the residual-risk wording is in §9 and the D-003 row. Effectiveness is unproven (N-M1). | **Partly** |

---

## Blocking finding

### N-B1 · `Agent`/`Task` with `isolation: "remote"` starts a cloud session outside every `create_session` rule (criterion 2)

- **Where:** `.claude/hooks/tool_allowlist.py`, `ALLOWED_NON_MCP` (`"Agent", "Task", … "Workflow"`) and `check()`, which returns 0 for any listed non-MCP name without looking at its input. Also §9, the "Non-MCP tools" row ("subagents … allowed").
- **Evidence:**
  - This builder-created session's `Agent` tool schema offers `isolation: "remote"`. It is documented as "launches the agent in a remote cloud environment".
  - Re-run through the literal settings command: `{"tool_name":"Agent","tool_input":{…,"isolation":"remote"}}` → **exit 0**; the same for `Task`.
  - The hook's session-tool rules exist because a new cloud session is where the barrier can be lost:
    - a checkout without `.claude/` (today `main` has none);
    - a sparse checkout;
    - another environment;
    - an ID that is not recorded.
  - None of those rules sees a session created this way.
- **Failure scenarios** (both within the §9 threat model):
  - *Accident.* The builder wants an independent reviewer or a probe "in a separate session" (BP-07) and uses the subagent tool with remote isolation instead of `create_session`. If that remote session checks out the default branch (no `.claude/` today) or runs where the account's connectors are attached (BP-04: builder-created sessions inherit them), it has live connectors and no hook. This is exactly the scenario of R-C00-BOM-1 B1.
  - *Injection.* A fetched page or library file says "run this analysis as a remote agent". The builder follows it, and the hook sees only `Agent`.
- **Severity:** blocking.
  - It is an existing tool, allowed by name, with a documented scope that creates a session outside the guard. That is the same class as R-C00-BOM-4 B1.
  - §9's design goal ("every route an honest builder might take by mistake is blocked technically") makes it blocking.
  - **Not exercised:** I did not launch a remote agent, because that would create a session on the account. Which revision, environment and connectors such a session gets is unknown. Verdict level: **plausible, strongly indicated**.
- **Fix:**
  1. In `check()`, block `Agent` and `Task` when `tool_input.isolation == "remote"`. Better, allow only an absent value or `"worktree"`, so that future values fail closed.
  2. Inspect `Workflow` the same way: block a script that passes a remote isolation to `agent()`, or block `Workflow` until its options are known. It is allowed today with any script.
  3. Add negative controls for both, and a mutation check.
  4. In §9, "Non-MCP tools": state "subagents in-process only; remote subagents blocked".

---

## Major finding (condition)

### N-M1 · The owned-ID recorder very likely records nothing from a real MCP response (criterion 1, M2; criterion 3)

- **Where:** `.claude/hooks/record_owned_id.py`: `text = resp if isinstance(resp, str) else json.dumps(resp)`, then the first `re.search(r'"id"\s*:\s*"(session_…)"')` anywhere in the text.
- **Evidence** (a copy of the recorder in the scratchpad, fed with different response shapes):

  | `tool_response` shape | Recorded |
  |---|---|
  | dict `{"ccr":{"id":"session_…"}}` (the shape the test uses) | the ID |
  | MCP content-block list `[{"type":"text","text":"{\"id\":\"session_NEW1\"}"}]` | **nothing**. `json.dumps` escapes the inner quotes, so the regex never matches. |
  | the same, with pretty-printed JSON in `text` | **nothing** |
  | `cse_…` ID form | **nothing** (the regex requires `session_`, while the hook itself normalises `cse_`) |
  | raw string with another `"id":"session_FOREIGN"` before the new ID | `session_FOREIGN` (first match anywhere) |
  | dict `{"parent":{"id":"session_PARENT"},"id":"session_NEW4"}` | `session_PARENT` |
- **Why it matters:**
  - If the harness passes MCP results as content blocks, which is the usual shape for MCP tools, the recorder fails silently on every call.
  - Failing closed is safe for the account. But the builder is then blocked on its own new sessions, and the obvious workaround is a hand edit of `owned_ids.txt`. That brings back the routine hand-edit path that M2 was about.
  - The first-match rule can also record a foreign ID if a response ever embeds another session object before the new one.
  - §9 states as fact that "the model never adds IDs by hand, so an instruction injected into the session … has no routine path". That holds only once T-H7 passes.
- **Severity:** major. It is a condition, not blocking, because the failure mode is fail-closed.
- **Fix:**
  1. Parse, don't regex. If `resp` is a string, `json.loads` it. If it is a list of content blocks, `json.loads` each `text`. Then take the top-level `id`, or the documented nested location of the new ID, and normalise `cse_`.
  2. Record nothing if the ID is ambiguous.
  3. Add tests for the content-block shape and for a foreign ID that appears earlier in the response.
  4. Run T-H7 at the next `create_session`, before the merge if possible. Until then, §9 should say "designed; live test T-H7 pending".

---

## Minor findings

- **m1 · §9 "Every tool call" row over-credits T-H5.**
  - **Problem:** T-H5 was a `send_message` blocked by the owned-ID rule under the old matcher. It was not a block of an unlisted tool, and it says nothing about the `.*` matcher.
  - **Fix:** cite this review's live block of `ReadNotifications` in a builder-created session (this session, about 19:20Z; the tool error is the record), or a new probe.
- **m2 · The test is not hermetic.**
  - **Evidence:** On this review branch, before it was pushed, `tools/test_tool_allowlist.sh` gave **2 BAD** (the two "this session's branch" positive controls). The fetch of a branch that does not exist on the remote fails, so the hook blocks. On a fresh clone of the pushed `claude/epic-hamilton-9tisc4`, the result was 84 ok and `ALLOWLIST_TEST PASS`.
  - **Effect:** the behaviour is safe (fail-closed). But T-H4's "PASS" depends on the branch being pushed and on the network, and §13 does not say so.
  - **Fix:** do what the test already does for `main`: print an `info` line and expect 2 when the remote branch is missing. Say this in §13.
- **m3 · Three rules have no isolating negative control.** Each of these mutations still gives `ALLOWLIST_TEST PASS`:
  - `DEVOS_URL.fullmatch` → `.match`. The `\n` case is blocked by the revision check, not by the URL rule. With `.match`, `…/devos-anything` would pass the URL rule.
  - Removing `and "owner" not in args` for the review-thread tools.
  - Checking `origin/<ref>` instead of `FETCH_HEAD`.

  **Fix:** add a `…/devos-x` control with a passing revision, and an owner-only `resolve_review_thread` control. Note the third gap as covered by reading only.
- **m4 · Smaller defects in the recorder test.** It does not cover the content-block shape (N-M1). Line 107 (`cp … "$tmp.owned"`) runs after `rm -rf "$tmp"` and writes a stray file. **Fix:** remove that line; add the shapes from N-M1.
- **m5 · The hook's own header is stale.** The `tool_allowlist.py` docstring item 4 still says "Non-MCP surfaces that publish … are blocked". The code is now an allow list. **Fix:** "4. Non-MCP tools are an allow list; anything not named is blocked."
- **m6 · Limits of `check_service_names.sh`.**
  - The exclusion set drops the generic word that, capitalised and without its vendor prefix, was the product name R-C00-BOM-4 B2 found. The check would therefore not catch that exact regression.
  - The pattern is a frozen snapshot from `3cd686a`. A connector added to the account later is not covered.
  - **Fix:** state both limits in the script header and in §13. At each stage closure, compare the derived terms with the live server list of a probe session, without writing the names to the tree.
- **m7 · Appendix M "Allowlist hook" row.** Its "Failure" column still lists only an edited hook, a revision without `.claude/`, and a hook timeout. **Fix:** add remote subagents (until N-B1 is fixed) and the shell routes (R-1 below).
- **m8 · Out of the criterion's scope, but noted.** `create_session` with `outcome_branch: "main"` is allowed (re-run: exit 0). A child session would push straight to `main`, which bypasses PC-02 (PR-only). This is not a connector route. **Fix:** block `outcome_branch == "main"`, or state it.
- **m9 · Over-blocking that §9 should name, so that nobody "fixes" it by widening.**
  - `ReadNotifications`, `ScheduleWakeup` and `CronCreate` are blocked (re-run).
  - `ReadNotifications` is how a session reads queued PR events and messages when a notice says they are pending. Blocking it is safe, but it may hamper PR follow-up.
  - **Fix:** list these under "Known over-blocking", with the reasoning.

---

## Criterion 2 · Remaining routes and how to classify them

| # | Route | Who could trigger it | Classification |
|---|---|---|---|
| N-B1 | `Agent`/`Task` (and possibly `Workflow`) with remote isolation → a new cloud session outside the `create_session` rules | honest mistake or injection | **Blocking** (above) |
| R-1 | **The shell holds session-level credentials.** In this builder-created session, Bash can reach the messaging socket that `SendMessage` uses (`CLAUDE_CODE_MESSAGING_SOCKET` and its token are set; the socket exists), a readable session-ingress token file, and the `claude` CLI binary. The hook sees only "Bash". | injection that names the mechanism; not a plausible honest mistake | **Residual risk, must be stated.** Not exercised; I did not use any of them. Add it to §9 "Not protected" and to the D-003 brief. Neither currently mentions it. |
| R-2 | The shell's GitHub token. **Checked (read-only):** it is scoped by the session proxy. The `devos` permissions read `push: true`. The library returns 403, "not enabled for this session; use add_repo". The hook allows `add_repo` for the library with `read` only. | — | **Covered** by the `add_repo` rule; the existing OI-001 statement stands |
| R-3 | `create_trigger` with `create_new_session_on_fire` | honest mistake | Residual risk, **stated** (rests on BP-05, one observation) |
| R-4 | Whether hooks run for subagent tool calls | — | Documented, not observed. My probe through a subagent was inconclusive: it could not load the tool. Keep it as an open premise. |
| R-5 | Deliberate edit of `.claude/**`, including a hand edit of `owned_ids.txt` | deliberate | Residual risk, **stated** (D-003) |
| R-6 | Hook timeout | network stall | Effectively fail-closed for the new fetch: `git` has a 20 s timeout, and the exception blocks. A harness-level hook timeout stays untested, as stated in Appendix M. |

Other inputs re-run through the literal settings command, with results as expected:
- **Allowed:** upper-case `devos` URL; `.git/` suffix; `blob_limit_kb`; `update_trigger` on an owned trigger; `get_file_contents` on any repository (read).
- **Blocked:** `environment_id: "remote_cowork"`; `extra_allowed_tools` given as a string; a session ID with a trailing space; `devos ` with a trailing space; `get_session` with a null ID; `ScheduleWakeup`, `CronCreate`, `ReadNotifications`.
- `permission_mode: "bypassPermissions "` (trailing space) is allowed. The platform should reject that value as not in its enum, so I do not count it.

## Criterion 3 · Hook, recorder, settings, tests, name check

- `tools/test_tool_allowlist.sh`:
  - on a fresh clone of the pushed target head: **84 ok, ALLOWLIST_TEST PASS**;
  - on the unpushed review branch: 82 ok, 2 BAD (m2).
- **Mutation runs** (on a scratch clone; the working tree was not touched):

  | Mutation | Result |
  |---|---|
  | non-MCP allow list removed | detected |
  | permission widening removed | detected |
  | GitHub block list emptied | detected |
  | revision check bypassed | detected |
  | PR tools no longer limited to `devos` | detected |
  | a failed fetch ignored | detected |
  | owned persistent session no longer required | detected |
  | `SendMessage` added to the allow list | detected |
  | `ListAgents` added to the allow list | detected |
  | `fullmatch` → `match` | **missed** |
  | the repoless-owner condition removed | **missed** |
  | `FETCH_HEAD` → local ref | **missed** |

  §13's claim ("removing any of four rules … makes the test fail") is **verified**.
- `record_owned_id.py`: six response shapes tried (N-M1). It never blocks, and its exit code is always 0, as designed.
- `settings.json`: `PreToolUse` `.*` through the fail-closed wrapper; `PostToolUse` limited to the two create tools, with `|| true`. Correct as written.
- `tools/check_service_names.sh`: `SERVICE_NAMES CLEAN`, exit 0 (m6 for its limits).

## Criterion 4 · Ledger rule 4

| Place | Result |
|---|---|
| §2.2 | Hand-over limited to runs. Correct. |
| §9 | Mostly accurate, and it names each enforcement layer. Overstated: "Non-MCP tools … subagents" without the remote case (N-B1); "the model never adds IDs by hand" before T-H7 (N-M1); T-H5 credit (m1). Missing: the shell routes (R-1). |
| §13 | The T-H4 count (84) and the four mutations are reproduced; the dependence on a pushed branch is not stated (m2). T-H7 is honestly pending. |
| Appendix M | Owned-ID row updated. Allowlist row incomplete (m7). |
| `CLAUDE.md` | Step 3 narrowed; working-tree rule added. Correct. |
| Plan Section 9 item 6 (Turkish) | Verification labels are accurate. The scope claim "hesabın başka oturumlarına ulaşan araçları … engeller" holds for tool names, but not for remote subagents (N-B1) or the shell routes (R-1). Fix together with N-B1 and R-1, for example by adding "kabuk üzerinden kalan yollar §9'da yazılıdır". |
| `DURUM.md` | Stamp 22:16 TR = 19:16Z, which matches commit `ef4bd4d` (19:16:22Z). Content is consistent with the state file (run lock to 22:16Z) and correctly in the future tense. |
| L-021 | Dispositions match the target, except M2 "Accepted" (designed, not working on likely inputs: N-M1). The new rule (write the disposition before the final check run, and quote its output) is followed: "SERVICE_NAMES CLEAN" is quoted, and I reproduced it. |

## Criterion 5 · Public repository safety

- `tools/check_service_names.sh`: clean (12 derived terms). Each of the 10 alternatives of the old L-019 pattern is covered by the derived terms, with 0 tree hits.
- I also checked several service names visible in this session's own environment against the tree. Only one generic word matched, inside the script's own exclusion set. I do not name them here.
- Commit messages and added lines of the target: 0 hits for the derived terms. A scan of the added lines for token, key, JWT, private-key and e-mail patterns found 0 hits.
- `owned_ids.txt` publishes session and routine IDs. These are not credentials, as accepted before.

## Conditions to reach PASS

- **C1:** fix N-B1: block remote isolation for `Agent`/`Task` (and in `Workflow`), add negative controls, and update the §9 row.
- **C2:** fix N-M1: parse the response properly and test the content-block shape. Mark M2 as "designed" until T-H7 passes.
- **C3:** state R-1 (shell credentials: messaging socket, ingress token, CLI binary) in §9 "Not protected" and in the D-003 brief. Adjust plan Section 9 item 6 to match.
- m1 to m9 may ride along. A narrow re-check of the hook diff, the recorder, the test, the §9 rows and plan item 6 is enough.

## Method

- **Read:**
  - `git diff 5d6861a..HEAD`;
  - R-C00-BOM-4 (from `claude/review-R-C00-BOM-4`);
  - the hook, the recorder, `settings.json`, `owned_ids.txt`, both test scripts;
  - operating model §2.2, §9, §13, R1, R2 and Appendix M;
  - plan Section 9 item 6; `CLAUDE.md`; `DURUM.md`; the ledger rows; L-019 and L-021.
- **Ran:**
  - both scripts, here and on a fresh clone of the pushed head;
  - 12 hook mutations on that clone;
  - about 25 extra hook inputs through the literal settings command;
  - 6 recorder input shapes on a scratch copy;
  - name and secret-pattern scans that print counts only;
  - one live call of an unlisted non-MCP tool (`ReadNotifications`), blocked;
  - read-only `gh api` permission reads for `devos` and the library;
  - checks that the messaging socket, the ingress token file and the `claude` binary exist. None of them was used.

## Could not check

- **What a remote subagent session gets** (revision, environment, connectors, whether it carries the hook). Checking would mean creating a session on the account.
- **The real `tool_response` shape** that the harness gives a `PostToolUse` hook for an MCP tool. It is only observable through a `create_session` (T-H7).
- **Whether hooks apply to subagent tool calls.** My subagent probe could not load the test tool, so the result was inconclusive.
- **Whether the shell routes in R-1 actually reach the account's other sessions.** Exercising them would act on the account.
- **The scope of the other cloud credentials present in the shell environment.** Not probed.
- The scope of the opaque Supabase connector (still identified by inference, as §9 says).
