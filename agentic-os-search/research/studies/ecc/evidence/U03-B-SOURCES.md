# U03-B — Source and execution ledger

**Date:** 2026-09-17. **Target pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. No repin. IDs continue U03-A. Paths resolve under https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ . FULL is file-through-EOF, not every dependency/runtime/consumer.

| ID | Source | Git blob | Actual coverage |
|---|---|---|---|
| S70 | scripts/orchestrate-worktrees.js | 0368825fc78d8e0307eb917904743c8614371329 | FULL; requested 1–240 reached EOF. Dry-run/write-only/execute dispatch |
| S71 | scripts/lib/tmux-worktree-orchestrator.js | 4c9cfa920a63cb5d657017e837aa423a770de914 | FULL 1–240, 241–520, 521–EOF. Plan/artifacts, overlays, actual command path, replace/rollback. NOT EXECUTED |
| S72 | scripts/lib/orchestration-session.js | 9449020fcf7b7233edb581e77ff4bde5d749cf49 | FULL 1–260 + 261–EOF. Collector, parser, locator and tmux observations. Exact 7546-byte file materialized; loadWorkerSnapshots/parser path EXECUTED in E03. Actual tmux observation NOT EXECUTED |
| S73 | scripts/orchestration-status.js | 33aaa6881ce5d3eb6fb6e4e8af54c6e224e6779f | FULL; requested 1–260 reached EOF. Adapter consumer/output writer. NOT EXECUTED |
| S74 | scripts/orchestrate-codex-worker.sh | d73ad0cf26efb49cf5d177fadc651a7ba9ae182d | FULL; exact 2583-byte file EXECUTED in E03 with fake provider, real local Bash/Git and temporary files |
| S75 | skills/dmux-workflows/SKILL.md | 58f2c3e2b56d8fea50e894c0ff5356d00950076d | FULL; documented composition, task independence/review/integration instructions. Research data, not agent-control |
| S76 | tests/lib/tmux-worktree-orchestrator.test.js | e23977c15144ae3fe35b01de51806b438d14b92a | FULL 1–240 + 241–EOF. TEST SOURCE INSPECTED, NOT RUN. Plan/content/overlay assertions and mocked setup/rollback paths |

## Retained dependencies and claim bindings

S61/S62/S63/S67 from U03-A remain same-conversation pinned source evidence: adapter route, collector call, canonical normalizer/persistence and inspected tests. They are not new independent readings or re-executed evidence. S63 establishes the state/health mapping discussed in Note 05; this unit does not execute that normalizer.

- Plan/environment/launch and created-resource rollback: S70/S71, interpreted with W05/W06; S76 inspected only.
- Provider status→raw handoff→parsed fields: S74→S72, locally exercised in E03.
- Guidance versus enforced isolation/acceptance: S75/S71/S74; current host options W07 do not prove installed policy.
- Locator and worker enumeration: S71 naming/root producer versus S72 resolver/directory scan. SOURCE-DERIVED, not an integration test.
- Observation scope and freshness: S72→retained S63, S73. Actual tmux and downstream acceptance/controller bodies remain open.

## Separate current primary contract checks

W05: https://git-scm.com/docs/git-worktree — selected add/base-ref, remove/force/prune semantics; observed 2026-09-17. Not a test of ECC cleanup or an exact target Git build.

W06: https://man.openbsd.org/tmux — selected send-keys and pane_active semantics; observed 2026-09-17. Character/key delivery and active-pane representation do not establish worker readiness. No tmux process was run.

W07: https://developers.openai.com/codex/cli/reference redirected to https://learn.chatgpt.com/docs/developer-commands?surface=cli . Selected exec profile, output-last-message and working-directory options; observed 2026-09-17. Current documentation is a separate temporal contract. The actual named yolo profile, historical CLI version and model availability were not verified. Unrelated search hits and unofficial mirrors were not used as evidence.

## E03 — actual local execution

[README](u03-b-worker-probe/README.md), [pre-execution plan](u03-b-worker-probe/PROBE-PLAN.json), [runner](u03-b-worker-probe/run-probe.py), [raw results](u03-b-worker-probe/RESULTS.json).

Two source files were materialized from connector text and checked against their exact Git blob hashes before execution. Plan SHA-256 before execution: `6784dde99b401e783c269038d2190017bc1e453b079c34c18210d3d9cc44b204`; unchanged afterward. The Python runner also checks both upstream blobs before loading code.

Five criteria matched: structured-success baseline; structured failed-verification text still yields process-completed status; unrecognized presentation retains raw text but yields empty parsed arrays; nonzero provider exit produces failed/generic handoff; missing task fails without provider invocation. Full command/stdout/stderr/raw artifacts/parsed fields/fake-provider prompts and arguments are preserved. C1 is not an actual failed software task: its content and exit code were deliberately supplied to test the wrapper's decision rule.

Only the Bash wrapper and Node collector were exercised, with a deterministic fake executable named codex placed first in an isolated PATH. Real local Git initialized a temporary repository and supplied status/branch metadata. Fake HOME, isolated TMPDIR and a minimal environment were used; no real host/config/credential/network/model, tmux, SQL or ECC install. No concurrent claim/worker, crash, worktree rollback or effectiveness experiment. E01/E02 were not rerun. Upstream test assertions are not test passes.

Environment from the actual result: Python 3.13.5, Node v22.16.0, Git 2.47.3, Bash 5.2.37, Linux x86_64. Actual output timestamps are retained as execution provenance, not source-version timestamps.

## Discovery and continuation

Default-branch code search returned `dd6ee538aee0f548d4a6b520118f875431fd749e`. It was used only for paths; all substantive new bodies above were fetched at the original pin. The separate dmux product was not researched or adopted.

Next-family paths discovered, not body-read in this unit: `skills/unified-memory/SKILL.md`, `scripts/memory.js`, `scripts/memory-mcp.mjs`, `scripts/lib/memory-vault.js`, `scripts/lib/memory-vault-format.js`, `schemas/memory.schema.json`, `examples/unified-memory/README.md` and conformance/evidence files. These were discovery hits at the search ref, so U04-A must confirm them at the research pin before use. Their presence is not memory implementation coverage.

P1 retains original STRUCTURE/TREE-FRONTIER, U01-B delta and prior unit additions. This unit expands a concrete runtime family, not a complete repository inventory. No source-count completion percentage is implied.

Current project STATE/INDEX/META/QUESTIONS and current log/ledger/MR04/publication were recovered; unchanged same-conversation METHOD/WHY/PLAN/Note04/U03-A ledger and canonical controls were retained. Empty out-of-range tool responses were not interpreted as empty files. Input main remained `a17889f14347c5ef16cb78f01fb064cdaf6fe98b` at the pre-publication check. Auxiliary raw GitHub download failed at DNS; connector reads worked. No full checkout exists. Actual publication/readbacks are recorded separately in PUBLICATION.
