# AI Knowledge Strategies — Bağlamlı kullanım kayıtları

2026-09-20, **B6-T11 / KALICI-AKTARIM-TAMAM / PACKAGE-COMPLETE**. Gerçek kaynak/okuma hesabı [READING.md](READING.md)'dedir.

Bu dosya `research/studies/ai-knowledge-strategies/` araştırmasının terimleri ve kavramsal ayrımları **bu araştırmanın kendi kullanımında** kaydeder. Genel AI sözlüğü, architecture decision, Foundation taxonomy veya Development OS/SOUL tasarımı değildir.

Türkçe karşılıklar kaynak bağlantılı parafrazdır. Dış literatür iddiası, araştırmacının teknik sentezi, project-specific SOUL/Development OS yorumu ve historical package metadata aynı statüde tutulmaz.

İki çalışma riski görünür tutulur: kullanıcı okuma anındaki anlam seçimlerini denetleyemediği için önemli dayanak/belirsizlik izlenebilir olmalı; aynı sözcüğü kullanmak aynı anlamı garanti etmediği için kullanıcı onayı, kaynak kullanımı ve extractor yorumu teknik doğruluğun yerine konmamalı.

## 1. Paket-geneli dil ve sınıflandırma

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| PKG01 — AI Knowledge Strategies | RAG, Knowledge Graph, Fine-Tuning, Cache-Augmented Generation ve Long Context'i decision-boundary açısından birlikte araştıran focused-topic paket. | META/STATE/00. Beşli final technology stack değildir. |
| PKG02 — mechanism family / candidate family / capability pattern | Belirli problem sınıfında kullanılabilecek yöntem/kapasite ailesi; tek ürün veya seçilmiş implementation değil. | 00 + files 01–05. |
| PKG03 — classification axis | Aynı olguları hangi bakış açısından sınıflandırdığımız; retrieval, representation, adaptation, context reuse gibi eksenler birbirine denk olmak zorunda değil. | 00 §1–2; STATE §3. |
| PKG04 — category error | Farklı sistem katmanı/problem tipindeki mekanizmaları eş-seviye rakip seçenekler sanma hatası. | 00 §2. |
| PKG05 — knowledge governance | Source authority, provenance, freshness, epistemic status, access, verification, update/invalidation/deletion gibi çapraz problemler. | 00 §2.3/§6; STATE §2. Altıncı peer strategy değil. |
| PKG06 — decision boundary | “Use when / Avoid / Needs evidence / Does not prove” ile mekanizmanın seçim sınırını görünür kılan research synthesis. | 00 §6/L; files 01–05. Architecture kararı değil. |
| PKG07 — working hypothesis | Sonraki deep-dive'larda yanlışlanması gereken başlangıç varsayımı. | 00 §7. Finding veya accepted decision değil. |
| PKG08 — bounded deep-research synthesis | Sınırlı kaynak setiyle decision-boundary hedefini karşılayacak kadar kapatılmış teknik araştırma. | 01–05 headers/stopping rationales. Alanın tüm literatürünü tükettiği anlamına gelmez. |
| PKG09 — current package state | Altı özgün research dosyasının tamamlanmış olması. | STATE authoritative; 00 içindeki “files 1–5 not yet researched” tarihsel initiation snapshot. |
| PKG10 — Context/Memory/Harness follow-up | Daha sonra beş mekanizmayı broader engineering problem domains ile ilişkilendiren sibling araştırma. | STATE §3. Üç yeni peer strategy değil; farklı classification axis. |

### Paket düzeyi kısa ilişki

Kaynak araştırmanın kendi kısa sentezi:

> **RAG → external evidence access**  
> **Knowledge Graph → relation-centric representation**  
> **Fine-Tuning → parametric behavior/capability adaptation**  
> **CAG → repeated stable context reuse**  
> **Long Context → whole-package working context**

Bu eşleştirme bir taxonomy membership veya mutually-exclusive architecture seçimi değildir. Aynı working system birden fazla mekanizmayı birlikte kullanabilir.

---

## 2. RAG — Retrieval-Augmented Generation

