# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 20:18 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı kontrol etti; kullanım sınırı yenilenene kadar yeni oturum açılmıyor

**Şu an:** Çalışma düzenimin bütüncül yeniden tasarımı (W-C00-12) başlıyor. Ayrı bir çalışma oturumu yapıyor; yol gösterici dosyası `briefs/w-c00-12/RUN_BRIEF.md`. C00'ın diğer işleri ve otomatik başlatma, tasarım bağımsız olarak denetlenene kadar kapalı. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede.

**En son yapılanlar**
1. Sen hiçbir şey yazmadan iş devam etti: zamanlanmış görev dağıtıcı oturumu uyandırdı, dağıtıcı yeni bir çalışma oturumu açtı, o oturum da kayıtları `main`'e aldı (T-A2r, geçti; bir kez gözlendi).
2. Çalışma düzeni belgesi (`plan/Builder_Operating_Model.md`) bir oturumun kendi kararıyla "bağlayıcı" işaretlendi; bağımsız olarak kabul edilmedi. Yerini bütüncül yeniden tasarım alacak. Belgenin ilk satırında hâlâ "bağlayıcı" yazıyor; bu çelişki bilerek yeniden tasarıma bırakıldı (`plan/ledger.md`, OI-011 madde 22).
3. Küçük bir eksik bulundu: dağıtıcının açtığı oturumların kimlikleri `main`'e yazılamıyor. Etkisi şimdilik düşük; düzeltme bir sonraki çalışmada bağımsız incelemeyle gelecek.

**Sırada:** Önce kurulumun bütünü için neyin hazır olması gerektiği baştan sona çıkarılacak; çalışma düzeni buna göre tek parça halinde yeniden tasarlanıp bağımsız olarak denetlenecek. Ondan sonra C00'ın ağır işleri (çeviri, bağımsız plan incelemesi, karşı tasarım, ECC karşılaştırması) başlayacak.

**Senden beklenen:** Acil bir şey yok. İki karar [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda duruyor: kullanım politikası (D-002) ve bağlantı engelinin kalan riski (D-003). İkisi de işi durdurmuyor; cevap gelene kadar önerdiğim varsayılanlar uygulanıyor.

**Kullanım:** Haftalık sınır 3 Ekim 20:00'de yenilendi; şu an "izinli" düzeyde.

**Bilmen gereken riskler**
- Bağımsız denetim ortamı henüz yok; önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Otomatik izin denetçisi aynı işlemde bazen farklı karar veriyor; bir reddedişte kurucu durur, başka yoldan zorlamaz. Bu yüzden gözetimsiz devam şimdilik "bir kez gözlendi" düzeyinde.
