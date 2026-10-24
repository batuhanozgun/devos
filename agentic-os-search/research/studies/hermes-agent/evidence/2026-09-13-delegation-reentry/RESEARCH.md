# U13-A — Kayıtlı alt ajan sonucundan ana ajanın yeni turuna

**2026-09-13 / Q57 / PINNED SOURCE STUDY.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. [Kaynaklar](SOURCES.md), [sonraki dar kontrolün önceden sabit ölçütü](SPEC.md), [STATE](../../STATE.md). Bu A diliminde yeni HERMES behavioral execution yapılmadı. Kaynak çıkarımı canlı ürün olayı veya güncel sürüm hükmü değildir.

## 1. Soru ve kapsam

U12, child'ın kurulması ve çalışması, sync dönüş ve detached sonucun ledger/queue'ya yazılmasını açıklamıştı. Q57'nin açık oku bu sonucun **kimin güncel konuşmasında hangi kabul sınırından geçerek kullanıldığıdır**. Bu tur bir normal CLI consumer ile TUI/Desktop gateway'in poller ve post-turn consumer'ları gerçek parent `run_conversation` girişine kadar bağlandı. Mesajlaşma gateway'lerinin bütün adapter'ları ve stateless API self-wake bu birimle aynı sayılmaz.

Başlangıç planı `899422ceba05f7b6a577b35baf6a985c317b7cf7`, main/ref/tam plan ve tek-path compare ile geri okundu; sonra kaynak araştırması başladı. U12 yayını `74c5e3d1dcd260a1841c64dda5fb1d182f7bb299` zaten tamamdı. Önceki kanıtlar yeniden çalıştırılmadı. Source→kanıt-sınırı→main readback kapısı korunur.

## 2. Ortak üretim yolu, farklı tüketim makbuzları

| Geçiş | İncelenen mekanizma | Tek başına göstermediği |
|---|---|---|
| Child sonucu | U12 async finalization, kalıcı result/event | Parent'ın sonucu gördüğü |
| Restore | ProcessRegistry kurulurken pending completion restore | Eski işin yeniden yürütülmesi veya yeni konuşmanın sahipliği |
| Routing | UI origin, durable session key ve compression lineage | Oturum üzerinde gerçek çalışma hakkı |
| Delivery claim | Pending ledger row üzerinde claim kimliği | Model turunun başladığı veya bittiği |
| CLI kabul | `_pending_input.put` sonrasında ack | Kuyruktan alınma, credential/init ve model kabulü |
| TUI kabul | `_run_prompt_submit` çağrısından sonra ack | False dönüşünün denetlendiği veya daemon turunun bittiği |
| Model bağlamı | Sentetik bildirim metni + güncel parent history snapshot | Child transcript'inin tamamı veya ilk ağ isteğinin ölçülmesi |

Bu tablo HERMES'in her koşulda veri kaybettiği ya da bütün teslimlerin yanlış olduğu iddiası değildir. Makbuzun tam olarak hangi geçişe bağlı olduğunu açar. [S01–S08]

## 3. Restart'ta mevcut olmak ile bu consumer'a ait olmak

ProcessRegistry'nin gerçek constructor'ı yeni completion_queue kurar ve `restore_undelivered_completions` çağırır; başarısızlık loglanır. Bu yalnız helper'ın varlığı değil, startup consumer bağlantısıdır. U12'de tam okunmuş S01 restore yolu, owner'ı kaybolan yürütmeleri unknown olarak sınıflandırabilir, kaydedilmiş kısmi child sonuçlarını korur; pending completion'ları `restored=True` ile kuyruğa koyar. Eski replay için age/drop sınırı vardır. Bu, in-flight child'ı tekrar başlatan bir mekanizma değildir. [S01,S02]

