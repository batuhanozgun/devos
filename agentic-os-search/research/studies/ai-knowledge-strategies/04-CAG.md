# CAG — Cache-Augmented Generation Derin Araştırması

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `03-FINE-TUNING.md`  
**Research object:** Cache-Augmented Generation (CAG), specifically the Chan et al. retrieval-free long-context + KV-cache formulation  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** separate technical research line; does not modify the current foundation hierarchy  
**Verification status:** cross-source research synthesis; no local CAG implementation, corpus benchmark, cache-security test or independent verification executed  
**Package position:** file 4 of 5 technical deep-dives; next planned file is `05-LONG-CONTEXT.md`

---

## 1. Araştırma sorusu

Bu dosya şu soruyu araştırır:

> **Cache-Augmented Generation hangi gerçek problem sınıflarını çözer, hangi koşullarda retrieval yerine bütün knowledge corpus'unu long context'e preload edip KV cache'i yeniden kullanmak doğru olur, hangi freshness/security/governance failure mode'larını yaratır ve SOUL ile Development OS açısından hangi karar sınırlarını görünür hale getirir?**

Bu soru şu daha dar sorularla aynı değildir:

> “Prompt caching açalım mı?”  
> “KV cache hızlı mı?”  
> “RAG'ı kaldıralım mı?”  
> “Bütün repo'yu context'e koyalım mı?”

Bu dosya özellikle şu yanlış başlangıçları reddeder:

- CAG = her tür caching değildir.
- CAG = semantic response cache değildir.
- CAG = generic prompt/prefix caching değildir.
- CAG = KV cache kullanan her LLM sistemi değildir.
- CAG = Long Context ile aynı şey değildir; Chan et al. formulation'ında Long Context + reusable precomputed KV state birlikte kullanılır.
- CAG = RAG'dan her durumda daha hızlı değildir.
- CAG = RAG'dan her durumda daha doğru değildir.
- CAG retrieval hatalarını kaldırsa da source-selection / authority / freshness hatalarını kaldırmaz.
- Cache hit = doğru bilgi / current bilgi / authorised bilgi değildir.
- Bir corpus advertised context window'a sığıyorsa model onu güvenilir şekilde kullanıyor demek değildir.
- Stable context = immutable context değildir.
- Development OS canonical recovery'nin yerine cached state koymak bu araştırmanın sonucu değildir.

---

## 2. Önce terimi sabitlemek gerekiyor

### 2.1. “CAG” tek anlamlı bir acronym değildir

2024–2026 literatüründe `CAG` farklı çalışmalar tarafından farklı anlamlarda kullanılmaktadır:

- **Cache-Augmented Generation** — Chan et al.; bu dosyanın konusu. [S1]
- **Context Awareness Gate** — retrieval gerekip gerekmediğine karar veren başka bir RAG mechanism'i. [S18]
- **Credibility-aware Generation** — retrieved context'in güvenilirliğini dikkate alan başka bir çalışma. [S19]
- Bazı sistem literatüründe `context-augmented generation` ifadesi de CAG kısaltmasıyla kullanılabilmektedir. [S13]

Dolayısıyla yalnız “CAG” yazmak teknik olarak yetersizdir.

Bu research package boyunca **CAG = Cache-Augmented Generation, Chan et al. (WWW Companion 2025)** olarak kullanılacaktır.

### 2.2. Terimin alanı henüz RAG kadar yerleşik değildir

Chan et al. yaklaşımı 2024 sonunda arXiv'de yayımlanmış ve 2025 ACM Web Conference Companion'da kısa makale olarak kabul edilmiştir. Ardından KV/prompt/context caching, cache-accelerated RAG ve cache-augmented RAG hakkında daha geniş bir sistem literatürü hızla büyümüştür. 2026 Journal of Supercomputing survey'i caching'i RAG pipeline'larında primary design dimension olarak ayrıca sınıflandırmaktadır. [S1][S17]

Bu nedenle iki şeyi ayırmak gerekir:

1. **Narrow CAG:** bütün bounded knowledge corpus'unu preload et, KV state'i cache et, query-time retrieval yapma.
2. **Broad cache-augmented LLM systems:** RAG dahil olmak üzere çeşitli pipeline'larda KV/prompt/semantic/cache reuse uygula.

Bu dosyanın ana hükmü narrow CAG hakkındadır; broad caching literature ise mekanizmanın sınırlarını anlamak için kullanılır.

---

## 3. CAG tam olarak ne yapar?

Chan et al. CAG üç aşamalı bir workflow tanımlar. [S1]

```text
1. External knowledge preload

Curated corpus D
    ↓
Long-context prompt/prefix
    ↓
Model prefill
    ↓
Precomputed KV cache C_KV
    ↓
Memory / disk

2. Query-time inference

C_KV + user query q
    ↓
Generation

(no online document retrieval)

3. Reset

Append-only query/output state removed
    ↓
Return to baseline knowledge KV state
```

Matematiksel olarak paper'ın özeti:

```text
C_KV = KV-Encode(D)
r = M(q | C_KV)
```

Buradaki temel kazanç:

> **Aynı uzun knowledge prefix'i her query'de tekrar prefill etmek yerine bir kez hesaplayıp reuse etmek.**

Bu nedenle CAG'ın teknik özünü yalnız “retrieval yok” diye tarif etmek eksiktir. Asıl amortized computation avantajı **repeated long-context prefill reuse**'dan gelir.

---

## 4. KV cache nedir ve ne değildir?

Transformer inference sırasında attention katmanları daha önce işlenmiş token'ların key/value ara temsilini saklar. Yeni token üretilirken bu temsillerin tekrar hesaplanmaması latency ve compute'u ciddi biçimde azaltır. Prompt/prefix/context caching sistemleri aynı prensibi requests arasında da kullanabilir. [S3][S5][S6]

Ancak önemli ayrım:

```text
Source document
      ↓ encode
KV tensors
```

şunu ifade etmez:

```text
KV tensors = verified factual database
```

KV cache:

- model-specific computational state'tir,
- source'un plaintext semantic schema'sı değildir,
- source authority'yi kendiliğinden taşımaz,
- freshness'i kendiliğinden bilmez,
- provenance query interface'i değildir,
- model update olduğunda portable kabul edilemez,
- access-control boundary değildir.

Dolayısıyla **cache bir epistemik source değil, source'tan türetilmiş inference artefact'ıdır.**

Bu ayrım SOUL/Development OS açısından load-bearing'dir.

---

## 5. CAG ile sık karıştırılan mekanizmalar

### 5.1. CAG vs Long Context

**Long Context:** bütün büyük context her request'te modele verilebilir ve prefill yeniden hesaplanabilir.

**CAG:** bounded corpus long context'e preload edilir ve onun prefill/KV state'i subsequent queries için reuse edilir.

Basitçe:

```text
Long Context
= full context available

CAG (Chan formulation)
= full bounded context available
+ repeated context stable enough to reuse
+ prefill/KV state cached
+ no query-time retrieval
```

Bu nedenle CAG, Long Context'ten bağımsız bir bilgi erişim sistemi değildir; Long Context kapasitesine ve utilization kalitesine güçlü biçimde bağımlıdır.

### 5.2. CAG vs generic prompt/prefix caching

