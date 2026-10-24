# U06 — Devam kabulü, geçmiş görünümü ve yeniden başlatma

**2026-09-11 / PINNED SOURCE STUDY + BOUNDED PROCESS-LOCAL DIAGNOSTIC.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. [SOURCES](SOURCES.md) gerçek okuma/yürütme kapsamını, [RESULT](RESULT.json) yeni ham koşuyu, [SPEC](SPEC.md) koşudan önce sabitlenen ayırıcıları, [MANIFEST](MANIFEST.json) kaynak/probe/arşiv kimliğini taşır. Bütün HERMES'in tamamlanması, gerçek gateway restart deneyi, bağımsız replication veya adoption kararı değildir.

## 1. U05'ten devralınan soru ve yeni bilgi

U05'in bıraktığı soru ikiye ayrılıyordu: continuation'ın hangi history ve çalışma hakkıyla yeni tura alındığı; kesinti/rotation sonrasında kalıcı niyetin nasıl canlı çalışmaya döndüğü. Bu tur güncel research main `0a475b5d7c50f47689c72cd31f954f5b2303ced6` ve v0.18 STATE/plan geri okundu; AGENT blob'u aynı kaldı. Aynı konuşmada tam okunmuş protokoller geçerlidir. U04-A/B yayınları yeniden yapılacak iş sayılmadı. Eski source engeli yeniden denendi: `hermes_state_messages.py` continuation'ı bu kez okunabildi.

Yeni inceleme, actual history selector/projection ve transcript write guard'dan gateway startup, active-turn marker, adapter dispatch ve post-turn consumer'a kadar ilerledi. Bunun içinde iki farklı lease ortaya çıktı: gateway'in process-local registry'si ile U05'teki durable DB lease. Küçük registry modülünün tamamı upstream blob'u ile byte-byte eşleştirilerek yedi ayırıcı senaryoda çalıştırıldı. Büyük kaynaklar seçili okumalardır; actual SessionDB veya bütün gateway kurulmadı/çalıştırılmadı. [S01–S11; L01–L07]

Ana sonuç: devam yalnız bir prompt veya stored JSON değildir. **Yönlendirmenin doğru oturumu seçmesi, uygun history görünümünün hazırlanması, o kapsamda çalışma hakkının alınması, çalıştırma/teslim yükümlülüğünün ayırt edilmesi ve ilgili sürücünün kabulü ayrı geçişlerdir.** Kaynakta bu geçişlerin bazıları atomik, bazıları best-effort, bazıları yalnız süreç içidir. Bu bir Foundation sınıflaması değil, incelenen native mekanizmaların açıklamasıdır.

## 2. Kimlikleri ayırmak neden gerekli?

| Native kimlik / kayıt | İncelenen sorumluluk | Eşit sayılmaması gereken |
|---|---|---|
| Routing/session key | Kanal, thread, kullanıcı/profile rotasının oturuma bağlanması | Tek transcript kimliği; farklı key aynı SID'ye bağlanabilir |
| Resolved session ID | Geçmişin okunacağı/yazılacağı segment | Compression öncesi/sonrası bütün conversation |
| Gateway TurnLeaseToken | Tek event loop'ta SID bölgesini tutan token, owner_key ve generation | Süreçler arası durable holder |
| DB session-turn holder / compression root | Compression segmentleri arasında süreçler arası transcript çalışma hakkı | Kanban expected_run_id veya bütün araç etkisi yetkisi |
| Active-turn token / resume_pending | Kesilen gateway turunun restart'ta recover edilebilir işareti | Başlamamış kuyruk öğesi; kalıcı otomatik işin semantik tamamlanması |
| Loop awaiting_response | Fire edilmiş tick'in tamamlanma bekleyişi | Kendiliğinden süre aşımında yeniden alınan DB lease |
| Delivery obligation | Üretilmiş yanıtın henüz teslim edilmemiş olması | Aynı işi yeniden hesaplama gereği |

Bu kimlikler aynı anda bulunabilir. Birini doğrulamak diğerlerini otomatik doğrulamaz. Özellikle token nesne kimliği, run generation ve DB holder birbirinin yerine kullanılamaz. [S01–S11; reused U05]

## 3. Normal gateway devamında history nasıl oluşuyor?

