# Superpowers — Source Ledger Supplement U05

Observation date: 2026-09-17. Additive continuation of [SOURCE-LEDGER.md](SOURCE-LEDGER.md), [SOURCE-LEDGER-U03.md](SOURCE-LEDGER-U03.md) and [SOURCE-LEDGER-U04.md](SOURCE-LEDGER-U04.md). Those volumes and E01–E10 remain unchanged. STATE owns current work and completion.

Target remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest context 6.3.0. This turn did not repin or produce a fresh upstream-HEAD, installed-version or live-host verdict.

## New full reads

Paths are relative to the pinned [source root](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797).

| ID | Path | Git blob | Coverage / evidence class |
|---|---|---|---|
| S55 | `skills/finishing-a-development-branch/SKILL.md` | `fa8aecaf8813f1b19d19996f7957d1b0121f2d9c` | FULL, 7,781 bytes in directory metadata. Human menus, full tests, base/merge/result checks, detached push, preservation and discard/cleanup policy. Prose instructions, not a runtime dispatcher. Selected command patterns locally exercised, not a whole-skill run. |
| S56 | `tests/claude-code/test-worktree-native-preference.sh` | `077ea19c360b66a4ab16d2c91d2bbc66e043704c` | FULL SOURCE ONLY. Action-oriented Claude scenario; RED/GREEN/PRESSURE branches and output predicates. No model call, historical-rate verification or suite execution. |
| S57 | `tests/claude-code/test-worktree-path-policy.sh` | `58caad7a09bc395fb2f4aefede6db56dfd0223de` | FULL SOURCE ONLY. Text-policy assertions across creation/finishing and historical rototill documents. Not lifecycle/creator/retention execution. Referenced historical documents were not read in this unit. |

Three new full file reads; one new SKILL body. **13 of the observed 14 SKILL bodies have now been read fully.** This is progressive file coverage, not 13 qualified subsystems or whole-repository closure. Writing-skills remains U06, with its actual dependencies.

The pinned finishing directory was listed in full and contains only S55. The two test paths were already known from the prior complete tests/claude-code directory listing. No recursive whole-repository inventory was performed.

## Direct re-entry of older sources

- S30 SDD, blob `aac35b91c07af15eca580a205eb0c894b86e87c8`: lines 400–510 directly re-read for correction disposition, final-review residuals, rulings disclosure and inner-workspace deletion. Earlier complete reading remains valid at the pin.
- S29 using-git-worktrees, blob `1381dacb3516b94382dd6ec736ede21ee8ede2b3`: lines 1–125 directly re-read for detection, consent, native preference, user location and in-place fallback. Earlier complete read retained.
- S18 Codex reference, blob `e4488fb224bb0fa0a33e9ac7dc961174e9f0c150`: FULL re-read. Only its environment/finishing clauses are used here. These are the target's host claims, not newly verified OpenAI/Codex instructions.
- S32 sdd-workspace, blob `4e2d16802ecaa23eb9a682663e4c356c4aa5a656`: FULL re-read, exact 1,586-byte connector-to-local transfer, hash-verified before actual execution. This new retention use is separate from E05/E06; old experiments were not rerun.
- S45 and earlier accepted/parked-review contracts remain recovered full sources in this conversation. U05 does not change their earlier findings or claim a new live verification.

## Supplementary primary documentation

- X01, refreshed: https://git-scm.com/docs/git-worktree — description, remove, retained worktree/branch topology and worktree state. Current documentation is supplementary; local observations use Git 2.47.3. Do not attribute ignored-record retention conclusions solely to a generic clean-worktree description.
- X05: https://git-scm.com/docs/git-branch — branch/ref operations and checked-out-worktree constraints. The actual branch-deletion refusal in E12 is the direct evidence for that local case.
- X06: https://git-scm.com/docs/git-merge — merged state, conflicts, pre-merge checks and limits of recovering uncommitted changes after abort. Selected sections, not a complete Git implementation audit.

All were retrieved through web on 2026-09-17. No mirror, search snippet or guessed host API substitutes for pinned target files. No external OpenAI product behavior was asserted from this documentation.

## E11/E12 — actual U05 execution

- E11 runner: [evidence/U05-lifecycle-probes.py](evidence/U05-lifecycle-probes.py), local Git blob `a59ca7af17737f64fa8ed54c214b77ceecd522a5`, 13,087 bytes.
- E12 actual output: [evidence/U05-lifecycle-probes-results.json](evidence/U05-lifecycle-probes-results.json), local Git blob `565da2eaf7aa293eea5663dce74436c71bb7595b`, 11,419 bytes.
- Source requirement: S32 exact helper; its identity is checked again by the runner before any fixture execution. S55's observed source identity is recorded, but the experiment is not an execution of all its text.
- Command: `python3 evidence/U05-lifecycle-probes.py /path/to/pinned/sdd-workspace`.
- Actual environment: Linux, Python 3.13.5, Git 2.47.3, GNU Bash 5.2.37. Built-in Python/Git/Bash; isolated HOME/global Git configuration; bounded subprocess timeouts; temporary repositories automatically removed.
- The sole remote was a local bare repository under the same temporary root. No network push/pull, credentials, forge PR, user checkout, plugin/dependency install, model, host exit tool or upstream suite was used.
- S55 command patterns use concrete fixture values; Python orchestrates setup and observations. Its decision not to clean up after failed merges/tests is not evidence of an agent following the instruction.
- Captured command traces preserve stdout/stderr/exit status. Temporary root/helper locations are explicitly normalised to `<TMP>` / `<PINNED_S32>`; recorded commit IDs and observed errors are actual run output.

Seven cases: six expected mechanism/scope/failure observations; one failed study-defined retention challenge; zero unexpected observation failures. Positive cases include green-result cleanup, ordinary untracked-file refusal and explicit detached ref publication. Other observations distinguish separately green inputs from a red merged result, preserved worktree from deletable branch, and conflict from automatic rollback. The failed retention inference is that refusal-based protection also preserves an only-copy ignored SDD ledger; ordinary removal deleted it without force.

This is source-informed exploratory work: criteria fixed after reading sources and before running. It does not establish a product score, independent research replication, real user consent or live review/disclosure behavior. Scratch is intentionally ephemeral upstream; no archival guarantee is invented as an upstream promise.

## Canonical recovery and acquisition

AGENT was fetched fresh and unchanged. All required protocols had been fully read in this conversation and remained available; no control file was modified or used as research evidence.

STATE, META, PLAN, INDEX and the final corrected U04 source supplement were freshly read. Package/notes metadata confirmed unchanged METHOD, original ledger, U03 supplement and U04 note identities; their full canonical contents already read in this same conversation remained available. Current routing agrees on U05; old note next-action sentences are historical. This is not a claim that directory listings replaced full reading.

A public raw-source download attempt failed at container DNS. Connected GitHub supplied the source; the S32 transfer was hash-verified locally. No full clone/archive was acquired. Earlier experiment files/results were preserved rather than claimed as new runs.

## Current coverage and next retrieval

[U05 note](notes/U05-delivery-cleanup-and-retention.md) records F36–F42 and Q26–Q29. Inner scratch cleanup, outer worktree cleanup and branch cleanup are separate transitions. Human disclosure of rulings is specified, but archive completeness, actual receipt and full residual discharge remain unverified.

U06 next: writing-skills and actual authoring/evaluation dependencies, contributor guidance, selected pressure/drill/CI/release evidence. S56/S57 are leads, not completed behavioral qualification. U07 retains supporting runtime/distribution; U08 retains native synthesis and project-facing projection. No Foundation, architecture or adoption authority follows.
