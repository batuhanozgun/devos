# Note49 — Reverse inventory and host-context frontier

**2026-09-23 · U19-A / G6 / Q01a2 / MR50 · BOUNDED FIRST-PASS ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Source ledger](../evidence/U19-A-SOURCES.md), [root/omission disposition](../inventory/U19-A-OMISSION-REVIEW.md), [round](../ROUND-U19-A.md), [STATE](../STATE.md). Source observations, original-research reconciliation and qualified deductions; no target execution or E11.

## 1. What was tested about the research

The question was not whether another defect could be found. It was whether the existing ECC explanation omitted a consequential role or treated materially different paths as equivalent. The full original frontier/U07 map, provisional Note33 and representative Note39 were recovered, together with the unchanged current entries and relevant previous results. Root metadata at the fixed pin still matches the historical 43 directory identities. Names and tree hashes establish location, not semantic coverage. [ROOT, HIST, MAP, ASSEMBLY, GUIDANCE]

Four small ambiguous subtrees were fully expanded and all their bodies read: .pi, .hermes, docker and scaffolds. The complete longform-guide text supplied a broad-document challenge. The actual package declaration, Cursor planner and Pi test-method prefix were then read at explicit selected depth. The linked disposition accounts for all 43 original roots without claiming that every descendant was read. This is a consequence-selected first pass, not a random holdout, independent replication or finished G6 audit.

**Result:** the provisional model remains useful, but CORE preparation is premature. A real Pi context/lifecycle adapter requires a joined source explanation beyond the prior Gemini representative; Cursor scaffolds require a data-root/host-consumer reconciliation. Docker's role can now be bounded without treating it as a general autonomous runtime. No new external-product research is needed to make these distinctions.

## 2. A host-labelled directory is not a uniform integration unit

The complete .hermes tree contains one README. It directs the reader to the common installer and describes the intended files and untouched configuration. That is not an embedded Hermes runtime in that directory, and it is not proof that the common installer lacks an adapter elsewhere. [HERMES-TREE, HERMES]

By contrast, .pi contains an actual TypeScript extension and a runtime-selection helper. PACKAGE's pi declaration points to that extension and directly to root skills/commands. The extension registers session_start, before_agent_start, session_shutdown and ecc-doctor handlers. This is implemented integration logic, not simply a copy of a prompt catalogue. [PI-TREE, PI, PI-RUNTIME, PACKAGE]

Note39 explains a different arrangement: Gemini metadata transformation plus actor-interpreted staged procedures. Its bounded result does not establish the Pi loader/callback contract. The shared source assets can be reused through generation, direct mounting, runtime prompt assembly or common installation, with different ownership and freshness conditions. The directory name does not select one of those meanings. [GUIDANCE]

## 3. Pi separates reusable rules from one-shot session context

The inspected adapter has two different routes into a returned systemPrompt:

- A finite allowlist of common engineering-rule files is read from the installed ECC package. The resulting text is memoized and added on every before_agent_start callback. Several host-specific common rules are deliberately excluded; this adapter does not read all language-rule directories.
- A successful session-start hook result may supply additionalContext. The adapter keeps that text as pendingContext, adds it to the next returned prompt and clears it. A new session_start also clears the previous pending value before calling the hook.

These are actual state and callback operations. Repeated policy injection and a one-shot handoff are not the same memory lifecycle. They also differ from Note45's persisted transcript replay: the Pi field is in-memory transfer state, not a restored task journal. [PI; original Note45]

The rule reader's cachedRules variable is module-level. The inspected session_start/shutdown callbacks do not reset it. Consequently, reapplying the cached text on a later turn does not itself reread changed source files. Whether a host session switch reloads the module is a separate loader question. This is a source-level distinction, not an observed stale Pi session or a blanket defect verdict.

The adapter resolves hook scripts from its own package root and calls the ECC hook runner without shell interpolation. It passes a project/session payload and bounded process options; failure paths produce warnings rather than ending the Pi session. Runtime selection distinguishes a Node executable from Bun/compiled-launcher contexts and permits an absolute override. These are useful local mechanisms. Their callbacks still need to be connected to the actual runner, hook output and named host contract before their end-to-end guarantees can be stated. [PI, PI-RUNTIME]

The doctor's companion check reads configured npm package names and explicitly warns that other installation forms can work while appearing absent. Its resource counts and rule shortfall report are useful diagnostics, not proof of loaded host tools, companion permissions or model obedience. Do not turn its output into a universal readiness certificate.

The selected Pi test prefix expressly describes source assertions, actual ECC runner subprocesses and hand-copied behavioral mirrors. The observed helpers confirm that distinction. It would be incorrect either to call the whole suite text-only or to treat a mirror as execution of the original TypeScript adapter. Only1–160 was inspected here; full assertions, test coverage and the real producer/consumer chain remain next work. No test ran. [PI-TEST]

## 4. Cursor scaffolds are operational inputs, not merely examples

All three files under scaffolds/cursor contribute to a concrete configuration: agentDataHome, a sessionStart hook command and an alwaysApply rule describing the data location. The selected install-executor source contains both addCursorAgentDataScaffoldOperations and its real call from planCursorLegacyInstall. It creates copy/merge operations and copies named hook/helper dependencies. The source is therefore connected to an actual installation planner rather than merely mentioned in prose. This does not certify every installed dependency or all alternative install routes. [SCAFFOLD-CONFIG, SCAFFOLD-HOOK, SCAFFOLD-RULE, INSTALLER]

