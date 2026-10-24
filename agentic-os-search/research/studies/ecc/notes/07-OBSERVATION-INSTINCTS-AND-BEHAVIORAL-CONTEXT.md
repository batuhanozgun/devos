# U05-A — Observation, instincts and behavioral context

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Questions:** Q06, related Q02/Q07/Q08/Q10. **Evidence:** source observation, test-source inspection and qualified inference. **No new execution or E04.** [Exact coverage](../evidence/U05-A-SOURCES.md); [round and MR07](../ROUND-U05-A.md).

## 1. The mechanism is not the Memory Vault's trust ladder

U04-A's vault keeps records unreviewed and places governed acceptance outside storage. Continuous Learning v2 is a different path: selected tool observations can be analyzed by a model into procedural instincts, and an ordinary SessionStart hook can place selected instinct actions into additional context. Global promotion and skill generation are not prerequisites to this direct instinct-injection path.

The source-grounded composition is:

`registered/profile-gated tool hooks → observe runner → filtered project observations → optional observer analysis → personal instinct files → SessionStart selection/ranking → compact action text in additionalContext`.

Alongside it, the Python CLI supports import, project-to-global promotion, and generation of skill/command/agent artifacts. These operations do not all mean the same kind of promotion. The study found concrete code connecting stored procedural records to model-facing context, but did not run a hook, observer, model or host. Actual invocation, model uptake, behavioral compliance and benefit remain different claims.

## 2. Observation is an engineered, incomplete evidence view

S99/S106 register the pre-observe and post-dispatch paths. S102 delegates to the actual S93 shell script and deliberately permits several failure/skip paths without blocking the primary tool. S93 excludes disabled/minimal/cooperatively skipped, subagent and named automated-session paths before project metadata creation. Missing Python/shell capability and timeout can also prevent recording. These controls prevent self-observation loops and unnecessary overhead; they are incompatible with reading S89's hook-reliability language as literal coverage of all interaction evidence.

The collector records pre-tool input and post-tool output, truncated to 5,000 characters each and subjected to a best-effort secret-pattern scrub. A parse-error fallback preserves only a smaller scrubbed fragment. Session/project labels remain; the intermediate parsed tool_use_id and cwd are not included in the final ordinary observation object. Consequently downstream analysis does not receive the full original event or an explicit per-call correlation identifier from this serialization.

The ordinary observation object also does not carry a direct user-follow-up message. An undo/error-resolution sequence can suggest a correction, but it is not identical to observing what the user requested. Other writers may exist; no repository-wide absence of correction evidence is inferred. The important constraint is that the actual analyzer reads this selected representation, not an assumed complete transcript. Observation counts are not automatically independent successful examples or a calibrated denominator for confidence.

S92 defaults observer.enabled to false. Recording and optional lazy analysis are distinct: the normal append occurs before the observer-enable check. S96 checks the effective config before starting the observer. Thus captured observations need not imply analysis, and installed learning files need not imply any learned result. The analyzer invokes the Claude CLI and grants prompt-free Read/Write permission through allowedTools; local persistence does not establish offline analysis. Current official CLI semantics distinguish allowedTools from an exclusive tools list (W11). No actual provider configuration, traffic or confidentiality guarantee was tested.

## 3. A stronger completion gate, with a narrower meaning than validated learning

S95 samples the last configured number of lines (default 500) once the minimum count is met, then constructs its own inline prompt. S94 observer.md is useful documentation, but it is not the file loaded as that prompt. The inline instructions require three or more occurrences, narrow triggers, textual evidence, and direct creation/update of an instinct in the configured personal directory. Frequency bands suggest confidence values; the model supplies the pattern interpretation and writes the file. This path does not first stage every result in pending or require an interactive human acceptance.

The archive decision is materially stronger than U03-B's worker-completed decision. It requires both process exit zero and exactly one literal analysis_complete JSON record as the final non-empty stdout line of this invocation. Output is read through descriptors bound to an unlinked temporary inode rather than trusting an independently replaceable result pathname. Old log text, stderr, duplicates and a marker followed by failure text do not satisfy the predicate.

