Prober (Sınayıcı), a fresh-context subagent (declared), for T-W03-05 and T-W03-08 (a) to (d) and (f). Environment: started 2026-10-13T07:40:29Z UTC. The local HEAD is `1c0dbcf51ad4079f7f3a67ed7646bac42e6bd6d9`, H1-prime's merge commit, and the working tree is clean under `.github`, `supabase` and `tests`. Model claude-opus-5-5; the Claude Code version was not observed.

**Method.** I used only read-only commands: `grep`, `sed`, `awk`, `cat`, `git show --stat`, `git cat-file`, and `python3 -I` reading files. All exited 0 except one: `git cat-file` on probe commit `6683a8b` failed because the object is not in the local store, so I could not read the probe workflow file. I wrote no file. I mapped steps to workflow step IDs by order. The log has one `##[group]Run` per step: 19 in devos-test and 16 in devos, the same counts as `migrate.yml`'s step lists at `1c0dbcf`.

**Sources abbreviated below** (all in `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/`):
- DT: `h1p_push_run38363215668_devos-test_job115182093582.log`
- DV: `h1p_push_run38363215668_devos_job115182202196.log`
- ROW: `t_w03_05_devos_read_20261013T0735Z.json`
- REC: `t_w03_08_attempts_run_records.md`
- PRL: `t_w03_08_pr321_migration-checks_run38363816205_job115184056302.log`

**Disclosure.** One of my parsing commands showed environment-block continuation lines in my own tool output: the public pinned root CA PEM (`W03_ROOT_CA_PEM`, 23 lines) and the CLI config (`W03_CLI_CONFIG`, 6 lines). A later grep also showed PRL L946, an env line. None of these is the plant. I checked by counting only: the plant's value sits on one line, appears on exactly 19 (DT) and 16 (DV) key lines, and on no other line. I did not decode it. Nothing from env blocks is quoted below.

## Disciplines (D1–D9)
D1: yes: for each inference (why the probe jobs failed, which project the `devos` row came from, the step mapping) I set out the reasonable alternatives and limited the claim where one was not excluded.
D2: yes: I treated the executor's unsaved run-level facts and the task's framing as claims rather than evidence, and graded each outcome by the tests' own words rather than towards closure.
D3: yes: I checked each observation against the test's "What is observed", "Expected" and "Observed from" columns, not just job success, and left W-C02-03's acceptance to point 13's checker.
D4: yes: for each record I asked whether it would turn red if the claim were false (a job failing vs. a step printing `yes`; the breaks), and named where sensitivity rests on a break that was not made.
D5: yes: I went back to the raw logs and the fixture text for every field and time, and marked what rests only on the executor's copies or account.
D6: yes: for T-W03-08's failed jobs I listed alternative causes (billing lock, no runner, a broken workflow file, a reviewer rule) and the evidence that tells them apart, without claiming the refusal message's text.
D7: no
D8: yes: I confirmed that the local HEAD equals merge commit `1c0dbcf` and the relevant paths are clean, so the files I compared are the ones the run used.
D9: no

## T-W03-05

**Item 1: the run record of push run 38363215668 at `1c0dbcf`**

| Observation | Raw evidence (job-own lines) | Outcome |
|---|---|---|
| devos-test: credential line | DT L838 `credential present: yes` (07:31:51.453Z) | pass |
| devos-test: `apply` succeeded | DT L1221 `cli: Applying migration 20261012231841_w03_fixture_apply.sql...`; L1228 `apply: exit 0`. Step runs 07:31:53.559Z to 07:31:54.581Z. | pass on job-own lines (see G1) |
| devos-test: `compare` succeeded | DT L1459 `comparison in devos-test: result=no_difference call=ok`. Runs 07:31:54.586Z to 07:31:55.149Z. | pass on job-own lines (G1) |
| devos-test: `dbtests` succeeded | DT L1600, L1631, L1656 `database test <file>: passed` for all three files. Runs 07:31:55.156Z to 07:31:57.395Z. DT L2053 `devos-test go=yes (head=yes apply=success comparison=no_difference tests=success programs=success revocation=success)`, where `go` prints `steps.apply.outcome` and `steps.dbtests.outcome`. No `##[error]` or `##[warning]` in DT, and no `continue-on-error` in `migrate.yml`. | pass on job-own lines (G1) |
| devos: `decide` gives apply = yes | DV L1544 `first-migration exception: not taken (...)`; L1545 `decide: apply=yes result_kind=differences exception=not_taken; only migrations on main, not applied: 1` (07:32:09.566Z) | pass |
| devos: dry run lists the fixture | DV L1621 `cli:  • 20261012231841_w03_fixture_apply.sql`; L1623 `dry run: pending versions: ["20261012231841"]` | pass |
| devos: `apply` succeeded | DV L1700 `cli: Applying migration 20261012231841_w03_fixture_apply.sql...`; L1707 `apply: exit 0`. Runs 07:32:10.385Z to 07:32:11.294Z. | pass (G1) |
| devos: `compare_after` ran | DV L1937 to L1938, runs 07:32:11.299Z to 07:32:11.514Z | pass |
| Order: devos's apply starts after devos-test ends | DT ends 07:31:57.778Z (L2167). DV starts 07:32:04.392Z (L1). The DV apply group starts at L1625, 07:32:10.385Z. The executor's unsaved job times agree: devos-test ended 07:32:00Z, devos started 07:32:03Z. The workflow has `needs: devos-test` (`migrate.yml` L993). | pass. The devos job's `if: !cancelled()` would also run it after a failed devos-test; whether devos waits for devos-test's `go` is T-W03-DEC's question, not checked here. |

