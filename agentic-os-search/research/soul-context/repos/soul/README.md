# `soul` — tarihsel denemenin okuma defteri

**29 Eylül 2026 statü notu:** `batuhanozgun/soul`, 25–29 Ağustos dönemindeki eski DevOS/SOUL denemesinin tarihsel kaynağıdır; bugünkü SOUL ürün deposu veya güncel proje otoritesi değildir. Yeni ürün deposu [batuhanozgun/soul-system](https://github.com/batuhanozgun/soul-system); geçerli DevOS kurulum planı [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devir sürümü **2.1**, ortam **Claude Code cloud**'dur.

Eski repo olduğu gibi kalır; bu bakım ona yazmaz. Aşağıdaki kaynak kimlikleri, okuma kapsamı, tarihsel bulgular ve kanıt sınırları değişmez. “Current explicit intent”, “branch current”, “kuruluyor” veya “şu anda” ifadeleri eski okuma dönemine aittir; yeni ürüne uygulama görevi ya da yetki vermez. Tarihsel statü, gözlemi hipoteze veya öneriyi kabul edilmiş mimariye dönüştürmez.

Yetki izi: [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri). Araştırma bağlamı [STATE](../../STATE.md)'ten; bu bakımın devamı [REPOSITORY-TRANSITION](../../../../REPOSITORY-TRANSITION.md)'dan okunur.

---

## Önceki kaynak defteri — araştırma içeriği; güncel kurulum talimatı değildir

# soul — okuma defteri

Repo: `batuhanozgun/soul`  
Rol: SOUL'un current explicit intent'i + Development OS'nin birincil kuruluş/işletim kanıtı  
Statü: **source ledger; current next-action authority değildir**

## Repo yalnız `main` değildir

İlk okumada default `main` dalında yalnız `README.md` görülmüş ve repo küçük kabul edilmişti. Bu hüküm yalnız `main` görünümü için doğrudur.

Dal taramasında çok sayıda `work/*`, `verify/*`, `review/*`, `audit/*` ve özellikle `phase0/development-os` dalı bulundu. Bu nedenle SOUL yalnız explicit-intent anchor değil, kendi geliştirme işletim sistemine dair birincil context kaynağıdır.

## Okuma kaydı — `main`

| Kaynak | SHA / commit | Tür | Maddi bulgu |
|---|---|---|---|
| `README.md` | `9dbded30` | full | SOUL first principles'tan general-purpose agentic architecture olarak yeniden kuruluyor; intended outcome → controlled, verifiable working system; `development/` ile `system/` ayrı; ilk paket Development OS |
| bootstrap commit | `7b2a9a4` | full diff | 2026-08-25'te yalnız README ile bilinçli yeniden başlangıç |

## Okuma kaydı — `phase0/development-os`

### Development OS amacı

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `development/README.md` | `e6a87f70` | full | SOUL geliştirmesini session length/context loss/model memory/single-model self-evaluation/undocumented decisions/unverified output'tan bağımsızlaştırmak; fresh session repo state'inden cold-start edip bounded work + evidence + handoff yapabilmeli |
| `development/00_foundation/VISION.md` | branch current | full | SOUL preset workflow/team/template değil; intended outcome için gereken çalışma sistemini kurabilen general-purpose agentic system |
| `development/00_foundation/DEFINITION.md` | branch current | full | SOUL'un işi `system formation`: outcome'u anla → gereken sistemi belirle → capability'leri kur/organize et → işlet → doğrula → adapt et → continuity/governance/state'i koru |
| `development/00_foundation/NON_NEGOTIABLES.md` | branch current | full | outcome-first, least privilege, independent verification, evidence-before-closure, explicit external state, governed capability acquisition, repair/adaptation, no hidden owner orchestration, fail-visible, scale-appropriate control, durable traceability |
| `development/00_foundation/SUCCESS_CRITERIA.md` | branch current | full | cold-session reconstructability, governance-before-product architecture, failed verification blocks closure, unresolved decisions visible, missing capability governance, recovery/adaptation, low hidden-owner orchestration, unbounded governance growth yok |

### İlk work/verification zinciri

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `development/04_work/WP-000-DEVELOPMENT-OS.md` | `6f5042ec` | full | SOUL'u uzun fresh-session'larda tek chat/model memory/producer self-certification'a bağlı olmadan tasarlayacak durable repo OS. KEEL klasör mapping'i ve product architecture Phase 0 non-scope |
| `development/04_work/WP-001-PHASE0-VERIFICATION.md` | `5f0b5bf3` | full | fresh verifier WP-000'ı exact commit'e karşı bağımsız değerlendirir; repair yapamaz; tarihsel sonuç `FAIL` |
| `development/06_reviews/VERIFICATION-WP-000-2026-08-25.md` | `d95f4507` | full | cold-start read-order çelişkisi ve stale duplicated `NEXT_SESSION` yüzünden 9/11 criterion PASS olsa da overall FAIL korunmuş |

### Predecessor repoların SOUL'a açık aktarımı

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `development/05_evidence/REASONING-POLICY-SYNTHESIS-2026-08-26.md` | `fa9b281e` | full | KEEL-Work, keel-dev, oyun2, os-architect ve keel-research SHA'larıyla okunmuş; source-derived principles ile SOUL-specific synthesis decisions ayrı tutulmuş |

Doğrudan taşınan tekrar eden principles arasında project truth'ın chat/model memory dışında yaşaması; objective/method/state/evidence/decision authority ayrımı; observation/inference/assumption ayrımı; producer/tool/retrieval non-proof; plan/mekanizma/tool'un privileged default olmaması; framing/necessity/alternative/falsification checks; owner-vs-technical authority ayrımı; double-cause failure analysis; observable/mechanical controls; proportional reasoning depth; independent exact-target verification bulunuyor.

SOUL-specific synthesis bu ilkeleri predecessor klasör/ritüellerini kopyalamadan yeni Development OS kararlarına dönüştürüyor.

## Research → architecture boundary için okunan direct SOUL kaynakları

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `development/01_governance/DECISION_POLICY.md` | `d26c1739` | full | Explicit: **Research is not decision**. Architecture decision ayrı ADR + review path'ine tabi |
| `development/05_evidence/EVIDENCE_TEMPLATE.md` | `ecbdb486` | full | Evidence question/source/method/findings/limitations/`what this does NOT prove`/decision relevance taşır; proper decision process olmadan architecture decision ilan etmez |
| `development/01_governance/ROLE_MODEL.md` | `f1b704bf` | full | Researcher evidence kurar; conflicting evidence'i saklayamaz ve finding'i architecture decision'a çeviremez |
| `development/01_governance/REASONING_POLICY.md` | `94f5368e` | full | primary/authoritative source, freshness, disagreement/limitations, similarity≠equivalence, popularity≠quality, tool/framework≠problem definition, analytical provenance |
| `development/02_architecture/README.md` | `a0a0d63a` | full | KEEL evidence/prior-art; default SOUL schema değil |
| `development/03_plan/ROADMAP.md` | `831d34dd` | full | definition/capability/failure work technology choice'tan önce; KEEL organisation Phase 2 taxonomy'si değil |

## Verification ve adversarial challenge ayrımı

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `WP-005-DEVELOPMENT-REASONING-POLICY.md` | `74240dfd` | full | predecessor synthesis'ten canonical reasoning policy; builder checks proof değil |
| `WP-006-PHASE0-REASONING-REVERIFICATION.md` | `71736914` | full | exact-target verification current kriterlerde PASS; ayrı adversarial review hâlâ gerekli |
| `WP-007-PHASE0-ADVERSARIAL-REVIEW.md` | `1be6e582` | full | WP-006 PASS sonrası yeni F-AR-001; overall `Requires repair`; conformance PASS frame robustness değil |

## Work-selection / pre-build lifecycle evidence

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `WP-021-DEVELOPMENT-LIFECYCLE-WORK-SELECTION-IMPROVEMENT.md` | `79442e5e` | full | material evidence/failure otomatik repair-shaped work olmamalı; doğru next unit of work ayrıca seçilmeli; research evidence gap olduğunda açılır ve evidence olarak kalır. Current stage design revision/candidate process evidence |
| `WP-022-WP021-DEVELOPMENT-LIFECYCLE-PREBUILD-ADVERSARIAL-REVIEW.md` | `5fc8d7e0` | full | implementation öncesi exact-target adversarial review; review ve replay birbirinin yerine geçmez; result `Requires design revision` |
| `PREBUILD-ADVERSARIAL-REVIEW-WP-021-acf6ddc6-2026-08-29.md` | `3926b33e` | full | F-AR-009..012: acceptance/finding disposition circular-or-unowned; bundled replay component necessity'sini identify edemez; selective-context omission detection yok; rollback contract'sız |

## Şu anda source-temelli söylenebilenler

### SOUL ürün yönü — birincil kaynakla destekli

SOUL bir workflow template veya KEEL'in genelleştirilmiş kopyası olarak tanımlanmıyor. Intended outcome'u alıp o outcome için gereken controlled working system'i oluşturma/işletme/doğrulama/adapt etme yönünde general-purpose agentic operating architecture olarak çerçeveleniyor.

### Development OS amacı — birincil kaynakla destekli

SOUL'u tasarlama süreci, SOUL'un çözmeye çalıştığı failure class'ları kendi içinde yeniden üretmemeli. Bu nedenle product architecture'dan önce repo-authoritative, cold-startable, bounded, independently verified, fail-visible development OS kuruluyor.

### Tarihsel bağ — birincil kaynakla destekli

SOUL Phase 0 predecessor alanlardan aldığı reasoning/governance principles'ı SHA seviyesinde belgeliyor; bağ yalnız benzerlik veya tarih sırası değil.

### Research ↔ architecture sınırı — birincil SOUL kaynaklarıyla destekli

Research/evidence architecture decision değildir; architecture etkisi ayrı decision/work-selection/review state transition'larından geçer.

## Ledger sınırı

Bu dosya source/read evidence taşır. Daha önce bu ledger'ın sonunda üretilmiş formal research-package, stopping, dimension/holdout ve `sonraki okuma` soruları current ledger'dan çıkarılmıştır. Bunlar source evidence değil, erken exploratory steering'di; ilgili kısımlar `../../exploratory/` altında ayrı statüde yaşar veya Git history'den recover edilebilir.
