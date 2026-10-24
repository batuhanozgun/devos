> **29 Eylül 2026 — kavramsal denemeler ile tarihsel DevOS kurulumunun ayrımı.** Bu alan kavramsal çalışma ve öğrenme kütüphanesi olarak korunur; bütün explorations tarihsel kurulum sayılmaz. Altıncı paket [EXP-006](EXP-006-development-os-calisma-duzeni/INDEX.md), SOUL'dan DevOS sorumluluklarının türetimini ve eski P4/P5 teslimlerini taşır; o paketin eski kurulum ve sonraki iş yönleri tarihseldir. Diğer denemelerin kendi kabul ve kanıt statüleri değişmez.
>
> [D030](EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) sonrasında DevOS Claude Code cloud'da kurulacak ve çalışacak; tek geçerli kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1), yeni ürün [soul-system](https://github.com/batuhanozgun/soul-system)'dir. Claude Code ve DevOS bu depoyu yalnız okur. Aşağıdaki araştırma ve eser okuma yolları bilgiye erişim içindir; kurulum görevi vermez. Ayrım bakımının devamı [REPOSITORY-TRANSITION](../REPOSITORY-TRANSITION.md)'dadır.

---

# Düşünce ve Model Denemeleri

**Alan:** `explorations/` — `agent/` ve `research/` ile aynı seviyede, araştırmadan ayrı çalışma kütüphanesi.

Burada kullanıcı ile assistant'ın araştırmaları ve kendi düşüncelerini kullanarak yaptığı beyin jimnastikleri, kavramsal provalar, örnek modeller, sentetik demolar ve bunların değerlendirmeleri korunur. Amaç yalnız son cümleyi değil, ona nasıl gelindiğinin görünür diyalog izini ve değişen görüşleri geri bulabilmektir.

## Okuma yolu

[CATALOG.md](CATALOG.md) → seçili paketin INDEX/STATE dosyası → konu haritası veya öğrenme kaydı → özgün konuşma, eser ve araştırma kaynağı.

Yeni paket düzeni: [PACKAGE-CONTRACT.md](PACKAGE-CONTRACT.md).

