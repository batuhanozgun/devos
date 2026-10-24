# SOUL Context — bounded synthesis

**Status:** context objective met; evidence/context synthesis only  
**Date:** 2026-08-30

## Purpose

Bu dosya `os-architect`, `keel`, `soul` ve bounded predecessor evidence olarak `keel-research` okumalarından çıkan **context cevabını** taşır.

Amaç proje-geneli araştırma metodolojisini, SOUL mimarisini veya agent-control'ü belirlemek değildir.

## Source roles

- `soul` — current explicit intent, Development OS, foundation/work/verification/review evidence için birincil kaynak.
- `os-architect` — tarihsel failure, yöntem, araştırma, owner-correction ve KEEL geliştirme bağlamı.
- `keel` — somut ürün/mekanizma yüzeyi; tarihsel iddiaların seçici mekanik karşı-okuması.
- `keel-research` — yalnız source-chain gerektiğinde bounded predecessor prior-art; SOUL authority değildir.

## Doğrudan desteklenen context

### 1. SOUL first-principles rebuild'dir; KEEL klasör migrasyonu değildir

SOUL current foundation, intended outcome'u alıp o outcome için gereken controlled working system'i kurabilen general-purpose agentic architecture yönünü açıkça taşır.

KEEL'in mevcut klasörleri, workflow'u, provider/framework veya bir task domain'i SOUL'un varsayılan şeması değildir. Predecessor mekanizmalar prior-art/evidence olarak kullanılabilir; mimari gerçek olarak otomatik taşınmaz.

### 2. Hedef tek cevap üreten agent'tan daha geniştir

İstenen yapı outcome'a göre gereken çalışma sistemini oluşturabilmeli; capability formation, bounded authority, state/context/knowledge handling, work lifecycle, evidence/verification, failure/recovery, observability ve governed evolution gibi ihtiyaçlar göreve göre ortaya çıkabilir.

Generality, her işe tek sabit workflow/team zorlamak yerine uygun task-specific working system'i oluşturabilme yönünde tarif edilmektedir.

### 3. Development OS ürün mimarisinden önce bilinçli olarak kurulmuştur

SOUL'un uzun, fresh-session mimari çalışmasının chat geçmişi, model hafızası, drifting state veya producer self-certification'a dayanması, ürünün çözmeye çalıştığı failure class'ları geliştirme sürecinde yeniden üretebilir.

Bu nedenle `development/` ve `system/` ayrılmış; product architecture ve technology selection Phase 0'da bilinçli biçimde ertelenmiştir.

### 4. Predecessor lessons architecture truth değildir

SOUL'un kendi evidence synthesis'i predecessor kaynakları SHA seviyesinde okur ve `source-derived principles` ile `SOUL-specific synthesis decisions`ı ayırır.

Bu, KEEL/os-architect geçmişinden öğrenmenin bilinçli olduğunu; fakat inherited mekanizmaların privileged default sayılmadığını doğrudan destekler.

### 5. Research/evidence architecture decision değildir

SOUL governance'ta Researcher/evidence ile architecture decision authority ayrıdır. Evidence karar için relevance sağlayabilir; fakat proper decision/review path olmadan requirement, backlog, permanent mechanism veya accepted architecture'a otomatik dönüşmez.

### 6. Tarihsel problem isolated product bug seviyesini aşmıştır

Predecessor corpus'ta zamanla şu problem türleri görünür hale gelmiştir:

- question/request'in gerçek objective sanılması,
- state/result korunurken purpose/reason/responsibility/next work'ün kaybolması,
- aynı source/frame/model hatasını paylaşan reviewer/verifier yakınsaması,
- kontrolün formu ölçüp gerçek value'yu kaçırması,
- dersin bulunmasına rağmen need-time'da invoke edilmemesi,
- owner'ın gizli orchestrator/verifier haline gelmesi,
- local reasoning iyi olsa bile system-level framing/work-selection'ın sahipsiz kalması,
- inherited mekanizmayı sürekli sertleştirirken `bunu baştan kurar mıydık?` sorusunun kaybolması.

Bu nedenle SOUL geçişini yalnız `KEEL bozuktu, yenisini yaptık` diye okumak kanıtla uyumlu değildir. Daha güçlü okuma: KEEL mekanik olarak sertleşirken unresolved problem framing/system-formation seviyesine yükselmiştir.

## Bounded answer — bu proje neden var?

Mevcut first-party reconstruction'a göre:

**SOUL Research; geçmiş agentic sistem deneyimlerinden ders alıp onların varsayımlarına hapsolmadan, intended outcome'dan gereken task-specific working system'i oluşturabilen genel amaçlı SOUL yönünün hangi gerçek problemlere, ilkelere ve kanıtlara dayanması gerektiğini araştırmak için açılmıştır.**

ChatGPT'deki SOUL Research projesi bu araştırmanın aktif etkileşim alanıdır. `agentic-os-search` ise uzun soluklu araştırmanın chat/model hafızasından bağımsız, aranabilir, düzeltilebilir ve oturumlar arasında sürdürülebilir çalışma ortamıdır.

Bu cevap `SOUL kesin olarak şudur` hükmü değildir. Repo okumalarının sağladığı başlangıç bağlamıdır ve sonraki dış araştırmanın problem uzayını gereksiz yere KEEL/Codex/Claude Code çerçevesine kilitlememesi gerektiğini gösterir.

## Neyi kanıtlamaz?

Bu context çalışması şunları kanıtlamaz:

- final SOUL definition veya architecture,
- belirli bir role/topology/workflow/database/model/framework zorunluluğu,
- predecessor diagnosis'ların causally complete olduğu,
- herhangi bir local taxonomy'nin complete/canonical olduğu,
- proje-geneli research package, stopping rule veya methodology'nin ne olması gerektiği,
- seçilmiş dış holdout'ların SOUL generality'sini kanıtladığı.

## Detail pointers

- KEEL → SOUL tarihsel bağ: `transition-to-soul.md`
- Research/evidence → architecture decision sınırı: `research-architecture-boundary.md`
- Exact source/read records: `../repos/*/README.md`

Erken research-design/taxonomy çalışmaları bu evidence corpus'un parçası değildir; `../exploratory/` altında ayrı tutulur.
