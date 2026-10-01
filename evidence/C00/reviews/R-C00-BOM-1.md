# R-C00-BOM-1 · Independent review: builder operating model (PR #4)

- **Target:** `git diff origin/main...claude/epic-hamilton-9tisc4` (head `3cd686a`, base `d97ac8d`), 17 files.
- **Reviewer:** a separate session, `session_0139FAmiXGW3U6rGKKbmgNYy`, created by the builder session (`parent_session_id` = `session_016Hi3ZYgAf2amYNGc43a3tr`, origin `claude_code_mcp_seed`). It does not see the producer's conversation. Independence level: same model family, separate session, restricted input (thinking independence only, BP-07).
- **Date:** 2026-10-01

## Verdict: **FAIL**

The design is mostly sound, and most of Batu's expectations have a real mechanism behind them. It fails on three points:

1. **A central security premise is contradicted by observation.** BP-04 says sessions created by the builder with `create_session` carry no account connectors. This review session was created that way, and it carries them (see B1). `DURUM.md` and plan Section 9 item 6 tell Batu that the connectors are blocked and that this was observed. That is stronger than the evidence supports.
2. **PC-05 is incomplete.** Several places in the Turkish plan package still route technical approval of high-impact changes to Batu (B2). Batu explicitly asked for "the plan's clause on this" to be changed. L-015 claims that §5.6 was changed, but §5.6's "Seçim" line still names Batu's approval.
3. **Criterion 3 (plan 6.12) is overstated.** The document says every mechanism names its problem, assumption, cost and failure mode. Only §2 does this in full (B3).

Nothing in the target is a public-repository safety problem (criterion 6 passes). The tools mostly work as described (criterion 7), with the limits listed below.

**To reach PASS:** fix B1 to B3 and the claims in M1 and M2, then have a fresh reviewer re-check §9, EV-C00-005, `DURUM.md` and the PC-05 places. All of these are high-impact text (§5).

---

## Blocking findings

### B1 · The connector barrier's structural layer is falsified, and the status claims are overstated (criteria 1-H, 5, 7)

- **Where:**
  - `plan/Builder_Operating_Model.md` §1 BP-04 and §9 layer 1;
  - §13 T-A1c and EV-C00-005 T-A1c;
  - `DURUM.md` ("En son yapılanlar" item 2);
  - plan Section 9 introduction, item 6 ("**[Gözlendi: 1 Ekim 2026]**");
  - L-015 "What was done" item 1 ("Builder-created and routine sessions carry no account connectors").
- **Observation (this session, 2026-10-01 ~18:32Z):**
  - `get_session` shows that this session was created by `session_016Hi3ZYgAf2amYNGc43a3tr` through the session tool.
  - Its tool list includes the account's connector servers: mail, calendar, file storage and several further third-party services, plus Supabase and one more that needs authentication. [Service names redacted by the builder on 2026-10-01 (R-C00-BOM-2 M9): personal account metadata; the rest of this review is unchanged.]
  - Five of these servers were still "connecting" at session start and appeared only later. A self-report taken early in a session (as in T-A1c) can therefore miss them.
- **Second problem, with the deny list (T-H1, layer 2a).** In this session the connector servers are named by opaque IDs (for example `mcp__9c01eb9f-…__send_message` for Gmail), not by display names. The deny rules in `.claude/settings.json` use display names (`mcp__Gmail`, `mcp__Google_Drive`, …), so they cannot match these tools. The denied tools are in fact still listed in this session, although the settings file is present in the checkout. T-H1's PASS therefore holds at most for the session where it was observed. It is not a general property.
- **What remains:** only layer 2b, the allowlist hook. It blocks every `mcp__<id>__…` name (unit-checked below). Whether it is active in this session was **not** checked, because that would mean calling a connector tool.
- **Failure scenario:**
  - A reviewer started from a sparse checkout (as the counter-design session was), or any session started on `main` before this PR merges, has no `.claude/settings.json` at all. `main` does not contain it today.
  - Such a session carries live mail, calendar and Drive tools, and nothing blocks them except an instruction.
  - Batu has been told in `DURUM.md` that they are technically blocked.
