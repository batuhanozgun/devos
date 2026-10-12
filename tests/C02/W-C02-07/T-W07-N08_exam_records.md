# T-W07-N08 · Only the exam environment's token reaches the exam records (N08's database part in C02)

Synthetic test data (plan Section 8 item 13): five synthetic tokens (working, audit, installation, CI, exam) are issued at run time in the rolled-back transaction. One work row is planted as owner, with text `w07_fixture SYNTHETIC W-C02-07`. Exam results are the neutral JSON `{"w07_fixture": "SYNTHETIC W-C02-07"}`. No exam content exists in C02. Part X (phase C4b) makes, inside its own rolled-back transaction, a synthetic `batu` decision answered at owner level, a Mission on it, work items, effort policies, relations and exam runs, labelled `SYNTHETIC W-C02-07` or `w07_fixture`; a claim token's value is replaced before any answer is kept.

**Phase C4b (EV-C02-008 section 5.1, N-262, decided and accepted; PC-47 place 1, B:286; CHK-C02-027, CHK-C02-032).** DM-35 hides the exam's own records, never the Work (5.1 (a)); property P: for `devos_calisma`, `devos_kurulum` and `devos_ci`, every C02 function gives the same answer on a work item an EvalRun names as on the same work item with no EvalRun (5.1 (c)), within five bounds. This test gains: the reader finder's exemption of nine functions named in 5.1 (part A); and part X, a file of its own, with N08-s3, N08-s4, the EXF pairs (5.1's EXF-pair-*, which carry 1.7.1's "answers equal" case) and N08-x-<function>-<class>. Part X keeps EV-C02-008 5.1's suggested case IDs, EXF-pair-* among them, as `T-W07-N28` keeps section 2.5's S-* IDs; they are this test's cases.

**Serves.** W-C02-10 point 5, fourth bullet: "✘ EvalRun written or read with any token but `devos_sinav`'s is refused (B 3.15; the access rule C03's N08 needs); N08's run with the `devos_kurulum` token is shown here if W-C02-05's record keeps it in C02 (N-136)". EV-C02-003 §4.5 keeps it: "N08's database part … also runs in C02, with the working, audit, `devos_kurulum` and `devos_ci` tokens".

Also W-C02-07 point 2's N-136 extension ("N08 with the `devos_kurulum` token"), and the executor's decision 6 (EV-C02-003 §4.5; PC-43 place 10). Design relied on:
- Appendix B 3.15 (B:273: "`EvalRun` and `Competence` are written only with the `devos_sinav` role, and `EvalRun` is read only with it");
- B section 2's `devos_kurulum` "Cannot" (PC-43 place 5);
- EV-C02-002 DM-24 (the exam fact lives only in EvalRun's `work_ref`; no exam field on Work);
- EV-C02-003 §5.2 (`devos_ci`'s key treated as readable by every session).
- Part X: EV-C02-008 5.1 (a) to (c) and its table; 1.7.1 (Rules O and C) and 1.7.4 (`set_effort_policy`'s kind (a)). Its items: N08-s3 serves W-C02-10 point 5 (EvalRun's write rule); N08-s4's three claim cases serve W-C02-09 points 4 and 8 (`claim` is W-C02-09's, EV-C02-008 5.3) and N08-s4-run W-C02-10 point 5; the EXF pairs and N08-x serve W-C02-09 point 8 (the authorization test with the checks after the gate; the two reads) and W-C02-10 point 5 (separation: the exam fact).

**Command.** (statement timeout 120 s, README 5.1 (a)) `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n08_exam_records.sql` (part A) and `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n08_exam_fact.sql` (part X, phase C4b; statement timeout 180 s), each in `devos-test` by the job's test step as `postgres`, and on the throwaway database by the harness. The test is PASS only when both files are.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. As `T-W07-IDC`. Beyond it:
- EvalRun's table is `devos_private.eval_run` and Work's is `devos_private.work` (`w07_cfg`);
- `devos_api.record_eval_run` writes EvalRun;
- the full positive fills an argument whose name matches `work` with the planted work's key.

B section 4 names no function that reads EvalRun. So the test finds every `devos_api` function whose text names EvalRun's table, `competence_summary` excepted (B 3.15 lets other classes call it, and it returns no exam content; its content rule is C05's), and holds each to the read rule.