The complete cursor-session-env hook returns an env object and explanatory context. Its helper resolves an explicit ECC_AGENT_DATA_HOME first, then a project setting constrained to the allowed default Cursor/Claude data roots, then a harness-sensitive default. Project configuration is not allowed to redirect freely to an arbitrary location; an explicit environment override is treated differently. These are real configuration-policy distinctions. [CURSOR-ENV, DATA-HOME]

Calling the result isolated memory must retain its object. The default separates Cursor's ECC data location from Claude's default; it does not create a distinct OS identity or prove that every later reader, installed hook, concurrent session and memory mechanism uses that root. The separately studied Vault has its own project/team/user scope contract. Actual host propagation and the shared utilities' downstream reads must be recovered before those two meanings are merged.

Thus this subtree is a material continuation point, not a reason to start a Cursor product study. The correct next question is source configuration → installation/dependencies → host-returned env → later ECC producers/readers, with the original installation and memory evidence reused rather than duplicated.

## 5. Docker is a setup test environment with distinct evidence objects

The complete docker subtree contains one plugin-setup dossier. Compose defines restricted test services: pinned base-image references, non-root configuration, read-only source mounts, temporary writable areas, dropped capabilities and default network_mode:none. A separately selected networked service changes the network setting. Docker's official service contract supports the narrow meaning of none/read_only; reading the YAML does not verify a running kernel, mounted paths or actual isolation. [D-COMPOSE, D-IMAGE, DOCKER-DOC]

The actual command path makes the role clearer. run-real-cli copies a supplied project into a disposable workspace, initializes local Git if necessary and offers four modes. dry-run/install prepare a tarball from the mounted ECC checkout, extract it, validate selected package/bin/manifest properties and invoke the packed public ecc entry. The plugin mode instead launches Claude against the mounted checkout via --plugin-dir; shell opens an interactive shell. These are different source/artifact paths, not one test of every delivery channel. [D-RUN, D-PACK, D-RESOLVE]

The dry-run verifier checks the reported target, dryRun field, install root and operation destination paths. The shell also checks that .claude was not created. These predicates do not compare a complete before/after filesystem or establish the model's behavior. In particular, that existence check is not a general unchanged-directory test for arbitrary input projects that already contain .claude. The install mode checks an install-state path and calls reinstall/list/doctor; it does not submit a software task and validate its outcome. [D-VERIFY, D-RUN]

There is a concrete environment-identity qualifier: Dockerfile supplies sql.js1.14.1 globally, while this pin's package.json declares1.14.2. No installed dependency resolution was observed. The image recipe is therefore not, by its existence alone, evidence of testing the exact declared dependency set. Likewise, a pinned image reference and package version are not complete reproducible-build or registry-provenance evidence. [D-IMAGE, PACKAGE]

The fixture wrapper checks uid/gid1000:1000 and invokes a runner listing three installation test files with failure propagation. The interactive-plan helper validates its arguments and emits an executable-plus-argv object; it does not start or authenticate the named container. All nine files are read, but referenced test bodies and actual Docker execution retain their original/unperformed scopes. [D-FIXTURE, D-PLATFORM, D-INTERACTIVE]

The useful disposition is positive and bounded: ECC contains a deliberate environment for testing installation/packaged-entry behavior. It is neither an ignored cosmetic folder nor proof of a deployed universal sandbox for user work. No Docker build, image download, shell/host/model launch or fixture execution occurred in this research.

## 6. The broad-guide challenge and its limits

The complete longform Markdown text discusses context files, dynamic prompt injection, persistence/learning hooks, model/tool economics, checkpoint and continuous evaluation, parallel worktrees, iterative retrieval and file-mediated phases. Those roles already appear in the provisional system and original mechanism notes. The guide emphasizes procedures performed by users and host agents; its examples do not establish a hidden deterministic controller that joins all ECC subsystems. [LONGFORM, ASSEMBLY]

That is a limited no-new-top-level-role result, not a claim that every guide is now covered. Its images, quantitative recommendations, historical links and external-product claims were not verified. The other broad root documents and consequential mirrors remain O3 in the disposition. A source author's numeric recommendation is not a measured ECC benchmark or our adopted research method.

## 7. Return decision and next work

U19-A meets the predeclared first-pass criterion: original directory identities reconciled, selected ambiguous roots assigned actual roles, a broad textual challenge applied, and exact material omissions identified. The 43-path bookkeeping check does not prove semantic completeness. This same-assistant review is not independent verification, and the challenge was chosen using the existing frontier rather than held out in advance.

**Next selected U19-B / G6 / O1:** Pi discovery/lifecycle → actual ECC hook runner/producer → rule/context state → host consumption and continuation. Begin with the already full .pi bodies and PACKAGE declaration, recover the complete actual test file and named hook implementations, then qualify the relevant host contract at a named version. Reuse original learning/context evidence first. The remaining Cursor/data/generator and broad-document obligations stay explicit; do not turn every host name into an automatic study.

U19-B is NOT STARTED. G6 remains open; final CORE and whole-study project evaluation remain unfinished. G5's bounded answers are not revoked or inflated. No original note/evidence, historical inventory, E06 exclusion, E05 distinction, E10 recovery, METHOD/WHY or agent-control was changed by these findings. No architecture, live integration or upstream patch follows.
