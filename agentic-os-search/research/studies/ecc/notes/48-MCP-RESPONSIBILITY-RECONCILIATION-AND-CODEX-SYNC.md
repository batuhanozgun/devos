# Note48 — MCP responsibility reconciliation and Codex sync consumers

**2026-09-23 · U18-I / G5 / Q02j / MR49 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources](../evidence/U18-I-SOURCES.md), [round](../ROUND-U18-I.md), [STATE](../STATE.md). Recovered original research, new source observations, inspected test definitions and conditional deductions. No target execution, installation, MCP connection or E11.

## 1. Reconcile responsibilities, not vendor names

The original [U15-A frontier](../inventory/U15-A-COVERAGE-RECONCILIATION.md) left MCP interfaces in G5. Reading that frontier together with the original Vault, shared-configuration, Itô and browser notes/ledgers identifies different responsibilities. A template containing many services is not an implemented ECC runtime for every service and does not require one new product study per entry.

| Responsibility | Actual source/evidence binding | Disposition and retained limit |
|---|---|---|
| Default versus optional declarations | ROOT-MCP declares chrome-devtools; POLICY names one default; TEMPLATE contains optional entries and copy/placeholder guidance | Source selection surfaces, not established installed or connected services. POLICY's broad industry/provider rationales remain authored claims |
| Native plugin reference | CODEX-PLUGIN points mcpServers to ./.mcp.json | A concrete distribution reference, not a call to the legacy TOML merger or proof of host loading. Other host/generator variants remain G6 |
| General JSON materialization and maintenance | [Note38](38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md) / U16-A2: source→Cursor operation→plan payload→apply filter→record→doctor/repair/removal; FILTER re-read here | Already explained. Exclusion filters the source contribution; stored-payload/repair and subtraction/restore limits remain. Not live revocation |
| ECC-owned memory MCP runtime | [Note06](06-MEMORY-SCOPE-RECALL-AND-AUTHORITY.md) / S77–S88: stdio server→server identity/scope→Vault/format/path functions→search/read/save/doctor | Already explained at original scope. Create-only unreviewed context and recipient filtering, not accepted knowledge or resumed work. Native-host uptake and stronger integrity remain open |
| Direct external MCP handoff | TEMPLATE's command/args or URL; [Note43](43-ITO-CLI-BRIDGE-AUTHORITY-AND-EFFECT-BOUNDARIES.md) / U18-D distinguishes ito-mcp.js from ECC's ito.js bridge | Host/provider boundary. CLI bridge restrictions cannot be transferred to a separately configured MCP entry; no provider's real tool set, credentials or effects are certified |
| Display of those declarations | [Note47](47-BROWSER-DASHBOARD-EXPOSURE-AND-CONSUMER-BOUNDARIES.md) / U18-H: files→projection→HTTP/client | Already explained. Display, masking, request admission and copying are not materialization or execution |
| Legacy Codex TOML generation and acceptance | Note38 identified actual writer calls but explicitly left their transformation bodies unexamined. MERGE→SYNC→CHECK is recovered below | Genuine ECC-side gap, now answered through actual generation, selection, file mutation and downstream check/rollback paths |

This accounting preserves distinct existing evidence classes rather than counting summaries as new corroboration. Notes40–47 retain their already published G5 scorecard/interface/explorer answers. The new work is the last row and its relationship to the others, not a rerun of those studies.

## 2. The legacy Codex route has its own recommendation source

MERGE is not a generic converter of TEMPLATE or ROOT-MCP. It contains its own ECC_SERVERS table, currently with chrome-devtools, and emits Codex TOML command/args plus a 30-second startup setting. Native plugin reference, generic JSON merge and legacy TOML generation are separate delivery mechanisms even where they recommend the same server name.

MERGE obtains a package-manager selection from PM, defaults to npx if that helper cannot be loaded, and specially probes Yarn's version to avoid yarn dlx on Yarn 1. PM's inspected selection path prioritizes environment and project/global metadata; its default project is the process working directory, not necessarily the destination config directory. The selected launcher is configuration text, not proof that its package is installed or can initialize. The @latest package reference is not a pinned acquired artifact.