- **Severity:** blocking. This is Batu's question H, and a false security statement on his status page.
- **Fix:**
  1. Withdraw BP-04 and mark T-A1c FAIL, citing this observation.
  2. Restate §9 as "one harness layer (the allowlist hook), effective only in sessions whose working tree contains `.claude/` at a revision that includes it".
  3. Require full checkouts (or include `.claude/` in every sparse checkout) for every session the builder creates.
  4. Re-test the hook in a builder-created session with an opaque-ID server, using a harmless method: a temporary hook that also blocks `mcp__github__get_me` proves the hook runs in that session, as in T-H2(b).
  5. Label the deny list as display-name-dependent, or drop it, and correct `DURUM.md` and plan Section 9 item 6.

### B2 · PC-05 leaves Batu's technical approval in place in several places (criterion 4)

Places in the Turkish package that still require Batu's approval or acceptance of a technical, high-impact change:

| Location | Text | Problem |
|---|---|---|
| `DevOS_Kurulum_Plani.md` §5.6 "Seçim" (line ~513) | "yüksek etkili dosyalarda Batu'nun onayı (B3'e göre GitHub onayı ya da karar paneli)" | The "İhtiyaç" line of the same section was changed, but this line was not. L-015 lists §5.6 as done. |
| §5.5 "İhtiyaç" (line ~495) | "yüksek etkili değişikliklerin Batu'nun onayı olmadan ana ürüne girmemesi" | Contradicts PC-05 |
| §5.5 option (a) rationale (line ~501) | "Batu telefondaki GitHub uygulamasından onaylar" | Historical rationale for B3; mark it as superseded or reword it |
| C01 table, row 11 (line ~848) | "Batu'nun onayı GitHub'da alınabiliyor" | A platform test built on the old approval path |
| `Ek_A_Rol_Sozlesmeleri.md` DR12 (lines ~284, ~288) | "Tüketici: … Batu (yüksek etkili değişiklik onayı)"; "Ortam: … kabul Batu" | Control changes are rule and security changes, exactly the class that PC-05 moves to independent review |

The PC-05 scope list in `plan/ledger.md` §4 and L-015 item 5 omits §5.5, C01 row 11 and Ek A DR12.

- **Severity:** blocking. Batu's expectation 2 says explicitly "Planın bu konudaki maddesini buna göre değiştir", and the ledger record overstates what was changed.
- **Fix:** edit the five places. Where approval of a decision that is Batu's own (scope, cost, accounts) remains legitimate, say so explicitly. Correct the PC-05 scope lists. Re-run a search like the one in "Method" below.

### B3 · Plan 6.12 is claimed for every mechanism but not met (criterion 3)

- **Where:** the operating model's preamble ("Every mechanism names the problem it solves, the assumption it rests on, its cost and how it fails"), and §§3–10.
- **Problem:**
  - Only §2 (runs, lease, dispatcher) states its problem, assumptions, cost and failure modes explicitly.
  - The following mechanisms state no assumption, no cost and no failure mode of their own: the boot order (§3.1), record vs. change PRs (§3.2), the write-ahead (§3.4), loop limits and the overhead check (§4.4, §4.5), the review prompt and the second-reviewer rule (§5), the issue channel and batching (§6), the status page (§7), the usage policy (§8) and the discipline table (§10).
  - Some of these rely on premises in §1 (BP-07, BP-08, BP-09), but the link is not made.
  - 6.12 item 4 (what each mechanism compensates for that the model cannot do alone, and the removal test) is applied nowhere.
- **Concrete example:** §7 assumes that runs actually rewrite `DURUM.md` at every checkpoint. The only check is `builder_check.sh`'s commit-time comparison, which does not detect a stale page if neither file changes (see M5).
- **Severity:** blocking for criterion 3, because Batu set this rule explicitly. The fix is text only.
- **Fix:** for each section, add a compact row: problem, assumption (with premise ID), cost, how it fails, and what removing it would make worse. Or soften the preamble to what is true, and list the mechanisms that still lack it.

---

## Minor findings

### M1 · The hook "fails closed" only by accident (criteria 5, 7)

