# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 01:19 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Gfj3M4MjrMb4YcRHwsA1X8`; kilit 4 Ekim 2026, 03:52 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.3` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Kurulumun üçüncü adımı (1b-ii, kayıtları ve durma anını kontrol eden araçlar) henüz ana dala alınmadı: ikinci denetçi de C00'ın bekletmesini kaldırabilecek bir yol buldu ve onay vermedi. Düzelttim; üçüncü bir denetçi onayı gerekiyor. Senin bir şey yapmana gerek yok. 
1. Bulunan yol: bir alt adımın gerçek onayı, üst işin (W-C00-12) onayı gibi kullanılabiliyordu. Artık kontrol, durma anında yaptığı denetimin tamamını değişiklik anında da çalıştırıyor: üst işin kendi bütünlük onayı ve bütün alt adımların kabul edilmiş olması gerekiyor. Ben de iki benzer yol daha buldum ve kapattım. Her yol bir testle gösterildi: eski kodda geçiyor, yeni kodda yakalanıyor. Bu cümleyi testler geçtikten sonra yazdım. 
2. Kalan açık (değişmedi, şimdi daha doğru tarifle): bir oturum, denetçi imzasını taklit edebilir ve sahte bir oturum kimliğini ayrı bir kayıt değişikliğiyle listeye ekleyebilir. Bunu ancak bağımsız denetim ortamı (C03) kapatır. 
3. Aynı türden hata (iddianın koddan güçlü yazılması) bu adımda üç kez oldu. Bu yüzden onayı istemeden önce kendi düzeltmeme kendim saldırdım. 
4. Dağıtıcı ve zamanlayıcı, yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Oturum zinciri derinliği: bu oturum "derinlik 7, sınır 8"de. Bir sonraki oturum 8. düzeyde olacak ve kendisi yeni oturum (denetçi ya da devralan) açamayabilir. O zaman yeni bir oturumu senin başlatman tek adımlık bir istek olarak buraya gelir. 
- Bekçi henüz kurulmadı; bir oturum ölürse bunu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
