# ECC — Release qualification and supply-chain evidence uses

2026-09-23 · **C6 post-U12 transfer / U13-A–B extraction.** Bu dosya release qualification/artifact binding ve supply-chain scanner/advisory freshness kullanımlarını kendi ECC araştırma bağlamlarında taşır. RS kimlikleri genel release/security standardı veya SOUL/Development OS kararı değildir.

Source packages:
- U13-A Note28 + U13-A sources + MR29 + publication.
- U13-B Note29 + U13-B sources + MR30 + publication.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; no build/pack/install/scan/registry/workflow/release/malware execution.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-RS01–RS37 | [Note28](../../../research/studies/ecc/notes/28-RELEASE-QUALIFICATION-AND-ARTIFACT-BINDING.md) §§1–9 → [U13-A ledger](../../../research/studies/ecc/evidence/U13-A-SOURCES.md) → [MR29](../../../research/studies/ecc/ROUND-U13-A.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U13-A.md) | SOURCE / TEST-SOURCE-INSPECTED plus dated primary contracts and conditional release ordering; no release/build/pack execution. |
| ECC-RS38–RS80 | [Note29](../../../research/studies/ecc/notes/29-SUPPLY-CHAIN-SCAN-COVERAGE-AND-ADVISORY-FRESHNESS.md) §§1–9 → [U13-B ledger](../../../research/studies/ecc/evidence/U13-B-SOURCES.md) → [MR30](../../../research/studies/ecc/ROUND-U13-B.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U13-B.md) | SOURCE / TEST-SOURCE-INSPECTED, narrow primary contracts and conditional scanner/advisory cases; no scan/refresh/malware/workflow execution. |

Release-document claims, executable workflow predicates and hosted/live outcomes retain separate evidence roles throughout RS.

## 1. Release qualification surfaces and artifact binding

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-RS01 — document approval gate | Local release docs/rows/labels/markers → ready/digest/exit. | Executed evidence, authenticated approver or candidate-byte approval değil. |
| ECC-RS02 — approval state row | Markdown decision table first cells containing approve/approved etc. | Notes/evidence columns executed/verified proof değil. |
| ECC-RS03 — URL-surface label | Required surface label string present in ledger. | Parseable/reachable URL, publisher identity or artifact binding değil. |
| ECC-RS04 — blocker phrase check | Selected blocking text absence/presence predicate. | Whole approval semantics or all failure conditions değil. |
| ECC-RS05 — listed verification command | Required command text appears in documents. | Command ran/succeeded/on same candidate proof değil. |
| ECC-RS06 — gate ready | All document predicates pass. | Publication authorized, tested artifact or safe deployment değil. |
| ECC-RS07 — gate CLI exit2 | ready=false document result. | Execution error or live release failure değil; invalid flags use separate exit1. |
| ECC-RS08 — gate digest | First12 SHA-256 over check id/status/evidence tuples. | Source/docs/archive/release candidate hash değil. |
| ECC-RS09 — report-predicate identity | Same check tuple set can preserve digest across different candidate/doc bytes. | Cryptographic collision claim değil; digest scope difference. |
| ECC-RS10 — preview-pack readiness | Fixed historical rc.1 local file/marker/command preparation checks. | npm pack/test execution or final publish approval değil. |
| ECC-RS11 — historical release packet | Dated owner-approval instructions/claimed evidence/decisions for older release. | Current 2.2.1 readiness or live URL/CI fact değil. |
| ECC-RS12 — version-relative gate paths | Approval script derives release-doc paths from current package version while filenames retain fixed suffix conventions. | Required docs necessarily exist for every version değil. |
| ECC-RS13 — source-derived blocked gate | Pinned 2.2.1 release directory lacks exact packet/ledger/preview paths required by gate. | Executed CLI failure or absence of all approval processes değil. |
| ECC-RS14 — maintainer release procedure | Exact-commit evidence, permissions/signing/tag/promotion operator instructions. | Executable enforcement, authenticated actor or completed action değil. |
| ECC-RS15 — signed-tag instruction | Runbook requires signed tag/verification. | Release workflow itself verifies tag signature guarantee değil. |
| ECC-RS16 — exact-main verification | Release verify job compares checked-out commit with freshly fetched origin/main. | Candidate remains current until promotion or concurrent release serialization değil. |
| ECC-RS17 — version/tag relation | Workflow validates tag and package version relation. | Human approval or artifact semantics proof değil. |
| ECC-RS18 — one packed archive | Verify stage runs npm pack once and selects expected single archive. | Archive correct/useful by existence alone değil. |
| ECC-RS19 — archive SHA-256 | Exact packed file digest passed to lifecycle/publish stages. | Provenance/signature or behavior proof değil. |
| ECC-RS20 — same-archive lifecycle | Platform lifecycle jobs download and hash the verify-stage archive. | Every host/configuration/model path tested değil. |
| ECC-RS21 — same-archive publish | Publish stage reuses downloaded tested archive rather than repacking source. | Registry/GitHub release atomicity or accepted deployment outcome değil. |
| ECC-RS22 — registry version existence check | Registry lookup distinguishes E404 missing from other errors. | Registry availability/authenticity or no race guarantee değil. |
| ECC-RS23 — registry integrity comparison | Existing/published package SHA-512 compared with candidate. | Installed-client bytes or provenance subject equality değil. |
| ECC-RS24 — staged dist-tag | Stable release first published under `staged`. | Unpublished/confidential review stage or npm stage-publish mechanism değil. |
| ECC-RS25 — next dist-tag | Prerelease initially published under `next`. | Same rollout semantics as stable staged→latest değil. |
| ECC-RS26 — latest promotion | Stable version later moved to shared `latest` pointer after readback. | Monotonic/shared-pointer concurrency safety değil. |
| ECC-RS27 — GitHub Release creation | Later multi-service publication effect after npm operations. | Whole workflow success iff package published or vice versa değil. |
| ECC-RS28 — post-publish failure | Registry/GitHub failure can occur after package bytes already published/promoted. | Failure = no effect veya automatic rollback değil. |
| ECC-RS29 — manual dist-tag rollback | Owner can repoint latest to known version and verify. | Existing installs/exact-version selections reversed değil. |
| ECC-RS30 — per-candidate identity / shared-pointer race | Two individually valid jobs can overwrite latest out of chronological order without shared concurrency/expected-current check. | Observed concurrent release incident değil; external serialization can prevent. |
| ECC-RS31 — fresh old-job rejection | Old candidate re-verifying after main advance can fail exact-main check. | Earlier already-passed job automatically revoked değil. |
| ECC-RS32 — packed lifecycle test | Temp install/public CLI/repeat/drift/repair/uninstall over downloaded archive definition. | Test executed, live Claude/OpenCode callback behavior or all host variants certified değil. |
| ECC-RS33 — fake Claude lifecycle dependency | Packed test uses fake Claude process/state. | Real host/plugin behavior validated değil. |
| ECC-RS34 — source release helper | release.sh edits/builds/commits/tags/pushes and prints Released. | Hosted publish completion, tag signature, rollback transaction or remote release observation değil. |
| ECC-RS35 — provenance subject | Separate SLSA workflow independently packs/hashes its own archive for attestation. | Same bytes as tested/published archive automatically değil. |
| ECC-RS36 — npm provenance | Publish/source-build linkage mechanism. | Artifact nonmalicious/correct/useful guarantee değil. |
| ECC-RS37 — publication object separation | document report, maintainer approval, packed archive, registry version, dist-tag and GitHub Release are distinct objects/states. | Shared “release” label makes them interchangeable değil. |

