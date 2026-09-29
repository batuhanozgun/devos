# Çalışma düzeni, uyandırma ve kapasite (A1) — sürüm 2

**Tarih:** 29 Eylül 2026 · **Statü:** Karar verildi (teknik karar). Kurulum planı 2.1'e girecek.

**Bu sürüm neden var?** İlk sürüm, "her rol ayrı bir oturumdur ve her devir sistemin kendini yeniden uyandırmasını gerektirir" öncülünü sorgulamadan kabul etti. Bu öncül P4 ve P5'teki tasarımdan (bir yöneticinin yönettiği ayrı süreçler) taşındı. Günde 15 routine sınırı bu öncülü tıkayınca plan yeni mekanizmalar eklemeye başladı. Doğru hamle mekanizma eklemek değil, öncülü sorgulamaktı. Bu sürüm onu yapıyor.

---

## 1. Öncül denetimi

| Öncül | Kaynağı | Hâlâ geçerli mi? | Sıfırdan seçer miydik? |
|---|---|---|---|
| DevOS, Batu başlatmadan ve bilgisayar kapalıyken çalışmalı | Batu'nun kriterleri 21, 22 | Evet | Evet |
| Her rol ayrı bir oturumda çalışır | P4/P5'in süreç tasarımı | **Hayır.** Rol bir sorumluluk ve bir paket; oturum bir çalışma yeri. Rol bir alt ajanda da taşınabilir | Hayır |
| Roller arası her devir yeni bir oturum başlatmayı gerektirir | Önceki öncülün sonucu | **Hayır.** Aynı oturumdaki alt ajanlar arasında devir zil gerektirmez | Hayır |
| Bağımsızlık ayrı kimlik gerektirir | Kriter 30 | **Kısmen.** İki tür bağımsızlık var. *Düşünme bağımsızlığı* (temiz bağlam, farklı bilgi görünümü, farklı talimat, gerekirse farklı model ailesi) alt ajanlarla sağlanabilir. *Yetki bağımsızlığı* (kendi değişikliğini onaylayamama, sınav cevaplarını görememe, kontrol kurallarını değiştirememe) veritabanının doğrulayabildiği ayrı kimlik ister | Yalnız yetki bağımsızlığı için |
| İş hacmi için çok sayıda paralel oturum gerekir | Varsayım | **Hayır.** Asıl sınır kullanım hakkı (token), oturum sayısı değil. Paralellik oturum içinde alt ajanlarla da sağlanır | Hayır |
| Oturumlar saatlerce çalışabilir | Varsayım | **Bilinmiyor.** Bulut oturumunun ne kadar sürebileceği C01'de ölçülecek | Ölçüme bağlı |

---

## 2. Karar: "ekip ofiste, denetçi ayrı" düzeni

**Üç ortam** (önceki beş yerine):

| Ortam | Ne yapar? | Yetkisi |
|---|---|---|
| `devos-calisma` | Koordinasyon, keşif, araştırma, tasarım, üretim, bilgi düzeni, teşhis. Rollerin çoğu bu oturumun içinde alt ajan olarak çalışır | İş açma ve üstlenme, katkı ve aday ürün yazma, `claude/` dallarına gönderim, PR açma. **Yapamaz:** bağlayıcı inceleme hükmü, kabul, sürüm etkinleştirme, kontrol kuralı değişikliği, sınav cevaplarına erişim |
| `devos-denetim` | Bağımsız inceleme hükümleri (DR13-G, DR13-Y), kabul önerileri, kontrol ve kural değişikliği incelemesi, yüksek etkili birleşmeler için yetki kontrolü, kurtarma aşamalarının ilerletilmesi | Hüküm ve kabul yazma; çalışma ortamının ürettiğini onaylama. **Yapamaz:** ürün üretme, sınav cevaplarına erişim |
| `devos-sinav` | Gizli sınav setlerini tutar ve puanlar | Yalnız `devos-evals` deposuna ve sınav kayıtlarına erişim |

**Sınavlar nasıl yürür?** Sınav ortamı, sınav görevini veritabanına sıradan bir iş olarak koyar. Çalışma ortamı bu işi normal iş gibi yürütür; görevin sınav olduğunu bilmek zorunda değildir. Sınav ortamı sonucu cevap anahtarıyla puanlar. Böylece sınanan rol cevap anahtarına hiçbir yoldan ulaşamaz ve "sınava göre davranma" riski azalır.

**Oturum içinde:** Çalışma oturumunun ana ajanı koordinatördür (DR06-G ve DR06-Y). İşin gerektirdiği rolleri kendi rol paketleriyle alt ajan olarak başlatır; birbirinden bağımsız işleri paralel yürütür. Her alt ajanın katkısı veritabanına katkı olarak yazılır, tüketen taraf kullanım kaydını yazar. Böylece oturum kesilse bile bir sonraki oturum kaldığı yerden devam eder (Ek D, D7).

