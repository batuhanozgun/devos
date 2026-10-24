> **30 Eylül 2026 — tarihsel P3 v0.5 tasarım devri.** Aşağıdaki “güncel tek ayrıntı yüzeyi” ve P4'e geçiş ifadeleri 27 Eylül'deki hazırlığa aittir; bugünkü kurulum sırası değildir. D021'deki kullanıcı kabulünün kapsamı, G/Y ayrımı, çalışma alanı bakımı ve platformdan bağımsız H1–H6 güvenceleri korunur. Masa başı senaryo canlı deney veya bütün taslağın kabulü sayılmaz; eski P4/P5 görevi başlatılmaz.
>
> Güncel devir [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. Özgün kullanıcı alıntıları ve aday tasarım gövdesi aşağıda aynen korunur; bu bakım aktarımın eksiksizliğini veya yeni hedefin yeterliğini onaylamaz. Devam noktası [REPOSITORY-TRANSITION](../../../REPOSITORY-TRANSITION.md)'dir.

---

# P3-01 — İş, çalışma alanı ve bilgi sürekliliği

**Üst iş:** [WORK/P3](../WORK.md). **Tarih:** 27 Eylül 2026.  
**Sürüm:** v0.5; başlangıç `51e1fafdc73de93cb992b3db96d0f88e5434066f`.  
**Statü:** DESIGN HANDOFF READY / CANDIDATE / USER EVALUATION. P3'ün kavramsal çalışma taslağı P4 değerlendirmesine hazır bulundu; kullanıcı tarafından bütün ayrıntıları kabul edilmiş veya canlı ortamda doğrulanmış değildir. P4–P6 başlamadı.  
**Rolü:** P3'ün güncel tek ayrıntı yüzeyi. G/Y ve bakım sözleşmeleri korunur; §8 eşzamanlı değişiklik, açık inceleme ve kesinti durumunu birlikte işler. §10 P4'ün karşılaması gereken yükleri sınırlar. [Önceki v0.4](https://github.com/batuhanozgun/agentic-os-search/blob/51e1fafdc73de93cb992b3db96d0f88e5434066f/explorations/EXP-006-development-os-calisma-duzeni/work/P3-01-work-information-discussion.md) kendi kaynak iziyle; [v0.3](https://github.com/batuhanozgun/agentic-os-search/blob/a2ee26c615361f2c88f58ed2d695c03e9386c206/explorations/EXP-006-development-os-calisma-duzeni/work/P3-01-work-information-discussion.md) rol konuşmalarıyla korunur.

## 1. Kullanıcı yönü ve önerinin sınırı

P3 başlangıcındaki istek araştırmadan beslenen bir yapı sunmak ve hemen karar vermeden birlikte değerlendirmekti. Kullanıcı ardından işin koordinasyonu ile yapının koordinasyonunun, ürün denetimi ile çalışma düzeni denetiminin ayrılmasını önerdi. v0.2 bu ayrımı, v0.3 kurgusal rol etkileşimini açtı.

Son netleştirme, görünür kullanıcı mesajıdır:

> “Ben belki detay bir noktaya takılacağım ama ben daha çok çalışma düzeninden bahsediyorum, yani etrafın derli toplu olmasından bahsediyorum, işin içeriği değil de işin yapılması aşamasında kullanılan yapının, dosyaların, klasörlerin, düzeninden falan ya da yeniden kullanılabilir olmasından falan. Ama doğru mu düşünüyorum emin değilim. Sen de buna benzer bir şeyden mi bahsediyorsun?”

Assistant içerik sahibinin ne söylendiği/nedeninden; düzen tarafının nerede, hangi statü ve ilişkilerle korunup yeniden kullanılacağından sorumlu olmasını önerdi. Kullanıcının sonraki görünür mesajı:

> “tamam evet aynı fikirdeyim.  
> şimdi bir toplarla P3'ü.  
> devam edelim.”

**Kabulün kapsamı:** Çalışma alanının düzeni, bulunabilirliği, güncelliği, bakımı, devri ve yeniden kullanımı asli sorumluluktur; içerik kararıyla aynı değildir. Bu D021 olarak kaydedilir. Fiziksel klasör ağacı, rol/ajan sayısı, bütün P3 hükümleri veya teknik topoloji kabul edilmiş değildir. Kaynak aktarımı bu görünür mesajlarla sınırlıdır; platform export'u değildir.

v0.4 sunumundan sonraki “devam et.”, planlanmış iki eşzamanlı iş/ortak kayıt/açık itiraz/kesinti incelemesini yetkilendirir. Bu incelemeden çıkan sözleşme ayrıntıları adaydır. Hazırlanan P4 devri, bu tur P4 seçimi yapma veya gerçek SOUL backlog'u üretme yetkisi değildir.

**Üst sınır:** İlk ve sonraki SOUL işlerini kurulacak ekip keşfeder. Cloud kullanıcı kısıtıdır; teknik seçim P4'te kalır. Kısa sunum, küçük miktarda iş yapmak veya her ayrımda kullanıcı komutu beklemek anlamına gelmez.

## 2. P3'ün birleşik modeli

**Ortak hedef ve iş ağı üzerinde, ihtiyaç etrafında işbirliği; bu işbirliğini sürdüren düzenli ve yeniden kullanılabilir çalışma alanı.**

| Sorumluluk alanı | Ne için var? | Başarı sorusu |
|---|---|---|
| **G — SOUL geliştirme** | Gereken işi keşfetmek, araştırmak, planlamak, tasarlamak, gerçekleştirmek ve değerlendirmek | Doğru işe yöneliyor ve SOUL hedefi için yeterli sonuç üretiyor muyuz? |
| **Y — DevOS işleyişi ve çalışma alanı** | Katılım, iletişim, erişim, bağlam, dosya/kayıt düzeni, bakım, yeniden kullanım ve devri sağlamak | Ekip, doğru çalışma koşullarını ve tekrar kullanılabilir bilgi düzenini gerçekten bulabiliyor mu? |

İkisi de DevOS içinde Work ve reasoning taşır. Y yalnız Claude teknik altyapısı veya Foundation ENVIRONMENT ground'u değildir. Her iki tarafta WORK, INFORMATION, ACTORS ve ENVIRONMENT ilişkileri bulunur. SOUL'un hafızasını geliştirmek G; geliştiren ekibin kendi kayıtlarını işletmek Y'dir. Konunun adı değil hedef nesne belirleyicidir.

İki alan iki kapalı takım, iki repository veya zorunlu iki lead değildir. F1–F8 başarı yönleriyle G/Y hedefleri farklı eksenlerdir. Genel rol yetkinliği gerektiğinde iki hedefte ayrı görevlendirmelerle kullanılabilir; ortak isim aynı uzmanlık veya bağımsızlık garantisi değildir.

## 3. Roller, sahiplik ve iki koordinasyon

[ACTORS](../ACTORS.md) ve [P2-01](P2-01-named-role-contracts.md) DR01–DR16 ilk sözleşme tabanını korur. Aşağıdaki profiller P3 taslak düzeltmesidir; yeni kabul edilmiş ajan sayımı değildir.

| Rol/taban | P3'te taşıdığı sorumluluk |
|---|---|
| DR01 İş Keşfi ve Planlama | Diğer rollerin de keşfettiği ihtiyaçları amaç, gerekçe, alternatif, önkoşul ve yaşayan planda bütünleştirir. |
| DR02 Kapasite / DR03 Sistem Bütünlüğü Tasarımcıları | Konuya uygun uzmanlıkla yerel tasarımı ve alanlar arası uyumu taşır. DevOS yapısına değişiklik gerekirse ayrı ve yetkili hedefle çalışırlar. |
| DR04 Sınama Tasarımcısı / DR05 Uygulama Geliştiricisi / DR11 Sınama Yürütücüsü | Sınama yolu, gerçek üretim ve koşu kanıtı ayrı katkılardır. G/Y hedefi, sürümü ve yetkisi açık olur. |
| **DR06-G SOUL Geliştirme Koordinatörü** | Hangi katkı neyi bekliyor, öncelik nedir, sonuçlar üst işe nasıl birleşecek? Ürün/plan sahipleriyle iş sırasını işletir; bütün teknik kararları üstlenmez. |
| **DR06-Y DevOS İşletim Koordinatörü** | Katkıyı etkinleştirme, çalışma denemesi, kapasite, bakım ve devamı koordine eder. Ürün önceliğini veya kalite ölçütünü sessizce değiştirmez. |
| **DR07 Bilgi Sorumlusu — çalışma alanı bakım kapsamıyla** | Dosya/kayıtların mantıksal yeri, tek yetkili kaynağı, statüsü, kaynak/sürüm bağı, indeksleri, arşiv ve tekrar kullanım bulunabilirliğini korur. İçeriğin doğruluk hakemi veya bütün dosyaların tek yazıcısı değildir. |
| DR08 Bağlam Kurucusu | İş sahibi/uzmanla gerekli görünümü oluşturur; kaynaklara dönüş, sürüm ve eksikleri korur. Herkese bütün geçmişi göndermek veya özeti yeterli saymak yoktur. |
| DR09 Rol ve Katılım / DR10 Ortam İşleticisi | Katılım bağını ve gerçek araç/erişim/ortam işlemlerini ayrı taşır. Assigned/active etiketi gerçek yeterlik, grant veya çalıştırma değildir. |
| DR12 Yetki ve Kontrol | Meşru kapsam/delegasyon/etki sınırları; her rutin işte müşteri onayı istemek değil. Teknik erişimden veya rol isminden yeni yetki çıkmaz. |
| **DR13-G SOUL Geliştirme İnceleyicisi** | İş seçiminin, tasarımın, uygulamanın ve sonuç iddiasının yeterliğini alan uzmanlığı ve uygun kanıtla sınar. |
| **DR13-Y DevOS İşleyiş İnceleyicisi** | Çalışma alanının gerçekten kullanılabilir, güncel, bulunabilir ve devralınabilir oluşunu; gereken iletişim/katılım/izin bağlarını sınar. Temiz görünen klasör yeterli değildir. |
| DR14 Teşhis / DR15 Öğrenme ve Yöntem / DR16 Araştırmacı | Olayın neden/etkisi, deneyimden yöntem değişikliği ve kaynaklı bilgi sonucu ayrı teslimatlardır. G/Y hedefi açık tutulur; öz-değişiklik veya ürün benimseme yetkisi kendiliğinden oluşmaz. |

**İçerik sahibi:** Araştırmacı bulgusunu, tasarımcı kararını, geliştirici uygulamasını, inceleyici hükmünü ve gerekçesini üretir. Y anlamı yeterince anlayarak düzenler; yerleştirme veya isim düzeltmesi bahanesiyle içerik hükmünü değiştirmez. Üreticiler de bakım işini bütünüyle başka role atıp sahipsiz çıktı bırakamaz.

**Karar sahibi işte belirtilir:** İş/önkoşul planını DR01, alan tasarımını ilgili DR02, alanlar arası tasarım uyuşmazlığını DR03 kendi yetkisinde ele alır. DR06-G öncelik ve iş ilişkilerini; DR06-Y verilmiş politika içindeki çalıştırma/bakım seçeneklerini işletir. DR13 kanıt hükmünü idari tercih uğruna olumluya çeviremez. Kapsamı aşan gerçek principal kararı DR12 üzerinden Batu'ya döner; her teknik anlaşmazlık müşteriye aktarılmaz.

**Bir nesnenin güncel sürümünü yayımlayan taraf:** Yetkili yazar/yayın sorumlusu değişiklik kapsamında belirlenir; bu her dosyayı DR07'nin yazacağı anlamına gelmez. İçerik kararını ilgili alan sahibi verir; DR07 yaşam döngüsü ve bağlantı bütünlüğünü, DR06-Y işlemin/devir kaydının ilerlemesini taşır. Aynı değişikliğe belirsiz iki yayın sahibi verilmez. Fiilî izin ve yazma koruması P4/P5 yüküdür.

## 4. Çalışma alanında ne nerede yaşar?

Bu tablo **mantıksal yerleşim önerisidir**, şu anda açılacak klasör ağacı veya depolama ürünü değildir. P4 gerçek erişim/yazma koşullarıyla fiziksel karşılığını seçecektir.

| Mantıksal alan | Korunan içerik | Karışmaması gereken |
|---|---|---|
| **SOUL ürün alanı** | Ürünün tasarım, tanım, kod ve diğer teslimatları; geçerli sürüm ve aday değişiklik bağı | DevOS'un kendi rol talimatı/işletim kuralı ürüne sessizce eklenmez. |
| **DevOS iş ve devam alanı** | Hedef/plan, aday ve etkin işler, talepler, beklemeler, itirazlar, çalışma denemeleri, devir | İşin durumu ile onu çalıştıran oturumun durumu aynı değildir. |
| **Kaynak, karar ve kanıt birikimi** | Araştırma rotaları, bulgular, karar gerekçeleri, inceleme ve test kanıtları | Erişilebilir yetkili kaynak gereksiz yere kopyalanmaz; üretilmiş yorum kaynakla eşitlenmez. |
| **DevOS çalışma tarifleri ve tekrar kullanım kütüphanesi** | Rol sözleşmeleri, yöntemler, şablonlar ve araç tarifleri; hangi koşulda kullanılacakları | Bir işte işe yarayan taslak otomatik genel kurala veya etkin agent talimatına yükselmez. |

Taslak, geçerli, yerini yenisi almış ve arşivlenmiş olma **yaşam döngüsü statüleridir**; her alanın ayrı kopyasını açma emri değildir. Aynı bilgi için bir yetkili kaynak, gerektiğinde ona bağlı açıkça türetilmiş görünümler olmalıdır. Arşiv geçmiş gerekçe için bulunabilir kalabilir; current okuma yoluna yanlışlıkla karışmamalıdır.

Her kalıcı nesne için gerektiği ölçüde: Neye ait? Sahibi kim? Taslak mı, geçerli mi? Hangi kaynak/karar/sürümle bağlı? Nereden bulunur? Kim kullanacak? Açık işse neyi bekliyor ve nereye dönülecek? Her dosyaya büyük zorunlu form kararı verilmez. Bir dosyanın depoda bulunması, o dosyanın her kullanım için geçerli olması değildir.

## 5. İş, talep ve karar nasıl ilerler?

### 5A. Hedeften işe; hazır backlog olmadan

Ekip yetkili hedefi, araştırmayı ve sonuçları devralır. Her rol ihtiyaç/bilgi açığı gösterebilir; DR01 bunları gerekçeli iş ağına dönüştürür. Bir işten doğmak, onu engelleyen önkoşul olmak ve aynı hedefe katkı vermek farklı ilişkilerdir. Bütün gelecek plan bitmeden önkoşulları sağlanmış sınırlı araştırma başlayabilir. İlk rol/grant/okuma yolu P4/P5'te kurulur; roller birbirini sonsuz biçimde yetkilendirmez.

### 5B. Danışma ile ayrı katkı

Mevcut işin kapsamı ve yetkisi içinde sonuçlanacak kısa danışma aynı iş altında izlenebilir. Ayrı sorumlu, bekleme/devir, anlamlı kaynak yükü, başka işe bağımlılık veya ayrı kabul koşulu doğuyorsa katkı ayrı kimlikle izlenir. Her mesaj için dosya veya iki koordinatörden onay gerekmez.

Talep; soruyu, neden gerektiğini, bağlı işi/kararı, beklenen teslimatı, gerekli uzmanlığı, kaynak/target sürümünü, tüketiciyi ve dönüş noktasını taşır. Var olan kayda bağlantı yeterliyse yeniden kopyalanmaz. Yanıt farklı soruyu cevaplıyorsa veya kaynağa ulaşamadıysa talep sessizce karşılanmış sayılmaz.

### 5C. Tek bir DONE yerine ayrı anlamlar

| Değişen durum | Kim karşılığını taşır? | Hangi sonuç çıkarılamaz? |
|---|---|---|
| Katkı istendi / üst işle bağlandı | Talep sahibi ve DR06-G | Araştırma başladı denemez. |
| Atandı / çalıştırma denemesi başladı | DR06-Y ve katılım/ortam sorumluları | Gerekli bilgi gerçekten kullanıldı denemez. |
| Yanıt veya ürün teslim edildi | Katkı sahibi | Üst karar, ürün veya kullanım tamamlandı denemez. |
| Kullandım / gerekçeli reddettim / ek katkı gerekiyor | Talep sahibi; gereken iddiada inceleyici | Mesaj alındı onayı teknik yeterlik değildir. |
| Karar veya iş kapanışı gerekçelendirildi | Yetkili karar/iş sahibi ve gereken güvence | Müşteri kabulü veya bütün SOUL hedefinin tamamlanması değildir. |

Bunlar tek doğrusal zorunlu state machine değil, karıştırılmaması gereken durum iddialarıdır. Gerekçeli iptal/erteleme mümkündür; erişim engeli veya zaman bitmesi başarılı tamamlanma değildir. Üst işin kapanış koşulu ayrıca değerlendirilir. Tüketim kanıtının derinliği kullanıma göre seçilir; her kayıt düzeltmesinde bütün ajanlardan onay toplanmaz.

### 5D. Görüş ayrılığı, durdurma ve devam

İtirazda hedef iddia, gerekçe/dayanak, beklenen cevap ve sahibi görünürdür. Eksik/çelişkili olgu kaynak veya uygun sınamayla araştırılır. Yalnız tasarım tercihleri çatışıyorsa yetkili alan sahibi alternatifleri/trade-off'u kaydederek seçim yapabilir. Olgusal karşı kanıtı çoğunluk oyu veya teslim baskısıyla bertaraf edemez.

İtiraz; karşılandığında, gerekçeli reddi kaydedildiğinde, öncül geri çekildiğinde veya açık kapsamıyla ertelendiğinde bir karşılık bulur. Kararı taşıyan çözülmemiş ihlal/kanıt açığı olumlu kalite hükmüyle örtülemez. Her itiraz sınırsız veto değildir; durdurma yetkisi kapsamla tanımlanır. Revizyon/ad değiştirme, itirazı karşılamak değildir; ilgili iddia sürüyorsa inceleme bağı yeni adaya taşınır. Alan sahibinin tercihiyle inceleyicinin kanıt hükmü ayrı kaydedilir.

G içerik/bağımlılık nedeniyle ilgili işi bekletir. Y yanlış girdi, kayıp kayıt, yetki veya gerçek ortam engelinde ilgili çalıştırmayı verilen yetki içinde tutar. İlgisiz işler otomatik durmaz. Y kapasiteyi/seçenekleri bildirir; ürün önceliği G'dedir. Gerçek kullanıcı durdurması normal ilerleme kuralıyla aşılmaz.

## 6. Çalışma alanı bakımı işin içine nasıl girer?

**Sözleşme adayı:** Maddi bir çıktı yalnız üretilmiş olduğu için devredilmiş sayılmaz; doğru yeri, sahibi, statüsü, kaynak bağı ve tüketici yolu korunmalıdır. Bu, her adımda ayrı bakım ajanı çağırma şartı değildir.

| Olay | İçerik/iş tarafının katkısı | Düzen tarafının katkısı ve devam koşulu |
|---|---|---|
| İş açılması / görevlendirme | Amaç, kapsam, katkı ve teslimat sahibi; gerekli bilgi ihtiyacı | Mevcut kayıt/kütüphane önce aranır; gerekirse yeni nesneye tek ev/kimlik verilir. Geçerli rol ve yeterli kaynak görünümü sağlanır. |
| Taslak/yanıt üretimi | İçerik, gerekçe, dayanak, belirsizlik, hedef ve temel sürüm | İşle bağlantısı/taslak statüsü korunur. Kalıcılaştırma kabul değildir. Paralel adaylar, birbirini ezen iki current kopya değildir. |
| Geçerli kullanım / devir | Gerekli içerik kararı ve uygun inceleme; kullanım karşılığı | İçerik, geçerlilik ve current giriş/tüketici bağı uyumlu olmalıdır. Kısmi yayın ayrı açık durumdur; yeni içeriğin varlığı tüm tüketicilere hazır olduğu anlamına gelmez. |
| Yeni sürüm / eşzamanlı yazma | Değişen anlamı/etkiyi alan sahibi çözer | Eski temele dayanan çıktı current'ı ezmez. Seçilen değişiklik güncel temelle ve maddi bağımlılıklarıyla yeniden karşılaştırılır. Metinsel birleştirme anlamsal uyum kanıtı değildir. |
| İş kapanışı / kesinti | Üst iş durumu, açık itiraz/katkı, sonraki ihtiyaç ve dönüş | Geçici çıktı, kalıcı dayanak, current kayıt ve arşiv ayrılır; bekleyen talep/deneme ve okuyucunun giriş yolu korunur. |
| Yeniden kullanım | DR15 ve ilgili uzman kullanımın gerekçesini ve sınırını değerlendirir | DR07/08 kaynak sürümü, sahip/kapsam ve uygun bağlamı sağlar. Açık itiraz taşıyan aday etkin kütüphane kuralı gibi sunulmaz. |
| Taşıma / sadeleştirme / arşiv | Korunacak anlam, karar ve kanıt bağı belirlenir | Bağlantı/indeks/current okuma yolu onarılır; eski kopya yanlışlıkla yüklenmez. Geri alınabilirlik/gerekli geçmiş korunur; yetkisiz silme yoktur. |

**Bakım tetikleri:** Yeni kalıcı çıktı, ilgili statü/karar değişimi, taşınan kaynak, bulunan çelişki, iş kapanışı, oturum devri ve tekrar kullanım isteği. Bunlar semantik tetiklerdir; hook/daemon seçilmedi. Her tur bütün depoyu taramak veya dosya sayısını azaltmayı başarı saymak önerilmez.

**Bakım yoğunluğu:** Yanlış current kaynak/izin, açık işi kaybettiren devir veya zorunlu kanıt bağı sorunu ilgili tüketimi durdurabilir. Adlandırma estetiği/zararsız fazlalık sınırlı bakım kuyruğuna alınabilir. Düzen ürünü geliştirmenin yerine geçmez; gerekli yerde isteğe bağlı dekorasyon da değildir.

**Yeniden kullanılabilir kayıt:** Ne işe yarar; hangi koşulda işe yaramaz; kaynak/sürüm/kanıt; kim bakar; nasıl çağrılır; hangi değişiklikte yeniden değerlendirilir? Aranabilirlik/yükleme yararlı yöntem kanıtı değildir. Mevcut iyi şablon, her işte yenisini üretmeden önce değerlendirilir.

## 7. Girdi, güncelleme ve oturum devri

Rol girdisi: rol sözleşmesi + yetkili hedef/kısıt + mevcut iş/soru + gerekli karar/kaynak/ürün sürümleri + açık eksikler + çıktı/tüketici/dönüş bağı. DR08 ile uzman birlikte yeterliği kurar. İnceleyici üreticinin özetine hapsedilmez. Kaydın varlığı, exposure ve actual kullanım ayrıdır.

Yeni bilgi geldiğinde DR07 ilişkili kayıt/tüketicileri belirler; uzman hangi gerekçenin/kararın değiştiğini değerlendirir. Bir dayanak çekildi diye alternatif destekle geçerli kalan karar otomatik iptal olmaz. Eksik bağımlılık kaydı etki yok demek değildir. DR08 yeni görünümü ulaştırır; ilgili G/Y işleri yeniden açılır. Eski veriye dayanan geç yanıt korunabilir ama current sonucu ezemez.

**Kesinti için devam kaydı:** Mevcut amaç/iş; kaynak ve temel sürümler; yapılan/yapılmayan; açık itiraz ve beklenen katkı; sahip/dönüş; çalışma ve yayın denemeleri; belirsiz yan etki; devam/durma sınırı. Yalnız “sıradaki adım” veya bütün sohbet dökümü bunun yerine geçmez.

Y yeniden girişte gerçek deneme, erişim, yetkili katılım, girdi ve etki durumunu uzlaştırır; G amaç/plan/açık hükmü devralır. Görevlendirme değiştiyse eski çalıştırmanın gecikmiş çıktısı current yayına otomatik yetkili değildir. Kayıt restore'u dış etkiyi geri almak değildir; belirsiz etkide kör retry yapılmaz. Batu gerekirse yeniden başlatır, her rolün sırasını tarif etmez.

## 8. Birleşik senaryo: iki iş, ortak dosya, açık inceleme, kesinti

### 8A. Kapsam ve başlangıç

**Bu tamamen masa başı tasarım yürüyüşüdür; canlı ajan, dosya yarışı veya arıza deneyi değildir.** SOUL'un bir teknik çözümünü veya ilk işini seçmek yerine, çalışma alanında aynı dosyaya dokunan iki katkıyı varsayıyoruz.

- `ÖR-A`: Bir ürün açıklamasındaki iddiayı değiştiren taslak; alan sahibi tasarımcı.
- `ÖR-B`: Aynı dosyanın mevcut iddiasına ait sınama/dayanak bağlantısını ekleme; kendi katkı sahibi var.
- `D@r0`: İki katkının başlangıçta okuduğu geçerli ortak dosya. `a` ve `b` ayrı değişiklik adaylarıdır; iki yetkili kaynak değildir.
- `İ-A`: A adayının yeni iddiası için kanıt açığı bulan inceleme itirazı. Bu örnekte itiraz, r0'ın mevcut iddiasının yanlış olduğunu göstermiyor.

Sürüm/iş/itiraz adları örnek gösterimdir; zorunlu dosya adları veya seçilmiş veri şeması değildir. B katkısının mevcut iddia bakımından ayrıca yeterli ve yetkili bulunduğu varsayımı aşağıda açıkça kullanılır; gerçek bir onay üretilmez.

### 8B. Geçişlerde sahip, kalıcı durum ve sonraki tetik

| Olay | Yetkili sahip ve işlem | Korunan durum / tüketici / sonraki tetik |
|---|---|---|
| **1. Paralel hazırlık** | G koordinasyonu A/B'nin katkı/bağımlılıklarını; Y koordinasyonu uygun çalıştırmaları sağlar. Yazarlar current'ı birbirinin haberi olmadan değiştirmek yerine r0 temelli adaylarını üretir. | A, B, temel r0, yazar/görevlendirme ve hedef kayıt bağlantılıdır. Teslim edilen aday ilgili içerik incelemesini ve yayın hazırlığını tetikler. Düşünme/araştırma süresince bütün dosya veya ekip kilitlenmez. |
| **2. A'ya itiraz** | DR13-G, İ-A'yı gerekçesiyle açar; tasarımcı cevap/düzeltme sahibidir. G koordinasyonu yalnız A'nın bu iddiaya bağlı kabul/kapanışını tutar. | A adaydır; İ-A açık ve A ile bağlıdır. Y bunu current giriş veya yeniden kullanım kütüphanesinde onaylı içerik yapamaz. Tasarımcının yeni kanıtı/düzeltmesi incelemeye geri döner. |
| **3. B'nin yayına hazırlanması** | İlgili alan sahibi ve gerekli inceleyici, B'nin r0'a bağ eklemesini kendi kapsamında yeterli bulmuş olsun. B'nin, A'nın açık iddiasını içeri almadığı kontrol edilir. Kapsamlı yayın sorumlusu b'yi güncel temele karşı değerlendirir. | Yayın denemesi `Y-B`: beklenen temel r0, aday r1, yetki ve ilgili inceleme dayanakları. Eski dosyanın bütünü körlemesine yazılmaz. Şartlar sağlanınca r1'in current olarak sunulması denenir. |
| **4. Yayın sırasında kesinti** | İşlemden kesin cevap gelmeden oturum kesilir. Ne G ne Y “yayın olmadı” ya da “B tamam” sonucunu sırf cevap yokluğundan çıkarır. | Y-B'nin sonucu BELİRSİZ; A'nın taslağı ve İ-A açık olarak korunur. B'nin içerik değerlendirmesi yayın durumundan ayrıdır. Yeniden girişte ilk tetik üretimi tekrarlamak değil, gerçek yayın durumunu uzlaştırmaktır. |
| **5. Yeniden giriş ve uzlaştırma** | DR06-Y, yetkili katılım/yazıcıyı ve erişimi yeniden kurdurur. Yayın sorumlusu ile DR07 gerçek D sürümünü, current girişini ve işlem izini kontrol eder. DR13-Y gerekli kapsamda kullanılabilirlik iddiasını sınar. | r1 ve ilgili girişlerin uyumu doğrulanmışsa işlem tekrar edilmez. Yayın olmadığı doğrulanırsa güncel temel/yetkiyle yeniden denenebilir. Kısmi veya bilinmeyen sonuçta yalnız etkilenen yayın/tüketim bekler; bitmiş araştırma otomatik tekrarlanmaz. |
| **6. Örneğin gözlenen dalı** | Y'nin kontrolünde D=r1, fakat ilgili türetilmiş giriş hâlâ r0 gösteriyor olsun. DR07 yetkili bakım kapsamında girişi uzlaştırır; Y karşılık gelen tüketici yolunu doğrular. | Bu ara durum bütün kaynakların hazır olduğu diye sunulmaz. Doğrulanmış eski görünüm yalnız kendi geçerli kullanımında kalabilir; güncel r1 isteyen tüketici bekler. Bildirim eksikse D tekrar yazılmaz, eksik devir tamamlanır. |
| **7. A'nın yeni görevlendirmesi ve geç çıktı** | DR08, A'nın yeni görevlisine r1, korunmuş a, İ-A ve dönüş noktasını sağlar. Eski A çalıştırmasından r0 temelli bir yanıt gelirse Y onun yeni yayın yetkisi olduğunu varsaymaz. | Geç yanıt aday/kanıt olarak korunabilir; current'ı ezemez. Tasarımcı A'yı r1'e göre uzlaştırır; B'nin yeni bağlantısını kaybetmez. İ-A yeniden adlandırma veya rebase ile kapanmaz. |
| **8. Anlamsal birleşim ve devir** | A'nın yeni iddiası B'nin eklediği sınamayı geçersiz veya ilgisiz kılıyorsa bu bir içerik bağı problemidir. Alan sahibi ve gerekli inceleyici bunu çözer; DR07 tek başına iki metni birleştirip onaylamaz. | A hâlâ açık kalabilir; B'nin r0 iddiasına ilişkin doğrulanmış bağlantısı A için otomatik kanıt olmaz. A ve birleşik aday yeterli bulunursa yeni yayın/devir açılır; bulunmazsa somut kanıt/karar ihtiyacı ve sorumlusu korunur. |

Örneğin sonunda **B'nin scoped yayını ve erişim yolu tamamlanabilirken A/İ-A açık kalır**. Bu, sistemin takıldığı veya P3 analizinin yarım kaldığı anlamına gelmez: yanlış bir kapanış yerine gerekli işi ve devam nedenini koruyan tasarım sonucudur. B'nin yayını üst ürün hedefini veya A'yı bitirmiş sayılmaz.

### 8C. Bu yürüyüşün keskinleştirdiği sözleşmeler

1. **Paralel taslak ≠ ortak current yayını.** Hazırlık paralel yürüyebilir. Aynı nesnenin current değişikliğinde mevcut temel, maddi bağımlılıklar, açık itirazlar ve yayın yetkisi kontrol edilir. Önce okuyup çok sonra koşulsuz yazmak yeterli değildir; aradaki değişimi yakalayan gerçek mekanizma P4'te gösterilmelidir. Tek evrensel yazıcı/merkezi kuyruk seçilmedi.
2. **Metin uyumu ≠ anlam uyumu.** İki katkı farklı satırları değiştirse bile aynı iddia ve kanıt bağında çatışabilir. G bu anlamı; Y kontrollü yerleşim, sürüm ve okuyucu yolunu taşır.
3. **İtiraz ve olumlu inceleme sürüme/kapsama bağlıdır.** Açık itiraz ilgili iddia sürüyorsa yeni adaya taşınır. Eski olumlu hüküm de önemli değişiklikten sonra otomatik geçerli değildir. Konu kalktıysa bu gerekçeyle kapatılır; sessizce düşürülmez.
4. **Güncel kaynak ile geçerli kullanım ayrıdır.** Bir itiraz mevcut r0'ın dayanağını da geçersizleştirirse onu sadece son yayımlanmış dosya olduğu için güvenle kullandırmayız; ilgili kullanım askıya alınır. Senaryonun B'yi ilerletmesi yalnız yukarıdaki dar karşı varsayımda geçerlidir.
5. **Yayının sonucu bilinmiyorsa önce gerçek durum bulunur.** Doğrulanmış uygulandı/uygulanmadı/kısmi/bilinmiyor dalları ayrı işlem görür. Birleşik içerik/giriş/devir ya uygun tutarlı görünüm sunmalı ya da tamamlanmadığını görünür kılmalıdır. Çok dosyanın/çok reponun tek transaction olduğu varsayılmadı.
6. **Oturum değişimi işi, itirazı veya yetkiyi sıfırlamaz.** Geçerli çıktılar, bekleyen tüketim, input sürümleri, yayın denemesi ve yetkili görevli korunur/uzlaştırılır. Eski görevlinin hâlâ yazabiliyor olmasıyla yeni görevlendirme kaydı aynı şey değildir; stale-writer koruması fiilen kurulmalıdır.

### 8D. Yeniden girişte okunacak örnek özet

```text
Ortak kayıt: D; fiilen gözlenen içerik r1.
İlgili current giriş: r0; uzlaştırılmadan r1 tüketimi hazır değil.
B: içerik incelemesi uygun; yayın/devir Y-B uzlaştırması bekleniyor.
A: r0 temelli aday a korunmuş; güncel r1 ile yeniden karşılaştırılacak.
İ-A: yeni iddianın kanıt açığı açık; cevap sahibi tasarımcı.
Görevlendirme: yeni etkin katılımın/yazma yetkisinin durumu kontrol edilecek.
Geç eski çıktı: kaynak olarak korunabilir; güncel kaydı doğrudan değiştiremez.
Sonraki tetik: Y-B gözlemi → giriş/devir onarımı → A'nın doğru bağlamla devamı.
Bilinmeyen etki veya gerçek kullanıcı durdurması varsa ilgili sınır korunur.
```

Bu kısa görünüm kaynakların yerine geçmez; kaynak, aday, itiraz ve işlem izlerine ulaşma yolu da bulunmalıdır. Her yeni role bütün geçmişin kopyası gerekmez.

### 8E. Karşı denemeler ve kanıt sınırı

Masa başında şu yanlış geçişler karşılaştırıldı: B'yi eski tüm-dosya kopyasıyla ezmek; A'nın adını değiştirip İ-A'yı düşürmek; yalnız yazıldı mesajıyla current girişi hazır saymak; kesinti sonrası aynı yayını kör tekrarlamak; eski çalıştırmayı yeni yetkili yazar saymak; kayıtlar düzenli diye içerik incelemesini atlamak. Sözleşme her biri için ayrı yasak/geri dönüş ve sahip belirtir.

Bunlar **koşulmuş mutation testleri değildir**. Aynı assistant senaryoyu ve kontrolleri tasarladı. Bir gerçek uygulamanın bu yanlışları engellediği, bütün mümkün arızaların kapsandığı veya mekanizma seçiminin tamamlandığı gösterilmedi. Yeni rol ailesi gerekmedi; mevcut rollere hedef, sürüm ve yayın/devralma sınırları eklendi.

## 9. Araştırma katkısı ve okuma sınırı

**v0.5 başlangıcı:** `51e1fafdc73de93cb992b3db96d0f88e5434066f`. Yeni hedefli reuse, daha önce okunan CATALOG'daki Beads satırı → [Beads META](../../../research/studies/beads/META.md) → [FINDINGS](../../../research/studies/beads/FINDINGS.md) yoludur. META tam, FINDINGS 1–245 seçici okundu; devamı tam okundu sayılmaz. Blob'lar `e63cd1b5002ea172a5ab88b860f6ae8b2e7ffb29` ve `902f2055e317aa366207316270c3aa0ed72cfe07`.

Beads study'si `71c4cd0` tarihsel kaynak incelemesidir: allocation/claim, liveness ve reopen ile etkilenen durumun ayrılması; lease bitmesinden önceki etkinin yokluğunun çıkarılamaması bu tur özellikle kullanıldı. **İş claim'inin dosya yayın yetkisi veya anlamsal doğruluk olmadığı** sınırı korundu. Beads/Dolt seçilmedi, kurulu sürüm veya bugünkü ürün özellikleri doğrulanmadı; study'nin bağlı özgün kaynakları yeniden okunmadı.

Aynı konuşmada doğrudan görülen [Information I1–I5](../../../research/soul-foundations/07_selection-dynamics-integration-review/SYNTHESIS.md) ve [Revision M5](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/derivation-transformation/maintained-information-revision/M5-SYNTHESIS-DECISION-AND-PARENT-DELTA.md), doğru içeriğin tüketicideki görünümle bağını ve yeni kayıt/geri alma/gelecek revizyon ayrımlarını taşıdı. [Hermes Note30](../../../research/studies/hermes-agent/notes/30-SKILL-LIBRARY-LIFECYCLE.md) aktif keşif, yedek/arşiv ve restore kapsamı; [Gas Town FINDINGS](../../../research/studies/gastown/FINDINGS.md) önceki 1–280 görünümü iş/deneme/liveness/yeniden giriş ayrımı için yeniden kullanıldı.

Work/Actors Foundation, RPD ve Superpowers'ın önceki P3 gerekçeleri korunur; bu tur yeni tam corpus okuması veya kaynak doğrulaması iddia edilmez. Önceki asıl okuma kapsamı, kısıt ve blob izleri [v0.4 §9](https://github.com/batuhanozgun/agentic-os-search/blob/51e1fafdc73de93cb992b3db96d0f88e5434066f/explorations/EXP-006-development-os-calisma-duzeni/work/P3-01-work-information-discussion.md#9-araştırma-katkısı-ve-okuma-sınırı) ve onun bağladığı v0.3'tedir. Hiçbir study adı tek başına tasarım doğrulaması sayılmaz.

**Canonical okuma:** AGENT main'den yeniden tam okundu; aynı konuşmada tam görülen gerekli protokoller kullanıldı. Güncel HEAD 51e1faf olarak doğrulandı. P3-01 1–90, 75–135 ve 136–220 görünümüyle tamamlandı; ilk çıktının kesilen sonu yeniden getirildi. HANDOFF/WORK/DECISIONS yeniden tam okundu; WORK 1–70 ve 71–180 olarak bölündü. STATE'in bu committeki tam görünümü; değişmemiş INDEX/ACTORS/U002/P1-01/P2-01'in önceki görünür içerikleri korundu. CATALOG'un ilgili EXP-006 satırı kontrol edildi. Kontroller araştırma kanıtı yapılmadı.

**Kanıt sınırı:** Nitel tasarım yürüyüşü ve kaynak yeniden kullanımıdır. Canlı Claude, dosya yarışı, yayın timeout'u, otomatik tetik, erişim/izin veya recovery deneyi yapılmadı. Araç/ürün seçimi ve davranış doğrulaması P4–P6 yüküdür.

## 10. P3 değerlendirmesi ve P4'e gereksinim devri

**Sınırlı sonuç:** P3'te planlanmış son birleşik senaryo işlendi. Mevcut kavramsal kapsamda sahipsiz bırakılan geçişler için aday karşılıklar artık var: içerik birleştirme, sürüme bağlı inceleme, kapsamlı yayın sahipliği, kısmi yayın/tüketici durumu ve eski çalıştırmadan dönüş. P3 **DESIGN HANDOFF READY / CANDIDATE** olarak kullanıcı değerlendirmesine döner. Bu, D021 dışındaki ayrıntıların kabulü, üretim güvenilirliği veya evrensel eksiksizlik değildir.

| P4'e geçen yük | P4 tasarımında gösterilecek karşılık | P5/P6'da gözlenecek yanlış-yol/başarı koşulu |
|---|---|---|
| **H1 — Rol ve etkinleşme** | P2 sözleşmeleri + G/Y koordinasyon/güvence + D021 bakım kapsamının gerçek actor/oturum/araç yetkisine bağlanması; ilk başlatma yolu | Rutin geçiş Batu komutu olmadan çalışır; gerçek durdurma/izin sınırı korunur. |
| **H2 — Ortak çalışma alanı** | Ürün/iş/dayanak/tarif alanlarının fiziksel yerleri, tek yetkili kaynak, taslak/current/arşiv ve okuyucu girişleri | Bir rol kaynağı ve açık işi bulur; eski/arşiv kopya current diye yüklenmez. |
| **H3 — Değişiklik ve yayın** | Paralel adayların korunması; güncel temel/dependency/inceleme kontrolü; scoped yayın sahibi ve fiilî yazma koruması | İki eski-temel yazma birbirini ezemez; metinsel uyum tek başına içerik onayı yapılmaz. |
| **H4 — Talep ve tüketim** | İstek, karşılık, açık itiraz, ilgili kaynak/sürüm ve tüketiciye dönüşün gerçek tetikleri | Yanıt kaybolmaz veya yanlış işe uygulanmaz; teslim edilmesi üst kararın kapanışı sayılmaz. |
| **H5 — Kesinti ve kısmi sonuç** | İş/çalıştırma/yayın ayrımı, gerçek durum uzlaştırması, yeniden görevlendirme ve stale-writer sınırı | Uygulanmış işlem kör tekrarlanmaz; belirsizlik korunur; eski çalıştırma current'ı ezemez; doğru noktadan devam edilir. |
| **H6 — Güvence ve bakım** | G/Y claim ve version bağları, ilgili durdurma/yeniden inceleme; yeniden kullanım ve bakım yetkisi | Açık itiraz yeni sürümle düşmez; kozmetik bakım tüm işi durdurmaz; düzenli dosya ürün doğruluğu sayılmaz. |

H1–H6 yeni platform özellikleri veya seçilmiş çözümler değil, karşılaştırma/kabul yükleridir. P1 Q01/Q02/Q04/Q05/Q06 bunlarla ilişkilidir; Q03 plugin çelişkisi yalnız plugin yolu yük taşırsa çözülür. Fiilî ortam bir yükü karşılayamıyorsa P4 alternatif yol veya hedefli P2/P3 dönüşü önerir; gereksinimi sessizce düşürmez.

**Sonraki mantıksal iş:** Kullanıcı değerlendirmesi/sonraki devamıyla P4'te bu yükleri gerçek Claude çalışma seçeneklerine ve fiziksel çalışma alanına birlikte eşlemek. Aynı soyut ayrımları yeniden tartışan genel audit turu açılmaz. P3'e dönüş ancak somut karşı örnek, kullanıcı düzeltmesi veya teknik kısıt gerektirirse yapılır.

**Bu tur durma sınırı:** P4'e başlanmadı; alt ajan/takım, dosya şeması, agent sayısı seçilmedi ve P5 dosyaları kurulmadı. P2/ACTORS ilk tabanı korunur; P4 bunları bu P3 farkıyla birlikte ele almalı, 16 rolü otomatik 16 ajan yapmamalıdır. EXP-006 açık; P3 tasarım devrine hazırlık kullanıcı kabulü yerine geçmez.
