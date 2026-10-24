# Note55 — Evaluator fixtures, oracles and promotion claims

**2026-09-24 · U19-G / G6 / O3 / Q01a2g / MR56 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U19-G-SOURCES.md), [method round](../ROUND-U19-G.md), [STATE](../STATE.md). Source/history observations, author claims, conditional deductions and executed results remain distinct. No target execution, installation, model/service operation, promotion or E11.

## 1. Result: a checked example contract, not the decision-making evaluator

The selected `examples/evaluator-rag-prototype/` route supplies a committed example corpus: scenarios describe what evidence and actions are appropriate; traces narrate phases; reports assign scores; verifier-result files store accepted/rejected candidates; playbooks prescribe later maintainer work. The inspected test reads these files and checks selected expected values and text. The actual recursive test runner discovers and can execute that test. This is a real documentation/fixture regression mechanism, not merely an uncalled description.

It is not, on this traced route, an evaluator that retrieves the referenced PRs or scanner reports, executes candidate procedures, computes their quality, chooses a winner and deploys it. The test treats the supplied decisions as data to compare against hardcoded expectations. Its outcome concerns fixture-contract conformance, not independent confirmation that the candidate deserves its decision.

This is a narrower legitimate role, not proof that ECC has no evaluators. [Note17](17-RUST-EVALUATION-REGISTRY-AND-USE.md) describes a different implemented recorded-evidence registry with transactional promotion; [Note18](18-OFFLINE-CAPSULES-REPLAY-AND-RECEIPT-SCOPE.md) describes executable evidence utilities and an explicitly unavailable candidate gate; [Note11](11-GOVERNANCE-EVENTS-PERSISTENCE-AND-DECISION.md) separates emitted events from stored decision standing. None is connected to this fixture corpus merely by sharing words such as trace, accepted or promotion.

## 2. Provenance and the actual chain

The path-filtered history located `dcf5668b27e2dc477ff2494b6eae88c601004653`, merged on 2026-05-12 through PR1824, titled `docs: add evaluator rag prototype`. The PR explicitly calls the five records fixtures. Its complete nine-path change list contains the five root artifacts, three documentation files and the test. The historical root verifier-result has the same Git blob as the research-pin result: `027eeab6966cd018e21e4429703098109eee5a10`. [HISTORY, PR1824, RESULT-OLD]

This recovers publication lineage and intended role. It does not recover the author's private generation process, authenticate every narrated retrieval, or independently verify the PR's reported test totals. A Git commit identity or GitHub signature cannot turn the stored scores into measured candidate performance.

| Link | Actual source and responsibility | What it does not establish |
|---|---|---|
| Evidence selection | ROOT-SCENARIO / POLICY-SCENARIO name documents, PRs, scanner categories and questions | Sources were fetched, remained unchanged, or support the conclusions |
| Recorded account | ROOT-TRACE / POLICY-TRACE narrate observation through promotion | An instrumented run generated those events in that order |
| Report and verdict | ROOT-REPORT / RESULT and POLICY-REPORT / POLICY-RESULT store scores and labels | Score computation, independent judgment or real policy changes |
| Regression check | TEST reads JSON/Markdown and asserts selected fields/strings | Reperformance of the narrated work or full semantic validation |
| Test-suite caller | RUNNER recursively selects `tests/**/*.test.js`, launches the child and counts failure/exit results; PACKAGE supplies the npm test route | Every dependency was present or the suite actually passed here |
| Subsequent use | Playbooks ask a maintainer to retrieve current evidence, create/review work and record validation | An automatic promotion-to-action or authenticated approval transaction |

Two complete five-artifact sets were joined: stale-PR salvage and AgentShield policy exceptions. TEST was fully read for all seven named scenarios. The other five sets' bodies were not newly read; their scenario-specific semantic correctness is not inferred from these representatives. Selection contrasts a repository maintenance procedure with a security-exception decision, not seven independent replications.

## 3. Useful controls and the limits of their oracle

TEST checks the root schema-version strings; scenario IDs agree across the root trace/report/verifier; their `read_only` fields equal true; required phase names occur; named accepted/rejected candidates exist; selected decision and promotion values match; and the root accepted score exceeds the rejected score. It also checks required phrases in the scenario and playbook. Other scenarios repeat selected ID/flag/gate/decision/text checks with scenario-specific expectations. These are executable assertions with a nonzero failure path. [TEST]

Positive conditional controls: changing a checked scenario ID, flipping a required decision, or removing a checked prohibition causes the corresponding assertion to fail. This is meaningful protection against specific fixture regressions. It is not an observed test run in this research.

The test named as accepting salvage and rejecting blind imports calls `readJson('verifier-result.json')`, finds two predetermined IDs and compares their stored decisions. It never submits a bad proposal to a decision function. The rejected candidate is an illustrative negative example, not evidence that a running evaluator rejected new bad input. Likewise, finding the words for a forbidden action checks that the example lists a prohibition; it does not attempt that action and observe enforcement.

The root report's score dimensions and `prototype_passed` result are not recomputed. Its schema-version string, scenario ID and read-only flag are inspected, not its run ID or result-bearing fields. The accepted-versus-rejected score ordering check is specific to the root verifier file; it is not a comprehensive scoring rule for all seven families. No observed score calibration, sample independence or improvement follows.

