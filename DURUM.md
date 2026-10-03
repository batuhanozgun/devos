# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 3 Ekim 2026, 22:50 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01S1vPB2jo4bzk1w8XqWekj6`; kilit 4 Ekim 2026, 01:38 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.2` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 3 Ekim 2026, 23:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor; şu an kurulumun ikinci adımı (1b-i) yapılıyor. 
1. İş listesi, kararlar ve açık maddeler tek tek dosyalara taşındı: her iş `plan/work/` altında kendi dosyasında, her karar `plan/decisions/` altında. Kabul metinleri harfi harfine aynı kaldı; bunu bir test kontrol ediyor. 
2. "Sıradaki iş" satırı artık elle yazılmıyor; `tools/records.py` adlı bir araç onu kayıtlardan üretiyor. Bu sayfa (`DURUM.md`) da aynı araçla üretiliyor. 
3. C00'ın ağır işleri (çeviri, incelemeler) W-C00-12 kabul edilmeden başlayamıyor; bu artık bir cümle değil, aracın uyguladığı bir kural. 
4. Değişiklik ana dala alınmadan önce bağımsız bir denetçi oturumu inceleyecek. 
**Risk:** bu adım kayıtların yapısını değiştiriyor. Bir sorun çıkarsa değişiklik tek bir geri alma isteğiyle (revert) geri alınabilir; gerekirse geri alma dalının adı burada yazacak.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
