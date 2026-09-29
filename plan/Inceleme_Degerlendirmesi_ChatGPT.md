# ChatGPT incelemesinin değerlendirmesi ve 2.1 revizyon listesi

**Tarih:** 29 Eylül 2026 · **İncelenen:** Kurulum planı 2.0 ve Ek A–G · **İnceleyen:** ChatGPT (kaynak sadakati) · **Değerlendiren:** Planı yazan oturum

**Yöntem:** Claude incelemesiyle aynı: savunma eğilimi uyarısıyla tartıldı (Ek D, D2); iki incelemenin örtüşen bulguları birleştirildi.

**Özet:** 23 bulgu. 20 kabul, 3 kısmi kabul, 0 ret. ChatGPT kendi yanlılık riskini açıkça yazmış (#1, #2, #6, #7 eski controller tasarımını savunma riski). Bu bulguları "eski bileşeni geri getir" diye değil "korunması gereken davranış" diye okudum; hepsi seçilmiş platformda karşılanabilir.

---

## Bulgu bulgu değerlendirme

| # | Karar | Gerekçe ve yapılacak değişiklik |
|---|---|---|
| 1 | **Kabul (kritik)** — Claude #4 ve #5 ile birleşir | Kimlik zinciri eksikti. Tasarım: (a) ortam belirteci rol sınıfını verir (Claude #4'teki mekanizma); (b) **üstlenme belirteci:** `claim` işlemi yalnız o oturuma dönen tek seferlik bir gizli değer üretir; veritabanı yalnız özetini saklar; o üstlenmeyle yapılan her etki bu değeri ister. Aynı ortamdaki başka bir oturum başkasının üstlenmesiyle işlem yapamaz. (c) Oturum kimliği beyana dayalı kalır ve öyle etiketlenir. Sınama: başka oturumun üstlenmesiyle ve sahte oturum kimliğiyle çağrı denemeleri. |
| 2 | **Kabul (kritik)** | Kurtarma yalnız yeni veritabanına erişimi kesiyordu; eski routine'lerin ve oturumların GitHub'a etki yolu açık kalıyordu. Kurtarma adımlarına: eski routine'lerin durdurulması, eski ortam belirteçlerinin iptali, yayın denetiminin yeni projedeki güncel yetki dönemini okuması. Kabul testi: eski sistem erişilebilir bırakılarak `main`'e etki denemesi reddedilir, yeni iş başarılı olur. |
| 3 | **Kabul** — Claude #7 ile birleşir | "En fazla bir saat kayıp" gösterilmemiş bir iddiaydı. Olaylardan yeniden kurma sözleşmesi, dosya deposundaki gövdelerin ayrı yedeği ve aktarım başarısının izlenmesi tasarlanacak. Gösterilene kadar "hedef" olarak yazılacak. |
| 4 | **Kabul (kritik)** — Claude #2 ile birleşir | Batu'nun K6 kararı (b): `devos` açık kalıyor. Bu yüzden kontrol ilk açık yazımdan önceye taşınır: oturum içinde her `git push`, PR ve issue yazımı öncesinde çalışan, modelin kararına değil koda dayalı bir kontrol (Claude Code kancası + git'in kendi gönderim öncesi kancası). Kalan açık dürüstçe yazılacak: kontrol oturumun içinde çalıştığı için kararlı bir ajan onu atlatabilir. Bu kalan risk Batu'nun K6 kararıyla kabul edilmiştir. C03 #7 sahte "gizli" metinle yapılacak. |
| 5 | **Kısmi kabul** | Doğru: özel kaynaktan türetilmiş içerik otomatik olarak yayımlanabilir değildir. Ama her belge için ayrı yayın kararı ağır bir bürokrasi olur; Batu da çalışmada kişisel veri olmadığını söyledi (K7). Kural: açık depo, DevOS'un kendi sentezini ve kaynak kimliklerini içerebilir; özel kaynaktan aynen ya da anlamca yakın aktarım yasaktır; Batu'nun özel konuşmalarından aktarım yasaktır. Ham kanıt ve kurulum defterinin özel içerik taşıyabilecek kısımları açık depoda değil veritabanında ve gizli dosya deposunda tutulur; açık depoya yalnız güvenli özet ve kimlik girer. |
| 6 | **Kabul** | Routine başlatmanın belirsiz sonucu tasarlanmamıştı; routine API'si tekrar anahtarı sunmuyor. Başlatma niyeti, gözlenen oturum kimliği, belirsiz durum ve uzlaştırma kaydı eklenecek. Günde 15 çalışma sınırı düşünüldüğünde bu, kapasite tasarımının parçası (aşağıda A1). |
| 7 | **Kabul** — Claude #27 ile birleşir | PR kontrolünün başarısı birleşme anındaki yetkiyi garanti etmiyor. Tasarım: birleştirmeyi bir yayın işi yapar ve birleştirmeden hemen önce veritabanındaki yetkiyi yeniden okur; kalan pencere ölçülüp açıkça yazılır. Test: kontrol başarısı ile birleşme arasına izin iptali koyan senaryo. |
| 8 | **Kabul** | B aşamasında kaynağın tam gövdesini okuma yolu tanımsızdı. `devos_api`'ye sürüm ve aralıkla gövde okuma fonksiyonu eklenecek (gizlilik denetimli). Arşiv, uyarlama sadakati denetimi için de okunabilecek; uygulama talimatı olarak değil. |
| 9 | **Kabul** | Özgün P4 §21.11 karşı örneği (kontrol doğru çalışırken kendi zorunlu gereksinim tanımının eksik olması) kaybolmuştu. K11'deki onay testi korunur; özgün karşı örnek ayrıca eklenir. |
| 10 | **Kabul** | F02'nin yapısal kısmı (veritabanı) ile niteleyici yorumlama kısmı (anlamsal) ayrı kanıt katmanları olarak etiketlenecek; birincinin geçmesi ikincisini kapatmayacak. |
| 11 | **Kabul** | Hükmün dayanak kümesi (kaynak, karar, politika sürümleri) ve bunlar değişince hükmün bayatlaması veri modeline eklenecek. |
| 12 | **Kabul** | Ortak kanıt zarfı: commit, yapılandırma, ölçüt sürümü, girdi, gözlem ve ham kanıt kimliği birlikte. Farklı sürümdeki "geçti" kaydı yeni kurulumu kapatamaz. |
| 13 | **Kabul** — Claude #12 ile birleşir | C07 ölçüt 1 değişecek: kontrollü sınavda gizli eksik bulunması zorunlu; gerçek görevde "eksik bulamadı" tek başına başarısızlık değil. Batu'nun amaç ve kabul değerlendirmesi ile teknik doğrulama ayrı kaydedilecek. |
| 14 | **Kabul** | Arama ölçüsünde ayar soruları ile son kabul soruları ayrılacak; seçimden etkilenmemiş bir son değerlendirme kümesi kullanılacak. |
| 15 | **Kabul** | "Her zaman iki alternatif" kotası yanlış aktarımdı. Zorunlu olan alternatif **araştırmasıdır**; araştırmadan sonra tek uygulanabilir yol kalırsa gerekçeli istisna; seçenek alanı henüz bilinmiyorsa açık keşif durumu. Bu, emek derinliğini azaltmaz. |
| 16 | **Kabul** | Tek olaydan yetenek eksikliği **adayı** kaydedilebilir; kesinleşmesi yeniden üretim, nedensel ayrım ve karşı örnekle olur, olay sayısıyla değil. |
| 17 | **Kabul** | Tetik zamanı daralmıştı. Düzeltme: her yeni talep, iş ya da tur başında ve her maddi değişiklikten sonra, esas çalışmadan önce dokuz sorunun **tamamı** değerlendirilir; gerekli disiplin dosyasına erişilemezse etkilenen iş durur. |
| 18 | **Kabul** | Denetim izi: dokuz sorunun sonucunun tamamı (yüklendi / atlandı ve neden), disiplin sürümü, iş ve tur kimliği veritabanına yazılır; denetçinin nasıl erişeceği belirtilir. Batu'ya gösterilmez. |
| 19 | **Kabul** | Bazı yerleşik yardımcı ajanların `CLAUDE.md`'yi yüklemediği belirtiliyor. C01 ve C05'te bütün taşıyıcılar sınanacak; ortak disiplini almayan taşıyıcıya rol işi verilmeyecek ya da metin açıkça verilecek. (İddia C01'de doğrulanacak.) |
| 20 | **Kabul** | Sınırlı ilişki sorgusunun devamında aynı anlık görüntüye bağlılık ya da açık yeniden başlama tanımlanacak. |
| 21 | **Kabul** | Kaynak türü, ifadenin epistemik statüsü ve bugünkü işlem yetkisi üç ayrı alan olacak. Eski bir gerçek gözlem, tarihsel bir belgede durduğu için "yalnız fikir"e dönüşmeyecek. |
| 22 | **Kabul** | Kurulum defterinin veritabanına aktarımı için kabul koşulları: tekrar güvenliği, kesintide devam, bağ ve sürüm eşliği, eski defterin yazma yüzeyi olmaktan çıkması. |
| 23 | **Kabul** | Ek A'daki DR12 farkı yanlış tanıtılmış; kaynak zaten mekanik tanımlıyordu. Düzeltilecek. |
| Ek D toplu hüküm | Not edildi | Dokuz disiplinin içeriği sadık bulundu; eksik olan devreye girme düzeni ve denetim izi (#17–19). |
| Ek A üç sınır | Not edildi | Sadık bulundu; "kısa özet tavan değildir" notu korunacak. |

**Kısmi kabuller:** #5 (bürokrasiye dönüşmeden, K6 ve K7 kararlarıyla uyumlu bir kural), #4 ve #19'da doğrulanacak iddia bulunması. (#4 kısmen: Batu açık depo kararını verdiği için kökten çözüm uygulanmıyor.)

---

## İki inceleme birlikte: 2.1 revizyon listesi

### A. Yeniden tasarlanacaklar (çözümü henüz bulunmamış)

| # | Konu | Kaynak bulgular | Durum |
|---|---|---|---|
| A1 | **Uyandırma ve kapasite mimarisi:** günde 15 routine çalışmasıyla sensiz akış; ortam sayısı; başlatmanın belirsiz sonucu; Batu'nun kendi Claude kullanımıyla paylaşılan sınırlar | Claude #3, #5, #6, #17, #20; ChatGPT #6 | Önce araştırma: Claude Code Projects, oturumlar arası mesajlaşma, uzun ömürlü oturum, sınıra sayılmadığı bildirilen tek seferlik zamanlanmış çalışmalar, GitHub Actions, ek kullanım. Seçenekler bedelleriyle Batu'ya gelecek |
| A2 | **Kimlik zinciri:** ortam belirteci + üstlenme belirteci | Claude #4, #5; ChatGPT #1 | Tasarım yukarıda; 2.1'de yazılacak |
| A3 | **Sınav yürütme yolu:** ayrı sınav ortamı ve rolü | Claude #6 | A1'in ortam sayısıyla birlikte |
| A4 | **Yedek ve kurtarma:** yeniden üretilebilir veriyi dışlama, gövde yedeği, olaylardan yeniden kurma, eski yolların kapatılması, yeniden bağlama, Actions dakika bütçesi | Claude #7, #14, #15; ChatGPT #2, #3 | Tasarım 2.1'de |
| A5 | **Açık depoya ilk yazımdan önce kontrol** | Claude #2; ChatGPT #4, #5 | Tasarım 2.1'de; kalan risk K6 ile kabul edildi |

### B. Düzeltilecekler (tasarım belli)

Connector'ların routine ve ortamlardan çıkarılması ve etki kanalı envanteri (Claude #1); bildirim ve yedek kanal (Claude #11); Batu onaylarının amaç düzeyine indirilmesi (Claude #12, ChatGPT #13); biçim kapısı etiketi (Claude #13); API tablosunun tamamlanması (Claude #18); ikinci model geçidi (Claude #19); rol etkinleşmesinin ihtiyaca bağlanması (Claude #21); kriter 2, 3, 13, 18, 20, 24 kabul koşulları (Claude #9, #22, #23); bellek ölçümü (Claude #24); etiket düzeltmeleri (Claude #25, #26); anahtar envanteri (Claude #28); iç çelişkiler (Claude #29, başlık notu); PR ile birleşme arasındaki yetki penceresi (Claude #27, ChatGPT #7); gövde okuma fonksiyonu (ChatGPT #8); P4 §21.11 karşı örneği (ChatGPT #9); F02 katmanları (ChatGPT #10); hüküm dayanağı (ChatGPT #11); kanıt zarfı (ChatGPT #12); arama ölçüsünde son değerlendirme kümesi (ChatGPT #14); alternatif araştırması kuralı (ChatGPT #15); yetenek eksikliği adayı (ChatGPT #16); disiplin tetiği ve denetim izi (ChatGPT #17, #18); taşıyıcı sınaması (ChatGPT #19); sorgu devamı (ChatGPT #20); statü üçlüsü (ChatGPT #21); defter aktarımı (ChatGPT #22); DR12 düzeltmesi (ChatGPT #23); model erişim ara katmanı (Claude #10); kendi kendini kapatan routine ve bağımsız izleme (Claude #16).

### C. Yeni ilkeler

1. **Güncel platform okuması:** Planın dayandığı her platform davranışı resmî belgenin güncel sürümünden ve tarihiyle okunur.
2. **Etki kanalı envanteri:** Ajanın etki üretebildiği her kanal tek listede; her biri için sınır ve olumsuz test.

### D. Batu kararları (bu turda verildi)

- **K6 = (b):** `devos` açık kalır. Kayıt: özel araştırma içeriğinin kazara açığa çıkma riski, koda dayalı ön kontrollerle azaltılmış haliyle kabul edildi.
- **K7 = (a):** "Yalnız sahte veri" kuralı kişisel ve iş verisini kapsar; DevOS'un kendi araştırma kütüphanesi ölçümlerde kullanılabilir. Batu: çalışmada kişisel veri yok.
