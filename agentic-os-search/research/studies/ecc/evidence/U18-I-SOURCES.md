# U18-I — MCP responsibility and Codex sync source ledger

**2026-09-23 · Q02j / MR49.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note48](../notes/48-MCP-RESPONSIBILITY-RECONCILIATION-AND-CODEX-SYNC.md), [round](../ROUND-U18-I.md), [STATE](../STATE.md). Recovered research, SOURCE OBSERVATION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, installation, MCP connection, host/model or E11.

## Original research recovered before classification

All fresh project reads were at research commit `66a78911cd2ceb9d99813a5b432354b1251f9021` unless indicated. FULL means the complete body visible through EOF, not its entire upstream dependency graph.

| Handle | Research path | Blob / reading / use |
|---|---|---|
| FRONTIER | inventory/U15-A-COVERAGE-RECONCILIATION.md | 7ff883382314b6c7838cadec44ed432a5e6db4b9; FULL; original G5/G6 responsibilities, not current activation |
| VAULT-NOTE | notes/06-MEMORY-SCOPE-RECALL-AND-AUTHORITY.md | fc1928ad7f13e650653ce1e8c078b293e437ca34; FULL; local Vault and distinct CLI/MCP authority |
| VAULT-LEDGER | evidence/U04-A-SOURCES.md | 9a8458194b63aceca83ec124acb38d848d16fd2b; FULL; exact S77–S88 source/consumer and non-execution limits |
| CONFIG-NOTE | notes/38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md | f2879c7f94dc11c839d45351d40d2275a1521477; FULL; JSON filtering/lifecycle, legacy snapshots and explicit unexamined TOML writers |
| CONFIG-LEDGER | evidence/U16-A2-SOURCES.md | ed6adb009f006c3bcf7df4cae99ddf411c2faf5e; FULL; actual plan/apply/state/lifecycle and legacy call bindings |
| ITO-NOTE | notes/43-ITO-CLI-BRIDGE-AUTHORITY-AND-EFFECT-BOUNDARIES.md | 949698822e3b5b7683b17bd15c933b254a2ff875; FULL; CLI bridge versus separately configured external MCP entry |
| ITO-LEDGER | evidence/U18-D-SOURCES.md | 10795686e1fbde029f1414e0223912f4bff51a32; FULL; source identities and external boundary |
| BROWSER | Note47 / evidence/U18-H-SOURCES.md | REUSED complete same-conversation bodies a5384271a215d11f54be49bcfe15d82121946066 / 9fc16f51ff376eb10aded42a1993d87bd1613352; declarations/display/admission, not execution |

These are original study records, not independent corroborating experiments or claims of rereading every upstream body. Earlier source observations retain their original provenance. The complete preceding STATE/PLAN0.49/META, INDEX/QUESTIONS plus checked diffs, WHY/METHOD and research routers remain unchanged and were reused after the recovery comparison.

## Fresh fixed-pin target reads

