---
id: EV-C02-012
item: W-C02-08
kind: build
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (points 1 and 3 to 8, report 2026-10-14T17:05Z, on db9ef6d); completed by a second fresh-context producer of the same session on 178468b (point 9, the copies, the runs and this record)"
main_at: 178468b14e76a423823a0ac0b2443c5044b43be8
date: 2026-10-14
claim: "the schema, role classes and access rules of W-C02-08, with the ledger transfer's schema S1 to S4, as versioned SQL; offline runs on PostgreSQL 16.15 are supporting evidence, not counted results; nothing applied to a project"
---

# EV-C02-012 · Schema, role classes and access rules (W-C02-08; C02 tasks 1 and 4): the build

**What this is.** The producers' record of W-C02-08's build at `main` `178468b`: six migrations under `supabase/migrations/`, the byte-for-byte copies of the three staged tests this item completes, and offline runs. It is not a verdict. Every offline run here is **PostgreSQL 16 supporting evidence, not a counted result**: the counted runs are the migration job's, in `devos-test`, after the executor's commit (W-C02-03's order), and `devos` after the merge. This record names each part that waits for them.

**Labels.** **O** observed in this record's offline run (raw output named, section 10); **Doc** read from the source named, at `main_at`; **Inf** inference. B = `plan/Ek_B_Veri_Modeli.md`; EV2 = EV-C02-002 (W-C02-04); EV3 = EV-C02-003 (W-C02-05); EV4 = EV-C02-004; EV5 = EV-C02-005 (W-C02-06); EV8 = EV-C02-008; README = `tests/C02/W-C02-07/README.md`; SCH = `tests/C02/W-C02-14/T-W14-SCH_transfer_schema.md`. M1 to M6 are the six migrations:

| | File (`supabase/migrations/`) | Holds |
|---|---|---|
| M1 | `20261014170201_w08_role_classes_epoch_tokens.sql` | the role-class type, the global authority epoch, `env_tokens` |
| M2 | `20261014170202_w08_event_rejected_attempt.sql` | Event, RejectedAttempt |
| M3 | `20261014170203_w08_missions_decisions_needs_work.sql` | Decision, Mission, Need, Work with WorkStanding, EffortPolicy, Relation, Assignment |
| M4 | `20261014170204_w08_findings_reviews_effects_exams.sql` | Finding, Artifact, Review, Verdict, Acceptance, the effect classes, Operation, Observation, EvalRun, LeakFingerprint |
| M5 | `20261014170205_w08_append_only_views_access.sql` | append-only triggers, the current views, the access rules |
| M6 | `20261014182601_w08_ledger_transfer_schema.sql` | point 9: the ledger transfer's schema S1 to S4 (section 9) |

Every version is later than `20261012232113` (the latest on `main`); M6 is later than M5. Every first line says "DevOS schema (W-C02-08), not a fixture". M2, M3 and M4 say in comments that the transfer's objects wait for point 9; M6 builds them, and its header says so.

## Evidence envelope (plan Section 8 item 9; B 3.15)

| Field | Value |
|---|---|
| Source commit | Base `main` `178468b14e76a423823a0ac0b2443c5044b43be8` (PR #342). The build is uncommitted at this record's writing; its head SHA, once the executor commits, is the one the verdicts judge |
| Deployment configuration | Offline only. (a) One throwaway PostgreSQL 16.15 cluster (`PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)`), unix socket only, in a user namespace, with labelled stand-ins for Supabase's `anon`, `authenticated`, `service_role`, `authenticator` (granted the three, NOINHERIT), `auth.users` and `supabase_migrations.schema_migrations`; migrations applied as the superuser `postgres` with `--single-transaction`. (b) W-C02-07's break harness's own clusters (PostgreSQL 16.15), where the migrations run as a non-superuser `postgres`, without `--single-transaction`. The projects run PostgreSQL 17.6 (EV2 front matter): these runs observe neither project. No project was reached; the read-only connector was not used |
| Criterion version | W-C02-08's acceptance block at `main_at` (last changed in `c818e944f432b417be4644e72c1fa66cfe0fe8e5`, point 6 as N-267 amended it, merged in `178468b`). W-C02-07's tests: merged in `68070993cebf76a2433256b6180c7dfc80889501` (PR #313); T-W07-5A's files last changed in `3e814829e0a04c0552231a7a8ffdb189f148b009`, before that merge; T-W07-DM02 revised under ledger rule 3 in `6b2dedba7f612ed78831c36ca814e9ad9444de4a` (its specification's writer filled in `c818e94`), merged in `178468b`. W-C02-14's T-W14-SCH: written in `6b2dedb`, revised before any result in `c818e94` (CHK-C02-066 C2, C3), merged in `178468b` (CHK-C02-066, CHK-C02-067) |
| Input | The ten migrations at the build's working tree; the six files of `supabase/migrations/tests/` (three of W-C02-03's, three copies); the break patches B-SCH-1 to B-SCH-9, B-5A-1, B-DM02-1 |
| Observation | Sections 1, 4, 6 and 9 |
| Raw evidence | Filed by the executor, verbatim, in `evidence/C02/raw/EV-C02-012_offline_runs_20261014/` (`01_init.txt` to `10_stop.txt` and `11_scan.txt`; section 10), copied from the producer's scratch directory `…/scratchpad/prd08b_raw/`. The first producer's exploratory outputs (`…/scratchpad/prd08_raw/`) are not filed: they are never counted. Synthetic: no token exists or was issued (no issuing function exists yet), and the outputs hold no credential |
| Independence level | The producers; not a verdict |

**The first producer's offline runs** (`…/scratchpad/prd08_raw/`, 2026-10-14, at `db9ef6d`) were made before N-267's amendment of point 6 merged, and on the test files as they were before DM02's revision. They are **exploratory only** (Appendix G G8 item 3: "the old result remains exploratory in nature and the new criterion is tested with new evidence"; log entry L-329, "Departure, recorded") and are never counted. DM02's revision also voids them for that test (its specification, "Earlier results"). Every run this record reports is new, at `178468b`, on the amended criterion and the revised files.

## 1. Point 1: only through the migration path, `devos-test` first

**What the build does.** Every object of this item is created by M1 to M6, plain SQL with no `psql` meta-command, applied in version order after `main`'s four migrations. Nothing else creates an object: no dashboard step, no hand-run command.

**Offline (PostgreSQL 16 supporting evidence, not counted).** O, `03_apply.txt`: each of the ten files applied with `psql -X -v ON_ERROR_STOP=1 --single-transaction -f supabase/migrations/<file>`, each `[exit 0]`, each followed by its history row (`[exit 0]`); `[drive apply exit 0]`. The harness's clusters applied the same ten files again for each of its 33 phases, as a non-superuser, without a failure (O, `08_harness_breaks.txt`: every phase reports its files). O, `04_drift.txt`: `expected` built as `migrate.yml`'s step builds it (top-level `<version>_<name>.sql` files, `functions: []` since `supabase/functions/` does not exist), then `devos_api.deployment_drift(expected)` as `postgres` returned `{"commit": "178468b…", "status": "no_difference", "compared": {"functions_expected": 0, "functions_recorded": 0, "migrations_applied": 10, "migrations_expected": 10}, "complete": true, "differences": []}`. No migration writes `devos_private.function_deployment`.

**One form to watch in the job** (Inf): the job applies with `supabase db push`, not with `psql`. M6's `alter type … add value 'declined'` runs inside a transaction on PostgreSQL 12 and later, and no statement of M6 or of a later file in the same push uses the value, so the CLI's transaction per file does not matter; the job's run shows it.

**Only the live runs can show:** the job's runs in `devos-test` and then `devos`, with their times; `deployment_drift`'s result after each apply; the ✘ look at each project's record of applied migrations and catalog listing. Those are verdict (i)'s `devos-test` part and verdict (ii)'s.

## 2. Point 2: decisions followed

**Plan changes these decisions make, all merged and accepted at `main_at`** (Doc, front matter of each): PC-40 (CHK-C02-007), PC-41 (CHK-C02-013), PC-42 (CHK-C02-009), PC-43 (CHK-C02-014), PC-44 (CHK-C02-024; the transfer's places 5, 8 and 9, which S3 and S4 rest on), PC-45 (CHK-C02-018), PC-46 (CHK-C02-026), PC-47 (CHK-C02-037), PC-48 (CHK-C02-031), PC-49 (CHK-C02-056). PC-50 is `proposed`; it changes the working order's guard description (N-270) and nothing this item relies on. N-136's plan text (EV-C01-004 section 8 item 2, `devos_kurulum`'s "Cannot") is in B section 2's `devos_kurulum` row (PC-43 place 5). No part of this build waits on an unmerged plan change.

| Decision | Object that carries it | Where | Catalog query or test that shows it |
|---|---|---|---|
| B section 2; EV3 §1.1, §1.2 (e): a role class is a token's value, not a database role | type `devos_private.role_class` (six values); no `devos_*` database role, no login role, no password | M1:10 | `pg_enum` listing (`06_catalog_full.txt`); T-W07-5A's `5A-roles` |
| EV2 DM-01; EV4 X-02: the global authority epoch, one row | `devos_private.global_authority_epoch` (singleton key, `epoch` 1) | M1:17, M1:22 | `select * from devos_private.global_authority_epoch` → one row, epoch 1 (`06_catalog_full.txt`) |
| B 3.27; EV3 §1.4, §1.7; PC-43 place 7 | `devos_private.env_tokens` (SHA-256 hex hash only, no `authority_epoch`) | M1:29 | column listing; 0 rows |
| B 3.13; EV2 DM-31 | `devos_private.event` (`role_class` from the token or `owner`; `origin` call/rule/owner/job) | M2:13 | column listing; check `event_role_class_check` (`06_catalog_point9.txt`) |
| EV2 DM-19; EV4 X-04 to X-06 | `rejected_attempt`, check `rejected_attempt_form`, index `rejected_attempt_counted_key` | M2:35, M2:55 | `pg_get_indexdef`, `pg_get_constraintdef` (`06_catalog_full.txt`) |
| EV2 DM-02: identity row plus an append-only revision table; current form a view | the five `*`/`*_revision` pairs; triggers `*_append_only`, `*_no_truncate`; views `*_current` | M3, M4, M5:10 to M5:76; M6:54 (`finding_current` made again) | T-W07-DM02 (21/21, section 6); `pg_trigger` listing (12 triggers) |
| EV2 DM-09 | `effort_policy`; `work.execution`, `qualification`, `acceptance`, `effect` | M3:108, M3:120 | column listing |
| B 3.5; EV2 DM-01: one active claim per work item | partial unique index `assignment_one_active_claim` | M3:214 | `pg_get_indexdef` (`06_catalog_full.txt`) |
| EV3 §4.3 (S8 line 2) | `assignment.role_class` | M3:198 | column listing |
| B 3.4; PC-16 place 13 | `relation.method`, `relation.epistemic_status` (B 3.4's values exactly); check `relation_model_extracted_not_observation` | M3:169, M3:187 | enum listing (`06_catalog_full.txt`) |
| EV2 DM-24: the exam link only in EvalRun | `eval_run.work_ref` + `work_revision` | M4:156 | column listing of `work` and `work_revision` |
| EV2 DM-12, DM-25, DM-26, DM-34 | `finding_revision.agent_addressed`, `finding.privacy_class`, `finding_revision.changeable`, `source_spans`; `scope` with the dotted-path check | M3, M4, M6:50 to M6:53 | column listing |
| EV2 DM-37 | `effect_class`; `operation.effect_class` references it | M4:114, M4:125 | column listing |
| EV2 DM-17 | `leak_fingerprint`, check `leak_fingerprint_library_source` | M4:174 | column listing |
| EV2 DM-45, DM-46 | `work_revision.mandatory_needs`; `decision_revision.alternatives_state` | M3 | column listing |
| B principle 1; EV3 §4.1 last row | M5's revokes; no grant on `devos_private`; M6's revoke on the view it makes again | M5:83 to M5:106; M6:68 to M6:78 | T-W07-5A (168/168, section 6); `relacl`, `nspacl`, `proacl`, `pg_default_acl` (`06_catalog_full.txt`, `06_catalog_point9.txt`) |
| EV5 section 15 S1 to S4; PC-44 places 5, 8, 9 (LT-31, decided) | M6's check, two indexes, enum value and enum type | M6 | section 9's table; T-W14-SCH (38/38, section 9) |

**Departures: none silent.** The choices of form that are the producers', each stated where it applies: the Mission reference of a work revision (section 3, "Work"); the identity columns' kind (section 4); and in point 9, the payload rule's layer, the form of `changeable`, the strictness of `transfer_source`'s fields and the reading of S4's Artifact and Acceptance values (section 9, "Choices"). The last is a reading of EV5's text that a checker may judge a departure under point 2; section 9 states it for that judgment.

## 3. Point 3: families, fields and objects (task 1)

Each family whose activation stage is C02 (B section 3's table), field by field against B section 3 as PC-42 to PC-47 left it. "=" means the field is there under B's name. A difference is named with the decision that explains it. "Function" means a rule that a W-C02-09 or W-C02-10 function applies, not a table field. O, `06_catalog_full.txt` and `06_catalog_point9.txt` hold the listing.

- **Mission (3.1).** `id` =; `revision` = (`mission_revision`); `purpose`, `scope`, `acceptance`, `owner_authority` = (`owner_authority` references `decision(id)`: an answered decision gets no new revision, DM-11, so the decision names its answered revision); `constraints` = as a JSON list (Constraint is C05's); `status` = on the identity row (DM-02). Added: `reason` on the revision (B principle 3), `created_at`. "Opened or widened only by Batu's decision" is a function's (DM-23; W-C02-09, W-C02-10 point 4).
- **Need (3.2).** All B fields =, under B's names (`mission_ref` references `mission(id)`). Need has no `revision` in B, so no revision table. Inquiry: a Need in `investigating` (activation table).
- **Work and WorkStanding (3.3).** `id`, `revision`, `scope`, `purpose`, `input_refs`, `target_refs`, `consumer`, `return_to`, `stop_rule`, `acceptance_ref`, `impact_class`, `effort_policy_ref`, `method_refs`, `mandatory_needs` =; the four WorkStanding axes on `work` with B's values (DM-09). **Difference:** `mission_ref` and `mission_revision` are carried by one column, `work_revision.mission_revision_id`, a foreign key to the Mission revision row; `devos_private.work_current` shows both under B's names. Reason: DM-02 (a) makes a reference to a revision a foreign key to the revision table; one column does that, and it is the form W-C02-07's fixture helper can plant (`w07_plant` plants a parent only for a single-column foreign key; README 8.1). A composite key `(mission_ref, mission_revision)` would meet DM-02 equally and would leave every such plant "could not check" until the test designer revised the helper. D2: the tests' form was a factor, named here. Not built here: the database copy of the high-impact path list (DM-47), W-C02-10 point 4's, and the sample streams' table (DM-08), W-C02-10 point 3's.
- **Relation (3.4).** All fields =, `from_ref`+`from_revision` and `to_ref`+`to_revision` (README 8.1's names); `method` and `epistemic_status` with exactly B 3.4's values; "model_extracted cannot be observation" is also a table check. **Difference:** the type `informed_of` is not in the type list: B 3.4 says its own fields "are built when `informed_of` is first needed (C06)". No uniqueness index for "an exact repeat produces no new record": that is `relate`'s (W-C02-09).
- **Assignment (3.5).** All fields =; `work_ref`+`work_revision` reference `work_revision(work_id, revision)`; the one-active-claim index; `unique (work_ref, generation)`; `claim_token_hash` SHA-256 hex (EV3 §1.7). Added `created_at`.
- **Finding (3.8).** All fields =; `status`, `scope` and `privacy_class` on the identity row, the rest on `finding_revision`. `changeable` is the value set `yes` / `no` / `not_recorded` (type `devos_private.finding_changeable`, M6:50; EV5 S4; B 3.8 as PC-44 place 5 gives it); `counter_evidence_searched` is text, so `not_recorded` is one of its values. The rule that admits `not_recorded` only on a transferred row is the format gate's, W-C02-10's (B 3.8; EV5 "Interfaces assumed").
- **Artifact (3.10).** All fields = (`path`, `commit`, `kind` on the revision; `scope`, `status` on the identity row). `kind` is free text: B 3.10 gives it no list; EV5 S4's `git_file` and `git_tree` are admitted (section 9).
- **Review, Verdict, Acceptance (3.11).** All fields =, with `target_ref` (+ `target_revision` or `target_snapshot`) and `criterion` as `criterion_ref` + `criterion_version` (README 8.1's plants). `reviewer_role_class` and `independence_level` nullable: the sample the database opens has no reviewer (B 3.11; EV8 section 2). `accepted_use` is free text: B 3.11 gives it no list; EV5 S4's `installation_acceptance` is admitted (section 9). The sample's own rules and DM-41 are W-C02-10's.
- **Operation and Observation (3.12).** All fields =; `unique (idempotency_namespace, idempotency_key)`; `effect_class` references the effect-class table (DM-37). Observation is append-only (B 3.12; M5). DM-28's "never deleted" holds by no function deleting and no role holding a privilege; no trigger is added for it.
- **Event (3.13).** All fields =; `tx_id` is `xid8` from `pg_current_xact_id()`. The transfer's events (B 3.13, "The ledger transfer's events"): the payload rule, the at-most-one hand-over and the idempotency key are M6's (section 9). RejectedAttempt (3.13, activated C02 by PC-42): all fields =, with DM-19's two forms as a check and its unique index.
- **EvalRun (3.15).** All fields =, `work_ref`+`work_revision` with a foreign key to the work revision (DM-24). The grader's fields are C05's (DM-14). No direct read or write by any role (section 4).
- **Decision (3.17).** All fields =: `class`, `status` and the answer fields on the identity row, the question's text and gate fields on `decision_revision`. `status` has B 3.17's seven values in B's order, `declined` among them (M6:43; PC-44 place 8).
- **EffortPolicy (3.18).** All fields =; `approved_by_role_class` can only be `devos_denetim`; a check that a policy is either an item's (`work_ref`) or a standing one (`work_class`). The transferred policies' step-set exception is the format gate's, W-C02-10's.
- **LeakFingerprint (3.23).** All fields =; no content column.
- **EnvToken (3.27).** All fields =, no `authority_epoch` (PC-43 place 7).

**✘ Deferred families not built** (O, `06_catalog_point9.txt`, every relation of `devos_private` and `devos_api`: 27 tables and 5 views, all of the families above plus W-C02-03's `function_deployment`): no Grant, Request, Contribution, ContextRequest, ContextPackage, DispatchReceipt, Premise, TaskDefinition, UseReceipt, Source, Chunk, Assembly, Release, Competence, UserModel, Constraint, DeadEnd, Learning, Budget, Usage, Recovery, SessionRecord, LaunchRecord, ProtocolAudit, FrameReview or MechanismAssumption table, and no progress or hand-over table for the transfer (EV5 section 15). W-C02-04 brings none forward (EV2 section 3); EV3 §4.4 keeps SessionRecord in C04.

**Objects of R1 section 1 (f)** (`evidence/C02/raw/W-C02-01_source_map_R1_appendix_B.md`): the schemas (from the first migration; closed here, section 4); the global authority epoch (M1); the one-active-claim constraint (M3); the rejected-attempt record (M2). Left to their items: the sample share and its table (W-C02-10 point 3), the `format_gate` label (W-C02-10 point 2), the high-impact path list's database copy (W-C02-10 point 4). The probe schema's removal: nothing to remove (EV2 DM-32).

## 4. Point 4: no role can write directly to the tables

**What the build does** (M5:77 to M5:106; M6:68 to M6:78). `revoke all` on the schema `devos_private`, on all its tables, sequences and functions, from PUBLIC and from `anon`, `authenticated`, `authenticator` and `service_role` where each exists; `revoke all on schema devos_api` from the same, then `grant usage on schema devos_api to anon` only (README 8.1). Nothing is granted on any `devos_private` object. M6 drops and makes again the view `finding_current` (section 9) and applies the same revokes to it. M6 adds no table, view in `devos_api`, sequence or function. No role class is a database role (EV3 §1.1), so "every login role created for a role class" is the empty set. Reads granted by name: none (EV3 §4.1 grants every read through a function), so no read reaches EvalRun directly, `devos_sinav`'s included.

The identity columns of `event`, `rejected_attempt` and `leak_fingerprint` are `generated by default`, so that a direct write is refused by the privilege check, not first by the identity rule (SQLSTATE 428C9), which is what T-W07-5A measures (the first producer's finding under B-5A-1).

**Offline (PostgreSQL 16 supporting evidence, not counted).** O, `05_dbtests.txt`: `W07_5A_NO_DIRECT_WRITES PASS (168/168)` (27 tables × 3 roles × write and read, plus `5A-snap`, `5A-roles`, `5A-cat-api`, `5A-cat-priv`, `5A-cat-default`, `5A-cat-grantees`); `5A-cat-exposed-db` did not run (no `pgrst.db_schemas` setting offline). O, `06_catalog_point9.txt`: `finding_current` `relacl` `{postgres=arwdDxt/postgres}`; 35 relations with ACL entries (the revokes write them), none held by PUBLIC or an application role (`5A-cat-priv`, `5A-cat-grantees`); `pg_default_acl` 0 rows; functions `deployment_drift` and `refuse_change` only. O, `08_harness_breaks.txt`: B-5A-1 through W-C02-07's harness: "shown", red exactly `5A-cat-grantees`, `5A-cat-priv`, `5A-w:anon:event`, positive control and restore PASS.

**Only the live runs can show:** the same test in `devos-test` against Supabase's real roles (their memberships, any default privileges Supabase's own roles hold, which no migration can remove: Inf); `5A-cat-exposed-db` where Supabase stores the setting, and part B (`w07_5a_exposed_schema.py`), W-C02-09's copy once the publishable key is stored (README 5.1 (c)); `devos`. The positive control (`w07_5a_positive_control.sql`, `relate`) is W-C02-09's (point 4).

## 5. Point 5: role classes and their limits

The classes exist as the six values of `devos_private.role_class` (M1:10), the line under B's activation table as EV3 gives it: `devos_calisma`, `devos_denetim`, `devos_sinav` (C02); `devos_backup`, `devos_ci` (C02, for C03); `devos_kurulum` (the installation). `devos_ingest` is not there: W-C02-04 does not bring it forward (DM-21, C04). What each can and cannot do is EV3 §4.1's matrix, with EV8 1.2 and 1.7's added rows; the functions' role lists (W-C02-09, W-C02-10) follow it (B section 2):

| Class | Can | Cannot |
|---|---|---|
| `devos_calisma` | open work other than missions, need and decision records, claim, contributions, candidates, products, findings, external-effect intents | binding verdicts, acceptance, release activation, approving rule changes, reading exam records, `revoke_claim` |
| `devos_denetim` | reviews, verdicts, acceptance, review of rule and control changes, high-impact merge approval, effort-reduction approval and standing policies, `revoke_claim`, reading RejectedAttempt | writing products and candidates, reading exam records |
| `devos_sinav` | exam tasks as ordinary work, EvalRun and Competence writes, reading EvalRun | writing products or verdicts |
| `devos_ci` | reading verdicts, decisions, current authority and epoch, fingerprint matches; recording its own checks' results; `deployment_drift` | writing verdicts or decisions; exam records |
| `devos_backup` | read only, for the export; `mark_exported` | every other write |
| `devos_kurulum` | installation operations: the ledger transfer (S5's functions, W-C02-09), then the installation's own records; `open_mission`/`revise_mission` on an answered or accepted `batu` decision until C06; the transfer's copies of checker verdicts and acceptances until C03 | (EV-C01-004 S8 line 1, verbatim) "exam records and the audit environment's binding rights: verdicts, acceptance, version activation and approving rule changes"; also issuing tokens, reading RejectedAttempt, any verdict or acceptance other than the transfer's copies (EV3 §4.2) |

`devos_kurulum`'s rights kept before C03, and when each ends (EV3 §4.2): the transfer's verdict and acceptance copies, at C03's hand-over of binding review (N-222); Mission opening, when C06 builds `answer_decision`'s path; installation operations, at C12. No class writes any table directly (section 4). The checks themselves are shown with W-C02-09 and W-C02-10.

## 6. Point 6: W-C02-07's tests (and, by point 9, W-C02-14's)

**Assigned to this item** (README 5.1 (c)'s table "Copied by": W-C02-08): `w07_5a_no_direct_writes.sql` and `w07_dm02_revision_append_only.sql`. **Listed with later items, not counted here:** `w07_5a_positive_control.sql` and `w07_5a_exposed_schema.py` (W-C02-09; the latter also needs the publishable key, sitting A); `w07_idc_identity_chain.sql` (the pull request of the identity chain's first part, N-221 step 2: its pre-check needs `caller_role_class`, `issue_env_token` and `revoke_env_token`, which this item does not build); every other staged file, the item README 5.1 (c) names. Point 9 applies point 6 to T-W14-SCH, so its staged file is copied too (section 9).

**(a) The copies** (O; `09_git_diff_tests.txt`, and the commands below): each made with `cp` from the staged file at this head, `tests/` unchanged from `178468b`.

| Copy (`supabase/migrations/tests/`) | Its staged file | SHA-256 of the copy | SHA-256 of the staged file on `main` |
|---|---|---|---|
| `w07_5a_no_direct_writes.sql` | `tests/C02/W-C02-07/job/w07_5a_no_direct_writes.sql` | `522238f1ce7ec589d316d64c1686c83464fcc48aa076e1daae53711438429480` | the same, at `178468b` and at W-C02-07's merge `6807099` (`git show <commit>:<path> \| sha256sum`) |
| `w07_dm02_revision_append_only.sql` | `tests/C02/W-C02-07/job/w07_dm02_revision_append_only.sql` | `28d47118286349d3e671aaf6cc6451faca7f41b48c4f5bcdfe13e15cfde278fe` | the same, at `178468b` and at its ledger-rule-3 revision `6b2dedb` (at `6807099` it was `b22fb4bb…07a7ec`, the bytes the first producer copied; that copy is replaced) |
| `w14_sch_transfer_schema.sql` | `tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql` | `70114d20c363c5e299736be18e6ab4275f284e048fb817ddae4f15f0cfe711ce` | the same, at `178468b` and at its last change `c818e94` (the revision before any result for CHK-C02-066 C2, C3; at `6b2dedb` it was `db509730…0404a`) |

**(b)** The migration job runs every `supabase/migrations/tests/*.sql`, so it runs these three copies with W-C02-03's three files (README 5.1 (c), "The gate").

**(c)** Each copy's SHA-256 equals its staged file's on `main`: for 5A at W-C02-07's merge commit, for DM02 and T-W14-SCH at the commit of their revision (DM02: ledger rule 3; T-W14-SCH: before any result, then merged).

**(d) `git diff` of the tests' files from W-C02-07's merge commit to this head** (O, `09_git_diff_tests.txt`), read as point 6 (d) now reads: their files, their specifications and breaks, and the staged paths among them. `git diff --stat 6807099 178468b` over T-W07-5A's specification, staged file and break, and T-W07-DM02's specification, staged file and break: two files change, `T-W07-DM02_revision_append_only.md` and `job/w07_dm02_revision_append_only.sql`; T-W07-5A's three files and `B-DM02-1` are unchanged. The commits: `6b2dedb` and `c818e94`. `git diff --stat 178468b -- tests/` against this build's working tree is empty: the build changes no test file. Each change, named:
- **T-W07-DM02, revised under ledger rule 3 by the executor's test designer** (agent `a033d27a36478231f`; commit `6b2dedb`, its specification's writer filled in `c818e94`; merged in `178468b`, PR #342, judged by CHK-C02-066 and CHK-C02-067; L-329). The `-trunc` case adds a second attempt in which the user triggers of every other table the cascade reaches are disabled, so only the table's own rule can refuse; no case ID changed and none was removed; B-DM02-1 is unchanged. **Its earlier results are void** (its specification, "Earlier results"): the only earlier runs were the first producer's uncounted offline runs.
- The other W-C02-07 files changed in the same span (`T-W07-F04`, `T-W07-K05` and their staged files; ledger rule 3, L-329) are W-C02-09's tests, not this item's.

**Offline runs at this head (PostgreSQL 16 supporting evidence, not counted).** O, `05_dbtests.txt`: the runner of `migrate.yml`'s test step, reproduced in `prd08b_run/drive.py` (copied from the first producer's), ran every `supabase/migrations/tests/*.sql` in name order with `psql -X -v ON_ERROR_STOP=1 -f`; each "passed", exit 0:
- `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`
- `W03_DRIFT_DETECTS PASS (10/10)`
- `W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)`
- `W07_5A_NO_DIRECT_WRITES PASS (168/168)`
- `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`; the list was `artifact_revision, decision_revision, finding_revision, mission_revision, work_revision`; each `-trunc` refused in both attempts, the second with the user triggers of 0 (artifact, decision, finding), 5 (mission) and 4 (work) other tables disabled
- `W14_SCH_TRANSFER_SCHEMA PASS (38/38)` (section 9)

O, `07_static_programs.txt`: `python3 -I tests/C02/W-C02-03/test_workflow_order.py` gave `W03_ORDER_TEST PASS`, `W03_RUN_EXPR_TEST PASS`, `W03_PR_INPUTS_TEST PASS (21/21 …)`, exit 0; `test_decision_steps.py` gave `W03_DECISION_TEST PASS (69/69)`, exit 0; `test_workflow_guards.py` gave `W03_RUN_EXPR_TEST PASS` and `W03_PR_INPUTS_TEST PASS (21/21 cases; breaks: 6 shown, 0 not shown, of 6)`, exit 0.

**Breaks through W-C02-07's harness (PostgreSQL 16 self-check, not W-C02-13's run, which counts only on PostgreSQL 17).** O, `08_harness_breaks.txt`: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --pg-bin /usr/lib/postgresql/16/bin --workdir <scratch> --patch <each>`, eleven patches, `HARNESS PASS (11/11 breaks shown)`, exit 0; every line says `counts: no: self-check on 16.15 …, not the projects' 17`. B-5A-1: section 4. **B-DM02-1: "shown"**, red exactly `DM02-work_revision-del`, `-trunc`, `-upd`; positive control and restore PASS. The revision closes the first producer's finding (the `-trunc` case stayed green under the break because `observation`'s own trigger refused the cascade).

**Only the live runs can show:** the three copies passing in `devos-test` in the migration job's step, with the job's raw output filed (verdict (i)). Until then point 6 is "could not check" there, never a pass.

## 7. Point 7: data and evidence

The offline fixtures are those the test files make inside their own rolled-back transactions (synthetic, labelled `w07_fixture SYNTHETIC W-C02-07` and `w14_fixture SYNTHETIC W-C02-14`), and the harness's, in clusters it deletes. The stand-ins are labelled in `prd08b_run/setup.sql`. No row was committed beyond the epoch row and the stand-ins' history rows. No token was issued, so the outputs hold no token, hash or key; this record holds none either. O, `11_scan.txt`: `python3 -I tools/credential_value_scan.py --dir` over `supabase/migrations/` (16 files), `evidence/C02/` with this record (288 files), `prd08b_raw/` and `prd08b_run/`: for both values the session holds, "0 files hold it" in every directory, `CREDENTIAL_VALUE_SCAN DONE`, exit 0. It searches the session's own credential values only, not every form of secret. The envelope is above.

## 8. Point 8: parameters

This item sets no parameter that sets when dependent work can next start. The lease (30 minutes, DM-07) is W-C02-09's claim functions'; the sample block (10, DM-08) is W-C02-10's. The initial epoch value 1 is a starting count, not a time.

**The wait point 9 added on the critical path** (plan 6.12 item 1; PC-23): **about 1.5 hours**, from the first producer's report at 2026-10-14T17:05Z (points 1 and 3 to 8 built; point 9 held because its tests were not merged) to the merge of PR #342 at 2026-10-14T18:19:48Z (`178468b`), which brought T-W14-SCH to `main`; this producer's work on the transfer schema started after that merge. Its reason's source: W-C02-08 point 9's ✘ "The part of them that judges this schema is merged before this item's work on that schema starts, so that git order shows it came first" (in the item's block since the work list's revision `0c234aa`, 2026-10-12T14:20Z; LG rule 3, tests before the build). It is the builder's rule, not a reason taken from a decision of Batu's; checked against his decisions answered after that commit, by their titles (D-033 to D-038, answered 2026-10-12T19:50Z to 2026-10-14T16:33Z: the reading of his words, the session mode, model and effort, plan 0.3's "different tool", the label narrowing, T-W03-08's fixture branches): none changes when a build may start against its tests. What would have ended it sooner at the same quality: the tests written and merged before the build's task was given (L-329's "Departure, recorded": the executor did not read N-267's deadline before giving the task); the executor's call. L-329 records the same wait.

## 9. Point 9: the ledger transfer's own schema

**The design** (EV5 section 15, decided, LT-31; PC-44 accepted): S1 the event types and the `transferred` payload; S2 the idempotency index; S3 Decision's status `declined`; S4 value sets; S5 the functions. "No progress table and no hand-over table: the progress record is S1's `transfer_run` and `transferred` events with S2's index; the hand-over record is S1's `ledger_handed_over` event."

**Git order** (O, `09_git_diff_tests.txt`): T-W14-SCH, the part of W-C02-14 point 13's tests that judges this schema, was written in `6b2dedb` (17:36Z), revised in `c818e94` (18:07Z) and merged in `178468b` (18:19:48Z). M6 was written after that merge (its version, `20261014182601`, is the time this producer started it). Its files are unchanged since their merge: `git diff --stat 178468b -- tests/` is empty.

**Each object EV5 gives, its carrier, and what shows it.** Catalog: O, `06_catalog_point9.txt`. Test: T-W14-SCH's copy, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)` (O, `05_dbtests.txt`); its breaks: O, `08_harness_breaks.txt`.

| EV5 | Object | Carrier | Catalog query | T-W14-SCH cases (all `ok`) | Break (harness, PG 16 self-check) |
|---|---|---|---|---|---|
| S1 | The event types `transferred`, `transfer_run`, `ledger_handed_over`, `ledger_entry`, `note_line`, `record_line`, `usage_reading`, `batu_step`, `ledger_state_row` | values of `event.event_type`, admitted by its form check `event_event_type_check` (`^[a-z][a-z0-9_]*$`, M2:19); no list (choice (1) below) | `pg_constraint` on `event` | SCH-S1-type-* (nine), `transfer_run` with every `phase` and `mode` | B-SCH-9 shown (red SCH-S1-type-batu_step) |
| S1 | A `transferred` event's `transfer_source` required: an object with `kind`, `source_id`, `path`, `input_commit` (40 hexadecimal characters), `last_commit`, `sha256` | check `event_transferred_transfer_source` (M6:17) | its `pg_get_constraintdef` | SCH-S1-nosrc, -miss-* (six), -commit, -null-kind, -null-source_id, -commit-nonhex (both attempts), -commit-null, -src-array | B-SCH-2 shown (red its 13 cases) |
| S1 | At most one `ledger_handed_over` event: the hand-over record | unique partial index `event_one_ledger_handover` on `(event_type) where event_type = 'ledger_handed_over'` (M6:30) | `pg_index`: `indisunique t`, `indisvalid t`, predicate `(event_type = 'ledger_handed_over'::text)` | SCH-S1-type-ledger_handed_over, SCH-S1-handover-two ("such events before 1, after 1") | B-SCH-3 shown |
| S1 | The progress record: `transfer_run` and `transferred` events | the types above; no table (EV5) | relation listing: no progress table | SCH-S1-type-transfer_run, -transferred | (as above) |
| S2 | The idempotency key: unique on (`payload->'transfer_source'->>'kind'`, `payload->'transfer_source'->>'source_id'`) where `event_type = 'transferred'` | unique partial index `event_transferred_key` (M6:36) | `pg_index`: `indisunique t`, `indisvalid t`, `indnatts 2`, the two expressions, predicate `(event_type = 'transferred'::text)` | SCH-S2-dup-same, -dup-other (refused, "duplicate key value violates unique constraint event_transferred_key"), -pos-kind, -pos-sid, -cat | B-SCH-1 shown |
| S3 | Decision `status` value `declined` | label of enum `devos_private.decision_status`, after `accepted` (M6:43) | `pg_enum`: `draft, open, answered, accepted, declined, superseded, withdrawn` | SCH-S3-declined; SCH-S3-closed (a value outside the set refused, 22P02) | B-SCH-4 shown |
| S4 | Finding `changeable`: the value set yes / no / not_recorded | enum `devos_private.finding_changeable` on `finding_revision.changeable` (M6:50 to M6:53) | `information_schema.columns` (`USER-DEFINED`, `finding_changeable`, not null); `pg_enum`: `yes, no, not_recorded` | SCH-S4-chg-yes, -chg-no, -chg-nr; -chg-closed (22P02) | B-SCH-5 shown |
| S4 | Finding `counter_evidence_searched` takes `not_recorded` | the column stays `text not null` (M4:30) | `information_schema.columns` | SCH-S4-ces-nr | B-SCH-6 shown |
| S4 | Artifact `kind`: `git_file`, `git_tree` | `artifact_revision.kind`, `text not null`, no check (M4:58; choice (4)) | `information_schema.columns`; no check on `kind` | SCH-S4-art-git_file, -art-git_tree (base: `w14_fixture_value`, admitted) | B-SCH-7 shown |
| S4 | Acceptance `accepted_use`: `installation_acceptance` | `acceptance.accepted_use`, `text not null`, no check (M4:104; choice (4)) | as above | SCH-S4-acc-use | B-SCH-8 shown |
| S4 | EffortPolicy: the step-set rule accepts the installation's step set only on a transferred row | not a schema object: a format-gate rule, W-C02-10's (EV5 "Interfaces assumed": "W-C02-10 applies the format gates with the exceptions of PC-44 places 3, 5, 8 and 9"; B 3.18) | none | none (SCH's design clause table, row S4 EffortPolicy: section 12's cases, W-C02-14 point 13's) | none |
| S5 | The ledger-transfer group of functions | **not built here** | `pg_proc`: only `deployment_drift` and `refuse_change` in the two schemas | none | none |

The two harness runs together (B-SCH-1 to B-SCH-9): each "shown", red equal to its `expect-red`, positive control and restore PASS (part of `HARNESS PASS (11/11 breaks shown)`; `counts: no`, PostgreSQL 16.15).

**S5's reading (note N-277).** Point 9 asks for the transfer's schema "as W-C02-06's accepted design record gives it", and that record gives S5 as functions "Built in W-C02-09 with section 4's other functions … tested before use; not left to W-C02-14", and its "Interfaces assumed" gives W-C02-08 S1 to S4. So this item builds S1 to S4 and not S5, as N-277 item (2) reads point 9; the verdicts judge that reading. No S5 function exists in this build (O, the `pg_proc` listing). N-277 item (3) carries S5's tests and W-C02-09's block before any S5 function is built.

**Choices** (point 2: none silent; D1).
1. **No list of event types.** S1's types are admitted values of `event_type`, which keeps part 2's form check. Alternative: an enum or a CHECK list of event types. Not chosen: B 3.13 gives no closed list, W-C02-09's functions write other types (B 3.8's `source_read`, the state changes' events), and a list now would be either incomplete or invented. A rule that refuses a type the transfer writes would be caught by SCH-S1-type-* (B-SCH-9 shows it).
2. **The payload rule and the at-most-one hand-over are table rules** (a CHECK and a unique index), not only the functions' (S5). EV5 lists them under "Fields and constraints"; T-W14-SCH reads them so ("Not covered" (2)); and a table rule holds for the owner too. Alternative: the functions only: a departure under point 2, which SCH's cases would then fail.
3. **`transfer_source`'s six fields are each required as a JSON string**, `input_commit` matching `^[0-9a-f]{40}$`, and the whole condition wrapped in `coalesce(…, false)` so that a SQL NULL (a missing or JSON-null field) refuses. This is stricter than SCH asks for `path`, `last_commit` and `sha256` (JSON null there "is not asked", SCH "Not covered" (11)): "required" is read as holding a value; the transfer's tool writes text there; and W-C02-07's staged `transfer_source` plants (`n02_src`, `n04t_src`) meet it. Lower case, as `artifact_revision.commit` (M4:57) and git's output. `last_commit` and `sha256` get no form check: S1 names a form only for `input_commit`.
4. **S4's Artifact `kind` and Acceptance `accepted_use` stay free text** (a reading of EV5, stated for point 2's judgment). EV5 S4 lists "Value sets … Artifact `kind`: `git_file`, `git_tree`; Acceptance `accepted_use`: `installation_acceptance`", and section 11 says the schema adds "value sets for three fields". B 3.10 and 3.11 give neither field a list, and W-C02-07's merged tests already write Artifact `kind` `note` (SCH "Not covered" (4)). A closed set of only the transfer's values would refuse those; a closed set with more members would need values no source lists. So the transfer's values are admitted and no set is closed; the three fields read as "value sets" are then `changeable` (closed: yes / no / not_recorded), and `kind` and `accepted_use` (open, holding the transfer's values). If the checker reads EV5 as asking closed sets here, that part stops until a decision record names their members (point 2).
5. **`changeable` is an enum type, not a CHECK list on text**, like every other value set of B the build carries (M3, M4). It also keeps W-C02-07's planter working: `w07_plant` gives an enum column its first label, but fills a NOT NULL text column with a fixed string, which a CHECK list would refuse (N-278 (4)); with a CHECK list DM02's `finding_revision` cases would be "could not check". D2: the tests' form was a factor, named here. T-W14-SCH passes values for `changeable` itself, so either form serves its Finding cases.
6. **N-278 item (3).** SCH-S4-art and SCH-S4-acc read CHECK lists only (`w14_other`), not `pg_enum`. **No enum type is used for Artifact `kind` or Acceptance `accepted_use`**: both are text with no check, so `w14_other` gives `w14_fixture_value`, the base fixture is admitted, and both cases ran `ok` (not "could not check"). That test needs no revision for this build on that account.
7. **The change of `changeable` from boolean.** M4 made it boolean; M6 changes its type (`using` maps true to `yes`, false to `no`), dropping and making again `finding_current` with M5's definition, since PostgreSQL refuses to change the type of a column a view reads. No row exists in any project before M6 (Inf: no migration of this item has been applied). Editing M4 instead would have been shorter; the executor's task asked for later migrations.

**✘ Looked for in either project's catalog:** offline only here (the table above); the look in `devos-test` (verdict (i), as W-C02-03's order applies it before the merge) and in `devos` (verdict (ii)) comes with the job's runs. Nothing EV5 gives for the transfer is left to W-C02-14: S1 to S4 are here, S5 is W-C02-09's by EV5's own text (N-277).

**Point 6 for T-W14-SCH** (point 9's last sentence): the copy and its SHA-256 (section 6); passes offline at this head; no case or control of it needs W-C02-14's transfer (SCH "Not covered" (1) lists what does: S5's behaviour, W-C02-14 point 13); its files unchanged since their merge; its live run in `devos-test` is "could not check" until the job runs it.

## 10. Raw outputs and commands

All under `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/` (outside the repository). Drivers: `prd08b_run/run.sh`, `prd08b_run/drive.py`, `prd08b_run/setup.sql` (the first producer's, with the cluster and raw paths changed), `prd08b_run/catalog_s.sql`, and the first producer's `prd08_run/catalog.sql`. Outputs, `prd08b_raw/`: `01_init.txt` (initdb, exit 0); `02_start_setup.txt` (start, version, stand-ins); `03_apply.txt`; `04_drift.txt`; `05_dbtests.txt`; `06_catalog_point9.txt`, `06_catalog_full.txt`; `07_static_programs.txt`; `08_harness_breaks.txt`; `09_git_diff_tests.txt`; `10_stop.txt` (`server stopped`, exit 0; the cluster directory `prd08b_pg` removed, exit 0); `11_scan.txt`. Each cluster step: `unshare --user --map-user=1000 --map-group=1000 bash prd08b_run/run.sh <init|start|setup|apply|drift|dbtests|sql|stop>`; the harness under the same `unshare`. The first producer's `prd08_raw/` and `prd08_run/` stay as they were (exploratory, envelope above).

## 11. What the build leaves to later items

| Left | Owner item |
|---|---|
| S5, the transfer's fourteen functions, their tests merged first, and W-C02-09's block amended to carry them (N-277) | W-C02-09 (the executor amends its block first) |
| `not_recorded` admitted only on transferred rows (Finding), the transferred EffortPolicy's step-set exception, the other format gates, the sample streams and the `format_gate` label, the high-impact path list's database copy | W-C02-10 (points 2 to 4; EV5 "Interfaces assumed") |
| Who may write a `declined` decision; the functions' role checks; point 4's positive control (`w07_5a_positive_control.sql`); 5A part B (`w07_5a_exposed_schema.py`, once the publishable key is stored) | W-C02-09, W-C02-10 |
| `devos_ci`'s grant on `deployment_drift`, which waits for the token check | the item that builds the token check (the identity chain's first part, N-221 step 2, or W-C02-09) |
| The transfer's behaviour: exact repeat and conflict answers, resuming, the hand-over's closing, N18 | W-C02-14 (point 13) |
| W-C02-07's tests that send `changeable` as JSON `false` (T-W07-5D, 6ST, DM11, DM47, F06): with the enum they are refused; the interface or those tests are reconciled (N-278 (1)) | the executor and the test designer, before W-C02-09's first result |
| F04-m4-kur's `update … work set mission_ref` (N-278 (2)); W-C02-09's tests that assume a `title` on `work_revision`, which B lacks (the first producer's finding) | the test designer, before W-C02-09's first result |
| Real environment tokens | W-C02-12 |
| The breaks counted on PostgreSQL 17 (W-C02-07's) | W-C02-13; T-W14-SCH's: W-C02-14 point 13's prober |
| The type `informed_of` with its fields | C06 |
| `devos_ingest` | C04 |

## 12. What this record cannot show

Anything about `devos-test` or `devos`: Supabase's roles and defaults, the Data API's exposed schemas, PostgreSQL 17.6's behaviour, `supabase db push`'s transaction form, the job's runs and times, and `deployment_drift` there. Also whether each test fails under its break on PostgreSQL 17 (W-C02-13; W-C02-14 point 13), the functions' role checks (W-C02-09, W-C02-10), and any content's meaning (plan Section 8 item 10).