Normal agent yolu source/session binding'i çözdükten sonra `_hmwa_prepare_turn`a gelir. Gateway'in `_turn_leases` registry'si varsa resolved session ID için edinilir. Timeout, task-local context'i temizleyip `TurnLeaseTimeoutError` olarak çıkar; üst dispatch bu durumda post-turn goal/loop hook'larına gitmeden yeniden gönderme cevabı verir. Böylece bir kabul reddinin goal judge'a başarılı tur gibi sunulmasını engelleyen somut dal vardır. Registry olmayan minimal/özel host yolu ayrı kalır. [S07,S09,S11]

Gateway active-turn marker'ı bu lease'ten **sonra**, transcript load'dan önce yazılır. Ardından `async_session_store.load_transcript` çağrılır. `TranscriptReadError`, boş history olarak yutulmaz: mesajın işlenmediği cevabı döner. Bu aşama U05'teki agent facade DB lease'inin aynısı değildir: dış gateway lock history load→agent run→host flush bölgesini tek process içinde; iç durable lock farklı süreçler üzerinden agent turn'ını korur. İki kilidin tüm hata bileşimi bu tur çalıştırılmadı. [S07,S09; U05-S01–S04]

TurnRunner, okunmuş history'yi `_build_gateway_agent_history` ile model görünümüne dönüştürür. Aynı SID'ye bağlı **yeniden kullanılan cached agent** varsa, disk görünümü geride kaldığında `_select_cached_agent_history` üzerinden canlı `_session_messages` seçimi mümkün olabilir; bu seçimden sonra tehlikeli eski confirmation'ların temizliği yeniden uygulanır. Seçici helper'ın tüm karşılaştırma kuralı bu tur yeniden kapanmadı, fakat gerçek caller bağlantısı açıkça görülür. Sonra `_run_conversation_with_approval`, seçilen listeyi `agent.run_conversation(...conversation_history=...)`a geçirir. [S08]

Bu gateway telafileri, quiet Kanban CLI'nin result messages listesini devraldığını göstermez. U05'teki no-wait/no-rotation prolog gap'i **bounded source inference** olarak sürer. Yeni DB selector gövdelerinin erişilmiş olması, immediate admission yolunda onları çağrılmayan bir yere kendiliğinden eklemez. `_persist_session`ın canlı `_session_messages` saklaması da CLI'nin kendi `conversation_history` alanına atama değildir. Gerçek quiet next-request mesajları ve final provider payload hâlâ ölçülmedi. [S01,S02,S08; U05-S01,S02,S05,S06]

## 4. Oturumu seçmek ile model geçmişini seçmek farklıdır

`resolve_resume_session_id` önce compression tip'i çözmeyi dener; ardından sınırlı child yürüyüşüyle mesaj taşıyan derin devam adayını arar. Branch/delegation/reset/tool child ayrımları uygulanır. Burada 'mesaj var' kontrolü ile sonraki projection'ın active-row filtresi aynı değildir: selector'ın herhangi bir message row bulması, live/model-visible history'nin boş olmayacağını tek başına garanti etmez. Seçim yolundaki best-effort geri dönüşler de gerçek başarılı resume ile karıştırılmamalıdır. [S01]

`get_messages_as_conversation` normalde yalnız istenen session'ın aktif satırlarını row ID sırasıyla okur. Ancestor/inactive/compacted seçenekleri açık parametrelerdir; varsayılan bütün geçmişi geri büyütmez. Satır çözümünde structured content, assistant reasoning, tool alanları, platform ID, display metadata ve `api_content` sidecar gibi farklı temsiller vardır. DB'den yüklenmiş mesajların persisted marker'ı sonraki flush'ın onları yeni row sanmamasına yardım eder. İsteğe bağlı row ID başka bir kimlik bilgisidir; clean content ile API replay sidecar'ı eşit değildir. [S01]

Alternation repair yalnız bellekteki model listesine uygulanabilir; bu onarım kendi başına depodaki transcript'i rewrite etmez. Ayrıca `get_resume_conversations` aynı row görünümünden **model için aktif tip bağlamı** ile **kullanıcı arayüzü için compression lineage boyunca görünür geçmişi** ayırır. Kullanıcı bütün eski mesajları görebilirken modelin bounded bir tip/handoff görünümü alması otomatik veri kaybı değildir. Tersi yönde, UI'de eski cevabın görünmesi onun yeni API isteğine girdiğinin kanıtı değildir. [S01]

## 5. Gerçek yazma koruması neyi koruyor?

