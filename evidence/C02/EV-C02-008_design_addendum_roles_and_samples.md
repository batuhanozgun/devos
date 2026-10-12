---
id: EV-C02-008
item: "W-C02-05 and W-C02-04 (a dated addendum to their accepted records EV-C02-003 and EV-C02-002; gaps found by W-C02-07; for W-C02-09 and W-C02-10)"
kind: design
title: "Design addendum: permitted role classes for ten C02 functions with no row (N-256), and DM-41's trigger against the database's own sample Reviews (W-C02-07 Group B, open 1)"
date: 2026-10-12
main_at: 11feac5
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3)"
sources:
  - "plan/Ek_B_Veri_Modeli.md at main 11feac5: principles 1, 2, 3, 4, 8 and 12; section 2 (lines 35 to 48); 3.3 (lines 120 to 138), 3.4 (lines 142 to 150), 3.5, 3.8 (lines 196 to 204), 3.10, 3.11 (lines 232 to 248), 3.13 (lines 264 to 270), 3.15 (line 286), 3.17 (line 308), 3.18, 3.23 (line 344); section 4 (lines 383 to 408); section 5 (lines 428 to 430); section 8's table of choices. Read 2026-10-12."
  - "plan/Ek_C_Testler.md at 11feac5: C0; F04, F05, F06, F08, Concurrency; N01, N03, N04, N08, N09, N25, N28, N29; K05. plan/Ek_G_Isleyis_Kurallari.md G2 item 1 (line 23) and G5 item 1 (line 60). plan/DevOS_Kurulum_Plani.md at 11feac5 lines 274, 623, 710, 841, 1002. Read 2026-10-12."
  - "evidence/C02/EV-C02-003_identity_chain_and_environments.md (W-C02-05, accepted on CHK-C02-014): sections 4.1 to 4.5, 5.2, 15, the names line and the terms; evidence/C02/EV-C02-002_data_model_choices.md (W-C02-04): DM-01, DM-06, DM-07, DM-08, DM-19, DM-23, DM-24, DM-29, DM-31, DM-35, DM-36, DM-41 (line 304) and sections 5, 6 and 13; evidence/C02/EV-C02-004_reconciliation_decisions.md part 1 (head); evidence/C02/EV-C02-005_ledger_transfer.md (searched for DM-41, N28 and 'same transaction'; lines 176, 203, 367). Read 2026-10-12."
  - "plan/work/W-C02-08.md, W-C02-09.md (points 2 to 8) and W-C02-10.md (points 2, 3 and 5) at 11feac5; plan/work/C02.md notes N-244 to N-258, N-256 in full. Read 2026-10-12."
  - "W-C02-07's test files, unmerged, read only for what they assume, in the executor's scratch clone (scratchpad/c04/tests/C02/W-C02-07/): T-W07-5B_authorization_matrix.md and T-W07-N28_verifier_does_not_repair.md in full; README.md section 8 (lines 355 to 377); the interface and token lines of T-W07-N09, T-W07-F04, T-W07-F05, T-W07-F06 and T-W07-6RG; the 'Phase C' lines of T-W07-N01, T-W07-5D and T-W07-T31; TABLES.md G18. Read 2026-10-12."
  - "plan/Ek_D_Dusunme_Protokolleri.md section 2 item 3 and section 3 (D1 to D8), for this producer's discipline answers (reported in its final message, not here)."
claim: "design from the plan, the accepted C02 design records and the unmerged test files' stated assumptions; nothing built, run or observed on a platform; not independently tested; a producer's proposal for a fresh checker to judge"
---

# EV-C02-008 · Design addendum: roles for ten C02 functions, and DM-41 against the database's own sample Reviews

**What this is.** Two gaps in C02's accepted designs, found while W-C02-07's test designers wrote the tests, need a design decision before W-C02-09 and W-C02-10 build the functions. Section 1 decides the permitted role classes of the ten functions N-256 names, which EV-C02-003 §4.1 has no row for, and says what happens to the five matrix rows whose functions Appendix B section 4 does not name. Section 2 decides how EV-C02-002 DM-41's trigger and the database's own `sample` Reviews coexist. Section 3 lists what changes elsewhere, with the plan text proposed for plan Section 14; section 4 what stays open. The decisions are technical, the builder's (working order section 8): none needs money, touches Batu's accounts or conflicts with his decisions. Neither accepted record is rewritten: each gets one dated line pointing here. This record is not a verdict and writes no test and no build.

