# U06-C — Governance events, persistence and decision boundaries

**Date:** 2026-09-18. **Unchanged target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q07c. [Source ledger](../evidence/U06-C-SOURCES.md), [round/MR11](../ROUND-U06-C.md). SOURCE OBSERVATION, TEST SOURCE INSPECTION and qualified INFERENCE only. No new experiment, E06, installation, user-state scan or host/model execution.

## 1. Two concrete paths rather than a demonstrated approval loop

The previous unit identified a first-touch gate, not verified investigation. This unit followed the adjacent governance-capture producer and a real database consumer without assuming either that governance is absent or that similarly named components form a connected system.

| Path | Actual source behavior | Boundary |
|---|---|---|
| Optional hook capture | Selected tool event → pattern/classifier analysis → event object → `[governance]` JSON on stderr → original input returned | Does not itself insert into the database, ask an actor, await approval or return a refusal |
| Explicit state-store API | Caller-supplied governance record → normalization/schema validation → SQL insert/update → pending query → status report and optional attention exit code | Database/reporting mechanism exists; the examined hook and callers do not supply its ingestion bridge |

S141's header says it writes to the governance_events table. Its complete implementation instead emits events with process.stderr.write; it imports no state-store writer. S144 creates a database API but contains no stderr listener or capture importer. S143 reads that database, not the emitted stream. The registered post dispatcher S148 passes the raw event to the hook and does not perform such ingestion either. Retained pre-wrapper/bootstrap code transports outputs, not database inserts.

The narrow result is an unestablished automatic connection in these traced paths, not a repository-wide proof that no external collector or alternate integration can exist. Default-branch searches for governance_events, GovernanceEvent and insertGovernanceEvent found the producer, API, schemas, status and tests, but are not an exhaustive pinned absence test. S151's selected fixture explicitly inserts events into the store; it does not obtain them from the capture hook. Such a test can characterize storage without demonstrating capture-to-storage integration.

A separate logging subsystem can be a legitimate design. The error would be interpreting the header, the existence of the table, or a visible pending counter as proof that captured events automatically arrive there.

## 2. What an event label actually asserts

S141 is enabled only when ECC_GOVERNANCE_CAPTURE has the value `1`, in addition to the enclosing hook/profile conditions. It creates random event IDs and initially null resolution fields. Its ordinary run path always returns the original input; parse failures do not block the tool pipeline. A truncated-input warning can be emitted even when subsequent parsing fails.

| Event | Implemented trigger | Stronger interpretation not established |
|---|---|---|
| secret_detected | Selected secret-like patterns match serialized tool input or a string tool_output | A live credential was verified, exposure occurred, or the original content was removed |
| approval_requested | A Bash approval regex or PowerShell destructive classifier matches command text | An authenticated actor was contacted, permission is pending in the host, or execution awaits that actor |
| policy_violation | A supplied file path matches a sensitive-path pattern | A policy engine evaluated the specific operation and found it unauthorized |
| security_finding | Post-phase selected shell input matches elevated-operation recognition | Privilege escalation or command success was independently observed |
| hook_input_truncated | Caller marks its input incomplete | All missing content was inspected, or the action was refused |

The sensitive-path check does not compare the proposed contents or evaluate a policy document. The registered matcher limits which tool events normally reach it; an arbitrary direct-helper input must not be represented as an actual host event.

Approval classification is not restricted to the pre phase. A qualifying pre event and a later post event can generate different IDs for the same command. The object does not carry a tool_use_id or an authenticated approval identity joining those events into one decision lifecycle. This is a source-derived possibility, not an observed duplicate incident. A higher-level consumer could reconcile them, but that consumer was not established here.

The PowerShell branch uses the same classification function as GateGuard; the Bash branch retains separate regular expressions. Sharing a classifier in one branch is not equivalent to sharing every policy, gate state, exception or final permission decision. For example, the Bash capture regex can flag a force-with-lease spelling independently of GateGuard's distinction between that form and bare force. Different audit sensitivity can be intentional; it is not by itself evidence of a defective policy.

## 3. Data minimization and input fidelity are separate properties

The event emitter deliberately avoids storing the matched secret or entire command in its event object. It keeps categories, a restricted command name and a short fingerprint; sensitive-path events can still contain a bounded path. That is a useful reduction of duplicated sensitive content, not proof of anonymity or removal of the original tool input/output.

The current host contract W17 documents session_id and hook_event_name in hook input, and tool_response for PostToolUse output. The inspected capture code instead gets correlation and phase from ECC_SESSION_ID and CLAUDE_HOOK_EVENT_NAME environment values, and reads only a string input.tool_output for output scanning. S148 does not translate these fields before calling it; the selected manifest entry does not add that translation.

Therefore, under an input using the documented field names without an extra adapter:

- output-only secret-like content in tool_response is not examined by this output scan;
- input.session_id alone does not populate the emitted sessionId;
- without CLAUDE_HOOK_EVENT_NAME, the internal `unknown` fallback is mapped to post because only a value starting with Pre selects pre.

These are conditional source traces. They do not prove that every installed host lacks the environment values or that no alternate adapter exists. The analyzer can receive explicit context, as its unit tests do; that capability does not show the production wrapper supplied it. No native event was captured in this unit.

