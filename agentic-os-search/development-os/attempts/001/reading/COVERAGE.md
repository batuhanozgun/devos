> **30 Eylül 2026 — tarihsel DEVOS-001 okuma kapsamı ve yöntem değişikliği kaydı.** Aşağıdaki sayımlar, karşı okuma açıkları ve D1/D2 tasarım rotası 24 Eylül'deki denemeye aittir; bugünkü araştırma kapsamını veya Claude kurucusunun sıradaki işini belirlemez. Eski seri Foundation okuma şartının kaldırılması tarihsel sıra olarak korunur; okunmamış kaynaklar bu notla okunmuş sayılmaz.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. Araştırma katkıları ve özgün metin korunur. Bu bakımın devamı [REPOSITORY-TRANSITION](../../../../REPOSITORY-TRANSITION.md)'dedir; eski okuma veya tasarım görevi yeniden başlatılmaz.

---

# DEVOS-001 — kaynak kapsamı ve tasarımdan kaynağa giriş

**Güncelleme:** 24 Eylül 2026. **Kaynak tabanı:** `batuhanozgun/agentic-os-search@dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb`.
[Güncel iş](../WORK.md) · [METHOD v2](../METHOD.md).

**Yeni kullanım:** Foundation'ın bütün dosyalarını yeniden okuma sayacı değil, gerçek okuma izi ve tasarım sorusundan kaynağa erişim haritası. Okunmamış kaynak okunmuş sayılmaz; Foundation tam yeniden okuması tasarıma başlama önkoşulu değildir. Önceki P1-tamamlanmadan-P2/P3-başlamaz koşulu bu kapsamda kaldırıldı. Oluşmuş kayıtların ortak değerlendirmesi sürer.

## Envanter ve gerçek kapsam

Claude'un kaynak tabanı manifesti [MANIFEST-dc76496.tsv](https://github.com/batuhanozgun/soul-development-os3_claudecode/blob/9866feb1127313394a3d1bd50bfd4b862a91567f/coordination/devos-001/reading/MANIFEST-dc76496.tsv), özeti [MANIFEST-OZET.md](https://github.com/batuhanozgun/soul-development-os3_claudecode/blob/9866feb1127313394a3d1bd50bfd4b862a91567f/coordination/devos-001/reading/MANIFEST-OZET.md), blob `0ab301214960e88129979101d9fedffe198a6e2b`. 2.238 dosya üretici sayımıdır. Research özeti okudu; bütün manifest satırlarını bağımsız uzlaştırmadı.

| Alan | Dosya (üretici sayımı) | Korunan gerçek okuma durumu / yeni kullanım |
|---|---:|---|
| Foundation | 931 | Research F08 + ek ve F00: 18 özgün dosya. Kalan gövdeler bu geçişle okunmuş olmadı; seri yeniden okuma yerine tasarım sorusuna göre derin okuma |
| studies | 893 | Claude 74 birim/kök kaydı; 116 ana oturum tam, 774 alt-ajan okuma/karşı okuma, 2 kısmi, 1 engel. Research tüm kayıtları henüz okumadı |
| concepts | 75 | Claude 9 kayıt; ana oturum tam okuma bildirimi, karşı okuma açık |
| soul-context | 59 | Claude E23 birincil okuma; Research karşı okuma |
| publications | 26 | Claude E23 birincil okuma; Research karşı okuma |
| explorations | 232 | Claude E23 birincil okuma; Research karşı okuma. Son alımda EX0 üç dosya bildirimi; kalan bitişi bu tur doğrulanmadı |
| Başlangıçtaki deneme kayıtları | 10 | Önceki dar denetim hattı tarihsel kanıt; otomatik yeni çalışma kuyruğu değil |
| Giriş | 2 | Root/research INDEX; güncel ve tarihsel kaynak rolleri ayrı |
| Kontrol | 10 | AGENT/agent Research için kontrol; araştırma sonucu veya Claude'a import edilecek kaynak değil |

Sonraki Foundation okuması `01_verticals` dizisini baştan bitirme zorunluluğuyla değil D1/D2 tasarım sorusuyla seçilir. 01/02, 03 zeminler, 04, 05 bileşim, 06/07 ve history/repair kaynakları erişilebilir araştırma olarak korunur; içerikleri bilinmiş sayılmaz. İlgili soru daha derin gövde gerektiriyorsa bu gövde gerçekten okunur. Gerekli derinlikte erişim yoksa ilgili karar açık kalır.

