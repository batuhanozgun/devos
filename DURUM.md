# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 02:08 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_011NtZnNGjojkTcmuzMRLtvL`; kilit 4 Ekim 2026, 04:39 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 4 Ekim 2026, 04:10 (Türkiye saati) tarihinde yenileniyor.

**Kurulu uyandırmalar:** yok

**Şu an**

Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Dördüncü adımın (1c: koruma kuralları, CLAUDE.md, roller) yeni oturum gerektirmeyen kısmı ayrı bir dalda (PR #86) hazır; ana dala henüz alınmadı, çünkü bağımsız denetçi onayı gerekiyor. Senin bir şey yapmana gerek yok. 
1. Dalda hazır olanlar: yeni bir oturum artık üretilmiş bir görev özeti olmadan başlatılamıyor; zamanlanmış hatırlatmalar sahiplik listesine kendiliğinden yazılıyor; her oturum açılışta bilinen hata kalıplarını görüyor; ortak taban kuralları CLAUDE.md'den yükleniyor; rol tanımları yazıldı. Bunlar dal ana dala alınınca yürürlüğe girer. 
2. Önceki denetçinin bulduğu açık (son alt adımın kendi kendini onaylı göstermesi) kodda kapatıldı; bunu gösteren test önce eski kodda başarısız, sonra yenisinde başarılı oldu. 
3. Yeni bir kontrol, önceki bir denetçinin rapor saatindeki 4 dakikalık bir hatayı geriye dönük yakaladı; zaten kayıtlıydı, yeniden işaretlendi. 
4. Kalanlar: canlı testler, eleştirmen okuması ve bağımsız denetçi. Bunlar yeni oturum açmayı gerektiriyor; onları devralan oturum yapacak. 
**Riskler:** 
- Oturum zinciri derinlik sınırında (8/8). Devralan oturumu açamazsam, bu sayfanın ilk satırında senden tek adımlık bir istek olacak. 
- Bekçi henüz kurulmadı; bir oturum ölürse bunu "Son güncelleme" saatinin eskimesinden görürsün.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
