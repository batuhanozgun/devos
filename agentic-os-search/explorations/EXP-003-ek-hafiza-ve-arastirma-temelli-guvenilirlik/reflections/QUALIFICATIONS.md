# EXP-003 — İddia sınırları ve assistant düzeltmeleri

**18 Eylül 2026, arşivleme değerlendirmesi.** Bu dosya özgün diyaloğun parçası değil, kaynak sonrası assistant değerlendirmesidir. Kullanıcının yeni kabulü, geriye dönük ortak karar veya agent-control değildir. U/S kaynakları [diyalog dizinindedir](../sources/conversation/INDEX.md).

## Q01 — Sayısal katkı tahminleri geri çekiliyor

S009'daki 160–220, merkez 180, 115–130, 170–220, 200–300; S010'daki 240–345 eğrisi ve +20/+30, +5/+10 beklentileri için tanımlanmış ortak ölçü, ağırlık, payda, deney, kalibrasyon veya karşılaştırılabilir baz yoktur. 'Sezgisel' demek bu sayılara araştırma değeri kazandırmaz. Bunlar karşılaştırmalı güvenilirlik, kapsam veya marjinal fayda tahmini olarak kullanılmamalı; bu arşivleme değerlendirmesinde geri çekilmiştir. Özgün kaynak korunur, puanlar yeni sentezlere taşınmaz.

## Q02 — Araştırma doyumu henüz ölçülmedi

S010'daki 'doyuma yaklaştık', 'kavramsal geç evre' ve 'üç çalışma tekrarlarsa dur' ifadeleri kanıtlanmış kapanış ölçütleri değildir. Benzer kaynak seçmek tekrar üretip sahte doygunluk yaratabilir. Yeni araştırma yeni özellik yerine bir riski azaltabilir, bir seçeneği eleyebilir veya eski inancı bozabilir. Marjinal fayda hedefe, mevcut bilgiye, araştırma sırasına, tamamlayıcılığa ve maliyete bağlıdır; klasör sayısı üzerinden eklenmez. OpenViking→ai-memory→context-mode sırası öneridir, etkin iş kuyruğu değildir.

## Q03 — Karpathy hakkında kaynak güvence açığı

S005/S008 Gist'in okunduğunu ve bazı özellikleri tarif ettiğini söyler. Görünür kaynak kesiminde tam Gist metni, revision pin'i ve bu tam okumayı taşıyan kaynak kaydı yoktur. Arşiv başlangıç ref'inde `research/studies/llm-wiki/META.md` blob `21e2adffbe3bfa41a52d6dd8145e0bd74471134b`, PLANNED / RESEARCH NOT STARTED ve pinned ref none durumundadır. Bu durum, U008'deki bakma yönünün hiç verilmediği anlamına gelmez; yön verilmesi ile kaynak çalışmasının gerçekleşip belgelenmesi ayrıdır.

S008, sürüm-sabit tamamlanmış study veya uygulama denetimi olarak devralınmamalıdır. İlgili kullanıma geçildiğinde Gist'in tam kaynağı ve revision'ı ayrıca geri kazanılmalıdır. Bu arşivleme turu o eksik araştırmayı yapmış gibi davranmaz ve studies statüsünü sessizce yükseltmez.

## Q04 — Fikir notu, ürün ve çalışan uygulama aynı karşılaştırma nesnesi değil

Bir notta açıklanmayan konu; yazarın fark etmediği, bütün uygulamaların içermediği veya testte başarısız olduğu konu değildir. Karpathy/Hermes/diğer sistemlerden 'daha sağlam' demek için aynı veya açıkça eşlenmiş kullanım, sürüm, runtime ve güvence ölçütleri gerekir. 'Source of truth' sözü tek başına olgusal hakikat iddiası gibi yorumlanmamalıdır. S008'in 'asıl yenilik' hükmü özgünlük araştırmasıyla desteklenmemiştir.

## Q05 — Hedef, gerçekleşmiş üstünlük veya hatasızlık değildir

U011'deki 'kurduk' gelecekte ulaşılmak istenen cümlenin içindedir; kullanıcı aynı anda daha çok iş olduğunu söyler. 'En iyi' ve 'örneklerin açıklarını içermiyor' bir amaçtır. Bütün bilinmeyen açıkların yokluğu ilan edilemez. Bilinen hata sınıfları, belirlenmiş kullanım ve test kapsamı, kalan riskler ve yeni entegrasyon hataları ayrı gösterilmelidir. Daha fazla bileşen eklemektense daha az bileşenle gerekleri sağlamak daha iyi çıkabilir. Bu bir yeni tasarım kararı değil, başarı iddiasına konan sınırdır.

## Q06 — Eğitim bilgisi, anlık bağlam ve kalıcı bilgi

'Batu adını ancak ek hafıza dosyasından öğrenebilirim' ifadesi fazla dardır: U002'nin kendisi bu bilgiyi mevcut konuşmada sunar. Ek hafıza ihtiyacı, bunun uygun koşullarda daha sonra yeniden kullanılabilmesiyle ilgilidir. Model ağırlıklarına bilgi eklemek ile dış temsili okumak farklı süreçlerdir; eğitim için ilgili firmada işe girmek zorunlu koşul değildir. Üretimde her modelin aynı iç hesaplama veya bütün ağırlık etkinliği modelini kullandığı da varsayılmamalıdır. Burada model geliştirme yöntemi araştırılmadı.

