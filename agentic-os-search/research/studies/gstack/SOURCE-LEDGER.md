# gstack Study — Source Ledger

## Canonical target

Primary study sources refer to:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

Pinned release context: `v1.79.0.0`; observed 2026-09-05.

Freshness revalidation was completed on 2026-09-06 against:

`garrytan/gstack@c24121663732644c56280474a1720475dbe53127` (`VERSION` = `1.80.0.0`).

The pinned corpus remains the canonical research snapshot. Current-HEAD delta evidence is kept separate in `revalidation/2026-09-06-v1.80.0.md`.

## Status legend

- **FULL** — source read as a whole with enough visibility for the stated synthesis use.
- **SUBSTANTIAL / CONTINUE** — meaningful source coverage; re-enter before stronger whole-file claims.
- **INVENTORY** — topology/metadata inspected only.
- **ABSENT / NEGATIVE** — searched-for evidence/surface does not exist at the pinned revision or registered matrix.
- **BOUNDED NEGATIVE** — targeted search did not find the surface; not a universal proof of absence outside searched scope.
- **REVALIDATED** — pinned conclusion selectively checked against the later observed `main` delta.

`FULL` means read coverage, not independent verification.

Detailed path-level provenance also remains inside the relevant subsystem syntheses. This ledger is the compact cross-package source router, not a replacement for those backreferences.

---

## Orientation / governing sources

| Source | Blob / evidence | Status | Role |
|---|---|---:|---|
| `AGENTS.md` | `7d802490e95cb7d6f19f9328d20223d6ce696ee9` | FULL | repo source-of-truth, generation, testing/security rules |
| `CLAUDE.md` | `115a5228277d6a5ecae31c3dc86b76802a739f62` | FULL | detailed repository/eval/release contract |
| `ETHOS.md` | pinned | FULL | behavioral philosophy |
| `DESIGN.md` | pinned | FULL | visual/design artifact policy |
| `ARCHITECTURE.md` | `374dd8774bd08657cb15987182596a7630bfae47` | FULL | runtime/browser/daemon/security architecture |
| `BROWSER.md` | pinned | SUBSTANTIAL / CONTINUE | browser operator/architecture view |
| `docs/PROJECT_STRUCTURE.md` | pinned | FULL | derived structure view; actual tree wins |
| `package.json` | pinned, v1.79.0 | FULL | runtime/test/eval commands and dependencies |
| root `SKILL.md.tmpl` | `402bd0d7b0f2bf02f6c9e4754e0e2a655f5f4057` | FULL | intent router |
| root tree/contents | pinned GitHub tree | INVENTORY | actual repository topology |

Source-fidelity correction retained: `docs/PROJECT_STRUCTURE.md` is a derived/intended view and was stale for some paths during the pinned pass. Direct pinned tree/file reads control path-existence claims.

---

## Planning / specification / work-admission sources

| Source | Evidence | Status | Role |
|---|---|---:|---|
| `office-hours/SKILL.md.tmpl` | `ecd96fb4186115182a653f67e59c1dc7496ed326` | FULL | discovery, premise/alternative qualification |
| `office-hours/sections/manifest.json` | `fa6df52648ceca8ea427056d73000c8a7d6cd870` | FULL | section registry |
| `office-hours/sections/phase-2a-startup-diagnostic.md.tmpl` | `0e3a12274d5cbd2845130e529aec6f9118b7d479` | FULL | forcing/evidence questions |
| `office-hours/sections/phase-2b-builder-brainstorm.md.tmpl` | `e49d6cd80b61b8b12cfc6e3d372b8b8c0857134b` | FULL | builder/generative mode |
| `office-hours/sections/design-and-handoff.md.tmpl` | `5924dd706a141a77d96ea05aec998e6ddbaae5b9` | SUBSTANTIAL / CONTINUE | design lineage, approval, handoff, memory/promotion surfaces |
| `plan-ceo-review/SKILL.md.tmpl` | `1b1affe160d2919ee08e00f101784a97d210906a` | FULL | scope/ambition/authority |
| `plan-ceo-review/sections/manifest.json` | `5ef4425a943600708ff1d0fdb9352f2a97c07de9` | FULL | section registry |
| `plan-ceo-review/sections/review-sections.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | full-depth review findings/gates |
| `plan-eng-review/SKILL.md.tmpl` | `e066e2c5f5028ad3b8485fe8606967ac1188b47e` | FULL | target/scope authority |
| `plan-eng-review/sections/manifest.json` | `f76e8f95bf4b313cecc2797278440cfc8f0a90a5` | FULL | section registry |
| `plan-eng-review/sections/review-sections.md.tmpl` | pinned | FULL for synthesis use | architecture/test/perf review + optional worktree-parallelization planning |
| `autoplan/SKILL.md.tmpl` | `6a034e15e7647980d74dfa71bfe17c25875ed054` | SUBSTANTIAL / CONTINUE | delegated decisions and audit |
| `spec/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | why/scope/code-evidence/spec spine |
| `spec/sections/gate-and-file.md.tmpl` | `f8923a834e9228d42b4e535ed8b97cb52e0e5a6d` | FULL | quality/redaction/sink/issue/archive/spawn controls |

