# Research → Architecture Boundary — context evidence

**Status:** context evidence; not research-method policy  
**Date:** 2026-08-30

## Question

İncelenen SOUL/predecessor kaynakları research/evidence ile architecture/work decision arasındaki sınır hakkında ne söylüyor?

## 1. Direct SOUL governance

Primary SOUL Development OS kaynaklarında sınır açıktır:

- `ROLE_MODEL.md`: Researcher external/empirical evidence üretir; finding'i sessizce architecture decision'a çeviremez ve conflicting evidence'i saklayamaz.
- `EVIDENCE_TEMPLATE.md`: evidence question, source/method, supported findings, limitations, `what this does NOT prove` ve decision relevance taşır; proper decision process olmadan architecture decision ilan etmez.
- `DECISION_POLICY.md`: **Research is not decision.** Architecture commitment ayrı decision/review state transition'ıdır.

Bu nedenle direct source model:

**research/evidence → decision relevance**

olup

**research/evidence → automatic architecture truth**

değildir.

## 2. KEEL/current tools default SOUL schema değildir

SOUL `development/02_architecture/README.md`, KEEL'i evidence/prior-art olarak konumlar; default architecture schema olarak değil.

Current roadmap da definition/capability/failure work'ünü technology/component selection'dan önce koyar. Bu, önceki mekanizma veya mevcut tool affordance'ın problemi peşinen tanımlamaması gerektiğini destekler.

## 3. Evidence types are non-substitutable

İncelenen SOUL work/verification/adversarial-review zinciri şu ayrımları destekler:

- verifier conformance PASS ≠ adversarial/frame robustness,
- historical replay ≠ generalisation,
- same-model/multi-agent agreement ≠ independent ground truth,
- producer/tool success ≠ proof.

Bu, bir evidence yolunun diğerinin yerine sessizce geçmemesi gerektiğine dair güçlü context kanıtıdır.

## 4. Work-selection lesson

SOUL Development OS içindeki WP-021/WP-022 hattı material result'ın otomatik olarak repair-shaped next work'e dönüşmesini problemleştirir.

Kaynak statüsü önemlidir: bu hat development-process design evidence/candidate discipline'dir; accepted SOUL product governance olarak kullanılmaz.

Context açısından taşıdığı ders şudur:

**bir bulgunun material olması, hangi sonraki iş türünün yetkili/doğru olduğunu tek başına belirlemez.**

## 5. Predecessor prior-art

`keel-research/PROMOTION.md` tarihsel olarak araştırma sinyalleri ile product promotion'ı ayırır. Bu SOUL authority değildir; ancak SOUL'un direct governance'ında bağımsız biçimde görülen epistemic-signal ≠ product-work ayrımının predecessor örneğidir.

## 6. Context sonucu

İncelenen kaynakların en güvenli ortak sonucu:

- research finding ≠ requirement,
- requirement/capability hypothesis ≠ mechanism,
- mechanism candidate ≠ accepted architecture,
- verification PASS ≠ adversarial robustness,
- historical success ≠ generalisation,
- evidence producer ≠ acceptance authority.

Bu dosya bu sınırı **bilgi olarak** kaydeder.

## Neyi belirlemez?

Bu dosya şunları belirlemez:

- SOUL Research'te kullanılacak canonical package schema,
- canonical stopping rule,
- project-wide research methodology,
- future architecture promotion workflow'unun exact biçimi.

Bu sorular hakkında bu konuşmada erken üretilmiş fikirler `../exploratory/research-method-implications.md` altında ayrı tutulur ve source evidence olarak yüklenmez.
