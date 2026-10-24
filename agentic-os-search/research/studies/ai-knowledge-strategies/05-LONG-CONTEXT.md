# Long Context — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `04-CAG.md`  
**Research object:** Long Context / long-context language model use as a working-context mechanism  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** separate technical research line; does not modify the current foundation hierarchy  
**Verification status:** cross-source research synthesis; no local long-context/RAG benchmark, provider benchmark, security test or independent implementation verification executed  
**Package position:** file 5 of 5 technical deep-dives; intended six-file research scope is now complete

---

## 1. Araştırma sorusu

Bu dosya şu soruyu araştırır:

> **Long Context hangi gerçek problem sınıflarını çözer, “context window'a sığmak” ile “context'i güvenilir biçimde kullanmak” arasındaki sınır nedir, hangi failure mode'ları ve governance yüklerini üretir ve SOUL ile Development OS açısından hangi koşullarda full-context, retrieval veya hybrid yaklaşım daha güçlü adaydır?**

Bu soru şu daha dar sorularla aynı değildir:

> “Model kaç token alıyor?”  
> “Bütün repository'yi prompt'a koyalım mı?”  
> “Long Context RAG'ın yerini alır mı?”  
> “1M context varsa retrieval artık gereksiz mi?”

Bu dosya özellikle şu yanlış başlangıçları reddeder:

- Advertised context window = effective context değildir.
- Context'e sığan bilgi = model tarafından güvenilir biçimde kullanılan bilgi değildir.
- Needle-in-a-Haystack başarısı = gerçek long-context reasoning başarısı değildir.
- Bütün corpus'u vermek = bütün corpus'u dikkate almak değildir.
- Retrieval'ı kaldırmak = omission riskini tamamen kaldırmak değildir; model yine kanıtı kullanmayabilir.
- Daha fazla context = daha yüksek doğruluk değildir.
- Long Context = persistent memory değildir.
- Long Context = knowledge governance değildir.
- Long Context = provenance/citation mekanizması değildir.
- Long Context = RAG'ın evrensel replacement'ı değildir.
- Context kapasitesi yükseldikçe compute/latency/memory problemi otomatik kaybolmaz.
- Development OS için full-repo context, canonical routing/current-state recovery'nin yerine geçmez.

---

## 2. Kısa hüküm

### 2.1. Long Context nedir?

Bu araştırma için Long Context şu anlamda kullanılır:

> **Bir LLM'nin tek bir inference/work episode içinde geleneksel kısa prompt'ların çok ötesinde büyüklükte text/code/data/evidence paketini doğrudan input context olarak kabul edip bu bağlam üzerinde retrieval, synthesis, comparison, reasoning veya generation yapabilme kapasitesi ve çalışma biçimi.**

Bu tanım iki şeyi ayırır:

1. modelin input'u **kabul edebilmesi**;
2. modelin input'u **güvenilir biçimde kullanabilmesi**.

Long-context literature'ın en güçlü ortak sonucu bu ayrımın zorunlu olduğudur. `Lost in the Middle`, RULER, HELMET, NoLiMa, `Lost in the Distance`, LongBench v2, 100-LongBench ve 2025 `Context Length Alone Hurts...` farklı test tasarımlarıyla aynı genel uyarıyı destekler: **context capacity ile workload-level utilization aynı şey değildir.** [S1][S2][S3][S4][S5][S6][S7][S8]

### 2.2. Bu araştırmanın ana sonucu

Long Context, SOUL ve Development OS için özellikle **bütün bir bounded çalışma paketinin birlikte görünür olması gereken** Work sınıflarında yüksek potansiyel değere sahiptir.

Örnek problem sınıfları:

- exact cross-document comparison,
- aynı karar paketindeki claim/evidence/exception ilişkilerinin birlikte değerlendirilmesi,
- bir repository/code package içinde birden çok dosyaya yayılan ilişkiyi anlamak,
- multi-hop evidence'in hangi parçada olduğunu önceden bilmediğimiz bounded corpus,
- retrieval chunking'in önemli document structure'ı kırdığı durumlar,
- full-document legal/technical review,
- retrieval omission maliyetinin yüksek olduğu verification pass'leri.

Fakat Long Context için doğru seçim kriteri:

> `package token limit'e sığıyor mu?`

olmamalıdır.

Daha güçlü kriter:

> **Bu exact Work, bu exact model, bu source layout ve bu length'te load-bearing bilgiyi güvenilir biçimde bulup birleştirebiliyor mu; bunu yapmak retrieval/hybrid alternatife göre yeterince doğru, güvenli ve ekonomik mi?**

---

## 3. “Context length” tek bir sayı değildir

Araştırma sonunda en az altı ayrı context kavramını ayırmak gerekir.

### 3.1. Advertised / admissible context

API veya model specification'ın kabul ettiği maksimum input/output budget.

Bu yalnız interface/capacity sınırıdır.

### 3.2. Trained / adapted context

Modelin pretraining, continued training veya context-extension adaptation sırasında gerçekten gördüğü ve optimize edildiği sequence-length rejimi.

LongRoPE ve LongRoPE2 gibi çalışmalar context extension'ın positional encoding, fine-tuning ve mixed-length training gibi explicit mühendislik gerektirebildiğini gösterir. [S14][S15]

### 3.3. Benchmark-effective context

Belirli benchmark + threshold altında modelin kabul edilebilir performansı sürdürebildiği uzunluk.

RULER özellikle “claimed length” ile “effective length” ayrımını problemleştirir. [S2]

### 3.4. Workload-effective context

SOUL açısından daha önemli olan budur:

> **Belirli bir Work'te, belirli evidence distribution ve reasoning gereksinimi altında modelin güvenilir biçimde kullanabildiği uzunluk.**

Bu sayı task'a göre değişebilir.

### 3.5. Economically usable context

Bir bağlam teknik ve epistemik olarak kullanılabilir olsa da:

- TTFT,
- token cost,
- GPU memory,
- throughput,
- cache/storage,
- concurrency

sınırları deployment kararını değiştirebilir.

### 3.6. Governed context

SOUL/Development OS açısından context yalnız uzunluk değildir. İçerideki source'ların:

- eligible,
- authorised,
- current,
- correctly versioned,
- epistemically labelled,
- provenance-preserving

olması gerekir.

Bu nedenle:

```text
fits in advertised context
        ≠
effective for task
        ≠
economic
        ≠
governed / authorised
```

Bu dosyanın ana decision frame'i bu ayrımı korur.

---

## 4. Long Context hangi problemi çözmeye çalışır?

### 4.1. Retrieval-before-reasoning darboğazı

RAG'da model yalnız retriever'ın görünür kıldığı evidence'i görebilir.

Long Context alternatif olarak:

