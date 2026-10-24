# U05 — Devam isteminden oturumda yeniden çalışabilmeye

**2026-09-11 / SOURCE-INSPECTED, PROVISIONAL.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Kaynak kapsamları](SOURCES.md), [NOT RUN kontrol tasarımı](CHECKS-NOT-RUN.md), [kısa not](../../notes/20-SESSION-LEASE-HISTORY-AND-RECOVERY.md). Bu yeni kaynak araştırmasıdır; U04 teslimini yeniden yayımlama, yeni HERMES test koşusu, ürün bug reproducer'ı veya bağımsız doğrulama değildir.

## 1. Soru ve yöntem

U04'ün bıraktığı soru, devam metninin üretilebilmesi değil, onun **hangi oturum üzerinde çalışma hakkıyla, hangi geçmişle ve hangi canlı sürücü tarafından gerçek yeni tura çevrildiği** idi. Kullanıcının bu turdaki açık devam yetkisiyle güncel main'den bootstrap/protokoller, STATE cold-start yolu, yöntem/plan, üç provisional sentez ve U04 ayrımları geri kazanıldı. Başlangıç v0.17 yayın uzlaştırmasıydı; ilk teknik hedef değişmemişti. A/B özgün dosyaları, eski sonuçlar ve syntheses/01–03 değiştirilmez.

İnceleme, facade admission'dan gerçek DB lease implementasyonuna, quiet caller ve turn prolog'a; ardından compression publication/state migration ve gateway manager/driver'a indi. Önceki alt-katman 429 engeli S01 için açıldı. Daha sonra transcript messages consumer'ının devamı S10'da 429 aldı. Böylece bazı önceki olasılıklar kaynakla ayrıldı, fakat actual DB/history projection ve full restart/worker zinciri tamamen kapanmadı.

Buradaki açıklama HERMES'in kendi nesnelerinden kurulur: Kanban task/run, session ID ve compression lineage, holder, transcript listesi, goal/loop/heartbeat state_meta, gateway watch/route/FIFO. Bunlar Foundation taxonomy'sine düğüm eklemek veya SOUL mimarisi seçmek değildir.

## 2. Normal admission: çalışma hakkının nesnesi nedir?

`TurnFacadeMixin.run_conversation`, canlı tur başlamadan review öncelik işlemini yapar, task/relay kimliklerini kurar ve `admit_durable_turn_lease` çağırır. Admission erken sonuç verirse asıl conversation loop çalıştırılmaz. Kabul edilmişse onun döndürdüğü history facade'ın history girdisinin yerini alır; relay/accounting/context scope'ları kurulur, lease başlatılır, gerçek loop'a geçilir. Düzenli ve istisnai çıkışlarda scope ve lease cleanup ayrı finally bloklarıyla dengelenir. [S01–S02]

Admission her girdiye koşulsuz durable lease uygulamaz. DB veya session ID yoksa, persistence kapalıysa, durable session henüz yoksa ya da concrete DB sınıfında acquire protokolü yoksa başlangıç history'si korunur. Yeni session'ın henüz DB'de olmayan bellek içi seed'ini reload ile silmemek burada bilinçli bir ayrımdır. Session-varlığı okuması hata verirse bu hata 'yeni/boş session' diye yorumlanmaz: lease edinme yolu denenir. Bu davranışın bütün özel runtime/shim/entrypoint'leri eşit koruduğu sonucu çıkmaz. [S01]

Mevcut durable session için holder, process PID'si, relay turn kimliği ve platformla oluşturulur. DB edinme döngüsü default olarak 300 saniyelik TTL ve 1800 saniyelik bekleme bütçesi kullanır; beklerken SQLite write lock tutulmaz. Kısa edinme denemesinde lock/busy türü persistence hatası yeniden denenebilir; başka SQL hataları aynı biçimde gizlenmez. Abort veya süre dolması durumunda 'mesaj işlenmedi' sonucu, sıfır API çağrısı ve completed=False döner. Bu bir durable continuation kuyruğuna teslim makbuzu veya kendiliğinden daha sonra yeniden çalışma sözleşmesi değildir. [S01,S03]

