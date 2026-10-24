# Note45 — NanoClaw context replay and session continuity

**2026-09-23 · U18-F / G5 / Q02i / MR46 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources](../evidence/U18-F-SOURCES.md), [round](../ROUND-U18-F.md), [STATE](../STATE.md). Source observations, authored guidance, inspected test definitions and conditional deductions. No target execution, E11, Claude/model/provider call, user-history mutation or installation.

## 1. Native role and real entry

This NanoClaw is ECC's own scripts/claw.js: a human-driven terminal REPL around successive Claude Code subprocesses. It is not a separately selected same-named product, a scheduler or a self-directed multi-agent controller. The package's claw script invokes node scripts/claw.js; its files list includes that script and skills/nanoclaw-repl. The legacy slash shim directs users to those maintained surfaces and explicitly redirects long-running orchestration requests elsewhere. The public ecc.js command table does not contain claw. Package membership, npm script, interpreted slash guidance and an ecc subcommand are distinct entry surfaces. [CLAW, PACKAGE, SHIM, CLI]

The main loop is concrete:

`session name → Markdown history + in-memory model/skill selection → one user line → prior history read → User append → prompt on stdin to claude -p → response/error string → Assistant append → next user line`.

Reading history before appending the current input avoids automatically including that input twice in the constructed prompt. Synchronous invocation serializes ordinary turns within one REPL. A named file gives a later launch a real, recoverable transcript. Local help, history, search, model changes, loading, branching, clearing, exports and metrics do not themselves call the model. These useful mechanisms do not establish accepted work or isolation from other processes. The zero-external-dependency description concerns the script's built-in Node imports; it does not remove its external Claude executable/account dependency or make all ECC dependency-free. [CLAW, PACKAGE]

## 2. Saved conversation is not a saved execution context

CLAW_SESSION selects a validated alphanumeric/hyphen name, defaulting to default. The path is under the user's .claude/claw directory, without a project identifier. Different working directories can therefore select the same transcript. Initial model and skills come from the current environment; /model and /load update only in-memory state. The transcript writer records role, timestamp and content, not those choices, their source revisions, working directory, host policy or native Claude session identity. [CLAW]

A restart with the same name recovers the file but need not recover the previous model, selected skills or project environment. For example, loading a skill interactively and restarting without the corresponding environment selection preserves the conversation while omitting that added skill context. This is a conditional source case, not an observed failed session. A branch preserves current in-memory settings while that REPL continues; it does not serialize them into the copied transcript for a future launch.

Skill discovery is also location-dependent: loadECCContext reads cwd/skills/<name>/SKILL.md, not a package-root or installed-host registry. The npm documentation establishes package-root working-directory semantics for npm run; direct execution of an absolute script from another directory can use a different skill root. CLAW does not read INIT_CWD or bind the selected files to an explicit project manifest. This qualifies entry equivalence without claiming every launch loses context. [CLAW, PACKAGE, NPM]

Read failures are deliberately forgiving. loadHistory returns an empty string on every caught read error, not only an absent file. Skill loading silently skips unreadable/missing files. Startup's loaded count and /load's success path depend on existence rather than successful content reads; names are not validated like session names. Existence, requested selection and actual included bytes can disagree. The full skill text is read at startup and again on /load, not on every ordinary turn, so a later disk edit alone does not refresh the in-memory context. [CLAW]

## 3. Text replay, host authority and process conditions

buildPrompt concatenates labels for SYSTEM CONTEXT, CONVERSATION HISTORY and USER MESSAGE into one ordinary string. askClaude sends it through stdin with -p and, when supplied, --model. It does not use native resume/session identifiers, structured role input or a system-prompt flag. Official Claude documentation distinguishes print/piped input, native continuation/resume, and explicit system-prompt controls. The label SYSTEM CONTEXT is therefore an application convention, not evidence that the host received a privileged system message. This does not prove the model ignores the guidance or that host-native settings are absent. [CLAW, CLAUDE]

CLAW starts the command name claude using the inherited environment, except that CLAUDECODE is set to an empty string. It does not pin an executable/version, supply a dedicated sandbox, set a tool-policy or spending limit, or explicitly bind a different child working directory. The actual installed host's permissions and configuration remain relevant. Clearing one variable is not credential isolation or evidence that host protections have all been disabled. [CLAW]

Sending the multiline prompt via stdin avoids embedding it as a shell argument. Windows still uses shell:true, and the model value can come directly from /model or CLAW_MODEL without validation or escaping. The source comment's fixed-command rationale does not cover this variable argument. Node warns about unsanitized arguments with shell execution; this identifies an unchecked Windows-specific input boundary, not an executed exploit or a claim about the non-shell path. [CLAW, NODE]

The subprocess call sets a five-minute timeout but no explicit maxBuffer. Node's documented synchronous-call contract has a default output buffer bound and waits for child exit after timeout signaling. These settings are not a proof of complete captured output or a hard end-to-end completion deadline. No timeout, shell, buffer or live-host experiment occurred here. [NODE]

## 4. Failure is converted into transcript text, not a separate attempt state

askClaude returns an error string when result.error exists. For a nonzero status it reports an error only when stderr is nonempty; otherwise it returns trimmed stdout, possibly empty. It does not return a structured success/failure/signal/result object. The main loop prints and stores every returned string as an Assistant turn. Thus a nonzero exit with empty stderr and partial stdout can enter history without the failure qualifier; a displayed error can also be counted as an assistant reply. This is a condition on possible subprocess results, not an assertion that the real Claude client emits that case. [CLAW]