**Düşünme bağımsızlığı nerede yeterli?** Araştırma incelemesi, tasarım eleştirisi ve çerçeve incelemesi gibi bağlayıcı olmayan incelemeler, çalışma oturumunda temiz bağlamlı ve farklı bilgi görünümlü bir alt ajanla yapılabilir. Bağlayıcı hükümler (kabul, birleşme için yetki, kural değişikliği) yalnız denetim ortamında verilir.

---

## 3. Uyandırma

Routine'ler yalnız oturumların başlamasını sağlar; roller arası devirler için kullanılmaz.

| Ortam | Günlük çalışma (başlangıç) | Zamanlama |
|---|---|---|
| Çalışma | 3 uzun oturum | Gece, sabah erken, akşam (Batu'nun yoğun saatleri dışında) |
| Denetim | 3 | Her çalışma oturumundan sonra |
| Sınav | 1 | Gece, yalnız sınav gerektiğinde |
| Yedek | 8'e kadar | Oturumlar kısa kalırsa ek çalışma oturumu, acil karar ya da kurtarma |

Toplam 7 çalışma ile başlar; 15 sınırının yarısı yedek kalır. Oturumların gerçek süresi C01'de ölçülür; kısa çıkarsa çalışma oturumlarının sayısı yedekten artırılır.

**Beklenti:** Roller arası devirler çalışma oturumunun içinde dakikalar sürer. Bağlayıcı bir hüküm, bir sonraki denetim oturumuna kadar (birkaç saat) bekler. Batu'ya ait kararlar, Batu cevap verdikten sonraki ilk oturumda işlenir.

---

## 4. Diğer güvenlik ve süreklilik kararları

- **Connector'lar:** Her routine'den çıkarılır; ayrıca depodaki izin kuralları connector araçlarının çağrılmasını engeller. İki katman C01 ve C03'te sınanır.
- **Kimlik zinciri:** Ortam belirteci rol sınıfını verir; üstlenme belirteci o oturumun o işi yaptığını kanıtlar. Oturum içindeki alt ajanlar aynı kimliği paylaşır; bu yüzden yetki ayrılığı gerektiren hiçbir iş oturum içinde yapılmaz.
- **Açık depoya yazım:** Depodaki kancalar ve git'in gönderim öncesi kancası, her gönderimden önce sızıntı kontrolünü çalıştırır.
- **Oturum kaydı:** Her oturum açılışta kendini kaydeder (ortam, başlangıç, hangi routine). Acil API tetiklerinde niyet ve dönen oturum kimliği kaydedilir; cevap kaybolursa önce oturumun varlığı kontrol edilir.
- **Projects:** Artık zorunlu değil. Hesapta açılırsa ve C01'de doğrulanırsa, çalışma ortamının işini hızlandırmak için kullanılabilir; güvenlik modeli değişmez, çünkü yetki oturumun açılış yolundan değil anahtardan gelir.
- **Kullanım paylaşımı:** Yoğun çalışma oturumları Batu'nun çalışma saatleri dışına konur; etkisi ölçülür; Batu'nun işi ciddi biçimde yavaşlarsa bu Batu'ya karar olarak gelir.

---

## 5. Bu kararın bedeli ve C01'de önce sınananlar

**Bedel:** Bir çalışma oturumu düşerse o anda çalışan bütün roller birlikte durur; iş veritabanından devam ettiği için veri kaybı olmaz, gecikme olur. Alt ajanlar oturumun kullanım hakkından ve bağlamından pay alır; çok büyük işler birden fazla oturuma bölünür.

**C01'in ilk satırları:**
1. Bir bulut çalışma oturumunun kuyruk işleyerek ne kadar süre çalışabildiği; bağlam sıkıştırmasından sonra işi doğru sürdürüp sürdürmediği.
2. Alt ajanların rol paketleriyle doğru başlatıldığı; `CLAUDE.md`'yi atlayan yerleşik yardımcıların rol işi için kullanılmadığı.
3. Connector engellerinin gerçekten çalıştığı.
4. Üç ortamın anahtarlarının birbirinin yetkisini kullanamadığı.
5. Bir haftalık gözlemde kullanım payı.

---

## 6. Bu olaydan çıkan kalıcı ders

Çerçeve körlüğü DevOS'un ve SOUL'un en büyük tehlikesidir (Batu, 29 Eylül 2026). Bu olayın öğrettiği işaret: **bir tasarım bir sınıra takıldığında ve çözüm olarak yeni mekanizmalar üretmeye başladığında, önce çerçevenin kendisi sorgulanmalıdır.** Kurulum planı 2.1'e bunun mekanizması girer: öncül envanteri, sıkışma sinyalinde zorunlu çerçeve denetimi ve yalnız amaç ile kısıtları gören bağımsız bir oturumun kendi tasarımını çıkarıp mevcut tasarımla karşılaştırması.