### Aynı ID değil, aynı compression kökü

DB lease satırının anahtarı çıplak current session ID değildir. `_session_turn_lease_key_on_conn`, compression ile bitmiş parent'ları izleyerek ortak conversation kökünü bulur; explicit fork ayrımı ve cycle kontrolü yapar. Anahtar yürüyüşü ile stale-holder silme, INSERT OR IGNORE ve ownership SELECT **aynı write transaction** içindedir. Böylece parent üzerinden çalışan bir süreç ile compression child üzerinden gelen süreç aynı konuşma hakkı için yarışır. Refresh ve release de kendi transaction'larında bu kökü çözer ve holder ile koşullandırır. [S03,S04]

Lease'nin original session ID'sini saklayıp release'te onu kullanması, refresh'te ise agent'ın güncel session ID'sine bakması bu kök eşlemesiyle anlam kazanır. Burada 'session ID değişti, eski lease başka konuşmada kaldı' diye yalnız alan adına dayalı bir hata hükmü doğru olmaz. Explicit branch/delegate/tool ayrımları ise bağımsız konuşma sınırları bakımından ayrıca önemlidir. [S01,S03]

Süresi dolan veya yerel PID'sinin gerçekten öldüğü kanıtlanan holder yeniden alınabilir. Aynı PID, yeniden kullanılmış canlı PID veya belirsiz process probe, sırf şüpheyle ölü sayılmaz. Bu conservative cleanup ve TTL, eski çalışanın bütün dış araç etkilerinin sona erdiğini kanıtlamaz. Session transcript hakkı ile Kanban kartının expected_run_id sahipliği de farklı nesnelerdir; bir session lease almak eski task-run'ın hâlâ yetkili olduğunu tek başına doğrulamaz. [S03,S04; U04 bağlamı]

### Yenileme ile ilerleme farklıdır

Admitted lease normalde periyodik olarak yenilenir; bu, model/araç işinin ilerlediğine kanıt sayılmaz. Ayrı liveness watchdog bağlanabilir. Lease refresh kaybı aktif turu hard interrupt etmeye çalışır; geç kalan refresh/watchdog'un sonraki turu kesmemesi için active/stop ve cleanup sırası vardır. Join/cancel sonrası yalnız bu lease'nin yayımladığı interruption temizlenir, holder-qualified release yapılır. Bu kaynak açıklaması gerçek thread/process/OS iptal testi değildir. [S01–S02]

## 3. History hangi koşulda yenilenir?

En önemli yeni ayrım: **lease admission her başarılı girişte DB history'sini yeniden yüklemez.**

| Yol | Admission'da history davranışı | Açık sınır |
|---|---|---|
| Durable row yok / persistence dışı yol | Çağıranın seed/history girdisi korunur. | Özel runtime ve caller kapsamı ayrı. |
| Lease ilk denemede alınır | Çağıranın history girdisi korunur; admission reload yapmaz. | Çağıranın güncellik sorumluluğu ortadan kalkmaz. |
| Başka holder için beklenip sonra alınır | `resolve_resume_session_id` çağrılır, gerekirse agent/task_context ID'si değişir; `get_messages_as_conversation(... repair_alternation=True, include_row_ids=True)` yüklenir. | Bu gerçek selector/projection gövdeleri S10 engeli nedeniyle henüz incelenmedi. |
| Admission beklemesi başarısız | Asıl turn'a girmeden early result. | Yeniden kuyruğa alma veya tüketici telafisi ayrıca gerekir. |

[S01–S02]

Beklemeli yolda reload **edinmeden sonra** yapılır; önceki holder bekleme sırasında transcript'i değiştirmiş veya session'ı döndürmüş olabilir. Immediate yolun reload'u atlaması kaynak yorumunda prompt-cache miss maliyetiyle ilişkilendirilir. Dolayısıyla önceki sentezin 'lower admission caller history'sini onarabilir' karşı açıklaması bütünüyle yanlış değildir; **koşulludur**. Artık onu bütün continuation'ları kurtaran evrensel telafi gibi kullanamayız. [S01]

