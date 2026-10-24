# RAG — Retrieval-Augmented Generation Derin Araştırması

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Research object:** Retrieval-Augmented Generation (RAG)  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** separate technical research line; does not modify the current foundation hierarchy  
**Verification status:** cross-source research synthesis; no local benchmark and no independent implementation verification executed  
**Package position:** file 1 of 5 technical deep-dives; next planned file is `02-KNOWLEDGE-GRAPH.md`

---

## 1. Araştırma sorusu

Bu dosya şu soruyu araştırır:

> **RAG hangi gerçek problem sınıflarını çözer, hangi koşullarda güçlü veya zayıf bir mekanizmadır, hangi failure mode'ları ve governance yüklerini üretir ve SOUL ile Development OS açısından hangi karar sınırlarını görünür hale getirir?**

Bu soru şu daha dar soruyla aynı değildir:

> “Hangi vector database'i kullanalım?”

RAG bir vector database ürünü değildir. Modern kullanımda RAG; kaynak seçimi, ingestion, representation/indexing, query formation, retrieval, filtering/reranking, context construction, generation, attribution, evaluation ve gerektiğinde corrective/iterative retrieval içerebilen bir **sistem deseni / yöntem ailesidir**. [S1][S2]

Bu dosya özellikle şu yanlış başlangıçları reddeder:

- RAG = embedding + vector search değildir.
- RAG = her soruda retrieval yapmak değildir.
- RAG = retrieved belgeyi modele vermekle doğruluğu garanti etmek değildir.
- RAG = source authority veya freshness'i otomatik çözmek değildir.
- RAG = hallucination'ı ortadan kaldırmak değildir.
- RAG = citation/provenance'ın otomatik olarak doğru olduğu anlamına gelmez.
- RAG kullanmak, Knowledge Graph / Long Context / CAG / Fine-Tuning kullanılamayacağı anlamına gelmez.

---

## 2. Kısa hüküm

### 2.1. RAG nedir?

En genel ve bu araştırma için kullanışlı anlamıyla RAG:

> **Bir modelin yanıt/karar/çalışma üretmeden önce veya üretim sırasında dış bir bilgi alanından task-relevant evidence/context getirmesi ve üretimi bu dış bilgiyle koşullandırmasıdır.**

Lewis ve arkadaşlarının 2020 çalışmasındaki orijinal teknik RAG daha dardır: parametric seq2seq model memory, dense retriever tarafından erişilen explicit non-parametric Wikipedia index'iyle birleştirilir. Modern RAG literatürü ise bu kalıbı Naive / Advanced / Modular RAG gibi daha geniş pipeline ve control desenlerine doğru genişletmiştir. [S1][S2]

### 2.2. Bu araştırmanın ana sonucu

**RAG, SOUL ve Development OS için yüksek potansiyel öneme sahip bir capability pattern'dir; fakat evrensel default olmamalıdır.**

RAG özellikle şu koşullarda güçlü adaydır:

- gerekli bilgi model parametrelerinin dışında yaşıyorsa,
- corpus büyükse,
- bilgi sık değişiyorsa,
- source-level evidence/provenance gerekiyorsa,
- bütün corpus'u her request'te context'e koymak pahalı veya olanaksızsa,
- task'ın ihtiyaç duyduğu bilgi yeterince lokalize edilip retrieve edilebiliyorsa.

Fakat RAG'ın başarısı yalnız “relevant chunk bulundu mu?” sorusuna indirgenemez. En az dört ayrı doğruluk katmanı vardır:

1. **Corpus/source eligibility:** doğru, yetkili, güncel ve erişime uygun kaynaklar index'te mi?
2. **Retrieval correctness:** gerekli evidence gerçekten getirildi mi; kritik evidence atlandı mı?
3. **Evidence-use correctness:** model getirilen evidence'i doğru, eksiksiz ve çatışmaları gözeterek kullandı mı?
4. **Downstream decision/action correctness:** evidence doğru kullanılsa bile sonuç/karar/eylem hedefe ve yetkiye uygun mu?

Bu ayrım SOUL açısından kritiktir. Bir RAG sistemi ilk üç katmanda başarılı olsa bile yanlış Work seçebilir; doğru Work seçse bile authorization ihlal edebilir. Dolayısıyla RAG **working system'in bilgi erişim kabiliyeti** olabilir; working system'in tamamı değildir.

---

## 3. RAG hangi problemi çözmeye çalışır?

### 3.1. Parametric memory'nin sınırları

LLM bilgisinin yalnız model weights içinde yaşaması şu sorunları doğurabilir:

- eğitim cutoff'u sonrası bilgiye erişememe,
- domain/private knowledge eksikliği,
- bilgiyi güncellemek için modeli yeniden eğitme/adapt etme yükü,
- bir cevabın hangi harici kaynağa dayandığını doğrudan gösterememe,
- yeni veya değişen bilgi ile eski parametric bilginin çatışması.

Orijinal RAG çalışması explicit non-parametric memory'nin güncellenebilir ve inspectable olmasını önemli motivasyonlardan biri olarak ortaya koymuştur. [S1]

Ancak buradan şu güçlü iddia çıkmaz:

> “RAG kullanırsak model artık stale bilgi kullanmaz.”

Daha doğru ifade:

> **RAG, güncel bilgiye runtime erişim için bir mekanizma sağlar; freshness ancak source → ingestion → index → retrieval zinciri güncel tutuluyorsa gerçekleşir.**

### 3.2. Büyük corpus problemi

Bütün bilgi alanı tek prompt/context'e sığmayabilir veya her seferinde verilmesi maliyetli olabilir. Retrieval burada bir **selective attention before model attention** katmanı gibi çalışır: çok büyük bir aday uzayından küçük bir evidence set'i seçer.

Bu avantajın ters yüzü şudur:

> Model artık yalnız context window'a değil, **retriever'ın neyi görünür kıldığına** da bağımlıdır.

Retrieval'da görünmeyen bilgi model için pratikte yokmuş gibi davranabilir. Bu nedenle retrieval miss, source absence değildir.

### 3.3. Source-backed generation problemi

RAG, generated claim'leri dış evidence ile destekleme imkanını artırabilir. Fakat retrieval + citation mekanizmasının varlığı support completeness'i garanti etmez. ALCE'de en iyi incelenen sistemler dahi ELI5 deneylerinde citation support'u önemli oranda eksik bırakmıştır; RAGTruth da retrieved context'e rağmen unsupported veya contradictory claims'in sürdüğünü belgelemektedir. [S13][S14]

Sonuç:

> **RAG provenance için gerekli altyapıyı kolaylaştırabilir; provenance correctness'ı otomatik sağlamaz.**

---

## 4. RAG'ı tek algoritma değil pipeline olarak düşünmek

Modern RAG için aşağıdaki pipeline daha açıklayıcıdır:

```text
Authorised / eligible sources
        ↓
Ingestion + parsing + versioning
        ↓
Segmentation / chunking / representation
        ↓
Indexes / stores
        ↓
Task / question
        ↓
Do we need retrieval?
        ↓
Query planning / rewrite / decomposition
        ↓
Candidate retrieval
        ↓
Filter / permission check / freshness check / rerank
        ↓
Context construction
        ↓
LLM reasoning / generation / action proposal
        ↓
Claim ↔ evidence attribution
        ↓
Verification / insufficiency detection
        ↓
Deeper retrieval / alternate source / abstain / repair
```

Bu pipeline'da her ok ayrı bir failure surface'tir.

### 4.1. Offline / pre-query tarafı

- Hangi source'lar corpus'a alınacak?
- Hangi source authoritative sayılacak?
- Version, timestamp, owner, permission ve epistemic status metadata'sı tutulacak mı?
- Belge nasıl parse edilecek?
- Chunk sınırları nasıl seçilecek?
- Sparse, dense, hybrid veya structured representation mı kullanılacak?
- Embedding/index değiştiğinde eski corpus nasıl migrate edilecek?
- Source delete/update edildiğinde türetilmiş chunk ve index kayıtları nasıl invalidated edilecek?

### 4.2. Online / query-time tarafı

- Bu request retrieval gerektiriyor mu?
- Kullanıcının doğal dil sorusu doğru retrieval query'si mi?
- Query rewrite/decomposition gerekiyor mu?
- Tek adım retrieval yeterli mi, yoksa önceki bulgunun sonraki retrieval'ı belirlediği iterative path mi gerekli?
- Semantic similarity mi, lexical exact match mi, hybrid mi?
- Top-k kaç olmalı?
- Reranking gerekli mi?
- Retrieved content gerçekten kullanıcının/Actor'ın erişmeye yetkili olduğu içerik mi?
- Kaynaklar birbiriyle çelişiyorsa ne olacak?
- Modelin parametric bilgisi retrieved evidence ile çelişiyorsa ne olacak?
- Evidence yetersizse sistem “bilmiyorum / daha derine inmeliyim” diyebiliyor mu?

Bu soruların hiçbiri yalnız vector database seçimiyle çözülmez.

---

## 5. Retrieval katmanının kritik tasarım ayrımları

## 5.1. Sparse, dense ve hybrid retrieval

### Sparse retrieval

BM25 benzeri lexical yöntemler exact term, identifier, code, proper noun ve rare token eşleşmelerinde güçlü olabilir. Avantajı, eşleşmenin daha inspectable olması ve corpus'a yeni belge eklendiğinde model training gerektirmemesidir.

### Dense retrieval

DPR gibi dense retrieval yöntemleri query ve passage'ı learned vector representations üzerinden eşleştirir; semantik benzerlik lexical overlap olmadan bulunabilir. DPR kendi open-domain QA benchmark'larında güçlü BM25 baseline'a karşı top-20 retrieval accuracy artışı göstermiştir. [S3]

Ancak:

> **“Dense her zaman sparse'tan iyidir” sonucu geçersizdir.**

Luan ve arkadaşları fixed-length dense representation'ların özellikle uzun dokümanlarda capacity/precision sınırlarını incelemiş; sparse-dense hybrid ve daha expressive attentional modellerin değerini göstermiştir. [S4]

### Hybrid retrieval

Hybrid yaklaşım lexical ve semantic signal'ları birleştirir. Bu, özellikle exact identifier + semantic concept karışımı corpus'larda güçlü adaydır. Fakat hybrid olmak otomatik olarak daha iyi değildir; ranking fusion, corpus yapısı ve query dağılımı benchmark edilmelidir.

### SOUL / Development OS çıkarımı

Development OS benzeri repo corpus'unda şu query türleri aynı değildir:

- “current authorization” → metadata/path/canonical status ağırlıklı,
- “F-AR-009 nerede?” → lexical/exact identifier ağırlıklı,
- “geçmişte verification independence problemine benzeyen failure neydi?” → semantic retrieval ağırlıklı,
- “şu kararın bağlı olduğu source chain nedir?” → relation/provenance ağırlıklı.

Bu nedenle **tek retriever'ı evrensel default yapmak için mevcut kanıt yoktur.**

---

## 5.2. Chunking yalnız token optimizasyonu değildir

Naive RAG çoğu zaman belgeleri sabit boyutlu parçalara böler. Bu pratik fakat semantik olarak tehlikelidir.

DAPR çalışması, passage retrieval hatalarının önemli bir bölümünün passage'ın document context'inden kopmasından kaynaklandığını göstermiştir; benchmark analizinde major errors'ın %53.5'i missing document context ile ilişkilendirilmiştir. [S5]

Chunking şu bilgileri kaybettirebilir:

- bölüm başlığı,
- hangi karar / sürüm / Actor bağlamında olduğu,
- önceki paragraftaki referent,
- “bu yalnız historical” gibi scope qualifier,
- exception / limitation,
- table/header ilişkisi,
- source hierarchy,
- revision status.

SOUL Research açısından bu özellikle yük taşıyan bir problemdir. Örneğin aynı cümle:

> “Next action: X”

bir historical handoff içinde bulunuyorsa current authority değildir. Semantic chunk yalnız cümleyi getirirse **representation doğru, interpretation yanlış** olabilir.

Bu yüzden chunk metadata ve parent-document context'i retrieval correctness'ın parçasıdır.

---

## 5.3. Query formation ayrı bir reasoning problemidir

Kullanıcının yazdığı soru retrieval için optimum query olmak zorunda değildir.

Query Rewriting çalışması input ile needed knowledge arasında sistematik gap olabileceğini; rewrite → retrieve → read yaklaşımının faydalı olabildiğini gösterir. [S6]

HyDE ise query'den hypothetical document üretip onun embedding'i üzerinden gerçek corpus'a retrieval yapar. İlginç nokta şudur: intermediate generated text “fake” ve hallucinated olabilir; onun görevi cevap olmak değil retrieval representation'ını değiştirmektir. [S7]

Bunun SOUL için daha genel dersi:

> **Retrieval query, user request'in mekanik kopyası değil; task'ın evidence need'inden türetilen ayrı bir çalışma ürünü olabilir.**

Ancak query rewriting de yeni failure mode üretir:

- yanlış decomposition,
- query drift,
- önemli qualifier'ın düşmesi,
- preferred hypothesis'a göre confirmation-seeking search,
- authority constraint'in query'den kaybolması.

Bu nedenle query transformation observability ve verification gerektirir.

---

## 5.4. One-shot retrieval her görev için yeterli değildir

Multi-hop task'larda ikinci retrieval ihtiyacı birinci retrieval sonucuna bağlı olabilir.

IRCoT çalışması, knowledge-intensive multi-step QA'da tek retrieve-and-read yaklaşımının yetersiz kalabildiğini ve reasoning ile retrieval'ı interleave etmenin benchmarklarında hem retrieval hem downstream QA'yı geliştirdiğini göstermiştir. [S8]

Bundan SOUL için çıkan aday ilke:

```text
retrieve once → answer
```

