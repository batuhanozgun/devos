# U07-A — Source recovery and breadth evidence

**Date:** 2026-09-18. **Unchanged target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). [Family map](../inventory/U07-A-FAMILY-MAP.md), [MR12](../ROUND-U07-A.md). SOURCE OBSERVATION / TARGET CLAIM / coverage reconciliation / bounded INFERENCE. No target execution, new experiment or E06.

## New coverage and re-entry

Paths below resolve at the pinned root, not mutable main. FULL means through EOF for the named body or complete entries and `truncated:false` for the named tree response. A complete direct listing does not expand descendants or establish their behavior. Long root/scripts/lib JSON responses were recovered through the connector response reader after the initial display was truncated.

| ID | Exact path/object | Git identity | Actual reading and role |
|---|---|---|---|
| S152 | Root Git tree at pinned commit | 8321021c54d670126ce3b2969d5deb880b4b0c2a request | FULL non-recursive metadata; root files and 43 directory names reconciled with historical TREE-FRONTIER. Not a full recursive inventory |
| S153 | scripts direct tree | d5df03f487a6e67c491c6837e3a95ff75075b852 | FULL listing; CLI, controller, audit, release, integration and helper frontiers |
| S154 | scripts/lib direct tree | 818a45b65bcdba7d30e3a1e1809aece1f0fea5d3 | FULL listing; actual library families and previously unread consumers |
| S155 | ecc2 direct tree | a5cd9ce731bc2d405fb2191f075ad19dbaed128a | FULL listing; re-entry into S09, not independent evidence |
| S156 | ecc2/src direct tree | 6e722551d08805adce0760184f5835e7e4de4ef8 | FULL listing; main.rs, harness_eval.rs, notifications and comms/config/observability/session/tui/worktree subtrees; Rust bodies NOT READ |
| S157 | integrations recursive tree | a96348e1551ab6066f3c769c259dd4b39b71897b | FULL bounded recursive metadata: aura adapter, README/threat model and tests. Only README body read below; integrations elsewhere in repo are not excluded |
| S158 | scripts/lib/eval-harness direct tree | a862a655eb92a8da013a825d760a7ddfe9e60b23 | FULL listing; canonical/capsule/envelope/gate/replay/receipt/retrospective and retired runner/fence entries |
| S159 | scripts/lib/plan-canvas direct tree | 7f62a500d3116dd698e0cd34fb9d52c294cc06c7 | FULL listing; sessions/server/sdk/markdown/ui bodies remain next-unit work |
| S160 | scripts/lib/control-pane direct tree | b1aa05b67fc57ae209dab53abeaa75a8700b22ab | FULL listing; actions, state, server, message-sink, views, proximity and previously studied work-item-mutations |
| S161 | .github and .github/workflows direct trees | 3eb5b20c69f9701b0dd6310ff4e08ae4d0132817; 5ca067ba23c74528020c5bdad9fba3a1fde3d2fa | Both FULL listings; CI/reusable validation/testing/release, provenance, supply-chain-watch, announcements and metrics. Workflow bodies NOT READ in this unit |
| S162 | docs/ROADMAP.md | 9a3273e3c6183af34c7f45541c2c94e8fedac9f8 | FULL; 2026-09-09 planning/source-candidate account, not release proof or current product certification |
| S163 | scripts/plan-canvas.js | 816a0be7b2cc4215e2030bb74fde6489ed5172e1 | FULL 1–210, 211–510 reaching EOF; actual open/await/pending/end/server CLI and dependency calls. Server/store/host effect not established |
| S164 | scripts/eval-harness.js | ccf17b19b34245b8f18be71b1e26fd5f352ffdd8 | FULL; offline capsule/receipt dispatch and gate refusal before config/capsule access |
| S165 | scripts/lib/eval-harness/index.js | 2ffccfbb1af5a652f2d5dbda9c933de77c2f855c | FULL; actual namespace-to-module binding, including gate |
| S166 | scripts/lib/eval-harness/gate.js | 6ec49938782929b54d3fb070d3e79a1e9817868e | FULL 1–125, 126–380 reaching EOF; unconditional isolation-required throw, static inspection, task/result validation helpers. Dependencies other than S165 not fully read |
| S167 | workflows/orch-review.workflow.js | 3fd502da40d77c46c28e0ed8b6845bb0072393ef | FULL 1–230, 231–390 reaching EOF; input/dimension/finding/dedup/verifier/result behavior. Native DSL host globals are not executed or conformance-verified |
| S168 | integrations/aura/README.md | 99000362def4e67ea01f86b94db3b687f9d1882c | FULL; declared opt-in caller-owned boundary. adapter.py, threat model, service and tests not read/run |
| S169 | scripts/build-opencode.js | 73610cd387316cfd9421ff5b36cf695afa857710 | FULL; actual dist removal/compiler invocation and missing-compiler error. Compiler/plugin output not acquired |
| S170 | agent.yaml | ac7578d8d24bf49782a0aa58b10f8fffd482a855 | FULL; explicitly initial gitagent export manifest and asset references. Not complete native catalog or runtime execution |
| S171 | src/llm direct tree | 90a2fad1ca232d5c049d8b9f9a4ee9ffe8aca17c | FULL listing; cli/core/prompt/providers/tools and package entries. Subtree implementation not read |
| S172 | pyproject.toml | 2e924826f6e60defe47ad9eb35accafd23bf6806 | FULL; llm-abstraction distribution, llm-select entry, dependencies and src/llm wheel declaration; not a published-package/provider test |
| S10 re-entry | ecc2/README.md | 71aad6da80ba490a3705587aa31a15c36625b9fc | FULL again; was already full in U01-A. Revived evaluation-registry and runtime frontiers are not newly added source features |
| S12 re-entry | scripts/control-pane.js | c5b7215f4dbd50d324768b1bcc5196cd5d0d1b91 | FULL again; separate ECC2/ECC state paths and server call; server body still unread |
| S23 re-entry | workflows/README.md | db58b5a398f1f4ef651baa360af6d46034568ad4 | FULL again; pilot, outer human gates and follow-up wiring claims; compare current pinned body S167 rather than treating prose as oracle |

