# C02 source map R2: Appendix C

## Disciplines (D1–D9)
D1: yes: Five F-entries have no stage line of their own, so I marked their C02 stage as an inference from the C1 heading and kept it apart from the stage text that is explicit.
D2: no
D3: yes: Besides listing the C02 tests, I checked every C02 acceptance condition against them (section 5b), so the work list's coverage is served and not only the test list.
D4: yes: For each test I recorded whether its break attempt and its negative control are actually specified, and I flagged the C0 fields that the specification leaves empty.
D5: yes: I read Appendix C in full, plus the C02/C03 plan text, the Appendix B parts the tests use and the relevant PC-08/PC-16 places at their sources instead of trusting the task's line pointers, and I cite path:line for each claim.
D6: no
D7: no
D8: yes: Before reading I confirmed the tree is clean with HEAD = origin/main = 796c427, and I read `plan/work/C02.md`'s open notes because some of them change these tests (N-131, N-136).
D9: no

**Question and decision served:** Which Appendix C tests are C02's, what each needs (C02 task 0–8, Appendix B part, environment), and where the sources leave gaps. This feeds W-C02-01's mapping of tests onto items. All paths are under `/home/user/devos/`.

## 1. Tests whose stage is C02 (or that name C02)

Every test below runs under task 6 ("The tests in Appendix C on real PostgreSQL; concurrency tests", `plan/DevOS_Kurulum_Plani.md:1003`). Under "Tasks" I list the build tasks each one depends on. "Inherits C02" means the entry has no stage line and sits under "## C1. F01–F08: database tests at the failure-class level (C02)" (`plan/Ek_C_Testler.md:30`). That reading is an **inference**.

**F01: whole-intent idempotency.** Stage: inherits C02. PC-08 place 80 says "Stages: C02" (`plan/decisions/PC-08.md:1938`).
- **Claim:** a key is bound to the operation's whole intent. This is derived from the class rule; F-entries have no claim line.
- **Class rule** (`Ek_C:35`): type, target, expected base, content, work item, claim generation, authority epoch. The grant revision joins only once Grant is active, and Grant is deferred (`Ek_B:65`).
- **Examples** (a)–(d) (`Ek_C:36`). **Negative** (`:37`). **Positive** (`:38`). **Break:** drop one intent field from the comparison and its example must start to pass (`:39`).
- **Tasks:** 1, 2 (`prepare_operation`), 3 (generation, epoch).
- **Appendix B:** 3.12 Operation fields and rule (`Ek_B:244,249`); 3.5 generation (`:150`); principle 9 (`:23`); activation (`:64,75`).

**F04: affected-records explosion.** Stage: inherits C02.
- **Class rule** (`Ek_C:64`). **Examples** (a)–(d) (`:65`). **Negative**: row count ≤ record count, no false "nothing else", no leak of a hidden node's name (`:66`). **Positive** (`:67`). **Break:** remove deduplication and (a) explodes (`:68`).
- **Tasks:** 1, 2, 4 (visibility for (c)).
- **Appendix B:** 3.4 Relation (`Ek_B:136-146`); `affected_entities`/`explain_paths` with completeness (`:374`); the privacy filter does not leak existence (`:432`); the continuation is tied to its snapshot (`:431`); activation (`:63`).

**F05: one-sided scope check.** Stage: inherits C02.
- **Class rule** (`Ek_C:73`). **Examples** (a)–(d), with (d) being a second function path (`:74`). **Negative**: all rejected (`:75`). **Positive** (`:76`). **Break:** remove the target-scope check and (a) passes (`:77`).
- **Tasks:** 1, 2.
- **Appendix B:** principle 4 (`Ek_B:18`); `Work.scope` (`:117`); Artifact (`:217`); activation (`:62,72`). See gap 5d-1.

