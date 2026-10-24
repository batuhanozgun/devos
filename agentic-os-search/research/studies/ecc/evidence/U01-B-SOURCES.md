# U01-B — Source/read ledger and evidence boundary

**Date:** 2026-09-17. **Primary repository/ref:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. No repin. Every relative source path below is resolved at that exact commit; [pinned source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a).

IDs continue S01–S25 from [U01-A](U01-A-SOURCES.md). FULL means the file was read through EOF, using contiguous requests where needed. It does not mean dependency closure or execution. Partial requests and large response acquisition are not promoted to full reading. Blob identities are included only where explicitly rechecked for this record; repo/ref/path is the immutable binding for the remaining rows.

| ID | Exact source path / object | Coverage | Role in U01-B |
|---|---|---|---|
| S26 | `manifests/install-modules.json` | FULL, contiguous ranges | Module paths, targets, dependencies and declared runtime prerequisites |
| S27 | `manifests/install-components.json` | FULL, contiguous ranges | Explicit component-to-module mappings; coarse versus leaf selection |
| S28 | `scripts/install-apply.js` | FULL; final entry/dispatch recheck | Guided versus ordinary entry; request/plan/apply and health projection. Blob `1435d2ff665b0595f490afd211fc0295b40d0842` |
| S29 | `.agents` tree `0b6fef700821049a86f9cef4b83d4fd06e371bdc` | FULL direct-child listing, not recursive | Discovered plugins and skills subtrees |
| S30 | `.agents/plugins` tree `e1b52421defb19841308a5c4fcbaa28afdf2fef0` | FULL direct-child listing | Discovered the marketplace filename rather than guessing it |
| S31 | `.agents/plugins/marketplace.json` | FULL | Native local source is repository root `./`; not a registry tarball inspection |
| S32 | `scripts/lib/install/runtime.js` | FULL | Manifest/legacy-compat/legacy plan dispatch and hook-consent wrapping. Blob `eabb930b26a8f85f26768de2d65036cc7f1c7b46` |
| S33 | `scripts/install-guided.js` | FULL, contiguous requests | Guided request, previews, confirmation and result presentation |
| S34 | `scripts/lib/multi-harness-setup.js` | FULL; rechecked in contiguous ranges through EOF | Native Claude/Codex versus managed Kimi; ownership preflight and sequential partial result. Blob `141eb42066720d3fb94459b369e9771dfdd18bcc` |
| S35 | `scripts/lib/codex-plugin-setup.js` | FULL; final contiguous recheck through EOF | Provider inventories/provenance, marketplace add/upgrade, plugin registration predicate. Blob `2f7de4170dea1cc760cbbcb86289520eb4e395bb` |
| S36 | `scripts/lib/install-executor.js` | SELECTED, lines 1–300 | Facade/legacy context; remainder not read, not a full legacy-installer analysis |
| S37 | Git trees API at primary commit with `recursive=1` | RESPONSE ACQUIRED / DISPLAY-LIMITED; not fully recovered/reviewed | Attempted broader metadata acquisition. No full recursive inventory or complete source tree coverage claimed |
| S38 | `scripts/lib/install/plan.js` | FULL, contiguous requests | Resolved modules, target adapter and operation planning |
| S39 | `scripts/lib/install-targets/registry.js` | FULL | Actual managed target adapter routing |
| S40 | `scripts/lib/install-targets/codex-home.js` | FULL | Home root `.codex`, `ecc-install-state.json`, native source prefix. Blob `ae29b41a1f52a93a09069992668c4a7deb9fded9` |
| S41 | `scripts/lib/install-targets/helpers.js` | FULL, contiguous requests | Target/source path mapping and operation construction |
| S42 | `scripts/lib/install-manifests.js` | FULL, contiguous requests | Explicit/synthetic components, target/dependency filtering and resolution |
| S43 | `scripts/sync-ecc-to-codex.sh` | FULL, contiguous requests through EOF | Separate copy/merge/legacy-ownership route. Called merger and legacy-state helpers remain unclosed |
| S44 | `scripts/lib/install/apply.js` | FULL, contiguous requests; write/failure section rechecked | Applied versus planned operations, transformations, digests, bridge checkpoint and partial-write boundary. Blob `fbab1293bb8dcdebb1df4a23556f06419bd290ec` |

## Current official host-contract checks — separate from the pinned corpus

| ID | Official source | Observation date and coverage | What it can and cannot support |
|---|---|---|---|
| W01 | [OpenAI Codex Plugins](https://developers.openai.com/codex/plugins) | 2026-09-17; selected plugin/hook trust sections via web | Provider's current documented contract; plugin enablement is not automatic hook-command trust. Not a validation of ECC's cited historical host build |
| W02 | [OpenAI Codex Hooks](https://developers.openai.com/codex/hooks) | 2026-09-17; selected plugin hooks, review/trust and changed-definition sections | Current contract-level corroboration of a separate trust boundary. Same provider, not independent replication or an observed host run |

Do not merge W01/W02's moving documentation into the historical ECC pin, or infer that a CLI command documented for one host version must work unchanged today.

## Claim coverage map

- Note 02 §2 channel comparison: S28–S35, S38–S43; prior S13/S15 and S03 only at their already recorded coverage.
- §3 native readiness: S35; W01/W02 for the separate current host-contract statement.
- §4 selection: S26/S27/S38/S41/S42.
- §5 transformation and partial-write representation: S44; imported guard/transform/state helpers are not thereby full-read.
- §6 multi-target sequencing: S33/S34; no actual failure injection.
- §7 health projection and memory runtime prerequisite: S28/S34/S44 and S26. The projection helper and the memory runtime body are NOT READ in this unit.

## Execution and dependency limits

**No new ECC execution in U01-B.** No upstream test suite, local installer/probe, real home/cache/config, Codex/Claude/Kimi process, model/API call, registry tarball or effectiveness experiment was run. E01 in U01-A is retained unchanged and was not rerun or counted as new evidence.

All new mechanism results are SOURCE OBSERVATION or qualified INFERENCE. Manifest prose and provider docs remain TARGET CLAIM/CONTRACT where they describe expected consumption or capability. No general safety/adoption verdict follows.

The legacy merge/state helpers, `install/ownership-guard.js`, `install-state.js`, `install-state-store-sync.js`, link-rewrite implementation and relevant tests remain dependency obligations. Their names were discovered in callers; names and imports are not full reading.
