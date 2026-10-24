# U07-A — Visual Companion, Interaction Evidence and Lifecycle

Date: 2026-09-17. **BOUNDED SOURCE / MOCKED-CLIENT INVESTIGATION COMPLETE. U07 overall and the whole study remain OPEN.** Primary corpus remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0). METHOD v0.1 is unchanged. Sources S71–S78 and execution E13/E14 resolve through [SOURCE-LEDGER-U07A.md](../SOURCE-LEDGER-U07A.md).

## 1. Question, scope and evidence

How does the optional visual companion turn an approved offer into displayed content, interaction evidence, recovery and shutdown? What does a recorded choice actually establish?

The complete load-bearing source chain was read: brainstorming's entry/consent contract, visual guide, start script, HTTP/WebSocket server, browser helper, frame and stop script. The helper's first-party tests and test-package manifest were read. The exact helper bytes were transferred and Git-blob verified before executing nine source-informed cases against a minimal simulated browser environment. No real browser, HTTP/WebSocket server, host/model, filesystem watcher, upstream suite, installation or external service was executed. E01–E12 were not rerun.

The local experiment observes the actual browser helper with fake DOM, transport, clock and timers. Server-side consequences below are source reasoning unless explicitly identified otherwise. A client send is not proof that a server received or persisted the event. Our criteria distinguish an actual producer/consumer field mismatch from a deliberately overstrong interpretation of a click.

U07 is divided into A (this cohesive visual lifecycle) and B (distribution, remaining adapters and authoring supports). The script/root/test listings obtained here route B; they are not completed packaging investigations. No evaluator audit was reopened, and S01 remains provisional.

## 2. F65 — The companion supplements dialogue; it is neither the whole workflow nor an approval service

**SOURCE — S10/S71.** Brainstorming requires the companion to be offered only when a particular question benefits from visualization, in a separate message, and started after acceptance. Acceptance makes the tool available; it does not require every later question to use it. The guide distinguishes a visual layout comparison from conceptual scope/tradeoff questions and makes the terminal conversation the primary feedback channel.

The loop is agent-mediated: write a screen, explain it and end the turn, then read the interaction file after the user replies in the terminal. The agent combines these records with the user's text. There is no autonomous browser-event-to-approved-design transition in the inspected runtime. A click does not itself advance a plan, commit a spec or authorize implementation.

This is a substantive design choice, not merely missing automation. The two channels carry different information: visual exploration can inform a discussion without replacing the human's explicit clarification or approval. The source-level offer and consent rules are not independently observed user behavior. The launcher has an opt-in browser-open flag, not a stored human-consent validator.

## 3. F66 — Access is concretely restricted, but key possession is not design authority

**SOURCE — S72/S73/S74.** The default bind is loopback. The server uses a generated secret, accepts it through the initial query or subsequent cookie, strips the key-bearing visible URL through a bootstrap page, and authenticates HTTP and WebSocket requests. The WebSocket upgrade also checks a supplied Origin against the request host. The cookie is HttpOnly/SameSite=Strict, while the bootstrap separately places a key in sessionStorage for reconnection. Owner-only file modes and the launcher's restrictive umask protect key-bearing local records at the inspected layer.

The file server selects regular in-content files, rejects symlinks and multiply linked files, and limits WebSocket frame payload size. These are concrete checks rather than a prose-only assertion that the companion is local. They were source-read, not security-tested by this study.

Limits must remain explicit. The same shared key authorizes clients; it does not establish a named human, an approved design revision or the semantic authority of a submitted event. The runtime serves agent-authored HTML and injects a helper; its frame-ancestor CSP is not a general HTML/script sanitizer. The connection URL is HTTP/WS at this surface; a remote transport's separate protection was not evaluated. Do not turn these observations into either universal security certification or a demonstrated exploit.

## 4. F67 — Reconnection restores reachability, not automatically the previous work state

