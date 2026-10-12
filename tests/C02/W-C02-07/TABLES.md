# W-C02-07 tests: the tables the acceptance asks for (skeletons from phase A)

Phase C fills these tables from the four groups' files. Phase A lists every row and leaves the cells empty.

**Where the authoritative copy is.** Each test's own specification carries its clause table (point 2) and its "Serves" line (point 8). These tables collect those into one view. If a cell here differs from the specification, the specification is right and this table is corrected, and the checker compares the two.

**Columns.**
- "Case ID(s)" are the IDs of README section 1.
- "Moved to" names the stage or plan change that takes a clause away from C02 (point 2: "a clause is left out only where Appendix C gives it to another stage, or where a plan change through Section 14, merged before the tests, moves it"). A clause with neither a case nor a "moved to" entry fails point 2.
- "Hint (phase A)" gives what `GROUPS.md` expects. It is not the answer. Phase C checks each hint against the files.

Clause texts are quoted from `plan/Ek_C_Testler.md` at `main` `db2ebd9`, which carries PC-42's and PC-43's changes.

## 1. Point 2: clause-to-case tables, per Appendix C test

### F01 · `T-W07-F01` (Ek_C:32-39)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F01-c0 | Claim, the designer's addition (F entries have no claim line; R2 section 5 (c)) | | |
| F01-r1 | Class rule: the key is bound to "type" | | |
| F01-r2 | Class rule: "target" | | |
| F01-r3 | Class rule: "expected base" | | |
| F01-r4 | Class rule: "content" | | |
| F01-r5 | Class rule: "work item" | | |
| F01-r6 | Class rule: "claim generation" | | |
| F01-r7 | Class rule: "authority epoch" | | |
| F01-r8 | Class rule: "(and the grant revision once Grant is activated, Appendix B 3.6; PC-08)" | | |
| F01-ea | Example (a) "same content, different target" | | |
| F01-eb | Example (b) "same content and target, different expected base" | | |
| F01-ec | Example (c) "everything the same, different claim generation" | | |
| F01-ed | Example (d) "a delayed retry after the retention period of the key record has expired" | | |
| F01-n1 | Negative: "(a)–(c) are rejected as conflicts" | | |
| F01-n2 | Negative: "(d) is not accepted as if it were a new operation; the real state is read" | | |
| F01-p1 | Positive: "The same key with the same full intent returns the existing record and produces no new effect" | | |
| F01-b1 | Break: "When one of the intent fields is removed from the comparison, the corresponding example must start to pass and the test must fail" | | |

### F04 · `T-W07-F04` (Ek_C:61-68)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F04-c0 | Claim, the designer's addition | | |
| F04-r1 | Class rule: "returns unique records" | | |
| F04-r2 | Class rule: "the path explanation is separate and bounded" | | |
| F04-r3 | Class rule: "a result that reaches the limit carries a completeness flag" | | |
| F04-ea | Example (a) "consecutive diamond structures" | | |
| F04-eb | Example (b) "a graph containing an explanatory cycle" | | |
| F04-ec | Example (c) "a graph containing a node outside authority" | | |
| F04-ed | Example (d) "a deep graph that reaches the limit" | | |
| F04-n1 | Negative: "The number of result rows does not exceed the number of records" | | |
| F04-n2 | Negative: "in (d), 'nothing else is affected' is not said" | | |
| F04-n3 | Negative: "in (c), the name of the hidden node does not leak" | | |
| F04-p1 | Positive: "All affected records are found with at least one explanatory path" | | |
| F04-b1 | Break: "When deduplication is removed, the row count in (a) must explode and the test must fail" | | |

