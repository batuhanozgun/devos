# Superpowers — Source Ledger and Progressive Topology

Observation date: 2026-09-17, updated through U02. This ledger records **observed coverage**, not promised future coverage. All upstream file references below are bound to `b36e0829c6d0140e93cfef2ca599b1b07d4a7797` unless explicitly stated otherwise. Earlier full reads and experiment results remain valid at their recorded scope; no previous experiment was rerun in U02.

## Snapshot binding

- Repository: https://github.com/obra/superpowers
- `refs/heads/main` resolved in the first round through connected GitHub to `b36e0829c6d0140e93cfef2ca599b1b07d4a7797`.
- Git commit metadata: timestamp `2026-08-12T16:53:21Z`; root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`.
- The commit message was truncated in the tool view. Only its metadata is used; its long change narrative is not treated as fully read evidence.
- `.codex-plugin/plugin.json` declares version `6.3.0`. U01-B additionally read matching version declarations in root package, Gemini, Cursor, Kimi and Hermes manifests. No installed-version/release-channel equivalence is claimed.
- U01-B and U02 continued at the existing pin. No new upstream HEAD/release freshness verdict was produced.

## Upstream source register — first round, retained

Base for paths: https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/

| ID | Source | Git identity | Coverage and role |
|---|---|---|---|
| S00 | Git ref and commit metadata | commit `b36e0829c6d0140e93cfef2ca599b1b07d4a7797` | Metadata observed; long commit message PARTIAL, not detailed-behavior evidence. |
| S01 | `README.md` | `09a91c6d03cfa3d874c5c33b6f8cc3d0b2d89645` | FULL earlier in this conversation; rebound through pinned root tree. Product orientation/author claims, not efficacy. |
| S02 | Root tree | tree `21219529a4e224bcb27baf8816b039c8bf7c6673` | FULL non-recursive tree; first JSON copy complete with truncated:false despite truncated repeated wrapper copy. Not full repository content. |
| S03 | Skills tree | tree `9483dd00b0bda60c6ea631d88900f0436630d064` | FULL non-recursive listing; 14 skill directories. Presence is not full skill reading. |
| S04 | `skills/using-superpowers/SKILL.md` | `7ab2eb678f649c8befb94512359ee0b6e9a9a9a4` | FULL; selection, subagent exception, user precedence, platform-reference routes. |
| S05 | `hooks/hooks.json` | `67975137aafc8a097bdd1c2b51fea3989b8ad6c0` | FULL; declared SessionStart matcher/wrapper. No actual host startup observed. |
| S06 | `hooks/session-start` | `93a6bc2c6b7269c704378cb6a61fce6aea7ff631` | FULL; exact local copy executed in U01-A synthetic fixtures. No rerun in U01-B/U02. |
| S07 | `.codex-plugin/plugin.json` | `123793e54ffbd933e9a3e6f99e133e8087a08828` | FULL; skills path, empty hooks object/version. Manifest observation, not live Codex. |
| S08 | `docs/porting-to-a-new-harness.md` | `4ae9603defaf0d9ff052189a33fe515dd2a4ee2e` | FULL across this conversation: initial 1–310, then U01-B 311–460, 461–610, 611–800, 801–EOF. Initial PARTIAL status superseded only for this file. |
| S09 | `tests/hooks/test-session-start.sh` | `c1508290e9813de1a7d20b24d3ca3c8927fbc11c` | FULL SOURCE ONLY; registration/output/warning checks. Upstream suite not run. |
| S10 | `skills/brainstorming/SKILL.md` | `b56a3b5ed6ea0d6216501e0e401ecb00a1b4675f` | FULL initial 1–150 and 151–EOF; same ranges re-read in U02. Three-path routing, approval, spec, companion reference. Plan/worktree handoffs now investigated; companion runtime remains open. |

An initial public web view was used only for orientation, not as substitute for pinned sources. U01-B public web opens failed. U02 retrieved two primary Git documentation pages listed separately below; they are not current-host or Superpowers HEAD validation.

## Upstream source register — U01-B additions, retained

All 17 file bodies below were **FULLY READ through GitHub at the same pin**. Only S12 was executed locally; other executable files/test files remain source observations.

| ID | Source | Blob SHA | Role / execution boundary |
|---|---|---|---|
| S11 | `hooks/run-hook.cmd` | `ceec3a732d6251abb3c65ba860b7cc5d1f21dfb8` | Polyglot wrapper; Windows Bash search/no-Bash success path, Unix dispatch. Not run. |
| S12 | `.opencode/plugins/superpowers.js` | `423e5ed513261485c657ba166b0372a5293639c7` | Config registration, first-user transform, generic-marker dedup, module cache. Exact-byte local callback execution E03/E04. |
| S13 | `.pi/extensions/superpowers.ts` | `a978e80ee0bbffe649ace8826bf6e8b69beea421` | Discovery, lifecycle flag, message insertion/dedup, inline mapping/cache. Not run. |
| S14 | `package.json` | `3a84ce88c91344a7931d3f1d156d2ade317d6577` | ESM/OpenCode entry; Pi extension and skill resource declarations. |
| S15 | `gemini-extension.json` | `ccb77ae2169968e60f49914f97aa1a25ffe98e18` | Declared extension context file. |
| S16 | `GEMINI.md` | `0dd2f585ecb2ee37c558c8233d72489bb2135856` | Two relative includes. Real host expansion not observed. |
| S17 | `skills/using-superpowers/references/gemini-tools.md` | `b01b65238a50981aeed22ae52ee20f8b55d16b42` | Target's tool/agent/template instructions, not verified current Gemini API. |
| S18 | `skills/using-superpowers/references/codex-tools.md` | `e4488fb224bb0fa0a33e9ac7dc961174e9f0c150` | Target's version-sensitive delegation/context/worktree instructions; actual current Codex contracts not revalidated. |
| S19 | `skills/using-superpowers/references/pi-tools.md` | `0c1f21713a45255ece4144fd2fee353e4ed4f90e` | Optional subagent/task-tool fallbacks. Not an identical copy of all S13 inline mapping. |
| S20 | `.hermes-plugin/__init__.py` | `3b41644bb2890fbd3b642b63ed6625da0077e935` | Two layout resolution, bootstrap build, skill registration, first-turn hook. Not run. |
| S21 | `.hermes-plugin/plugin.yaml` | `3a0ecfb21e6061c1560b8477f1e2f2b4e6cd1f58` | Declares pre_llm_call hook capability. |
| S22 | `skills/using-superpowers/references/hermes-tools.md` | `0f1fa57bc1b495462e75c6ce11e798245a34987e` | Skill names/path fallbacks/delegation mapping; namespace seam with S20 preserved. |
| S23 | `.kimi-plugin/plugin.json` | `dcb9a7a9bee9ee8acfc73d535060569de0cdc8e6` | sessionStart.skill, skills path, inline interaction/task/role mapping. Host not run. |
| S24 | `hooks/hooks-cursor.json` | `84e6d33874ab5926035e35bc13dccf21244bb079` | Lowercase event, relative command; no explicit compaction entry in this file. |
| S25 | `.cursor-plugin/plugin.json` | `bb2bdbcd1ab620883d1a4865ae03f021064ff13c` | Skills/hooks declarations. |
| S26 | `tests/opencode/test-bootstrap-caching.mjs` | `32149aed33037d7bcda36dc875546d390b501c78` | FULL SOURCE ONLY; present/missing cache assertions, mapping strings, generic-marker counting. Not run. |
| S27 | `tests/pi/test-pi-extension.mjs` | `d7af9cb2ae125341eaab1e53bea8d2a2d7448dda` | FULL SOURCE ONLY; fake-event actual-extension tests and table-text check. Not run. |

Additional FULL non-recursive navigation trees in U01-B:

- `.hermes-plugin`: `24ce40750b8c305dac592ed04462861d102a2fb2` — two files, both read.
- `tests`: `3b4b2210556b6c3f668aca2c6c34dffb114c7293` — test-family presence only.
- `tests/opencode`: `60f3f9394823bc86c768e3b9974e49fa18968f9d` — seven entries; only S26's content read.

## Upstream source register — U02 additions

Nine new file bodies were FULLY READ. A full source read is not a completed investigation of all mechanisms referenced by that file.

| ID | Source | Blob SHA | Coverage / role |
|---|---|---|---|
| S28 | `skills/writing-plans/SKILL.md` | `f74605bfa9af7a3fb7e4ad7f17750a86a9b0d728` | FULL; Spec pointer, globals, interfaces, task granularity, self-review and execution choice. |
| S29 | `skills/using-git-worktrees/SKILL.md` | `1381dacb3516b94382dd6ec736ede21ee8ede2b3` | FULL; consent/native/manual/in-place routes, detection, setup/baseline. Only one literal ignore-check command executed, not the full skill. |
| S30 | `skills/subagent-driven-development/SKILL.md` | `aac35b91c07af15eca580a205eb0c894b86e87c8` | FULL in contiguous ranges 1–160, 161–320, 321–490, 491–EOF. Entry/ledger/ruling/task handoff analysed in U02; deeper task/final review dependencies remain U03/U04/U05. |
| S31 | `skills/executing-plans/SKILL.md` | `b51d97d2cc4c2ecc5eabecf27e499aa8c933efac` | FULL; alternate entry, stop/ask rules, SDD redirect and finishing handoff. |
| S32 | `skills/subagent-driven-development/scripts/sdd-workspace` | `4e2d16802ecaa23eb9a682663e4c356c4aa5a656` | FULL; exact byte-verified helper locally executed in E05/E06. Plan existence, basename/root mapping and self-ignored scratch. |
| S33 | `skills/subagent-driven-development/scripts/task-brief` | `612e14a1ee7ca9c0078d896325935759a1827c24` | FULL; exact byte-verified helper locally executed in E05/E06. Task extraction/output and missing-task behavior. |
| S34 | `skills/subagent-driven-development/scripts/review-package` | `31852e2abbeb9a41084f67a9f2ef3cfc3378bce9` | FULL; local copy hash-verified, NOT executed. Plan/range checks, commit/stat/diff package; deeper review semantics remain U03/U04. |
| S35 | `skills/subagent-driven-development/implementer-prompt.md` | `5c8ecd61fba036263bf88d0af24d47125780efa0` | FULL; brief/context contract, escalation, no child dispatch, report/TDD evidence. Source-only; no worker/model run. |
| S36 | `tests/claude-code/test-sdd-workspace.sh` | `841723016a9ceca8028f02e5e20ac811468c2ec2` | FULL SOURCE ONLY; input checks, different basename/worktree isolation, ignored scratch and helper output placement. Not run. |

U02 FULL bounded recursive navigation trees:

- `skills/subagent-driven-development`: `8133f2b10d4e71e73d867f2e2e365e0778ff0e4e` — scripts subtree `7b07ee25e91b9a394e20e8430adf5c57aadb254e`; main skill, implementer and three scripts read. task-reviewer/re-review templates remain unread.
- `tests/claude-code`: `21a7cc807b8930bc80f9fcd0056dc174e1128ea2` — nine files listed; only S36 read. A directory tree is navigation, not full content coverage.

### External primary documentation — separate from pinned target

- X01: https://git-scm.com/docs/git-worktree — consulted 2026-09-17, selected description/add/HEAD/index/topology sections. Supports underlying Git materialization semantics, not Superpowers efficacy or host-specific behavior.
- X02: https://git-scm.com/docs/git-check-ignore — consulted 2026-09-17, selected description, quiet option and exit-status sections. Supports the targeted path check interpretation. This is current documentation, not an exact local Git 2.47.3 source audit.
- Initial search results were irrelevant and discarded. Direct official documentation retrieval succeeded; no unavailable page was cited as verification.

## Progressive native source topology

This is not a complete recursive inventory or final subsystem taxonomy.

| Family | Observed role | Current coverage limit |
|---|---|---|
| Shared skills | 14 native skill directories | Six SKILL bodies fully read: using-superpowers, brainstorming, writing-plans, using-git-worktrees, SDD, executing-plans. Not all referenced mechanisms closed. |
| Host integration | Shell, native-description, manifest-sessionStart, includes, in-process callback paths | Selected material families covered in U01-B matrix. Not every supported host/version or distribution path. Devin and remaining installations deferred to U07. |
| Bootstrap/hooks | Selected shell registration/output/wrapper plus Cursor config | S06 local U01-A probes retained; wrapper source-only; event consumption not established. |
| In-process entry | OpenCode, Pi, Hermes | All three adapter bodies fully read; only OpenCode callbacks locally exercised. No actual host run. |
| Work entry / artifacts | Classification, spec/plan, Git workspace, ledger and task brief | U02 bounded source/helper model complete; human behavior, exact approval/revision binding and downstream review/retention remain qualified. |
| Supporting runtime/distribution | scripts, assets, root package, host dotdirs | Root package full; three SDD helpers now read, two executed; visual/runtime/packaging internals mostly open. Guide-to-Antigravity mismatch remains U07. |
| Tests/evaluation/history | tests, .github, pre-commit/version manifests, release history | Four first-party test bodies fully read across rounds, none run. Three separate study-written local experiments exist. CI/effectiveness open. |
| Contributor/orientation | README, CLAUDE, AGENTS, LICENSE and auxiliary files | README full; remaining contributor/license bodies not yet investigated. Root AGENTS symlink noted only. |
| Documentation | Porting and other docs/history | Porting guide full. Other documentation not recursively inventoried. |

Skill catalogue retained: brainstorming; dispatching-parallel-agents; executing-plans; finishing-a-development-branch; receiving-code-review; requesting-code-review; subagent-driven-development; systematic-debugging; test-driven-development; using-git-worktrees; using-superpowers; verification-before-completion; writing-plans; writing-skills.

## Method and project-context inputs

- `gstack/METHOD.md`, FULL initial round, blob `dc003b3f74115667a05787a847eadb10876784c8`: source-first synthesis precedent, not imported architecture.
- `gstack/META.md`, FULL initial round, blob `f2ad498742f026aa84578e82ec7fd0cf6843da65`: historical scope/no-adoption boundary; no current runtime comparison.
- Initial `research/INDEX.md`, `studies/INDEX.md`, `studies/PACKAGE-CONTRACT.md`, `studies/CATALOG.md`: full placement/continuity recovery.
- U01-B re-read package STATE, META, METHOD, PLAN, SOURCE-LEDGER and U01 note fully, then current CATALOG before updating its row. Concurrent registrations were preserved.
- U02 re-read current package STATE, META, METHOD, PLAN, SOURCE-LEDGER and U01-B note fully before source continuation. Shared CATALOG is refreshed before row mutation; unrelated studies remain protected.
- Agent-control files are not part of the substantive research corpus.

## Local experiment evidence

### E01/E02 — retained U01-A, not rerun

- Runner: [evidence/U01-hook-probes.py](evidence/U01-hook-probes.py).
- Output: [evidence/U01-hook-probes-results.json](evidence/U01-hook-probes-results.json).
- S06 exact blob `93a6bc2c6b7269c704378cb6a61fce6aea7ff631`, 2,274 bytes, verified before first-round execution.
- Linux, Python 3.13.5, GNU Bash 5.2.37. Temporary synthetic filesystem; no host, credentials, installation or external APIs.
- Four transport cases passed; two study-defined bootstrap-health challenges failed; one wrong-event negative control rejected correctly. Interpretation remains in the original U01 note.

### E03/E04 — retained U01-B, not rerun

- Runner: [evidence/U01B-opencode-probes.mjs](evidence/U01B-opencode-probes.mjs).
- Output: [evidence/U01B-opencode-probes-results.json](evidence/U01B-opencode-probes-results.json).
- S12 exact module blob `423e5ed513261485c657ba166b0372a5293639c7`, 5,464 bytes, transferred through connector output and hash-verified before execution.
- Linux x64, Node v22.16.0; built-in modules, temporary ESM/skill fixtures; factory/callbacks manually invoked. No install, network, real host/model or upstream suite.
- Eight mechanism checks passed; two study-defined semantic-health challenges failed (marker collision, empty-body loaded claim); one marker-only oracle control passed.
- V1/V2 and missing/repaired controls distinguish file revision, cached module and fresh module identity. A new ES module is not a host-session restart.
- Published/local runner blob `6a99be598bac4d60943c816857124c907882c089`; output `fae46fb808c5814fc7039f874f7d9aae5e5b34f3`. Identities establish transfer fidelity, not independence.
- Full interpretation: [U01-B note](notes/U01B-host-delivery-and-continuity.md).

### E05/E06 — U02 actual execution

- Runner: [evidence/U02-handoff-probes.py](evidence/U02-handoff-probes.py).
- Output: [evidence/U02-handoff-probes-results.json](evidence/U02-handoff-probes-results.json).
- Exact S32/S33 source copies matched Git blobs before execution (1,586 / 1,158 bytes). S34 also transferred/hash-verified (1,469 bytes), not executed. S29 supplied one literal displayed ignore-check command only.
- Linux, Python 3.13.5, Git 2.47.3, Bash 5.2.37. Isolated HOME, synthetic temporary repos/commits/worktrees; no remotes, credentials, installs, dependency commands, model/host session or upstream suite.
- Thirteen cases: eleven expected mechanism/representation/identity observations; two failed health criteria: same-basename cross-plan overwrite and unselected-directory ignore acceptance. No other case failed.
- Descriptive PASS does not certify safety; e.g. preserving a synthetic completion marker after a same-path revision is an observation, not accepted completion. Fixture controls constrain local checks, not an independent review or universal verifier.
- GitHub readback matched actual local runner `5cf7d9dd25ade628743a3250158486c8349a6fb5` and output `c95be67a743b7e8526e9fe30a2198117aee61d50` exactly.
- Full interpretation: [U02 note](notes/U02-approval-plan-workspace-handoff.md).

## Acquisition and negative-evidence limits

First-round archive and later raw-source acquisition attempts failed at container DNS resolution, including U02. Connected GitHub reads/writes worked. U02 official Git documentation was accessible through web, but no full clone/archive was obtained; transferred scripts/modules do not imply full-repository availability.

No real Claude/Codex/Cursor/Gemini/Kimi/Hermes/Pi/OpenCode session, Windows wrapper, model/credentialed call, upstream suite or CI verdict was produced. No production incident, general reliability ranking, development-quality benchmark or host namespace/API qualification is claimed.

Absence from this progressive map is not repository-wide absence. Source/helper units may close with explicit host/effectiveness limits; the whole study remains open while load-bearing execution/review/verification/lifecycle families require further investigation.
