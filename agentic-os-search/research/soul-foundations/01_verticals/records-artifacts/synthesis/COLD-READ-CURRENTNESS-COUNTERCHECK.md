# Records Reading Architecture — Cold-Read / Currentness Counter-Check

**Document role:** ADVERSARIAL_AUDIT  
**Date:** 2026-09-01  
**Tested revision:** `records-foundation-2026-09-01-r2`  
**Scope:** evaluate the Records package as a reading/understanding/inference structure; not independent verification of the underlying research findings.

## Test question

Can a reader with no conversation context:

1. obtain a cheap but bounded orientation;
2. select the correct deeper topic without full-corpus reading;
3. avoid treating historical/pass-stage material as current conclusion;
4. distinguish current synthesis, adversarial audit, source ledger and primary source;
5. recover exact historical reasoning and exact source paths when needed;
6. detect drift among current derived surfaces?

## Scenario 1 — Normal surface-to-topic reading

Route tested:

`KEY.md → FINDINGS-MAP.md → synthesis/current/REQUIREMENT-DERIVATION.md`

### Result: PASS

- L0 gives the domain result and rejected shortcuts without requiring pass history.
- L1 identifies materially different problem areas and points directly to current L3 files.
- L3 contains the countercheck-surviving result rather than the pre-countercheck pass state.
- L3 routes deeper reading back through `INDEX.md`, preventing duplicated path logic from drifting across topic files.

### Efficiency effect

A bounded topic question can stop at L3 without reading the integrated L2 or all pass documents. A multi-topic question can use L2 first.

---

## Scenario 2 — Direct retrieval lands on an old synthesis path

Path tested:

`synthesis/REQUIREMENT-PROFILE-DERIVATION.md`

### Result: PASS

The file now identifies itself immediately as `HISTORICAL_PASS_SYNTHESIS`, states that it is not the current reading surface, names `current/REQUIREMENT-DERIVATION.md` as replacement, and preserves the exact pre-revision blob SHA.

The same protection was applied to the legacy positive syntheses; especially misleading provisional views such as `CONCEPT-BOUNDARIES.md` and legacy `FAILURE-MODES.md` are explicitly `SUPERSEDED`.

### Historical recoverability test

The exact old requirement-profile blob `0962c700a60b61339087cc676b422f07aa258c29` was fetched successfully after the path was converted to a historical stub.

Therefore current-tree clarity did not destroy research-history recoverability.

---

## Scenario 3 — Challenge path vs evidence path

Topic tested: requirement derivation.

### L4A — challenge/audit

`INDEX.md` routes to:

- the exact historical pass blob;
- `REQUIREMENT-PROFILE-COUNTERCHECK.md`.

This answers: `How did the reasoning develop and how was it attacked/calibrated?`

### L4B — evidence trace

`INDEX.md` separately routes to:

- `sources/requirement-profile-derivation.md`.

That ledger identifies exact source URLs, direct observations, research use and limitations, including ISO 15489, ISO/TR 21946 and NARA sources.

This answers: `Where did this claim family come from and what was the source scope?`

### L5

The ledger exposes the primary source URLs for exact/load-bearing recovery.

### Result: PASS

Adversarial reasoning and source provenance are no longer represented as one linear/depth-equivalent step. They are two different deep-reading purposes.

---

## Scenario 4 — Revision/currentness binding

`CURRENT-REVISION.md` binds L0, L1, L2, current L3 topic files and key routers to exact blob SHAs.

The current `synthesis/current/` directory was re-fetched after route corrections. The tested L3 SHAs matched the revision binding, including:

- change/time/standing `bee8197ff3490f94316c1b32cb6df40c1f116017`;
- object/identity `64296b4356f842dae49d9e6083766aa0b1ce66b1`;
- preservation closure `bb255435ad69a678326988931b3dd5d4af682810`;
- organisation/retrieval `94d5152050bf5cf501e86128c90e802e72f056b8`;
- requirement derivation `491c40143ede4bba16047796a5d5bd972e2f21f4`;
- mechanism landscape `9e2fe2fcafe802ec1f8b5be7dbc4d58e531df60c`;
- retention/disposition `244adcbd9108e8b0617e4caf8340bf81ddbb4ce3`;
- failure surfaces `73c9f99bfb052b87eb8b576ad8ec4a121248ff74`;
- completeness `0a7add99862bdc054410e9e21b0ee0066aea4952`.

### Result: PASS at repository/self-check level

This is not independent verification. It establishes repository currentness/persistence and creates a detectable failure if a derived surface changes without revision rebinding.

---

## Scenario 5 — Search/index freshness adversarial case

GitHub code search was queried for newly written/superseded wording after the repository writes. It returned no matches while direct repository file fetch showed the new content at the expected paths.

### Result: EXPECTED FAILURE OF SEARCH-AS-CURRENTNESS

This is a concrete instance of the Records retrieval finding:

> search/index visibility can lag canonical repository state; a search miss does not establish absence or currentness.

The package cannot force an external search index to refresh synchronously. It therefore protects interpretation by:

- making current files self-identifying;
- making old known synthesis paths self-identifying historical/superseded stubs;
- using `DOCUMENT-STATUS.md` and `CURRENT-REVISION.md` as repository-state controls;
- requiring exact fetch/source recovery when currentness is load-bearing.

---

# Residual risks after the redesign

## R1 — Claim-to-ledger routing is topic-level, not claim-level

Current L3 files route to the correct ledger family but do not attach a source anchor to every sentence/claim.

**Assessment:** acceptable for the current foundation package; if exact-claim recovery later proves materially expensive or error-prone, add stable claim/evidence handles rather than duplicating primary-source prose in higher layers.

## R2 — Revision binding is a maintained control, not an automatic invariant

A future editor can change a current file and forget to update `CURRENT-REVISION.md`.

**Mitigation already present:** SHA mismatch makes the drift detectable; the manifest explicitly instructs readers to treat it as stale when mismatch occurs.

**Possible later assurance:** automated validation can be added if repository tooling/scale justifies it. That is an implementation/process control, not a new Records semantic dimension.

## R3 — Historical audit requires blob recovery

Legacy detailed pass syntheses are no longer directly visible at their old path; the path is now a role/currentness stub and the exact old content is addressed by blob SHA.

**Trade-off:** current-tree safety improves while historical reconstruction needs one extra retrieval step.

**Assessment:** intentional and consistent with the package goal: ordinary reading should favor current meaning; deep audit remains exactly recoverable.

## R4 — L3 is a current interpretation layer, not a maximal-detail layer

The current topic syntheses are shorter than some historical pass syntheses because they integrate the stable result + surviving adversarial corrections. Full reasoning detail lives in L4A history/audit.

**Assessment:** intentional. `Deeper` means stronger contextual/audit recovery, not simply more words in each next file.

---

# Verdict

The redesigned package now supports a materially safer progressive-reading model:

`status/currentness gate → L0 orientation → L1 topic routing → L2 integrated result / L3 current topic → L4A audit or L4B evidence → L5 primary source`.

The prior central defect — deeper reading exposing stale pre-countercheck syntheses as if they were current — has been removed from the preferred path and explicitly guarded on the legacy paths.

The structure is therefore **fit for efficient bounded reading and selective deepening at the current Records foundation scale**, with the residual risks above kept explicit rather than hidden.

This verdict is a repository/self-review of the reading structure, not independent validation of the research content.