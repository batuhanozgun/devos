# Note43 — Itô CLI bridge, authority and effect boundaries

**2026-09-23 · U18-D / G5 / Q02g / MR44 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-D-SOURCES.md), [round](../ROUND-U18-D.md), [STATE](../STATE.md). Original source, authored procedure, inspected test definitions and explicit conditional inference. No target execution, E11, credentials, installation, live API/RFQ, purchase or node qualification.

## 1. A real process bridge, not an embedded compute platform

ECC's public dispatcher sends `ecc ito` to scripts/ito.js using the current Node executable. The bridge parses a limited command surface, selects an explicitly configured local JavaScript entry and starts that entry as a subprocess. It forwards arguments, a command-specific environment and process output/status. It does not implement its own RFQ API client, economic store, quote evaluator or reservation workflow in this source. The human or originating agent follows the installable skill; the external Itô client implements the delegated service interactions. [CLI, BRIDGE, ENV, SKILL]

The chain is:

`operator/agent instruction → ECC public CLI → filtered bridge process → local validation → configured external-client entry → client-owned service operation → output/status → caller interpretation/reconciliation`.

There are two actual child boundaries in the public route. scripts/ecc.js first filters the environment with controls retained and launches scripts/ito.js; the bridge filters again for the final client without retaining those ECC control keys. Rejecting an invalid operation before the external client starts does not mean the public dispatcher created no bridge process at all. The separate direct-script entry begins at the second stage. [CLI, BRIDGE, ENV]

This adds a different relationship from Note41's HTTP reputation lookup and Note42's catalog advice: a selectively admitted, credential-bearing local execution dependency. The bridge is operational code, but its existence is not proof that a particular external client, account or remote outcome has been qualified.

## 2. Executable selection is meaningfully restricted, but provenance remains operator-owned

The main route requires ECC_ITO_CLI_EXECUTABLE. It rejects an absent or relative override rather than looking up an `ito` executable on PATH. It resolves the path through realpath, requires the canonical trailing segments `cli/ito-compute-cli/dist/bin/ito.js`, and checks that the resolved object is a readable regular file. It starts that JavaScript file with process.execPath and shell:false, avoiding a shell wrapper or a shebang interpreter selected through PATH. These are useful defenses against accidental executable-name collisions and differently shaped shims. [BRIDGE]

The check does not read package metadata, a repository remote, a commit, a signed release or a file digest. The prefix of the path is unrestricted; the suffix proves a layout, not origin or reviewed bytes. A symlink resolving to the required shape is not categorically rejected. The resolved name is subsequently opened by Node; there is no retained descriptor/digest binding between the earlier check and execution. Actual replacement/race exploitation has not been observed here.

The upstream test fixture makes this boundary especially clear. makeItoProbe writes a new harmless JavaScript probe under the required directory suffix, without constructing the real external package or its history. The ordinary forwarding tests expect that probe to execute and receive selected environment variables. In contrast, separate negative tests create a PATH collision, an absolute shim and a JavaScript decoy outside that suffix, and assert that their marker files are absent. The useful tested distinction is explicit path/layout admission versus excluded discovery forms, not genuine-client provenance. The fixture is not a malicious deployment or proof of credential theft. [T-BRIDGE]

The skill and design document tell the operator to build from the named repository and run npm ci/check. That is a procedural acquisition responsibility, not a verification performed by the bridge. The external repository is named but not pinned by ECC's validator. The same path can later contain different bytes. Claims that a particular client is authentic or compatible need additional source/build/environment evidence. [SKILL, DESIGN, BRIDGE]

## 3. Environment minimization is not isolation from every credential source

The environment helper constructs a new allowlisted object rather than copying all inherited variables. It retains selected operating-system/terminal variables and string-valued LC_* entries, then chooses one of two command-related groups. [ENV]

| Route | Explicitly forwarded credential/configuration class |
|---|---|
| login / logout | Itô endpoint/auth/file-token settings, but not ITO_API_KEY |
| auth / find / status | The Itô runtime group, including ITO_API_KEY when configured |
| evals | Explicit live opt-in, SIXTYTWO_API_TOKEN / SIXTYTWO_TOKEN and SSH agent variables; no Itô runtime group |
| Unknown command prefix in the helper | Neither credential group; the public parser separately rejects unsupported commands |

