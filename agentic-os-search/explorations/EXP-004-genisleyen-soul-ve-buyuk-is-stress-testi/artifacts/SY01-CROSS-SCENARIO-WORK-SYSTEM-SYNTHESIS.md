# EXP-004 / SY01 — İki senaryodan çalışma sistemi sorumluluklarına

**Tarih:** 2026-09-21. **Tür:** T1–T15 üzerine sınırlı ara sentez; yeni stress testi, tam konuşma transkripti, kabul edilmiş mimari veya uygulama değildir. **Başlangıç ref:** `9ce108652e7383ef6a0390fd5272193925cf6fb5`. **Kullanıcı yönü:** Önceki mesaj Development OS, SOUL ve yürütülecek kullanıcı işinin birlikte önemini vurguladı; son «devam et lütfen» yönü önerilmiş ara sentezi yetkilendirir. Gerçek roman/soru bankası üretimi veya target-repository geliştirmesi açılmaz.

## 1. Sentezin sorusu ve sonucu

Başlangıç sorusu, büyük bir kullanıcı işi için SOUL'un hangi çalışma yapısını oluşturması gerektiğiydi. Agent, rol, iş, plan ve memory başlangıç adaylarıydı. Soru-bankası ve roman karşı durumları bu adayların arkasındaki sorumlulukları açtı.

**Çalışma hipotezi:** SOUL, kullanıcı amacına göre işi ve o işi yapma düzenini birlikte geliştirebilen; gerekli alan yetkinliğini, bilgi ve çalışma koşullarını sağlayan; parçaların ve değişikliklerin ortak etkisini değerlendiren; yeterli dayanak ve yetkiyle ilerleyip gerekçeli biçimde durabilen veya yeniden açabilen bir çalışma sistemi olabilir.

Bu bir ürün tanımı olarak kabul edilmedi. Özellikle «gerekli olanı fark eder» ve «uygun değerlendirme yapar» ifadeleri, kurulmuş mekanizma değil, hâlâ açıklanması ve sınanması gereken kapasite yükleridir.

## 2. Birbirine karıştırılmaması gereken üç bakış

**Foundation bakışı:** Work / Actors / Information / Environment ve Binding / Standing / Control / Transition ayrımları, sistemde hangi gerçeklik ve ilişkileri kaçırabileceğimizi sorgulamaya yarar. Bunlar dört servis, dört veri tabanı veya zorunlu işlem sırası değildir. Bir sonucu bu başlıklara yerleştirebilmek doğal-dil muhakemesini veya uygulama yeterliliğini göstermez.

**Sorumluluk bakışı:** İş ilerlerken neyin yerine getirilmesi gerekir? Aşağıdaki sekiz grup bu ara sentezin okunabilir düzenidir; yeni Foundation hiyerarşisi, eksiksiz ontoloji veya sekiz-modüllü tasarım değildir. Gruplar örtüşebilir.

**Gerçekleştirme bakışı:** Sorumluluğu insan, model, araç, kalıcı kayıt, çalışma yöntemi ve ortamın hangi düzeni karşılayacak; bunun işe yaradığını hangi kanıt gösterecek? Bu soru, sorumluluk başlığının bulunmasıyla kapanmaz.

## 3. Ortak sorumluluk haritası

