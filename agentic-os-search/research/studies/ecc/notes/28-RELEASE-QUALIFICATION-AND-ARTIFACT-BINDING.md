# Note28 — Release qualification and artifact binding

**2026-09-21 · U13-A / Q07d1 · bounded source answer.** Fixed ECC target 8321021c54d670126ce3b2969d5deb880b4b0c2a. [Exact sources](../evidence/U13-A-SOURCES.md), [method review](../ROUND-U13-A.md), [STATE](../STATE.md). No target script/test/build/pack/install, live workflow, registry operation, tag/release or E10 was executed. Conditional examples are source-derived, not observed incidents. Prior experiments retain their separate scopes.

## 1. Native system: three different kinds of release qualification

The release family is not one gate with interchangeable labels. Its source connects three distinct responsibilities:

| Mechanism | Producer and actual consumer | What completion means |
|---|---|---|
| Preview/document gate | Local files, command strings and launch decision tables → Node checks → ready/digest/CLI exit | Required local document predicates hold, not tests performed or actor authenticated |
| Maintainer release procedure | Human reads exact-commit evidence, checks permissions/signature and issues tag/promotion operations | A prescribed authorization and operating process; prose alone does not enforce it |
| Artifact release pipeline | Tag/ref → verify job → one packed archive/hash → three-platform lifecycle → same-file publish → registry integrity → dist-tag/GitHub release | Concrete job and byte-identity checks can block later actions; not all prior or downstream claims are covered |

This is a material positive finding, not merely a catalogue of missing checks. The shipped workflow does preserve a tested archive across stages instead of rebuilding it in the publishing job. Conversely, the existence of that strong byte-binding mechanism does not make the separate document gate an authenticated approval record. Sources: R-GATE, R-PREVIEW, R-RUNBOOK, R-RELEASE, R-REUSABLE.

## 2. What the document approval gate actually verifies

The release-approval script chooses a version from package.json and derives paths under docs/releases/<version>. It reads an owner packet, URL ledger, preview manifest and six announcement/copy files. Eight named decision rows must say approve/approved; seven URL-surface labels must occur; blocker phrases must be absent. It checks its package script/file registration, that the final command appears in three documents, and that selected copy lacks specified placeholders/private paths. A final required sentence explicitly says the packet alone does not authorize public actions.

These checks are useful for incomplete launch preparation. Missing rows, a defer/block state, missing copy, or a known placeholder can produce ready=false and CLI exit2. Invalid flags fail separately with exit1. A caller that actually invokes this CLI can stop on that exit status.

But the decisive predicates are local text checks. The decision parser stores the first two cells of qualifying Markdown rows; the evidence/notes columns do not become executed evidence. The URL check recognizes surface-label strings, not parsed reachable URLs, publisher identities or matching release artifacts. Listing a verification command is not running it. There is no Git HEAD comparison, approving-user authentication, signed receipt, approval expiry or candidate-byte digest in this script.

A concrete countercase is a ledger retaining every required label and command while its URL cells are replaced by non-URL text that contains no blocked phrase. The URL predicate can still pass. Likewise changing ordinary source code outside these documents leaves their readiness predicates unchanged. These are consequences of the complete implementation, not an executed bypass or an assertion about every possible operator's policy.

### The digest identifies the report predicates, not the candidate

The digest is the first twelve hex characters of SHA-256 over check id/status/evidence tuples. It does not hash source files, document bytes, the release archive or the separately returned release field. In a fully passing report the evidence strings are fixed descriptions/counts. Different candidates, changed approved text, or different version directories yielding the same tuples can therefore have the same digest without any hash collision.

This is acceptable as a compact summary fingerprint; it is insufficient as evidence that a later candidate is the one an owner reviewed. Fresh recomputation improves document freshness only at the observed predicates. It does not add a missing candidate binding. Sources: R-GATE and T-GATE.

## 3. Preserve the historical release scope instead of conflating versions

The preview-pack script is explicitly fixed to 2.0.0-rc.1. It checks required files and manifest references, listed verification commands, selected sanitization markers and preserved publication blockers. Its digest has the same check-tuple scope. It does not invoke npm pack or execute its listed tests. A ready preview can deliberately retain approval-gated publication steps; this is preparation readiness, not permission to publish.

The inspected package version is 2.2.1. The approval script follows that version but retains owner-packet and ledger filenames ending in 2026-05-19. The complete pinned 2.2.1 directory contains launch-runbook.md, patch-execution.md and release-notes.md, not those required packet/ledger/preview-manifest files. Therefore an unchanged checkout of this pin cannot satisfy that script's required document predicates. This is a source-derived blocked result, not a performed command or current public release-status check.

