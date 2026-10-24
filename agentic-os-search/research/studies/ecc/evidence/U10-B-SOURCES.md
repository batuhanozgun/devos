# U10-B — Offline capsule/replay/receipt source ledger

**2026-09-19 · Q06d2.** Unchanged target: [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Result: [Note18](../notes/18-OFFLINE-CAPSULES-REPLAY-AND-RECEIPT-SCOPE.md). Method: [MR19](../ROUND-U10-B.md). STATE owns current work/publication. No target code, suite, candidate, provider/model, live server or new experiment/E08 was executed by this research.

## Source accounting

All ECC bodies below were fetched through connected GitHub at the pin. FULL means the named body through EOF, not all dependencies, runtime verification or every test. Multiple paths sharing a blob are not independent evidence. Source IDs continue S220; the three procedural documents use local U10B-P identifiers without renumbering any potentially earlier whole-study entry.

| ID | Pinned path | Git blob | Reading |
|---|---|---|---|
| S221 | scripts/lib/eval-harness/canonical.js | bfba94b6d134c296aa84efee0245d7e0ae6fe433 | FULL: canonical JSON and hashes |
| S222 | scripts/lib/eval-harness/envelope.js | 7d24d5353ffc3dff695d6974c7353c4d2370eb8a | FULL: lineages, effect labels, scalar payload, canaries, envelope/hash validation |
| S223 | scripts/lib/eval-harness/capsule.js | 7e0079aa064ff7a0b66c779316cf6ffd76514df0 | FULL 1–240/241–530 through EOF: create/open, cooperative append, readers, projection/export |
| S224 | scripts/lib/eval-harness/replay.js | 509c5ae97570eb896a6612ba091eabb2dcc16b21 | FULL: mutable fixture store, record/replay, effect admission and onCall |
| S225 | scripts/lib/eval-harness/receipt.js | 9ea5659dc6d685ba46c84d5eb4c1a9c97f34beba | FULL: producer, optional witnesses, exact-checkpoint/read-only verifier |
| S226 | scripts/lib/eval-harness/retrospective.js | b4ae2158ddb269ed20e8672aee14c67ed960c03d | FULL: explicit-input grouping, duplicate/conflict and report-only output |
| S227 | scripts/lib/eval-harness/effect-fence.js and gate-child.js | 236ada9ab6802351126572e294d8d99887c0cc39 | FULL shared 214-byte blob, both path identities from S158; unconditional gate refusal |
| S228 | docs/architecture/eval-harness-frameworks.md | d00e4b4e02b1e2de0720072dd4cc080e450f7f40 | FULL 1–230/231–500 through EOF; stated scope and known limits, not execution evidence |
| S229 | examples/eval-harness/run-example.js | 8dacd3db328d8a154d019eecff8bb6a3f6385ffd | FULL actual integration example; NOT RUN |
| S230 | tests/lib/eval-harness/replay.test.js | 9095ae79a119b6239b563434ce2cae5c326d1417 | FULL TEST SOURCE, NOT RUN |
| S231 | tests/lib/eval-harness/receipt.test.js | 7ca344100a04db64f4696d8b18ddb33083044854 | FULL 1–230/231–480 through EOF, NOT RUN |
| S232 | tests/lib/eval-harness/capsule.test.js | 4640d525ca6f09d78c31c312dc8c955fa26afbf3 | FULL 1–230/231–460/461–750 through EOF, NOT RUN |
| S233 | tests/lib/eval-harness/retrospective.test.js | aec4d8f10c08a9b5a46653a218d6620573a717a1 | FULL TEST SOURCE, NOT RUN |
| S234 | tests/lib/eval-harness/gate.test.js | 7fa9344e94caf5098f76a277954cdc1af97925d6 | FULL TEST SOURCE, NOT RUN |
| S235 | tests/lib/eval-harness/cli.test.js | e552da166e2c6bc3dc2ebe49eda6d9a4c5f438dc | FULL TEST SOURCE, NOT RUN |
| S236 | tests/lib/eval-harness/helpers.js | fc201ed74255ade5c7b6d04be5fd5412c098eb1b | FULL test bookkeeping/temp-file/child helpers; NOT RUN |
| U10B-P1 | skills/eval-harness/SKILL.md | 6076dd18548503bf00ab28c06e05086d8bc90ea9 | FULL target procedure; local-framework boundary versus broader EDD instructions |
| U10B-P2 | commands/harness-audit.md | fc36601aa175aa1eb00c210d5b85dc6b9132232c | FULL target procedure; points to a separate deterministic audit script |
| U10B-P3 | agents/harness-optimizer.md | 7bc8b2c5ddfc5fc3a2dd55d1d712ee14e8ba75d4 | FULL target procedure; audit/tests/configuration workflow, not an executable receipt consumer |

Re-entry: S164 scripts/eval-harness.js `ccf17b19b34245b8f18be71b1e26fd5f352ffdd8` FULL; S165 index.js `2ffccfbb1af5a652f2d5dbda9c933de77c2f855c` FULL; S166 gate.js `6ec49938782929b54d3fb070d3e79a1e9817868e` FULL 1–180/181–380 through EOF. S158 tree `a862a655eb92a8da013a825d760a7ddfe9e60b23` was fully recovered with ten entries and truncated:false. Combined source reads cover all ten immediate implementation files, not the entire evaluation ecosystem.

The tests-directory contents response was display-truncated and is not claimed as a complete recursive test inventory. canonical.test.js, envelope.test.js and security.test.js were discovered but their bodies were not read in this unit; the example's variant/taskset/config bodies were not closed. The tests inspected above refer to them without conferring body or execution coverage. The U07-A family map was fully reread for next-family selection, not new target behavior evidence.

## Load-bearing producer/consumer chains

- **Journal:** S229 or library caller → S223 append → S222 scalar/redaction/hash validation → S221 canonicalization → lock/reload/write/fsync/release → S223 readCapsule/project. One chain carries five labels; no universal automatic event capture or truth validation is present in this chain. S232 distinguishes malformed/partial data, real child contention and simulated I/O failures in test source.
- **History witness:** S223 standalone verify checks the currently supplied chain, not an externally expected count/tip. S225 adds an earlier receipt's count/root/digest and distinguishes complete-tail loss from a valid later extension. This is a source-derived valid-prefix counterexample; no event deletion was performed by this research.
- **Replay:** S229 explicit tools/onCall → S224 caller-chosen record or replay → fixture keyed by tool/args → returned response and optional event callback. Replay does not invoke the implementation in its admitted branch; record does. S230 spies on calls and deliberately corrupts fixtures in test source. Implementation/environment/time binding and response privacy are not added by the capsule envelope because fixtures are separate.
- **Receipt:** S164 or S229 → S225 build → S223 verified projection write; export copies three files; verifier independently derives expected projection without healing the supplied file. Signer/verifier, artifact and external gate witnesses are options, not all required by a generic ok result. The CLI supplies artifact/gate options, not a signature verifier. S231 has both real Ed25519 checks and separate synthetic-signature compatibility vectors; neither is a task-correctness oracle.
- **Execution refusal:** S164 runGate → S166 requireSupportedIsolation; S166 runGate/runVariant and S227 direct entrypoints also refuse before candidate/config work. The trusted record-mode implementation in S224 is a different active route. S234/S235 test-source refusal and no-write predicates do not establish an implemented OS sandbox.
- **Aggregation:** S164 capsule group → S226 → S223 project → verified selected identities/counts/digests. S233 rejects mixed families/conflicting snapshots and ignores score/verdict payloads. It is report preparation, not measured improvement or candidate admission.
- **Actual downstream meaning:** S229 constructs a valid capsule/receipt while the candidate gate is explicitly unavailable; its success is utility correctness, not candidate promotion. U10B-P1 distinguishes local utilities from broader interpreted EDD. U10B-P2/P3 reference audit/tests and human-sensitive review, not an automatic S225 receipt-to-deployment path. That separate audit engine and native-host compliance were not closed here. No repository-wide absence of custom consumers is inferred from search results.

## External contracts and source freshness

Selected primary checks observed 2026-09-19, separate from the ECC pin:

- **W-U10B-FS:** [Node filesystem flags](https://nodejs.org/api/fs.html#file-system-flags), wx/exclusive-creation and network-filesystem qualification. The page displayed v26.9.0. This bounds the cooperative-lock claim; it is not a check of the filesystem or Node version used by an installed ECC.
- **W-U10B-PERM:** [Node permissions](https://nodejs.org/api/permissions.html), trusted-code versus malicious-code boundary. The page displayed v26.7.0. This supports the distinction between runtime restrictions and hostile-code containment, not a new security incident or proof about every OS backend.

Default-branch searches for verifyReceipt and gate.isolation_required returned ref `9e06a2792bb3a5c1bc3ca272b853bac7998485d8`; used only to discover paths, then pinned bodies were read. A project search for an earlier harness-optimizer source identity returned no hit; that is not absence evidence, hence the local procedural source labels. No repin/current-ECC-main audit occurred. An auxiliary raw-file attempt failed DNS and produced no verified target checkout; connected reads worked.

## Evidence limits and disposition

Six named test files plus their helper were read, not executed. S232's child contention, fsync/short-write/lock-failure cases are inspected test designs; simulated Windows behavior is not a native Windows observation. S235 directly invokes a trusted example solve function in one unit test, which does not enable the disabled gate. Source templates, examples, constants, test counters and hashed assertions are not measured ECC efficacy.

No E04/E07 repetition, E06 rehabilitation, new fixture/E08, install, provider/model, user-home mutation, live server or upstream fix. Claims about partial failure, missing witnesses or stale environmental fixtures are source-derived conditions, not observed production incident rates. Quiescent local filesystem, trusted caller, optional authentication and explicit checkpoint identity remain material limits.

The original U10-B source return criterion has a coherent answer across journal, replay, receipt, refusal and actual caller/report paths. Full hostile-filesystem/privileged replacement, crash/concurrent export, external witness/key authority, provider freshness, async/custom tools, live capture/adoption and independent outcome validity remain separate residuals. Publication completion is recorded only after actual readbacks in STATE/receipt.
