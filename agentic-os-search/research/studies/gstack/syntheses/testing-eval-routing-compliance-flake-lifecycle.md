# gstack — Testing / Eval / Routing / Compliance / Flake Lifecycle

## Scope

This synthesis reconstructs how the pinned gstack revision decides **what verification should run, whether it actually ran, what its oracle means, how results are persisted/compared, and how false-green/flake/cost/routing failures are controlled**.

Pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

The protected question is:

> what does a green test/eval result actually prove in gstack, and which mechanisms prevent selection, execution, oracle, aggregation or retry artifacts from being mistaken for stronger verification than occurred?

This is a gstack-native subsystem synthesis. It does not mutate the SOUL Foundation.

---

## 1. Executive reconstruction

The verification system is not one test suite. It is a pipeline:

```text
source / behavior change
        ↓
test registration + coverage metadata
        ↓
diff/touchfile selection
        ↓
gate vs periodic tier routing
        ↓
paid/free partition
        ↓
planner manifest + shard allocation
        ↓
actual runtime execution
        ↓
test-specific oracle
        ↓
strict execution/result classification
        ↓
partial + finalized eval artifacts
        ↓
flake / cost / efficiency / baseline comparison
        ↓
CI/report/release consequence
```

The strongest system-level conclusion is:

> **verification standing is conjunctive.** A result is trustworthy only to the degree that selection, execution, oracle and aggregation all preserve their qualifications.

A useful negative equation is:

```text
test exists
≠ test selected
≠ test executed
≠ intended runtime exercised
≠ intended oracle valid
≠ result finalized
≠ result independently verified
```

Much of gstack's eval infrastructure is the accumulated result of closing concrete violations of exactly these distinctions.

---

## 2. Four broad evidence families

The repository uses materially different verification families.

### 2.1 Free/static tests

These include:

- deterministic TypeScript/Bun tests;
- generated-file invariants;
- config/schema checks;
- shell-script behavior;
- resolver/generation pins;
- audit-compliance scans;
- test-routing/coverage integrity checks.

They are generally cheap, reproducible and strong for structural contracts.

They do **not** by themselves prove an LLM follows the workflow in a real session.

### 2.2 Real-agent E2Es

`runSkillTest()` launches a separate `claude -p` process and captures real tool calls, transcript, turns, timing and result state.

These are materially stronger for behavioral workflow claims.

However:

```text
real agent
≠ real external integration
```

A real Claude process can still be instructed to simulate GitHub merge, browser Canary or provider deployment. Production research found exactly this in `test/skill-e2e-deploy.test.ts`.

### 2.3 External-host E2Es

Codex has a dedicated real-CLI harness and E2E family. Gemini has its own surface.

These test host/runtime portability more directly, but runtime availability becomes part of the oracle. A missing binary can make every test self-skip.

### 2.4 LLM-as-judge evals

These evaluate semantic quality that deterministic assertions cannot easily score:

- documentation clarity/completeness/actionability;
- planted-bug detection;
- mode/posture preservation;
- recommendation substance;
- generated-vs-baseline quality.

Their oracle is probabilistic/model-dependent and must be interpreted differently from structural or ground-truth deterministic tests.

---

## 3. Coverage matrix guarantees a route, not behavioral validation

`test/skill-coverage-matrix.ts` requires every skill to have a non-empty gate coverage array.

This is valuable: no skill can be completely absent from the declared verification topology.

But the requirement can be satisfied by:

`test/skill-coverage-floor.test.ts`

which checks structural properties such as:

- frontmatter exists;
- generated skill has a name;
- H1/body exist;
- template placeholders do not leak.

Therefore:

```text
skill has gate coverage
≠ skill behavior has been exercised
```

The matrix should be read as a **coverage-routing registry**, not a calibrated behavioral-confidence score.

### 3.1 Canary proves the attribution problem

The production synthesis found:

- `test/skill-e2e-deploy.test.ts` contains a real-agent `canary-workflow` scenario;
- `E2E_TOUCHFILES` registers `canary-workflow` and `E2E_TIERS` marks it `gate`;
- but the skill coverage matrix represents `canary` itself only with the generic structural floor.