| Yerel kimlik | Sorumluluk adayı | Soru-bankasındaki görünüm | Romandaki görünüm | Önceki dayanak |
|---|---|---|---|---|
| S1 | Amaç, kapsam, kabul ve karar takdirini kurmak/korumak | Hedef kapsam, kullanım ve yayın kabulü | Yaratıcı yön, keşfe açık alan, editoryal takdir | T1, T6, T11, T12, T15 |
| S2 | İhtiyaç ve işi keşfetmek, yöntem alternatiflerini ve başlamayı yönetmek | Müfredat dayanağı veya doğrulama ihtiyacını çıkarmak | Nihai bölümden önce keşif sahnesi; eksik motivasyon hazırlığını fark etmek | T2, T11–T13 |
| S3 | İşin konusunu ve bilgisini uygun anlam/statüyle temsil etmek, gerektiği gibi birlikte kullanmak | Kaynak/sürüm/kapsam/kabul durumunu korumak | Olay, karakter inancı, plan, taslak ve okura açılmayı ayırmak | T4, T12–T14 |
| S4 | Gerekli yetkinliği, katılımı ve çalışma imkânını gerçekten sağlamak | Araştırma, matematik kontrolü, pedagojik değerlendirme ve yayın imkânı | Yaratıcı yazım, kaynak okuma, bütünsel revizyon ve editoryal yeterlik | T3–T5; T12, T15 |
| S5 | Ortak yükümlülükler ve kaynaklar altında işi yürütmek; gerçekleşen etkiyi izlemek | Kapasiteyi aşmadan atama; kontrolü atlamadan doğru sürümü yayınlama | Farklı revizyonların çelişmemesi; seçilen yönün gerçek metne uygulanması | T5, T9, T10, T13 |
| S6 | İddiaları değerlendirmek, tercihler arasında karar vermek ve doğru kapsamda teslim etmek | Doğruluk, pedagojik uygunluk, kabul ve kullanım etkisinin ayrılması | Çelişki, gerekçelendirme, estetik tercih ve okur etkisinin ayrılması | T6, T11, T14, T15 |
| S7 | Sürekliliği, değişiklik etkisini, koruma/onarım ve yeniden giriş koşullarını yönetmek | Yarım kalan işlemin etkisini uzlaştırma; eski kaynakla kurulmuş işleri yeniden değerlendirme | Eski adayın kanona sızmaması; değişen motivasyonun önceki sahnelere etkisi | T7, T12–T15 |
| S8 | Çalışma düzeninin kendisini, maliyeti ve faydasıyla kontrollü geliştirmek | Hatalı bilgi devri yöntemini değiştirmek; yeni kontrolün gerçekten kullanımını izlemek | Tekrarlayan editoryal salınımı gidermek; bağlam ve revizyon yöntemini iyileştirmek | T8–T11, T15 |

Sorumluluk ihtiyacı koşulludur. Büyük iş varsayımı önemlidir; fakat bütün işleri aynı araçlar, kayıt yoğunluğu, aktör sayısı veya onay zinciriyle yönetmeyi gerektirmez. Yeni bir işte bu haritanın eksik veya yanlış ayrılmış olduğu da gösterilebilir.

### Üretme kapasitesi haritanın dışında kalmamalı

S4 yalnız «rol kaydı var» demek değildir. Rolü gerçekleştirecek yeterlik gerekir. Bir aktöre romancı veya pedagojik uzman adı vermek o yeterliği yaratmaz. Yeterlik de her kullanım, bağlam ve çıktı için sınırsız değildir.

Sistemin en iyi kayıt ve kontrol düzenine sahip olması, yeterli nitelikte metin, soru, analiz veya karar üretebildiğini göstermez. Alan bilgisi, üretim becerisi ve muhakeme; uygun organizasyon, bilgi ve ortamla birlikte değerlendirilmelidir. Kullanıcı, eksik alan yetkinliğini sürekli gizli işçi veya orkestratör olarak tamamlamak zorunda bırakılmamalıdır. Gerçek insan katkısı gerekiyorsa katkının rolü, maliyeti ve kabul sınırı görünür olmalıdır.

## 4. İşin takibi ile işin konusunu anlamak ayrı

«Bölüm 8 tamamlandı» iş durumudur. «Derya bu noktada mektubu gördü mü?» eserin içindeki bilgi ilişkisidir. «Bu ilişki metinde yeterince kurulmuş mu?» bir değerlendirme iddiasıdır. «Bu sürümü teslim edelim mi?» ayrıca yetkili karardır.

Aynı ayrım soru-bankasında da vardır: 500 soru yazılmış olması, hangi kazanımların gerçekten kapsandığını veya yanlış bir cevabın nasıl fark edileceğini göstermez. T6 ve T14 yerel tamamlanma ile bütünsel yeterliği farklı şekillerde zorladı.

