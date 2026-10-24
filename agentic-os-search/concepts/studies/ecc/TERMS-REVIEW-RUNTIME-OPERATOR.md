# ECC — Material family, review, runtime and operator terms

2026-09-20, **B6-T16-C4 / DURABLE-COMPLETE / C4-COMPLETE**. [TERMS.md](TERMS.md)'nin linked parçasıdır. Bu dosya U07–U09 source package kullanımını taşır.

Bu envanterde R öneki yalnız adresleme kolaylığı içindir; review/runtime/operator için ortak kavram sınıfı ilan etmez. Satırlar ECC source-study'nin pinned source açıklamaları, source-derived conditional counter-path'leri ve kayıtlı bounded evidence'i üzerinden çıkarılmıştır. Source-study'nin kendi terimi, araştırma yazarının açıklaması ve concepts extractor yorumu aynı epistemik rol değildir. Aşağıdaki sınırlar özellikle bu ayrımı korur.

## 1. U07-A — material-family accounting and breadth

Dayanak: inventory/U07-A-FAMILY-MAP.md, evidence/U07-A-SOURCES.md, ROUND-U07-A.md, PUBLICATION-U07-A.md.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R01 — material family | ECC korpusunda benzer sorumluluk/mekanizma alanlarını takip etmek için kullanılan overlapping research family. | Sabit ürün mimarisi veya mutually-exclusive subsystem değil. |
| ECC-R02 — responsibility map | Material family'leri source standing, açık iş ve disposition ile ilişkilendiren breadth görünümü. | Runtime topology veya component diagram değil. |
| ECC-R03 — breadth checkpoint | Root/family düzeyinde kapsamı yeniden kurup sonraki derin soruyu seçen bounded research checkpoint. | Recursive/full semantic inventory veya CORE closure değil. |
| ECC-R04 — disposition | Bir source family'nin preserve/deepen/defer/open gibi araştırma standing'i. | Ürünün enabled/disabled runtime state'i değil. |
| ECC-R05 — reverse frontier | Daha önce görülmüş ama derinleştirilmemiş source branch'leri yeniden görünür kılan coverage frontier. | O branch'in artık araştırılmış olduğu anlamına gelmez. |
| ECC-R06 — final reverse-inventory challenge | Closure öncesi unread descendant/mirror/broad-source omissions'ı yeniden arama yükümlülüğü. | U07-A'da tamamlanmış final audit değil. |
| ECC-R07 — Plan Canvas family | Artifact review, feedback queue, wait/end/reopen ve continuation mekanizmaları taşıyan local review family. | Governance-event logger ile aynı producer değil. |
| ECC-R08 — ECC2 operator surface | Rust ECC2 lifecycle/store/daemon/TUI/worktree gibi runtime-control family. | Node control-pane veya önceki tmux worker ile otomatik aynı controller değil. |
| ECC-R09 — paired-seed evaluation registry | ECC2 README'de candidate config, paired seed, thresholds, active registry ve rollback diliyle anlatılan ayrı evaluation family. | U05-B Node skill evaluator verdict'inin devamı değil; body/callers ayrıca okunmalıydı. |
| ECC-R10 — offline capsule | Node evaluation-harness family'de replay/receipt/gate çevresindeki bounded execution package abstraction. | Çalışan isolation backend veya completed evaluation run değil. |
| ECC-R11 — static gate | Candidate/config/result shape'lerini source-level inspect eden gate path'i. | Runtime isolation veya live variant execution değil. |
| ECC-R12 — unsupported isolation boundary | Public eval-harness execution path'inin verified isolation backend yokluğu nedeniyle explicit refusal standing'i. | Unsafe execution'ın gerçekleştiği anlamına gelmez. |
| ECC-R13 — native review dimension | orch-review workflow'unda ayrı review lens/axis. | Bağımsız uzman veya doğru değerlendirme garantisi değil. |
| ECC-R14 — finding | Native review caller'ın dimension sonuçlarından topladığı issue record. | Doğrulanmış defect veya impact proof değil. |
| ECC-R15 — verifier | High/critical finding için refutation/verification sonucu üreten follow-up reviewer path. | Epistemik bağımsızlık veya insan doğrulaması garanti değil. |
| ECC-R16 — blocker | Failed dimension, verifier error/null veya yeterince güvenli refutation bulunmayan finding'in final review'u kapatan standing'i. | Gerçek deployment block uygulanmış demek değil. |
| ECC-R17 — failedDimensions | Review dimension'ın error/null sonucu nedeniyle incomplete/failed sayıldığı collection. | Dimension'ın hedefte mutlaka problem bulduğu anlamına gelmez. |
| ECC-R18 — CHANGES_REQUESTED | Native review source predicate'inde blockers veya failed dimensions varsa produced final verdict. | Outer human decision veya code change enforcement değil. |
| ECC-R19 — generated runtime | OpenCode build source'undan compiler ile üretilen dist/runtime artifact. | Source file ile byte/behavior equivalent olduğu otomatik değil. |
| ECC-R20 — initial export manifest | agent.yaml içinde gitagent export'un initial asset manifest'i. | Complete native catalog veya runtime authority map değil. |
| ECC-R21 — caller-owned trust check | AURA integration README'sinde caller tarafından explicit invoked trust/reputation check. | Global ECC hook, payment/delegation enforcement veya adopted integration değil. |
| ECC-R22 — source candidate / release distinction | Roadmap/release surfaces'te source candidate standing ile release/artifact qualification'ın ayrılması. | Published artifact veya approved release kanıtı değil. |

