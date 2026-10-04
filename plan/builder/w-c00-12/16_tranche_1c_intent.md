# W-C00-12 · 16 · Tranche 1c: intent, order of work and acceptance checks (write-ahead)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_011NtZnNGjojkTcmuzMRLtvL`, before any 1c file is built (write-ahead, operating model §3.4). **Governs nothing by itself:** the contents of 1c are fixed by `12_tranche_plan.md` §2.1 (row 1c) and §2.2 (gate 1c); the rules by `02_memory.md`, `03_work_model.md`, `04_roles.md`, `05_continuity.md` and the register (`plan/builder/mechanisms.md`); the conditions by C3 and C6 of `13_r-w12-2_dispositions.md` §1; the carried items by notes N-047, N-048, N-052 and N-053 on `plan/work/W-C00-12.4.md`. This file states only how 1c is built and checked, so that the session Verifier can compare the result with an intent written before it. Where this file and a rule disagree, the rule wins, and the disagreement is a finding.

## 1. What 1c builds (from 12 §2.1 row 1c; nothing added except where §2 or §7 says so)

| # | Piece | Rule | Carrier | Gate tests |
|---|---|---|---|---|
| 1 | `.gitattributes`: `.claude/hooks/owned_ids.txt merge=union` | M-R10 | `.gitattributes` | T-M8 |
| 2 | The recorder also records `send_later` (matcher and parser), from the response shape sampled in 1a | M-R11 | `.claude/settings.json`, `.claude/hooks/record_owned_id.py` | T-M12, T-H4 |
| 3 | The brief gate on `create_session` (hook rule H-BRF) | W-R6 | `.claude/hooks/tool_allowlist.py` | T-W6, T-H4 |
| 4 | The `SessionStart` boot map: `tools/boot_map` and the one home table it prints, `plan/builder/MEMORY_MAP.md` | M-R18 | `.claude/settings.json`, `tools/boot_map` | T-M17 |
| 5 | `CLAUDE.md`: the floor import (`@plan/Ek_A_Rol_Sozlesmeleri.md`, `@plan/Ek_D_Dusunme_Protokolleri.md`) and the map pointer; the import's token cost measured with its method | R-R6 | `CLAUDE.md` | T-R5 |
| 6 | Role definitions: `.claude/agents/{verifier,triager,researcher,critic}.md`; `plan/builder/roles/{counter-designer,probe}.md`; `plan/builder/REVIEW_PROMPT.md` extended (claims, failure classes, exact SHA; review, verification and challenge kept apart) | R-R3a, R-R4, R-R16 | the files named | T-R1, T-R2, T-R3, T-R21, T-R22 |
| 7 | `plan/builder/heritage/FAILURE_PATTERNS.md` (RUN_BRIEF §5's ten patterns plus the F-entries named in `04_roles.md` §4, each with lens, question, sources, `status: candidate`, `qualified_by`), and a check that `qualified_by` never equals the entry's producer | R-R7 | the file; `tools/check_records.py` | T-R12 |
| 8 | Operating model v1.8 as a **delta** (12 §1): header pointer (M-R2), supersession table per v1.7 section, and R-R4, R-R8, R-R9, R-R16, R-R17, R-R21, C-R2, C-R3, C-R5, C-R6, C-R10 written into it; pieces 02–05 and 07 moved under `plan/builder/design/` unchanged except their status header (supersession lines) | as listed | `plan/Builder_Operating_Model.md`, `plan/builder/design/` | T-R8, T-R18, T-R19, T-C2, T-C4 (and T-C1 in 1d) |
| 9 | N-053's items: (a) T-R22 (a2) confirmed to run; (b) T-W6 with a brief whose text differs from its hash; (c) and (d) in the v1.8 delta; (e) M-R16 (b) binding against any review-branch commit whose blob equals the copy, and the owned list judged on the checked tree; (f) a verdict's `Written:` stamp compared with its review-branch commit time, and reviewers told to stamp from the clock; (g) the W-R7 (ii) exemption also runs the work check of every child at the PR head, a composition verdict identifies itself structurally (`**Composition of:** <ID>`), and R-W12-6 B-1's fixture is a T-W9 planted case that fails on `9d0fb72`'s checker; (h) `work_problems_at()` reads the test register at `rev`; (i) W-R7 (ii) points to M-R16 (b) and W-R1 by ID | W-R7, W-R4, M-R16, M-R14 | `tools/check_records.py`, `tools/test_check_records.py`, texts | T-W9, T-M15, T-W4 (1b-ii gate, re-run) |
| 10 | N-047 (effort of created sessions), N-048 (barrier in multi-repository sessions), N-052 (lineage limit): each a pre-registered probe (§4) before any rule text depends on it | W-R11 | evidence files | — (premises) |

**Not in 1c:** workflows (1d), the dispatcher's retirement (1d), C-R9 (deferred), the deferred rules of 12 §3.

## 2. Formats and decisions (each stated so that the Verifier can judge it)

- **Composition marker (N-053 g).** A composition verdict carries a line `**Composition of:** <ID>` naming the parent. W-R4 accepts `composition_by` only when that line names the item; the word "composition" anywhere in the text no longer suffices. No existing record uses `composition_by`, so no record changes.
- **Children at PR time (N-053 g).** `exemption_problems()` runs `item_work_problems()` for the item and for each of its children at the PR head; a child failing its own work check makes the parent's acceptance change class high, with the child's reason.
- **Brief gate (W-R6).** The hook takes the last line of the first message matching `^Task-Brief: (\S+) (\S+) ([0-9a-f]{16})$`, regenerates the brief with `records.py brief <ID> --role <role>` (and `brief run --role producer` for `run`) from an export of the fetched source revision, and compares the hash. A `run` brief needs the creating session to be the Run lock holder on the fetched `main` (or Batu's conversation session, R-R17). The first message must end with the whole generated brief (N-053 b; since the Critic's finding 2, nothing may follow it; text before it, the role file's task text, is allowed), so a valid-looking hash on a hand-pasted brief is refused. A non-empty `append_system_prompt` is refused (Critic finding 3). Verifier briefs need their arguments; the hook reads `--target-sha` and `--failure-classes` from the brief's own header lines, so it can regenerate them. Any error in the gate blocks the call (fail closed), and the message names the cause.
- **Boot map (M-R18).** `tools/boot_map` never exits non-zero to the hook: an exception prints `BOOT_MAP ERROR <type>` and exits 0. It prints no work state.
- **Hook edits in this session.** Every hook change is first run against its unit tests in a scratch copy; only then is it copied into the working tree, because the working-tree hook guards this session's own tool calls.

## 3. Gate tests (procedures of `11_test_register.md` §2; PASS and FAIL conditions unchanged)

Deterministic tests run in scratch repositories, never in this working tree, and their unedited output goes to `evidence/C00/tests/1c_gate.md`: T-M8, T-W6 (unit part), T-H4 (extended for H-BRF and the recorder), T-M17 (b), T-R12 (b), T-R22 (incl. a2, N-053 a), plus the 1b-ii gate re-run with N-053's planted cases.

Live tests need sessions or this session's own wakes: T-M12 (one `send_later`), T-C2 and T-C4 (a), (b) (this session's watchdog and queue), T-W6 (live part), T-M17 (a), T-R1, T-R2, T-R3, T-R5, T-R8, T-R18, T-R19, T-C4 (c), (d). The planted problem of every T-R1, T-R8, T-R18 and T-R19 case is written into `evidence/C00/tests/1c_planted.md` and committed before the run that meets it.

## 4. Probes (pre-registered here; each records the raw response)

- **P-W12-6 (N-052, lineage).** This run sits at `lineage` depth 8 of limit 8. Its first `create_session`, whatever its purpose, is the probe: the full response is recorded. If it is refused for depth, that is S3 for that action: the run releases the lease and `DURUM.md`'s first line asks Batu for one step (to have his conversation session start a new run, R-R17), and nothing routes around it. If it is allowed, the created session's `lineage` is recorded.
- **P-W12-7 (N-047, effort).** A created session reports what it can observe of its own effort setting (settings, environment variable, agent frontmatter). Recorded as observed or unknown; no rule changes on it in 1c.
- **P-W12-8 (N-048, multi-repository).** Not run in 1c unless a builder session needs a second repository: `create_session` takes one `source_url`, and the allow-list hook is observed in this run's own single-repository session. Its premise line goes on the map row A-01 as `untested (multi-repository)`.

## 5. Order of work, and what this run expects to reach

The order puts the pieces that need no new session first, because the lineage limit (P-W12-6) may refuse every `create_session` from this run:
1. this intent; W-C00-12.4 set `running`;
2. N-053 (g), (h), (e), (f) in `tools/check_records.py`, with planted cases that fail on `9d0fb72`'s checker;
3. M-R10 and T-M8;
4. R-R7: `FAILURE_PATTERNS.md` and its check, T-R12 (b);
5. W-R6 and M-R11 in the hooks, T-W6 and T-H4;
6. M-R18 and R-R6: `tools/boot_map`, `MEMORY_MAP.md`, `CLAUDE.md`;
7. role files, `REVIEW_PROMPT.md`, the v1.8 delta and the `design/` move;
8. the Critic pass (R-R16), the live tests and the session Verifier.

The tranche is larger than one run's half context. The run hands over (S4) at 50% context or a natural boundary, with the branch pushed and its state in the log; the PR stays open until a session verdict covers its head. A merge without that verdict is not made.

## 6. The session Verifier

Started with `create_session` on the PR head, with `plan/builder/REVIEW_PROMPT.md`, a review ID, the PR and its head SHA, and the generated brief, under the brief gate built here. **Criteria:** 12 §2.1 row 1c and §2.2 gate 1c; the rules of §1; this file; C3 and C6 of `13` §1; every item of N-053, (g) as a condition it checks itself; T-R1's planted problems, including one given to the Verifier itself. **Failure classes:** a check or hook rule that cannot fail on its planted case; a hook change that blocks ordinary work; a gate test departing from its register row; a class-high change computed normal; a producer-written check accepting the producer's work; a claim stronger than the evidence; a rule restated instead of pointed to; a role file without its sections (`04_roles.md` §3). A revert branch `claude/revert-w12-1c` is pushed and checked with `git ls-remote` before the merge, and named in `DURUM.md`'s risk line (12 §1).

## 7. Departures found during the build

Stated by run `session_011NtZnNGjojkTcmuzMRLtvL` before any Critic or Verifier read the result:

1. **Stamp comparison class (N-053 f).** A verdict whose `Written:` time is later than its review-branch commit fails `stamps`, not `claims`. A `claims` failure on a verdict file cannot be acknowledged, and would make every later stop fail for a timing error that leaves the binding intact; a `stamps` failure on a merged commit can be acknowledged by a log line. The new check found F-052-1 on `58f16bb` (L-058, F-058-1), acknowledged there.
2. **T-W4's fixture** now writes the composition marker into its composition verdict, because N-053 (g) changes the composition verdict's format; T-W4's PASS and FAIL conditions are unchanged, and one case was added (the word without the marker fails).
3. **The home table moved** byte-identical from `02_memory.md` §3 to `plan/builder/MEMORY_MAP.md`, which 02 §4 names as its one home; 02 §3 now points there (M-R1).
4. **Governing-documents rows** were added for `MEMORY_MAP.md`, `heritage/*`, `roles/*` and `REVIEW_PROMPT.md`, so that their status pointer resolves; each is a candidate until 1c merges with its verdict.
5. **Brief gate details.** For a verifier brief the hook reads `Target SHA:` and the failure-class list from the brief text in the message and regenerates with them; the whole generated brief must appear verbatim in the message (N-053 b). The hook exports the fetched revision with `git archive` and runs that revision's `tools/records.py` with `GIT_DIR` set to this repository, so a brief is judged by the generator of the revision the new session checks out.
6. **T-M17's script part** (`tools/test_1c.py`) reads the working tree and writes nothing; T-M17 (a) itself is a live test.
7. **Not done in this run:** the move of pieces 02–05 and 07 under `plan/builder/design/`, the live tests, the probes, the Critic pass and the Verifier (L-058). The `design/` move changes no rule; it waits so that every path citing those pieces changes in one reviewed step.
8. **The run brief and the `/goal` length limit** (found by run `session_01SsLSgp5RLPtNMhc1RxuDoZ` at boot, L-062). `/goal` takes the whole first message as its condition and, as reported by Batu's conversation session, refuses one longer than 4,000 characters. The run brief alone is 3,409 characters on `9999328` and the R1 goal about 2,750, so the gate as built (the message must end with the whole generated brief) makes every S4 successor and every run started from Batu's conversation session impossible. **Change, before any successor is attempted:** for a `run` brief only, the first message may end with the bare `Task-Brief: run producer <hash>` line instead of the whole brief; the hash is still regenerated and compared on the fetched revision, so a wrong or stale hash is refused as before. The successor regenerates the brief at boot with `tools/records.py brief run --role producer` and compares the last line (instructed, in R1 and C-R10; the run brief is mostly generated state that the successor reads anyway at boot steps 2 to 4). Item briefs (verifier, counter-designer, probe) keep the whole-brief rule, because those sessions do not start with `/goal`. Also new: a first message that starts with `/goal` and is longer than 4,000 characters is refused by the gate, so the failure shows at the call, not in the new session. Planted cases in T-H4 (T-W6 r1 to r4), each run on the previous hook first.
9. **Environment of a created session (N-054 b).** `create_session` must name `environment_id` explicitly and equal to the builder environment; an omitted one, which inherits the caller's, is refused. Planted case in T-H4.
10. **Notification of a Batu item at a stop (F-062-1).** The stop rules C-R10 and the S3 path name only `DURUM.md`'s first line; operating model §6 also requires a comment on the "Batu'dan beklenenler" issue that mentions him. The v1.8 delta and 05's C-R10 now point to §6 for that, and this run comments on issue #6 when it stops with a Batu item. Instructed, not mechanised in 1c; stated as such.
11. **A stamps false failure on a staged rename (F-063-1).** Before the `design/` move was committed, `check_records.py all` reported `stamps` on `02_memory.md` line 100, because the working-tree mode blames a staged, renamed file as new; on the committed tree `git blame` follows the rename and the check passes. Not changed in 1c (the check is right on every commit, which is what the stop check reads); stated so that a producer does not edit a moved file to silence it.

## 8. Critic findings and responses (non-binding; R-R16)

A Critic subagent (fresh context, read-only, prompted with `.claude/agents/critic.md`; the agent type itself was not loadable in this session, which started before the file existed) read `origin/main..db06c26` at 23:05Z and reported 13 findings. Each was reproduced or checked by this run before the response.

| # | Finding (short) | Severity | Response |
|---|---|---|---|
| 1 | A late `Written:` stamp made `verdict_bound()` false, so R-W12-5 could cover nothing; §7.1 and L-058 said the binding stays intact | material | **Accepted.** Binding counts only `claims` failures. Planted case T-M15 (f3) failed on `c530773`'s checker and passes after the fix |
| 2 | The brief gate accepted text appended after a valid brief; intent §2 and `CLAUDE.md` said more | material | **Accepted.** The message must end with the generated brief. T-H4 case added; it reported `BAD` on the previous hook and passes now. `CLAUDE.md` now points to W-R6 instead of restating it |
| 3 | `append_system_prompt` bypassed the gate | material | **Accepted.** A non-empty one is refused; T-H4 case added, `BAD` before, passes now |
| 4 | N-053 (e) can bind a copy of a superseded verdict (a PASS later revised to FAIL on the review branch) | material | **Accepted, carried to the next run:** bind to an older version only when every later version carries the same verdict line, and state the residual in M-R16; with a planted case |
| 5 | (z) is high by the missing marker alone; only (z2) tests the children's check; grandchildren are not checked | minor | **Accepted, carried:** the labels in L-058 are corrected by its last lines; recursion or a stated residual in the next run |
| 6 | `stamp_after_commit` takes the first `Written:` anywhere, passes when none, and uses author time | minor | **Accepted, carried** (anchor on `**Written:**`, use `%ct`, decide on a missing line) |
| 7 | `REVIEW_PROMPT.md` lacks an explicit terminal goal, FP IDs and a knowledge map with "look here when" lines | material | **Accepted, carried** to the next run, before the Verifier is started |
| 8 | R-R6's cost measurement is not done, though L-058 counts R-R6 as built | minor | **Accepted.** Corrected in L-058's last lines: the import is built; its measurement is open (needs a session started on the branch) |
| 9 | `CLAUDE.md` restated W-R6 and the role layout; REVIEW_PROMPT item 8 restates M-R14 | minor | **Accepted** for `CLAUDE.md` (now pointers); REVIEW_PROMPT carried with finding 7 |
| 10 | The run-brief check ignores a released or expired lease; `BATU_CONVERSATION` is one hard-coded ID | minor | **Accepted, carried** as residuals to state (with N-054 (b)) |
| 11 | Fail-closed status of the brief gate: no defect; a branch brief needs the branch pushed first | — | **Noted;** the push requirement goes into the role files with finding 7 |
| 12 | The boot map's `main` SHA is the last-fetched ref; chain FAIL lines could carry item IDs; T-R22 also reads the working tree | minor | **Accepted, carried** (label the SHA; filter FAIL lines; departure 6 extended to T-R22 here: T-R22 reads this tree and writes nothing) |
| 13 | The v1.8 delta's §2.3 row speaks in the present tense of a rule not yet governing | minor | **Accepted, carried** (mark rows "from the merge") |

## 9. Order of the remaining work (run `session_01SsLSgp5RLPtNMhc1RxuDoZ`, written before the work)

1. The `design/` move (done, L-063).
2. Frame review `FR-01` of the W-R7 (ii) path (N-054 a), with a bounded library consultation, before any further change to that path.
3. Departures 8 and 9 in the hook, and the carried Critic findings 4, 5, 6, 7 (with 11), 10, 12 and 13, as `FR-01` decides for those on the W-R7 (ii) path; each code change with its planted case run on the previous code first.
4. The planted-problems file `evidence/C00/tests/1c_planted.md`, committed before any live test.
5. Live tests and probes. The first session this run creates is P-W12-6's lineage record (its `lineage` from `get_session`); P-W12-7 is asked of the same session where its role allows.
6. A Critic pass (R-R16) on the final diff; the gate evidence re-run on the final head; the session Verifier with the generated verifier brief, created on the branch revision.
7. If the verdict passes: its recorder line in its own record PR on `main`, `main` merged into the branch, the verdict copied, the revert branch pushed and checked, PR #86 merged. If it fails: dispositions, and a hand-over or a stop with the reason.
