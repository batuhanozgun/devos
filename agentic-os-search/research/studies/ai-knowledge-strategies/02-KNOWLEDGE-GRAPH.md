# Knowledge Graph — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `01-RAG.md`  
**Research object:** Knowledge Graph (KG) / relation-centric knowledge representation  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** separate technical research line; does not modify, reinterpret or instantiate the current foundation hierarchy as an ontology/schema  
**Verification status:** cross-source research synthesis; no local KG implementation, corpus extraction benchmark or independent verification executed  
**Package position:** file 2 of 5 technical deep-dives; next planned file is `03-FINE-TUNING.md`

---

## 1. Araştırma sorusu

Bu dosya şu soruyu araştırır:

> **Knowledge Graph hangi gerçek problem sınıflarını çözer, hangi koşullarda graph representation gerçekten değer üretir, hangi construction/quality/governance failure mode'larını yaratır ve SOUL ile Development OS açısından hangi karar sınırlarını görünür hale getirir?**

Bu soru şu daha dar sorularla aynı değildir:

> “Neo4j kullanalım mı?”  
> “RDF mi property graph mı?”  
> “SOUL foundation ağacını graph database'e çevirelim mi?”

Bu dosya özellikle şu yanlış başlangıçları reddeder:

- Knowledge Graph = graph database değildir.
- Knowledge Graph = RDF olmak zorunda değildir.
- Knowledge Graph = ontology olmak zorunda değildir.
- Knowledge Graph = ilişkili her veri için otomatik olarak en iyi representation değildir.
- Graph üzerinde bir edge bulunması, o ilişkinin doğru, güncel, authoritative veya nedensel olduğu anlamına gelmez.
- Graph'ta bir edge bulunmaması, ilişkinin gerçek dünyada olmadığı anlamına gelmez.
- Knowledge Graph completion ile bulunan/predicted edge, source-observed fact ile aynı epistemic statüde değildir.
- GraphRAG = Knowledge Graph'ın tek kullanım biçimi değildir.
- GraphRAG = vanilla RAG'ın genel olarak daha iyi versiyonu değildir.
- Mevcut SOUL Foundations araştırma hierarchy'si = ontology/schema değildir.

---

## 2. Kısa hüküm

### 2.1. Knowledge Graph nedir?

Literatürde “Knowledge Graph” için tek ve tartışmasız bir tanım yoktur. Hogan ve arkadaşları terimin tanımının tartışmalı olduğunu; farklı teknik ve kapsayıcı tanımların bulunduğunu belirtir. Bu araştırma için en kullanışlı minimum tanım şudur: [S1][S2]

> **Knowledge Graph, gerçek veya kavramsal dünyadaki entity/concept'leri ve bunlar arasındaki anlamlı ilişkileri graph tabanlı bir data model içinde açıkça temsil etmeyi amaçlayan ilişki-merkezli bir bilgi yapısıdır.**

Bu minimum tanımın ötesinde sistemler önemli biçimde farklılaşabilir:

- RDF triple / dataset,
- labeled property graph,
- explicit ontology'li veya schema-light graph,
- deductive rule'lar içeren veya içermeyen yapı,
- static, temporal, event-centric veya evolving graph,
- manually curated, automatically extracted veya hybrid graph,
- source facts + inferred knowledge + predicted links'in farklı kombinasyonları.

Dolayısıyla “Knowledge Graph kullanalım” ifadesi tek başına implementation specification değildir.

### 2.2. Bu araştırmanın ana sonucu

**Knowledge Graph, SOUL ve Development OS için özellikle relation-heavy, dependency-heavy, provenance-heavy ve multi-hop bilgi problemlerinde yüksek potansiyel öneme sahip bir representation/capability pattern'dir; fakat universal knowledge store veya universal architecture default'u olmamalıdır.**

Graph representation özellikle şu koşullarda güçlü adaydır:

- entity'ler arasındaki ilişkiler birinci sınıf bilgi ise,
- sık sorulan sorular traversal / dependency / impact / multi-hop gerektiriyorsa,
- farklı kaynaklardaki aynı entity'lerin birleştirilmesi gerekiyorsa,
- source → evidence → decision gibi provenance zincirleri sorgulanacaksa,
- Actor → authority → Work gibi typed relations çalışma açısından yük taşıyorsa,
- relation'ın kendisine tarih, source, confidence, status veya başka metadata bağlanması gerekiyorsa,
- “hangi öğeler bu değişiklikten etkilenir?” türü graph reachability/impact soruları önemliyse.

Fakat graph yalnızca bir **representation ve query/reasoning yüzeyi** sağlar. Şunları otomatik çözmez:

- hangi source'un doğru veya authoritative olduğu,
- extraction'ın doğru olduğu,
- entity identity'nin doğru çözüldüğü,
- edge semantics'in doğru modellendiği,
- graph'ın complete olduğu,
- stale edge'lerin temizlendiği,
- inferred link'in gerçek fact olduğu,
- access control'un doğru uygulandığı,
- downstream kararın doğru olduğu.

Bu nedenle Knowledge Graph'ın değeri “ilişkileri çizmesi” değil, **doğru relation semantics'i, doğru identity'yi, doğru context/provenance'ı ve doğru lifecycle'ı güvenilir biçimde taşıyabilmesi** ile belirlenir.

---

## 3. Terim problemi: Knowledge Graph tek bir teknik nesne değildir

Hogan et al. Knowledge Graph tanımının contentious olduğunu açıkça belirtir; Ji et al. ise KG'yi entities, relationships ve semantic descriptions içeren structured fact representation olarak ele alır. Otomatik KG construction survey'leri de ontology ağırlıklı ve daha hafif semantic-graph tanımlarını yan yana kullanır. [S1][S2][S3]

Bu nedenle araştırmada aşağıdaki katmanları ayırmak gerekir:

```text
Knowledge representation intent
        ↓
Graph data model
        ↓
Schema / ontology / constraints
        ↓
Storage / query engine
        ↓
Construction / extraction pipeline
        ↓
Reasoning / retrieval / application
```

Bunların hepsi aynı şey değildir.

Örneğin:

- Bir RDF graph bir graph data model'dir.
- OWL bir ontology language'dir.
- SHACL graph constraints/validation için kullanılabilir.
- SPARQL RDF query language'dir.
- Bir graph database storage/query engine'dir.
- GraphRAG, graph structure'u retrieval/generation pipeline'ında kullanan application pattern'dir.

Bu ayrım SOUL açısından kritiktir. Çünkü “relation-heavy problem var” sonucu doğrudan “şu graph database'i seç” sonucuna geçmemelidir.

---

## 4. Graph database, ontology ve Knowledge Graph ayrımı

### 4.1. Graph database ≠ Knowledge Graph

Graph database bir storage/query technology sınıfıdır. Knowledge Graph ise bilgi representation amacı ve semantic structure ile ilgilidir.

Aynı KG farklı storage katmanlarında tutulabilir; graph-like query bir relational engine üzerinde de uygulanabilir. Stanford'ın graph data model notları RDF/property graph modellerini relational model ile karşılaştırırken graph traversal'ın bazı relation-heavy query'lerde daha doğal/kompakt olduğunu, fakat graph model'in her veri tipinde üstün olmadığını açıkça belirtir. [S4]

### 4.2. Ontology ≠ Knowledge Graph