## 2. U08-A — Plan Canvas review and continuation

Dayanak: notes/12-PLAN-CANVAS-FEEDBACK-AND-CONTINUATION.md, evidence/U08-A-SOURCES.md, ROUND-U08-A.md, PUBLICATION-U08-A.md. Historical E06 outcomes bu terminoloji için behavior evidence değildir.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R23 — Plan Canvas | Local artifact review channel: CLI, server, browser UI, session store ve procedure/continuation instructions bileşimi. | Authenticated approval transaction veya universal review subsystem değil. |
| ECC-R24 — review artifact | Canvas session'ın açtığı local file/path target. | Immutable reviewed revision değil. |
| ECC-R25 — canonical path | Session identity türetiminde realpath-normalized file location. | File-content identity veya revision digest değil. |
| ECC-R26 — session key | canonicalPath hash'inden türetilen stable review-session locator. | Reviewer, task veya artifact revision identity değil. |
| ECC-R27 — path-bound session identity | Same canonical path değişen content boyunca aynı session key'i koruyabilen identity rule. | Exact final revision approval proof değil. |
| ECC-R28 — feedback item | Chat, annotation, approve veya request-changes kind'larından normalized queued record. | Accepted engineering decision veya verified human instruction değil. |
| ECC-R29 — annotation anchor | Feedback'in text-range/selector/snippet gibi artifact-local locator metadata'sı. | Whole-document revision binding değil. |
| ECC-R30 — feedback acceptance | Server'ın feedback input shape'ini kabul edip queue'ya yazması. | Engineering proposal'ın accepted olması değil. |
| ECC-R31 — pending feedback | Session store'da consumer tarafından henüz drain edilmemiş feedback batch. | Human attention veya model uptake proof değil. |
| ECC-R32 — chat mirror | Structured feedback'in textual projection olarak retained conversation/history yüzeyi. | Original structured object veya replayable delivery envelope değil. |
| ECC-R33 — await | Consumer'ın session feedback için long-poll/read operation'ı. | Feedback'in sonradan işlendiğini veya uygulandığını göstermez. |
| ECC-R34 — takeFeedback / drain | Pending batch'i alıp queue'yu clear/persist eden store transition. | Client receipt, model uptake veya acknowledgment değil. |
| ECC-R35 — consumer acknowledgment gap | Queue clear ile CLI/host/model receipt arasında transaction/ack linkage bulunmaması. | Gerçek message loss olayı gözlendi demek değil. |
| ECC-R36 — final batch | Session ended olsa da direct await ile pending feedback + sessionEnded metadata'nın birlikte dönebilmesi. | Ended discovery surfaces'in bu batch'i göstereceği anlamına gelmez. |
| ECC-R37 — sessionEnded | Review interaction'ın ended standing'ini response'a taşıyan field/state. | Bütün feedback resolved veya accepted değil. |
| ECC-R38 — endedBy | Session end'in user/agent gibi recorded initiator standing'i. | Cryptographically authenticated person identity değil. |
| ECC-R39 — explicit reopen | User-ended session'ı yeniden açmak için gereken explicit transition. | Önceki approval/revision'in yeniden doğrulandığı anlamına gelmez. |
| ECC-R40 — pending summary | CLI/Stop tarafında non-ended sessions içinden pending feedback gösteren discovery view. | Repository'de herhangi bir yerde feedback kalmadığı oracle'ı değil. |
| ECC-R41 — open-session projection | SessionStart'ta non-ended sessions'ın bounded listesi. | Task ownership veya complete session inventory değil. |
| ECC-R42 — ended-but-pending | Session ended olsa da queue'da consumer tarafından alınmamış feedback bulunabilen state combination. | Feedback silindi demek değil; discovery ve direct-await davranışları ayrıdır. |
| ECC-R43 — Stop backstop | Agent stop anında pending Canvas feedback'i kontrol edip continuation reason üretebilen hook. | Sürekli supervisor veya every interruption coverage değil. |
| ECC-R44 — decision:block | Stop hook'un host contract'ında devam talep eden structured decision. | Tool/process nonzero exit veya verified host uptake ile aynı değil. |
| ECC-R45 — stop_hook_active | Repeated Stop continuation loop'unu sınırlayan host-provided activity guard. | Every interruption/retry state için durable lease değil. |
| ECC-R46 — Stop projection | Drained feedback'in bounded reason text'ine çevrilmesi. | Full original batch representation değil. |
| ECC-R47 — twenty-item projection cap | buildReason'ın artifact başına ilk 20 nonempty description'ı görünür kılması. | 21+ item drain edilmedi demek değil; omitted item queue'dan çıkmış olabilir. |
| ECC-R48 — server metadata | server.json içindeki port/process discovery bilgisi. | Server live/healthy/current guarantee değil. |
| ECC-R49 — metadata-selected transport | Truthy port varsa HTTP drain, yoksa direct-file path seçimi. | Failed HTTP sonrası otomatik file fallback guarantee değil. |
| ECC-R50 — stale-port path | Eski server metadata'sının HTTP yolunu seçtirip hook'un feedback'i drain etmeden no-block dönebildiği conditional path. | Reproduced incident değil. |
| ECC-R51 — presence | waiting/queued/listener/recent pickup/typing/thinking/ended gibi session-level activity projection. | Message-specific acknowledgment veya cognition proof değil. |
| ECC-R52 — markThinking | Batch pickup/explicit request sonrası session presence'i temporarily thinking yapan marker. | Model gerçekten reasoning yaptı veya yeni message'ı gördü demek değil. |
| ECC-R53 — delivered display | UI'ın session-level presence üzerinden message delivered benzeri gösterim yapabildiği state. | Per-message receipt/processing guarantee değil. |
| ECC-R54 — loopback guard | Host/Origin hostname predicates ile local HTTP surface'i sınırlayan check. | Reviewer authentication, authorization veya immutable loopback-only policy değil. |
| ECC-R55 — browser-side queue | UI tarafında send başarısına kadar sessionStorage ile retained feedback attempt. | Server/store acknowledgment veya durable exactly-once delivery değil. |
| ECC-R56 — store reload | sessions.json'dan pending/session state'in yeniden yüklenmesi. | Arbitrary corruption/power-loss recovery guarantee değil. |
| ECC-R57 — drain-once semantics | Test source'da drained feedback'in sonraki take'te tekrar dönmemesi contract'ı. | Test run edilmiş veya network receipt guaranteed demek değil. |
| ECC-R58 — cooperative local review | Kaynağın desteklediği bounded interpretation: local user/agent feedback channel + procedural continuation. | Authenticated, revision-bound, transactional approval system diye yükseltilmez. |

