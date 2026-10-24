# Note29 — Supply-chain scan coverage and advisory freshness

**2026-09-21 · U13-B / Q07d3 · bounded source answer.** ECC target remains 8321021c54d670126ce3b2969d5deb880b4b0c2a. [Exact sources and reading scope](../evidence/U13-B-SOURCES.md), [MR30](../ROUND-U13-B.md), [STATE](../STATE.md). No target scan, refresh, upstream test, installation, registry call, live workflow or E10 was executed. Countercases below are source-derived. Rule labels are the pinned program's data, not a newly verified/current incident catalogue.

## 1. Native explanation: three different evidence producers

The scanner reached from Note28's release prerequisite is a deterministic local IOC matcher. IOC means an indicator of compromise: here a selected package/version pair, a text marker, a filename/path or a file hash. The tool does not infer that arbitrary code is safe or run the inspected payload.

A separate advisory-source reporter inventories curated sources and optionally checks whether their URLs respond. CI and the scheduled watch also invoke npm's signature and vulnerability-advisory audits. These are not interchangeable implementations of one security verdict.

| Producer | Actual input and output | Followed consumer |
|---|---|---|
| IOC scanner | Selected local paths plus static in-code indicators → findings and selected-file count → CLI status | CI security job, watch job and release verification |
| Advisory-source reporter | Static source metadata plus optional URL-status checks → readiness, per-source refresh details and suggested Linear status | Watch writes JSON and uploads it; no Linear update is performed by this script |
| npm audits | Installed dependency/signature information and registry advisory services → command result | Separate CI/watch commands before IOC reporting |

The useful composition is real: a scanner match can stop the followed job; signature and advisory checks examine different properties. However, co-location does not create an automatic advisory-to-rule learning loop. S-SCAN imports only standard local libraries and uses its in-code maps/sets. It does not read the advisory JSON. S-ADVISORY does not write scanner rules. W-WATCH invokes the commands but contains no rule extraction, review or adoption step. Sources: S-SCAN, S-ADVISORY, W-WATCH, W-CI, R-PACKAGE/R-RELEASE/R-REUSABLE; D-NPM for the separate audit contract.

## 2. What is selected for scanning?

The scanner's default root is resolved relative to its own source directory, not the caller's current project directory. In the followed repository CI jobs that points at the checkout. Running a packaged copy from another working directory would not automatically change that root; --root is the explicit override. This is target selection, not proof that an installed invocation scanned the user's intended project.

The general walk chooses explicit dependency filenames, certain persistence/config filenames in special directories, selected payload names under node_modules, and a few inspect-only filenames. It ignores directories including docs, tests, dist, target and coverage. The implementation therefore avoids indiscriminately flagging every educational or fixture mention, but it also does not inspect arbitrary source or generated content merely because that content might execute.

Installed packages use another traversal: immediate nonhidden directories under node_modules, plus immediate directories under scopes. inspectPackageDir checks a fixed list at each package root. It does not recursively inspect that package's subdirectories or nested node_modules. Symbolic-link directory entries are not followed by this route; hidden entries are skipped.

The documented pnpm layout makes that boundary consequential. A .pnpm store and top-level package symlinks can be valid, usable installation structures while this installed-payload walker selects neither the hidden store nor those symlink entries. The claim is about the described layout and entry types, not all pnpm settings or an executed ECC/pnpm compatibility test. A root lockfile can still expose a listed package/version independently. Payload discovery and declared-version discovery must not be conflated. D-PNPM/D-NODE supply the narrow external interface/layout comparison.

Home-level Claude/VS Code/OS persistence locations are added only with home enabled. --home-dir also enables home scanning and changes the selected home, but runtimeTargets still includes fixed /tmp and /private/tmp locations. It is not by itself a completely isolated fixture root. The actual watch, CI-security and release scanner commands do not pass --home. A repository-scoped scan is not a scan of developer machines.

Source: S-SCAN walkFiles, walkNodeModules, inspectPackageDir, shouldInspectFile, homeTargets, runtimeTargets, scanSupplyChainIocs and parseArgs. No filesystem-layout experiment was run.

## 3. Empty evidence and unreadable evidence can reach the same exit

There are real diagnostic exits, but not every missing-evidence branch uses them.

| Condition | Source behavior |
|---|---|
| Selected readable manifest contains a listed package/version or text IOC | Finding; ordinary CLI exit1 |
| Unexpected traversal or uncaught argument error | Top-level catch; stderr and exit2 |
| Specified root does not exist | walkFiles returns an empty list; zero findings; ordinary exit0 |
| Ordinary selected file fails text and hash reads | Each reader returns an empty string; no separate read-error finding/count |
| Selected known payload filename remains present but unreadable | Filename matching can still produce a finding independently of contents |

Thus a nonexistent requested root can produce a passing text report with zero inspected files. A selected ordinary package.json that cannot be read can be included in the count without contributing inspectable bytes. The number named scannedFiles is files.length before deduplication; actual scan iteration uses a Set. With overlapping root/home discovery it can also count the same selected path more than once.

