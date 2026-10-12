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
  - "Added 2026-10-12 for sections 1.7, 2.7 and 3.3's argument and PC-46 (a second fresh-context producer of the same session): B:200, B:258, B:259, B:266, B:268, B:284 to B:286, B:312 to B:316, B:389 to B:404; C:26, C:91 to C:95 (F07), C:118, C:120, C:145; P:330, P:641, P:710, P:763; plan/Installation_Working_Order.md sections 4 and 6; plan/ledger.md rule 3; EV2 DM-29 and DM-41; EV3 sections 4.1 to 4.3; plan/work/W-C02-10.md in full; plan/decisions/PC-44.md and PC-45.md; W-C02-07's unmerged T-W07-N03 and T-W07-N28 in full, T-W07-5B lines 20 to 124, README section 8.1, and the lines of T-W07-F07, T-W07-RT, T-W07-6TK and T-W07-N04 that name operation_state or set_effort_policy, read only for what they assume. Read 2026-10-12."
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

### 1.7 Four open points of section 4 (items 1, 4, 5 and 6), decided

*Added 2026-10-12, by a second fresh-context producer of the same session (declared, Ek A 5.3), at the executor's task; read with PC-46.* Labels as above. Each rule here is a check after the role gate (1.1) unless it says "at the gate". Further sources read for this section, at `11feac5`: B:312 to B:316, B:389 to B:404, P:763, C:91 and C:94 (F07), C:120 (N03); EV2 DM-29; W-C02-07's unmerged T-W07-N03 (in full), T-W07-F07 line 10, T-W07-RT line 42, T-W07-6TK line 20 and T-W07-N04 line 41, read only for what they assume.

#### 1.7.1 Changing a work item another environment opened (section 4, item 1)

**What the families record (Doc).** Work has no field naming the class that opened it (B:120); that class is on the work item's creation event (B 3.13: `role_class` "from the caller's token, never declared"). The installation's work items sit under the installation's Mission (B:138, PC-44 place 4). An exam task is recorded as one only by the exam link, which "lives only" in EvalRun, readable only with `sin` (B:284; B:286: "in the `Work` record, the fact that the task is an exam is kept in a field the working environment cannot see"; N08, C:125; §4.1's row for "the fact that a task is an exam": `sin` only). A claim's class is on its Assignment (B 3.5; EV3 §4.3, S8 line 2). A relation the ledger transfer wrote has a creation event of type `transferred` (B:268).

**The lines of B section 2 that bear (Doc).** B:35: `kur` writes "the installation's own records (work items and claims on them, …)". B:36: `cal` "Opening work other than missions"; no "Cannot" line of B:36 names other environments' work. B:37: `den` writes no work item. B:38: `sin` "Opening exam tasks as ordinary work". Principle 8: "Separation-of-authority rules are defined at the environment level." EV2 DM-29 (b): letting `cal` revoke "would let any working session take another's claim"; ending another's claim is `revoke_claim`, `den` only.

