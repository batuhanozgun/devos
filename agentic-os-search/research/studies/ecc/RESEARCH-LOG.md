# ECC — Research Round Log

Append-only chronological record of bounded work; current work authority remains STATE. Corrections may be appended with links; historical facts are not silently rewritten. This is a research/work rationale log, not a verbatim conversation or private reasoning transcript.

## U00 — 2026-09-17 — Method and plan establishment

**Authorized request:** kullanıcı önce yöntem ve değişebilir plan istedi; repo'nun araştırmayı beslemesi/yönetmesi, turlar ve oturumlarda güncel tutulması, yöntemin de araştırmayla birlikte değerlendirilen bir örnek olarak korunması istendi.

**Input state:** ECC ön taraması conversation'daydı, `research/studies/ecc/` input main `e3af9d9fc40391ebb31b2a8972fd5e1b7994d52f` üzerinde yoktu (exact-path Contents API 404). Diğer studies katalog/index'e kayıtlıydı; Superpowers'ın yeni kayıtları görüldü ve korunacak.

**Work performed:** gstack, Hermes ve Superpowers METHOD dosyaları tam okundu; güncel Foundation STATE, discussion handoff ve REUSE recover edildi. ECC main direct ref ile sabitlendi; cross-harness dokümanı pinned tam okundu; manifest 1–45 satır seçili okundu. Ön taramanın full/partial/truncated farkları kayda geçirildi. Ayrıntı SOURCE-LEDGER'da.

**Research output:** ECC hakkında yeni runtime/effectiveness sonucu değil; bounded araştırma amacı, sabit kaynak referansı, provisional soru aileleri, iki-döngülü yöntem, esnek faz planı, cold-start/authority, question/source kayıtları ve ilk yöntem değerlendirmesi. Ürün kurulmadı; upstream testleri çalıştırılmadı.

**Method delta:** Ön taramadaki yedi konu nihai subsystem şeması kabul edilmedi. Yalnız portability odağının native discovery'yi daraltmaması, doküman statüsünün current runtime'a yükseltilmemesi, plan/yöntem revizyonlarının sonuçlarıyla kaydedilmesi eklendi. MR00, alternatifleri ve henüz gözlenmemiş etkiyi taşır.

**Project context effect:** Foundation'da genel derinleştirme yerine yeterli-durma/seçici-reuse yönü recover edildi. Bu bilgi geç projeksiyonun çapasını güncelledi; Foundation veya hedef geliştirme işi değiştirilmedi.

**Operational boundary:** Container'dan yardımcı doğrudan GitHub erişimi DNS çözümlemesinde başarısız oldu. Canonical GitHub connector okumaları başarılıydı; onun üzerinden yayın yolu seçildi. Bu olay ECC arızası veya GitHub genel kesintisi olarak yorumlanmadı. Yerel ECC checkout/host capability hazır varsayılmaz.

**Publication:** içerik hazırlığı ve GitHub yayını ayrı eylemlerdir. Gerçek commit/scope/readback receipt PUBLICATION.md oluşturulduğunda orada bulunur. Bu log tamamlanmış runtime testi veya independent cold-start iddiası taşımaz.

**Return:** yöntem/plan kullanıcıya sunulur; bu tur U01 başlatılmaz. Next logical U01 kapsamı PLAN'da, yetkisi STATE'te.

## Later-round record template

`Unit / date / input main / method-plan versions`

- Authorized question, scope and return condition.
- Actual source/dependency coverage; source or local/live execution distinctions.
- Bounded finding and what changed in the system model; strongest rival/counterexample and unresolved limit.
- Impact on QUESTIONS, notes/syntheses and next work.
- Method check: adequate / change needed / insufficient evidence; linked MR entry when material.
- Published artifacts, commit/readback status, interruption or capability boundary.
- Exact next question/first source, authorization/stop boundary and reason for its priority.

Template alanları gereksiz tekrar için değil, yeni oturumun doğru işi devralması içindir. Salt açıklama turu maddi state değiştirmiyorsa yeni log dosyası veya commit kotası yoktur.

## U01-A — 2026-09-17 — Source surfaces and cache-verifier falsifier

**Authorization:** after U00 the user wrote 'harika. devam edebilirsin.' The source study continued; no installation, host/user state change, upstream reporting or architecture work was authorised. Same-conversation canonical STATE and entry identities were recovered; WHY, QUESTIONS, SOURCE-LEDGER and this log were additionally read in full. This is not an independent cold-start experiment.