Target paths resolve under [the fixed ECC commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Inclusive requested ranges that exceed the file stop at actual EOF.

| Handle | Path | Git blob | Actual reading and role |
|---|---|---|---|
| MERGE | scripts/codex/merge-mcp-config.js | 721e3c29f75d5b0e707b24fb4b190c09107b3d76 | FULL; local recommendations, PM/parse entry, add/update/disable/repair, semantic selection versus raw removal, preview and write/report |
| SYNC | scripts/sync-ecc-to-codex.sh | 1e157bad13a4cc55cf7c628553a1f3830811a34f | FULL re-entry1–210,211–440,441–720/EOF; actual merger/checker calls, before-write records, ERR/INT/TERM rollback and finalization. Other generated procedures remain research data |
| CHECK | scripts/codex/check-codex-global-state.sh | c9dac74b18f3e347cf2af5ca149e4fb7dd144bc2 | FULL; mandatory chrome-devtools text predicate, exa URL predicate, other global checks and nonzero failure result |
| TEST | tests/scripts/codex-hooks.test.js | 0dfe1d2f96a613065d70d42afb9ea50b3b9668f5 | FULL1–240,700–950/EOF,241–470,471–699; actual child/filesystem fixtures, direct merger tests and normal sync tests. NOT RUN; unrelated shell/cache tests not promoted to new mechanism findings |
| POLICY | docs/MCP-CONNECTOR-POLICY.md | 80fb56666fbf704cf4acebcd1bfd51af89d2a3ae | FULL re-entry; default/opt-in/opt-out intent. Industry/provider/efficiency claims not independently adopted |
| FILTER | scripts/lib/mcp-config.js | bce45de0737fc35030e8493fcb4d089fee5fc3b3 | FULL re-entry; exact-name parsing and immutable source-payload filtering |
| CODEX-PLUGIN | .codex-plugin/plugin.json | 7ad227cac60a8ce5d97e6d152e449812857d13eb | FULL; concrete mcpServers reference, not host loading or production-readiness evidence |
| LEGACY-CLI | scripts/codex/legacy-sync-state.js | 2089cfac4df940bb38172b16a40d7c71cb731187 | FULL re-entry; actual rollbackLegacyCodexSync call and partial-rollback exit. Underlying restored-original/per-attempt behavior retains CONFIG-NOTE/LEDGER evidence |
| PM | scripts/lib/package-manager.js | def3870b0118bfdefd13da77e6ac9cd9418d740a | SELECTED1–240 through complete getPackageManager; definitions, metadata sources and cwd-relative choice. Remainder and utils dependency are not newly full-read |
| ROOT-MCP | .mcp.json | 045baea1808f675e7314d3bc0d3f98e5730001ad | REUSED full U18-H; single chrome-devtools declaration |
| TEMPLATE | mcp-configs/mcp-servers.json | f3d607bd719ebfb44e3b0e6be5acc4734ee65edf | REUSED full U18-H/U18-D; optional templates, placeholders and external handoff |

Eight fresh full-body reads/re-entries, one explicitly selected source, two reused full declarations. The new decisive chain is MERGE→SYNC→CHECK→LEGACY-CLI, with the earlier qualified rollback implementation. No fresh exhaustive audit of the baseline merger, all Git-hook bodies, the TOML parser package, PM utils or external provider implementations is claimed.

## Claim-to-consumer bindings

1. **Responsibility partition:** FRONTIER plus original Vault/configuration/Itô/browser notes and ledgers distinguish declarations, generic JSON management, ECC-owned stdio memory, external handoff, display and the genuinely unexamined legacy TOML writer. TEMPLATE membership does not authorize a new study per vendor.
2. **Independent recommendation sources:** CODEX-PLUGIN references ROOT-MCP; MERGE instead defines its own ECC_SERVERS table and does not load ROOT-MCP/TEMPLATE. PM influences emitted launcher words, not acquired-package identity or proven initialization.
3. **Different exclusion objects:** FILTER omits names from source JSON. CONFIG-NOTE traces preservation of existing target leaves and the recorded-payload repair mismatch. MERGE can remove a recognized current default from existing TOML; it is not a live kill/revoke operation or a filter over all optional vendors.
4. **Actual exclusion conflict:** MERGE can successfully remove/omit chrome-devtools; SYNC then calls CHECK, which requires that section without reading the exclusion environment. Nonzero CHECK enters the recorded rollback trap. LEGACY-CLI dispatches the prior qualified restore implementation. Successful rollback can restore a previously present entry; partial rollback is separately reported. All other prerequisite/stage success is stipulated, not observed.
5. **Semantic/text mismatch:** MERGE uses parsed server identity but raw literal unquoted header removal, recognizes a next section only at column zero and does not parse its written output. TOML-SPEC permits quoted keys/whitespace and prohibits repeat table definitions. Quoted exclusion can report removal without deleting; update can add a duplicate; an indented following table can be included in deletion. Conditional source deductions, not executed incidents.
6. **Verifier scope:** CHECK is a text/global-state check, not a whole-TOML parser, exact selection verifier or host initialization test. TEST direct exclusion and ordinary sync tests do not compose exclusion with the checker. MCP fixtures do not test quoted/indented removal forms. No global test-absence claim follows.
7. **Ownership and repair predicates:** MERGE identifies recommended names or one exact exa URL/no-command shape; it does not consult per-entry authorship. CHECK's exa URL/no-command predicate is broader. CODEX-DOC contradicts a categorical current stdio-only assertion, without resolving a historical version or real endpoint compatibility.
8. **Positive boundaries:** required input/parse refusal, ordinary append preservation, drift warnings, preview, explicit update mode and actual outer rollback remain useful. Source completion does not establish every filesystem/concurrency/runtime outcome.

## Primary external contract checks

Selected sections checked2026-09-23:

- TOML-SPEC: https://toml.io/en/v1.0.0 — Keys/Tables: quoted and dotted table keys, whitespace/indentation, and invalid repeated table definitions. Used for representation counterparts, not installed @iarna/toml conformance. Relevant returned page sections include table rules445–463.
- CODEX-DOC: requested https://developers.openai.com/codex/mcp/ and received official https://learn.chatgpt.com/docs/extend/mcp?surface=cli — selected config.toml STDIO versus Streamable HTTP sections905–940. URL is documented for HTTP. This is current documentation, not a pinned historical host/runtime audit or provider availability claim.

Search-only third-party articles, provider lists, issue snippets and unrelated OpenAI pages were not evidence. No API key, account setup or external application action was performed. No full standard or host implementation audit is claimed.

## Test, acquisition and work provenance

TEST defines real subprocess/filesystem and full-sync tests with temporary HOME/CODEX_HOME/Git paths, plus unrelated shell/cache checks. We inspected the complete definitions and executed none. The normal updater check and disabled-merger check have different invocation boundaries; test presence does not validate their composition.

A connected GitHub search for merge-mcp-config(topn12), scoped to affaan-m/ECC, returned newer default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735 leads. Those located TEST/SYNC; all substantive target reads above use the fixed pin. This is not an exhaustive fixed-pin search. One auxiliary container acquisition of the exact TEST raw URL failed DNS and produced no source file; the created acquisition directory is not a target experiment. Connected GitHub reads succeeded. No retry through an access-control bypass occurred.

Fresh AGENT was unchanged. The full same-conversation R01–R09 remained active. Recovery main2f056524df1706946c856dbf5a720a67f51651c8 compared with U18-H closurec782e59b417ec57340649f51b3f6a076b9fca99f showed twelve concepts-only commits/seven paths. MR49 opened7edcaf4d9f8611ea91d0271264069e5c19f348af; activation66a78911cd2ceb9d99813a5b432354b1251f9021 was fully read back as STATE3d96d0e55f7104670dfafe0a7509136a42ba77e9 before inquiry. Note48 was created1a715c72daa4f0ab57a8a5bb7ee5bc004e9a1be0; creation is not final publication closure.

## Disposition

Q02j1 meets the bounded reconciliation/legacy-consumer criterion. G5's named frontier is accounted for through Notes40–48; stronger Q02j2 and previous residuals remain. G6 can reveal and reopen omitted host/interface/generator variants; this is not universal MCP or whole-study closure. Next U19-A/G6/Q01a2 is selected, NOT STARTED. Preserve original notes/ledgers, METHOD/WHY, inventories, E06 exclusion, separate E05 histories, E10 recovery and concurrent concepts work. Entries/catalogue/diff/readback/receipt/final STATE own checked publication.