**F06: every state change produces an event.** Stage: inherits C02. PC-08 place 84 says "Stages: C02" (`PC-08:2043`).
- **Class rule** (`Ek_C:82`). **Examples:** every state-changing function, with the list "extracted automatically from `devos_api`" (`:83`). **Negative**, including an event whose `role_class` does not come from the token, and no orphan event on a mid-transaction error (`:84`). **Positive:** an exact repeat creates no event and raises no error (`:85`). **Break** (`:86`).
- **Tasks:** 2 (core: "every transition produces an event in the same transaction", `plan:999`), 3 (`role_class` from the token), 1.
- **Appendix B:** principle 2 (`Ek_B:16`); 3.13 Event (`:255`); activation (`:76`).

**F07: overwritten observation history.** Stage: "Stage: C02 and C08 (with real GitHub)." (`Ek_C:95`)
- **Class rule** (`:91`). **Examples** (a)–(c) (`:92`). **Negative** (`:93`). **Positive:** the current-state question is answered correctly (`:94`). **Break:** allow updates on the observation table, and the test on (a) must fail (`:95`).
- **Tasks:** 1, 2 (`record_observation`), 4.
- **Appendix B:** 3.12 Observation and the append rule (`Ek_B:246,251`); `WorkStanding.effect` (`:126`); activation (`:75`).

**F08: re-check at the moment of effect.** Stage: inherits C02. PC-08 places 85–86 say "Stages: C02" (`PC-08:2065,2087`).
- **Class rule**: the mandatory read set is decided on the server by operation type (`Ek_C:100`). **Examples** (a)–(d), where (c) is claim revocation or expiry, or an epoch change (`:101`). **Negative** (`:102`). **Positive** (`:103`). **Break:** remove the re-check and (a) passes (`:104`).
- **Tasks:** 1, 2, 3.
- **Appendix B:** 3.12 rule (`Ek_B:250`); 3.5 (`:155`); 3.4 hard dependencies (`:143`); activation (`:62,63,75`).

**Concurrency.** Stage: "### Concurrency (C02)" (`Ek_C:106`).
- **Claim:** of several connections, only one claims the work item, and two opposing hard dependencies added at once form no cycle (`:108`). That is two claims in one entry.
- **Method:** many concurrent connections on real PostgreSQL, repeated runs (`:109`). **Positive:** one claim always succeeds (`:110`).
- No class rule, no examples, no explicit negative and no break are given.
- **Tasks:** 1, 2, 6. Appendix B section 8 says the "Concurrency control" choice is made with these tests (`Ek_B:442`).
- **Appendix B:** 3.5 uniqueness (`:153`); 3.4 cycle rejection (`:143`); activation (`:62,64`).

**N01: format gate on Need.** Stage "C02" (`Ek_C:118`).
- **Negative:**
  - an empty `why_needed` is rejected;
  - a meaningless one is accepted and reaches the audit queue as a `Review` of kind `sample`;
  - the sampled share matches the set rate;
  - a sample review written with the working token is rejected.
- **Positive:** a justified need is accepted.
- **Tasks:** 1, 2 (`record_need`), 3/7 (working token), 4, 5.
- **Appendix B:** 3.2 (`Ek_B:108,111`); principle 12 (`:26`); 3.11 sample rule (`:240`); activation (`:60,74`).

**N02: alternatives gate on Decision.** Stage "C02" (`Ek_C:119`).
- **Negative:** no options, no single-path reason and no open-exploration state → rejected; a major design decision without premises → rejected.
- **Positive:** a single viable path with its reason is accepted; no invented second option is required.
- **Break:** plan K-3 Testing gives one ("when the rule is deliberately removed, the test fails", `plan:317`).
- **Tasks:** 1, 2 (`open_decision`), 5.
- **Appendix B:** 3.17 gate (`Ek_B:290`); 3.26 premises rule (`:354`); activation (`:83`).

**N03: effort policy.** Stage "C02" (`Ek_C:120`).
- **Negative:** five cases, including a standing policy written with the working token, a reduction that cites a retired policy, and a reduction beyond what the policy allows without the item's own audit approval.
- **Positive:** two cases.
- **Tasks:** 1, 2 (`set_effort_policy`), 3/7 (working and audit tokens), 4, 5.
- **Appendix B:** 3.18 (`Ek_B:297,299`); activation (`:84`).

