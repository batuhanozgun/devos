# Context, Memory ve Harness Engineering — Neden Bu Araştırmayı Yapıyoruz?

**Status:** research rationale / package entry surface  
**Date:** 2026-09-03  
**Scope:** Context Engineering, agent memory systems / “Memory Engineering”, Harness Engineering ve bunların mevcut AI Knowledge Strategies araştırmasıyla ilişkisi  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** ayrı teknik/sistem araştırma hattı; mevcut foundation hierarchy'yi değiştirmez veya genişletmez  
**Related package:** `research/ai-knowledge-strategies/`  
**Package intent:** üç kavramı eş düzey moda terimleri gibi kabul etmek yerine gerçek problem sınırlarını, örtüşmelerini, failure mode'larını ve SOUL / Development OS için karar değerini araştırmak

---

## 1. Bu araştırma neden açıldı?

Bir video parçasında üç kavram yan yana kullanıldı:

1. **Context Engineering**
2. **Memory Engineering**
3. **Harness Engineering**

İlk bakışta bunlar agent sistemlerinin üç temiz katmanı gibi görünebilir:

```text
Context  → model şimdi ne görüyor?
Memory   → sistem zaman içinde ne tutuyor?
Harness  → model hangi çalışma sistemi içinde hareket ediyor?
```

Bu sezgi yararlıdır, fakat doğrudan taxonomy olarak kabul edilirse iki risk vardır:

- alanın güncel terminolojisindeki olgunluk farklarını gizlemek;
- üç alanın gerçek sistemlerde birbirinin içine girdiği noktaları yapay biçimde ayırmak.

Örneğin Anthropic, “context engineering” altında yalnız prompt seçimini değil retrieval, compaction, persisted note-taking/agentic memory ve sub-agent context izolasyonunu da tartışır. Güncel agent-memory survey'leri memory'yi yalnız storage değil `write → manage → read` yaşam döngüsü olarak ele alır. Harness engineering ise güncel kaynaklarda agent loop, tools, context management, safety controls, orchestration, verification ve runtime scaffolding'i kapsayacak kadar geniş tanımlanır.

Dolayısıyla başlangıç sorumuz:

> “Bu üçünden hangisini seçmeliyiz?”

veya:

> “Bunlar SOUL'un üç yeni katmanı mıdır?”

değildir.

Daha doğru soru:

> **Context, memory ve harness engineering hangi farklı mühendislik problemlerini adlandırıyor; nerede örtüşüyorlar; mevcut RAG / Knowledge Graph / Fine-Tuning / CAG / Long Context araştırmasının hangi sonuçlarını yeniden çerçeveliyorlar; SOUL ve Development OS açısından hangi karar sınırlarını görünür hale getiriyorlar?**

---

## 2. Terminoloji güveni eşit değil

### 2.1. Context Engineering

“Context engineering” 2025 itibarıyla güçlü biçimde yerleşen pratik bir terimdir. Anthropic bunu, her model çağrısında sınırlı context budget içine hangi token/state'in gireceğini ve hangi davranışı doğuracağını optimize etme problemi olarak açıkça tanımlar.

Bu nedenle bu pakette terim yüksek güvenle kullanılabilir.

### 2.2. Harness Engineering

“Harness engineering” 2026'da hızla kurumsallaşan bir terimdir. OpenAI bunu agent-first software development'ta modelin çevresindeki environment, tooling, feedback loops, repository knowledge ve enforceable constraints tasarımı üzerinden kullanır. 2026 tarihli güncel bir source-code study ayrıca coding agent'ı `model + harness` şeklinde ayırır ve harness'i loop, tools, context management, safety, orchestration ve extension surfaces içeren runtime olarak tanımlar.

Terim gençtir; ancak artık yalnız tek bir blog ifadesi değildir.

### 2.3. “Memory Engineering”

Burada daha dikkatli olmak gerekir.

**Agent memory** yerleşik bir araştırma problemidir; multi-session memory, episodic/semantic/procedural memory, retrieval, consolidation, forgetting, temporal update ve persistent state üzerine geniş literatür vardır.

