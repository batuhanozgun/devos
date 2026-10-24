# U01-B / Note06 — Evidence qualification at producer–consumer boundaries

**Date:** 2026-09-12. **Standing:** source observations plus eight bounded local diagnostic groups, not end-to-end system verification. [Note05](05-TERMINALBENCH-OPTIMIZER-LIFECYCLE.md) retains the positive native mechanism. [CHECKS](../evidence/2026-09-12-u01b-terminalbench/CHECKS.md) separates execution from inference; source IDs are in [SOURCES](../evidence/2026-09-12-u01b-terminalbench/SOURCES.md).

## E01 — Existing failure and absent attempt have different numerical effects

The source correctly counts an existing trial directory with no usable reward as failure. It does not enumerate attempts that have no directory. In B01, an independently specified synthetic two-task/two-attempt population contained one success and three failed records, yielding 0.25. Removing one failed directory changed the computed rate to 1/3. Removing all directories for the second task then changed it to 1.0 without adding a single success. The wholly absent task produced no task-specific warning. At equal comparison scope in the fixture, the incomplete candidate displaced a complete 0.75 baseline in the native frontier. [T03; B01–B02]

This is not an observed 25%→100% change in the real benchmark or evidence of intentional result deletion. It establishes a narrower mechanism: the parser/selector alone does not carry the independent expected evaluation population. Whether real Harbor provisioning always materializes every required directory is a separate producer-side question.

The two legitimate goals must not be collapsed: count a materialized failed attempt honestly, and establish whether every required attempt is represented. Setting all unknown outcomes to zero is not the only defensible policy; excluding, retrying, bounding or refusing comparison may be appropriate under different purposes. A valid policy must preserve what is unknown rather than silently change the denominator.

## E02 — A helper's safe return can be discarded by its consumer

`harbor_run` returns no success signal on timeout. Candidate evaluation checks it. Baseline seeding later parses whatever directory exists, and final evaluation discards the signal before reading an existing directory. The first-party timeout test checks the helper result, not those caller continuations. [T03, T05]

The source-supported failure chain is: incomplete job → helper reports failure → caller re-enters artifacts on directory existence → partial population can be interpreted as a comparable score. B02 tests the latter population rule, not an actual timeout or the full chain. The same failure class could also arise through interrupted materialization or stale result reuse. Repairing one timeout branch would not by itself prove complete coverage or freshness.

## E03 — Declared configuration and effective dispatch can diverge

B07 ran the exact `run_eval.sh` blob against fake `uv`. Inherited `HARBOR_MODEL=synthetic/parent` appeared in the normal Harbor argument vector. An isolated local `.env` changed that to `synthetic/override`. Invalid environment selection exited before either fake validation or fake Harbor dispatch. [T04; B07]

The invalid-environment rejection is a real positive control. The override is not inherently wrong: it may be intentional configuration policy. The issue is attribution—proposer context, cache comparison, recorded experiment specification and actual child invocation must agree or explicitly record the difference. This probe stops at shell argv/environment, not provider execution.

## E04 — Improvement history and artifact identity are independent of scalar accuracy

B04 started at 0.60, added a candidate scoring 0.75, updated the frontier and then wrote the summary. Stored delta was 0.0, not the independently calculated 0.15. The summary's reference point was the just-updated frontier. A later same-name score of 0.10 left the best entry at 0.75. Its identity fields were only agent name and average pass rate. [T03; B04]

Keeping a historical best is legitimate. Treating that record as qualification of the current same-named code is not justified without a binding rule. Similarly, a zero delta can be correct relative to the current frontier while misleading when read as improvement relative to the prior iteration. A useful adaptation history needs comparator identity and time, not merely a numeric field.

## E05 — A failure-tolerant observation can become a false statement about reality

The selected artifact's snapshot method catches execution exceptions and tolerates missing tools, aiming not to break normal exploration. Yet partial stdout can survive. B05 supplied nonzero-return output containing a working-directory section and an empty LS section; the method returned an environment snapshot calling `/app` an empty directory. It did not examine the supplied return code. [A01; B05]