Ontology kavramları, relation'ları, class hierarchy'leri, constraint/axiom'ları formalize edebilir. Bazı KG yaklaşımları güçlü ontology kullanır; bazıları schema-light veya schema-free olabilir.

LLM-empowered KGC survey'i 2025 itibarıyla hem **schema-based** hem **schema-free** paradigmaları ayrı hatlar olarak inceler. Schema-based yaklaşım normalization/consistency sağlar; schema-free yaklaşım flexibility/open discovery avantajı taşır. [S5]

Dolayısıyla:

> “KG varsa mutlaka ağır ontology gerekir” doğru değildir.

Ancak ters yöndeki iddia da tehlikelidir:

> “Schema gerekmez, LLM entity/edge çıkarsın yeter” de doğru değildir.

Relation semantics, identity, allowed types ve validation ihtiyacı arttıkça explicit schema/constraints değeri yükselir.

### 4.3. Knowledge Graph ≠ relational database replacement

Graph modeller traversal-heavy ve relationship-centric query'lerde doğal avantaj taşıyabilir. Fakat primarily numeric/time-series data veya relation traversal'ın yük taşımadığı durumlarda graph model gereksiz karmaşıklık yaratabilir. Stanford örneği graph model'in time-series gibi alanlarda doğal olmadığını ve daha yüksek arity relation'ların binary edge modeline zorla çevrilmesinin conceptual clarity kaybettirebileceğini gösterir. [S4]

SOUL için bunun genel dersi:

> **Data model problemi, “hangi model daha modern?” değil, “hangi query/semantic workload hangi representation'da doğal ve doğrulanabilir?” sorusudur.**

---

## 5. Knowledge Graph'ın gerçek avantajı: relation'ı first-class yapmak

Flat document veya tabular representation'da relation çoğu zaman implicit veya join/query sırasında recover edilir.

Knowledge Graph'ta relation açık bir nesne haline gelir:

```text
Actor-A ──authorised_for──> Work-B
Work-B  ──depends_on──────> Capability-C
Decision-D ─supported_by──> Evidence-E
Evidence-E ─derived_from──> Source-F
Source-F ─supersedes──────> Source-G
```

Bu yapı şu soruları daha doğal hale getirebilir:

- Work-B hangi capability'lere bağlı?
- Capability-C kaybolursa hangi Work'ler etkilenir?
- Decision-D hangi source chain'e dayanıyor?
- Source-G superseded olduysa hangi derived decision'lar yeniden değerlendirme adayı?
- Actor-A hangi Work'lerde hangi authority'ye sahip?
- Bir entity'ye iki farklı path üzerinden ulaşılıyor mu?
- Aynı relation hangi tarihler arasında geçerli?

Ancak relation'ın graph'ta explicit olması, relation'ın **doğru** olduğu anlamına gelmez.

Bu araştırmanın en önemli epistemik ayrımlarından biri:

```text
relation represented
      ≠
relation validated
      ≠
relation current
      ≠
relation authoritative
      ≠
relation causal
```

Graph formalitesi yanlış bilgiyi daha doğru gösteren bir “false precision” etkisi yaratabilir.

---

## 6. Representation aileleri

### 6.1. RDF

RDF graph, subject–predicate–object triples üzerinden bilgi temsil eder. RDF 1.1 Recommendation'dır; RDF 1.2 ise 7 Nisan 2026 itibarıyla Candidate Recommendation Snapshot seviyesindedir. RDF 1.2 triple terms gibi statement-level metadata'yı kolaylaştıran yeni representation özellikleri getirir. [S6]

RDF ekosisteminde:

- global identifiers / IRIs,
- vocabularies,
- named graphs / datasets,
- SPARQL querying,
- OWL semantics,
- SHACL validation,
- PROV-O provenance

gibi composable standards bulunur. [S6][S7][S8][S9]

Bu interoperability ve formal semantics açısından güçlüdür; fakat her application için gerekli olmayabilir.

### 6.2. Labeled Property Graph

Property graph model node ve edge'lere label/property bağlamayı doğal hale getirir. Relation'a `valid_from`, `source_sha`, `confidence`, `status` gibi metadata koymak uygulama açısından doğrudan olabilir. [S4]

Bu model relation traversal ve application-centric graph işlemlerinde pratik olabilir.

### 6.3. Model seçimi teknoloji seçimi değildir

RDF ve property graph arasında mapping mümkündür fakat semantics/expressivity/metadata modelleme biçimleri farklılaşır. Bu nedenle veri modelinin seçimi:

- interoperability,
- formal reasoning,
- edge metadata,
- traversal workload,
- tooling,
- portability,
- standards dependency

gibi kriterlerle değerlendirilmelidir.

Bu araştırma bunlardan birini SOUL için seçmez.

---

## 7. Construction lifecycle: graph'ın asıl maliyeti veriyi graph'a dönüştürmektir

Knowledge Graph'ın değeri yalnız query zamanında ortaya çıkmaz; en büyük epistemik riskler construction aşamasında oluşabilir.

Automatic KGC literatürü süreci farklı taxonomy'lerle ele alsa da şu lifecycle oldukça genel bir synthesis sağlar: [S3][S10][S11]

```text
Purpose / competency questions
        ↓
Source selection
        ↓
Schema / ontology / relation vocabulary
        ↓
Parsing / extraction
        ↓
Entity identification + coreference
        ↓
Entity resolution / alignment
        ↓
Relation / event / attribute extraction
        ↓
Knowledge fusion + conflict handling
        ↓
Provenance / temporal / status annotation
        ↓
Validation / quality assessment
        ↓
Publication / query / application
        ↓
Update / deletion / evolution / revalidation
```

Her adım hata biriktirebilir.

### 7.1. Pipeline error propagation

Bir entity yanlış çıkarılırsa relation extraction yanlış node'a bağlanabilir. Aynı entity iki node'a split edilirse downstream traversal eksik görünür. Farklı entity'ler yanlış merge edilirse graph sahte path'ler üretir.

LLM-empowered KGC survey'i traditional pipeline'larda cumulative error propagation'ı temel sorunlardan biri olarak vurgular. [S5]

Bu nedenle “LLM ile otomatik KG çıkaralım” düşük maliyetli bir preprocessing ayrıntısı değildir; **source → graph fidelity** ayrıca doğrulanması gereken bir transform'dur.

---

## 8. Schema / ontology: düzen ile rigidity arasındaki trade-off

### 8.1. Schema ne sağlar?

Explicit schema veya ontology şunlara katkı sağlayabilir:

- entity type'larını tanımlamak,
- relation vocabulary'yi sınırlandırmak,
- domain/range semantiği,
- hierarchy / subclass semantics,
- constraint ve validation,
- interoperability,
- ortak query vocabulary,
- extraction hedeflerini netleştirmek.

SHACL gibi standards RDF graph'larını explicit shapes/conditions'a göre validate etmeyi sağlar. [S8]

### 8.2. Schema neyi zorlaştırır?

Domain değiştiğinde yeni relation/entity/event type'ları ortaya çıkabilir. EMNLP 2023 Schema-Adaptable KGC çalışması static predefined schema yaklaşımının dynamic domains'te yetersiz kalabildiğini ve schema expansion'ın ayrı problem olduğunu gösterir. [S12]

Bu nedenle schema yalnız başlangıç tasarımı değil, lifecycle yüküdür:

