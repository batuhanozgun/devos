# T-W03-15 · The workflow guards: no expression in a `run:` body, and `pr_inputs`' own body

**Synthetic test data** (plan Section 8 item 13). Everything `test_workflow_guards.py` feeds the workflows is made up and labelled: the versions `2999…`, the names `w03_fixture_*`, the repository `w03-fixture-owner/w03-fixture-repo`, the token text `w03-fixture-token-not-a-credential`, the run and job ids `9…`, the scratch repositories' commits, the report and log lines, and the planted workflow text. The frozen bodies in `breaks/G2_pr_inputs_d33c8e9.py` and `breaks/G2_pr_decide_d33c8e9.py` are copies of `main`'s own steps at `d33c8e9` (byte-identical below their header), used only by `--self-check`. Not made up, because the rules name them: the workflow paths, job and step ids, `supabase/migrations/`, the report line's form (`migrate.yml`, step `report`) and `deployment_drift`'s result kinds.

**Serves.** Note N-265 (`plan/work/C02.md`; CHK-C02-038 F-11; EV-C02-007 section 12.8 items 3 and 4): "a rule in M22 or a test that refuses a `${{` in a `run:` value (or runs a pinned copy of GitHub's parser), and a test that runs `pr_inputs`' body against git with the quoted-name, failed-diff and positive cases, each with its break, merged before their results." It also keeps CHK-C02-035 C2 ("pr_decide must never answer pass for a pull request that changes, removes or renames a merged file under supabase/migrations/ whose name git quotes") and EV-C02-001 M15 and M16 in force on every later change of `pr_inputs`.