## 3. U09-A/A2 — Rust session lifecycle, store and operator view

Dayanak: notes/13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md, notes/14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md, U09-A/U09-A2 source ledgers, MR14/MR15, publication receipts ve E07 bounded evidence.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R59 — ECC2 session | Durable Rust-side record carrying id/state/task/pid/workdir/profile/output references and lifecycle metadata. | Tekil live process veya execution attempt ile aynı nesne değil. |
| ECC-R60 — Pending session | Created/admitted but harness-running confirmation henüz olmayan session state. | Runner/harness readiness değil. |
| ECC-R61 — queued worktree session | Worktree capacity yokken row/request kaydedilip session id dönen fakat runner henüz başlamayan standing. | Started worker değil. |
| ECC-R62 — session-started message | CLI'nın queue/spawn admission sonrası gösterdiği user-facing wording. | Universal Running/readiness acknowledgment değil. |
| ECC-R63 — ECC runner wrapper | Session id/task/agent/workdir ile hidden run-session path'ini başlatan intermediary ECC process. | Harness child ile aynı pid/process değil. |
| ECC-R64 — detached runner | Ordinary CLI path'inde caller shell lifetime'ından ayrılmak için setsid/new-process-group kullanan wrapper. | Her OS/shell failure altında survival guarantee değil. |
| ECC-R65 — harness child | Runtime capture function'ın spawn edip pid/output/exit gözlemlediği actual configured/built-in child. | Session id veya wrapper pid ile aynı identity değil. |
| ECC-R66 — wrapper pid | Outer ECC runner spawn'ında elde edilen process id. | Session row'a later stored harness pid ile aynı değil. |
| ECC-R67 — stored pid | Harness launch sonrası session record'a yazılan numeric pid. | Attempt generation, process-tree receipt veya immutable process identity değil. |
| ECC-R68 — DbWriter | Runtime store mutations'ını dedicated thread üzerinden yürüten message/ack boundary. | Whole transaction, UI receipt veya semantic acceptance oracle'ı değil. |
| ECC-R69 — oneshot acknowledgment | Store method'in completion/error sonucunu runtime'a geri taşıyan reply channel. | Receiver iptali earlier DB effect'i geri almaz. |
| ECC-R70 — Running transition | pid write sonrası session state'in Running'e geçirilmesi. | Useful work started/accepted veya model progress proof değil. |
| ECC-R71 — heartbeat | Periodic/touch operations ile refreshed liveness timestamp. | Reasoning/tool progress/task advancement değil. |
| ECC-R72 — Completed | Child exit status success sonrası runtime terminal state'i. | Goal-specific work acceptance veya quality verdict değil. |
| ECC-R73 — Failed | Runtime/session failure classification path. | Her side effect'in rollback edildiğini veya process'in gone olduğunu göstermez. |
| ECC-R74 — transition validator | update_state içinde current state → requested state legality check'i. | Her writer/mutation için exclusive authority değil. |
| ECC-R75 — reset mutation | update_state_and_pid gibi transition validator dışından state/pid reset eden path. | Illegal by definition değil; farklı recovery/resume contract. |
| ECC-R76 — process-local output store | Arc/Mutex ring + broadcast ile aynı runtime içi bounded output view. | Cross-process dashboard transport değil. |
| ECC-R77 — session_output | SQLite'ta persisted stdout/stderr line table. | Unlimited transcript veya model conversation archive değil. |
| ECC-R78 — retained output tail | Her session için newest 1,000 line'ı tutan bounded persistence. | Complete historical output değil. |
| ECC-R79 — output cache | Dashboard'ın DB tail'ini poll edip locally retained/rendered lines'a çevirdiği view. | Store'un current/complete olduğu guarantee değil. |
| ECC-R80 — stale output cache | Per-session read failure'da previous cached lines'ın görünmeye devam edebilmesi. | Underlying data unchanged demek değil. |
| ECC-R81 — no-sessions view | Session-list failure path'inde empty vector üzerinden ordinary-looking empty UI çıkabilmesi. | Gerçekten session yokluğu kanıtı değil. |
| ECC-R82 — prefix session lookup | id equality veya starts-with üzerinden updated-descending list'ten first match seçimi. | Unique exact address guarantee değil. |
| ECC-R83 — latest session | updated_at descending list'in first row'u. | Semantically intended/current task session'ı olmak zorunda değil. |
| ECC-R84 — board lane | Session state'ten Inbox/In Progress/Review/Blocked/Done/Stopped projection'ı. | Independent project/work acceptance state machine değil. |
| ECC-R85 — board progress percent | State/worktree/tool/file heuristics'ten assigned 0–100 operational percentage. | Requirements-completion ölçümü değil. |
| ECC-R86 — board conflict signal | Task/scope/branch heuristics'ten türetilen operational conflict hint. | Git merge conflict veya ownership adjudication değil. |
| ECC-R87 — board motion | Current derived snapshot ile previous snapshot arasındaki movement annotation. | Append-only event history değil. |
| ECC-R88 — effectful observer | TUI dashboard'ın read/poll yanında queued activation ve heartbeat/budget/conflict enforcement çağırması. | Passive monitor değil; ancak universal supervisor da değil. |
| ECC-R89 — dashboard tick | UI loop içinde activation/sync/enforcement yapan periodic-ish maintenance step. | Fixed refresh interval guarantee değil; interaction branches delay edebilir. |
| ECC-R90 — worktree request | Capacity wait sırasında stored launch/resource request. | Running attempt veya accepted scheduling lease değil. |
| ECC-R91 — attached worktree | Session'a çalışma dizini/resource olarak bağlı Git worktree standing'i. | Path exists ile aynı şey değil. |
| ECC-R92 — base checkout | Current Git worktree list'inden cleanup/sync için seçilen alternate checkout. | Immutable environment identity değil. |
| ECC-R93 — dependency fingerprint | Selected manifest/lock content'e göre reuse/link decision veren compatibility signal. | Dependency bytes immutable/isolated guarantee değil. |
| ECC-R94 — shared dependency link | node_modules/target/.venv gibi resource'ları symlink/reuse eden strategy. | Concurrent-writer isolation veya exact reproducibility değil. |
| ECC-R95 — cleanup stop | Stop path'inde process action + Stopped state + default worktree cleanup behavior. | Useful output preservation veya all descendants terminated receipt değil. |
| ECC-R96 — retaining pause | Budget/conflict path'inde cleanup=false ile Stopped'e gidebilen resource-preserving variant. | Same Stopped label'in same resource consequence taşıdığını göstermez. |
| ECC-R97 — worktree removal | git worktree remove --force + branch delete ve fallback/warning behavior. | Return Ok bütün cleanup/preservation succeeded proof değil. |
| ECC-R98 — recreated path | Cleanup sonrası old working_dir altında log directories yeniden yaratılınca path'in tekrar var olması. | Former Git worktree/resource identity'nin geri geldiği anlamına gelmez. |
| ECC-R99 — resource identity | Git registration/branch/uncommitted contents gibi path string'den daha güçlü continuation identity. | Session id veya filesystem existence ile eşit değil. |
| ECC-R100 — same-id resume | Existing ECC session id/task/agent/workdir ile fresh wrapper başlatma. | Model conversation/reasoning context restoration değil. |
| ECC-R101 — native-context restoration | Underlying harness/model transcript state'inin gerçekten resumed olması. | Reviewed built-in resume path bunu establish etmedi; stronger residual. |
| ECC-R102 — startup reconciliation | Daemon startup'ta Running rows'i numeric-pid liveness'a göre keep veya Failed yapma. | Process relaunch, Child handle recovery veya supervision reattachment değil. |
| ECC-R103 — pid liveness | kill(pid,0)/platform helper ile numeric pid existence/access probe. | Original attempt identity/readiness guarantee değil. |
| ECC-R104 — auto-termination classification | Overdue session için termination request sonrası Failed/None write path. | terminate result discarded olduğundan process gone receipt değil. |
| ECC-R105 — partial method effect | Multi-statement store method'in later error vermesine rağmen earlier statement side effect'inin committed kalabilmesi. | Her store method non-atomic veya observed production failure demek değil. |
| ECC-R106 — expected-state predicate | Write'ı previously observed state'e bağlayan compare-style control. | ECC source'da adopted attempt fencing değil; E07 counter-control. |
| ECC-R107 — stale guarded write | Earlier admission/read'e dayanan id-only update'in newer state'i overwrite edebildiği conditional/interleaved write. | Reproduced ECC concurrent race/frequency değil. |
| ECC-R108 — E07 | Source-derived SQLite/Git bounded fixture: tail retention, partial effects, stale write ve resource identity discriminators. | Compiled Rust/ECC/Tokio/live-host test değil. |

