# U08 — Cron teslimini gerçek göndericiye ve durum bildirimine bağlamak

**2026-09-12 / PINNED SOURCE STUDY + BOUNDED NATIVE ASYNC-BRIDGE DIAGNOSTIC.** Araştırma tamamlanmış bir yerel kayıttır; bu dosyanın varlığı repository yayını değildir. Güncel yayın hükmü [PUBLICATION](PUBLICATION.md)'dadır. Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. Current release, kurulu ürün, gerçek kanal gönderimi veya genel güvenilirlik hükmü verilmez.

[SOURCES](SOURCES.md) / [source map](SOURCES.json), [SPEC](SPEC.md), [tam RESULT](RESULT.json), [ham arşiv ve kimlikler](MANIFEST.json), [çalıştırılmayan kontroller](CHECKS-NOT-RUN.md).

## 1. Devralınan amaç ve birimin sınırı

Başlangıç main `188095b930ac77f8d2a5dd605191a09a369a57ce` idi. STATE, U07/v0.20 ve bitmiş U07 yayınını gösteriyordu. Kullanıcı önce araştırmanın planını sordu; mevcut yöntem/sıra açıklandıktan sonra araştırmaya devam yetkisi verdi. Bu birim U07'yi yeniden yayımlama veya U07 kuyruk testlerini yeniden çalıştırma değildir. İlk hedef kayıtlı Q48/Q46'dır: kalıcı cron teslim kuyruğunu hangi gerçek gateway çağıranı boşaltıyor; elde edilen durum hangi tüketicide ne anlama geliyor?

U07, tam `cron/delivery_queue.py` üzerinde gerçek geçici SQLite ile `None` dönüşü ve hâlâ `pending` kayıt birlikteliğini sınamıştı. Ancak bu modülün gerçek gateway'e ve görünen sonuca bağlantısı eksikti. U08 bu köprüyü kaynakla açtı; gönderim yolunda görülen bir iptal varsayımını, o yolun gerçekten kullandığı tam `agent/async_utils.py` modülü ve gerçek asyncio ile sınadı. Böylece salt aynı queue senaryolarını büyütmek yerine bir sonraki consumer incelendi. [S01–S08; U07]

En önemli kapsam ayrımı: **Gerçek HERMES async köprüsü çalıştırıldı; onu çağıran bütün cron/gateway/transport zinciri çalıştırılmadı.** Sentetik coroutine içindeki dosya etkisi gerçek yerel gözlemdir, gerçek ağ tesliminin temsilcisidir; gerçek kullanıcıya iki mesaj gittiğinin kanıtı değildir. Sınırlı karşı örnek bir yanlış ayrım kuralını çürütebilir, fakat ürün çapında olay sıklığını veya bütün telafilerin yokluğunu kanıtlamaz.

## 2. Artık kaynakla birbirine bağlanan zincir

