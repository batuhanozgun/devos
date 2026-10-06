# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 6 Ekim 2026, 20:49 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C01 (Platform doğrulaması).

**Sıradaki işler:** başlatılabilir: `W-C01-03`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 6 Ekim 2026, 22:50 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

Senden beklenen: yok. 
Durum: C01'de (platform doğrulaması) dört iş ve iş listesi kabul edildi: anahtar envanteri, alt ajan belgeleri, disiplin araçlarının takip işi ve küçük ön deneme. Deneme tasarımı ikinci denetimde de kaldı; kural gereği üçüncü denemeden önce bir çerçeve incelemesi yapıyorum. Denetçinin gösterdiği ortak kök şu: bütün çalıştırma sırası, senin bir kez yapıştıracağın tek bir talimata sabitlenmiş, sonradan düzeltilemiyor. İnceleme, her çalıştırmanın talimatını ana daldaki denetlenmiş bir dosyadan okumasını tartacak. 
Tasarım geçince senden iki deneme ortamı kurmanı isteyeceğim; adımları issue #6'ya tek seferde, adım adım yazacağım. 
C00'ın "sır görünmüyor" koşulu, platform anahtarının oturum dışına uzanmadığı C01'de gösterilene kadar şarta bağlı.
