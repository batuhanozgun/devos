# ECC — External client, artifact lifecycle and transcript-context uses

2026-09-23 · **C6 post-U12 transfer / U18-D–F extraction.** Bu dosya Itô CLI bridge, Nasiko pinned-artifact lifecycle ve NanoClaw transcript-replay kullanımlarını kendi ECC araştırma bağlamlarında taşır. EC kimlikleri ortak “external integration” veya “memory” tanımı değildir.

Source packages:
- U18-D Note43 + U18-D sources + MR44 + publication.
- U18-E Note44 + U18-E sources + MR45 + publication.
- U18-F Note45 + U18-F sources + MR46 + publication.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; no target execution/E11/credential/service/model/installation action.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-EC01–EC26 | [Note43](../../../research/studies/ecc/notes/43-ITO-CLI-BRIDGE-AUTHORITY-AND-EFFECT-BOUNDARIES.md) §§1–8 → [U18-D ledger](../../../research/studies/ecc/evidence/U18-D-SOURCES.md) → [MR44](../../../research/studies/ecc/ROUND-U18-D.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-D.md) | Fixed-pin source/test observation and conditional external-process boundaries; no credentials/client/service execution. |
| ECC-EC27–EC55 | [Note44](../../../research/studies/ecc/notes/44-NASIKO-ARTIFACT-IDENTITY-AND-LIFECYCLE-RECOVERY.md) §§1–8 → [U18-E ledger](../../../research/studies/ecc/evidence/U18-E-SOURCES.md) → [MR45](../../../research/studies/ecc/ROUND-U18-E.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-E.md) | Source/test inspection and conditional artifact-lifecycle failure/recovery paths; no install/download execution. |
| ECC-EC56–EC83 | [Note45](../../../research/studies/ecc/notes/45-NANOCLAW-CONTEXT-REPLAY-AND-SESSION-CONTINUITY.md) §§1–8 → [U18-F ledger](../../../research/studies/ecc/evidence/U18-F-SOURCES.md) → [MR46](../../../research/studies/ecc/ROUND-U18-F.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-F.md) | Source/test observation and transcript/context conditional deductions; no Claude/model invocation by Concepts. |

External client/service claims remain outside ECC-side source evidence unless the cited path actually consumes them.