Thus:

```text
behavior scenario exists and is routed
but
skill coverage view does not attribute it
```

This is a cross-surface representation inconsistency, not necessarily a missing execution.

---

## 4. Paid-test ownership has a single canonical set

`test/helpers/paid-test-set.ts` defines the globs for tests that consume API/external-service/e2e resources.

The reason is explicitly historical: if package scripts, free-suite exclusion and paid runner maintain separate lists, a new file can:

- burn money inside the free lane;
- self-skip in free;
- never enter the paid census;
- appear covered while no intended lane owns it.

The central set is an important architecture pattern:

> **test ownership itself is canonical data.**

Comments document prior orphan classes caused by too-narrow exact globs for Codex and LLM-eval files.

---

## 5. Diff selection is deliberately biased toward extra work, not missing work

The touchfile selection machinery is more defensive than a simple changed-file table.

It considers:

- committed diff;
- staged/unstaged changes;
- untracked files;
- global touchfiles;
- per-test dependency patterns;
- changes to the touchfile map itself.

### 5.1 Broken git state does not look like “clean diff”

Git failures throw rather than returning an empty set.

This prevents:

```text
cannot determine changed files
→ silently select zero tests
```

### 5.2 Changing the selector map triggers map-diff logic

When touchfile mappings change, the system attempts to compare old and new maps from git history.

If the previous map cannot be resolved safely, the failure direction is:

```text
RUN ALL
```

not under-selection.

### 5.3 Parent shard optimizer also fails toward inclusion

If a paid test file cannot be mapped confidently to selected names, the parent keeps the shard rather than dropping it.

This is a recurring verification design principle:

> uncertainty in selection should spend extra verification work rather than manufacture confidence from missing work.

---

## 6. Tier metadata and actual self-gating are separately verified

The repository learned that declaring a test `periodic` in metadata does not matter if the file still self-gates on `gate`.

`test/e2e-tier-alignment.test.ts` detects this “inert demotion” class.

It also enforces that skill E2E files register themselves in touchfile dependency lists so editing the test file itself re-selects the test.

Historical comment:

> 129 of roughly 177 E2E keys once failed this self-registration property.

This is an important systemic lesson:

```text
route metadata
≠ actual child execution predicate
```

Both surfaces need consistency checks.

### 6.1 Known-unregistered is a ratchet, not amnesty

A small explicit set of standalone files lacks normal map keys. The invariant requires entries to remain live/unregistered and instructs maintainers not to extend the set casually.

This converts known exceptions into bounded debt with a shrink-only contract.

---

## 7. Gate and periodic are different operational contracts

`gate` is the PR-blocking/fast-enough verification tier.

`periodic` runs deeper or more expensive scenarios weekly/on demand.

The periodic lane aims to run all periodic tests to prevent invisible rot, but this is not literally universal.

`PERIODIC_CI_EXCLUDE` currently contains explicit exclusions, each requiring:

- a real paid file;
- a substantive reason;
- a tracking pointer / re-entry condition.

Current examples include tests documented as never-green and an iOS hardware-dependent suite.

Therefore:

```text
periodic run-all
=
all periodic tests minus declared tracked exclusions
```

The exclusions are surfaced and removal reactivates the test.

This is healthy work-system bookkeeping, but it remains a real verification hole until the excluded scenarios re-enter.

---

## 8. Paid CI uses planner → executor → fail-closed report

The paid lane was re-platformed away from a manually enumerated CI matrix.

Current architecture:

```text
ONE planner
→ computes selection once
→ emits manifest with planned/skipped entries + slice ownership
        ↓
K executor slices
→ run exactly their manifest partition
→ persist result artifacts
        ↓
report
→ reconcile every expected slice/shard against manifest
→ fail if anything is missing/wrong-tier/failed/unreported
```

This closes several classes simultaneously.

### 8.1 Selector divergence

Old per-slice selection could resolve git state differently.

One manifest means every executor consumes one selection decision.

### 8.2 Missing slice artifact cannot look green

The report uses `always()` and explicitly fails when a planned executor did not upload a result.

