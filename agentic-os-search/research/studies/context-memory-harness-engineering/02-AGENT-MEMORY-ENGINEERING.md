# Agent Memory Systems / “Memory Engineering” — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `01-CONTEXT-ENGINEERING.md`  
**Research object:** persistent and evolving memory/state mechanisms for LLM-based agents; “Memory Engineering” treated as an emerging practical label  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to AI Knowledge Strategies:** intersects RAG and Knowledge Graph most strongly; must be distinguished from CAG, Long Context and parametric fine-tuning  
**Verification status:** cross-source synthesis; no local memory benchmark, privacy test or long-horizon SOUL experiment executed

---

## 1. Araştırma sorusu

> **Bir agent memory sistemi neyi gerçekten “hatırlamalı”, memory'yi storage'dan ayıran lifecycle nedir, update/contradiction/forgetting/provenance gibi failure mode'lar nasıl yönetilir ve SOUL / Development OS açısından persistent project state ile agent memory arasında nasıl bir sınır kurulmalıdır?**

Bu dosya şu daha dar sorularla aynı değildir:

- “Vector database kullanalım mı?”
- “Chat history'yi kaydedelim mi?”
- “RAG memory midir?”
- “Model weights memory midir?”
- “Long Context varsa memory gereksiz mi?”
- “Repository memory olsun mu?”

---

## 2. Terminoloji: problem yerleşik, etiket genç

Agent memory üzerine akademik çalışma en az 2023–2024 itibarıyla belirgin bir araştırma hattıdır. Generative Agents experience stream + reflection + dynamic retrieval; Reflexion episodic verbal reflection; MemGPT hierarchical/virtual context; LongMemEval multi-session memory; daha yeni surveys write/manage/read, consolidation, forgetting ve privacy gibi mekanizmaları sistematize eder. [S1][S2][S3][S4][S5][S6]

Buna karşılık **“Memory Engineering”** adı henüz aynı derecede settled academic term değildir.

Bu nedenle bu dosyanın epistemik pozisyonu:

> **Agent memory systems gerçek ve olgunlaşan bir research object'tir. “Memory Engineering” ise bu sistemlerin deliberate design, lifecycle, verification ve governance disiplinini anlatmak için yararlı ama emerging bir engineering label'dır.**

Bu ayrım önemlidir çünkü popüler terminolojiye mimari gerçeklik atfetmemeliyiz.

---

## 3. Minimum tanım: memory = state over time

2026 memory survey agent memory'yi perception/action ile bağlı bir `write → manage → read` loop olarak formalize eder. [S1]

Bu araştırma için genişletilmiş tanım:

> **Agent Memory Engineering = bir agent/system'in zaman içinde hangi bilgi ve deneyimi external veya internal memory substrate'larına yazacağını, nasıl temsil edeceğini, doğrulayacağını, birleştireceğini, güncelleyeceğini, supersede/forget edeceğini, ne zaman geri çağıracağını ve current context'e hangi epistemik statüyle taşıyacağını tasarlama disiplinidir.**

Bu tanım memory'yi “persist edilmiş text”ten ayırır.

```text
storage ≠ memory correctness
retrieval ≠ recall correctness
recall ≠ context use
retention ≠ truth
```

---

## 4. Memory'nin temel yaşam döngüsü

### 4.1. Observe / candidate formation

Agent bir olay, tool result, user statement, decision veya outcome görür.

Soru:
> Bu olay memory candidate mı?

Her observation kalıcı memory olmamalıdır.

### 4.2. Write / encode

Candidate hangi formda yazılır?

- raw episode,
- normalized fact,
- decision record,
- procedure,
- summary,
- relation edge,
- embedding/index entry,
- structured state.

### 4.3. Validate / qualify

Memory'ye yazılan şey:

- user claim mi,
- observed source fact mi,
- model inference mı,
- accepted decision mı,
- hypothesis mi,
- temporary plan mı?

Epistemic status korunmazsa memory zamanla misinformation amplifier olabilir.

### 4.4. Consolidate / organize

Generative Agents raw experiences'dan higher-level reflections üretir. 2026 survey memory evolution'u storage → reflection → experience abstraction üzerinden inceler. [S2][S5]

Consolidation yararlı olabilir; fakat lossy transformation ve false synthesis riski taşır.

