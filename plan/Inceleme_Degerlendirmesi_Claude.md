# Bağımsız Claude incelemesinin değerlendirmesi

**Tarih:** 29 Eylül 2026 · **İncelenen:** Kurulum planı 2.0 ve Ek A–G · **İnceleyen:** Bu konuşmayı görmemiş ayrı bir Claude sohbeti · **Değerlendiren:** Planı yazan oturum

**Değerlendirme yöntemi:** Her bulgu, "planı yazan ben olduğum için savunma eğilimim olabilir" uyarısıyla (Ek D, D2) tartıldı. Yüksek etkili olgusal iddialar birincil kaynakla yeniden kontrol edildi. Karar türleri: **Kabul**, **Kısmi kabul** (bulgu doğru, önerilen düzeltme değiştirildi), **Ret**.

**Özet:** 29 bulgu ve bir başlık notu. 25 kabul, 4 kısmi kabul, 0 ret. Üç kritik bulgunun üçü de doğru çıktı.

---

## Yeniden doğrulanan olgusal iddialar

| İddia | Sonuç | Kaynak |
|---|---|---|
| Routine'lere hesaptaki bütün connector'lar varsayılan olarak ekleniyor; oturum bunları yazma dahil izinsiz kullanabiliyor | **Doğru** | Claude Code routines belgesi (code.claude.com/docs/en/routines) |
| Max planında günde en fazla 15 routine çalışması | **Doğru.** Planda "resmî belgede yazılı değil" demiştim; Anthropic'in resmî duyurusunda yazıyor. Hatam | claude.com/blog/introducing-routines-in-claude-code |
| Claude Code Projects 17 Eylül 2026'da beta olarak çıktı: bir koordinatör konuşması işi paralel bulut oturumlarına dağıtıyor | **Doğru.** Ayrıca oturumlar arası mesajlaşma (Ağustos 2026) ve projelerin routine oluşturabilmesi gibi, planın hiç değerlendirmediği yeni özellikler var | Birden çok bağımsız haber kaynağı; Anthropic duyurusu |
| GitHub Free'de gizli depolarda dal koruması yok | **Doğru.** Gizli depoda koruma için GitHub Pro gerekiyor | docs.github.com, protected branches |

---

## Bulgu bulgu değerlendirme