### 8.3 Planned shard nobody reported is failure

Even if a slice artifact exists, the reconciler checks every planned file/shard.

### 8.4 CI pipe exit once silently failed open

The workflow contains a concrete historical failure:

```text
reconcile | tee report
```

was effectively using `tee`'s success as the step result under the GitHub shell configuration.

The current workflow captures `PIPESTATUS[0]` and separately fails the job if reconciliation returned non-zero.

This is a particularly useful example:

> a verification engine can be correct while the CI transport of its verdict is wrong.

---

## 9. Bun process exit is not trusted as the sole oracle

`scripts/test-strict-output.ts` exists because Bun can emit failure lines while the child exits successfully.

The wrapper classifies:

- explicit failed-test lines;
- unhandled errors between tests;
- terminal file counts;
- test counts;
- pass counts;
- skip counts.

A zero child exit is not enough if output shows a failure or fewer test files ran than planned.

Thus:

```text
process exit 0
≠ test suite passed
```

This mirrors gstack's merge-state discipline: local mechanism completion is not automatically authoritative effect state.

---

## 10. “Ran N tests” is not proof that tests executed meaningful work

Bun's terminal total includes skipped tests.

The paid runner therefore tracks pass/skip counts separately.

### 10.1 Hollow-shard guard

Under `EVALS_ALL`:

```text
selected shard
+ exit 0
+ zero executed tests
→ passed-empty
→ run FAILS
```

In a selective run, zero execution can be legitimate because child-side name/tier filtering may intentionally skip everything. The runner keeps it green but emits a warning.

This context-sensitive polarity is deliberate.

### 10.2 All-skipped pass is labeled “verified nothing”

A file whose every test self-skips can still have a Bun success status. The paid summary explicitly marks this state rather than allowing it to read as ordinary coverage.

This is the class behind the known Codex periodic false-green: without the Codex runtime, Codex tests can all self-skip and the lane color can be misleading unless execution census is interpreted.

Protected conclusion:

> **execution count is part of verification evidence.**

---

## 11. External runtime availability is a first-class validity condition

Claude E2Es need Claude runtime/API availability.

Codex E2Es need Codex CLI.

Gemini E2Es need Gemini runtime credentials/tools.

A missing runtime is not automatically a code regression, but neither is an all-skip run positive behavioral evidence.

The repository increasingly distinguishes:

```text
unavailable oracle/runtime
from
negative test result
```

but not every CI surface has fully closed this distinction; Codex periodic CI remains a known example at the pinned revision.

---

## 12. The session runner distinguishes startup failure from work failure

`runSkillTest()` launches an independent Claude CLI process in a hermeticized environment.

It records:

- transcript;
- tool calls;
- exit reason;
- turns;
- model;
- first-response latency;
- max inter-turn latency;
- duration;
- browse errors.

### 12.1 Two-phase timeout

A startup-phase deadline distinguishes:

```text
API/model never began responding
```

from:

```text
agent began work but exceeded work budget
```

CI has a larger minimum startup grace because queue latency is known to be materially worse.

This reduces false reds from classifying rate-limit/queue availability as workflow failure.

### 12.2 Process-group termination

Timeout kills the process group, not only the top-level Claude process.

This was added because tool subprocesses could survive as orphans, continue holding pipes/API resources and extend a supposedly timed-out run dramatically.

Again, eval correctness includes liveness and cleanup, not just assertions.

---

## 13. Paid shards isolate shared runtime state

Each paid shard receives separate:

- temp directory;
- Chromium profile;
- eval artifact directory by shard.

This matters because concurrent browser/test processes previously contaminated shared state or killed each other's browser resources.

The same isolation pattern appears in the free runner.

Protected boundary:

> this is test-runner state isolation, not proof that all application workflows have the same isolation semantics.

---

## 14. Eval artifacts preserve provenance beyond pass/fail

`EvalTestEntry` can carry:

- pass/fail;
- cost;
- duration;
- attempt number;
- transcript/prompt/output;
- turns/tokens;
- browse errors;
- exit reason;
- timeout location;
- model;
- first-response / inter-turn timing;
- judge scores/reasoning;
- detection rate / false positives / evidence quality;
- harvest/diff data.

