# W-C02-07 tests: the split into four groups (phase A, revised in phases C4a and C4b)

Every test that W-C02-07's acceptance asks for is in exactly one group below. Phase A cut the groups; phase B wrote them; phase C aligned the groups' files to one assumed interface (README section 8.1) and moved every program the migration job runs to `supabase/migrations/tests/` (note N-255 on `plan/work/C02.md`); phase C4a (2026-10-12) revised this file to the groups as they now stand, after the executor's decisions of phases B and C and EV-C02-008 sections 1 to 3 with PC-46 (merged and accepted, PR #300); phase C4b (2026-10-12) added what EV-C02-008 section 5 changes (N-262 and N-263, with PC-47; decided and accepted, L-301), with no new test: new parts of `T-W07-N08` (part X), `T-W07-N01` and `T-W07-T31` (parts B). The paths below are the current ones, except that phase C5 (2026-10-12; the executor's staging decision on CHK-C02-030 C1, README 5.1 (c)) staged every `w07_*` SQL file and program, unchanged, in `tests/C02/W-C02-07/job/`: where a path below reads `supabase/migrations/tests/w07_*`, that is the place its byte-for-byte copy takes once a build item makes it, and the staged file is `job/w07_*`. Phase C5 also moved T-W07-5A's positive control into `w07_5a_positive_control.sql`. 41 tests: Group A 11, Group B 11, Group C 10, Group D 9. Each group writes its own files only and follows `README.md`. `TABLES.md` holds the final mapping (points 2, 5, 6 and 8); where this file and `TABLES.md` differ, `TABLES.md` and the specifications hold.

- **Group A:** claims, effects and concurrency.
- **Group B:** graph, events, reviews and direct writes; it also owns the break harness.
- **Group C:** format gates, the sample, the impact class and decisions.
- **Group D:** the identity chain, authority between environments, real tokens and the scan; it also owns the token format.

"Serves" gives the build item and point each test serves, as `TABLES.md` section 4 maps it.

**How line references read.** The "Sources" lists below are phase A's reading lists, kept as they were written: they are at `main` `db2ebd9` unless marked otherwise, and phase C4a did not renumber them. The interface's references are README section 8.1's, at `main` `a98ea48`. At `db2ebd9`:
- `Ek_C:n` is `plan/Ek_C_Testler.md` line n, and `Ek_B:n` is `plan/Ek_B_Veri_Modeli.md` line n, which already hold PC-42's and PC-43's text;
- `EV2:n` is `evidence/C02/EV-C02-002_data_model_choices.md`, `EV3:n` is `evidence/C02/EV-C02-003_identity_chain_and_environments.md`, and `EV4:n` is `evidence/C02/EV-C02-004_reconciliation_decisions.md`;
- `R2:n` is `evidence/C02/raw/W-C02-01_source_map_R2_appendix_C.md`;
- `PC-42:n` and `PC-43:n` are lines of `plan/decisions/PC-42.md` and `PC-43.md`;
- the R2 source map's own `Ek_B:` numbers predate PC-42, so take Appendix B lines from this file.

## 1. Reading every group does first

- `plan/work/W-C02-07.md` lines 21 to 57 (the acceptance, in full).
- `tests/C02/W-C02-07/README.md` (these conventions).
- Appendix C C0, `Ek_C:9-26`.
- Plan Section 8 items 1 to 14: `plan/DevOS_Kurulum_Plani.md` from line 828.
- R2 sections 1, 2 and 5: `R2:16-130`, `R2:132-148` and `R2:189-232`, with section 4 at `R2:164-187` for environments.
- The break path, `EV2:368-378`, and the interfaces between the designs, `EV2:428-451`.
- EV-C02-003 §6.3, the owner-level path, `EV3:437-453`.
- EV-C02-004 Y-05, `EV4:55`.
- Note N-244 on `plan/work/C02.md` lines 314 to 316.
- W-C02-03's tests, read only: clone `scratchpad/cw57`, branch `claude/c02-w03-tests` at `86ebd65`. Read its `tests/C02/W-C02-03/README.md`, `T-W03-06`, `T-W03-07`, `breaks/B4_could_not_check_as_clean.sql` and `supabase/migrations/tests/w03_drift_could_not_check.sql`.
- The role check of every function: the matrix at `EV3:268-298`. It gives the role class for every call a test makes.

## 2. The groups

### Group A · Claims, effects and concurrency

