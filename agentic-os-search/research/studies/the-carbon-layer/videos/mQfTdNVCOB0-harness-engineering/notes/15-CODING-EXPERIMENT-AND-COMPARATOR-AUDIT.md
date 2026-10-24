# U03-C / Note15 — Coding results, experiment identity and the meaning of improvement

**Date:** 2026-09-16. **Standing:** bounded documentary/comparator audit and descriptive arithmetic, not a benchmark reproduction, live efficacy test or adopted architecture. U03-C follows the classification and math audits without redoing U01-B's source characterization. Source IDs resolve in [SOURCES](../evidence/2026-09-16-u03c-coding/SOURCES.md); [REVIEW](../evidence/2026-09-16-u03c-coding/REVIEW-AND-LIMITS.md) records the limits and local calculation correction.

## 1. The question connecting this experiment to the video

The video's final loop proposes improving a working arrangement using experience. The coding experiment offers a concrete candidate: a proposer examines earlier agent code and execution records, changes the harness around a fixed solver, and evaluates the result. The question is whether the reported evidence supports a useful change, a reliable search procedure, or a transferable operating rule. These are different claims. [P01 §4.3; earlier Note12]

Terminal-Bench includes terminal-based systems, scientific and other tasks, not only ordinary repository patching. The native benchmark measures the resulting environment through task-specific tests rather than accepting the agent's final account as sufficient. That makes this family useful for studying the transition from claimed completion to observed work. It does not make every task's verifier an infallible oracle. [B01 §§2–3]

## 2. Preserve three different run scopes

| Source surface | Reported object | Safe interpretation |
|---|---|---|
| Project-page interactive demonstration | Earlier, deliberately difficult 19-task subset; 28.5% baseline and 46.5% at iteration 7; expressly not the run producing the final reported harness | A within-demonstration 18-point difference, not the full-benchmark improvement |
| Paper Appendix A | A ten-iteration Opus 4.6 search narrative with a 64.4% baseline, rejected candidates and later environment preparation | A selected process account, not a raw paired reconstruction of the final table |
| Paper Table 7 and selected artifact README | Full 89-task result; Opus artifact reports 76.4% with five attempts per task; comparison rows come from the historical leaderboard | A reported selected-harness result and historical comparisons, not one uniformly controlled rerun |

[P02 opening and coding section; P01 Appendix A/Table 7; A01]

These numbers must not be joined into one curve. In particular, neither 64.4→76.4 nor the demonstration's +18 can be labeled the measured full-benchmark effect of the final snapshot change without a run-to-artifact correspondence. The current reference's two-search-trial/five-final-trial defaults also do not reconstruct every historical run. [R01]

The project-page illustration uses generic held-out language, but the coding-specific paper explicitly states that search and final evaluation use the same 89 tasks. The specific protocol controls this interpretation. Repeated evaluation can characterize stochastic behavior on those tasks; it does not turn them into new task identities. Manual and regex checks for embedded task strings address one leakage route, not all adaptation to repeatedly observed benchmark feedback. This limits generalization claims without demonstrating cheating or disproving the reported result. [P01 §4.3; P02]

## 3. What was actually added to the selected harness?

The selected artifact is built on Terminus-KIRA and Harbor's Terminus 2. KIRA's native tool calls, multimodal path, command-completion polling, completion reconsideration and caching are inherited capabilities. The highlighted discovered addition gathers a compact environment snapshot before the normal agent loop and supplies it with the initial task. [A01; K01; P01 B.3/Figure 9]

The mechanism shifts some recurring environment inspection from model-selected exploratory actions into a deterministic preparation step. It is not a newly invented whole agent, a mandatory multi-agent architecture, or weight training. It supplies a useful candidate division of labor: inexpensive, predictable observations can be prepared outside inference, while the solver still decides how to use them.

The claimed turn saving is not precisely consistent across descriptions: the paper's explanation, quoted proposer language and artifact README use different small ranges. They agree qualitatively about reducing early exploration, but no newly recovered per-task trace distribution establishes exact saved turns or end-to-end dollars. Startup work also costs time and can deliver irrelevant or misleading information. Total proposer, evaluation, setup and solver costs remain separate. [P01 B.3; A01]

U01-B already found meaningful qualifications: the snapshot's fail-soft command/parser can preserve execution while misrepresenting a failed listing; successful snapshot construction does not prove that its text reached the actual first model request; and the later reference baseline differs from the selected artifact in more than the highlighted function. Those remain the earlier mixed source/excerpt-test findings, not new runtime observations here. [Notes06–07; U01-B CHECKS]

A future comparison could contrast no preparation, this fixed preparation, and task-conditioned prerequisite discovery. It should measure actual request content, task quality, regressions and total cost. That is a proposed discriminating study, not a test run or a SOUL design decision.

## 4. Positive reported results and comparator boundaries

The [local arithmetic](../evidence/2026-09-16-u03c-coding/ARITHMETIC.json) preserves differences of published rounded percentages:

| Model held fixed within the table | Historical Terminus-KIRA | Meta-Harness | Difference |
|---|---:|---:|---:|
| Claude Opus 4.6 | 74.7% | 76.4% | +1.7 percentage points |
| Claude Haiku 4.5 | 33.7% | 37.6% | +3.9 percentage points |

[P01 Table 7; P02 coding section]

