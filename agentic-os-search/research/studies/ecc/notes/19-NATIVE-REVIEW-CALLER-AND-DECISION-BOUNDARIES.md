# Note19 — Native review, caller and decision boundaries

**2026-09-19 · U11-A / Q04h · bounded source answer with E08.** Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Source ledger](../evidence/U11-A-SOURCES.md), [E08 and complete raw record](../evidence/u11-a-review-flow-probe/README.md), [MR20](../ROUND-U11-A.md), [STATE](../STATE.md). Source observation, target procedure, dated host documentation, conditional inference and adapted local execution are distinguished here. No native Workflow, live model review, user repository operation or remediation ran.

## 1. The actual system boundary

The native pilot is a review-and-verification segment, not the entire Research–Plan–Implement–Review–Commit pipeline. Three responsibilities meet here:

| Layer | Actual source responsibility | What is not established by its presence |
|---|---|---|
| Interpreted command/skill | Gather request and diff, choose operation/phases, invoke a reviewer or Workflow, report findings and ask for human confirmation | That a host actually followed the instructions or that Git writes are mechanically blocked |
| Native review script | Select dimensions, collect findings, merge them, invoke verifiers and return blocking/advisory/incomplete data | Complete target identity, independent truth, human acceptance, commit or durable cross-session recovery |
| External host | Provide Workflow globals, agent execution, tool permissions and runtime continuation | That the pinned ECC script was installed or conformed to every actual API/version/permission mode |

The separate paths matter. `/orch-add-feature` delegates through its operation skill to `orch-pipeline`. That shared skill still names the ordinary code-reviewer or `/code-review` for Phase5. `/orch-review` separately instructs the host to call `workflows/orch-review.workflow.js`. The workflows README explicitly leaves native pipeline and installer wiring as follow-ups. We therefore do not turn the word pipeline into an already connected native execution graph. Sources: S23, S167, U11A-01–04.

This is nevertheless more than a list of specialist agents. The script contains concrete input checks, selection predicates, result composition and failure rules. The source question is which relationships those rules actually preserve from the supplied request to a returned decision.

## 2. Safe command input is not complete target identity

The `/orch-review` command distinguishes local uncommitted work from a GitHub PR. Local instructions collect changed paths and the HEAD-relative diff in separate commands, and stop if the diff is empty. PR instructions reject raw shell metacharacters and accept only a bare number or a valid-looking GitHub PR URL, extracting its trailing number before invoking gh. Restricting shell input is a real defensive instruction.

However, the shown PR commands carry only that number. The repository component of an input URL is not passed onward, and the command body does not set an explicit --repo. The official gh manuals describe a separate repository selection and GH_REPO environment choice. Consequently, if the operator supplied repository A's PR N while gh resolves to repository B, the literal prescribed commands can inspect B's PR N unless the host separately corrects the target. This is a conditional caller-contract result, not an executed wrong-PR incident. The same procedure can work correctly when target context agrees. Sources: U11A-01, W-U11A-GH-DIFF/ENV.

The workflow then receives diff text, language and changedFiles, not a repository/commit identity or an approval-bound diff digest. Its nonempty-string check does not parse or authenticate a unified diff. E08's non-diff input reached the fixture reviewer, confirming this admission boundary; the fixture's clean response says nothing about what a real reviewer would conclude.

Nor do separately collected paths and text establish one immutable snapshot under concurrent editing. The final result does not bind a later commit to exactly those bytes. These limits do not mean the text cannot be reviewed usefully; they mean reviewing a supplied view and approving the current intended repository revision are different responsibilities.

## 3. Complete selected review is not complete required coverage

Quality is always selected. A known language label adds its specialist; a lexical expression over diff and paths adds security review. The command derives a dominant language and may omit it for mixed changes. Security words are a concrete heuristic, not a semantic classifier proving that every sensitive change is covered.

`incomplete` is computed from failures of dimensions that were selected. It does not certify that selection included every dimension the real change needed. In E08, changing a supplied path to an auth-related name added a third dimension, while an ordinary path selected only quality/language. That demonstrates the predicate, not the recall or precision of security detection.

