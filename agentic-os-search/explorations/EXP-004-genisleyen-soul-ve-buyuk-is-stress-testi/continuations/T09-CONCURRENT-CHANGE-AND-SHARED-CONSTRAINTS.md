# EXP-004 / T09 — Eşzamanlı değişiklikler ve ortak koşullar

**Tarih:** 2026-09-21. **Tür:** T08 ve U016 sonrasında, kullanıcının «Harika. Devam et kaldığın yerden.» yönüyle oluşturulan türetilmiş devam kaydı. Kaynak yanıt transkripti değildir. **Kapsam:** Aynı büyük soru-bankası programındaki eşzamanlı işler, yöntem değişiklikleri, ortak kapasite, yetki ve geçiş. Canlı ajan, veritabanı, Git çatışma deneyi veya SOUL prototipi çalıştırılmadı.

## 1. Devralma ve sınır

[STATE](../STATE.md), [INDEX](../INDEX.md), görünür T08 cevabı/S015 ve U016 açıklaması esas alınır. İlk arşiv onarımı kapalıdır; T1–T8 yeniden yapılmaz. [U016 çerçeve notu](../reflections/FRAME-CLARIFICATION-20260921.md), yeni yeteneklerle birlikte mevcut işlevlerin yeni aktör/kaynak kapsamını devralması fikrini korur. Dikey/yatay kelimeleri zorunlu mimari, branch çağrışımı Git seçimi değildir.

Bu turun sorusu: tek tek uygun ve yerel yetki sınırları içinde görünebilen iki değişiklik, ortak çalışma düzeninde birlikte uygun mu? İlk aşamada tüm SOUL'u tek merkezi aktör veya tek veritabanı saymıyoruz. Karşılıklı etkisi olan işlerin hangi ortak koşulları koruması gerektiğini arıyoruz.

## 2. Sonuçtan önce belirlenmiş karşıörnek

Sentetik programda aynı yayımlanacak soru sürümü için iki ayrı noktada üreticiden bağımsız matematik kontrolü çalıştığı varsayılsın: üretim sonrası P, yayın öncesi Y. Bu küçük vaka için iki kontrol aynı korunan iddiayı kapsıyor; arada soru sürümünü değiştiren işlem yok. Gerçek eğitim ürününde kontrollerin eşdeğerliği veya birinin gereksizliği ileri sürülmüyor.

Korunan koşul: **Yayımlanacak her soru sürümü, yayından önce en az bir uygun bağımsız matematik kontrolünden geçmiş olmalı.** Kontrolün yapılması, matematiksel doğruluğun kusursuz kanıtı değildir; önceki T6 sınırı korunur.

Değişiklik X: üretim ekibi P'yi kaldırmayı önerir; Y'nin kaldığına dayanır.
Değişiklik Z: yayın ekibi Y'yi kaldırmayı önerir; P'nin kaldığına dayanır.

Her teklif aynı başlangıç düzenine karşı tek başına değerlendirilir. İlgili kontrolün gerçekten çalıştığı varsayımı altında:

| Düzen | Kalan kontrol yolu | Kurulmuş koşul |
|---|---|---|
| Başlangıç | P ve Y | Korunur |
| Yalnız X | Y | Korunur |
| Yalnız Z | P | Korunur |
| X ve Z birlikte | Hiçbiri | İhlal edilir |

Bu bir deney sonucu değil, açık koşullardan çıkan mantıksal karşıörnektir. **Yerel uygunlukların toplamı ortak uygunluk değildir.** X ve Z farklı kayıt/dosya/aktörlerde gerçekleşebilir. Aynı dosyayı değiştirmeme veya iki ayrı inceleme onayı, ortak koşulun korunduğu anlamına gelmez.

## 3. Neyin değiştiği kadar neye dayanıldığı

X'in değerlendirmesi sadece «P kaldırılabilir» değildir; «Y ilgili soru sürümlerinde işlemeye devam ettiği müddetçe P kaldırılabilir» biçiminde koşulludur. Z için simetrik koşul geçerlidir.

Bir değişikliğin değerlendirme/kabul kaydı, karar açısından maddi olduğu ölçüde başlangıç düzenini, değiştirdiği nesneleri, dayanılan fakat değiştirilmemiş koşulları, korunan yükümlülüğü, kapsamı ve ilgili yetkiyi taşımalıdır. Her dosyanın bütün bağımlılıklarını bilen kusursuz harita varsayılmıyor; bilinmeyen etki alanı açık tutulabilir.

