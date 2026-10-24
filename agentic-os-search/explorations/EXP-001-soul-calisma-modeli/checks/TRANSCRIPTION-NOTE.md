# Görünür diyalog aktarımı — sadakat notu

## Kapsam

19 kullanıcı mesajı ve 18 substantive assistant cevabı ayrı kimliklerle korunur. İlk uygulama sorusu U001, arşivi başlatma yetkisi U019'dur. Bu çalıştırmadaki progress yorumları, tool transport kayıtları, gizli bağlam ve geçmiş diğer proje konuşmaları kaynak kesimine dahil değildir.

Aktarım, modele görünür mesajlar üzerinden assistant tarafından yapılmıştır. Ham platform export'una karşı bağımsız mekanik diff yoktur. Bu yüzden “tam kapsamlı görünür-metin aktarımı” ile “byte-perfect platform export” aynı iddia değildir.

## Bilinen normalizasyonlar

- Assistant kaynaklarında `# S...` başlığı ve tarihsel statü notu eklendi; bunlar özgün cevabın parçası değil.
- Kod bloklarının geçici arayüz `id` değerleri çıkarıldı; kod/metin içeriği korunmaya çalışıldı.
- Markdown satır boşlukları normalize edilebilir.
- Routing blokları ve sandbox/filecite adresleri tarihsel olarak korundu; yeni etkin yönerge veya bugün çalışacak bağlantı değildir.
- U006 görseli ayrı dosyada korunur; metin içinde arşiv notu ile referans verilir.

## Düzeltilen aktarım hatası

İlk USER-MESSAGES aktarımında U006 içinde kaynakta `üretilmesine` olan sözcük `üretiltilmesine` yazılmıştır. Bu, kullanıcının değil aktarımın hatasıydı. Kaynak ifadeye uygun biçime bu arşivleme turunda geri getirildi; kullanıcının diğer yazımı veya fikri değiştirilmedi. Bu düzeltme, diğer metnin platform export'uyla byte-eşit doğrulandığını göstermez.

## Kaynak kalitesi

Mesajların konuşmacı/sıra/ana içerik kapsamı denetlenebilir; özgün eserler ayrıca hash'lenmiştir. Hash, yalnız kendisine uygulanan aktarım dosyasının bütünlüğünü gösterir; dışarıdaki asıl konuşmaya uygunluğunu tek başına doğrulamaz. Kesin kelimesi kelimesine kullanım gerekirse platform export'uyla karşılaştırma yapılmalıdır.
