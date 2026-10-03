# R-C00-BOM-3 · Independent re-review: builder operating model v1.3 (PR #4)

- **Target:** `git diff 33b5043..c0007ea` on `claude/epic-hamilton-9tisc4` (16 files). Context: `git diff origin/main...c0007ea`.
- **Reviewer:** a separate session (`session_01PEMTsgPZVoFoz44RHzPELw`, created by the builder session, environment `env_01AMBDuHjjTsXMeXFyYgk1zR`, checkout of `claude/epic-hamilton-9tisc4` at `c0007ea`). It does not see the producer's conversation. Independence level: same model family, separate session, restricted input (thinking independence only, BP-07).
- **Date:** 2026-10-01, checks run about 18:53–19:05Z.

## Verdict: **FAIL**

Most of R-C00-BOM-2 is fixed for real:
- the wrapper makes the hook fail closed in every case I could produce;
- the session tools are now checked;
- the Turkish labels in plan Section 9 item 1 and Appendix F are honest;
- `DURUM.md` is stamped correctly;
- the numbering exception is in the binding Turkish text;
- the mechanism register is complete enough.

It fails on one blocking point and one claims point:

1. **B1. The new session-tool rules can still be bypassed, through parameters and tools the hook does not look at.**
   - `create_session` with `source_url` = `devos` and `source_revision` set to any commit or branch without `.claude/` is allowed. That gives a session without the barrier. Today the default branch `main` (`d97ac8d`) has **no** `.claude/settings.json` at all, so even the hook's own "legitimate" positive control yields an unprotected session until PR #4 merges.
   - `create_trigger` with `persistent_session_id` set to any session is allowed. This is the `send_message` route that the owned-ID rule was meant to close.
   - Unlisted session tools are allowed by default, including `list_events` and `get_event` on any session of the account.
   - The non-MCP resource tools are not covered.

   Plan Section 9 item 6, §9's table and `DURUM.md` item 2 state the closed version.
2. **B2. L-018 again records a fix as done that is not done.** M9's redaction is incomplete in five current files, including the two that L-018 names. This is the third time this failure class (FND-001) has appeared in a disposition record.

The fixes are small: a few hook lines with tests, plus text. A narrow re-review is enough. It should cover the hook diff, the test script, §9, plan Section 9 item 6, `DURUM.md` item 2 and the redaction.

---

## Criterion 1 · R-C00-BOM-2 findings: is each one actually resolved?

| Finding | Judged on the target | Resolved? |
|---|---|---|
| B1 session tools route around the barrier | `create_session` now requires a `devos` `source_url`, no sparse checkout, and the builder environment (I confirmed that `env_01AMBDuHjjTsXMeXFyYgk1zR` is the environment of this builder-created session). `add_repo` is limited. Targeted tools need an owned ID. Routines cannot be given connectors. 26 negative controls cover the cases R-C00-BOM-2 listed. But `source_revision`, `create_trigger.persistent_session_id`, `create_trigger.environment_id` / `create_new_session_on_fire` and every unlisted session tool are unchecked (new B1). | **Partly** |
| B2 Turkish text and `DURUM.md` overstate | Item 1 is relabelled "Tasarım; kısmen gözlendi". Appendix F is softened. `DURUM.md` says 21:52 TR = 18:52Z, and the commit is 18:52:12Z, so the stamp is correct. L-016 is corrected in L-018. Item 6 now uses accurate verification labels (unit test, T-H3, T-H5), but it states a **scope** the hook does not have (B1). | **Mostly**; new overstatement of scope |
| M1 register incomplete | 32 rows. Every mechanism R-C00-BOM-2 named now has a row. No "Assumption: none" remains (the remaining "none" cells are costs). §1 has the from-scratch column. The deny rules are removed by the register's own rule. | **Yes** (minor note m6) |
| M2 hook fails open on syntax, import, missing interpreter | Re-run with the exact command from `settings.json` under `/bin/sh` (dash): a syntax error, a failed import, a hook returning 1, a missing hook, `python3` missing from `PATH` and `CLAUDE_PROJECT_DIR` unset **all exit 2**. The test covers four of these. | **Yes** |
| M3 lease check informational | `BUILDER_RUN=1` makes a non-holder `FAIL`. An unset session variable, with `BUILDER_RUN=1`, gives `FAIL`, not an abort. Expiry more than 3h15m ahead gives `FAIL`, and an invalid date gives `FAIL`. All re-run in a scratch repository. See criterion 3 for the remaining logic issues. | **Yes** (minor m3, m4) |
| M4 numbering in Turkish | Plan line 12 and ledger rule 5 both carry the exception. | **Yes** |
| M5 W-C00-05 (c) | Recorded in ledger §2 before closure and sent for review. See criterion 5. | **Yes in form**; condition C4 |
| M6 CODEOWNERS at C08 | Recorded as gap G-016, with the right remedy. It is deferred, which is acceptable for a latent C08 risk. | **Yes** (tracked) |
| M7 GitHub edge cases | Case-insensitive comparison, `actions_*` read-only, and the thread tools are all fixed and tested. The reason for not adding the plan 6.1 edit hook is stated. But the stated reason ("reviewed before merge") is enforced by instruction only (G-015), and the thread-tool rule is wider than §9 says (m1). | **Mostly** |
| M8 opaque ID by inference | Labelled "identified by inference", with the grounds. | **Yes** |
| M9 account connector inventory | `T-H3.md` is redacted. Service names, and opaque-ID-to-service mappings, remain in `R-C00-BOM-1.md`, `R-C00-BOM-2.md`, `EV-C00-005`, the operating model §13 and the test script (B2). | **Partly**; claimed as done |
| M10 non-MCP surfaces | The artifact tools and design sync are blocked and tested. The MCP resource tools (`ListMcpResourcesTool`, `ReadMcpResourceTool`) reach the same MCP servers as the connectors and are neither matched nor listed as a residual risk (B1 d). | **Partly** |