- **Where:** §9 ("a broken hook fails closed"); EV-C00-005 T-H2 note.
- **Re-run (piping JSON to `.claude/hooks/tool_allowlist.py`):**

  | Input | Exit code |
  |---|---|
  | Opaque-ID Gmail tool, `mcp__Gmail__send`, `mcp__github_evil__x`, `mcp__githubX`, unknown Supabase ID | 2 (block) |
  | `mcp__github__merge_pull_request`, `mcp__github__create_repository`, `mcp__claude-code-remote__create_trigger`, `mcp__Supabase_DevOS_Salt-okuma__execute_sql`, `Bash`, `Read` | 0 (allow) |
  | Non-JSON input | 2 |
  | Valid JSON that is not an object (`[]`, `"x"`) | **1**, with a traceback |
  | `{}` and `{"tool_name": null}` | **0** |

- **Why it matters:** Claude Code treats only exit code 2 as "block". This is the documented hook semantics, not re-observed here. So:
  - an exception in the script, a missing `python3` (exit 127) or a future bug **fails open**;
  - a missing script fails closed only because Python happens to exit 2 for "can't open file".
- **Severity:** minor today, because the harness sends an object with `tool_name`. But the claim is overstated.
- **Fix:** wrap `main()` in a catch-all that returns 2. Treat an empty or non-string `tool_name` as a block. State the dependency on `python3`.

### M2 · The allowlist is coarser, and more name-dependent, than §9 says (criteria 5, 7)

- §9 says the hook allows "the read-only Supabase tools". It allows every tool of that server prefix, including `execute_sql` and any future write tool. "Read-only" comes from the database role. EV-C00-002 row 7 records that as observed; §9 should cite it.
- In this session the Supabase server has an opaque ID, so the hook would block it. That fails closed, but the builder would lose Supabase access in such sessions. The server-name dependency is unstated.
- `mcp__github__` allows all GitHub tools on all repositories reachable by the system account. That includes `create_repository`, `fork_repository`, `delete_file` and writes to the library repository. The last one is acknowledged as a residual risk; the others should be listed too.

### M3 · Numbering (question J) is not fully separated

- Plan §9 and ledger rule 5 say that "`K` önekli numaralar yalnız Batu'nun kararlarıdır".
- But the plan still has capability headings `K-10` and `K-11` (Section 4), and Appendix C has test IDs `K10` and `K11`. These are the very names that PC-01 and PC-02 used to carry.
- The operating model itself cites "plan K-10" (§4.5) and "plan 4 K-11" (ledger PC-05).
- **Fix:** state that `K-n` (with hyphen) are capability sections and that Appendix C `K`-series are test IDs, not decisions. Or rename them.

### M4 · "v1.0 fixed before reading the counter-design" is not shown by git order

- The counter-design commit `73baa5a` is dated 18:23:18Z, and the v1.0 commit `a58413a` is dated 18:23:35Z, 17 seconds **later**.
- The SHA-256 in the history line matches `a58413a` (re-computed: `e37de022…afb4`).
- So the claim rests on the builder's word, not on git order. The counter-design existed on the remote before v1.0 was committed.
- **Fix:** state it as "committed 17 s after the counter-design was pushed; not read before, by the builder's account". Or label it unverified.

### M5 · `tools/builder_check.sh` proves less than §3.4 implies

- **Re-run on the PR head:** `BUILDER_CHECK FAIL`, exit 1 (3 commits ahead; `DURUM.md`, the model and `CLAUDE.md` missing on `main`; run lock row missing). This is correct before the merge. On `main` the script does not exist yet (exit 127).
- **Limits:**
  - It passes for a run that did nothing.
  - The `DURUM.md` check compares last-commit times only. Freshness relative to the work done, and the page's content, are not checked.
  - It does not check that the run lock names the current session or was renewed.
  - If `git fetch` fails, the script continues against a stale `origin/main`. This is flagged as FAIL, which is acceptable.
- The R1 goal still relies on the run's unverified naming of the stop condition and evidence IDs.
- **Fix:** add a lease-holder check (the run lock equals the current session ID, and the expiry is in the future). State in §3.4 what the script does not prove.

### M6 · Timestamps later than the commit that carries them

- `3cd686a` was committed at 18:30:52Z.
- Its `DURUM.md` says "21:45 (Türkiye saati)", which is 18:45Z, and the ledger state rows say "as of 18:40Z".
- **Fix:** stamp records with the time they were actually written.

