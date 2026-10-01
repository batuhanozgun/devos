# DevOS kurulum durumu

**Son güncelleme:** 1 Ekim 2026, 22:16 (Türkiye saati) · **Son nabız:** henüz yok (nabız düzeni kuruluyor)

**Aşama:** C00 (başlangıç kontrolleri). Şu an kurucunun kendi çalışma düzeni kuruluyor ve sınanıyor (W-C00-05).

**En son yapılanlar**
1. Kurucunun çalışma düzeni tasarlandı. Bağımsız bir karşı tasarımla karşılaştırıldı ve düzeltildi.
2. Hesaptaki connector'lara (e-posta, takvim, dosya) karşı teknik bir engel kuruluyor. Dört bağımsız inceleme turunda açıklar bulundu. Son düzeltmeler yazıldı ve yeniden incelemede. Engel bütün araçlara bakacak ve yalnız açıkça izin verilenleri geçirecek. Görevi kazayı ve dışarıdan sızan talimatı durdurmak; kurucunun kendisi isterse onu değiştirebilir. Bu kalan riski sana bir karar olarak getireceğim. Engel bu değişiklik `main`'e girince devreye giriyor.
3. Planda teknik onayın senden alınıp bağımsız denetime verildiği değişiklik (PC-05) yazıldı.

**Sırada**
- Çalışma düzeninin bağımsız incelemesi ve son iki deneme (yeni oturumun kaldığı yerden devam etmesi; nabız oturumu).
- Düzeltmelerin beşinci, dar kapsamlı bir incelemesi; ardından PR'ın `main`'e alınması ve son iki deneme.
- Ardından C00'ın ağır işleri: çeviri, bağımsız plan incelemesi, karşı tasarım. Bunlar haftalık kullanım sınırı yenilendikten sonra (3 Ekim 20:00).

**Senden beklenen:** Şu an yok. Bekleyen bir karar ya da iş olduğunda "Batu'dan beklenenler" başlıklı GitHub issue'sunda, tek seferde ve adım adım gelecek.

**Kullanım:** Haftalık sınır "uyarı" düzeyinde. Sınır 3 Ekim 20:00'de yenileniyor; o zamana kadar yalnız hafif işler yapılıyor.

**Bilmen gereken riskler**
- Kurulumun bu ilk döneminde bağımsız denetim ortamı henüz yok. Önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Kütüphane deposuna yazmama kuralını hâlâ yalnız kurucunun kendisi uyguluyor (bkz. defter L-003).
