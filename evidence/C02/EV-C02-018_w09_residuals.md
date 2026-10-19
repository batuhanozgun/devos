---
id: EV-C02-018
title: "W-C02-09: the residual questions left to the executor before verdict (ii) (N-298, N-302 (3) to (6), N-303 (3), EV-C02-013 27 (10), N-304 (5)), with their sources, options and a recommendation each"
kind: evidence
status: decided (to a checker)
date: 2026-10-19
produced_by: "sections 1 to 15: producer agent a41351f02cf136dc0 (fresh-context subagent), named by the executor at filing; section 16: the executor (L-406)"
main_at: 23e2d22d09842eda08b7021aa867bdde4a3c3958
---

# EV-C02-018 · W-C02-09: the residual questions left to the executor before verdict (ii)

**What this is.** W-C02-09's build is complete and applied: M09-01 to M09-12 and the rule corrections are on `main` at `23e2d22`. Several notes on `plan/work/C02.md` leave a question "to be decided, with a checker: built (a migration) or a stated residual" to the executor, with a deadline before W-C02-09's verdict (ii). For each question, this record gives:
- (a) the question and what is built, with file and line;
- (b) the sources that bear on it;
- (c) the options, with what each does now and at C03 or W-C02-14;
- (d) one recommendation, with its reason;
- (e) for "built", the smallest change; for "stated residual", the risk, who carries it and until when.

Section 13 groups the recommended changes into one corrective migration and orders the work. Section 14 marks where a source settles a question; there it is not a choice. **This record decides nothing and builds nothing.** Every (d) is a recommendation. The executor decides, and a checker judges the decision.

**Labels.** As in EV-C02-017:
- **Doc**: read in the source named, at `main_at`.
- **Inf**: an inference.
- **Off**: observed in this record's offline probe (below). It is not a test result and counts for nothing.

A number after a colon is a line at `main_at`.

**Abbreviations.**
- Appendices and plan: B = `plan/Ek_B_Veri_Modeli.md`; C = `plan/Ek_C_Testler.md`.
- Work items: W9 = `plan/work/W-C02-09.md`; W14 = `plan/work/W-C02-14.md`.
- Evidence records: EV5, EV13, EV14 = `evidence/C02/EV-C02-005_ledger_transfer.md`, `…/EV-C02-013_w09_interface.md`, `…/EV-C02-014_w09_build.md`.
- Checker verdicts: CHK-n = `evidence/C02/checks/CHK-C02-n.md`.
- Migrations, all under `supabase/migrations/`:
  - W08-E = `20261014170202_w08_event_rejected_attempt.sql`;
  - W08-W = `20261014170203_w08_missions_decisions_needs_work.sql`;
  - W08-S = `20261014182601_w08_ledger_transfer_schema.sql`;
  - M09-05 = `20261018235501_w09_claims.sql`;
  - M09-RC = `20261019080001_w09_rule_corrections.sql`;
  - M09-08 = `20261019050001_w09_external_effect.sql`;
  - M09-10 = `20261019120001_w09_transfer_runs_events.sql`;
  - M09-11 = `20261019140001_w09_transfer_records.sql`;
  - M09-12 = `20261019160001_w09_transfer_copies.sql`.
- Test files: FN = `tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql`; `job/` = `tests/C02/W-C02-07/job/`.

**The offline probe (Off).**
- **Cluster.** A throwaway PostgreSQL 16.15 cluster in a user namespace, reached by unix socket only.
- **Schema.** The stand-ins of `scratchpad/m0903_run/setup.sql`, unchanged, and the clone's top-level migrations applied as `postgres` in name order. W-C02-03's two fixture files `20261012232112` and `20261012232113` raise on the stand-in, as they did for EV-C02-017, because it holds no migration-history row. Neither defines anything the probe reads.
- **P1 and P2** plant synthetic rows as owner on the real schema and time the built query forms.
- **P3 and P4** use labelled stand-in functions that copy the built forms: the key read and write of `prepare_operation`, and the closing check and hand-over write of the transfer group. P3 runs them on a scratch table with the same kind of unique key; P4 runs them on the real `devos_private.event`. Each uses two concurrent connections.
- **Clean-up.** No token was issued. The cluster and socket directories were deleted after each run (`[cluster directory deleted: yes]`).
- **Files.** Everything is under `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/res_run/`:
  - `run.sh` (SHA-256 `d51559716c9f2ca7fb26a9371ddb3dbf093878821ba8213cdda7aa3d4a84cd7c`);
  - `probe_scale.sql` (`27f3cda507bfabb09e66f33515019c647bbf4ca5ce32b6e36f57787b1cfe65f0`);
  - `probe_race_defs.sql` (`ce4b205b42a4f7d474b56f64d6628ca9cd84450c08c7f22b367f2c8eac312a8e`);
  - the output, `out4.txt` (`6c5876bce9aa01e79809686c9ef0baf5d63cf7ae771e52a3a8650751e05aa8c3`). Rows below are cited as `out4:n`.
- **Superseded runs.** `out1.txt` to `out3.txt` are superseded. In the first two, my planted rows broke the check `event_transferred_transfer_source` (W08-S:17-27). The third had a label with an unbalanced quote; its numbers are the same in kind.

**Independence.** This is the producer's own reading and the producer's own probe. It is not a verdict, and it is not independent of the build records it reads.

---

## 1. N-298 (1): the work item's `effect` field has no writer

**(a) The question, and what is built.**
- **The field.** `devos_private.work.effect` is `devos_private.work_effect` (`none`, `prepared`, `observed`, `unknown`), not null, default `none` (W08-W:105, :113). The view `work_current` exposes it (`20261014170205_w08_append_only_views_access.sql:56`).
- **No writer, no reader** (Doc, by a search of `supabase/migrations/` and `tests/`):
  - No function writes the field. EV13 21 (9) decided that `record_observation` does not touch the work item's axes (EV13:862). The producer's self-check `RO-work-axes-untouched` shows it (EV14:1735).
  - No function and no merged test reads the field.
- **Where the effect state is kept today.** Per Operation:
  - `operation.status` (M09-08:510-558, :857-861, :1051-1057);
  - the appended Observations;
  - `operation_state`'s `ever_applied` and `current_effect` (M09-08:1080-1160).
- **The question.** Which function sets the work item's axis, and when? Or does a stated reason say that the Operation's own state carries it?

**(b) Sources.**