**SOURCE — S72–S74.** Each start-script invocation allocates a fresh PID/time-named session directory. With a project directory, the preferred port and token live at project scope; screens and state live under the newly allocated session. The server reads screens only from its configured session's content directory. Neither the launcher nor server copies the prior session's screens into the new one.

There is a deliberate concurrent-session safeguard. When the preferred port is occupied, a non-explicit token can receive a new port and token; the fallback does not overwrite the project's shared port/token files. With an explicit environment token, that fallback is refused. Consequently, even the same-project restart guarantee is conditional on the original port being available. These branches were read, not executed.

The client retries with capped backoff, displays a paused overlay after sufficiently long disconnection, and re-enters the key bootstrap after a tombstoned recovery. Its event queue is memory-local. In E13/E14, queued events were sent before the recovery navigation; a brief reconnect did not itself request a page reload. The latter case injects no server reload message and does not establish a real fs.watch delivery failure.

**INFERENCE:** if the corresponding server state or displayed question changed while the page was disconnected, a successful reconnect alone does not prove that the old screen, queued feedback and new session refer to the same work. That requires an additional binding or an explicit dialogue reconciliation. No actual cross-session wrong acceptance was observed.

## 5. F68 — The default explicit-choice API and persistence predicate disagree

**SOURCE + CLIENT EXECUTION — S73/S74, E13 C02/C03.** Normal choice-element clicks emit `type`, `text`, `choice`, `id` and timestamp. The server logs parsed events and appends an event to the dedicated `state/events` file only when `event.choice` is truthy.

The exposed convenience API `brainstorm.choice(value, metadata)` instead constructs `{ type: 'choice', value, ...metadata }`. The local execution of the exact helper confirmed that the default call has `value` but no `choice`. A control with metadata explicitly supplying `choice` produced that field.

Therefore the default explicit API output does not satisfy the inspected server's dedicated-file predicate. This is a concrete producer/consumer representation mismatch, not proof that ordinary DOM clicks are lost. The server's broader console logging means it is also wrong to claim that this event can leave no record anywhere. The consequence for `state/events` is source-derived; this round did not launch the server or measure real user event loss.

The current guide routes agents to the dedicated event file, so the distinction matters to retrieval. Successful transport, logging somewhere and visibility in the designated consumer file are different outcomes.

## 6. F69 — A click stream is not a self-contained selection state or a revision-bound decision

**SOURCE + CLIENT EXECUTION — S71/S74, E13 C04/C05/C07/C09.** Multi-select toggles the selected CSS class. The emitted click does not say whether that click selected or deselected the element, and `selectedChoice` is set to the last clicked value in both cases. In the local case, clicking A twice left A unselected while both events still reported A and `selectedChoice` still contained A. A negative control rejected the incorrect inference from that last value to actual selected state.

This falsifies the stronger claim that the last click alone always determines the final selected set. It is not proof that the complete event history plus known UI state can never reconstruct the selection. The guide's advice about a typical final choice must be interpreted alongside its multi-select option and primary terminal feedback, not as a universal approval rule.

The default payload also has no screen/session revision binding. A DOM `id` is optional and not automatically a unique screen identifier. Text can help an agent infer context, but it is not an exact binding. The queued-event case retained its original synthetic timestamp and was transmitted before the recovery navigation. A fresh helper instance did not recover the prior instance's unsent queue.

These observations distinguish four things: the user interacted, a payload was sent, a selected state is known, and a particular design was approved. They must not be collapsed. No model or real user was evaluated, and no false approval was observed.

## 7. F70 — Display persistence, event history and process shutdown have different lifetimes

**SOURCE — S71–S75.** The server selects the newest eligible HTML file by modification time, not a committed design version or explicit publication manifest. A file watcher distinguishes newly observed filenames from updates. On a new HTML filename it clears the dedicated event file, records `screen-added` and broadcasts reload; overwriting a known filename preserves the event file. The guide consequently tells the agent to use fresh filenames and clear stale content with a waiting screen when returning to text.

