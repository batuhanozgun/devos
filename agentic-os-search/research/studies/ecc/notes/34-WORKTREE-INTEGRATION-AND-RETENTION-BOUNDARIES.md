# Note34 — Worktree integration and retention boundaries

**2026-09-22 · U15-B / Q04i · bounded source answer.** Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U15-B-SOURCES.md), [MR35](../ROUND-U15-B.md), [STATE](../STATE.md). SOURCE OBSERVATION, inspected test definitions and conditional INFERENCE are distinguished below. No target execution, test, real project merge/rebase, installation, live host/model or E10 occurred.

## 1. The missing integration mechanism is real

ECC's Rust controller does more than launch workers and label their exit. It has a local Git integration path:

`attached session/worktree → reconstructed merge queue → Git conflict/dirty checks → actual merge or rebase → optional resource removal → store update → CLI result and daemon summary`.

The queue can detect conflicts with the base and with earlier selected candidates, skip active or dirty work, retry selection after integration changes the base, and attempt a rebase for certain blocked candidates. This supplies the concrete delivery relationship left open by Note33. It is neither a complete semantic acceptance engine nor merely an instruction telling an agent to merge later.

The most consequential result comes from following the containing daemon cycle: **work retained by the merge/rebase path can subsequently become eligible for deletion by a different cleanup predicate.** Correct behavior at one boundary is not necessarily preserved by the next controller. Sources: M-Q, W-GIT, D-LOOP, D-WRAPPERS.

## 2. What qualifies a candidate?

`build_merge_queue` reads sessions with attached worktrees and orders them using a priority helper followed by project, task group, update time and id. Exact priority-helper internals are outside this slice; no universal fairness or exact state-ranking claim depends on them. Each candidate's Git health and dirty status are read, then the following predicates determine blockers:

| Condition | Queue treatment |
|---|---|
| Pending, Running, Idle or Stale session | Blocked as active |
| Git merge preview reports conflicts with the base | Self-blocked with conflict paths and a bounded preview |
| Uncommitted changes are reported | Self-blocked until committed or discarded |
| A conflict with an earlier selected candidate is detected | Blocked behind that candidate |
| No blocker is constructed | Ready, with a queue position |

The single-session merge entry independently refuses those four active states. **Completed, Failed and Stopped are not excluded by that state predicate.** A clean, mechanically mergeable stopped or failed session can therefore reach the Git operation. The inspected normal merge test intentionally uses a stopped session, so treating this solely as a defect would miss its flexible operator use. What is not established is that eligibility certifies task success.

Neither the queue nor the followed merge helper consumes native-review findings, a Canvas approval, a test result, an authenticated human decision or acceptance criteria. External Git hooks, a trusted operator or an outer process may impose additional conditions; no global absence is inferred. The command does not ask Git to bypass hooks. Its responsibility is local integration eligibility, not proof that the change should ship.

`WorktreeHealth::InProgress` is also not the same as session Running: it can mean the preview contains branch changes. Such a worktree can be eligible after the session is inactive and its working copy is clean. Source: M-Q/W-GIT; test source M-TEST.

## 3. Preview and actual Git effect have distinct identities

Worktree creation records a path, a new branch name and the current branch name as base. Its stored worktree description is not an immutable pair of candidate/base commit ids. Base-checkout discovery consults Git's current worktree list, preferring another checkout of the recorded base branch and otherwise returning another-checkout fallback.

The preview runs `git merge-tree --write-tree <base> <candidate>`. Git's documented operation computes a merge tree without updating the working tree or index, but can create tree objects; it is not a wholly effect-free filesystem inspection. ECC treats successful exit as ready, recognized conflict messages as conflicted, and other nonzero results as errors. An unrecognized conflict description is not silently turned into ready. This preview tests mechanical integration, not the change's behavior. Sources: W-GIT/W-HELPERS, G-MERGETREE.

