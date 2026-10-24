# U18-E — Nasiko acquisition and lifecycle source ledger

**2026-09-23 · Q02h / MR45.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note44](../notes/44-NASIKO-ARTIFACT-IDENTITY-AND-LIFECYCLE-RECOVERY.md), [round](../ROUND-U18-E.md), [STATE](../STATE.md). SOURCE OBSERVATION, TARGET CLAIM/INSTRUCTION, TEST SOURCE INSPECTED and explicitly conditional INFERENCE. No target execution, E11, release-artifact download, registry query, installation or executable launch.

## Original identities and actual reading

All target paths resolve under [the fixed ECC commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Ranges below are inclusive requested ranges, with oversized final requests ending at actual EOF. FULL means the body, not all external dependencies or installed behavior.

| Handle | Path | Git blob | Coverage and role |
|---|---|---|---|
| ENTRY | scripts/nasiko.js | 71a240878253f4fe9702eeb7cf3f1c9a19c3ea75 | FULL1–260/EOF. Public status/install/uninstall dispatch; argument/consent/preview inputs; status-only executable override; output and error handling |
| LIFE | scripts/lib/nasiko-release.js | 6e5391768084e58409677f322c682d599371998d | FULL1–240,241–510/EOF. Embedded release table; platform, digest, manifest, archive, transport, directory, bounded-file, receipt, lock, install/reuse and staged-removal implementation |
| TEST | tests/ci/nasiko-control-plane.test.js | ad68cec60fd18e75559a18391eb04288018524ce | FULL1–240,241–480,481–750/EOF. Actual local filesystem/child-process and injected acquisition/extraction/inspection/failure tests; distribution/text assertions. INSPECTED, NOT RUN |
| SKILL | skills/nasiko-control-plane/SKILL.md | 43a9c50d4f5a345f3e22a55fae2bb65922658793 | FULL1–230/EOF. Explicit lifecycle-only purpose, local preview/consent, qualification, telemetry and failure responsibilities |
| CLI | scripts/ecc.js | 6c2aee1a5826475bfd05552a1bc485b35295bf9a | Fresh SELECTED190–370/EOF: full resolveCommand/runCommand/main for global dry-run→environment→Nasiko handoff. Earlier same-conversation FULL body from U18-C reused for command registry/help. Not a fresh full reread |
| NEXT-CLAW | scripts/claw.js | 982ce5c22cdc8ec77ebcf4fac58fdfc8786f98b7 | SELECTED1–95 only. NanoClaw REPL description; session/history and optional skill-context helpers; beginning of askClaude. Next-work qualification only, not complete invocation/REPL/test research |

Four new complete bodies, one selectively reread public caller with its prior full context, and one selected next-work prefix. The previous Nasiko1–80 lead is superseded by the full ENTRY read and is not independent corroboration. No external Nasiko implementation, binary, archive or installed environment was read. Distribution declarations asserted by TEST are not newly verified pack/installation results; earlier package/profile/component reads retain their U18-C scopes.

## Claim-to-chain bindings

1. **Native lifecycle:** CLI maps Nasiko to ENTRY; ENTRY calls LIFE install/inspect/uninstall. LIFE handles acquisition and file state, with no child-process invocation of the acquired artifact. SKILL expressly distinguishes this from running a control plane, governance, ACLs, telemetry and Itô connectivity.
2. **Integrity chain:** LIFE's qualified table supplies manifest/binary digests; fixed-origin HTTP and size bounds precede manifest digest/shape, exact archive size/digest, bounded extraction and final binary digest. Extraction returns one buffer to a separately computed destination, not arbitrary archive-named filesystem writes. Source/metadata labels do not independently verify release authorship or licensing.
3. **Local consent/preview:** ENTRY requires version for public mutation; LIFE defaults direct-helper version separately. dryRun returns before consent, target-state qualification, mkdir/lock/network. yes gates actual mutation; SKILL adds an authored review responsibility. Directory canonicalization and non-Windows ownership/mode checks have their specific scopes.
4. **Global preview counterpart:** CLI removes leading --dry-run and sets ECC_DRY_RUN. Nasiko receives env and remaining arguments, but complete ENTRY/LIFE never read that variable. With valid version and yes, a leading-global-only request enters mutation. The documented local --dry-run does work. TEST injects dryRun:true directly and cannot detect public propagation mismatch.
5. **Status versus mutation identity:** ENTRY's explicit executable override belongs only to status. LIFE mutation chooses installDir/default. Inspecting one custom executable does not implicitly select the later mutation target.
6. **Qualified versus requested host:** LIFE inspection resolves release by receipt platform/architecture and compares live bytes/selected receipt fields; install reuse checks only qualified plus version. For same-version, different supported non-Windows platforms with the same binary filename and a matching installedPath, genuine foreign-platform bytes/receipt can be reused while the returned plan describes the requested platform/digest. Stipulated source case, not a downloaded binary or executed compatibility test. artifactDigest and executable permission are not inspection predicates.
7. **Ownership/locking:** exclusive lock creation and descriptor-identity cleanup, conservative live/malformed-owner handling and dead-owner recovery are real controls. TEST includes initialization failure, a displaced lock, injected Windows-like path stats and a real finished-child definition. No execution or hostile-writer guarantee is inferred.
8. **Binary/receipt publication:** LIFE publishes the final binary with wx, flags ownership, writes/fsyncs/checks size, then exclusively writes the receipt and only afterward flags receipt ownership. NODE-FS supports exclusive-create semantics. A stipulated receipt-created-then-write-failed state leaves an orphan receipt while binary cleanup occurs; retry's missing-binary path does not reconcile it before another exclusive receipt write. TEST's throwing metadata substitute creates no receipt and therefore does not exercise this state.
9. **Removal and later recovery:** LIFE stages two names, restores a prefix on staging failure, then reports failed cleanup paths. After cleanup failure its staging flags are cleared, active names can be absent and tombstones remain. Later status/uninstall do not scan them; reinstall does not enforce the error message's cleanup instruction. TEST checks immediate error/leftovers, then removes the fixture directory; it does not test lifecycle recovery. ENTRY emits error text/exit1, not a structured JSON cleanupPending object.
10. **Transport and publication labels:** NODE-HTTP qualifies LIFE's request timeout as inactivity-related rather than an end-to-end15-second guarantee. TEST's atomic-install title is not an assertion of transactional binary+receipt/crash durability. Findings preserve useful controls and their actual discrimination scope.

## Test oracle and inference limits

Successful installation uses synthetic manifest/binary digests via releaseOverride, a fetchBytes replacement, a non-gzip archive string and an extractBinary replacement. Removal tests can replace the qualification oracle. These isolate meaningful local paths but do not authenticate actual release bytes or exercise the production transport/extractor as a single joined lifecycle. Tar framing has separate small constructed fixtures. Status and dead-owner tests define real subprocess observations without launching the actual Nasiko product.

None of TEST, ENTRY or LIFE was executed. No local behavioral probe was opened. The global preview, foreign-platform reuse, orphan-receipt retry and tombstone-continuity cases are source deductions with stated inputs/failures, not measured incidents, attacks, user loss or quantified rates. No release-table bypass or unsafe-action experiment was performed. Q02h2 retains stronger runtime/platform/transport/archive/concurrency/approval/recovery and useful-outcome claims.

## Search and external documentation

Connected GitHub searches for nasiko-release(topn8) and nasiko(topn12), scoped to affaan-m/ECC, located files on default branch bf70150eb2df8070024e5bdf08e4aa08959e2735. The broader response was clipped. Searches located paths only; every new substantive target body was fetched at the fixed research pin. No exhaustive caller or release-document absence is claimed.

Primary documentation checked2026-09-23:

- NODE-FS: https://nodejs.org/api/fs.html — selected wx/open and writeFileSync/flush contracts. wx creates exclusively and fails on an existing path; synchronous writing is not itself an application-level two-file transaction. Used narrowly for the observed calls and conditional retry analysis, not an installed OS/disk test.
- NODE-HTTP: https://nodejs.org/api/http.html — selected timeout event and request.setTimeout sections. Socket inactivity and connected-socket behavior qualify the claimed bound; the target's callback explicitly destroys the request.

The pages displayed Nodev26.10.0. That is documentation identity, not ECC's installed runtime. Unrelated web-search results were discarded. No current Nasiko release availability, product safety, license validity, functional service, telemetry or build reproducibility was independently established. No auxiliary source download was attempted this turn; past DNS/acquisition failures remain historical.

## Recovery and publication provenance

Fresh main-ref recovery returned02a48e6ef5bd894188152775d46bccc7f70e9147, unchanged from U18-D closure. Current AGENT and R04–R09 were fully recovered, including clipped tails; same-conversation full R01–R03 remained active. Root research/studies routers, METHOD and WHY were fully read. Current package entry/question/source/receipt context was reused at checked identities, not claimed as a fresh reading of all prior files.

MR45 opening d7e73461e975d3f3565dc275236c154930433697 preceded activation fd99cde131edd39fe5f361b13f6b8bd920cf4bbd. Activation STATE was fully read back as79fa387bbde5f7c68ddedb59209049e454c2cbe7 before inquiry. Note44 was created9324093df2df0c3dd037ce912f7545f706918bd3. Subsequent result/entry/catalogue/diff/readback/receipt/STATE checks, not creation alone, determine checked publication.

Original Notes01–43, experiments/E06 exclusion/E05 histories/E10 recovery, METHOD/WHY, historical inventory and unrelated project/control surfaces remain outside mutation. Next U18-F/Q02i NanoClaw is selected, not started; its role is not inferred to be another external product merely from its place in G5.