```text
large bounded corpus
        ↓
full / near-full direct context
        ↓
model performs in-context retrieval + reasoning
```

sunabilir.

Bunun potansiyel yararı:

- retrieval miss'i azaltmak,
- chunk boundaries'den doğan qualifier kaybını azaltmak,
- hangi parçanın relevant olduğunu query öncesi bilmek zorunda kalmamak,
- multi-hop relation'ları aynı working context'te tutmak,
- corpus-wide synthesis yapmak.

LOFT çalışması uzun-context modellerin bazı retrieval/RAG görevlerinde specialized sistemlerle rekabet edebildiğini ve bütün corpus'un modelde bulunmasının bazı multi-hop görevlerde pipeline cascading-error riskini azaltabildiğini gösterir. Ancak compositional/SQL-like reasoning ve çok uzun inputlarda zayıflıklar sürer. [S12]

### 4.2. Document integrity problemi

RAG chunking:

- section hierarchy,
- previous-definition context,
- table header,
- exception,
- version qualifier,
- local references

gibi yapıları parçalayabilir.

Full-document Long Context bunları fiziksel olarak aynı input'ta tutabilir.

Fakat “aynı input'ta” olması semantik olarak hepsinin eşit işlendiği anlamına gelmez.

### 4.3. Bounded package sensemaking

Bazı Work'lerde soru tek fact'i bulmak değil:

> “Bu paketin bütününden ne sonuç çıkıyor?”

Bu durumda retrieval yalnız en relevant top-k parçayı getirirse long-tail evidence, contradiction veya exception kaçabilir.

Long Context'in doğal avantajı burada daha güçlüdür.

---

## 5. Long Context'in en önemli avantajları

### 5.1. Retrieval omission riskini azaltabilir

Retriever'ın yanlış query/chunk/ranking yüzünden kritik belgeyi hiç göstermemesi yerine corpus modele doğrudan verilebilir.

Bu özellikle:

- bounded corpus,
- high omission cost,
- unknown evidence location

durumlarında değerlidir.

### 5.2. Cross-document ilişkileri koruyabilir

Birden fazla belgeyi birlikte görmek:

- comparison,
- contradiction detection,
- dependency reasoning,
- temporal sequence,
- multi-hop synthesis

için yararlı olabilir.

### 5.3. Retrieval infrastructure'ını basitleştirebilir

Bazı workload'larda:

- embedding,
- vector index,
- chunking,
- reranking,
- retrieval orchestration

gereksiz olabilir.

Ancak bu complexity ortadan kalkmak yerine context construction, compute ve verification tarafına taşınabilir.

### 5.4. User/workflow ergonomisini iyileştirebilir

Kullanıcı “hangi dosyada ne var?” bilmek zorunda kalmadan bounded package hakkında doğrudan soru sorabilir.

### 5.5. RAG verification için ikinci yol olabilir

High-impact Work'te bir retrieval result'ı full bounded package üzerinden cross-check etmek omission test'i olarak kullanılabilir.

Bu, Long Context'i yalnız production answer path değil, **verification capability** olarak da değerli yapabilir.

---

## 6. En temel failure: context window capacity ≠ utilization

### 6.1. Lost in the Middle

Liu et al. multi-document QA ve key-value retrieval'da relevant information'ın context içindeki position'ının performance'ı etkilediğini gösterdi: modeller genellikle bilgi başta veya sonda olduğunda daha iyi, ortada olduğunda daha kötü performans gösterebiliyor. [S1]

Bu sonuç:

> “Model 100K token okuyabiliyor.”

ifadesini şu soruya dönüştürür:

> “100K içindeki load-bearing evidence nerede ve model o pozisyonda da aynı güvenilirliği gösteriyor mu?”

### 6.2. Position bir governance değişkenine dönüşür

SOUL açısından context ordering yalnız formatting değildir.

Eğer:

- canonical rule başta,
- contradictory historical note ortada,
- user query sonda

ise modelin attention/use pattern'i answer'ı etkileyebilir.

Bu yüzden ordering, labels ve document boundaries test edilmelidir.

---

## 7. Lexical eşleşme ortadan kalkınca retrieval zorlaşıyor — NoLiMa

NIAH benchmarkları çoğu zaman query ile needle arasında açık lexical overlap bırakır.

NoLiMa bunu bilinçli olarak kaldırır ve latent association gerektirir. 2025 ICML çalışmasında 128K+ context claim'i olan 13 model incelenmiş; 32K'da 11 model güçlü short-context baseline'larının %50'sinin altına düşmüştür. GPT-4o çalışmadaki güçlü istisnalardan biri olsa da 99.3% short baseline'dan 69.7%'ye düşmüştür. [S4]

Bu sonuç önemli çünkü gerçek SOUL/Development OS query'leri her zaman exact source phrase'i içermez.

Örneğin:

> “Bu kararın arkasındaki verification bağımsızlığı problemi neydi?”

query'si source'taki exact terimi bilmeyebilir.

Dolayısıyla exact lexical needle finding, gerçek context understanding için zayıf proxy olabilir.

---

## 8. İlişkiler uzaklaştıkça reasoning zorlaşabiliyor — Lost in the Distance

Wang et al. iki ilişkili bilgi arasına giderek daha fazla unrelated text koyduğunda relation-capture performance'ının ciddi biçimde düşebildiğini gösterdi. Çalışma bu paterni GPT-4, GPT-4o-mini, Gemini-1.5 ve Claude-3.5-Sonnet dahil farklı modeller ve causal-reasoning / knowledge-extraction görevlerinde gözlemledi. [S6]

Bu Long Context'in SOUL için önemli bir failure mode'udur.

Bir dependency chain fiziksel olarak context'e sığsa bile:

```text
Decision A
   ... 40K tokens ...
Evidence B
   ... 30K tokens ...
Exception C
```

modelin bu ilişkiyi güvenilir biçimde kurduğu varsayılamaz.

Bu nedenle:

> **co-presence ≠ relational integration**

ayrımı gerekir.

---

## 9. Daha sert bulgu: kanıt kusursuz bulununca bile uzunluk zarar verebilir

Du et al. 2025 çalışması Long Context failure'ını yalnız retrieval problemine bağlayan görüşü doğrudan test etti.

Çalışmada:

- math,
- question answering,
- coding

görevleri ve 5 open/closed model kullanıldı.

Relevant information kusursuz biçimde mevcut/erişilebilir tutulsa bile context uzadıkça performance'ın **%13.9–85** arasında düştüğü raporlandı. Üstelik degradation:

- irrelevant tokens whitespace ile değiştirildiğinde,
- irrelevant tokens attention'dan maskelendiğinde,
- evidence doğrudan question önüne konduğunda

dahi gözlendi. [S5]