## 1. Itô CLI bridge and caller authority

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-EC01 — public Itô bridge | `ecc ito` → scripts/ito.js → configured local client subprocess. | Embedded RFQ/economic engine veya service implementation değil. |
| ECC-EC02 — two child boundaries | ECC dispatcher child → bridge child → external client. | Local refusal means no bridge process started demek değil. |
| ECC-EC03 — executable override | `ECC_ITO_CLI_EXECUTABLE` explicit absolute path requirement. | Provenance/revision/signature authority değil. |
| ECC-EC04 — canonical suffix admission | realpath must end with `cli/ito-compute-cli/dist/bin/ito.js`. | Authentic package/source bytes proof değil. |
| ECC-EC05 — regular/readable executable file | final client path regular/readable check. | Immutable check-to-use binding or trust origin değil. |
| ECC-EC06 — same-Node invocation | `process.execPath` + JS entry + `shell:false`. | Filesystem/UID/network sandbox değil. |
| ECC-EC07 — layout-not-provenance fixture | Test creates harmless arbitrary JS probe under accepted suffix. | Genuine Itô package qualification değil. |
| ECC-EC08 — command-specific environment filter | OS + selected Itô/evals credential/config groups only. | Credential isolation from filesystem/Keychain/network değil. |
| ECC-EC09 — login/logout env class | endpoint/auth/file-token settings, API key excluded. | Caller authenticated or endpoint trusted proof değil. |
| ECC-EC10 — auth/find/status env class | runtime Itô group including API key. | Command authorized or remote effect safe proof değil. |
| ECC-EC11 — evals env class | explicit live opt-in + SixtyTwo token/SSH vars. | Node ownership/config authenticity or isolated execution değil. |
| ECC-EC12 — bridge control vars | ECC dispatcher retains dry-run/executable/NODE_ENV for bridge only. | Final client inherits those controls guarantee değil. |
| ECC-EC13 — buyer authority procedure | Skill asks actor for explicit buyer authority/economic constraints before find. | Bridge validates authority/constraints cryptographically değil. |
| ECC-EC14 — forwarding boundary | Non-evals args forwarded to client after local command admission. | External client accepts/understands them proof değil. |
| ECC-EC15 — evals local preconditions | live opt-in, one live flag, one cluster/nodes/config-dir option, config dir/file presence. | YAML semantics, node identity, token scope or external version verification değil. |
| ECC-EC16 — lower-level invocation API | exported `invokeIto` bypasses main parse/evals preconditions. | Custom caller inherits public main's full guards değil. |
| ECC-EC17 — same-pin accept mismatch | Skill prescribes `ecc ito accept`; bridge allowlist excludes `accept`. | External service/MCP cannot accept anything proof değil. |
| ECC-EC18 — CLI/MCP route split | MCP template launches another absolute `ito-mcp.js` directly. | CLI path/layout/env guards automatically apply to MCP host launch değil. |
| ECC-EC19 — text-alignment oracle gap | Tests assert selected documented strings/verbs, not complete doc↔allowlist equality. | Matching textual test means actual command admitted değil. |
| ECC-EC20 — stdout/stderr/status pass-through | Child normal output and numeric exit propagated. | Authenticated remote effect receipt veya accepted result değil. |
| ECC-EC21 — login inherited stdio | Interactive login path streams child I/O. | Successful authorization/session establishment proof değil. |
| ECC-EC22 — buffered command output | Other commands use bounded sync output buffer. | Complete evidence under overflow/failure guarantee değil. |
| ECC-EC23 — evals timeout option | 31-minute spawnSync timeout configuration. | Hard end-to-end deadline or effect-free timeout değil. |
| ECC-EC24 — post-start process error ambiguity | `result.error` can occur after process start/timeout though wrapper wording says couldn't start. | No external effect occurred proof değil. |
| ECC-EC25 — status-before-retry guidance | Skill asks reconciliation/status after ambiguous failures. | Durable idempotency/request receipt implemented by bridge değil. |
| ECC-EC26 — external responsibility boundary | Auth/account/RFQ/economics/MCP/service semantics belong to external client/caller. | ECC-side interface source answer certifies those external claims değil. |

