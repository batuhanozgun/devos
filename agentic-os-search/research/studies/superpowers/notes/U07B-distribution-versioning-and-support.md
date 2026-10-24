# U07-B — Distribution, Versioning and Supporting Representations

Date: 2026-09-18. **BOUNDED SOURCE / LOCAL-HELPER INVESTIGATION COMPLETE.** U07's selected runtime/distribution inquiry is now bounded-complete; U08 native synthesis is next. The whole study remains ACTIVE / PARTIAL. This is not a released-artifact audit, installation, live-harness qualification or adoption decision.

Primary remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0). METHOD remains v0.1. Resolve S79–S102 and E15/E16 through [SOURCE-LEDGER-U07B.md](../SOURCE-LEDGER-U07B.md). Earlier F01–F72, Q01–Q43, E01–E14 and S01 are preserved.

## 1. Question and evidence boundary

How does the shared source become a distributed package and then available guidance, and what does a successful packaging/versioning operation actually establish?

The study read the archive builder, legacy fork-sync script, version updater/configuration, shell linter, remaining selected manifests/install guides, Antigravity and Devin references/tests, authoring reference/graph tools and selected test documentation. The exact version helper was transferred, Git-blob verified and executed against eight controlled JSON-only scenarios. Neither packaging nor synchronization was executed. No dependency install, remote publication, real host/model or upstream test suite was run.

A source-defined command is not an observed external effect. Target installation guidance remains a claim about its intended consumers at this source revision, not a fresh certification of current marketplace availability or host APIs. The copied vendor reference was read as text, not adopted as current vendor policy; its remote illustrations were not rendered.

## 2. F73 — Distribution is several transformations, not one identical copy

**SOURCE — S79/S80, with S01/S14/S07.** The standalone Codex archive and the older fork synchronization flow are distinct mechanisms:

| Path | Actual input at the inspected layer | Produced result |
|---|---|---|
| Standalone archive | Selected Git ref plus per-skill metadata from a supplied prior package | Rootless ZIP or tar.gz and printed version/count/digest |
| Legacy fork sync | Current upstream working tree, configured exclusions and preserved destination metadata | Proposed destination change, then optional commit/push/PR |
| Host-native installation | Host's interpretation of repository/package/marketplace source and local configuration | A host-controlled installed/discovered version; not observed here |

The archive selects `.codex-plugin/`, `assets/`, `skills/`, README, license and code of conduct. Root hooks, tests, docs, development scripts and other harness manifests are not selected. Nested runtime and reference files under `skills/` remain selected: removing root `scripts/` does not mean removing the visual companion or SDD helpers. Host-specific references inside the shared skills also remain; the package is not rewritten into entirely host-specific skill prose.

The legacy sync intentionally retains root hooks and uses a root-anchored exclusion list rather than the archive's positive selection. Their payloads need not match even at the same upstream revision. The archive script explicitly describes the sync flow as the older path; the porting guide's appendix still lists fork sync. This is a documentation/implementation-era seam, not evidence that either artifact was actually distributed by us.

**Interpretation:** the stable subject is a source family with channel-specific assembly. A version string is a useful label, but not the identity of every input or the complete bytes delivered through every channel.

## 3. F74 — The archive has an external metadata dependency and bounded reproducibility

**SOURCE — S79/S95.** The builder uses `git archive` at `--ref`. Its `--allow-dirty` flag permits a dirty checkout but does not include those working changes. It stages selected source files, then requires `skills/<skill>/agents/openai.yaml` for every skill from a supplied prior package directory or archive. Missing metadata and a count mismatch stop packaging.

This is a meaningful completeness check. It does not parse the YAML or establish that its descriptions, permissions or other semantics remain suitable for the new skill text. The script calls the input a prior official package but accepts an operator-provided path; no independent publisher-authentication or expected-metadata digest check appears in this builder. Such checks may exist outside it and were not investigated.

The script normalizes ordering, timestamps and archive metadata, controls Git tar extraction modes and prints the produced SHA-256. Those measures support reproducible assembly. They do not make the primary SHA the only input: external metadata bytes/modes, builder/toolchain and applicable Git attributes remain relevant. Git's official archive documentation also permits archive attributes outside the selected tree; the inspected committed `.gitattributes` contains line-ending/binary declarations, not export filters. No actual archive was built or cross-platform byte equivalence measured.

The builder ends at a local artifact and digest. It does not upload to a portal, prove admission or establish what a running Codex instance loaded. Retaining an artifact digest can bind a later comparison to bytes; it cannot by itself prove those bytes are correct or approved.

## 4. F75 — Sync protects the destination, but a source permalink is not its full provenance