## Reconciled prior evidence

The master SOURCE-LEDGER through U03-B and full U01-A/U01-B/U02-A/U03-A/U03-B/U04-A/U05-A/U05-B/U06-A source ledgers were reopened. U06-B/U06-C full ledgers and latest Note11/round/receipt remained available from this conversation at unchanged identities. This is source-coverage recovery, not independent corroboration of the findings. Earlier notes retain their exact claims; a ledger is sufficient to establish what was read, not to extend an old mechanism result.

Historical inventory/STRUCTURE.md, TREE-FRONTIER.tsv and U01-B-DISCOVERY.md remain pass-time records. U07-A adds a linked disposition map rather than overwriting them to look retrospectively complete. Full body reading, selected body reading, complete metadata and executed fixtures are distinct.

E01 cache presence; E02 work-item helper with store double; E03 worker/collector with fake provider; E04 evaluation helper with stipulated outcomes; both historical E05 identities retain their original scopes. No rerun, new pooled score or independent replication is introduced.

## Consequential source bindings

- Separate Plan Canvas feedback journey: S163/S159, contrasted only at mechanism identity with Note11. The CLI calls a real HTTP await route; arrival/persistence/consumption/approval validity needs server/store/caller closure.
- Separate control systems: S12/S155/S156/S160; S10 describes Rust lifecycle and registry. No whole ECC2 implementation claim from its README or filename.
- Evaluation refusal: S164 → S165 → S166. Gate/variant execution paths unconditionally throw; static inspection/protocol helper existence is not containment or a completed evaluator. Capsule/receipt/replay internals remain unread.
- Native review pilot: S167 versus S23. Unknown or failed verifier results preserve blockers; failed review dimensions prevent a clean final verdict. This is the selected script's source predicate, not actual review efficacy or host availability. Its schema/proof fields do not authenticate proof.
- Distribution/external boundaries: S169/S170/S172, prior S03/S150, S168 and S161. Build/export/dependency declarations are not installed parity, release evidence or integration adoption.
- Breadth dispositions: S152–S161/S171 plus all prior ledgers; top-level accounting is not an exhaustive semantic inventory of every descendant.

## Verification and access limits

No ECC script, hook, native Workflow, Rust/Python provider, database, model, scanner, installation or upstream test ran. No E06. Source comparisons and any local text/hash preparation are administrative research/publication work, not target behavior experiments.

A narrow web search did not establish current native Workflow engine conformance; that remains open, not evidence of absence. Current release/product search hits were not used to repin or certify the source snapshot. No diagrams or PDFs were analyzed. Auxiliary raw GitHub acquisition again failed at DNS and produced no full checkout. Bounded connected tree reads succeeded; do not infer global GitHub failure.

Fresh AGENT/STATE and all nine protocol identities were checked against fully read same-conversation controls. Entry comparison from prior ECC closure 219d483bf79d3c80d7e5f1d1a0772296ce717828 showed concurrent work outside ECC. File creation succeeded as aba0b7da37e3548ecb5e80ee989ecd53342b621e, recording resumption after the previous read-only interruption. This is not an independent fresh-session methodology trial. Actual later publication checks belong in the unit receipt.
