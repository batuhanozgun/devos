# U06-A — Skill Authoring, Behavioral Criteria and Change Admission

Date: 2026-09-17. Primary target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE INVESTIGATION COMPLETE. U06 OVERALL REMAINS OPEN.** This unit explains the author's intended skill-development and contribution method, not demonstrated general effectiveness. U06-B owns the evaluation implementation, evidence-to-verdict path and remaining CI/release qualification. U01–U05 and all their evidence remain unchanged.

Source IDs S58–S69, dependency D01–D03 and supplementary X07 resolve in [SOURCE-LEDGER-U06A.md](../SOURCE-LEDGER-U06A.md). [METHOD.md](../METHOD.md) remains v0.1; PLAN v0.7 records the source-led split.

## 1. Question and coverage

How does an observed agent failure become a reusable skill, a behaviorally evaluated change and an admissible contribution? Which observation would justify each transition?

Twelve new primary-repository files were read fully: writing-skills, its testing and persuasion references, the worked CLAUDE-document example, root contributor guidance, the PR template, gitignore, and the debugging creation log plus four academic/pressure files. Writing-skills was read in contiguous ranges through its final Discovery Workflow. This completes full reading of the fourteen observed SKILL bodies, not all supporting files, runtime, history or system-level explanation.

The actual authoring package is larger than those bodies. Its copied vendor best-practices document and graph-rendering supports were listed but not read here; their role remains reference/tool coverage for later re-entry. No authoring reference is activated as our agent-control. Historical paths inside examples are not assumed to be current host paths.

A separately versioned evaluation repository was discovered through the contributor guide and pinned before use. Only its ref/commit metadata, non-recursive root tree and README orientation were inspected. The README is PARTIAL: exact lines 1–165 were recovered after an initial truncated response. Its implementation, scenarios, retained results, CI and transitive evaluator were not read or executed. Its newer snapshot is not assumed to be the evaluator used to qualify our primary Superpowers pin.

No new upstream script, model, agent, test suite, synthetic behavioral response or pressure scenario was executed in U06-A. There is deliberately no new E-series experiment or fabricated pass count. The bounded question is answered by source analysis; behavior and effectiveness remain distinct claims.

## 2. F43 — Skill authoring begins by selecting the kind of intervention

**OBSERVATION — S58/S60/S62.** Writing-skills describes reusable techniques, patterns and references rather than narratives of one successful session. It separates broadly reusable knowledge from project-specific conventions. It also recommends implementing mechanically enforceable constraints as automation rather than relying on prose. Contributor guidance separately sends domain-, project- or tool-specific additions to standalone plugins instead of automatically enlarging core.

The intended change path is therefore not simply incident → more instructions. It includes deciding whether the remedy belongs in a reusable skill, project instructions, executable validation or a separate plugin. Those are target design choices, not an adopted taxonomy for SOUL.

The authoring cycle then runs a scenario without the skill, records failures and rationalizations, adds a focused intervention, runs with the skill and revises. For an existing-skill edit, the general no-skill control and the actual prior version answer different questions. The contributor template asks for before/after outcomes, but these documents do not fully specify every controlled-comparison variable for each edit.

**INFERENCE.** A no-guidance control can show that the proposed guidance adds something under the tested conditions. It does not alone show that a new revision is better than the existing revision. Model, task, context, tool availability and scoring must not silently change along with the wording when attributing an improvement. No such comparison was run by this study.

## 3. F44 — Discovery metadata and behavior-shaping content have different jobs

**OBSERVATION — S58.** The description should answer when the skill should be loaded, not abbreviate its full procedure. The source's rationale is that an agent may use a workflow summary as a shortcut and skip the body. It also recommends explicit skill-name dependencies, selective supporting references and avoiding unnecessary immediate loading.

Its discovery anecdote refers to one versus two reviews. That is historical explanatory material, not authority to replace the current one-task-reviewer/two-verdict topology established in U03. An anecdote inside a current file can still describe an earlier workflow. The observed existence of a description does not establish that a host exposes it or that the model actually loads the body; U01's delivery distinctions remain necessary.

