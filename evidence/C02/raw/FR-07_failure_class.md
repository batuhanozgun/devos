# FR-07 input: researcher 2, the failure class

*The final report, verbatim, of agent `a6d5b92b6df90bf6b` (a fresh-context `researcher` subagent, workflow run `wf_664638e3-b44`, 2026-10-13), taken with `tools/subagent_audit.py last` after its end status; `tools/subagent_audit.py disciplines`: DISCIPLINES OK. An input to `plan/decisions/FR-07.md`, not a decision. Its line references are to the files as they stood when it read them.*

---

## Disciplines (D1–D9)
D1: yes: I tested my two-class reading against the strongest alternative frame, a single class ("one fact held in two representations, reconciled only by a reader"), and I say below where that choice changes the intervention. It does not change where to act.
D2: yes: The task pushes against "bad luck" and "more checks". Before classifying, I fixed my criteria: does each defect share a mechanism, and would a check of the kind that was added have turned red. I also report the evidence that favours luck (an undocumented 404) and that checkers did catch 8 of 9.
D3: yes: The purpose is to inform FR-07's choice of premise. I stayed with classification, where each class enters and is caught, and the squeeze count. I name what each remedy option would change but do not design it.
D4: yes: For each check that let a defect through, I asked whether it could have turned red if "it works on GitHub" or "the test and the build agree" were false. That question is the core of class I.
D5: yes: I read the verdicts, EV-C02-007 (main, and H1 at `1fa178d` in cw80) and T-W03-09 directly, not the task summary. The task says GitHub "rejected" the workflow; the record shows an offline parser result plus an inference.
D6: yes: Each defect gets three layers: proximate cause, the gap that let it through, and the premise behind that gap. For each fix I asked which layer it changes and whether the class can come back by another route. It did come back (14.14).
D7: no
D8: yes: Before classifying I read the state from cw80 (H1 head `1fa178d`, base `d33c8e9`) and from N-265 on `plan/work/C02.md`. I did not take the task's list as the whole state.
D9: uncertain: The research library is not in this working tree, and I did not consult it within budget. The analysis rests on the item's own records, and a library look at captured-fixture or contract-test practice is still open.

## Question
Do the blocking defects of W-C02-03 share one cause class or a few? Where in the flow does each class enter, and where is it caught? How many mechanisms has the item already added for the same class, and did each close the cause or only the symptom? This serves FR-07: which premise to question before a third attempt (`plan/Installation_Working_Order.md:69`; plan 6.12 item 2, `plan/DevOS_Kurulum_Plani.md:780`).

## Findings

**A. The nine blocking defects, after merging duplicates across lenses.** Each line gives the proximate cause, then the gap, then the premise.

1. **CHK-C02-017 F1** (`evidence/C02/checks/CHK-C02-017.md:32-42`). The break patches' guard refuses, yet the patch still applies when psql runs without ON_ERROR_STOP.
   - Cause: the guard is a separate `do` statement with no transaction around it.
   - Gap: the designer's runs used the flag (with it, the refusal holds, `:39`).
   - Premise: an unlabelled model of how psql behaves after an error.
   - **Class I.** Entered at test design. Caught by a checker running real psql without the flag.
2. **CHK-C02-017 F2** (`:44-49`). The prose spec claims `test_workflow_order.py` checks something it does not check.
   - Gap: nothing executes the spec's claims.
   - Premise: test specs are prose, bound to the code only by a reader.
   - **Class II.** Entered at test design. Caught by a checker reading both.
