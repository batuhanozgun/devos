# U04 / Note17 — Selective comparison and the research-to-use bridge

**Date:** 2026-09-16. **Standing:** bounded cross-study comparison and candidate-use synthesis, not a combined product benchmark, current deployment audit or U06 project design. Read with [Note16](16-OPERATING-ARRANGEMENT-AND-QUALIFIED-CHANGE-SYNTHESIS.md). Exact pins and reading depth are in [SOURCES](../evidence/2026-09-16-u04-synthesis/SOURCES.md).

## 1. Why these two studies were reopened

The source pair explains operational responsibilities and a particular search for better harness code. To make the synthesis complete at its chosen level, two further questions matter:

- When a change is selected, what connects its source to the behavior a real worker consumes?
- When experience is saved as reusable knowledge, what does maintaining or using that knowledge actually establish?

The catalog led selectively to GSTACK's generation/install/update research and HERMES's skill-library lifecycle research. This is not a requirement to complete either product study again or load every related framework. Both already have relevant bounded results. Their fresh primary checks here address specific symbols/assertions, not whole systems.

| Source object | Contribution to this synthesis | Not being compared or certified |
|---|---|---|
| The Carbon Layer video | Operating responsibilities and an experience-driven evolution question | Universal completeness of its ten-part map |
| Meta-Harness paper | Code-level candidate generation and evaluation using recoverable experience | End-to-end safe deployment, recursive optimizer self-rewriting or every kind of learning |
| GSTACK pinned self-development study | Authored, generated, installed and running behavior are distinct states | Relative optimizer performance or the current product after the study's revalidation |
| HERMES pinned skill-library study | Knowledge maintenance, discovery, loading and usage records have different meanings | Future-task efficacy, universal memory quality or current release behavior |

Their complementarity is analytical. Evidence from one is not experimental validation of another.

## 2. GSTACK: selection is not materialization

The previously completed GSTACK study examines `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`, v1.79 context. Its later v1.80 check remains a dated, separate revalidation; it is not extended here. The selected subsystem synthesis distinguishes authored templates, generated skill representations, installed assets and live processes. [G01–G02]

The useful positive mechanism is staged user-local rendering: prepare a candidate rendering outside the canonical checkout, preserve the live representation on a failed preparation path, and switch the live path after successful preparation. This is a narrower and more useful object than a blanket statement that an update is safe.

A fresh read of the pinned `test/user-render-out-dir-install.test.ts` makes the intended distinction inspectable. Its tests assert temporary rather than live output paths, exercise extracted swap helpers on a successful fixture, and construct a failed-render branch that must leave the old rendering and installed symlink readable. Additional cases distinguish locally rendered content from the unchanged canonical source. **We read this test source; we did not execute it, its dependencies or the complete installer.** In particular, the failure case is a reconstructed branch, not a crash test of every setup path. [G03]

The older subsystem study also preserves counterexamples and different failure postures across upgrade paths. Its conclusions cannot be flattened into all updates are transactional. Replacing files, completing migrations and moving a busy process to new code remain different problems. Those older findings retain their own source/test scopes; no new runtime verdict is assigned here. [G02]

**Contribution to Note16:** a selected candidate can be scientifically interesting yet fail to reach the intended worker, or can reach only some consumers. Acceptance should not be confused with materialization, and materialization should not be confused with the measured benefit that justified the candidate. These distinctions do not require adopting GSTACK's installer, template format or whole workflow.

## 3. HERMES: recorded use is not measured learning efficacy

