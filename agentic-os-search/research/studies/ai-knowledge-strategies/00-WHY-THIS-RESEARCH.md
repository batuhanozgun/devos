# AI Knowledge Strategies — Neden Bu Araştırmayı Yapıyoruz?

**Status:** research rationale / package entry surface  
**Date:** 2026-09-03  
**Scope:** RAG, Knowledge Graph, Fine-Tuning, Cache-Augmented Generation (CAG), Long Context  
**Architecture status:** no architecture decision; no implementation decision  
**Relation to SOUL Foundations:** separate research package; does not modify or extend the current foundation hierarchy  
**Current package state:** file 0 complete; files 1–5 not yet researched in this package

---

## 1. Bu araştırma neden açıldı?

Bu araştırma, aşağıdaki popüler sınıflandırmanın SOUL ve Development OS açısından gerçekten ne ifade ettiğini anlamak için açıldı:

1. Large External Knowledge → RAG
2. Connected Knowledge → Knowledge Graph
3. Change Model Behavior → Fine-Tuning
4. Repeated Stable Context → CAG
5. Single Large Context → Long Context

Bu liste ilk bakışta pratik bir mimari seçim rehberi gibi görünmektedir. Ancak ilk kontrol, beş başlığın aynı sistem katmanında bulunan ve birbirini dışlayan beş alternatif olmadığını göstermektedir.

Örneğin:

- RAG ağırlıklı olarak **hangi bilginin ihtiyaç anında getirileceği** problemiyle ilgilenir.
- Knowledge Graph ağırlıklı olarak **bilginin hangi yapıda ve hangi ilişkilerle temsil edileceği** problemiyle ilgilenir.
- Fine-Tuning, dış bilgiyi nasıl getireceğimizden çok **modelin parametrelerini ve davranış eğilimlerini nasıl adapte edeceğimiz** problemiyle ilgilenir.
- CAG, tekrar kullanılan ve yönetilebilir büyüklükteki bağlamın **önceden yüklenmesi / cache edilmesi** üzerinden retrieval ihtiyacını azaltmayı hedefler.
- Long Context ise bir görev sırasında büyük miktarda bağlamın **doğrudan model context'inde tutulması ve kullanılabilmesi** problemidir.

Bu nedenle araştırmanın başlangıç varsayımı şu değildir:

> “SOUL bu beş seçenekten hangisini seçmeli?”

Daha doğru başlangıç sorusu şudur:

> **SOUL veya Development OS hangi bilgi, bağlam, davranış, ilişki ve çalışma koşullarında bu mekanizmaların hangisine ihtiyaç duyar; bu mekanizmalar birbirleriyle nasıl birleşebilir; hangi failure mode'ları üretir; hangi durumda kullanılmamalıdır?**

Bu dosyanın görevi bu sorunun neden araştırmaya değer olduğunu sabitlemek ve sonraki beş araştırma dosyasının ortak çerçevesini belirlemektir. Beş mekanizmanın teknik derin araştırması bu dosyada yapılmaz.

---

## 2. Neden doğrudan Instagram sınıflandırmasını kabul etmiyoruz?

Sınıflandırma yararlı bir keşif tetikleyicisidir, fakat bir mimari taxonomy olarak doğrudan kabul edilmemelidir.

Bunun üç temel nedeni vardır.

### 2.1. Aynı seviyedeki kategoriler değiller

RAG ve Long Context çoğunlukla bilgiye erişim / context sağlama yollarıdır. Knowledge Graph bir representation yapısıdır. Fine-Tuning model adaptation katmanına müdahale eder. CAG ise context'i runtime'a hazırlama ve yeniden kullanım yaklaşımıdır.

Dolayısıyla bunları beş rakip ürün seçeneği gibi ele almak category error üretebilir.

### 2.2. Birlikte kullanılabilirler

Microsoft GraphRAG açıkça knowledge graph üretimini RAG süreciyle birleştirir; yani Knowledge Graph ile RAG zaten aynı sistem içinde kompozisyon halinde kullanılabilir.

