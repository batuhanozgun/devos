# Note30 — Readiness predicates and operator projections

**2026-09-21 · U14-A / Q08a · bounded source answer.** Fixed ECC target 8321021c54d670126ce3b2969d5deb880b4b0c2a. [Sources and exact reading scope](../evidence/U14-A-SOURCES.md), [MR31](../ROUND-U14-A.md), [STATE](../STATE.md). No target command, test, live probe, host/model, installation, workflow or E10 was executed. Conditional cases are source-derived, not observed operational incidents.

## 1. Native roles: readiness for what?

ECC does not expose one interchangeable readiness predicate. The followed implementation has three related but distinct producers:

| Producer | Actual input and output | Useful role and boundary |
|---|---|---|
| observability-readiness | Repository files, text markers and a small example-JSON shape → score/checks/ready | Local availability of selected source/document surfaces; not delivery of live telemetry |
| platform-audit | Local Git status, selected live GitHub lists/discussions and historical document predicates → checks/totals/ready | Repeatable queue/worktree/document inspection with explicit failure and skip fields |
| operator-readiness-dashboard | Actual platform report plus launch-specific document markers → objective requirements, dashboardReady, publicationReady and next-work text | An operator snapshot and prompt-to-artifact checklist; not a release-authorization service |

The observability document explicitly calls its first gate local, opt-in and file-backed. It says no telemetry is sent and instructs the operator to run separate loop-status, session-inspection, audit and synchronization tools. Not measuring live signals is therefore not automatically a violated promise. The inference boundary is whether success of the preparation check is later treated as proof that those signals are enabled, delivered, complete or useful.

Likewise, the dashboard explicitly says it is a snapshot rather than release approval. Its conservative publication boundary is real. The important research question is how strong each intermediate label is, and whether the next consumer preserves its conditions. Sources: O-GATE, O-DASH, O-PLATFORM, D-OBS.

## 2. What the observability score actually establishes

O-GATE reads named source/document files. Ten checks cover loop status, HUD/session-control shape, session adapters, harness audit, hook activity, ECC2 tool-risk logging, release onramp, progress synchronization, release-safety material and package exposure. They total21 points; ready requires the full total. Point weights also prioritize up to three suggested fixes. This is not a confidence probability or percentage of real work completed.

Most predicates are file existence plus literal includesAll checks. The HUD example additionally needs the exact schema_version and named top-level own properties; the values of those properties are not validated as actual observations. The implementation does not execute loop status, deliver a tool event, query the risk ledger, compile Rust, invoke the cited scanner or contact a tracker. It does not inspect whether referenced test bodies passed.

A concrete contrast is the upstream minimal fixture: source files are short strings containing the expected tokens, including nonexecutable Rust/JavaScript stand-ins. The checker can satisfy its own predicates with that fixture. This is appropriate for a unit test of a marker-based contract, but not proof of runnable source or a functioning observation pipeline. An equivalent ordinary source change that removes behavior while retaining marker strings can leave the readiness predicate unchanged. Conversely, removing a required marker, contract file or release link can really make it fail. Both directions matter.

Read failures become empty text for these local predicates and can therefore fail affected checks. A nonexistent root also encounters realpathSync during report construction and can throw; do not import Note29's scanner-specific empty-root success behavior into this different program. The rubric's date and deterministic flag identify a fixed checker convention, not current telemetry capture. Sources: O-GATE, T-GATE, D-OBS.

## 3. A false report is not necessarily a failing command — but a real CI consumer exists

The normal observability CLI renders the report and returns. It does not set a nonzero process status merely because ready=false. Its top-level catch does exit1 for actual errors. Thus a shell caller relying only on successful command completion can continue after a negative readiness report. The official Node process contract explains the normal zero exit; no command was run here.

It would nevertheless be wrong to conclude that readiness never blocks anything. T-GATE invokes the real CLI against the current repository and explicitly asserts parsed.ready=true. Its test runner exits nonzero on failed assertions. C-SUITE recursively discovers tests/**/*.test.js, runs each file, preserves subprocess failures even if printed counts omit them, and returns a failing aggregate status. The previously read CI test lanes invoke C-SUITE.

The useful executable chain is therefore:

`current repository → readiness JSON → test assertion → test-file exit → suite exit → CI test job`.

That chain checks the original surface rubric, not live telemetry. Reading its source does not show a CI run occurred, nor that every release path requires that exact CI result. Note28 retains the separate real release prerequisites and external-policy limits.

O-DASH and O-PLATFORM expose another deliberate policy choice: their default CLI emits a report, while --exit-code opts into a nonzero result for negative readiness. These are reporting tools that can be wrapped as gates; invocation options and parsed fields determine the caller's policy. Sources: O-GATE, T-GATE, C-SUITE, O-DASH, O-PLATFORM, prior W-CI; W-NODE.

