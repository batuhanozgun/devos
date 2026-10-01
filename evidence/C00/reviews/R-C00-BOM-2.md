# R-C00-BOM-2 · Independent re-review: builder operating model (PR #4)

- **Target:** `git diff origin/main...claude/epic-hamilton-9tisc4` (head `33b5043`, base `d97ac8d`), 20 files.
- **Reviewer:** a separate session (`CLAUDE_CODE_REMOTE_SESSION_ID` `cse_01PyDeZF839c2p8XXQnpm5mh`), full checkout of the head `33b5043`. It does not see the producer's conversation. Independence level: same model family, separate session, restricted input (thinking independence only, BP-07).
- **Date:** 2026-10-01 (checks run about 18:40–18:50Z).

## Verdict: **FAIL**

Most of R-C00-BOM-1 is fixed for real. The hook now fails closed on runtime errors, limits GitHub writes to `devos`, and its test catches a broken write-scope check. PC-05 is complete in the Turkish package. The mechanism register exists. BP-04 and T-A1c are honestly withdrawn.

It fails on two points:

1. **B1. The hook leaves an open, unstated route around the connector barrier.** It allows every session tool (`mcp__claude-code-remote__*`) with any input. So the builder can create a session with no checkout or a sparse checkout, which per §9 item 3 runs **without** the barrier and with live connectors. It can also send prompts to connector-bearing sessions or routines it did not create, and attach the library repository with push access. §9 lists "full checkouts" as an observed protection, but it is an instruction only. The residual-risk list does not name this route. This is Batu's question H ("yalnız talimat yeterli değil") again, in a narrower form.
2. **B2. The binding Turkish text still overstates what was observed** (ledger rule 4). Plan Section 9 item 1 marks "Kurucu bir sonraki koşuyu kendisi başlatır; Batu komut yazmaz" as **[Gözlendi]**, while T-A2 is still pending. R-C00-BOM-1 M9 was fixed only in the English §12. Item 6 marks unit-tested hook behaviour as **[Gözlendi]**. `DURUM.md` again carries a time later than its own commit (M6 not fixed).

Public-repository safety passes (criterion 7), with one minor note (M9).

**To reach PASS:**
- Fix B1 in the hook, with tests, or at minimum state the route as a residual risk everywhere the barrier is described. A hook change is high-impact, so it needs a review in any case.
- Fix B2 (text only).
- Address M1–M4.
- A narrow re-review is enough: the hook diff, the test script and the Turkish places in B2.

---

## Criterion 1 · R-C00-BOM-1 findings: is each one actually resolved?