```text
schema design
 → versioning
 → migration
 → compatibility
 → extraction adaptation
 → validation update
 → downstream query update
```

### 8.3. SOUL açısından kritik risk: araştırma taxonomy'sini production ontology'ye erken dondurmak

Current SOUL Foundations state açıkça mevcut hierarchy'nin research-routing hypothesis olduğunu, ontology/schema/data model olmadığını belirtir.

Bu nedenle:

> `Environment / Information / Work / Actors` gibi araştırma ayrımlarını bugün graph class'larına çevirmek epistemik olarak yetkisiz ve metodolojik olarak prematüredir.

Research hierarchy'nin amacı olguyu keşfetmek; ontology'nin amacı operational semantics'i formalize etmek olabilir. Bunlar aynı şey değildir.

---

## 9. Identity / entity resolution yük taşıyan problemdir

Graph'ta bir node'un “aynı şey” olduğunu belirlemek relation reasoning'in önkoşuludur.

Multi-source KG'lerde entity alignment farklı kaynaklardaki kayıtların aynı real-world object'e refer edip etmediğini belirler. Entity alignment survey'leri bunu knowledge fusion'ın temel sorunlarından biri olarak ele alır. [S13]

### 9.1. İki kritik failure

**False split**

```text
SOUL
Soul project
batuhanozgun/soul
```

aynı entity olduğu halde üç node oluşur.

Sonuç:
- relations dağılır,
- retrieval recall düşer,
- dependency chain parçalanır.

**False merge**

İki farklı Work Package aynı short name nedeniyle tek node'a birleşir.

Sonuç:
- sahte relation'lar oluşur,
- yanlış authority/path inference yapılır,
- contamination graph'ın başka bölgelerine yayılır.

### 9.2. Stable identity ihtiyacı

Development OS gibi source-controlled ortamda node identity mümkün olduğunda semantic similarity yerine stable identifier'lara bağlanmalıdır:

- repository + path,
- commit/blob SHA,
- work package ID,
- decision ID,
- Actor ID,
- explicit canonical entity key.

Bu **project synthesis**'tir; architecture decision değildir.

---

## 10. Relation extraction: bir edge üretmek bir iddia üretmektir

Knowledge Graph construction'da relation extraction yalnız NLP işlemi değildir. Her extracted edge bir assertion yaratır.

Örneğin metin:

> “WP-021 proposes X; WP-022 later rejected part of it.”

naive extraction şu edge'i çıkarabilir:

```text
WP-021 ──implements──> X
```

halbuki source yalnız proposal söylüyor olabilir.

Yanlış predicate seçimi epistemic status'u değiştirir.

Relation extraction literatürü triplet prediction, context encoding ve relation classification'ın ayrı challenges taşıdığını gösterir. [S14]

SOUL/Development OS için relation vocabulary şu ayrımları korumak zorunda olabilir:

- `proposes` vs `decides`,
- `supports` vs `proves`,
- `references` vs `depends_on`,
- `observed_in` vs `inferred_from`,
- `authorised_for` vs `performed`,
- `supersedes` vs `contradicts`,
- `current` vs `historical`.

Graph bu ayrımları güçlü biçimde taşıyabilir; fakat yanlış predicate onları güçlü biçimde **bozabilir** de.

---

## 11. Binary edge her ilişkiyi doğal temsil etmez

Graph representation çoğu zaman binary relation'a dayanır:

```text
A ─relation→ B
```

Fakat gerçek bilgiler çoğu zaman contextual / n-ary'dir:

> Actor A, Work B üzerinde, Environment C altında, tarih T1–T2 arasında, scope S için authority taşıyor.

Bunu tek binary edge'e sıkıştırmak kritik context'i kaybedebilir.

Çözümler:

- relation properties,
- statement node / reification,
- event/entity modeling,
- named graph/context,
- RDF 1.2 triple-term / statement metadata türü mekanizmalar

olabilir. [S4][S6]

Ama model karmaşıklaştıkça query ve maintenance maliyeti artar.

Bu nedenle “relation var → edge yeter” varsayımı güvenli değildir.

---

## 12. Provenance: graph'ın SOUL açısından en güçlü potansiyel alanlarından biri

Bir fact/edge'in kaynağı bilinmiyorsa graph yalnız structured assertion deposudur.

PROV-O provenance için entities, activities ve agents arasındaki provenance ilişkilerini modellemek üzere W3C standardı sunar. Provenance-aware KG literatürü de statement-level provenance'ın authority ve trust için önemli olduğunu gösterir. [S9][S15][S16]

SOUL/Development OS açısından aday relation representation:

```text
Claim-C
  ├── derived_from → Source-S
  ├── extracted_by → Process-P
  ├── status → observation / inference / hypothesis / accepted
  ├── valid_at → T
  └── source_ref → repo/path/SHA
```

Bu model **architecture proposal değildir**; Knowledge Graph'ın hangi tür problemi iyi ifade edebileceğini gösteren bir analytical example'dır.

### 12.1. Provenance granularity kararı

Provenance:

- node-level,
- edge-level,
- statement-level,
- subgraph-level,
- document-level

olabilir.

Document-level provenance bazı yüksek-risk use case'lerde yetersiz kalabilir; statement-level provenance ise storage/query complexity yaratabilir.

Dolayısıyla “KG provenance sağlar” değil:

> **KG provenance'ı representation'a dahil etmeyi kolaylaştırabilir; doğru granularity ayrıca tasarlanmalıdır.**

---

## 13. Temporal knowledge: current truth için edge'in zamanı gerekir

Static KG gerçek dünyanın değişen ilişkilerini yanlış temsil edebilir.

Temporal KG literatürü birçok fact'in yalnız belirli zaman aralığında geçerli olduğunu ve static representation'ın yanlış inference üretebileceğini vurgular. [S17][S18]

Örneğin:

```text
Actor-A ──authorised_for──> Work-B
```

şu bilgiler olmadan tehlikeli olabilir:

```text
valid_from
valid_to
recorded_at
superseded_by
```

Development OS için özellikle:

- current authorization,
- current Work,
- active branch/ref,
- accepted vs superseded decision,
- tool availability,
- verification verdict freshness

dinamik olabilir.

Bu nedenle KG kullanılırsa **temporal validity bir enhancement değil, bazı relation sınıflarında correctness requirement** olabilir.

---

## 14. Completeness ve open-world problemi

Knowledge Graph'ın en tehlikeli yanlış okumalarından biri:

```text
edge yok
  ⇒
ilişki yok
```

çıkarımıdır.

Birçok KG/semantic-web regime open-world yaklaşımıyla çalışır: fact'in bulunmaması fact'in false olduğunu göstermez. OWL 2 Primer bunu database closed-world behavior'dan açıkça ayırır. [S7]

2024 ACM survey'i de real-world knowledge bases'in pragmatik biçimde inşa edildiği için çoğu zaman incomplete olduğunu ve completeness/recall/negation'ın ayrı bilgi problemi olduğunu gösterir. [S19]

### 14.1. SOUL açısından doğrudan paralel

RAG araştırmasındaki:

```text
retrieval miss ≠ source absence
```

ilkesi graph için şu hale gelir:

```text
graph miss ≠ world/source absence
```

Graph yalnız ingestion/construction coverage'ı kadar dünyayı görür.