The rc.1 owner packet is meaningful historical evidence of the intended human procedure. It asks for evidence rerun from the intended commit, records action-specific approvals/deferrals, and denies authority to publish merely from the packet. Its recorded live URLs, dates and historical test/CI counts were not independently verified here. They must not become current 2.2.1 readiness facts. Sources: R-PREVIEW, R-PACKAGE, finite 2.2.1 directory, R-OWNER-RC.

## 4. The actual publishing workflows qualify an exact archive

Both release.yml and reusable-release.yml implement a coherent execution chain. The first responds to version-tag pushes; the second accepts a tag through a reusable/manual invocation and explicitly checks out that tag.

The verify job requires the checked-out commit to equal freshly fetched origin/main, validates the tag/version relation, invokes build/metadata and supply-chain checks, and requires a release-notes file. It queries the registry to distinguish an existing version from E404; unrelated registry errors stop rather than being treated as nonexistence.

It then calls npm pack once, selects an expected archive name, refuses an ambiguous set of archives and hashes the actual file. The uploaded bundle contains that archive, release notes and the lifecycle test script. Three lifecycle jobs download it and receive the verify job's expected SHA-256. Publish depends on both verify and lifecycle; it downloads and hashes the file again and publishes that archive, not a freshly packed working directory.

This establishes an actual source-level mechanism for **tested bytes → publishing input bytes**. A replaced archive failing the digest check blocks the followed path. An already published package must also match the candidate's SHA-512 registry integrity rather than merely sharing a name/version. These are stronger controls than the document digest or a statement that a file exists.

The two workflow bodies do not directly run the preview/owner-document gate or consume its ready/digest output. The package prepack hook builds OpenCode; it is not an indirect call to those gates. Their operational prerequisites are the explicit verify/lifecycle checks, plus whatever external repository, registry and human controls actually apply. This is not a claim that no other caller anywhere uses the document gate. Sources: R-RELEASE, R-REUSABLE, R-PACKAGE; W-GH-NEEDS explains the job dependency contract.

## 5. What the three-platform lifecycle really tests

The lifecycle script verifies archive path, regular-file status, containment, archive count and SHA-256 before installation. It creates temporary home/project directories and a narrowed inherited environment; provider credentials are not passed. It installs the downloaded tarball and exercises packed public CLI entrypoints.

The scripted checks include guided setup, repeated installation and ownership-ledger preservation, status/doctor, deliberate managed-file drift, repair, uninstall and retention of user sentinel files. A test that deliberately changes managed content and expects doctor to detect it has genuine error sensitivity for that specific property. It is not merely a string inventory.

The oracle is nevertheless selective. Claude plugin commands are served by an explicit fake executable and state files, not a real Claude host. OpenCode is checked through selected install/doctor/uninstall operations under the ordinary .config/opencode root; the script does not start OpenCode and exercise its callback dispatcher. Thus it neither resolves Note25's callback mismatch nor tests Note26's explicit canonical/legacy same-root case. Windows, macOS and Linux jobs vary platform, but do not automatically cover every configuration, host version, interrupted operation or model task.

These are inspected test definitions. No job, installation or induced drift was run by this research. The external Actions implementations, full build-test internals and every underlying install helper are not re-certified by reading the lifecycle driver. Sources: R-LIFECYCLE, R-RELEASE, R-REUSABLE; Notes25–26 retain their original evidence.

## 6. Signed-tag procedure and executable gate are separate

The 2.2.1 runbook requires an authorized maintainer, green CI and CodeQL on the exact merged commit, matching HEAD/origin/main, a signing identity and explicit signed-tag creation/verification. This is substantive operating guidance.

The actual release YAMLs enforce commit equality and version checks but do not themselves verify the tag signature, look up that exact CI/CodeQL conclusion, or declare a protected deployment environment with required reviewers. A signature requirement in prose and an action named Use reviewed release notes are not their own authenticated observations. Branch/tag rules, token permissions and human controls may supply additional protection; these were not read and must not be presumed absent.

The older release.sh helper has its own main/clean-tree/version checks and runs build/manifest checks after changing multiple files. It then commits, invokes git tag without an explicit -s flag, pushes main and tag, and prints Released. Git configuration may still sign that tag, so an inevitably unsigned-tag claim would be wrong. The helper does not wait for remote lifecycle/publish completion, and later update/test failure can leave earlier local edits because this is not a transactional file operation. Its success message denotes completion of its commands, not independently observed public distribution. Sources: R-RUNBOOK, R-BUMP, R-RELEASE, R-REUSABLE.

