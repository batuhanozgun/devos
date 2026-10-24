# U01-A / Note03 — Classification candidate, evaluator and selection lifecycle

**Date:** 2026-09-12. **Standing:** bounded source-code characterization; not an executed experiment or security assessment. **Target:** the published reference implementation at `stanford-iris-lab/meta-harness@0cbc31e97c9e6d24232d1dc754827c02e1ec415c`, not the historical paper run or the separate TerminalBench output agent.

Exact file identities, reading depth and source IDs S01–S19 are in [U01-A SOURCES](../evidence/2026-09-12-u01a-classification/SOURCES.md). The critical qualifications are developed in [Note04](04-CLASSIFICATION-EVIDENCE-BOUNDARIES.md). No source instruction or SKILL in this corpus is an instruction to the SOUL researcher.

## 1. Native object and boundaries

The classification example searches for Python implementations of a `MemorySystem`. A candidate decides how to construct a prediction and how to update/serialize its memory. It is not merely a retrieved prompt string. The outer process proposes candidates; a benchmark process dispatches evaluation workers; each worker imports a candidate, supplies a model callable, loads data and scores predictions. Finalization selects a set of candidates for test evaluation. This is a source-level producer–consumer account, not evidence of tamper-resistant separation. [S02, S04–S07]

`ONBOARDING.md` asks for the task unit, fixed model and tool boundary, mutable interface, evaluation split, baselines and budget before an implementation is specified. It also warns that an unstable evaluation loop or a need primarily to change the model can make this approach a poor fit. This is useful scope discipline; it does not itself enforce the resulting constraints. [S01]

## 2. Entry and run identity

`meta_harness.run_evolve` reads `config.yaml`, checks that the requested model occurs in the configuration and creates a named log directory. `pending_eval.json`, `frontier_val.json`, `evolution_summary.jsonl`, `results/` and `finalized.json` are scoped to that run. Candidate Python files remain in the shared `agents/` directory. Named runs therefore isolate result locations, not candidate code or every dependency. [S04]

The shipped configuration uses three datasets, one configured solver, one seed, offline training, one epoch and temperature zero. Its dataset-size overrides differ by dataset. These are observations of this release, not reconstructed settings for every paper experiment. In particular, the paper's online-learning account must not be silently equated with this default. [S10; paper §4.1]

The outer `--model` selects the model used for frontier/score interpretation, but ordinary calls to `run_benchmark` do not pass an execution-model filter. `benchmark.main` builds evaluation jobs using its configured `MODELS` list; its `--model` option is used for frontier filtering. The default has one model, so this distinction becomes material when the configuration is expanded. [S04–S05]

## 3. History enters the proposer

`render_task_prompt` identifies the current run's summary, frontier, report directory and pending-evaluation destination. `propose_claude` invokes `claude_wrapper.run` with a loaded proposer skill, an Opus model label, a working directory and tools including Read, Grep, Write, Edit, Bash and Agent. The wrapper injects the skill into the system prompt, builds the CLI command and records the returned events, text, tool calls and usage. This establishes how history locations and the prior enter the proposer; it does not establish which evidence a real proposer inspected or understood. [S04, S08–S09]

The skill prescribes three candidates, falsifiable hypotheses, mechanism-level changes rather than mere parameter variants, local prototyping and short reports. It forbids benchmarking and delegation in prose. The caller nevertheless supplies broad tool types, including Agent and Bash. These are different layers: an intended division of work, the tool surface made available, and the host's actual enforcement. [S04, S08–S09]

The prior itself influences the search distribution. Mandatory novelty/prototyping and a fixed candidate count cannot be treated as causally neutral when interpreting the value of richer history. That is an experimental question for U03/U05, not evidence that the prior is ineffective.

## 4. Proposal receipt is weaker than interface acceptance

Before each proposal, the outer loop deletes an old `pending_eval.json`. A successful wrapper exit plus a newly present file admits the next parsing step. The outer loop reads the `candidates` array and uses each `name`. It does not validate a complete proposal schema or enforce the requested candidate count. The manifest's `iteration`, `file` and `base_system` fields are not used as immutable binding checks in the inspected admission path. [S04]

`validate_candidates` launches a short Python import and accepts a successful exit containing its marker. This executes the imported module and tests importability, not whether `predict`, memory round-trip, model restrictions or evaluation isolation are correct. Later, `inner_loop.load_memory_system` scans module classes for a `MemorySystem` subclass and instantiates one. These are separate admission stages. The latter does not require the class to have been defined in that module rather than imported into it. [S04, S07]

A proposal can therefore be import-valid without being a usable or properly attributed candidate. No malformed candidate was executed by this study. The precise runtime boundary remains a probe candidate, not a claimed exploit.

## 5. Benchmark dispatch and failure handling

`benchmark.discover_all_memory_systems` enumerates Python files under `agents/`, with exclusions for the package initializer and the shared few-shot implementation. A selected name is resolved against that discovery. `build_val_runs` creates dataset × candidate × configured-model × seed jobs, unless a corresponding result is considered reusable. The command supplies an absolute package path and project location before invoking `text_classification.inner_loop`. [S05]

