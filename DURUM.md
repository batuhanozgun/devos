# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-038` (T-W03-08'in kırma denemesi ve iki test dalının silinmesi, tek seferde: (a) GitHub'da sahte bir ortam açarsın, ben denemeyi yaparım, sonra ortamı ve üç dalı silersin (önerim); (b) hiçbiri: kırma denemesi 'kontrol edilemedi' kalır, dallar durur). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 14 Ekim 2026, 19:27 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C02 (Veri modeli, kural kapısı ve kimlik zinciri).

**Sıradaki işler:** `W-C02-20` sürüyor; başlatılabilir: `W-C02-08`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "uyarı düzeyinde" düzeyinde (haftalık pencere); pencere 17 Ekim 2026, 20:00 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

**Sürüyor** (14 Ekim, 14:07 UTC'de senin "devam"ınla). Zamanlanmış üç çalışma (S1–S3) okundu: şifre hiçbir yerde bulunmadı, sahte işaret konduğu yerlerde bulundu. Veritabanı yolunun dört kontrollü denemesi (H2–H5) bitti: hatalı ya da fark çıkaran değişiklik asıl veritabanına hiç gitmedi; onarımlardan sonra iki veritabanı yine birebir aynı. 
**W-C02-03 kabul edildi** (veritabanı değişikliklerini uygulayan yol, 14 Ekim): son denetçi koşullarla onayladı, koşullar karşılandı. 
**Senden beklenen:** bir adım, isteğe bağlı: D-038 (#6), bir test için GitHub'da sahte bir ortam açıp sonra onu ve üç test dalını silmek. #6'daki dört cevabın (13 Ekim: D-034 b, D-035 a, D-036 a, D-037 a) kayda geçti; efor denemen için deponun sabit "xhigh" ayarı kaldırıldı, etkisi oturum yeniden başlayınca görülecek. 
**Senin kuralın (D-033):** kullanıcı aksini belirtmedikçe sözleri teknik şartname değildir; kurulum, DevOS ve SOUL için. DevOS'un ve SOUL'un kurallarına yazıldı (PC-48, denetçi onayladı). 
**C01 kabul edildi** (12 Ekim), sınırlarıyla (FR-05'in daralttığı amaç; rutinin silinmesi senin bildirimin, N-202 bugün 11:40'tan sonra; birleşik deneme kısmi, N-207). 
**C02 sürüyor.** On bir madde kabul edildi; sonuncusu koruyucunun `Monitor` açığının kapatılması (W-C02-21). Veritabanı değişikliklerini uygulayacak yol (W-C02-03): ilk değişiklik iki projeye de uygulandı. Kabul için gereken canlı denemelerin ilk adımı (H0) birleşti. İkinci adım (H1′) GitHub'da provadan geçti, denetçi koşullarla onayladı. GitHub'ın zamanlanmış işi ilk kez çalıştı (07:05 UTC): iki projede de şifreyi aldı ve bağlandı, şifre hiçbir yerde bulunmadı. Bu yüzden elle başlatma yoluna (E2) gerek kalmadı; H1′ birleşti. Test için hazırlanan sahte değişiklik iki projeye de uygulandı ve ikisinde de dosyadakiyle birebir aynı görüldü. Şifreyi isteyen sahte bir iş akışı ayrı bir dala gönderildi: GitHub dala gönderimde, PR'da, elle başlatmada ve yeniden çalıştırmada şifreyi vermedi. Asıl sızma araması bugün 18:41'deki (UTC) zamanlanmış çalışmada yapılacak. Bu arada sonraki adımların provası GitHub'da geçti. Koruyucuya iki ekleme denetimden geçip birleşti ve canlı denendi: anahtar biçimindeki metinler dışarı giden hiçbir yerden çıkamıyor (W-C02-20'nin ilk kısmı; sahte bir anahtarla yapılan iki deneme de durduruldu), ve hiçbir denetimden geçmeden kabuk komutu çalıştırabilen `Monitor` aracı kapatıldı (W-C02-21 kabul edildi). Denetçi, ilk hâlinde anahtar desenlerinin tek bir dosya değişikliğiyle sessizce devre dışı bırakılabildiğini buldu; düzeltildi. Koruyucudaki iki küçük açık da denetimden geçip birleşti: nesne olmayan bir girdi artık koruyucunun reddini bozmuyor (N-269), anahtar desenlerinin dosyaları da birleştirme kapısında korunuyor (N-270). 
**Kullanım:** haftalık kullanım hızı uyarısı var; senin sözünle iş hafif işlerle sınırlı değil (D-002, 12 Ekim).