### 14.2. Negative fact ayrı statü gerektirir

“Actor A Work-B için authorised değildir” ile “A→B authority edge'i graph'ta yok” aynı şey değildir.

Bu ayrım özellikle authority/safety control için kritiktir.

---

## 15. Knowledge Graph completion: eksik edge tahmini fact değildir

KG completion methods graph'taki pattern'lerden eksik relation'ları tahmin etmeye çalışabilir. Bu research alanı embedding, path inference ve logical-rule methods içerir. [S2]

Fakat epistemik ayrım zorunludur:

```text
source-observed edge
validated derived edge
logical entailment
statistical prediction
LLM-proposed edge
```

aynı statüde değildir.

SOUL/Development OS için graph completion şu şekilde kullanılabilir:

> “Burada olası eksik relation var; kontrol et.”

Ama şu şekilde kullanılmamalıdır:

> “Model edge'i tahmin etti, artık authority/dependency fact'i budur.”

Özellikle governance relation'larında predicted edge'in action authority üretmesi kabul edilemez bir risk olabilir.

---

## 16. Quality: graph structure kalite değildir

KG quality literature şu boyutları tekrar tekrar vurgular: [S20][S21]

- accuracy,
- consistency,
- completeness,
- timeliness,
- trustworthiness/provenance,
- accessibility/availability,
- fit-for-use.

Bir graph'ın:

- çok node içermesi,
- çok edge içermesi,
- yüksek density göstermesi,
- güzel community structure üretmesi

tek başına knowledge quality kanıtı değildir.

### 16.1. Structural metric ≠ semantic correctness

GraphRAG-Bench node count, edge count, degree ve clustering gibi structural metrics kullanır; fakat bu metrikler graph'ın underlying facts'i doğru temsil ettiğini tek başına göstermez. Aynı benchmark ayrıca retrieval evidence recall ve answer faithfulness gibi stage-specific metrics'e ihtiyaç duyar. [S22]

SOUL açısından verification en az şu katmanlara ayrılmalıdır:

1. **Source coverage:** eligible source'lar graph construction'a girdi mi?
2. **Entity accuracy:** entity boundaries/identity doğru mu?
3. **Relation accuracy:** predicate + endpoints doğru mu?
4. **Context accuracy:** provenance/time/status qualifiers doğru mu?
5. **Schema/constraint conformance:** graph structurally valid mi?
6. **Completeness:** gerekli Work/use-case için gereken relation'lar yeterince mevcut mu?
7. **Query correctness:** graph query doğru subgraph/answer üretiyor mu?
8. **Downstream use:** model graph sonucunu doğru kullanıyor mu?

SHACL gibi mechanisms structure/constraints açısından güçlü olabilir fakat graph fact'lerinin dış dünyada doğru olduğunu tek başına kanıtlamaz. [S8]

---

## 17. Inference ve reasoning: path bulunması neden bulmak değildir

Graph query ve reasoning şu işlemleri kolaylaştırabilir:

- traversal,
- reachability,
- neighborhood expansion,
- hierarchy queries,
- rule-based entailment,
- path search,
- community/centrality analysis,
- link prediction.

Ancak graph path'in semantiği kritik önemdedir.

Örneğin:

```text
A supports B
B precedes C
```

buradan:

```text
A causes C
```

çıkarılamaz.

Graph reasoning'in gücü relation types ve allowed composition rules kadar güvenilirdir.

Bu nedenle SOUL için “graph = reasoning engine” ifadesi fazla güçlüdür. Daha doğru ifade:

> **Graph, explicit relation structure üzerinde bazı reasoning/query işlemlerini mümkün kılan substrate olabilir; hangi inference'ın geçerli olduğu ayrıca formalize ve doğrulanmalıdır.**

---

## 18. LLM ile Knowledge Graph construction: fırsat ve yeni failure surface

LLM'ler ontology engineering, entity/relation extraction ve knowledge fusion süreçlerini hızlandırabilir. 2025 survey'i LLM-driven KG construction'ın ontology engineering, extraction ve fusion'da hızla geliştiğini gösterir. [S5]

Ancak 2023 LLM-for-KG experiments, GPT-4'ün reasoning tasks'ta güçlü görünürken few-shot information extraction'da daha sınırlı olduğunu raporlamıştır. [S23]

Bu önemli bir ayrımdır:

> **LLM'nin graph üzerinde reasoning yapabilmesi, graph'ı doğru çıkaracağı anlamına gelmez.**

Microsoft GraphRAG standard indexing'i LLM ile entity/relationship extraction ve summarization yapar. Güncel docs ayrıca graph extraction'ın standard indexing cost'unun yaklaşık %75'ini oluşturabildiğini ve daha ucuz FastGraphRAG'ın daha noisy graph ürettiğini belirtir. [S24]

Bu, cost–fidelity trade-off'unu somutlaştırır.

---

## 19. GraphRAG: Knowledge Graph + RAG kompozisyonu

GraphRAG, Knowledge Graph'ın LLM sistemlerinde en görünür kullanım biçimlerinden biridir fakat KG'nin kendisi değildir.

Microsoft GraphRAG:

- raw text'ten entities/relations çıkarır,
- community structure oluşturur,
- community summaries üretir,
- local/global/DRIFT search gibi farklı query modes sağlar. [S24][S25]

Original GraphRAG çalışması özellikle **global corpus-level sensemaking / query-focused summarization** sorularında naive RAG baseline'a göre comprehensiveness/diversity artışı göstermiştir. [S25]

Bu şu güçlü fakat sınırlı sonucu destekler:

> Graph structure, answer'ın tek bir passage'da bulunmadığı ve corpus genelindeki ilişkileri/sentezi gerektiren task'larda değer sağlayabilir.

Ancak buradan:

> “GraphRAG RAG'dan daha iyidir.”

sonucu çıkmaz.

---

## 20. GraphRAG benchmark evidence: graph avantajı task-dependent

2025–2026 karşılaştırmalı çalışmalar unconditional GraphRAG superiority iddiasını zayıflatır.

### 20.1. RAG vs GraphRAG systematic evaluation

Han et al.'ın 2025 çalışmasının Mart 2026 v3'ü RAG ve GraphRAG'ın farklı task/evaluation perspektiflerinde farklı strengths/trade-offs taşıdığını, selection/integration strategies'in daha tutarlı performans verebildiğini raporlar. [S26]

### 20.2. GraphRAG-Bench

Xiang et al.'ın Şubat 2026 v3 GraphRAG-Bench çalışması doğrudan şu soruyu sorar: **“Graph ne zaman kullanılmalı?”** Çalışma GraphRAG'ın birçok real-world task'ta vanilla RAG'ın altında kalabildiğini; graph value'nun fact retrieval, reasoning complexity, contextual summarization ve information density'ye göre değiştiğini gösterir. [S22]

Benchmark'ta örneğin simple fact retrieval'da basic RAG bazı GraphRAG varyantlarını geçerken, bazı complex reasoning/contextual summarization task'larında graph approaches avantaj sağlayabilmektedir. [S22]

### 20.3. SOUL açısından sonuç

Bu evidence `00-WHY-THIS-RESEARCH.md` içindeki H2 hipotezini güçlendirir:

> **Doğru sonuç tek mekanizma seçmek değil, task/query class'a göre mekanizma seçmek olabilir.**