### F05 · `T-W07-F05` (Ek_C:70-77)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F05-c0 | Claim, the designer's addition | | |
| F05-r1 | Class rule: "Every operation checks the work item, target and source scopes and their revisions together" | | |
| F05-r2 | Class rule: "different verification paths apply the same check" | | |
| F05-ea | Example (a) "a target in another scope" | | |
| F05-eb | Example (b) "a source in another scope" | | |
| F05-ec | Example (c) "the right scope, an old revision" | | |
| F05-ed | Example (d) "the same operation attempted through a second function path" | | |
| F05-n1 | Negative: "All are rejected" | | |
| F05-p1 | Positive: "The right scope and the current revision are accepted" | | |
| F05-b1 | Break: "When the target scope check is removed, (a) must pass" | | |

### F06 · `T-W07-F06` (Ek_C:79-86)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F06-c0 | Claim, the designer's addition | | |
| F06-r1 | Class rule: "Every state-changing function produces an event in the same transaction" | | |
| F06-r2 | Class rule: "on rollback the two are rolled back together" | | |
| F06-r3 | Class rule: "an exact repeat produces no new event" | | |
| F06-e1 | Examples: "All state-changing functions, one by one", the list "extracted automatically from `devos_api` and from the owner-only functions of `devos_private`, `issue_env_token` and `revoke_env_token`" | | |
| F06-e2 | Examples: "every function whose catalogue comment does not mark it as a read function counts as state-changing" | | |
| F06-e3 | Examples: "a function so marked is checked to change no table but RejectedAttempt, on accepted and on refused calls" | | |
| F06-e4 | Examples: "when a new function is added, the test covers it by itself" | | |
| F06-n1 | Negative: "If a function that produces no event is found … the test fails" | | |
| F06-n2 | Negative: "or an event without the caller's `role_class` taken from its token (Appendix B 3.13)" | | |
| F06-n3 | Negative: "when an error is raised in the middle of a transaction, no half state or orphan event remains" | | |
| F06-p1 | Positive: "An exact repeat produces no new event but raises no error either" | | |
| F06-b1 | Break: "When event production is removed from a function, the test must fail" | | |

### F07 · `T-W07-F07` (Ek_C:88-95; C02 part)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F07-c0 | Claim, the designer's addition | | |
| F07-r1 | Class rule: "Observations are appended, not deleted" | | |
| F07-r2 | Class rule: "a later observation does not remove earlier evidence" | | |
| F07-r3 | Class rule: "'applied in the past', 'current now' and 'accepted' are separate questions" | | |
| F07-ea | Example (a) "applied, then unknown" | | |
| F07-eb | Example (b) "observations arriving out of order" | | |
| F07-ec1 | Example (c) "the PR merged, then `main` was reverted", as a synthetic sequence (C02) | | |
| F07-ec2 | Example (c) against real GitHub | | C08 (Ek_C:95; R2 section 2) |
| F07-n1 | Negative: "In no case is past 'applied' evidence lost" | | |
| F07-p1 | Positive: "The current-state question gives the right answer" | | |
| F07-b1 | Break: "When updates are allowed on the observation table, (a) must fail" | | |

### F08 · `T-W07-F08` (Ek_C:97-104)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| F08-c0 | Claim, the designer's addition | | |
| F08-r1 | Class rule: at the moment of effect, re-checked: "the current work item" | | |
| F08-r2 | Class rule: "dependencies" | | |
| F08-r3 | Class rule: "claim (active, current generation, valid epoch)" | | |
| F08-r4 | Class rule: "read set" | | |
| F08-r5 | Class rule: "(and the grant, once Grant is activated; PC-08)" | | |
| F08-r6 | Class rule: "the mandatory elements of the read set are determined on the server according to the operation type" | | |
| F08-ea | Example (a) "a new hard dependency" | | |
| F08-eb | Example (b) "a change to a source in the read set" | | |
| F08-ec1 | Example (c) "revocation … of the claim" | | |
| F08-ec2 | Example (c) "expiry of the claim" | | |
| F08-ec3 | Example (c) "an authority epoch change after the claim" | | |
| F08-ed | Example (d) "the agent deliberately writing an incomplete read set" | | |
| F08-n1 | Negative: "The effect is rejected" | | |
| F08-n2 | Negative: "the candidate result is kept" | | |
| F08-p1 | Positive: "After the dependency is resolved, the effect can be made" | | |
| F08-p2 | Positive: "an independent exploration work item can continue under another claim" | | |
| F08-b1 | Break: "When the re-check at the moment of effect is removed, (a) must pass" | | |

