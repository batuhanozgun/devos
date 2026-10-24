# Note 12 — Plan Canvas: feedback, review binding and continuation

**Unit:** U08-A / Q04f. **Date:** 2026-09-18. **Target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Evidence:** SOURCE OBSERVATION, TARGET PROCEDURE and explicitly bounded INFERENCE; no new execution. [Exact source ledger](../evidence/U08-A-SOURCES.md). Historical E06 outcomes are excluded under [the recovery diagnosis](../RECOVERY-U08-A-20260918.md). STATE owns publication and current work.

## 1. Question and bounded answer

How does a particular artifact become the subject of human feedback, and how does that feedback reach an agent and affect its next action?

Plan Canvas supplies a concrete local review channel, not merely an approval label. Its CLI, HTTP server, browser controls and JSON session store form a traceable path from opening a local file to queued feedback and a consumer-readable response. The plan/skill procedures then tell the agent how to interpret a verdict, revise the artifact and continue. This is a different responsibility from Note11's governance-event emitter; no automatic bridge from that emitter into Plan Canvas is established here.

The boundary is equally concrete: artifact path is not artifact revision; server-side draining is not acknowledged consumer receipt; a role/verdict field is not authenticated human authority; ended review is not necessarily an empty queue; and a bounded hook message is not the complete feedback batch. These distinctions arise from the actual paths below, not from the unusable E06 evidence.

## 2. Normal route — the useful mechanism actually present

| Stage | Producer/consumer and actual source behavior | Limit of that stage |
|---|---|---|
| Prepare review | `/plan` describes producing a plan artifact and waiting for confirmation; the command and skill offer canvas review (S175/S182/S183) | Interpreted procedure, not an OS-enforced ban on other implementation tools |
| Open artifact | S163 validates existence, ensures a detached server, posts `/api/sessions` and optionally launches a browser | Successful process launch is not proof that a person saw the page |
| Locate session | S173 resolves the file path, usually through realpath, and hashes that path to a session key; S174 serves the registered file | The key does not hash the file contents or identify an immutable revision |
| Submit feedback | S178 sends chat, annotation and approve/request-changes items; S174 normalizes and queues them through S173 | Accepted means usable input shape, not accepted engineering decision |
| Retain and notify | S173 persists pending items and a textual chat mirror; S174 wakes waiting requests and broadcasts chat/presence | Persistence is conditional on successful writes and readable state; no application acknowledgment yet |
| Receive | `/api/await` drains a batch, and S163 waits for the HTTP response then prints JSON | Clearing the queue occurs before proof that the agent received or acted on that JSON |
| Continue | Skill/command says revise on request-changes; on approve, end review and implement; `await --reply` sends a reply then waits again | The consumer interprets the verdict. Neither store nor CLI independently starts or validates implementation |

The core offers real operations for open/resume, waiting, feedback, replies and end. The server restores file watchers for open sessions after startup. Browser queues are also retained on a best-effort basis in sessionStorage until send succeeds. These mechanisms address genuine communication discontinuities, but operate at different stages and cannot be combined into an unconditional losslessness claim.

## 3. Review object — stable location, changing content

S173's identity is `sha256(canonicalPath)[:12]`. Normalized feedback keeps an item ID, kind, text, server timestamp, verdict or annotation anchor; it does not keep an artifact digest/revision, a snapshot of the reviewed document or a verified reviewer identity. S174 reads the current file when serving it and uses file watching to request browser reloads. S178 sends feedback without a content-revision field.

**Source-derived contrast, not an observed incident:** a person can prepare feedback about revision A, while the file at the same path changes to B. The session key remains the same, and the feedback record does not allow the server to reject that submission merely because the content changed. An annotation's snippet/selector helps a consumer interpret the intended location but does not cryptographically or transactionally bind the decision to the whole reviewed revision.