Bu, koşullu bir kararı bağlamsız PASS bayrağına indirgememe ihtiyacıdır. Yeni zorunlu Change Case veya ayrı veritabanı ilan edilmiyor; Work, ilgili kaynak/karar kayıtları, Qualification Case adayları ve bindings bu ayrımı taşıyabilir mi soruluyor.

## 4. Yarışı yalnız daha çok inceleme kapatmaz

İki değerlendirme de başlangıç durumunda doğru olabilir. X kabul edilip P kaldırıldıktan sonra Z, Y'yi kaldırma önerisi için artık önceki P desteğine sahip değildir.

Bu vaka için bir aday kabul yolu: X veya Z'den birini seç; ortak koşulu kapsayan ilgili durumda kabul/uygulama hakkını kaydet; diğerinin yük taşıyan varsayımını güncel duruma karşı yeniden değerlendir. Örneğin X seçilmişse Y korunur ve Z önceki değerlendirmesiyle uygulanmaz. X'i seçmenin daha iyi olduğu iddia edilmiyor; ters sıra da aynı güvenlik koşulunu koruyabilir.

Kontrol ile kabul arasında yarış kalırsa ikisi yine eski durumu okuyabilir. Bu nedenle kritik yerde yalnız «önce oku, sonra yaz» değil, kontrol edilen durumla kabul edilen geçişi uygun bir eşzamanlılık mekanizmasıyla ilişkilendirmek gerekir. Hangi mekanizma gerektiği açıktır: ortak koşulun korunacağı dar karar alanı, sürüm/koşul doğrulaması, ilgili rezervasyon veya sıralama gibi seçenekler vardır. Ayrı ayrı iki dosyaya uygulanan sürüm kontrolü, aralarındaki ortak koşulu otomatik korumaz.

Kubernetes'in resourceVersion ile eski nesneye dayalı güncellemeyi reddetmesi, nesne düzeyinde somut mekanizma örneğidir; çok nesneli anlamsal güvence değildir. PostgreSQL'in transaction-isolation belgesi de tutarlı bir snapshot okumanın bütün eşzamanlı işlemlerin birlikte iş kuralını korumasına eşit olmadığını ve Serializable davranışın read/write bağımlılıklarını izlediğini açıklar. Bu referanslar kavramsal ayrımı somutlaştırır; SOUL'a Kubernetes/PostgreSQL seçmez.

## 5. Kabul edilen hedef düzen ve çalışan düzen

İki denetimin tek yeni denetim N'de birleştirildiğini varsayalım. Son düzenin taslağı uygun görünebilir; P ve Y kaldırılıp N henüz ilgili aktörler/sürümler/yayın yollarında etkin değilse geçiş sırasında denetimsiz aralık oluşur.

Bu vaka için aday güvenli sıra: N'yi sınırlı kapsamda hazırlamak; ilgili çıktılarda gerçekten devreye girdiğini gözlemek; eski yükümlülükleri boşluk bırakmadan devretmek; ancak sonra kapsanan eski yolu kaldırmak. Tek evrensel geçiş algoritması değildir. Bazı ortamlarda kısa duruş, bazı işlerde eski sürümle tamamlama, bazılarında yeniden qualification gerekebilir.

Eski aktörün sürecine «dur» mesajı gitmesi veya eski yetkinin kayıtta sona ermesi, dış etki gücünün fiilen kaldırıldığını kanıtlamaz. Bu vakada eski onaya dayalı yayın denemesi korunmuş etki sınırında yeniden kontrol edilmelidir. Görünürlüğü/denetlenebilirliği olmayan dış yolda kalan sınır açıkça tutulur. Teknik yetenek sahibi olmak meşru yayın yetkisi değildir.

Dolayısıyla değişikliğin hazırlanması, kabulü, kalıcı kaydı, aktif uygulanması ve etkisinin doğrulanması yine ayrıdır. İki güvenli uç durum, aralarındaki her geçişin güvenli olduğunu göstermez.

## 6. Kapasite karşıörneği: frontier ve seçilmiş küme

Ayrı sentetik varyant: aynı bir saatlik pencerede toplam 60 dakika uzman kapasitesi var. Bağımsız A işi 40, B işi 35 dakika gerektiriyor; işler bu pencere içinde bölünemez ve başka kapasite yok varsayılıyor. A tek başına sığar, B tek başına sığar; birlikte 75 dakika ister. 15 dakikalık açık vardır.

İki iş farklı Work kimlikleriyle tekil olarak claim edilmiş olsa da ortak kapasite aşılabilir. Aynı Work'ün iki kez alınmasını önleme ile farklı Work'lerin aynı kaynağı fazla taahhüt etmesini önleme ayrı sorulardır.

