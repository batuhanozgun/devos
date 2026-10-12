# T-W07-F04 · The affected-records query returns each record once; the explanation is bounded; a limit or a hidden record gives a completeness flag and leaks nothing

Synthetic test data (plan Section 8 item 13): four made-up graphs built inside a rolled-back transaction: random uuids named by their place (m0..m18, a1..b18, c1..c3, r, x, h, y, n1..n40); relation rows of type `derived_from` with scope `synthetic.w07fixture`; one work item titled `w07_fixture_hidden_node SYNTHETIC W-C02-07` tied to a synthetic exam run, and one titled `w07_fixture_visible_node SYNTHETIC W-C02-07`; one synthetic `devos_calisma` token issued in the transaction.

**Serves.** W-C02-09 point 8 ("F04 with K05") and point 7 ("`affected_entities` and `explain_paths` at a limit return their completeness flag and never 'nothing else is affected' (F04 (d))"): cases F04-d1 and F04-d2 are point 6's test for that check (GROUPS.md section 3). Appendix C F04 (Ek_C:61-68). Appendix B section 4, Relation row ("the result carries completeness information"), and section 7's privacy filter ("even the existence of results a role cannot see is not leaked. If completeness is limited because of a region that cannot be seen, this is stated without revealing the content"). EV-C02-002 DM-35 ("`affected_entities` and `explain_paths` return only what the caller may see and mark completeness 'limited' without naming the hidden part").
**Command.** In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_f04_affected_records.sql` as `postgres`, after the merge's migrations are applied there and before `devos` (EV-C02-004 Y-05; EV-C02-001 P10 fixes the client, which runs no meta-command). It counts a pass only on the notice `W07_F04_AFFECTED_RECORDS PASS`. Statement timeout 300 s (stated here, README 5.1 (a)). Breaks, on the throwaway database: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-F04-1_no_deduplication.sql --patch tests/C02/W-C02-07/breaks/B-F04-2_always_complete.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit (seconds of computation).
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. Group B's call convention: `devos_api` functions called as the Data API calls them, by named parameters (a JSON key `k` binds the parameter `k`; a record writer's `p jsonb` takes the other keys, README section 8.1), as `anon`, with the token in `x-devos-env-token` inside `request.headers`. A refusal is returned, not raised (DM-19), as `{status: refused, reason_code}` (README section 8.1); a raised error also counts as refused, since the same helper reads direct writes, where a privilege's error is the refusal (README section 8.1, "An answer outside this form"). Fixtures are planted as the owner, with every NOT NULL column without a default filled by type. `devos_private.issue_env_token(role_class text)` returns the token (as Group D's `T-W07-IDC` states; phase C checks they agree). For this test:
- `devos_private.relation` (`type`, `from_ref`, `from_revision`, `to_ref`, `to_revision`, `scope`, `hard`, `method`, `epistemic_status`, `validity`), where an edge `from_ref = x, to_ref = y` of type `derived_from` means a change of y affects x;
- `devos_api.affected_entities(root uuid, limits jsonb)` returning `{records: [{ref}], complete: boolean}` (a set of rows with `ref` is also read);
- `devos_api.explain_paths(root uuid, target uuid, limits jsonb)` returning `{paths: [[ref, ...]], complete}`;
- `limits` keys `max_depth`, `max_records`, `max_paths`;
- `devos_private.work_revision` (`work_id`, `revision`, `title`) and `devos_private.eval_run` (`work_ref`) (DM-24).

A call that cannot be formed under this interface gives `could_not_check` with the mismatch named. If the build chooses another form, the test designer revises the test before its first result (README 8).

## Cases
- **F04-a-rows** (a), the original finding's graph: 18 consecutive diamonds, 55 records and 72 relations (1,048,573 rows if every path is carried). `affected_entities(m0)` with limits above the graph's size: at most 55 rows, no ref twice.
- **F04-a-found** (positive): all 54 records other than m0 are in the result.
- **F04-a-complete** (positive): the completeness flag is true when no limit is reached.
- **F04-a-paths** (positive): for each of a1..a18 and m1..m18, `explain_paths(m0, it, max_paths 3)` returns 1 to 3 paths. Each path joins m0 and the record through fixture relations.
- **F04-a-bounded**: `explain_paths(m0, m18, max_paths 3)`, where 262,144 paths exist, returns at most 3 valid paths, with `complete = false`.
- **F04-b-rows** (b): an explanatory cycle (c1 -> r, c2 -> c1, c3 -> c2, c1 -> c3). The result is exactly c1, c2, c3, once each, and the call ends.
- **F04-c-noleak** (c): r <- x <- h <- y, with h tied to an exam run. Called with the working token, the result holds neither h's id nor its title's marker.
- **F04-c-flag** (c): the same result's completeness flag is false.
- **F04-c-pos** (positive control for (c)): the same shape with h2, which is tied to no exam. x, h2 and y are found, and the result is complete. It differs from (c) only in the exam link.
- **F04-d1** (d): a chain of 40 with `max_depth 10`. Expected: `complete = false` (not true, not absent), at most 40 rows, none twice.
- **F04-d2** (d): the same chain with `max_records 5`. Expected: `complete = false` and at most 5 rows.
- **F04-pre**: `could_not_check` when an object is absent or a fixture cannot be planted.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-F04. **[Designer's addition: F entries have no claim line (R2 section 5 (c)); drawn from the class rule]** `affected_entities` returns each affected record once, however many paths reach it. `explain_paths` is separate and returns a bounded number of valid paths. A result cut by a limit, or by a record outside the caller's authority, says so with its completeness flag. It never says "nothing else is affected", and never names the hidden record. |
| **Failure class rule** | Appendix C F04: "The affected-records query returns unique records; the path explanation is separate and bounded; a result that reaches the limit carries a completeness flag." Members of the family: a result whose size follows paths rather than records (diamonds, cycles, ladders); a traversal that does not end on a cycle; a cut result presented as complete; a hidden record's id or name in a result. |
| **Examples** | The original finding, (a) consecutive diamonds: F04-a-rows. Other manifestations: (b) an explanatory cycle, F04-b-rows; (c) a node outside authority, F04-c-noleak and F04-c-flag; (d) a deep graph that reaches the limit, by depth (F04-d1) and by count (F04-d2); the bounded explanation, F04-a-bounded. T-W07-K05 adds a ladder. |
| **Negative control** | "The number of result rows does not exceed the number of records" (F04-a-rows, F04-b-rows); "in (d), 'nothing else is affected' is not said" (F04-d1, F04-d2: `complete` must be false); "in (c), the name of the hidden node does not leak" (F04-c-noleak), and the cut is stated (F04-c-flag). No case writes state, and the fixtures are rolled back. |
| **Positive control** | "All affected records are found with at least one explanatory path": F04-a-found, F04-a-paths, F04-a-complete. Also F04-c-pos, which differs from (c) only in the exam link. |
| **Break attempt** | **B-F04-1** (`breaks/B-F04-1_no_deduplication.sql`) removes deduplication. `devos_api.affected_entities(uuid, jsonb)` is renamed and wrapped; the wrapper keeps the build's visibility and flag, and lists each visible record once per path (up to 25 steps). Must turn red: **F04-a-rows, F04-b-rows** (Appendix C: "the row count in (a) must explode"). **B-F04-2** (`breaks/B-F04-2_always_complete.sql`) removes the completeness flag: the wrapper sets `complete` to true. Must turn red: **F04-c-flag, F04-d1, F04-d2**. |
| **Stage and environment** | C02. `devos-test`, in the migration job's test step (README 5.1 (a)), with a synthetic `devos_calisma` token of `devos-test` (EV-C02-003 §6.3); no Claude environment. The breaks run on the throwaway database (README 5.2). It relies on EV-C02-004 Y-05 (the job's test step) and EV-C02-002 section 5 (the break path). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; its agent ID is in W-C02-07's "Record", point 1). Run by the migration job in `devos-test`, by W-C02-09's producer at its head, and by W-C02-13's prober with the breaks. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared by all: model lineage, EV-C02-002 to EV-C02-004 and Appendices B and C (plan Section 8 item 7). |
| **Evidence layer** | Structural: the deployed query's output on planted graphs. It does not show that the records a real graph holds are the right ones to call affected (semantic), nor how agents use the result (behavioural). |
| **Evidence envelope** | README 4's fields. `transport` is `sql-set-role` in the job and `throwaway` under the harness. `observations_ref` is the job run's URL, run ID, job and step, or the harness's JSON line for the patch. `raw_evidence_ref` is the unedited output under `evidence/C02/raw/`, after README 4's two hygiene checks. Values fixed before the run: each case's expected outcome above; graph sizes 55/72, 6/4, 4/3 and 41/40 (records/relations); limits 100/1000/10, depth 10, records 5, paths 3; the bounds; each break's red cases. |

## Clause table (point 2)
| Clause of Appendix C F04 (verbatim) | Case ID(s) |
|---|---|
| Original finding: "In a small graph of 55 records and 72 relations, the query carrying all paths produced 1,048,573 rows." | F04-a-rows (the same counts: 18 diamonds) |
| Class rule: "The affected-records query returns unique records; the path explanation is separate and bounded; a result that reaches the limit carries a completeness flag." | F04-a-rows, F04-b-rows; F04-a-paths, F04-a-bounded; F04-d1, F04-d2 |
| "(a) consecutive diamond structures" | F04-a-rows, F04-a-found, F04-a-complete, F04-a-paths, F04-a-bounded |
| "(b) a graph containing an explanatory cycle" | F04-b-rows |
| "(c) a graph containing a node outside authority" | F04-c-noleak, F04-c-flag, F04-c-pos (tested in the design's form: "outside authority" is DM-35's exam link) |
| "(d) a deep graph that reaches the limit" | F04-d1, F04-d2 |
| Negative: "The number of result rows does not exceed the number of records" | F04-a-rows, F04-b-rows, F04-d1, F04-d2 |
| Negative: "in (d), 'nothing else is affected' is not said" | F04-d1, F04-d2 |
| Negative: "in (c), the name of the hidden node does not leak" | F04-c-noleak |
| Positive: "All affected records are found with at least one explanatory path." | F04-a-found, F04-a-paths, F04-c-pos |
| Break: "When deduplication is removed, the row count in (a) must explode and the test must fail." | B-F04-1: F04-a-rows red |

## Could not check
The test gives COULD NOT CHECK when any of these is absent: `affected_entities`, `explain_paths`, `relation`, `eval_run`, `work_revision` or `issue_env_token` (F04-pre). The same holds when a fixture cannot be planted, or when a call cannot be formed or is refused for its token: the case gives `could_not_check` with the reason, and a refusal is never read as a pass. Before the build exists, the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-F04-1 and B-F04-2 turns red exactly F04-a-rows, F04-b-rows; and F04-c-flag, F04-d1, F04-d2, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- `devos` as a target: a pass in `devos-test` closes nothing there (README 4). K05's real-session part is T-W07-K05 part B.
- Continuation queries tied to their snapshot (B section 7): C02 builds none. If the build adds one, a case is added before its first result.
- Visibility beyond DM-35's exam rule: privacy classes govern public writes, not reads (DM-35 (d)).
- What "affected" means for each relation type: the test fixes one type, `derived_from`, and one direction; the other types are the build's interface.