These support interest in an automatically discovered modification on a mature baseline. However, the larger differences from Terminus 2 include the intervening KIRA design and cannot all be credited to the environment snapshot. The historical rows do not bind identical runtimes, model settings, resources, task revisions or failure handling. Holding a displayed model name fixed is necessary for this subtraction but not sufficient for a causal comparison.

The newly read KIRA README advertises a different Opus percentage from the historical table. It is a later source snapshot, not an instruction to rewrite the old baseline. Its submission-path correspondence is useful provenance supplied by the maintainers, not a byte-verified historical execution receipt. The live leaderboard route did not yield usable historical rows in this reading, so no current ranking is asserted. [K01; L01]

The selected artifact's difficulty groups contain 4, 55 and 30 tasks. Weighting their rounded percentages by those counts gives 76.421348%, consistent at one decimal with 76.4%. An equal mean of the three groups would be 81.933333% and would answer a different question. Five attempts across 89 tasks implies 445 nominal attempts if coverage is complete, not 445 independent task types or a recovered raw outcome file. [A01; ARITHMETIC]

No confidence interval, p-value or newly solved-task count was inferred. The paper's statement that seven tasks improve does not supply a complete paired outcome vector or establish that all remaining tasks were unchanged. Nor does evaluation of two solver models alone show whether the same unmodified candidate was selected independently of the second model; exact cross-model candidate/search identities remain unrecovered. [P01 §4.3/B.3]

## 5. Does the search narrative establish the cause of improvement?

Appendix A is useful because it preserves failed ideas. Early candidates combine structural changes with a prompt rewrite and regress; later proposals try to distinguish the interventions; the seventh candidate changes preparation instead. A subsequent attempted composition and a crashed candidate remain part of that history. [P01 A.2]

This supports the narrower finding that a proposer can use records to revise hypotheses instead of endlessly repeating its newest idea. The reported file-access statistics support broad inspection of earlier material, not proof that every read was useful or that raw-history access alone caused the coding gain. The classification interface ablation remains evidence in its own domain; it was not repeated here for coding.

The proposer's confident causal language is itself source data. A return toward baseline after restoring one prompt is suggestive, but bundled edits, stochastic trials and adaptive selection leave alternatives. Calling an additive change safe does not establish absence of regressions, and a best-so-far archive can rise while many generated candidates worsen. This study therefore retains the positive discovery and failed attempts without promoting the narrative into a factorial causal experiment or monotonic self-improvement guarantee.

## 6. Follow one concrete task from request to external reward

To ground what a coding success means, this unit follows **path-tracing**, one of the paper's named improvement examples, at the task commit identified by the reference SETUP. This is task-source recovery, not reconstruction of the historical candidate's behavior. The old repository owner redirected; the same pinned task was recovered under `harbor-framework/terminal-bench-2`. [R01; T01–T04]

The task asks for a small C program generating a close reconstruction of a supplied image, with restrictions on reading the reference and using extra local source. Its test body checks source existence, compilation, compressed size, local dependencies, execution in a minimal chroot, output presence and normalized pixel-vector cosine similarity at a 0.99 threshold. The shell writes a binary reward from pytest's exit status. No program or task test was run. [T01–T04]

Three source-view distinctions matter:

- Figure 9's completion-checklist pass is the worker's internal completion path, not this task's separate pytest result.
- The test comments describe an older reference-file renaming approach and mention a 98% threshold; the executable body uses chroot and 0.99. The source body, not the stale comment, establishes the inspected contract.
- High image similarity, small source and constrained execution are observable properties. They do not by themselves prove every claim in the test commentary about the internal rendering algorithm. This is an oracle-scope limit, not an exploit demonstration or a verdict that the task is worthless.

The test environment also has compilers and setup dependencies of its own. Whether a zero reward reflects an incorrect solution or an evaluation-infrastructure problem requires the actual logs and configuration. No such historical failure was observed here. One recovered task cannot certify all 89 graders, and the task commit named in setup is not proof that every historical trial used those exact bytes.

The bounded chain is therefore: worker produces an artifact → task-specific code measures selected properties → a binary reward is recorded → the optimizer interprets that reward → an owner may later accept a change. Its links can fail for different reasons. Neither a completion message nor a reward alone supplies the entire acceptance argument.

## 7. Research value, closure and next boundary

This family adds a concrete example of improving a working arrangement by changing preparation rather than increasing model power or agent count. It also shows why improvement claims need run identity, inherited-baseline attribution, meaningful outcome measurement and exposure-aware transfer claims.

For later SOUL/Development OS inquiry, these are candidate selection criteria and falsifiers: determine what should be prepared before inference, preserve observed-versus-assumed capability, distinguish worker completion from checked effects, and bind any accepted improvement to its tested conditions. No current project architecture or implementation was assessed or changed.

**U03-C is complete at documentary/arithmetic depth.** The three planned U03 experimental families now have bounded audits in Notes13–15. Historical replication, complete cost, statistical uncertainty, raw paired outputs, independent search repeatability and causal efficacy remain open. U01's unexecuted and limited tests and U02's audio-fidelity boundary are unchanged.

Return this result before entering U04. The next logical phase is a full source-native synthesis linking operational responsibilities to proposal, evaluation and qualified change, followed by selective comparison under the plan. It is not performed here; current authorization and subsequent user direction govern its start. U05–U07, formal project projection and CORE remain open.