## 4. The operator checklist can mark a check complete without consuming its verdict

O-DASH really calls buildPlatformReport; its live-data path is not just a label. But its observability-for-self-use requirement is a different predicate from O-GATE. It checks the package script mapping and a documentation marker. It neither invokes O-GATE nor consumes its score/ready output, and that particular predicate does not require the gate file to exist.

Consequently a source tree with the expected package mapping and documentation text can mark this row complete even if the named gate script is missing, or if its ten-check result would be false because a risk-logging source surface is absent. This is a row-level projection, not whole-dashboard readiness or permission to publish. It records preparation at a weaker granularity than the underlying checker.

Other launch requirements similarly inspect source/document evidence rather than re-performing the claimed activity. Preview readiness looks for script registration, file presence and characteristic marker strings. Video status can move to current when a dated evidence document contains fixed successful-count/self-evaluation phrases; the dashboard does not inspect the video files. Supply-chain status recognizes runbook/workflow/package markers, not the latest scanner/advisory report. Linear progress becomes current from roadmap phrases and selected identifiers plus the progress contract, not a live Linear readback.

These rows retain useful gap text, often explicitly requesting a fresh check before publication or after a merge. The problem is not that every preparation row must execute a production action. It is that current/complete and the resulting next-work selection must not be read more strongly than the predicate. A retained historical statement can keep a row current after the represented external condition changes. Several evidence strings are generated descriptions, not independently acquired records.

There is even a source-to-view-to-source relationship: O-PLATFORM inspects text markers in a historical generated operator dashboard, while O-DASH invokes O-PLATFORM to generate a new dashboard. This can check that a previous reporting surface remains present; it does not constitute an independent second observation of the real platform. No circular-propagation incident was observed. Sources: O-DASH buildRequirements and marker helpers, O-PLATFORM buildLocalEvidenceChecks, T-DASH/T-PLATFORM.

## 5. Error-aware collection can become an affirmative-looking table

The platform collector provides genuine controls. Git status is attempted; GitHub commands and JSON parsing can fail explicitly; per-repository exceptions are retained and counted. Discussion availability is checked before the heavier query. Budget excess, sampled discussion gaps, conflicting sampled PRs and missing local material can become failed checks and top actions.

However, the meanings are different across the transformations:

| Input condition | Platform result | Operator projection |
|---|---|---|
| Successful supported GitHub reads within budget | Counts and passing fetch/budget checks | Detailed queue requirements can become current |
| GitHub explicitly skipped | Zero totals, skipped=true, fetch warning | Platform ready may remain true if local checks pass; detailed operator queue rows remain in_progress |
| All selected repo reads fail | Zero fallback counts plus errors and failed fetch check | dashboardReady=false and detailed queue requirements remain in_progress; Markdown overview can still label PR/issues/discussions Current |
| Local Git unavailable | available=false, error, empty dirty arrays/count0, warning | Platform warning need not block ready; Markdown local-worktree row can say Current from the zero count |

The key loss is in renderMarkdown's Current Status table. Its queue/discussion labels inspect counts and whether GitHub was skipped, but not githubErrors. A failed query is not skipped, so zero fallback counts meet its Current conditions. Other sections still carry incomplete requirements and dashboard failure; this is not total error suppression. It is a conflicting high-level view that a reader or downstream text consumer could mistake for a clean observation.

The same table reimplements thresholds instead of preserving the producer's decision. It uses fixed <20 for PRs/issues and ==0 for dirty files. Platform and detailed queue requirements use configurable <= limits. Exactly20 can pass the default maximum20 but display Needs work; with a stricter custom maximum, a below20 overview can say Current while the actual budget fails. Historical owner-wide count fields add another distinct input to detailed requirements and are not part of that overview threshold.

These are source-level rendering and status-composition findings, not false claims that a release was authorized. They identify where observation validity and policy are dropped, rather than recommending another generic readiness label. Sources: O-PLATFORM inspectGit/buildGithubReport/buildReport; O-DASH buildRequirements/buildReport/renderMarkdown.

## 6. Live retrieval is still a selected population

PR and issue commands explicitly pass --repo, which is a useful target binding. They do not pass a list limit or request a total count. O-PLATFORM counts the returned array. The official gh documentation currently specifies a default limit30. Under that behavior, a repository with50 open items and a custom maximum40 can be represented by30 returned items, assuming other checks pass. No actual repository count or installed-gh version was measured here.

