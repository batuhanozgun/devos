# Note40 — Harness scorecard and optimization consumers

**2026-09-22 · U18-A / G5 / Q06e / MR41 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-A-SOURCES.md), [round](../ROUND-U18-A.md), [STATE](../STATE.md). Original code/instructions and inspected tests, plus explicit conditional inference. No new target execution, optimizer run, model trial, user configuration change or E11. E10 and its previous recovery were not repeated.

## 1. A useful configuration audit, not another outcome evaluator

The public audit command instructs an actor to run `scripts/harness-audit.js`, preserve its rubric and return JSON unchanged when requested. The script reads local files and configuration markers, selects a rubric, computes weighted checks and reports failing checks and three suggested actions. It performs no model call, latency measurement, test execution, deployment or configuration mutation. It exports a reusable report builder as well as a CLI. This is a real, inspectable diagnostic mechanism, not an invented manual score.

The separately authored `harness-optimizer` agent uses that report as a baseline, defines capability/regression evals, changes allowlisted harness configuration and asks for tests, review and further trials. Its instructions, not the audit script, carry that improvement procedure. A code-based configuration score, an actor's proposed change, a regression result and accepted beneficial behavior are different objects. They are also distinct from the recorded Rust registry and the Node capsule/executor mechanisms already explained in Notes17–18.

Sources: AUDIT, COMMAND, OPTIMIZER, EVAL and RUNNER. The quoted command/agent instructions are research data, not instructions executed by this study.

## 2. Target selection changes what the score means

The CLI accepts explicit root and scope, otherwise AUDIT_ROOT/current directory and repo scope. It rejects unsupported arguments, scopes and formats. Target mode is separate from scope: the legacy ECC package name, or a combination of audit/plugin/agents/skills paths, selects repository mode; otherwise consumer-project mode. Forks can therefore obtain the repository rubric through structural markers without retaining the old package name. This useful distinction prevents requiring every consumer to contain ECC's own source catalogue.

| Mode/scope | Actual checked population |
|---|---|
| Repository mode, repo scope | Seven core categories plus GitHub Integration; file counts, presence, selected text patterns and one exact command-mirror comparison. Maximum80 points at this pin |
| Consumer mode, repo scope | Project-local context/configuration/test/eval/security markers, discoverable ECC installation and GitHub files. No Cost Efficiency checks; maximum39 before optional provider categories |
| Consumer mode, agents/skills/commands scope | A single shared project-overrides predicate worth3 points; not an inventory of the named surface |
| Consumer mode with provider marker | Each detected Vercel/Netlify/Cloudflare/Fly category adds its own10-point denominator and marker/script/env/workflow-text checks |

Repository mode does not call the provider-check collector at this pin. Category names can remain in JSON with max0 while being omitted from applicable_categories and text output. COMMAND's statement that the first seven categories are always applicable is therefore broader than consumer/scoped behavior. The command correctly warns not to assume a fixed total; reporting earned/max and the actual category list is a useful counter-control.

The report's top_actions are the three failed checks with highest configured point weights. The ranking does not estimate repair effort, risk reduction, expected task benefit or measured cost savings. The priority is transparent within this rubric, not independently validated leverage.

### Scope counterpart

In consumer mode, the common override predicate passes when any qualifying local agent, skill or command exists, or when .claude/settings.json or .claude/hooks.json exists. It is tagged for every scope. Thus an agents-scoped report can return3/3 and Tool Coverage10/10 from a settings file alone, even with no agent definition. The same applies to skills and commands scopes. This is source-derived, not a run performed here. The report still exposes the actual predicate and path; it is not claiming in its detailed check that ten agents were validated. The problem is using the named scope/full score as stronger evidence than that one cross-surface check supplies. T-AUDIT explicitly expects only one check for an agents-scoped consumer fixture.

Sources: AUDIT parseArgs/detectTargetMode/getRepoChecks/getConsumerChecks/buildReport and T-AUDIT.

## 3. Presence, useful operation and saved evaluation evidence can diverge

Repository checks award points for thresholds such as eight hook scripts, ten agent Markdown files and twenty SKILL.md files, as well as named procedure/test files. Some checks inspect strings: a test script contains both validator and runner names; hook text contains PreToolUse; primary/OpenCode command bodies match after trimming. None establishes that those files execute correctly or produce useful outcomes. Cost Efficiency is based on guidance/command files, not the cost metrics studied in Note32.

