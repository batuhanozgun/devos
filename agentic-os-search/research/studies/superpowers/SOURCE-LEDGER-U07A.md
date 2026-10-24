# Superpowers — Source Ledger Supplement U07-A

Observation date: 2026-09-17. Additive continuation of the [original ledger](SOURCE-LEDGER.md) and U03/U04/U05/U06-A/U06-B1/U06-B2 supplements. S00–S70, D01–D37, G01–G09 and E01–E12 remain unchanged. STATE owns current work/completion.

Primary unchanged: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`, manifest context 6.3.0. No new HEAD, host API, installed-version, release or efficacy verdict. The evaluation-lab and Gauntlet pins remain historical dependencies already recorded; neither was reopened.

## Eight new full primary file reads

Paths are relative to [the pinned primary source](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797). FULL means the complete returned body was read, not that every referenced mechanism was tested.

| ID | Path | Git blob | Actual coverage / role |
|---|---|---|---|
| S71 | `skills/brainstorming/visual-companion.md` | `c145e64388d4441710da016ea665fed5699e2e91` | FULL. Optional per-question display, consent/start, dialogue/event loop, fresh filenames, recovery and cleanup guidance. Host claims are target instructions, not current host verification. |
| S72 | `skills/brainstorming/scripts/start-server.sh` | `016a8e4870142ce2adbe81a021d8b6b9073e7618` | FULL. Fresh session directories, shared project port/token, owner-only defaults, foreground/background and owner-PID selection. Source-only, not launched. |
| S73 | `skills/brainstorming/scripts/server.cjs` | `a828b35af64d5c64ca68b9ec78473999ce698874` | FULL in contiguous 1–230, 231–450, 451–EOF. HTTP/WS auth, selected files, branding, event predicate, watcher, fallback identity and lifecycle. No server/protocol/watch/security execution. |
| S74 | `skills/brainstorming/scripts/helper.js` | `e11d26489ce248f37af3e4dd01ddec6a4e88287f` | FULL; exact 5,615-byte local transfer independently rehashed before E13 execution. Actual helper executed with mocked DOM, WebSocket, clock and timers, not a real browser. |
| S75 | `skills/brainstorming/scripts/stop-server.sh` | `7cacfe9440043f7a46eac555cd835fad0769c425` | FULL. Per-start command-line identity, ambiguous PID refusal, signalling/death checks, log removal and lexical /tmp cleanup. Not executed. |
| S76 | `skills/brainstorming/scripts/frame-template.html` | `f540bb8a4f88107e2b37b2871a4c1a55a3b6f720` | FULL. Framing, branding/content placeholders, status, CSS selection and layout. Not rendered or screenshot-tested. |
| S77 | `tests/brainstorm-server/helper.test.js` | `604b611ad4315f82919b45505d776f74922d8d4d` | FULL SOURCE ONLY. Pure/source assertions plus actual-helper mocked browser reconnection tests. Header alone understates the later test body. Not run here. |
| S78 | `tests/brainstorm-server/package.json` | `0cb87f9dabbfd4e9dc754835e9d30e3af74f3088` | FULL. Declares separate protocol/helper/auth/branding/server/lifecycle/start/stop suites and ws dependency. No install or suite invocation. |

S10 brainstorming was directly re-read in full, 1–170 and 171–EOF, at unchanged blob `b56a3b5ed6ea0d6216501e0e401ecb00a1b4675f`. Re-entry clarifies optional visual consent and primary dialogue; it is not another new skill count. All fourteen earlier SKILL-body reads remain preserved.

## Navigation and deliberately open paths

- `skills/brainstorming` complete directory response: main skill, scripts subtree, visual guide and spec-document-reviewer template. The reviewer template was listed, not read in this unit.
- Scripts subtree `b6c29cd4ed66866e7e3f24c1e53bee9393792699`: five files; all bodies read as S72–S76.
- Root tree `21219529a4e224bcb27baf8816b039c8bf7c6673`: complete first JSON copy through `truncated:false`; duplicate wrapper truncated. No complete recursive repository reading claimed.
- Root scripts tree `c99188d12822f70b92226df81136627957bd1024`: `bump-version.sh` (`14ead00291407c584f58a437f3acf5be1e772e78`), `lint-shell.sh` (`190db0140d9e250af4cd8edabb42995c0201803c`), `package-codex-plugin.sh` (`5308e28d9c3460b130abd7e3185374294b33d00f`) and `sync-to-codex-plugin.sh` (`bdaa13a357defed6b43e0a769b0ec06e9099b6d3`) LISTED ONLY. These are U07-B starting paths, not distribution findings.
- Tests root `3b4b2210556b6c3f668aca2c6c34dffb114c7293` listed fully, including Antigravity, Devin, packaging/version and other families. Names do not prove a supported current runtime or passing tests.
- Brainstorm test subtree `3452bb7acc447da3f63a052e61b43db677e31f21` listed fully: twelve entries. Only S77/S78 bodies read. Auth, branding, server, lifecycle, protocol and shell tests remain unexecuted and otherwise unread here.
- Copied vendor guidance, graph conventions/renderer, remaining adapters and installation/update paths remain U07-B. No omission is silently reclassified as full coverage.

## E13/E14 — actual mocked-client execution

- Runner: [evidence/U07A-companion-client-probes.mjs](evidence/U07A-companion-client-probes.mjs).
- Actual output: [evidence/U07A-companion-client-probes-results.json](evidence/U07A-companion-client-probes-results.json).
- Local runner Git blob: `27082457c9e782cfec1e392aa78e02677d54b735`, 10,276 bytes.
- Local output Git blob: `2ceef31098d65cfda54bfa708ab0ed002632f37e`, 5,244 bytes.
- Source S74: 5,615 bytes, blob `e11d26489ce248f37af3e4dd01ddec6a4e88287f`, exactly matched before execution and checked again inside the runner.
- Observed environment: Node v22.16.0, Linux x64, built-in modules only. Minimal fake DOM, in-memory WebSocket, explicit synthetic millisecond clock and manually advanced timers.
- Command: `node evidence/U07A-companion-client-probes.mjs /path/to/pinned/helper.js evidence/U07A-companion-client-probes-results.json`.
- Actual exit: 0. This means the observation checks completed, not that the two stronger criteria passed.

| Cases | Result and evidence boundary |
|---|---|
| C01/C02/C08 | Key/cookie URL construction, normal click payload and capped reconnect sequence behaved as expected. No server handshake/auth or actual timer latency was tested. |
| C03 | Default explicit API emitted value without choice. Study-defined compatibility criterion unmet against S73's inspected persistence predicate. Metadata supplying choice is a positive control. Server was not run. |
| C04 | Multi-select A then A leaves A unselected but still reports A twice and as selectedChoice. Last-click-only inference criterion unmet; not a universal upstream approval promise. |
| C05 | Previously queued event sent before keyed recovery navigation, with original synthetic timestamp and no screen/session fields. Mock reconnection only; no observed false approval. |
| C06 | Brief reconnect did not force a content reload without a reload message. No filesystem watcher or real content loss tested. |
| C07 | New helper instance did not restore old unsent queue; old instance still flushed it. Memory-lifetime observation, not whole-browser storage testing. |
| C09 | Negative control rejected an invented selected-state oracle based only on last click. |

Nine expected mechanism/control observations; zero unexpected observation failures; two explicitly unmet stronger criteria. These are source-informed exploratory tests selected after source reading and before execution, not preregistered or independently replicated product qualification. They do not establish a general success rate, vulnerability exploit, lost real user event or behavioral efficacy.

No real browser, server, HTTP/WS network, shell startup/stop, filesystem watcher, native test suite, model/agent, dependency installation or credentials were used. No upstream modification or issue was filed. E01–E12 were not rerun.

## Acquisition and external retrieval

A single pinned archive acquisition attempt in the container failed at DNS resolution. No archive or clone was obtained. Connected GitHub supplied every load-bearing source; only S74 was manually transferred to the local execution fixture and verified against its canonical blob.

Public web search for the visual companion and Node fs.watch returned an upstream issue and official versioned Node documentation among other results. These were discovery/context only: the issue was not followed or used as a live incident, mirrors were not evidence, and no current Node API or all-platform watcher guarantee was inferred. No supplementary X-series source is needed for these pinned-code findings. The private fixture itself made no external requests.

## Recovery and interpretation

Current AGENT was freshly fetched at unchanged blob `2084cfd7e944f67d7b52805e4bd8d0d1502b4c4a`; all triggered protocols were already fully available as actual canonical same-conversation text. No control file was used as research evidence or changed.

Current STATE/META/PLAN were refreshed. The full original ledger, U05 and U06-A supplements were recovered where not fully visible; overlapping reads repaired original-ledger truncation. Required METHOD, U03/U04/U06-B1/U06-B2 supplements, B2 note and S01 were available as their actual complete source text. STATE's fresh abbreviated/tail request confirmed unchanged blob `6b8a898693595c200376fae9be58cdda3bd3d77d`; its complete canonical body was already available in prior contiguous same-conversation reads. No summary alone replaced a mandatory source.

The new [U07-A note](notes/U07A-visual-companion-lifecycle.md) records F65–F72 and Q41–Q43. Access, conversation consent, interaction, selection, revision binding, persistence and approval are treated as distinct source-grounded mechanisms. The companion is not judged against an invented requirement to replace human dialogue.

U07-A closes the visual source/client slice. U07-B distribution and remaining authoring/adapter supports, U08 native synthesis/projection and whole-study closure remain open. Publication/readback validates transfer and continuity only, not independent correctness. Current publication details and next responsibility belong to STATE.
