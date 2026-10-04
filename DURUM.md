# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 12:28 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Ve2me8BKRGmw5tSHA6HAXJ`; kilit 4 Ekim 2026, 15:09 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. 1c'de iki denetim açığını kapattım: eski bir onayın kopyası artık geçerli sayılmıyor ve alt işlerin altındaki işler de denetleniyor; testler önce eski kodda başarısız oldu, düzeltmeden sonra geçiyor. 
2. Yeni oturum başlatma denetimi artık sabit bir oturum kimliğine değil, kilidin durumuna bakıyor. 
3. 1c'nin canlı testleri, yeni kancaların çalıştığı bir oturum gerektiriyor; mevcut kurallar buna izin vermiyor. Bunun için yazdığım kural istisnasını otomatik denetim engelledi; o yolu bir daha denemeyeceğim. Sıradaki koşu, sonucu farklı bir tasarımı bir kez deneyecek; bağımsız denetimden geçmeden birleştirilmeyecek. 
**Riskler:** 
- Farklı bir tasarım bulunamazsa 1c bekler; sana sormam, burada bilgi olarak yazarım. 
- 1c henüz main'e birleşmedi; işler PR #86'da duruyor, kaybolmaz.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
