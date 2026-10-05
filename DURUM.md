# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-009` (D-008 altında oturum başlatma: tek görevi yeni çalışma ve inceleme oturumlarını başlatmak olan bir oturum otomatik modda çalışabilir mi?). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 5 Ekim 2026, 12:49 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01XBdYJwHjvsouur4ayJJM5Z`; kilit 5 Ekim 2026, 15:31 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 5 Ekim 2026, 14:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Senden bir karar bekleniyor: **D-009** (issue #6'da). 
1. Accept edits modundaki bir oturum yeni oturum açamıyor: platform "onay gerekiyor" diyerek reddediyor; belgelerine göre bunu hiçbir kural dosyası aşamıyor. D-008 kararın olduğu gibi kalırsa sistem kendi kendine devam edemez ve bağımsız incelemeler başlatılamaz. 
2. Bu oturum yeni oturum gerektirmeyen işi bitiriyor: tranche 1c (W-C00-12.4, PR #86) yeni guard'ın üzerine taşınıyor. Sonra duracak. 
**Açık uç:** Ayrı "ultracode" bayrağı hâlâ doğrulanamadı: oturum kaydında bu bilgi görünmüyor; effort "xhigh" olarak doğrulandı. 
**Riskler:** 
- D-009 cevaplanana kadar yeni çalışma ve inceleme oturumları yalnız senin sohbet oturumundan (otomatik moddayken) başlatılabilir. 
- Guard olağan hataları ve enjekte talimatları yakalar; sıra dışı kabuk yazımlarına karşı "en iyi çaba"dır, arkasında birleştirme-öncesi inceleme var.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
