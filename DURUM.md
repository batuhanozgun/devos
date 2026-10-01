# DevOS kurulum durumu

**Son güncelleme:** 1 Ekim 2026, 23:48 (Türkiye saati) · **Son nabız:** 1 Ekim 2026, 23:58 (Türkiye saati): dağıtıcı yeni bir çalışma oturumu başlattı

**Aşama:** C00 (başlangıç kontrolleri). Şu an kurucunun kendi çalışma düzeni kuruluyor ve sınanıyor (W-C00-05).

**En son yapılanlar**
1. Kurucunun çalışma düzeni tasarlandı. Bağımsız bir karşı tasarımla karşılaştırıldı ve düzeltildi.
2. Hesaptaki connector'lara (e-posta, takvim, dosya) karşı teknik bir engel kuruluyor. Beş bağımsız inceleme turunda açıklar bulundu. Beşinci turun en önemli açığı (alt ajanların ayrı bir bulut oturumunda çalıştırılması) kapatıldı ve altıncı, dar inceleme bunu doğruladı (PASS). Engel bütün araçlara bakacak ve yalnız açıkça izin verilenleri geçirecek. Görevi kazayı ve dışarıdan sızan talimatı durdurmak; kurucunun kendisi isterse onu değiştirebilir. Bu kalan riski sana bir karar olarak getireceğim. Engel bu değişiklik `main`'e girince devreye giriyor.
3. Planda teknik onayın senden alınıp bağımsız denetime verildiği değişiklik (PC-05) yazıldı.

**Sırada**
- Çalışma düzeni `main`'e alındı. Yeni bir oturum, yalnız "devam et" denince kaldığı yeri doğru buldu (ikinci denemede geçti).
- Nabız denemesi (sen yazmadan işin sürmesi) ilk seferde geçmedi: zamanlanmış görev çalıştı, ama dağıtıcı oturum gelen mesajı okuyamadı (kendi engelim bu aracı kapatıyordu) ve kaydını birleştiremedi. Düzeltme bağımsız incelemeden geçti ve `main`'e alındı. Değişen: dağıtıcı mesajları okuyabiliyor, kendi kaydını artık birleştirmiyor (bir sonraki çalışma oturumu, kapsamını denetleyip birleştiriyor). Bu yüzden çalışan oturum yokken buradaki "Son nabız" satırı geride kalabilir. Deneme şimdi tekrarlanıyor: ilk kurucu oturum işi bıraktı; dağıtıcının sen hiçbir şey yazmadan yeni bir çalışma oturumu açması bekleniyor. Açılırsa iş orada sürecek.
- Ardından C00'ın ağır işleri: çeviri, bağımsız plan incelemesi, karşı tasarım. Bunlar haftalık kullanım sınırı yenilendikten sonra (3 Ekim 20:00).

**Senden beklenen:** İki karar, [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda: kullanım politikası (D-002) ve bağlantı engelinin kalan riski (D-003). İkisi de işi durdurmuyor; cevap gelene kadar önerdiğim varsayılanlar uygulanıyor.

**Kullanım:** Haftalık sınır "uyarı" düzeyinde. Sınır 3 Ekim 20:00'de yenileniyor; o zamana kadar yalnız hafif işler yapılıyor.

**Bilmen gereken riskler**
- Kurulumun bu ilk döneminde bağımsız denetim ortamı henüz yok. Önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Kütüphane deposuna yazmama kuralını hâlâ yalnız kurucunun kendisi uyguluyor (bkz. defter L-003).
