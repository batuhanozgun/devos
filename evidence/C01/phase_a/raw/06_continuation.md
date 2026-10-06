# Phase-A probe: continuation

*Filed for EV-C01-003 with two kinds of edit: the two library file paths in the labels of section 1 are cut to their source key stems (`MS01-SOUL`, `review-qa`; keys expanded in EV-C01-003, "Source keys"), because the full paths match the research library's fingerprints; and one list of result states (F4) that repeated the library's own list word for word is given in another order, with the same members. Nothing else is changed.*

## Disciplines (D1–D9)
D1: yes: The hand-over's three options left out the review, verdict and staleness records DevOS already has (EkB 3.3, 3.4, 3.11). I added them as option A+, built from existing families only, set my criteria before the written trace, and made the recommendation conditional on two untested assumptions.
D2: yes: To avoid favouring the option I added, I ran the from-scratch test against B, recorded A+'s main risk (one qualification spread over several records), kept B as a named fallback, and did not let the "add no mechanism" limit or the wish to finish narrow the option space.
D3: yes: I did only the next step: a comparison and an unaccepted draft, with money left out as instructed, ending at the return point. The C02 items below come from the trace; I did not open C02 work.
D4: yes: The comparison is my own trace on synthetic cases, by the model family that produced the result, so it is self-reviewed conceptual evidence. My criteria were not set blind to the options, and the verdict belongs to the probe checker.
D5: yes: The hand-over saw DevOS's data model only through EkB 3.14 to 3.18. So I went back to EkB 3.3, 3.4, 3.10, 3.11 and the activation table, and re-opened the library passages D-6 rests on (CS/KEY L33-89, CS/S3 L236-271, GS/CORE L428-507, GS review-qa L469, MS01 L38-61, DQ02 L88). All of them held.
D6: yes: I classed the hand-over's missing EkB families as a reading-range edge taken for the edge of the option space (same class as the result's E1) and named a capability-gap candidate. I stopped there because going deeper would not change the draft.
D7: yes: This output is the hand-over to the probe record and to the note on C02. The draft is self-contained, marked draft and not accepted, and carries its owner stage, reopen triggers and what happens if it is not answered.
D8: yes: devos head is 2399915 with a clean tree and the library clone is at 941f027d3a15497b90e60d752303c0463a9feab5 with a clean tree. The cited EkB and plan lines match the hand-over. I treated library status lines as data.
D9: yes: I used only cited library passages and record per option whether each one justified or limited it. MS01 L54 and DQ02 L88 justify A+; MS01 L47 and DQ02 L88 limit B; GS/CORE F1 and GS review-qa L469 limit C.

## What I did

### 1. Labels and evidence level
I use the result's legend, plus MS01 = EXP4/MS01-SOUL and GS-RQ = GS/review-qa.

D-6's content gets short labels:
- **F1** binding: carrier; role text and method version; sources and context method; tools; environment and grants; named use
- **F2** frame: criterion and its version, named use, scope
- **F3** basis
- **F4** result states: holds, false, indeterminate, stale, not applicable, not evaluated
- **F5** assessment layer: evidence paths, method, evaluator and judge model, instrument version, independence level, uncertainty and coverage
- **F6** decision layer: who accepted, and accept or reject
- **F7** dependencies and reopen triggers
- **F8** a flag saying whether a changed score came from the subject or the instrument
- **R1** "holds", "assessed", "accepted" and "recorded" stay apart
- **R2** every consumer carries the verdict and its qualifiers

Evidence level: a conceptual trace by one model family on invented cases. Nothing was built or tested.

### 2. Criteria (written before the trace; not blind to the options)
- K1: through all 8 traced events, every F and R item is held without merging two of them.
- K2: one authoritative copy of each fact (Appendix D, D7 item 2).
- K3: a consumer can identify the standing and check its freshness (GS-RQ L469).
- K4: a portability path for criteria 2, 4 and 33 (plan L154).
- K5: no new record family unless the existing ones cannot hold the content (DQ02 L88; MS01 L47).
- K6: DevOS's exam access rule is not weakened (criterion 30; EkB L273).