---

## Blocking findings

### B1 · Session-tool scope and connector barrier still bypassable (criterion 2; ledger rule 4)

- **Where:**
  - `.claude/hooks/tool_allowlist.py`: `check_session_tool` (its final `return 0` and its `create_trigger` branch), and `BLOCKED_NON_MCP`;
  - `.claude/settings.json` matcher;
  - `plan/Builder_Operating_Model.md` §9 table, row "Session tools";
  - `plan/DevOS_Kurulum_Plani.md` Section 9 item 6: "yeni oturumların yalnız `devos`'un tam kopyasıyla açılmasına izin verir; kurucuya ait olmayan oturum ve routine'lere dokunmayı engeller";
  - `DURUM.md` item 2: "Engel artık benim yeni oturum açmamı, başka oturumlara mesaj göndermemi … da denetliyor".

- **Re-run:** each input below was piped through the exact `settings.json` command and **exits 0 (allowed)**.

  | # | Input | Effect |
  |---|---|---|
  | a1 | `create_session` with `{"source_url":"https://github.com/batuhanozgun/devos","source_revision":"9ae67ef"}` | A full checkout of a commit that has no `.claude/` (`.claude/settings.json` first appears in `a58413a`, and the hook in `3cd686a`). The session runs with live connectors and no hook. |
  | a2 | the same with `"source_revision":"<any branch>"` | The builder can push a branch without `.claude/` (`git push` and GitHub writes to `devos` are allowed) and start a session on it |
  | a3 | `create_session` with `{"source_url":"https://github.com/batuhanozgun/devos"}`, i.e. the positive control in the test | It checks out the default branch. **`origin/main` = `d97ac8d` has no `.claude/settings.json`**, so today this session has no barrier. §9 "Not protected" mentions "any session started before this change merges". But plan item 6 and `DURUM.md` do not, and R2 tells the dispatcher to start runs "on devos main". This reviewer session itself had to be started with `source_revision` = the PR branch. |
  | b | `create_trigger` with `"persistent_session_id":"session_SOMEONE_ELSE"` | A routine that fires a prompt into any session of the account, including sessions Batu opened. This is exactly what the owned-ID rule blocks for `send_message`. |
  | c1 | `create_trigger` with `"create_new_session_on_fire":true` (optionally with another `environment_id`) | A fresh session per firing, with no repository and therefore no hook. Today T-A1b observed such sessions to have no tools, which limits the risk. Its environment is not checked, unlike `create_session`. |
  | c2 | `create_trigger` with no `connectors` field | The tool documents "Omit to keep the default behavior for this surface". Only an explicit `[]` guarantees no connectors. The hook allows omission (and the falsy value `""`). |
  | d1 | `list_events` / `get_event` with `"session_id":"session_SOMEONE_ELSE"` | Reads the transcript of any session of the account. In a session where Batu used a connector, that transcript contains the connector's output (mail, calendar or file content). That is account data read around the barrier, and a builder could then commit it to this public repository. `get_trigger`, `list_sessions` and `list_triggers` similarly expose other routines' stored prompts. |
  | d2 | any future or unlisted session tool, for example `some_future_write_tool` with a foreign `session_id` | The final `return 0` is default-allow. The MCP layer is an allow list, but the session layer is a deny list. |
  | e | `ReadMcpResourceTool` with `{"server":"<opaque connector ID>","uri":"…"}`; `ListMcpResourcesTool` | These are not `mcp__`-prefixed, so they are not matched. They read MCP resources from any connected server, connectors included. Whether this account's connectors expose resources is **not verified** (see "Could not check"). §9 lists unknown non-MCP surfaces only "if new ones appear", but these exist now. |