**SOURCE — S80/S102.** The sync script has useful protective mechanisms: an always-shown preview; a separate preview clone for local destinations; overlaying local destination changes into that preview; preserving destination-owned OpenAI metadata; refusal to apply over an uncommitted destination plugin subtree; and no-op detection before changing a local branch. Its test source exercises preview preservation, ignored/tracked distinctions, dirty-destination refusal and clean no-op behavior using temporary repositories and a fake `gh`. Those tests were read, not run here.

The source identity has a different boundary. The script warns and requests confirmation for non-main or dirty upstream state, explicitly saying it will use the working tree rather than HEAD. Its rsync selection is not generated solely from `git ls-files --cached`: nonignored untracked files outside exclusions can also enter the staging source. Destination metadata is then overlaid. Nevertheless, generated commit/PR wording uses an upstream `main`/HEAD permalink. That reference alone cannot reconstruct all permitted inputs, and repeating the same upstream SHA alone need not produce identical content.

The committed exclusion list also lacks `.agents/` and `.hermes-plugin/`, both present in this primary tree. The porting guide advises adding new harness directories to other distributions' exclusion lists. This is a source-level legacy-filter coverage issue, not an observed shipment incident. The standalone archive's positive selection avoids these root families by construction.

Dry-run means no final destination apply/push/PR, not no activity: authentication checks and temporary clone/overlay preparation occur before the dry-run return. A full run can commit and push a branch and create a PR, but does not merge it. We did not execute any sync mode or access credentials. No claim about a real destination repository or marketplace follows.

## 5. F76 — Version checking, advisory audit and mutation have different completion semantics

**SOURCE + LOCAL EXECUTION — S81/S82, E15/E16.** The configuration lists nine manifest fields. The helper's `--check` detects missing files or unequal declared versions with a nonzero result. `--audit` explicitly suppresses that check's status before scanning for the most common current version string. Bump mode preflights existing readable manifests, skips missing ones, writes sequentially and ends with that advisory audit.

The controlled experiment used the actual 7,461-byte helper, Bash and jq, with synthetic JSON manifests. It did not exercise the production nine-file layout, YAML/yq or an actual release.

| Case | Observed result | Bounded meaning |
|---|---|---|
| Complete declared JSON files | Check, bump and later check succeed; fields actually updated | Positive mutation/control path |
| Unequal declared versions | `--check` exits 1; `--audit` prints drift but exits 0 | Advisory audit success is not a clean version gate |
| Missing middle declared file | Bump exits 0, missing path remains, later check exits 1 | Successful bump does not entail complete declared inventory |
| Missing last declared file | Bump exits 1 after updating earlier files | Failure does not imply rollback; ordering affects this shell path |
| Invalid existing JSON file | Preflight fails before the preceding valid file changes | Real preventive check, unlike the missing-file path |
| Undeclared file still at old version after bump | Audit says no undeclared current-version matches; old file remains | Post-bump current-string search is not a complete old-version inventory |
| Undeclared file at current version | Audit reports it, still exits 0 | Scan is sensitive to its actual predicate |
| Exit-code-only completeness oracle | Rejected against the missing-file inventory | Negative control for an overstrong interpretation |

The missing-last result is explained by the audit's version-selection loop/pipeline status under `set -euo pipefail`; it is not a universal claim that all missing-file bumps succeed. The earlier writes are direct observations. Missing/SKIP/drift lines remain visible in stdout, so the entire transcript does not conceal the conditions.

Two explicit study-defined stronger criteria were unmet: zero bump exit implying every declared file exists at the new version, and a post-bump all-clear implying no unregistered old-version manifest remains. The other cases record controls or descriptive boundaries; eight cases are not an eight-item product benchmark. The updater offers useful checking and preflight, but is not a single atomic release transaction or universal version-discovery service.

S101, inspected after the experiment, tests mixed JSON/YAML success and rejection of a non-string YAML field before mutation. We did not run it or replace its YAML coverage with our JSON cases.

## 6. F77 — Acquiring new files and activating new guidance are separate host transitions

**SOURCE — S84–S93, with S01/S08 and earlier adapters.** Devin's manifest is metadata-only. Its integration test describes host-native skill discovery and rejects injector/hook fields; it validates the manifest/version registration without requiring Devin. Antigravity's test describes reuse of the existing plugin hook and checks a tool-mapping reference. Its task mapping explicitly distinguishes a checklist artifact from `manage_task`, which manages processes. Neither test observes a live host using skills.

These concrete surfaces qualify the porting guide's universal full-bootstrap framing. The same guide's appendix already lists Codex native discovery without a session-start hook, and the newly inspected Devin surface relies on native discovery. Do not force every integration into an injector-shaped architecture merely because a general guide says injection is non-negotiable. Conversely, absence of a custom injector does not prove skills cannot be used.

