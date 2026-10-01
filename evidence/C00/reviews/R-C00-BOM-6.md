# R-C00-BOM-6 · Narrow re-check: operating model v1.6 (answer to R-C00-BOM-5)

- **Target:** `git diff c166639..7fb2ca8` on `claude/epic-hamilton-9tisc4` (10 files).
- **Criteria:** conditions C1–C3 and minor findings m1–m9 of `evidence/C00/reviews/R-C00-BOM-5.md`, and the dispositions claimed in `plan/ledger/C00-log.md` L-023.
- **Reviewer:** a separate session on `claude/review-R-C00-BOM-6`. It does not see the producer's conversation. Same model family, so this is thinking independence only (BP-07).
- **Date:** 2026-10-01.
- **Scope note:** the branch has moved on since the target (`bdbf92f`, "T-H7 passes live", L-024). That commit is outside the target and was **not** reviewed. Every check below ran on `7fb2ca8`.

## Verdict: **PASS**

- C1, C2 and C3 are met.
- No blocking finding. No finding rises to a condition.
- The minor findings below (n1–n8) may ride along with the next change. None of them is a route that an honest builder or an injected instruction could use to reach the account.

| Condition | Result |
|---|---|
| C1 (remote subagents, `Workflow`) | **Met.** Reproduced through the literal settings command. Every rule has a control that detects its removal (mutation table below). |
| C2 (recorder parses; records nothing on ambiguous or foreign IDs; M2 marked "designed") | **Met.** 7 extra response shapes tried beyond the test's own. All of them either record the right ID or record nothing. §9 and §13 say "live test T-H7 pending". |
| C3 (R-1 shell routes stated; plan item 6 matches) | **Met.** They are in §9 "Not protected", and plan Section 9 item 6 now points there explicitly. "And the D-003 brief" is met only indirectly (n6). |

---

## Criterion 1 · Subagents and `Workflow` are blocked through the literal settings command

**What the target does.** In `check()`, `Agent` and `Task` are allowed only when `tool_input.isolation` is absent or null. Any other value is blocked: `"remote"`, `"worktree"`, `""`, or a future value. `Workflow` is removed from `ALLOWED_NON_MCP`.

**Re-run** on a fresh clone at `7fb2ca8`, with the command read from `.claude/settings.json` and run under `sh`:

| Input | Exit |
|---|---|
| `Agent` / `Task` with `isolation: "remote"` | 2 |
| `Agent` with `isolation: "worktree"` / `""` / `"some_future_value"` | 2 |
| `Agent` with `isolation: null`; `subagent_type: "fork"`; `run_in_background: true` | 0 (in-process, as intended) |
| `Agent` with a non-object `tool_input` | 2 |
| `agent` (lower case), `Workflow` (any input), `RemoteTrigger` | 2 |
| `Agent` with a key `Isolation` (wrong case) | 0. Not a route: the platform schema has no such key. |

**Full test:** `tools/test_tool_allowlist.sh` gives **107 ok, `ALLOWLIST_TEST PASS`**, plus one `info` line (`main` has no `.claude/settings.json` yet). This matches §13 and L-023.

**Mutation runs.** These ran on a scratch clone at `7fb2ca8`, checked out on the pushed branch name. The working tree was not touched.

| Mutation | Result |
|---|---|
| subagent isolation rule removed (`if False:`) | detected |
| isolation blocked only when `== "remote"` | detected (worktree and future-value controls) |
| `Task` dropped from `SUBAGENT_TOOLS` | detected |
| `Workflow` re-added to the allow list | detected |
| `outcome_branch` `main` rule disabled | detected |
| `DEVOS_URL.fullmatch` → `.match` | detected |
| repository-less thread condition without `"owner" not in args` | detected |
| non-MCP default-allow | detected |
| permission-widening rule removed | detected |
| `FETCH_HEAD:` → `HEAD:` in the revision check | detected. This catches the main-branch control. The `origin/<ref>` variant that R-C00-BOM-5 named was not re-run. §13 honestly lists it as "reading only". |
| recorder: any ID when ambiguous | detected |
| recorder: no `ccr`/`trigger` preference | detected |
| recorder: no `cse_` normalisation | detected |
| recorder: list-of-text format ignored | detected |
| recorder: prefix and alphanumeric check removed | **missed** (n2) |