| Finding | Judged on the target | Resolved? |
|---|---|---|
| B1 connector premise, deny list, status claims | BP-04 is withdrawn. T-A1c is FAIL. The deny list is labelled display-name-only. §9 is restricted to sessions with `.claude/`. `DURUM.md` and plan Section 9 item 6 are reworded. T-H3 shows that checkout hooks run in a builder-created session. But fix 3 ("require full checkouts") was done **by instruction only**, and the hook still allows the builder to create sessions without the barrier (new B1). | **Partly** |
| B2 PC-05 incomplete | All five places are fixed: §5.5 İhtiyaç and option (a), §5.6 Seçim, C01 row 11, and Ek A DR12 lines 284 and 288. The scope lists in plan line 12 and ledger §4 now match. See criterion 4 for the residual note on CODEOWNERS. | **Yes** |
| B3 plan 6.12 | Appendix M exists, with problem, compensation, assumption, cost, failure and removal test. But the preamble's "every mechanism is listed" is still not literally true, and 8 rows give "none" as their assumption (M1). | **Mostly** |
| M1 hook fails open | Runtime exceptions, a non-object input and an empty or non-string tool name now exit 2 (re-run). But a **syntax or import error** in the hook still exits 1, and a missing `python3` exits 127. Both fail **open** under the documented hook semantics (M2). | **Partly** |
| M2 allowlist coarse | Fixed: GitHub writes are limited to `batuhanozgun/devos`; `create_repository` and `fork_repository` are blocked. The Supabase "read-only" property is attributed to the database role. The new bypasses are on the session-tool prefix (B1). | **Yes**, for GitHub |
| M3 K-series ambiguity | Clarified in the English model §6. The binding Turkish plan (line 12: "`K` önekli numaralar yalnız Batu'nun kararlarıdır") and ledger rule 5 still state it without the exception. The `K-1`…`K-11` headings and the Ek C `K01`…`K13` IDs stand unexplained in Turkish. | **Partly** (M4) |
| M4 v1.0 ordering | History line and EV-C00-005 T-E1 restate it as the builder's account, 17 s after `73baa5a`. | **Yes** |
| M5 check script | A lease-holder check was added, but it prints `INFO`, not `FAIL`. A run that does not hold the lease still gets `BUILDER_CHECK PASS` (reproduced). The limits are printed and stated in §3.4. But §3.4's "The script checks that the lease names this session" reads as a gate, and it is not one (M3). | **Partly** |
| M6 timestamps | **Not fixed.** `DURUM.md` at `33b5043` says "Son güncelleme: 1 Ekim 2026, 21:55 (Türkiye saati)", which is 18:55Z. The commit is dated 18:41:01Z, 14 minutes earlier. The ledger rows (18:40Z) are fine. | **No** (B2) |
| M7 briefing and issue | (g) and (h) were added to W-C00-05 before results exist. | **Yes** |
| M8 W-C00-05 status | It stays "doing". But see M5 below: condition (c) requires T-A1c to **pass**, and T-A1c is now a recorded FAIL. | **Noted**; new issue M5 |
| M9 continuation untested | Fixed in the English §12. **Not** fixed in plan Section 9 item 1 or in Ek F (B2). | **Partly** |

---

## Blocking findings

### B1 · The session tools are an open route around the connector barrier (criteria 2-H, 5, 6)

- **Where:**
  - `.claude/hooks/tool_allowlist.py` (`ALLOWED_PREFIXES`: `mcp__claude-code-remote__` with no input check);
  - `plan/Builder_Operating_Model.md` §9 (introduction "Only the following is observed", item 3, "Not protected" list) and Appendix M (rows "Allowlist hook" and "Full checkouts");
  - plan Section 9 item 6;
  - `DURUM.md` "En son yapılanlar" item 2.
- **Re-run:** each of these inputs, piped to the hook, exits **0 (allowed)**:

  | Input | What it does |
  |---|---|
  | `create_session` with `{"prompt":"x"}` (no `source_url`) | Child session with no checkout, so no `.claude/` and no hook. It inherits the account connectors (BP-04 withdrawal, T-H3). |
  | `create_session` with `source_url` = the library repo and `sparse_checkout_paths: ["docs"]` | Same, and §9 item 3 itself says a sparse checkout "runs without the barrier" |
  | `add_repo` with `{"owner":"batuhanozgun","repo":"agentic-os-search","access":"push"}` | Attaches the library repo with push credentials. With `git push` this is a library write. §9 names `git push` (OI-001) but not this step. |
  | `send_message` with `{"session_id":"…","message":"…"}` | Sends a prompt to any session of the account, including sessions Batu opened himself with connectors and no hook |
  | `update_trigger` or `fire_trigger` with `{"trigger_id":"trig_…"}` | Rewrites or fires any routine of the account, including Batu's own routines that may store connectors |
  | `create_trigger` with `"connectors":["SomeConnector"]` | Rejected server-side today ("not available for this organization", T-A0), so the hook is the only barrier if that changes |

- **Failure scenario:**
  - The builder starts the dispatcher, a reviewer or a probe with `create_session` and forgets `source_url`. Or, for "input restriction", it uses a sparse checkout, as it did for the counter-design session (FND-002).
  - That session has live mail, calendar and file-storage tools, and nothing but an instruction stops them.
  - `DURUM.md` tells Batu: "Engel, `devos`'un tam kopyasıyla açılan oturumlarda geçerli". That sentence is literally true. But Batu cannot tell that the builder itself decides which sessions get a full checkout, and that the hook does not enforce it.