Fakat **“Memory Engineering”** adı Context Engineering veya Harness Engineering kadar standardize değildir. 2026 practitioner materialinde bu ad giderek daha sık kullanılmakta ve Oracle developer materialinde Context / Memory / Harness üçlüsü açıkça ayrı disiplinler olarak sunulmaktadır. Buna rağmen akademik literatür çoğunlukla `agent memory`, `memory mechanisms`, `long-term memory`, `memory systems` gibi adlar kullanır.

Bu nedenle package boyunca:

> **“Memory Engineering” = agent memory systemlerinin tasarım ve işletim disiplini için yararlı, fakat henüz tam yerleşmiş olmayan pratik etiket**

olarak ele alınacaktır.

Terminoloji olgunluğunu problem olgusunun gerçekliğiyle karıştırmıyoruz: ad yeni olabilir; persistent memory lifecycle problemi yeni değildir.

---

## 3. Mevcut AI Knowledge Strategies paketiyle neden birlikte değerlendirilmeli?

`research/ai-knowledge-strategies/` şu beş mekanizmayı ayrı ayrı araştırdı:

- RAG
- Knowledge Graph
- Fine-Tuning
- Cache-Augmented Generation (CAG)
- Long Context

Bu araştırmaların ortak sonucu şuydu:

> Beş mekanizma eş düzey, birbirini dışlayan “knowledge architecture seçenekleri” değildir.

Yeni araştırma bu sonucu daha üst bir sistem çerçevesine yerleştirme fırsatı sunuyor.

İlk çalışma haritası:

```text
Context Engineering
    ├─ RAG'dan gelen evidence'in context'e seçilmesi
    ├─ Long Context ile whole-package working set
    ├─ CAG / prompt caching ile repeated context reuse
    ├─ memory read sonuçlarının injection'ı
    ├─ tool outputs / conversation / instructions
    └─ compaction, ordering, pruning, isolation

Agent Memory Engineering
    ├─ ne yazılacak?
    ├─ nasıl temsil edilecek?
    ├─ ne zaman güncellenecek / supersede edilecek?
    ├─ ne unutulacak?
    ├─ ne zaman geri çağrılacak?
    ├─ RAG / graph / file / DB / episodic log gibi substrates
    └─ provenance, temporal validity, authority, privacy

Harness Engineering
    ├─ agent loop
    ├─ tools / Agent-Computer Interface
    ├─ context assembly policy
    ├─ memory read/write triggers
    ├─ permissions / guardrails / sandbox
    ├─ orchestration / handoff / subagents
    ├─ retries / budgets / stop conditions
    ├─ observability / tracing
    ├─ verification / evaluator loops
    └─ persistent work artefacts / recovery

Model adaptation layer
    └─ Fine-Tuning / parametric behavior adaptation
```

Bu harita **architecture proposal değildir**. Araştırmanın sınanacak başlangıç framing'idir.

---

## 4. En kritik başlangıç düzeltmesi: üçlü temiz bir “stack” olmayabilir

Üç kavramı üç bağımsız katman gibi çizmek öğretici olabilir, fakat teknik olarak fazla temizdir.

### Context ile memory iç içedir

Memory'nin **read** tarafı sonunda context üretir. Persist edilmiş bilgi model tarafından ancak:

- retrieve edilirse,
- seçilirse,
- doğru sırayla/formatta context'e girerse

inference'ı etkiler.

Dolayısıyla memory availability ile memory utilization aynı şey değildir.

### Harness ikisini de kapsayabilir

Harness'in geniş tanımlarında context management ve memory/session management harness'in alt sistemleridir.

Bu nedenle:

```text
Context Engineering
Memory Engineering
Harness Engineering
```

üç eş düzey ve birbirinden bağımsız kutu olarak düşünülmemelidir.

Daha ihtiyatlı hipotez:

> **Context ve memory ayrı failure surfaces taşıyan mühendislik problemleridir; harness ise çoğu gerçek sistemde bu problemleri işleten, bağlayan ve sınırlandıran daha geniş runtime/control substrate'ıdır.**

Bu hipotez sonraki dosyalarda sınanacaktır.

---

## 5. SOUL açısından neden önemli?

SOUL'un hedefi yalnız iyi cevap veren bir model değil, intended outcome için gereken controlled ve verifiable working system'i oluşturabilen general-purpose agentic architecture ise model seçiminin ötesindeki sistem soruları yük taşıyacaktır.

Örneğin bir SOUL Work için şu üç soru ayrı ayrı doğru cevaplanmalıdır:

