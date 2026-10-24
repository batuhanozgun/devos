# U06-B — Source and evidence ledger

**Date:** 2026-09-18. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). FULL means through EOF, not all dependency/platform/host coverage. No new execution; no E06.

| ID | Path | Git blob | Actual coverage |
|---|---|---|---|
| S130 | scripts/hooks/gateguard-fact-force.js | bfd2b11c6fa9ecd1dcc63fe16dedb522f4232599 | FULL: 1–270, 271–540, 541–820, 821–1100, 1101–1380 reaching EOF. Completes prior S128 prefix, not independent corroboration |
| S131 | skills/gateguard/SKILL.md | e7ebc5cec567aef95d369f423fc12c41c665beb9 | FULL: target narrative, operation guidance, controls, two-task reported table; no empirical revalidation |
| S132 | tests/hooks/gateguard-fact-force.test.js | 49592869107b657f47f8903f26a8c270d5881312 | SELECTED 1–540: harness helpers, first/retry, persistence failure, destructive/routine contrasts, expiration and selected controls. TEST SOURCE INSPECTED, NOT RUN; rest unread |
| S133 | scripts/hooks/bash-hook-dispatcher.js | 5a13202dc93258d6225fd4260ee57227d17e63bf | FULL 1–260 reaching EOF: real ordering, normalization and final output precedence |
| S134 | scripts/hooks/pre-bash-dispatcher.js | b9ccad7d6f50ee3065e0c8c108eef350e5794f71 | FULL: registered caller into S133; bounded stdin and output |
| S135 | scripts/hooks/pre-bash-git-push-reminder.js | 52ae376aa5a230bcf9ef4872a5fc83a2af22f271 | FULL: actual additionalContext producer; no command execution |
| S136 | scripts/lib/shell-substitution.js | a2241770d7609fb9906a3296361d0bdbc8a3d511 | FULL 1–300 + 301–620 reaching EOF: executable-body extraction |
| S137 | scripts/hooks/gateguard-heredoc.js | 31e41b29be09277ba0902b02eb1d5f09029c5b85 | FULL: limited passive-sink recognition, substitutions and ambiguity fallback |
| S138 | scripts/lib/powershell-destructive-command.js | 6ec29445319b23324dd2f3dae662b5b2d2a49cf9 | SELECTED 1–300: rule IDs, parser setup and initial helpers; full classifier NOT read |
| S139 | scripts/hooks/block-no-verify.js | 16e0044d7fd7c5707d4c807237b3d83027085bd1 | SELECTED 1–280: preceding checker orientation; full decision body NOT read |
| S140 | scripts/hooks/governance-capture.js | 5f75baeafa4adf1e27a94bafd33f425858e8ee3f | SELECTED 1–110: actual classifier import and next event-capture frontier; no event lifecycle conclusion |
| S129 re-entry | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | SELECTED 1–65 + 66–108: Bash/PowerShell/Edit/Write registrations, neighboring governance capture and early following events; not whole manifest |

Retained full source: S122 run-with-flags `9f6de372212d5c3ba20502b5e05711431f1a0053`; S124 hook-flags `69d3f25d6ba5d49acdebed943352674f87caa5c3`; S125 pretooluse-visible-output `dc48119099f6206e6011174a62ad9912d7af9a25`; S126 plugin-hook-bootstrap `8d573ffedaa0f55de122a704737d3db0aa23f68d`. Their same-conversation full bodies were retained, not newly executed.

## Claim binding

- First-touch marker precedes refusal; no fact-response acceptance in this included run path: S130 run/markChecked/markCheckedAndCountDenial, contrasted with S131 and selected S132 fixtures. No repository-wide absence claim.
- Raw path/command/session scopes, inactivity versus semantic freshness, bounded marker storage, subagent exemptions and persistence trade-off: S130 state and run sections. No live concurrency/platform/actor-authentication test.
- Concrete classifier mechanisms: S130/S136/S137; S138 only supports bounded orientation, not exhaustive PowerShell behavior. No interpreter-equivalence or all-command guarantee.
- Real delivery and zero-exit denial: S129/S134/S133 versus retained S122/S125/S126, qualified by W15.
- Conditional loss of deny under accumulated context: S133 final return plus actual S135 producer and S130 denyResult. Earlier unexamined hooks and host controls are explicit conditions, not presumed absent.
- Test coverage gap: S132 runBashHook calls run-with-flags directly, not S134/S133. Written assertions do not demonstrate passing runtime results or substantive fact investigation.
- Governance next frontier: S140 imports the included classifier, but only prefix read; complete producer/store/consumer/authority chain is next work.

## Current primary interface checks, not a corpus repin

**W15:** [Official Claude Code hooks reference](https://code.claude.com/docs/en/hooks), observed 2026-09-18; selected PreToolUse JSON decision and exit-zero/no-decision semantics, plus documented subagent hook input. A structured deny can accompany exit zero. A missing decision is not affirmative authorization. This is a current documented contract, not an installed historical-host result.

**W16:** [Official hooks guide](https://code.claude.com/docs/en/hooks-guide), observed 2026-09-18; selected combining-multiple-hooks section. Sibling commands run before host result merging; most restrictive returned permission decision wins. This external merge is not S133's internal aggregation and cannot recover omitted data. No real host composition ran.

Search returned unofficial mirrors and unrelated news; neither was used as evidence. GitHub code search used default ref dd6ee538aee0f548d4a6b520118f875431fd749e only to discover paths. All substantive repository bodies above were fetched at the unchanged pin.

## Execution, coverage and continuity

No ECC code, upstream test, probe, model, tool write, real shell command, scanner, user configuration, dependency install or provider ran. Auxiliary raw-source download failed at DNS and produced no checkout; connected source reads remained available. A source-only unit was sufficient for the selected release/state/composition question. Source-derived counter-paths are not observed deployment incidents or proven empirical harm.

P1 remains partial. No full recursive inventory or security-family closure is implied by reading the large gate and two helpers. Other dispatcher imports, PowerShell classifier remainder, larger tests, external scanners and external GateGuard package remain outside this body scope. S140 is an actual next entry, not a completed unit.

Fresh AGENT and STATE were read; main compared identical to the prior continuity commit 3d93615ae51e4e85cd509e49f65b4c2afbad07c0. Required unchanged protocols and full package entry/Note09/source/round/E05 plan/receipt/reconciliation bodies were retained from this conversation. This is same-conversation recovery, not an independent cold-start test. Both E05 historical identities remain separate; no new count or experiment is substituted. Publication checks belong in the unit receipt.