Final run metadata includes:

- schema version;
- git branch/SHA;
- package version;
- timestamp;
- hostname;
- Claude CLI version;
- tier;
- shard;
- wall clock;
- flaky retry ledger.

This is a strong evidence-design choice: later comparisons can reason about environment and failure class rather than only the Boolean verdict.

---

## 15. Partial and finalized evals are intentionally distinct — but not all consumers preserve that distinction

`EvalCollector` writes an atomic `_partial: true` accumulator after each test so a killed long run does not erase all evidence.

Finalization writes a separate completed run.

Core comparison helpers explicitly exclude partial accumulators from baselines because otherwise the current run can compare against itself and falsely report no regressions.

`eval-flake-rank` also filters to finalized result files.

### 15.1 `eval-list` currently leaks partials into “run history”

`test/eval-cli-family.test.ts` explicitly documents current behavior:

> in-progress `_partial` accumulators appear in the listing.

The test itself says excluding them would be an improvement, not a regression.

### 15.2 `eval-summary` also aggregates partial files as runs

`eval-summary.ts` uses `listEvalJsonFiles()` and loads every JSON result without applying `isPartialEval()` / `isFinalizedEvalResultFile()`.

Therefore an in-progress accumulator can contaminate:

- total run count;
- total/average cost;
- per-test efficiency;
- flaky status;
- date range;
- branch statistics.

This is a concrete source/view-fidelity defect:

```text
upstream artifact knows “partial”
→ some consumers preserve qualification
→ eval-list/summary flatten it into ordinary run representation
```

It is analogous to the earlier GBrain stale-label loss.

---

## 16. Baseline comparisons avoid several false-stability classes

`findPreviousRun()` excludes partial runs and prefers:

1. same shard + same branch;
2. same shard;
3. same branch;
4. fallback only when necessary.

Comparison tracks how many tests actually matched by name.

If zero tests matched, commentary explicitly says:

```text
NO BASELINE
Nothing was compared
This run says nothing about regressions
```

That prevents a new/different test set from reading as “stable.”

### 16.1 Budget regression is intentionally history-dependent

Efficiency regression checks compare latest finalized same-branch history and skip when:

- no current run;
- current eval belongs to another branch;
- no same-branch prior exists.

First-run grace is therefore **absence of comparative evidence**, not proof of efficiency.

---

## 17. Retry success is permanently recorded as flake evidence

Bun `--retry` can hide a fail→pass sequence in normal text output.

`EvalCollector.addTest()` detects repeated recording of the same test name and stores a 1-based `attempt` field.

Finalized runs expose `flaky_retries`.

`eval-flake-rank` then ranks historical tests by:

1. retried passes;
2. failure rate.

The policy is explicit:

```text
flaky pass
→ does not block by itself
→ but never disappears into ordinary green history
```

This is superior to retry-as-erasure.

---

## 18. Flake management is historical, not a one-run label

`eval-flake-rank` scans finalized results over a bounded recent window and groups attempts by test/run.

It also merges a free-suite flake ledger.

Malformed JSONL lines in the free ledger are skipped per-line rather than discarding the entire series.

A future required-check promotion is meant to depend on weeks of clean flake history rather than informal confidence.

This makes reliability a time-series standing.

---

## 19. LLM judges are calibrated oracles, not objective graders

The judge infrastructure is consciously model-specific.

The default general judge is Sonnet. Repository comments document a controlled A/B where Haiku scored the same documentation rubric substantially more harshly than Sonnet.

Rather than pretending scores are model-invariant, the system kept Sonnet because existing thresholds were calibrated to Sonnet baselines.

Therefore:

```text
judge score 4/5
≠ absolute semantic truth
```

It means approximately:

```text
this artifact met a rubric under this judge/model/calibration regime
```

### 19.1 Judge model is recorded/configurable

Model resolution is centralized and environment-overridable per role (`capture`, `warmup`, `distill`, `judge`).

This improves reproducibility and makes model migration explicit.

### 19.2 Deterministic checks are preferred when possible

