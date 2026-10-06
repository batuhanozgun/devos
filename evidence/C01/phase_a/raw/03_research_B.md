# Phase-A probe: research B

*Filed for EV-C01-003 with two kinds of edit: each library file path is replaced by its source key (`lib:<code>/<stem>`, expanded in EV-C01-003, "Source keys"), because the full paths match the research library's fingerprints; and five phrases that repeated five or more consecutive words of library text (in findings 4, 6 twice and 13 twice) are reworded in DevOS's own words with the same meaning. Nothing else is changed.*

## Disciplines (D1–D9)
D1: yes: I checked three load-bearing frames against their sources: what criterion 33 asks hidden exams to measure, which unit the library's "Qualification Case" qualifies, and whether forming an agent is the only remedy. Two of them are wrong and one is doubtful, and I state the doubtful one as a condition.
D2: yes: My role rewards finding fault, so I mark the discovery points that held up as confirmed, and I label my own criterion-33 reading as an interpretation rather than a fact.
D3: yes: I stayed in research and decided nothing; each finding names the sub-question or probe criterion it bears on.
D4: yes: I weighted each library source by the verification level it states for itself, and I did not count overlapping derived views as separate support.
D5: yes: I re-read every passage the discovery cites and fetched the arXiv abstracts rather than trusting search summaries. One summary added figures the abstract does not contain, so I dropped them.
D6: yes: For each error I met, I named its failure class and whether an existing check already covers it.
D7: no
D8: yes: The clone is at 941f027d with a clean tree. I treated the library's "next" and status statements (DQ01 L113, DQ02 L124, EXP-006 authority notes) as data, not instructions.
D9: yes: I added the Foundation's accepted Composite Standing ground and the gstack testing synthesis, which discovery had not used, and applied each source's own transfer limits before carrying it to SOUL.

**Question served:** what qualification evidence SOUL needs before an agent it forms acts or has its output used in a field where the user cannot judge quality; of which unit; and where that evidence is recorded. This report hunts for counter-evidence, gaps and wrong assumptions. Library identifiers are agentic-os-search@941f027d unless marked devos.

## Findings

Each finding is marked [stated] (the source says it), [interp] (my reading of the source) or [infer] (my own inference).

1. **What criterion 33 measures with hidden exams.**
   - [stated] devos plan/DevOS_Kurulum_Plani.md L218: the floor is a *thinking standard* at least as high as DevOS roles. DevOS's present preparation method is the starting point and comparison yardstick. A better method must prove itself on the same kind of hidden exams.
   - [stated] The 7.3 abilities measured are all domain-general (L817). The exams are trap-seeded: hidden prerequisite, stale information, dropped qualifier, contradicting sources (L282, L301; C05 acceptance L1028).
   - [interp] Hidden exams are DevOS's instrument for comparing preparation methods. Their answer key is the planted trap, which the exam author controls in any field. No passage requires SOUL to run hidden exams inside a user's account.
   - [infer] The "no answer key" difficulty therefore applies to runtime qualification of domain fitness, not to criterion 33's floor. Uncertain point: "keep this quality" in L218 could be read as runtime upkeep.

2. **DevOS already has a competence record.**
   - [stated] devos plan/Ek_B_Veri_Modeli.md L269-273 (3.15): Competence is keyed by role, task class, model and settings, and tools and context method. A change to the model, role text, tools or context method sets it to retest_required. Exam content is unreadable outside the exam role.
   - [interp] DevOS is the first instance of SOUL (plan L149-154). It already answers part of "which unit" (a role bound to task class, model, tools and context) and part of "what invalidates". PC-10 (L154) asks for a portability path for criteria 2, 4 and 33. Discovery did not cite this record.