`merge_into_base` supplies further real controls immediately before its action. It repeats the preview, rejects reported candidate dirtiness, resolves the base checkout, requires its currently checked-out branch to equal the recorded base name, and rejects reported base dirtiness. It then runs `git merge --no-edit <candidate>` in that checkout. This is a real local branch/worktree effect, not a push, remote PR approval or deployment.

The repeat check narrows stale-observation risk but does not bind the action to a previously reviewed immutable revision. Names are resolved again by separate commands; the source does not retain the preview tree's OID as the exact object to apply. A candidate or base changing between checks and effect is therefore a distinct concurrency condition. The actual Git operation can still reject it. No changed-ref race or incorrect merge was executed here.

There is a more specific identity boundary in rebase. ECC reads the stored candidate branch's OID before and after, but runs `git rebase <base>` in the stored worktree directory without supplying that candidate as the branch argument or verifying the directory's current branch. If an external actor switched that checkout to another branch, the acted-on current branch and measured stored branch can differ. This requires that change of environment and otherwise successful operations; it is not an observed wrong-branch incident. The normal unchanged-checkout path avoids it. Source: W-GIT/W-HELPERS, G-REBASE.

## 4. Queue progression, rebase and the keep option

With cleanup enabled, `merge_ready_worktrees` delegates to `process_merge_queue`. That function rebuilds the queue, attempts ready candidates, collects per-candidate errors and starts another pass when any merge succeeds. If none succeeds, it can try a clean self-conflicted candidate through rebase, then rebuild again. It does not ask a model to resolve a conflict.

A local map records each attempted session and base-head OID. The same session is not rebased repeatedly against that same base during one invocation. A changed base can permit another attempt. This is a useful bounded retry discriminator, not a durable attempt history or a guarantee of eventual progress across processes. A new invocation starts a new map.

Rebase failure has a real recovery action: ECC attempts `git rebase --abort`, preserves the original failure text and adds a warning for a nonzero abort. A failure to launch the abort is a different error path. The direct tests check that an unsuccessful rebase returns an error while leaving a clean worktree whose branch still conflicts with the base. They also describe a successful rebase after base advancement; none was run by this study.

The merge helper does not have the same abort branch. A failed actual merge returns an error without invoking `git merge --abort`. A previously clean preview is not a promise that the later command cannot fail or stop with conflicts. These failure types must not inherit the rebase helper's recovery claim.

**Keeping a worktree changes more than cleanup.** For a bulk invocation, `cleanup=false` chooses a separate one-pass algorithm rather than the iterative queue/rebase controller. The CLI maps `--keep-worktree` to this argument. The one-pass path still skips active/conflicted/dirty candidates and performs individual checks, but does not gain the other branch's iterative rebase and queue behavior. This is a caller-specific contract, not proof that the option is universally wrong. Sources: M-Q/C-MERGE/W-GIT, G-MERGE/G-REBASE.

## 5. A retained merge failure can be removed by the next daemon step

The actual daemon loop awaits auto-merge, logs any pass error, then invokes auto-prune before pending-worktree activation. Auto-merge checks `auto_merge_ready_worktrees`; the prune wrapper has no matching enable predicate. Defaults are `auto_merge_ready_worktrees=false` and `worktree_retention_secs=0`.

Pruning protects Pending, Running and Idle, but **not Stale**. For other attached sessions it applies a positive retention duration, when present, to `last_heartbeat_at`. Zero bypasses the delay; it does not mean retain forever or disable pruning. The followed prune body does not check dirtiness, unresolved conflicts, merge ancestry, accepted output or a pending human review before calling cleanup.

The complete removal helper normally issues `git worktree remove --force`, may fall back to recursive directory removal, and issues `git branch -D`. Git documents that force can remove an unclean worktree and that forced branch deletion does not require the branch to be merged. ECC's function name `prune_inactive_worktrees` must not be mistaken for Git's narrower administrative `worktree prune` command. Sources: D-LOOP/D-WRAPPERS/CFG/M-Q/W-REMOVE; G-WORKTREE/G-BRANCH.