Knowledge Graph'ın existence'ı every-query graph traversal zorunluluğu anlamına gelmemelidir.

---

## 21. GraphRAG'ın kendi failure mode'ları

GraphRAG, vanilla RAG'ın bazı failure'larını çözmeye çalışırken yeni failure surfaces üretir:

### 21.1. Extraction hallucination

LLM yanlış entity veya relation çıkarabilir.

### 21.2. Entity duplication / collapse

Aynı entity split veya farklı entity merge olabilir.

### 21.3. False relation

Source'ta zayıf/implicit association explicit strong edge'e dönüşebilir.

### 21.4. Community distortion

Community detection topological proximity'yi meaningful semantic unit sanabilir.

### 21.5. Summary loss

Community summary source qualifier, exception veya exact value kaybedebilir.

### 21.6. Stale graph

Source değişirken graph, summary ve embeddings güncellenmezse derived representation stale kalabilir.

### 21.7. Cost explosion

Graph extraction, summarization, storage ve rebuild maliyeti baseline RAG'dan çok daha yüksek olabilir. Microsoft docs bu indexing yükünü açıkça uyarır. [S24]

### 21.8. Wrong task routing

Simple exact lookup için graph pipeline pure overhead olabilir; current benchmark evidence bunu destekler. [S22][S26]

---

## 22. Evolution ve maintenance: graph bir kez kurulup bitmez

Real-world graph'lar dynamic'tir.

KG evolution literature static, dynamic, temporal ve event KG ayrımlarını ele alır; incremental update ve versioning ayrı araştırma problemidir. [S17][S27]

Lifecycle:

```text
source change
 → entity/relation re-extraction
 → identity reconciliation
 → edge update/delete
 → temporal validity change
 → inferred-edge invalidation
 → community/index rebuild
 → downstream cache invalidation
 → verification refresh
```

Bu closure kurulmazsa graph “structured stale memory”ye dönüşür.

Development OS açısından bu çok önemlidir: repo commit değişikliği yalnız source text'i değil, graph'taki derived node/edge ve downstream summaries'i de invalidate edebilir.

---

## 23. Access control ve authority

Graph structure fine-grained access problemine yeni boyut getirir. Bir node gizli olsa bile:

- edge existence,
- path existence,
- aggregate count,
- neighbor expansion,
- inferred relation

gizli bilgi sızdırabilir.

Graph-structured data için access-control literature bu nedenle graph topology ve path-level policy'leri ayrı problem olarak ele alır. [S28]

SOUL açısından least-privilege şu sorulara dönüşebilir:

- Actor node'u görebilir ama edge'i görebilir mi?
- Relation metadata'nın tamamını görebilir mi?
- Traversal hidden node üzerinden geçebilir mi?
- Derived/inferred relation permission inheritance nasıl çalışır?
- GraphRAG context construction access policy'yi koruyor mu?

Bu nedenle KG authority representation için yararlı olabilirken, access-control implementation'ını otomatik kolaylaştırmaz.

---

## 24. SOUL açısından değerlendirme

## 24.1. SOUL için güçlü aday kullanım sınıfları

SOUL'un intended outcome'a göre task-specific controlled working system oluşturma hedefi düşünüldüğünde KG şu capability türlerinde değerli olabilir:

### A. Working-system dependency model

```text
Work → requires → Capability
Capability → provided_by → Tool/Actor
Tool → available_in → Environment
```

### B. Authority model

```text
Actor → authorised_for → Work
Decision → owned_by → Actor
Action → requires_authority → Role
```

### C. Evidence/provenance model

```text
Claim → supported_by → Evidence
Evidence → derived_from → Source
Source → supersedes → Source
```

### D. Change-impact model

```text
Source changed
 → affects Evidence
 → affects Decision
 → affects Work
```

### E. Multi-hop domain knowledge

Task-specific system bazı domain'lerde relation-heavy professional knowledge kullanabilir.

Bu örnekler **candidate problem mappings**'dir, final SOUL data model değildir.

## 24.2. KG'nin SOUL generality'sine uygun olma koşulu

SOUL her task için KG kurarsa KG yeni fixed default olur.

Daha uygun decision frame:

1. Task relation-heavy mi?
2. Hangi query'ler traversal/multi-hop gerektiriyor?
3. Relations source'dan güvenilir şekilde çıkarılabilir mi?
4. Identity stabil mi?
5. Schema yeterince biliniyor mu?
6. Temporal/provenance requirements nedir?
7. Graph lifecycle cost'u value'yu aşıyor mu?
8. Flat RAG / relational / direct source / long context daha basit çözüm mü?
9. Graph'tan gelen relation yanlışsa downstream harm nedir?
10. Graph'ın doğruluğunu test edecek oracle var mı?

SOUL için **graph capability formation**, graph default'tan daha uyumlu görünmektedir.

---

## 25. Development OS açısından değerlendirme

## 25.1. Current repository için graph'ın en güçlü olası rolü: derived relation index

Mevcut Development OS / SOUL Research modelinde repository source-of-truth'tur.

Bu nedenle ilk-principles project synthesis şu yöndedir:

> **Eğer graph kullanılırsa, ilk aday rol canonical source'un yerine geçmek değil; canonical source'a exact provenance ile bağlı derived relation/index layer olmaktır.**

Örneğin:

```text
Node: WP-021
source: development/04_work/WP-021...
sha: abc123
status: historical/current/accepted/etc.

WP-021 ─reviewed_by→ WP-022
```

Graph edge'in source pointer'ı yoksa current repository authority modeline uyumu zayıflar.

## 25.2. Development OS'de graph'ın değer üretebileceği sorular

- Bu decision hangi evidence'lara dayanıyor?
- Bu evidence hangi source SHA'lardan geliyor?
- Bu finding'i kullanan hangi downstream work var?
- Bu file superseded olursa hangi current surface'ler etkilenebilir?
- Bu Actor'ın hangi work üzerinde authority'si var?
- Hangi verification verdict'i hangi exact target'a ait?
- Aynı failure class daha önce nerede görüldü?
- Bir dependency closure'da hangi node eksik?

Bunlar relation-heavy query'lerdir.

## 25.3. Graph'ın kullanılmaması gereken Development OS query'leri

Örneğin:

> “Current authorization tam olarak ne?”

sorusunda current `STATE.md` doğrudan okumak, derived graph'tan cevap almaktan daha güvenilir olabilir.

Benzer şekilde:

- exact wording,
- current SHA,
- current source content,
- authoritative policy text

gibi durumlarda source recovery graph traversal'dan daha güçlü oracle'dır.

Bu nedenle candidate retrieval stack:

```text
exact/current authority → direct canonical source
relation/impact query   → graph-assisted retrieval
semantic similarity     → text/vector retrieval
global synthesis        → GraphRAG or broader context
```

şeklinde düşünülebilir; **bu architecture kararı değil, araştırmadan çıkan decision frame'dir.**

## 25.4. Source–graph fidelity zorunluluğu

Graph'taki her load-bearing entity/relation için mümkünse:

- exact source pointer,
- repo/ref/SHA,
- extraction method,
- epistemic status,
- valid time,
- last verified time

gibi metadata tutulmalıdır.

Aksi halde graph canonical repository'nin authority modelini degrade edebilir.

---

## 26. Knowledge Graph + diğer dört strateji

### 26.1. Knowledge Graph + RAG