3. **The library's Qualification Case qualifies an output claim, not an agent.**
   - [stated] It binds a claim about an object or revision to criterion, evidence, oracle, verdict and currentness: lib:EXP-004/MS01-SOUL L54; reflections/TERMS.md L21; reflections/OPEN-QUESTIONS.md L41-43 (O10).
   - [stated] The question-bank walkthrough (MS01-QUESTION-BANK L66) puts two such cases on one question: arithmetic correctness and fit to the task's condition. reflections/QUALIFICATIONS.md L33-35 calls it a candidate only.
   - [stated] Qualification of a bound configuration is a separate candidate: lib:EXP-006/B7 L121-134 and L342; DQ01 L63 (actor, method, information, environment and use together); MS01 draft P3 L15 and K4 L99.
   - [interp] There are three different record objects: a claim about an output, the joint readiness of a configuration, and a role's competence profile.

4. **The Foundation's qualification semantics are finer than pass/fail/indeterminate.**
   - [stated] lib:composite-standing/KEY (accepted 2026-09-05, L4), L73-87, keeps apart:
     - the standing holding, being assessed, being recognised by a decision, and being recorded;
     - stale, not applicable, not evaluated, unknown and false;
     - capable, actionable, authorised and reachable.
   - [stated] L106-110 uses JCGM: actual conformity, the probability of conformity and the accept/reject decision are separate layers.
   - [stated] S3-EVALUATION-UNCERTAINTY-INVALIDATION.md L222-237 lists invalidators, including a change to the evaluation model or procedure. L239-253: a dependency change may flip the standing, require re-evaluation, or provably leave it unchanged. L255-269: a stale assessment does not prove the standing false.
   - [stated] Verification limit: same-model adversarial review only (KEY L122).
   - [interp] For record shape (sub-question 5), Superpowers' three outcomes (S01 L58) are too coarse. A model or provider change should mark "re-evaluate", not "fail".

5. **Lab conditions versus operational conditions.**
   - [stated] S3 L271-288 (NIST AI RMF): validity must be judged in conditions relevant to deployment, and measured performance is not the same as valid for this use. L290-298 (NASA TRL): the conditions of a demonstration set the maturity it shows.
   - [stated] lib:EXP-006/B9 L196-212: a verdict binds the exact build, model and provider, configuration, data, tools, grants and oracle version.
   - [infer] Qualification earned in DevOS's exam environment on Claude is a lab-condition standing. SOUL in another account, possibly on another model (criterion 4, L193), is the operational condition, and the standing does not carry over by default.

6. **Model-graded evaluation in the library.**
   - [stated] lib:gstack/testing-eval:
     - L643-662: scores are tied to the judge model; changing the judge model shifted scores, so thresholds stayed calibrated to one model.
     - L684-706: planted-bug evals combine a known ground truth with model-mediated matching. That is stronger than taste grading, but it is not proof by execution.
     - L710-722: a same-family judge and generator share priors. This adds oracle diversity, not independent verification, and is weakest when nothing outside the judge fixes the right answer.
     - L994-996: judge calibration is local to the judge.
   - [stated] lib:superpowers/CORE L76-78: a report being accepted does not show sound judgment; grader limits are uncalibrated; no causal advantage was established. S01 L37: separating roles on the same model is not epistemic independence. S01 L60-64: repairing the instrument can raise a score without improving the subject.
   - [stated] EXP-004 DQ02 L70-80 and EXP-006 B9 L179: another model is not proof, and a second look by the same model is not worthless.
   - [interp] Planted-defect grading is the library's nearest analogue to plan 7.3. It supplies its own key, but only for the defect classes that were planted.

