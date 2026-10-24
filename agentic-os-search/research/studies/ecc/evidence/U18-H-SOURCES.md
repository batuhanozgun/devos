# U18-H — Browser dashboard source ledger

**2026-09-23 · Q08d2 / MR48.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note47](../notes/47-BROWSER-DASHBOARD-EXPOSURE-AND-CONSUMER-BOUNDARIES.md), [round](../ROUND-U18-H.md), [STATE](../STATE.md). SOURCE OBSERVATION, TARGET CLAIM/INSTRUCTION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, E11, server/browser/model launch or user-configuration mutation.

## Exact corpus and reading

Target paths are at [the fixed commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Ranges are inclusive requests; a final oversized range ends at actual EOF. FULL describes the body, not every imported dependency, installed package or runtime.

| Handle | Path | Git blob | Actual reading / responsibility |
|---|---|---|---|
| WEB | scripts/dashboard-web.js | 5524853bd73fb1881ab47e0cdb217d6a027ed09b | FULL completed: prior unchanged1–140 reused; fresh141–270 clipped, recovered175–260; then261–350,351–445,446–530,531–615,616–700,701–815,816–1040/EOF. All loaders, styles/languages, client/rendering, request handlers and exports |
| GUARD | scripts/lib/loopback-guard.js | c56366ea35131d8afd3ab5362ec1c6eb5d7f5ec0 | FULL. Host parsing/port handling and hostname-only Origin predicate |
| TOOLS | scripts/lib/agent-tools.js | 8b810c8855676da906c9be2e0c07bdf677dba584 | FULL. Quoted/nested tool-list normalization |
| HOOKCFG | scripts/lib/hooks-config.js | 11515c4bc431e7e7d7db11752a1860ba4f7dff62 | FULL. Sidecar correspondence, fingerprints, metadata merging and actual reader |
| TEST | tests/scripts/dashboard-web.test.js | d9a125dbe6c40f650cc39a5de2746ad7377508c9 | FULL1–230,231–480,481–750,751–1010,1011–1290/EOF. Filesystem, string and HTTP test definitions; NOT RUN |
| DISPATCH | scripts/hooks/posttooluse-dispatcher.js | fcffeb40086bd9327f6360348a0a093290739b0a | FULL1–240,241–430/EOF. Child registries versus actual enablement/matching/run paths; not a fresh full audit of every imported child |
| ROOT-MCP | .mcp.json | 045baea1808f675e7314d3bc0d3f98e5730001ad | FULL. Root Chrome DevTools declaration |
| MCP-TEMPLATE | mcp-configs/mcp-servers.json | f3d607bd719ebfb44e3b0e6be5acc4734ee65edf | FULL1–230/EOF. Selection templates, placeholders, descriptions/headers and usage/disable notes; external claims not independently adopted |
| PACKAGE | package.json | 87487a914c0fd739ea62107e7bf9e56b127207a5 | REUSED full U18-F1–180/181–470/471–650/EOF. Browser script and package declarations, not installed tarball proof |

Eight complete target bodies are available for this unit: seven freshly full bodies plus WEB's completed full read incorporating the earlier prefix. PACKAGE is additional reused context. The fixed-pin mcp-configs directory metadata listed only mcp-servers.json; this is that directory's inventory, not an exhaustive repository or MCP-host audit.

## Claim-to-consumer bindings

1. **Role and entry:** WEB root derives from __dirname. Its handler has /api/data and the HTML fallback, not installation or agent-execution routes. Client actions navigate/filter/copy names; normal main separately attempts browser opening. PACKAGE distinguishes this entry from the desktop.
2. **Source versus capability:** WEB finite loaders and field projections expose declarations. ROOT-MCP and MCP-TEMPLATE are distinct source locations; template opt-in/setup descriptions, headers and comments are not part of the displayed projection. No actual server connection, host selection or provider functionality follows.
3. **Admission:** WEB resolver/listen enforce loopback; GUARD rejects foreign/missing Host and foreign present Origin before routing. GUARD compares hostnames, not exact scheme/host/port origin or user identity. HTML-ORIGIN prevents turning server admission into proof of browser cross-origin readability; WEB emits no Access-Control-Allow-Origin.
4. **Missingness and failure:** HOOKCFG validates correspondence and throws on a sidecar mismatch; WEB.loadHooks catches and returns []. MCP errors similarly become omitted entries. The HTTP200/no-configs counterpart follows the actual outer loader/client, while diagnostics remain on stderr. TEST's injected whole-loader500 and expected empty malformed-config results have distinct scopes.
5. **Masking:** WEB masks env values before both response formats, but not command/URL/args. A secret in another field is a conditional exposure case, not a real credential observed in the public placeholder template. Headers are omitted, not leaked by this projection.
6. **Two-stage encoding:** WEB renderHTML escapes '<' in JSON embedded in the initial script. Its client renderPage(mcps) later puts unescaped args.join into app.innerHTML. HTML-DOM establishes the markup parser contract. The harmless '<b>sample</b>' argument is a source countercase, not an executed exploit. TEST inspects only initial serialization strings and does not exercise this DOM consumer.
7. **Registry versus execution:** WEB expands exported DISPATCH arrays at the canonical root without runtime enablement/profile filtering. DISPATCH's actual main/runHooks checks dispatcher state, matcher, hook enablement and dry-run. No actual hook child was run or freshly fully audited merely because it is imported.
8. **Freshness and fidelity:** WEB reads on requests but sends constant embedded client arrays without live polling. no-store is not live refresh. Bodies are truncated1200/1000/600 characters; detail clicks do not fetch the rest. Counts and metadata search do not prove installed/full-source coverage.
9. **Action/result:** WEB copy issues a clipboard promise or legacy copy call, then reports Copied without observing successful completion. CLIPBOARD distinguishes rejected permission from fulfilled writing. No copy, paste or command execution occurred.

The countercases are conditional source deductions. No observed attack, credential exposure, browser failure rate, model result, source mutation or system-wide security certification is claimed. Q08d4 retains stronger installed/browser/DOM/permission/cross-origin/privacy/concurrency/outcome obligations. Q08d3 preserves the desktop's independent stronger obligations.

## Narrow primary external contracts

Selected sections checked2026-09-23, not full standards audits:

- HTML-DOM: https://html.spec.whatwg.org/multipage/dynamic-markup-insertion.html#dom-element-innerhtml — innerHTML setter/fragment parsing. Supports the second parsing boundary, not a measured exploit.
- HTML-ORIGIN: https://html.spec.whatwg.org/multipage/browsers.html#origin — tuple-origin scheme/host/port and same-origin comparison. Separates server hostname acceptance from browser policy.
- CLIPBOARD: https://www.w3.org/TR/clipboard-apis/#dom-clipboard-writetext — writeText promise, permission rejection and resolution after writing. Interface contract, not a successful installed-browser write.

Irrelevant search hits were not used; direct primary pages supplied the narrow contracts. No browser/runtime or external MCP service was evaluated. Sources with a shared downstream origin are not independent corroborating experiments.

## Discovery, work and acquisition provenance

GitHub search createDashboardServer(topn5), scoped to affaan-m/ECC, returned default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735 leads. It located TEST; all substantive target reads used the fixed research pin. Existing G5 and prior source notes supply the remaining-MCP frontier, not a new external-product taxonomy.

Recovery main4504044886afe50e43573313f99a4648cb78d594 was compared with prior closure1b25af6845fb70717ed93b4e4e9f54338eab8329: eight commits affected only five concepts paths. Fresh AGENT and full R04–R09, including clipped tails, were recovered; full same-conversation R01–R03 remained active. Research/studies routers, WHY and METHOD were freshly fully read. The unchanged preceding package context was reused, not falsely described as newly reread history.

MR48 opening1bd135062602d0546b1c26ad47bf8dd9566cf8e0 preceded activationc6776eb120f206ce62c0dcca4bee2dbe9b5ac098, fully read back as STATE8d575f645802df00e340943d3ecd55593d850c92 before inquiry. Note47 was createdd87bd7f0fd7d625ef76cac44ee1fa946bec30d5d; creation is not publication closure.

Auxiliary working-container retrieval of the exact research catalogue failed DNS and produced no source file. Two download-helper attempts were refused because the URL was not marked viewed for that helper, including one after a connected GitHub raw fetch. They produced no downloaded source; connected GitHub remained available. These are publication-source acquisition limits, not target behavior, research experiments or a reason to bypass an access safeguard. No target artifact, user data or credentials were downloaded.

Original Notes01–46/evidence, METHOD/WHY, inventories, E06 exclusion, E05 histories and E10 recovery remain preserved. Next U18-I/Q02j is selected source-responsibility reconciliation, NOT STARTED; it must reuse original evidence before declaring a gap or studying an external provider. Entries/catalogue/diff/readback/receipt/final STATE checks own publication closure.