Bu nedenle genel görev yöneticisinin yanında görevin konusunu anlamaya yarayan temsiller ve alan yetkinliği gerekir. Buradan ayrı bir Domain Model Service veya bütün bilgiyi biçimselleştirme zorunluluğu çıkarılmaz. Bilginin bir kısmı asıl metinde, bir kısmı kaynaklarda, kararlarda veya araçların içinde kalabilir; gerektiğinde geri erişilebilir ve doğru statüyle kullanılabilir olmalıdır.

Romanın kurmaca kişileri, roman üzerinde çalışan SOUL aktörleriyle aynı nesne değildir. Bir çalışma aktörü finali biliyor olabilir; kurmaca kişinin o bölümde bildiği şey farklıdır. Bu ayrım, yaratıcı sistemi yanlış bir çok-ajan rol oyununa indirgememek için korunur.

## 5. Ortak sorumluluk, ortak yöntem demek değil

Soru-bankası «tamamen nesnel», roman «tamamen öznel» değildir. Pedagojik uygunluk da yorum/tercih ve kullanım kanıtı isteyebilir; romandaki bazı zaman, olay ve bilgi-aktarımı iddiaları ise açık biçimde sınanabilir. Yöntem seçimi yalnız ürün adına değil, değerlendirdiğimiz belirli iddiaya bağlıdır.

| Ayrım | Genellenebilen sorumluluk | Otomatik genellenmemesi gereken yöntem |
|---|---|---|
| Kaynak ve statü | Karar, hipotez, kanıt ve üretilmiş içeriği karıştırmamak | Kurmacadaki kabul edilmiş olayı dış kaynak doğrusu gibi görmek; dış gerçeği yaratıcı tercihle değiştirmek |
| Değerlendirme | İddiaya uygun dayanak ve hata-duyarlılığı aramak | Matematik çözümleyicisini pedagojik veya edebî kalite oracle'ı yapmak |
| İlerleme | Gerekli koşul ve yetki altında tamamlanan kapsamı ilerletmek | Bağımsız soru dilimini yayımlama kuralını roman bölümlerinin bütünsel kabulüne kopyalamak |
| Bağlam | Kullanımın gerektirdiği ayrımı ve kaynağa dönüşü korumak | Her durumda bütün metni yüklemek veya yalnız özetle yetinmek |
| Geri dönüş | Kararın etkisini, korunacakları ve yapılacak onarımı belirlemek | Dış dünyadaki etkiyi bir metin sürümünü geri alır gibi ortadan kalkmış saymak |
| Anlaşmazlık | Olgusal karşı kanıt, yorum, tercih ve yetkiyi ayırmak | Bütün sorunları çoğunluk oyu, aynı denetleyici veya daha fazla araştırmayla çözmek |

Bu sentez «bütün yöntemleri bir araya getirelim» sonucu üretmez. Work Management çalışmasının farklı yöntem ailelerini koruyup tek ürün veya evrensel model seçmemesi bu noktada karşı baskıdır. Aktarımın hedef kanıtı ayrıca gereklidir.

## 6. Temsil, mekanizma, kapasite ve gösterilmiş sonuç

Örneğin «değişiklik etkisini takip etmek» için şu ayrımlar korunmalıdır:

1. **İhtiyaç/sorumluluk:** Yük taşıyan bir değişiklik ilgili eski içeriği veya hükmü sessizce yanlış bırakmamalı.
2. **Temsil:** Sürüm, kaynak, karar gerekçesi, bağlantı veya etki adayı kayıtları bu soruyu taşımaya yardımcı olabilir.
3. **Mekanizma adayı:** Kaynakla karşılaştırmalı okuma, bağımlılık takibi, yeniden değerlendirme veya farklı bir çalışma düzeni uygulanabilir.
4. **Kapasite:** Sistem yeni durumda hangi bağı bulması gerektiğini gerçekten keşfedip uygun müdahaleyi üretebiliyor mu?
5. **Gösterilmiş sonuç:** İlgili bozma durumunu yakaladığı, sağlam durumu gereksiz reddetmediği ve hedef kapsamda kabul edilebilir maliyetle çalıştığı gözlenmiş mi?

Bu beşli yeni bir kalite sertifikası veya zorunlu veri şeması değildir. Özellikle mekanizmanın varlığı ile yeni durumlarda başarı ayrı tutulur.

