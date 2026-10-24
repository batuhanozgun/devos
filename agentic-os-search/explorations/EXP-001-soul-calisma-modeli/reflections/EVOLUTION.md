# EXP-001 — Düşünce evrimi ve düzeltme izi

Bu dosya kaynak metinleri geriye dönük düzeltmez. İki aktörün aynı fikre yaklaşmak için yaptığı çerçeve değişikliklerini kaynak sırasıyla gösterir. “Son yorum” bir mimari kabulü değil, bu oturumdaki son görünür yaklaşımı anlatır.

| Evre | İlk çerçeve / eksik | Değiştirici girdi | Oturumda gelinen karşılık | Kaynak |
|---|---|---|---|---|
| E01 | Uygulamanın nasıl yapılacağına hızla geçme | Kullanıcı örneğin araç, asıl sorunun LLM girdisinin çalışma davranışına dönüşmesi olduğunu açıklar | Araştırma ayrımı + işletim tercihi + anlık durum ayrımı | [U002](../sources/conversation/USER-MESSAGES.md#u002), [S001](../sources/conversation/assistant/S001.md), [S002](../sources/conversation/assistant/S002.md) |
| E02 | A'yı iyi ifade edilmiş gereksinime çevirme | Kullanıcı A/B/C ile ifade, zihinsel model ve yeterli çalışma tanımını ayırır | C, kaynağa bağlı ve değişebilir problem anlayışı; B tahmini gerçek sayılmaz | [U004](../sources/conversation/USER-MESSAGES.md#u004), [S004](../sources/conversation/assistant/S004.md) |
| E03 | Romanı geniş kapsamlı faaliyetlere açmak | Manuskript, yayın, okura erişim ve kariyer farklı amaçlar olabilir | Geniş amaç keşfi, bütün kapsamı otomatik üstlenme değildir | [U005](../sources/conversation/USER-MESSAGES.md#u005), [S005](../sources/conversation/assistant/S005.md) |
| E04 | “C yeterince bitti; execution'a geç” şeklinde genel kapı | Kullanıcının çizimi, yazım ve dağıtım örneği | İşe özgü başlanabilirlik; keşif ile üretim birlikte ilerler | [U006](../sources/conversation/USER-MESSAGES.md#u006), [S006](../sources/conversation/assistant/S006.md) |
| E05 | C'nin küçülmesi / A ile büyüklük karşılaştırması | Bilginin zenginliği ile belirsizliğin ayrı olması | Sayısal A>C kuralı değil; geçerli seçeneklerin ve belirsizliğin değişmesi | [S006](../sources/conversation/assistant/S006.md), konsolidasyon §5 |
| E06 | Demo kendiliğinden akan bir düzen gibi görünür | Kullanıcı proje dosyalarının arkasındaki çalışma bilgisini sorar | Kaynak/rule/domain/state/runtime ve onları kullanan aktörler görünür olur; anlatıcı aktarımı runtime doğrulaması değildir | [U008–U009](../sources/conversation/USER-MESSAGES.md#u008), [S008](../sources/conversation/assistant/S008.md), [S009](../sources/conversation/assistant/S009.md) |
| E07 | Ortamın büyüklüğünü maliyet ve bürokrasi kaygısı gibi okumak | Kullanıcı “yakınmadım”, ev/gökdelen/kulübe ve alet çantası örneğiyle düzeltir | Ölçekten bağımsız mesleki standart; kapsam/katılım bu standardın içinden belirlenir | [U011](../sources/conversation/USER-MESSAGES.md#u011), [S010](../sources/conversation/assistant/S010.md), [S011](../sources/conversation/assistant/S011.md) |
| E08 | Agent her tur bütün üniversite/meslek bilgisini yeniden öğrenmeli | Genel kapasite ile proje/kurum/episodik bağlamı ayırma | Yeni çağrıda eğitimi tekrarlamak değil, sorumluluğa güncel katılım bağlamını kurmak | [U011](../sources/conversation/USER-MESSAGES.md#u011), [S011](../sources/conversation/assistant/S011.md) |
| E09 | Uzmanı yalnız görev çıktıktan sonra çağırma | İş ihtiyacını keşfetmek de uzmanlık ister | Süregelen uzmanlık sorumluluğu; rol etiketi yeterlilik değildir; actor readiness | [S011](../sources/conversation/assistant/S011.md) |
| E10 | Metinsel prensipler yeterince somut görünmez | Kullanıcı program akışı benzetmesini getirir | İşlem sözleşmeleri, tipli ilişkiler, ideal geçiş ile gerçek doğruluk ayrımı; Atlas | [U013–U015](../sources/conversation/USER-MESSAGES.md#u013), [S013](../sources/conversation/assistant/S013.md), [S015](../sources/conversation/assistant/S015.md) |
| E11 | Yerel iş discovery/admission mekanizması bütün proje planını temsil ediyor sanılabilir | Kullanıcının 1–6/1.1–1.5 roman planı, başka dala not ve odak örneği | Yaşayan katmanlı plan ayrı açıklık; I03'ün adı bu ihtiyacı tamamlamıyor | [U016](../sources/conversation/USER-MESSAGES.md#u016), [S016](../sources/conversation/assistant/S016.md) |
| E12 | C'yi bul, sonra planı üret şeklinde yeni seri kapı riski | C'yi bulurken plan sinyallerinin de doğması | C ↔ plan ↔ gerçek Work; koşul≠eylem, sıra≠bağımlılık, child done≠parent achieved | [U017](../sources/conversation/USER-MESSAGES.md#u017), [S017](../sources/conversation/assistant/S017.md) |
| E13 | Son PDF veya Atlas oturumun tamamıdır varsayımı | Kullanıcı denemeleri araştırmadan bağımsız bir kütüphane olarak arşivlemeyi ister | Kaynak mesajlar, eser kesimleri, sonraki değerlendirme ve retrieval ayrı korunur | [U018–U019](../sources/conversation/USER-MESSAGES.md#u018), [S018](../sources/conversation/assistant/S018.md) |

## Değiştirilmemesi gereken tarihsel sınırlar

Konsolidasyon v0.1, E09'a kadar gelişen görüşleri bütünleştiren eserdir. Atlas v0.1 E10'un ürünüdür; E11–E12'nin yaşayan plan modelini tamamlamış değildir. E11–E12'yi arşivlemek Atlas dosyalarını değiştirme yetkisi değildir. E13, bu arşivi başlatır; yeni araştırma veya Atlas sürümü başlatmaz.

Erken cevaplarda güçlü/genel söylenmiş cümleler korunur ama otomatik uygulanmaz. Örneğin “Work A geldiği anda başlar” talep taahhüdü olarak; “roman içeriği dağıtımla hiç bağlantılı değildir” evrensel edebiyat ilkesi olarak; “C giderek stabil olur” monoton garanti olarak okunmamalıdır. Bunlar örnek ve diyalog bağlamında değerlendirilir.

## Sonraki deneme bu izi nasıl kullanabilir?

Yeni deneme hangi E/L kaydını devraldığını belirtir; aynı sonucu yeni kanıt olmadan tekrar etmek bağımsız doğrulama sayılmaz. Yeni karşı örnek eski kaydı silmez; yeni EXP'de `revises` veya `contrasts_with` bağı ve gerekçe oluşur.