| Geçiş | Gerçek çağıran/tüketici | Bu tur sağlanan açıklama ve sınırı |
|---|---|---|
| Çalışan gateway → sürücüler | `start_gateway` → `_start_gateway_start_cron_and_housekeeping` | Başarılı `runner.start()` ve running koşulundan sonra cron ile housekeeping ayrı thread'lerde başlatılır. Startup failure/erken çıkış aynı yol değildir. [S01] |
| Housekeeping → ilgili profil | `_start_gateway_housekeeping` → `_drain_restart_safe_cron_deliveries` | Teslim kuyruğu boşaltma cron trigger'ından bağımsız bir bakım işidir; kök ve çözülen secondary profiller için scope/adapters seçilir. [S01] |
| Profil → kalıcı queue | `cron.scheduler.drain_delivery_queue` | Dosya yoksa DB yaratmadan 0 döner. Varsa gerçek `queue.drain`e `_deliver_result` callback'i verilir. [S02] |
| Queue → bir gönderim girişimi | U07 `claim_next` → callback → `_finish` | Execution ID, payload ve failure lane taşınır; claimed queue girişimi ile callback'in içindeki fiziksel send denemeleri aynı birim değildir. [S02; U07-S06] |
| Callback → live transport | `_deliver_result` → `_deliver_via_live_adapter` → `_live_send_text` | Gerçek `DeliveryRouter` coroutine'i async köprüyle gateway loop'una planlanır. Normal receipt, timeout, fallback ve mirror/seed ayrılır. [S03,S04] |
| Hesaplama/teslim özeti → job | `_finish_completed_run` → `mark_job_run` → `_record_run_outcome` | `success` ve `delivery_error` farklı girdiler; queue durumunu bilmeyen `None` girdisi başarılı hesaplama için `last_status=ok` üretebilir. [S02-reuse,S06] |
| Job + son execution → CLI | `list_jobs` → `cron_list` → `_job_rows` / `_last_run_display` | Job kaydı son execution ile birleştirilir; görülen bu yolda deliveries kaydı ayrıca okunmaz. `ok` ve execution durumu ayrı gösterilir. [S05,S06] |

Bu tablo final HERMES CORE veya yeni Foundation şeması değildir. U02–U07'nin tur, kalıcı iş ve devam açıklamasına ek bir native bağlantıdır. “Kayıt → çalıştırma → teslim” zincirindeki geçişlerin hangi farklı nesnelere bağlı olduğunu gösterir.

## 3. Kuyruğu boşaltan gerçekten kim?

`_start_gateway_start_cron_and_housekeeping`, cron provider'ını çözer ve cron scheduler thread'ini başlatır. Ardından aynı durma işaretini kullanan, fakat ayrı bir housekeeping thread'i açar. Housekeeping'e canlı adapter haritası, çalışan event loop, cron provider ve runner geçirilir. Dolayısıyla dış bir zamanlayıcı seçilmiş olması teslim kuyruğunu boşaltan periyodik işin yerini otomatik almaz. [S01]

Bu launch yolunun asıl üst çağıranı da okundu: `start_gateway`, önce `runner.start()` sonucunu ve running/erken çıkış durumlarını ele alır. Başlatma başarısızsa veya startup sırasında durma kararı verilmişse cron ve housekeeping'in başlatıldığı bölüme girmez. “Gateway nesnesi var” ile “teslim sürücüsü başladı” eşdeğer değildir. Burada kod yolu açıklanmıştır; canlı bir gateway başlatılmamıştır. [S01:5230–5395]

Housekeeping queue drain'i her tick'te çağırır; varsayılan `interval=60` döngünün işler tamamlandıktan sonraki beklemesidir. Diğer işlerin süresi, gönderimin bloklanması ve hata yolları nedeniyle bu sayı “her mesaj 60 saniye içinde teslim edilir” güvencesi değildir. Kuyruk boşaltma sırası bir gecikme üst sınırı oluşturmaz. [S01:4400–4625]

Profil seçiminin nüansı önemlidir: `None` adapter haritası atlanabilir, boş `{}` haritası ise aynı şey değildir. Kök/secondary profil scope'una girilir; adapter'sız secondary bir profil, uygun primary routes varsa `SharedRouteAdapters` üzerinden kök adapter'ı kullanabilir. Route resolver başarısızlığı veya desteklenmeyen secondary hedefin bütün davranışını bu seçili koddan kapatmıyoruz. Gerçek home/secret/terminal scope yardımcılarının varlığı, bütün çok-profille çalışma durumlarının yürütülmüş doğrulaması değildir. [S01:1530–1755,4400–4625]

Scheduler'ın drain wrapper'ı queue dosyası yoksa SQLite açmaz. Dosya varsa queue'nun `drain` işlevine verdiği callback, queued job, content ve `for_failure` değerini aynı `_deliver_result` ailesine iletir. Bu wrapper içinde job/execution'ın eski terminal özetini yeniden hesaplayan ayrı bir yazı görülmez. Callback'in başka yardımcıları veya bütün repository yazıcıları hakkında genel yokluk iddiası yapılmaz. [S02]