| Test | What it tests | Serves (expected) |
|---|---|---|
| `T-W07-F01` | F01, whole-intent idempotency, examples (a) to (d); (d) under DM-28 (keys never deleted) | W-C02-09 point 8 |
| `T-W07-F05` | F05, scope checked on work item, target and source, with (d)'s second function path (DM-34) | W-C02-09 point 8 |
| `T-W07-F07` | F07's C02 part: (a), (b), and (c) as a synthetic sequence; (c) against real GitHub is C08's | W-C02-09 point 8 |
| `T-W07-F08` | F08, re-check at the moment of effect: (a) to (d); (c)'s epoch change by revoking a synthetic token (EV-C02-004 X-07); expiry as DM-06 computes it | W-C02-09 points 3, 4 and 8 |
| `T-W07-CONC` | Concurrency, both claims: one claim of many concurrent connections; no cycle from two opposing hard dependencies. It confirms DM-01 and DM-06. The numbers of connections and runs are fixed in advance (W-C02-13 point 4) | W-C02-09 point 8 |
| `T-W07-LOCKS` | Added in W-C02-09's test round 2 (parts TC-A and TC-C, 2026-10-19; EV-C02-018 16 decisions 2, 5 and 12): two connections get the answers of a serial order. A second first use of one new key gets the exact repeat (locks 9006 and 9007). A transfer call concurrent with `record_handover` is ordered against it (lock 9005). Of two first transfers of the installation's Mission, one is accepted (lock 9004). The numbers of runs are fixed in advance. It runs only on the break harness's throwaway database, is never copied, and its counted result is the harness's run on PostgreSQL 17 in W-C02-13 (the executor's decision, 2026-10-19; README 5.1 (b)) | The corrective migration's verdict (i) and W-C02-09's verdict (ii) (EV-C02-018 16 decision 12); W-C02-13 point 3 for its breaks. Not W-C02-09 point 8, which asks for `devos-test` |
| `T-W07-N17` | N17 with PC-43 place 11 and N-136: another session's claim; no claim token; every call that takes a claim token (an effect, `heartbeat`, `release`) with another role class's token; the `devos_kurulum` token's own claims. "A claim without registration" is named as moved to C04 (EV3 §4.4) | W-C02-09 points 4 and 8 |
| `T-W07-5C` | Point 5 (c): another session's claim, and a fake session ID, on a claim-bearing operation that is not a verdict | W-C02-09 point 8 |
| `T-W07-DM07` | `heartbeat` refuses a lapsed or revoked claim (EV2 §6) | W-C02-09 point 4 |
| `T-W07-DM34` | A scope outside the Mission refused at `admit_work` (EV2 §6) | W-C02-09 point 8 |
| `T-W07-6RG` | Point 6 for the rule gate's checks without the token (W-C02-09 point 7). Inputs: the global authority epoch missing; a referenced record or revision missing; an element of the read set missing; a readiness group with an unknown member; a claim whose lease or generation cannot be read. Each is missing, unreadable and partial | W-C02-09 point 7 |
| `T-W07-5F` | Point 5 (f): the migration lines. It cites W-C02-03's tests by path, with the item that runs them, and checks each line has a C0 test there; a line without one gets one here | W-C02-03 (cited); none built here |

**Files.**
- Specifications: `tests/C02/W-C02-07/T-W07-{F01,F05,F07,F08,CONC,LOCKS,N17,5C,DM07,DM34,6RG,5F}_<slug>.md`.
- SQL: `supabase/migrations/tests/w07_{f01,f05,f07,f08,n17,5c,dm07,dm34,6rg}_<slug>.sql`.
- Concurrency's multi-connection runner: `supabase/migrations/tests/w07_conc_claim_and_cycle.py`, a program the migration job runs (phase C: note N-255; README 5.1 (b)).
- LOCKS's multi-connection program: `tests/C02/W-C02-07/job/w07_locks_key_and_handover_locks.py`, staged only. The harness runs it on its throwaway database; the migration job does not run it, and no item copies it (README 5.1 (b) and (c)). It refuses, writing nothing, on any other database.
- Breaks: `tests/C02/W-C02-07/breaks/B-{F01,F05,F07,F08,CONC,LOCKS,N17,5C,DM07,DM34,6RG}-<n>_<slug>.sql` (`B-LOCKS-1` to `-5`).

**Sources** (beyond section 1):
- Appendix C:
  - F01 `Ek_C:32-39`, F05 `Ek_C:70-77`, F07 `Ek_C:88-95`, F08 `Ek_C:97-104`;
  - Concurrency `Ek_C:106-110`, N17 `Ek_C:134`.
- Appendix B:
  - principles 4, 6, 8 and 9 (`Ek_B:11-30`);
  - 3.3 Work (`Ek_B:117-137`), 3.4 hard dependencies and cycle refusal (`Ek_B:138-149`), 3.5 Assignment (`Ek_B:150-159`), 3.10 Artifact (`Ek_B:219-226`), 3.12 Operation and Observation (`Ek_B:246-257`);
  - section 4's rows "Readiness and claim" and Operation (`Ek_B:372-401`);
  - section 5's activation paragraph (`Ek_B:402-423`).
- EV-C02-002:
  - DM-01 `EV2:105-111`, DM-06 `EV2:129-135`, DM-07 `EV2:136-142`, DM-28 `EV2:250-255`;
  - DM-34 `EV2:279-284`, DM-37 `EV2:293-297`, DM-38 `EV2:298`;
  - the lease's row in section 4, `EV2:354` (30 minutes; point 8's time);
  - section 6, `EV2:380-382`.
- EV-C02-003:
  - §1.4 `EV3:141-146`, §1.7 the claim token `EV3:164-179`;
  - §4.3 `EV3:322-324`, §4.4 `EV3:326-341`, §4.5 `EV3:343-347`;
  - §6.2's last item, `EV3:435`;
  - §15's rows on claims and fake declarations, `EV3:1302-1307`.
- PC-42:
  - place 13, expiry and `heartbeat`, `PC-42:92-97`;
  - place 17, the re-check and the read set, `PC-42:114-119`;
  - place 28, "Readiness and claim", `PC-42:171-175`.
- PC-43 place 11, N17, `PC-43:77-81`.
- The build items' conditions: W-C02-09 points 3, 4, 7 and 8; W-C02-13 point 4.
- For `T-W07-LOCKS` (2026-10-19, not at `db2ebd9`): EV-C02-018 section 16 (decisions 2, 5 and 12, with its dated line), and EV-C02-013 sections 26 (2) and 28, at `main` `3520a9d`.
- R2 section 5:
  - (b)'s "fake session ID", `R2:198`;
  - (d) items 2, 5 and 8, `R2:215`, `R2:221` and `R2:224`.
