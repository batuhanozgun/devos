# U08-A — Plan Canvas source and evidence ledger

**Date:** 2026-09-18. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Source-only completion of the interrupted unit; **historical E06 outcomes are excluded**. No new experiment or target execution occurred in this continuation.

FULL means the named body through EOF, not all dependencies, an executed test or a native host observation. S173–S184 give the previously unnumbered U08-A source trail its first durable ledger identities; they do not claim twelve newly discovered sources or independent repetitions. The original reading trail and artifact failure remain in [the recovery record](../RECOVERY-U08-A-20260918.md).

## Exact source accounting

All paths below resolve under the pinned root.

| ID | Path | Git blob | Actual reading in this conversation |
|---|---|---|---|
| S173 | scripts/lib/plan-canvas/sessions.js | 799cf4b364860ce3400abada964b6d6e5f8b6c49 | FULL in interrupted turn and fully re-fetched in this continuation; normalization, path identity, persistence, drain, end/reopen |
| S174 | scripts/lib/plan-canvas/server.js | 11b44062a3c11d03bc5756a91aa7f7999e8e9e2f | Retained FULL contiguous source from interrupted turn: creation/routes, await/wake/send ordering, presence, serving, shutdown. Not a newly executed server |
| S175 | skills/plan-canvas/SKILL.md | 7c87e18752df8d6788353fbf51d8bc793b9eda6f | Retained FULL; procedure and target claims, not this assistant's instructions |
| S176 | scripts/hooks/plan-canvas-pending.js | 9ba2a92072a9fb8031eb581c50ba64b70ebe7c6e | FULL previously and fully re-fetched now; Stop selection, server/file drain, formatting, skip/error paths |
| S177 | scripts/hooks/plan-canvas-sessions.js | 4e0799f870b6924ec69c10bfd82cf3298b4e84bc | Retained FULL; SessionStart open-session projection, first-five limit, no cwd filter |
| S178 | scripts/lib/plan-canvas/ui.js | df1f0562603784af83f59f875b2ea282fa20b381 | Retained SELECTED source: canvasClientJs queue/message/send/end/presence and renderCanvasHtml iframe/bootstrap. Initial long response was truncated; CSS, all templates and full EOF coverage are NOT claimed |
| S179 | docs/design/plan-canvas.md | 3de3fc7333912082f47e1eb1a68ebfe6e33cda4e | Retained FULL text; target design/losslessness/compatibility claims. Embedded image not analyzed |
| S180 | tests/lib/plan-canvas-sessions.test.js | ea712a2fa6d2c9d1ed0bf88af623671346ca8f43 | Retained FULL TEST SOURCE INSPECTED; NOT RUN. Store reload, drain-once, normalization, end/reopen and corrupt-file assertions |
| S181 | scripts/lib/loopback-guard.js | c56366ea35131d8afd3ab5362ec1c6eb5d7f5ec0 | Retained FULL; Host/Origin hostname predicates, absent-origin acceptance; not person authentication |
| S182 | commands/plan.md | 7397529577199ad2666b65f21ddb9bfbc27b24af | Retained FULL target procedure; artifact production and waiting for confirmation |
| S183 | commands/plan-canvas.md | 8fd4c63c0e294bba61e763fa6bfea1c16e6a4ca5 | Retained FULL target procedure; approve-to-implementation interpretation |
| S184 | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | Retained SELECTED SessionStart and Stop registrations, including their inline wrappers. Not whole manifest coverage |
| S163 re-entry | scripts/plan-canvas.js | 816a0be7b2cc4215e2030bb74fde6489ed5172e1 | FULL newly re-fetched 1–210 and 211–520 through EOF; CLI status/open/await/pending/end, server process and JSON output |
| S122 re-entry | scripts/hooks/run-with-flags.js | 9f6de372212d5c3ba20502b5e05711431f1a0053 | FULL newly re-fetched 1–200 and 201–400 through EOF; awaits async run, preserves stdout result, flushes before exit, profile/dry-run/failure distinctions |

