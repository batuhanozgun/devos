# Note50 — Pi hook context and host consumption

**2026-09-23 · U19-B / G6 / O1 / Q01a2b / MR51 · BOUNDED SOURCE ANSWER.** ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`; separately qualified host Pi0.84.1, `earendil-works/pi@53fa77ccd8a279eb87e92294ef3687b03ff80112`. [Exact sources](../evidence/U19-B-SOURCES.md), [round](../ROUND-U19-B.md), [STATE](../STATE.md). Source observations, inspected test definitions and conditional deductions. No target execution, installation, model, MCP or E11.

## 1. A joined input mechanism, not another independent product study

Note49 identified a real context-construction adapter, but deliberately left its runner, producers and actual host consumer unjoined. The recovered Note07/ledger already explain ECC's instinct-to-SessionStart path. U19-B reuses that evidence and follows the additional Pi connection rather than reopening all learning or reviewing Pi as a separate product.

The bounded chain is:

`ECC package declaration → host-selected resource paths and extension factory → session_start → ECC run-with-flags → session-start producer → JSON additionalContext → adapter pendingContext → before_agent_start → host result chaining → AgentSession systemPrompt → agent.prompt`.

The canonical host tag and package manifest both identify0.84.1. This is a source comparison against the version claimed by ECC's README, not a verified installed package, latest-host verdict or runtime compatibility certificate. The host repository resolved through discovery is earendil-works/pi. Its selected real event types agree with the adapter's start/shutdown reason names; no event-name mismatch was found at this boundary. [PI-README, PI, PACKAGE, HOST-TAG, HOST-PACKAGE, H-TYPES]

## 2. Declaration, selection and loading really are separate operations

PACKAGE declares the extension path and canonical root skills/commands. H-MANIFEST reads the pi resource arrays; H-PACKAGES collects package-relative paths and applies resource filters. In the ordinary filtered-package branch, an empty resource-type array disables that type. H-RESOURCES selects enabled paths, loads extensions and separately loads skill/prompt resources. Project trust and explicit no-resource options participate in those host paths. A directory or a package name alone therefore does not prove that its extension or resources are active.

H-LOADER imports a factory through jiti, creates a fresh extension/API object and invokes the factory. The API's on method stores real callbacks. H-SESSION builds its ExtensionRunner from the loaded extensions and binds it to the host's session manager and working directory; binding emits the selected session_start event. This establishes more than an adapter-local interface declaration. It does not independently audit every acquisition, glob, trust-provider, parser or application-mode branch. [H-MANIFEST, H-PACKAGES, H-RESOURCES, H-LOADER, H-SESSION]

The host's explicit /skill:name path resolves a selected skill and rereads its body, strips frontmatter and expands it into the user prompt. Unknown or unreadable skills can leave the original slash text instead. Loaded prompt templates are another input surface. Neither presence in the ECC directory nor the adapter doctor's count proves that a particular resource survived host filtering or was used. [H-SESSION; PI]

## 3. The selected hooks have useful controls and real side effects

PI runs the named start/end hooks through ECC's common runner, using package-relative scripts, a separately selected Node executable, argument arrays rather than shell interpolation, and timeout/output limits. It supplies the host session ID through CLAUDE_SESSION_ID and the project through cwd/CLAUDE_PROJECT_DIR. The runtime selector's absolute override and Node/Bun/compiled-launcher distinction are admission conventions, not binary provenance or an OS sandbox. [PI, PI-RUNTIME]

FLAGS applies the global enable flag, explicit disabled IDs and allowed profiles, with environment/plugin-option/managed-setting precedence. Both selected hook specifications admit minimal, standard and strict. Thus minimal alone does not disable these two hooks. Disabled and dry-run paths return the input without invoking the selected hook. RUNNER also preserves flushed output, awaits exported async run functions and distinguishes legacy child failures. These are implemented controls, not just the README's claims. [FLAGS, RUNNER]

START has no exported run function, so this runner selects its legacy subprocess path. It creates the session/learned directories, resolves the observer project, prunes expired session-summary files according to the retention setting and can write an observer lease. Turning additional-context injection off does not by itself disable those other operations. The separately configured agent-data and homunculus roots retain different purposes. [START, OBSERVER; original LEARNING/LEARNING-SOURCES]

START's context includes selected instinct actions, an eligible prior summary, learned-skill summaries and detected project type, bounded by the configured total length. Prior-summary matching prefers the exact worktree and only falls back to project name for legacy records without a worktree; its historical-only warning is meaningful. Resume/fork maps to resume and skips this prior-summary branch, while new/reload maps to startup. Instinct and learned-skill selection have their own conditions. This does not mean every session transition restores the same information. Note07 retains the original scope/trigger/evidence compression limitations. [START, PI, LEARNING]

END is the lightweight session-end-marker, not session-end.js. Its actual helper removes an observer lease, lists remaining lease files and may signal the recorded observer PID when none remain. It returns the input. It does not write the current conversation summary. Consequently the selected start/end pair is not by itself a self-contained transcript-save-and-restore loop. Pi has its own message restoration path in H-SDK; lack of an ECC summary writer here is not absence of host session persistence. PID identity, concurrent lease ownership and successful termination are stronger claims, not established by sending a signal. [END, OBSERVER, H-SDK]

## 4. Returned hook context reaches the host, but has a deliberately short lifetime

PI extracts a nonempty additionalContext string and keeps it in the extension factory's closure. Before the next ordinary agent start it adds an ecc-session-context block, clears pendingContext and returns a modified systemPrompt. It adds cached engineering rules separately. No custom-message or appendEntry operation records this context in this adapter path. Clearing old pending context on session_start helps avoid replaying an earlier unconsumed value. [PI]

H-RUNNER awaits before_agent_start handlers in order and passes each the current prompt. H-SESSION consumes the returned result, assigns it to agent.state.systemPrompt and then calls agent.prompt. This is an actual host consumer, not a hypothetical interpretation of a field. The host also has a separate custom-message result path, which this ECC context callback does not use. [H-RUNNER, H-SESSION]

**Normal two-prompt counterpart:** assume the selected start hook returned context, no later extension replaces it and the first ordinary prompt proceeds. The first run receives the context plus rules. At the next separately submitted ordinary prompt, the host starts again from its base prompt; ECC re-adds rules but has no pending context left. The original hook text is therefore not retained as the same system-prompt contribution merely because the same session continues. An assistant response may indirectly carry information forward, but that is not equivalent to preserving the original text and standing. [PI→H-RUNNER→H-SESSION]

The unit is not necessarily one LLM call. The same agent run can contain tools, queued messages, retry or continuation, while a new ordinary prompt rebuilds the input. Streaming submissions can queue before the before_agent_start branch. Calling this 'one model turn' without that distinction would overstate what the callback controls. Model/authentication preflight happens before this callback; a missing-model/key case is not evidence that pending context was consumed and lost. [H-SESSION]

**Later-consumer counterpart:** after ECC clears pendingContext, a later before_agent_start handler may return a replacement prompt without preserving ECC's block. The host permits this ordered replacement. ECC has no acknowledgement from the final composed prompt or provider before consuming its field. This is a conditional composition limit, not an observed malicious extension, failed model call or demand that every context handoff be durable. Internal retries and subsequent new prompts must not be conflated. [PI, H-RUNNER, H-SESSION]

## 5. New extension state does not necessarily mean freshly read rules

The rule cache is module-level; pendingContext is factory-local. The host loader can cache the imported factory by path and working-directory/generation token, then invoke that same factory again to create fresh callback collections. A new factory invocation resets pendingContext but need not recreate the module-level cachedRules value. [PI, H-LOADER]

This is bound to an actual cache-using resource path. H-RESOURCES calls loadExtensionsCached; a newly constructed resource loader starts with loaded=false. H-SERVICES creates such a loader and calls its initial reload. Reusing the same cached factory for the same working directory can therefore preserve earlier rule text even while a new extension object is constructed. If a rule file changes between those cache-backed constructions, that file change is not by itself an invalidation event. This is a conditional source case, not a live /new observation or a claim about every custom runtime factory. [H-RESOURCES, H-SERVICES, H-LOADER]

There is a genuine freshness path, not a permanent-cache defect: reloading an already loaded resource loader clears the extension cache. H-SESSION's explicit reload calls that operation before rebuilding the runner and emitting reload. A changed cache working directory also invalidates the loader cache; a fresh process has a fresh module. Thus session identity, extension-object identity, loaded-module identity and source freshness are distinct. The adapter doctor's rule count describes what its cache contains, not a comparison with newly changed disk contents. [H-RESOURCES, H-SESSION, H-LOADER, PI]

H-RUNTIME's selected new/resume paths also settle/abort outgoing work, emit shutdown, dispose the old session and request a replacement runtime. Those real lifecycle operations prevent treating session changes as only a label update. The supplied createRuntime factory and application bindings still determine the concrete resource-loader path; no universal multi-application cache or concurrency guarantee follows. [H-RUNTIME]

## 6. An internal failure can become silent absence at the adapter boundary

PI produces a warning when runEccHook receives a failure: examples include a missing common runner, an invalid runtime override or a nonzero child exit. It tolerates irrelevant/non-JSON/empty context output. Both behaviors are intentional and useful. [PI]

However, RUNNER returns exit0 and the original payload when the named hook script is missing, after writing a diagnostic to stderr. The extension's execFile callback accepts error/stdout but does not retain stderr in HookResult. For a normal SessionStart payload, its extractor finds no additionalContext; the callback returns without the warning branch. **The runner exists, the actual start script is absent, and the adapter observes successful execution plus no context.** The error is not nonexistent—it was written internally—but it is not surfaced by this adapter's warning path. [RUNNER→PI]

START also catches an internal error, logs it and leaves exit status0. RUNNER's exported-run exception path similarly turns failure into successful passthrough. Those paths must be distinguished from nonzero legacy subprocess failures, which the adapter does warn about. It is inaccurate to generalize either 'all hook failures are warned' or 'all failures are silent'. Intentional disablement, genuinely empty context and some internal failures can share the same outer representation. No files were removed, hooks invoked or Pi warnings observed in this research. [START, RUNNER, PI]

## 7. The tests are mixed evidence, not full adapter execution

The complete ECC Pi test file was inspected, not run. Its source assertions check package-root resolution, callback names, non-shell invocation, guard structure, tags and pending-context clear order. It directly imports the real runtime selector and defines real runner subprocess/filesystem cases. Other cases operate on hand-copied extract/context/name/rule logic, sometimes against actual rule files; the EPIPE case recreates an execution pattern rather than importing the TypeScript adapter. Neither dismissing the suite as text-only nor calling it an executed Pi integration is justified. [T-PI]

Several assertions have narrower oracles than their names suggest. The profile case asserts spawn/status success; the selected end hook includes minimal in its allowed profiles. That check does not independently establish a restrictive-profile skip or observer cleanup. The pending-context checks inspect statement order, not the host's later prompt replacement. The rule mirror expressly omits memoization. Thus these tests do not establish the cache-backed lifecycle or final consumer correspondence described above. This is the scope of the inspected file, not a repository-wide claim that no other tests exist or pass.

Positive controls remain meaningful: real argument/path handling, selector cases, source assertions tied to shipped code, guarded stdin failures, historical-summary selection and a host reload path. No independent model-obedience, useful-learning, isolation, installed-version, retry-durability or outcome evidence was produced.

## 8. Bounded disposition and next responsibility

Q01a2b/O1 now has a joined source answer from the ECC declaration and actual producers to the named Pi host consumer. Note49's source gap is resolved at this scope; stronger installed/runtime claims remain distinct. The provisional system account gains a directly loaded extension with several input/state lifetimes, not a universal memory or authority layer.

Q01a2b2 preserves exact installed package/jiti/Node/host correspondence; complete resource/trust/application-mode variants; concurrent lifecycle callbacks, durable handoff and final-provider fidelity; cache/source-change behavior outside the selected paths; lease/PID authority; and useful task/model outcomes. The source cases are not observed incidents. No external Pi product study, target execution or E11 was opened.

**Next selected U19-C / G6 / O2 — Cursor data-root deployment and later-reader correspondence, NOT STARTED.** Start from Note49/U19-A sources, the already read scaffold/hook/data-home sources and original installation/learning evidence. Follow actual selected installer operations and dependencies into host-returned environment and subsequent ECC readers/writers; distinguish separate data locations from isolation and from Vault scopes. Remaining non-MCP Codex/generator/Kiro and O3 broad-document obligations stay explicit and are not silently closed. Final CORE and joint evaluation remain unfinished.