**N04: no self-approval, at environment level.** Stage "C02, C05, C10" (`Ek_C:121`). The C02 part is marked "(C02)" in the row.
- **Negative:** a binding verdict or an acceptance written with the working token is rejected; so are a fake role name and a fake session ID used with the same token.
- **Positive:** the audit environment's record is accepted.
- **Tasks:** 3, 4, 5, 7.
- **Appendix B:** principle 8 (`Ek_B:22`); 3.11 (`:237`); 3.27 (`:358`); activation, where EnvToken's first need is "C02 tasks 3 and 7; N04" (`:96`).
- Note N-136 adds runs with the `devos_kurulum` token (`plan/work/C02.md:87`).

**N09: undated or secondary-only finding.** Stage "C02, C04" (`Ek_C:126`).
- **Negative:** such a finding cannot become `accepted_for_use`. **Positive:** a dated finding with a primary source can.
- **Tasks:** 1, 2 (`record_finding`, `review_finding`).
- **Appendix B:** 3.8 Finding fields and rule (`Ek_B:191,194`); function check (`:376`); activation (`:87`).

**N17: no effect without a claim token.** Stage "C02" (`Ek_C:134`).
- **Negative:** another session's claim, or no token. **Positive:** the right token.
- **Tasks:** 1, 2, 3.
- **Appendix B:** 3.5 (`Ek_B:150-155`); principle 8; activation (`:62,64`).
- N-136 adds a claim used with another role class's token, and a claim without registration (`C02.md:87`).

**N18: ledger transfer.** Stage "C02" (`Ek_C:135`).
- **Negative:** no duplicates on a re-run; an interrupted transfer resumes; a write to `ledger.md` after the transfer is rejected by the check. **Positive:** links and versions match.
- **Task:** 8, mapping work items→Work, decisions→Decision, log entries→Event, verdicts→Review/Verdict and findings→Finding (`plan:1005`); the four conditions are at `plan:870`.
- **Appendix B:** 3.3, 3.8, 3.11, 3.13, 3.17.

**N25: a verdict goes stale.** Stage "C02, C08" (`Ek_C:142`).
- **Negative:** when `basis_refs`, the criterion or the use changes, the old verdict cannot be used for acceptance. **Positive:** an unchanged basis keeps the verdict valid.
- **Tasks:** 1, 2 (`open_review`, `record_verdict`, `accept`), 3/7 (audit token).
- **Appendix B:** 3.11 (`Ek_B:225,238`); activation (`:74`).

**N28: the verifier does not repair.** Stage "C02" (`Ek_C:145`).
- **Negative:** a new target revision in the same transaction as the review is rejected. **Positive:** the repair opens as a separate work item.
- **Tasks:** 1, 2, 4.
- **Appendix B:** 3.11 (`Ek_B:239`); Artifact revision (`:217`); activation (`:72,74`).

**N29: impact class by rule.** Stage "C02, C05 (the Constraint case)" (`Ek_C:146`).
- **Negative (C02):**
  - a routine item whose target is on the high-impact path list, or that prepares an irreversible effect;
  - a routine decision on a high-impact item;
  - a decision below `batu` that opens or widens a Mission;
  - a routine item that only a declared trigger makes high-impact, planted in a run, must reach the audit environment through the sample.
- **Positive:** a routine item with no trigger runs without extra gates.
- **Tasks:** 1, 2, 5 ("impact-class rules with their sample of items labelled routine", `plan:1002`).
- **Appendix B:** 3.3 rule (`Ek_B:134`); 3.17 class (`:293`); 3.11 sample (`:240`).

**K05: small graph, many paths.** Stage "C02" (`Ek_C:160`).
- **Success condition:** "The F04 class test, and the row count not exceeding the record count in the real query". C3 entries are also tested "with real sessions", with the success condition written in advance (`Ek_C:152`).
- **Tasks:** 1, 2.
- **Appendix B:** 3.4 and section 4 (`Ek_B:374`).