`Run / Execution Attempt`, `Qualification Case`, karar kaydı, yeniden giriş bağlamı ve kabul/adayı ayıran kayıtlar, önceki testlerden çıkan temsil adaylarıdır. Ayrı servis, veritabanı veya her durumda zorunlu nesne olmaları kararlaştırılmadı.

Bir `DEPENDENCIES` dosyası veya graf, keşfedilmiş ilişkileri tutabilir. Henüz keşfedilmemiş bağı kendiliğinden bulmuş sayılmaz. Bir `verification_status` alanı değerlendirme sonucunu taşıyabilir; uygun doğrulayıcıyı yaratmaz. Bir rol tanımı, çalışan aktörün o rolün gerektirdiği muhakemeyi yapabildiğini göstermez.

## 7. Üç sorumluluk düzeyine aktarım

Buradaki üç düzey yazılım deployment katmanı veya birbirinden tamamen kopuk üç ürün olarak kabul edilmez. Aynı yükümlülüğün hangi nesne üzerinde yerine getirileceğini ayıran bir sentez görünümüdür. Gerçek Development OS/SOUL repository'lerinin güncel kurulumu bu tur incelenmedi; aşağıdaki ifadeler kurulacak kapasiteye ilişkin aday sorumluluklardır.

| Kullanıcı işindeki ihtiyaç | SOUL açısından gereken kapasite | Development OS açısından ileride gereken geliştirme/doğrulama işi |
|---|---|---|
| Eksik kapsam/ilişki veya gerekli Work'ü fark etmek | Verilen görev listesinin yeterli olduğunu varsaymadan ihtiyacı ve uygun araştırmayı keşfetmek | Eksik koşulun önceden söylenmediği durumlar dahil keşif yaklaşımını geliştirmek ve karşılaştırmak |
| Doğru bilgiyi doğru statüyle birlikte kullanmak | Yetersiz görünümü fark etmek; ilgili kaynak ve ilişkileri çalışma bağlamına getirmek | Erişim, seçim, kullanım ve başarının hangi noktada ayrıştığını sınamak |
| Yerel işleri bütünsel sonuca dönüştürmek | Kaynak, yükümlülük, sürüm ve değişiklik etkilerini işler arasında korumak | Tekil başarıyla ortak başarısızlığın ayrıldığı kapsamlı denemeler geliştirmek |
| İddiaya uygun değerlendirme yapmak | Hata, yorum, tercih ve kabul yetkisini karıştırmamak | Gerçekten hata-duyarlı ve göreve uygun değerlendirme yollarını seçip sınamak |
| Yeni oturum/aktörle devam etmek | Durumu kayıttan geri kazanmak ve gerektiğinde gerçek etkiyle uzlaştırmak | Devamı yalnız belgelerden değil fiilî davranış ve hedef durum üzerinden değerlendirmek |
| Yeterli kapsamı teslim edip gerektiğinde yeniden açmak | Bitirmeme ile erken kapatma arasında gerekçeli ilerlemek | Geçerli işi gereksiz engelleme, kritik eksikliği atlama ve karar salınımını birlikte sınamak |

Development OS'un bir yaklaşımı test edilebilir biçimde tarif etmesi SOUL'un onu gerçekleştirdiğini göstermez. SOUL'un sınırlı bir denemede başarması bütün kullanıcı işlerinde güvenilirliğe eşit değildir. Tek bir kullanıcı işinin başarıyla bitmesi de genel kapasiteyi doğrulamaz.

Aynı disiplin Development OS'un kendi geliştirme Work'üne de uygulanmalıdır: tasarım, uygulama, değerlendirme, kabul ve gerçek sürüme geçiş ayrıdır. Bu, SOUL'un tamamını geliştirme başlamadan önce zaten inşa etmek zorunda olduğumuz anlamına gelmez. Başlangıçta daha dar, insan destekli ve sınırı açık bir geliştirme düzeniyle ilerlemek bir seçenek olabilir; bu tur böyle bir bootstrap tasarımı seçilmedi.

## 8. Önceki söyleyişlere üç inceltme

### 8.1 Work-first bir araştırma yönü, zorunlu zamansal pipeline değil

