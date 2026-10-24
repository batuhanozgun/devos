# U01-A — ECC surfaces, Codex hook boundary and cache-verifier coverage

**Date:** 2026-09-17. **Target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Questions:** Q01, bounded Q02/Q03/Q08 intersections. **Status:** bounded first slice; U01 remains PARTIAL. Source IDs and coverage: [U01-A sources](../evidence/U01-A-SOURCES.md).

## 1. Result and its scope

ECC is not adequately described at this point as either only a prompt collection or one uniformly shipped/runtime-equivalent OS. The inspected sources expose several distribution/execution surfaces whose relationship must be traced rather than inferred from a shared brand. This is an orientation inference, not the final ECC-native model.

A concrete contradiction was also found: the cross-harness architecture text describes Codex hooks as instruction-backed, while the same pinned revision's provider-local documentation and manifest wire a native synchronous SessionStart projection. A narrow local test then found that the cache checker does not inspect that current manifest hook reference.

## 2. Repository, package and execution surface are different objects

**SOURCE OBSERVATION — S03/S04/S06/S09–S12/S22–S24.**

The root `package.json` identifies `ecc-universal` 2.2.1, defines six binary names, an explicit `files` list and an OpenCode prepack build. `scripts/ecc.js` is a dispatcher: its command table maps setup/install, memory, state/session/work-items, control-pane and other commands to separate Node scripts and spawns the selected script. Calling the dispatcher an end-to-end orchestrator would overstate what this file proves.

The Rust `ecc2/Cargo.toml` separately identifies `ecc-tui` 0.1.0. Its README describes an alpha control-plane scaffold and explicitly bounds its recorded-measurement evaluation registry: changing an active registry pointer is not deployment into running sessions. That is a target claim about implementation until the Rust call paths are inspected. The Node `scripts/control-pane.js` instead delegates to `scripts/lib/control-pane/server`; it prints `dbPath` and `stateDbPath`. That wrapper alone does not establish identical or disjoint persistence semantics.

`workflows/README.md` describes a native Workflow-tool pilot and names installer/manifest wiring as unfinished follow-up. The root package's explicit `files` list does not include `workflows/` or `ecc2/`. This aligns with separate delivery boundaries; no npm tarball or native-plugin cached tree was inspected, so do not upgrade whitelist inspection to verified installed contents. Native repo-marketplace caching and npm packaging are different channels.

See [STRUCTURE](../inventory/STRUCTURE.md). The first root tree listing was read to its `truncated:false` end; the entire recursive repository tree was NOT obtained/read. Known unexpanded subtrees remain in [TREE-FRONTIER](../inventory/TREE-FRONTIER.tsv). No repository-wide content-reading or completion percentage is claimed.

## 3. The Codex label must be narrower than one host-wide status

**TARGET CLAIM / SOURCE OBSERVATION — S02/S13–S20/S24.**

- The shared architecture document says Codex hook parity is instruction-driven.
- `.codex-plugin/plugin.json` at the same pin references `./hooks/codex-hooks.json`.
- That hook file contains only `SessionStart`; it requires `PLUGIN_ROOT`, sets the shared bootstrap root and delegates through the Node bootstrap chain.
- `.codex-plugin/README.md` describes Codex 0.146-specific synchronous support, exclusion of unsupported/async/tool-blocking handlers and separate plugin enablement versus definition-hash trust. These are ECC's provider-contract claims, not a live host observation in this study.
- The root README's selected install sections likewise distinguish native Codex marketplace installation from deprecated managed sync.

**Bounded conclusion:** 'ECC Codex hooks are only instructions' is inaccurate as a description of the inspected source surface. 'ECC has full native hook parity on Codex' is also unsupported. The useful unit is a specific mechanism/event + install channel + source/host version + trust/enabling conditions.

This corrects the earlier screening answer without retroactively erasing it. No present-day native Codex capability is inferred beyond what these source files actually say and implement.

## 4. The partially followed bootstrap chain

