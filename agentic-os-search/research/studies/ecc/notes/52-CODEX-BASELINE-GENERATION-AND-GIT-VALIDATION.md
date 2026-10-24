# Note52 — Legacy Codex baseline, generation and Git validation

**2026-09-24 · U19-D / G6 / O2 / Q01a2d / MR53 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U19-D-SOURCES.md), [round](../ROUND-U19-D.md), [STATE](../STATE.md). Source observations, inspected test definitions and conditional deductions; no target execution, installation, Codex/model/MCP, user configuration or E11.

## 1. Three different responsibilities in one legacy synchronization path

Note48 explained the MCP writer/checker and Note38 the surrounding legacy ownership/rollback. The remaining non-MCP path is now joined: SYNC selects a baseline merger, concatenates instructions, generates command/tool/rule prompts, copies role definitions and installs executable global Git hooks before CHECK and finalization. These are neither one uniform enforcement mechanism nor the native Codex plugin/hooks channel.

| Responsibility | Actual producer and consumer | Bounded meaning |
|---|---|---|
| Baseline configuration | REF → BASE whitelist → target config.toml → later MCP parse/CHECK and documented host config | Selected missing keys/tables are added; installed schema acceptance and effective layered policy remain separate |
| Global guidance | Root AGENTS + SUPPLEMENT → SYNC marker block → target AGENTS.md → documented host discovery | Authored instructions become a candidate input, not proof the host selected this file or followed its contents |
| Command and QA prompts | Top-level commands/*.md and literal here-docs → prompts/ecc-*.md | Actor-interpreted procedures; generation does not run tests, audit dependencies or approve work |
| Optional rule packs | Generated prompt → absolute paths into the source checkout's .cursor/rules | A live source reference, not a self-contained copied or revision-bound rule bundle |
| Agent roles | REF config_file references + missing-only role copies → documented role configuration | Actual role config files exist, but preservation of existing files and host selection/availability qualify the result |
| Git enforcement | INSTALL-HOOKS → copied executable PRECOMMIT/PREPUSH → Git hook invocation | Real local denial/command execution, with explicit bypass, dependency, checked-population and revision limits |

The previous MCP answer is an input, not a new discovery. REF contains several MCP examples, but BASE explicitly selects only non-MCP roots/tables; it does not import every reference setting. The separate MCP merger still owns the legacy route's current default. Sources: SYNC, BASE, REF, CHECK, INSTALL-HOOKS, PRECOMMIT, PREPUSH; original Notes38/48.

## 2. Add-only configuration preserves values, but textual placement can change meaning

BASE parses both target and reference through @iarna/toml, selects absent whitelisted root keys and scalar/array table keys, and leaves existing values unchanged. Root model/provider values are not among the imported keys. A valid existing false or empty value counts as present. Standalone table editing preserves surrounding text; certain inline-child forms are supported, and an implicit-table fallback reparses its candidate before accepting it. An unextendible table can produce a warning and remain unchanged. These are meaningful controls, stronger than unrestricted string replacement.

However, root placement uses a regular expression over raw text to locate the first apparent table header. It does not know whether the matched line is inside a TOML string. A valid conditional input is:

```toml
developer_instructions = '''
[example]
Keep this literal example.
'''
```

The parser sees one string, not an example table. BASE's first-header regex nevertheless matches the line inside that string. With the reference's root settings absent, insertBeforeFirstTable inserts those settings at that position, inside the existing literal string. The selected new keys are consequently text in developer_instructions rather than actual root configuration. The user's existing instruction value also changes despite the add-only intent. The reference's inserted values do not close this triple-single-quoted literal; subsequent generated tables are appended after it. This is a source/specification deduction, not an executed fixture or a claim about arbitrary serializer versions. [BASE, REF, D-TOML]

BASE does not reparse and compare the final output's intended semantics before writing. More importantly, even a later successful syntax parse would not establish correct placement: this counterpart can remain valid TOML. The actual later MCP merger parses TOML, while CHECK does not assert the root approval/sandbox values. Its persistent_instructions check can also recognize text inside a string. Other checks must still succeed; no live successful-sync incident is claimed.

The positive alternative is an ordinary target whose apparent headers are actual table headers. The inline/implicit-table safeguards also remain useful. The finding is not that every baseline update fails, but that semantic selection is followed by a lexical placement rule with a different recognition boundary.

A separate composition concerns a deliberate `features.multi_agent = false`. BASE preserves it, but CHECK requires a line enabling multi_agent. With ordinary formatting, no unrelated matching true line and all earlier steps successful, the verifier fails and SYNC enters its recorded rollback path. The user's setting is not silently forced to true by BASE; instead the enclosing workflow cannot complete under that preserved choice. Conversely, CHECK's unscoped line match does not prove that a matching true value belongs to the effective features table. Note48's MCP exclusion case is related but is not this non-MCP setting case.

## 3. Marker replacement, preserved user content and selected guidance differ

SYNC saves a backup and records AGENTS before mutation. An absent file gets a new block; a marker-free file gets an appended block; exactly one ordered full-line BEGIN/END pair is replaced. The scanner does not account for Markdown fences. Its malformed-marker branch deserves a narrower interpretation than the comment's preservation claim.

**Missing-END counterpart:** suppose an existing AGENTS file has a BEGIN marker followed by user text and no END marker. The repair branch sets skip at BEGIN and never clears it. It drops the remaining suffix, then appends the fresh ECC block. A warning and original backup exist, so the change is not wholly undisclosed or necessarily unrecoverable. But if the later sync checks succeed, their success does not restore or prove preservation of that user suffix. CHECK only searches for the generated root/supplement headings. No user file was changed in this study. [SYNC → CHECK]

This differs from Note38's marker-only uninstall helper, which requires an unambiguous pair outside fences. One channel's stronger boundary cannot be transferred to another writer merely because they use ECC markers. The outer ownership record and rollback remain useful; neither is proof that a semantically wrong successful write will be recognized.

The host has another selection boundary. Current official documentation says a nonempty global AGENTS.override.md takes priority over global AGENTS.md. The checker examines the latter only. Thus correctly generated headings and a successful local check are not proof that this global guidance was selected. Project-layer overrides and size limits further qualify effective input; no installed Codex run was observed. [D-AGENTS]

The copied SUPPLEMENT also contains a same-pin factual mismatch: its legacy-sync description says seven managed MCP servers, whereas the actual merger already explained in Note48 selects one current default. This new observation concerns stale authored guidance being concatenated into a host-facing file; it does not reopen seven external providers. Useful external-action approval and private-state preservation instructions in the supplement remain intact. Literal transfer preserves source wording, not its accuracy.

## 4. Generated prompts are interpreted instructions with distinct dependencies

The command converter reads only top-level Markdown command files, strips an initial YAML frontmatter block and copies the body under a new heading/source-path preamble. It does not rewrite every tool name, slash invocation or project path. COMMAND supplies a concrete source: its description and argument-hint metadata are removed, while its body still repeatedly requires explicit approval before implementation and defaults to inline planning. Therefore metadata loss must not be inflated into loss of all approval instructions.

Current official legacy custom-prompt documentation describes description/argument-hint metadata, parameter expansion and explicit invocation from the prompt directory. It marks custom prompts deprecated and recommends skills, while still documenting that path. This is not evidence that every installed version has removed prompt loading. The study does not use third-party version/removal claims as the host oracle. [SYNC, COMMAND, D-PROMPTS]

The generated run-tests, coverage and security-audit prompts tell an actor to select commands, inspect results and report. Their PASS/FAIL formats are not independent executable verifiers. They retain useful no-auto-fix/explicit-request conditions. In contrast, PREPUSH actually invokes selected project scripts and rejects their nonzero exit.

Rule-pack prompts point to absolute source-checkout paths. RULE verifies one actual cited common rule body exists; it is not an invented missing reference. Moving/removing that checkout can break resolution, and changing its rules can change what the prompt later requests without changing the installed prompt bytes. No copying, digest binding or automatic source migration is supplied by this generator. These conditional dependencies do not show that a model actually read or ignored the rule.

REF's three role paths are relative to the declaring config under the documented host contract. SYNC copies the corresponding TOML files only when the destination is absent. The actual role files specify read-only sandbox settings and bounded developer instructions. Existing user role files remain untouched. That is a deliberate preservation policy, not a promise of equality to the current reference; CHECK does not qualify their content or prove a particular role was loaded. Requested models and provider availability were not validated. [REF, ROLE-E/R/D, D-CONFIG]

The two prompt manifests are regenerated, but old ecc-*.md outputs no longer represented by source commands are not removed by the inspected loop. CHECK only requires manifest-file presence and at least43 matching prompt files. That population can include old/extra outputs; it is not an exact member/content/ref-resolution check. No source-version migration or generated prompt was executed here.

## 5. Global Git hooks are real enforcement, with different validity limits

INSTALL-HOOKS copies two scripts, makes them executable and sets global core.hooksPath. Git documentation establishes this as a real hook-selection mechanism; it can affect Git use beyond Codex. Setting one directory does not compose all previous hooks, and global configuration is not every invocation's effective configuration. Note38 preserves the separate original-pointer restoration conditions. CHECK verifies the global pointer and executable files, not the complete runtime path. [INSTALL-HOOKS, CHECK, D-GIT]

PRECOMMIT scans added staged lines for its finite secret patterns, excluding named binary/lockfile classes. A positive match denies the commit. Explicit environment/marker bypasses and no-staged-file cases are separate intentional paths.

**Dependency counterpart:** the scanning command uses `rg --pcre2` inside an if-tested command substitution, suppressing its stderr. Missing rg or another scanner error returns nonzero just as no match does; no positive finding is recorded and the hook can return0. Bash's conditional error semantics do not turn this into automatic errexit denial. Neither INSTALL-HOOKS nor CHECK qualifies rg/PCRE2 availability; CHECK itself even has a grep fallback that PRECOMMIT lacks. This is a conditional source/contract finding, not a real secret leak or executed commit. [PRECOMMIT, INSTALL-HOOKS, CHECK, D-BASH]

PREPUSH has useful command-failure handling, Corepack/direct-pnpm selection, optional dependency audit and explicit missing-check reporting. But it uses incoming refs only to distinguish deletion-only from another push, then runs project-native commands in the current working directory. It does not select and verify each nonzero pushed object ID.

**Revision counterpart:** a working tree can differ from a pushed non-HEAD branch, or contain changes absent from the pushed commit. The hook's tests can then describe that working tree rather than the sent revision. Git actually supplies the ref/object IDs on stdin, but the inspected consumer does not use them for qualification. A matching clean checked-out revision is a useful normal case; it does not establish universal correspondence. No push, checkout or test command was run. [PREPUSH, D-GIT]

Missing Node/script-detection failures and unavailable language tools can also become skipped checks; actual selected-script failure is instead rejected. Successful skipping, successful execution, installed executable presence and qualification of the intended revision must retain separate meanings.

## 6. Test evidence and bounded disposition

The complete TEST file was inspected, not run. It exercises original merger subprocesses and temporary files, parses selected resulting TOML, checks preserved user choices, no-op equality, preview immutability, inline/implicit-table behavior and ordinary full-sync results. PREPUSH cases call the original script with stubbed Git/package-manager functions and check invocation order/failure propagation. Those are useful local oracles, not live Codex discovery or actual test quality on pushed commits. Cache/MCP cases retain their previous research roles rather than being counted as new findings.

This inspected file does not challenge the multiline-literal root-placement case, malformed AGENTS markers, full-sync preserved false choice, global override selection, scanner absence or working-tree/pushed-object mismatch. That is a bounded test-file statement, not a repository-wide claim of absent tests. Current host/specification documentation is not proof of installed parser/shell/Git/Codex conformance.

Q01a2d1 meets the selected source criterion: non-MCP producers, generated surfaces, executable Git consumers and actual sanity/finalization are reconciled. Q01a2d2 retains installed source/package/parser/shell/Git/host identity; complete legal representations and source-update cases; effective layered config and discovery; authenticated ownership/approval; dependency and pushed-revision correspondence; concurrent/crash/rollback behavior; model uptake and useful outcomes. No whole G6 or security certification follows.

**Next selected U19-E / G6 / O2: the already recorded Kiro optimizer representation/generator/host-selection distinction, NOT STARTED.** Recover Note40 and U18-A-SOURCES before following the actual generator/caller: primary optimizer, shorter Kiro Markdown and embedded JSON were already distinguished, but generator causality and effective selection were not established. This is a pre-existing material variant, not an automatic new study per host. Remaining O3 broad-document/mirror/example obligations, revised CORE and joint evaluation stay open.