Kaynak: `01-RAG.md`.

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| RAG01 — Retrieval-Augmented Generation / RAG | Model üretiminden önce veya sırasında dış bilgi alanından task-relevant evidence/context getirip üretimi bununla koşullandıran yöntem ailesi. | §1–2. Vector database ile eşit değil. |
| RAG02 — parametric memory | Model weights içinde taşınan bilgi. | §2–3, Lewis framing. External source store ile aynı değil. |
| RAG03 — non-parametric memory | Orijinal RAG framing'inde retriever'ın eriştiği explicit dış index. | §2–3. Modern “memory system” kavramının tümü değil. |
| RAG04 — RAG pipeline | Source selection → ingestion → representation/index → query planning → retrieval → filter/rerank → context construction → generation → attribution → verification/repair zinciri. | §4. Tek algoritma değil. |
| RAG05 — corpus/source eligibility | Bir kaynağın retrieval aday havuzuna girmeye yetkili, güncel ve uygun olup olmadığı. | §2.2/§6.1. Semantic relevance'dan ayrı. |
| RAG06 — retrieval correctness | Gerekli evidence'ın gerçekten getirilmesi ve kritik evidence'ın atlanmaması. | §2.2/§6.2. |
| RAG07 — evidence-use correctness | Doğru evidence gelmiş olsa da modelin onu doğru/eksiksiz/çatışmaları gözeterek kullanması. | §2.2/§6.3. |
| RAG08 — downstream decision/action correctness | Evidence doğru kullanılsa bile seçilen Work/eylem/yetkinin doğru olup olmadığı. | §2.2/§6.4. Agentic evaluation surface. |
| RAG09 — sparse retrieval | Lexical/exact-term eşleşmeye dayalı retrieval ailesi; BM25 örneği. | §5.1. |
| RAG10 — dense retrieval | Learned vector representation üzerinden semantic matching. | §5.1. Dense her durumda üstün değil. |
| RAG11 — hybrid retrieval | Lexical ve semantic signal'ların birleştirilmesi. | §5.1. Ranking fusion/workload'a bağlı. |
| RAG12 — chunking / segmentation | Kaynağı retrieval parçalarına bölme işlemi. | §5.2. Token optimizasyonu değil; parent context/qualifier kaybı üretebilir. |
| RAG13 — document context / parent context | Chunk'ın doğru yorumlanabilmesi için geldiği üst belge/bölüm bağlamı. | §5.2. |
| RAG14 — query formation / query rewrite | User request'ten retrieval için evidence-need odaklı ayrı query üretme. | §5.3. User wording'in mekanik kopyası değil. |
| RAG15 — HyDE | Hypothetical generated document'i retrieval representation pivot'u olarak kullanan yöntem. | §5.3. Intermediate text cevap/truth değildir. |
| RAG16 — iterative / interleaved retrieval | İlk bulgunun sonraki evidence ihtiyacını belirlediği çok-aşamalı retrieval. | §5.4. |
| RAG17 — adaptive retrieval | No-retrieval / single-step / iterative retrieval arasında query/task koşuluna göre seçim. | §5.5/§12. Retrieval her turn ritual değil. |
| RAG18 — corrective RAG | Retrieval kalitesini değerlendirip alternatif/deeper retrieval veya fallback kullanan control-loop yaklaşımı. | §12. |
| RAG19 — reranking | İlk candidate set'i daha pahalı/ayrıntılı signal ile yeniden sıralama. | §5.6. |
| RAG20 — context construction | Retrieved candidate'lardan modelin göreceği working context'i kurma. | §5.6. Retriever correctness ile aynı değil. |
| RAG21 — retrieval omission | Load-bearing evidence'ın hiç görünür olmaması. | §6.2/§21 F-RAG-03. Wrong retrieval kadar önemli failure. |
| RAG22 — updateability | External store'un model retraining olmadan değiştirilebilmesi. | §7. Freshness ile aynı değil. |
| RAG23 — freshness | Source change'in ingestion/index/version zincirinden query'ye doğru güncel biçimde yansıması. | §7. |
| RAG24 — provenance / lineage | Claim → chunk → source revision → canonical source bağını kurabilme. | §8. Citation correctness otomatik değil. |
| RAG25 — citation correctness / completeness | Verilen citation'ın claim'i gerçekten desteklemesi ve tüm load-bearing claim'lerin desteklenmesi. | §8/§11.4. Ayrı metrikler. |
| RAG26 — knowledge conflict | Retrieved evidence ile parametric knowledge veya iki external source arasındaki uyuşmazlık. | §6.3/§9. |
| RAG27 — retrieval policy | Ne zaman, nereden, kaç aşamada ve hangi fallback ile retrieve edileceğine dair control problem. | §12/F-RAG-04. Retriever algoritmasından daha geniş. |
| RAG28 — governed adaptive retrieval | Evidence need, authority/access, query plan, retriever selection, filtering, context construction, verification ve repair'i birlikte düşünmek için project decision frame. | §13.3. Architecture proposal değil. |
| RAG29 — decision-critical evidence omission rate | Sonucu değiştirecek evidence'ın atlanma oranını görünür kılmak için project-specific candidate metric. | §11.2. Literatür standardı olarak sunulmuyor. |
| RAG30 — progressive retrieval baseline | Development OS'nin STATE→INDEX→package→source recovery düzeni. | §14.1/F-RAG-06. Vector-RAG değil; karşılaştırılacak controlled retrieval baseline. |

