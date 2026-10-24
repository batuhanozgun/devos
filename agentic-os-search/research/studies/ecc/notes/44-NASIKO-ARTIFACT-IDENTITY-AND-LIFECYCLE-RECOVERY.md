# Note44 — Nasiko artifact identity and lifecycle recovery

**2026-09-23 · U18-E / G5 / Q02h / MR45 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-E-SOURCES.md), [round](../ROUND-U18-E.md), [STATE](../STATE.md). Source observations, inspected test definitions and explicitly conditional deductions; no target execution, E11, release-artifact download, registry query, installation or executable launch.

## 1. Native responsibility: acquire and maintain a binary, not operate a control plane

Nasiko differs from Note43's separately installed Itô client. ECC's Nasiko implementation itself retrieves a pinned manifest and archive, extracts and verifies a binary, writes it with a local receipt, inspects the pair without executing it, and offers qualified removal. The public dispatcher routes to scripts/nasiko.js; that script delegates to nasiko-release.js. The complete two implementation bodies contain no child-process launch of the acquired Nasiko artifact. [CLI, ENTRY, LIFE]

The useful chain is:

`explicit version/platform/destination/consent → ECC's release table → fixed-origin manifest → archive → extracted binary → exclusive destination + receipt → read-only qualification → reuse or staged removal`.

The installable skill accurately narrows its purpose to this lifecycle. It explicitly separates installation from a running server, governed agents, routing/ACL correctness, observability, telemetry consent and Itô connectivity. Those external capabilities are not dismissed; they simply are not established by this bridge. The research does not install Nasiko or independently evaluate that product. [SKILL]

## 2. There is a substantive integrity chain before binary publication

The release table contains only v0.1.0, with separate manifest and binary digests for five platform/architecture combinations. The public mutation parser requires a version; getQualifiedRelease rejects latest, unknown versions and unsupported combinations. The helper API separately defaults an omitted version to v0.1.0. This distinction matters when describing CLI versus direct helper requirements. [ENTRY, LIFE]

The production acquisition path uses a fixed HTTPS registry origin, refuses redirects and non-200 responses, and bounds response sizes. It verifies the downloaded manifest against the table's digest before parsing. The accepted manifest must declare schemaVersion2 and exactly one gzip layer with a valid SHA-256 digest and bounded positive size. The fetched archive must match both that exact size and the layer digest. After extraction, the binary must match the independent binary digest in ECC's release table before destination publication. This is not merely trusting a checksum supplied alongside arbitrary new bytes. [LIFE]

The extractor inflates into bounded memory rather than invoking tar or a fetched shell script. It accepts the expected regular binary name, narrowly permits ignored AppleDouble/PAX metadata, rejects unexpected entries, and checks octal size, padding and a complete zero terminator. Entry names are not used to choose arbitrary output paths: the installer separately computes one destination and publishes only the extracted binary buffer. These are real restrictions, not a universal tar implementation or proof of all malicious-archive behavior. The final pinned binary digest is a separate check. [LIFE]

The trust anchor is still ECC's reviewed source/table. The helper does not establish how those digest values were approved, verify a release signature, rebuild from upstream source or independently check the asserted source URL/license. Matching receipt strings to fixed sourceUrl/license fields is correspondence, not a new provenance or licensing audit. No current registry availability or actual artifact contents were queried. [LIFE]

The request timeout destroys an idle request, but Node documents request.setTimeout as a socket timeout after connection, not a whole-operation deadline. Thus the 15-second setting is useful without proving that the complete acquisition, which runs while the lifecycle lock is held, finishes within15 seconds. No slow-transfer experiment was performed. [LIFE, NODE-HTTP]

## 3. Destination, consent and concurrency controls exist at specific entry points

Mutation destinations are normalized from an explicit install directory or a platform default. The implementation rejects a filesystem root and Windows UNC/device-style paths, resolves the existing ancestor, then checks the actual install directory. On non-Windows systems the directory must belong to the current user and not be group/world-writable. Existing symlinked ancestors can be canonicalized; this is not a categorical rejection of every symlink anywhere in the original input path. [LIFE]

A real mutation requires options.yes. The skill additionally requires the user to review version, origin, digest and destination before approval. The boolean CLI choice is an executable gate, not an authenticated approval bound to immutable preview bytes. Dry-run returns before consent enforcement, directory creation, lock acquisition, existing-install qualification and network access. It is an offline proposed selection, not proof that application or removal will pass later checks. [ENTRY, LIFE, SKILL]