`_check_transcript_write_guards` gerçek write transaction içinde çalışır. Bir turn holder sağlanmışsa conversation kökündeki current holder okunur; bulunmama veya uyuşmama `SessionTurnLeaseLostError` üretir. Süre dolmuş ama holder hâlâ aynıysa yazı transaction'ında süre yenilenebilir. TTL bitişi, successor gerçekten hak almadan eski holder'ın her eylemini otomatik yasaklayan ayrı bir revoke olayı değildir. Successor holder varsa eski sahibin bu yolla yenilemesi mümkün değildir. [S01; U05 DB lease kaynakları]

Yük taşıyan kapsam ayrımı: **ordinary append'in varsayılanında holder yoksa ve `reject_active_turn_lease` açık değilse bu turn-lease kontrolü koşulsuz devreye girmez.** Bu bütün appends korunmuyor demek değildir; actual caller'dan parametreyi izlemek gerekir. Agent `_db_flush_write`, `_active_session_turn_lease_holder`ı `append_messages_batch`e gerçekten geçirir. Guard, transcript batch resolution/insert ve counters aynı `_execute_write` transaction'ına girer; chunk seçeneği ise ayrı işlemler oluşturabilir. Bu tur full DB çalıştırması veya tüm writer coverage yoktur. [S01,S02]

Compression-ended eski parent'a normal yazı, ayrı closed-parent kontrolüyle reddedilir. SessionPersistence bu özel hatada bounded tip adoption/retry deneyebilir. Bu adoption, yazının doğru session'a yönelmesini sağlayan bir yol; **modelin history listesini yeniden yükleyen genel onarım değildir**. Flush success/False/None, persisted marker stamping ve model bağlamı farklı nesnelerdir. Persist failure bütün geçmiş dış etkileri geri almaz. [S01,S02]

## 6. Process-local lease: gerçek küçük bileşen üzerinde sınananlar

Tam `gateway/turn_lease.py` 9,190 byte, Git blob `1f65614e66e748ec61573aced3fa48b57ee20281`. Modül içeriği değiştirilmeden ayrı araştırma adıyla import edildi. Gerçek asyncio.Lock/wait_for/task cancellation çalıştı; session/routing değerleri sentetikti. GatewayRunner, SessionDB, agent/model veya OS restart yoktu. [S11; SPEC/RESULT]

L01 aynı SID için iki routing key'in sırayla kabul edildiğini; L02 tutulan lease'te timeout'un gerçek exception ürettiğini ve sonraki sentetik gövdeye girilmediğini; L03 normal parent→child alias sonrasında eski/yeni ID'den bekleyenlerin aynı lock üzerinden sıralandığını gösterdi. L05 alanları aynı ama nesne kimliği farklı token'ın ve tekrar bırakılan eski token'ın successor'ı bırakamadığını; L06 iptal edilmiş waiter sayacının temizlendiğini ve capacity baskısının live lease'yi evict etmediğini gösterdi. [L01–L06]

L04 önemli bir **sınırın beklenen sonucudur**: target SID'de başka live lease varken rebind False döner; iki ayrı map korunur. Bu durum birleşik serialization'ın kurulması değildir. Normal alias korumasını bütün rotation yarışlarına yaymamak gerekir; gerçek DB root lease başka katmanda telafi edebilir. L07 iki bağımsız registry instance'ının aynı SID'yi ikisinin de kabul ettiğini gösterdi; process-local kapsamın dışına güven taşınmaz. Aynı process'teki iki instance, gerçek process restart deneyi değildir. [L04,L07]

N00 değiştirilmiş kaynağı normal identity checker import öncesinde reddetti. N01 timeout exception'ını dönüşe çeviren mutantı L02 oracle'ı; N02 target-conflict reddini kaldıran mutantı L04 oracle'ı reddetti. Bu kontroller iki ilgili hata sınıfına duyarlılık sağlar; bağımsız araştırmacı, bütün fault dağılımı veya ürün testi değildir. İlk SPEC sonucu gördükten sonra gevşetilmedi. Yedi grubu eski U04 G/H/K kayıtlarına ekleyip ürün başarı puanı üretmiyoruz. [SPEC, RESULT, MANIFEST]

## 7. Restart: active-turn işaretinden yeni isteme

`mark_turn_active` opaque token üretir. `_set_turn_marker_locked`, candidate entry'yi `_save_entry` ile yazdıktan sonra live alanlara geçirir. `clear_turn_active` token karşılaştırır; eski asynchronous unwind yeni token'ı temizleyemez. Bu single-marker save-before-live sırasını batch recovery'nin bütününe yaymıyoruz: `_update_all_entries_locked` başka bir mutate-then-save yoludur ve onun failure rollback'i burada doğrulanmadı. [S04]