**RAG ilişki görünümü:** source eligibility → retrieval → context/evidence use → downstream decision/action. Bu dört katmanın biri diğerini otomatik garanti etmez.

---

## 3. Knowledge Graph — relation-centric representation

Kaynak: `02-KNOWLEDGE-GRAPH.md`.

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| KG01 — Knowledge Graph / KG | Entity/concept ve anlamlı ilişkileri graph tabanlı data model içinde explicit temsil etmeyi amaçlayan relation-centric yapı ailesi. | §2–3. Tek tartışmasız tanım yok. |
| KG02 — graph data model | Bilginin node/edge/triple benzeri graph primitives ile temsil biçimi. | §3–6. Storage engine ile aynı değil. |
| KG03 — graph database | Graph veriyi saklama/query etme technology class'ı. | §4.1. Knowledge Graph'ın kendisi değil. |
| KG04 — ontology | Concept/class/relation/axiom/constraint semantiğini formalize eden yapı. | §4.2. Her KG ağır ontology olmak zorunda değil. |
| KG05 — schema / schema-based | İzin verilen entity/relation/type/constraint düzeni. | §4.2/§8. |
| KG06 — schema-free / schema-light | Daha az önceden belirlenmiş semantic constraint ile graph construction. | §4.2. Flexibility kazanırken semantic drift riski. |
| KG07 — RDF | Subject–predicate–object triples/datasets kullanan graph representation family. | §6.1. |
| KG08 — labeled property graph | Node/edge label ve property'lerini application-centric biçimde taşıyan graph modeli. | §6.2. |
| KG09 — first-class relation | Relation'ın implicit text/join yerine açık sorgulanabilir bilgi nesnesi olması. | §5. |
| KG10 — relation represented / validated / current / authoritative / causal | Aynı edge için birbirinden ayrı epistemik nitelikler. | §5. Structured form truth guarantee değil. |
| KG11 — construction lifecycle | Purpose/source/schema/extraction/entity resolution/relation extraction/fusion/provenance/validation/update zinciri. | §7. |
| KG12 — entity resolution / alignment | Farklı kayıtların aynı real-world entity'yi temsil edip etmediğini belirleme. | §9. |
| KG13 — false split | Aynı entity'nin birden fazla node'a ayrılması. | §9.1. |
| KG14 — false merge | Farklı entity'lerin tek node'da birleştirilmesi. | §9.1. |
| KG15 — relation extraction | Text/source'dan predicate + endpoints assertion üretme. | §10. Her extracted edge bir iddia üretir. |
| KG16 — relation vocabulary | `proposes/decides/supports/proves/authorised_for/performed` gibi semantik olarak ayrılması gereken predicate set'i. | §10. |
| KG17 — n-ary/contextual relation | Actor, Work, Environment, time, scope gibi birden fazla bağlam öğesi taşıyan ilişki. | §11. Basit binary edge'e indirgeme kayıp yaratabilir. |
| KG18 — reification / statement node / relation properties | Relation'ın kendi context/provenance/time metadata'sını taşımak için kullanılan representation yolları. | §11. |
| KG19 — provenance granularity | Provenance'ın node/edge/statement/subgraph/document düzeyinde tutulması. | §12.1. |
| KG20 — temporal validity | Relation/fact'in hangi zaman aralığında geçerli olduğunun explicit tutulması. | §13. Bazı authority/state ilişkilerinde correctness requirement. |
| KG21 — open-world assumption | Graph'ta fact bulunmamasının false olduğu anlamına gelmemesi. | §14. |
| KG22 — graph miss ≠ world/source absence | Missing edge'in gerçek dünyada relation yokluğunu kanıtlamaması. | §14.1. RAG miss ayrımının graph analoğu. |
| KG23 — Knowledge Graph completion | Graph patternlerinden eksik relation tahmin etme. | §15. Predicted edge source-observed fact değil. |
| KG24 — source-observed / derived / entailed / predicted / LLM-proposed edge | Relation'ların farklı epistemik statüleri. | §15. |
| KG25 — graph quality | Accuracy, consistency, completeness, timeliness, provenance/trust, fit-for-use gibi çok boyutlu kalite. | §16. Node/edge count kalite değil. |
| KG26 — structural metric | Degree, density, clustering, node/edge count gibi topological ölçümler. | §16.1. Semantic correctness oracle değil. |
| KG27 — graph reasoning / traversal / reachability | Explicit relation structure üzerinde path/neighborhood/hierarchy/rule query'leri. | §17. Path bulmak neden/causality kanıtı değil. |
| KG28 — GraphRAG | Graph structure'u retrieval/generation pipeline'ında kullanan application pattern. | §19–21. KG'nin kendisi veya universal RAG upgrade değil. |
| KG29 — global corpus sensemaking | Cevabın tek passage'da olmadığı, corpus-wide relation/summarization gerektiren task family. | §19. GraphRAG'ın güçlü aday kullanım alanı. |
| KG30 — derived relation index | Canonical source'un yerine geçmeden source pointers ile relation/dependency sorgusunu hızlandıran project candidate role. | §25.1/F-KG-09. Architecture decision değil. |
| KG31 — source–graph fidelity | Load-bearing node/edge'in exact source/ref/SHA/extraction/status/time ile bağlanması gereksinimi. | §25.4. |
| KG32 — graph capability formation | Her task için graph default yerine relation-heavy workload olduğunda graph capability kurma yaklaşımı. | §24.2/F-KG-13. Project synthesis. |