## Claim bindings

- Normal artifact-to-feedback route: S182/S183/S175 → S163 → S173/S174 → S178 → S173/S174 → S163. Approval's action meaning is supplied by the procedure, not an execution command hidden inside the feedback store.
- Path versus revision and actor identity: S173 normalization/key, S174 current-file serving/API and S178 send/iframe producer; S181 bounds Host/Origin checks. No general hostile-browser exploit or all-host approval failure is asserted.
- Queue persistence versus acknowledged consumption: S173 takeFeedback/persist precedes S174 response emission; S163 consumes final JSON without an acknowledgment API. S180 inspects store-reload/drain behavior, not the response-loss window.
- Ended-but-pending discovery: S173 queue/end/take → S163 cmdPending, S176 pendingSessions and S177 openSessions. Direct await can still retrieve the final batch: exclusion from these summaries is not total deletion.
- Stop projection: S176 drains all items, then formats at most 20 descriptions per artifact. S173's browser transcript persists textual mirrors, not every original structured field. This is a source-derived conditional counterexample, not an E06 result.
- Stop activation/output: S184 registration → S122 async run/stdout result → S176 decision/reason. The code can produce an effective hook signal under the host contract, but this unit does not demonstrate actual host activation.
- Presence and operational recovery: S174 presenceFor/markThinking/expiry, S178 status interpretation, S163 health/restart/no-server and S176 metadata-selected fallback. Store/global/path identities are not verified task ownership or per-message acknowledgment.

## Separate primary contract checks

**W-U08A-HTTP:** [Node.js v22.18.0 HTTP reference](https://nodejs.org/download/release/v22.18.0/docs/api/http.html#event-finish_2), selected ServerResponse finish description, observed 2026-09-18. Handing a response to the operating system does not establish client receipt. This supports the transport/consumer distinction; it is not an ECC server execution or an installed-version claim.

**W-U08A-STOP:** [Official Claude Code hooks reference](https://code.claude.com/docs/en/hooks#stop), selected Stop event/input/decision and SessionStart context descriptions, observed 2026-09-18. A Stop block with reason can require continuation; stop_hook_active guards repeated continuation; user interruption/API-error paths differ. This moving manual is separate from the fixed ECC pin. No claim of full manual reading, historical-host conformance or a real resumed agent. Search mirrors and unrelated hits were not used as evidence.

## Evidence exclusions and operational continuity

E06's two objects, invalidity/unverified standing and forensic checks remain unchanged under `evidence/u08-a-recovery/`. No raw outcomes were reconstructed, no old pass count is used, and no replacement experiment was given the E06 identity. No new target code, test, browser, server, model, database, installer, provider or user configuration was run or changed. Administrative text/hash/diff checks are publication work, not ECC behavior evidence.

Fresh AGENT and the nine protocol identities match the fully read same-conversation controls. Current STATE/INDEX/PLAN/ROUND-U08-A were recovered; complete unchanged META/WHY/METHOD/QUESTIONS, recovery diagnosis/checks/receipt and U07-A map/ledger/receipt remain available from this conversation. Comparison from recovery publication `502bc3cf4b15b901ec3b096f59397de231521e98` showed only concurrent concepts work, not ECC changes. Publication input main was `1f3307ddc99bfde41aa234ac72d5a4a1c35d0596`.

One auxiliary raw-file retrieval failed at DNS; connected reads worked. No binary recovery was attempted in this continuation. Notes and ledgers are published as readable UTF-8 text. Actual write/readback/scope results belong in the new U08-A publication receipt, not in an inferred success claim here.

## Remaining scope

No complete SDK/Markdown/UI security audit, browser/transport-failure test, parallel-process ownership test, native-host hook integration, independent human approval or model efficacy study. No repository-wide absence claim. U08-A can close its source question while these stronger claims remain open. The next research family remains Rust/operator control from the U07-A map, after this source publication closes.
