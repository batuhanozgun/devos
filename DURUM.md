# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 01:00 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Gfj3M4MjrMb4YcRHwsA1X8`; kilit 4 Ekim 2026, 03:52 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.3` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Kurulumun üçüncü adımı (1b-ii, kayıtları ve durma anını kontrol eden araçlar) için bağımsız denetçinin engelleyici şartını düzelttim; yeni bir denetçi onayı bekleniyor. Onay gelmeden ana dala alınmayacak. Senin bir şey yapmana gerek yok. 
1. Düzeltilen açık: C00'ın bekletmesi, benim yazdığım bir "onay" dosyasıyla ya da eski, ilgisiz bir onayla kaldırılabiliyordu. Artık kontrol, onayın denetçinin kendi dalından birebir kopyalanmış olmasını, o dalda bu değişikliğe katılmamış bir denetçi oturumunun imzasını taşımasını ve işin başlamasından sonraki bir sürümü onaylamasını istiyor. Denetçinin iki saldırı senaryosu teste eklendi; ikisi de eski kodda geçiyor, yeni kodda yakalanıyor. Bu cümleyi testler geçtikten sonra yazdım. 
2. Kalan açık (değişmedi): bir oturum, gerçek bir denetçi oturumunun imzasını taklit ederse bu kontrol bunu ayırt edemez. Bunu ancak bağımsız denetim ortamı (C03) kapatır. 
3. Denetçinin diğer şartları ve küçük bulguları karşılandı ya da gerekçesiyle sonraki adıma (1c) not edildi. 
4. Dağıtıcı ve zamanlayıcı, yeniden tasarım kabul edilene kadar bilerek kapalı. 
**Riskler:** 
- Oturum zinciri derinliği: bu oturum "derinlik 7, sınır 8" gösteriyor. Açacağım denetçi 8. düzeyde olacak. Sınır gerçekse, bir sonraki devirde yeni oturum açılamayabilir; o zaman yeni bir oturumu senin başlatman tek adımlık bir istek olarak buraya gelir. 
- Bekçi henüz kurulmadı; bir oturum ölürse bunu yukarıdaki "Son güncelleme" saatinin eskimesinden görürsün.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