RAG ve Long Context üzerine yapılan karşılaştırmalı çalışmalar da bunları mutlak rakipler olarak değil, farklı maliyet / performans koşullarında birleştirilebilecek yaklaşımlar olarak ele almıştır. Li ve arkadaşlarının 2024 çalışması, RAG ile Long Context arasında yönlendirme yapan hibrit yaklaşımı ayrıca test etmiştir.

CAG çalışması da RAG'ı evrensel olarak reddetmez; sınırlı ve yönetilebilir knowledge base durumlarında retrieval'ı devreden çıkarmanın avantajlı olabileceğini savunur.

### 2.3. Liste eksiksiz bir “knowledge architecture” değildir

Bu beş mekanizma önemli olsa da aşağıdaki soruların tamamını kendi başlarına çözmez:

- Hangi kaynak authoritative?
- Bilgi ne zaman üretildi?
- Bilginin provenance'ı nedir?
- Bilgi hangi Work veya karar için geçerlidir?
- Bilgi stale olduğunda sistem bunu nasıl fark eder?
- Hangi Actor bu bilgiye erişebilir veya onu değiştirebilir?
- Retrieval sonucu kaynağı doğru temsil ediyor mu?
- Bir modelin kullandığı bilgi doğrulanabilir mi?
- Bilgi yanlışsa hangi kararların yeniden değerlendirilmesi gerekir?

Bu nedenle beş mekanizmayı araştırırken daha geniş bir **knowledge governance** problemi sürekli arka planda tutulacaktır. Ancak knowledge governance bu pakette altıncı bağımsız teknik araştırma dosyasına dönüştürülmeyecektir; beş araştırmanın hepsine uygulanan çapraz değerlendirme lensi olacaktır.

---

## 3. SOUL açısından neden önemli?

SOUL'un current explicit direction'ı, intended outcome'u alıp o outcome için gereken controlled, verifiable working system'i oluşturabilen general-purpose agentic architecture yönüdür. SOUL'un kendi README'si ayrıca development state'in chat history veya model memory yerine repository'de authoritative tutulmasını açıkça belirtir.

Bu hedef, “modelin daha fazla bilgi bilmesi” probleminden daha geniştir.

Bir task-specific working system farklı görevlerde şunlara ihtiyaç duyabilir:

- büyük bir harici bilgi havuzundan seçici retrieval,
- Actors, Work, Information ve Environment arasındaki ilişkilerin takibi,
- belirli bir uzman davranış veya capability'nin modele adapte edilmesi,
- tekrar tekrar kullanılan sabit kuralların düşük maliyetle hazır tutulması,
- tek bir büyük çalışma paketinin bütün halinde değerlendirilmesi,
- kaynakların ve kararların provenance'ının korunması,
- güncellik ve stale-state kontrolü,
- farklı bilgi yolları arasında seçim yapabilme,
- yanlış veya yetersiz bilgi akışında fail-visible davranış,
- doğrulanabilir ve değiştirilebilir çalışma sistemi.

Bu nedenle beş başlığın her biri SOUL için olası bir capability veya infrastructure mekanizmasına dokunmaktadır.

Fakat SOUL açısından asıl araştırma sorusu mekanizmanın varlığı değildir. Asıl soru şudur:

> **SOUL hangi problem koşullarında hangi mekanizmanın gerekli olduğunu nasıl belirleyecek ve bu seçimin doğru olduğunu nasıl sınayacak?**

Bu soru SOUL'un generality hedefi açısından kritiktir. Eğer SOUL her göreve aynı retrieval, aynı graph yapısı, aynı long-context stratejisi veya aynı fine-tuned model yaklaşımını zorunlu tutarsa, “task-specific working system oluşturma” hedefinden uzaklaşıp sabit bir workflow/template sistemine dönüşme riski doğar.

Dolayısıyla araştırmanın SOUL açısından temel amacı bir teknoloji seçmek değil, **mekanizma-seçim sınırlarını anlamaktır.**

---

## 4. Development OS açısından neden önemli?

SOUL Development Operating System'in birincil amacı, SOUL geliştirmesini chat memory, session length ve tek model self-assessment'ından bağımsız hale getirmektir. Development OS README'si yeni bir oturumun repository state'inden cold-start yapabilmesini, bounded responsibility yürütebilmesini, evidence bırakabilmesini ve önceki konuşmaya ihtiyaç duymadan handoff yapabilmesini hedefler.