S104's full test source contains those negative cases, a successful baseline and watchdog cleanup checks. It runs a copied observer loop with a deterministic provider and guardian stub when executed; we did not run it. Its so-called semantic-failure fixtures model a failure by omission/misplacement of the marker. They do not independently establish whether a model that prints the correct marker actually inferred a valid rule or completed every required write. The completion assertion is still produced by the same analyzer.

A distinct source-derived counter-path concerns the set being acknowledged: S95 samples a tail, but on success moves the whole then-current live observations file to a processed archive. With more than 500 lines, some older entries were outside the sample; new entries can also arrive after sampling. They may be archived with the batch even though they were not part of the sampled analysis. Bytes can remain available in the archive, so this is not an assertion of total data destruction. It is a mismatch between analyzed scope and processed-file scope; the inspected next cycle reads the live file, not an automatic archive backlog. The three-line archive test does not challenge this larger/concurrent case.

Conversely, process/marker failure retains the live observations but does not transactionally undo any instinct writes already made. The retained-input retry and the generated-output lifecycle therefore need separate reasoning. These batch/concurrency/partial-write paths are unexecuted residuals, not observed production incidents or proven historical root causes.

## 4. Confidence, global promotion and evolution have different predicates

An instinct has a trigger, an action, a numeric confidence field and free-text evidence. S94 describes confirmation/contradiction/weekly-decay adjustments. The executed-path source S95 instead builds frequency-oriented instructions; S97 stores, loads, compares and uses confidence metadata. These inspected paths do not independently remeasure task benefit or implement the entire documented decay narrative. Pending-record TTL pruning is a different operation from decaying the confidence of active personal instincts.

S97 distinguishes three operations:

| Operation | Actual source predicate/effect | Not established by that predicate |
|---|---|---|
| Explicit-ID promote | Valid current-project ID, no existing global ID, confirmation unless force; writes global record and removes matching source blocks | Repeated cross-project evidence or a minimum confidence requirement |
| Auto-selected promote | Same ID in at least two registered projects, average confidence at least 0.8, no existing global ID; confirmation unless force | Equal action meanings, independent evidence origins, or a global-friendly domain check |
| Evolve / generate | Groups trigger keywords; optional generation writes templates under evolved directories | Successful execution, acceptance, installation or improved outcomes |

The automatic promotion scan includes both personal and inherited instincts, deduplicating the same ID within each project. Two imports from one source can therefore supply two project instances without proving two independent learning histories. The implementation groups by ID rather than comparing the action/trigger bodies and does not apply the domain allowlist described by S94. It selects the highest-confidence instance's body, writes the average confidence and project count, then removes matching blocks from project sources. Different meanings under one ID are a source-derived counterexample to interpreting promotion as semantic agreement. An explicit operator override can be intentional; this is not a blanket verdict that flexibility is a defect.

Evolve requires at least three loaded instincts overall. Skill candidates are trigger clusters with at least two members; the displayed count of confidence >=0.8 instincts is not a skill-generation gate. Workflow-command candidates require confidence >=0.7; agent candidates require at least three members and average >=0.75. Similarity uses deterministic keyword overlap, not a semantic or causal evaluation. Generated artifacts are assembled from metadata/actions/source IDs; no trial task or correctness oracle occurs in these generator predicates. Thus a low-confidence pair can still be a skill candidate when the overall input set qualifies, while the command/agent predicates are different.

## 5. Scope is enforced partly by location, not merely by the scope field

The launcher assigns INSTINCTS_DIR to the current project's personal directory. The inline observer prompt also allows a universal pattern to be labelled scope: global, but does not change that write destination. Both the management loader and SessionStart attach a scope label from the directory. Changing frontmatter to global is therefore not, by itself, global materialization. The explicit promotion command moves the record into the actual global namespace.