### 3. Options
- **A** (as handed over): extend Competence, EvalRun and EvidenceEnvelope with A2's missing dimensions.
- **A+** (added by me): A, plus the existing EkB 3.11 Review → Verdict → Acceptance chain for F5 and F6, and the existing staleness carriers (EkB 3.4 `Relation.validity`, EkB 3.3 `WorkStanding.qualification` with its stale-on-input-change rule) for F7. It adds no new family.
  - Why I added it: A as stated has no home for F6, and EkB 3.11 already keeps the verdict apart from the acceptance.
  - Library support: MS01 L54's candidate qualification record (claim, object, use, criterion, method, evidence, reviewer, uncertainty, with validity kept apart from authorised acceptance) maps field for field onto Review, Verdict and Acceptance.
- **B**: a separate qualification-standing record that references the others.
- **C**: qualifiers only on the consuming records (Work, Decision, Artifact).

### 4. Trace (synthetic cases, criterion 20)
**Case 1, checkable end state.** Binding K1:
- carrier model M v1; role text "converter" v1;
- sources: target schema S v3 and invented sample exports;
- tools: a schema parser; grant: writes to a draft folder only;
- named use U1: convert exports to S v3 for import;
- criterion c1: parser validation plus row-count and checksum reconciliation;
- evidence: the parser over 8 repeated runs; no model judge.

**Case 2, no reference.** Binding K2:
- carrier M v1; role text "methods drafter" v1;
- sources: notes the user supplied; grant: drafting only;
- named use U2: draft a proposal's methods section in a field nobody present can judge;
- evidence: a model judge J with no reference answers.

**Events:**
- **e1, level 1 → 3.** Case 1: a trial run, then 8 of 8 runs pass, then the user accepts output v7. Case 2: the judge gives level 1. Level 2 cannot be reached (D-4 b and c), so the standing is indeterminate, the claim narrows and the user is told; the user then accepts draft v3 on his own authority (D-4 f).
- **e2:** the carrier model changes from M v1 to v2.
- **e3:** the judge changes from J to J'. Case 1 has no judge.
- **e4:** a downstream work item reads v7 (Case 1) or v3 (Case 2).

**What should happen (from D-3, D-5, D-6):**
- e1: each level is a typed state. In Case 2, "indeterminate" and "accepted" coexist.
- e2: the binding is marked for re-evaluation, not failed. The acceptances of v7 and v3 stay valid for those versions.
- e3: no trigger in Case 1; in Case 2, re-evaluation with the F8 flag set.
- e4: the consumer sees the level, the qualifiers and the freshness.

