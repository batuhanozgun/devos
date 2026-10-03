# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 3 Ekim 2026, 23:48 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01CmCKBkyHynQ27CwqkiviC6`; kilit 4 Ekim 2026, 02:18 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.3` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Bu oturum kurulumun üçüncü adımını (1b-ii) kurdu: kayıtları ve durma anını kontrol eden araçlar. Bağımsız denetçi oturumunun onayı bekleniyor; onay gelmeden ana dala alınmayacak. Senin bir şey yapmana gerek yok. 
1. Yeni araç `tools/check_records.py` on ayrı kontrol yapıyor. Bazıları: her kayıt değişikliğinin günlükte gerekçesi var mı; saatler gelecekte mi; kanıt dosyaları gerçekten var mı; bir iş kendi üreticisi tarafından "kabul" edilmiş mi. 
2. Durma kontrolü (`tools/builder_check.sh`) artık bu kontrolleri, senin issue'daki cevaplarını ve gizli isim sızıntısını da denetliyor. Aynı tür hata iki kez çıkarsa oturumu devretmeye zorluyor. 
3. 25 testin hepsi geçti. Testler yalnızca geçici kopyalarda çalıştı; gerçek kayıtlara dokunmadı. 
4. C00'ın bekletmesi artık bir işin "kabul edildi" diye elle işaretlenmesiyle kaldırılamıyor; bunun için bağımsız bir denetçi kararı gerekiyor. 
5. Dağıtıcı ve zamanlayıcı, yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Bekçi (takılan oturumu fark eden bağımsız kontrol) henüz kurulmadı. Bir oturum şimdi ölürse onu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün. 
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar. 
- Oturum zincirinin bir derinlik sınırı olabilir: sistem bu oturum için "derinlik 6, sınır 8" gösteriyor. Doğruysa yalnızca birkaç devir daha mümkün. Bunu bir sonraki adımda (1c) ölçüp tasarlayacağım; gerekirse yeni bir oturumu senin başlatman tek adımlık bir istek olarak gelir. 
- Yeniden tasarımın 1c adımı koruma kurallarımın (hook) değiştirilmesini gerektiriyor. Güvenlik denetimi bunu reddederse, kuralları nasıl değiştirebileceğim konusu o zaman sana karar olarak gelir.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
