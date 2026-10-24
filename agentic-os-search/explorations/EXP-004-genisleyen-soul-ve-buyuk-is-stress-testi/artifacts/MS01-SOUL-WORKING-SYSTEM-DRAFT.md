# MS01 — SOUL Çalışma Sistemi Taslağı v0.1

**2026-09-21 / Checkpoint B / PROVISIONAL MECHANISM DRAFT — REVIEW READY.** İlk yapı, iki senaryonun kurgusal yürüyüşü ve sınırlı birleşim değerlendirmesi tamamlanmış taslak olarak sunulur. Bu; kabul edilmiş mimari, gerçekleştirilmiş SOUL, çalıştırılmış simülasyon veya canlı model/okur/öğrenci yeterliği değildir. EXP-004'ün kullanıcı değerlendirmesi ve mimari/implementasyon kararları ayrıdır.

**Bu checkpoint'in başlangıcı:** `a0f3ab5f450b28d908a5a89d15a626637e322bfe`. Kullanıcının «peki izliyorum ve okuyorum seni. devam et.» yönü, roman yürüyüşüyle aynı taslağı geliştirme ve birleşim değerlendirmesine devam eder. Yazma yalnız EXP-004'tedir. Önceki [Checkpoint A taslağı](https://github.com/batuhanozgun/agentic-os-search/blob/a0f3ab5f450b28d908a5a89d15a626637e322bfe/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md) tam olarak Git'te korunur; aşağıdaki yeniden düzenleme önceki kaynak veya araştırmayı değiştirmez.

**Birlikte okunacaklar:** [Soru-bankası yürüyüşü — A](MS01-QUESTION-BANK-WALKTHROUGH.md), [roman yürüyüşü — B](MS01-NOVEL-WALKTHROUGH.md), [kapsama, birleşim ve kaynak defteri](MS01-COVERAGE-AND-OPEN-MECHANISMS.md). [RV01](../reflections/RV01-DIRECTION-REVIEW-AND-MECHANISM-TARGET.md) taslakla kapanış hedefini; [SY01](SY01-CROSS-SCENARIO-WORK-SYSTEM-SYNTHESIS.md) sorumluluk zeminini taşır. Bank dosyasının romanı sonraki iş gösteren ifadeleri Checkpoint A tarihidir, bugünkü kuyruk değildir.

## 1. Taslağın seçtiği düzen

**P1 — Hibrit gerçekleştirme.** Model; amaç yorumunu, keşfi, yöntem ve kaynak seçimini, alan üretimini ve anlamsal değerlendirmeyi yapar. Host Runtime; model/araç çağrısını, aktör kimliğini, verilmiş izinleri, kayıt sürümlerini, kaynak ayırmasını ve tanımlı durum/etki sınırlarını kodla işletir. Salt prompt sistemi veya bütün olası işi baştan kilitleyen statik workflow seçilmedi. Host kontrolü anlamsal doğruluğun yerine geçmez; insan katkısı ancak gerçekten mevcut rol ve yetkisiyle plana girer.

**P2 — Mission başına tek mantıksal commit yolu.** Paralel aktörler candidate çıktı ve karar önerisi üretebilir. Ortak current state'e geçiş ise tek mantıksal commit sınırında uzlaştırılır. Bu tek LLM, tek owner, tek makine veya seri üretim zorunluluğu değildir. Farklı aktörlerin yetkili kararları aynı kurulum yolundan geçebilir. Çok-yazarlı federatif düzen alternatif olarak kalır; bu ilk taslakta bağımsız ortak yazımlar yerine açık uzlaştırma seçildi. Darboğaz, failover ve cross-mission kaynak ortaklığı G03/G05'te açıktır.

**P3 — Birlikte uygulanabilir konfigürasyon.** Aktör, yöntem, kaynak ve araç ayrı ayrı mevcut diye bir Work hazır sayılmaz. Bunların aynı izinli çalışma yolunda birleşmesi gerekir.

**P4 — Başlatma, sonuç kabulü ve etki ayrı sınırlar.** Start kontrolü bütün sonraki etkiler için açık çek değildir. İş sürerken dayanak değişebilir.

**P5 — Yöntem kütüphanesi ile etkin yöntem ayrı.** Retrieve edilmiş ders, kaynağa bağlı adaydır. Belirli Work için seçimi veya ortak baz davranışa geçişi ayrıca yetkili seçim/değişikliktir.

B'deki ek tercihler: **P6** Work kipi/etkisine bağlı giriş; **P7** bileşik eser kimliği ve tasarım/uygulama/teslim ayrımı; **P8** kaynak-bağlı, süren okuma/inceleme; **P9** tekil yöntem değil birlikte işleyen konfigürasyonun değerlendirilmesi. Ayrıntılar aşağıdadır.

## 2. İlk işi kim başlatır? Baz SOUL

| Başlangıç taşıyıcısı | İlk görevde yaptığı iş | Önceden sağlanması gereken sınır |
|---|---|---|
| **Host Runtime** | Kullanıcı girdisi, model/araç çağrısı, kayıt işlemleri ve yeniden giriş olayını işletir. | Çalışan host ve gerçek kontrol yolları; talimat bunları yoktan kurmaz. |
| **Bootstrap Actor B0** | Genel amaçlı modelin ilk çalışma rolü; talebi yorumlar, sınırlı kaynak incelemesi ve ilk Work önerisini üretir. | Genel model kabiliyeti bütün alanlarda uzmanlık veya ipucusuz keşif garantisi değildir. |
| **Working State erişimi** | Mission, Work, kaynak, Run ve kararları kimlik/sürümle korur. | İzinli kalıcılık, gerekli atomik yerel geçiş ve gerçek geri okuma imkânı. |
| **Başlangıç yöntemleri ve araç bağları** | Amaç oluşturma, izinli kaynak edinme, soru açma, sonuç bildirme ve yeniden giriş için sınırlı yöntemler. | Katalogda bulunma, erişim/çalışırlık değildir. |
| **Owner/Operator yetkisi** | Keşif kapsamı, bütçe, değiştirilemez sınırlar ve karar delegasyonu. | Amaç sahibi gizli teknik işçi yapılmaz; verilmemiş yetki B0 tarafından üretilemez. |

İlk Mission-formation Work'ü henüz bulunmayan Mission Contract'tan değil **başlangıç yetkisinden** başlar. Bu yetki taslak ve sınırlı incelemeye izin verebilir; yayın, yeni hesap/credential veya ortak politika değişimine izin vermeyebilir. Gerekli erişim/kapasite yoksa ilgili iş `unavailable` kalır; hayalî aktör planlanmaz.

Bu bazın geliştirilmesi gelecekte Development OS'un işi olacaktır. SOUL'un bütün bazını aynı kullanıcı mission'ı içinde zaten hazırmış gibi varsayıp sonsuz bootstrap döngüsü kurmuyoruz. B0'ın başlangıç muhakemesi G01/G04'te ayrıca sınanacak kapasitedir.

## 3. İşe özgü genişleme: Working Configuration

Bir mission, bazın üzerinde rol örnekleri, yöntem sürümleri, araç bağlantıları, kaynaklar, değerlendirme Work'leri ve karar/etki sınırlarından oluşan **Working Configuration** kurar. B0 başlangıçta birden çok rolü taşıyabilir; yeni katılım ancak ihtiyaç ve yeterlik dayanağıyla bağlanır.

Yeni rol = talimat + gerçek model/insan/program taşıyıcısı + uygun context + araç/etki kapsamı + ilgili yeterlik dayanağı. Rol adı model eğitimi değildir. Yeni araç/yöntem katılırken K3 context, K6 etki/kabul ve K7 recovery yollarının kapsamı da genişler; sadece registry satırı eklenmez. Gerekli kapsam sağlanamıyorsa etkiyle devreye alınmaz, izinli inceleme kullanımı ayrı kalabilir.

İş bittiğinde rol kapanabilir; Work ve gerekli kanıt/geçmiş silinmez. Yerel ders baz davranışına otomatik geçmez. Mevcut yeterli yöntem varsa yeni parça eklememek veya iki aynı işlevi birleştirmek geçerli sonuçtur.

## 4. Ortak kayıtlar ve türleri

Bunlar yerel taslak adlarıdır, zorunlu ayrı tablolar/dosyalar veya Concepts tanımları değildir. Karar gerekçesi görünür dayanak özeti taşır, özel model düşünce dökümü değildir.

| Kayıt | Taşıdığı içerik ve yazma yolu |
|---|---|
| **Mission Contract** | Kaynak amaç, yorum, kapsam, kabul şartları, delegasyon; K1 önerir, yetkili karar etkinleştirir. |
| **Work Model / Work** | İhtiyaç, yöntem, açık soru, iş, başlangıç/kapanış şartları, sorumlu, kaynak ve `return_to`; K1/K2 önerir, K6 yetkili geçişleri kaydeder. Plan yaşayan bir görünüm, yürütme değil. |
| **Artifact / Source Record** | Asıl içerik/konum, kimlik/sürüm, kaynak türü, zaman, erişim ve candidate/current/withdrawn gibi kapsamlı statü; özet source değildir. |
| **Qualification Case — QC** | İddia, nesne/sürüm/birleşim, kullanım, ölçüt, yöntem, kanıt, inceleyen ve belirsizlik; K5 değerlendirir. QC geçerliliği ile yetkili kabul ayrıdır. |
| **Decision / Authority Grant** | Karar sahibi, scope, hedef, dayanak, delegasyon ve yeniden açma koşulu; modelin «onaylandı» cümlesi grant yaratmaz. |
| **Run / Effect Record** | Work denemesi, claim dönemi, aktör, başlangıç basis'i, fiilen sunulan context, işlem/etki kimliği ve gözlenen/bilinmeyen sonuç. Run dönmesi Work kabulü değildir. |
| **Context Package** | İş sorusu, aktör, yöntem, kaynak/sürüm/statü ve eksik kapsam; gerçek model isteği/ek okumalar Run'a bağlanır. |
| **Method Entry / Working Configuration** | Kaynağa bağlı yöntem adayı ve uygunluk/uygunsuzluk koşulu; ayrıca belirli işte seçilmiş etkin bileşim. Library etkin talimat değildir. |
| **Change Proposal / Event Journal** | Önerilen değişiklik, karar, kurulum ve geçiş kaynağı; günlük bütün gerçek dünyanın eksiksiz tarihi veya zorunlu event-sourcing seçimi değildir. |

Bilinen `requires`, `uses`, `supports`, `supersedes`, `discovered_from`, `return_to` ilişkilerinin rolleri farklıdır. Keşfedilen işin kökeni, onun önceki işi otomatik engellediği anlamına gelmez. Bilinen graf, bilinmeyen ilişkiyi keşfetmiş sayılmaz.

### B'de eklenen bileşik ve alana özgü görünümler

**Assembly Snapshot**, sıralı parça/revision'ları, bağlı tasarım ve bilinen eksikleriyle bileşik Artifact'tır. Sadece her dosyanın `latest` sürümünü toplamaz. QC ve teslim belirli bir birleşimi hedefler. **Design Baseline**, seçilmiş amaç/tasarım kararlarını; **Delivery Baseline**, teslim için kabul edilmiş birleşimi gösterir. Aralarındaki revizyon işleri açık kalabilir; tek `current` bayrağı hepsinin aynı olduğunu iddia etmez.

Romanda **Narrative Ledger**, olay dünyası, karakter inancı, anlatıcı ifadesi, kaynak metin ve planlanan ilişkiyi kaynak/zaman/sürümle ayıran seçici görünüm; **Scene Brief**, Work/Context'in alan biçimi; **Reading Pass**, sıralı okuma konumu, kaynak kapsamı, görünür gözlem/yorum ve açık soruların devam kaydı; **Revision Package**, Change Proposal'ın etkilenen ve korunacak içerikle ayrıntısıdır. Bunlar ek servis veya her cümleyi formal graph'a çevirme talebi değildir.

## 5. Çalışan parçalar: K1–K7

### K1 — Mission Interpreter / Discovery Driver

**Tetik/girdi:** yeni talep, maddi bulgu veya amaç–sonuç itirazı; kaynak amaç, mevcut Work Model, ilgili alan kaynakları ve gerçek kullanım koşulları. **Taşıyıcı:** B0/araştırma rolü ve model muhakemesi.

Amaçlanan sonuca hangi üretim/kullanım adımlarıyla gidileceğini kurar; bu açıklamadaki desteksiz koşulları araştırılacak soruya çevirir. Sonuç `need candidate`, inquiry Work, frame-change proposal veya gerekçeli no-change olabilir. Inquiry; hangi kararı beslediği, neyin o kararı değiştireceği, izinli kaynak yolu ve dönüş noktasıyla kurulur. Kaynak yeni bir soru da açabilir; mevcut anahtar sözcükler keşfin sınırı yapılmaz.

Yetkisi inceleme/öneri scope'udur; kullanıcı amacını kendisi değiştiremez. Yanlış çerçeve, yetersiz alan bilgisi ve ortak körlük K5 incelemesi/alternatif kaynakla zorlanır. Bunlar G01'in güvenilir keşif kapasitesini otomatik çözmez.

### K2 — Work Coordinator

**Tetik/girdi:** Work sonucu, karar/kaynak/kapasite değişimi veya re-entry; Work Model, açıklar, kaynak ve teslimat koşulları. **Taşıyıcı:** aday çıkaran kod + öncelik/yöntem muhakemesi.

Open, blocked ve koşullu frontier'ı ayırır. K4 ve K3 ile aynı aktör-bilgi-ortam-yetki yolunda hazırlanabilen işi seçer. Öncelik sonraki anlamlı teslimat, kritik bağımlılık, inquiry'nin karar katkısı ve gerçek maliyetle gerekçelendirilir; tek uydurma utility puanı yoktur. K6, revision/claim/rezervasyonu korunan yerel geçişte denetler. Paylaşılan rezervasyonlar mission sınırını aşıyorsa gerçek ortak otorite gerekir; burada varsayılmaz.

Keşif sonucu `return_to` kararına döner. Açık soru yalnız gerçekten etkilediği karar/etkiyi engeller. Uygun bağımsız dilim ancak kapsam/yetki ve ortak kaynak şartlarıyla ilerler. Sonsuz keşif, aç kalma ve ucuz işlerin asıl teslimatı ertelemesi G05'tir. Tamamlandı statüsü kullanıcı amacının gerçekleşmesi değildir.

### K3 — Context Builder

**Tetik/girdi:** çağrı kurma, yeni inceleme sorusu veya devam; Work sorusu, mode, aktör, yöntem ve kaynak/sürüm bağları. **Taşıyıcı:** erişim/kesit araçları + model seçimi.

İlgili amaç, gerçek kaynak, yakın asıl içerik ve önceki kayıtları kullanım için birleştirir. Kimlik/erişim/sürüm mekanik denetlenir; içeriğin yeterliği model/alan incelemesidir. Özet ilişkiyi taşımıyorsa asıl pasajları ve gerekli çevreyi getirir. Seçilen kaynak listesi ile fiilen sunulan context ayrı bağlanır. İçeriğin görünmesi anlama değildir.

Uzun eserde Reading Pass kaynak boyunca ilerler; konum/kapsam ve kaynak-bağlı açık sorular tutulur. Bir soruda önceki–sonraki ilgili pasajlar birlikte getirilir. Geniş edebî hüküm seçilmiş alıntı toplamından çıkarılmaz. Plan-aware ve text-grounded kipler farklı görünüm kurar. Önce finali görmüş aktöre «unut» demek izolasyon değildir; host bellek/araç yollarının uygun scope'u gerekir. G02/G04 açık kalır.

### K4 — Capability Binder / Method Selector

**Tetik/girdi:** yeni Work, beceri/araç açığı veya yöntem çatışması; gerçek capability erişimi, yöntem kataloğu, yeterlik kanıtı ve grant. **Taşıyıcı:** registry + muhakeme + host erişim kontrolleri.

Mevcut aktör, başka yöntem, araç desteği veya gerçekten mevcut insan katkısını karşılaştırır. Seçim gerekçesi ve sınırı Working Configuration'a bağlanır. Yeterlik zayıfsa gerekli küçük qualification Work'ü açılır: fiilî uygulama ve iddiaya uygun ayrı değerlendirme; salt skill yükleme sayısı değil. Tek küçük başarı geniş uzmanlık değildir. Uygulanabilir bileşim yoksa bağımlı etki bekler; kullanıcıya yalnız gerekli seçenek/maliyet/yetki kararı taşınır.

Çelişen yöntemlerde önce amaç/kullanım/sürüm ayrımı yapılır. Bir görevde anlamlı olan yöntemi başka görevde kullanmamak geçerlidir. Gerçek ortak çatışmada geçerli yükümlülük korunur; değişiklik yetkili scope'ta önerilir. Örneğin devir notunu kısaltma, karar-kritik statüyü silme izni değildir; kısa source locator + statüyle taşıma denenebilir. Eşdeğer kontroller ancak gerekli işlevin kaybolmadığı gerekçeyle birleştirilir. G06, hem doğru uygulama hem doğru seçme/kullanmama ve birlikte etki yükünü taşır.

### K5 — Domain Workbench

**Tetik/girdi:** atanmış üretim, araştırma, inceleme, revizyon veya bütünleştirme Work'ü; seçilmiş yöntem, domain context ve exact çalışma nesnesi. **Taşıyıcı:** bağlanmış model/insan/program ve alan yöntemi.

Bankada soru/çözüm üretimi, hazır çözüm verilmeden yeniden çözme, hesap kontrolü, dil/uygunluk incelemesi ve program bütünleştirmesi farklı işlerdir. Hesap aracı pedagojik oracle değildir. Romanda yaşayan plan ve sahne brief'iyle prose üretimi, kaynak boyunca okuma, bilgi/karakter ilişkisini değerlendirme, gerekçeli alternatif yazım ve bütünsel editoryal inceleme vardır. Alan yöntemi bankadan aynen kopyalanmaz.

Çıktıları Artifact candidate, QC, sorun/yeni inquiry veya `need more context` olabilir. Prose'da beliren fikir otomatik kanon değildir; plan sapması izinli yeni yaratıcı aday veya gerçek ihlal olabilir. Seçimi kaynak amaç ve yetkiyle ayırır. Gerekli yerlerde kalite, tutarlılık, amaç ve tercih farklı iddialardır; başka rol/model adı bağımsızlık değildir.

Bütünleştirme Work'ü exact Assembly Snapshot'a bakar. Yerel QC'ler kullanılır fakat bütünün ilişkileri, eksikleri ve etkileşimleri ayrıca incelenir. Eleştirinin kaygısı ile önerilen patch ayrıdır. Verilmiş yaratıcı takdirde gerekçeli seçim yapılabilir; evrensel estetik skor veya zorunlu oybirliği yoktur. Gerçek okur/öğrenci etkisi gerekiyorsa uygun ayrı kanıt gerekir; model rol oyunu bu kanıtı yaratmaz.

### K6 — Run Controller / State Committer / Effect Broker

**Tetik/girdi:** start, effect, result-admission ve ortak karar/kurulum; host-bound aktör kimliği, grant, Work mode/revision, claim dönemi, context/konfigürasyon ve ilgili basis. **Taşıyıcı:** host kodu; anlam incelemesi K5'te kalır.

| Kontrol noktası | Çağıran ve yapılan iş | Ret/bekleme veya başarı sonucu |
|---|---|---|
| `before_work_start` | Dispatcher; Work kipine uygun yetki/bilgi/aktör/rezervasyon ve revision denetimi. | Claim + Run veya gerekçeli ret. Keşif, nihai ürün QC'si eksik diye otomatik bloklanmaz. |
| `before_effect` | Araç adaptörü; exact hedef/işlem/payload, grant ve gerekli karar/QC. | Tam bu etkiyi geçir veya çağırma. Dış etki öncesi niyet/operation kimliği kaydedilir. |
| `before_result_admission` | Sonuç yolu; Run basis'i, candidate artifact/QC, amaç ve birleşim. | Candidate korunur; current/committed kullanım için uygun karar ve güncellik yoksa yeniden inceleme. |
| `after_state_change` | Başarılı yerel State Committer; değişen kimlikler ve geçiş. | İlgili readiness/context/QC kullanımlarını yeniden incelemeye işaretle. |
| `on_resume` | Host re-entry/liveness olayı. | K7 uzlaştırması; bilinmeyen etkili işi kör yeniden dispatch etme. |

Hook adları hosttan bağımsız taslak etiketleridir. Hook mekanizmayı çağırır; modelin anlamsal hükmünü doğru yapmaz. Her token/sözcükte global onay yoktur: izinli yerel draft işlemleri paketlenebilir. Ortak kabul, erişim genişletme ve haricî etkilerin kontrol yolunu atlamaması gerçek host mühendisliğinin G03 yüküdür.

Worker doğrudan ortak yazma/yayın credential'ı taşıyıp bu yolu aşabiliyorsa broker yaptırım değildir. Dolaylı araç zincirleri de admission'da incelenir. Model serbest metinle kendi kimliğini veya grant'ini genişletemez. Rol atamak yetki üstlenmek değildir.

Yerel yazım ve guard aynı korunan işlemde düşünülür. Kontrol yalnız yazılan nesnenin revision'ı değil, maddi karar/kaynak bağımlılıkları ve gerektiğinde assembly'dir. Her metin değişiminde bütün QC'ler kör iptal edilmez; kapsamı uygun bağımsız destek korunabilir, anlamsal uyumluluk bilinmiyorsa yeniden inceleme gerekir.

Dış sistemle tek atomik işlem yoktur. Sağlanabiliyorsa operation identity, koşullu/idempotent çağrı ve hedef readback kullanılır. Timeout `effect unknown`dur; başarısızlık veya etkisizlik diye kesinlenmez. Sağlayıcı bu destekleri vermiyorsa tekrar ve etki sınırı daraltılır. Yerel exactly-once kayıt veya claim, haricî exactly-once etki garantisi değildir.

### K7 — Change & Recovery Manager

**Tetik/girdi:** kaynak, kriter, yöntem veya tasarım değişimi; itiraz, kayıp aktör ve re-entry; kayıtlı basis, history, claim ve gerçek ortam gözlemi. **Taşıyıcı:** kayıt araçları + etkiyi inceleyen model/rol + K6.

Bilinen destek/kullanım bağlarını takip edip etki adaylarını işaretler. K1/K5, kaydedilmemiş ilişki ve yeni Work'leri kaynakla araştırır; graph traversal eksiksiz keşif değildir. Destek çekilmesi ters sonucun kabulü değildir; alternatif geçerli destek ve eski doğru materyal korunur. Eski türetilmiş sonuç başka özette bağımsız öncül olarak geri dönmemelidir.

Revision Package, temel birleşim, hedef tasarım, etkilenen/korunan parçalar, yeni işler ve yeniden QC kapsamını bağlar. Yeni yön seçimi metni değiştirmez. Current tasarım ilerlerken manuscript revizyonu açık kalabilir; teslim başka exact baseline'a bağlıdır. Yeni adayın onaysız olması, zedelenmiş eski güvenceyi düzeltmez; ilgili etki bekletilebilir, diğer yararlı işler kaynak sınırlarıyla sürebilir.

Eski Run'ların bazıları bağlı eski konfigürasyonda sınırlı bitebilir, bazıları yeniden bağlanır veya durdurulur; geç sonuçlar K6'da uzlaştırılır. Recovery'de yeni B0 canonical Mission/Work/Run/karar, pending işler ve etki kaydına döner. Liveness kaybı etkisizlik kanıtı değildir. Claim dönemi değiştirilerek eski aktörün geç ortak yazımı reddedilir; önceden gerçekleşmiş dış etki ortadan kalkmaz.

Reading Pass yeniden kurulurken actual kapsam/konum bilinmiyorsa okunmuş varsayılmaz. Gerekli yeniden okuma yapılır; eski birleşimin incelemesi yenisini otomatik desteklemez. Dış kaynak sessiz değişebileceği için journal tek tazelik kaynağı değildir: ilgili kullanımdan önce kaynak kontrolü, gerçek hostta tanımlı gözlem veya yetkili periyodik Work gerekir. Bu not background iş başlatmaz.

## 6. Bütünün hareketi

Host yeni talep/sonuç/değişiklik alır → K1/K7 yorum veya uzlaştırma üretir → K2 next Work ve dönüş kararını seçer → K4 gerçek bileşimi, K3 context'i kurar → K6 start/claim denetler → K5 üretir/inceler → K6 candidate, karar ve etkiyi doğru statüyle bağlar → K2 ana karara veya teslimat/bütünleştirme işine döner.

Bu tek yönlü phase zinciri değildir. Üretim yeni bilgi ve yaratıcı tasarım doğurabilir. İzinli Run'lar paralel olabilir. Kontrol koşulları keşif yazımını durdurmadan ortak değişiklik ve dış etkileri sınırlar. K1 ve K5 birbirinden kopuk yönetim/iş dünyaları değildir; alan işi çalışma anlayışını da değiştirebilir.

**Romanın getirdiği fark:** tasarım kararı → metinde gerçekleştirme → exact assembly üzerinde ortak inceleme → o assembly'nin yetkili teslimi ayrı hareketlerdir. **Bankanın koruduğu sınır:** küçük iç dilim kabulü yıllık programı veya öğrenci sonucunu tamamlamaz. İkisi aynı kayıt/koordinasyon/etki omurgasını kullanır; aynı alan yöntemi veya tek değerlendirme ölçütünü kullanmaz.

## 7. Sadeleştirme ve açık sınırlar

K1–K7 işlev kimlikleridir, yedi zorunlu ayrı process/agent değildir. İlk kurulumda K1/K2/K4'ün muhakemesi B0'daki farklı görevler; K3 seçim/erişim araçları; K5 üretim/inceleme çağrıları; K6 host kodu; K7 olayla çağrılan uzlaştırma Work'leri olarak gerçekleşebilir. Gereksiz sürekli çalışan supervisor veya evrensel policy arbiter eklenmedi. Farklı epistemik görev gerektiğinde bağlamlar ayrılır; aynı modelin tekrar çağrılması bağımsızlık sertifikası değildir.

Assembly, Reading Pass, Scene Brief ve Narrative Ledger için ayrı motor gerekçelendirilmedi. Bunlar mevcut Artifact/Work/Run/Context/Decision ilişkilerinin daha yeterli kullanımlarıdır. Baştan bütün romanı formalize etme, her karaktere agent, her sahneye insan onayı, tek büyük hafıza veya her yeni derse yeni global kontrol seçilmedi.

G01 keşif; G02 context/anlamsal etki; G03 host sınırı/recovery; G04 yeterlik/oracle; G05 yararlı ilerleme/kapasite; G06 yöntem birleşimi/aktarım; G07 gerçek uzun-eser üretim ve bütünsel değerlendirme açıkları [kapsama kaydında](MS01-COVERAGE-AND-OPEN-MECHANISMS.md) mekanizmalara ve sınanacak iddialara bağlıdır. Özellikle G01/G02/G04 yalnız kodlama işi değildir; bilişsel yöntem ve alan yeterliği yükleri açıkça kalır.

## 8. Teslimatın statüsü ve devam sınırı

Checkpoint B, roman yürüyüşünü ve iki senaryonun sınırlı birleşim/sadeleştirme incelemesini ekleyerek **MS01 v0.1 kavramsal taslak teslimatını değerlendirmeye hazır** hale getirir. Bu self-review'dur; bağımsız değerlendirme veya işlevsel test değildir. Prose örnekleri, hazır bağımsız holdout değildir. Gerçek tam roman, yıllık banka ve runtime sonuçları yoktur.

EXP-004'ün adlandırılmış yapı ve mekanizma çıkarma işi bu taslakla somut bir değerlendirme noktasına ulaşmıştır; kullanıcı kabulü ve nihai kapanış ayrı kaydedilir. Yeni DQ05, yeni research kampanyası, ürün seçimi veya implementasyon varsayılan sonraki iş değildir. Sonraki iş bu taslağın kullanıcı değerlendirmesi veya adı konmuş bir mekanizma açığına yönelik açık yetkili düzeltmedir.