The selected HERMES research remains pinned to `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. Its campaign is active/partial. The reopened note and evidence concern library maintenance and the path from files to discovery and loading, not a newly completed quality-evaluation study. [H01–H03]

A fresh primary read of `tools/skills_tool.py` follows the registered `_skill_view_with_bump` handler. After the deduplication path, it calls `skill_view`, parses a successful result and increments view/use counters for the resolved skill. The comment explicitly associates viewing with loading the skill for use and with the curator's last-used timer. There is no task-quality comparison in this inspected handler. That local observation does not claim that no other HERMES component can evaluate work. [H04]

This is a legitimate operational definition of use for library maintenance. It would be a different claim to say that every counted use improved the task. The earlier evidence also distinguishes list entries, prompt indexes, full content, readiness, cached representations and actual downstream behavior. Its rollback discussion distinguishes restoration of selected files from restoration of all relationships and external effects. These remain source-grounded, bounded results, not newly run fault experiments. [H02–H03]

**Contribution to Note16:** converting experience into a skill opens a continuing maintenance and consumption problem. A skill must remain discoverable and applicable to the recipient; the evidence that it helped must come from the task, not be manufactured from its view counter. HERMES's implementation is a concrete case, not a required SOUL memory design.

## 4. A direct source connection to the research library

Appendix D of Meta-Harness explicitly suggests making relevant prior experience, solved-example corpora and research papers navigable to the proposer. The authors label the appendix as engineering lessons rather than scientific claims about the method. It therefore supplies a direct source motivation for research reuse, not experimental proof that this repository's library improves SOUL. [P01 Appendix D]

Our resulting hypothesis is more specific than feed all research into the agent:

**Different consumers may need different products of research, and each product retains its own evidential and authority status.**

| Research product | Possible consumer/use | Qualification that must travel with it |
|---|---|---|
| A source-native explanation | Analyst learning how a mechanism works | Version, scope, source claims versus our inference |
| A bounded candidate mechanism | A proposer constructing an alternative method | Prerequisites, actual implementation limits and relevant simpler alternatives |
| A failure case or rejected idea | A diagnostician or reviewer | Conditions producing the failure; rejection is not universal invalidity |
| A discriminating example | An evaluator designing a useful check | What it detects, what it misses and whether it has already influenced selection |
| A task-specific procedure | A worker performing recurring work | Applicability, current owner, required capabilities and expected evidence |
| An unresolved question | Planner deciding what must be learned before action | Why the unknown changes the decision and where the source can be recovered |

These are candidate roles, not new repository schemas or mandatory runtime components. Some useful research stays background understanding. A reviewed source can justify not adding a mechanism. A library can be valuable while only a small relevant part is consulted for a given task.

### The role of the same record can change the experimental question

If an example is used to generate or select a candidate, it can still be useful for regression testing. It no longer supports a claim that the candidate never encountered that example. If a score, successful trace or expected answer becomes proposer input, the later evaluation must describe that exposure. This is an analytical consequence of the U03 findings, not a blanket ban on reusable tests.

Likewise, a paper's recommended technique is an idea to investigate, not an instruction with authority over the current work. A generated summary must retain a route to exact evidence when details become decisive. Safe reuse is not established by a file's location in a research directory.

## 5. What survives the comparison, and what does not

**Supported synthesis at this depth:** the three objects expose different links of a research-to-use chain. Meta-Harness supplies a particular improvement search; GSTACK supplies a source/materialization distinction; HERMES supplies a maintenance/consumption distinction. The selected primary reads make the latter two concrete without importing their entire systems.

**Unestablished stronger claim:** combining these mechanisms necessarily produces an effective or safe self-improving operating system. We did not implement their integration, measure its overhead, establish common interfaces or validate transfer to the current SOUL/Development OS context. Such a composition may be unnecessary for simple work or may create new failure modes.

**Alternative framing retained:** some tasks are better served by a fixed prompt, a single worker, exact source reading or a small deterministic script. Some improvements require changing the model, objective or environment rather than its wrapper. A reasonable objective is not maximal automation, maximal history or maximal control; it is appropriate support for the particular work under its real constraints.

**No novelty inflation:** existing studies already distinguish source, representation, authority, effect and actual consumption. U04's addition is an explicit connection among these bounded findings and the video/paper question. It does not rediscover the entire field or turn those studies into Foundation canon.

## 6. What should happen next?

U04's source-native synthesis and selective comparison are complete at documentary/analytical depth. The next planned phase is U05: determine which remaining rival explanation or missing observation warrants a bounded probe. A focused candidate is the environment-preparation path already characterized in U01-B: distinguish raw observation, interpreted snapshot and the actual first request constructed for the solver. Its source recovery, fixture/oracle and provider-free boundary must be specified before execution.

That candidate is not yet a selected or executed U05 test. A source-only or limited request-construction probe could clarify representation and consumption, but could not establish live quality, saved cost or historical reproduction. If those stronger claims are not needed yet, retaining the uncertainty may be preferable to more tests.

The formal current-Foundation and separate SOUL/Development OS projection remains U06. No Foundation tree, agent-control, runtime, development grant or other study's completion was changed. The channel still has one linked canonical home for the first video; this comparison is not a multi-video synthesis and no second video has been selected.
