# U06-C — Source and evidence ledger

**Date:** 2026-09-18. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). FULL is source through EOF, not all dependencies, execution or independent validation. No new experiment/E06.

| ID | Path | Git blob | Actual reading |
|---|---|---|---|
| S141 | scripts/hooks/governance-capture.js | 5f75baeafa4adf1e27a94bafd33f425858e8ee3f | FULL 1–240, 241–510 reaching EOF; completes S140 prefix, not independent evidence |
| S142 | scripts/lib/state-store/queries.js | 0225f476182ab68c77285d1e2f398637b7c20bbc | FULL 1–220, 221–460, 461–730, 731–1030 reaching EOF; re-entry into earlier Work/status source |
| S143 | scripts/status.js | 7f6404a12a278a22cd258f68c2437b0007924185 | FULL 1–240, 241–520, 521–670 reaching EOF; report and optional exit-code path |
| S144 | scripts/lib/state-store/index.js | 49b6204d635330401ede6fd734c72f9588466f78 | FULL; database open/export/persistence and exposed API; sql.js/install-projection dependency internals not audited here |
| S145 | scripts/lib/state-store/schema.js | 915e0481d3ff8d810573ef0f9f6bae8cb3151e76 | FULL; actual validator invocation; no Ajv execution |
| S146 | schemas/state-store.schema.json | 70b0e9dc4727020cdbef190c804b5b3c4f09c015 | SELECTED 1–90 and 220–410 through EOF; common definitions and governance record complete; middle unrelated entities not reread |
| S147 | scripts/lib/state-store/migrations.js | 7716c992589341e4db89a403139a2fd7db040894 | FULL 1–290 reaching EOF; actual table/FK/index and migration transaction |
| S148 | scripts/hooks/posttooluse-dispatcher.js | fcffeb40086bd9327f6360348a0a093290739b0a | FULL 1–270, 271–400 reaching EOF; selection, unchanged raw input, options and output; other imported hooks not audited |
| S149 | tests/hooks/governance-capture.test.js | 7d40ebe78188cb2026301de60dc6e1018cd5ecfd | FULL 1–240, 241–540, 541–830 reaching EOF; TEST SOURCE INSPECTED, NOT RUN |
| S150 | SECURITY.md | c7fdcfd9ca4114a3625c77a44e4ac68233eb1d4c | FULL 1–180 reaching EOF; target's pinned distribution/security scope, not current support certification or instructions adopted by us |
| S151 | tests/lib/state-store.test.js | b632cec7fbac8c9883b83f2dd5e50c0f761c44a9 | SELECTED 1–260 and 280–370; fixture explicitly inserts governance records; remainder not read/run |
| S129 re-entry | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | SELECTED 116–154: registered synchronous/asynchronous PostToolUse dispatcher; earlier pre registration retained. Additional 160–230 request truncated in Stop declarations and is not full coverage |

## Claim/source binding

- Capture header versus actual destination, flag, no refusal, event predicates and source fields: S141; actual post caller/registration S148/S129; retained S122/S124/S126 pre wrappers.
- Explicit store path and missing demonstrated ingestion bridge: S141–S144; S151 is a seeded store test, not a hook-stream importer.
- Database shape versus authenticated resolution, mutable upsert, null timestamp definition, total versus limited listing: S142/S145/S146/S147.
- Status consumer, payload projection and optional machine attention: S143/S142. Installation reconciliation is separate existing functionality, not a governance ingestion bridge.
- Privacy and missing host-field adaptation: S141/S148/S129 plus W17. Distinguish conditional source behavior from measured native-host behavior.
- Test adequacy: S149 verifies helpers and stderr with explicit environment/context; it does not establish capture-to-DB/approval integration. S151 only selected fixture source.
- Wider surface/accountability boundary: S150. AgentShield's separate repository, the-security-guide.md and release/CI surfaces are frontier, not evaluated scanner internals.

Retained source dependencies are re-used, not independent corroboration: S122 run-with-flags, S124 hook-flags, S126 plugin bootstrap, S130 GateGuard, S138 partial PowerShell classifier. No full PowerShell interpreter or all hook coverage is claimed. Earlier source/experiment identities remain unchanged.

## Current external interface check

**W17:** [Official Claude Code hooks reference](https://code.claude.com/docs/en/hooks), observed 2026-09-18. Selected common input, PostToolUse tool_response, PermissionRequest and zero-exit stderr/output sections. It supplies current documented field/channel semantics, not an installed pinned host or proof that no custom environment adapter exists. Repeated opens of this same document are not independent sources. No PDF/image analysis occurred; unofficial search mirrors were not used.

## Discovery versus absence

GitHub searches for governance_events, approval_requested, GovernanceEvent, insertGovernanceEvent, governance and AgentShield used default branch dd6ee538aee0f548d4a6b520118f875431fd749e for discovery only. Some broad results were truncated. An empty listGovernanceEvents search does not prove absence. Every load-bearing body above was recovered at the research pin. Neither a global collector absence nor a new source baseline is asserted.

Additional discovered but unread material includes docs/architecture/agentshield-enterprise-research-roadmap.md, docs/security/ecc-039-powershell-gateguard-plan.md, examples/evaluator-rag-prototype/agentshield-policy-exception/candidate-playbook.md, skills/living-docs-governance/SKILL.md and .claude/enterprise/controls.md. Their names/claims do not fill any runtime gap. Use pinned reads before reuse.

## Execution and canonical recovery

No ECC code, test, model, scanner, database, actual tool operation, installation or credentialed provider was run. No E06 was created; E01–E05 were not rerun or pooled. Auxiliary raw download failed at DNS and produced no checkout. Local publication preparation, if performed, is administrative text/hash work rather than target execution.

Fresh AGENT and all required R01–R09 protocols were read fully; bounded range reads recovered truncated control text. Current R09 includes the separate concepts programme exception. Current ECC STATE/INDEX/META/METHOD/QUESTIONS/MR10 were recovered; full same-conversation WHY/PLAN/Note10/ledger/receipt remained available. Comparison from prior closure 34ebc13e87fc7f42f882472eced2a576bb4d27a1 showed concurrent concepts/router changes, not ECC changes. Later publication preparation starts from fresh main f922b49d92df26578e74a42e37f9b97133854b73; all concurrent material must be preserved.

This is same-assistant canonical recovery and source analysis, not an independent cold-start trial or security verdict. Exact publication/check outcomes belong in PUBLICATION-U06-C once actual. The historic two-E05 reconciliation and user-owned whole-study evaluation boundary remain intact.
