# Multi-Agent Patterns — Okuma ve kalıcı çıkarım durumu

2026-09-20, **B6-T12 / SOURCE-READ-COMPLETE / DURABLE-EXTRACTION-COMPLETE / PACKAGE-COMPLETE**.

Bu dosya `research/studies/multi-agent-patterns/` paketinin concepts programı açısından gerçek kaynak/okuma hesabını taşır. Kaynak package'in ayrı `STATE.md` veya `INDEX.md` dosyası yoktur; bunu eksik diye tahminle tamamlamıyoruz. Package'in current sınıflandırması ve entry-point semantiği `META.md` içinde verilir.

## 1. Kaynak kimliği ve kapsam

- Repository: `batuhanozgun/agentic-os-search`
- B6-T12 başlangıç main: **ee763da635d8b147ddcbdf787a22a7dd3edc8d2f**
- Kaynak yolu: `research/studies/multi-agent-patterns/`
- Paket türü: `focused-topic`
- Source-study status: triggering conversation için exploratory systems assessment complete; Foundation veya architecture'a promote edilmemiş.
- Architecture / implementation authority: yok.
- Concepts girişi: [TERMS.md](TERMS.md)

Package current main'de üç metin dosyasından oluşur:

1. `META.md`
2. `CONVERSATION-SYNTHESIS.md`
3. `SOUL-DEVELOPMENT-OS-ASSESSMENT.md`

`META.md` explicit olarak ayrı package `STATE.md` bulunmadığını söyler. Bu nedenle başka study'lerdeki META→STATE→INDEX düzeni burada zorla varsayılmaz.

## 2. Dosya envanteri ve gerçek okuma

| Kaynak | Blob SHA | B6 okuma |
|---|---|---|
| `META.md` | `9ac3239bee023a83f50c2d0b942bcc0934baa7d1` | FULL |
| `CONVERSATION-SYNTHESIS.md` | `23e0514b8277cab32785f18ce6faca6fd0a7114c` | FULL; 1–220, 221–440, 441–700, 701–EOF |
| `SOUL-DEVELOPMENT-OS-ASSESSMENT.md` | `c3b7e41eb947e29f10b5c8a60ef1d7eb9554311a` | FULL; 1–220, 221–440, 441–660, 661–880, 881–1100, 1101–EOF |

EOF görülen aralık gerçek içerik sonudur; istek üst sınırı gerçek satır sayısı değildir.

Source package bazı dış/current product gözlemlerine ve SOUL/Development OS/Foundation dosyalarına atıf yapar. Bu concepts turunda bu dış/current kaynaklar yeniden araştırılmadı. Burada yalnız **bu package'in onları nasıl kullandığı** çıkarıldı. Özellikle 2026-09-03 tarihli Codex/Claude Code nesting/concurrency notları current product contract olarak yeniden doğrulanmış sayılmaz.

## 3. Kaynak rolü ve epistemik sınır

Üç dosyanın rolleri farklıdır:

- `META.md`: library classification, reuse semantics, current package status/boundary.
- `CONVERSATION-SYNTHESIS.md`: paylaşılan görsel ve konuşmadan türetilmiş teknik kavramsallaştırma; image taxonomy'sini authority saymayan conversation-derived note.
- `SOUL-DEVELOPMENT-OS-ASSESSMENT.md`: bu pattern'leri current first-party SOUL/Development OS intent ile karşılaştıran exploratory project assessment; Foundation finding veya architecture proposal değil.

Assessment içindeki candidate requirements (C1–C10), risk register (R1–R10), candidate value matrix ve “promising” bölümler **project-specific design pressure/hypothesis** statüsündedir. Bunlar ürün-native tanım veya accepted architecture değildir.

## 4. Kaynak-bölüm → kalıcı kullanım kapsamı

[TERMS.md](TERMS.md) aşağıdaki kaynak ailelerini kapsar:

### Conversation synthesis
- Sequential as dependency/execution ordering;
- Parallel decomposition vs parallel redundancy/ensemble;
- Merge, independence, concurrency;
- parent thread + subagents vs multiple independent threads;
- thread vs session;
- Hierarchical as delegation/authority/coordination topology;
- Manager and recursion/depth;
- Generator–Critic and degrees of reviewer separation;
- review/critique vs verification;
- cross-system orchestration bridge/external orchestrator;
- Human-in-the-Loop authority/governance vs technical verification;
- Composite, Input, Router, Orchestration;
- Agent, Subagent, Thread, Manager, Router, Orchestrator, Merge, Independence, Verification;
- minimum sufficient complexity and mixed-abstraction correction.

### SOUL / Development OS assessment
- dependency ordering, concurrency structure, delegation/authority topology, challenge/verification topology, human governance topology, routing/composition policy;
- Work topology vs Actor topology;
- merge contract;
- manager decisions as load-bearing work;
- bounded recursion / spawn governance;
- critic detectable-failure-class framing;
- human gate as authority rather than generic uncertainty;
- topology transitions as persistent state;
- cross-model diversity vs proof;
- no-multi-agent-complexity as valid topology result;
- exact-target verification / stale-verdict / repair→new-target relationships as Development OS comparison language;
- system formation / emergent task-specific topology.

## 5. Maddi interpretation sınırları

1. **Altı image label peer architecture option değildir.** Kaynak bunların farklı abstraction levels ve relation dimensions taşıdığını özellikle düzeltir.
2. **Sequential/Parallel Work relations; Hierarchical authority/delegation relation; Generator–Critic review topology; Human-in-the-Loop governance insertion; Composite composition** olarak kullanılır. Bunlar mutually exclusive değil.
3. **Agent count ≠ epistemic independence.** Independence evidence/framing/method/model/tool/oracle gibi error-path dimensions'a bağlanır.
4. **Critic ≠ independent verifier.** Review, verification ve adversarial challenge assessment'te ayrıca ayrılır.
5. **Human approval ≠ technical verification.** Authority gate ile evidence review aynı durum değildir.
6. **Manager/worker/critic/human role label ≠ authority/capability/accountability.** Assessment bunu Actors araştırmasının ayrımlarıyla sınırlar.
7. **Composite ≠ universal mega-workflow.** Task-specific emergent topology ve minimum sufficient complexity olarak yorumlanır.
8. **Router ≠ Manager.** Router hangi path/topology; Manager path içindeki decomposition/coordination sorusunu taşır.
9. **Orchestrator ≠ agent team.** Sequencing, dependency, retry, merge, state transition ve gate machinery olarak ayrı control-layer kullanımı vardır.
10. Product-specific Codex/Claude depth/concurrency notları stable pattern properties değildir; source kendisi revalidation sınırı koyar.

## 6. Source-side coverage ve kapanış

Concepts açısından:

- 3/3 source file accounted;
- 3/3 full-read;
- source roles ve current/historical boundaries açıklanmış;
- contextual uses source sections'a bağlanmış;
- external/current product claims yeni doğrulama gibi sunulmamış;
- unread source file yok;
- somut aktarım eksiği bulunmadı.

Kapanış **source-bounded contextual extraction** içindir. Bağımsız verification, image taxonomy doğrulaması, multi-agent architecture acceptance veya current product capability certification değildir.

## 7. Devralma

Normal seri devam SCOPE sırasındaki `research/studies/anthropic-ai-native-sdlc-playbook/` paketidir. Yeni tur current main + gerçek package tree + META/STATE/INDEX preflight ile başlamalıdır. Multi-Agent Patterns yeniden current work yapılmaz; gerektiğinde bu READING ve TERMS durable-complete source olarak geri çağrılır.
