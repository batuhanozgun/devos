# Note22 — Backlog coordination and consumption

**2026-09-19 · U11-D / Q04e3 · bounded source answer.** Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources](../evidence/U11-D-SOURCES.md), [MR23](../ROUND-U11-D.md), [STATE](../STATE.md). No new target execution, live model/daemon, SQL experiment or E09. Conditional cases below are source-derived, not observed production incidents.

## 1. The working object is an unread message, not an accepted task result

This controller manages the movement of task-handoff messages:

`unread handoff → recipient treated as lead → delegate selection or creation → onward handoff → old message read marker → routing statistics → pressure/recovery decision`.

That is useful coordination, but it is not a complete task-acceptance protocol. The central distinctions are a message row, a routing attempt, a session/process, a recipient's actual consumption, and a qualified task result. Moving a message can change where work is offered without completing it.

The daemon's automatic path is opt-in: Config::default sets auto_dispatch_unread_handoffs=false. When enabled, its wrappers use the configured default agent and request worktrees, with bounded per-pass lead and per-lead message counts. Explicit CLI operations call the manager directly and are a separate control path. Findings about automatic repetition do not apply unconditionally to default installations. Sources: U11D-M/D/CFG/C.

## 2. What selection and normal acknowledgement actually do

The per-session frontier selects unread task_handoff rows, parses their priority, orders by priority and message id, then limits the result. The global frontier aggregates recipient ids using highest message priority, unread count and age/id tie-breakers. It does not start with a separately declared list of lead roles. A recipient found in this frontier becomes the lead argument to drain_inbox.

Drain resolves that lead, takes its working directory, extracts the task text and calls assignment using the caller's agent/worktree choices. Assignment can use a clear idle delegate, create a child when its candidate team has capacity, reuse an active delegate at capacity when it has no unread handoff, or defer a saturated case. Eligible children are derived from previous handoff relationships and filtered by harness and session state. This is a concrete selection mechanism, not a task-quality or authenticated-role test.

After a routing action, drain marks the source message read. DeferredSaturated does not consume it. This is a real positive control: work that this path declines to route remains eligible for a later pass. However, acknowledgement follows successful routing/admission, not recipient execution or output acceptance.

Forwarding extracts the task rather than preserving an immutable original work envelope. The common handoff builder makes a new message, records current lead context and assigns Normal priority. Original message id/priority/remote requester/profile constraints are not automatically carried as a correlated task receipt. U11-C's propagation boundaries are not repaired merely by another forwarding step. Sources: U11D-M/S/COM; Note21 remains the upstream request explanation.

## 3. A forwarded task can become another request to delegate the same task

In the new-child branch, queueing gives the task to the child through its launch arguments, then assignment writes an additional unread handoff to that child. The latter is also eligible for the global unread frontier. The complete native runtime handles process output, heartbeat and exit state; it does not automatically acknowledge that handoff when the child starts or completes.

Consider the following conditional sequence, with automatic distribution enabled and no intervening consumer reading the new handoff:

1. A receives task T and the controller creates child B for T.
2. A's source message becomes read; a new unread A→B handoff for T remains.
3. A later pass selects B from the global recipient frontier and treats B as a lead.
4. If B has no eligible children and admission succeeds, it creates C for the same extracted T and marks A→B read.
5. The new B→C handoff can repeat that pattern on another pass.

There is no leaf-role, decreasing subtask requirement or task-lineage termination predicate in this examined chain. Per-lead team capacity does not supply a global depth bound. Worktree-capacity queueing can still return an admitted Pending session and allow the handoff to be written before a harness runs.

This is not a claim of inevitable infinite processes, measured cost, or behavior under every host. A real consumer may mark a handoff read, automatic mode may be disabled, admission may fail, or another controller may intervene. Hierarchical delegation can be intentional. The source result is narrower: this frontier does not distinguish a request to execute T from a request to delegate T further, and launching T does not itself remove its companion handoff from that frontier.

The inspected limited-pass test is consistent with that representation: after routing one of two initial inboxes, it expects two remaining unread messages, not one. That assertion tests the resulting message population; it is not an execution result obtained in this study. Sources: U11D-M/S/R/MTEST.

## 4. Rebalancing has useful guards, but its marker rule differs from drain

Rebalancing examines delegates with more than one unread message, looks for an empty idle alternative or spare team capacity, and refreshes those conditions for each candidate. It only moves candidate handoffs whose from_session matches the selected lead. Rechecking changing state and restricting the source relationship are real safeguards.

There is a population difference: rebalance uses all unread messages for its initial load/empty checks, while assignment principally uses unread task handoffs. An informational message is therefore irrelevant to some assignment decisions but relevant to a rebalancing admission check. Do not treat every inbox count as the same load metric.

After assignment returns, rebalancing checks whether the destination equals the old delegate. It does not apply drain's assignment_action_routes_work guard before marking the source read and adding a reroute outcome. If concurrent state changes turn a previously available route into DeferredSaturated, assignment returns the lead id. That id can differ from the original delegate, so the old handoff can be marked read despite no onward routing action. This is a conditional precheck-to-action interleaving, not an observed lost task. Under stable normal inputs the earlier guards often avoid this branch; the normal rebalance test covers transfer to a clear idle delegate, not this concurrent contrast.

The normal test also uses an idle receiver with pid=None and verifies message movement. That is legitimate evidence of the test's intended routing oracle, not proof that a live worker resumed or consumed the task. Sources: U11D-M/MTEST.

## 5. Route, mark-read and summary publication are separate effects

The source ordering is not a single transaction:

`possible session/worktree admission → message INSERT → graph/board projection → old read marker → more projection → controller statistics`.

