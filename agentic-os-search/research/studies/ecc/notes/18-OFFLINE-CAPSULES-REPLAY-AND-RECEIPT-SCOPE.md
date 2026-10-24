# Note18 — Offline capsules, replay and receipt scope

**2026-09-19 · U10-B / Q06d2 · bounded source inquiry.** Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U10-B-SOURCES.md), [MR19](../ROUND-U10-B.md), [STATE](../STATE.md). SOURCE OBSERVATION, TARGET CLAIM, inspected test source and bounded INFERENCE are distinguished below. No target code/test, new fixture/E08, live model/provider or candidate deployment was executed.

## 1. What this framework actually is

The Node framework is a set of local evidence utilities: a typed event envelope, a hash-linked journal, a derived projection, a declared-tool response recorder/replayer, an offline receipt verifier and a report-only grouping function. Static candidate inspection exists, but its candidate execution gate deliberately refuses all calls because no supported containment backend is implemented.

This is separate from Note17's Rust recorded-score registry. The Node utilities do not compare live candidate performance or activate a selected configuration. Their narrower, implemented purpose is to preserve and inspect selected records and avoid re-firing registered tool implementations during replay. The author's architecture document explicitly retains that boundary.

The actual example is a useful discriminator: it records that candidate execution was unavailable, records static inspection and synthetic tool replay, and builds a verifiable receipt over that capsule. Its utility steps can succeed while no candidate was executed or promoted. A valid receipt is therefore not a hidden success verdict about the candidate.

The source explanation joins:

`caller-selected events → validated journal → checkpoint/projection → optional witness checks → report or caller interpretation`

and, separately:

`trusted tool implementation → saved response → fixture replay without implementation invocation`.

It does not silently join those chains to independent truth, complete observation, restored environmental effects, or runtime adoption. Sources: S164–S166 and S221–S229.

## 2. A capsule records five categories in one chain

The five lineages are plan, attempt, interaction, environment and strategy. They are labels on entries in one globally sequenced NDJSON journal, not five independent event sources. Every entry carries identity, sequence, timestamp, declared effect class, predecessor hash and allowed payload. Each entry hash covers its content except its own hash field.

The envelope enforces meaningful constraints. Retained payloads use declared scalar types; unknown keys are refused by default. An explicitly non-strict append can drop unknown fields but cannot expand the persisted schema or silently accept an invalid retained value. Descriptor checks reject accessors and unsupported object shapes before reading ordinary payload values. Canary patterns can reject recognized secret-like strings. These measures reduce malformed or unwanted record content; they do not inspect arbitrary caller behavior or prove that every sensitive string has been removed.

A field such as status, score, verdict or effect_class still carries what the caller supplied. Type-valid pass/fail numbers are not independently checked outcomes. An environment entry is not automatically a snapshot of the actual environment. The example explicitly constructs its entries and installs an onCall callback; no universal recorder is discovered merely because the framework has an interaction lineage.

The generic canonical JSON helper and strict envelope have different contracts. The canonicalizer preserves selected JSON keys, including own prototype-like names; the envelope rejects unknown top-level fields. This is not a proof of unique canonical identity for every possible JavaScript object, proxy, getter or non-JSON value. S221/S222 and the source document keep those limits separate.

## 3. Cooperative append is stronger than cached state, but not exactly-once delivery

Append obtains an exclusive local `.append.lock` with wx. It immediately reports busy if the path exists, regardless of age; it does not guess that an old lock is stale or wait/retry automatically. Under the lock it reloads and verifies current journal and metadata, deriving the new sequence and predecessor from that disk snapshot. A preopened Capsule object's cached counters are not append authority.

The writer loops through short writes, fsyncs the journal and closes the descriptor. Lock release compares the still-open lock descriptor's identity with the path and preserves a detected replacement. These are concrete protections for cooperating writers. They differ from both an unguarded append and an OS containment boundary against hostile filesystem mutation. Exclusive creation also depends on filesystem support; the Node contract qualifies network filesystems.

Three failure states must stay distinct:

| Failure boundary | Source-level consequence |
|---|---|
| Invalid payload or metadata before writing | Append refuses and ordinarily releases its owned lock; no new journal entry is written by that branch |
| Partial entry written, then I/O failure | Partial bytes remain; later append revalidates and refuses the broken tail instead of hiding it |
| Full entry written, then fsync/close/release error | The caller can receive an exception although a complete entry already exists; this is an ambiguous acknowledgement, not proof of rollback |

The last case matters for retry. A later append reloads the disk and continues the sequence, but it does not deduplicate the logical operation. Retrying the same event can append another valid event. Process failure can also leave the cooperative lock behind; recovery is deliberately not an automatic stale-lock deletion.

The inspected capsule tests include a real child contender during append, short-write and fsync error injection, replaced/missing locks and simulated Windows release cases. They are relevant error-sensitive test designs, but were not run in this study and do not certify every filesystem, crash or platform.

Create, readers, projection production, receipt production and export do not share this append lock. An append guarantee must not be promoted into a concurrent snapshot/export guarantee. Sources: S223/S228/S232; external contract W-U10B-FS.

