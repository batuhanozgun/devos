# U19-C — Cursor deployment/data-root source ledger

**2026-09-24 · G6 / O2 / Q01a2c / MR52.** [Note51](../notes/51-CURSOR-DEPLOYMENT-DATA-ROOT-AND-CONTEXT-HANDOFF.md), [round](../ROUND-U19-C.md), [STATE](../STATE.md). Fixed target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. SOURCE OBSERVATION, original-research recovery, TEST SOURCE INSPECTED and conditional INFERENCE are distinct. No target import/function/test, installation, Cursor/model/MCP, user configuration/credentials or E11.

## Recovery and original research

Initial main matched the preceding checked U19-B closure `d5155587ae1b127c3e50a4a3d4fd23d930b30949`. STATE was freshly fully read. Fresh AGENT was unchanged; full same-conversation R01–R09 and current research routers, WHY/METHOD, PLAN0.52, META/INDEX/QUESTIONS and U19-A/B result/ledger/publication context were reused at their recorded identities. This is not a fresh reading of every upstream dependency or an independent cold-start test. Control files are not research evidence.

Fresh FULL research reads at that commit:

| Handle | Path relative to this study | Blob / relevance |
|---|---|---|
| N02 | notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md | 786514f0fc6cd4287b1a1197eb32ac5c4081ffc8; different channels and materialization |
| N03 | notes/03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md | 06077976b0ba350adc0b07e35f6e4c3f3f680703; common guard/checkpoint versus guided ownership |
| N37 | notes/37-MANAGED-MAINTENANCE-OWNERSHIP-AND-PREVIEW.md | 82d9fab2f5f9e3eaa84d7a80a6019e348d852d25; recorded-content health versus desired/active capability |
| N38 | notes/38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md | f2879c7f94dc11c839d45351d40d2275a1521477; array/JSON merge, separate ownership paths |
| N07 | notes/07-OBSERVATION-INSTINCTS-AND-BEHAVIORAL-CONTEXT.md | d0fd71399bd1915d16bcb057c07d2a07ff20c24a; agent-data/instinct/learned/Vault distinctions |
| NEXT-LEDGER | evidence/U18-I-SOURCES.md | ab3f68ae5ac4c90ce069ed264d809a0d0db176a3; preserve answered MCP chain while locating remaining non-MCP sync/generator work |

Note49/U19-A ledger/omission review and Note50/U19-B ledger remain original full same-conversation inputs. Note49's planner-call observation is refined by the newly recovered public caller, not silently rewritten. The prior Vault and learning notes retain their original evidence classes and scope; this is not a new all-memory audit.

## Fixed-pin ECC reads

All paths below resolve under https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a. FULL means complete text through EOF, not every transitive dependency or actual execution. Requested final ranges extending beyond EOF add no content.