### 4.5. Update / supersede / contradiction handling

LongMemEval'in core memory abilities'inden biri **knowledge updates**'tır. [S3]

Gerçek memory sistemi yalnız eski bilgi bulmamalı; yeni bilgi geldiğinde:

- overwrite mi,
- version mi,
- temporal interval mi,
- conflict set mi,
- invalidate mi

yapacağını bilmelidir.

### 4.6. Retain / expire / forget

Memory sisteminin amacı maksimum retention değildir.

Gereksiz retention:
- privacy risk,
- stale recall,
- retrieval noise,
- storage growth,
- obsolete behavior.

2026 survey learned forgetting ve privacy governance'ı açık research problem olarak tutar. [S1]

### 4.7. Read / retrieve

Memory hangi query/state altında geri çağrılır?

- semantic relevance,
- recency,
- temporal validity,
- work/actor scope,
- exact key,
- causal/relational relevance,
- current goal.

### 4.8. Inject / use

Recall sonucu current context'e girer. Bu noktadan sonra Context Engineering failure surface'i başlar.

---

## 5. Memory türleri: tek taxonomy yok

Literatür memory'yi farklı eksenlerde böler. Tek bir insan-belleği taxonomy'sini production architecture olarak dayatmak doğru değildir.

Yararlı system-oriented ayrımlar:

### 5.1. Episodic memory

Belirli geçmiş interaction/trajectory/event:

```text
“Bu API call önce 401 verdi; token scope eksikti.”
```

Reflexion reflective text'i episodic buffer'da tutarak sonraki trial'ları etkiler. [S6]

### 5.2. Semantic / fact memory

Daha general, event'ten abstraction yapılmış bilgi:

```text
“Service X yalnız scope Y ile erişilebilir.”
```

### 5.3. Procedural / workflow memory

Nasıl yapılır bilgisi:

```text
“Release öncesi A → B → C kontrolü gerekir.”
```

LongMemEval-V2 gibi current agent-memory evaluations workflow knowledge ve environment gotchas gibi experience classes'i ayrıca test eder. [S7]

### 5.4. Working/session state

Current task'in:
- progress,
- current plan,
- pending calls,
- scratch calculations,
- temporary hypotheses.

Bunun kalıcılık süresi long-term semantic memory'den farklı olabilir.

### 5.5. Canonical operational/project state

Repository/database/source-of-truth tarafından authority taşıyan current state.

Bu sınıf SOUL/Development OS için özellikle önemlidir ve “agent'ın hatırladığı bir şey” ile aynı statüde olmamalıdır.

---

## 6. En kritik ayrım: memory ≠ source of truth

Bir agent memory kaydı:

- source'dan türetilmiş olabilir,
- model tarafından özetlenmiş olabilir,
- user claim'inden gelmiş olabilir,
- eski bir state'i temsil ediyor olabilir.

Dolayısıyla:

> **Memory availability, source authority üretmez.**

SOUL/Development OS açısından candidate precedence:

```text
fresh authoritative source/state
        >
verified persistent derived memory
        >
unverified/heuristic memory
```

Bu architecture decision değildir; epistemik boundary'dir.

Mevcut repository'nin “canonical state chat/model memory'den üstündür” ilkesi bu ayrımla uyumludur.

---

## 7. Memory write path neden read path kadar önemlidir?

RAG-centric düşünce çoğu zaman şu soruya odaklanır:

> “Doğru memory'yi nasıl retrieve ederiz?”

Fakat kötü yazılmış memory'yi kusursuz retrieve etmek sadece yanlışı daha güvenilir şekilde geri getirir.

Write path failure'ları:

- hallucinated fact persist edildi,
- temporary hypothesis fact olarak yazıldı,
- old state current diye snapshotlandı,
- private data gereksiz kaydedildi,
- duplicate facts conflict üretti,
- model-generated reflection source evidence'dan ayrılmadı,
- user correction eski memory'yi supersede etmedi.

Bu nedenle memory quality:

```text
write correctness
× management correctness
× read correctness
× context-use correctness
```

zinciridir.

---

## 8. Contradiction ve temporal state

Long-term agent systemsinde aynı entity hakkında farklı zamanlarda farklı true values olabilir.

Örnek:

```text
T1: deployment region = eu-west
T2: deployment region = us-east
```