This is not automatically the wrong interaction model. A live collaborative review may intentionally follow one evolving artifact rather than create a new session for every edit. The stronger claim that an exact final revision was approved, however, needs evidence not provided by this path.

Host and Origin checks are real predicates (S174/S181), with a loopback default. They do not identify the human entitled to approve a particular task. The CLI also exposes a host override; default-local behavior should not be restated as an unchangeable bind restriction. This unit does not attempt a hostile browser/local-process exploit or audit all renderer/SDK behavior. The scoped result is that the examined approval record has no authenticated-person or exact-revision contract.

## 4. Durable queue versus consumer acknowledgment

S173 writes `sessions.json` via a temporary file and rename. On successful queueing, pending items and their textual chat representations are persisted. A new store can load that state. S180 explicitly tests queued-feedback reload and drain-once semantics in its source, but was not run here.

The critical ordering is:

`takeFeedback → clear pendingFeedback → persist cleared state → return batch → server emits response → CLI parses/prints → host/model receives`

There is no acknowledgment or redelivery transaction connecting the latter stages back to the clear. If the receiving CLI or transport fails after the successful drain but before consumer uptake, a later await need not return the same batch. This is a conditional source explanation, not a reproduced network incident. The Node HTTP reference also distinguishes response transmission from client receipt (W-U08A-HTTP).

Conversely, a consumer interrupted before any drain can leave the batch pending for a later call. It would therefore be wrong to replace the target's blanket losslessness language with an equally blanket claim that restarts always lose feedback.

The remaining chat mirror prevents a total-erasure conclusion. It keeps readable messages, but S173's chatLineFor projection drops the feedback ID and parts of the structured annotation such as the full text-range/selector combination. Recoverable transcript text is not automatically a replayable original delivery object. Corrupt or unreadable persisted state is caught and startup can begin with an empty store: an explicit availability trade-off, not guaranteed recovery from arbitrary storage failure. No fsync/power-loss or concurrent-writer guarantee was established.

## 5. Review end is not feedback resolution

S173 refuses a plain reopen when status is ended and endedBy is user; explicit reopen changes that behavior. The server reports the refusal as 409 and the CLI preserves it. An agent-ended session can reopen without that flag. These are useful implemented distinctions. The flag itself does not verify that a human actually requested the new opening.

Pending feedback and session status are separate. `takeFeedback` first checks the pending batch; if the session ended, it returns the batch with sessionEnded and endedBy, then later reports ended. S163 supplies different next-step guidance for a final batch and for an already-ended review.

But three discovery surfaces exclude ended sessions: CLI `pending`, Stop `pendingSessions`, and SessionStart `openSessions` (S163/S176/S177).

**Conditional contrast:** feedback is queued while no agent awaits, and the person subsequently ends review before consumption. Direct await can still fetch that known session's final batch, yet those open-session summaries omit it. A `clear` pending summary then means no pending feedback among the selected non-ended sessions, not no remaining feedback anywhere. This is selective discovery, not deletion of the final message.

A blanket instruction to reopen would conflict with the implemented user-end boundary. The distinction to retain is that stopping the interaction and resolving everything said within it are different states.

## 6. Stop backstop — actual continuation signal, bounded message

The Stop hook is separately registered for minimal, standard and strict profiles (S184). S122 awaits its asynchronous run function and forwards the returned stdout; it is not treating a Promise as an empty result. In its normal enabled path, S176 can emit `decision: block` with a reason. The current official host contract recognizes that as a request to continue rather than stop (W-U08A-STOP). No real host hook was run in this unit.

There are meaningful scope and failure controls: default project-path filtering, an explicit all-scope option, a stop_hook_active escape to avoid repeated blocking, and no block if no batch was drained. This is a recovery backstop, not a supervisor that guarantees an agent is listening continuously. Current host docs also distinguish a normal Stop from user interruption or API failure; registration alone does not cover every interruption mode.

Two source boundaries matter:

