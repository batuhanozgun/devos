# W-C02-07 tests (C02's tests, written before the build): conventions

**What this is.** These are the conventions every C02 test file under this directory and every `supabase/migrations/tests/w07_*.sql` file follows. The test designer (W-C02-02's role, `.claude/agents/test-designer.md`) wrote them in phase A of W-C02-07's three phases:
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
| SQL test, run by the migration job in `devos-test` and by the break harness | `supabase/migrations/tests/w07_<id>_<slug>.sql` (`<id>` is `<ID>` in lower case without hyphens, for example `w07_f01_whole_intent.sql`, `w07_5b_authorization_matrix.sql`) | high (`supabase/migrations/**`) |
| Break patch | `tests/C02/W-C02-07/breaks/B-<ID>-<n>_<slug>.sql`, never under `supabase/migrations/` | normal |
| Non-SQL executable (a multi-connection runner, a Data API client, a scan) | `tests/C02/W-C02-07/bin/<ID lower>_<slug>.py`, run with `python3 -I` | normal |
| Shared fixture or definition owned by one group | `tests/C02/W-C02-07/shared/<name>` (owners in `GROUPS.md` section 2) | normal |
| The break harness | `tests/C02/W-C02-07/harness/` (owner in `GROUPS.md`) | normal |

**Test IDs.** `<ID>` is one of these:
- the Appendix C ID: `F01`, `F04`, `F05`, `F06`, `F07`, `F08`, `CONC` (Concurrency), `N01`, `N02`, `N03`, `N04`, `N08`, `N09`, `N17`, `N25`, `N28`, `N29` or `K05`;
- the acceptance point it answers: `5A`, `5B`, `5C`, `5D`, `6RG`, `6TK`, `6ST`, `7SCAN`, `T31`;
- a rule a design record adds: `DM02`, `DM07`, `DM11`, `DM19`, `DM19B`, `DM34`, `DM47`, `IDC`, `FGFIND`, `RT`.

`GROUPS.md` fixes every ID and its owner. A group adds an ID only inside its own scope and names it in its report, so that phase C can put it in `TABLES.md`. In the full name `T-W07-<ID>`, the prefix keeps the IDs apart from Appendix C's own and from W-C02-03's `T-W03-*`.

**Case IDs** inside a test are `<ID>-<letter or number>`, for example `F01-a`, `N03-neg3`, `5B-calisma-verdict`, `CONC-pos`. The clause table (point 2) and the break's expected red cases cite case IDs. Case IDs never change after the merge.

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
- **SQL files.** One row per case (`case_id`, `outcome`, `detail`), then a final block:
  - PASS raises a notice `W07_<NAME> PASS (n/n)`;
  - FAIL raises an exception `W07_<NAME> FAIL (...)`;
  - COULD NOT CHECK raises an exception `W07_<NAME> COULD NOT CHECK (...)`.

  Because FAIL and COULD NOT CHECK raise, the job's step fails and `go` is not `yes` (as `w03_drift_could_not_check.sql`). `<NAME>` is the file name without `.sql`, in upper case.
- **Executables.** The last line is `T-W07-<ID> PASS (n/n)`, `... FAIL (...)` or `... COULD NOT CHECK (...)`, with exit codes 0, 1 and 3.

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

**(a) SQL files.** `supabase/migrations/tests/w07_*.sql` are run by the job's test step after the job applies a merge's migrations to `devos-test`, and before it applies them to `devos` (Y-01). The job runs them as `postgres`.

How a file is built (the same as `w03_drift_detects.sql`):
- **Header comment.** The synthetic-data label; the claim; the specification's path; where it runs; the interface assumed; and its safety.
- **Transaction.** `begin;` then `set local search_path = pg_catalog, pg_temp;` and `set local statement_timeout = '60s';` (a longer timeout is stated in the specification). Then a `pg_temp` results table and the cases, then the final block of section 3. Last comes `rollback;`. Nothing is committed.
- **Fixtures.** Every fixture is made inside the transaction, as owner where the rule under test is not the owner's, or through `devos_api` where it is.
- **No `psql` meta-commands**, so a client that does not interpret them runs the file unchanged (EV-C02-001 section 10).
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

**(b) Calls through the Data API to `devos-test` with synthetic tokens** (EV-C02-003 §6.3: "for a call over HTTP, it commits them, sends them with the header set explicitly, and revokes them before the run ends"). These cover:
- the real path for each role class (W-C02-09 point 3);
- rules keyed on `session_user`;
- tests that need several connections, or committed state that other connections see (Concurrency).

Such tests are executables under `bin/`, run by the job's runner from inside its `devos-test` step. They follow these rules:
- **Tokens.** The executable issues its synthetic tokens and commits them, holds them only in memory, sends them in the `x-devos-env-token` header with the publishable key in `apikey`, and revokes every one before it ends, even after a failure. It prints no header.
- **HTTP method.** It calls remote procedures with `POST`. The Data API runs a `GET` in a read-only transaction, while read functions that record a refusal are `VOLATILE` (N-244 item (2)), so a `GET` case is made only where its specification names its expected result.
- **Fixtures.** Committed fixtures are labelled synthetic (section 6) and listed in the run's output. They cannot be deleted where the rule makes their family append-only, so the run lists what it left.
- **Interface.** Whether the migration job runs such an executable in its `devos-test` step is an interface on W-C02-03's job (P10 covers SQL files only). If the job does not run it, the test's result there is COULD NOT CHECK, and the record says which claim then rests on the real-token runs alone (5.3).

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
- **Builds a fresh database per break run.** It is PostgreSQL 17, the projects' major version: `devos` runs 17.6, observed 2026-10-12. If `devos-test`'s version, not yet observed, differs, each version is run (EV-C02-002 §5 and §14). The database is built from `supabase/migrations/` at the commit under test, in a container or on a CI runner. The session container's PostgreSQL 16.15 serves only the test designer's self-checks, which never count as results.
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
  2. **Break.** A new database gets exactly one patch, and the same files run. The cases that turn `bad` must equal the patch's `expect-red` list, and the file must end in FAIL. A failure from anything else (a missing object, a syntax error, a lost connection) is not a break shown (W-C02-13 point 3).
  3. **Restore.** The unpatched database is run again.

**How a break patch is built** (as W-C02-03's `breaks/B4_could_not_check_as_clean.sql`):
- **Header.**
  - The first line names the test and the example that must turn red, in a machine-readable form: `-- w07-break: test=<sql file>[,<sql file>]; expect-red=<case IDs>`.
  - Then the rule removed and the synthetic label.
  - No `psql` meta-command.
- **Guard block.** It raises unless `current_setting('w07.throwaway', true) = 'yes'`, and raises if `supabase_admin` exists.
- **The change.** It removes one rule and no more. For example, it renames the build's function and wraps it so that one check is skipped, or drops one trigger, constraint or privilege revocation. It holds as little of the build's logic as it can, so the test cannot pass by copying the build.
- **Location.** It sits outside `supabase/migrations/`, so no job ever applies it.

**Executables against the harness.** The tests of 5.1 (b) run against the throwaway database only for breaks of rules they test there, such as Concurrency's. Their Data API calls are then replaced by direct connections. The specification says which assertions hold on each transport.

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

**The scan of point 7** (owner: `GROUPS.md`). Its subject is the files of this directory and `supabase/migrations/tests/w07_*`, at the head that adds them. It applies:
- the guard's credential patterns: `REDACT` and the expansions of `CREDENTIAL_VARS` in `.claude/hooks/tool_allowlist.py`;
- both token formats;
- `tools/credential_value_scan.py`.

It is first shown to catch a planted synthetic string of each token format, and of each guard pattern, in a scratch copy outside the repository. Its result is worded "none found by the scanned patterns", never "no secret". A file it cannot read makes it COULD NOT CHECK. A hit is classified as a name or a value, and its classification rule is fixed before the run.

## 7. Shared definitions

- **The literal markers of both token formats.** EV-C02-003 §1.3 and §1.7 leave the markers to W-C02-07, "when it writes its scan". They are fixed once, in `shared/token_format.md`, by the group that owns the scan. W-C02-09's issuing function and W-C02-11's guard pattern take them from there. They are checked against the guard's existing patterns, so that neither marker is caught or masked by an unrelated pattern.
- **The break harness** (5.2) is written once, by the group named in `GROUPS.md`. Other groups write their patches to section 5.2's form and list their files in their patches' `w07-break` lines.
- **SQL fixtures are not shared.** Each SQL file makes its own, since no file can include another. Helper functions use the `pg_temp.w07_` prefix. A group that wants a common helper copies it and names its source.

## 8. Interfaces with the build

Where the design leaves a name or a form open, the specification states the interface it assumes under "Interface assumed". Examples: a function's signature, a reason code's spelling, the read marker's form, the sample-stream table, the path-list table.

If the build chooses another form, the test designer revises the test before its first result. The revision is merged before the result it judges, the build item's record shows the change in its `git diff` of the test files (W-C02-08 point 6), and the builder never adapts a test. After a result of the build has been seen, a test is changed only under ledger rule 3, with the earlier result void and the test repeated, by the executor's decision (Appendix G G8 item 3).

## 9. Naming the build item a test serves (point 8)

Each specification's "Serves" line names the build item and point whose condition takes it: W-C02-08, W-C02-09, W-C02-10, W-C02-12 or W-C02-14. Where parts of one test serve two items, it names each part's item (for example, 5 (a)'s negative cases serve W-C02-08 point 4, and its positive control serves W-C02-09, as W-C02-08 point 4 says).

A test or control that needs a later item's part names that item. The earlier item then lists the test with it and does not count it (W-C02-08 point 6). `GROUPS.md` gives the expected item for every test, and phase C writes the final table in `TABLES.md`.

A test that waits on a schedule or a time limit states the time it adds to W-C02-13's run, with the source and date (point 8). An example is the lease: 30 minutes, EV-C02-002 DM-07 and §4, 2026-10-12. Where the test can plant the limit as already passed (an owner-level change of the stored time inside its transaction), it says so, and states what that leaves untested.

## 10. Who runs and who judges (point 1's independence field)

- **Writes:** the test designer, in a fresh-context run of type `test-designer` (or a `producer`-typed agent given the role text in full, W-C02-02 item 4). No test is written by the executor, or by a run that produces a build item the tests judge. W-C02-07's "Record" names each run's agent ID and type.
- **Runs:**
  - the migration job, in `devos-test` on every merge (5.1);
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
