# T-W07-N29 · The impact class follows the database's rules, and a declared trigger reaches the audit environment through the sample

Synthetic test data (plan Section 8 item 13): every work item, artifact path (`docs/w07_fixture_*`, and listed paths with `w07_fixture` file names), operation, effect class (`w07_fixture_reversible`, `w07_fixture_irreversible`), relation, decision and Mission (scopes `synthetic.w07_fixture*`) is made up and rolled back. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 3, 4 and 7. Appendix C N29 (`Ek_C:146`, with PC-42 place 39's link clause). Design: B 3.3 and 3.17 (PC-08; PC-42 place 12); B 3.1 (Mission only by a `batu` decision); EV-C02-002 DM-23, DM-37 (effect classes), DM-42 (the link case), DM-47 (the path table), DM-48 ("exactly the cases B:134 and B:293 name as the database's"), DM-08 (streams `work_routine`, `decision_routine`).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n29_impact_class.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** (README section 8):
- `devos_api.admit_work`, `claim` (returns `claim_token`), `register_artifact` (`work_ref`, `claim_token`, `path`), `prepare_operation` (`work_ref`, `claim_token`, `effect_class`, `target`, idempotency fields), `relate` (`type`, `from_ref`, `to_ref`, revisions), `open_decision` (`class`, `work_ref`), `open_mission` and `revise_mission` (`owner_authority`; `revise_mission` takes the Mission's `id` and a wider `scope`); each takes and returns jsonb. An impact-class refusal names the rule (its reason contains `impact`). Calls run as `anon` with the header `x-devos-env-token` holding a token from `devos_private.issue_env_token(text)` (EV-C02-003 §1.6, §6.3).
- `devos_private.high_impact_path(path)`, read at run time: one case per listed path. `devos_private.effect_class` with `name` and `irreversible`: the test plants its two synthetic classes there at owner level inside the rolled-back transaction (DM-37 fills the table by migration and C02 prepares no real effect; nothing is committed).
- Decisions answered at owner level (`devos_private.decision`, `devos_private.decision_revision`; C02 builds no answering function, B:390). Sample streams in `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`); sample reviews in `devos_private.review` (`kind = sample`, naming the target's `id`, one field holding `devos_denetim`).

## Cases
Under one routine work item W, claimed with the working token:
- `N29-pos-admit`, `N29-pos-artifact` (`docs/w07_fixture_note.md`), `N29-pos-operation` (reversible class, same target), `N29-pos-link` (`about` to a routine decision): accepted (the positive: a routine item with no trigger runs without extra gates).
- `N29-art-<path>`, one per row of the path table (a directory entry gets `w07_fixture.txt` appended): refused, naming the impact class; no artifact row.
- `N29-op-path-migrations`, `N29-op-path-claude`: an operation on `supabase/migrations/…` or `.claude/…` → refused.
- `N29-op-irreversible`: an operation of the irreversible class on a docs target → refused.
- `N29-link-high_impact`, `N29-link-depends_on` (a hard `depends_on`), `N29-link-batu`: a link from W to a `high_impact` or `batu` decision → refused.
Other cases:
- `N29-dec-routine-on-high`: a routine decision tied to a high item → refused. `N29-pos-dec-high-on-high`: a `high_impact` one → accepted.
- `N29-mis-open-high_impact`, `N29-mis-open-routine`: `open_mission` (`devos_kurulum` token) on an answered decision below `batu` → refused. `N29-pos-mis-open-batu` → accepted.
- `N29-mis-widen-high_impact`: `revise_mission` widening the scope on a `high_impact` decision → refused, scope unchanged. `N29-pos-mis-widen-batu` → accepted.
- `N29-share-work_routine`, `N29-share-decision_routine`: block size 10.
- `N29-sample-work`: from a block boundary, one complete block of routine items each declaring a trigger only (a recurring cost) → all accepted; exactly one sample review queued for `devos_denetim`. `N29-sample-decision`: the same for routine decisions declaring a schema change.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-N29`: where the database can decide a work item's or decision's impact class, it refuses the routine label; where it cannot, a routine-labelled item reaches the audit environment through the sample. |
| **Failure class rule** | **[Designer's addition: C2 rows give none.]** Any write under a routine label of something the database's records make high-impact (a target on the path table, an irreversible effect class, a link to a `high_impact` or `batu` decision, a routine decision on a high item, a Mission opened or widened below `batu`), and any routine-labelled record that escapes the sample. |
| **Examples** | **[Designer's addition.]** Original finding (C:146's first negative): a routine item whose target is on the list (`N29-art-*`, `N29-op-path-*`). Other manifestations: an irreversible effect (`N29-op-irreversible`), a link (`N29-link-*`), a routine decision on a high item (`N29-dec-routine-on-high`), a Mission below `batu` (`N29-mis-*`), a declared-only trigger (`N29-sample-*`). |
| **Negative control** | Each refusal case: refused, no row in the family's table (`N29-mis-widen-high_impact`: scope unchanged). |
| **Positive control** | `N29-pos-*`: the same calls with a target off the list, a reversible class, a routine decision, a `high_impact` decision on a high item, a `batu` decision for the Mission. Each differs from its negative in the one record the rule reads. |
| **Break attempt** | **[Designer's addition.]** Each patch makes the record the rule reads look like the other class for the length of one call. (1) `breaks/B-N29-1_artifact_target.sql`: red `N29-art-.claude/`, `N29-art-.github/CODEOWNERS`, `N29-art-.github/workflows/`, `N29-art-CLAUDE.md`, `N29-art-methods/`, `N29-art-pipelines/`, `N29-art-supabase/functions/`, `N29-art-supabase/migrations/`. (2) `breaks/B-N29-2_operation.sql`: red `N29-op-path-migrations`, `N29-op-path-claude`, `N29-op-irreversible`. (3) `breaks/B-N29-3_link_to_decision.sql`: red `N29-link-high_impact`, `N29-link-depends_on`, `N29-link-batu`. (4) `breaks/B-N29-4_routine_decision_on_high_item.sql`: red `N29-dec-routine-on-high`. (5) `breaks/B-N29-5_mission_below_batu.sql`: red `N29-mis-open-high_impact`, `N29-mis-open-routine`, `N29-mis-widen-high_impact`. (6) `breaks/B-N29-6_routine_sample_skipped.sql`: red `N29-sample-work`, `N29-sample-decision`. B-N29-1's list follows the path table at `main` (eight paths, `T-W07-DM47`). |
| **Stage and environment** | C02 (the Constraint case is C05's). `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show that a declared trigger is judged rightly in the audit environment (C03 onward), nor that the path table equals plan 6.7's list (`T-W07-DM47`). |
| **Evidence envelope** | README section 4. Fixed before the run: each case's outcome; one refusal per listed path; one sample per complete block of 10. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (Appendix C N29)
| Clause (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Impact class follows the rules (PC-08)" (claim) | all cases | — |
| "A work item labelled routine whose target is on the high-impact path list … is rejected" | `N29-art-*`, `N29-op-path-*`: **tested in the design's form** (DM-48: the database reads the target of the item's Artifact or Operation; B:134) | — |
| "or that prepares an irreversible effect, is rejected" | `N29-op-irreversible` | — |
| "and so is a link from a work item labelled routine to a decision of class `high_impact` or `batu` (PC-42)" | `N29-link-high_impact`, `N29-link-depends_on`, `N29-link-batu` | — |
| "a decision labelled routine on a high-impact work item … [is] rejected" | `N29-dec-routine-on-high` | — |
| "and one below `batu` that opens or widens a Mission, are rejected" | `N29-mis-open-high_impact`, `N29-mis-open-routine`, `N29-mis-widen-high_impact` | — |
| "from C05, where Constraint is activated, one below `batu` that changes a Constraint is rejected" | — | C05 (Appendix C's stage column; W-C02-07 point 2) |
| "a routine-labelled item that only a declared trigger makes high-impact, planted in a run, reaches the audit environment through the sample review" | `N29-sample-work` (and `N29-sample-decision`, W-C02-10 point 3's routine decisions) | — |
| "A routine work item with no trigger is accepted and runs without extra gates" (positive) | `N29-pos-admit`, `N29-pos-artifact`, `N29-pos-operation`, `N29-pos-link` | — |
| Break | `B-N29-1` to `B-N29-6` | — |

## Could not check
COULD NOT CHECK when an object is absent (`N29-pre`), the effect class table lacks `name` or `irreversible`, the path table is empty (`N29-art`), a fixture or claim cannot be made, or a stream cannot be aligned.

## Not covered
The Constraint case (C05); triggers the database cannot read (declared, sampled); whether the audit environment judges the label rightly (C03 onward); `devos`.