**Not C02, checked:** N05–N08, N10–N16, N19–N24, N26, N27, K01–K04, K06–K13 and C4/C5 all carry other stages (`Ek_C:122-144,156-168,172-189`).

## 2. Tests that name C02 with a later stage

| Test | C02 part | Later part |
|---|---|---|
| F07 | Append-only observations and the current-state answer, in the database ((a), (b); (c) as a synthetic sequence, **inference**) | C08: (c) against real GitHub (`Ek_C:95`); C08 acceptance "✔ The intent and observation records are consistent" (`plan:1089`) |
| N04 | Binding verdict or acceptance with the working token, plus the fake role name and session ID (`Ek_C:121`) | C05: version activation in the release form C05 decides (`Ek_C:121`; `Ek_B:265`; `plan:1046`). C10: the row does not say. **Inference:** C10's "✘ The working environment cannot approve its own change" for method changes (`plan:1105`; `Ek_B:265`). PC-08's reason explains only C02 and C05 (`PC-08:2151`) |
| N09 | The Finding gate. Finding is active in C02 (`Ek_B:87`) | C04: the row does not split it. **Inference:** "primary/secondary" judged with the Source records (`source_type`, `authority_status`) built in C04 (`Ek_B:69,183,187`) |
| N25 | The database staleness rule (`Ek_B:238`) | C08: the row does not split it. **Inference:** a verdict tied to the head commit at merge (`plan:1089`; N23 `Ek_C:140`) |
| N29 | All cases except the Constraint case | C05: "one below `batu` that changes a Constraint" (`Ek_C:146`; `PC-08:2525-2528`; `Ek_B:293`) |

Under the C1 "(C02)" heading but not C02: F02 → C04 (`Ek_C:50`) and F03 → C09 (`Ek_C:59`). PC-08 says F03 "cannot run in C02" (`PC-08:732`).

**Not C02-stage, but C02 builds their records "for C03"** (plan "what C03 needs at its start", `plan:998`; `Ek_B:55`):
- N06 and C03 test 6 need LeakFingerprint (`Ek_B:89`).
- N08 needs EvalRun's access rule (`Ek_B:78`; N-136 adds a `devos_kurulum` run, `C02.md:87`).
- N26 and C03 test 8 need `mark_exported` and `devos_backup` (`Ek_B:98,390`).
- K06 and C03 test 1 need every role class, including `devos_ci` (`Ek_B:98`).

## 3. F02

- **What PC-08 moves:**
  - F02 now applies to the subagent task definition (`Ek_C:44`; `Ek_B:174`), whose stage is C04: "Stage: C04, when the task definition record is built." (`Ek_C:50`).
  - C02's acceptance excludes it (`plan:1007`; `PC-08:729-734`, reason: "F02 moves with its rule to C04, where the record it now tests is built").
  - C04 task 4 builds the record and its mandatory-needs check (`plan:1029`).
  - C04's acceptance carries F02's structural negative (`PC-08:795`).
  - The semantic case (c) is tested in C04 and C05 with K04 (`Ek_C:47`). Place 81 lists stages C04 and C05 (`PC-08:1977`).
  - TaskDefinition is activated in C04, with F02 as its first need (`Ek_B:66`).
- **What remains in C02:**
  - No F02 test part.
  - **One build question (inference):** `Work.mandatory_needs`, "revised only with a new work revision" (`Ek_B:117`), is a field of Work, and Work is activated in C02 (`Ek_B:62`). PC-08 place 49 lists stages "C02, C04" (`PC-08:1164`). F02's (d) relies on it, but no C02 test exercises it. Under `plan:848`, building it with Work in C02 or adding it in C04 is the work list's choice.
- **Stale text:** C02's summary row still says "F01–F08 regressions" (`plan:895`), and the C1 heading still says "(C02)" (`Ek_C:30`). Both ignore F02 → C04 and F03 → C09.