## 4. Normal, ertelenmiş ve belirsiz teslim farklı zaman çizgileridir

**Normal yol:** external worker sonucu kuyruğa koyar; gateway uygun profile ve route'a bağlar; queue kaydı claimed/delivering olur; callback live veya uygun standalone yolu dener; callback'in error/None sonucu queue terminal kaydına çevrilir. Worker hâlâ bekliyorsa bu terminal sonucu okuyabilir ve kendi job/execution kapanışını buna göre yapabilir. Bu birleşik yolun kaynak bağlantısı var, bu tur bütün host üzerinde koşusu yok. [S01–S03; U07]

**Ertelenmiş yol:** U07-D01'deki gibi bekleme süresi sonunda kayıt hâlâ `pending` ise worker'a hata dönmeyebilir; mesaj ilerideki gateway için kuyrukta tutulur. “Hata yok” burada “kayıt gelecekte gönderilebilir” demektir, “alıcı gördü” değildir. Bu eski deney yeniden yapılmadı. U08, işin üst sonuç sınıflamasını somut consumer'a kadar izledi: başarılı hesaplama ve boş teslim hatası `_record_run_outcome` içinde `last_status=ok` olur; CLI `_last_run_display` bunu `ok` olarak renklendirir. [U07-D01; S02-reuse,S05,S06]

Bu nedenle **normal bir başarılı hesaplama, çözülen non-local hedef ve queue deferral koşullarında**, hâlâ pending bir gönderiyle birlikte job/CLI'de başarılı son çalıştırma özeti oluşması kaynak düzeyinde açıklanabiliyor. Bu çıkarımın bütün enclosing worker, ledger, CLI ve gerçek ağ bileşimi yeni bir runtime deneyiyle gözlenmiş değildir. Tek bir `ok` metni “teslim edildi” açık iddiasına da otomatik eşitlenmez: UI ayrıca “Last run” ve “Execution” etiketlerini gösteriyor. Asıl bulgu, bu tüketicinin bekleyen queue durumunu o alanlardan yeniden kuramadığıdır.

**Belirsiz yol:** U07'de queue'nun teslim üstlenilmiş ama terminal makbuzu yazılamamış durumları `unknown` bırakıp yeniden göndermeme tercihi görüldü. U08 bu tercihin kapsamını daraltır: queue, callback'i bir kez sahiplenmiş olabilir; callback live→standalone gibi alt denemeler yapabilir. Bir queue ID'sinin tek claim'i, her alt gönderim etkisinin bir kez gerçekleştiğini kanıtlamaz. Tersine, callback başarısız sayılırken daha önce bazı dış etkiler gerçekleşmiş olabilir. [U07-D03,D06; S03]

## 5. İptal sonucu neden gönderim makbuzu değildir?

Pinned `_live_send_text`, gerçek Hermes `safe_schedule_threadsafe` yardımcı işleviyle bir `DeliveryRouter` coroutine'ini gateway loop'una verir. Yardımcı, `asyncio.run_coroutine_threadsafe` tarafından döndürülen `concurrent.futures.Future` nesnesini geçirir. Ayrı bir “transport başladı”, “karşı taraf kabul etti” veya “yan etki oluştu” kimliği eklemez. [S03,S04]

Caller `future.result(timeout=60)` sonrasında TimeoutError alırsa iki kola ayrılır:

- `future.cancel()` **True** ise kod bunu coroutine henüz dispatch edilmemiş gibi yorumlar; live lane başarısız döner, uygun native hedefte standalone fallback mümkün olur.
- **False** ise zaten in-flight olduğu varsayılır; yeniden gönderimi önlemek için teslim varsayılır ve terminal result/error yeniden okunmadan `(True, True, None)` döner. [S03]