**What I could not show.** I found no way to start a remote subagent through an allowed tool input. One residual path remains unverified: whether an agent **definition** can carry an isolation setting of its own (n1).

## Criterion 2 · `record_owned_id.py`

**How it works.** The recorder now parses the response and does not search it as text:
- a dict;
- a JSON string;
- a list of `{"type":"text","text":…}` items, where each text is JSON-parsed and items that are not JSON objects are skipped.

From each parsed object it takes the ID from `ccr` / `trigger` if that key holds an object, or else from the top-level `id`. It then normalises `cse_`, requires the expected prefix plus a non-empty alphanumeric tail, and records **only if exactly one distinct ID** is found. On any exception it records nothing and exits 0.

**Extra shapes** I fed to a scratch copy, beyond the test's own 10:

| Shape | Recorded | Judgement |
|---|---|---|
| `{"ccr":{"id":A},"id":B}` | A | correct (the documented place wins) |
| `{"ccr":{"title":…},"id":B}` | nothing | fail-closed. `ccr` is present without an id, so the top-level id is ignored. Correct. |
| a second text item with a foreign top-level `id` | nothing | ambiguous, so nothing. Correct. |
| `create_trigger` whose response holds only `{"id":"session_…"}` | nothing | the prefix guard works |
| a dict wrapper `{"content":[{text…}]}` | nothing | fail-closed miss (n3) |
| a JSON string that encodes the list | nothing | fail-closed miss (n3) |
| `session_` plus full-width letters | recorded | `str.isalnum()` accepts Unicode. Harmless, because the ID comes from the session's own create response (n8). |

**Conclusion:** no shape I could build makes it record a foreign ID. Every failure is a missed ID, which fails closed.

**About the evidence for the shape.** The recorder's premise is that `create_session` returns the new ID at `ccr.id`. Per L-022, that premise rests on the observed shape of a `get_session` response, not of a `create_session` response. Appendix M says this correctly ("as `get_session` … returned them"). The recorder's docstring calls it "documented" (n4).

## Criterion 3 · R-1 stated

- **§9 "Not protected"** has a new bullet. It names the messaging socket, the session-ingress token file and the `claude` program, and says the hook sees only "Bash". It is marked "not exercised" and "Listed for D-003". This is accurate and no stronger than the R-C00-BOM-5 evidence. It names no values.
- **R-4** (hooks inside in-process subagents) is listed as an open premise. Good.
- **Plan Section 9 item 6** (Turkish) now says:
  - remote subagents are blocked;
  - the hook looks only at the tool name and input;
  - the routes it does not cover, the shell included, are in §9 "Not protected".

  This matches §9. The earlier phrase "hesabın başka oturumlarına ulaşan araçları … engeller" is now bounded by the closing sentence, so it no longer overstates.

## Criterion 4 · §9, §13 and Appendix M against the evidence

| Place | Claim | Result |
|---|---|---|
| §9 "Every tool call" | Live: the R-C00-BOM-5 reviewer was blocked from `ReadNotifications` | Matches R-C00-BOM-5 (m1 fixed) |
| §9 "Non-MCP tools" | in-process only; `Workflow` blocked; "Unit-tested, with mutation checks" | Reproduced |
| §9 "Session tools" | `outcome_branch` `main` blocked | Reproduced (`main`, ` Main `, `refs/heads/main\n` all blocked). The row's "live (T-H5, T-H6)" covers older rules only (n7). |
| §9 owned-ID paragraph | "Designed and unit-tested; the live test T-H7 is pending" | Accurate for the target |
| §9 over-blocking list | `ReadNotifications`, `ScheduleWakeup`, `CronCreate`, `Workflow`, worktree subagents | Matches the code (m9 fixed) |
| §13 T-H4 | 107 checks; the listed rules are detected on removal; `FETCH_HEAD` covered by reading only; not hermetic | Count and detections reproduced. The hermeticity note **understates** the effect (n5). "8 response shapes" is loosely counted: the test has about 10 watched-tool shapes. That is harmless. |
| §13 T-H7 | FAIL at the first try; parser rewritten; live re-test pending | Accurate for the target |
| Appendix M, allowlist row | uninspected inputs; shell routes | Added (m7 fixed) |
| Appendix M, owned-ID row | the shape premise is cited to `get_session`; T-H7 pending | Accurate |

