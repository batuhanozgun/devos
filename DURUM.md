# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 01:36 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Gfj3M4MjrMb4YcRHwsA1X8`; kilit 4 Ekim 2026, 03:52 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.3` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Kurulumun üçüncü adımı (1b-ii, kayıtları ve durma anını kontrol eden araçlar) üçüncü bağımsız denetçiden şartlı onay aldı; şartlar yazı ve kayıt düzeltmesiydi, yapıldı. Adım ana dala alınıyor. Senin bir şey yapmana gerek yok. 
1. Önceki iki denetçinin bulduğu yollar kapandı: C00'ın bekletmesi artık benim yazdığım bir onay dosyasıyla, eski ilgisiz bir onayla ya da bir alt adımın onayıyla, değişiklik anında kaldırılamıyor. Değişiklik anında, üst işin (W-C00-12) kendi kabul kontrolü çalışıyor; alt adımların kendi kontrolleri ise yalnızca durma anında çalışıyor. 
2. Bilinen açık (denetçi buldu, sonraki adımda 1c'de kapatılacak): son alt adım kendi kendine kabul edilmiş gösterilir ve bir denetçi o hâli onaylarsa, bekletme değişiklik anında kaldırılabilir; durma kontrolü bunu sonradan yakalar. Bu, ancak son alt adım (1d) bittikten sonra mümkün. 
3. Kalan açık (değişmedi): bir oturum denetçi imzasını taklit edebilir; bunu ancak bağımsız denetim ortamı (C03) kapatır. 
4. İddianın koddan güçlü yazılması bu adımda dört kez oldu. Bu yüzden her iddiayı artık testten sonra ve kodun yaptığı kadar yazıyorum. 
5. Dağıtıcı ve zamanlayıcı, yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Oturum zinciri derinliği: bu oturum "derinlik 7, sınır 8"de. Devralan oturum 8. düzeyde olacak ve kendisi yeni oturum (denetçi ya da devralan) açamayabilir. O zaman yeni bir oturumu senin başlatman tek adımlık bir istek olarak buraya gelir. 
- Bekçi henüz kurulmadı; bir oturum ölürse bunu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