| Source | What it says | Bearing |
|---|---|---|
| B:19 (principle 5) | A work item's execution, validity, acceptance and external-effect states are separate fields; there is no single "done" field | The axis exists and is separate. Nothing says who writes it. |
| B:122-129 (3.3) | WorkStanding's `effect`: none, prepared, observed, unknown | The values only. No transitions. |
| B:252-260 (3.12) | The Operation's own `status` (prepared / attempted / observed / conflicted / abandoned) and Observations | The effect state per Operation. Silent on how it rolls up to the work item. |
| C:91 (F07) | "'applied in the past', 'current now' and 'accepted' are separate questions" | `operation_state` answers the first two per Operation. |
| B:398 (section 4) | `prepare_operation`, `record_attempt`, `record_observation`: "Full intent; re-check at the moment of the effect" | No axis write is named. |
| EV13:862; EV14:1879 | No row of 2.7 and no function of B section 4 names a writer; this is open for the executor, "before any reader of the axis (C03's audit work, C08's release)" | The first reader is a later stage. |
| N-279 (1) (`plan/work/C02.md:474`) | No function sets `execution` to `finished`, `running` or `waiting`; C03's audit work needs it, "before C03's work list" | The same kind of gap on a sister axis, already carried to C03. |

**Silent:** no source gives an aggregation rule for a work item with several Operations. None says whether `not_applied` counts as `observed`.

**(c) Options.**
- **A. A stated reason, carried with N-279 (1).** In C02 the Operation and its Observations carry the effect state, and `operation_state` reads it. The work item's `effect` axis stays `none` and is not to be read until a stage defines its writer.
  - Changes now: a dated line in EV13 2.7. Nothing is built.
  - At C03: the design of the axis (aggregation over Operations, the event on the work item) joins N-279 (1)'s writer of `execution`, in C03's work list.
- **B. Build a writer now.** `prepare_operation` would move `none` to `prepared`. `record_observation` would move it to `observed` (on `applied` or `not_applied`) or to `unknown`, with an event on the work item.
  - It needs an aggregation rule that no source gives, for example the latest Observation of any Operation of the item.
  - It reverses EV13 21 (9)'s decided "the work item's axes are not touched".
  - It writes a field that nothing reads before C03.
- **C. Drop the column.** This departs from B 3.3. Rejected.