**The finder's exemption (phase C4b; EV-C02-008 5.1, after CHK-C02-027 D; fixed before any result).** Nine functions are exempt by name: `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `relate`, `retract_relation` and `set_effort_policy` (Rule O's `devos_sinav` limit, 1.7.1; kind (a), 1.7.4; `relate`'s own reason for `devos_sinav`, 5.1 (b)), and `affected_entities` and `explain_paths` (the exam record shown to `devos_sinav`, F04-c-sin). Each admits some of the four classes, and the build reads EvalRun's table in it only on the branch where the caller's class is `devos_sinav`. `claim`, `ready_works`, `heartbeat` and `release` are not on the list: they need no read of the table, since 5.1 (c) 3 refuses `devos_sinav` every claim. The file prints the exempt functions it finds that name the table. Their answers to the four classes are part X's N08-x cases; their `devos_sinav` answers are `T-W07-F04`'s F04-c-sin, N08-s4 and `T-W07-ROC`'s Rule O cases; `relate`'s refusal of an exam record as an end is F04-m4. Every other function whose text names the table stays under the role-refusal rule, so a reader the build adds is still found.

**Part X's interface (phase C4b; README 8.1 holds where this differs).**
- Group C's fixtures and call forms, copied from `T-W07-ROC`'s file (README section 7), with five more: `heartbeat(claim_token text)`, `release(claim_token text)`, `ready_works()`, `affected_entities(root uuid, limits jsonb)`, `explain_paths(root uuid, target uuid, limits jsonb)`.
- `record_eval_run(p jsonb)` with B 3.14's EvalRun fields: `work_ref`, `work_revision`, `eval_set_id`, `eval_set_version`, `subject_role`, `subject_release`, `runner_session`, `results`, `run_at` (README 8.1's v1 form; part A's N08-wp2 now uses it too, since its old substitution by argument name never reached `p`).
- Event's `aggregate_id` (B 3.13): the events "on the Work" are those whose `aggregate_id` is the work item's id. Assignment's `work_ref`, `role_class`, `status` (B 3.5) for N08-s4-run's planted claim and for reading a claim's generation (`generation`, read as owner when the column exists).
- "Ids aside": every uuid in an answer is replaced by `<id>`, a claim token's value by `<claim token>` before the answer is kept, and keys ending in `_at` (times within the one transaction) are dropped; status, reason codes and every other value are compared as they are.

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

