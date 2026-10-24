# Hermes Agent — Persistent work, continuation and scheduling terms

2026-09-20, **B6-T15-H5 / DURABLE TRANSFER COMPLETE / PACKAGE-COMPLETE**. TERMS.md'nin bağlı parçasıdır. Kaynak: Hermes notes 17–25, synthesis/03–04 ve U07–U10 evidence.

## 1. Persistent task and run identities

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-W01 — durable task | Session/tur ötesinde yaşayan, dependency/status/claim/run history taşıyabilen kalıcı iş kaydı. | Turn/session ile aynı değil. |
| HA-W02 — Kanban task | Board/store üzerinde persisted task object. | Worker process veya current turn değil. |
| HA-W03 — task ID | Kalıcı task'ı adresleyen kimlik. | Run/claim/session/turn ID değil. |
| HA-W04 — run | Aynı task için belirli execution attempt/lifecycle instance. | Task'ın kendisi değil. |
| HA-W05 — run ID | Bir execution attempt'i adresleyen kimlik. | Task success veya owner claim değil. |
| HA-W06 — claim | Belirli actor/process'in task/run üzerinde current work ownership hakkı. | Task assignment/history ile aynı değil. |
| HA-W07 — claim owner | Claim'i taşıyan process/worker/actor identity. | Task'ın normatif owner'ı veya user authority değil. |
| HA-W08 — claim heartbeat / refresh | Current worker ownership'ın hâlâ canlı olduğunu kaydetme. | Work progress veya semantic success kanıtı değil. |
| HA-W09 — stale/dead claim recovery | TTL/PID/liveness koşullarına göre eski claim'in reclaim edilebilir hale gelmesi. | Original work'ün yapılmadığını kanıtlamaz. |
| HA-W10 — task status | pending/running/waiting/done/failure benzeri task-level standing. | Run terminali veya judge verdict ile aynı değil. |
| HA-W11 — run terminal | Bir execution attempt'in terminal lifecycle sonucu. | Task'ın final kabulü değil. |
| HA-W12 — task acceptance | Run/result'ın persistent task state'i ilerletmesine izin veren ayrı acceptance transition. | Worker exit ile aynı değil. |
| HA-W13 — worker stop | Worker/process execution'ın bitmesi/durması. | Task success/done değildir. |
| HA-W14 — judge verdict | Output/progress hakkında model/evaluator verdict'i. | Task-store mutation veya user acceptance değildir. |
| HA-W15 — finalize nudge | Judge/loop sonucu terminal'e yakınsa task/goal state'i kapatmaya zorlayan ek continuation attempt. | Already-done receipt değil. |
| HA-W16 — dependency | Bir task/work item'in başka task/result tamamlanmasına bağlı olması. | Same group/session membership değil. |
| HA-W17 — dependency readiness | Dependencies'in current status'una göre task'ın runnable olup olmaması. | Environment/resource readiness ile aynı değil. |

## 2. Goal loop, continuation and heartbeat

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W18 — multi-turn goal | Tek turn ile bitmesi beklenmeyen, progress/judge/budget/continuation state taşıyan goal. | Kanban task ile birebir aynı değil. |
| HA-W19 — goal ID | Persistent/multi-turn goal identity. | Session veya turn ID değil. |
| HA-W20 — goal progress | Goal loop içinde recorded current progress/state. | Semantic completion oracle değil. |
| HA-W21 — continuation prompt | Önceki goal/work state'inden yeni turn başlatmak için üretilen prompt/input. | Same conversation replay'i olmak zorunda değil. |
| HA-W22 — loop tick | Goal loop'un next continuation opportunity'si. | Model turn, heartbeat fire veya cron occurrence ile aynı değil. |
| HA-W23 — cadence | Continuation ticks'in time/interval policy'si. | Scheduler occurrence identity değil. |
| HA-W24 — heartbeat | Waiting/continuation condition'ı zamanla tekrar gözleyen ayrı manager/watch mechanism. | Goal loop tick ile aynı implementation değil. |
| HA-W25 — heartbeat watch | In-memory/registered watch state. | Restart sonrası otomatik recover edildiği anlamına gelmez. |
| HA-W26 — heartbeat fire | Watch condition/time nedeniyle generated continuation opportunity. | Accepted turn veya completed work değil. |
| HA-W27 — awaiting_response | Goal/session'ın external/user response beklediği state. | Paused veya terminal done ile aynı değil. |
| HA-W28 — WAIT | Work/goal'un belirli condition beklemesi gerektiğini söyleyen local status/control result. | Her subsystem'te aynı lifecycle meaning değil. |
| HA-W29 — pause | Automatic continuation/dispatch'ın geçici olarak durdurulması. | Existing workers'ın physically stopped olması zorunlu değil. |
| HA-W30 — stop | Loop/manager'ın new work generation'ını bitirme control. | In-flight effect/process cessation receipt değil. |
| HA-W31 — goal budget | Multi-turn goal için continuation/iteration allowance. | Per-turn model iteration budget ile aynı değil. |
| HA-W32 — turn budget | Bir accepted turn içindeki model/tool iteration allowance. | Whole goal budget değil. |
| HA-W33 — runtime budget | Worker/provider/backend wall-clock/resource limit. | Goal/task semantic budget değil. |
| HA-W34 — budget exhaustion | İlgili budget class'in tükenmesi. | Success/failure/done anlamı mekanizmaya göre ayrıca belirlenir. |