**SUPPLEMENTARY SPECIFICATION CHECK — X07.** The current Agent Skills specification was consulted separately on 2026-09-17. It distinguishes mandatory format constraints from recommendations: lowercase skill names, a 1–1024-character description, and descriptive guidance covering what a skill does and when it applies. S58's trigger-only description is a project-specific method preference; its total-frontmatter length wording is not the specification's description-field limit. Its capitalized illustrative name should not be copied as a specification-conformant name. No validator was run, and no host failure or repository-wide incompatibility is claimed.

S60 expressly says the project does not automatically accept changes made merely to match vendor writing guidance; outcome evidence is required. Thus specification identity, vendor recommendation and local behavioral preference must be separated. The copied anthropic-best-practices file is not used here as proof of current vendor policy or as a substitute for an empirical comparison.

## 4. F45 — The form of guidance is selected by the failure, not by a universal preference for stricter wording

**OBSERVATION — S58/S63.** The current writing skill distinguishes four intervention forms:

| Observed baseline problem | Form prescribed by the source | Boundary |
|---|---|---|
| Agent knows a rule but bypasses it under pressure | Explicit prohibition, rationalization counter and red flags | Appropriate scope is discipline enforcement, not every output defect. |
| Agent follows the task but produces a poorly shaped output | Positive recipe describing the output's parts and order | More prohibitions are not assumed to improve shape. |
| A required element is repeatedly omitted | A required field/slot in the artifact template | A slot makes omission more visible; it does not prove the value is correct. |
| Behavior should vary with a condition | Conditional rule tied to an observable predicate | The predicate still has to identify the right condition and target. |

The persuasion reference also varies recommendations by skill type, discourages liking-based compliance, and states that techniques should serve the user's genuine interests. It is not a license for this research assistant to fabricate authority, urgency or evidence.

S58 claims head-to-head wording tests favored recipes over prohibitions for a shaping problem and that a nuance clause increased variability. The underlying run records were not recovered here. S63's borrowed statistics and psychological explanations likewise remain target claims; the cited research was not reviewed in this unit. Neither is evidence that the same effect size or causal account holds for software-development quality.

**INFERENCE.** The important source-grounded contribution is a conditional intervention-selection model. It is more informative than calling Superpowers a collection of increasingly emphatic prompts. Actual improvement must still be tested; a more consistent output can consistently omit the same necessary information.

## 5. F46 — Wording trials, pressure tests and useful task outcomes are distinct evaluations

**OBSERVATION — S58/S59.** The current writing skill includes a micro-test stage: a fresh context per sample, realistic surrounding instructions, a no-guidance control, at least five repetitions per variant, manual inspection of flagged automated matches and attention to variability. If the control does not exhibit the failure, it says not to author guidance to solve that unobserved problem. Micro-tests are explicitly not substitutes for full pressure scenarios in discipline skills.

The testing reference combines time, sunk-cost, social and authority pressures. It asks authors to record exact choices and rationalizations, revise against observed failures and re-test. Academic questions test understanding; technique/reference/pattern testing in S58 additionally considers application, retrieval, novel situations and when not to apply a pattern.

S59's don't-test-reference language occurs in a discipline-focused pressure-testing document. S58 explicitly asks for retrieval/application checks of reference skills. This can be read as different test scope rather than a global ban on evaluating references; the files do not provide an executable scope resolver.

**INFERENCE / VERIFICATION LIMIT.** These are useful experimental disciplines, not proof that a completed experiment satisfies them. Five repetitions is an authoring heuristic, not a statistical guarantee. Fresh context reduces carry-over but does not independently validate the oracle or remove shared model/source assumptions. A test that rewards the expected A/B/C choice measures that choice unless actual effects are independently inspected.

The pressure loop repeatedly revises against the same scenarios. That is legitimate development evidence but not independent confirmation of generalization. These particular documents do not specify a separate held-out challenge set or fully determined stopping threshold. This bounded statement must not be generalized to the external evaluation repository, whose partially read README describes additional comparison and assessment mechanisms.