**The executor's decisions this test follows** (task of 2026-10-13):
1. It runs with no workflow change: `test_workflow_order.py`, which step `w03_tests` of `migration-checks.yml` already runs on every pull request, runs `test_workflow_guards.py` after its own final line and exits with the worse of the two results (1 over 3 over 0). Each test's own final line is its result.
2. Guard 1 is a static rule over every workflow file, read with PyYAML (the runner has no pinned copy of GitHub's parser, and adding one is a workflow change).
3. Guard 2 runs `pr_inputs`' own body, read from `migration-checks.yml` at the head under test, against scratch git repositories and a stub of GitHub's REST API on 127.0.0.1, and feeds its outputs to `pr_decide`'s own body. It checks cases (a) to (e) below, with the behaviour decision 3 states, not any code.

## Expected results on `main` `d33c8e9` (this branch's head), stated before any run

- **G1 (`W03_RUN_EXPR_TEST`): PASS.** EV-C02-007 section 12.1 (a) and CHK-C02-038 F-1 found no opener in any `run:` value of the two files, and neither file has changed since in a `run:` value that this test reads differently. If G1 is red on `main`, that is a finding about `main`, and the rule is not weakened.
- **G2 (`W03_PR_INPUTS_TEST`): FAIL, on D1, D2, D3, D4, E1 and E2 only.** Every other case is green.
  - **Why D1 to D4.** `main`'s `pr_inputs` asks for every job's log inside one `try`. The first skipped job's log answers 404, so the whole report is "could not be read (HTTPError)" and both projects read "could not check". That is what pull request #309's check printed at `f287a7c`. The additions (D1, D3) still get verdict pass, but the state does not give the records' state. The removals (D2, D4) get verdict fail.
  - **Why E1 and E2 (the test designer's reading; the executor's decision 4 named (d) only).** Case (e) asks that "the other project is still read". `main`'s body leaves the whole report unreadable on any job's 404, so the other project is not read. The verdict is fail, as (e) wants, but the state is not.
  - **What turns it green.** The executor expects H1 (pull request #309) to turn G2 green once it merges `main`, because it passes over skipped jobs and reads each job's log on its own.
- **G2's breaks on `main`:** BRK-a, BRK-b, BRK-c1 and BRK-c2 are shown (each turns its own cases red). BRK-d and BRK-e are "not shown", because the head already fails D2, D4, E1 and E2.
- **Combined.** `test_workflow_order.py` therefore exits 1 on this branch, and so does its pull-request check. That red is expected and stated here.

## Reading the pull-request check until `main`'s `pr_inputs` is fixed (CHK-C02-049 C1)

- **(a) The red window.** From this test's merge until W-C02-03's fix of `pr_inputs` merges, every pull request's `migration-checks` job is red at step `w03_tests`, with `W03_PR_INPUTS_TEST FAIL (6 of 21 cases red: D1, D2, D3, D4, E1, E2; …)`. That is the known fault in `main`'s `pr_inputs` (above), not a finding about the pull request. In that window the job's conclusion says nothing about the pull request. A reader reads instead:
  - `pr_decide`'s `pr check: <verdict>: <reason>` line, which gives the pull request's migration verdict. A real fail there no longer shows in the job's conclusion, because the job is red anyway;
  - each test's own final line in `w03_tests`: `W03_DECISION_TEST`, `W03_ORDER_TEST`, `W03_RUN_EXPR_TEST` and `W03_PR_INPUTS_TEST`. Only `W03_PR_INPUTS_TEST`'s FAIL on exactly D1, D2, D3, D4, E1 and E2 is the known fault. Any other result is read as on any other day. That includes another case red, a break BAD, or a could not check.
  - On the pull request that changes `pr_inputs`, G2 runs that pull request's own body, so its line is that change's result.
  - The window ends when that change merges. From then on the job's conclusion counts again.
- **(b) The echo line.** `w03_tests` prints `W-C02-03 tests: decision steps exit A, workflow order exit B`. B is `test_workflow_order.py`'s exit code. Since this test's merge, that code is the worse of the T-W03-14 and T-W03-15 results (1 over 3 over 0), not T-W03-14's alone.
  - T-W03-14's own result is its `W03_ORDER_TEST` line. T-W03-15's results are its two lines.
  - The label lives in `migration-checks.yml`, so it changes only with the next change of that workflow. This test makes no workflow change.
- **(c) BRK-d and BRK-e.** On `main`'s body both are "not shown", because the head already fails their targets: D2 and D4 for BRK-d, E1 and E2 for BRK-e.
  - They are shown for the first time on the first head whose body passes D2, D4, E1 and E2. A head that passes only some of them shows BRK-d once it passes D2 or D4, and BRK-e once it passes E1 or E2, but G2 still fails on the rest.
  - Until then, the only evidence that they turn a correct body red is scratch runs outside this test (CHK-C02-049 F-8), not this test's run.
  - No `W03_PR_INPUTS_TEST PASS` line can appear while a break is not shown. A break is "not shown" only when one of its target cases is red, or could not check, on the head itself. That makes G2 FAIL or COULD NOT CHECK. So a PASS line always reads "breaks: 6 shown, 0 not shown, of 6".

## Guard 1 (`W03_RUN_EXPR_TEST`)

**The rule.** In every `.yml` and `.yaml` file at the top of `.github/workflows/`, for every job and every step: a `run:` value, as YAML parses it, holds no expression opener (a dollar sign followed by two opening braces). A value that holds one is a FAIL naming the file, job and step, with the count and the first line.
- GitHub reads no subfolder.
- The suffix is read in any case, so `.YML` and `.Yaml` files are read too (CHK-C02-049 F-2). Whether GitHub runs such a file is not verified here, and reading more is the safe side.
- Each file is read once, with PyYAML's safe loader, which here also refuses a key written twice in one mapping (under "Could not check").

**What counts, and why** (asked of this test):
- **A multi-line block scalar counts.** The rule reads the parsed value, so every line of a `|` or `>` block counts, heredocs included. That is where the class arose: the opener sat in Python string literals inside a `run: |` body (EV-C02-007 12.1).
- **The value as GitHub reads it counts, not the raw text.** An opener written as a YAML escape (`"\x24{{ … }}"` in a double-quoted scalar) has none in the raw text, but the parsed value holds one, and so does GitHub's. It counts. Aliases are read through.
- **An opener split by spacing does not count** (`$ {{`, `${ {`). GitHub evaluates only the contiguous opener, so such text reaches the runner as written. Refusing it would refuse a correct body. An opener with text before it (for example `$${{`) still holds the contiguous opener, and counts.
- **`defaults.run` (workflow or job) does not count.** Its values are the `shell` and `working-directory` settings, not a body. GitHub reads expressions there by design, and the offline runs never execute them as script. Neither file uses `defaults`. Stated under "Not covered".
- **Places where expressions are meant are not refused.** These are `if:`, `env:`, `with:`, `name:`, job `outputs:`, `concurrency:`, and the inputs of a job that calls a reusable workflow. The rule is the step's `run:` only.

**Could not check:** None of these is ever a pass.
- the folder is absent or holds no `.yml` or `.yaml` file;
- a file is unreadable, not UTF-8 or not YAML;
- a file holds one key twice in one mapping, naming the file and the lines (CHK-C02-049 F-2). This covers a key written twice (quoted or not), and two keys PyYAML reads as one, such as the job ids `on` and `yes`, which both read as true. PyYAML would keep the last value, which can hide an opener in the first. GitHub is recalled to refuse such a file, which is not verified here; either way the file is not a pass.
- a file has no mapping of jobs;
- a job or step is not a mapping, or its steps are not a list;
- a `run:` value is a list or a mapping.

A file that could not be checked does not stop the rest (CHK-C02-049 C2). The other files are still read, and their copies are still made. G1 ends `W03_RUN_EXPR_TEST COULD NOT CHECK`, unless a value fails, and G2 still runs and prints its final line. The program then exits 3, or 1 if anything fails.

**Break (run on every run, on copies of the head's folder).** Each break must fail on its own file, job and step, and nothing else may change. Copies are made only from files G1 read. A file it could not check is copied as it is, never parsed again, and its line reads "n/a … not made". A copy that cannot be made is could not check.
- for each workflow file at the head, a copy whose last job's last `run:` value gains one line with the opener, re-written as a block scalar;
- a planted file whose one-line `run:` writes the opener as a YAML escape;
- a planted file whose block `run:` holds the opener inside a Python heredoc.

**Control (must pass):** a planted file holding openers in `name:`, workflow `env:`, job `if:`, step `env:` and a reusable-workflow call's `with:`, and in its `run:` only the split forms `$ {{` and `${ {` and `${HOME}`.

## Guard 2 (`W03_PR_INPUTS_TEST`)

**How it runs.** The test runs `pr_inputs`' own `run:` body, read from `migration-checks.yml` at the head, as a program (`python3 -I`, as GitHub's `shell: python` runs it). It runs in a scratch git checkout, with the environment GitHub gives a step:
- `GITHUB_REPOSITORY`, `GITHUB_API_URL` pointing to the stub, and `GITHUB_OUTPUT`;
- the step's own `env:` filled from `github.token` (a fixture text) and the other `github.*` values;
- every proxy variable set to a dead address (127.0.0.1:9) with `NO_PROXY=127.0.0.1`, so a request to any host but the stub fails and nothing reaches GitHub;
- git with no system or user configuration.

Then `pr_decide`'s own body runs with its `env:` filled through its wiring (each value `steps.pr_inputs.outputs.<name>`).
- **The checkout.** `main` holds `supabase/migrations/2999010100000{1..8}_w03_fixture_*.sql` and a document. The pull request's change is merged into `main` with `--no-ff`, so HEAD is a merge commit whose first parent is `main`'s head, as GitHub's merge commit is. `origin` is a local bare repository whose `main` is that head.
- **The stub** answers what the test can see `pr_inputs` may ask:
  - the workflow's runs, filtered by `branch`, `status`, `head_sha` and `event`;
  - the run;
  - the run's jobs;
  - a job;
  - a job's log: for a job that ran, a 302 to a blob on the stub holding the job's log lines, timestamp-prefixed, with one `W03REPORT {…}` line of `migrate.yml`'s form for its own project. For a skipped job, and for a ran job whose log is missing, HTTP 404 with GitHub's error body.

  Any other path answers 404 and is named in the case's line.
- **The report** in every log shows versions `…01` to `…07` applied in both projects and `…08` `on_main_not_applied` in both, at the run's commit, which is `main`'s head.

| Case | Job list | Pull request's change | Expected |
|---|---|---|---|
| **(a) quoted names** | | | |
| A0 (control) | the two jobs that ran | a plain name modified, applied in both | fail |
| A1 | ran | non-ASCII name (`café`) modified | fail |
| A2 | ran | non-ASCII name removed | fail |
| A3 | ran | non-ASCII name renamed | fail |
| A4 | ran | name holding a tab, modified | fail |
| A5 | ran | name holding a double quote, removed | fail |
| A6 | ran | name holding a backslash, renamed | fail |
| A7 | ran | name holding a newline, modified (CHK-C02-038 F-4) | fail |
| A8 | ran | name holding a byte that is not UTF-8, modified (CHK-C02-038 F-4) | fail |
| **(b) a failed diff** | | | |
| B1 | ran | the checked-out commit has no parent; it adds a migration and changes a document | fail, and `pr_decide`'s reason says "could not check" |
| B2 | ran | a depth-1 clone of the merge commit (its parent absent); the same change | as B1 |
| **(c) positive controls** | | | |
| C1 | ran | a new migration `…09` added | pass. Both `pr_inputs` and `pr_decide` exit 0. The state reads each project from its job (not "could not check") and names `…08`, which each report lists |
| C2 | ran | `…08` removed while the report shows it unapplied in both (M16's allowed path) | pass, with the state as C1 |
| **(d) the job list as GitHub gives it** | | | |
| D1 | push run: `devos-test` success, `check-devos-test` skipped, `check-devos` skipped, `devos` success, in that order, each `status: completed` | C1's addition | as C1 |
| D2 | push run | C2's removal | as C2 |
| D3 | scheduled run (derived, not observed; below the table): `devos-test` skipped, `check-devos-test` success, `check-devos` success, `devos` skipped | C1's addition | as C1 |
| D4 | scheduled run | C2's removal | as C2 |
| D5 (negative control) | push run | a migration applied in both modified | fail |
| D6 (negative control) | scheduled run | the same | fail |
| **(e) a ran job's log answers 404** | | | |
| E1 | push run; `devos-test`'s own log answers 404 | C2's removal | fail. The state reads `devos-test` "could not check", and reads `devos` from its job, naming `…08` |
| E2 | scheduled run; `check-devos`'s own log answers 404 | C2's removal | fail. The state reads `devos` "could not check", and reads `devos-test` from its job, naming `…08` |

**The two job lists are not equally grounded** (CHK-C02-049 F-5).
- **Push run: observed.** The list used by D1, D2, D5 and E1 is GitHub's own, observed in run 38319371450.
- **Scheduled run: derived, not observed.** The list used by D3, D4, D6 and E2 is derived from `migrate.yml`'s `if:` lines, put in the push run's order. Those lines are 76, 990, 2035 and 2711 at this branch's head: `check-devos-test` and `check-devos` run only on `schedule`, `devos-test` and `devos` only on `push`.
  - The first scheduled run of `migrate.yml` will observe it.
  - Until then, those four cases rest on that derivation.

**What is checked, and why.**
- **The verdict** is `pr_decide`'s `verdict` output.
- **Exit codes, on a pass only.** For a pass, `pr_inputs` and `pr_decide` must also exit 0, since on GitHub a failed step fails the job.
- **The state** is `pr_decide`'s `state` output, split per project (`<project>: …`).
- **(a) is judged by the verdict alone.** CHK-C02-035 C2 allows either reading a quoted name verbatim or failing it as "could not check", and both give fail. The class of the defect, a quoted name read as git quotes it, gives pass.
- **(a) to (c) use a job list of the two jobs that ran.** GitHub never gives that shape. It keeps (a) to (c) apart from (d)'s rule, so a body that mishandles skipped jobs is caught by (d), not by everything at once.

**Breaks (run on every run, on the head's body).** Each break is the head's body with a prelude prepended. The prelude intercepts one call the body makes (`subprocess.run` for `git diff`, or urllib's `OpenerDirector.open` for the API) and gives the body what a body without the rule would have taken from it. The body's text is not edited, so the breaks work on whatever body the head holds. Each break must turn red every case in its target set in which its change was reached, and leave the cases it cannot touch as they were (a case that turns red there is BAD). A target case the head already fails is "not shown". If the prelude's change is never reached, the break is "could not check" for that break, never a pass.

| Break | The copy… | Must turn red | Must leave as they were |
|---|---|---|---|
| BRK-a | reads the changed files from `git diff` without `-z`, where git quotes such names (CHK-C02-035 C2's class) | A1 to A8 | A0, (b), (c), (d), (e) |
| BRK-b | reads a failed `git diff` as an empty list of changes (EV-C02-007 12.3's second fail-open) | B1, B2 | all others |
| BRK-c1 | reports an added migration as modified | C1, D1, D3 | (a), (b), C2, D2, D4, D5, D6, (e) |
| BRK-c2 | reads each job's report without its list of differences | C2, D2, D4 | (a), (b), D5, D6 |
| BRK-d | cannot tell a skipped job from one that ran (the job list rewritten), and reads a skipped job's 404 as an empty clean report | D2, D4 | (a), (b), (c) |
| BRK-e | folds a ran job's 404 into an empty clean report ("no difference") | E1, E2 | (a), (b), (c), (d) |

**`--self-check`** (wrong-by-construction inputs; it must give exactly what is stated):
- **G1**, on synthetic folders:
  - the control file passes;
  - the heredoc and escape plants fail;
  - a file that is not YAML, a `run:` that is a list, and a missing folder each give "could not check";
  - the break and the control on a clean synthetic folder behave as above;
  - `g1()` itself on a folder holding the control file and one file it could not check gives `W03_RUN_EXPR_TEST COULD NOT CHECK` and returns 3, with no exception (CHK-C02-049 C2). This is run four times, once for each kind of file: not YAML, not UTF-8, `jobs:` a list, `steps:` not a list;
  - a step holding `run:` twice, the first with an opener, gives "could not check" naming the file. So do the job ids `on` and `yes` (one key to PyYAML) with the opener in the first. With PyYAML's plain reading, both would pass;
  - openers in files named `.YML` and `.Yaml` fail on both files.
- **G2**, with the frozen `pr_decide` of `d33c8e9`:
  - the frozen `pr_inputs` of `d33c8e9`, a known-faulty body of class (d) and (e), gives (a), (b), (c), D5 and D6 green, and D1 to D4, E1 and E2 red;
  - a body that always writes no change and no report gives (a), (b) and (c) red;
  - a crashing body gives every positive control red;
  - the six breaks on the frozen body give none BAD and none "could not check";
  - a repository without the workflows, and one whose `pr_inputs` body holds an opener, each give "could not check".

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-15.<br>G1: no step's `run:` value in any workflow holds an expression opener, so the body every offline check runs is the body GitHub runs.<br>G2: `pr_inputs`, as the head writes it, gives `pr_decide` inputs from which a pull request that changes, removes or renames a merged migration applied in a project fails (including names git quotes), and a failed diff fails as "could not check". An addition, and a removal of a version unapplied in both, pass with the records' state read from the jobs that ran, whether GitHub's job list holds skipped jobs or not. A ran job whose log is missing leaves its project "could not check" and the other read. |
| **Failure class rule** | G1: a workflow whose text, as GitHub hands it to the runner, differs from the text the offline checks read and run. Here, an expression in a `run:` body. Examples: the six openers of CHK-C02-029 F-1 in `workflow_check`'s string literals; an opener in a heredoc; one written as a YAML escape.<br>G2: `pr_inputs` failing open, or failing shut where M16 allows the change, because of an input shape it does not read as GitHub or git gives it. Examples: a quoted file name (CHK-C02-035 C2), a failed diff read as no change (EV-C02-007 12.3), a skipped job's 404 (pull request #309's check at `f287a7c`), a ran job's missing log. |
| **Examples** | G1: the planted head copies, the escape plant, the heredoc plant.<br>G2: A1 to A8, B1 and B2, D1 to D4, E1 and E2. |
| **Negative control** | G1: every plant fails, naming its file, job and step.<br>G2: (a), (b), D5, D6 and the (e) verdicts fail; `--self-check`'s frozen `d33c8e9` body and always-clean body are caught. |
| **Positive control** | G1: the control file passes, and so do the head's two workflows.<br>G2: C1, C2 and D1 to D4 pass with the state read; the frozen body's (a) to (c) pass in `--self-check`. |
| **Break attempt** | G1: the planted copies (above). Each must fail on its own file, job and step, and the control must not.<br>G2: BRK-a to BRK-e (above), run on the head's body on every run. Each must turn its own cases red and leave the cases it cannot touch as they were. |
| **Stage and environment** | C02, from N-265's merge on.<br>• On every pull request, in `migration-checks`' step `w03_tests` (through `test_workflow_order.py`), on GitHub's `ubuntu-24.04` runner.<br>• Anywhere with Python 3, PyYAML and git ≥ 2.32, with loopback networking.<br>• No credential, no database, no request to GitHub. |
| **Independence level** | Written by the test designer (a fresh-context subagent of the working session) before the results it judges. Run by the pull-request check, by the producer of the change that next touches `pr_inputs` (H1), and again by its fresh-context checker, who reads the raw output.<br>Shared: model lineage and the design record. The expected results above were stated by the executor (decision 4) and by this test's designer from reading `main`'s code, before any run. |
| **Evidence layer** | G1: structural (the files' text as parsed). It shows the rule holds for what PyYAML reads. That GitHub's own parser reads the same is EV-C02-007 12.2's observation (0 differences), not this test's.<br>G2: behavioural, offline. It shows what `pr_inputs`' body does with git's real output and with a stub shaped like GitHub's answers as observed. The scheduled run's job list is derived (under the case table). What GitHub's API answers on a later day is live only. |
| **Evidence envelope** | As in the README.<br>• `target_commit`: the head the check ran on (the pull request's merge commit).<br>• `deployment_config_ref`: `migration-checks.yml`'s and `migrate.yml`'s blob SHAs at that commit.<br>• `criterion_version`: the commit that merged this file and `test_workflow_guards.py`, which must precede `target_commit`.<br>• `inputs_ref`: case and break ids.<br>• `observations_ref`: the check's run and job ids and its `w03_tests` log lines.<br>• `raw_evidence_ref`: the full output. |

## Could not check

- G1: as listed under Guard 1.
- G2:
  - `migration-checks.yml` or `migrate.yml` absent or unparsable (a key twice in one mapping included, as G1 reads it);
  - no step `pr_inputs` or `pr_decide`;
  - a body that is neither `shell: python` nor a one-line `python3 [-I] <class-high file>`;
  - a body holding an opener;
  - `pr_inputs`' `env:` holding an expression other than `github.token`, `github.repository`, `github.api_url`, `github.event_name` or `github.sha`;
  - `pr_decide`'s `env:` taking a value from anything but `steps.pr_inputs.outputs.*`;
  - `migrate.yml`'s jobs not exactly the four the observed job list names (the stubbed shape then no longer describes the workflow, and the test designer revises the test);
  - a checkout that git cannot make, such as a filesystem that refuses a name;
  - the stub failing to start;
  - a break whose change is never reached.

  None of these is a pass.

## Interface

- **Outputs.** `pr_inputs` writes its outputs to `GITHUB_OUTPUT`, and `pr_decide` reads them through its `env:` wiring. `pr_decide` writes `verdict` (`pass` or `fail`) and `state`, as `<project>: <words>` parts joined by `; `, with "could not check" for a project not read (T-W03-DEC's interface). Its stdout states the reason.
- **Report lines.** A migration job's log holds its report as one line `<timestamp> W03REPORT <JSON>` (`migrate.yml`, step `report`), with `project`, `commit`, `result`, `applied_versions` and `differences`.
- **Jobs.** Job names in the stub's job list are `migrate.yml`'s `name:` values at the head, as GitHub's API gives them.
- **Calls the breaks rely on.** The body runs `git diff` through `subprocess.run` (or a helper that calls it) and reaches the API through urllib (`urlopen` or an opener). If the head's body uses other calls, the breaks give "could not check", and the test designer revises them before they count.

## Not covered, and why

- **`migrate.yml`'s steps.** They run only live: they need the projects and their credentials (T-W03-05 to T-W03-14). G1 reads their `run:` values. G2 stubs their report lines in the form step `report` prints, not their content.
- **`pr_decide`'s own rules.** These are T-W03-DEC's (`test_decision_steps.py`). G2 runs `pr_decide` only to turn `pr_inputs`' outputs into the verdict and state a reader sees.
- **GitHub's own reading of the files.** G1 is PyYAML's reading. A pinned copy of GitHub's parser (N-265's alternative) was not chosen, because the runner has none and adding one is a workflow change. Constructs where GitHub's reading differs beyond the opener (EV-C02-007 12.2) are not re-checked here.
  - Not verified offline (CHK-C02-049 F-2): whether GitHub refuses a key twice, whether it runs a `.YML` file, and how it treats merge keys (`<<`). G1 takes the safe side of the first two: it gives "could not check" for a key twice, and it reads the file.
  - A value merged in by `<<` and then overridden in the same mapping is read as PyYAML reads it.
- **Expressions outside `run:`.** These are `defaults.run`'s `shell` and `working-directory`, an action's script input (for example `actions/github-script`'s `script:` through `with:`), and composite actions' `run:` outside `.github/workflows/`. They are not refused. None exists in the repository at `d33c8e9`. A future one is the class-high review's.
- **The API's live answers.** Status codes, redirects, pagination beyond one page, rate limits, and whether the token is accepted are GitHub's on the day (the pull request's own check log shows them). The stub does not check the `Authorization` header, nor that it is withheld on the redirect.
- **Runs at another commit.** The stub serves one completed run at `main`'s head. A body that ignores `head_sha` would read it too, and `pr_decide`'s commit check (T-W03-DEC P09) is the guard there.
- **The comparison through `devos_ci`** (README). When `pr_inputs` changes source, this test's (c) to (e) are revised.