**Labels.** **Doc** documented in the plan or an accepted record, read at `main` `11feac5` on 2026-10-12. **Inf** inference. B = `plan/Ek_B_Veri_Modeli.md`, C = `plan/Ek_C_Testler.md`, G = `plan/Ek_G_Isleyis_Kurallari.md`, P = `plan/DevOS_Kurulum_Plani.md`; "B:36" is a line at `11feac5` (B's lines 35 to 48 are the same as at `560bcab`, which EV-C02-003 cites). EV2 = EV-C02-002, EV3 = EV-C02-003. "§4.1" is EV3's matrix; "row 2" is its row "Need and decision records; opening work other than missions". The role classes are written `cal` (`devos_calisma`), `den` (`devos_denetim`), `sin` (`devos_sinav`), `kur` (`devos_kurulum`), `ci` (`devos_ci`) and `bak` (`devos_backup`), as T-W07-5B writes them.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `11feac5d1db15475bf2b773fd1b90742ded86e0e` (PR #296) |
| Deployment configuration | Nothing deployed: a design. Written by a fresh-context producer subagent in a scratch clone at that commit, branch `claude/c02-design-addendum` |
| Criterion version | The executor's task for this addendum (2026-10-12); N-256 on `plan/work/C02.md` at `11feac5`; W-C02-07 Group B's open 1 as T-W07-N28 ("Not covered") and the README section 8 state it |
| Input | The sources in the front matter |
| Actual observation | None |
| Raw evidence ID | This record |
| Independence level | Same session, fresh-context subagent (declared, Ek A 5.3). Shared with the earlier producers: model lineage and the plan's text; not their working notes |

## 1. Gap 1: ten functions with no row of permitted role classes (N-256)

### 1.1 The rule for each cell

As §4.1's: the row is the function's role gate. A role class not listed is refused, never given a default (plan 6.2; Section 8 item 14), and is recorded as DM-19 says. A qualifier in a ✔ cell ("its exam tasks only", "the installation's own") is a check after the role gate, as T-W07-5B already reads §4.1's qualifiers ("Two readings stated"); it is not part of the role list. Where a function takes a claim token, S8 line 2 (EV3 §4.3) applies on top of the row. Each refused class is tied to the "Cannot" line of B section 2 that refuses it; where no "Cannot" line names the function, the refusal rests on §4.1's rule (no "Can" line lists it), and the record says so.

### 1.2 The ten rows

To be read as additional rows of §4.1's matrix (columns as there).

| Function (B section 4 group, line) | What it does | `cal` | `den` | `sin` | `kur` | `ci` | `bak` |
|---|---|---|---|---|---|---|---|
| `ready_works()` (Readiness and claim, B:390) | Lists the work items that are ready now, computing lease expiry; `claim` re-checks the same conditions (B:132; B 3.5; DM-06) | ✔ | ✔ its review work | ✔ its exam work | ✔ the installation's work items | ✘ | ✘ |
| `relate` (Relation, B:391) | Writes a typed relation; a hard `depends_on` changes readiness and is cycle-checked (B 3.4; DM-01) | ✔ | ✘ | ✔ its exam tasks only, as ordinary work | ✔ the installation's own records | ✘ | ✘ |
| `retract_relation` (B:391) | Sets a relation's `validity` to `retracted` (B 3.4) | ✔ | ✘ | ✔ its exam tasks only | ✔ the installation's own records | ✘ | ✘ |
| `affected_entities(root, limits)` (B:391) | Returns the unique affected records, one explanatory path each, with a completeness flag; records linked to an exam are hidden from every class but `sin` (G2 item 1; F04; DM-35) | ✔ | ✔ | ✔ | ✔ | ✘ | ✘ |
| `explain_paths(root, target, limits)` (B:391) | Returns bounded paths on explicit request, with a completeness flag (G2 item 1; F04 (d); DM-35) | ✔ | ✔ | ✔ | ✔ | ✘ | ✘ |
| `revise_work` (Work, B:389) | Writes a new revision of a work item, with its reason (principle 3; B:120 `mandatory_needs` "revised only with a new work revision"; F05 (c)) | ✔ | ✘ | ✔ its exam tasks only | ✔ the installation's work items | ✘ | ✘ |
| `mark_stale` (B:389) | Sets a work item's `qualification` to `stale` when its input changes; the old output is kept (B:134) | ✔ | ✘ | ✔ its exam tasks only | ✔ the installation's work items | ✘ | ✘ |
| `cancel_work` (B:389) | Sets a work item's `execution` to `cancelled`; a late result is kept as a candidate (B 3.3's axes; B:136) | ✔ | ✘ | ✔ its exam tasks only | ✔ the installation's work items | ✘ | ✘ |
| `reopen_for_review` (B:389) | Takes work items whose basis changed into the candidate review set, without cancelling them (B:135; G5 item 1) | ✔ | ✔ | ✔ its exam tasks only | ✔ the installation's work items | ✘ | ✘ |
| `review_finding` (Knowledge, B:393) | Moves a Finding to `reviewed` or `accepted_for_use` after review; refuses `accepted_for_use` for changeable information undated or with only secondary sources (B:196, B:199, B:201; N09) | ✘ | ✔ | ✘ | ✘ | ✘ | ✘ |

### 1.3 Each row's sources, refusals and inferences

| Function | Allowed, and the source | Refused, and the "Cannot" line (or §4.1's rule) | What is inference |
|---|---|---|---|
| `ready_works()` | The classes that may `claim`, with §4.1's qualifiers: `cal` (B:36 "claiming"), `den` (§4.1's `claim` row, "its review work"; EV2 section 3 row 2.9: C03's audit sessions claim their review work items), `sin` (§4.1, "its exam work"), `kur` (B:35 "work items and claims on them"). Doc: B:132 ties readiness to the claim ("`ready` is the momentary result of a query; the claim operation re-checks the same conditions"), and B:390 groups them | `ci`: no "Cannot" line names it; B:40's "Can" lists `ci`'s reads (review verdicts, decisions, current authority and epoch, fingerprint matches), and readiness is not one; EV3 §5.2 ("It reads only what the checks need"); the same ground as §4.1's `competence_summary` row ("not among B:40's reads"). `bak`: B:41 "Read only; only the `mark_exported` function"; "Cannot: Every other write"; as §4.1's `competence_summary` row | **Inf:** that the row follows `claim`'s (a class that may claim may ask what is ready to claim; one that may not claim has no use for it); `ci`'s refusal (a C03 check that needs readiness reopens it, 1.6) |
| `relate`, `retract_relation` | Row 2's classes, since a relation records how the records they open stand: `cal` (B:36 "Opening work other than missions, need and decision records, … writing contributions and candidates, findings, context, proposals": a work item's hard `depends_on`, a finding's `derived_from`, `supports` or `challenges`, B:144); `kur` (B:35 "the installation's own records"; Doc: B:116 and B:138 make its notes' blocking and its items' `depends_on` and `part_of` relations); `sin` (B:38 "Opening exam tasks as ordinary work": an ordinary work item carries its hard dependencies as relations, B 3.3, B 3.4). For `sin`, B 3.15 (B:284, B:286) already keeps the exam link only in EvalRun, so a relation with an exam record at either end is refused after the gate by B 3.15's own rule, not by a new one. Doc: T-W07-F06 calls `relate` with `cal` and `kur` (F06-role-token) | `den`: no "Cannot" line names relations, and none of B:37's "Can" lines lists them, so §4.1's rule refuses it (as row 2's ✘ for opening work); B:37 "Cannot: Writing products and candidates" covers the relations that state how a product was made (`derived_from`, `uses`, `part_of`). `ci`: B:40 "Cannot: Writing verdicts or decisions", and its one write is "writing observations", narrowed to the results of its own checks (EV3 §5.2): a relation is neither. `bak`: B:41 "Every other write" | **Inf:** that relations go with opening work and writing knowledge; `den`'s refusal (the relations a review needs, its `target_ref` and `basis_refs`, are fields of the Review itself, B:232); `sin`'s ✔ rests on B:38's "as ordinary work" (C05 may change the exam form, N-138; 1.6) |
| `affected_entities`, `explain_paths` | The four environment and installation classes. Doc: B:36 to B:38 refuse the environments, among reads, only the exam records, and B:35 refuses `kur` only exam records and RejectedAttempt, the reading §4.1's notes give for its row of reads; DM-35 (F04 (c)) has these two functions hide exam-linked records from every class but `sin` and say "limited" without naming them, so it already assumes callers of several classes, `sin` among them. Uses: a producer's impact of a change (`cal`, `kur`, `sin`); a reviewer's (`den`; G5 item 1, "The review determines for which use the earlier output is still valid"). Doc: T-W07-F04 calls them with `cal` | `ci`: B:40's "Can" (as `ready_works`); EV3 §5.2. `bak`: B:41 | **Inf:** `den`'s use; `ci`'s refusal (1.6) |
| `revise_work`, `mark_stale`, `cancel_work` | Row 2's classes: `cal` (B:36), `sin` (B:38, its exam tasks only), `kur` (B:35, the installation's work items). Each writes the work item a class may open: a new revision (principle 3; B:120), the `qualification` axis (B:134), the `execution` axis (B 3.3's table). Doc: DM-01 lists all three among the writes of a work item's readiness inputs | `den`: §4.1's row 2 gives it ✘ for opening work, and no "Can" line of B:37 writes work items; its authority over others' work is `revoke_claim` (DM-29) and acceptance. A verdict whose basis changed goes stale by the review family's own rule (B:245; N25), not by `mark_stale`. `ci`: B:40 "Cannot: Writing verdicts or decisions"; its only write is its checks' results (EV3 §5.2). `bak`: B:41 | **Inf:** the tie to row 2; `den`'s refusal. Which work items a permitted class may change (another class's included) is a check after the gate and open (section 4, item 1) |
| `reopen_for_review` | Row 2's classes as above (the class that changed a work item's basis takes the affected items into review, B:135), and `den`: B:37 "Can: Reviews"; the candidate review set is the review's input (G5 item 1: the affected work items "are taken into the candidate review set … The review determines for which use the earlier output is still valid"). It writes no product (B:37's "Cannot" does not reach it) and cancels nothing (B:135) | `ci`: B:40; EV3 §5.2. `bak`: B:41 | **Inf:** `den`'s ✔ entirely. No C02 test calls the function (EV-C00-015 row B5: "`mark_stale` and `reopen_for_review` have no test of their own") |
| `review_finding` | `den` only. Doc: B:37 "Can: Reviews, verdicts, acceptance"; B:244 "Binding verdicts and acceptance are written only with the `devos_denetim` role"; B:199 has the sample review check the writer's declared markers; B:201: a transferred finding "cannot move to `reviewed` or `accepted_for_use` until a review enters both". Doc: T-W07-N09 assumes `den` | `cal`: B:36 "Cannot: Binding verdicts, acceptance"; B:244 "`devos_calisma` cannot approve what it produced itself". `sin`: B:38 "Cannot: … writing verdicts". `kur`: B:35 "Cannot: … any other verdict or acceptance" (its one verdict right is the transfer's copies, EV3 §4.2; its findings enter as `candidate`, B:201). `ci`: B:40 "Cannot: Writing verdicts or decisions". `bak`: B:41 | **Inf:** that `review_finding` carries the review transitions (`reviewed`, `accepted_for_use`) and that `accepted_for_use` is an acceptance for use. If the build gives it a transition that is no review (the writer's `withdrawn`), that transition's classes are not decided here (section 4, item 2) |

**Lines of the plan, Appendix C and the work items that bear on these rows.** W-C02-09 point 6 (`relate`'s rule on `model_extracted`), point 7 (`affected_entities` and `explain_paths` at a limit; readiness with an unknown member) and point 8 (F04 with K05, F05, F06, F08, Concurrency, N09, and the authorization test); W-C02-10 has none of the ten in its points. Appendix C: F04 and K05 (`affected_entities`, `explain_paths`), F05 (c) (`revise_work`'s revision), F06 (its original finding is "Creating a relation … produced no event"), F08 (a) (a new hard dependency, `relate`), Concurrency (hard dependencies added at once), N09 (`review_finding`). None of them names a role class for these functions except through the tests' assumed tokens, which W-C02-07's README section 8 labels as assumed; those read here (T-W07-N09: `den`; T-W07-F04: `cal`; T-W07-F06: `cal` and `kur` on `relate`) fall inside the rows above. The other tests' tokens were not checked here.

**Separation lines these rows add, in every direction.** `review_finding` refused to the working, exam, installation and job classes (B:36, B:38, B:35, B:40, B:41); the Work and Relation writes refused to the audit class and to the job classes; the relation reads refused to the job classes. Each ✘ cell is a negative case of T-W07-5B, each ✔ cell a positive control, as §4.1's "Tests, in every direction" says. No line of EV3 §15 changes.

### 1.4 The five rows whose functions Appendix B section 4 does not name

T-W07-5B keys them `R10r`, `R12`, `R13`, `R14`, `R15`; their cells are §4.1's and do not change here.

| Row | §4.1's cells | What the plan gives | Named now? | Why |
|---|---|---|---|---|
| R10r: reading EvalRun, the exam records and the exam fact | `sin` only | B:286 ("`EvalRun` is read only with it"); B section 4 names `record_eval_run` and `competence_summary`, no reader | No: W-C02-09's build | Its arguments and result follow EvalRun's table and its `work_ref` link (DM-24), whose form C05 may change (N-138), and what N08's positive control reads ("The exam environment accesses and scores"). Naming it now would fix half an interface; the row's cells are already fixed, so the build only names and maps it |
| R12: reading review verdicts, decisions, current authority and epoch | all ✔ | B:40 (the reads of `ci`); none named | No: W-C02-09's build | Four objects, in one function or several; their forms follow W-C02-08's tables and DM-02's views, and what C03's checks read (B:40). Naming now would fix their number. Bound for the build: a function it maps to R12 returns only these four, never an exam record, RejectedAttempt or a record DM-35 hides; anything else needs a row of its own |
| R13: fingerprint matches | `ci` only | B:344 ("Of the application roles only `devos_ingest` writes; `devos_ci` reads"); none named | No: W-C02-09's build, which C03 may revise before test 6 | Its arguments (the hashes a check computes) and its result (what a match returns without the matched text; N06: "the matching text is not written to the audit record") are an interface with C03 test 6's check, which C03 writes. W-C02-09 names it in the form LeakFingerprint's table allows |
| R14: recording a check's result | `ci` only | B:40 "writing observations", narrowed by EV3 §5.2 to the results of its own checks; no family named | No, and possibly not in C02 | Appendix B gives no family for a check's result: Observation (3.12) belongs to an Operation, and §4.1 refuses `record_observation` to `ci`. A function cannot be named before the record it writes. W-C02-09's build states whether a C02 check writes results (then the record and its function are built with it) or the row moves to C03, whose required checks are the first to need it, with its reason; until then `5B-row-R14` stays COULD NOT CHECK with that reason, which is never a pass |
| R15: reading RejectedAttempt | `den` only | B:270 ("Only the functions write it; `devos_denetim` reads it"); DM-19 fixes its rows; none named | **Yes:** `devos_api.read_rejected_attempts(since timestamptz)` | Its family, fields and one reader are fixed (B 3.13; DM-19; §4.1; EV-C02-004 X-13), and no later design bears on it. The name and argument are those W-C02-07's README section 8 (unmerged) already assumes, so the tests' function for R15 then comes from the design, not the build. It carries the read marker (DM-36) and returns no input content, token or value derived from one (B:270). The build may add arguments with its reason; it does not rename it |

No plan text is needed for these names: B:40, B:270, B:286 and B:344 already state the rights, and §4.1's accepted rows already stand for reads B section 4 does not name. Whether W-C02-09 lists the five readers in B section 4 for completeness is its record's question (section 4, item 3).

### 1.5 What the build and the tests take from this section

W-C02-09 writes each of the ten functions' role lists as 1.2 gives them (B:48: "The role list sits in the function's definition"), names R15's function as 1.4 does, and names and maps the other rows as 1.4 bounds them. T-W07-5B's matrix gains the ten rows and R15's function from this record (section 3.4).

### 1.6 What reopens a row

Each through a change judged by a fresh checker, before the dependent work: (a) C03's statement of checks needs readiness or relation reads from `ci` (`ready_works`, `affected_entities`, `explain_paths`); (b) C03's design of the audit environment needs a relation that the review functions do not write themselves (`relate`'s `den` cell); (c) C05's exam form (N-138) changes how exam tasks are opened (the `sin` cells); (d) W-C02-09's build gives `review_finding` a transition that is no review.

## 2. Gap 2: DM-41 and the database's own sample Reviews

### 2.1 The conflict, and its cause

DM-41 (a), as accepted: "A trigger refuses a `Review` (or `Verdict`) and a new revision of its target in the same transaction, whichever comes first, by the transaction id." Its "its target" covers every family a Review can name, not only B:246's "target product". The sample mechanism: for a set share of the records a format gate accepts, and of the work items and decisions labelled `routine`, "the database creates a `Review` of kind `sample` and queues it for the audit environment" (B:26; B:247; B:137; B:307); DM-08 draws one record in every block of 10 of each stream; DM-31 (B:266) makes the sample a record "the database makes by rule within that call". So the sample Review and the revision that drew it share one transaction, and DM-41 as written refuses the database's own sample: one write in ten of each gated family, routine work item and routine decision would fail, and N01's, N29's and W-C02-10 point 3's positives could never pass beside N28's negative (T-W07-N28, "Not covered"; W-C02-07's TABLES G18).

**Cause (D6).** The proximate cause is the timing. The cause is a classification: DM-41 counts every Review row as a verifier's act, while a `sample` Review at its opening is the database's queue entry for the audit environment (B:247, "it is queued for the audit environment"): it has no reviewer and holds no judgement. DM-41 and DM-08 were decided side by side in EV2 and never checked against each other; its section 6 names them under separate tests (N28, N01). The decision below fixes the classification, not the timing.

### 2.2 Decision: the database's own sample is not a review record until a verifier takes it

DM-41's trigger does not count as a review record a `Review` row that is all of:

1. **Kind `sample`.**
2. **Written by the database's sampling path, and by nothing else.** One function in `devos_private`, named by W-C02-10's build, which no application role may execute and which only the functions that accept a format-gated or routine-labelled write call, inside that write's call. It is the one writer of kind `sample`: a check on the Review table refuses a `sample` row written by any other path. The check reads a marker that only the sampling function sets, for its own insert, and that no Data API request can set; W-C02-10's build chooses its form (for example a transaction-local setting the function sets and clears around its insert), records it, and section 2.5's cases test it. Before that check, `open_review` and the ledger transfer's `transfer_review` refuse kind `sample` from every token (N01; W-C02-10 point 3: "A `sample` Review written with any environment token … is refused").
3. **Bound to the revision that drew it.** Its target and target revision are the record and the revision whose accepted write drew it, in that call.
4. **Opened without a reviewer.** Its reviewer fields (`reviewer_declared_session`, `reviewer_role_class`, `independence_level`, `view_ref`, `shared_with_producer`) are empty and no `Verdict` names it. The role class of the call that drew it is on its creation event (`origin = rule`, DM-31), never in `reviewer_role_class`.

**Everything else in DM-41 stands, and one case is added:**
- Every other Review (kind `review` through `open_review`, and the transfer's copies) and every Verdict, with a new revision of its target in the same transaction, in either order: refused, as DM-41 says. T-W07-N28 stays as written.
- **The taking.** The transaction that takes a `sample` Review is a review transaction under DM-41 in full: a Verdict on it, or the setting of its reviewer fields if W-C02-10's build gives taking that form, with a new revision of its target in the same transaction, in either order, is refused. The exception ends the moment a verifier acts. The Verdict half is DM-41's own words; the reviewer-fields half is added here, because DM-41's words name an insert and taking a sample may be an update.
- **Could not check.** If the trigger cannot establish conditions 1 to 4 for a row (the marker absent or unreadable, a field unreadable), it counts the row as a review record: the write is refused and recorded as "could not check" with its reason, never let through (plan Section 8 item 14). With W-C02-10 point 3's own rule (a missing or unreadable share setting refuses the gated write), no gated write is accepted without its draw decided.
- **Nothing else is exempt**: no other kind, no Review written through the ledger transfer's path, no record made by another rule. The exemption depends on the writer, not on the caller: a sample that a transferred decision draws (B:308) is exempt like any other.

**Not needed:** no job, no queue but the sample Review itself, no change to DM-08's draw or to the trigger's comparison by transaction id. A later revision of a sampled target in the same transaction is not refused (2.4, alternative D).

### 2.3 Why N28's purpose stays whole

N28 (C:145), "The verifier does not repair"; plan 6.7 (P:710): "The audit session does not fix a problem it finds in the same action; the fix is a separate work item in the working environment"; B:246. The purpose: nobody judges a target and changes it in one action, so a judgement is never of a target its judge has just shaped, and a fix is always a separate, visible work item.

- When the database opens a sample, no verifier acts. The call is the producer's (or the transfer's), the row has no reviewer and no verdict (condition 4), and the database's hidden draw chose it (DM-08), not anyone in the transaction. Nothing is judged, so nothing is repaired "in the same action".
- The verifier's act, taking the sample or writing its verdict, is under DM-41 in full, so the audit environment cannot judge a sample and change its target in one transaction. The rule about taking also closes a case DM-41's words left open if taking were an update.
- No client reaches the exemption. Kind `sample` is refused at `open_review` and `transfer_review` for every token, and the table check refuses a `sample` row from any other writer (condition 2). A client's Review keeps DM-41 in full.
- The producer gains nothing **[Inf]**. The draw is random within each block and hidden (DM-08), the sample names the revision written (condition 3), any later revision of the target is a gated write of its own in the stream, and a sample is a request for review, not an approval.

### 2.4 Alternatives weighed

| Alternative | What it would need, and what happens if it fails | Not chosen because |
|---|---|---|
| **B1. Open the sample in a later transaction, by a scheduled job** | A table of pending draws (a second queue); a scheduler, whose availability on the free plan was not read (DM-06 (d)); a C02 job where B section 5 has none (DM-06); the due-occurrence check B section 5 requires with every job (B:430; T-77), on the independent monitoring path. If the job stops or never runs, the sampled records wait unreviewed and no one sees it unless that check catches it; a failed run between the draw and the Review needs retry logic | It adds a job, a queue, a monitor and a silent failure mode to solve a classification error. N01's "reaches the audit environment's queue as a `Review` of kind `sample`" would hold only after the next run, and W-C02-07's tests, each in one rolled-back transaction, could never see the Review. It stays the fallback if a checker finds the exemption loosens N28 (section 4, item 9) |
| **B2. The next call of any function opens the pending samples** | Pending draws as in B1, opened inside an unrelated call | The sample's event would carry an unrelated caller's role class (DM-31). That call might itself write a revision of the same target and meet DM-41 again. If no call comes, the sample is never opened |
| **B3. The audit environment's queue read opens them** | A read that writes | It breaks DM-36's read marker (a read changes nothing but RejectedAttempt), and the sample would be opened in the audit environment's own transaction, where DM-41 must stay strict |
| **B4. An autonomous transaction commits the sample on its own** | An extension (for example `dblink`) | A sample would commit when the gated write rolls back: a sample of a revision that never existed, against principle 2 |
| **C1. The trigger compares products only (Artifact), as B:246's "target product" reads literally** | Nothing: no sample stream targets an Artifact, so the conflict vanishes | A verifier who rewrites the Finding, Decision or work item it reviews, in one transaction, would pass (for example `review_finding` with a new revision of the finding). That narrows DM-41's accepted "its target" and T-W07-N28's failure class ("any transaction that holds both a review record and a new revision of its target") |
| **C2. The trigger compares who acts (refuses only when the Review's and the revision's writer are the same class or session)** | Actor fields on both rows | DM-41 (b) chose "whatever roles act in it", because a caller holding two tokens, or a later role with both rights, could split the act. Role classes would not tell a sample apart anyway (DM-31 gives it the caller's class) |
| **C3. The trigger acts on Verdicts only** | — | B:246 and C:145 name the Review record, where the verifier's claim, criterion and basis are written; it narrows the rule |
| **C4. A Review with empty reviewer fields is not counted** | — | It covers the sample, and also any client Review a function fails to fill (a fault in `open_review`). The exemption would rest on a field any writer can leave empty. Kept only as condition 4 of four |
| **A′. Kind `sample` alone** | — | It rests on every client path refusing kind `sample`. A later stage's function that forgot that refusal would open the exemption to a client that also writes the repair. Condition 2's table check closes that route |
| **D. Also refuse any other revision of the sampled target in the transaction that opened the sample** | — | It serves no part of N28's purpose, since no verifier has acted. The sample names its revision, which stays (DM-02's revisions are never changed), and a later revision is in the stream itself. In W-C02-07's tests, which run up to about 230 calls in one transaction (T-W07-5D), it would refuse a later revision only when the hidden draw happened to fall on the earlier one, so results would vary from run to run |

**From scratch (D1).** Had DM-41 not existed, the trigger would be chosen in the same form with this exemption: it keeps one comparison by transaction id, adds no job or queue, and moves the review moment to where a verifier acts.

### 2.5 Planted cases that would show the decision holds

These are for W-C02-07's test designer to write. They are not written here, and their IDs are suggestions.

| Case | Planted | Must be observed |
|---|---|---|
| S-pos-gate | With the share set to take it (block 1 on the throwaway database; in `devos-test`, enough writes to fill a block), one accepted record of each format-gated family (Need, Decision at `open` of class `high_impact` or `batu`, EffortPolicy, Finding) | The record's revision and its `sample` Review commit in one transaction. The sample names that record and revision, its reviewer fields are empty, no Verdict names it, and its creation event has `origin = rule` and the caller's role class |
| S-pos-routine | The same for a work item and a decision labelled `routine` (B:137; B:307; N29's planted run) | As S-pos-gate |
| S-neg-open | `open_review` with kind `sample`, with each role class's token, `den`'s included; `transfer_review` with kind `sample` and the `kur` token | Refused, recorded; no Review row |
| S-neg-direct | On the throwaway database, as the owner: a `sample` row written into the Review table without the sampling path's marker | Refused by the table's check |
| S-neg-take | In one transaction, a Verdict on a `sample` Review (`den` token) and a new revision of its target, in either order; and, if the build has the form, the sample's reviewer fields set with a new revision of its target | Refused; the Verdict (or the taking) and the revision are not both written |
| S-neg-client | T-W07-N28's N28-a and N28-b, unchanged (a Review of kind `review` through `open_review` and a new revision of its target in one transaction) | Refused: the exemption opened nothing else |
| S-ccc | The marker's source made unreadable (as T-W07-6RG plants unreadable input), then a gated write whose draw falls on it | Refused and recorded as "could not check"; neither accepted with the sample nor accepted unsampled |

**Break attempts.** B-S1: the exemption removed; S-pos-gate and S-pos-routine turn red. B-S2: the writer condition dropped (any `sample` row exempt, the table check removed); S-neg-direct turns red. B-S3: the rule about taking dropped (a taken sample still exempt); S-neg-take's reviewer-fields case turns red, or, if the build has no such form, the break is not applicable and is recorded so. B-S4: the exemption granted when the marker is unreadable; S-ccc turns red.

### 2.6 What W-C02-10's build takes from this section

The sampling function in `devos_private`, not executable by any application role, called only from the gated and labelled writes; its marker; the refusal of kind `sample` in `open_review` and `transfer_review` (the latter built in W-C02-09, EV-C02-005 S5); the Review table's check; DM-41's trigger with conditions 1 to 4, the rule about taking and the fail-closed rule. Its record names the marker's form and shows the catalogue's grants on the sampling function.

## 3. What changes elsewhere

### 3.1 Made with this record

- EV3 §4.1: one dated line after "Tests, in every direction", pointing here; the accepted text is unchanged.
- EV2 DM-41: one dated line after its paragraph, pointing here; the accepted text is unchanged.
- `plan/work/C02.md`, N-256: one dated line saying the ten rows are decided here; its status is unchanged.

### 3.2 Plan text, for the executor to change through plan Section 14 (a plan-change record)

**Such places exist: two, both from Gap 2. Gap 1 needs none:** its cells rest on B section 2 and B section 4 as they stand, and no plan line names other classes for these functions.

**Place 1. Appendix B 3.11, rules, line 246 at `11feac5`.**
- Old: "- The verifier does not repair in the same action: a new revision of the target product cannot be written in the same transaction as a `Review` record."
- New: "- The verifier does not repair in the same action: a new revision of a review's target cannot be written in the same transaction as a `Review` record of it or a `Verdict` on such a review. The `sample` Review the database itself opens (next rule) for the record revision whose accepted write draws it, with no reviewer and no verdict, is not such a record; the transaction that takes it or writes its verdict falls under this rule in full (`evidence/C02/EV-C02-002_data_model_choices.md` DM-41; `evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md` section 2)."
- Why. Read literally, "the target product" (an Artifact, B 3.10) stays true under the decision, since no sample stream targets an Artifact. But DM-41, accepted, applies the rule to every target and to Verdicts, and under that reading the decision would make the sentence untrue. The new text states DM-41's reading and the one exception, so that plan and design say the same.

**Place 2. Appendix C N28, line 145 at `11feac5`.**
- Old: "| N28 | The verifier does not repair | A new revision of the target in the same transaction as the review record is rejected | The repair is opened as a separate work item | C02 |"
- New: "| N28 | The verifier does not repair | A new revision of the target in the same transaction as the review record is rejected, and so is one in the transaction that takes a `sample` Review or writes its verdict; the `sample` Review the database itself opens for the record revision that draws it is not a review record here (Appendix B 3.11) | The repair is opened as a separate work item; a record whose accepted write draws a `sample` Review is accepted with it in the same transaction | C02 |"
- Why. Under the old plain words, N01's positive (the sample in the audit queue) and N28's negative cannot both pass. The new negative adds a case (the taking) and excludes only a row no verifier wrote. The new positive states what the decision admits. Whether this reads as a loosening is for the change's checker (section 4, item 9).

**Not changed on purpose:** P:710 (plan 6.7's "The verifier does not repair", which names the audit session's action: still true); B:26 (principle 12); B:247 (the sample is created by the database); B:396 (the Review group: "no repair in the same transaction; `sample` reviews are created by the database", true of the review functions); B section 2.

### 3.3 Not plan text: an acceptance line, changed only through the merge gate

**W-C02-10 point 5, its N28 bullet (line 38 at `11feac5`).** Like N-253 (1), this goes through the merge gate (class high), with a fresh checker's verdict, before W-C02-10's tests are run against it, and it must not loosen the block.
- Old: "   - ✘ N28: a new revision of a review's target in the same transaction as the Review record is refused; ✔ the repair opened as a separate work item is accepted (B 3.11)."
- New: "   - ✘ N28: a new revision of a review's target in the same transaction as the Review record is refused, and so is one in the transaction that takes a `sample` Review or writes its verdict; the `sample` Review the database itself opens for the record revision that draws it is not such a record (`evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md` section 2); ✔ the repair opened as a separate work item is accepted, and so is a sampled record with its `sample` Review in one transaction (B 3.11)."
- Why it does not loosen **[Inf]**. Under its plain words the block's own point 3 (the database creates the sample) and point 5 cannot both be met. The change settles that conflict, adds a negative (the taking) and three planted negatives (2.5), and excludes only the row no verifier wrote.

### 3.4 W-C02-07's tests (the executor's, before any result; README section 8)

T-W07-5B gains the ten rows of 1.2 and R15's function (1.4). Its "Could not check" item on the ten functions and its `w07_fn_cfg` key `R15` change accordingly. T-W07-N01's, T-W07-5D's and T-W07-T31's "Phase C" lines, and the first bullet of T-W07-N28's "Not covered", cite section 2 in place of the assumption. The cases of 2.5 are added. Nothing here changes a test file.

## 4. What stays open

1. **Which work items a permitted class may change.** The rows admit `cal` to `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `relate` and `retract_relation` without qualifier. Neither §4.1 nor this record decides whether a working session may cancel, revise or retract the relations of a work item that the audit environment, the exam environment or the installation opened, or an exam subject cancel its own exam task. Principle 8 puts separation at the environment level, and EV3 §15 has no line for it. This is a material question, reported and not decided: the executor decides it before W-C02-09 builds these functions (one candidate: the opening class, as S8 line 2 binds a claim to its class), judged by a fresh checker.
2. **`review_finding`'s other transitions.** If W-C02-09's build gives it a transition that is no review (the writer's `withdrawn`), that transition needs its own row, or another function, before it is built (1.3; 1.6 (d)).
3. **The readers of R10r, R12 and R13; R14's record.** W-C02-09 names them within 1.4's bounds; R14 may move to C03 with its reason. Whether B section 4 should then list the five readers is W-C02-09's record's question, with one plan change if so.
4. **`operation_state(operation_id uuid)`**, which W-C02-07's README section 8 assumes for T-W07-F07, has no row in §4.1 or here; it is outside N-256's ten. Reported for the executor.
5. **The ledger transfer's fourteen functions.** B:397 states their class ("Only `devos_kurulum`"), but §4.1 has no row for them; T-W07-5B's table, as read here, would report them as unmapped. Reported, not checked against its SQL.
6. **`set_effort_policy` in T-W07-5B's R08** (`den` only). B 3.18 has every work item carry an EffortPolicy (B:312, B:314), and N03 refuses the working environment only a reduction's approval and a standing policy. If `set_effort_policy` is the one writer of an item's policy, R08's mapping refuses the working environment's ordinary write. Reported, outside this record's scope.
7. **A sample's other fields at opening** (`claim`, `criterion`, `use`, and `basis_refs`, which B:396 makes mandatory for reviews): W-C02-10's, with DM-08.
8. **The ledger transfer and DM-41 [Inf].** EV-C02-005 writes Artifacts and Review copies in separate phases of its manifest (its line 203), each write with its `transferred` event in one transaction (its line 367), so DM-41 does not meet them as designed. If W-C02-14's build wrote a copy and a new revision of its target in one transaction, DM-41 would refuse it, and this exemption does not cover it (a copy has a reviewer).
9. **The checker's reading of places 1 and 2 and of 3.3.** If the checker finds the exemption loosens N28, alternative B1 is the next best, with the costs 2.4 states; the executor decides before W-C02-10 builds the trigger.
10. **Not consulted:** the research library (the question is the consistency of DevOS's own rules); Appendix A; PC-42 and PC-43 beyond what EV2 and EV3 carry.
