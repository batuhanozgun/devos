# U05-B — Skill outcomes, evaluation and change

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q06c, related Q07/Q08/Q10. [Sources S109–S122](../evidence/U05-B-SOURCES.md), [E04 execution](../evidence/u05-b-evaluation-probe/README.md), [round/MR08](../ROUND-U05-B.md). This is a bounded mechanism explanation, not the deferred joint whole-study evaluation.

## 1. Native map: three learning-related paths, not one proved loop

U05-A traced homunculus observations → model-authored instincts → SessionStart context. This unit found two other paths whose names must not conceal distinct records and consumers:

| Path | Producer / storage / consumer | Current evidenced effect |
|---|---|---|
| Automatic invocation telemetry | Skill event → skill-run-tracker → skill-evolution/tracker → default home `.claude/state/skill-runs.jsonl` → skills-health | Records invocation-labelled outcomes and reports rolling rates/trends |
| Improvement observations | create/appendSkillObservation → project `.claude/ecc/skills/observations.jsonl` → session-inspect skills:health/amendify/evaluate | Builds outcome summaries, a Markdown proposal and a rate-based recommendation |
| Procedural instincts, retained U05-A | selected tool observations → optional analyzer → personal/inherited instincts → SessionStart | Places selected action text in additional context |

S109 imports the **skill-evolution** tracker, not S110's **skill-improvement** observation writer. The record contracts differ: flat skill_id/outcome versus ecc.skill-observation.v1 with nested skill/outcome/run. S115 reads the latter; pointing it at the former JSONL does not constitute a schema conversion. No automatic bridge between these paths was established. Default-branch search found helper/test/caller references but is not an exhaustive pinned-repository proof of absence.

The improvement caller serializes its result and optionally writes that JSON to a caller-selected output path. It does not execute the proposed skill, run a benchmark, apply the Markdown fragment to SKILL.md, call versioning, or invoke the Python instinct promoter in this traced branch. Its recommendation is an output for another actor, not proof that a change has been admitted or used.

## 2. What the automatic outcome actually measures

S109 accepts only Skill tool events with a bounded identifier-shaped skill name; it synthesizes task_description from that identifier rather than storing the prompt. A version field is taken from plausible input fields or becomes `unknown`. It records failure for PostToolUseFailure or selected error-bearing object fields; otherwise it records success. Missing responses and free-text failure prose are not independently interpreted by this predicate.

This is useful best-effort invocation telemetry, not task-quality evaluation. W12 distinguishes successful tool completion from broader task completion; W13 describes ordinary skill invocation as loading rendered skill content into context. A later implementation/test failure need not be a failure of the earlier Skill tool call. Conversely an actual failure event is handled, not universally labelled successful.

The real route matters: retained S106 calls the tracker module's run function from the PostToolUse dispatcher. Retained S99's selected failure route uses run-with-flags; newly read S122 detects and calls exported run(raw, context). The tracker lacking its own standalone main is therefore **not** proof that this registered route is inert. Profile/root/runtime conditions remain relevant; no live route was executed here.

S114 normalizes identifiers, outcome enum, optional feedback, numeric fields and timestamp, then uses an explicitly supplied state-store writer or falls back to JSONL. The ordinary hook supplies neither session/project identity, a content digest, task evidence, verified feedback, tokens nor duration. The wider schema's ability to carry such data does not mean this producer provides it. There is no after-the-fact task-acceptance update in the examined hook.

Storage retention is bounded and best-effort, with owner-only modes attempted. These are meaningful operational choices; they neither authenticate the observed outcome nor prove complete telemetry. Hook failures can be swallowed; malformed JSONL rows can be omitted by analytics. No lossless journal, multi-user confidentiality or concurrent-write guarantee was tested.

## 3. Two meanings of health

S118's rolling health reports success rates over seven and thirty days, a trend, pending amendment count and a current version label. Rates are grouped by skill ID, not by version, while the displayed version comes from S119's file snapshots. Therefore the adjacent version label is not proof that all contributing runs used that version or the current SKILL.md bytes.

Its headline `healthy_skills` is total minus declining. With the default positive decline threshold, no observations yield null rates and stable trend; a constant zero success rate in both windows also yields stable trend. Both can be counted as non-declining/healthy even though one has no outcome evidence and the other has only failures. The detailed n/a or numeric fields remain available: this is a label/interpretation boundary, not total erasure of the evidence. These cases are source-derived and were not run in E04. The seven-day window is nested within thirty days, not an independent comparison cohort.

S111's separate improvement health instead counts failures across its supplied records, assigning failing at the default absolute count two, watch at one, healthy at zero. It groups error/task/feedback strings from failures. Those recurring labels can guide investigation but do not establish the causal defect in the skill. Different inputs and thresholds mean the two health surfaces can legitimately disagree; there is no universal ECC health verdict shown by these files.

S121 provides real provenance metadata validation and learned/imported path rules. However S118 uses its classification/root helpers, not a provenance admission check for every reported skill. A provenance helper's presence is not a control on every consumer.

## 4. A proposal is generated from failure labels, not a demonstrated repair

S110 creates observations from caller-supplied task, skill, success and optional feedback/session/amendment metadata. `Boolean(input.success)` is coercion, not proof of a successful task or strict boolean validation. Its reader filters by schema label and drops malformed JSON; it does not validate each nested record against a complete schema or report discarded-row counts. These are source findings; E04 supplies well-shaped fixtures directly rather than exercising this writer/reader.

