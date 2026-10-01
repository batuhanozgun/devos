# DevOS kurulum durumu

**Son güncelleme:** 1 Ekim 2026, 21:52 (Türkiye saati) · **Son nabız:** henüz yok (nabız düzeni kuruluyor)

**Aşama:** C00 (başlangıç kontrolleri). Şu an kurucunun kendi çalışma düzeni kuruluyor ve sınanıyor (W-C00-05).

**En son yapılanlar**
1. Kurucunun çalışma düzeni tasarlandı. Bağımsız bir karşı tasarımla karşılaştırıldı ve düzeltildi.
2. Hesaptaki connector'lara (e-posta, takvim, dosya) karşı teknik bir engel kuruldu. İki bağımsız inceleme açıklar buldu, ikisi de düzeltildi. Engel artık benim yeni oturum açmamı, başka oturumlara mesaj göndermemi ve GitHub'da `devos` dışına yazmamı da denetliyor. Kuralların çoğu birim testiyle sınandı, biri canlı olarak sınandı. Engelin kapsamadığı yollar yazılı (örneğin kütüphane deposuna doğrudan `git push`).
3. Planda teknik onayın senden alınıp bağımsız denetime verildiği değişiklik (PC-05) yazıldı.

**Sırada**
- Çalışma düzeninin bağımsız incelemesi ve son iki deneme (yeni oturumun kaldığı yerden devam etmesi; nabız oturumu).
- Düzeltmelerin üçüncü bir bağımsız incelemesi.
- Ardından C00'ın ağır işleri: çeviri, bağımsız plan incelemesi, karşı tasarım. Bunlar haftalık kullanım sınırı yenilendikten sonra (3 Ekim 20:00).

**Senden beklenen:** Şu an yok. Bekleyen bir karar ya da iş olduğunda "Batu'dan beklenenler" başlıklı GitHub issue'sunda, tek seferde ve adım adım gelecek.

**Kullanım:** Haftalık sınır "uyarı" düzeyinde. Sınır 3 Ekim 20:00'de yenileniyor; o zamana kadar yalnız hafif işler yapılıyor.

**Bilmen gereken riskler**
- Kurulumun bu ilk döneminde bağımsız denetim ortamı henüz yok. Önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Kütüphane deposuna yazmama kuralını hâlâ yalnız kurucunun kendisi uyguluyor (bkz. defter L-003).