**KG ilişki görünümü:** canonical/source evidence → extraction/identity/relation semantics → graph representation → query/reasoning → downstream use. Formal graph yapısı her geçişin doğruluğunu otomatik sağlamaz.

---

## 4. Fine-Tuning — parametric adaptation

Kaynak: `03-FINE-TUNING.md`.

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| FT01 — Fine-Tuning | Pretrained model parametrelerini veya ek trainable parametreleri görev/domain/davranış/preference için adapte eden yöntem ailesi. | §2. |
| FT02 — full fine-tuning | Model parametrelerinin büyük kısmı/tamamının gradient ile güncellenmesi. | §5.1. |
| FT03 — Supervised Fine-Tuning / SFT | Input/instruction → desired output örneklerinin likelihood'ını artıran supervised adaptation. | §2/§6.1. |
| FT04 — instruction tuning | Çoklu instruction/task örnekleriyle general instruction-following adaptation. | §2/§6.2. |
| FT05 — preference optimization | Chosen/rejected gibi preference verisinden davranış tercihinin öğrenilmesi. | §2/§6.3. Correctness ile preference aynı değil. |
| FT06 — DPO | Explicit reward model+RL olmadan preference pairs üzerinden policy optimization örneği. | §2/§6.3. |
| FT07 — RLHF / RLxF | Human/other feedback reward sinyaliyle policy adaptasyonu; fine-tuning içerebilir ama SFT ile aynı süreç değil. | §2. |
| FT08 — PEFT | Küçük parametre subset/modülünü eğiten parameter-efficient fine-tuning family. | §2/§5. |
| FT09 — LoRA | Frozen base model üzerinde low-rank trainable update matrices kullanan PEFT yöntemi. | §5.2. |
| FT10 — QLoRA | Quantized frozen base model + LoRA adapter training. | §5.3. |
| FT11 — continual / sequential fine-tuning | Modelin zaman içinde yeni task/domain/data aşamalarıyla tekrar adapte edilmesi. | §2/§8. |
| FT12 — domain-adaptive / continued pretraining | Domain verisiyle pretraining'in sürdürülmesi; downstream SFT ile aynı aşama değil. | §2/§4.2. |
| FT13 — behavior / task adaptation | Modelin mevcut knowledge/capability'yi hedef task/format/procedure/preference olarak kullanma biçimini değiştirme. | §2–4. Fine-Tuning için güçlü use case. |
| FT14 — factual knowledge injection/update | Yeni factual knowledge'ı weights'e öğretme/değiştirme. | §4/§9. Mümkün fakat reliability/provenance/freshness problemi daha güçlü. |
| FT15 — objective mismatch | Pretraining objective ile human/task instruction objective arasındaki boşluk. | §3. |
| FT16 — task/domain mismatch | General-purpose model ile target task/domain dağılımı arasındaki uyumsuzluk. | §3. |
| FT17 — preference mismatch | Birden fazla plausible output arasındaki tercih düzeninin pretraining objective'de bulunmaması. | §3. |
| FT18 — behavioral specification | Fine-tuning dataset'inin istenen/istenmeyen davranışları fiilen öğreten yüksek etkili specification rolü. | §7. |
| FT19 — data quality / diversity | Training volume'dan ayrı, robustness/generalization'ı etkileyen dataset nitelikleri. | §7/F-FT-05. |
| FT20 — catastrophic forgetting / regression | Yeni adaptation'ın önceki knowledge/capability/safety behavior'ı bozması. | §8. |
| FT21 — regression matrix | Target task yanında prior capability, safety, factuality, OOD, adversarial, tool/action ve retention kontrolleri. | §8.1/§17. |
| FT22 — knowledge conflict | Old parametric fact ile yeni training fact'in weights düzeyinde çatışması. | §9. |
| FT23 — training provenance | Dataset/version/source/license/run/checkpoint lineage'ının kaydı. | §10/§16. |
| FT24 — training-data attribution / influence | Belirli output/model behavior üzerinde hangi training example'ların etkili olduğunu tahmin etme problemi. | §10. Inference-time source citation ile aynı değil. |
| FT25 — model mutation capability | Fine-tuning yapabilmenin persistent/semi-persistent yüksek etkili model behavior mutation authority'si olması. | §11/§18.3. |
| FT26 — safety regression / backdoor / latent behavior | Fine-tuning sonrası safeguards'in bozulması veya trigger-dependent hidden behavior riski. | §11–12. |
| FT27 — adapter/base binding | Adapter'ın exact base model family/version/tokenizer/config ile birlikte identity taşıması gereği. | §5.4/§15–16. |
| FT28 — rollback target | Fine-tuned checkpoint/adapter'dan önceki verified model/adapter state'e dönme noktası. | §16. |
| FT29 — core governance vs task-specific capability | Mutable authority/current-state/control rulesini weights'e gömmek ile stable specialized task behavior eğitmek arasındaki project distinction. | §18.2/F-FT-11/12. |
| FT30 — governed capability formation | Capability gap → baseline alternatives → authorised data/training → regression/safety verification → bounded deployment/rollback akışı. | §18.1. Architecture proposal değil. |