### Conditional counterpart A — the skipped dirty work

An inactive attached session has valuable uncommitted work. With automatic merge enabled, the merge stage can correctly skip it as dirty. With zero retention, the subsequent prune stage can nevertheless select and force-remove its working directory. With automatic merge disabled, pruning can still occur. This needs an actual running daemon, an eligible record, reached cleanup and successful removal; it does not assert that every ECC launch starts a daemon or that all default use destroys work.

### Conditional counterpart B — the target's own failed-rebase scenario

The inspected queue test creates two completed candidate branches. Alpha integrates; Beta's rebase fails; the queue returns Beta as conflicted, with its worktree still attached. The test checks precisely that retained state. If this same outcome is followed by the production daemon's prune step under zero retention, Beta is eligible for removal despite the retained conflict. The test did not call that next step.

The important result is a **composition boundary**, not a fabricated failing test: the rebase/queue preserves an unresolved candidate locally, but the containing lifecycle does not use that reason as a retention condition. No fixture, real Rust execution or data-loss incident was produced in this research.

### Conditional counterpart C — different definitions of active

Merge blocks Stale; prune does not. The previously traced default heartbeat path can classify a still-existing process as stale without terminating it (Notes13/15). Cleanup only performs its explicit stop branch for Running; an attached Stale record can go directly to removal. Thus stale observation is not a sufficient process-death or safe-disposal proof. This is conditional on the earlier lifecycle and current cleanup predicates, not newly observed live-worker deletion.

Positive counterparts remain: Pending/Running/Idle records are retained by pruning; a positive retention interval can defer cleanup; successful integration followed by deliberate cleanup can free capacity normally. Retention time is a resource policy, however, not verification that the work was integrated or is valueless. No replacement policy is implemented or adopted here.

## 6. A successful operation, successful cleanup and durable receipt differ

The manager sequences Git integration, optional removal, store clearing and returned outcome. They are not one transaction. An error after Git succeeds can leave the base updated while the caller receives an error; an error after directory removal can leave stale database attachment. Conversely, a successful SQL clearing followed by a board-projection error can report failure after the primary row already changed.

`remove` also returns success for several warning-only failures, including failed branch deletion and some filesystem fallback failures. Therefore `cleaned_worktree=true` is the requested cleanup flag after that helper returns, not independent confirmation that every resource is absent. Other errors do propagate; it would be wrong to describe every failure as swallowed.

The store's `clear_worktree` retains the existing working directory while nulling the attached path/branch/base fields and refreshing timestamps/board metadata. It does not replace that path with the base checkout or mark the task accepted. The old row can therefore remain visible in its prior state with a directory value that no longer denotes a live worktree. Notes14–15 retain the earlier continuation consequences; this unit does not rerun E07.

The per-call merge result contains session and branch/base names plus booleans, not before/after commit ids, reviewer authority or an immutable integration receipt. Git history can still retain committed evidence, and separate operator logs may retain the returned result. The bounded claim is about this writer, not global evidence absence. Sources: M-Q/W-REMOVE/S-CLEAR/S-BOARD.

## 7. Error-aware results can still be weaker at their consumer

The actual CLI exposes individual merge, bulk merge, queue display/apply and prune. Invalid all-plus-session combinations are rejected. Structured JSON is available. An individual helper error propagates; a normally returned bulk object can contain failures and blockers and is printed without that arm converting them into an error. A caller must inspect the result rather than equate normal completion with all candidates integrated.

Per-candidate merge/rebase errors are collected, but errors constructing a later queue, resolving a session or reading a base OID can exit the whole invocation after prior effects. There is no batch-wide rollback or guaranteed partial-result vector on every error. A successful candidate and a later failure are not mutually exclusive.

Daemon summary writers persist last-pass time and counts in one current activity row. They do not preserve every candidate id, commit OID, rebase result, queue blocker or retention reason. Counts are refreshed after a normally returned pass; summary-write failure can follow real integration. The manager's status formatter displays those stored auto-merge/prune counts, an actual downstream consumer rather than an unused schema. This is an operational summary, not an accepted-deliverable ledger. Sources: C-MERGE/D-WRAPPERS/S-ACTIVITY/M-VIEW.

