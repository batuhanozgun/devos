---
id: EV-C02-017
title: "W-C02-09: the record five open rule questions are decided from (N-284, N-286, N-289, N-292, N-296 (3))"
kind: evidence
status: decided (to a checker)
date: 2026-10-19
produced_by: "sections 1 to 8: producer agent af4f94fe9a7b1e1a0 (fresh-context subagent), named by the executor; section 9: the executor (L-378)"
main_at: d1407973e142a5d7a55e1765ee991145d44460da
---

# EV-C02-017 · W-C02-09: five open rule questions, with their sources, options and a recommendation each

**What this is.** Five notes on `plan/work/C02.md` leave a rule question of W-C02-09's build to the executor, each "to be decided, with a checker": N-284, N-286, N-289, N-292 and N-296 item (3). For each question this record gives (a) the question and what is built now, (b) the sources that bear on it, (c) the options, (d) a recommendation and (e) the exact change the recommendation makes. A closing section groups the changes into one corrective migration and orders the work by the notes' deadlines. **It decides nothing.** Every (d) is a recommendation. The executor decides, and a checker judges the decision. Nothing built, merged or applied is changed by this record.

**Labels.** **Doc** read in the source named, at `main_at`. **Inf** an inference. **Off** observed in this record's offline run (below), which is not a test result and counts for nothing. A number after a colon is a line at `main_at`. B = `plan/Ek_B_Veri_Modeli.md`; C = `plan/Ek_C_Testler.md`; P = `plan/DevOS_Kurulum_Plani.md`; W9 = `plan/work/W-C02-09.md`; EV2, EV8, EV13, EV14 = `evidence/C02/EV-C02-002_data_model_choices.md`, `…/EV-C02-008_design_addendum_roles_and_samples.md`, `…/EV-C02-013_w09_interface.md`, `…/EV-C02-014_w09_build.md`; CHK-n = `evidence/C02/checks/CHK-C02-n.md`; `job/` = `tests/C02/W-C02-07/job/`. The migrations are under `supabase/migrations/`: M09-02 `20261018203001_w09_private_helpers.sql`, M09-03 `20261018214501_w09_mission_need_decision.sql`, M09-04 `20261018230001_w09_work_effort.sql`, M09-05 `20261018235501_w09_claims.sql`, M09-06 `20261019010001_w09_relations.sql`, M09-07 `20261019030001_w09_knowledge_product_review.sql`.

**The state it starts from (Doc).** `main` at `d140797`: M09-01 to M09-07 merged and applied; M09-08 (the external effect) and M09-09 to M09-12 not yet committed. T-W07-N08 stops at its `-pre` line, since `record_eval_run` does not exist until M09-09. No merged test has a counted result for any function these questions touch.

**The offline run (Off).** A throwaway PostgreSQL 16.15 cluster in a user namespace, unix socket only, with the stand-ins of `scratchpad/m0903_run/setup.sql` unchanged and the 19 top-level migration files of this clone applied as `postgres` in name order. Two of them, W-C02-03's fixture files `20261012232112` and `20261012232113`, raised on the stand-in because it holds no row in `supabase_migrations.schema_migrations`; they define no function the checks call (**Inf**, from their names and error text). The checks ran in one transaction that was rolled back. Tokens were made at run time, held only in transaction-local settings and never printed. The cluster directory and the socket directory were deleted after the run. Scripts and output: `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/dec09_run/run.sh`, `…/dec09_run/checks.sql`, `…/dec09_run/out2.txt`. An earlier run, `…/dec09_run/out1.txt`, is superseded: my script cancelled the N-289 work item before its last two rows. Its other rows are the same as `out2.txt`'s. The rows cited below are `out2.txt`'s, by number.

**Independence.** The producer's own reading and the producer's own offline check. Not a verdict, and not independent of the build records it reads.

---

## 1. N-284: a widening that names the Mission's own decision again

**(a) The question, and what is built.** `revise_mission` accepts a widening of the scope (a new scope that does not lie within the current one) or a changed purpose only when the call names a Decision: `owner_authority` with `owner_authority_revision`, checked as `open_mission` checks them. The Decision must be of class `batu`, `answered` or `accepted`, with `answered_revision` equal to the revision named (M09-03:383-410). The widening rule itself is M09-03:426-435. It asks only that a Decision be named. It does not ask which one, so the Decision the Mission already rests on passes. Off, rows 12 to 14:
- `open_mission` on a `batu` Decision D1 answers `ok`.
- A widening that names no Decision is refused `mission_authority`.
- A widening that names D1 again answers `ok`, writes revision 2, and that revision's owner authority is the opening decision: `true`.

This is the same result as CHK-C02-086's case K-RM-widen-same-authority. The question is whether a widening must name a Decision other than the one the Mission rests on, and one answered after it.

**(b) Sources.**

| Source | What it says | What it requires here |
|---|---|---|
| B:106 | "A mission is opened or widened only by a decision that belongs to Batu." | The widening rests on a decision of his. Silent on whether the opening decision may serve again. |
| B:60 | "the rule that only a decision of Batu's opens or widens it is enforced from C02, and N29 tests its class part (PC-42)" | The rule has a part beyond the class, and N29 does not test it. |
| B:305 | "Once a decision is answered, no new revision of it is written: a change after the answer is a new decision that `supersedes` it (3.4)." | An answer is bound to what it answered. A scope beyond the one the opening decision authorised is a change after that answer, so it needs a new decision (**Inf**). It gives no database form. |
| B:306 | "an earlier decision is reopened only with new material information or a changed goal" | Reusing the opening decision for a new scope reopens it in effect, with no record of why (**Inf**). |
| B:307 | "a decision that opens or widens a Mission cannot be below `batu`"; "Where the database can decide, it enforces it" | The class part, and enforcement wherever the database can decide. |
| B:308 | From the hand-over until `answer_decision` exists (C06), an answer of Batu's "is recorded verbatim … in the installation's log event about the decision and is not applied: the decision stays `open`" | Before C06, no `batu` Decision becomes `answered` in the database after the hand-over. The only answered ones are those the ledger transfer copies, with their recorded dates. |
| C:146 (N29) | "… one below `batu` that opens or widens a Mission, are rejected" | The class only. |
| EV2:220 (DM-23 (a)) | "`open_mission` and `revise_mission` refuse unless `owner_authority` is a Decision of class `batu` that is answered or accepted" | The class and status part only. |
| EV13:88 (2.2, `revise_mission`, R1-4) | Reopening a closed Mission with `mission_authority` "needs a rule that tells a decision given for the reopening from the one the Mission already rests on, which no source gives" | The same gap. R1-4 chose to make a closed Mission terminal. |
| EV13:504-506 (16 (3)); EV14:485-488 (4.2 item 3) | The residual; the decision is the executor's note | — |
| CHK-086:9 (C3) | "B 3.1's 'widened only by a decision that belongs to Batu' is met only in form" | A note with a deadline before verdict (ii). |
| W9 "Not covered" (g) (W9:60); P Section 8 item 10 | "the functions check structure and authority, not content" | The limit: the database cannot read what a decision decided. |

