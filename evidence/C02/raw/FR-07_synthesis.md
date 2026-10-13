# FR-07 input: the synthesis of the three

*The final report, verbatim, of agent `ac40204e4b7ed460d` (a fresh-context `researcher` subagent, workflow run `wf_664638e3-b44`, 2026-10-13), taken with `tools/subagent_audit.py last` after its end status; `tools/subagent_audit.py disciplines`: DISCIPLINES OK. An input to `plan/decisions/FR-07.md`, not a decision. Its line references are to the files as they stood when it read them.*

---

## Disciplines (D1–D9)
D1: yes: I compared the current frame with three alternatives: dispatch for the compare-only jobs, taking p4 out of the binding control, and the counter-assessment's full rehearsal with stacked verdicts. The recommendation depends on one fact I could not read, so it is stated conditionally: whether GitHub fires the :41 schedule on time.
D2: yes: I fixed my test before weighing anything: does a change remove a premise or only add a check around it, and what does it cost on the critical path. I tested both pulls, "keep the written campaign" and "look different from it". I keep the cron and p4 only on cost and risk, and I drop C4's wait only under C4's own exception.
D3: yes: I traced each recommended change to the acceptance points it serves (5 to 9 and 14) and to W-C02-03's acceptance as the end state. Nothing I recommend changes the acceptance block, or changes T-W03-09 after a result exists.
D4: yes: for each proposed check I asked whether it could turn red on the failure it targets. The credential-free rehearsal on GitHub can turn red on stray copies and on unreadable refs or archives. It shares the token-reach assumption with S2, though, so I label it exploratory and keep S2 as the binding observation.
D5: yes: I read the verdicts, W-C02-03.md, EV-C02-001, EV-C02-007 section 14, T-W03-09 and migrate.yml at 1fa178d, log entries L-301 to L-304, notes N-257 and N-265, and merge_gate.py myself. I did not rely on the three reports' summaries. Claims that rest only on the executor's scratchpad notes are marked.
D6: yes: for each failure I separated the proximate cause, the prevention gap, the detection gap and the premise. For each change I state which layer it alters and whether the class can come back by another route; the search's first live run is that route.
D7: no
D8: yes: main is at 85a3943 (L-304, PR #311), H1's head is 1fa178d in cw80, and PR #310 is open with its check red by design. GitHub's state after 00:45Z could not be read here.
D9: uncertain: the research library has no local copy and the task did not name it. The premises are this repository's own, so I did not consult it, and I list that as a limit.

## Question
FR-07 asks which premises produce W-C02-03's recurring failures, whether each premise is necessary, and what frame the third attempt and the rest of the live campaign should use. It serves the frame review that working order §6 item 2 requires before a third attempt (/home/user/devos/plan/Installation_Working_Order.md:69). Labels: [S] stated, [I] my interpretation, [Inf] my inference, [est] my estimate.

## (1) The premises behind the failures

**P-A. GitHub-facing code without the secret first meets GitHub after the merge. Before the merge, models written by the same lineage stand in as the evidence: extracted bodies, stubs written from belief, and simulators.**
- Failure 1 [S]: every offline run executed the body outside GitHub. GitHub's parser package refused the file (C02-log.md:235, :242).
- Failure 3 [S]: the stub listed two jobs, both run. Every real run lists four jobs and skips two (C02-log.md:264-265). The design already says so (EV-C02-001:27), so the stub contradicted the repository's own record [Inf].
- The class is still open [S]. The search, the next GitHub-facing code, has never run on GitHub: no scheduled run had happened at 00:33Z (CHK-C02-045:42). Its archive layout is still "could not check" (cnc) (EV-C02-007 at 1fa178d, 14.3 and 14.6).
- Counter-evidence [S]: each time a real component replaced the model, the defect was caught: GitHub's parser (CHK-C02-038), PR #309's own check (C02-log.md:265), and the pinned CLI on PostgreSQL for P2 (pending_log_notes.md:142).

**P-B. One revision is built from parts that helpers write in parallel without seeing each other. Their tasks leave an interface fact open, and only a reader reconciles the parts at the end. The bundle also grows while it is being built.**
- The research plan left open which run prints p4, and assumed the print would come in H1's push run with merges frozen (scratchpad w03_live_plan_research.md:141-142, :244-245) [S].
- The executor's decision named the step but not its job (pending_log_notes.md:140) [S, scratchpad only].
- The producer put the print in the scheduled job (3c80bf1; EV-C02-007 14.2, "Why this job"). Four minutes later the test designer wrote "prints in H1's push run" (7eb8e26; T-W03-09:24). The merge 1ef2d6b produced no conflict (CHK-C02-043:36) [S].
- The same class shows in C4: the test requires a baseline run that no merge plan contains (CHK-C02-045:71-77).
- The fix f266f84, added mid-flight, made H1 the change on which N-265's deadline fell (C02.md:414).

**P-C. The synthetic plant is an exact value that every writer handles as text. It sits in a public corpus where pull-request refs keep any pushed copy permanently. T-W03-09's exact counts make one stray copy fatal to the tag, and each tag lives in a class-high file.**
- EV-C02-007 14.13 spelled the plant. Three blobs holding it stay reachable from refs/pull/309 (CHK-C02-045:47-57) [S].
- The value was kept in a scratch file the executor copied from (pending_log_notes.md:143) [S].
- Nothing counts the plant before a push (CHK-C02-045:63) [S].

**P-D. A class guard that a verdict finds is parked in a note whose event deadline nothing enforces.**
- CHK-C02-038 F-11 became N-265 (C02.md:413-415).
- The deadline was seen only after a compaction (C02-log.md:262, D3).
- The same class came back as 14.14 (CHK-C02-043:54-58) [S].

**P-E (multiplies cost; not a cause). The search can be reached only through the 6-hourly schedule (M04, EV-C02-001:40).**
- A round needs two slots: S1 prints, S2 searches. It has no cheap retry, and S2 must come before 2026-10-19 (N-266; EV-C02-007 14.3 and 14.12.2) [S].
- The design's PC-23 row says the schedule adds "None" (EV-C02-001:267). That is incomplete: the schedule gates T-W03-09, and with it the acceptance [I].

**The common frame [I].** The campaign keeps class-high merges and scheduled waits few by bundling parts made in parallel and by modelling GitHub offline. The price is that consistency, and the truth about the platform, are checked only by a reader at the end. Researcher 2's single-class reading ("one fact, two representations, reconciled by a reader") points to the same places to act. P-C is the case where the second representation is a copy that must not exist at all.

## (2) Which parts are necessary, and the alternatives

| Premise | Necessary part | Alternatives (cost) | Choice |
|---|---|---|---|
| P-A | Secret-holding steps run only on main, after the merge (W-C02-03.md:44; M31, EV-C02-001:67, :233) | A1: run all GitHub-facing code that needs no secret on GitHub, in a PR job, before the verdict. For the search this is T-W03-09's break-copy workflow (T-W03-09:38), with the unbroken copy run first. Cost: one producer task and a 5–10 min run; never merged; exploratory only. A2: repeatable tests replay responses captured from GitHub, as N-265's guard 2 does with run 38319371450's job list (C02-log.md:268); small cost. A3: an offline rehearsal of H2→H5 on PostgreSQL 17 with the pinned CLI and the job's own decision bodies; runs during the S1/S2 wait. Rejected: any pre-merge run that holds the credential (it contradicts point 8). | A1 and A2 now; A3 before H2 |
| P-B | None. Bundling is fine; working blind in parallel is not | B1: the executor fixes the interface facts in each task. The producer builds first, then the test designer revises the test after reading the build. The role may read the product (test-designer.md:32 bans only writing it), and tests must merge before results, not before the build. Cost: 30–60 min run in series [est]. B2: make the shared fact executable, e.g. test_workflow_order.py asserts where the plant step sits; small cost, class normal. B3: freeze a revision's scope once its tasks are out; a mid-flight finding becomes its own change. | B1 and B3; B2 optional |
| P-C | Plants in devos itself; the exact count, which keeps the control from failing open (CHK-C02-045:56) | C1: make the plants last; produce the value from the tag at the point of use and never store it in a file; records name the tag only; before each push, run the search's own counting code over the local clone; minutes. C2: a separate tag per place (search change, class high). C3: the plant in a repository variable, so a new tag needs no merge (a new input to a secret-holding job; needs a security review). C4: report object IDs instead of totals. | C1 now; C2/C3 only if a second tag is spoiled |
| P-D | None | D1: meet N-265 now, and in future make a class guard a condition of the verdict that finds the class whenever the next change can repeat it. D2: tie event deadlines to the merge gate (a new mechanism). | D1 |
| P-E | Security simplicity of M04 is a real reason | E1: keep the cron, plan S1/S2 explicitly, and run the fixture campaign in parallel. E2: `workflow_dispatch` for the compare-only jobs. It saves about 6 h per round, but changes M04, M22, points 1(b), 8 and 14(b) and T-W03-08 (c). It also gives a session a way to start secret-holding runs (main's code only; N-257, C02.md:374-376), and which version's `on:` decides is undocumented (EV-C02-001:126). E3: take p4 out of the binding control. Logs are not among point 9's places (W-C02-03.md:45), and from 2026-10-19 the logs place reads "could not check" anyway (14.12.2). It saves about 6 h but claims less than EV-C02-001:472. | E1, conditional on step 0; E3 only as a fallback |

## (3) Recommended frame

**Step 0. Executor, no merge.** Read on GitHub whether the 00:41Z and 06:41Z scheduled runs were created, how late they were, and their credential-present line (P7). Save the logs; this is C4's baseline if the run is at a pre-H1 head.
- If the runs came within about 30 min: keep E1.
- If they are missing or hours late: reopen E2 as a design change with its own record and verdict, before H1′.

**Step 1. H0, class high.** Put PR #310's guards and f266f84's `pr_inputs` change on one head, cherry-picked onto a branch from main.
- Checker: one fresh verdict at that head. Scope: guard 2 green on the fixed body and red on the frozen copy of main's body, the parser, and the `${{` scan. CHK-C02-049 is already judging #310 at e90cd5c.
- Shown on GitHub before the merge: the PR's own run, with W03_PR_INPUTS_TEST PASS, W03_RUN_EXPR_TEST PASS and "projects reported: ['devos', 'devos-test']".
- What it removes:
  - F-3: N-265 is met, not re-dated.
  - The red-check window that #310 alone would open. Its check fails by design on main's `pr_inputs` (pending_log_notes.md:167); [Inf] the next PR that runs the W03 tests on main's body would also be red, which M32 then blocks.
  - The latent block on H3's allowed removal under M16 (C02-log.md:265).
- Cost: about 1 h [est].

**Step 2. H1′, made in sequence.**
- 2a. Executor: the producer's and test designer's tasks state the facts as decided:
  - the print stays in `check-devos-test` (14.2's reason holds: merges stay free);
  - S1 prints and S2 searches;
  - the expected count is 1 per job, read from S1's archive;
  - S1's own logs place reads "could not check" by design;
  - CHK-C02-045 C1's windows apply;
  - T-W03-08 (e) runs after S2's search.
- 2b. Producer:
  - H1's content, with 14.13 naming the plant by tag only;
  - `W03_PLANT_B64` left empty for now;
  - the rehearsal workflow T-W03-09:38 already specifies: no environment; `issues: read` and `actions: read`; the search's own code; the plant only in base64; unbroken copy only.
- 2c. Test designer, after reading 2b's head:
  - T-W03-09 revised as C1 asks, with the README's revisions line;
  - B2 optional.
- 2d. Executor, last:
  - a new tag, and plants p1, p2/p5 and p3, never written to any file, commit message or PR text;
  - `W03_PLANT_B64` set;
  - the local count with the search's code before each push.
- 2e. Shown on GitHub before the verdict:
  - H1′'s own PR check;
  - the rehearsal PR's log, on a branch based on H1′ and never merged. It must show C2's counts for trees, history, the fixture issue and issue #6, and logs p4 = 0 (expected before S1), with each run's layout line, the paging line and the refs fetched.
- 2f. Checker: fresh, limited as CHK-C02-045:126 allows. It also reads the rehearsal log against C2's numbers and compares the facts in the test with the facts in the build. No merge while a scheduled run is queued or in progress.
- What it removes: F-1's class for this revision; F-2's route before GitHub keeps a copy; the search's unknowns from P-A before a tag is spent; C4's wait of up to 6 h.
- Cost: about 2.5–4 h from FR-07's decision to the merge, overlapping H0 [est].

**Step 3. Two tracks in parallel.**
- Point 9: S1, then S2. After S2's search come the break copies (now including the logs break), then T-W03-08 (e). The unsetting of the plant rides on the next class-high merge.
  - Merges stay free except from about :35 before S2's slot until its search ends. The search step's condition is only the head check (migrate.yml:2503-2505), so the H2–H5 states do not stop it.
- Fixtures: H2–H5, each built by the producer, then the test revision if any, then the PR check on GitHub, then the checker. A3's rehearsal comes before H2. Optionally stack H2–H5 and run their verdicts in parallel; a fix to H2 then voids the later verdicts.
- T-W03-08's probes (a)–(d) and (f) need no merge and can run at any time.

**Step 4.** The records PR, then point 13's checker.

Estimated total: about 10–18 h if nothing fails; the point-9 track bounds it [est].

## (4) What the recommendation must not do
- Add another offline model of GitHub written from belief, or a one-off harness kept outside the repository, as evidence (c2b_cases, gate_sim, mini_run). Plan 6.12 item 4 says to stop producing them.
- Add a standing plant scanner to the guard, the gate or a hook while the value is still handled as text.
- Respond with more lenses of the same kind.
- Patch `workflow_dispatch` into H1′. If it is wanted, it is a design change.
- Re-date N-265 when its guards are ready.
- Let H1′ grow after its tasks go out.
- Count the rehearsal as T-W03-09's result.
- Change the acceptance block, or change T-W03-09 after S1 has run.

## (5) CHK-C02-045 C1 to C4 under this frame
- **C1:** unchanged. It is met by the order in 2a–2c, and the re-check compares the named facts: print job, print run, search run, count, windows, re-run order.
- **C2:** unchanged. Tag 20261012T2338Z is retired. The count is done twice before the merge: locally before each push, and on GitHub by the rehearsal (the same numbers C2 lists). Records name the tag only.
- **C3:** met, not re-dated. H0 merges before H1′, and N-265 is closed with its evidence after `render --check`.
- **C4:** "not while queued or in progress" stays. The baseline is any completed scheduled run at a pre-H1′ head (step 0). If none exists, the revised T-W03-09 drops it under C4's own exception, with the reason that the rehearsal shows the code on GitHub and S1 shows P7. It is not a wait.

## Counter-evidence and alternatives
- The gate worked: checkers caught 8 of 9 defects before the merge, and the one that reached main failed closed. The failures are costly, not unguarded.
- Compared with the counter-assessment's six points:
  - match on 3 (schedule cannot apply), 4 (M22) and 6 (T-W03-14 reads step skips from a `devos` job that runs);
  - partial on 1 (no rehearsal of the full sequence) and 2 (H3's removal was blocked until 14.14);
  - no on 5 (the plants are handled as text, not derived).
- Dispatch is faster. It loses here only because it changes the security frame mid-campaign on platform behaviour that is not documented. If step 0 shows the schedule is unreliable, that verdict flips.

## Open
- GitHub's state after 00:45Z is not read here. The guard denies helpers `gh api`, and I have no GitHub tool.
- Whether a PR job's token reaches refs/pull/* and run archives the way the scheduled job's does [Inf].
- The archive layout.
- N-266: after 2026-10-19 the logs place is permanently "could not check"; the lasting design is the executor's, after acceptance.
- EV-C02-001:267 needs a dated correction (the 6–12 h added).
- For later: migrate.yml is 3,477 lines at 1fa178d, with the logic in `run:` bodies and two identical search copies. Moving it into class-high files that tests run directly (T-W03-DEC interface (b)) is worth weighing after N-266; it is not for this attempt.
- W-C02-08's `depends_on` is the executor's reading. W-C02-07 also gates W-C02-08, so narrowing it saves nothing now.
- 6.12's signal fired late because 14.14 was recorded under its own label; that is input for C05's failure classification.
- **Batu:** nothing here needs money, an account action or a change of scope. The old fixture branch holds only the retired tag; deleting it can wait for one of his batched steps. If dispatch is adopted later, it is the builder's decision, told to him as information unless it changes D-003's stated residual (the executor's reading).
- **Not read:** CHK-C02-044's body, which spells the old plant; EV-C02-001 §§4, 5, 9 and 15 in full; T-W03-05/06/07/10 on H1 beyond greps; the H2–H5 fixture texts; PR #304/#306/#307/#309/#310 logs; the library.

## Guard denials
None.