Bu, bu araştırmanın en yük taşıyan bulgularından biridir:

> **Long Context failure yalnız “model doğru parçayı bulamadı” değildir. Sheer sequence length reasoning'in kendisini bozabilir.**

Dolayısıyla Long Context verification iki ayrı katmanı test etmelidir:

1. evidence retrieval/use;
2. length-conditioned reasoning.

Du et al.'ın evidence'i önce recite ettirerek short-context-like reasoning phase'e geçme yaklaşımı GPT-4o/RULER'da sınırlı fakat tutarlı iyileşme göstermiştir. Bu da selective compression / evidence distillation / staged reasoning'in neden değerli olabileceğine işaret eder. [S5]

---

## 10. Needle testleri gerçek kullanım için yetersiz olabilir

### 10.1. RULER

RULER simple NIAH'ı:

- multi-key retrieval,
- multi-hop tracing,
- aggregation,
- variable tracking

gibi daha zor sentetik task'larla genişletti. Orijinal değerlendirmede modeller claimed context lengths'e sahip olsa da uzunluk ve task complexity arttıkça önemli performance degradation gösterdi. [S2]

### 10.2. HELMET

HELMET 2025 ICLR çalışması 7 application-centric category ve 128K'ya kadar controllable lengths ile 59 long-context modeli değerlendirdi.

Ana sonuçlardan biri:

> **NIAH performance downstream long-context performance'ı güvenilir biçimde tahmin etmiyor.**

Task categories arasında düşük correlation bulunması da “tek long-context score” fikrinin zayıf olduğunu gösterir. [S3]

### 10.3. 100-LongBench

100-LongBench iki ek problem gösterir:

- fixed sequence lengths failure threshold'u görünmez yapabilir;
- modelin base capability'si ile gerçek long-context degradation birbirine karışabilir.

Bu nedenle length-controllable evaluation ve baseline-adjusted metrics gerekir. [S8]

### 10.4. LongBench v2

LongBench v2 gerçekçi ve reasoning-heavy task'lara yönelir:

- single-document QA,
- multi-document QA,
- long in-context learning,
- dialogue-history understanding,
- code repository understanding,
- structured-data understanding.

503 sorunun context'leri 8K–2M **words** arasında değişir. Human experts 15 dakika sınırında %53.7, en iyi direct-answer model %50.1, daha uzun reasoning kullanan o1-preview %57.7 raporlanmıştır. [S7]

Bu sonuç long-context performance'ın yalnız retrieval değil, reasoning-time compute ve model capability ile de bağlı olduğunu gösterir.

### 10.5. LongBench Pro — 2026 current evidence

LongBench Pro Ocak 2026 preprint'i 1,500 doğal English/Chinese sample, 11 primary / 25 secondary task ve 8K–256K token aralığında 46 model değerlendirir. Çalışmanın raporladığı ana bulgulardan biri effective context'in çoğunlukla claimed context'ten kısa olmasıdır. [S9]

**Caveat:** bu çalışma current preprint evidence'dir; peer-reviewed final architecture law olarak ele alınmamalıdır.

---

## 11. Long Context evaluation için tek benchmark yeterli değildir

Bu araştırmadan çıkan evaluation matrix:

### A. Literal retrieval

- exact needle,
- identifier lookup,
- known phrase.

### B. Non-literal retrieval

- query/source lexical mismatch,
- semantic association.

### C. Multi-hop retrieval

- evidence pieces multiple locations.

### D. Relation integration

- distant facts must be connected.

### E. Aggregation

- many items must be counted/summarized/combined.

### F. Full-context reasoning

- answer depends on broad corpus state.

### G. Code/repository understanding

- cross-file dependency and exact symbols.

### H. Citation/provenance

- generated claims mapped back to source spans.

### I. Length-conditioned regression

- same task/evidence at increasing irrelevant or masked sequence length.

### J. Position robustness

- same evidence beginning/middle/end.

SOUL architecture decision öncesi exact intended workload bu matrix'te test edilmelidir.

---

## 12. Context construction başlı başına bir bilgi sistemi problemidir

Long Context “bütün dosyaları concatenate et” kadar basit değildir.

Context builder şu kararları verir:

- hangi source'lar dahil?
- hangi branch/version?
- canonical mı historical mı?
- source order?
- document boundaries?
- title/path/metadata?
- timestamp?
- provenance ID?
- source authority label?
- permissions?
- duplicate/superseded content?
- table/code/binary transformation?
- trust boundary?

Bu nedenle context construction bir **governed preprocessing Work** olarak düşünülmelidir.

### 12.1. Bad full context, bad retrieval'dan farklı fakat eş derecede tehlikeli olabilir

RAG failure:

```text
important source omitted
```

Long Context failure:

```text
important source included
+
wrong/historical/conflicting sources also included
+
model uses wrong one
```

İki sistemin failure topology'si farklıdır.

---

## 13. Distractor, conflict ve instruction contamination

Long Context büyüdükçe model yalnız daha fazla bilgi değil, daha fazla:

- irrelevant content,
- duplicated claims,
- contradictory versions,
- embedded instructions,
- user-generated text,
- malicious content

görür.

### 13.1. Many-shot attack surface

Anil et al. NeurIPS 2024 `Many-shot Jailbreaking` çalışması yüzlerce undesirable behavior demonstration'ı uzun context'e koymanın frontier models üzerinde yeni bir attack surface oluşturduğunu gösterir. [S18]

Bu çalışma doğrudan “her document prompt injection'dır” demek değildir.

Daha sınırlı sonuç:

> **Long Context kapasitesi aynı zamanda daha fazla adversarial/instruction-like material'ın aynı inference episode'a sokulabilmesi anlamına gelir.**

SOUL için source trust label ve instruction/data separation önem kazanır.

---

## 14. Provenance ve citation otomatik gelmez

Long Context'te model bütün source'u görse bile kullanıcı/model şu soruyu hâlâ cevaplamak zorundadır:

> “Bu cümle tam olarak hangi source/span'a dayanıyor?”

LongCite çalışması long-context QA'da citation eksikliğinin verification'ı zorlaştırdığını ve current models için citation quality'de ciddi improvement room bulunduğunu gösterir. Fine-grained sentence-level citation için özel dataset/training pipeline geliştirilmiştir. [S13]

Sonuç:

> **full context visibility ≠ fine-grained provenance**

SOUL/Development OS için context item'larının path/ref/SHA/span metadata'sı korunmalı ve load-bearing claim'lerde direct-source recovery mümkün olmalıdır.

---

## 15. Long Context cost ve sistem yükü

### 15.1. Attention maliyeti

