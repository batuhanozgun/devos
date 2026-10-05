# Appendix B — Data model

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*

**Version:** 1.1 (consistent with plan 2.1) · **Date:** 29 September 2026 · **Status:** [Proposal]. Implemented in the test project in C02; that the rules work is shown with the Appendix C tests.

**Sources:** P4 v4 report §8–§18 and §30 (state axes, readiness and claim, request-contribution-use, knowledge families, context contracts, relation queries, operation intent, release, recovery, composite product, learning); P5 v2 guide §7 (object table); installation plan 2.0 Sections 4 and 6 (families added in this version: decision rules, unnecessary-prerequisite rule, learning, exam run, user model, constraint, effort policy, dead end, leak fingerprint).

**Reader:** Builder. Field names are in English, descriptions in Turkish.

---

## 1. Invariant principles

These principles hold for every family; if a family breaks one of them, that is a design error.

1. **Single write path.** Agents and jobs call only the functions in the `devos_api` schema. Writing directly to the tables in the `devos_private` schema is closed to all application roles (access rules + revoking privileges). The functions run with definer rights and check the caller's role themselves.
2. **State and event together.** Every state change produces an event (`event`) within the same transaction; if the transaction is rolled back, both are rolled back together (F06). An exact repeat of the same change produces no new event.
3. **Revision.** Every meaningful object carries a `revision` number. An update does not change the old revision; it produces a new revision and a reason. References to other objects carry which revision they refer to.
4. **Scope and revision check.** An operation checks the work's scope together with the scope and revision of the target and of the source. Checking only one of them is the F05 failure.
5. **State axes are separate.** A work item's execution, validity, acceptance and external-effect states are separate fields; there is no single "done" field.
6. **Three-valued logic.** Readiness and support groups take the value true, false or unknown. In an ALL group, one false makes the result false; if there is no false but there is an unknown, the result is unknown. In an ANY group, one true is enough; if there is no true but there is an unknown, the result is unknown. An empty group does not count as ready.
7. **Short transaction.** No database transaction is held open during the agent's long work. The agent relies on an immutable input snapshot; at the end, a short transaction produces acceptance or a conflict. A conflict does not throw the work away; the result is kept as a candidate.
8. **Identity chain.** The role class is derived from the **environment token** the call carries (only the token's hash is kept in the `env_tokens` table). Every effect concerning a work item requires the **claim token**, which is returned during `claim` to that session only (its hash is kept in the `assignment` record). The session ID and the role name are declarations: they are written to the record and labelled `declared`, and no authority decision rests on them. Separation-of-authority rules are defined at the environment level. The authority epoch is a separate concept.
9. **Authority epoch.** There is a single global `authority_epoch` counter. A restore and a key change increment the epoch; the claims and permissions of an old epoch cannot produce effects.
10. **Privacy class.** Every knowledge record carries the class `public` or `private`. Content derived from a private source is in the `private_derived` class by default; DevOS's own synthesis, source identifiers and DevOS's design documents may enter the public repository; verbatim or near-in-meaning transfer from the research content in the library, and transfer from conversation transcripts, may not (plan, K8). Only `public` content goes to the second model family.
11. **Deletion.** When a source's retention permission is withdrawn, the raw body, chunks, vectors, search indexes, context packages and derived quotations are handled together. Merely setting a "deleted" mark is not enough. When backups are restored, the search and context service does not open until the current retention policy has been reapplied.
12. **Format gate.** The database can enforce that a field is filled, not that its content is meaningful. Such rules are labelled `format_gate`; the content is assessed in the audit environment and by sampling.
13. **Language.** The language of records and fields is English; only the original of Batu's words (`*_original_tr`) and the texts shown to Batu (`*_tr`) are in Turkish. Sources coming from the library are stored in their own languages and carry a `language` field.

---

## 2. Database roles and access

| Database role | Who uses it | What it can do | Cannot do |
|---|---|---|---|
| `devos_kurulum` | Builder (stage A) | Installation operations; closed in C12 | Issuing tokens |
| `devos_calisma` | Working environment | Opening work other than missions, need and decision records, claiming, writing contributions and candidates, findings, context, proposals, external-effect intents | Binding verdicts, acceptance, release activation, approving rule changes, reading exam records |
| `devos_denetim` | Audit environment | Reviews, verdicts, acceptance, review of rule and control changes, authority approval for high-impact merges, advancing recovery stages | Writing products and candidates, reading exam records |
| `devos_sinav` | Exam environment | Opening exam tasks as ordinary work, writing exam runs and competence | Writing products, writing verdicts |
| `devos_ingest` | The transfer job in `devos-backup` | Writing only sources, chunks, vectors and fingerprints | Everything else |
| `devos_ci` | PR checks and the release job | Reading: review verdicts, decisions, current authority and epoch, fingerprint matches; writing observations | Writing verdicts or decisions |
| `devos_backup` | The backup job | Read only; only the `mark_exported` function | Every other write |
| `devos_batu` | Only if B3 (b) is chosen: the decision panel | Reading and answering only the decisions assigned to it | Everything else |

- Agent environments do not hold Supabase's secret (service) key; environments carry the public (publishable) key and an environment token. Every `devos_api` function first verifies the token and derives the role class from it.
- Tokens are issued with `devos_private.issue_env_token(role_class)`; only the project owner (Batu, from the Supabase dashboard) can run this function. The function returns the token once and stores only its hash. `revoke_env_token` runs with the same authority and increments the authority epoch.
- At the start of every function, the permitted roles are checked. The role list sits in the function's definition and is tested with the authorization tests in Appendix C.

---

## 3. Record families

For each family: purpose, core fields, rules, states and transitions. The "Who" column uses the roles in Section 2.

### 3.1 Mission — authorized purpose

**Fields:** `id`, `revision`, `purpose`, `scope`, `constraints` (references to Constraint), `acceptance` (acceptance boundary), `owner_authority` (reference to Batu's decision record), `status` (active / paused / closed).

**Rules:** A mission is opened or widened only by a decision that belongs to Batu. Opening internal work cannot widen the mission's scope.

### 3.2 Need and Inquiry — need and discovery

**Fields:** `id`, `mission_ref`, `condition` (what is missing), `origin` (required by the goal / required by the chosen method / merely useful), `method_ref`, `why_needed` (**mandatory**: which decision or action would be wrong without it), `evidence_for`, `evidence_against`, `assumptions`, `alternatives` (at least one alternative path, or the reason for "no alternative"), `consumer`, `return_to`, `uncertainty`, `status` (open / investigating / resolved / dropped / superseded).

**Rules:**
- If `why_needed` is empty, the record is rejected (the unnecessary-prerequisite brake, plan K-1).
- A need with `origin = method` automatically falls back into re-evaluation when the method changes.
- An Inquiry's result is linked to `return_to`; an inquiry cannot be closed before the result has returned.

### 3.3 Work and WorkStanding — work and its states

**Work fields:** `id`, `revision`, `mission_ref`, `mission_revision`, `scope`, `purpose`, `input_refs`, `target_refs`, `consumer`, `return_to`, `stop_rule`, `acceptance_ref`, `impact_class` (routine / high), `effort_policy_ref`, `method_refs`.

**WorkStanding (separate axes):**

| Axis | Values |
|---|---|
| `execution` | planned, ready, running, waiting, finished, cancelled |
| `qualification` | current, stale, needs_review |
| `acceptance` | proposed, accepted, rejected |
| `effect` | none, prepared, observed, unknown |

**Rules:**
- `ready` is the momentary result of a query; the claim operation re-checks the same conditions.
- When `execution = finished`, `acceptance` does not automatically become `accepted`.
- If a work item's input changes, it becomes `qualification = stale`; the old output is not deleted.
- Reopening: work items whose basis has changed are taken into the candidate review set; they are not cancelled automatically.
- The late result of a cancelled claim is kept as candidate evidence and does not mix into the current product.

### 3.4 Relation — typed relation

**Fields:** `id`, `type`, `from_ref` (+revision), `to_ref` (+revision), `scope`, `hard` (whether it affects readiness), `group_id` and `group_mode` (ALL / ANY), `validity` (current / stale / retracted), `use` (which use it is valid for).

**Relation types (initial list):** `depends_on` (hard dependency), `supports`, `challenges`, `derived_from` (source derivation), `supersedes`, `uses` (contribution use), `part_of` (composite product), `reviews`, `blocks_effect`, `about` (descriptive).

**Rules:**
- In hard dependencies a cycle is rejected; in descriptive relations a cycle is allowed.
- An exact repeat of the same relation produces no new record and no new event.
- When a supporting source goes stale, what it supports is not automatically counted as false; the sufficiency of the support falls back into re-evaluation.

### 3.5 Assignment — claim

**Fields:** `id`, `work_ref`, `work_revision`, `declared_session_id` (declared), `role_class` (from the token), `claim_token_hash`, `generation` (the ordinal number of this claim for the same work item), `authority_epoch`, `lease_expires_at`, `last_heartbeat_at`, `status` (active / released / expired / revoked).

**Rules:**
- A work item can have only one active claim at a time; this is enforced at database level by a uniqueness constraint.
- The session sends a regular liveness signal; if the time runs out, the claim becomes `expired` and the work item can become ready again.
- Every operation that produces an effect requires the claim token and checks that the claim is still active, its generation current and its epoch valid. Another session in the same environment cannot carry out an operation with someone else's claim.

### 3.6 Grant — permission

**Fields:** `id`, `issuer`, `subject` (role class or claim), `scope`, `permitted_effects`, `revision`, `expires_at`, `revoked_at`, `authority_epoch`.

**Rules:** A permission is not derived from the work's free text. Preparation or a retry with a revoked permission is rejected. Reading an operation receipt is not re-authorizing the effect.

### 3.7 Request, Contribution, UseReceipt — request, contribution, use

**Request fields:** `id`, `sender_work`, `recipient` (work item or role), `requested_contribution`, `parent_decision`, `scope`, `source_depth`, `format`, `urgency`, `deadline_reason`, `return_to`, `status` (sent / accepted / narrowed / rejected / fulfilled / withdrawn).

**Contribution fields:** `id`, `request_ref`, `content_ref` (product or finding revisions), `scope`, `rationale`, `uncertainty`, `intended_use`, `qualifiers`, `limitations`, `status` (candidate / delivered / superseded).

**Subagent task definition (inside `Request`, also for requests within a session):** `objective` and the decision it is tied to, `expected_output_format`, `sources_and_tools`, `boundaries` (what it will not do), `effort_budget`, `write_target` (the record the result is written to), `writer` (whether it is the single writer of this product or only a reader).

**UseReceipt fields:** `id`, `consumer_work`, `consumer_revision`, `contribution_ref`, `disposition` (used / used_conditionally / not_used / opened_question), `rationale`, `changed_decision_ref`.

**Rules:**
- Only the consumer writes the use receipt; the producer cannot write it on the consumer's behalf.
- Redelivery of the same request does not start new work; different content under the same ID shows up as a conflict.
- "An answer came" and "used" are separate.

### 3.8 Source, Chunk, Finding — source, chunk, finding

**Three separate fields (for every source and finding):** `source_type` (foundation / candidate_study / context / exploration / historical_record / archived_report / legacy_repo), `epistemic_status` (observation / user_decision / inference / hypothesis / proposal), `current_authority` (can_open_work / instruction / information_only). An old genuine observation does not turn into a hypothesis by standing in a historical document; an old decision, being historical, does not count as an instruction today.

**Body reading:** `read_source(source_ref, revision, span)` returns the full body of the source or the requested span; it passes through the privacy filter; the read is recorded as a `DispatchReceipt`.

**Source fields:** `id`, `revision`, `origin_repo`, `origin_path`, `origin_commit`, `branch`, `body_ref` (the body in file storage), `content_owner`, `kind` (original / derived), `authority_status` (foundation / candidate / context / protocol_input / exploratory / historical / historical_trial / exploratory_note), `privacy_class`, `language`, `retention` (keep / archive / retract), `ingested_at`.

**Chunk fields:** `id`, `source_ref`, `source_revision`, `span` (start and end), `heading_path`, `text`, `tsv_tr`, `tsv_en`, `tsv_simple`, `embedding` (its dimension according to the model chosen in C04), `embedding_model`, `privacy_class`, `authority_status`.

**Finding fields:** `id`, `revision`, `claim`, `source_spans`, `qualifiers`, `counter_evidence_searched` (mandatory: the counter-evidence searched for and found, or "none found"), `confidence`, `open_questions`, `fresh_until` (for information that can change), `status` (candidate / reviewed / accepted_for_use / stale / withdrawn), `use_scope`.

**Rules:**
- A finding that carries information that can change cannot move to the `accepted_for_use` state undated or with only secondary sources.
- Sources with a historical status do not overshadow current information in the search ranking; their status is visible in the result.
- The vectors and indexes of chunks are tied to the source revision; they are regenerated when the source changes.
- When the model changes, all vectors are regenerated; vectors of two models are not mixed in the same query.

### 3.9 ContextRequest, ContextPackage, DispatchReceipt — context

**ContextRequest fields:** `id`, `revision`, `work_ref`, `assignment_ref`, `target_refs`, `use` (discovery / design / production / review / acceptance / recovery), `mandatory_obligations` (each: what must be known, why, at what depth), `access_limit`, `consumer`.

**ContextPackage fields:** `id`, `request_ref`, `request_revision`, `obligation_coverage` (source chunks for each mandatory need), `unmet_obligations`, `view_ref`, `view_hash`, `unknown_need_checklist_ref`, `cache_key`.

**DispatchReceipt fields:** `id`, `package_ref`, `session_id`, `runtime_info`, `observed_extra_context` (as far as it can be observed), `limitations`.

**Rules:**
- Whoever prepares the package cannot shorten the list of mandatory needs; a change requires a new request revision (F02).
- A package with an unmet mandatory need is not accepted; discovery may start for what is missing.
- When the budget tightens, repeated content and content of low decision value is reduced first; mandatory counter-evidence and the authority boundary are not removed.
- The cache key includes the work item and use, the target and source revisions, the permission view, the role and method versions, and the index version (Appendix G).

### 3.10 Artifact and Assembly — product and composite product

**Artifact fields:** `id`, `revision`, `path`, `commit`, `kind`, `status` (candidate / current / superseded).

**Assembly fields:** `id`, `name`, `design_baseline` (intent revision), `working_assembly` (the sequence of realized part revisions), `delivery_baseline` (the accepted whole), `snapshot_id`.

**Rules:** A change in the design does not mean that the working state or the delivered state has changed. Every review carries the ID of the snapshot it reviewed.

### 3.11 Review, Verdict, Acceptance — review, verdict, acceptance

**Review fields:** `id`, `target_ref` (+revision or snapshot), `claim`, `criterion` (+version), `use`, `basis_refs` (the full set of source, decision and policy revisions the verdict rests on), `reviewer_declared_session`, `reviewer_role_class` (from the token), `independence_level` (same_session / same_model_other_session / other_view / other_model_family / batu_expert), `view_ref`.

**Verdict fields:** `id`, `review_ref`, `result` (pass / fail / conditional), `evidence_refs`, `objections`, `limits`.

**Acceptance fields:** `id`, `target_ref`, `accepted_use`, `scope`, `current_evidence`, `residual_decisions`, `owner_authority`.

**Rules:**
- The reviewing session cannot be the session that produced the reviewed product or proposed the change.
- The independence level is kept in the record; the acceptance claim is limited to this level.
- The user's approval of a preference does not count as evidence of a technical fact.
- Binding verdicts and acceptance are written only with the `devos_denetim` role; `devos_calisma` cannot approve what it produced itself.
- When `basis_refs`, `criterion` or `use` changes, the verdict goes stale and a new acceptance is needed; the old verdict is not automatically carried over to another use of the same product.
- The verifier does not repair in the same action: a new revision of the target product cannot be written in the same transaction as a `Review` record.

### 3.12 Operation and Observation — external effect

**Operation fields:** `id`, `idempotency_namespace`, `idempotency_key`, `effect_class`, `target`, `expected_base`, `payload_hash`, `work_ref`, `assignment_ref`, `generation`, `authority_epoch`, `grant_ref`, `read_set`, `status` (prepared / attempted / observed / conflicted / abandoned), `attempts`.

**Observation fields:** `id`, `operation_ref`, `source` (the reliable source of the observation), `observed_at`, `observed_effect` (applied / not_applied / unknown), `details`.

**Rules:**
- Same key and same full intent: the existing record is returned. Same key and different intent: conflict (F01).
- At the moment of the effect, the current work item, dependencies, claim, permission and read set are re-checked (F08). Which dependencies enter the read set is determined on the server side according to the operation type; it is not left to a short list written by the agent.
- Observations are appended, not deleted; a later "unknown" does not erase an earlier "applied" (F07).

### 3.13 Event — event

**Fields:** `id`, `aggregate_type`, `aggregate_id`, `aggregate_revision`, `tx_id`, `event_type`, `payload`, `created_at`, `exported_at`.

**Rules:** The growth of the event ID is not by itself a global order; export and monitoring work with the transaction ID and the object revision. The event record is the source of the hourly export.

### 3.14 Release — rules, roles, methods

**Fields:** `id`, `kind` (common_rules / role / method / config), `name`, `version`, `content_ref` (commit), `applicability`, `owner`, `trial_ref` (exam run), `rollback_to`, `status` (proposed / trial / active / retired).

**Rules:** A method file being in the repository does not mean that it is active; being active is determined by the release record. The proposing role cannot activate the same release.

### 3.15 Competence and EvalRun — competence and exam

**Competence fields:** `id`, `role`, `task_class`, `model_and_settings`, `tools_and_context_method`, `eval_refs`, `result_summary`, `known_limits`, `retest_triggers`, `valid_for_release`.

**EvalRun fields:** `id`, `eval_set_id` (ID only; the content is in `devos-evals`), `eval_set_version`, `subject_role`, `subject_release`, `runner_session`, `results` (positive and negative examples separately), `run_at`.

**Rules:** When the model, the role text, the tool set or the context method changes, the related competence becomes `retest_required`. `EvalRun` and `Competence` are written and read only with the `devos_sinav` role. Exam tasks are opened in the working environment as ordinary `Work`; in the `Work` record, the fact that the task is an exam is kept in a field the working environment cannot see.

**Common evidence envelope (`EvidenceEnvelope`, for all evidence):** `claim`, `target_commit`, `deployment_config_ref`, `criterion_version`, `inputs_ref`, `observations_ref`, `raw_evidence_ref` (private content in the database or in private file storage), `independence_level`, `evidence_layer` (structural / semantic / behavioral), `run_at`. A `pass` obtained on a different target or version cannot close the new installation.

### 3.16 UserModel and Constraint — user model and constraint

**UserModel fields:** `id`, `domain`, `level` (expert / knowledgeable / limited), `evidence_original_tr` (Batu's Turkish wording, verbatim), `evidence_interpretation_en`, `decision_types_owned`, `updated_at`.

**Constraint fields:** `id`, `statement` (English), `statement_original_tr` (Batu's Turkish wording, verbatim), `source` (Batu's decision), `kind` (budget / tool / scope / time / other), `questionable` (always true), `conflicts` (contradictions detected), `status` (active / revised / withdrawn).

**Rule:** When a contradiction between a constraint and what the work requires is recorded, a Batu decision is opened automatically (3.17).

### 3.17 Decision — decision

**Fields:** `id`, `revision`, `class` (routine / high_impact / batu), `question` (English), `presented_text_tr` (in the `batu` class, the Turkish text shown to Batu), `answer_original_tr` (Batu's answer, verbatim), `answer_interpretation_en`, `why_this_owner`, `options` (each: description, purpose, benefit, cost, risk), `alternatives_considered`, `single_viable_path_reason`, `premises`, `criteria`, `evidence_refs`, `assumptions`, `reversibility`, `reopen_triggers`, `recommendation`, `recommendation_rationale`, `if_unanswered`, `status` (draft / open / answered / accepted / superseded / withdrawn), `answer`, `answered_by`, `answer_channel_ref`, `answered_at`.

**Rules:**
- Decisions of the `high_impact` and `batu` classes cannot move to the `open` state until the result of the alternatives research (the compared options, or `single_viable_path_reason`, or the `open_exploration` state), the criteria, evidence, assumptions, `premises` (premise inventory), reversibility and the reopening conditions have been entered (format gate).
- The answer to a `batu`-class decision can come only from Batu's identity: if B3 (a) is chosen, the answer is processed after verifying that it came from Batu's GitHub account; if (b) is chosen, only with the `devos_batu` role.
- When a new decision is opened, related earlier decisions are queried and linked to the record; an earlier decision is reopened only with new material information or a changed goal.

### 3.18 EffortPolicy — effort policy

**Fields:** `id`, `work_ref`, `level` (high by default), `expert_assessment_ref` (expert assessment; cannot be empty for any work item), `reduction_reason`, `approved_by_role_class` (`devos_denetim`), `non_removable_steps` (verification, alternatives research, external source research for high-impact work).

**Rule:** `expert_assessment_ref` and `non_removable_steps` cannot be emptied for any work item (format gate); a reduction only with the audit environment's approval.

### 3.19 DeadEnd — dead end

**Fields:** `id`, `attempted_path`, `context`, `why_abandoned`, `salvaged_knowledge`, `do_not_retry_unless`, `related_refs`.

**Rule:** When a new work item is opened, similar dead ends are searched for and those found are linked to the record.

### 3.20 Learning — learning

**Fields:** `id`, `class` (observation / incident / finding / pattern / failure_class / capability_gap_candidate / capability_gap / good_example / bad_example / eval / method / proposal), `mas_failure_class` (specification / inter_agent_misalignment / verification / none), `statement`, `evidence_refs`, `versions_involved`, `generalization_level`, `applies_when`, `does_not_apply_when`, `status`.

**Rules:** A bad example cannot be recorded without carrying why it is bad. A single strong event can be recorded as `capability_gap_candidate`; the move to `capability_gap` requires evidence of reproduction, causal separation or a counter-example (the number of events alone is not enough).

### 3.21 Budget and Usage — limit and usage

**Fields:** `id`, `surface` (routine_runs / session_usage / supabase_db_size / storage / actions_minutes / second_model_quota), `limit_value`, `limit_source` (read from the account, or documentation), `observed_usage`, `observed_at`, `reservations`, `uncertainty`.

**Rule:** When a limit's set threshold is approached, a decision record is opened; the scope is not narrowed silently.

### 3.22 Recovery — recovery

**Fields:** `id`, `backup_ref`, `restored_into_project`, `authority_epoch_before`, `authority_epoch_after`, `revoked_assignments`, `pending_effects_reconciled`, `reopen_stage` (read_only / candidate / publish), `retention_policy_reapplied`.

**Rule:** A recovery record cannot skip the `reopen_stage` order.

### 3.23 LeakFingerprint — leak fingerprint

**Fields:** `hash` (rolling-window hashes produced from private source chunks), `source_ref`. No content is kept. Only `devos_ingest` writes; `devos_ci` reads.

---

### 3.24 SessionRecord and LaunchRecord — session and launch

**SessionRecord fields:** `id`, `role_class` (from the token), `declared_session_id`, `routine_ref`, `started_at`, `last_seen_at`, `ended_at`, `handoff_ref` (structured hand-over record).

**LaunchRecord fields (for emergency API triggers):** `id`, `routine_ref`, `reason`, `intent_at`, `returned_session_id`, `result` (started / uncertain / failed / reconciled), `reconciled_by`.

**Rules:** A launch whose response is lost stays `uncertain`; before a retry, its counterpart is searched for in the session list and in `SessionRecord`. Blind repetition is forbidden.

### 3.25 ProtocolAudit — thinking discipline audit trail

**Fields:** `id`, `work_ref`, `turn_ref`, `role_class`, `protocol_release`, `results` (for D1–D9: loaded / skipped + reason / unavailable), `recorded_at`.

**Rule:** If a required discipline is `unavailable`, the related work cannot advance in the same turn.

### 3.26 Premise, FrameReview, MechanismAssumption — frame review

**Premise fields:** `id`, `design_ref`, `statement`, `origin` (user_decision / source / prior_design / assumption), `still_valid`, `from_scratch_test` (would we choose it from scratch?), `reviewed_at`.

**FrameReview fields:** `id`, `trigger` (squeeze_signal / major_design / phase_gate), `design_ref`, `counter_design_ref` (the design of a session that does not see the current design), `comparison`, `decision_ref`.

**MechanismAssumption fields:** `id`, `mechanism_ref`, `compensates_for` (what the model cannot do on its own), `last_tested_at`, `test_result`, `retest_triggers` (model or platform change).

**Rules:** When a second correction mechanism is proposed on the same subject (`Learning.class = proposal` and the same `failure_class`), a `FrameReview` work item is opened by itself. The `Decision` record of a major design decision cannot be opened without carrying `premises`.

### 3.27 EnvToken — environment token

**Fields:** `id`, `role_class`, `token_hash`, `issued_at`, `revoked_at`, `authority_epoch`.

**Rule:** The token itself is kept in no table and no record.

## 4. `devos_api` functions

Each function: permitted roles, checked conditions, the event it produces. On failure, an error with a reason is returned and the rejected attempt is recorded.

| Group | Functions | Key checks |
|---|---|---|
| Session | `session_brief(role)`, `register_session`, `record_handoff`, `record_launch`, `reconcile_launch` | Role class from the token; the `role` parameter only selects which role package is loaded. An uncertain launch is not repeated blindly |
| Mission and need | `open_mission`, `revise_mission`, `record_need`, `resolve_need` | Mission only by Batu's decision; `why_needed` mandatory for a need |
| Work | `admit_work`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` | Scope and revision; link to the mission revision |
| Readiness and claim | `ready_works()`, `claim(work_id)` → claim token, `heartbeat`, `release` | Single active claim; epoch and generation; effects require the claim token |
| Relation | `relate`, `retract_relation`, `affected_entities(root, limits)`, `explain_paths(root, target, limits)` | Cycle rejection in hard dependencies; the result carries completeness information |
| Request-contribution-use | `send_request`, `answer_request`, `deliver_contribution`, `record_use` | Only the consumer writes the use |
| Knowledge | `record_finding`, `review_finding`, `search(query, modes, filters)`, `read_source(source, revision, span)`, `ingest_source` (only `devos_ingest`) | Date and primary source for information that can change; the privacy filter is applied first; three status fields |
| Context | `request_context`, `build_package`, `record_dispatch` | Mandatory needs cannot be shortened |
| Product | `register_artifact`, `update_assembly`, `snapshot_assembly` | Design and working state separate |
| Review | `open_review`, `record_verdict`, `accept` | Only `devos_denetim`; `basis_refs` mandatory; no repair in the same transaction |
| External effect | `prepare_operation`, `record_attempt`, `record_observation` | Full intent; re-check at the moment of the effect |
| Decision | `open_decision`, `answer_decision`, `link_prior_decisions` | Mandatory fields by class; answer identity |
| Learning and exam | `record_learning`, `record_eval_run`, `propose_release`, `activate_release`, `rollback_release` | The proposer cannot activate; an exam is required |
| Limits | `record_usage`, `budget_status` | A decision is opened at the threshold |
| User and policy | `record_constraint`, `revise_constraint`, `update_user_model`, `set_effort_policy`, `record_dead_end`, `grant`, `revoke_grant` | Effort reduction only with audit approval; constraint change with a decision record |
| Discipline and frame | `record_protocol_audit`, `record_premises`, `open_frame_review`, `record_mechanism_assumption` | Without a required discipline, work does not advance; premises mandatory in major design |
| Backup | `mark_exported` (only `devos_backup`) | No other write |
| Recovery | `begin_recovery`, `advance_recovery_stage` | The order is not skipped; epoch increment |

---

## 5. Scheduled jobs

| Job | Frequency | Output |
|---|---|---|
| Marking ready work | Every few minutes | Work items moving to the ready state (sends no trigger; sessions are scheduled) |
| Expired claims | Every few minutes | `expired` claims, the work item becoming ready again |
| Deadlock scan | Hourly | A decision record for wait cycles |
| Stale record and link check | Daily | Maintenance work for stale findings and broken references |
| Purpose audit | Daily | Maintenance work for work items weakly tied to the mission |
| Capability gap scan | Weekly | A learning record for recurring failure patterns |
| Limit tracking | Hourly | A decision record when a threshold nears; routine budget |
| Silent-failure sampling | Weekly | Audit work for a sample of work counted as "completed" and "passed" |
| Assumption inventory testing | Monthly and on a model or platform change | `MechanismAssumption` testing work |
| Constraint contradiction scan | At the opening of every working session | A constraint list for the coordinator; the audit also looks separately in every review |

The frequencies are initial values; they are changed, with reasons, on the basis of observations in C06 and C11.

---

## 6. Session launch contract

- In the normal flow, sessions start through scheduled routines (plan Section 6.4); the database sends no trigger.
- In emergencies (Batu's awaited decision has arrived and work is waiting; recovery), an API trigger from the reserve budget is used. The trigger sends only the work ID; the session reads the actual information from the database.
- Every trigger is recorded as a `LaunchRecord`; an uncertain result is not repeated before it is reconciled.
- Every session registers itself at opening with `register_session`.
- **Independent monitoring:** A path independent of the DevOS components (for example a scheduled GitHub Actions job in `devos-backup`) checks the time of the last session record, the last backup and the last ingestion; if the expected interval is exceeded, it opens an issue assigned to Batu. This path also notices routines switching themselves off and Actions minutes running out. It also notifies Batu of every commit the machine account makes in `agentic-os-search` (observation of the single-writer principle).

---

## 7. Search details

- **Keyword search:** `tsv_tr` (Turkish), `tsv_en` (English), `tsv_simple` (language-independent; technical terms and identifiers).
- **Semantic search:** the model chosen in C04; the query vector is produced on the session's own machine.
- **Merging:** Keyword and semantic results are merged with a rank-based merging method; the merging setting is chosen with the C04 benchmark.
- **Status:** Results carry their authority status; historical sources do not get ahead of a current source of the same relevance.
- **Continuation queries:** The continuation of a bounded relation or search query is tied to the same snapshot (snapshot, revision, policy); if the data changes in the meantime, the continuation information becomes invalid and the query restarts explicitly. Parts coming from different snapshots are not merged into a single "complete" result.
- **Privacy:** The filter is applied before the search; even the existence of results a role cannot see is not leaked. If completeness is limited because of a region that cannot be seen, this is stated without revealing the content.

---

## 8. Details to be chosen with evidence in C02

These are implementation details deliberately left open in this appendix. Each has an initial proposal; the choice is made in C02, with the tests in Appendix C and with its reasons.

| Topic | Initial proposal | What the choice will be based on |
|---|---|---|
| Concurrency control | Row lock and uniqueness constraint on claiming; stricter isolation on critical transitions | Concurrency tests and failure frequency |
| Revision storage form | Current table + a history table that is appended to | Query simplicity and size |
| Vector index | An approximate nearest neighbour index suited to the dimension of the chosen model | C04 search benchmark and size |
| Chunk size | Chunks of roughly one or two paragraphs that respect the heading structure | C04 search benchmark |
| How the environment token reaches the database | Carried in a separate request header through the API credential feature of the Claude environment; `devos_api` functions read the header and compare its hash with `env_tokens` | C01 #3 observation; C02 negative tests. If the header path does not work, an Edge Function gate that verifies the token |
