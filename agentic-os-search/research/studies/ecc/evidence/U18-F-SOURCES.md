# U18-F — NanoClaw source ledger

**2026-09-23 · Q02i / MR46.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note45](../notes/45-NANOCLAW-CONTEXT-REPLAY-AND-SESSION-CONTINUITY.md), [round](../ROUND-U18-F.md), [STATE](../STATE.md). Classes: SOURCE OBSERVATION, TARGET INSTRUCTION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, E11, actual Claude/model/provider call, user-history mutation or installation.

## Exact corpus and reading

ECC paths below are at [the fixed commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Inclusive requested ranges may end at actual EOF. FULL describes the file body, not external implementations or all dependencies.

| Handle | Path | Git blob | Coverage / use |
|---|---|---|---|
| CLAW | scripts/claw.js | 982ce5c22cdc8ec77ebcf4fac58fdfc8786f98b7 | FULL1–230,231–500/EOF. Session/context/prompt/process helpers, parser/metrics/search/compaction/export/branch and complete interactive main |
| TEST | tests/scripts/claw.test.js | b4c0da0b40cb4930f4f3102dcbe3f2f160902027 | FULL1–240,241–500/EOF. Filesystem/helper tests and real askClaude call with nondiscriminating string oracle; inspected, NOT RUN |
| SKILL | skills/nanoclaw-repl/SKILL.md | 3d162bb5b0bfe62ad6a13e2cda8440ed6075e6ca | FULL. Capabilities, branch/compact/export guidance and extension contract |
| SHIM | legacy-command-shims/commands/claw.md | 6086abdffc53780fe01a997a56991fecc01ff371 | FULL. Maintained skill/script/npm routes and separate long-running-orchestration responsibility |
| PACKAGE | package.json | 87487a914c0fd739ea62107e7bf9e56b127207a5 | FULL1–180,181–470,471–650/EOF. files/bin/scripts/dependencies; claw npm script and alternate dashboard entries. Not tarball/registry evidence |
| CLI | scripts/ecc.js | 6c2aee1a5826475bfd05552a1bc485b35295bf9a | Fresh SELECTED1–190: full command table, primary list and help prefix; previous same-conversation full body and U18-E dispatcher read retained. No claw command in this table |
| COMPAT | skills/autonomous-loops/SKILL.md | b6c64c2af3d52d325a12181888c0dac4fec4fb5e | SELECTED1–170 only: compatibility notice, spectrum, sequential pattern, complete NanoClaw subsection and start of next pattern. Not full skill or canonical successor audit |
| NEXT-DASH | ecc_dashboard.py | b7e3f93f562775958190c0839c4e371bf589cf57 | SELECTED1–100 only. Tkinter requirements, alternate browser reference, ecc_dashboard_runtime imports and start of component discovery. Next selection, not a GUI/action result |

Five new complete target-file reads, two selected target re-entries and a selected next-source prefix. Earlier CLAW prefixes are superseded by the full body, not independent evidence. The explanatory pause exposed the invocation options but not result/REPL closure. No Claude implementation, installed binary, native transcript, account, model or user filesystem was inspected. The complete test file is its standalone test entry; this unit does not claim a fresh run-all/CI-wrapper audit.

## Claim-to-source bindings

1. **Native entry and loop:** PACKAGE scripts.claw and SHIM lead to CLAW; CLI has no claw table entry. main reads prior history before User append, constructs stdin, waits for askClaude, stores returned text and asks again. It does not implement a scheduler or multi-agent controller.
2. **Context recovery:** CLAW's home-scoped named file is not project-scoped. model/skills are initialized from environment and changed in memory, not serialized. cwd determines skill files; reads catch missing/unreadable errors and exist-based counts differ from successfully included bytes. NPM qualifies package-root launch behavior.
3. **Host boundary:** one labeled text prompt, optional model and -p, without native resume or system-message flags. CLAUDE documentation distinguishes those interfaces. Node environment, command lookup and Windows shell remain actual host conditions; the variable model argument is not protected merely by a fixed command name.
4. **Outcome projection:** result.error becomes text; nonzero status requires nonempty stderr to receive an error qualifier. main saves either form as Assistant. User/Assistant appends and external effects lack an atomic attempt/recovery record. No actual failed provider return is alleged.
5. **Representation counterpart:** appendTurn does not escape the parser's newline/horizontal-rule delimiter. A multiline Assistant body with an internal delimiter can remain raw but lose its suffix in parsed export/compaction. TEST's simple payloads do not discriminate this case.
6. **Prefix cap and compaction:** parseTurns takes the first5,000,000 JS string units; compactSession retains a suffix of that parsed prefix and overwrites the full file when its threshold passes. Newest records beyond the cap can be removed. The cap is not a prompt budget. Default20 counts message records, not exchanges or a semantic summary.
7. **Branch/export controls:** valid name does not imply unused destination; copying history does not snapshot project files or native host state. Raw MD and parsed JSON/text exports differ; explicit destinations can alias the session. Default MD exports are discoverable by the broad .md listing despite dotted names being invalid for startup.
8. **Oracle/side-effect scope:** TEST directly invokes askClaude; actual response and infrastructure error both satisfy its nonempty-string predicate. No fake client is installed by the test. Context early-return skips are counted as successful wrapper returns. Local utility tests do not test the entire REPL/restart/large-history/error pipeline.

The delimiter, prefix-cap, setting-loss, existing-branch overwrite and result-projection counterparts are conditional code-path deductions. No exploit, compaction, branch, export, live model action, measured loss or failure rate was observed. Q02i2 retains stronger runtime/host/security/recovery/efficacy obligations.

## Narrow external primary documentation

Checked2026-09-23, selected contracts only:

- CLAUDE: https://code.claude.com/docs/en/cli-reference — print/piped input, continue/resume, model and system-prompt controls. Used to classify the supplied interface, not certify installed behavior or quote a current model/version recommendation.
- NODE: https://nodejs.org/api/child_process.html — spawnSync input/result/options, buffer/timeout and shell-argument warning. Page displayed Nodev26.10.0; that is documentation identity, not a pinned ECC runtime.
- NPM: https://docs.npmjs.com/cli/v11/commands/npm-run/ — package-root cwd, INIT_CWD and npm script behavior. Page displayed npm11.19.1; no npm command or registry query was executed.

The initial web search returned irrelevant results, which were not used. Direct official pages supplied these narrow contracts; the initial npm-run-script URL failed before npm-run succeeded. No broader provider/product study was opened.

## Discovery, acquisition and work provenance

Connected GitHub searches claw(topn12) and compactSession(topn6), scoped to affaan-m/ECC, returned default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735 leads. The first response was clipped; neither search is an exhaustive fixed-pin inventory. Every substantive target file was then read at the fixed pin.

The project inventory/U15-A-COVERAGE-RECONCILIATION.md was fully reread1–170/EOF at recovery mainc2f1788c, blob7ff883382314b6c7838cadec44ed432a5e6db4b9, solely to reassess G5 sequencing. Its historical labels are superseded by STATE/PLAN. It retains the separate Python dashboard/runtime-helper and MCP obligations. NEXT-DASH qualifies U18-G/Q08d, not a completed inquiry.

One auxiliary working-container attempt to retrieve the exact research CATALOG raw bytes failed DNS (urllib URLError, errno-3) and created no source file. It was publication-source acquisition, not target execution. Connected GitHub remained available. An empty working directory is not a research artifact or evidence bundle; no E11 exists.

Fresh AGENT matched the existing router and fully read same-conversation protocols remained active. Fresh main-ref recovery returnedc2f1788cc1a6a7b3b0f4e149d08e6ff7e9721c67. MR46 openedc5bcfd54e3e66c97290feeed1e8208a7d5102872; activationc5e3dd68fba38b3b47c25188a3983f5874062130 was fully read back as STATE31eadc2b3d3e128458bbb42f9d0b3eb663783cce before inquiry. Note45 creation7ce22d478071be0863e7677bae280e2d648736d6 is not publication closure; actual readbacks, entry/diff/catalogue/receipt and final STATE follow.

Original Notes01–44/evidence, METHOD/WHY, historical inventories, E06 exclusion, E05 histories, E10 recovery and unrelated project/control files remain unchanged. No branch/PR, upstream change or adoption is implied.