Bu contradiction değildir; temporal update olabilir.

Başka örnek:

```text
Source A: current owner = Alice
Source B: current owner = Bob
same validity interval
```

Bu gerçek conflict olabilir.

Memory sistemi şu ayrımları taşıyabilmelidir:

- observed_at,
- valid_from / valid_to,
- source identity,
- source authority,
- supersedes,
- confidence/status,
- work/project scope.

Knowledge Graph burada useful substrate olabilir; zorunlu değildir.

---

## 9. RAG ile ilişki

RAG external non-parametric evidence retrieval problemidir. Memory retrieval da RAG-benzeri mechanisms kullanabilir, fakat iki kavram eş değildir.

### RAG memory'nin read mechanism'i olabilir

Memory store:

```text
episodes / facts / notes
        ↓ index
query → retrieve
        ↓
context
```

### Fakat memory ayrıca write/manage lifecycle içerir

RAG tek başına şu soruları çözmez:

- ne yazılmalı,
- yanlış memory nasıl silinmeli,
- conflict nasıl resolve edilmeli,
- memory ne kadar tutulmalı,
- access scope ne olmalı,
- episodic observation ne zaman semantic fact'e promote edilmeli.

Dolayısıyla:

> **RAG, memory engineering'in tamamı değil; bazı memory architectures'ta read/retrieval katmanıdır.**

---

## 10. Knowledge Graph ile ilişki

Knowledge Graph relation-heavy persistent memory için candidate representation olabilir:

```text
Actor → authorised_for → Work
Decision → supported_by → Evidence
Fact_v2 → supersedes → Fact_v1
```

Fakat `02-KNOWLEDGE-GRAPH.md` sonucu korunmalıdır:

- graph edge fact değildir,
- extracted/predicted relation epistemic status ister,
- graph miss absence değildir,
- graph source-of-truth'ı otomatik ikame etmez.

Bu nedenle KG memory substrate olabilir; memory governance'ı çözmez.

---

## 11. CAG / cache neden long-term memory değildir?

CAG / prompt/KV cache repeated computation veya repeated context reuse sağlar.

KV cache:

- model/prefix/runtime identity'ye bağlıdır,
- invalidation ister,
- semantic fact store değildir,
- source authority taşımaz,
- “öğrenilen bilgi” değildir.

Dolayısıyla:

> **Cache persistent computational state olabilir; fakat agent memory ile eş anlamlı değildir.**

Memory sistemi cache kullanabilir, ama cache “agent ne biliyor?” sorusunun authoritative answer'ı değildir.

---

## 12. Long Context neden memory değildir?

Long Context aynı inference episode içinde çok bilgi görünür kılar.

Memory ise information'ın **zaman içinde survival/update/read** problemidir.

```text
Long Context
= large current working set

Memory
= cross-time state lifecycle
```

MemGPT'nin virtual-context yaklaşımı bu iki problemi birbirine bağlar: sınırlı fast context ile larger external memory arasında data movement yapar. [S4]

Bu ilişki operating-system analogy'sini yararlı kılar, fakat exact implementation prescription değildir.

---

## 13. Fine-Tuning ve parametric memory

Literatürde model weights bazen parametric memory olarak adlandırılır. Fakat SOUL/Development OS açısından practical memory engineering ile fine-tuning'i aynılaştırmak tehlikelidir.

Fine-Tuning:
- model weights'i değiştirir,
- runtime recall path'i görünür değildir,
- precise deletion/update zor olabilir,
- source attribution zayıftır.

External memory:
- inspectable olabilir,
- version/delete/update edilebilir,
- source identity taşıyabilir.

Bu nedenle current package için:

> **Parametric adaptation memory-like persistence sağlayabilir ama operational agent-memory lifecycle ile aynı engineering surface değildir.**

Core governance/current state için `03-FINE-TUNING.md`'in explicit external control lehine boundary'si korunur.

---

## 14. Reflection memory: fayda ve epistemik risk

Generative Agents raw memory stream'den higher-level reflections üretir; Reflexion task feedback'ten verbal reflections persist eder. Bu çalışmalar reflection'ın behavior'a katkı sağlayabileceğini gösterir. [S2][S6]

Fakat reflection:

```text
observations
→ model interpretation
→ persistent reflection
```

olduğu için derived inference'tır.