## 4. U09-A3 — execution-attempt ownership and revocation

Dayanak: notes/15-EXECUTION-ATTEMPT-OWNERSHIP-AND-REVOCATION.md, evidence/U09-A3-SOURCES.md, ROUND-U09-A3.md, PUBLICATION-U09-A3.md. Bu bölümün conditional schedules'i observed incidents değildir.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R109 — execution attempt | Bir session id altında belirli launch/capture invocation'ına ait child + observer tasks + effects bütünü. | Durable session record ile aynı identity değil. |
| ECC-R110 — attempt ownership | Hangi invocation'ın current child/state/output finalizer üzerinde yetkili olduğunu belirleyen binding ihtiyacı. | Reviewed schema'da explicit generation/lease olarak bulunmuş değil. |
| ECC-R111 — attempt generation | Old/new execution writers'ı ayırabilecek conceptual version/generation identity. | ECC'de implemented field diye kaydedilmez; source gap'i açıklayan extractor label. |
| ECC-R112 — attempt lease | Exclusive/current execution claimant'i belirleyebilecek conceptual lease/fencing role. | ECC source term/implemented mechanism değil; missing binding'i anlatan yorum. |
| ECC-R113 — Child handle | Tokio runtime içinde belirli spawned child process'in in-process owner handle'ı. | Durable store identity veya automatic kill-on-drop değil. |
| ECC-R114 — kill_on_drop | Tokio process ChildDropGuard için default false olan process-handle cleanup option. | External harness/supervisor davranışını belirlemez. |
| ECC-R115 — JoinHandle | Spawned async task completion handle; drop edilmesi task'i detach eder. | Runtime shutdown ile aynı event değil. |
| ECC-R116 — runtime shutdown | Tokio runtime kapanırken spawned tasks/I/O'nun drop/stop semantics'i. | Sadece JoinHandle drop veya process kill ile eşdeğer değil. |
| ECC-R117 — Pending admission check | run_session'ın launch öncesi observed state Pending değilse return eden guard. | Durable exclusive claim/reservation değil. |
| ECC-R118 — stop-before-pid window | Pending read sonrası child spawn/pid write öncesinde Stop'un pid=None görüp Stopped yazabildiği ordering window. | Orphan process empirically observed demek değil. |
| ECC-R119 — refused post-spawn transition | Child spawn sonrası Stopped→Running guard refusal'u. | Already issued child side effect'ini otomatik revoke etmez. |
| ECC-R120 — selective kill/wait cleanup | Missing-pipe gibi belirli error branches'te explicit child kill + wait. | Every later error/cancellation branch'inde aynı cleanup var demek değil. |
| ECC-R121 — post-spawn DB failure | Child spawn sonrası pid/state/heartbeat store operation'larından birinin fail olabileceği source window. | Üretimde gerçekleştiğine dair run/frequency evidence yok. |
| ECC-R122 — cancellation versus Err | Future cancellation path'i ile ordinary awaited operation'ın Err dönüp cleanup code'una girmesinin ayrılması. | Cancellation otomatik persisted Failed veya child termination değil. |
| ECC-R123 — abandoned acknowledgment | DB writer operation gerçekleşirken oneshot receiver'ın artık beklememesi. | DB side effect revoked/rolled back demek değil. |
| ECC-R124 — observer-task divergence | Stream capture/heartbeat tasks'in child ve birbirlerinden farklı failure windows'ına sahip olması. | Her error'da leak/orphan olduğu iddiası değil. |
| ECC-R125 — stale attempt | Aynı session id altında artık current sayılmaması gereken fakat hâlâ effect/finalizer üretebilen older execution. | Gerçek concurrent duplicate worker gözlemi değil. |
| ECC-R126 — stale finalizer | Old attempt'in newer same-id run sırasında pid clear veya legal terminal state yazabilen conditional finalization path'i. | Reproduced production overwrite değil. |
| ECC-R127 — legal-but-stale transition | Current state table açısından izinli fakat effect provenance'ı eski attempt'e ait transition. | State-transition legality'nin gereksiz olduğu anlamına gelmez. |
| ECC-R128 — delayed activation | Queued worktree request'ten daemon/TUI içinde Tokio task olarak run_session launch etme path'i. | Ordinary detached wrapper ile aynı supervisor lifetime değil. |
| ECC-R129 — discarded task handle | Delayed activation callback'in spawned run_session JoinHandle'ını retain etmemesi. | Task hemen iptal edildi demek değil. |
| ECC-R130 — surviving process vs recovered supervisor | Restart sonrası pid alive görünmesi ile original Child/stream/heartbeat ownership'ın yeniden kurulmasının ayrılması. | External supervisor yokluğu theorem'i değil. |