---

## Review / QA / delivery-qualification sources

| Source | Evidence | Status | Role |
|---|---|---:|---|
| `review/SKILL.md.tmpl` | `a1d6a172746bdc4905731fe4e96ffb6976a579e9` | FULL | diff review/Fix-First |
| `review/sections/manifest.json` | `26a94ca3a7ed431514d857d9b6bd758afa859e88` | FULL | section registry |
| `review/sections/plan-completion.md.tmpl` | `7a7ae47e4ae31f1e28991bf7b233fc665f2ad4a8` | FULL | standalone plan audit policy |
| `review/sections/plan-completion.md` | `38da1ae08b0d966004d522b74af3f48ffceadcf3` | FULL | generated audit implementation |
| `ship/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | delivery orchestration |
| `ship/sections/manifest.json` | `e4394e5623f9421972c9be642f7d202760af866d` | FULL | ship section registry |
| `ship/sections/tests.md` | pinned | SUBSTANTIAL / CONTINUE | merged-code tests/failure ownership |
| `ship/sections/test-coverage.md` | pinned | SUBSTANTIAL / CONTINUE | semantic path coverage |
| `ship/sections/plan-completion.md` | `2c36cefe477d68768a5623090c9a90835427ae5f` | FULL | ship-time plan control |
| `ship/sections/review-army.md` | `bb1c3b82910ebaccf1beecfa10bf0771cc777601` | SUBSTANTIAL / CONTINUE | fresh specialists/red-team/fix loop |
| `ship/sections/adversarial.md` | `254331b9f615a09dc6e96deb952d622fe54bcd32` | FULL | Claude/Codex adversarial challenge |
| `ship/sections/pr-body.md` | pinned | SUBSTANTIAL / CONTINUE | PR/release evidence aggregation + spawned doc-sync handoff/recovery |
| `qa-only/SKILL.md.tmpl` | `75c4123cc5c406ffdd36c71a094335c137135b1e` | FULL | browser report-only evidence |
| `qa/SKILL.md.tmpl` | `d15a0c5d151ec6a8b15cd3a31dc96430ddb91909` | FULL | browser fix/verify loop |
| `scripts/resolvers/utility.ts` | `911b01d8f7e5264a759cfa878c440e7f642eb7cb` | FULL for synthesis use | shared QA methodology |
| `scripts/resolvers/review.ts` | `04f2dee0091e768ad1a11feda9f3a824256bfb45` | FULL for synthesis use | review standing/freshness |

---

## Browser runtime / security / evidence sources

| Source | Evidence | Status | Role |
|---|---|---:|---|
| `browse/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | browser contract/evidence caveats |
| `browse/src/server.ts` | pinned | SUBSTANTIAL / CONTINUE | daemon/listeners/auth/dispatch/security/audit |
| `browse/src/browser-manager.ts` | pinned | SUBSTANTIAL / CONTINUE | browser lifecycle/tab ownership |
| `browse/src/tab-session.ts` | `dccabf28f4263cb77d0a594369bb15f3e2c7ad73` | FULL | per-tab state/ref invalidation |
| `browse/src/token-registry.ts` | `89b0a990c31e26188275295e3d2d60f5908c5033` | FULL | scoped authority/revocation |
| `browse/src/cdp-allowlist.ts` | `752ce464c8e9e5d9f697c81a08444d0dd666b1e0` | FULL | deny-default CDP |
| `browse/src/cdp-bridge.ts` | `3d1fa3d8d002656f0e9528001df7b7c6e300b80b` | FULL | locks/timeouts/CDP lifecycle |
| `browse/src/url-validation.ts` | `c9e9c170ac36a6c744f47dee2b3bf15eb49e68f1` | FULL | URL/SSRF controls |
| `browse/src/path-security.ts` | `bc02ccde06c753dcd4b00e3fba49ad87267adb04` | FULL | filesystem path controls |
| `browse/src/session-persist.ts` | `3c6627bcbc0c24e76c519934b0a3a9ba3b87aca9` | FULL | opt-in persistence/restore |
| `browse/src/content-security.ts` | `a185764583f73aaa7b8d979d8ff5942bf63c25f7` | FULL | deterministic content defenses |
| `browse/src/security.ts` | `3da662a008e0785102f6572de468cc8dcb6bc136` | FULL | verdict combiner/dead-state context |
| `browse/src/security-classifier.ts` | `a89ddf694b165872263ed8a2f46e88faa5b3f52f` | FULL | optional fail-open ML defense |
| `browse/src/audit.ts` | `f93b47fb090c99c95dd3c83091a0b097330130df` | FULL | best-effort persistent audit |
| `browse/src/activity.ts` | `b15eb45a1d1c2bf5ae57f832418a0d7aa40a0f52` | FULL | bounded live activity/gaps |

