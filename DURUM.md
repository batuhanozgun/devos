# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 12:13 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı kontrol etti; kullanım sınırı yenilenene kadar yeni oturum açılmıyor

**Şu an:** Kurulum bilerek bekletiliyor. Çalışma düzenimin bütüncül olarak yeniden tasarlanması gerekiyor; o bitmeden ağır işler başlamayacak. Otomatik başlatma kapatıldı. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede.

**En son yapılanlar**
1. Sen hiçbir şey yazmadan iş devam etti: zamanlanmış görev dağıtıcı oturumu uyandırdı, dağıtıcı yeni bir çalışma oturumu açtı, o oturum da kayıtları `main`'e aldı (T-A2r, geçti; bir kez gözlendi).
2. Çalışma düzeni belgesi (`plan/Builder_Operating_Model.md`) bir oturumun kendi kararıyla "bağlayıcı" işaretlendi; bağımsız olarak kabul edilmedi. Yerini bütüncül yeniden tasarım alacak. Belgenin ilk satırında hâlâ "bağlayıcı" yazıyor; bu çelişki bilerek yeniden tasarıma bırakıldı (`plan/ledger.md`, OI-011 madde 22).
3. Küçük bir eksik bulundu: dağıtıcının açtığı oturumların kimlikleri `main`'e yazılamıyor. Etkisi şimdilik düşük; düzeltme bir sonraki çalışmada bağımsız incelemeyle gelecek.

**Sırada:** Önce kurulumun bütünü için neyin hazır olması gerektiği baştan sona çıkarılacak; çalışma düzeni buna göre tek parça halinde yeniden tasarlanıp bağımsız olarak denetlenecek. Ondan sonra C00'ın ağır işleri (çeviri, bağımsız plan incelemesi, karşı tasarım, ECC karşılaştırması) başlayacak.

**Senden beklenen:** Acil bir şey yok. İki karar [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda duruyor: kullanım politikası (D-002) ve bağlantı engelinin kalan riski (D-003). İkisi de işi durdurmuyor; cevap gelene kadar önerdiğim varsayılanlar uygulanıyor.

**Kullanım:** Haftalık sınır "uyarı" düzeyinde; 3 Ekim 20:00'de yenileniyor. Yapılabilecek hafif iş kalmadığı için o zamana kadar yeni çalışma oturumu açılmıyor.

**Bilmen gereken riskler**
- Bağımsız denetim ortamı henüz yok; önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Otomatik izin denetçisi aynı işlemde bazen farklı karar veriyor; bir reddedişte kurucu durur, başka yoldan zorlamaz. Bu yüzden gözetimsiz devam şimdilik "bir kez gözlendi" düzeyinde.