The source passes finding schemas to agent calls. HIGH/CRITICAL require a proof property, but its string has no nonempty or semantic-impact requirement. A schema-valid proof is not an independently justified finding. The source prompts ask for concrete evidence and discourage speculative findings; those are useful instructions, not measured model compliance.

The referenced quality reviewer also asks to inspect surrounding files and callers in the working tree. The adversarial verifier prompt instead asks for judgment only from the supplied diff and explicitly says not to refute an unapplied change just because its file is absent locally. This preserves a useful PR distinction, while leaving the adequacy and exact revision of each actor's evidence to the host/caller. Sources: S167, U11A-01/05, E08.

## 4. Merging can preserve severity while losing its supporting claim

The script merges findings by file and normalized evidence text. Normalization collapses whitespace and lowercases; line numbers are not part of the ordinary evidence-based key. This reduces duplicate verifier calls, but string identity is not automatically semantic issue identity.

When a matching key already exists, the merge keeps the first finding's fields and replaces only its severity with the stricter value and its dimension list with the union. It does not select or combine the later stronger title, proof, fix or location. It also does not validate the merged record again before passing it to the verifier.

E08 supplied two individually schema-valid findings for the same file/snippet:

| Input order in the review result list | Merged record observed |
|---|---|
| MEDIUM with no proof, then CRITICAL with a distinct proof | CRITICAL severity, first MEDIUM title, no proof |
| CRITICAL with proof, then MEDIUM | CRITICAL severity and original stronger proof retained |

Different snippets or files remained separate. The same snippet at two line numbers in the same file merged into one. These are deterministic observations from the fixed source body under the declared adapter. They are not a claim about native completion order: the adapter explicitly models parallel as ordered Promise.all, and the native parallel implementation was not verified.

The downstream fixture verifier returned a positive judgment only when the stronger proof marker reached its prompt. Under the first ordering it refuted the merged finding and the script returned APPROVE; under the reverse ordering it retained a blocker and returned CHANGES_REQUESTED. That controlled contrast shows that information loss can affect a consumer, not that an actual vulnerability was missed by an LLM. The proof and severity were stipulated, and the full diff still reached the verifier; a real reviewer could independently reconstruct the missing evidence.

The causal distinction is useful: the first-stage schemas can be honored, the verifier can process its actual input correctly, and yet the composed pipeline can present a weaker or different claim than the one that carried the strongest finding. Improving input formatting alone would not establish preservation through this merge. No replacement merge algorithm or upstream patch was adopted. Source: S167; execution: E08.

## 5. Existing failure guards remain real

The merge result does not justify calling the whole review fail-open. The script has explicit protections:

| Condition | Returned treatment |
|---|---|
| Reviewer returns null or rejects | Dimension recorded as failed; final result cannot be a clean APPROVE |
| Verifier returns null or rejects | Finding remains unverified and blocking |
| Verifier returns false with confidence below0.8 | Finding remains uncertain and blocking |
| Verifier confidently returns false | Finding becomes advisory |
| Verifier returns true | Finding remains blocking |

E08 exercised all of these paths with controlled responses. Empty diff and malformed path elements failed before any agent call. The command additionally instructs the main host to report Workflow-tool errors without silently substituting a hand-rolled clean review. These are positive controls with distinct implementation/procedure evidence classes.

The README's early claim about default refutation under uncertainty conflicts with its detailed explanation and the script. The body retains uncertainty. This was already noticed in U07-A and is preserved, not counted again as a new discovery. S23/S167 and the explicit E08 outcomes are the relevant sources.

## 6. Result labels are not stronger evidence than their predicates

Two additional semantics were observed.

First, a reviewer response's top-level verdict is not propagated. The script consumes its findings and recomputes the final verdict from blocking findings and failed dimensions. E08 supplied a schema-valid CHANGES_REQUESTED response with an empty findings array; the aggregate returned APPROVE. This is not necessarily wrong if findings are the intended sole authority, but a caller must not interpret the final verdict as unanimous approval by each reviewer. The source schema permits the discrepancy and the command does not expose a vote history.