tek pattern olmamalıdır.

Bazı Work için:

```text
working hypothesis
   ↓
retrieve evidence
   ↓
update state / identify gap
   ↓
retrieve next dependency
   ↓
verify / stop
```

şeklinde adaptive/iterative retrieval daha doğal olabilir.

---

## 5.5. Retrieval her request'te zorunlu olmamalıdır

Adaptive-RAG, query complexity'ye göre no-retrieval / single-step / iterative retrieval yolları arasında seçim yapmayı araştırmıştır. [S9]

Self-RAG ve benzeri çalışmalar da retrieval'ın koşullu olabileceğini vurgular. [S10]

Bu, SOUL'un task-specific system formation hedefiyle güçlü biçimde rezonans gösterir:

> **Retrieval bir capability olabilir; her turn zorunlu ritual olmamalıdır.**

Ancak dikkat: bir modelin “retrieval gerekli mi?” diye kendini değerlendirmesi bağımsız verification değildir. Wrong confidence, retrieval'ı tam ihtiyaç anında atlatabilir. Bu nedenle retrieval gate'in hangi sinyallerle beslendiği ayrı bir verification problemidir.

---

## 5.6. Reranking ve context construction ayrı katmanlardır

İlk-stage retriever geniş candidate set'i düşük maliyetle getirip daha pahalı bir reranker bunları sıralayabilir. Bu trade-off:

- recall,
- precision,
- latency,
- compute,
- context token budget

arasında yapılır.

Top-k artırmak da otomatik çözüm değildir. Daha fazla chunk:

- evidence recall'ı artırabilir,
- fakat noise ve contradiction ekleyebilir,
- context budget'i tüketebilir,
- relevant evidence'in attention'da seyrelmesine neden olabilir,
- prompt injection surface'ini büyütebilir.

Bu yüzden “retriever doğru çalıştı mı?” ile “constructed context downstream model için optimal mi?” iki ayrı sorudur.

---

## 6. RAG failure taxonomy

## 6.1. Layer A — Source / corpus failure

Retrieval algoritması kusursuz olsa bile corpus yanlışsa RAG yanlış evidence getirir.

Failure örnekleri:

- authoritative source hiç ingest edilmemiş,
- historical/superseded source current gibi indexlenmiş,
- stale version duruyor,
- source update edilmiş ama index yenilenmemiş,
- deletion source'ta yapılmış ama chunk/vector store'da kalmış,
- access-control metadata kaybolmuş,
- malicious document corpus'a eklenmiş,
- generated/synthetic text primary evidence gibi işaretlenmiş.

Bu katman **relevance metric ile ölçülemez.**

### SOUL açısından kritik sonuç

**Authority relevance'dan önce gelir.**

Çok benzer fakat yetkisiz/bayat/provisional bir kaynak, az benzer fakat canonical kaynaktan daha kötü evidence olabilir.

---

## 6.2. Layer B — Retrieval failure

Corpus doğru olsa bile retrieval yanlış olabilir:

- needed document top-k dışında kalır,
- lexical mismatch,
- embedding mismatch,
- wrong chunk boundaries,
- query rewrite drift,
- multi-hop dependency tek query'ye sıkıştırılır,
- duplicate chunks ranking'i domine eder,
- relevant ama peripheral chunks core evidence'i iter,
- rare exact identifiers semantic search'te kaçırılır,
- no-result “source absence” sanılır.

Bu katmanda önemli metric yalnız precision değildir. High-stakes evidence work için **recall / omission sensitivity** çok önemlidir.

---

## 6.3. Layer C — Context / evidence-use failure

Doğru evidence retrieve edilmiş olsa bile:

- model evidence'i kullanmayabilir,
- parametric memory'yi tercih edebilir,
- iki source arasındaki conflict'i gizleyebilir,
- limitation veya exception'ı atlayabilir,
- chunk'ı parent context'ten kopuk yorumlayabilir,
- citation doğru source'a görünse bile claim'in tamamını desteklemeyebilir.

Knowledge-conflict literatürü context-memory ve inter-context conflict'lerin model trustworthiness'ını etkilediğini gösterir. [S15]

ALCE ve RAGTruth ise retrieved evidence'in varlığına rağmen attribution ve unsupported-claim sorunlarının sürdüğünü gösterir. [S13][S14]

---

## 6.4. Layer D — Decision / action failure

Agentic sistemlerde generation son nokta değildir.

Model doğru evidence'ten doğru factual conclusion çıkarsa bile:

- yanlış Work'ü seçebilir,
- Actor authority sınırını aşabilir,
- verification gerektiren yerde eyleme geçebilir,
- evidence finding'i architecture decision'a çevirebilir,
- source content içindeki malicious instruction'ı tool command gibi uygulayabilir.

Dolayısıyla agentic RAG için gerçek evaluation target yalnız QA accuracy değildir.

---

## 7. Freshness: “updateable” ile “up-to-date” ayrımı

RAG'ın en güçlü avantajlarından biri external store'un model retraining olmadan değiştirilebilmesidir. Fakat bu yalnız **updateability capability**'dir.

Gerçek freshness zinciri:

```text
source changed
   ↓
change detected
   ↓
re-ingestion / re-parse
   ↓
old chunks invalidated
   ↓
new chunks indexed
   ↓
permissions/version metadata updated
   ↓
query sees correct version
```

Bu zincirin bir halkası kırılırsa “RAG güncel bilgi kullanıyor” iddiası yanlış olabilir.

### Freshness için gereken metadata adayları

- canonical source identifier,
- source version / commit / revision,
- ingestion timestamp,
- effective date,
- superseded/deprecated status,
- deletion/tombstone state,
- source owner / authority class,
- access scope,
- parser/chunker version,
- embedding/index version.

Bu liste architecture kararı değildir; freshness iddiasını doğrulayabilmek için gereken gözlenebilirlik yüzeyini gösterir.

---

## 8. Provenance: RAG'ın güçlü yanı, fakat otomatik değil

RAG, parametric-only modelden farklı olarak retrieved source identifiers'ı runtime trace'e bağlama imkanı verir.

İdeal lineage:

```text
claim
  ↓ supported_by
retrieved chunk
  ↓ derived_from
source revision
  ↓ belongs_to
canonical source
```

Ancak şu hatalar mümkündür:

- model retrieve edilen source'tan daha güçlü claim üretir,
- citation yalnız claim'in bir kısmını destekler,
- doğru source yanlış passage'a bağlanır,
- generated synthesis'e kaynakta olmayan inference eklenir,
- citation metadata sonradan değişir,
- source chain kullanıcıya gösterilir ama sistem aslında parametric memory'ye dayanır.

ALCE bu nedenle citation correctness ve completeness'i ayrı değerlendirme eksenleri olarak ele alır. [S13]

### SOUL için çıkarım

**Observation / source-supported claim / inference ayrımı RAG'dan sonra da gereklidir.**

RAG yalnız evidence'i modele getirir; evidence ile inference arasındaki epistemik sınırı kendiliğinden korumaz.