Risk:
- yanlış causal lesson kalıcılaşır,
- tek failure overgeneralize edilir,
- self-assessment “truth” olur,
- later retrieval aynı yanlış reflection'ı reinforce eder.

SOUL için reflection memory kullanılacaksa source/evidence ve verification status'tan ayrılmalıdır.

---

## 15. Forgetting bir bug değil, capability olabilir

Agent memory'nin naive objective'i:

> “Hiçbir şeyi unutma.”

olmamalıdır.

Selective forgetting / expiration şu nedenlerle gerekli olabilir:

- privacy/minimization,
- stale state removal,
- revoked authorization,
- superseded procedures,
- low-value episode noise,
- storage/latency budget.

Ama forgetting failure da üretir:

- rare but critical lesson silinir,
- provenance chain kırılır,
- reason-for-decision kaybolur.

Bu nedenle retention policy memory class'a göre değişmelidir.

---

## 16. Privacy ve access control

Persistent memory short-lived context'ten daha yüksek privacy risk taşıyabilir çünkü:

- data cross-session kalır,
- recall başka Work'te olabilir,
- multiple Actors arasında sızıntı olabilir,
- “unut” talebi deletion semantics ister,
- derived memories source deletion'dan sonra yaşamaya devam edebilir.

Minimum governance questions:

- bu memory kime ait?
- hangi Work/tenant/Actor scope'una ait?
- hangi source'tan üretildi?
- ne kadar tutulmalı?
- deletion source-derived copies'i de kapsıyor mu?
- sensitive data write path'te filtreleniyor mu?
- recall permission current mı?

Memory system privacy yalnız encrypted storage değildir; **read/write policy** problemidir.

---

## 17. Memory poisoning ve self-reinforcement

Agent kendi outputs'unu tekrar memory'ye yazıyorsa feedback loop oluşur:

```text
model inference
→ memory write
→ later recall
→ model sees its own old inference as context
→ confidence amplification
```

Source-linked verification yoksa unsupported model belief persistent pseudo-evidence'e dönüşebilir.

Bu nedenle candidate rule:

> model-generated memory ile externally observed/authoritative memory aynı epistemic class'ta tutulmamalıdır.

---

## 18. Memory evaluation: yalnız recall accuracy değil

LongMemEval memory evaluation'ı extraction, multi-session reasoning, temporal reasoning, knowledge updates ve abstention gibi abilities'e böler. [S3]

SOUL/Development OS için daha geniş matrix:

### 18.1. Write precision

Persist edilmemesi gereken şey memory oldu mu?

### 18.2. Write recall

Persist edilmesi gereken critical event kaçtı mı?

### 18.3. Update correctness

Yeni fact eskiyi doğru biçimde supersede etti mi?

### 18.4. Temporal reasoning

Model T1/T2 state'lerini karıştırıyor mu?

### 18.5. Contradiction handling

Conflicting sources tek fact'e collapse oluyor mu?

### 18.6. Retrieval / recall

Relevant memory doğru zamanda bulunuyor mu?

### 18.7. Abstention

Memory'de yoksa sistem “bilmiyorum” diyebiliyor mu?

### 18.8. Authority precedence

Stale memory fresh canonical state'i override ediyor mu?

### 18.9. Forgetting / deletion

Revoked/superseded memory gerçekten use path'ten çıkıyor mu?

### 18.10. Privacy/access

Memory cross-tenant veya wrong-Actor scope'a sızıyor mu?

### 18.11. Downstream decision impact

Memory retrieval doğru fact'i getirse bile actual Work kararını iyileştiriyor mu?

---

## 19. OpenAI Sessions örneğinin gösterdiği sınır

OpenAI Agents SDK `Sessions` mekanizmasını persistent memory layer olarak tanımlar; previous conversation items'ı retrieve edip next turn'e prepend eder ve yeni items'ı persist eder. [S8]

Bu yararlı bir concrete implementation'dır fakat memory engineering'in tamamını temsil etmez.

Session persistence:

```text
history stored + replayed
```

sağlayabilir.

Ama ayrıca çözülmesi gerekenler:

- hangi history prune/compact edilir,
- fact update nasıl anlaşılır,
- stale instruction ne olur,
- cross-session authority nasıl yönetilir,
- derived facts nasıl doğrulanır.