These are not claims that every I/O error is swallowed: stat/readdir failures have different handling and may stop the program. Nor does every read error necessarily remove all detection, because filename/path checks can still fire. The missing distinction is a comprehensive successful-read/failed-read/skipped population supporting the clean verdict. There is no minimum expected input set or nonzero-coverage admission requirement in the CLI's zero-finding predicate.

Malformed JSON similarly falls back to lexical text matching in dependency files, rather than being reported as a separate invalid-structure outcome. That fallback can find a marker, but no marker does not certify a valid manifest. Source: S-SCAN readers, dependencyFileReferencesPackageVersion, scanFile, result construction and CLI.

## 4. Matching is useful, but its meaning remains finite

The implementation has several distinct detectors. JSON dependency data is recursively searched using explicit package names/keys and versions; non-JSON text uses bounded regex patterns. Selected files are also hashed against fixed known hashes, scanned for case-insensitive marker strings, and checked for certain names/paths. Findings retain a severity, path, line, indicator and message.

The JSON path avoids some package-name substring collisions. Text matching has a left-boundary check so a legitimate name ending in execution.js is not automatically treated as the bare indicator. T-SCAN includes clean manifests, nearby nonlisted versions, unrelated package/version combinations, benign hook-name suffixes and positive matches. These are useful error-sensitive test definitions, not empty test theatre.

However, lexical version-token detection is not full dependency-range resolution or installed-package identity. Static lists are not automatically updated by consulting the listed advisory sources. A generic filename or a text occurrence is evidence of that marker, not proof that malicious behavior executed. Conversely an unlisted version, renamed payload, unselected file or unfamiliar behavior is outside the corresponding detector. No false-positive/false-negative rate or current threat coverage was measured.

### Defensive exception is implemented by value search, not location binding

For Claude settings, the scanner parses permissions.deny and extracts its string values. To avoid flagging defensive deny rules, claudePermissionDenyRanges then searches the complete raw file for every occurrence of each value and its JSON encoding. Those ranges suppress text-indicator findings.

The operation does not recover only the AST locations belonging to permissions.deny. If the exact same deny-entry text also occurs in another field, its occurrence can be exempted too. The invariant actually enforced is 'text lies inside an occurrence of a deny value', not 'text lies inside the deny field'. Filename/hash/version detectors remain separate.

The existing mixed deny/hook test is a meaningful positive guard: a deny string in permission syntax and a different full hook command containing the same IOC still produce a finding. Because the full strings differ, that test does not discriminate the identical-value case. This is a source-level exemption-scope distinction, not a demonstrated live Claude-policy bypass or claim that arbitrary attack commands necessarily fit valid permission syntax. No active hook was executed or attacker payload constructed. Sources: S-SCAN claudePermissionDenyRanges/indexInRanges/text loop; T-SCAN deny-only and mixed-value cases.

## 5. A source report can be ready while every refresh fails

validateSources checks metadata: at least eight records, required fields and unique IDs, and configured ecosystem/signal labels. It does not read the articles to establish that they support those labels or that the scanner contains adequate current rules.

Refresh status is a separate dimension. Returned fetch failures become per-source warnings and refresh.ok=false. The readiness predicate rejects only checks with status fail; the refresh check is warn, not fail. With valid default metadata, even an ordinary failed-result object for every URL can therefore coexist with ready=true. The detailed failures are preserved, not hidden everywhere.

Offline mode deliberately returns a passing refresh-contract check saying refresh was not requested. That is a defensible offline metadata contract. The potentially misleading projection is buildLinearStatus: it chooses its 'Advisory sources current' summary from report.ready, not refresh.ok or whether refresh occurred. Both an offline report and an all-warning refresh can produce that summary. The script only emits a proposed Linear status and explicitly retains a remaining synchronization task; it does not update the external issue.

The CLI offers a real stronger exit policy: --strict-refresh exits1 when a requested refresh is not ok. This does not rewrite ready in the JSON; strictness belongs to the caller's exit decision. The actual watch uses --refresh, not --strict-refresh. A consumer reading only ready and one respecting the strict process exit can reach different operational decisions from the same detailed report.

A custom fetchSource callback that rejects outright is different from one returning a failed-result object: the build loop does not catch every custom callback exception locally, and the CLI can end in its error exit. Do not generalize the warning path to all conceivable transport failures. Sources: S-ADVISORY validateSources, refreshStatusFromResult, buildAdvisorySourceReport, buildLinearStatus and CLI; T-ADVISORY; W-WATCH.

## 6. Successful URL refresh is not fresh incident content

The default fetcher makes HEAD requests, follows a bounded number of redirects, and falls back to GET for 403/405 responses. It has timeout and request-error handling. These are real availability checks.

requestUrl drains the response and retains status/final URL; it does not parse or hash the response body. A reachable address can still serve changed, irrelevant, withdrawn or outdated information. The reporter neither checks an advisory's publication/update date nor compares its content with the current rules. generatedAt is the report timestamp, can be overridden, and is not an incident-data timestamp.