Prompt/prefix caching, tekrar eden prompt prefix'lerinin prefill hesaplarını reuse eden serving optimization'dır. Prompt Cache (MLSys 2024), vLLM Automatic Prefix Caching ve büyük hosted API'lerin prompt caching mekanizmaları bu aileye girer. [S3][S4][S20][S21][S22]

Generic prompt caching:

- system prompt'u cache edebilir,
- tool definitions cache edebilir,
- conversation history cache edebilir,
- retrieved documents cache edebilir,
- CAG kullanılmadan da çalışabilir,
- RAG ile birlikte de çalışabilir.

CAG ise daha spesifik bir **knowledge architecture choice** yapar: bütün relevant bounded corpus query-time retrieval yerine preloaded context olarak kalır.

Dolayısıyla:

> **Prompt caching CAG'ın enabling mechanism'i olabilir; prompt caching açmak tek başına CAG kurmak değildir.**

### 5.3. CAG vs KV-cache accelerated RAG

TurboRAG, CacheBlend, Cache-Craft ve EPIC gibi sistemler retrieval'ı koruyup retrieved/reused chunks'ın KV computation maliyetini azaltmaya çalışır. [S7][S8][S9][S10]

```text
RAG + KV caching
retrieval var
prefill compute reuse edilir

Chan-CAG
retrieval yok
whole bounded corpus preloaded
```

Bu fark önemli çünkü CAG ile caching arasında “ya hep ya hiç” seçimi yoktur.

### 5.4. CAG vs semantic response cache

Semantic cache benzer query için daha önce oluşturulmuş **cevabı** doğrudan reuse etmeye çalışabilir. GPTCache bunun erken örneklerindendir. [S23]

Bu fundamentally farklıdır:

```text
CAG / KV cache
→ computation state reused
→ model yine yeni output üretir

semantic response cache
→ previous output reused
→ model çağrısı tamamen atlanabilir
```

Semantic cache approximate similarity nedeniyle false-hit correctness problemi üretir. Bu dosyada semantic response cache CAG sayılmaz.

---

## 6. Orijinal CAG paper'ını adversarial okumak

Instagram postundaki:

> `Repeated Stable Context → CAG`

heuristic'ini değerlendirmek için yalnız paper'ın title/abstract'ını değil deney tasarımını ve kendi tablolarını incelemek gerekir.

### 6.1. Deney kapsamı

Chan et al.: [S1]

- Llama 3.1 8B kullandı,
- 8 × Tesla V100 32GB üzerinde çalıştı,
- SQuAD ve HotPotQA kullandı,
- knowledge corpus boyutlarını yaklaşık 21k–85k token aralığında oluşturdu,
- sparse RAG için BM25,
- dense RAG için OpenAI-index tabanlı retrieval kullandı,
- top-1 / top-3 / top-5 / top-10 RAG baselines ile karşılaştırdı,
- answer similarity için BERTScore kullandı.

Bu iyi bir proof-of-concept comparison'dır; fakat production-genel architecture theorem değildir.

### 6.2. Accuracy sonucu “CAG hep daha iyi” değil

Paper'da CAG çoğu split'te en yüksek BERTScore'u alır. Ancak **HotPotQA Large** üzerinde:

```text
Sparse RAG top-5: 0.7535
CAG:              0.7407
```

Yani paper'ın kendi sonucu bile unconditional CAG superiority göstermemektedir. [S1]

Ayrıca corpus büyüdükçe CAG–RAG performance gap'inin daraldığını paper açıkça kabul eder ve bunu long-context degradation ile ilişkilendirir. [S1]

### 6.3. Latency sonucu da “CAG hep daha hızlı” değil

Paper'ın HotPotQA response-time tablosunda sparse RAG top-3'ün retrieval + generation toplamı:

```text
Small:   0.0008 + 0.7406 = 0.7414 s
Medium:  0.0008 + 0.7148 = 0.7156 s
Large:   0.0008 + 0.6667 = 0.6675 s
```

CAG generation süreleri:

```text
Small:   0.8512 s
Medium:  1.4078 s
Large:   2.2631 s
```

Dolayısıyla paper'ın kendi benchmark'ında **sparse RAG top-3 her üç size'da da CAG'dan daha hızlıdır.** [S1]

Dense RAG ile karşılaştırma daha karmaşıktır: CAG small'da daha hızlı, medium'da yaklaşık aynı, large'da dense top-3'ten daha yavaştır.

Bu çok önemli bir correction'dır:

> **CAG'ın retrieval latency'yi sıfırlaması total latency'yi otomatik minimum yapmaz; daha büyük context üzerinde attention/generation maliyeti devam eder.**

### 6.4. CAG'ın en net latency kazancı: uncached full-context'e karşı

Aynı paper CAG'ı standard in-context long-context processing ile de karşılaştırır:

```text
HotPotQA Small
uncached full-context: 9.3197 s
CAG:                  0.8512 s

Medium
uncached full-context: 26.3717 s
CAG:                   1.4078 s

Large
uncached full-context: 92.0824 s
CAG:                   2.2631 s
```

Buradaki çok büyük speedup şunu daha doğrudan kanıtlar:

> **CAG'ın en sağlam sistem avantajı aynı uzun context'in repeated prefill computation'ını amortize etmesidir.**

Bu, “RAG'ı öldürür” iddiasından daha güvenilir ve mekanizmaya daha yakın bir sonuçtur.

### 6.5. Baseline sınırı

Paper modern RAG'ın bütün variation'larını test etmez:

- hybrid retrieval,
- advanced reranking,
- query rewriting/decomposition,
- adaptive retrieval,
- iterative/multi-hop retrieval,
- authority/freshness filtering,
- GraphRAG,
- modern cache-accelerated RAG.

Bu nedenle:

> “CAG traditional baselines'ı bu benchmarklarda geçti”

ile:

> “CAG modern RAG architecture'dan genelde iyidir”

aynı claim değildir.

---

## 7. CAG'ın gerçek önkoşulu: context window'a sığmak değil, **effective context** içinde çalışmak

CAG bütün relevant knowledge'ı context'e koyduğu için Long Context failure'larını miras alır.

### 7.1. Advertised context length ≠ effective context length

RULER, long-context models'ın advertised length'e ulaşmadan önce task complexity arttıkça performans kaybedebildiğini gösterir. Orijinal RULER çalışmasında değerlendirilen modellerin yalnız yaklaşık yarısı 32K'da belirlenen satisfactory threshold'u koruyabilmiştir. [S11]

Long Context RAG çalışması da 20 model üzerinde 2K–128K (bazılarında 2M) aralığında yalnız az sayıda modern modelin 64K üzerindeki accuracy'yi tutarlı koruduğunu raporlamıştır. [S12]

### 7.2. Lost in the Middle

Liu et al. relevant information context'in başında veya sonunda olduğunda performance'ın daha yüksek, middle'da olduğunda daha düşük olabildiğini göstermiştir. [S14]

CAG bütün corpus'u preload ettiği için şu risk doğar:

```text
all knowledge is present
        ≠
all knowledge is equally usable
```

### 7.3. Entire-corpus context query type'a göre avantaj veya yük olabilir

Long-context vs RAG study, yeterli resource ile LC'nin average performance'da RAG'ı geçebildiğini; fakat RAG'ın çok daha düşük maliyet avantajı taşıdığını göstermiş ve hybrid routing önermiştir. [S15]

Bu CAG için şu sonucu destekler:

> Corpus context'e sığıyor diye CAG seçilmemeli; **query workload'ın full-context erişimden gerçekten yararlanıp yararlanmadığı** test edilmelidir.

---

## 8. Stable context ne demek?

Instagram postunun en güçlü sezgisi burada:

> `Repeated Stable Context → CAG`

Ancak “stable” en az dört farklı şeyi ifade edebilir.

### 8.1. Content stability

Source content sık değişmiyor mu?

### 8.2. Eligibility stability

Aynı source set'i tüm query'ler için relevant/eligible mı?

### 8.3. Authority stability

Hangi source'un authoritative/current olduğu sık değişmiyor mu?

### 8.4. Access stability

Aynı user/Actor group'u aynı knowledge'a erişmeye yetkili mi?

Bir corpus text olarak değişmese bile access/authority durumu değişebilir.

Bu nedenle CAG için gerçek condition:

> **Repeated + bounded + reusable + access-consistent + sufficiently stable context.**

“Dosya birkaç gündür değişmedi” tek başına yeterli değildir.

---

## 9. CAG'ın en kritik governance problemi: cache invalidation

RAG query-time retrieval yapar; source/index güncellendiğinde yeni query teorik olarak yeni content'i retrieve edebilir.

CAG ise precomputed state taşır:

```text
source version v1
      ↓
cache-v1

source becomes v2
      ↓
cache-v1 still exists
```

Eğer invalidation closure kurulmazsa model **structured stale inference state** kullanır.

### 9.1. Hangi değişiklik cache'i invalidate edebilir?

En az:

- source content değişti,
- source silindi,
- source superseded oldu,
- authority/status değişti,
- access permission değişti,
- system prompt değişti,
- ordering/prompt template değişti,
- tokenizer/model revision değişti,
- LoRA/adapter değişti,
- positional/scaling configuration değişti,
- cache representation/runtime değişti.

### 9.2. Cache manifest gereksinimi

Project-specific candidate manifest:

```text
cache_id
cache_type
model_id + exact revision
adapter/LoRA identity
model/runtime config
prompt template hash
tokenizer revision
source IDs
source revisions / commit SHAs
source authority status
access scope / tenant
built_at
valid_from / valid_until
invalidation triggers
verification suite version
```

Bu **implementation specification değildir**; cache correctness'ın hangi state'e bağımlı olduğunu görünür kılan research synthesis'tir.

---

## 10. KV cache portability ve positional correctness sanıldığından zor

Naive fikir:

> “Bir document'in KV'sini bir kere hesapla; her yerde kullan.”

her durumda doğru değildir.

KV states context'in önceki token'ları, positional encoding ve attention interactions ile ilişkilidir. Bu nedenle arbitrary document chunks'ın precomputed caches'ini farklı prefixes/positions altında birleştirmek quality kaybı yaratabilir.

Bu problem ayrı systems research üretmiştir:

- Prompt Cache reusable modules için positional correctness sağlar. [S3]
- CacheBlend selective recomputation ile independently cached chunks arasındaki missing cross-attention'ı düzeltir. [S8]
- EPIC position-independent caching'in accuracy sorunlarını ele alır. [S10]
- Cache-Craft arbitrary context positions için chunk-cache reuse'da recomputation yapar. [S9]
- TurboRAG reordered positional encoding / independent attention gibi mechanisms kullanır. [S7]

Bu evidence'in genel dersi:

> **KV cache source text'in universal portable embedding'i değildir; inference context ve model configuration ile bağlı computational state'tir.**

---

## 11. Hosted provider prompt caching CAG'ı otomatik sağlamaz

2026'da major APIs prompt/context caching sağlıyor, fakat semantics provider-specific.

### 11.1. Google Gemini

Gemini API implicit caching'i modern modellerde default destekler; explicit context cache objects için TTL tanımlanabilir. Google büyük/common content'i prompt başına koymayı cache-hit için önerir. [S20]

### 11.2. Anthropic

Claude prompt caching 5-minute default ve 1-hour optional TTL'ler sunar; cached content system/messages/documents/tools olabilir. [S21]

### 11.3. OpenAI

OpenAI API prompt caching cached prefixes üzerinden cost/latency reduction sağlar; current API caching controls model ve endpoint generation'ına göre değişmektedir. [S22]

### 11.4. Project consequence

Provider cache:

- TTL ile expire olabilir,
- eviction olabilir,
- prefix layout'a bağımlı olabilir,
- API/model version'a bağlı olabilir,
- user kontrolünde disk-persistent CAG cache'i olmayabilir.

Bu nedenle:

> **“Provider prompt caching destekliyor → CAG deployment hazır” sonucu geçersizdir.**

CAG implementation feasibility provider/runtime contract'ına ayrı ayrı bağlıdır.

---

## 12. Agentic workloads: stable-prefix / dynamic-suffix ayrımı gerçek değer taşıyor

2026 `Don't Break the Cache` çalışması 500'den fazla long-horizon agent session ve 10k-token system prompt ile OpenAI/Anthropic/Google prompt caching strategies'ini karşılaştırmıştır. Çalışma prompt caching'in API cost'larını %45–80, TTFT'yi %13–31 azaltabildiğini; fakat naive full-context caching'in bazı durumlarda latency'yi artırabildiğini raporlamıştır. Dynamic content'i sona koymak ve tool results gibi volatile content'i stable prefix'ten ayırmak daha tutarlı sonuç vermiştir. [S16]

Bu **Chan-CAG benchmark'ı değildir**, fakat Development OS/SOUL açısından çok önemli bir systems-level discriminator sağlar:

```text
stable reusable prefix
        +
dynamic mutable suffix
```

ayrımı cache efficiency için gerçekten yük taşıyabilir.

Bu finding `00-WHY-THIS-RESEARCH.md` içindeki H5 hipotezini destekler; fakat “Development OS CAG kullanmalıdır” sonucunu vermez.

---

## 13. CAG retrieval failure'ı kaldırırken yeni failure sınıfı yaratır

RAG failure:

```text
relevant source exists
→ retriever misses it
→ model never sees it
```

CAG bunu bounded corpus içinde azaltabilir çünkü bütün corpus context'tedir.

Fakat yeni failure:

```text
wrong / stale / unauthorized source
→ cache construction includes it
→ every query sees its derived state
```

Bu durumda query-time retrieval filter da yoktur.

Dolayısıyla CAG:

> retrieval selection problem'ini ortadan kaldırabilir,

ama:

> **corpus eligibility problem'ini cache-build time'a taşır.**

SOUL açısından bu daha iyi olabilir veya daha kötü olabilir; depende on corpus governance.

---

## 14. Authority ve provenance CAG'da daha da kritik olabilir

### 14.1. CAG source authority üretmez

Corpus'a şu belgelerin hepsinin girdiğini düşünelim:

```text
current policy
superseded policy
historical proposal
exploratory note
user draft
```

CAG hepsini preload ederse model bütün conflict'leri görür fakat hangisinin authoritative olduğunu cache mechanism belirlemez.

Bu nedenle CAG corpus selection şu metadata'ya bağımlı olabilir:

- canonical/current,
- superseded,
- source vs synthesis,
- epistemic status,
- version/SHA,
- valid time,
- Actor/access scope.

### 14.2. Query-time citation hâlâ ayrı problem