Meta-testing asks the agent how wording could make the selected correct answer unavoidable. That answer is useful feedback for a new wording hypothesis, not an independent diagnosis of why the model failed or proof that the rule itself is appropriate. S59 treats some disagreement and hybrid approaches as evidence of failed discipline; evaluating rule legitimacy, authorized exceptions and useful outcomes is a different question. Compliance and good judgment must not be collapsed.

## 6. F47 — Scenario definitions, anticipated outcomes and historical success narratives are not interchangeable records

**OBSERVATION — S64–S69.** The worked CLAUDE-document example contains four scenarios, a NULL control, four wording variants, a proposed protocol, expected outcomes and next steps to build/run the test harness. It does not contain completed variant counts, full execution traces or an observed winning arm. Its introductory reference as a complete worked campaign cannot upgrade expected results into actual results.

The debugging CREATION-LOG reports successful academic/pressure checks and a completed skill. This is a first-party historical narrative dated 2025-10-03, with old source paths and no run-level identities in that file. It records what the author claims happened, not new execution evidence at the 2026 primary pin.

The companion academic file asks questions based solely on the skill and requests quotations. The three pressure files ask for choices under an emergency, exhaustion/sunk cost and authority/social pressure. They are stimuli, not subject responses. Their dates/roles and older paths must be preserved rather than interpreted as a current installed integration.

| Evidence surface | What was actually available in this unit | What it cannot establish alone |
|---|---|---|
| Academic prompt | Questions about the skill | Actual understanding, use or effect without a response/run |
| Pressure prompt | A scenario and choice framing | Correct tool invocation or improved task outcome |
| Worked variant document | Design, expected results and planned next steps | A completed comparative evaluation |
| Creation log | Author-reported historical outcomes | Reproducibility, present-version behavior or general success rate |
| Current writing instructions | Proposed controls, repetitions and manual checks | That those controls were used in any particular claimed result |

U03's description-predicate finding and U05's native-preference/source-policy limits remain prior results at their original scope, not reruns. Their existence does not establish that all evaluations are defective; the external lab requires its own investigation.

## 7. F48 — Contribution acceptance asks for situated evidence and human responsibility

**OBSERVATION — S60/S62.** The contributor guide and actual PR template ask for a specific experienced problem, alternatives, prior open/closed PRs, the authoring model/harness/plugins, tested environments, before/after evaluation across sessions and human review of the complete diff. They direct contributions to dev, describing main as the released branch. New-harness submissions require a clean-session transcript showing automatic brainstorming before coding on a prescribed todo-list request.

These documents treat a skill change as a behavior-changing intervention rather than editorial cleanup. They also reject speculative bulk fixes and changes justified only by conformity to vendor prose recommendations. The stated PR rejection percentage is not a measured result of this study.

**INFERENCE.** This is an admission contract connecting motivation, provenance, comparison evidence and human accountability. It is not evidence that branch protection or CI enforces every field, that maintainers always apply it, or that a checked human-review box proves review occurred. A single prescribed new-harness scenario tests a narrow entry path, not every workflow or host state.

Local/personal skill creation, contributor PR admission, maintainer acceptance and release distribution are different transitions. S58's commit/push-to-fork checklist does not itself establish released behavior. The development-only external evaluation dependency also does not, by itself, contradict a zero-dependency distributed-plugin design.

No upstream issue, contribution, installation or change of this research assistant's rules is authorized or performed by these observations. Our synthetic/source findings remain research evidence, not automatically eligible upstream problem reports.

## 8. F49 — The evaluation lab is a separately versioned dependency, not hidden content in this plugin snapshot

**OBSERVATION — S60/S61 and D01–D03.** The contributor guide points to prime-radiant-inc/superpowers-evals and calls the harness Drill. The primary root tree has no tracked evals entry, and gitignore explicitly excludes a separately cloned development evals directory from the published plugin. This is a positive architectural distinction, not a retrieval miss being mislabeled as missing tests everywhere.