The default maximum20 is an important countercase: a saturated30-row result still exceeds20. Truncation alone does not make a genuinely over-budget queue pass that default. It does still limit counts and which PR conflict states are inspected; it matters directly if the operator raises the allowed maximum. Names, counts, complete population and applicable threshold are distinct.

Discussion selection is explicit in source: the latest100 updated discussions, with the first20 comments per discussion. The helper retains totalCount and sampledCount, but the platform verdict uses the lengths of classified gap lists without a completeness requirement. An unresolved older discussion outside the sample can therefore be absent from the verdict. A maintainer comment after the selected20 can produce the opposite error, an apparent missing touch. The classifier also treats an OWNER/MEMBER/COLLABORATOR author or answer as touch; it is an association-based operational rule, not semantic assessment of response quality.

These are bounded sampling policies, not inherently useless measurements. T-PLATFORM tests genuine small positive/negative cases through a subprocess gh shim and confirms that discussion-disabled repositories skip the heavy query. It does not establish complete live retrieval or the relevant boundary cases. The dashboard flattens these measurements further, so its summary should not inherit stronger whole-population confidence than the helper provides. Sources: O-PLATFORM, O-DISCUSSIONS, T-PLATFORM; W-GH-PR/W-GH-ISSUE.

## 7. Readiness dimensions, historical state and continuation

The operator output has separate meanings:

- dashboardReady copies platformReport.ready, whose predicate excludes warnings from failure;
- ready is based on whether every objective requirement is current or complete;
- publicationReady is explicitly false.

This separation prevents a locally successful platform report from automatically becoming publication permission. Moreover, multiple objective rows in the pinned builder have only in_progress/not_complete branches. Completing an external action alone cannot make those rows terminal without updating the reporting implementation. As written, the ordinary builder cannot produce objective ready=true merely by making all real-world launch work complete.

T-DASH's renderer test supplies a handcrafted report with ready=true and publicationReady=true. It proves how rendering is intended to handle that input, not that buildReport can reach it. This is a concrete producer-versus-renderer test boundary. The generator is a maintained historical launch checklist, not a generic objective engine whose completion is entirely inferred from observations.

Fresh generatedAt and a reported Git head do not provide an atomic evidence snapshot. Document reads, Git status, GitHub queries and the later HEAD query occur sequentially; historical success text is not age-checked or bound to a fresh external read. The generated-at override is useful for deterministic tests but not a trusted observation clock. The head does not hash uncommitted input bytes. The optional --write happens after inspection and can itself alter a tracked file; no post-write Git check occurs. Snapshot generation and continued validity must remain separate.

The actual continuation is human-facing top_actions and next_work_order text. Some advice changes when a requirement becomes current, such as switching from rendering video to reviewing/uploading chosen candidates. No instruction was executed by this research. The dashboard does not itself synchronize Linear, approve billing, publish an announcement or start a worker. The source's explicit owner/publication boundaries remain intact. Sources: O-DASH, O-PLATFORM, T-DASH.

## 8. Verification standing, reuse and next work

Four implementation bodies, three test files, the root test runner and the observability document were read fully. The tests contain meaningful local positive/negative predicates, CLI/write/exit checks and a real subprocess shim; they were not run. No fresh local fixture was needed to distinguish literal readiness checks, runtime measurements, error-preserving versus error-dropping projections and the actual CI assertion path. A simulated hosted run would not establish real operational readiness.

Useful candidate mechanisms include a local no-telemetry prerequisite inventory, structured evidence/gaps, explicit GitHub targets, discussion-enabled preflight, error-aware aggregation, selectable failure exits, a real JSON-verdict assertion in CI, and a conservative publication boundary. Limits include marker presence versus functioning capability, historical phrase versus fresh observation, skipped/unavailable versus clean, sampled versus complete populations, renderer versus producer thresholds, handcrafted test states versus reachable builder states, and report time/head versus evidence correspondence.

These are reusable research distinctions and implementation references, not adopted SOUL/Development OS components or Foundation taxonomy. The study's source criterion for U14-A is met without claiming installed-host, full telemetry, live queue, authority or task-effectiveness validation. Q08a2 preserves those stronger questions and external consumer/concurrency/renderer correspondence.

Next selected U14-B / Q08b follows an actual signal rather than adding another layer of readiness prose: scripts/hooks/session-activity-tracker.js → metrics/tool-usage.jsonl → ECC2 session-manager ingestion → ecc2/src/observability/mod.rs and session/store.rs → query/operator use. Determine what event is captured, how session/time/duplicates/errors are handled, what risk scoring means and which control consumes it. Prior manager/store readings remain prior context; the joined telemetry chain is not newly credited as examined here. Other native variants/resources, synthesis/CORE, reverse inventory/holdout and whole-study evaluation remain unfinished.
