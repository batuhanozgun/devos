# T-W07-N08 · Only the exam environment's token reaches the exam records (N08's database part in C02)

Synthetic test data (plan Section 8 item 13): five synthetic tokens (working, audit, installation, CI, exam) are issued at run time in the rolled-back transaction. One work row is planted as owner, with text `w07_fixture SYNTHETIC W-C02-07`. Exam results are the neutral JSON `{"w07_fixture": "SYNTHETIC W-C02-07"}`. No exam content exists in C02.

**Serves.** W-C02-10 point 5, fourth bullet: "✘ EvalRun written or read with any token but `devos_sinav`'s is refused (B 3.15; the access rule C03's N08 needs); N08's run with the `devos_kurulum` token is shown here if W-C02-05's record keeps it in C02 (N-136)". EV-C02-003 §4.5 keeps it: "N08's database part … also runs in C02, with the working, audit, `devos_kurulum` and `devos_ci` tokens".

Also W-C02-07 point 2's N-136 extension ("N08 with the `devos_kurulum` token"), and the executor's decision 6 (EV-C02-003 §4.5; PC-43 place 10). Design relied on:
- Appendix B 3.15 (B:273: "`EvalRun` and `Competence` are written only with the `devos_sinav` role, and `EvalRun` is read only with it");
- B section 2's `devos_kurulum` "Cannot" (PC-43 place 5);
- EV-C02-002 DM-24 (the exam fact lives only in EvalRun's `work_ref`; no exam field on Work);
- EV-C02-003 §5.2 (`devos_ci`'s key treated as readable by every session).

**Command.** (statement timeout 120 s, README 5.1 (a)) `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n08_exam_records.sql`, in `devos-test` by the job's test step as `postgres`, and on the throwaway database by the harness.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** As `T-W07-IDC`. Beyond it:
- EvalRun's table is `devos_private.eval_runs` and Work's is `devos_private.works` (`w07_cfg`);
- `devos_api.record_eval_run` writes EvalRun;
- the full positive fills an argument whose name matches `work` with the planted work's key.

B section 4 names no function that reads EvalRun. So the test finds every `devos_api` function whose text names EvalRun's table, `competence_summary` excepted (B 3.15 lets other classes call it, and it returns no exam content; its content rule is C05's), and holds each to the read rule.

## Cases

- **Writing an exam record.** `N08-w-<class>` for `devos_calisma`, `devos_denetim`, `devos_kurulum` and `devos_ci`: `record_eval_run` is a role refusal under that class, nothing changed. `N08-w2-devos_calisma` is the same call on the planted work item, the positive's arguments.
- **Reading the exam records.**
  - `N08-r-<function>-<class>`: every function that reads EvalRun's table refuses the same four classes.
  - `N08-rp-<function>`: with the exam token, the same function is accepted.
  - If no such function exists, a notice says so. The read is then closed by `T-W07-5A`, since no direct SELECT reaches EvalRun but `devos_sinav`'s (W-C02-08 point 4), and by the absence of a reading function.
- **The exam fact.**
  - `N08-s1`: no `devos_private` table other than the exam records has a column named for an exam or an eval (DM-24: "No exam field on Work").
  - `N08-s2`: no table outside the exam records refers to EvalRun by foreign key, so the link lives only in the exam records.
- **Positive.**
  - `N08-wp1`: the exam token passes `record_eval_run`'s role gate.
  - `N08-wp2`: on a planted work item, the exam environment's `record_eval_run` is accepted, with an event under `devos_sinav`.
  - `N08-w2-devos_calisma` differs from it in the token only.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-N08. Appendix C's claim: "The role under test cannot reach the exam answers". Its C02 part is the exam records' access rule in the database (PC-43 place 10). |
| **Failure class rule** | **[Designer's addition: Appendix C's C2 rows give none (R2 section 5 (c)).]** Any path by which a token other than the exam environment's writes or reads an exam record or the exam fact. That includes any function that reads EvalRun, and any field outside the exam records that carries the exam link. |
| **Examples** | **[Designer's addition, as above.]** (1) The original finding (C:125): the working or audit token reads the exam records (`N08-r-*-devos_calisma`, `N08-r-*-devos_denetim`). (2) Another manifestation: the installation or CI token writes or reads one (`N08-w-devos_kurulum`, `N08-w-devos_ci`, `N08-r-*-devos_ci`; N-136; EV-C02-003 §5.2). (3) Another: the exam fact leaks through a field on Work or a link from another table (`N08-s1`, `N08-s2`; DM-24). |
| **Negative control** | Every `N08-w-*`, `N08-w2-*` and `N08-r-*` case: refused, recorded once per call under the token's class, no event, no table changed. `N08-s1` and `N08-s2`: none found. |
| **Positive control** | `N08-wp1`, `N08-wp2` and `N08-rp-*`: "The exam environment accesses". |
| **Break attempt** | **[Designer's addition, as above.]** Each patch is applied by the harness on the throwaway database (README 5.2).<br>**B-N08-1** (`breaks/B-N08-1_exam_read_admits_working.sql`). Removed: B 3.15's read rule; every function that reads EvalRun's table also admits `devos_calisma`. Red: `N08-r-<function>-devos_calisma` for each such function. The patch's line names the stand-in's `read_eval_runs`, and the prober writes the build's function names in before the run.<br>**B-N08-2** (`breaks/B-N08-2_exam_write_admits_ci.sql`). Removed: B 3.15's write rule; `record_eval_run` admits `devos_ci`. Red: `N08-w-devos_ci` and `5B-R10-record_eval_run-ci`. |
| **Stage and environment** | C02, in `devos-test` (the job's test step) and on the throwaway database, with synthetic tokens. The real-token runs: W-C02-12 point 5 (the working, audit and `devos_kurulum` tokens on exam records; `T-W07-RT`). |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record); run by the job, W-C02-10's producer and W-C02-13's prober; judged by a fresh-context checker. Shared: model lineage, the design records and the README. |
| **Evidence layer** | Structural, at the database (`sql-set-role`). It does not show the `devos-evals` repository's access, what a session can see of an exam task in its own environment (C03; N-137, S2), or scoring (C05). |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case `ok`. There are 4 + 1 write cases, 5 per reading function, 2 structure cases and 2 positives. That was 14 on the stand-in, with one reading function. The red cases of each break are as above.<br>`transport`: `sql-set-role` or `throwaway`. `observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Appendix C N08, C:125 as PC-43 place 10 writes it. Scope as EV-C02-003 §4.5 and PC-43 place 10 give it (the executor's decision 6).

| Clause (verbatim) | Case IDs | Or: moved to |
|---|---|---|
| "The role under test cannot reach the exam answers" (claim) | the whole test, at the database | |
| "Every access to the exam records with the working, audit, installation (`devos_kurulum`) and CI (`devos_ci`) tokens … is rejected" | `N08-w-*`, `N08-w2-devos_calisma`, `N08-r-*`; direct table access: `T-W07-5A` | |
| "and to `devos-evals` with the working and audit tokens, is rejected" | | C01 (the `devos-evals` part, C01 #12) and C03 (N-137), by Appendix C's stage column: a repository, not the database |
| "the fact that an exam task is an exam is kept in an area the working environment cannot see" | the database part: `N08-s1`, `N08-s2`, and the read refusals `N08-r-*` | C03 (N-137, S2) for what a session sees; C05 may change the form (N-138) |
| "The exam environment accesses and scores" | "accesses": `N08-wp1`, `N08-wp2`, `N08-rp-*` | "scores": C05 (the grader's fields, B's activation table) |
| Stage "C01 …, C02 (the exam records' access rule in the database, with those four tokens; EV-C02-003 section 4.5), C03, C05" | C02: this test | C01, C03 and C05: theirs |

## Format gate

Not a format-gate test.

## Could not check

- Before the build, when the exam records' table or `record_eval_run` is absent (`N08-pre`).
- `N08-wp2`, when the work item cannot be planted or the exam call on it is not accepted. The arguments are then revised (README section 8).

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, with the scratch stand-in:
- without the build: COULD NOT CHECK;
- with the stand-in: PASS (14/14);
- B-N08-1 and B-N08-2 turned exactly their listed cases red.

## Not covered

- `devos-evals` and the session-level exam fact (C01, C03).
- Scoring and the grader's fields (C05).
- `devos_backup`'s read of exam records: C09's export design (EV-C02-003 §5.4). Its write cell is in `T-W07-5B` (R10, `bak`).
- A reading function that names the table only through another function or a view: the test finds readers by their own text. A reader through a second level is found only if `T-W07-5B` maps it to row R10r.