OpenCode's installation guides warn that resolved Git dependencies can stay pinned in a lock/cache across restart. That acquisition/cache layer is distinct from the in-process module cache previously observed in U01-B. Kimi's guide distinguishes a bare repository's release selection from an explicitly selected branch, and says plugin changes apply to fresh sessions. These are target-document statements, not current independently verified host behavior.

A fuller update chain is therefore `source/channel resolution → package acquisition → installed files → host/module/session activation → discovery/load → use`. Different controls observe different transitions. Asking an agent to describe its Superpowers can be an orientation check; it does not establish exact source bytes or effective behavior.

## 7. F78 — Infrastructure checks do not automatically form a release gate

**SOURCE — S83/S94/S100–S102.** The shell linter selects changed, all-tracked or explicit shell files, optionally formats them, then runs ShellCheck and shell syntax checks. The primary pre-commit configuration names Python eval checks, not packaging, the version helper or live behavior. A file's existence does not establish that the hook was installed, ran or blocked release.

The testing guide's broad directory labels are not sufficient evidence of execution type: it introduces `tests/` as infrastructure but later names Claude-session tests. Its Python Drill description belongs to the primary snapshot; the separately pinned later Quorum lab has already been investigated at its own revision. Neither naming nor location replaces reading a test's actual dependency and assertion path.

The legacy sync test uses synthetic Codex hook files and checks that sync preserves them. This is evidence about that fixture and older channel's expected copying, not proof that the standalone archive should ship hooks or that native Codex now uses them. No first-party test was newly executed in this round. Actual administrative release admission and current host availability remain outside the source-level conclusion.

## 8. F79 — References and diagrams help communicate a method; they do not instantiate it

**SOURCE — S96–S99.** The copied vendor guidance supports several useful ideas: specificity proportional to fragility; selective reference loading; baseline-first evaluation; separate authoring and consuming agent instances; and explicit distinction between executing a script and reading it as reference. Its evaluation JSON is an example, explicitly not a built-in runner. Its platform/model claims are not promoted to current external policy or empirical evidence.

There are local guidance differences, such as the vendor copy's description including what-and-when versus writing-skills' narrower trigger-focused preference. The study preserves them at their respective roles rather than inferring incompatibility or choosing a universal rule without evidence.

The graph conventions call themselves a process DSL, but the inspected renderer extracts DOT blocks and asks Graphviz to produce SVG files. Its combine option groups diagram bodies; it does not execute the depicted transitions, enforce approvals or validate the meaning of a workflow. It was read, not run or visually inspected.

The spec-reviewer prompt is an available template. Pinned brainstorming's default flow instead calls for inline spec self-review and then human review. Mere presence of the template does not make an additional reviewer compulsory or overturn the actual role topology previously established. We have not proved that no optional caller ever uses it.

## 9. Coverage disposition and U07 closure

The source model now covers the selected primary distribution mechanisms and their relevant supports. This closes U07 at explanatory scope without certifying every installed artifact or testing all platforms.

| Family | Current disposition |
|---|---|
| Visual companion | U07-A full selected runtime chain and exact mocked-client evidence; real server/browser limits preserved |
| Standalone archive and legacy sync | Full scripts, relevant manifests and full sync-test source; no artifact build, upload or sync execution |
| Version/change controls | Full updater/config/linter; exact JSON-only E15/E16; YAML/production layout and active hook execution unverified |
| Remaining selected integrations | Devin/Antigravity and package/update guides covered; actual host APIs/loading remain explicit empirical limits |
| Authoring supports | Complete textual vendor copy, graph conventions/renderer and spec-reviewer template read; no images rendered or workflow execution |
| Historical release/plans/assets and exhaustive upstream tests | Not recursively read or qualified; reopen only if a synthesis claim depends on them |
| Evaluation dependencies | U06's qualified explanation and S01 retained; no new evaluator campaign or deeper dependency audit |

No known missing family blocks a provisional native whole-system synthesis at this research scope. That is not final closure: U08 must still test composition against sources, preserve contradictions and compare to current project context before CORE. Any decision-critical omission found there reopens the relevant source selectively.

New questions: **Q44** exact artifact-input and metadata qualification; **Q45** validation-mode/partial-mutation meaning surviving downstream consumers; **Q46** source-channel, installed bytes and active-session correspondence. These are reuse boundaries, not upstream-fix authority.

**Next logical and authorized work: U08.** Build the remaining native subsystem syntheses and request-to-delivery/evolution explanation, using S01 without upgrading its evidence class. Then recover current Foundation and selected comparator context for project-facing research, followed by CORE and omission/freshness challenge. No architecture adoption, installation or unlimited host/evaluator validation follows automatically.