**Silent:** no source gives a field that ties a Decision to the Mission it widens, and none gives an order of answers.

**(c) Options.**
- **A. Keep as built, with the residual stated.** Any valid `batu` Decision authorises a widening, the Mission's own included.
  - Changes: a dated line in EV13 2.2 and 16 (3). No migration, no test.
  - Risk: B:106 holds in form only. `devos_kurulum`, the only caller of `revise_mission` until C06, can widen the installation's own Mission on D-010.
  - Touches nothing else.
- **B. Not a Decision this Mission already rests on.** The Decision named must not be the `owner_authority` of any revision of this Mission, current or earlier. Otherwise `mission_authority`.
  - Changes: one condition at M09-03:426-435, read from `devos_private.mission_revision`; a dated correction of EV13 2.2 and 16 (3).
  - Tests: no merged case changes its outcome. `N29-pos-mis-widen-batu` names a fresh Decision (`job/w07_n29_impact_class.sql:583-586`). F06's recipe names `d2`, which is not the owner authority of its planted revision (`job/w07_f06_state_change_event.sql:495-510`). New negative cases are needed.
  - Residual: any other answered `batu` Decision still passes, even one unrelated to this widening. At the hand-over there are 16 answered `batu` D-records to choose from (EV-C02-005:95).
- **C. B, plus the order of answers.** The Decision named must also have been answered no earlier than the Mission's current revision was written: `decision.answered_at` ≥ the `created_at` of the current `mission_revision`. `answered_at` NULL is `could_not_check` (EV13 1 item 7 (ii)). Otherwise `mission_authority`.
  - Changes: the same place as B; it also reads `answered_at` (migration `20261014170203`:26) and the current revision's `created_at` (:75).
  - Effect: by B:308, no transferred Mission can be widened before C06 applies a new answer of Batu's. Such a widening would cite an answer given before the Mission's current state, and so not given for this change.
  - Tests:
    - F06's `revise_mission` recipe changes the purpose and names a planted Decision whose `answered_at` is NULL. `w07_plant` fills only NOT NULL columns, and `answered_at` is nullable. So `F06-event:revise_mission` and `F06-repeat:revise_mission` become `could_not_check`, and the recipe needs `answered_at` (ledger rule 3).
    - `N29-pos-mis-widen-batu` answers its Decision with `now()` in the same transaction that wrote the Mission's revision (`w07_set_status`, `job/w07_n29_impact_class.sql:194`). The two times are equal, so the case passes under "no earlier than" and would fail under "strictly later". The rule must therefore be ≥, or N29 must be revised.
  - Risks:
    - Two clocks are compared: the answer's time (copied by `transfer_decision`, later set by C06's intake) and the database's write time.
    - An answer given before a later narrowing revision is refused and has to be asked again. That is acceptable (**Inf**): the answer was to a state that no longer holds, which is DM-11's reasoning (EV2:164).
  - Touches C06: its intake must set `answered_at`, which B 3.17 already lists.
- **D. A stated tie.** A Decision must name the Mission it widens, as a Relation `about` or as a field. This is a new mechanism that no source asks for. Not recommended.

Who else is touched: W-C02-12 only closes the test Mission (status only), so it is untouched. M09-11's `transfer_mission` opens Missions and does not revise them, so it is untouched. C06 is touched under C. C10's purpose audit (B:60) is unchanged.

**(d) Recommendation (not a decision): C.**
- B:106 with B:305 point to a new decision for a widening. B:307 asks the database to enforce what it can decide.
- C is the strongest proxy the database can decide for "a decision given for this widening": a Decision this Mission has not used, answered no earlier than its current state.
- B alone leaves every older, unrelated `batu` Decision usable. Before C06 those are the only answered ones (B:308), so under B the installation could still widen its own Mission without a new answer from Batu.
- C makes a widening impossible until C06's channel applies a new answer, which is what B:308 already says of new answers.
- If a checker finds the time comparison unsound (the two clocks), B is the fallback, with its residual stated.
- R1-4's closed-Mission rule stays as it is. C would give the rule R1-4 found missing, but reopening is outside this note, and opening a new Mission is a route that already exists.

**(e) The change, if C is decided.**
- **Function:** `devos_api.revise_mission` (M09-03:196-491), in the `mission_authority` step after `stale_revision` (:426-435), on a widening or purpose change that names `owner_authority`:
  1. If the named Decision is the `owner_authority` of any `mission_revision` of this Mission: `mission_authority`, reason "owner_authority: a Decision this Mission already rests on cannot widen it (B 3.1, B 3.17)".
  2. Read `answered_at` with the Decision's row (it is already read `for share` at :386-387). NULL: `could_not_check`, reason "owner_authority: answered_at missing". Earlier than the current revision's `created_at`: `mission_authority`, reason "owner_authority: answered before the Mission's current revision (B 3.1)".
  - A narrowing, a status change, and an `owner_authority` sent without a widening keep today's checks.