KV state preloaded source'dan türetilmiş olsa bile output claim'in exact source span'ıyla bağlanması otomatik değildir.

CAG provenance candidate pattern:

```text
cache contains source manifest
        +
model output cites source IDs/spans
        +
verification checks cited source directly
```

Ama bunun capability olarak ayrıca kurulması gerekir.

> **CAG source availability sağlar; source attribution correctness sağlamaz.**

---

## 15. Freshness: CAG'ın Development OS için en sert sınırı

Development OS current state'e dayanır:

- current Work,
- current authorization,
- current next action,
- current canonical protocol,
- current branch/SHA,
- current research status.

Bunlar tam olarak CAG'ın en riskli bilgi sınıfına yakındır: **yük taşıyan ve değişebilir state.**

Örneğin:

```text
STATE.md @ commit A
   ↓ cache-A

repository advances to commit B
   ↓
model still runs cache-A
```

Bu durum cold-start'ın temel amacını bozar.

Dolayısıyla mevcut project rules altında:

> **CAG, canonical source recovery'nin yerine geçemez.**

Özellikle `AGENT.md` için project bootstrap açıkça her yeni conversation'da canonical GitHub sürümünün yeniden okunmasını zorunlu kılar. Cached copy bu requirement'ı ikame edemez.

Ancak fresh canonical read sonrasında, **aynı verified revision'ın tekrar tekrar işlenmesinin compute maliyetini azaltmak** ayrı bir cache optimization konusu olabilir. Bu distinction critical'dir:

```text
canonical freshness check
        ≠
repeated compute reuse
```

---

## 16. Development OS için aday stable/dynamic ayrımı

Aşağıdaki tablo **architecture design değildir**; research decision frame'dir.

| Context class | CAG/cache candidate status | Ana neden |
|---|---|---|
| Immutable source at exact SHA | güçlü aday | content identity doğrulanabilir |
| Long stable reference package | güçlü/koşullu | repeated full-context reuse değerli olabilir |
| Stable prompt/tool schema | generic prompt cache için güçlü aday | yüksek repetition, düşük semantic change |
| Current `STATE.md` | zayıf cross-session default | freshness yük taşıyor |
| Authorization/current Work | çok zayıf stale-cache tolerance | yanlış state action riskine dönüşebilir |
| Dynamic web/current facts | zayıf CAG default | change rate yüksek |
| Historical evidence corpus | koşullu | bounded package ise full-context faydalı olabilir; authority qualifiers gerekli |
| Mixed stable + dynamic package | hybrid güçlü aday | stable prefix + fresh retrieval/direct read |

Bu nedenle Development OS açısından en güçlü candidate pattern:

```text
verified stable context
        ↓ cache/reuse
+
fresh mutable state
        ↓ canonical recovery / retrieval
```

Bu **CAG architecture kararı değil**, araştırmanın görünür kıldığı boundary'dir.

---

## 17. Security / privacy: KV cache yeni bir protected asset'tir

KV cache plaintext prompt değildir, fakat input hakkında bilgi taşıyan internal representations içerir.

2024–2026 security research shared KV/prefix caches'in multi-tenant timing side channels ve prompt leakage üretebildiğini göstermiştir. NDSS 2025 PROMPTPEEK çalışması shared KV cache reuse üzerinden başka kullanıcıların prompt'larını infer/reconstruct etme riskini göstermiştir. ICML 2025 API prompt-caching audit'i birden fazla real-world provider'da global cache-sharing signals tespit etmiştir. vLLM güncel security docs bu risk için cache salting desteği sağlar. [S24][S25][S26]

2025–2026 KV-cache inversion/reconstruction literature internal cache state'in doğrudan korunması gerektiğini ayrıca gösterir. [S27]

CAG için bu daha önemlidir çünkü cache büyük bir knowledge corpus'u temsil edebilir.

Minimum security questions:

- cache hangi tenant/Actor'a ait?
- cross-user reuse var mı?
- cache key namespace isolated mı?
- disk persistence encrypted mı?
- TTL/retention nedir?
- deletion source deletion'ı takip ediyor mu?
- permission change cache'i invalidate ediyor mu?
- cache-hit timing side channel var mı?
- provider cache retention/privacy contract'ı nedir?

Bu nedenle cache yalnız performance object değil, **governed data-derived asset**'tir.

---

## 18. Cache hit ratio tek başına başarı metriği değildir

CAG/cache system'lerde tempting metrics:

- hit rate,
- TTFT,
- throughput,
- GPU utilization,
- input-token savings.

Bunlar gerekli olabilir ama yeterli değildir.

SOUL/Development OS için evaluation en az şu katmanlara ayrılmalıdır:

### 18.1. Cache identity correctness

Doğru model/source/prompt revision cache'i mi kullanıldı?

### 18.2. Freshness correctness

Source değiştiğinde cache gerçekten invalidated mı?

### 18.3. Access correctness

Actor yalnız yetkili cache state'e erişiyor mu?

### 18.4. Context utilization

Model full cached corpus'taki load-bearing evidence'i gerçekten kullanabiliyor mu?

### 18.5. Answer/evidence correctness

Output source'la supported mı?

### 18.6. Cold-start vs warm-path performance

- cache creation cost,
- cache load latency,
- hit latency,
- miss latency,
- eviction/rebuild cost

ayrı ölçülmelidir.

### 18.7. Invalidation tests

Test suite deliberately şu değişiklikleri yapmalı:

- source edit,
- source deletion,
- permission change,
- model upgrade,
- system-prompt change,
- corpus reorder,
- tenant switch.

Eski cache hâlâ hit ederse test kırmızı vermelidir.

### 18.8. Security verification

- cross-tenant cache isolation,
- timing leakage,
- persistence/deletion,
- cache artifact access.

“Warm path hızlı” validation değildir.

---

## 19. CAG'ın güçlü olduğu workload sınıfları

CAG güçlü adaydır eğer:

### 19.1. Corpus bounded ise

Knowledge set effective context'e güvenilir biçimde sığıyorsa.

### 19.2. Corpus stable ise

Update/invalidation sıklığı cache amortization'ı bozmuyorsa.

### 19.3. Aynı corpus'a çok query geliyorsa

One-time prefill/cache build cost birçok request'e yayılıyorsa.

### 19.4. Query'ler corpus-wide synthesis gerektiriyorsa

Relevant evidence'in hangi parçada olduğunu önceden seçmek zor ve retrieval omission önemliyse.

### 19.5. Retrieval infrastructure complexity gerçekten yükseklik yaratıyorsa

Retriever/index/chunk/rerank pipeline complexity'si workload'a göre gereksizse.

### 19.6. Exact whole-document context önemliyse

Contracts, bounded reports, manuals, code/document package gibi full-context dependence yüksekse.

Ama bunların hepsi benchmark edilmelidir.

---

## 20. CAG'ın zayıf olduğu workload sınıfları

### 20.1. Rapidly changing knowledge

Live operational state, prices, inventory, news, incidents, mutable authorization.

### 20.2. Corpus çok büyükse

Context'e fiziksel/effective olarak sığmıyorsa.

### 20.3. Query workload lokal fact lookup ağırlıklıysa

Tiny relevant subset'i retrieve etmek full corpus attention'dan daha ucuz olabilir.

### 20.4. Multi-tenant access scopes farklıysa