Bu amaç doğrudan bilgi ve bağlam mimarisi problemine dönüşür.

Development OS sürekli olarak şu sorularla karşılaşır:

- Yeni session'a hangi dosyalar yüklenmeli?
- Hangi bilgi retrieval ile bulunmalı?
- Hangi kurallar her seferinde hazır bulunmalı?
- Büyük bir evidence package doğrudan context'e mi yüklenmeli, yoksa parçalı mı getirilmelidir?
- Bir relation veya dependency dosya metniyle mi, yapısal graph olarak mı tutulmalıdır?
- Davranış kuralları explicit control files içinde mi kalmalı, yoksa model adaptation'a mı gömülmelidir?
- Context ne zaman stale sayılmalıdır?
- Retrieval miss “kaynakta yok” anlamına gelmemeliyse sistem bunu nasıl koruyacaktır?
- Aynı sabit kuralları sürekli yeniden işlemek yerine caching kullanmak mantıklı mıdır?
- Long Context kullanıldığında modelin gerçekten bütün bağlamı etkin kullandığı nasıl doğrulanacaktır?

Mevcut `agentic-os-search` repository'sinde kullanılan progressive retrieval deseni zaten bu problem uzayının pratik bir örneğidir:

`STATE → INDEX → ilgili package/router → KEY/synthesis → finding → gerekirse source recovery`

Bu yapı “her şeyi her seferinde modele yükleme” yaklaşımını bilinçli olarak kullanmaz. Aynı zamanda retrieval sonucunu source-of-truth saymaz; load-bearing iddialarda daha derin source recovery gerekebilir.

Dolayısıyla RAG, CAG ve Long Context doğrudan Development OS'nin **cold-start context formation** problemine; Knowledge Graph repository'deki **relation/dependency/provenance** problemine; Fine-Tuning ise explicit governance ile parametric behavior arasındaki sınıra temas eder.

Bu nedenle beş araştırmanın Development OS için pratik değeri yüksektir.

---

## 5. Beş olguyu neden ayrı ayrı araştırıyoruz?

### 5.1. RAG — Retrieval-Augmented Generation

RAG'ın temel araştırma değeri, büyük veya dinamik dış bilgi alanından her görev için yalnız gerekli parçaların nasıl seçilip getirileceğini anlamaktır.

Lewis ve arkadaşlarının orijinal RAG çalışması, parametric model memory ile explicit non-parametric memory'yi birleştirme problemini ortaya koymuş; world knowledge güncelleme ve provenance gibi problemlerin parametric-only yaklaşımda açık kaldığını vurgulamıştır.

SOUL/Development OS açısından araştırılması gereken ana soru:

> Büyük, değişken ve source-sensitive bilgi alanında retrieval ne zaman doğru mekanizmadır; retrieval yanlış, eksik veya stale olduğunda sistem bunu nasıl fark eder?

RAG dosyası özellikle retrieval quality, chunking/indexing, relevance, provenance, freshness, missing-evidence riskleri, reranking, query formation, verification ve diğer dört stratejiyle kompozisyonu araştıracaktır.

### 5.2. Knowledge Graph

Knowledge Graph'ın araştırma değeri bilgi parçalarını yalnız doküman olarak değil, entities + relations + semantics şeklinde temsil edebilme ihtimalidir.

Knowledge graph literatürü bu yapıları entities ve structural relations üzerinden knowledge representation olarak ele almaktadır. GraphRAG gibi sistemler bu structured representation'ı retrieval ile birleştirmektedir.

SOUL açısından özellikle şu sorular önemlidir:

- Actor → authority → Work ilişkileri,
- Work → dependency → Environment ilişkileri,
- Decision → evidence → source ilişkileri,
- state transition ve control ilişkileri,
- bir değişikliğin hangi downstream öğeleri etkilediği.

Ancak mevcut SOUL Foundations araştırması relations/control composition'ı henüz architecture olarak yetkilendirmiş değildir. Bu nedenle Knowledge Graph araştırması mevcut foundation tree'den “graph ontology” türetmeyecektir.

