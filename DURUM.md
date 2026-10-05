# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 5 Ekim 2026, 13:03 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01XBdYJwHjvsouur4ayJJM5Z`; kilit 5 Ekim 2026, 15:31 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.4` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 5 Ekim 2026, 14:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. Yeni bir çalışma oturumu (`session_01XBdYJwHjvsouur4ayJJM5Z`) kilidi aldı ve C00'ın yeniden tasarımına (W-C00-12) devam ediyor. 
2. Önce izin modeli işinin (W-C00-12.6) resmî kabulü için bağımsız bir doğrulayıcı oturum açılıyor; bu, bu oturumdan yeni oturum açılabildiğini de sınıyor. 
3. Ardından tranche 1c (W-C00-12.4, PR #86) yeni guard'ın üzerine taşınıyor. 
**Açık uç:** Ayrı "ultracode" bayrağı hâlâ doğrulanamadı: oturum kaydında bu bilgi görünmüyor; effort "xhigh" olarak doğrulandı. 
**Riskler:** 
- Bir oturum, kendisinden daha geniş izinli bir alt oturum açamayabilir (doğrulanmadı); bu oturumdan ilk oturum açma denemesi kayda geçecek. 
- Guard olağan hataları ve enjekte talimatları yakalar; sıra dışı kabuk yazımlarına karşı "en iyi çaba"dır, arkasında birleştirme-öncesi inceleme var.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
