# T-W07-6ST · With a database setting missing, unreadable or partial, a guarded write is refused as "could not check"

Synthetic test data (plan Section 8 item 13): every need, finding, work item, claim, artifact path (`docs/w07_fixture_*`), operation, effect class (`w07_fixture_reversible`) and Mission is made up and rolled back; the planted states (a deleted row, a renamed table or column, a null or out-of-range value) exist only inside a subtransaction that is undone before the next case. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 3 ("✘ With the share's setting missing or unreadable, a format-gated write is refused as "could not check", not accepted unsampled") and 4 ("✘ With that copy missing or unreadable, a routine-labelled write with a target is refused as "could not check""); W-C02-07 point 6; W-C02-13 point 6. Plan Section 8 item 14 (PC-16). GROUPS section 3's rows: the sample share's setting, the sample stream's hidden position (DM-08 keeps it as stored state, so it is a separate input), the high-impact path list's copy. Design: EV-C02-002 DM-08, DM-47, DM-48.
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_6st_settings_could_not_check.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8):
- A "could not check" refusal is returned as `{"status": "refused", "reason_code": "could_not_check", …}` (or `status = could_not_check`, or a raised error whose message says "could not check"), distinct from the gate's refusal (naming its field) and from the impact-class refusal (naming `impact`), and from an acceptance.
- `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`); `devos_private.high_impact_path` (`path`); `devos_private.effect_class` (`name`, `irreversible`; one synthetic reversible class planted at owner level).
- `devos_api.record_need`, `record_finding`, `admit_work`, `claim`, `register_artifact`, `prepare_operation`, `open_decision`, `open_mission`, jsonb in and out; calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; fixtures: a Mission on an answered `batu` decision, opened with the `devos_kurulum` token.


**Phase C, the executor's decision on effect classes.** A synthetic effect class may be planted as an owner-level fixture inside the test's rolled-back transaction in `devos-test` (nothing is committed), as well as on the throwaway database (README section 8.1, "Effect classes").

## Cases
Input 1, the sample share (for `need` and for `finding`, `<f>`):
- `6ST-share-<f>-clean`: a complete record → accepted. `6ST-share-<f>-fail`: its gated field empty → refused naming the field (the gate's fail answer).
- `6ST-share-<f>-missing` (the stream's row deleted), `-unreadable` (the table renamed), `-partial` (the stream's `block_size` null, constraints dropped) → a complete record is refused as "could not check"; no row added.
Input 2, the hidden position (stream `finding`, with a block open):
- `6ST-pos-missing` (`block_position` null mid-block), `6ST-pos-unreadable` (the column renamed), `6ST-pos-partial` (`block_position` = `block_size` + 5) → refused as "could not check"; no row. If the build keeps no `block_position`, the cases are COULD NOT CHECK until revised to its form.
Input 3, the path list's copy (a routine item W, claimed):
- `6ST-path-clean`: an artifact on `docs/…` → accepted. `6ST-path-fail`: on `supabase/migrations/…` → refused, naming the impact class.
- `6ST-path-missing` (every row deleted), `6ST-path-unreadable` (the table renamed), `6ST-path-partial` (a row whose `path` is null, constraints dropped) → an artifact on `docs/…` is refused as "could not check"; no row.
- `6ST-path-op-clean` (an operation of the reversible class on `docs/…`) → accepted; `6ST-path-op-missing` (every row deleted) → refused as "could not check".
- `6ST-counts`: per check, the counts of clean, fail and could-not-check answers seen as wanted, with the denominator (all cases).

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-6ST`: the checks that read database settings answer "could not check", block the write they guard, and keep that answer apart from their clean and fail answers. |
| **Failure class rule** | **[Designer's addition: point 6 names inputs, not a class.]** A check that reads a setting and, when the setting is absent, unreadable or partial, lets the write through (as clean: unsampled, or "not on the list") or folds the case into its fail answer. |
| **Examples** | Original finding (plan Section 8 item 14; PC-16: "could not check" a result of its own): the share's row missing (`6ST-share-need-missing`). Other manifestations: the table unreadable, a value partial; the hidden position missing or out of range; the path list's copy empty, unreadable or with an unreadable row, on an Artifact and on an Operation. |
| **Negative control** | Every `-missing`, `-unreadable`, `-partial` case: refused as "could not check", no row written. |
| **Positive control** | `-clean` cases: the same write with the setting intact is accepted. `-fail` cases show the check's fail answer is a different answer. |
| **Break attempt** | **[Designer's addition.]** Each patch folds a "could not check" answer into an acceptance, writing the record directly and unsampled. (1) `breaks/B-6ST-1_need_could_not_check_accepted.sql`: red `6ST-share-need-missing`, `-unreadable`, `-partial`. (2) `breaks/B-6ST-2_finding_could_not_check_accepted.sql`: red `6ST-share-finding-missing`, `-unreadable`, `-partial`, `6ST-pos-missing`, `-unreadable`, `-partial`. (3) `breaks/B-6ST-3_artifact_could_not_check_accepted.sql`: red `6ST-path-missing`, `-unreadable`, `-partial`. (4) `breaks/B-6ST-4_operation_could_not_check_accepted.sql`: red `6ST-path-op-missing`. |
| **Stage and environment** | C02. `devos-test` (migration job step; the planted states are owner-level DDL inside the rolled-back transaction) and the throwaway database. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. The states are planted by the owner, which no application role can do; it does not show how such a state would arise in `devos`. |
| **Evidence envelope** | README section 4. Fixed before the run: each case's wanted answer (clean 4, fail 3, could not check 13; with `6ST-counts`, 21 cases); `6ST-counts` reports them with the denominator. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (W-C02-07 point 6; W-C02-10 points 3 and 4)
| Clause | Case ID(s) | Or: moved to |
|---|---|---|
| The sample share, missing / unreadable / partial | `6ST-share-<f>-missing`, `-unreadable`, `-partial` | — |
| The sample stream's hidden position, missing / unreadable / partial | `6ST-pos-missing`, `-unreadable`, `-partial` | — |
| The high-impact path list's copy, missing / unreadable / partial | `6ST-path-missing`, `-unreadable`, `-partial`, `6ST-path-op-missing` | — |
| "kept apart from "clean" and from "fail" and counted in the denominator" | `-clean`, `-fail`, `6ST-counts` | — |
| "where the check guards a write …, the test shows the write … blocked" | every "could not check" case's row count | — |
| The comparison of the copy with the merge gate's list | — | `T-W07-DM47` (its self-test) |
| The rule gate's inputs; the token derivation | — | `T-W07-6RG` (Group A); `T-W07-6TK` (Group D) |

## Could not check
The test's own result is COULD NOT CHECK when an object is absent (`6ST-pre`), a planted state cannot be planted (the case's own `could_not_check`), a block cannot be opened, or a fixture cannot be made.

## Not covered
How a setting could go missing in a project (only migrations change it); the hidden position's randomness; `devos`.