## 3. Scheduled work identities

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W35 — cron job | Profile-local persistent scheduled work definition. | Occurrence veya execution attempt değil. |
| HA-W36 — job ID | Persistent scheduled job identity. | Fire/occurrence/execution ID değil. |
| HA-W37 — schedule | Recurrence/once/time rule defining future due opportunities. | Actual external registration değil. |
| HA-W38 — next_run_at | Built-in scheduler için currently planned next due time representation. | Inbound external callback identity değil. |
| HA-W39 — fire_at | External scheduler'a provision edilen planned occurrence time. | Gateway claim path bunu her zaman consume etmiyor. |
| HA-W40 — occurrence | Belirli job'un belirli planned time/fire instance'i. | Job identity ile aynı değil. |
| HA-W41 — dedup_key | Chronos outward registration'da job_id:fire_at birleşiminden oluşan external idempotency key. | Inbound claim'de korunması garantisi değil. |
| HA-W42 — fire claim | Job üzerinde o anda execution hakkını tutan persisted owner claim. | Historical occurrence memory değil. |
| HA-W43 — fire owner token | Host/PID yanında per-acquisition UUID ile current claim identity. | Execution ID değil. |
| HA-W44 — execution | Scheduled job'un belirli run attempt record'u. | Job veya occurrence değil. |
| HA-W45 — execution ID | Exact cron execution attempt identity; delivery queue idempotency key olarak da kullanılabilir. | User semantic success değil. |
| HA-W46 — dispatch claim | One-shot/finite work'te work side effect başlamadan dispatch budget'ını consume eden admission. | Success counter değil. |
| HA-W47 — repeat.completed | Finite repeat budget/dispatch accounting state. | Successful user outcome count değil. |
| HA-W48 — due scan | Built-in scheduler'ın current time vs next_run_at ve runnable conditions ile job selection yapması. | External claim path ile aynı admission değil. |
| HA-W49 — external fire | Chronos/provider callback üzerinden gelen scheduled execution trigger. | Built-in due scan ile aynı time gate değil. |
| HA-W50 — manual trigger | User/operator'ın run-now intent'iyle job schedule state'ini current execution'a yönlendirmesi. | Historical scheduled occurrence ile aynı değil. |
| HA-W51 — rearm_oneshot | Terminal/once job'u explicit new schedule ile tekrar aktif hale getirme. | New job identity veya explicit occurrence token üretmeyebilir. |

## 4. Job execution paths

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W52 — run_one_job | Claimed scheduled snapshot'ı execution body'ye taşıyan outer scheduler path. | Job record varlığı bunu çalıştırılmış yapmaz. |
| HA-W53 — run_job | Script/monitor/agent/no_agent paths arasında execution seçen shared worker. | Whole scheduler acceptance değil. |
| HA-W54 — no_agent job | Model/agent kurmadan script output'unu work result olarak kullanan scheduled path. | Cron always opens fresh agent genellemesini bozar. |
| HA-W55 — pre-run script | Agent job'dan önce data/context toplamak için çalışan script. | Agent workdir ile aynı cwd'yi garanti etmiyor. |
| HA-W56 — monitor job | External source değişimini hash/snapshot ile izleyip changed/no_change sonucu üreten scheduled path. | Observed change handled successfully değil. |
| HA-W57 — wake gate | Script output'taki exact wakeAgent:false contract ile model turn'ü açmama decision. | Script hiç effect üretmedi demek değil. |
| HA-W58 — normal agent job | Fresh AIAgent kurup prompt/context/tool/runtime ile run_conversation açan cron path. | Prior conversation replay'i değil. |
| HA-W59 — ephemeral cron agent | Scheduled execution için newly constructed agent/session. | Persistent user agent object'i değil. |
| HA-W60 — cron task ID | Tools/workspace için cron:job:execution benzeri execution-scoped identity. | Conversation session ID ile aynı değil. |
| HA-W61 — cron session ID | Scheduled agent conversation session identity. | Job/occurrence/task ID ile aynı değil. |
| HA-W62 — usage/fire UUID | Audit/usage tracking için ayrı identity. | Execution ID'nin synonym'i değil. |