Vanilla Transformer self-attention sequence length'e göre quadratic time/memory cost taşır. FlashAttention IO-aware exact attention ile memory traffic'i azaltarak önemli hız ve memory avantajları sağlar; fakat semantik utilization problemini çözmez. [S16]

Bu distinction önemlidir:

> **Daha uzun context'i compute edebilmek ≠ daha uzun context'i doğru anlamak.**

### 15.2. Prefill maliyeti

Long context özellikle first-token öncesi büyük prefill cost oluşturabilir.

CAG/prompt caching bu repeated prefill'i amortize edebilir; fakat first-build, storage, load, invalidation ve privacy maliyetleri getirir. `04-CAG.md` bu katmanı ayrı araştırmıştır. [S17]

### 15.3. Opportunity cost

Full corpus context:

- daha fazla input token,
- daha düşük throughput,
- daha fazla latency,
- daha az concurrent requests

anlamına gelebilir.

RAG'ın güçlü tarafı relevance gating ile model attention'a giden volume'u küçültmesidir.

---

## 16. Context extension nasıl mümkün oluyor?

Long Context yalnız product-level number değildir; model mechanics/training problemidir.

### 16.1. Position representation sınırı

RoPE tabanlı modeller training range'in ötesindeki position'larda distribution shift yaşayabilir.

### 16.2. LongRoPE

LongRoPE non-uniform positional interpolation ve progressive extension kullanarak pretrained models için 2M-token class extension göstermiştir. [S14]

### 16.3. LongRoPE2

LongRoPE2 explicit olarak **effective context window** kavramını hedefler; mixed-context training ve RoPE rescaling ile Llama3-8B üzerinde 128K effective context ve >98.5% short-context retention raporlar. [S15]

Bu çalışmalar şu noktayı destekler:

> **Advertised context bir knob değildir; positional generalization + training + evaluation gerektiren learned/system capability'dir.**

---

## 17. Long Context ile RAG nasıl karşılaştırılmalı?

Instagram framing:

```text
Large External Knowledge → RAG
Single Large Context → Long Context
```

yararlı ama eksiktir.

Daha güçlü comparison:

| Condition | Long Context eğilimi | RAG eğilimi |
|---|---|---|
| Corpus | bounded / fit | large / unbounded |
| Query locality | broad / unknown | localized evidence |
| Multi-hop | all evidence co-visible | retriever must recover each hop |
| Omission risk | lower retrieval omission | retrieval-dependent |
| Noise | potentially high | filtered |
| Token cost | high | lower |
| Latency | high prefill | retrieval + smaller context |
| Provenance | needs mapping | retrieved docs naturally surfaced |
| Freshness | context builder responsibility | index/source refresh responsibility |
| Access | pre-context eligibility | query-time filtering possible |
| Failure | position/length/reasoning | retrieval/chunk/ranking |

### 17.1. Li et al. 2024 comparison

EMNLP Industry study's benchmarklarında sufficient resources altında LC average performance'ta RAG'ı geçti; RAG ise belirgin biçimde daha düşük cost avantajı gösterdi. Self-Route hybrid yaklaşımı comparable LC performance'ı daha düşük compute ile hedefledi. [S11]

Bu evidence universal dominance kanıtı değildir.

### 17.2. LOFT

LOFT retrieval, multi-hop, ranking, SQL-like ve diğer real-world task'larda million-token context'i değerlendirir. Long-context models bazı retrieval/RAG sistemleriyle rekabet edebilse de compositional reasoning ve extreme lengths'te gap'ler sürer. [S12]

Sonuç:

> **Long Context vs RAG bir technology-war değil, workload routing problemidir.**

---

## 18. Hybrid yaklaşım neden güçlü aday?

Candidate hybrid:

```text
fresh control/state
        ↓
router / retrieval selects bounded authoritative package
        ↓
full package Long Context
        ↓
reasoning / comparison / synthesis
        ↓
targeted source recovery + citation verification
```

Bu yapı:

- RAG'ın large-corpus selection avantajını,
- Long Context'in local whole-package integrity avantajını

birleştirebilir.

Fakat hybrid'in de control surfaces'i vardır:

- selection miss,
- context overload,
- source priority conflict,
- duplicated evidence,
- provenance merge,
- cost routing.

Bu nedenle hybrid otomatik “best of both worlds” değildir.

---

## 19. Long Context + Knowledge Graph

Knowledge Graph relation-centric representation sağlar; Long Context ise graph'ın veya graph-derived view'ın büyük bir bölümünü model context'ine getirebilir.

Candidate uses:

- graph substructure + underlying documents together,
- relation traversal sonrası bounded neighborhood full context,
- schema/edge context + source evidence comparison.

Risk:

- graph-derived relation fact gibi görünür,
- predicted/inferred edge'in epistemic status'u serialization sırasında kaybolur,
- huge graph serialization context'i doldurur fakat query için gereksiz olabilir.

`02-KNOWLEDGE-GRAPH.md` sonucu korunur:

> derived graph canonical source'u ikame etmemelidir.

---

## 20. Long Context + Fine-Tuning

Fine-Tuning model behavior/capability'yi adapte eder; Long Context runtime evidence sağlar.

Örnek composition:

```text
specialized code-review / extraction model
+
bounded full repository/package context
```

Fine-tuning:

- context-following behavior,
- citation formatting,
- long-context task skill

için faydalı olabilir.

Long Context ise current external evidence'i taşır.

Bu katmanlar farklıdır.

Fine-tuned modelin uzun context'i gerçekten kullanabildiği ayrıca benchmark edilmelidir; short-context task improvement long-context robustness kanıtı değildir.

---

## 21. Long Context + CAG

Bu pair özel bir ilişkidir.

`04-CAG.md` sonucu:

> **Long Context CAG'ın substrate'ıdır; CAG repeated stable long-context prefill için efficiency layer'dır.**

Yani:

```text
Can/should this full package be processed together?
        ↓ Long Context question

Will this exact stable package be reused many times?
        ↓ CAG/cache question
```

CAG Long Context utilization failure'ını çözmez.

Model package içindeki orta/distant evidence'i kötü kullanıyorsa cache yalnız bu başarısızlığı daha hızlı çalıştırabilir.

---

## 22. Freshness ve authority

Long Context'e bütün corpus'u koymak source authority problemini çözmez.

Aynı context'te:

- current policy,
- superseded policy,
- hypothesis,
- rejected proposal,
- historical state,
- canonical state

bulunabilir.

Model lexical/semantic olarak eski source'u seçebilir.

SOUL/Development OS için context builder şu ayrımı görünür taşımalıdır:

```text
source identity
version/ref/SHA
current/historical
canonical/derived
accepted/hypothesis/rejected
valid-from / valid-to if relevant
actor/access scope
```

Long Context governance olmadan “çok bilgi” **authority ambiguity** yaratabilir.