The lifecycle lock uses exclusive creation, records PID/time/token, flushes the lock file and uses descriptor identity for cleanup. A live or ambiguous owner blocks recovery; a confirmed dead owner permits an identity-checked takeover. Negative tests challenge initialization failure, malformed ownership, replacement locks and a finished child owner. These are useful cooperative serialization/recovery controls. They do not make all pathname operations atomic against arbitrary external writers or prove OS-independent crash durability. [LIFE, TEST]

### Countercase A — the global preview flag does not become Nasiko's local preview option

The public ECC dispatcher advertises a leading global --dry-run, removes it from the command position and sets ECC_DRY_RUN=1. For Nasiko it forwards the remaining arguments and the environment. Neither ENTRY nor LIFE reads ECC_DRY_RUN; ENTRY derives options.dryRun only from a --dry-run argument within the mutation's own arguments. [CLI, ENTRY, LIFE]

Consequently, the source trace for a leading-global-preview invocation with a valid version and explicit --yes enters the real Nasiko mutation path, not its preview return. Install can create its directory/lock and proceed to acquisition; uninstall can enter removal when its own qualification conditions hold. This is not a claim that consent is absent or that every dry-run form fails. The skill's documented local form, with --dry-run after the Nasiko install/version arguments, does set the correct option and returns offline. No example command was executed. [SKILL]

The existing dry-run test calls installNasiko directly with dryRun:true and verifies a zero fetch count. It meaningfully tests the helper's local branch, but never sends a leading global flag through ecc.js. The propagation gap and the correct local preview therefore coexist; the test does not join these two entry contracts. [TEST]

Status also has a different target selector: ECC_NASIKO_CLI_EXECUTABLE affects readStatus, whereas install/uninstall use installDir or their default directory. Inspecting a configured file A is not evidence about mutation destination B unless the caller deliberately aligns them. The explicit install-dir option provides a common route; the code does not automatically bind the earlier status object to a later mutation. [ENTRY, LIFE]

## 4. What qualified means, and what reuse actually compares

inspectInstalledNasiko reads bounded regular-file bytes without running the executable. It rejects a symlink at the executable entry, uses O_NOFOLLOW where available and a descriptor/path identity fallback otherwise, and reads a bounded receipt. Qualification requires the live binary digest plus selected receipt fields to agree with a release looked up using the receipt's version/platform/architecture. installedPath must equal the supplied executable string. The recorded artifactDigest is not included in this later predicate. [LIFE]

This is stronger than file presence or trusting nasiko --version output. The status subprocess test places an unqualified script with an execution marker and asserts installed:true, qualified:false, version:null and no marker. The status command normally returns exit0 for both qualified and unqualified/absent reports; consumers must inspect the payload, not treat exit0 as qualification. [ENTRY, TEST]

### Countercase B — a recognized release is not necessarily this machine's requested release

The inspection predicate does not compare receipt platform/architecture with the current machine. The install reuse branch only requires existing.qualified and existing.version === requested version. It does not compare the existing binary digest or recorded platform with the newly selected platform release. [LIFE]

Stipulate a genuine, correctly hashed Linux release and matching receipt at the expected non-Windows destination, with installedPath matching that destination, while the caller now requests the same version for macOS. Both platforms use the filename nasiko and have entries in the table. Inspection can qualify the Linux pair; install can return reused:true under the same version test. Its returned plan still carries the requested macOS platform/digest, not a re-bound description of the reused Linux bytes. No forged digest, service error or executed binary is needed for this source countercase. The actual bytes and receipt were not acquired or constructed in this research.

The same bounded inspection does not test executable permission or functional startup. The normal new-install path requests executable permissions, but later status/reuse is not a repair of changed permissions. These observations do not negate byte qualification; they show that historical recognized-release identity, requested target identity, present launchability and useful control-plane behavior are different conditions. [LIFE, SKILL]

## 5. Caught-error cleanup is not a transaction over binary and receipt

The installer refuses an incompatible/unqualified existing executable. For a new file it opens the final destination with wx, marks that creation as owned, writes the buffer, fsyncs and checks size. It then writes a separate receipt with wx and mode0600. Only after that call returns does metadataOwned become true. On a caught failure, cleanup removes only paths whose ownership flags were set. The exclusive-create behavior protects a destination that appeared before publication; a test injects precisely that event and asserts preservation of the competing file. [LIFE, TEST, NODE-FS]