### Quiet Kanban continuation: disk kaybı ile bağlam eksikliğini ayırmak

Quiet ilk query ve `_run_kanban_goal_loop_q` içindeki `_run_turn`, `cli.conversation_history` listesini `run_conversation`a verir. Dönen sonucun final_response alanını alır; `_sync_cli_session_id_from_agent` yalnız session ID'sini eşitler. İncelenen bu gövdelerde `result['messages']` ile CLI history'sinin yenilenmesi yoktur. Facade da dönen messages'ı CLI'ye yerleştirmez. [S02,S05]

Turn-context girişinde, rotation recovery history döndürmediyse, `messages = list(conversation_history) if conversation_history else []` ile ayrı **liste** kurulur ve güncel user message buna eklenir. Bu shallow-copy'dir: eski dict'lerin paylaşımı, yeni turda eklenen liste elemanlarının caller listesine otomatik eklenmesi anlamına gelmez. `_hydrate_from_history` de verilen history'den process-local state kurar; ordinary path'te genel DB reload yerine geçmez. [S06]

Buna göre kaynakla desteklenen dar karşı yol şudur: caller history H0 olarak kalır; ilk tur kendi yeni listesinde P1/A1'i üretip döndürür; quiet caller bu listeyi devralmaz; ikinci tur beklemeden kabul edilir ve rotation recovery tetiklenmezse **prolog'un liste-kurma sınırında H0 + P2** oluşur. Bir önceki turun yeni mesajlarını yalnız DB'ye yazmış olmak bu noktayı otomatik düzeltmez. Bu, belirli call-chain için açıklanmış history-propagation boşluğudur; yeni bir actual runtime reproducer değildir. [S01,S02,S05,S06]

**Buradan çıkarılmayan hükümler:** DB transcript'i silindi; bütün Hermes continuation'ları eski history kullanıyor; gateway/interactive CLI/API de aynı davranıyor; son provider wire kesin bu eksik listeyi gönderiyor; model kesin yanlış iş yapıyor. Gerçek run_conversation/SessionDB/request tüketicisiyle exact history kaydı hâlâ gerekir. Finalizer/engine/compaction varyantları yalnız test taklidiyle devre dışı bırakılıp ürün sonucu ilan edilemez. Q40'ın sorusu artık belirsiz 'history belki yenileniyor' değil, bu koşullu telafiler ve ordinary caller sorumluluğudur.

## 4. Rotation recovery, tek bir yeniden-adlandırma değildir

`build_turn_context` history'yi kopyalamadan ve turn/log kimliklerini bağlamadan `recover_rotated_compression_session`ı çağırır. Recovery history döndürürse girdinin yerini alır. İncelenen helper, compression-ended session için canlı devam ucunu çözmeye çalışır. `_adopt_live_compression_child` transitive `get_compression_tip` ile ucu bulur, canlı row'u ve boş olmayan history'yi yükler, sonra tip'i **yeniden çözerek** hâlâ aynı olduğunu kontrol eder. Ancak bundan sonra agent session ID, cached system prompt, flush markers, context-engine ve memory-manager bağlantıları değiştirilir. [S06–S07]

Burada iki selector karıştırılmamalıdır. DB'deki `find_live_compression_child` tam bir live direct child arar; fakat incelenen recovery'nin gerçek çağrısı o değil, **transitive get_compression_tip**'tir. Onun ileri yürüyüşü explicit branch/delegate/tool çocuklarını dışlar ve canonical child adayları arasında tanımlı tercih/sıralama kullanır. Recovery yorumundaki 'ambiguous lineage fails closed' ifadesi tek başına sistem çapında benzersizlik ispatı değildir; çağrılan selector'ın gerçek davranışı önemlidir. [S03,S07]

