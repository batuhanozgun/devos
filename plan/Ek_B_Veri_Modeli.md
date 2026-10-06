# Appendix B — Data model

**Version:** 1.1 (consistent with plan 2.1) · **Date:** 29 September 2026 · **Status:** [Proposal]. Implemented in the test project in C02; that the rules work is shown with the Appendix C tests.

**Sources:** P4 v4 report §8–§18 and §30 (state axes, readiness and claim, request-contribution-use, knowledge families, context contracts, relation queries, operation intent, release, recovery, composite product, learning); P5 v2 guide §7 (object table); installation plan 2.0 Sections 4 and 6 (families added in this version: decision rules, unnecessary-prerequisite rule, learning, exam run, user model, constraint, effort policy, dead end, leak fingerprint).

**Reader:** Builder. Field names and descriptions are in English.

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
12. **Format gate.** The database can enforce that a field is filled, not that its content is meaningful. Such rules are labelled `format_gate`; the content is assessed in the audit environment and by sampling: for a set share of the records a format gate accepts, the database creates a `Review` of kind `sample` and queues it for the audit environment (3.11), so that a "filled but meaningless" record can fall to it. The share is set in C02 and recorded. The weekly silent-failure sampling of completed and passed work (section 5) is separate (PC-08).
13. **Language.** The language of records and fields is English; only the original of Batu's words (`*_original_tr`) and the texts shown to Batu (`*_tr`) are in Turkish. Sources coming from the library are stored in their own languages and carry a `language` field.

---

## 2. Database roles and access

| Database role | Who uses it | What it can do | Cannot do |
|---|---|---|---|
| `devos_kurulum` | Builder (phase A) | Installation operations; closed in C12 | Issuing tokens |
| `devos_calisma` | Working environment | Opening work other than missions, need and decision records, claiming, writing contributions and candidates, findings, context, proposals, external-effect intents | Binding verdicts, acceptance, release activation, approving rule changes, reading exam records |
| `devos_denetim` | Audit environment | Reviews, verdicts, acceptance, review of rule and control changes, authority approval for high-impact merges, advancing recovery stages | Writing products and candidates, reading exam records |
| `devos_sinav` | Exam environment | Opening exam tasks as ordinary work, writing exam runs and competence | Writing products, writing verdicts |
| `devos_ingest` | The transfer job in `devos-backup` | Writing only sources, chunks, vectors and fingerprints | Everything else |
| `devos_ci` | PR checks and the release job | Reading: review verdicts, decisions, current authority and epoch, fingerprint matches; writing observations | Writing verdicts or decisions |
| `devos_backup` | The backup job | Read only; only the `mark_exported` function | Every other write |

The `devos_batu` role of option B3 (b) (a decision panel) is removed: B3 = (a) was chosen, so Batu's answers come through the decision channel's intake, which checks his GitHub account (plan 6.9), not through a database role (PC-08).

- Agent environments do not hold Supabase's secret (service) key; environments carry the public (publishable) key and an environment token. Every `devos_api` function first verifies the token and derives the role class from it.
- Tokens are issued with `devos_private.issue_env_token(role_class)`; only the project owner (Batu, from the Supabase dashboard) can run this function. The function returns the token once and stores only its hash. `revoke_env_token` runs with the same authority and increments the authority epoch.
- At the start of every function, the permitted roles are checked. The role list sits in the function's definition and is tested with the authorization tests in Appendix C.

---

## 3. Record families

For each family: purpose, core fields, rules, states and transitions. Where a rule names who may write or read, it uses the roles in Section 2.

**Activation stages** (PC-08). Each family carries the stage that activates it, as roles do (plan 7.4). It is built at that stage, at final quality, before that stage's work needs it; C02 builds the families marked C02 and those C03 needs at its start. A deferred family is not built until its condition is met, and nothing depends on it before then. When a stage's work list is written, it asks again whether a deferred family is needed earlier. The first need is the earliest acceptance condition or test that fails without the family (evidence: `evidence/C00/EV-C00-015_scope_table.md`).

