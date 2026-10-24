# A4 — EXP-001–005 yaprak envanteri

**30 Eylül 2026 / REPO-SEPARATION-20260929. Durum: KISMİ.** Beş açık alt ağacın 229 dosyası bu dilimde envantere açıldı. Önceki kayıt ve yayın farkıyla birlikte 438 açık dosya kimliği vardır; research altındaki üç ana ağacın yaprak envanteri hâlâ açık. Bu sayı içerik okuma veya bütün repository dosya sayısı değildir. Tek güncel yetki ve devam noktası [kök bakım planındadır](../../REPOSITORY-TRANSITION.md).

## 1. Yetki ve sabit başlangıç

Başlangıç main **`d5cbe13f8d38066f1d5d138022dff28b443a58bf`**, root tree **`61fd18514effa53efe68092a4bfed91aedb85d95`**. Önceki yayınla fark gözlenmedi. Bu sabit ref üzerinde makine hesabı için `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boş döndü; bu, bütün dallar veya alternatif kimlikler hakkında yokluk hükmü değildir.

Görev [REQUEST](REQUEST.md) §4–§6 ve bakım planı §7 uyarınca sıradaki iş dosya envanteridir. EXP-001–005 araştırmaları, eski görevler veya DevOS kurulumu yeniden başlatılmadı. Kaynak anlamına, geçerli platform kararına veya başka repository'lere müdahale edilmez.

## 2. Bu dilimde açılan beş alt ağaç

| Alan | Dosya | API boyut toplamı (byte) | Dizin (alan kökü dahil) | Doğrulanan Git tree |
|---|---:|---:|---:|---|
| EXP-001 | 66 | 6.461.818 | 13 | `d581d4a74c6367d8491282e24593aad0522f59ed` |
| EXP-002 | 38 | 216.360 | 8 | `30a5ccfcabc816c23b0d154ca35b90299ec1e4d1` |
| EXP-003 | 29 | 197.185 | 8 | `8dfb55a8e45febe2f46be6ddb59fbe6892256911` |
| EXP-004 | 75 | 755.974 | 11 | `8352d8c8f835c4c79029b8d28a55b0381abf5874` |
| EXP-005 | 21 | 277.564 | 7 | `732ff5c4549358873104fcd0727cd75834a2689a` |
| **Toplam** | **229** | **7.908.901** | **47** | Beş kökün her biri eşleşti |

Tam path/mode/type/blob/boyut karşılığı [A4-EXP001-005-INVENTORY.json](A4-EXP001-005-INVENTORY.json) içindedir. Metadata, GitHub'ın yukarıdaki değişmez Git Trees nesnelerinin recursive yanıtlarından alındı. Araç görünümünde kesilen yanıtların kalan içeriği ayrıca açıldı; API yanıtlarının `truncated` değeri false idi. Bir dizin kimliğinin bilinmesiyle içindeki yaprakların açılması aynı sayılmadı.

## 3. Önceki envanterle birleşim

[A4-PATH-INVENTORY.json'un sabit sürümü](https://github.com/batuhanozgun/agentic-os-search/blob/d5cbe13f8d38066f1d5d138022dff28b443a58bf/maintenance/2026-09-29-research-installation-separation/A4-PATH-INVENTORY.json), 207 yaprağı ve sekiz açık alt ağacı `36255c1` snapshot'ında taşır. Bu dosya değiştirilmez. Yeni envanter, bu sabit girdiyi blob **`efc3e589647c7803a96b2a5a51f959ef3517a001`**, **29.600 byte** ile bağlar.

`d5cbe13` yayınının dört farkı ayrıca taşınır: concepts INDEX ve bakım planının yeni kimlikleri, A4-INVENTORY-EXPANSION ile A4-PATH-INVENTORY dosyalarının eklenmesi. Bunlar bu turun yeni kaynak değişiklikleri değildir. Sonra beş frontier girdisi 229 açık yaprakla değiştirilir; repository dosyası kaldırılmaz.

**Hesap: 207 + önceki yayının 2 ek dosyası + 229 = 438.** Explorations alanının tamamında 282 dosya kimliği vardır: 229 yeni açılan + önceki EXP-006'nın 50 dosyası + alan kökündeki 3 dosya. Diğer alanların gövdeleri veya yaprakları bu sayıya dayanarak yeni okunmuş sayılmaz.

Yeni JSON, birleşim sırasını, beklenen eski kimlikleri, benzersizlik koşulunu ve kalan üç alt ağacı açıkça taşır. Kapsam yayın öncesi sabit snapshot'tır: bu turun iki yeni bakım dosyası ve plan güncellemesi sonraki yayın farkıdır. Envanter kendi son kimliğini tekrar tekrar içine alan bir kayıt üretmez. Sonraki tam envanterde bu fark da hesaba katılmalıdır.

Yeni JSON **28.701 byte**, Git blob **`2b72cac6c98844e55ec5275a4cfedf976eec213b`**, SHA-256 **`9e5fb9018174de2e4e205925423216a0d19c8c10d4e0d417a33ba7db7be51ab2`**. Uzak blob oluşturma sonucu yerel byte'lardan hesaplanan kimlikle eşleşti. Bu, tek başına main yayını değildir.

## 4. Doğrulamanın kapsamı

229 yeni yaprağın her biri `100644` / `blob` olarak alındı. Her alt ağacın path, mode ve blob kimliklerinden Git'in dizin sıralaması ve nesne kodlamasıyla ağaç tekrar kuruldu; beş hesaplanan kök, uzak Git tree kimliğiyle aynı çıktı. Her bir yaprağın ayrı çıkarıldığı 229 olumsuz kontrolde ilgili kökün eşitliği bozuldu. Doğru listeler kabul edildi. Bu, kayıt atlama/bozma hatasına duyarlı metadata kontrolüdür; yeni ürün veya muhakeme testi değildir.

Önceki 207 yaprağın root doğrulaması önceki turun kayıtlı sonucudur; bu dilimde bütün birleşik 438 yaprağın root'u yeniden hesaplanmış gibi sunulmaz. Yeni beş kök doğrulaması ve bilinen yayın farkıyla kapsam genişletilir. Boyutlar API metadata'sıdır; Git tree hash'inin parçası değildir. Aynı blob'un iki ayrı yolda bulunması iki dosya yolu sayılır, iki bağımsız içerik veya kanıt sayılmaz.

**Yeni araştırma gövdesi okuması: 0.** Zorunlu kontrol ve bakım kayıtları okundu; bu, 229 araştırma dosyasının içerik taramasının yerine geçmez. Dosya türleri arasında 194 Markdown, 8 JSON, 7 DOT, 7 SVG, 3 PDF, 3 HTML, 2 Python ve birer ZIP, SHA256, JavaScript, CSS, PNG vardır. PDF/görsel düzeni, HTML metni, ZIP içleri, kaynak iddiaları, eski komutların anlamı ve gövde bağlantıları bu dilimde incelenmedi. Tarihsel betikler çalıştırılmadı. Bağımsız Claude okuyucu sınaması yapılmadı.

Bu nedenle beş pakete topluca yeni tarihsel etiket konmadı, hiçbir araştırma sonucu onaylanmadı ve “eski yönü güncel gösteren kayıt kalmadı” hükmü verilmedi. Envanter, sonraki içerik taramasının dosya atlamadan yapılabilmesi içindir.

## 5. Yayın kümesi ve korunanlar

Bu dilim yalnız üç yolu değiştirir:

- `maintenance/2026-09-29-research-installation-separation/A4-EXP001-005-INVENTORY.json`: yeni, sabit kaynak kimlikli envanter bileşeni;
- `maintenance/2026-09-29-research-installation-separation/A4-EXPLORATIONS-INVENTORY.md`: yeni kapsam, birleşim ve denetim kaydı;
- `REPOSITORY-TRANSITION.md`: mevcut planın A4 ilerlemesi ve tek devam noktası.

Önceki envanterler ve bakım kanıtları yerinde korunur. `AGENT.md`, `agent/**`, bütün araştırma/deneme/yayın gövdeleri, arşiv ve MOVES değişmez. Silme veya taşıma yoktur. Yeni kurulum, rol, mimari veya SOUL iş listesi üretilmez. Nihai aday farkı yalnız yukarıdaki üç yolu göstermelidir; main delta/yazar kontrolü ve yayın sonrası ref/dosya geri okuması ayrıca yapılır.

## 6. Tek devam

**A4: kalan üç araştırma alt ağacının yaprak envanteri; ilk giriş `research/soul-context`.** Ardından `research/soul-foundations` ve `research/studies` gelir. Mevcut kimlikleri değişmediyse tamamlanan alanların envanteri yeniden çıkarılmaz. Üç alanın başlangıç Git tree kimlikleri JSON'un `remaining_frontier` alanındadır.

Sonrasında A4'ün kalan metin/statü/bağlantı ve gerekli belge/ZIP içi taraması sürer; A5 son karşılaştırma hâlâ yapılmadı. A3, beş arşivlenmiş aile ve erişilemeyen S00–S12 ile SOUL ve DevOS nedeniyle kısmi kalır. Bu iki kaynağa yeni somut erişim olmadan aynı aramalar veya ZIP yükleme talebi tekrarlanmaz.