`ProcessRegistry._owns_event` özel ownership callback verilmişse onu kullanır ve callback hatasında false döner; aksi durumda verilen session_key ile doğrudan eşitlik kullanır. Hiç filtre verilmemiş legacy yolda çoğu olay tüketilebilirken restored delegation fail-closed bırakılır. Dolayısıyla docstring'deki genel ownership ifadesiyle legacy davranışı aynılaştırılmaz. Routing, consumed/poll-observed filtrelerinden önce yapılır: yabancı consumer kendi gördüm bilgisini kullanarak asıl sahibin olayını düşürmemelidir. [S02]

TUI'de `origin_ui_session_id`, mevcut session anahtarları ve compression continuation çözümü birlikte kullanılır. Başka canlı continuation'ın üstünlüğü ile bu session'ın pozitif sahiplik kanıtı ayrı helper'lardır. Parent Python nesnesinin aynı kalması tek kanıt değildir; fakat kaydın hiçbir canlı oturumla eşleşmemesi de rastgele yeni oturuma teslim yetkisi vermez. Normal poller unowned delegation olayını memory queue'dan düşürebilir; shutdown drain onu deferred listede geri verebilir. Buradaki memory drop, durable row'un delivered/drop yapıldığı anlamına gelmez. [S04]

## 4. CLI: kuyruğa kabul ile gerçek turn arasında pencere

Pinned `cli.py::_drain_process_notifications`, parent session_id ve `_owns_process_notification` ile drain eder. Bu ownership helper'ı boş kimliklerde reddeder; eski event key'ini DB üzerinden continuation'a çözmeyi dener. Sonra delivery claim alır. Claim None ise atlar. Delegation metni `SubagentNotification` içine sarılır, `_pending_input` kuyruğuna konur ve **hemen `complete_event_delivery` çağrılır**. [S06]

Gerçek `_tui_process_loop` bu kuyruğu daha sonra alır; idle ve post-turn yolları aynı drainer'ı çağırır. `_tui_process_one_input`, bildirim metadata'sını koruyarak `chat` çağrısına ulaşır. `CLIChatTurnMixin.chat` credential ve ajan kurulumunu kontrol eder; bu kontrollerin başarısızlığında None ile dönebilir. Metin ancak bundan sonra user row olarak stage edilir ve worker thread başlar. `_chat_run_agent`, `conversation_history[:-1]` ve task_id=session_id ile gerçek `agent.run_conversation` çağrısını yapar. [S06,S07]

**Koşullu çıkarım:** ack sonrasında fakat input tüketimi/staging öncesinde süreç kaybolursa, yalnız pending-row replay mekanizmasının o olayı otomatik geri getirmesi beklenemez; çünkü ack delivered durumuna taşımayı ister. Bu çalışmada bu crash üretilmedi; başka kayıt/kurtarma mekanizmalarının bütün etkisi kapatılmadı. Düşük seviyeli `complete_event_delivery` wrapper'ı DB update'in boolean sonucunu üstüne döndürmez; bir ack çağrısı ile kalıcı ack'in başarıyla yazılması da ayrı tutulmalıdır. [S01,S06,S07]

## 5. TUI/Desktop: üç farklı sahiplik/kabul katmanı

Poller önce routing ve pozitif ownership'i kontrol eder, formatlar ve kısa status görünümünü dedup eder. Sonra history_lock altında `session.running=True` ile yerel boş-tur yerini alır. Meşgulse olay yeniden queue'ya konur. **UI status görünmesi bu noktada model kabulü değildir; status, turn-slot ve durable delivery claim'den önce olabilir.** [S04]

`_notif_dispatch_event`, bundan sonra durable claim alır; `_notif_submit` üzerinden `_run_prompt_submit` çağırır. Submit exception atarsa yerel running temizlenir ve claim release edilir. Exception yoksa `complete_event_delivery` çağrılır. Bu sıranın iki dar composition sınırı vardır:

1. `_run_prompt_submit` **bool** döndürür. `_admit_prompt_turn` gerçek aktif-session hakkını reddederse veya session closing/queued-generation uyumsuzsa False; thread başlamadan önce live session replacement/closing görülürse yine False. Fakat `_notif_submit` dönüş değerini taşımıyor, `_notif_dispatch_event` de denetlemiyor. Böylece no-exception False dalında ack çağrısı kaynakla açıklanır.
2. `_notif_handle_event` running'i true yaptıktan sonra `_notif_dispatch_event` claim None alırsa hemen döner; bu dalda running'i temizleyen bir işlem görünmez. Yerel busy işaretiyle durable claim acquisition bir transaction değildir. Bu tek başına bütün ürünün sonsuza kadar takıldığına dair gözlem değildir; başka release/telafi yolları veya yarışın gerçekleşmemesi sonucu değiştirebilir. [S04,S05]

Post-turn yolu da karşı okundu: queued user prompt önceliklidir; goal continuation ve completion drain sonra gelir. Completion için running alınır, claim istenir ve `_dispatch_followup_turn` çağrılır. Bu helper da `_run_prompt_submit` False dönüşünü kontrol etmeden on_done callback'ini çalıştırır. Claim None dalında benzer release sorusu kalır. Aynı sorun sadece tek poller satırına bakılarak genellenmedi; ikinci gerçek caller da görüldü. [S05]

Bu bir exploit veya uygulama düzeltmesi önerisi değildir. Kaynakta doğru bool üreten alt katmanla onu tüketmeyen üst katmanı ayırıyoruz. Dar seçki diagnostic'i için oracle [SPEC](SPEC.md)'de sonuçtan önce tanımlanmıştır; bu A kaydı o diagnostic'in çalışmış olduğunu söylemez.

## 6. Schedule edilen thread henüz model turu değildir

Normal `_run_prompt_submit` active-session admission'dan sonra bir daemon thread başlatıp `can_start` döndürür. Thread içinde profile home/secret/terminal scopes, callback'ler ve güncel model ayarı bağlanır; history_lock altında `session.history` kopyası ve history_version alınır. `_prepare_turn_input` daha sonra context-reference expansion'ı bile reddedebilir. `_invoke_agent`, run_message ve snapshot history ile gerçek `agent.run_conversation` çağrısına girer. [S05]

AIAgent'in ortak facade'sinde ayrı durable cross-process turn lease admission vardır. Early result bu katmanda da mümkündür. Kabul edilirse admission'ın seçtiği history kullanılır, Relay/accounting/runtime kapsamları kurulup conversation loop'a geçilir. Dolayısıyla yerel running flag, host aktif-session hakkı, thread schedule ve model facade lease'i aynı gate değildir. U05/U06 history yenileme sınırları burada kapanmış sayılmaz. [S08; önceki lease araştırması]

Turn sonucu daha sonra history_version kontrolünden geçer; belirli model/personality marker değişimleri birleştirilebilir, diğer uyuşmazlıklar görünür uyarı üretebilir. `message.complete`, kalıcı hosted receipt ve cleanup daha sonraki olaylardır. Notification ack bunları bekleyen callback olarak bağlanmış değildir. Queue claim expiry, bütün DB write sonuçları, crash ve actual first request bu tur ölçülmedi. [S05,S08]

## 7. Yeniden gelen bilgi ne biçimde temsil ediliyor?

`format_process_notification`'ın delegation dalı, dispatch zamanı, goal/context, role/model, status, summary/error ve varsa transcript yollarından yeni sentetik metin oluşturur. Batch'te task_index ile call-wide goals eşleştirilir; bütçe-truncated sonuçların incomplete niteliği ayrı gösterilir. Kısa UI başlığı `async_delegation_display_text` ile üretilir; parent modeline verilen metin onunla aynı değildir. CLI `SubagentNotification` string taşıyıcısı bu iki görünümü ayırır. [S03,S06,S07]