### A. Working context problemi

> Bu model çağrısında hangi bilgi gerçekten görünür olmalı?

Yanlış cevap:
- gerekli evidence yok,
- çok gürültü var,
- historical/current karışmış,
- tool output aşırı büyük,
- kritik instruction context'in içinde kaybolmuş.

### B. Persistence / memory problemi

> Bu Work sırasında öğrenilen veya değişen hangi bilgi sonraki adımlara/session'lara taşınmalı?

Yanlış cevap:
- kritik karar unutulur,
- eski bilgi current sanılır,
- transient scratch kalıcı truth olur,
- contradiction çözülmeden memory'ye promote edilir,
- sensitive state gereksiz tutulur.

### C. Harness / operating-system problemi

> Agent hangi loop, tools, permissions, evaluators, budgets ve recovery mekanizmaları içinde çalışmalı?

Yanlış cevap:
- doğru context ve memory olsa bile yanlış tool çağrılır,
- verifier hiç koşmaz,
- retry loop kontrolden çıkar,
- permission sınırı uygulanmaz,
- work session'lar arasında düzgün handoff olmaz,
- sistem failure'ı görünmez biçimde sürdürür.

Bu üç failure aynı dış semptomu — “agent yanlış yaptı” — üretebilir. Ayrım diagnosis için değerlidir.

---

## 6. Development OS açısından neden önemli?

Development OS zaten bu problem uzayının yaşayan bir örneğidir.

Mevcut repository yaklaşımında:

- canonical files persistent state taşır;
- `STATE / INDEX / handoff` yüzeyleri fresh session recovery sağlar;
- progressive retrieval tüm repository'yi körlemesine context'e yüklemek yerine gerekli source depth'i seçer;
- agent-control routing hangi protokollerin yükleneceğini belirler;
- verification, continuity ve source-view fidelity ayrı kontrollerdir;
- repository state chat history/model memory'den üstün source-of-truth olarak tutulur.

Bunlar doğrudan “SOUL kesin şu harness architecture'ını kullanmalı” sonucu vermez.

Fakat yeni araştırma şu soruyu daha net sormamızı sağlar:

> **Development OS'nin bugün dosyalar, retrieval, protocols ve repository continuity ile yaptığı işler context, memory ve harness problem uzayının hangi kısımlarını zaten çözüyor; hangi kısımları yalnız temsil ediyor ama runtime'da enforce etmiyor; hangi kısımlar hâlâ açık?**

Bu ayrım özellikle önemlidir çünkü:

> bir kuralın repository'de yazılı olması ≠ harness'in o kuralı her gerekli çalışma kipinde gerçekten enforce etmesi.

---

## 7. Araştırmanın ana soruları

Bu paket şu sorulara cevap vermeye çalışacaktır:

1. Context Engineering'in minimum ve geniş tanımı nedir?
2. Prompt Engineering, RAG, Long Context, compaction ve memory injection bunun neresindedir?
3. Agent memory'yi storage'dan ayıran lifecycle nedir?
4. Memory'nin write, update, supersede, consolidation, forgetting ve read aşamalarında hangi failure mode'lar oluşur?
5. Memory ile canonical project state aynı şey midir; değilse hangi ayrımlar gerekir?
6. Harness'in minimum sınırı nedir: loop + tools mı, yoksa repository/process/evaluation environment da dahil midir?
7. Tool/ACI tasarımı agent performansını model değişmeden ne kadar etkileyebilir?
8. Harness'in context ve memory üzerinde hangi control responsibility'si vardır?
9. Model capability arttığında harness'in hangi parçaları stale assumption'a dönüşebilir?
10. Verification ve observability harness'in first-class parçası mıdır?
11. Mevcut beş AI knowledge mekanizması bu üç problem alanına nasıl haritalanır?
12. Fine-Tuning neden bu üçlüye tam oturmaz?
13. SOUL için task-specific working system formation açısından hangi selection logic soruları ortaya çıkar?
14. Development OS'nin mevcut repository-authoritative yaklaşımının hangi yönleri güçlü, hangi yönleri sınırlıdır?
15. Bu araştırma hangi architecture kararlarını **vermek için henüz yeterli değildir**?

---

## 8. Araştırma yöntemi

Kaynaklar dört sınıfta değerlendirilecektir:

### A. Primary engineering sources

- Anthropic — context engineering ve long-running harness çalışmaları
- OpenAI — harness engineering ve Agents SDK runtime/control surfaces

### B. Peer-reviewed / academic agent-system evidence

- agent memory surveys ve benchmarks
- MemGPT / virtual context management
- SWE-agent / Agent-Computer Interface
- long-context ve retrieval failure literature gerektiğinde

### C. Current 2026 emerging research

- harness source-code studies
- yeni agent-memory surveys

Bu kaynaklar current fakat bazıları preprint'tir; peer-reviewed sonuç gibi aşırı genellenmeyecektir.

### D. Existing repository research

`research/ai-knowledge-strategies/` bulguları yeni araştırma için input'tur; dış kaynak yerine geçmez. Yeni package bu bulguları sistem-seviyesi framing altında yeniden değerlendirir.

---

## 9. Package plan

Bu package şu dosyalardan oluşacaktır:

1. `00-WHY-THIS-RESEARCH.md` — mevcut dosya; rationale ve sınır
2. `01-CONTEXT-ENGINEERING.md` — context formation, attention budget, retrieval/compaction/tool-output/context isolation
3. `02-AGENT-MEMORY-ENGINEERING.md` — persistent memory lifecycle ve governance
4. `03-HARNESS-ENGINEERING.md` — runtime, tools, controls, feedback, verification, long-running continuity
5. `04-CROSS-LAYER-SYNTHESIS.md` — üç alanın birbirleriyle ve mevcut beş mekanizmayla ilişkisi; SOUL / Development OS değerlendirmesi
6. `STATE.md` — current package status / handoff
7. `INDEX.md` — retrieval router

Bu sıra architecture tasarım sırası değildir; araştırma okunabilirliği içindir.

---

## 10. Başlangıç hipotezleri — bulgu değildir

### H1 — Üçlü yararlı bir diagnostic decomposition'dır, fakat settled universal taxonomy değildir

Context ve harness terimleri daha güçlü yerleşmiştir; “Memory Engineering” adı daha yenidir. Ayrıca sınırlar gerçek sistemlerde örtüşür.

### H2 — Context Engineering'in ana nesnesi persistent bilgi değil, **current model-visible working set**'tir

RAG, Long Context, CAG, memory retrieval ve tool-output shaping bunun farklı mechanisms'ıdır.

### H3 — Agent memory'nin ana nesnesi storage değil, **state over time** yaşam döngüsüdür

Write/read kadar update, contradiction, consolidation, forgetting, authority ve provenance da yük taşıyabilir.

### H4 — Harness geniş anlamda context ve memory'yi işleten outer control/runtime substrate olabilir

Bu nedenle Harness Engineering Context/Memory Engineering ile tamamen eş düzey bağımsız bir layer olmayabilir.

### H5 — Fine-Tuning bu üçlü içinde zorla sınıflandırılmamalıdır

Fine-Tuning model parametre/adaptation layer'ındadır; harness tarafından seçilebilir/govern edilebilir fakat context veya external memory mekanizması değildir.

### H6 — Development OS mevcut haliyle üç problem alanına da dokunmaktadır

Repository state → persistence; progressive retrieval → context formation; protocols/tools/verification/continuity → harness-like controls. Ancak dosya düzeyindeki kural ile runtime enforcement aynı değildir.

### H7 — En güçlü SOUL sonucu sabit bir üç-katman mimarisi değil, problem-condition-dependent system formation olabilir

Task'a göre memory substrate, context strategy, tool interface, verification intensity ve orchestration değişebilir.

---

## 11. Architecture sınırı

Bu package şunları **yetkilendirmez veya kanıtlamaz**:

- SOUL'un final architecture'ı Context / Memory / Harness üç katmanından oluşmalıdır.
- Development OS mevcut haliyle tam bir agent harness'tir.
- SOUL mutlaka persistent agent memory kullanmalıdır.
- Knowledge Graph memory'nin zorunlu representation'ıdır.
- RAG memory engineering ile eş anlamlıdır.
- Long Context context engineering'in tamamıdır.
- CAG memory sistemidir.
- Fine-Tuning gereksizdir.
- Repository bütün memory'nin tek store'u olmalıdır.
- Mevcut agent-control files production runtime enforcement'ın yerine geçer.
- “Memory Engineering” settled akademik taxonomy'dir.

