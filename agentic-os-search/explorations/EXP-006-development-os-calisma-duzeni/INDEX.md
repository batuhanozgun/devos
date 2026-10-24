# EXP-006 — güncel statü ve tarihsel okuma yolu

**29 Eylül 2026 / D030:** Bu alanın eski DevOS kurulum ve devir yönü tarihseldir. DevOS, **Claude Code cloud** üzerinde kurulacak ve çalışacaktır. Kurulumun tek geçerli planı [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; devirde belirtilen sürüm **2.1**. Bu depoya plan kopyası alınmaz.

[DECISIONS / D030](DECISIONS.md#d030--claude-code-cloud-kurulum-devri) → [STATE](STATE.md) → [HANDOFF](HANDOFF.md) bu statü ayrımını taşır. Research bakımının sıradaki işi [REPOSITORY-TRANSITION](../../REPOSITORY-TRANSITION.md)'dadır; DevOS kurulum işi değildir. Claude Code ve DevOS bu depoyu yalnız okur. ChatGPT başka DevOS/SOUL depolarına yazmaz.

Aşağıdaki eski okuma sırası yalnız tarihsel inceleme içindir. P5 ZIP, CODEX_START veya S00'a işaret etmesi bunları yeniden yürütme yetkisi vermez. B/S1/P2/P3 araştırma ve sorumluluk türetimleri kaynak olarak korunur; bulgu, öneri, kullanıcı kararı ve hedefte gösterilmiş davranış ayrımı değişmez.

---

## 28 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# EXP-006 — Development OS çalışma düzeni

**Üst amaç:** SOUL'u geliştirecek ekibin çalışma düzenini SOUL'un gerektirdiği kabiliyetlerden türetmek.
**Current:** [WORK](WORK.md) v1.9; **P5 CODEX İNŞA/KURULUM PAKETİ HAZIR / GERÇEK KURULUM BAŞLAMADI / P6 YOK.**

## Güncel okuma yolu

AGENT ve gereken kontrollerden sonra:

1. [STATE](STATE.md) — son kullanıcı yönü, current teslim ve gerçek kanıt sınırı.
2. [HANDOFF](HANDOFF.md) — Codex'e veya yeni Research oturumuna doğru devir.
3. [WORK](WORK.md) — B/S1/P1–P6 bağı ve P5 hazırlığı–gerçek inşa ayrımı.
4. [DECISIONS](DECISIONS.md) — D027 Codex, D028 sıra, D029 builder/runtime ve P5 devam yetkisi.
5. [P5-01 — inşa ve kurulum paketi](work/P5-01-codex-build-installation-package.md) — 13 aşama, kaynaklar, gerçek QA, açık seçimler ve dosya kimlikleri.
6. **Gerçek `EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip`** — rehber, sözleşmeler, role/protocol/skill kaynakları, araçlar, testler ve exact P4 v4 tabanı. Tam gövdeler repository'de değildir.
7. [Codex başlangıç metni](work/p5/CODEX_START.md) — paketi targetta S00'dan devralma. Bu pasif proje artefaktı Research agent-control değildir.

Yeni Codex builder paketin README, tam P4 v4 gövdesi, docs, phase registry ve builder talimatlarını okur; mevcut target talimatlarını körlemesine değiştirmez. P5 ZIP bulunmadan repository özetinden eksik komut/kod/rehber uydurulmaz.

## Korunan kaynaklar

| Yüzey | Rolü |
|---|---|
| ACTORS.md ve work/P2-01-named-role-contracts.md | İlk aile/rol sözleşmeleri ve türetim izi; 18 sürekli agent kararı değil |
| work/P3-01-work-information-discussion.md | G/Y, içerik–düzen, bakım ve H1–H6 kavramsal bağları |
| work/P4-01-cloud-runtime-and-workspace-design.md | Eski teknik baseline; current mimari veya next-work değil |
| work/P4-02-soul-derived-report-v2.md | Tarihsel v2 teslimi, kaynak kimliği ve sınırlı test kanıtı |
| work/P4-03-unbounded-stress-test-handoff.md | Önceki yarım v3 ve kaynak devri |
| work/P4-04-unbounded-stress-test-report-v3.md | V3 stres testi/kanıt tabanı |
| work/P4-05-codex-environment-revision-v4.md | P4 Codex revizyonu; P5 için kaynak, bugünkü next değil |
| work/P5-01-codex-build-installation-package.md | Güncel inşa şartnamesi/kaynak teslimi; actual kurulum değil |
| work/P1-01-claude-cloud-environment-map.md | Tarihsel Claude haritası; D027 sonrası current hedef değil |
| sources/U001.md, sources/U002-cloud-plan-and-autonomy.md, EXP-006_Context | Amaç/kısıt/yöntem kaynakları; tarihsel next ifadeleri current sıra değil |
| work/B*.md, work/S1-*.md, history/ | İş/sorumluluk türetimi; normal devirde körlemesine yeniden yüklenmez |

Codex builder ve DevOS runtime'ıdır; SOUL sağlayıcı taşınabilirliği bir tasarım hedefi olarak korunur. Rehberin hazırlanması, hedef testlerin geçtiği veya uygulamanın kurulduğu anlamına gelmez. Sonraki nokta gerçek paketle S00; target/bütçe/yetki olmadan dış kurulum yoktur. Agent-control değişmedi.