### Concurrency · `T-W07-CONC` (Ek_C:106-110)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| CONC-c1 | Claim: "Of several connections that request the same work item at the same time, only one claims it" | | |
| CONC-c2 | Claim: "when two opposing hard dependencies are added at the same time, no cycle forms" | | |
| CONC-m1 | Method: "Many concurrent connections on real PostgreSQL; repeated runs" (numbers fixed in advance; W-C02-13 point 4 also asks that the transactions are shown to overlap in time) | | |
| CONC-p1 | Positive: "One claim always succeeds (the system does not deadlock and reject everyone)" | | |
| CONC-x1 | Class rule, examples, negative control and break: the designer's additions (R2 section 5 (c)) | | |

### N01 · `T-W07-N01` (Ek_C:118)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N01-c0 | Claim: "A prerequisite without a justification is not accepted (format gate)" | | |
| N01-n1 | Negative: "A need with an empty `why_needed` is rejected" | | |
| N01-n2 | Negative: "a 'filled but meaningless' justification is accepted by the database and lands in sample review: with the share set to take it, it reaches the audit environment's queue as a `Review` of kind `sample` (Appendix B 3.11)" | | |
| N01-n3 | Negative: "at the set share, the share of sampled needs matches the rate", with the tolerance written in advance (point 4) | | |
| N01-n4 | Negative: "a sample review written with the working environment's token is rejected" | | |
| N01-p1 | Positive: "A need with a justification is accepted" | | |
| N01-x1 | Class rule, examples and break: the designer's additions | | |

### N02 · `T-W07-N02` (Ek_C:119)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N02-c0 | Claim: "A high-impact decision cannot be opened without alternatives research" | | |
| N02-n1 | Negative: "A decision with neither compared options, nor a single-path justification, nor an open exploration state is rejected" | | |
| N02-n2 | Negative: "a major design decision without premises is rejected" (EV2 DM-27: no "major design" marker in C02; state how the clause is carried) | | |
| N02-p1 | Positive: "A decision that writes down the single feasible path with its justification is accepted" | | |
| N02-p2 | Positive: "an invented second option is not required" | | |
| N02-f1 | Point 4: its "filled but meaningless" example, accepted and landing in sample review | | |
| N02-f2 | Point 4: `alternatives_state = open_exploration` cannot be answered or accepted, through each transition C02 builds, until compared options or `single_viable_path_reason` are entered | | C06 with `answer_decision`, if C02 builds no such transition; name the carrier note on `plan/work/C06.md` |
| N02-x1 | Class rule, examples and break: the designer's additions | | |

### N03 · `T-W07-N03` (Ek_C:120)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N03-c0 | Claim: "Non-removable effort steps and the expert assessment cannot be emptied; a reduction needs the audit environment's approval" | | |
| N03-n1a | Negative: a policy with "the expert assessment" removed is rejected | | |
| N03-n1b | Negative: a policy with the "verification" step removed is rejected | | |
| N03-n1c | Negative: a policy with the "alternatives research" step removed is rejected | | |
| N03-n1d | Negative: a policy with the "external source step" removed is rejected | | |
| N03-n2 | Negative: "the working environment's own approval of a reduction is rejected" | | |
| N03-n3 | Negative: "a standing policy written with the working environment's token" is rejected | | |
| N03-n4 | Negative: "a reduction that cites a retired standing policy" is rejected | | |
| N03-n5a | Negative: "an item that cites an active standing policy but reduces effort more than the policy allows (a lower level than the policy's …) is rejected unless it has its own approval from the audit environment" | | |
| N03-n5b | Negative: the same, "without a step the policy keeps" | | |
| N03-n5c | Negative: n5a or n5b with the item's own audit approval is accepted (the "unless") | | |
| N03-p1 | Positive: "A justified reduction with the audit environment's approval is accepted" | | |
| N03-p2 | Positive: "an item that uses a standing policy the audit environment approved for its class" is accepted | | |
| N03-f1 | Point 4: its "filled but meaningless" example | | |
| N03-x1 | Class rule, examples and break: the designer's additions | | |

