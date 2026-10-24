> **30 Eylül 2026 — tarihsel P2 ilk rol sözleşmeleri.** Aşağıdaki 16 DR sözleşmesi 27 Eylül'deki aday taslaktır; güncel kurulumun kesin kadrosu veya 16 çalışan ajan değildir. Daha sonraki G/Y koordinasyon ve inceleme profilleri [P3-01](P3-01-work-information-discussion.md)'dedir. Ortak muhakeme, uzmanlık, yetki ve bağımsızlık ayrımları korunur; eski P3–P6 çalışma sırası yeniden başlatılmaz.
>
> Güncel devir [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. Özgün aday sözleşmeler aşağıda aynen korunur; bu not onları kabul edilmiş tasarıma yükseltmez. Bakımın devamı [REPOSITORY-TRANSITION](../../../REPOSITORY-TRANSITION.md)'dedir.

---

# P2-01 — Adlandırılmış rol ve sözleşme taslağı

**Üst iş:** [WORK/P2](../WORK.md). **Tarih:** 27 Eylül 2026.  
**Başlangıç:** `agentic-os-search@b0743c6a363ceffd2560baa78cba782bcd5f8d52`.  
**Statü:** FIRST ROLE-CONTRACT DRAFT / CANDIDATE / USER RETURN. İlk kavramsal rol taslağı hazır; kullanıcı kabulü, optimal kadro, Claude ajan dosyası veya çalışan ekip değildir. P2'nin işleyişle karşılıklı ayrıntılandırılması P3'te sürer.  
**Yetki:** Kullanıcı, teknik seçimin P4'te olduğunu anladıktan sonra devam istedi. Bu tur P2'nin rol isimleri, sözleşme adayları ve aile–rol–motivasyon ayrımını ele alır. P4 seçimi, P5 dosyaları ve gerçek SOUL backlog'u üretilmedi.

## 1. Sonuç: isimden fazlası, ajan dağılımından öncesi

[ACTORS](../ACTORS.md#p2-adlandırılmış-rol-taslağı) 16 adlandırılmış sözleşme adayının registry'sidir. `DR01–DR16` bu taslağın referanslarıdır; ilk R1–R25 kimlikleri değiştirilmez. Sayı fiziksel ajan, daima açık oturum veya zorunlu dosya sayısı değildir.

Her sözleşme amaç/başarı yönü, bilgi ve uzmanlık, etkinleşme nedeni, teslimat/tüketici, yetki ve olumsuz sınır taşır. Fiilî araç, izin, çağırma ve kalıcılık karşılıkları P3–P6'da tamamlanacaktır. Yalnız bir rol adının bulunması competence kanıtı değildir.

### Aile–rol–motivasyon için aday yorum

Kullanıcının `aktör → aile → rol → motivasyon` önerisi konuşmayı ve registry'yi düzenlemek için kullanılabilir; fakat bundan otomatik bir çalıştırma ağacı çıkarmıyoruz.

- **Aile:** Benzer başarı yönündeki sorumlulukları karşılaştırma ve yeniden kullanma grubu.
- **Rol:** Belirli katkının amacı, teslimatı, yetkisi, bilgi ihtiyacı ve devir sözleşmesi.
- **Motivasyon / başarı yönü:** Bu taslakta rolün hangi sonucu gözettiği. Ayrı bir runtime nesnesi veya modelin içsel dürtüsü olduğu iddia edilmez.
- **Etkin görevlendirme:** Gerçek aktör örneğinin bu rolü belirli iş, hedef/sürüm, bağlam ve araç/yetki koşullarında üstlenmesi.

**Tercih edilen taslak:** Motivasyonu rol sözleşmesinin içinde açıkça yazmak; ajan eşlemesini ayrı tutmak. Ayrı motivasyon başına ajan kullanmak ne peşinen reddedildi ne zorunlu kabul edildi. Birbirine ters başarı yönleri ayrı görevler gerektirebilir; birkaç uyumlu ölçüt ise kendiliğinden birkaç ajan gerektirmez. Bunun çalışma biçimi ve fiziksel ayrımı P4'te, etkinliği P6'da sınanır.

Örnek: Güvence İnceleyicisinin amacı mutlaka hata bulmak veya mutlaka onaylamak değil, kanıtın taşıdığı hükmü vermektir. Uygulama Geliştiricisinin kendi değişikliğini sınaması yararlıdır; bu kontrol otomatik bağımsız güvence olmaz. [S1-02/S1-03; F-A]

## 2. Kaynaklardan taslağa gelen gerçek değişiklikler

**Actors Foundation:** Süregelen sorumluluk ile şu an çalışan aktörü ayırdığı için Bilgi Sorumlusu veya Koordinatörün daima açık bir süreç olmasını varsaymadım. Atama, yeterlik ve yetkiyi ayrı tuttuğu için Rol ve Katılım Sorumlusuna bunların üçünü kendi beyanıyla üretme gücü vermedim. [F-A]

**Work Foundation:** İş keşfi, admission, yürütme ve temsil edilen durum ayrı olduğu için İş Keşfi ve Planlama ile Çalışma Koordinasyonunu ayırdım. Araştırma, inceleme ve kayıt bakımı da Work'tür; kod üretimi olmayan katkıları görünmez bırakmadım. [F-W]

**Superpowers S03:** Bir controller'ın bağlam seçimi ve anlamsal devir de yaptığını gösteriyor. Buradaki aday tasarım, bu yükü Koordinatörün gizli yeteneği saymak yerine Bağlam Kurucusu ve işin alan sorumlusuyla açık ilişkilendiriyor. Aynı eksik brief'i birkaç inceleyiciye vermek bağımsız yeterlik sağlamaz. Kaynaktaki insan onayları ve bütün workflow alınmadı. [S-SP]

**Work-management U10:** Yetki, atama, claim, liveness, closure ve outcome'un ayrı kalması; Koordinatör, Rol/Katılım, Ortam ve Güvence arasındaki devirleri gerekçelendiriyor. Bu çalışma ürün veya dispatcher seçimi değildir. [S-WM]

**S1-02/S1-03 ve OS Architect rol-sözleşmesi kaydı:** Motivasyonun tek başına yetmediğini, bilgi ihtiyacının bakımını, komşu rol sınırını ve gerçekten çalışan tetiği korudum. Kaynak kaydındaki sabit bölüm sayısı, slug kısıtı, eski kuyruğu ve insanla rol açma düzeni alınmadı. Bu tarihsel kayıt motivasyonun model performansına etkisini kanıtlamaz. [S-KEEL]

## 3. Bütün roller için ortak sözleşme koşulları

1. **Hedef düzeyi açıktır:** SOUL ürününü geliştiren iş, DevOS'un kendi işleyişini değiştiren meta-iş ve gelecekteki SOUL müşteri işi birbirine karıştırılmaz. Aşağıdaki roller DevOS sorumluluklarıdır; SOUL içinde aynı kadroyu kurma kararı değildir. DevOS meta-değişikliği de kendi kapsam/yetkisine tabidir.
2. **Ortak taban korunur:** Her rol amacı, kanıtı, belirsizliği, ilgili araştırmaya dönmeyi ve kendi yetersizliğini görebilmeyi taşımalıdır. Uzmanlaşma, düşünmeyi bırakma veya yalnız gelen talimatı kopyalama demek değildir.
3. **İhtiyaç fark etme tekelleştirilmez:** Her rol yeni iş veya bilgi açığı gösterebilir. DR01 bunları hedef ve plan bakımından bütünleştirir; bütün doğru fikirlerin sadece ondan çıkması beklenmez.
4. **Girdi sözleşmesi:** İlgili amaç/kısıt, exact hedef ve sürüm, gerekli birincil kaynaklar, önceki kararın gerekçesi, açık soru, kullanılabilir araç/yetki ve beklenen teslimat görünür olmalıdır. Eksik kaynak tahminle tamamlanmış sayılmaz.
5. **Çıktı sözleşmesi:** Sonuç, gerekçe, dayanak/sürüm, belirsizlik, değişen nesne, açık ihtiyaç ve tüketici korunur. Gerekçe kaydı, özel iç düşünce dökümü değildir. Mesaj gitmesi veya dosya yazılması, tüketicinin sonucu kullandığını kanıtlamaz.
6. **Etkinleşme:** Aşağıdaki tetikler anlam koşuludur; henüz hook/API adı değildir. K1/K2 gereği normal role geçiş ve talep/cevap yolu Batu'nun elle rol açmasına bağlanmaz. Gerçek kullanıcı müdahalesi veya yetki ihtiyacı yok sayılmaz.
7. **Yetki:** Sorumluluk atanması teknik erişim veya meşru grant yaratmaz. Başka role istekte bulunmak yasak etkiyi dolaylı yoldan yaptırma yetkisi vermez. Rolün uzmanlığı kanıtlanamıyorsa görev/kalite sınırı sessizce düşürülmez.
8. **Bilgi bakımı ortak yük taşır:** Her üretici kendi teslimatının doğruluğu, gerekçesi ve sürüm bağından sorumludur. DR07 tek başına bütün dosyaları yazan darboğaz değildir; ortak lifecycle bütünlüğünü taşır. Somut yazıcılar ve mutation protokolü P3/P4'ün işidir.

## 4. Rol sözleşmeleri v0.1

### DR01 — İş Keşfi ve Planlama Sorumlusu · F1

**Amaç/motivasyon:** SOUL hedefi için gerekli işin ve önkoşullarının gerekçeli biçimde ortaya çıkması; kolay veya çok iş üretmek değil doğru işe yönelmek.  
**Girdi/yeterlik:** Yetkili hedef, B kapsamı, mevcut sonuçlar, araştırma, bağımlılıklar ve açık belirsizlikler; amaçtan ihtiyaç/önkoşul türetme ve alternatif planları karşılaştırma.  
**Tetik → teslimat/tüketici:** Hedefin devri, yeni ihtiyaç, önemli sonuç veya planı etkileyen değişiklik → gerekçeli iş adayları, önkoşul/bağımlılık ve plan revizyonu; DR06 ve ilgili alan rollerine.  
**Yetki/sınır:** Verilmiş kapsam içinde planlama hükümleri kurabilir; müşteri mandatını değiştiremez. Öneri, yürütmeye alınmış iş ve tamamlanmış iş aynı değildir. Kendi planının doğruluğunu yalnız görevlerin kapanmasıyla savunmaz. İlk SOUL işini ileride bu rolün de bulunduğu DevOS düzeni keşfeder; bu dosya o işi seçmez.

### DR02 — Kapasite Tasarımcısı · F1

**Amaç/motivasyon:** Belirli kapasite ihtiyacını gerekçeli, gerçekleştirilebilir ve sınanabilir tasarıma dönüştürmek.  
**Girdi/yeterlik:** İlgili B gereksinimi, Foundation, alan araştırmaları, karşı örnekler ve gerçek Environment sınırları. **Zorunlu uzmanlık profili** seçilir: ortak çalışma tabanı, bilgi düzeni, rol/aktör kapasitesi veya ortam/kabiliyet tasarımı. Bunlar tek kişinin bildiği varsayılmaz.  
**Tetik → teslimat/tüketici:** Açılan tasarım ihtiyacı veya başarısız tasarımın yeniden açılması → alternatifleri ve sınırları belli tasarım/aktarım sözleşmesi; DR03, DR05 ve DR04'e.  
**Yetki/sınır:** Kapsam içi tasarım kararları verir; farklı alanı uzmanlıksız sahiplenmez, uygulanmış saymaz. DR02 ortak sözleşme kalıbıdır: bilgi düzeninde etkinleşen rol açıkça bilgi düzeni uzmanlığıyla adlandırılır. P3 farklı bilgi/yetki gereği gösterirse bu profiller ayrı named role sözleşmelerine ayrılabilir; şimdi dört zorunlu ajan atanmaz.

### DR03 — Sistem Bütünlüğü Tasarımcısı · F1

**Amaç/motivasyon:** Yerel tasarımların birlikte üst hedefi karşılayan, yeterli ve yönetilebilir bir bütün oluşturması.  
**Girdi/yeterlik:** Kapasite tasarımları, interfaces, bilgi/aktör/iş/ortam ilişkileri, mevcut capability envanteri ve bütünleşik açıklar; cross-ground ve working-system formation bilgisi.  
**Tetik → teslimat/tüketici:** Birden çok alanı etkileyen tasarım, yeni capability veya bütünleşme sorunu → bağlama ve bütünlük gereksinimi, reuse/configure/create/defer gerekçesi; DR01/02/05/06 ve sınama rollerine.  
**Yetki/sınır:** Bütünleşik tasarımın sahibidir; bütün uzmanlıkların yerine geçmez, kurulumu kendiliğinden yapmaz ve tasarım uyumunu actual joint-fit kanıtı saymaz.

### DR04 — Sınama Tasarımcısı · F1

**Amaç/motivasyon:** İlgili yanlışta başarısızlık sinyali verebilen, doğru iddiayı değerlendiren sınama yolu kurmak.  
**Girdi/yeterlik:** Yetkili ihtiyaç, exact claim/target, riskler, gerekli bağımsızlık ve alan bilgisi; oracle, negatif örnek, leakage ve coverage tasarımı.  
**Tetik → teslimat/tüketici:** Yeni iddia/tasarım veya yetersiz sınama → kriter, yöntem, örnekler ve kanıt gereği; DR05'e harness gereksinimi, DR11'e yürütme tarifi, DR13'e inceleme dayanağı.  
**Yetki/sınır:** Kötü sonucu geçirmek için kriteri sonradan gevşetmez. Kendi sınama tasarımı da eleştirilebilir; oracle'ın doğruluğunu yazarı olduğu için garanti edemez.

### DR05 — Uygulama Geliştiricisi · F2

**Amaç/motivasyon:** Gereksinim/tasarımı gerçekten kullanılabilir uygulama veya mekanizmaya dönüştürmek.  
**Girdi/yeterlik:** Tasarım ve gerekçesi, hedef sürüm, çalışma ortamı ve araçlar; exact gerçekleştirme nesnesine uygun teknik uzmanlık.  
**Tetik → teslimat/tüketici:** Yetkili üretim/uyarlama veya düzeltme işi → kod, etkin yönerge, adapter, configuration ya da başka gerçek uygulama ve üretici testleri; DR06/10/11/13 ve ilgili tasarımcıya.  
**Yetki/sınır:** Tasarımın uygulanamazlığı DR02/03/01'e döner; kapsam ve kabul ölçütü sessizce değişmez. Her metin üretimi F2 değildir. Kendi testi bağımsız güvence yerine geçmez; tek işe özgü uygulama da geçerli teslimattır.

### DR06 — Çalışma Koordinatörü · F3

**Amaç/motivasyon:** Yetkili işin, taleplerin ve devirlerin sahipsiz kalmadan ilerlemesi; yerel kapatma sayısı değil gerekçeli üst işin sürmesi.  
**Girdi/yeterlik:** Yaşayan plan, dependency/ready bilgisi, rol ve ortam durumu, sonuç/engel/devir kayıtları; admission, coordination, configuration assembly ve yeniden giriş yönetimi.  
**Tetik → teslimat/tüketici:** Çalışma başlangıcı, uygun iş, rol talebi/cevabı, engel, tamamlanma veya yeniden giriş → atama/başlatma/devir ve current yürütme durumunun uzlaştırılması; ilgili roller ve DR01'e.  
**Yetki/sınır:** Verilmiş politika içinde yürütmeye alır ve sırayı işletir; planın/ürünün bütün teknik kararlarını tek başına vermez. DR09/10 katkılarından yararlanır; bütün sistem teslimatıyla tekil katılım/ortam işleminin sahipliğini karıştırmaz. Kanıt gerektiren kapanışı çalışan sayısına veya DONE mesajına indirgemez.

### DR07 — Bilgi Sorumlusu · F3

**Amaç/motivasyon:** Kalıcı bilginin kaynak, anlam, statü ve sürüm ilişkilerini korumak.  
**Girdi/yeterlik:** Yetkili değişiklikler, kaynaklar, ürün/çalışma kayıtları ve lifecycle kuralları; provenance, revision, supersession ve güncellik değerlendirmesi.  
**Tetik → teslimat/tüketici:** Yeni sonuç/karar, düzeltme, çelişki, arşivleme veya devir → current kayıt/index/lifecycle işlemi ve etkilenen tüketicilerin işaretlenmesi; DR08/06 ve ilgili üreticilere.  
**Yetki/sınır:** Kayıt bakım yetkisi domain kararı veya gerçeği üretmez. Çözülemeyen çelişki görünür tutulur. Ürün ve DevOS kayıtlarının hepsini tek dosya/tek yazıcıya toplama kararı verilmez.

### DR08 — Bağlam Kurucusu · F3

**Amaç/motivasyon:** Belirli rolün o iş için yeterli, güncel ve yetkili bilgi görünümünü alması.  
**Girdi/yeterlik:** İş/rol/claim, kaynak rotaları, sürüm ve görünürlük koşulları; use-conditioned seçim, derin okuma ve context oluşturma.  
**Tetik → teslimat/tüketici:** Rol etkinleşmesi, bilgi talebi, yetersiz bağlam veya önemli girdi değişimi → kaynak bağları ve açık eksikleriyle bağlam paketi; doğrudan ilgili role, koordinasyon için DR06'ya.  
**Yetki/sınır:** Özetin yeterli olduğunu varsaymaz; role bütün geçmişi kopyalamayı da başarı saymaz. Yeni araştırma gerekiyorsa DR16'ya ihtiyaç çıkarır. Paketin oluşturulması gerçek exposure/use kanıtı değildir; consumer kontrolleri P3/P6'da gerekir.

### DR09 — Rol ve Katılım Sorumlusu · F3

**Amaç/motivasyon:** Gerekli sorumluluğun uygun ve yetkili aktörle doğru kapsamda etkin bağ kurması.  
**Girdi/yeterlik:** Rol sözleşmesi, yeterlik sonucu, meşru grant, episode/scope ve aktör availability'si; participation ve replacement/lifecycle bilgisi.  
**Tetik → teslimat/tüketici:** Görevlendirme, katılım değişimi, actor replacement veya retirement → bind/activate/deactivate/reassign işlemi ve doğru current katılım kaydı; DR06/10/07'ye.  
**Yetki/sınır:** Yeterliği DR13 yerine onaylamaz; yetkiyi DR12 yerine yaratmaz. Aktif etiketi hazır ortam veya gerçekleşmiş çalışma değildir. Gerçek yetersizlikte uygun aday/uzmanlık ihtiyacını geri açar.

### DR10 — Ortam İşleticisi · F3

**Amaç/motivasyon:** Yetkili çalışma için gerekli gerçek araç, erişim ve çalışma koşullarını hazır ve gözlenebilir tutmak.  
**Girdi/yeterlik:** Ortam ihtiyacı, gerçek capability/configuration, izinler ve effect sınırları; hedef ortam operasyon bilgisi.  
**Tetik → teslimat/tüketici:** Hazırlık, erişim sorunu, ortam değişimi veya operational recovery → mevcut mekanizmalarla provisioning/bağlantı/işletim ve gözlem; DR06/09/11 ve çalışan role.  
**Yetki/sınır:** Eksik mekanizmayı olmuş saymaz; geliştirme DR05'e döner. Araç çağrısının başarılı olması istenen gerçek etkinin oluştuğunu garanti etmez; grant/enforcement ve readback ayrı kalır.

### DR11 — Sınama Yürütücüsü · F3

**Amaç/motivasyon:** Sınamayı doğru hedef/sürüm/koşullarda yürütüp kullanılabilir kanıt üretmek.  
**Girdi/yeterlik:** DR04 sınama tasarımı, exact target ve Environment, fixture ve kayıt yolu; kampanya/rerun ve kanıt yakalama bilgisi.  
**Tetik → teslimat/tüketici:** Hazır değerlendirme veya yeniden sınama → koşu koşulları, gözlemler, başarısızlık ve eksiklerle kanıt paketi; DR13 ve DR06'ya.  
**Yetki/sınır:** Kriteri veya sonucu geçirecek veriyi sessizce değiştiremez. Koşu bitişi ürünün yeterliği değildir; koşulamayan test yeşil sonuç yapılmaz.

### DR12 — Yetki ve Kontrol Sorumlusu · F4

**Amaç/motivasyon:** Çalışmanın meşru mandate, delegation ve effect sınırları içinde kalması.  
**Girdi/yeterlik:** Müşteri yetkisi, kapsam, grant/revocation ve kontrol koşulları; doğrudan/dolaylı eylem yolu ve authority ayrımları.  
**Tetik → teslimat/tüketici:** Yetki belirsizliği/değişimi veya kontrol gerektiren geçiş → kapsamlı yetki/kontrol hükmü ve uygulanması gereken sınır; DR06/09/10 ve ilgili role.  
**Yetki/sınır:** Üst mandate üretemez; doğru verilmiş delegasyon içinde teknik kararları gereksizce müşteriye taşımaz. Her rutin adımda manuel onay görevi değildir. Kontrolün fiilen etkili oluşu DR13 kanıtına ayrıca tabidir.

### DR13 — Güvence İnceleyicisi · F5

**Amaç/motivasyon:** Exact iddia için kanıtın neyi desteklediğini tarafsız ve kapsamlı biçimde belirlemek.  
**Girdi/yeterlik:** Gereksinim, doğrudan artefakt/kaynak, uygun kriter ve evidence; davranış, bilgi, aktör yeterliği, Work, ortam/etki veya bütünlük için gerekli uzmanlık profili.  
**Tetik → teslimat/tüketici:** Kritik öneri/plan, tamamlanma iddiası, değişiklik veya yetersiz evidence → desteklenen/desteklenmeyen/doğrulanamayan yönleriyle scoped hüküm; ilgili sorumlu, DR06 ve gerekiyorsa DR01/14'e.  
**Yetki/sınır:** Mutlaka kusur bulmak veya onaylamak görevi değildir. Aynı değişikliği onarırsa üretici katkısı ayrıca ayrılır; bağımsızlık kendiliğinden korunmuş sayılmaz. Müşteri kabulü yerine geçmez. Tek genel çağrının bütün alanları doğrulayabileceği varsayılmaz.

### DR14 — Teşhis ve Etki Analisti · F6

**Amaç/motivasyon:** Başarısızlık veya değişikliğin nedenini, etkilediği bağı ve doğru geri dönüş işini saptamak.  
**Girdi/yeterlik:** Olay/karşılaştırma, kaynak/sürüm, karar bağı, farklı neden adayları ve gerçek çalışma izleri; ilgili domain ve nedensel analiz.  
**Tetik → teslimat/tüketici:** Failure, uyuşmazlık, belirsiz etki veya önemli değişiklik → kanıtla orantılı teşhis, invalidation kapsamı ve recovery önerisi; DR01/06 ve düzeltmeden sorumlu role.  
**Yetki/sınır:** Her hatayı prompt, memory veya kullanıcıya bağlamaz. Recovery yolunu önermek ile uygulamak ayrı; acil durdurma yetkisi varsa kapsamı ayrıca verilmelidir.

### DR15 — Öğrenme ve Yöntem Sorumlusu · F7

**Amaç/motivasyon:** Deneyimden gerekçeli, korunabilir ve kullanımda sınanabilir yöntem değişikliği çıkarmak; tek olayı evrensel kural yapmamak.  
**Girdi/yeterlik:** Sonuçlar, tekrar desenleri, karşı kanıt ve mevcut yöntem/birikim; adaptation, retention ve expression ayrımları.  
**Tetik → teslimat/tüketici:** Deneyim, tekrarlanan hata veya yöntem değerlendirmesi → değiştir/koru/sadeleştir/kullanımdan kaldır önerisi ve kapsamı; DR01/02/03 ile kayıt için DR07'ye.  
**Yetki/sınır:** Kendiliğinden kalıcı politika veya grant değiştirmez. Gerçek değişim ilgili tasarım/üretim/işletim rollerine, yarar iddiası uygun güvenceye gider. Yeni kural sayısı başarı değildir.

### DR16 — Araştırmacı · F8

**Amaç/motivasyon:** Yetkili bilgi sorusunu kaynak/gözlemle aydınlatmak; desteklenmeyen kesinlik değil kullanılabilir bilgi sonucu üretmek.  
**Girdi/yeterlik:** Soru, karar değeri, kapsam/zaman/sürüm, mevcut birikim ve erişim; konuya uygun araştırma ve kaynak değerlendirme.  
**Tetik → teslimat/tüketici:** Herhangi bir rolden gelen ayrı araştırma teslimatı ihtiyacı → kaynaklı bulgu, karşı örnek, sınır ve açıklar; isteyen role, kalıcılık için DR07'ye.  
**Yetki/sınır:** Araştırma sonucunu teknik/product adoption kararı gibi ilan etmez. Negatif veya sonuçsuz bulgu geçerli olabilir; erişimden dolayı yarım kalan iş çözülmüş soru değildir. Her küçük arama için ayrı actor çağrısı gerekmez; diğer rollerin araştırma yapma kabiliyeti alınmaz.

## 5. Birleştirme, uzmanlaşma ve karşı kontroller

**Neden bu bir ilk sözleşme taslağı?** Sekiz aileyi sekiz evrensel ajana çevirmek bilgi, yetki ve teslimat ayrımlarını gizler. İlk R1–R25'i bire bir fiziksel kadro yapmak ise tarihsel ayrıştırmayı kurulmuş organizasyon sayar. Burada nesnesi ve devri uyumlu katkılar için ortak sözleşme kuruldu; expertise ve runtime allocation ayrı tutuldu. Bu karşılaştırma 16 sayısının optimal olduğuna kanıt değildir.

- **DR02 / DR03:** Belirli kapasitenin tasarımı ile tasarımlar arası bütünlük ayrı teslimattır. DR02'nin dört uzmanlığı silinmez; her görevlendirmede gerekli profil açık olmalıdır.
- **DR01 / DR06:** Gerekli iş/planın kurulması ile admitted iş/talep akışının işletilmesi ayrı. Koordinatör sorgulama yapabilir; bu, bütün planlama ve bilgi seçimini tek başına taşımak zorunda olduğu anlamına gelmez.
- **DR06 / DR09 / DR10:** Bütün iş/configuration devri, exact katılım işlemi ve gerçek ortam işlemi farklı sahipliklerdir. Aynı transaction'a belirsiz iki primary owner verilemez; somut arbitration P3'tedir.
- **DR07 / DR08:** Kalıcı nesnenin lifecycle'ı ile belirli consumer'ın o anki görünümü ayrı. Aynı yeterli actor taşıyabilir; görevlendirmede mutation ve access sınırı kaybolmaz.
- **DR04 / DR11 / DR13:** Sınama yolunu tasarlama, koşma ve kanıt hükmü ayrı. Her durumda üç ajan zorunlu değil; sırf aynı dosyada buluştu diye bağımsızlık varsayılmaz.
- **DR14 / DR15:** Belirli olaydan doğru recovery işi ile deneyimden tekrar kullanılabilir yöntem değişikliği ayrı. Bir olay değişiklik gerektirmeyebilir.

### Masa başı karşı vakalar — canlı deney değil

| Durum | Taslağın gerektirdiği davranış / açık yük |
|---|---|
| Henüz SOUL için bir görev listesi yok | DR01 hedef/birikimden ihtiyaç üretir, DR16 bilgi açığını araştırabilir, ilgili tasarımcı ve DR13 öneriyi sorgular; DR06 uygun işleri yürütmeye alır. Görevleri assistant'ın dışarıdan seçmesi gerekmez. Bu sadece sorumluluk rotasıdır; P3'ün tam akışı değildir. |
| Araştırma isteği yazıldı, kimse çalışmıyor | Talebin kayıtlı olması K1'i kapatmaz. DR06 çağrı/devir yükünü, DR09 katılımı taşır; çağırma mekanizması P4/P5'te gösterilir. Batu rutin dispatcher yapılmaz. |
| Araştırmacı gerekli kaynağa ulaşamadı | Eksiklik tüketiciye döner; DR08/10 erişim ayrımını açar. Kanıtsız bulgu karar veya tamamlanma sayılmaz. |
| Sınamayı yazan üretici her şeye geçti diyor | DR11 koşu kanıtını ayırır; DR13 oracle, kapsam ve independence'ı sorgular. Ayrı isim tek başına bağımsızlık değildir. |
| Bilgi güncellendi ama çalışan rol eski sürümü kullanıyor | DR07 lifecycle/etki işaretini, DR08 actual bağlam değişikliğini, tüketici kendi gerekçesini taşır. P3 notification/consumer yolunu tasarlamalı. |
| Koordinatör bitti sayısını artırmak için açık soruyu kapatıyor | DR01 üst amaç/planı; DR13 closure iddiasını sorgular. Koordinatöre koşulsuz bitirme başarısı yüklenmez. |
| Yeni uzmanlık gerekiyor ama role bir isim verdik | İsim yeterlik değildir. DR09 uygun bearer ihtiyacını, DR16 araştırma açığını, ilgili tasarımcı gerekli capability'yi açar; kalite düşürülmez. |

## 6. Lineage ve kapsam kontrolü

ACTORS registry'sindeki birincil R eşlemesi yerel Python ile sayıldı: R1–R25 birer kez, eksik/fazla/tekrarlı kimlik yok; F1–F8'in her biri temsil ediliyor. R10 kasıtlı kaldırıldığında missing, tekrar eklendiğinde duplicate saptandı. Bu yalnız **eşleme envanterinin mekanik kontrolüdür**; uzmanlıkların birleşebilirliğini veya gerçek sistem başarısını kanıtlamaz. Envanter ve eşleme aynı assistant tarafından hazırlanmıştır.

DR05 ve DR16 initial R listesinde açık adlandırılmamış F2/F8 teslimatlarını; DR07/09 ise S1'de bulunan iki F3 operational uzmanlığı görünür taşır. M1–M9 requirement'ları hangi actual actor'un gerçekleştirebildiği bu tur kanıtlanmadı. 100 C için yeni bağımsız coverage deneyi yapılmadı; S1-17'nin mevcut haritası ve bu turdaki R/specialization bağlantısı kullanıldı.

## 7. Gerçek okuma ve kanıt izi

Bu tur main `b0743c6` olarak alındı. AGENT yeniden tam okundu; aynı konuşmada tam yüklenmiş gerekli kontrol protokolleri, son R08 kısa iletişim değişikliği dahil korundu. Araştırma kanıtı olarak kullanılmadı.

Current INDEX/HANDOFF/WORK/DECISIONS yeniden tam okundu. STATE, ACTORS, U002 ve P1-01'in aynı konuşmada görülen tam, unchanged içerikleri korundu. WORK iki parçada, S1-03 iki parçada okundu. S1-02'nin ilk görünümü sonunda kesildi; 75–110 aralığı son bölümü tamamladı, 110–200 boş döndü. Bütün S1 veya Foundation/studies korpusu bu tur yeniden okunmuş sayılmaz.

| Kod | Kaynak / kapsam / blob |
|---|---|
| F-ROOT | `research/soul-foundations/STATE.md`, tam; `6d1c3db664bb154546cb6c0bf5edc6da5275dcf8`. REUSE'nin aynı konuşmadaki tam içeriği korundu. |
| F-A | [Actors INDEX](../../../research/soul-foundations/03_ground-deepening/grounds/actors/INDEX.md), STATE ve [ground synthesis](../../../research/soul-foundations/03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md), tam; synthesis `28ae2efed0bc19255e2df678b30480450c60e572`. Önceki tüm vertical ve özgün dış kaynaklar yeniden okunmadı. |
| F-W | [Work INDEX](../../../research/soul-foundations/03_ground-deepening/grounds/work/INDEX.md), STATE ve [ground synthesis](../../../research/soul-foundations/03_ground-deepening/grounds/work/synthesis/WORK-GROUND-AUDIT-SYNTHESIS.md), tam; synthesis `5967c60b7650c0493cfb21813ff894b678a54138`. Synthesis'in eski awaiting etiketi current STATE'deki accepted sonucunu değiştirmez. |
| S-SP | [Superpowers META](../../../research/studies/superpowers/META.md) ve [S03](../../../research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md), bu tur tam; S03 `f69f5c99aefa2a6a13b4233ae49afd73dc2ce0ca`. Kaynaklarına yeniden live-product doğrulaması yapılmadı; bu, study yorumunun yeniden kullanımıdır. |
| S-WM | [Work-management META](../../../research/studies/work-management-project-control/META.md) ve [U10](../../../research/studies/work-management-project-control/10-CLOSURE-EVALUATION.md), aynı konuşmada daha önce tam görülen unchanged içerik korundu; U10 `e140a0cac67d41af1d3b45dfdddf1eccedfcc860`. |
| S1-02/03 | [S1-02](S1-02-actor-conditioned-role-purpose.md) `b7041ee6237e1e24e150a3bd6e0fc7a4a7d8d41f` ve [S1-03](S1-03-role-purpose-activation-and-transfer.md) `0ff47fb0ca829c8abe52a83df4596d03249a5454`, bu tur tam; tarihsel analiz olarak. |
| S-KEEL | [OS Architect rol sözleşmesi kaydı](https://github.com/batuhanozgun/os-architect/blob/20e42a098ea1599a9dfe6558352eb585d6f274ed/bilgi/keel/rol-sozlesmesi.md), bu tur tam; `abd738546d17bd8d24b9f05a1e49a70f491e8756`. Kaynağın kendi derlenmiş tarihsel yorumudur, canlı Keel/Claude davranışı değildir. |

Studies seçiminde aynı konuşmada okunmuş CATALOG ve S1/WORK rotaları kullanıldı. Yeni candidate study, Foundation değişikliği veya source repo mutation'ı yapılmadı. P1'in platform özellikleri bu tur yeni teknik seçime dayanak yapılmadı veya yeniden doğrulanmış sayılmadı; P1 Q01–Q06 yükleri korunur. Buradaki öneriler uzmanlık/rol tasarım çıkarımlarıdır, deneysel motivasyon yasası veya canlı ajan testi değildir.

## 8. Devir

P2'nin ilk adlandırılmış rol/sözleşme taslağı hazırdır. Bu taslak kullanıcıya döner; nihai kadro olarak kabul edilmiş sayılmaz. **Sonraki plan işi P3'tür:** bu rollerin WORK–INFORMATION döngüsünü, talep/cevabın tüketilmesini, karar ve kayıt sahipliğini tasarlamak; bunun gösterdiği eksik/uyumsuz rol sınırları için P2'ye geri dönmek.

P3'ün ilk alt kapsamı hedef/birikimin devrinden gerekli işin keşfine, bilgi/inceleme talebine ve gerekçeli plan/admission'a uzanan çalışma yoludur. Bir SOUL teknik görevini dışarıdan seçmek değildir. Ayrıntılandırılacak yükler: tekil talep sahibi, konuya göre karar sahibi, uzlaşmazlık yolu, tüketici bilgisi, kayıt sürümü, routine trigger ve uygun durma/yeniden giriş.

P4'te alt ajan/takım ve gerçek actor allocation; P5'te actual dosya/yükleme/izin; P6'da işleyiş/kalite/independence sınaması yapılır. Bu tur P3 yürütülmedi ve bu sonraki aşamalar otomatik başlatılmadı.