**Item 2: devos-test's own read.** It runs in step `dbtests`, which runs only after a clean comparison (DT L1459). Its lines are DT L1632 to L1656, each prefixed `w03_fixture_apply_read.sql:`:
- L1635 `W03_FIXTURE_READ server: PostgreSQL 17.6, database postgres, session user postgres, read at 2026-10-13T07:31:57Z UTC`
- L1636 and L1637: positive controls `table auth.users present` and `table devos_private.function_deployment present`
- L1638 to L1649: the twelve fields
- L1650: the view definition, printed only: `SELECT id, note FROM w03_fixture.apply_check`
- L1651 `break (a), the default planted as 'w03_other': fields found different: {table_columns}`
- L1652 `break (b), the history read with version 29990101000009: 0 rows`
- L1653 `W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)`

Provenance: the read sits in job "devos-test (apply, compare, test)" (DT L32). That job's `PROJECT_REF` and `PGUSER` match devos-test's ref in EV-C00-002 item 6, not devos's. I compared them in code and did not quote them. **Outcome: pass.**

**Item 3: the `devos` read through the read-only connection** (ROW). Read at `2026-10-13T07:35:14Z`, after DV's apply. Server `17.6`, database `postgres`. `control_auth_users: true` and `control_function_deployment: true`. `differs: []`, `break_a_differs: ["table_columns"]`, `break_b_rows: 0`. Its ten columns are exactly the output columns of `T-W03-05_devos_read.sql`. **Outcome: pass** by the SQL's own reading rule, with a provenance caveat (G2).

**My comparison of the twelve fields with the fixture file** (`supabase/migrations/20261012231841_w03_fixture_apply.sql`):

| Field | File text | devos-test (DT line) | devos (ROW) | Match |
|---|---|---|---|---|
| schema | L9 `create schema w03_fixture` | L1640 `"w03_fixture"` | `w03_fixture` | yes |
| table_kind | L11 `create table` | L1643 `"r"` | `r` | yes |
| table_columns | L12–13 (primary key gives not-null; no default on `id`) | L1641 `[["id", "integer", true, null], ["note", "text", true, "'synthetic'::text"]]` | same | yes |
| table_primary_key | L12 | L1645 `["PRIMARY KEY (id)"]` | same | yes |
| table_other_constraints | none in the file | L1644 `0` | `0` | yes |
| table_comment | L16 | L1642, the exact string | the exact string | yes |
| view_kind | L19 `create view` | L1647 `"v"` | `v` | yes |
| view_columns | L20 `select id, note` | L1646 `[["id", "integer"], ["note", "text"]]` | same | yes |
| view_options | L19 `security_invoker = true` | L1648 `["security_invoker=true"]` | same | yes |
| view_reads | L20 `from w03_fixture.apply_check` | L1649 `["w03_fixture.apply_check"]` | same | yes |
| history_rows | the version in the file name | L1639 `1` | `1` | yes |
| history_name | the file name without version and `.sql` | L1638 `["w03_fixture_apply"]` | same | yes |