Recommendation eval first parses deterministically whether:

- a Recommendation line exists;
- it commits to one option;
- it contains a `because` clause.

Only reason substance is handed to an LLM judge.

This is a good oracle-design pattern: do not spend probabilistic judgment on facts a parser can establish.

---

## 20. Planted-bug outcome evals strengthen the oracle but remain model-mediated

`outcomeJudge()` receives explicit ground truth bug IDs and asks the judge to map an agent report onto:

- detected bugs;
- missed bugs;
- false positives;
- evidence quality.

Pass logic centralizes thresholds for detection / false positives / evidence quality.

This is stronger than asking an LLM “was this QA good?” with no oracle.

However, semantic equivalence between report text and ground-truth bug still goes through an LLM judge.

Thus:

```text
known ground truth
+ model-mediated matching
```

is stronger than pure taste scoring but not identical to deterministic execution proof.

---

## 21. Same-family judge/generator common cause limits independence

Many gstack behaviors are generated by Claude and judged by Anthropic Claude models.

Even when generator and judge use different sessions/models, they can share:

- training-family priors;
- provider/system behavior;
- rubric interpretation tendencies.

Therefore LLM-as-judge is valuable **oracle diversity**, but not automatically independent external verification.

This is especially important for style/posture/documentation rubrics where the judge has no external ground truth.

---

## 22. Routing itself is behaviorally tested

`test/skill-routing-e2e.test.ts` launches a real Claude process and installs reduced skill frontmatter fixtures.

A key hardening is deliberate:

- the fixture no longer contains a per-skill answer-key routing table;
- the agent must choose based on actual skill descriptions;
- the test stops after the first Skill call because downstream execution is irrelevant to routing.

This closes a subtle invalid-oracle class: an E2E that supposedly tested skill discovery once included the correct routing answer in context, so description regressions could not make it fail.

This is a strong example of **test validity requiring removal of leaked oracle answers**.

---

## 23. Static audit/compliance is useful but narrower than runtime security validation

`test/audit-compliance.test.ts` checks structural/security hygiene such as:

- no realistic credentials in skill examples;
- telemetry gates;
- checksum-verified install language;
- untrusted-content wrapping;
- extension sender validation;
- data-flow documentation.

These are legitimate contract pins.

They do not establish:

- exploitation resistance;
- runtime hostile-input behavior across all paths;
- independent penetration testing.

Thus “audit compliance passes” is structural security evidence, not full security standing.

---

## 24. Slop scanning is advisory, not a hard gate

`slop-diff.ts` compares new scan findings against the merge base and avoids line-number-only noise.

But if `slop-scan` is missing or returns invalid JSON, the command reports the problem and exits successfully.

`package.json` also treats scanner absence as a message rather than a required failure.

Therefore:

```text
slop scan clean
```

and

```text
slop scan unavailable
```

must not be flattened into the same positive evidence merely because both can have exit code 0.

---

## 25. Eval cost/efficiency is separately controlled from correctness

The budget-regression test watches tool-call and turn growth relative to prior finalized same-branch runs.

It also applies high hard-dollar ceilings designed to catch runaway infrastructure bugs rather than normal scope growth.

Overrides require an explicit reason and are audit-logged.

This is a useful separation:

```text
correctness standing
≠ efficiency standing
≠ spend-safety standing
```

A test can be correct but pathologically expensive, or cheap but semantically wrong.

---

## 26. Cancellation and cleanup are part of eval correctness

Both shard and session runners contain significant process-lifecycle logic because earlier systems leaked subprocesses after timeout or user cancellation.

The paid runner:

- spawns detached process groups;
- propagates SIGINT/SIGTERM;
- stops launching new shards after cancellation;
- uses external wall-clock timers;
- SIGKILLs groups when necessary;
- cleans temp/browser state;
- preserves per-shard full logs.

The source comments record a historical stalled-run class lasting roughly 15.7 hours.

Verification infrastructure therefore treats:

```text
test timed out
→ all its side effects/processes are actually terminated
```

as a correctness property, not housekeeping.

---

## 27. Verification failure classes