Dolayısıyla “session memory enabled” = “memory architecture solved” değildir.

---

## 20. SOUL açısından değerlendirme

SOUL'un general-purpose working-system hedefinde memory'nin güçlü potansiyel rolleri:

### 20.1. Work continuity

Uzun-running Work'te decisions, progress, unresolved issues.

### 20.2. Environment experience

Tekrarlanan local gotchas, tool quirks, failure patterns.

### 20.3. Task-specific procedural knowledge

Belirli Work type için discovered workflow.

### 20.4. Actor/project scoped durable facts

Yalnız proper authority/privacy controls ile.

### 20.5. Verification learning

Hangi testlerin önceki failure'ları yakaladığı — fakat verifier ritualization riskini de taşıyarak.

SOUL memory system için asıl soru “memory var mı?” değil:

> **Hangi memory class hangi Work/Actor/Environment koşulunda güvenli ve faydalıdır; source-of-truth ile ilişkisi nedir; nasıl current tutulur?**

---

## 21. Development OS açısından değerlendirme

Development OS bugün persistent continuity'yi büyük ölçüde repository üzerinden sağlar.

Bu önemli bir distinction yaratır:

```text
repo canonical state
≠
opaque model memory
```

Repository avantajları:
- inspectable,
- versioned,
- diffable,
- source-linked,
- fresh session'da recoverable,
- human/agent ortak erişimli.

Bu açıdan Development OS'nin mevcut yaklaşımı bazı memory-engineering goals'i zaten açık ve denetlenebilir external state ile karşılar.

### Fakat bütün repository “memory” değildir

Repository içinde:
- source evidence,
- current state,
- historical state,
- hypotheses,
- rejected work,
- protocols,
- synthesis

vardır.

Bunların hepsini tek memory pool gibi retrieve etmek yanlış olur.

### En güçlü project-specific boundary

> **Development OS için canonical project state memory'den daha yüksek authority class'ı olarak kalmalıdır; memory-like derived/learned artefacts fresh canonical recovery'yi ikame etmemelidir.**

Bu architecture implementation kararı değil, mevcut project correctness goal'undan çıkan epistemik constraint'tir.

---

## 22. Candidate memory classes for Development OS — research frame

| Memory/state class | Candidate persistence | Authority | Main risk |
|---|---|---:|---|
| Current Work/authorization | canonical repository state | high | stale read |
| Accepted decision | decision/state artifact + source refs | high/qualified | decision context loss |
| Research finding | versioned evidence-backed file | qualified | synthesis overreach |
| Session scratch | ephemeral/short-lived | low | accidental promotion |
| Agent reflection | derived persistent note if useful | low until verified | self-reinforcement |
| Tool/environment gotcha | candidate learned procedure | medium after validation | obsolete workaround |
| User/project stable preference | scoped memory | context-dependent | privacy/staleness |
| Historical state | archive | historical only | current contamination |

Bu tablo implementation schema değildir; memory-class separation'ın neden gerekli olduğunu gösterir.

---

## 23. Memory ile Context Engineering'in handoff boundary'si

Memory read sonucu şu metadata ile Context Engineering'e verilirse daha güvenli olabilir:

```text
memory_id
memory_type
epistemic_status
source_refs
created_at
valid_time / superseded_by
actor/work scope
confidence / verification status
```

Context builder sonra şu kararı verir:

- include,
- exclude,
- retrieve source,
- compare with canonical state,
- compress,
- ask clarification.

Bu separation diagnosis ve observability sağlar.

---

## 24. Harness ile ilişki

Harness memory lifecycle'i işletir:

- hangi event write trigger?
- write before/after verifier mı?
- tool result auto-persist mi?
- session end'de handoff oluşuyor mu?
- memory recall her turn mü, on-demand mı?
- access control nerede uygulanıyor?
- failure halinde rollback var mı?

Bu nedenle Memory Engineering policy tanımlayabilir; harness policy'nin **operational execution surface**'i olabilir.

---

## 25. Decision boundary

### Memory Engineering güçlü lens when

- agent session'lar arasında kararları unutuyor,
- aynı environment gotcha tekrar tekrar öğreniliyor,
- stale facts geri geliyor,
- user correction etkisiz kalıyor,
- learned procedure zaman içinde gelişmeli,
- session history büyüyor ama useful knowledge ayrışmıyor,
- old/new state conflict ediyor,
- memory privacy/deletion gerekiyor.

