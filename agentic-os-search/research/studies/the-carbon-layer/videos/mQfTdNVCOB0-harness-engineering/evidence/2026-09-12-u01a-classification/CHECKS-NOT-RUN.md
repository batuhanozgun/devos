# U01-A — Verification boundary and unexecuted checks

**Date:** 2026-09-12. **Status:** NOT RUN. This file is not a test report, PASS verdict or a claim of independent replication. The current result is a source-level mechanism trace. Exact sources: [SOURCES](SOURCES.md).

## First-party tests actually inspected

`tests/test_evolution_contracts.py` and `tests/test_benchmark.py` were fully read, not run. They cover useful behaviors at unequal levels: configured-seed aggregation/completeness, Pareto dominance, command construction, corrupt-result retry, worker-error propagation, metadata preservation, stable baseline sampling, named result directories and finalization transitions.

Several fixtures mock benchmark/provider work. The default-evolution non-test fixture uses zero iterations and skips baselines; it is not an end-to-end proof that an active proposer never accesses test data. The successful-finalization fixture writes synthetic numeric scores. The incomplete-finalization fixture writes corrupt empty result objects and explicitly allows evolution to resume. That fixture does not cover mixed useful-test-output and failed-test-output exposure. These observations limit what a later green suite result could establish even if the suite is run.

A separate process, another function or a first-party test label does not by itself establish independence from candidate code, evaluator state or shared filesystem effects.

## High-value bounded probes for later U03/U05

Before execution, recover exact source bytes/dependencies and write a concrete SPEC with fixtures, side effects and assertions. Use an isolated temporary root, no provider credentials and no model/network calls for the following mechanical questions. Do not silently replace native functions with reimplementations and call the result upstream execution.

| Probe | Distinction to test | Evidence/oracle needed | What it would not prove |
|---|---|---|---|
| P01 Partial finalization | No useful held-out exposure versus some successful test groups plus another failure | Run the real finalization/resume functions with a bounded mock benchmark producing mixed valid/failed groups; record retained files and actual admission to a subsequent proposal | Actual historical test leakage or a live agent reading the files |
| P02 Stale result identity | Same name/path versus same candidate and configuration | Change candidate bytes or mode under the same result address; call native job builders; compare scheduling with an independent expected-input manifest | Remote model identity, all dependency freshness or production acceptance |
| P03 Coverage-sensitive selection | Complete seeds versus complete datasets | Native result loader/frontier/table with three controlled datasets, one incomplete candidate and one complete baseline; compare population and denominator before/after filling missing groups | Statistical significance or real task improvement |
| P04 Admission levels | Importable module versus valid candidate contract | Harmless import-only fixture, legitimate subclass and imported-subclass fixture; record validation stage and selected runtime class | Containment, malicious-code resistance or all interface semantics |
| P05 Diagnostic persistence | Detailed evaluation records created in memory versus records written for later retrieval | Native worker with a stub callable and tiny synthetic data; independently enumerate written files and compare to returned prediction/prompt records | Historical trace completeness or diagnostic usefulness to a real proposer |
| P06 Measurement semantics | Last prompt versus sum of calls; pre-truncation text versus actual callable input | Tiny two-call candidate with capturing stub; exact request capture and independent character totals; separate cache-hit/miss accounting | Provider billing, task quality or actual tokenization without provider binding |
| P07 Comparison anchor | Prior frontier versus just-updated frontier | Native summary writer on explicitly versioned before/after frontiers; assert the comparator identity separately from candidate accuracy | A causal explanation of improvement |

These are research tests of observable boundaries, not instructions to fix upstream code or alter SOUL/DevOS. They may be reordered if U01-B reveals a more decision-critical uncertainty. Full paid benchmark replication, host security testing and deployment require their own explicit bounded execution decision.

## Present evidence strength

The normal and negative paths were cross-read between caller, implementation, config and two test files. That is same-researcher source cross-checking, not executed verification or independent model review. The numerical illustrations in Note04 are analytical consequences of the displayed formulas. No RESULT.json, fabricated test count, performance improvement or measured failure frequency is supplied.

U01-A may close as a source-characterization unit while these validation debts remain open. Campaign closure and operational reuse must not silently promote that closure into a runtime verdict.