### N04 · `T-W07-N04` (Ek_C:121; C02 part)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N04-c0 | Claim: "The ban on approving one's own output is at environment level" | | |
| N04-n1 | Negative: "A binding verdict … with the working environment's token is rejected (C02)" | | |
| N04-n2 | Negative: "an acceptance with the working environment's token is rejected (C02)" | | |
| N04-n3 | Negative: "a version activation from C05, in the form C05 gives release activation" | | C05 (Ek_C:121) |
| N04-n4 | Negative: "a fake role name … with the same token" is rejected | | |
| N04-n5 | Negative: "a fake session ID with the same token" is rejected | | |
| N04-n6 | Negative: "with the installation environment's token (`devos_kurulum`), a verdict or an acceptance written other than through the ledger transfer's path" is rejected (C02; EV-C02-003 section 4.2) | | |
| N04-n7 | Negative: with the `devos_kurulum` token, "any approval that a rule counts as the audit environment's, is rejected too" | | |
| N04-p1 | Positive: "The audit environment's record is accepted" | | |
| N04-p2 | Positive: "the ledger transfer's copy of an installation checker verdict is written under role class `devos_kurulum` and counts nowhere a rule needs the audit environment's (C02, until C03 hands binding review to the audit environment)" | | W-C02-14, if it needs the transfer's path (W-C02-06); state which part is shown here |
| N04-s1 | C10 part (the row does not say; R2 section 2) | | C10 |
| N04-x1 | Class rule, examples and break: the designer's additions | | |

### N08 · `T-W07-N08` (Ek_C:125; the C02 database part, N-136 and EV-C02-003 §4.5)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N08-c0 | Claim: "The role under test cannot reach the exam answers" | | |
| N08-n1 | Negative: access to the exam records with the working token is rejected | | |
| N08-n2 | Negative: … with the audit token | | |
| N08-n3 | Negative: … with the installation (`devos_kurulum`) token | | |
| N08-n4 | Negative: … with the CI (`devos_ci`) token | | |
| N08-n5 | Negative: access "to `devos-evals` with the working and audit tokens" | | C01 and C03 (Ek_C:125) |
| N08-n6 | Negative: "the fact that an exam task is an exam is kept in an area the working environment cannot see" | | State it: here (EV2 DM-24) or C03 (N-137) |
| N08-p1 | Positive: "The exam environment accesses and scores" | | |
| N08-x1 | Class rule, examples and break: the designer's additions | | |

