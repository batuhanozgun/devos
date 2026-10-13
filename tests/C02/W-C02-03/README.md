# W-C02-03 tests (migration path): index

**What this is.** These are the tests of W-C02-03's points 5 to 10 and the observation of point 14, in Appendix C's form C0 (`plan/Ek_C_Testler.md` C0). They are written before the build they judge (point 12) by the test designer (W-C02-02's role, `.claude/agents/test-designer.md`). They follow the accepted design `evidence/C02/EV-C02-001_migration_path.md` at `main` `0fe3b36` (sections 4, 5, 6, 10 and 12), PC-41, EV-C02-004, and the findings of CHK-C02-008, CHK-C02-011 and CHK-C02-013 that name test needs.

The acceptance condition and the design are not changed here. A test is never changed after a result of the item it judges has been seen (ledger rule 3; Appendix G G8 item 3). If a test looks wrong after a result, report it; the earlier result is then void and the test is run again. That is the executor's decision.

All fixtures are synthetic (plan Section 8 item 13). Each file says so in its header.

## Index

| Test | Points | Specification | Executable part (class) | Runs where |
|---|---|---|---|---|
| T-W03-05 | 5 | `T-W03-05_apply_and_effect.md` | the fixture `supabase/migrations/20261012231841_w03_fixture_apply.sql` and its read `supabase/migrations/tests/w03_fixture_apply_read.sql` (high); `T-W03-05_devos_read.sql` (normal) | GitHub's run record; `devos` through the builder's read-only connection; `devos-test` through the job's own read (`dbtests`) |
| T-W03-06 | 6 | `T-W03-06_merged_not_applied.md` | `supabase/migrations/tests/w03_drift_detects.sql` (high); `breaks/B1` to `B3` (normal) | live, as T-W03-05; SQL in `devos-test` (the job's test step) and on a throwaway database (the breaks) |
| T-W03-DEC | 6, 7, 14 (the deciding steps) | `T-W03-DEC_decision_steps.md` | `test_decision_steps.py` (normal) | anywhere with Python 3 and PyYAML; no credential; also in the pull-request checks |
| T-W03-07 | 7 | `T-W03-07_could_not_check.md` | `supabase/migrations/tests/w03_drift_could_not_check.sql` (high); `breaks/B4` (normal); part A is in `test_decision_steps.py` | as T-W03-06 and T-W03-DEC |
| T-W03-08 | 8 | `T-W03-08_branch_refused.md` | none (live) | GitHub's run record |
| T-W03-09 | 9 | `T-W03-09_credential_search.md` | none (live; the search step is the build's) | the scheduled jobs `check-devos-test` and `check-devos` |
| T-W03-10 | 10 | `T-W03-10_probe_absence.md` | `T-W03-10_devos_listing.sql` (normal), the listing step's text for a one-statement client | the job's listing in each project; `devos` also through the builder's read-only connection; a throwaway PostgreSQL database, with the listing step's own text run by psql, for the sensitivity check and its breaks |
| T-W03-14 | 14 (observation) | `T-W03-14_order_and_stop.md` | `test_workflow_order.py` (normal; it reads the workflow and does not run it); the fixtures H2, H4 and H5, kept outside the repository until each one's change (high when merged) | live, as T-W03-05; the static test anywhere with PyYAML |

"Class" is the merge gate's class of the file's path (`tools/merge_gate.py`). `supabase/migrations/tests/` is class high: the job runs those files with `devos-test`'s credential (EV-C02-001 M09; N-233).

## Common rules (each specification applies them; its own fields give the specifics)

**Results.** Every test gives one of three results: **pass**, **fail** or **could not check**. The three are counted apart. A "could not check" is never counted as a pass, and it counts in the denominator (plan Section 8 item 14).
- The executable tests end with one line, `<NAME> PASS (n/n)`, `<NAME> FAIL (...)` or `<NAME> COULD NOT CHECK (...)`, with exit codes 0, 1 and 3. The SQL tests end with a notice for PASS, or with a raised error for FAIL and COULD NOT CHECK, so that the job's step fails and `go` is not `yes`.
- A live observation that cannot be made is recorded as "could not check", with what kept it from being made. Examples: a project that no reader reaches, a run that did not start, or a session that cannot push a workflow file.

**Before the build exists.** Each executable test gives COULD NOT CHECK, never PASS:
- `test_decision_steps.py` and `test_workflow_order.py` when `.github/workflows/migrate.yml` or `migration-checks.yml` is absent;
- the SQL tests when `devos_api.deployment_drift(jsonb)` or one of the records is absent.

The two Python tests each have a self-check (`--self-check`) that turns red on programs or workflows that are wrong by construction. The SQL tests have no self-check of their own. Their check is the break patches `breaks/B1` to `B4`, run on the throwaway database, with the unpatched run as the positive control (T-W03-06 and T-W03-07, "Break attempt"). Each patch refuses, and applies nothing, unless `w03.throwaway = 'yes'` is set and no `supabase_admin` role exists. The guard and the patch are one statement, so this holds whatever the client does after an error.

**Interfaces.** Where the design leaves a name or a form open, the specification states the interface the test assumes, under "Interface". If the build chooses another form, the test designer revises the test before its first run. The revision is merged before the result it judges, so git order still shows the test first. The builder does not adapt a test.

**The evidence envelope** (plan Section 8 item 9; Appendix B `EvidenceEnvelope`). Each result carries these fields, filled as follows:
- `claim`: the test's claim, as its specification states it;
- `target_commit`: the `main` commit judged, and for a live run the run's own `head_sha`;
- `deployment_config_ref`: the blob SHA of `.github/workflows/migrate.yml` (and of `migration-checks.yml` where used) at that commit; the command-line tool's release and its committed SHA-256; the environment names. Never a secret's value;
- `criterion_version`: the commit that merged this test's files, which must precede `target_commit`;
- `inputs_ref`: the fixture files and the case IDs;
- `observations_ref`: the run's URL, run ID, job IDs and step names; or the query and the time it was taken;
- `raw_evidence_ref`: the raw output file under `evidence/C02/raw/`;
- `independence_level`: who wrote the test, who ran it, who assessed it (plan Section 8 item 7);
- `evidence_layer`: as the specification states;
- `run_at`: UTC.

**Raw output hygiene** (point 12). Raw output must hold no key, token or password, and nothing derived from one: no hash, no prefix, no length, no masked fragment.
- The job prints names, versions, counts and statuses only (EV-C02-001 M21).
- Before a raw file is committed, the runner checks it in two ways:
  - (a) A search for connection-string, URL-with-password and long hex or base64 patterns, whose method and result are recorded.
  - (b) `python3 -I tools/credential_value_scan.py --dir <the raw file's directory>`, whose exit code and match counts only are recorded. Its printed labels and lengths of the session's own credentials are not copied into any record. That scan finds only the session's own credentials. The migration passwords are never in a session's reach, so for them the guarantee is (a) plus the job's own masking and printing rules.
- If either check cannot run, the raw file is "could not check" for hygiene and is not committed until it can.

**Fixtures.**
- **Offline and in-transaction fixtures** use versions `2999…`, names `w03_fixture_*` and slugs `w03-fixture-*`.
- **Live fixture migrations** merged into `main` use the normal version format, `<UTC timestamp>_w03_fixture_<what>.sql`, with a first-line comment `-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 <test ID>`. A far-future version would make every later real migration older than the latest applied one, which the pinned tool refuses without `--include-all` (observed offline with v2.120.0: T-W03-14, "P2, settled offline"). For the same reason each fixture's version is later than every version on `main` when its pull request is opened, and a real migration that merges after a fixture must have a later version than every fixture applied before it.
- Every live fixture is class high, merges only through the merge gate with a fresh-context verdict, and is merged after W-C02-19 is accepted (W-C02-03 item text).
- Each record states what each fixture left in each project, and how `main` and both projects came back to "no difference" (point 14).
- **The live campaign's class-high changes** are named H1 to H5 in these tests. H1: T-W03-05's fixture and its read, with the workflow change made in parallel by a producer (the plant's settings `W03_PLANT_B64` and `W03_FIXTURE_ISSUE`, the step that prints the decoded plant once, and `tokens_revoke` gated on the head check). H2: T-W03-14's failing fixture (with the plant's settings unset and the print step removed, or that in a later class-high change). H3: H2's file removed. H4: the fixture that changes the name in T-W03-05's history row. H5: its repair. H2, H4 and H5 are kept outside the repository with their intended file names until each one's change.

**Who runs, who judges** (unless a specification says otherwise):
- **Executable tests:** run by the build producer at the build's head, and run again by the fresh-context checker of point 13, who reads the raw output rather than the producer's account. (These ran so at the build; they are re-run at each head that changes what they read.)
- **Live observations** (revised 2026-10-12, before any of them was made: the producer, prober and checker roles may not push, open or close pull requests or issues, comment, dispatch or re-run, and the guard refuses `gh`):
  - the **executor** makes every GitHub action (pushes, pull requests, issues and comments, dispatches, re-runs, merges), reads the run records and job logs, and saves them unedited; it also makes the reads in `devos` through the builder's read-only connection (EV-C00-002 item 8), with their UTC times;
  - a **prober** (fresh-context subagent, declared) analyses the saved records and logs, and runs the tests that need a throwaway PostgreSQL database (T-W03-10's planted part and breaks; the equivalence checks of the `devos` reads);
  - the **fresh-context checker of point 13** assesses them from the saved raw records, not from the executor's or the prober's account.
  The observations are read from GitHub's run record, from the job's own lines, and in `devos` from the read-only connection. A test's "Who runs" and "Independence level" name these roles; where an older text names "the build producer" as observer, this rule replaces it.
- **The test designer** neither runs nor judges these tests. It wrote T-W03-05's fixture and reads and T-W03-14's fixtures, and its offline runs of them (P2; T-W03-05's and T-W03-10's self-checks) are self-checks of the tests, not their results.

**Revisions before the first runs** (2026-10-12, by the test designer, under "Interfaces" above; no result of the parts revised existed): T-W03-05 (its fixture, reads, self-check and observers named; run 38316669047 supporting only); T-W03-06 part A (forms (i) and (ii) planted by H2 and H4; observers); T-W03-07 part C (observers); T-W03-08 (e) (H1's own push run, whose commit gates `tokens_revoke` on the head check; observers; run 38316669047 supporting only); T-W03-09 (p4 is the line H1's print step prints; its expected count; plant handling; observers); T-W03-10 (the planted part and its breaks on a throwaway database with the listing step's own text; the `devos` read's one-statement form; observers); T-W03-14 (P11: item 1 fails in both projects; item 2a revised after P2; P2's offline result; observers; run 38316669047 supporting only). The parts that already had results (T-W03-06 part B, T-W03-07 parts A and B, T-W03-DEC, the static tests) are unchanged.

**What this directory does not cover, and why** (so that silence is not read as a pass):
- **Y-09's test** (EV-C02-001 section 10: the command-line tool reads nothing under `supabase/` but the copies). It is a design commitment, not one of points 5 to 10 or 14. It needs its own C0 test before the first migration merges.
- **Probes P1 to P13.** These are the build's observations. The tests name the probes they rely on.
- **`deployment_drift`'s token branch and the identity chain's token check.** These are W-C02-05's, W-C02-07's and W-C02-09's. No point of W-C02-03 needs them. The first migration's refusal of every caller but `postgres` (EV-C02-001 section 10, "Two further points") is observed through the Data API at P5, not by a `set role` test, because `session_user` stays `postgres` (N-244 (2)).
- **The content of C02's own migrations.** This is W-C02-07's and W-C02-08's.
- **The comparison through `devos_ci`.** It starts at W-C02-12 or the item that stores the key (M15). `test_decision_steps.py`'s pull-request cases cover the run-report period only, and the direct call needs its own cases then.
- **Whether the credential stays out of reach after a later change** of the workflow, or of GitHub's or Supabase's behaviour. Class high, judged at that change; re-read under N-208's trigger.
