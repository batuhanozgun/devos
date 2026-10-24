# U03-B — Execution, handoff and recovery boundaries

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q04d; related Q02/Q08/Q10. **Evidence:** source reading, upstream test-source inspection, and E03 local execution of two unchanged files with a fake provider. [Sources](../evidence/U03-B-SOURCES.md), [E03](../evidence/u03-b-worker-probe/README.md). No real Codex, model, tmux session, installed ECC or remote work was run.

## 1. Result and scope

ECC does have concrete execution machinery beyond the local cards examined in U03-A. Its worktree orchestrator builds Git commands, creates per-worker artifacts, creates tmux panes and sends launcher commands. It also has an explicit setup rollback path. The earlier record-level limits do not justify saying that ECC only describes work.

However, command submission, provider-process completion, parsed handoff content and accepted task outcome remain separate. This slice follows an actual documented composition:

`dmux-workflows guidance → plan CLI → worktree/tmux orchestrator → Codex worker wrapper → task/status/handoff files → orchestration collector → previously examined canonical adapter/status output`.

This is ECC's helper path, not a source study of the separate standardagents/dmux product, every control-pane consumer, GitHub-epic coordination or Rust ecc2. The plan accepts other launcher commands; their contracts are not established by inspecting the Codex wrapper.

## 2. Turning a plan into a worker environment

S70 separates three modes: dry-run builds and prints a plan; write-only materializes artifacts; execute performs command effects. S71 validates nonempty worker tasks/launcher templates, rejects colliding normalized worker names, normalizes seed paths and derives branch/worktree/artifact locations. Shell-quoted placeholder aliases exist alongside raw placeholders. The presence of aliases does not mean every example uses them safely.

Each worker gets a branch-backed Git worktree from the configured baseRef, defaulting to HEAD. Selected seedPaths are overlaid from the current main checkout so dirty/untracked local material can be supplied. This is a useful capability that differs from a pure committed checkout. It also means the worker input is not identified by the base Git ref alone: current overlay bytes and the rendered launcher matter. The inspected helper does not freeze all those inputs into one immutable content manifest. No concurrent-input-change experiment was performed.

The generated task contains the objective, locations and a prohibition on nested agents; status begins as not started and handoff begins with placeholders. The worker is instructed to emit output, while a launcher manages coordination files outside its worktree. This separates the worker's requested edit scope from the control artifacts. It is a prompt-level division of responsibility, not proof of filesystem confinement or instruction compliance.

S74 selects a named `yolo` profile and model in a Codex command. The name alone is not a permission specification; actual host configuration and policy were not inspected. W07 separately confirms current profile/output-option meanings, not the pinned environment's configuration or availability.

## 3. What launch success actually establishes

S71 checks that Git recognizes the repository and tmux is available. Without replaceExisting it refuses a matching existing tmux session. It materializes artifacts, creates all worktrees with overlays, starts the detached orchestrator session, creates worker panes, labels them and sends commands to the returned pane ids.

The actual launch step uses tmux send-keys. After successful command submissions, executePlan returns coordinationDir, sessionName and the planned worker count. S70 prints that the session was started. There is no worker-ready acknowledgement, wait-for-completion loop, artifact-quality check or merge in this inspected return path. W06 confirms send-keys' character/key delivery semantics; it is not an oracle that the command subsequently succeeded.

This does not make launch success meaningless. It is evidence about provisioning and dispatch. It should not be promoted to accepted work or even successful completion of every asynchronously launched provider command. Later failures after executePlan returns do not enter its already-finished catch block.

## 4. Setup rollback, replacement and evidence preservation

The failure mechanism is more than a status label. createdState records a worker after successful worktree creation and records the tmux session after creation. On a caught setup failure, rollback kills a session it created, walks created workers in reverse, force-removes worktrees, prunes metadata and deletes their branches. A newly created coordination directory can also be removed. Cleanup errors can be attached to the original error.