Bu iki varsayım aynı Future nesnesinin neyi temsil ettiğini aşar. Dönen nesne sonuç/iptal köprüsüdür; underlying Task'ın daha önce hangi etkiyi gerçekleştirdiğiyle özdeş değildir. Yerel CPython source excerpt'leri de `run_coroutine_threadsafe`in Future oluşturup Task'a bağlamasını ve iptalin bağlı Task'a taşınmasını gösterir. Python belgelerindeki genel Future açıklamasını, Executor'da çalışan iş ile asyncio bridge Task'ını ayırmadan uygulamak yanlış olabilir. [S04,P01; RUNTIME-EXCERPTS]

### B02: True dönen iptal, başlamış etkiyi ortadan kaldırmadı

Gerçek Hermes köprüsüyle ikinci thread'deki gerçek asyncio loop'una bir coroutine verildi. Coroutine önce yerel dosyaya `B02` kaydını yazıp flush/fsync yaptı, sonra bir barrier işaretleyip beklemeye geçti. Test, dosyanın varlığını **iptalden önce** okuyarak ölçtü. `result(timeout=0)` gerçekten TimeoutError üretti; ardından `cancel()` **True** döndü ve coroutine iptali gözlendi. Dosyadaki etki aynen kaldı. [B02]

Bu gözlem, “bu köprüden gelen Future'da cancel=True ise coroutine/etki hiç başlamadı” önermesine somut karşı örnektir. Ölçülen `future.running()` False iken coroutine'in başlamış olması da iki çalışma durumunun aynı nesne olmadığını gösterir. Bu ek alan ölçümdür; bağımsız bir geniş ürün oracle'ı değildir.

### B03: False dönen iptal, başarıyı veya sürmekte olan gönderimi kanıtlamadı

İkinci ayırıcı durumda test önce gerçek TimeoutError aldı; ardından controlled barrier ile coroutine'in belirli RuntimeError'a düşmesini ve Future'ın terminal olmasını sağladı. Bundan sonra `cancel()` **False** döndü. Terminal hata açıkça okunabildi ve gönderimi temsil eden dosya yoktu. [B03]

Böylece False sonucu yalnız “iş sürüyor/teslim varsayılabilir” durumunun temsilcisi değildir. Timeout ile cancel çağrısı arasına hata ile bitiş girebilir. Bu deterministik karşı sıralama yarışın mümkün semantiğini ayırır; ne sıklıkta meydana geldiğini veya 60 saniyelik gerçek ağ davranışını ölçmez.

### Gerçek ürün için çıkarılabilecek ve çıkarılamayacak hüküm

Pinned caller'ın yalnız cancel boolean'ını etkilerin zamanına ilişkin ayrım kuralı olarak kullanması güvenilir değildir. Non-relay hedefte live etkisi gerçekleşmiş ama makbuz beklenirken True kolu seçilirse standalone tekrarının aynı etkiyi üretme ihtimali vardır. False kolunda terminal hata araya girerse teslimin varsayılması yanlış olabilir. **Bu koşullu kaynak/semantik bulgudur; gerçek platformda çift gönderim, kullanıcı zararı veya bütün HERMES sürümlerinin hatalı olduğu gözlenmedi.**

Relay hedefler standalone fallback'i ayrıca reddediyor; transport'un kendi idempotency koruması, route özellikleri ve gerçek send primitive'inin iptal davranışı ayrıca araştırılmalı. Bu telafilerin var olabilmesi karşı örneği geçersiz kılmaz; ürün sonucu hakkında genellemeyi sınırlar. HERMES upstream'inde düzeltme uygulanmadı veya güvenlik açığı yayını yapılmadı. [S03; B01–B03]

## 6. Teslimi varsaymak sonraki konuşmayı da etkileyebilir