This sequence is not an atomic publication of both files. A crash after binary creation and before the receipt can leave an unqualified binary; recovering the dead process's lock alone does not qualify or reconcile that pair. The ordinary next install then refuses the unqualified existing executable. This is conservative non-overwrite behavior with an unresolved recovery responsibility, not evidence that a crash occurred. [LIFE]

### Countercase C — receipt creation followed by write failure leaves a different retry state

Suppose the receipt file is created but an I/O error occurs before its write call returns. metadataOwned is still false, while destinationOwned is true. Under that stipulated failure, the catch removes the binary but leaves the partially created receipt. On retry, inspection returns absent immediately when the binary is missing and does not reconcile the orphan receipt. After another acquisition/publication attempt, the exclusive receipt write encounters the existing path; the caught-error path again removes the newly created binary. [LIFE, NODE-FS]

The metadata-failure test replaces writeMetadata with a function that throws before creating any receipt and checks only that the binary disappeared. It verifies a useful cleanup case, but does not distinguish the created-then-failed receipt state or successful recovery from it. The source case is conditional reasoning, not an executed disk failure. Whole-file publication success and final-state existence assertions do not establish crash consistency merely because a test title calls installation atomic. [TEST]

## 6. Removal preserves a useful failure signal but does not persist its recovery work

Uninstall acquires the same lifecycle lock and requires a qualified matching version. It first renames the binary and receipt to unique .remove- paths. If staging fails before cleanup, the catch attempts to restore staged files when the original destinations are absent. The test injects a second-rename failure and checks that both original paths remain. This is a substantive rollback path. [LIFE, TEST]

During cleanup, each staged removal is attempted; failures are collected as cleanupPending. The staging flags are then cleared even for retained files, so the catch does not undo a partially completed cleanup. The operation throws a descriptive incomplete-uninstall error naming leftovers rather than reporting success. The corresponding test asserts an error and retained .remove- files. [LIFE, TEST]

### Countercase D — absent active path is not completed cleanup

After such cleanup failure, active binary/receipt names can be absent while staged files remain. A later status checks only the active executable and reports absent. A repeated uninstall returns removed:false on that same absence; it does not discover or retry prior tombstones. Reinstallation likewise does not scan those retained paths, despite the error message's instruction to remove them before reinstalling. That instruction is caller-owned recovery guidance, not an enforced persistent prerequisite. [LIFE]

The CLI renders the thrown error message and exit1; it does not emit cleanupPending as a structured JSON failure object. The first failure remains honestly reported, but future work must retain its paths elsewhere. The local test checks immediate leftovers and then its finally block deletes the whole temporary fixture; it does not demonstrate a later real lifecycle invocation recovering them. No retained product files were created by this research. [ENTRY, TEST]

## 7. Test scope and native-system contribution

The complete test file combines real local filesystem/child-process lock tests with injected acquisition, release digests, extraction, inspection and failure callbacks. Its successful-install fixture uses a synthetic archive string and extractBinary substitute, not an actual registry gzip artifact. Tar framing is separately tested with constructed fixtures. These tests can be sensitive to their specified local errors without independently authenticating the real release table, registry transport, all extraction variants, current host compatibility or crash recovery. None was run here. [TEST]

Note44 adds an actual pinned-artifact acquisition and managed-binary lifecycle to provisional Note33. Useful controls include a multi-stage integrity chain, bounded extraction, explicit local consent/preview, non-executing status, non-overwrite publication, cooperative locking and rollback/error disclosure. The consequential boundaries are entry-specific preview propagation, qualification relative to receipt versus requested machine, two-file publication and persistent recovery after partial removal. This is not simply a claim that hashes or tests are weak; it identifies which object each real control protects and which transition remains separately responsible.

Q02h1 carries this source answer. Q02h2 preserves stronger release provenance/build/registry/runtime correspondence, host/platform/permission fidelity, full entry/config/approval binding, native transport/archive variants, hostile/concurrent filesystem and durable orphan/tombstone recovery, and useful outcomes. No upstream patch, final CORE or architecture adoption follows.

Next selected U18-F/Q02i is the existing claw responsibility: NanoClaw session/history and optional skill context → prompt → actual Claude process → reply persistence/compaction/continuation. Only scripts/claw.js1–95 was read to qualify that lead; complete invocation, REPL lifecycle and tests remain NOT STARTED. The prefix identifies an internal session REPL, not another external-product installer. No Claude/model execution, user-history mutation or new provider trial is authorized.