**FT ilişki görünümü:** dataset/recipe/base identity → parametric mutation → changed behavior/capability → target/general/safety verification → bounded deployment. Training tamamlanması veya target score deployment acceptance değildir.

---

## 5. Cache-Augmented Generation — repeated context reuse

Kaynak: `04-CAG.md`.

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| CAG01 — CAG / Cache-Augmented Generation | Chan-style: bounded knowledge corpus'u long context'e preload edip precomputed KV state'i reuse eden, query-time retrieval yapmayan pattern. | §1–3. Bu dosyada CAG bu exact anlamda. |
| CAG02 — acronym collision | CAG'nin Context Awareness Gate, Credibility-aware Generation vb. başka açılımlarla kullanılması. | §2.1. Acronym tek başına yeterli terim değil. |
| CAG03 — narrow CAG | Whole bounded corpus preload + reusable KV + no query-time retrieval. | §2.2. |
| CAG04 — broad cache-augmented LLM systems | RAG dahil çeşitli pipeline'larda prompt/KV/context cache reuse ailesi. | §2.2. Narrow CAG ile aynı değil. |
| CAG05 — KV cache / KV state | Önceki token'ların attention key/value ara hesaplarını saklayan model-specific computational state. | §4. Semantic/source database değil. |
| CAG06 — prefill | Input prefix/context'in model tarafından ilk kez işlenerek KV state oluşturulması. | §3/§6. |
| CAG07 — repeated prefill amortization | Aynı uzun prefix'i her query'de yeniden hesaplamama avantajı. | §3/§6.4/F-CAG-05. Narrow CAG'ın en temiz mekanik faydası. |
| CAG08 — prompt/prefix caching | Repeated prompt prefix'lerinin prefill hesaplarını reuse eden generic serving optimization. | §5.2. CAG olmak zorunda değil. |
| CAG09 — KV-cache accelerated RAG | Retrieval'ı koruyup retrieved chunks'ın KV computation'ını reuse etme. | §5.3. Narrow CAG'dan farklı. |
| CAG10 — semantic response cache | Similar query için önceki cevabı tekrar kullanabilen cache. | §5.4. KV-state reuse ile aynı değil. |
| CAG11 — Long Context substrate | Whole bounded corpus'un context'e sığması/kullanılabilmesi; Chan CAG'ın temel substrate'ı. | §5.1/§25. CAG ve LC tamamen bağımsız değil. |
| CAG12 — effective context | Advertised window değil, modelin workload'ta gerçekten kullanabildiği context. | §7. |
| CAG13 — content / eligibility / authority / access stability | “Stable context”in dört ayrı anlamı. | §8. Text unchanged olmak tek başına cache-safe değil. |
| CAG14 — cache invalidation | Source/model/prompt/access/version değişiminde eski derived cache state'in geçersiz kılınması. | §9. Correctness'ın first-class parçası. |
| CAG15 — cache manifest / identity | Cache'i source SHAs, model/adapter/tokenizer/prompt/access/build/verification ile bağlayan candidate metadata. | §9.2. Research synthesis; implementation spec değil. |
| CAG16 — positional/cache portability | KV state'in prefix/position/model interactions nedeniyle universal portable representation olmaması. | §10. |
| CAG17 — provider prompt cache | API provider'ın TTL/eviction/prefix semantics ile yönettiği caching. | §11. App-level CAG deployment ile aynı değil. |
| CAG18 — stable-prefix / dynamic-suffix | Reusable stable context'i mutable/volatile content'ten ayırma düzeni. | §12/F-CAG-11. Supporting prompt-cache evidence. |
| CAG19 — corpus eligibility at build time | Retrieval seçimini kaldırınca wrong/stale/unauthorized source riskinin cache-build aşamasına taşınması. | §13. |
| CAG20 — cache-derived asset | Source'dan türetilmiş KV/prefix state'in performance object yanında privacy/access/governance gerektiren asset olması. | §17. |
| CAG21 — cache identity correctness | Hit edilen cache'in exact source/model/prompt/access identity ile uyumlu olması. | §18.1. |
| CAG22 — cold-build / warm-hit / rebuild | Cache creation, load/hit ve invalidation sonrası rebuild'ün ayrı performans yüzeyleri. | §18.6. |
| CAG23 — stable context / dynamic state boundary | Verified stable context'in reuse edilebilmesi, mutable authoritative state'in fresh canonical recovery gerektirmesi. | §15–16/§27. Project-specific key boundary. |
| CAG24 — hybrid CAG + RAG | Stable bounded foundation'ı cache, dynamic/rare external tail'i retrieval/direct-source ile getirme. | §22. Candidate composition. |