`_deliver_via_live_adapter`, `adapter_ok` True olduğunda teslim log'u yazar ve `_seed_live_delivery_sessions` çağırır. `timed_out=True` durumunda medya atlanıp hata kaydı eklenebilir, fakat aynı flag seeding çağrısını kendiliğinden durdurmaz. Bu nedenle kodun “teslim varsayıldı” kararı, yalnız log metni değil, sonraki konuşmada brief'i görünür kılmayı amaçlayan seed/mirror geçişine de taşınabilir. [S03]

Seed helper'larının gerçek veritabanı yazıları ve başarısızlık telafisi bu tur incelenmiş/çalıştırılmış bütünlük değildir. “Görülmemiş brief kesin olarak konuşmaya kaydediliyor” gibi güçlü bir runtime sonucu çıkarılmadı. Bulgu yalnız bu caller'ın seeding denemesini hangi kabul koşuluna bağladığını gösterir.

Normal `SendResult` da kendi başına tek seviye değildir: None veya success alanı olmayan sonuç reddedilir; `delivered=False` filtre yanıtı success=True olsa bile reddedilir. Ancak message ID/raw response içermeyen bare success kabul edilip UNVERIFIED işaretlenebilir. Bu işaretin CLI'de gösterildiği ayrıca görüldü. Timeout'ta varsayılan başarı, bare-success unverified ve güçlü taşıma makbuzu aynı kanıt statüsü değildir. [S03-reuse,S05]

## 7. Çalıştırılan diagnostic'in doğrulama kapsamı

Tam `agent/async_utils.py`, 2.049 byte, Git blob `2bc558fad21eeec736c0283cb7df86304349f222` eşleştirilerek import edildi. Kaynak transkripsiyonundan seçilmiş bağımsız helper gövdesi değil, tam byte-eşit modüldür. Bu bütün üst parent'ların byte-eşitliğini veya eski manuel Kanban seçkilerinin sadakatini doğrulamaz. [S04]

SPEC ve INPUTS hash'leri koşudan önce sabitlendi. B01 normal receipt ve dosya etkisi; B02 effect-before-cancel; B03 timeout-to-terminal-error ayrımları tek recorded run'da sınandı. Test doğru beklentiyi sonucu gördükten sonra değiştirmedi. `result(timeout=0)` ölçüm hızlandırması açıkça belirtilmiştir; event barrier, ilgili nedensel sırayı belirler. Sentetik transport callback'i gerçek dosya etkisi üretir; ağ mesajı üretmez.

N00 değişmiş kaynak byte'ını import öncesinde reddetti. N01 ve N02, fabricated yanlış gözlem kayıtlarını observation validator'a vererek ilgili eksik kanıtın reddedildiğini gösterdi. **Bunlar HERMES source mutation testleri değildir.** Aynı araştırmacı tarafından tasarlanmış bir kayıt doğrulayıcısının dar hata duyarlılığıdır; bağımsız replication veya geniş hata dağılımını kapsama iddiası taşımaz. [SPEC,RESULT]

Ağ bağlantısı, adres çözümü, socket bind ve subprocess audit olayları yasaklandı; forbidden-event listesi boş kaldı. Event loop'un yerel socketpair kullanımı ağ gönderimi diye sayılmadı. Loop thread'i finally içinde durduruldu/join edildi, loop kapatıldı. Probe stderr dosyası sıfır byte; üç vaka expectation_met. Runtime tarihleri değiştirilmeden saklandı: UTC `2026-09-11T21:12:38.167078+00:00`–`2026-09-11T21:12:38.171479+00:00`, Europe/Istanbul karşılığı 12 Eylül. [RESULT]

## 8. Upstream test karşı okuması ve alternatif açıklamalar