- For `T-W07-5F`:
  - `plan/work/W-C02-03.md` lines 20 to 62 (points 5 to 10, 12 and 14);
  - the W-C02-03 tests index in the `cw57` clone's README;
  - `plan/work/C02.md` lines 36 to 39, the migration lines.

**Dependencies.**
- On Group D: the interface of `issue_env_token` and `revoke_env_token`, which F08 (c) and N17 use. Group D's `T-W07-IDC` states it. Group A states the same interface under "Interface assumed", and phase C checks that the two agree.
- On Group B: the harness, for its breaks.
- On W-C02-03's tests being merged: `T-W07-5F` cites them by path, so it waits for that merge. This is a partial wait, off the critical path (W-C02-07's body).

### Group B · Graph, events, reviews and direct writes; the break harness

| Test | What it tests | Serves (expected) |
|---|---|---|
| `T-W07-F04` | F04, the affected-records query: examples (a) to (d), with (c) as DM-35 defines "outside authority", narrowed by EV-C02-008 5.1 (an exam record planted as a relation end; phase C4b: F04-e-exam, F04-c-sin, F04-m3, F04-m4). (d) is also point 6's case for `affected_entities` and `explain_paths` at a limit (completeness flag; never "nothing else is affected") | W-C02-09 points 7 and 8 |
| `T-W07-K05` | K05: the F04 class test, and the row count not exceeding the record count in the real query, with the success condition written in advance (`Ek_C:152`) | W-C02-09 point 8 |
| `T-W07-F06` | F06: every state-changing function produces its event in the same transaction. The list is extracted from the catalogue as PC-42 place 37 and DM-36 state it: `devos_api` and the owner-only `issue_env_token` and `revoke_env_token`, with the `devos:read` marker. A marked read function changes no table but RejectedAttempt. Events carry `role_class` from the token. No orphan event on a mid-transaction error. An exact repeat makes no event and raises no error | W-C02-09 points 5 and 8 |
| `T-W07-N09` | N09's C02 part: an undated or secondary-only Finding cannot become `accepted_for_use`, with DM-26's markers | W-C02-09 point 8 |
| `T-W07-N25` | N25's C02 part: the database's staleness rule | W-C02-09 point 8 |
| `T-W07-N28` | N28, as PC-46 place 2 writes it: a new revision of a review's target in the same transaction as a Review or Verdict is refused (DM-41; parts A and B); the database's own `sample` Review, opened for the revision whose accepted write draws it, is not a review record, and nothing else is exempt; the transaction that takes a sample or writes its verdict is refused with a new revision of its target (EV-C02-008 2.5's cases; parts A2 and B2, phase C4a); the repair opens as a separate work item | W-C02-10 points 5 and 7 |
| `T-W07-DM02` | Revision tables refuse update and delete (EV2 §6) | W-C02-08 points 3 and 6 |
| `T-W07-DM19` | A refused call leaves its RejectedAttempt record and no half state; the record survives the refused transaction (EV2 §6; W-C02-09 point 3) | W-C02-09 points 3 and 5 |
| `T-W07-DM19B` | A burst of calls without a verified token adds no rows beyond one counted row per function, reason code and hour; a revoked token is counted (EV2 §6; `EV3:1311`) | W-C02-09 point 3 |
| `T-W07-5A` | Point 5 (a), no direct writes. The roles are every role class C02 creates, plus `anon` and `authenticated`. The tables are every table, listed from the catalogue at run time. The operations are INSERT, UPDATE, DELETE, TRUNCATE, and SELECT where it is not granted by name (W-C02-08 point 4). It includes the catalogue looks of W-C02-08 point 4. The positive control goes through the owning `devos_api` function. The migration credential's role and the project owner are named as outside the line, with the reason | negatives: W-C02-08 points 4 and 6; positive control: W-C02-09 |
| `T-W07-REL` | Relation's rule: `relate` with `model_extracted` and `observation` refused (PC-16 place 13). Assigned to Group B by the executor's decision 1 of phase B (section 5) | W-C02-09 point 6 (point 8) |
| harness | The break harness of README 5.2. It also runs W-C02-03's breaks B1 to B4 with `w03.throwaway = 'yes'`, and their unpatched run is its own positive control | used by W-C02-13 and W-C02-03 |

**Files.**
- Specifications: `tests/C02/W-C02-07/T-W07-{F04,K05,F06,N09,N25,N28,DM02,DM19,DM19B,5A,REL}_<slug>.md`.
- SQL: `supabase/migrations/tests/w07_{f04,k05,f06,n09,n25,n28,dm02,dm19,5a,rel}_<slug>.sql`; N28 has two, `w07_n28_verifier_does_not_repair.sql` (part A) and `w07_n28_sample_exemption.sql` (part A2, phase C4a).
- `DM19B` needs calls without a verified token through the Data API, so its part B is `supabase/migrations/tests/w07_dm19b_burst_over_http.py`, a program the migration job runs (phase C: N-255; README 5.1 (b)); its SQL part is `w07_dm19b_burst_count.sql`. 5A's part B is `supabase/migrations/tests/w07_5a_exposed_schema.py`.
- Breaks: `tests/C02/W-C02-07/breaks/B-{F04,K05,F06,N09,N25,N28,DM02,DM19,DM19B,5A,REL}-<n>_<slug>.sql`.
- The harness: `tests/C02/W-C02-07/harness/README.md` (its specification, with its own positive control and its refusals), `tests/C02/W-C02-07/harness/run_breaks.py`, its canary, and the scenarios that commit on the throwaway database only: `harness/scenarios/n28_separate_transactions.sql` (N28 part B) and `harness/scenarios/n28_sample_taking.sql` (N28 part B2, phase C4a). Phase C4b adds two scenarios there that belong to Group C's tests: `n01_open_block.sql` (`T-W07-N01` part B) and `t31_open_block.sql` (`T-W07-T31` part B).

**Sources** (beyond section 1):
- Appendix C: F04 `Ek_C:61-68`, F06 `Ek_C:79-86`, N09 `Ek_C:126`, N25 `Ek_C:142`, N28 `Ek_C:145`, K05 `Ek_C:160`, with C3's introduction at `Ek_C:152`.
- Appendix B:
  - principles 1 to 3 (`Ek_B:11-30`), section 2 (`Ek_B:31-51`);
  - 3.4 (`Ek_B:138-149`), 3.8 Finding (`Ek_B:184-202`), 3.11 (`Ek_B:227-245`), 3.13 Event (`Ek_B:258-265`);
  - section 4 (`Ek_B:372-401`), including `affected_entities` and `explain_paths`;
  - section 7's privacy filter (`Ek_B:434-445`).
- EV-C02-002:
  - DM-02 `EV2:112-117`, DM-19 `EV2:206-211`, DM-26 `EV2:238-243`, DM-31 `EV2:264-269`;
  - DM-35 `EV2:285`, DM-36 `EV2:287-292`, DM-41 `EV2:304`;
  - section 6 `EV2:380-382`;
  - the PostgreSQL version, `EV2:374` and `EV2:457`.
- EV-C02-003: §1.6 `EV3:156-162`; §15 `EV3:1291-1313`, rows 1310 and 1311; §0 row 48 `EV3:97` (who reads RejectedAttempt).
- PC-42:
  - place 3, Section 8 item 3, `PC-42:40-44`;
  - place 15, `PC-42:103-108`;
  - places 18 and 19, Event, `PC-42:120-130`;
  - place 37, F06, `PC-42:237-241`.
- The build items' conditions: W-C02-08 points 3, 4 and 6 and "Not covered" (e); W-C02-09 points 3, 5, 7 and 8; W-C02-10 point 5's N28 line; W-C02-13 point 3.
- For the harness:
  - EV-C02-001 section 10, `psql` and meta-commands (`evidence/C02/EV-C02-001_migration_path.md` line 496), and P10 (line 511);
  - W-C02-03's `breaks/` and the "Break attempt" rows of T-W03-06 and T-W03-07 (clone `cw57`).

**Dependencies.**
- None on another group for writing.
- The other groups depend on the harness for their break self-checks, but not for writing: their patches follow README 5.2's form.
- `T-W07-DM19` and `T-W07-DM19B` assume the same reason codes as Group D's `T-W07-6TK` (EV3 §15's list). Phase C checks they agree.