## 2. Scanner selection, evidence and missingness

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-RS38 — IOC scanner | Selected local files/paths + static in-code indicators → findings/report/exit. | General code safety analysis or arbitrary-malware execution detection değil. |
| ECC-RS39 — IOC | Explicit package/version, text marker, filename/path or file hash indicator. | Proof malicious behavior executed değil. |
| ECC-RS40 — static rule set | Pinned maps/sets embedded in scanner. | Automatically current threat intelligence or advisory-fed rule set değil. |
| ECC-RS41 — default scan root | Root relative to scanner source unless explicit override. | Caller cwd/user project automatically scanned değil. |
| ECC-RS42 — selected-file population | Explicit dependency/config/payload names and path rules. | Whole repository/source/generated-content coverage değil. |
| ECC-RS43 — ignored-directory set | docs/tests/dist/target/coverage etc omitted by ordinary walk. | Those areas harmless or irrelevant universally değil. |
| ECC-RS44 — installed package walk | Immediate nonhidden package dirs/scope dirs and fixed filenames. | Recursive package payload/nested node_modules coverage değil. |
| ECC-RS45 — pnpm layout gap | Hidden `.pnpm` store and top-level symlink entries can be skipped by installed walker. | Lockfile/version route also blind or all pnpm installs missed değil. |
| ECC-RS46 — opt-in home scan | Home/persistence locations included only via home options. | CI/release repo scan represents developer machine scan değil. |
| ECC-RS47 — fixed temp targets | runtime targets can include fixed system temp locations even with custom home. | Completely isolated fixture root semantics değil. |
| ECC-RS48 — nonexistent-root clean exit | Missing specified root can yield zero selected files/findings and normal exit0. | Root successfully scanned or absence of indicators proof değil. |
| ECC-RS49 — swallowed content read error | text/hash readers can map selected-file read failures to empty strings. | All I/O errors hidden; traversal/stat errors can differ. |
| ECC-RS50 — filename detection despite unreadable contents | Known payload name can still create finding. | Content was successfully read or verified malicious proof değil. |
| ECC-RS51 — scannedFiles count | Selected pre-dedup path count. | Successfully read unique files count değil. |
| ECC-RS52 — malformed JSON fallback | Dependency parse failure can fall back to lexical text checks. | Manifest valid or fully inspected proof değil. |
| ECC-RS53 — finite package/version matcher | Explicit known version/name rules. | Range resolution/current incident coverage/unknown variants detection değil. |
| ECC-RS54 — text indicator match | Bounded regex/marker occurrence detection. | Executed malicious behavior or unique causal source proof değil. |
| ECC-RS55 — hash indicator match | Selected file hash equals fixed known digest. | Threat list complete/current or file executed proof değil. |
| ECC-RS56 — defensive deny exemption | Claude permission deny values suppress matching textual occurrences. | AST/location-bound exception or generalized safe context proof değil. |
| ECC-RS57 — occurrence-wide deny range | Same deny value searched across raw file; identical occurrence outside deny field can also be exempted. | Observed policy bypass or executable malicious content proof değil. |
| ECC-RS58 — zero findings | No selected matcher produced finding. | Clean/safe package, complete readable coverage or current threat absence değil. |
| ECC-RS59 — scanner exit1 | Findings cause ordinary nonzero consumer failure. | Every security issue detected or report complete değil. |
| ECC-RS60 — scanner exit2 | Uncaught/argument/traversal error path. | All missing/read failures use diagnostic exit değil. |

