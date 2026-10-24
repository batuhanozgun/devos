# Superpowers — Source Ledger Supplement U03

Observation date: 2026-09-17. This is the additive source register for U03, not a replacement for [SOURCE-LEDGER.md](SOURCE-LEDGER.md), whose S00–S36 and E01–E06 remain preserved through U02. STATE and INDEX route to both volumes. Earlier statements such as S34 not executed describe that earlier checkpoint; the execution addition below supersedes that status for U03 only.

All Superpowers sources remain pinned to `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`. No new upstream HEAD observation, repin, host-version qualification or release-channel claim was made.

## New full source reads

Base: https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/

| ID | Source | Git blob | Coverage and role |
|---|---|---|---|
| S37 | `skills/subagent-driven-development/task-reviewer-prompt.md` | `ce796948232b6ae5fb65fd2d1f2f864530201a2e` | FULL; one reviewer/two verdicts, constrained diff recovery, unverified report/test evidence, read-only/no-child instructions. No reviewer execution. |
| S38 | `skills/subagent-driven-development/re-review-prompt.md` | `ad74b10b30762affc44173f8ec3228d2877f372f` | FULL; finding-by-finding fix verdicts, FIX_BASE binding, new versus out-of-scope defects, reused test evidence. No model run. |
| S39 | `skills/dispatching-parallel-agents/SKILL.md` | `3fa091b348bbe0a18eaa0e17e9092c97f7005cbe` | FULL; independent-domain/no-shared-state scope, focused dispatch and integration checks. No scheduler, parallel agents or integrated suite executed. |
| S40 | `skills/requesting-code-review/SKILL.md` | `fa4f2f9965591d6d8a7ef4ad47e6ba4d5ac344d0` | FULL; generic dispatch/feedback and HEAD~1 example; specialized SDD range/parking distinctions retained. |
| S41 | `skills/requesting-code-review/code-reviewer.md` | `b898cb982e8a368e847d31136ac106001173b1d5` | FULL; broader plan/architecture/testing/readiness review, checkout preservation and output contract. No merge/adoption evidence. |
| S42 | `tests/claude-code/test-subagent-driven-development.sh` | `151fc64d04668567c4980301dc28f323bd5424b5` | FULL SOURCE; explicitly description/keyword rather than drill behavior. Test 7 predicate locally exercised separately with synthetic replies, not whole-file/suite execution. |
| S43 | `tests/claude-code/test-helpers.sh` | `9e187610d6a973c6db0aed91dfb8deadfcac3e78` | FULL SOURCE; assert_contains uses case-insensitive grep; also contains run_claude and test-project helpers. File not sourced/executed; no Claude call. |

Seven new file bodies were fully read. No whole-repository recursive coverage or full test-family coverage is implied. Prior six SKILL bodies plus new parallel-dispatch/requesting-review bodies give eight fully read SKILL bodies; supporting files are counted separately, not as extra skills.

## Re-entry of previously read sources

- S30 `skills/subagent-driven-development/SKILL.md`, blob `aac35b91c07af15eca580a205eb0c894b86e87c8`: direct re-read of lines 240–400 and 401–505 for task packets, unresolved coverage, fix loops, adjudication, final review and retention. Prior full reading through EOF remains recorded in U02.
- S34 `skills/subagent-driven-development/scripts/review-package`, blob `31852e2abbeb9a41084f67a9f2ef3cfc3378bce9`: FULL direct re-read; exact 1,469-byte local transfer verified before execution. Explicit OUTFILE path executed; default sdd-workspace path not rerun.
- S35 implementer and S31 executing-plans contracts remain fully read in this conversation and were reused for role/route interpretation; they are not counted as new reads or new runtime tests.
- S28 planning and S30 global-constraint requirements remain the context for evaluating the reviewer/re-review packet. A missing re-review placeholder does not prove a real controller omits the constraint.

## Supplementary primary sources