**Item 4: `deployment_drift` after each apply**
- devos-test: DT L1458 `reads in devos-test (...): function_exists=True history_table_exists=True history_rows=2 listing=7 objects complete=True` and L1459 `result=no_difference`. The report line L2149 `W03REPORT {"project":"devos-test",...,"commit":"1c0dbcf51ad4079f7f3a67ed7646bac42e6bd6d9","head":"yes",...,"result":"no_difference","differences":[],...}`.
- devos: DV L1937 (same form, `history_rows=2 listing=7 objects complete=True`), L1938 `comparison in devos: result=no_difference call=ok`, and L2040 `W03REPORT {"project":"devos",...,"result":"no_difference","differences":[],...,"result_before_apply":"differences"}`.
- Head check in each job, L101: `head check: yes (this run's commit 1c0dbcf51ad4079f7f3a67ed7646bac42e6bd6d9 is main's head)`.
- **Outcome: pass for each project.**

**Item 5: the versions in a run's report.** Both reports carry `"applied_versions":["20261012184638","20261012231841"]` (DT L2149, DV L2040). The run was not superseded (head = yes). PRL L837 shows an independent job reading the same report: `run report: run 38363215668 (push) at 1c0dbcf...: projects reported: ['devos', 'devos-test']`. **Outcome: pass.**

**Examples (a) to (d), per project**
- (a) The table: devos-test DT L1641 to L1645; devos ROW `table_*`. Pass in both.
- (b) The view: DT L1646 to L1649; ROW `view_*`. Pass in both.
- (c) The history row: DT L1638 to L1639; ROW `history_*`. Pass in both.
- (d) The comparison after each apply: DT L1459; DV L1938. Pass in both.

**Positive controls** held in both projects: DT L1636 to L1637; ROW controls `true`. **Breaks (a) and (b)** held in both: DT L1651 to L1652; ROW. The comparison breaks (T-W03-06 B1 to B3) and T-W03-14's static test are not in my sources and were not assessed.

**T-W03-05 result as recorded:** devos-test passes and devos passes, with the record weaknesses G1 to G3 and coverage note G12.

## T-W03-08