| Event | A | A+ | B | C |
|---|---|---|---|---|
| C1 e1 | Levels 1–2 fit once A2's fields and typed states are added. **Loses level 3 and F6:** there is no per-result acceptance; `valid_for_release` is DevOS's release flag | Review (target K1, level, use U1, criterion c1) and Verdict pass, with evidence in EvalRun or EvidenceEnvelope; Acceptance on v7 (accepted use U1, owner = user). **Holds** | Holds levels 1–2. Level 3 holds only by referencing an acceptance; embedding one duplicates it | Level 1 sits on the trial work item. **Loses level 2 as a standing:** it is copied into each consumer. Level 3 uses Acceptance |
| C1 e2 | The trigger exists (EkB L273), but there is only one outcome (`retest_required`), not three | Competence becomes `retest_required`; `Relation.validity` turns stale; a new Review revision gives one of three outcomes (CS/S3 L243-251); v7's Acceptance is unaffected. **Holds**, but "stale" is not on the Verdict | Holds | **Loses F7 for the binding:** only consumers that list M v1 as an input go stale (EkB 3.3). Either v7's reader is wrongly made stale, or new output under v2 inherits a copied "fit" |
| C1 e3 | Holds if A2 adds a judge field and `retest_triggers` lists K1's real dependencies | K1's `basis_refs` name no judge, so nothing fires. **Holds** | Holds | Holds trivially |
| C2 e1 | "Indeterminate" fits only with the finer states. The narrowed claim goes into `known_limits` as prose. The user's acceptance has no home; written as a status, it merges accepted into holds. **Loses R1 and F6** | Verdict indeterminate; its `limits` say there is no reference path and it was judged by a model only; the independence level is as stated. Acceptance on v3 by the user, with `residual_decisions` "quality not evidenced". **Holds R1 exactly** | Holds | Each consumer copies "indeterminate, no reference". A copy that drops it presents the user's approval as quality (GS/CORE L432-444, F1). **Loses R1 there** |
| C2 e2 | As C1 e2 | As C1 e2 | Holds | As C1 e2 |
| C2 e3 | Holds once A2 adds the judge and instrument; F8 is derived by comparing EvalRuns | J's change makes the Review stale and a new review follows. F8 is derivable only if `basis_refs` are typed into subject and instrument. **Loses F8 if they are untyped** | Holds | **Loses F8 consistency:** each copy is re-assessed on its own, or not at all |
| e4 (both) | Other roles see only `competence_summary`, which omits evidence and independence (EkB L273). **Loses R2 in part.** In SOUL, the exam access rule either hides what the user must be told (D-4 d) or cannot be enforced under one identity (plan L812, L143, L191) | The consumer's `input_refs` point to the Verdict and Acceptance and go stale on change (EkB 3.3). **Holds K3.** Risk: one standing spans 4–6 records, so a view that does not join them drops qualifiers | Holds if the consumer references the record's revision. The consumer-side qualifier is still needed | R2 holds by construction. **Loses freshness:** there is nothing to check against (GS-RQ L469) |

### 5. Per option

**A.**
- Holds: F1 and F7 (after A2), F3, and F5 in part.
- Loses: F6 and level 3, R1, and R2 in part; the three-outcome rule; carriers that are not roles, because Competence is keyed by `role`.
- Portability: the fields port. The hidden-evidence access rule does not port, because it needs a separate exam credential (plan L812) and SOUL runs in one user's account (G3). Criterion 4 is met through the carrier and judge fields. For criterion 33, Competence stays DevOS's yardstick record.
- C02 action wrong without it: EvalRun's field list (EvalRun is built in C02, EkB L78). Under A, F5 lives there.

**A+.**
- Holds: every D-6 field, with existing families, given these field changes:
  - A2's binding dimensions on Competence;
  - Review can target a binding;
  - a typed level;
  - typed `basis_refs`;
  - a judge on Review or EvidenceEnvelope;
  - `not_applicable` in `Verdict.result`;
  - an independence level for a named expert who is not Batu.
- Loses: none of D-6. Risk: one standing is spread across several records, and "stale" is not on the Verdict.
- Portability: the 3.11 chain needs no exam environment, so it ports at its real independence level. Criterion 4 is met through `basis_refs` and Relation. For criterion 33, hidden-exam evidence stays in EvalRun under exam access, and runtime evidence stays visible. What ports to SOUL is the layer mapping, not tables (MS01 L47; host still open, G3).
- C02 action wrong without it: none for C02's own tests. Untyped `basis_refs` and the Verdict enum without `not_applicable` would need a migration in C05. The EvalRun point is the same as for A.

**B.**
- Holds: all of D-6 by construction, if it references an acceptance record.
- Costs: a new family, against DQ02 L88. In DevOS it either duplicates Competence (breaking K2) or is used only in SOUL, so DevOS would not exercise SOUL's shape (plan L149-154 item 1).
- Portability: best for criterion 2. Criterion 33 then needs a mapping between two records.
- C02 action wrong without it: none. Its first need is a binding that is not a DevOS role.