Ana soru:

> Relation-heavy bilgi gerçekten graph representation gerektiriyor mu; hangi durumda graph, doküman/relational/tabular representation'dan daha doğru ve daha yönetilebilir olur?

### 5.3. Fine-Tuning

Fine-Tuning diğer dört başlıktan farklı olarak modelin dış context akışından çok modelin kendi parametric behavior'ına müdahale eder.

FLAN çalışması instruction tuning'in unseen tasks üzerindeki davranışı anlamlı biçimde değiştirebildiğini göstermiştir. LoRA ve sonraki parameter-efficient yöntemler bu adaptation'ın daha düşük maliyetli biçimlerini mümkün kılmıştır.

SOUL/Development OS açısından burada kritik gerilim şudur:

- Explicit rule / evidence / provenance → gözlenebilir ve değiştirilebilir.
- Parametric adaptation → daha düşük runtime yükü veya daha güçlü domain behavior sağlayabilir fakat davranışın nedeni ve update path'i daha az görünür hale gelebilir.

Ana soru:

> Hangi davranışların explicit working-system controls içinde kalması, hangilerinin model adaptation yoluyla öğrenilmesi daha doğrudur?

Bu dosya özellikle core governance ile task-specific capability fine-tuning ayrımını araştıracaktır.

### 5.4. CAG — Cache-Augmented Generation

CAG çalışması, limited/manageable knowledge base'in long context'e önceden yüklenmesi ve runtime state'in cache edilmesi sayesinde real-time retrieval'ın azaltılabileceğini öne sürmektedir.

Bu Development OS için ilginçtir çünkü bazı bilgiler:

- sık tekrar edilir,
- nispeten sabittir,
- her session/turn için gereklidir.

Ancak Development OS aynı zamanda freshness ve canonical state'e güçlü biçimde bağlıdır. Bu nedenle cached context hızlı olsa bile stale ise tehlikeli olabilir.

Ana soru:

> Stable context ile dynamic state nasıl ayrılır; hangi bağlam cache edilebilir, hangi bağlam her seferinde canonical kaynaktan yeniden recover edilmelidir?

CAG araştırmasının ana eksenlerinden biri bu freshness boundary olacaktır.

### 5.5. Long Context

Long Context'in araştırma değeri, retrieval olmadan büyük çalışma paketlerini bütün halinde modele sunabilmesidir.

Bu özellikle:

- exact cross-document comparison,
- bütün bir karar paketinin birlikte değerlendirilmesi,
- birden çok parçanın ilişkisel anlamının korunması,
- retrieval omission riskinin azaltılması

gibi durumlarda yararlı olabilir.

Ancak “context window'a sığması”, modelin bütün context'i eşit derecede iyi kullandığını garanti etmez. `Lost in the Middle` çalışması, ilgili bilginin uzun context içindeki konumunun performansı etkileyebildiğini göstermiştir.

RAG ve Long Context üzerine yapılan karşılaştırmalı araştırmalar da tek bir evrensel kazanan olmadığını; performans, maliyet ve task type arasında trade-off bulunduğunu göstermektedir.

Ana soru:

> Bir corpus veya çalışma paketi ne zaman doğrudan long context'e verilmelidir; ne zaman retrieval veya hibrit yöntem gerekir; long-context kullanımının gerçek coverage'ı nasıl doğrulanır?

---

## 6. Araştırmanın ortak değerlendirme çerçevesi

Sonraki beş araştırma dosyası yalnız “teknoloji nedir?” açıklaması olmayacaktır. Her dosya mümkün olduğunca aynı değerlendirme sorularına cevap verecektir.

### A. Olgunun tanımı

- Terimin kesin anlamı nedir?
- Terim tek bir yöntem mi, yöntem ailesi mi?
- Literatürde farklı kullanımlar var mı?
- Popüler kullanım ile teknik kullanım aynı mı?

### B. Çözdüğü problem

- Hangi failure/problem class için ortaya çıkmıştır?
- Hangi problemi doğrudan çözer?
- Hangi problemi çözmez?
- Problem başka mekanizmalarla da çözülebilir mi?

