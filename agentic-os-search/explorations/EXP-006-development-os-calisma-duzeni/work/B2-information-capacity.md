# B2 — SOUL'un Information kapasitesini geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.


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

## Süreklilik notu

B2'den türeyen R4–R6 adaylarının current registry'si [ACTORS](../ACTORS.md) içindedir. B1'deki R3, B2 failure diagnosis için de genişlemeye adaydır. M2 bir aktör/rol değil mekanik Information sorumluluğudur.
