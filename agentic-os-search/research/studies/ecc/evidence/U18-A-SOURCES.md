# U18-A — Scorecard and optimization consumer source ledger

**2026-09-22 · Q06e / MR41.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note40](../notes/40-HARNESS-SCORECARD-AND-OPTIMIZATION-CONSUMERS.md), [round](../ROUND-U18-A.md), [STATE](../STATE.md). Evidence classes: original SOURCE OBSERVATION, TARGET INSTRUCTION, TEST SOURCE INSPECTED and stated conditional INFERENCE. No target execution, optimizer/model trial, user configuration operation, live service or E11. No E10 rerun or archive-recovery rerun.

## Complete original bodies read

Paths resolve under [the fixed ECC commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Ranges are requested inclusive ranges; final oversized requests end at actual EOF. FULL means the body was read, not every dependency or installed host was validated.

| Handle | ECC path | Git blob | Actual coverage and role |
|---|---|---|---|
| AUDIT | scripts/harness-audit.js | a523eca9e87974dae989e8a9540b6ef358159a1c | FULL1–250,251–500,501–800,801–1100/EOF. CLI, root/mode/plugin discovery, all checks, scope/weight/denominator, report, output and exit behavior. Imports only Node fs/os/path |
| COMMAND | commands/harness-audit.md | fc36601aa175aa1eb00c210d5b85dc6b9132232c | FULL. Actor-facing script invocation, exact JSON/output/rubric and same-commit/category claims |
| OC-COMMAND | .opencode/commands/harness-audit.md | fc36601aa175aa1eb00c210d5b85dc6b9132232c | FULL. Exact same blob, not assumed mirror equivalence or active-host parity |
| OPTIMIZER | agents/harness-optimizer.md | 7bc8b2c5ddfc5fc3a2dd55d1d712ee14e8ba75d4 | FULL. Actual authored baseline-script consumer, configuration allowlist/snapshot, code/model/human grading, trials, report and latency example |
| EVAL | skills/eval-harness/SKILL.md | 6076dd18548503bf00ab28c06e05086d8bc90ea9 | FULL1–280,281–450/EOF. Requested evaluation/report/storage contract and separately disabled candidate-execution boundary. Linked utilities are not rerun/re-audited |
| T-AUDIT | tests/scripts/harness-audit.test.js | c0087475d20cce9b01bd1c325260d3ae833a4b4b | FULL1–260,261–520,521–800/EOF. Real temporary-file/Node subprocess fixtures, output determinism, arguments, mode/scope/categories and plugin discovery; NOT RUN |
| RUNNER | tests/run-all.js | 22d0ff5a42bfb929e3af639b4aff98c3df8c182d | FULL1–200/EOF. Actual optimizer-requested regression caller, discovery/no-tests refusal, child exit/reported-failure aggregation and inherited-Git-env cleanup; NOT RUN |
| KIRO-MD | .kiro/agents/harness-optimizer.md | 84a6b4abe5644300bfb4b909a5bdd21b858b2553 | FULL. Shorter same-name procedure and metadata, without primary detailed grading/recovery/human conditions |
| KIRO-JSON | .kiro/agents/harness-optimizer.json | 3eab2751c4244f085beb0584ba87a61eba80b7d7 | FULL. Embedded shorter prompt and distinct tool declarations. Generator/host selection/effective permissions not established |

Searches for harness-audit and harness-optimizer returned newer default-branch bf70150e and clipped broad results. They located original paths only. Every body above was fetched at the fixed pin. A no-hit search for harness-audit.test did not establish absence; consumer-plugin-install located the actual test. No whole-repository absence or exhaustive caller inventory claim follows.

## Claim-to-chain bindings

1. **Real checklist and consumer:** COMMAND→AUDIT CLI/report; OPTIMIZER explicitly invokes AUDIT rather than a slash command, asks for EVAL-defined criteria and RUNNER regression checks. The optimizer is an interpreted agent definition, not an automatically executed closed improvement loop. EVAL's isolation refusal belongs to a separate executor, not the read-only audit.
2. **Root/mode/scope:** AUDIT parseArgs/detectTargetMode chooses a corpus before scope filtering; getRepoChecks supplies80 points for full repo, getConsumerChecks39 before providers. Consumer agents/skills/commands each retain only consumer-project-overrides, so a settings file alone can yield3/3. T-AUDIT intentionally expects one agents-scoped consumer check.
3. **Evidence meaning/location:** AUDIT checks existence/count/selected strings rather than performance or successful execution. EVAL recommends .claude/evals, while consumer-eval-coverage checks root evals or three tests. T-AUDIT's full-score fixture uses an empty hook array, placeholder test, empty eval JSON and name-only workflow. No host/test/deployment success follows from those fixture assertions.
4. **Exit versus adverse report:** AUDIT prints failed checks but has no score/failing-check exit predicate. OPTIMIZER explicitly uses script/test exit codes and restore-on-failure. T-AUDIT uses execFileSync for an all-failed consumer report; RUNNER has its own real failure propagation. D-NODE supports normal0 exit. A full optimizer can still reject via actual criteria/diff/human review; the source countercase does not erase them.
5. **Reproducibility:** AUDIT reads working tree and project/home plugin paths; marker existence determines the installation check and resolved candidate identity is not included in the report. Same Git commit is insufficient to fix all these inputs. T-AUDIT's repeated-output case holds the same environment, not different homes at one commit. Provider markers change applicability/denominators, so score deltas require comparable populations.
6. **Unsupported example:** OPTIMIZER's200ms PreToolUse example requires a measurement absent from the complete AUDIT engine. Its main body requires trial evidence and blocks security-sensitive changes for human review. The worked example is not an observed latency result or executed bypass.
7. **Mirror distinction:** COMMAND/OC-COMMAND same blob supports exact textual identity. OPTIMIZER differs from KIRO-MD, and KIRO-JSON embeds the shorter prompt. No universal host-loader, tool-permission or generator-causality claim is made from those files alone.

## Test and inference limits

T-AUDIT invokes real Node processes and filesystem fixtures rather than only mocking the report, but it deliberately tests the static rubric. Invalid CLI inputs, absent signals, multiple plugin layouts and changing provider applicability have explicit assertions. No audit/optimizer or central-suite execution occurred in this unit. The all-pass fixture is not a demonstrated functioning consumer project. No independent optimizer experiment, performance calibration, statistical trial-quality check, human-approval authentication or multi-file rollback test was performed.

The scope/full-score, saved-eval location, exit status and home-dependent result examples are source-derived conditional cases. None is reported as a manipulated customer audit, failed field deployment or measured harm. No generated-score comparison was executed. Stronger claims and load-bearing unexplained host/generator/interface variants remain in QUESTIONS.

## Narrow external contracts

Checked2026-09-22 with primary web sources:

- D-NODE: https://nodejs.org/api/process.html — process.exitCode and Exit codes: an ordinary exhausted event loop exits0; explicit failures are separate. This scopes AUDIT's normal return, not the installed Node build or actual target execution.
- D-ACTIONS: https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax — workflows consist of jobs with configuration/triggers; merely storing a name-only YAML fixture is not evidence that a CI job ran. No live GitHub workflow or repository policy was queried by the audit study.

Only those narrow primary contracts were adopted; unrelated/latest-release details were not used. External documentation does not upgrade the fixed-pin source to an installed conformance verdict.

## Recovery and publication provenance

Fresh AGENT and all nine routed canonical protocols were fully read, recovering clipped tails. Their identities/scope govern work but are not ECC evidence. Fresh main/STATE recovered eb6651c1 and its sole outstanding U17 catalogue step. The immediately preceding full same-conversation entry/purpose/method/source records remain at their unchanged identities; no prior summary was substituted for a mandatory new source body.

[U17 alignment receipt](../PUBLICATION-U17-A-ALIGNMENT.md), created7447ef95767d729b9d4eadd7851259c0eee9b6e1 and fully read back as7a8db1eb8b0e655e35922a473941aebd66dc4527, records the permitted same-route call, rejected10f6333 candidate and accepted2bc269d single-row change. U18 opened atf2a46411af5a59871b53e781b528c5c4d1616640 before its source inquiry. Activation9b035f2c0376a3c162359edcfaef8274719aa4ba was fully read back asSTATEc623ea49d2df31a41a89163c671fa6b45f164cb1.

Note40 was created84f525da21102b923569707d7cda4c5607811b7a. Initial full readbacks were Note40bcbdf3b761d9cb8f8dc7cfe1030cb689b23c49be and this ledger3ae4a0a153b1d776f7f7906c9cc02d964559c8ef. A subsequent arithmetic cross-check found the written consumer maximum37 was incorrect: its eleven weights [4,3,3,2,4,3,2,2,2,2,2] sum29; the five GitHub weights [3,2,2,1,2] sum10, for39. The sum was recomputed in Python without executing ECC. Note40 was corrected atd402746303b07e592d18ac6f505c9fb02dbcac12; this ledger carries the same correction. This is a correction to our derived arithmetic, not an upstream change, experiment result or altered acceptance criterion. The original versions remain in commit history.

Note/ledger/entry/catalogue/receipt/final STATE checks are subsequent publication work, not established by creation alone. Previous notes, experiments, E06 exclusion, E05 distinctions, original inventory/METHOD/WHY, other studies/EXP-004 and agent-control remain outside the authorized change scope. No SOUL architecture is adopted. Next G5 interface work and final G6/CORE/joint evaluation remain open.