---

## 9. Hallucination: RAG azaltabilir, ortadan kaldırmaz

RAG'ın en yaygın marketing framing'lerinden biri “hallucination'ı çözer” ifadesidir. Kanıt bu kadar güçlü değildir.

RAGTruth, retrieved contents'e rağmen unsupported veya contradictory claims üretilebildiğini gösterir. [S14]

Knowledge conflict araştırmaları da modelin external context ile parametric knowledge arasında güvenilir seçim yapmasının trivial olmadığını gösterir. [S15]

Bu nedenle doğru claim:

> **Uygun RAG tasarımı bazı hallucination ve stale-knowledge risklerini azaltabilir ve grounding imkanı sağlar.**

Yanlış claim:

> “RAG output factualdır.”

---

## 10. Security ve authority boundary

RAG harici knowledge'ı model context'ine taşıdığı için corpus aynı zamanda bir **behavior influence surface** haline gelir.

OWASP RAG Security guidance şu risk sınıflarını özellikle vurgular:

- document poisoning,
- indirect prompt injection,
- cross-tenant retrieval,
- stale permissions,
- cache/data leakage,
- source attribution tampering,
- downstream agent/tool invocation riskleri. [S17]

PoisonedRAG, knowledge database'e az sayıda adversarial text eklenmesinin belirli deney koşullarında attacker-chosen output'ları tetikleyebildiğini göstermiştir. [S18]

Bu nedenle agentic SOUL için retrieved content şu şekilde ele alınmalıdır:

> **Evidence/data olabilir; instruction/authority değildir.**

Bir source'un “şunu yap” demesi, source content'in tool authority sahibi olduğu anlamına gelmez.

Bu sınır özellikle RAG + tool-using agent bileşiminde kritiktir.

---

## 11. RAG evaluation nasıl yapılmalı?

End-to-end “cevap doğru mu?” metriği tek başına yetersizdir. Aynı final score farklı failure nedenlerinden gelebilir.

RAGAS retrieval relevance/focus, faithful evidence use ve generation quality gibi boyutları ayırmaya çalışır. RAGChecker retrieval ve generation modüllerini fine-grained diagnostic metrics ile ayrı değerlendirir. [S11][S12]

### 11.1. Corpus-level evaluation

Sorular:

- Gold/authoritative evidence corpus'ta var mı?
- Current version index'te mi?
- Superseded document yanlışlıkla eligible mı?
- Permission filtering doğru mu?
- Deletion propagation çalışıyor mu?

### 11.2. Retrieval-level evaluation

Örnek metricler:

- Recall@k / evidence recall,
- Precision@k,
- MRR / ranking quality,
- nDCG,
- exact identifier retrieval,
- multi-hop evidence coverage,
- no-answer / insufficient-evidence detection.

SOUL/Development OS için özellikle kritik metric:

> **decision-critical evidence omission rate**

Bu standart literatür metriği olarak sunulmamalıdır; project-specific candidate metric'tir. Amaç, “retrieved set genel olarak relevant” olsa bile sonucu değiştirecek bir evidence'ın atlanmasını görünür kılmaktır.

### 11.3. Context-level evaluation

- Retrieved evidence'in gerekli qualifier/context'i korunmuş mu?
- Contradictory source'lar görünür mü?
- Duplicate/noise useful evidence'i bastırıyor mu?
- Parent-document metadata mevcut mu?

### 11.4. Generation-level evaluation

- Faithfulness / groundedness,
- claim-level citation support,
- citation completeness,
- unsupported claim rate,
- conflict disclosure,
- uncertainty calibration.

### 11.5. Agentic downstream evaluation

SOUL gibi action-capable bir sistem için ayrıca:

- retrieved content authority'yi değiştirdi mi?
- unauthorized action tetiklendi mi?
- source finding decision gibi kullanıldı mı?
- verification gerektiren durumda premature closure oldu mu?
- retrieval failure fail-visible oldu mu?

### 11.6. Automated LLM-as-judge sınırı

RAGAS/RAGChecker gibi otomatik evaluator'lar değerlidir fakat final oracle değildir. Aynı family model, aynı context veya aynı framing'e dayalı evaluator ortak hata taşıyabilir. Önemli acceptance için human/ground-truth/independent reperformance veya deterministic checks gerektiği yerde korunmalıdır.

---

## 12. Corrective ve adaptive RAG neden önemli?

CRAG retrieval'ın yanlış olabileceğini first-class problem kabul edip retrieved documents için evaluator ve alternatif retrieval yolları önerir. [S16]

Adaptive-RAG ise query complexity'ye göre no-retrieval / single-step / iterative path seçer. [S9]

Bu iki çalışma birlikte şu önemli framing'i destekler:

> **Production-grade RAG, yalnız retriever çağırmak değil; retrieval'ın gerekli olup olmadığını ve sonucunun yeterli olup olmadığını yöneten control loop olabilir.**

SOUL için bu fikir doğrudan architecture kararı değildir; fakat general-purpose system formation açısından güçlü bir araştırma sonucu üretir:

> Retrieval capability'sinin varlığından daha önemli olan, **retrieval policy** ve **retrieval failure handling** olabilir.

---

## 13. SOUL açısından değerlendirme

## 13.1. Neden yüksek relevance?

SOUL'un hedefi intended outcome'a göre gereken controlled, verifiable working system'i oluşturmaksa farklı task'lar şu bilgi rejimlerine sahip olabilir:

- public web knowledge,
- private enterprise knowledge,
- current operational state,
- source-controlled technical repo,
- legal/regulatory corpus,
- scientific literature,
- sensor/tool observations,
- historical work/evidence.

Bu bilgi alanlarının tamamını model weights'e gömmek veya her seferinde full context'e koymak uygun olmayabilir. RAG bu nedenle task-specific working system'e takılabilen bir **external evidence access capability** olarak güçlü adaydır.

## 13.2. Fakat RAG capability'si “knowledge truth layer” değildir

SOUL için candidate separation:

```text
Knowledge / evidence sources
          ↓
Governed retrieval capability
          ↓
Working context
          ↓
Reasoning / Work
          ↓
Verification / decision / action controls
```

Burada RAG ikinci oku destekleyebilir; tüm zinciri ikame etmez.

## 13.3. Aday “governed adaptive retrieval” modeli

Aşağıdaki model **architecture proposal değil**, bu araştırmadan çıkan decision frame'dir:

1. **Evidence need:** Bu task harici bilgi gerektiriyor mu?
2. **Authority scope:** Hangi source sınıfları bu Work için eligible/authoritative?
3. **Access scope:** Actor hangilerine erişmeye yetkili?
4. **Query plan:** Factoid, exact, semantic, multi-hop, relation-heavy veya broad synthesis mi?
5. **Retriever selection:** lexical / dense / hybrid / structured / web / direct-source read.
6. **Candidate filtering:** authority, freshness, permission, version.
7. **Reranking/context construction:** relevance + evidence coverage + context preservation.
8. **Evidence use:** observation / source claim / inference ayrımı.
9. **Verification:** claim support, omission, conflict ve freshness kontrolü.
10. **Repair:** alternate retrieval, deeper source recovery, broader scope veya abstention.