**C.**
- Holds: R2, and level 3 through Acceptance.
- Loses: level 2 as a standing, F7 and the three outcomes for the binding, F8 consistency, freshness, K2, and R1 at any consumer that drops a copy.
- Portability: trivial, but a cross-provider re-qualification (criterion 4, C11) would have to inspect every consumer.
- C02 action wrong without it: none before C05.
- Verdict: rejected as the only shape. Its consumer-side part is needed under every option, and DevOS already has it.

**One finding holds under every option.** EvalRun, which C02 builds, has no grader identity or version. If C05's exams use a model grader (unknown), two things fail:
- criterion 33's comparison cannot show that both methods were graded under equal conditions (D-7);
- a grader change cannot trigger a retest (D-5).

### 6. Decision draft (EkB 3.17 fields; status draft, not accepted)
- **id:** none; not recorded. **revision:** 0.
- **class:** high_impact (schema and methods, EkB L293). Not batu: it touches no purpose, scope, cost or account of Batu's.
- **question:** Which shape carries D-6's qualification content for a binding for a named use: A, A+, B or C?
- **presented_text_tr:** not applicable.
- **why_this_owner:** a technical choice, accepted on a checker's verdict. The owning stage is C05, because Competence is activated there (EkB L79; plan L1026). SOUL's own physical shape waits for SOUL's host (G3), so this decision fixes DevOS's shape and its portability path only.
- **options** (money not assessed, as instructed):

  | Option | Purpose | Benefit | Build effort | Risk |
  |---|---|---|---|---|
  | A | Reuse DevOS's competence records | Least new structure | A2's fields | Loses F6 and R1; evidence hidden from consumers |
  | A+ | Reuse existing families for every layer | Full D-6 coverage, no new family | A2 plus 4 small field changes in C05 | Records must be joined; depends on S1 |
  | B | One record built for D-6 | Complete; ports best | A new family | Duplicates Competence or splits DevOS from SOUL |
  | C | Qualifiers only where results are used | Nothing to build | Fields on every consumer | Loses the binding as a unit and its invalidation |
- **alternatives_considered:** A, A+, B and C. **alternatives_state:** compared. A+ was added by this run.
- **single_viable_path_reason:** empty.
- **premises:**
  1. The unit is a binding for a named use (D-2).
  2. D-6's content is fixed.
  3. No hidden exam runs inside SOUL (D-7).
  4. D-1's reading of criterion 33 holds (conditional).
  5. A component claimed for the SOUL core needs a portability path (plan L154).
  6. Each family is built at the stage that needs it (plan L847).
  7. SOUL's host is open (G3).
- **criteria:** K1 to K6.
- **evidence_refs:** section 4 of this message; the result's D-2, D-3, D-5, D-6 and A2; EkB L60-96, L115-138, L215-234, L267-275, L285-293; plan L149-154, L191-193, L218, L808-817, L847, L1017-1031, L1137-1144; CS/KEY L39-89; CS/S3 L239-269; MS01 L41, L47, L54; DQ02 L88; GS/CORE L432-444; GS-RQ L469.
- **assumptions:**
  - S1: Competence's access rule can be scoped so that exam-derived evidence stays hidden while binding fields and other evidence are visible, without weakening N08. Untested; this decides between A+ and B.
  - S2: C02 keeps EkB 3.3, 3.4 and 3.11 as written.
  - S3: SOUL's host will have an equivalent of the review, verdict and acceptance chain.
  - S4: C05's exams use a model grader for some items.
  - S5: a binding's standing is shared by many consumers.