`tests/gateway/test_cron_delivery_housekeeping.py` tam okundu, çalıştırılmadı. Testler queue drain fonksiyonunu ve bazı profil yardımcılarını değiştirerek doğru adapter/route değerleriyle çağrılıp çağrılmadığını denetliyor. Bu, routing bağlantısı için anlamlı test kodudur. Fakat gerçek transport receipt'i, send cancellation semantiği veya job/queue durumu uzlaştırması bu testin oracle'ı değildir. Bütün upstream suite'in aynı açığı taşıdığı veya başka bir test bulunmadığı söylenmez. [S07]

Rakip açıklamalar korundu: live transport hiç etki üretmeden iptal edilebilir; normal receipt başarıya yeterli olabilir; platform idempotency'si duplicate riskini daraltabilir; son job bilgisi başka bir run tarafından değişebilir; queue geç de olsa başarıyla teslim edilebilir. Bu nedenle pending+ok görünümü otomatik mesaj kaybı değildir ve cancellation karşı örneği otomatik gerçek çift gönderim değildir. Ancak hangi kanıtın hangi hükmü taşıdığı ayrımı bu alternatiflerin hepsinde gereklidir.

## 9. Araştırma planına etkisi

Q48'in drainer/launch/profile/CLI bağlantısı artık yalnız keşif pointer'ı değildir; kaynak düzeyinde açıklanmıştır. Q46'nın compute/queue/receipt ayrımı kullanıcıya görünen tek CLI tüketicisine bağlandı. Yeni Q50, iptal boolean'ının transport-effect aşaması yerine kullanılmasının sınırını kaydeder. Q40/Q42'nin eski actual-DB/whole-startup borçları bu karşı örnekle kapatılmadı.

Bu dar birimin açıklama hedefi karşılandı, **bütün runtime güvence hedefi karşılanmadı**. Aynı iptal veya queue senaryolarını sonsuza dek çoğaltmak yerine kayıtlı geniş sıra ilerletilir: Q47 scheduled occurrence/late callback/claim/rearm; ardından Q49 run_job script/no_agent/agent/context. Q48/Q50 gerçek transport ve status uzlaştırma deneyleri, tam ilgili kaynak/bağımlılık ve yetki sağlandığında veya güçlü reliability/adoption hükmü gerektiğinde yeniden açılır. Erteleme kapanış değildir.

Üç merkezi synthesis değişmedi. Yeni derived çalışma haritası, ayrıntı ile büyük resim arasındaki görünürlüğü destekler; STATE'in otoritesini ele geçirmez. Nihai HERMES CORE, dört-alan projeksiyonu, Foundation veya Development OS mimarisi bu tur üretilmedi.

## 10. Yayın ve erişim durumu

Bu tur connector source okumaları çalıştı. İlk create_tree ve sonraki create sorguları boş döndü; full GitHub discovery 48 read/search aracı sundu. update_file sorgusu benzer isimli read eylemlerini verdi, gerçek mutation eylemi sunmadı. Plugin directory GitHub'ı installed/enabled gösterdi. Bunun repository izninin iptali olduğu veya önceki tool safety block'unun tekrarı olduğu teşhis edilmedi. İzin/ayar/credential değişmedi; read endpoint'lerine write semantiği yüklenmedi.

Main'e yazma/commit/ref işlemi gerçekleşmedikçe bu U08 dosyaları yerel yayın adayıdır. Özgün U07 yayını tamamdır ve yeniden yapılacak iş değildir. Başlangıç/final ref, candidate dosya kimlikleri, scoped farklar ve gerçek erişim sınırı [PUBLICATION](PUBLICATION.md) ile teslim paketinde saklanır. Yerel hash/readback, remote yayın veya yeni davranış doğrulaması değildir.

Son yayın kontrolü: main `a6c47ef3ff697c2d23c492dcf4ccfa32003040da` oldu; native compare yalnız Foundation yollarını değiştirdi, HERMES STATE yeni ref'te yine U07/v0.20 ve aynı blob. U08 için write gerçekleşmedi. Bu head farkı araştırmanın pinned upstream kaynağını değiştirmez.