Canlı tip benimsenemezse helper kısa süre compression holder'ını kontrol ederek tekrar deneyebilir; holder yoksa orphan parent'ı yeniden açma yardımcısını çağırır. DB tarafında bu açma, compression-ended parent, canonical child yokluğu ve compression-lock koşullarını tek transaction'da denetler. Var olan continuation'ı yok sayıp gelişigüzel parent açmaz. Buna rağmen recovery hata/başarısızlığında None dönebilir. 'Hiçbir sonraki yazı eski parent'a inemez' garantisi için gerçek transcript guard/flush consumer'ı ayrıca izlenmelidir; S10'un kalan gövdesi bu tur engellendi. [S03,S07,S10]

Immediate lease yolunda bu recovery ayrı bir telafidir. Dolayısıyla 'admission beklemedi → rotation mutlaka kaçırılır' da doğru değildir. Öte yandan agent zaten current child ID'ye geçmiş ama caller history'si eskiyse, sırf aynı ID'nin kullanılması history tazeliğini kanıtlamaz. Bu ayrım exact normal/rotated trace ile yeniden sınanmalıdır.

## 5. Transcript publication ile devam-state aktarımı aynı commit değildir

`_publish_rotated_compaction` önce parent'ı/flush baseline'ı ele alır, DB `publish_compression_child` çağrısıyla child'ı yayımlar; ardından agent ID'sini yeni session'a çevirir ve `_carry_session_state_to_child` çağırır. Parent flush bazı hatalarda best-effort'tur; child publication ise kendi DB transaction sınırına sahiptir. [S07]

Gerçek DB publisher'ın `_execute_write` callback'i; lease koşulu, parent durumu, boş-olmayan handoff, child row, messages/counters, gerekli foreign-tail clone ve parent'ın compression olarak kapanmasını birlikte işler. `_execute_write` BEGIN IMMEDIATE alır, callback sonucunu commit eder, hata halinde rollback dener; belirli lock hatalarında bütçeli retry uygular. Bu, **transcript lineage yayınının transaction kapsamını** gösterir; bütün storage altyapısının veya crash settlement'ın deneysel doğrulaması değildir. [S03,S04]

Goal/heartbeat/loop aktarımı ise publication çağrısı döndükten sonra üç ayrı best-effort helper çağrısıyla yapılır. Bu helper'ların başarılı görünmesi transcript+manager+route'un tek atomik geçişi olduğu anlamına gelmez. Bu tur bu üçünün içinde **loop'un gerçek alt yolu** ayrıca kapatıldı; goal/heartbeat migration alt gövdelerinin bütünü yeniden incelenmedi. [S07–S08]

### Gerçek loop → state_meta writer bağı

`migrate_loop_to_session`: eskiyi yükle; cleared değilse ve child state yoksa child'a save; old'u clear; True dön. `save_loop`, DB yokluğunu uyarıp dönebilir; `set_meta` hatalarını `_db_op` yakalayıp default'a dönüştürür. Dönen başarı receipt'i veya child readback yoktur. `clear_loop` da ayrı load+save kullanır. [S08]

Gerçek `SessionDB.set_meta`, cursor verilmişse mevcut transaction'a katılabilir; **bu loop helper çağrısında cursor verilmez**. Normal durumda her set_meta ayrı `_write_sql` → `_execute_write` transaction'ına gider. 'Aynı DB/connection kullanılıyor' ile 'iki key tek transaction'da değişiyor' eşit değildir. Ayrıca goals'ın shared-cache bootstrap'ı üzerinden edinilen DB'nin bu çalışma anında agent DB ile aynı path/profile olduğu bu tur yürütülmedi. [S04,S08]

Bu bağlantı, önceki B:H09 reduced-adapter kaydına yeni bir **source-level gerçek-writer açıklaması** ekler: child save hatası üstte gizlenirse sonraki old clear'a geçilebilecek kontrol akışı vardır; ters yönde old clear hatası iki aktif kayıt bırakabilir. Bunlar bu tur gerçek SQLite fault injection sonucu değildir. DB IO/commit settlement belirsizliği, başka writer veya profile farklılığı daha güçlü hükümler için ayrıca ölçülmelidir. Eski B deneyi büyütülmez, bütün goal/heartbeat yollarına genellenmez. Q41 kaynak düzeyinde daraldı; migration'ın kalıcı ve kayıpsız tamamlandığı doğrulanmadı.

