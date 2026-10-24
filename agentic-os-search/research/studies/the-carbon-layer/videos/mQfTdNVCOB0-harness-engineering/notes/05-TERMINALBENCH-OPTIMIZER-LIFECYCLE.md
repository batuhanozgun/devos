# U01-B / Note05 — TerminalBench proposal, execution and selection

**Date:** 2026-09-12. **Standing:** bounded source characterization, with explicitly identified local diagnostics in Note06. Not a live Harbor run or a reconstruction of the paper's historical experiments. Exact T/H source IDs resolve in [SOURCES](../evidence/2026-09-12-u01b-terminalbench/SOURCES.md). The selected output agent is a different object: [Note07](07-SELECTED-HARNESS-ENVIRONMENT-BOOTSTRAP.md).

## 1. Native object and execution ownership

The TerminalBench reference searches Python agent implementations that subclass Harbor's `Terminus2`. Its outer loop is not the solver: it proposes a candidate, admits its interface, optionally smoke-tests it, dispatches benchmark work, reads reward/usage artifacts and updates an empirical frontier. The solver operates through a terminal session in a selected remote environment; the task verifier's reward is later read from trial results. The optimizer, solver and verifier are different roles, not automatically protected authority domains. [T01–T07]

The shipped full search declares 89 tasks and two attempts per task. Two baselines are registered: a native-tool KIRA variant and an alias of vanilla Terminus2. The model, expected task count and task-set label are module constants. A named run scopes `jobs/` and `logs/`; candidate code and prompt templates remain shared. Named output directories therefore do not freeze the implementation or its dependency closure. [T03, T07–T08]

The direct reference dependencies are pinned, including Harbor 0.18.0 and LiteLLM 1.84.10. This is stronger reproducibility information than an unspecified environment, but not proof of the installed wheel, remote backend, model service, task content or historical run. The shell uses the dataset label `terminal-bench@2.0`; the separate task-commit identity mentioned in SETUP is not passed as an explicit immutable dataset ref in that shell command. [T01–T04]

## 2. Experience and prior enter the proposer

`render_task_prompt` names the model, full benchmark and current summary/frontier/report/pending-receipt locations. `propose_claude` calls the same wrapper blob previously read in U01-A, but with the TerminalBench skill. It removes one API-key environment variable for that invocation and restores it afterward; that operation is not a demonstrated isolation boundary. [T03, T06, T11]

The skill prescribes one candidate and one mechanism per iteration. It uses one Agent subagent for analysis and another for implementation, unlike classification's anti-delegation prior. It asks the analyst to inspect successful as well as failed trajectories, predict both success and efficiency changes, and preserve a falsifiable hypothesis. Those are substantive search priors, not neutral plumbing. The wrapper still exposes broad tool categories; source-level prohibitions on changing existing code or benchmarking do not mechanically enforce path-scoped authority. [T06, T11]

The skill permits arbitrary Python changes inside a new candidate and a new prompt template while prohibiting edits to existing agent files, the optimizer and wrapper. It prohibits task-name hints and recommends general mechanisms. This bounds intended authorship, but neither subclass admission nor a clean filename establishes that a generated program obeys those constraints. The field `expected_efficiency` is proposed in the receipt; the summary writer does not preserve that field as a checked prediction/outcome pair. [T03, T06]

## 3. Receipt, exact-class admission and smoke are distinct

Before proposing, the outer loop removes the old `pending_eval.json`. It requires wrapper success and a newly present receipt, parses candidates, and normalizes any supplied class suffix to `AgentHarness`. It does not establish a frozen content identity from the candidate name or require a complete receipt schema. [T03]

`validate_agent_class` checks an exact module/class reference, requires a class object and requires a Terminus2 subclass. This is materially stronger than classification's wildcard-import marker. Module import still executes code, and the check does not test state correctness, effect authority, model identity or the candidate's success criterion. The shell runs this validator again before invoking Harbor. [T03–T05]

An apparent flag discrepancy was checked rather than declared a defect: the shell uses `--agent MODULE:CLASS`; Harbor's pinned 0.18.0 CLI explicitly accepts custom import paths there and marks `--agent-import-path` deprecated. The older skill's flag spelling does not make this shell invalid. Only that selected CLI boundary was recovered, not the full installed CLI-to-runtime chain. [T04, H01–H02]

The optional smoke test runs one named task with one trial. Its acceptance checks successful launcher exit, a top-level result file and zero reported errors, not positive task reward. Thus smoke acceptance is an execution-health signal, not evidence that the task was solved. `--skip-smoke` bypasses that stage. The first-party suite tests exact-class rejection, timeout wiring and a mocked one-episode loop; this study read the suite but did not run it. [T03, T05]

## 4. The effective invocation crosses another configuration surface