---

## 23. Access control

Bir Actor'a full corpus vermek, retrieval sırasında document-level filtering yapmaktan daha kaba olabilir.

Long Context'te permission control **context construction'dan önce** yapılmalıdır.

Riskler:

- hidden file accidentally included,
- cross-tenant data mixed,
- derived summary leaks restricted fact,
- source permission changed but cached/assembled context reused.

Bu nedenle large context package ayrıca access-scoped artefact olarak düşünülebilir.

---

## 24. Verification nasıl yapılmalı?

### 24.1. Capacity test

Input accepted mı?

Bu yalnız smoke test'tir.

### 24.2. Position test

Same evidence:

- beginning,
- middle,
- end

pozisyonlarında test edilmelidir.

### 24.3. Length-controlled test

Same evidence + increasing irrelevant/masked context.

### 24.4. Non-literal retrieval test

Query/source exact overlap olmadan evidence bulunuyor mu?

### 24.5. Multi-hop / distance test

Evidence parçaları birbirinden uzaklaştırılır.

### 24.6. Full-context reasoning

Answer birçok parçanın birleşimine bağlı olmalı.

### 24.7. Distractor/conflict test

Plausible outdated/contradictory source eklenir.

### 24.8. Authority test

More-relevant historical source vs less-similar current canonical source.

### 24.9. Citation test

Generated claims exact source/span'a bağlanabiliyor mu?

### 24.10. Regression by length

Quality curve ölçülmelidir:

```text
4K → 8K → 16K → 32K → 64K → 128K → ...
```

“Passes at max length” yerine failure curve daha anlamlı olabilir.

### 24.11. Cost/latency

- input token cost,
- TTFT,
- total latency,
- throughput,
- cache benefit,
- memory

ölçülmelidir.

### 24.12. Negative / security tests

Untrusted instruction-like content eklenince governance/control instruction'ları korunuyor mu?

---

## 25. SOUL açısından değerlendirme

### 25.1. Long Context bir truth store değil, working-context capability'dir

SOUL'un intended outcome'a göre working system oluşturma hedefinde asıl soru:

> **Bu Work için hangi information aynı anda görünür olmalıdır?**

Long Context bu answer'ın büyük olduğu task'larda capability sağlar.

### 25.2. Strong candidate Work classes

- bounded evidence package review,
- exact cross-document comparison,
- contract/spec/manual whole-package analysis,
- bounded code/repo package understanding,
- multi-document contradiction/exception analysis,
- verification pass where retrieval omission cost is high.

### 25.3. Weak default Work classes

- live/unbounded web knowledge,
- tiny exact fact lookup,
- rapidly changing operational state,
- huge corpus with low query locality,
- mixed-access corpus,
- workloads where context-length regression is high.

### 25.4. Candidate selection gate

Architecture proposal değil, research decision frame:

1. Bu Work gerçekten simultaneous visibility gerektiriyor mu?
2. Candidate source package bounded mı?
3. Eligible/authoritative/current source'lar ayrıştırıldı mı?
4. Package workload-effective context içinde test edildi mi?
5. Position/distance/length robustness yeterli mi?
6. Citation/provenance requirement nasıl karşılanacak?
7. Long Context cost/latency kabul edilebilir mi?
8. Retrieval daha basit/ucuz mu?
9. RAG omission riskinin downstream maliyeti nedir?
10. Hybrid daha iyi boundary sağlar mı?
11. Untrusted content ve access scope kontrol edildi mi?
12. Repeated stable package ise CAG/cache faydalı mı?

### 25.5. Fail-visible state'ler

```text
context package complete
context package incomplete
source authority conflict
source revision mismatch
access-scope conflict
package exceeds tested effective length
position/distance robustness unknown
citation coverage insufficient
long-context regression detected
```

Hepsini “model kabul etti, çalış” yoluna çevirmek doğru değildir.

---

## 26. Development OS açısından değerlendirme

### 26.1. Current progressive retrieval yalnız context-window workaround değildir

Development OS / SOUL Research pattern:

```text
STATE
 → INDEX/router
 → current package
 → synthesis/finding
 → load-bearing claim için source recovery
```

Long Context büyüdüğünde bu yapı otomatik gereksiz olmaz.

Çünkü progressive retrieval ayrıca:

- currentness,
- authorization,
- authority hierarchy,
- scope control,
- noise reduction

yapar.

### 26.2. Full repo context riski

Bütün repository tek prompt'a sığsa bile içinde:

- historical work,
- current work,
- rejected ideas,
- accepted findings,
- research hypotheses,
- source evidence,
- generated synthesis

birlikte bulunabilir.

Bu, context capacity problemini çözerken source-view fidelity problemine dönüşebilir.

### 26.3. `AGENT.md` ve current `STATE.md`

Canonical fresh-read requirement devam eder.

```text
full repo loaded yesterday
        ≠
current AGENT / STATE recovered today
```

Long Context persistence değildir.

### 26.4. Development OS için güçlü candidate pattern

```text
fresh canonical control/state
        ↓
router identifies current bounded package
        ↓
full authoritative package loaded via Long Context
        ↓
cross-document reasoning
        ↓
load-bearing claims direct-source verified
        ↓
repository receives explicit output/handoff
```

Bu **architecture decision değildir**; research decision frame'dir.

### 26.5. Long Context'in Dev OS'de en güçlü rolü

Current evidence altında en güçlü rol:

> **progressive retrieval'ın yerine geçmek değil; router'ın belirlediği bounded authoritative çalışma paketini gerektiğinde bütün halinde değerlendirebilmek.**

Bu yaklaşım selective authority recovery ile whole-package reasoning'i birlikte korur.

---

## 27. Decision boundary

### Use when

Long Context güçlü adaydır eğer:

- Work bounded bir package üzerinde çalışıyorsa,
- evidence'in location'ı önceden bilinmiyorsa,
- cross-document relations/contradictions yük taşıyorsa,
- retrieval omission maliyeti yüksekse,
- chunking document semantics'i bozuyorsa,
- full-context reasoning measurable value üretiyorsa,
- workload-effective context benchmark'ı yeterliyse,
- authority/access/provenance context builder tarafından korunuyorsa,
- compute/latency maliyeti kabul edilebiliyorsa.

### Avoid as default when

Long Context zayıf/default-olmaması gereken adaydır eğer:

- corpus unbounded veya rapidly changing ise,
- query çoğunlukla tiny local fact lookup ise,
- access scopes heterojen ise,
- source authority/historical mixing yüksektir ama metadata/filter yoksa,
- model target length'te degradation gösteriyorsa,
- retrieval baseline daha ucuz ve yeterince reliable ise,
- whole corpus'taki untrusted instructions/security surface büyüyorsa,
- sırf advertised token count yüksek diye tercih ediliyorsa.