## 5. Scheduled continuity channels

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W63 — context_from | Previous output file'dan next cron prompt'a bounded text inject etme channel'ı. | Transcript replay değil. |
| HA-W64 — context_from=self | Aynı job/profile output directory'sindeki newest mtime Markdown file'ı seçme. | Last successful/meaningful result seçici değil. |
| HA-W65 — output document | Scheduled attempt'tan durable Markdown result artifact. | User delivery veya task acceptance değil. |
| HA-W66 — newest-output selection | Freshest file by mtime üzerinden continuity. | Success/status-aware quality selection değil. |
| HA-W67 — 8k context truncation | context_from content'in first 8,000 chars ile sınırlandırılması. | Full output semantics'i taşımayabilir. |
| HA-W68 — job notepad | Profile/job keyed persistent key-value notes rendered into prompt. | Prior transcript değil. |
| HA-W69 — prefill messages | Config/env'den fresh agent context'e verilen priming messages. | Previous run history değil. |
| HA-W70 — built-in memory | Cron agent'in configured persistent memory store'dan context alabilmesi. | Her run'da doğru/relevant content garantisi değil. |
| HA-W71 — external memory provider | Configured provider üzerinden additional persistent context. | Real provider availability/quality current research'te tam ölçülmedi. |
| HA-W72 — SOUL/project context | Identity/project context files'in workdir/config'e göre fresh agent'a girmesi. | Researcher control instruction değil. |

## 6. Monitor and continuity findings

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W73 — detection checkpoint | Monitor source hash/snapshot'ını agent work başlamadan önce kaydetme. | Handled successfully receipt değil. |
| HA-W74 — no_change output | Monitor source unchanged olduğunda saved/silent result representation. | Older meaningful context'ten daha useful olduğu garanti değil. |
| HA-W75 — output shadowing | Newer no_change/empty/FAILED output file'ın context_from newest selector'da older useful report'u gölgelemesi. | Bounded selector execution finding; next-task harm measured değil. |
| HA-W76 — Prompt-before-Response truncation | Saved doc formatında long Prompt first 8k'yı doldurursa Response'ın context_from view dışında kalabilmesi. | Whole output lost demek değil; source file durur. |
| HA-W77 — operational success vs semantic completion | max_iterations/other end reason sonrası usable fallback text ile cron run'ın operational success yoluna gidebilmesi. | User goal accepted/done anlamına gelmez. |

## 7. Delivery identities and receipts

| ID / ifade | Yerel kullanım | Sınır |
|---|---|---|
| HA-W78 — delivery target | Result'in hangi external/local user/channel route'a gönderileceğini belirleyen destination. | Delivery success değil. |
| HA-W79 — delivery attempt | Bir output/result'i route üzerinden fiziksel gönderme denemesi. | Computation execution ile aynı değil. |
| HA-W80 — deliveries.db row | Exact execution ID için pending/delivering/terminal gönderim state'i. | Job outcome ile aynı store değil. |
| HA-W81 — pending | Delivery henüz claimed/sent terminal receipt almamış persistent state. | Failure veya delivered değil. |
| HA-W82 — delivering | Queue consumer tarafından claim edilmiş delivery attempt state. | External effect gerçekleşti receipt'i değil. |
| HA-W83 — delivered | Queue callback'in terminal success classification'ı. | Recipient saw/accepted result anlamına gelmeyebilir. |
| HA-W84 — failed | Queue callback terminal error classification. | Computation failed demek değil. |
| HA-W85 — unknown | Effect başlamış olabilir fakat terminal delivery standing'i güvenilir biçimde bilinmeyen state. | Retry-safe not-delivered demek değil. |
| HA-W86 — tombstone | Full terminal row prune olsa bile same execution'in resend edilmesini engelleyen retained idempotency marker. | User received output proof değil. |
| HA-W87 — SendResult | Live adapter/transport send outcome representation. | Bare success receipt strength değişebilir. |
| HA-W88 — UNVERIFIED delivery | success=True ama message_id/raw_response gibi stronger receipt absent olduğunda accepted-but-weak standing. | Verified external delivery değil. |
| HA-W89 — deferred delivery | enqueue_and_wait timeout'ta row pending kalırken error=None dönmesi ve later gateway drain'e bırakılması. | Delivered demek değil. |
| HA-W90 — delivery error | Computation success'ten ayrı external delivery failure information. | Job execution failed ile aynı değil. |
| HA-W91 — last_status | Job store'daki latest operational summary. | Delivery queue current state veya user acceptance değil. |
| HA-W92 — HTTP 202 accepted | External fire claim/admission'ın accepted/background path'e aktarılması. | Agent execution/delivery completion değil. |
| HA-W93 — HTTP duplicate | claim_fire None sonucu için response label. | Mutlaka same occurrence ran before anlamına gelmez. |
| HA-W94 — cancellation boolean != effect receipt | Future.cancel True/False sonucunun underlying async effect'in başlayıp/bitip/başarılı olduğunu güvenilir biçimde göstermemesi. | U08 bounded real-async diagnostic. |
| HA-W95 — assumed delivery | Timeout/cancel branch'inde terminal transport receipt okunmadan delivery accepted sayılan source decision. | Actual recipient effect proof değil. |

