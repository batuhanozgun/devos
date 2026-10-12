# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-034` (Auto mod kuralın bundan sonra nasıl uygulansın: (a) bugünkü gibi, her Auto kullanımı senin her seferinde vereceğin bir istisna; (b) çalışma oturumu Accept edits'te kalır; Auto yalnız platformun başka mod bırakmadığı oturumlarda (başka yol bulunamazsa routine'lerin açtıkları) ve önceden adı yazılmış tek işlik kısa pencerelerde, kurucunun gerekçesi ve bir denetçinin kararıyla (önerim); (c) mod, çalışma oturumu dahil, kurucunun teknik seçimi), `D-035` (Opus 5.5 ve ultracode kuralın: (a) varsayılan; kurucu yalnız kalitenin düşmediğini bir denetçiyle gösterdiği mekanik işlerde daha hafif bir model ya da daha düşük bir efor kullanabilir (önerim); (b) kurucunun açtığı her oturum için sabit ayar, bugünkü gibi), `D-036` (Planın ilkelerindeki “farklı bir araç” sözü: (a) yalnız paraya, hesaplarına, verilerine ya da diğer işlerine dokunan araç değişikliği sana gelir; diğerlerine kurucu karar verir ve gerekçesini yazar (önerim); (b) her araç değişikliği sana gelir, yazıldığı gibi; (c) (a) gibi, ama diğer değişiklikler de sana tek satırla bildirilir), `D-037` (“Batu kararı” etiketli ama içinde teknik ayrıntı da olan metinler: (a) etiket yalnız senin kısımlarını kapsayacak biçimde daraltılır, teknik kısımlar kaynağıyla kurucunun önerisi olarak işaretlenir (önerim); (b) etiketler kalır, her teknik değişiklik ayrı ayrı sana gelir; (c) etiketler kalır, kurucunun kendi kuralı değişir). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 13 Ekim 2026, 01:13 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C02 (Veri modeli, kural kapısı ve kimlik zinciri).

**Sıradaki işler:** `W-C02-03`, `W-C02-07` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "uyarı düzeyinde" düzeyinde (haftalık pencere); pencere 17 Ekim 2026, 20:00 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

**Senden beklenen** (acil değil; şu an bunları bekleyen bir iş yok): teknik içerikli kararlarınla ilgili dört soru, D-034 ile D-037 arası, #6'da; her biri tek harfle cevaplanır. Adım 1 tamam (12 Ekim 23:33); doğrulamasını göç işinin ilk çalışması yapacak, sonucu #6'da bildireceğim. 
**Senin kuralın (D-033):** kullanıcı aksini belirtmedikçe sözleri teknik şartname değildir; kurulum, DevOS ve SOUL için. DevOS'un ve SOUL'un kurallarına yazıldı (PC-48, denetçi onayladı). D-032 bu yüzden geri çekildi. Kararlarının içinden teknik olup bizi kısıtlayanların listesi ve dört soru üç denetimden geçti; #6'ya tek parça olarak yazıldı. 
**C01 kabul edildi** (12 Ekim), sınırlarıyla (FR-05'in daralttığı amaç; rutinin silinmesi senin bildirimin, N-202 yarın 11:40'tan sonra; birleşik deneme kısmi, N-207). 
**C02 sürüyor.** Yedi madde kabul edildi: W-C02-15, W-C02-19, W-C02-16, W-C02-04 (veri modeli), W-C02-05 (kimlik zinciri ve ortamlar), W-C02-11 (oturum araçlarının kapatılması), W-C02-06 (defterin aktarım tasarımı). Veritabanı değişikliklerini uygulayacak yol (W-C02-03): düzeltildi, GitHub'un kendi çalıştırmasında da geçti, denetimden geçti ve birleştirildi. İlk çalışmaları başlıyor: ilki sunucu adresini bulup durur (tasarım gereği), ikincisi bağlanır ve adım 1'i doğrular; sonuç #6'da. C02'nin testleri (W-C02-07) tamamlanıyor. 
**Kullanım:** haftalık kullanım hızı uyarısı var; senin sözünle iş hafif işlerle sınırlı değil (D-002, 12 Ekim).