`harbor_run` supplies import path, task-set label, attempts, concurrency, job name and output directory to `scripts/run_eval.sh`. It passes the declared model and timeout in the child environment. The shell adds temperature 0.7, resolves Runloop or Modal, loads a local `.env`, validates the class and launches Harbor. [T03–T04]

The shell's local `.env` can override the inherited model value. Local B07 verified this command-construction behavior using the exact shell blob and a fake `uv`: no real class validation, Harbor job or provider request occurred. The declared proposer configuration and the effective launch arguments therefore require separate binding; a command-line constant alone is not evidence of the executed model. [CHECKS B07]

Timeout layers are also distinct. The Python benchmark wrapper manages a wall-clock timeout and asks the shell to defer its own wrapper. Direct shell usage uses `timeout` or `gtimeout` when available. These paths manage local subprocesses; complete descendant and remote-job cleanup was not established. The helper's timeout result must be followed into every caller. [T03–T05]

## 5. Rewards are reconstructed from trial directories

`parse_job_results` ignores the job's top-level score snapshot and inspects directories named like `task__trial`. An existing trial directory with a missing result file, invalid JSON or absent reward contributes zero. This avoids silently dropping several ordinary failed-result cases. `compute_pass_rates` uses a flat count of positive-reward trials rather than averaging task percentages. [T03]

However, the parser is driven by discovered directories, not an independently enumerated expected task/attempt manifest. `expected_trials` warns about counts for tasks already found; it does not create missing attempts or reject incomplete coverage. A wholly absent task is invisible to that loop. Positive numeric reward is interpreted as success. Unsupported but valid JSON structures can raise instead of becoming zero. Note06 and the B01–B03 diagnostics preserve these distinctions. [T03; CHECKS]

`parse_trial_metrics` separately extracts token/cost/episode fields from readable per-trial results. Unlike reward parsing, it skips missing or invalid files. The success denominator and usage-observation population may consequently differ. Reported cost is not automatically total attempted-search spend. [T03]

## 6. Frontier, summary and reuse

The frontier contains per-task best agent names/rates and one global best name/rate. It is a best-so-far archive, not a synthesized agent that can automatically combine all per-task winners. It uses strict improvements, retains the old winner on ties, and carries neither an immutable candidate hash nor a versioned evaluation population in its best entry. [T03]

Baseline reuse examines model and attempt fields when a config file exists; missing config is explicitly trusted. Other code, prompt, environment and data identities are not checked there. Whether the selected config lookup matches every real Harbor-written schema remains unverified. The later baseline-seeding path also operates when baseline execution was skipped. [T03]

A candidate benchmark failure is represented as empty per-task results and zero. Candidate-stage parsing respects `harbor_run`'s failure/timeout flag. Baseline seeding and optional final evaluation instead parse an existing directory regardless of the earlier flag. Those are different caller contracts; the helper's local refusal is not end-to-end exclusion. This mismatch was traced in source, not executed as a timeout experiment. [T03]

The summary records name, import path, hypothesis, changes, rounded scores, timing and selected rollout metrics. It reads the frontier after it was updated. B04 demonstrated that a 0.60→0.75 improvement can be recorded with zero delta, because the persisted comparison uses the new best. This does not make the absolute score false; it changes the learning history's meaning. [T03; CHECKS B04]

## 7. Final evaluation is replication on the same benchmark, not held-out testing

With `--full-eval`, the code takes the global winner, searches the summary for its first matching import path and dispatches five attempts on the same full dataset. It does not evaluate the union of all per-task winners. A baseline winner without an appropriate summary import path is not handled like an ordinary generated candidate. [T03]

There is no classification-style finalized-run lock here. That is not automatically a failure of a promised held-out split: this is benchmark-specific discovery and a higher-trial winner pass, not an unseen-task estimate. It still needs fresh code/config identity, outcome qualification and an honest statement of adaptive benchmark exposure. [T03; U00 paper audit]

`fresh_start` clears selected run history and generated code in the shared agents directory; it does not define an immutable historical artifact archive. A filename, an import path, an archived best score and the actually loaded bytes are separate identities. Actual historical naming discipline and exact search-run artifacts remain open. [T03]

## 8. Bounded model and continuation

The native model is a **file-mediated, delegated candidate search with exact-class admission, optional execution-health smoke, remote-task dispatch, per-trial reward reconstruction and best-so-far selection**. Its useful mechanisms and its caller/coverage/configuration limits must travel together.

U01-B does not close all Harbor internals, historical experiment reconstruction, statistical generalization, hostile containment, provider costs or live task quality. The selected artifact's operating loop is examined separately in Note07. The next broader unit returns to the video's operational responsibilities, using these concrete cases without forcing them into a ten-layer architecture.