| # | Expected / Observed from | What REC/PRL show | What they do not show | Outcome by the test's words |
|---|---|---|---|---|
| (a) push, run 38363721373 attempt 1 | Refused by the deployment-branch rule (its message), and the presence step does not run or prints `no` / the jobs' status and annotations, the step's log | First read: run and both jobs `"status":"waiting"`. Then run and jobs `"conclusion":"failure"`; jobs started 07:36:26Z and completed 07:36:27Z. Job 115183743279 has `"runner_id":0,"runner_name":""` and no `steps` field. Both check runs have empty output. `get_job_logs` returned HTTP 404 for both jobs. | The protection-rule message, so the annotations; the step's log, which does not exist; and the runner fields for job 115183743459. | "Presence step does not run": observed. No runner was assigned, there is no log, and the job lasted 1 s, against 15 s for H1-prime's devos-test job. "Refused by the deployment-branch rule": could not check, because the message was not read. |
| (b) PR #321, probe run 38363816211 | `GITHUB_REF` is `refs/pull/N/merge`; refused as in (a) | `"event":"pull_request","conclusion":"failure"`; jobs failed in 1 to 2 s (07:37:19Z to 07:37:20/21Z). The sibling `migration-checks` run of the same PR checked out the merge ref: PRL L101/L283 `+...:refs/remotes/pull/321/merge`, L308 `HEAD is now at 6398a81 Merge 6683a8b2... into 1c0dbcf5...`. | The probe run's own `GITHUB_REF` (seen only for the sibling run); runner fields; a log request; the message. | Not a fail. The ref is shown only indirectly. "Does not run" rests on a failure conclusion within 1 to 2 s, with no runner or log record. The message part could not be checked. |
| (c) `workflow_dispatch`, run 38363830176 | Refused as in (a); `GITHUB_REF` is the branch | `"event":"workflow_dispatch","head_branch":"claude/w03-branch-probe"`; first `waiting`, then `failure`; jobs ran 07:37:27Z to 07:37:29Z. | Runner fields, a log request, the message. | As (b). The branch ref is shown by `head_branch`. |
| (d) re-run of (a) | Refused again; P6 / the re-run's attempt number and status | `"run_attempt":2`, first `waiting` (07:37:40Z), then `failure`; new job IDs 115184174360 and 115184174710, failed in 2 s. | The attempt-2 jobs' `waiting` state (only the run's is recorded); runner fields and logs. | Pass on its own "Observed from" column (attempt number and status). The run's `waiting` is the only sign that the rules were evaluated again for P6. |
| (f) `issue_comment` on #322 | No probe run / the probe workflow's run list at and after the comment | Comment created 07:38:00Z. The probe list read at about 07:38:30Z has `"total_count":3`, none `issue_comment`. The repository-wide `issue_comment` and `issues` lists both have `"total_count":0`. | Exact read times ("about"); only one read after the comment. | pass |
| Positive control | H1-prime's push run: each job prints `yes` and applies | DT L838 and DV L838 `credential present: yes`; DT L1228 and DV L1707 `apply: exit 0` | none | met |

**Is "the presence step does not run, or prints `no`" met?**
- **(a): yes, in my reading.** `runner_id 0`, no log and a 1 s job mean no step executed. That a secret reaches only a job running on a runner is general GitHub knowledge, not something observed here.
- **(b) to (d): only by the conclusions.** If the probe's only step had run, it would most likely have ended in success, since it "runs no other command". So `failure` at 1 to 2 s does tell the cases apart. But that rests on the probe file's content, which I could not read (G8). PRL L707 to L716 show only its parse: environments `migrate-devos` and `migrate-devos-test`, a `presence` step in both jobs, and the events `pull_request`, `workflow_dispatch` and `issue_comment`, plus a push trigger that is not main-only.

**Alternative causes for the failures (D6):**
- A billing or account lock, or no runner available: argued against by PRL. `migration-checks` ran on a runner from 07:37:22Z to 07:37:30Z, between (b) and (c).
- A broken workflow file: argued against because jobs were created, and the file parses (PRL L707 to L716).
- A reviewer or wait-timer rule: it would stay `waiting` rather than fail within 1 s.
- **Best explanation: the environments' branch rule. It is consistent with the evidence but not proven without the message.**

**Break attempt:** the synthetic environment `w03-fixture-unprotected` does not appear in any record. By the test's own rule the break is "could not check".

## Gaps and could-not-check
- **G1.** T-W03-05 item 1 asks for "GitHub's run record": step conclusions and step times. No saved file holds them for jobs 115182093582 and 115182202196. The job conclusions and times are the executor's unsaved account. Only the two skipped jobs are confirmed by a saved file (PRL L835 to L836 by absolute line). My step times are log timestamps, not GitHub's recorded step times.
- **G2.** The `devos` row has no project identifier. `database: postgres` and version 17.6 hold in both projects, and both now have the same fixture state. EV-C00-002 item 8 (single project) is "documented only". So that the row came from `devos` rests on the executor's label and the connector setup. ROW is also the executor's copy of the connector's answer, not a transcript.
- **G3.** Hygiene: DT and DV hold the plant tag in 19 and 16 env-block lines. Under the README's hygiene rule and FR-07 item 3 they cannot be committed unedited as T-W03-05's `raw_evidence_ref`. How point 13's checker reaches the raw logs is the executor's decision.
- **G4.** The protection-rule message was not read for any of (a) to (d): check-run output is empty, and the tools returned no annotations. That part of "Expected" is "could not check".
- **G5.** For (b) to (d) there are no runner fields and no log request on record, unlike (a).
- **G6.** For (b), `GITHUB_REF` is shown only for the sibling `migration-checks` run.
- **G7.** The T-W03-08 break was not made, so it is "could not check". Sensitivity rests on the positive control and on GitHub's documentation, and the record must say so.
- **G8.** The probe workflow's text is not available locally (`6683a8b` is absent). Its blob SHA and `migrate.yml`'s blob SHA (`deployment_config_ref`) are not in REC.
- **G9.** The (f) read times are approximate, with one read each.
- **G10.** The "Afterwards" steps (PR closed, issue closed) appear only as executor lines. Branch deletion is not mentioned.
- **G11.** Attempt (e) has not been made yet, so T-W03-08 is incomplete until it is.
- **G12.** Coverage: the twelve fields do not cover the fixture's revoke statements (L24 to L35). The test does not ask for them, and nothing observes them.
- Not run: no network or GitHub reads, by the task's limits. The probe file could not be read (G8).
- Guard denials: none.

## Summary
- **T-W03-05:** every one of the five items and all four examples (a) to (d) are observed in both projects from job-own lines and the `devos` row. The twelve fields equal the fixture file, the controls and both breaks held, and the order holds. Result: pass in devos-test and in devos, subject to G1 to G3.
- **T-W03-08 (a) to (d):** every probe job failed within 1 to 2 s; in (a) no runner was assigned and no log exists. "The presence step does not run" is observed for (a) and inferred for (b) to (d). The refusal message is unread, so that part is "could not check".
- **T-W03-08 (f)** passes, and the positive control is met. The break is "could not check", and (e) is pending.
- The weakest records are the unsaved step-level run record (G1), the `devos` row's lack of a project label (G2), and the message and break gaps (G4, G7). Acceptance is left to point 13's checker.