### Memory çözümü değildir when

- current call'da doğru evidence yoksa → context/retrieval problemi olabilir,
- tool kullanımı yanlışsa → harness/ACI problemi olabilir,
- model task capability'si yetersizse → model/adaptation problemi olabilir,
- canonical source yanlışsa → source correctness problemi,
- verifier zayıfsa → verification problemi.

---

## 26. Bulgular

### F-MEM-01 — Agent memory yerleşik araştırma problemidir; “Memory Engineering” etiketi ise emerging'dir

**Confidence:** high  
**Basis:** multi-year memory literature vs current practitioner terminology. [S1][S2][S3][S4][S5][S9]

### F-MEM-02 — Memory storage değil, cross-time lifecycle'dır

**Confidence:** high  
**Basis:** write–manage–read survey + update/temporal benchmarks. [S1][S3]

### F-MEM-03 — Memory write correctness read correctness kadar yük taşıyabilir

**Confidence:** high as synthesis  
**Basis:** reflection/experience systems + contradiction/privacy management literature. [S1][S2][S6]

### F-MEM-04 — Knowledge update, temporal validity ve abstention long-term memory'nin ayrı capabilities'idir

**Confidence:** high  
**Basis:** LongMemEval. [S3]

### F-MEM-05 — Reflection memory behavior'ı iyileştirebilir fakat derived inference olduğu için epistemic status ister

**Confidence:** high  
**Basis:** Generative Agents + Reflexion. [S2][S6]

### F-MEM-06 — RAG memory retrieval mechanism'i olabilir ama memory engineering'in tamamı değildir

**Confidence:** high as synthesis  
**Basis:** `01-RAG.md` + write/manage/read lifecycle.

### F-MEM-07 — Knowledge Graph memory substrate olabilir ama authority/temporal/provenance correctness'ı otomatik sağlamaz

**Confidence:** high as synthesis  
**Basis:** `02-KNOWLEDGE-GRAPH.md`.

### F-MEM-08 — CAG/KV cache durable semantic memory ile eş anlamlı değildir

**Confidence:** high  
**Basis:** `04-CAG.md`.

### F-MEM-09 — Long Context current working set'tir; persistent memory değildir

**Confidence:** high  
**Basis:** MemGPT relation + `05-LONG-CONTEXT.md`. [S4]

### F-MEM-10 — Development OS canonical repository state'i agent memory ile aynı authority class'ında ele almak zayıf framing'dir

**Confidence:** high as project-specific synthesis  
**Basis:** repository-authoritative goal + memory staleness/update findings.

### F-MEM-11 — Memory read path Context Engineering'e, lifecycle execution Harness Engineering'e bağlanır

**Confidence:** high as systems synthesis  
**Basis:** agent-memory lifecycle + context/harness sources.

---

## 27. Açık sorular

1. SOUL hangi memory classes'e gerçekten ihtiyaç duyuyor?
2. Hangi memory sınıfı canonical state değil derived/learned memory olmalı?
3. Memory promotion gate human/verifier/source-backed nasıl çalışmalı?
4. Episodic → semantic consolidation ne zaman yapılmalı?
5. Reflection memory hangi doğrulama statüsünü taşımalı?
6. Temporal facts için version model'i ne olmalı?
7. Memory deletion downstream derived copies'e nasıl yayılmalı?
8. Work/Actor scope access control nasıl temsil edilmeli?
9. Recall ranking semantic relevance dışında hangi signals'i kullanmalı?
10. Memory retrieval miss nasıl fail-visible olmalı?
11. Canonical state ile memory conflict'i hangi gate çözecek?
12. Memory latency/token budget'i task value ile nasıl dengelenecek?
13. LongMemEval-benzeri local benchmark hangi project scenarios'u içermeli?
14. Tool/environment experience memory'si model upgrade sonrası stale olabilir mi?
15. Memory poisoning/self-reinforcement nasıl test edilmeli?
16. Fine-tuning ile external memory arasında capability boundary nerede?

---

## 28. Araştırma sınırları