**Source binding:** ECC remains pinned at `8321021c54d670126ce3b2969d5deb880b4b0c2a`. The project main used for initial publication staging was `5272ee899d575c1be99c4467295d5cc00f34a2e0`; any later rebase and actual publication belong in PUBLICATION. Other sessions' study/catalog changes must be preserved.

**Actual work:** root non-recursive Git tree recovered in full, four selected direct-child lists read, package manifest and selected entry/provider/hook/test files read. Exact S02–S25 scope is in [U01-A sources](evidence/U01-A-SOURCES.md). [STRUCTURE](inventory/STRUCTURE.md) and [TREE-FRONTIER](inventory/TREE-FRONTIER.tsv) preserve the shallow map and 43 root-directory identities. The recursive tree, installer dependency closure and complete README remain open.

**Substantive result:** [Note 01](notes/01-SURFACES-AND-CODEX-CACHE.md) distinguishes npm/Node, Rust and native Workflow pilot surfaces. It corrects the broad Codex instruction-backed screening description using the pinned provider manifest and SessionStart projection, while keeping actual host trust/consumption untested. The shared bootstrap was followed only through the runner; session-start body and other helpers remain outside this slice.

**Actual local execution:** [E01](evidence/u01-a-cache-probe/README.md) used unchanged checker and manifest bytes, verified against Git blob identities, synthetic caches and fake home. A pre-execution source-informed plan defined C0 presence baseline, C1 missing hook, C2 missing MCP. Actual exits were 0, 0, 1. C1 is a missing-reference false-green under the broad checker claim; C2 supplies sensitivity for a field actually checked. Dummy file contents do not represent a working plugin. The upstream native-hook test was inspected, NOT run. No Codex process, installer, network request or model call was part of E01.

