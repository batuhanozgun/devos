# Note46 — Desktop dashboard discovery and action boundaries

**2026-09-23 · U18-G / G5 / Q08d1 / MR47 · BOUNDED DESKTOP SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-G-SOURCES.md), [round](../ROUND-U18-G.md), [STATE](../STATE.md). Source observations, authored claims, inspected test definitions and conditional deductions. No target execution, GUI/browser/server/terminal/model launch, installation or user-configuration mutation. The separate browser implementation remains a source question under Q08d2, not a stronger unrun desktop test.

## 1. A repository-component explorer with local launch conveniences

The complete ecc_dashboard.py implements a Tkinter desktop application. It loads agents, skills, commands and rules from a selected filesystem tree, displays searchable/filterable lists and short details, offers appearance changes, and provides terminal/document opening and manual refresh. It neither starts the listed agents nor installs or activates their skills/rules. Its action callbacks do not query the Rust/Node session stores, dispatch work items, supervise models or display live agent execution. The word dashboard therefore does not make it the same mechanism as the previously studied operator control pane. [GUI, RUNTIME]

The chain is:

`script location / selected path → directory/file interpretation or fallback catalogue → in-memory lists and labels → user selection → details / local terminal or document dispatch → external OS application`.

The package's dashboard script invokes python3 ./ecc_dashboard.py; dashboard:web invokes another JavaScript file. TROUBLE explicitly instructs using a full repository clone rather than the Claude plugin directory. The GUI separately catches missing Tkinter and explains the requirement and browser alternative. Thus a plugin installation is not evidence that the desktop launch surface is available. The omitted root Python entry in PACKAGE's files list is not, by itself, a newly established packaging bug: the authored full-clone boundary must be retained. No package was built or installed. [PACKAGE, TROUBLE, GUI]

The initial component root is the directory containing the Python script, despite a comment mentioning the working directory. The icon paths are separately cwd-relative. Settings and appearance are in-memory only; no persistent preferences or work-state database are written by this GUI. [GUI]

## 2. Discovery is real, but presence and fallback are not installed capability

load_agents scans direct .md files and extracts simple frontmatter name/description lines. load_skills lists subdirectories, including one without SKILL.md, and derives categories from filename substrings. load_commands scans direct Markdown filenames; load_rules scans Markdown files one directory below rules. These are concrete, useful discovery choices, not the install manifests, a recursive semantic inventory or a running host's loaded-component registry. [GUI]

Each family supplies a hard-coded fallback when its discovered list is empty. Those fallback entries reach the same lists, tab counts and Ready status as discovered content without a per-record origin/availability label. The GUI then supplies generic statements about automatic skill/rule activation or using a slash command. No installed-host check is performed before showing those statements; agent-to-slash mapping is derived from a name, not validated against a command registry. This is a distinction between displayed guidance and demonstrated activation, not proof that the host can never activate those assets. [GUI]

### Countercase A — missing source becomes a populated catalogue, then an unusable detail

Select an existing empty directory and refresh. The loaders can return their fallback entries and refresh_data can announce success with nonzero component counts. This does not establish any ECC content in that directory. If a fallback skill is selected, on_skill_select accesses skill['path'], but the fallback skill dictionaries contain no path key. That source path raises KeyError rather than producing the requested details. This is a conditional callback trace; no GUI was launched and no actual user error was observed. [GUI]

The enabling condition is not simply missing files. The loader substitutes a different record shape without carrying its fallback status; the consumer assumes the discovered-record shape. The same substitution also prevents the Ready/count presentation from distinguishing observed files from examples. The runtime-helper tests do not instantiate these loaders or this callback. [GUI, TEST]

### Countercase B — metadata is present but the short description can be only a delimiter

The skill description loop accepts the first nonempty line not beginning with '#'. A standard frontmatter opening line, '---', satisfies that predicate. For example, the fully read same-pin nanoclaw-repl skill starts that way; its displayed short description follows the delimiter rather than the later description field. The skill file has not lost its contents, and this is not a claim that the host misreads it. It is this GUI's derived description and search representation. Agent frontmatter and command headings use different parsers and must not be declared equivalent. [GUI, SAMPLE]

The header/About version strings are also static GUI text, not a readback of PACKAGE or an installed host. Their presence cannot qualify a running package version. [GUI, PACKAGE]

## 3. Displayed source and action target can separate during path changes

The initial lists are loaded into self.agents/skills/commands/rules. browse_path changes only the editable path entry. Typing into that entry has the same immediate effect. Terminal and document callbacks read its current value, whereas the component lists continue to represent the preceding load until Refresh Data is pressed. [GUI]

Stipulate displayed data from directory A, then select directory B without refreshing. Opening README or a terminal targets B while the lists still describe A. This can be an intentional manual-refresh interaction, but it is not an atomic switch of dataset and action target and should not be interpreted as one. No automatic code change in the wrong project follows from the GUI itself; its terminal is an ordinary user-controlled terminal. [GUI, RUNTIME]