```text
.codex-plugin/plugin.json
  → hooks/codex-hooks.json : SessionStart only
  → require PLUGIN_ROOT; adapt root variable
  → scripts/hooks/plugin-hook-bootstrap.js
  → scripts/hooks/session-start-bootstrap.js
  → scripts/hooks/run-with-flags.js : session:start
  → scripts/hooks/session-start.js [BODY NOT READ IN U01-A]
  → host admission/consumption [NOT EXECUTED]
```

Full reads covered both bootstraps and the flag runner. Several helper dependencies and the session-start body were not read; this is not dependency closure. The hook declaration requires `PLUGIN_ROOT` before legacy fallback logic. The shared runner has profile/dry-run/no-output/failure branches; therefore declaration and invocation do not establish meaningful context delivery. Specific availability-oriented fallback branches should not be relabelled as universal security failures without a protected-effect claim.

`manifests/install-profiles.json`'s `minimal` profile omits the `hooks-runtime` module, whereas the native SessionStart runner lists `minimal,standard,strict` hook profiles. These are different configuration scopes; matching strings do not prove they select the same installed capabilities. Actual channel/profile wiring is for U01-B.

## 5. What the upstream hook test does and does not establish

**TEST SOURCE INSPECTED, NOT RUN — S16.**

`tests/codex-native-hooks.test.js` constructs a temporary home/project, executes the declared command through a shell and asserts (a) exit 0 plus SessionStart-shaped JSON/string additionalContext and (b) nonzero plus a missing-root error without PLUGIN_ROOT. It does not launch Codex. It does not test host approval, semantic completeness of restored context or outcome quality. Its runtime environment inherits other process variables. We did not run this upstream test or claim independent host verification.

## 6. Source-bound local falsifier: cache success misses a missing hook

**SOURCE OBSERVATION + LOCAL EXECUTION — S25 / E01.**

The checker header describes verifying every referenced file path. `collectManifestRefs` actually collects four fields: `skills`, `mcpServers`, `interface.composerIcon`, `interface.logo`. It does not collect `hooks`. Its success text says all cached manifest references resolve after checking that narrower set.

A source-informed probe was designed before execution, using an unchanged, blob-verified checker and the current blob-verified manifest. No installation or real cache was used. Results:

| Case | Hook path | MCP path | Checker exit |
|---|---|---|---:|
| C0 presence baseline | present | present | 0 |
| C1 omitted-reference challenge | missing | present | 0 |
| C2 checked-reference control | present | missing | 1 |

The observed C1 falsifies the broad inference that this checker's success establishes existence of every current manifest reference. C2 shows the probe can produce rejection for a field the checker actually measures. C0 is only a valid baseline for presence/type, not a functioning plugin.

The proximate explanation is the collector's omitted field. A broader possible explanation is evolution of the manifest without corresponding evolution of its verifier, but causation/history was not investigated; do not report that as an established maintenance root cause.

[Probe README](../evidence/u01-a-cache-probe/README.md), [plan](../evidence/u01-a-cache-probe/PROBE-PLAN.json), [raw results](../evidence/u01-a-cache-probe/RESULTS.json), [reproducer](../evidence/u01-a-cache-probe/run-cache-probe.py).

## 7. Candidate project relevance, not adoption

This supplies a concrete implementation-learning/falsifier case for representation and verification boundaries: a manifest can expand, a checker can remain narrower, and an overbroad success label can survive. It motivates asking which exact current references/conditions a verdict covered, rather than accepting a generic green label. It does not prescribe a SOUL service, agent topology, schema or Foundation modification.

## 8. Disposition and next reading

Q01: PARTIAL, with distribution/runtime alternatives now better separated. Q02: one source-level host-label correction, not full portability. Q03/Q08: this verifier's missing-hook coverage demonstrated under a local fixture; install/ownership and other verification mechanisms remain open. Q10: the source→contradiction→bounded falsifier method produced one material correction; long-run method quality remains unproven.

Next U01-B completes the installation/materialization map: read the remaining install manifests and actual entry dispatch; discover marketplace source binding through the pinned `.agents`/plugin trees; follow cache/consumer boundaries and finish relevant subtree discovery. Then choose U02 from that evidence. Do not repeat U00, erase this result or declare the broad U01 map complete.
