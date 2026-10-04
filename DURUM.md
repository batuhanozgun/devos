# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 15:15 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** Çalışan oturum yok; son oturum 4 Ekim 2026, 15:15 (Türkiye saati) itibarıyla işi bıraktı.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 15:20 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. Bu koşu açılışta durdu: otomatik denetim, önceki koşuların kayıtlarını okumamı "kendi kendini onaylama" gerekçesiyle engelledi. Kurala göre bu engeli başka bir yoldan aşmaya çalışmadım; bu bir bilgi notudur, senden bir şey istemiyorum. 
2. Kilidi aldım ve temiz durduğum için bıraktım; böylece sonraki koşu beklemeden başlayabilir. 
3. 1c işleri PR #86'da duruyor, kaybolmadı. Sonucu farklı tek tasarım denemesi hâlâ kullanılmadı. 
**Riskler:** 
- Şu an çalışan bir koşu yok; otomatik başlatıcılar bilerek kapalı. 
- Aynı engel tekrar ederse 1c bekler; bunu burada bilgi olarak yazarım.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
