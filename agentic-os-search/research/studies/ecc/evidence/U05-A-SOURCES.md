# U05-A — Source, evidence and discovery ledger

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. All load-bearing bodies below were fetched at this pin. [Source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). IDs continue S88. FULL means through EOF, not automatic dependency/platform/host closure. **No new execution.**

| ID | Path/object | Git blob or tree identity | Actual coverage |
|---|---|---|---|
| S89 | skills/continuous-learning-v2/SKILL.md | 397b3d334dd1fdf5d7648dd619b6a744cd4734a5 | FULL 1–250 + 251–550 reaching EOF; completes earlier partial screening, not a new independent source |
| S90 | docs/continuous-learning-v2-spec.md | a27be00b2351b6e5097dfa8d33b31eb6a89362ee | FULL; pointer/spec orientation |
| S91 | continuous-learning-v2 direct root and recursive scripts/hooks/agents subtrees | scripts d165e2df17338f5bcd1f8d6b0a98d073e5b0dee9; hooks 11a94c964033746b68411bd27eb4956ac841ac5f; agents 229296d909a2a5e58da211cf0aede0d9b5c7ea80 | FULL bounded metadata listings, recursive responses truncated:false; not body reading |
| S92 | skills/continuous-learning-v2/config.json | 84f622095f8c5929b6f41983698268a77b506d47 | FULL; disabled observer default, interval/count |
| S93 | skills/continuous-learning-v2/hooks/observe.sh | 61bdd85a0d48755c35d7a4138b3f7f8ff0bf9b96 | FULL 1–240, 241–500, 501–850 reaching EOF; guards, selected serialization, scrub, rotation, lazy start and signals |
| S94 | skills/continuous-learning-v2/agents/observer.md | 57c09b7341399625d60705b501e4e1a8579b2a5f | FULL; documented pattern/confidence/scope guidance, not actual loop prompt |
| S95 | skills/continuous-learning-v2/agents/observer-loop.sh | bce0d2d7cecd1bce128706991badbb22af861bb0 | FULL 1–260 + 261–560 reaching EOF; inline prompt, invocation/output binding, archive and retry |
| S96 | skills/continuous-learning-v2/agents/start-observer.sh | 5485a79e3f4076674a971acc6a2ec1e754fe8ec8 | FULL 1–320 reaches EOF; effective config and destination/loop environment |
| S97 | skills/continuous-learning-v2/scripts/instinct-cli.py | f7f35abbb52a232e5171f03c02cae484bb553d34 | FULL 1–280, 281–600, 601–940, 941–1280, 1281–1600, 1601–1940, 1941–2250, 2251–2500 reaching EOF; body complete despite duplicate metadata truncation in one response; no execution |
| S98 | scripts/hooks/session-start.js | 63854aff1c2efeaaa82fbf05886dadbd791a048e | FULL 1–260, 261–520, 521–830 reaching EOF; direct instinct selection/summary/context output, separate learned skills |
| S99 | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | SELECTED 45–67, 105–145, 145–210; initial 1–260 response TRUNCATED. Pre-observe/SessionStart/PostToolUse routes only, not whole hook manifest coverage |
| S100 | scripts/lib/instinct-relevance.js | 81dde7e79581418025a9b8c194b1729bebfa8fb4 | FULL; location/stack ranking, not current-task semantic oracle |
| S101 | scripts/hooks/session-start-bootstrap.js | 4da168bad72611821639d6c7106708e3722cf5fe | FULL; runner delegation and output/failure paths |
| S102 | scripts/hooks/observe-runner.js | c046d75f0dd11e3b6039e296eeace1ba24366cc7 | FULL; actual shell delegation, timeout/nonblocking behavior |
| S103 | scripts/lib/observer-sessions.js | 08296da3a4ade8c86ae2c3fdfd5b22937f34ab11 | FULL; homunculus/project resolution and leases; not full cross-language identity equivalence |
| S104 | tests/hooks/observer-loop-archive.test.js | f350892822c07de771ab43fae321c704aeb80b5a | FULL 1–260 + 261–600 reaching EOF; TEST SOURCE INSPECTED, NOT RUN |
| S105 | scripts/lib/utils.js | 5e29868eb51663c75122297e9062b5a9d027da73 | SELECTED 1–230; agent-data and learned-skill directory functions; rest not full-read by implication |
| S106 | scripts/hooks/posttooluse-dispatcher.js | fcffeb40086bd9327f6360348a0a093290739b0a | FULL 1–280 + 281–330 reaching EOF; actual post-observe routing and skill tracker dependency; unrelated imported hook bodies not read |
| S107 | scripts/lib/agent-data-home.js | 7302bd572ca183aef2ae33160cc5c672d7365539 | FULL 1–220 + 221–300 reaching EOF; actual learned-data root producer |
| S108 | scripts/lib/skill-improvement direct contents | observations 1544c4b9fa899b159abe285dd2a7137e14a87041; health 8aba59861e9bfc4c1e4263f103808c7999632663; amendify c95f0e91481b4a20d13107923f502258e7375391; evaluate f45023d549b0fc5ad0ac96ac1fef3eb5306bd5d9 | FULL four-file directory metadata at pin. Bodies NOT READ; concrete next-unit frontier |