---

## Investigation / causal-control sources

| Source | Evidence | Status | Role |
|---|---|---:|---|
| `investigate/SKILL.md.tmpl` | `c7cd9a99ad695f966ef2befaf18b1120eff89535` | FULL | causal workflow/3-strike/verification/learning |
| `freeze/SKILL.md.tmpl` | `e6804d91c23d1fd9804097a14adbc21a58745979` | FULL | Edit/Write boundary and non-sandbox caveat |
| `freeze/bin/check-freeze.sh` | pinned blob `6c6e62e76395a4cb568a13f7578f4222ae0bb26d` | FULL | pinned runtime freeze enforcement |
| `freeze/bin/check-freeze.sh` | current blob `02ac381ca974532e62181000a8630dcf70244c40` | REVALIDATED | v1.80 state-root + fail-closed hardening |
| `unfreeze/SKILL.md.tmpl` | `88e413fe5a49a45d46d8867b2d80ace30b3b45aa` | FULL | freeze cleanup |
| `bin/gstack-paths` | `5b66e3102ff5c55b76bf88b0a2cdc31ae6b83d56` | FULL | state-root resolution |
| OpenClaw investigate adaptation | pinned | FULL | causal phases without freeze |

Current-main correction: the specific pinned `/freeze` `GSTACK_HOME` state-root fail-open defect was repaired in v1.80. The broader Edit/Write-only scope/non-sandbox conclusion remains.

---

## Memory / learnings / context / GBrain sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| `context-save/SKILL.md.tmpl` | `a3702bc95439cddd87841aba836708bf511ef55d` | FULL for synthesis use | explicit append-only context checkpoint |
| `context-restore/SKILL.md.tmpl` | `d2e78ca8976b96df3077bce57ab5396ad7e4afd2` | FULL for synthesis use | branch-aware restore/fallback; summary not source-revalidated |
| `learn/SKILL.md.tmpl` | `90d08d2298cccd0d5090f194a2cd76a5361b4323` | FULL for synthesis use | learning show/search/add/prune/export/stats |
| `scripts/resolvers/learnings.ts` | `aefc0fb864a3b19ee33b6253e1dbf7228ce2ba82` | FULL | learning schema/search/log prompt contract |
| `bin/gstack-learnings-log` | `3c47ebb80a4285028cf7c54549038553b81c5eb4` | FULL | validation/injection filter/trust mark/append |
| `bin/gstack-learnings-search` | `d7038e821881861f9661af2f34f3728bf1cabe23` | FULL | decay/latest-winner/query/cross-project trust |
| `scripts/brain-cache-spec.ts` | `eab2f9588776f7d3d9c734d9dcd2e1a52ba6879f` | FULL for synthesis use | canonical entity scope/TTL/budget/invalidation spec |
| `bin/gstack-brain-cache` | pinned | SUBSTANTIAL / CONTINUE | cache states/refresh/atomicity/stale fallback |
| `scripts/resolvers/gbrain.ts` | `6c6b66d640187363c0dc12326fe08adfb689c98d` | FULL | planning consumer suppresses cache stderr, losing stale label |
| `bin/gstack-gbrain-repo-policy` | pinned | FULL for synthesis use | per-remote read-write/read-only/deny store; batch fail-closed |
| `lib/gbrain-repo-policy-client.ts` | `890282847a4241e4f79509360de5dc6a33de2505` | FULL | shared TS policy client |
| `bin/gstack-memory-ingest.ts` | pinned | SUBSTANTIAL / CONTINUE | transcript/artifact ingest policy filtering |

Freshness: `scripts/resolvers/gbrain.ts` is byte-identical between pinned v1.79 and revalidated v1.80; the stale-fallback qualifier-loss finding remains current through `c2412166...`.

---

