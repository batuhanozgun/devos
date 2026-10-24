# Note21 — Remote intake, dispatch and result boundaries

**2026-09-19 · U11-C / Q04e2 · bounded source answer.** Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources](../evidence/U11-C-SOURCES.md), [MR22](../ROUND-U11-C.md), [STATE](../STATE.md). This is source analysis and conditional reasoning, not a live HTTP/security test, Rust execution, model experiment or implementation. No E09 occurred.

## 1. What the remote system actually connects

The mechanism has three distinct responsibilities:

`HTTP or CLI intake → persistent remote request → CLI/daemon dispatcher → new session or delegate handoff → stored routing outcome → operator/recipient-side consumer`.

The HTTP service does not itself run the dispatcher. Its main command branch accepts connections and records requests. A separate remote run invocation or the daemon's remote pass selects pending work from the configured store. A running intake service alone therefore does not establish that accepted tasks will be dispatched. The relevant processes must also refer to the intended store/configuration; source presence does not prove an installed deployment has done so.

This producer differs from Note20's recurring scheduler. A remote request has a durable status, result_session_id, result_action, error and dispatch timestamp. Those are useful provenance surfaces. However, the result describes routing/admission, not a per-request accepted task outcome. A reused session can receive several requests; one session identifier is not a unique completed-work receipt. Sources: U11C-C/M/S/D/TYPES.

## 2. HTTP success is deliberately an acceptance result

The complete handler supports GET /health and POST /dispatch or /computer-use. Health returns a constant ok and does not check the request queue, dispatcher, live harness or output quality. For the two POST routes, an exact configured bearer string is checked before JSON interpretation and persistence. Wrong credentials receive401. Nonempty task/goal and resolvable target checks reject their relevant invalid cases before insertion; explicitly named profiles are validated by the constructor.

On success, the row is inserted and read back before the service serializes a202 response. That response carries the request's pending state. It does not assert that the worker started or completed the task. This agrees with the intentionally noncommittal meaning of202 in RFC9110; treating all acceptance-only responses as defects would impose the wrong contract. The complete handler does not provide a separate request-status retrieval route; the built-in operator reader is the CLI list/run surface. Source: U11C-C/S, W-U11C-HTTP.

Failure classes are not uniform. An empty task or unresolved target receives400. Malformed JSON propagates to the outer handler and is reported as500. More importantly, insertion and response delivery are not one operation: a row can exist even if its later readback, serialization or response write fails. Retrying the POST creates another auto-increment request; no caller idempotency key is part of this schema. This is a conditional acknowledgement boundary, not an observed duplicate HTTP request or a claim that every500 leaves a row behind.

## 3. Authentication protects one boundary, not every earlier resource use

The token comparison is real and must not be described as absent. But read_http_request runs before route-specific authentication. It first reads headers and then accumulates the declared Content-Length body. The server handles accepted connections synchronously, with no accepted-stream read/write timeout or overall request deadline configured in the examined functions. The parser has a header-size check; that is not an explicit body-size bound. Its handling is a small custom parser, not a demonstrated complete HTTP implementation.

Consequently, a connected peer can occupy that intake connection's read path before reaching the credential decision. With no external deadline, a stalled read can delay later connections handled by this process. The Rust socket contract explains why a missing deadline matters. This is a source-derived resource-control boundary, not a performed denial-of-service test, a measured limit or proof of arbitrary unauthenticated job execution. A proxy, encrypted tunnel, firewall or other deployment control may change exposure and was not inspected. Source: U11C-C, W-U11C-RUST.

The configured listener defaults to loopback in the CLI, but accepts another bind address. The application shown uses plain TCP/HTTP; no TLS layer is configured in these functions. The shared bearer is a capability to use this intake, not a named-user or per-target grant model. The stored requester is the TCP peer IP, which can identify a proxy rather than an individual. No token identity, scope, expiry or grant version is persisted with the request, and the later dispatcher does not recheck the HTTP credential. This is the implemented authority boundary, not a demand that every local control plane implement multi-tenant IAM. A local CLI also has its own direct store-writing trust boundary. W-U11C-BEARER is only a terminology/security reference, not evidence that ECC implements OAuth.

## 4. A target session is a routing anchor, not necessarily the worker

The intake resolves to_session through the session lookup and stores the resulting id. The lookup accepts a first exact/prefix match; it does not establish unique resolution for every short or empty prefix. Supplying an exact existing id is a useful positive case, while ambiguous-prefix and latest semantics remain separate from authenticated target intent.