### V1 — coverage registry false confidence

Skill appears covered because generic structural floor exists.

**Residual risk:** user/maintainer reads matrix as behavioral confidence.

### V2 — changed test does not select itself

Test logic changes but diff mapper skips it.

**Mitigation:** self-registration/tier-alignment invariant.

### V3 — tier metadata is inert

Registry says periodic; file self-gates gate.

**Mitigation:** cross-surface tier-alignment test.

### V4 — selector cannot resolve changed state

Broken git/map state yields under-selection.

**Mitigation:** throw/run-all/keep-shard failure polarity.

### V5 — process exits 0 despite test failure output

**Mitigation:** strict Bun output classifier.

### V6 — selected files exist but no meaningful test executed

**Mitigation:** pass/skip census, hollow-shard guard, all-skipped “verified nothing” label.

### V7 — external runtime absent

Codex/Gemini tests self-skip.

**Residual risk:** green job color can overstate behavioral evidence; known Codex periodic issue.

### V8 — executor/slice disappears

No artifact reaches report.

**Mitigation:** planner manifest + fail-closed reconciliation.

### V9 — CI transport swallows verifier failure

`tee` pipeline masks reconcile exit.

**Mitigation:** `PIPESTATUS[0]` pin + explicit fail step.

### V10 — real-agent E2E simulates external system

Agent follows prompt, but GitHub/provider/browser effect is not real.

**Residual risk:** filename `E2E` interpreted as live integration proof.

### V11 — retry hides flake

Fail→pass looks green.

**Mitigation:** in-process attempt recording + flake history.

### V12 — current partial run becomes baseline

Comparison says no regression against itself.

**Mitigation:** baseline helpers filter partials.

### V13 — partial run displayed/aggregated as completed run

**Current residual gap:** `eval-list` and `eval-summary` preserve this defect at the pinned revision.

### V14 — no comparable tests but summary says stable

**Mitigation:** zero matched baseline explicitly means “nothing compared.”

### V15 — judge model changes calibration

Score threshold meaning shifts.

**Mitigation:** centralized/pinned judge role; controlled A/B history; residual model-dependence remains.

### V16 — model judge agrees due to common cause

**Residual limit:** not independent verification.

### V17 — known-red periodic tests disappear from attention

**Mitigation:** explicit exclusion registry with tracking and shrink/re-entry policy.

### V18 — routing test leaks expected answer in fixture

**Mitigation:** current routing E2E removes per-skill answer key; frontmatter carries routing load.

### V19 — scanner unavailable but command green

**Residual behavior:** slop scan is advisory; green exit is not positive scan evidence.

### V20 — test exists but coverage attribution disagrees

**Current example:** Canary touchfile/tier + E2E scenario vs generic-floor skill coverage matrix.

---

## 28. What gstack does particularly well

### 28.1 It treats false-green bugs as architecture problems

Many controls were not invented abstractly; comments preserve the exact failure class that forced the invariant.

### 28.2 It separates selection from execution

Manifest planning, route maps, child gates and execution census are distinct.

### 28.3 It records degraded/unknown states increasingly explicitly

Examples:

- timeout_startup;
- all-skipped “verified nothing”;
- no baseline;
- partial run;
- flaky retry;
- skipped-by-diff;
- known periodic exclusion.

### 28.4 It stores enough provenance to debug infrastructure, not just product behavior

CLI version, model, branch/SHA, timings, transcripts, attempts and shard identity are first-class evidence.

### 28.5 It uses fail-closed/fail-expensive selection where feasible

When selector certainty fails, the preferred consequence is often “run more.”

---

## 29. Where the system remains weaker

### 29.1 Coverage strength is not normalized

One skill can have a real behavioral E2E, another only generic structural floor, yet both satisfy the matrix's gate-nonempty invariant.

A richer declared evidence class would make the matrix safer to interpret.

### 29.2 Cross-surface metadata still drifts

Canary demonstrates that touchfile/tier routing and skill coverage attribution can disagree.

### 29.3 Partial/final qualification is not universally preserved

`eval-list` and `eval-summary` flatten partial accumulators.