An error before the old marker can leave onward work plus an unread source that is selected again. An error after the marker can leave that source consumed even though the caller reports failure. Marking uses WHERE read=0, but the caller discards the affected-row count; a competing reader can already have performed an onward action before learning that no source row was newly marked.

This does not mean every error duplicates or loses work. It identifies why Err does not imply rollback and why a late marker is not an exclusive pre-action claim. SQLite's implicit-transaction and mutation-count contracts support this distinction; no new SQL or Rust experiment was performed.

Manager drain/auto-dispatch/rebalance paths propagate a first error. Prior effects remain; later messages/leads may not be attempted. Daemon wrappers record summary counts after manager success, so routing can occur without the latest summary being updated if a later operation fails. The main daemon surfaces the pass error and continues other work categories. Remote intake's per-request failure handling from Note21 must not be generalized to this different loop. Sources: U11D-M/S/D, W-U11D-SQL.

## 6. Cooloff is a persistent condition, not a timed retry delay

DaemonActivity chooses rebalance-first when the previous dispatch deferred work and has no later recovery. Its cooloff predicate becomes true when that unresolved dispatch deferred at least two items, or the recorded saturation streak reaches three. It does not compare elapsed time with a deadline.

During cooloff the daemon attempts rebalancing first. If rebalancing reports zero reroutes, it skips dispatch entirely. The rebalance writer updates rebalance fields only. It does not refresh the last deferred count, advance the saturation streak or clear the old dispatch condition. Thus another cycle can make the same decision from the same controlling history.

A material countercase is newly available capacity without a qualifying rebalance. For example, eligible active children may finish and stop counting against a lead's team capacity, while the lead still has unread work. With no backed-up eligible child to move work from, rebalance can return zero even though a fresh dispatch could admit work. The cooloff branch still does not perform that dispatch. Without another relevant intervention it can remain suppressed across cycles; restart reads the persistent activity and is not itself a reset.

The escalation threshold has a related limit: operator_escalation_required requires a streak of at least five. A state entering cooloff at streak one because multiple items were deferred, or at streak three, need not reach five if subsequent cycles skip the only dispatch writer that advances it. Repeated wall-clock waiting is not counted as additional dispatch failures.

Positive paths remain: when rebalancing produces a route, another dispatch is allowed; successful recovery writes a timestamp and resets the streak. The inspected tests deliberately cover both cooloff causes and suppression of the dispatch closure. They do not test fresh capacity across persistent cycles or guarantee eventual recovery. This is a source-level conditional liveness boundary, not a measured daemon hang. Sources: U11D-D/S and their tests.

## 7. Health, manual maintenance and actual consumption are separate

get_coordination_status joins current unread targets/candidate capacity with historical daemon activity. Its health precedence is escalation, then saturated pressure, then absorbable backlog, otherwise Healthy. These states concern routing pressure; they do not inspect a deliverable, acceptance criteria or task success. A read marker can remove work from this pressure view without completing it, while stale activity can still influence the reported mode or escalation.

Explicit auto-dispatch and coordinate/maintain commands call manager functions directly. They do not pass through the daemon cooloff wrappers or record its dispatch/recovery history. They can attempt routing even while automatic mode is off, but successful manual routing does not by itself prove the persistent daemon condition was cleared. The until-healthy loop is also bounded and stops on Saturated or EscalationRequired, not only Healthy. A command's agent override is used for routing while get_coordination_status uses cfg.default_agent for its pressure estimate.

There is a concrete consumer for inbox records: the CLI Messages Inbox command. It selects a limited recent view of sent/received messages, marks all unread incoming messages for that recipient, then prints the selected view. Consequently, a read marker is not even a guarantee that every marked row was shown in that invocation, much less that a worker accepted its task. An external host could explicitly invoke and consume this output; that integration must be demonstrated rather than inferred from the message table.

The full native runtime and comms module do not provide an automatic inbox-to-stdin pump. A discovered module named session-bridge is instead a shared metrics JSON utility. This narrows the apparent integration lead; it is not evidence that every ECC/custom host lacks a consumer. New-child launch arguments are a real initial input route, reused-agent inbox storage is another route, and neither supplies an authenticated per-message accepted-output receipt in the examined controller. Sources: U11D-C/M/R/COM/BRIDGE.

## 8. Evidence standing and continuation

The bounded return condition is met by the actual frontier, assignment, read-marker, rebalancer, persistent controller, CLI observer and runtime-input boundaries, with normal guards and material continuation contrasts. Relevant manager tests inspect temporary Git/store behavior; daemon tests use controlled futures and recorder callbacks. They were read, not run. No E09, live host/model, installation, credentials or upstream change occurred. Prior E06 exclusion and E08/E07/E05 identities remain unchanged.

Q04e3a has this source answer. Q04e3b retains actual long-running/host behavior, task/message identity and authenticated uptake/acceptance, concurrent routing/marking, fairness, cancellation, leaf/termination rules, cooloff recovery/observer freshness and custom consumers. These are evidence boundaries, not adopted SOUL requirements or proposed ECC patches.

Candidate reuse distinctions include message movement versus work completion; handoff history versus lead-role authority; repeated forwarding versus decomposition; post-effect read markers versus admission claims; persistent inhibition versus timed backoff; current capacity versus old control history; and a readable output channel versus verified worker uptake.

Next selected after publication: U11-E, orchestration-template resolution and launch composition. Follow template variables/profiles/steps into capacity admission, anchor/handoff relationships and partial failure. Determine whether ordered launch descriptions imply execution dependencies or accepted completion. Start at Config::resolve_orchestration_template, manager::launch_orchestration_template and the actual Template CLI arm. Incidental template code already exposed is not completion. Broader host/provider/release/audit/native-synthesis and omission work remain.