**CAG ilişki görünümü:** canonical/source state → validated bounded context → model-specific cached compute state → repeated query use. Cache, source authority veya freshness oracle değildir.

---

## 6. Long Context — whole-package working context

Kaynak: `05-LONG-CONTEXT.md`.

| ID / ifade | Bu araştırmadaki karşılık | Kaynak / sınır |
|---|---|---|
| LC01 — Long Context | Tek inference/work episode içinde çok büyük text/code/data/evidence paketini doğrudan input context olarak işleme capacity/work mode. | §2. Persistent memory değil. |
| LC02 — advertised / admissible context | Model/API'nin kabul ettiği maksimum input/output budget. | §3.1. Interface capacity. |
| LC03 — trained / adapted context | Modelin training/context-extension sırasında optimize edildiği length regime. | §3.2. |
| LC04 — benchmark-effective context | Belirli benchmark+threshold altında acceptable performance sürdürülen length. | §3.3. |
| LC05 — workload-effective context | Belirli Work/evidence distribution/reasoning biçiminde güvenilir kullanılabilen context uzunluğu. | §3.4. Project açısından daha yük taşıyan kavram. |
| LC06 — economically usable context | Cost, TTFT, memory, throughput, concurrency sınırları altında pratik length. | §3.5. |
| LC07 — governed context | Included sources'ın eligible/authorised/current/versioned/epistemically labelled/provenance-preserving olması. | §3.6. Capacity'den ayrı. |
| LC08 — in-context retrieval | Bounded corpus full/near-full context'e verildiğinde modelin relevant evidence'i context içinden bulması. | §4.1. |
| LC09 — document integrity | Full-document context ile section/header/exception/reference ilişkilerinin fiziksel olarak birlikte tutulması. | §4.2. Equal utilization guarantee değil. |
| LC10 — bounded package sensemaking | Cevabın tek fact yerine bütün paketin synthesis/contradiction/relationship'ına bağlı olduğu Work. | §4.3. |
| LC11 — retrieval omission reduction | Full package görünürlüğüyle retriever'ın critical source'u hiç göstermemesi riskinin azaltılması. | §5.1. Model-use omission hâlâ mümkün. |
| LC12 — position effect / Lost in the Middle | Relevant information'ın context pozisyonuna göre kullanım performansının değişmesi. | §6. |
| LC13 — NoLiMa / non-literal retrieval | Query/source lexical overlap olmadan latent association ile evidence bulma zorluğunu test eden benchmark yaklaşımı. | §7. |
| LC14 — long-distance relational knowledge | Birbiriyle ilişkili evidence parçalarının uzaklığı arttıkça relation integration'ın zorlaşması. | §8. Co-presence ≠ integration. |
| LC15 — length-conditioned reasoning degradation | Evidence perfect/reachable olsa bile sheer sequence length'in reasoning quality'yi düşürebilmesi. | §9. |
| LC16 — NIAH / needle test | Long context içinde literal target bulma benchmark family. | §10. Tek başına readiness oracle değil. |
| LC17 — RULER / HELMET / LongBench families | Retrieval, multi-hop, aggregation ve realistic long-context reasoning'i farklı açılardan sınayan benchmark families. | §10. Tek skor bütün workload'u temsil etmiyor. |
| LC18 — context construction | Full context'e hangi source/version/order/metadata/permission/trust boundary'nin girdiğini belirleme preprocessing work. | §12. Governed information system problemi. |
| LC19 — distractor / conflict / instruction contamination | Large context'e irrelevant, contradictory, historical veya instruction-like malicious material karışması. | §13. |
| LC20 — fine-grained citation / provenance | Long-context output claim'ini exact source/span ile bağlama capability'si. | §14. Full visibility bunu otomatik sağlamaz. |
| LC21 — prefill cost | Uzun input'un generation öncesi compute/latency yükü. | §15.2. CAG/prompt cache bunu amortize edebilir. |
| LC22 — context extension | Positional/training/engineering ile modelin supported context range'ini büyütme. | §16. Accepted length semantic utilization guarantee değil. |
| LC23 — Long Context vs RAG routing | Full bounded package ile selected retrieved context arasında workload/cost/omission/reasoning trade-off'una göre seçim. | §17. Technology-war değil. |
| LC24 — hybrid retrieval → bounded package Long Context | Router/retrieval ile authoritative package seçip paketi whole-context reasoning'e verme. | §18/§26.4. Candidate pattern. |
| LC25 — access-scoped context package | Full context construction'dan önce actor/tenant permission'a göre filtrelenmiş package. | §23. |
| LC26 — length regression curve | Aynı Work/evidence'ı artan length'te test ederek performance failure threshold'unu ölçme. | §24.10. |
| LC27 — bounded authoritative package reasoning | Development OS'ta fresh canonical routing sonrası current bounded package'i bütün halinde değerlendirme. | §26.4–26.5/F-LC-14. Progressive retrieval replacement değil. |
| LC28 — full-repo context | Bütün repository'nin tek context'e yüklenmesi fikri. | §26.2. Capacity çözerken authority/noise/source-view fidelity riski yaratabilir. |