## 4. An intact chain is not proof of the complete historical chain

The reader checks valid UTF-8, terminating newline, envelope structure/hash, exact sequence, predecessor links and canonical serialized bytes. readCapsule additionally binds metadata identity to every entry. Missing, corrupt, reordered or partial-tail data receives a named failure rather than automatic repair. Lower-level journal-only access and full metadata-bound capsule verification are different APIs.

However, standalone verify has no externally supplied expected final count or root. Removing one or more complete trailing entries can leave a valid shorter prefix. That prefix still begins at genesis and satisfies every remaining link. This is a source-derived counterexample, not a deletion experiment conducted here. The documented/tested middle-deletion and partial-write cases do not contradict it: they damage a relationship that remains observable.

A previously retained receipt provides the missing checkpoint expectation. Its verifier can reject a journal shorter than the named entry count, or one whose prefix root differs. Conversely, an authentic journal that has advanced beyond that checkpoint is reported as stale_checkpoint after its named prefix is checked. Valid historical checkpoint, current checkpoint and corrupted history are therefore distinct states.

A hash chain also does not authenticate its author or resist wholesale replacement by an actor controlling the log and its unwitnessed expected hashes. Independent custody or signature verification can strengthen a particular witness, but neither is implicit in standalone capsule.verify. Sources: S223/S225/S231/S232.

## 5. Projection and export preserve a selected view, not a reproducible workspace

Projection derives identities, entry count, final sequence/root, raw journal digest and counts by declared lineage/effect class from the verified snapshot. It does not calculate task success or infer unrecorded events. The same verified inputs yield the same projection, but determinism of that transformation is not completeness or truth of the inputs.

exportBundle writes a projection in the source capsule, then copies capsule.json, journal.ndjson and projection.json. It does not copy the workspace, replay fixture directory, evaluated artifact or receipt automatically. The example explicitly writes its receipt separately and supplies the artifact independently when verifying the bundle.

The export is consequently a minimal evidence bundle, not a complete replay environment or a restored execution state. Because the files are copied sequentially and outside the append lock, the documented small, quiescent-capsule condition is material. No atomic concurrent export, power-loss recovery or hostile-path guarantee was established. Sources: S223/S228/S229.

## 6. Replay reproduces a response, not the original effect

FixtureStore keys a record by the canonical hash of tool name and arguments. It stores the response and argument/response hashes. Replay checks the declared tool, effect limit and fixture correspondence, then returns the recorded response without invoking the registered implementation. Missing/corrupt/mismatched fixtures fail; there is no fallback to an unexpected live call.

Replay also refuses declared SE3 and SE4 tools even if the configured maximum is raised. This is a real guard in that wrapper. Yet effect classes and determinism are declarations, not measurements or operating-system permissions. The admitted replay branch avoids calling the implementation; it does not sandbox arbitrary caller JavaScript.

Record mode is different: it invokes a caller-supplied trusted implementation, saves the response and emits an event. The default effect maximum is SE2, but a trusted caller can configure another maximum. Therefore 'the candidate gate is disabled' does not mean 'no library entrypoint can execute supplied code'. The gate's untrusted candidate execution and the replayer's trusted record-mode tool are separate responsibilities.

A returned replay response also does not recreate a file, database write, worktree or remote effect that originally produced it. A tool that originally wrote a local note can replay an ok response without writing that note. This is deliberate avoidance of repeated effects, not environmental restoration.

### Identity, freshness and event gaps

The fixture key does not include implementation version, environment revision, time or external data version. A matching tool/argument pair can therefore retrieve an older response even when the current world has changed. Hash mismatch detects altered/inconsistent bytes, not arbitrary temporal staleness. Re-recording the same key overwrites that fixture rather than creating an immutable capsule-style history. The determinism label does not supply repeated-sampling logic.

Fixture responses are stored separately from the envelope and do not pass through its payload allowlist/canary function. A caller must not inherit a capsule privacy claim for raw fixture content. The minimal capsule export excludes those files rather than certifying them safe.

Observation is also conditional on the path. The example connects onCall to append, but an unknown tool, missing fixture, implementation error or storage error can occur before emit. In record mode the real effect precedes fixture persistence and the callback; failure later is not compensation for that effect. An onCall exception can follow a saved response. The source does not provide one atomic transaction joining effects, fixtures and capsule acknowledgement. Sources: S224/S229/S230.

## 7. Receipt verification is parameterized by its caller

buildReceipt binds capsule root/count, journal digest, projection hash, identities, optional artifact/gate digests and its own body hash. It persists a verified projection before returning the receipt; it is not a read-only call even when no receipt output path is provided. verifyReceipt is read-only and compares the supplied saved projection against a fresh derivation rather than healing a missing or forged projection.

The major distinction is between checks that always run and checks the caller must request:

| Check | Actual admission condition |
|---|---|
| Receipt shape/hash, journal integrity, count/root/checkpoint and projection correspondence | Required for ordinary successful verification |
| Signature | Checked only when an external verifier callback is supplied; a signature field alone does not activate that check |
| Evaluated artifact | Compared only when artifact bytes or an artifact digest are supplied to verification |
| External gate receipt | Compared only when that object is supplied to verification |

