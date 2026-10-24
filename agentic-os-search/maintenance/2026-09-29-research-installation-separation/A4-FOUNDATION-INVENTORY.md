# A4 — Foundation dikeyleri ve yeterlilik envanteri

**30 Eylül 2026 / REPO-SEPARATION-20260929. Durum: KISMİ.** Bu dilim 173 yeni dosya yolunu kaydeder. Foundation'ın dört dikeyi 133 dosyayla tam envanterlidir; Foundation bütünü 200 açık dosya ve sekiz opak alt ağaçla hâlâ kısmidir. Önceki kayıt ve yayın farklarıyla repository kapsamı 702 açık yoldur; bu bütün depo sayısı veya içerik okuma sayısı değildir. Tek güncel yetki ve devam [kök bakım planındadır](../../REPOSITORY-TRANSITION.md).

## 1. Başlangıç ve yetki

Sabit başlangıç main `ac7e4549ee87b35d84a3f34b86e5f48912549cb3`, root tree `47a16b3c9a41c9350668fbda81535bb7538fa6d5`. Önceki doğrulanmış yayından fark gözlenmedi. Aynı ref üzerinde `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boştu; bu bütün dallar veya alternatif kimlikler hakkında yokluk iddiası değildir.

[REQUEST](REQUEST.md) §4–§6 ve bakım planının devralma sırası uygulanır. Amaç, sonraki içerik ve yönlendirme taramasında dosya atlamamaktır. Foundation araştırması veya DevOS kurulumu başlatılmaz; dosya adlarındaki current/next tek başına yanlış yönlendirme sayılmaz. Araştırmanın kendi durumu ve anlamı korunur.

## 2. Bu dilimin kesin kapsamı

Aşağıdaki yollar `research/soul-foundations/` altındadır. Bütün yaprakların kesin yol/blob/boyut değerleri [JSON kaydındadır](A4-FOUNDATION-INVENTORY.json).

| Alan | Yeni açık dosya | API boyut toplamı (byte) | Sonuç |
|---|---:|---:|---|
| `01_verticals/records-artifacts` | 66 | 402.099 | Tam yaprak envanteri |
| `01_verticals/work-environment` | 30 | 251.409 | Tam yaprak envanteri |
| `01_verticals/work` | 17 | 122.069 | Tam yaprak envanteri |
| `02_adequacy` | 22 | 216.148 | Tam yaprak envanteri |
| `03_ground-deepening` | 38 | 244.280 | Kısmi: altı kök dosya, actors 16, work 16; environment/information opak |
| **Toplam** | **173** | **1.236.005** | Yeni araştırma gövdesi okuması: **0** |

Önceki actors dikeyinin 20 dosyası bu turun yeni dosyası değildir. Onunla birlikte dört dikey toplamı **133** olur. Önceki 27 Foundation yolu + 173 yeni yol = **200**, API boyut toplamı **1.396.067 byte**. Bunlar yeni oluşturulan kaynaklar değil, mevcut dosyaların envanteridir.

Kalan sekiz Foundation sınırı: deepening/grounds/environment ve information; 04, 05, 06, 07, 08 paketleri ve history. `research/studies` ayrıca opaktır; toplam dokuz açık sınır vardır. Tam dosya adları ve tree kimlikleri JSON'da bulunur.

## 3. Kaynak, yöntem ve doğrulama sınırı

Metadata sabit GitHub Git Trees nesnelerinden alındı; her bloğun değişmez API adresi JSON'daki `source` alanındadır. API yanıtları `truncated: false` idi; görünümde kesilmiş yanıtların ilgili kalan bölümleri açıldı. Büyük `03_ground-deepening` recursive metadata yanıtı sonuna kadar görüldü. Buna rağmen environment/information'ın bütün yaprakları bu dilimde kalıcı listeye geçirilip doğrulanmadı; tamamlanmış sayılmadı. Actors ayrıca küçük, tam yanıt üzerinden karşılaştırıldı. Aynı metadata'nın ikinci kez görülmesi yeni içerik okuması veya bağımsız kanıt değildir.

Yeni blokların kökleri path/mode/blob girdilerinden Git sıralaması ve nesne kodlamasıyla yeniden kuruldu. Altı tam alt blok (üç dikey, adequacy, derinleştirmedeki actors ve work) kendi uzak tree kimlikleriyle eşleşti. Derinleştirme kökü 38 yaprak + iki opak alt ağaçtan yeniden üretildi. Önceki 27 Foundation yaprağı eklenince **200 yaprak + sekiz opak sınır**, uzak Foundation kökü **`0f9513f91bba76f1e52c955ddcb6270908c11939`** ile eşleşti. Açılmış 32 dizinin nesne hash hesabı yerel `git hash-object -t tree --stdin` ile de karşılaştırıldı. Dört dikeyin tam kökü **`4e2325dfd8f49454e8bf9cd8f63908e171c0c131`** olarak doğrulandı.

Olumsuz kontroller: 200 yaprak ayrı ayrı çıkarıldı; sekiz opak sınır ayrı ayrı çıkarıldı; bir yol ve bir blob kimliği değiştirildi. Her durumda kök eşitliği bozuldu; doğru liste kabul edildi. Bu, eksik veya bozuk envantere duyarlı **aynı yazarın deterministik metadata denetimidir**. Git hash'i API'nin boyut alanını içermez. Önceki bütün kayıtlarla birleşik repository kökü bu tur yeniden hesaplanmadı.

**İçerik/bağlantı/kanıt geçerliliği incelemesi yapılmadı.** 173 yeni yolun hepsi Markdown olsa da metinleri okunmuş sayılmaz. PDF/ZIP içleri, tarihsel kod davranışı, kaynak iddiaları veya bağımsız Claude okuyucu davranışı sınanmadı. Tarihsel betikler çalıştırılmadı; araştırma sonuçlarına yeni kabul veya tarihsel etiket verilmedi. A2'nin mevcut kararları bu tur yeniden yapılmış sayılmaz.

## 4. Önceki envanterle birleşim

Sabit girdi [A4-RESEARCH-INVENTORY.json](https://github.com/batuhanozgun/agentic-os-search/blob/ac7e4549ee87b35d84a3f34b86e5f48912549cb3/maintenance/2026-09-29-research-installation-separation/A4-RESEARCH-INVENTORY.json): **14.762 byte**, blob **`a908c77955190588cd199a2cc436342a20949e7a`**, önceki anlık görüntüde 527 açık yol. Önce onun EXP ve PATH envanteri bağımlılıkları aynı sürümleriyle birleştirilir; eski kayıtlar değiştirilmez.

Sonra ac7e454 yayınının üç farkı eklenir: planın yeni kimliği ve iki yeni RESEARCH-INVENTORY bakım dosyası. Bunlar yeni kaynak değişikliği değildir. Beş Foundation frontier girdisi bu dilimin bloklarıyla açılır; repository'den hiçbir dosya kaldırılmaz. **527 + önceki yayının 2 ek dosyası + 173 = 702 benzersiz açık yol.** Kalan frontier yukarıdaki dokuz sınırdır. Yeni envanter yayın öncesi snapshot'tır; kendisini ve bu yayınla eklenecek diğer bakım kaydını sonsuz biçimde kendi içine eklemez.

Yeni JSON'un yerel kimliği: **24.141 byte**, Git blob **`e2939212e1095881e5bac5c7ea2b22565f56332b`**, SHA-256 **`56ba127ddc656141703823e038f17e610eb3c9a1181f820c1a699896d55f68a8`**. Uzak blob oluşturma, main'e yayın ve yayın sonrası readback ayrı işlemlerdir; dosyanın yerelde olması yayın değildir.

## 5. Yayın kümesi

Yalnız üç yol: yeni `A4-FOUNDATION-INVENTORY.json`, bu yeni `A4-FOUNDATION-INVENTORY.md`, mevcut `REPOSITORY-TRANSITION.md` ilerleme ve tek devam güncellemesi. Görev aşamaları, yetki, kapanış koşulları ve eski tarihli ilerleme gövdeleri korunur. Planın önceki 42.474 byte gövdesi yerelde uzak blob `cd6b0c130200b9d49de46a3bb5d6afcd3675e511` ile eşleştirildi; özgün son-LF yokluğu korunur.

Bütün araştırma/deneme/yayın içerikleri, `AGENT.md`, `agent/**`, arşiv, önceki envanterler ve MOVES değişmez. Dosya silinmez veya taşınmaz; başka depoya, hesaba veya Supabase'e yazılmaz. Aday farkı yalnız bu üç yolu göstermelidir. Main farkı/yazar kontrolü yayın öncesi, uzak ref ve üç dosya kimliğinin geri okuması yayın sonrası yapılır. Yeni bağlantılar aynı bakım dizinindeki mevcut/yeni envanterlere ve mevcut kök plana gider; bu, bütün eski gövde bağlantılarının doğrulandığı anlamına gelmez.

## 6. Tek devam

**A4 — `research/soul-foundations/03_ground-deepening/grounds/environment` yaprak envanteri.** Ardından information, diğer Foundation sınırları ve studies. Tamamlanan alanların kimlikleri aynıysa listeleri yeniden çıkarılmaz. Metadata okuması içerik okumasının yerine geçmez.

A4'ün tam yol envanteri, içerik/statü/bağlantı ve gerekli belge/ZIP içi taraması açıktır; A5 bekler. A3'ün S00–S12 ve SOUL ve DevOS kaynak erişim engelleri korunur; yeni somut erişim olmadan tekrar aranmaz ve aynı ZIP yeniden istenmez. **Eski yönü güncel gösteren hiçbir kayıt kalmadığı henüz teyit edilmez.**