S76 tests that a failure invokes rollback with the created worker list, and that a failure before worktree creation does not mark pre-existing worker resources for removal. These tests replace command, materialization and rollback functions; they were read, not run, and do not establish real deletion or restoration behavior.

Three distinct boundaries remain:

- **Created resource versus valuable output:** a first worker can already have received its command when provisioning a later pane fails. The rollback rule still removes worktrees created in this attempt; it does not check for useful worker output or task acceptance first. W05 confirms that force-removal can remove unclean worktrees. Loss of such newly produced output is a source-derived possible path, not an observed incident in E03.
- **Preserving a directory versus preserving its contents:** removeCoordinationDir is based on whether the directory existed before execution. Nevertheless, materializePlan unconditionally writes task/handoff/status files before worktree creation. Keeping an old directory does not prove its prior artifacts survived unchanged.
- **Replacement versus recovery:** replaceExisting runs cleanup before the main try block. It can kill the matching old session, force-remove expected worktree paths and delete matching branches before provisioning the replacement. The subsequent rollback is not restoration of that previous run. No backup/merge/accepted-result gate is implemented in this inspected cleanup.

These are setup/replacement policies, not a transparent resume protocol. Abrupt termination, external side effects, concurrent writers and full transaction durability remain untested. Native-plugin installation, common managed-install checkpoints and this rollback must not be treated as one universal ECC recovery mechanism.

## 5. Provider exit and task acceptance — E03

S74 checks the task file, writes running, builds a prompt, invokes the provider, captures its final output and writes a handoff/status. Its successful command branch writes completed without interpreting task correctness. The failure branch writes failed and a generic nonzero-exit handoff. An EXIT trap removes temporary prompt/output files.

E03 ran the unchanged S74 Bash wrapper and S72 Node collector against a temporary Git repository and deterministic fake `codex` executable. Source blobs were checked before execution. HOME/PATH/TMPDIR were isolated; no credentials or real model were used. Criteria were written after source inspection and before execution, with the same plan digest verified afterward.

| Case | Controlled input | Actual wrapper/consumer observation |
|---|---|---|
| C0 | Exit 0, exact headings and bullet-form successful report | Exit 0; completed; summary, validation and risks extracted |
| C1 | Exit 0, exact headings explicitly reporting failed verification/incomplete work | Exit 0; completed; the failure/risk text remained visible in parsed fields |
| C2 | Exit 0, numbered section labels with prose | Exit 0; completed; raw handoff retained the text, but all three parsed output arrays were empty |
| C3 | Exit 7, diagnostic stderr and partial output | Wrapper exit 1; failed; generic failure handoff omitted partial output; diagnostic remained in captured stderr; temporary output was removed |
| C4 | Missing task file | Exit 1; failed; fake provider was never invoked |

All five source-informed criteria matched. They are observations of wrapper/parser semantics, not five safety/quality passes. C3/C4 show real refusal/failure sensitivity, rather than a probe that always reports success. C1 is particularly informative because negative task evidence is retained alongside process completion: the consumer has to interpret both rather than trust the status alone.

C2 is not evidence that an actual model often produces that format. It shows what these unchanged components do when it is produced. E03 does not validate Codex CLI options, host policy, worktree isolation, tmux behavior or useful task outcomes.

## 6. Handoff as information: retained text versus extracted fields

S72 recognizes exact `## Heading` or `**Heading**` lines and extracts only dash-prefixed bullets for Summary, Validation and Remaining Risks. Other presentation forms can be human-readable yet yield empty arrays. The wrapper asks for section names but does not validate their concrete syntax; it embeds the final message as received. The initial generated handoff also uses Tests / Verification and Follow-ups, while the parser expects Validation and Remaining Risks. Those initial placeholders are not evidence of completed work, and a successfully rewritten wrapper response can replace them.