Bu modelin değeri, SOUL'u “always-vector-RAG” gibi fixed workflow'a kilitlememesidir.

## 13.4. Fail-visible olma gereği

RAG failure'ın en tehlikeli hali boş sonuç değil, **plausible but incomplete evidence** olabilir.

SOUL için RAG şu durumları ayırt edebilmelidir:

- evidence found,
- evidence partially found,
- evidence conflict,
- source unavailable,
- source scope incomplete,
- retrieval confidence low,
- no eligible authoritative source.

Bunların hepsini “cevap üret” yoluna çevirmek güvenilir değildir.

---

## 14. Development OS açısından değerlendirme

## 14.1. Mevcut repo zaten selective retrieval problemi çözüyor

Current Development OS / SOUL Research pratiğinde kullanılan desen:

```text
STATE
 → INDEX/router
 → current package
 → KEY/synthesis/finding
 → load-bearing claim için source recovery
```

teknik olarak bir vector-RAG sistemi değildir. Fakat aynı temel problemi çözer:

> **Büyük persistent corpus'tan current Work için minimum yeterli context nasıl recover edilir?**

Bu nedenle RAG araştırmasının Dev OS için ilk sonucu “hemen vector DB ekle” değildir.

Daha güçlü sonuç:

> **Mevcut progressive retrieval mantığı, semantic/lexical retrieval ile desteklenebilir; fakat canonical routing ve authority hierarchy kaybedilmemelidir.**

## 14.2. En kritik risk: relevance'ın authority'yi ikame etmesi

Semantic search şu dosyayı çok relevant bulabilir:

- historical proposal,
- superseded STATE,
- exploratory note,
- failed design,
- old handoff.

Ama Development OS için “çok relevant” ≠ “current authority”.

Bu nedenle Dev OS RAG'ı varsa candidate eligibility/ranking şu metadata'yı düşünmelidir:

- current vs historical,
- accepted vs hypothesis,
- source vs synthesis,
- canonical vs derived,
- branch/ref/SHA,
- superseded status,
- authorization scope.

Bu, araştırmanın SOUL/Development OS açısından en önemli bulgularından biridir.

## 14.3. Retrieval miss source absence değildir

Current repo protocol'ündeki source-view fidelity kuralı RAG için doğrudan geçerlidir:

```text
search/retrieval'da görünmedi
        ≠
kaynakta yok
```

High-impact claim için no-hit halinde sistem:

- query reformulation,
- alternate index,
- broader search,
- exact path/source read,
- human clarification

gibi escalation yollarına sahip olmalıdır.

## 14.4. Cold-start için olası değer

RAG, fresh session'ın:

- current state,
- active Work,
- ilgili evidence,
- historical precedent,
- source chain

bulmasını hızlandırabilir.

Fakat cold-start'ın correctness'ı semantic retrieval'ın insafına bırakılamaz. Current state / authorization gibi yük taşıyan surfaces deterministic/canonical preflight ile zorunlu kalabilir; RAG bundan sonra bounded retrieval yapabilir.

Bu nedenle şu distinction güçlü görünmektedir:

```text
mandatory canonical bootstrap
        +
adaptive evidence retrieval
```

Bu bir implementation kararı değil, sonraki architecture değerlendirmesinde sınanması gereken candidate pattern'dir.

---

## 15. Knowledge governance lensi

RAG aşağıdaki governance problemlerini **çözmez**, yalnız bazılarını uygulanabilir kılar:

| Problem | RAG'ın katkısı | Hâlâ gereken |
|---|---|---|
| Source authority | source seçilebilir | authority policy / source classes |
| Provenance | chunk/source IDs taşınabilir | claim-level lineage ve attribution validation |
| Freshness | external store update edilebilir | sync/update/delete/version controls |
| Access | retrieval filtrelenebilir | identity/authorization enforcement |
| Epistemic status | metadata taşınabilir | finding/inference/hypothesis/decision semantics |
| Conflict | birden fazla source getirilebilir | conflict policy / disclosure / adjudication |
| Verification | evidence görünür olur | independent/error-sensitive validation |
| Deletion | index kaydı silinebilir | full derived-data/cache invalidation |

Ana hüküm:

> **RAG, knowledge governance'ın alternatifi değildir; governance kuralları RAG pipeline'ının giriş ve çıkışlarını sınırlar.**

---

## 16. Operational trade-off'lar

### 16.1. Maliyet

RAG token maliyetini full-corpus context'e göre azaltabilir; fakat yeni maliyetler yaratır:

- ingestion/parsing,
- embedding/indexing,
- vector/sparse index storage,
- query embedding/search,
- reranking,
- iterative retrieval calls,
- observability/logging,
- evaluation infrastructure.

### 16.2. Latency

Online retrieval + reranking + multi-hop steps latency ekler. Basit task'ta gereksiz retrieval performansı hem maliyet hem hız açısından bozabilir; adaptive retrieval bu yüzden önemlidir. [S9]

### 16.3. Update cost

External store model retraining'den daha kolay güncellenebilir; fakat:

- embedding model değişimi,
- chunking policy değişimi,
- schema/metadata değişimi,
- corpus büyümesi

reindex/migration maliyeti yaratabilir.

### 16.4. Observability

RAG parametric-only modele göre daha gözlenebilir olabilir çünkü:

- retrieved candidates,
- scores,
- source IDs,
- query transformations

loglanabilir.

Fakat modularity arttıkça failure localization zorlaşabilir. Bu yüzden tracing yalnız debugging özelliği değil verification surface'idir.

### 16.5. Vendor/model dependency

Embedding model, reranker, vector store veya managed search ürünü seçimi portability etkiler. Bu araştırma herhangi bir vendor/framework seçimini desteklemez.

---

## 17. Security için minimum conceptual controls

Bu bölüm product security design değildir; araştırmadan çıkan minimum decision boundaries'dir.

RAG agentic sistemde kullanılacaksa en az şu sorular cevaplanmadan güvenli default sayılmamalıdır:

- Corpus'a kim yazabilir?
- Source ingestion provenance doğrulanıyor mu?
- Retrieved content instruction değil data olarak ayrılıyor mu?
- Permission filter retrieval'dan önce/sonra nasıl enforce ediliyor?
- Cross-tenant leakage test ediliyor mu?
- Source delete/revoke sonrası index/cache invalidation doğrulanıyor mu?
- Tool/action layer retrieved text tarafından doğrudan tetiklenebiliyor mu?
- Poisoned document için red-team / negative test var mı?
- Retrieval trace incident investigation için korunuyor mu?

2025 USENIX PoisonedRAG sonucu bu riskin teorik olmadığını göstermektedir. [S18]

---

## 18. Diğer dört stratejiyle kompozisyon