| Family (section) | Activated | First need |
|---|---|---|
| Mission (3.1) | C02 | Work's parent (`mission_ref`); its own rule is first tested in C10 |
| Need (3.2) | C02 | N01 |
| Inquiry (3.2) | C07, if C07's discovery measures need it as a separate record; until then an inquiry is a `Need` in the state `investigating` | K-1 discovery work |
| Work and WorkStanding (3.3) | C02 | F05, F08, N17, the concurrency test |
| Relation (3.4) | C02 | F04, K05, F08 (a) |
| Assignment (3.5): claim, claim token, generation, epoch, expiry | C02; the liveness signal's sender and form in C06 | N17, F01 (c), the concurrency test; C06's acceptance on interruption |
| Grant (3.6) | Deferred until an external effect needs a permission narrower than role class plus claim | — |
| Subagent task definition (3.7) | C04 | F02; C04's acceptance |
| UseReceipt (3.7) | C06 | C06's acceptance; K03 |
| Request and Contribution (3.7) | Deferred until a lost hand-off between sessions shows the need | — |
| Source and Chunk (3.8) | C04 | C04 tasks 1 and 4; the search benchmark; N10, N11 |
| Finding (3.8) | C02 | N09 |
| ContextRequest, ContextPackage, DispatchReceipt (3.9) | Deferred until missed-information records (plan U-4) show that task definitions miss needs | — |
| Artifact (3.10) | C02 | N28; F05 |
| Assembly (3.10) | C08 | C08 task 2; K09 |
| Review, Verdict, Acceptance (3.11) | C02 | N04, N25, N28; the sample of N01 |
| Operation and Observation (3.12) | C02 | F01, F07, F08 |
| Event (3.13) | C02 | F06 |
| Release (3.14) | C05, in the form C05 decides | Role activation (Appendix A section 6 item 7); C10's method changes |
| EvalRun (3.15) | C02, for C03 (its access rule) | N08 |
| Competence (3.15) | C05 | C05 task 4 and acceptance |
| EvidenceEnvelope (3.15) | As a form in git from C01; as database fields from C04 (benchmark) and C05 (exams) | Every evidence record |
| UserModel (3.16) | C06 | C06's acceptance (criterion 14) |
| Constraint (3.16) | C05 | C05's exam trap; C07 measure 5 |
| Decision (3.17) | C02; `answer_decision` with answer identity in C06 | N02; N05 |
| EffortPolicy (3.18) | C02 | N03 |
| DeadEnd (3.19) | C10 | C10's acceptance (criterion 12) |
| Learning (3.20) | C07 | C07 measure 6 (criterion 28); C10 |
| Budget and Usage (3.21) | C04 | N12; C04 task 6 |
| Recovery (3.22) | C09 | F03, K08 |
| LeakFingerprint (3.23) | C02, for C03 (test 6, N06); the library's fingerprints in C04 (task 5) | C03 test 6; N06 |
| SessionRecord (3.24) | C04 | C04's acceptance (what changed since the last session); C06's hand-over |
| LaunchRecord (3.24) | C06 | N24 |
| ProtocolAudit (3.25) | C05 | C05's acceptance; N19 |
| Premise (3.26) | Deferred until premises must be shared across designs; until then premises are held once, in `Decision.premises` and in design documents | — |
| FrameReview (3.26) | C10 (usable as a record from C07) | N20 |
| MechanismAssumption (3.26) | C05 (first version); its testing in C10 | C05 task 5; C10's acceptance |
| EnvToken (3.27) | C02 | C02 tasks 3 and 7; N04 |

Database roles (section 2): `devos_calisma`, `devos_denetim` and `devos_sinav` in C02; `devos_backup` and `devos_ci` in C02, for C03; `devos_ingest` in C04; `devos_kurulum` for the installation only. Functions (section 4) and jobs (section 5) follow their families, with the exceptions stated there.

### 3.1 Mission — authorized purpose