İlk paket: [EXP-001 — SOUL'un çalışma modeli](EXP-001-soul-calisma-modeli/INDEX.md).

İkinci paket: [EXP-002 — SOUL'un baz yapısı ve ortak entelektüel tabanı](EXP-002-soul-baz-yapi-ve-entelektuel-taban/INDEX.md).

Üçüncü paket: [EXP-003 — Ek hafıza ve araştırma temelli güvenilirlik](EXP-003-ek-hafiza-ve-arastirma-temelli-guvenilirlik/INDEX.md). İşlem–nesne–mekanizma ayrımları, seçici erişim, Foundation/studies kullanımı ve daha sağlam yapı hedefi; gerçekleşmiş mimari/üstünlük değil. Önceki ölçülmemiş puanlar ayrı nitelendirmelerle korunur.

Dördüncü paket: [EXP-004 — Genişleyen SOUL ve büyük-iş stress testi](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/INDEX.md). **2026-09-21 / BOUNDED-COMPLETE / USER-EVALUATED / CLOSED.** Kullanıcı exploration'ın kapatılmasını ve sonraki konuşmalar için korunmasını istedi. Somut sonuç [MS01 SOUL çalışma sistemi taslağı](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md), iki senaryonun mekanizma yürüyüşü ve [araştırma→mekanizma eşlemesidir](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/artifacts/MS01-RESEARCH-TO-MECHANISM-MAP.md). Kapanış, nihai SOUL mimarisini veya gerçek yeterliği kabul etmez; G01–G07 sonraki çalışmalar için açık dayanaklardır. Güncel kabul kapsamı ve yeniden kullanım yolu [STATE](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/STATE.md)'tedir; otomatik sonraki EXP-004 işi yoktur.

EXP-004'ün korunan test birikimi T1–T15; Mission/Work keşfi, rol→Actor, bağlam, gerçek etki, qualification/kabul, süreklilik, kontrollü uyarlama, ortak koşullar, yeni katılımın kapsamı ve gerekçeli ilerleme. [T09](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T09-CONCURRENT-CHANGE-AND-SHARED-CONSTRAINTS.md) eşzamanlı değişimi, [T10](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T10-EXTENSION-ADMISSION-AND-CONTROL-COVERAGE.md) yeni katılımı, [T11](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T11-EVIDENCE-SUFFICIENCY-AND-BOUNDED-PROGRESS.md) kanıt yeterliliği/araştırma maliyeti/sınırlı kapanışı, [T12](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T12-NOVEL-FORMATION-AND-FIRST-WRITABLE-WORK.md) romanın ilk yazılabilir işini, [T13](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T13-NOVEL-SEMANTIC-REVISION-AND-IMPACT.md) büyük yaratıcı değişikliğin anlamsal etkisini, [T14](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T14-NOVEL-READING-COVERAGE-AND-JOINT-CONTEXT.md) uzun eserde bölüm/ilişki kapsaması ve ortak değerlendirme bağlamını, [T15](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/continuations/T15-NOVEL-EDITORIAL-DISAGREEMENT-AND-CHOICE.md) editoryal anlaşmazlık, yaratıcı tercih ve gerekçeli kapanışı işler. SY01 ve DQ01–DQ04 bu birikimi mekanizma sentezine taşıyan tamamlanmış girdilerdir. Türetilmiş notlar kaynak sayımını artırmaz; mikro-metin örnekleri tam roman veya okur deneyi değildir. U016'nın yatay/dikey kapsama ve branch açıklaması araç/mimari kararı değildir. Aday nesneler benimsenmiş mimari sayılmaz. [Onarım kaydı](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/checks/REPAIR-20260921.md) kapanmış arşiv onarımının içerik/yayın/kontrol durumunu taşır; exploration kapanışıyla aynı olay değildir.

Birlikte okuma: [EXP-001 → EXP-002 → EXP-003 → EXP-004](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/retrieval/CUMULATIVE-READING.md). Adreslenen kesim 37 + 37 + 21 + 31 = **126 mesajdır**; sayı bağımsız kaynak sadakati garantisi değildir. EXP-004 görünür tam kaynakları ve eski yoğunlaştırılmış görünümleri ayrı bulundurur. Sonraki devam notları ve MS01 kaynak transkripti sayılmaz; güncel yola STATE/INDEX yönlendirir. Önceki üç paketin kaynak/aktarımı bu kapanışta yeniden denetlenmedi. Önceki [üç-deneme yolu](EXP-003-ek-hafiza-ve-arastirma-temelli-guvenilirlik/retrieval/CUMULATIVE-READING.md) 95 mesajlık, [iki-deneme yolu](EXP-002-soul-baz-yapi-ve-entelektuel-taban/retrieval/CUMULATIVE-READING.md) 74 mesajlık kapsamıyla korunur. Konsolidasyonlar kaynak yerine geçmez; eser incelemesi diyalog okumasından ayrıdır.

Beşinci paket: [EXP-005 — İhtiyaç keşfi ve çalışma disiplini](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/INDEX.md). **İptal edilen geliştirme girişiminden dersler; araştırma sorusu açık.** Görsel/kapsam sorusundan başlayan diyalog, erken motor teşhisi, mevcut RPD, Codex'e devir, kaynak erişimi/yayın sorunları, sınırlı v1/v2 raporu ve kullanıcının iptali korunur. [95 görünür kaynak mesaj](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/sources/conversation/INDEX.md), [özgün görev eseri](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/artifacts/DEVOS02-NEED-DISCOVERY-20260922.md) ve [dersler](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/reflections/LESSONS-AND-OPEN-QUESTIONS.md) ayrıdır. Plan belgesinin varlığı fiilî hazırlık değildir; dört vakalık eşit sonuç genel yeterlik değildir. [STATE](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/STATE.md) aktarım/yayın sınırını ve iptali taşır. [Beş-deneme okuma yolu](EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/retrieval/CUMULATIVE-READING.md) önceki paketleri değiştirmez. Arşivleme eski DevOS görevini yeniden yetkilendirmez.

## Sınırlar

- Deneme, gerçek ajan deneyi veya bilimsel doğrulama olmak zorunda değildir. Türü ve kanıt seviyesi paket içinde belirtilir.
- Konuşmada benimsenen çalışma tercihi, Foundation bulgusu ve kabul edilmiş mimari kararla aynı şey değildir.
- Buradaki yönerge örnekleri çalışma malzemesidir; `AGENT.md` yerine geçmez.
- Öğrenme, önceki konuşmayı otomatik olarak haklı çıkarma değildir. Geri çekilen görüşler ve karşı örnekler korunur.
- Yeni denemeler eski kaynakları yeniden yazmaz; yeni kimlik ve açık türetim ilişkisiyle eklenir.
- Kullanıcı bu alanı araştırma dışında özellikle yetkilendirmiştir. Candidate-study kütüphanesine sahte bir araştırma kaydı eklenmez.

## Yeniden kullanım

Bir sonraki deneme, hangi önceki kayıttan neyi devraldığını ve neyi yeniden sorguladığını belirtir. EXP-002'nin [devir haritası](EXP-002-soul-baz-yapi-ve-entelektuel-taban/sources/PREDECESSOR-EXP001.md), EXP-001 ile bu ilişkiyi kaynak seviyesinde kurar. EXP-003'ün [öncül kaydı](EXP-003-ek-hafiza-ve-arastirma-temelli-guvenilirlik/sources/PREDECESSORS.md) uzmanlık sürekliliği ve ortak entelektüel taban ile ek hafıza konuşmasını bağlar; gerçek okuma derinliğini ayrıca belirtir. EXP-004'ün [öncül kaydı](EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/sources/PREDECESSORS.md) bu zinciri büyük-iş çalışma sistemi stress testine taşır. Tamamlanmış MS01, sonraki denemelerde araştırma dayanaklarıyla devralınabilir, sorgulanabilir veya değiştirilebilir; eski teslimatlar otomatik yeni iş kuyruğu yapılmaz.

Araştırma ihtiyacı doğarsa araştırma ayrı yetkilendirme ve kendi paketinde yürür. Mimari benimseme de ayrı karardır. Denemelerin topluca okunması Development OS hazırlığını besleyebilir; bu okuma tek başına kurulum veya yeni araştırma yetkisi değildir. Gerçek geçişte güncel proje/target state'i ayrıca ele alınır.

Bu dosya kütüphanenin okuma ve kayıt semantiğini açıklar; yeni agent-control protokolü değildir.