### Group C · Format gates, the sample, impact class and decisions

| Test | What it tests | Serves (expected) |
|---|---|---|
| `T-W07-N01` | N01, all its negatives (empty `why_needed`; a "filled but meaningless" justification reaches the audit queue as a `sample` Review; the sampled share matches the rate, with its tolerance written in advance; a `sample` Review written with the working token refused) and its positive. Phase C4b (EV-C02-008 5.2): N01-same-answer, and part B (a harness scenario): the open sample, a Verdict on it and their events unseen by every class but the audit environment's until the block completes, in the need stream and the two routine streams (N01-unseen-*) | W-C02-10 points 3 and 7 |
| `T-W07-N02` | N02, its negatives and positive. Also point 4's "filled but meaningless" example. Also point 4's `alternatives_state = open_exploration` case, for each transition C02 builds that answers or accepts a decision. If C02 builds none (`answer_decision` is C06's), the test says so and names the C06 carrier note that the executor writes (W-C02-07 point 4; W-C02-10 point 6) | W-C02-10 points 6 and 7 |
| `T-W07-N03` | N03, all five negative cases and both positive cases, with point 4's "filled but meaningless" example; and `set_effort_policy`'s three kinds after the gate (EV-C02-008 1.7.4), with the cases of CHK-C02-025 C2 (phase C4a) | W-C02-10 points 2, 5 and 7 |
| `T-W07-N29` | N29, every case but the Constraint case (C05). This includes PC-42 place 39's link case and DM-48's structural cases. It also covers the routine-labelled item that only a declared trigger makes high-impact, planted, which must reach the audit environment through the sample | W-C02-10 points 4 and 7 |
| `T-W07-T31` | Point 4's N-074 T-31 C02 part: how many filled-but-meaningless records are planted, the share used (DM-08), and the rate at which they must be caught, with its tolerance, all written before any run. It names where PC-08 moved T-31's other parts. Phase C4b: part B (a harness scenario), T31-unseen-<stream> (EV-C02-008 5.2) | W-C02-10 points 3 and 7 |
| `T-W07-5D` | Point 5 (d): every format gate refuses its field empty in each form W-C02-10 point 2 lists (absent, empty string, whitespace, empty list, emptied by a later revision). Each gate's "filled but meaningless" examples (at least two kinds) fall to sample review, and every gate's complete record is accepted | W-C02-10 points 2, 3 and 7 |
| `T-W07-FGFIND` | Finding's format gate, kept in C02 by DM-30 (`counter_evidence_searched`, `changeable`), with its "filled but meaningless" example. N-032's structural gate is named as moved to C03 (EV2 §7; N-211), with no test here | W-C02-10 points 2 and 7 |
| `T-W07-DM11` | An answer's revision equals the current one, and no revision follows an answer (EV2 §6). If C02 builds no answering transition, the test says so and names the stage that takes it | W-C02-10, or the stage that builds `answer_decision` |
| `T-W07-DM47` | The database's high-impact path table equals the merge gate's list, path by path (EV2 §6; W-C02-10 point 4) | W-C02-10 point 4 |
| `T-W07-6ST` | Point 6 for the checks that read database settings (W-C02-10 points 3 and 4). Inputs: the sample share; the sample stream's hidden position if DM-08's design makes it a separate input; the high-impact path list's copy. Each is missing, unreadable and partial. A format-gated write, or a routine-labelled write with a target, is refused as "could not check" | W-C02-10 points 3 and 4 |

**Files.**
- Specifications: `tests/C02/W-C02-07/T-W07-{N01,N02,N03,N29,T31,5D,FGFIND,DM11,DM47,6ST}_<slug>.md`.
- SQL: `supabase/migrations/tests/w07_{n01,n02,n03,n29,t31,5d,fgfind,dm11,dm47,6st}_<slug>.sql`.
- `DM47` reads the merge gate's list, which is not in the database: its comparison is `supabase/migrations/tests/w07_dm47_merge_gate_list.py`, a program the migration job runs (phase C: N-255; README 5.1 (b)).
- Breaks: `tests/C02/W-C02-07/breaks/B-{N01,N02,N03,N29,T31,5D,FGFIND,DM11,DM47,6ST}-<n>_<slug>.sql`.
- Part B of `T-W07-N01` and `T-W07-T31` (phase C4b): `tests/C02/W-C02-07/harness/scenarios/n01_open_block.sql` and `t31_open_block.sql`, copies of this group's helper block (README section 7) with two more call forms; they commit, so they run only under the harness.

**Sources** (beyond section 1):
- Appendix C: C0's last paragraph `Ek_C:26`; N01 `Ek_C:118`, N02 `Ek_C:119`, N03 `Ek_C:120`, N29 `Ek_C:146`.
- Appendix B:
  - principle 12 (`Ek_B:11-30`);
  - 3.2 (`Ek_B:108-116`), 3.3 with the impact-class rule (`Ek_B:117-137`; PC-42 place 12), 3.8's Finding fields (`Ek_B:184-202`);
  - 3.11's sample rule (`Ek_B:227-245`), 3.17 (`Ek_B:292-302`), 3.18 (`Ek_B:303-308`);
  - section 4's Decision row (`Ek_B:372-401`; PC-42 place 29).
- EV-C02-002:
  - DM-08 `EV2:143-148` (one in every block of 10, at a hidden random position; "the test needs no tolerance" for N01);
  - DM-11 `EV2:161-166`, DM-23 `EV2:218-229`, DM-27 `EV2:244`, DM-30 `EV2:262`;
  - DM-42 `EV2:306`, DM-45 `EV2:314`, DM-46 `EV2:316`, DM-47 `EV2:318-323`, DM-48 `EV2:324`;
  - section 7's rows for N-032 and N-074, `EV2:389` and `EV2:391`.
- PC-42:
  - place 12, `PC-42:87-91`; place 14, `PC-42:98-102`;
  - places 21 and 22, `PC-42:136-145`; place 29, `PC-42:176-180`;
  - place 39, `PC-42:247-251`.
- The build items' conditions: W-C02-10 points 2 to 4, 6 and 7, and "Not covered" (a) and (f); W-C02-13 point 5.
- T-31's sources, as W-C02-07 point 4 quotes them: CHK-C00-022 F12 (c) and CHK-C00-035 item 3, under `evidence/C00/checks/`; note N-074 on `plan/work/C02.md`.
- Plan 6.7's high-impact path list, and `tools/merge_gate.py` lines 35 to 41.
- R2 section 5:
  - (b) `R2:199-200`;
  - (c) `R2:204-211`;
  - (d) items 6 and 12, `R2:222` and `R2:232`.

**Dependencies.**
- None on another group for writing.
- N03's token cases and the matrix's effort rows (Group D, `T-W07-5B`) touch the same function. The split, since EV-C02-008 1.7.4: `T-W07-5B`'s row R08g tests `set_effort_policy`'s gate (`devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum` ✔; `devos_ci`, `devos_backup` ✘); `T-W07-N03` tests EV-C02-003 §4.1's effort row as an operation row after the gate, every cell of it (CHK-C02-025 C2), and kind (a) under Rule O. `T-W07-ROC` (Group D) tests Rule O on the Work and Relation functions.

### Group D · Identity chain, authority between environments, real tokens and the scan

| Test | What it tests | Serves (expected) |
|---|---|---|
| `T-W07-IDC` | The identity chain's first part (EV3 §3.3 item 1, needed first, before sitting A): `env_tokens`, the global authority epoch's row, and Event with `origin`. `issue_env_token` shows a token once and stores only its hash; the token is then looked for by value in every table, event, refusal, result and error. `revoke_env_token` increments the epoch. Also the derivation, `token_role_class()` and RejectedAttempt. Every application role and every class's token is refused `issue_env_token` and `revoke_env_token` | W-C02-09 point 3 |
| `T-W07-6TK` | Point 6 for the derivation's input: one case per reason code, `missing`, `empty`, `malformed`, `unknown`, `revoked` and `header_unreadable` (`EV3:1310`). Each is refused before any other check, recorded with role class `none`, and kept apart from a refusal for a wrong role class and from acceptance | W-C02-09 points 3 and 7 |
| `T-W07-5B` | Point 5 (b) and the authorization test of W-C02-09 point 8: every ✘ cell and every ✔ cell of the matrix `EV3:268-298`, and of the rows EV-C02-008 adds (1.2's ten functions, R15's `read_rejected_attempts`, 1.7.2's `operation_state`, 1.7.3's ledger transfer, 1.7.4's `set_effort_policy` at the gate; phase C4a), in every column. The columns include `devos_ci` and `devos_backup`, which are tested here with synthetic tokens (`EV3:375-380`). The rows include `revoke_claim` (DM-29), `open_mission`, the RejectedAttempt read, `deployment_drift`, `mark_exported`, and the issue and revocation of tokens. It is run with `devos-test`'s synthetic tokens | the role lists: W-C02-09 point 8; the separation lines: W-C02-10 point 5 |
| `T-W07-ROC` | Phase C4a: EV-C02-008 1.7.1's Rules O and C, after the gate. Each Work and Relation write with each class's token on a working item, the installation's item and an exam task; the exam fact not leaked by these rules; another class's claim stopping a revision, cancellation or hard relation, and a claim of the caller's own class not stopping a cancellation | W-C02-09 point 8; W-C02-10 point 5 |
| `T-W07-N04` | N04's C02 part, with PC-43 place 9. A binding verdict or acceptance with the working token is refused, and so are a fake role name and a fake session ID with the same token. The same with the `devos_kurulum` token outside the ledger transfer's path, and with any approval a rule counts as the audit environment's. The positive control: the audit environment's record is accepted. The transfer copy's positive is named with W-C02-14 | W-C02-10 point 5 |
| `T-W07-N08` | N08's database part, which N-136 and EV3 §4.5 bring into C02: every access to the exam records with the working, audit, `devos_kurulum` and `devos_ci` tokens is refused, and the exam token accesses. Its C03 parts are named. Phase C4b (EV-C02-008 5.1): the reader finder exempts nine named functions; part X holds N08-s3, N08-s4, the EXF pairs (an exam task opened with the exam token against ordinary work, which carry 1.7.1's "answers equal" case) and N08-x | W-C02-10 point 5; part X also W-C02-09 points 4 and 8 |
| `T-W07-RT` | The real-token runs in `devos` (README 5.3): the cases of W-C02-12 points 4 to 6, per environment and for `devos_kurulum` and `devos_ci`. Each ✘ case names the 5.1 test of the same rule (from Groups A and D) whose break stands for it (W-C02-12 point 8) | W-C02-12 points 4 to 7 |
| `T-W07-7SCAN` | Point 7's scan over the test files and fixtures of all four groups, with its planted control in a scratch copy and its own missing, unreadable and partial inputs (point 6) | W-C02-07 point 7 (it judges this set) |
| `T-W07-6SC` | Point 6 for the scans that W-C02-05 designs and C02 runs: the session's format scan (`EV3:239-251`) and W-C02-12 point 9's scan of the repository, branches, issue #6 and the records. Each is tested with missing, unreadable and partial input, against the build's scan through the interface it names. A place the scan cannot read gives "could not check", never zero | W-C02-12 point 9 |
| `shared/token_format.md` | The literal markers of the environment token's and the claim token's formats (`EV3:133-139`, `EV3:164-179`), and the patterns that find them, fixed before the build. Checked against the guard's existing patterns | W-C02-09 (the issuer), W-C02-20 (the guard's stop; `plan/work/W-C02-20.md`), W-C02-12 point 9 |