7. **Current outside evidence (abstracts read 2026-10-06).** [stated]
   - Krumdick et al., arXiv 2503.05061 (v1 2025-03-07, v4 2026-09-28): on 160 expert finance questions, LLM judges agree with experts mainly on questions they can answer themselves. Expert-written reference answers largely fix this, and a weaker judge with good references beats a stronger one with synthetic references.
   - Szymanski et al., arXiv 2410.20266 (v1 2024-10-26; listed as IUI '25 in the ACM DL, not fetched): subject experts agreed with LLM judges 68% of the time in dietetics and 64% in mental health.
   - Goel et al., arXiv 2502.04313 (v2 2025-06-12): judges favour models similar to themselves, and model errors grow more alike as capability rises.
   - Kenton et al., arXiv 2407.04622 (v2 2024-07-12): debate beats consultancy, but beats direct judging only with information asymmetry; results elsewhere are mixed.
   - Bowman et al., arXiv 2211.03540 (2022-11-11): non-experts assisted by an unreliable model beat both alone, scored against answers known to experts.
   - [infer] In a field where SOUL's agent is unqualified, a judge of similar capability fails for the same reason. Validity returns with a reference answer or an outside ground truth, which is exactly what such a field lacks. A second model family is a weakening rung, not a fix.
   - Freshness: these are 2024-2025 results not re-tested on 2026 models; DQ02 L78 gives the same caution for its sources.

8. **Hidden-suite failures in the project's own history.**
   - [stated, relayed Codex reports, not independently verified] lib:EXP-005/07-V2 L14-18 and L30-33:
     - The v1 comparison (12 runs) was invalid for choosing a winner because candidate context contaminated the suite.
     - In v2 (four unseen tasks) both arms scored 4/4; the candidate gained nothing and was slower and noisier.
   - [stated, same status] 04-ILK-CLOUD L86-92: negative tests passed on any failure, not on the intended one. L221-237: new tests only checked that certain phrases exist in a text. Both files say at L3 that they relay reports.
   - [stated] LESSONS L21 and L112: four equal passes show neither adequacy nor ineffectiveness.
   - [interp] Small hidden suites saturate and cannot rank methods, and contamination and false-green negatives did happen in this lineage. This bears on criterion 33's comparison and on plan L282.

9. **Disclosed cases cannot become hidden tests, and SOUL is open source.**
   - [stated] DQ01 L93, DQ02 L98, DQ04 L120: a disclosed case can never later serve as a hidden test. EXP-006 B9 L87-100 lists contamination checks.
   - [stated] Plan L812-813: answer keys stay out of the tested role's reach, and the audit environment cannot write its own exam. Plan L143 and L191: SOUL is open source and installed by others.
   - [infer] An exam bank shipped inside SOUL is public. Inside a user's account, SOUL would write, hold and take its own exams on one model. Hidden-exam separation therefore does not transfer to runtime. Also, nothing this probe writes to the public `devos` can later seed C05's hidden exams.

10. **Forming an agent is one remedy among several.**
    - [stated] EXP-006 B7 L66: naming a gap does not fix its solution. L68-81 lists the options: reuse, reconfigure, a new role instance, binding an external tool or expert, creating something new, or deferring. Also DQ01 L67-69, MS01 draft L43, DQ04 L103.
    - [interp] Qualification must also cover a reused agent with new context and an external human expert.

11. **Gate by effect, not by act.**
    - [stated] MS01 draft P4 L17 and K6 L119: the start check does not block exploration for lack of a final output qualification. DQ01 L75: a candidate worth trying justifies a bounded trial, not acceptance. DQ01 L81: the three thresholds are explicitly not universal certification tiers.
    - [stated] Limits: DQ02 L48 says inquiry is not automatically harmless (sending private text out, asking real people, spending budget). DQ04 L99 says a pilot label does not make an effect acceptable.
    - [interp] "Qualify before any act" is circular, since qualifying is itself work, and the sources contradict it.

12. **No infinite chain of evaluators; narrow the claim instead.**
    - [stated] DQ01 L99-101: the bounded bases are an external ground, a valid source, an error-sensitive limited check, or authorised acceptance; without one, the claim narrows. Plan U-3 L1127: fields with no independent expert get a disclosure note. Plan U-8 L1132. Actors ground INDEX.md L44: the state of acceptance is not the authority to accept.
    - [interp] When the user cannot judge, the user's acceptance is authority, not evidence of quality.

13. **Stated status of the sources.**
    - [stated]
      - DQ01, DQ02, DQ04, MS01 and MS01-COVERAGE (each at L3): same-assistant conceptual work, self-reviewed, with no experiments.
      - EXP-006 B7 and B9 (L3-4): candidate decomposition. lib:explorations/CATALOG L1-3: superseded as DevOS's plan.
      - Foundation KEY L122 and Actors INDEX L55: same-model adversarial review.
      - lib:superpowers/META L38: its syntheses overlap and are not independent corroboration. Its STATE.md L23: acceptance is not replication.
      - lib:gstack/CORE L7-15: lossy, so go back to the lower layers when a claim is decision-critical. L18-20: pinned at version 1.79.0, as seen on 2026-09-05.
      - autoresearch META L5 and i-have-adhd META L8: planned studies only.
    - [interp] A decision justified by these sources carries draft-level confidence. S01 plus superpowers CORE count as one source, not two.

14. **Cost and data in the user's account.**
    - [stated] Criterion 3 (L192): user data stays in the user's space. Criterion 25: cost is Batu's decision. Plan L143: SOUL puts cost options to its user. DQ02 L48.
    - [infer] Second-model grading of a user's work sends that work to another provider and costs that user. Qualification evidence drawn from users' work cannot feed a shared exam bank without a leak.

## Gaps and wrong assumptions

- **W1 (doubtful frame): "criterion 33 makes hidden exams SOUL's runtime yardstick."** Source: plan L218, L817, L282, L301; finding 1. The synthesis should state this conditionally.
- **W2 (wrong): "Qualification Case is an agent-qualification candidate."** It qualifies output claims. Source: MS01 draft L54, O10 L41-43, walkthrough L66; finding 3.
- **W3 (wrong): "the agent alone is the unit."** Source: DQ01 L63; B7 L121-134; Ek B L269; findings 2 and 3.
- **W4 (partly wrong): "model-graded evaluation is valid evidence where the user cannot judge."** It holds only with reference answers or an outside ground truth. Source: finding 7 (Krumdick, Szymanski); gstack testing synthesis L710-722.
- **W5 (weakened): "a second model family supplies independence."** This also bears on plan U-3 L1127 and Section 8 item 7. Source: Goel et al.; DQ02 L74; B9 L179.
- **W6 (wrong): "every agent must be qualified before any act."** Source: finding 11.
- **W7 (wrong, with a counter-risk): "qualification survives a model or provider change."** Source: Ek B L273; S3 L222-237; B9 L196-212; gstack testing L643-662. Counter-risk of over-invalidating: S3 L239-253.
- **G1:** DevOS's Competence record is not considered as the starting point (Ek B 3.15).
- **G2:** The Foundation's Composite Standing ground is unused, and the planned verdict states are too coarse (finding 4).
- **G3:** Hidden-exam separation conflicts with open source and with operation inside the user's account (finding 9).
- **G4:** Hidden suites saturate or get contaminated in practice; criterion 33's comparison needs discriminating, balanced sets (finding 8).
- **G5:** The evaluation-path list omits reference-anchored judging and non-expert oversight protocols such as debate and sandwiching (finding 7).
- **G6 (measure 7):** Variants that narrow which user work SOUL accepts touch purpose and scope, and variants that spend the user's or Batu's quota touch cost. Both are batu class, not only high_impact (Ek B L293; plan L141).
- **G7:** Cost and data egress of qualifying inside a user's account are unaddressed (finding 14).
- **G8 (reading route):** Discovery did not read DQ02, which works the very follow-up DQ01 L113 proposes, nor DQ04, EXP-005, EXP-006 B7/B9, Foundation Composite Standing or the gstack testing synthesis. These change sub-questions 1, 2, 4 and 5.
- **G9 (minor):** gstack CORE L467-475, cited for model or provider invalidation, covers stale artifacts and names neither. The "SOUL requirement record" does not exist until C12 (plan L1106).

## Errors and squeezes met

- **E1 (mine, caught):** the search summary for Szymanski et al. gave an inter-expert baseline and a lay-user comparison that the arXiv abstract does not state. Failure class: a derived view adding unsupported specifics (source versus view, D5). The existing rule of returning to the source for exact numbers caught it. No new capability gap.
- **E2 (met in the discovery record):** gstack CORE L467-475 was cited for a claim it does not make. Failure class: citation by topical nearness, where the claim drifts beyond its source (qualifier-loss type). Candidate check: verify each cited passage against the exact sentence it supports.
- **E3 (met in the discovery record):** the library's Qualification Case was read as an agent primitive. Failure class: the same term used on different layers, so the unit is mistaken (D1 frame error).
- **E4 (met):** S01's header still says "provisional / active-partial" while its study is accepted (superpowers META L7). Failure class: a stale label in a derived view. Small effect, since the content is unchanged (superpowers STATE L43).
- **S1 (squeeze, frame first):** "no answer key, so evidence is needed before acting, so it needs a home" pushes toward new mechanisms: a SOUL exam bank, a second-model gateway, a qualification record family. Frame question for the synthesis: must SOUL establish domain quality before its agent acts in a field nobody present can judge? Alternatives:
  - examine the domain-general floor in DevOS, where seeded traps carry their own key;
  - at runtime, gate by effect class and show the user the stated limit (U-3 pattern; DQ01 L101);
  - obtain a reference answer or outside ground truth when the effect warrants it (Krumdick et al.).
- **S2 (budget):** I read the Foundation Composite Standing KEY and S3 only (not S1, S2 or S5), and none of T6, T10, T11 or the S012 origin of the Qualification Case.

**Open:**
- Whether criterion 33's "keep this quality" means runtime upkeep. This is Batu's wording, so its interpretation may need his decision.
- Whether the 2024-2025 judge results hold for 2026 models.
- The EXP-005 figures are relayed and were not verified.

**For the decision:**
- Prerequisites tested against measure 2:
  - DevOS's C05 exam set is load-bearing for criterion 33's method comparison and is already planned.
  - A shipped SOUL exam bank defeats itself under criterion 2.
  - The second-model gateway and the model access layer (C08) are not needed to decide unit or record shape.
  - A full base-SOUL definition is not needed. Only DQ01 L103's minimal starting capacities bear on who qualifies the first agent.
- Library content that limits decisions:
  - The unit (findings 2 and 3).
  - The verdict states (finding 4).
  - Gating by effect class (finding 11).

## Sources read

- **devos:**
  - plan/DevOS_Kurulum_Plani.md L137-221, L792-871, L955-971, L1017-1030, L1040-1144
  - plan/Ek_B_Veri_Modeli.md L267-297
  - plan/work/W-C01-25.md
  - plan/Ek_D_Dusunme_Protokolleri.md L60-331
- **agentic-os-search@941f027d, full:**
  - EXP-004 continuations: DQ01, DQ02, DQ04
  - lib:EXP-004/MS01-SOUL, lib:EXP-004/MS01-COVERAGE
  - lib:EXP-004/QUALIFICATIONS, lib:EXP-004/OPEN-QUESTIONS
  - lib:EXP-002/OPEN-QUESTIONS
  - superpowers S01
  - lib:actors-ground/INDEX
  - lib:composite-standing/KEY
- **agentic-os-search@941f027d, part:**
  - lib:gstack/CORE L1-20, L300-320, L420-537
  - gstack testing synthesis L1-20, L640-730, L990-998, L1073-1094
  - superpowers META L1-40, STATE and CLOSURE-AUDIT and CORE (grep hits)
  - composite-standing S3 L1-12, L222-311
  - EXP-006 B7 L1-15, L60-139, L325-350
  - EXP-006 B9 L1-105, L164-273
  - EXP-005: 04 L1-12, L80-119, L215-244; 07 L1-99; LESSONS (grep hits); DEVOS02 L99-101
  - lib:explorations/CATALOG L1-25
  - autoresearch, i-have-adhd and anthropic-playbook META (header and cited lines)
  - Grep hits for "Qualification Case" across the library
- **Outside, abstract pages only, read 2026-10-06:**
  - https://arxiv.org/abs/2503.05061 (v4 2026-09-28)
  - https://arxiv.org/abs/2502.04313 (v2 2025-06-12)
  - https://arxiv.org/abs/2410.20266 (v1 2024-10-26)
  - https://arxiv.org/abs/2407.04622 (v2 2024-07-12)
  - https://arxiv.org/abs/2211.03540 (2022-11-11)
  - Venue listings seen only in search results (not fetched): https://icml.cc/virtual/2025/poster/46528 and https://dl.acm.org/doi/10.1145/3708359.3712091

## Guard denials

none