| # | Karar | Gerekçe ve yapılacak değişiklik |
|---|---|---|
| Başlık | Kabul | Plan Bölüm 2 hâlâ "31 madde" diyor; 32 ve 33 eklenince düzeltilmemiş. Düzeltilecek. |
| 1 | **Kabul (kritik)** | Güvenlik tasarımım yalnız veritabanı kapısına odaklandı; ajanın başka hangi kanallardan etki üretebileceğini (connector'lar) envanterlemedi. Bu bir hata sınıfıdır: **etki kanalı envanteri eksikliği**. Düzeltme: her routine ve ortam için connector'ların çıkarılması kurulum adımı olur; C01'e connector envanteri, C03'e "DevOS oturumunda hiçbir connector aracı görünmüyor" olumsuz testi eklenir; plana "ajanın etki üretebildiği bütün kanallar" envanteri ilke olarak girer. |
| 2 | **Kabul (kritik)** | Açık depoda içerik dala gönderildiği anda yayımlanır; PR kontrolü geç kalır. Bu, Batu'nun görünürlük kararını ilgilendirdiği için Batu'ya karar olarak gidiyor (Karar K6). C03 #7 sahte "gizli" metinle yapılacak. |
| 3 | **Kabul (kritik)** | Uyandırma mimarisi günde 15 çalışmaya sığmıyor. Bu, planın temel bir tasarım sorunudur ve "C01'de sınanır" diyerek bırakılamaz. Ayrıca planın değerlendirmediği yeni seçenekler var (Projects koordinatörü, oturumlar arası mesajlaşma, uzun ömürlü oturum, sınıra sayılmadığı bildirilen tek seferlik zamanlanmış çalışmalar, ek kullanım). Uyandırma ve kapasite mimarisi araştırılarak yeniden tasarlanacak; seçenekler bedelleriyle Batu'ya gelecek. |
| 4 | **Kabul** | Doğru: Supabase'in gizli anahtarı erişim kurallarını atlıyor; eski anahtar düzeni kalkıyor. Tasarım: ortamlara yalnız herkese açık anahtar + ayrı bir başlıkta ortam belirteci verilir; belirtecin özeti veritabanında tutulur ve her `devos_api` fonksiyonu rol sınıfını buradan çıkarır. Belirteci Batu, Supabase panelinde hazır verilen tek bir SQL satırını çalıştırarak üretir; değer bir kez görünür, Batu onu Claude ortamının ayar alanına yapıştırır; kurucu değeri hiç görmez. Ajan ortamlarında gizli anahtar açıkça yasaklanır. |
| 5 | **Kabul** | Doğru: veritabanı yalnız ortamı doğrulayabilir; oturum kimliği ve rol adı beyana dayanır. Ayrılık gerektiren her çift farklı ortamlara konacak; oturum düzeyindeki ayrım "beyana dayalı" diye etiketlenecek; N03 ve N04'e sahte beyan örnekleri eklenecek. Ortam sayısının artması #3 ile birlikte tasarlanacak. |
| 6 | **Kabul** | Sınav yürütme yolu tanımsızdı. Ayrı bir sınav ortamı ve veritabanı rolü; sınanan rol görevi kendi ortamında normal iş olarak alır; cevap anahtarı yalnız sınav ortamında. İnceleme rollerinin sınavını başka ortam hazırlar. #3 ile birlikte kapasite hesabına girecek. |
| 7 | **Kabul** | Yedek biçimi ve Actions dakika bütçesi tasarlanmamıştı. Yeniden üretilebilir veri (vektörler) yedekten çıkarılır, yerine kaynak ve model sürümü kaydedilir; döküm boyutu ve dakika bütçesi C04'ten önce hesaplanır; saklama yeri seçenekleri gerekirse bedeliyle Batu'ya gelir. |
| 8 | **Kabul** | Bölüm 10.1'deki bazı maddeler aslında çözülmemişti. 10.2'ye taşınacak: kapasite ve uyandırma, sınav yürütme, anahtar-rol eşlemesi, yeniden bağlanma, yedek biçimi. (Bu revizyonda çoğunun tasarımı yapılacak; yapılamayan açık kalacak.) |
| 9 | **Kabul** | "Yalnız sahte veri" kuralının kapsamı belirsiz; arama ölçüsü gerçek kütüphaneyi kullanıyor. Kapsam Batu'nun kararı (Karar K7). |
| 10 | **Kabul** | Model erişim ara katmanı C08'de tasarlanıp kurulacak; C11 sınamasının asgari ürün kapsamı önceden yazılacak; Claude ayağı abonelik içindeki oturumla koşulacak. |
| 11 | **Kabul** | "Kesin ulaşan yedek kanal" ölçülebilir yapılacak: belirli sürede açılmayan karar ikinci kanaldan yinelenir. B3 (a) makine hesabı bu sorunu da çözüyor: issue'ları makine hesabı açacağı için Batu bildirim alır. |
| 12 | **Kısmi kabul** | Doğru: Batu'nun uzmanlık dışındaki teknik onayları biçimsel imzaya dönüşebilir. Ama kontrol ve yetki kurallarını değiştiren işlerde bir insan kapısı, ajanların kendi kurallarını sessizce değiştirmesine karşı değerli. Düzeltme: teknik doğruluğu bağımsız inceleme belirler; Batu'ya yalnız amaç ve risk açısından sade bir kabul sorusu gelir; onay sayısı C06–C07'de ölçülür. |
| 13 | **Kabul** | Veritabanı yalnız alanın dolu olduğunu zorlayabilir, adımın gerçekten yapıldığını değil. Bu kurallara "biçim kapısı" denecek; içerik örneklem incelemesine bağlanacak; testlere "dolu ama anlamsız" örnek eklenecek. |
| 14 | **Kabul** | Yedek işi için salt okuma yetkili `devos_backup` rolü; aktarım işareti yalnız bir fonksiyonla. C03'te sınanacak. |
| 15 | **Kabul** | Geri yüklemede ortamların, routine'lerin ve kontrollerin yeni projeye yeniden bağlanması adımlara ve Batu'nun iş listesine eklenecek; tatbikatta en az bir ortam gerçekten yeniden bağlanacak. |
| 16 | **Kabul** | GitHub bağlantısı bozulursa routine'in kendini kapatması ve izleme bileşeninin izlediği şeylere bağımlı olması G7'ye ve risklere eklenecek; en az bir izleme yolu DevOS'tan bağımsız olacak. (72 saat süresi C01'de doğrulanacak.) |
| 17 | **Kabul** | DevOS, Batu'nun kendi Claude kullanımıyla aynı sınırları paylaşıyor. Bu karşılıklı etki U-5'e ve kapasite kararına girecek. |
| 18 | **Kabul** | API tablosu tamamlanacak; kısıt çelişkisinin "otomatik" tespiti yanlış ifade — hangi rolün ne zaman arayacağı yazılacak. |
| 19 | **Kabul** | İkinci modele giden her istek tek bir fonksiyondan, sızıntı denetiminden ve kayıttan geçecek; ücretsiz kotanın düşüklüğü kapasite planına girecek. |
| 20 | **Kabul** | Claude Code Projects ve oturumlar arası mesajlaşma, #3'teki yeniden tasarımda maddi alternatif olarak değerlendirilecek. Batu'nun hesabında Projects'in açık olup olmadığı C01 öncesinde kontrol edilecek (beta, önce mevcut projesi olmayan kullanıcılara açıldı; Batu'nun claude.ai'de mevcut projeleri var). |
| 21 | **Kısmi kabul** | Doğru: 18 rolün hepsi için baştan sınav hazırlamak kapasiteyi SOUL'dan çalabilir. Ama rol gruplarına inmek kriter 32'yi zayıflatır. Düzeltme: 18 rol sözleşmesi korunur; roller ihtiyaç duyuldukça etkinleşir (zaten "hepsi her an etkin değil"); sınav ve hazırlık rol etkinleşirken yapılır; başlangıç etkin kümesi C07'nin gerektirdiği rollerle sınırlanır. |
| 22 | **Kabul** | Kriter 3 SOUL gereksinim kaydına açıkça devredilecek; kriter 2 için asgari ürün kapsamı yazılacak. |
| 23 | **Kabul** | Rolün emekliye ayrılması, süreç sınırı ve düzenli çalışma (örneğin gözetimsiz birkaç günlük çalışma) için kabul koşulları eklenecek. |
| 24 | **Kabul** | C04 ölçümüne bellek ve gecikme eklenecek. |
| 25 | **Kısmi kabul** | İki kaynak çelişiyor: DEVOS-002 hesap eklentilerinin yüklendiğini, inceleme ise yüklenmediğini söylüyor. Etiket "[Doğrulandı]"dan "[Doğrulama bekliyor; kaynaklar çelişiyor]"a çevrilecek; C01'de gözlenecek. |
| 26 | **Kabul** | Etiketler birincil kaynak ve tarihle güncellenecek; `gte-small` resmî belgede yalnız İngilizce tanımlı (varsayımım doğrulandı). |
| 27 | **Kabul** | "Kontroller o anda geçmeli" ifadesi fazla güçlü; düzeltilecek. Otomatik birleşme C01'de ayrıca sınanacak. |
| 28 | **Kabul** | Tek bir anahtar envanteri: anahtar, sahibi, yeri, yetkisi, iptal yolu. |
| 29 | **Kısmi kabul** | Çelişkiler doğru; D9 ve DR16'daki "dosya aç" ifadesi B aşamasında "kütüphanede ara ve kaynak gövdesini `devos_api` üzerinden getir" olarak yazılacak; `.claude/protocols/` ağaca eklenecek; `session_brief` imzası tekleşecek. |

---

## Bu inceleme ne öğretti?

Üç kritik bulgunun ortak nedeni: plan, platform özelliklerini güncel birincil kaynaklardan yeterince derin okumadan kurdu ve güvenliği yalnız bir kanal (veritabanı) üzerinden düşündü. Bu iki hata sınıfı yeni revizyonda ilke olarak eklenecek:

1. **Güncel platform okuması:** Planın dayandığı her platform davranışı, resmî belgenin güncel sürümünden ve tarihiyle okunur; ikincil kaynak "[Doğrulandı]" sayılmaz.
2. **Etki kanalı envanteri:** Ajanın dünyada etki üretebildiği her kanal (veritabanı, GitHub, connector'lar, ağ, ikinci model) tek listede tutulur ve her biri için sınır ve olumsuz test yazılır.

---

## Batu'nun kararına gelenler

- **K6 — `devos` deposunun görünürlüğü** (#2).
- **K7 — "Yalnız sahte veri" kuralının kapsamı** (#9).
- Uyandırma ve kapasite mimarisi (#3) araştırma ve yeniden tasarımdan sonra seçenekleriyle gelecek.