**(d) Recommendation (not a decision): A.**
- No reader exists in C02, so W9 point 2's "no state transition except through a function" is not touched: no transition of the axis exists.
- The rule that B builds would need comes from no source. Built now, it would be a guess fixed in a function, to be re-decided at C03 anyway.
- The gap is the same kind as N-279 (1), whose route (C03's work list, with a checker) already exists.
- **From-scratch test (D1):** designing afresh, I would still define the axis's writer together with its first reader, not before it.

**(e) The residual, if A is decided.**
- **Risk.** A reader written later that trusts `effect = none` for a work item with an applied Operation would be wrong. Nothing reads it now.
- **Who carries it.** The executor: a dated line in EV13 2.7 ("the work item's `effect` axis is not written in C02 and is not to be read; the per-Operation state is in `operation_state`"). The item goes to C03's work list with N-279 (1).
- **Until when.** Before C03's work list, and before any function or view reads the axis.

---

## 2. N-298 (2): two concurrent first uses of one new idempotency key

**(a) The question, and what is built.**
- **`prepare_operation`.**
  - The key read (M09-08:271-278) finds nothing while the first call is uncommitted.
  - The second call's insert then waits on the operation table's unique key. When the first commits, the insert fails with 23505.
  - The write block answers `write_failed` (M09-08:551-571; EV14:1770 `PO-key-taken-in-write`, :1891).
  - A retry then gets the repeat.
- **The transfer group.**
  - Ten functions take their key from S2's index alone (`event_transferred_key`, W08-S:36-38). Their key reads are M09-10:810 and :1316, M09-11:246, :672, :1145, :1603, :1870 and :2228, and M09-12:305 and :718.
  - EV13 27 (10)'s third bullet states the same residual for them (EV13:1346).
  - `begin_transfer_run`, `end_transfer_run` and `record_ledger_entry` already serialize their keys with advisory locks 9002 and 9003 (M09-10:180, :333, :1077). EV13 25 (2) explains why: "without it two concurrent first calls could both write a begun event".
  - `transfer_mission` also takes 9004 (M09-11:291), but only after its key read (:246), so it is in the list of ten.
- **Off, P3** (out4:198-208):
  - Without a lock: `A: ok written`, `B: write_failed (SQLSTATE 23505)`; B's retry `ok repeat`.
  - With a transaction-level advisory lock on the key, taken before the key read: `A: ok written`, then `B: ok repeat` once A commits. Under read committed the read after the wait is a new statement and sees A's row.

**(b) Sources.**

| Source | What it says | Bearing |
|---|---|---|
| B:257 (3.12) | "Same key and same full intent: the existing record is returned" | The second call has the same key and intent. As built, it gets an error instead of the record. |
| C:38 (F01, positive) | "The same key with the same full intent returns the existing record and produces no new effect" | The same. |
| B:259 | A delayed retry "is answered from the existing record and the real state, never accepted as a new operation" | Met: nothing is let through. |
| B:472 (section 8, concurrency) | Locks taken in one order; "Provisional: confirmed by C02's Concurrency test" | The Concurrency test (C:106-110) covers claims and cycles, not keys. |
| EV13 25 (2) (EV13:1181) | The run key is serialized by an advisory lock for exactly this reason | The house form exists. |

**(c) Options.**
- **A. A stated residual.** Nothing is let through. The second caller retries.
  - Risk at C03: an effect channel's client that reads `write_failed` as "not prepared" and takes a new key would leave two Operations for one intent. That is F01's failure class. The client must retry `write_failed` with the same key.
  - Carried by C03's effect-channel work.
- **B. Built: a transaction-level advisory lock on the key before the key read.**
  - `prepare_operation`: `pg_advisory_xact_lock(9006, hashtext(namespace || ':' || key))` at M09-08:271. It comes after `check_claim`'s DM-01 locks, so the order stays the hard-dependency lock, the work item, the claim, the epoch, then the key.
  - The ten transfer functions: `pg_advisory_xact_lock(9007, hashtext(kind || ':' || source_id))` before each key read.
  - Effect: the second call waits, then answers the repeat (or `conflict`). Off P3 shows this.
  - A hash collision only serializes two unrelated keys.
- **C. Catch 23505 in the write block and run the key comparison again.** The same answer, with more code per function. Not preferred over the house form.

**(d) Recommendation (not a decision): B.**
- B:257 and F01's positive control state the answer, and the built answer departs from them in one interleaving.
- The cost is one line per function. For the transfer group it is nearly free inside section 13's replacement, which replaces those ten functions anyway.
- It removes a hazard that would otherwise pass to C03's client design.
- If the executor builds no corrective migration, the fallback is A for the transfer group, whose only caller is the one transfer tool running in sequence. `prepare_operation` would still be worth its own one-line change (Inf).

**(e) The change.** As in (c) B. Signatures, role literals, the `ALIAS FOR $n` form and grants stay as they are. One shared form, so the lock ids are 9006 (Operation key) and 9007 (transfer key), after 9001 to 9005 (section 5).
- **Tests.** A two-connection case (the test designer's, under ledger rule 3): two first calls of one new key give exactly one record and, for the second, the repeat answer.
- **Break.** Removing the lock must turn it red: `write_failed`, as P3 shows without the lock.
- **Merged cases.** No merged case changes outcome (**Inf**, from the text: every merged case calls on one connection).

---

## 3. N-298 (5): a stale read set, and a repeat that keeps answering `ok`

**(a) The question, and what is built.**
- **The refusal.** Once an Operation's stored read set no longer holds, `record_attempt` refuses it with `read_set_changed` on every later call. The read set fails when:
  - the work item is revised (M09-08:777);
  - a hard dependency changes (:805);
  - an entry is at another revision (:837).
- **The repeat.** `prepare_operation` with the same key and intent answers `ok`, `repeat: true` and the stored `operation_status` (M09-08:300). This is by design: the repeat is judged before the revisions (EV13 21 (2), "Why the repeat comes before the effect class and the revisions", EV13:793).
- **The consequence.** The effect needs a new key.

**(b) Sources.**
- **B:259:** a retry "is answered from the existing record and the real state, never accepted as a new operation".
- **R2-9 (EV13 section 1 item 10):** the repeat is compared with the stored state before any check that the first call's own write would now fail.
- **F08 (C:97-104):** at the moment of the effect the read set is re-checked and the effect is rejected.
- **B 3.12:** gives `abandoned` and `conflicted`, which have no writer (N-298 (3)).

**(c) Options.**
- **A. A stated residual.** The caller prepares a new Operation under a new key, against the new state. The old record stays, as B:259 keeps every key's record.
- **B. Refuse the repeat** for an Operation that can no longer be attempted. This contradicts R2-9 and B:259 ("answered from the existing record"), since the refusal would be a check the first call's write would now fail. It is ruled out by the sources (section 14).
- **C. Answer the repeat with an extra key**, for example `attemptable: false`. A new answer form that no source asks for. It duplicates what `record_attempt` already answers.

**(d) Recommendation (not a decision): A.** The sources settle the repeat's answer (B:259; R2-9), and a new key is the correct way to re-prepare against a changed state (F08). Nothing is let through.

**(e) The residual.**
- **Risk.** A client that loops on the repeat never reaches an effect. This fails closed.
- **Who carries it.** C03's effect-channel work: its client handles `read_set_changed` by preparing anew under a new key. N-298 (3)'s owner, when `abandoned` gets its writer, considers an Operation refused `read_set_changed` as its first case; the repeat would then answer `abandoned` from the record.
- **Until when.** C03's first external effect through an Operation (N-298 (4)'s deadline).

---

## 4. N-298 (3) and (4): carried, confirmed

- **(3)** `conflicted` and `abandoned` have no writer, and no status refuses an attempt. Its owner is "the producer of that change (C03's effect channels, or a later W-C02 migration), read at its start". Its deadline is that change (`plan/work/C02.md:567`).
- **(4)** `expected_base` is stored but never re-checked. It is "carried to `plan/work/C03.md` at C03's stage start". Its deadline is before C03's first external effect through an Operation (`plan/work/C02.md:567`; EV13:852).
- **Doc.** `plan/work/C03.md` holds no line on either yet (searched for `expected_base`, `conflicted`, `abandoned`, `N-298`: no hits). That is consistent with "at C03's stage start". Both are carried by N-298's own text, with an owner and a deadline. They are not reopened here.

---

## 5. N-302 (3): a closed function's check against a concurrent `record_handover`

**(a) The question, and what is built.**
- **The closing check.** Every closed function checks `exists (… event_type = 'ledger_handed_over')` with a plain read: M09-10:172, :325, :479, :803, :1307; M09-11:239, :665, :1138, :1596, :1863, :2221. M09-12's two functions read it at :302 and :715 to choose their run rule and the mark's `after_handover`.
- **The hand-over.** `record_handover` writes the event, with S1's unique index as the backstop (M09-10:549-560; W08-S:30-31).
- **No lock orders the two** (EV13 25 (9), EV13:1217).
- **Off, P4** (out4:209-221):
  - Without a lock: a closed call that read no hand-over, waited, then wrote, committed after the hand-over (`B: … hand-over event 1, committed …25.045`, then `A: ok, event 2, committed …26.519`). Its event id (2) follows the hand-over's (1).
  - With a shared advisory lock in the closed call and an exclusive one in the hand-over: the hand-over waited for the closed call. The closed call's event is 1 and the hand-over's is 2, committed 5 ms later.
- **Inf, with the probe:** the interleaving is serializable as "the closed call, then the hand-over". `record_handover` reads nothing a closed call writes that would change its outcome: it needs only a begun run and the one installation Mission, and `transfer_mission`'s one-Mission rule keeps a second from appearing. So no record is written that the closing rule would refuse in some serial order.
- **What the race does leave.** A closed call's event can carry a higher id than the hand-over event, so the event order does not show which writes came first.

**(b) Sources.**

| Source | What it says | Bearing |
|---|---|---|
| B:397 | "After the `ledger_handed_over` event every one refuses except …" | The rule. "After" is not defined under concurrency. |
| EV5 3.4 (EV5:214) | `record_handover` runs after the hand-over pull request merges, which follows the transfer | The order of steps in time. |
| EV5 12 (EV5:325-326) | "The `ledger_handed_over` event is the switch" | The event is the cut. |
| W14:28 (point 2) | "✘ Looked for: every record that takes an exception … was written through the transfer's path before the `ledger_handed_over` event" | A check that W-C02-14's checker decides from the database, by the event's order. |
| EV13:1217 | The residual; "a mechanism no source asks for" | — |

**(c) Options.**
- **A. A stated residual.**
  - The working session records the hand-over only after `end_transfer_run`, the comparisons and the hand-over pull request's merge, with no transfer call in flight.
  - W-C02-14's checker counts the `transferred` marks that have a `run_id` and an id above the hand-over event's. The expected count is 0.
  - The window is one call, once.
- **B. Built: one advisory lock, 9005.**
  - The twelve functions that read the hand-over take it shared, first: the ten closed ones and M09-12's two.
  - `record_handover` takes it exclusive, first.
  - Effect: every committed write of the group either precedes the hand-over event in id and commit order, or sees it and refuses. A second concurrent `record_handover` then answers `handed_over` instead of `write_failed`.
  - Lock order: 9005 before every other lock of these functions. `record_handover` takes no other advisory lock, so no cycle forms (**Inf**).
- **C. `record_handover` requires a completed run.** This orders steps, not transactions, so the race stays. Not a fix.

**(d) Recommendation (not a decision): B, inside section 13's replacement.**
- With the lock, the hand-over event is a clean cut in the event order (Off P4), so W14 point 2's look "before the event" can be decided from the database. Without it, that look can misread a write from the race window.
- Once section 6 replaces these functions, B costs one line each.
- If the executor builds no corrective migration, A is a sound fallback: by the serializability argument no wrong record results, and the check in A finds the order anomaly.

**(e) The change.** At the top of each read block, before the closing check:
- the twelve functions: `perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);`
- `record_handover`: `perform pg_catalog.pg_advisory_xact_lock(9005, 0);`

Nothing else changes.
- **Tests.** A two-connection case (the test designer's): a closed call held open across a concurrent `record_handover` commits before it, and its event's id is below the hand-over's.
- **Break.** Removing the lock must turn the case red. Off P4 shows the red form.
- **Merged cases.** No merged case changes outcome (**Inf**: every merged case runs on one connection).

---

## 6. N-302 (4): input commits not compared with the run's

**(a) The question, and what is built.**
- **The run.** `begin_transfer_run` stores the run's `input_commit` (M09-10:121-129, :167).
- **The calls.** `transfer_event` and `transfer_artifact` check only the form of `transfer_source.input_commit` (M09-10:688, :1232). So do M09-11's six (for example M09-11:166) and M09-12's two (M09-12:182).
- **The run check.** The open-run check reads the run's events for their phase only (for example M09-10:832-846).
- **The hand-over.** `record_handover` writes the `input_commit` it is sent (M09-10:551-553) and checks only that the run was begun (:486-498).
- **The question.** Is either compared with the run's input commit?
- **The merged recipes** use one input commit per file (Doc):
  - FN:236, :253, :290 and :415 (`w14_hex('w14 input commit', 40)`);
  - `job/w07_f06_state_change_event.sql:341`, :345 and :744;
  - `job/w07_n02_decision_alternatives.sql:591` and :614;
  - `job/w07_n04_self_approval.sql:569` and :588.
  - So **Inf**: a comparison changes no merged outcome. Not run.

**(b) Sources.**
- **EV5 3.2 (EV5:203):** "A run is fixed by its **input commit**"; a resumed run "rebuilds the manifest from the same commit, checks its hash against the run's".
- **EV5 3.1 (EV5:198):** the creation event holds "the input commit" in `transfer_source`.
- **EV5 3.4 (EV5:214):** the hand-over block lists "the transfer run's ID, its input commit"; S1's payload (EV5:363).
- **W14:29 (point 3):** "The record names the transfer's input commit."
- **EV13:1218:** "W-C02-14's comparison reads both".

**(c) Options.**
- **A. A stated residual.** W-C02-14's comparison runs one query: every mark's `input_commit` against its run's, and the hand-over's against its run's. Expected: no difference.
  - Weakness: S2 allows one mark per source and S1 one hand-over. A wrong value already written cannot be replaced by a later call, so the comparison can find it but not mend it.
- **B. Built: compare at the write.**
  - Each of the ten functions that names a run, when it names one, compares `transfer_source.input_commit` with the begun event's `input_commit`. On a difference: `invalid_field`, reason "transfer_source: input_commit is not the run's input commit (EV-C02-005 3.2)".
  - `record_handover` does the same with its `input_commit`.
  - The exact repeat stays before the run check (R2-9), so a source written in an earlier run with the same hash still answers its record. That covers D-010 entered ahead and then found by the full run (EV5:297).
  - After the hand-over, the copies name no run and are not compared.
- **C. B for `record_handover` only.** It protects the one-time event and leaves the marks to A.

**(d) Recommendation (not a decision): B.**
- The design fixes a run by its input commit (EV5 3.2).
- The transfer's records are append-only and keyed once (S2; S1 for the hand-over). An error the database lets through is permanent, whereas a check at the write stops the run at the faulty call (EV5:198: "the run stops, listing it, never overwriting").
- No merged outcome changes (**Inf**).
- The run check already reads the run's events, so the comparison reads one more field.

**(e) The change.**
- **Ten functions** (`transfer_event`, `transfer_artifact`, the six of M09-11, `transfer_review`, `transfer_acceptance`): in the run check, select the begun event's `payload ->> 'input_commit'` with the phase counts. If it differs, refuse as in (c) B. If the begun event lacks it, `could_not_check` (partial; `begin_transfer_run` refuses such a form, M09-10:121-127).
- **`record_handover`:** the same, after its run check (M09-10:486-498), with the reason "input_commit: not the run's input commit (EV-C02-005 3.2)".
- **Tests.** T-W14-FN gains, per function, a call whose `transfer_source.input_commit` is not the run's (`invalid_field`, nothing written, one refusal row), and the same for `record_handover`.
- **Break.** Removing the comparison must turn them red. These are the test designer's, under ledger rule 3.

---

## 7. N-302 (5), with N-303 (3)'s first residual: transfer writes on records that are not the installation's

**(a) The question, and what is built.**
- **`transfer_event`** checks that its aggregate exists, and its revision when one is sent (M09-10:848-872). It checks the installation's Mission only for `ledger_state_row` (:873-886).
- **`transfer_relation`** checks its ends' existence and revisions, with no ownership (EV13 26 (4), :1258-1259; M09-11 around :1191).
- **The same migration already holds the rule for one function.** `record_ledger_entry` applies Rule O's `devos_kurulum` clause to its Work: `is_installation_mission`, NULL `could_not_check`, false `not_owner` (M09-10:1042-1070).
- **R2-2 decided the same question for `transfer_acceptance`'s target** (EV13:422; built at M09-12:969, :982).
- **Records that are not the installation's can exist in `devos` before the transfer.** The test Mission of W-C02-12 rests on D-010, which is entered ahead for it (EV5:297; EV-C02-002 DM-23).

**(b) Sources.**

| Source | What it says | Bearing |
|---|---|---|
| B:35 | `devos_kurulum`: "the ledger transfer …; after the transfer, the installation's own records" | The transfer's writes are the installation's. |
| EV5 2.3, 2.5, 3.3 | Events go on installation records; links run between transferred records | The design writes no other. |
| EV5 12 (EV5:322-326) | Title: "The transfer is not a way around the rule gate". "What stays open, named": before the hand-over, a session holding the token can call the group, and "W-C02-14's two-way comparison of IDs finds a record the input does not hold" | The design names the window and its carrier, the comparison. That catches a write whose source ID is not in the input, not a mis-attached one whose ID is. |
| EV-C02-008 1.7.1; EV13:1219 | Rule O lists `relate` and `retract_relation`, not the transfer | No rule binds it now. |
| EV13:422 (R2-2) | "`transfer_acceptance` checks whose record its target is … Reason: B:35, B:244, EV5:176. 'No rule' was weighed" | The same question, already decided for one function of the group. |
| W14:29, :33 (points 3 and 7) | IDs both ways; links compared at the mapped revision, including "a link to the wrong record" | Carriers after the fact, for links. For events' aggregates, no comparison is named. |

**(c) Options.**
- **A. A stated residual**, carried by W-C02-14's comparisons until the hand-over.
  - Risk: a mis-attached event or link on a record of the test Mission or of another class. It is permanent: events are append-only, and the source's key is consumed (S2), so the correct event cannot be written afterwards. `devos_kurulum` cannot retract a relation from another class's work item (Rule O; N-291's ROC case).
- **B. Built, in R2-2's form.**
  - `transfer_event`: a Work aggregate must lie under the installation's Mission (Rule O's `kur` clause, as M09-10:1042-1070); a Need's `mission_ref` must be the installation's Mission; a Mission must be the installation's for every kind (it is already so for `ledger_state_row`, the only kind on a Mission).
  - `transfer_relation`: each end of family Work, Need or Mission is judged the same way, and a Decision end by R2-2's Decision clause (its creation event `transferred` or `decision_opened` of class `devos_kurulum`, as M09-12:982). Ends of other families are not judged, stated.
  - NULL is `could_not_check`; false is `not_owner`. `ledger_state_row` keeps `invalid_field`.
- **C. "Each end is itself a transferred record"** (its creation event is `transferred`). Uniform, but a Verdict has no creation event of its own (27 (1): the Review's mark names it). It would need more reading of which families are ends (EV5 3.3). Not chosen.

**What B changes in merged tests (Inf, from the text; not run).**
- FN's `transfer_event` and `transfer_relation` recipes use planted Works under a Mission with no creation event (FN:389-390; EV13:1290, "which is accepted, since the function reads no Mission"). Under B they answer `could_not_check`.
- F06's `transfer_relation` and `transfer_event` recipes (`job/w07_f06_state_change_event.sql:760-783`) use work items under a Mission opened through `open_mission` (N-285 (1)'s revision). Under B they answer `not_owner`.
- Both files are in the carried test round now (N-304 (1); N-303 (1) revises F06's `transfer_relation` ends anyway). **So this decision must reach that round before its F06 and FN revision merges.** Otherwise a second revision follows.

**(d) Recommendation (not a decision): B.**
- R2-2 already answered this question for the group on B:35's ground and rejected "no rule". The same reason holds for an event's aggregate and a relation's ends.
- A wrong write cannot be mended (A's risk).
- The check exists in the same file (M09-10:1042-1070) and in M09-12 (:969, :982), so it is reused, not invented.
- **Its cost is test churn**, and the timing above keeps that to one revision. If the carried round has already merged, B still holds, at the price of a second revision. A remains the fallback, with W-C02-14's comparison extended to every `transferred` event's aggregate.

**(e) The change.**
- **`transfer_event`.** After the aggregate is found (M09-10:868), by family:
  - Work: its current revision's Mission, then `is_installation_mission`;
  - Need: `is_installation_mission(need.mission_ref)`;
  - Mission: `is_installation_mission`.
  - Codes as in (c) B; reason "aggregate_id: not a record of the installation's Mission (B section 2; R2-2's reading)".
- **`transfer_relation`.** After each end is found (M09-11 around :1191): the same per family, and the Decision clause for a Decision end.
- **Tests (the test designer's, under ledger rule 3).** In T-W14-FN:
  - an event on a Work under another Mission gives `not_owner`;
  - an event on a Work whose Mission has no creation event gives `could_not_check`;
  - a relation whose end is such a Work gives the same two answers;
  - the fixtures of the positive cases are moved under the installation's Mission;
  - F06's two recipes likewise.
- **Break.** Removing the check must turn the refusals red.

---

## 8. N-302 (6): run and entry lookups with no index

**(a) The question, and what is built.**
- **Indexes on `devos_private.event`:**
  - `(aggregate_type, aggregate_id)` and `(tx_id)` (W08-E:28-29);
  - the one-hand-over partial unique index (W08-S:30-31);
  - S2's key (W08-S:36-38).
- **Lookups the indexes do not serve:**
  - the run, `event_type = 'transfer_run' and payload ->> 'run_id' = …`: M09-10:182, :189, :338, :345, :490, :836, :1356; M09-11:275, :712, :1169, :1632, :1894, :2257; M09-12:346, :753;
  - the entry, `event_type = 'ledger_entry' and payload ->> 'entry_id' = …`: M09-10:1080.
- **Off, P1:**
  - 50,003 planted events: run lookup 17.3 ms, entry lookup 15.3 ms, by sequential scan (out4:32-50).
  - 500,003 events: 74.3 ms and 75.9 ms, by parallel sequential scan (out4:60-84).
  - The hand-over check uses the partial unique index: 0.049 ms (out4:87-95).
  - With two partial expression indexes: 0.043 ms and 0.034 ms (out4:98-123). Their sizes: 16 kB and 600 kB, beside a 391 MB heap (out4:102-104).

**(b) Sources.**
- **EV13:1220:** "a cost at the real transfer's thousands of events, not a correctness question".
- **EV5 9 (EV5:294):** the real run is "a few thousand writes".
- **B:397:** `record_ledger_entry` stays open after the hand-over and writes every later log entry.

**(c) Options.**
- **A. A stated residual.**
  - **Inf:** at the transfer's scale (under about 50,000 events, Off P1a) each call spends about 15 ms on the lookup, so over a few thousand calls about a minute in all.
  - After the hand-over, the run lookups end with the closed functions. The entry lookup grows with the event table for the life of the system.
- **B. Built: two partial indexes, no function changed.**
  - `create index event_transfer_run_idx on devos_private.event ((payload ->> 'run_id')) where event_type = 'transfer_run';`
  - `create index event_ledger_entry_idx on devos_private.event ((payload ->> 'entry_id')) where event_type = 'ledger_entry';`
  - The planner takes them for the built query forms as written (Off P1c).

**(d) Recommendation (not a decision): B, in section 13's migration.**
- It is two statements that change no function and none of the functions' answers.
- Its benefit lasts: `record_ledger_entry` is the group's long-lived function, and its lookup is linear in the event table (Off: about 15 ms at 50k events, about 76 ms at 500k).
- If no corrective migration is made, A, with the trigger "add the entry index when `record_ledger_entry`'s lookup is first seen above about 100 ms" (**Inf**: about 650k events at Off's rate). Carried by the executor until C03's work list.

**(e) The change.** The two statements above, with a comment each citing this section.
- **Tests.** None of any function changes. The migration's checker reads the catalog for the two indexes and runs `explain` on the two forms.

---

## 9. N-303 (3): the residuals of EV13 26 (8)

EV13 26 (8) (EV13:1281-1284) lists three residuals:

1. **"`transfer_relation` checks no ownership of its ends."** This is section 7's question. Recommendation: built, with `transfer_event`'s check.
2. **"The closing rule and the inputs not compared with the run are 25 (9)'s."** These are sections 5 and 6. Recommendation: built.
3. **"`transfer_work` judges the Mission revision named against the current one."**
   - Built: an earlier revision is `stale_revision`, as `admit_work` reads B 3.3 (EV13 26 (3), :1251; 17 (3)).
   - **A source settles that this is no conflict.** EV5 3.3's "every transferred record is revision 1" (EV5:208) is about the transferred record's own revision. The Mission revision a Work names is a reference to the Mission's current state (B 3.3, "Link to the mission revision"; principle 3).
   - So the only constraint falls on the transfer tool: it names the installation Mission's current revision. In the manifest's phase order the Mission precedes the Works (EV5:203), and nothing in the run revises it. Before C06 a widening is impossible anyway (N-284 C).
   - **Stated residual, nothing to build.**
     - Risk: a run made after an intervening `revise_mission` of the installation's Mission would be refused `stale_revision` and would stop, listing the call (EV5:198). It fails closed and the next run resumes.
     - Carried by W-C02-14's tool (it reads the current revision); until the hand-over.

---

## 10. EV13 27 (10): M09-12's residuals

EV13 27 (10) (EV13:1343-1347) lists four:

1. **"The copies are not checked against a verdict file."**
   - **A source settles it.** EV5 2.4 and 3.4 bind each copy to a verdict file through the merge gate's comparison, W-C02-14's `tools/`, not through a database rule. W14:28 plants the case "a copy whose verdict file is missing on `main` or differs from it by hash". B:396 says the copies "count as no audit verdict".
   - Stated residual. Risk: until W-C02-14's comparison exists, a copy the working session writes is bound to no file. Before the hand-over, copies come from the run's input commit (with section 6's check if built).
   - Who carries it: W-C02-14's point 2 and its tool. Until: W-C02-14's acceptance.
2. **"No staleness of a copy is judged."**
   - **A source settles it.** B:396: copies count as no audit verdict. `accept` refuses a copy (`verdict_missing`, EV13 20 (6)), so no rule reads a copy's staleness. C03's sample re-review of C00 to C02's acceptances reaches every copy (EV5:320; P:1016).
   - Stated residual, with no reader in C02. Carried by C03's re-review.
3. **"Two concurrent first calls of one key … `write_failed`."** This is section 2. Recommendation: built.
4. **"25 (9)'s 'inputs not compared with the run' holds for these two."** This is section 6. Recommendation: built, before the hand-over, when a run is named.

---

## 11. N-304 (5): CONC's fixtures grow without bound in `devos-test`

**(a) The question, and what is built.**
- **When the job runs.** `.github/workflows/migrate.yml` runs on every push to `main` (:13-16). Its test step runs after a clean comparison (:698-700), and its program step runs every `supabase/migrations/tests/*.py` (:828-850).
- **What CONC adds per run.** About 160 Works, one Mission, one Decision and about 320 revoked tokens; it raises the epoch by about 320. Source: CHK-C02-106 finding 7, an observation not re-run here. CONC's copy is not in `supabase/migrations/tests/` at `main_at` (removed by route (a), L-401), so the growth starts when N-304's later pull request copies it.
- **Pushes (Doc, from git).** From 2026-10-11 to `23e2d22` there are 168 first-parent commits on `main`; 22 of them touch `supabase/migrations/`.
- **Off, P2.** The inner query of `ready_works` (M09-05:86-95) over planted Works with no claims or dependencies:
  - 256 ms at 2,000 Works (out4:144-161);
  - 2,529 ms at 20,000 (out4:171-188);
  - linear, about 0.13 ms per Work.
- **Who reads the global set.** Three copied test files call `ready_works`: 6RG, F08 and N08, with 5, 3 and 10 mentions. The job's timeout is 30 minutes (migrate.yml:1016).

**(b) Sources.**
- **README 5.1 (b)** (`tests/C02/W-C02-07/README.md:190-201`): Concurrency commits state that other connections see, and revokes its tokens. Allowed.
- **EV-C02-001 O1** (`evidence/C02/EV-C02-001_migration_path.md:69`): "a path that resets `devos-test` is not designed here | Open: designed when first needed, through plan Section 14".
- **CHK-C02-106 finding 7:** "A bound or a reset plan for `devos-test` belongs in N-304".

**(c) Options.**
- **A. A bound inside CONC.** It cannot delete what it committed: revisions and events are append-only (DM-02; migration `20261014170205`). Closing its fixture Mission would hide its Works from readiness but not shorten the scan. Rejected as a bound.
- **B. A frequency bound.** The program step runs CONC only on a push that changes `supabase/migrations/`, which is about 13% of pushes by the count above (**Inf**: about 8 times less growth). A push that changes nothing there applies nothing, so CONC would re-test the same build.
  - Cost: a change to `migrate.yml`, the job that holds the credential (class high, its own verdict).
- **C. A reset plan for `devos-test`.** EV-C02-001 O1 places it under plan Section 14. It would also clear what `devos-test` holds for other items (its synthetic history, and whatever W-C02-12 places there). A design of its own, not a W-C02-09 decision.
- **D. A stated residual with a measured trigger, and B named as the remedy.**

**Inf, the projection.**
- At about 19 pushes a day and 160 Works per run, about 3,000 Works a day once CONC is copied.
- At that rate: 20,000 Works in about a week; 100,000 in about five weeks.
- At 100,000 Works: about 13 s per `ready_works` call, so about 2 to 4 minutes per job run over at most 18 calls.
- The 30-minute limit nears at around 10^6 Works, about a year at that rate, ignoring the job's other steps.
- The failure is a timeout, so `go` is `no` and nothing is applied: it fails closed and never lets anything through.

**(d) Recommendation (not a decision): D.**
- The growth slows tests but does not change any result: tests read deltas inside rolled-back transactions.
- The projection leaves weeks before any material slowing.
- Quality is not lowered by waiting. Only speed is at stake, and the trigger acts before the timeout.
- **From-scratch test (D1), disclosed:** designing afresh, I would run CONC only when the schema or its copies change (B). What favours D now is not cost alone: a change to the job that holds the credential is better made once, with the other changes N-304's later pull request already brings to the job's inputs. So B is named as the remedy, to be taken at the trigger or at the next change of `migrate.yml`, whichever comes first.

**(e) The residual.**
- **Risk.** The job's test and program steps slow down roughly linearly with CONC's runs. The end state is a timeout (`go` = no). It fails closed.
- **Who carries it.** The executor.
- **Trigger.** At each stage start (C03 first), and whenever the job's test and program steps together take more than 10 minutes (a third of the timeout; read from the run's step times), the executor takes B, or C through plan Section 14.
- **Until when.** C03's stage start, where it is read again.

---

## 12. Other notes with a "before W-C02-09's verdict (ii)" deadline that ask the executor

Listed with their state at `main_at` (Doc, from `plan/work/C02.md` and the log). Test work is not decided here.

| Note | What it asks the executor | State |
|---|---|---|
| N-279 (8), L-358 and L-359 | Verdict (ii) counts "permission denied to create temporary tables" in `devos`'s logs twice, about 12 h and 24 h after the apply, each with a counted positive control | Open. This is an observation the executor arranges for verdict (ii), not a decision. |
| N-284 | Widening rule | Decided, option C (L-378). Built in M09-RC (EV14:1901, :1925). Cases merged by #378 (L-389). Awaits verdict (ii). |
| N-289 | Old-epoch claim | Decided, option B (L-378). Built in M09-RC (`claim_live`, EV14:1923). Cases merged by #378. Awaits verdict (ii). |
| N-292 | Walk directions | Decided, option B (L-378). Built in M09-RC (EV14:1931). Cases merged by #378. Awaits verdict (ii). |
| N-296 (3) | Finding order | Decided, option B (L-378). Built in M09-RC (EV14:1932). Cases merged by #378. (1) and (2) are W-C02-10's. |
| N-298 (1), (2), (5) | — | This record, sections 1 to 3. (3) and (4) are carried (section 4). |
| N-302 (3) to (6) | — | This record, sections 5 to 8. (1), (2) and L-396 (c) are the test designer's. |
| N-303 (3) | — | This record, section 9. (1) and L-398 are the test designer's. |
| N-304 (1), (2), (4) | The later pull request: F06's copy, the refresh of T-W14-FN's copy, the three Data API programs, CONC's copy with its offline run after a model of the tokens step | (2) decided (L-400). (1) and (4) wait on the carried test round. These are actions, not open decisions. |
| N-304 (5) | — | This record, section 11. |
| N-300 (1) | A Rule O case for `open_decision` with the exam token, "or EV-C02-008 5.1 gets a dated qualifier, whichever the record supports" | Open. The choice is between a test case and a record qualifier. It is test work, so not weighed here. |
| N-291, N-293, N-297 (c) and (4), N-301, N-302 (1), (2), (c), N-303 (1), L-398, N-305 (1) | The test designer's revisions and cases, under ledger rule 3 | N-291 merged (#371); N-293 and N-294 merged (#374); N-297 (c) and (4) merged (#378); N-301 (1) to (4) merged (#380), with its thirteenth and fourteenth rules carried to the next round. The rest are in the carried round or open. |

---

## 13. One corrective migration, and the order of the work

**What can share one file.** One migration, for example `w09_transfer_corrections`, after M09-12. Class high, with its own verdict (i). It holds:

1. **N-298 (2)** in `devos_api.prepare_operation` (M09-08): lock 9006 on the key (section 2).
2. **The thirteen transfer functions** (`record_ledger_entry` excepted), each its merged text with only these changes:
   - **N-302 (3):** lock 9005, shared in the twelve that read the hand-over and exclusive in `record_handover` (section 5).
   - **N-302 (4):** the input-commit comparison in the ten that name a run, and in `record_handover` (section 6).
   - **N-298 (2) for the group:** lock 9007 on (kind, source ID) before each of the ten key reads (section 2).
   - **N-302 (5) and N-303 (3) item 1:** ownership in `transfer_event` and `transfer_relation` (section 7).
3. **N-302 (6):** the two partial indexes (section 8).

**How the file is made.**
- Fourteen functions are replaced in all. It is made as M09-RC was made: each replaced function is its merged text plus the named changes, generated and diffed per function (EV14:1909, `build.py`, file 66's per-function difference).
- Each replaced function keeps its signature, its role literal, the `ALIAS FOR $n` form and its grants written again (EV-C02-017 section 6).
- **Lock order.** 9005 first; then the function's own locks (9001 to 9004 as today); then the key lock (9006 or 9007, before the key read); DM-01's row locks keep their order.
- **Not in it:** N-298 (1) and (5), N-303 (3) item 3, EV13 27 (10) items 1 and 2, and N-304 (5). Each of these is a stated residual or reason.

**What its checker re-runs.**
- T-W14-FN, F06, N02 and N04 (part T), the callers of the transfer functions.
- F01, F05, F08, 6RG and 5C, the callers of `prepare_operation`.
- Every merged break that wraps a replaced function.
- The new cases of sections 2 and 5 to 7, including the two-connection cases.

**The order, by each note's deadline.**
1. The executor decides from this record, and a checker judges the decisions. Each note says "with a checker". Deadline: before verdict (ii).
2. **At once, if section 7's B is decided:** the carried test round is told before its FN and F06 revision merges, so that one revision carries both N-303 (1) and section 7's fixtures.
3. A dated section of EV13 states the decided forms, judged by the migration's checker, before the migration's first commit.
4. The test designer's cases for sections 2, 5, 6 and 7, merged before the results they judge.
5. The migration, with its verdict (i), merged and applied, `devos-test` before `devos`.
   - Deadline: before W-C02-14's first real transfer run (N-302's deadline for (3) to (5); L-396 (a)).
   - **Recommended: before W-C02-09's verdict (ii)**, so that verdict (ii) and T-W14-FN's counted result at the item's head judge the final transfer functions. W9 point 10 is the item's acceptance of these functions, and W14 says W-C02-14 "deploys no migration".
6. N-304's later pull request (the copies), then verdict (ii).

---

## 14. Where a source settles, or bears on, a question

**Settled by a source (not a choice):**
- **N-298 (5):** B:259 and R2-9 fix the repeat's answer as the record's. Refusing the repeat is ruled out, and the residual is the design (section 3).
- **N-303 (3), third residual:** EV5 3.3's "revision 1" is the record's own revision; the Mission revision named is a reference (B 3.3). There is no conflict (section 9).
- **EV13 27 (10) items 1 and 2:** EV5 2.4 and 3.4 place the file binding in the merge gate (W14 point 2), and B:396 makes copies count as no audit verdict (section 10).
- **N-298 (3) and (4):** carried by the note's own text, with owner and deadline (section 4).

**Borne on by a source, still a choice:**
- **N-298 (2):** B:257 and F01's positive control state the answer that the built function departs from under concurrency (section 2).
- **N-302 (3):** B:397 and W14 point 2's "before the event" look (section 5).
- **N-302 (4):** EV5 3.2, "A run is fixed by its input commit" (section 6).
- **N-302 (5) and N-303 (3) item 1:** B:35 with R2-2's decision for the same group point one way. EV5 12's "What stays open, named" accepts the window with the comparison as its carrier (section 7).
- **N-304 (5):** EV-C02-001 O1 puts a reset under plan Section 14 (section 11).

**No source:** N-298 (1)'s writer (section 1) and N-302 (6)'s indexes (section 8).

## 15. Not done, and limits

- **Nothing built, committed, pushed or applied.** No live project was reached; no connector, Supabase project or GitHub call was used. No token was issued, held or written.
- **The probe is the producer's own and counts for nothing.**
  - P3 and P4 run labelled stand-ins of the built forms, not the functions.
  - P2 plants Works with no claims or dependencies, so its per-Work cost is a lower bound.
  - CONC's per-run counts are CHK-C02-106's, not re-run.
- **Inferences that were not run.** "No merged outcome changes" for sections 2, 5 and 6, and the outcome changes named for section 7, are inferences from the test text.
- **The research library was not consulted.** These are questions of DevOS's own rules, plus PostgreSQL behaviour that the probe settles.
- **The clone `td09` was not used.**

## 16. The executor's decisions (2026-10-19, L-406)

Technical decisions of the builder (working order section 1, principle 5), made from sections 1 to 15, each to be judged by a checker before anything is built from it. Sections 1 to 15 are kept as the producer wrote them.

1. **N-298 (1): a stated reason, carried to C03.** The Operation and its Observations carry the effect state; nothing reads the work item's `effect` field and no source gives a roll-up rule (section 1). Carried to `plan/work/C03.md` at C03's stage start, with N-279 (1); until then the field stays `none` and nothing may read it as the effect's state.
2. **N-298 (2): built.** An advisory lock on the key before the key read, in `prepare_operation` and in the ten transfer functions keyed by S2 (section 2), so a concurrent first use gets the repeat answer B:257 states.
3. **N-298 (5): a stated residual, settled by a source.** B:259 and R2-9 fix the repeat's answer as the record's; the caller takes a new key (section 3). Carried by C03's effect channel with N-298 (3) and (4).
4. **N-298 (3) and (4):** confirmed carried as their annotation says (section 4).
5. **N-302 (3): built.** Lock 9005, shared in the twelve functions that read the hand-over and exclusive in `record_handover` (section 5), so the hand-over is a clean cut in the event order that W-C02-14 point 2's "before the event" look needs.
6. **N-302 (4): built.** `invalid_field` when a run-naming function's or `record_handover`'s input commit differs from the run's (section 6): an event cannot be mended after it is written.
7. **N-302 (5) with N-303 (3) item 1: built, in R2-2's form** (section 7 (c) B, (e)). Reason: R2-2 decided the same question for the group on B:35's ground; a mis-attached event or link is permanent. The cost, a second revision of T-W14-FN's and F06's recipes after the carried round (#384), is accepted: that round is checked and nearly merged, and its revisions are needed in any case; the new fixtures and cases come in the next test round, merged before the migration.
8. **N-302 (6): built.** The two partial indexes of section 8; no function changes.
9. **N-303 (3): items as section 9 states; item 3 a stated residual settled by a source** (EV5 3.3's "revision 1" is the record's own).
10. **EV-C02-013 27 (10): items 1 and 2 stated residuals settled by sources** (EV5 2.4 and 3.4, B:396); items 3 and 4 by decisions 2 and 6.
11. **N-304 (5): a stated residual with a measured trigger** (section 11 (e)): at C03's stage start, and whenever the job's test and program steps together take more than 10 minutes, the executor takes the frequency bound (B) or a reset plan through plan Section 14; B is also taken at the next change of `migrate.yml`, whichever comes first. Carried by the executor.
12. **The work, as section 13 orders it, with one change.** One corrective migration (`w09_transfer_corrections`, after M09-12) holds decisions 2, 5, 6, 7 and 8. Before it: a dated section of EV-C02-013 stating the decided forms; the test designer's next round (cases with breaks for decisions 2, 5, 6 and 7, the two-connection cases among them; the fixtures of section 7 moved; N-305 (1)'s cases; the one-Mission lock under two sessions, N-303's L-403 annotation), merged before the results they judge. Then the migration and its verdict (i), merged and applied, `devos-test` before `devos`; its pull request also makes N-304's later copies (F06, CONC, T-W14-FN refreshed, the three Data API programs), so that each copy is its staged file on the final build. Deadline: before W-C02-09's verdict (ii). The change from section 13's order: the carried round (#384) merges first, without section 7's fixtures (decision 7's reason).

*[Dated line, 2026-10-19, L-407, CHK-C02-110 C3: decision 12 is changed in one respect. The job's run on a pull request's merge is also the first result of every copy that pull request adds; a failing copy sets `go` to `no`, so the migration would be applied to `devos-test` and not to `devos`, and N-304 (2)'s premise ("stops nothing already applied") would not hold. So the corrective migration's pull request makes only the copies already shown passing offline on the final build (F06's copy and T-W14-FN's refreshed copy, each its staged file, run by the migration's checker), and the four first-result copies (the three Data API programs and CONC) come in a separate pull request after the corrective migration is applied to both projects, carrying no migration. If one of those four fails in the job, nothing new is withheld from `devos` (that run applies nothing), and the failing copy is fixed by the test designer or removed, with a checker, before verdict (ii). Decision 7's "nearly merged": #384 merged before this record's checker ran (CHK-C02-110 finding 8).]*