- **Record:** a dated correction of EV13 2.2's `revise_mission` row and of 16 (3).
- **Tests that judge it** (the test designer's, under ledger rule 3, before verdict (ii)):
  - New cases in T-W07-N29: a widening that names the current owner authority gives `mission_authority` with the scope unchanged; one that names an earlier owner authority gives `mission_authority`; one that names a `batu` Decision answered before the current revision gives `mission_authority`; one answered after it is accepted; `answered_at` NULL gives `could_not_check`.
  - A break that removes the new condition must turn the first case red.
  - F06's `revise_mission` recipe sets `answered_at` on `d2`. **A merged test is revised (F06), and N29 gains cases.** Both happen before any result they judge.

---

## 2. N-286: `open_decision` reads the exam table but is not on N08's exempt list

**(a) The question, and what is built.**
- **Built.** `open_decision` (M09-03:737-946), called with `work_ref`, checks Rule O on the work item it ties the Decision to. On the `devos_sinav` branch only (M09-03:858), it reads `devos_private.eval_run` (:859).
- **The test.** T-W07-N08's reader finder (`job/w07_n08_exam_records.sql:381-392`) takes every `devos_api` function whose text names that table and is not in `n08_exempt()` (:283-286). It requires a role refusal of `devos_calisma`, `devos_denetim`, `devos_kurulum` and `devos_ci` (`N08-r-<fn>-<class>`) and acceptance with the exam token (`N08-rp-<fn>`).
- **Off, rows 1 to 11.** Ten `devos_api` functions name the table: the nine exempt ones, and `open_decision`, which is not exempt. Its only lines naming the table or `devos_sinav` are the role list and the `devos_sinav` branch of Rule O.
- **The consequence.** Once `record_eval_run` exists (M09-09), `N08-r-open_decision-devos_calisma` and `-devos_kurulum` are `bad`, since `open_decision` admits both classes.
- **The question.** Does N08's list gain `open_decision`, or does `open_decision` stop reading the table?

**(b) Sources.**

| Source | What it says | What it requires here |
|---|---|---|
| B:286 | `EvalRun` "is read only with" `devos_sinav`; "no function answers the working environment differently for an exam task than for ordinary work" | No class other than `devos_sinav` may read the table, and no answer to the working environment may depend on it. |
| C:125 (N08) | "Every access to the exam records with the working, audit, installation (`devos_kurulum`) and CI (`devos_ci`) tokens … is rejected" | The access must be refused. A function that reads the table only for `devos_sinav` gives those classes no access. |
| EV8:381 (5.1 (c) bound 1) | "No check made for a class other than `sin` reads EvalRun." | `open_decision` keeps this: the read is on the `devos_sinav` branch only. |
| EV8:462-471 (5.1, the finder's exemption) | "The finder exempts nine functions by name. The list is fixed here, before any result" (:464). The reason: "In each of these functions the build reads EvalRun's table only on the branch where the caller's class is `sin`" (:468) | The ground for an exemption, and the rule that the list is fixed before any result. |
| EV8:117-119 (1.7.1, Rule O) | Rule O is checked "in `relate` and `retract_relation` when the relation's `from_ref` is a work item"; "`sin`: only work items its exam link names" | A relation from a work item gets Rule O, and the `devos_sinav` clause reads the exam link. |
| EV13:91 (2.2, `open_decision`, R1-6, dated 2026-10-17) | With `work_ref`, the call writes a Relation `about` from the work item and "makes the checks `relate` makes for that relation (Rule O on the work item …)" | `open_decision` came to read the table through R1-6, five days after 5.1 fixed its list (2026-10-12). |
| EV13:97 (2.3, R2-6) | What Rule O reads: "for `sin`, the exam link in `devos_private.eval_run`" | The same. |
| EV13:538 (17 (3)) | "`admit_work` is not one of the functions T-W07-N08 exempts by name, so its text names no exam record" | The list is read as binding the build's text. |
| EV14:864; CHK-089:8 (C2 (c)), :95 (finding 7) | The finding. The first option "needs a dated revision of EV-C02-008 5.1, judged by a checker, as well as the test revision under ledger rule 3" | The route if the list changes. |
| T-W07-N08.md:25, :63, :121 | Nine exempt functions; 36 N08-x cases; the "Not covered" line on readers reached through a second function | What the test revision touches. |
| `tests/C02/W-C02-07/README.md:372`; ledger rule 3 | A test is revised before its first result; after a result, only under ledger rule 3 | No N08 result exists yet. |

**(c) Options.**
- **A. The list gains `open_decision`.**
  - Changes, with no migration:
    - a dated revision of EV8 5.1 (ten functions, with the reason), judged by a checker;
    - both copies of `n08_exempt()` (`job/w07_n08_exam_records.sql:283-286`, `job/w07_n08_exam_fact.sql:937-940`);
    - steps for `open_decision` with `work_ref` in `n08x_seq` (`job/w07_n08_exam_fact.sql:590`). Without them, `n08x_pair` reports `N08-x-open_decision-<class>` as `could_not_check`;
    - T-W07-N08.md:25 and :63 (ten functions, 40 N08-x cases);
    - optionally, an `EXF-pair-open_decision` in `n08x_pairs` (:917).
  - Risk: each exemption narrows the finder's reach. As for the nine, N08-x then compares the four classes' answers on an exam task and on an ordinary item, so the property the finder protects is still tested.
  - Touches: M09-09's producer, who runs N08; W-C02-13's N08 breaks; C05, which may change the exam's form (N-138).
- **B1. `open_decision` refuses `work_ref` for `devos_sinav` without reading the table** (`not_owner` on every work item).
  - Changes: a migration of M09-03 and a correction of R1-6.
  - Risk: it narrows what `devos_sinav` may do with no source asking for it, and it differs from `relate`, where `devos_sinav` may relate from its exam task under the same Rule O.
- **B2. Move the read into a `devos_private` helper.** `open_decision`'s text would then not name the table. This hides a known reader from the finder, which is exactly what T-W07-N08.md:121's "Not covered" line warns of. It defeats the test. Rejected.
- **B3. Drop Rule O on the tie.** This contradicts R1-6 and EV8 1.7.1. Rejected.

**(d) Recommendation (not a decision): A.**
- The exemption's stated ground (EV8:468) holds for `open_decision` exactly as it holds for `relate`: the table is read only on the `devos_sinav` branch (M09-03:858-859; Off rows 5 and 11).
- The function came to read the table through R1-6 (2026-10-17), after the list was fixed (2026-10-12). So the omission is a defect in the list's coverage, found before any N08 result. It is not a criterion changed after seeing a result, so criterion integrity holds (Appendix D, D4 item 5), and ledger rule 3 allows the revision.
- A keeps the protection, because N08-x judges the four classes' answers on `open_decision`.

**(e) The change.** No build change.
- A dated revision of EV8 5.1, judged by a checker.
- The test designer's revision of T-W07-N08, both job files and the specification, merged before M09-09's first commit.
- The tests that judge it: N08 part A (the finder now lists ten exempt functions) and part X (`N08-x-open_decision-cal`, `-den`, `-kur`, `-ci`).
- The break: 1.7.1's "Rule O reading the exam link for `cal`", applied to `open_decision`, must turn `N08-x-open_decision-cal` red. The test designer names the patch or adds it.
- **A merged test is revised under ledger rule 3**, before its first result.

---

## 3. N-289: an old-epoch claim keeps blocking its work item

**(a) The question, and what is built.** After the global authority epoch changes, a claim of the earlier epoch can produce no effect, and its holder can neither extend nor release it. It still counts as a live claim, so its work item stays unready until the lease runs out or `devos_denetim` revokes it.
- **What counts a live claim.** Six places count "an active claim whose lease has not run out" and read no epoch:
  - `ready_value` (M09-02:356-361);
  - `claim`'s `already_claimed` (M09-05:229, :237);
  - Rule C in `revise_work` (M09-04:539) and `cancel_work` (M09-04:969);
  - Rule C in `relate` (M09-06:363) and `retract_relation` (M09-06:606).
- **What stops a second claim.** The partial unique index `assignment_one_active_claim` (migration `20261014170203`:214) allows one active claim per work item.
- **What ends the old claim.** `check_claim` refuses `claim_epoch` (M09-02:189-191). `revoke_claim` does not check the epoch (EV13:586).
- **Off, rows 15 to 26**, after an owner revocation raises the epoch to 2:
  - `ready_value` is false, and `ready_works` does not list the item;
  - a new `claim` is refused `already_claimed`;
  - `release` and `heartbeat` with the old claim token are refused `claim_epoch`;
  - `devos_denetim`'s `revoke_claim` answers `ok`; after it, `ready_value` is true and a new `claim` answers `ok` with generation 2.
- **The question.** Does readiness ignore claims of an earlier epoch, or does the delay stand as a stated residual?

**(b) Sources.**

| Source | What it says | What it requires here |
|---|---|---|
| B:23 (principle 9) | "the claims and permissions of an old epoch cannot produce effects" | Met as built. In B, an effect is an operation's (B:160: "Every operation that produces an effect requires the claim token"; B 3.12), and holding readiness is not named (**Inf**). |
| B:158 | "If the time runs out, the claim becomes `expired` and the work item can become ready again"; `heartbeat` extends only a claim "made in the current global authority epoch" | The old claim lapses at most 30 minutes after its last `heartbeat`. |
| B:159 | `revoke_claim` "only `devos_denetim` calls it … The work item can then be claimed again at once" | A remedy that frees the item at once. |
| EV2:130 (DM-06 (a)) | "A lapsed claim counts as no claim for readiness … marked `expired` … by the `claim` that next takes the work item" | Lease only; silent on the epoch. |
| EV2:138 (DM-07 (b)) | "The lease sets how long a work item stays blocked after its claimant stops … a short lease fails safe, at the cost of a new claim" | The same kind of block, of the same length, already accepted for any stopped claimant. |
| W9:39 (point 4, "Parameters (PC-23)") | The record gives, for the lease, "the time it adds on the critical path (the longest wait before a stopped session's work item can be claimed again …)" | The epoch case must be stated. |
| EV13:266 (7, the lease row) | "none when `den` revokes it or the claimant releases it" | It does not name the epoch case, in which the claimant cannot release. Whatever is decided, this row needs a dated line. |
| B:477 (section 8, Lease) | "Decided for C02 to C05; read again in C06 with the liveness signal" | A natural point to read this again (N-214 item 2). |
| B:47; PC-41 | `revoke_env_token` "increments the authority epoch"; in `devos` no migration and no job calls it | In `devos`, an epoch change is an owner step or a restore (C09). It is rare. |
| C:101-103 (F08 (c)) | An epoch change after the claim: the effect is rejected; positive control: "an independent exploration work item can continue under another claim" | Met as built. |
| C:55-59 (F03, C09) | "A new claim opened in the new epoch can do the right work"; (d) "a claim that appears active in the restored database" is rejected | C09's (W9 "Not covered" (f)). Its restore design reads this question again. |
| EV13:110, :588 (2.4; 18 (4)); EV14:965, :1126 | Stated, not changed; the executor decides | — |
| CHK-091:104 (finding 10) | "Nothing is let through, and the cost is at most 30 minutes after the last heartbeat. The deadline … is adequate." | — |
| T-W07-F08, -DM07 (`job/w07_f08_recheck_at_effect.sql:488-489`, `job/w07_dm07_heartbeat.sql:403-404`) | The epoch case runs last: "it ends every claim of the old epoch" | No merged case claims again after an epoch change. No option changes a merged outcome. |

**Silent:** no source says whether a claim of an earlier epoch counts for readiness, for `claim`, or for Rule C.

**(c) Options.**
- **A. Keep as built, with the residual stated.** After an epoch change, each active claim holds its work item for at most 30 minutes after its last `heartbeat`, or until `devos_denetim` revokes it.
  - Changes: dated lines in EV13 7's lease row and in 2.4 / 18 (4). No migration, no test.
  - Reopened at C06 (the lease reread, N-214 item 2), at C09 (F03's restore design), or on an observed stall that matters.
- **B. A claim of an earlier epoch counts as lapsed.**
  - Changes, in all six counts:
    - `ready_value` (M09-02:356);
    - `claim` (M09-05:229), whose write block (:280-287) then also marks such claims `expired` with `claim_expired`, origin `rule`, the payload naming the epoch. That frees the unique index. The epoch is read before the live count is judged, still last in DM-01's lock order (B:472);
    - Rule C in `revise_work`, `cancel_work`, `relate` and `retract_relation`.
  - Scope: six functions in four merged migrations, best through one shared private predicate so that the six cannot drift apart. M09-08's effects reach readiness through `ready_value` and follow it.
  - Status: `expired` serves an epoch-ended claim, since B 3.5 gives no other state. The event's payload tells why.
  - Tests: new cases (readiness true and `claim` accepted right after an epoch change; Rule C ignores an earlier-epoch claim of another class), and a break that counts such claims again. No merged case changes its outcome.
  - Risk: more code changed after its verdicts (i).
- **C. `revoke_env_token` ends the active claims of the earlier epoch when it increments.** One owner-only function changes (M09-01), but:
  - it must lock the claims' work items and claims before the epoch row (DM-01);
  - a claim committed in the old epoch between those locks and the increment keeps today's behaviour;
  - C09's recovery must repeat it;
  - a `revoked` status written by the owner blurs B:159's "only `devos_denetim`".
  - Not recommended.

**(d) Recommendation (not a decision): A for C02, stated conditionally.**
- Nothing is let through: principle 9's "effects" holds.
- The block is of the kind and size DM-07 (b) accepted for any stopped claimant, and B:159 gives a remedy that frees the item at once.
- In `devos` an epoch change is an owner step (B:47, PC-41) or a restore (C09). Both are rare.
- B would change six functions in four migrations that already have their verdicts, for no C02 acceptance point that needs it.
- **From-scratch test (Appendix D, D1), disclosed:** designing afresh, B would be chosen. What favours A now is the cost of the change, not the quality of the design. The reopen points (C06's lease reread, C09's F03 design) are where the stall's real cost can be measured.
- **If** the executor counts the stall as material, or reads principle 9 as covering a claim that holds a work item, the change is B, not C.

**(e) The change, if A is decided.**
- No build change.
- EV13:266 (7, the lease row) gets a dated line: "After an authority epoch change, a claim of the earlier epoch cannot be released or extended and holds its work item until its lease lapses (at most 30 minutes after its last `heartbeat`) or `devos_denetim` revokes it: up to 30 minutes on the critical path of each work item claimed at that moment." This meets W9 point 4's "Parameters" for the epoch case.
- EV13 2.4 and 18 (4) are marked decided, with the reopen triggers.
- No test is needed. No merged test changes.
- If B is decided instead: the changes in (c) B, with the new cases added by the test designer to T-W07-F08 or T-W07-DM07 under ledger rule 3, before verdict (ii).

---

## 4. N-292: the walks' direction for `supports`, `challenges` and `part_of`

**(a) The question, and what is built.** `affected_entities` (M09-06:668-845) and `explain_paths` (M09-06:856-1138) treat every relation that is not retracted alike: `to_ref` is the record changed and `from_ref` the record affected (M09-06:775-817, :989-1036). Off, rows 27 to 38: for each of `supports`, `challenges`, `part_of` and `derived_from`, with a relation from y to z:
- a walk from y returns 0 records and `complete: true`;
- a walk from z lists y.

The question is the direction for each type.

**(b) Sources.**

| Source | What it says | What it requires here |
|---|---|---|
| B:149 | "When a supporting source goes stale, what it supports is not automatically counted as false; the sufficiency of the support falls back into re-evaluation." | `y supports z` is written from y to z, the subject-to-object reading every B 3.4 type has (x `derived_from` y; w `depends_on` d; a review `reviews` its target; `informed_of`: "the content of `from_ref` has been sent", B:144). So a change of the `from_ref` affects the `to_ref`, the opposite of what is built. |
| B:144 | The type list; `part_of` "(composite product)"; no direction for any type | — |
| B:391 (section 4, Relation) | "the result carries completeness information" | No direction. |
| C:64-67 (F04) | "All affected records are found with at least one explanatory path" | As built, a walk from a supporting source omits what B:149 says must be re-evaluated, and says `complete: true` (CHK-092:59-62, finding 4). |
| EV13:637-639 (19 (3)), with its dated line | The edge is "T-W07-F04's reading of `derived_from` ('a change of y affects x') … taken for every type" | The built rule and its residual. |
| CHK-092:7 (C1) | The decision "follows B:149 for `supports`, or a checker judges a reasoned departure from it" | — |
| B:226 (3.10, Assembly) | `working_assembly` is "the sequence of realized part revisions" | For `part_of`, a part's new revision changes the whole's working state: the `from_ref` (part) changed, the `to_ref` (whole) affected (**Inf**). |
| C:164 (K09, C08 and C11) | "A product whose parts stay old although the design changed is not counted as 'current'; the work items to be redone are opened" | For `part_of`, a change of the whole's design affects its parts: the `to_ref` changed, the `from_ref` affected, as built (**Inf**). |
| B:138 with B:135 | The ledger writes "an item is `part_of` its stage"; "work items whose basis has changed are taken into the candidate review set" | A stage's change bears on its items (as built), and an item's change bears on its stage's acceptance (the reverse) (**Inf**). |
| B:110 (3.2), B:196 (3.8) | `evidence_for` and `evidence_against`; `counter_evidence_searched` | For `challenges`, only an analogy with B:149 (**Inf**). |
| `job/` walk tests | F04 and K05 use `derived_from`; N08 part X uses `derived_from` and `depends_on`; F04 and REL use `about` (`job/w07_f04_affected_records.sql:268`, `:412`; `job/w07_k05_many_paths.sql:261`; `job/w07_n08_exam_fact.sql:639-812`; `job/w07_rel_relation_status.sql:328-333`) | No merged walk test uses `supports`, `challenges` or `part_of`. |

**Silent:** nothing decides `challenges`. For `part_of`, sources bear on both directions, and none decides between them.

**(c) Options.**
- **A. Keep as built for every type, as a reasoned departure from B:149.** No reason was found that outweighs B:149, and the departure claims `complete: true` on an omission. Not defensible on the sources.
- **B. A direction per type.**
  - `supports` and `challenges`: the `from_ref` changed, the `to_ref` affected.
  - `part_of`: both directions.
  - Every other type as built.
  - Changes: both walks' edge selection; a dated correction of EV13 19 (3).
  - Tests: new cases; no merged outcome changes.
  - Risk: for `part_of`, a walk from a part reaches its whole and then, from the whole, the other parts. That over-includes siblings, bounded by `max_records` and flagged by `complete`.
- **C. Reverse `supports` only.** It follows B:149 alone and leaves `challenges` and `part_of` as built, each with a stated residual: a walk from a challenge, or from a part, omits what it bears on.
- **D. Both directions for every type.** It never omits, but it turns the walk into a search of the connected component and departs from F04's reading of `derived_from`. Rejected.
- **E. An edge of an undecided type makes the result not complete.** Honest, but every graph holding such an edge then reads "not complete", which a review that needs a complete result cannot use (EV8:422: "G2 item 2 needs a complete result for a negative verdict"). Rejected.

**(d) Recommendation (not a decision): B.**
- `supports`: B:149 decides it.
- `challenges`: B:149's reasoning applies to counter-evidence; when it changes, the sufficiency of what it challenges falls back into re-evaluation. This is chosen, and it is an inference.
- `part_of`: both directions. Two sources point opposite ways (B 3.10 from the parts to the whole; K09 with B:135 and B:138 from the whole to the parts). Of the two possible errors, omitting an affected record under `complete: true`, or listing an extra one, only the omission breaks F04's positive control. The siblings' over-inclusion is stated as a residual for C08 (K09) to read again.

**(e) The change, if B is decided.**
- **Functions:** `devos_api.affected_entities` and `devos_api.explain_paths` (M09-06:668-1138). An edge is a pair (changed, affected):
  - (`to_ref`, `from_ref`) for `depends_on`, `derived_from`, `supersedes`, `uses`, `reviews`, `blocks_effect`, `about`, and `informed_of` when it is built;
  - (`from_ref`, `to_ref`) for `supports` and `challenges`;
  - both pairs for `part_of`.
- **What stays.** Retracted relations are not walked; stale ones are; a NULL `validity` makes the result not complete; hidden or missing records are neither listed nor walked through. The `max_depth` edge test, `explain_paths`' region and its depth-first search all use the same edge set.
- **One new form.** A relation whose `type` is NULL is partial input and makes the result not complete (EV13 1 item 7 (ii)). As built, the walks do not read the type.
- **Unchanged:** the role list, the answer, the error codes, the `devos:read` comment and N08's exemption of both functions.
- **Record:** a dated correction of EV13 19 (3).
- **Tests that judge it:**
  - New cases in T-W07-F04, the test designer's under ledger rule 3, before verdict (ii): `F04-dir-supports` (y `supports` x: a walk from y lists x, and a walk from x does not list y); `-challenges` the same; `-part_of` both ways; `-derived_from` as built; and `explain_paths` on each.
  - A break that restores one direction for every type must turn `F04-dir-supports` red.
  - F04, K05, N08 part X and REL run again. **No merged case changes its expected outcome. Adding cases is a revision under ledger rule 3.**

**Outside the note, reported:** `supersedes`, `blocks_effect`, `uses`, `reviews` and `about` keep the built direction. No source read for this record decides them.

---

## 5. N-296 (3): a Finding's status has no transition order

**(a) The question, and what is built.** `review_finding` (M09-07:282-470) moves a Finding to `reviewed`, `accepted_for_use` or `stale` from any current status (:344-374). The `not_recorded` gate and N09's rule apply on every move into `reviewed` or `accepted_for_use` (:376-436). Off, rows 39 to 46:
- `accepted_for_use` → `reviewed` → `stale` → `accepted_for_use` → `stale` → `reviewed`: each move `ok`;
- a `withdrawn` status planted as owner → `accepted_for_use`: `ok`;
- each move writes one `finding_reviewed` event (7 in all).

The question is whether to build an order, or to state why no rule is needed.

**(b) Sources.**

| Source | What it says | What it requires here |
|---|---|---|
| B:196 | `status` (candidate / reviewed / accepted_for_use / stale / withdrawn) | The states; no transitions (EV13:694; EV14:1645). |
| B:199, B:201 | N09's rule for a move to `accepted_for_use`; `not_recorded` "cannot move to `reviewed` or `accepted_for_use` until a review enters both" | Gates on entry, whatever the earlier state. Built (:376-436). |
| B:37, B:244 | Binding verdicts and acceptance only with `devos_denetim` | Every move is the audit environment's. `review_finding` admits `den` only (:320). |
| B:16 (principle 2) | Every state change has its event | `finding_reviewed` carries `previous_status` (:455-457), so the history is kept. |
| EV8:63, :74 (1.2) | `review_finding` "Moves a Finding to `reviewed` or `accepted_for_use` after review"; **Inf**: it "carries the review transitions" | Its moves are reviews. |
| EV8:344 (4 item 2) | "If W-C02-09's build gives it a transition that is no review (the writer's `withdrawn`), that transition needs its own row, or another function, before it is built" | `withdrawn` is the writer's, not a review transition. Silent on moves out of it. |
| B:418 (section 5) | "Stale record and link check \| Daily \| Maintenance work for stale findings" (C10) | The plan answers a stale finding with work on it, not with a relabel (**Inf**). Not built until C10. |
| EV13:80 (2.1, R2-8) | A literal in the function preferred to "a note binding the migration that adds a role class", because the note "rests on that migration's author reading a note, where the literal makes the database refuse by itself" | A precedent for building a refusal now rather than leaving it to a later author. |
| EV13:90 (2.2, `resolve_need`) | "a Need `dropped` or `superseded`: `invalid_field`" | A precedent for the code. |
| CHK-093:7 (C1 (c)) | "The note needs a decision or a stated reason that no rule is needed." | — |
| T-W07-N09.md:52 | "Other transitions into `accepted_for_use`, if the build has one besides `review_finding`: a case is added" | No merged test reads another transition. |

**Silent:** no source gives an order of a Finding's statuses.

**(c) Options.**
- **A. No order, with the reason stated.**
  - The reason: every move is the audit environment's binding judgement. The content gates apply to every entry, whatever the earlier status. A move back (`accepted_for_use` to `reviewed` or `stale`) narrows use and is the audit's to make. The events keep the history.
  - Residual (i): a `withdrawn` Finding can be moved back by `den`. That is unreachable in C02: no function writes `withdrawn` (`record_finding` writes `candidate` only, EV13 20 (1); `review_finding` refuses it as a target; `transfer_finding` writes `candidate`, B:201).
  - Residual (ii): a `stale` Finding can be accepted again at the same revision. That is the audit's judgement, and C10's stale check reads it again.
  - Changes: a dated line in EV13 20 (2). No migration.
- **B. A, plus one rule built now: `withdrawn` is terminal for `review_finding`.** A move of a `withdrawn` Finding is `invalid_field`.
  - Changes: one check in `review_finding`; a planted case; a correction of EV13 20 (2).
- **C. A full order.** `candidate` → `reviewed` → `accepted_for_use`; `stale` from any status; out of `stale` only at a newer revision; no move back.
  - No source gives it.
  - It blocks an audit correction (de-acceptance).
  - "Out of `stale` only at a newer revision" needs a record of which revision went stale, a mechanism no task asks for.
  - Rejected.

**(d) Recommendation (not a decision): B.**
- For the general case, A's reason holds: no source gives an order, and every move is `den`'s binding act with the gates applied on entry.
- The one move that is not a review is the revival of a Finding its writer withdrew. EV8:344 already places `withdrawn` outside `review_finding`. Building the refusal now, rather than relying on the author of the later function, follows R2-8's reasoning.
- If the executor wants no build change, the alternative is A, with the `withdrawn` rule carried as a dated line to EV8 section 4 item 2's carrier.

**(e) The change, if B is decided.**
- **Function:** `devos_api.review_finding` (M09-07:282-470). After the Finding is read and its status is known (after :357-360): if the status is `withdrawn`, refuse `invalid_field`, reason "finding: a withdrawn finding is not under review (EV-C02-008 section 4 item 2)". Nothing else changes.
- **Record:** a dated correction of EV13 20 (2), giving A's reason for the absence of any other order.
- **Tests that judge it:** a case the test designer adds, in T-W07-N09 or a short specification of its own, under ledger rule 3, before verdict (ii). A `withdrawn` status planted as owner; `review_finding` to each of the three statuses gives `invalid_field`, with the status unchanged and one refusal row each. A break that removes the check must turn the case red. **No merged case changes its outcome.**

---

## 6. One corrective migration, and the order of the work

**What can share one migration.** One file, for example `w09_rule_corrections`. Its version follows M09-08's, and it is committed before M09-09's first commit. It is class high (`supabase/migrations/`) and has its own verdict (i). It holds:
1. **N-288** (no behaviour change): `cancel_work`, `mark_stale` and `reopen_for_review` (M09-04:736-1172) replaced in the `ALIAS FOR $n` form.
2. **N-284**, if C (or B) is decided: `revise_mission` (M09-03:196-491).
3. **N-292**, if B is decided: `affected_entities` and `explain_paths` (M09-06:668-1138).
4. **N-296 (3)**, if B is decided: `review_finding` (M09-07:282-470).
5. **N-289**: nothing under A. Under B, `ready_value` (M09-02), `claim` (M09-05), `revise_work` and `cancel_work` (M09-04), `relate` and `retract_relation` (M09-06). `cancel_work` is then replaced once, for items 1 and 5 together.
6. **N-286**: no migration. A record revision and a test revision only.

Each function the file replaces:
- keeps its signature, since the merged breaks wrap functions by name and signature (EV13 10, "Signatures"; EV14:565);
- keeps its role literal (EV13 1 item 6 (b));
- takes the `ALIAS FOR $n` form, since N-288's reason applies to every function a break renames;
- has its grants written again (EV13 1 item 13);
- for the two walks, keeps its `devos:read` comment.

The file's checker runs again F04, K05, N08, N29, F06, ROC (with B-ROC-1 and B-ROC-2), N09 and REL, plus F08 and DM07 if N-289's option B is taken.

One file instead of four: the four changes are each small, and one apply and one verdict cover them. The cost is one verdict over several behaviours, met by one section per note in the build record. No reason was found to prefer separate files.

**The order the work follows, by each note's deadline.**
1. The executor decides the five questions from this record, and a checker judges the decisions (each note: "with a checker").
2. The record corrections, before any test is revised from them (`tests/C02/W-C02-07/README.md:372`: tests are filled from the record):
   - a dated section of EV13 for N-284, N-289 (the lease row), N-292 and N-296 (3);
   - a dated revision of EV8 5.1 for N-286;
   - judged by a checker.
3. **N-286's test revision** (N08's two job files and its specification), merged. **Deadline: before M09-09's first commit.** It does not depend on the migration.
4. The test designer's new cases for N-284 (N29, and F06's recipe under C), N-292 (F04) and N-296 (3), each shown on a stub, merged before the results they judge.
5. M09-08, as planned.
6. **The corrective migration**, with its verdict (i), merged and applied, `devos-test` before `devos`. **Deadlines:** before ROC's first result (N-288), and before W-C02-09's verdict (ii) (N-284, N-289, N-292 and N-296 (3)). Placing it right after M09-08 and before M09-09 puts it ahead of every counted result that W-C02-09's copies produce.
7. M09-09 to M09-12, the copies (W9 point 8), and verdict (ii).

---

## 7. Where a source decides, or bears on, what a note calls open

- **N-292.** The note says "For `challenges` and `part_of` no source fixes it." For `part_of`, B:226 (3.10, `working_assembly`) and C:164 (K09), read with B:135 and B:138, bear on both directions without deciding between them. For `challenges`, no source was found.
- **N-284.** EV13 R1-4 says no source gives a rule that tells a fresh decision from the one a Mission rests on. B:305 ("a change after the answer is a new decision") and B:60 ("N29 tests its class part") bear on it: the rule has a part beyond the class, and a widening needs a new decision. What no source gives is the database form.
- **N-289.** DM-07 (b) (EV2:138) already accepts this kind of block for a stopped claimant. W9 point 4 (W9:39) requires the record to state the wait on the critical path, and EV13 7's lease row (EV13:266) does not state it for the epoch case. That row needs a dated line under any option.
- **N-296 (3).** EV8:344 places `withdrawn` outside `review_finding`, which bears on moves out of it. B:418 (C10's stale check) bears on leaving `stale`, by inference.
- **N-286.** R1-6 (EV13:91) and EV8 1.7.1 decide that `open_decision` checks Rule O as `relate` does. With EV8:468's ground, they support the exempt-list option, which the note left open between two options.

## 8. Not done, and limits

- Nothing built, committed, pushed or applied. No live project was reached, and no connector was used.
- The research library was not consulted. These are questions of DevOS's own rule consistency, as EV8 section 4 item 10 said of the same kind of question.
- The offline run is the producer's own. It is labelled offline and counts for nothing. Two W-C02-03 fixture migrations raised on the stand-in, as described above.
- Rule C's count of an old-epoch claim (N-289) is read from the text (M09-04:539, :969; M09-06:363, :606), not observed in the run.

---

## 9. The executor's decisions (2026-10-19, L-378)

Technical decisions of the builder (working order section 1, principle 5), made from sections 1 to 8, each to be judged by a checker before anything is built from it. Sections 1 to 8 are kept as the producer wrote them.

1. **N-284: option C.** A widening of scope or a change of purpose must name a `batu` Decision that is not the `owner_authority` of any revision of this Mission and whose `answered_at` is not earlier than the `created_at` of the Mission's current revision (equal passes); otherwise `mission_authority`; a NULL `answered_at` is `could_not_check`. Reason: B:106 with B:305 ask for a new decision for a widening, and B:307 asks the database to enforce what it can decide; option B leaves every older, unrelated answered `batu` Decision usable, which before C06 (B:308) means the installation could widen its own Mission with no new answer of Batu's. Accepted consequence: no Mission can be widened in the database before C06 applies a new answer, which is what B:308 already says of new answers. Residual, stated: a `batu` Decision answered after the current revision for another matter still passes; the database cannot read what a decision decided (W9 "Not covered" (g)). The two clocks (`answered_at` as copied or set by the intake, `created_at` as written by the database) are compared as recorded; the checker is asked to judge that comparison.
2. **N-286: option A.** `open_decision` joins N08's exempt list, by a dated revision of EV-C02-008 5.1 and a test revision of T-W07-N08 (both job files, `n08x_seq`, the specification), with N08-x cases for `open_decision`; no migration. Reason: EV8:468's ground holds (the table is read only on the `devos_sinav` branch, M09-03:858-859); the read came with R1-6 after the list was fixed, and no N08 result exists, so the criterion is not changed after a result. Due before M09-09's first commit.
3. **N-289: option B, departing from the recommendation (A).** A claim of an earlier global authority epoch counts as lapsed in every count of a live claim (`ready_value`, `claim`'s `already_claimed`, Rule C in `revise_work`, `cancel_work`, `relate` and `retract_relation`), through one shared private predicate; `claim` marks such a claim `expired` (event `claim_expired`, origin `rule`, the payload naming the epoch) before it judges the live count, keeping DM-01's lock order. Reason: section 3 (d) states that a fresh design would choose B and that only the cost of the change favours A; plan 0.3 item 1 does not let quality be lowered for cost. Principle 9's "cannot produce effects" is read to cover holding a work item, since the old claim's only remaining effect is to keep the item from the new epoch's work. The cost is lowered by the corrective migration that already replaces `cancel_work` for N-288, and the shared predicate keeps the six counts from drifting. EV13 7's lease row gets its dated line in any case (W9 point 4).
4. **N-292: option B.** The walk's edge is (`from_ref` changed, `to_ref` affected) for `supports` and `challenges`, both directions for `part_of`, and as built for every other type; a relation whose `type` is NULL makes the result not complete. Reason: B:149 decides `supports`; `challenges` follows it by inference; for `part_of` the sources point both ways (B:226; C:164 with B:135 and B:138), and only an omission under `complete: true` breaks F04, so both directions are taken, the siblings' over-inclusion stated as a residual for C08 (K09) to read again.
5. **N-296 (3): option B.** No general order of a Finding's statuses, for section 5 (d)'s reason (every move is `devos_denetim`'s binding act, the gates apply on entry, the events keep the history); and `review_finding` refuses to move a `withdrawn` Finding (`invalid_field`), as EV8:344 places `withdrawn` outside it.
6. **The work, as section 6 orders it.** One corrective migration after M09-08 and before M09-09's first commit holds N-288's `ALIAS FOR $n` replacements and the build changes of items 1, 3, 4 and 5; N-286 needs none. Before the migration: a dated section of EV-C02-013 carrying items 1, 3, 4 and 5 (written after M09-08's producer, the file's current writer, has finished), the EV-C02-008 5.1 revision, and the test designer's revisions and new cases (N08; N29 and F06's recipe for item 1; F08 or DM07 for item 3; F04 for item 4; N09 or its own specification for item 5), each shown on a stub, merged before the results they judge.
