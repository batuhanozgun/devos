# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-006` (Tek adım: sohbet oturumuna "devos için yeni bir kurulum koşusu başlat" yaz; benim oturum zincirim derinlik sınırında (8/8) ve yeni oturum açamıyorum). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 4 Ekim 2026, 10:47 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** Çalışan oturum yok; son oturum 4 Ekim 2026, 02:10 (Türkiye saati) itibarıyla işi bıraktı.

**Sıradaki işler:** `W-C00-12`, `W-C00-12.4` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor, ama bu oturum devredemedi: oturum zinciri platformun derinlik sınırına ulaştı (8/8) ve yeni oturum açamıyorum. Senden tek adım istiyorum (sayfanın ilk satırı, D-006): sohbet oturumuna "devos için yeni bir kurulum koşusu başlat" yaz ya da devos üzerinde kendin bir oturum başlat. Bir şey kaybolmadı. 
1. Dördüncü adımın (1c: koruma kuralları, CLAUDE.md, roller) yeni oturum gerektirmeyen kısmı ayrı bir dalda (PR #86) hazır; ana dala henüz alınmadı, çünkü bağımsız denetçi onayı gerekiyor. Yeni oturumlar artık üretilmiş bir görev özeti olmadan başlatılamayacak; her oturum açılışta bilinen hata kalıplarını görecek; rol tanımları yazıldı. Bunlar dal ana dala alınınca yürürlüğe girer. 
2. Önceki denetçinin bulduğu açık (son alt adımın kendini onaylı göstermesi) kodda kapatıldı; test önce eski kodda başarısız, yenisinde başarılı. Bir eleştirmen okuması 13 bulgu verdi; üçü düzeltildi, gerisi sıradaki oturuma yazıldı. 
3. Aynı kontrol yolu beş kez sıkılaştırıldı; tasarım kuralı bu durumda bir çerçeve incelemesi istiyor. Sıradaki oturum bunu denetçiden önce yapacak. 
4. Sorduğun model ve efor konusu: model her oturum için açıkça sabit; efor için henüz bir yapı yok. Sıradaki oturum önce ölçecek, karar noktası yeniden tasarımın son incelemesine yazıldı. 
**Riskler:** 
- Zincir yeniden başlasa da her devir ve her denetçi bir seviye ekliyor; bu sınır yine dolacak. Bunun kalıcı çözümü yeniden tasarımın bir parçası olarak ele alınacak. 
- Bekçi henüz kurulmadı; bir oturum ölürse bunu "Son güncelleme" saatinin eskimesinden görürsün.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