A seçilirse aynı pencerenin kalan 20 dakikası B için yetmez. B'nin beklemesi, başka pencereye taşınması veya gerçekten sağlanabilir ek kapasite için ayrıca karar verilmesi gerekir. Hangi işin önce seçileceği bu karşıörneğin çözülmüş optimizasyon sorusu değildir; hedef, öncelik, gecikme maliyeti ve yetki ayrıca gereklidir.

T2'nin actionable frontier anlatımı böylece incelir: **ayrı ayrı başlanabilir adaylar kümesi, aynı anda başlatılabilecek ortak-uygun küme değildir.** Hazırlık, seçim ve ortak kaynak taahhüdü ayrılır.

## 7. Tek merkez ve yalnız mesajlaşma zorunlu sonuç değil

Bu vakalar otomatik olarak tüm kararların tek üst ajana gönderilmesini gerektirmez. Yalnız ilgili ortak koşulu etkileyen kararların uzlaştırılması gerekir; ilgisiz araştırma/biçim değişikliği paralel ilerleyebilir. Yerel, ortak ve üst kapsam yetkileri belirlenebilir; taşıyıcı rol/servis/insan bileşimi açık kalır.

Ayrıca yalnız aktörlere birbirini bilgilendirme kuralı vermek, kontrol–kabul yarışını veya yetkisiz dış etkiyi kendi başına kapatmaz. Paylaşılan sorumluluk görünümü ile fiilî karar/uygulama yolu birlikte değerlendirilir. Bütün aktörlerin bütün bağlamı görmesi gerekmez.

Yetki uyuşmazlığında son yazan, en yüksek özgüven veya basit çoğunluk otomatik oracle değildir. Korunan kuralı değiştirmeden çözülebilen yerel çakışma ile kural/amaç/kapsam değişikliği isteyen karar ayrılır. Çözümsüz yüksek etkili aday bekleyebilir; bütün sistemin durması gerekmez. Sonsuz yeniden-deneme/karşılıklı bekleme de başarı değildir: beklenen koşul, sorumlu, yeniden değerlendirme ve gerektiğinde üst karar yolu görünür olmalı; mevcut grant çözmüyorsa ilerlemek yerine açık bekleme/ret gerekir.

## 8. Kavramsal negatif ve pozitif kontroller

C01: X tek başına veya Z tek başına, diğer uygun yol gerçekten kaldığında koşulu ihlal etmez. Sistem her sadeleştirmeyi otomatik reddetmemeli.
C02: X+Z aynı eski temelden birlikte kabul edilirse koşul ihlal olur; bağımsız PASS'leri toplamak yetersiz.
C03: X uygulandıktan sonra Z eski değerlendirmesini kullanırsa yeni duruma karşı kabul geçersizdir.
C04: X/Z ile ortak koşulu paylaşmayan bir biçim değişikliği gereksiz yere engellenmemeli.
C05: N henüz aktif değilken P+Y kaldırılırsa hedef tasarım uygun olsa bile geçiş başarısızdır.
C06: A=40 ve B=35, kapasite=60 varyantında birlikte rezervasyon reddedilmelidir; ikisini ayrı ayrı claim etmek yeterli değildir.
C07: Yetki/kayıt değişmiş fakat eski aktör hâlâ yayın yapabiliyorsa kontrol etkisi kanıtlanmamıştır.

Bu maddeler uygulamada çalıştırılmış testler değildir. C01–C06 için sonuçlar kurulan koşulların mantıksal/aritmetik sonuçlarıdır; C07 bir kanıt ve mekanizma açığıdır. Stok kodun veya gerçek aktörlerin bu kontrolleri geçtiği ileri sürülmez.

## 9. Modele katkı

T08, yöntemin değişmesini yönetilen Work olarak ele aldı. T09 buna **karşılıklı dayanaklar, ortak koşullar ve geçiş düzeni** ekledi. Çalışma sisteminin tutarlılığı, parçaların tekil başarısından otomatik türemez.

U016'ya bağlantı: yeni bir aktör eklenirken yalnız aktörün kendi görevleri değil; mevcut kalite, bilgi, kaynak, yetki ve süreklilik işlevlerinin bu yeni katılımı hangi kapsamda karşılayacağı da incelenmelidir. Bu, merkezi her-şeyi-denetleyen servis veya tüm aktörlere sınırsız erişim sonucu değildir. Kapsama gereği, yetki genişletme izni vermez.

