# Phase-A probe: result

*Filed for EV-C01-003 with three kinds of edit: each library file path is replaced by its source key (`lib:<code>/<stem>`, expanded in EV-C01-003, "Source keys"), because the full paths match the research library's fingerprints; three phrases that repeated five or more consecutive words of library text (in D-2, D-6 and D-7) are reworded in DevOS's own words with the same meaning; and one outside page (Anthropic's "Demystifying evals for AI agents"), which the library also cites with the same title, date and address, so that the leak check denies them together, has its date put before its title in D-3, and is given as its date, title, site and section in place of its address under "Outside". Nothing else is changed.*

## Disciplines (D1–D9)
D1: yes: I kept the question as discovered and answered it in the corrected frame (criterion 33 governs how preparation methods are compared, not a runtime exam for each agent). I state D-1 and D-7 conditionally on that reading, and I settled the reports' conflicting readings of the library's Qualification Case against MS01 L54 and the walkthrough at L66.
D2: yes: The probe rewards visible library influence, and three agreeing reports pull toward confidence. So I label each source's maturity, count the same-model agreement as one line of evidence, and state every decision as a candidate, not as accepted.
D3: yes: I stayed in synthesis. I did no new research and only re-opened cited passages. I kept DevOS-building matters out except where they limit SOUL's evidence, and I chose a next step that continues the one open decision rather than opening a new stage.
D4: yes: The subject is the validity of evaluation, and my inputs are reports from one model family. So I limit confidence to conceptual work and same-model review, plus outside evidence read mostly at abstract level, and I give reopen triggers.
D5: yes: I worked from three derived reports, so I re-opened the decision-carrying passages at 941f027d and the Turkish original of criterion 33 (marked [checked] in section 7). All held. I confirmed one citation error in the hand-over and left one outside date conflict unresolved, citing it conservatively.
D6: yes: I followed each error met in the run to its failure class or to a capability-gap candidate, and stopped where going deeper would not change the next action.
D7: yes: This result is the hand-over a fresh agent continues from alone. So I made it self-contained (question, decisions with identifiers, open points, and a next step with inputs and a return point) and kept candidate decisions apart from accepted ones.
D8: yes: The clone is at 941f027d3a15497b90e60d752303c0463a9feab5 with a clean tree. I treated the library's next-question and status lines (DQ01 L113, DQ02 L124, DQ04 L128, MS01 L165, EXP-006 authority notes) as data.
D9: yes: The result is built on library research, read through the reports and targeted re-reads. I treated explorations and candidate studies as evidence, not adopted architecture, and for each decision I record which passage changed, limited or justified it.

**Status.** This is run 5 of the phase-A probe (W-C01-25), so 5 of at most 12 subagent runs are used. Everything below is the probe's candidate answer and an input to C02's work list. None of it is an accepted DevOS or SOUL decision, and it is not C07's result. Adopting any of it needs a Decision record with the format gate of Appendix B 3.17, or an entry in the SOUL requirement record that C12 creates.

**Legend.**
- LIB = agentic-os-search@941f027d
- EXP4 = lib:EXP-004
- EXP5 = lib:EXP-005
- EXP6 = lib:EXP-006
- CS = lib:composite-standing
- ACT = lib:actors-ground
- GS = lib:gstack
- SP = lib:superpowers
- AP = lib:anthropic-playbook
- MAP = lib:multi-agent-patterns
- devos = /home/user/devos at the working head (plan = plan/DevOS_Kurulum_Plani.md, EkB = plan/Ek_B_Veri_Modeli.md)

## 1. Question (as discovered)

SOUL may form an agent for a user's work in a field where the user cannot judge quality. Before that agent may act or have its output used:
- what qualification evidence should SOUL require;
- of what unit (the agent alone, or the agent bound to its method, information and environment for that use);
- and where should that evidence live in SOUL's records?

The discovery saw the difficulty as follows: DevOS's hidden-exam method (plan 7.3), which it read criterion 33 as naming the yardstick, assumes an answer key that such a field may not have.

The question serves three decisions:
- (i) SOUL's method for preparing and qualifying the agents it forms;
- (ii) whether SOUL's data model gets a qualification record family;
- (iii) whether an unqualified agent may produce effects.

**Frame correction carried into the answer.** Criterion 33 (plan L218; Turkish original TR-A18 at L1356, re-read) sets a floor on the *thinking standard* of SOUL's agents. It makes DevOS's present role-preparation method the starting point and the comparison yardstick, and it names hidden exams as the way to show that a *better preparation method* is better. It does not require each agent to pass a hidden exam inside a user's account. The missing answer key therefore matters mainly for the domain fitness of an agent for a named use, which SOUL's purpose requires (plan 1.1, L141). That residue is the hard core of the question (section 3, G13).

## 2. Answer and decisions

### 2.1 Answer in brief

**What is qualified.** SOUL qualifies a *binding for a named use*, not an agent (D-2). The binding is:
- the carrier;
- the role and method version;
- the information sources;
- the tools, environment and grants;
- the named use with its criterion.

This covers every way SOUL meets a need, not only a newly formed agent.

**What each level permits.** Qualification has three levels, each tied to the acts it permits (D-3):
- Unqualified bindings may draft and explore in a bounded scope, but exploration that sends private content out, asks real people, spends budget or changes production state needs its own permission.
- Effects and the admission of results are gated.

**What evidence counts.** In a field nobody present can judge (D-4):
- Model grading without a reference supports at most "worth trying". This holds for a second model family too.
- "Fit for a named use" needs at least one error-sensitive evidence path that carries a reference and does not share the producer's frame.
- Where no such path exists, the claim narrows, the user is told the limit, and a reference or expert path is offered as an option with its cost.
- The user's approval is authority, not evidence of quality.

**When it goes stale.** The qualification binds its dependencies and is marked for re-evaluation, not failure, when one of them changes. Silent drift needs pinned versions or re-probes (D-5).

**Where the evidence lives.**
- The record's content is fixed; its physical shape stays open (D-6).
- Runtime qualification records live in the user's own space.
- The hidden, keyed exam belongs to DevOS's validation of SOUL's preparation method before release, not to SOUL's runtime (D-7).
- Qualification depth is budgeted per level, and paid or outside evaluation of a user's work is the user's decision (D-8).

**For the three decisions:**
- (i) is answered by D-2 to D-5 and D-7.
- (ii) has its content fixed by D-6, but the choice of a separate record family remains open.
- (iii) is answered by D-3: an unqualified binding may not produce effects, but it may draft.

### 2.2 Decisions

**D-1. Where criterion 33's yardstick applies.**
- **Decided:**
  - Criterion 33's floor is a thinking standard.
  - Its hidden exams are DevOS's instrument for comparing SOUL's agent-preparation methods.
  - The domain fitness of a binding for a named use is required by purpose 1.1, not by criterion 33's exam clause.
  - This is recorded as the plan's interpretation (plan 0.6 item 2, L114). No difference between L218 and TR-A18 was noticed. TR-A18's "bu kaliteyi nasıl koruyacağı" (how SOUL keeps this quality) puts runtime upkeep inside what DevOS must find; it does not fix that upkeep to a hidden exam per agent.
  - **Conditional:** if Batu meant a hidden exam for each agent at runtime, D-7 changes. The collision with criterion 2 (open source, other people's accounts) then becomes a constraint conflict to present to him with options (criterion 16).
- **Library (c):**
  - EXP4/DQ02 L112-116 and DQ04 L124 *justify* the split: the user's work, SOUL's capacity, and DevOS's building and testing of that capacity carry separate burdens, and DevOS describing a method does not show that SOUL performs it.
  - EXP4/DQ01 L105 states the same three levels.
  - CS/S3-EVALUATION-UNCERTAINTY-INVALIDATION.md L271-298 *limits* what DevOS's exam results can show. A standing demonstrated under laboratory conditions is not demonstrated under operational ones, so passing DevOS's exams does not qualify a binding in a user's account.
- **Class:** high_impact, because it concerns rules and methods (EkB 3.17 L293). It is not batu class as stated, because it keeps hidden exams where the criterion puts them. Any later step that narrows them below the criterion's text would be batu class (purpose and scope; K-11 item 7).
- **Research reflected (f):** the library passages above, the plan text and its Turkish original. No outside source bears on a textual reading.

**D-2. The unit is a binding for a named use.**
- **Decided:**
  - The unit has these parts:
    - the carrier (model, provider, version and settings, or a named human);
    - the role text and method version;
    - the information sources and context method;
    - the tools;
    - the environment and grants;
    - the named use, with its criterion and version.
  - The same applies whether SOUL reuses an actor with new context, binds an outside tool or human expert, or forms a new agent.
  - A role name or a loaded skill qualifies nothing.
- **Library (c):**
  - DQ01 L63 *changes* the unit from the actor to the combination of actor, method, information, environment and use, without choosing a schema.
  - EXP4/MS01-SOUL L15 (P3) and L41 *justify* it: separately existing parts do not make a ready configuration, and a role is an instruction plus a real carrier, context, tool and effect scope, and a competence basis.
  - EXP6/work/B7-system-formation.md L83-101 and L121-134 *justify* it: the smallest sufficient working configuration has its readiness tested jointly.
  - ACT/INDEX.md L40-41 *justifies* it: competence differs from what the environment allows, and holding authority is not the same as having the technical power to cause an effect.
  - B7 L66-81 and DQ01 L65-69 *widen the scope*: forming an agent is one remedy among reuse, reconfiguration, a new role instance, binding an outside tool or expert, creation, and deferral.
  - DevOS's own Competence record (EkB 3.15 L269) is already keyed by role, task class, model and settings, and tools and context method. It lacks information sources, environment and grants, and the named use.
  - Whether this standing is cross-ground in the Foundation's sense (CS/KEY.md L33-37, the removal test) is likely but untested.
- **Class:** high_impact (methods and schema).
- **Research reflected (f):**
  - Feng, McDonald and Zhang, arXiv 2506.12469 v2 §4: an autonomy certificate binds model, prompts, tools and environment, and a change invalidates it.
  - NIST AI RMF Playbook MEASURE 2.5: validity is shown for tested conditions, and the limits of generalising beyond them are documented.
  - Mitchell et al., arXiv 1810.03993: evaluation results travel with the intended use.
  - These sources are why environment and named use are part of the unit. No source read supported the agent-alone unit; that absence is limited to the sources read.

**D-3. Three levels tied to acts; effects and result admission are gated.**
- **Decided:**
  - **Worth trying** permits a bounded trial in a draft scope with no external effect.
  - **Fit for a named use** permits dependent work for that use.
  - **This result accepted** (this version and use, with an authorised decision) permits admission of the result and its effect.
  - These levels are not universal certificates, and there is no global trusted flag.
  - Exploration is not exempt: sending a user's private text out, asking real people, spending budget or changing production state each needs its own permission.
  - Weak qualification opens a small qualification work item: real application plus a separate evaluation fitted to the claim. One small success is not broad competence, and the dependent effect waits.
  - For effects, "fit for a named use" rests on consistency across repeated trials, not on best of k.
  - Before moving to a stronger level, the case states which change reopens it and which authority accepts it.
- **Library (c):**
  - DQ01 L73-81 *justifies* the three levels and *limits* them: they are not universal tiers, and a list of questions must be answered before a stronger verdict.
  - MS01 L33, L99 (K4) and L119-121 (K6) *change* the premise "qualified before any act": start is not blocked for lack of a final qualification, but each effect needs its decision and qualification.
  - EXP4/T10 L39-51 *justifies* it: creation, competence, access and acceptance are separate standings, with no global trust flag, and a new actor drafts in a bounded environment.
  - DQ02 L48 *limits* it: exploration is not harmless by default.
  - DQ04 L88-99 *limits* it: a pilot label does not make an effect safe, and neither one success nor a score that rose under a changed criterion shows benefit.
- **Class:** high_impact (security, and possibly irreversible effects).
- **Research reflected (f):**
  - Library:
    - AP/03-SOUL L400-411 and L512-516: autonomy depends on actor, action, environment, evidence and gate.
    - MAP/CONVERSATION-SYNTHESIS.md L478-485: irreversible, financial and external actions stop at a human.
  - Outside:
    - Feng et al.: autonomy is a design choice separate from capability.
    - Greenblatt et al., arXiv 2312.06942: control without proving trust. Its threat model is deliberate subversion, so it carries over only partly.
    - Anthropic, 2026-01-09, "Demystifying evals for AI agents", and τ-bench, arXiv 2406.12045: the pass^k consistency bar. The best agent of 2024 reached pass^8 below 25% in the retail domain.
  - These sources are reflected in the effect-tiered gate and the consistency bar.

**D-4. Valid evidence where the user cannot judge.**
- **Decided:**
  - (a) Each qualification records its evidence paths and their independence level. That level is a bounded argument about which error paths diverge, not a certificate.
  - (b) Model grading without reference answers or an outside ground truth supports at most "worth trying" in a field nobody present can judge, whether the judge is the same model family or a second one.
  - (c) "Fit for a named use" needs at least one error-sensitive path that carries a reference and does not share the producer's frame:
    - an outcome check against a checkable end state;
    - reference answers from a valid outside source or a real expert;
    - balanced known-good and known-bad cases, including sound but unusual solutions and cases where the information is insufficient;
    - planted defects, which are keyed only for the classes planted.

    Parsers decide what parsers can decide; a judge decides only substance.
  - (d) Where no such path exists, the claim narrows. SOUL states the limit to the user, as plan U-3 does for DevOS, and offers the reference or expert path as an option with its cost. Neither more review in the same frame nor a new role hides the gap.
  - (e) A second model family reduces shared blind spots but does not remove them, and it is recorded at its stated independence level.
  - (f) In a field the user cannot judge, the user's approval is an act of authority, not quality evidence. The user's purpose and preferences are inputs SOUL must ask for.
  - (g) Model-assisted judging by a non-expert (structured debate, assisted oversight) is a conditional path, valid only where its conditions hold.
- **Library (c):**
  - DQ01 L89 *changes* the approach to evidence: the evidence path must change materially, a different agent or model label alone does not remove a shared wrong assumption, and a model's opinion does not settle a strong claim about real reader or learner effect.
  - DQ01 L101 *justifies* (d): there is no endless chain of evaluators, and the claim shrinks.
  - DQ02 L58-64 and L70-80 *limit* the approach: every path keeps a blind spot, the human path cannot be assumed, and a second look by the same model still has some value.
  - DQ02 L92-98 *justifies* balanced known cases.
  - GS/testing-eval:
    - L643-662 *limits* trust in scores: a score is relative to the judge model and its calibration.
    - L670-680 *justifies* the rule that parsers decide first.
    - L684-706 *justifies* planted defects, with a limit: stronger than taste scoring, but still model-mediated.
    - L710-722 *limits* the second family's value: a same-family judge adds diversity, not independent verification.
  - SP/S01 L37-41 *limits* role separation: separating roles on one model is not independence, and a row that passes the schema can still answer the wrong obligation.
  - EXP4/T15 L54 *justifies* (f): preference is input, not evidence.
  - GS/multi-agent-cross-model L505-562 *limits* (e): agreement between two models creates no ground truth.
- **Class:** high_impact (method). Two sub-choices are costs: a paid second model and a human expert's time. In DevOS they are batu class (criterion 25; EkB 3.17 L293). In SOUL they are the user's own decision (plan L143).
- **Research reflected (f):**
  - Krumdick et al., arXiv 2503.05061 (submitted 2025-03-07): judges agree with experts mainly on questions they can answer themselves. Expert reference answers largely fix this, and a weaker judge with good references beats a stronger one with synthetic references. This is the basis for (b) and (c).
  - Szymanski et al., arXiv 2410.20266 (2024-10-26): experts agreed with judges 68% of the time in dietetics and 64% in mental health. This supports (b).
  - Goel et al., arXiv 2502.04313 (revised 2025-06-12), and Kim et al., arXiv 2506.07962 (2025-06-09): judges favour similar models, and errors correlate across providers. This supports (e). The counter-evidence is Verga et al., arXiv 2404.18796 (2024-05-01): a panel drawn from different families beats a single judge. So (e) says "reduces", not "removes".
  - Zheng et al., arXiv 2306.05685 (v4 2023-12-24), and Panickssery et al., arXiv 2404.13076 (2024-04-15): judge biases and self-preference. This supports (b).
  - Bowman et al., arXiv 2211.03540; Khan et al., arXiv 2402.06782 (2024-07-25); Kenton et al., arXiv 2407.04622 (2024-07-12). This supports (g).
  - Anthropic (2026-01-09): calibrate model graders against expert humans, and grade outcomes. This supports (c).
  - **Freshness:** these results are from 2023 to 2025, mostly read at abstract level, and none was re-tested on 2026 models.
  - **Reopen trigger:** a current measurement showing that judges without references agree with experts on questions the judge cannot answer itself.

**D-5. Validity dependencies and invalidation.**
- **Decided:**
  - A qualification binds these dependencies:
    - the carrier's model, provider and version;
    - the judge model and instrument version;
    - the role text and method version;
    - the tools and context method;
    - the information sources;
    - the environment and grants;
    - the criterion version;
    - the named use.
  - A declared change to a load-bearing dependency marks the qualification for re-evaluation, not as failed. There are three outcomes: the standing changes; it may change, so re-evaluate; or it provably stays unchanged.
  - A stale assessment does not make the standing false.
  - Drift under an unchanged model name escapes triggers that fire on declared changes, so pinned versions or periodic re-probes are needed where the provider allows them.
  - A qualification earned on one provider does not carry to another (criterion 4).
- **Library (c):**
  - CS/S3 L222-237 *justifies* the list of invalidators, which includes a change to the evaluation model or procedure.
  - CS/S3 L239-253 *limits* invalidation (no overcorrection; three outcomes), and L255-269 *justifies* stale not meaning false.
  - AP/04-FALSIFIERS L484-500 (F17) *changes* the criterion-4 assumption: a model or provider change makes earlier evaluations stale, and the verifier may shift at the same time.
  - AP/04 L376-399 (F13) *justifies* binding the exact configuration and model, and holdout cases.
  - EXP6/B9 L196-212 *justifies* binding a verdict to its build, model and provider, configuration, sources, environment, grants and oracle version.
  - MS01 L129 *limits*: not every qualification is cancelled blindly on every change.
  - GS testing synthesis L643-662 *justifies* binding the judge model.
  - DevOS's EkB 3.15 L273 already sets retest_required on a change of model, role text, tool set or context method. It lacks the judge and instrument, sources, environment and grants, and use dimensions, and the three-outcome rule.
- **Class:** high_impact (rules and methods; criterion 4).
- **Research reflected (f):**
  - Chen, Zaharia and Zou, arXiv 2307.09009 (revised 2023-10-31): the same named service changed materially within months. This is the basis of the drift clause.
  - Feng et al. §4: a change invalidates the certificate.

**D-6. Record content is fixed; physical shape stays open; records live with the work.**
- **Decided:**
  - Whatever record carries a qualification holds:
    - the binding (D-2);
    - the frame: criterion and its version, named use, scope;
    - the basis;
    - the result, in distinct states: holds, false, unknown or indeterminate, stale, not applicable, not evaluated;
    - a separate assessment layer: evidence paths, method, evaluator and judge model, instrument version, independence level, uncertainty and coverage;
    - a separate decision layer: who accepted, and whether they accepted or rejected;
    - its dependencies and reopen triggers (D-5);
    - a flag saying whether a changed score came from a changed subject or a changed instrument.
  - "The standing holds", "it was assessed", "it was accepted" and "it was recorded" stay apart.
  - Every consumer of a qualified result carries the verdict and its qualifiers.
  - **Not decided (the shape):** a separate qualification record family, an extension of DevOS's Competence, EvalRun and EvidenceEnvelope, or qualifiers carried only on the consuming records.
  - **Location:** runtime qualification records live in the user's own space with the work they qualify (criterion 3, L192). DevOS's method-comparison evidence lives in DevOS's exam environment (plan 7.3 L812).
- **Library (c):**
  - CS/KEY.md L39-66 *justifies* the core and the optional layers, and L68-89 *justifies* the rules that keep the states and layers apart.
  - SP S01 L58-64 *justifies* the pass, fail and indeterminate verdicts and the instrument-versus-subject flag. It is coarser than KEY's five states, so KEY governs.
  - GS/CORE.md L432-444 (F1) and L505 *justify* treating qualifiers as first-class and carrying them downstream.
  - GS/review-qa L469: a stored verdict is reusable only if its consumer can identify it and check its freshness.
  - MS01 L47 and L54 *limit* the choice: a qualification's validity is apart from its authorised acceptance, and the names are drafts, not mandatory tables.
  - EXP4/reflections/OPEN-QUESTIONS.md L41-43 (O10) and EXP4/reflections/QUALIFICATIONS.md L33-35 *limit* it: the Qualification Case is a candidate, and whether it is a needed primitive is open.
  - DQ02 L88 *limits* it: not every distinction needs a new physical object.
  - The library's Qualification Case is shown only on output claims (EXP4/MS01-QUESTION-BANK L66). The readiness of a configuration is a separate candidate (B7 L121-134; MS01 L99).
- **Class:** high_impact (schema).
- **Research reflected (f):**
  - UK AISI Inspect eval-logs documentation (read 2026-10-06): a run binds task, model and configuration, with per-sample results and a run status.
  - Model cards (Mitchell et al.).
  - EkB 3.15 L269-275.

**D-7. The hidden, keyed exam lives in DevOS's validation of SOUL's method, not in SOUL's runtime.**
- **Decided:** The hidden, keyed part belongs to DevOS's validation of SOUL's agent-preparation method before release, in DevOS's exam environment (C05). It consists of:
  - planted traps for the domain-general thinking abilities (plan 7.3 L817);
  - a comparison of the current method with the candidate under equal model and budget;
  - development cases kept apart from final cases;
  - oracles that accept valid alternative solutions and have been shown able to turn red;
  - balanced sets varied enough not to saturate.

  Further:
  - No exam bank ships inside SOUL.
  - Runtime evidence in a user's account is recorded at its real, lower independence level (D-4).
  - No disclosed case, including anything this probe writes to the public devos, can later serve as a hidden test.
- **Library (c):**
  - DQ02 L92-98 *changes* the exam design: what is hidden is the defect's location, not the basis for acceptance, and sets must be balanced.
  - DQ01 L93 and DQ04 L120 *limit* reuse: a disclosed case can never become a hidden test.
  - EXP5/DEVOS02 L97-103 *justifies* the design pressures: equal model and budget, development cases kept apart from final ones, and an oracle that accepts alternatives and can turn red.
  - EXP5/07-V2 L14-33, 04-ILK-CLOUD L86-92 and L221-237, and EXP5/LESSONS L21 and L112 *limit* small suites. They are relayed, unverified reports: a contaminated comparison, a saturated 4/4 against 4/4, and negative tests that passed on any failure.
  - SP S01 L21: adjusting a method on cases it already knows gives development evidence only.
  - CS/S3 L290-298: demonstration conditions set maturity.
  - Plan L812-813: the separation needs DevOS's exam environment and credential. Plan L143 and L191: SOUL is open source and runs in other people's accounts.
- **Class:** high_impact (methods and the evaluation of roles). It is batu class only if a later step restricts hidden exams more than criterion 33 does (see D-1).
- **Research reflected (f):**
  - Dwork et al., arXiv 1506.02629: adaptive reuse of a holdout overfits to it. Hence development cases are kept apart from final cases, and sets are renewed.
  - Anthropic (2026-01-09): suites saturate and need upkeep.

**D-8. Cost, data and budget of qualification.**
- **Decided:**
  - Qualification depth is budgeted per level (D-3).
  - A spent budget is a resource event, not a verdict. It leads to bounded progress, a held effect, another route, or a reasoned "cannot do".
  - In SOUL, a second-model or human-expert evaluation of a user's work is the user's cost and data decision, presented with purpose, benefit, cost and alternative (plan L143).
  - A provider tier that uses submitted content for product improvement may not receive the user's private work (criterion 3).
  - Evidence drawn from users' work does not feed a shared exam bank.
  - In DevOS the same paths are Batu's cost decision (criterion 25).
- **Library (c):**
  - EXP4/T11 L29-35 and L47-64 *justify* it: sufficiency is relative to the next effect, a budget is a resource event, and there is no fixed review quota.
  - DQ02 L48 *justifies* permission for spending, and DQ02 L108 *limits* the decision: no cost was measured.
  - DQ01 L71 keeps the cost of a human contribution visible.
- **Class:** the SOUL rule is high_impact (user-data security, methods). Any actual spending in DevOS is batu class (cost; EkB 3.17 L293; criterion 25).
- **Research reflected (f):** changeable vendor facts, read 2026-10-06 by research run 4:
  - Gemini API terms (updated 2026-04-28): content sent to the unpaid tier is used for product improvement and may be read by human reviewers, and clients offered in the EEA, Switzerland or the UK must use the paid tier.
  - Gemini rate-limits page (updated 2026-09-02): limits are not guaranteed and are shown per account.
  - Claude Max plan help page: a five-hour allowance and a weekly cap.
  - These facts are why the second-model path is paid and user-decided, and why budgets are set per level.
  - **Uncertain:** whether a self-hosted SOUL running on the user's own key counts as "offering a client" under the EEA clause.

### 2.3 Evidence level of the whole answer
- **Library basis:**
  - Same-assistant conceptual work, self-reviewed, with no experiments: DQ01, DQ02, DQ04, MS01, T10, T11 and T15, each so labelled at its L3.
  - EXP6 B7 and B9: candidate decomposition (L3-5); lib:explorations/CATALOG L1-3 marks it superseded as DevOS's plan.
  - Foundation results accepted after same-model adversarial review only: CS/KEY L122; ACT/INDEX L55.
  - Study syntheses: GS is pinned at v1.79. In SP, the syntheses and CORE overlap, so they count as one source.
- **Outside evidence:** papers from 2022 to 2025, mostly at abstract level (Feng §4 read in full), and vendor pages read 2026-10-06.
- **The three research runs** share one model family, one hand-over and one frame. Their agreement is one line of evidence.
- **Confidence by decision:**
  - D-2, D-3, D-5 and D-6's content are conceptually well grounded but have little empirical support.
  - D-4's empirical core rests on a few outside results that have not been re-tested on 2026 models.
  - D-1 is a textual reading.
  - D-7 is an inference.
- **Nothing here has been tried on a real SOUL binding.**

## 3. Material gaps and wrong assumptions

**How the search was done.** Runs 2 to 4 went from the catalogue to META, STATE and the findings. They searched by need and by failure term in English and Turkish (judge, grader, oracle, answer key, holdout; cevap anahtarı, gizli sınav, yeterlik), and they searched outside sources (arXiv abstracts, NIST, AISI, vendor pages). I re-opened the decision-carrying passages (section 7).

**Wrong or partly wrong assumptions in the question:**
- **W1 (wrong frame):** that criterion 33 makes hidden exams the runtime yardstick for each agent. Sources: plan L218, L1356 and L817; D-1.
- **W2 (wrong):** that the agent alone is the unit. Sources: DQ01 L63; MS01 L15 and L41; B7 L121-134; EkB L269.
- **W3 (wrong as stated):** that every agent must be qualified before any act. Sources: DQ01 L73-81; MS01 L119-121; T10 L39-51. The counter-limit is DQ02 L48.
- **W4 (wrong without references):** that model grading is valid evidence where the user cannot judge. Sources: Krumdick 2025; Szymanski 2024; GS testing synthesis L710-722.
- **W5 (weakened):** that a second model family supplies independence. Sources: Goel 2025; Kim 2025; DQ02 L74; B9 L179. The counter-evidence is Verga 2024. This also bears on plan U-3 (L1127).
- **W6 (wrong, with a counter-risk):** that a qualification survives a model or provider change. Sources: AP/04 L484-500; EkB L273; Chen 2023. The counter-risk of over-invalidating is CS/S3 L239-253.
- **W7 (partly wrong):** that the hidden-exam method transfers. Its form transfers where an acceptance basis can be derived (DQ02 L92-98). Its separation does not transfer to a user's account (plan L812; open source, L143). The host boundary is open (EXP4/MS01-COVERAGE L83, G03).
- **W8 (partly wrong):** that the library treats the question as open. DQ02 (L7-11, L120-122) and DQ04 answered it conceptually. Only the empirical capability is open (MS01-COVERAGE L84, G04).
- **W9 (wrong as read):** that the Qualification Case is a candidate for qualifying agents. Its worked uses qualify output claims (walkthrough L66; MS01 L54). Configuration readiness is a separate candidate (B7 L121-134).
- **W10 (limited):** that forming an agent is the remedy. It is one remedy among several (B7 L66-81; DQ01 L65-69).

**Gaps:**
- **G1:** DevOS's Competence record (EkB 3.15 L269-273) was not considered as the starting point. It lacks the information-source, environment-and-grants, named-use, and judge-and-instrument dimensions and the finer verdict states. This bears on PC-10's portability path (plan L154).
- **G2:** The accepted Composite Standing grammar (CS/KEY) was unused. The planned three-way verdict is too coarse.
- **G3:** The separation hidden exams need conflicts with open source and with a user's account that has one identity (plan L812, L143, L191).
- **G4:** In this project's own history, small hidden suites saturated or were contaminated (EXP5 relayed reports, unverified).
- **G5:** The list of evaluation paths omitted reference-anchored judging, non-expert oversight protocols, and outcome checks with pass^k (D-3, D-4).
- **G6:** The cost and data egress of qualifying inside a user's account were not addressed (D-8).
- **G7:** Drift under an unchanged model name escapes rules that fire on declared changes (D-5; Chen 2023).
- **G8:** The real-expert path has no owner and no cost. In DevOS that path is only Batu, and only in his own fields (plan U-3 L1127; K-11 items 3 and 7).
- **G9:** There is no empirical evidence in the library. Fixtures are synthetic, and all review is self-review or same-model review (EXP4/reflections/QUALIFICATIONS.md L13-15 and L37-39; MS01 L163; CS/KEY L122).
- **G10:** None of the library's thresholds has measured values (DQ01 L95; DQ02 L108).
- **G11:** The evaluation-focused studies have not started. lib:autoresearch/META and lib:i-have-adhd/META are planned only; Hermes Q60 has not started; the roadmap's evaluation seam has no research (lib:studies/CATALOG L21 and L38).
- **G12:** Citation defects in the hand-over (section 5, E3 and E5). Also, the "SOUL requirement record" does not exist until C12 creates it (plan L1139).
- **G13 (the open core):** In a field nobody present can judge, no library or outside source gives "fit for a named use" without a reference or an outside ground truth. The answer narrows the claim (D-4 d); it does not solve this. It is the SOUL-side form of plan U-2 and U-3 (L1126-1127).

## 4. Prerequisites added

**Prerequisites the discovery proposed, tested against K-1 item 3:**
- **Base SOUL definition.**
  - A full definition is not needed.
  - Only DQ01 L103's minimal starting capacities are needed: forming questions from purpose, seeking help, testing claims, and stating its own limits.
  - Without knowing whether the starting carrier can state its own limits, D-3's permission to draft in a bounded scope would be granted on an unchecked premise.
- **Exam bank.**
  - DevOS's C05 exam set (already planned) is needed. Without it, D-7's claim that one preparation method is better than another would have no basis.
  - An exam bank shipped inside SOUL is rejected. It would be public (criterion 2), so it would defeat its own purpose.
- **Model access layer (C08).**
  - It is not needed for D-1 to D-8.
  - It is needed only to exercise D-5's re-qualification across providers (criterion 4, C11). Without it, that test could not run.
- **Second-model gateway.**
  - It is not needed to decide the unit, levels or record content.
  - In DevOS it is justified only where shared blind spots are decision-critical and the content is fake or public (B2).
  - In SOUL it is a paid path the user decides (D-8).

**Added by this result:**
- **A1.** C05's existing comparison set must be balanced (sound but unusual solutions, intended ambiguity, cases with insufficient information) and kept apart from development cases.
  - **Without it:** in criterion 33's comparison, a method that flags everything would beat the current method (DQ02 L94; EXP5 relayed saturation).
  - This is a requirement on C05's planned set, not a new component.
- **A2.** A qualification record, whatever its shape, needs the binding dimensions that are now missing: information sources, environment and grants, named use, judge model, instrument version, and the finer verdict states.
  - **Without them:** D-5's invalidation could not fire on a change of source, grant or judge, and a stale verdict would be reused as current (GS/CORE L432-444, L467-475).
- **No other prerequisite is added.** There is no SOUL exam bank, no new role and no new gateway.

## 5. Errors and squeezes

**Errors:**
- **E1 (in the hand-over).** The discovery read EXP4 STATE and MS01-COVERAGE, which both point to DQ02 and DQ04, but did not open DQ02 or DQ04, and it called the question open.
  - Failure class: a pointer seen in a derived view was not followed, and "not read" was treated as "not there" (Appendix D, D5).
  - Capability-gap candidate: discovery has no step that follows a package's own continuation records before declaring a question open.
- **E2 (in the hand-over).** The discovery's paraphrase of criterion 33 dropped the difference between the yardstick and the instrument.
  - Failure class: a qualifier lost in a summary, the same seam as GS/CORE L432-444.
  - Capability-gap candidate: check each paraphrase of one of Batu's criteria against its original (TR-A18) before it becomes a premise of the frame.
  - Effect: W1.
- **E3 (in the hand-over; I confirmed it).** GS/CORE L467-475 (F5) was cited for invalidation on a model or provider change. The passage covers stale artifacts taken as current and names neither model nor provider.
  - Failure class: citation by topical nearness, where the claim drifts past its source.
  - Capability-gap candidate: verify each citation against the exact sentence it supports.
- **E4 (in the hand-over).** The Qualification Case was read as a primitive for qualifying agents.
  - Failure class: the same term used on different layers, so the unit was mistaken (a D1 frame error).
- **E5 (in the hand-over; minor).** MS01-COVERAGE L40 (P6) was cited for deferring qualification. The closer passages are MS01 L99 and L119. Same class as E3.
- **E6 (research runs 3 and 4).** Search summaries added specifics that the abstracts lack (the Szymanski figures; the Feng certificate details).
  - Failure class: a derived view adding unsupported specifics.
  - Both were caught by the return-to-source rule; no new gap.
- **E7 (research run 4).** A web address recalled from memory returned 404.
  - Failure class: a remembered identifier treated as a found source.
  - Caught by the tool.
- **E8 (research run 3).** The header of SP S01 (L3) still says provisional and partial, while the study is accepted.
  - Failure class: a stale label in a derived view.
  - Small effect; the content is unchanged.
- **E9 (met in synthesis).** Run 3 reported a revision of Krumdick et al. dated 2026-09-28; run 4 could not confirm it.
  - Failure class: an unconfirmed changeable fact from a fetched summary.
  - Handling: I cite only the 2025-03-07 submission. No decision depends on the revision date.

**Squeezes:**
- **S1 (met by all three research runs).** "No answer key, so evidence before acting, so the evidence needs a home" pushed toward new mechanisms: a SOUL exam bank, the gateway as the qualifier, a new record family.
  - The frame was questioned first. Three premises create the limit: the agent is the unit; qualification comes before any act; criterion 33 requires an exam per agent. The sources weaken all three (W1 to W3).
  - Result: no new mechanism. Effects are gated, claims narrow, and the hidden exam stays in DevOS.
  - From C07, FrameReview is usable as a record for this.
- **S2.** "Where the evidence lives" pushed toward specifying a physical record before SOUL has a host (G03 open).
  - Frame question: does decision (ii) need a physical shape now?
  - Answer: no. The content is fixed and the shape is deferred (D-6).
- **S3.** Criteria (c) and (f) pushed toward overstating how strong the library passages are.
  - Frame question: is the measure the number of citations, or whether a cited passage really changed or limited a decision?
  - Answer: the effect of each citation is stated per decision, and its maturity is given in 2.3.
- **S4 (reading budget).** The gstack syntheses (about 13,000 lines) and Foundation CS S1, S2 and S5 were read only in part.
  - Frame check: further reading is unlikely to change D-2 to D-5, though it might add detail to D-6.

## 6. Next step

**Take D-6's open choice to a decision-ready comparison.** This continues the work; it is not new research.
- **Goal:** for the qualification record content fixed in D-6, compare three shapes and draft the decision at high_impact class with the fields of EkB 3.17. Do not accept it.
  - **(A)** Extend DevOS's Competence, EvalRun and EvidenceEnvelope.
  - **(B)** A separate qualification-standing record that references them.
  - **(C)** Qualifiers carried only on consuming records (work, decision, artifact), with no qualification record.
- **Inputs:** this result (D-2, D-3, D-5, D-6, and A2 in section 4). From devos:
  - EkB L267-275 and L285-293;
  - plan L149-154 (DevOS as SOUL's first instance; PC-10's portability path for criteria 2, 4 and 33);
  - plan L808-817 (7.3);
  - plan L191-193 and L218.
- **Method:** trace each option through two invented cases, labelled synthetic (criterion 20):
  - (1) a binding with a checkable end state, for example a data conversion checked against a target schema;
  - (2) a binding in a field nobody present can judge, with no reference.

  For each case, trace these events:
  - a move from level 1 to level 3;
  - a change of carrier model, which re-evaluates the qualification;
  - a change of judge model;
  - a downstream consumer reading the result.

  Record where each option loses a D-6 field or a qualifier.
- **Output:**
  - For each option: the D-6 fields it holds, the fields it loses, its portability path, and which C02 action would be wrong without it.
  - A Decision draft with options, premises, assumptions, reopen triggers and a recommendation.
- **Limits:**
  - Cite only the identifiers in section 7.
  - Write no files.
  - Add no mechanism beyond the three options.
  - Treat cost as out of scope.
- **Return point:** the probe's record. Its result joins this one in the note on plan/work/C02.md.

## 7. Records

[checked] = re-opened at 941f027d by this run. Unmarked entries come from the research reports.

**devos:** plan L107-119 [checked], L137-235 [checked], L806-818 [checked], L840-869 [checked], L955-970 [checked], L1038-1072 [checked], L1119-1144 [checked], L1356 [checked], L447-461, L575-583, L1168-1187; EkB L262-299 [checked]; plan/work/W-C01-25.md [checked]; plan/Ek_D_Dusunme_Protokolleri.md L60-331 [checked].

**LIB:**
- EXP4:
  - DQ01 L1-115 [checked]
  - DQ02 L1-125 [checked]
  - DQ04 L1-130 [checked]
  - T10 L37-52 [checked]
  - T11 L29-72
  - T15 L25-76
  - MS01-SOUL L1-166 [checked]
  - MS01-QUESTION-BANK L60-71 [checked]
  - MS01-RESEARCH L138 [checked]
  - MS01-COVERAGE L3, L29-34, L40, L63, L83-84
  - SY01 L38, L59, L79
  - reflections/OPEN-QUESTIONS.md L41-43, L61-63
  - reflections/QUALIFICATIONS.md L13-15, L33-39
  - STATE.md L39, L53
- EXP6:
  - work/B7-system-formation.md L1-6 and L60-139 [checked]
  - B9 L170-214 [checked]
- EXP5:
  - DEVOS02 L97-103
  - 04-ILK-CLOUD L3, L86-92, L221-237
  - 07-V2 L3, L14-33
  - LESSONS L21, L112
- lib:EXP-002/OPEN-QUESTIONS L5-11
- lib:explorations/CATALOG L1-3
- CS:
  - KEY.md L1-122 [checked]
  - S3-EVALUATION-UNCERTAINTY-INVALIDATION.md L218-299 [checked], L121-168
- ACT:
  - INDEX.md L36-55 [checked]
  - A1 L83-135
  - FINDINGS-MAP.md L52
  - OPEN-QUESTIONS.md L13-15
- lib:soul-foundations/STATE L36
- GS:
  - CORE.md L428-507 [checked], L7-20
  - testing-eval L640-725 [checked], L994-996
  - multi-agent-cross-model L505-562
  - review-qa L133-151, L469
- SP:
  - S01 L1-70 [checked]
  - CORE.md L76-78
  - META.md L7, L38
  - U06A L66-68
- AP:
  - 04-FALSIFIERS L374-403 and L480-501 [checked], L168-197
  - 03-SOUL L400-411, L512-516
  - META.md L50, L71, L99
- MAP:
  - CONVERSATION-SYNTHESIS.md L349-356, L460-485
  - SOUL-DEVELOPMENT-OS-ASSESSMENT.md L823-855
- lib:autoresearch/META L35, L58, L95-97
- lib:i-have-adhd/META L8, L27-30, L107-111
- lib:carbon-layer-mQfTdNVCOB0:
  - 12-VERIFICATION L29-31, L51-53
  - 14-MATH L11, L61-67
- lib:studies/CATALOG L21, L38, L51

**Outside.** All were read 2026-10-06 by runs 3 and 4; dates are as reported.
- arXiv papers (https://arxiv.org/abs/...):
  - 2503.05061 (submitted 2025-03-07; a later revision date is unconfirmed)
  - 2410.20266 (2024-10-26)
  - 2502.04313 (revised 2025-06-12)
  - 2506.07962 (2025-06-09)
  - 2404.18796 (2024-05-01)
  - 2306.05685 (v4 2023-12-24)
  - 2404.13076 (2024-04-15)
  - 2211.03540 (2022-11-11)
  - 2402.06782 (2024-07-25)
  - 2407.04622 (2024-07-12)
  - 2406.12045 (2024-06-17)
  - 1506.02629 (2015-09-25)
  - 2307.09009 (revised 2023-10-31)
  - 2312.06942 (revised 2024-07-23)
  - 1810.03993 (2019-01-14)
  - 2506.12469 (v2 2025-07-28; HTML §4 at https://arxiv.org/html/2506.12469v2)
- Anthropic, 2026-01-09, "Demystifying evals for AI agents" (www.anthropic.com, Engineering)
- https://airc.nist.gov/airmf-resources/playbook/measure/ (no page date)
- https://inspect.aisi.org.uk/eval-logs.html (no page date)
- https://ai.google.dev/gemini-api/terms (updated 2026-04-28)
- https://ai.google.dev/gemini-api/docs/rate-limits (updated 2026-09-02)
- https://support.claude.com/en/articles/11049741-what-is-the-max-plan (page undated)

## 8. Guard denials

none
