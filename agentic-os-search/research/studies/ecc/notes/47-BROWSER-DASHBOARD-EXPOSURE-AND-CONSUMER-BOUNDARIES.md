# Note47 — Browser dashboard exposure and consumer boundaries

**2026-09-23 · U18-H / G5 / Q08d2 / MR48 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-H-SOURCES.md), [round](../ROUND-U18-H.md), [STATE](../STATE.md). Source observations, inspected test definitions and conditional deductions; no target execution, server/browser/model launch or E11. [Note46](46-DESKTOP-DASHBOARD-DISCOVERY-AND-ACTION-BOUNDARIES.md) owns the separate desktop result.

## 1. Native role: a local source catalogue, not an execution control plane

The browser dashboard reads ECC's agents, skills, commands, rules, MCP declarations and hook definitions, then exposes them as JSON or an HTML application. Its normal root is the package directory derived from the script location. The exported server factory permits an explicitly supplied root; the normal CLI does not implement the desktop application's editable project selector. PACKAGE names the separate dashboard:web entry. [WEB, PACKAGE]

The actual chain is:

`package files/configuration → loaders and metadata projection → Host/Origin admission → JSON or HTML with embedded data → local navigation/search/details/copy → clipboard or separate user action`.

After admission, /api/data returns JSON; other pathnames render the HTML application. The request pathname is not used to choose a source file. The handler does not dispatch agent work, install components, change MCP configuration or invoke a model. It does not distinguish request methods, but that is not evidence of a hidden write endpoint: its implemented application paths read/project data. The normal entry also attempts to open an OS browser after listening. These observations describe the inspected handlers, not a complete audit of every transitive module's import-time behavior. [WEB]

This is therefore another component explorer, not a browser version of the operational Rust/Node control pane. Compared with the desktop it adds HTTP admission, more source families and client-side interactions, while removing the desktop's terminal/document callbacks. No uniform live-dashboard contract follows from the shared name.

## 2. What the data actually represent

Agent files supply names, descriptions, declared models/tools and an initial body segment. Skill subdirectories supply a description and body segment, even when a missing SKILL.md yields empty fields. Commands are direct Markdown files, rules are language-directory/file names, MCP entries come from .mcp.json and mcp-configs JSON, and hooks come from the source configuration plus a child registry. None of these loaders queries an installed host's loaded tools, active MCP connections or successful hook executions. [WEB]

The root .mcp.json contains a Chrome DevTools declaration. The separately read mcp-configs/mcp-servers.json contains a selection template with public placeholders, optional services and instructions to copy only needed entries into host configuration. The dashboard preserves the source filename but omits description, headers and template comments from its MCP projection. Seeing these entries does not mean the template has been installed, its credentials are available or its services are running. The omitted instructions include source-specific setup and opt-in boundaries; the display is not a faithful runnable configuration export. No listed external provider's claims were validated here. [ROOT-MCP, MCP-TEMPLATE, WEB]

Useful normalization exists. TOOLS preserves commas inside scoped tool expressions rather than splitting every comma into a new tool. HOOKCFG binds sidecar IDs/descriptions to hook matcher/command entries with stable fingerprints and rejects mismatch, duplicate IDs or inconsistent lengths before merging. These are real representation controls, not runtime permission or signature checks. [TOOLS, HOOKCFG]

Hook expansion has a separate boundary. For the canonical package root, WEB imports the PostToolUse dispatcher and displays all entries in its synchronous and asynchronous registries, dropping their profile and execution fields. The actual dispatcher later filters by dispatcher enablement, tool match, hook enablement/profile and preview mode. Displaying a child ID therefore establishes registry membership, not current enablement or execution. The dashboard does not call runHooks. Custom roots do not receive the same child expansion merely because their files are equivalent. The dispatcher body was read; a new complete audit of its imported child implementations was not performed. [WEB, DISPATCH]

## 3. Useful local admission, with a narrower object than authentication