At dispatch, a present target id is passed to assign_session_in_dir_with_runner_program as a lead. The function examines its prior handoff-derived children, chooses a reusable idle/active delegate or creates a new one. Therefore specifying session A does not mean task execution will occur inside A itself. The returned and persisted result_session_id tells the operator which child was selected. Lead existence is checked, but the assignment function does not require the lead to be in a particular active state before examining its delegates. Sources: U11C-C/M/S.

The intake also records the creator's current working directory, not the remote client's directory. New delegated sessions use the request's stored directory; reusable delegates retain their own directory. Task grouping is descriptive and does not authenticate a repository identity. The native scheduling/lifecycle studies already distinguish saved paths from a preserved or correct environment; this remote path adds another point where requested context and actual receiver can diverge.

## 5. Successful deletion can turn a targeted request into untargeted work

The schema declares:

`target_session_id REFERENCES sessions(id) ON DELETE SET NULL`.

StateStore enables foreign keys. Its session deletion method deletes session-related output/log/messages and then the session, without cancelling the pending remote request. The request mapper reads the resulting null target as None. The remote dispatcher then treats None as permission to take its ordinary new-top-level-session branch.

A concrete conditional sequence is therefore:

1. A pending request is accepted with target session A.
2. A is eligible for deletion and is successfully deleted before a fresh dispatch selection, with the declared foreign-key action active.
3. The pending request remains, but its target is null.
4. The next dispatcher reads it as untargeted and can admit a new top-level session in the stored working directory.

The positive referential-integrity mechanism is functioning: there is no dangling foreign key. What is lost is the distinction between **no target was ever requested** and **the requested target disappeared**. The same null representation selects an execution branch in both cases. This is a composition result of the schema, successful delete, mapper and consumer, not a SQLite malfunction or a live ECC incident. Sources: U11C-S/M and W-U11C-SQL.

Timing matters. If a dispatcher already holds a snapshot containing A before deletion, its subsequent lead lookup can instead fail and record a failed request. Other database dependencies can also prevent deletion. We do not claim every removal silently launches work or that every migrated database has precisely this schema. The bounded claim concerns a successful deletion under the inspected native schema followed by a fresh pending read. No replacement schema or cancellation policy was implemented.

## 6. Reusing an agent does not reapply the requested execution profile

Delegate discovery checks the requested harness and selected session states, using children derived from handoff history. Selection uses unread handoff counts and a lexical context-graph match score. It does not compare the existing delegate's profile, permissions, worktree choice or directory with the remote request's values.

In the reuse branches, the function sends a task handoff and returns ReusedIdle or ReusedActive. It does not reconfigure, restart or otherwise apply profile_name to that already-existing session. The new-child branches instead pass the requested profile to the normal queue/resolution path, where a session profile is persisted. This branch distinction is the important finding, not a blanket assertion that profiles are ignored everywhere. Source: U11C-M and retained queue/profile functions.

For example, a request may name a valid restricted profile while a matching-harness idle delegate already uses a different profile. The constructor can validate the name successfully, yet selection can still reuse that delegate without checking profile equality. The observed source contract does not guarantee that a requested execution constraint follows the task across reuse. The actual delegate might already have equivalent restrictions; no live privilege escalation or model action was measured.

Priority has a similar, narrower propagation boundary. The remote queue orders requests by stored priority. The shared send_task_handoff helper then constructs a Normal-priority handoff and does not include the remote request id or requester. Thus a Critical request can be selected first but become a Normal message in the receiving inbox. The later inbox reader really sorts by message priority, so the distinction is not just a lost display label. It does not prove priority was intended to be global; it defines where the current prioritization guarantee ends. Sources: U11C-M/S/COM.

Computer-use requests go through the same dispatcher. Their constructor applies defaults and renders goal, URL and context into task text. It does not itself supply a browser, authenticated account, device access or successful computer-use execution. Those remain properties of the chosen harness and environment, not of the request_kind label.

## 7. Pending, dispatched and failed have different continuation meanings

| Path | Persistent/request result | What it does not establish |
|---|---|---|
| Target team is saturated | Request remains Pending; current call returns DeferredSaturated | A durable new deferral reason, backoff schedule or guarantee that lower-ranked requests will get a turn |
| New session or reusable delegate is admitted | Dispatched with result session/action/time | Ready harness, message consumption or accepted task output |
| Routing/admission returns an error and failure recording succeeds | Failed with error; the loop can continue to the next request | No prior side effect, automatic retry or compensation |
| Writing success/failure itself fails | Pass returns an error; earlier effects can remain | Atomic rollback or a complete partial result vector |

Pending selection excludes failed and dispatched rows. A saturated request is reconsidered on later passes, whereas an ordinary recorded failure is not automatically retried by that selector. The inspected CLI provides add/list/run/serve paths, not a same-id retry operation. External tools can manage records differently; they were not audited. A permanently saturated high-priority prefix can repeatedly occupy the query's limited batch, so retention alone does not establish fairness. Sources: U11C-C/M/S/D.

