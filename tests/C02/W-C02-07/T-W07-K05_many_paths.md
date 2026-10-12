# T-W07-K05 · On a small graph with many paths, the real affected-records query returns no more rows than records

Synthetic test data (plan Section 8 item 13): part A builds a made-up ladder graph inside a rolled-back transaction: random uuids named r, u1..u27 and v1..v27, and relation rows of type `derived_from` with scope `synthetic.w07fixture`. It uses one synthetic `devos_calisma` token of `devos-test`. Part B writes the same ladder into `devos`, under the synthetic test Mission of EV-C02-002 DM-23 (scope `synthetic.real_token_tests`), through `devos_api` with the `devos_kurulum` token.

**Serves.** W-C02-09 point 8 ("F04 with K05"). Part B also needs W-C02-12's `devos-calisma` session (see "Could not check"). Appendix C K05 (Ek_C:160): "The F04 class test, and the row count not exceeding the record count in the real query". C3's introduction (Ek_C:152): "These are tested not only with database tests but with real sessions. For each of them, the success condition is written in advance."
**Command.** Part A, in `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_k05_many_paths.sql` as `postgres`, and passes only on the notice `W07_K05_MANY_PATHS PASS`. Statement timeout 300 s. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-K05-1_no_deduplication.sql --pg-bin <PostgreSQL 17 bin>`. Part B: from a session in `devos-calisma`, the client path of EV-C02-003 §1.6 (the repository's Data API script; the proxy adds the header) calls `affected_entities(r)` and `explain_paths(r, x)` on part B's ladder in `devos`. It records counts, flags and milliseconds only.
**Time added to W-C02-13's run.** None for part A (seconds). Part B adds one set of calls to a `devos-calisma` session (minutes). By the executor's decision it runs in a session of sitting B2 (W-C02-12), so it waits on that sitting: its time on the critical path is W-C02-12 point 3's, with that point's source and date (PC-23), not this test's (phase C3, G15).
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. As T-W07-F04 states it: the call convention; the `relation` columns and the edge's direction; `affected_entities(root, limits)` returning `{records, complete}`; `explain_paths(root, target, limits)` returning `{paths, complete}`. Part B also needs the client path W-C02-09 builds and DM-23's test Mission.


**Phase C, the executor's decision.** Part B (a real session's run) is run by W-C02-13 in a session of sitting B2 (W-C02-12). Until that run, part B is "could not check", and this test's result is COULD NOT CHECK for that clause.

## Success condition, written before any run
On the ladder below (55 records, 72 relations, hundreds of paths), `affected_entities(r)` with limits above the graph's size must:
- return at most 55 rows, each record once;
- return all 54 records other than r;
- give `complete = true`;
- end within 10 seconds.

`explain_paths(r, record, max_paths 3)` must return 1 to 3 valid paths for each of the 54.

The ladder: two chains below r (u1..u27 and v1..v27: 2 + 52 relations), plus 18 rungs crossing both ways in the first nine steps.

## Cases
- **K05-graph** records the fixture's size (55, 72).
- **K05-rows**: rows <= 55 and unique.
- **K05-found**: all 54 found.
- **K05-complete**: the flag is true.
- **K05-time**: the call ends within 10,000 ms.
- **K05-paths**: each record has 1 to 3 valid paths.
- **K05-pre**: `could_not_check` when an object is absent or the graph cannot be planted.
- **K05-B-rows, K05-B-found, K05-B-complete, K05-B-time, K05-B-paths** (part B): the same five checks on the same ladder in `devos`, with the `devos-calisma` session's real token.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-K05. On a small graph with many paths, of another shape than F04 (a), the real (deployed) affected-records query returns no more rows than records: each once, all of them, complete and promptly. The explanation stays bounded. |
| **Failure class rule** | **[Designer's addition: K05 has only a success condition (R2 section 5 (c))]** F04's class: a result whose size follows the number of paths, not the number of records, or a traversal of many crossing paths that does not finish. |
| **Examples** | **[Designer's addition, same reason]** The original finding is F04 (a)'s diamonds (T-W07-F04, F04-a-rows). Another manifestation: the ladder with crossing rungs (K05-rows, K05-time), in `devos-test`; and the same ladder in `devos` (K05-B-rows). |
| **Negative control** | **[Designer's addition]** A row count above 55, a record twice, or a call over 10 s is `bad` (K05-rows, K05-time). Nothing is written; part A's fixtures are rolled back. |
| **Positive control** | **[Designer's addition]** All 54 found, complete, each with a valid path (K05-found, K05-complete, K05-paths). |
| **Break attempt** | **[Designer's addition]** **B-K05-1** (`breaks/B-K05-1_no_deduplication.sql`) makes the same removal as B-F04-1: the query lists each record once per path. Must turn red: **K05-rows**. Part B has no break of its own, since no rule is broken in `devos`; its break is part A's (README 5.3; W-C02-12 point 8). |
| **Stage and environment** | C02. Part A: `devos-test`, the migration job's test step; the break on the throwaway database. Part B: `devos`, from a session in the Claude environment `devos-calisma`, with its real token (README 5.3). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Part A is run by the migration job, W-C02-09's producer and W-C02-13's prober with its break. Part B is run by W-C02-12's `devos-calisma` session. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Part A is structural: the deployed query's output. Part B is behavioural only in the narrow sense that it shows the query answering a real session in `devos`. Neither shows that agents use the result rightly. |
| **Evidence envelope** | README 4's fields. `transport`: `sql-set-role` (part A in the job), `throwaway` (break) or `real-token` (part B, with the session's branch and result file as `observations_ref`). Values fixed before the run: the success condition above (55, 72, 54, 3 paths, 10,000 ms) and the break's red case. |

## Clause table (point 2)
| Clause of Appendix C K05 and C3 (verbatim) | Case ID(s) |
|---|---|
| "A small graph with many paths" | K05-graph (the ladder) |
| "The F04 class test" | K05-rows, K05-found, K05-complete, K05-paths, K05-time; and T-W07-F04 in full |
| "the row count not exceeding the record count in the real query" | K05-rows in `devos-test`; K05-B-rows in `devos`. Tested in the design's form: "the real query" is read as the function the migrations deploy, called on real PostgreSQL, not a copy of it (EV-C02-002 section 5) |
| C3: "tested not only with database tests but with real sessions" | Part B, K05-B-*. Tested in the design's form: a real session is a `devos-calisma` session calling `devos` with its real token, and its fixtures sit under DM-23's test Mission (EV-C02-002 section 5 and DM-23; README 5.3) |
| C3: "the success condition is written in advance" | "Success condition, written before any run" above |

## Could not check
Part A gives COULD NOT CHECK in the same cases as T-W07-F04: an absent object, a fixture that cannot be planted, or a call that cannot be formed. Part B is COULD NOT CHECK until W-C02-12's `devos-calisma` session runs it on the test Mission's ladder. While it is, K05's real-session clause is not met. W-C02-12's acceptance does not list this run, so the executor assigns it (the group's report, "Open").

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-K05-1 turns red exactly K05-rows, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- Larger graphs and capacity: C04 task 6's measurement.
- Breaks in `devos`: none are run there.
- The meaning of the result.