- **Failure scenarios:**
  - (a3) The dispatcher follows R2 literally before PR #4 merges: `create_session` on `devos` `main`. Or after a revert, or a bad merge that drops `.claude/`. The run then has live connectors and no hook, and every check the builder relies on passes.
  - (b) A heartbeat routine is created with a mistyped or copied `persistent_session_id` that points at one of Batu's own sessions. It injects builder prompts there every 6 hours.
  - (d1) A boot step "read the previous session's events" with a wrong ID pulls a transcript from one of Batu's sessions into a commit.
- **Severity:** blocking. B1 of R-C00-BOM-2 asked for the hook to enforce two things: "full checkouts" and "do not act on sessions you did not create". The binding text now says it does. For a1–a3 and b, it does not. Each is a single parameter.
- **Fix:**
  1. `create_session`:
     - allow `source_revision` only when absent or `main`. Until PR #4 merges, also allow the one named working branch. Block raw SHAs and other branches.
     - Note in §9 that this protects only while `main` carries `.claude/`.
     - Until the merge, R2's "devos main" must read "the working branch", or no runs are started.
  2. `create_trigger`:
     - block `persistent_session_id` unless it is in `owned_ids.txt`;
     - require `connectors == []` explicitly (or block the field, since T-A0 shows it is rejected anyway);
     - block `create_new_session_on_fire` or a non-builder `environment_id` until needed.
  3. Make the session layer an allow list: name the read tools explicitly. Restrict `list_events`, `get_event` and `get_trigger` to owned IDs. Block unknown tools.
  4. Add `ListMcpResourcesTool` and `ReadMcpResourceTool` to the matcher and to `BLOCKED_NON_MCP`. Alternatively, allow them only for the allowed servers.
  5. Add a negative control for each of a1, a2, b, c1, c2, d1, d2 and e to `tools/test_tool_allowlist.sh`.
  6. Restate plan Section 9 item 6, the §9 table and `DURUM.md` item 2 to match what is then enforced. Until then, list a, b, d and e under "Not protected".

### B2 · M9 redaction recorded as done but incomplete (criterion 6; ledger rule 4)

