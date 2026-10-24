# EXP-001 — Görünür diyalog kaynak dizini

## Kapsam ve sadakat

Bu dizin modele görünür kullanıcı metinleri ile substantive assistant cevaplarının aktarımıdır; ham ChatGPT export'u, tool trace veya gizli muhakeme değildir. Mesaj saatleri bilinmediği için üretilmemiştir. Kullanıcı yazımı düzeltilmeden korunmaya çalışılmıştır; mekanik byte-perfect platform karşılaştırması yapılamamıştır. Satır boşlukları ve kod bloklarının geçici UI kimlikleri normalize edilebilir; kaynak metnin anlamı veya tarihsel yanlışları sessizce güncellenmez.

U001–U019 ve S001–S018 kesimi 37 görünür kaynak mesajından oluşur. Akış aşağıdaki tabloda U ardından S olacak şekilde okunur. Bu arşivleme turunun yanıtı henüz kaynak kesimine dahil değildir.

| Sıra | Kullanıcı | Assistant | Konu |
|---|---|---|---|
| 01 | [U001](USER-MESSAGES.md#u001) | [S001](assistant/S001.md) | Form uygulaması üzerinden Work/Information sorusu |
| 02 | [U002](USER-MESSAGES.md#u002) | [S002](assistant/S002.md) | Hava bugün çok; araştırma girdiden davranışa nasıl geçer? |
| 03 | [U003](USER-MESSAGES.md#u003) | [S003](assistant/S003.md) | Bittiğinde ne var; amaç, kapsam, yöntem |
| 04 | [U004](USER-MESSAGES.md#u004) | [S004](assistant/S004.md) | A–B–C; kavramsal prova sınırı |
| 05 | [U005](USER-MESSAGES.md#u005) | [S005](assistant/S005.md) | Roman, yayın, dağıtım; kapsamı keşfetmek |
| 06 | [U006](USER-MESSAGES.md#u006) | [S006](assistant/S006.md) | Özgün çizim; C ile Work'ün birlikte değişmesi |
| 07 | [U007](USER-MESSAGES.md#u007) | [S007](assistant/S007.md) | Sentetik form/dashboard demosu; C0–C3, W-01–04, D-02 |
| 08 | [U008](USER-MESSAGES.md#u008) | [S008](assistant/S008.md) | Altı proje dosyası ve görünmeyen çalışma bilgisi |
| 09 | [U009](USER-MESSAGES.md#u009) | [S009](assistant/S009.md) | Dosyaları aktörün kullanması |
| 10 | [U010](USER-MESSAGES.md#u010) | [S010](assistant/S010.md) | Harness ve çalışma ortamının hacmi |
| 11 | [U011](USER-MESSAGES.md#u011) | [S011](assistant/S011.md) | Mimar/kulübe/alet çantası; standart, yetkinlik ve süreklilik |
| 12 | [U012](USER-MESSAGES.md#u012) | [S012](assistant/S012.md) | Kırpmadan konsolidasyon ve v0.1 teslimi |
| 13 | [U013](USER-MESSAGES.md#u013) | [S013](assistant/S013.md) | Program gibi düşünülebilir mekanizma; işlem sözleşmeleri |
| 14 | [U014](USER-MESSAGES.md#u014) | [S014](assistant/S014.md) | HTML/PDF/SVG Atlas önerisi |
| 15 | [U015](USER-MESSAGES.md#u015) | [S015](assistant/S015.md) | Atlas v0.1 teslimi |
| 16 | [U016](USER-MESSAGES.md#u016) | [S016](assistant/S016.md) | Roman 1–6 / 1.1–1.5; odak, başka dala not; Atlas kapsam açıklığı |
| 17 | [U017](USER-MESSAGES.md#u017) | [S017](assistant/S017.md) | Yaşayan plan, Work kaynakları, WBS/HTN/rolling wave |
| 18 | [U018](USER-MESSAGES.md#u018) | [S018](assistant/S018.md) | Araştırmadan ayrı denemeler kütüphanesi ve arşivleme planı |
| 19 | [U019](USER-MESSAGES.md#u019) | — | Bu arşivleme turunun açık uygulama yetkisi |

## Atıflar ve ekler

Eski `filecite` kimlikleri mesaj içindeki tarihsel gösterimlerdir; farklı araç dönemlerinde aynı kimlik farklı çıktıya işaret edebilir. Global tekil kimlik kabul edilmez. Kalıcı kaynak yolları ve konu düzeyi bağlar [RESEARCH-REFERENCES](../RESEARCH-REFERENCES.md) içinde tutulur. Raw sandbox adresleri teslim geçmişini korur; yeni oturumda erişim garantisi değildir. Özgün eser byte'ları için paket SOURCE-MANIFEST ve STATE birlikte okunur.

U006'nın el çizimi, `sources/original-sketch.png` olarak yerel kaynak paketinde korunur; remote payload durumuna STATE'ten bakılır. Erişimi olmayan aktör çizimi metinden yeniden üretip özgünmüş gibi sunmamalıdır.

## Bilerek dahil edilmeyenler

Diğer proje conversation özetleri, sistem/developer talimatları, gizli muhakeme, connector kimlik bilgileri, token içeren transport yanıtları ve geçici QA render kopyaları kapsam dışıdır. Kaynak eser ZIP'inin içindeki özgün doğrulama raporu ise eserin parçası olarak saklanır; bu tur tekrar bağımsız UI doğrulaması yapıldığı anlamına gelmez.
