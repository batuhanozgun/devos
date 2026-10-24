> **30 Eylül 2026 — tarihsel B1/B2 Work haritası; güncel kurulum talimatı değildir.** Aşağıdaki çalışma yönü 25 Eylül 2026 anlık görüntüsüne aittir. [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) sonrasında DevOS kurulumunun tek geçerli planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; buradaki eski yetki ve sonraki iş devralınmaz.
>
> Özgün gövde değiştirilmeden korunur; tarihsel bulgu ve kalite gereksinimleri topluca geçersiz sayılmaz. Göreli bağlantıları eski konumuyla okumak için [aynı gövdenin sabit tarihsel sürümünü](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/EXP-006_Work_Map.md) kullanın. Bu da tarihsel kaynaktır, güncel talimat değildir. Kaynak eşliği ve bağlantı sınırı [history girişinde](README.md#historical-source-map) açıklanır.

---

# EXP-006 — Development OS Work Map

**Statü:** DIALOGUE WORKING MAP / aday ayrıştırma.  
**Amaç:** SOUL'u yaratma hedefinden Development OS'un yapacağı işleri; ardından bu işler için gereken kabiliyet ve sorumlulukları katman katman çıkarmak.  
**Sınır:** Bu dosya SOUL modül listesi, Development OS mimarisi, rol listesi veya araç seçimi değildir.

## Katman mantığı

```text
SOUL hedefi
  ↓
Development OS'un SOUL üzerinde yapacağı ana işler (B1–B9)
  ↓
Her iş için Development OS'un gerekli kabiliyet ve sorumlulukları
  ↓
Bu sorumlulukları taşıyacak yapay zekâ rolleri / mekanik sistemler / insan
  ↓
Development OS yapısı
  ↓
İhtiyaçtan türeyen mekanizma ve araç seçimleri
```

Roller Work'ten önce icat edilmeyecek. Aynı şekilde bir kabiliyetin adı, otomatik olarak ayrı bir rol, agent, servis veya dosya anlamına gelmez.

## B — Birinci seviye Development OS Work haritası

### B1 — SOUL'un ortak entelektüel çalışma tabanını geliştirmek

İhtiyaç keşfi, sistem görüşü, araştırmadan yararlanma, kanıt–varsayım ayrımı, belirsizlik yönetimi, profesyonel çalışma standardı ve gerektiğinde derin bilgiye dönme davranışlarını oluşturmak ve sınamak.

### B2 — SOUL'un Information kapasitesini geliştirmek

Memory, context, kalıcı kayıtlar, kaynak ve sürüm takibi, retrieval, güncellik, değişiklik etkisi ve doğru bilginin doğru aktöre kullanılabilir biçimde ulaşmasını geliştirmek.

### B3 — SOUL'un Actors kapasitesini geliştirmek

İhtiyaçtan rol çıkarmak; uygun aktörü oluşturmak/bağlamak; yeterlilik, yetki, delegasyon, sorumluluk, insan–yapay zekâ ilişkisi ve aktör yaşam döngüsünü geliştirmek.

### B4 — SOUL'un Work kapasitesini geliştirmek

Amaçtan ihtiyaç ve iş keşfetmek; yaşayan planı, bağımlılıkları, başlanabilir işleri, koordinasyonu, ilerlemeyi, yeniden çalışmayı ve tamamlanma durumlarını yönetebilen kapasiteyi geliştirmek.

### B5 — SOUL'un Environment kapasitesini geliştirmek

Araçlar, runtime, çalışma alanları, sandbox, veri ve kaynak erişimi, credentials/network/tool availability, fiilî kullanılabilirlik ve gerçek dünyada etki yaratma kapasitesini geliştirmek.

### B6 — Dört zemini birbirine doğru bağlayan düzeni geliştirmek

Information–Actors–Work–Environment ilişkilerinin birlikte doğru işlemesini; readiness, context, authority, assignment, effect, verification, acceptance, change impact ve transition sınırlarını geliştirmek.

### B7 — SOUL'un işe göre çalışma sistemi kurma ve genişletme kapasitesini geliştirmek

Verilen amaç için hangi aktörlerin, bilgi düzeninin, Work yapısının, araçların, ortamın ve kontrollerin gerektiğini keşfedip kurabilmesini; ihtiyaç değiştikçe sistemi değiştirebilmesini geliştirmek.

### B8 — Süreklilik, değişim, toparlanma ve öğrenme kapasitesini geliştirmek

Oturum veya aktör kaybında Work'ü kaybetmemek; eskiyen sonuçları bulmak; belirsiz etkileri uzlaştırmak; yeni bilgiyle gerekli parçaları yeniden açmak; yöntem ve birikimi koşullarıyla korumak.

### B9 — Ortaya çıkan SOUL'u bütün olarak birleştirmek ve gerçek görevlerle sınamak

Parçaların ayrı ayrı varlığını değil, SOUL'un gerçekten amaç alıp gerekli çalışma sistemini kurabildiğini, işi ilerletebildiğini, gerçek sonuç üretebildiğini ve bunu uygun kanıtla sınayabildiğini göstermek.

## Güncel odak

Şimdi yalnız **B1** açılacaktır.

Sorulan soru:

> **Development OS, SOUL'un ortak entelektüel çalışma tabanını geliştirebilmek için neyi yapabilir olmalı ve hangi sorumlulukları taşımalıdır?**

Bu sorunun cevapları henüz rol isimleri değildir. Bir cevap ancak daha sonra “bunu kim/ne taşımalı?” sorusuyla role, mekanik sisteme veya insan sorumluluğuna bağlanacaktır.


---

## B1 açılımı — SOUL'un ortak entelektüel çalışma tabanını geliştirmek

### B1'in hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey, yalnız bir ilke veya prompt listesi değildir.

Hedef; yeni bir SOUL rolü/aktörü oluşturulduğunda ona aktarılabilen, role özgü uzmanlıktan ayrı duran, hangi derin bilgiye ne zaman dönüleceğini fark ettiren ve gerçek davranışta sınanabilen **ortak çalışma tabanıdır**.

Bu taban örneğin şu davranış yönlerini taşıyabilir:

- görünür talebi doğrudan yeterli iş tanımı saymama;
- amaç, yöntem, varsayım, kanıt ve gerçek sonucu ayırma;
- sistemin bütününü ve kendi yerini görebilme;
- belirsizliği ve eksik önkoşulu fark etme;
- gerektiğinde araştırma veya başka uzmanlık ihtiyacını yükseltme;
- var olan araştırma/bilgi kütüphanesinin farkında olma ve ne zaman derine inileceğini bilme;
- rol ve yetki sınırını aşmama;
- yeni bilgi karşısında hükmünü güncelleme;
- iş küçük diye profesyonel çalışma standardını terk etmeme;
- uzun işte amaç ve çalışma durumunu kaybetmeme.

Bunlar nihai checklist değildir; B1'in geliştireceği ortak tabanın yönünü tarif eder.

### Development OS'un B1 için gerekli kabiliyet ve sorumlulukları

#### B1-C1 — Ortak tabanı keşfetmek ve tanımlamak

Development OS, hangi çalışma davranışlarının bütün akıl yürüten SOUL aktörlerinde ortak olması gerektiğini araştırıp gerekçelendirebilmelidir.

Aynı anda şunları ayırmalıdır:

- ortak entelektüel taban;
- role özgü uzmanlık;
- role özgü amaç/sorumluluk;
- projeye özgü güncel bağlam;
- yalnız belirli bir mekanizmaya ait uygulama ayrıntısı.

Amaç bütün rolleri aynılaştırmak değil, rol uzmanlaşırken kaybolmaması gereken ortak çalışma niteliğini belirlemektir.

#### B1-C2 — Ortak tabanı aktöre taşınabilir hâle getirmek

Tanımlanan çalışma tabanı yalnız Development OS'un araştırma dosyalarında kalmamalıdır.

Development OS, farklı SOUL aktörlerinin/rollerinin bu tabanı fiilen kullanabileceği bir karşılığa dönüştürebilmelidir. Bunun teknik biçimi henüz seçilmez; instruction, protokol, skill, seçilmiş context, model uyarlaması veya başka mekanizmalar aday olabilir.

Buradaki sorumluluk mekanizmayı erken seçmek değil, **tanımdan gerçek aktör davranışına aktarım problemini çözmektir.**

#### B1-C3 — Derin bilginin varlığını ve ne zaman gerektiğini aktöre fark ettirmek

Her aktör bütün araştırma ve kaynakları sürekli taşımak zorunda değildir.

Fakat ortak taban, aktörün:

- hangi tür sorunlarda daha derin bilgi gerekebileceğini;
- ilgili bilgi veya araştırmanın mevcut olabileceğini;
- kendi mevcut bilgisinin ne zaman yetersiz olduğunu;
- ne zaman kaynak/araştırma/uzmanlık çağırması gerektiğini

fark edebilmesini sağlamalıdır.

Derin bilginin saklanması, bulunması ve context'e taşınması B2 ile kesişir; B1'in sorumluluğu **bu bilgiye dönme ihtiyacını fark eden çalışma davranışını** geliştirmektir.

#### B1-C4 — Davranış beklentisini uygun kontrol türüne çevirmek

Development OS, her çalışma ilkesinin yalnız “aktöre söylemekle” güvenilir biçimde sağlanabileceğini varsaymamalıdır.

Her kritik beklenti için şu ayrımı yapabilmelidir:

- aktör muhakemesi / talimat yeterli mi;
- gözlem ve değerlendirme yeterli mi;
- yoksa yanlış davranışı gerçekten engelleyen mekanik bir kontrol mü gerekiyor?

B1 burada kontrol ihtiyacını ve beklenen davranışı tanımlar. Gerçek host/runtime/enforcement mekanizmasının geliştirilmesi özellikle B5/B6 ile kesişir.

#### B1-C5 — Aktörün gerçekten bu tabanla çalıştığını sınamak

“Kuralları okudum”, “araştırmadan haberdarım” veya “SOUL-native çalışıyorum” beyanı yeterli değildir.

Development OS, ortak tabanın gerçek davranışta ortaya çıkıp çıkmadığını sınayabilmelidir. Örneğin:

- söylenmemiş kritik ihtiyacı fark ediyor mu;
- varsayımı kanıt gibi kullanıyor mu;
- ilgili araştırmaya gerektiğinde dönüyor mu;
- rolünün dışında kalan ihtiyacı görünür kılıyor mu;
- küçük işte gereksiz sistem kuruyor mu;
- yeni kanıt geldiğinde eski hükmü değiştirebiliyor mu?

Test yöntemi tek bir benchmark veya aynı-model self-review olmak zorunda değildir; iddiaya uygun değerlendirme gerekir.

#### B1-C6 — Başarısızlığın nedenini teşhis etmek

Bir aktör ortak tabana uygun davranmadığında Development OS bunu yalnız “daha iyi prompt yazalım” sorunu saymamalıdır.

Sorunun kaynağını ayırabilmelidir:

- temel model kapasitesi yetersiz mi;
- gerekli bilgi/context verilmedi mi;
- bilgi vardı ama kullanma davranışı oluşmadı mı;
- rol amacı yanlış mı kuruldu;
- talimat zayıf mı;
- araç/Environment yetersiz mi;
- yetki veya kontrol sınırı yanlış mı;
- değerlendirme yöntemi hatalı mı?

Bu teşhis sonraki düzeltmenin hangi B dalına ait olduğunu belirler.

#### B1-C7 — Ortak tabanı kanıta bağlı biçimde değiştirmek

Yeni araştırma, gerçek çalışma deneyimi veya başarısızlık ortak çalışma tabanında değişiklik gerektirebilir.

Development OS:

- yeni dersi doğrudan kalıcı kurala çevirmemeli;
- hangi davranışın neden değişeceğini göstermeli;
- değişikliğin hangi aktör/rol kullanımlarını etkilediğini belirlemeli;
- eski yararlı davranışları gereksiz yere kaybetmemeli;
- değişmiş tabanı yeniden sınamalıdır.

Kalıcılık, sürüm ve yeniden kullanım mekanikleri B2/B8 ile kesişir; B1'in sorumluluğu ortak çalışma standardının **epistemik ve davranışsal olarak kontrollü evrimi**dir.

### B1 sınırı

B1 tek başına:

- memory sistemi kurmaz;
- rol uzmanlıklarını çözmez;
- host/runtime seçmez;
- bütün mekanik kontrolleri implemente etmez;
- Work yönetimini çözmez.

B1, diğer dallarda geliştirilecek kapasiteleri kullanacak aktörlerin **nasıl bir ortak çalışma zekâsı ve davranış standardı taşıması gerektiğini ve Development OS'un bunu nasıl oluşturup sınayacağını** ele alır.

Bu açılım henüz rol listesi değildir.


### B1'den türeyen ilk Development OS taşıyıcıları

Bu bölüm ilk rol türetimidir. Statüsü **adaydır**; B2–B9 ilerledikçe bazı roller birleşebilir, ayrılabilir veya yeniden adlandırılabilir.

#### R1 — Ortak Çalışma Tabanı Tasarımcısı

**Taşıdığı B1 sorumlulukları:** C1, C2, C3, C4'ün tasarım tarafı ve C7'nin değişiklik tasarımı.

Temel amacı:

> SOUL aktörlerinde ortak bulunması gereken çalışma davranışını araştırmak, tanımlamak ve başka Development OS işlerinin uygulayabileceği açık bir davranış/aktarım sözleşmesine dönüştürmek.

Bu rol:

- ortak taban ile role özgü uzmanlığı ayırır;
- hangi davranışların bütün akıl yürüten SOUL aktörlerinde korunacağını gerekçelendirir;
- araştırma ve deneylerden yararlanır;
- aktörün ne zaman daha derin bilgiye/uzmanlığa dönmesi gerektiğini tanımlar;
- davranış beklentisini gözlenebilir hâle getirir;
- hangi beklentinin instruction/reasoning, hangisinin evaluation, hangisinin mekanik enforcement gerektirdiğine ilişkin requirement üretir;
- başarısızlık ve yeni kanıt sonrasında taban değişikliği önerir.

**Sınır:** Aktörü fiilen yaratmak B3'e; memory/context plumbing B2'ye; host/enforcement implementasyonu B5/B6'ya aittir. R1 bunlar için gereksinim/sözleşme üretir, hepsini kendi başına uygulamaz.

#### R2 — Davranış Doğrulayıcısı

**Taşıdığı B1 sorumluluğu:** C5.

Temel amacı:

> Oluşturulan SOUL aktörünün iddia edilen ortak çalışma tabanıyla gerçekten çalışıp çalışmadığını kanıt arayarak sınamak.

Bu rol:

- “talimatı okudu” ile “davranışı gösterdi”yi ayırır;
- söylenmemiş ihtiyaç, varsayım/kanıt, araştırmaya dönme, yetki sınırı, yeni kanıtla hüküm güncelleme gibi davranışları uygun senaryolarda sınar;
- yalnız olumlu örnek aramaz; yanlış davranışı ortaya çıkarabilecek karşı durumları da dener;
- kullanılan testin hangi iddiayı gerçekten sınayabildiğini açık tutar;
- sonuç üreticisinin “çalışıyor” beyanını kabul kanıtı saymaz.

**Neden ayrı rol adayı:** R1'in başarı yönü ortak tabanı oluşturmak ve iyileştirmektir. R2'nin başarı yönü, bu tabanın çalışmadığı yerleri bulabilmektir. Aynı temel model kullanılabilir; fakat aynı rol-instantiation olarak düşünülmesi doğrulama baskısını zayıflatabilir.

#### R3 — Davranış Teşhisçisi / Değişiklik Analisti

**Taşıdığı B1 sorumlulukları:** C6 ve C7'nin teşhis/etki tarafı.

Temel amacı:

> Gözlenen davranış başarısızlığının nedenini doğru katmanda teşhis etmek ve hangi Development OS işinin yeniden açılması gerektiğini belirlemek.

Bu rol şu olasılıkları birbirinden ayırmaya çalışır:

- model kapasitesi;
- ortak tabanın yanlış/eksik tanımı;
- aktarım/konfigürasyon sorunu;
- eksik veya yanlış context/information;
- role özgü amaç/yeterlilik sorunu;
- araç/environment eksikliği;
- authority/control sorunu;
- test/oracle sorunu.

Çıktısı doğrudan “promptu düzelt” değildir. Etkilenen B dalını, dayanağı ve yeniden sınama gereğini gösteren değişiklik önerisidir.

**Neden R1'e tamamen birleştirilmedi:** R1 kendi tasarımını savunma veya her hatayı taban tanımına bağlama eğilimine girebilir. Teşhis rolünün başlangıç amacı “tasarımı kurtarmak” değil, failure'ın doğru nedenini bulmaktır. Bunun ayrı fiziksel actor gerektirip gerektirmediği daha sonra belirlenir.

#### M1 — Mekanik davranış sınırı / enforcement sorumluluğu

Bu bir yapay zekâ rolü değildir.

C4'te R1 bazı davranışların yalnız instruction/evaluation ile yeterince güvenilir olmadığını gösterebilir. Bu durumda Development OS'ta gerçek teknik kontrol sorumluluğu doğar:

- izin dışı eylemi engellemek;
- belirli effect yolunu gate etmek;
- kimlik/yetki bağını korumak;
- gerekli kayıt/readback olmadan ilerlemeyi engellemek;
- başka gerçek host kontrolleri.

B1 burada yalnız **hangi davranış için hangi kontrolün gerektiğini** tarif eder. M1'in gerçek tasarım ve implementasyonu B5/B6 ile açılacaktır.

#### İnsan müşterinin B1'deki yeri

B1 yeni bir teknik insan rolü üretmedi.

Müşterinin daha önce belirlenen **yetki + kabul** çekirdeği korunur. Ortak çalışma tabanındaki bir değişiklik müşteri mandatını, değer tercihini veya verilmiş yetki sınırını değiştiriyorsa insanın yetkisi gerekir. Teknik çalışma standardını keşfetme ve uygulama yükü ise varsayılan olarak müşteriye geri bırakılmaz.

### B1 rol akışı — ilk aday

```text
R1 Ortak Çalışma Tabanı Tasarımcısı
        │
        │ davranış / aktarım / kontrol gereksinimi
        ▼
B2/B3/B5/B6'daki uygulama mekanizmaları
        │
        │ oluşturulmuş SOUL aktörü
        ▼
R2 Davranış Doğrulayıcısı
        │
        │ failure / evidence
        ▼
R3 Davranış Teşhisçisi
        │
        │ hangi neden? hangi B dalı yeniden açılmalı?
        └──────────────► R1 veya ilgili B2–B8 işi
```

Bu akış sabit workflow değildir. B1'in sorumluluk ayrımını görünür kılan ilk modeldir.

### B1'den çıkan artefakt/sözleşme adayları

Rollerin somut çıktıları da şimdilik şu ailelerde görünüyor:

- **Ortak Çalışma Tabanı Tanımı:** ortak davranışların ve sınırlarının gerekçeli tanımı.
- **Aktarım Sözleşmesi:** yeni SOUL aktöründe bu tabanın hangi gözlenebilir davranışlara dönüşmesi gerektiği.
- **Kontrol Gereksinimleri:** instruction/evaluation/enforcement ayrımı ve mekanik sınır ihtiyacı.
- **Davranış Kanıtı:** gerçek test/senaryo sonucu; yalnız role beyanı değil.
- **Teşhis ve Değişiklik Önerisi:** failure nedeni, etkilenen Development OS dalı ve yeniden sınama gereği.

Bunlar kesin dosya adları veya şemalar değildir.


---

## B2 açılımı — SOUL'un Information kapasitesini geliştirmek

### B2'nin hedef çıktısı

Development OS'un B2'de üretmeye çalıştığı şey tek bir “memory sistemi” değildir.

Hedef; SOUL'un bilgiyle zaman içinde güvenilir biçimde çalışabilmesini sağlayan bir Information kapasitesidir. Bu kapasite en azından şu ayrımları korumalıdır:

- bilginin/temsilin ne olduğu ile gerçek dünyadaki referenti;
- kaynak ile türetilmiş temsil;
- gözlem, kullanıcı bildirimi, çıkarım, varsayım, öneri, karar ve kanıt;
- güncel durum ile tarihsel durum;
- canonical/current kayıt ile düşük-otoriteli öğrenilmiş/derived memory;
- bilginin depoda bulunması ile bulunabilir olması;
- bulunabilir olması ile belirli Work/Actor/use için seçilmesi;
- seçilmesi ile aktöre gerçekten görünür olması;
- görünür olması ile anlaşılması/kullanılması;
- bugünkü doğru kaydın gelecekte de otomatik doğru kalmaması.

Bu kapasite; dosya, RAG, knowledge graph, long context, veri tabanı veya başka bir teknolojiyle özdeş değildir. Bunlar ancak belirli bilgi ihtiyacını karşılayan mekanizma adayları olabilir.

### Development OS'un B2 için gerekli kabiliyet ve sorumlulukları

#### B2-C1 — Bilgi sınıflarını, anlamını ve otorite seviyelerini ayırmak

Development OS, SOUL'da hangi bilgi türlerinin bulunduğunu ve bunların birbirine göre ne anlama geldiğini tanımlayabilmelidir.

Örneğin:

- kullanıcı hedefi/talimatı;
- current Work/state;
- kabul edilmiş karar;
- kaynak/evidence;
- araştırma bulgusu;
- türetilmiş özet/görünüm;
- geçici çalışma notu;
- aktör reflection'ı/öğrenilmiş deneyim;
- tarihsel kayıt;
- aday yöntem veya hipotez.

Bunların hepsini tek “memory” havuzuna koyup aynı otoriteyle kullanmamalıdır. Özellikle canonical current state ile derived/learned memory aynı authority class'ında olmamalıdır.

#### B2-C2 — Bilgiyi doğru statü ve provenance ile oluşturmak / edinmek

Yeni bilgi sisteme girdiğinde yalnız içeriğin kendisi değil, en azından gerektiği ölçüde:

- kaynağı;
- kimliği/sürümü;
- ne zaman edinildiği;
- hangi kapsamda geçerli olduğu;
- gözlem mi çıkarım mı olduğu;
- hangi Work/Actor/use ile ilişkili olduğu;
- doğrulama/qualification durumu

korunabilmelidir.

Amaç her cümleyi ağır metadata şemasına çevirmek değil; sonraki kullanımda anlam ve yetki kaybını önleyecek kadar iz bırakmaktır.

#### B2-C3 — Bilgiyi zaman içinde bakım altında tutmak

Development OS, kalıcı bilgiyi yalnız yazıp bırakmamalıdır.

Şunları yönetebilmelidir:

- düzeltme ve revizyon;
- yeni sürüm / supersession;
- çelişki;
- support withdrawal;
- güncellik ve temporal validity;
- stale olma;
- geçmişi koruma;
- gerektiğinde silme/unutma veya kullanım dışına çıkarma;
- değişikliğin türetilmiş görünüm ve kararlara etkisi.

Eski kayıt tarihsel olarak doğru kalabilir ama current kullanım için uygun olmayabilir.

#### B2-C4 — Bilginin varlığını ve erişim yolunu keşfedilebilir kılmak

Bir kaynağın depoda bulunması, aktörün onun varlığını bilmesi demek değildir.

Development OS, SOUL'un bilgi evreninde:

- hangi bilgi alanlarının bulunduğunu;
- ilgili kaynağa nasıl gidileceğini;
- hangi index/locator/relationship'in kullanılabileceğini;
- doğrudan kaynak mı, türetilmiş görünüm mü okunacağını

bulmayı mümkün kılmalıdır.

Burada “arama” mekanizması henüz seçilmez. Dosya indeksi, graph, search, RAG veya başka yollar ihtiyaca göre aday olabilir.

#### B2-C5 — Belirli Work / Actor / use için yeterli bilgiyi seçmek

Development OS, “ilgili birkaç belge buldum” ile yeterli context oluşturmayı eşitlememelidir.

Belirli bir iş ve aktör için:

- hangi kaynakların gerekli olduğu;
- hangi sürümlerin uyumlu olduğu;
- hangi zaman/authority kapsamının geçerli olduğu;
- bütün görünüm için hangi eksiklerin kritik olduğu;
- hangi bilginin gereksiz yük olduğu;
- özetin ne zaman yetersiz kaldığı ve asıl kaynağa dönülmesi gerektiği

değerlendirilebilmelidir.

Seçim, actor/use-conditioned olmalıdır; aynı bilgi bütün roller için aynı görünümle uygun olmayabilir.

#### B2-C6 — Seçilen bilgiyi aktörün gerçek context'ine taşımak

Seçilmiş bilgi ile fiilen modele/aktöre sunulan bilgi ayrı kaydedilebilir veya gözlenebilir olmalıdır.

Development OS:

- context package oluşturabilmeli;
- kaynak/sürüm bağını koruyabilmeli;
- gerekli ayrıntıyı sessizce kırpmamalı;
- uzun kaynakta gerektiğinde hedefli derin okumaya izin vermeli;
- yeni çağrı/oturumda gerekli çalışma bağlamını yeniden kurabilmelidir.

Context formation, persistent memory'nin kendisi değildir; memory read'in çalışma anındaki görünür girdiye dönüşmesidir.

#### B2-C7 — Görünürlük ile gerçek kullanımı ayırmak ve sınamak

Bir bilginin context'e konmuş olması, aktörün onu anladığını veya kararında kullandığını kanıtlamaz.

Development OS, kritik bilgi için gerektiğinde:

- aktörün dayanağını göstermesini;
- kararın hangi kaynak/sürüme bağlı olduğunu;
- verilen bilgi değiştiğinde hükmün değişip değişmediğini;
- relevant bilginin gözden kaçıp kaçmadığını

sınayabilmelidir.

Bu nokta B1 davranış doğrulamasıyla kesişir; B2'nin özel sorusu **bilgi zincirinin gerçekten kullanıma kadar ulaşıp ulaşmadığıdır.**

#### B2-C8 — Bilgi erişimi ve görünürlüğünü yetkiyle uyumlu tutmak

Bilgi mevcut diye her aktöre gösterilmemelidir.

Development OS, hangi aktörün hangi bilgiye hangi amaçla erişebileceğini ve hangi temsilin paylaşılabileceğini belirleyebilmelidir.

Burada B2 bilgi görünürlüğü gereksinimini tanımlar. Aktör authority/delegation B3; credentials, gerçek erişim ve enforcement B5/B6 ile birleşir.

#### B2-C9 — Information başarısızlığını teşhis etmek

Bir aktör yanlış sonuca vardığında “memory bozuk” gibi tek açıklama kullanılmamalıdır.

Development OS şu failure türlerini ayırabilmelidir:

- bilgi hiç üretilmedi / edinilmedi;
- bilgi yanlış statüyle yazıldı;
- kaynak eski veya geçersiz;
- gerekli kaynak bulunamadı;
- retrieval yanlış/eksik;
- seçim/context yetersiz veya aşırı;
- yanlış sürüm aktöre sunuldu;
- erişim engellendi;
- doğru bilgi görünür oldu ama aktör kullanmadı;
- derived memory canonical state'i ezdi;
- değişiklik downstream kullanımlara yansımadı.

Teşhis sonucu ilgili B2 işi, B1 davranış işi, B3/B5/B6 sınırı veya B8 continuity işi yeniden açılabilir.

### B2 sınırı

B2:

- bütün bilgi problemlerini “memory” adı altında tek sistem yapmaz;
- RAG/KG/vector DB/long context gibi mekanizmaları baştan seçmez;
- bilginin doğru olmasını yalnız metadata varlığıyla garanti etmez;
- aktör yetkisini kendi başına belirlemez;
- host/runtime erişimini kendi başına sağlamaz;
- Work'ün ne olduğunu veya hangi işin öncelikli olduğunu tek başına belirlemez.

B2, SOUL'un **bilgiyi oluşturma/edinme, koruma, güncelleme, bulma, seçme, aktöre görünür kılma ve kullanıma kadar izleme kapasitesini** Development OS'un nasıl geliştireceğini ele alır.

### B2'den türeyen Development OS taşıyıcıları

#### R4 — Information Steward / Bilgi Yaşam Döngüsü Tasarımcısı

**Taşıdığı B2 sorumlulukları:** C1, C2, C3, C4'ün bilgi düzeni tarafı, C8'in semantik görünürlük tarafı ve C9'un yaşam-döngüsü teşhisi.

Temel amacı:

> SOUL bilgisinin hangi tür/statü/otoriteyle oluşacağını, zaman içinde nasıl korunup değişeceğini ve daha sonra güvenli biçimde bulunabilmesi için hangi anlam bağlarının korunacağını tasarlamak ve denetlemek.

Bu rol:

- bilgi sınıflarını ve source-of-truth sınırlarını tanımlar;
- provenance/currentness/version/statü gereksinimlerini çıkarır;
- write/update/supersede/retention/forgetting davranışını tasarlar;
- index/locator ihtiyacını tanımlar;
- derived/learned bilginin canonical state'i sessizce ikame etmesini engelleyecek requirement üretir;
- bilgi yaşam döngüsündeki failure'ları araştırır.

**Sınır:** gerçek depolama motoru, dosya sistemi, DB, retrieval altyapısı veya access enforcement mekanizmasını tek başına implement etmez; bunlar B5/B6 ile kesişir.

#### R5 — Context & Retrieval Curator / Bağlam Kurucusu

**Taşıdığı B2 sorumlulukları:** C4'ün retrieval tarafı, C5, C6 ve C8'in use-conditioned selection tarafı.

Temel amacı:

> Belirli Work ve Actor için doğru, yeterli, güncel ve yetkili bilgi görünümünü kurmak.

Bu rol:

- neyin aranacağını ve hangi kaynaklara inileceğini belirler;
- ilgili fakat yetersiz kaynak kümesini yeterli context sanmaz;
- sürüm/zaman/authority uyumunu dikkate alır;
- özet ile asıl kaynak arasında gerektiğinde derinleşir;
- context package oluşturur;
- gereksiz bütün-korpus yüklemesi ile kritik bilgi eksikliğinin iki ayrı hata olduğunu gözetir;
- aktör/rol/use değişince aynı bilginin başka görünüm gerektirebileceğini hesaba katar.

**Neden R4'ten ayrı rol adayı:** R4'ün başarı yönü bilgi yaşamının uzun vadede doğru temsil edilmesidir. R5'in başarı yönü ise **şu anki işi yapan aktörün doğru şeyi görmesidir.** Memory lifecycle ile context formation aynı failure surface değildir.

#### R6 — Information Integrity Reviewer / Bilgi Yeterliği Doğrulayıcısı

**Taşıdığı B2 sorumlulukları:** C7 ve C9'un bağımsız inceleme tarafı; C2/C3/C5/C6'nın kritik kontrolleri.

Temel amacı:

> Belirli bir işte kullanılan bilgi zincirinin kaynak→statü→sürüm→seçim→exposure→use boyunca iddiayı gerçekten taşıyıp taşımadığını sınamak.

Bu rol örneğin şunları arar:

- eski veya yanlış sürüm;
- kaynakla türevin karışması;
- eksik provenance;
- stale bilgi;
- gerekli karşı kaynağın atlanması;
- context'te kritik boşluk;
- yalnız relevance'e bakıp bütün görünümü eksik bırakma;
- aktöre bilgi gösterildiği halde kararın ona dayanmaması;
- düşük-otoriteli memory'nin canonical state gibi kullanılması.

**Neden R5'ten ayrı rol adayı:** R5 kullanılabilir context üretmeye çalışır; R6 o context'in yeterli olmadığı yerleri bulmaya çalışır. Aynı model kullanılabilir ama başarı yönleri farklıdır.

#### Mevcut R3'ün B2 ile genişlemesi

B1'deki **R3 — Davranış Teşhisçisi / Değişiklik Analisti** yeni bir bilgi rolüyle kopyalanmıyor.

R6 bir bilgi problemi bulduğunda R3 daha üst teşhisi yapabilir:

- sorun R4'ün information modelinde mi;
- R5'in selection/context kararında mı;
- mekanik retrieval/exposure yolunda mı;
- yoksa doğru bilgiye rağmen aktör davranışında mı?

Böylece B1 ve B2 failure teşhisi tek bir cross-domain değişiklik analizi rolünde birleşmeye adaydır.

#### M2 — Information persistence / retrieval / exposure mekanik sorumluluğu

Bu bir yapay zekâ rolü değildir.

B2'de tanımlanan davranışların gerçek sistem karşılığı için mekanik sorumluluklar doğar:

- durable storage / canonical state;
- version/history;
- index/search/retrieval;
- source readback;
- context injection;
- erişim kontrolleri;
- update/supersede/forget triggers;
- stale/dependency propagation için destek;
- hangi içeriğin fiilen aktöre sunulduğuna dair kayıt/observability.

B2 bunların **bilgi anlamı ve kullanım gereksinimini** tanımlar. Hangi teknik substrate'ın kullanılacağı B5/B6'da seçilip uygulanacaktır.

#### İnsan müşterinin B2'deki yeri

B2 de müşteriye yeni bir teknik bilgi-yönetimi rolü yüklemez.

İnsan:

- kendisine ait bilgi ve tercihlerin yetkili kaynağı olabilir;
- belirli bilgi erişimleri için izin sınırı belirleyebilir;
- yanlış/eskimiş bilgisini düzeltebilir.

Fakat hangi kayıt sınıfının, retrieval yönteminin, context politikasının veya memory lifecycle'ının gerektiğini müşterinin teşhis etmesi beklenmez.

### B2 rol akışı — ilk aday

```text
R4 Information Steward
   │ bilgi türü / statü / lifecycle / source-of-truth
   ▼
M2 bilgi mekanikleri
   │ kalıcılaştır / indeksle / getir / sun
   ▼
R5 Context & Retrieval Curator
   │ belirli Work + Actor + use için yeterli görünüm
   ▼
SOUL aktörü
   │ karar / üretim / gözlenen kullanım
   ▼
R6 Information Integrity Reviewer
   │ bilgi zinciri yeterli mi?
   ▼
R3 Değişiklik Analisti
   │ sorun R4, R5, M2, B1 veya başka B dalında mı?
   └──────────────► ilgili iş yeniden açılır
```

Bu sabit workflow veya zorunlu fiziksel agent topolojisi değildir.

### B2'den çıkan artefakt/sözleşme adayları

- **Information Semantics / Authority Contract:** bilgi türleri, statüler ve source-of-truth sınırları.
- **Information Lifecycle Contract:** oluşturma/edinme, revise/supersede, freshness, retention/forgetting.
- **Source / Provenance Record:** kritik bilginin kaynak, sürüm, kapsam ve qualification bağı.
- **Discovery / Locator Surface:** bilginin varlığını ve erişim yolunu bulduracak indeks/görünüm.
- **Context Package / Selection Record:** belirli Work/Actor/use için seçilen ve fiilen sunulan bilgi.
- **Information Integrity Evidence:** source→selection→exposure→use zincirinin sınama sonucu.
- **Information Failure / Change Proposal:** eksikliğin türü, etkilenen kullanım ve yeniden açılacak iş.

Bunlar kesin dosya, tablo veya servis adları değildir.