## 4. A concrete same-scenario / different-run counterpart

The root trace, report and verifier contain a shared `run_id`, but TEST does not compare it. It also does not inspect ROOT-REPORT's `result`, findings, score values or recommended candidate. Under otherwise valid unchanged fixtures, changing only that report's run ID and result to describe a different failed run leaves the tested report fields unchanged. The inspected test therefore has no assertion that distinguishes that inconsistent combination. [ROOT-TRACE, ROOT-REPORT, RESULT, TEST]

This is a conditional source deduction, not a mutation experiment or a claim that current stored IDs actually disagree. It demonstrates why same-scenario conformance is not same-run evidence binding. A future report consumer that trusted `prototype_passed` or the recommendation would need a different check; no such future consumer is assumed active here.

A second boundary is evidence retrieval. Changing a referenced source's contents while retaining its path need not change the checked strings. This test performs no network retrieval, referenced-document hashing or semantic comparison. Several root references are real PR URLs rather than anonymous placeholders, which improves traceability; a useful locator still does not establish that the supporting bytes were used, are current or were assessed correctly.

The causal distinction is not simply too few tests. The chosen test object is the example representation. Adding more assertions that the same expected labels remain present would not itself produce an evaluator or independent evidence. The appropriate conclusion is to keep the fixture-regression verdict at its actual scope.

## 5. Security-exception wording versus a current security decision

POLICY-SCENARIO and POLICY-PLAYBOOK request a named finding, scanner evidence, policy source, owner, ticket, scope, expiry and a remediation-versus-time-boxed-exception choice. They reject blanket suppression and keep live policy modification outside the evaluator pass. These are valuable procedural requirements. [POLICY-SCENARIO, POLICY-PLAYBOOK]

POLICY-TRACE says those facts were retrieved, but its evidence entries include descriptions such as a SARIF result pattern and report exception counts, not the actual finding, responsible actor, timestamped exception and scanner output. POLICY-RESULT records reasons saying those fields are preserved; it does not contain concrete owner/ticket/expiry values that this test validates. The test checks that the relevant requirements and expected rejection text are present, without parsing a SARIF artifact or comparing an expiration time with a clock. [POLICY-TRACE, POLICY-RESULT, TEST]

Thus the file can be a model of the required decision record without proving that a particular live exception is valid now. The test itself has no policy-write operation, which supports its narrow non-mutating role; `read_only: true` alone is not an operating-system permission boundary or proof about the producer's past actions. The later playbook directs a capable actor to obtain current evidence and retain a human-readable handoff. Execution, approver authority and final policy effect remain separate.

## 6. The hosted claim is another source and another system

The inspected roadmap row says that separate ECC-Tools PRs68–72 turned the corpus into hosted PR checks, cached-output scoring, retrieval planning and gated model-judge execution. The prototype contract still describes future hosted consumption. This is dated cross-repository rollout prose, not sufficient evidence that the local example test performs those operations. [ROADMAP selected row, CONTRACT]

TEST checks that the roadmap contains the sentence claiming integrated hosted functionality. It does not inspect ECC-Tools source, call the service or validate the integration. Therefore that assertion can preserve the existence of a product claim, not establish its truth. The reported external implementation must not be discarded as impossible, but must not be certified by this test either.

No external ECC-Tools study or live service inquiry was opened. Its implementation, final consumer identity and execution results remain an explicit boundary for any stronger hosted-system claim. That boundary does not require inventing an unknown local producer or indefinitely searching for a hypothetical one: the inspected current caller is a fixture test, the addition PR names that role, and the roadmap names a different repository for the stronger role.

## 7. Disposition and remaining research

Q01a2g1 meets the selected criterion: publication lineage, two complete artifact chains, full validator, actual test-suite caller, useful checks, same-run countercase and downstream actor/external-system limits are identified. No independent experiment, model judgment, security approval or deployed improvement was observed. Stored scores are not adopted as performance evidence.

Q01a2g2 preserves unobserved authoring/trial provenance, referenced-evidence truth/freshness, other five fixture bodies' semantics, fuller run/revision/criterion binding, actual hosted implementation and authenticated deployment/outcomes. These are explicit stronger/reopening limits, not proof that every possible consumer is absent. A demonstrated different local consumer or oracle reopens this source account. A new unit for every similarly shaped example is not required merely because its text has not been semantically evaluated.

**Next selected U19-H / G6 / O3: remaining document/media materiality disposition and synthesis-entry decision, NOT STARTED.** Return to Note54's exact remaining corpus, the original U19-A disposition and current evidence routes. Give the linked docs troubleshooting/GA-roadmap remainder, relevant history/translation/example variants and consequential images/assets an explicit role/depth disposition. Distinguish evidence needed to change the ECC-native explanation from advice, historical proposals, illustrations and stronger external claims. Then either name the remaining necessary source or admit revised CORE preparation. Do not automatically open the hosted products or claim exhaustive source/media coverage.

This closes U19-G's bounded role inquiry, not O3/G6 or the whole ECC study. Original notes, experimental identities and question inheritance remain unchanged; no SOUL/Development OS architecture or upstream fix follows.