## 8. Core non-collapse

Hermes scheduled-work research şu zinciri ayrı tutar:

**job definition → scheduled occurrence → current claim/owner → execution attempt → computation result → output document → delivery attempt → delivery receipt/queue state → job-visible last status → future continuation context.**

Özellikle:
- job ID != occurrence ID;
- occurrence != execution ID;
- claim != execution;
- repeat.completed != success count;
- output saved != delivered;
- accepted HTTP callback != work completed;
- no delivery error != delivered;
- delivered queue standing != recipient/user acceptance;
- cancellation result != physical effect receipt;
- newest output != best prior context;
- fresh cron agent != old conversation resumed.


## 9. H2 persistent-work / multi-turn refinements

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-W96 — expected run ID | Task mutation/status read'in exact execution attempt'e bağlanmasını sağlayan expected_run_id predicate. | Task ID tek başına current execution authority değildir. |
| HA-W97 — review handoff | Current worker run'ın review_requested terminaliyle own execution'ı kapatıp same task üzerinde successor/reviewer run'a geçiş. | Task done veya old worker'ın new run authority'si değil. |
| HA-W98 — superseded run | Same durable task current başka run'a geçmişken prior run'ın continuation hakkını kaybetmiş standing'i. | Prior work erased/failed demek değil. |
| HA-W99 — loop outcome | Multi-turn helper'ın completed_by_worker/review_requested/blocked/stopped gibi local return classification'ı. | Durable task/run DB state'iyle aynı receipt değil. |
| HA-W100 — durable transition receipt | complete/block/review/claim gibi requested transition'ın task/run store'da gerçekten accepted/read-back edilmiş olması. | Callback return text veya loop outcome tek başına yeterli değil. |
| HA-W101 — block attempt vs block acceptance | Loop'un block callback'i çağırması ile task/run store'un blocked standing'e gerçekten geçmesi. | U04 G08/G09'da local blocked outcome persistent running ile coexist etti. |
| HA-W102 — finalize request | Judge done verdict'inden sonra worker'a kanban_complete/review/block transition'ı üretmesini isteyen continuation prompt. | Judge done = task done değildir. |
| HA-W103 — ownership recheck gap | Ownership/status check ile next turn/effect arasında state değişebilen zaman aralığı. | U04 G10 bounded harmless-turn finding; product-wide race incidence değil. |
| HA-W104 — WAIT-as-continue | Kanban goal-loop'ta wait verdict'inin yeni continuation turn'e dönüştürülmesi. | Session GoalManager WAIT barrier semantics'iyle aynı değil. |
| HA-W105 — WAIT barrier | Session goal mechanism'inde pid/process/time condition çözülene kadar judge/turn tüketimini durduran persisted waiting state. | Kanban wait semantics'i değil. |
| HA-W106 — persistent manager state | goal:/loop:/heartbeat:session records'ında saklanan definition/status/counters/timing state. | Live watcher/host reactivation guarantee değil. |
| HA-W107 — live reactivation | Persisted manager state'in host watcher/queue/route tarafından yeniden runnable continuation opportunity'ye dönüştürülmesi. | State load veya migration alone değil. |
| HA-W108 — manager-state migration | Session rotation/continuation sırasında parent key'den child/new-session key'e goal/loop/heartbeat state taşıma attempt'i. | Helper success boolean = child record durably present guarantee değil. |
| HA-W109 — migration acknowledgement gap | Migration helper'ın success döndürmesi ile child record'un durable readback'inin ayrılabilmesi. | U04 heartbeat H09 bounded fault; all managers/product failure hükmü değil. |
| HA-W110 — claim heartbeat vs session heartbeat | Kanban claim ownership refresh ile recurring session heartbeat prompt'unun farklı object/effect families olması. | Ortak “heartbeat” kelimesi aynı mechanism anlamına gelmez. |