## Multi-agent / cross-model coordination sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| pinned v1.79 commit `0d1bd...` | commit message/diff | FULL for synthesis use | third stranded-parent recurrence; foreground fix/recovery/TODOs |
| `scripts/resolvers/constants.ts` | `4e94b986eff9a526eae24acead228e50dafb8bd8` | FULL | foreground dispatch + Codex availability semantics |
| `test/run-in-background-guidance.test.ts` | `bd0f1e42d95c0ac96ec40cda7a89112cd2c1f749` | FULL | cross-carrier structural pin/scanner |
| `ship/sections/pr-body.md` | pinned | FULL for multi-agent use | spawned docs child, JSON contract, timeout/cancel/reconcile |
| `document-release/SKILL.md` | pinned | SUBSTANTIAL / CONTINUE | spawned-session decision semantics |
| `test/skill-e2e-ship-docsync.test.ts` | pinned | FULL | actual dispatch/foreground behavioral pin |
| `test/skill-e2e-docsync-spawned.test.ts` | pinned | FULL | spawned child gate + JSON contract |
| `review/sections/review-army.md` | `f37fb5d738106c063bdcf784078535d714723bc5` | FULL for synthesis use | parallel specialist aggregation |
| `test/skill-e2e-review-army.test.ts` | pinned | SUBSTANTIAL / CONTINUE | checklist/output behavior; weaker topology proof |
| `ship/sections/adversarial.md` | pinned | FULL for synthesis use | same-family + Codex challenge |
| `codex/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | outside-model workflow/nesting guard |
| `test/codex-under-codex-detection.test.ts` | `b2428244eaf6fab4be0ce86a914594987a643c70` | FULL | same-model nesting detection |
| Autoplan phase sections | pinned SHAs in synthesis | FULL for synthesis use | deliberately asymmetric Claude/Codex context |
| `test/skill-e2e-autoplan-dual-voice.test.ts` | `1efc6dfc68643fa2772770ea9b87187986612e99` | FULL | periodic actual dual-voice invocation/liveness |
| `cso/SKILL.md` | pinned | SUBSTANTIAL / CONTINUE | fresh verifier pattern |
| `test/skill-e2e-cso.test.ts` | `5f58a45d053b450d958c16696ec65fa8e393a60c` | FULL for synthesis use | selected live verifier behavior |
| `design-shotgun/SKILL.md` | pinned | SUBSTANTIAL / CONTINUE | parallel generative fan-out |
| dedicated Design Shotgun E2E | targeted search | ABSENT / NEGATIVE | no dedicated production-topology E2E found |
| `pair-agent/SKILL.md.tmpl` | `2f66ec44b63ba24e6a0ba4023a042f66342edefc` | FULL for synthesis use | remote/local browser capability delegation |
| `plan-eng-review/sections/review-sections.md` | pinned | SUBSTANTIAL / CONTINUE | optional worktree parallelism |
| `hosts/define-host.ts` | `0ed190dd00606a69acb0aca990289781f79bbc79` | FULL | host tool rewrite model |
| `hosts/codex.ts` | `b46e9222495eada3da68debaae6dab6d9d57167c` | FULL | Codex host suppression / Agent mismatch context |
| pinned `TODOS.md` dispatch items | pinned | SUBSTANTIAL / CONTINUE | host dispatch defect + runtime foreground follow-up |

No multi-agent dispatch template/resolver files are in the single v1.80 changed-file set; pinned coordination conclusions remain current through the observed revalidation point.

---

## Guarded-action / security-review sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| `careful/SKILL.md.tmpl` | `8fba18fb0bc699d68058bb569a55a2aa535ebb93` | FULL | Claude Bash PreToolUse safety contract; MEDIUM ask + narrow HIGH deny |
| `careful/bin/check-careful.sh` | pinned blob `b6bebb9d3cc74758a292dd779361a7b5f49fff0b` | FULL for pinned synthesis | parser/obfuscation/safe-exception/destructive-pattern enforcement |
| `guard/SKILL.md.tmpl` | `d4c78be492ed24425a763008c975bd5e4569a5ee` | FULL | composition of careful Bash + freeze Edit/Write hooks |
| `freeze/bin/check-freeze.sh` | pinned/current deltas above | FULL / REVALIDATED | path deny control reused by guard |
| `test/hook-scripts.test.ts` | pinned + v1.80 changed | FULL / REVALIDATED | realistic hook regressions; v1.80 adds state-root/backstop coverage |
| `scripts/gen-skill-docs.ts` | `0be3ca9a126d0e3ad0f9cf76b641f15a728307c0` | FULL for safety-prose path | external-host hook extraction → Safety Advisory prose |
| `test/gen-skill-docs.test.ts` | `cc4a8eaaf982d86c0dd8d21965f689431f65168f` | SUBSTANTIAL / CONTINUE | external hook skills have safety prose and no hooks frontmatter |
| `scripts/one-way-doors.ts` | `61c0b24eaeec133afa399cd032d2106597bc4ff8` | FULL | typed-registry-first / keyword-fallback destructive-decision classification |
| `hosts/claude/hooks/question-preference-hook.ts` | `3e488363f005659e65f271445e46d06741a97795` | FULL | never-ask enforcement; one-way safety override; refuse-on-ambiguous |
| `test/plan-tune.test.ts` | `4eb9483ba2f808810f454b7011785afc704ff20f` | FULL | one-way typed-registry invariants |
| `test/question-preference-hook.test.ts` | pinned | SUBSTANTIAL / CONTINUE | one-way overrides never-ask; destructive keyword defense-in-depth |
| `cso/SKILL.md` | `d16aef3278eede8f2b5377ed7d2798c8f5c11eff` | FULL for late-phase synthesis use | FP filters, active verification, confidence/status, source-quote gate, report/trend |
| `test/skill-e2e-cso.test.ts` | `5f58a45d053b450d958c16696ec65fa8e393a60c` | FULL | full/diff/infra live audit; diff path records verifier child |
| `.gstack/security-reports` consumers | targeted repo search | BOUNDED NEGATIVE | no separate live ship/deploy gate found in targeted search |

---

## Host adapters / portability-fidelity sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| `hosts/index.ts` | `cc1c213b532a5abb3bdf95a292a3a422c2faa1f8` | FULL | ten-host registry and host lookup/alias model |
| `scripts/host-config.ts` | `378a24e2fefc500e166c848580e60dba8a8e242a` | FULL | typed HostConfig + validators |
| `hosts/define-host.ts` | `0ed190dd00606a69acb0aca990289781f79bbc79` | FULL | common defaults, suppression sets, tool rewrites |
| `hosts/claude.ts` | `5381953cae8040508a260e6e4b3eb39973c92934` | FULL | primary host semantics |
| `hosts/codex.ts` | `b46e9222495eada3da68debaae6dab6d9d57167c` | FULL | Codex model/path/suppression/boundary adaptation |
| `hosts/factory.ts` | `9161d7fafa0c02dd8721051a357d1bd76fc2f856` | FULL | sensitive metadata + generic tool rewrites |
| `hosts/kiro.ts` | `05d4b9ee512fe317299732d4573bce70cd27602f` | FULL | path adaptation |
| `hosts/opencode.ts` | `fcba39d91f0a7b14dd1b272a4c1e295a75fc2a07` | FULL | expanded runtime-root asset set |
| `hosts/slate.ts` | `99fa7197ab27f478f29d84d3a3d76f790b5331af` | FULL | registry/generation config despite non-first-class setup standing |
| `hosts/cursor.ts` | `e0d38db8a8c8bb2f05f9ca923c6fa3c715018d7e` | FULL | default host config; first-class setup arm exists separately |
| `hosts/openclaw.ts` | `6248e0587f083640b0b747ebff7eac90e90b258e` | FULL | sessions_spawn-style rewrites, suppression, instruction tier |
| `hosts/hermes.ts` | `cf140fae79bd69114b966def75960b2bfc13f339` | FULL | terminal/patch/delegate_task rewrites; GBrain enabled; instruction tier |
| `hosts/gbrain.ts` | `32dfaa349ef5f67b9f5f642e2c979c63ee79e1ea` | FULL | brain-aware resolver retention |
| `scripts/models.ts` | `e7bdf3d2f4e32da7139e710ef50714572842160a` | FULL | explicit host != model; family/overlay normalization |
| `scripts/resolvers/model-overlay.ts` | pinned | SUBSTANTIAL / CONTINUE | model-specific behavior patch generation |
| `scripts/gen-skill-docs.ts` | `0be3ca9a126d0e3ad0f9cf76b641f15a728307c0` | FULL for portability synthesis | host compilation, frontmatter transform, suppression, section inlining, safety prose |
| `docs/ADDING_A_HOST.md` | `d699816df9d63ee964a4d8184fb2b9528012526d` | FULL | intended declarative architecture; overstates setup integration at pinned revision |
| `scripts/host-config-export.ts` | `35a0b91927dc38c8b45f4b8cf614d89ab1ba98bb` | FULL | explicit statement that setup still hand-rolls host lists |
| root `setup` | pinned | SUBSTANTIAL / CONTINUE | actual install/support tiers, runtime roots, host/model detection |
| `scripts/skill-check.ts` | `9182737ee19e83855a622a90d3cb6e00ac793b73` | FULL | generated-host path/freshness health, not behavioral parity |
| `test/host-config.test.ts` | pinned | FULL | config/index/export/golden structural validation |
| `test/gen-skill-docs.test.ts` | pinned | FULL for portability use | all-host generation and structural checks |
| `test/helpers/codex-session-runner.ts` | pinned | SUBSTANTIAL / CONTINUE | real Codex CLI behavioral harness |
| `test/codex-e2e.test.ts` | pinned | SUBSTANTIAL / CONTINUE | real Codex workflow behavior |
| `test/codex-e2e-sol-scope.test.ts` | pinned | SUBSTANTIAL / CONTINUE | Sol-profile behavior/scope termination |
| Factory/Kiro/OpenCode/Cursor real-host E2E | targeted repo search | BOUNDED NEGATIVE | no comparable dedicated runners found |
| OpenClaw/Hermes full install/runtime parity | setup + targeted search | BOUNDED NEGATIVE / DIFFERENT CONTRACT | methodology/instruction-tier integration rather than same full install |

No `hosts/**` source is in the v1.80 changed-file set; pinned host-portability model remains current through `c2412166...` except for setup-level materialization changes recorded in the revalidation note.

---

## Deploy / Canary / production / retrospective sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| `land-and-deploy/SKILL.md.tmpl` | `b78eae6c18617308b7bce373280b40a98204b370` | FULL for synthesis use | merge authority/state, deploy, health, revert path |
| `setup-deploy/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | persisted deployment configuration/fingerprint |
| `canary/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | longitudinal live-health monitoring/baseline semantics |
| `retro/SKILL.md.tmpl` | pinned | SUBSTANTIAL / CONTINUE | historical operational feedback/trends/recommendations |
| `test/skill-e2e-deploy.test.ts` | pinned | FULL for current use | real-agent workflow with simulated external merge/deploy/canary effects |
| `test/skill-coverage-matrix.ts` / E2E routing | pinned | FULL for production coverage use | Canary attribution inconsistency |
| deploy/canary report schemas and history surfaces | pinned | SUBSTANTIAL / CONTINUE | durable evidence + release/live-state representation |

Freshness: `land-and-deploy/SKILL.md.tmpl` is byte-identical between pinned and v1.80. The `REVERTED != production restored` closure finding remains current through `c2412166...`.

---

## Testing / eval / routing / compliance / flake sources

| Source | Status | What it supports |
|---|---:|---|
| `package.json` test/eval scripts | FULL | free/paid/E2E/eval command topology |
| `test/skill-coverage-matrix.ts` | FULL | skill gate/periodic coverage registry |
| `test/skill-coverage-floor.test.ts` | FULL | generic structural floor; not behavioral proof |
| `test/helpers/paid-test-set.ts` | FULL for synthesis use | canonical paid-test ownership set |
| `test/e2e-tier-alignment.test.ts` | FULL for synthesis use | tier metadata ↔ child self-gating consistency |
| touchfile/diff selection helpers | FULL/SUBSTANTIAL | fail-toward-inclusion routing and map-change behavior |
| paid planner/executor/reconciler surfaces | FULL/SUBSTANTIAL | one selection manifest, shard ownership, missing-artifact fail-closed reporting |
| `scripts/test-strict-output.ts` | FULL for synthesis use | child exit 0 != suite pass; output/census oracle |
| `test/helpers/session-runner.ts` | FULL for synthesis use | real Claude process, startup/work timeout split, process-group cleanup |
| eval store / collector surfaces | FULL/SUBSTANTIAL | partial accumulator vs finalized run, provenance metadata |
| eval compare / baseline helpers | FULL/SUBSTANTIAL | partial exclusion, same-shard/branch preference, no-baseline semantics |
| `eval-list` family | FULL for negative finding | partial accumulators appear in run listing |
| `eval-summary` family | FULL for negative finding | partial files can enter run/cost/flake aggregates |
| `eval-flake-rank` | FULL for synthesis use | finalized-run filtering / recurrence view |
| LLM-judge evals | SUBSTANTIAL / CONTINUE | semantic-quality oracle with probabilistic/common-cause limits |
| Codex/Gemini E2E harnesses | SUBSTANTIAL / CONTINUE | external-host/runtime behavior with availability caveats |
| compliance/audit/slop scans | SUBSTANTIAL / CONTINUE | structural/policy hygiene gates; not universal behavioral proof |
| `test/skill-e2e-deploy.test.ts` | FULL for topology caution | real agent does not imply live external integration |
| Codex periodic CI known gap | pinned `TODOS.md` | FULL for negative finding | all-skip can still present a green lane if execution census is ignored |

The testing/eval subsystem is **synthesized and closed**. The old ledger state `broader LLM judge/routing/compliance/flake lifecycle tests: PLANNED` is retired.

No eval consumer/routing files are in the one-commit v1.80 changed set, so the pinned partial-artifact and execution-standing conclusions remain current through `c2412166...`.

---

## Repository self-development / generation / update / release sources

| Source | Evidence | Status | Role / key finding |
|---|---|---:|---|
| `scripts/gen-skill-docs.ts` | `0be3ca9a126d0e3ad0f9cf76b641f15a728307c0` | FULL | canonical template/resolver/host/model compilation |
| `scripts/resolvers/index.ts` | `cee08c2015a6ac2ff8605b02ac07a49d284d3ce1` | FULL | resolver registry |
| `scripts/resolvers/sections.ts` | `c6425e19b93d20018057cf2fe6ae9eeb2f613a18` | FULL | carved section rendering |
| `scripts/resolvers/composition.ts` | `b8d3483d9bd961409025959eddcd8840dd5f98a8` | FULL | parent-child composition |
| root `setup` | pinned + v1.80 delta | SUBSTANTIAL / CONTINUE + REVALIDATED | runtime materialization; v1.80 capability/ownership hardening |
| user-local render/relink surfaces | pinned + v1.80 `gstack-relink` delta | FULL/SUBSTANTIAL + REVALIDATED | out-of-tree local render, provenance-bound installed mutations |
| `gstack-upgrade/SKILL.md.tmpl` | `158f3e052f60e0f220fdaede640767fc078eb435` | FULL for synthesis use | manual upgrade/backup/setup/migration orchestration |
| `gstack-upgrade/migrations/v1.27.0.0.sh` | pinned | FULL for migration finding | per-migration journal/done/skip semantics; outer version-window gap |
| `bin/gstack-update-check` | `3573c7878acd9192520b4310fae8f6aa0a2d066b` | FULL for negative finding | remote version freshness/cache standing |
| update-check tests | pinned/current | FULL for negative finding | invalid/unreachable remote deliberately cached as `UP_TO_DATE` |
| `bin/gstack-session-update` | `15f8caa8728a02bd5ccef2df193106116c434e4d` | FULL | background pull/setup/marker state machine |
| `test/session-update-autostash.test.ts` | pinned | FULL/SUBSTANTIAL | pull/autostash/lock liveness; no setup-failure standing pin found |
| `bin/gstack-next-version` | pinned | FULL for synthesis use | pure queue-aware version-slot reader/reporter |
| `test/gstack-next-version.test.ts` | pinned | FULL | arithmetic/slot/version-path/fallback tests |
| `bin/gstack-version-bump` | pinned | FULL for synthesis use | deterministic classify/write/repair version state |
| `test/gstack-version-bump.test.ts` | pinned | FULL | idempotency/drift/write/repair/lockfile behavior |
| `.github/workflows/version-gate.yml` | `3c8dcb1f6f77b3cc3b2fd168782f99b2c24fce46` | FULL | queue collision/version gate; util error fail-open |
| `scripts/compare-pr-version.ts` | `27f746aaae2eeaa021e53c0bdf1935c1fb04b924` | FULL | hard rules: base advance + collision; suggested slot informational |
| `TODOS.md` | pinned/current selectively | SUBSTANTIAL / CONTINUE | explicit deferred migration/tag/update/test-gap debt |
| selected release chronology / commit history | sampled | FULL for evolution use | capability growth → environment bugs → control hardening → recurrence repair |

### Freshness-preserved negative findings

Byte identity from pinned v1.79 to observed v1.80:

```text
bin/gstack-update-check      3573c787... → same
bin/gstack-session-update    15f8caa8... → same
gstack-upgrade/SKILL.md.tmpl 158f3e05... → same
```

Therefore v1.80 does not repair the recorded update-check, session-update or migration-orchestration concerns.

---

## v1.80 freshness / revalidation evidence

| Source | Status | Role |
|---|---:|---|
| pinned→current compare `0d1bd...` → `c241216...` | REVALIDATED | exactly one commit ahead; complete 38-file delta inventory |
| current `VERSION` | REVALIDATED | `1.80.0.0` |
| release commit `c241216...` | FULL for delta use | freeze/setup/relink/telemetry/test-harness changes |
| PR `#2802` | FULL for delta use | merged release rationale, test plan, review record |
| final PR head `10100d...` workflow runs | REVALIDATED | Quality, Free, Windows Free, Windows Setup E2E, E2E Evals, Skill Docs, Workflow Lint, Dependency Review, Version Gate, make-pdf gate all visible success |
| Free Tests job | REVALIDATED | actual `Run free suite` step completed successfully |
| Windows Setup E2E job | REVALIDATED | build, binary, find-browse and gstack-paths checks completed successfully |
| `revalidation/2026-09-06-v1.80.0.md` | BOUNDED SYNTHESIS | current-head impact and repin decision |

Verification boundary: these are strong first-party execution signals, not independent external replication.

---

## Durable synthesis ladder

| Layer | Artifact | Status |
|---|---|---:|
| Native subsystem | `syntheses/planning-specification-work-admission.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/review-qa-ship-delivery-qualification.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/browser-runtime-security-evidence.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/investigation-root-cause-debug-control.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/memory-learnings-context-gbrain.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/multi-agent-cross-model-coordination.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/guarded-action-security-review.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/host-adapters-portability-fidelity.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/deploy-canary-production-retrospective-feedback.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/testing-eval-routing-compliance-flake-lifecycle.md` | BOUNDED / CLOSED |
| Native subsystem | `syntheses/repository-self-development-generation-upgrade-release.md` | BOUNDED / CLOSED |
| Cross-system | `syntheses/cross-system-composition.md` | BOUNDED / CLOSED |
| Foundation projection | `syntheses/four-ground-projection.md` | BOUNDED / CLOSED; comparison only |
| Cross-ground mechanisms | `syntheses/cross-ground-mechanisms.md` | BOUNDED / CLOSED |
| Core | `CORE.md` | COMPACT TOP-LAYER VIEW |

Higher synthesis never removes source re-entry.

---

## Evolution / chronology

| Source | Status | Note |
|---|---:|---|
| full `CHANGELOG.md` | PARTITIONED / SAMPLED | deliberately not linearly reread; chronology sampled by mechanism/failure wave |
| early March–April commits | SAMPLED / SYNTHESIZED | workflow/browser/cross-model capability expansion |
| May environment/community waves | SAMPLED / SYNTHESIZED | Windows/runtime/state-contamination/install failure pressure |
| August hardening waves | SAMPLED / SYNTHESIZED | generation/install/host/eval/self-consistency hardening |
| pinned v1.79 release commit | READ / SYNTHESIZED | repeated subagent-liveness failure → broader structural/behavioral controls |
| v1.80 release delta | REVALIDATED | setup/freeze/ownership/test-environment hardening; core model strengthened |

Chronology is horizontal corroboration of the mechanism model, not a twelfth native subsystem.

---

## Protected source-fidelity / verification warnings

1. Derived repository docs do not override actual pinned source/tree.
2. Generated `SKILL.md` does not replace `.tmpl`/resolver provenance.
3. Skill prose is intended workflow policy, not automatically executed behavior.
4. First-party tests/evals and green PR CI are not independent verification.
5. Same-family fresh-context and cross-model diversity are not automatically independent verification.
6. AI-assessed changed-path coverage is not instrumented coverage.
7. Pair-agent own-only tab isolation does not generalize to filesystem/worktree isolation.
8. Browser state continuity is not default cross-daemon persistence.
9. Investigate causal workflow is less behaviorally tested than freeze enforcement.
10. Context checkpoints are LLM-authored continuity views, not automatically current truth.
11. Local learnings are fallible sourced/decayed evidence.
12. GBrain `stale-fallback` qualification is lost before planning consumption and remains unchanged through v1.80.
13. Review Army behavioral tests do not establish statistical independence of specialists.
14. Fresh context is not side-effect isolation; selected children share mutable resources with parents.
15. v1.79 foreground guidance is not equivalent to universal runtime-enforced dispatch semantics.
16. Claude-host Agent semantics do not automatically port to other hosts.
17. `/careful` HIGH deny is explicitly best-effort/session-scoped, not a universal policy boundary.
18. `/guard` is careful+freeze composition, not a complete sandbox.
19. External-host careful/freeze/guard can degrade from PreToolUse enforcement to Safety Advisory prose.
20. CSO “read-only” is authored behavior, not an inspected source-write sandbox.
21. CSO confidence/status is an audit representation, not externally calibrated probability.
22. Historical `.gstack/security-reports` are not automatically current security truth or delivery gates.
23. One-way typed registry is the primary destructive-decision source; keyword prose classification is defense-in-depth.
24. Host registry membership, generated-file freshness, installability, runtime capability and behavioral validation are separate standings.
25. `docs/ADDING_A_HOST.md` is stale/aspirational where it says setup is already fully config-driven; implementation surfaces win.
26. Host and model are independent axes; do not infer model behavior from host identity alone.
27. External-host section inlining changes context/loading topology even where logical content is preserved.
28. A green lane is not positive behavioral evidence when the intended runtime/oracle skipped; execution census matters.
29. Targeted absence of non-Codex external-host E2E runners is a bounded repository finding, not proof about private/external validation.
30. Real-agent E2E does not automatically mean real external-system integration; deploy E2E simulates dangerous/external effects.
31. `REVERTED` in the pinned/current inspected deployment workflow does not prove production restoration.
32. Invalid/unreachable update-check remote state remains representable as `UP_TO_DATE`; remote freshness is not thereby proven.
33. Session-update source HEAD advancement can still outpace setup/materialization standing.
34. Outer upgrade version windows can advance past a skipped per-migration action; version advancement is not migration completion.
35. VERSION identity is not equivalent to immutable tag-pinned installed bytes in the inspected upgrade design.
36. v1.80 repairs the specific `/freeze` `GSTACK_HOME` fail-open bug; do not repeat that pinned defect as a current-main defect.
37. v1.80 setup success can intentionally coexist with unavailable Chromium; “setup completed” is not “all capabilities ready.”
38. The study remains pinned to v1.79 and only revalidated through `c2412166...`; later HEAD must be rechecked before load-bearing current-state reuse.
