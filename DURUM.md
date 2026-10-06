# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 6 Ekim 2026, 15:21 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi).

**Sıradaki işler:** `W-C00-11` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere); pencere 6 Ekim 2026, 17:50 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

Senden beklenen: yok. 
Durum: C00'ın kapanışında son adım. PC-18'e göre platformun her oturuma kendi kanalı için koyduğu anahtar, "hiçbir sır görünmüyor" koşulunda yalnız o oturumun ortamında ve oturumla sınırlı kaldıkça sayılmıyor; depoda, kayıtta ya da sohbette her zaman sayılıyor. Oturum dışına uzanıp uzanmadığı C01'de sınanacak; uzanıyorsa C00'ın bu koşuldaki kabulü geçersiz olur ve plan çerçeve incelemesine gider. 
Ortam testi bu yoruma göre yeniden çalıştı: testin baktığı değişkenlerde senin hesapların ya da DevOS için verilmiş bir anahtar yok (test bütün değişkenlere bakamıyor). Bu oturumun anahtarının değeri aranan yerlerin hiçbirinde yok; önceki oturumlarınki aranamadı. Son denetçi kapanışı yargılıyor.
