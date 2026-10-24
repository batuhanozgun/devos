# U02-A — Source coverage and evidence boundaries

**Date:** 2026-09-17. **Primary target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. No repin. IDs continue [U01-B](U01-B-SOURCES.md). This unit is SOURCE OBSERVATION, TEST SOURCE INSPECTED and qualified INFERENCE; **no new ECC execution**.

All paths below resolve under `https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/`. Blob identities bind the actual fetched files. FULL means reading through the file's end, not full dependency, platform or runtime coverage.

| ID | Pinned path | Git blob | Actual read scope and role |
|---|---|---|---|
| S45 | `scripts/lib/install/ownership-guard.js` | `962c62e8835f0550ccdca05e499a16391f436491` | FULL, request 1–230 reaches EOF. Common copy-file ownership filtering, late collision and unwritten-file preservation |
| S46 | `scripts/lib/install-state.js` | `3b5b7fc231a65ae8099734eb5f4af85b7e71f51d` | FULL, 1–250 + 251–EOF. Structural validator, optional content digest, record creation/read/write. Separate schema file not compared |
| S47 | `scripts/lib/install-state-store-sync.js` | `fb31c6aa04712e85f95ef4ddd894d0599c58e228` | FULL. Wrapper, derived-store warnings and close-failure boundary |
| S48 | `tests/scripts/ownership-guard.test.js` | `4c16afd2e8a405764fc4dd5b8951574d73f99af4` | FULL TEST SOURCE, request 1–260 reaches EOF. Existing unowned content across adapters; changed managed content; late collisions; unwritten prior hashes. NOT RUN |
| S49 | `scripts/lib/state-store/install-state-projection.js` | `d63ba7911c23dc58b251b3fd0dd7acd248ec8fbd` | FULL, 1–240 + 241–EOF. Projection fields, scoped reconciliation, invalid/missing-record treatment and separate managed-file health |
| S50 | `tests/lib/multi-harness-setup.test.js` | `24b5a5f45a8c29aca6e14186f0f32de8225500ba` | FULL TEST SOURCE, 1–240, 241–500, 501–780 reaching EOF. Guided Kimi identity/digest and late-change checks; identical-file preservation; mocked orchestration and projection boundaries. NOT RUN |
| S51 | `scripts/lib/install-lifecycle.js` | `ec9cb1d801a3e638a9befaca1ece7427b47b881e` | SELECTED 1–480 only. Imports, recorded-request reconstruction, digest predicate, transformed expected content and path helpers. Remainder, full doctor/repair/uninstall call paths NOT READ |
| S52 | `scripts/lib/install/claude-skill-migration.js` | `adc9170b3032ab6115b1e1531ef2c6684b1c7a4f` | FULL, 1–230 + 231–460 reaching EOF. Non-Claude disabled-migration branch still creates a bridge; generic state union and Claude-specific migration separated |
| S53 | `scripts/lib/state-store/index.js` | `49b6204d635330401ede6fd734c72f9588466f78` | FULL, 1–160 + 161–EOF. Projection import/export and store factory confirmed; SQL adapter/persistence source read, not executed or concurrency-qualified |
| S54 | `scripts/lib/install-targets/kimi-project.js` | `dd1bf11d8b9ed80ef1dc7807ade8b7842c944828` | FULL. Actual project root `.kimi-code`, compatibility source mapping, skills and MCP-merge operation production |
| S55 | Contents API: `scripts/lib/state-store` at the pin | Directory response, not a blob | FULL direct listing: index.js, install-state-projection.js, migrations.js, queries.js, schema.js. Original JSON array read to its closing bracket; only duplicated response metadata was display-truncated. No repository-wide inventory claim |

## Retained caller evidence, not new independent readings

The same conversation's pinned full reads remain applicable: S28 ordinary/guided install entry; S32 runtime dispatch; S34 multi-harness setup including `readOwnedDestinations`, `preflightManagedPlan`, `applyPreflightedManagedPlan`; S38 plan; S39/S41 target registry/helpers; S44 apply engine. Their source is available in [U01-B ledger](U01-B-SOURCES.md); the current analysis follows their exact call and failure bodies alongside newly opened dependencies, not the prior prose summary alone.

U01-A E01 is unchanged historical evidence. No rerun or additional independent observation was made. Earlier official host-document checks are not needed to establish this unit's source-local results.

## Claim bindings

- Common versus guided ownership: S45/S46/S48/S50/S54 plus S28/S34/S44.
- Identical bytes do not acquire managed ownership: S45, S50's initially-identical preservation case and S34's preflight classification.
- Bridge before writes and preservation after failure: S52 → S45 → S44; S48 assertions. Caught exception handling is not proven power-loss recovery.
- Missing/unwritten operation versus guided retry: source-derived path through S52/S45/S44 and S34. **Not executed**; operational prevalence and supported end-to-end recovery remain open.
- Canonical JSON versus projection versus file health: S46/S47/S49/S53; full SQL queries and doctor consumers remain outside this slice.
- Removal of modified user content is not independently established by a helper name: S48 contains relevant assertions, but S51 is selected-only and no uninstall was run.

## Test-oracle limits

S48 varies registered adapters but narrows each first ownership case to one real planned copy operation. It exempts the OpenCode build precondition for that purpose. That is not a full installed-host matrix. Its Antigravity reinstall case explicitly expects modified managed bytes to be restored from source.

S50 uses temporary filesystem fixtures and constructed Kimi plans. Some mutation cases replace the health projection with a stub; the cross-harness partial-result cases inject apply functions that throw. These distinguish useful local contracts but do not test a real model, a complete native install, or an actual second guided run after a two-file partial install. The fixtures' root arrangement is not the actual CLI installation journey.

No upstream tests, ECC installer/helper, host, model, database, network service, new local probe or effectiveness benchmark was executed. Reading assertions is not a passing test result.

## Discovery and access

The state-store listing adds a bounded usable inventory: index/projection were fully read; migrations.js (`7716c992589341e4db89a403139a2fd7db040894`, 5570 bytes), queries.js (`0225f476182ab68c77285d1e2f398637b7c20bbc`, 26677 bytes) and schema.js (`915e0481d3ff8d810573ef0f9f6bae8cb3151e76`, 2175 bytes) were only discovered. P1 remains partial. Prior root frontier and Node/Rust/native-workflow distinctions are preserved.

A container-side raw GitHub retrieval failed at DNS; no new checkout was obtained. A supplementary web open failed and the narrow web search returned unrelated results; none supports the research. Canonical GitHub connector reads succeeded. Acquisition failure is not an ECC failure. No unreviewed third-party result was added to the corpus.

Project preflight recovered current STATE, METHOD, INDEX, META, QUESTIONS, current log/ledger entries, MR02 and discovery delta. Same-conversation pinned WHY/PLAN/Note 02/source/publication reads were retained at their recorded boundaries. This is not an independent fresh-session test.
