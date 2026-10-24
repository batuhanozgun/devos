# U01-B — Installation channels, materialization and bounded readiness

**Date:** 2026-09-17. **Target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Questions:** Q01b, Q02/Q03, bounded Q05/Q08, Q10. **Evidence:** source reading and analytical comparison only; no new execution. Exact paths and read limits: [U01-B sources](../evidence/U01-B-SOURCES.md).

## 1. Bounded result

A harness name is not a sufficient identity for an ECC installation. At this pin, Codex has three distinguishable entry/lifecycle paths: provider-native plugin reconciliation, ECC's manifest-driven home adapter, and the separate legacy sync script. They share some source assets but do not imply the same selection, destination, ownership record, update procedure or readiness claim.

The managed path also separates requested components, resolved modules, planned operations, operations actually applied and recorded installed content. Materialization can transform content. The guided multi-harness coordinator performs previews before application, but explicitly represents partial application rather than a global rollback transaction.

These observations extend the system explanation beyond U01-A's cache-checker counterexample. They do not establish that every path is correct, that the three paths are safe to combine, or that an installed agent actually uses the resulting content.

## 2. Three paths to the same named harness

| Path | Source-grounded route | What this route establishes, and what remains separate |
|---|---|---|
| Native Codex plugin | `install-apply.js --guided` → `install-guided.js` → multi-harness coordinator → `codex-plugin-setup.js` → Codex marketplace/plugin CLI | Provider inventory/provenance and installed/enabled registration are checked; actual cache completeness, hook trust, context consumption and task benefit are not verified by that registration predicate. |
| Manifest-driven managed Codex home | Ordinary `install-apply.js` → normalized request → install runtime/plan/resolver → `codex-home` adapter → common apply engine | ECC resolves a file-operation plan and writes managed install-state. The adapter declares a home root `.codex` and `ecc-install-state.json`. This is not native marketplace registration. |
| Legacy Codex sync | `scripts/sync-ecc-to-codex.sh` → copy/merge steps and `scripts/codex/legacy-sync-state.js` | A separate shell workflow merges configuration/instructions and copies ECC assets, with its own legacy ownership helper. It is not merely another spelling of either route above. Full helper/recovery closure remains open. |

Sources: S28, S31–S35, S38–S43. The routing statements concern these pinned implementations. Commands in the table describe source paths; none was executed in the user's environment.

The native marketplace file discovered through `.agents/plugins/marketplace.json` binds its local source to `./`, the repository root. This explains why the repo-native source boundary differs from the npm `files` allowlist identified in U01-A. Neither declaration is a readback of an actual installed cache or registry tarball.

The legacy script is read as implementation, not an invitation to run it. Its configuration merge and ownership helpers require further reading before claims about preservation, reversal or safe coexistence. Do not collapse the legacy helper's ledger into the manifest adapter's state merely because both refer to Codex home.

## 3. Native reconciliation has a specific verification object

S35 reads marketplace and plugin inventories as JSON, validates their expected shapes and rejects duplicate/invalid ECC entries. For an existing `ecc` marketplace it verifies Git origin against the official repository. The implementation adds or upgrades the marketplace, checks the returned/re-read marketplace information and provenance, adds the plugin when necessary, and verifies an installed and enabled ECC plugin entry.

The final plugin predicate is `installed === true && enabled === true`. It is a real check, not just trusting a command's text. However, it is a check of provider registration state. It is not a hash check of every cached dependency and does not demonstrate that a hook was trusted, fired or delivered useful context.

Do not infer a no-op from a ready registration: the non-dry-run path still reconciles the marketplace. The dry-run action label and the real refresh path are different observations. Research pinning also does not force this installer to install that research pin; the inspected code invokes the provider's marketplace lifecycle.

ECC's provider README (S15, previous unit) and the current official Codex plugin/hooks documentation (W01/W02) independently expose the separation between plugin enablement and hook-command trust. W01/W02 are current, unpinned documentation; they do not validate the exact historical Codex version cited by ECC or substitute for a live host run.

U01-A's E01 remains relevant as an existing cache-checker coverage counterexample. It was not rerun here and supplies no additional independent observations in this unit.

## 4. Selection labels are not necessarily leaf payloads

S26/S27 define modules and user-facing components; S42 resolves them. Several explicit language/framework and skill components map to a shared module rather than to one isolated file. For example, the explicit `skill:tdd-workflow` component maps to `workflow-quality`, while several language/framework selectors map through `framework-language`. Their descriptions disclose this coarse mapping.

Conversely, the resolver can discover synthetic skill components for skill directories without an explicit component mapping. Therefore it would also be wrong to say that every `skill:` selector installs a broad bundle. The selection granularity must be recovered from the actual mapping at the pin.

Target compatibility and dependency resolution then further constrain the selected modules. A requested module can be skipped when the target or a required dependency is incompatible; the plan records such distinctions. Adapter mapping can narrow the source paths again. We did not execute a particular CLI selection, so these are source-derived resolution rules, not observed installed file counts.

Useful interpretation:

`named request → component/module resolution → target/dependency filtering → adapter operation plan`

An explanatory model that jumps directly from a user-facing selector to installed capability drops these intermediate decisions. Coarse selection is not by itself a defect; it may be an intentional packaging trade-off.

## 5. Materialization is a transformation with its own result

