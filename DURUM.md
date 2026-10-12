# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-032` (C02 sonunda defter veritabanına taşınınca kurulum kayıtlarının asıl yeri: (a) veritabanı; main her tamamlanan işten sonra ve her duruştan önce güncellenen kopyayı tutar (önerim); (b) tek doğru kaynak main kalır; veritabanı ondan doldurulan kopyayı tutar). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 12 Ekim 2026, 22:16 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C02 (Veri modeli, kural kapısı ve kimlik zinciri).

**Sıradaki işler:** `W-C02-03`, `W-C02-07` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "uyarı düzeyinde" düzeyinde (haftalık pencere); pencere 17 Ekim 2026, 20:00 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

**Senden beklenenler** (ikisi de acil değil; şu an bunları bekleyen bir iş yok): (1) Adım 1, veritabanı şifrelerini GitHub'a girmek ([#6'daki yorum](https://github.com/batuhanozgun/devos/issues/6#issuecomment-6129504560)); karar değil, yalnız adım; yaklaşık 15 dakika, ücretsiz. (2) Karar D-032 ([#6'daki yorum](https://github.com/batuhanozgun/devos/issues/6#issuecomment-6130933563)): defter veritabanına taşınınca kayıtların asıl yeri; önerim (a). 
**C01 kabul edildi** (12 Ekim), sınırlarıyla (FR-05'in daralttığı amaç; rutinin silinmesi senin bildirimin, N-202 yarın 11:40'tan sonra; birleşik deneme kısmi, N-207). 
**C02 sürüyor.** Yedi madde kabul edildi: W-C02-15, W-C02-19, W-C02-16, W-C02-04 (veri modeli), W-C02-05 (kimlik zinciri ve ortamlar), W-C02-11 (oturum araçlarının kapatılması), W-C02-06 (defterin aktarım tasarımı). Veritabanı değişikliklerini uygulayacak yol (W-C02-03) kuruldu, son düzeltmeleri ve denetimi sürüyor; C02'nin testleri (W-C02-07) tamamlanıyor. 
**Kullanım:** haftalık kullanım hızı uyarısı var; senin sözünle iş hafif işlerle sınırlı değil (D-002, 12 Ekim).