## 10. H3 scheduled-work / cron refinements

| ID / ifade | Hermes araştırmasındaki kullanım | Sınır |
|---|---|---|
| HA-W111 — provisioned occurrence identity | External scheduler'a job_id + fire_at ile kaydedilen planned occurrence identity. | Persistent job veya later execution ID değil. |
| HA-W112 — inbound admission key | Gateway/provider claim path'inde actual acceptance decision'a taşınan identity set'i. | U09 pinned path'te fire_at her hopta admission predicate olarak korunmuyor. |
| HA-W113 — occurrence identity narrowing | Outward job+time identity'nin inbound path'te job-only acceptance'a daralması. | Source-only finding; actual duplicate occurrence observed değil. |
| HA-W114 — active claim protection | Hâlâ canlı fire_claim varken overlapping execution admission'ını engelleyen current-owner control. | Completed historical occurrence memory/idempotency ile aynı değil. |
| HA-W115 — historical occurrence memory | Daha önceki exact scheduled occurrence'ın already-consumed olduğuna dair persistent identity/standing. | Current active claim bunu otomatik sağlamaz. |
| HA-W116 — late callback | Prior planned occurrence'a ait callback'in original execution tamamlandıktan sonra gelmesi. | U09'da source-derived scenario; live NAS/provider run yapılmadı. |
| HA-W117 — duplicate response label | HTTP/provider path'in claim_fire None gibi birçok ret nedenini “duplicate” etiketiyle sunabilmesi. | Exact same occurrence previously executed receipt'i değil. |
| HA-W118 — scheduled snapshot | Admission sonrası execution body'ye taşınan current job/config/owner/execution state görünümü. | Persistent job definition'ın kendisi veya immutable occurrence object değil. |
| HA-W119 — execution context channels | Current prompt, context_from, notepad, prefill, built-in memory, external memory ve project/SOUL context gibi fresh run'a bilgi sağlayan ayrı channels. | Previous conversation transcript replay'i değildir. |
| HA-W120 — fresh cron conversation | Normal agent cron path'inde new agent/session ile başlayan execution conversation. | Persistent job continuity yok demek değil; continuity other channels üzerinden gelebilir. |
| HA-W121 — script-only execution | no_agent/script branch'inde AIAgent/model turn açılmadan result üreten scheduled path. | Script'in external effect üretmediği anlamına gelmez. |
| HA-W122 — wakeAgent gate | Script/monitor output'unun exact boolean wakeAgent:false contract'iyle model turn'ünü açmama control. | Scheduler occurrence/execution oluşmadı demek değil. |
| HA-W123 — script working directory | no_agent/monitor/pre-run script'in subprocess cwd seçimi. | Agent workdir ile her branch'te aynı değil. |
| HA-W124 — monitor detection-time checkpoint | Observed source hash/snapshot'ının downstream agent handling tamamlanmadan önce kaydedilebilmesi. | “Change handled successfully” receipt'i değil. |
| HA-W125 — execution-context selection quality | Which prior output/context channel is selected and injected into fresh execution. | mtime/newest selection semantic relevance/success-aware guarantee değil. |
| HA-W126 — operational cron success | Scheduler'ın nonfailed usable output/fallback ile success path'e ilerlemesi. | User goal semantic completion/acceptance ile aynı değil. |
| HA-W127 — execution teardown deferral | Caller timeout/return sonrası worker Future hâlâ running ise agent/SessionDB cleanup'ın Future completion'a ertelenmesi. | Caller returned = worker/effects stopped değildir. |
| HA-W128 — occurrence acceptance vs execution completion | Callback/admission 2xx/claim success ile execution, output, delivery ve user-visible outcome'un ayrı lifecycle stages olması. | HTTP accepted = scheduled work complete değil. |