The referenced repository was accessible. Its observed main was separately pinned at `e64684cd1fa270c464ac797747e45bbe8d127e8b`, commit timestamp 2026-09-12T00:49:23Z, root tree `38d962c27c78a4ba692fe3c0f8ec6ebb8f80a059`. Its README calls the system Quorum. Our primary target remains the earlier b36e0829 pin; no primary repin or historical evaluator correspondence is asserted.

The inspected README segment describes a static/unit versus live-evaluation split, broad-permission live CLI launches, per-run homes that are explicitly not a sandbox, private criteria and a fresh assessor following a user-like conversation. It also describes stock-versus-pinned-treatment comparisons retaining harness/model/effort/evaluator settings and distinguishes conversation completion from pass/fail.

These are promising **target descriptions**, not verified implementation findings. No code path, private criterion, run record, grading result or compatibility with the primary Superpowers revision was checked in U06-A. The commit message's run counts/costs and the README's supported-workload claims are not reused as effectiveness evidence. No credential file or raw sensitive transcript was opened.

**Next dependency question:** Which exact Superpowers revision and environment is provisioned, what is actually observed, which checks operate independently, and how do missing/partial evidence and evaluator disagreement affect the final verdict? U06-B must follow that path rather than infer the answer from the README or import the newer lab's guarantees into the older plugin snapshot.

## 9. Native partial model and method reflection

The source-defined development loop is:

`observed problem → choose intervention layer → classify baseline failure → author discoverable content/template/conditional → controlled wording trials → relevant application/pressure tests → revision → human-reviewed contribution → maintainer/release process`.

Each arrow has a different evidence obligation. A behaviorally compelling instruction is not a valid scoring rule; a repeatable score is not proof of useful outcome; a useful local change is not a released dependency. This is a partial native mechanism model, not a whole-system CORE or Foundation projection.

U06 is split because its load-bearing evaluation machinery is a separate, newer source corpus. U06-A closes authoring/admission at source level. U06-B remains open for evaluator implementation, corpus compatibility, observed-result grading, CI and release qualification. Supporting runtime/materialization stays U07; whole-system composition stays U08. METHOD v0.1 and closure criteria are unchanged. No experiment was created merely to preserve the pattern of earlier research rounds.

## 10. Residuals and next work

Q21 gains a source-layer map of academic, pressure, narrative and external-lab evidence; no global evaluator qualification follows. Q20/Q24 gain scope distinctions between discipline pressure testing and other skill evaluation. Existing Q18 result binding and Q27 retention/receipt remain relevant to evaluation artifacts.

New questions:

- Q30: for edits, what controlled comparison distinguishes no-guidance benefit from improvement over the prior skill revision, while preserving task/model/context and uncontaminated assessment?
- Q31: what actual observation and scoring path distinguishes a compliant statement, a tool action, a realized effect and useful task outcome; how are grader errors/disagreements handled?
- Q32: how are legitimate exceptions, human authority and criticism of a rule separated from rationalized noncompliance in the tested criteria?
- Q33: which subject revision, harness/model configuration, evaluator revision and dependencies make a lab result applicable to this pinned Superpowers corpus?
- Q34: which evaluation and human-admission obligations are actually enforced before dev-to-main release, and what evidence survives that transition?

**Next logical and authorized unit: U06-B — evaluation implementation and evidence-to-verdict qualification.** Recover this note and its source ledger. At the separate eval pin, complete README and inspect ABOUT, contributor/safety guidance, package scripts, scenario-authoring, scenario/suite/arm identities and the relevant src/test paths. Follow one bounded representative scenario through provisioning → interaction/capture → deterministic checks → assessor → verdict/report. Pin any transitive evaluator before using its implementation/results. Keep the primary target pin unchanged and record compatibility rather than assuming it. Examine CI/release obligations without launching agents, installing tools, acquiring keys or publishing anything upstream. Split B further if its dependencies warrant a bounded handoff.