## Claim/source binding

- Selected observation versus complete user/interaction evidence: S89/S93/S99/S102/S106; event meanings qualified by W10.
- Optional analysis, actual inline prompt and current-result archive gate: S92/S94–S96; S104's test oracle inspected. W11 qualifies allowedTools, not an exclusive sandbox assertion.
- Tail sample versus whole live-file archive, and retry versus existing instinct writes: S95; source-derived unexecuted paths. S104 uses three input lines and no concurrent append, so it does not close this scope issue.
- Heuristic confidence, import/scope promotion and generated structures: S94–S97. Auto promotion groups same IDs from personal/inherited per-project directories, not evidence independence or semantic agreement.
- Direct behavioral-context path and trigger/evidence omission: S98/S100/S101/S103; W10 is a separate current host contract, not a recorded invocation.
- Evolved artifacts versus learned-skill reader: S97/S98/S105/S107. No global absence of explicit install/discovery bridges is inferred.

## Separate current primary contract checks

**W10:** [Claude Code hooks reference](https://code.claude.com/docs/en/hooks), observed 2026-09-17. SELECTED event distinctions (PreToolUse/PostToolUse/PostToolUseFailure/UserPromptSubmit), enabled-plugin hooks and additionalContext delivery. The current manual describes a host contract, not proof of the historical/pinned deployment, hook delivery or model uptake. No full host-version/conformance audit.

**W11:** [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference), observed 2026-09-17. SELECTED allowedTools: tools execute without permission prompts; the manual distinguishes --tools for restricting availability. This prevents treating one flag in S95 as proof that no other tools or filesystem rights exist. No installed configuration/model/API/privacy test.

Unofficial search mirrors and unrelated results were not used as evidence. These mutable manuals are not ECC corpus repins.

## Execution and oracle limits

No ECC hook, observer, Python instinct command, test, CLI/MCP server, real model/harness or new local probe ran. No E04 was created. E01–E03 were not rerun. Only source/test-source reading supports this unit. S104's provider/guardian stubs, sourceable loop and current-output negative tests do not constitute an independent pattern-quality oracle; assertions are not passing results.

Capture/analysis guards, output descriptor binding, metadata thresholds, generation and injection are real source mechanisms. The source-derived sample/archive, same-ID disagreement/import duplication and conditional-action compression cases have not been executed as incidents. No claim about frequency of actual model errors or effectiveness is made.

## Bounded discovery progress and unclosed dependencies

S91 completes this skill's bounded directory topology: direct SKILL/config plus scripts/hooks/agents recursion. In addition to read bodies, discovered but unread files include detect-project.sh (ddf8f41500f0fc15e376c9e859fc78698ee5e696), scripts/lib/homunculus-dir.sh (27f9adb84258fdebbab6302e1d98207f0644816c), migrate-homunculus.sh (3453b92948d5fc067b48e3f8e7c4026936f8e3cd), test_parse_instinct.py (f58c58853b3874265fd405380423253b10d895cf), and agents/session-guardian.sh (39fd748525d71f6764da9b012368911f9dd04981). A complete small subtree listing is not a complete body/dependency/host review or full P1.

S98's project-detect and unrelated utility/package/alias functions were not all followed. Common profile/root/bootstrap wrappers include retained earlier evidence, but this unit does not claim a fresh complete audit of all hook infrastructure. Different producer/consumer project identities remain qualified. S108 is the next actual pinned subtree, not another completed study.

Searches used default-branch dd6ee538aee0f548d4a6b520118f875431fd749e for path discovery; all substantive bodies stayed at the pin. Auxiliary container raw acquisition failed at DNS and created no checkout. Connector reads worked. Failure of auxiliary acquisition is not ECC failure evidence.

Current AGENT and package STATE/PLAN/WHY/ROUND-U04-A/QUESTIONS/META/INDEX were recovered; unchanged full same-conversation METHOD, Note06, U04-A sources/receipt and required controls were retained. This is same-conversation recovery, not independent cold-start verification. Before publication, main 80499d8ef74f6123b44882fef0a4656b93f8d871 differed from the previous ECC closure only by Superpowers STATE and shared catalog changes; no ECC/control changes. Actual writes and checks belong in the publication receipt.