Clean-shutdown marker varsa startup active-turn marker'larını discard eder, sonra clean receipt'i tüketir; bu işlemin hatasında devam etmeyerek eski clean receipt'in sonraki crash'i maskelemesini engelleyen dal vardır. Unclean startup önce gerçek active-turn işaretlerini `resume_pending`e terfi ettirir; sonra 120 saniyelik recent-activity fallback'ini dener. `suspend_recently_active` adı burada hard suspension değil, resume_pending işaretleme davranışı taşır. Eski/bozuk marker'lar ve suspended session'lar otomatik yeniden kurulmaz; daha özel pending reason korunabilir. [S03,S04]

Devam scheduler'ı origin/reason/profile/adapter, freshness, busy state ve yeniden yetkilendirme koşullarını değerlendirir. Owner artık izinli değilse otomatik tur için kapı kapanır. Bu check ayrı önem taşır: shared inbound pipeline'da internal event normal kullanıcı auth yolundan daha erken dönebilir; bütün internal producer'ların aynı auth check'e sahip olduğu sonucu çıkmaz. Bu kaynak gözlemi, yetkisiz kullanıcının internal işaret üretebildiği veya exploit bulunduğu iddiası değildir. [S03,S09]

Uygun kayıtta startup boş metinli internal event oluşturur. TurnRunner reason-aware recovery guidance ekler; yeni kullanıcı metni varsa ayrı persistence override korunur. Adapter'ın `interactive_resume` tercihi kullanıcıya geri dönme ile olayı sürdürme yönlendirmesini ayırır. Freshness'te transcript zamanı ve resume marker zamanı birlikte ele alınır; boş startup isteminin yanlışlıkla modele boş user turn olarak verilmemesi için fallback vardır. Guidance'ın varlığı modelin doğru devam ettiğinin ölçümü değildir. [S03,S08]

## 8. Yeniden hesaplama ile yeniden teslim birbirinin yerine geçmez

Startup önce mevcut delivery obligation'ları ele alan yola da sahiptir. Üretilmiş ama teslim edilmemiş yanıt için `_claim_pending_obligations`, network send başlamadan önce ilgili resume_pending'i temizlemeye çalışır. Amaç aynı işi yeniden hesaplatmak değil, mevcut yanıtı yeniden teslim etmektir. Sonraki consumer, send sonucuna göre delivered/failed kaydı yapar. Reconnect yolunda pending-clear başarısı şart koşulabilirken startup best-effort kolu bazı temizleme hatalarını loglayıp devam eder; bunları tek atomik garanti gibi anlatmıyoruz. [S03]

Dolayısıyla 'restart recovery tamam' birkaç ayrı soruya yanıt vermelidir: hesaplama kaldığı yerden mi devam etti; zaten hesaplanan cevap mı gönderildi; teslim state'i değişti mi; yanlış ikinci tur önlendi mi? Delivery ledger'ın actual SQL settlement'ı, ambiguous send, tüm platform/profile varyantları ve user delivery bu tur çalıştırılmadı. Yeni Q46 bu hesaplama/teslim ayrımını saklar, üretim exactly-once garantisi vermez. [S03,S06]

## 9. Loop ve heartbeat için önceki görünümün daraltılması

Gateway startup'taki background watcher listesinde `_loop_wakeup_watcher` gerçek launch bağı artık görüldü. Bu, U05'te yalnız keşif pointer'ı olan startup consumer'ını açar. Persisted active loop ve route, due/busy/goal kontrolleri üzerinden gerçek adapter'a ulaşabilir. Fakat `awaiting_response=True`yi yalnız saat geçişi temizlemez. [S03; reused U05-S08,S09]

Yeni karşı bağlantı şudur: inbound actual agent yolundan döndükten sonra `_run_post_turn_hooks`a gider; bu hook loop completion'ı boş yanıt durumunda da dener. Post-turn manager'da in-flight state varsa `complete_tick` çağrılır. Bu nedenle uygun bir generic restart-resumed turn veya sonraki gerçek turn, bekleyen tick'i yeniden takvime bağlayan **koşullu bir telafi yolu** olabilir. Bu, yalnız loop-specific otomatik retry değildir; tüketicide tick ile yeni turun exact kimlik eşleşmesi, hangi reason'ın nasıl sayıldığı ve gerçek restart zaman çizelgesi ayrıca sınanmalıdır. Başlamadan önce kesinti, başka routing/session key veya timeout/early-return yolları aynı sonucu vermez. [S09; U05-S08,S09]

