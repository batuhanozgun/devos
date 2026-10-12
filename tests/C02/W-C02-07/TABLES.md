# W-C02-07 tests: the tables the acceptance asks for

Phase A wrote the skeleton of this file. The phase C2 test designer filled it on 2026-10-12, from the 40 specifications in this directory (`T-W07-*.md`), W-C02-03's merged tests and the plan. This file holds no test. It judges nothing either: whether a test passes, or fails on its break, is W-C02-13's to show.

**Where the authoritative copy is.** Each test's own specification carries its clause table (point 2) and its "Serves" and "Time added" lines (point 8). This file collects them into one view. If a cell here differs from the specification, the specification is right and this file is corrected. The checker compares the two.

**How tests are cited.** A W-C02-07 test is cited by its test ID and its specification file in this directory (for example `T-W07-F01` · `T-W07-F01_whole_intent.md`), and a case by the case ID its specification gives. A W-C02-03 test is cited by its ID and its specification under `tests/C02/W-C02-03/`. No program or SQL file is cited by path, because phase C1 moves the programs the migration job runs (N-255).

**Sources and versions.**
- Appendix C is quoted from `plan/Ek_C_Testler.md` at `main` `b679568`, unchanged since `db2ebd9`, which carries PC-42's and PC-43's changes. `Ek_C:NN` is its line.
- C02's acceptance lines are quoted from `plan/work/C02.md` lines 29 to 39 at `b679568`.
- The specifications are those at the clone's head `c699a19` (phases A and B), before phase C1's alignment. Case IDs inside a specification are stable.
- **Phase C3** (2026-10-12) updated this file on the branch at `e8f5ce8`, which carries `main` `11feac5` (PC-44, the ledger transfer's functions). The rows phase C3 changed say so; an Appendix B line cited with `11feac5` is at that commit (README section 8.1). Phase C3 closed the gaps of section 7 that are test work and marks each with what closed it.
- **Phase C4a** (2026-10-12) updated this file on the branch at `b63aceb`, which carries `main` `a98ea48`: EV-C02-008 sections 1 to 3 and PC-46, merged and accepted (PR #300; CHK-C02-025, CHK-C02-026). Appendix C N28 is quoted as PC-46 place 2 writes it (Ek_C:145 at `a98ea48`). The rows phase C4a changed say so. What EV-C02-008 section 5 changes (N-262, N-263) is phase C4b's, and is listed at the end of section 7.

**Columns.**
- "Case ID(s)" are the case IDs of the test's own specification.
- "Moved to" names the stage, or the merged plan change, that takes a clause away from C02, with its source. Point 2: "a clause is left out only where Appendix C gives it to another stage, or where a plan change through Section 14, merged before the tests, moves it".
- A clause with neither a case nor a "Moved to" entry is marked **GAP** and listed in section 7. This file does not close a gap by writing a test.
- "Design's form" marks a clause tested in the form an accepted design gives it (the executor's decision 4 of phase B), with the design's place.

## 0. Point 1: the runs that wrote the tests

Every run below was of type `test-designer`, a fresh-context subagent given `.claude/agents/test-designer.md`. The agent IDs come from the executor's task. The reports name no test written by the executor or by a build item's producer. The executor's Record states this, and the checker checks it.

| Phase | Agent ID | Wrote |
|---|---|---|
| A | `a92e3d1ca454e627f` | `README.md` (the conventions and the C0 template), `GROUPS.md` (the split and point 6's check list) and this file's skeleton. No test. |
| B, Group A | `a867a38cdb8fc4dc4` | 11 tests: `T-W07-F01`, `-F05`, `-F07`, `-F08`, `-CONC`, `-N17`, `-5C`, `-DM07`, `-DM34`, `-6RG`, `-5F`. Their SQL files, Concurrency's program and 15 breaks (`B-F01-1` to `-3`, `B-F05-1`, `B-F07-1`, `B-F08-1` and `-2`, `B-CONC-1` and `-2`, `B-N17-1`, `B-5C-1`, `B-DM07-1`, `B-DM34-1`, `B-6RG-1` and `-2`). |
| B, Group B | `aa0b3721911d8646a` | 11 tests: `T-W07-F04`, `-K05`, `-F06`, `-N09`, `-N25`, `-N28`, `-DM02`, `-DM19`, `-DM19B`, `-5A`, `-REL`. Their SQL files, two Data API programs (DM19B part B, 5A part B), 12 breaks (`B-F04-1` and `-2`, `B-K05-1`, `B-F06-1`, `B-N09-1`, `B-N25-1`, `B-N28-1`, `B-DM02-1`, `B-DM19-1`, `B-DM19B-1`, `B-5A-1`, `B-REL-1`), and the break harness with its canary. |
| B, Group C | `ad4981899748d3c8c` | 10 tests: `T-W07-N01`, `-N02`, `-N03`, `-N29`, `-T31`, `-5D`, `-FGFIND`, `-DM11`, `-DM47`, `-6ST`. Their SQL files, DM47's program and 38 breaks (`B-N01-*`, `B-N02-*`, `B-N03-*`, `B-N29-*`, `B-T31-*`, `B-5D-*`, `B-FGFIND-*`, `B-DM11-*`, `B-DM47-*`, `B-6ST-*`). |
| B, Group D | `a6ab96b9844c2e843` | 8 tests: `T-W07-IDC`, `-6TK`, `-5B`, `-N04`, `-N08`, `-RT`, `-7SCAN`, `-6SC`. `shared/token_format.md` and `shared/scan_patterns.json`, their SQL files, three programs (IDC's real path, 6TK over HTTP, 7SCAN), 10 SQL breaks (`B-IDC-1` to `-3`, `B-6TK-1` and `-2`, `B-5B-1` and `-2`, `B-N04-1`, `B-N08-1` and `-2`) and 7SCAN's two scratch-copy breaks. |
| C1 | `afaf6459da4ede741` | Aligns names and interfaces across the groups, moves the programs the migration job runs under `supabase/migrations/tests/` (N-255), and aligns `README.md`. The tests it changes are the executor's to record from its report. |
| C2 | `a1fc040de6876b43d` | This file only. No test, product or verdict. |
| C4a | phase C4a: the executor fills in the ID | To EV-C02-008 sections 1 to 3 and PC-46: `T-W07-5B`'s rows R08g, R15 (named), R20 to R26 and `B-5B-3`; new test `T-W07-ROC` (Rules O and C) with `B-ROC-1` and `-2`; `T-W07-N03`'s cases of CHK-C02-025 C2 with `B-N03-6` and `-7`, and `B-N03-3` narrowed to kinds (b) and (c); `T-W07-N28` parts A2 (`w07_n28_sample_exemption.sql`) and B2 (`harness/scenarios/n28_sample_taking.sql`) with `B-N28-2` to `-5`; `B-N01-2` and `N01-tok-*` per layer (CHK-C02-026 C2); `T-W07-RT`, `-N04` and `-6TK` aligned with EV-C02-008 1.7.4; `T-W07-F07` on `operation_state(operation_id)`; the four Data API programs' endpoint check; README 5.1 (b) and 8.1; `GROUPS.md`; this file. No product or verdict. |
| C3 | phase C3: the executor fills in the ID | Closes the test-work gaps of section 7: new cases F01-t1, F01-t2, F01-g (F01), F08-g1, F08-pos6, F08-g2, F08-w, F08-pos7 (F08), F04-m1, F04-m2, F04-u1, F04-u2 (F04), F06's recipes, 5B's row R19, 7SCAN-pf5 with 7SCAN-ec-same, -ec-diff and -ec-missing; six breaks (`B-F01-4` to `-6`, `B-F04-3`, `B-F08-3`, `-4`), `B-F08-2`'s red set widened, `B-7SCAN-3`; the six programs' input to N-255's form, with the database declaration; every backslash removed from `supabase/migrations/tests/`; the IDC program's embedded token pattern; README sections 1, 5.1, 5.2 and 8.1; the harness's program input and run time; 5F's stale text; this file. No product or verdict. |

Total: 41 test specifications (11 + 11 + 10 + 9): phase C4a adds `T-W07-ROC` to Group D. Each one's C0 field "Independence level" names its writer, its runner (the migration job, the build producer at its head, W-C02-13's prober with the breaks) and its assessor (a fresh-context checker). Checking those fields is point 3's work, not this file's.

## 1. Point 2: clause-to-case tables, per Appendix C test

Each table quotes Appendix C's clauses with their line. A class rule with several elements is split into rows, so that each element shows its case. The original finding is point 3's (C0 "Examples"), not mapped here.

"Designer's additions" are the C0 fields Appendix C leaves empty (R2 section 5 (c)): the F entries' claim; the C2 rows' class rule, examples and break; Concurrency's class rule, examples, negative control and break; K05's fields beyond its success condition. Each specification marks them as the designer's own in its Form C0.

### F01 · `T-W07-F01` · `T-W07-F01_whole_intent.md` (Ek_C:32-39)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F01-c0 | — | Claim: none in the F entries | Form C0 "ID and claim", the designer's addition | — |
| F01-r1 | 35 | "bound to the operation's **whole intent**: type" | F01-t1 (another effect class), F01-t2 (another idempotency namespace: never answered from the existing record). Phase C3, closing G1 | — |
| F01-r2 | 35 | "target" | F01-a, F01-d2 | — |
| F01-r3 | 35 | "expected base" | F01-b | — |
| F01-r4 | 35 | "content" | F01-e | — |
| F01-r5 | 35 | "work item" | F01-f | — |
| F01-r6 | 35 | "claim generation" | F01-c | — |
| F01-r7 | 35 | "authority epoch" | F01-g: the stored record's epoch planted one lower, the same key and intent from the same claim. Phase C3, closing G2 | — |
| F01-r8 | 35 | "(and the grant revision once Grant is activated, Appendix B 3.6; PC-08)" | none | Not active in C02: Grant is deferred (Appendix B 3.6; PC-08), and the clause is conditioned on its activation |
| F01-ea | 36 | "(a) same content, different target" | F01-a | — |
| F01-eb | 36 | "(b) same content and target, different expected base" | F01-b | — |
| F01-ec | 36 | "(c) everything the same, different claim generation" | F01-c | — |
| F01-ed | 36 | "(d) a delayed retry after the retention period of the key record has expired" | F01-d1, F01-d2, F01-d3. Design's form: keys are never deleted (EV-C02-002 DM-28; B 3.12, PC-42 place 17), so (d) is a back-dated retry, plus a look for any path that deletes Operation rows | — |
| F01-n1 | 37 | "(a)–(c) are rejected as conflicts" | F01-a, F01-b, F01-c | — |
| F01-n2 | 37 | "(d) is not accepted as if it were a new operation; the real state is read" | F01-d1, F01-d2 | — |
| F01-p1 | 38 | "The same key with the same full intent returns the existing record and produces no new effect" | F01-pos2, F01-d1 | — |
| F01-b1 | 39 | "When one of the intent fields is removed from the comparison, the corresponding example must start to pass and the test must fail" | B-F01-1 (F01-a, F01-d2), B-F01-2 (F01-c), B-F01-3 (F01-d1 to -d3), B-F01-4 (F01-t1), B-F01-5 (F01-t2), B-F01-6 (F01-g) | — |

### F04 · `T-W07-F04` · `T-W07-F04_affected_records.md` (Ek_C:61-68)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F04-c0 | — | Claim: none in the F entries | Form C0, the designer's addition | — |
| F04-r1 | 64 | "The affected-records query returns unique records" | F04-a-rows, F04-b-rows | — |
| F04-r2 | 64 | "the path explanation is separate and bounded" | F04-a-paths, F04-a-bounded | — |
| F04-r3 | 64 | "a result that reaches the limit carries a completeness flag" | F04-d1, F04-d2 | — |
| F04-ea | 65 | "(a) consecutive diamond structures" | F04-a-rows, -a-found, -a-complete, -a-paths, -a-bounded (18 diamonds: 55 records, 72 relations) | — |
| F04-eb | 65 | "(b) a graph containing an explanatory cycle" | F04-b-rows | — |
| F04-ec | 65 | "(c) a graph containing a node outside authority" | F04-c-noleak, F04-c-flag, F04-c-pos. Design's form: "outside authority" is DM-35's exam link (EV-C02-002 DM-35) | — |
| F04-ed | 65 | "(d) a deep graph that reaches the limit" | F04-d1, F04-d2 | — |
| F04-n1 | 66 | "The number of result rows does not exceed the number of records" | F04-a-rows, F04-b-rows, F04-d1, F04-d2 | — |
| F04-n2 | 66 | "in (d), "nothing else is affected" is not said" | F04-d1, F04-d2 | — |
| F04-n3 | 66 | "in (c), the name of the hidden node does not leak" | F04-c-noleak | — |
| F04-p1 | 67 | "All affected records are found with at least one explanatory path" | F04-a-found, F04-a-paths, F04-c-pos | — |
| F04-b1 | 68 | "When deduplication is removed, the row count in (a) must explode and the test must fail" | B-F04-1 (F04-a-rows, F04-b-rows). B-F04-2 (the flag always true) also breaks the class rule's flag: F04-c-flag, F04-d1, F04-d2 | — |

### F05 · `T-W07-F05` · `T-W07-F05_scope_both_sides.md` (Ek_C:70-77)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F05-c0 | — | Claim: none in the F entries | Form C0, the designer's addition | — |
| F05-r1 | 73 | "Every operation checks the work item, target and source scopes and their revisions together" | F05-a, F05-b, F05-c | — |
| F05-r2 | 73 | "different verification paths apply the same check" | F05-d | — |
| F05-ea | 74 | "(a) a target in another scope" | F05-a | — |
| F05-eb | 74 | "(b) a source in another scope" | F05-b. Sources are Artifacts or work items in the read set; Source is C04's (B:69; EV-C02-002 DM-34) | — |
| F05-ec | 74 | "(c) the right scope, an old revision" | F05-c | — |
| F05-ed | 74 | "(d) the same operation attempted through a second function path" | F05-d (`prepare_operation` beside `register_artifact`) | — |
| F05-n1 | 75 | "All are rejected" | F05-a, F05-b, F05-c, F05-d | — |
| F05-p1 | 76 | "The right scope and the current revision are accepted" | F05-pos1, F05-pos2, F05-pos3 | — |
| F05-b1 | 77 | "When the target scope check is removed, (a) must pass" | B-F05-1 (F05-a, F05-d) | — |

### F06 · `T-W07-F06` · `T-W07-F06_state_change_event.md` (Ek_C:79-86)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F06-c0 | — | Claim: none in the F entries | Form C0, the designer's addition | — |
| F06-r1 | 82 | "Every state-changing function produces an event in the same transaction" | F06-event:\<f\>, one per state-changing function. Phase C3 (G5, closed in part): a recipe for every state-changing C02 function README 8.1 lets the file form (27 state-changing functions with recipes, phases B, C1 and C3 together); listed as `could_not_check`, each with its reason: the ledger transfer's fourteen functions, `mark_exported`, `link_prior_decisions` and `deployment_drift`'s event case (section 7, G20) | — |
| F06-r2 | 82 | "on rollback the two are rolled back together" | F06-orphan-a, F06-orphan-b | — |
| F06-r3 | 82 | "an exact repeat produces no new event" | F06-repeat:\<f\> | — |
| F06-e1 | 83 | "All state-changing functions, one by one (the function list is extracted automatically from `devos_api` and from the owner-only functions of `devos_private`, `issue_env_token` and `revoke_env_token`" | F06-list; F06-refused:\<f\> (no recipe needed); F06-event:\<f\>; F06-owner:issue_env_token, F06-owner:revoke_env_token | — |
| F06-e2 | 83 | "every function whose catalogue comment does not mark it as a read function counts as state-changing" | F06-list, F06-refused:\<f\> | — |
| F06-e3 | 83 | "a function so marked is checked to change no table but RejectedAttempt, on accepted and on refused calls" | F06-read-refused:\<f\>, F06-read-accepted:\<f\> | — |
| F06-e4 | 83 | "when a new function is added, the test covers it by itself; PC-42" | F06-list, F06-refused:\<f\>. A new function's F06-event case gives `could_not_check` until its recipe is added, so it shows as unchecked, never as passed. | — |
| F06-n1 | 84 | "If a function that produces no event is found … the test fails" | F06-event:\<f\> | — |
| F06-n2 | 84 | "or an event without the caller's `role_class` taken from its token (Appendix B 3.13)" | F06-event:\<f\> (role class checked), F06-role-token, F06-owner:\<f\> | — |
| F06-n3 | 84 | "when an error is raised in the middle of a transaction, no half state or orphan event remains" | F06-orphan-a, F06-orphan-b (and T-W07-DM19) | — |
| F06-p1 | 85 | "An exact repeat produces no new event but raises no error either" | F06-repeat:\<f\> | — |
| F06-b1 | 86 | "When event production is removed from a function, the test must fail" | B-F06-1 (F06-event:relate, F06-role-token) | — |

The original finding's "reassignment" (Ek_C:81) maps to F06-event:claim and F06-event:revoke_claim, both with recipes since phases C1 and C3.

### F07 · `T-W07-F07` · `T-W07-F07_observation_history.md` (Ek_C:88-95; C02 part)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F07-c0 | — | Claim: none in the F entries | Form C0, the designer's addition | — |
| F07-r1 | 91 | "Observations are appended, not deleted" | F07-a1, F07-b1, F07-c1 | — |
| F07-r2 | 91 | "a later observation does not remove earlier evidence" | F07-a1, -b1, -c1, -a2, -b2, -c2 | — |
| F07-r3 | 91 | ""applied in the past", "current now" and "accepted" are separate questions" | F07-a2, -b2, -c2 (past and current); F07-c3 (accepted) | — |
| F07-ea | 92 | "(a) applied, then unknown" | F07-a1, F07-a2 | — |
| F07-eb | 92 | "(b) observations arriving out of order" | F07-b1, F07-b2 | — |
| F07-ec1 | 92 | "(c) the PR merged, then `main` was reverted", as a synthetic sequence | F07-c1, F07-c2, F07-c3 | — |
| F07-ec2 | 92, 95 | (c) "with real GitHub" | none | C08: "Stage: C02 and C08 (with real GitHub)" (Ek_C:95; W-C02-07 point 2) |
| F07-n1 | 93 | "In no case is past "applied" evidence lost" | F07-a1, -b1, -c1, -a2, -b2, -c2 | — |
| F07-p1 | 94 | "The current-state question gives the right answer" | F07-a2, F07-b2, F07-c2 | — |
| F07-b1 | 95 | "When updates are allowed on the observation table, (a) must fail" | B-F07-1 (F07-a1 and -a2, among six) | — |

F07-a2, -b2 and -c2 read the current state through `devos_api.operation_state(operation_id uuid)`, which Appendix B section 4 does not name and EV-C02-008 1.7.2 names, with its argument, its fields and its row (`T-W07-5B` R26; phase C4a). If the build has no such read, those cases give `could_not_check`.

### F08 · `T-W07-F08` · `T-W07-F08_recheck_at_effect.md` (Ek_C:97-104)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| F08-c0 | — | Claim: none in the F entries | Form C0, the designer's addition | — |
| F08-r1 | 100 | "At the moment of effect, the current work item … [is] checked again" | F08-w (the work item revised after the claim; the effect then refused), with its paired control F08-pos7. Phase C3, closing G4 | — |
| F08-r2 | 100 | "dependencies" | F08-a | — |
| F08-r3a | 100 | "claim (active" | F08-c1 (revoked), F08-c2 (expired), F08-g1 (released; phase C3) | — |
| F08-r3b | 100 | "current generation" | F08-g1 (a released claim's token), F08-g2 (the earlier generation's token after the work item is claimed again), with F08-pos6. Phase C3, closing G3 | — |
| F08-r3c | 100 | "valid epoch)" | F08-c3 | — |
| F08-r4 | 100 | "and read set are checked again" | F08-b, F08-d | — |
| F08-r5 | 100 | "(and the grant, once Grant is activated; PC-08)" | none | Not active in C02: Grant is deferred (Appendix B 3.6; PC-08) |
| F08-r6 | 100 | "the mandatory elements of the read set are determined on the server according to the operation type" | F08-d, F08-pos5. Design's form: the server's mandatory elements per effect class (EV-C02-002 DM-37), with a synthetic class | — |
| F08-ea | 101 | "(a) a new hard dependency" | F08-a | — |
| F08-eb | 101 | "(b) a change to a source in the read set" | F08-b (the source is a work-item revision; Source is C04's) | — |
| F08-ec1 | 101 | "(c) revocation … of the claim" | F08-c1 | — |
| F08-ec2 | 101 | "or expiry of the claim" | F08-c2 (lease planted as passed) | — |
| F08-ec3 | 101 | "or an authority epoch change after the claim" | F08-c3 (a synthetic token revoked) | — |
| F08-ed | 101 | "(d) the agent deliberately writing an incomplete read set" | F08-d | — |
| F08-n1 | 102 | "The effect is rejected" | F08-a, -b, -c1, -c2, -c3, -d; F08-g1, -g2, -w (phase C3) | — |
| F08-n2 | 102 | "the candidate result is kept" | F08-a (F08-pos0's artifact still there) | — |
| F08-p1 | 103 | "After the dependency is resolved, the effect can be made" | F08-pos2 | — |
| F08-p2 | 103 | "an independent exploration work item can continue under another claim" | F08-pos1 | — |
| F08-b1 | 104 | "When the re-check at the moment of effect is removed, (a) must pass" | B-F08-1 (F08-a); B-F08-2 (F08-c1, -c2, -c3, -g1); B-F08-3 (F08-c1, -g1, -g2); B-F08-4 (F08-w) (phase C3 added the last two and -g1) | — |

### Concurrency · `T-W07-CONC` · `T-W07-CONC_claim_and_cycle.md` (Ek_C:106-110)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| CONC-c1 | 108 | "Of several connections that request the same work item at the same time, only one claims it" | CONC-claim, CONC-overlap | — |
| CONC-c2 | 108 | "when two opposing hard dependencies are added at the same time, no cycle forms" | CONC-cyc2, CONC-cyc4 | — |
| CONC-m1 | 109 | "Many concurrent connections on real PostgreSQL; repeated runs" | 8 connections; 20 runs for the claim, 20 for two edges, 20 for four edges, 10 for the late effect, fixed before any run; CONC-overlap shows that the transactions overlapped (W-C02-13 point 4) | — |
| CONC-p1 | 110 | "One claim always succeeds (the system does not deadlock and reject everyone)" | CONC-pos, CONC-err | — |
| CONC-x1 | — | Class rule, examples, negative control and break (none in Appendix C) | Form C0, the designer's additions (five marks); CONC-late and CONC-tokens; B-CONC-1 (CONC-claim), B-CONC-2 (the dependency queue removed: CONC-cyc2 and CONC-cyc4) | — |

### N01 · `T-W07-N01` · `T-W07-N01_need_justification.md` (Ek_C:118)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N01-c0 | 118 | "A prerequisite without a justification is not accepted (format gate)" | N01-neg1, N01-neg2, N01-neg3 | — |
| N01-n1 | 118 | "A need with an empty `why_needed` is rejected" | N01-neg1 (empty), N01-neg2 (absent), N01-neg3 (whitespace) | — |
| N01-n2 | 118 | "a "filled but meaningless" justification is accepted by the database and lands in sample review" | N01-fbm1, N01-fbm2 | — |
| N01-n2b | 118 | "with the share set to take it, it reaches the audit environment's queue as a `Review` of kind `sample` (Appendix B 3.11)" | N01-fbm1, N01-fbm2 (a complete block of ten meaningless needs: the share takes one of them wherever the hidden position falls) | — |
| N01-n3 | 118 | "at the set share, the share of sampled needs matches the rate" | N01-share, N01-rate (3 of 30, tolerance 0; the tolerance is the designer's addition, with its reason, EV-C02-002 DM-08); N01-writer | — |
| N01-n4 | 118 | "a sample review written with the working environment's token is rejected" | N01-tok-devos_calisma (and -devos_denetim, -devos_sinav, -devos_kurulum, W-C02-10 point 3): `open_review`'s own refusal, returned and recorded (phase C4a, CHK-C02-026 C2); the Review table's check behind it: `T-W07-N28`'s S-neg-direct; every class and `transfer_review`: S-neg-open-* | — |
| N01-p1 | 118 | "A need with a justification is accepted" | N01-pos | — |
| N01-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N01-1, B-N01-2 (layer 1, revised in phase C4a), B-N01-3; layer 2 is `T-W07-N28`'s B-N28-3 | — |

### N02 · `T-W07-N02` · `T-W07-N02_decision_alternatives.md` (Ek_C:119)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N02-c0 | 119 | "A high-impact decision cannot be opened without alternatives research" | N02-neg-none-\*, N02-neg-compared-empty-\*, N02-neg-single-blank-\* (classes `high_impact` and `batu`) | — |
| N02-n1 | 119 | "A decision with neither compared options, nor a single-path justification, nor an open exploration state is rejected" | N02-neg-none-hi, N02-neg-none-batu | — |
| N02-n2 | 119 | "a major design decision without premises is rejected" | N02-neg-premises-empty-\*, N02-neg-premises-absent-\*. Design's form: EV-C02-002 DM-27 gives C02 no "major design" marker, so it is a `high_impact` or `batu` decision without `premises` | — |
| N02-p1 | 119 | "A decision that writes down the single feasible path with its justification is accepted" | N02-pos-single-hi, N02-pos-single-batu | — |
| N02-p2 | 119 | "an invented second option is not required" | N02-pos-single-one-option-\*, N02-pos-single-\* | — |
| N02-f1 | — | W-C02-07 point 4: N02's "filled but meaningless" example, accepted and landing in sample review | N02-fbm1, N02-fbm2 | — |
| N02-f2 | — | W-C02-07 point 4: a decision with `alternatives_state = open_exploration` cannot be answered or accepted, through each transition C02 builds, until the compared options or `single_viable_path_reason` are entered | N02-oe-answer-\*, N02-oe-accept-\*, N02-oe-pos-reason-\*, N02-oe-pos-options (the rule on the decision's state, EV-C02-002 DM-46); N02-oe-transfer (the ledger transfer's answering path: `could_not_check` until W-C02-06's design is accepted, the executor's decision 5) | `answer_decision`: C06 (B:390). **GAP**: point 4 asks for a carrier note on `plan/work/C06.md`, named in the record; there is none at `b679568` (section 5) |
| N02-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; N02-pos-compared-\*, N02-pos-open-exploration-\*; B-N02-1 to B-N02-4 | — |

### N03 · `T-W07-N03` · `T-W07-N03_effort_policy.md` (Ek_C:120)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N03-c0 | 120 | "Non-removable effort steps and the expert assessment cannot be emptied; a reduction needs the audit environment's approval" | every case | — |
| N03-n1a | 120 | "A policy from which the expert assessment … has been removed is rejected" | N03-neg-expert-empty, N03-neg-expert-absent | — |
| N03-n1b | 120 | "… verification …" | N03-neg-step-verification, N03-neg-step-with-audit-token | — |
| N03-n1c | 120 | "… alternatives research …" | N03-neg-step-alternatives_research | — |
| N03-n1d | 120 | "… or external source step …" | N03-neg-step-external_source_research. It rests on the specification's reading of B 3.18: external source research is required on high items and on standing policies. | — |
| N03-n2 | 120 | "the working environment's own approval of a reduction is rejected" | N03-neg-own-approval, N03-neg-own-approval-declared (and -kurulum, N-136; EV-C01-004 S8 line 1) | — |
| N03-n3 | 120 | "and so are a standing policy written with the working environment's token" | N03-neg-standing-calisma (and -kurulum, EV-C02-003 §15) | — |
| N03-n4 | 120 | "and a reduction that cites a retired standing policy" | N03-neg-retired (and N03-neg-retire-by-calisma) | — |
| N03-n5a | 120 | "an item that cites an active standing policy but reduces effort more than the policy allows (a lower level than the policy's" | N03-neg-over-level | — |
| N03-n5b | 120 | "or without a step the policy keeps) is rejected" | N03-neg-over-step | — |
| N03-n5c | 120 | "unless it has its own approval from the audit environment" | N03-pos-over-with-approval | — |
| N03-p1 | 120 | "A justified reduction with the audit environment's approval is accepted" | N03-pos-audit-reduction (and N03-pos-default) | — |
| N03-p2 | 120 | "and so is an item that uses a standing policy the audit environment approved for its class" | N03-pos-standing-audit, N03-pos-standing-use | — |
| N03-k1 | — | Phase C4a, EV-C02-008 1.7.4 with CHK-C02-025 C2 (a): `devos_sinav`, a reduction, a standing policy and a retirement refused | N03-neg-own-approval-sinav, N03-neg-standing-sinav, N03-neg-retire-by-sinav; positive N03-pos-default-sinav | — |
| N03-k2 | — | CHK-C02-025 C2 (b): `devos_denetim`, a kind (a) write refused | N03-neg-default-denetim | — |
| N03-k3 | — | CHK-C02-025 C2 (c): kind (a) under Rule O refused for `devos_kurulum` outside the installation and for `devos_sinav` on an item its exam link does not name | N03-neg-rule-o-kurulum, N03-neg-rule-o-sinav; positives N03-pos-default-kurulum (through the hook, G21), N03-pos-default-sinav | — |
| N03-f1 | — | W-C02-07 point 4: its "filled but meaningless" example | N03-fbm1, N03-fbm2 | — |
| N03-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N03-1 to B-N03-7 (B-N03-3 narrowed to kinds (b) and (c), and B-N03-6 and -7 added, in phase C4a) | — |

### N04 · `T-W07-N04` · `T-W07-N04_self_approval.md` (Ek_C:121, as PC-43 place 9 writes it; C02 part)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N04-c0 | 121 | "The ban on approving one's own output is at environment level" | the whole test | — |
| N04-n1 | 121 | "A binding verdict … with the working environment's token is rejected (C02)" | N04-a1, N04-a2 | — |
| N04-n2 | 121 | "or an acceptance with the working environment's token is rejected (C02)" | N04-b1, N04-b2 | — |
| N04-n3 | 121 | "and so is a version activation from C05, in the form C05 gives release activation (Appendix B 3.14)" | none | C05: the clause's own "from C05"; Appendix C's stage column; C02 builds no release activation |
| N04-n4 | 121 | "**a fake role name** … with the same token" | N04-c1 (headers), N04-c2 (JWT claim settings), N04-c3-\<function\> (arguments), N04-c4 (a database role), N04-e2, N04-k6 | — |
| N04-n5 | 121 | "**a fake session ID with the same token** are also rejected" | N04-e1-\<function\>, N04-e2, N04-k6 | — |
| N04-n6 | 121 | "with the installation environment's token (`devos_kurulum`), a verdict or an acceptance written other than through the ledger transfer's path" | N04-k1, N04-k1b, N04-k2, N04-k6 | — |
| N04-n7 | 121 | "and any approval that a rule counts as the audit environment's, is rejected too (C02; EV-C02-003 section 4.2)" | N04-k-\<function\> (`set_effort_policy` no longer among them: EV-C02-008 1.7.4); T-W07-5B rows R07, R10r, R15 and R25 for `devos_kurulum`; R08's operations after the gate: `T-W07-N03`'s N03-neg-own-approval-kurulum, N03-neg-standing-kurulum (phase C4a) | — |
| N04-p1 | 121 | "The audit environment's record is accepted" | N04-p1 to N04-p4 | — |
| N04-p2 | 121 | "the ledger transfer's copy of an installation checker verdict is written under role class `devos_kurulum` and counts nowhere a rule needs the audit environment's (C02, until C03 hands binding review to the audit environment)" | Part T, T1 to T4, reported on its own line, outside the file's result. Written; `could_not_check` until W-C02-06's design is accepted (the executor's decision 5) | Counted by W-C02-14 (point 13), not a stage move; see section 7 |
| N04-s1 | 121 | Stage "C02, C05, C10" | C02: this test | C05 and C10 (Appendix C's stage column) |
| N04-k1 | — | N-136 (W-C02-07 point 2): N04 with the `devos_kurulum` token | N04-k\* | — |
| N04-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N04-1, B-5B-1 | — |

Real-token form (W-C02-12 points 4 to 6): `T-W07-RT` cases RT-cal-n1, RT-cal-n2, RT-cal-n5, RT-kur-n2, RT-kur-n5 and RT-den-p2.

### N08 · `T-W07-N08` · `T-W07-N08_exam_records.md` (Ek_C:125, as PC-43 place 10 writes it; the database part, EV-C02-003 §4.5)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N08-c0 | 125 | "The role under test cannot reach the exam answers" | the whole test, at the database | — |
| N08-n1 | 125 | "Every access to the exam records with the working … token[s] … is rejected" | N08-w-devos_calisma, N08-w2-devos_calisma, N08-r-\<function\>-devos_calisma | — |
| N08-n2 | 125 | "… audit …" | N08-w-devos_denetim, N08-r-\<function\>-devos_denetim | — |
| N08-n3 | 125 | "… installation (`devos_kurulum`) …" (N-136) | N08-w-devos_kurulum, N08-r-\<function\>-devos_kurulum | — |
| N08-n4 | 125 | "… and CI (`devos_ci`) tokens" | N08-w-devos_ci, N08-r-\<function\>-devos_ci | — |
| N08-n4b | — | Direct access to the exam records' table | T-W07-5A (5A-r:\<role\>:\<table\>) | — |
| N08-n5 | 125 | "and to `devos-evals` with the working and audit tokens, is rejected" | none | C01 (the `devos-evals` part, C01 #12) and C03 (N-137): Appendix C's stage column |
| N08-n6 | 125 | "the fact that an exam task is an exam is kept in an area the working environment cannot see" | The database part: N08-s1, N08-s2, N08-r-\* | What a session sees: C03 (N-137); C05 may change the form (N-138) |
| N08-p1 | 125 | "The exam environment accesses" | N08-wp1, N08-wp2, N08-rp-\<function\> | — |
| N08-p2 | 125 | "and scores" | none | C05, on the specification's reading (the grader's fields; Appendix B's activation table). Appendix C names C05 as a stage but not which part is C05's; see section 7 |
| N08-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N08-1, B-N08-2 | — |

If no function reads EvalRun's table, N08 prints a notice. The read is then closed by T-W07-5A and by the absence of a reading function.

### N09 · `T-W07-N09` · `T-W07-N09_finding_gate.md` (Ek_C:126; C02 part)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N09-c0 | 126 | "Changeable information is not accepted undated" | N09-a to N09-d | — |
| N09-n1 | 126 | "A finding that is undated … cannot become `accepted_for_use`" | N09-a, N09-d | — |
| N09-n2 | 126 | "or has only secondary sources cannot become `accepted_for_use`" | N09-b, N09-c. Design's form: Appendix B 3.8 with PC-42 place 15, through the source spans' markers and dates (EV-C02-002 DM-26) | — |
| N09-p1 | 126 | "A dated finding with a primary source can" | N09-pos | — |
| N09-s1 | 126 | Stage "C02, C04": the C04 part | none | C04, where a span's Source record decides primary or secondary (Appendix C's stage column; PC-42 place 15; N-212 item 5) |
| N09-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N09-1 | — |

### N17 · `T-W07-N17` · `T-W07-N17_claim_token.md` (Ek_C:134, as PC-43 place 11 writes it; with N-136)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N17-c0 | 134 | "No effect without a claim token" | the whole test | — |
| N17-n1 | 134 | "An effect attempt with another session's claim … is rejected" | N17-n1 (and T-W07-5C's 5C-n1, 5C-n4) | — |
| N17-n2 | 134 | "or without a token is rejected" | N17-n2 (none), N17-n3 (empty), N17-n4 (unknown) | — |
| N17-n3 | 134 | "and so is any call that takes a claim token (an effect …) when the caller's environment token gives a role class other than the claim's (EV-C02-003 section 4.3)" | N17-n5, N17-n8 | — |
| N17-n4 | 134 | "… `heartbeat` …" | N17-n6 | — |
| N17-n5 | 134 | "… or `release` …" | N17-n7 | — |
| N17-p1 | 134 | "An effect with the right token is accepted" | N17-pos1 (and -pos2, -pos3, -pos4) | — |
| N17-k1 | — | N-136: N17 run with the `devos_kurulum` token | N17-pos2, N17-n7, N17-n8 | — |
| N17-k2 | — | N-136: "a claim used with another role class's token" | N17-n5 to N17-n8 | — |
| N17-k3 | — | N-136: "a claim without registration refused" | none | C04, with SessionRecord and `register_session`: PC-43 place 11 (merged; "S8 line 3 … moves to C04 … and is not added here"), EV-C02-003 §4.4, N-223 on `plan/work/C04.md` |
| N17-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; N17-n9 (a lapsed claim); B-N17-1, B-5C-1 | — |

Real-token form: `T-W07-RT` cases RT-cal-p2, RT-cal-n6 and RT-cal-n8 (the last labelled "within one session"). RT-s8l2 is not made with real tokens, for the reason the specification states, and is left to N17 in `devos-test`.

### N25 · `T-W07-N25` · `T-W07-N25_verdict_staleness.md` (Ek_C:142; C02 part)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N25-c0 | 142 | "A verdict whose basis changes goes stale" | N25-a, N25-d | — |
| N25-n1 | 142 | "When `basis_refs` … changes, the old verdict cannot be used for acceptance" | N25-a, N25-d | — |
| N25-n2 | 142 | "… the criterion …" | N25-b | — |
| N25-n3 | 142 | "… or the use changes …" | N25-c | — |
| N25-p1 | 142 | "A verdict whose basis stays the same is valid" | N25-pos | — |
| N25-s1 | 142 | Stage "C02, C08": the C08 part | none | C08, a verdict tied to the head commit at merge (Appendix C's stage column; R2 section 2) |
| N25-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; B-N25-1 | — |

### N28 · `T-W07-N28` · `T-W07-N28_verifier_does_not_repair.md` (Ek_C:145, as PC-46 place 2 writes it; phase C4a)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N28-c0 | 145 | "The verifier does not repair" | N28-a, N28-b, N28-S-verdict, S-neg-take-verdict-first, S-neg-take-revision-first, S-neg-take-fields | — |
| N28-n1 | 145 | "A new revision of the target in the same transaction as the review record is rejected" | N28-a, N28-b (EV-C02-008 2.5's S-neg-client), and N28-S-verdict (DM-41's Verdict) | — |
| N28-n2 | 145 | "and so is one in the transaction that takes a `sample` Review or writes its verdict" | S-neg-take-verdict-first, S-neg-take-revision-first, S-neg-take-fields (where the build has that form; G21); positive pair S-neg-take-pos (part B2, the throwaway database) | — |
| N28-n3 | 145 | "the `sample` Review the database itself opens for the record revision that draws it is not a review record here (Appendix B 3.11)" | S-pos-gate-need, -decision, -effort_policy, -finding, S-pos-routine-work, -decision; its bounds: S-neg-open-* and S-neg-open-transfer, S-neg-direct, S-ccc (G21) | — |
| N28-p1 | 145 | "The repair is opened as a separate work item" | N28-S-repair, N28-S-sep, N28-S-later. Design's form: the separate transactions run only on the throwaway database (EV-C02-002 §5; DM-41 (b)), so the positive rests on the harness's run | — |
| N28-p2 | 145 | "a record whose accepted write draws a `sample` Review is accepted with it in the same transaction" | S-pos-gate-*, S-pos-routine-* | — |
| N28-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; N28-pos; B-N28-1; B-N28-2 to B-N28-5 (EV-C02-008 2.5's B-S1 to B-S4, B-S3 in its Verdict form; phase C4a) | — |

### N29 · `T-W07-N29` · `T-W07-N29_impact_class.md` (Ek_C:146, with PC-42's link clause; every case but the Constraint case)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| N29-c0 | 146 | "Impact class follows the rules (PC-08)" | every case | — |
| N29-n1 | 146 | "A work item labelled routine whose target is on the high-impact path list … is rejected" | N29-art-\<path\> (one per row of the path table), N29-op-path-migrations, N29-op-path-claude. Design's form: the database reads the target of the item's Artifact or Operation (EV-C02-002 DM-48; B:134) | — |
| N29-n2 | 146 | "or that prepares an irreversible effect, is rejected" | N29-op-irreversible | — |
| N29-n3 | 146 | "and so is a link from a work item labelled routine to a decision of class `high_impact` or `batu` (PC-42)" | N29-link-high_impact, N29-link-depends_on, N29-link-batu | — |
| N29-n4 | 146 | "a decision labelled routine on a high-impact work item … [is] rejected" | N29-dec-routine-on-high | — |
| N29-n5a | 146 | "and one below `batu` that opens … a Mission" | N29-mis-open-high_impact, N29-mis-open-routine | — |
| N29-n5b | 146 | "… or widens a Mission, are rejected" | N29-mis-widen-high_impact | — |
| N29-n6 | 146 | "from C05, where Constraint is activated, one below `batu` that changes a Constraint is rejected" | none | C05: the clause's own "from C05"; Appendix C's stage column "C05 (the Constraint case)" |
| N29-n7 | 146 | "a routine-labelled item that only a declared trigger makes high-impact, planted in a run, reaches the audit environment through the sample review" | N29-sample-work (and N29-sample-decision, W-C02-10 point 3's routine decisions); N29-share-work_routine, N29-share-decision_routine | — |
| N29-p1 | 146 | "A routine work item with no trigger is accepted and runs without extra gates" | N29-pos-admit, N29-pos-artifact, N29-pos-operation, N29-pos-link | — |
| N29-x1 | — | Class rule, examples and break (none in Appendix C) | Form C0, the designer's additions; N29-pos-dec-high-on-high, N29-pos-mis-open-batu, N29-pos-mis-widen-batu; B-N29-1 to B-N29-6 | — |

### K05 · `T-W07-K05` · `T-W07-K05_many_paths.md` (Ek_C:160, with C3's introduction at Ek_C:152)

| # | Line | Clause (verbatim) | Case ID(s) | Moved to |
|---|---|---|---|---|
| K05-c0 | 160 | Counterexample: "A small graph with many paths" | K05-graph (a ladder of 55 records and 72 relations) | — |
| K05-s1 | 160 | Success condition: "The F04 class test" | K05-rows, K05-found, K05-complete, K05-paths, K05-time; and T-W07-F04 in full | — |
| K05-s2 | 160 | "and the row count not exceeding the record count in the real query" | K05-rows (`devos-test`), K05-B-rows (`devos`). Design's form: "the real query" is the deployed function on real PostgreSQL, not a copy (EV-C02-002 §5) | — |
| K05-i1 | 152 | "These are tested not only with database tests but with real sessions" | Part B: K05-B-rows, -B-found, -B-complete, -B-time, -B-paths, from a `devos-calisma` session with its real token, on the test Mission's ladder (EV-C02-002 §5 and DM-23). By the executor's decision, W-C02-13 runs part B in a session of sitting B2 (W-C02-12), and it is `could_not_check` until then (section 6) | — |
| K05-i2 | 152 | "For each of them, the success condition is written in advance" | The specification's section "Success condition, written before any run" | — |
| K05-x1 | — | The fields beyond the success condition (R2 section 5 (c)) | Form C0, the designer's additions; B-K05-1 (and B-F04-1) | — |

### Named as not C02's (point 2)

| Test | Where | Source |
|---|---|---|
| F02 | C04, with the subagent task definition | Ek_C:50 ("Stage: C04"); `plan/work/C02.md` line 29; PC-08 |
| F03 | C09, with a real restore | Ek_C:59 ("Stage: C09") |
| N18 | W-C02-14's test, not this item's: written by the test designer after W-C02-06's design is accepted, merged before W-C02-14's work starts | W-C02-07 point 2; W-C02-14's body and its point 13. W-C02-06 is at `execution: running`, `acceptance: proposed` at `b679568`, so N18 is not written. |
| N06, N26, K06, and N08 beyond its database part | C03 | Ek_C:123, 143, 161 and 125; W-C02-07 "Not covered" |
| The later parts of F07, N04, N09, N25 and N29 | C08; C05 and C10; C04; C08; C05 | The rows above |

## 2. Point 5: each line of `plan/work/C02.md`'s acceptance block, to its tests

W-C02-03's tests are merged on `main`: commit `ceb206b` (CHK-C02-017's conditions C1 and C2 applied) is an ancestor of `main` `b679568`. Phase C2 counted the ten C0 field names in each of the eight cited specifications on `main`, as `T-W07-5F`'s command does, and found all ten in each. That count is a look, not `T-W07-5F`'s result. No migration line lacks a test in form C0 there, so none is written here (point 5 (f)).

| # | Line | Acceptance line (verbatim) | Tests (ID · specification) | Run in which item | Gaps |
|---|---|---|---|---|---|
| A1 | 29 | "✔ The Appendix C tests whose stage is C02 pass (F02's rule is tested in C04 with the subagent task definition; PC-08); when each rule is deliberately broken, the related test fails." | The 18 tests of section 1, with their breaks: `T-W07-F01`, `-F04`, `-F05`, `-F06`, `-F07`, `-F08`, `-CONC`, `-N01`, `-N02`, `-N03`, `-N04`, `-N08`, `-N09`, `-N17`, `-N25`, `-N28`, `-N29`, `-K05`. The breaks run on the harness of `harness/README.md` (Group B). F02: C04. | W-C02-09 point 8: F01, F04 with K05, F05, F06, F07, F08, Concurrency, N09, N17, N25. W-C02-10 point 7: N01, N02, N03, N04, N28, N29; point 5: N08. W-C02-13 runs them all, with their breaks (points 1 to 4). K05 part B: W-C02-13 in sitting B2. | Section 7: G6 to G9 and G20 (G1 to G4 closed in phase C3; G5 in part) |
| A2 | 30 | "✘ No role can write directly to the tables." | `T-W07-5A` · `T-W07-5A_no_direct_writes.md` (5A-w, 5A-r, 5A-snap, 5A-cat-\*, part B 5A-B-\*; positive control 5A-pos). Also `T-W07-DM02` · `T-W07-DM02_revision_append_only.md` (the revision tables refuse UPDATE and DELETE to every role). The migration credential's role and the project owner are named as outside the line, with the reason (5A, "Outside the line"). | W-C02-08 points 4 and 6 (negatives; DM02 also point 3); W-C02-09 point 8 (5A-pos); W-C02-13 | — |
| A3 | 31 | "✘ With each environment's real token, an operation that requires another environment's authority is rejected." | With `devos-test`'s synthetic tokens: `T-W07-5B` · `T-W07-5B_authorization_matrix.md` (every cell of EV-C02-003 §4.1 and of EV-C02-008's rows; point 5 (b)'s "Cannot do" lines, by its clause table); `T-W07-ROC` · `T-W07-ROC_ownership_and_claim_class.md` (Rules O and C after the gate, EV-C02-008 1.7.1); `T-W07-N04`; `T-W07-N08`; `T-W07-N03` (its token cases); `T-W07-N01` (N01-tok-\*); `T-W07-IDC` · `T-W07-IDC_identity_chain.md` (IDC-n-\*: issuing and revoking refused to every class). With the real tokens: `T-W07-RT` · `T-W07-RT_real_token_runs.md` | 5B and ROC: W-C02-09 point 8 (role lists and the checks after the gate) and W-C02-10 point 5 (separation). N04, N08, N03: W-C02-10 point 5. IDC: W-C02-09 point 3. RT: W-C02-12 points 4 to 7, counted by W-C02-13 (point 2) only if its envelope shows the same deployed migrations and function versions. | G7 (four rows with functions the build names: R10r, R12 to R14); G21 (hooks); RT-s8l2 not made with real tokens, for the reason RT states. Phase C3: PC-44's fourteen ledger transfer functions are 5B's row R19, "Only `devos_kurulum`" (B:397). Phase C4a: EV-C02-008 1.2 and 1.7 give 5B the rows R08g, R15, R20 to R26; Rules O and C are `T-W07-ROC` |
| A4 | 32 | "✘ An operation with another session's claim, and with a fake session ID, is rejected." | `T-W07-5C` · `T-W07-5C_other_session_fake_id.md` (a claim-bearing operation that is not a verdict: 5C-n1 to 5C-n5); `T-W07-N17`; `T-W07-N04` (verdicts: N04-e1-\*, N04-e2, N04-k6); `T-W07-RT` (RT-cal-n5 to RT-cal-n8, RT-kur-n5) | 5C, N17: W-C02-09 points 4 and 8. N04: W-C02-10 point 5. RT: W-C02-12 point 6. | G13 (the reading of "fake session ID"); RT-cal-n7 and RT-cal-n8 are labelled "within one session" (W-C02-12 point 7) |
| A5 | 33 | "✘ The format gates reject empty fields; "filled but meaningless" examples fall to the sample review." | `T-W07-5D` · `T-W07-5D_format_gates_empty.md`; `T-W07-N01`; `T-W07-N02`; `T-W07-N03`; `T-W07-FGFIND` · `T-W07-FGFIND_finding_gate.md`; `T-W07-T31` · `T-W07-T31_planted_rate.md`; N29-sample-\* (the routine sample). The share's "could not check": `T-W07-6ST` · `T-W07-6ST_settings_could_not_check.md`. N-032's gate is moved to C03 (EV-C02-002 §3 row 2.12; N-211). | W-C02-10 points 2, 3, 6 and 7; W-C02-13 point 5 | G6 (C06's carrier note) |
| A6 | 34 | "✔ Complete records are accepted." | The positive controls: 5D-need-pos, 5D-dec-hi-pos, 5D-dec-batu-pos, 5D-eff-pos, 5D-find-pos, 5D-eff-rev-pos; N01-pos; N02-pos-\*; N03-pos-\*; FGFIND-pos, FGFIND-pos-changeable | W-C02-10 point 7; W-C02-13 point 5 | — |
| A7 | 35 | "✔ The four acceptance conditions of the ledger transfer are met." | W-C02-14 point 13's tests: the four conditions of "Installation ledger", with the explicit hand-over mark that N18 omits, and N18. The test designer writes them after W-C02-06's design is accepted, and they merge before W-C02-14's work starts. None is written here (point 5 (e)). | W-C02-14 (points 3 to 8, 13) | Not yet writable: W-C02-06 is not accepted at `b679568` |
| A8 | 36 | "✔ A migration merged into `main` is applied by the CI job, and its effect is seen in the database." | `T-W03-05` · `tests/C02/W-C02-03/T-W03-05_apply_and_effect.md` (W-C02-03 point 5). Citation checked by `T-W07-5F` (5F-36). | W-C02-03: its producer, from the job's runs, and its checker (W-C02-03 point 13). `T-W07-5F`: W-C02-07's checker and W-C02-13's prober. | — |
| A9 | 37 | "✘ A migration merged into `main` but not applied is detected by the comparison of 6.2 (PC-16)." | `T-W03-06` · `tests/C02/W-C02-03/T-W03-06_merged_not_applied.md` (point 6) and `T-W03-DEC` · `tests/C02/W-C02-03/T-W03-DEC_decision_steps.md`, with breaks B1 to B3. "Could not check": `T-W03-07` · `tests/C02/W-C02-03/T-W03-07_could_not_check.md` (point 7, break B4). `T-W03-14` · `tests/C02/W-C02-03/T-W03-14_order_and_stop.md` (point 14, its second example). Citation: `T-W07-5F` (5F-37, 5F-37cnc). | The migration job (its SQL tests); W-C02-03's producer and checker; breaks B1 to B4 by W-C02-07's harness at W-C02-13 | — |
| A10 | 38 | "✘ The migration credential cannot be read by an agent session, nor by a workflow run for a branch other than `main`." | `T-W03-08` · `tests/C02/W-C02-03/T-W03-08_branch_refused.md` (branch runs, point 8); `T-W03-09` · `tests/C02/W-C02-03/T-W03-09_credential_search.md` (agent sessions, point 9). Citation: `T-W07-5F` (5F-38). | W-C02-03's producer, from GitHub's run records and the scheduled jobs; its checker | — |
| A11 | 39 | "✔ The C01 probe schema and its tokens no longer exist." | `T-W03-10` · `tests/C02/W-C02-03/T-W03-10_probe_absence.md` (point 10). Citation: `T-W07-5F` (5F-39). | W-C02-03's producer and checker | — |

**Point 6's checks tested elsewhere**, named here as point 6 asks:

| # | Check | Tests (ID · specification) | Run in which item |
|---|---|---|---|
| E1 | `deployment_drift` with missing, unreadable and partial input (W-C02-03 point 7, with its point 6 and point 14's second example, in form C0 as its point 12 asks) | `T-W03-07` · `tests/C02/W-C02-03/T-W03-07_could_not_check.md` (break B4); `T-W03-06` · `tests/C02/W-C02-03/T-W03-06_merged_not_applied.md`; `T-W03-14` · `tests/C02/W-C02-03/T-W03-14_order_and_stop.md` | The migration job's step; W-C02-03's producer and checker; break B4 at W-C02-13 |
| E2 | The ledger transfer's checks (the ID comparison, the link and version comparison, the write rejection) with missing, unreadable and partial input | W-C02-14 point 13's tests, written after W-C02-06's design is accepted (W-C02-14 point 10) | W-C02-14 |
| E3 | The guard's stop of strings of the two token formats, with its pattern file missing, unreadable, invalid or partial | W-C02-20 points 4 and 7: tests in form C0, written by a test designer who does not produce the change. This replaces `GROUPS.md` section 3's row, which named W-C02-11 (section 6). | W-C02-20 |
| E4 | The migration job's decision steps and its order and stop, which W-C02-03 designs beyond `deployment_drift` | `T-W03-DEC` · `tests/C02/W-C02-03/T-W03-DEC_decision_steps.md`; `T-W03-14` | W-C02-03 |

## 3. Point 6: every automatic check, scan or audit C02 builds, and its "could not check" test

Sources: W-C02-09 point 7; W-C02-10 points 3 and 4; EV-C02-002 (DM-01, DM-06, DM-08, DM-35, DM-37, DM-47); EV-C02-003 (§1.3, §1.6, §1.7, §3.2, §14, §15); `GROUPS.md` section 3; the executor's decisions. Every test below keeps "could not check" apart from "clean" and "fail", counts it in the denominator (README section 3), and shows the guarded write blocked, by an unchanged state digest or row count.

| # | Check | Designed in | Missing | Unreadable | Partial | Test (ID · specification) |
|---|---|---|---|---|---|---|
| K1 | The token derivation (header absent, empty, malformed, unknown, revoked, unreadable; refused before any other check) | EV-C02-003 §1.6, §15; W-C02-09 points 3, 7 | 6TK-mi\*, 6TK-http-missing | 6TK-hu\* | 6TK-em1-\*, 6TK-ma\* (and -http-empty, -http-malformed); unknown and revoked: 6TK-un\*, 6TK-rv1-\* | `T-W07-6TK` · `T-W07-6TK_token_reasons.md`; kept apart: 6TK-ka1, 6TK-ka2. The burst count: `T-W07-DM19B` |
| K2 | The rule gate: the global authority epoch | W-C02-09 point 7; EV-C02-002 DM-01 | 6RG-e1, 6RG-e4 | 6RG-e2 | 6RG-e3 | `T-W07-6RG` · `T-W07-6RG_rule_gate_could_not_check.md` (control 6RG-e0) |
| K3 | The rule gate: a referenced record or revision | W-C02-09 point 7 | 6RG-r1, 6RG-r2 | 6RG-r4 | 6RG-r3 | `T-W07-6RG` (control 6RG-r0) |
| K4 | The rule gate: an element of the read set | W-C02-09 point 7; EV-C02-002 DM-37 | 6RG-s1 | 6RG-s3 | 6RG-s2 | `T-W07-6RG` (control 6RG-s0) |
| K5 | Readiness: a group with an unknown member (never counted ready) | W-C02-09 point 7; B principle 6 | 6RG-g2 | 6RG-g3 | 6RG-g1 | `T-W07-6RG` (control 6RG-g0) |
| K6 | The claim's expiry, computed at `claim`, `ready_works()` and every effect | EV-C02-002 DM-06 | 6RG-l1, 6RG-l4, 6RG-l5 | 6RG-l2 | 6RG-l3 | `T-W07-6RG` (control 6RG-l0) |
| K7 | `affected_entities` and `explain_paths` at a limit, and with missing or unreadable input | W-C02-09 point 7; F04 (d); EV-C02-002 DM-35 | F04-m1, F04-m2 (a root that names no record; phase C3) | F04-u1, F04-u2 (the relation table renamed for the call; phase C3) | F04-d1, F04-d2 (the limit reached: `complete = false`); F04-c-flag (a hidden region) | `T-W07-F04`; break B-F04-3 ("could not check" folded into clean). G10 closed |
| K8 | The sample share's setting | W-C02-10 point 3; EV-C02-002 DM-08 | 6ST-share-\<f\>-missing | -unreadable | -partial | `T-W07-6ST` (6ST-counts, -clean, -fail) |
| K9 | The sample stream's hidden position, a separate stored input | EV-C02-002 DM-08 | 6ST-pos-missing | 6ST-pos-unreadable | 6ST-pos-partial | `T-W07-6ST` |
| K10 | The high-impact path list's copy | W-C02-10 point 4; EV-C02-002 DM-47, DM-48 | 6ST-path-missing, 6ST-path-op-missing | 6ST-path-unreadable | 6ST-path-partial | `T-W07-6ST` |
| K11 | The comparison of the path table with plan 6.7's list and the merge gate's classes | EV-C02-002 DM-47; W-C02-10 point 4 | DM47-st-plan-missing | DM47-st-plan-unreadable, DM47-st-rows-unreadable | DM47-st-plan-partial-no-bullet, -plan-partial-no-path, -rows-partial | `T-W07-DM47` · `T-W07-DM47_path_table.md` (DM47-st-control clean) |
| K12 | W-C02-07's scan of its test files (point 7) | W-C02-07 point 7; EV-C02-003 §1.3 | 7SCAN-m1, -m2 | 7SCAN-u1, -u2 | 7SCAN-pa1, -pa2 | `T-W07-7SCAN` · `T-W07-7SCAN_test_file_scan.md` |
| K13 | The session's own format scan | EV-C02-003 §3.2 | 6SC-fs-m1, -m2 | 6SC-fs-u1 ("never as zero") | 6SC-fs-pa1 | `T-W07-6SC` · `T-W07-6SC_scans_could_not_check.md` (a procedure; G12) |
| K14 | W-C02-12 point 9's scan of the repository, branches, issue #6 and the records | EV-C02-003 §1.7; W-C02-12 point 9 | 6SC-rs-m1, -m2 | 6SC-rs-u1, -u2 | 6SC-rs-pa1, -pa2 | `T-W07-6SC` (a procedure; G12) |
| K15 | The guard's stop of the token formats | EV-C02-003 §1.6, §1.7 | — | — | — | W-C02-20's tests (E3), not here |
| K16 | `deployment_drift` | EV-C02-001; PC-41 | — | — | — | W-C02-03's tests (E1), not here |
| K17 | The ledger transfer's checks | W-C02-06 | — | — | — | W-C02-14 point 13's tests (E2), not here |
| K18 | The pull-request checks' reading of the migration job's run record, and from step 4 their call of `deployment_drift` with the CI key | EV-C02-003 lines 367 and 1329 at `b679568`, citing EV-C02-001 point 1 (c) | — | — | — | `deployment_drift`'s (E1); what a difference or "could not check" stops is EV-C02-001's |
| K19 | The executor's count-only log check on `devos` | EV-C02-003 §14 | — | — | — | None. The executor's decision 2 of phase B: a manual procedure, not a check C02 builds; it carries its own positive control in §14 |
| K20 | The migration job's reading of the test programs' exit codes (0 pass, 1 fail, 3 could not check), with their input (N-255's four keys) and environment (`env -i` unless a program declares `# w07-needs-database: yes`) | N-255 (the executor's decision; W-C02-03's build) | — | — | — | Not tested here, by the executor's decision: W-C02-03's build checker judges the runner by running its step against stub programs (section 7, G11) |
| K22 | DM-41's trigger establishing EV-C02-008 2.2's conditions for a `sample` row (the sampling path's marker), with the Review table's check (phase C4a) | EV-C02-008 2.2 condition 2 and its fail-closed rule; W-C02-10 | S-neg-direct (a `sample` row with no marker: refused by the table's check) | S-ccc (through the hook `sample_marker_unreadable`, G21) | none yet: whether a marker can be partial depends on the form W-C02-10 chooses; the case is added with the hook (G21) | `T-W07-N28` part A2 (`w07_n28_sample_exemption.sql`); breaks B-N28-3 and B-N28-5 |
| K21 | The comparison of the class-high IDC program's embedded token pattern with `shared/scan_patterns.json` (phase C3; C1's open 5) | W-C02-07 point 7; README section 6 | 7SCAN-ec-missing (no such name in the program) | none planted: a program `ast` cannot parse gives could not check by the code | none: a tuple of strings either joins or is not read | `T-W07-7SCAN` (`7SCAN-pf5`; controls 7SCAN-ec-same, -ec-diff; break B-7SCAN-3) |

Not counted as checks C02 builds: W-C02-09 point 3's look for a token by value right after issuing (a step of `T-W07-IDC`); the network-level result in W-C02-12's sessions (an observation W-C02-12 records); X1's registration flag (C06, T-77's parts, EV-C02-002's table of later parts).

## 4. Point 8: each test, to the build item whose acceptance it serves

"Time added" is the time the test adds to W-C02-13's run, with its source and date (plan 6.12 item 1; PC-23). Each source below is the test's own specification, written on 2026-10-12. No test waits on the lease of 30 minutes (EV-C02-002 DM-07 and §4, 2026-10-12): each plants a lapse instead (README section 9). A build item's "every other test W-C02-07's record assigns to this item" (W-C02-08 point 6, W-C02-09 point 8, W-C02-10 point 7) takes the tests this table assigns to it.

| Test · specification | Group | Serves: item and point | Part needing a later item | Time added, source, date |
|---|---|---|---|---|
| `T-W07-F01` · `T-W07-F01_whole_intent.md` | A | W-C02-09 point 8 | — | None; (d)'s delay is back-dated (spec, 2026-10-12) |
| `T-W07-F05` · `T-W07-F05_scope_both_sides.md` | A | W-C02-09 point 8 | — | None (spec, 2026-10-12) |
| `T-W07-F07` · `T-W07-F07_observation_history.md` | A | W-C02-09 point 8 | Real GitHub: C08 | None; observation times given as data (spec, 2026-10-12) |
| `T-W07-F08` · `T-W07-F08_recheck_at_effect.md` | A | W-C02-09 points 3, 4 and 8 | — | None; expiry planted, the 30-minute lease not waited on (spec; EV-C02-002 DM-07, 2026-10-12) |
| `T-W07-CONC` · `T-W07-CONC_claim_and_cycle.md` | A | W-C02-09 point 8; W-C02-13 point 4 | The job must run its program (N-255; W-C02-03's build) | About 1 minute per run of the program (54 s observed on the scratch stub, PostgreSQL 16.15; the designer's self-check, 2026-10-12). Worst case about 70 minutes, if every one of the 70 runs' barriers times out at its 60-second limit. The numbers are the designer's own, with no plan reason to check against Batu's later decisions. |
| `T-W07-N17` · `T-W07-N17_claim_token.md` | A | W-C02-09 points 4 and 8 | Real-token form: W-C02-12 point 6 (`T-W07-RT`) | None; the lapse planted (spec, 2026-10-12) |
| `T-W07-5C` · `T-W07-5C_other_session_fake_id.md` | A | W-C02-09 point 8 | Real-token form: W-C02-12 point 6 (`T-W07-RT`) | None (spec, 2026-10-12) |
| `T-W07-DM07` · `T-W07-DM07_heartbeat.md` | A | W-C02-09 point 4 (point 8, assigned here) | — | None; lapse and near expiry planted. The lease length read: 30 minutes (EV-C02-002 DM-07 and §4, 2026-10-12; reasons EV-C00-012 P16, 2026-10-05; EV-C01-007 point 2, 2026-10-11; PC-38 P1, 2026-10-11; checked against Batu's later decisions in EV-C02-002 §4) |
| `T-W07-DM34` · `T-W07-DM34_mission_scope.md` | A | W-C02-09 point 8 (assigned here) | — | None (spec, 2026-10-12) |
| `T-W07-6RG` · `T-W07-6RG_rule_gate_could_not_check.md` | A | W-C02-09 point 7 (point 8, assigned here) | — | None (spec, 2026-10-12) |
| `T-W07-5F` · `T-W07-5F_migration_lines.md` | A | No build item: W-C02-07 point 5 (f); the tests it cites serve W-C02-03 | — | None (spec, 2026-10-12) |
| `T-W07-F04` · `T-W07-F04_affected_records.md` | B | W-C02-09 points 7 and 8 | — | None; seconds of computation (spec, 2026-10-12) |
| `T-W07-K05` · `T-W07-K05_many_paths.md` | B | W-C02-09 point 8 (part A) | Part B: W-C02-13, in a session of sitting B2 (W-C02-12), by the executor's decision | Part A none. Part B adds one set of calls in that session, minutes (spec, 2026-10-12), and waits on sitting B2: its time on the critical path is W-C02-12 point 3's, not this test's (spec, as phase C3 words it; G15 closed) |
| `T-W07-F06` · `T-W07-F06_state_change_event.md` | B | W-C02-09 points 5 and 8 | — | None (spec, 2026-10-12) |
| `T-W07-N09` · `T-W07-N09_finding_gate.md` | B | W-C02-09 point 8 | C04 part: C04 | None (spec, 2026-10-12) |
| `T-W07-N25` · `T-W07-N25_verdict_staleness.md` | B | W-C02-09 point 8 | C08 part: C08 | None (spec, 2026-10-12) |
| `T-W07-N28` · `T-W07-N28_verifier_does_not_repair.md` | B (parts A2 and B2: phase C4a) | W-C02-10 points 5 and 7 | The hooks W-C02-10's record fills (G21) | None; part A2 about 120 calls in one transaction (spec, 2026-10-12) |
| `T-W07-DM02` · `T-W07-DM02_revision_append_only.md` | B | W-C02-08 points 3 and 6 | — | None (spec, 2026-10-12) |
| `T-W07-DM19` · `T-W07-DM19_rejected_attempt_survives.md` | B | W-C02-09 points 3 and 5 (point 8, assigned here) | — | None (spec, 2026-10-12) |
| `T-W07-DM19B` · `T-W07-DM19B_burst_count.md` | B | W-C02-09 point 3 (point 8, assigned here) | Part B: the job must run its program (N-255) | None scheduled. Part B makes 251 HTTP calls, seconds to a minute (spec, 2026-10-12) |
| `T-W07-5A` · `T-W07-5A_no_direct_writes.md` | B | Negatives: W-C02-08 points 4 and 6. Positive (5A-pos): W-C02-09 point 8 | Part B: the job must run its program (N-255) | None (spec, 2026-10-12) |
| `T-W07-REL` · `T-W07-REL_relation_status.md` | B | W-C02-09 point 6 (point 8, assigned here; the executor's decision 1) | — | None (spec, 2026-10-12) |
| The break harness (`harness/README.md`) | B | W-C02-13 point 3; also runs W-C02-03's breaks B1 to B4 | — | About 4 to 5 s a patch for its three clusters, about 6 minutes for 85 patches, plus three applies of the build and three runs of each patch's files (B-CONC-1 and -2 about 3 minutes each); the build's apply time is unknown before the build. Phase C3's self-check, PostgreSQL 16.15, 2026-10-12 (`harness/README.md`, "Run time"; G15 closed) |
| `T-W07-N01` · `T-W07-N01_need_justification.md` | C | W-C02-10 points 2, 3 and 7 | — | None; about 90 calls in one transaction (spec, 2026-10-12) |
| `T-W07-N02` · `T-W07-N02_decision_alternatives.md` | C | W-C02-10 points 6 and 7 | N02-oe-transfer: W-C02-06's design, then W-C02-14 | None (spec, 2026-10-12) |
| `T-W07-N03` · `T-W07-N03_effort_policy.md` | C | W-C02-10 points 2, 5 and 7 | Real tokens: `T-W07-RT` (RT-cal-n4) | None (spec, 2026-10-12) |
| `T-W07-N29` · `T-W07-N29_impact_class.md` | C | W-C02-10 points 3, 4 and 7 | Constraint case: C05 | None (spec, 2026-10-12) |
| `T-W07-T31` · `T-W07-T31_planted_rate.md` | C | W-C02-10 points 3 and 7; W-C02-13 point 5 | — | None; about 120 calls in one transaction (spec, 2026-10-12) |
| `T-W07-5D` · `T-W07-5D_format_gates_empty.md` | C | W-C02-10 points 2, 3 and 7 | — | None; about 230 calls in one transaction (spec, 2026-10-12) |
| `T-W07-FGFIND` · `T-W07-FGFIND_finding_gate.md` | C | W-C02-10 points 2, 3 and 7 | — | None (spec, 2026-10-12) |
| `T-W07-DM11` · `T-W07-DM11_answer_revision.md` | C | W-C02-10 point 7 (assigned here; B 3.17's rules, EV-C02-002 DM-11) | The decision channel's cases: C06 (N-096) | None (spec, 2026-10-12) |
| `T-W07-DM47` · `T-W07-DM47_path_table.md` | C | W-C02-10 point 4 (point 7, assigned here) | The job must run its program (N-255) | None (spec, 2026-10-12) |
| `T-W07-6ST` · `T-W07-6ST_settings_could_not_check.md` | C | W-C02-10 points 3 and 4 (point 7, assigned here); W-C02-13 point 6 | — | None (spec, 2026-10-12) |
| `T-W07-IDC` · `T-W07-IDC_identity_chain.md` | D | W-C02-09 point 3 (point 8, assigned here) | Its real-path program: the job must run it (N-255) | None; part A in seconds, timeout 120 s (spec, 2026-10-12) |
| `T-W07-6TK` · `T-W07-6TK_token_reasons.md` | D | W-C02-09 points 3 and 7 (point 8, assigned here) | Its HTTP program: the job must run it (N-255) | None (spec, 2026-10-12) |
| `T-W07-5B` · `T-W07-5B_authorization_matrix.md` | D | W-C02-09 point 8 (role lists); W-C02-10 point 5 (separation lines) | The four rows whose readers W-C02-09 names (R10r, R12 to R14; EV-C02-008 1.4) | None (spec, 2026-10-12) |
| `T-W07-ROC` · `T-W07-ROC_ownership_and_claim_class.md` | D | W-C02-09 point 8 (the checks after the gate of the rows EV-C02-008 decides); W-C02-10 point 5 (separation) | The hooks W-C02-09's record fills (G21) | None; about 90 calls in one transaction (spec, phase C4a, 2026-10-12) |
| `T-W07-N04` · `T-W07-N04_self_approval.md` | D | W-C02-10 points 5 and 7 | Part T: W-C02-14 (point 13), after W-C02-06's design. Real tokens: W-C02-12 (`T-W07-RT`) | None (spec, 2026-10-12) |
| `T-W07-N08` · `T-W07-N08_exam_records.md` | D | W-C02-10 point 5 (point 7) | Real tokens: W-C02-12 point 5 (`T-W07-RT`) | None (spec, 2026-10-12) |
| `T-W07-RT` · `T-W07-RT_real_token_runs.md` | D | W-C02-12 points 4 to 7 | — | None to W-C02-13's own run, which counts these runs only on a matching envelope. The runs wait on Batu's steps 2 to 5; their time on the critical path is W-C02-12 point 3's, not this test's (spec, as phase C3 words it; G15 closed) |
| `T-W07-7SCAN` · `T-W07-7SCAN_test_file_scan.md` | D | No build item: W-C02-07 point 7 | — | None; about one second, before W-C02-07's checker verdict (spec, 2026-10-12) |
| `T-W07-6SC` · `T-W07-6SC_scans_could_not_check.md` | D | W-C02-12 point 9 | — | None (spec, 2026-10-12) |
| N18 and the transfer checks' tests | — | W-C02-14 point 13 | Not written: W-C02-06's design first | Stated when written |

Counts: 41 tests and the harness, mapped.
- 22 tests serve W-C02-09, and 5A's positive control does too.
- 15 serve W-C02-10. `T-W07-5B` and `T-W07-ROC` are among them and serve both items.
- 2 serve W-C02-08 (`T-W07-DM02`, and `T-W07-5A`'s negatives).
- 2 serve W-C02-12 (`T-W07-RT`, `T-W07-6SC`).
- 2 serve no build item (`T-W07-5F`, `T-W07-7SCAN`). Parts go to W-C02-12 (the real-token forms of N04, N08, N17, 5C and N03), to W-C02-13 in sitting B2 (K05 part B) and to W-C02-14 (N04 part T, N02-oe-transfer). One test adds measurable time to W-C02-13's run: CONC, about 1 minute, at worst about 70.

## 5. Point 4: format gates, the sample, T-31 and the open-exploration rule

**"Filled but meaningless" examples.** The database must accept each one, and the share must land it, one per complete block of ten, as a `Review` of kind `sample` queued for `devos_denetim`.

| Gate | Test | Kind 1 | Kind 2 | Cases |
|---|---|---|---|---|
| Need `why_needed` (N01) | `T-W07-N01`; `T-W07-5D` | `-` | a circular justification | N01-fbm1, N01-fbm2; 5D-fbm-need-1, -2 |
| Decision, `high_impact` and `batu`, at `open` (N02) | `T-W07-N02`; `T-W07-5D` | every gated list `x`, `reversibility` `x` | a circular single-path reason | N02-fbm1, N02-fbm2; 5D-fbm-dec-1, -2 (class `batu`) |
| EffortPolicy (N03) | `T-W07-N03`; `T-W07-5D` | `expert_assessment_ref` = `n/a` | an assessment unrelated to the item | N03-fbm1, N03-fbm2; 5D-fbm-eff-1, -2 |
| Finding (kept in C02: EV-C02-002 DM-30) | `T-W07-FGFIND`; `T-W07-5D` | `counter_evidence_searched` = `-` | `changeable = false` declared on a time-bound claim, with "none found" | FGFIND-fbm1, FGFIND-fbm2; 5D-fbm-find-1, -2 |
| N-032's structural gate | none | — | — | Moved to C03: W-C02-04 did not keep it in C02 (EV-C02-002 §3 row 2.12 and §7; N-211) |
| The routine sample (not a format gate) | `T-W07-N29` | a routine item that declares only a trigger | a routine decision that declares a schema change | N29-sample-work, N29-sample-decision |

**N-074 T-31's numbers** (`T-W07-T31`, section "Written before any run"):
- **Planted:** 80 records. Each of the four format-gated streams (Need; a `high_impact` Decision at `open`; EffortPolicy; Finding) gets two complete blocks of 10, every record filled but meaningless, the two kinds by turns.
- **Share:** one in every block of 10, W-C02-04's recorded share (EV-C02-002 DM-08). It is read from the database and checked (T31-share-\*), and the run does not change it.
- **Rate:** 2 of 20 per stream, 8 of 80 overall, one in every complete block: 0.1 (T31-need, T31-decision, T31-effort_policy, T31-finding, T31-total).
- **Tolerance:** 0 records.
- **Reason for both:** DM-08 samples exactly one record per complete block, at a position drawn when the block opens. The run starts each stream at a block boundary and plants only complete blocks in which every record is planted, so exactly one planted record per block is sampled, wherever the position falls. A random draw per record would need a tolerance; DM-08 does not.
- **"Caught"** means the record reaches the audit environment's queue as a `sample` Review. Whether the audit environment recognises it as meaningless is C03's and later.

**N01's "matches the rate".** N01-rate plants three complete blocks of 30 complete needs. Exactly one sample per block is expected: 3 of 30, tolerance 0. The reason is the same, DM-08's "the test needs no tolerance". N01-writer shows that writer-chosen keys do not steer the sample.

**The open-exploration rule** (Appendix B 3.17; CHK-C00-035 item 3). C02's `devos_api` builds no `answer_decision`: it is C06's (B:390), and W-C02-04 did not bring it forward. The decision's state rule (EV-C02-002 DM-46) is tested on the state itself: N02-oe-answer-\*, N02-oe-accept-\*, N02-oe-pos-reason-\* and N02-oe-pos-options. C02 has one transition that answers decisions, the ledger transfer, which writes answered decisions (EV-C02-002 DM-11). Its case, N02-oe-transfer, is `could_not_check` until W-C02-06's design names the transfer's function (the executor's decision 5). The `answer_decision` case moves to C06 with it. Point 4 asks for a carrier note on `plan/work/C06.md`, named in the record. There is none at `b679568`. Writing it is the executor's record write, not a test file (`GROUPS.md` section 5; G6).

**T-31's other parts that name C02.** Criterion 12 goes to C10 and criterion 14 to C06 (PC-08; `plan/work/C02.md` line 41). F12 (c)'s green-but-wrong completed work, with the silent-failure sampling, goes to C10 (PC-08). `T-W07-T31`'s clause table names each.

## 6. The executor's decisions that change a mapping

1. **K05 part B** (a real session's run) is run by W-C02-13 in a session of sitting B2 (W-C02-12). It is `could_not_check` until then, and K05's real-session clause (Ek_C:152) is not met before that run. The specification still says "W-C02-12's acceptance does not list this run, so the executor assigns it"; this decision is that assignment. W-C02-13 point 1 ("Every test W-C02-07's record lists was run") takes it through this record.
2. **The stop of the token formats** belongs to W-C02-20 (`plan/work/W-C02-20.md`, points 2, 4 and 7), not W-C02-11. It replaces `GROUPS.md` section 3's row naming W-C02-11 (E3, K15).
3. **The ten functions with no role-class row** (N-256 on `plan/work/C02.md`). Decided in EV-C02-008 section 1.2, merged and accepted (PR #300; CHK-C02-025), with R15's function named (1.4) and the rows of `operation_state`, the ledger transfer and `set_effort_policy` at the gate (1.7.2 to 1.7.4); phase C4a revised the tests' assumed lists before any result (README section 8): `T-W07-5B`'s rows R08g, R15, R20 to R26, `T-W07-ROC` for Rules O and C (1.7.1). Four rows still wait for the build to name their functions (R10r, R12 to R14; EV-C02-008 1.4).
8. **G19, a stated residual** (phase C4a, the executor's call): Concurrency's committed fixtures stay out of `devos` because W-C02-03's job runs the programs only in its `devos-test` job, which W-C02-03's build verdict checks; nothing is added to the programs' input (README 5.1 (b)).
4. **Phase B's decisions that change a mapping:**
   - (1) Relation's rule is `T-W07-REL`, serving W-C02-09 point 6.
   - (2) The executor's log check is not tested here (K19).
   - (3) The programs the migration job runs sit under `supabase/migrations/tests/` and are given their tokens by the job (N-255).
   - (4) A clause an accepted design changed is tested in the design's form.
   - (5) N04 part T and N02-oe-transfer are `could_not_check` until W-C02-06's design is accepted.
   - (6) N08's scope follows EV-C02-003 §4.5 and PC-43 place 10.
   - (7) The harness's PostgreSQL version differs from the projects', and that is stated as a limit.

## 7. Gaps found

Each gap names the point it touches. Phase C2 closed none. Phase C3, a test designer's change before any result (README section 8), closed those that are test work and marks each **Closed** with what closed it; the others stay as phase C2 wrote them, for the executor's record write or decision.

**Clauses without a case, and nothing that moves them (point 2):**
- **G1 (point 2; F01). Closed in phase C3:** F01-t1 (another effect class: refused) and F01-t2 (another idempotency namespace: never answered from key 1's record; either reading of the namespace allowed), with B-F01-4 and B-F01-5 (F01-r1). Self-checked on a scratch stub.
- **G2 (point 2; F01). Closed in phase C3:** F01-g plants the stored epoch one lower (no call changes the epoch alone, B 3.5), with B-F01-6 (F01-r7). Self-checked on a scratch stub.
- **G3 (point 2; F08; W-C02-09 point 4). Closed in phase C3:** F08-g1 (a released claim's token), F08-g2 (the earlier generation's token after the work item is claimed again) and F08-pos6; breaks B-F08-2 (now also F08-g1) and B-F08-3 (F08-c1, -g1, -g2) (F08-r3b). Self-checked on a scratch stub.
- **G4 (point 2; F08). Closed in phase C3:** F08-w (the work item revised after its claim; the effect refused) and F08-pos7, with B-F08-4 (F08-r1). If the build ends a claim when its work item is revised, F08-w's refusal comes from the claim and B-F08-4 is revised before the run. Self-checked on a scratch stub.
- **G5 (point 2; F06). Closed in part in phase C3:** recipes for every state-changing C02 function README 8.1 lets the file form, `claim` and `revoke_claim` among them; the rest are listed in the specification and in each case's detail (G20). The phase C3 recipes ran on no stub of their functions.

**Records and moves (point 4):**
- **G6 (point 4; N02).** The carrier note on `plan/work/C06.md` for the open-exploration case of `answer_decision` is absent at `b679568`, and point 4 asks the record to name it.

**Cases written but unable to run yet (points 2, 5 and 8):**
- **G7 (points 2 and 5 (b); 5B). Closed in part in phase C4a:** the ten functions N-256 names have rows (EV-C02-008 1.2), and R15's function is named (1.4). The four rows whose readers the build names (R10r, R12 to R14) give `could_not_check` until it names them; `5B-row-R14` until it names R14's function or moves the row to C03 with its reason (section 6, item 3).
- **G8 (points 2 and 8; N02, N04).** N02-oe-transfer and N04 part T are `could_not_check` until W-C02-06's design is accepted. So W-C02-10 point 7's N02 line is unmet until then (Group C's report, Open 4). N04 part T is counted by W-C02-14, whose acceptance names "its tests" (point 13) but not these two cases by name.
- **G9 (point 2; K05).** Part B stays `could_not_check` until W-C02-13's run in sitting B2. Neither W-C02-12's nor W-C02-13's acceptance names it; this record assigns it (section 6, item 1).

**Checks (point 6):**
- **G10 (point 6; F04). Closed in phase C3:** F04-m1 and F04-m2 (a root that names no record) and F04-u1 and F04-u2 (the relation table unreadable), each wanting the "could not check" answer, with B-F04-3 (K7). Self-checked on a scratch stub extended to answer so.
- **G11 (point 6; N-255).** No test here shows that the migration job counts a program's exit 3 as "could not check", never as a pass. W-C02-03's merged tests predate N-255, and W-C02-07's programs only define their own exit codes. The executor's decision (phase C3's task, point 7): W-C02-03's build checker judges the runner by running its step against stub programs, so no test is written here (K20). That judgement also covers the job's input object and its `env -i` unless the declaration.
- **G12 (point 6; 6SC).** `T-W07-6SC` is a specification run by a procedure, with no program, because none was assigned (Group D's report, Open 4). Whether the two scans become programs is the executor's call.

**Readings and stale text the checker should see (points 2, 5 and 8):**
- **G13 (point 5 (c); 5C).** `T-W07-5C` reads "with a fake session ID, is rejected" in EV-C02-003 §4.4's form: a fake declared session ID changes nothing, and the claim token decides. So 5C-pos2 (the right claim token with a fake ID) is accepted, and the refusals 5C-n2, -n3 and -n5 come from the missing or foreign claim. This follows B principle 8 and W-C02-09 point 3. W-C02-09 point 4 and C02's acceptance line (line 32) word it as a rejection.
- **G14 (point 5 (f); 5F). Closed in phase C3:** `T-W07-5F`'s "Interface assumed", "Examples", "Positive control", clause table and "Could not check" now say that W-C02-03's tests are on `main` (merged at `ceb206b`, an ancestor of `11feac5`, where every cited path is present).
- **G15 (point 8; PC-23). Closed in phase C3, as far as this item can:** `T-W07-RT` and K05 part B say that their time on the critical path is W-C02-12 point 3's (still unstated there: W-C02-12 is `planned`); the harness's run time is measured by a self-check and stated with its date (section 4).
- **G16 (point 2; N08).** "and scores" is moved to C05 on the specification's reading. Appendix C names C05 as a stage of N08 without saying which part is C05's.
- **G17 (point 2; self-checks, not results).** B-CONC-2's red set was not shown in the designer's self-check, and F07 and DM07 were not rerun after their last fix (Group A's report, Open 3 and 4). W-C02-13 shows the breaks; the checker may want these before the merge.
- **G17, a phase C3 note.** Phase C3 reran B-F01-1 to -3 and B-F08-1 and -2 on a scratch stub with the new cases present: their red sets are as named (B-F08-2 now with F08-g1). F07's and DM07's breaks were not rerun.
- **G18 (points 2 and 4; N28 and the sample). Closed in phase C4a:** EV-C02-008 section 2 and PC-46 (merged and accepted; CHK-C02-026) state the exemption, its bounds and the rule about taking; `T-W07-N28` parts A2 and B2 test them, with breaks B-N28-2 to -5 (B-S1 to B-S4).

**Found in phase C3 (reported for the checker and the executor):**
- **G19 (point 7; CONC). A stated residual, by the executor's call (phase C4a):** N-255's decided input form names no target, so Concurrency, which commits fixtures, no longer reads `devos-test` from its input. That it never runs in `devos` rests on W-C02-03's migration job running the programs only in its `devos-test` job; W-C02-03's build verdict checks it. Nothing is added to the input; README 5.1 (b) says so. The program still tells the harness's database apart by `w07.throwaway`.
- **G20 (point 2; F06, and G8).** F06 cannot pass until the ledger transfer's fourteen functions, `mark_exported` and `link_prior_decisions` have recipes, and `deployment_drift`'s event case is the Data API's. W-C02-06's design is accepted at `11feac5` (PC-44), so N02-oe-transfer's and N04 part T's wait (G8) is now on the transfer's payload names (W-C02-09) and W-C02-14 point 13's tests, not on the design.

**Found in phase C4a (reported for the checker and the executor):**
- **G21 (points 2, 3 and 6; ROC, N03, N28).** Four states the design leaves to the build's form are planted through owner-level hooks in the test files, empty until the build's records name them: `installation_mission` (`T-W07-ROC`, `T-W07-N03`; the Mission Rule O treats as the installation's, CHK-C02-025 F5, W-C02-09's record), `transferred_relation` (`T-W07-ROC`; W-C02-09's record), `sample_marker_unreadable` and `take_sample` (`T-W07-N28` parts A2 and B2; EV-C02-008 2.2 condition 2's marker and the taking's form, W-C02-10's record). Until each is filled, the cases that need it give `could_not_check` (the `inst` kind's 19 Rule O cases, the three transferred-relation cases, `N03-pos-default-kurulum`, `S-ccc`, `S-neg-take-fields`), so the tests cannot PASS, and B-N28-5 cannot be shown. The test designer fills them before the first result (README section 8); the build items' records name the forms. K22's partial input waits on the same marker form.
- **G22 (point 2; ROC).** `T-W07-ROC`'s Rule C cases with an audit claim need `devos_denetim` to claim a working item; its claim row's "its review work" is C03's design (EV-C02-008 1.7.5 (a)). If the build refuses that claim, those six cases stay `could_not_check` in C02, and the record says Rule C's cross-class refusals rest on no run until C03.
- **Phase C4b (not done here):** everything EV-C02-008 section 5 changes (N-262, the exam fact through DM-35's reads; N-263, the sample's position after the draw): `T-W07-F04` including F04-c-noleak, `T-W07-N08`, the EXF pairs, N01's unseen cases, `T-W07-T31`, `T-W07-N29`.

**Outside this file, reported only:** the groups' names for shared objects differ (for example the event table's name, the epoch table, the refusal form). Aligning them is phase C1's work. It changes no mapping above, since case IDs are stable.
