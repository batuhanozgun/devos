# U06-B2 — Assessor Contracts and Evaluation-Evidence Qualification

Date: 2026-09-17. **BOUNDED SOURCE / PUBLISHED-RECORD INVESTIGATION COMPLETE.** This closes the selected U06 authoring/evaluation inquiry, not evaluator certification, an independently reproduced campaign or the whole study. U07 runtime/distribution is next. Remaining empirical and release boundaries are explicitly disposed below rather than silently closed.

Primary: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`. Lab: `prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b`. Neither was repinned. Gauntlet was separately bound to a revision named in an inspected historical campaign, not today's HEAD. Resolve D28–D37/G01–G09/S70 through [SOURCE-LEDGER-U06B2.md](../SOURCE-LEDGER-U06B2.md). METHOD remains v0.1.

## 1. Question and evidence boundary

What qualifies an assessor report as usable, and how far does that qualification support a claim that Superpowers improves work?

B1 traced Quorum's consumer side. B2 follows the producer's rubric, tools, report parser and publication; the consumer's completion/accounting checks; representative source materialization; and public experiment records containing both positive and negative results. This is enough to distinguish protocol validity, semantic judgment and treatment effectiveness without auditing every dependency or operating a live lab.

No model, provider, upstream script, test suite, oracle or new synthetic experiment was run. E01–E12 remain unchanged. Gauntlet tests were inspected as source. The public experiment notes report real runs by their authors, but their private raw evidence was not retrieved or authenticated by this study. Such reports are evidence about reported findings, not our independent replication.

## 2. F58 — Historical evaluator identity is recoverable, but is not a universal version binding

D30 reports a code-review smoke campaign against primary Superpowers b36e0829 and explicit none controls. Its repaired rerun names Gauntlet db6c8e0f. The commit was resolved to `db6c8e0fcf80889aa6d9631c99adec698f6c0caa`, dated 2026-09-10, and its implementation was read at that exact revision. The first short-SHA Git-data lookup failed; the commit endpoint resolved the full identity. This was not evidence that the repository was unavailable.

D31 subsequently names `25a2e3e00431f8d8eb63781162ccb974d43d5405`. Exact comparison shows one intervening commit: strict report-tool schema metadata, provider-route transmission and wire tests. The assessment loop, scoped reader, completion publisher and story parser were unchanged in that comparison. The complete changed patch was read; full provider implementations were not. The older parser's validation/repair remains distinct from the newer request-schema constraint.

D37's later release-path record names yet another Gauntlet revision, aa08b729, and different Evals revisions. Its statements remain author-reported; that revision was not silently substituted for the source we inspected. The current lab pin is a repository snapshot containing these historical records, not the exact runner revision of every recorded campaign.

**Conclusion:** A concrete subject/evaluator correspondence can be recovered for a reported run. It does not establish every actual binary, loaded byte or runtime input without the retained provenance evidence.

## 3. F59 — Rubric coverage and read-before-cite have concrete producer controls

**SOURCE OBSERVATION — G03/G04/G05/G07/G08.** The story parser collects Markdown criteria, preserving soft-wrapped continuation text and ending the section at a new heading. In the selected six-bullet review rubric this supplies six obligations. Arbitrary prose outside bullets is not automatically another criterion; this is a defined parsing convention, not a universal natural-language requirements extractor.

The report parser requires exactly one submitted row per parsed criterion. The model cannot supply the criterion text or an overall status: canonical criterion text is attached by position, and the overall result is derived from row verdicts. Each row requires a verdict, direct observation, basis, limitations and at least one source reference.

References must name files whose successful read results reached an earlier model request. The loop maintains pending and exposed sets separately: reading and reporting in one response does not make the new read available to that same report. Failed reads do not enter the set. The indexed reader checks relative normalized paths, containment, regular files and duplicate/index validity; unlisted files are rejected.

The assessment function starts its own empty message history and offers only indexed reading and report submission. Unknown tool names are rejected in dispatch. This is stronger than a prose-only request to be read-only. It is still a scoped tool interface, not proof of whole-process sandboxing or semantic immunity to instructions embedded in evidence.

| Control | What it establishes at the inspected layer | What it does not establish |
|---|---|---|
| Exact row count and canonical text | A position exists for every parsed obligation | Every explanation actually answers its assigned obligation |
| Observation/basis/limitations fields | Those fields are nonempty and separately represented | Observations are true or limitations are relevant |
| Read-before-cite | A referenced file was successfully exposed earlier | The cited content supports the claim, or all necessary sources were read |
| Indexed read-only tools | The model-facing dispatcher limits operations | Full host isolation or an epistemically independent model |
| Derived aggregate status | The overall label follows the submitted row labels | The row labels are correct |

The test source explicitly allows repeated valid rows. That is not automatically an error: multiple obligations can share evidence. It does make the boundary plain—syntactic coverage is not semantic coverage. G08 checks missing fields/rows, unread references, forbidden supplied status/text, repaired/native paths and derived status. It was not executed here and does not claim to measure live judgment accuracy.

## 4. F60 — Format repair preserves a distinction between authored judgment and accepted representation

**SOURCE OBSERVATION — G02/G03/G04.** When native `criteria` is absent, the parser can recover a JSON array embedded in recognized reasoning markup. Native criteria, when present, take priority; malformed or unsupported markup is not freely interpreted. Recovered rows face the same count/reference/field checks. A repaired report that leaves no synthesis text is rejected. The accepted path logs a repair event and gives completion a distinct repair reason.

This is representation recovery, not a model being asked to change a fail into pass. The parser still derives status from the recovered row verdicts. Recognizing the first block leaves any later block in the reasoning; neither ambiguous multiple-block intent nor semantic correctness is generally solved by this parser. Its design records this boundary.

**PUBLISHED REPORT — D30, not reproduced here.** The initial twelve-assessment smoke reported four timeouts/indeterminate outcomes associated with invalid report shape. A retained-submission repair check reportedly recovered 22 of 23 previously rejected submissions; one summary-only submission remained rejected. The subsequent fresh twelve-attempt rerun reportedly accepted all first submissions, six through repair, with all twelve composing pass. The authors state that malformed-placement behavior still occurred in those six cases.

Three evidence classes must remain separate: tuning a parser against retained failures; a new run after the change; and any claim about useful coding-agent performance. The first is post-hoc development evidence; the second is reported confirmation for a bounded workload; neither isolates a Superpowers-versus-stock benefit. The same note says that its small all-pass accepted sample does not test fail-side discrimination and cannot separate treatment from control.

## 5. F61 — Valid report delivery and complete accounting are different qualifications

**SOURCE OBSERVATION — G04/G06 and D28/D29.** A report decision does not immediately create a completed assessment. Publication writes result files, performs the event/usage finalization callback and publishes a no-replace completion marker. The marker identifies the run and accepted result digest. Publication failure produces an error path rather than a successful receipt merely because a report was generated.

Quorum checks completion/run/directory identity, status/digest consistency, the actual result digest and aggregate criterion-status consistency. These checks complement the producer; they do not independently reinterpret the rubric. The digest binds the result file, not automatically the whole original subject workspace or every possible causal fact.

The accounting reconciler links logical requests/responses to physical admissions, settlements and usage records. It retains valid known usage when other rows are incomplete. Crucially, `reportEligible` and `complete` differ: an honestly unpriced retry may leave a usable completed judgment with partial cost coverage, while broken identities or unfinished logical history can make the report ineligible. Known spend is not total spend. Unknown is not zero.

D31 reports a downstream reader defect that had treated a priced subtotal as complete despite the runner's incomplete-accounting marker. Its correction reportedly preserved the known subtotal while changing completeness to false, and left the historical publication unchanged. That is a reported producer-consumer qualification-loss case, not a fresh observation by us. It illustrates why a correct producer field must survive the consumer's reconstruction.

## 6. F62 — Published negative evidence separates semantic failure from format and capture failure

**PUBLISHED REPORT — D31.** A later investigation reports two full-review grounding errors: an unsupported claim that a query payload alone bypasses the remaining password check, and an unsupported assertion about stored plaintext based on a read/comparison path. The supplied source can support serious defects without proving those stronger claims.

The record says the disputed text reached the assessor in successful prior reads and the model itself submitted native pass verdicts. It therefore does not attribute these cases to absent capture or a parser changing the label. Six fresh assessor-only cases reportedly compared two original full bundles, each isolated unsupported claim, and a supported rewrite of each claim. Both full-review errors recurred; the four isolated cases received the expected labels. No coding-agent run was launched in that diagnostic.

This is important contrary evidence to the inference that valid citations, complete rows and a valid output schema imply sound judgment. It is not a general error-rate estimate. The cases changed several variables together: evidence size, neighboring claims and a six-criterion versus one-criterion rubric. The authors explicitly do not identify context length as the cause. Isolated success also does not establish complete causal understanding of every claim.

The appropriate research result is therefore conditional: this source corpus contains substantial controls and reported semantic counterexamples to stronger reliability claims. We have not independently adjudicated the private full reviews and cannot label every reported disagreement a proven product failure.

## 7. F63 — Materialized source identity advances configuration evidence but does not finish treatment attribution

**SOURCE OBSERVATION — D33–D35, with B1 D15–D18.** The general comparison helper creates baseline/candidate arms holding pairing parameters constant; that helper is not automatically the path used by the stock smoke. Campaign snapshots separately carry Evals/Gauntlet references and materialize one Superpowers worktree per distinct non-null arm SHA. Reconstruction compares observed identities and the exact arm-SHA set with registered references instead of deriving expectation solely from current HEAD.

The materializer requires a full hash before destination construction. Reuse requires an actual directory, matching HEAD and empty ordinary Git porcelain. New work uses a detached worktree at the requested SHA. Failed creation includes inspected cleanup outcomes rather than assuming cleanup succeeded. No materializer was run here.

These are actual source controls, not simply a YAML declaration. They still have bounded meaning: ordinary Git status is not a complete inventory of ignored inputs; source preparation is not proof of actual model-visible content or intentional skill use. The registration file was inspected only for its imports/initial contracts; the complete campaign, all adapters and all capture normalizers were not audited. Existing B1 explicit-none/root/ambient distinctions remain preserved.

For this study's explanation we can now locate both configured and materialized identities. Independently authenticating each historical run and proving treatment isolation remains a prerequisite for a stronger comparative-effect claim, which we do not make.

## 8. F64 — Static CI, an operationally successful campaign and release acceptance are different

**SOURCE OBSERVATION — D36/S70.** The inspected Evals workflow performs dependency installation, static/type/unit checks and scenario validation; it does not invoke a live campaign. The primary Superpowers pin's complete `.github` tree has no workflows entry. That is a precise tracked-snapshot observation, not proof that maintainers have no external CI, branch rules or manual gates. Those administrative and historical enforcement paths were not inspected.

**LATER PUBLISHED CHECK — D37, selected opening section.** The latest described focused run in the pinned record executed on 2026-09-12 despite the document's 2026-09-10 filename and 2026-09-11 section label. It reports all 156 executable checks passing but six original composed failures among 28 attempts, with grading marked uncalibrated and broader release acceptance still held/deferred. It also reports paired grading disagreements and simulator deviations; it explicitly distinguishes agent audits from human gold/calibration.

This later record matters because it prevents the earlier format repair or an all-green executable-check total from being misrepresented as subsequent general evaluator qualification. We did not recover its private authenticated files, inspect its newer Gauntlet implementation, reproduce its numerical outcomes or review the whole long historical document. It is a source-bounded recency check within the fixed lab corpus, not a latest-HEAD claim.

Actual packaging/update and release materialization remain U07. No automatic or human release acceptance is inferred from a contributor checklist, an Evals merge or these records.

## 9. U06 closure at the research scope

The bounded authoring/evaluation model is now explainable from producer to consumer:

`observed failure → chosen intervention → authored revision → controlled scenario/arms → prepared source/environment → interaction and retained evidence → bounded assessor reads → criterion report → representation validation/repair → publication and accounting → composed result → separately qualified inference/release decision`.

This is a family of distinct transitions, not a universal automatic pipeline. The first subsystem synthesis is [S01 — Skill evolution and evaluation](../syntheses/S01-skill-evolution-and-evaluation.md). It combines U06-A/B1/B2 without upgrading their evidence classes.

| Previously open B2 item | Disposition |
|---|---|
| Relevant Gauntlet identity and producer contract | Bounded source answer at campaign-named db6c8e0f, with exact 25a2e3e delta; not all Gauntlet versions. |
| Rubric/citation/completion/accounting controls | Explained at inspected source surfaces; semantic correctness remains unqualified. |
| Declared versus materialized subject | Representative materializer/snapshot located; actual loaded treatment and full capture remain unverified empirical applicability conditions. |
| One published run and disagreements | Two full public records plus a later selected read; private evidence not independently authenticated. |
| CI/release linkage | Static workflow and primary tracked absence located; real administrative admission unverified, packaging/update continues in U07. |
| Deeper evaluator/provider/campaign audit | Not required to support the bounded explanation or an explicit non-efficacy conclusion; reopen only for a stronger claim. |

No requirement was weakened to manufacture a pass. The investigation closes with a supported model and explicit unresolved boundaries, not by certifying the target. The user's approximate progress question did not create pressure to raise a percentage or shorten a necessary evidence chain.

## 10. Residuals and continuation

Q30–Q37 now have source/record dispositions rather than an indefinitely expanding audit queue. Preserve Q35 semantic relevance/completeness, Q33/Q37 actual-run attribution, Q36 assessment-attempt versus eligibility, and Q34 real release admission as qualified reuse boundaries. New Q38 concerns representation repair versus measured behavioral improvement; Q39 concerns full-output semantic coverage versus isolated-case success; Q40 concerns qualification surviving accounting/report consumers. These are research questions, not authorized product changes.

**Next: U07, primary runtime and distribution.** Inspect the pinned brainstorming visual-companion chain, remaining adapters/install/update/packaging and authoring support files. Follow input, consent, actual effect, retention and exit. Then build the remaining native syntheses and U08 whole-system/project-facing explanation. Do not automatically run a new Gauntlet campaign, seek credentials or reopen every evaluator dependency. Foundation, other studies, agent-control and external repositories remain unchanged by this research unit.