Unlike Note20's first-error schedule loop, this remote loop handles many per-request errors explicitly and continues after successfully recording them. That is a real improvement in failure isolation, not a reason to inherit the scheduler's behavior by analogy. But queue creation or message persistence occurs before request acknowledgement. A later error can leave admitted work while the request stays pending or is recorded failed. In particular, send_message inserts the message before graph/board projection; a projection error need not erase that handoff.

The pending query is a snapshot, not a claim. Success/failure updates match only request id and ignore affected-row counts; they do not require a pending state or attempt owner. Competing dispatchers can act on one previously read request and overwrite its result fields. The failure writer changes status/error without clearing a previous result id/action/time, so a delayed competing failure can leave mixed historical fields. These are conditional interleavings, not tested races or duplicate rates. SQL statement safety and a connection timeout do not establish ownership across read, route and acknowledge.

## 8. Stored routing evidence is not recipient acknowledgement

Comms::send serializes a structured message into StateStore. The examined path updates graph/board views but does not write to a worker's input stream or wait for its acknowledgement. Reuse preserves an inbox record, not proof that a live agent read it. A new session receives task text through its launch path, while the added handoff also participates in delegation/history; the two routes have different consumption semantics.

The actual built-in operator surfaces are present: remote run prints outcomes, list --all can include processed/failed requests, and JSON exposes more fields than the compact text list. Default list shows pending records only, so disappearance from that view can mean dispatched or failed. The HTTP health result cannot distinguish those states.

The message-side readers likewise have narrower meanings. The inbox command selects a limited recent view and marks unread messages for the recipient before printing it. A read flag is not successful work acknowledgement. The backlog dispatcher can consume a handoff by assigning it onward and marking it read after routing; that is another control action, not acceptance of output. Deeper team/backlog coordination and its actual worker ingestion remain the next unit, not a completed closed loop here. Sources: U11C-C/S/COM and retained drain_inbox/daemon paths.

The request's persistent result_session_id remains useful for following the selected session. It is more informative than a timestamp alone. However, there is no completed state in RemoteDispatchStatus and the followed writer does not bind a particular remote task to a verified output or caller acknowledgement. We do not infer that no external consumer could add this contract.

## 9. Evidence quality and bounded closure

Three relevant test bodies were fully inspected: priority-based targeted routing, untargeted session admission and computer-use defaults. They exercise temporary repository/store logic and injected runner behavior. The untargeted test writes source=http directly into the database; it does not make a network request or validate authentication. No test was run in this unit, and a search miss did not establish that other HTTP tests are absent.

The source return criterion is met through the actual intake, checks, store, dispatcher, assignment, status writer and operator consumer, with unauthorized-input, target-deletion, reuse and failure/continuation contrasts. A new SQL or socket fixture was not needed to distinguish these explicit predicates. This does not certify installed networking, multi-tenant authorization, multi-dispatch safety or real task effectiveness. Exact scopes and dependency references are in the ledger; no E09, Rust build, live server, model/provider, installation or corrective patch occurred.

Q04e2a has the bounded answer. Q04e2b retains actual HTTP/transport/resource behavior, actor/grant and target/revision authority, migrated-schema correspondence, idempotency/concurrency, profile/environment compatibility, full tests and authenticated per-request worker acknowledgement/acceptance. Previous stronger residuals and experiment identities remain separate. These are unresolved guarantees, not automatically adopted requirements for SOUL.

## 10. Reuse and next responsibility

Candidate reuse distinctions: credential acceptance versus resource admission; request acceptance versus routing versus completion; lead target versus actual receiver; referential integrity versus preserved target intent; valid profile name versus effective recipient policy; queue priority versus propagated priority; persistent routing result versus accepted task output; deferred retry versus failed exclusion; observed read flag versus acknowledged work.

Reopen dependent findings for changes in intake/parser/authority, schema and delete actions, request-to-delegate binding, queue/result ownership or actual consumer behavior. Preserve useful token/input checks, parameterized persistence, explicit failure status, pending retention and operator traceability alongside their limits.

After publication, U11-D/Q04e3 is selected: unread-handoff/backlog selection, assignment/rebalancing and actual consumption/acknowledgement. Start at manager drain_inbox/auto_dispatch_backlog/rebalance_team_backlog, daemon coordinate_backlog_cycle and store unread/mark-read methods, then follow a real downstream consumer. Do not rerun this intake study or silently convert research into a live agent campaign. Broader templates/host/provider/release/audit/observability, native synthesis/CORE and final omission challenge remain.