Heartbeat için daha kesin bir düzeltme var: primary command handler'da boş `/heartbeat` ve `/heartbeat status` sadece durum döndürür; watch kurmaz. **Set veya resume**, watch'ı register eden çağrılardır; clear unregister eder. Önceki notlardaki 'kullanıcı heartbeat'e yeniden dokunur' sözü bu somut koşullarla okunmalıdır. Stored heartbeat JSON tek başına watch değildir; bir status okuması da onu yeniden başlatmaz. Normal rotation binding sync, bütün heartbeat-watch rebind yollarının kapandığını kanıtlamaz. [S05,S08; U05-S09]

## 10. Adapter kabulü ve post-delivery ismi hakkında karşı okuma

Primary `BasePlatformAdapter.handle_message` hızlı döner: handler yokluğu veya beklenen route-key uyuşmazlığı durumunda çalıştırmadan dönebilir; busy yolu event'i kuyruklayabilir; idle yol guard kurup background task başlatır. `await handle_message` bu nedenle agent completion veya delivery receipt değildir. Gerçek iş `_process_message_background` içindeki handler await'inde ve sonraki teslimde yürür. [S06]

Startup `_run_startup_resume_event`, adapter'ın o anda görünen session task'ını ayrıca bekler; bu, ilk hızlı dönüşün eksikliği için gerçek bir karşı mekanizmadır. Ancak base pending drain'i yeni bir task'a devir edebilir. Beklenen ilk carrier task ile gerçek agent admission'a ulaşan drain zincirinin aynı tamamlanma sınırı olup olmadığı bu tur bütün runtime üzerinde sınanmadı. Startup preclaim/busy sentinel ve source routing bu sınır için açık challenge'dır; source'dan 'her startup kilitlenir' hükmü çıkarılmadı. [S03,S06,S09]

Aynı şekilde `_fire_post_delivery_callback` generation-bound ve bounded olsa da background method'un **finally** kısmında çağrılır. Yalnız adı 'post-delivery' diye başarılı external delivery veya semantik completion kanıtı sayılmaz. Handler result, active marker cleanup, goal/loop hook, platform send ve callback farklı zamanlarda gerçekleşebilir. Bazı streamed yollar zaten teslim etmiş olabilir; bazı exception yolları olmayabilir. [S06,S07,S09]

## 11. Açık sınırlar ve bir sonraki çalışma

U05'in actual messages selector/guard kaynak engeli açıldı. Q40 history projection ve Q43 holder-write fence kaynak olarak derinleşti; Q42 startup/command/adapter bağlantıları artık salt keşif değil. **Actual SessionDB+quiet next-request, whole gateway crash/restart, full carrier/drain receipt, migration fault/profile eşitliği, model kalitesi ve external effect/delivery doğrulaması açık kalır.** L01–L07 bu kontrollerin yerine geçmez. Önceki CHECKS-NOT-RUN dosyası tarihsel plan olarak değişmeden kalır.

Default-branch search bu tur `8c74118c4a0c332a6bc57d2509147bad0e6ee864` gibi daha yeni bir ref'te restart-recoverable heartbeat/acceptance işaretlerine navigasyon verdi. Bunlar **yalnız freshness uyarısıdır**: primary bulgular güncel ürüne genellenmez, daha yeni davranışın tümü doğrulanmış sayılmaz ve pin sessizce yükseltilmez. [SOURCES]

Dar bir sonraki doğrulama sorusu, startup carrier/preclaim→drain→actual turn admission ilişkisini ve uygun actual-DB/history trace'ini tamamlamaktır. Bu güvence güçlü bir resume/restart hükmü için gereklidir; aynı registry fixture'larını çoğaltmak yerine tam kaynak/consumer sınırı kullanılmalıdır. Geniş araştırmada ise F10 cron/scheduler→run→delivery ve F05/F07/F08 provider/backend/delegation büyük açıklama boşlukları olarak kalır. Current plan, bu açık ayrımı görünür tutar; bütün fault borçlarını bitirme bahanesiyle genel HERMES'i yalnız lease'ye indirgemez. Yeni SOUL/Foundation/architecture kararı verilmez.