## Foundation girişleri ve kayıtlar

[Foundation STATE](../../../../research/soul-foundations/STATE.md) → [INDEX](../../../../research/soul-foundations/INDEX.md) → [REUSE](../../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md).

| Tasarım sorusu | Başlangıç kaydı | Özgün derin rota |
|---|---|---|
| İşin keşfi, planı, takibi ve devamı | F08-01/02/21; F00-03 | Work INDEX/sentez → gereken alt inceleme; RPD ve iş yönetimi studies kayıtları |
| Sorumluluk, uzmanlık, yetki ve devir | F08-03/10/16/23; F00-01/03 | Actors INDEX/sentez; ilgili örnek sistemin rol/koordinasyon kaydı |
| Bilginin seçimi, bağlam ve fiilî kullanım | F08-05/08/09/21; F00-04/05 | Information → Selection/Exposure, Formation veya Derivation; kullanıma göre ilgili tam metin |
| Gerçek ortam ve birleşik yapılabilirlik | F08-04/06/07; F00-02 | Environment → domain/work conditions; Claude ORT1 ve gerekli güncel ortam kanıtı |
| Etki, değişim, devam ve öğrenme | F08-06/11/12/20/24; F00-06 | Composition → Binding/Standing/Control/Transition; Records/Revision |
| Alternatif ve yapı kararı | F08-13/14/15/17/18/19/22/25; F00-02/05 | REUSE; bütünsel studies paketleri; explorations modelleri ve ilgili özgün kaynaklar |

F08 güncel okuma: [düzeltme/ek](F08-RECONCILIATION.md) + [ilk kayıt](F08-FOUNDATION-FRAME.md). 20 ilk katkı + 5 ek; S07'nin eski tamlık beyanı düzeltildi. [F00](F00-CONTEXT-AND-USE.md): Foundation README, RESEARCH-USE-ALIGNMENT ve 00_context/README tam; altı katkı, karşı okuma açık. 08'in üst sonucu bütün alt araştırmaların okuması değildir.

## Claude kayıtlarına giriş ve açıklar

[Reading kökü](https://github.com/batuhanozgun/soul-development-os3_claudecode/tree/9866feb1127313394a3d1bd50bfd4b862a91567f/coordination/devos-001/reading). Paket rotaları `studies/<paket>/*-paket.md`, birim kayıtları `studies/<paket>/<kod>.md`; concepts `concepts/`, ortam `ortam/ORT1.md`, karşı okuma `karsi-okuma/`. C-003/4/5 exact alındıları önceki WORK'te korunur. Son alımda 4.508 birim katkısı, 39 paket katkısı ve dokuz concepts kaydı bildirilmiştir; sayım kalite veya Research tam okuması değildir.

İki ECC gzip kısmi; ASR görseli erişilemez. O-25 kaydında kullanıcıda da kopya yok; yeniden sorulmaz. Kaynak sorunu çözülmüş veya görsel okunmuş sayılmaz; yazılı temsilin sınırı korunur. Ortam, concepts/paket karşı okumaları ve ortak kayıt tüketimi açık kalır. Dar erişim eksiği her tasarım sorusunu engellemez; etkilediği karar belirtilir.

Kayıt hacmi ve tekrarı yeni özet projesi açma gerekçesi yapılmaz; kayıtlar parçalara bölünmüş okumayla değerlendirilir. Aday META'daki araştırılacak sorular, okuyucu yorumu, kaynağın bulgusu ve yerel deney ayrı tutulur. Kaynak/kayıt görülmeden yalnız bir paket adıyla mekanizma seçilmez.

## İz ve tarihçe

Bu tur yeni Foundation alt-gövde okuması veya yeni katkı çıkarımı yok; REUSE aynı blob'dan tam tekrar okundu. Yöntem değişikliği okuma sayısını artırmaz. [Önceki kapsam](https://github.com/batuhanozgun/agentic-os-search/blob/3c809d9691643b6183bc035cd344f12efb3f4c87/development-os/attempts/001/reading/COVERAGE.md) bütün eski sayım/açıkları korur. Yeni maddi kaynak sürümleri, etkiledikleri tasarım kararına bağlı delta kaydıyla izlenir. Yeni deneme çıktıları kaynak paydasını sonsuz büyütmez.