Araştırmanın işi technology/architecture seçmek değil, **problem sınırlarını ve decision boundaries'i doğru görmek**tir.

---

## 12. Başlangıç kaynakları

### Context Engineering

**[C1] Anthropic (2025). _Effective context engineering for AI agents_.**  
https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents  
Use: context = inference-time token/state set; context utility optimization; just-in-time retrieval; compaction; structured note-taking/agent memory; sub-agent isolation.  
Limit: organization-authored engineering guidance; universal taxonomy değildir.

### Agent Memory

**[M1] Du, P. et al. (2026). _Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers_.**  
https://arxiv.org/abs/2603.07670  
Use: memory as write–manage–read loop; temporal scope / substrate / control-policy taxonomy; contradiction, latency, privacy, forgetting.  
Limit: current survey / preprint.

**[M2] Zhang, Z. et al. (2024). _A Survey on the Memory Mechanism of Large Language Model based Agents_.**  
https://arxiv.org/abs/2404.13501  
Use: established agent-memory problem space.

**[M3] Wu, D. et al. (2024). _LongMemEval: Benchmarking Chat Assistants on Long-Term Interactive Memory_.**  
https://arxiv.org/abs/2410.10813  
Use: extraction, multi-session reasoning, temporal reasoning, knowledge updates, abstention; indexing/retrieval/reading decomposition.

**[M4] Packer, C. et al. (2023). _MemGPT: Towards LLMs as Operating Systems_.**  
https://arxiv.org/abs/2310.08560  
Use: virtual context management and data movement between memory tiers.

**[M5] Oracle Developer Relations (2026). _Building a Memory-First Agent Harness / Developer Week Memory Engineering material_.**  
https://oracle-devrel.github.io/oracle-ai-developer-hub/guides/memory_engineering_devweek_sf_2026.pdf  
Use: current practitioner evidence that Context / Memory / Harness terminology is being used together.  
Limit: practitioner material; terminology standardization kanıtı değildir.

### Harness Engineering / Agent Runtime

**[H1] OpenAI (2026). _Harness engineering: leveraging Codex in an agent-first world_.**  
https://openai.com/index/harness-engineering/  
Use: environment/scaffolding, repository as system of record, progressive disclosure, agent legibility, mechanical enforcement, feedback loops and entropy management.  
Limit: specific internal software-development experience; universal production law değildir.

**[H2] Anthropic (2025). _Effective harnesses for long-running agents_.**  
https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents  
Use: multi-session continuity, initializer/coding-agent split, explicit progress artifacts and incremental work.

**[H3] Anthropic (2026). _Harness design for long-running application development_.**  
https://www.anthropic.com/engineering/harness-design-long-running-apps  
Use: planner/generator/evaluator loops, harness ablation, model-dependent scaffolding, re-evaluation after model upgrades.

**[H4] Barbaste, P. et al. (2026). _Harness Engineering: Anatomy, Architecture, and Evolution of Coding Agents — A Source-Code Study of Eleven Systems_.**  
https://arxiv.org/abs/2609.00006  
Use: current empirical harness definition and subsystem comparison.  
Limit: fresh preprint; coding-agent-focused; not final cross-domain taxonomy.

**[H5] Yang, J. et al. (2024). _SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering_. NeurIPS 2024.**  
https://arxiv.org/abs/2405.15793  
Use: tool/interface design can materially affect agent performance with the model held broadly constant.

**[H6] OpenAI Agents SDK documentation (current read 2026-09-03).**  
https://openai.github.io/openai-agents-python/agents/  
https://openai.github.io/openai-agents-js/guides/sessions/  
https://openai.github.io/openai-agents-js/guides/guardrails/  
https://openai.github.io/openai-agents-js/guides/tracing/  
Use: concrete runtime surfaces: tools, handoffs, sessions, guardrails, lifecycle hooks, tracing.  
Limit: implementation/framework documentation; architecture evidence değil.

---

## 13. Current handoff

**Completed:** research rationale and scope.  
**Next research object:** Context Engineering.  
**Architecture decision:** none.  
**Foundation-tree effect:** none.  
**Important boundary:** the three labels will be researched as overlapping engineering problem domains, not assumed to be three mandatory SOUL architecture layers.