## 4. What the tests need from the environment

- **Real PostgreSQL:** all of them (`Ek_C:3`; `plan:1003`); Concurrency explicitly needs "many concurrent connections" (`Ek_C:109`).
- **Which Supabase project:** task 1 says "first in the test project" (`plan:998`), which is `devos-test` (`plan:630`).
  - Migrations reach both `devos-test` and `devos` on every merge to `main`, and the builder's connection is read-only (`plan:631`).
  - **Inference:** N18 targets the live `devos` at C02's end (`plan:870`). For K05, "the real query" does not name a project.
- **Real environment tokens:**
  - Tied to real tokens by the sources: N04 (`Ek_B:96`) and acceptance "each environment's real token" (`plan:1007`).
  - Needing a working or audit token: N01, N03, N25 and N28 (the audit role writes reviews, `Ek_B:237`), and N29's audit queue.
  - Needing claim tokens: N17, F01, F05, F08, Concurrency.
  - Needing `role_class` from the token: F06.
  - Batu issues the tokens in task 7 (`plan:1230`, `plan:648`).
  - **Gap:** the sources do not say which project the tokens are issued for. N-136 sets them on "the live project's host" (`C02.md:87`).
  - **Inference:** if the token is a network secret that sessions cannot read (`C02.md:81-82`), then each real-token test must run from a session in that environment, including an audit-environment session for N04's positive.
- **Concurrency:** the Concurrency test (`Ek_C:106-110`). Not concurrency but related: N18's interrupted transfer and N01's rate need volume and repeats.
- **GitHub:** in C02, only N18's "rejected in the check" (`Ek_C:135`; `plan:870`, "rejected by the checks"). F07 and N25's GitHub parts are in C08. **Inference:** every break attempt that redeploys a function goes through merge → CI (`plan:631`); see gap 5d-9.
- **Batu (inference from `Ek_B:46`):** F08 (c)'s epoch change needs `revoke_env_token`, which only the project owner can run.
- **Order the sources imply (inference; the executor decides):**
  1. Task 0.
  2. Tasks 1, 2, 4 and 5 in `devos-test`.
  3. Task 3, with the token design (N-131/N-136).
  4. The database-only tests (F01, F04, F05, F06, F07, F08, Concurrency, N02, N09, N28, K05).
  5. Task 7 and Batu's tokens, then N01's token case, N03, N04, N17, N25, N29's audit-queue case, and acceptance's real-token and claim negatives.
  6. N18 last, on `devos` with the GitHub check.

## 5. Contradictions and gaps

**a. Stage text.**
- `plan:895` and `Ek_C:30` list F02 and F03 under C02 (section 3).
- `Ek_B:59` says Mission's "own rule is first tested in C10", yet N29 (C02) tests that a decision below `batu` cannot open a Mission (`Ek_C:146`; `Ek_B:104,293`). This is a near-duplicate rule; **interpretation**.

**b. C02 acceptance conditions (`plan:1007`) that no C02-stage Appendix C test covers.**
- "✘ No role can write directly to the tables": no test. `Ek_B:47` points to "the authorization tests in Appendix C", but none is so named. C03 test 1 and K06 are C03.
- "each environment's real token": only the working→audit direction is tested (N01, N03, N04). Audit→product writes and exam→verdict/product writes (`Ek_B:37-38`) have no C02 test.
- "fake session ID" on a claim-bearing operation: N17 omits it, and N04 covers it only for verdicts.
- "filled but meaningless": N02 and N03 lack the example that `Ek_C:26` requires of every format-gate test. Both gates are labelled format gates (`Ek_B:290,299`).
- Finding's mandatory `counter_evidence_searched` (`Ek_B:191`) has no test. **Inference:** it is a format gate.
- The migration items (applied, unapplied detected, credential unreadable, probe schema gone): no Appendix C test.
- Plan Section 8 item 14 (could not check, `plan:843`) applies "C02 onward" (`PC-16:173`). No C02 test feeds missing or partial input to `deployment_drift` (`Ek_B:387`) or to the `ledger.md` check.