**LC ilişki görünümü:** context accepted → relevant evidence physically present → evidence found/related → reasoning correct → claims attributable → downstream action. Her geçiş ayrı failure surface.

---

## 7. Mekanizmalar arası kaynak-içi ilişkiler

Bu bölüm ortak sözlük kararı değildir; yalnız bu araştırmanın kompozisyon dilini taşır.

| ID | İlişki | Kaynaktaki karşılık |
|---|---|---|
| X01 — RAG + KG | Retrieval ile relation-centric representation birlikte kullanılabilir; GraphRAG örneği. | 01 §18.1; 02 §19/§26.1. |
| X02 — RAG + Fine-Tuning | External current evidence ile specialized parametric behavior farklı katmanlarda birlikte kullanılabilir. | 01 §18.2; 03 §20. |
| X03 — RAG + CAG | Stable/repeated bounded context cache edilirken dynamic/rare tail retrieve edilebilir. | 01 §18.3; 04 §22. |
| X04 — RAG + Long Context | Retrieval selection + bounded whole-package context hybrid olabilir. | 01 §18.4; 05 §17–18. |
| X05 — KG + Fine-Tuning | KG structured external state; FT graph extraction/use behavior'ını adapte edebilir. | 02 §26.2; 03 §21. |
| X06 — KG + CAG | Stable graph/schema/subgraph view cache edilebilir; provenance/time/status korunmalı. | 02 §26.3; 04 §23. |
| X07 — KG + Long Context | Graph relation-aware selection yapabilir; underlying raw sources whole-context'e getirilebilir. | 02 §26.4; 05 §19. |
| X08 — FT + CAG | Stable behavior weights'te; stable repeated context cache'de olabilir. | 03 §22; 04 §24. |
| X09 — FT + Long Context | Specialized behavior + current external full package context farklı katmanlardır. | 03 §23; 05 §20. |
| X10 — CAG + Long Context | Long Context CAG'ın whole-package substrate'ı; CAG repeated-use compute layer'ı. | 04 §25; 05 §21. |

