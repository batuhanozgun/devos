# M4 — Executed checks and published-example reperformance

**Date:** 2026-09-13. **Status:** executed bounded evidence; not independent Foundation validation.

## Execution and oracle

The research PLAN was published before fresh external reconnaissance. The check SPEC was written after reconnaissance and before first execution. Python 3.13.5 and SQLite 3.46.1 ran twelve named checks and eight false-rule controls. The first run passed without changing the specification, excluding a case or revising an expected result. A second run of the unchanged script produced identical RESULT bytes.

Eleven cases are researcher-designed. C12 re-performs a particular published mathematical example, using an externally supplied expected result; this improves the independence of that case's oracle, not the independence of our interpretation or final research tree. The figure's world ordering was visually inspected before transcription. The two operators are implemented from the paper's definitions, not imported production code.

| Case | Observed result |
|---|---|
| C01 | Same current world 00; same next input/operator selects 10 from one retained ranking and 11 from the other. |
| C02 | Direct q removed; q still follows from a. Removing the remaining basis does not derive not-q. |
| C03 | Recomputed seedless closure empty; recycling an old consequence keeps both a and b. |
| C04 | Static learning gives {10}; event update gives {10,11}; an added exclusivity invariant would reject 11. |
| C05 | Two equal-size repairs; two explicit priority settings choose opposite retained literals. |
| C06 | Native SQLite: ready as known at15; blocked as known at25, both about reference-time15; two records retained. |
| C07 | Native SQLite: arrival-latest v2; applicable-current v1 at15 and v2 at35. |
| C08 | Native SQLite: zero rows changed by stale version-conditioned update; unconditional update erases the blocker. |
| C09 | Native SQLite: focal-version-only condition true; declared object-plus-policy condition false. |
| C10 | Duplicate delta totals2; event-ID deduplication and repeated absolute assignment each total1. |
| C11 | Each admitted context is coherent; unconditional union includes p and not-p. |
| C12 | Published example: both first revisions prefer {100,101}; next q gives {110,111} under natural revision and {011} under lexicographic revision. |

Eight rejected false rules concern current-belief-only state, direct deletion as complete withdrawal, circular recycled support, learning versus world update, unique minimal repair, latest receipt as currentness, focal checks as complete dependency coverage, and universally safe replay. These are controls on the same fixtures, not eight independent experiments or a broad mutation-testing campaign.

## Exact executed artifacts

- `checks/SPEC.md`: Git blob `9b24cb312d2aea6f5638810ba6d710981951e281`; SHA256 `d94fa7cb18c31be20e1bbc1663c034f33019f681d667d9d5926ddf868a2f08d5`.
- `checks/revision_checks.py`: Git blob `965a7d58381b5b24c535ca92c548ea88d3894d60`; SHA256 `c9ccf7a80c3b8f0b3cb1f1cb4b09d3964de06a4b53c7b7c4c81e73acdd5f2536`.
- `checks/RESULT.json`: Git blob `0a2f2b559154d862af85ea784906a470e09b9cd3`; SHA256 `5d0892ff50ce5b8793b286089189b2603d9374ddb0b0e6962f85c2f497503be9`.

These identities were compared with the actual local files, not only with the writer's description. Running `python checks/revision_checks.py` writes a result including failures and exits nonzero on failure. Python/SQLite version changes can change the recorded environment bytes; re-evaluate rather than expecting identical hashes under every runtime.

## Boundaries

No actual HTTP request, competing OS processes, model invocation, distributed transaction, production database, human revision experiment or SOUL runtime ran. C06/C07 temporal semantics are supplied by the fixture; they do not establish world truth. C08 is a scheduled interleaving, not a concurrent-race stress test. C09 covers two declared prerequisites, not a complete real dependency-discovery method. C10 provides no exactly-once external effect guarantee. C11 is a small contextual illustration, not a complete ATMS.

C12 does not replicate S2's general theorems, prove our implementations satisfy all DP axioms, select an optimal revision policy, or independently validate our leaf judgment. The sources, counterexamples and native executions constrain specific claims; unknown support, epistemic-state reconstruction, actual actor use and real benefit remain open.
