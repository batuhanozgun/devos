# U01-A — Source coverage and local evidence

**Date:** 2026-09-17. All new external source reads below use `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. Stable S01–S03 identifiers continue [SOURCE-LEDGER](../SOURCE-LEDGER.md). S03's U00 selected read is historical; the U01-A entry below records its newly completed read. Directory discovery, full text reading and execution are separate statuses.

Pinned file URLs are `https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/<path>`; Git tree identities use `https://api.github.com/repos/affaan-m/ECC/git/trees/<sha>`.

| ID | Source path or tree | Blob/tree identity | Actual coverage / use |
|---|---|---|---|
| S02 | docs/architecture/cross-harness.md | 768414b72432115fe885fecdd9ef72751a6b9742 | Same-conversation pinned FULL READ from U00 retained; documentation claim, not host execution |
| S03 | package.json | 87487a914c0fd739ea62107e7bf9e56b127207a5 | FULL READ completed via 1–240, 241–480, 481–EOF; same blob each part; distribution declarations, not tarball verification |
| S04 | root Git tree at pinned ref | API tree request at the pinned commit | FULL non-recursive response recovered through resource read; truncated:false at API level; NOT full recursive inventory |
| S05 | AGENTS.md | 0853429231f5ed495cf16f3945276e722fb4de82 | FULL READ; external-target instruction data only |
| S06 | scripts/ecc.js | 6c2aee1a5826475bfd05552a1bc485b35295bf9a | FULL READ 1–230 + 231–EOF; dispatcher, child-script invocation, dependency frontier |
| S07 | manifests tree | 2acc664165883bdad6cca2d1661d75783471c48d | FULL direct-child listing; components/modules/profiles identities |
| S08 | manifests/install-profiles.json | 09ed37033173a583ffbdf2e569f481f7e4eab99f | FULL READ; install profile contents |
| S09 | ecc2 tree | a5cd9ce731bc2d405fb2191f075ad19dbaed128a | FULL direct-child listing; src subtree 6e722551d08805adce0760184f5835e7e4de4ef8 unexpanded |
| S10 | ecc2/README.md | 71aad6da80ba490a3705587aa31a15c36625b9fc | FULL READ; local alpha/eval-registry claims and explicit deployment limits |
| S11 | ecc2/Cargo.toml | 1995913c78282b08ccc7b4940b22e522c6e9cb41 | FULL READ; separate package/version/dependency declaration |
| S12 | scripts/control-pane.js | c5b7215f4dbd50d324768b1bcc5196cd5d0d1b91 | FULL READ; Node wrapper, server dependency not followed |
| S13 | .codex-plugin/plugin.json | 7ad227cac60a8ce5d97e6d152e449812857d13eb | FULL READ; also exact local byte identity verified for E01 |
| S14 | hooks/codex-hooks.json | 551f7a4b4732e95937af538cc97d92f7b5d76511 | FULL READ; only SessionStart declaration; no hook execution in this turn |
| S15 | .codex-plugin/README.md | ed4ece00e5b2ad59786182151e3d9f5f4ce42741 | FULL READ; provider-specific install/trust claims, not independently verified host facts |
| S16 | tests/codex-native-hooks.test.js | 04cfd41739932af8623f2c5741be3fb7e2619d5d | TEST SOURCE INSPECTED in full; two declared cases; NOT RUN |
| S17 | scripts/hooks/plugin-hook-bootstrap.js | 8d573ffedaa0f55de122a704737d3db0aa23f68d | FULL READ 1–250 + 251–EOF; exact code, helper imports not all followed |
| S18 | scripts/hooks/session-start-bootstrap.js | 4da168bad72611821639d6c7106708e3722cf5fe | FULL READ; entry→flag runner; session-start body not read |
| S19 | scripts/hooks/run-with-flags.js | 9f6de372212d5c3ba20502b5e05711431f1a0053 | FULL READ 1–230 + 231–EOF; gating/no-output/failure paths; helper dependencies open |
| S20 | .claude-plugin/plugin.json | 5f1e9a391ae0e0f096f9f65d7b1f119b549bc6b5 | FULL READ; Claude-local plugin configuration surface |
| S21 | src tree | 41570fb73637b18803324cc4f557564294489bed | FULL direct-child listing; llm subtree 90a2fad1ca232d5c049d8b9f9a4ee9ffe8aca17c unexpanded |
| S22 | workflows tree | d5cb8a3065c426d7e85b289a92c3cb14389e9f22 | FULL direct-child listing; README plus orch-review.workflow.js |
| S23 | workflows/README.md | db58b5a398f1f4ef651baa360af6d46034568ad4 | FULL READ; pilot/distribution/approval claims; workflow code not read |
| S24 | README.md | 86dba51207907b2e5de07d6b0579a681522cdc13 | SELECTED READ 180–360; install channels and Codex/legacy boundaries only |
| S25 | scripts/codex/check-plugin-cache.js | 6839b413cc78d6755cc56f61be0d57f4754b5fa6 | FULL READ 1–230 + 231–EOF; 264-line local source bytes independently matched to this blob identity; EXECUTED only in E01 fixtures |

## E01 — Actual local execution, not the upstream native-hook suite

[Probe plan](u01-a-cache-probe/PROBE-PLAN.json), [runner](u01-a-cache-probe/run-cache-probe.py), [raw results](u01-a-cache-probe/RESULTS.json), [limits/reproduction](u01-a-cache-probe/README.md).

Three newly executed cases: presence baseline exit 0; missing-hook challenge exit 0; missing-MCP control exit 1. S13 and S25 bytes were verified against Git blob identities before execution. The root package manifest was a synthetic version-only fixture, not the full upstream package. Dummy target files test presence, not valid runtime content. This is same-assistant, source-informed exploratory execution with a pre-execution criterion, not independent replication or live Codex use.

No installation, native host/model, hook-body, upstream full-suite, npm registry tarball, paid API or external write was executed. E01 is stronger than a source prediction for this narrow checker behavior, but does not establish whole-product reliability or failure frequency.

## Discovery-only and access limits

Search for codex-hooks.json supplied pinned paths for S15/S16 and tests/plugin-manifest.test.js. That last test was NOT opened; snippets are not test-source coverage. Known install-module/component files were listed, not yet read. Root tree identities in TREE-FRONTIER are discovery anchors, not content reads.

A container-side public GitHub recursive-tree request failed with DNS resolution; no tree file or checkout was downloaded. A supplementary web open failed and search results were irrelevant, so no substantive claim uses those results. Connector reads remained successful. Local Node/Python execution later succeeded for E01. Do not conflate network acquisition capability with offline execution capability.

## Project recovery

Fresh ECC STATE and directory identities were checked on main. Unchanged INDEX/META/METHOD/PLAN/METHOD-REVIEW/PUBLICATION full reads from this same conversation remained applicable; WHY/QUESTIONS/SOURCE-LEDGER/RESEARCH-LOG were additionally recovered in full. This was same-session re-entry, not a blind fresh-session test. The user continuation activates U01 under the existing study boundaries. No Foundation or other study research was resumed.