Bu bölüm yalnız RAG açısından boundary belirler; diğer mekanizmaların kendi derin araştırmaları sonraki dosyalarda yapılacaktır.

## 18.1. RAG + Knowledge Graph

Potentially complementary.

Graph:

- entity/relation structure,
- multi-hop relation paths,
- dependency/provenance traversals

sağlayabilir; RAG bu yapıyı retrieval/generation pipeline'ına bağlayabilir.

Ancak “relation-heavy → graph şart” sonucu bu dosyadan çıkmaz. `02-KNOWLEDGE-GRAPH.md` bunu ayrıca sınamalıdır.

## 18.2. RAG + Fine-Tuning

Orthogonal/partially complementary.

Fine-tuning:

- retriever,
- reranker,
- query rewriter,
- generator

bileşenlerini task/domain'e adapte edebilir. Orijinal RAG da retriever/generator training bileşenleri içerir. [S1]

Fakat runtime external knowledge erişimi ile parametric behavior adaptation aynı problem değildir.

## 18.3. RAG + CAG

Potentially complementary.

Aday ayrım:

- stable/repeated context → cache,
- dynamic/large/rarely-needed evidence → retrieval.

Ama cache freshness ve bounded corpus koşulları `04-CAG.md` içinde ayrıca araştırılmalıdır.

## 18.4. RAG + Long Context

Rakip olmak zorunda değildir.

Retrieval:

- input'u küçültür,
- büyük corpus'ta selectivity sağlar,
- fakat omission riskini getirir.

Long Context:

- daha geniş evidence'i birlikte görünür yapabilir,
- fakat cost/attention/utilization sorunları doğurabilir.

Hybrid routing ve retrieved-then-long-context composition mümkündür; kapsamlı kıyas `05-LONG-CONTEXT.md` dosyasına bırakılmıştır.

---

## 19. Decision boundary

## USE WHEN — RAG güçlü adaydır

RAG özellikle şu koşulların birkaçı birlikte doğruysa güçlü adaydır:

1. Knowledge model weights dışında yaşamalı veya sık değişiyor.
2. Corpus tek request'te full context'e koymak için büyük.
3. Task belirli evidence parçalarını lokalize edebiliyor.
4. Source provenance / citation / audit trail önemli.
5. Model retraining yapmadan knowledge update etmek gerekiyor.
6. Private/domain-specific corpus kullanılacak.
7. Retrieval quality ölçülebilir ve representative evaluation set kurulabilir.
8. Source authority, permission ve freshness metadata'sı enforce edilebilir.
9. Retrieval failure durumunda deeper search / abstention / alternate source yolu var.

## AVOID AS DEFAULT — RAG yanlış default olabilir

1. Corpus küçük, bounded, stable ve doğrudan context'e güvenle sığıyorsa.
2. Task bütün corpus'un global/holistic yapısını aynı anda anlamayı gerektiriyorsa ve chunk retrieval sistematik context loss üretiyorsa.
3. Gerekli evidence'ın query'den lokalize edilmesi çok zorsa.
4. Authoritative source set belirlenemiyorsa.
5. Retrieval omission'ının yüksek etkili olduğu fakat recall doğrulanamıyorsa.
6. Access/security boundary enforce edilemiyorsa.
7. Runtime latency çok kritik ve retrieval değeri düşükse.
8. Corpus poisoning riski yüksek fakat ingestion governance yoksa.
9. “RAG kullandık, dolayısıyla factualız” gibi false assurance yaratacaksa.

## NEEDS EVIDENCE — architecture seçiminden önce bilinmeli

- Corpus size ve growth rate.
- Update/change frequency ve freshness SLA.
- Source authority hierarchy.
- Permission / tenant model.
- Query distribution: exact, semantic, factoid, multi-hop, cross-document, relation-heavy, broad synthesis.
- Representative gold evidence / benchmark set.
- Required retrieval recall ve acceptable omission risk.
- No-answer / insufficient-evidence frequency.
- Latency ve cost budget.
- Required provenance granularity.
- Threat model ve untrusted-source exposure.
- Update/delete propagation requirements.
- Whether full-context/CAG/graph alternatives are simpler for the actual corpus.

## DOES NOT PROVE — bu araştırmadan çıkmayan kararlar

Bu dosya aşağıdakileri **kanıtlamaz veya yetkilendirmez**:

- SOUL kesinlikle RAG kullanmalıdır.
- Development OS vector database'e taşınmalıdır.
- Semantic search canonical router'ların yerini almalıdır.
- Dense retrieval sparse/hybrid retrieval'dan genel olarak üstündür.
- Belirli embedding model / vector DB / cloud vendor seçilmelidir.
- RAG her turn çalışmalıdır.
- Current foundation hierarchy bir retrieval schema'sına dönüştürülmelidir.
- RAG knowledge governance'ı çözer.
- RAG hallucination'ı ortadan kaldırır.
- RAG output'u verified yapar.
- Retrieved content güvenilir instruction'dır.
- RAG, Knowledge Graph / CAG / Long Context / Fine-Tuning ihtiyacını ortadan kaldırır.

---

## 20. Araştırmada yanlışlanan / güçlenen başlangıç hipotezleri

### H1 — “RAG = vector search”

**Yanlışlandı / aşırı dar.**

RAG modern literatürde retrieval/generation/augmentation ve pre/post retrieval controls içeren yöntem ailesidir. Sparse, dense, hybrid, iterative ve adaptive yollar vardır. [S2]

### H2 — “External corpus varsa her zaman retrieve et”

**Yanlışlandı.**

Adaptive retrieval çalışmaları no-retrieval / single-step / iterative path arasında task complexity'ye göre seçim yapılmasının değerini göstermektedir. [S9]

### H3 — “Doğru document retrieve edilirse factual output gelir”

**Yanlışlandı.**

RAGTruth, ALCE ve knowledge-conflict literatürü retrieval sonrası generation/use failure'ın sürdüğünü gösterir. [S13][S14][S15]

### H4 — “RAG freshness'i çözer”

**Koşullu.**

RAG update path sağlar. Freshness, ingestion/index synchronization ve version governance çalışıyorsa mümkündür.

### H5 — “RAG provenance'ı çözer”

**Koşullu.**

Source linkage kolaylaşır; claim-level support correctness ve citation completeness ayrıca doğrulanmalıdır. [S13]

### H6 — “RAG SOUL için tek knowledge strategy olabilir”

**Desteklenmedi.**

RAG retrieval/access katmanıdır; relation representation, repeated stable context, full-context synthesis ve model adaptation farklı problemler olarak açık kalır.

### H7 — “Development OS'de relevance en önemli ranking signal'ıdır”

**Project synthesis tarafından güçlü biçimde reddedildi.**

Development OS için canonical authority, currentness, epistemic status ve permission; relevance'dan önce candidate eligibility'yi belirleyebilir.

---

## 21. En önemli SOUL/Development OS bulguları

### F-RAG-01 — RAG bir knowledge store değil evidence-access capability'dir