**Fields:** `id`, `revision`, `purpose`, `scope`, `constraints` (references to Constraint), `acceptance` (acceptance boundary), `owner_authority` (reference to Batu's decision record), `status` (active / paused / closed).

**Rules:** A mission is opened or widened only by a decision that belongs to Batu. Opening internal work cannot widen the mission's scope.

### 3.2 Need and Inquiry — need and discovery

**Fields:** `id`, `mission_ref`, `condition` (what is missing), `origin` (`goal`: required by the goal / `method`: required by the chosen method / `useful`: merely useful), `method_ref`, `why_needed` (**mandatory**: which decision or action would be wrong without it), `evidence_for`, `evidence_against`, `assumptions`, `alternatives` (at least one alternative path, or the reason for "no alternative"), `consumer`, `return_to`, `uncertainty`, `status` (open / investigating / resolved / dropped / superseded).

**Rules:**
- If `why_needed` is empty, the record is rejected (the unnecessary-prerequisite brake, plan K-1).
- A need with `origin = method` automatically falls back into re-evaluation when the method changes.
- An Inquiry's result is linked to `return_to`; an inquiry cannot be closed before the result has returned.

### 3.3 Work and WorkStanding — work and its states

**Work fields:** `id`, `revision`, `mission_ref`, `mission_revision`, `scope`, `purpose`, `input_refs`, `target_refs`, `consumer`, `return_to`, `stop_rule`, `acceptance_ref`, `impact_class` (routine / high; set by the rules below), `effort_policy_ref`, `method_refs`, `mandatory_needs` (written by the work's consumer; each: what must be known, why, at what depth; revised only with a new work revision).

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
- `impact_class` follows rules, not the agent's choice (PC-08). A work item is `high` when it changes a path on the high-impact path list (plan 6.7: rules, roles, methods, schema, security and release settings), creates or changes a cost, touches a matter that belongs to Batu (purpose, scope, cost, his accounts and his other work), or prepares an irreversible external effect. Where the database can decide a trigger, it enforces it: under a work item labelled `routine`, an `Artifact` or `Operation` whose target is on the high-impact path list, an `Operation` whose `effect_class` is irreversible, and a link to a decision of class `high_impact` or `batu` are refused. The other triggers are declared; for a set share of work items labelled `routine`, the database creates a `Review` of kind `sample` for the audit environment (3.11), which also checks the label (Appendix C N29).

### 3.4 Relation — typed relation

**Fields:** `id`, `type`, `from_ref` (+revision), `to_ref` (+revision), `scope`, `hard` (whether it affects readiness), `group_id` and `group_mode` (ALL / ANY), `validity` (current / stale / retracted), `use` (which use it is valid for), `method` (how the relation was made: `mechanical`, from links, heading paths or status files; `model_extracted`; or `recorded`, by a function call in DevOS's own work; PC-16), `epistemic_status` (as plan 6.6: `observation` / `user_decision` / `inference` / `hypothesis` / `proposal`; PC-16).

**Relation types (initial list):** `depends_on` (hard dependency), `supports`, `challenges`, `derived_from` (source derivation), `supersedes`, `uses` (contribution use), `part_of` (composite product), `reviews`, `blocks_effect`, `about` (descriptive), `informed_of` (the content of `from_ref` has been sent to Batu; used by the user model, 3.16; PC-08). Each `informed_of` relation carries its own `sent_at`, `channel` and `delivery_observation_ref` (the Observation, 3.12, that shows he saw it); without that Observation it records "sent", never "seen". These fields are built when `informed_of` is first needed (C06; section 3, "Activation") (PC-16).

**Rules:**
- In hard dependencies a cycle is rejected; in descriptive relations a cycle is allowed.
- An exact repeat of the same relation produces no new record and no new event.
- When a supporting source goes stale, what it supports is not automatically counted as false; the sufficiency of the support falls back into re-evaluation.
- A relation with `method = model_extracted` cannot have `epistemic_status = observation` (PC-16).

### 3.5 Assignment — claim

**Fields:** `id`, `work_ref`, `work_revision`, `declared_session_id` (declared), `role_class` (from the token), `claim_token_hash`, `generation` (the ordinal number of this claim for the same work item), `authority_epoch`, `lease_expires_at`, `last_heartbeat_at`, `status` (active / released / expired / revoked).

**Rules:**
- A work item can have only one active claim at a time; this is enforced at database level by a uniqueness constraint.
- The claim carries an expiry (`lease_expires_at`), built in C02 with the claim. Who sends the liveness signal that extends it, and how, is decided in C06 (EV-C00-012 D18; PC-08). If the time runs out, the claim becomes `expired` and the work item can become ready again.
- Every operation that produces an effect requires the claim token and checks that the claim is still active, its generation current and its epoch valid. Another session in the same environment cannot carry out an operation with someone else's claim.

### 3.6 Grant — permission (deferred)

**Deferred** (PC-08) until an external effect needs a permission narrower than role class plus claim. Until then the authority of an effect is the environment token's role class, the active claim and the authority epoch (3.5; principle 9), and no record refers to a grant. The fields and rules below are kept for its activation.

**Fields:** `id`, `issuer`, `subject` (role class or claim), `scope`, `permitted_effects`, `revision`, `expires_at`, `revoked_at`, `authority_epoch`.

**Rules:** A permission is not derived from the work's free text. Preparation or a retry with a revoked permission is rejected. Reading an operation receipt is not re-authorizing the effect.

### 3.7 Subagent task definition and UseReceipt; Request and Contribution (deferred)

**Subagent task definition (`TaskDefinition`; recorded with the work item, also for subagent tasks within a session):** `id`, `revision`, `work_ref`, `work_revision`, `objective` and the decision it is tied to, `expected_output_format`, `sources_and_tools`, `mandatory_needs` (every mandatory need of the work revision, each met with a source chunk or passage), `unknown_need_checklist_ref` (the list of things that may have been missed for this type of work; plan K-6 item 6), `boundaries` (what it will not do), `effort_budget`, `write_target` (the record the result is written to), `writer` (whether it is the single writer of this product or only a reader; declared), `result_handover` (written with the result: its scope, rationale, uncertainty, intended use and limitations; see the rules).

**UseReceipt fields:** `id`, `consumer_work`, `consumer_revision`, `task_ref` (the task definition whose result is used; a `contribution_ref` once Contribution is activated), `result_ref` (the record or product revision the result was written to), `disposition` (used / used_conditionally / not_used / opened_question), `rationale`, `changed_decision_ref`.

**Request and Contribution (deferred, PC-08):** The protocol for requests and contributions between sessions was built for the role-per-session frame that plan 2.1 dropped. It is not built until a lost hand-off between sessions shows the need. Its fields and rule are kept for its activation. **Request:** `id`, `sender_work`, `recipient` (work item or role), `requested_contribution`, `parent_decision`, `scope`, `source_depth`, `format`, `urgency`, `deadline_reason`, `return_to`, `status` (sent / accepted / narrowed / rejected / fulfilled / withdrawn). **Contribution:** `id`, `request_ref`, `content_ref` (product or finding revisions), `scope`, `rationale`, `uncertainty`, `intended_use`, `qualifiers`, `limitations`, `status` (candidate / delivered / superseded). Redelivery of the same request does not start new work; different content under the same ID shows up as a conflict.

**Rules:**
- A task definition carries every mandatory need of its work revision, each met with a source; one that drops a need or leaves one unmet is rejected (Appendix C F02, structural layer). Whoever writes the task cannot shorten the list; a change of needs is a new work revision with its reason.
- While a task definition that declares itself writer of a product is active, a second one declaring the same is rejected. Inside a session this checks the declaration, not the write: subagents share one identity (plan K-9 item 2 (d)), so the single writer between subagents rests on declaration and is labelled as such. What is enforced is one active claim per work item (3.5), a branch per writer and one merge queue (plan 6.8).
- Only the consumer writes the use receipt; the producer cannot write it on the consumer's behalf. Inside a session both are the session's identity, so there this rests on declaration.
- A result recorded twice for the same task definition (a retried subagent call) gives one record and one use receipt; different content under the same task shows up as a conflict.
- The result is recorded for its task definition with its hand-over (`result_handover`): its scope, rationale, uncertainty, intended use and limitations, which `expected_output_format` requires. They stand in for the Contribution fields of the same names while Contribution is deferred, so that a hand-over loses none of them (Appendix A Section 1). `record_use` refuses a use receipt for a task whose hand-over lacks any of the five. This is a format gate (principle 12): it shows that they are filled, not that they are meaningful.
- "An answer came" and "used" are separate.

### 3.8 Source, Chunk, Finding — source, chunk, finding

**Three separate fields (for every source and finding):** `source_type` (foundation / candidate_study / context / exploration / historical_record / archived_report / legacy_repo), `epistemic_status` (observation / user_decision / inference / hypothesis / proposal), `current_authority` (can_open_work / instruction / information_only). An old genuine observation does not turn into a hypothesis by standing in a historical document; an old decision, being historical, does not count as an instruction today.

**Body reading:** `read_source(source_ref, revision, span)` returns the full body of the source or the requested span; it passes through the privacy filter; the read is recorded as an `Event` of type `source_read` (a `DispatchReceipt` once the context package is activated, 3.9; PC-08).

**Source fields:** `id`, `revision`, `origin_repo`, `origin_path`, `origin_commit`, `branch`, `body_ref` (the body in file storage), `content_owner`, `kind` (original / derived), `authority_status` (foundation / candidate / context / protocol_input / exploratory / historical / historical_trial / exploratory_note), `privacy_class`, `language`, `retention` (keep / archive / retract), `ingested_at`.

**Chunk fields:** `id`, `source_ref`, `source_revision`, `span` (start and end), `heading_path`, `text`, `tsv_tr`, `tsv_en`, `tsv_simple`, `embedding` (its dimension according to the model chosen in C04), `embedding_model`, `privacy_class`, `authority_status`.

**Finding fields:** `id`, `revision`, `claim`, `source_spans`, `qualifiers`, `counter_evidence_searched` (mandatory: the counter-evidence searched for and found, or "none found"), `confidence`, `open_questions`, `fresh_until` (for information that can change), `status` (candidate / reviewed / accepted_for_use / stale / withdrawn), `use_scope`.

**Rules:**
- A finding that carries information that can change cannot move to the `accepted_for_use` state undated or with only secondary sources.
- Sources with a historical status do not overshadow current information in the search ranking; their status is visible in the result.
- The vectors and indexes of chunks are tied to the source revision; they are regenerated when the source changes.
- When the model changes, all vectors are regenerated; vectors of two models are not mixed in the same query.

### 3.9 ContextRequest, ContextPackage, DispatchReceipt — context (deferred)

**Deferred** (PC-08). Under plan 2.1 the coordinator writes a full task definition for every subagent; the rule of this family that F02 tests (a mandatory need cannot be shortened, and an unmet one is rejected) applies to the subagent task definition (3.7). The family, its functions and role DR08 come back when missed-information records (plan U-4) show that task definitions miss needs. The fields and rules below are kept for its activation.

**ContextRequest fields:** `id`, `revision`, `work_ref`, `assignment_ref`, `target_refs`, `use` (discovery / design / production / review / acceptance / recovery), `mandatory_obligations` (each: what must be known, why, at what depth), `access_limit`, `consumer`.

**ContextPackage fields:** `id`, `request_ref`, `request_revision`, `obligation_coverage` (source chunks for each mandatory need), `unmet_obligations`, `view_ref`, `view_hash`, `unknown_need_checklist_ref`, `cache_key`.

**DispatchReceipt fields:** `id`, `package_ref`, `session_id`, `runtime_info`, `observed_extra_context` (as far as it can be observed), `limitations`.

**Rules:**
- Whoever prepares the package cannot shorten the list of mandatory needs; a change requires a new request revision (F02).
- A package with an unmet mandatory need is not accepted; discovery may start for what is missing.
- When the budget tightens, repeated, low-decision-value content is reduced first; mandatory counter-evidence and the authority boundary are not removed.
- The cache key includes the work item and use, the target and source revisions, the permission view, the role and method versions, and the index version (Appendix G).

### 3.10 Artifact and Assembly — product and composite product

**Artifact fields:** `id`, `revision`, `path`, `commit`, `kind`, `status` (candidate / current / superseded).

**Assembly fields:** `id`, `name`, `design_baseline` (intent revision), `working_assembly` (the sequence of realized part revisions), `delivery_baseline` (the accepted whole), `snapshot_id`.

**Rules:** A change in the design does not mean that the working state or the delivered state has changed. Every review carries the ID of the snapshot it reviewed.

### 3.11 Review, Verdict, Acceptance — review, verdict, acceptance

**Review fields:** `id`, `kind` (review / sample), `target_ref` (+revision or snapshot), `claim`, `criterion` (+version), `use`, `basis_refs` (the full set of source, decision and policy revisions the verdict rests on), `reviewer_declared_session`, `reviewer_role_class` (from the token), `independence_level` (same_session / fresh_context_subagent / same_model_other_session / other_view / other_model_family / batu_expert; the six levels of plan 8 item 7), `view_ref`, `shared_with_producer` (what the reviewer shared with the producer: the criterion, the sources, the framing; plan 8 item 7; PC-16).

**Verdict fields:** `id`, `review_ref`, `result` (pass / fail / conditional / indeterminate; PC-16), `evidence_refs`, `objections`, `limits`.

**Acceptance fields:** `id`, `target_ref`, `accepted_use`, `scope`, `current_evidence`, `residual_decisions`, `owner_authority`.

**Rules:**
- The reviewing session cannot be the session that produced the reviewed product or proposed the change.
- The independence level is kept in the record; the acceptance claim is limited to this level.
- A review planned at an independence level that did not run (for example a pass by the second model family) is recorded as missing coverage at that level, in the `limits` of the verdict that did run, never as agreement (plan 8 item 7; PC-16).
- `indeterminate` is the result of a reviewer who cannot decide (missing evidence; a degraded mode of Appendix G G7). It accepts nothing, and the review stays open; the squeeze signal (3.26) does not count it as a failure (plan 8 item 14; PC-16).
- The user's approval of a preference does not count as evidence of a technical fact.
- Binding verdicts and acceptance are written only with the `devos_denetim` role; `devos_calisma` cannot approve what it produced itself.
- When `basis_refs`, `criterion` or `use` changes, the verdict goes stale and a new acceptance is needed; the old verdict is not automatically carried over to another use of the same product.
- The verifier does not repair in the same action: a new revision of the target product cannot be written in the same transaction as a `Review` record.
- A review of kind `sample` is created by the database, never by an agent, for a set share of the records a format gate accepts (principle 12) and of the work items and decisions labelled `routine` (3.3, 3.17); it is queued for the audit environment, which judges the content and the label (PC-08).

### 3.12 Operation and Observation — external effect

**Operation fields:** `id`, `idempotency_namespace`, `idempotency_key`, `effect_class`, `target`, `expected_base`, `payload_hash`, `work_ref`, `assignment_ref`, `generation`, `authority_epoch`, `read_set`, `status` (prepared / attempted / observed / conflicted / abandoned), `attempts`.

**Observation fields:** `id`, `operation_ref`, `source` (the reliable source of the observation), `observed_at`, `observed_effect` (applied / not_applied / unknown), `details`.

**Rules:**
- Same key and same full intent: the existing record is returned. Same key and different intent: conflict (F01).
- At the moment of the effect, the current work item, dependencies, claim (active, current generation, valid epoch) and read set are re-checked (F08); `grant_ref` and the grant check join when Grant is activated (3.6; PC-08). Which dependencies enter the read set is determined on the server side according to the operation type; it is not left to a short list written by the agent.
- Observations are appended, not deleted; a later "unknown" does not erase an earlier "applied" (F07).

### 3.13 Event — event

**Fields:** `id`, `aggregate_type`, `aggregate_id`, `aggregate_revision`, `tx_id`, `event_type`, `payload`, `role_class` (from the caller's token, never declared), `declared_session_id` (declared), `created_at`, `exported_at` (PC-08).

**Rules:** The growth of the event ID is not by itself a global order; export and monitoring work with the transaction ID and the object revision. The event record is the source of the hourly export.

### 3.14 Release — rules, roles, methods

**Fields:** `id`, `kind` (common_rules / role / method / config), `name`, `version`, `content_ref` (commit), `applicability`, `owner`, `trial_ref` (exam run), `rollback_to`, `status` (proposed / trial / active / retired).

**Rules:** A method file being in the repository does not mean that it is active; being active is determined by the release record. The proposing role cannot activate the same release.

**Activation** (PC-08): not built in C02. C05 decides, before role activation needs it (Appendix A section 6 item 7), whether "active" is this release record or "merged into `main` with a gate-required measurement and a verdict from another role", trial packs being loaded from a branch for exam runs (EV-C00-012 R13), and builds that form; C10's method changes use it. Either way the proposing role cannot activate its own change.

### 3.15 Competence and EvalRun — competence and exam

**Competence fields:** `id`, `role`, `task_class`, `model_and_settings`, `tools_and_context_method`, `eval_refs`, `result_summary`, `known_limits`, `retest_triggers`, `valid_for_release`, `status` (current / retest_required / retired; PC-08).

**EvalRun fields:** `id`, `eval_set_id` (ID only; the content is in `devos-evals`), `eval_set_version`, `subject_role`, `subject_release`, `runner_session`, `results` (positive and negative examples separately), `run_at`.

**Rules:** When the model, the role text, the tool set or the context method changes, the related competence's `status` becomes `retest_required`. `EvalRun` and `Competence` are written only with the `devos_sinav` role, and `EvalRun` is read only with it. Other role classes read a competence only through `competence_summary(role)`, which returns `task_class`, `model_and_settings`, `tools_and_context_method`, `known_limits`, `status` and `valid_for_release`, never `eval_refs` or `result_summary`; `session_brief(role)` uses it for the role's competence profile (plan 6.5 item 1; Appendix A 3.3), and release activation uses it to see that the exam was passed (PC-08). Exam tasks are opened in the working environment as ordinary `Work`; in the `Work` record, the fact that the task is an exam is kept in a field the working environment cannot see.

**Common evidence envelope (`EvidenceEnvelope`, for all evidence):** `claim`, `target_commit`, `deployment_config_ref`, `criterion_version`, `inputs_ref`, `observations_ref`, `raw_evidence_ref` (private content in the database or in private file storage), `independence_level`, `evidence_layer` (structural / semantic / behavioral), `run_at`. A `pass` obtained on a different target or version cannot close the new installation.

### 3.16 UserModel and Constraint — user model and constraint

**UserModel fields:** `id`, `domain`, `level` (expert / knowledgeable / limited), `evidence_original_tr` (Batu's Turkish wording, verbatim), `evidence_interpretation_en`, `decision_types_owned`, `updated_at`.

**Constraint fields:** `id`, `statement` (English), `statement_original_tr` (Batu's Turkish wording, verbatim), `source` (Batu's decision), `kind` (budget / tool / scope / time / other), `questionable` (always true), `conflicts` (contradictions detected), `status` (active / revised / withdrawn).

**Rule:** When a contradiction between a constraint and what the work requires is recorded, a Batu decision is opened automatically (3.17).

### 3.17 Decision — decision

**Fields:** `id`, `revision`, `class` (routine / high_impact / batu), `question` (English), `presented_text_tr` (in the `batu` class, the Turkish text shown to Batu), `answer_original_tr` (Batu's answer, verbatim), `answer_interpretation_en`, `why_this_owner`, `options` (each: description, purpose, benefit, cost, risk), `alternatives_considered`, `single_viable_path_reason`, `premises`, `criteria`, `evidence_refs`, `assumptions`, `reversibility`, `reopen_triggers`, `recommendation`, `recommendation_rationale`, `if_unanswered`, `alternatives_state` (compared / single_viable_path / open_exploration; PC-08), `status` (draft / open / answered / accepted / superseded / withdrawn), `answer`, `answered_by`, `answer_channel_ref`, `answered_at`.

**Rules:**
- Decisions of the `high_impact` and `batu` classes cannot move to the `open` state until the result of the alternatives research (the compared options, or `single_viable_path_reason`, or `alternatives_state = open_exploration`), the criteria, evidence, assumptions, `premises` (premise inventory), reversibility and the reopening conditions have been entered (format gate). A decision opened with `alternatives_state = open_exploration` cannot be answered or accepted until the compared options or `single_viable_path_reason` are entered (plan K-3 item 2; PC-08).
- The answer to a `batu`-class decision can come only from Batu's identity: B3 = (a) was chosen, so the answer is processed only after the decision channel's intake has verified that it came from Batu's GitHub account (plan 6.9). Option (b)'s `devos_batu` role is removed (PC-08).
- When a new decision is opened, related earlier decisions are queried and linked to the record; an earlier decision is reopened only with new material information or a changed goal. A recorded defect in the earlier decision's basis is new material information: a reasonable alternative it never considered (absent from its `alternatives_considered`), one of its `premises` shown false, or a failed from-scratch test on the same evidence (Appendix D, D1). Re-arguing the same evidence in the same frame is not (plan K-3 item 3; PC-16).
- `class` follows rules, not the agent's choice (PC-08). A decision is `batu` when it concerns a matter that belongs to Batu (purpose, scope, cost, his accounts and his other work; plan K-11 item 7), and at least `high_impact` when it concerns the schema, the rules, roles or methods, security, a cost or an irreversible effect. Where the database can decide, it enforces it: a decision that opens or widens a Mission cannot be below `batu`, and from Constraint's activation (C05, section 3) neither can one that changes a Constraint; a decision tied to a work item of `impact_class = high` cannot be `routine`. A set share of the decisions labelled `routine` falls to the sample review (3.11).

### 3.18 EffortPolicy — effort policy

**Fields:** `id`, `work_ref` (empty for a standing policy), `work_class` (for a standing policy: the class of work it covers and its conditions), `standing_policy_ref` (for a work item that uses a standing policy), `level` (high by default), `expert_assessment_ref` (expert assessment; cannot be empty for any work item), `reduction_reason`, `approved_by_role_class` (`devos_denetim`), `non_removable_steps` (verification, alternatives research, external source research for high-impact work), `status` (active / retired).

**Rules:** `expert_assessment_ref` and `non_removable_steps` cannot be emptied for any work item (format gate). A reduction needs the audit environment's approval: its own approval for the item, or a standing policy that the audit environment approved in advance for a class of work (for example "a short direct query runs at a stated lower effort"); a work item of that class uses the policy without a new approval, and anything outside a standing policy needs its own approval. A standing policy is written and retired only with `devos_denetim`; an item cannot cite a retired policy. That an item belongs to the policy's class is declared and falls to the sample review (3.11). **Why the audit environment** (criterion 15 asks for "another role's approval"): inside one session every role shares one identity (plan K-9 item 2 (d)), so the database can verify another role's approval only when it comes from a separate environment; an approval inside the session would be self-approval by declaration (PC-08).

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

### 3.24 SessionRecord and LaunchRecord — session and launch

**SessionRecord fields:** `id`, `role_class` (from the token), `declared_session_id`, `routine_ref`, `started_at`, `last_seen_at`, `ended_at`, `handoff_ref` (structured hand-over record).

**LaunchRecord fields (for emergency API triggers):** `id`, `routine_ref`, `reason`, `intent_at`, `returned_session_id`, `result` (started / uncertain / failed / reconciled), `reconciled_by`.

**Rules:** A launch whose response is lost stays `uncertain`; before a retry, its counterpart is searched for in the session list and in `SessionRecord`. Blind repetition is forbidden.

### 3.25 ProtocolAudit — thinking discipline audit trail

**Fields:** `id`, `work_ref`, `trigger` (work_item_start / material_change), `change_ref` (for a material change: the new evidence or the changed plan), `role_class`, `protocol_release`, `results` (for D1–D9: loaded / skipped + reason / unavailable), `recorded_at`.

**Rules** (PC-08): A record is written at the start of each work item and after each material change of plan or evidence, never after every tool result or every turn; the result of the recording call is not a trigger. The record is the agent's own report (self-report): a hint, not evidence (plan 7.3); whether the disciplines are applied is measured by exams (Appendix D section 1). If a required discipline is `unavailable`, the related work cannot advance until a later record shows it available.

### 3.26 Premise, FrameReview, MechanismAssumption — frame review

**Premise (deferred, PC-08):** premises are held once, in `Decision.premises` and in design documents, until premises must be shared across designs; then this table is activated. Its fields, kept for that: `id`, `design_ref`, `statement`, `origin` (user_decision / source / prior_design / assumption), `still_valid`, `from_scratch_test` (would we choose it from scratch?), `reviewed_at`.

**FrameReview fields:** `id`, `trigger` (squeeze_signal / major_design / phase_gate), `design_ref`, `counter_design_ref` (the design of a session that does not see the current design), `commissioned_at`, `design_submitted_at`, `comparison` (each difference, with how it was closed and why), `decision_ref`.

**MechanismAssumption fields:** `id`, `mechanism_ref`, `compensates_for` (what the model cannot do on its own), `last_tested_at`, `test_result`, `retest_triggers` (model or platform change).

**Rules:**
- A `FrameReview` work item is opened by itself when (a) a second correction proposal (`Learning.class = proposal`) is linked (`about`, 3.4) to the same failure-class record (`Learning.class = failure_class`), or (b) the same work item fails a second time. A failure is a `fail` verdict on its output, a revoked claim, or a claim that expired or was released with a recorded abandonment (the release, or the session's structured hand-over (3.24), records that the attempt is given up, with the reason). A claim released with a hand-over that continues the work, a finished result awaiting review, and an `indeterminate` verdict (3.11; PC-16) are not failures: work carried across sessions by hand-over opens no review (Appendix C N20). In case (b) the work item is not claimed again until the FrameReview is open. The signal sees only these records: a squeeze recorded under different failure-class records, or not recorded, does not trigger it (plan U-7; PC-08).
- **Seal** (plan 6.12 item 3; PC-08): for `trigger = major_design`, the FrameReview is opened when the design work is admitted, and the counter-design is commissioned then, from the purpose, the constraints and the criteria only (`commissioned_at` before any design revision exists). Until `design_submitted_at` is set, the database returns `counter_design_ref` only to the claim of the counter-design work item and to the audit environment. Inside one session, which holds every claim it opens, the seal rests on declaration and is labelled as such (plan K-9 item 2 (d)). The decision cannot be accepted until every difference in `comparison` is closed with its reason.
- The `Decision` record of a major design decision cannot be opened without carrying `premises`.

### 3.27 EnvToken — environment token

**Fields:** `id`, `role_class`, `token_hash`, `issued_at`, `revoked_at`, `authority_epoch`.

**Rule:** The token itself is kept in no table and no record.

---

## 4. `devos_api` functions

Each function: permitted roles, checked conditions, the event it produces. On failure, an error with a reason is returned and the rejected attempt is recorded.

| Group | Functions | Key checks |
|---|---|---|
| Session | `session_brief(role)`, `register_session`, `record_handoff`, `record_launch`, `reconcile_launch` | Role class from the token; the `role` parameter only selects which role package is loaded. An uncertain launch is not repeated blindly |
| Mission and need | `open_mission`, `revise_mission`, `record_need`, `resolve_need` | Mission only by Batu's decision; `why_needed` mandatory for a need |
| Work | `admit_work`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` | Scope and revision; link to the mission revision |
| Readiness and claim | `ready_works()`, `claim(work_id)` → claim token, `heartbeat`, `release` | Single active claim; epoch and generation; expiry; effects require the claim token. `heartbeat`'s sender and form are decided in C06 |
| Relation | `relate`, `retract_relation`, `affected_entities(root, limits)`, `explain_paths(root, target, limits)` | Cycle rejection in hard dependencies; the result carries completeness information |
| Task and use | `record_task` (C04), `record_use` (C06); `send_request`, `answer_request`, `deliver_contribution` deferred with Request and Contribution (3.7) | Mandatory needs not shortened; one declared writer per product; only the consumer writes the use (declared inside a session) |
| Knowledge | `record_finding`, `review_finding`, `search(query, modes, filters)`, `read_source(source_ref, revision, span)`, `ingest_source` (only `devos_ingest`) | Date and primary source for information that can change; the privacy filter is applied first; three status fields |
| Context (deferred, 3.9) | `request_context`, `build_package`, `record_dispatch` | Mandatory needs cannot be shortened |
| Product | `register_artifact`, `update_assembly`, `snapshot_assembly` | Design and working state separate |
| Review | `open_review`, `record_verdict`, `accept` | Only `devos_denetim`; `basis_refs` mandatory; no repair in the same transaction; `sample` reviews are created by the database |
| External effect | `prepare_operation`, `record_attempt`, `record_observation` | Full intent; re-check at the moment of the effect |
| Decision | `open_decision`, `answer_decision`, `link_prior_decisions` | Mandatory fields by class; class by rule; answer identity |
| Learning and exam | `record_learning`, `record_eval_run`, `competence_summary(role)`, `propose_release`, `activate_release`, `rollback_release` | The proposer cannot activate; an exam is required; `competence_summary` returns no exam content (3.15); the release functions take the form C05 decides (3.14) |
| Limits | `record_usage`, `budget_status` | A decision is opened at the threshold |
| User and policy | `record_constraint`, `revise_constraint`, `update_user_model`, `set_effort_policy`, `record_dead_end`; `grant`, `revoke_grant` deferred with Grant (3.6) | Effort reduction only with audit approval, for the item or by a standing policy; constraint change with a decision record |
| Discipline and frame | `record_protocol_audit`, `open_frame_review`, `record_mechanism_assumption`; `record_premises` deferred with Premise (3.26) | Without a required discipline, work does not advance; premises mandatory in major design (`Decision.premises`); a counter-design is sealed until the design is submitted |
| Backup | `mark_exported` (only `devos_backup`) | No other write |
| Deployment | `deployment_drift(expected)` (the migration job and `devos_ci`; from C04 also inside `session_brief`) | `expected` is the set of migrations and function versions at a `main` commit; the result lists every difference from what the database records as applied and deployed; "no difference" only when the comparison ran in full, otherwise "could not check" (plan 6.2, 8 item 14; PC-16) |
| Recovery | `begin_recovery`, `advance_recovery_stage` | The order is not skipped; epoch increment |

**Activation** (PC-08): each function is built with its family (section 3). Exceptions: `session_brief(role)` and `register_session` in C04, `record_handoff`, `record_launch` and `reconcile_launch` in C06; `answer_decision` with answer identity in C06; `mark_exported` in C02, for C03's test (8); `deployment_drift` in C02, with the migration path (plan C02 task 0): in C02 and C03 the migration job runs it after every apply and the checks of every later pull request run it, and from C04 `session_brief(role)` also runs it at every session opening and stops the affected work (PC-16).

---

## 5. Scheduled jobs

| Job | Frequency | Output |
|---|---|---|
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

**Activation** (PC-08): the job that marked ready work every few minutes is removed; readiness is the momentary result of `ready_works()`, and `claim` re-checks it (3.3). The expiry of claims is built in C02 with the claim; whether it is applied by the expired-claims job or computed when `claim` and `ready_works()` run is chosen in C02 with the tests (section 8). The deadlock scan is activated in C06; limit tracking in C04; the constraint contradiction scan in C05; the purpose audit, the capability gap scan, the silent-failure sampling, the stale record and link check and the assumption inventory testing in C10.

---

## 6. Session launch contract

- In the normal flow, sessions start through scheduled routines (plan Section 6.4); the database sends no trigger.
- In emergencies (Batu's awaited decision has arrived and work is waiting; recovery), an API trigger from the reserve budget is used. The trigger sends only the work ID; the session reads the actual information from the database.
- Every trigger is recorded as a `LaunchRecord`; an uncertain result is not repeated before it is reconciled.
- Every session registers itself at opening with `register_session`.
- **Independent monitoring:** A path independent of the DevOS components (for example a scheduled GitHub Actions job in `devos-backup`) checks the time of the last session record, the last backup and the last ingestion; if the expected interval is exceeded, it opens an issue assigned to Batu. This path also notices routines switching themselves off and Actions minutes running out. It also notifies Batu of every commit pushed to `agentic-os-search` with a credential DevOS's sessions can use: the machine account's, and the Claude GitHub App's if C01 #12 shows that sessions reach the library through it (observation of the single-writer principle, and of whether C04's removal of that access held; whether the job can read who pushed each commit is settled when it is built, C09). The path is independent of DevOS's runtime components, so that it notices their failure; it is not independent of DevOS, which builds it and can change it, so this signal is not safeguard 2 of Section 0.5 of the plan (PC-07, alternative E): that safeguard is a setting outside DevOS's control, Batu's decision D-014.

---

## 7. Search details

- **Keyword search:** `tsv_tr` (Turkish), `tsv_en` (English), `tsv_simple` (language-independent; technical terms and identifiers).
- **Semantic search:** the model chosen in C04; the query vector is produced on the session's own machine.
- **Merging:** Keyword and semantic results are merged with a rank-based merging method; the merging setting is chosen with the C04 benchmark.
- **Status:** Results carry their authority status; historical sources do not get ahead of a current source of the same relevance.
- **DevOS's own knowledge** (PC-08): every knowledge-bearing record DevOS makes (Finding, Decision, DeadEnd, Learning, UserModel, Constraint) is reachable by the same keyword, semantic and relation searches as library chunks, through a catalogue entry written with the record or one search view over them (chosen in C04); a family is covered from the stage that activates it.
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

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*