«İşten yeteneğe, rolden aktöre» yönü, rastgele ajan listesi kurmama bakımından yararlıydı. Fakat yeni işin keşfi mevcut aktörlerin, araçların ve alan bilgisinin katkısıyla gerçekleşebilir; bulunan yetenekler de mümkün yöntemleri değiştirir. SOUL'un ilk keşif işi için de bir taşıyıcı ve ortam gerekir; bunları yoktan var sayamayız.

Ayrıca T2'de aktör seçilmeden «actionable frontier» diye anılan küme, tam çalışma koşulları henüz belirli değilse daha doğru olarak koşullu/hazırlık açısından aday kümedir. Tam uygulanabilirlik aktör, bilgi, ortam ve yetkiyle birlikte değerlendirilir; T9 ortak kapasite taahhüdünü de ekler. Bu inceltme eski kaynak yanıtı sessizce değiştirmez.

### 8.2 Plan Work'ün kendisi değildir; fakat yalnız etkisiz bir özet de değildir

Plan gerçek yürütme veya sonuç değildir. Buna karşılık kabul edilmiş bir plan, kimin neyi yapacağına ve hangi geçişe izin verileceğine dayanak olabilir. Etki, plan metninin salt varlığından değil, ilgili karar/bağ/uygulama düzeninden gelir. «Information temsilidir» demek planın denetim ve taahhüt rolünü yok saymak değildir.

### 8.3 Her keşif ve değerlendirme otomatik meta-work değildir

Müfredat araştırması ve romanın karakter keşfi, doğrudan kullanıcı işinin parçası olabilir. Araştırma rolünü yeniden tasarlamak veya kontrol yöntemini değiştirmek çalışma sistemine yönelen iştir. Ayrım, faaliyetin adına değil hangi nesneyi değiştirdiğine bağlıdır. SOUL yalnız meta-work, oluşturduğu aktörler yalnız object-work yapar diye katı görev sınırı çıkmaz.

## 9. Baz SOUL ve işe göre şekillenme

U010/U016'nın açıklamasıyla uyumlu hipotez: SOUL'un baz kapasitesi işe göre yeni yetenekler edinirken mevcut sorumlulukların kapsamı da yeni aktör, bilgi ve etki yollarını kapsayabilir. Bu bir tek-process, tek-repository, yeni klasör yasağı veya sonsuz büyüme kuralı değildir. İş bittiğinde bazı yapılar daralabilir, birleşebilir, devreden çıkarılabilir; gerekli geçmiş korunabilir.

Şu kapsamlar ayrı kalır:

- Baz çalışma kapasitesi: işi ve uygun çalışma düzenini oluşturabilme/yürütebilme kapasitesi; tam içeriği açık.
- İşe özgü çalışma düzeni: o amaç için seçilmiş roller, kaynaklar, araçlar, yöntemler ve kararlar.
- Yeniden kullanılabilir aday öğrenme: bu işten başka işlere aktarılması değerlendirilebilecek bilgi/yöntem.

Bir romanda yerel olarak seçilen anlatım tercihi otomatik bütün SOUL için yazım politikası olmaz. Soru-bankasındaki belirli kontrol de bütün işler için zorunlu doğrulayıcı olmaz. Yerel başarı, aktarım ve baz davranış değişikliği ayrı değerlendirme/karar gerektirir. Bu ayrımlar kalıcı üç yazılım katmanı değildir.

## 10. İki senaryonun gösterdiği ve göstermediği

**Gösterilen dar şey:** Açıkça kurulmuş karşı durumlarda bazı eşitlemeler geçersizdir. Örneğin tek tek uygun değişiklikler ortak kontrolü kaldırabilir (T9); aynı kaba özet karar-kritik bilgi aktarımı farkını örtebilir (T14). Mantıksal karşıörneklerin geçerliliği kurulan koşullara bağlıdır.

**Gerekçelendirilmiş aday ihtiyaç:** Ortak koşul koruma, kaynak/statü sadakati, uygun bağlam kurma, etki keşfi, yetki ve tercih ayrımı gibi sorumluluklar iki vakadan türetilebilir. İki örnekte görünmek evrensel zorunluluk kanıtı değildir; sorumluluk, uygulama ve kapsam yeni işte ayrıca sınanır.