3. **CHK-C02-029 F-1 / CHK-C02-035 F1** (`CHK-C02-029.md:30-53`; `CHK-C02-035.md:31-37`). `${{` inside the `workflow_check` run body.
   - Stated: fix 2 (`d4eb7c6`) put five of them there and fix 3 (`ccd92f2`) the sixth (`CHK-C02-029.md:41-46`; `CHK-C02-038.md:138`). These were the fixes that added M22 rules and self-check copies after the four lenses (`EV-C02-007:239`, `:289`; `plan/work/W-C02-03.md:67`).
   - Gap: every M22 run, by producers and lenses alike, ran the body as PyYAML extracts it, outside GitHub (`EV-C02-007:637`).
   - Premise: "the body run locally is the body GitHub runs".
   - **Class I.** Entered in the fix rounds. Caught by a checker using GitHub's parser package offline. The record says GitHub "would have refused" the file (`EV-C02-007:689`), so the task's wording that GitHub rejected it is an inference.
4. **CHK-C02-035 F2** (`:39-45`). `git diff` was read without `-z`, so quoted file names passed silently.
   - Gap: the offline cases used plain names only.
   - Premise: a model of git's output.
   - **Class I.** Entered at the build. Caught by a checker running real git on a non-ASCII name.
5. **14.14** (cw80 `1fa178d`, EV-C02-007 `:1046-1056`). `pr_inputs` could never read the run report, because GitHub answers 404 for a skipped job's log.
   - Gap, stated in three parts:
     - The `c2_cases.py` stub "listed two jobs, both run, with no `conclusion` field" (14.14).
     - PR #304's live run printed the same HTTPError line. 12.8 item 1 had predicted it as an inference, and CHK-038 accepted it as foreseen (`EV-C02-007:793`; `CHK-C02-038.md:55`). The expectation absorbed the defect.
     - The class review after FAIL 1 covered only workflow-file constructs and found "no hole" (`EV-C02-007:691-704`; `CHK-C02-038.md:129-135`). It never reached the REST API.
   - Premise: `migrate.yml` first meets GitHub after merge (M04, `EV-C02-001:40`). `:233` weighed only a pre-merge *apply*. My search found no weighing of a pre-merge run without the credential (inference; the search was limited).
   - **Class I.** Entered at design (`EV-C02-007:68`), the build and the harness. It reached `main`, failing closed, from the #304 merge until H1. Caught live, on PR #309.
6. **H1 F-1** (CHK-043 F-1, CHK-044 F2, CHK-045 F-1; `CHK-C02-045.md:30-45`). The test and the build disagree on which run prints p4.
   - Stated: `main`'s T-W03-09 left p4 open (`d33c8e9:T-W03-09:24`, "a line that a run of `migrate.yml` prints").
   - The researcher's plan said "in one job only … gate the step or freeze merges" (`scratchpad/w03_live_plan_research.md:141`).
   - The producer (`3c80bf1`, 23:33:59Z) chose `check-devos-test` and weighed the push job (EV 14.2, "Why this job"). Four minutes later the test designer (`7eb8e26`, 23:37:47Z) wrote "prints in H1's push run".
   - The merge `1ef2d6b` (00:04:09Z) touched different files, so git saw no conflict.
   - Gap: nothing compares a revised test with the build at merge.
   - Premise: parallel production, plus "tests first" that binds only through reading.
   - **Class II.** Entered at the merge of parallel work. Caught by checkers reading both.
7. **H1 F-2** (`CHK-C02-045.md:47-63`). The record (EV 14.13, commit `30198e0`, the same second as the merge) spells the plant tagged 20261012T2338Z in plain form.
   - Gap: T-W03-09's premise, "only plain occurrences are the planted ones" (`T-W03-09:3`), is held by a list of forbidden carriers: commit messages, PR text, and raw logs before the search (`:27`). The researcher's warning covered raw logs only (`w03_live_plan_research.md:150`). Nothing scans tracked files for a live plant (CHK-045 F-2; CHK-044 F1).
   - Premise: records keep exact values, and they sit in the same public repository the search reads.
   - The producer had kept the workflow side safe by design (regex, base64, a stand-in tag; EV 14.2). The other artefacts relied on attention.
   - **Class II.** Entered in the records. Caught by checkers' mirror counts.