En doğal kompozisyon GraphRAG'dır.

**Güçlü olabilir:**
- multi-hop,
- relation-heavy retrieval,
- global corpus synthesis,
- dependency/path questions.

**Gereksiz olabilir:**
- simple fact lookup,
- exact file/path lookup,
- high-churn corpus'ta graph rebuild maliyeti yüksekse.

GraphRAG-Bench evidence task-dependent selection'ı destekler. [S22]

### 26.2. Knowledge Graph + Fine-Tuning

İki yön mümkündür:

- Fine-tuned extractor/entity linker graph construction'ı geliştirebilir.
- KG structured supervision/training data sağlayabilir.

Ancak dynamic graph knowledge'ı model weights'e gömmek update/provenance avantajını azaltabilir.

Fine-Tuning dosyası bu boundary'yi ayrıca araştırmalıdır.

### 26.3. Knowledge Graph + CAG

Stable graph schema, frequently used ontology veya stable subgraph summaries cache edilebilir.

Risk:
- source/edge değişirken cache invalidation yapılmazsa stale structured context oluşur.

### 26.4. Knowledge Graph + Long Context

Graph, long context'e hangi source/subgraph'ın gireceğini organize edebilir; raw source context ise graph extraction sırasında kaybolan qualifier'ları geri kazandırabilir.

Potansiyel hybrid:

```text
graph → relation-aware selection
raw source → long context evidence
LLM → synthesis
```

Bu, graph'ı source replacement yerine navigation layer yapabilir.

---

## 27. Operational trade-off

| Boyut | Knowledge Graph etkisi |
|---|---|
| Query expressiveness | relation/traversal-heavy query'lerde yüksek değer |
| Construction cost | medium → very high; extraction/fusion/schema'ya bağlı |
| Update cost | dynamic graph'ta sürekli lifecycle yükü |
| Storage | node/edge + metadata + indexes + derived artifacts |
| Latency | direct traversal hızlı olabilir; GraphRAG pipeline pahalı olabilir |
| Observability | explicit relations inspectable olabilir |
| Error propagation | yanlış edge/path downstream reasoning'i geniş ölçekte etkileyebilir |
| Provenance | iyi modellenirse güçlü; otomatik değil |
| Temporal correctness | explicit modeling gerektirir |
| Completeness | doğal olarak garanti edilmez |
| Interoperability | RDF/standards stack'te güçlü olabilir |
| Schema flexibility | schema-light kolay; semantic drift riski |
| Formal validation | SHACL/ontology/rules ile mümkün; truth oracle değildir |
| Access control | fine-grained olabilir fakat graph topology nedeniyle karmaşık |
| Vendor dependency | seçilen graph model/query engine'e bağlı |

---

## 28. Decision boundary

### Use when

Knowledge Graph güçlü adaydır eğer:

- relation semantics task'ın ana bilgisiyse,
- multi-hop/path/dependency query'ler sık ve yük taşıyorsa,
- source/provenance/authority links explicit tutulmalıysa,
- heterogeneous sources entity-level integration gerektiriyorsa,
- change impact / lineage / dependency closure sorgulanacaksa,
- graph construction/maintenance doğrulanabilir ve ekonomikse,
- identity ve relation vocabulary yeterince stabilse.

### Avoid as default when

Knowledge Graph zayıf/default-olmaması gereken adaydır eğer:

- workload çoğunlukla simple exact lookup ise,
- relation traversal düşük değerdeyse,
- data primarily numeric/time-series/tabular ise,
- entity identity belirsiz ve rapidly shifting ise,
- schema henüz araştırma aşamasındaysa,
- extraction oracle yoksa,
- graph'ın güncellenmesi source'tan daha yavaş olacaksa,
- graph kurmak yalnız “AI architecture modern görünsün” diye öneriliyorsa.

### Needs evidence before architecture decision

1. Gerçek query mix nedir?
2. Relation-heavy query oranı nedir?
3. Hangi relation types load-bearing?
4. Identity keys neler?
5. Schema stability ne düzeyde?
6. Source churn/update rate nedir?
7. Required provenance granularity nedir?
8. Temporal validity gereksinimi nedir?
9. Completeness hangi Work sınıflarında kritik?
10. Graph extraction precision/recall hedefleri nedir?
11. False edge ve missing edge'in downstream cost'u nedir?
12. Access-control modeli nedir?
13. Graph construction/rebuild cost'u nedir?
14. RAG/relational/direct-source baseline'a karşı measurable value var mı?

### Does not prove

Bu araştırma şunları kanıtlamaz:

- SOUL Knowledge Graph kullanmalıdır.
- Development OS graph database'e taşınmalıdır.
- RDF veya property graph seçilmelidir.
- Ontology kurulmalıdır.
- Current SOUL Foundations hierarchy final ontology'dir.
- Actor/Work/Environment/Information doğrudan graph node class'larıdır.
- GraphRAG vanilla RAG'dan daha iyidir.
- Graph relations doğruysa downstream reasoning otomatik doğrudur.

---

## 29. Bulgular

### F-KG-01 — Knowledge Graph tek bir teknoloji değil, relation-centric representation ailesidir

**Confidence:** high  
**Basis:** Hogan, Ji, automatic KGC surveys + RDF/property-graph literature. [S1][S2][S3][S4]

Graph database, RDF, ontology ve GraphRAG ayrı katmanlardır.

### F-KG-02 — Graph'ın değeri relation density'den çok relation usefulness + query workload'a bağlıdır

**Confidence:** high  
**Basis:** graph data-model comparisons + GraphRAG evaluation. [S4][S22][S26]

Çok relation bulunması tek başına graph gerektirmez; task'ın bu relations üzerinde traversal/synthesis yapması gerekir.

### F-KG-03 — Formal graph structure false certainty üretebilir

**Confidence:** high as synthesis  
**Basis:** KGC extraction/fusion/quality literature. [S3][S5][S10][S20]

Yanlış extracted edge, natural-language ambiguity'yi “structured fact” görünümüne sokabilir.

### F-KG-04 — Entity identity KG correctness'ın yük taşıyan önkoşuludur

**Confidence:** high  
**Basis:** entity-alignment literature. [S13]

False split ve false merge tüm downstream relation/query sonuçlarını bozabilir.

### F-KG-05 — Provenance ve temporal validity SOUL/Development OS use case'lerinde optional metadata olmayabilir

**Confidence:** high as project-system inference  
**Basis:** provenance standards/surveys + temporal KG literature + repo authority model. [S9][S15][S16][S17]

Current authority veya supersession taşıyan edge zaman/source bağlamı olmadan tehlikelidir.

### F-KG-06 — Graph absence, source/world absence değildir

**Confidence:** high  
**Basis:** OWL/open-world + completeness research. [S7][S19][S21]

Bu RAG'daki retrieval-miss ayrımının graph eşdeğeridir.

### F-KG-07 — Predicted/inferred edge source-observed fact ile aynı epistemic statüde tutulmamalıdır

**Confidence:** high  
**Basis:** KG completion/reasoning literature + project governance requirements. [S2]

Completion suggestion olabilir; authority fact'i olmamalıdır.

### F-KG-08 — GraphRAG universal RAG upgrade değildir

**Confidence:** high  
**Basis:** original GraphRAG + 2025/2026 comparative evaluations. [S22][S25][S26]

