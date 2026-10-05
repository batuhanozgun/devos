# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-009` (D-008 altında oturum başlatma: tek görevi yeni çalışma ve inceleme oturumlarını başlatmak olan bir oturum otomatik modda çalışabilir mi?). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 5 Ekim 2026, 13:39 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** Çalışan oturum yok; son oturum 5 Ekim 2026, 13:39 (Türkiye saati) itibarıyla işi bıraktı.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 5 Ekim 2026, 14:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Senden bir karar bekleniyor: **D-009** (issue #6'da). 
1. Accept edits modundaki oturumlar ne yeni oturum açabiliyor ne de ileri bir saate kendine hatırlatma kurabiliyor: platform "onay gerekiyor" diyerek reddediyor. D-008 olduğu gibi kalırsa sistem kendi kendine devam edemez ve bağımsız inceleme başlatılamaz. 
2. Bu oturum yeni oturum gerektirmeyen işi bitirdi: tranche 1c (W-C00-12.4, PR #86) yeni guard'ın üzerine taşındı ve testleri geçti; taşımayı gözden geçiren denetleyicinin bulduğu, eş zamanlı çağrılarda ortaya çıkan bir açık da kapatıldı. 1c'nin geri kalanı (canlı testler, bağımsız inceleme) yeni oturum gerektiriyor. 
3. Oturum durdu ve kilidi bıraktı. D-009 cevaplanana kadar yeni bir çalışma ancak otomatik moddaki bir oturumdan başlatılabilir. 
**Açık uç:** Ayrı "ultracode" bayrağı hâlâ doğrulanamadı; effort "xhigh" olarak doğrulandı. 
**Riskler:** 
- D-009 cevaplanana kadar iş bekler; 4 saat sonraki hatırlatmayı kuracak bir oturum da yok. 
- Guard olağan hataları ve enjekte talimatları yakalar; sıra dışı kabuk yazımlarına karşı "en iyi çaba"dır, arkasında birleştirme-öncesi inceleme var.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