**Alternatives weighed.**
- **(A) The opening class only** (section 4 item 1's candidate: a work item changes only with the class whose token opened it, read from its creation event). Not chosen. Exam tasks are opened with `sin` (B:38), so `cal` would be refused on exactly the exam tasks, and the refusal would answer for a working session the question B:286 and N08 hide from it: `den` opens no work, and the installation's items are known by their Mission, so a refused item outside the installation is an exam task.
- **(B) Any permitted class on any work item.** Not chosen. `sin` would change working items (B:38 limits it to exam tasks), `kur` working items (B:35, "own"), `cal` the installation's, and a working session could revise or cancel a work item the audit environment holds a claim on, ending that claim's effects (F08's re-check at the effect, B:258): the revocation DM-29 gives `den` alone.
- **(C, chosen) Ownership read from what the families record (Rule O), and the claim's class (Rule C).**

**Rule O (ownership).** Checked in `revise_work`, `mark_stale`, `cancel_work` and `reopen_for_review`, in `relate` and `retract_relation` when the relation's `from_ref` is a work item, and in `retract_relation` for every relation:
- `kur`: only work items under the installation's Mission (B:35; B:138).
- `sin`: only work items its exam link names (B:38; B:284).
- `cal`: any work item not under the installation's Mission. The check reads nothing about exams, so an exam task is changed exactly as an ordinary work item, with the same answers and reasons (B:286; N08).
- `den` (only `reopen_for_review` passes its gate): any work item. It takes the item into its own candidate review set and changes nothing else (B:135; G5 item 1).
- A relation whose creation event is `transferred` is retracted only with `kur` (B:35; B:268).
- Refused otherwise, recorded as DM-19 says; the reason names the rule, never the item's opener.

**Rule C (another class's claim).** Checked after Rule O in `revise_work` and `cancel_work`, and in `relate` and `retract_relation` for a hard relation whose `from_ref` is a work item: refused while an active claim of a role class other than the caller's is on that work item. It is not checked in `mark_stale` or `reopen_for_review`, which keep the work, its claim and its output (B:134, B:135): a running claimant must learn that its input changed. A claim of the caller's own class does not stop the call, so B:136's case (a work item cancelled while claimed, its late result kept as candidate evidence) stays inside one environment, where principle 8 draws no line between sessions.

**The cases the task names.**
- **`cal` and the audit environment's work.** `den` opens no work in C02 (§4.1's row 2); the review work items its sessions claim from C03 (EV2 section 3 row 2.9) are opened by a design C03 makes. Under Rule C, `cal` can neither revise, nor cancel, nor add or retract a hard dependency of a work item while `den` holds its claim. Before `den` claims it, `cal` may cancel a review work item outside the installation. That delays an acceptance and never grants one: acceptance needs `den`'s verdict (B:133; B:244), and a sample is a Review row, which `cal` cannot write or change (§4.1's reviews row).
- **`cal` and the exam environment's work.** `cal` changes an exam task as any ordinary work item, so no answer that Rules O and C give tells it the task is an exam. *(Limited 2026-10-12, CHK-C02-025 C1: other answers can; section 4 item 11.)* On the plan's form the subject claims its exam task in the working environment (B:286: "opened in the working environment as ordinary `Work`"), so Rule C does not refuse `cal` there either.
- **An exam subject cancelling its own exam task.** Allowed, as on any ordinary work item: the work item's `execution` becomes `cancelled`, with its event under `devos_calisma`. EvalRun and the exam records are untouched (B:286: written only with `sin`); the exam reads the cancellation through its link. A revision by the subject is a new revision, which the link's "+revision" (B:284) tells apart from the one `sin` opened.
- **`sin` on other work.** Refused on every work item its exam link does not name.
- **`kur`'s own items.** Only `kur` revises, marks stale, cancels or changes the relations of the installation's work items, and `kur` only those (`den`'s `reopen_for_review` excepted, which changes nothing else). After the hand-over the installation writes them through these functions with `kur` (B:35; B:138).

**What is inference.** Rule C in full (that revising, cancelling or adding a hard dependency across classes is DM-29's revocation by another name); that `den`'s `reopen_for_review` reaches every work item; that the exam reads and scores a cancellation or revision by its subject; that `cal` is refused the installation's items, which rests on B:35's "own" and not on a "Cannot" line of B:36. **Doc:** Rule O's `kur` and `sin` limits (B:35, B:38) and the reason it reads no exam link for `cal` (B:286; N08; §4.1).

**Tests this asks for** (for W-C02-07's designer; IDs and form are the designer's). Rule O: each function with each class's token on a work item of each kind (opened with `cal`, under the installation's Mission, an exam task opened with `sin`), ✔ or ✘ as above; for `cal`, the answers that Rules O and C give on an exam task equal those on a `cal`-opened item (the exam fact not leaked by these rules; section 4 item 11 for the reads). Rule C: with a `den` claim on a `cal`-opened item, `cal`'s `revise_work`, `cancel_work` and hard `relate` refused and `mark_stale` accepted; with another working session's claim, `cal`'s `cancel_work` accepted and the late result kept as a candidate (B:136). Breaks: Rule O reading the exam link for `cal` (the leak case turns red); Rule C removed (the `den`-claim cases turn red). These are not T-W07-5B's role-gate cases.

#### 1.7.2 `operation_state` (section 4, item 4)

**Decision: a separate read function, named now:** `devos_api.operation_state(operation_id uuid)`, carrying the read marker (DM-36). It returns the Operation's `status`, whether any of its observations is `applied` (`ever_applied`), and the latest observation's `observed_effect` (`current_effect`). It returns no payload and nothing B 3.12 does not hold. The build may add fields of B 3.12 with its reason; it does not rename it.

| Function | `cal` | `den` | `sin` | `kur` | `ci` | `bak` |
|---|---|---|---|---|---|---|
| `operation_state(operation_id)` | ✔ | ✔ | ✔ | ✔ | ✘ | ✘ |

**Why a separate function (Doc, then Inf).** F07's positive is "The current-state question gives the right answer", and its class rule keeps "applied in the past", "current now" and "accepted" apart (C:91, C:94). No function of B section 4 answers it as a read: `prepare_operation`'s repeat answers "from the existing record and the real state" (B:259), but it takes a claim token and the full intent and runs the effect's checks, so a reader would need a claim and could be refused by them; `record_attempt` and `record_observation` write. DM-36 requires a read to change nothing. **Inf:** that the three fields are those F07 needs; "accepted" is the work item's and Acceptance's, not this read's.

**Why named now, unlike R10r, R12 and R13 (1.4).** Its family and fields are fixed (B 3.12: Operation's `status`; Observation's `observed_effect`, appended, F07); the tests already assume the name (W-C02-07 README section 8.1, its "Reads the tests need" line); and no later design bears on its form (C08 runs F07 again on the same tables, C:95). The argument is README section 8.1's `operation_id uuid`; T-W07-F07's line 10 writes `operation uuid` and is aligned by the test designer before a first result (README section 8).

**The row's sources.** Doc: §4.1's note, "B:36 to B:38 refuse the environments, among reads, only the exam records", and B:35 refuses `kur` among reads only exam records and RejectedAttempt; Operation and Observation are neither. `ci`: not among B:40's reads (as §4.1's `competence_summary` row; EV3 §5.2). `bak`: B:41, "only the `mark_exported` function". Uses: `cal` and `kur` read the effects they intend (§4.1's row of "external-effect intents and their observations": `cal` ✔, `kur` its own); `den` reads them to review work with an effect and for recovery's stages (B:37: "advancing recovery stages"); `sin` reads an exam task's effect. **Inf:** `den`'s and `sin`'s uses; that no after-gate limit applies (none applies to §4.1's other reads).

#### 1.7.3 The ledger transfer's fourteen functions (section 4, item 5)

The row, in §4.1's terms, from B:397 (PC-44 place 10):

| Operation (B section 4) | `cal` | `den` | `sin` | `kur` | `ci` | `bak` |
|---|---|---|---|---|---|---|
| Ledger transfer (B:397; PC-44 place 10): `begin_transfer_run`, `transfer_mission`, `transfer_work`, `transfer_relation`, `transfer_decision`, `transfer_review`, `transfer_acceptance`, `transfer_need`, `transfer_finding`, `transfer_artifact`, `transfer_event`, `end_transfer_run`, `record_handover`, `record_ledger_entry` | ✘ | ✘ | ✘ | ✔ until the `ledger_handed_over` event; after it only `transfer_review`, `transfer_acceptance` and `transfer_artifact` for a verdict file, until the C03 migration removes them, and `record_ledger_entry` for `ledger_entry` events, until C12 | ✘ | ✘ |

**Reading.** At the gate the row is `kur` only, for all fourteen. What follows "✔" is a check after the gate, read from the `ledger_handed_over` event (state, not role), as 1.1 reads §4.1's qualifiers; so are `transfer_mission`'s condition ("opens a Mission only on an answered `batu` decision", B:397; DM-23) and `transfer_review`'s refusal of kind `sample` (2.2, condition 2).

**Refusals, each with its line (Doc).** Every class but `kur`: B:397, "Only `devos_kurulum`"; B:35's "Can" names the ledger transfer, no other class's does. Besides: `cal` on `transfer_review` and `transfer_acceptance`, B:36 "Cannot: Binding verdicts, acceptance"; `den` on the same two, EV3 §4.2 ("Writing them as `devos_denetim` would make an installation self-check look like an audit verdict (criterion 30), and is refused"), and on `transfer_artifact`, B:37 "Cannot: Writing products and candidates"; `sin` on `transfer_artifact` and `transfer_review`, B:38 "Cannot: Writing products, writing verdicts"; `ci` on `transfer_review` and `transfer_decision`, B:40 "Cannot: Writing verdicts or decisions", its one write being its checks' results (EV3 §5.2); `bak`, B:41 "Every other write". **Inf:** none in the cells; that the hand-over's limits are not role cells.

**For T-W07-5B.** One row (its key the designer's), six cells for each of the fourteen; until it exists the fourteen give `5B-unmapped-*`. Its `kur` ✔ cells are run before any `ledger_handed_over` event exists in the test's transaction **[Inf]**; the refusals after the hand-over are the transfer's tests (N18; W-C02-14), not the role gate's.

#### 1.7.4 `set_effort_policy` (section 4, item 6)

**Sources (Doc).** B:312: `work_ref` is "empty for a standing policy"; `expert_assessment_ref` "cannot be empty for any work item"; `approved_by_role_class` (`devos_denetim`). B:314: "A reduction needs the audit environment's approval: its own approval for the item, or a standing policy that the audit environment approved in advance for a class of work …; a work item of that class uses the policy without a new approval"; "A standing policy is written and retired only with `devos_denetim`". P:763: "Every work item is opened with high effort depth. A reduction is made with a reason and with the approval of the audit environment". B:402, `set_effort_policy`'s key check: "Effort reduction only with audit approval, for the item or by a standing policy". Where B section 4 limits a whole function to one class it says so: `revoke_claim` "only `devos_denetim`" (B:390), `ingest_source` "(only `devos_ingest`)" (B:393), the Review group "Only `devos_denetim`" (B:396), the ledger transfer "Only `devos_kurulum`" (B:397), `mark_exported` "(only `devos_backup`)" (B:404). For `set_effort_policy` it limits only the reduction. B:35 refuses `kur` "effort-reduction approval"; §4.1's row "Effort-reduction approval; standing effort policies": `den` only; N03 (C:120).

**Decision.** One function with three kinds of write.
- **At the gate:** `cal` ✔, `den` ✔, `sin` ✔, `kur` ✔; `ci` ✘ (B:40: no write but its checks' results, EV3 §5.2); `bak` ✘ (B:41).
- **(a) A work item's own policy at the default** (level high with every step, B:312; P:763), **or within an active standing policy for its declared class** (B:314: "uses the policy without a new approval"): the classes that may change that work item under 1.7.1's Rule O, that is `cal`, `sin` (its exam tasks) and `kur` (the installation's work items). `den` is refused this kind: its right is the approval, (b), and B:37 lists no other policy write.
- **(b) A reduction for one item** (a lower level, or a step dropped where no standing policy allows it), with its reason: `den` only, on any work item; `approved_by_role_class` is taken from the token, and a declared approval counts for nothing (B principle 8). Refused to `cal` (N03: "the working environment's own approval of a reduction is rejected"), `kur` (B:35) and `sin` (B:38 lists no approval).
- **(c) Writing or retiring a standing policy:** `den` only (B:314).
- In every kind, the expert assessment and the non-removable steps bind the writer, `den` included (B:314; N03). The transferred items' policies are written by the transfer (`transfer_work`; B:316), not here.

**Is T-W07-5B's mapping right?** Not as a role list. Its R08 maps the whole function to §4.1's row "Effort-reduction approval; standing effort policies", a row of operations (b) and (c). The function also carries (a), so `5B-R08-set_effort_policy-cal`, `-sin` and `-kur` expect a role refusal where the gate must admit those classes. That contradicts B:312 and B:314 (every item carries a policy, and an item uses a standing policy "without a new approval") and T-W07-N03's own positives with the working token (`N03-pos-default`, `N03-pos-standing-use`). R08's cells are right for (b) and (c), as checks after the gate: T-W07-N03 already tests them with the working and `kur` tokens (`N03-neg-own-approval`, `-kurulum`, `N03-neg-standing-calisma`, `-kurulum`, `N03-neg-retire-by-calisma`). For the test designer, before a first result (README section 8): a gate row for `set_effort_policy` (`cal`, `den`, `sin`, `kur` ✔; `ci`, `bak` ✘), with R08 kept as the operation row T-W07-N03 tests. Three other places cite R08 for this function: T-W07-RT's `RT-cal-n4`, T-W07-N04's `N04-k-set_effort_policy` and T-W07-6TK's list of functions that "refuse `devos_calisma` by its role list". They hold only if their call is a reduction or a standing policy refused after the gate. Their arguments were not read here. The test is not changed here.

**Alternatives weighed.** (i) `den` only at the gate, with each item's default policy written by `admit_work` in the same call (R08's mapping would then be right). Not chosen: B section 4 gives the policy its own function and `admit_work` the key check "Scope and revision; link to the mission revision" (B:389), and an item's use of a standing policy (B:314) is a write on the item's side, which a `den`-only function could not take. (ii) Two functions, one for approvals: B section 4 names one, and the token already tells the approver (B:312's `approved_by_role_class`; principle 8). **Inf:** reading B:402's "only" for the reduction alone; `den`'s refusal of kind (a); `den`'s reduction on any work item.

#### 1.7.5 What reopens 1.7

Each through a change judged by a fresh checker, before the dependent work: (a) C03's design of review work items (who opens them; whether `cal` may cancel one not yet claimed); (b) C05's exam form (N-138), if `sin` holds claims on exam tasks or exam tasks leave the working environment's reach; (c) W-C02-09's build splitting `set_effort_policy` or giving `operation_state` another form, before the tests' first results; (d) C08's or C09's need for other operation reads.

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

*Added 2026-10-12 (CHK-C02-026 C1):* B-S3 has a second form, which every build has: a break under which DM-41's trigger treats a Verdict on a `sample` Review as exempt (for example by judging the Verdict's review by conditions 1 to 3 and by reviewer fields still empty); under it, S-neg-take's Verdict case turns red. "Not applicable" stays only for the reviewer-fields form, where the build has no such form.

### 2.6 What W-C02-10's build takes from this section

The sampling function in `devos_private`, not executable by any application role, called only from the gated and labelled writes; its marker; the refusal of kind `sample` in `open_review` and `transfer_review` (the latter built in W-C02-09, EV-C02-005 S5); the Review table's check; DM-41's trigger with conditions 1 to 4, the rule about taking and the fail-closed rule. Its record names the marker's form and shows the catalogue's grants on the sampling function.

### 2.7 The ledger transfer's row (1.7.3) and the sample path

*Added 2026-10-12, with 1.7.*

- **Who calls the sampling function.** Condition 2's "the functions that accept a format-gated or routine-labelled write" means every function that accepts a record of one of DM-08's streams, whether or not the record passed a gate. That includes four of the transfer's functions, whose records skip the gate but are in a stream. `transfer_decision`: B:308, "such decisions count in the sample stream of `high_impact` and `batu` decisions". `transfer_work`, for the item's EffortPolicy: B:316, "EffortPolicy is a sample stream". `transfer_finding`: B:200, Finding "is one of the sample's streams". `transfer_need`: PC-44 place 3's reason, `why_needed` is "the note's own text, which the Need sample stream sees". So a sample a transferred record draws is the database's own, exempt as 2.2's last bullet says, and its creation event carries `kur`'s class (B:266; DM-31). **Doc** for decisions and effort policies; **Inf** for findings and needs (B states their streams, not the transferred records' place in them).
- **After the hand-over** these four refuse (B:397), so the transfer's samples end with it; the installation's later records draw theirs through the ordinary functions.
- **`transfer_review`** refuses kind `sample` after the gate (condition 2). Its copies are Review records under DM-41 in full (they have a reviewer); section 4 item 8 stands.

## 3. What changes elsewhere

### 3.1 Made with this record

- EV3 §4.1: one dated line after "Tests, in every direction", pointing here; the accepted text is unchanged.
- EV2 DM-41: one dated line after its paragraph, pointing here; the accepted text is unchanged.
- `plan/work/C02.md`, N-256: one dated line saying the ten rows are decided here; its status is unchanged.

### 3.2 Plan text, for the executor to change through plan Section 14 (a plan-change record)

**Such places exist: two, both from Gap 2. Gap 1 needs none:** its cells rest on B section 2 and B section 4 as they stand, and no plan line names other classes for these functions.

*Added 2026-10-12:* both places are carried by `plan/decisions/PC-46.md`, with their old texts quoted from `11feac5`, and applied word for word in `plan/Ek_B_Veri_Modeli.md` and `plan/Ek_C_Testler.md` at this record's head. A search of the plan and its appendices for "repair", "same transaction", "same action", "review record" and "sample" found no other text that sections 1.7, 2 or 2.7 make untrue; PC-46's "Places checked, unchanged" lists the places read and why each stays.

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

**Made, and the argument for a checker** (*added 2026-10-12*). The New text above is in `plan/work/W-C02-10.md` at line 38, word for word. Ledger rule 3 says an acceptance condition is "never loosened". W-C02-10 has no result yet. The table takes each case the bullet can meet, in the old wording and the new.

| Case | Old wording | New wording |
|---|---|---|
| 1. A Review of kind `review` (through `open_review`) and a new revision of its target in one transaction, either order: the verifier's repair (T-W07-N28's N28-a, N28-b) | ✘ | ✘, unchanged |
| 2. A ledger transfer's copy (`transfer_review`) and a new revision of its target in one transaction | ✘ | ✘: a copy is not "the `sample` Review the database itself opens" |
| 3. A Verdict on a Review of kind `review`, with a new revision of its target, in a later transaction than the Review | Not named: the words name the Review record. Required through point 7 (T-W07-N28's N28-S-verdict; DM-41) | The same in the bullet. Still required through point 7, and now also by B 3.11's own words (PC-46 place 1), which name the Verdict |
| 4. A Review of kind `sample` from any writer but the database's sampling path (a client asking for kind `sample`; the owner's direct insert), with a new revision of its target | ✘ | ✘: not "the database itself opens". The client path is also ✘ by point 3's fourth bullet |
| 5. The database's own sample, opened in the drawing call for the revision whose accepted write drew it | ✘ in plain words, while point 3's first bullet requires it ✔: the block could not be met | ✔: the exemption. The new ✔ clause requires it |
| 6. A further revision of the sampled target in the same transaction, after the sample opened, before any verifier acts | ✘ in plain words, but only when the hidden draw (DM-08) fell on the earlier write | ✔: a revision no review record names (T-W07-N28's N28-pos) |
| 7. Taking a sample (setting its reviewer fields, if the build takes it that way) with a new revision of its target | Not named: the words name the transaction that writes the Review record, and taking an existing row is an update | ✘: added |
| 8. A Verdict on a `sample` Review with a new revision of its target | Not named in the bullet (DM-41 covers it) | ✘: named |
| 9. The repair opened as a separate work item | ✔ | ✔, unchanged |

*Why the old block could not be met.* Point 3's first ✔ has the database itself create the sample "for format-gated records it accepts", and B:266 makes it "a record the database makes by rule within that call". A build that meets point 3 meets case 5, and so fails point 5's ✘ in its plain words. A build that meets point 5 refuses every drawn write, and so fails point 3. The only builds that met both moved the sample out of the call (2.4, B1 to B4). Those go against B:266 and carry the costs 2.4 states. A condition that no build following the plan can meet is a defect of the condition. Ledger rule 3 allows it to be corrected on a block with no result, provided nothing else is let through.

*Why the difference is the exemption and nothing more.* The new wording admits two cases the old refused: 5 and 6.
- Both arise only while the sample row has no reviewer and no verdict and was written by the database for the drawn revision. In neither does a verifier act in the transaction.
- Case 6 is no further exemption. It is N28-pos's rule (a revision that no review record names). Read with point 3, the old wording made that rule depend on whether the hidden draw fell on an earlier write.
- Every case in which a verifier writes or takes a review record stays refused (1, 2, 4, 8) or is newly refused (7). Case 3 stands as it stood.
- The exemption's bounds are in its words: "the database itself opens" (case 4 refused; 2.2 condition 2), "for the record revision that draws it" (condition 3), and "takes it or writes its verdict" (condition 4's end).
- The new ✔ clause is a requirement the old block lacked. A build that refuses its own samples now fails point 5, where before it failed only point 3.
- What the build cannot establish of these bounds, it refuses (2.2's fail-closed rule; point 7: "'could not check' is never a pass").

*What else in the block, and why nothing more changes.* Point 3's fourth bullet ("A `sample` Review written with any environment token, the working environment's included, is refused") is kept. Read with its first bullet ("the database itself creates") and its source (B 3.11: "created by the database, never by an agent"), it refuses a sample a caller writes. The database's sample is made "by rule within that call" (B:266), with `origin = rule`: it is no caller's write, although its event carries the caller's role class (DM-31). On that reading, point 3's bullets and point 5's new bullet can all be met. **[Inf]** If a checker reads the fourth bullet as covering the database's own sample, point 3 conflicts with itself, apart from N28, and the same correction is needed there, with the same argument: what stays refused is a sample written by any writer but the database. Point 7 requires T-W07-N28 to pass. Its clause table quotes Appendix C N28, which PC-46 place 2 changes, so the test gains the new clauses and 2.5's cases before its first result (README section 8; 3.4). The block's words need no change for that. Points 1, 2, 4, 6, 8 and 9, point 5's other bullets, "Who judges" and "Not covered" do not name the review record and are unchanged.

*Appendix C N28 (PC-46 place 2)* is judged by the same table, with "the review record" in place of "the Review record". PC-46 place 1 widens B 3.11's own words to DM-41's reading (every target, and the Verdict), which loosens nothing.

*What this rests on.* The following are documented: B:266's "within that call" and point 3's first bullet; and that no verifier acts while the sample has no reviewer and no verdict (B:232's reviewer fields; B:247, "queued for the audit environment"). That the producer gains nothing from the exemption is inference (2.3, last bullet). This is the producer's argument, not a verdict. The change's checker judges it (section 4, item 9).

### 3.4 W-C02-07's tests (the executor's, before any result; README section 8)

T-W07-5B gains the ten rows of 1.2 and R15's function (1.4). Its "Could not check" item on the ten functions and its `w07_fn_cfg` key `R15` change accordingly. T-W07-N01's, T-W07-5D's and T-W07-T31's "Phase C" lines, and the first bullet of T-W07-N28's "Not covered", cite section 2 in place of the assumption. The cases of 2.5 are added. Nothing here changes a test file.

*Added 2026-10-12, from 1.7 and PC-46:* T-W07-5B also gains the rows of 1.7.2 (`operation_state`), 1.7.3 (the ledger transfer's fourteen functions) and 1.7.4 (`set_effort_policy` at the gate, with R08 kept as the operation row T-W07-N03 tests), and RT-cal-n4, N04-k-set_effort_policy and T-W07-6TK's list are checked against 1.7.4. T-W07-F07's line 10 takes README section 8.1's argument name. Rules O and C (1.7.1) need cases of their own, outside the role gate. T-W07-N28's clause table takes PC-46 place 2's text.

*Added 2026-10-12 (CHK-C02-025 C2):* with `set_effort_policy` at the gate (1.7.4), these cases keep every cell of EV-C02-003 §4.1's effort row tested: (a) with the `devos_sinav` token, a reduction refused, and writing and retiring a standing policy each refused (§4.1's effort row, `sin` ✘); (b) with the `devos_denetim` token, a kind (a) write refused; (c) kind (a) under Rule O refused for `devos_kurulum` on a work item outside the installation, and for `devos_sinav` on a work item its exam link does not name.

*Added 2026-10-12 (CHK-C02-026 C2):* T-W07-N01's break B-N01-2 (`tests/C02/W-C02-07/breaks/B-N01-2_sample_written_by_agent.sql`) wraps `open_review` to insert a `sample` row without the sampling path's marker; under section 2.2 condition 2 the Review table's check still refuses that row, so N01-tok-* no longer turn red. The break is revised before any result: either it also bypasses the table check, or there is one break per layer, each with the case that turns red.

## 4. What stays open

*Added 2026-10-12:* items 1, 4, 5 and 6 are decided in section 1.7 (1.7.1, 1.7.2, 1.7.3 and 1.7.4), and the plan text of section 3.2 is carried by PC-46; the text below is as first written.

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
11. **The exam fact through DM-35's reads** (CHK-C02-025 C1 and F2; added 2026-10-12). EV-C02-002 DM-35 (a) hides an exam task's Work from `devos_calisma` in `affected_entities` and `explain_paths` (a record linked to an exam through EvalRun is outside every class's authority but `devos_sinav`'s; T-W07-F04's F04-c-noleak tests it), while 1.2's `ready_works` row and Rule O let `devos_calisma` see and change the same Work as ordinary work (B:286). The difference tells a working session which tasks are exams: a call on its own exam task's input answers "limited" with that task missing. Owner: the executor. Deadline: before W-C02-09 builds `affected_entities` and `explain_paths`. A fresh checker judges the resolution. Note N-262. *Added 2026-10-12:* decided in section 5.1 (DM-35 narrowed to the exam's own records; the two reads walk relations only; every answer to the subject the same), for a fresh checker to judge.
12. **The sample's position after the draw** (CHK-C02-026 F11; added 2026-10-12). DM-08 (b) relies on the sample's hidden position to keep a writer from timing a meaningless record past the sample, but EV-C02-003 §4.1 lets every class read reviews, so a writer who sees a sample appear in a block knows the rest of that block is unsampled. 2.3's "hidden" covers only the position before the draw. Owner: the executor. Deadline: before W-C02-10 builds the sampling. Note N-263. *Added 2026-10-12:* decided in section 5.2 (a sample, its verdict and its creation event withheld from every class but `devos_denetim` until its block is complete), for a fresh checker to judge.

## 5. N-262 and N-263, decided (2026-10-12)

*Added 2026-10-12, by a third fresh-context producer of the same session (declared, Ek A 5.3), at the executor's task.* These are the builder's technical decisions (Batu's D-033; working order section 8): none needs money, touches Batu's accounts or conflicts with his decisions. A fresh checker judges them before W-C02-09 builds `affected_entities` and `explain_paths`, before W-C02-10 builds the sampling, and before W-C02-07's tests of them get a result. Labels as above; line numbers are at `main` `310e0c4`. **Further sources read for this section, 2026-10-12:** B:26, B:35 to B:41, B:246, B:247, B:266, B:270, B:284, B:286, B:391, B:452 (section 7, "Privacy"), B:478; G2 items 1 to 4 (G:22 to G:25); C:61 to C:68 (F04), C:118 (N01), C:123 (N06), C:125 (N08), C:146 (N29), C:161 (K06); P:566, P:642, P:726, P:813, P:814; EV2 DM-08, DM-24, DM-31, DM-35, DM-36; EV3 §4.1 to §4.5 and §15; CHK-C02-025 F2, F7 and C1; CHK-C02-026 F10 and F11; `plan/work/W-C02-09.md` points 7 and 8, `W-C02-10.md` points 3 and 5, `W-C02-12.md` point 5. Also W-C02-07's unmerged T-W07-F04, T-W07-N08, T-W07-N01 and T-W07-T31 in full, and README section 8.1's lines on reads, read only for what they assume.

### 5.1 N-262: the exam fact through DM-35's reads

**The conflict (Doc).** DM-35 (a) puts "a record linked to an exam through EvalRun" outside every class's authority but `sin`'s. Through DM-24's `work_ref` that record is the exam task's Work, and T-W07-F04's F04-c-noleak tests the Work hidden from `cal`. But B:286 opens exam tasks "in the working environment as ordinary `Work`", and P:813 says the working environment "carries it out like normal work and does not have to know that the task is an exam". 1.2's `ready_works` row and Rule O give `cal` the same Work. So "limited", with the task missing, tells a working session which tasks are exams (CHK-C02-025 F2). The same holds when the task is the root (G2 item 4). P:814 makes the audit roles exam subjects too.

**Decision.**

(a) **What DM-35 hides: the exam's own records, never the Work.** "Outside authority" in DM-35 (a) means, from this record on, the exam records:
- EvalRun, every field, `work_ref` included;
- Competence's fields that `competence_summary` does not return;
- any record of the exam schema that C05 adds, the answer keys among them (P:813).

They are refused to every class but `sin`, as B:35 to B:38, B:286 and EV3 §4.1's exam row (EV3:284) already say. The Work an exam task was opened as is ordinary for every class, with the rights and checks an ordinary work item gets (1.2; Rules O and C). So are its revisions, claims, relations, effort policy, contributions, products and samples.

(b) **The two reads walk relations only, and no relation has an exam record at either end.**
- `affected_entities` and `explain_paths` follow Relation rows (B 3.4; B:391), never EvalRun's `work_ref`, for every class, `sin` included. `sin` reads the link through R10r's reader (1.4).
- `relate` refuses, for every class, a relation that names an exam record at either end (B 3.15's rule, as 1.3 reads it for `sin`). For a class other than `sin`, the answer and the recorded reason code are those for an id that names no record.
- So no walk an application role can make meets an exam record. An exam task's graph gets the result and the completeness flag of the same graph of ordinary work.
- A root or target that names an exam record gets, for a class other than `sin`, the answer and the recorded reason code of a root that names no record. G2 item 4's check of "the existence of the root record and the authority to access it" thus never tells such a record apart from none.
- The hidden-node handling that G2 item 4 and F04 (c) require is still built and tested, on a graph only a fault could make (the planted cases below).

(c) **Every answer to the subject the same: property P.** For a class other than `sin`, every C02 function gives the same answer on a work item an EvalRun names as on the same work item with no EvalRun: the same result, status, reason code, completeness flag and refusal. No such call succeeds or fails because of the link. The build keeps these bounds:
1. No check made for a class other than `sin` reads EvalRun. Rule O already reads nothing about exams for `cal` (1.7.1); this adds the two reads (b), readiness and `claim`.
2. `record_eval_run` writes no field, revision or event on the Work it names, and changes nothing that a read by another class returns. This extends DM-24's "No exam field on Work" to revisions and events.
3. `claim` refuses `sin` on a work item that an EvalRun names: the subject claims it (B:286; P:813). `record_eval_run` refuses to name a work item on which `sin` holds an active claim. So Rule C never refuses the working class on an exam task because `sin` holds it (CHK-C02-025 F7). A refusal by Rule C, or by `claim`'s single active claim, never names the claimant's class. This is F7's recommendation; 1.7.1 already says it for the opener.
4. No read callable by a class other than `sin` returns the `role_class` of a Work's events or the class that opened it. An exam task's creation event carries `devos_sinav` (B:266, "never declared"). C02 builds no such read: B section 4 names none, and R12's four objects are not events (1.4). A later read that returns events to those classes needs its own row and a form under which P holds, judged before it is built.
5. Out of the database's reach: the task's own text, scope, Mission, labels and its EffortPolicy's `work_class` must look like ordinary work's. `sin` writes them, and C05's exam-set design governs them (N-138). No rule here can check them.

(d) **What stays, with owner and deadline.**
- **The audit class reads RejectedAttempt.** EV3 §4.1 gives it that read, and the rows keep `role_class` and `target_ref` (B:270). So a refused `sin` call on an exam task tells `den` that `sin` acted on that work item. That matters once an audit role sits an exam (P:814). The working session is not affected. Owner: the executor. Deadline: before C05 opens an exam task for an audit role (carried under N-138; 1.7.5 (b)). A candidate for C05: `sin`'s refusals on work items an EvalRun names are kept where only `sin` reads.
- **The export.** `bak` reads every record into the private `devos-backup` (P:566). No environment session attaches that repository: P:726, "only `devos` is attached and written". That rests on the guard. C09 designs the export.

**Alternatives weighed.**
- **(i) Keep DM-35 (a) on the Work and hide the exam task from the working class everywhere** (`ready_works`, `claim`, Rules O and C). Not chosen: the subject could not do its task, against B:38 and B:286 ("as ordinary work") and P:813.
- **(ii) Keep DM-35 (a) on the Work and hide it only in the two reads.** Not chosen: this is the leak F2 states.
- **(iii) Walk `work_ref` as an edge, with the EvalRun behind "limited".** Not chosen: "limited" would arise only on exam tasks' graphs, the same leak one step further on.
- **(iv) Make "limited" carry no signal,** by answering it on every call of another class, or at random. Not chosen: G2 item 2 needs a complete result for a negative verdict, and G5 item 1's review needs one too. A flag that is always or randomly false says nothing.
- **(v) Take exam tasks out of the working environment.** Not chosen: it goes against B:286 and P:813 as they stand, and it is C05's form (N-138). 1.7.5 (b) reopens this record if C05 chooses it.
- **(vi) A separate Work table, or shadow rows, for exam tasks.** Not chosen: every read would have to merge them identically, which is more code where a leak can hide, for the result (a) and (b) already give.
- **From scratch (D1).** With no DM-35, a design that starts from B:286 and P:813 draws the line at the exam's own records, as (a) does.

**Checked against.**
- **B section 2's "Cannot" lines (Doc).** B:35 refuses `kur` "reading or writing exam records (`EvalRun`, `Competence`, the exam schema, the fact that a task is an exam)"; B:36 and B:37 refuse "reading exam records". All are kept. The Work is not among the exam records (B:286, "ordinary `Work`"). The exam fact stays unreadable, and after (c) no answer carries it.
- **Appendix C.**
  - N08 (C:125), "the fact that an exam task is an exam is kept in an area the working environment cannot see": served in C02 by DM-24's form and (c). Its C03 part (what a session sees; N-137, S2) gains P as a testable property.
  - N06 (C:123): no exam record becomes readable by any class, so none reaches the public repository by this change. The answer keys stay in the exam schema (P:813).
  - K06 (C:161) and its C03 run: no function's role list changes. R10r and `record_eval_run` stay `sin`-only (T-W07-5B unchanged).
- **EV3 §4 and S8.**
  - §4.1's exam row and reads row are unchanged.
  - S8 line 1 (§4.2: `kur` never reads the exam records or the exam fact) and S8 line 2 are unchanged.
  - (c) 3 adds a check after the gate to §4.1's `claim` cell "its exam work" (EV3:277), read as work `sin` runs itself, not a subject's task **[Inf]**.
- **EV2.**
  - DM-24 is kept and extended by (c) 2.
  - DM-35 (b) calls its rule "the only visibility rule C02 has beyond role-class writes". 5.2 adds a second one (open samples), so "only" no longer holds. EV2 gets a pointer line.
- **W-C02-09's and W-C02-12's acceptance blocks.**
  - W-C02-09 point 7 (completeness at a limit; F04 (d)) is unchanged.
  - W-C02-09 point 8 ("F04 with K05") is unchanged in its words; T-W07-F04 changes before its first result (below).
  - W-C02-12 point 5 ("the working token on … reading an exam record") is unchanged: EvalRun stays refused.

**What is inference.**
- That the two reads walk Relation rows only: B:391 groups them under Relation, and T-W07-F04 assumes `devos_private.relation`.
- (c) 3's reading of "its exam work".
- That no C02 read returns events to an application role other than `bak`.
- That no session reads `devos-backup` by another route.

**Doc:** the ground of the narrowing (B:284, B:286, P:813) and the "Cannot" lines.

**W-C02-07 cases to change.** These are the executor's, through the test designer, before any result (README section 8). IDs are suggestions.
- **T-W07-F04.**
  - Header line and clause-table row (c): the node outside authority becomes an exam record, an EvalRun row planted by the owner as a relation end (a graph no function can make; (b)). The row's note "'outside authority' is DM-35's exam link" changes to "DM-35 as narrowed by EV-C02-008 5.1".
  - **F04-c-noleak**, on that graph: with the working, audit and `devos_kurulum` tokens, no result holds h's id.
  - **F04-c-flag**: unchanged (`complete = false`), on that graph.
  - **F04-c-pos**: unchanged.
  - **"Not covered"**: its line "Visibility beyond DM-35's exam rule" now cites 5.1 and 5.2 (open samples are no relation ends).
  - New cases, and the breaks that must turn them red, are in the table below.
- **T-W07-N08.** Gains N08-s3 and N08-s4 (table). N08-s1 and N08-s2 are unchanged.
- **Rule O's cases (1.7.1, "Tests this asks for"), or a test of their own.** They gain the pair cases EXF-pair-* (table), which also carry 1.7.1's "answers equal" case.
- **T-W07-5B.** Unchanged: no gate cell changes.

| Case | Planted | Must be observed | Break that turns it red |
|---|---|---|---|
| F04-e-exam | r ← x ← h3 ← y, h3 a work item that a planted EvalRun names (DM-24); working token | `affected_entities(r)` gives x, h3 and y, `complete = true`, equal to F04-c-pos's; `explain_paths(r, h3)` gives its path; with h3 as root, the answer has the same form as with F04-c-pos's h2 | B-F04-4: the walk drops a work item an EvalRun names for a class other than `sin` (DM-35's old reading). B-F04-5: the walk follows `work_ref` as an edge and reports the EvalRun behind "limited" |
| F04-c-sin | F04-c-noleak's graph; exam token | h found, `complete = true`: the filter goes by class and is not a blanket drop | A break that drops exam records for every class: F04-c-sin red |
| F04-m3 | root = a planted EvalRun's id; working token | The answer and reason code of F04-m1 (a root that names no record) | B-F04-6: the root check answers an exam record with an authority refusal |
| N08-s3 | `record_eval_run`, exam token, on a planted work item | The Work's rows, revisions and events, counted and compared before and after, are unchanged | B-N08-3: `record_eval_run` also writes an event on the Work |
| N08-s4 | `claim` with the exam token on a work item an EvalRun names; and `record_eval_run` on a work item `sin` has claimed | Both refused, recorded | B-N08-4: (c) 3's check removed |
| EXF-pair-* | Work items w_e (an EvalRun names it) and w_o (identical, no EvalRun); working token | `ready_works` lists both, or neither. `claim`, `heartbeat`, `release`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `relate`, `retract_relation` and `set_effort_policy` of kind (a) give the same status and reason code on each, accepted and refused (a stale revision, an empty required field, a claim another working session holds); the two reads as F04-e-exam | Rule O reading the exam link for `cal` (1.7.1's break); B-F04-4; B-N08-3; B-N08-4 (with `sin` able to claim w_e, the Rule C pair differs) |

### 5.2 N-263: the sample's position after the draw

**The conflict (Doc, then Inf).** DM-08 (b): "The random position keeps a writer from timing a meaningless record past the sample". B:478 says the position is "not visible to agents". But the audit environment reads the sample as soon as it is opened (B:247: "queued for the audit environment"). EV3's reads row (EV3:286) gives every class "review verdicts", and R12's reader is W-C02-09's to name (1.4). CHK-C02-026 F11 reads that row as letting every class read reviews. Whether an open sample with no verdict would be returned is therefore left to how W-C02-09 builds that reader **[Inf]**, so this section decides it. W-C02-10 point 3 asks the record to show "that nothing a writer can choose decides it".

**Decision.**

(a) **Withheld until the block closes.** While the block of the stream that drew it is still that stream's open block, no read returns any of these to any class but `den`, whose queue holds them at once (B:247):
- a `sample` Review;
- any Verdict on it;
- its creation event.

Once that block is complete (its last record accepted), they are readable as any Review and Verdict are (EV3:286; 1.4's R12).
- `ci` is withheld like the environments **[Inf]**: its check results can be read in the public repository's pull-request checks.
- `bak`'s read for the export (B:41; P:566) is not withheld. It writes no stream record, and its output goes to the private `devos-backup` (P:726; 5.1 (d)).

(b) **Nothing else tells.** The drawing call's answer, the sampled record's fields, revision and events, and the RejectedAttempt rows are the same whether the record was drawn or not. No read returns:
- a stream's block state (`sample_stream`; DM-08 (a): "not visible to agents");
- a count that changes with open samples;
- a walk node that is a Review (Reviews are not relation ends; 5.1 (b)).

(c) **A strong random source for the draw.** The block's position is drawn from a cryptographically strong source (for example `gen_random_uuid()` or pgcrypto's `gen_random_bytes`), never from `random()`. Then a closed block's position tells nothing about the next block's. **[Inf: PostgreSQL's documentation as remembered, not read today; W-C02-10's record cites what it reads.]**

(d) **Where it is built.** W-C02-10 builds it with the sampling. It applies (a) to every read function existing then that can return a Review, a Verdict or an Event, R12's reader from W-C02-09 among them. Its record lists those functions, with the cases below, as part of point 3's "shows that nothing a writer can choose decides it".

(e) **What stays, with size, owner and deadline.**
- **The audit class writes in the EffortPolicy stream.** It writes reductions and standing policies (1.7.4 (b), (c)), and it must read every sample to judge it. So for its own EffortPolicy records the position is not hidden from the writer. Principle 8 draws no line inside the audit environment.
  - Size: every EffortPolicy record `den` writes. In C02 there are none outside the tests.
  - Owner: the executor. Deadline: C03's design of the audit environment's sessions, before they write effort policies. Candidates: a block of its own, judged by a session that wrote none of it; or every such record reviewed.
- **Timing.** A drawn call does one more insert and event, which a writer timing its own Data API calls might detect **[Inf; not measured; the network's variation is likely larger]**. Owner: W-C02-10's record states it. It is read again in C06 with the audit queue (N-214 item 3).
- **Delay.** In a rare stream (decisions of class `high_impact` or `batu` at `open`) a block may stay open for weeks. Until it closes, the working environment sees no sample verdict on its records. C02 has no route from a sample verdict to a fix (`den` opens no work; §4.1 row 2). C03's design of that route either waits for the close or states the leak it accepts. That reopens this section.

**Alternatives weighed.**
- **(i) Accept the residual.** Not chosen. The size follows from DM-08 (a): one sample per block of 10, at a uniform position. A writer that sees the sample knows on average 4.5 of the block's 10 records are unsampled. A writer that waits for the sample before writing a meaningless record escapes in 9 blocks of 10, and, if it waits on into the next block, every time. Against a writer that watches, that is DM-08 (d)'s rejected "every tenth", and W-C02-10 point 3 could not be shown, because the writer's choice of moment would decide.
- **(ii) More than one position per block** (for example 2 in 20). Not chosen. N01's rate without tolerance needs an exact count per block (DM-08 (b)). With an exact count, once the count is reached in view the rest of the block is known; more positions only move that moment.
- **(iii) A position the writer cannot infer from what it sees.**
  - An independent draw per record (probability 0.1) tells nothing when seen. But it makes the count inexact (DM-08 (d)), and N01 and T-31 would need a tolerance written after this finding, which changes a criterion. Not chosen.
  - Block boundaries at a hidden offset: the offset is learned from the gaps between seen samples (a gap of 19 fixes it). Not chosen.
- **(iv) A deferred draw:** pick the sampled record when the block completes, and open its sample in that call. It needs no read rule. Not chosen:
  - the audit queue waits for the block, which in a rare stream is long;
  - the sample would open in another record's call, against 2.2's condition 3 and PC-46's B:246 text ("for the record revision whose accepted write draws it"), which a checker accepted;
  - its event would carry another writer's class (DM-31).
- **(v) Withhold samples from the writing classes for good.** Not chosen: once the block closes DM-08 does not need it, and it would take from every class a verdict on its own work that the reads row gives it.
- **(vi) Withhold only from the class that wrote the sampled record.** Not chosen: a stream has writers of several classes (`cal`, `kur`, `sin`, and `den` in EffortPolicy), and any of them could read another's sample to locate the position.

**Checked against.**
- **B 3.11 and principle 12** (B:26; B:247: created by the database, queued for the audit environment): unchanged, and the queue is `den`'s at once.
- **B:478's "not visible to agents"**: until now no rule made it true (see the conflict above); it is made exact for the open block (5.3).
- **DM-08.**
  - (a) stands.
  - (b)'s "hidden" now holds from the draw to the block's end, and after it nothing about the next block follows ((c)).
  - (d)'s rejection of "every tenth" keeps its reason.
- **Section 2 of this record**: unchanged, that is 2.2's conditions, DM-41 and the taking. 2.3's last bullet ("The draw is random within each block and hidden") now holds for the open block. 2.5's cases read as the owner and are unchanged.
- **W-C02-10's acceptance.**
  - Point 3: no word changes. Its last-but-one bullet can now be shown; T-31's number, rate and tolerance are unchanged.
  - Point 5 is untouched.
- **EV3's reads row** (EV3:286): a gate row, unchanged. (a) is a check after the gate, as 1.1 reads §4.1's qualifiers. `ci`'s read of review verdicts (B:40) is delayed for a sample's verdict, not refused.

**What is inference.**
- (c)'s statement about `random()`.
- That `ci`'s results are publicly readable.
- That no session reads `devos-backup`.
- The size of every residual except (i)'s arithmetic.

**W-C02-07 cases to change** (before any result; README section 8):
- **T-W07-N01.** Gains the N01 cases of the table. Its "Not covered" item "that the hidden position is random and unseen by agents (shown only in part …)" narrows to the random source ((c), shown by W-C02-10's record). B-N01-1 to B-N01-3 stay, with B-N01-2 revised as 3.4 says (CHK-C02-026 C2).
- **T-W07-T31.** Its planted numbers, rate 2 in 20 per stream and tolerance 0 are unchanged: it counts samples as the owner. It gains T31-unseen-<stream>. Its "Not covered" gains (e)'s first two items.
- **T-W07-N29.** Its routine streams (work items and decisions) get the same unseen case, unless the designer puts them in N01.
- **T-W07-5B, T-W07-N28 and 2.5's cases.** Unchanged.

| Case | Planted | Must be observed | Break that turns it red |
|---|---|---|---|
| N01-unseen-<class> (`cal`, `sin`, `kur`, `ci`) | A block opened by alignment, the drawing write accepted, the block not yet complete. Each read function that can return a Review, a Verdict or an Event (found by its text, as T-W07-N08 finds EvalRun's readers), called with that class's token | No result holds the sample's id, its target's sampled state, or any value that changes with it | B-N01-4: the withholding removed (a reader returns open samples) |
| N01-unseen-den (positive) | The same; audit token | The queue read returns the sample | A break that hides it from `den` too |
| N01-unseen-after (positive) | The block completed; a Verdict on the sample with the audit token | With the working token, R12's reader returns the verdict | A break that withholds for good |
| N01-same-answer | One complete block of ten needs | The ten answers differ in nothing but each record's id | B-N01-5: the drawing write answers with a sampled mark |
| T31-unseen-<stream> | Each of T-31's four streams, inside a planted block, with the writing class's token (`cal`; for EffortPolicy, kind (a)) | As N01-unseen | B-N01-4's patch, applied to T-31 as well |

### 5.3 Plan text, record text and acceptance blocks

**Plan text, for the executor to change through plan Section 14.** Old texts are quoted from `main` `310e0c4`.

**Place 1 (5.1). B:286, Appendix B 3.15, the last sentence of its rules.**
- Old: "Exam tasks are opened in the working environment as ordinary `Work`; in the `Work` record, the fact that the task is an exam is kept in a field the working environment cannot see."
- New: "Exam tasks are opened in the working environment as ordinary `Work`. The fact that a task is an exam is kept only in `EvalRun`'s link (above), never in a field of the `Work` record; the exam records stay hidden, and no function answers the working environment differently for an exam task than for ordinary work (`evidence/C02/EV-C02-002_data_model_choices.md` DM-24 and DM-35; `evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md` section 5.1)."
- Why. The old sentence's "field" has disagreed with B:284 ("the link lives only here") since PC-42 and DM-24. The decision states its property where B states the exam's rules. It names the working environment only, since the audit class's RejectedAttempt read stays open until C05 (5.1 (d)).

**Place 2 (5.2). B:247, Appendix B 3.11.**
- Old: "- A review of kind `sample` is created by the database, never by an agent, for a set share of the records a format gate accepts (principle 12) and of the work items and decisions labelled `routine` (3.3, 3.17); it is queued for the audit environment, which judges the content and the label (PC-08)."
- New: the same, followed by: "Until the block of its stream that drew it is complete, the sample, any verdict on it and its creation event are read only with `devos_denetim`, and by the backup job for the export (`evidence/C02/EV-C02-002_data_model_choices.md` DM-08; `evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md` section 5.2)."
- Why. B:40 gives `devos_ci` "review verdicts", and EV3's reads row gives them to every class. Without a rule in B, the withholding would rest on a design record that a plan line, read literally, contradicts.

**Place 3 (5.2). B:478, section 8's table, the row "Sample share".**
- Old: "One record in every block of 10 of a stream, at a position drawn at random when the block opens and not visible to agents."
- New: "One record in every block of 10 of a stream, at a position drawn from a strong random source when the block opens; until the block is complete, neither the position nor the `sample` Review it opens is visible to any agent but the audit environment's (3.11; `evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md` section 5.2)."
- Why. The audit environment, an agent, sees the sample once it is drawn (B:247). Without (a), writers would see it too. The new text says who sees it and from when.

**Not changed on purpose.**
- B:26 (principle 12): still true.
- B:35 to B:41: no "Can" or "Cannot" changes.
- B:452 and G2 item 4: still true. In C02 no unseen region arises in a walk made through the functions.
- C:61 to C:68 (F04 (c)): its node outside authority is planted.
- C:118 (N01) and C:125 (N08): served as they read.
- P:642, P:813 and P:814: true, and the ground of 5.1.

A search of B, C, G and P for "exam task", "is an exam", "hidden" and "not visible" found no other text these decisions make untrue.

**Record text superseded, not edited (pointer lines instead).**
- This record's 1.2 row for `affected_entities` ("records linked to an exam are hidden from every class but `sin`").
- 1.3's row for the two reads ("DM-35 (F04 (c)) has these two functions hide exam-linked records").
- 1.7.1's dated limitation of its exam-task bullet: 5.1 resolves it.
- EV2 DM-35 (a) and (b), and DM-08 (b)'s "hidden": each has a dated pointer line.

**Acceptance blocks.**
- **W-C02-09 point 8 ("F04 with K05").** Its words are unchanged; T-W07-F04 changes before its first result. Not loosened **[Inf]**: (c)'s negative on a hidden node stays, and F04-e-exam, F04-m3 and F04-c-sin are added.
- **W-C02-09 point 7.** Unchanged.
- **W-C02-10 point 3.** Its words are unchanged. 5.2 is what lets "shows that nothing a writer can choose decides it" be met. Not loosened: cases are added and none is dropped.
- **W-C02-10 point 5 (the EvalRun bullet).** Unchanged. N08-s3 and N08-s4 add cases; the designer names the item each serves (`claim` is W-C02-09's).
- **W-C02-12 point 5.** Unchanged.

No acceptance block needs new words.