## 5. U09-B — Node operator bridge and target binding

Dayanak: notes/16-NODE-OPERATOR-BRIDGE-AND-TARGET-BINDING.md, evidence/U09-B-SOURCES.md, ROUND-U09-B.md, PUBLICATION-U09-B.md. Tests inspected, not run.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R131 — control pane | Node HTTP/UI operator bridge combining ECC2 snapshot, state.db work items, Cargo shortcuts, recall/proximity views and messages. | Homogeneous controller veya single state authority değil. |
| ECC-R132 — snapshot database | Node panel'ın configured ECC2 database file bytes'ını sql.js ile import edip local view üretmesi. | Live Rust API response veya coherent multi-store snapshot değil. |
| ECC-R133 — stateDbPath | Separate Node state.db work-item/session store target. | Rust ECC2 sessions DB ile aynı store/schema değil. |
| ECC-R134 — observed database | Panel snapshot'ın okuduğu selected database A. | Action subprocess'in gerçekten mutation yaptığı target ile otomatik aynı değil. |
| ECC-R135 — commanded database | Fresh Rust process'in kendi Config::load sonucuyla açtığı cfg.db_path. | Panel-selected explicit DB/config'e automatically bound değil. |
| ECC-R136 — target-binding gap | Observation target'i ile delegated command target'i arasında explicit shared identity/argument bulunmaması. | Her installation'da mismatch observed demek değil. |
| ECC-R137 — Cargo shortcut | Control pane action route'undan repoRoot/ecc2 cwd ile fixed Rust command argv launch'u. | Selected snapshot DB'ye effect guarantee değil. |
| ECC-R138 — copy-only action | Open TUI gibi server'ın execute etmeyip yalnız command text sunduğu action. | Terminal gerçekten açıldı demek değil. |
| ECC-R139 — graph sync shortcut | graph sync --all action'ı; transitive olarak runtime metrics/heartbeat/budget enforcement çağırabilen route. | Her click worker stop/pause eder demek değil. |
| ECC-R140 — local page recall | Node snapshot içinden local scoring/recallKnowledgeEntries ile üretilen page result. | Rust Recall Knowledge command'ı ile same algorithm/result değil. |
| ECC-R141 — card mutation | Selected state.db üzerinde claim/lane move/upsert ve persisted image change. | Rust worker launch veya exclusive execution ownership değil. |
| ECC-R142 — explicit-id claim | Work-item claim API'sinin supplied owner ile existing owner'ı replace edebilmesi. | Exclusive lease/admission invariant değil. |
| ECC-R143 — lane move | Work item lane/status record mutation. | Goal acceptance veya process lifecycle transition değil. |
| ECC-R144 — whole-image persistence | sql.js imported DB image'in temp file + fsync + atomic rename ile save edilmesi. | Multiwriter merge/serialization guarantee değil. |
| ECC-R145 — snapshot generatedAt | Snapshot construction zamanı. | Underlying two stores için common commit/revision freshness proof değil. |
| ECC-R146 — bounded snapshot | Sessions/work-items/entities/observations için fixed row limits ile constructed operator view. | Complete database inventory değil. |
| ECC-R147 — existing-file flag | DB path exists bilgisinin health/snapshot context'te görünmesi. | DB contents valid/openable/current guarantee değil. |
| ECC-R148 — health ok | Control-pane health endpoint'in paths/config surface'i üzerinden ok standing'i. | Databases, Cargo, worker veya command readiness test'i değil. |
| ECC-R149 — advisory view | Proximity/control-plane GET route'larının declarations/actions/risks gösteren read projection'ı. | Message delivery veya actuator effect değil. |
| ECC-R150 — declared-only inventory | Control-plane projection'da inventory/lease benzeri item'ların acquired/enforced sayılmadan gösterilmesi. | Actual lock/resource ownership değil. |
| ECC-R151 — proximity-tick | Snapshot → triggers → dispatcher → external message sink yapan ayrı Node CLI. | HTTP advisory view ile aynı caller değil. |
| ECC-R152 — message sink | ecc-tui messages send argv'sini kurup selected executable'ı sync invoke eden producer boundary. | Recipient uptake veya actual Rust consumer admission guarantee değil. |
| ECC-R153 — executable selection | Override/env/built-path/PATH üzerinden selected ecc-tui binary identity. | Pinned research source ile installed executable equality guarantee değil. |
| ECC-R154 — proximity_steer / proximity_hold | Node trigger kinds'in conflict message kind'ına map edildiği delivery intents. | Valid Rust conflict command guarantee değil. |
| ECC-R155 — proximity_transmit | Node trigger kind'in query message kind'ına map edildiği delivery intent. | Recipient behavior veya resolved conflict değil. |
| ECC-R156 — conflict message | Rust consumer'da at least one file gerektiren structured message kind. | Node producer bu required field'i sağlıyor demek değil. |
| ECC-R157 — --file contract | Rust conflict-message builder'ın first file argument'ını zorunlu kılan consumer predicate. | Query kind için required değil. |
| ECC-R158 — producer/consumer mismatch | Node steer/hold argv'sinde --file olmaması ile pinned Rust conflict consumer'ın bunu require etmesi arasındaki source contradiction. | Installed override binary'nin aynı davranacağı veya live failure observed olduğu anlamına gelmez. |
| ECC-R159 — skipped send | Message sink/dispatcher error'ında attempt'in skipped olarak counted edilmesi. | Trigger resolved veya recipient notified değil. |
| ECC-R160 — success cooldown | Successful sync return sonrası sender/recipient/type key ile in-memory five-minute suppression. | Failed attempt'leri suppress etmez; content/revision binding veya durable lease değil. |
| ECC-R161 — sent count | Dispatcher'ın successful command-return count'i. | Message recipient uptake, action veya conflict resolution proof değil. |
| ECC-R162 — read-only server gate | HTTP card/action mutation routes'ını disabled eden control-pane mode. | proximity-tick veya external writers dahil bütün system writes'i kapatmaz. |
| ECC-R163 — action allowlist | Server'ın yalnız named predefined actions'ı build/execute etmesi. | Effect target correctness veya harmlessness guarantee değil. |
| ECC-R164 — argv execution | Child process'i shell string yerine fixed argv ile launch etme boundary. | Process-tree termination, target binding veya business-level authorization guarantee değil. |
| ECC-R165 — runAction success | Child exit code zero üzerinden server-side action success standing'i. | Intended database changed veya later snapshot reflected effect demek değil. |
| ECC-R166 — action timeout | Timer sonrası SIGTERM request'i içeren process timeout path'i. | Hard deadline veya whole descendant tree terminated receipt değil. |
| ECC-R167 — refreshed evidence gap | Action result ile subsequent Node snapshot refresh arasında rollback/identity transaction bulunmaması. | Partial effect observed demek değil. |
| ECC-R168 — work-item local foreign key | state.db work_items.session_id'nin aynı state.db sessions table'ına referansı. | Cross-file Rust ECC2 process session authority değil. |