The normal host resolver admits only loopback hostnames and explicitly passes the chosen loopback address to listen. Each HTTP request must then pass Host before Origin and routing. Missing, malformed or foreign Host values receive 421; a present foreign Origin receives 403. These checks are useful against requests retaining an attacker-controlled hostname even when DNS points it at a local address. [WEB, GUARD]

The guard's accepted set includes the loopback aliases, rather than only one exact origin. Host parsing validates the port's range and then discards it. Origin parsing compares only URL.hostname; it does not compare protocol or port. An absent Origin is permitted for ordinary navigation/CLI use. Consequently, a request with an allowed Host and an Origin on a different loopback port can pass this server-side predicate. There is no per-user authentication in this handler. This qualifies the protection's scope; it does not negate the foreign-host refusal. [GUARD, WEB]

Server admission must not be inflated into browser readability. The browser's same-origin definition includes scheme, host and port, and this server does not supply an Access-Control-Allow-Origin response. A server-side allowance alone does not prove that an arbitrary other-origin web page can read the returned data. No DNS-rebinding attack, cross-origin browser trial, remote exposure or authentication bypass was executed. [HTML-ORIGIN, WEB]

Every response helper sends Cache-Control: no-store. Each new request loads data again, but a delivered page uses embedded constant arrays and local hash navigation; it does not poll /api/data or subscribe to changes. Thus the open page can remain stale while a later request sees changed files. Cache policy is not live synchronization, and sequential file reads are not a version-bound snapshot. [WEB]

## 4. Counterpart: rejected or unread data can become an apparently empty catalogue

The outer server catches loading/rendering exceptions and returns a generic 500, keeping detailed diagnostics on the server side. Its error-reporting wrapper even protects the generic response if the reporter itself throws. These are useful failure controls. [WEB]

However, several inner loaders catch their own errors. Malformed MCP JSON is logged and omitted. Hook parsing or sidecar-alignment failure is logged and converted to an empty hook list. The outer loader then returns an ordinary data object, so the request can succeed with 200 and the client can display No MCP configs found or No hooks configured. The API does not carry a per-family degraded/failed status distinguishing this case from genuine absence. [WEB, HOOKCFG]

A concrete conditional chain is: change a hook command without updating its sidecar fingerprint → HOOKCFG rejects the mismatch → WEB.loadHooks catches that error and returns [] → successful page/API contains an empty hook collection. The first control correctly refuses an inconsistent binding, but the later representation loses the reason. This is not silent failure everywhere: stderr still contains a diagnostic. Nor does an empty browser collection show that the actual host has stopped executing hooks. No configuration was changed in this research.

The test file explicitly expects malformed MCP/hooks JSON to yield empty arrays. Its 500 tests instead inject failures that escape the whole loadData or render function. Both are legitimate tests of their selected contracts; neither makes valid-HTTP-response status a completeness guarantee for every underlying source family. [TEST]

## 5. Masking and output encoding must be followed to their final consumer

### Field masking is useful but not complete secret removal

loadMcps replaces environment values with six bullet characters before either JSON or HTML output, while preserving variable names. It does not apply equivalent masking to the command/URL or argument array. If a locally supplied configuration stores a token in an argument or URL, that value remains in the projected data. Headers are omitted rather than transmitted by this projection. This is a conditional field-location distinction, not an observed secret leak: the inspected repository template contains public placeholders, not acquired user credentials. [WEB, MCP-TEMPLATE]

### Initial script-data protection is not final DOM encoding

renderHTML serializes each dataset with JSON.stringify and replaces literal '<' with a Unicode escape. This protects that initial inline-script representation against literal markup in the embedded data. Most client text paths additionally call esc or use textContent, and some event handlers are attached as functions rather than generated source strings. These are real positive controls. [WEB]

The MCP detail path, however, concatenates s.args.join(' ') directly into an HTML string and assigns the result to app.innerHTML. The Unicode escape in the initial script has already become an ordinary character in the JavaScript string by then. For a harmless stipulated argument '<b>sample</b>', the detail consumer interprets markup rather than displaying the literal argument. The HTML innerHTML contract parses its input as markup; the earlier serialization control does not protect this later context. No browser, executable payload or exploitation campaign was used. [WEB, HTML-DOM]