The input must exist and parse through @iarna/toml. Default behavior preserves a recognized existing server and warns about differences in recommended fields; missing defaults are appended without reserializing the original file. A local --dry-run returns before the file-writing branch. These are useful controls. Preview still loads dependencies and can perform the Yarn version probe; no universal effect-free-preview claim is warranted.

Three exceptions qualify the add-only label. Excluding a current default removes a recognized existing entry; --update-mcp replaces a same-name default entry; and an exact exa URL-only pattern is removed as a legacy repair even without --update-mcp. The local classification uses names/fields, not a per-entry ownership receipt. TEST's update-preview fixture deliberately uses a custom chrome-devtools command and expects its replacement to be proposed. A name in ECC_SERVERS is therefore not proof that ECC authored the existing contents.

FILTER simply parses case-sensitive, trimmed, comma-separated names. MERGE acts on those names while iterating its own current defaults, not every vendor in TEMPLATE. Its exclusion is a configuration edit, not a command to terminate a live server.

## 3. Counterpart A — the producer honors exclusion, the real verifier rejects it

SYNC is the actual shell caller. It resolves CODEX_HOME/config.toml, creates backups, begins the already studied legacy ownership transaction and records config/AGENTS before writes. It calls MERGE with --dry-run and --update-mcp propagated as applicable. In apply mode it subsequently installs Git hooks, invokes CHECK, and only after success finalizes the legacy record. ERR/INT/TERM handlers invoke LEGACY-CLI rollback. Note38 owns the original snapshot/restoration implementation and its partial-recovery limits.

CHECK, however, unconditionally requires the text section [mcp_servers.chrome-devtools]. It does not read ECC_DISABLED_MCPS. Consequently the following conditional source chain is supported:

1. Run the ordinary sync apply path with chrome-devtools excluded, an ordinarily spelled existing section, and the other prerequisites/stages succeeding.
2. MERGE removes that section, reports its removal and returns normally.
3. CHECK treats the absent section as a failure and exits nonzero.
4. SYNC's ERR trap invokes recorded rollback instead of finalization. If rollback succeeds, the preceding config is restored, including a previously present chrome-devtools entry. If rollback is partial, the wrapper reports that separately.

If the entry was absent initially, exclusion still prevents addition and CHECK still rejects the result; restoration need not reintroduce a previously absent entry. Directly invoking MERGE also differs: it does not call CHECK or create SYNC's backup/rollback campaign.

This is not evidence of a live MCP restart, credential exposure or an observed user incident. It is a source-level disagreement between an authorized selection policy, its writer and the actual postcondition verifier. The verifier is not merely missing a test; its required state conflicts with the producer's supported option. Existing Note38's JSON repair mismatch and this legacy sync rejection are related but different mechanisms.

TEST checks disabled-server removal by invoking MERGE directly. Its complete sync tests do not supply that exclusion. Therefore the local removal assertion and ordinary full-sync assertions can both be satisfied without exercising this composition. No test was run here.

## 4. Counterpart B — parsed identity and textual removal do not cover the same TOML forms

MERGE decides which server exists from parsed TOML, but removes it by matching literal unquoted section-header lines. removeSectionFromText accepts the generated spelling and trailing comments/whitespace, removes CR, and stops skipping at a line beginning directly with '['. It does not normalize quoted keys, spaces inside the header or leading indentation. No post-write TOML parse validates its output.

TOML permits quoted table keys and header whitespace. Stipulate a normal accepted input whose header is [mcp_servers."chrome-devtools"]. It denotes the same server as the unquoted spelling. The parser can identify it, while the remover searches for [mcp_servers.chrome-devtools] and does not match the original line.