## 7. Publication, promotion, failure and retry

Stable versions initially publish under staged; after registry readback and SHA-512 comparison they move to latest. Prereleases instead publish under next initially, before that post-publish readback. These branches are not identical staging policies.

A distribution tag is a selectable label for a published package. npm publish --tag staged is not the separate npm stage publish review mechanism and does not make the version confidential or nonexistent. If registry readback fails after publication, the workflow retries the lookup up to six times, then fails without automatically deleting the published version. If promotion succeeds and the GitHub Release step fails, npm can already point to the new version while the full workflow is unsuccessful. This is a multi-service sequence, not one atomic transaction.

The runbook offers a meaningful manual rollback: an authorized owner points latest back to a known version and checks it, while keeping versioned packages/tags intact. That changes discovery for subsequent default installs; it does not undo installs that already selected exact or previously promoted versions. These are source procedures and documented npm semantics, not a rollout exercised here.

### Correct individual candidates can still race at the shared tag

The exact-main check is performed at verification, not continuously until promotion. A conditional ordering is possible:

1. Stable release A passes exact-main verification and continues slowly.
2. Main advances; newer release B passes its own verification and promotes successfully.
3. A finishes and unconditionally moves latest to A's older version.

Both archives can satisfy every byte-identity check. The two workflow bodies have no common concurrency group or expected-current-dist-tag/monotonic-version predicate at promotion. External serialization could prevent the ordering; no concurrent workflow was run, and no actual regression is alleged. The point is the scope of the control: per-candidate identity does not serialize writes to a shared publication pointer.

A fresh rerun differs: if A begins verification only after main advances, the exact-main check rejects it. This is a real conservative boundary, but it also means reusing an older release's name does not by itself provide an unconditional recovery path. Sources: R-RELEASE, R-REUSABLE, R-RUNBOOK, W-NPM-TAG.

## 8. Provenance does not automatically refer to the same packaged object

The publish command requests npm provenance. Separately, the generic SLSA workflow declares release-published/manual triggers, independently packs the source, hashes the new archive and passes that subject to an external provenance generator. It does not download the release pipeline's tested archive or compare with its recorded digest.

That separate workflow can provide provenance for its own subject; source co-location or identical package version does not prove the independently rebuilt subject is byte-equal to the registry artifact. Actual event triggering, build reproducibility, external generator behavior, emitted attestations and verification were not examined. The workflow comment describing a SLSA level is a target declaration, not this study's certification. npm's own provenance documentation also distinguishes a verifiable source/build link from absence of malicious code. Sources: R-PROVENANCE, R-RELEASE, W-NPM-PROVENANCE.

## 9. Verification standing, reuse and disposition

T-GATE defines useful positive approved-document and negative deferred/missing-marker/placeholder cases, including CLI exit checks. It builds local fixtures and uses the actual gate code, but does not authenticate a human, fetch a URL, submit a changed tarball or inspect a live release. The first passing fixture even represents the local script as placeholder text because existence is the tested predicate. This is appropriate for testing the predicate, not proof of execution or approval of those represented objects. The tests were not run.

No new fixture was necessary to distinguish the explicit text predicates, byte hashes and job dependencies. This avoids treating another mock as evidence about hosted execution. U13-A satisfies its original bounded source question: document readiness, human operating procedure, exact-artifact qualification and real publication consumers are explained with positive and failure/continuation counterparts. Actual protected policies, actor/signature authority, exact CI state, builds/runs/artifacts/attestations, concurrent promotion, service recovery and deployed behavior remain stronger open claims.

Candidate reuse includes report identity versus artifact identity; listed evidence versus executed evidence; per-action intent versus authenticated authority; checked candidate versus current shared release pointer; single-service success versus multi-service completion; distribution rollback versus effect reversal; provenance subject versus installed/published artifact. These are research distinctions, not adopted SOUL/Development OS components or Foundation taxonomy.

After verified publication, U13-B / Q07d3 follows the actual supply-chain scanner invoked before packing: scripts/ci/scan-supply-chain-iocs.js and its advisory-source companion. Determine what data and freshness it uses, what a clean or unavailable result means, and which consumer blocks. Scanner implementation, other native variants, observability/resources, native syntheses/CORE and final omissions remain unfinished; the ECC study is not complete.
