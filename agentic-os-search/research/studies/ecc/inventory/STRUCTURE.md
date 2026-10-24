# ECC — U01-A source and execution surface map

**Target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Date:** 2026-09-17. **Status:** first orientation map, NOT a completed recursive inventory or final subsystem taxonomy.

## Actual discovery depth

S04 is the root non-recursive Git tree response, read through its final `truncated:false` field, including a second resource read after the initial display was truncated. Direct child listings for `manifests/`, `ecc2/`, `src/` and `workflows/` were also read in full. Other directories were not recursively expanded, even when selected files inside them were read.

[TREE-FRONTIER.tsv](TREE-FRONTIER.tsv) preserves all 43 root-directory identities from that listing, with explicit expansion status. It is a derived transcription of the API response, not a downloaded raw recursive manifest. Root file metadata and selected content are represented below and in [U01-A sources](../evidence/U01-A-SOURCES.md).

The attempted container-side recursive-tree download failed at DNS resolution. GitHub connector access remained available. No full local checkout or whole recursive-tree acquisition was achieved. This is an access/coverage boundary, not evidence that unexpanded regions are absent or irrelevant.

## Native source families discovered, not predetermined bins

| Source region | What is actually observed | Current research treatment |
|---|---|---|
| `AGENTS.md`, `CLAUDE.md`, `SOUL.md`, `contexts/`, `rules/`, `skills/`, `agents/`, `commands/`, `legacy-command-shims/` | Root entries; full AGENTS declares skills-first workflow and legacy command compatibility | Shared/procedural assets and guidance. AGENTS full read; remaining content coverage differs. ECC's SOUL.md is only a discovered external file, not this project's SOUL definition. |
| Hidden host directories and `plugins/` | Multiple host-specific roots; full Claude/Codex plugin manifests; Codex-local README | Packaging/adaptation variants. Directory count is not verified host support. Shared copies/generation still to trace. |
| `package.json`, `install.sh`, `install.ps1`, `manifests/`, `scripts/ecc.js` | Full package manifest and dispatcher; three install manifest identities; full profile manifest | Distribution and command entry layer. Profiles/modules/components are separate source surfaces. Actual plan/apply/ownership paths remain open. |
| `scripts/`, `scripts/lib/`, `hooks/`, `schemas/`, `config/`, `src/llm/` | Dispatcher names install, memory, session/state/work-items, audits, bridges and control-pane handlers; selected hook sources read | Executable helpers and services. The facade's existence does not establish all downstream dependencies or effects. `src/llm/` content unread. |
| `ecc2/` | Separate Cargo manifest (`ecc-tui` 0.1.0), local README, Rust source-tree identity | Separate Rust control-plane surface, locally described as alpha. Not equivalent to npm 2.2.1 or proof that all operator features are deployed. |
| `workflows/` | Direct tree contains README and `orch-review.workflow.js`; README describes a native Workflow-tool pilot | Additional native orchestration surface; code body not yet read. Installer/manifest follow-up is documented, not verified current installed failure. |
| `tests/`, `.github/`, `docker/`, `examples/`, `scaffolds/` | Root identities, package test/prepack scripts, one full upstream test-source read | Validation/distribution/example surfaces; most remain unexpanded. They must not be treated as merely non-runtime clutter. |
| `integrations/`, `mcp-configs/`, external command bridges | Directory identities and dispatcher references to optional external tools; README scopes multiple install channels | Explicit dependency frontier. External services/repos are not automatically included as fully researched ECC components. |
| `docs/`, guides, changelog, security and community files, `assets/`, lint/lock/config root files | Root discovery; selected architecture/provider/workflow texts read | Different authority/freshness roles. Presentation assets can be required cached references; not all assets are irrelevant to runtime qualification. |

The regions overlap. They are a map of discovery and delivery boundaries, not nine independent semantic subsystems or a required layer order.

## Command and distribution boundaries

S03 `package.json` explicitly maps:

| Binary name | Entry |
|---|---|
| `ecc`, `ecc-universal` | `scripts/ecc.js` |
| `ecc-install` | `scripts/install-apply.js` |
| `ecc-control-pane` | `scripts/control-pane.js` |
| `ecc-memory-mcp` | `scripts/memory-mcp.mjs` |
| `ecc-plan-canvas` | `scripts/plan-canvas.js` |

S06 `scripts/ecc.js` resolves the requested command and spawns a separate script with propagated arguments/status. Its table and imports are not a complete runtime dependency graph. S12's Node control-pane wrapper loads a Node server; S11 defines a separate Rust package. Neither is assumed to be the sole ECC runtime.

The root npm manifest uses an explicit content list and `prepack → build:opencode`. `workflows/` and `ecc2/` are not in that explicit list. S24/S15 describe native repo-marketplace caching separately from npm releases and legacy managed sync. Actual registry tarball contents, generated OpenCode package output and native cached contents were not acquired.

## Configuration dimensions that must not collapse

Install profile, hook profile, plugin enablement, host hook trust and source/runtime version are distinct. For example S08's `minimal` install profile omits `hooks-runtime`; S18 passes `minimal,standard,strict` to the SessionStart runner; S20 exposes separate Claude plugin hook preferences. These facts do not establish identical profile selection across channels.

S13/S14/S15 expose a Codex SessionStart projection despite S02's broader instruction-backed label. [Note 01](../notes/01-SURFACES-AND-CODEX-CACHE.md) records the discrepancy and the source/local cache-verifier finding.

## Unexpanded frontier and continuation

U01-B must recover the remaining install component/module manifests, actual install dispatch and marketplace source ownership; expand the relevant `.agents`, plugin, `scripts/lib`, schema and test trees; then revisit generated/distributed versus repository-only paths. Root source-file families must remain represented while this branch is followed. The full recursive inventory, duplicate/generated equivalence and representative host-comparison coverage remain open.

First exact sources: pinned `manifests/install-modules.json`, `manifests/install-components.json`, `scripts/install-apply.js`; `.agents` tree `0b6fef700821049a86f9cef4b83d4fd06e371bdc` for discovering, rather than guessing, the marketplace path. Actual SessionStart content/consumer work remains a dependent next mechanism, not a completed result.