- X03: https://git-scm.com/docs/git-diff — retrieved through web on 2026-09-17; selected description on endpoint comparison and context options. Distinguishes a commit-to-commit diff from current working-copy inspection. Not an exact-version Git implementation audit or Superpowers behavior proof.
- X04: https://git-scm.com/docs/git-log — retrieved through web on 2026-09-17; selected description on reachability and A..B notation. Supports distinction between a commit list and net diff.
- Initial search results were unrelated and discarded. Only the direct official Git documentation was used. No unavailable or irrelevant result supports a claim.

## E07/E08 — actual U03 execution

- Runner: [evidence/U03-review-probes.py](evidence/U03-review-probes.py).
- Actual output: [evidence/U03-review-probes-results.json](evidence/U03-review-probes-results.json).
- Runner Git blob: `a1982668d06c8cf22783af60bfb5430839eb1b5c`, 9,542 bytes.
- Output Git blob: `48ba0976e661c74fe20f9232836fcc2dc2debb19`, 4,086 bytes.
- Source S34: Git blob `31852e2abbeb9a41084f67a9f2ef3cfc3378bce9`, 1,469 bytes, recomputed and matched before running the real script.
- Environment: Linux, Python 3.13.5, Git 2.47.3, GNU Bash 5.2.37. Isolated HOME/global Git config; synthetic local commits, no remotes, no credentials, no installation/network, automatic temporary-directory cleanup.
- The script was invoked with an explicit output file, preserving default workspace-name and collision questions at their U02 scope.
- Literal grep predicate from S42 was executed with two constructed answers under S43's observed case-insensitive matching semantics. Neither S42 nor S43 was executed as a file and neither answer is live model output.

| Family | Observed result / meaning |
|---|---|
| Positive helper checks | Missing plan and bad BASE rejected; correct two-commit task and one-commit fix packets produced. |
| Scope observations | Valid shortened BASE omitted the first task file; fixed commit endpoints produced identical packets despite tracked/staged/untracked working changes. Not helper failures or product qualification. |
| Negative control | Fixture coverage oracle rejected a packet omitting one expected changed file. Narrow file-coverage check, not semantic review. |
| Oracle-health challenges | Current minimal by-file answer rejected; obsolete direct-paste answer accepted. Two failed alignment criteria, not observed CI/model failures. |

Nine cases: seven expected mechanism/scope/control observations; two failed oracle-health criteria; no other failures. Criteria were fixed in the runner after source inspection and before execution. They are source-informed exploratory evidence, not preregistered independent validation.

## Current topology and interpretation limits

U03 establishes a bounded procedural model of implementer → one two-verdict task reviewer → scoped fix review → controller disposition → final broad review. Context isolation, read-only behavior and no-child rules are instructions at the inspected surface, not proven capability restrictions. DONE, review clean, completion with parked findings and merge readiness remain distinct.

The source study now has four chronological mechanism notes (U01-A, U01-B, U02, U03) and four separate local experiment records. No whole-system CORE, cross-study result, Foundation projection, live review trace or product-effectiveness benchmark exists.

The full upstream integration/drill/evaluation surfaces remain open for U06. S42's explicit reference to behavioral drill scenarios is a lead, not observed behavioral evidence. No claim of repository-wide test absence or failure is justified.

## Project recovery and publication discipline

U03 re-read current STATE, META, METHOD, PLAN, the full prior source ledger and full U02 note before continuation. AGENT was refreshed and unchanged; applicable protocols already read in this conversation remained active. Agent-control is not included as research evidence.

This additive ledger volume avoids retranscribing earlier source identities and experiment results. It changes physical placement, not evidence standards or completion criteria. Future sessions read the prior ledger plus this supplement, then later named supplements if any. STATE remains current-work authority.

Old local files were not present in this container at U03 start. Prior results were recovered from canonical repository records and not claimed as newly executed. Only S34 was transferred anew. No raw-source download or complete clone was attempted in this round.
