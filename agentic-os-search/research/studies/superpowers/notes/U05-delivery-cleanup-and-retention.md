# U05 — Delivery, Cleanup and Evidence Retention

Date: 2026-09-17. Target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE / LOCAL GIT-PRIMITIVE INVESTIGATION COMPLETE.** Whole study remains ACTIVE / PARTIAL. This is not an observed agent finishing a project, a forge integration test, or adoption. U06 skill authoring/evaluation is next.

Sources S55–S57 and experiment E11/E12 resolve through [SOURCE-LEDGER-U05.md](../SOURCE-LEDGER-U05.md). Earlier source IDs retain their original ledger volumes. [METHOD.md](../METHOD.md) remains v0.1.

## 1. Question, source recovery and execution boundary

What turns accepted development work into an authorised delivery, a verified resulting state and a correctly retained or disposed working context?

Three additional files were fully read at the existing pin: finishing-a-development-branch, the native-worktree-preference test and the path-policy test. The finishing directory contains only its SKILL.md. SDD final-review/ruling/cleanup clauses, worktree-creation clauses, the full Codex reference and the exact sdd-workspace helper were re-entered. Earlier full-read statuses remain preserved; this does not re-open every previously completed mechanism.

Seven local cases exercised selected Git primitives with synthetic repositories. Only S32 sdd-workspace was executed as an exact, hash-verified upstream script. S55 is an instruction document: its command patterns were instantiated with fixture values, not executed by an actual agent or a prose interpreter. The fixture's decisions to retain work after failure are ours, not observations of model compliance. No user checkout, real remote service, forge PR, installation or upstream suite was used. One push targeted a bare repository inside the same temporary directory, without network or credentials.

## 2. F36 — Finishing separates work acceptance from integration authority

**OBSERVATION — S55.** The source first requires the project's full test suite. Failure stops the normal finishing flow before its integration menu. The environment determines whether local merge is offered: normal/named-branch workspaces receive merge, push-and-PR and keep choices; detached workspaces receive push-as-new-branch-and-PR or keep. The base branch should come from the work's context and be confirmed when unknown, not silently assumed to be main.

Integration belongs to the human. There is no default discard item; discard requires an explicit request followed by the exact confirmation word. Rejected pushes are investigated rather than automatically force-pushed. These are concrete procedural restraints, not a machine-enforced authorisation token or proof of actual user consent.

| Route | Required decision / condition | Intended effect and retention |
|---|---|---|
| Local merge | Named-branch route, known base, human choice, passing tests | Move to main checkout, update base, merge feature, test merged result; only then eligible worktree cleanup and branch deletion. |
| Push and PR | Human selects publication; actual push/forge capability exists | Push branch or detached HEAD under an explicit remote branch name; create PR against the base using forge tools/conventions; report URL. Preserve worktree for feedback. |
| Keep | Human defers integration | Report retained branch/workspace; no publication or cleanup. Detached keep remains a retained checkout, not a newly named local branch. |
| Discard | Explicit discard request plus exact confirmation | Move outside the worktree, apply cleanup policy and force-delete named feature branch. This is not ordinary completion. |

The two-option detached menu must be interpreted by action, not by reusing the numbered labels of the three-option menu. No executable dispatcher was found in this directory. A menu item describes intended work; it does not establish that the effect already occurred.

## 3. F37 — The merged result is a new verification object

**OBSERVATION — S55, with S45.** The merge route explicitly tests both the work about to be integrated and the resulting merged state. If the latter fails, it stops and preserves the feature worktree and branch. This is stronger than carrying a prior green result across integration without checking what integration produced.

**LOCAL OBSERVATION — E11/E12.** A positive fixture merged a feature, passed the synthetic result test, removed its worktree and deleted the feature branch. The feature commit remained an ancestor of main. A second fixture had two separately passing inputs: one branch changed `a`, the other changed `b`. Git merged without a textual conflict, but the combined invariant `a + b <= 1` failed. That supports the need for result-level verification; it is not a failure of Superpowers' prescribed retest.

A conflicting-merge fixture instead returned failure with an unmerged file and MERGE_HEAD still present. That is an unfinished local state, not an automatic rollback. The source's description of local recovery should not be elevated into transactional rollback of pull, merge, tests, cleanup and branch deletion. The branch/worktree remained in our fixture because we did not perform subsequent cleanup.

The actual main checkout matters too. S55 changes directories before integration, but does not enumerate a separate comprehensive inventory of unrelated main-checkout edits. Official Git merge documentation warns that uncommitted changes can complicate abort/recovery. This is a bounded prerequisite to inspect, not an observed loss of unrelated user work.

**INFERENCE.** At least these objects are distinct: reviewed commits; tested working tree; updated base; merged local result; pushed remote ref; and created PR. A successful observation for one does not automatically qualify all the others. No real pull, push rejection, forge-creation failure or post-publication feedback cycle was executed here.