**Henüz gösterilmeyen:** SOUL'un bu koşulları kendiliğinden fark etmesi, uygun yetkinliği edinmesi, yeni bir görevi baştan sona güvenilir yürütmesi, özet kaybını doğru zamanda bulması, gerçek okur/öğrenci etkisini sağlaması veya bunu kabul edilebilir maliyetle yapması.

Senaryolar büyük iş çerçevesinde düşünüldü; fakat aylarca süren iki gerçek sistem veya tam roman üzerinde deney yapılmadı. Soru-bankasında birçok başlangıç koşulu varsayıldı. Romanda mikro-pasajlar kullanıldı; kapsamlı eser ve okur tepkisi yok. Birçok tehlikeyi tartışmanın kendisi önceden verdi. Dolayısıyla «işaret edilmiş sorunu doğru açıklamak» ile «işaret edilmemiş sorunu zamanında keşfetmek» ayrı sınama hedefleridir.

Aynı assistant örnekleri kurdu, çözüm yollarını yorumladı ve sentezledi; bu bağımsız değerlendirme değildir. İşleyişi doğru anlatmak, o işleyişi çalıştırmış olmak değildir. İş sayısı, dosya sayısı veya taxonomy coverage'ı başarı puanı yapılmaz.

## 11. Açık kapasite yükleri ve sıralama sınırı

Bu aşamada en belirgin açık yükler:

- hangi eksik koşul veya uzmanlık ihtiyacının aranacağını keşfetmek;
- yetkinliği rol etiketinden veya genel model kabiliyetinden bağımsız yeterli kapsamda değerlendirmek;
- soruya göre yeterli bilgi ve ortak bağlamı güvenilirce kurmak;
- değişiklikten etkilenen anlamı, korunacak kısmı ve hiç yazılmamış gereği bulmak;
- uygun değerlendirme yöntemini seçmek ve onun yanlış/sağlam örneklere duyarlılığını göstermek;
- bütün bunları güvenli fakat yararlı ilerlemeyi durdurmayan maliyet ve kapasite koşullarında yürütmek.

Buradan doğrudan bütün sistemi implement etmeye geçilmez. Sonraki mantıklı, dar kavramsal soru şu olabilir: **SOUL, henüz bize söylenmemiş bir gereksinimi veya yeterlik eksikliğini nasıl keşfeder; keşfettiği ihtiyacı karşılayabildiğini neye dayanarak kabul eder?** Bu soru burada yeni test olarak işletilmedi. Kaynak taraması, ayrı mekanizma deneyi veya Development OS tasarımı için sonraki yetki ve kapsam ayrıca ele alınır.

## 12. Kaynak izleri ve okuma derinliği

Bu not mevcut konuşma ve repository birikiminin sentezidir; bu tur yeni dış araştırma yapılmadı, eski dış yayınlar güncel model/ürün iddiası olarak kullanılmadı.

**Bu tur tam geri okunanlar:**

- EXP-004 STATE: 1–68 ve 69–180; ilk sonuçta yalnız metadata kırpılmış, content sonu C12 sınırına kadar görünmüştür. Başlangıç blob `f73dba9260ffe0c474f1c49f88331c52b0bd7ee2`.
- EXP-004 INDEX: tam content; metadata sonu kısalmıştır. Blob `c5ba6d35093eae069388e15b81c12c37a153dc50`.
- [T1–T7 tarihsel konsolidasyonu](CONSOLIDATION.md): 1–140/141–350; blob `e2867cf73cdda72655afad422bb8be8423fe43f2`. Türetilmiş belge olduğu korunur; onun o dönemde açık bıraktığı T8 ve sonraki işler güncel kuyruk sanılmadı.
- [U016 çerçeve açıklaması](../reflections/FRAME-CLARIFICATION-20260921.md): tam; blob `0ab496cd9740fafb1ea1efb4bbde1717f8e9f338`. Kaynak kullanıcı mesajıyla yorumun ayrımı korunur.
- [T15](../continuations/T15-NOVEL-EDITORIAL-DISAGREEMENT-AND-CHOICE.md): 1–70/71–180 tam; blob `2788224e4f7b5d02f98536145bea035d77715b21`.
- Foundation [STATE](../../../research/soul-foundations/STATE.md), [DISCUSSION-HANDOFF](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md), [REUSE](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md): tam. Reuse bir reçete değildir; üretim tarafının geçmişte atlanması, araştırmanın mevcut olmasıyla doğru kullanımının ayrı kaldığını gösteren kayıtlı konuşma örneğidir. Genel Foundation derinleştirmesi yeniden açılmadı.
- Work Management [META](../../../research/studies/work-management-project-control/META.md), [STATE](../../../research/studies/work-management-project-control/STATE.md), [METHOD](../../../research/studies/work-management-project-control/METHOD.md), [U10 closure](../../../research/studies/work-management-project-control/10-CLOSURE-EVALUATION.md): tam. Yöntem ailelerini birleştirme zorunluluğu olmaması, readiness ayrımları ve tanımlı kontrolün gerçek agent efficacy olmaması için kullanıldı. Dış ürünler yeniden denetlenmedi.

