# EXP-006 — çalışma kaydının güncel statüsü

**29 Eylül 2026 / D030:** Aşağıdaki v1.9 master plan ve S00–S12 inşa haritası tarihsel kayıttır; bugünkü kurulum sırası veya ChatGPT'nin sonraki işi değildir. DevOS, **Claude Code cloud** üzerinde kurulacak ve çalışacaktır. Kurulumun tek geçerli planı [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devirdeki sürümü **2.1**'dir.

[D030](DECISIONS.md#d030--claude-code-cloud-kurulum-devri) yalnız yeni yetki ve statü geçişini kaydeder; eski B/S1/P1–P6 türetimlerinin anlamı yeniden yazılmaz. Tarihsel bir yerel test, yeni Claude kurulumunun kabul kanıtı olmaz. İlk gerçek SOUL işlerini bu bakım çalışması seçmez.

Bu depodaki yetkili devam [REPOSITORY-TRANSITION](../../REPOSITORY-TRANSITION.md) kapsamındaki araştırma/kurulum ayrımı bakımıdır. DevOS'un canlı işlerini bu WORK'te izlemeyiz; dış plan kopyası üretmeyiz. Claude Code ve DevOS ekibi bu depoyu salt okunur kullanır. Arşiv erişimi ve depo genelindeki son tarama henüz tamamlanmış sayılmaz.

---

## 28 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# EXP-006 — WORK ve master plan

**Plan:** v1.9 — 28 Eylül 2026. **Current:** P5 Codex inşa ve kurulum paketi `P5-1.0.0` hazır; gerçek hedefte inşa başlamadı. [STATE](STATE.md), [HANDOFF](HANDOFF.md) ve [P5-01](work/P5-01-codex-build-installation-package.md) current yetki, sonuç, kaynak ve devri taşır.

**Üst amaç:** SOUL'u geliştirecek ekibin çalışma düzenini ortaya koymak. Bu plan SOUL'un teknik backlog'u değildir; ilk/sonraki gerçek SOUL işlerini ekip keşfeder.

## 1. Korunan zemin

SOUL hedefi → DevOS işi → kabiliyet/sorumluluk → rol/mekanik/insan sınırı → S1 → P1–P6.

| Kapsam | Korunmuş kaynak |
|---|---|
| B1 Ortak entelektüel taban | [B1](work/B1-common-intellectual-baseline.md) |
| B2 Bilgi kapasitesi | [B2](work/B2-information-capacity.md) |
| B3 Aktör kapasitesi | [B3](work/B3-actors-capacity.md) |
| B4 İş kapasitesi | [B4](work/B4-work-capacity.md) |
| B5 Ortam kapasitesi | [B5](work/B5-environment-capacity.md) |
| B6 Dört zeminin ilişkileri | [B6](work/B6-cross-ground-integration.md) |
| B7 İşe göre sistem oluşturma | [B7](work/B7-system-formation.md) |
| B8 Süreklilik/değişim/toparlanma/öğrenme | [B8](work/B8-continuity-change-recovery.md) |
| B9 Bütünleşme ve gerçek sınama | [B9](work/B9-integration-and-testing.md) |

B1–B9 geliştirme sırası veya SOUL modül listesi değildir. [S1](work/S1-role-responsibility-consolidation.md), [S1-17](work/S1-17-consolidation-closure-audit.md) ve [ACTORS](ACTORS.md) ilk R/M ve F/DR lineage'ını taşır. Rol sayısı actor sayısı değildir. S1-16 kaynak-tamlığı qualification'ı S1-17 §7'de korunur.

## 2. Sabit gereksinimler ve son yetki

**Codex builder ve DevOS runtime'ıdır.** D027 eski D011 Claude Code cloud hedefini current açısından supersede eder; D029 builder/runtime ayrımını ve P5'e devamı açıkça bağlar. SOUL'un sağlayıcıdan bağımsızlığı ürün hedefidir, deneysel kabul değildir.

K1 talep→çalışma→yanıt→gerçek kullanım. K2 rutin rol geçişlerinde Batu'nun taşıyıcı/tetikleyici olmaması; başlangıç/yeniden başlatma, gerçek müdahale, yetki ve kabul mümkün. D021 içerik sahibinin anlam/gerekçeyi, düzen tarafının yer/statü/bağ/bulunabilirlik/bakım/devri taşımasıdır. Ürün ve çalışma bilgisi ayrı amaçlı ve ilişkilidir. Foundation gereklilik keşfini, studies örnek/karşı kanıtı besler; dış kaynak talimatı etkin kontrol değildir.

P4 v4 sonrası kullanıcı P5 inşa rehberini istedi. Yüksek kalite; daha fazla sayfa/servis veya kolay örnek başarıları değil, kapsamın korunması, gerekçeli seçim, actual doğrulama ve doğru devirdir. Bu tur hazırlık paketini üretir; gerçek hedef, bütçe, veri ve yayın yetkisi yokken dış kurulum yapmaz.

## 3. Bütün yol

| Aşama | Esas teslimat | Durum |
|---|---|---|
| P1 — Environment gerçekliği | Kaynaklı imkân/sınır ve actual hedef soruları | Claude haritası tarihsel; Codex kaynakları P4/P5'te seçici tazelendi; actual S02 açık |
| P2 — Roller | Amaç/yeterlik/bilgi/teslimat/yetki/tüketici sözleşmeleri | P2/S1 kökeni ve P4 18 profil P5 yönergelerine bağlandı; 18 sürekli agent kararı değil |
| P3 — İş/bilgi/düzen | Keşif, katkı, karar, bakım, kesinti/devir | P4 semantiği P5 komut/bağlam/aşama sözleşmelerine taşındı; canlı yeterlik değil |
| P4 — Bütünleşik tasarım | SOUL yüklerinden mimari ve sınama programı | V4 exact kaynak olarak korunur; yeni P5 teknik farkları ayrı kayıt |
| **P5 — Gerçekleştirme** | Kurulabilir specification/runbook ve sonra actual inşa | **REHBER/PAKET HAZIR; ACTUAL İNŞA NOT_STARTED.** P5-01 current teslim |
| P6 — Hedef sınaması/devir | Gerçek kullanım, bilgi/etki/güvence, recovery ve bilişsel kalite | Yapılmadı. S12 ayrı P6 planına devir yapacak; paket hazırlığı kabul değil |

P1→P2↔P3→P4→P5→P6 bağı korunur. Somut ortam/sözleşme kusuru ilgili varsayımı açar; bütün taxonomy yeniden başlatılmaz. İnşa ilerlemesi ile rehber tamamlanması aynı durum değildir.

## 4. P5 inşa haritası

| Aşama | İnşa/qualification yükü |
|---|---|
| S00 | Kaynak, gerçek target ve yetki; C01–C08 karar kapıları |
| S01 | Tekrar üretilebilir inşa alanı, lock/CI/test girişleri |
| S02 | Gerçek Codex session/tool/child/config/lifecycle deneyi |
| S03 | Gerçek PostgreSQL migration/ACL/concurrency temeli |
| S04 | Yetkili komut kapısı, read-set, claim ve fencing |
| S05 | Typed ilişkiler, ALL/ANY, tamlık ve ACL sorguları |
| S06 | Ortak yönerge, rol ve yöntem release'i; gerçek davranış sınaması |
| S07 | Kaynak/memory/context/dispatch, erişim ve retention |
| S08 | Dayanıklı request/contribution/use, dispatcher ve K1/K2 |
| S09 | Üretim, exact assembly, review ve scoped kabul |
| S10 | Korunan gerçek uzak publication ve unknown effect uzlaştırması |
| S11 | Restore, current authority, eski worker reddi ve kapasite |
| S12 | Birleşik sınırlı commissioning; ayrı P6 planına devir |

Bu tablo düz seri zorunluluğu değildir. Exact dependency grafiği pakette `phases/registry.json` içindedir. Her phase çıktıyı, giriş koşulunu, olumlu/olumsuz testi, durmayı ve geri alma yolunu belirtir. 67 target senaryosu şu an NOT_RUN'dır.

## 5. Teknik seçimler ve açıklıklar

P5 referansı typed application/control plane, PostgreSQL canlı state, private body store, korunan publisher ve restore edilen DB'den bağımsız authority fence, Codex harness adapter'ıdır. Native child'ların function-tool ve miras aldığı MCP sınırı nedeniyle farklı yetki/izolasyon isteyen roller ayrı root session/environment ile ele alınır. Aynı güven sınırındaki helper delegation ayrı yetki veya bağımsız reviewer sayılmaz.

18 rol metni, 6 ortak protokol ve 7 method/skill P5'te yazıldı. Bunların mandatory/optional bağlanması ve release/config değişiminde yeni session gereği ayrı test konusudur. Research `AGENT.md`/`agent/**` değiştirilmedi; passive target kaynaklar aktif Research kontrolü değildir.

Supabase veya başka PG provider, barındırma, bölge, maliyet/veri sınırı, publisher kimliği, RPO/RTO/retention ve acceptance owner C01–C08 ile çözülür. Codex uygulamasını kullanmak programatik API maliyet/veri şartlarının kabulü değildir. Raw key sohbetten istenmez.

## 6. Bu tur yapılan iş ve gerçek kanıt

Tam P4 v4 gövdesi, mandatory repository entry'leri ve v4 sözleşme/manifest kaynakları okundu; ilgili primary platform/PG/GitHub belgeleri ve iki studies paketi seçici geri çağrıldı. Tüm research corpus yeniden okunmuş sayılmaz.

Rehber, 13 phase, 30 mantıksal veri ailesi, 33 komut/şema, yönerge kaynakları, 67 hedef senaryosu ve evidence/package araçları üretildi. **50 yerel paket-araç testi geçti.** Bunlar actual DevOS değildir; v4'ün tarihsel 53 testi bu tur yeniden koşulmadı. Evidence linter en fazla `ELIGIBLE_FOR_REVIEW` üretir; gerçek runner/kanıt doğruluğunu veya owner kabulünü yaratmaz.

PDF 74 sayfa; 1345/1345 metin birimi ve ilgili belge/görsel QA. ZIP 125 dosya; 124 manifest boyut/hash'i ve CRC yeniden açmada eşleşti. V4 original manifest'in 95 girdisi de eşleşti. Kaynak, şema, araç, gerçek native davranış ve kullanıcı kabulü ayrı statüdedir.

## 7. Current devir ve erişim

**Current ZIP:** `EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip`, SHA-256 `40aee0e270e683b12ee7316406dfb2254a7bf64d8aeffcf215dcd6b54b62c36b`. Gerçek gövdeler konuşma ekinde; repository [P5-01](work/P5-01-codex-build-installation-package.md) ve [başlangıç metnini](work/p5/CODEX_START.md) taşır, bütün paketi değil.

**Şimdi:** Hazır P5 paketini kullanıcıya döndür. **Codex devrinde ilk actual iş:** S00, source/target/authority preflight. Mevcut target verilmemişse başka repo seçilmez. C01–C08 sonucu ilgili aşamayı açar; tüm kararları baştan kullanıcıya teknik bulmaca halinde sormak veya yetkiyi varsaymak iki uç hatadır.

Gerçek servis kurma, P6 kabulü ve ilk SOUL backlog'u bu hazırlık tesliminde yapılmadı.

## 8. Değişim izi

v1.0 plan; v1.1 P1; v1.2 P2; v1.3 P3 ve G/Y/D021; v1.4 P4-01; v1.5 SOUL odaklı v2/P4-02.

**v1.6 / 28 Eylül 2026:** Sayfa sınırının kaldırılması, teyitsiz v3 ve kaynak devri P4-03; yeni test yok.
**v1.7 / 28 Eylül 2026:** V3 stres testi/rapor ve sınırlı yerel kanıt P4-04.
**v1.8 / 28 Eylül 2026:** Codex Environment kararı, P4 v4 raporu ve kaynak teslimi P4-05.
**v1.9 / 28 Eylül 2026:** D029 P5 devamı/builder+runtime sınırı; `P5-1.0.0` rehber ve tam kaynak paketi hazır. 50 paket testi ile 67 çalıştırılmamış hedef senaryosu ayrıldı. Actual inşa NOT_STARTED; current devir S00.
