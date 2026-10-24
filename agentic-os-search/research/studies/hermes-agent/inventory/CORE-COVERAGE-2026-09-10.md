# U02 — Kaynak kapsamı ve bir sonraki açıklama boşluğu

2026-09-10 / TARGETED SOURCE-CALLSITE MAP. Pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Eski kapsam değerlendirmesi](SCOPE-REVIEW-2026-09-10.md), [ilk topoloji](STRUCTURE.md), [U02 kaynak kimlikleri](../evidence/2026-09-10-turn-lifecycle/SOURCES.md).

## 1. Envanterin anlamı

Bu dosya recursive bütün upstream ağacının çıkarıldığı veya bütün dosyaların okunduğu iddiası değildir. Agent alt ağacı bir navigasyon girdisidir. Kapsam birimi gerçek bir geçiş/callsite ve maddi varyantıdır. **Listelenmiş**, **kaynakla incelenmiş**, **çalıştırılmış** ve **sentezlenmiş** aynı statü değildir. U02 kaynak incelemesi ve sentezdir; yeni runtime deneyi değildir.

## 2. Genel kaynak aileleriyle ilişki

| Aile | U02'nin gerçekten eklediği açıklama | Açık kalan / neden tüm aile kapanmadı? |
|---|---|---|
| F01 turn/execution/stop | Prolog → iteration → retry → tool/text → finalize ve normal gateway caller kaynak bağı. | API-error/recovery helper'ları, alternate runtimes, whole execution test. |
| F02 context/prompt/cache | Sidecar/API copy; engine selection; request-only ekler; normal compaction rebuild/keep-equal ve dönen active prompt. | Full builder/transport/plugin variants; gerçek approval-to-wire süre/ölçüm; bütün failure yolları. |
| F03 session/persistence | SessionPersistence row projection, batch append, True/False/None contract; gateway binding/count/reset; in-place/rotation caller. | Actual SQLite append/archive/child publication, crash/lease tests; search/retrieval semantiği. |
| F04 memory/skill lifecycle | Önceki M4'ü gerçek refresh caller'a bağlama; frozen vs external per-turn recall; finalizer review trigger. | Quality, exact review completion, skill-ledger/backup/sync, bütün writers. |
| F05 runtime/profile/provider | Session/channel/global routing, cache signature, per-turn callback/override updates. | Secret/provider init/rotation implementation; bütün profile resolvers/platformlar. |
| F06 tools/plugins/policy | Actual tool-round admission/persist/effect ile request/execution middleware sınırları. | Q26/Q29 full worker, plugin dependency closure; general permission verdict yok. |
| F07 backend/native | App-server'ın ordinary loop'tan ayrı sahipliği kaynak branch'i. | Backend process/sandbox/native thread internalleri. |
| F08 delegation/concurrency | Run generation, lease release/rebind, redirect result race; delegation cap çağrı noktası. | Full multi-agent coordination, lease registry/SQLite implementation, physical cancellation. |
| F09 gateway/delivery | Prepare/history/run/shape/persist/deliver; stream/None/already_sent, post-delivery notifications. | Bütün adapter transportları, replay/delivery ack, reconnect, media and shutdown. |
| F10 persistent work/cron | Kanban terminal nudge + timeout receipt call; goal/loop/heartbeat compression migration pointers. | **Yeni yüksek-değerli genişleme:** task create/claim/dispatch/run/accept, resume/retry, scheduler. |
| F11 UI/API/ACP | Normal gateway ve mevcut CLI memory path ilişkisi. | CLI host'un bütün lifecycle'ı; direct API/ACP/TUI/desktop aynı sayılmaz. |
| F12 install/eval | Mevcut kanıt sınırlarına dayalı kaynak karşı okuması; publication-only checks. | Upstream suite NOT RUN; eval quality/install/update/current release ayrı. |

F10 başlığı yeni kanıtla genişleme adayıdır; mevcut aileler kalıcı ontology değildir. Kanban'ı yalnız cron altına zorlamak yanlış olabilir. Sonraki kaynak turu task orchestration'ın ayrı aile olup olmadığını sınamalıdır. Bu map, Foundation tree'yi değiştirmez.

## 3. Yeni modelde açıklanmış ve açık kenarlar

Kaynakla bağlanan normal kenarlar: accepted external input → session lease/history → cached/fresh agent → turn-context → API-message copy → request/preflight/API attempt → tool-call persistence → tool execution dispatch → text/stop gates → finalizer → host transcript/delivery.

Bu kenarların altında kalan dağıtılmış/harici tüketiciler açıklanmış sayılmaz: `_get_transport`, `_execute_tool_calls` tüm bağımlılıkları, actual SQLite implementations, plugin hooks/engines ve son platform acknowledgement. C13 normal compaction, eski M4 artificial invalidate→restore sırasını actual caller diye yorumlamaya karşı somut kaynak kanıtıdır. Q07/Q22 source-level ilerler, end-to-end runtime kapanmaz.

## 4. Sonraki iş seçimi

**İlk yetkili sonraki birim: kalıcı task ve turn arasındaki kabul sınırı.** Başlangıç kanban: `agent/kanban_stop.py` ve finalizer'daki `hermes_cli.kanban_db_dispatch._record_task_failure` çağrısından task create/claim/dispatch/run → complete/block → terminal kaydı tüketen dispatcher'a geri git. İki yönlü trace: terminal receipt neyi değiştiriyor; bu receipt'i gerektiren başlatma ve ownership ne?

Çıkış ölçütü: normal bir kanban işinin kimliği, claimant/run sahibi, çalıştırılabilirlik koşulu, agent launch, kabul edilen terminal sonucu ve bir kesinti/retry yolunun state'leri kaynakla açıklanabilmeli. Tool-name/narration ile DB receipt aynı sayılmamalı. Offline deney yapılırsa test yalnız ad kontrolüne değil gerçek transition consumer'a yönelmeli; source kimliği ve sentetik çevre açık tutulmalı. Ürün kurulumu/provider çağrısı yok.

Ardından goal/loop/heartbeat yolları kanban'la aynı mı farklı mı araştırılır; sırf benzer adlar tek task modeli üretmez. Session persistence'ın actual DB/lease/compaction consumer'ları iki tarafa da bağlanır. Kalan F01–F12 aileleri ve skill-ledger/sync/curator köprüleri bu bilgiyle yeniden önceliklendirilir.

### Alternatiflerin değerlendirilmesi

Daha fazla M4 veya slash-policy senaryosu, yeni tur-üstü boşluğu kapatmaz. Bütün worker/runtime güvenlik sorularını önce bitirmek genel mimari açıklamayı tek dala kilitler. Nihai dört-alan/SOUL sentezi ise büyük outer-work/runtime varyantları bilinmeden erken olur. Kanban/kalıcı iş adımı, genel ajan döngüsünün kullanıcı işine nasıl dönüştüğünü açıklama değerinden dolayı seçildi; bir benchmark/bug sayısını büyütmek için değil.

Bütün kullanıcı görevlerini tamamlayan genel bir planlayıcı bulunduğu varsayılmıyor. Kalıcı iş yöneticisi bir opt-in yol olabilir; normal sohbetin ayrıca task nesnesi taşıması gerekmeyebilir. Bu rakip modeller sonraki source turunda açık tutulur.
