# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 6 Ekim 2026, 21:05 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C01 (Platform doğrulaması).

**Sıradaki işler:** başlatılabilir: `W-C01-03`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 6 Ekim 2026, 22:50 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

Senden beklenen: yok. 
Durum: C01'de (platform doğrulaması) iş listesi ve dört iş kabul edildi. Deneme tasarımı iki kez denetimden kalınca kural gereği bir çerçeve incelemesi yaptım (FR-04) ve denetimden geçti. Yeni çerçeve: rutinlerin talimatı kısa ve sabit; her çalıştırma ne yapacağını ana daldaki denetlenmiş bir dosyadan okuyor; çalıştırmalar zamanlayıcıyla başlıyor; sıra plandaki gibi, önce 1–4. ve 17. satırlar. Planı değiştirmiyor, senin adımlarını artırmıyor. Tasarımın üçüncü turu bu çerçeveyle yazılıyor. 
Tasarım geçince senden iki deneme ortamı kurmanı isteyeceğim; adımları issue #6'ya tek seferde, adım adım yazacağım. 
C00'ın "sır görünmüyor" koşulu, platform anahtarının oturum dışına uzanmadığı C01'de gösterilene kadar şarta bağlı.