One lower-level evidence distinction remains relevant: `git_status_short` propagates failure to start the command, but a nonzero Git exit becomes an empty list after a warning. `has_uncommitted_changes` interprets that list as false. Other checks or Git itself may still refuse the operation, so this is not proof that any unreadable workspace is successfully merged. It is specifically the loss of unknown-versus-clean in that helper's return. The separate detailed status reader has stricter error behavior. Source: W-HELPERS.

## 8. Evidence and what this adds to the system model

Relevant manager tests use temporary Git repositories and SQLite records; some setup uses a fake harness. They cover stopped-session integration, normal bulk skipping, successful/failed rebase, conflict ordering and positive retention. Direct worktree tests use real Git commands in their definitions and check both conflict and recovery outcomes. These are meaningful designs, not merely schema assertions. **They were inspected, not executed.** Their local preservation assertions do not cover the full daemon merge-then-prune composition, concurrent ref changes, actual human acceptance or every installation.

The source return condition is met through the real manager, Git helpers, configuration, store, CLI and daemon, with useful normal behavior and material failure/continuation counterparts. Detailed TUI gestures/renderers, exact priority ranking, separate draft-PR/remote-delivery operations and arbitrary multi-repository layouts were not required for these bounded conclusions and are not silently certified. No exhaustive whole-file or whole-test-suite reading is claimed.

Note33 can now gain a concrete integration edge, but not an automatic acceptance guarantee. The method change selected in U15-A produced an observable research benefit: following delivery into retention revealed a consequential relationship that isolated process or merge tests did not explain. This is same-assistant source work, not independent validation of the research method or a measured product failure rate.

Reusable distinctions: mechanically mergeable versus accepted; current branch names versus approved revisions; successful rebase rollback versus downstream retention; selected resource lifetime versus useful-work lifetime; resource-policy defaults versus actual caller activation; operation result versus effect-free failure; process activity versus safe disposal; per-call detail versus last-pass summary. No SOUL architecture or upstream remedy follows.

## 9. Standing and next responsibility

Q04i1 has the bounded qualification/integration/retention source answer. Q04i2 retains installed Git/config/host correspondence; exact ref and repository identity, authenticated acceptance, concurrent callers/cleanup, crash and retry behavior, output recovery and empirical safety; detailed TUI/priority/remote-delivery variants remain materiality-based re-entry rather than blanket completion. Original Q01a2 and all earlier residuals remain.

After verified publication, next selected **U15-C / Q05d** addresses the existing G2 knowledge/connector-to-use gap: local connector input → checkpoint/import → graph entity/observation → retrieval and actual context/recipient selection. Start at Rust main's connector sync/import/recall, the store's graph/checkpoint methods and the manager's graph-based delegate-selection consumer. Compare the separate Vault and Node view only where a real bridge matters. Incidental connector code exposed during this unit is routing context, not a completed next inquiry.

Original evidence and E06 exclusion remain unchanged. Publication and activation are owned by STATE, not this note's existence.

## Source handles

All handles resolve through [U15-B-SOURCES](../evidence/U15-B-SOURCES.md) to immutable paths/blobs/ranges. M-Q: manager integration/queue/prune; M-TEST: manager tests; M-VIEW: activity formatter; W-GIT: worktree preview/merge/rebase; W-REMOVE: removal; W-HELPERS: status/ref/base helpers; D-LOOP/D-WRAPPERS: actual daemon composition; CFG: defaults; S-CLEAR/S-BOARD/S-ACTIVITY: real persistence; C-MERGE: CLI; G-* are dated primary Git contracts. Prior [Note13](13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md), [Note14](14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md) and [Note15](15-EXECUTION-ATTEMPT-OWNERSHIP-AND-REVOCATION.md) retain their original evidence classes.