The source file is therefore a deeper recovery surface than the normalized view. Empty parsed risks can mean nothing matched the parser, not that a reviewer established absence of risks. Similarly, captured validation strings are reports, not independently executed tests. The canonical normalizer examined in U03-A preserves those extracted strings but does not turn them into acceptance evidence.

C3 identifies a different information limit: a process failure produces a generic handoff and discards the temporary final-output file. The captured stderr or tmux terminal may contain additional diagnostics, but no durable terminal-log collection was established in this slice. This is a scoped observation, not a claim that every failure loses all evidence.

## 7. Observation identity and liveness

S72 actually queries tmux and associates pane titles with worker directory names. This is a live observation path unlike the SQLite-only query in U03-A. Yet its meanings remain bounded:

1. Worker discovery scans directories containing any task/status/handoff file; it does not reconcile that set against the current plan's expected worker set.
2. Missing tmux executable or a nonzero list-panes result becomes an empty pane list. This representation does not preserve the distinction between no session and every observation failure.
3. sessionActive means at least one pane was returned. A remaining orchestrator shell can keep that true independently of task completion. W06 identifies pane_active as an active-pane flag, not an agent-progress or work-readiness verdict.
4. S74 writes Updated at running and termination, not as a periodic heartbeat. The retained S63 freshness heuristic can consequently mark a long-running worker stale. This is a source-derived timestamp/heuristic interaction, not proof of a stalled worker.

There are also source-level locator differences. The launcher slugifies session names and defaults coordination to `.orchestration`; plan-file resolution uses config.sessionName directly, while name-only resolution looks under `.claude/orchestration`. A normalized session name with an explicitly aligned root/plan can work; an arbitrary equivalent-looking name or default invocation need not identify the same files. E03 did not run this full discovery path. Reopen before asserting interchangeable addressing or complete worker enumeration.

The status CLI S73 forces the dmux adapter, emits JSON and optionally writes it. The previously examined adapter can persist observations. This command does not itself accept outputs, merge branches, restart workers or dispatch follow-up work.

## 8. What the wider system still needs us to investigate

S75 advises independent task partitioning, explicit boundaries, review before merging and integration in the main pane. In this slice, those are operator/agent instructions, not an implemented dependency scheduler or acceptance gate. The separate control-pane server, GitHub-epic coordination and Rust ecc2 may implement additional controls; their absence from this trace is not global absence.

Q04d is bounded-answered for this documented launcher→wrapper→artifact→collector path. Q04e retains deeper acceptance, supervision, restart/resume, locator consistency, artifact retention and alternative-controller questions. Existing Q04b/c and Q03b/c remain open. Useful handoff content, current process state and authority to act must still be bound at their actual downstream consumers.

Next U04-A opens the memory family: how does a memory/handoff become a stored, scoped, reviewable and actually consumed record? This is preferable to exhausting every tmux/board variant now, while maintaining explicit re-entry triggers for the unresolved control paths. The primary memory CLI/vault/skill paths have been search-discovered and must be bound to the original pin before substantive next-unit use.

## 9. Method assessment and candidate use

MR05 records a meaningful correction to a possible one-sided reading of U03-A: ECC has genuine runtime provisioning and rollback, not just card mutations. The exact wrapper/collector pair then distinguished execution status from reported task outcome and representation loss. The alternative was either to trust the successful-launch label or to expand into an unbounded live-agent campaign; neither was necessary for this bounded question.

The experiment is source-informed and same-assistant, not independent method verification. Source-search results belonged to a different default-branch ref; bodies were fetched at the pin. Two exact local files are not a complete checkout. E01/E02 were not rerun. P1 and the overall study remain partial.

The candidate SOUL/Development OS lesson is to distinguish provisioning, dispatch, process completion, information extraction and accepted outcome, and to scope recovery by both created resources and subsequently valuable effects. This is a research case, not a required architecture, adopted component or authorization to deploy ECC.