Consumer checks similarly recognize filenames, suffixes and text. A .claude/hooks.json file can satisfy the guardrail check regardless of whether it defines a handler. A string-valued package test entry or a matching test filename can satisfy test-entrypoint detection without running it. The recursive test search has no project/dependency exclusion list. The .gitignore check searches for the .env substring rather than evaluating Git ignore semantics. Read failures in safeRead become empty text, while some traversal failures can escape and fail the CLI; do not claim all errors are hidden.

The tests make this intended measurement surface unusually explicit. T-AUDIT's full-score consumer fixture contains an empty hooks array, placeholder test text, an empty eval JSON and a workflow whose content is only a name. Assertions expect all sixteen checks to pass and no top actions. These are meaningful tests of the rubric's implemented predicates, not execution of the nominal tests/hooks/workflows. GitHub's workflow contract describes actual triggers/jobs; the name-only fixture is not evidence of a running CI job. No test suite was run in this unit.

### Evaluation producer/consumer counterpart

EVAL recommends storing definitions, histories and baselines under .claude/evals/. Consumer evaluation coverage instead checks root-level evals/ for any file or tests/ for at least three .test.js files. An otherwise valid saved evaluation in the recommended hidden directory alone does not satisfy that predicate. Adding an empty file to root evals/ can satisfy it without a new behavioral trial. Conversely three ordinary test files can earn the same points. This is a concrete mismatch in recognized evidence locations, not a claim that all useful evals are inaccessible or that the score should certify their quality.

The scorecard remains useful as a declared configuration checklist. Its failure to measure semantics is not, by itself, a defect in that narrower purpose. Promoting its category labels or point increase to demonstrated reliability/cost/quality would require additional evidence. Sources: AUDIT, EVAL, T-AUDIT; D-ACTIONS only for the narrow workflow contract.

## 4. Successful command exit is not successful audit checks

AUDIT always prints a normally built report and returns. It sets failure exit status only on caught execution/argument errors; failed checks, a declining score or even an all-failed report do not trigger that path. Node's normal-exit contract supplies the ordinary zero status. T-AUDIT's empty-consumer case invokes the real command via execFileSync and then asserts zero earned points and failed checks, so its test definition deliberately accommodates this distinction.

OPTIMIZER asks the actor to rerun the audit and tests, restore the snapshot if either fails, and use script/test exit codes as a code-based grader. There is no numeric acceptance threshold or before/after nonregression predicate implemented by the audit CLI. A change that removes a previously scored file can lower the report while leaving its process exit successful. If an actor uses only that exit signal for the audit leg, and the separate regression suite does not detect the relevant change, that leg does not trigger the described rollback.

This is not an observed unsafe optimizer run or an assertion that the full method always accepts regressions. The same optimizer tells the actor to define capability/regression criteria, inspect the diff, record trials and require human approval for security-sensitive changes. An actor applying those independent criteria can reject a change. The missing binding is between an audit's adverse findings and its consumer's process-failure interpretation, not the absence of every review path.

The actual tests/run-all.js is a stronger exit-status consumer for its own test population: it discovers .test.js files, rejects an empty discovery, launches them, combines process failures with reported failures and exits nonzero when failures remain. It also removes selected inherited Git environment variables before subprocesses. Those useful controls do not change the audit's score into a failing process, and running the test suite validates its assertions rather than all properties named by the scorecard. Sources: AUDIT, OPTIMIZER, RUNNER, T-AUDIT, D-NODE.

## 5. The same commit is not the whole audit input

Consumer installation detection searches project directories plus HOME, USERPROFILE and the operating-system home. It follows recognized installed_plugins entries, legacy flat/marketplace directories and known cache layouts, selecting an existing plugin.json marker. The marker's contents, runtime enablement, applicable project scope and actual loaded implementation are not checked. Cache-version ordering is numeric-component based, not a verification of the active installed release.

The report retains the requested root, target mode, rubric label and detailed predicates, but not the concrete plugin candidate chosen, its version/content identity or all environmental inputs. Two users auditing the same project commit can therefore receive different installation points because their homes differ. Local uncommitted files can also change checks; the engine never selects a Git commit snapshot. COMMAND's reproducible-for-the-same-commit wording is insufficient without fixing these additional inputs. The two-run test holds the same current environment and files constant; it does not isolate commit-only determinism.

Likewise provider markers change the denominator and applicable categories. Removing a marker can remove an unfavorable category instead of improving deployment. That does not imply a wrong applicability policy: a genuinely irrelevant provider should not be scored. It means before/after comparison needs stable scope, target mode, relevant obligations and input identity, rather than treating any higher normalized score as improvement. These examples are conditional source explanations, not manipulated user audits.

