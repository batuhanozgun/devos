# Note17 — Rust evaluation registry and actual use

**2026-09-19 · U10-A / Q06d1 · bounded source inquiry.** Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources and exact coverage](../evidence/U10-A-SOURCES.md), [MR18](../ROUND-U10-A.md), [STATE](../STATE.md). Evidence is source observation, declared dependency contract, inspected test source and explicitly bounded inference. No original Rust execution, live benchmark, new fixture/E08 or adopted remedy.

## 1. Question and bounded answer

How does Rust ECC2 form an evaluation result, admit or reject a candidate, preserve evidence, and expose the accepted choice to actual use?

The implemented route is an **operator-driven recorded-evidence registry with a transactional promotion gate**. It can identify and retain a candidate artifact, compare supplied paired scores against supplied thresholds, check a candidate-keyed health assertion, preserve rejection or rollback records, and change a registry pointer. These are useful implemented operations, not merely documentation.

It is not, on this route, a system that generates trials, independently determines task quality, deploys the candidate into running harnesses and measures the deployed result. The pinned README explicitly limits the feature to registry state; the actual main/store/launcher paths support that boundary. Absence of automatic deployment is therefore not an undiscovered failure of a promised live-learning loop. A future claim about such a loop would require additional producers, authority and consumers.

The important separation is:

`candidate integrity → supplied measurement comparison → registry admission → runtime adoption → actual effectiveness`

This implementation joins the first three in a bounded way. The latter two are not established by a successful promotion result.

## 2. The actual path, not one generic evaluator label

| Stage | Implementation | Actual meaning |
|---|---|---|
| Record | main Record → CandidateSpec → StateStore record | Canonical candidate JSON and normalized trace/evidence reference strings receive a content address and persistent row |
| Bootstrap | ActivateInitial → transaction and audit | Operator selects the first existing candidate; this is not a scored promotion |
| Read measurements | RecordedEvidence → RecordedEvaluator | Parse supplied scores and exactly one candidate-keyed health assertion |
| Pair | evaluate_paired | Retrieve candidate and baseline scores for each explicitly requested distinct seed |
| Compare | PromotionPolicy::compare | All supplied arithmetic thresholds must be met |
| Admit | evaluate_promote_and_health_check | Validate the current baseline, conditionally change the active slot, inspect health and preserve the corresponding outcome |
| Read audit | harness_audit_entries → verifier | Check specific persisted health-integrity and event/evaluation correspondences |
| Launch a worker | main Config::load → manager run_session → profile/command builder | Uses normal configuration and session profile; no candidate-registry application step is present in this examined path |

Sources: S218; re-entered S186/S187/S190/S195; S10 for the feature's stated contract. The module's Evaluator trait is an extension interface, but the shipped CLI instantiates RecordedEvaluator, and the store accepts the recorded-v1 evaluator name. A trait definition is not evidence that a live, independent or shell-command evaluator is available on this CLI path.

## 3. What the candidate hash actually binds

CandidateSpec canonicalizes JSON objects recursively and normalizes reference lists by trimming, sorting and deduplicating. Its v2 SHA-256 input includes the canonical JSON value, trace reference strings and evidence reference strings. Changing a normalized reference can change the candidate identity even when the configuration itself is unchanged. The constructor bounds canonical configuration size and reference count/length; empty references are rejected.

The distinction is **reference text versus referenced evidence**. This constructor does not fetch trace:// or evidence:// content, verify its author, freeze remote bytes or determine whether the evidence supports the configuration. A stable link string can still point at changed material. An operator could also use an externally immutable, content-addressed reference; this code does not establish that property by checking only its string. The hash binds the supplied artifact, not the truth of every claim it mentions.

The JSON input is a serde_json Value, not a validated live Config or a guaranteed applicable harness patch. It can be recorded without proving how it maps to a runner's model, prompt, tools or permissions. This is consistent with a generic candidate registry but matters before treating a recorded candidate as deployable.

record_harness_candidate verifies the reconstructed content address, inserts without replacing a conflicting row, then checks stored content against the expected artifact. Covered UPDATE/DELETE operations are blocked by database triggers. A repeated matching record can be idempotent; a conflicting record is not silently accepted as the same candidate.

Legacy v1 identities address canonical configuration alone. The migration can register a normalized v2 alias pointing to the existing physical row, preserving old foreign keys and audit history. It checks candidate/alias consistency and rejects incompatible collisions. That preserves historical identity without retroactively making old reference strings authenticated evidence. A returned v2 alias and a physical legacy id in an old audit are not automatically inconsistent.

## 4. Paired seeds are matched records, not proof of independent trials

The CLI reads a bounded measurements file containing evaluator, scores and health. RecordedEvaluator requires recorded-v1, bounds score entries and demands exactly one candidate-keyed health assertion. Requested scores must exist, be finite and lie between zero and one. evaluate_paired rejects an empty seed list, more than 10,000 requested seeds and duplicate seeds.

