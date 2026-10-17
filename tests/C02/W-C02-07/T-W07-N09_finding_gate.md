# T-W07-N09 · A changeable finding cannot become accepted_for_use undated or without a primary source span

Synthetic test data (plan Section 8 item 13): findings made up inside a rolled-back transaction: claim `w07_fixture SYNTHETIC W-C02-07 claim`; source spans naming random uuids, with read dates in October 2026; scope `synthetic.w07fixture`. One synthetic `devos_denetim` token. No library text.

**Serves.** W-C02-09 point 8 ("N09 (its C02 part)"). Appendix C N09 (Ek_C:126): "A finding that is undated or has only secondary sources cannot become `accepted_for_use`" / "A dated finding with a primary source can" / stage "C02, C04". Appendix B 3.8's rule, with PC-42 place 15: "Until C04 this reads `changeable` and its source spans' primary or secondary marker and reading date". EV-C02-002 DM-26: "A finding with `changeable` true cannot move to `accepted_for_use` undated or without a primary span."
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n09_finding_gate.sql` as `postgres`, and passes only on the notice `W07_N09_FINDING_GATE PASS`. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-N09-1_undated_accepted.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. Group B's call convention, as T-W07-F04 states it. For this test:
- `devos_private.finding` (`id`, `status`, `scope`) and `devos_private.finding_revision` (`finding_id`, `revision`, `claim`, `source_spans`, `changeable`, `counter_evidence_searched`), as DM-02 splits a family;
- each span is an object with `primary` (boolean) and, when dated, `read_at` (a date);
- `devos_api.review_finding(finding_id uuid, revision integer, status text)`, permitted to `devos_denetim`.

## Cases
- **N09-a** (the original): `changeable` true, its one primary span undated. The move to `accepted_for_use` is refused and the status stays.
- **N09-b**: `changeable` true, only secondary spans, both dated. Refused.
- **N09-c**: `changeable` true, no span at all (no primary span). Refused.
- **N09-d**: `changeable` true, an undated primary span beside a dated secondary one. Refused: the primary source is undated.
- **N09-pos**: N09-a with the primary span dated. Accepted: the status becomes `accepted_for_use`.
- **N09-pre**: `could_not_check` when an object is absent.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-N09. A finding whose information can change (`changeable` true) cannot be moved to `accepted_for_use` while its primary source is undated or missing; a finding dated from a primary source can. |
| **Failure class rule** | **[Designer's addition: C2 rows have no class rule (R2 section 5 (c))]** Changeable information accepted for use without a dated primary source: undated spans, secondary-only spans, no spans, or a date carried only by a secondary span. |
| **Examples** | **[Designer's addition]** The original, Appendix C N09's negative: N09-a (undated) and N09-b (secondary only). Other manifestations: N09-c (no span) and N09-d (the date on the wrong span). |
| **Negative control** | Appendix C: "A finding that is undated or has only secondary sources cannot become `accepted_for_use`". N09-a to N09-d: each call is refused and the finding's status is not `accepted_for_use`. |
| **Positive control** | Appendix C: "A dated finding with a primary source can": N09-pos, which differs from N09-a only in the primary span's date. |
| **Break attempt** | **[Designer's addition: C2 rows have no break]** **B-N09-1** (`breaks/B-N09-1_undated_accepted.sql`) removes the rule wherever it sits. It disables triggers on `finding` that read the spans, and wraps `review_finding`, so that a refused move to `accepted_for_use` is made anyway. Must turn red: **N09-a, N09-b, N09-c, N09-d**. |
| **Stage and environment** | C02 (its C02 part). `devos-test`, the migration job's test step, with a synthetic `devos_denetim` token. The break runs on the throwaway database. The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-09's producer at its head, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural: the database refuses on the declared markers. It does not show that a declared "primary" is primary, or that a date is true: those are declarations the sample review checks (principle 12; DM-26), from C03 in the audit environment. |
| **Evidence envelope** | README 4's fields; `transport` `sql-set-role` or `throwaway`. Values fixed before the run: each case's outcome above and the break's red cases. |

## Clause table (point 2)
| Clause of Appendix C N09 (verbatim) | Case ID(s) / moved to |
|---|---|
| Claim: "Changeable information is not accepted undated" | N09-a to N09-d |
| Negative: "A finding that is undated or has only secondary sources cannot become `accepted_for_use`" | N09-a (undated), N09-b (secondary only), N09-c, N09-d |
| Positive: "A dated finding with a primary source can" | N09-pos |
| Stage "C02, C04": the C04 part | Moved to C04 by Appendix C itself and PC-42 place 15: there, a span's Source record decides primary or secondary (N-212 item 5) |

## Could not check
The test gives COULD NOT CHECK when `finding`, `finding_revision` (with `finding_id`, `revision`, `source_spans`, `changeable`), `review_finding` or `issue_env_token` is absent. A case gives `could_not_check` when its finding cannot be planted, or when the call cannot be formed. Before the build exists the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-N09-1 turns red exactly N09-a, N09-b, N09-c, N09-d, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- Finding's format gates (`counter_evidence_searched`, `changeable`): Group C's T-W07-FGFIND.
- Whether the declared markers are true: sample review.
- Other transitions into `accepted_for_use`, if the build has one besides `review_finding`: a case is added before the first result.

## Revision before any result (N-278, 2026-10-17)
Revised by: test-designer, agent `a4e19b0f4f0daf82d`, filled in by the executor at filing (it read no file of W-C02-09's build: there is none; it read W-C02-08's merged migrations, the interface these tests must fit). Under ledger rule 3 and README section 8: no result of this test is counted (the executor's task of 2026-10-17); any earlier result of the changed file is void, and the test is run again. Changed: `job/w07_n09_finding_gate.sql`.
- **N-278 (1): Finding's `changeable` is the value set `yes` / `no` / `not_recorded`.** Its owner-level planter `pg_temp.w07_finding(p_spans, p_changeable boolean)` put the boolean in the built enum column, so every case's fixture failed and gave `could_not_check`; it now plants `yes` for true and `no` for false. The cases still say "changeable" (`yes`) and "not changeable" (`no`), as DM-26 does. Decided from Appendix B 3.8 (`changeable`, "mandatory: whether the finding carries information that can change"; a transferred finding's fields "hold `not_recorded`, a recorded value distinct from 'none found'") and EV-C02-005 S4 ("so `changeable` is a value set: yes / no / not_recorded"), as W-C02-08 built it (the enum `devos_private.finding_changeable`, migration `20261014182601`). A boolean cannot carry `not_recorded`, so these tests do not assume an interface that maps one; a JSON `false` planted in the built column is refused (`invalid input value for enum devos_private.finding_changeable: "false"`; the test designer's self-check of 2026-10-17, PostgreSQL 16.15, counts: no). The file now sends `no` where it sent `false`, and `yes` where it sent `true`. Whether W-C02-09's `record_finding` also accepts a JSON boolean is its build's choice; no case relies on it.
- No case ID, expected outcome, count or break's red list changed.