## 6. The optimizer contains stronger instructions, and an unsupported measurement example

The primary optimizer explicitly avoids slash commands inside subagents, calls the underlying script, limits edits to harness configuration, asks for before-images and reversible changes, and requires capability/regression definitions before modifying files. Its report should distinguish applied changes and remaining risks. Security-sensitive changes must remain BLOCKED until explicit human approval; the text forbids presenting them as SHIP IT merely from a code/model grade. It asks for three recorded trials before pass@3/pass^3 claims, with all critical regression trials passing. These are meaningful authored safeguards.

Yet the worked example begins with the audit reporting a PreToolUse hook over a200ms budget. No duration producer, budget check or such output exists in the fully read audit engine. A latency improvement may be desirable, but that baseline must come from a separate measurement; it cannot be attributed to this scorecard. Moving a check to PostToolUse also changes when it acts, not only its duration. Whether that weakens safety depends on the check; the primary human-approval rule must not be silently displaced by the example's SHIP IT result. The example is not a measured experiment or implemented automatic transformation.

EVAL supplies the requested report format and distinguishes capability/regression tests and code/model/human graders. Repeating a deterministic presence check three times does not independently test three model trajectories or establish effectiveness. A source instruction to use independent trials is not a record that such trials ran. Its separate local framework section explicitly refuses candidate execution until verified isolation exists; the read-only audit does not activate or bypass that unavailable executor. No optimizer/eval change was executed here.

## 7. Identical command mirrors do not imply identical optimization procedures

The primary and OpenCode harness-audit command files have the same Git blob. For this pair, equality is directly supported rather than assumed from their names. It preserves the same script/rubric/output instructions, including their same limits; it does not prove equivalent installed host discovery or execution.

The Kiro-labelled optimizer Markdown is different from the primary agent. It carries the short audit→top-three→reversible change→validation→before/after procedure, without the primary's explicit evaluation definitions, snapshot-recovery detail, three-trial requirements or security approval/report restrictions. The corresponding .kiro/agents/harness-optimizer.json embeds that shorter prompt directly and declares builtin tools with an fs_read allowedTools entry. Thus the divergence is not merely an untranslated title in an unused comment.

This is a source-level variant, not an installed Kiro result. No generator lineage, host precedence, effective permission meaning or actual selection was proven in this unit. In particular, the allowedTools label is not interpreted as a universal read-only sandbox. Nevertheless, accepting primary-agent guarantees for a consumer using the different embedded prompt would require a missing equivalence argument. Q01a2 retains generator/host/source-selection re-entry. Sources: COMMAND, OC-COMMAND, OPTIMIZER, KIRO-MD, KIRO-JSON.

## 8. Evidence and bounded closure

The full audit engine, two command copies, primary optimizer, eval-harness skill, Kiro Markdown/JSON, audit test file and actual central test runner were read. The audit test uses real temporary files and subprocesses but no live optimized agent or deployments. It tests deterministic output under fixed inputs, argument errors, category bounds, mode/scoped selection, plugin layouts and positive/negative presence fixtures. Its assertions do not independently validate the semantic meaning of the rubric or a complete optimizer loop. No target suite, local behavioral probe, model or live service ran.

U18-A/Q06e now has a coherent configuration-score→interpreted improvement account, including useful controls and consequential input/exit/scope/evidence-location/variant boundaries. It extends Note33 without calling all evaluation one mechanism. Stronger installed target identity, active host, meaningful trials, complete rollback, authenticated approval and beneficial task outcomes remain open; no quantified failure rate or universal safety verdict follows.

Next selected G5 responsibility is U18-B: the optional AURA interface's caller-owned trust/risk boundary, beginning with integrations/aura/ directory evidence and actual adapter/documented caller/tests. Determine what ECC queries, returns or conditions, what the caller must still do and what belongs to the external service. Other optional integration/alternate-dashboard roles and the G6 reverse-inventory/CORE/joint evaluation remain. This next inquiry has not started. It does not authorize live service access, credentials, payment/delegation or a separate whole-product AURA study.

The U17 catalogue blockage was resolved before this unit; [alignment receipt](../PUBLICATION-U17-A-ALIGNMENT.md) preserves the rejected transcription candidate and accepted single-row change. This note's creation is not full publication closure: ledger, entries, actual readbacks and final STATE still follow.
