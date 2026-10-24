# U04-A — Source and evidence ledger

**Date:** 2026-09-17. **Target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. No repin. Paths below are relative to [the pinned source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). IDs continue S76. FULL means through EOF, not every dependency/platform/test/consumer.

| ID | Source path | Git blob | Actual scope |
|---|---|---|---|
| S77 | skills/unified-memory/SKILL.md | 2eb70c775d90ed081530f9eeb419cc5ba81be147 | FULL; runtime prerequisite, recall/review guidance and scope boundary; instructions are research objects |
| S78 | scripts/memory.js | 07471906afc6a32a3617823c7013da969029ec1e | FULL; requests 1–260 and 261–560 reached EOF; CLI entry/body/formatters/exit handling |
| S79 | scripts/lib/memory-vault.js | e79cb1a73230bf5a76c078b82cd61a1fd2a98ca0 | FULL; 1–250, 251–520, 521–830 reaching EOF; roots/create/scan/search/read/doctor |
| S80 | scripts/lib/memory-vault-format.js | 006f32e30ea2c05ad1b86fc70473f8723854f406 | FULL; 1–280 and 281–420 reaching EOF; document validation, trust/status, lexical format and secret patterns |
| S81 | scripts/memory-mcp.mjs | 64fe6bebc8b64acfcb3977939f27e95c0fcf6fa1 | FULL; 1–260, 261–540, 541–800 reaching EOF; input schemas, server identity/scope, tool and transport handling |
| S82 | scripts/lib/path-safety.js | 95a64138fb2154cebf1340fcdbe150cd18a13279 | FULL; actual containment dependency; stable paths, not race/confinement proof |
| S83 | schemas/memory.schema.json | 3a7f4696f6e0931a9edfa71c46f893db734d2b0d | FULL; separate normalized document schema; core uses its own S80 normalizer |
| S84 | examples/unified-memory/README.md | bc4cbb1b8d25ca23e68602b0a0dcc779c5176882 | FULL; example intent, non-goals and test boundaries |
| S85 | docs/design/ecc-memory-vault.md | ac90669a5154044ab15136c2bc3aeb9000ca869f | FULL; request 1–280 reached EOF; design/threat/intentional availability and governance limits |
| S86 | examples/unified-memory/evidence.cjs | ba12aaf92777f5b64039cc12faf20cced0084e2e | FULL; example-only exact source/catalog/context matching, not executed |
| S87 | tests/lib/memory-read-completeness.test.js | de03aee1fc2d2f304e45609d276f5d80df15ba72 | FULL TEST SOURCE; request 1–300 reached EOF; invalid/truncated/direct/MCP/error controls; NOT RUN |
| S88 | examples/unified-memory/conformance.cjs | a8fb424fe3617d758e0c46c95e40694ee2690412 | FULL TEST/EXAMPLE SOURCE; 1–260 included EOF; 220–280 recovered complete identity/tail after duplicate metadata truncation. NOT RUN |

## Claim bindings

- File-based lifecycle and non-promotion: S77–S81/S83/S85. No SQLite/worktree dispatch imported in the traced memory path.
- Roots/scopes, create-only and stable containment: S79/S80/S82; operational threat limit S85; Git ignore semantics W08.
- Active search versus historical direct read; untyped links; lexical ranking: S79/S80/S85. Terminal status omission: S78 printRead versus full result.
- Incomplete lookup versus partial search: S79 readMemoryFiles/searchMemories/readMemoryById → S78 printSearch/runCommand and S81 executeMemoryTool/toolFailure. S87 assertions are inspected intent, not passing results.
- Server-stamped source/target and two-stage user opt-in: S81 input schemas, resolveServiceSecurity/assertScopesAuthorized/executeMemoryTool; operator CLI contrast S78 and S88.
- Example integrity versus truth/adoption: S86; S88 separately invokes it after normal storage and retrieval. S84 bounds native-harness/evidence claims.

## External primary contract checks, separate from the pin

**W08:** [Git gitignore manual](https://git-scm.com/docs/gitignore), selected description/notes observed 2026-09-17 through web search: ignore rules do not affect already tracked files. Not an ECC project-memory leak test or an installed-version validation.

**W09:** [MCP tools specification, 2025-11-25](https://github.com/modelcontextprotocol/modelcontextprotocol/blob/main/docs/specification/2025-11-25/server/tools.mdx), selected result/error distinction from primary-source web result. Protocol error and isError tool execution result are different surfaces. Not a full MCP compliance/latest-version audit. Other search results, unofficial mirrors and unrelated recommendations were not research evidence.

## Execution and oracle limits

**No new ECC execution and no E04.** No memory CLI, MCP process, example, upstream test, real model/harness, database, user vault or remote service was run. E01/E02/E03 remain historical and were not rerun. Source-derived terminal-output and supersession counter-paths are not observed production incidents.

S87 uses disposable vaults and direct core/MCP helper calls, plus filesystem-method fault injection; it starts no server. S88 starts actual Node CLI/stdio subprocesses if run, but the harness names are environment-configured identities, not native applications. CLI/MCP parity shares the core and is not an independent retrieval-quality oracle. S86 compares against a separate host-owned synthetic catalog, not truth or currentness. No passing receipt was recovered in this unit.

## Discovery and retained context

The memory-native map now covers procedural guidance → CLI/MCP → vault/format/path functions → document schema, with design and examples/tests in their separate roles. This is not a full recursive repository inventory. ECC2 Markdown graph ingestion, actual host uptake, governed-reference injection, other adapters, broad test coverage and examples/unified-memory/evidence.test.cjs remain unclosed. S81's missing-dependency helper and installed Ajv implementation were not dependency-qualified.

Code search for completeness tests returned default-branch ref dd6ee538aee0f548d4a6b520118f875431fd749e; only path discovery used it. All bodies were fetched at the existing pin. Initial memory leads from U03-B were confirmed there. No latest-main verdict is implied.

The fresh canonical control reads and current STATE/INDEX/META/QUESTIONS/METHOD/MR05 were recovered; same-conversation full WHY/PLAN/Note05/U03-B ledger/publication material was retained. State identity was unchanged from U03-B. Before publication, main a46cb2fc4df1f59110000a91e0a82b673ebe5d8d differed from 317af70c836868c5798c8a6ea63af068b2d48bb2 only by a Superpowers note; no ECC change. This is not an independent cold-start trial.

Auxiliary container raw acquisition failed at DNS. Canonical connector reads succeeded; no checkout was created. The failure does not support a target-system defect. Current results and continuation are routed through INDEX/STATE and this unit ledger; older SOURCE-LEDGER.md remains history through U03-B.