**Research/method delta:** U01-A is a bounded result, not completion of all U01. PLAN 0.2 adds U01-B and QUESTIONS splits Q01a/Q01b; METHOD stays 0.1. [MR01](METHOD-REVIEW.md#mr01--2026-09-17--u01-a) records the actual correction, bounded falsifier, acquisition/recording overhead and unproven broader benefits. A potential systemic verifier-maintenance explanation remains a hypothesis; only the local omitted-field mechanism was established.

**Operational boundary:** direct container-side GitHub acquisition failed at DNS; connector reads worked. Offline Python/Node execution succeeded. No full checkout exists. Evidence files contain raw transient paths as historical output, not future locations. Tool-response truncation was not upgraded to full reading.

**Continuation:** U01-B starts with pinned install-modules.json, install-components.json and scripts/install-apply.js, then actual marketplace discovery through the .agents tree. Trace native plugin source/cache versus managed sync and preserve the other runtime/distribution families. U02 is selected only after that evidence. Existing E01 is not a new experiment to count again on re-entry. Actual commit/diff/readback details follow in [PUBLICATION](PUBLICATION.md).

## U01-B — 2026-09-17 — Installation channels and materialization

**Authorization/input:** user 'güzel. devam et lütfen.'; recovered current U01-A publication/authority, sources, map, questions and handoff. Same conversation, not an independent cold-start. Publication staging base `afe8710cd9f95264611de6c8be1bc93c3cef844c`; subsequent actual commit/readbacks go in PUBLICATION.

**Actual sources:** [S26–S44/W01–W02](evidence/U01-B-SOURCES.md). Read both install manifests and the source route through guided/ordinary entry, native Codex reconciliation, managed plan/adapter/resolver/apply, Kimi preflight and legacy shell sync. The legacy executor facade was selected-read only; imported ownership/merge/projection helpers are not full-read by implication. Current official host docs were selected contract checks outside the pin. No ECC test, code, host, installer or new local probe was executed. E01 was retained, not repeated.

**Bounded result:** [Note 02](notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md). A harness label does not identify its installation channel. Native registration/provenance, managed materialization/state and legacy sync have distinct boundaries. Named components do not always select leaf payloads. Transformation and filtering separate planned source from installed content. Multi-target preflight is followed by sequential apply and an explicit partial result, not a global rollback transaction. Registration, health projection, trust and separately required CLI capability must not be collapsed.

**Research change:** Q01b bounded-answered for the route comparison; Q01 overall remains PARTIAL. Q03a identifies the next ownership/recovery mechanism. The failed/partial child's internal effects still require its own evidence; the coordinator's completed list is not a complete mutation journal. No whole-system defect or safety verdict was produced.

**Method/plan:** METHOD 0.1 retained; PLAN 0.3. MR02 evaluates MR01's requested next-unit check: the source inquiry expanded beyond the Codex false-green into Kimi, selection, transformation and partial-state semantics. The original broader discovery is not declared complete; its remaining frontier is explicitly carried while U02-A follows a concrete discovered dependency.

**Operational limit:** recursive-tree response was acquired but too large to recover as a fully reviewed inventory; source metadata acquisition is not content reading. Direct container acquisition again failed at DNS; no checkout was established. [Discovery delta](inventory/U01-B-DISCOVERY.md) updates only named `.agents` entries and preserves old frontier material.

**Next:** U02-A begins at install/ownership-guard.js, install-state.js and install-state-store-sync.js, then actual callers/tests, with Kimi as a non-Codex consumer contrast. Deliver bounded ownership/partial-recovery evidence, not all installer variants or an installation. No background work or architecture transition is implied.

## U02-A — 2026-09-17 — Ownership, checkpoints and projection

**Authorization/input:** user 'anlaştık. devam et.'; current U01-B and its published boundaries recovered through canonical files. The source study continued without installation or architecture authority. The main snapshot immediately before publication was `ab15db506a841720d75cb81c3dec536e55350251`; other study work is preserved.

**Actual work:** [S45–S55](evidence/U02-A-SOURCES.md). Full reads of ownership/state/projection helpers, the bridge-state producer, actual Kimi adapter, store facade and two relevant test files; lifecycle source selected 1–480 only. A five-file state-store directory listing supplies bounded discovery progress. No new ECC helper, installer, test, host, database, model or local probe was executed; E01 was not rerun.

**Result:** [Note 03](notes/03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md). Common recorded ownership and guided Kimi's identity/live-digest admission differ. Identical bytes do not automatically transfer ownership. The non-Claude branch also produces bridge state, refining Note 02's outer-engine migration framing. Caught-failure handling retains previous unwritten digests, excludes new unowned collisions and can retain missing pending operations. Canonical JSON, projection and scoped current-file health are separate.

**Open boundary:** Q03b records a source-derived, unexecuted two-file interrupted-guided-retry counter-path; retry selection does not guarantee admission. Full repair/uninstall, merged-JSON ownership and abrupt/concurrent persistence remain Q03c. Do not count assertions as passing tests or this counter-path as a production incident.

**Method/plan:** METHOD 0.1 retained; PLAN 0.4. MR03 evaluates MR02: the actual producer corrected a scope assumption, Kimi provided a substantive consumer contrast and bounded discovery avoided a giant-response loop. Record overhead is real but not quantified; no comparative method-efficacy claim.

**Publication:** new source ledger and Note 03 were checkpointed directly on main before continuity updates, rather than held for one large final batch. Actual commits, changed paths and readbacks are in PUBLICATION. Direct GitHub connector worked; auxiliary container DNS and web retrieval supplied no new source evidence.

**Next:** U03-A / Q04, Work/session production→record→consumer/control. Begin sessions-cli.js, work-items.js and state-store/queries.js, follow actual dependencies and preserve Node/Rust separation. Installation residuals reopen when needed, not as an endless prerequisite. P1 remains partial; U03-A has not started.

## U03-A — 2026-09-17 — Work/session records and control boundaries

**Authorization/input:** user 'Harika, hakimsin plana. devam et lütfen araştırmaya.' after a qualitative progress check. Canonical main `2e6455b0967235ae59bc0d36182fbc8b7762c5e6` still carried U02-A. Current controls and same-conversation full entry/evidence reads were retained; WHY/INDEX/META/MR03 were recovered directly. No phase change, installation, architecture or closure was authorized.

**Actual sources:** [S56–S69/W03–W04](evidence/U03-A-SOURCES.md). Work/session CLIs, complete query/schema/migration code, claim/move helper, adapter registry/dmux/canonical persistence, status consumer and full session-adapter test source. Raw collector, actual worktree launcher, control-pane server and other ingestion/runtime consumers remain open. Search returned a different default-branch ref; every load-bearing body was fetched at the unchanged pin. A direct tests listing and completion of the five-file state-store body reads are bounded discovery progress, not full P1.

**Result:** [Note 04](notes/04-WORK-SESSION-RECORDS-AND-CONTROL.md). Local card mutation is not an exclusive execution lease. Imported author/source status can replace local assignment/progress. Limited open-list absence can be converted into local closure. Default canonical snapshot persistence recognizes a different writer interface from the state-store factory and falls back to JSON; sessions CLI reads SQLite. Stored activity, source freshness, snapshot health, attention summary and optional exit-code signalling are distinct.

**New local execution:** [E02](evidence/u03-a-work-item-probe/README.md) ran exact S59 bytes after Git-blob verification, with a new in-memory store double. All six source-informed criteria recorded before execution matched. Observations include blocked-card pickup, explicit reassignment, retained links on reopen, a bounded priority window, and a done-card refusal with zero writes. This is not SQLite, authentication, concurrent claiming, live agent or product-efficacy evidence. Synthetic prerequisite metadata is illustrative, not a claimed ECC schema. E01 was not rerun; S67 tests were inspected, not run; sync and database-ingestion counter-paths were not executed.

**Method/plan:** METHOD 0.1 retained; PLAN 0.5 and Q04a–d split. MR04 checks MR03: the study left installation and recovered distinct session contracts instead of copying ownership/projection assumptions. Card flexibility remains a plausible intentional policy, not an automatic defect. Runtime controls elsewhere are not declared absent. Record and publication overhead remains real, not a success metric.

**Publication:** the six new assets were first staged in commit `bdfe933425c6fd56cdb3aaf85774e0c39267df50`; non-force main update was rejected under concurrent work. Compare showed no ECC edits. PR #4 integrated the bounded assets into main; current metadata/log/discovery and receipt updates follow separately. Actual final commits/readbacks belong in PUBLICATION. No upstream report or user merge chore was created.

**Next:** U03-B/Q04d actual plan→worktree/worker/process→status/handoff→consumer/acceptance/recovery. Begin discovered orchestrate-worktrees.js, orchestration-session.js and orchestration-status.js. Preserve Q03b/c, Q04b/c, Node/Rust separation and P1; do not exhaust every board/sync edge case before inspecting real execution.

## U03-B — 2026-09-17 — Execution, handoff and recovery

**Authorization/input:** user 'Çok yararlı bir repo bu okuduklarımdan anladığım kadarıyla. Devam et lütfen.' Current U03-A publication/authority was recovered from main `a17889f14347c5ef16cb78f01fb064cdaf6fe98b`. The positive assessment is research continuation, not acceptance of each result or a new installation/design phase.

**Actual sources:** [S70–S76/W05–W07](evidence/U03-B-SOURCES.md). Full launcher, orchestrator, collector, status CLI, worker wrapper, documented skill composition and upstream orchestrator-test reads. Current primary Git/tmux/OpenAI option checks are separate temporal contracts. Mutable searches supplied paths only; all bodies were fetched at the pin. No full inventory or external dmux/Rust/control-pane audit was performed.

**Result:** [Note 05](notes/05-EXECUTION-HANDOFF-AND-RECOVERY.md). ECC has actual worktree/tmux provisioning and created-resource rollback beyond card mutations. Base ref plus local overlays describes worker inputs better than ref alone. Command submission, process completion, parsed handoff and accepted outcome are different. Source-only residuals include new output loss during setup rollback, replacement versus restoration, pre-existing artifact rewrites, locator normalization and pane/timestamp observation limits.

**New local execution:** [E03](evidence/u03-b-worker-probe/README.md). Unchanged S74 Bash wrapper and S72 Node collector, blob-verified, temporary Git repository and deterministic fake codex. Five source-informed pre-execution criteria matched: positive baseline; failed-verification report still marked completed on exit 0; readable numbered/prose output omitted from parsed fields; nonzero exit failed with generic handoff; missing task failed without provider call. Raw commands/prompts/artifacts/stdout/stderr and pre/post plan identity are preserved. Not a model, tmux, real Codex, rollback, sandbox, concurrency or task-quality test. S76 assertions were read, not run; E01/E02 were not rerun.

**Method/plan:** METHOD 0.1 retained; PLAN 0.6. MR05 evaluates MR04: actual execution code counterbalanced the record-only view, then exact producer/consumer testing exposed outcome and representation boundaries. Q04d bounded; Q04e preserves deeper control/retention/resume; Q05 memory lifecycle next to widen the native model rather than exhaust every launcher edge.

**Publication:** six new note/source/E03 files were prepared in `1bb294919101355c9f8ceba8b17e43c27b441f02`. Non-force main update rejected under concurrent Superpowers work; compare showed no ECC edits. PR #5 merged expected head at `cdf452425c796979492f14ae699a92ddba9eb0f1`. Evidence plan/runner/results blobs matched local files before merge. Continuity updates/readbacks are separate and their actual scope is recorded in PUBLICATION. No user upload/merge or upstream issue was created.

**Next:** U04-A/Q05 memory/handoff→scope/storage→review/retrieval→actual consumer. Confirm discovered memory skill/CLI/vault/format/schema/example paths at the pin. Preserve Q03b/c, Q04b/c/e and P1. No memory investigation, architecture or adoption is performed by selecting this next unit.