Graph advantage task/query class'a bağlıdır; simple retrieval'da overhead/failure artabilir.

### F-KG-09 — Development OS için en güvenli ilk rol derived relation index'tir, canonical truth replacement değil

**Confidence:** high as project-specific inference  
**Basis:** repository-authoritative Development OS + KG provenance/fidelity findings.

Bu architecture decision değildir; sonraki design için decision boundary'dir.

### F-KG-10 — Current SOUL Foundations hierarchy'yi ontology/schema olarak yorumlamak desteklenmiyor

**Confidence:** high  
**Basis:** current `research/soul-foundations/STATE.md` explicit boundary.

Research hierarchy ile operational data model ayrımı korunmalıdır.

### F-KG-11 — KG verification stage-specific olmalıdır

**Confidence:** high  
**Basis:** quality, SHACL, GraphRAG benchmark evidence. [S8][S20][S21][S22]

Node/edge count veya schema conformance alone truth verification değildir.

### F-KG-12 — Schema governance continuous lifecycle problemidir

**Confidence:** high  
**Basis:** schema-adaptable KGC + LLM KGC survey + evolution literature. [S5][S12][S27]

Schema bir kez tasarlanıp kapanan artefakt değildir.

### F-KG-13 — SOUL için graph capability koşullu formation'a, universal graph ontology'den daha uyumludur

**Confidence:** medium-high as project synthesis  
**Basis:** SOUL general-purpose task-specific system formation + task-dependent graph evidence.

---

## 30. Açık sorular — architecture öncesi gerekli bilgi

Bu araştırma aşağıdaki project-specific soruları çözmez:

1. SOUL runtime'da hangi relation-heavy knowledge sınıflarına gerçekten ihtiyaç duyacak?
2. Actor/Work/Environment/Information arasındaki relation vocabulary ne zaman yeterince araştırılmış olacak?
3. Hangi relation'lar canonical fact, hangileri derived view olacak?
4. Current repository için stable entity identity nasıl tanımlanmalı?
5. Source-level provenance granularity edge-level mi statement-level mı olmalı?
6. Temporal validity hangi node/edge sınıflarında zorunlu?
7. Negative facts ve unknown state nasıl temsil edilmeli?
8. Graph completeness hangi Work class'larında ölçülmeli?
9. Automatic extraction için kabul edilebilir precision/recall nedir?
10. False merge / false split cost'u nedir?
11. RDF vs property graph vs relational + relation index hangi workload'da daha uygun?
12. GraphRAG hangi query class'larda measurable value sağlıyor?
13. Current Dev OS corpus üzerinde graph-assisted retrieval baseline RAG/direct routing'i gerçekten geçiyor mu?
14. Graph update/invalidation repository commit lifecycle'a nasıl bağlanmalı?
15. Access-control graph traversal'a nasıl uygulanmalı?
16. Predicted/inferred links hangi epistemic status ve approval gate ile kullanılabilir?
17. Graph derived views fresh-session cold-start'a nasıl dahil edilmeli?

Bunlar architecture/design veya sonraki ilgili research aşamalarında çözülmelidir.

---

## 31. Araştırma yöntemi ve sınırlar

Bu çalışma:

- foundational KG surveys,
- graph data model / Semantic Web standards,
- automatic KG construction literature,
- schema adaptation,
- entity alignment ve relation extraction,
- KG quality/completeness,
- provenance ve temporal KG,
- LLM-assisted KG construction,
- GraphRAG original work ve current implementation docs,
- 2025–2026 RAG vs GraphRAG comparative evaluation,
- graph access-control literature

üzerinden cross-source synthesis yapmıştır.

### Bilinçli sınırlar

- Belirli bir graph database vendor benchmark edilmemiştir.
- SOUL corpus üzerinde KG extraction çalıştırılmamıştır.
- RDF/property graph performance benchmark'ı yapılmamıştır.
- Ontology tasarlanmamıştır.
- Current SOUL Foundations tree graph schema'ya dönüştürülmemiştir.
- GraphRAG benchmark sonuçları dataset/task-specific evidence olarak tutulmuş, universal dominance iddiasına çevrilmemiştir.
- SHACL conformance semantic truth doğrulaması sayılmamıştır.
- LLM self-generated graph bağımsız verification sayılmamıştır.
- KG completion predictions fact olarak kabul edilmemiştir.
- 2026'daki draft/candidate W3C specs final Recommendation gibi sunulmamıştır.

### Stopping rationale

Araştırma boundedly closed kabul edilmiştir çünkü farklı kaynak hatları aynı yük taşıyan ayrımlarda yakınsamıştır:

- KG ≠ graph database/ontology,
- relation-centric value task-dependent,
- entity identity ve relation extraction critical,
- provenance/time/completeness lifecycle'ın parçası,
- graph quality structural metrics'e indirgenemez,
- inferred/predicted knowledge observed fact değildir,
- GraphRAG value query class'a bağlıdır,
- SOUL/Development OS için graph ancak source authority ve provenance closure'ıyla anlamlıdır.

Yeni kaynaklar ayrıntı ekleyebilir; ancak bu package'ın **SOUL / Development OS relevance ve decision-boundary** hedefi için ana sonuçları değiştirme olasılığı düşmüştür.

---

## 32. Source ledger

### Foundational definitions / representation

**[S1] Hogan, A. et al. (2021). _Knowledge Graphs_. ACM Computing Surveys 54(4), Article 71.**  
DOI: 10.1145/3447772  
https://arxiv.org/abs/2003.02320  
Use: KG definition controversy; graph data models; schema, identity, context; creation/quality overview.  
Limit: broad survey; no SOUL-specific architecture implication.

**[S2] Ji, S. et al. (2022). _A Survey on Knowledge Graphs: Representation, Acquisition, and Applications_. IEEE TNNLS 33(2):494–514.**  
DOI: 10.1109/TNNLS.2021.3070843  
https://arxiv.org/abs/2002.00388  
Use: entities/relations/semantic descriptions; representation, acquisition, completion, temporal KG.  
Limit: field survey; technology landscape has evolved since publication.

**[S3] Zhong, L. et al. (2023). _A Comprehensive Survey on Automatic Knowledge Graph Construction_. ACM Computing Surveys 56(4), Article 94.**  
DOI: 10.1145/3618295  
https://arxiv.org/abs/2302.05019  
Use: acquisition/refinement/evolution; construction complexity and definition variants.

**[S4] Stanford CS520. _What are Graph Data Models?_**  
https://web.stanford.edu/class/cs520/2020/notes/What_Are_Graph_Data_Models.html  
Use: RDF/property graph/relational comparison; traversal advantages; limitations for time-series and higher-arity relations.  
Limit: course material, not empirical universal benchmark.

### LLM-assisted construction / schema

**[S5] Bian, H. (2025). _LLM-empowered knowledge graph construction: A survey_.**  
https://arxiv.org/abs/2510.20345  
Use: ontology engineering → extraction → fusion; schema-based vs schema-free; cumulative error/evolution challenges.  
Limit: recent arXiv survey; not architecture authority.

**[S12] Ye, H. et al. (2023). _Schema-adaptable Knowledge Graph Construction_. Findings of EMNLP 2023.**  
https://aclanthology.org/2023.findings-emnlp.425/  
DOI: 10.18653/v1/2023.findings-emnlp.425  
Use: static-schema limitations and evolving schema problem.