### C. Mekanizma

- Sistem hangi katmanını değiştirir?
- Runtime'da ne olur?
- Bilgi nerede yaşar?
- Model neyi görür?
- Model parametreleri değişir mi?

### D. Önkoşullar ve varsayımlar

- Corpus boyutu?
- Change rate?
- Latency ihtiyacı?
- Model context kapasitesi?
- Relation density?
- Training data availability?
- Infrastructure ihtiyacı?

### E. Failure mode'lar

- Yanlış retrieval?
- Missing information?
- Stale cache?
- Context overload?
- Hidden parametric behavior?
- Graph extraction errors?
- False relations?
- Catastrophic forgetting / overfitting?
- Cost explosion?
- Verification blind spots?

### F. Knowledge governance etkisi

- Source authority korunabilir mi?
- Provenance korunabilir mi?
- Freshness nasıl yönetilir?
- Update/delete nasıl yapılır?
- Access/authority nasıl sınırlandırılır?
- Bilgi yanlışsa downstream etki izlenebilir mi?

### G. Verification

- Mekanizmanın çalıştığını nasıl doğrularız?
- “Sistem cevap verdi” dışında hangi oracle gerekir?
- Yanlış durumda test kırmızı verebilir mi?
- Coverage nasıl ölçülür?
- Retrieval/context/training hataları ayrı ayrı ayırt edilebilir mi?

### H. Operational trade-off

- Token cost
- indexing/training cost
- latency
- storage
- update cost
- engineering complexity
- observability
- portability
- vendor/model dependency

### I. SOUL relevance

- Task-specific working system formation'a katkısı nedir?
- Mekanizma seçimi task koşullarına göre yapılabilir mi?
- Fail-visible ve repairable mı?
- Governed capability acquisition ile uyumlu mu?
- Least-privilege / bounded authority etkisi var mı?
- Generality'yi artırıyor mu, yoksa yeni fixed default mı yaratıyor?

### J. Development OS relevance

- Cold-start reconstructability'yi nasıl etkiler?
- Repository-authoritative state ile uyumlu mu?
- Source-view fidelity'yi nasıl etkiler?
- Session bağımsızlığı sağlar mı?
- Persistent state ile runtime context ayrımını güçlendirir mi?
- Evidence/verification zincirini kolaylaştırır mı zorlaştırır mı?

### K. Kompozisyon

Her mekanizma diğer dört mekanizma ile ikili olarak değerlendirilecektir:

- RAG + Knowledge Graph
- RAG + Fine-Tuning
- RAG + CAG
- RAG + Long Context
- Knowledge Graph + Fine-Tuning
- Knowledge Graph + CAG
- Knowledge Graph + Long Context
- Fine-Tuning + CAG
- Fine-Tuning + Long Context
- CAG + Long Context

Amaç tüm kombinasyonları zorunlu kılmak değil; mekanizmaların gerçekten rakip mi, tamamlayıcı mı, yoksa farklı problem katmanlarında mı olduğunu belirlemektir.

### L. Decision boundary

Her dosyanın sonunda en az şu soruların cevabı bulunmalıdır:

- **Use when:** hangi koşullarda güçlü aday?
- **Avoid when:** hangi koşullarda yanlış default?
- **Needs evidence:** seçimden önce hangi bilgiler bilinmeli?
- **Does not prove:** araştırma hangi architecture kararını otomatik olarak desteklemez?

---

## 7. Bu araştırmada özellikle test edilecek çalışma hipotezleri

Aşağıdakiler **bulgu veya architecture decision değildir**. Sonraki araştırmalarda yanlışlanması gereken working hypotheses'tir.

### H1 — Beş yaklaşım tek bir taxonomy'nin eş düzey kategorileri değildir

İlk inceleme bunların representation, retrieval, context management ve model adaptation gibi farklı katmanlara dokunduğunu düşündürmektedir.

### H2 — SOUL için doğru sonuç büyük olasılıkla tek mekanizma seçimi değil, koşula bağlı composition'dır