### 29.4 External-runtime proof remains uneven

Codex has stronger harness support than most other hosts, and periodic runtime availability remains a known defect.

### 29.5 LLM judge calibration is necessarily local

Thresholds are tied to judge model/rubric history. They are not universal quality numbers.

### 29.6 “E2E” is topology-ambiguous

Some tests exercise a real agent but simulated external effects. The evidence class should state what boundary is actually real.

### 29.7 Known periodic exclusions are controlled debt, still debt

Two current exclusions are explicitly never-green workflows.

---

## 30. Cross-subsystem implications

### 30.1 Verification standing is itself qualified information

A statement such as:

```text
tests green
```

is underspecified without:

```text
which route/tier?
selected why?
what executed?
what skipped?
which runtime/model?
which oracle?
which attempt?
final or partial?
what baseline?
```

### 30.2 Test infrastructure is a work system

It has:

- admission/selection;
- scheduling/sharding;
- execution;
- failure/timeout recovery;
- evidence persistence;
- recurring debt/exclusion management;
- historical trend/flake feedback.

It should not be treated merely as passive instrumentation.

### 30.3 Oracle validity can dominate test sophistication

A beautifully orchestrated E2E proves little if the fixture leaks the answer or the external effect is simulated while the claim assumes it was live.

### 30.4 Source→view fidelity recurs again

Partial/final state exists upstream but is lost in some CLI views. This is the same class as hidden GBrain stale state and historical report/current-state confusion.

### 30.5 “Green” is a derived view, not an authoritative primitive

The repository's own history demonstrates multiple ways a green process/job/test could mean:

- failure line hidden behind exit 0;
- every test skipped;
- slice missing;
- verifier failure swallowed by shell pipeline;
- retry hid first failure;
- simulated external effect;
- scanner unavailable;
- structural floor only.

The correct object is therefore the **qualified execution/evidence record**, not the UI color alone.

---

## 31. Evidence / verification limits

This synthesis does **not** claim:

- that all gate tests are behaviorally weak — many are strong;
- that LLM judges are invalid — only that their calibration/common-cause limits matter;
- that simulated E2Es are useless — they test real agent workflow behavior, just not the external integration boundary;
- that all-skipped selective shards should always fail — child-side selection makes some zero-execution results legitimate;
- that targeted Codex/runtime issues generalize to all external hosts;
- that periodic exclusions mean periodic verification is ineffective;
- that an `eval-summary` contaminated by partial data will always materially change a decision — only that it can misrepresent completed-run history;
- that first-party test rigor provides independent external validation.

No independent external validation of the eval infrastructure itself was established.

---

## 32. Bounded conclusion

**Status: BOUNDED subsystem synthesis.**

Protected conclusion:

> gstack's testing/eval infrastructure is itself a mature work-and-evidence system built around repeated false-green/false-red lessons. It separates route selection, tiering, paid/free ownership, manifest planning, execution, oracle, retry/flake state, artifact finality and historical comparison more carefully than a conventional “run tests and trust exit code” pipeline. Strong mechanisms include fail-toward-more-work diff selection, self-registration/tier-alignment invariants, planner→executor→fail-closed reconciliation, strict Bun-output interpretation, hollow/all-skip execution census, hermetic/process-group-controlled E2E runners, retry-attempt persistence, finalized-baseline filtering and explicit no-baseline semantics. The remaining weaknesses are equally important: coverage matrix membership can mean only structural floor, cross-surface coverage attribution can drift (Canary), real-agent E2Es can simulate the external boundary, external-host runtime availability can produce non-evidence greens, LLM judges are model-calibrated/common-cause oracles rather than independent truth, periodic coverage has tracked exclusions, and partial/final artifact qualification is lost in `eval-list`/`eval-summary`. Therefore “tests/evals green” is never sufficient evidence without the route, execution census, runtime, oracle and artifact standing that produced it.

The next native subsystem should reconstruct **repository self-development / generation / upgrade / release mechanics**: how gstack safely changes the machinery that generates, installs, upgrades, tests and releases gstack itself, and how it prevents derived artifacts or installed copies from drifting away from canonical source.