The server also logs parsed events to stdout. The background launcher redirects that output to a session log, but the normal successful stop script removes the log even for a persistent project session. Keeping mockup files therefore does not imply preservation of the full interaction history. Automatic watchdog shutdown, explicit stop and a later launcher invocation are separate paths, not a single archival transaction.

The stop script validates a per-start instance marker in the target process command line before signalling it. An unprovable or stale PID removes stale metadata and records that condition without signalling the ambiguous process. For a matching process it waits, can escalate, and checks whether it remains alive. These are meaningful ownership/liveness controls, not a name-only kill.

Cleanup uses a lexical `/tmp/*` condition, not the original `--project-dir` flag. A project session placed under `/tmp` also falls under that deletion branch after a successful explicit stop. Conversely, the server's own idle shutdown does not itself remove the entire temporary session directory. These are source-path qualifications to broad persistence/cleanup wording; neither path was executed here.

The owner's watchdog is environment-sensitive: Windows-like launch clears the owner PID, and a dead owner PID at server startup disables that monitor in favor of idleness. A running process, metadata saying it ran, browser reachability and valid current content remain different readiness observations. No all-platform liveness guarantee follows.

## 8. F71 — A local rendering service is not necessarily an offline presentation

**SOURCE — S73/S76.** The default framed/waiting page inserts a remote branding image URL with a version query parameter unless a supported telemetry-disable flag is truthy. The image has no-referrer policy. Full documents can bypass the default frame, while all served screens still receive the helper.

This is a source-defined external-resource path, not a captured network request. No server-side collection, content transmission or received telemetry was observed. Disabling the built-in branding resource also does not prove that arbitrary agent-authored HTML contains no other remote resources. The relevant distinction is local hosting versus the complete set of resources rendered by the browser.

## 9. F72 — The evidence supports a bounded runtime model, not browser or host qualification

S77's header describes pure-function/source checks, but the actual file also contains a simulated browser state-machine section exercising the real helper. We preserve that stronger scope rather than classifying the whole file as string matching. S78 invokes several separate protocol/auth/branding/server/lifecycle suites; their listed existence is not our execution or evidence of universal correctness.

Our nine cases were selected after source inspection and before execution. All nine expected mechanism/control observations were obtained; two explicit stronger criteria were unmet: default API/persistence-field compatibility and last-click-only multi-select interpretation. The runner's successful exit means its observation checks completed, not that the product passed those two criteria.

No native helper test or complete upstream suite was run. The local environment was Node v22.16.0 on Linux x64 with built-in modules only, a synthetic clock, a fake WebSocket and a minimal fake DOM. Real rendering, authentication, file watching, server restart/stop, persistence and model behavior remain source-level or untested. The exact helper Git blob matched before execution; source fidelity is not independent behavioral replication.

## 10. Method reflection, residuals and return

This unit completes a coherent companion chain without treating every newly listed test or release helper as another compulsory audit. It adds a positive native explanation: the companion is a consent-gated, optional presentation and feedback side channel with concrete access/recovery/process controls. Its main boundaries concern how observations bind to current work and which records survive transitions.

New reuse questions:

- Q41: which screen/session/selection state does a delayed or replayed visual event qualify?
- Q42: which record is authoritative for feedback and which interactions survive screen changes, stop and restart?
- Q43: how should endpoint access, live readiness and human approval remain distinct?

These questions do not authorize upstream fixes or a SOUL architecture. Earlier F01–F64/Q01–Q40, source volumes, experiments and S01 remain unchanged.

**Next: U07-B — primary distribution and remaining supports.** Inspect the actual package/sync/version scripts, remaining adapter/install/update surfaces, copied authoring reference and graph conventions/renderer. Scripts were listed but not read here. Preserve U06's release/efficacy boundaries and U07-A's runtime evidence limits. U08 remains native whole-system synthesis followed by selective project-facing projection, not installation or adoption.
