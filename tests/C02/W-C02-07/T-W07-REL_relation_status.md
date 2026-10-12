# T-W07-REL · relate refuses a model-extracted relation recorded as an observation

Synthetic test data (plan Section 8 item 13): four work items made up inside a rolled-back transaction (text `w07_fixture SYNTHETIC W-C02-07`, scope `synthetic.w07fixture`); one synthetic `devos_calisma` token.

**Serves.** W-C02-09 point 6: "✘ `relate` with `method = model_extracted` and `epistemic_status = observation` is refused; ✔ with `model_extracted` and `inference` it is accepted." Appendix B 3.4: "A relation with `method = model_extracted` cannot have `epistemic_status = observation` (PC-16)". Assigned to Group B by the executor (decision 1; GROUPS.md section 5).
**Command.** In `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_rel_relation_status.sql` as `postgres`, and passes only on the notice `W07_REL_RELATION_STATUS PASS`. Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-REL-1_model_extracted_observation.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. Group B's call convention, as T-W07-F04 states it. `devos_api.relate(p jsonb)` (README section 8.1), `p` holding `type`, `from_ref`, `from_revision`, `to_ref`, `to_revision`, `scope`, `hard`, `method` and `epistemic_status`; formerly assumed as `relate(type text, …)`, permitted to `devos_calisma`, taking no claim token. `devos_private.relation` with those columns. `devos_private.work_revision` (`work_id`, `revision`) for the related records.

## Cases
- **REL-a** (the rule's own case): a descriptive relation (`about`), `model_extracted`, `observation`. Refused: no relation row, no event, nothing stored for the pair.
- **REL-b**: a hard dependency (`depends_on`, `hard` true) with the same pair. Refused the same way. This takes `relate`'s other branch, the lock and cycle check of DM-01.
- **REL-pos**: REL-a with `inference`. Accepted: one row more, at least one event.
- **REL-pos2**: REL-a with `method = recorded` and `observation`. Accepted, so the rule is not a ban on observations.
- **REL-pre**: `could_not_check` when an object is absent.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-REL. A relation a model extracted can never be recorded with the status of an observation, on either branch of `relate`; the same relation as an inference, or an observation recorded by a call, is accepted. |
| **Failure class rule** | **[Designer's addition: no Appendix C entry]** A relation recorded with an epistemic status stronger than its method supports: `model_extracted` stored as `observation`, by any path that writes a relation. |
| **Examples** | **[Designer's addition]** The original, B 3.4's case: REL-a. Another manifestation: the same pair on the hard-dependency branch, REL-b. |
| **Negative control** | REL-a and REL-b are refused: no row, no event, and nothing stored for the pair. |
| **Positive control** | REL-pos differs from REL-a only in the status, REL-pos2 only in the method. |
| **Break attempt** | **B-REL-1** (`breaks/B-REL-1_model_extracted_observation.sql`) removes the rule wherever it sits. It drops the check constraints and disables the triggers on `relation` that name `model_extracted`, and wraps `relate` so that the pair is written as `inference` and then set to `observation`. Must turn red: **REL-a, REL-b**. |
| **Stage and environment** | C02. `devos-test`, the migration job's test step, with a synthetic `devos_calisma` token. The break runs on the throwaway database. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-09's producer at its head, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural. It does not show that a relation declared `recorded` really was recorded by a call (a declaration, sampled). |
| **Evidence envelope** | README 4's fields. Values fixed before the run: the cases' outcomes and the break's red cases. |

## Could not check
The test gives COULD NOT CHECK when `relation`, `event`, `work_revision`, `relate` or `issue_env_token` is absent, or when the fixtures cannot be made. A case gives `could_not_check` when its call cannot be formed (for example, if `relate` takes a claim token). Before the build exists the test gives COULD NOT CHECK.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-REL-1 turns red exactly REL-a, REL-b, with the file ending in FAIL; the restore passes. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- Relations the ledger transfer writes (W-C02-06's path): T-W07-REL covers `relate` only.
- The C04 ingestion's extracted relations (`devos_ingest`).