## 6. U08 recovery/evidence-integrity language

Dayanak: RECOVERY-U08-A-20260918.md, evidence/u08-a-recovery/README.md, CHECK-RESULTS.json, PUBLICATION-U08-A-RECOVERY.md. Bunlar behavior evidence değil; research/publication integrity semantics'idir.

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-R169 — quarantined object | Interrupted E06 publication'dan retained fakat validated experiment evidence sayılmayan stored binary object. | Usable/result-bearing evidence olduğu anlamına gelmez. |
| ECC-R170 — Git blob correspondence | Fetched/stored bytes'ın expected Git object identity ile eşleşmesi. | Original local artifact correctness veya semantic validity değil. |
| ECC-R171 — text-reader mismatch | Compressed bytes'ın UTF-8 reader ile açılamaması. | Tek başına archive corruption proof değil. |
| ECC-R172 — invalid compressed stream | Exact stored object'in gzip decompression testinde fail etmesi. | Corruption'ın hangi adımda oluştuğunu açıklamaz. |
| ECC-R173 — partial forensic recovery | Invalid archive'dan complete pre-error member/prefix çıkarılabilmesi. | Full archive, preregistration authenticity veya run results recovery değil. |
| ECC-R174 — preserved-unverified object | Stored object'in metadata/identity ile korunup full content integrity'sinin doğrulanmamış olması. | Intact/corrupt/replacement evidence diye sınıflandırılmaz. |
| ECC-R175 — blob creation vs file publication | Git object upload başarısının reachable repository path/current STATE ile aynı şey olmaması. | Object useless demek değil; continuity ayrı obligation. |
| ECC-R176 — publication correspondence | Note/ledger/result bytes'ının intended repo path/ref ile readback/diff üzerinden eşlenmesi. | Research reasoning'in independent doğrulaması değil. |

