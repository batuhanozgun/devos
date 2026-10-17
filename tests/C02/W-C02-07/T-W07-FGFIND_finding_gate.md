# T-W07-FGFIND · Finding's format gate: the counter-evidence search and the changeable marker cannot be empty

Synthetic test data (plan Section 8 item 13): every finding (claims about a "w07_fixture parser", "service" or "product"), source span (`w07_fixture_source`), Mission and decision is made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 2, 3 and 7 ("Finding's gate test … if W-C02-04 keeps them in C02": EV-C02-002 DM-30 keeps it). W-C02-07 points 4 and 5 (d) (R2 section 5 (b): "Finding's gate if W-C02-04 keeps it"). Design: B 3.8 (PC-42 place 14: `counter_evidence_searched` and `changeable` mandatory, "format gates", Finding a stream of the sample); EV-C02-002 DM-26, DM-30, DM-08. N-032's structural gate: moved to C03 (EV-C02-002 section 3 row 2.12 and section 7; N-211), no test here.
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-10 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_fgfind_finding_gate.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8): `devos_api.record_finding(jsonb)` with B 3.8's fields as keys (`claim`, `source_spans` with `primary` and `read_at`, `counter_evidence_searched`, `changeable` as B 3.8's value set, a JSON string `yes`, `no` or `not_recorded` (N-278 (1)), `fresh_until`, `privacy_class`, `scope`, `status`); a refusal names its field, returned or raised; calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; `devos_private.finding` (row count); `devos_private.sample_stream` stream `finding` (`block_size`, `block_seen`, `block_position`); sample reviews in `devos_private.review` (`kind = sample`, the target's `id`, one field holding `devos_denetim`); fixtures: a Mission on an answered `batu` decision (some builds may need it for scope).

## Cases
- `FGFIND-pos`: a complete finding (`changeable = no`, a dated primary span, "none found" after a named search) → accepted.
- `FGFIND-pos-changeable`: `changeable = yes` with `fresh_until` → accepted.
- `FGFIND-neg-ces-empty`, `-whitespace`, `-absent`: `counter_evidence_searched` empty → refused naming it; no row.
- `FGFIND-neg-chg-absent`, `-null`, `-empty`: `changeable` missing → refused naming it; no row.
- `FGFIND-fbm1`: a complete block of findings whose `counter_evidence_searched` is `-` → accepted; one sample per block.
- `FGFIND-fbm2`: a complete block of findings claiming a price today with `changeable = no` and "none found" → accepted; one sample per block (DM-26: "the declaration falls to the sample").

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-FGFIND`: a finding whose `counter_evidence_searched` or `changeable` is empty is refused; a filled but meaningless one is accepted and reaches sample review. |
| **Failure class rule** | **[Designer's addition: no Appendix C entry; R2 section 5 (b).]** A finding stored without the record of its counter-evidence search or without the declaration that decides whether N09's dating rule applies to it, in any empty form; or such a declaration, filled but false, that escapes the sample. |
| **Examples** | Original finding (R2 section 5 (b): "Finding's mandatory `counter_evidence_searched` (`Ek_B:191`) has no test"): `FGFIND-neg-ces-*`. Another manifestation: the `changeable` marker missing (`FGFIND-neg-chg-*`), which would let a changeable finding escape N09's rule (DM-26 (b)). |
| **Negative control** | `FGFIND-neg-*`: refused, naming the field, no `finding` row. |
| **Positive control** | `FGFIND-pos`, `FGFIND-pos-changeable`: the same record with the field filled. |
| **Break attempt** | **[Designer's addition.]** (1) `breaks/B-FGFIND-1_counter_evidence_gate.sql`: red `FGFIND-neg-ces-empty`, `-whitespace`, `-absent`. (2) `breaks/B-FGFIND-2_changeable_gate.sql` (a missing `changeable` filled with `no`): red `FGFIND-neg-chg-absent`, `-null`, `-empty`. (3) `breaks/B-FGFIND-3_sample_skipped.sql`: red `FGFIND-fbm1`, `FGFIND-fbm2`. |
| **Stage and environment** | C02. `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`). The migration job runs a file of this test only once W-C02-10 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show that a search was made or a declaration is true (sample review), nor N09's `accepted_for_use` rule (Group B's `T-W07-N09`). |
| **Evidence envelope** | README section 4. Fixed before the run: each case's outcome; one sample per complete block of 10. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (B 3.8's gate; no Appendix C entry)
| Clause | Case ID(s) | Or: moved to |
|---|---|---|
| "`counter_evidence_searched` (mandatory …)" is a format gate | `FGFIND-neg-ces-*`, `FGFIND-pos` | — |
| "`changeable` (mandatory …)" is a format gate | `FGFIND-neg-chg-*`, `FGFIND-pos-changeable` | — |
| "Finding is one of the sample's streams" | `FGFIND-fbm1`, `FGFIND-fbm2` | — |
| N-032's structural gate | — | C03 (EV-C02-002 2.12; N-211) |

## Format gate (point 4)
Kind 1: `counter_evidence_searched` = `-`. Kind 2: `changeable = no` declared on a time-bound claim with "none found". The database must accept both; one per complete block lands as a `sample` Review queued for `devos_denetim`.

## Could not check
COULD NOT CHECK when an object is absent (`FGFIND-pre`), a fixture cannot be made, or the stream cannot be aligned.

## Not covered
N09's rule (`T-W07-N09`); N-032 (C03); the content of a finding (sample review); `devos`.

## Revision before any result (N-278, 2026-10-17)
Revised by: test-designer, agent `a4e19b0f4f0daf82d`, filled in by the executor at filing (it read no file of W-C02-09's build: there is none; it read W-C02-08's merged migrations, the interface these tests must fit). Under ledger rule 3 and README section 8: no result of this test is counted (the executor's task of 2026-10-17); any earlier result of the changed file is void, and the test is run again. Changed: `job/w07_fgfind_finding_gate.sql`, `breaks/B-FGFIND-2_changeable_gate.sql`.
- **N-278 (1): Finding's `changeable` is the value set `yes` / `no` / `not_recorded`.** The Group C fixture finding that this file sends to `record_finding` (`pg_temp.w07_args('finding', ...)`, kinds complete and fbm2); `FGFIND-pos-changeable` sends `yes`; B-FGFIND-2 fills a missing `changeable` with `no`, as it filled it with `false`. Decided from Appendix B 3.8 (`changeable`, "mandatory: whether the finding carries information that can change"; a transferred finding's fields "hold `not_recorded`, a recorded value distinct from 'none found'") and EV-C02-005 S4 ("so `changeable` is a value set: yes / no / not_recorded"), as W-C02-08 built it (the enum `devos_private.finding_changeable`, migration `20261014182601`). A boolean cannot carry `not_recorded`, so these tests do not assume an interface that maps one; a JSON `false` planted in the built column is refused (`invalid input value for enum devos_private.finding_changeable: "false"`; the test designer's self-check of 2026-10-17, PostgreSQL 16.15, counts: no). The file now sends `no` where it sent `false`, and `yes` where it sent `true`. Whether W-C02-09's `record_finding` also accepts a JSON boolean is its build's choice; no case relies on it.
- **N-278 (5): Finding's `epistemic_status` and `current_authority`.** The Group C fixture finding (`pg_temp.w07_args('finding', ...)`) now carries `epistemic_status` `observation` and `current_authority` `information_only`, which W-C02-08 built NOT NULL on `finding_revision` (migration `20261014190401`; Appendix B 3.8's separate fields). `source_type` stays absent (NULL: a DevOS-made record, T-35's value pending). How W-C02-09 and W-C02-10 tell a NULL `source_type` from one not filled in is theirs to settle (N-278 (5)); no case here depends on it.
- No case ID, expected outcome, count or break's red list changed.