**Confidence:** high  
**Basis:** foundational + survey + pipeline literature. [S1][S2]

Bu ayrım, RAG'ın final “knowledge architecture” gibi yanlış konumlandırılmasını engeller.

### F-RAG-02 — Retrieval correctness çok katmanlıdır

**Confidence:** high  
**Basis:** retrieval, chunking, evaluation ve citation/hallucination literatürünün ortak sonucu. [S5][S11][S12][S13][S14]

Source eligibility → retrieval → evidence use → downstream action ayrı test edilmelidir.

### F-RAG-03 — RAG'ın en önemli failure'larından biri omission'dır

**Confidence:** high  
**Basis:** passage context, query formation, multi-hop ve evaluation evidence. [S5][S6][S8]

“Yanlış belge getirmek” kadar “yük taşıyan belgeyi hiç getirmemek” önemlidir.

### F-RAG-04 — Retrieval policy retriever'dan daha genel bir control problemidir

**Confidence:** medium-high  
**Basis:** Adaptive-RAG, CRAG, IRCoT ve modular RAG literature. [S8][S9][S16]

Ne zaman, nereden, kaç aşamada ve hangi fallback ile retrieve edileceği ayrı bir control surface'tir.

### F-RAG-05 — SOUL için source authority similarity'den bağımsız bir boyuttur

**Confidence:** high as project-system inference  
**Basis:** SOUL/Development OS canonical-source requirements + RAG failure/security evidence.

Semantic similarity authoritative status'u kanıtlamaz.

### F-RAG-06 — Development OS'nin current progressive retrieval'i RAG problemine yakındır fakat vector-RAG değildir

**Confidence:** high  
**Basis:** current repository operation.

Bu nedenle mevcut yapı “RAG ile değiştirilmesi gereken eski sistem” olarak değil, RAG araştırmasıyla karşılaştırılacak controlled retrieval baseline'ı olarak ele alınmalıdır.

### F-RAG-07 — RAG governance yükünü azaltmaz; governance'ı pipeline'a taşır

**Confidence:** high  
**Basis:** freshness/provenance/security/evaluation evidence + 2026 trustworthy-RAG survey. [S17][S18][S19]

### F-RAG-08 — Agentic RAG security, ordinary QA RAG'dan daha yüksek etkili olabilir

**Confidence:** medium-high  
**Basis:** OWASP threat model + PoisonedRAG; downstream tool authority nedeniyle project-specific impact inference. [S17][S18]

Retrieved malicious content yalnız yanlış cevap değil, yanlış eylem riski yaratabilir.

---

## 22. Açık sorular — architecture öncesi gerekli bilgi

Bu RAG araştırması aşağıdaki project-specific soruları çözmez:

1. SOUL'un gerçek runtime knowledge sources'ları neler olacak?
2. Source authority modeli nasıl olacak?
3. Bilgi corpus'ları ne kadar büyük ve ne kadar hızlı değişecek?
4. Hangi Work class'ları exact retrieval, semantic retrieval, multi-hop veya full-context gerektirecek?
5. SOUL'un generated claim'lerinde hangi provenance granularity gerekli?
6. Retrieval gate deterministic mi, learned mi, policy-based mi olmalı?
7. High-impact Work için minimum acceptable evidence recall nasıl tanımlanmalı?
8. RAG ile Knowledge Graph arasındaki gerçek relation-heavy boundary nerede?
9. Stable knowledge için CAG/RAG bölüşümü nasıl yapılmalı?
10. Long Context kapasitesi arttıkça RAG hangi task'larda gereksiz karmaşıklık olur?
11. Development OS'nin mevcut canonical router'ları semantic search ile nasıl birleşebilir ve authority kaybetmeden nasıl eval edilebilir?
12. Retrieval corpus'una yazma authority'si ve poisoning threat model'i ne olacak?

Bu sorular architecture/design aşamasında veya ilgili sonraki araştırmalarda çözülmelidir.

---

## 23. Araştırma yöntemi ve sınırlar

Bu çalışma:

- foundational RAG paper,
- peer-reviewed retrieval literature,
- query/chunking/adaptive retrieval çalışmaları,
- RAG evaluation benchmarks/frameworks,
- hallucination/citation/conflict çalışmaları,
- security guidance ve peer-reviewed security research,
- 2026 trustworthy-RAG survey

üzerinden cross-source synthesis yapmıştır.

### Bilinçli sınırlar

- Her RAG paper'ı taranmamıştır; alan çok büyüktür.
- Her retriever/embedding/vector database/vendor benchmark edilmemiştir.
- Local SOUL corpus üzerinde retrieval benchmark'ı çalıştırılmamıştır.
- Bu nedenle project-specific performance iddiası yoktur.
- Survey ve benchmark sonuçları kendi dataset/model dönemleriyle sınırlıdır; universal dominance iddiasına çevrilmemiştir.
- OWASP guidance engineering/security guidance olarak kullanılmış, deneysel universal theorem gibi ele alınmamıştır.
- Self-evaluation/corrective-RAG fikirleri independent verification sayılmamıştır.
- 2026 survey field-level trustworthiness taxonomy için kullanılmış; tek başına mekanizma seçimi kanıtı sayılmamıştır.

### Stopping rationale

Araştırma, yeni kaynakların ana failure sınıflarını değiştirmekten çok mevcut ayrımları güçlendirmeye başladığı noktada boundedly closed kabul edilmiştir. Ana karar sınırları—source eligibility, retrieval correctness, evidence-use correctness, downstream action correctness; adaptive retrieval; freshness/provenance; security; modular evaluation—birden fazla bağımsız araştırma hattında tekrar ortaya çıkmıştır.

Bu, “RAG hakkında artık araştırılacak şey yok” anlamına gelmez. Yalnız bu paketin **SOUL / Development OS relevance ve decision-boundary** hedefi için yeterli bir bounded synthesis üretildiği anlamına gelir.

---

## 24. Source ledger

### Foundational / field framing

**[S1] Lewis, P. et al. (2020). _Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks_. NeurIPS 2020.**  
https://arxiv.org/abs/2005.11401  
Use: original RAG framing; parametric + non-parametric memory; retrieval/generation coupling; provenance/update motivation.  
Limit: original architecture is narrower than current RAG ecosystem.

**[S2] Gao, Y. et al. (2023/2024). _Retrieval-Augmented Generation for Large Language Models: A Survey_.**  
https://arxiv.org/abs/2312.10997  
Use: Naive / Advanced / Modular RAG framing; field-level component map.  
Limit: survey; taxonomy is literature synthesis, not universal architecture law.

### Retrieval representations

**[S3] Karpukhin, V. et al. (2020). _Dense Passage Retrieval for Open-Domain Question Answering_. EMNLP 2020.**  
https://aclanthology.org/2020.emnlp-main.550/  
DOI: 10.18653/v1/2020.emnlp-main.550  
Use: learned dense retrieval evidence.  
Limit: benchmark-specific; does not prove dense superiority for all domains.

