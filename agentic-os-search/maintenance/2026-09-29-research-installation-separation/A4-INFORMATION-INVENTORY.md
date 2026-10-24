# A4 — Information envanterinin ilk dilimi

**1 Ekim 2026 / REPO-SEPARATION-20260929. KISMİ.** Bu kayıt dosya yolu ve kimlik envanteridir; araştırma içeriği incelemesi değildir. Tek güncel bakım yetkisi ve devam noktası [kök plandadır](../../REPOSITORY-TRANSITION.md).

## 1. Başlangıç ve kapsam

Başlangıç main `d45441970fbec9b022fea59253f6ef85e8e183b3`, root tree `92cbb172af53f65027d6ca90763c443ce0d2d4d2`. Önceki doğrulanmış yayından fark gözlenmedi. Aynı ref üzerindeki makine hesabı author/committer sorguları boştu; başka dallarda veya alternatif kimliklerde yokluk hükmü değildir. [REQUEST](REQUEST.md) ve mevcut A4 sırası izlendi; kurulum veya araştırma yeniden açılmadı.

[JSON envanteri](A4-INFORMATION-INVENTORY.json) `03_ground-deepening/grounds/information` altındaki **157 yeni yolu**, blob kimliklerini ve API boyutlarını taşır: **145 Markdown, 6 JSON, 6 Python; toplam 869.925 byte**. Araştırma gövdesi okuması **0**; tarihsel Python dosyaları çalıştırılmadı.

| Alt alan | Yeni yol | API byte toplamı | Sonuç |
|---|---:|---:|---|
| Information kökü ve synthesis | 19 | 149.158 | Doğrudan giriş yolları tam |
| informational-dynamics kökü ve synthesis | 19 | 123.709 | Doğrudan giriş yolları tam |
| informational-dynamics/derivation-transformation | 96 | 493.671 | Alt dizinleriyle tam yaprak envanteri |
| informational-dynamics/formation-acquisition | 23 | 103.387 | Alt dizinleriyle tam yaprak envanteri |

Information bütünü tamamlanmadı: `informational-dynamics/selection-exposure` ve `informational-state` iki opak sınır olarak korunur. Büyük recursive Information yanıtı ve kısmen görülen selection-exposure yanıtı tam envanter sayılmadı. JSON'daki altı sabit Git Trees kaynağının ilgili yanıtları sonuna kadar alındı; hepsinde `truncated: false` görüldü.

## 2. Doğrulama ve önceki kayıtla birleşim

157 yaprak ve iki opak sınırdan Information kökü yeniden hesaplandı: `57e5859ade346c254e49172028909434af87a460`. İki tamamlanan alt alanın kökleri de uzak kimlikleriyle eşleşti. Hesaplanan 20 dizinin Git nesne kodlaması `git hash-object -t tree --stdin` ile karşılaştırıldı. 157 ayrı yaprak çıkarma, iki sınır çıkarma ve bir yol/bir blob bozma kontrolünde kök eşitliği bozuldu; sağlam liste kabul edildi.

Bu, aynı yazarın deterministik metadata denetimidir. Tree hash'i dosya adını, mode'u ve blob kimliğini bağlar; API boyutlarını bağlamaz. Araştırma doğruluğu, statü/anlam, gövde bağlantıları, arşiv içleri veya bağımsız Claude okuyucu davranışı doğrulanmadı. Önceki içerik incelemeleri yeni yapılmış sayılmaz.

Sabit önceki girdi, başlangıç commit'indeki A4-ENVIRONMENT-INVENTORY.json'dur: blob `0b3afb1662f3e0cd64753f90fbba83279a9e4224`, **30.774 byte**. Önce onun sabit bağımlılık zinciri, sonra d454419 yayınının iki yeni bakım dosyası ve plan farkı uygulanır; Information frontier 157 yaprak ve iki alt sınıra açılır. **912 + 2 + 157 = 1.071 açık repository yolu; Foundation 408 + 157 = 565 açık yol.** Bu sayılar bütün depo veya okunmuş belge sayısı değildir. Foundation'da sekiz, studies ile birlikte dokuz opak sınır kalır; sayıdaki artış yeni kapsam değil, eski Information sınırının ayrıntılandırılmasıdır. Foundation ve birleşik repository kökleri bu dilimde yeniden hesaplanmadı.

## 3. Yayın ve koruma

Yayın kümesi yalnız bu kayıt, yeni A4-INFORMATION-INVENTORY.json ve mevcut REPOSITORY-TRANSITION.md'nin durum/ilerleme/devralma güncellemesidir. Önceki envanterler, araştırma/deneme/yayın gövdeleri, arşiv, MOVES, AGENT.md ve agent/** korunur; dosya silinmez veya taşınmaz. Kaynak kodların adı envantere girdiği için onları çalıştırma yetkisi oluşmaz.

Envanter yayın öncesi snapshot'tır; kendi yayınındaki iki yeni dosya ve plan farkı sonraki birleşime aittir. Yayın öncesi main/delta, aday diff ve yayın sonrası uzak ref/dosya kimlikleri ayrı kontrol edilir; blob veya aday commit oluşturmak tek başına main yayını değildir.

## 4. Tek devam

**A4: `research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/selection-exposure` envanteri.** Ardından informational-state, kalan Foundation sınırları ve studies. Kimlikleri aynıysa bu dilimin 157 yolu tekrar çıkarılmaz.

A4'ün tam yol, içerik/statü/bağlantı ve gerekli arşiv içi taraması açıktır. A5 bekler. A3'te S00–S12 ile SOUL ve DevOS kaynaklarına erişim hâlâ açık olduğundan 5/7 aile durumu korunur; yeni somut erişim olmadan aynı aramalar ve ZIP yükleme talebi tekrarlanmaz.
