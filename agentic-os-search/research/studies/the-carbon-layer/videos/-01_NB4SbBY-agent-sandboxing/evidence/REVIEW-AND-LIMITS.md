# İkinci video — Karşı inceleme ve kapsam sınırları

**2026-09-16 / same-researcher source comparison.** Bağımsız inceleyici, güvenlik deneyi veya bütün ürünlerin conformance testi değildir. Başlangıç materyali [SOURCE](../SOURCE.md) içinde kimliklendirilmiştir.

## Kapsam denetimi

Anlatımın başlangıç probleminden son sınıra kadar bütün SRT metni okundu. RESEARCH'in haritası beş izolasyon yaklaşımı yanında onay yorgunluğu, child tree, dosya/ağ ilişkisi, varsayılanlar, araç exposure'ı, maliyet/ergonomi ve credential ile uzak zarar örneğini kapsar. Yalnız izolasyon tablosunu özetlemekle yetinilmedi. V8 heap sandbox ile isolate ayrımı ve kaynakta zaten bulunan uyarılar korunur.

20 seçilmiş kare, beş katman ve ortak dosya örneğinin görsellerini; seçim/matris/ilkeler ve dış API uyarısını içerir. Ara animasyonlar ve bütün konuşma sesi tam incelenmiş sayılmaz. V02 native altyazı olarak doğrulanmış değildir. W01'in yeniden çizilmiş web deck'i kaynak videonun yerine geçirilmedi.

## Uygulanan karşı okumalar

| Güçlü fakat desteklenmeyen sonuç | Yapılan kontrol | Korunan sonuç |
|---|---|---|
| Sandbox varsa modelin yanlış eylemi güvenlidir | Kaynağın 33:13–34:23 API karşı örneğine dönüldü | Yerel containment ile uzak servis yetkisi ayrı. |
| L1–L5 bütün güvenliği ve maliyeti tek sıraya dizer | Seçim anlatımı, 08:40 ve 29:10 slaytları birlikte okundu | Koşullu mekanizma haritası; eş koşullu hız/güvenlik sıralaması değil. |
| L2 kernel'e gelmeden bütün çağrıları durdurur | 16:25 görseli, SRT ve D02/D05 karşılaştırıldı | Kernel kontrolü ile hassas işlemin engellenmesi, kernel'e hiç giriş olmaması değildir. |
| %84 daha az onay, %84 daha az risk demektir | D01'in internal usage ve permission prompts ifadesi okundu | Belirli gözlemde onay sayısı; güvenlik olayı veya nedensel etki ölçümü değil. |
| Aynı path'in okunması host'a kaçışı gösterir | Beş dosya okuma örneğinin gerçek nesnesi ayrıldı | Container/guest dosyası ile host dosyası karışmaz. |
| Güçlü runtime otomatik dar dosya erişimi sağlar | D05'in runsc do ile OCI kapsamı okundu | Aynı teknoloji içinde yapılandırma ve çalışma yolu önemlidir. |
| İnterneti kapatınca tüm zarar biter | 30:50–31:02 yazı/sonraki yüksek-yetki örneği korundu | Yerel bütünlük ve gecikmeli etki açık kalabilir. |
| Kernel kaçışı bütün olayların açıklamasıdır | W01'in doğrudan D08 bağlantısı izlendi | Host-side araç exposure'ı farklı yol; exploit çalıştırılmadı. |
| İkinci kaynak birinci videonun U05 devamıdır | Collection/migration STATE ile yeni source selection karşılaştırıldı | Ayrı child dossier; ilk videonun açık işleri değişmez. |

## Kaynak uyuşmazlığı ve belirsizliğin dürüst aktarımı

Kernel çizimi ve hız matrisi RESEARCH §7'de korunuyor; doğru oldukları varsayılarak temiz bir özet üretilmedi. Semantic Kernel 2024 görsel etiketi ile 2026 birincil bağlantısının eşleşmesi açık. SRT bozuk terimleri sessiz exact alıntıya çevrilmedi. Basit host-file örneği evrensel yasak listesi sayılmadı.

Dış sayfalar dokümantasyon/maintainer veya yazar açıklamasıdır; birincil olmaları tüm güvenlik iddialarını bağımsız deneyle kanıtlamaz. Güncel dokümanlar videonun yapıldığı tarihteki konfigürasyonun yerine geçirilmedi. Kaynak kodu, tüm kernel özellikleri, her child/fallback yolu ve bütün açıklar araştırılmadı.

## Bu inceleme neyi tamamlıyor?

**İlk kaynak incelemesi ve sınırlı teknik çapraz kontroller tamamlandı; sonuç kullanıcı değerlendirmesine hazır.** Videonun ana mekanizmaları ve alternatifleri, hatalı genelleme sınırları ve başlangıç proje ilgisi geri kazanılabilir. Bütün sesin veya çalışan bir sistemin doğrulaması, kabul edilmiş mimari, gerçek güvenlik garantisi ya da bağımsız benchmark sonucu tamamlanmış değildir.

Daha güçlü karar için gerekiyorsa belirli iş yükü, işletim sistemi/ABI, runtime sürümü, gerçek policy, mounts, ağ ve credentials, host-side araçlar, child tree ve runtime gözlemi yeniden ele alınır. Bunlar bir sonraki videoya geçmeden bitirilecek otomatik görev listesi değildir. Somut soru olmadan bütün teknolojilere kurulum/test kampanyası açmak bu kaynağın inceleme hedefini aşar.

Yerel çalışma yalnız medya ölçümü, altyazı parse/read ve kare çıkarma/görsel incelemedir. Test sayısı veya ürün güvenilirlik puanı üretilmedi. İlk videonun U05–U07'si, Foundation, diğer araştırmalar ve agent-control değiştirilmedi. Yayın ayrıca gerçek diff ve main readback ile denetlenir; bu metnin varlığı tek başına yayın makbuzu değildir.