A non-null artifact or gate digest in the receipt does not force the caller to provide the external object. The generic ok result does not enumerate omitted optional checks. The CLI passes optional artifact/gate inputs but exposes no signature-verifier option. Its normal successful result must not be called authenticated signing verification.

This yields a bounded source counterexample: a receipt carrying an artifact digest can verify against its unchanged capsule without an artifact argument even if the external artifact has since changed. Supplying the changed artifact activates a comparison and rejects it. Similarly, an invalid signature is not detected when no verifier is supplied. These are API scope conditions, not a claim that the requested checks are bypassed when enabled.

Gate-receipt support is compatibility hashing of supplied bytes and a copied verdict, not validation that the current disabled gate produced them. A caller-provided object containing PROMOTE can be hashed without executing or admitting a candidate. The receipt tests intentionally use such synthetic gate objects. A signature, when actually checked with the intended key, binds a signer to bytes; it does not independently establish the reported task outcome or organizational authority.

The tests include real Ed25519 wrong-key/unsigned rejection as well as separate synthetic-signature compatibility vectors. They also check altered artifacts when supplied, missing projections without repair, stale checkpoints, malformed counts and identity mismatches. None was executed by this research. Sources: S164/S225/S231/S235.

## 8. Retrospective grouping does not turn event counts into outcome evidence

The grouping utility accepts up to 100 explicit capsule directories from one declared task family and recomputes each projection from journal/metadata. It does not trust a saved projection. An invalid capsule or mixed family rejects the report; it does not silently omit inconvenient inputs.

Repeated run_id/capsule_id identities count once only when their verified projection hashes match. Conflicting checkpoints of the same identity are refused instead of choosing a winner. This is useful protection against counting copied snapshots twice. It does not prove that distinct IDs represent independent tasks or trials.

The output groups by declared harness version and counts capsules, entries, lineages and effect labels. It deliberately ignores payload scores, verdicts, pass/fail totals, durations and costs. report_only remains true. These are source-bound descriptive counts, not a learned improvement, performance comparison or promotion signal.

The report omits payloads, input paths and raw run/capsule IDs, but retains family/version labels verbatim and linkable digest references. It is not universal anonymization. Sources: S226/S228/S233/S235.

## 9. Actual use and deliberately unavailable execution

The CLI and example join the utilities end to end. The example's all-five-lineages condition is fulfilled by its own curated record production, including a blocked attempt and unavailable environment. A successful receipt over those records correctly preserves the refusal; it does not reverse it. Static candidate digest, single-file receipt artifact digest and fixture response hash identify different objects and must not be conflated.

The broad eval-harness skill separately describes interpreted evaluation-driven development with code/model/human graders. Its local-utility section explicitly forbids treating receipts or utility tests as containment/promotion evidence. The harness-optimizer agent instead instructs a host to invoke a separate audit script and test suite, make reversible configuration changes and retain human-sensitive review. The harness-audit command points to a deterministic scorecard engine. These procedural references are not an executable Node receipt-to-change bridge, and that separate engine's full scoring/caller behavior remains outside this unit.

S166 runGate/runVariant and both retired child/preload paths refuse before candidate execution. Pure child-result and baseline-validation helpers remain available but are not called by a supported gate in this release. Their presence and test assertions are not a containment backend. Likewise, a test directly importing a trusted example solve function is not evidence that the refused gate has become operational.

This aligns with the documented limited purpose without assuming that every other ECC or custom consumer has been exhaustively searched. Sources: S164–S166/S227/S229/S234–S235/U10B-P1–P3; W-U10B-PERM bounds the separate Node permission concept.

## 10. Bounded result, remaining questions and continuation

The original return condition is met at source level: actual event/fixture/receipt producers, their consumers, checkpoint identity, optional verification, failure/refusal and report-only usage are joined. The implementation provides real structural validation, cooperative append protection, response replay without live fallback, immutable-checkpoint comparisons and failure-sensitive verification paths. It does not thereby prove truthful observations, independent trials, current external state, complete capture, authenticated acceptance or adopted behavior.

Retain Q06d2b for stronger caller/environment/version binding, external witness and key authority, complete event capture, raw fixture privacy, async/custom tools, concurrent creation/export and crash recovery, privileged log replacement and any live downstream use. The remaining envelope/security/canonical test bodies and packaging/host integration are not silently closed. No new experiment, architecture or remedy is adopted.

Next selected research is U11-A / Q04h: recover the native orchestration review pilot with its actual caller and outer human decision/recovery path. Start from S23 workflows/README.md and S167 workflows/orch-review.workflow.js, then follow their real references. Its earlier selected review predicates are preserved, not rerun as a new discovery. The separate audit script encountered here is an omission/reuse lead, not automatic permission for an unbounded testing campaign. Broad Rust orchestration, host/provider, release/observability, native syntheses and final omission challenge remain. Publication must close before another family starts.