**Part X (phase C4b; `w07_n08_exam_fact.sql`; EV-C02-008 5.1's table).**
- **Fixtures, in the order 5.1 and CHK-C02-032 F11 (d) give.** A Mission (Group C's, with the `devos_kurulum` token on an answered `batu` decision). w_e: opened through `admit_work` with the exam token. Before its EvalRun exists, `claim` on w_e with the exam token (case `EXF-pair-sin-claim`: refused after the gate, its own reason code, recorded once; it is not undone, so that a build that admitted it would leave the claim). Then an EvalRun naming w_e through `record_eval_run` with the exam token (and, read as owner, an EvalRun row whose `work_ref` is w_e). Then w_e's kind (a) effort policy with the exam token, which Rule O admits only once the EvalRun names w_e. w_o: opened through `admit_work` with the working token, with the same payload (Mission, scope, purpose, labels) and the same effort policy, and no EvalRun. Also w_x (for relations) and, on each side, the walk graph r <- x <- item <- y (descriptive `derived_from` relations), made with the working token. If a fixture call is not accepted, `EXF-pair-fixtures` gives `could_not_check` with the reason, and the pair cases do not run.
- **EXF-pair-<function>** (working token), each run on w_e and on w_o in a subtransaction undone after it, and compared step by step, ids aside:
  - `EXF-pair-ready_works`: it lists both or neither, and its rows for them are the same, ids aside.
  - `EXF-pair-claim`: the first claim (accepted) and its generation, read as owner; a second claim by another working session (refused).
  - `EXF-pair-heartbeat`, `EXF-pair-release`: claim, then `heartbeat` or `release` with its token (accepted), and with the released claim's token (refused).
  - `EXF-pair-revise_work`: a revision on the current revision (accepted), a stale revision, an empty required field (`purpose`).
  - `EXF-pair-mark_stale`, `EXF-pair-cancel_work`: with a reason (accepted), again, and with an empty reason.
  - `EXF-pair-reopen_for_review`: on the open item, and on the item planted finished and accepted.
  - `EXF-pair-relate`: a hard `depends_on` from the item (accepted), the opposite one (a cycle), an empty type.
  - `EXF-pair-retract_relation`: a hard relation from the item made with the working token, retracted (accepted) and retracted again.
  - `EXF-pair-set_effort_policy`: kind (a) at the default (accepted), an empty expert assessment, a reduction with no approval.
  - `EXF-pair-reads-affected_entities`, `EXF-pair-reads-explain_paths`: the two reads as in `T-W07-F04`'s F04-e-exam (from r, with the item as root; from r to the item, from the item to y).
  - Each pair needs its accepted step accepted on at least one item; accepted on neither is `could_not_check` (no comparison in a refused state only); accepted on one and refused on the other is `bad`.
  - `EXF-pair-state` (as owner): the Work row, its revisions, the events whose aggregate is the Work and the effort policies of w_e and w_o are the same, ids, times, transaction ids and the events' `role_class` aside, and the Work has at least one event (bound 2; DM-24).
- **N08-x-<function>-<class>** (EV-C02-008 5.1, after CHK-C02-027 D): EXF-pair's comparison for each of the nine exempt functions, with each of the working, audit, `devos_kurulum` and `devos_ci` tokens (`cal`, `den`, `kur`, `ci`): 36 cases. Same status, reason code and result, ids aside, on w_e and w_o; no accepted step is required (most are refused for these classes). N08-x passes no exam record's own id; F04-m4 does.
- **N08-s3**: `record_eval_run` with the exam token on a work item opened with the working token: the Work's row, revisions and events (all, by `aggregate_id`), read as owner before and after, are unchanged; the call is accepted (else `could_not_check`).
- **N08-s4** (revised after CHK-C02-027 C): `claim` with the exam token, each in a subtransaction undone after it, on w_e (an EvalRun names it: `N08-s4-claim-linked`), on a work item `devos_sinav` opened that no EvalRun names (`N08-s4-claim-unlinked`), and on one `devos_calisma` opened (`N08-s4-claim-working`): each refused after the gate (a reason code that is neither the role gate's nor a token code) and recorded once under `devos_sinav`. `N08-s4-code`: the three codes are one code. `N08-s4-run`: `record_eval_run` with the exam token on a work item that carries an active claim of class `devos_sinav`, planted by the owner (a state only a fault makes): refused, recorded once, and no EvalRun row added.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-N08. Appendix C's claim: "The role under test cannot reach the exam answers". Its C02 part is the exam records' access rule in the database (PC-43 place 10). |
| **Failure class rule** | **[Designer's addition: Appendix C's C2 rows give none (R2 section 5 (c)).]** Any path by which a token other than the exam environment's writes or reads an exam record or the exam fact. That includes any function that reads EvalRun, and any field outside the exam records that carries the exam link. Phase C4b (EV-C02-008 5.1 (c)): also any answer that differs between an exam task and ordinary work for the working, `devos_kurulum` or `devos_ci` class, any write of `record_eval_run` on the Work, and any claim of class `devos_sinav`. |
| **Examples** | **[Designer's addition, as above.]** (1) The original finding (C:125): the working or audit token reads the exam records (`N08-r-*-devos_calisma`, `N08-r-*-devos_denetim`). (2) Another manifestation: the installation or CI token writes or reads one (`N08-w-devos_kurulum`, `N08-w-devos_ci`, `N08-r-*-devos_ci`; N-136; EV-C02-003 §5.2). (3) Another: the exam fact leaks through a field on Work or a link from another table (`N08-s1`, `N08-s2`; DM-24). (4) Phase C4b: through an answer, a function that answers an exam task differently (`EXF-pair-*`, `N08-x-*`), the opener's class in a read (`EXF-pair-ready_works`), an exam run written on the Work (`N08-s3`, `EXF-pair-state`), and a claim of class `devos_sinav` that Rule C would then show (`N08-s4-*`, `EXF-pair-sin-claim`). |
| **Negative control** | Every `N08-w-*`, `N08-w2-*` and `N08-r-*` case: refused, recorded once per call under the token's class, no event, no table changed. `N08-s1` and `N08-s2`: none found. Part X: `N08-s4-*` and `EXF-pair-sin-claim` refused after the gate and recorded; `N08-s3` nothing written on the Work. |
| **Positive control** | `N08-wp1`, `N08-wp2` and `N08-rp-*`: "The exam environment accesses". Part X: `record_eval_run` with the exam token accepted in the fixtures and in `N08-s3`; each EXF pair's accepted step (a working session's claim, revision, cancellation, relation and policy on an exam task, as on ordinary work). |
| **Break attempt** | **[Designer's addition, as above.]** Each patch is applied by the harness on the throwaway database (README 5.2).<br>**B-N08-1** (`breaks/B-N08-1_exam_read_admits_working.sql`). Removed: B 3.15's read rule; every function that reads EvalRun's table also admits `devos_calisma`. Red: `N08-r-<function>-devos_calisma` for each such function. The patch's line names the stand-in's `read_eval_runs`, and the prober writes the build's function names in before the run.<br>**B-N08-2** (`breaks/B-N08-2_exam_write_admits_ci.sql`). Removed: B 3.15's write rule; `record_eval_run` admits `devos_ci`. Red: `N08-w-devos_ci` and `5B-R10-record_eval_run-ci`.<br>Phase C4b, part X (EV-C02-008 5.1's table): **B-N08-3** (`breaks/B-N08-3_exam_run_event_on_work.sql`): `record_eval_run` also writes an event on the Work. Red: `N08-s3`, `EXF-pair-state`. **B-N08-4** (`breaks/B-N08-4_exam_claim_on_unlinked_item.sql`): `claim` admits `devos_sinav` on a work item no EvalRun names (the first version's bound 3). Red: `EXF-pair-sin-claim`, `N08-s4-claim-unlinked`, `N08-s4-claim-working`, `N08-s4-code`. **B-N08-5** (`breaks/B-N08-5_exam_run_claim_check_removed.sql`): `record_eval_run`'s claim check removed. Red: `N08-s4-run`. **B-EXF-1** (`breaks/B-EXF-1_ready_works_shows_opener.sql`; bound 4): `ready_works` returns each row's creation-event `role_class`. Red: `EXF-pair-ready_works`. Breaks of other tests that also turn part X red, each listing this file: `T-W07-ROC`'s **B-ROC-1** (Rule O reading the exam link for `devos_calisma`, 1.7.1's break): `EXF-pair-cancel_work`, `N08-x-cancel_work-cal`; `T-W07-F04`'s **B-F04-4** and **B-F04-5**: `EXF-pair-reads-affected_entities`, `EXF-pair-reads-explain_paths`, `N08-x-affected_entities-cal`, `-den`, `-kur`, `N08-x-explain_paths-cal`, `-den`, `-kur`. Two differences from EV-C02-008 5.1's table, stated: under B-N08-4 the EvalRun the fixtures write on w_e is refused by bound 3's second layer (`record_eval_run`'s claim check), so the pair cases on w_e give `could_not_check` and the red cases are the claims themselves; and B-N08-3's red cases are `N08-s3` and the owner's view `EXF-pair-state`, since no read callable by the working class returns a Work's events (bound 4), so no answer-level pair can show an extra event. |
| **Stage and environment** | C02, in `devos-test` (the job's test step) and on the throwaway database, with synthetic tokens (part X: working, audit, exam, `devos_kurulum` and `devos_ci`). The real-token runs: W-C02-12 point 5 (the working, audit and `devos_kurulum` tokens on exam records; `T-W07-RT`). |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record); run by the job, W-C02-10's producer and W-C02-13's prober; judged by a fresh-context checker. Shared: model lineage, the design records and the README. |
| **Evidence layer** | Structural, at the database (`sql-set-role`). It does not show the `devos-evals` repository's access, what a session can see of an exam task in its own environment (C03; N-137, S2), or scoring (C05). Part X compares answers on one pair of work items: it is behavioural evidence of property P for the functions and steps it calls, not of every input. |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case `ok`. There are 4 + 1 write cases, 5 per reading function, 2 structure cases and 2 positives. That was 14 on the stand-in, with one reading function. Part X: 57 cases (13 EXF pairs with the sin-claim and state cases, 36 N08-x cases, N08-s3, and five N08-s4 cases), each expected `ok`. The red cases of each break are as above.<br>`transport`: `sql-set-role` or `throwaway`. `observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Appendix C N08, C:125 as PC-43 place 10 writes it. Scope as EV-C02-003 §4.5 and PC-43 place 10 give it (the executor's decision 6).

| Clause (verbatim) | Case IDs | Or: moved to |
|---|---|---|
| "The role under test cannot reach the exam answers" (claim) | the whole test, at the database | |
| "Every access to the exam records with the working, audit, installation (`devos_kurulum`) and CI (`devos_ci`) tokens … is rejected" | `N08-w-*`, `N08-w2-devos_calisma`, `N08-r-*`; direct table access: `T-W07-5A` | |
| "and to `devos-evals` with the working and audit tokens, is rejected" | | C01 (the `devos-evals` part, C01 #12) and C03 (N-137), by Appendix C's stage column: a repository, not the database |
| "the fact that an exam task is an exam is kept in an area the working environment cannot see" | the database part: `N08-s1`, `N08-s2`, and the read refusals `N08-r-*`; phase C4b, served in C02 by DM-24's form and EV-C02-008 5.1 (c) (property P, as a testable property): part X's `EXF-pair-*`, `N08-x-*`, `N08-s3`, `N08-s4-*` | C03 (N-137, S2) for what a session sees; C05 may change the form (N-138) |
| "The exam environment accesses and scores" | "accesses": `N08-wp1`, `N08-wp2`, `N08-rp-*` | "scores": C05 (the grader's fields, B's activation table) |
| Stage "C01 …, C02 (the exam records' access rule in the database, with those four tokens; EV-C02-003 section 4.5), C03, C05" | C02: this test | C01, C03 and C05: theirs |
| (not Appendix C; EV-C02-008 5.1's table and its list for T-W07-N08) N08-s3, N08-s4, the finder's exemption with N08-x, the EXF pairs (which carry 1.7.1's "answers equal" case) | part X: `N08-s3`, `N08-s4-*`, `N08-x-*`, `EXF-pair-*`; the exemption in part A | — |

## Format gate

Not a format-gate test.

## Could not check

- Before the build, when the exam records' table or `record_eval_run` is absent (`N08-pre`); part X when a function or table it needs is absent (`N08-pre-x`).
- `N08-wp2`, when the work item cannot be planted or the exam call on it is not accepted. The arguments are then revised (README section 8).
- Part X: `EXF-pair-fixtures` when a fixture call is not accepted (for example `record_eval_run`'s payload in another form), and then no pair runs; a pair whose steps are not answered in interface v1's form, or whose accepted step is accepted on neither item; `EXF-pair-state` and `N08-s3` when Event has no `aggregate_id`; `N08-s4-run` when the active claim cannot be planted.

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, with the scratch stand-in:
- without the build: COULD NOT CHECK;
- with the stand-in: PASS (14/14);
- B-N08-1 and B-N08-2 turned exactly their listed cases red.

Phase C4b, 2026-10-12, PostgreSQL 16.15, on a scratch stub of README 8.1 and EV-C02-008 sections 1, 2 and 5 (outside the repository, not delivered; the test designer's reading of the design, not the build: a pass on it is no evidence about the build): part A PASS (9/9; the stub reads EvalRun only in `devos_private` helpers, so the finder found no reader); part X PASS (57/57); B-N08-3, B-N08-4, B-N08-5, B-EXF-1, and B-ROC-1, B-F04-4 and B-F04-5 on part X, each turned exactly its listed cases red, the file ending in FAIL. Two faults of the test's own were found and fixed before any result: a pair accepted on one item and refused on the other was first counted `could_not_check`, which hid B-ROC-1 (now `bad`); and the order of `cancel_work`'s steps made the pair depend on how the build treats an empty reason. On an empty database: COULD NOT CHECK.

## Not covered

- `devos-evals` and the session-level exam fact (C01, C03).
- Scoring and the grader's fields (C05).
- `devos_backup`'s read of exam records: C09's export design (EV-C02-003 §5.4). Its write cell is in `T-W07-5B` (R10, `bak`).
- A reading function that names the table only through another function or a view: the test finds readers by their own text. A reader through a second level is found only if `T-W07-5B` maps it to row R10r.
- The nine exempt functions' `devos_sinav` branches beyond F04-c-sin, N08-s4 and `T-W07-ROC`'s Rule O cases, and an exempt function that would read EvalRun for another class through a value N08-x's steps do not reach: N08-x covers the steps listed.
- Property P for `devos_denetim`: it fails through two reads by design (RejectedAttempt and a sample's creation event; EV-C02-008 5.1 (d)), open until C05 opens an exam task for an audit role (N-138 on `plan/work/C05.md`); N08-x's `den` cases cover only the nine functions' answers. The export to `devos-backup` (5.1 (d)): C09's, before its first export (N-176 on `plan/work/C09.md`).
- Bound 5 (the task's text, scope, Mission, labels and `work_class` look like ordinary work's): out of the database's reach (5.1 (c) 5); part X gives w_e and w_o the same payload, which shows nothing about C05's exam sets.
- Values outside an answer that could still differ (timing; a time in a key ending in `_at`, dropped here): not compared.