B08 then tested the native compound shell command itself using a fake failing `ls`, with no real language/package probes available in PATH. The `&&` chain stopped before the later sections; the final `|| true` produced exit zero. Feeding that actual partial stdout to the snapshot method again produced the empty-directory label. The snapshot's availability fallback and its representation fidelity are therefore different properties. [A01; B08]

This does not establish that the paper's task environments lacked `/app`, that historical models were misled, or that the bootstrap's measured net effect was negative. It shows a concrete boundary requiring scrutiny when transferring the mechanism to other environments.

## E06 — Metrics are measurements over a particular observation population

In B01, success computation counted four trial directories while usage summarization reported two readable result records and cost 2.0. The synthetic number is not a real dollar estimate. The difference follows from separate parsers: missing/corrupt trial files count as failed rewards but have no readable usage record. [T03; B01]

B03 also showed that three positive fractional rewards of 0.01 yield a success rate of 1.0 and are included despite an expected count of two. The positivity predicate can be appropriate for binary task rewards; it cannot be generalized to arbitrary continuous rewards without changing metric meaning. Unsupported JSON shape `[]` raised AttributeError rather than being converted to failure. These are limited schema/metric diagnostics, not a claim that normal Harbor result files have those shapes.

No live budget, infrastructure cost, provider billing, cancelled job cost or statistical uncertainty was measured. A mean over observed costs must not be renamed total search cost.

## E07 — Protocol placeholders, observed effects and verification verdicts differ

Both the reference baseline and selected agent append tool-result text `executed` to chat history before the outer agent loop actually performs commands or image reading. Actual observations are supplied afterward through a subsequent prompt and trajectory entry. This is a protocol/history design, not a reliable per-call execution receipt. [T07, A01]

The tool parser can collect commands and an image request together; the operating loop takes the image branch when an image request exists. The presence of an earlier placeholder therefore does not demonstrate that every parsed action took effect. This is source-only, not a mixed-tool runtime experiment.

The double `task_complete` confirmation is a same-agent reconsideration gate. It is not the task verifier's verdict or independent review. A complete account must retain all three surfaces: proposed action/protocol response, actual observation, and evaluator judgment. Calling them all verification would hide material differences.

## E08 — Similar code and shared names do not establish the same experiment

The current reference and historical selected artifact differ in dependencies, logging interfaces, version/name metadata and bootstrap behavior. The selected artifact allows Harbor >=0.1.44 and LiteLLM <1.82.7; the reference pins Harbor 0.18.0 and LiteLLM 1.84.10. The reference's tests do not validate the selected artifact under every version allowed by its range. [T02, T05, A01–A02]

A small set of pinned Harbor source sections was recovered to check the CLI and inherited loop caller. This is stronger than guessing from today's documentation but weaker than verifying an installed wheel, complete inheritance chain or historical environment. Neither current incompatibility nor historical validity is settled by importability alone. Do not attribute every difference from the current baseline to the optimizer's original discovered intervention.

## Provisional synthesis and bounded bridge

The sources suggest an operating/change loop with multiple evidence transfers: declared work → effective invocation → attempted work → materialized result → interpreted score → selected name/artifact → proposed future change. Each transfer can preserve bytes while changing what is warranted. Controls must compose across the consumer boundary, not merely exist inside a helper.

For SOUL/Development OS, the candidate reuse question is therefore not only which memory, tool or harness mechanism to choose. It also includes what evidence makes an observation usable, a comparison fair, a past result reusable and a change acceptable. These are design pressures, not a prescribed schema, fifth Foundation ground or permission to modify agent-control.

Positive safeguards, falsifiers and scope limits are retained together. No malicious manipulation, universal insecurity, paper invalidation, live quality gain or independent replication is claimed. The five local mutants discriminate selected semantics only; they are not a product reliability score.