8. **H1 F-3** (`CHK-C02-045.md:65-69`; `plan/work/C02.md:414`). N-265's event deadline passed with no decision recorded.
   - Gap: nothing ties "the next change to `.github/workflows/`" to the merge gate or to the start of an item.
   - Premise: class-level guards are parked in notes because "the executor decides, and the test designer writes" (`C02.md:414`; `EV-C02-007:795-796`).
   - **Class III.** Its subject is class I. Entered at CHK-038's close and at H1's start. Caught by checkers reading the notes.
9. **CHK-045 F-4 / C4** (`:71-77`). The baseline scheduled run is required by the test prose (`T-W03-09:39`) but appears in no merge plan.
   - **Class II variant.** Caught by a checker's end-to-end trace.

**B. Counts.**
- Class I: 4 of 9 (items 1, 3, 4, 5). Class III, whose subject is class I, adds 1, so 5 of 9 relate to class I. Class II: 4 of 9 (items 2, 6, 7, 9).
- The producers' own offline tests caught 0 of 9. Checkers caught 8: four by putting a real component in place of a model (psql, GitHub's parser package, git, a mirror of GitHub's refs), three by reading artefacts against each other, and one by an end-to-end trace. The live run caught 1.
- Non-blocking class II findings appear at almost every verdict: `CHK-C02-029` F-3, `CHK-C02-035` C3 to C5, `CHK-C02-038` F-10, `CHK-C02-039` C1.
- Platform unknowns that were labelled as such were handled well: PostgreSQL 16 vs 17.6, the archive layout f, the pooler tenant, `queue` (EV 10.2, 14.3, 14.6; `CHK-C02-039.md:62-70`). The class I defects came from assumptions that were *not* labelled, hidden in stubs and harnesses.

**C. The squeeze: mechanisms already added, with whether each reached the cause.**
- **Class I, about 13 mechanisms:**
  - M22 rules and self-check copies (fixes 2 and 3): in the repository, but they *introduced* FAIL 1.
  - The `OPEN` constant (`EV-C02-007:639`): symptom.
  - One-off and kept outside the repository (`:795`): the `${{` scan (`:643-649`), the parser and actionlint runs (`:651-673`), and the "as handed" harness (`:675-687`).
  - The class audit 12.2: one-off, and too narrow.
  - Reading the pull request's own GitHub run (`:793`, `:802`): this is the only practice that touches the real platform. On #304 its expectation absorbed the defect; on #309 it found it.
  - `c2_cases.py`: one-off, and its stub carried the next defect.
  - N-265: deferred, and unmet at its deadline.
  - The per-job read in `pr_inputs` (`f266f84`): symptom.
  - `c2b_cases.py`: kept outside the repository (CHK-045 F-3).
  - `gate_sim.mjs` and `mini_run.mjs`: the record itself says "Not a repeatable check" (EV 14.1 on cw80).
  - Each checker also installs its own parser (CHK-038 F-2; CHK-043 F-8).
  - **Mechanisms that close the cause and repeat in the repository: 0.**
- **Class II, at least 6 mechanisms:** the CHK-017 C2 correction; dated record corrections after CHK-029 F-3, CHK-035 C3 to C5 (where the records option was chosen, EV 12.5 and 12.6), CHK-038 F-10 and CHK-039 C1; the README's revision line; and CHK-045 C1 and C2 (revise the test; retire the tag with a one-off mirror count). All treat the symptom. The one cause-level design is the plant step's own (EV 14.2), and it covers the workflow file only.
- 6.12 item 2's signal "sees only what is recorded" under one class (`plan:780`). Each defect was recorded under its own label, so nothing fired before the second FAIL. The checkers at H1 were the first to name 14.14 as N-265's class (`CHK-C02-043.md:19`; CHK-045 F-3).