Related context-specific boundaries are visible in the same client: model metadata enters a generated attribute and badge without text escaping, and esc only handles ampersands/angle brackets while some uses are quoted attributes. These are source surfaces requiring stronger context-aware rendering evidence, not proof of every possible exploit. The main finding is the complete MCP argument producer-to-innerHTML chain, not an inference from a dangerous function name alone.

The upstream escaping tests assert that the server-generated HTML string contains Unicode-escaped angle brackets in skill data. They do not execute the embedded client, inspect the resulting DOM or exercise MCP argument details. They can detect regressions in the initial representation while missing a problem introduced by the downstream consumer. [TEST]

## 6. Detail, search and copy are also derived views

The loaders truncate body text to 1,200 characters for agents, 1,000 for skills and 600 for commands. Detail navigation uses those same arrays and does not fetch the rest of a file. A critical instruction beyond the cutoff is therefore outside this view, not absent from the source. Search covers selected metadata fields, with its own suggestion limits; it is not a full-source search or proof of capability absence. Static version strings are not readbacks of the installed package version. [WEB]

Command buttons copy a slash-command name. They do not execute it or bind it to a particular installed host/namespace. The copy helper calls Clipboard.writeText and immediately displays Copied feedback outside the promise's completion path; rejection is not handled. The fallback also ignores the legacy copy operation's boolean result. If writeText returns a promise that is subsequently rejected for lack of permission, success feedback has already been displayed. A synchronous exception before that feedback is a different path. The clipboard specification distinguishes promise rejection from completed writing. No clipboard operation occurred here. [WEB, CLIPBOARD]

Even actual clipboard success would establish only that text reached the clipboard, not that a valid command ran or its outcome was accepted. LocalStorage preserves language/theme/recent-view data, not an ECC work state or an authenticated task history. These are useful conveniences with a limited continuity object.

## 7. Evidence and tests

The complete browser test file includes real filesystem fixtures and definitions for ephemeral loopback HTTP requests, raw Host-less requests, rejection status codes, no-store responses and continued service after an injected failure. It also uses a fake server for the explicit-listen-host call contract. This is more than a marker-only test suite, but its definitions were inspected, not run. The browser/DOM/clipboard is not exercised by that file. A full test file is not an exhaustive test-discovery claim across the repository. [TEST]

The completed corpus consists of WEB, GUARD, TOOLS, HOOKCFG, TEST, DISPATCH, ROOT-MCP and MCP-TEMPLATE. WEB reuses the unchanged prior1–140 prefix and completes the body through overlapping fresh ranges; the ledger records exact coverage. Package declarations and the desktop explanation retain their prior evidence scope. No target code was imported or executed, no HTTP listener/browser/model was started, no user data/configuration/credential was accessed or changed and no E11 exists. Standards qualify selected interfaces, not installed-browser efficacy.

## 8. System contribution, reopening and next responsibility

Together, Notes46–47 explain the selected desktop and browser explorer roles without mistaking either for a unified live operator. The browser adds genuine HTTP admission, source normalization, masking and presentation, while retaining distinct boundaries for source completeness, metadata authority, browser trust contexts, freshness and action-result standing. Q08d2 is source-complete at this bounded level; Q08d3 retains stronger desktop claims and Q08d4 retains stronger browser/runtime/DOM/request/privacy/concurrency/outcome claims. Broader ECC source coverage is not thereby complete.

Next selected U18-I / G5 / Q02j is a remaining-MCP/interface responsibility reconciliation, not another external-product study. Begin with the already fully read root/template MCP declarations, the existing G5 map and the original evidence routes for Vault, maintenance/configuration and Itô. Determine which ECC-side producer/installer/host-consumer links are already explained, which genuinely require new source and which terminate at an external-provider boundary. If an actual uncovered chain changes the ECC system account, select and explain it; otherwise justify G5 source closure and the move to G6. Do not open a study for every provider listed in a template. This reconciliation is selected but NOT STARTED. G6 reverse inventory, final CORE and joint evaluation remain open.