S38/S40/S41 map source paths to target operations. S44's apply engine then distinguishes the original plan from its applied and skipped operations. It exposes `plannedOperations`, effective `operations`, `skippedOperations`, warnings and `statePreview` in its result.

The engine is not only a recursive copy. Where declared, it transforms content; for mapped Markdown it can rewrite relative links to the installed locations. MCP configuration may be filtered, JSON configuration merged, and Claude settings handled through a separate managed-hook path. Digests are taken for installed content before the final install-state is persisted. A legitimate transformation means source bytes and installed bytes need not be identical.

This does not prove that every rewritten link resolves or that a merge preserved every intended semantic condition. The transformer, ownership guard, state writer and target consumer form separate evidence obligations. Reading the outer engine cannot close all of them.

The common engine contains a migration-specific bridge-state/checkpoint path for partial writes and a failure branch that can report a second checkpoint failure. That is evidence of a recovery mechanism's implementation, not evidence that all installation modes are atomic or that every failure is recoverable. In particular, do not generalize the `requiresBridgeState` branch to every target and every failure mode.

## 6. Preflight is not a transaction across harnesses

S34 constructs previews for the selected harnesses before the apply stage. Claude and Codex use native-plugin reconciliation; Kimi uses a managed-project plan. The Kimi path validates existing-state identity and content evidence, checks destinations, and includes further checks near writes. This is already richer than trusting a pathname or a prior ownership label alone.

Application is sequential. The coordinator accumulates completed entries; after an exception it returns `partial` when an earlier entry completed, otherwise `failed`, together with the failing harness and `retryHarnesses` from that point onward. This function does not roll earlier successful harnesses back as one transaction.

Two distinctions matter:

- all previews succeeded does not mean the later write environment cannot change;
- the failing harness may itself have partial effects before throwing. The coordinator's `completed` list does not enumerate every internal effect of that failed step.

This is not reported as a defect. Explicit partial-result reporting is useful. The remaining research question is whether the per-channel records and retry/cleanup semantics make those partial effects recoverable without overwriting user changes.

No failure was injected or observed in a real installation during U01-B. These statements follow the coordinator and apply source, not an executed failure scenario.

## 7. Installation state, health projection and usable capability differ

The ordinary installer and the Kimi apply path invoke `projectCanonicalInstallState` after obtaining the managed apply result. A returned projection warning is surfaced without turning that warning alone into a failed file installation. Thus managed install-state and the derived health projection are not interchangeable success surfaces. The projection helper and its consumers were not read in this unit; no stronger consistency guarantee is asserted. Sources: S28/S34/S44.

A separate capability boundary is explicit in S26: the `skill-unified-memory` module supplies workflow guidance, but installing that skill alone does not provide the `ecc memory` runtime. A package or reviewed checkout with the CLI is additionally needed. Invoking a repo-relative script from an arbitrary consumer repository is not the same as invoking the ECC runtime.

These examples support a bounded model:

`source available ≠ selected ≠ materialized ≠ recorded/visible ≠ admitted by host ≠ used effectively`.

This is an interpretation of the observed seams, not a new mandatory SOUL architecture or an assertion that ECC claims all stages are equivalent.

## 8. Counter-reading and limits

The strongest rival was that these were only cosmetic wrappers around one installer. Source dispatch, the provider-owned native path, the managed adapter and the separate legacy shell path contradict that simplified model. Shared helper reuse remains real; distinct entrypoints do not mean wholly independent subsystems.

Another overstatement would be that a successful installation check is worthless. Native reconciliation does validate registration/provenance; managed preflight has substantive identity/content checks. Their value must be scoped to the objects they actually check, not denied because they do not establish agent effectiveness.

This unit did not execute ECC code, upstream tests, installers, a host, models or a product-quality benchmark. It did not inspect an npm tarball or actual user cache. Legacy helper safety, ownership maintenance, uninstall/repair, link-transform correctness and host consumption remain open. The previous Node/Rust/native-workflow boundaries are preserved; no claim of complete integration is made.

The full recursive tree was requested through the connector, but its large response could not be recovered as a completely reviewed inventory. Acquisition/display limits must not become a false coverage claim. See [discovery update](../inventory/U01-B-DISCOVERY.md).

## 9. Disposition and next research

Q01b receives a bounded source answer for these installation channels. Q01 overall and Q01a's broader topology remain partial. Q02 portability is better specified by channel/operation, not closed for all hosts. Q03 opens the next high-value question: how current ownership evidence governs update, skip, retry and removal after partial application. Q08 keeps registration/presence/projection/host-effect predicates separate. Q05's CLI prerequisite is only a boundary observation, not a memory study.

The selected next unit is **U02-A: managed ownership and partial-application recovery**, with Kimi's guided path as a non-Codex consumer contrast. Begin with `scripts/lib/install/ownership-guard.js`, `scripts/lib/install-state.js`, and `scripts/lib/install-state-store-sync.js`, then the actual tests/callers they identify. All are discovered imports, not guessed file paths. The legacy helper is a later comparison dependency, not permission to expand into every installer at once.

P1's unresolved discovery remains a tracked obligation, not a falsely completed prerequisite. No final ECC-native synthesis can close while a known material family remains unexplained. The plan makes this sequencing explicit rather than repeatedly treating the entire inventory as a new U01 deliverable.
