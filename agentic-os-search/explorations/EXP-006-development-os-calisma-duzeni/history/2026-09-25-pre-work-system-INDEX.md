> **30 Eylül 2026 — tarihsel INDEX okuma yolu; güncel kurulum talimatı değildir.** Aşağıdaki çalışma yönü 25 Eylül 2026 anlık görüntüsüne aittir. [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) sonrasında DevOS kurulumunun tek geçerli planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; buradaki eski yetki ve sonraki iş devralınmaz.
>
> Özgün gövde değiştirilmeden korunur; tarihsel bulgu ve kalite gereksinimleri topluca geçersiz sayılmaz. Göreli bağlantıları eski konumuyla okumak için [aynı gövdenin sabit tarihsel sürümünü](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/INDEX.md) kullanın. Bu da tarihsel kaynaktır, güncel talimat değildir. Kaynak eşliği ve bağlantı sınırı [history girişinde](README.md#historical-source-map) açıklanır.

---

# EXP-006 — Development OS'un çalışma düzeni

**Tür:** Açık kavramsal diyalog; önce aktörler.  
**Açılış:** 25 Eylül 2026.  
**Amaç:** SOUL'u yaratma işinin düşünme, üretme, bilgi ve iş sürekliliği ihtiyaçlarından hareketle Development OS'un nasıl olması gerektiğini karşılıklı konuşarak geliştirmek.  
**Statü:** Aktör sayısı, rol dağılımı veya mimari kabul edilmedi.

## Okuma yolu

1. [STATE](STATE.md): güncel soru, yetki, assistant önerilerinin statüsü, konuşma planı ve sonraki sorumluluk.\n2. [EXP-006_Context](EXP-006_Context): konuşmanın yönünü, birlikte çalışma metodolojisini ve drift önleyici bağlamı korur.\n3. [EXP-006 Work Map](EXP-006_Work_Map.md): aktif B1–B9 Work haritasını ve katman katman açılımını taşır.
4. [U001](sources/U001.md): kullanıcının beş gerekçesi ve aktörlerden başlama talebinin görünür kaynak aktarımı.
5. Aşağıdaki önceki birikim ve araştırma yolları: mevcut sorunun gerektirdiği derinlikte yeniden kullanım.

Bu paket Development OS kurulum denemesi veya yeni candidate study değildir. Önceki birikimden yararlanmak, eski kadroları ve görevleri tekrar yürürlüğe koymak anlamına gelmez. Konuşmada düşünülen yapı ile kabul edilen karar ayrıdır.

## Önceki birikimle ilişki

- **EXP-001–004 / builds_on, kapsamı seçici:** [Explorations kataloğu](../CATALOG.md) ve [EXP-004'ün birikimli okuma yolu](../EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/retrieval/CUMULATIVE-READING.md) önceki plan, bilgi, aktör ve çalışma sistemi düşüncelerine giriş sağlar. Bu açılışta dört konuşmanın tamamı okunmuş değildir; geçmiş kaynaklar değiştirilmedi.
- **EXP-002 / clarifies, questions:** [INDEX](../EXP-002-soul-baz-yapi-ve-entelektuel-taban/INDEX.md) ve [LEARNINGS](../EXP-002-soul-baz-yapi-ve-entelektuel-taban/reflections/LEARNINGS.md) tam okundu. Özellikle L02–L03 rol/model ayrımı, L05 ihtiyacın çalışma sırasında keşfi, L07/L09 bilgi erişimi ile kullanımı ve L12 Development OS'un SOUL'u yaratma amacı. Eski örnek aktör sayıları yeni ekip kararı değildir. Birebir geçmiş ifade gerektiğinde bu notların bağladığı kaynak mesajlara dönülür.
- **EXP-005 / builds_on, contrasts_with:** [Dersler](../EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/reflections/LESSONS-AND-OPEN-QUESTIONS.md) dosyasının açılışı ve 1–5. bölümleri okundu; daha sonraki bölümler tam okundu iddiası yoktur. Erken çözüm/motor teşhisi, planın varlığı ile fiilî hazırlığın ayrımı ve kullanıcının üstlendiği gizli koordinasyon yükü bu konuşmada yeniden dikkate alınır. Kaynak konuşmanın tümü yeniden okunmadı; iptal edilmiş girişim tekrar başlatılmaz.
- **DEVOS-002 / context only:** [Güncel deneme kaydı](../../development-os/attempts/002/README.md) üzerinden amaç, kullanıcının kısıtları ve varsayım denetimi durumu geri kazanıldı. Bu EXP ayrı konuşma hattıdır; Mac arızası, cloud kurulumu, ECC uygunluğu veya hosting sorusu şimdi yürütülmez.

## Foundation ve studies kullanım izi

Açılışta [Foundation STATE](../../research/soul-foundations/STATE.md), [DISCUSSION-HANDOFF](../../research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md) ve [REUSE](../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md) tam okundu. [Actors INDEX](../../research/soul-foundations/03_ground-deepening/grounds/actors/INDEX.md) ve [Actors STATE](../../research/soul-foundations/03_ground-deepening/grounds/actors/STATE.md) tam okundu; bütün Actors korpusunun veya bütün Foundation'ın tam okunduğu iddia edilmez.

Bu turdaki katkı: dört zemin dört ayrı agent değildir; rol ihtiyacı ayrı AI gerektirmez; aktörün sorumluluğu/yetkisi/yeterliği aynı şey değildir. Kullanıcı dahil gerçek geliştirme katılımcılarını, onların üstlenebileceği sorumluluklardan ayrı düşünmek için kullanıldı. Sonraki yük taşıyan araştırma hükmünde ilgili sentez ve kaynaklara daha derin inilir.

[Studies kataloğunun](../../research/studies/CATALOG.md) başlangıcı ve ilgili satırları seçici okundu. [Multi-agent patterns META](../../research/studies/multi-agent-patterns/META.md) tam; [assessment](../../research/studies/multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md) dosyasının 1–7. bölümleri ve 8. bölümünün görünen başlangıcı okundu. Bu eski çalışma, görev/rol sayısını aktör sayısına çevirmemek ve başka modelin aynı sonuca varmasını bağımsız doğrulama saymamak için düşünce girdisidir. İçindeki tarihsel Development OS kadrosu, SOUL mimari adları ve o tarihteki yetki bu konuşmaya taşınmaz. Çalışmanın tamamı veya güncel ürün davranışları yeniden doğrulanmadı.

Gstack'ın katmanlı okuma örneği U001'de korunur. Gstack yöntemi bu açılışta ayrıntılı yeniden incelenmedi veya yeni sistemin bilgi mimarisi olarak seçilmedi; bilgi sürekliliğini konuşurken kendi araştırmasına dönülebilir.

## Arşiv ve yetki sınırı

Bu yalnız başlangıç paketidir; kapanmış konuşma, canlı ajan deneyi, bağımsız doğrulama veya kurulu Development OS değildir. Kaynak U001 ile türetilmiş STATE notları ayrıdır. Yeni turlar ortaya çıktıkça konuşma ve görüş değişiklikleri kendi statüleriyle korunur. Agent-control, Foundation, studies, concepts veya diğer denemeler bu paket nedeniyle değişmez.