## Q07 — Üç işlem modeli minimalite teoremi değildir

Create/read/revise, kullanıcının geniş operasyon kümeleri önerisidir. 'Düzenleme' bütün durum değişikliklerini kapsarsa yaratma da seçilen sistem sınırında bir durum değişikliği olarak görülebilir. Nesneye göre yararlı ayrım olması ile tek zorunlu primitive tabanı olması farklıdır. Karar verme, seçme ve yönetme bu işlemlerin kullanımını örgütler; sırf başka açıklama seviyesi oldukları için eksik dördüncü primitive sayılmaz. Policy de her uygulamada fiziksel bir dosya olmak zorunda değildir.

## Q08 — Dosya işlemi ile anlam ve zaman sınırları

S004'teki kayıt dizileri olası açıklamalardır, gerçek syscall/çökme dayanıklılığı deneyi değildir. Rename atomikliği ile güç kaybında kalıcılık aynı güvence değildir. Yeni cümle yazmak dünyada yeni gerçek veya bağımsız kanıt yaratmaz; aynı anlam daha önce başka yerde bulunabilir. Eş anlamlı sözcük değişimi mutlaka bilgi düzeltmesi değildir. Kırmızı→mavi metin değişimi tek başına dünya değişimi, hata düzeltmesi veya kaynak çatışmasını ayıramaz. T1/T2 kaydetme zamanlarından otomatik valid_from/valid_until çıkarılmaz.

## Q09 — Kusursuzluk, tüm bağımlılıkları bilme ve her şeyi geri alabilme

'Bozulma sessiz olamaz' sağlanmış bir garanti değil, kapsamı tanımlanması gereken hedeftir. İçerik/indeks/bağımlılık kayıtları da yanlış olabilir. Tespit edilemeyen hata olasılığı, geri alınamayan dış etkiler ve uygun silme yükümlülükleri yok sayılmamalıdır. U005 zaten her dosyanın değişmesi gerekmediğini söyledi; S006'nın bunu yeni bir düzeltme gibi sunması kullanıcı görüşünü eksik yansıtır.

## Q10 — Şemalardaki oklar zorunlu sıralama değildir

S005/S006/S010'un görünürlük zincirleri tanısal ayrımları gösterebilir; evrensel ardışık işlem hattı değildir. Bir locator keşif için yeterli olabilir; on-demand yol her ayrıntıyı önceden context'e yüklemeyi gerektirmez. Kapsam, yetki, yorumlama, yeterlilik ve erişilebilirlik farklı ilişkiler olarak değerlendirilmelidir. Foundation'ın araştırma ağacı runtime modülleri veya dosya sınıfları olarak benimsenmedi. Katmanlılık zorunlu olduğu kanıtlanmış seçim değildir.

## Q11 — İnsan benzetmesi ve hayalî kullanıcı profilleri

U005'in uyanınca bütün bilgiyi saymama benzetmesi seçici erişimi açıklamak içindir; insan/LLM bilişsel eşdeğerliği veya insanın ürettiğini daima hatırlaması kanıtı değildir. Batu/Alin/Kemal dizinleri ve iş/eğitim/karakter alanları hayalî örnektir; bu kişilere ait gerçek profil, kişilik çıkarımı veya hassas veri toplama yetkisi değildir. 'Hafızasız reasoning soyut kalır' ifadesi, bütün reasoning'in kalıcı dış hafıza gerektirdiği evrensel önerme olarak taşınmamalıdır.

## Q12 — Okuma kapsamı ve kanıt seviyesi

U006/U010 çevresindeki araç görünümlerinde gerçek repository okumaları vardır; fakat bazı büyük toplu çıktılar kesilmiştir. Studies META taramasının bir bölümü başlık/statü filtrelemesidir; bu, bütün META içeriklerinin tam okunması değildir. Daha derin bazı dosyalar tekrar açılmıştır; bu da bütün klasörlerin ve birincil dış kaynakların eksiksiz yeniden incelendiğini göstermez. S010'un 'META yüzeylerinin tamamını okudum' ifadesini kapsamlı tam-okuma kanıtı olarak kullanmayın.

Kaynak kodu gözlemi, test kodunun okunması, sentetik parçanın çalıştırılması ve canlı agent davranışı farklı kanıt türleridir. Örneğin gstack/ECC'de benzer görünüm kaybı örnekleri bulunması, projedeki aynı-assistant yorumlarını bağımsız doğrulamaya dönüştürmez. Önceki dış bağlantıların varlığı da sayfanın okunduğuna veya atfı desteklediğine tek başına kanıt değildir. Bu arşiv dış kaynak doğrulamasını tamamlamaz.

## Kullanım

Düzeltmeler önceki bütün düşüncenin değersiz olduğu anlamına gelmez. Kullanıcı hedefi, işlem–nesne ayrımı, erişilebilirlik sorusu ve araştırma kullanım yönü korunabilir. Kaynak sonrasında yapılan bu nitelendirmeler kullanıcı adına yeni karar üretmez; gerçek araştırma ve tasarım uygun yetkiyle ayrıca yürür.