Her user için farklı corpus eligibility varsa giant shared cache authorization riskini büyütebilir.

### 20.5. Source-level provenance/citation critical ise

CAG bunu otomatik çözmez; extra mapping/verification gerekir.

### 20.6. Cache reuse düşükse

Corpus bir kere sorulacaksa precompute/persistence complexity'si amortize olmayabilir.

### 20.7. Provider/runtime persistent cache guarantee vermiyorsa

TTL/eviction/cache API semantics CAG economics'ini bozabilir.

---

## 21. RAG vs CAG: daha doğru decision frame

Basit framing:

```text
Large external knowledge → RAG
Repeated stable context → CAG
```

yararlı ama yeterli değildir.

Daha güçlü frame:

| Condition | RAG eğilimi | CAG eğilimi |
|---|---|---|
| Corpus size | büyük/unbounded | bounded/effective-context fit |
| Change rate | yüksek olabilir | düşük olmalı |
| Query locality | küçük relevant subset | broad/full-context reuse |
| Reuse | query-specific retrieval | same corpus many queries |
| Retrieval omission cost | moderate/manageable | yüksek olabilir |
| Full-context compute cost | selected chunks | amortized by cache |
| Source update | index refresh | cache rebuild/invalidation |
| Access scopes | query-time filtering possible | cache partitioning/build-time eligibility needed |
| Citation/provenance | retrieved source naturally visible | extra attribution mapping required |
| Infrastructure | retriever/index complexity | cache lifecycle/runtime complexity |

Son satır özellikle önemlidir:

> **CAG complexity'yi yok etmez; retrieval complexity'sini cache-lifecycle complexity'siyle değiştirir.**

---

## 22. Hybrid CAG + RAG güçlü bir ayrı seçenek

Chan et al. paper'ın conclusion'ı bile hybrid possibility'yi açık bırakır: foundation context preload edilir, edge cases için selective retrieval kullanılabilir. [S1]

Candidate hybrid:

```text
Stable bounded foundation
        ↓
CAG / cached long context

Dynamic / rare / external tail
        ↓
RAG / direct-source / tool retrieval

        ↓
Combined working context
```

Bu özellikle SOUL için güçlü conceptual fit olabilir çünkü task-specific system farklı knowledge regimes'i aynı mekanizmaya zorlamak zorunda değildir.

Ancak hybrid'in kendi complexity'si vardır:

- duplicate/conflicting knowledge,
- source priority,
- cache vs retrieved freshness,
- context-budget allocation,
- provenance merge,
- retrieval decision policy.

Dolayısıyla hybrid de ücretsiz çözüm değildir.

---

## 23. CAG + Knowledge Graph

Knowledge Graph relation-centric representation; CAG context reuse mechanism'idir.

Birlikte kullanılabilirler:

```text
canonical graph / relation source
       ↓ serialize/summarize
stable bounded graph view
       ↓
cache
```

Ama graph dynamic ise derived cache'in invalidation closure'u gerekir.

Graph'taki source-observed / inferred / predicted epistemic distinctions serialization sırasında kaybolursa CAG onları kurtarmaz.

Bu nedenle CAG + KG için load-bearing question:

> **Cached view graph'ın provenance/time/status semantics'ini koruyor mu?**

---

## 24. CAG + Fine-Tuning

Fine-Tuning model parameters/behavior'ı adapte eder; CAG runtime context computation'ı reuse eder.

Örnek candidate composition:

```text
fine-tuned domain extractor/model
+
stable domain manual cached as context
```

Bunlar farklı katmanlardır.

Fine-tuned model/base version değişirse eski KV cache invalid kabul edilmelidir; adapter identity cache compatibility'nin parçasıdır. vLLM prefix caching tasarımı bile LoRA IDs gibi extra hashes'i cache key'e dahil eder. [S4]

---

## 25. CAG + Long Context

Bu pair diğer kombinasyonlardan farklıdır.

Chan-style CAG zaten Long Context'e dayanır:

> **Long Context capacity/utilization CAG'ın substrate'ıdır; KV caching onun repeated-use efficiency layer'ıdır.**

Bu nedenle `CAG` ve `Long Context` Instagram listesindeki tamamen bağımsız eş düzey seçenekler değildir.

Sonraki `05-LONG-CONTEXT.md` şu ayrımı daha derin araştıracaktır:

```text
Can the model accept the context?
        vs
Can the model use the context?
        vs
Should we pay to process all of it?
        vs
Can repeated processing be cached?
```

---

## 26. SOUL açısından değerlendirme

### 26.1. CAG bir “knowledge store”dan çok context-reuse capability olarak daha doğru konumlanıyor

SOUL'un intended outcome'a göre working system oluşturma hedefinde bazı task'lar:

- bounded manuals,
- stable domain package,
- fixed contract corpus,
- repeated technical reference,
- immutable evidence bundle

üzerinde çok sayıda Work çalıştırabilir.

Bu durumlarda CAG-like capability:

- retrieval omission'ı azaltabilir,
- repeated prefill maliyetini amortize edebilir,
- exact package context'i bütün olarak tutabilir.

Ama cache'in kendisi SOUL truth layer olmamalıdır.

### 26.2. CAG selection için candidate gate

Architecture proposal değil, research decision frame:

1. Knowledge source bounded mı?
2. Effective context test edildi mi?
3. Corpus gerçekten stable mı?
4. Authority/access scope stable mı?
5. Aynı corpus çok kez kullanılacak mı?
6. Queries broad/full-context benefit taşıyor mu?
7. Retrieval baseline gerçekten failure/cost üretiyor mu?
8. Cache invalidation exact ve observable mı?
9. Source attribution gerekiyor mu?
10. Model/runtime exact cache reuse destekliyor mu?
11. Security isolation kurulabiliyor mu?
12. RAG/hybrid daha basit veya daha güvenli mi?

### 26.3. Fail-visible CAG

CAG system şu state'leri ayırt edebilmelidir:

```text
cache valid
cache missing
cache expired
cache source revision mismatch
cache model revision mismatch
cache authorization mismatch
cache verification stale
```

Hepsini “cache hit gibi devam et” yoluna çevirmek doğru değildir.

---

## 27. Development OS açısından değerlendirme

### 27.1. CAG'ın cazibesi gerçek

Development OS sürekli aynı tür büyük context'i işleyebilir:

- agent-control files,
- stable research synthesis,
- methodology documents,
- repeated repository reference packages.

Bunların repeated prefill'i compute/cost oluşturabilir.

### 27.2. Fakat canonical source authority öncelikli

Development OS'nin temel ilkesi:

> repository state authoritative; chat/model memory değil.

KV cache de bir çeşit derived runtime memory'dir.

Dolayısıyla candidate hierarchy:

```text
canonical source identity/freshness
        ↓ must be checked
validated context package
        ↓ may be cached/reused
KV/prompt cache
        ↓ acceleration only
LLM work
```

Bu ordering ters çevrilmemelidir.

### 27.3. `AGENT.md` özel örneği

Project bootstrap her new conversation canonical `AGENT.md`'nin fresh read'ini zorunlu tutmaktadır.

Bu nedenle:

```text
cached AGENT state exists
        ≠
AGENT fresh-read requirement satisfied
```

CAG yalnız canonical file read sonrası exact revision'ın tekrar compute edilmesini optimize edebilir; source retrieval requirement'ı kaldırmaz.