- **Where:** L-018 says "Service names redacted in `evidence/C00/probes/T-H3.md`, `R-C00-BOM-1.md` and `R-C00-BOM-2.md`".
- **What the current files still contain** (names of the account's third-party services, some tied to their opaque server IDs):
  - `evidence/C00/reviews/R-C00-BOM-1.md` lines 35, 39 and 89. Line 35 maps the opaque ID `9c01eb9f…` to a named mail service, and lists display names of the old deny rules.
  - `evidence/C00/reviews/R-C00-BOM-2.md` lines 63 and 67.
  - `evidence/C00/EV-C00-005_builder_operating_model_tests.md` lines 9 and 15. Line 9 maps `1a59c906…` to a named service.
  - `plan/Builder_Operating_Model.md` line 297 (§13 row T-A1c): the same mapping.
  - `tools/test_tool_allowlist.sh` lines 13, 28 and 56, as a display-name test input. This is mild, but it is the same name.

  Found with a case-insensitive search of the working tree for the service names that the earlier versions of `T-H3.md` listed.
- **Severity:**
  - The safety impact is minor. It is account metadata, not a secret, and R-C00-BOM-2 rated M9 optional.
  - It is **blocking as a claims finding**, because L-018 records as done something that is not done. L-018 itself names this failure class ("the same failure class as FND-001, now repeated in a disposition record") while repeating it.
- **Fix:**
  - Redact the places listed. Use "a mail connector" and similar, and drop the ID-to-service mappings.
  - Change the test input to a neutral display name such as `mcp__SomeConnector__send`.
  - Correct L-018's M9 disposition.
  - Before recording any redaction as done, run a tree-wide search and record the command and its empty result.

---

## Minor findings

- **m1 · Review-thread tools are allowed for any repository.**
  - **Where:** hook `REPOLESS_GITHUB_ALLOWED`.
  - **Problem:** `resolve_review_thread` with a `threadId` from another repository's PR exits 0 (re-run). §9 says these tools "act on threads of PRs the builder opened". That is an assumption, not enforced.
  - **Fix:** say so in §9 ("allowed for any thread ID; low impact"), or check the thread ID's repository.
- **m2 · The test misses two rules and the matcher.**
  - Mutation runs: removing the `BLOCKED_GITHUB` check leaves the test at **0 BAD**. `create_repository` is still blocked by the write-scope check, and `fork_repository` is not tested; `fork_repository` on `batuhanozgun/devos` would then be allowed.
  - Every other rule I removed was detected (1–3 BAD each).
  - The test copies the wrapper text instead of reading `settings.json`, so a changed command or matcher in `settings.json` goes untested.
  - **Fix:** add `fork_repository` on `devos` as a negative control. Read the command and matcher from `settings.json` in the test, and assert that the matcher matches `mcp__x__y`, `Artifact` and the resource tools.
- **m3 · Lease hand-over is undefined, and the gate makes it sharper (criterion 3).**
  - §2.1 makes "create the successor" the run's last act. §2.2 says a booting session treats the lease as live while its holder is working. `CLAUDE.md` step 3 says that a session finding a live lease stops.
  - A successor that boots while the predecessor is still writing its stop report therefore stops. Recovery waits for the heartbeat (up to 6 h).
  - If the predecessor instead writes the successor's ID into the lease before its final check, its own `BUILDER_RUN=1` check fails.
  - **Fix:** define the hand-over. For example: the predecessor runs the check, then merges "Run lock: `<successor>`" and creates the successor, and the stop report says the check preceded the hand-over. Or: a booting session may take over a lease whose holder is its own `parent_session_id` (visible in `get_session`).
- **m4 · `builder_check.sh` details.**
  - The holder test is a substring match on the whole row. A row such as "`session_OTHER` (released by ME)" passes for ME (re-run).
  - The output does not print the mode, so when the holder matches, a run without `BUILDER_RUN=1` looks identical to a gated run.
  - **Fix:** match the first backticked ID only; print `MODE run` or `MODE report`, and have R1's condition require `MODE run`.
- **m5 · The `owned_ids.txt` workflow contradicts itself.**
  - The file header and §9 call changes to it high-impact, needing review before merge.
  - The hook reads the **local** file, so an added ID takes effect at once, and every new run, dispatcher or reviewer needs an added ID before it can be archived or messaged.
  - Either every session start triggers a review, or the rule is not followed. The register row's assumption ("kept current") hides this.
  - **Fix:** state that adding an ID returned by the builder's own `create_session` or `create_trigger` call is a record change (merged at once, checked at closure), and that only removals and foreign IDs are high-impact.
- **m6 · Stale statements in §1 and §13.**
  - BP-03 cites T-A1c as an observation of `/goal`, but T-A1c tested connectors.
  - BP-06 still describes the deny rules that v1.3 removed.
  - §13 T-H1 is listed as a PASS of a removed mechanism.
  - **Fix:** cite T-A1a and T-A1b only; mark BP-06's deny-rule sentence and T-H1 as "mechanism removed in v1.3".
- **m7 · Enforcement layer not named for "reviewed before merge".**
  - §9 ("Why there is no separate hook…") and Appendix M rely on "they go through a review before merge" for `.claude/**`.
  - G-015 says `main` requires a pull request but no approval. That review is therefore enforced by instruction only, and the builder can open and merge its own PR (allowed by the hook).
  - **Fix:** add "(instruction; no required approval on `main`, G-015)".
- **m8 · T-H5's evidence is not traceable.** EV-C00-005 gives the blocked message but no session ID, time or event reference, unlike T-H3. **Fix:** add them.
- **m9 · The deny-rule removal ignored defence in depth.**
  - The removal test says the hook blocks the same tools. That holds only while the hook runs.
  - In Batu-started sessions, the display-name rules were an independent second layer that does not depend on `python3`.
  - With the wrapper this is acceptable. Note it in the register row.

---

## Criterion 2 · Hook, settings and test

- `tools/test_tool_allowlist.sh`: **45/45 pass** (26 negative, 15 positive, 4 wrapper), matching T-H4's counts. `bash -n` is clean on both scripts.
- **Wrapper fails closed:** confirmed for six cases with the literal `settings.json` command (see M2 above).
- **Should block but allows:** B1 (a1–a3, b, c1, c2, d1, d2, e); m1. Also allowed, and stated or acceptable:
  - GitHub file writes to `devos` `.claude/**` through the API (§9 residual, m7);
  - `add_repo` for `devos` with push access;
  - `create_session` with `permission_mode`, `extra_allowed_tools` or `blob_limit_kb`. Hooks still apply in such sessions, as far as the documentation goes; I did not check this live.
- **Should allow but blocks:**
  - `send_message` with a `cse_`-form ID of an owned session, which fails closed;
  - `add_repo` for any repository other than `devos` and the library, even read-only (for example, the old experiment repositories that the plan allows reading).

  Both are safe failures. Note them in §9 so they are not "fixed" by widening.
- **Live, incidental:** this session's `mcp__claude-code-remote__get_session` call (self, read-only) succeeded with the hook present in the checkout. This is consistent with the allow path; it is not a test of blocking.

## Criterion 3 · `builder_check.sh`

Re-run in a scratch repository whose `main` has all the required files. `BUILDER_RUN=1` was used throughout, except in the third row.

| Lease row | `BUILDER_RUN` | Result |
|---|---|---|
| foreign holder, +1 h | 1 | `FAIL` (correct) |
| foreign holder, +1 h, session variable unset | 1 | `FAIL` (correct, no abort) |
| foreign holder, +1 h | unset | `INFO` and `BUILDER_CHECK PASS` (as designed) |
| own, +4 h | 1 | `FAIL` (bound works) |
| own, invalid date | 1 | `FAIL` |
| own, two "Expires" values (the first valid) | 1 | `PASS`; the first value is used |
| foreign holder, own ID in a note | 1 | `PASS` (m4) |

The gate logic and the expiry bound are correct. The 3h15m bound fits §2.2 (last checkpoint plus 3 h, plus 15 minutes of slack). The remaining issues are m3 and m4.

## Criterion 4 · Ledger rule 4 (enforcement layer, verification status)

| Place | Result |
|---|---|
| §9 | It names the layer (one hook plus wrapper) and gives a verification status per rule. Overstated: the "Session tools" row (B1); the thread-tool sentence (m1); "reviewed before merge" (m7). |
| §1, §13 | Statuses are accurate except for m6. T-H4 counts are reproduced. T-H5 is reported, not traceable (m8). |
| Appendix M | It names the layer. The "Allowlist hook" row's failure column omits "session started from a revision without `.claude/`" (B1 a), which §9 does list. |
| Plan Section 9 item 1 | **Fixed**: "Tasarım; kısmen gözlendi… T-A2 henüz sınanmadı". |
| Plan Section 9 item 6 | The verification labels are fixed and accurate. The scope is overstated (B1). |
| `plan/Ek_F_Baslangic_Mesaji.md` | **Fixed**: "Tasarıma göre…; bunun bir kısmı gözlendi; gözetimsiz devam henüz sınanıyor (T-A2)". |
| `DURUM.md` | Stamp 21:52 TR = 18:52Z against commit 18:52:12Z: **correct**. Item 2 gives an honest verification status ("çoğu birim testiyle, biri canlı"). But "yeni oturum açmamı … denetliyor" overstates (B1). "Engelin kapsamadığı yollar yazılı" is true only for the routes §9 lists. It does not say the barrier takes effect only once PR #4 is merged into `main`. |

## Criterion 5 · W-C00-05 acceptance change (T-A1c → T-H3, T-H4, T-H5)

- **Legitimate in kind.**
  - T-A1c tested premise BP-04 ("builder-created sessions carry no connectors"). That premise is falsified and withdrawn, so T-A1c cannot be re-passed. Keeping it would make (c) unmeetable, not stricter.
  - The change was recorded in ledger §2 before closure, marked high-impact and sent for review.
  - So it is not the rule-3 pattern of loosening a criterion to fit a result.
- **But the replacement is weaker in evidence level than what it replaces.** T-A1c's acceptance was a live observation **in a builder-created session**. The replacement consists of:
  - T-H3, which observed a *temporary* hook in a builder-created session;
  - T-H4, unit tests;
  - T-H5, one live block of the **session-tool** rule, in the builder's own Batu-started session.

  No test observes the allowlist hook itself blocking anything in a builder-created session. The claim that replaced BP-04 ("connectors are present but blocked there") is therefore composed from two partial observations.
- A live check is possible without calling a connector. In a builder-created full-checkout session, make calls that are harmless if they slip through and assert that they are blocked:
  - a GitHub write to a non-existent repository other than `devos`;
  - `send_message` to a fake ID;
  - `create_session` without `source_url`.
- **T-H1** stays in (c), "counted only for the session it was observed in". Its mechanism (the deny rules) was removed in v1.3, so it no longer tests anything that exists. It should be retired with a reason, like T-A1c, not kept as a pass.
- **Judgement:** acceptable as a replacement only with condition C4 below. As written, it reduces the observation level without saying so.

## Criterion 6 · Public repository safety

- No secrets, tokens, e-mail addresses, library text or transcripts were found in the target diff. I searched for key, token, password, PAT, private-key and address patterns.
- `owned_ids.txt` publishes session, routine and environment IDs. These are not credentials; using them needs the account's own authentication. Earlier records already publish such IDs.
- The M9 redaction is incomplete (B2).
- The builder edited a reviewer's verdict file (`R-C00-BOM-2.md` line 203) to redact it. The edit carries a note, which is acceptable. The branch copy keeps the original.

## Conditions to reach PASS

- **C1:** fix B1 (hook, tests, text) as listed. This is high-impact, so it needs a narrow re-review.
- **C2:** complete the redaction and correct L-018 (B2).
- **C3:** define the lease hand-over (m3).
- **C4:** add one live negative check of the allowlist hook in a builder-created session (criterion 5), and retire T-H1 with a reason.
- m1, m2, m4–m9 may ride along with C1.

## Method

- **Read:** `git diff 33b5043..HEAD`; R-C00-BOM-2; L-017 and L-018; the hook, `settings.json`, `owned_ids.txt` and both scripts; operating model §1, §2, §3, §9, §11–§13, R1, R2 and Appendix M; plan Section 9 items 1 and 6 and line 12; Appendix F line 7; `DURUM.md`; ledger §1 and §2; EV-C00-005; EV-C00-003 G-016; `T-H3.md`.
- **Ran:**
  - the test script;
  - about 40 further hook inputs through the literal `settings.json` command;
  - six wrapper failure cases;
  - 12 mutations of the hook against the test;
  - `builder_check.sh` in a scratch repository (7 cases);
  - `git log` for the first commit with `.claude/settings.json` and the hook, and the content of `origin/main`;
  - commit time against the `DURUM.md` stamp;
  - a tree-wide search for service names and secret patterns;
  - `get_session` on this session only (read-only) to confirm the environment ID and the revision this session was created from.

## Could not check

- **Whether the account's connectors expose MCP resources** (B1 e). Checking would mean calling a resource tool against a connector server, which is forbidden.
- **What `create_trigger` attaches when `connectors` is omitted** (B1 c2). Taken from the tool's description only.
- **Whether `create_session` with `source_revision` set to a revision without `.claude/` really yields a session without the hook.** Inferred from T-H3 (hooks come from the checkout) and the git history; not created.
- **Claude Code hook semantics:** that only exit 2 blocks, whether the matcher is a full or a partial regex match, whether hooks run under `bypassPermissions`, and what happens on a hook timeout (a timeout may not block). These rest on documentation and are unverified here.
- **T-H5** and the builder's own session transcript (m8).
- **Branch protection on `main`** beyond what G-015 records.
