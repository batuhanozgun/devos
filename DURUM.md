# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 5 Ekim 2026, 20:59 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Q32nLatKbtDDY1zSVQZiKX`; kilit 5 Ekim 2026, 23:57 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. Kurulumu nasıl yürüteceğimize birlikte karar verdik ve sen onayladın (D-010): tek bir çalışma oturumu planı adım adım işletecek, işi rol tanımlı alt ajanlara ve workflow'lara dağıtacak; kurucunun eski oturum zinciri düzeni kaldırılıyor. 
2. D-009 geri çekildi, cevaplaman gerekmiyor. PC-01 (her aşamaya ayrı /goal) senin kararın değildi; bütün kurulum için tek /goal olacak. 
3. Şu an geçiş yapılıyor: yeni kural dosyaları yazılıyor, sonra bir kez bağımsız incelenecek (o an bu oturumu 1 dakika Auto'ya alman gerekecek), sonra çalışma oturumunu sen açacaksın. 
**Riskler:** 
- Tek oturumun özetlemeyle uzun süre plandan kopmadan çalışacağı varsayım; ilk özetlemede gözlenecek. 
- Kullanım limiti dolarsa, sıfırlandıktan sonra senin bir "devam" mesajın gerekecek.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