The user input is appended before the subprocess starts; the assistant entry is appended after completion. That preserves attempted input in some failures, but the pair is not an atomic attempt record. An interruption after the first append can leave an unmatched user entry; a failure after external work but before response persistence leaves no durable effect receipt here. Reopening replays whatever file remains rather than resuming an identified interrupted execution. Local filesystem writes have no enclosing recovery transaction, and multiple REPLs can use the same file without a lifecycle lock. No actual interruption or lost user work was observed. [CLAW]

## 5. Raw history and parsed history are different representations

Ordinary prompting, /history, substring search and Markdown export use raw file text. Metrics, JSON/text exports and compaction use parseTurns. That parser recognizes a header and the first following newline-delimited Markdown horizontal rule as the end of the record. appendTurn does not escape such content. [CLAW]

### Countercase A — an ordinary Markdown answer loses content during conversion

Suppose one stored Assistant answer contains the text Alpha, then a line consisting of three hyphens, then the important text Omega. The raw session and the next ordinary prompt contain both parts. parseTurns treats the internal horizontal rule as the record terminator and does not include Omega in that parsed turn. Unless later content independently matches a new record header, it is skipped. JSON/text export omits it; compaction can permanently rewrite the file without it when the parsed turn-count threshold is exceeded.

This needs no malformed filesystem, malicious input or service failure: model responses commonly support multiline content, while the storage grammar uses unescaped content delimiters. The observation is about this stipulated string and code path, not a measured model-output frequency. The tests use simple one-line payloads and do not check round-trip preservation across embedded separators. [CLAW, TEST]

### Countercase B — the parser's protective cap can discard the newest history

parseTurns limits scanning to the first 5,000,000 JavaScript string units. The cap is explicitly motivated by expensive regex scanning. It is not a whole-file read limit or a model-input budget: loadHistory already reads the file, and prompt construction uses the full raw history. [CLAW]

compactSession chooses the last requested number of records from that parsed prefix, not from the full file. For a file beyond the cap with more than twenty complete parsed records before the cutoff and newer records afterward, default compaction can retain twenty older prefix records and discard the genuinely newest suffix. The implementation is not merely dropping the oldest context in this case. If the parsed count is too small, it instead returns false without rewriting; that condition is part of the finding.

Below the cap and with unambiguous delimiters, /compact intentionally retains the last twenty message records, not twenty user/assistant exchanges and not a semantic summary. Earlier content is overwritten without an automatic archive, checkpoint or assessment of unresolved goals. This can be a deliberate lightweight trade-off, but the authored advice to compact after a milestone is not an implemented guarantee that omitted information is no longer needed. Metrics estimate raw-history tokens as length/4; they do not include skill context, current input or host-added context and do not enforce a budget. [CLAW, SKILL]

## 6. Branching and export provide utilities, not isolation or recovery transactions

branchSession validates the new session name and copies the current transcript, then the caller switches to that file. It does not create a Git branch/worktree, snapshot project files, isolate permissions or preserve an identified native Claude session. Existing destination names are written without an exclusive-create or overwrite-confirmation check. The skill's advice to branch before high-risk changes can preserve dialogue in a new name; it cannot itself protect external project changes, and a name collision can replace earlier dialogue. [CLAW, SKILL]

Markdown export copies raw history; JSON/text export depends on the lossy parser above. An explicit export path is not protected against the active transcript path, so writing another format there can destroy its record grammar. Default Markdown export creates a .export.md file in the same directory; session listing/search select all .md names, including that export, although the startup session-name validator does not permit dots. These are bounded representation/namespace distinctions, not a claim that all exports or branches fail. No files were branched, cleared, compacted or exported in this research. [CLAW]

## 7. What the test file establishes and cannot establish

The complete TEST file defines useful local checks for storage, name validation, prompt section ordering, context concatenation, search, branching, JSON export, metrics and simple recent-record compaction. It does not drive main through a complete interactive history/skill/model/restart cycle, nor test delimiter collisions, the prefix-cap counterpart, destination collisions or interrupted persistence. [TEST]

Its askClaude error test calls the actual helper without substituting the executable. Despite a comment about using a nonexistent command, the implementation still invokes claude. The test accepts either an actual response or an error as long as it is a nonempty string. That oracle cannot distinguish successful delegation from an infrastructure failure, and running the file where a configured Claude exists can cross a live-provider boundary. It was not run. Separately, context-test early returns print a skip message but the enclosing test wrapper counts normal return as success; that does not mean content concatenation was tested in every environment. [TEST]

## 8. Native-system contribution, limits and next responsibility

NanoClaw supplies an explicit, inspectable transcript-replay path joining portable skill text to an external coding host. Persistence, single-REPL sequencing and local utilities are real. Faithful conversation serialization, recovery of the prior execution environment, host authority, attempt/result standing, reversible compaction and safe branching are distinct obligations. The result extends Note33's provisional assembly; it does not equate NanoClaw's files with ECC's Vault, Rust sessions or a universal memory contract.

Q02i1 carries the bounded source answer. Q02i2 retains installed host/model/config/permission correspondence, Windows argument treatment, secret and project separation, complete input/output fidelity, concurrency/crash/attempt recovery, structured round-trip/large-history behavior and accepted useful outcomes. Source deductions are not executed incidents, model-efficacy evidence or an upstream patch.

G5 was reassessed against the unchanged U15-A responsibility map, not a new product list. Next selected U18-G/Q08d concerns the alternate dashboard's component discovery → displayed standing → actual action/terminal consumer, starting with ecc_dashboard.py and scripts/lib/ecc_dashboard_runtime.py. Only ecc_dashboard.py1–100 was read for selection; the complete GUI/actions/helper/tests remain NOT STARTED. Its header and imports identify a Tkinter component-management surface and a separate browser alternative, not proof of a unified live operator view. Remaining MCP/other dashboard roles and G6/CORE/joint evaluation stay open. No GUI, terminal, service or model launch is authorized by this selection.