Project identification also has its own producers: Python detection normalizes origin and has a main-worktree fallback, while S103 uses an existing registry-root match or its own root/remote hash. The shell detection helper was discovered but not read in this unit. Their complete migration/no-remote/worktree equivalence is not established. Do not import Memory Vault root selection or assume that all features' use of the word project denotes the same identity boundary.

## 6. There is a real path into context, but it compresses the conditions of use

S99 → S101 routes SessionStart to S98 through the hook runner. With context enabled, S98 reads current-project and global personal/inherited directories, selects by confidence (default 0.7), resolves same-ID precedence among surviving entries, ranks and caps the result (default six). Pending is not among these input directories. No human-review certificate or supporting-observation recheck is part of this selection predicate.

S100's relevance boost uses location and detected software stack: project scope adds 0.25, a token-level stack match adds 0.2. It can rank a relevant lower-confidence instinct above an unrelated higher-confidence one. This is a concrete applicability heuristic, not an arbitrary confidence-only sort. But startup lacks the new task, so it is not a check of the actual current user request or the full trigger condition. Framework detection and every host variant were not audited here.

The rendered instinct line contains scope, the stored confidence as a percentage, and the first non-empty action line. It does not carry the instinct ID, trigger, evidence block, source path or the rest of a multiline action. That is a load-bearing representation boundary, not merely cosmetic shortening. For example, a synthetic rule whose trigger is 'when creating test fixtures' and action is 'Use fixed sample data' can lose its explicit conditional scope in this view. This example illustrates the formatter, not an observed model error.

The output field is hookSpecificOutput.additionalContext. Official current host documentation supports interpreting this as a context-delivery interface (W10), not proof that this particular pinned installation was invoked or the model used it correctly. The entire combined context also has a character cap. Instincts are placed before the guarded historical session summary and learned-skill summaries; not every discovered candidate is delivered in full.

This is the significant difference from the Memory Vault: an observer-produced personal instinct can be selected on a later SessionStart without first running evolve, promoting to global, or changing a vault trust field. The study establishes the source path into a behavioral context surface, not a reliable closed-loop learning outcome.

## 7. Generated files and learned-skill discovery are not the same location

S97 generates under project/global homunculus evolved directories. S98's separate learned-skill summary uses getLearnedSkillsDir. S105/S107 resolve that to the configured agent-data home plus skills/learned, with Claude/Cursor defaults and explicit override logic. This reader does not traverse the default evolved output as part of the inspected path. An explicit copy, installation, alternate host discovery or other bridge may connect them; no global absence is inferred.

Direct instinct injection, generated artifacts, learned-skill summaries and native skill discovery must therefore be tracked separately. Showing a generated SKILL.md or a name/description is not evidence of installation, actual selection or benefit. The next research unit must inspect ECC's separate skill-observation/health/amendment/evaluation path rather than claim no quality controls exist anywhere from this one generation route.

## 8. Disposition, project relevance and next inquiry

Q06a is bounded-answered for capture → optional analysis → instinct management → model-facing context. Q06b retains sample/archive coverage, partial effects, evidence/meaning agreement and trigger/identity fidelity. Q06c asks how skill-run outcomes, amendment/evaluation and accepted changes are connected, including whether they qualify the records examined here.

The user's Information/Foundation association is retained as a reuse cue: the concrete issue is when information becomes a reason to act, and which provenance, condition and uncertainty survive that transition. This unit does not map ECC into Foundation taxonomy, change Foundation, or adopt a SOUL/Development OS mechanism. Candidate lessons include preserving applicability through context compression and distinguishing frequency, scope generality, source-bound completion, accepted behavior and measured usefulness.

Next U05-B begins the pinned four-file skill-improvement directory confirmed in S108, the actual skill-run-tracker caller and retained session-inspect CLI. Trace outcome production → health/amendment → evaluation evidence → material change/use, keeping the Python instinct mechanism distinct unless a real bridge is found. P1, prior installation/work/memory residuals and wider security/runtime families remain open. No full-study or independently validated method completion is claimed.