## 3. Advisory metadata, refresh and actual consumers

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-RS61 — advisory-source reporter | Curated metadata + optional URL availability checks → detailed report/readiness/projection. | Advisory content ingestion or scanner-rule update engine değil. |
| ECC-RS62 — source metadata readiness | Record count/required fields/unique IDs/ecosystem/signal labels validation. | Article validity/currentness/content support proof değil. |
| ECC-RS63 — refresh.ok | Requested URL checks' aggregate availability standing. | Advisory content fresh/relevant/unchanged proof değil. |
| ECC-RS64 — report ready | Rejects fail checks; warning-only refresh can coexist with ready=true. | Successful requested refresh or current advisory data guarantee değil. |
| ECC-RS65 — offline refresh contract | Refresh not requested recorded as passing metadata contract. | Sources actually reachable/current proof değil. |
| ECC-RS66 — strict-refresh exit | Requested refresh not ok can yield CLI exit1 while JSON ready remains true. | Ready field changes or watch uses strict mode değil. |
| ECC-RS67 — Linear status projection | Coarse text derived from report ready. | Linear issue updated or refresh/content current proof değil. |
| ECC-RS68 — all-refresh-fail / ready | Valid metadata + ordinary failed result objects can preserve ready=true with warnings. | Failures hidden everywhere değil; detailed warnings exist. |
| ECC-RS69 — HEAD/GET availability probe | URL status/redirect checks with GET fallback for selected statuses. | Body content parsed/hashed/current advisory verified değil. |
| ECC-RS70 — exhausted-redirect 3xx success | Final 3xx can satisfy generic 200–399 success when redirect allowance ends. | Terminal advisory content reached proof değil. |
| ECC-RS71 — fallback checkedAt loss | GET fallback path can return result without per-source checkedAt. | Top-level generatedAt absent or request failed proof değil. |
| ECC-RS72 — generatedAt | Reporter generation time. | Advisory publication/update time or threat-data age değil. |
| ECC-RS73 — no automatic rule-refresh loop | Scanner rules and advisory reporter outputs are separate; watch runs both without rule mutation. | Human/external update process absent universally değil. |
| ECC-RS74 — npm signature audit | Separate registry/package signature/provenance command in CI/watch. | IOC scanner equivalent or local file-content proof değil. |
| ECC-RS75 — npm vulnerability audit | Registry advisory lookup with selected omission/threshold. | Static IOC scan or complete dependency-security coverage değil. |
| ECC-RS76 — watch sequential evidence generation | Audit/tests/scanner/advisory steps run in order under normal success conditions. | Later reports generated after earlier failure guarantee değil. |
| ECC-RS77 — always-upload | Upload attempts whatever report artifacts exist. | Skipped producer retroactively executed or complete diagnostic bundle guarantee değil. |
| ECC-RS78 — release scanner prerequisite | Release verify invokes scanner before build/pack. | Watch advisory report consumed by release or all audits repeated there değil. |
| ECC-RS79 — scheduled watch | Six-hour cron declaration. | Actual cadence/history/continuous coverage proof değil. |
| ECC-RS80 — scanner/advisory/npm non-collapse | Local finite matcher, source-link freshness and registry audits are three separate evidence producers. | Combined one universal security verdict değil. |

## 4. U13 non-collapse

- approval words ≠ authenticated approval;
- listed command ≠ executed evidence;
- report digest ≠ candidate digest;
- historical preview ≠ current release readiness;
- tested archive identity ≠ signed provenance;
- same candidate bytes ≠ serialized shared tag;
- publish success ≠ whole multi-service workflow success;
- dist-tag rollback ≠ installed-effect reversal;
- provenance subject ≠ published artifact automatically;
- selected file ≠ readable file;
- scannedFiles ≠ successfully inspected unique files;
- zero findings ≠ safe/complete scan;
- URL reachable ≠ advisory content fresh;
- report ready ≠ refresh ok;
- generatedAt ≠ incident age;
- advisory metadata ≠ scanner rules;
- IOC scan ≠ registry signature audit ≠ vulnerability audit.

U13-A/B are bounded source answers. Stronger release authority/ruleset/signature/CI/build/provenance/concurrency and scanner coverage/freshness/false-result/effectiveness questions remain source-study residuals, not automatic Concepts experiments.