Refresh replaces the four in-memory datasets, tab counts, visible rows and status bar. It does not rebuild the category/language option sets, reset the separate search-count labels or apply current search/filter conditions to the newly populated rows. Those controls were initialized from the prior data. Consequently a successful refresh is not a guarantee that every visible filter/qualifier represents the new source. Refresh is also not a filesystem watcher, version-bound snapshot or a transaction across all four loaders. [GUI]

These distinctions matter to the native-system account: this is a manually refreshed source explorer, not an authoritative current-state interface shared with execution. The findings do not require turning a lightweight browser into a full orchestrator.

## 4. Useful path controls precede launch; launch is not observed completion

open_terminal canonicalizes the selected path, and launch_terminal verifies that it is a directory before starting anything. On Windows the helper uses cmd.exe with cwd and a new-console flag. On macOS it supplies the directory as a separate argument to open -a Terminal. On Linux the directory is a separate positional argument to a fixed bash script that uses quoted '$1'; it is not interpolated into that script's command text. The outer Popen call does not set shell=True, but Linux deliberately starts bash, so 'no shell=True' must not be inflated into 'no shell interpreter'. [GUI, RUNTIME]

These controls address concrete path/argument problems. They do not prove that the OS application opened successfully, that its final working directory is still the checked directory, or that later terminal activity is governed by ECC. The helper discards Popen's returned process object and does not poll/wait/read a result. The GUI catches immediate exceptions, but a child that starts and then exits unsuccessfully has no corresponding completion report here. Official Python documentation distinguishes creation from later poll/wait/returncode inspection. No terminal was started in this study. [RUNTIME, PY-PROC]

Document opening uses fixed README.md or AGENTS.md names. It resolves both base and target and rejects a canonical target outside the base, which is useful against a document symlink resolving outside that selected directory. It checks existence and passes a file URI to webbrowser.open. This is not a general file-access sandbox or an immutable check-to-open binding. The callback also ignores the browser API's boolean launch result, so a False return does not become a user-visible failure in this code. Missing files and the explicit containment rejection do receive errors. No browser/document was opened. [GUI, PY-BROWSER]

Window maximization has a separate best-effort fallback: try zoomed, then platform-specific attributes. That is local UI resilience, not application or host readiness. [RUNTIME]

## 5. Actual tests discriminate a narrower object

The complete tests/scripts/ecc-dashboard.test.js imports the Tkinter-independent Python runtime helper through subprocess-driven snippets. Four definitions check Linux path separation, the shape of Windows cwd/creationflags arguments, refusal of a missing directory, and a fake window's Linux maximize fallback. These are meaningful local checks; the dangerous-looking path string in the Linux test is inspected as an argument value, not executed. [TEST]

The test suite does not instantiate ECCDashboard, load an empty source tree, select a fallback skill, refresh across roots or confirm a launched terminal/browser's result. Its Windows branch can be simulated on another platform; asserting that creationflags exists does not independently validate a Windows console. The macOS launch branch is not exercised in this file. No test was run, and no claim of exhaustive test absence elsewhere is made. [TEST]

The selected npm publish test prefix compares a manifest-derived allowlist and begins a dry-run pack test. It is recorded as selected-read only; it does not independently establish desktop usability or actual package contents in this unit. The authored full-clone requirement is the relevant boundary, not an assumed all-distribution GUI promise. [PACK-TEST, TROUBLE]

## 6. Return, broader contribution and unresolved browser source

Q08d1 now explains the desktop role through its complete GUI, actual helper and test consumers. Useful source discovery, manual refresh, filtering, local appearance, constrained document paths, directory validation and argument separation remain alongside fallback/schema mismatch, metadata projection, selected-root versus loaded-root drift, incomplete filter refresh and unobserved launch completion. These are source deductions, not measured GUI failures, security certification or an upstream fix.

Note46 extends provisional Note33 by separating a component explorer from the operational Rust/Node control plane. It does not demand that every presentation surface supervise agents, nor promote the GUI's labels into installed capability evidence. Q08d3 preserves installed Python/Tk/OS/terminal/browser correspondence, full parsing and locale/symlink/permission variants, concurrent source/target changes, complete refresh/display fidelity and actual successful user outcomes.

The browser alternative cannot inherit this answer. Only scripts/dashboard-web.js1–140 was read: it introduces an HTTP entry, loopback-host selection, different metadata loaders, MCP projection and referenced helper dependencies. Its request handling, content delivery, actions, actual guard consumers and tests remain unread. This is **Q08d2 / U18-H, next selected and NOT STARTED**, not a completed browser security finding. Begin with its complete body and actual loopback-guard/agent-tools/hooks-config consumers; separate source declarations, exposed content, copied configuration and any execution. Q08d overall remains PARTIAL. Remaining MCP interfaces and G6/reverse inventory/CORE/joint evaluation stay open. No server or browser launch is authorized by selection.
