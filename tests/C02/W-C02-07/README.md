# W-C02-07 tests (C02's tests, written before the build): conventions

**What this is.** These are the conventions every C02 test file under this directory follows, the SQL files and programs staged in `job/` among them, and their copies under `supabase/migrations/tests/` (section 5.1 (c), phase C5). The test designer (W-C02-02's role, `.claude/agents/test-designer.md`) wrote them in phase A of W-C02-07's three phases:
- phase A: this file, `GROUPS.md` (the split into four groups) and `TABLES.md` (the skeletons of the tables the acceptance asks for);
- phase B: four test designers write the groups in parallel;
- phase C: one test designer fills `TABLES.md` from the groups' files.

The acceptance condition is `plan/work/W-C02-07.md`, points 1 to 8 and "Not covered", at `main` `db2ebd9`. Nothing here changes it. Where this file and that condition differ, the condition holds and the difference is reported.

The conventions follow W-C02-03's tests (`tests/C02/W-C02-03/README.md` and `supabase/migrations/tests/w03_*.sql`, branch `claude/c02-w03-tests` at `86ebd65`, under check when this was written) in:
- the result values;
- the evidence envelope;
- the raw-output hygiene;
- the form of an SQL test file;
- breaks run only on a throwaway database.

They add what W-C02-07 needs and W-C02-03's tests do not have:
- role switching with `set role`;
- the Data API path;
- the real-token runs;
- the break harness's own definition.

No test case is written in phase A.

## 1. File naming

| What | Path | Merge-gate class (`tools/merge_gate.py`) |
|---|---|---|
| Specification of one test, in form C0 | `tests/C02/W-C02-07/T-W07-<ID>_<slug>.md` | normal |
| SQL test, staged (phase C5; section 5.1 (c)): run by the break harness from here, and by the migration job in `devos-test` once a build item copies it | Staged: `tests/C02/W-C02-07/job/w07_<id>_<slug>.sql` (`<id>` is `<ID>` in lower case without hyphens, for example `w07_f01_whole_intent.sql`, `w07_5b_authorization_matrix.sql`). Its copy, byte for byte: `supabase/migrations/tests/w07_<id>_<slug>.sql` | Staged: normal (`tests/**`). The copy: high (`supabase/migrations/**`) |
| Break patch | `tests/C02/W-C02-07/breaks/B-<ID>-<n>_<slug>.sql`, never under `supabase/migrations/` | normal |
| Program the migration job runs in its `devos-test` step once a build item copies it (a multi-connection runner, a Data API client, a check that reads a repository file against the database) | Staged: `tests/C02/W-C02-07/job/w07_<id>_<slug>.py`; its copy, byte for byte: `supabase/migrations/tests/w07_<id>_<slug>.py` (section 5.1 (c)). Run with `python3 -I`; one that needs the step's database connection says so in a line `# w07-needs-database: yes` among its first ten lines, and any other runs under `env -i` (section 5.1 (b); note N-255 on `plan/work/C02.md`) | Staged: normal. The copy: high (`supabase/migrations/**`) |
| Program the job does not run (a scan of the repository's files) | `tests/C02/W-C02-07/bin/<id>_<slug>.py`, run with `python3 -I` | normal |
| Shared fixture or definition owned by one group | `tests/C02/W-C02-07/shared/<name>` (owners in `GROUPS.md` section 2) | normal |
| The break harness | `tests/C02/W-C02-07/harness/` (owner in `GROUPS.md`) | normal |

**Test IDs.** `<ID>` is one of these:
- the Appendix C ID: `F01`, `F04`, `F05`, `F06`, `F07`, `F08`, `CONC` (Concurrency), `N01`, `N02`, `N03`, `N04`, `N08`, `N09`, `N17`, `N25`, `N28`, `N29` or `K05`;
- the acceptance point it answers: `5A`, `5B`, `5C`, `5D`, `6RG`, `6TK`, `6ST`, `7SCAN`, `T31`;
- a rule a design record adds: `DM02`, `DM07`, `DM11`, `DM19`, `DM19B`, `DM34`, `DM47`, `IDC`, `FGFIND`, `RT`, `ROC` (EV-C02-008 1.7.1's Rules O and C; phase C4a).

`GROUPS.md` fixes every ID and its owner. A group adds an ID only inside its own scope and names it in its report, so that phase C can put it in `TABLES.md`. In the full name `T-W07-<ID>`, the prefix keeps the IDs apart from Appendix C's own and from W-C02-03's `T-W03-*`.

**Case IDs** inside a test are `<ID>-<letter or number>`, for example `F01-a`, `N03-neg3`, `5B-calisma-verdict`, `CONC-pos`. The clause table (point 2) and the break's expected red cases cite case IDs. Case IDs never change after the merge. Where a design record suggests case IDs that its verdicts then cite, the test keeps them: `T-W07-N28` keeps EV-C02-008 2.5's `S-*`, and `T-W07-N08` part X keeps EV-C02-008 5.1's `EXF-pair-*` (phase C4b).

## 2. The C0 template (point 3)

Every specification has the header lines and the table below. Every field is filled. A field that the Appendix C entry leaves empty (R2 section 5 (c): the C2 rows' class rule, examples and break; Concurrency's class rule, examples, negative control and break; K05's fields beyond its success condition; the F entries' claim; N01's tolerance) is filled by the test designer and marked **[Designer's addition: <reason>]**. A field that holds a placeholder ("TBD", "as above" with nothing above, "see build") fails point 3. "As in the README" is allowed only where this README fixes the content.

This section is a template, not a test.

```
# T-W07-<ID> · <the claim, in one line>

Synthetic test data (plan Section 8 item 13): <what is made up, with the names and labels it uses>.

**Serves.** <build item and point, e.g. W-C02-09 point 8>; C02 Acceptance line "<verbatim>" if any; Appendix C <ID>, verbatim where quoted; the design decisions it relies on (EV-C02-002 DM-nn, EV-C02-003 §n, EV-C02-004 X-/Y-nn, PC-42/PC-43 place n).
**Command.** <the exact command that runs it on real PostgreSQL in its place (section 5)>.
**Time added to W-C02-13's run.** <time, or "none: it waits on no schedule or limit">; for a wait: the time's source with its date (plan 6.12 item 1; PC-23).
**Interface assumed.** <names and forms of the build's objects the test relies on; see section 8>.

## Cases
<one line per case ID: input, expected observation, outcome rule>

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | ... |
| **Failure class rule** | ... |
| **Examples** | ... |
| **Negative control** | ... |
| **Positive control** | ... |
| **Break attempt** | ... |
| **Stage and environment** | ... |
| **Independence level** | ... |
| **Evidence layer** | ... |
| **Evidence envelope** | ... |

## Clause table (Appendix C tests only; point 2)
| Clause of the Appendix C entry (verbatim) | Case ID(s) | Or: moved to (stage or plan change) |

## Format gate (format-gate tests only; point 4)
<the "filled but meaningless" example(s), what the database must accept, and the sample review it must land in>

## Could not check
<when this test's own result is COULD NOT CHECK>

## Not covered
<what this test does not show, and why>
```

**What each field must hold.**

| Field | Meaning and what must be in it |
|---|---|
| **ID and claim** | `T-W07-<ID>`, and the single claim the test tests (C0; plan Section 8 item 1). For an F entry, the claim is the designer's addition, drawn from the class rule. |
| **Failure class rule** | The family of wrong states or acts that break the same general rule, not only the example seen. Each example below must be a member of it. |
| **Examples** | At least two different members of the class. One is the original finding (the Appendix C entry's "Original finding", or for a C2 row its first negative), the other a different manifestation. Each example names its case IDs. |
| **Negative control** | The wrong attempt, input or state that is made, planted or looked for, and what must then be observed: refused, with which reason or result. Also that nothing changed: no row, no event, no half state. |
| **Positive control** | The right attempt, with the right authority, that is observed to succeed, so the test is not a check that refuses everything (plan Section 8 item 2). It must differ from a negative case in the one thing the rule tests (W-C02-12 point 7 asks this of the real-token cases; every test follows it). |
| **Break attempt** | Three parts. (1) What is removed: the rule, named as the build's object (a check inside a function, a trigger, a constraint, a privilege). (2) By which path: the patch file under `breaks/`, applied by the harness on the throwaway database (section 5.2). (3) Which example must then pass, or which assertion must then fail, by case ID. A break whose red cases are not named does not count. |
| **Stage and environment** | The stage (C02). The place or places it runs (section 5) and the Supabase project (`devos-test` or `devos`). For a real-token test, also the Claude environment whose token it uses (`devos-calisma`, `devos-denetim`, `devos-sinav` or the installation environment `devos-kurulum`). Also the probes or design facts it relies on. |
| **Independence level** | Who wrote it: the test designer, a fresh-context subagent; its agent ID and type are in W-C02-07's "Record", point 1. Who runs it: the migration job, the build producer at the build's head, the prober of W-C02-13 with its breaks, or for real-token cases the session in each environment. Who assesses the result: a fresh-context checker that wrote none of the tests. What they share: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural, semantic or behavioural (plan Section 8 item 10), and what that layer does not show. A format gate's pass is structural and says nothing of content (plan Section 8 item 12). |
| **Evidence envelope** | Section 4's fields. Name the values fixed before the run (expected outcomes per case, counts, shares, rates, tolerances, numbers of connections and repetitions, each break's red cases). Name where the run records its observation and its raw evidence ID. In C02 the envelope is a form in git (Appendix B line 80). |

## 3. Results, and how "could not check" is counted (point 6)

**Three results per test:** PASS, FAIL and COULD NOT CHECK. They are counted apart. COULD NOT CHECK is never a pass and is always in the denominator (plan Section 8 item 14; PC-16). While any C02 test stands at COULD NOT CHECK, the Acceptance line it serves is not met (W-C02-13 point 6; W-C02-08 point 6).

**Three outcomes per case:** `ok`, `bad` and `could_not_check`. A test is:
- FAIL if any case is `bad`;
- otherwise COULD NOT CHECK if any case is `could_not_check` or there are no cases;
- otherwise PASS.

This order is W-C02-03's.

**Two kinds of "could not check" are kept apart in every point-6 test:**
- **(i) The result of the check under test.** The test plants missing, unreadable or partial input and expects the check to answer "could not check". The case is `ok` when the check answers "could not check", the write or merge it guards is blocked, and that answer differs from the check's clean answer and from its fail answer. The case is `bad` when the check answers clean, or folds "could not check" into fail or into clean.
- **(ii) The test's own result**, when the test could not make its observation (the function is absent, a state could not be planted, a connection failed).

A point-6 test reports, per check, the counts of clean, fail and "could not check" answers it saw, with the denominator.

**Output forms.**
- **The verdict line's name: one rule for every SQL file and program** (phase C; the model is W-C02-03's `W03_DRIFT_DETECTS PASS (n/n)`). `<NAME>` is the file's name without its extension, in upper case: `w07_n01_need_justification.sql` gives `W07_N01_NEED_JUSTIFICATION`, `w07_conc_claim_and_cycle.py` gives `W07_CONC_CLAIM_AND_CYCLE`, and `bin/7scan_test_files.py` gives `7SCAN_TEST_FILES`. No program has a SQL file's name, so every name is one file's. A part that a test reports apart from its own result would add `_PART_<letter>`; no file prints such a line now (T-W07-N04's part T, which once had its own line, is inside the file's result since phase C5, counted by W-C02-10 point 7; CHK-C02-046 C5 (b)). The three lines are `<NAME> PASS (n/n)`, `<NAME> FAIL (b bad, c could not check, of n)` and `<NAME> COULD NOT CHECK (c of n could not be checked)`.
- **SQL files.** One row per case (`case_id`, `outcome`, `detail`), then a final block: PASS raises a notice with its line; FAIL and COULD NOT CHECK raise an exception with theirs. Because FAIL and COULD NOT CHECK raise, the job's step fails and `go` is not `yes` (as `w03_drift_could_not_check.sql`). **Which files the job counts** (phase C5; the executor's decision on CHK-C02-030 C1): the job runs, and gates `go` on, only the files in `supabase/migrations/tests/`. W-C02-07's files are staged in `job/` and reach that folder only as byte-for-byte copies that a build item makes once the file can pass (section 5.1 (c)). So a COULD NOT CHECK or FAIL holds `go` at `no` only for a copied file. A staged file that is not yet copied is not run by the job, and its test stands at COULD NOT CHECK for the Acceptance line it serves until its copy passes; it is never counted as a pass.
- **Programs.** One line per case (`<case ID>`, outcome, detail, separated by a tab or by ` | `), then the verdict line last, with exit codes 0, 1 and 3.

**Before the build exists,** every test gives COULD NOT CHECK, never PASS. Each SQL file starts with a `pg_temp.w07_pre()` that returns the reason when an object it needs is absent (W-C02-03's `w03_pre()`).

## 4. The evidence envelope (plan Section 8 item 9; Appendix B `EvidenceEnvelope`; W-C02-13 point 7)

Each result carries these fields:
- `claim`: the specification's claim.
- `target_commit`: the `main` commit whose migrations are deployed in the project tested. For a job run, the run's `head_sha`.
- `deployment_config_ref`:
  - the Supabase project's name and ref;
  - the server version the database reports (`select version()`);
  - the applied migrations' versions and the deployed function versions, as `deployment_drift` or the history table gives them;
  - the workflow file's blob SHA;
  - for the throwaway database: the image and its version, and the harness's commit.

  Never a secret's value.
- `criterion_version`: the commit that merged this test's files. It must be an ancestor of `target_commit` and of the first commit of the build the test judges (W-C02-07's last paragraph).
- `inputs_ref`: the fixture names and case IDs, all synthetic.
- `transport`: one of
  - `sql-set-role` (SQL with `set role`, the token header simulated with `set_config('request.headers', …, true)`);
  - `data-api-synthetic` (an HTTP call to `devos-test`'s Data API with a synthetic token, section 5.1 (b));
  - `real-token` (`devos`, the environment's own network secret, section 5.3);
  - `throwaway` (section 5.2).
- `observations_ref`: the run's URL, run ID, job and step names; or the harness's output with the patch name; or the session's branch and result file.
- `raw_evidence_ref`: the runner's unedited output, filed under `evidence/C02/raw/`.
- `independence_level`: as the C0 field, with the run's agent ID where an agent ran it.
- `evidence_layer`: as the C0 field.
- `run_at`: UTC.

A result taken on another target or another deployed version closes nothing for this one (plan Section 8 item 9). In particular, a pass in `devos-test` does not close `devos`.

**Raw-output hygiene** (as W-C02-03's README, "Raw output hygiene"). Raw output holds no key, token or password, and nothing derived from one: no hash, prefix, length or masked fragment of a value. Before a raw file is committed, the runner records the method and result of two checks:
- (a) a pattern search: connection strings, URLs with a password, long hex or base64, and both token formats (`shared/token_format.md`, section 7);
- (b) `python3 -I tools/credential_value_scan.py --dir <the raw file's directory>`, recording only its exit code and match counts.

If either check cannot run, the file is "could not check" for hygiene and is not committed until it can.

## 5. The three places a test runs, and what each can show (plan Section 8 item 10)

### 5.1 The migration job's step in `devos-test` (the owner-level path; EV-C02-004 Y-05; EV-C02-001 M25 and P10)

**(a) SQL files.** The copies `supabase/migrations/tests/w07_*.sql` of the staged files (5.1 (c)) are run by the job's test step after the job applies a merge's migrations to `devos-test`, and before it applies them to `devos` (Y-01). The job runs them as `postgres`.

How a file is built (the same as `w03_drift_detects.sql`):
- **Header comment.** The synthetic-data label; the claim; the specification's path; where it runs; the interface assumed; and its safety.
- **Transaction.** `begin;` then `set local search_path = pg_catalog, pg_temp;` and `set local statement_timeout = '60s';` (a longer timeout is stated in the specification). Then a `pg_temp` results table and the cases, then the final block of section 3. Last comes `rollback;`. Nothing is committed.
- **Fixtures.** Every fixture is made inside the transaction, as owner where the rule under test is not the owner's, or through `devos_api` where it is. A synthetic effect class may be planted this way in `devos-test` too, inside the rolled-back transaction, as well as on the throwaway database (the executor's decision; section 8.1, "Effect classes").
- **No `psql` meta-commands**, so a client that does not interpret them runs the file unchanged (EV-C02-001 section 10).
- **No backslash.** No file under `supabase/migrations/tests/`, and so no staged file under `job/` (its copy lands there), holds the character `\` anywhere, so no `psql` meta-command can run with the database password in reach: W-C02-03's migration job refuses to run a test file that holds one (W-C02-03's build; EV-C02-001 section 10). A pattern uses a bracket class (`[[:space:]]`, `[.]`, `[*]`, `[$]`, and `[[:<:]]` and `[[:>:]]` for the word boundaries), a control character is `chr(9)` or `chr(10)`, a character a test needs at run time is built with `chr(...)`, and no E-string is used (phase C3). A program does the same: `chr(...)` for control characters, a bracket class or a look-around in a regular expression.
- **How the job counts it.** The runner runs each file as written, never strips `begin` or `rollback`, and stops it at the first error (`psql -v ON_ERROR_STOP=1`, or a client that does the same). It counts a file as passed only when the file's own PASS notice appears (W-C02-03's T-W03-06, "The runner"). A file that ends without its notice counts as FAIL or COULD NOT CHECK, by the exception it raised.
- **Self-contained.** Each file stands alone: no file includes another, since that needs a meta-command. Each file defines its own `pg_temp.w07_*` helpers.

**Role classes in SQL (`set role`).** A case acts as a role with `set local role <role>` inside its own subtransaction (a PL/pgSQL block with an exception handler), so that a refusal does not end the file and the role is reset after the case. It acts as a role class's token with `perform set_config('request.headers', json_build_object('x-devos-env-token', <token>)::text, true)`, where:
- the token comes from `devos_private.issue_env_token(<class>)`, called as owner inside the same rolled-back transaction (EV-C02-003 §6.3);
- the token is kept only in a PL/pgSQL variable;
- it is never put in a notice, an error text or the results table.

Each such case records `current_user` and `session_user` in its detail. The limits of `set role` (note N-244 item (2)):
- **`session_user` stays `postgres`.** A rule keyed on `session_user` cannot be exercised this way: `deployment_drift`'s branch that admits the migration role's direct login (EV-C02-003 §1.6; EV-C02-004 Y-02) would admit every such call. Such a rule is tested through the Data API (5.1 (b), or W-C02-03's P5), and its specification says so.
- **The token check runs on a simulated header.** The derivation `devos_private.caller_role_class(function_name)` reads `request.headers`, so it is exercised on a header that the test set itself. The case's `transport` is `sql-set-role`, and its record says the header was simulated (W-C02-09 point 3: "a test that simulates it says so in its record"). This shows neither that the Data API passes the header nor that a network secret adds it.
- **Privileges.** `set role` does change `current_user`. So privilege checks (no direct writes, point 5 (a)) and role-class lists inside functions are exercised as the role.

**(b) Programs the job runs: calls through the Data API to `devos-test` with synthetic tokens, and several connections** (note N-255 on `plan/work/C02.md`, the executor's decision; EV-C02-003 §6.3: "for a call over HTTP, it commits them, sends them with the header set explicitly, and revokes them before the run ends"). These cover:
- the real path for each role class (W-C02-09 point 3);
- rules keyed on `session_user`;
- tests that need several connections, or committed state that other connections see (Concurrency);
- a check that reads a repository file against the database (DM47's comparison with the merge gate's list).

They follow these rules (N-255):
- **Where.** Every program the job runs is staged at `tests/C02/W-C02-07/job/w07_<id>_<slug>.py` and runs in the job only as its copy `supabase/migrations/tests/w07_<id>_<slug>.py`, class high: the job holds the migration credential, so a class-normal change must not reach it. The staged file is class normal and reaches the credential only through that high-class copy, whose hash the copying item's checker compares with the staged file (5.1 (c)). A program the job does not run (the point-7 scan) stays under `tests/C02/W-C02-07/bin/`. Python's standard library only; run from the repository root as `python3 -I <path>`, with no arguments, one program at a time. The programs: `w07_5a_exposed_schema.py`, `w07_6tk_http_reasons.py`, `w07_idc_real_path.py`, `w07_dm19b_burst_over_http.py` (Data API); `w07_conc_claim_and_cycle.py`, `w07_dm47_merge_gate_list.py` (database connection).
- **Input** (N-255, with its line "The key's source, decided"). Every program gets the same one JSON object on standard input, with exactly the keys `endpoint` (the project's base URL, `https://<ref>.supabase.co`, with no path: each program appends its own, `/rest/v1/rpc/<function>` for a remote procedure call and `/rest/v1/<table>` for 5A's look at the exposed schemas; a Data API program refuses any other form of it, by name, as COULD NOT CHECK; phase C4a), `apikey` (the publishable key, a string, or `null` while it is not stored), `tokens` (an object from role class to token: `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`, `devos_ci`, `devos_backup`) and `revoked_token` (a token the job revoked before the run). A program reads exactly that form: no input, a value that is not one JSON object, a missing key or any other key gives COULD NOT CHECK, exit 3, naming the key and never a value.
- **Environment** (N-255). The job runs each program under `env -i`, with no environment, unless the program declares, in a line `# w07-needs-database: yes` among its first ten lines, that it needs the step's own database connection settings (libpq's environment). Concurrency and DM47 declare it; the four Data API programs do not.
- **Tokens.** The job, as owner, issues the synthetic tokens in `devos-test` before the programs run and revokes every one after they end, failed or not. A program holding only the publishable key cannot issue them. A program holds the tokens only in memory and sends one in the `x-devos-env-token` header with the publishable key in `apikey`. The publishable key's source is decided (N-255, "The key's source, decided", L-295): Batu stores it as the environment secret `DEVOS_TEST_PUBLISHABLE_KEY` of `migrate-devos-test` in sitting A, and the job passes it as `apikey`. No key is written in the repository. Until it is stored, `apikey` is `null`, and every program that needs the Data API exits 3 with that reason.
- **Database connection.** A program that needs one (Concurrency, DM47) declares it (above) and takes it from the step's own connection settings, libpq's environment, never from a credential on its command line. Without those settings it gives COULD NOT CHECK. It takes no key and no token from the input. Concurrency issues its own synthetic tokens through its owner connection, as the SQL files do, commits them because its other connections must see them, and revokes each by its `env_tokens` row ID before it ends (section 8.1).
- **Could not check.** A program given no input, an input of another form, `apikey` null, or an input without the endpoint or a token it needs, gives COULD NOT CHECK and names what is missing by name, never by value. A database program with no connection settings does the same.
- **Output.** Nothing printed is a token, a header or a key's value; section 3's lines; exit 0 pass, 1 fail, 3 could not check.
- **HTTP method.** It calls remote procedures with `POST`. The Data API runs a `GET` in a read-only transaction, while read functions that record a refusal are `VOLATILE` (N-244 item (2)), so a `GET` case is made only where its specification names its expected result.
- **Fixtures.** Committed fixtures are labelled synthetic (section 6) and listed in the run's output. The executor's decision (Group A's open 2): Concurrency may commit labelled synthetic fixtures in `devos-test`, among them an owner-planted synthetic Decision of class `batu`; EV-C02-002 DM-23 forbids them only in `devos`. They cannot be deleted where the rule makes their family append-only, so the run lists what it left.
- **Interface on W-C02-03's job.** W-C02-03's build gives its runner this interface (N-255). If the job does not run a program, that test's result there is COULD NOT CHECK, and the record says which claim then rests on the real-token runs alone (5.3).
- **Only in `devos-test`: a stated residual (TABLES G19; the executor's call, phase C4a).** N-255's input names no target project, so no program can tell from its input which project it reaches. Concurrency commits labelled synthetic fixtures (above), and EV-C02-002 DM-23 forbids such fixtures in `devos`. That it never reaches `devos` rests on W-C02-03's migration job: the job runs these programs only in its `devos-test` job, the one that holds `devos-test`'s connection settings, and never in the job that applies the migrations to `devos`. W-C02-03's build verdict checks this, from the workflow file and its runs. Nothing is added to the programs' input for it, and no test here shows it (the database programs tell only the harness's throwaway database apart, by `w07.throwaway`).

**(c) Staged, then copied: the files the job counts** (phase C5; the executor's decision on CHK-C02-030 C1, recorded in its log entry and in `TABLES.md` section 7, G29).

*The gate.* The job's test step runs every `supabase/migrations/tests/*.sql` file in that folder, not its subfolders, and counts a file passed only on exit 0 with its PASS notice (`.github/workflows/migrate.yml` lines 708 to 751; the folder at line 716). Its program step runs every `supabase/migrations/tests/*.py` (line 842). `go` is `yes` only if both steps succeeded (lines 920 to 936), and the `devos` job's `decide` step reads that `go` (line 1573). The job runs on every push to `main` and every six hours (lines 13 to 16). Plan line 631: "to `devos` only if the apply, the comparison and the database tests in `devos-test` all succeeded". If W-C02-07's files sat in that folder, `go` would be `no` on every run until the whole C02 build passed all of them. Then each of these would wait on itself (CHK-C02-030 C1; a bare `depends_on` entry means "on: accepted", `tools/records.py` `deps()`):
- (a) W-C02-03 point 5, a synthetic migration the job applies to `devos`, still open (L-303), while W-C02-08 depends on W-C02-03's acceptance;
- (b) W-C02-08 point 1, its objects applied to `devos` after its point-6 tests pass, while W-C02-09 depends on W-C02-08's acceptance and W-C02-10 on W-C02-09's;
- (c) N-221 step 2, the identity chain's first part applied to `devos` before sitting A and before W-C02-09 builds the rest;
- (d) a file that stays COULD NOT CHECK after the item that builds its rule (a hook of section 8.1 not yet filled, a case left to a later item).

*Decided: staging.*
- Every W-C02-07 SQL file and program is staged in `tests/C02/W-C02-07/job/`, which the job does not read. Its copy takes the path `supabase/migrations/tests/<the same name>`. What the header comments say of that path (CHK-C02-046 C5 (c)):
  - **SQL files.** No SQL file's header names its own copy's path. Each of the 39 headers [40 since 2026-10-19, with `w07_n29_mission_widening.sql` (N-284), whose header does the same] names the two places the file runs, in its "Runs:" or "Where it runs:" statement: the migration job's `devos-test` test step, which runs only the copy, and the break harness's throwaway database, which runs the staged file (5.2). Four headers name their program half by that program's copy path, `supabase/migrations/tests/w07_<name>.py`: 6TK, DM19B, DM47's path table and IDC.
  - **Programs.** Each of the six programs' docstrings gives its run command with its copy's path, `python3 -I supabase/migrations/tests/<the same name>`. DM47's also names its staged run.
  - A copy is the staged file byte for byte, so these comments read the same in both. Each says where the file runs, not which of the two files it is. The move from `supabase/migrations/tests/` changed no file's content; phase C5's changes for CHK-C02-030's other conditions are on top of it, each named in `TABLES.md`.
- Each build item's pull request copies into `supabase/migrations/tests/`, byte for byte, exactly the staged files whose rule it completes, as the table below gives them from each test's "Serves" line (point 8). Its checker compares each copy's SHA-256 with the staged file on `main` at the copy's commit. A copy that differs is a FAIL of that build's check. The staged file stays on `main` as it is, so git order still shows each test written and merged before the build it judges (W-C02-07's last paragraph).
- A file is copied only when it can pass. A file whose cases stay "could not check" after an item's build (a hook not yet filled, a case that needs a later item's part) is copied by the item that completes it. Where the test designer fills a hook (section 8), that revision is merged into the staged file before the copy is made. If a file can pass earlier, the earlier item its "Serves" line names may copy it. If it cannot pass on the item's build the table names, that item's record lists it with the item that will complete it and does not count it (W-C02-08 point 6), and that item copies it.
- A copy, once made, stays in the job's folder. A later change that turns it FAIL or COULD NOT CHECK sets `go` to `no` and keeps that change out of `devos`, which is the gate this decision keeps. A copy is never edited in place. A test changes in its staged file, by the test designer, before any result of the build it judges, or under ledger rule 3 after one (section 8), and is then copied again.
- W-C02-13 runs every staged file with its breaks, copied or not: the harness reads the staged files (5.2).
- The job's own interface does not change: input on standard input, `env -i` unless the declaration, the database line, and exit codes 0, 1 and 3 (5.1 (b)).

*What this keeps and what it removes.* Plan line 631 holds, with "the database tests" being the files in the runner's folder: `devos` receives a change only after the apply, the comparison and every copied test in `devos-test` succeed. The four waits go:
- (a) At this item's merge the job's folder holds only W-C02-03's `w03_*` files, so W-C02-03 point 5's synthetic migration is gated by W-C02-03's files alone.
- (b) W-C02-08's pull request copies the two files it completes. Its objects reach `devos` once those pass in `devos-test`, so W-C02-08 can be accepted before W-C02-09 starts. W-C02-09 and W-C02-10 do the same. For this, phase C5 moved T-W07-5A's positive control, which needs W-C02-09's `relate`, into its own file, `w07_5a_positive_control.sql` (as T-W07-N08 has two files). Otherwise W-C02-08 could either show 5A's negatives in `devos-test` (W-C02-08 point 6) or keep `go` open, but not both.
- (c) The identity chain's first part (N-221 step 2) reaches `devos` the same way (CHK-C02-046 C3). The pull request that merges the first part, whichever item makes it, copies `w07_idc_identity_chain.sql` (T-W07-IDC part A), the test of the first part, and no file that the first part does not complete. So `go` rests on that file's PASS in `devos-test` and on the files copied before it, and that file is the test that N-221 step 2's "runs its tests there" names. It is not copied with `w07_idc_real_path.py` (part B): part B waits for the publishable key (sitting A; with `apikey` null it exits 3, which would hold `go` at `no`), and W-C02-09 copies it once the key is stored.
  - **Every case of part A can pass on the first part alone** (the designer's reading of the file, not a run: no first-part build exists). Its pre-check (`w07_pre`) needs exactly the first part's objects: `env_tokens`, the epoch's table, Event, RejectedAttempt, `caller_role_class`, `token_role_class()`, `issue_env_token`, `revoke_env_token`, and the role `anon`. Its other four table names (`review`, `verdict`, `work`, `eval_run`, in `w07_cfg`) are used by no case. Its cases `IDC-s1` to `-s4`, `-i-*`, `-f1`, `-d-*`, `-n-*` (with `-n-acl`) and `-r1` to `-r3` use only those objects. `IDC-v1` reads every table there is, and `IDC-e1` calls every `devos_api` function there is, so on the first part they cover the first part's own. So no case is named here as one that cannot pass on the first part alone.
  - **If the first part's run still leaves a case COULD NOT CHECK,** no other test stands in for it. N-221 step 2 is then not met until `w07_idc_identity_chain.sql`, whole, passes as its copy in `devos-test`. The first part does not reach `devos` before that. The build is fixed, or, if the test is wrong, the test designer revises the staged file under section 8 and ledger rule 3 (the earlier result is void), and the file is copied again. Copying no file, so that step 2 is met by an empty set, does not meet it.
- (d) A file that cannot pass yet is not copied.

*What it costs, stated.*
- A test reaches the job only through a high-class copy that a build item makes. A copy that is never made leaves its test unrun in `devos-test`, so the test stands at COULD NOT CHECK for its Acceptance line. Each build item's record lists its copies. W-C02-13 point 1 ("every test W-C02-07's record lists was run") reads the table below.
- A staged file is class normal (`tests/**`) and runs only on the harness's throwaway database, with no credential. It reaches the migration credential only through its high-class copy.
- Time: none on the critical path. Copying is part of each build item's pull request (plan 6.12 item 1: the decision is the executor's, 2026-10-12, with no plan reason to check against Batu's later decisions).

*The copies, by the item expected to complete each file* (from `TABLES.md` section 4's "Serves"; for a file that serves two items, the later; one exception, `w07_idc_identity_chain.sql`, which the identity chain's first part completes before W-C02-09 builds the rest, bullet (c) above):

| Copied by | Staged files (`tests/C02/W-C02-07/job/`) |
|---|---|
| The pull request that merges the identity chain's first part (N-221 step 2) | `w07_idc_identity_chain.sql`. Not its real-path program `w07_idc_real_path.py`, which waits for the publishable key (W-C02-09's row) |
| W-C02-08 | `w07_5a_no_direct_writes.sql`, `w07_dm02_revision_append_only.sql` |
| W-C02-09 | `w07_5a_positive_control.sql`; `w07_5c_other_session_fake_id.sql`; `w07_6rg_rule_gate_could_not_check.sql`; `w07_6tk_token_reasons.sql`; `w07_dm07_heartbeat.sql`; `w07_dm19_rejected_attempt_survives.sql`; `w07_dm19b_burst_count.sql`; `w07_dm34_mission_scope.sql`; `w07_f01_whole_intent.sql`; `w07_f04_affected_records.sql` (once G21's `installation_mission` hook is filled); `w07_f05_scope_both_sides.sql`; `w07_f06_state_change_event.sql` (once G20's recipes are written); `w07_f07_observation_history.sql`; `w07_f08_recheck_at_effect.sql`; `w07_k05_many_paths.sql`; `w07_n09_finding_gate.sql`; `w07_n17_claim_token.sql`; `w07_n25_verdict_staleness.sql`; `w07_n29_mission_widening.sql` (T-W07-N29's second file, N-284, 2026-10-19: the corrective migration's pull request copies it); `w07_rel_relation_status.sql`; the programs `w07_conc_claim_and_cycle.py`, and, once the publishable key is stored (sitting A; with `apikey` null they exit 3), `w07_5a_exposed_schema.py`, `w07_6tk_http_reasons.py`, `w07_dm19b_burst_over_http.py`, `w07_idc_real_path.py` |
| W-C02-10 | `w07_5b_authorization_matrix.sql`; `w07_5d_format_gates_empty.sql`; `w07_6st_settings_could_not_check.sql`; `w07_dm11_answer_revision.sql`; `w07_dm47_path_table.sql`; `w07_fgfind_finding_gate.sql`; `w07_n01_need_justification.sql`; `w07_n02_decision_alternatives.sql`; `w07_n03_effort_policy.sql` (hook `installation_mission`); `w07_n04_self_approval.sql`; `w07_n08_exam_records.sql`; `w07_n08_exam_fact.sql` (W-C02-09 may copy it if every case passes on its build); `w07_n28_verifier_does_not_repair.sql`; `w07_n28_sample_exemption.sql` (hooks `sample_marker_unreadable`, `sample_marker_partial`, `take_sample`); `w07_n29_impact_class.sql`; `w07_roc_ownership_and_claim_class.sql` (hooks `installation_mission`, `transferred_relation`); `w07_t31_planted_rate.sql`; the program `w07_dm47_merge_gate_list.py` |
| W-C02-12, W-C02-14 | None. `T-W07-RT` and `T-W07-6SC` are procedures, and W-C02-14's tests are its own (point 13) |

The harness scenarios (`harness/scenarios/`) are never copied: they commit, so they run only on the throwaway database (5.2).

**What 5.1 can show.** Structural behaviour of the SQL deployed in `devos-test`:
- each refusal and its record;
- each positive control;
- the catalogue.

**What it cannot show:**
- that the same rule holds in `devos`, a separate target whose deployment `deployment_drift` compares (W-C02-08 "Not covered" (d));
- in (a), the header path and `session_user`-keyed rules;
- the real environments' network secrets;
- whether a test fails when its rule is removed (5.2);
- any content's meaning.

### 5.2 The throwaway database: the break harness (plan Section 8 item 3 as PC-42 place 3 writes it; EV-C02-002 §5 and DM-39)

A database rule is broken only here, never on `devos-test` or `devos`. The harness:
- **Builds a fresh database per break run.** It is PostgreSQL 17, the projects' major version: `devos` runs 17.6, observed 2026-10-12. A run on another major version, such as the session container's 16.15, is a self-check that never counts (the executor's decision; the harness labels it `counts: no`). If `devos-test`'s version, not yet observed, differs, each version is run (EV-C02-002 §5 and §14). The database is built from `supabase/migrations/` at the commit under test, in a container or on a CI runner. The session container's PostgreSQL 16.15 serves only the test designer's self-checks, which never count as results.
- **Holds no credential to `devos-test` or `devos`** (EV-C02-002 A2 item 3), and refuses to run against anything but its own local database.
- **Supplies what Supabase supplies and the migrations use** (N-244 item (2): the throwaway database lacks Supabase's roles and request settings). It creates each as a labelled stand-in before applying the migrations, and lists them in its output:
  - the roles `anon`, `authenticated`, `authenticator` and `service_role`, as stand-ins without login;
  - a login named `postgres`;
  - any schema or extension the migrations need, such as `extensions`.

  It never creates `supabase_admin`, because W-C02-03's break patches refuse to run where that role exists. Request settings are absent there. A test sets `request.headers` itself (5.1 (a)), so `transport` is `throwaway`.
- **Owns the database.** It issues synthetic tokens of its own, sets the sample block to 1 where a test needs every record sampled (EV-C02-002 §5), and writes synthetic fixtures, all of which disappear with the database.
- **Sets marker settings.** It sets `w07.throwaway = 'yes'`, and `w03.throwaway = 'yes'` for W-C02-03's breaks (T-W03-06 and T-W03-07 name "W-C02-07's break harness"), as database settings before the tests connect.
- **Runs a break in this order:**
  1. **Positive control.** The unpatched database runs the named test files. Each must PASS, or give COULD NOT CHECK before the build exists.
  2. **Break.** A new database gets exactly one patch, and the same files run. The cases that turn `bad` must equal the patch's `expect-red` list; every named file that holds one of them must end in FAIL; and every other named file must end as it did in the positive control (phase C5, CHK-C02-030 C3: W-C02-03's B3 and B4 each leave one of their two files green). A failure from anything else (a missing object, a syntax error, a lost connection) is not a break shown (W-C02-13 point 3).
  3. **Restore.** The unpatched database is run again.

**How a break patch is built** (as W-C02-03's `breaks/B4_could_not_check_as_clean.sql`):
- **Header.**
  - The first line names the test and the example that must turn red, in a machine-readable form: `-- w07-break: test=<file>[,<file>]; expect-red=<case IDs>`. A bare file name is a staged file of `tests/C02/W-C02-07/job/`, or else a file of `supabase/migrations/tests/` (W-C02-03's), so the harness runs the staged file whether or not it has been copied (5.1 (c); phase C5); a path is from the repository root, except that a path `supabase/migrations/tests/w07_<name>`, which thirteen patches written before the staging use, also means the staged file `job/w07_<name>`. A program named there (Concurrency, DM47) is run by the harness as the job runs it (section 5.1 (b)): N-255's one JSON object on standard input, its four keys null or empty, and, because the program declares `# w07-needs-database: yes`, the throwaway database's socket as its only libpq environment (a program without the declaration would get no environment at all).
  - Then the rule removed and the synthetic label.
  - No `psql` meta-command.
- **Guard block.** It raises unless `current_setting('w07.throwaway', true) = 'yes'`, and raises if `supabase_admin` exists. The guard covers the whole change (CHK-C02-017's condition C1): either the change is inside the guard's block, or the patch runs as one transaction (`begin;` before the guard, `commit;` last), so that a refused guard aborts everything after it, whatever the client does after an error.
- **Wrappers.** A patch that wraps a build function keeps its parameter types and order (section 8.1), so that a call by position still binds. Group A's and Group C's wrappers name their parameters differently from section 8.1 (for example `p_claim_token`, `p_operation`); the tests that reach them call by position, so a call by name to a wrapped function is not assumed to bind.
- **The change.** It removes one rule and no more. For example, it renames the build's function and wraps it so that one check is skipped, or drops one trigger, constraint or privilege revocation. It holds as little of the build's logic as it can, so the test cannot pass by copying the build.
- **Location.** It sits outside `supabase/migrations/`, so no job ever applies it.

**Programs against the harness.** The programs of 5.1 (b) run against the throwaway database only for breaks of rules they test there: Concurrency's and DM47's, which use a database connection. The Data API programs do not run there; their rules' breaks are shown by the SQL test of the same rule. The specification says which assertions hold on each transport.

**What 5.2 can show.** That a test turns red when its rule is removed, and green again when it is restored. Also the test designer's self-checks of the test's own logic.

**What it cannot show:**
- that the build in either project passes (a pass here is never a pass of the build);
- anything about Supabase's roles, the Data API or the network secrets;
- that the patch removed the rule in the form the build deploys, beyond what the red cases show.

### 5.3 The real environments' tokens in `devos` (W-C02-12; EV-C02-003 §1.5, §6.2; EV-C02-002 §5 and A1 item 7; EV-C02-004 X-10)

The real-token tests run in `devos`, each environment's real token tried from inside that environment. These runs come from:
- one session in each of `devos-calisma`, `devos-denetim` and `devos-sinav`, opened by Batu ("Batu's steps" row 5);
- the installation environment `devos-kurulum`, with the `devos_kurulum` token;
- the pull-request checks, for the `devos_ci` key.

Each call is a Data API remote procedure call to `devos`, with the publishable key in `apikey`. The proxy adds the network secret's header. The session never sees or sends the token itself, and records only role classes, outcomes, reason codes and counts (EV-C02-003 §6.2).

The fixtures are written beforehand through `devos_api` with the `devos_kurulum` token, under the test Mission of EV-C02-002 DM-23, and labelled synthetic. No synthetic record of class `batu` is written into `devos`. No rule is broken in `devos`. A real-token case's break is the break of the 5.1 test of the same rule, shown in 5.2 (W-C02-12 point 8). Each real-token case names that test.

**The rules every real-token case follows** (W-C02-12 point 7):
- Each ✘ case differs in one thing from an accepted ✔ case.
- The first call in each session is that session's positive control (W-C02-12 point 4).
- A refusal for another reason (no network, no header, a missing function) is COULD NOT CHECK, never a pass.
- A case made within one session by declaration only (one session using one claim's token on another claim's work) is labelled so and not counted as the real-session case (EV-C02-003 §6.2, last item).

**What 5.3 can show.** Behavioural evidence of the configuration:
- each token is stored in its environment;
- the proxy adds the header;
- the database derives the right role class from each real token;
- each environment is refused another's authority on live state.

**What it cannot show:**
- breaks;
- a second real session in one environment;
- that a session cannot read its token beyond the places scanned (EV-C02-003 §3.2, "Limits");
- `devos_backup`, which has no credential before C09 (EV-C02-003 §5.4);
- the control surface between environments (C03 test 3).

## 6. Synthetic data and nothing secret (point 7; plan Section 8 item 13; plan 6.3)

**Synthetic data.**
- Every fixture, example and input is made up for the test, holds no personal or business data and nothing from Batu's other repositories or accounts, and is labelled synthetic in its file. The first line of every specification and the header of every SQL, break and executable file says so (section 2's template).
- **Names.** Fixtures use the prefix `w07_fixture_` (tables' text fields, slugs, titles), and text fields carry the words `SYNTHETIC W-C02-07`.
- **Committed fixtures** (5.1 (b), 5.3) carry the scope or label the design gives synthetic records (`synthetic`, EV-C02-002 DM-23; EV-C02-004 X-10).
- **No real names.** No file names a real person, company, repository other than `devos`, account, host other than the projects' own, or library text (`CLAUDE.md`, "Public repository").

**No token or key value in any file.**
- No file holds a string of the environment token's format or of the claim token's format (EV-C02-003 §1.3 and §1.7).
- A test that needs a well-formed token gets one at run time:
  - from `issue_env_token` or `claim`, inside its transaction (5.1 (a)) or in memory (5.1 (b));
  - a well-formed but unknown token, by changing one character of the random part of an issued token at run time;
  - a malformed token, by cutting or altering an issued token at run time.
- Only `shared/token_format.md` and the scan's pattern file name the literal markers (section 7). Other files refer to them by that path.
- No test prints, stores or compares a token's hash, prefix, length or masked form. A case compares outcomes, role classes and reason codes only.
- Tokens reach a test only by the routes W-C02-05 designs:
  - the owner-level path in `devos-test` (EV-C02-003 §6.3);
  - the network secret in `devos` (§1.1);
  - the `devos_ci` repository secret (§5.2).

  A token is never asked for, pasted or put in a variable.

**The scan of point 7** (owner: `GROUPS.md`). Its subject is the files of this directory, the staged files in `job/` among them, and any copy `supabase/migrations/tests/w07_*` (5.1 (c)), at the head that adds them. It applies:
- the guard's credential patterns: `REDACT` and the expansions of `CREDENTIAL_VARS` in `.claude/hooks/tool_allowlist.py`;
- both token formats;
- `tools/credential_value_scan.py`.

It is first shown to catch a planted synthetic string of each token format, and of each guard pattern, in a scratch copy outside the repository. Its result is worded "none found by the scanned patterns", never "no secret". A file it cannot read makes it COULD NOT CHECK. A hit is classified as a name or a value, and its classification rule is fixed before the run.

## 7. Shared definitions

- **The literal markers of both token formats.** EV-C02-003 §1.3 and §1.7 leave the markers to W-C02-07, "when it writes its scan". They are fixed once, in `shared/token_format.md`, by the group that owns the scan. W-C02-09's issuing function and the guard's stop of the token formats take them from there; that stop is W-C02-20's (`plan/work/W-C02-20.md`), no longer W-C02-11's. They are checked against the guard's existing patterns, so that neither marker is caught or masked by an unrelated pattern.
- **The break harness** (5.2) is written once, by the group named in `GROUPS.md`. Other groups write their patches to section 5.2's form and list their files in their patches' `w07-break` lines.
- **SQL fixtures are not shared.** Each SQL file makes its own, since no file can include another. Helper functions use the `pg_temp.w07_` prefix. A group that wants a common helper copies it and names its source.

## 8. Interfaces with the build

Where the design leaves a name or a form open, the specification states the interface it assumes under "Interface assumed". Examples: a function's signature, a reason code's spelling, the read marker's form, the sample-stream table, the path-list table.

Section 8.1 states the one interface every file assumes. If the build chooses another form, the test designer revises the test before its first result. The revision is merged before the result it judges, the build item's record shows the change in its `git diff` of the test files (W-C02-08 point 6), and the builder never adapts a test. After a result of the build has been seen, a test is changed only under ledger rule 3, with the earlier result void and the test repeated, by the executor's decision (Appendix G G8 item 3).

### 8.1 The assumed interface, version 1 (phase C)

Line numbers are at `7f7fef1`, the `main` commit this branch carries since phase C4b (merged into the branch at `e1d7b4b`; B is `plan/Ek_B_Veri_Modeli.md`, EV2 and EV3 are EV-C02-002 and EV-C02-003, EV8 is EV-C02-008). Phase C1 cited `b679568`; PC-44's insertions moved B's lines from 116 on, and phase C3 renumbered them to `11feac5`. Between `11feac5` and `a98ea48`, B changes only its line 246 (PC-46 place 1), so no B line moves; EV2 gains two lines after its line 305 and EV3 two after its line 299 (EV-C02-008's dated pointer lines), so EV2:481 became EV2:483, and EV3:506, 1280 and 1310 became EV3:508, 1282 and 1312 (phase C4a). Between `a98ea48` and `7f7fef1`, B changes its lines 247, 286 and 478 in place (PC-47), so no B line moves; EV2 gains one line after its line 147 and one after its line 285 (EV-C02-008 5.3's pointer lines after DM-08 and DM-35), so EV2:207, 288, 294, 304 and 483 are now EV2:208, 290, 296, 306 and 485; EV3 is unchanged (phase C4b compared each cited line's text at both commits). This is the one form every specification, SQL file, program, break patch and the harness assume. Phase C fixed it from the four groups' assumptions. Each entry says where it comes from: **fixed** (a design source names it; the line is cited) or **chosen** (no source fixes it; the reason is given). Everything chosen is an assumption about the build, not a requirement on it: if W-C02-09 or W-C02-10 builds another form, the tests are revised before their first result (section 8, above).

**Schemas.** `devos_api` holds the functions the Data API exposes (fixed: Appendix B section 4's heading). `devos_private` holds the tables and the private functions (fixed for `issue_env_token`, B:47; `caller_role_class`, EV3:158; `function_deployment`, B:405; chosen for the other tables, which no source places).

**Tables** (all in `devos_private`; the field names are Appendix B section 3's).

| Record | Table | Source |
|---|---|---|
| EnvToken | `env_tokens` (`id`, `role_class`, `token_hash`, `issued_at`, `revoked_at`) | Fixed: B:375 (fields), B:377 (`env_tokens`) |
| The global authority epoch | `global_authority_epoch`, one row, integer column `epoch` | Chosen. B:23 names the counter `authority_epoch` and EV-C02-002 DM-01 makes it one row with its lock; no source names the table. Reason: EV-C02-004 T-4 (EV2:485) keeps "the global authority epoch", the row, apart from the claim's own field `authority_epoch` (B:154), so the table's name carries "global" and its column is not called `authority_epoch` |
| Event | `event` | Fixed: B:16 ("produces an event (`event`)") |
| RejectedAttempt | `rejected_attempt` | Chosen. B 3.13 (B:270) and EV2 DM-19 name the record, not its table. Reason: the singular form B uses for `event` (B:16) and `assignment` (B:22) |
| Every other family | its singular name: `work`, `assignment`, `operation`, `observation`, `relation`, `artifact`, `mission`, `need`, `decision`, `finding`, `effort_policy`, `review`, `verdict`, `acceptance`, `eval_run`, `effect_class`, `sample_stream`, `high_impact_path`; a family's revisions in `<family>_revision` | Chosen, by the same rule (`assignment` is B:22's) |
| The effect classes (DM-37's server table) | `effect_class`'s columns: `effect_class` (`text`, the class's key, one row per class), `irreversible` (`boolean`), `mandatory_read_set` (`text[]`, the mandatory elements of the class's read set). A test plants a synthetic class with all three and finds it by `effect_class` | Chosen. EV2:296 (EV-C02-002 DM-37 (a): "per class, whether it is irreversible and the mandatory elements of its read set") and B:258 name the table's content, not its columns. Reason: the key keeps the name of the Operation's field that holds the class (`effect_class`, B:252), by this table's rule that field names are Appendix B section 3's; the other two name DM-37's two facts. It is the form of Group A's helpers v1 (`pg_temp.w07_effect_class`), of Group B's T-W07-F06 and of T-W07-F01's interface. Group C's helper (`pg_temp.w07_effect_classes`, copied into its 13 job files and 3 harness scenarios) keyed the class by `name` and planted no read set until it was aligned on 2026-10-13, before any result: with two keys, one group would have ended "could not check" on every build. If W-C02-09 (which builds DM-37's read set by operation type, its point 1) or W-C02-10 (which reads `irreversible`, its point 4), or the item whose migration creates the table, names other columns, the test designer revises every test that plants or reads the table before its first result (section 8, above) |

**Owner-only functions.**
- `devos_private.issue_env_token(role_class text) returns text`: the token, returned once; only its hash is stored. Fixed: B:47 (`issue_env_token(role_class)`, "returns the token once and stores only its hash"); EV3:508 (`issue_env_token('devos_kurulum')`).
- `devos_private.revoke_env_token(<the env_tokens row's id>)`: sets `revoked_at` and increments the global authority epoch (fixed: B:47, B:377). Its argument is **chosen**: no source fixes it (B:47; EV3:117 says only that one token can be revoked alone). Reason: the token exists only in its secret (EV3:146), so Batu, who revokes in `devos` (PC-43 place 6), holds no value to pass; and a value in a statement's text can reach Postgres logs, which "can keep statement text and error details" (EV3:1282; EV3:229). The argument has the type of `env_tokens.id`, and a test passes it as an untyped literal. A test finds the ID as the row its own issue added (the rows marked before the issue, read after it); it never reads, compares or keeps a hash.

**`devos_api` functions: answers.**
- Every function returns one `jsonb` object (chosen: one answer form over SQL and over the Data API).
- **Accepted:** `{"status": "ok", ...}`. A call that writes a record carries its `id` (and `revision` where the family has revisions); `claim` carries `claim_token` and `assignment_id`; `token_role_class()` carries `role_class`; `ready_works()` carries `works`; `affected_entities` and `explain_paths` carry `records` or `paths`, and `complete` (chosen).
- **Refused:** `{"status": "refused", "reason_code": "<code>", "reason": "<text>"}`, returned, never raised, so that its RejectedAttempt record commits. Fixed: EV2:208 (DM-19 (a): "on a refusal it rolls that block back, writes the record and returns the refusal"); B:270. The keys are chosen.
- **Could not check:** `{"status": "refused", "reason_code": "could_not_check", "reason": "<the input that could not be read>"}`. Fixed in substance by W-C02-09 point 7 (the check "refuses the write ... and records 'could not check' with its reason"); the form is chosen. It keeps the three answers apart: clean (`ok`), fail (`refused` with any other code) and could not check.
- **An answer outside this form** (a raised error, another status, no object) is never a pass. Groups A, C and D make the case the test's own COULD NOT CHECK. Group B's helper also reads direct writes, where a privilege's raised error is the refusal under test (T-W07-5A, T-W07-DM02), so it reads any raised error as a refusal; for its function calls that shows only that the write was blocked. T-W07-DM19 is the test that fails a refusal that is raised.

**`devos_api` functions: parameters.** Parameters are named. Over the Data API a call is `POST /rest/v1/rpc/<function>` whose JSON body's keys are the parameter names (EV3:108: a session calls a function as a Data API remote procedure call); in SQL a test calls positionally or by name.
- **Where Appendix B section 4 names them, those names** (fixed): `claim(work_id uuid, declared_session_id text)` (`claim(work_id)`; `declared_session_id` is Assignment's field, B:154); `affected_entities(root uuid, limits jsonb)`; `explain_paths(root uuid, target uuid, limits jsonb)`; `token_role_class()`; `deployment_drift(expected jsonb)`.
- **Chosen everywhere else.** Reason: no source fixes these forms; this is the form most of the four groups' files and break patches already used, and were self-checked on; and it keeps a record's fields, among them a format gate's "absent" field, in one object. The alternative, one named parameter per field, is equally open to the build, and would be a revision of the tests before their first result.
  - A function that writes a new record, or a new revision, of one family takes the record's fields as one parameter `p jsonb`: `open_mission`, `revise_mission`, `record_need`, `admit_work`, `revise_work`, `relate`, `open_decision`, `set_effort_policy`, `record_finding`, `open_review`, `record_observation`, `record_eval_run`, `record_verdict`.
  - A function that acts under a claim takes the claim token first, as `claim_token text` (EV3:170: "`heartbeat`, `release` and every effect take it as a parameter"): `register_artifact(claim_token text, p jsonb)`, `prepare_operation(claim_token text, p jsonb)`, `record_attempt(claim_token text, operation_id uuid)`, `heartbeat(claim_token text)`, `release(claim_token text)`.
  - A function that changes the state of one existing record takes its identifier and the new values: `revoke_claim(assignment_id uuid, reason text)`, `accept(verdict_ref uuid, accepted_use text)`, `review_finding(finding_id uuid, revision integer, status text)`. An identifier parameter is named `<record>_id` (`operation_id` in `record_attempt` and `operation_state`), never otherwise; a record's own field keeps Appendix B section 3's name (`operation_ref` in an Observation's payload, B:254). By the same rule, with a reason as the only new value (phase C3, for T-W07-F06's recipes; chosen): `resolve_need(need_id uuid, reason text)`, `mark_stale(work_id uuid, reason text)`, `cancel_work(work_id uuid, reason text)`, `reopen_for_review(work_id uuid, reason text)`, `retract_relation(relation_id uuid, reason text)`.
  - **The ledger transfer's functions** (Appendix B section 4's row "Ledger transfer", B:397, added by PC-44 place 10 at `11feac5`): `begin_transfer_run`, `transfer_mission`, `transfer_work`, `transfer_relation`, `transfer_decision`, `transfer_review`, `transfer_acceptance`, `transfer_need`, `transfer_finding`, `transfer_artifact`, `transfer_event`, `end_transfer_run`, `record_handover`, `record_ledger_entry`. Each writes records or events, so by the rule above each takes `p jsonb`. Their payload keys are W-C02-09's interface record's (`evidence/C02/EV-C02-013_w09_interface.md` section 3; until it, no source named them: EV-C02-005 section 12 names the functions only). Their role class is fixed ("Only `devos_kurulum`", B:397; in EV-C02-003 §4.1's terms, EV8 1.7.3): T-W07-5B's row R19, at the gate; what follows the `ledger_handed_over` event is a check after the gate. Their own tests, after the hand-over among them, are T-W14-FN's (`tests/C02/W-C02-14/T-W14-FN_transfer_functions.md`), judged with W-C02-09 (W-C02-09 point 10; EV-C02-005 section 15 S5: "tested before use; not left to W-C02-14"; note N-277); W-C02-14 point 13's prober may run them again, and the transfer as a whole (N18) is W-C02-14 point 13's. [Revised before any result, EV-C02-013 D-12, 2026-10-17: this sentence said the functions' tests were W-C02-14 point 13's, against S5 and W-C02-09 point 10; CHK-C02-075 finding 2 (g).]
    - **The payload keys T-W07-N02 and T-W07-N04 send, each chosen** (phase C5, CHK-C02-030 C5 and C6; stated here by CHK-C02-046 C4). Four of the fourteen are called, with accepted calls, by `job/w07_n02_decision_alternatives.sql` (`n02_transfer`) and by `job/w07_n04_self_approval.sql` (part T).
      - *Reason:* no source names a payload key of these functions (EV-C02-005 section 12 names the functions only). So each key below is **chosen**: it names the field of the record or event that the design says the call writes.
      - *Sources:* EV-C02-005 2.4, for the Review, Verdict and Acceptance copies' fields; 2.2, for a transferred decision written in the status its record holds; and section 15 S1, for the `transfer_run` event's payload and the `transferred` event's `transfer_source`.
      - *Revision rule:* if W-C02-09 names other keys, the test designer revises every file that sends these keys before its first result (section 8, above). Until then, a positive call that is not accepted with these keys makes its case and its pair the test's own `could_not_check`, never a pass or a fail.
      - `begin_transfer_run`: `run_id`, `input_commit` (40 hexadecimal characters), `manifest_sha256`, `counts` (an object, per kind), `phase` (`begun`), `mode` (`ahead` in N02, `verdict_copies` in N04). These are S1's `transfer_run` payload, key for key.
      - `transfer_decision` (N02): the Decision fields that N02's `open_decision` calls send (`class`, `question`, `why_this_owner`, `options`, `alternatives_considered`, `alternatives_state`, `criteria`, `evidence_refs`, `assumptions`, `premises`, `reversibility`, `reopen_triggers`, `recommendation`, `recommendation_rationale`). Then `status` (the recorded status, `answered`; 2.2), `single_viable_path_reason` (the positive case only), `run_id` and `transfer_source`.
      - `transfer_review` (N04): the Review copy's fields of 2.4: `kind`, `claim`, `target_ref`, `criterion`, `basis_refs`, `reviewer_declared_session`, `independence_level`, `use`. Then a `verdict` object with the Verdict's fields of 2.4 (`result`, `objections`, `evidence_refs`, `limits`), `run_id` and `transfer_source`. It sends no `reviewer_role_class`: 2.4 takes it "from the token".
      - `transfer_acceptance` (N02): `run_id`, `target_ref`, `review_ref` (the Review copy it names; 2.4: it "refuses when the Review copy it names is missing"), `accepted_use` (`installation_acceptance`), `scope` (`installation`), `current_evidence` (an array naming the Review copy) and `transfer_source`. It sends no `owner_authority` (2.4: D-010's Decision).
      - `transfer_source`, sent in every call but `begin_transfer_run`: S1's object, with `kind`, `source_id`, `path`, `input_commit`, `last_commit` and `sha256`.
    - **T-W07-F06's recipes for the fourteen** (`TABLES.md` G20). For each state-changing function, F06 needs a recipe: an accepted call whose event it checks, and that call's exact repeat (F06-r3, F06-p1). [Revised before any result, EV-C02-013, 2026-10-17: the recipes are filled from W-C02-09's interface record (section 3.2, with `mark_exported` and `link_prior_decisions` from sections 2.8 and 2.2). F06 builds the order they need itself: an open run and a second run for `end_transfer_run`, made before the loop; `transfer_mission`'s call makes the installation's Mission, the calls that need it run after it, and `record_handover`, which closes the path, runs last. The first version of this paragraph left the order to W-C02-14 point 13's tests and kept the fourteen "could not check".]
  - Identifiers are `uuid` (chosen; Appendix B fixes no type; a test compares them as text).
- **Reads the tests need that Appendix B section 4 does not name** (fixed, phase C4a): `operation_state(operation_id uuid)`, returning the Operation's `status`, `ever_applied` and `current_effect` (T-W07-F07's current state; EV8 1.7.2: "it does not rename it"), and `read_rejected_attempts(since timestamptz)` returning `{"status": "ok", "rows": [...]}` (T-W07-DM19B part B; the `devos_denetim` read of RejectedAttempt, EV3 §4.1; EV8 1.4: "The build may add arguments with its reason; it does not rename it"). Both carry the read marker (DM-36). The readers of T-W07-5B's rows R10r, R12, R13 and R14 are W-C02-09's to name (EV8 1.4) and sit in that test's `w07_fn_cfg`: named by EV-C02-013 section 4 (R10r `read_eval_run`; R12 `read_review`, `read_decision`, `authority_epoch`; R13 `fingerprint_matches`) and filled before any result; R14's move to C03 waits for note N-279 (9) on `main`.
- **Role classes of the functions EV3 §4.1 has no row for** (fixed, phase C4a): EV8 1.2 decides the ten N-256 named (`ready_works`, `relate`, `retract_relation`, `affected_entities`, `explain_paths`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `review_finding`), 1.7.2 `operation_state`, 1.7.3 the ledger transfer's fourteen, and 1.7.4 `set_effort_policy` at the gate (`devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`; EV3 §4.1's effort row kept as an operation row after the gate). T-W07-5B's rows R08g, R15, R19 and R20 to R26 hold them. The qualifiers after the gate are EV8 1.7.1's Rules O and C (T-W07-ROC) and 1.7.4's three kinds (T-W07-N03).
- **Hooks the build's records name** (chosen; README section 8): an owner-level statement a test runs to plant a state whose form the design leaves to the build, empty until the build's record names it, so that the cases needing it give "could not check" with the reason. `installation_mission` (T-W07-ROC, T-W07-N03 and, phase C4b, T-W07-F04's F04-m4-kur: the Mission Rule O treats as the installation's, CHK-C02-025 F5), `transferred_relation` (T-W07-ROC), `sample_marker_unreadable`, `sample_marker_partial` (phase C6, CHK-C02-030 C7 (d): the marker present but incomplete; part A2) and `take_sample` (T-W07-N28 parts A2 and B2: EV8 2.2 condition 2's marker and the taking's form). The test designer fills each before the first result.
- **Phase C4b: EV8 section 5 (N-262, N-263; PC-47), decided and accepted.**
  - *The exam fact* (EV8 5.1). DM-35 hides the exam's own records (EvalRun; Competence's fields `competence_summary` does not return; the exam schema), never the Work. The two walks follow Relation rows only. A root, a target or a `relate` end that names an exam record gets, for a class other than `devos_sinav`, the answer and recorded reason code of an id that names no record; for `devos_sinav`, `relate` refuses it with a reason of its own. `claim` refuses `devos_sinav` on every work item after the gate, with a reason code of its own (bound 3); `record_eval_run` writes no field, revision or event on the Work it names and refuses to name a work item with an active claim of class `devos_sinav`.
  - `record_eval_run(p jsonb)` (chosen, by this section's rule for a record writer): `p` carries B 3.14's EvalRun fields, `work_ref` with `work_revision`, `eval_set_id`, `eval_set_version`, `subject_role`, `subject_release`, `runner_session`, `results`, `run_at` (T-W07-N08 parts A and X).
  - *Event's `aggregate_id`* (fixed: B:264's field list): an event is "on" the record its `aggregate_id` names (T-W07-N08 part X's N08-s3 and EXF-pair-state; T-W07-N01 and T-W07-T31 part B, for the sample's and the Verdict's events).
  - *Graph nodes are records* (chosen; phase C4b): T-W07-F04's and T-W07-K05's graph nodes are work items planted by the owner, since a root that names no record is answered "could not check" (F04-m1; W-C02-09 point 7; G2 item 4).
  - *The open sample* (EV8 5.2). While its block is open, a `sample` Review, any Verdict on it and every event of either are read only with `devos_denetim` (and the backup job's read for the export); no read returns a stream's block state, a count that changes with open samples, an ID that grows with withheld records, or a walk node that is an open sample or a Verdict on it; neither is a relation end, and as a root or a `relate` end it is answered, for a class other than `devos_denetim`, as an id that names no record. The read functions "that can return a Review, a Verdict or an Event" are found by their text (chosen, as T-W07-N08 finds EvalRun's readers): `devos_api` functions with the read marker whose text names the `review`, `verdict` or `event` table, the two walks excepted. `record_verdict(p jsonb)` with `review_ref`, `result`, `reason` (as T-W07-N28 part B2).
  - *Ids aside* (chosen; EV8 5.1's "the same result, ids aside"): where a case compares two answers, every uuid is replaced by `<id>` (or each compared record's id by one label), a claim token's value by `<claim token>` before the answer is kept, and keys ending in `_at` (times) are dropped; every other value is compared as it is.
  - *Where they run* (chosen): the cases that need a Verdict on a sample inside its open block need a later transaction than the sampled record's (DM-41 (a)), so T-W07-N01's and T-W07-T31's part B are harness scenarios (`harness/scenarios/n01_open_block.sql`, `t31_open_block.sql`) that commit on the throwaway database only, as T-W07-N28 part B; N01-same-answer runs in `devos-test`.

**Reason codes.**
- Token refusals: `missing`, `empty`, `malformed`, `unknown`, `revoked`, `header_unreadable` (fixed: EV3:1312; B:377; EV2:208).
- A role class the function does not permit: `role_class_not_permitted` (chosen; no source names it; Group D's spelling).
- Could not check: `could_not_check` (chosen, above).
- Any other refusal: a test reads its reason code only where its specification names it. A format gate's refusal names the empty field in its `reason_code` or `reason` (chosen; T-W07-5D).

**Other names.**
- The token header: `x-devos-env-token`, read from `request.headers` (fixed: B:475; EV3:28; EV3:158).
- RejectedAttempt's `role_class` for a call without a verified token: `none` (fixed: B:270; B:377).
- A read function's marker: its catalogue comment begins with `devos:read` (fixed: EV2:290, DM-36 (a)).
- The role a Data API request with the publishable key runs as: `anon`, which has USAGE on `devos_api` and EXECUTE on its functions (chosen; W-C02-08 grants it). No application role has EXECUTE on the owner-only functions (fixed: B:46; EV3:293).
- The token formats' markers: `shared/token_format.md` only (section 7).

**For W-C02-10: sample Reviews and DM-41** (fixed, phase C4a; EV8 section 2, merged and accepted; PC-46). DM-41 (EV2:306) refuses a new revision of a review's target in the same transaction as a Review of it or a Verdict on it. The `sample` Review the database itself opens for the record revision whose accepted write draws it, with no reviewer and no verdict, is not such a record; the transaction that takes it or writes its verdict falls under the rule in full (B:246 and C:145, as PC-46 writes them; EV8 2.2's four conditions, its rule about taking and its fail-closed rule). An agent-written sample is refused at two layers: `open_review` and `transfer_review` refuse kind `sample` from every token, and the Review table's check refuses a `sample` row from any writer but the sampling function (EV8 2.2 condition 2). T-W07-N28 tests DM-41 (parts A and B), the exemption and its bounds (parts A2 and B2); T-W07-N01, T-W07-5D and T-W07-T31 rely on the exemption; T-W07-N01's N01-tok judge the first layer and T-W07-N28's S-neg-direct the second.

**Effect classes** (the executor's decision on Group A's open 1 and Group C's open 5). DM-37 (EV2:296) fills the effect-class table by migration and puts the tests' synthetic classes on the throwaway database. The tests may also plant a synthetic effect class as an owner-level fixture inside their own rolled-back transaction in `devos-test`; nothing is committed. The table's columns, which every test that plants or reads it assumes, are under **Tables** above.

## 9. Naming the build item a test serves (point 8)

Each specification's "Serves" line names the build item and point whose condition takes it: W-C02-08, W-C02-09, W-C02-10, W-C02-12 or W-C02-14. Where parts of one test serve two items, it names each part's item (for example, 5 (a)'s negative cases serve W-C02-08 point 4, and its positive control serves W-C02-09, as W-C02-08 point 4 says).

A test or control that needs a later item's part names that item. The earlier item then lists the test with it and does not count it (W-C02-08 point 6). `GROUPS.md` gives the expected item for every test, and phase C writes the final table in `TABLES.md`.

A test that waits on a schedule or a time limit states the time it adds to W-C02-13's run, with the source and date (point 8). An example is the lease: 30 minutes, EV-C02-002 DM-07 and §4, 2026-10-12. Where the test can plant the limit as already passed (an owner-level change of the stored time inside its transaction), it says so, and states what that leaves untested.

## 10. Who runs and who judges (point 1's independence field)

- **Writes:** the test designer, in a fresh-context run of type `test-designer` (or a `producer`-typed agent given the role text in full, W-C02-02 item 4). No test is written by the executor, or by a run that produces a build item the tests judge. W-C02-07's "Record" names each run's agent ID and type.
- **Runs:**
  - the migration job, in `devos-test` on every merge, each file once a build item has copied it (5.1 (c));
  - the build producer, at its build's head (W-C02-08 point 6, W-C02-09 point 8, W-C02-10 point 7);
  - the prober of W-C02-13, a run that wrote none of the tests and produced none of the build, everywhere with its breaks (5.2);
  - for real-token cases, the session in each environment (5.3; W-C02-12).
- **Judges:** a fresh-context checker that wrote none of the tests. Before the merge it judges this set against W-C02-07's condition. After a run it judges the build item from the raw outputs, not from the runner's account, and states its independence level and what it shared (plan Section 8 item 7).
- **The test designer** neither runs these tests for a result nor judges them. Self-checks of a test's logic on the throwaway database or a scratch stub are allowed, are stated in the specification, and are never results.

## 11. What this directory does not cover, and why (plan Section 8 item 14)

These come from W-C02-07's "Not covered", so that silence is not read as a pass:
- whether the tests pass, and whether each fails on its break (W-C02-13);
- the C03-stage tests of what C02 builds for C03 (N06, N08 beyond its C02 database part, N26, K06);
- the later parts of F07, N04, N09, N25 and N29;
- F02 (C04) and F03 (C09);
- N18, the four conditions of "Installation ledger" and the ledger transfer's checks (W-C02-14 point 13);
- `deployment_drift`'s tests (W-C02-03, only cited here);
- the content of records (sample review in the audit environment).
