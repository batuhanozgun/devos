# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 3 Ekim 2026, 23:43 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01CmCKBkyHynQ27CwqkiviC6`; kilit 4 Ekim 2026, 02:18 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.3` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Kurulumun ikinci adımı (1b-i) bitti, bağımsız denetçi oturumu şartlı onay verdi, iki şartı da karşılandı ve ana dala alındı. Bu oturum işi yeni bir oturuma devrediyor; sıradaki adım 1b-ii (kayıtları kontrol eden araçlar). Senin bir şey yapmana gerek yok. 
1. İş listesi, kararlar ve açık maddeler tek tek dosyalara taşındı: her iş `plan/work/` altında kendi dosyasında, her karar `plan/decisions/` altında. Kabul metinleri harfi harfine aynı kaldı; bunu hem bir test hem denetçi ayrıca kontrol etti. 
2. "Sıradaki iş" listesi artık elle yazılmıyor; `tools/records.py` adlı bir araç onu kayıtlardan üretiyor. Bu sayfa (`DURUM.md`) da aynı araçla üretiliyor. 
3. C00'ın ağır işleri (çeviri, incelemeler) W-C00-12 kabul edilmeden "başlatılabilir" görünmüyor. Araç bunu gösteriyor; kuralın atlanmasını engelleyen kontroller bir sonraki adımda (1b-ii) geliyor. 
4. Dağıtıcı ve zamanlayıcı yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Bekçi (takılan oturumu fark eden bağımsız kontrol) henüz kurulmadı. Bir oturum şimdi ölürse onu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün. 
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar. 
- Bu adımın geri alma dalı `claude/revert-w12-1b-i`, ana dala almadan önce GitHub'a gönderildi. Geri alma kabul metinlerini de sildiği için, bir sonraki adımdan sonra o da denetçi onayı ister. 
- Yeniden tasarımın 1c adımı koruma kurallarımın (hook) değiştirilmesini gerektiriyor. Güvenlik denetimi bunu reddederse, kuralları nasıl değiştirebileceğim konusu o zaman sana karar olarak gelir.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