### 27.4. Current `STATE.md` özel örneği

Current Work/authorization/next action değişebildiği için cross-session cached STATE stale-risk yüksektir.

Bu yüzden `STATE.md` CAG'ın Instagram tanımındaki “repeated stable context” sınıfına otomatik girmez.

### 27.5. Development OS için en güçlü project synthesis

> **Stable verified context'i cache et; dynamic authoritative state'i fresh recover et.**

Bu architecture decision değildir; `H5 — stable context / dynamic state ayrımı` için güçlü research support'tur.

---

## 28. Decision boundary

### Use when

CAG güçlü adaydır eğer:

- relevant knowledge corpus bounded ve effective context içinde ise,
- corpus aynı workload boyunca sufficiently stable ise,
- same corpus üzerinde çok sayıda query/work yapılacaksa,
- whole-context access query quality için değerliyse,
- retrieval omission önemli failure ise,
- one-time cache build cost amortize oluyorsa,
- runtime persistent/prefix cache support güvenilir ise,
- invalidation/versioning/security lifecycle kurulabiliyorsa.

### Avoid as default when

CAG zayıf/default-olmaması gereken adaydır eğer:

- source hızlı değişiyorsa,
- current authority/state knowledge'ın ana parçasıysa,
- corpus effective context'i aşıyorsa,
- workload mostly tiny fact lookup ise,
- user access scopes çok farklıysa,
- exact provenance/citation yük taşıyorsa ama mapping yoksa,
- cache invalidation güvenilir değilse,
- reuse frequency düşükse,
- provider TTL/eviction semantics use case'e uymuyorsa,
- sırf “RAG karmaşık” olduğu için alternative baseline ölçülmeden öneriliyorsa.

### Needs evidence before architecture decision

1. Corpus token size ve growth rate nedir?
2. Advertised değil **effective context** hangi modelde kaçtır?
3. Source update/churn rate nedir?
4. Query reuse rate nedir?
5. Query workload fact-local mı, corpus-global mı?
6. RAG baseline accuracy/latency/cost nedir?
7. Full-context uncached baseline nedir?
8. Cache cold-build, load, hit, miss, rebuild cost'ları nedir?
9. Source authority/access boundaries nelerdir?
10. Required provenance granularity nedir?
11. Cache invalidation triggers nelerdir?
12. Model/runtime version compatibility contract'ı nedir?
13. Provider TTL/eviction semantics nedir?
14. Cross-tenant privacy threat model'i nedir?
15. Hybrid CAG + RAG measurable value sağlıyor mu?
16. Context-position / long-context regression testleri nedir?
17. Cache stale olduğunda downstream harm nedir?

### Does not prove

Bu araştırma şunları kanıtlamaz:

- SOUL CAG kullanmalıdır.
- Development OS canonical files'ı cache'den okumalıdır.
- CAG RAG'dan daha iyidir.
- CAG RAG'dan daha hızlıdır.
- CAG Long Context'ten bağımsız bir stratejidir.
- Prompt caching = CAG'dır.
- KV cache persistent knowledge database'dir.
- Cache hit factual correctness'tır.
- Stable document cache-safe demektir.
- Büyük context'e sığan corpus güvenilir biçimde kullanılabilir.
- Provider prompt cache'in varlığı application-level CAG architecture'ını garanti eder.

---

## 29. Bulgular

### F-CAG-01 — “CAG” emerging ve overloaded bir terimdir

**Confidence:** high  
**Basis:** independent papers using CAG for Cache-Augmented Generation, Context Awareness Gate ve Credibility-aware Generation. [S1][S18][S19]

Bu package exact term'i açıkça sabitlemelidir.

### F-CAG-02 — Chan-style CAG'ın özü retrieval-free bounded long context + reusable KV state'tir

**Confidence:** high  
**Basis:** original paper methodology. [S1]

CAG'ın primary mechanical advantage'ı repeated prefill'i amortize etmektir.

### F-CAG-03 — Prompt/prefix caching CAG değildir; CAG'ın enabling optimization'ı olabilir

**Confidence:** high  
**Basis:** MLSys Prompt Cache, vLLM, provider docs. [S3][S4][S20][S21][S22]

### F-CAG-04 — CAG RAG'dan universal olarak daha hızlı veya daha doğru değildir

**Confidence:** high  
**Basis:** original CAG paper'ın kendi accuracy/latency tabloları. [S1]

HotPotQA-large accuracy ve sparse-RAG latency sonuçları unconditional superiority claim'ini doğrudan reddeder.

### F-CAG-05 — CAG'ın en net benchmark avantajı uncached full-context prefill'e karşıdır

**Confidence:** high  
**Basis:** original paper response-time comparison. [S1]

Bu sonuç caching mechanism'in gerçek compute value'sunu RAG-vs-CAG rhetoric'inden daha temiz izole eder.

### F-CAG-06 — CAG advertised context length'e değil effective context utilization'a bağlıdır

**Confidence:** high  
**Basis:** RULER, Lost in the Middle, Long Context RAG. [S11][S12][S14]

### F-CAG-07 — CAG retrieval omission'ı azaltabilir fakat corpus eligibility failure'ını cache-build time'a taşır

**Confidence:** high as synthesis  
**Basis:** CAG mechanism + RAG/source-governance findings.

### F-CAG-08 — Freshness/invalidation CAG correctness'ın first-class parçasıdır

**Confidence:** high  
**Basis:** mechanism analysis + cache/runtime/version dependency literature. [S3][S4][S8][S9][S10]

### F-CAG-09 — KV cache portable semantic memory değildir

**Confidence:** high  
**Basis:** position-independent/cache-composition research. [S8][S9][S10]

Model/prefix/position/runtime configuration cache correctness'ı etkiler.

### F-CAG-10 — Cache security least-privilege / tenant isolation gerektirir

**Confidence:** high  
**Basis:** NDSS/ICML KV/prompt-cache security research + vLLM mitigation. [S24][S25][S26][S27]

### F-CAG-11 — Stable-prefix / dynamic-suffix ayrımı agentic workloads için measurable operational value taşır

**Confidence:** medium-high  
**Basis:** 2026 prompt-caching agent benchmark. [S16]

Bu Chan-CAG validation değil; supporting systems evidence'tir.

### F-CAG-12 — Development OS current mutable state'i cross-session CAG'a taşımak zayıf default'tur

**Confidence:** high as project-specific synthesis  
**Basis:** repository-authoritative Dev OS + CAG invalidation/freshness findings.

### F-CAG-13 — Development OS için cache canonical recovery'yi değil repeated compute'u optimize edebilir

**Confidence:** high as project-specific synthesis  
**Basis:** canonical source policy + cache mechanism.

### F-CAG-14 — CAG + RAG hybrid, stable foundation + dynamic tail için önemli candidate'dır

**Confidence:** medium-high  
**Basis:** original CAG conclusion + modern cache-accelerated RAG literature. [S1][S7][S8][S9]

### F-CAG-15 — CAG ve Long Context eş düzey tamamen bağımsız kategoriler değildir

**Confidence:** high  
**Basis:** CAG mechanism.

Long Context CAG'ın knowledge substrate'ı; cache onun repeated-use compute layer'ıdır.

### F-CAG-16 — `Repeated Stable Context → CAG` useful heuristic'tir fakat eksiktir