## 2. Nasiko pinned acquisition and managed binary lifecycle

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-EC27 — Nasiko lifecycle | version/platform/destination/consent → acquire/verify/publish/receipt/status/remove. | Running Nasiko control plane or agent governance değil. |
| ECC-EC28 — embedded release table | Fixed v0.1.0 per-platform manifest/binary digests. | Digest provenance/review/signature/reproducible-build proof değil. |
| ECC-EC29 — public version requirement | CLI mutation requires explicit version. | Direct helper has same requirement değil; helper defaults separately. |
| ECC-EC30 — fixed-origin fetch | Production path fixed HTTPS origin, redirects refused, response bounds. | Registry availability/authorship or whole-operation deadline proof değil. |
| ECC-EC31 — manifest digest | Downloaded manifest checked against release-table digest before parse. | Manifest signer/source build verified değil. |
| ECC-EC32 — manifest shape | schemaVersion2, one gzip layer, digest+size constraints. | General archive safety or upstream release policy proof değil. |
| ECC-EC33 — archive size/digest | Exact declared size and layer digest. | Extracted program useful/compatible proof değil. |
| ECC-EC34 — bounded extraction | In-memory gzip/tar parsing with expected binary name and limited metadata entries. | Universal tar implementation/malicious archive proof değil. |
| ECC-EC35 — independent binary digest | Extracted bytes checked against release-table binary digest. | Release-table provenance/signature proof değil. |
| ECC-EC36 — explicit mutation consent | `yes` required for actual helper mutation; skill adds human review. | Authenticated immutable approval token değil. |
| ECC-EC37 — local dry-run | Nasiko local `--dry-run` returns before consent/lock/network. | Global ECC preview automatically reaches it değil. |
| ECC-EC38 — global dry-run propagation gap | Root `--dry-run` becomes ECC_DRY_RUN; Nasiko ENTRY/LIFE ignore it. | Documented local preview broken veya every root dry-run mutates değil. |
| ECC-EC39 — status executable override | Status can inspect explicit executable path. | Mutation installDir is bound to same path değil. |
| ECC-EC40 — non-executing qualification | Status reads binary/receipt bytes without launching artifact. | Executable permission/startup/capability proof değil. |
| ECC-EC41 — receipt-relative qualification | Release selected from receipt version/platform/arch and live bytes. | Current requested platform identity automatically matches receipt değil. |
| ECC-EC42 — same-version reuse | Install reuse checks qualified + same requested version. | Existing platform/arch/digest equals newly requested release guarantee değil. |
| ECC-EC43 — requested/installed platform mismatch | Genuine same-version foreign-platform pair can satisfy reuse while plan describes requested platform. | Executed incompatibility incident değil. |
| ECC-EC44 — lifecycle lock | Exclusive file, PID/time/token, descriptor identity, dead-owner recovery. | Arbitrary external writer exclusion or crash transaction değil. |
| ECC-EC45 — binary exclusive publication | final executable opened with `wx`, then fsync/size checks. | Binary+receipt atomic transaction değil. |
| ECC-EC46 — separate receipt publication | Receipt independently exclusive-created after binary. | Both objects commit together guarantee değil. |
| ECC-EC47 — orphan receipt state | Receipt created then write failure before ownership flag can leave receipt while binary cleanup occurs. | Observed disk failure değil; conditional source path. |
| ECC-EC48 — retry orphan obstruction | Missing binary makes inspect absent; later exclusive receipt creation can hit orphan. | Durable recovery exists or impossible recovery proof değil. |
| ECC-EC49 — staged uninstall | Binary/receipt renamed to unique removal paths before cleanup. | Final removal all-or-nothing transaction değil. |
| ECC-EC50 — staging rollback | Rename-stage failure attempts restore of already staged files. | Every cleanup failure rolled back değil. |
| ECC-EC51 — cleanupPending | Staged deletion failures retained and reported in immediate error. | Persistent lifecycle work queue or structured later retry state değil. |
| ECC-EC52 — tombstone continuity gap | Later status/uninstall/reinstall do not discover prior retained remove-paths. | First error hidden değil; recovery continuation missing. |
| ECC-EC53 — status exit vs qualification | Status can exit normally for absent/unqualified and return payload. | Exit0 = qualified installation değil. |
| ECC-EC54 — socket timeout | Request timeout is inactivity/socket bound. | Complete acquisition always <15s guarantee değil. |
| ECC-EC55 — lifecycle-only skill boundary | Skill expressly separates install/status/remove from running service/governance/telemetry. | Nasiko external product useless/absent değil. |