- With exclusion, the code records a planned removal and reports Removed 1 even though the quoted section remains.
- With --update-mcp, it can retain the original quoted section and append a new unquoted definition for the same table. Repeated table definitions are invalid TOML.
- A separate whitespace counterpart occurs when removing an ordinary header followed by an indented unrelated table: the stop-skipping predicate need not recognize that next table, allowing its lines to be removed too.

These are conditional code/specification deductions, not executed parser or file-mutation results. They do not depend on malicious contents. TEST's MCP fixtures use ordinary unquoted, unindented headers and do not cover these representations. CHECK uses text patterns rather than reparsing the whole output, so its presence must not be promoted into full TOML validity or semantic-preservation assurance. Its other checks can still fail; no universal successful-sync claim is made for the duplicate case.

The causal distinction is concrete: semantic selection is followed by a narrower textual mutation, and completion messages count selected operations rather than verified removed objects. Preserving original formatting by appending is a legitimate aim; it does not make the removal recognizer equivalent to the parser.

## 5. Repair rationale is not an independent host contract

MERGE and CHECK describe URL-only Codex MCP entries as invalid. MERGE's automatic exa repair recognizes an exact URL plus absence of a string command; it does not inspect installed Codex version, actual transport acceptance or provenance. CHECK flags an ordinarily spelled exa block with any URL and no command, a broader predicate than the repair's exact URL match. A differently addressed user HTTP exa entry can thus be retained by MERGE but rejected by CHECK.

The official Codex documentation checked on 2026-09-23 explicitly supports Streamable HTTP servers using a url field. Therefore the code comment's categorical stdio-only claim cannot be adopted as a general current host fact. This documentation is not a historical-version audit, proof that a particular endpoint is compatible, or evidence of an actual installed failure. The study does not diagnose the historical issue cited by the code or certify an Exa service. The independently supported observation is the local field-pattern mutation and its narrower/different consumer predicate.

## 6. Controls, tests and evidence boundaries

Useful behavior remains: dependency/input parse refusal, predictable default selection, ordinary add-only preservation, drift warnings, local write preview, explicit replacement mode, outer snapshots and rollback, and a real post-sync check. TEST uses actual child-process/file fixtures and parses selected outputs, not only regex markers. Its full body also tests unrelated shell/cache/baseline behavior; reading it does not make those mechanisms newly researched here.

No target script, import, test, package manager, MCP server, host, browser or model was run. No user files, credentials or Git configuration were accessed or changed. The exact installed @iarna/toml implementation, PM utility dependencies, package-manager availability and host/provider acceptance remain unvalidated. The PM file was selected-read through its complete selection function, not falsely marked full. Original Vault/configuration/Itô/browser findings retain their prior source and execution limits.

## 7. Bounded G5 disposition and next work

Q02j1 now reconciles the named MCP responsibilities and closes the consequential legacy TOML writer/checker gap at source scope. G5's selected frontier is accounted for by Notes40–48: no new provider-by-provider campaign is needed for this explanation. This is bounded frontier closure, not proof that every MCP-related file, host variant, indirect consumer or transitive dependency has been audited.

Q02j2 preserves installed parser/launcher/host correspondence, all legal TOML forms, authenticated ownership/selection, immutable preview/application identity, concurrency/crash/rollback behavior, live revocation and accepted useful outcomes. Q03c3 and prior interface residuals remain. Newly discovered material variants may reopen their original questions.

**Next selected: U19-A / G6 / Q01a2 — reverse-inventory and omission challenge, NOT STARTED.** Begin with the complete original U07 family map, TREE-FRONTIER and U15-A reconciliation, current INDEX/Note33 and Notes34–48. Compare the explained roles back against fixed-pin source structure and selected unaccounted guides/host generators/rules/contexts/translations/examples/scaffolds/deployment assets. Specifically retain source obligations for materially different native/adapter paths and the legacy non-MCP baseline/generator/host-validation paths; this unit did not certify them. Return an explicit disposition of consequential omissions and a justified next source or CORE-preparation decision. Do not turn G5 closure into automatic whole-study, architecture or implementation closure.