**Confidence:** high  
**Basis:** full synthesis.

Daha doğru condition:

> **Repeated + bounded + effective-context-usable + sufficiently stable + access-consistent + cache-reusable context → CAG candidate.**

---

## 30. Açık sorular — architecture öncesi gerekli bilgi

1. SOUL runtime'da gerçekten bounded/repeated knowledge packages oluşturacak mı?
2. Stable context ile mutable state operational olarak nasıl ayrılacak?
3. `stable` için acceptable source-churn threshold ne olacak?
4. Hangi cache class'ları source SHA ile cryptographically bound olmalı?
5. Development OS current STATE cache policy'si nasıl olmalı?
6. Canonical recovery sonrası cache-hit optimization uygulanabilir mi?
7. Hangi provider/runtime persistent cache semantics gerekiyor?
8. Cache model-version compatibility nasıl temsil edilmeli?
9. Tenant/Actor cache isolation nasıl yapılmalı?
10. Source delete/supersede cache deletion'ını nasıl tetikleyecek?
11. CAG output provenance nasıl source spans'a bağlanacak?
12. Local SOUL corpus'ta CAG vs progressive retrieval vs RAG benchmark sonucu nedir?
13. Query classes hangileri whole-context advantage taşıyor?
14. Cache cold-build + storage + transfer cost amortization threshold nedir?
15. Effective context model-specific olarak nasıl benchmark edilecek?
16. CAG + RAG hybrid routing hangi evidence'e göre seçilecek?
17. Cache poisoning / unauthorized build threat model'i ne olacak?
18. Cache verification stale olduğunda revalidation gate nasıl çalışacak?
19. Hosted provider cache TTL'leri long-running SOUL workloads için yeterli mi?
20. Long Context research sonunda CAG decision boundary hangi ölçüde yeniden çizilmeli?

---

## 31. Araştırma yöntemi ve sınırlar

Bu çalışma:

- original Cache-Augmented Generation paper,
- Long Context vs RAG literature,
- effective-context benchmarks,
- generic prompt/prefix caching research,
- KV-cache composition/position-independence systems research,
- cache-accelerated RAG systems,
- 2026 cache-augmented RAG survey,
- hosted-provider prompt/context caching documentation,
- agentic prompt-caching evaluation,
- KV-cache privacy/security literature

üzerinden cross-source synthesis yapmıştır.

### Bilinçli sınırlar

- SOUL corpus üzerinde CAG implementation çalıştırılmamıştır.
- Cache build/load/TTFT local benchmark yapılmamıştır.
- Provider-specific production pricing architecture seçimi yapılmamıştır.
- Exact KV cache persistence format seçilmemiştir.
- CAG security red-team yapılmamıştır.
- Original CAG paper'ın BERTScore sonuçları factual correctness'ın universal oracle'ı sayılmamıştır.
- Original paper'ın two-dataset/single-model benchmark'ı universal architecture law'a çevrilmemiştir.
- Prompt caching benchmark'ı Chan-CAG validation gibi sunulmamıştır.
- RULER/Lost-in-the-Middle results current tüm modeller için immutable performance claim'i sayılmamıştır.
- Vendor/provider docs performance guarantee veya architecture recommendation olarak kullanılmamıştır.
- Semantic cache CAG ile aynılaştırılmamıştır.
- Context Awareness Gate / Credibility-aware Generation bu package'ın CAG nesnesiyle karıştırılmamıştır.

### Stopping rationale

Araştırma boundedly closed kabul edilmiştir çünkü farklı evidence hatları aynı load-bearing ayrımlarda yakınsamıştır:

- Chan-CAG = bounded long context + precomputed/reused KV + no query-time retrieval,
- generic caching ile CAG aynı değildir,
- CAG'ın real advantage'ı repeated prefill amortization'dır,
- universal RAG superiority evidence yoktur,
- effective context advertised context'ten ayrılmalıdır,
- freshness/invalidation correctness'ın parçasıdır,
- cache model/prefix/access identity'ye bağlıdır,
- KV cache protected derived state'tir,
- SOUL/Dev OS için stable vs dynamic context ayrımı yük taşıyabilir,
- canonical recovery cache ile ikame edilmemelidir.

Yeni kaynaklar implementation detail ekleyebilir; ancak bu package'ın **SOUL / Development OS relevance ve decision-boundary** hedefi için ana sonuçların değişme olasılığı düşmüştür.

---

## 32. Source ledger

### Cache-Augmented Generation — primary

**[S1] Chan, B. J., Chen, C.-T., Cheng, J.-H., Huang, H.-H. (2025). _Don't Do RAG: When Cache-Augmented Generation is All You Need for Knowledge Tasks_. Companion Proceedings of the ACM Web Conference 2025.**  
DOI: 10.1145/3701716.3715490  
https://arxiv.org/abs/2412.15605  
Use: authoritative Cache-Augmented Generation definition, methodology, benchmark, latency/accuracy tables, limitations and hybrid note.  
Limit: short paper; one base model, two QA datasets, 21k–85k test corpora, selected RAG baselines; not universal production comparison.

**[S2] Huang et al. CAG implementation repository.**  
https://github.com/hhhuang/CAG  
Use: author implementation and explicit stated limitations.  
Limit: implementation artefact, not independent evidence.

### Prompt / prefix / KV caching systems

**[S3] Gim, I. et al. (2024). _Prompt Cache: Modular Attention Reuse for Low-Latency Inference_. MLSys 2024.**  
https://proceedings.mlsys.org/paper_files/paper/2024/hash/a66caa1703fe34705a4368c3014c1966-Abstract-Conference.html  
Use: reusable attention-state modules; repeated-context latency reduction; positional correctness.

**[S4] vLLM. _Automatic Prefix Caching_. Current read 2026-09-03.**  
https://docs.vllm.ai/en/latest/design/prefix_caching/  
Use: exact-prefix block reuse, cache key dependencies, LoRA/multimodal extra hashes, security salting.  
Limit: implementation documentation.

**[S5] Li, Y. et al. (2025). _SCBench: A KV Cache-Centric Analysis of Long-Context Methods_. ICLR 2025.**  
https://proceedings.iclr.cc/paper_files/paper/2025/hash/a540b17fb2295c736d5afd6c507acf66-Abstract-Conference.html  
Use: KV lifecycle—generation, compression, retrieval, loading—as distinct evaluation surfaces.

**[S6] Jin, S. et al. (2025). _Compute or Load KV Cache? Why Not Both?_ ICML 2025.**  
https://proceedings.mlr.press/v267/jin25d.html  
Use: cache loading vs computation trade-off; storage I/O can become bottleneck.

### Caching + RAG / composable KV

**[S7] Lu, S. et al. (2025). _TurboRAG: Accelerating Retrieval-Augmented Generation with Precomputed KV Caches for Chunked Text_. EMNLP 2025.**  
https://aclanthology.org/2025.emnlp-main.334/  
Use: retrieval retained while document KVs are precomputed; CAG-vs-cache-accelerated-RAG distinction.

**[S8] Yao, J. et al. (2025). _CacheBlend: Fast Large Language Model Serving for RAG with Cached Knowledge Fusion_. EuroSys 2025.**  
https://www.microsoft.com/en-us/research/publication/you-only-prefill-once-combining-cached-knowledge-for-large-language-model-serving-with-cacheblend/  
Use: arbitrary cached chunks need cross-attention repair/selective recomputation; TTFT/throughput evidence.