The public dispatcher uses the same command classifier and helper, retaining ECC_DRY_RUN, the executable override and NODE_ENV only for the bridge. The final client receives a fresh mutable copy of the helper's frozen result, not those controls. Model/cloud secret variables and arbitrary ITO-prefixed variables do not pass merely because they exist in the parent's environment. The tests inspect the actual probe environment for both retained and excluded values. [CLI, ENV, T-BRIDGE]

These controls minimize inherited environment data. They do not create a filesystem, OS-user, network or Keychain sandbox. HOME and ordinary process context remain; the code introduces no separate user identity or filesystem containment. The intended client may retrieve a device credential from its own store. Removing ITO_API_KEY from evals is therefore an explicit-variable guarantee, not proof that arbitrary code at the admitted path cannot reach any credential by another means. Likewise, forwarded endpoint/token-file settings are not locally authenticated endpoints or permission-checked token files. Those responsibilities are delegated or operator-owned. No secret store was inspected or credential extracted by this research. [BRIDGE, ENV, SKILL]

## 4. Command admission, buyer authority and node qualification are different checks

The ordinary main route accepts exactly login, logout, auth, find, status and evals. It normalizes a single --json flag, rejects multiple copies, refuses ECC_DRY_RUN/--dry-run rather than manufacturing simulated success, and rejects --no-browser specifically on auth. Help short-circuits without invoking the external client. Other arguments are forwarded rather than fully interpreted. [BRIDGE]

The skill requires explicit buyer authority and all topology/economic constraints before find, including the count/topology relation and a deliberate split-fill decision. The bridge does not itself collect or authenticate that authority and does not validate those RFQ constraints. The first upstream forwarding test even supplies find with no economic arguments and expects the probe to receive it. This confirms the intended local forwarding boundary, not that the real external client accepts an incomplete RFQ. Whether a real client refuses it is outside this source result. [SKILL, BRIDGE, T-BRIDGE]

Evals has stronger local preconditions. It requires ITO_ENABLE_SIXTYTWO_LIVE=1, exactly one live flag and exactly one cluster/nodes/config-dir option with a nonempty following value. Node tokens cannot be empty. The config directory must be absolute, resolve to a directory and contain a file named sixtytwo.yaml. Those checks occur before selecting/starting the external client in main. The tests use absence of the probe marker to challenge missing opt-in/flag/nodes/cluster and bad directory cases. [BRIDGE, T-BRIDGE]

The validator does not parse the YAML, bind its contents to approved nodes, validate node ownership, read a grant, check token scope or verify an installed sixtytwo version. fs.stat follows the paths it receives, and the original arguments are forwarded, not replaced by a digest-bound configuration object. The same actor setting the environment and arguments can satisfy the two opt-in predicates; they are separate explicit choices, not evidence of two independent authorizers. The pinned sixtytwo version and restricted remote effects described in help belong to the external-client contract and have not been independently established here. [BRIDGE, SKILL, DESIGN]

Lower-level buildInvocation/invokeIto functions are exported. invokeIto does not call parseArgs or the node-precondition validator. This does not invalidate the checked public main path; it means a custom direct helper caller must not inherit all CLI checks merely by importing the function. No additional production helper consumer was established by the default-branch search. [BRIDGE, SEARCH]

## 5. A same-pin procedure asks for a command the bridge does not admit

The installable compute skill's workflow adds `ecc ito accept rfq_<ticket-id>` after buyer approval. It describes this as desk review rather than a purchase, and lists ito_accept among MCP tools. The actual CLI allowlist at the identical ECC pin contains no accept. Consequently, an ordinary `ecc ito accept ...` invocation reaches the unsupported-command branch before executable resolution or final-client spawn. No external availability or new version is needed to discriminate this source mismatch. [SKILL, BRIDGE]

This is not evidence that the external Itô service or a separately configured MCP client cannot accept a ticket. It is specifically a disagreement between an ECC-authored CLI instruction and ECC's own admitted CLI surface. The rejection prevents the requested transition; the caller cannot treat the described step as an available bridge operation. The underlying cause of the documentation/code drift is not established by this snapshot.

The design document and bridge help retain a three-tool MCP description, while the actual MCP template and compute skill list a fourth, ito_accept. The template invokes `node` with an absolute ito-mcp.js argument directly; it does not route through scripts/ito.js or its environment helper. Accordingly the CLI's executable/path/command/environment guarantees cannot simply be transferred to that host-owned MCP launch. The template describes a requested configuration, not an inspected running MCP server. Real tool schemas, filtering, authentication and acceptance remain external/host claims. [DESIGN, BRIDGE, MCP, SKILL]

