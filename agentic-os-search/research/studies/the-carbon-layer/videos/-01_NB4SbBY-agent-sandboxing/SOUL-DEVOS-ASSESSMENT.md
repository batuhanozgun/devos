# İkinci video — SOUL ve Development OS için aday öğretiler

**2026-09-16. Statü:** kaynak incelemesine dayalı ilk proje-ilgi değerlendirmesi; mevcut mimari, izin veya implementasyon denetimi değil. Bu tur Foundation'ın veya Development OS'un canlı durumu yeniden açılmadı; bu metin onların neyi zaten çözdüğünü ya da eksik bıraktığını iddia etmez. Kaynak iddiaları ve teknik kontroller [RESEARCH](RESEARCH.md) / [SOURCE](SOURCE.md) içindedir.

## 1. SOUL için yeni soru: aktörün gücü nereye kadar taşınacak?

Videonun üç sorusu, iş için gerekli kabiliyet sağlanırken o kabiliyetin erişebileceği alanın da düşünülmesini gerektiriyor: hangi araçlar sunuluyor; hangi veriler, servisler ve credentials erişilebilir; işlemin gerçek yürütücüsü nerede? [V02 01:19–02:59; 33:13–34:23]

Bizim aday çıkarımımız: işin amacı ile aktöre teknik olarak açılan güç arasında gerekçeli bir ilişki kurulmalı. Yalnız bir role güvenmek veya modelden dikkatli olmasını istemek, verdiğimiz geniş yetkinin doğru olduğunu göstermez. Bunun nasıl temsil edileceği veya uygulanacağı bu araştırmayla seçilmiş değildir.

**Analitik örnek, çalıştırılmadı:** Bir aktörden rapor üretmesi isteniyor. Rapor için belirli dosyaları okuması ve bir çıktı dizinine yazması gerekiyor. Üretim yönetim anahtarına ihtiyacı olduğu buradan çıkmaz. Aynı aktör daha sonra onaylanmış bir işlem yapacaksa erişim gereksinimi değişebilir; bu yeni gereksinimin meşruiyeti yalnız mevcut credential'ın bulunmasına dayandırılamaz.

## 2. Development OS için aday: yerel koruma ve teslimat etkisi ayrı

Kod değiştiren aktör için hem geliştirici ortamının kullanılabilirliği hem ana makinenin ve komşu işlerin sınırı önemlidir. Video native OS sandbox'larını yerel ergonomi için, container ve microVM'leri farklı iş koşulları için aday gösteriyor. Bu seçenekleri SOUL Development OS'a otomatik eşleştirmedik. [V02 09:07–11:05; 26:50–30:21]

Somut değerlendirme soruları: yazılabilir çalışma alanı hangisi; paket/test/derleyici çocukları aynı kurallara tabi mi; ağ ve sırlar gereklilikle sınırlı mı; sandbox dışında kalan dosya aktarım veya servis araçları var mı? Üretilmiş değişikliği sonradan yüksek yetkiyle çalıştıran CI veya insan da ayrı bir tüketicidir. Video 30:50–31:02'de bu gecikmeli etkiyi anıyor.

Bu nedenle bir coding ortamının makineyi koruması, ürettiği patch'in doğru, güvenli veya yayımlanabilir olduğunu kanıtlamaz. Bu analitik ayrım, sandbox'ın değersiz olduğu anlamına değil, koruduğu nesnenin farklı olduğuna işaret eder. Gerçek teslimat/release kararı ayrıca kendi ölçütlerine bağlıdır.

## 3. Güvenlik yalnız engel sayısı değildir

Onay yorgunluğu bölümü, insanın dikkatinin de tasarım girdisi olduğunu düşündürüyor. Kaynağın fikri anlamlı sınır geçişlerini öne çıkarırken rutin işin gereksiz kesilmesini azaltmak. Anthropic'in %84 verisi permission-prompt sayısıdır; görev kalitesi veya olay azalması için kendi ölçümümüz değildir. [V02 04:31–06:31; D01]

Aday kullanım sorusu: insan gerçekten karar vermesi gereken şeyi görüyor mu, yoksa ilerlemeyi açmak için tekrarlanan düğmelere mi basıyor? Daha az onay, ancak gerekli sınırların gerçekten uygulandığı koşullarda bir kolaylık kazanımı olarak değerlendirilebilir. Bu dosya hangi eylemlerin önceden yetkilendirileceğine karar vermez.

## 4. Tek tip sandbox yerine gerçek iş gereksinimi

Aynı sistemde dar bir metin/JSON dönüşümü, repository üzerinde test, dış kullanıcı kodu ve üretim API eylemi farklı risk taşır. Kaynağın L1–L5 haritası bu farkı görünür kılmak için değerlidir. Buradan SOUL için zorunlu beş katman, beş aktör tipi veya belirli tedarikçi seçimi çıkarmıyoruz.

Uygun kullanım; önce korunacak nesneyi, izinli normal işi, olası yanlış eylemi ve değiştirilebilen bağlantıları sormaktır. Daha güçlü yürütme izolasyonu bazı host risklerini azaltırken, izinli uzak servisteki geniş credential yetkisini tek başına daraltmaz. [V02 33:13–34:23]

**Karşı örnek:** Çok dar yerel dosya erişimine sahip bir agentın geniş izinli dış yönetim aracı bulunabilir. Tersine, tamamen ağsız bir iş yerel dosyaları veya sonraki derleme girdisini bozabilir. Bu iki durum farklı korumalar gerektirir; tek bir sandboxed etiketi ikisini açıklamaz.

## 5. İlk videoyla ilişki ve araştırma sahipliği

İkinci video, 06:01–06:31 ve 35:08–35:26 bölümlerinde önceki harness anlatımını kendisi tamamlayıcı olarak sunuyor. İlk videonun [mevcut dosyası](../mQfTdNVCOB0-harness-engineering/INDEX.md) geniş çalışma sorumluluklarını ve tamamlayıcı Meta-Harness araştırmasını taşımaya devam ediyor.

Bu ilişki ikinci videoyu ilk videonun U05'i yapmaz. Yeni dosyanın nesnesi sandboxing videosu; ilk videonun açık işlerine veya Meta-Harness makalesine dönülmedi. Burada ilişkiyi işaretlemek, ayrıca tamamlanmış bir cross-video sentez veya yeni ürün entegrasyonu değildir.

## 6. Şimdilik neyi saklıyoruz?

Yeniden kullanım değeri: beş mekanizmayı ayırt eden açıklama; aynı path/farklı kaynak örneği; host-side araç ve uzak API karşı örnekleri; yapılandırma, süreç ağacı ve kullanılabilirlik soruları; kaynak çizimlerinin teknik sınırları. Bunların bir kısmı ileride seçim ölçütü veya kontrol örneği olabilir; hepsinin çalıştırılacak koda ya da prompt'a dönüşmesi gerekmez.

Mimari veya güvenlik hükmü vermeden önce gerçek iş yükü, korunan kaynaklar, exact runtime/policy ve dış yetkiler yeniden okunmalı; gerekli normal/olumsuz yollar uygun ve yetkili bir ortamda sınanmalıdır. Böyle bir hedef henüz verilmedi. Bugünkü dönüş noktası kaynak derslerini değerlendirmek; bütün ürünlerin güvenliğini kanıtlamak değil.
