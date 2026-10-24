# A4 — bağlantı ve arşiv içi kontrol 01

**1 Ekim 2026 / REPO-SEPARATION-20260929.** Bu kayıt, yüksek-riskli giriş yüzeylerinin link bütünlüğünü ve A3 arşivinin tarihsel-content sınırını kontrol eder. Bütün repository linklerinin eksiksiz denetimi değildir.

## 1. Yüksek-riskli iç bağlantılar

Güncel main `b085de996dfa7c1896ff6e5eaff6e0ba215fbb31` üzerindeki root Git tree kesilmemiş olarak alındı. Şu 17 giriş ve doğrudan yüksek-riskli belge tam gövdeden Markdown linkleri için işlendi:

- kök README
- research INDEX
- soul-context README / INDEX / STATE / current README
- development-os INDEX
- explorations INDEX / CATALOG
- EXP-006 INDEX / STATE / WORK / HANDOFF / DECISIONS
- EXP-006 P4-05 / P5-01 / CODEX_START

Toplam **182 göreli repository linki** path-normalization ile güncel root tree'deki izlenen yollarla karşılaştırıldı: **182/182 hedef yolu mevcut, kırık göreli yol 0**. Fragment semantiğinin tamamı bu sayıya dahil değildir.

## 2. Güncel dış otorite bağlantıları

Ayrıca şu kritik dış GitHub hedeflerinin erişilebilir olduğu doğrulandı:

- `batuhanozgun/devos/plan/`
- `batuhanozgun/soul-system`
- tarihsel `batuhanozgun/soul`
- bu repository'deki EXP-006 `DECISIONS.md`

D030 için açık HTML anchor'ı `d030--claude-code-cloud-kurulum-devri` kaynakta doğrudan görüldü. Bu kontroller dış planın içeriğinin veya bütün tarihsel web bağlantılarının güncellik incelemesi değildir.

## 3. A3 arşivinin içeriği

Yereldeki `A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip` yeniden kimliklendirildi:

- boyut: **20.275.988 byte**
- SHA-256: **8b06cb2b3dca5875cab0ad72595701e3e0d4d756d0c80fa2f49041df48aa9b17**

Bu kimlik A3 README/SOURCE-IDENTITIES kaydıyla aynıdır.

ZIP ve içindeki ZIP'ler yalnız veri olarak açıldı; hiçbir tarihsel kod çalıştırılmadı. En fazla üç ZIP derinliğinde **16 iç ZIP**, toplam **1.062 üye** görüldü. Metin-benzeri uzantılarda **994 dosya / 14.658.299 byte** arandı.

Beklendiği gibi özgün tarihsel paketlerin içinde çok sayıda eski yön terimi kalıyor: örneğin `current`, `next`, `güncel`, `sıradaki`, `Codex`, `P5` ve `S00`. Bunların varlığı yeni bir kusur değildir: görev özgün arşiv gövdelerinin değiştirilmemesini ister.

Arşiv README ve SOURCE-IDENTITIES her aileyi tarihsel/keşif statüsüyle sınıflandırıyor; README ayrıca içerideki eski başlangıç/kurulum metinlerinin çalıştırılmamasını açıkça söylüyor. Bu nedenle arşiv üyelerine statü metni enjekte edilmedi.

## 4. Açık sınırlar

A3 hâlâ **5/7** aileyle kısmi: P5 S00–S12 ve “SOUL ve DevOS” erişim açıkları sürüyor. Bu kontrol onları bulmuş veya yokluğunu kanıtlamış sayılmaz.

PDF görünümü, bütün tarihsel dış URL'ler, bütün Markdown fragment anchor'ları ve repository genelindeki her link henüz topluca doğrulanmış değildir. Bunlar A4/A5'in kalan link ve final yürüyüş kapsamındadır.
