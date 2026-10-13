# FR-07 input: researcher 3, the independent counter-assessment (it read only the acceptance block, the plan text and stated platform facts)

*The final report, verbatim, of agent `af0d56625365bedda` (a fresh-context `researcher` subagent, workflow run `wf_664638e3-b44`, 2026-10-13), taken with `tools/subagent_audit.py last` after its end status; `tools/subagent_audit.py disciplines`: DISCIPLINES OK. An input to `plan/decisions/FR-07.md`, not a decision. Its line references are to the files as they stood when it read them.*

---

## Disciplines (D1–D9)
D1: yes: I compared the main design choice (devos-test receives a migration only after merge, and the evidence before merge comes from a rehearsal that holds no credential) against four alternatives, and I name the open assumptions that would change the plan.
D2: uncertain: as the counter-assessor I tested my reasoning both ways, neither departing from the plan's order to look independent nor keeping it just because it is written, and I kept 6.2's order only where the acceptance or plan lines require it.
D3: yes: I followed each live point (5, 6, 7, 8, 9, 10, 14) from its merge to the raw observation a checker reads, and flagged one need the push run cannot meet (point 6 form (b): the job must name devos's difference itself).
D4: yes: every plant, decoy and break is placed so its check turns red if the claim is false (exact expected counts, no self-match, encoded and regex-hostile forms, a near-miss decoy), and rehearsal results count only as exploratory.
D5: yes: I worked only from the acceptance block, the plan lines I read in full and the task's facts, and every platform behaviour I took from memory is labelled "inference, verify".
D6: no
D7: no
D8: uncertain: the design depends on state the task told me not to read (what is on main, which workflow fires at :41, whether checks can run containers), so I give each as an assumption and say what changes if it is false.
D9: uncertain: the library may hold research on keeping CI secrets confined, but the task limits my reading, so I did not consult it and list that as a limit.

**Short forms.** W = /home/user/devos/plan/work/W-C02-03.md. P = /home/user/devos/plan/DevOS_Kurulum_Plani.md. "Fact" means the task's facts. Labels: [stated] = what the source says; [interp] = my reading of it; [infer] = my own inference or my memory of platform behaviour, not read in this session.

## Question and the decision it serves
The question: how to get W-C02-03's live points (W:41–46, W:59) shown and accepted with the fewest failure modes and the least time on the critical path. The answer feeds FR-07's comparison with the existing campaign design, which I did not read.

## A. The main design choice
- Nothing that holds the password can run before merge (Fact). The plan already puts break tests on a throwaway PostgreSQL of the projects' major version, built from `supabase/migrations/`. Those runs hold no credential, and the break patches sit outside `supabase/migrations/` [stated P:832].
- My design therefore proves everything the job does before merge on throwaway databases, plus the parts of the network path that need no password. devos-test gets a migration only after merge, first in the job's order [stated P:631; W:53].
- For W:54 (a), what the verdict judges before merge: the migration's text plus its effect in the rehearsal, not its effect in devos-test. Point 8 then holds unchanged, and no plan text changes for (a) [interp].

Alternatives I rejected:
1. A job holding the credential on `pull_request_target`, `issue_comment` or `workflow_run`. These events run main's file in main's context, so a main-only environment would admit them [infer, verify]. Content from a branch or the public would then run next to the credential, which contradicts P:1010's ✘ line in substance.
2. A third environment that admits `claude/*` and holds devos-test's password. This breaks P:1010 and W:44 directly.
3. Supabase's integration or branching. The design record weighs these (W:26, W:37); I did not evaluate them.
4. Making "stopped after merge" by cancelling the push run. The timing is a race.

## B. What is shown on GitHub before any merge, and how
**B1. Checks on M-A's pull request.** These use no credential. They run on a service-container PostgreSQL 17, either the Supabase Postgres image or plain postgres with Supabase's roles stubbed [infer: image tag not checked].
- The comparison's three results (no difference / difference / could not check). Point 7's three forms run here: expected set missing; record unreadable (SELECT revoked from the reader); partial read (the reader's backend killed mid-read). Point 6's breaks run here too (comparison rule removed, a project skipped, function versions skipped) and must turn the tests red (W:42–43).
- Point 14's break: a copy of the orchestration with the stop removed must turn red. The record states whether that test reads the workflow file or runs it (W:59).
- **A rehearsal of the whole live sequence F1 → F2 → (remove F2, add F3) → F4.** It uses the same pinned CLI and the same orchestration script against two containers standing in for the two projects. At each step it asserts each project's applied set, the comparison's result and which stage ran. It counts as exploratory evidence only. Its value is that it catches tool behaviour before a live state gets stuck, for example the CLI refusing to push when the remote record holds versions the local set lacks [infer]. That behaviour is why I avoid any plant that writes rows into `schema_migrations`.
- **A static trigger check over all of `.github/workflows/`.** Any job naming `migrate-devos-test` or `migrate-devos` must sit in a workflow whose only triggers are `push` to main, `schedule` and `workflow_dispatch`. Apply steps must be gated to `push`. Reason: a main-only environment admits every event that runs in main's context, and in a public repository some of those events can be caused by anyone [infer, verify]. This also gives the static part of W:55 (b).
- The point 9 counting code, run against a synthetic local corpus: a git repo with branches and history, a paginated issue JSON, and encoded forms.

**B2. Probe branch.** Written by the prober, never merged; its pull request is closed unmerged.
- A workflow on a `claude/` branch names both environments with no `if` guard. It has one job per environment, and a separate job with no environment that reports only whether the secret is present.
- It is started by a push, by a pull request, and by a `workflow_dispatch` on the branch ref if the tool allows it; if not, that is recorded (W:44).
- Expected: the environment jobs are refused, and the job without an environment reports "absent". Evidence comes from the jobs API (conclusion and annotation), not from logs, because GitHub answers 404 for the log of a job that never ran (Fact).
- The same branch carries a network step that needs no password: DNS for the direct host and the pooler, TCP to the pooler, and one startup per project with a deliberately wrong password. A "password authentication failed" answer proves the IPv4 path, TLS and tenant routing. Only one attempt per project, because the pooler bans repeated failures [infer].

**B3.** The plants for point 9 are placed (section D).

**B4.** M-A's merge record carries the gate's class-high line, which is point 14's positive control (W:59).

What cannot be shown before merge: anything that uses the password. That covers authentication, applies, the job's own reads, the comparison on real records, the search with the real credentials, and point 8's positive control.

## C. Changes to main: six, in order
**M0 – tests (test designer).**
- C0-form tests for points 5–10 and 14, with exact expected outcomes.
- Fixtures F1–F4 kept under `tests/`. They are outside `supabase/migrations/`, so the job never applies them (as P:832 requires for break patches) and M0 is not class high.
- Plant tags, the rule that derives each plant value, the expected count table, and the break definitions.
- Merged first, so git order shows tests before any result (W:51). If the test harness needs a new workflow, that workflow moves into M-A.

**M-A (producer; class high).**
- The workflow:
  - On push: preflight (credential presence and the listing) → apply to devos-test → the job's own read, the comparison and the database tests → apply to devos only if all three succeeded [stated P:631] → read and comparison → a report job that always runs. It records `needs.*.result`, step times, head SHA and event as an artifact and a job summary.
  - On schedule and dispatch: compare and search only, never apply.
  - One concurrency group for all events, with cancel-in-progress off.
- The comparison reads through a restricted role (NOLOGIN, used via SET ROLE) so that a migration can make the record unreadable. This changes the Appendix B roles, so it needs W:33's plan change.
- The pull-request check reads the last report at main's head [stated P:631].
- The gate's stop scope is exactly the three classes in 6.2 [stated P:631]: the apply to devos; a change to a merged migration file that the records do not show unapplied in both projects; and use of a result read from a project that is not at "no difference".
- F1 is copied byte for byte from M0, and a test checks that.
- What the run shows:
  - point 10: a listing of both projects before the first apply. The job takes both; for devos the connector also takes one, so devos has two independent readers.
  - point 5: devos-test read by the job, devos read by the connector (W:41).
  - point 8: the positive control.
  - point 14: the step times (W:59).

**M-B: F2, a migration that fails in every project.** Making it fail in devos-test only would need a way to tell the projects apart, which is fragile, so the record says the stop rests on GitHub's record of the run, as W:59 allows.
- Expected: the devos-test apply fails, and the devos stage never starts (jobs API and the report job's needs result). The connector shows devos lacks F2.
- The comparison in devos-test names F2. A dispatched run, or the next :41 run, names it for devos. The next pull request's check names it too. This is point 6 form (a).
- A probe pull request that edits the applied F1 is refused by the gate and closed: the stopped work is observed not to go on.

**M-C: delete F2 and add F3.**
- Deleting F2 is allowed because the records show it unapplied in both projects (P:631).
- F3 revokes the reader's SELECT on the record. Expected: devos-test applies F3, its comparison gives "could not check", and devos is not reached. That gives point 7's live "unreadable" form, point 14's second example and point 6 form (b).
- Then a dispatched or scheduled run names F3 as missing in devos. That run also leaves devos still lacking F3, which is live evidence for W:55 (b) that no route other than a merge applied it.

**M-D: F4 regrants (and optionally drops F1's object).**
- Expected: devos-test applies F4 and comes back clean. devos then applies F3 followed by F4 and comes back clean.
- This is point 6's positive control. M-D's change lies outside the stop scope, so the "could not check" left by M-C does not block it.

**M5: records.** The evidence record, the work file and the C09 line for point 11, at the head the final checker judges (W:52, W:47).

Point 6 form (c), function versions, applies only if C02 deploys a function. Otherwise the record names it not applicable and names the item that deploys the first function.

**Option to save time:** stack M-A to M-D as branches, each based on the previous head. The four checker verdicts can then run in parallel, and merge commits keep each head, and so each verdict, valid. This assumes merge commits are allowed and branches need not be up to date. The cost: if M-A needs a fix, all four heads change and need fresh verdicts.

## D. How the credential search's sensitivity is shown (point 9)
- **Where it runs:** in each environment's job, on the schedule and dispatch path only, so it adds nothing to migration runs.
- **What it searches:** main's tree, every branch tip, every blob reachable from any ref, issue #6's body and all its comments across all pages, and recent run logs. The logs are public in a public repository [infer].
- **Forms and matching:** the plain value and the percent-encoded value (upper- and lowercase hex), matched as fixed strings, not regex.
- **Plants** (placed by the prober; referred to by tag only):
  - P1: plain, at the tip of a dedicated fixture branch.
  - P2: plain, in that branch's history only (removed at its tip).
  - P3: percent-encoded, as the last comment on #6. This also tests pagination. It is labelled as a test fixture in Turkish and English so Batu does not read it as a request.
  - P4: plain, echoed into the probe-branch run's log.
  - N1: a near-miss decoy (one character changed) in each class.
  - Each plant value is shaped like a credential and contains both characters that percent-encoding changes and regex metacharacters.
- **How it is counted:** for each (location class, form) cell, the number of distinct objects containing the value (blob id, comment id or log file). Only this table is printed.
- **Expected counts, fixed in M0 before any run:** the real credentials are 0 in every cell; each plant appears in exactly its planted cells; N1 is 0 everywhere. Exact counts make a self-match or a double count turn red just as a miss does.
- **Kept out of the records the search reads:**
  - A plant value is never written anywhere except at its planted locations: not in the repository, a pull request, an issue, a commit message, a test or a record.
  - The job derives it at run time from its tag through a fixed one-way rule. The tag and the rule are in the searched corpus; the value is not.
  - The job masks the value and its encoded form before use, and feeds it through the same code path as the real credential.
  - The credential's encoded form is masked as well, because GitHub masks the registered value but not forms derived from it [infer].
- **Residual:** "a session has no other route" stays documented, not tested (W:45).

## E. Offline and live
| Offline (no credential) | Live |
|---|---|
| Point 7: all three forms | Point 5 |
| Point 6 and point 14: the breaks | Point 6 forms (a) and (b), and the positive control |
| The full sequence rehearsal | Point 7: the unreadable form (F3) |
| The static trigger check | Point 8: refusals (probe branch) and the positive control (main) |
| The search counter on a synthetic corpus | Point 9: plants and counts |
| | Point 10: the listing |
| | Point 14: the order and stop |

**Time [infer].** M0 and the probe branch, plants and offline suite run off the critical path. Each run takes about 5–10 minutes; the class-high verdicts dominate the time. Without dispatch, M-B and M-C may each wait up to 6 hours for a :41 run, unless the review of the next pull request overlaps the wait.

## Three most likely failures of this design
1. **The first use of the password happens only on main, in M-A's run.** Possible causes: the direct host is IPv6-only while runners use IPv4, the pooler's user form, TLS, special characters in the password breaking the URL, a paused project, or a pooler ban. A preflight failure stops before any apply, but each fix is another class-high cycle. There is also a leak risk: an unmasked encoded password in a public log [infer]. B2's handshake without a password reduces this but cannot remove it.
2. **The planted states behave differently on real Supabase than in the rehearsal, or the stop guard blocks the merges meant to heal them.** Possible causes: different ownership or privileges on `supabase_migrations`, the pooler in the path, the comparison reading as `postgres` (then F3 gives "no difference" and reaches devos), or a guard that blocks all merges and deadlocks M-C and M-D. The only way out would be an ungated fix, which the rules forbid.
3. **Evidence capture on GitHub fails.** Possible causes:
   - a job that never ran answers 404 for its log (Fact);
   - a concurrency group replaces a pending run;
   - a :41 run, which may itself be late [infer], changes "the last report at main's head" mid-sequence;
   - the "acts only at main's head" rule (P:724) skips the run of a merge that is no longer the head;
   - the log tool truncates output;
   - the executor cannot dispatch, so naming devos's difference waits for the schedule.
   The result can be a real observation that cannot be shown raw, recorded as "could not check", and a repeated class-high cycle.

Next in likelihood: the executor's push identity may lack permission to push workflow files [infer], and the search may miss things through pagination or token scope.

## Counter-evidence and alternatives inside my own design
- **A separate M-A with no migrations,** proving the connection first: one more cycle, but a cleaner "before the first migration" listing. I chose to combine, because the preflight already stops before any apply.
- **A failing database test for form (b):** 6.2 lists database tests as a stop (P:631), and this would avoid the reader role. But point 14's second example names only "difference" and "could not check" (W:59), so it would cover point 6 (b) only.
- **The plant on #6 adds noise to Batu's channel.** A dedicated fixture issue would avoid that, but then #6's own pagination would be untested.

## For the decision
Compare the existing design with this one on six points:
1. Whether the whole live sequence is rehearsed before merge without a credential.
2. Whether the stop guard's scope lets the healing merges through.
3. Whether the schedule and dispatch paths can apply.
4. Whether there is a static check for events that run in main's context.
5. Whether plants are derived and counted exactly, and kept out of the corpus.
6. How "the devos stage never started" is evidenced without a log.

If the existing design matches on all six, this changes nothing.

## Not read
- EV-C02-001, R5 (S and G items), Appendix B, plan Section 8 item 14, 6.7, the workflows now on main, and current GitHub or Supabase documentation.
- Every [infer] platform claim above is unverified.

## Guard denials
None.