Two narrower source countercases refine even the availability record:

- After the redirect allowance is exhausted, a remaining 3xx response can still be classified ok by the final 200–399 condition, without reaching a terminal 2xx page.
- The HEAD-to-GET fallback returns requestUrl directly. That helper does not include checkedAt in its result, so the per-source refresh record can have checkedAt=null even on a successful GET; the top-level generatedAt still exists.

The upstream loopback-server test defines genuine redirects and unsupported-HEAD behavior, not only injected fetch mocks. It asserts overall/status success but not the fallback timestamp or exhausted-redirect outcome. All these tests were inspected, not run. Source: S-ADVISORY defaultFetchSource/requestUrl/refreshStatusFromResult; T-ADVISORY final test.

## 7. Actual consumers preserve some failures and can prevent later evidence generation

W-WATCH orders ignore-scripts dependency installation, npm signature/advisory checks, scanner fixtures, advisory fixtures, IOC report generation, advisory refresh report generation, workflow-hardening validation and artifact upload. Its concurrency declaration and job timeout are actual workflow controls. No live job was dispatched.

A nonzero scanner result is not merely an advisory log: the followed ordinary step fails. CI's security job and the release verify jobs likewise invoke the actual scanner as a command without a permissive continuation flag. In release, verify/lifecycle dependencies can prevent publish. Note28's artifact controls remain genuine; reading the scanner does not cancel them.

Watch report generation is nonetheless sequential under the default success condition. An early npm audit or fixture failure can prevent both JSON reports from being generated. A scanner finding can leave its JSON report written while the later advisory report is skipped. always on the upload step only attempts to collect available files; it does not retrospectively execute skipped producers. Failure of the overall job and completeness of its diagnostic evidence are different properties. D-GH supplies the status-condition contract.

The independent npm audits must remain in the explanation. Signature/provenance checks and registry advisory lookup are not the local fixed-IOC matcher. In CI/watch the explicit vulnerability command omits development dependencies and fails at the high threshold; development-only packages still face other checks in those jobs. That is a chosen coverage boundary, not proof of no controls. The release YAML's direct scanner prerequisite should not be silently rewritten as if it independently reran all these audit commands or imported the watch report.

The watch's six-hour cron declaration describes intended schedule, not verified run cadence, complete refresh history or immunity to missed jobs. No schedules, reports or artifacts from actual runs were fetched here. Sources: W-WATCH/W-CI, prior R-RELEASE/R-REUSABLE, D-NPM/D-GH.

## 8. What this changes in the ECC model

The source now supports a more precise composition:

`curated local indicators → selected-file matcher → findings/exit → required job`

alongside

`curated source metadata → optional URL availability checks → detailed refresh status → coarse readiness/Linear projection → uploaded report`

and separately

`dependency state + registry services → signature/advisory audit → job status`.

The first two do not form a closed, validated rule-refresh loop. Coverage loss can occur before matching through target/traversal/read selection. Qualification loss can occur after matching through a coarse status or skipped diagnostic producer. A repeated watch can rerun unchanged rules while refreshing only link availability. These are concrete source mechanisms, not a generic instruction to 'be careful'.

Useful reusable elements include structured finding provenance, multiple indicator classes, benign-pattern countertests, explicit optional home scope, detailed refresh warnings, opt-in strict policy, independent audits and failure-sensitive job sequencing. Reuse limits include target-presence/read completeness, layout-specific selection, structural exemption binding, content-to-rule freshness, status projection and complete error evidence. No SOUL/Development OS design is adopted by identifying them.

## 9. Evidence standing and next responsibility

The two implementations, two test files, watch workflow and CI workflow were read fully; prior package/release bodies were reused at their established unchanged pin. Primary Node/pnpm/npm/GitHub documents were used only for narrow interface semantics. The currently documented versions are not an installed-environment fingerprint. No new target execution, E10, malware download, credential access, live API/provider, package install or workflow action occurred.

An optional raw-source download failed DNS and produced no source file. This is an acquisition limitation, not a scanner failure. No manually modified reconstruction was run as original upstream. Source predicates already distinguish the bounded question; a hosted-security or real-malware experiment was neither required nor authorized. A future original-module fixture would need recovered, hash-matched bytes and its own prior criteria.

U13-B meets Q07d3's original source-to-consumer criterion. Q07d4 retains installed/platform/package-manager conformance, actual read-error/race behavior, precise rule/artifact/authority association, threat-intelligence freshness and content validity, false-result rates, real strict/diagnostic behavior, other scanners and measured safety/effectiveness. Whole ECC remains active/partial.

After verified publication, next selected **U14-A / Q08a** follows observability/readiness production and consumption through scripts/observability-readiness.js and scripts/operator-readiness-dashboard.js. These were known entry names, not source bodies read in this unit. The question is which claimed operational conditions are configured, actually measured or merely projected into readiness, and what subsequent control consumes the result. Native syntheses/CORE and final family/omission/project evaluation remain unfinished.
