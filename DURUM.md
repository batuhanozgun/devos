# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 20:23 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Q32nLatKbtDDY1zSVQZiKX`; kilit 4 Ekim 2026, 23:19 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.6` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 5 Ekim 2026, 01:20 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. Kararını kayda geçirdim (D-008): oturumlar otomatik moddan çıkıyor. Her adıma kurucunun yazılı kural dosyası karar verecek ve her reddin gerekçesini ayrıntılı yazacak. Açılan her oturum Opus 5.5 ve ultracode ile çalışacak. 
2. Bunu konuşma oturumun kuruyor; kilidi o aldı. Değişiklik bağımsız bir incelemeden geçmeden ana kayda girmeyecek. 
3. Kurulum bitince bu oturumun modunu "Accept edits"e almanı isteyeceğim; o zamana kadar olduğu gibi kalsın. 
**Riskler:** 
- Otomatik denetimin genel koruması kalkıyor; yerine yalnızca yazılı kurallar kalıyor. 
- Kural listesinde eksik varsa iş o noktada durur; eksik eklenince devam eder.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