## 4. F38 — Branch state, host capability and workspace ownership differ

**OBSERVATION — S55/S18.** Generic finishing provides an explicit detached-HEAD push refspec. The pinned Codex reference separately describes a constrained environment in which branch/push operations are blocked and the user should use native App controls. Those are host-conditioned instructions, not fresh verification of current Codex APIs or sandbox policy.

**LOCAL OBSERVATION.** A detached synthetic worktree successfully pushed `HEAD:refs/heads/review-fixture` to a local bare repository. Direct readback of the destination ref matched the intended commit; local HEAD remained detached and the worktree remained present. No forge PR was created. This establishes that detached HEAD is not itself a Git-wide prohibition on such a push; it says nothing about a particular host's permissions or network access.

S55 infers external management from detached state and infers cleanup ownership from project-local directory names. S29 also permits existing worktrees, native creation and explicit user location preferences. Git topology alone cannot prove which actor created a directory or currently owns its cleanup. The source's policy is a convention/heuristic, not an ownership registry.

## 5. F39 — Preserving a worktree can conflict with deleting its checked-out branch

**OBSERVATION — S55/S29.** Cleanup treats worktrees under `.worktrees/` or `worktrees/` as owned; others are left to the host, optionally through a workspace-exit tool. The local-merge path subsequently asks for feature-branch deletion. Explicit creation preferences outside the conventional paths and externally managed named worktrees therefore require attention to both policies.

**LOCAL OBSERVATION.** After merging a feature checked out in a retained external-location worktree, `git branch -d feature` was refused because that branch was still used by the worktree. Both branch and worktree survived. No host-exit/detach action was performed. A real host exit tool might change the relevant state; that behavior is unverified.

**INFERENCE.** Preserving an external workspace and completing branch cleanup are separate outcomes. Git's refusal is a safeguard, not evidence that all delivery failed or that forcing removal is appropriate. A successful merge must not be reported as proof that every subsequent cleanup step succeeded. The source gives no complete recovery protocol for every refused branch deletion or nonstandard repository layout; these remain bounded composition questions.

## 6. F40 — Non-force removal protects ordinary untracked files, not every ignored record

**OBSERVATION — S55/S32.** S55 refuses to escalate to `git worktree remove --force` on its own initiative. When ordinary removal is refused, it displays status and asks whether the human wants files committed, moved or deleted. This is a meaningful protection for the files that trigger that refusal. S32 deliberately creates self-ignored SDD scratch containing reports, briefs, review packages and the ledger.

**LOCAL OBSERVATION — paired cases.** An ordinary untracked note appeared in `git status --porcelain -uall`, caused removal to fail, and remained on disk. In the paired ignored-evidence fixture, the exact S32 helper created scratch, and we wrote a unique synthetic ledger there. Git confirmed it was ignored; ordinary status was empty; its path had no tracked history. Ordinary worktree removal then succeeded and the ledger disappeared, without `--force` and without executing SDD's explicit `rm -rf`.

This refutes the stronger inference that refusal-based cleanup protects every only-copy record. It does **not** show Git violated its intended semantics, prove production data loss, or establish that Superpowers promises to archive all scratch. Scratch is explicitly short-lived. A compliant agent could preserve relevant information beforehand; that preservation was intentionally absent in the challenge.

**CAUSAL INTERPRETATION.** The archival need is semantic, while the removal safeguard relies on Git's working-tree classification. SDD intentionally places records outside normal status/staging; ordinary removal can therefore be permitted while those records still exist. The ask-on-refusal path never runs in that case. Avoiding force alone cannot substitute for deciding which ignored records must survive.

## 7. F41 — Retaining code, rulings and full evidence are different handoffs

**OBSERVATION — S30/S55.** SDD instructs the controller to gather every `Ruling:` entry into the final human-facing message, in order and with its cost if wrong, before deleting anything. It also routes residual load-bearing findings to the human when finishing presents options. These obligations must be retained; it would be false to claim there is no decision-preservation provision.

However, SDD's plan-scratch cleanup is distinct from S55's Git-worktree cleanup. SDD conditionally deletes the plan workspace after a clean final review and merged fixes, then invokes finishing. The wording does not supply an immutable receipt of archival success. S55's PR/keep routes preserve the outer worktree, not a guarantee that an inner scratch directory still exists.

The finishing skill does not name the SDD ledger as a required input or provide a residual-finding discharge checklist. It requests a concise exact menu while SDD additionally requires disclosure. The controller must compose these responsibilities. The final test suite cannot itself establish that every parked non-test issue was fixed, waived or communicated.

**INFERENCE, bounded to the inspected contracts.** There are at least three retained records to distinguish:

- code/spec/plan content that was actually committed;
- human-visible decisions and residual risks copied from the ledger;
- detailed test/report/review artifacts, which may remain ignored and temporary.