## 7. C4 relation view / non-collapse

Aşağıdaki ayrımlar bu source slice'ın en güçlü ilişki sınırlarıdır:

- material family ≠ subsystem;
- breadth disposition ≠ implementation completion;
- review session identity ≠ artifact revision identity;
- feedback accepted ≠ engineering decision accepted;
- queue persisted ≠ consumer acknowledged;
- feedback drained ≠ model acted;
- review ended ≠ pending feedback resolved;
- session presence ≠ message receipt;
- loopback host check ≠ reviewer authorization;
- session id ≠ execution attempt;
- wrapper pid ≠ harness pid ≠ durable attempt identity;
- heartbeat ≠ useful progress;
- child exit success ≠ accepted work;
- state transition legality ≠ effect provenance;
- stored output ≠ complete transcript;
- board progress ≠ requirement completion;
- operator view ≠ passive observation;
- filesystem path ≠ Git worktree/resource identity;
- same-id resume ≠ native context restoration;
- pid alive ≠ supervisor recovered;
- Stop state ≠ process-tree termination receipt;
- session state guard ≠ attempt fencing;
- task-handle drop ≠ runtime shutdown ≠ process kill;
- displayed database ≠ commanded database;
- work-item claim ≠ worker launch;
- advisory projection ≠ message delivery;
- message send command success ≠ recipient uptake;
- producer argv accepted by test double ≠ actual consumer admission;
- source-derived counter-path ≠ observed incident;
- binary object preserved ≠ experiment evidence validated;
- same-assistant publication readback ≠ independent verification.

C4 local closure bu ayrımları ECC'nin current pinned source package'i için taşır. Bunlar global ortak tanım, Foundation primitive'i, SOUL/Development OS architecture decision'ı veya current upstream product certification değildir.