### Needs evidence before architecture decision

1. Exact workload classes neler?
2. Bounded package size distribution nedir?
3. Relevant evidence distribution nerede?
4. Simultaneous visibility gerçekten gerekli mi?
5. Position robustness nedir?
6. Distance/multi-hop robustness nedir?
7. Length-only regression curve nedir?
8. Non-literal retrieval performance nedir?
9. RAG baseline recall/accuracy nedir?
10. Long Context vs RAG cost/latency nedir?
11. Citation/provenance requirement nedir?
12. Source authority metadata nasıl korunacak?
13. Access-control scope nedir?
14. Historical/current conflict rate nedir?
15. Context construction algorithm nedir?
16. Hybrid routing hangi signal'la yapılmalı?
17. CAG/cache reuse hangi package'larda amortize olur?
18. Model/version change effective-context benchmark'ı invalid eder mi?
19. Security/adversarial long-context tests nelerdir?
20. Failure threshold hangi Work sınıfında kabul edilebilir?

### Does not prove

Bu araştırma şunları kanıtlamaz:

- SOUL her Work'te Long Context kullanmalıdır.
- Development OS bütün repository'yi her session context'e yüklemelidir.
- Long Context RAG'ın yerini almalıdır.
- RAG Long Context'ten daha güvenilirdir.
- Advertised 1M context 1M effective context demektir.
- NIAH pass etmek real-world long-context readiness'tır.
- Full context retrieval omission'ı tamamen bitirir.
- Context'teki her bilgi reasoning'e eşit katkı yapar.
- Long Context provenance'ı otomatik sağlar.
- Long Context CAG'dan bağımsız bir repeated-context strategy'dir.
- Daha büyük context daha iyi model demektir.

---

## 28. Bulgular

### F-LC-01 — Advertised context ve effective context ayrı kavramlardır

**Confidence:** high  
**Basis:** RULER, HELMET, LongRoPE2, LongBench Pro. [S2][S3][S9][S15]

Maximum accepted token count readiness metric değildir.

### F-LC-02 — Effective context tek model-level sayı olmaktan çok workload-dependent property'dir

**Confidence:** high  
**Basis:** HELMET category divergence, 100-LongBench, LongBench v2, NoLiMa. [S3][S4][S7][S8]

Task, position, lexical overlap, reasoning form ve evidence distribution sonucu değiştirir.

### F-LC-03 — Position effect long-context correctness'ın gerçek failure surface'idir

**Confidence:** high  
**Basis:** Lost in the Middle. [S1]

Co-presence uniform utilization anlamına gelmez.

### F-LC-04 — Non-literal evidence access literal needle finding'den daha zordur

**Confidence:** high  
**Basis:** NoLiMa. [S4]

NIAH real-world retrieval ability'yi overestimate edebilir.

### F-LC-05 — Long-distance relations context'e sığsa bile reasoning degradation gösterebilir

**Confidence:** high  
**Basis:** Lost in the Distance. [S6]

Co-presence relational integration değildir.

### F-LC-06 — Long input length retrieval perfect olsa dahi reasoning performance'ını düşürebilir

**Confidence:** high  
**Basis:** Du et al. EMNLP Findings 2025. [S5]

Bu Long Context'in failure modelini retrieval-only açıklamadan çıkarır.

### F-LC-07 — Synthetic retrieval benchmark tek başına architecture readiness oracle değildir

**Confidence:** high  
**Basis:** RULER, HELMET, 100-LongBench. [S2][S3][S8]

### F-LC-08 — Long Context retrieval omission/chunking failure'larını azaltabilir fakat noise/length/reasoning failure'ları ekler

**Confidence:** high as synthesis  
**Basis:** RAG-vs-LC, LOFT + long-context failure literature. [S11][S12][S1][S5]

### F-LC-09 — RAG vs Long Context universal winner problemi değildir

**Confidence:** high  
**Basis:** Li et al. 2024 + LOFT. [S11][S12]

Selection workload/cost/omission/reasoning trade-off'una bağlıdır.

### F-LC-10 — Full context visibility provenance/citation correctness sağlamaz

**Confidence:** high  
**Basis:** LongCite. [S13]

### F-LC-11 — Long Context security surface'i de büyütebilir

**Confidence:** medium-high  
**Basis:** Many-shot Jailbreaking + general context-governance inference. [S18]

Daha büyük input aynı inference episode'a daha fazla adversarial instruction-like material taşıyabilir.

### F-LC-12 — Long Context ve CAG eş düzey bağımsız strategies değildir

**Confidence:** high  
**Basis:** Chan-CAG mechanism + current analysis. [S17]

Long Context whole-package substrate; CAG repeated-use efficiency layer'dır.

### F-LC-13 — SOUL için Long Context universal knowledge path değil, conditional working-context capability olarak daha uyumludur

**Confidence:** high as project synthesis  
**Basis:** SOUL task-specific system formation + workload-dependent LC evidence.

### F-LC-14 — Development OS için Long Context progressive retrieval'ın yerini değil, bounded-package reasoning katmanını güçlendirebilir

**Confidence:** high as project-specific synthesis  
**Basis:** repository-authoritative/current routing requirements + LC evidence.

### F-LC-15 — “Load everything” source-view fidelity'yi zayıflatabilir

**Confidence:** high as project synthesis  
**Basis:** current repository epistemic-state structure + long-context noise/conflict evidence.

Current/historical/hypothesis/rejected materials birlikte verilirse relevance authority'yi ikame edebilir.

### F-LC-16 — Long-context evaluation model/version-specific yeniden yapılmalıdır

**Confidence:** high  
**Basis:** context-extension training literature + benchmark variation. [S14][S15][S3][S9]

Provider/model upgrade previous effective-context result'ını otomatik taşımaz.

---

## 29. Açık sorular — architecture öncesi gerekli bilgi

1. SOUL'un gerçek Work sınıflarında simultaneous-information requirement nedir?
2. Typical bounded package sizes nedir?
3. Development OS current packages hangi token distributions'a sahiptir?
4. Current model families için workload-specific effective context nedir?
5. High-impact Work için acceptable degradation curve nedir?
6. Position/distance sensitivity hangi task'larda critical?
7. Full-repo context ile progressive routing arasında exact quality/cost farkı nedir?
8. Historical/current ambiguity real repo benchmark'ında ne kadar hata üretir?
9. RAG omission rate hangi Work'lerde Long Context maliyetini haklı çıkarır?
10. Hybrid router deterministic metadata/rule tabanlı mı, model-based mi olmalı?
11. Context package provenance formatı nasıl olmalı?
12. Citation span granularity ne olmalı?
13. Access-scoped long-context packages nasıl oluşturulmalı?
14. Source update package/caches'i nasıl invalidate etmeli?
15. Long Context package içinde instruction/data separation nasıl korunmalı?
16. CAG hangi stable package'larda ekonomik value sağlar?
17. Long Context + KG relation-heavy tasks'ta actual benchmark advantage sağlıyor mu?
18. Fine-tuned specialized capability Long Context'e karşı regression gösteriyor mu?
19. Context compression/staged evidence recitation hangi Work'lerde value sağlar?
20. Local benchmark oracle'ları nasıl independent yapılmalı?