S112 reads the summarized labels, not the target skill text or original task evidence. It makes an additive Markdown fragment suggesting routing focus, a guardrail for the top error, an example for the top failing task, feedback handling and a verification checklist. That is an inspectable proposal, not an analysis showing the proposed text fixes the actual cause.

The no-failure case returns insufficient-evidence. A **single** failure is sufficient to return proposed, however, including when minFailureCount is passed as ten: that option changes the health status but the proposal decision checks only whether failures is nonzero. E04 C08 observed both cases. The returned stock rationale nevertheless says proposals come from repeated failures rather than a single anecdote. Its preview can also refer to proven success cases when the input contains no success. Actual evidence counts remain in the object; the explanatory prose overstates what the predicate requires.

A one-event exploratory proposal can be useful. The defect in interpretation is to treat the wording as proof of repeated evidence or a validated remedy. No task was repaired and no skill file was changed by E04.

## 5. The evaluator has real gates, but no independent outcome oracle

S113 does not run baseline and amended candidates. It consumes records, filters by skill ID and treats every variant other than the exact string `amended` as baseline. An optional amendmentId restricts only the amended records. It computes recorded success rates, rounded to three decimals, and their difference.

The decision is:

- fewer than the configured minimum (default two) in either group → insufficient-data;
- enough rows and positive rounded success-rate difference → promote-amendment;
- enough rows but zero/negative difference → keep-baseline.

These predicates are genuinely implemented. They do not validate unique run IDs, paired/comparable tasks, equivalent environments/models, consistent criteria, content digests, independent outcome judgments or a nontrivial effect threshold. Without an amendment selector, multiple amendments can be pooled. An amendment ID is a supplied label, not an authenticated binding to bytes.

### E04: original-helper execution with predeclared controls

The three executed target files matched their pinned blobs before and after the single run. No target dependency was stubbed. Synthetic input fixtures and complete output are preserved with the pre-execution plan; upstream tests were inspected, not run.

| Contrast | Observed |
|---|---|
| No input / only one row per variant | insufficient-data; empty proposal insufficient-evidence |
| Two paired tasks, recorded 1/2 baseline vs 2/2 amended | promote-amendment, delta 0.5 |
| Recorded regression / recorded tie | keep-baseline in both |
| The same baseline row duplicated and same amended row duplicated | promote-amendment; four rows but only two unique observation IDs |
| Keep outcomes but replace amended task labels with unrelated tasks | same promote-amendment; task difficulty was not measured |
| Two amended successes from different amendment IDs | unfiltered promote-amendment; selecting one ID leaves one row and returns insufficient-data |
| Only one failed observation, proposal path | proposed, with repeated-failures rationale |

The counterexamples show that a recommendation can survive loss of evidential independence/comparability. The negative controls prevent the opposite overclaim that no gate exists. Nine matching expectations are **not** nine tests proving a better skill. They characterize original helper behavior with stipulated labels. A validated upstream experiment could satisfy the missing assumptions, but that validation was not supplied by this function or demonstrated by this run.

The close causal explanation is sufficient for this unit: the gate uses aggregate row counts/rates, not identity/task/evidence checks; the caller only reports the result. No unsupported historical claim about why maintainers chose this design is needed. A control imposed elsewhere would require an actual connected caller, not a similarly named module.

## 6. Actual file-change mechanisms exist, separately

S119 can snapshot SKILL.md into `.versions/vN.md`, append evolution records and restore a prior snapshot while making a new version. These are real mutation mechanisms, not just descriptions. But their public arguments and source path do not demand S113's evaluation result or a human approval certificate. Snapshot history is not an independent validation of the restored behavior.

`getCurrentVersion` returns the largest snapshot number, or one when only the skill file exists; it does not compare current content against that snapshot. Pending-amendment reporting counts matching log entries, not necessarily the latest resolved state per proposal. Deeper event reduction/concurrency/host-refresh tests remain open. No snapshot or rollback was executed in this unit, and no automatic call from session-inspect's recommendation to these mutations was found in the traced path.

## 7. Disposition and next boundary

Q06c1 is bounded-answered: automatic invocation telemetry, a separate outcome-observation scaffold, health/proposal/evaluation semantics, and the actual reporting versus mutation boundary. Q06c remains partial through Q06c2: connected independent task oracle, actual change admission, version-bound experiments and later use are unestablished. This does not prove that ECC has no other learning/evaluation controls.

U05-A's instinct path has not acquired a quality gate merely because these modules exist. The concrete finding is separation, not repository-wide disconnection. S116 adds six-file directory metadata; dashboard/index and broader test/source families are still outside this unit. P1 and prior residuals remain open.

Next U06-A opens a different major family: which repository/configuration mutations are actually prevented or admitted by ECC's security/governance hooks, and what does an external scan add? Start the already-discovered config-protection and gateguard-fact-force paths plus their actual caller/profile logic; select one bounded effect boundary before expanding. No upstream fix/report, real install or adopted SOUL/Foundation design follows.

The user asked to reserve the joint comprehensive evaluation for research completion. Intermediate research/method checks continue; a material purpose/scope/authority decision returns to the user sooner. This unit supplies cases for that later discussion rather than conducting it now.