- “Memory Engineering” settled industry standard diye sunulmadı.
- Human cognitive-memory taxonomy production schema'ya çevrilmedi.
- Vector DB memory default'u ilan edilmedi.
- Local memory implementation/benchmark yapılmadı.
- Personal-user memory ile project/agent operational memory aynı privacy modelinde varsayılmadı.
- Reflection'ın başarı gösterdiği benchmarks universal self-improvement garantisi sayılmadı.
- Model weights ile external memory eşitlenmedi.
- Repository'nin tamamı memory store olarak adlandırılmadı.

---

## 29. Source ledger

**[S1] Du, P. et al. (2026). _Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers_.**  
https://arxiv.org/abs/2603.07670  
Use: write–manage–read loop, taxonomy, write filtering, contradiction, latency, privacy and forgetting.  
Limit: current survey/preprint.

**[S2] Park, J. S. et al. (2023). _Generative Agents: Interactive Simulacra of Human Behavior_. UIST 2023.**  
https://doi.org/10.1145/3586183.3606763  
Use: memory stream, reflection synthesis, dynamic retrieval for planning.

**[S3] Wu, D. et al. (2024). _LongMemEval: Benchmarking Chat Assistants on Long-Term Interactive Memory_.**  
https://arxiv.org/abs/2410.10813  
Use: extraction, multi-session reasoning, temporal reasoning, knowledge updates, abstention; indexing/retrieval/reading.

**[S4] Packer, C. et al. (2023). _MemGPT: Towards LLMs as Operating Systems_.**  
https://arxiv.org/abs/2310.08560  
Use: virtual context management and hierarchical data movement beyond context window.

**[S5] Luo, J. et al. (2026). _From Storage to Experience: A Survey on the Evolution of LLM Agent Memory Mechanisms_. Findings of ACL 2026.**  
https://aclanthology.org/2026.findings-acl.2069/  
Use: storage → reflection → experience abstraction framing.

**[S6] Shinn, N. et al. (2023). _Reflexion: Language Agents with Verbal Reinforcement Learning_. NeurIPS 2023.**  
https://papers.nips.cc/paper_files/paper/2023/hash/1b44b878bb782e6954cd888628510e90-Abstract-Conference.html  
Use: episodic reflective text influencing later trials without weight updates.

**[S7] Wu, D. et al. (2026). _LongMemEval-V2: Evaluating Long-Term Agent Memory Toward Experienced Colleagues_.**  
https://xiaowu0162.github.io/longmemeval-v2/  
Use: current environment-experience memory abilities: static state, dynamic state, workflow knowledge, gotchas, premise awareness.  
Limit: current benchmark evidence; package result does not depend on exact leaderboard numbers.

**[S8] OpenAI Agents SDK. _Sessions_. Current read 2026-09-03.**  
https://openai.github.io/openai-agents-js/guides/sessions/  
Use: concrete persistent session-memory implementation; previous items fetched/prepended and new items persisted.  
Limit: framework implementation, not complete memory theory.

**[S9] Oracle Developer Relations (2026). _Building a Memory-First Agent Harness_.**  
https://oracle-devrel.github.io/oracle-ai-developer-hub/guides/memory_engineering_devweek_sf_2026.pdf  
Use: evidence of current practitioner use of “Memory Engineering” label alongside Context/Harness.  
Limit: practitioner terminology, not standardization proof.

**[S10] Existing package evidence:**  
`research/ai-knowledge-strategies/01-RAG.md`  
`research/ai-knowledge-strategies/02-KNOWLEDGE-GRAPH.md`  
`research/ai-knowledge-strategies/03-FINE-TUNING.md`  
`research/ai-knowledge-strategies/04-CAG.md`  
`research/ai-knowledge-strategies/05-LONG-CONTEXT.md`

---

## 30. Current handoff

**Completed:** agent memory systems / “Memory Engineering” bounded research.  
**Result:** memory is best treated as cross-time state lifecycle, not storage or retrieval alone. Correctness depends on write qualification, update/supersede, temporal validity, retention/forgetting, access, read/retrieval and eventual context injection.  
**Key Development OS finding:** repository-authoritative current state should remain a higher-authority class than derived/learned agent memory; memory should not silently become source-of-truth.  
**Terminology caveat:** “Memory Engineering” is useful but emerging; package conclusions rest on agent-memory evidence rather than the label.  
**Architecture decision:** none.  
**Next research object:** Harness Engineering.