| Handle | Path | Git blob / actual reading |
|---|---|---|
| ENTRY | scripts/install-apply.js | 1435d2ff665b0595f490afd211fc0295b40d0842; FULL1–260/EOF |
| REQUEST | scripts/lib/install/request.js | f99f5aba1e1fe2b8bd6dfa0c499f22cacdefbf08; FULL1–250/EOF |
| RUNTIME | scripts/lib/install/runtime.js | eabb930b26a8f85f26768de2d65036cc7f1c7b46; FULL |
| LEGACY | scripts/lib/install-executor.js | 72eac5e8a9868ac1632121977c1281c026afe50b; FULL coverage completed: retained U19-A1–240/241–460 plus fresh461–800/EOF |
| RESOLVER | scripts/lib/install-manifests.js | bb16cc93c89bbda4c2c4f493baeab6188d6985eb; FULL1–250/251–500/501–759;760–1100 empty |
| REGISTRY | scripts/lib/install-targets/registry.js | 8dd7cf848810c1512dff72fdae4841563dea5d58; FULL |
| CURSOR | scripts/lib/install-targets/cursor-project.js | 81e71aefd0b2cf25efc7394dce2cc5983fa8028d; FULL |
| HELPERS | scripts/lib/install-targets/helpers.js | f69d75e86bab0276eee66359366096d1c38f2441; FULL1–280/281–620/EOF |
| PLAN | scripts/lib/install/plan.js | 1400557c79566f059b89b4b065c13d80f5d473e4; FULL1–270/271–650/EOF |
| APPLY | scripts/lib/install/apply.js | fbab1293bb8dcdebb1df4a23556f06419bd290ec; FULL1–300/301–640/641–850/EOF |
| CONSENT | scripts/lib/install/hook-consent.js | 883c121d70ab6aae6858e45db977f3afd8a518bf; FULL1–340/EOF |
| MODULES | manifests/install-modules.json | 884c7d39d867dd882ba097bcaab9dd2696ed1a5e; SELECTED1–240. Complete relevant core/hook/platform entries; not all modules |
| NATIVE-CONFIG | .cursor/hooks.json | 9c3f9d23b5022dc597f4f81adfea721923f2da52; FULL |
| C-ADAPTER | .cursor/hooks/adapter.js | 8ac8d298c62e6b8572255a9bce6881baadaf28e0; FULL1–280/EOF |
| C-START | .cursor/hooks/session-start.js | b3626af2e12a708d077fc5f2fd9bf94beb22be21; FULL |
| C-END | .cursor/hooks/session-end.js | 3dde321f21ca20b040d69294fbd6e7fb79d0703c; FULL |
| C-STOP | .cursor/hooks/stop.js | a6cd74c02fbb0bbb0b15812de3b3774c4da6d4ea; FULL |
| S-START | scripts/hooks/session-start.js | 63854aff1c2efeaaa82fbf05886dadbd791a048e; FULL1–240/241–490/491–850/EOF re-entry |
| S-END | scripts/hooks/session-end.js | 9709aa95a65ef10db1b18173565ca35fcc1ccb21; FULL1–290/291–590/EOF |
| UTILS | scripts/lib/utils.js | 5e29868eb51663c75122297e9062b5a9d027da73; SELECTED1–340, complete root/directory/session-ID getters; not full utilities |
| OBSERVER | scripts/lib/observer-sessions.js | 08296da3a4ade8c86ae2c3fdfd5b22937f34ab11; FULL1–300/EOF re-entry |
| T-DATA | tests/lib/agent-data-home.test.js | f5f72fc358ba18d0bce621923afa7de6deadd2fb; FULL1–260/261–570/EOF; inspected, NOT RUN |

Twenty full/completed-full target bodies, including the one test file; two selected bodies. This is a reading record, not a completeness score. The old full LEGACY prefix and the five unchanged U19-A inputs below are reused explicitly rather than counted as newly read.

| Reused handle | Path | Blob / prior scope |
|---|---|---|
| SCAFFOLD-CONFIG | scaffolds/cursor/ecc-agent-data.json | a39a46ed9e5fcf21b2e4bde0730233d65dbd2b07; FULL U19-A |
| SCAFFOLD-HOOK | scaffolds/cursor/hooks.json | f4e389e8a4fe8afe41179ddf546fd47a4f03cc42; FULL U19-A |
| SCAFFOLD-RULE | scaffolds/cursor/rules/ecc-agent-data-home.mdc | c7e2b6085b6f2010893ca28ca6cc5b01eea05d23; FULL U19-A |
| ENV-HOOK | scripts/hooks/cursor-session-env.js | e5fe360fff7322923d966d5867c3d6ecfc9a7797; FULL U19-A |
| DATA-HOME | scripts/lib/agent-data-home.js | 7302bd572ca183aef2ae33160cc5c672d7365539; FULL U19-A |

The selected common writer imports llm-summary; its full implementation, provider execution and all other learned-data writers were not audited. The root policy delegates containment to path-safety; no universal filesystem safety claim follows from the helper call or test definitions. Existing original ownership/projection/learning evidence retains its scope.

## Metadata, discovery and acquisition

The direct .cursor tree `2fddacadc2bb2b78b792ac8363d2a190b4c05cb1` was read completely with truncated:false: hooks.json plus hooks/rules/skills trees. This establishes the native root entries, not a recursive body audit. Direct tests tree `2e4ba12d4f37a6faaad81657c6fa0c2e2b33fb05` was visible through its complete primary array/truncated:false; duplicate response content clipped. A tests/hooks tree request `384bf7418008a8b044dc3c58a441998f89094943` yielded only a clipped view used for navigation, not complete inventory coverage or a no-test assertion.