Second, every non-unverified `isReal=true` is counted as confirmed regardless of confidence. The verifier prompt itself permits low-confidence true for uncertainty. E08's confidence0.2/true response stayed blocking, as intended, but increased confirmed rather than uncertain. Thus the blocking decision is conservative while the count can sound epistemically stronger than its predicate. No confidence calibration or independent proof follows from that label.

The verifier is called with a skeptical prompt, not an independently authenticated evidence source. The script does not force a different model or establish independence from the first reviewers' assumptions. Different roles and separate calls can still be useful, but their value depends on evidence scope, preserved information and actual error sensitivity. Source: S167; execution: E08.

## 7. Human gates and continuation belong to the outer system

The shared pipeline instructs the host to obtain plan approval before implementation and commit confirmation before Git commits. It carries planning documents and a task_list as handoff artifacts, and says unresolved HIGH/CRITICAL findings must clear before Gate2. The native command presents returned blockers and manual-confirmation needs. These are meaningful workflow obligations; they are not a revision-bound consent token, a checked Git hook or a demonstrated durable human-decision service in the examined bodies.

The native script does not write or commit code, ask for interactive approval, persist an approval record or run an automatic fix-and-re-review loop. Returning APPROVE from it is therefore not user consent to commit. Conversely, a human deciding what to do with unresolved findings is not replaced by the script's boolean result.

The current official host documentation distinguishes executable workflows from interpreted skills, keeps ordinary stage sign-off outside a running workflow, and makes launch prompts permission-mode dependent. It documents plugin-root workflow discovery and same-session resume, with replay limited to a completed start-order prefix; exiting the session starts fresh. These are dated host contracts, not an installed ECC observation. The linked full SDK reference was unavailable, so exact API/schema/parallel conformance remains open. Source: W-U11A-HOST.

The narrower native result can support a controlled process, but the outer caller must retain which revision was reviewed, what remains unresolved, which human decided and whether a later change needs another review. The current source study identifies that responsibility rather than implementing it. Sources: S23, U11A-01–05.

## 8. Source availability, plugin discovery and packed delivery differ

The ECC plugin manifest names ecc and points to skills and commands. Absence of an explicit workflows property is not alone evidence of unsupported discovery, given the documented default plugin-root directory. However, the npm package's explicit files list includes commands and orchestration skills but not the root workflows directory. The command's literal scriptPath also does not by itself resolve every installed-plugin or working-directory layout.

These are source-level delivery dependencies. No npm pack, installation or actual plugin lookup ran, and no universal claim that the command is broken in every channel follows. Git checkout/plugin distribution and npm selected contents are different paths. The README's installer follow-up remains a target statement, not a substitute for a current packed-artifact check. Sources: U11A-06/07, S23; host default as bounded above.

## 9. Evidence quality and bounded result

The source question is answered through the actual command, representative operation wrapper, shared pipeline, reviewer contract, native body and delivery/host boundaries. E08 adds one local adapted run with18 controlled scenarios; all38 non-null supplied responses passed a separate Draft7 check against captured source schemas. It does not add18 independent trials, a success percentage or a live review benchmark.

The experiment's strongest contribution is a concrete composition counterexample with negative/positive controls. Its limits are equally important: substituted agent behavior, assumed parallel ordering, no native host, no actual PR selection, no user approval, no package delivery and no semantic truth oracle. The complete record, source/probe identities and precheck are in the evidence package. An initially incomplete evidence transport was corrected and documented; it was not relabeled a target failure or hidden by changing outcomes.

**Q04h1 has a bounded source answer. Q04h2 retains stronger claims:** exact repository/revision and consent binding; actual native API/schema/permissions and installed discovery; semantic dedup and truthful/calibrated reviewers; full language/security coverage; real remediation/re-review, commit enforcement and cross-session recovery. The general orchestration family is not complete merely because this review segment is explained.

Next selected work is U11-B: the separate Rust scheduled-work admission path, from persistent schedule and due decision to launch/record association and retry/failure. Re-enter S189 daemon and actual S187 manager/S190 store/S186 CLI callers without reopening the completed basic lifecycle. Remote/delegation variants, other procedural families, host/provider, release/audit/observability, native syntheses and final omission challenge remain. Publication must close before another unit begins. No architecture or corrective implementation is adopted by this note.
