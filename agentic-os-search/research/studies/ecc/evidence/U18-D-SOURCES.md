# U18-D — Itô CLI bridge source ledger

**2026-09-23 · Q02g / MR44.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note43](../notes/43-ITO-CLI-BRIDGE-AUTHORITY-AND-EFFECT-BOUNDARIES.md), [round](../ROUND-U18-D.md), [STATE](../STATE.md). Classes: SOURCE OBSERVATION, TARGET CLAIM/INSTRUCTION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, E11, installation, credential operation, live API/RFQ, purchase or node qualification.

## Exact sources and coverage

ECC paths resolve under [the fixed commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Ranges are inclusive requested ranges; oversized final reads end at actual EOF. FULL means the entire body, not every dependency, host or external service.

| Handle | Path | Git blob | Actual reading / role |
|---|---|---|---|
| BRIDGE | scripts/ito.js | e981d85ee5b7bce339a67c005a46beb949dceca6 | FULL1–240,241–500/EOF. Main, command/JSON/dry-run parsing, evals preconditions, realpath/layout/readability, same-Node invocation, environment/output/status and exported helpers |
| ENV | scripts/lib/ito-environment.js | e9a6c909c466c759bc50e73e32e5f23e13f4474b | FULL. Command classifier, OS/runtime/evals/control allowlists and immutable helper output |
| CLI | scripts/ecc.js | 6c2aee1a5826475bfd05552a1bc485b35295bf9a | REUSED full same-conversation1–300,301–450/EOF from U18-C. Public first process boundary, shared environment filter with controls retained, cwd/stdio/output/status. Not a newly performed full reread |
| SKILL | skills/ito-compute/SKILL.md | 4970a757b6075d1ce12043ba3c73e0bdea52f1ed | FULL1–220/EOF. Authored acquisition, buyer authority, RFQ constraints, reconciliation, CLI accept step, four-tool MCP and qualification procedure |
| DESIGN | docs/design/ecc-ito-compute-integration.md | c346428a913613183bc6a5eb1d7578d6666b8dab | FULL1–240/EOF. Six-verb/three-tool boundary, external responsibility, state/retry and future-serving requirements. Future requirements are not current controls |
| T-BRIDGE | tests/scripts/ito-cli-bridge.test.js | e6e4c7d2c32bbd6a25fc032f5d5af6ac9bbd3aba | FULL1–230,231–460,461–730/EOF. Actual public CLI/child probes, environment/argument/exit/login-output tests, precondition refusal and PATH/shim/decoy counter-tests. NOT RUN |
| T-SKILL | tests/ci/ito-compute-skill.test.js | eb1953debe4788cc7d9e517dfe47fe3addc05880 | FULL1–240/EOF. Text/JSON assertions for six CLI strings, four MCP names, manifests, package surface and template. Does not compare complete documented verb set to bridge allowlist. NOT RUN |
| MCP | mcp-configs/mcp-servers.json | f3d607bd719ebfb44e3b0e6be5acc4734ee65edf | FULL1–240/EOF. Itô template launches node/absolute ito-mcp.js directly, description includes ito_accept; user-selected copy guidance. Reading other entries is not independent product qualification |
| NEXT-NASIKO | scripts/nasiko.js | 71a240878253f4fe9702eeb7cf3f1c9a19c3ea75 | SELECTED1–80 only. nasiko-release helper imports, pinned install/status/uninstall help, flags and executable lead. Next-work qualification, not completed acquisition/lifecycle inquiry |

The earlier BRIDGE1–70 next-work prefix is superseded by this full body read, not a second independent source. Prior package.json selected ranges/bin mapping remain recorded in U18-C, not upgraded to a full package or tarball audit here. No external Itô repository implementation body or installed client was read.

## Claim-to-chain bindings

1. **Actual process and responsibility:** CLI routes to BRIDGE with a filtered control-bearing environment; BRIDGE main parses then resolves and invokes the final client with another filter. Local refusal precedes final-client execution, not necessarily the already-started bridge process. No second API/economic store is implemented in the complete BRIDGE.
2. **Executable identity:** resolveItoExecutable→realpath→canonical suffix→regular/readable file→process.execPath/shell:false. Useful avoidance of PATH collisions and shebang shims does not read origin, revision, digest or signature. T-BRIDGE's ordinary fixture supplies harmless arbitrary probe bytes under the admitted suffix; negative fixtures lie outside it. This is layout/admission evidence, not authentic external-client provenance.
3. **Environment scope:** ENV uses explicit OS plus command-specific key groups. Login/logout exclude API key; auth/find/status include it; evals receives only its named credential group beyond OS variables. CLI retains controls for BRIDGE, final invocation omits them. This is inherited-variable minimization, not filesystem/UID/Keychain containment. No secret store was inspected.
4. **Authority and arguments:** SKILL requires buyer authority and full RFQ constraints. BRIDGE forwards non-evals arguments, and T-BRIDGE expects a find-without-constraints probe invocation. This demonstrates local forwarding, not real client acceptance. Evals checks opt-in/required arguments/config-file presence but does not parse/bind YAML, authenticate nodes/authority or verify the external sixtytwo version.
5. **Entry-dependent coverage:** exported invokeIto calls buildInvocation and environment filtering without parseArgs/evals validation. Main has those checks. SEARCH did not establish a real additional direct helper caller; custom API users cannot automatically inherit main's guards.
6. **Same-pin accept mismatch:** SKILL prescribes ecc ito accept, while BRIDGE's allowed verbs exclude it; ordinary invocation is rejected before final executable resolution/spawn. DESIGN/help describe three MCP tools; SKILL/MCP/T-SKILL describe four including ito_accept. MCP directly launches another entry, outside the bridge. No claim that the real external MCP/server lacks accept follows.
7. **Oracle limitation:** T-SKILL checks six required CLI strings and selected forbidden patterns, not equality of the complete verb sets. T-BRIDGE tests several unsupported verbs but not the documented accept transition. A matching string is not proof that its actual command is admitted. Other tests elsewhere are not claimed absent or green.
8. **Output and failure:** BRIDGE propagates normal output/status, streams login by inherited stdio and buffers other routes. Its evals timeout and maxBuffer are concrete options. NODE establishes that errors can arise after start and timeout can wait for exit; BRIDGE's generic could-not-start wording does not prove no effect. SKILL/DESIGN status-before-retry is valuable procedural recovery, not an implemented durable idempotency/receipt layer.

## Test and inference limits

The full bridge suite creates a temporary executable-shaped probe and runs ECC's public entry through child processes. It asserts actual argument/environment/output boundaries and absence of a probe marker for selected refusals. Its fixture is not the external Itô package and uses no live API, RFQ, browser or GPU node. The timeout test checks a constant and source pattern, not actual elapsed termination. The skill suite checks authored text and declarations, not an installed server or verified service behavior.

No target tests or functions were executed in this unit. The accept rejection, suffix/provenance and post-start-error counterparts are source deductions. There is no measured failure rate, observed credential theft, malicious deployment, ambiguous RFQ or real timeout in this evidence. No E11 was opened and no previous experiment was rerun. Q02g2 carries stronger operational and external obligations.

## Search / acquisition scope

An initial guessed tests/scripts/ito.test.js path returned404. This did not establish test absence. A clipped tests directory listing and default-branch searches located the actual sources. SEARCH includes ECC_ITO_CLI_EXECUTABLE (topn12) and invokeIto (topn8), scoped to affaan-m/ECC, returning default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735. These are discovery only; every new substantive body above was fetched at the research pin. No exhaustive fixed-pin caller inventory is claimed.

One auxiliary working-container curl acquisition of the research catalogue failed DNS with curl6 and yielded no file. It was publication-source acquisition, not an Itô call or target experiment. No target execution depends on a local copy. Connected GitHub remained available.

## Narrow external primary contract

NODE: https://nodejs.org/api/child_process.html — checked2026-09-23, especially spawnSync options/return and timeout behavior. The page displayed Nodev26.10.0; this is documentation identity, not the installed ECC runtime. It documents errors on failure/timeout, buffer-limit termination/truncation, and timeout signaling followed by waiting for child exit. Used only to qualify the wrapper's process-error and timing claims. Unrelated search hits were not used. Actual runtime/platform/client conformance, remote effects and external package availability remain unverified.

## Work and publication provenance

Fresh main f9af636b differed from the previous handoff only by an unrelated soul-context WORK change. Canonical AGENT/R01/R02/R03 were fetched fully; remaining routed controls and full project recovery reads from this conversation stayed active. [U18-C alignment](../PUBLICATION-U18-C-ALIGNMENT.md) records current permission on the same route, rejected12bb6222, accepted42428b11, force=false update and main-row readback. It resolves the previous catalogue gap without rerunning Note42.

MR44 opened33acbea20886564dcfd66ce1ca04bfa5144074a3. STATE activation03a3bca1aff5118efcb825b42b49b1e54db506b2 was fully read back as0072eb096950c6a54257550ebf0797f719faf130 before source inquiry. Note43 creation47fef6c8e38fe2230526f226e971eb388074ad43 is a source-publication step, not final checked closure. Actual note/ledger/entry/catalogue/receipt/STATE checks follow.

Original Notes01–42, evidence/experiments/E06 exclusion/E05 distinctions/E10 guarded recovery, METHOD/WHY and unrelated project/control files remain outside this unit's mutation scope. Next U18-E/Q02h Nasiko is selected only; source claim, adoption and real service operation remain separate.
