# U07 — Zamanlanmış iş, çalıştırma denemesi ve teslimin ayrı kabulleri

> Bu metindeki unpublished durumu ilk U07 teslim anını kaydeder. İlerideki gerçek yayın hükmü ilgili PUBLICATION makbuzu ve güncel canonical STATE üzerinden okunur; raw deney kimlikleri bundan etkilenmez.
**2026-09-11 / PINNED SOURCE RESEARCH + BOUNDED REAL-SQLITE QUEUE DIAGNOSTIC.** Primary: `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0; güncel kurulu ürün veya son sürüm hükmü değildir. [SOURCES](SOURCES.md) bütün kaynak/okuma sınırlarını; [SPEC](SPEC.md), [RESULT](RESULT.json) ve [MANIFEST](MANIFEST.json) koşunun kimliğini taşır. **Bu U07 teslimi henüz main'e yayımlanmadı:** [PUBLICATION](PUBLICATION.md). U04-A/B, U05, U06 ve üç merkezi provisional synthesis korunur; bu yeni not bütün HERMES'in tamamlandığı anlamına gelmez.

## 1. Yetkili sorudan geniş modele geçiş

Kullanıcı U06 yayınının ardından araştırmaya açıkça devam edilmesini istedi. Başlangıç main `d928ee14b16a277c010a966816fc2c4097944aab`; STATE, v0.19 plan ve U06 kaynak/araştırma metni repo üzerinden geri okundu. Aynı konuşmada yüklü kontrol/yöntem bağlamı korundu; AGENT yeniden okundu, değişmemişti. Bu tur eski yayın paketini yeniden gönderme işi değildir.

İlk hedef U06'nın startup preclaim → adapter carrier/drain → gerçek ajan turu kabulüydü. Pinned `gateway/run_startup.py` yeniden okundu: wrapper, `handle_message` dönüşünden sonra o anda görülen session task'ını ayrıca bekler. Bu, hızlı adapter dönüşünü beklemekten daha güçlüdür; fakat takip eden bütün drain görevlerini tek bir tamamlanma makbuzuna bağladığına kanıt değildir. Ek `gateway/run.py` okuma isteği 429 ile reddedildi. İstenen aralığın aranan tüm predicate'leri içerdiği bile doğrulanmış sayılmaz. Seri retry veya engeli dolaşma yapılmadı; yeni full-host/actual-DB deney kurulmadı. **Q42 ve Q40 kapanmadı.** [U07-S01; U06/§10–11]

V0.19 planının açık erteleme kuralıyla sonraki geniş açıklama boşluğuna, F10 cron/scheduler → run → delivery hattına geçildi. Bu seçim “eksik doğrulama artık gereksiz” demek değildir. Aynı küçük lease testlerini büyütmek yerine başka bir native çalışma yolunu açıklamaktır. Araştırmanın nesnesi şimdi zamanlanmış işin saklanması, çalıştırma hakkı, deneme kaydı, dış worker devri, sonuç ve teslim arasındaki geçişlerdir. Foundation sınıflaması veya SOUL mimarisi üretilmedi.

## 2. Bir cron işi tek durum makinesinden ibaret değil

İncelenen kaynaklar, birbirini etkileyen fakat aynı kaydı paylaşmayan en az şu yüzeyleri ayırıyor:

| Native yüzey | Taşıdığı durum / sorumluluk | Tek başına göstermediği |
|---|---|---|
| Profile-local `jobs.json` | İş tanımı, schedule, enabled/paused, next run, repeat, fire/run claim ve son durum | Canlı bir dış tetikleyicinin kayıtlı olduğu; belirli denemenin başarılı olduğu |
| Scheduler provider | Ne zaman tetikleme yapılacağı; register/reconcile/fire sözleşmesi | Agent/tool işinin ve dış teslimin tamamlandığı |
| `executions.db` | Tekil execution ID, process ownership, claimed/running/terminal deneme | Aynı işin otomatik yeniden deneneceği; tüm yan etkilerin bilindiği |
| Output dosyası | O denemeden saklanan metinsel çıktı | Kullanıcıya ulaştığı veya semantik kabul aldığı |
| `deliveries.db` | Exact execution ID için pending/delivering/terminal gönderim | İşin yeniden hesaplanması gerektiği; “hata yok” dönüşünün her zaman teslim olduğu |
| Ticker heartbeat / success | Zamanlayıcı döngüsünün canlılığı ve yükselen hata olmadan bitmesi | İş kalitesi, tüm işlerin çalışması, gönderim makbuzu |

Bu ayrıştırma dosya isimlerine dayanarak önerilmiş bir tasarım değil, okunan gerçek geçişlerin açıklamasıdır. Aynı `completed` sözcüğü repeat sayacında, job state'inde ve execution ledger'da farklı yükümlülüklere bağlanır. Alan isimlerini ortak bir başarı anlamına indirgemek yanıltıcıdır. [U07-S02–S06]

### Saklama ile tetikleyici kurulumu

`create_job_with_scheduler_registration` önce `create_job` ile kaydı saklar; ardından seçili provider'ın `register_job` çağrısını yapar. İkinci adım başarısız olursa `CronSchedulerRegistrationError` işin saklandığını, scheduler kaydının başarısız olduğunu ve yeniden create yapılmaması gerektiğini ayrı alanlarla bildirir: `job_saved=True`, `scheduler_registered=False`, `retry_create=False`. Ara çıktı kaybolmamıştır; fakat henüz çalışacak tetikleyici de doğrulanmamıştır. Built-in register hook'u no-op olduğundan ayrıca çalışan ticker gerekir. [U07-S02, S04]

`CronScheduler` arayüzü tetikleyiciyi yürütmeden ayırır. Dış provider, ortak çalıştırma/teslim hattını yeniden yazmak yerine claim/fire sözleşmesini kullanır. Provider bulunamaz veya kullanılamazsa built-in'e dönüş vardır. İncelenen sürümde external provider'ın tek uzak registry'si çoklu profile durumunu temsil edemediği için multiplex kipinde built-in seçilir. Bu kaynak davranışı bütün plugin'lerin eşdeğerliği veya dağıtık scheduler güvencesi değildir. [U07-S04]

## 3. Built-in normal yol: vadesi gelmekten gerçek denemeye

`tick` önce stale-code yield, dosya kilidi, emergency-stop ve drain kapılarını değerlendirir. Vadesi gelenler okunur; recurring işlerin `next_run_at` değeri **yürütmeden önce** ileri alınır. Ardından in-process running set ile mükerrer dispatch kontrolü, durable execution kaydı ve executor submission gelir. İş gerçekten worker'da başladığında `claim_job_for_fire(..., return_job=True)` çalışır; persisted claim snapshot'ı ortak `run_one_job` yoluna aktarılır. [U07-S02]

Önceden next-run ilerletme, crash sonrası aynı occurrence'ın patlayarak yeniden çalışmasını azaltmayı hedefler. Bunun bedeli, ilerletme ile gerçek iş arasında süreç kesilirse bir occurrence'ın atlanabilmesidir. “At-most-once” yorumları bu tercihi anlatır; bütün süreç/makine/dosya sistemi/yan etki uzayında exactly-once ispatı değildir. Claim-time advance ve completion-time rearm ayrı işlemlerdir. [U07-S02, S05]

`tick(sync=False)` future'lar tamamlanmadan submission'ları iyimser olarak sayar. Provider ticker, tick çağrısı hata yükseltmeden dönünce success heartbeat yazabilir; dispatch pause kolu da `ok=True` ile bitebilir. Dolayısıyla “ticker son turda başarılı” demek “işlerin hepsi tamamlandı” değildir. Senkron kip de alt fonksiyonların boolean anlamına bağlıdır: limit nedeniyle çalıştırılmayan veya ownership kaybı nedeniyle atlanan bazı yollar `True` döner. `fire_claimed` ortak body'yi çağırıp `True` verir; bu job başarısının doğrudan vekili değildir. [U07-S02, S04]

### Bir işin birden fazla sahiplik sınırı

Profile-local store seçiminde ContextVar tabanlı override ve aktif home kullanılır. Normal jobs lock, thread RLock ile cross-process dosya kilidini birleştirir; fakat timeout/backend yokluğunda yalnız in-process kilitle devam edebilir. Buna karşılık profile+job düzeyindeki fire fence, cross-process kilidi alamazsa kapalı kalır. Aynı sistemde iki kilidin hata politikası farklıdır. “Dosya kilidi var” diyerek bütün yazıları aynı güçte güvenceye almak doğru olmaz. [U07-S05]

Her fire claim, aynı hostname/PID yeniden kullanılsa bile eski worker'ın yeni claim'i yenilememesi için yeni UUID içerir. Heartbeat ve `mark_job_run` beklenen owner ile koşullandırılır. `fire_claim_fence` seçili çıktı saklama ve teslim etkisi boyunca per-job kilidi tutabilir; unrelated işler ayrı kilit kullanır. Bu, bütün model araçlarının veya keyfi shell etkilerinin aynı kilit altında kaldığını kanıtlamaz. `_FireOwnership.lost` bazı doğrulama istisnalarında `False` dönebilir; selected output/delivery fence'in ayrı fail-closed davranışıyla birlikte okunmalıdır. [U07-S02, S05]

## 4. Sayaç neden başarı sayacı değildir?

`claim_dispatch`, yalnız finite one-shot işlerde `repeat.completed` değerini **yan etki başlamadan artırıp saklar**. Böylece defalarca çöken bir one-shot aynı bütçeyi sonsuza dek yeniden kullanmaz. Buradaki sayaç, başarılı kullanıcı sonucundan önce tüketilen dispatch hakkını da içerir. Recurring işler aynı pre-claim yoluna sahip değildir; `mark_job_run` sonrasında sayılır. Eksik job kaydıyla doğrudan verilmiş dict yolunda `claim_dispatch` True dönebilir; durable store admission'ının bütün girişlerde zorunlu olduğu varsayılmaz. [U07-S05]

Pre-claim edilmiş fakat terminal kayıt yazamamış finite one-shot, sonraki tarama/claim sırasında retire edilebilir; diagnostic çıktı üretme yolu vardır. Bu, işin başarıyla bittiği anlamına gelmez. Normal completion ile limitin tüketilip sonuç alınamaması ayrılır. Kaynakta `completed` etiketine bakmak yerine hangi transition'ın onu değiştirdiği izlenmelidir.

`mark_job_run`, son iş durumunu ve sonraki zamanı job store'da yazar; `finish_execution` execution ledger'ı ayrı işlemde terminalize eder. `mark_job_run` teslim hatasını agent hatasından ayırabilir: agent success=True iken `last_status=delivery_failed` olabilir. Buna karşılık execution terminal kararı `d.success` ile verildiğinden aynı deneme execution kaydında completed kalabilir. Bu, aynı olay için iki alanın farklı anlam taşıdığını gösteren source bağlantısıdır; bu tur iki gerçek store'u birlikte fault-test etmedik. [U07-S02, S03, S05]

## 5. Execution ledger: yeniden deneme kuyruğu değil, bilinen sonucu saklama

`executions.db`, denemeyi executor/provider dispatch'ten önce claimed olarak kaydeder. Normal `mark_execution_running`, process ID/PID eşleşmeli claimed→running geçişidir. External worker için `adopt_claimed_execution`, handoff_pending durumundaki kaydı yeni owner'a geçirip running yapar. Terminal yazı completed/failed/unknown durumunu sonradan keyfi değiştirmez; owner ve önceki statü koşulları vardır. [U07-S03]

`recover_interrupted_executions` terk edilmiş denemeyi unknown yapar, **yeniden deneme planlamaz**. Unknown, “iş kesin yapılmadı” değildir; side effect gerçekleşmiş fakat durable terminal kaydı oluşmamış olabilir. Böyle bir kaydı doğrudan retry gerekçesi yapmak mükerrer etki doğurabilir. Bu tur bu recovery'nin gerçek foreign-process doğruluğu çalıştırılmadı.

Burada kaynak yorumunu implementasyonla aynı saymamak gerekir. `_owner_is_live`, PID sorgusu istisnasında True ile muhafazakâr kalır; ancak saklanan process start zamanı yoksa yabancı PID için False, start-time probe None dönerse yine False üretebilen kolları vardır. Bu nedenle “belirsizliğin her türünde kesin ölüm kanıtı bekliyor” şeklinde evrensel garanti vermiyoruz. Alt platform PID/start-time yardımcıları ve çoklu process testi açıktır. Queue diagnostic'inde foreign-owner probe çağrılması özellikle yasaklandı. [U07-S03, S06; SPEC]

## 6. External worker devri: acknowledgement, ownership ve başarı ayrı

Managed gateway koşulunda launcher, işi gateway yaşam döngüsünden bağımsızlaştıran scoped subprocess yardımcısını kullanabilir. İncelenen yol, durable handoff_pending işaretini ve fsync edilmiş payload'ı üretir. Worker, execution kaydını başarıyla adopt etmeden ready acknowledgement yayımlamaz ve ortak run body'ye geçmez. Acknowledgement exact execution ID taşır. [U07-S02]

Acknowledgement gelmez, okunamaz veya yanlış kimlik taşırsa launcher doğrudan in-process çalıştırmaya geri dönmez. Çocuk ownership'i almış fakat ack kaydı geç kalmış olabilir; ikinci bir yürütme side effect'i çoğaltır. Bunun yerine gerçek deneme kaydı/worker sonlanması beklenir. Worker'ın terminal kaydı completed, failed veya unknown olabilir; waiter's True dönüşü hepsini aynı biçimde “izleme sona erdi” olarak kabul edebilir. [U07-S02]

Bu kaynak, yeniden başlatma sırasında **aynı hesaplamayı ikinci kez başlatmamak** için somut bir devir protokolü gösterir. Ancak atomik ownership transferi ile dosyaya ack yazımı aynı transaction değildir. Adopt başarılı, ack başarısız veya owner probe belirsiz olduğunda bütün sonlanma yolları ayrı doğrulama ister. Gerçek systemd/cgroup, process kill, credential scope, OS restart ve tool etkisi burada kurulmadı; “restart-safe” adı deneysel sonuç sayılmaz.

## 7. Teslim kuyruğunun gerçek SQLite sınaması

External worker canlı gateway adapter nesnelerine sahip olmadığından, `_deliver_result` uygun execution/environment eşleşmesinde `cron.delivery_queue.enqueue_and_wait` çağrısına gider. Exact execution ID idempotency key'dir. Queue, pending kaydı saklar; `claim_next` pending→delivering geçişini transporttan önce alır. Terminal payload'lar temizlenir; retention sırasında tam satır silinse bile tombstone aynı execution'ın yeniden gönderilmesini engellemek için tutulur. [U07-S06, S07]

Bu tur **13.837 byte'lık `cron/delivery_queue.py` dosyasının tamamı** pinned Git blob'u ile eşleştirildi ve değiştirilmeden import edildi. Gerçek Python sqlite3, gerçek geçici veritabanları ve WAL kullanıldı. Home, UTC saat, fresh-schema column check, WAL kurulum yardımcısı, sentetik metne identity redaction ve process-start etiketi açık bağımlılık dikişleridir. Transport bir recording callback'tir; actual gateway veya network değildir. Gerçek SessionDB ile karıştırılmamalıdır. [SPEC; RESULT]

Koşu UTC `2026-09-11T14:22:57.364884+00:00`–`2026-09-11T14:22:57.404381+00:00`, Python 3.13.5, SQLite 3.46.1. Altı ordinary vaka beklentileri karşılandı; bunlar ürün başarı yüzdesi değildir:

| Vaka | Gerçek gözlem | Kanıt sınırı |
|---|---|---|
| D01 | `enqueue_and_wait(timeout=0)` None döndü; DB satırı payload'ıyla pending kaldı. | Timeout=0 expired dalı seçer; 300 saniyelik zamanlama/host davranışı sınanmadı. |
| D02 | Bir recording callback original payload/failure lane ile çağrıldı; terminal delivered, payload temiz; aynı ID ile yeni payload tekrar gönderilmedi. | Callback None, gerçek dış teslim makbuzu değildir. |
| D03 | Claimed kayıt bekleme timeout'unda unknown; geç `_finish` False; yeniden claim yok. | Claim-before-send sentetik sıra; network ortasında crash yapılmadı. |
| D04 | Retention=0 ile tam terminal row yerine tombstone kaldı; aynı execution yeniden enqueue edilmedi. | Default retention kapasitesi/performance veya sınırsız depolama testi değildir. |
| D05 | Callback exception sonrası drain sayısı 1, durable status failed; ikinci drain 0. | İşlenen sayısı teslim başarısı sayısı değildir. |
| D06 | SQLite trigger terminal UPDATE'ini ABORT etti; bir callback sonrası IntegrityError, durable delivering/local active boş; gerçek recovery unknown yaptı; ikinci callback yok. | Gerçek queue SQL yazma hatası; gerçek filesystem/OS/process arızası veya SessionDB testi değil. |

D01'de yazılan callback_count=0, tüketici verilmemiş test kurulumunun açıklamasıdır; bağımsız gateway/transport instrumentation değildir. Asıl ayırıcı kanıt native dönüş değeri ile doğrudan DB snapshot'ının birlikte bulunmasıdır. D02/D05/D06 sayıları gerçekten çağrılan recording callback'ten gelir. Bu ayrım, testin kendisinin ürettiği sıfır sayısından geniş non-execution iddiası çıkarmayı engeller.

N00 değiştirilmiş source'u import öncesinde reddetti. N01 pending-timeout dönüşünü hataya çeviren mutantı D01; N02 `_finish`in delivering filtresini kaldıran mutantı D03 reddetti. Bunlar oraclenin ilgili iki davranış değişimini ayırdığını gösterir; tasarımın kullanıcı açısından ideal olduğuna veya bütün arızalara duyarlı olduğuna kanıt değildir.

İlk harness girişimi, daha vaka başlamadan `platform.platform()`ın `uname` subprocess çağrısını kendi audit guard'ının reddetmesiyle durdu. Yalnız metadata ifadesi `os.uname()` olarak değişti; source, SPEC, oracles, dependency seams ve audit guard korunarak input kimlikleri yeniden sabitlendi. Başarısız bootstrap `attempt-00/` altında saklandı. Bu bir ek HERMES behavioral run veya sonradan PASS'a çevrilmiş sonuç değildir. [HARNESS-REVISION, raw archive]

## 8. “Hata yok” hangi üst katmanda “teslim edildi”ye dönüşüyor?

Queue'da timeout anında kayıt hâlâ pending ise hiç gönderim claim edilmemiştir. `_terminalize_wait_timeout` bu kaydı gelecekteki gateway için kuyrukta bırakır ve boş hata döndürür; `enqueue_and_wait` bunu None olarak iletir. Kayıt delivering ise uncertainty nedeniyle unknown yapılır ve yeniden denenmez. **Pending deferral ile uncertain send aynı recovery kararı değildir.** D01 ve D03 bu ayrımı gerçek queue SQL'iyle gösterdi. [U07-S06; D01,D03]

Üst zincir kaynakta şöyle bağlanır: `_deliver_result` → `enqueue_and_wait` → `_save_compose_deliver` içindeki `delivery_error` → `_finish_completed_run` → `_classify_delivery_outcome`. Non-local ve çözümlenmiş bir hedef, should_deliver=True, kesinti/ownership kaybı yokluğu ve None delivery_error koşullarında classifier **delivered** döndürür; pending queue status'ünü bu classifier yeniden okumaz. Böylece **alt katmanın “ertelendi ama hata değil” sonucu üst katmanın “teslim edildi” sınıfına girebilir.** [U07-S02, S06, S07]

Bu son cümle iki kanıt türünü bilinçli olarak birleştirir: queue tarafı çalıştırılmış sonuç; üst classifier bağlantısı ise aynı pin'den okunmuş çok-modüllü koşullu çıkarım. Gerçek enclosing scheduler, job store, monitoring veya platform üzerinde bu birleşik yol çalıştırılmadı. Her UI'nin kesin yeşil gösterdiği, her mesajın kaybolduğu veya bütün sürümlerde aynı davranış olduğu iddia edilmez. Kuyrukta kalmak, gelecekte kesin gönderileceği anlamına da gelmez; bunun gerçek drainer/route/host koşulları hâlâ yük taşır.

Başka bir kabul sınırı `_confirm_adapter_delivery`de görülür: None, success alanı yokluğu ve delivered=False reddedilir; fakat success=True olup message_id/raw_response taşımayan yanıt **UNVERIFIED** uyarısıyla kabul edilebilir ve ayrı `last_delivery_unverified` kaydı tutulur. Pozitif boolean, transport kanıtı ve kullanıcıya ulaşma burada da aynı şey değildir. Bu helper yalnız kaynakla incelendi, çalıştırılmadı. [U07-S07]

## 9. Geç kalma ve tekrar sözleşmeleri

Recurring tarama, kaçırılmış bütün periyotları seri biçimde yeniden yürütmek yerine backlog'u daraltıp bir kez çalıştırma/yeniden anchor etme yoluna sahiptir. One-shot için ayrı 120 saniyelik grace uygulanır. External misfire backstop ise varsayılan 10 dakika bekleyip geç dış callback'e öncelik verir; aynı fonksiyon 120 saniyeyi aşan one-shot'ı çalıştırmaz. [U07-S04, S05]

**Koşullu kaynak çıkarımı:** bu iki varsayılan birlikte kullanılıyorsa external backstop'un one-shot için hem en az 600 saniye gecikmiş hem en çok 120 saniye gecikmiş bir kayıt bulması mümkün değildir. Bu, yalnız bu backstop'un default kapsama sınırıdır. Normal external fire, built-in due scan, explicit force ve farklı config yolları bundan dolayı yok olmaz. “One-shot hiçbir zaman çalışmaz” veya doğrulanmış scheduler bug'ı sonucu verilmez. Zamanlama/occurrence kimliği, late callback ve rearm ilişkisi sonraki yüksek-değerli kaynak sorusudur.

## 10. Karşı okuma, güncellik ve açık borçlar

En güçlü karşı açıklamalar korundu. Pending deferral hata olmadan kalabilir ve sonra gerçekten teslim edilebilir; bunu kayıp saymıyoruz. Delivered sınıfı bazı katmanlarda kabul edilmiş yükümlülüğü anlatıyor olabilir; bu nedenle dış consumer/UI kanıtı olmadan evrensel yanlış raporlama hükmü vermiyoruz. Unknown'un retry edilmemesi eksiklik kadar mükerrer etkiden kaçınan bilinçli bir tercih olabilir; hangi kullanıcı hedefinde hangisinin doğru olduğu adoption aşamasının ayrı sorusudur.

Default-branch araması `04dd80a977f40b05e5b2054111747af07a61886a` üzerinde queued/unverified alanları ve drainer çağrılarına işaret etti. Bunlar farklı snapshot'taki navigation hit'leridir: **current fix, pinned davranışın değiştiği veya aynı queue yolunun kapandığı doğrulanmadı.** Kaynak pin'i yükseltilmedi. Doküman/current search ile eski kod birleştirilip hayalî tek sürüm yapılmaz. [SOURCES]

Açık kalanlar: gerçek startup preclaim/drain/agent kabulü; actual SessionDB quiet history/final request; cron create/parse/load/save bütünlüğü; actual `run_job` içindeki script/agent/preflight/backend; gateway queue-drain launch/profile/transport; external callback occurrence/due/rearm; foreign owner identity; çoklu process/fault matrix; model kalite/oracle ve user delivery. U07 queue'nin exact byte identity'si eski Kanban selected-parent borcunu veya bu büyük modüllerin completeness'ini kapatmaz.

## 11. Sonraki bounded birim ve yayın

İlk sonraki teknik birim, **cron delivery drainer'ın gerçek gateway caller'ı ve delivery/queue/finished status tüketicileri** ile occurrence/claim/late callback bağlantısıdır. Bir normal ve bir deferred/uncertain akışta exact execution ID, job outcome, queue status ve dış makbuzun hangi yerde ayrıştığı izlenmelidir. Yeni küçük queue testlerini sırf sayı için çoğaltmak bu sınırı kapatmaz. Ardından actual `run_job`/script/agent bağlamı ve provider/backend/delegation aileleri yeniden önceliklendirilir. Q40/Q42 borçları görünür ertelemedir, sessiz kapanış değildir.

Bu çalışma yeni kaynak ve sınırlı gerçek-SQLite kanıtı üretti. **Canonical yayın üretmedi:** bağlı GitHub yüzeyi bu tur read/search eylemleri sundu; create_tree/commit/update_ref/write eylemi yoktu. Önceki U06 güvenlik engeliyle veya GitHub izin iptaliyle aynı olay sayılmadı. Yerel teslim, kimlikleri ve candidate v0.20 girişlerini korur; main'in v0.19 kaldığı ayrı okunur. Gelecek yayın mevcut main ile non-force/scoped karşılaştırma ve içerik readback gerektirir. [PUBLICATION](PUBLICATION.md)