The CI test titled as documenting only real commands checks that the six expected CLI strings appear; it does not extract the complete documented verb set and compare it with SUPPORTED_COMMANDS. Its forbidden-pattern list omits accept, and its MCP assertions explicitly expect ito_accept. The bridge suite tests several unsupported commands but not this newly documented accept step. These exact assertions therefore do not test the missing CLI transition, even though both suites contain useful controls. This is an oracle-coverage observation, not a claim that we ran the suites or that all other repository checks pass. [T-SKILL, T-BRIDGE]

## 6. Process output preserves useful evidence but does not prove a remote effect

The bridge passes through the child's stdout/stderr and normal numeric exit status without inventing a success result. Device login inherits stdio through both public layers, allowing interaction while the child is running; other commands are buffered. A probe test checks login's first output before its delayed exit; another checks propagation of exit7 and both output streams. These are test definitions, not executions in this study. [BRIDGE, CLI, T-BRIDGE]

The child receives a 10MiB output cap; evals additionally receives a 31-minute timeout setting. Other commands have no bridge-supplied timeout. The timeout test asserts the constant and a source regex, not elapsed termination. Node's contract says spawnSync can report an error when the child failed or timed out; its timeout sends a signal and still waits for exit. Buffer overflow can terminate the child and truncate output. Thus these options do not certify bounded end-to-end completion or complete output preservation in every failure mode. [BRIDGE, T-BRIDGE, NODE]

BRIDGE emits available output before checking result.error, but then describes every such error as the local CLI being unable to start. A timeout after execution is a consequential alternative: that wording does not prove that no process ran or no external action occurred. The bridge has no durable request identity, effect receipt, automatic reconciliation or rollback. The skill/design's instruction to inspect status before repeating find after ambiguous transport failure is therefore valuable caller-owned recovery guidance, not implemented idempotency in this wrapper. A numeric successful child exit likewise leaves RFQ/quote/qualification meaning to the client's response and the caller. No real ambiguous transaction or timeout occurred here. [BRIDGE, SKILL, DESIGN, NODE]

## 7. What is established, and what remains at the external boundary

Established source behavior includes explicit-path admission, realpath/layout/readability checks, same-Node/no-shell invocation, two command-aware environment filters, unsupported/dry-run refusal, local evals preconditions and output/status propagation. The paired authored procedure retains buyer authority, return-to-task after login and reconciliation-before-retry guidance. These are useful components of an optional integration, not one universal authority mechanism.

External-source claims remain distinct: package publication availability, actual device authorization/Keychain/revocation behavior, live RFQ acceptance and economic semantics, real MCP tool set, pinned qualification adapter behavior, endpoint trust and accepted useful outcomes. No external Itô implementation body or installed client was inspected. The source question can be bounded at this genuine interface without certifying those claims or starting an exhaustive product study. A new consequential caller or a decision depending on those claims requires deeper recovery. [DESIGN, SKILL, BRIDGE]

The complete bridge/environment, compute skill/design, MCP template and two actual test files were read. The existing full same-pin public dispatcher reading was reused. The source tests create harmless local child probes; they do not use an actual Itô package, GPU node, token service or market. Their positive and negative assertions are meaningful for process boundaries, not independent service evidence. No tests or target functions were executed here.

## 8. Bounded return and next responsibility

Q02g1 carries this ECC-side source answer; Q02g2 retains external-client provenance/build/runtime correspondence, authenticated authority, full argument/config/endpoint/credential-policy fidelity, actual MCP and helper consumers, timeout/retry/effect identity, test variants and accepted outcomes. The accept mismatch is an original same-pin source finding, not an upstream patch or a statement about a later release. Note33 remains provisional and is extended by this optional local-execution relationship.

Next selected G5 question is U18-E/Q02h, Nasiko's pinned acquisition/install/status/uninstall boundary. Only scripts/nasiko.js1–80 was read to qualify it: the prefix names the actual nasiko-release helper and claims digest-checked installation. Those claims are not yet findings. Recover the complete script, helper, release metadata and tests before explaining artifact identity, extraction, consent, ownership or removal. No download, installation, external registry query or executable launch is authorized. Other claw/MCP/alternate-dashboard roles and G6/CORE/joint evaluation remain open.