**“Full task source” ifadesinin sınırı:** U12 gerçek `_dispatch_unit`, call-wide goals ve üst context'i async record'a geçirir; task bazında her context alanı aynı record'da ayrı bir liste olarak taşınmaz. Yeni formatter eldeki event'i kullanır; var olmayan task-specific bağlamı yeniden yaratmaz. Parent geçmişindeki özgün delegation çağrısı veya child transcript'i telafi edebilir. Bu nedenle sentetik bildirimin tek başına bütün özgün bağlamın lossless kopyası olduğu söylenemez. [S01,S03; U12 S08/S10]

TUI `_prepare_turn_input`, string içinde @ varsa genel context-reference preprocessing uygulayabilir. CLI ise SubagentNotification için bu expansion'ı açıkça atlar. Bu, iki host'un aynı notification metnini mutlaka aynı ilk model girdisine dönüştürdüğünü varsaymamak için başka bir somut farktır. Burada malicious prompt, gerçek dosya genişletmesi veya veri sızıntısı deneyi yapılmadı. [S05,S07]

## 8. Interim ve final aynı delivery token'ını tüketmemeli

Erken child-failure notice, final batch sonucu ile aynı delegation_id'yi taşıyabilir. S01 `claim_event_delivery`, interim notice'a boş token verir; `_event_delivery` boş token'da kalıcı ack/release yapmaz. TUI UI-dedup anahtarı da notice için task_index eklerken final için delegation_id+type kullanır. Böylece erken uyarının aynı satırın final teslim hakkını tüketmemesi amaçlanır. [S01,S04]

Buna karşılık final event claim'i başka tüketiciler arasında pending/claim/expiry koşullarıyla alınır; ack o claim'in hâlâ geçerli olmasını ister. Claim'in varlığı, sahibi doğru olsa bile downstream'in çalıştığının kanıtı değildir. Restore, interim, foreign-owner ve normal completion birbirinin otomatik eşdeğeri değildir.

## 9. Karşı açıklamalar, güncellik ve sınır

Olumlu mekanizmalar görünür tutuldu: pozitife dayalı ownership, compression lineage, restore provenance, interim/final ayrımı, gerçek host/facade admission ve current history snapshot. Üst ack ile alt bool'un kopukluğu, bu kontrollerin hiç bulunmadığı anlamına gelmez; tersine kontrolün reddinin üst katmanda neye dönüştüğünü gösterir.

Güncel resmî mutable delegation belgesi messaging gateway ack'ini adapter scheduling/queue insertion seviyesinde tarif eder ve bunun model turu/yanıt bitişi olmadığını açıkça ayırır. Bu güncel belge pinned TUI/CLI kaynak davranışının yerine kullanılamaz; current implementation veya fix doğrulanmadı. Default-branch aramasının verdiği yeni `hermes_cli/cli_process_notifications.py` primary pin'de 404 idi; eski gerçek metotlar `cli.py` içinde bulundu. Sürüm farkı primary upgrade gerekçesi yapılmadı. [W01,S06]

A'da hiçbir HERMES modülü, model/credential, canlı UI, process restart veya DB fault çalıştırılmadı. Tam parent-file byte kopyası da alınamadı; bir public raw download DNS hatası verdi. Load-bearing selected metin aralıkları ve re-used full sources [SOURCES](SOURCES.md)'de ayrıdır. Yeni upstream test suite sonucu yoktur.

## 10. Sonraki sınırlı iş

A main/ref/content olarak yayımlandıktan sonra, False/exception/claim-refusal farkını ayıran küçük source-selection diagnostic yapılabilir; tam ürün koşusu değildir. Sonrasında kapsam haritası yeniden değerlendirilir. Q57'nin normal CLI/TUI source oku ilerlemiş olur; messaging adapter/API, delivered-row vs actually-used, claim expiry/crash ve exact request doğrulamaları residual kalır. Bütün fault uzayını tüketmek sonraki geniş aileye geçmenin ön koşulu yapılmaz. Final CORE, Foundation veya mimari kararı yoktur.