---

## 30. Araştırma yöntemi ve sınırlar

Bu çalışma:

- long-context positional-utilization research,
- effective-context benchmarks,
- real-world reasoning benchmarks,
- literal vs non-literal retrieval evaluation,
- length-conditioned reasoning studies,
- long-distance relational reasoning,
- context-extension/training research,
- Long Context vs RAG / whole-corpus research,
- citation/provenance research,
- attention systems efficiency,
- long-context security research,
- önceki `01-RAG.md` ve `04-CAG.md` sınırları

üzerinden cross-source synthesis yapmıştır.

### Bilinçli sınırlar

- SOUL/Development OS repository üzerinde local Long Context benchmark çalıştırılmamıştır.
- Current provider/model token limits comparative product table'a dönüştürülmemiştir; bunlar hızla değişir.
- LongBench Pro 2026 evidence preprint olarak tutulmuştur.
- LOFT preprint evidence peer-reviewed universal conclusion gibi kullanılmamıştır.
- RULER synthetic benchmark comprehensive real-world oracle sayılmamıştır.
- LongBench v2'de context birimi **words** olarak korunmuş, token'a çevrilmemiştir.
- Du et al.'ın %13.9–85 degradation range'i universal production failure rate olarak sunulmamıştır; kendi deney koşullarına aittir.
- NoLiMa model-specific percentages universal current leaderboard iddiasına çevrilmemiştir.
- LongRoPE/LongRoPE2 context-extension achievement'ları semantic understanding guarantee sayılmamıştır.
- Many-shot Jailbreaking every long document'ın malicious olduğu iddiasına çevrilmemiştir.
- FlashAttention semantic long-context solution sayılmamıştır.
- LLM-as-judge veya same-model self-assessment independent verification sayılmamıştır.
- Bu çalışma architecture, provider, model veya framework seçmemiştir.

### Stopping rationale

Araştırma boundedly closed kabul edilmiştir çünkü birbirinden farklı evidence hatları aynı load-bearing ayrımlarda yakınsamıştır:

- accepted context ≠ effective context,
- effective context workload-dependent,
- literal retrieval ≠ real semantic access,
- co-presence ≠ relational integration,
- perfect retrieval ≠ length-robust reasoning,
- whole context omission'ı azaltabilir fakat noise/cost/reasoning riskini artırabilir,
- RAG vs LC query/workload-dependent seçimdir,
- provenance/authority/access ayrı governance katmanlarıdır,
- CAG LC'nin repeated-context efficiency katmanıdır,
- Dev OS için selective canonical routing Long Context büyüse bile epistemik değerini korur.

Yeni model/benchmark sonuçları sayısal sınırları değiştirebilir; fakat bu package'ın **SOUL / Development OS relevance ve decision-boundary** hedefi için ana conceptual boundary'lerin değişme olasılığı düşmüştür.

---

## 31. Source ledger

### Core long-context utilization

**[S1] Liu, N. F. et al. (2024). _Lost in the Middle: How Language Models Use Long Contexts_. Transactions of the Association for Computational Linguistics 12:157–173.**  
DOI: 10.1162/tacl_a_00638  
https://aclanthology.org/2024.tacl-1.9/  
Use: position-dependent utilization failure; beginning/end vs middle.  
Limit: evaluated model generation is time-specific; exact magnitudes not universal current-model claims.

**[S2] Hsieh, C.-P. et al. (2024). _RULER: What's the Real Context Size of Your Long-Context Language Models?_**  
https://arxiv.org/abs/2404.06654  
https://github.com/NVIDIA/RULER  
Use: claimed vs effective context; retrieval/multi-hop/aggregation benchmark beyond vanilla NIAH.  
Limit: synthetic task suite; authors explicitly note it is not comprehensive real-world evaluation.

**[S3] Yen, H. et al. (2025). _HELMET: How to Evaluate Long-context Models Effectively and Thoroughly_. ICLR 2025.**  
https://proceedings.iclr.cc/paper_files/paper/2025/hash/f5332c8273d02729730a9c24dec2135e-Abstract-Conference.html  
Use: seven application-centric categories; NIAH/downstream mismatch; low cross-task correlation; 128K controllable evaluation.  
Limit: benchmark/model snapshot, not universal future ranking.

**[S4] Modarressi, A. et al. (2025). _NoLiMa: Long-Context Evaluation Beyond Literal Matching_. ICML 2025.**  
https://proceedings.mlr.press/v267/modarressi25a.html  
Use: non-literal needle retrieval; lexical-overlap benchmark bias; length degradation.  
Limit: benchmark design/model snapshot specific.

**[S5] Du, Y. et al. (2025). _Context Length Alone Hurts LLM Performance Despite Perfect Retrieval_. Findings of EMNLP 2025.**  
DOI: 10.18653/v1/2025.findings-emnlp.1264  
https://aclanthology.org/2025.findings-emnlp.1264/  
Use: length-only degradation despite perfect evidence retrieval; 13.9–85% experiment range; evidence-recitation mitigation.  
Limit: five-model/task suite; percentages are experiment-specific.

**[S6] Wang, M. et al. (2025). _Lost in the Distance: Large Language Models Struggle to Capture Long-Distance Relational Knowledge_. Findings of NAACL 2025.**  
DOI: 10.18653/v1/2025.findings-naacl.256  
https://aclanthology.org/2025.findings-naacl.256/  
Use: relation integration degrades as unrelated distance increases.

### Realistic / robust evaluation

**[S7] Bai, Y. et al. (2025). _LongBench v2: Towards Deeper Understanding and Reasoning on Realistic Long-context Multitasks_. ACL 2025.**  
DOI: 10.18653/v1/2025.acl-long.183  
https://aclanthology.org/2025.acl-long.183/  
Use: realistic multi-task deep reasoning, code-repo/structured-data/dialogue tasks, human/model difficulty.  
Limit: 503-question benchmark; context unit is words.

**[S8] Yang, V. et al. (2025). _100-LongBench: Are de facto Long-Context Benchmarks Literally Evaluating Long-Context Ability?_ Findings of ACL 2025.**  
DOI: 10.18653/v1/2025.findings-acl.903  
https://aclanthology.org/2025.findings-acl.903/  
Use: length-controllable real tasks; separates baseline ability from long-context degradation.