### M7 · W-C00-05's acceptance condition misses parts of Batu's process (criteria 1, 2)

- Process step 4 is not in the acceptance condition: a single, short Turkish briefing to Batu that says what changes for him and which decisions he must take (D-002).
- The "Batu'dan beklenenler" issue is the only mechanism for expectation 3, and it does not exist yet (T-D1 pending). It is also not in condition (c).
- **Fix:** add both to W-C00-05 (or a following item) before results are seen, per ledger rule 3. Note that loosening is not involved, only additions.

### M8 · Status of W-C00-05 (criterion 2), for the record

- (a) and (b) are met.
- (c) is not yet met: T-B1, T-A2 and T-E2 are pending. T-A1c must now be recorded as FAIL (B1).
- (d) is this review.
- (e) is not merged.
- (f) is done, but incomplete per B2.
- None of this is a defect of the PR itself, but the item cannot close on the current evidence.

### M9 · Question A, usage-limit continuation and the dispatcher's life are untested

- The answer to "can work continue by itself when the usage limit is reached?" rests on `send_later` into a long-lived dispatcher session.
- Untested points:
  - whether a reclaimed container or a paused sandbox resumes on such a message;
  - whether a recurring routine bound with `persistent_session_id` counts against the 15 runs per day.
- The document labels the first as documented and the second as unknown, which is fair. Until T-A2 passes, §12's "He types no commands" is a design statement, not an observed one. `DURUM.md` should not imply otherwise.

---

## Criteria summary

| Criterion | Result |
|---|---|
| 1. Expectations 1–5, questions A–J, process | 1, 4 and 5: mechanisms present. 2: incomplete (B2). 3: designed, not installed (M7). A–J are answered with rationale, cost and limits, except that H rests on a falsified premise (B1) and J is incomplete (M3). Process step 2 (counter-design) is done. Steps 3 and 4 are partly done (pending tests; briefing not yet given). |
| 2. W-C00-05 acceptance | Not yet met (M8) |
| 3. Plan 6.12 | Not met as claimed (B3). The design is not needlessly complex: each added part (dispatcher, lease, digest) is justified by an observed limit. |
| 4. PC-05 | Incomplete (B2) |
| 5. Evidence claims | Overstated: T-A1c and BP-04, T-H1 generality, "fails closed", "read-only Supabase tools", v1.0 ordering, the `DURUM.md` security line (B1, M1, M2, M4) |
| 6. Public repository safety | Pass. No key or token values, no e-mail addresses, no library text. Session and trigger IDs are identifiers. The only verbatim text is Batu's own instruction (allowed by ledger rule 1). Log entries L-001 to L-014 were moved to `plan/ledger/C00-log.md` unchanged (compared entry by entry; only the section separators differ). |
| 7. Technical soundness | The hook works for the listed cases but fails open on exceptions (M1). The script is correct for what it checks (M5). |

## Method

- Read: the diff; `BATU_ORIGINAL_TR.md`; `BRIEF.md`; the operating model; `plan/ledger.md`; `plan/ledger/C00-log.md` (L-015, and the move check); EV-C00-005; `DURUM.md`; `CLAUDE.md`; `REVIEW_PROMPT.md`; plan §5.5, §5.6, §6.12 and the PC-05 places.
- Searched: the Turkish plan package (`DevOS_Kurulum_Plani.md`, `Ek_A` to `Ek_G`) for Batu together with onay or kabul. EV-C00-002 was searched only for the Supabase read-only claim.
- Ran: the hook with 17 inputs; `builder_check.sh` on the PR head and on `main`; `get_session` on this session; git timestamps and the SHA-256 of `a58413a`.

## Could not check

- Whether the allowlist hook is actually active in this session, or in the builder's. Testing it would require calling a connector tool, which is forbidden.
- T-H1 and T-A1a/b/c in the builder's own session. Only the builder's records describe them, and I did not read those transcripts.
- Live behaviour of the dispatcher, the heartbeat routine and `send_later`; whether Batu receives notifications (T-D1).
- The counter-design file itself (not in the read list). §14's account of its content is taken as stated.
- Whether Claude Code exit-code semantics for hooks are exactly as documented in this harness version. M1 relies on the documented rule: only exit code 2 blocks.