For each requested seed, the evaluator retrieves candidate and baseline values from its map. There is no experiment launch or model call in that method. Consequently, distinct seed labels establish distinct lookup keys, not independent runs, equivalent task conditions, a common dataset version or an unbiased sample. Those may be true of the external process that produced the file, but the caller must supply the corresponding evidence.

The CLI also chooses which seeds to request. The code does not require using every score contained in the file or bind the selection to an earlier evaluation plan. Selected measurements can support a legitimate targeted comparison; their presence alone does not establish complete or representative coverage.

For n paired samples, the policy calculates the candidate arithmetic mean, baseline arithmetic mean, their difference, and the fraction of pairs where the candidate score is strictly greater. Ties are not wins. It fails when sample count, mean delta or win rate is below its supplied threshold. Equality with a threshold is accepted. All failures are retained in the Comparison.

The policy requires positive minimum sample count, a finite mean-delta threshold and a win-rate threshold between zero and one. It does not require a positive delta threshold, nor does it establish statistical significance or uncertainty intervals. These are configurable acceptance rules, not automatically claims of superior performance.

Policy parameters and seed choices arrive with the same Run invocation as the measurements. Their persistence allows later inspection of the rule that was used. It does not prove the rule was fixed before the operator saw the scores. **Saved criteria are not automatically preregistered criteria.** Nothing here independently authenticates task success, measurement provenance or selection neutrality.

## 5. Initial activation is deliberately a different authority path

activate_initial_harness requires a valid-length candidate id, a bounded nonempty activation reference and an existing resolvable candidate. Inside a transaction it refuses when an active default slot already exists. Otherwise it inserts that slot and an initial_activation audit record, then commits.

There is no paired-score comparison or health callback in that bootstrap operation. It establishes the first baseline by an explicit operator action; it should not be described as a candidate that passed the later promotion gate. Conversely, this is not an unrestricted way to overwrite an already active baseline through the same method: the existing-slot check is real.

A reference named approval is not authenticated approval. The source establishes the API's admission conditions, not who supplied the reference or whether they held an external organizational role.

## 6. Transactional promotion and distinct failure results

The store validates identifiers, evaluator, evidence reference and health snapshot/candidate correspondence before beginning the main transaction. It computes the comparison, resolves the candidate/baseline to physical ids, reads the active slot inside the transaction and refuses a baseline that is not current.

| Condition in the examined method | Registry result | Durable evaluation-family result when the operation commits normally |
|---|---|---|
| Malformed evidence, invalid scores/policy, missing candidate or stale baseline | No accepted promotion | These errors return before this method appends its evaluation/audit pair; not every rejected invocation has a durable rejection record |
| Arithmetic policy fails | Prior pointer retained | Evaluation with samples/policy/comparison plus promotion_rejected audit; health callback is not run |
| Policy passes, callback returns matching true | Candidate becomes active registry choice | Evaluation and promoted audit with canonical health snapshot/digest/status |
| Policy passes, callback returns matching false | Prior pointer restored inside the same transaction | Evaluation and promotion_rolled_back audit |
| Callback errors or disagrees with the health snapshot | Prior pointer restored inside the same transaction | Evaluation and health_check_error_rolled_back audit |

The successful-policy path uses an UPDATE conditioned on both the default slot and expected stored baseline; the changed-row count must be one. Restoration similarly checks that the slot still names the provisional candidate. This is a genuine compare-and-swap-style predicate, not the unconditional session-state writes examined in Note15. Do not generalize one subsystem's weakness to this separate registry.

The provisional update, health check, restoration when needed, evaluation insertion and audit insertion are enclosed by one transaction. The declared rusqlite 0.40.2 contract defaults an uncommitted transaction to rollback; explicit commit is required. That is stronger than separately acknowledging each write. It is not a tested guarantee against every storage, panic, crash or custom-callback effect.

The table's early-error row concerns this method's evaluation/audit writes, not a claim that the entire CLI caused no prior effects. Main opens StateStore before command dispatch, and initialization/migration can have separate effects. Likewise, already registered candidate rows are not undone because a later Run fails.

A normal policy rejection or handled health failure is returned as a structured HarnessPromotionOutcome, not necessarily an error from main. The CLI prints the JSON outcome and can finish normally. A caller must inspect promoted, rolled_back and failures rather than use process exit zero as proof of promotion.

## 7. The health check is correlated evidence; rollback is not rollout reversal

For the production CLI, health_evidence_snapshot and health_check both come from the same RecordedEvaluator health map. The candidate binding and result-versus-snapshot equality checks are useful: they prevent accidentally pairing one candidate's health assertion with another or persisting a callback result inconsistent with the declared snapshot. They do not turn the repeated boolean into an independent health measurement.

The generic store method accepts a callback that can error or disagree; the tests exercise such callbacks. The stock CLI callback simply returns its candidate-keyed recorded value. It does not inspect a process after deployment. The existence of the generic error-handling branch must not be narrated as evidence of a live health probe.