**[S9] Chen, Z. et al. (2026). _LongBench Pro: A More Realistic and Comprehensive Bilingual Long-Context Evaluation Benchmark_.**  
https://arxiv.org/abs/2601.02872  
Use: current 2026 8K–256K bilingual benchmark; claimed vs effective context observation; 46-model evaluation.  
Limit: preprint as of research date; not treated as final peer-reviewed authority.

**[S10] Zhang, X. et al. (2024). _∞Bench: Extending Long Context Evaluation Beyond 100K Tokens_. ACL 2024.**  
https://aclanthology.org/2024.acl-long.814/  
Use: >100K evaluation across diverse retrieval/reasoning/code/math task types.  
Limit: benchmark snapshot.

### Long Context vs RAG / whole-corpus systems

**[S11] Li, Z. et al. (2024). _Retrieval Augmented Generation or Long-Context LLMs? A Comprehensive Study and Hybrid Approach_. EMNLP Industry 2024.**  
DOI: 10.18653/v1/2024.emnlp-industry.66  
https://aclanthology.org/2024.emnlp-industry.66/  
Use: direct RAG vs LC cost/performance comparison; Self-Route hybrid evidence.  
Limit: model/dataset-specific; does not establish universal LC dominance.

**[S12] Lee, J. et al. (2024). _Can Long-Context Language Models Subsume Retrieval, RAG, SQL, and More?_**  
https://arxiv.org/abs/2406.13121  
https://github.com/google-deepmind/loft  
Use: LOFT million-token-class whole-corpus retrieval/reasoning comparison; retrieval/RAG competitiveness and compositional limitations.  
Limit: preprint benchmark evidence; not universal architecture decision.

### Citation / verifiability

**[S13] Zhang, J. et al. (2025). _LongCite: Enabling LLMs to Generate Fine-grained Citations in Long-Context QA_. Findings of ACL 2025.**  
DOI: 10.18653/v1/2025.findings-acl.264  
https://aclanthology.org/2025.findings-acl.264/  
Use: citation quality is separate long-context capability; fine-grained citation requires explicit training/evaluation.

### Context extension / model mechanics

**[S14] Ding, Y. et al. (2024). _LongRoPE: Extending LLM Context Window Beyond 2 Million Tokens_. ICML 2024.**  
https://proceedings.mlr.press/v235/ding24i.html  
Use: positional interpolation/progressive context extension; context capacity as engineered capability.  
Limit: context extension benchmark does not guarantee all downstream semantic utilization.

**[S15] Shang, N. et al. (2025). _LongRoPE2: Near-Lossless LLM Context Window Scaling_. ICML 2025.**  
https://proceedings.mlr.press/v267/shang25a.html  
Use: explicit effective-context framing; mixed-context training; short-context retention.  
Limit: evaluated model families and method-specific results.

**[S16] Dao, T. et al. (2022). _FlashAttention: Fast and Memory-Efficient Exact Attention with IO-Awareness_. NeurIPS 2022.**  
https://proceedings.neurips.cc/paper_files/paper/2022/hash/67d57c32e20fd0a7a302cb81d36e40d5-Abstract.html  
Use: quadratic attention cost and systems-level memory/IO optimization.  
Limit: efficiency method, not semantic long-context correctness solution.

### CAG relation

**[S17] Chan, B. J. et al. (2025). _Don't Do RAG: When Cache-Augmented Generation is All You Need for Knowledge Tasks_. WWW Companion 2025.**  
DOI: 10.1145/3701716.3715490  
https://arxiv.org/abs/2412.15605  
Use: Long Context as CAG substrate and repeated-KV prefill reuse relationship.  
Limit: narrow CAG benchmark; see `04-CAG.md` for full caveats.

### Security

**[S18] Anil, C. et al. (2024). _Many-shot Jailbreaking_. NeurIPS 2024.**  
DOI: 10.52202/079017-4121  
https://proceedings.neurips.cc/paper_files/paper/2024/hash/ea456e232efb72d261715e33ce25f208-Abstract-Conference.html  
Use: very long contexts create new attack surface through many harmful demonstrations.  
Limit: adversarial research setting; not evidence that ordinary long documents are malicious.

---

## 32. Package-level synthesis checkpoint

Bu dosyanın tamamlanmasıyla `research/ai-knowledge-strategies/` için başlangıçta belirlenen **6 dosyalık kapsam tamamlanmıştır**:

1. `00-WHY-THIS-RESEARCH.md`
2. `01-RAG.md`
3. `02-KNOWLEDGE-GRAPH.md`
4. `03-FINE-TUNING.md`
5. `04-CAG.md`
6. `05-LONG-CONTEXT.md`

Bu tamamlanma **architecture synthesis yapıldığı** anlamına gelmez.

Beş deep-dive'ın birlikte desteklediği bounded meta-observation:

```text
Knowledge representation       → Knowledge Graph candidate family
External evidence access       → RAG candidate family
Parametric behavior/capability → Fine-Tuning candidate family
Repeated stable context reuse  → CAG candidate pattern
Whole-package working context  → Long Context candidate capability

Across all:
authority / provenance / freshness / epistemic status / access / verification
remain governance problems.
```

Bu observation `00-WHY-THIS-RESEARCH.md` başlangıç framing'ini büyük ölçüde destekler: beş olgu eş düzey, birbirini dışlayan teknoloji seçenekleri değildir.

Ancak package-level architecture decision **verilmemiştir**.

---

## 33. Current handoff

**Completed:** `05-LONG-CONTEXT.md` bounded deep research.  
**Package status:** intended six-file research scope complete; all five technical deep-dives complete.  
**Result:** Long Context is a high-relevance whole-package working-context capability, not a reliable-context guarantee, persistent memory system or universal RAG replacement.  
**Key project-specific finding:** for SOUL/Development OS, the strongest candidate role is bounded authoritative package reasoning after fresh canonical routing; advertised context size must never replace workload-specific effective-context, authority, provenance and verification checks.  
**Critical finding:** long-context degradation can persist even with perfect evidence retrieval, so reliability cannot be reduced to retrieval recall alone.  
**Verification:** cross-source synthesis only; no local SOUL/Dev OS long-context/RAG/hybrid benchmark or independent implementation verification.  
**Architecture decision:** none.  
**Foundation-tree effect:** none. Current Foundation sequencing remains independently governed by `research/soul-foundations/STATE.md`; Domain Structure is currently bounded and awaiting user evaluation.  
**Next technical file:** none within the authorised six-file scope.  
**Next action:** stop here. Await user evaluation or an explicit later authorization for package synthesis/comparison/architecture work; do not infer such authorization from research completion.