**D. "Bad luck" and "more checks", tested against the record.**
- **Bad luck is refuted.**
  - The class I defects share one mechanism: an unlabelled model of an external system sits inside both the code and the check that tests it. They arrived about once per round.
  - A class review that declared "no hole" was followed by 14.14.
  - Both H1 defects came from process choices (parallel revision of an open parameter; records holding exact values), and the record had foreseen each one in kind.
  - What supports luck: the skipped-job 404 seems undocumented. One search found only the documented 302 ([GitHub REST workflow jobs](https://developer.github.com/v3/actions/workflow_jobs/); [GHES mirror](https://docs.github.com/fr/enterprise-server@3.19/rest/actions/workflow-jobs); limited). This instance was hard to foresee. The class was not.
- **"More checks" is refuted.**
  - About 20 mechanisms were added. Most were one-off and of the same kind: offline models written by the same model lineage. They cannot turn red when the model is wrong (D4; plan 6.11 at `:767`, "roles that use the same model can share the same blind spot").
  - One added check caused FAIL 1.
  - N-265 as written (a `${{` rule and a `pr_inputs` test against git) would not have caught 14.14 unless its stub copied GitHub's real job list (inference).
  - What worked was replacing the model with the real component.

**E. The premises.**
- **P1 (class I):** platform behaviour is evidenced by offline models that the producer's lineage writes, and `migrate.yml` first meets GitHub after merge. The design conflated "no pre-merge apply" with "no pre-merge exercise" (inference from `EV-C02-001:233`).
- **P2 (class II):** facts are duplicated in prose (test specs, a record of more than 1,000 lines) and reconciled by a reader at one head. Running test revision and build in parallel removes the ordering that "tests first" would otherwise give.
- **P3 (the shared detection gap):** each check is re-derived per head and kept outside the repository. The role split sends every repeatable check through a separate test-designer item, so the item's learning does not persist between rounds (inference from `C02.md:414` and `EV-C02-007:795-796`).

## Counter-evidence and alternatives
- **The gate is working.** Checkers caught 8 of 9 before merge, and the one defect that reached `main` failed closed. A defensible reading is that the FAILs are the gate doing its job. The loop rule still asks which premise produces the recurrence.
- **Single-class frame.** "Two representations of one fact, reconciled only by a reader" fits all nine. It points to the same actions: fewer hand-held representations, and the rest tied mechanically to their source.
- **Speed was a real constraint.** Running H1 in parallel saved time, and the reason for it is not read.

## Open (what I could not read)
- The four lens files at `762640d` (`scratchpad/w03lens_*.json`).
- `CHK-C02-008`, `-011`, `-013` and `-020`.
- `EV-C02-001` beyond targeted greps.
- The C02 log entries L-289 to L-303, so the reason H1 ran in parallel is unread.
- PR #304 and #309 and their run logs on GitHub.
- The researcher's plan beyond lines 140 to 160.
- The library.
- Whether `5cad061`'s file was ever run by GitHub on a pull request.
- Whether a credential-free pre-merge exercise was weighed anywhere I did not search.

Process note: a filtered read of CHK-044 showed its line that holds the old plant. I did not copy it.

## For the decision
Each finding below gives the remedy option and the layer it changes, so FR-07 can choose. Another round of one-off scans, harnesses or reviewer lenses of the same kind would treat the symptom only.

- **Class I.** Close the cause by bringing the real platform in before merge without the credential, or by making the offline stubs replay responses captured from GitHub. The saved job lists and logs of runs 38319371450 and 38325999697 exist and could serve. Either check should be repeatable and live in the repository.
- **Class II.**
  - Make the shared facts executable: `test_workflow_order.py` asserts T-W03-09's placement and stage.
  - Put a reconcile step at the merge of parallel work.
  - Add a repository-wide scan for the live plant tag in tracked files.
  - Restate less code in the records (plan 6.12 item 4).
- **Class III.** Tie event deadlines to pull requests that touch the named path, or turn N-265 into an item now. Widen its class from "`${{` and quoted names" to "a model of GitHub written by us".

## Guard denials
None.
