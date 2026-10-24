# A4 — yol envanterinin genişletilmesi

**30 Eylül 2026 / REPO-SEPARATION-20260929. Durum: KISMİ.** Bu dilimde 207 dosyanın yol/kimlik/boyut envanteri ve sekiz henüz açılmamış alt ağacın sınırı kaydedildi. Bütün repository envanteri, bütün metinlerin taraması veya A4 kapanışı değildir. Tek güncel iş ve yetki [kök bakım planındadır](../../REPOSITORY-TRANSITION.md). A3'ün iki kaynak erişim engeli korunur; A5 bekler.

## 1. Başlangıç ve kapsam

Başlangıç main `36255c146241f0d05ed8f4672f7cbf7c35752af5`; root tree `195e2f97bf456c8cd50f96cb8c5191092ada62cb`. Önceki doğrulanmış yayından sonra main farkı gözlenmedi. Aynı sabit ref üzerinde `author=batuhanozgun-devos` ve `committer=batuhanozgun-devos` sorguları boş döndü. Bu, bütün dallarda veya alternatif kimliklerde makine hesabı commit'i bulunmadığını kanıtlamaz.

Görev [REQUEST](REQUEST.md) §4–§6, araştırma içeriğini koruyarak okuyucuya araştırma/kurulum ve veri/talimat sınırını göstermeyi, kapsamlı taramayı ve fazladan değişikliklerin gerekçesini ister. Bu tur kurulum, yeni araştırma, terim çıkarımı, kaynakların doğruluk değerlendirmesi veya platform seçimi yapılmadı. Başka depoya veya hesaba yazılmaz.

Önceki dört history notu gerçekten yayımlanmıştı; bekleyen iş gibi yeniden uygulanmadı. Önceki [69-dosya envanteri](A4-SCOPED-INVENTORY.json) ve [ilk tarama/yayın kaydı](A4-INITIAL-SCAN.md) tarihli kayıt olarak değişmeden kalır. Yeni [A4-PATH-INVENTORY](A4-PATH-INVENTORY.json), o 69 dosyayı dört yayımlanmış history farkıyla güncelleyerek 138 yeni dosyayla birleştirir; 207, 207 yeni okuma veya yeni dosya değildir.

## 2. Envanter sonucu

| Alan | Açık dosya kimliği | Yaprak envanteri sınırı |
|---|---:|---|
| Kök dosyalar | 4 | Dört kök dosyanın tamamı |
| `agent/` | 9 | Tam; yalnız kontrolün korunmasına ilişkin metadata, araştırma korpusu değildir |
| `archives/` | 4 | Tam repository yolu listesi; ZIP'in içi bu sayıya dahil değil |
| `concepts/` | 75 | Tam yaprak envanteri; içerik incelemesi tamamlanmış değil |
| `development-os/` | 19 | Önceki tam envanter aynı alt-ağaç kimliğiyle yeniden kullanıldı |
| `explorations/` | 53 | Kökün üç dosyası + EXP-006'nın 50 dosyası; EXP-001–005 içerilmez |
| `maintenance/` | 16 | Başlangıç commit'inde tam; bu turun yeni bakım dosyaları sonraki yayın farkıdır |
| `publications/` | 26 | Tam yaprak envanteri; yalnız giriş dosyası bu tur tam okundu |
| `research/` | 1 | Yalnız kök INDEX; üç ana alt ağaç açık |
| **Toplam** | **207** | **Repository'nin toplam dosya sayısı değildir** |

Sekiz açık alt ağaç, kesin path ve Git tree kimliğiyle envanterin `frontier` alanındadır: EXP-001–005 ile `research/soul-context`, `research/soul-foundations`, `research/studies`. Bunların kimliği ve kökteki üyeliği bilinir; içlerindeki bütün dosya yolları henüz bu envantere açılmamıştır. Önceki A2 içerik sonuçları, bu alanların yeni tam envanteriymiş gibi sayılmaz.