- **Drain scope versus visible scope.** S176 drains the entire batch but buildReason includes at most 20 nonempty item descriptions per artifact, plus a count of additional items. IDs, timestamps and full anchors are not preserved in that text. With 21 valid items, the twenty-first may be absent from the hook message even though it has left the pending queue. A final request-changes verdict in that position would not be transmitted verbatim in the visible reason. The browser transcript may retain a textual mirror; no claim of total data destruction is made. This is an unexecuted source counterexample, not a recovered E06 result.
- **Metadata-selected fallback.** collectDeliveries chooses HTTP when server.json yields a truthy port, otherwise direct-file drain. It does not fall back to disk after a failed HTTP drain. Stale port metadata can therefore leave feedback queued while the hook returns no block. This also avoids one unsafe temptation: writing the state file merely because a live server is slow. Absence of a recorded port is not a proof that no competing writer exists; full concurrency/locking is outside this unit.

The registered inline wrapper waits for stream writes to flush and S122 does likewise. These controls address truncated process output; they do not supply the missing consumer acknowledgment or restore content omitted deliberately by buildReason.

## 7. Presence is a bounded observation, not message-specific proof

S174 distinguishes waiting, queued, an active await listener, recent feedback pickup, explicit typing and ended review. Thinking and typing expire rather than staying active indefinitely, and a sweep can rebroadcast the changed state. This is a concrete improvement over an indefinitely stale activity label.

The signals nevertheless concern the session. `markThinking` runs after a batch is taken or an explicit thinking request; it is not evidence of model cognition or completed work. S178 can display a delivered message based on thinking/typing presence. If an earlier batch is still within that presence window while a new message is queued without a waiter, the old session-level signal is not acknowledgment of the new batch. This is a source-derived conditional observation; browser behavior was not executed.

SessionStart lists the first five non-ended sessions without the Stop hook's cwd filter. Session keys also do not identify one assigned agent. Shared-state convenience therefore differs from task-specific routing, actor ownership or authorization. The consumer must still establish that this is the review it should resume.

## 8. Verification boundaries and alternatives

S180's source includes useful positive and negative controls: invalid feedback rejection, one-time drain, store reload, user/agent end differences and corrupt-state startup. It directly calls store functions. It does not test transport loss after drain, exact revision approval, browser identity, the Stop limit, parallel consumers or model uptake. Tests were inspected, not run; historical E06 remains unverified and contributes no observations to this note.

The strongest benign interpretation is a cooperative local review channel whose procedures rely on an agent to interpret and act on feedback. A stronger interpretation as an authenticated approval transaction with guaranteed exactly-once application is not supported by the inspected code. Lack of that stronger contract does not show that ordinary reviews fail or that every system needs the same heavyweight approval design.

Proximate explanations here are specific predicates and orderings: path-only identity, pre-response drain, status filters, projection limits and session-level activity. They do not establish why maintainers historically chose them or that a single patch would solve every continuity problem. No upstream bug report or proposed implementation is part of this source study.

## 9. Research use, residuals and return condition

The normal producer-to-consumer route and material revision/interruption/end contrasts are now explained. U08-A can close as a bounded source study, not as a live-host or effectiveness validation. This repairs the missing source publication without pretending to repair historical E06.

Candidate reuse: separate interaction lifetime, artifact identity, retained record, delivery, consumption, acceptance and action when studying future Work/Information/Actor mechanisms. This is not a new Foundation taxonomy, adopted SOUL architecture or the deferred joint whole-study evaluation.

Q04f1 carries the bounded source answer. Q04f2 retains exact-revision/actor/acknowledgment, ended-session discovery, Stop representation and real-host uptake questions. Reopen before relying on stronger guarantees. The next selected family is U09-A/Q04g: Rust ECC2 command-to-session/process lifecycle, with Node operator consumers followed where load-bearing. Do not spend another unbounded unit on UI details merely because they are adjacent. The U07-A family map and all older residuals remain active.
