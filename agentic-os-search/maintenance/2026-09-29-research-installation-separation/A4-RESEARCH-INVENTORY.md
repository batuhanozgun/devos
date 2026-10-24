# A4 — araştırma alanlarının dosya envanteri

**30 Eylül 2026 / REPO-SEPARATION-20260929. Durum: KISMİ.** Bu kayıt, `research/soul-context` envanterinin tamamlanmasını ve Foundation envanterinin ilk bölümünü kapsar. Araştırma içeriği taraması değildir. Tek güncel yetki ve devam noktası [kök bakım planındadır](../../REPOSITORY-TRANSITION.md). A3'ün iki kaynak erişim engeli ve A5'in bekleme durumu korunur.

## 1. Başlangıç, amaç ve yetki

Sabit başlangıç main **`2dbf81a5ae66ea0482371725e40a4b8a84802979`**, root tree **`938fa623d9ffbec64f89a2713ee636d6eb574c7d`**. Önceki yayınla fark gözlenmedi. Bu ref üzerinde `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boş döndü; bütün dallarda veya farklı kimliklerde yokluk iddiası değildir.

[REQUEST](REQUEST.md) §4–§6 ve bakım planının devralma sırası izlenir: dosya atlamadan tarama yapabilmek için önce kalan yaprak yollarını kaydetmek. Bu iş Foundation araştırmasını, eski current görevlerini veya DevOS kurulumunu yeniden açmaz. Platform kararı, araştırma anlamı ve kontrol dosyaları değiştirilmez.

## 2. Açılan kapsam

| Alan | Açık dosya | API boyut toplamı (byte) | Envanter sınırı |
|---|---:|---:|---|
| `research/soul-context/` | 60 | 677.364 | **Tam yaprak envanteri.** 3 kök dosya, current 42, evidence 3, exploratory 8, repos 4 |
| `research/soul-foundations/` | 27 | 160.062 | **Kısmi.** 6 kök dosya, `00_context/` 1, `01_verticals/actors/` 20; 11 opak alt ağaç |
| **Bu dilim** | **87** | **837.426** | Yeni açılan dosya yolları; yeni oluşturulan araştırma dosyaları değildir |

Context'in 60 dosyası 59 Markdown ve bir Python dosyasıdır. A2'deki 41 başlangıç current dosyası ile sonradan eklenen current README, bugünkü 42 current dosyasını oluşturur. **A2'nin tamamlanmış içerik/statü kararları yeniden yapılmış sayılmaz.** Context dışındaki alanlara ilişkin eski sonuçlar da bu sayıya eklenerek yeni inceleme toplamı üretilmez.

Foundation'ın iki alt alanı için tam yaprak listesi elde edildi: `00_context/` ve `01_verticals/actors/`. Diğer alanların yalnız sınır kimlikleri kayıtlıdır. Foundation'ın recursive yanıtının tamamı görünür olarak geri kazanılmadı; ilk tam blokları kullanıldı, geri kalanı tam envanter sayılmadı. `records-artifacts` için görülen başlangıç parçası da tamamlanmış liste olarak alınmadı.

## 3. Kaynak ve doğrulama

[A4-RESEARCH-INVENTORY.json](A4-RESEARCH-INVENTORY.json) kesin path/blob/boyut girdilerini, önceki kayıtla birleşim tarifini ve kalan alt ağaçları taşır. Yeni yaprakların mode/type değeri `100644` / `blob`'dur. Kaynaklar sabit GitHub Git Trees nesneleridir:

- Context recursive tree: `7b823b3e422516c46b696395caf97c7b58263a5f`; tam yanıt sonuna kadar açıldı, `truncated: false`.
- Foundation doğrudan kökü: `0f9513f91bba76f1e52c955ddcb6270908c11939`; 6 dosya ve 10 alt ağaç.
- Foundation verticals doğrudan kökü: `4e2325dfd8f49454e8bf9cd8f63908e171c0c131`; dört alt ağaç.
- Foundation recursive yanıtının tam görülen `00_context` ve `actors` blokları; hesaplanan kökleri sırasıyla `349911b392ba647c891af3332d6f27554978fe89` ve `109505629955c396cf6cdedacbeb2c587c4448f1` ile eşleşti.

Yerel kayıtların path/mode/blob girdilerinden Git nesne kodlaması ve dizin sıralamasıyla kökler yeniden hesaplandı. Context'in 60 yaprağı kendi uzak kökünü; Foundation'ın 27 yaprağı ve 11 opak alt ağaç kimliği birlikte Foundation kökünü yeniden üretti. Böylece Foundation'ın açılmış ve açılmamış sınırlarının birlikte kaydı denetlendi; opak alanların içlerinin görüldüğü ileri sürülmedi.

87 yeni yaprağın her biri ayrı çıkarıldığında ilgili kök eşitliği bozuldu. Foundation'ın 11 opak sınırından her biri çıkarıldığında da eşitlik bozuldu. Doğru listeler kabul edildi. Context'te 24, Foundation'ın açılmış kısmında 7 dizin hesaplandı; bunlar bağımsız API çağrısı veya içerik okuması sayısı değildir.

**Doğrulama sınırı:** Aynı yazarın deterministik metadata kontrolüdür. Boyutlar API metadata'sıdır; tree hash'i boyutları bağlamaz. Önceki bütün yapraklarla birleşik repository kökü bu dilimde yeniden hesaplanmadı. Yeni araştırma gövdesi okuması **0**; kaynak iddiaları, gövde bağlantıları, PDF/görsel ve ZIP içleri, tarihsel Python davranışı veya bağımsız Claude okuyucu davranışı sınanmadı. Hiçbir tarihsel betik çalıştırılmadı.

## 4. Önceki kayıtla birleşim ve dosya kimliği

Önceki [EXP envanteri](A4-EXP001-005-INVENTORY.json), `2dbf81a` commit'inde blob **`2b72cac6c98844e55ec5275a4cfedf976eec213b`** ve **28.701 byte** ile bulunur; `d5cbe13` anlık görüntüsünde 438 açık yolu tanımlar. Onun bağlı olduğu sabit [A4-PATH-INVENTORY](A4-PATH-INVENTORY.json) ve yayın farkı tarifi korunur.

Yeni JSON önce `2dbf81a` yayınının üç farkını ekler: planın yeni kimliği ve o yayında eklenen iki bakım dosyası. Ardından eski context/Foundations frontier girdilerini bu dilimin kayıtlarıyla açar. Hesap **438 + önceki yayının 2 ek dosyası + 60 + 27 = 527 açık dosya yolu**. Yeni 87 yol birbiriyle çakışmaz ve önceki envanterde opak bırakılmış iki alanın altındadır.

Bu sayı bütün repository'nin toplamı değildir. Kalan iki üst araştırma alanı Foundation ve studies'dir. Foundation ayrıntılandırıldığı için frontier artık 11 Foundation alt ağacı ve bir studies ağacı, yani **12 opak sınır** taşır. Bu artış yeni kapsam açıldığı anlamına gelmez; eski opak Foundation alanının daha ayrıntılı tarifidir.

Yeni JSON **14.762 byte**, Git blob **`a908c77955190588cd199a2cc436342a20949e7a`**, SHA-256 **`15a3dacfcf5a16d65475bb975de860b2d0c422c12e690ac8d5683b857b3d52b4`**. Uzak blob oluşturma sonucu yereldeki byte kimliğiyle eşleşti. Bu tek başına main yayını değildir. Envanter yayın öncesi sabit snapshot'tır; bu turun iki yeni bakım dosyası ve plan güncellemesi sonraki yayın farkıdır, kendisini sonsuz kez içine alan bir liste kurulmaz.

## 5. Yayın kümesi ve koruma

Yalnız üç yol yazılır: `A4-RESEARCH-INVENTORY.json`, bu `A4-RESEARCH-INVENTORY.md` ve kökteki `REPOSITORY-TRANSITION.md` ilerleme/devralma güncellemesi. İki yeni dosya bakım kaydıdır; araştırma veya DevOS iş listesi değildir.

Araştırma, deneme, yayın ve arşiv gövdeleri; `AGENT.md`, `agent/**`, önceki envanterler ve MOVES korunur. Dosya silinmez veya taşınmaz; başka repository ya da hesaba yazılmaz. Main farkı ve yazar kontrolü yayın öncesi, uzak ref ve üç dosya kimliğinin geri okuması yayın sonrası ayrıca yapılır. Başarılı blob ya da aday commit, ref doğrulanmadan yayın diye sunulmaz.

## 6. Tek devam

**A4: Foundation yaprak envanterini `research/soul-foundations/01_verticals/records-artifacts` girişinden sürdür.** Sonra JSON'daki kalan Foundation frontier ve studies gelir. Kimlikleri aynıysa context ve daha önce tamamlanan alanların yaprak listeleri tekrar çıkarılmaz. Bu bir içerik araştırması veya mimari devam yetkisi değildir.

Tam yol envanteri ardından metin/statü/bağlantı ve gerekli belge/ZIP içi taraması sürer. Bu yükler kaldırılmadı; A4 kapanmadı. A5 bekler. A3'ün S00–S12 ve SOUL ve DevOS kaynakları, yeni somut erişim olmadan tekrar aranmaz veya başka metinle ikame edilmez.