W17 also distinguishes stderr/debug output at an ordinary zero exit from a model-visible decision or additional context. Emitting a JSON-looking event there is not equivalent to returning a permission decision on the expected channel. This is a current documented interface boundary, not an installation test.

## 4. Persistence is implemented, but it has its own contract

S144 implements real file-backed sql.js storage and exposes S142's query API. It validates file types and selected symlink conditions, uses private creation modes, writes a temporary database file, fsyncs and renames it, and defers exports during transactions. These are concrete persistence controls. Their existence does not authenticate an event's source or establish multi-process concurrency/crash guarantees; none was tested here.

For governance records, S142 normalizes missing optional fields and supplies createdAt if absent, then S145/S146 enforce the entity shape. S147 adds SQL JSON validity and a nullable session foreign key. A non-null session reference must fit the actual database constraints; a log object's apparent shape is not automatically a successful insertion receipt. Deleting a referenced session is defined to clear that attribution rather than cascade-delete the event.

The operation is named insertGovernanceEvent, but SQL uses ON CONFLICT(id) DO UPDATE, including payload, resolution and createdAt. Thus it supports mutable records under the same ID, not an intrinsically append-only audit history. This may be appropriate for current event standing. Claiming immutable provenance would require a different guarantee.

The schema validates structure, not the truth or authority of resolution. eventType/createdAt are nonempty strings; resolvedAt and resolution are nullable strings. There is no required authenticated approver, current-target binding or cross-field rule that verifies why a non-null resolvedAt is justified. The API can therefore represent a resolution without itself establishing that the underlying issue was correctly addressed. This is an API boundary, not proof that real callers supply false resolutions.

## 5. Pending counts and readiness: real aggregation, bounded meaning

Pending is defined by `resolved_at IS NULL`. The count covers all such records in the selected database, while the detail query returns only a limited recent list. This is an important correct separation: a small visible list does not make older pending records disappear from the total.

Conversely, the count does not evaluate the meaning of resolution. A populated resolution string with a null resolvedAt remains pending; a non-null resolvedAt is outside the pending set even if the explanatory resolution is absent. These are source-derived contrasts, not executed fixtures. The count is also not automatically restricted to the current repository or session.

S142 adds pending governance count to other attention signals. S143 preserves that contribution, shows status and can return exit code 2 with --exit-code. That is a usable machine-readable signal for a separately connected caller. It does not itself suspend a prior tool, request human approval, validate a decision or resume work afterward. The CLI also reconciles installation projections, so the whole command must not be described as universally read-only or run against user state casually.

The human and Markdown governance views show identifiers, types, session and creation time but omit event payload details such as rule IDs/reasons/severity. JSON retains those details. A summary is not the full review evidence; the omission should not be generalized to the JSON path.

Most importantly, zero pending records means zero unresolved rows in this database. It does not distinguish a clean, fully observed system from disabled capture, failed parsing, absent ingestion or a different database. The examined governance contribution has no linked capture-coverage or ingestion-freshness check. Overall readiness can still need attention for other reasons, so this is not a claim that every empty database produces a globally healthy deployment.

## 6. Test and causal boundaries

S149 was read fully, not executed. It contains meaningful positive/negative pattern cases, explicit context-based session tests, privacy checks and feature-flag/pass-through behavior. Its truncation test intercepts stderr and deliberately sets the hook-phase environment value. These tests characterize their supplied interfaces; they do not demonstrate database ingestion, actual PermissionRequest integration, authenticated approval, host-field translation or operational safety.

S151's selected state-store fixture seeds records directly, including resolved and unresolved examples. It is not an end-to-end capture test. No previous experiment was rerun and no E06 was created. A synthetic execution could confirm individual branch outputs, but is not required to establish which writer and reader this source invokes. A real collector/host trial would be necessary for the stronger deployment claim and was not implied by source-only closure.

The immediate explanation for the observed separation is concrete: emit writes to stderr; the status reader queries SQL; neither inspected caller supplies the missing conversion. Field selection explains the conditional output/correlation gaps. No unsupported historical story about maintainers' intentions or universal root cause is needed. Separate telemetry can be useful without enforcing an approval workflow.

## 7. Disposition and breadth return

Q07c1 is bounded-answered: actual event classification/output, state-store insertion and resolution predicates, status consumption and the missing demonstrated link between those paths. Q07c2 remains open for a connected collector, real host event fidelity, authenticated approval/resolution, operational prevention and appropriate collector-health evidence. This does not close all ECC governance.

S150's pinned security policy distinguishes embedded AgentShield usage documentation from the separately maintained AgentShield code. It also names delivery/release/CI surfaces and the security guide. These are source-map frontiers, not an executed scan, verified current advisory catalogue or newly authorized external-product study.

Next U07-A returns to P1 material-family accounting: consolidate the pinned topology and existing unit coverage; distinguish still-unexamined ecc2, native workflows/controllers, procedural assets, UI/integrations and scanner/release/evaluation families; select the next consequential mechanism from that map. Existing hooks must not monopolize the research simply because they produce clear local counterexamples. Native synthesis should be built where supporting coverage is sufficient; no premature whole-system CORE or final joint evaluation follows.

Candidate reuse for the later discussion: a classified event, a transported log, a persisted record, unresolved standing, an actual decision and an enforced effect are separate transitions. Their necessary connections must be demonstrated, not inferred from matching labels. No Foundation taxonomy, SOUL design, upstream report or adoption is created by this unit.