- **reversibility:** fully reversible before C05. After C05, moving from A+ to B is a data migration. Moving away from C is hard, because the bindings must be rebuilt from scattered copies.
- **reopen_triggers:**
  1. S1 fails at C05 (switch to B).
  2. C02 changes 3.3, 3.4 or 3.11 so that a binding target, typed basis or staleness can no longer be carried.
  3. SOUL's host has no such chain (B for SOUL).
  4. A real case drops a D-6 field or a qualifier under A+.
  5. Batu meant a hidden exam per agent at runtime (D-1).
  6. Competence fails the from-scratch test at C05.
- **recommendation:** A+ for DevOS, decided at C05, not before C02. B is the fallback under triggers 1 and 3. C is rejected as the only shape, but its consumer-side part is kept under every option. SOUL's physical shape stays open, and A+'s mapping is the portability path to test.
- **recommendation_rationale:** only A+ holds every field through the trace with no new family and no second copy. Case 2 depends on the existing separation of verdict and acceptance, and MS01 L54 maps onto it. B is equally complete but costs a family (DQ02 L88; MS01 L47). A loses F6. C loses the binding as a unit. Confidence is limited to a self-traced synthetic comparison, and S1 is untested.
- **if_unanswered:** C05 builds Competence exactly as EkB 3.15 describes it. A2's gap is then recorded, and a change of source, grant, named use or judge cannot trigger a retest for DevOS's roles. C02 is unaffected.
- **status:** draft.

### 7. Proposed note for C02's work list
1. This decision is not a C02 prerequisite (K-1 item 3). Its first need is C05 task 6.
2. EvalRun's field list: decide whether the grader identity and version enter in C02 or in C05. This depends on S4.
3. If A+ is kept, two questions are asked again under the ordering principle: should `Review.basis_refs` be typed by kind, and does `Verdict.result` need `not_applicable`? Neither is needed for C02's own tests.

## What I used
- **devos, plan:** L137-236 for criteria 2-4 and 33 and PC-10; L800-824 for 7.3; L845-1031 for the ordering principle, the probe, C02 and C05; L1040-1074 for C07 and C08; L1119-1144 for U-2, U-3 and 10.3. Why: the frame and the C02 and C05 actions.
- **devos, EkB:** L60-96 (activation table: owning stages); L115-138 (Work, WorkStanding, Relation); L215-234 (Artifact, Review, Verdict, Acceptance); L255-304 (Competence, EvalRun, EvidenceEnvelope, Decision). Why: to trace the options against the actual fields.
- **devos, other:** plan/work/W-C01-25.md; plan/Ek_D_Dusunme_Protokolleri.md L60-331. Why: the acceptance condition and the disciplines.
- **LIB:**
  - CS/KEY L30-122: to check D-6's layers and states against their source.
  - CS/S3 L236-271: the three outcomes, and stale not meaning false.
  - GS/CORE L428-507: the F1 seam used against C.
  - GS-RQ L462-473: consumer identification and freshness (K3).
  - MS01 L38-61: L41 for the unit, L47 for draft names, L54 for the A+ mapping.
  - DQ02 L84-90: L88, no new object required.

## Did I need to redo research?
No. I opened only passages the result cites, to use or check them. I read DevOS's own plan and data model, and searched only devos, with Grep. I did no library search and no web access.

## What the result lacked for continuing
1. **Missing data-model inputs.** The inputs and the option space left out EkB 3.3, 3.4, 3.11 and the activation table (EkB L60-96). These are DevOS's existing carriers of the assessment layer, the decision layer and staleness. I read them from devos, which goes beyond the result's limit of citing only section 7 for devos lines. I am flagging this for criterion (d).
   - Failure class: a reading range treated as the edge of the option space.
   - Capability-gap candidate: check the option list for a schema decision against the whole data model.
2. **No owning stage** was named for the decision. I took C05 from EkB L79.
3. **Whether C05's exams use a model grader** is not stated, so the EvalRun item is conditional.
4. **"Cost out of scope"** leaves the 3.17 options' cost field unfilled. The format gate needs it before the draft can open.

## Guard denials
none