## 3. Kayıt tamlığı nasıl sınandı?

Yeni metadata sabit Git Trees kaynaklarından alındı. İlk üç küçük concepts alt ağacı büyük recursive cevabın görünen bölümünde eksiksizdi ve ağaç kimlikleriyle doğrulandı; kalan alt ağaçlar ayrı, tam görünür yanıtlardan tamamlandı. Kesilmiş görünümün bütünü okunmuş sayılmadı. Her tamamlanan dizinin `name/mode/type/sha` girdileri Git'in dizin sıralamasıyla yeniden kodlandı; hesaplanan ağaç kimliği kaynaktakiyle karşılaştırıldı. Önceki 69 dosya da kaynak envanterinin kimliği ve yayımlanmış dört dosya farkıyla bağlandı.

**39 açılmış dizin doğrulandı.** Bu sayı 39 bağımsız API çağrısı veya içerik okuması değildir; bazı iç dizinler yapraklardan türetildi ve üst ağacın bilinen kimliğiyle bağlandı. Düz 207 yaprak ile sekiz açık alt-ağaç kimliği birlikte başlangıç root tree'sini yeniden üretti. Bu, sekiz alt ağacın da açıldığı anlamına gelmez: onlar açıkça opak sınır olarak kalır.

Olumsuz kontrollerde her bir yaprak ayrı ayrı çıkarıldı (207); her açık alt ağaç çıkarıldı (8); bir yol, bir mode ve bir blob kimliği değiştirildi (3). Hepsinde beklenen root eşitliği bozuldu. Bu kontrollerin konusu dosya envanteridir; sayı bir muhakeme ya da ürün kalitesi skoru değildir. Boyut alanları Git tree hash'inin parçası değildir; API'nin döndürdüğü metadata olarak saklanır.

**Denetim sınırı:** Aynı yazarın deterministik kayıt karşılaştırması ve belge incelemesidir; bağımsız Claude okuyucu sınaması değildir. Kaynakların olgusal doğruluğu, bütün gövde bağlantıları, PDF/görsel düzeni veya ZIP içlerinin statüsü bu kontrolden çıkarılamaz. Hiçbir tarihsel Python/kurulum betiği çalıştırılmadı; ağ veya hesap ayarı değiştirilmedi.

## 4. Üç girişin tam okuması ve sonuçları

| Dosya | İnceleme | Sonuç ve gerekçe |
|---|---|---|
| [Kök README](../../README.md) | Tam; `a1ce9546c684317461d56ef321ea020285411552` | **KORU.** Araştırma/kurulum, ChatGPT kontrolü/Claude okuyucu ve eski/yeni SOUL depoları zaten açıkça ayrılıyor. Bu kaynak A2'de sonuçlandırılmıştı; yeni değişiklik gerektiren bulgu yok. |
| [Concepts INDEX](../../concepts/INDEX.md) | Tam; önce `b7e19deb909462a42f6f48508f1cfc1afd987000` | **ALTI SATIRLIK OKUYUCU SINIRI.** Doğrudan dosyadan girildiğinde “Önce ... AGENT.md”, tam okuma ve “global current authority” ifadelerinin kime ait olduğu açık değil. Aktif terim araştırması korunarak bu okuma/current yönlerinin ChatGPT araştırmasına ait olduğu ve Claude DevOS kurulumu için talimat olmadığı başta belirtilir. |
| [Yayın arşivi README](../../publications/linkedin/README.md) | Tam; `878c88b4134223d68e04eb9484eae20539280012` | **KORU.** Mevcut metin, alanı yayımlanmış görüşlerin arşivi olarak tanımlar; agent talimatı veya kabul edilmiş araştırma sonucu olmadığını açıkça söyler. Yayın gövdeleri bu tur okunmuş sayılmaz. |