The word post-promotion refers here to ordering after a provisional pointer UPDATE but before transaction commit. Under ordinary separate-connection SQLite isolation, other connections cannot see that uncommitted candidate pointer. On an unhealthy result the same transaction restores the baseline and commits the rollback record. This is **transactional registry reversal**, not evidence that workers switched to the candidate, ran, became unhealthy and were switched back.

A future callback that changes an external system would cross a new boundary: database rollback does not itself reverse that external effect. No such callback ran or was adopted here. The result is scoped to the supplied recorded evaluator and examined store contract.

## 8. Audit integrity has a specific, useful scope

The health snapshot contains schema version, evaluator, candidate id and asserted health. The store persists canonical JSON, its SHA-256 digest, the assertion and a health status in both evaluation and audit records. On audit read it checks canonicalization/digest, candidate resolution, assertion equality, consistency of event/status and the corresponding health columns in the linked evaluation.

This can detect missing, altered or inconsistent health metadata. It is not a re-execution of the trial, authentication of the operator, retrieval of evidence references, a recomputation of every comparison, or a signed external transparency log. The verifier's actual predicates matter more than the word audit.

Initial activation and arithmetic rejection intentionally lack health metadata; legacy-unverifiable entries can also be accepted as historical rows without inventing missing health evidence. A successful audit read therefore does not mean every historical entry has the same evidentiary completeness. The legacy flag and event type must survive any summary.

The schema's immutability triggers cover UPDATE/DELETE of candidate, alias, evaluation and audit rows. They are meaningful in-database controls, but a party able to alter schema, replace files or reconstruct coherent records is outside that narrow protection. The inspected tamper test deliberately drops a trigger and removes health metadata, then expects the audit verifier to reject it. That is an error-sensitive test for that mutation, not proof that all privileged tampering is detectable.

## 9. Following actual use closes the registry/runtime distinction

The active_harness_id convenience getter in the inspected store is compiled only under cfg(test). The production evaluator reads the slot internally to establish the expected baseline. The production audit command displays its audit history.

The worker route takes a different path: main loads Config, run_session reads a session profile, agent_program chooses a configured or built-in executable, and build_agent_command/build_configured_harness_command use the task, normal runner configuration and profile fields. Task normalization projects those profile fields into text where the host lacks a corresponding flag. No step in these reviewed builders reads candidate JSON or installs the registry's active choice into the worker.

This explains actual consumers rather than relying only on a search miss. It agrees with the pinned README's explicit registry-only/no-automatic-deployment contract. The bounded conclusion concerns this built-in route. A custom executable could independently read the registry, and this study did not exhaustively search every external adapter, process or future version. Such a consumer would need its own exact-target, loading and effect evidence.

Thus a recorded candidate, a promoted pointer, a configured worker and an effective behavior change remain different states. Registry promotion alone neither changes existing sessions nor establishes the configuration of a future worker on the examined path.

## 10. Test evidence and method result

The module tests inspect canonical/reference-sensitive identity, tamper rejection, seed uniqueness, threshold behavior and evaluation call order. The store's evaluation-specific tests use real temporary SQLite stores, including two synchronized connections for idempotent candidate registration, persisted promotion after reopen, trigger rejection, health false/error, policy failure and legacy alias migration. These are substantive test designs, not only string or mock checks.

None was executed by this research. The concurrent-registration test does not establish concurrent promotion behavior. Constant health callbacks test store branching, not live candidate health. The deliberately altered audit tests a specific detectable inconsistency, not the truth of supplied outcomes. E04 and E07 retain their older scopes and are not repurposed as evidence for this registry.

The method's useful change in understanding is that not every missing autonomous capability is a defect: the source defines a bounded registry, and real control predicates implement that narrower responsibility. At the same time, content addresses, paired labels, health digests and an active slot must not be promoted into stronger claims about truth, independence or deployment.

## 11. Disposition and next responsibility

The original U10-A return condition is met at source level: the candidate and evidence producer, comparison, active-baseline gate, health/reversal, persistent audit and actual built-in use boundary have been joined, with rejection/invalid/failure counterparts and exact dependencies. Completion of publication remains owned by STATE and the receipt, not by this note's existence.

Retain a separate residual for external measurement provenance and statistical validity, criteria/seed preregistration, real health/deployment integration, custom evaluators/consumers, privileged tamper, concurrent promotion/crash behavior, registry-crate/build correspondence and any remediation. No live efficacy or automatic improvement is certified, and no architecture is adopted.

The next distinct unit is U10-B / Q06d2: the Node offline capsule/replay/receipt framework. Re-enter S164 scripts/eval-harness.js → S165 scripts/lib/eval-harness/index.js and S158 tree a862a655eb92a8da013a825d760a7ddfe9e60b23; preserve S166's deliberate execution refusal while following the actual capsule, replay and receipt producers/consumers. Do not transplant either this Rust verdict or the older E04 helper findings. Broad workflow/orchestration, host/provider, release/observability, native synthesis and final omission work still remain.