**[S4] Luan, Y. et al. (2021). _Sparse, Dense, and Attentional Representations for Text Retrieval_. TACL 9.**  
https://aclanthology.org/2021.tacl-1.20/  
DOI: 10.1162/tacl_a_00369  
Use: dense representation capacity limits; sparse/dense/attentional trade-offs.

### Chunking / document context

**[S5] Wang, K., Reimers, N., Gurevych, I. (2024). _DAPR: A Benchmark on Document-Aware Passage Retrieval_. ACL 2024.**  
https://aclanthology.org/2024.acl-long.236/  
DOI: 10.18653/v1/2024.acl-long.236  
Use: missing parent-document context as substantial passage-retrieval failure source.  
Limit: DAPR benchmark conditions; 53.5% figure is not universal RAG failure rate.

### Query transformation / iterative retrieval

**[S6] Ma, X. et al. (2023). _Query Rewriting in Retrieval-Augmented Large Language Models_. EMNLP 2023.**  
https://aclanthology.org/2023.emnlp-main.322/  
DOI: 10.18653/v1/2023.emnlp-main.322  
Use: user input and retrieval query need not be equivalent.

**[S7] Gao, L. et al. (2023). _Precise Zero-Shot Dense Retrieval without Relevance Labels (HyDE)_. ACL 2023.**  
https://aclanthology.org/2023.acl-long.99/  
DOI: 10.18653/v1/2023.acl-long.99  
Use: generated hypothetical representation as retrieval pivot; query representation is design variable.

**[S8] Trivedi, H. et al. (2023). _Interleaving Retrieval with Chain-of-Thought Reasoning for Knowledge-Intensive Multi-Step Questions_. ACL 2023.**  
https://aclanthology.org/2023.acl-long.557/  
DOI: 10.18653/v1/2023.acl-long.557  
Use: iterative/interleaved retrieval for multi-step knowledge tasks.

### Adaptive / corrective retrieval

**[S9] Jeong, S. et al. (2024). _Adaptive-RAG: Learning to Adapt Retrieval-Augmented Large Language Models through Question Complexity_. NAACL 2024.**  
https://aclanthology.org/2024.naacl-long.389/  
DOI: 10.18653/v1/2024.naacl-long.389  
Use: no-retrieval / single-step / iterative path selection by complexity.

**[S10] Asai, A. et al. (2024). _Self-RAG: Learning to Retrieve, Generate, and Critique through Self-Reflection_. ICLR 2024.**  
https://arxiv.org/abs/2310.11511  
Use: conditional retrieval / critique concept.  
Limit: self-reflection is not independent verification.

**[S16] Yan, S.-Q. et al. (2024). _Corrective Retrieval Augmented Generation_.**  
https://arxiv.org/abs/2401.15884  
Use: retrieval-quality assessment and corrective/fallback retrieval concept.  
Limit: arXiv/benchmark evidence; evaluator is not automatically an independent oracle.

### Evaluation

**[S11] Es, S. et al. (2024). _RAGAs: Automated Evaluation of Retrieval Augmented Generation_. EACL 2024 Demo.**  
https://aclanthology.org/2024.eacl-demo.16/  
Use: retrieval/context/generation dimensions evaluated separately.  
Limit: automated evaluator; not sufficient as sole high-stakes oracle.

**[S12] Ru, D. et al. (2024). _RAGChecker: A Fine-grained Framework for Diagnosing Retrieval-Augmented Generation_. NeurIPS 2024.**  
https://proceedings.neurips.cc/paper_files/paper/2024/hash/27245589131d17368cccdfa990cbf16e-Abstract-Datasets_and_Benchmarks_Track.html  
DOI: 10.52202/079017-0692  
Use: modular fine-grained retrieval/generation diagnosis.

### Attribution / hallucination / conflict

**[S13] Gao, T. et al. (2023). _Enabling Large Language Models to Generate Text with Citations (ALCE)_. EMNLP 2023.**  
https://aclanthology.org/2023.emnlp-main.398/  
DOI: 10.18653/v1/2023.emnlp-main.398  
Use: citation correctness/completeness as separate evaluation dimensions; retrieved sources do not ensure fully supported claims.

**[S14] Niu, C. et al. (2024). _RAGTruth: A Hallucination Corpus for Developing Trustworthy Retrieval-Augmented Language Models_. ACL 2024.**  
https://aclanthology.org/2024.acl-long.585/  
DOI: 10.18653/v1/2024.acl-long.585  
Use: unsupported/contradictory generation persists in RAG settings.

**[S15] Xu, R. et al. (2024). _Knowledge Conflicts for LLMs: A Survey_. EMNLP 2024.**  
https://aclanthology.org/2024.emnlp-main.486/  
DOI: 10.18653/v1/2024.emnlp-main.486  
Use: context-memory and inter-context conflict taxonomy.

### Security / trustworthiness

**[S17] OWASP Cheat Sheet Series. _Retrieval-Augmented Generation (RAG) Security Cheat Sheet_. Current read: 2026-09-03.**  
https://cheatsheetseries.owasp.org/cheatsheets/RAG_Security_Cheat_Sheet.html  
Use: production RAG threat/control surface: poisoning, permissions, prompt injection, data leakage, downstream agents.  
Limit: engineering guidance, not peer-reviewed empirical proof; numeric defaults are not treated as universal.

**[S18] Zou, W., Geng, R., Wang, B., Jia, J. (2025). _PoisonedRAG: Knowledge Corruption Attacks to Retrieval-Augmented Generation of Large Language Models_. USENIX Security 2025.**  
https://www.usenix.org/conference/usenixsecurity25/presentation/zou-poisonedrag  
Use: empirical evidence that RAG knowledge databases create a practical poisoning attack surface.  
Limit: attack success rates are experiment-specific, not universal deployment probabilities.

**[S19] Ni, B. et al. (2026). _Towards Trustworthy Retrieval Augmented Generation for Large Language Models: A Survey_. ACM Computing Surveys.**  
https://research.adobe.com/publication/towards-trustworthy-retrieval-augmented-generation-for-large-language-models-a-survey/  
DOI: 10.1145/3837074  
Publication date: 2026-08-06.  
Use: current field-level trustworthiness framing across reliability, safety, privacy, fairness, explainability and accountability.  
Limit: survey; does not select a specific architecture for SOUL.

---

## 25. Current handoff

**Completed:** `01-RAG.md` bounded deep research.  
**Result:** RAG is a high-relevance external evidence-access capability pattern, not a universal knowledge architecture or truth mechanism.  
**Key project-specific finding:** Development OS/SOUL retrieval cannot rank by semantic relevance alone; canonical authority, epistemic status, freshness, permission and provenance may determine eligibility before relevance.  
**Verification:** cross-source synthesis only; no local implementation benchmark / independent verification.  
**Architecture decision:** none.  
**Foundation-tree effect:** none.  
**Next planned file:** `02-KNOWLEDGE-GRAPH.md`.  
**Next action:** stop here; do not start Knowledge Graph deep research in this turn.
