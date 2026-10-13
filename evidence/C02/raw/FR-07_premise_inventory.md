# FR-07 input: researcher 1, the premise inventory

*The final report, verbatim, of agent `a8cfe008993ddd6ba` (a fresh-context `researcher` subagent, workflow run `wf_664638e3-b44`, 2026-10-13), taken with `tools/subagent_audit.py last` after its end status; `tools/subagent_audit.py disciplines`: DISCIPLINES OK. An input to `plan/decisions/FR-07.md`, not a decision. Its line references are to the files as they stood when it read them.*

---

## Disciplines (D1–D9)
D1: yes: the whole task is a premise inventory, so I asked the from-scratch test of each premise and set the strongest alternative against it. Where a premise holds only under a condition, I state the condition rather than a verdict.
D2: yes: the task frames the premises as the cause of the failures. I looked for counter-evidence too: offline runs with the real tools that prevented a stall, the H1 parts that were sound, and the PR's own check that caught failure 3. I kept necessary premises apart from contingent ones.
D3: yes: I kept to the inventory and to the mapping from premises to failures. I did not design the fix, and I flagged the critical-path effect (W-C02-08 is blocked) as part of the purpose.
D4: yes: for each check behind a premise (an extracted body, an API stub, the pinned parser, gate_sim, a checker round) I asked whether it could have turned red on the failure that later happened. I separated high-fidelity offline runs (real artefacts) from stubs written from belief.
D5: yes: the executor's notes, the researcher's plan and the verdicts are views. I went back to W-C02-03.md, EV-C02-001, EV-C02-007 (main, and H1 at 1fa178d through git show), the tests on H1, merge_gate.py and the ledger for every load-bearing claim. I mark what rests only on scratchpad notes.
D6: yes: for each failure I separated the proximate cause, the contributing premise, the prevention gap and the detection gap, and asked whether the class can recur by another route (the search's archive layout).
D7: no
D8: yes: I confirmed the live tree is main at d33c8e9 and the H1 head is 1fa178d in cw80. I read the frontier (ledger.md:35-51): nothing is ready, and W-C02-08 is blocked on W-C02-03.
D9: uncertain: there is no local copy of the research library in this container and the task did not name it. The premises are this repository's own, so I did not consult it, and I state that as a limit.

## Question
FR-07 premise inventory for W-C02-03's design and its live campaign. For each premise: where it came from, whether it still holds, whether we would choose it again from scratch, and the time it adds on the critical path. Then: which premises create the recurring failures, and which are necessary. This serves the frame review that working order §6 item 2 requires before a third attempt.

Labels: [S] stated by the source, [I] my interpretation, [Inf] my inference, [est] my estimate.

## Premise inventory

**PR-1. GitHub's behaviour before a merge is shown offline.** This means extracted bodies run locally, hand-written stubs of GitHub's API (c2_cases, the search_run stand-in API, gate_sim/mini_run), and the pinned `@actions/workflow-parser` 0.3.61 for syntax.
- **Source.**
  - Design: "Nothing here is probed" (EV-C02-001:17).
  - No pre-merge apply, and no branch run holds the credential (M31, :67, :233).
  - "That a pull-request check can read a run's log with actions: read [inf; no reading quotes the endpoint]" (:536).
  - Build: offline only (EV-C02-007:633; H1 EV-C02-007:817). The stub is at :714. The parser was added after CHK-C02-029 (:651).
- **Does it hold?** It splits into five parts:
  - (a) Steps that hold the secret cannot run before a merge. Holds and is necessary: point 8's ✘ (W-C02-03.md:44) and M03.
  - (b) "An extracted body run locally = GitHub's run." Refuted by CHK-C02-029 [S] (EV-C02-007:637).
  - (c) "A stub written from belief = GitHub's API." Refuted by 14.14 [S] (H1 EV-C02-007:1050: the stub listed two jobs, both run). The design itself gives each run four jobs, two of them skipped (EV-C02-001:27), so the stub contradicted a fact readable in the repository [Inf].
  - (d) The pinned parser. Holds for syntax: it reproduces failure 1 at d4eb7c6, ccd92f2 and 5cad061 (EV-C02-007:656-662), and GitHub's server read migrate.yml at run 1 (:806). It says nothing about runtime or API behaviour (:704) [S].
  - (e) Running non-secret steps in the PR's own GitHub check before the verdict. Adopted after failure 1 (L-301 at C02-log.md:235; EV-C02-007:802), and it caught failure 3 before the merge (H1:1048) [S].
- **Counter-evidence.** Offline runs with the real artefacts were valuable. P2, settled offline with the pinned CLI on PostgreSQL, showed that item 2a as first written would stall devos-test, and the test was revised before any run (T-W03-14 H1:9, :31-38) [S].
- **Choose again from scratch?** Yes for offline runs with real artefacts (pinned CLI, real PostgreSQL, GitHub's parser and expression evaluator). No for stubs written from belief as the only pre-merge evidence of API shape. Instead, build them from responses captured from real runs, or run the non-secret code on GitHub in a PR check before the verdict [Inf].
- **Same class still open for the search, which has never run live.**
  - The log-archive layout is [cnc] (H1 EV-C02-007:897; 14.3 f).
  - The run-archive download from inside a job is unobserved.
  - Whether the token can fetch every ref is P8.
  - Rate limit and duration are unobserved (14.11 item 6).
  - The executor tried to capture a real archive; it needed a raw network tool and was not pursued (pending_log_notes:141) [S].
- **Time.** This is not a wait parameter; its cost is review rounds.
  - Failure 1: the FAIL came after four lenses and two fix rounds missed the class (C02-log.md:198-199, :224). The fix ran from FAIL to merge in about 21:50Z to 22:13Z (C02-log.md:227, :244) [S].
  - Failure 3: found and shown fixed live between 00:05Z and 00:11Z on 2026-10-13 (pending:148-149) [S].
  - Reason's source: M31 and point 8 (2026-10-12). No Batu decision touches it.

**PR-2. H1 bundles parts written in parallel by helpers who do not see each other, and the executor merges them without reconciling their interfaces.** The parts are T-W03-05's fixture and read, the plant settings and print step, the `tokens_revoke` gate, the test revisions, and later the `pr_inputs` fix.
- **Source.**
  - Researcher's plan, "fewest class-high merges" (w03_live_plan_research.md:240-257; scratchpad, not a merged record).
  - Executor's decisions (pending:140, :147).
  - README on H1, :62: "made in parallel by a producer".
- **Does it hold?** The reason holds: each class-high head needs its own verdict (merge_gate.py:8-12). The hidden premise, that parallel parts agree, failed: F-1 (CHK-C02-045:30-45; cause named in CHK-C02-043:36).
- **Root of the disagreement [Inf].**
  - The researcher's plan left the print run open ("gate the step or freeze merges", :141), and its next item assumed a print in the push run ("the next cron slot after that. No push to main in between", :142).
  - The executor's decision "C3 print step in H1" (pending:140) did not choose between the two.
  - The producer chose the scheduled job (H1 EV-C02-007:855). The test designer wrote "prints in H1's push run" (T-W03-09 H1:24).
- **H1 also grew mid-flight.** The executor added the `pr_inputs` fix (f266f84), which made H1 the "next change to .github/workflows/" that N-265's deadline names (F-3).
- **Counter-evidence.** The other H1 parts are sound (CHK-C02-045:122-126), and reconciling F-1 costs no extra merge (:45).
- **Choose again from scratch?** Bundling yes. Blind parallelism no: the executor should fix the interface facts (which job prints, which run searches, the expected count) in both tasks, or sequence the test revision after the producer's design. An interface cross-check should come before the verdict [Inf].
- **Time.** Bundling saves about one class-high cycle (5 merges against 6; researcher :257). H1's FAIL cost about 23:00Z to 00:33Z (pending:140-152; CHK-C02-045:42), plus rework and a re-check [est 1–2 h].

**PR-3. T-W03-09's sensitivity design.**
- **What it is.**
  - One synthetic tag is planted in every kind of place: p1, p2/p5, p3, and p4, a line that migrate.yml prints.
  - The plants are in devos itself, the same repository the records are written to.
  - Each job must count exactly 1 per planted place.
  - The search reads every ref, `refs/pull/*` included.
- **Source.**
  - Acceptance: a positive control with a planted value, over main and every branch and issue #6 (W-C02-03.md:45) [S].
  - The design adds the logs of earlier migrate.yml runs and the p4 print line (EV-C02-001:472) [S].
  - "Exactly one" and "count 1" are the test designer's (T-W03-09 main:20, :37), as is "only plain occurrences are the planted ones" (:3).
- **Does it hold?**
  - Planting in devos is necessary [I]: only plants where the live job searches show its token's reach.
  - "Exactly 1 under one tag" is a test choice, not the acceptance's. It makes one stray copy fatal to the whole round. F-2: one record line spelled the plant, and refs/pull/309 keeps the blob (CHK-C02-045:47-63; CHK-C02-044:26-43) [S].
  - Interaction [Inf]: the practice adopted after failure 1, opening the PR before the verdict so GitHub runs the checks, is what put every intermediate blob on `refs/pull/309/head` (CHK-C02-043:44).
  - Detection gap: nothing scans for the plant before a push (CHK-C02-045:23, :63) [S]. The researcher had warned only about raw logs (w03_live_plan_research.md:150).
  - p4 needs one class-high change to set the plant and another to unset it (T-W03-09 H1:27), and an exact count over an unread archive layout [S].
- **Choose again from scratch?**
  - Same-repo plants: yes.
  - Exact count under one tag: only with a plant scan before every push in the executor's path. The PR check is too late, because the push has already made the ref [Inf].
  - Per-place tags would limit a stray copy to one place [Inf].
  - The logs place is a real exposure route but goes beyond the acceptance's list of places [I]. Weigh whether p4 is worth its two merges.
- **Time.**
  - A spoiled tag costs a new round: new plants, a class-high change, and S1 and S2 again. That is 6–12 h plus GitHub's delay, and there is no repeat at the same tag (H1 EV-C02-007:855, :862, :867; 2026-10-12) [S].
  - Hard bound: S2 must come before about 2026-10-19, the 400-run window (N-266 on H1 C02.md; H1 EV-C02-007:1016; 2026-10-13) [S].

**PR-4. The search is timed to scheduled runs.**
- **What it is.** The search runs only in the scheduled compare-only jobs (EV-C02-001:27, :472), and migrate.yml has no manual start (M04, :40, :126; N-257, EV-C02-007:181). So a round is: a baseline run, S1 prints, S2 searches, with windows in which nothing may merge.
- **Source.** M04 (2026-10-12). The PC-23 schedule row says "None: it applies nothing" (EV-C02-001:267). Also T-W03-09 H1:39 (baseline; no merge before the search), H1 14.3 :862-867, and CHK-C02-045 C4 (:10, :71-77).
- **Does it hold?**
  - The reason for no dispatch holds as security simplicity [S].
  - The PC-23 entry is wrong for acceptance [I]: the schedule decides when T-W03-09, and so W-C02-03 and W-C02-08, can move. H1's 14.3 gives 6–12 h for S2 only, not counting the baseline or a retry.
  - A dispatch of the compare-only jobs on main would run only main's code [Inf]. Secret-holding runs already happen at every merge, so a dispatch would widen when they run, not what code holds the secret [Inf].
  - But a dispatch changes M04, M22's event rule (EV-C02-007:184) and T-W03-08's expectations. It also lets any session with Actions write start a secret-holding run, and the guard allows GitHub writes (EV-C02-007:183; pending:66). That residual is to be weighed under D-003.
- **Choose again from scratch?** Uncertain. The options:
  - (i) keep the cron;
  - (ii) dispatch for the compare-only jobs;
  - (iii) show the method's positive control in a PR run with no secret (the break-copy PR already runs the search's code, T-W03-09 H1:38), and keep the scheduled run for the negative and P7. Option (iii) is weaker on the equivalence of token and event [Inf].
- **Time.**
  - Baseline: up to one slot (≤6 h) before H1 merges; C4 allows dropping it with a reason.
  - S2: 6–12 h after H1's merge, plus GitHub's delay.
  - Retry: another 6–12 h.
  - Hard bound: 2026-10-19.
  - Sources: EV-C02-001 M04 and M17, R6a 4 and R6b 4 (read 2026-10-12); H1 EV-C02-007:867 (2026-10-12); N-266 (2026-10-13).
  - Against Batu's later decisions: EV-C02-001:262 finds none touches this up to D-031 [S]. D-032 to D-037 I know only from the ledger's titles (C02-log.md:186-223), and they concern labels and modes [I].

**PR-5. Live points that change main's behaviour each need a class-high merge with a fresh checker, one after another.** These are the fixtures H1 to H5, the plant set and unset, and the `tokens_revoke` gate.
- **Source.** merge_gate.py:8-22; W-C02-03.md:41 (point 5 "merged into main through the merge gate"), :59 (point 14), :52; M05 and M31 (EV-C02-001:41, :67).
- **Not every point needs one.** Point 8 (a)–(d) and (f) run on a branch probe (pending:153-156). Point 10 runs on a throwaway database and the read-only connection. Point 11 is a record line [S].
- **Does it hold?** Yes, for the fixtures: these are the acceptance's own words, and they cannot be loosened (plan:1290; working order:44). Not required for the plant plumbing, which comes from PR-3 [Inf].
- **Choose again from scratch?** Yes for the fixtures. For the plant, a mechanism that needs no merge to unset (for example a print limited to a window encoded in the tag) [Inf, untested].
- **Time.** The researcher estimated 5 class-high merges plus one scheduled wait of up to 6 h (:257; 2026-10-12). I estimate 1–2 h per class-high cycle, from H1's timeline [est]. H2→H3 and H4→H5 are strictly serial (T-W03-14 H1:23-27).

**PR-6. Tests are written before results, and a class-high change is judged at its head after it is made.**
- **Source.** plan:835, :872, :1290; plan 0.3 items 6 and 7 [Batu kararı] (TR-A2 :1308-1309); working order:44, :47; W-C02-03.md:51-52.
- **Does it hold?** Yes; it is necessary, and it worked: there is no T-W03-09 result yet, so revising the test now is not a loosening (CHK-C02-045:42).
- **What it does not require.** It does not require the test designer to work blind to the producer's design: the role forbids writing the product, not reading it (test-designer.md:3, :14, :32) [I]. PR-2's parallel form is a scheduling choice.
- **Time.** Small. Test files under `tests/` are class normal (not in merge_gate.py:14-15), so a revision merges without a checker. Files under `supabase/migrations/tests/` are class high.

**PR-7. W-C02-08, W-C02-12 and W-C02-18 depend on all of W-C02-03 being accepted.**
- **Source.** W-C02-08.md:9-17 (work list 81cc788, 2026-10-12); ledger.md:43; plan:1000 ("first"; "designed and probed first"); W-C02-03.md:16.
- **Does it hold?** W-C02-08 cites only "W-C02-03's accepted order" and the merge-only route to devos (W-C02-08.md:42). Points 8, 9 and 10 do not feed its work [Inf]. W-C02-03 itself rejected a `depends_on` on W-C02-19 for exactly this reason (W-C02-03.md:16) [S].
- **Choose again from scratch?** Depend on points 5, 6, 7 and 14 plus their verdict [Inf]. Whether plan:1000's "probed first" covers the ✘ points is the executor's reading to settle. W-C02-07 also gates W-C02-08 (ledger.md:40, :43), so whether this premise is binding now is uncertain.
- **Time.** The whole live campaign, PR-4 plus PR-5: on the order of a day [est].

**PR-8. Every GitHub action is the executor's, in one session.**
- **Source.** D-010 and working order:26; README H1:66; guard B7.
- **Does it hold?** Yes, and it is necessary (Batu's D-010).
- **Side effect.** Deadlines triggered by an event rest on one context's attention. N-265 was caught only after a compaction, while its guards were still unmerged (pending:154). `records.py render --check` passes with N-265 open (CHK-C02-045:67) [S].

**PR-9. The pooler host is recorded in the workflow through a class-high change (M19).**
- **Source.** EV-C02-001:55; EV-C02-007:71, :810; C02-log.md:249.
- **Does it hold?** Yes, and it was chosen deliberately. It cost about 13 min (22:13Z→22:26Z) and is not a failure. Choose again: yes.

**PR-10. The class guard after failure 1 was deferred to a note rather than made a condition.**
- **Source.** CHK-C02-038 F-11 (:143-147, not blocking); N-265 (C02.md:414).
- **Does it hold?** No: the same class recurred in 14.14 (CHK-C02-043:19, :54-58).
- **Choose again from scratch?** No. Make the class guard a condition before the next class-high change, built from GitHub's real responses.

## Which premises create the failures

1. **CHK-C02-029 (failure 1).**
   - Proximate: PR-1(b).
   - Contributing: the lenses ran on a branch with no PR, so GitHub's own run came last (C02-log.md:235) [Inf].
   - Prevention gap: no parser in the repository (EV-C02-007:795).
2. **First push run stopped (item 2).** PR-9, by design; not a failure.
3. **The skipped job's 404 (failure 3).**
   - Proximate: PR-1(c), which contradicts EV-C02-001:27.
   - Class guard deferred: PR-10.
   - Detection [Inf, not read]: PR #306's and #307's checks probably already printed "could not be read" (both ran after run 1), a line expected since #304.
4. **CHK-C02-045 (failure 4).**
   - F-1: PR-2, together with PR-4 (S1/S2 makes "which run prints" non-obvious) and PR-3 (p4's exact count).
   - F-2: PR-3, together with PR-1(e)'s early PR (refs/pull persistence), and no plant scan before a push.
   - F-3: PR-10, together with PR-8 and PR-2 (H1 grew into the change that triggers the deadline).
- **Common frame [I].** The platform is modelled offline and timed by the cron, and class-high merges are minimised by bundling. Each premise trades fewer merges and waits for more facts that the builders must keep consistent by hand.

**Necessary:** PR-5 for the fixtures, PR-6, PR-8, PR-1(a), PR-3's same-repo plants, PR-9.

**Not necessary, and candidates to change:** PR-1(c), PR-2's blind parallelism, PR-3's single tag with exact counts and no pre-push scan, PR-4 (uncertain: a trade-off), PR-7, PR-10.

## For the decision
These findings change the frame review's options. A third attempt that only meets CHK-C02-045 C1 to C4 keeps PR-2, PR-3, PR-4, PR-7 and PR-10 in place, and the search, which has never run live, still carries PR-1(c)'s class.

The cheapest premise changes:
- fix the interface facts in both tasks;
- add a plant scan before every push;
- run the search's code in a PR check before H1 merges, to observe the real archive layout and paging;
- narrow W-C02-08's `depends_on`;
- decide between dispatch and cron with its security residual stated.

## Open, and what I could not read
- I read only the front matter and D-lines of CHK-C02-017, -029, -035 and -039 (CHK-C02-038 F-9 to F-12 in full).
- I did not read in full: EV-C02-001 §§4, 5, 9, 14 and 15; T-W03-05, -06, -07, -08 and -10 on H1; migrate.yml itself; the decision records D-034 to D-037.
- GitHub state was not read: whether the 00:41Z scheduled run happened, and the check logs of PR #306 and #307.
- The research library: no local copy.
- I did not verify W-C02-07's remaining duration, so whether PR-7 binds the critical path is uncertain.
- Every [est] is mine.

## Guard denials
None.