Yeni bir Foundation ground bulup bulmamak başarı ölçütü değildir. Asıl yeni tasarım baskısı, yerel doğruluğun yanı sıra ortak durumun ve aradaki geçişin korunmasıdır. Güçlü mekanizma ve canlı davranış güvencesi henüz yoktur.

Doğal sonraki soru: yeni aktör/araç/yol sisteme katıldığında ortak yükümlülüklerin gerçekten ilgili tüketiciye ve etki sınırına taşındığı nasıl görülecek? Bu not T10'u çalıştırmaz; model/ürün seçimi veya uygulama yetkisi vermez.

## 10. Kaynaklar ve gerçek okuma kapsamı

Proje okumaları, başlangıç main `e372ed7558b0b0ebbf388c864b0733382d1418ba` bağlamındadır. Güncel EXP STATE/INDEX yeniden tam açıldı; bu konuşmada tam görünür S015/U016 ve önceki tam kaynak aktarımı kullanıldı. Araştırma yeniden kullanımı:

- `research/studies/CATALOG.md`: ilgili Beads/Gas Town satırları dahil türetilmiş katalog görünümü; bütün katalog veya bütün studies tam okuması değil.
- [Beads META](../../../research/studies/beads/META.md), blob `e63cd1b5002ea172a5ab88b860f6ae8b2e7ffb29`, ve [FINDINGS](../../../research/studies/beads/FINDINGS.md), blob `902f2055e317aa366207316270c3aa0ed72cfe07`, tam okundu. Kaynak araştırma pini `71c4cd08b9991e7ba4e53822769c78337e0f4ee4`. Atomic claim / read-claim ilişkisi ile semantik plan çatışmasının açık sınırı ayrıldı. Upstream yeniden denetlenmedi; mevcut ürün garantisi verilmiyor.
- [Gas Town META](../../../research/studies/gastown/META.md), blob `dfe8dd29a38ef7e4f686b358dac77ec8fdfe6fe6`, tam; [FINDINGS](../../../research/studies/gastown/FINDINGS.md), blob `4e376aaf3f45936637125496451d1258325fe310`, satır 1–150. Kaynak araştırma pini `649b832b7672bc7a2dbef26f5983aba6198b819b`. Readiness/capacity/dispatch ayrımı ve alternatif dispatch yollarının coverage sınırı kullanıldı; canlı sistem veya tüm upstream yeniden okuması değil.
- [Foundation Control STATE](../../../research/soul-foundations/05_relation-control-composition/control-constraint/STATE.md), blob `fdbf3fe6973cd3bc982d394993a3309eb7178049`, tam. Korunan etki kapsamı ile denetim noktası/yol kapsamının ayrımı, authority/decision/enforcement sınırı. Yeni Foundation araştırması değil.
- [PostgreSQL transaction isolation](https://www.postgresql.org/docs/current/transaction-iso.html), 21 Eylül 2026 erişimi, özellikle §13.2.2–3. Snapshot, read/write dependencies ve Serializable sınırı için birincil teknik dayanak. PostgreSQL seçilmedi, veritabanı deneyi yapılmadı; dış etkiler bu belgenin transaction garantisine otomatik dahil edilmez.
- [Kubernetes API Concepts](https://kubernetes.io/docs/reference/using-api/api-concepts/#updates-to-existing-resources), 21 Eylül 2026 erişimi, mevcut kaynakların güncellenmesi bölümündeki resourceVersion/409 kontrolü. Tek nesneli sürüm koşulu için birincil örnek; çok nesneli iş kuralı doğrulaması olarak kullanılmadı. Kubernetes kurulmadı/seçilmedi.

Kontrol protokolleri çalışma davranışını yönetti; araştırma kanıtı olarak gösterilmez.

## 11. Kayıt ve yayın sınırı

Bu not, paket STATE/INDEX'i ve kütüphane INDEX/CATALOG yönlendirmeleri aynı dar değişiklikte güncellenir. Önceki kaynak kesimi U001–U016/S001–S015, manifest, eski özetler, onarım/yayın kanıtları ve T08 notu değiştirilmez. Yeni çalışma notu tam konuşma aktarımı sayılmaz; kaynak sayısı 31 olarak kalır.

Git nesnesi oluşturma ve main'e yayın ayrı olaylardır. Main ref ilerlemesi, değişen yollar ve uzak geri okuma işlemden sonra kontrol edilir; bu belge kendi gelecekteki commit kimliğini veya henüz yapılmamış readback sonucunu uydurmaz. Bu, yeni arşiv onarımı işi veya tüm-repo denetimi başlatmaz.