Concepts düzeltmesi araştırmanın bulgularına yönelik değildir. Aynı sözcükle aynı anlam varsayılmaz; kaynak ifadesi, yorum ve bugünkü işlem yetkisi ayrı tutulur. Kullanıcının okuma anındaki yorumları denetleyememesi nedeniyle değişiklik yalnız açık okuyucu/statü notuyla yapılır; yeni bir terim yorumu, yöntem ya da kabul sonucu üretilmez. Concepts programının başka dosyaları veya etkin çalışma sırası değiştirilmez.

Concepts INDEX'in özgün 5.801 byte gövdesi yerelde Git blob kimliğiyle eşleştirildi. Yeni dosya yalnız 918 byte / altı başlangıç satırı ekler: **6.719 byte, `e204ebd05dd4868e64c4616c0a9b67521f91ad00`**. Önekten sonraki byte'lar özgün gövdeyle aynıdır; EOF korunur. “Tarihsel” etiketi aktif araştırma programına uygulanmaz. Diğer iki kaynak değiştirilmez.

## 5. Bağlantı ve erişim sınırı

Yeni not D030'un mevcut açık anchor'ına, kök bakım planına ve kullanıcının belirlediği `devos/plan/` adresine yönlenir. Repository içindeki yeni göreli yollar envanterle karşılaştırılır; D030 kimliği korunmuş karar kaydından gelir. Dış planın yeni bir kopyası oluşturulmaz veya ortam bilgileri yeniden doğrulanmış sayılmaz.

Concepts'in kendi içindeki 23 benzersiz dosya hedefine giden 24 göreli Markdown bağlantısı envanterde çözülür. Research/studies'e giden iki gövde bağlantısının alt ağacı henüz açık olduğu için bu tur bu iki hedef için yeni varlık/anchor hükmü verilmez. Yeni not dışındaki bütün eski gövde linkleri veya bağlantılardaki anlam tutarlılığı sağlam ilan edilmez. Arşiv ZIP'i ve erişilemeyen iki A3 kaynağı için bu tur içerik taraması yapılmadı.

## 6. Yayın ve koruma sınırı

Bu dilimin yayın kümesi dört yoldur:

- `concepts/INDEX.md`: yalnız okuyucu/statü öneki;
- `maintenance/2026-09-29-research-installation-separation/A4-PATH-INVENTORY.json`: birleşik, açık eksikleri taşıyan envanter;
- `maintenance/2026-09-29-research-installation-separation/A4-INVENTORY-EXPANSION.md`: bu kapsam ve gerekçe kaydı;
- `REPOSITORY-TRANSITION.md`: mevcut A4'ün ilerleme ve tek devam noktası.

Kök planın A2/A3 tarihçesi, aşamaları ve ilk A4 kaydı korunur. Araştırma gövdeleri, `AGENT.md`, `agent/**`, eski 69-dosya kayıtları, arşiv ve MOVES değişmez; dosya silinmez veya taşınmaz. Yeni envanter yayın öncesi sabit snapshot'tır. Bu yayında değişen dört yolun snapshot'a göre farkı ayrıca izlenir; kendi kimliğini içerdiği sonsuz bir envanter üretilmez.

Yayın adayı ref değildir. Main delta ve yazarlar yayın öncesinde yeniden kontrol edilir; aday farkı yalnız bu dört yolu göstermelidir. Başarılı ref güncellemesinden sonra uzak ref, dosya kimlikleri ve yeni yönlendirmeler geri okunmadan “main'de” denmez.

## 7. Tek devam

**A4: sekiz açık alt ağacın yaprak envanterini tamamlamak; ilk alt ağaç EXP-001.** Sonra kalan içerik/bağlantı taraması ve gerekli arşiv içleri gelir. Bu, EXP-001 diyalog veya mimari çalışmasını yeniden başlatmak değildir. Tamamlanmış alanların kimlikleri aynıysa envanterleri tekrar çıkarılmaz; okuma yapılmamış gövdeler ise yapılmış sayılmaz. A3 iki erişim engeliyle kısmi; A4 açık; A5 henüz yapılmadı.