Connected searches getSessionsDir/getLearnedSkillsDir, agent-data-home, transformToClaude and cursor/adapter/test returned newer default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735 paths. They were navigation only. transformToClaude+assert returned no hits; that is not evidence that all adapter tests are absent. Additional discovered test files were not read and are not represented as part of T-DATA's coverage.

An initial guessed cursor.js adapter path returned404; REGISTRY supplied the actual cursor-project.js path. No missing-adapter finding relies on that404. An auxiliary raw-source acquisition failed DNS and supplied no source file; connected GitHub provided the actual bodies. Local acquisition staging did not import or execute ECC.

## Official host interface

**D-CURSOR:** https://cursor.com/docs/hooks, checked2026-09-24. Selected project-hook cwd, common inputs, sessionStart/sessionEnd/stop and environment-variable sections; not a full host/security or cloud-mode audit. The retrieved page describes JSON stdin/stdout, project-root execution, env available to later hooks and additional_context, CURSOR_VERSION/CURSOR_PROJECT_DIR and the CLAUDE_PROJECT_DIR alias, plus startup's nonblocking nature. These are current documentation contracts, not a named installed version or historical conformance evidence. Repeated page sections are not independent sources.

Current documentation's cloud/lifecycle differences prevent an all-application generalization; the detailed cloud path is not a new study. No Cursor installation, credentials, transcript capture or real callback was used to validate the documentation.

## Claim-to-chain bindings

1. ENTRY→REQUEST returns manifest/legacy-compat; RUNTIME→LEGACY's compatibility function→PLAN→RESOLVER→CURSOR is the ordinary route. The separate legacy branch remains real for explicit callers. Note49's existence observation did not establish ordinary CLI selection.
2. MODULES/RESOLVER→CURSOR/HELPERS→PLAN/APPLY yield native wrappers under P/.cursor/hooks and common scripts under P/.cursor/scripts/hooks. C-ADAPTER instead looks under P/scripts/hooks. Consent and valid fresh destination are explicit counterpart assumptions; source-checkout execution is a positive alternative.
3. C-START/C-ADAPTER move event metadata into _cursor and discard child stdout. S-START then skips historical-summary injection for the unrecognized envelope, while other work can occur. A reachable child still lacks the wrapper's result-to-additional_context bridge. These are separate input and output joins, not one observed failure.
4. DATA-HOME→UTILS→S-START/S-END establishes real root-dependent reads/writes. Inherited Cursor markers can select the correct root without ENV-HOOK. Intentional sharing, cross-root migration and OS isolation are separate; OBSERVER has its own root. No all-memory contract is inferred.
5. Explicit old LEGACY copies three named files; DATA-HOME imports path-safety not copied by that builder. APPLY's array replacement also changes the scaffold/native sessionStart combination. These findings are not generalized to manifest hooks-runtime's full shared library copy.
6. C-STOP invokes the session summary writer, C-END the marker. S-END can write a placeholder without usable transcript and has a conditional LLM-summary branch. S-START has matching/placeholder checks. File presence is not useful recalled context or host uptake.
7. T-DATA directly tests resolver configuration/paths with temporary files and environment changes, including allowed sharing and unsafe cases; some symlink cases skip when unavailable. It neither applies the chosen normal installation nor consumes its installed callback output through Cursor. No test was executed or claimed to pass.

## Work provenance and disposition

MR52 opening `3cdc5efe6dbd38dee141a0f26c19dec7fb08e304` preceded activation `8851593930b5839345babe546be1a5bb2403ddfe`, fully read back as STATE `78e5e6503f8134fa62afaa806a40e614a8f2373f` before source inquiry. Note51 created `6449ecd897b4071688aec69473c5add0c18bfaea`; creation alone is not publication verification.

Q01a2c is source-answered at the selected deployment/data-root/context scope; stronger c2 remains. Next U19-D is the remaining non-MCP legacy Codex baseline/generator/validation reconciliation, NOT STARTED, beginning from Note48/NEXT-LEDGER and the actual sync/checker. Other O2 variants, O3 broad documents, CORE and joint evaluation remain open. No target execution/E11 or independent Cursor product study. Preserve original notes/evidence, METHOD/WHY, historical inventories, E06 exclusion, E05 distinction, E10 recovery and unrelated/concurrent work. Entries, actual diff/readback checks, receipt and final STATE own checked closure.