Copying rulings does not automatically preserve every test output or deferred minor without a ruling. A successful code merge does not automatically store either category. Conversely, long-term archival of every scratch byte need not be the right objective; the question is which records remain necessary for the next authorised decision or investigation. The source documents a disclosure duty, but this study has not observed its live execution or a complete acceptance receipt at the handoff.

## 8. F42 — Tests of ownership wording are not evidence of lifecycle ownership

**OBSERVATION — S56/S57.** The path-policy test checks that particular source/spec/plan strings are present or absent, including the conventional cleanup directories. It does not create worktrees, identify their creators or exercise retention. It was read, not run.

The native-preference test contains an action-oriented agent scenario and historical success claims, not merely a documentation example. Yet its GREEN/PRESSURE pass predicate accepts output that lacks the literal `git worktree add`; the separately computed native-tool mention is not required on that branch. Its script does not itself switch installed skill versions between its RED and GREEN scenarios. The caller's setup and actual action trace therefore matter. No model call, historical rerun or success-rate verification was performed.

These are specific limits of the inspected tests, not repository-wide absence of stronger lifecycle/drill tests. They are carried into U06, where evaluation architecture and current-contract alignment belong. They do not justify turning this unit into an unbounded host-testing campaign.

## 9. E11/E12 — Actual execution record

Runner: [U05-lifecycle-probes.py](../evidence/U05-lifecycle-probes.py). Actual output: [U05-lifecycle-probes-results.json](../evidence/U05-lifecycle-probes-results.json).

Environment: Linux, Python 3.13.5, Git 2.47.3, Bash 5.2.37. The S32 helper was verified as blob `4e2d16802ecaa23eb9a682663e4c356c4aa5a656`, 1,586 bytes, before execution. All repositories, worktrees, synthetic commits and the sole local bare remote lived under an automatically removed temporary root. HOME/Git configuration were isolated; commands had bounded timeouts. No real network, credentials, user work or upstream suite was involved in the experiment.

| Case | Result at its stated scope |
|---|---|
| Green merge then eligible cleanup | Merged test passed; worktree and branch removed; feature commit remained in main. |
| Separately green inputs | Conflict-free merge produced a failing combined invariant; no cleanup attempted. |
| Ordinary untracked note | Removal refused; note retained. |
| Ignored SDD ledger | Removal succeeded without force; ledger not retained. Stronger retention challenge FAIL. |
| Retained named external worktree | Merge succeeded; branch deletion refused; branch/worktree remained. |
| Detached explicit refspec | Local-only remote ref matched expected commit; local HEAD remained detached. Not a PR test. |
| Merge conflict | Failure, unmerged file and MERGE_HEAD observed; no rollback/cleanup performed. |

Six expected mechanism/scope/failure observations matched; one study-defined retention criterion failed. No unexpected observation failure occurred. A PASS can confirm a limit rather than certify product safety. Criteria were fixed after source inspection and before the run. Filesystem checks, explicit ref/ancestry readback and the synthetic invariant provide narrow independent observables, not independent research replication or a live acceptance test.

## 10. Method reflection and residuals

U05 follows the outcome through integration and removal rather than treating the final skill invocation as completion. It preserves the source's useful human-choice, merged-result retest, non-force and PR-iteration provisions while locating their actual scope. The experiment distinguishes exact upstream helper execution from study-selected command sequences; the latter cannot validate agent reasoning or authorisation behavior.

METHOD remains v0.1; PLAN v0.6 records these refinements. No Foundation node, SOUL/Development OS architecture, upstream instruction or dependency has been adopted.

Q16/Q19 now have a bounded source answer: disclosure is specified, full archive/receipt and residual discharge are not automatically established; ignored records can leave the retained set. Q18 gains the explicitly tested merged-result boundary. Q20/Q24 retain actor/stage composition. Q21 gains two source-inspected evaluation leads, not new behavioral evidence.

New residuals:

- Q26: how is actual workspace creation/cleanup authority distinguished from path and detached-state conventions?
- Q27: which records must survive each inner-scratch/outer-worktree transition, and what establishes successful disclosure or retention before removal?
- Q28: what reconciles partially successful delivery, such as push without PR or merge without cleanup, with the final reported state?
- Q29: how does a host-owned named worktree release its branch when workspace preservation and branch deletion policies meet?

**Next authorised unit: U06 — skill authoring, testing and evolution.** Fully read writing-skills and its actual references; inspect contributor guidance and selected pressure/drill/test/CI sources. Follow skill change → expected behavior → evaluation → revision → distribution, keeping source-text assertions, model reports, actual action traces and historical success claims distinct. Pin external evaluation dependencies separately before using their results. U07 retains runtime/distribution coverage; U08 retains system synthesis and project-facing projection. No installation, upstream reporting or architecture phase follows automatically.
