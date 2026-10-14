# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 14 Ekim 2026, 17:24 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C02 (Veri modeli, kural kapısı ve kimlik zinciri).

**Sıradaki işler:** `W-C02-03`, `W-C02-20` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "uyarı düzeyinde" düzeyinde (haftalık pencere); pencere 17 Ekim 2026, 20:00 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

**Duraklatıldı** (13 Ekim, 08:40 UTC; senin isteğinle, haftalık kullanım %83). Devam etmek için bu oturuma "devam" yazman yeter; haftalık sınır 17 Ekim 20:00'de (Türkiye saati) yenileniyor. İki veritabanı tutarlı, `main` temiz; zamanlanmış iki çalışma (S1 ve S2) bugün kendiliğinden yapılacak, sonuçlarını devam edince okuyacağım. Sıradaki işler hazır ve kendi dallarında bekliyor. 
**Senden beklenen** (acil değil; şu an bunları bekleyen bir iş yok): teknik içerikli kararlarınla ilgili dört soru, D-034 ile D-037 arası, #6'da; her biri tek harfle cevaplanır. 
**Senin kuralın (D-033):** kullanıcı aksini belirtmedikçe sözleri teknik şartname değildir; kurulum, DevOS ve SOUL için. DevOS'un ve SOUL'un kurallarına yazıldı (PC-48, denetçi onayladı). 
**C01 kabul edildi** (12 Ekim), sınırlarıyla (FR-05'in daralttığı amaç; rutinin silinmesi senin bildirimin, N-202 bugün 11:40'tan sonra; birleşik deneme kısmi, N-207). 
**C02 sürüyor.** On bir madde kabul edildi; sonuncusu koruyucunun `Monitor` açığının kapatılması (W-C02-21). Veritabanı değişikliklerini uygulayacak yol (W-C02-03): ilk değişiklik iki projeye de uygulandı. Kabul için gereken canlı denemelerin ilk adımı (H0) birleşti. İkinci adım (H1′) GitHub'da provadan geçti, denetçi koşullarla onayladı. GitHub'ın zamanlanmış işi ilk kez çalıştı (07:05 UTC): iki projede de şifreyi aldı ve bağlandı, şifre hiçbir yerde bulunmadı. Bu yüzden elle başlatma yoluna (E2) gerek kalmadı; H1′ birleşti. Test için hazırlanan sahte değişiklik iki projeye de uygulandı ve ikisinde de dosyadakiyle birebir aynı görüldü. Şifreyi isteyen sahte bir iş akışı ayrı bir dala gönderildi: GitHub dala gönderimde, PR'da, elle başlatmada ve yeniden çalıştırmada şifreyi vermedi. Asıl sızma araması bugün 18:41'deki (UTC) zamanlanmış çalışmada yapılacak. Bu arada sonraki adımların provası GitHub'da geçti. Koruyucuya iki ekleme denetimden geçip birleşti ve canlı denendi: anahtar biçimindeki metinler dışarı giden hiçbir yerden çıkamıyor (W-C02-20'nin ilk kısmı; sahte bir anahtarla yapılan iki deneme de durduruldu), ve hiçbir denetimden geçmeden kabuk komutu çalıştırabilen `Monitor` aracı kapatıldı (W-C02-21 kabul edildi). Denetçi, ilk hâlinde anahtar desenlerinin tek bir dosya değişikliğiyle sessizce devre dışı bırakılabildiğini buldu; düzeltildi. Koruyucudaki iki küçük açık da denetimden geçip birleşti: nesne olmayan bir girdi artık koruyucunun reddini bozmuyor (N-269), anahtar desenlerinin dosyaları da birleştirme kapısında korunuyor (N-270). 
**Kullanım:** haftalık kullanım hızı uyarısı var; senin sözünle iş hafif işlerle sınırlı değil (D-002, 12 Ekim).