- **Overstatement:** §9 opens with "Only the following is observed" and lists item 3, "Full checkouts", as a protection. It is a rule that the builder follows, not an observed or enforced barrier (ledger rule 4: name the enforcement layer).
- **Severity:** blocking. This is question H. The fix that R-C00-BOM-1 asked for (full checkouts for every builder-created session) was implemented as an instruction, while the hook could enforce it.
- **Fix:**
  1. In the hook, check `mcp__claude-code-remote__` inputs:
     - allow `create_session` only with `source_url` on `batuhanozgun/devos`, with no `sparse_checkout_paths` and no `environment_id` (Cowork environments carry the account's plugins);
     - allow `add_repo` only for `devos`;
     - block `send_message`, `update_trigger`, `fire_trigger`, `delete_trigger`, `archive_session` and `interrupt_session` unless the target ID is on a builder-owned list in the repository (or block them and add them back one at a time with a reason);
     - block `create_trigger` with a non-empty `connectors`.
  2. Add negative controls for each case to `tools/test_tool_allowlist.sh`, plus a positive control for a legitimate full-checkout `create_session`.
  3. In §9, move "Full checkouts" to "enforced by the hook" once it is, or to "instruction only" until then. Add the session-tool route to "Not protected" until it is closed.
  4. Correct plan Section 9 item 6 and `DURUM.md` item 2 to match.

### B2 · Binding Turkish text and Batu's page still overstate observation status (criterion 5; ledger rule 4)

- **Where and what:**
  1. **Plan Section 9 item 1** (line ~784): "Kurucu bir sonraki koşuyu kendisi başlatır; Batu komut yazmaz **[Gözlendi: T-A1a, T-A1b, 1 Ekim 2026]**".
     - T-A1a observed only that a session the builder created runs under `/goal`.
     - The chain (a run starting its successor) and unattended continuation (T-A2) are not observed.
     - The English §12 was corrected to "designed and partly observed", but the binding Turkish plan was not.
     - **Ek F** line 52 ("Sonraki oturumları kurucu kendisi başlatır; `/goal` yazman gerekmez") states the same as a fact.
  2. **Plan Section 9 item 6**: "…bütün MCP araçlarını engeller; GitHub araçlarıyla yazmayı da yalnız `devos` deposuyla sınırlar **[Gözlendi: T-H2, T-H3, T-H4]**".
     - The allowlist hook blocking an opaque-ID connector, and the GitHub write scope, are **unit-tested** (T-H4, piped JSON).
     - T-H3 observed a *temporary* hook running in a builder-created session.
     - Neither has been observed live for the allowlist hook itself.
     - Label it "birim testiyle sınandı; kancanın bu oturumlarda çalıştığı gözlendi (T-H3)".
  3. **`DURUM.md`** item 2: "Bu düzeltildi ve yeniden sınandı." The same distinction applies. Also, see B1: what holds the barrier in place is partly the builder's own discipline.
  4. **`DURUM.md` timestamp** "21:55 (Türkiye saati)" = 18:55Z, on a commit dated 18:41:01Z. This repeats M6, which L-016 records as fixed ("Stamps corrected. Rule: stamp at writing time").
- **Severity:** blocking under criterion 5. This is the binding text and Batu's page. Two of the four points are fixes that L-016 records as done. Text only.
- **Fix:** relabel items 1 and 6 as "[Tasarım; kısmen gözlendi: T-A1a. T-A2 bekliyor]" and as described above. Soften Ek F line 52 the same way. Restamp `DURUM.md` at writing time. Then correct L-016's dispositions for M6 and M9.

---

## Minor findings

### M1 · The mechanism register is not complete, and "Assumption: none" is often not credible (criterion 3)

- **Where:** the preamble ("Every mechanism is listed in the mechanism register"); Appendix M.
- **Mechanisms of the document with no row:**
  - hand-over at 50% context (S4, §2.1 and §3.4);
  - passing the configured model explicitly (§2.1, BP-05);
  - accepting answers only from `batuhanozgun` (§6; a security mechanism on a public repository);
  - the 24-hour second-channel reminder (§6 "Silence");
  - input restriction of reviewers by instruction (§5);
  - the reviewer-never-delivers replacement after 2 hours, and regenerating the ledger from the log (§11);
  - the squeeze-signal frame review (§10).
- **Rows with "Assumption: none":** ledger split, work list, priority rule, loop limits, overhead check, `DURUM.md`, discipline line, and some cost cells. Each of these rests on something:
  - `DURUM.md` assumes runs actually rewrite it at every checkpoint, which was R-C00-BOM-1's own example;
  - loop limits assume progress can be judged at a checkpoint;
  - the priority rule assumes risk can be ranked before probing.
- **Also:**
  - 6.12 item 1 asks for the "bugün sıfırdan seçseydik" test per premise; §1 has no such column.
  - The deny-rules row's removal test says that removing them changes nothing material. By the register's own rule ("a mechanism whose removal changes nothing is removed"), they should be removed now, not marked "candidate".
- **Fix:** add the rows; replace "none" with the real assumption; add the from-scratch column to §1; remove the deny rules or give a removal test that shows a loss.

### M2 · "Every error path blocks" is still overstated (criterion 6)

- **Where:** hook docstring; §9 item 1; Appendix M "Allowlist hook" row ("Missing `python3` or an edited hook; … fails closed").
- **Re-run:**

  | Case | Exit code | Effect |
  |---|---|---|
  | Hook with a syntax error (one missing colon) | 1 | fails open |
  | Hook with a failing import | 1 | fails open |
  | `python3` missing from `PATH` (shell) | 127 | fails open |
  | Hook file missing | 2 | fails closed by accident, as before |

- An "edited hook", which the register names as a failure, is exactly the case that fails open.
- **Fix:**
  - State the limit: only errors after the script has parsed and imported fail closed.
  - Optionally use a wrapper command that maps any non-zero, non-2 exit to 2, for example `python3 … ; rc=$?; [ $rc -eq 0 ] || exit 2`.
  - Add a syntax-error break test to `tools/test_tool_allowlist.sh`.

### M3 · `builder_check.sh`: the lease check is informational, and an unset variable aborts the script

- **Re-run** in a scratch repository whose `main` has every file and a run lock naming another session, expiring 2099: `INFO run lock does not name this session` and `BUILDER_CHECK PASS`.
- So a run that never took the lease satisfies R1's goal condition. §3.4 says "The script checks that the lease names this session and has not expired", which reads as a gate.
- There is no upper bound on the expiry. A lease of "2099" passes, although §2.2 defines the expiry as the last checkpoint plus 3 hours.
- With `CLAUDE_CODE_REMOTE_SESSION_ID` unset, `set -u` aborts at line 29 with "unbound variable" and exit 1. No `BUILDER_CHECK` line is printed. This fails safe, but the output gives no verdict.
- `bash -n` passes on both scripts.
- **Fix:**
  - Add a mode or flag for runs (for example `BUILDER_RUN=1`) in which a non-holder is `FAIL`.
  - Use `${CLAUDE_CODE_REMOTE_SESSION_ID:-}`.
  - Fail on an expiry more than about 3 hours ahead.
  - Reword §3.4: "reports whether…; fails only for runs".

### M4 · Numbering clarification is missing from the binding Turkish text (question J)

- Plan line 12 and ledger rule 5 say that `K` numbers are only Batu's decisions.
- The exception (capability sections `K-n`, Ek C test IDs `Knn`) exists only in the English model §6.
- **Fix:** add one Turkish sentence to plan line 12, and the exception to ledger rule 5.

### M5 · W-C00-05 condition (c) can no longer be met as written

- (c) requires "tests T-A1a, T-A1b, **T-A1c**, T-H1, T-H2, T-E1 **pass**".
- T-A1c is now a recorded FAIL, and T-H1 passes only in one session.
- Under ledger rule 3, conditions are not loosened, and a loosening voids the result. L-016 does not say how the item can close.
- **Fix:** record now, before closure, that T-A1c's claim was withdrawn (a falsified premise, not a test to re-pass). Record the replacement test (T-H3/T-H4 plus the B1 hook controls) as a high-impact acceptance change, reviewed as §4.3 requires. Do this before W-C00-05 is closed, not at closure.

### M6 · CODEOWNERS could route technical approval back to Batu at C08 (criterion 4, latent)

- §5.6 Seçim keeps "`CODEOWNERS` ile zorunlu inceleme C08'de" for high-impact files, and plan line 566 adds `.github/CODEOWNERS`.
- GitHub does not let a PR's author approve it. Under B3 (a), every system session acts as the machine account.
- The code owner whose approval is required must therefore be another account. In the present setup the only other account is Batu's. Unless this is specified, C08 would quietly make Batu the technical approver again.
- This is not a remaining PC-05 sentence, so criterion 4 otherwise passes.
- **Fix:** name the code owner (for example a separate audit-environment account), or replace the required review with a required status check written by the audit environment.

### M7 · GitHub write scope: over-blocking and edge cases (criterion 6)

All of the following fail **closed**, which is safe but blocks legitimate `devos` work:
- Write tools that carry no `owner`/`repo` are blocked even for `devos`: `resolve_review_thread` and `unresolve_review_thread` take only a `threadId`.
- Owner and repo are compared case-sensitively: `BatuhanOzgun/devos` is blocked.
- Read tools outside the `get_`/`list_`/`search_` prefixes are treated as writes: `actions_get` and `actions_list` on any other repository are blocked.

What the scope does **not** cover, beyond B1:
- `create_or_update_file` and `delete_file` on `devos` paths under `.claude/` are allowed, so the barrier can be removed through the API as well as locally.
- §9 names local editing as a residual risk. But plan 6.1 (line ~573) says "Oturum içinde bu dosyaların düzenlenmesini engelleyen bir kanca da vardır [Öneri]", and the model neither installs that hook nor says why not.
- A hook edit takes effect in the running session within seconds (T-H2 reload observation), so "review before merge" does not protect that session.

**Fix:**
- Allow the thread tools explicitly (they are scoped by the PR they belong to), or document the gap.
- Compare owner and repo in lower case.
- Add `actions_get` and `actions_list` to the read-only set.
- State in §9 why the `.claude/**` edit hook of plan 6.1 is deferred, or add it.

### M8 · The Supabase opaque ID is identified by inference

- §9 and the hook treat `86834617-…` as "the read-only Supabase connector".
- T-H3 lists its tools (`execute_sql`, `list_tables`, …) but not why this server is the `DevOS_Salt-okuma` connector, as opposed to some other Supabase connection.
- The same ID appears in this session's tool list, which supports that it is stable across sessions. The read-only role is a property of the connection, and the hook allows all its tools.
- **Fix:** label the identification as inferred, or record the evidence for it (for example, the connector's configured project).

### M9 · Public safety note: account connector inventory (criterion 7)

- No secrets, no e-mail addresses, no library text and no transcripts were found in the diff (searched for key, token and address patterns).
- However, T-H3 and R-C00-BOM-1 publish the list of third-party services connected to Batu's account (service names redacted by the builder per this finding), with their server IDs.
- This is not a secret, but it is personal account metadata in a public repository.
- **Fix:** optional. Reduce it to "10 account connectors with opaque IDs" plus the one ID the hook needs. Or record that Batu's ledger rule 1 allows it.

### M10 · Non-MCP account surfaces are outside the hook (criterion 6)

- The hook matcher is `mcp__.*`. Tools that are not MCP tools but reach account data or publish are not covered: for example the artifact tools (list and read the person's claude.ai artifacts, publish pages), and push notifications.
- They are not mail, calendar or file connectors, so this is not a breach of §9's stated scope. But "never use account connectors (… files and similar)" in `CLAUDE.md` is broader than the barrier.
- **Fix:** name these in §9 "Not protected", or extend the matcher.

---

## Criteria summary

| Criterion | Result |
|---|---|
| 1. R-C00-BOM-1 fixes | B2, M2, M4 and M7 resolved. B1, B3, M1, M3, M5 and M9 partly resolved. M6 not resolved. See the table above. |
| 2. Expectations 1–5, questions A–J | 1: met (T-E1, and the T-E2 route). 2: met in text (PC-05 complete); M6 is a latent risk. 3: designed, with the issue not yet open (W-C00-05 (h)). 4: met in design (§4.3), and the check script is partly a gate (M3). 5: met (`DURUM.md`), but stamped wrongly (B2). A: answered with limits; Projects was not checked in the account, only deferred to C01 row 14. B–G and I: answered. H: barrier present but bypassable through the session tools (B1). J: complete in English, incomplete in Turkish (M4). Process step 4 (the briefing) is still pending, as (g) records. |
| 3. Plan 6.12 and Appendix M | Substantially present; not every mechanism, and several assumptions are given as "none" (M1) |
| 4. PC-05 | Pass. No remaining place in `DevOS_Kurulum_Plani.md` or `Ek_*.md` gives Batu technical approval. Section 11.2 (lines ~1051–1052) and §5.3's "[Öneri; Batu kabul etti]" for Supabase (line ~471) are historical records. M6 is a latent path at C08. |
| 5. Evidence claims | Overstated: plan Section 9 items 1 and 6, Ek F line 52, `DURUM.md` (B2); §3.4 lease check (M3); "every error path" (M2); "full checkouts" as observed protection (B1). EV-C00-005 rows are accurate. T-H4's counts (13 negative, 7 positive, break test failing on 3) are reproduced. |
| 6. Technical | `tools/test_tool_allowlist.sh`: 20/20 pass; the break test (write-scope check removed) gives `ALLOWLIST_TEST FAIL` with 3 `BAD` lines, reproduced. Inputs that should be blocked and are not: B1. Inputs blocked that should not be: M7. `bash -n` is clean for both scripts; logic issues are in M3. |
| 7. Public safety | Pass, with note M9 |

## Method

- **Read:** the diff; R-C00-BOM-1; L-016 and FND-002; `BATU_ORIGINAL_TR.md`; the operating model in full; the hook; `settings.json`; both scripts; EV-C00-005; the T-H3 report; `DURUM.md`; `plan/ledger.md`; `REVIEW_PROMPT.md`; plan 5.5, 5.6, 6.1, 6.12, Section 9 introduction, C01 table, C08 and 11.2; the diffs of Ek C, E and F.
- **Searched:** `DevOS_Kurulum_Plani.md` and `Ek_*.md` for "onay" and "kabul" (every hit read in context); for `CODEOWNERS` and "kod sahibi"; for any Turkish K-numbering clarification. The diff was searched for secret and address patterns.
- **Ran:**
  - the hook test script, and a break test of it;
  - the hook with about 30 further inputs (B1, M7);
  - syntax-error, import-error, missing-interpreter and missing-file variants of the hook (M2);
  - `builder_check.sh` on the head, and in a scratch repository with a foreign lease and with the session variable unset (M3);
  - git commit times against the stamps in `DURUM.md` and the ledger (B2).

## Could not check

- **Whether the allowlist hook is active in this review session.** This session again lists the account's connector servers under opaque IDs (consistent with BP-04's withdrawal). Testing the hook live would mean calling a connector tool, which is forbidden.
- **Whether `create_session` without `source_url` really yields a session with no checkout.** This is taken from the tool's documentation, not created. The same applies to whether `send_message`, `update_trigger` and `fire_trigger` act on sessions and routines the builder did not create; the tool descriptions say so (same account), but I did not invoke them.
- **Claude Code's exit-code semantics for hooks** (only exit 2 blocks). This rests on documentation, as in R-C00-BOM-1.
- **The builder's own sessions and the probe transcripts** (OI-009). T-H3's live result is taken from its report file.
- **Branch protection on `devos` `main`**, which bears on M7 (direct API writes to `main`).