**L-023 dispositions.** All match the diff, except the two wordings in n6. The final check outputs quoted in L-023 (107 ok; `SERVICE_NAMES CLEAN … 12 terms`) are reproduced exactly.

**Earlier minor findings:**

| Finding | Result |
|---|---|
| m2 | Partly addressed (n5) |
| m3 | Fixed |
| m4 | Fixed: the stray `cp` line is gone |
| m5 | Fixed |
| m6 | Fixed in the script header only (n6) |
| m8 | Fixed |

## Criterion 5 · Public-repository safety

- `tools/check_service_names.sh` → `SERVICE_NAMES CLEAN (pattern derived from 3cd686a; 12 terms)`, exit 0.
- **Added lines and commit messages:** 0 hits for token, key, JWT, private-key and AWS-key patterns. The only e-mail-shaped string is the standard co-author attribution line.
- **IDs in added lines:**
  - one real session ID (the R-C00-BOM-5 reviewer);
  - the builder environment ID, which was already in the test before;
  - test fixtures.

  None of these is a credential. The R-1 bullet names mechanisms, not values.
- The copied R-C00-BOM-5 file names the allowed Supabase connector, which §9 already names. No other service names appear.

---

## Findings

No blocking findings. All of the following are **minor**.

**n1 · An agent definition may set isolation outside the tool input** (`.claude/hooks/tool_allowlist.py`, the `SUBAGENT_TOOLS` branch)
- **Problem:** the hook inspects only `tool_input.isolation`. Agent types take settings from their definition files (`.claude/agents/*.md` frontmatter, or user-level ones). If a definition can declare an isolation mode, `Agent` with `subagent_type: <that type>` and no `isolation` field would pass.
- **Unverified:** I did not check whether the frontmatter supports a remote value. No such agent type exists in this session.
- **Effect:** writing a repository definition is an edit to `.claude/**`, which is already a stated high-impact change. A user-level definition outside the repository is not covered by that wording.
- **Suggested fix:** add one line to §9 "Not protected" (agent definitions are not inspected; do not create agent definitions), or allow only a fixed list of `subagent_type` values.

**n2 · The recorder's prefix and alphanumeric guard has no isolating control** (`tools/test_tool_allowlist.sh`, recorder block)
- **Problem:** the mutation `if i:` (accept any ID) still gives `ALLOWLIST_TEST PASS`.
- **Failure scenario:** a `create_trigger` response that carries a session ID at the top level, with no `trigger` object, would be recorded as owned once the guard is gone.
- **Suggested fix:** add `rec create_trigger '{"id":"session_X"}'` and a `create_session` response with `{"ccr":{"id":"env_X"}}`, both expected to record nothing.

**n3 · Two plausible response shapes are fail-closed misses** (`record_owned_id.py`, `payloads`)
- **Shapes:** a dict wrapper `{"content":[…]}`, and a JSON string that encodes the list of text items.
- **Why minor:** the observed format (L-022) is the bare list, so this is not a live defect today. If the harness changes format, the builder is blocked on its own sessions, and the tempting workaround is a hand edit.
- **Suggested fix:** unwrap `content` and handle a JSON-decoded list. At minimum, name the expected format in §9 so that a miss is recognised as a format change.

**n4 · The docstring says "documented place"** (`record_owned_id.py`, lines 7–9)
- **Problem:** the `ccr.id` location is inferred from a `get_session` response (L-022), not documented, and not observed on `create_session`.
- **Suggested fix:** "observed place (on `get_session`, L-022)".