## 6. Restart'ta kaydı bulmak ile çalıştıracak sürücüyü kurmak

### Gateway loop: kalıcı tarama var, in-flight otomatik çözülmüş değil

İncelenen `GatewayGoalsMixin._loop_wakeup_watcher`, aktif `loop:*` kayıtlarını DB'den tarar. Route'taki platform/chat/thread gibi bilgilerden source kurar; adapter yokluğu, session busy, aktif non-parked goal ve due koşulları firing'i erteler. Yeni LoopManager state'i yeniden okur; fire_tick dönerse wakeup adapter.handle_message'a gider. Exception yolunda abandon_tick çağrılabilir; slash command loop'ları normal post-turn hook'a gitmediği için açıkça complete edilir. Normal model turu için tamamlanma başka post-turn hook'a bağlıdır. [S08–S09]

Bu kaynak, persisted loop + route'un bir driver tarafından nasıl tüketilebildiğini gösterir. **Gerçek gateway process yeniden başlatıldığında watcher'ın nasıl başlatıldığı** bu tur kapatılmadı: gateway/run_startup.py yalnız navigasyonla bulundu. Adapter/FIFO'nun gerçek kabul makbuzu da incelenmedi. Dolayısıyla kaynak taraması görmek, çalıştırılmış restart senaryosu veya her route için otomatik devam garantisi değildir.

`fire_tick`, event kabul edilmeden önce ticks_fired'i artırır, awaiting_response=True ve provisional next_due_at kaydeder. LoopState.from_json bu bayrağı korur; manager constructor sadece yükler. Hem is_due hem gateway fire_one, awaiting_response=True iken firing'i reddeder. **Saatin next_due_at'ı geçmesi bu bayrağı temizlemez.** İncelenen local zincirde 'crash oldu, belirli süre sonra kesin tekrar alınır' yolunu gösteren bir reset yoktur. [S08–S09]

Bu bayrağı complete_tick, abandon_tick, pause/resume gibi açık geçişler değiştirir. Resume aynı zamanda sonraki zamanı yeniden kurar. Normal post-turn hook, final metin boş olsa bile in-flight loop'u tamamlamaya çalışır; fakat süreç o hook'tan önce öldüyse onun çalışmış olduğu varsayılamaz. Bu, araştırılan path'in recovery sınırıdır; bütün runtime'da başka recovery yoktur veya ürün kesin kilitlenir şeklinde evrensel negatif hüküm değildir. Startup/command/adapter tüketicilerinin karşı okuması sonraki en değerli kenardır.

### Gateway heartbeat: persisted state, in-memory watch

Aynı gateway dosyasında `_register_heartbeat_watch`, quick_key → (source, session_id) eşlemesini bellek içi sözlükte tutar ve poller başlatır. Kaynak yorumunda heartbeat state'inin DB'de kaldığı, firing'in restart sonrasında kullanıcı /heartbeat'e yeniden dokununca canlandırılmasının amaçlandığı açıkça yazılıdır. Poller kendi watch listesinde adapter/busy/queue koşullarını kontrol eder, manager'dan due prompt alır ve adapter'a gönderir; finally'de active-session claim oluşmadıysa abandon_fire kullanır. [S09]

Bu **loop'un DB scan yolu ile aynı recovery sözleşmesi değildir**. Persisted heartbeat JSON tek başına canlı watch kaydını oluşturmaz. Ayrıca rotation'da yeni state key'inin yazılması, eski watch'ın yeni session ID'ye yeniden bağlandığını kanıtlamaz. Gerçek command registration/startup/rotation rebind caller'ları bu tur kapanmadı. Bu nüans 'heartbeat bozuk' değil, reactivation'ın ayrı koşul ve sahibi olduğuna ilişkin kaynak bulgusudur.

### Goal: karar, FIFO ve gerçek yeni turn