**[S23] Zhu, Y. et al. (2023/2024). _LLMs for Knowledge Graph Construction and Reasoning: Recent Capabilities and Future Opportunities_.**  
https://arxiv.org/abs/2305.13168  
Use: empirical distinction between LLM KG construction and reasoning capabilities.  
Limit: evaluated models/datasets are period-specific.

### Standards / semantics / validation / provenance

**[S6] W3C. _RDF 1.2 Concepts and Abstract Data Model_. Candidate Recommendation Snapshot, 7 Apr 2026.**  
https://www.w3.org/TR/rdf12-concepts/  
Use: current RDF graph/dataset model; RDF 1.2 status and triple-term evolution.  
Limit: Candidate Recommendation, not final Recommendation as of research date.

**[S7] W3C. _OWL 2 Web Ontology Language Primer (Second Edition)_.**  
https://www.w3.org/TR/owl2-primer/  
Use: ontology semantics and open-world vs database closed-world distinction.

**[S8] W3C. _Shapes Constraint Language (SHACL)_. Recommendation, 20 Jul 2017.**  
https://www.w3.org/TR/shacl/  
Use: RDF graph constraint/validation model.  
Limit: validates declared conditions, not external factual truth.

**[S9] W3C. _PROV-O: The PROV Ontology_. Recommendation.**  
https://www.w3.org/TR/prov-o/  
Use: provenance representation vocabulary.

### Entity/relation construction

**[S13] Zeng, K. et al. (2021). _A comprehensive survey of entity alignment for knowledge graphs_. AI Open 2:1–13.**  
DOI: 10.1016/j.aiopen.2021.02.002  
Use: entity alignment as fundamental multi-source KG fusion problem.

**[S14] Zhao, X. et al. (2023). _A Comprehensive Survey on Relation Extraction: Recent Advances and New Frontiers_.**  
https://arxiv.org/abs/2306.02051  
Use: relation extraction/task complexity and failure surfaces.

### Provenance / time / evolution / completeness

**[S15] Sikos, L.F., Philp, D. (2020). _Provenance-Aware Knowledge Representation: A Survey of Data Models and Contextualized Knowledge Graphs_. Data Science and Engineering 5:293–316.**  
https://link.springer.com/article/10.1007/s41019-020-00118-0  
Use: statement provenance representation trade-offs.

**[S16] Kleinsteuber, E. et al. (2024). _Managing Provenance Data in Knowledge Graph Management Platforms_. Datenbank-Spektrum 24:43–52.**  
https://link.springer.com/article/10.1007/s13222-023-00463-0  
Use: practical provenance management in KG platforms.

**[S17] Cai, B. et al. (2023). _Temporal Knowledge Graph Completion: A Survey_. IJCAI 2023, 6545–6553.**  
DOI: 10.24963/ijcai.2023/734  
https://www.ijcai.org/proceedings/2023/734  
Use: temporal validity of changing facts.

**[S18] Cai, L. et al. (2024). _A Survey on Temporal Knowledge Graph: Representation Learning and Applications_.**  
https://arxiv.org/abs/2403.04782  
Use: static vs temporal KG and dynamics.

**[S19] Razniewski, S. et al. (2024). _Completeness, Recall, and Negation in Open-world Knowledge Bases: A Survey_. ACM Computing Surveys 56(6).**  
DOI: 10.1145/3639563  
https://arxiv.org/abs/2305.05403  
Use: incomplete KGs; open-world absence; completeness/negation.

**[S27] Jiang, X. et al. (2023). _On the Evolution of Knowledge Graphs: A Survey and Perspective_.**  
https://arxiv.org/abs/2310.04835  
Use: static/dynamic/temporal/event KG evolution and maintenance.

### Quality

**[S20] Wang et al. (2021). _Knowledge graph quality control: A survey_. Fundamental Research 1(5):607–626.**  
DOI: 10.1016/j.fmre.2021.09.003  
Use: KG quality dimensions and construction-quality dependence.

**[S21] Issa, S. et al. (2021). _Knowledge Graph Completeness: A Systematic Literature Review_. IEEE Access 9:31322–31339.**  
DOI: 10.1109/ACCESS.2021.3056622  
Use: completeness as multi-dimensional quality problem.

### GraphRAG

**[S22] Xiang, Z. et al. (2025; v3 22 Feb 2026). _When to use Graphs in RAG: A Comprehensive Analysis for Graph Retrieval-Augmented Generation_.**  
https://arxiv.org/abs/2506.05690  
Use: GraphRAG-Bench; task-dependent graph value; stage-specific evaluation; GraphRAG can underperform vanilla RAG.  
Limit: benchmark/corpora specific; not universal production result.

**[S24] Microsoft GraphRAG Documentation. Current read 2026-09-03.**  
https://microsoft.github.io/graphrag/  
https://microsoft.github.io/graphrag/index/methods/  
Use: current standard/fast indexing pipelines; entity/relationship extraction; cost/fidelity trade-off.  
Limit: implementation documentation from project authors.

**[S25] Edge, D. et al. (2024). _From Local to Global: A Graph RAG Approach to Query-Focused Summarization_.**  
https://arxiv.org/abs/2404.16130  
Use: original Microsoft GraphRAG global-query motivation/evidence.  
Limit: global sensemaking task class; LLM-judge style evaluation; not universal RAG comparison.

**[S26] Han, H. et al. (2025; v3 4 Mar 2026). _RAG vs. GraphRAG: A Systematic Evaluation and Key Insights_.**  
https://arxiv.org/abs/2502.11371  
Use: standardized comparison; distinct strengths/efficiency trade-offs; integration/selection strategy.  
Limit: benchmark-specific; not final architecture rule.

### KG + LLM reliability / security

**[S28] Mohamed, A. et al. (2024). _Comparison of Access Control Approaches for Graph-Structured Data_.**  
https://arxiv.org/abs/2405.20762  
Use: graph-structured fine-grained access-control complexity.

**[S29] Agrawal, G. et al. (2024). _Can Knowledge Graphs Reduce Hallucinations in LLMs? A Survey_. NAACL 2024.**  
https://aclanthology.org/2024.naacl-long.219/  
DOI: 10.18653/v1/2024.naacl-long.219  
Use: KG augmentation as promising but unresolved hallucination-mitigation area.  
Limit: survey; “can help” does not mean hallucination elimination.

---

## 33. Current handoff

**Completed:** `02-KNOWLEDGE-GRAPH.md` bounded deep research.  
**Result:** Knowledge Graph is a high-relevance relation-centric representation/capability family, not a graph-database mandate, ontology mandate or universal knowledge architecture.  
**Key project-specific finding:** for SOUL/Development OS, graph value is strongest where typed relations, provenance, temporal validity, authority/dependency and impact traversal are load-bearing; however a graph should not silently replace canonical source truth, and current SOUL Foundations hierarchy must not be promoted to ontology/schema.  
**Verification:** cross-source synthesis only; no local KG extraction/query benchmark / independent verification.  
**Architecture decision:** none.  
**Foundation-tree effect:** none. Current Foundation sequencing remains independently governed by `research/soul-foundations/STATE.md`.  
**Next planned file:** `03-FINE-TUNING.md`.  
**Next action:** stop here; do not start Fine-Tuning deep research in this turn.