RAG + graph, RAG + long context ve stable-cache + fresh retrieval gibi kombinasyonlar pratik olarak mümkün olduğu için exclusive-choice framing zayıf olabilir.

### H3 — Knowledge governance bu beş mekanizmanın üzerinde ayrı bir sistem problemi olarak kalır

Authority, provenance, freshness, epistemic status ve verification yalnız bu mekanizmalardan biri seçilerek çözülmeyebilir.

### H4 — Fine-Tuning core governance ile task-specific capability için aynı değerlendirmeyi almamalıdır

Governance behavior'ın parametric weights içine gömülmesi ile özel domain capability'nin fine-tune edilmesi farklı risk/yarar profillerine sahip olabilir.

### H5 — Development OS için stable context / dynamic state ayrımı önemli olabilir

CAG ve caching bazı sabit knowledge/control surface'lerinde yararlı olabilirken current Work, authorization ve mutable state'in fresh canonical recovery gerektirmesi olasıdır.

### H6 — Long Context capacity ile long-context utilization aynı şey değildir

Bir modelin N token kabul etmesi, o N token içindeki yük taşıyan bilgiyi güvenilir biçimde kullandığını kanıtlamaz.

### H7 — Retrieval başarısı yalnız relevance metriğiyle değerlendirilemez

Source authority, omission, provenance, freshness ve downstream decision sensitivity de retrieval correctness'ın parçası olabilir.

---

## 8. Araştırma paketi ve dosya sırası

Bu paket toplam **6 dosyadan** oluşacaktır.

### Dosya 0 — mevcut dosya

`00-WHY-THIS-RESEARCH.md`

Rolü:

- araştırmanın neden açıldığını kaydetmek,
- beş başlığın başlangıç framing'ini sabitlemek,
- category-error riskini görünür yapmak,
- SOUL ve Development OS relevance'ını açıklamak,
- sonraki araştırmaların ortak değerlendirme yöntemini tanımlamak.

### Dosya 1

`01-RAG.md`

Derin araştırma konusu: Retrieval-Augmented Generation.

### Dosya 2

`02-KNOWLEDGE-GRAPH.md`

Derin araştırma konusu: Knowledge Graph ve relation-centric knowledge representation.

### Dosya 3

`03-FINE-TUNING.md`

Derin araştırma konusu: model adaptation / fine-tuning ve parameter-efficient adaptation.

### Dosya 4

`04-CAG.md`

Derin araştırma konusu: Cache-Augmented Generation ve stable-context caching.

### Dosya 5

`05-LONG-CONTEXT.md`

Derin araştırma konusu: Long Context, direct-context ingestion ve RAG/LC trade-off'ları.

Bu turda yalnız Dosya 0 oluşturulmuştur. Dosya 1–5 için substantive research henüz bu package kapsamında başlamamıştır.

---

## 9. Paket sınırları

Bu araştırma paketi şu kararları **vermez**:

- SOUL kesin olarak RAG kullanacak.
- SOUL kesin olarak Knowledge Graph kullanacak.
- SOUL modelini fine-tune edecek.
- Development OS CAG kullanacak.
- Development OS tüm dosyaları Long Context'e yükleyecek.
- Mevcut SOUL Foundations research tree bir graph ontology'dir.
- `Environment / Information / Work / Actors` doğrudan database schema'ya çevrilmelidir.
- Bu beş mekanizma SOUL'un final technology stack'idir.
- Bu beş mekanizma bilgi/bağlam probleminin eksiksiz taxonomy'sidir.

Araştırma bulgusu ile architecture decision ayrımı korunacaktır.

---

## 10. Başarı ölçütü

Beş derin araştırma tamamlandığında paketin başarılı sayılması için yalnız her tekniğin tanımının bilinmesi yeterli değildir.

Araştırma sonunda şu tür sorulara kanıt-temelli cevap verebiliyor olmalıyız:

1. Hangi problem koşulu hangi mekanizmayı güçlü aday yapar?
2. Hangi koşulda aynı mekanizma yanlış seçim olur?
3. Mekanizmalar hangi katmanlarda birbirinden farklıdır?
4. Hangi kombinasyonlar gerçek anlamda tamamlayıcıdır?
5. Hangi kombinasyonlar gereksiz karmaşıklık yaratır?
6. SOUL'un task-specific system formation hedefi açısından hangi selection logic gerekir?
7. Development OS'nin cold-start, repository authority, provenance ve verification ihtiyaçları açısından hangi mekanizmalar değerlidir?
8. Hangi kritik bilgiler bu beş teknikten hiçbiri tarafından çözülmez ve ayrı governance mekanizması gerektirir?
9. Hangi bulgular architecture decision için yeterli değildir?
10. Sonraki bir architecture/implementation aşamasında hangi decision-critical belirsizlikler hâlâ açık kalacaktır?

Araştırmanın hedefi “kazanan teknoloji” ilan etmek değil, **doğru karar sınırlarını görünür hale getirmektir.**

---

## 11. Başlangıç kaynakları

Aşağıdaki kaynaklar bu rationale dosyasındaki başlangıç framing'ini desteklemek için kullanılmıştır. Her derin araştırma kendi source set'ini ayrıca genişletecek ve doğrulayacaktır.

### SOUL / Development OS birincil kaynakları

1. `batuhanozgun/soul`, `main`, `README.md`, blob `9dbded3017e62a968ead024cf1d544d1d37a2be2`  
   https://github.com/batuhanozgun/soul/blob/main/README.md

2. `batuhanozgun/soul`, `phase0/development-os`, `development/README.md`, blob `e6a87f700f4766073ad8cf4307582f3498f3bfdd`  
   https://github.com/batuhanozgun/soul/blob/phase0/development-os/development/README.md

### Mevcut SOUL Research canonical context

3. `research/soul-foundations/STATE.md`, blob `27a400c091943d442c654d500ab768f93eea7e4c`  
   Kullanım: mevcut foundation araştırma statüsü ve architecture/non-architecture sınırı.

4. `research/soul-context/evidence/CONTEXT-SYNTHESIS.md`, blob `42ddc1dcc9bb7c07b927961bc74179008060a562`  
   Kullanım: SOUL ve Development OS'nin bounded source-backed context'i.

### RAG

5. Lewis, P. et al. (2020), *Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks*.  
   https://arxiv.org/abs/2005.11401

### Knowledge Graph / GraphRAG

6. Ji, S. et al. (2021/2022), *A Survey on Knowledge Graphs: Representation, Acquisition and Applications*.  
   https://arxiv.org/abs/2002.00388  
   DOI: 10.1109/TNNLS.2021.3070843

7. Microsoft GraphRAG documentation.  
   https://microsoft.github.io/graphrag/

### Fine-Tuning

8. Wei, J. et al. (2021/2022), *Finetuned Language Models Are Zero-Shot Learners*.  
   https://arxiv.org/abs/2109.01652

9. Hu, E. J. et al. (2021), *LoRA: Low-Rank Adaptation of Large Language Models*.  
   https://arxiv.org/abs/2106.09685

### CAG

10. Chan, B. J. et al. (2024), *Don't Do RAG: When Cache-Augmented Generation is All You Need for Knowledge Tasks*.  
    https://arxiv.org/abs/2412.15605

### Long Context / RAG comparison

11. Li, Z. et al. (2024), *Retrieval Augmented Generation or Long-Context LLMs? A Comprehensive Study and Hybrid Approach*.  
    https://arxiv.org/abs/2407.16833

12. Liu, N. F. et al. (2024), *Lost in the Middle: How Language Models Use Long Contexts*. Transactions of the Association for Computational Linguistics 12:157–173.  
    https://aclanthology.org/2024.tacl-1.9/  
    DOI: 10.1162/tacl_a_00638

---

## 12. Current handoff

**Completed:** research rationale / package framing.  
**Not completed:** individual research on RAG, Knowledge Graph, Fine-Tuning, CAG, Long Context.  
**Next planned file:** `01-RAG.md`.  
**Next action in this package:** stop here; do not start RAG research in the same turn.  
**Architecture authority:** none granted by this file.  
**Foundation-tree effect:** none; this package is a separate technical research line.

The next session/turn can begin from this file and research `01-RAG.md` without reconstructing the Instagram-post conversation from chat history.