**Files.**
- Specifications: `tests/C02/W-C02-07/T-W07-{IDC,6TK,5B,ROC,N04,N08,RT,7SCAN,6SC}_<slug>.md`.
- SQL: `supabase/migrations/tests/w07_{idc,6tk,5b,roc,n04,n08}_<slug>.sql`. `w07_roc_ownership_and_claim_class.sql` copies Group C's helper block (README section 7), with two more call forms. Phase C4b: `T-W07-N08` part X is `w07_n08_exam_fact.sql`, a copy of the ROC file's helper block with five more call forms.
- Data API programs the migration job runs (phase C: N-255; README 5.1 (b)): `supabase/migrations/tests/w07_idc_real_path.py` for the real path per role class (W-C02-09 point 3), and `supabase/migrations/tests/w07_6tk_http_reasons.py` for the HTTP form of the reason codes. `header_unreadable` is planted in SQL instead, since the Data API always sets `request.headers` (the executor's decision, phase C).
- The scan: `tests/C02/W-C02-07/bin/7scan_test_files.py` (the job does not run it, so it stays class normal: N-255 (4)), with its pattern file `tests/C02/W-C02-07/shared/scan_patterns.json`.
- The format: `tests/C02/W-C02-07/shared/token_format.md`.
- Breaks: `tests/C02/W-C02-07/breaks/B-{IDC,6TK,5B,ROC,N04,N08,EXF}-<n>_<slug>.sql` (`B-EXF-1`, phase C4b, is `T-W07-N08` part X's).
- `T-W07-RT` is a specification only. Its runs are W-C02-12's sessions.

**Sources** (beyond section 1):
- Appendix C: N04 `Ek_C:121`, N08 `Ek_C:125`, N17 `Ek_C:134` (for RT), and K06 `Ek_C:161` (what stays C03's).
- Appendix B:
  - principles 8 and 9 (`Ek_B:11-30`);
  - section 2 (`Ek_B:31-51`), with the `devos_kurulum` row and the paragraph on issuing tokens (PC-43 places 5 and 6);
  - 3.15 EvalRun (`Ek_B:274-283`), 3.27 EnvToken (`Ek_B:364-371`);
  - section 4's Session group and its Review row (PC-43 places 8 and 13).
- EV-C02-003:
  - §0 `EV3:44-100`; §1.1 `EV3:104-120`; §1.3 `EV3:133-139`; §1.5 `EV3:148-154`; §1.6 `EV3:156-162`; §1.7 `EV3:164-179`;
  - §3.2 `EV3:239-251`; §3.3 `EV3:253-264`;
  - §4.1 `EV3:268-298`; §4.2 `EV3:300-320`; §4.5 `EV3:343-347`; §5.1 to §5.4 `EV3:351-380`;
  - §6.2 `EV3:411-435`; §6.3 `EV3:437-453`;
  - §14 `EV3:1275-1289`; §15 `EV3:1291-1313`.
- EV-C02-002: DM-19 `EV2:206-211`, DM-23 `EV2:218-229`, DM-24 `EV2:230-235`, DM-29 `EV2:256-261`, DM-31 `EV2:264-269`; A1 `EV2:430-438`.
- EV-C02-004 part 1: X-04 to X-06, X-10, X-13, X-16 and X-17 (`EV4:17-44`).
- PC-43 places 5 to 11 and 13, `PC-43:45-101`.
- The build items' conditions: W-C02-08 point 5; W-C02-09 point 3; W-C02-10 point 5; W-C02-12 points 4 to 9.
- Note N-136 on `plan/work/C02.md`, and `evidence/C01/EV-C01-004_environment_separation_one_account.md` S8.
- For the scan:
  - `.claude/hooks/tool_allowlist.py` lines 149 to 153 (`CREDENTIAL_VARS`) and 416 to 418 (`REDACT`);
  - `tools/credential_value_scan.py` and its test `tools/test_credential_value_scan.py`.
  - `REDACT`'s last pattern matches the words "token", "secret" or "password" followed by `=` or `:`, so the scan must class each hit as a name or a value, by a rule fixed before the run.

**Dependencies.**
- Groups A to C on D's `shared/token_format.md`: none in writing, since README section 6 has them derive tokens at run time and never write the marker.
- `T-W07-RT` on Group A: it cites Group A's `T-W07-N17` and `T-W07-5C` by test ID (fixed here), and by case ID once Group A has written them. Phase C fills in any case ID still missing.
- `T-W07-7SCAN` is written by D. It is run over all four groups' files at the head that adds them, before the checker's verdict. Its run waits for the other groups; its writing does not.
- On Group B: the harness, for its breaks.

## 3. Point 6: every automatic check, scan or audit C02 builds, and its test

This is the list the record needs ("the record lists any other that W-C02-04 or W-C02-05 designs"). It is drawn from W-C02-09 point 7, W-C02-10 points 3 and 4, EV-C02-002, EV-C02-003 and EV-C02-008. `TABLES.md` section 3 holds it with each input's case IDs (K1 to K22).

| Check | Designed in | Its "could not check" test | Group or item |
|---|---|---|---|
| The derivation: the token header missing, empty, malformed, unknown, revoked or unreadable | EV3 §1.6, §15; EV-C02-004 X-04, X-06 | `T-W07-6TK` | D |
| The rule gate: the global authority epoch missing | W-C02-09 point 7; EV2 DM-01 | `T-W07-6RG` | A |
| The rule gate: a referenced record or revision missing | W-C02-09 point 7 | `T-W07-6RG` | A |
| The rule gate: an element of the read set missing | W-C02-09 point 7; EV2 DM-37 | `T-W07-6RG` | A |
| Readiness: a group with an unknown member | W-C02-09 point 7; B principle 6 | `T-W07-6RG` | A |
| The claim's expiry, computed at `claim` and `ready_works()`: lease or generation unreadable | EV2 DM-06 | `T-W07-6RG` | A |
| `affected_entities` and `explain_paths` at a limit, and with a missing or unreadable input | W-C02-09 point 7; F04 (d) | `T-W07-F04`, cases (d), F04-m1, -m2, F04-u1, -u2 | B |
| The sample share's setting | W-C02-10 point 3; EV2 DM-08 | `T-W07-6ST` | C |
| The sample stream's hidden position, if a separate input | EV2 DM-08 | `T-W07-6ST` | C |
| The high-impact path list's copy | W-C02-10 point 4; EV2 DM-47 | `T-W07-6ST` | C |
| The comparison of the path table with the merge gate's list | EV2 DM-47 | `T-W07-DM47`'s own "could not check" cases | C |
| W-C02-07's scan (point 7) | W-C02-07 point 7; EV3 §1.3 | `T-W07-7SCAN` | D |
| The comparison of the IDC program's embedded token pattern with `shared/scan_patterns.json` (phase C3) | W-C02-07 point 7; README section 6 | `T-W07-7SCAN` (7SCAN-pf5) | D |
| DM-41's trigger and the Review table's check establishing a `sample` row's writer (the sampling path's marker; phase C4a) | EV-C02-008 2.2 condition 2 and its fail-closed rule | `T-W07-N28` part A2 (S-neg-direct; S-ccc through a hook) | B |
| The session's format scan, and W-C02-12 point 9's scan | EV3 §3.2; W-C02-12 point 9 | `T-W07-6SC` | D |
| The executor's count-only log check on `devos` | EV3 §14 | None, by the executor's decision 2 of phase B: a procedure the executor runs, not a check C02 builds (`TABLES.md` K19) | executor |
| The migration job's reading of the programs' exit codes, input and environment (N-255) | W-C02-03's build | None here, by the executor's decision (phase C3): W-C02-03's build checker judges the runner against stub programs (`TABLES.md` K20, G11) | W-C02-03 |
| The guard's stop of strings of the token formats | EV3 §1.6, §1.7 | W-C02-20's own tests (`plan/work/W-C02-20.md`; the stop moved there from W-C02-11) | W-C02-20 |
| `deployment_drift` | EV-C02-001; PC-41 | W-C02-03's T-W03-07, with T-W03-06 and T-W03-14 (cited, point 6) | W-C02-03 |
| The ledger transfer's checks | W-C02-06 | W-C02-14 point 13 | W-C02-14 |

## 4. Rules a design asks W-C02-07 to cover that no Appendix C test names

EV-C02-002 section 6 (`EV2:380-382`) asks W-C02-07 to cover the rules below; "the executor reconciles". W-C02-07's acceptance does not list them. They are assigned here because Section 8 item 3 asks a break test for every database rule.

- **DM-02 revision tables:** `T-W07-DM02` (Group B).
- **DM-11 the answer's revision:** `T-W07-DM11` (Group C).
- **DM-19, no half state:** `T-W07-DM19` (Group B).
- **DM-07 `heartbeat` on a lapsed or revoked claim:** `T-W07-DM07` (Group A).
- **DM-19's burst count:** `T-W07-DM19B` (Group B).
- **DM-29 `revoke_claim`:** inside `T-W07-5B` (Group D).
- **EV-C02-008 1.7.1, Rules O and C:** `T-W07-ROC` (Group D; phase C4a).
- **DM-47 the path table:** `T-W07-DM47` (Group C).
- **DM-34 the Mission's scope at `admit_work`:** `T-W07-DM34` (Group A).
- **EV-C02-018 16 decisions 2, 5 and 12, the locks under two connections** (9006 and 9007, the key locks; 9005, the hand-over lock; 9004, the one-Mission lock, N-303's L-403 annotation): `T-W07-LOCKS` (Group A; W-C02-09's test round 2, 2026-10-19). It is not one of EV2 section 6's rules: a later design record adds it, as README section 1 allows.

The rules EV2 section 6 places "inside named tests" go with those tests:

| Rule | Test |
|---|---|
| DM-28 | F01 |
| DM-35 | F04 |
| DM-34 | F05 |
| DM-31, DM-36 | F06 |
| DM-07 (PC-43's extension) | N17 |
| DM-06, DM-37 | F08 |
| DM-08 | N01 |
| DM-26, DM-30 | N09, FGFIND |
| DM-41, with EV-C02-008 section 2 | N28 |
| DM-42, DM-48 | N29 |
| DM-01 | CONC |

EV-C02-003 section 3.3 item 1 asks for the identity chain's first part's tests: `T-W07-IDC` (Group D).

## 5. Phase A's unassigned items, as the executor decided them

- **W-C02-09 point 6, Relation's rule** (`relate` with `model_extracted` and `observation` refused; PC-16 place 13): assigned to Group B as `T-W07-REL` (the executor's decision 1 of phase B).
- **The executor's log check** (EV3 §14): not tested here, a procedure (the executor's decision 2 of phase B; section 3).
- **The carrier note on `plan/work/C06.md`.** C02 builds two transitions that answer or accept a decision, both the ledger transfer's (W-C02-06's design, accepted): `transfer_decision`, which writes a decision in its recorded status (EV-C02-005 2.2), and `transfer_acceptance`, which sets a Decision accepted (EV-C02-005 2.4). `T-W07-N02` tests both (N02-oe-transfer-decision and N02-oe-transfer-accept, each with its positive pair; phase C5, CHK-C02-030 C6). `answer_decision` is C06's (B:390), so its case moves to C06 with it, and its carrier note is N-259 on `plan/work/C06.md` (lines 154 to 156), which L-296 names: the executor's record write, not a test file (W-C02-07 point 4). Closed (`TABLES.md` G6; CHK-C02-046 C5 (a)).
- **Phase C4b** (2026-10-12), done before any result: what EV-C02-008 section 5 changes (N-262 and N-263, with PC-47), in `T-W07-F04` (F04-c-noleak on an exam record, F04-e-exam, F04-c-sin, F04-m3, F04-m4), `T-W07-N08` (the finder's exemption; part X: N08-s3, N08-s4, the EXF pairs, N08-x), `T-W07-N01` (N01-same-answer; part B, the unseen cases, the routine streams' among them), `T-W07-T31` (part B; its "Not covered"), and pointers in `T-W07-ROC` and `T-W07-N29`. Also, found while doing it: `T-W07-F04`'s and `T-W07-K05`'s graph nodes are now records (`TABLES.md` G26). N-264's frame review of the sample's hidden position is an open dependency of the N-263 cases (`TABLES.md` G23).