**[S9] Agarwal, S. et al. (2025). _Cache-Craft: Managing Chunk-Caches for Efficient Retrieval-Augmented Generation_.**  
https://arxiv.org/abs/2502.15734  
Use: naive KV reuse at arbitrary contexts can degrade quality; selective recomputation/cache management.

**[S10] Hu, J. et al. (2025). _EPIC: Efficient Position-Independent Caching for Serving Large Language Models_. ICML 2025.**  
https://proceedings.mlr.press/v267/hu25j.html  
Use: exact-prefix limitation and position-independent cache reuse challenges.

### Long Context capability / CAG substrate

**[S11] Hsieh, C.-P. et al. (2024). _RULER: What's the Real Context Size of Your Long-Context Language Models?_**  
https://arxiv.org/abs/2404.06654  
Use: advertised vs effective context distinction; multi-hop/aggregation beyond simple needle retrieval.

**[S12] Leng, Q. et al. (2024). _Long Context RAG Performance of Large Language Models_.**  
https://arxiv.org/abs/2411.03538  
Use: long-context performance across 20 models and 2k–128k/2M ranges; few models robust above 64k in study.

**[S13] Li, T. et al. (2024). _Long-context LLMs Struggle with Long In-context Learning_.**  
https://arxiv.org/abs/2404.02060  
Use: long context capacity does not guarantee complex context-rich task performance.

**[S14] Liu, N. F. et al. (2024). _Lost in the Middle: How Language Models Use Long Contexts_. TACL 12:157–173.**  
DOI: 10.1162/tacl_a_00638  
https://aclanthology.org/2024.tacl-1.9/  
Use: position-dependent long-context utilization failure.

**[S15] Li, Z. et al. (2024). _Retrieval Augmented Generation or Long-Context LLMs? A Comprehensive Study and Hybrid Approach_. EMNLP Industry 2024.**  
https://aclanthology.org/2024.emnlp-industry.66/  
Use: LC vs RAG cost/performance trade-off and hybrid routing evidence.

### Agentic / operational caching

**[S16] Lumer, E. et al. (2026). _Don't Break the Cache: An Evaluation of Prompt Caching for Long-Horizon Agentic Tasks_.**  
https://arxiv.org/abs/2601.06007  
Use: multi-provider agentic cache strategy; stable-prefix/dynamic-content layout; cost/TTFT evidence.  
Limit: prompt caching study, not retrieval-free Chan-CAG benchmark.

**[S17] Khaliq, A. et al. (2026). _A comprehensive survey on cache-augmented retrieval-augmented generation: performance metrics and future directions_. Journal of Supercomputing 82(8):477.**  
DOI: 10.1007/s11227-026-08604-4  
Use: current broad caching/RAG landscape and cache as primary pipeline design dimension.  
Limit: broader than narrow Chan-CAG.

### Acronym / taxonomy collisions

**[S18] Heydari, M. H. et al. (2024). _Context Awareness Gate For Retrieval Augmented Generation_.**  
https://arxiv.org/abs/2411.16133  
Use: demonstrates `CAG` acronym collision; mechanism is retrieval gate, not cache-augmented generation.

**[S19] Pan, R. et al. (2024). _Not All Contexts Are Equal: Teaching LLMs Credibility-aware Generation_.**  
https://arxiv.org/abs/2404.06809  
Use: demonstrates another `CAG` acronym collision.

### Current provider caching examples

**[S20] Google AI for Developers. _Context caching — Gemini API_. Current read 2026-09-03.**  
https://ai.google.dev/gemini-api/docs/caching  
Use: implicit/explicit context caching, prompt-prefix layout and TTL/runtime dependence.  
Limit: provider-specific current documentation.

**[S21] Anthropic. _Prompt caching — Claude API_. Current read 2026-09-03.**  
https://platform.claude.com/docs/en/build-with-claude/prompt-caching  
Use: 5m/1h TTL, cacheable prompt sections, retention/isolation example.  
Limit: provider-specific current documentation.

**[S22] OpenAI. _Prompt Caching / current API prompt-cache controls_. Current read 2026-09-03.**  
https://openai.com/index/api-prompt-caching/  
https://developers.openai.com/api/reference/  
Use: current example of managed prefix caching semantics and version-dependent controls.  
Limit: provider-specific documentation; current contracts can change.

### Semantic cache distinction

**[S23] Fu, B., Feng, D. (2023). _GPTCache: An Open-Source Semantic Cache for LLM Applications_. NLP-OSS 2023.**  
DOI: 10.18653/v1/2023.nlposs-1.24  
https://aclanthology.org/2023.nlposs-1.24/  
Use: response-level semantic caching distinction from KV-state CAG.

### Security / privacy

**[S24] Wu, G. et al. (2025). _I Know What You Asked: Prompt Leakage via KV-Cache Sharing in Multi-Tenant LLM Serving_. NDSS 2025.**  
https://www.ndss-symposium.org/ndss-paper/i-know-what-you-asked-prompt-leakage-via-kv-cache-sharing-in-multi-tenant-llm-serving/  
Use: PROMPTPEEK shared-KV cache privacy risk.

**[S25] Gu, C. et al. (2025). _Auditing Prompt Caching in Language Model APIs_. ICML 2025.**  
https://proceedings.mlr.press/v267/gu25b.html  
Use: data-dependent timing and provider cache-policy/privacy audit.

**[S26] vLLM. _Security — Prefix Cache Timing Side-Channel Mitigation_. Current read 2026-09-03.**  
https://docs.vllm.ai/en/latest/usage/security/  
Use: current cache-salting mitigation and explicit timing-channel acknowledgment.  
Limit: implementation guidance.

**[S27] Luo, Z. et al. (2025/2026). _Shadow in the Cache: Unveiling and Mitigating Privacy Risks of KV-cache in LLM Inference_.**  
https://www.ndss-symposium.org/ndss-paper/shadow-in-the-cache-unveiling-and-mitigating-privacy-risks-of-kv-cache-in-llm-inference/  
Use: KV-state reconstruction/inversion privacy surface.

---

## 33. Current handoff

**Completed:** `04-CAG.md` bounded deep research.  
**Result:** Cache-Augmented Generation is a high-relevance repeated-context optimization / retrieval-free bounded-knowledge pattern when the full corpus is effectively usable, sufficiently stable and repeatedly reused; it is not a universal RAG replacement and not synonymous with generic prompt caching.  
**Key project-specific finding:** for SOUL/Development OS, the strongest boundary is `verified stable context → cache/reuse` versus `mutable authoritative state → fresh canonical recovery`; a cache may optimize repeated computation but must not silently become source-of-truth.  
**Critical correction:** the original CAG paper's own tables do not support unconditional “CAG is faster/better than RAG”; its clearest performance win is versus repeatedly recomputing the same full long context.  
**Verification:** cross-source synthesis only; no local CAG/RAG/long-context benchmark, cache-invalidation test, privacy audit or independent implementation verification.  
**Architecture decision:** none.  
**Foundation-tree effect:** none. Current Foundation sequencing remains independently governed by `research/soul-foundations/STATE.md`.  
**Next planned file:** `05-LONG-CONTEXT.md`.  
**Next action:** stop here; do not start Long Context deep research in this turn.