## 8. Paket-geneli tekrar eden governance kullanımları

| ID / ifade | Bu araştırmadaki rol |
|---|---|
| G01 — source authority | Hangi source'un bu Work için authoritative/eligible sayıldığı. Relevance ile aynı değil. |
| G02 — provenance | Claim/context/relation/cache/model output'un hangi source/version/run'a dayandığının izi. |
| G03 — freshness / temporal validity | Bilginin veya derived state'in current olup olmaması ve validity aralığı. |
| G04 — epistemic status | Observation, source claim, inference, hypothesis, accepted decision, predicted relation gibi statülerin ayrımı. |
| G05 — access / permission | Hangi Actor/tenant'ın hangi source/context/graph/cache'e erişebildiği. |
| G06 — verification | Mekanizmanın doğru şeyi doğru kapsamda yaptığına dair error-sensitive evidence. |
| G07 — invalidation / deletion propagation | Source değişince index/graph/cache/derived view'in de güncellenmesi/silinmesi. |
| G08 — downstream correctness | Information mechanism'in başarılı olmasının Work/decision/action doğruluğunu otomatik garanti etmemesi. |

Bu governance başlıkları pakette sık tekrar eder; ancak araştırma onları bağımsız bir altıncı “knowledge strategy” olarak tanımlamaz.

## 9. Named-but-not-generally-defined / kapsam notları

Kaynakta LLM, model, agent, runtime, provider, API, token, embedding, vector database, benchmark, dataset, tool, work, actor, authority gibi birçok genel teknik sözcük geçer. Bu paket bunların tümü için genel tanım üretmez. Yalnız yukarıdaki bağlamda yük taşıyan kullanımlar kaydedildi.

Source ledger içindeki paper/framework/provider adları terim envanterinin kendisi değildir. Benchmark isimleri, ilgili mekanizmanın evaluation kullanımını ayırdığı ölçüde kayda alındı.

## 10. Kapanış ve yorum izi

B6-T11'de dokuz package dosyası tam okundu. Ana interpretive sonuçlar source package'in current `STATE.md` senteziyle uyumlu:

- beş mekanizma aynı classification axis'te eş-seviye rakipler değildir;
- RAG external evidence access;
- KG relation-centric representation;
- Fine-Tuning parametric adaptation;
- narrow CAG repeated bounded context reuse/KV compute state;
- Long Context whole-package working context capability;
- authority/provenance/freshness/access/verification gibi governance problemleri hepsinin üzerinde/çaprazında kalır.

Bu kayıt, sibling Context/Memory/Harness package'inin kavramlarını bu pakete zorla taşımadı. Ancak kaynak `STATE.md` sibling mapping'i açıkça verdiği için yalnız şu boundary korunur: Context/Memory/Harness daha broader/overlapping engineering problem domains'dir; beş mekanizmaya üç yeni peer strategy olarak eklenmez.

Maddi source ambiguity'leri açık bırakıldı: “Knowledge Graph” ve “CAG” terimleri literatürde overloaded olabilir; “Fine-Tuning” şemsiye ailesidir; “effective context” workload-dependent'tir; “RAG” modern kullanımda orijinal paper'dan daha geniş family olarak kullanılabilir.

Bu aynı-assistant source extraction ve source-side coverage kontrolüdür. Bağımsız verification, evrensel terminology kararı veya architecture adoption değildir.
