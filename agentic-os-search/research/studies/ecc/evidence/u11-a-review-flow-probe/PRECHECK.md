# E08 — Review-flow discriminator / pre-execution checkpoint

**2026-09-19 · NOT YET RUN at publication.** This is a bounded local control-flow fixture, not Claude Code Workflow execution, independent review quality, installed-plugin testing or a live model experiment.

## Object and authority

Original target: affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a, workflows/orch-review.workflow.js, Git blob 3fd502da40d77c46c28e0ed8b6845bb0072393ef. Connected source was read in full. Auxiliary raw acquisition failed DNS. A local reconstruction from the fetched text has been checked against the exact blob: 15,454 bytes, matching Git SHA-1. That correspondence check did not execute the target.

Installed local Node is v22.16.0. The fixture will run only under /mnt/data/ecc_u11a, with no host installation, provider/model, credential, user workspace, upstream change or candidate command execution. The reviewed script uses supplied globals; its export declaration will be converted to a local const, and its otherwise unchanged body wrapped in an async function. Explicit fake agent/parallel/log functions will supply deterministic responses. The wrapper is an adaptation, not the native host. Promise.all ordering and supplied exceptions/nulls are declared fixture assumptions, not verified host behavior.

## Questions and criteria fixed before execution

1. **Positive/negative control:** clean selected dimensions should approve; null or rejected reviewer results should mark incomplete and request changes. Empty diff and malformed changedFiles should fail before any agent call.
2. **Verifier boundary:** null/error or low-confidence false should preserve a blocker; confident false should demote it. A low-confidence true should remain blocking; separately inspect whether the reported category is confirmed or uncertain.
3. **Merge preservation:** supply two individually schema-valid findings for the same file/evidence: a first MEDIUM without proof, then a CRITICAL with distinct proof/title. Inspect whether the merged verifier prompt/output retains the stronger finding's proof/title. Reverse the order as a discriminator. Different evidence and different-file counterparts must remain separate. No live defect claim follows from a supplied finding.
4. **Downstream sensitivity:** a deterministic fake verifier that changes answer only when the distinct stronger proof reaches its prompt will show whether any merge loss can change the returned verdict. This is controlled information-flow evidence, not a model-quality oracle.
5. **Verdict contract:** a schema-valid CHANGES_REQUESTED with no findings will reveal whether the reviewer verdict itself is propagated or whether the aggregate is recomputed solely from findings/failures.
6. **Selection/input scope:** a nonempty non-diff string with clean supplied reviews, and a changed path without a security-trigger token, will expose actual admission and selected-dimension counts. They will not establish that real reviewers approve invalid diffs or that the regex misses a measured vulnerability.

Non-null supplied responses will be checked against the schema passed by the original workflow, using a local JSON Schema validator where available. A schema-check failure, source mismatch, harness failure or unexpected assertion must remain in the record rather than being silently excluded. Raw inputs, callbacks' supplied replies, prompts, result/error and environment will be retained. No tests will be counted as independent trials or a performance success rate.

## Decision rule

If the merged record loses the stronger proof while either ordering/input retains it before merging, record an observed deterministic composition boundary. If it preserves it, revise that source hypothesis. Existing failure guards must remain visible regardless of the merge result. No remedy, upstream issue or broader test campaign is authorised by this fixture. Publication and source-study closure are separately owned by STATE.