Post-turn goal yolu manager'ı actual session entry'den kurar, senkron judge'ı executor'a taşır ve devam prompt'unu adapter FIFO'ya ekler. Empty final response goal'u sürmez; loop completion yine denenir. FIFO'ya ekleme ile yeni turn'ın admission'ı, transcript flush'ı ve dış teslimi aynı olay değildir. Bunun altındaki durable turn lease, session yazı hakkını korur; üstteki semantic goal kararı veya Kanban run sahipliği için tek başına oracle değildir. [S09,S01–S03]

## 7. Karşı okuma ve iddia sınırları

1. **Eksik history bütün ürüne ait olmayabilir.** Quiet caller özel bir yol; interactive/gateway caller result history'sini devralabilir. Bekleme reload'u ve rotation recovery gerçek telafilerdir. Bu karşı yolları yok sayan genel history-loss hükmü reddedilir.
2. **Helper True'nin zayıflığı DB'nin hiçbir atomik işlemi olmadığı anlamına gelmez.** Transcript child publication somut transaction kullanır. Sorun/ayrım, hangi state kümesinin o transaction'a girdiğidir.
3. **Bekleyen tick'in scan'de atlanması tam startup araştırması değildir.** Başka consumer karşı örnek sağlayabilir. Bu yüzden restart'ın tümü kapanmadı; yalnız gözlenen state-machine kenarı açıklanmıştır.
4. **Koruma yorumları evrensel garantiler değildir.** Root lease, refresh interruption, tip revalidation ve rollback önemli mekanizmalardır. Gerçek holder-write fence gövdesi, arbitrary tool effects, API wire ve concurrency/crash settlement ayrı kanıt ister.
5. **Bu tur kanıt sayısı değil açıklama derinliği arttı.** U04'ün fake/selected koşularını çoğaltmadık; onların bıraktığı gerçek source consumer'a indik. Yeni deney yapılmadığı açık tutulur.

## 8. Sorular ve sonraki bounded frontier

**Q40:** admission kaynağı erişildi; waited/immediate/new-session ayrımı ve quiet caller→prolog history-propagation boşluğu kaynakla açıklandı. Actual DB resolve/projection ve gerçek next-request history ölçümü açık. Eski S01 kaynak erişim engeli güncel değildir; yeni engel S10 continuation'dadır.

**Q41:** actual transcript publication ile loop meta migration transaction'ları ayrıldı; real set_meta writer ve swallowed-error zinciri görüldü. Goal/heartbeat alt consumer'ları, same DB/profile binding ve actual migration fault/recovery kanıtı açık.

**Q42:** loop scan/route/in-flight bayrağı ile heartbeat in-memory watch ayrıldı. Actual startup registration, command resume, rotation watch rebind, adapter kabulü ve process-restart crash timeline açık.

**Q43:** session lease ile task-run sahipliği ayrı; lower transcript-write guard'ın kalanı source-blocked. Hard cancellation ve external-effect fencing doğrulanmadı. Q44/Q45 ve önceki sorular sessizce kapanmaz.

İlk sonraki teknik paket: **S10 selector/guard → actual quiet continuation history → gateway startup/adapter ve persisted in-flight recovery**. Yeni oturum önce current STATE ve erişimi yeniden kontrol eder; çalışırsa gerçek consumer'ları bağlar. Model/credential kullanmadan kurulabilen exact-source+actual-DB sınır testi ancak kaynak/bağımlılık kimliği yeterliyse yapılır; shim'i gerçek DB diye sunmak yoktur. [Kontrol tasarımı](CHECKS-NOT-RUN.md) yapılmış iş değildir.

Bu sınırlı birimden sonra broad F01–F12 haritası yeniden önceliklendirilir. Provider/backend/delegation, cron/scheduler, diğer UI/install/eval, learning/ledger/sync/quality kaybolmaz. Bütün güvenlik borçları bitmeden genişleme yasaklanmadı; bunun tersi olarak bu kesitten nihai CORE/dört-alan/adoption'a sıçranmaz.
