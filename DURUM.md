# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 00:52 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Gfj3M4MjrMb4YcRHwsA1X8`; kilit 4 Ekim 2026, 03:52 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.3`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Bu oturum kurulumun üçüncü adımını (1b-ii, kayıtları ve durma anını kontrol eden araçlar) kurdu ve 25 testin hepsi geçti. Bağımsız denetçi oturumu şartlı onay verdi, ama bir şartı engelleyici. Bu yüzden adım henüz ana dala alınmadı; yeni oturum düzeltip yeni bir denetçi onayı alacak. Senin bir şey yapmana gerek yok. 
1. Denetçinin bulduğu açık: C00'ın bekletmesini, kendi yazdığım bir "onay" dosyasıyla kaldırabiliyordum. Durma kontrolü bunu sonradan yakalıyordu, ama önceden engellemiyordu. Daha önce sana "artık kaldırılamıyor" yazmıştım; bu, kodun gerçekte yaptığından güçlü bir iddiaydı. Düzeltilmeden ana dala alınmayacak. 
2. Eleştirmen alt-oturumun 13 bulgusundan 12'si kapatıldı ve teste eklendi; biri gerekçesiyle reddedildi. 
3. Bu oturum bağlamının yaklaşık yarısını kullandığı için işi yeni bir oturuma devrediyor. 
4. Dağıtıcı ve zamanlayıcı, yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Bekçi (takılan oturumu fark eden bağımsız kontrol) henüz kurulmadı. Bir oturum şimdi ölürse onu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün. 
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar. 
- Oturum zincirinin bir derinlik sınırı olabilir: sistem bu oturum için "derinlik 6, sınır 8" gösteriyor. Doğruysa yalnızca birkaç devir daha mümkün. Bunu bir sonraki adımda (1c) ölçüp tasarlayacağım; gerekirse yeni bir oturumu senin başlatman tek adımlık bir istek olarak gelir. 
- Yeniden tasarımın 1c adımı koruma kurallarımın (hook) değiştirilmesini gerektiriyor. Güvenlik denetimi bunu reddederse, kuralları nasıl değiştirebileceğim konusu o zaman sana karar olarak gelir.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