## 3. NanoClaw transcript replay and context continuity

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-EC56 — NanoClaw REPL | Human-driven terminal loop around repeated `claude -p` subprocesses. | Scheduler, autonomous multi-agent controller or external same-name product değil. |
| ECC-EC57 — entry-surface split | npm script/skill/legacy shim exist; no `ecc claw` public command. | Package membership = dispatcher subcommand değil. |
| ECC-EC58 — named transcript | `~/.claude/claw/<session>.md` conversation persistence. | Project-scoped identity or native Claude session state değil. |
| ECC-EC59 — model selection | Environment/REPL in-memory model value. | Persisted transcript contains/restores selected model değil. |
| ECC-EC60 — skill selection | cwd-based skill file text loaded into memory. | Persisted transcript records/restores skill source/version değil. |
| ECC-EC61 — history-before-current-input | Prior history read before current User append for prompt construction. | Atomic turn/attempt record guarantee değil. |
| ECC-EC62 — plain-text prompt composition | SYSTEM CONTEXT / HISTORY / USER labels concatenated into stdin text. | Native system-prompt/role/resume semantics değil. |
| ECC-EC63 — inherited Claude host | command name `claude`, inherited environment, no pinned binary/tool policy/spend limit. | Host unprotected or misconfigured proof değil. |
| ECC-EC64 — Windows shell path | Windows uses shell execution while model arg is unvalidated. | Exploit occurred or non-Windows path same risk değil. |
| ECC-EC65 — subprocess text result | Helper returns string response/error projection. | Structured success/failure/signal/effect receipt değil. |
| ECC-EC66 — nonzero-empty-stderr projection | Nonzero status can return stdout/empty without explicit failure qualifier. | Real Claude produces this condition proof değil. |
| ECC-EC67 — transcript error-as-assistant | Returned error text also stored as Assistant turn. | Model authored that content or task succeeded değil. |
| ECC-EC68 — split User/Assistant persistence | User written before process, Assistant after process. | Atomic turn/side-effect transaction or resumable attempt state değil. |
| ECC-EC69 — raw history | Ordinary replay/history/search/Markdown export use original file text. | Parsed representation matches raw losslessly değil. |
| ECC-EC70 — parsed history | Metrics/JSON/text export/compaction use delimiter parser. | Full Markdown content round-trips automatically değil. |
| ECC-EC71 — embedded-separator truncation | Internal `---` line can terminate parsed turn and drop later content from parsed consumers. | Raw transcript loses same bytes or common occurrence measured değil. |
| ECC-EC72 — parser prefix cap | Only first 5,000,000 JS string units scanned by parseTurns. | Full-file read/prompt input budget or newest-history guarantee değil. |
| ECC-EC73 — compaction suffix-of-prefix | Compact keeps last N records from parsed prefix then rewrites full file. | Last N true newest records beyond cap preserved guarantee değil. |
| ECC-EC74 — record-count compaction | Default20 means message records, not conversations/exchanges/semantic summary. | Resolved-goal or sufficient-context guarantee değil. |
| ECC-EC75 — metrics token estimate | raw history length/4 approximation. | Skill/current input/host context or billed tokens budget enforcement değil. |
| ECC-EC76 — transcript branch | Copies current transcript to another session file. | Git/worktree/project/permission/native host-state branch değil. |
| ECC-EC77 — branch overwrite risk | Existing destination name can be overwritten without exclusive-create confirmation. | Every branch fails or project work lost proof değil. |
| ECC-EC78 — raw-vs-parsed export | Markdown export copies raw; JSON/text depends on parser. | Equivalent fidelity across formats değil. |
| ECC-EC79 — export/session namespace overlap | Default exported .md files can appear in broad session listing despite invalid startup dotted name. | Startup can necessarily open them or all exports unsafe değil. |
| ECC-EC80 — live-provider test oracle weakness | Test calls actual `askClaude`; response or error both satisfy nonempty-string expectation. | Safe fake-provider test or meaningful Claude success assertion değil. |
| ECC-EC81 — forgiving history read | Any caught history-read error becomes empty history. | File absent, permission/read failure and intentional empty are distinguished downstream değil. |
| ECC-EC82 — forgiving skill read | Missing/unreadable selected skill silently omitted. | Requested name equals included bytes/context guarantee değil. |
| ECC-EC83 — context restart gap | Same transcript restart need not restore model/skills/cwd/policy. | Conversation persistence useless değil; operating context is separate. |

## 4. U18-D/E/F non-collapse

- explicit executable path ≠ provenance;
- environment minimization ≠ sandbox/isolation;
- buyer instruction ≠ authenticated authority;
- local precondition ≠ external qualification;
- CLI route ≠ MCP route;
- numeric process status ≠ remote effect receipt;
- pinned digest ≠ provenance/signature;
- local dry-run ≠ root-global preview propagation;
- qualified installed bytes ≠ requested target identity;
- binary publication ≠ binary+receipt transaction;
- cleanup error ≠ persistent recovery queue;
- transcript ≠ execution context;
- plain-text SYSTEM label ≠ native system role;
- saved response string ≠ structured attempt result;
- raw conversation ≠ parsed conversation;
- compaction ≠ faithful newest-context retention;
- transcript branch ≠ project isolation;
- local helper test ≠ provider/service validation.

U18-D/E/F provide bounded source answers only. Stronger installed/runtime/provenance/authority/recovery/effectiveness residuals remain source-study obligations, not automatic Concepts experiments.