The asynchronous launcher bounds concurrency, records commands/output and retries a failed worker. A failed set of actual jobs causes a nonzero benchmark exit. These are genuine source-level reliability mechanisms. The outer evolution loop, however, logs an individual benchmark failure and still proceeds to frontier construction and score collection. The completeness rules at that later boundary are consequently load-bearing. [S04–S05]

Timeout paths kill the directly managed subprocess; complete descendant-process cleanup or hostile containment was not established. No timeout, retry or live provider operation was executed here.

## 6. Data, memory and prediction

The worker loads the dataset interface through `data/__init__.py` and `data/api.py`. With a three-way split, train, validation and test examples are loaded even when only validation output is requested. The default MCE loaders read local split files, add task input formatting and return targets. The API shuffles within splits and rejects requests exceeding available sizes. Raw dataset rows and duplicate/leakage properties were not audited. [S07, S12, S14, S19]

The abstract memory interface requires prediction, batch learning and state serialization/restoration. The worker and candidate share one Python process; the candidate receives the model callable, and the evaluator holds both predictions and targets. A separate function or module is not a protected execution domain. [S06–S07]

There are two different training regimes:

- **Online:** predictions for a batch precede feedback; labels and correctness are then supplied to `learn_from_batch`.
- **Offline:** labeled examples are supplied during training; optional validation checks select an epoch checkpoint. The shipped configuration selects this regime.

`evaluate_memory` does not call the learning method. That is an operational no-learning path, not a proof that arbitrary candidate `predict` code is state-immutable or thread-safe. [S07, S10]

The few-shot baseline stores examples and later selects/orders their representations using a stable input-derived seed. The effective example-text limit in the read implementation is 30,000 characters, despite stale comments in the two baseline files referring to other limits/units. This is a small but concrete reason to follow implementation rather than inherit comments as exact configuration. [S16–S17]

## 7. Model call and two different caches

`MemorySystem.call_llm` records information about the last prompt in thread-local storage, then calls the supplied LLM. `LLM` can truncate a long prompt, adds its model-specific system prompt and calls `ProviderLLM`, which checks a response cache before calling the provider library. The cache key hashes the normalized model, endpoint, prompt, system prompt, arguments and cache version. This is an actual content-sensitive cache; it must not be confused with the weaker benchmark-result reuse rule discussed in Note04. [S06, S18]

This reading stops at the provider-library boundary. Installed library versions, wire requests, actual remote models, authentication behavior and live cache contents were not recovered. An environment variable or constructor setting is not a verified provider execution.

## 8. Scoring, storage and frontier

Dataset-specific evaluator functions are selected by `get_evaluator`. The default paths normalize answers and compare labels or sets; some return auxiliary overlap/F1 metrics. This is a concrete oracle, not proof that its answer normalization or metric is adequate for every domain. We did not audit the scientific/domain validity of all evaluators. [S15]

After training, the worker can save `memory.json`. Validation/test result files contain aggregate accuracy/counts, model/dataset/memory/seed/mode, timestamp, runtime and usage/context fields. `evaluate_memory` also constructs detailed predictions and prompt text in memory, but the main result writer does not persist those detailed arrays. Training logs and proposer event logs are different evidence carriers. [S07, S09]

`load_results` requires all configured seeds for a result group and aggregates their counts or accuracy. This is useful seed-completeness handling. `print_frontier` then computes per-dataset best candidates and an aggregate Pareto frontier over accuracy and context-character length. It can retain multiple candidates, not just one winner. Dataset completeness and the denominator used by each consumer need separate treatment. [S05]

`update_evolution_summary` persists candidate names, hypotheses, axes, optional component tags and aggregate outcomes. It does not persist every proposal-manifest field or an immutable candidate/dependency identity. Its delta is computed against a frontier read at summary-write time, after the frontier update, whereas console comparison uses the previously loaded frontier. Historical interpretation must therefore identify the comparator. [S04]

## 9. Explicit finalization and its residual boundary

Finalization is requested separately using a named run. `finalize_run` selects the union of configured baselines, validation-Pareto candidates and per-dataset best candidates. It writes an in-progress marker, runs their test evaluations, builds/displays test results and checks that the required result groups exist. Only after successful completion is the marker changed to complete. [S04–S05]

A completed marker blocks further evolution under that run name. An in-progress marker does not. This is not just an inference from a missing guard: `test_incomplete_finalization_allows_evolution` explicitly expects that behavior. Its corrupt-output fixture does not cover a run that has already produced some usable test results. [S11]

Thus the source implements finalization/recovery bookkeeping, but test-exposure validity requires a finer distinction than complete versus incomplete. Nothing here establishes that historical proposer sessions actually consumed held-out results. The published README itself calls this operational separation rather than access control. [S02]

## 10. Native model and next unit

The bounded native model is a **cooperative, file-mediated candidate search with named run outputs, staged import/evaluation, mutable memory policies, multi-objective selection and explicit test finalization**. Its positive mechanisms and its qualification gaps must travel together.

U01-A characterizes this classification path. It does not characterize the TerminalBench optimizer or selected output artifact. Those use a different candidate interface and execution substrate; the shared wrapper has the same blob identity, but shared code does not make caller authority or evaluation behavior equivalent. U01-B begins at the exact TerminalBench routes in STATE/PLAN.