**Seçici/önceki bağlam:** Studies CATALOG 19–58 keşif okuması kısmen kırpılmıştır; bütün katalog tarandı denmez. Seçilen Work Management paketi doğrudan tam açılarak ayrıntı geri kazanıldı. T8–T14 ve SC02 bu tur ayrı ayrı yeniden tam açılmadı; mevcut konuşma, current STATE/INDEX'in sınırları ve önceki okuma bağlamı üzerinden sentezlendi. Korunmuş 31 mesajlık kaynak arşivi veya bütün Foundation/studies yeniden tam okunmuş sayılmaz.

**Soruya göre kaynak rotası:** T1–T7 için [CONSOLIDATION](CONSOLIDATION.md) → [kaynak diyalog](../sources/conversation/INDEX.md); T8 için [T08](../continuations/T08-FEEDBACK-AND-CONTROLLED-ADAPTATION.md)/[S015](../sources/conversation/assistant/S015.md); ortak işler [T09](../continuations/T09-CONCURRENT-CHANGE-AND-SHARED-CONSTRAINTS.md); yeni kapsam [T10](../continuations/T10-EXTENSION-ADMISSION-AND-CONTROL-COVERAGE.md); yeterlilik [T11](../continuations/T11-EVIDENCE-SUFFICIENCY-AND-BOUNDED-PROGRESS.md); yaratıcı statü [T12](../continuations/T12-NOVEL-FORMATION-AND-FIRST-WRITABLE-WORK.md); revizyon [T13](../continuations/T13-NOVEL-SEMANTIC-REVISION-AND-IMPACT.md); birlikte okuma [T14](../continuations/T14-NOVEL-READING-COVERAGE-AND-JOINT-CONTEXT.md); seçim [T15](../continuations/T15-NOVEL-EDITORIAL-DISAGREEMENT-AND-CHOICE.md). Maddi bir iddia tasarım dayanağına çevrilirken asıl kaynağın ve uygulanabilirliğin yeniden incelenmesi gerekir.

Agent-control araştırma kanıtı değildir. İlgili güncel davranış protokolleri çalışmaya uygulanır; bu sentez onların yerine geçmez.

## 13. Süreklilik ve korunacak dosyalar

SY01, EXP-004 STATE ve INDEX ile birlikte yayımlanacak dar ara sentezdir. Eski CONSOLIDATION, T1–T15, SC02, kaynak/manifest/onarım kayıtları, önceki EXP'ler, research, concepts ve agent-control değişmez. Test sayısı T1–T15 olarak kalır; SY01 bir test değildir. Korunmuş 31 mesaj ve 126 kümülatif kaynak adresi artmaz. Kütüphane INDEX/CATALOG'daki T1–T15 bilgisi ve paket girişine yönlendirme hâlâ geçerlidir; SY01 current package INDEX/STATE'ten bulunur.

Bu belge kendi gelecekteki commit'ini veya henüz yapılmamış readback'i başarılı saymaz. Yayın/diff/geri okuma ayrıca kontrol edilir; teknik yayın, içerik doğruluğu veya gerçekleşmiş SOUL kapasitesi kanıtı değildir.