**c. C0 fields that the specification leaves empty** (`Ek_C:11` says entries give the claim, class rule, examples, controls and break; `Ek_C:11` also says a test with an empty field is not accepted).
- All C2 rows have only Claim, Negative, Positive and Stage (`Ek_C:116`): no class rule, no examples and no break. Break can be drawn from `plan:832`, and for N02 from `plan:317`.
- Concurrency has two claims and no class rule, examples, explicit negative or break.
- K05 has only a success condition.
- F-entries have no claim line.
- Evidence layer is stated only for F02.
- Environment is stated only for Concurrency and F07.
- N01's "matches the rate" has no tolerance.

**d. A test needs something Appendix B does not define (inference unless stated).**
1. **F05:** Artifact has no `scope` field (`Ek_B:217`) although F05 is its first need (`:72`), and Source, which carries scope for (b), is C04 (`:69`).
2. **F01 (d):** Operation has no retention period for key records (`Ek_B:244-251`; checked by search).
3. **F04 (c):** "outside authority" has no C02 visibility rule beyond the hidden exam flag on Work and EvalRun (`Ek_B:273`).
4. **F06:**
   - Extraction from `devos_api` misses `devos_private.revoke_env_token`, which changes the epoch (`Ek_B:46`), and the expired-claims job (`:410`); neither carries a token `role_class`.
   - `mark_exported` updates `Event.exported_at` (`:255,386`), so an event per mark loops.
   - What counts as "state-changing" for the automatic extraction is not specified.
5. **F08:** the mapping from operation type to read set is unspecified (`Ek_B:250`).
6. **N02:** Decision has no "major design" marker (`Ek_B:287`). `premises` is already required at "open" for high-impact and batu decisions (`:290`).
7. **N09:** what marks "information that can change", and what counts as a primary source before Source exists in C04.
8. **N17 / N-136:** "a claim needs a registration" (`C02.md:87`), but `register_session` and SessionRecord are C04 (`Ek_B:90,390`). This is a deferred part needed earlier (`plan:848`). I did not read EV-C01-004 S8.
9. **Break attempts:** the only database write path is migration-on-merge to both projects (`plan:631`). No path to break a rule in `devos-test` only is stated.
10. **N18:** the plan names no role for the transfer.
    - Verdicts are writable only by `devos_denetim` (`Ek_B:237`).
    - Answered batu-class decisions require Batu's identity and `answer_decision`, which is C06 (`Ek_B:83,291,390`).
    - Transferred Work needs a `mission_ref` to a Mission opened by a batu decision (`Ek_B:104`).
    - N18 omits `plan:870`'s "explicit hand-over mark".
11. **N28:** a same-transaction attempt needs a call that writes both records in one transaction, and the audit role cannot write products anyway (`Ek_B:37`).
12. **N29:** `Ek_B:134` also refuses a link from a routine item to a high-impact or batu decision, and N29 has no negative for it. The high-impact path list (plan 6.7) must have a copy in the database.

## Open
- **Not read:** EV-C00-015 and EV-C01-004 (S5/S8/S9), EV-C01-002, `plan/Installation_Working_Order.md`, the test designer's role file, Appendices A and G, `plan/work/C03.md`–`C05.md`, and plan sections other than those cited.
- **Uncertain:**
  - what "the real query" in K05 and "planted in a run" in N29 require: a database query or a live session;
  - whether `devos-test` gets its own environment tokens;
  - what "registration" means in N-136.
- **Outside Appendix C but in C0 form on C02's file:** N-032 (FND-001's class test, with a structural part in C02/C03, `C02.md:35-37`). The work list should map it alongside these tests.
- **For the decision:** F02 needs no C02 item beyond the `Work.mandatory_needs` build choice. Items 5b, 5c and 5d-8, 5d-9 and 5d-10 change what the work list must decide before the tests can be written in C0 form.
- **Guard denials:** none.