**n5 · On an unpushed branch, two rules lose their controls, and the test still prints PASS** (`tools/test_tool_allowlist.sh`, `[ $bok = 0 ] && t 2 …`; §13 T-H4)
- **Re-run** on a clone checked out on a branch that is not on the remote:
  - 105 ok and `ALLOWLIST_TEST PASS`;
  - the mutations `fullmatch` → `match` and "`outcome_branch` rule disabled" both **missed**.
- **Problem:** §13 says only that the branch controls "expect a block". It does not say that the `fullmatch` and `outcome_branch` controls are skipped. A PASS from an unpushed branch therefore proves less than the T-H4 row claims.
- **Suggested fix:** print an `info` line naming the skipped controls, and state in §13 that T-H4 counts only when run on a pushed branch (107 checks).

**n6 · Two L-023 dispositions say more than the diff does** (`plan/ledger/C00-log.md`, L-023)
- **R-1:** "Added … to the D-003 brief". No brief exists yet. The D-003 row says the brief must list §9 "Not protected", so the route reaches it **indirectly**.
- **m6:** "Comparison with a live server list is added to each stage closure". The only change is a comment in the script header. No closure procedure and no §13 text changed.
- **Suggested fix:** reword both ("§9 list, which the D-003 brief must carry"; "stated in the script header; to be added to the closure checklist"), or make the closure change.

**n7 · The §9 "Session tools" verification column now spans an untested-live rule** (`plan/Builder_Operating_Model.md` §9)
- **Problem:** "Unit-tested; live (T-H5, T-H6)" now also covers the `outcome_branch` rule, which only has unit tests.
- **Suggested fix:** add "(`outcome_branch`: unit-tested only)".

**n8 · Small items**
- `str.isalnum()` accepts non-ASCII letters (`record_owned_id.py`). Use `re.fullmatch(r"[A-Za-z0-9]+", …)` if strictness matters. It is harmless today.
- `DURUM.md`:
  - It says "beşinci turda kalan tek önemli açık … kapatıldı". R-C00-BOM-5 had one blocking **and** one major finding, and "kapatıldı" is stated before this check had passed. Suggested wording: "en önemli açık … kapatıldı; dar incelemede".
  - Its stamp (22:35 TR = 19:35Z), and the ledger "Next action" stamp (19:35Z), are later than the commit that contains them (19:31:39Z).
- The recorder test calls the script directly, not through the `PostToolUse` command (`… || true`). That is acceptable because the recorder never blocks. Note it if T-H4 is meant to cover the settings command for both hooks.

---

## What I could not check

- **The agent-definition route (n1):** whether a definition can set a remote isolation mode. Checking it would need writing an agent definition and launching it.
- **Whether hooks run for tool calls inside in-process subagents** (R-4): this is still an open premise, and I did not probe it.
- **The live `create_session` response shape and T-H7.** That would need creating a session. A later commit outside the target (`bdbf92f`) claims T-H7 passes. I did not review it.
- **The R-1 shell routes:** not exercised, as before.
- **The `origin/<ref>` variant of the revision-check mutation** (R-C00-BOM-5 m3): not re-run. §13 lists it as covered by reading only.

## Method

- **Read:**
  - the target diff;
  - R-C00-BOM-5;
  - L-022 and L-023;
  - `.claude/settings.json`, both hook scripts and both test scripts at `7fb2ca8`;
  - the changed rows of §9, §13 and Appendix M;
  - plan Section 9 item 6;
  - the D-003 row and references (to check the n6 wording).
- **Ran:**
  - both scripts on a fresh clone at `7fb2ca8`, on the pushed branch name and on an unpushed branch name;
  - 17 hook and recorder mutations;
  - about 20 extra hook inputs through the literal settings command;
  - 7 extra recorder shapes on a scratch copy;
  - secret-pattern and ID scans of the added lines and commit messages, printing counts only.