### N09 · `T-W07-N09` (Ek_C:126; C02 part)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N09-c0 | Claim: "Changeable information is not accepted undated" | | |
| N09-n1 | Negative: "A finding that is undated … cannot become `accepted_for_use`" | | |
| N09-n2 | Negative: a finding that "has only secondary sources cannot become `accepted_for_use`" (EV2 DM-26's markers) | | |
| N09-p1 | Positive: "A dated finding with a primary source can" | | |
| N09-s1 | The C04 part (Source-based primary or secondary) | | C04 (EV2 DM-26; N-212 item 5) |
| N09-x1 | Class rule, examples and break: the designer's additions | | |

### N17 · `T-W07-N17` (Ek_C:134, with N-136)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N17-c0 | Claim: "No effect without a claim token" | | |
| N17-n1 | Negative: "An effect attempt with another session's claim … is rejected" | | |
| N17-n2 | Negative: an effect attempt "without a token is rejected" | | |
| N17-n3 | Negative: an effect, when "the caller's environment token gives a role class other than the claim's" (EV-C02-003 section 4.3) | | |
| N17-n4 | Negative: `heartbeat`, the same | | |
| N17-n5 | Negative: `release`, the same | | |
| N17-p1 | Positive: "An effect with the right token is accepted" | | |
| N17-k1 | N-136: N17 run with the `devos_kurulum` token | | |
| N17-k2 | N-136: "a claim without registration refused" | | C04 (EV3 §4.4; N-223) |
| N17-x1 | Class rule, examples and break: the designer's additions | | |

### N25 · `T-W07-N25` (Ek_C:142; C02 part)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N25-c0 | Claim: "A verdict whose basis changes goes stale" | | |
| N25-n1 | Negative: "When `basis_refs` … changes, the old verdict cannot be used for acceptance" | | |
| N25-n2 | Negative: when "the criterion" changes, the same | | |
| N25-n3 | Negative: when "the use" changes, the same | | |
| N25-p1 | Positive: "A verdict whose basis stays the same is valid" | | |
| N25-s1 | The C08 part (a verdict tied to the head commit at merge; R2 section 2) | | C08 |
| N25-x1 | Class rule, examples and break: the designer's additions | | |

### N28 · `T-W07-N28` (Ek_C:145)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N28-c0 | Claim: "The verifier does not repair" | | |
| N28-n1 | Negative: "A new revision of the target in the same transaction as the review record is rejected" | | |
| N28-p1 | Positive: "The repair is opened as a separate work item" | | |
| N28-x1 | Class rule, examples and break: the designer's additions | | |

### N29 · `T-W07-N29` (Ek_C:146; every case but the Constraint case)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| N29-c0 | Claim: "Impact class follows the rules (PC-08)" | | |
| N29-n1 | Negative: "A work item labelled routine whose target is on the high-impact path list … is rejected" | | |
| N29-n2 | Negative: a routine work item "that prepares an irreversible effect, is rejected" | | |
| N29-n3 | Negative: "a link from a work item labelled routine to a decision of class `high_impact` or `batu` (PC-42)" is rejected | | |
| N29-n4 | Negative: "a decision labelled routine on a high-impact work item" is rejected | | |
| N29-n5a | Negative: a decision "below `batu` that opens … a Mission" is rejected | | |
| N29-n5b | Negative: a decision below `batu` that "widens a Mission" is rejected | | |
| N29-n6 | Negative: "from C05, where Constraint is activated, one below `batu` that changes a Constraint is rejected" | | C05 (Ek_C:146) |
| N29-n7 | Negative: "a routine-labelled item that only a declared trigger makes high-impact, planted in a run, reaches the audit environment through the sample review" | | |
| N29-p1 | Positive: "A routine work item with no trigger is accepted and runs without extra gates" | | |
| N29-x1 | Class rule, examples and break: the designer's additions | | |

### K05 · `T-W07-K05` (Ek_C:160, with C3's introduction at Ek_C:152)

| # | Clause | Case ID(s) | Moved to |
|---|---|---|---|
| K05-c0 | Counterexample: "A small graph with many paths" | | |
| K05-s1 | Success condition: "The F04 class test" | | |
| K05-s2 | Success condition: "the row count not exceeding the record count in the real query" | | |
| K05-i1 | C3: "tested not only with database tests but with real sessions", and "the success condition is written in advance"; state what "the real query" and "real sessions" mean here (R2 "Open") | | |
| K05-x1 | The fields beyond the success condition: the designer's additions (R2 section 5 (c)) | | |

### Named as not C02's (point 2)

| Test | Where | Record |
|---|---|---|
| F02 | C04 (Ek_C:50; PC-08) | |
| F03 | C09 (Ek_C:59) | |
| N18 | W-C02-14 point 13, written after W-C02-06's design is accepted | |
| N06, N26, K06, and N08 beyond its C02 database part | C03 | |

## 2. Point 5: each line of `plan/work/C02.md`'s acceptance block, to its tests

The lines are quoted from `plan/work/C02.md` lines 29 to 39 at `db2ebd9`. W-C02-03's tests are cited by path once they are merged. Until then, they are at branch `claude/c02-w03-tests` `86ebd65`, and W-C02-07 waits for that merge where it cites them.

| # | Acceptance line (verbatim) | Hint (phase A) | Tests (ID and path) | Run in which item | Gaps |
|---|---|---|---|---|---|
| A1 | "✔ The Appendix C tests whose stage is C02 pass (F02's rule is tested in C04 with the subagent task definition; PC-08); when each rule is deliberately broken, the related test fails." | Every test of section 1; breaks in W-C02-13 | | | |
| A2 | "✘ No role can write directly to the tables." | `T-W07-5A` | | | |
| A3 | "✘ With each environment's real token, an operation that requires another environment's authority is rejected." | `T-W07-5B` (`devos-test`), `T-W07-RT` (`devos`); also `T-W07-N04`, `T-W07-N08`, N03's token cases | | | |
| A4 | "✘ An operation with another session's claim, and with a fake session ID, is rejected." | `T-W07-5C`, `T-W07-N17`, `T-W07-N04`, `T-W07-RT` | | | |
| A5 | "✘ The format gates reject empty fields; "filled but meaningless" examples fall to the sample review." | `T-W07-5D`, `T-W07-N01`, `T-W07-N02`, `T-W07-N03`, `T-W07-FGFIND`, `T-W07-T31` | | | |
| A6 | "✔ Complete records are accepted." | The positive controls of `T-W07-5D` and of each gate's test | | | |
| A7 | "✔ The four acceptance conditions of the ledger transfer are met." | W-C02-14 point 13's tests, written by the test designer after W-C02-06's design is accepted and merged before W-C02-14's work starts; not here (point 5 (e)) | | W-C02-14 | |
| A8 | "✔ A migration merged into `main` is applied by the CI job, and its effect is seen in the database." | W-C02-03: `tests/C02/W-C02-03/T-W03-05_apply_and_effect.md` | | | |
| A9 | "✘ A migration merged into `main` but not applied is detected by the comparison of 6.2 (PC-16)." | W-C02-03: `T-W03-06_merged_not_applied.md` with `supabase/migrations/tests/w03_drift_detects.sql`; `T-W03-DEC_decision_steps.md` with `test_decision_steps.py`; `T-W03-14_order_and_stop.md` | | | |
| A10 | "✘ The migration credential cannot be read by an agent session, nor by a workflow run for a branch other than `main`." | W-C02-03: `T-W03-08_branch_refused.md`, `T-W03-09_credential_search.md` | | | |
| A11 | "✔ The C01 probe schema and its tokens no longer exist." | W-C02-03: `T-W03-10_probe_absence.md` | | | |

**Point 6's checks tested elsewhere**, named in this table as point 6 asks:

| # | Check | Hint (phase A) | Tests (ID and path) | Run in which item |
|---|---|---|---|---|
| E1 | `deployment_drift` with missing, unreadable and partial input (W-C02-03 point 7, with its points 6 and 14's second example, in form C0 as its point 12 asks) | `T-W03-07_could_not_check.md` with `w03_drift_could_not_check.sql` and `test_decision_steps.py`; `T-W03-06`; `T-W03-14` | | |
| E2 | The ledger transfer's checks with missing, unreadable and partial input | W-C02-14 point 13's tests, written after W-C02-06 | | W-C02-14 |
| E3 | Any check W-C02-03 or W-C02-06 designs beyond these | `GROUPS.md` section 3 (W-C02-11's guard stop is named there) | | |

## 3. Point 8: each test, to the build item whose acceptance it serves

"Time added" is the time the test adds to W-C02-13's run, with its source and date (plan 6.12 item 1; PC-23). A wait on a schedule or a limit must appear here, for example the lease of 30 minutes (EV2 DM-07; EV2 §4, 2026-10-12) if a test waits on it.

| Test | Group | Hint: item and point | Item and point (final) | Part needing a later item (which) | Time added, source, date |
|---|---|---|---|---|---|
| `T-W07-F01` | A | W-C02-09 pt 8 | | | |
| `T-W07-F05` | A | W-C02-09 pt 8 | | | |
| `T-W07-F07` | A | W-C02-09 pt 8 | | | |
| `T-W07-F08` | A | W-C02-09 pts 3, 4, 8 | | | |
| `T-W07-CONC` | A | W-C02-09 pt 8 | | | |
| `T-W07-N17` | A | W-C02-09 pts 4, 8; real run W-C02-12 pt 6 | | | |
| `T-W07-5C` | A | W-C02-09 pt 8; real run W-C02-12 pt 6 | | | |
| `T-W07-DM07` | A | W-C02-09 pt 4 | | | |
| `T-W07-DM34` | A | W-C02-09 pt 8 | | | |
| `T-W07-6RG` | A | W-C02-09 pt 7 | | | |
| `T-W07-5F` | A | W-C02-03 (cited) | | | |
| `T-W07-F04` | B | W-C02-09 pts 7, 8 | | | |
| `T-W07-K05` | B | W-C02-09 pt 8 | | | |
| `T-W07-F06` | B | W-C02-09 pts 5, 8 | | | |
| `T-W07-N09` | B | W-C02-09 pt 8 | | | |
| `T-W07-N25` | B | W-C02-09 pt 8 | | | |
| `T-W07-N28` | B | W-C02-10 pt 5 | | | |
| `T-W07-DM02` | B | W-C02-08 pts 3, 6 | | | |
| `T-W07-DM19` | B | W-C02-09 pts 3, 5 | | | |
| `T-W07-DM19B` | B | W-C02-09 pt 3 | | | |
| `T-W07-5A` | B | W-C02-08 pts 4, 6 (negatives); W-C02-09 (positive control) | | | |
| harness | B | W-C02-13 (and W-C02-03's breaks) | | | |
| `T-W07-N01` | C | W-C02-10 pts 3, 7 | | | |
| `T-W07-N02` | C | W-C02-10 pts 6, 7 | | | |
| `T-W07-N03` | C | W-C02-10 pts 5, 7 | | | |
| `T-W07-N29` | C | W-C02-10 pts 4, 7 | | | |
| `T-W07-T31` | C | W-C02-10 pts 3, 7 | | | |
| `T-W07-5D` | C | W-C02-10 pts 2, 3, 7 | | | |
| `T-W07-FGFIND` | C | W-C02-10 pts 2, 7 | | | |
| `T-W07-DM11` | C | W-C02-10, or the stage that builds `answer_decision` | | | |
| `T-W07-DM47` | C | W-C02-10 pt 4 | | | |
| `T-W07-6ST` | C | W-C02-10 pts 3, 4 | | | |
| `T-W07-IDC` | D | W-C02-09 pt 3 | | | |
| `T-W07-6TK` | D | W-C02-09 pts 3, 7 | | | |
| `T-W07-5B` | D | W-C02-09 pt 8 (role lists); W-C02-10 pt 5 (separation lines) | | | |
| `T-W07-N04` | D | W-C02-10 pt 5; real run W-C02-12 pts 4, 5 | | | |
| `T-W07-N08` | D | W-C02-10 pt 5; real run W-C02-12 pt 5 | | | |
| `T-W07-RT` | D | W-C02-12 pts 4 to 7 | | | |
| `T-W07-7SCAN` | D | W-C02-07 pt 7 | | | |
| `T-W07-6SC` | D | W-C02-12 pt 9 | | | |
| N18 and the transfer checks' tests | not here | W-C02-14 pt 13 | | | |

Phase C adds a row for any test a group adds in its own scope (README section 1).
