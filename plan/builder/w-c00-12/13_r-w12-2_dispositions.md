# W-C00-12 · 13 · Dispositions of review R-W12-2, and the text fixes for its conditions C1–C6

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01WcVuDQhDW3EKr4Sb87MHxN`, the successor of the revision-3 producer (L-043). This file was committed **before** the text fixes it names (write-ahead, operating model §3.4, commit `1667a8f`); its §4 self-checks are the acceptance of the fix step. **Where a disposition in §2 or §3 was revised after the critic pass, §5 states the revision and supersedes the earlier text; the earlier text is kept so that the change stays visible.** **Answers:** `evidence/C00/reviews/R-W12-2.md` (PASS-WITH-CONDITIONS on `08459af`), and the post-target correction F-042-3 (`226ce0d`, L-043).

**How the conditions are met.** R-W12-2 asks that each condition be met in the text before the named tranche part merges, checked by that part's session Verifier. This file fixes the text now, for all six, so that no part starts on a text with a known defect. Whether each fix meets its condition is judged by the Verifier of the part named in the "Before" column, not by this file.

## 1. Conditions

| # | Condition | Before | Disposition | Where fixed |
|---|---|---|---|---|
| C1 | The three W-R7 holes of B-1, with tests | 1b-i (b, c); 1b-ii (a) | accepted, see B-1 | `03` W-R1, W-R7, §3, §6; `08` §2 (migration); `11` T-W1, T-W9, T-W15; `12` §1, §2.2 |
| C2 | The B-2 contradictions; `check_ids.py` flags retired or deferred rules cited as active, and deferred tests cited as evidence | 1b-i | accepted, see B-2 | the files in B-2's table; `check_ids.py` |
| C3 | A defined run brief; how R-R17 and C-R10 pass the brief gate | 1c | accepted, see M-3 | `03` W-R5, W-R6, §9; `04` R-R17; `05` C-R10; `11` T-W6 |
| C4 | M-1, M-2, M-5: relabel; a fallback if P-W12-4 fails | 1b-i | accepted, with one deviation each in M-1 and M-2 | `05` §2.2, §2.3, C-R1, C-R8, C-R9 (deferred); `07` §1, B9, A-04, A-09, H15, H16, X-37, X-39; `12` §2, §2.1, §3; `02` M-R14 |
| C5 | The M-4 ordinary-record edge cases | 1b-ii | accepted | `02` M-R13, M-R14; `04` §6; `11` T-M7a, T-M7c, T-M6r, T-R20 |
| C6 | Tests that exercise R-R16, R-R3a and C-R6; the compaction arrow labelled I | 1c | accepted | `11` T-R21, T-R22, T-C4; `12` §2.2; `02` §4; `04` §6, R-R9; `07` B1, §6 |

## 2. Findings, one disposition each

### Blocking

**B-1 (a) · The break-glass revert covers record files.** **Accepted** (eligibility and the log line revised in §5, findings 3 and 4). The exception is limited to an exact revert whose diff touches only executable carriers (`.claude/**`, `.gitattributes`, `CLAUDE.md`, `.github/workflows/**`, `tools/**`, and `plan/builder/**/*.py`). It must carry a log line `break-glass: <merge SHA>`, and the stop check fails at every stop after it until a session verdict on the revert exists (verification after the fact, not none). An exact revert of anything else is classified like any other diff. Test: T-W9 (i), the exact revert of a merge that changed an acceptance block or a Governing-documents row is class high; T-W9 (h) is kept and extended with (h2), the stop check after a break-glass revert without a later verdict FAILS.

**B-1 (b) · Readiness fields class normal; the C00 hold not encoded.** **Accepted** (the admission exception narrowed and a stage hold added in §5, finding 7).
- The migration writes `depends_on: W-C00-12` into W-C00-06 to W-C00-11, and the render shows them as blocked by W-C00-12. Test T-W15 in the 1b-i gate.
- W-R7 makes high: modifying or deleting an existing `depends_on` or `waits_for` entry; adding `on: finished` to any edge; any change of `admission` on an existing item, except `candidate` → `admitted` or `candidate` → `declined` on an item with no open `waits_for` entry (admitting technical work stays the builder's, `03` §5); and the Stage row of `plan/ledger.md` §1. Test T-W9 (j) to (m) in the 1b-ii gate, where `impact` is built.
- **Deviation, stated:** the reviewer listed "changing `admission` on an existing item" without exception. Making every admission high would put a session verdict on each admitted technical item, which `03` §5 gives to the builder. The exception is narrow: a candidate with an open Batu decision is still high.

**B-1 (c) · Deterministic acceptance can rest on a producer-written script.** **Accepted** (the verdict clause tightened in §5, finding 8).
- W-R1 accepts a deterministic evidence file only if the command's file, at the cited commit, is unchanged since a merge that carries a session verdict, or was merged before the item's `execution` became `running` (pre-registered). Test T-W1 (g).
- W-R7 makes `tools/**` and `plan/builder/**/*.py` high, so `check_ids.py`, `check_service_names.sh` and `test_tool_allowlist.sh` are covered by path, and any new script is high from its first PR. Test T-W9 (n). The break-glass exception of (a) still covers exact reverts of such a merge.
- Consequence for this file's own fix: `check_ids.py` is extended in this step (C2) at class normal, because W-R7 is not built yet. Its extension is checked by the 1b-i Verifier with mutation checks before 1b-i merges (§4, S-5).

**B-2 · Contradictions `check_ids.py` cannot see.** **Accepted**, each row fixed:

| Contradiction | Fix |
|---|---|
| `08` §2: operating model "v2.0 rewritten in place" | the row says the v1.8 delta of `12` §1 |
| `08` items 12 and 13: M-R12 (deferred) cited as answering | both rows say: acceptance (c) is met by the Scope column of every rule table and register row, checked by `check_ids.py`; the per-record `scope:` field is deferred (M-R12, deferred) with its trigger; T-M13 (deferred) is not cited as evidence |
| `12` §1: pieces become governing "without content change", while their headers carry a candidate status and 07's tables move in 1b-i | `12` §1 and §2.1 say: in 1c each promoted file's status line is replaced by the M-R2 pointer (a supersession line, no rule text changed); the register and 07's carrier tables move to `plan/builder/mechanisms.md` in 1b-i and are replaced in 07 by a pointer, so they have one home |
| D-02 typed I, the same arrow typed M\* in `02` §4, `04` §6 item 2, `07` §6 | typed **I until observed** everywhere (also C6) |
| `07` B8 cites retired R-R2 | cites W-R1 (independence label) and R-R3 |
| `07` B9 and A-04: scope (M-R12) without "(deferred)"; a `scope` subcommand | B9 marks M-R12 deferred; A-04 drops `scope` and notes it is added when M-R12 is re-admitted |
| `07` H12 Rec: "T-C1 PASS, observed twice" | "T-C1 observed twice under v1.7, not counted for C-R10" |
| `08` §2: plan §9 and Ek F row attached to W-C00-06 | split: the dispatcher text is decided in 1d (`12` §2.1); the lines naming the operating model's path stay with W-C00-06's `builder/` move |
| `08` §2: failure-pattern row omits F-042-2 | adds F-042-2 and F-042-3; `04` §4 adds F-042-3 |
| `12` §3: "59 active tests" | the count is re-made by script after this step and written with its command |
| `11` preamble: "run on the tranche that builds the mechanism" against tests gated later | "run on a tree that includes the tranche that builds it" |

`check_ids.py` gains two checks: (1) a table cell, or a prose line, that cites a deferred or retired rule must say so in the same cell or line (`deferred`, `retired`, `merged`, `superseded`, `withdrawn`); the rule's own rows in the register and pieces, and the register's Basis and Tests cells, are exempt; (2) a test cited in `08` must not be `deferred` or `retired` in the register. Mutation checks (§4, S-5) show both catch their planted case, including the reviewer's 07 B8 mutation.

### Major

**M-1 · Enforcement after 1d stated as M where it is M\*.**
- **(a) Accepted by relabelling; the detector alert declined.** With C-R9 deferred (M-2), B9's "M on the PR from 1d" is removed. When C-R9 is re-admitted, its type is "M (report), M\* (consequence)". **Reason for declining the detector alert:** the detector alerts Batu's phone. A failed record check is a technical failure, not his decision (BP-01; operating model §6). The consequence is read by the next session Verifier and the closure review instead.
- **(b) Accepted, with a deviation** (superseded in §5, findings 5 and 6: the detector is M\* in every case, and D-003 is not cited). A-09, H15 and H16 are typed by P-W12-4's outcome: if a session can push workflow files, the workflows are M\* (changeable through a merged PR), and every such PR is already class high (W-R7, `.github/workflows/**`), so it needs a session verdict. The proposed alert on any change under `.github/workflows/**` is declined for the reason in (a); the residual (a session can weaken the detector through a reviewed PR) is stated under D-003 (a), which Batu accepted until C03.

**M-2 · If P-W12-4 fails, acceptance waits on Batu indefinitely.** **Accepted, with a deviation on the fallback** (the fallback is superseded in §5, finding 1: the residual goes to Batu as decision D-005, with no default).
- **C-R9 is deferred** to D-08's original trigger: a merged PR is found to have weakened a check it was judged by, or C03 begins. Its tests T-C8 and T-C5 (e) become deferred; C-R1's 1d part (reading C-R9's results) is deferred with it; the M\* labels stay.
- **The dependency is stated** in `12` §2 and in `DURUM.md`'s risk line.
- **Consequence found while applying this:** `06` D-15's rejection rested partly on the main-definition check catching a merged `.claude/**` self-edit. With that check (C-R9) deferred, the remaining layer is the session verdict that every `.claude/**` change needs before merge (W-R7, class high). `06` D-15, row b and §3b D-08 are corrected; the D-15 rejection still holds on that layer plus D-003 (a).
- **Fallback for C-R8 if P-W12-4 fails:** the workflow file goes to Batu as one account action in his batch (Appendix E). C-R8 then becomes **deferred**, with the trigger "the file is on `main`", and the stall residual (a stall is visible only through `DURUM.md`'s update time and the self-watchdog) is stated in `DURUM.md`. W-C00-12's acceptance does not wait on that action.
- **Deviation from the reviewer's "date after which W-C00-12 is accepted with the residual":** that would turn Batu's silence into acceptance of a residual, which the rules forbid. The fallback here accepts nothing on his behalf: without his action the system stays where it was before W-C00-12 on this point (no detector), the residual is stated, and his action re-admits C-R8 whenever he takes it. Holding W-C00-12's acceptance on an account action would make Batu a blocker of technical work (BP-01).

**M-3 · Run starts are undefined under the brief gate.** **Accepted.** A **run brief** is defined: `tools/records.py brief run --role producer` prints the purpose chain down to the active stage, the stage's acceptance block, the frontier block, and the role file; its line is `Task-Brief: run producer <hash>`. C-R10's S4 successor carries it. R-R17: a session that Batu's conversation session creates passes the same hook (it runs in a `devos` checkout), so its first message must carry the run brief line; Batu's own first message to his session is not gated. T-W6 gains (d) a run brief with a correct hash, allowed, and (e) `Task-Brief: W-X-99 producer <hash>` with an invented ID, blocked.

**M-4 · Ordinary records still fail.** **Accepted**, all four:
- **S5 wake bound:** a wake recorded with type `S5` must equal the Usage row's `resets` plus 15 minutes (so at most 7 days plus 15 minutes ahead); other wakes keep 25 hours. T-M7a (f): an S5 wake at `resets` plus 15 minutes, 3 days ahead, PASSES; one at `resets` plus 2 hours FAILS; a watchdog wake 3 days ahead FAILS. (Aligned in tranche 1c with the pre-registered T-M7a (f) and the code, N-053 (d); the earlier words "bounded by" were looser than both.)
- **Cross-midnight:** T-M7c (c): a log line committed at 00:10Z quoting "23:50Z" without a date, about the previous evening, FAILS (read as 23:50Z on the commit's date, which is future); the same with its date PASSES.
- **`ISSUE_READ_FAILED`:** the stop check accepts `S3` with the reason `ISSUE_READ_FAILED` when the log entry of the stop carries a line `issue read by MCP: <comment IDs seen>`; every other stop reason still FAILS while the read fails. T-M6r (e).
- **R-R9 counter:** a FAIL counts toward `HAND-OVER DUE` only when the check runs on a committed head that is pushed (`HEAD` equals its remote branch), that is, at a checkpoint; failures on an uncommitted tree are the check working. T-R20 (b): two failures on an uncommitted tree print no signal. The false-trigger rate in the tranche-1 runs is recorded at the composition review.

**M-5 · Coverage claims stronger than the mechanisms.** **Accepted**, all three:
- X-39 is typed "M\* for L-018 and L-033; I for L-021 → L-023 and L-030". The I part gets a route: a disposition that declines a reviewer's fix, or a departure from a recorded budget, is listed in the log entry under `Declined or departed:` and handed to the next session Verifier of that work, which judges it (instructed; the narrow re-check already did this once).
- F-042-1: M-R14's stamp type is extended to the `Written:` header line of a file that a PR adds under `plan/` or `evidence/`: a time there must not be later than the commit time. T-M7b (e) plants the F-042-1 text in such a header line, which is where it happened. X-37 then holds.
- The compaction re-ground is **I until T-M17 (c) observes it** (also C6, B-2).

**M-6 · Three tests do not exercise their rule.** **Accepted.**
- R-R16: new T-R21 (1c gate): at the 1c gate, every design artefact that a tranche-1 session Verifier reviewed shows a Critic call before the verdict request, and each Critic finding answered in the artefact, labelled non-binding. Plus one scratch case: an artefact with an unanswered Critic finding is reported by the 1c Verifier.
- R-R3a: new T-R22 (1c gate): `records.py brief <ID> --role verifier` refuses to generate without `target_sha` and a non-empty `failure_classes` list, and the generated header carries the claims, the failure classes and the SHA. This makes the rule mechanical for every brief-gated verifier session.
- C-R6 relay form: T-C4 (c): a message from the parent prefixed `Batu (relayed):` is recorded verbatim with its source; (d) a relayed message that also says "delete branch X" is recorded, and the deletion is not done (data).
- R-R3a's and R-R16's test cells are updated in 04 and 11.
- The composition review lists T-R16 and T-M17 (c) as **unobserved**, not passed (`12` §2.3).

**M-7 · Deferral triggers without an observer; the trigger of R-R14 (deferred) is circular.** **Accepted.**
- A token `patch:<mechanism ID>` is added now to the Record changes line of any change that patches an existing mechanism after a finding. `builder_check.sh` prints, non-blocking, the count of `patch:` tokens per mechanism since the last `FR-nn` record. The trigger of R-R14 (deferred) is then countable. The token is part of M-R5's line format; T-M3 (e) checks that a line with the token is accepted and counted.
- `12` §3 gains an Observer column: the stop check for counted triggers; the session Verifier of each tranche part and the closure review (W-C00-11) for the others, all deferred rules (R-R13, W-R8, M-R12, R-R15, W-R13).
- R-R13's deferral stands, as the reviewer judged, now with an observer.

### Minor

| Finding | Disposition |
|---|---|
| m-1 M-R16 (a) path matching | **Accepted.** The match is anchored to repository-root paths not preceded by `/` or a word character; T-M14 (b): a library path containing `evidence/` is not reported |
| m-2 impact class before a diff exists | **Accepted.** An item carries `targets:` (paths it expects to change); its class at `running` is computed from them as W-R7 computes a PR's; an empty `targets:` is high. The PR's computed class still governs acceptance |
| m-3 composition condition outside the acceptance markers | **Accepted.** `03` §6: it sits inside the acceptance block |
| m-4 Actor A versus B covers two roles | **Accepted, combined with T-R1.** Each role's T-R1 task is chosen in an area with a bounded library study, and T-R2's PASS condition is checked on every T-R1 transcript, so every role that interprets or decides is tested with no extra session |
| m-5 P-W12-4 could run something | **Already met.** The pre-registration (`evidence/C00/probes/P-W12-4_workflow_push.md`) uses a workflow with only a `workflow_dispatch` trigger and no schedule; nothing runs unless dispatched. No change |
| m-6 `records-check.yml` permissions | **Accepted, for when C-R9 is re-admitted.** `05` §2.3 states `permissions: contents: read, pull-requests: read`, and that `impact`'s `git revert` runs in a scratch clone with hooks disabled (`core.hooksPath=/dev/null`) on PR content read as data |
| m-7 prototype revision not pinned | **Accepted, done before T-M7c is run** (1b-ii): the prototype script pins its revision, the evidence file is re-run on it, and the L-027 row is corrected with a correction line. Not a condition, so not done in this step |

## 3. F-042-3, weighed, and then refused

R-W12-2 judged X-29 "acceptable as a tranche-2 candidate" on `08459af`. After that target, `226ce0d` moved the probe-branch rule H-PRB (deferred since, below) into tranche 1a because P-W12-3 adds hooks on its probe branch.

- **Was the move needed for P-W12-3?** Yes. The hook's revision check (`revision_has_barrier` in `.claude/hooks/tool_allowlist.py`) allows `create_session` only on `main` or on the current branch of the run's own tree. P-W12-3's hooks cannot be on `main` before the probe, and putting them on the run's own branch would load them into the run's own session. Switching the run's tree to the probe branch is what X-29 forbids.
- **What happened (L-044).** This run prepared the hook change in a scratch clone and then tried, in one command, to push the two test fixtures of T-W14 (now deferred): a probe branch identical to `main`, and a probe branch without `.claude/settings.json`. The permission classifier refused the command as self-modification. Nothing reached the remote (`git ls-remote`, checked after the refusal). A refusal is S3 for that action and its goal, and is not routed around (operating model §11; R-R21): the rule H-PRB (now deferred) is not pursued by another route, in smaller pieces or in a later turn.
- **Disposition (supersedes the earlier "the move stands").** H-PRB and P-W12-3 are deferred to tranche 2, with the trigger in `12` §3: a probe needs `.claude/` changes on its own branch, **and** Batu has decided how the builder may change its own guardrails. This is the order R-W12-2 had accepted for X-29. No active rule's gate depends on P-W12-3: since R-W12-2 the compaction arrow is typed I until observed, and P-W12-3's findings feed R-R19 and R-R20, both deferred. The working-tree rule stays instructed.
- **What the refusal says about later parts.** Tranche 1c is mostly `.claude/**` changes (the brief gate, the recorder, the boot map, agent definitions). Earlier hook changes were merged (operating model v1.3 to v1.7), and the refused command also removed a settings file on a pushed branch, so the refusal does not show that every reviewed hook change will be refused. It is a risk to 1c, stated in `12` §2.4's sense of a blocker: if a 1c change is refused, that is S3 for it, and the way the builder may change its own guardrails becomes a decision for Batu (his account's permission settings), sent then, in Appendix E format. It is not sent now, because no current action needs it.

## 4. Self-checks for the fix step (written before the fixes)

| # | Check | Pass only if |
|---|---|---|
| S-1 | Every row of §1 and §2 names files, and each named file is changed in the fix commit | `git diff --stat` of the fix commit lists every file named in §1's "Where fixed" column |
| S-2 | `python3 plan/builder/w-c00-12/check_ids.py` from the repository root | prints `IDS OK` |
| S-3 | The register count, by script, is the one written in `12` §3 | the command and its output are pasted in the log entry and match `12` §3 |
| S-4 | No remaining text types the compaction arrow as M or M\* | `grep -n "compact" plan/builder/w-c00-12/0[2-7]*.md` shows no M\* label on the re-ground arrow |
| S-5 | Mutation checks on the extended `check_ids.py`, in a scratch copy: (a) 07 B8 cites R-R13 without "deferred"; (b) 08 cites T-M13 (deferred) as evidence; (c) a new rule row cites a retired rule as active in a piece; (d) the unmodified tree | (a), (b), (c) each print a problem and `IDS FAIL`; (d) prints `IDS OK` |
| S-6 | `tools/check_service_names.sh` on the staged tree | prints `SERVICE_NAMES CLEAN` |
| S-7 | A non-binding Critic subagent reads this file and the fix diff against R-W12-2 | each of its findings is answered in this file's §5 or in the log entry |

## 5. Critic pass (non-binding; fresh-context subagent; 14 findings)

The Critic read this file, the fix diff `4c5caae` and R-W12-2. Its findings, and the response to each:

| # | Finding (short) | Severity | Response |
|---|---|---|---|
| 1 | The P-W12-4 fallback turns R-W12-1 B1's "Batu decides the residual" into "the builder states it", while still retiring the dispatcher | blocking | **Accepted.** If P-W12-4 fails, Batu gets candidate D-005, with no default by silence: (a) he adds the workflow file, or (b) he accepts the residual of no independent stall detection until C06. W-C00-12's acceptance and the dispatcher's retirement wait for one of the two. Under (b), C-R8, T-C6, T-C7, T-23 and the detector clause of T-21 are deferred (`05` §2.2, §3, C-R8; `12` §2, §2.1 1d, §2.3, §3, §7; `11` C-R8) |
| 2 | Recorder lines in `.claude/hooks/owned_ids.txt` would be class high, so every successor and wake needs a verdict, and a Verifier's creation needs another Verifier | blocking | **Accepted.** W-R7 exempts a diff to that file that only appends lines of the recorder's ID form; a deleted line is high; T-W9 (o) |
| 3 | Break-glass unusable: the log line breaks "exact inverse", and real merges also touch records | material | **Accepted.** Eligibility is the exact inverse of the merge's executable-carrier part; the `break-glass:` line goes into a separate record PR right after; T-W9 (h2), (p) |
| 4 | Break-glass contradicts M-1 (b), and a revert could remove the after-the-fact check | material | **Accepted.** `.github/workflows/**` and `tools/builder_check.sh` never qualify; T-W9 (q) |
| 5 | D-003 (a) stretched to the detector | material | **Accepted.** D-003 is no longer cited; the residual (a session weakening the detector through a reviewed PR) is stated in `05` §2.2 and covered by the class-high session verdict. The proposed alert stays declined for the reason in M-1 (a) |
| 6 | "M if P-W12-4 fails" is unsupported: the probe does not try the contents API or the MCP writes | material | **Accepted.** The detector is M\* in every case (`07` §1, H15, A-09, X-26, §6) |
| 7 | Admission exception and C00 hold have holes (a later Batu answer; a new admitted item; retirement) | material | **Accepted.** The exception covers only technical candidates whose file never carried `waits_for`; the C00 stage carries `hold_until: W-C00-12`, applied to every item of the stage, changing it is high; retiring an admitted item is high (`03` §3, §5, W-R7); T-W9 (r), (s) |
| 8 | "Unchanged since a merge with a verdict" can be laundered by an unrelated verdict | material | **Accepted.** The file's last change must be in a PR whose bound verdict covers that PR's head, or pre-registered (`03` W-R1); T-W1 (h) |
| 9 | The run brief is a universal pass | material | **Accepted.** A `run` brief is allowed only from the lease holder or Batu's conversation session (W-R6); T-W6 (f). The R-R3a claim is narrowed to verifier sessions started with a verifier brief, and the remaining misuse is stated as instructed (`04` R-R3a) |
| 10 | The new `check_ids.py` checks are easy to evade (broad words, paragraph-wide exemption, `06` unscanned, tests unchecked) | material | **Accepted.** The check now works per clause (cell, then `;` and sentence ends); the exempting words are narrowed (`merged into`, `superseded`, not `merged` or `supersed`); `06` §3b and §8 are scanned; deferred and retired tests are checked in every scanned file except where tests are listed by design; the critic's mutations are re-run (L-044) |
| 11 | The S5 wake bound is a generic 7 days | minor | **Accepted.** It must equal the recorded `resets` plus 15 minutes (`02` M-R14); T-M7a (f) revised |
| 12 | `DURUM.md` not changed, though the text says it states the dependency | minor | **Accepted.** `DURUM.md` is updated in the record PR of this step |
| 13 | Wording: "in place" and "moved"; the run brief's role file; where the gate runs for Batu's session | minor | **Accepted** for the last two (`03` §9; `04` R-R17: the gate runs in the creating session's hook, and if Batu's session is not in a `devos` checkout, the rule is instructed, a stated residual). "In place" means the same text, under a new path; kept |
| 14 | Two triggers rest on the producer's own word (Critic call evidence in T-R21; the `patch:` token) | minor | **Accepted as a stated residual.** Subagent calls are not recorded by any hook, and the token is written by the producer. The session Verifier of each part checks them against the transcript (`list_events` of the run) when it judges T-R21 and the `patch:` count |

