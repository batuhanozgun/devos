# Context Engineering — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Research object:** inference-time working-context formation and maintenance for LLM/agent systems  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to AI Knowledge Strategies:** cross-layer interpretation of RAG / CAG / Long Context and memory read paths  
**Verification status:** cross-source synthesis; no local SOUL/Development OS context benchmark executed

---

## 1. Araştırma sorusu

> **Context Engineering tam olarak neyi optimize eder, prompt engineering'den nasıl ayrılır, retrieval/memory/tools/compaction/long-context gibi mekanizmaları nasıl bir araya getirir ve SOUL / Development OS açısından context correctness hangi failure yüzeylerine sahiptir?**

Bu dosya şu sorularla aynı değildir:

- “En iyi system prompt nasıl yazılır?”
- “Context window kaç token?”
- “RAG kullanmalı mıyız?”
- “Bütün repository'yi modele verelim mi?”
- “Memory varsa context problemi çözülmüş olur mu?”

---

## 2. Minimum tanım

Anthropic'in 2025 engineering framing'i context'i, model sampling sırasında mevcut olan token seti olarak; context engineering'i ise bu tokenların sınırlı model kapasitesi altında utility'sini optimize etme problemi olarak ele alır. [S1]

Bu araştırma için daha operasyonel tanım:

> **Context Engineering = her model inference/agent step'inde model-visible working set'in hangi bilgi, instruction, state, tool result, memory, evidence ve metadata'dan oluşacağını; bunların ne kadar, hangi sırada, hangi fidelity ile ve hangi trust/authority işaretleriyle sunulacağını tasarlama ve yönetme disiplini.**

Bu tanımın kritik tarafı `model-visible` ifadesidir.

Bir bilgi:

- database'de mevcut olabilir,
- repository'de mevcut olabilir,
- memory store'da mevcut olabilir,
- web'de mevcut olabilir,

ama current inference'ta modele doğru biçimde getirilmiyorsa **working context açısından yoktur**.

---

## 3. Prompt Engineering ile ayrım

Prompt Engineering çoğunlukla instruction'ın kendisini optimize eder:

```text
role
objective
constraints
examples
output format
```

Context Engineering ise daha geniş working-state problemini kapsar:

```text
instructions
+ current user/task state
+ retrieved evidence
+ memory recall
+ tool schemas
+ tool outputs
+ conversation/history
+ source metadata
+ intermediate artefacts
+ summaries/compaction
+ subagent outputs
```

Dolayısıyla:

> **Her prompt context'in parçasıdır; her context problemi prompt problemi değildir.**

Prompt wording kusursuz olsa bile yanlış source set'i, stale memory, aşırı tool output veya historical/current karışımı answer'ı bozabilir.

---

## 4. Context Engineering neden “daha fazla context” değildir?

Anthropic'in temel çerçevesi context'i finite resource olarak görür. OpenAI'nin 2026 harness engineering deneyimi de giant instruction file yaklaşımının task/code/relevant docs'u crowd-out ettiğini, her şey önemli olduğunda agent'ın doğru navigasyonu kaybettiğini raporlar. [S1][S2]

Bu nedenle objective:

```text
maximize tokens loaded
```

değil:

```text
maximize decision-relevant signal
subject to:
  attention / token / latency / cost / trust constraints
```

olmalıdır.

### 4.1. Context completeness ve context minimality gerilimlidir

Çok az context:
- critical evidence omission,
- missing constraints,
- wrong assumptions.

Çok fazla context:
- distraction,
- authority ambiguity,
- long-context degradation,
- stale/historical contamination,
- token/latency cost.

Dolayısıyla context engineering bir **selection problem** kadar bir **exclusion problem**'dir.

---

## 5. Context'in kaynak sınıfları

Bir agent call'daki context tek tür değildir.

### 5.1. Control / instruction context

- system/developer instructions,
- policy,
- task constraints,
- tool use rules,
- acceptance criteria.

### 5.2. Current work state

- current goal,
- current phase,
- unresolved questions,
- next authorised action,
- active plan/progress.

### 5.3. External evidence

- source documents,
- web results,
- repository files,
- database rows,
- API responses.

### 5.4. Memory recall

- prior decisions,
- persistent notes,
- user/project facts,
- episodes,
- learned procedures.

### 5.5. Tool interface context

- available tool names,
- schemas,
- affordances,
- permissions,
- tool descriptions.

### 5.6. Tool result context

- command outputs,
- logs,
- traces,
- search results,
- test outputs.

### 5.7. Derived context

- summaries,
- retrieval snippets,
- graph views,
- compressed histories,
- sub-agent syntheses.

Her sınıf farklı fidelity/freshness/authority problemine sahiptir.

---

## 6. Context retrieval ve “just in time” loading

Anthropic 2025, pre-loading everything yerine agent'ın lightweight references — file paths, links, stored queries — taşıyıp gerektiğinde tool kullanarak veriyi context'e getirdiği `just in time` stratejilerini vurgular. [S1]

Bu mevcut `research/ai-knowledge-strategies/01-RAG.md` sonucuyla güçlü biçimde uyumludur:

> retrieval'ın değeri yalnız vector similarity değildir; **working context'e hangi evidence'in ne zaman gireceğini yönetmek**tir.

Bu nedenle RAG Context Engineering'in bir mekanizması olabilir, fakat Context Engineering = RAG değildir.

Aynı context builder:

- exact path read,
- keyword search,
- semantic retrieval,
- graph traversal,
- API query,
- human clarification

arasında seçim yapabilir.

---

## 7. Retrieval correctness tek başına context correctness değildir

Retriever doğru document'i bulsa bile context şu nedenlerle bozulabilir:

- chunk qualifier'ı kesilmiş,
- source title/path/version düşmüş,
- authority metadata yok,
- retrieved 20 chunk içinde kritik chunk dikkat açısından gömülmüş,
- historical document current document'dan daha semantically relevant,
- duplicate snippets token budget'i doldurmuş,
- query rewrite problem framing'i kaydırmış.

Dolayısıyla pipeline:

```text
source selection
→ retrieval
→ rerank/filter
→ context assembly
→ model use
```

her aşamada ayrı doğrulama ister.

---

## 8. Long Context Context Engineering'i ortadan kaldırmaz

`05-LONG-CONTEXT.md` araştırmasının ana sonucu:

> accepted context capacity ≠ workload-effective context.

Long Context büyüdükçe context engineering şu sorulardan kurtulmaz:

- hangi sources eligible?
- current vs historical nasıl ayrılacak?
- hangi order?
- metadata nasıl korunacak?
- duplicate/conflict nasıl işaretlenecek?
- permission filter nerede?
- source boundaries görünür mü?
- untrusted instructions data'dan ayrılıyor mu?

Hatta bütün corpus sığdığında selection problemi kısmen **prioritization ve authority problemine** dönüşebilir.

Bu nedenle:

> **Long Context context engineering'in kapasite sınırını iter; context engineering ihtiyacını kaldırmaz.**

---

## 9. CAG / caching Context Engineering içindeki yeri

`04-CAG.md` narrow Cache-Augmented Generation'i repeated bounded long context + reusable KV state olarak araştırdı.

Context Engineering açısından CAG şu soruyu çözer:

> Aynı verified/stable working context tekrar kullanılıyorsa prefill computation nasıl amortize edilir?

Fakat cache:

- source authority üretmez,
- freshness garanti etmez,
- context correctness doğrulamaz,
- dynamic state'i current yapmaz.

Dolayısıyla CAG **context reuse mechanism**'idir; context governance'ın yerine geçmez.

---

## 10. Memory ile sınır: read path context'e dönüşür

Anthropic structured note-taking'i agentic memory olarak tanımlar: agent context dışına persistent notes yazar ve daha sonra bunları tekrar context'e çeker. [S1]

Bu bize net bir boundary verir:

```text
Memory Engineering
  write / update / consolidate / retain / forget
                ↓
        recall candidates
                ↓
Context Engineering
  select / rank / compress / frame / inject
                ↓
             LLM call
```

Gerçekte iki alan feedback loop ile bağlıdır, fakat failure diagnosis için ayrım değerlidir.

Örneğin agent eski preference kullandıysa:

- memory yanlış mı güncellendi?
- retrieval yanlış memory'yi mi seçti?
- context builder current override'ı mı düşürdü?
- model doğru context'i yanlış mı kullandı?

aynı şey değildir.

---

## 11. Compaction: lossy transformation olarak ele alınmalı

Anthropic compaction'ı context window dolarken history'yi high-fidelity özetleyip yeni context window başlatma yöntemi olarak tarif eder. Aynı kaynak, aşırı agresif compaction'ın ancak daha sonra önemli olduğu anlaşılan subtle context'i kaybedebileceğini açıkça belirtir. [S1]

Dolayısıyla compaction:

```text
large trace
→ summary
```

şeklinde neutral compression değildir.

Bu bir **derived view** üretir ve şu testlere ihtiyaç duyar:

- load-bearing decisions korundu mu?
- unresolved issues korundu mu?
- negatives / rejected alternatives kayboldu mu?
- source references korundu mu?
- uncertainty certainty'ye dönüştü mü?
- authority/status labels korundu mu?

Development OS açısından bu doğrudan source-view fidelity problemine dokunur.

---

## 12. Tool output shaping de Context Engineering'dir

SWE-agent çalışması agent-computer interface'in nasıl context verildiğini model performansını etkileyen first-class design variable olarak gösterir. Örneğin repository search sonuçlarını kısa özetlemek ve file viewer'ı sınırlı satırlarla sunmak agent'ın davranışını iyileştiren interface seçimleridir. [S3]

Bu önemli bir genişletmedir:

> **Context Engineering yalnız “hangi document?” değil, tool'un observation'ı modele hangi shape'te verdiği problemidir.**

Aynı raw environment farklı interface ile farklı model performance üretebilir.

Bu harness ile doğrudan overlap alanıdır.

---

## 13. Sub-agent isolation: context partitioning

Anthropic sub-agent architecture'larını context limitations için bir yöntem olarak tartışır: specialist sub-agent geniş araştırma context'i kullanır, ana agent'a condensed result döndürür. [S1]

Bu iki fayda sağlayabilir:

- lead agent'ın context pollution'ını azaltmak;
- task-specific clean context vermek.

Ancak yeni failure mode üretir:

```text
subagent source context
→ summary
→ lead context
```

Burada source fidelity ve omission iki kez test edilmelidir.

Sub-agent sayısı otomatik reliability değildir.

---

## 14. Context ordering ve salience

Long-context literature position-dependent performance gösterdiği için context order yalnız formatting konusu değildir.

Candidate ordering dimensions:

- control before untrusted data,
- current canonical before historical alternatives,
- source identity adjacent to content,
- task-local evidence near relevant question,
- conflicting evidence explicitly grouped,
- large low-value tool outputs pruned or referenced.

Fakat bunlar universal fixed ordering rule'a dönüştürülmemelidir; workload-specific benchmark gerekir.

---

## 15. Context pollution ve contamination

Context zamanla şu maddelerle kirlenebilir:

- obsolete plans,
- already-resolved errors,
- failed tool attempts,
- superseded source text,
- verbose logs,
- copied instructions from untrusted documents,
- repeated summaries,
- model-generated unsupported claims.

Context pollution iki risk üretir:

1. attention budget waste;
2. **epistemic status collapse** — source, inference, plan ve speculation aynı text surface'te görünür.

Bu nedenle context cleanup yalnız token optimization değildir.

---

## 16. Context security / trust boundary

Context'e giren external content model davranışını yönlendirebilir.

Bu nedenle context item'ları en azından zihinsel olarak şu sınıflara ayrılmalıdır:

```text
trusted control instruction
trusted canonical state
trusted/verified source evidence
untrusted external content
model-generated derived content
user-provided claim/preference
```

Bir external document içinde “ignore previous instructions” bulunması o text'i control instruction yapmaz.

Bu ayrım harness-level tool/permission guardrail ile desteklenmelidir; prompt label tek başına enforcement değildir.

---

## 17. Context evaluation nasıl yapılmalı?

### 17.1. Sufficiency / recall

Critical evidence gerçekten context'e girdi mi?

### 17.2. Precision / noise

Context'te decision-irrelevant volume ne kadar?

### 17.3. Authority correctness

En relevant source yerine current/authoritative source korunuyor mu?

### 17.4. Freshness

Mutable state doğru revision'da mı?

### 17.5. Fidelity

Summary/chunk/tool output source anlamını koruyor mu?

### 17.6. Position robustness

Aynı load-bearing evidence farklı context locations'ta kullanılıyor mu?

### 17.7. Conflict robustness

Current canonical + plausible historical contradiction birlikteyken doğru status korunuyor mu?

### 17.8. Context budget curve

Quality yalnız max token'da değil farklı budget'larda ölçülmeli.

### 17.9. Negative control

Context'ten load-bearing evidence çıkarıldığında test kırmızı veriyor mu? Aksi halde test cevap shortcut'ını ölçüyor olabilir.

### 17.10. Security

Untrusted instruction-like content control davranışını değiştirebiliyor mu?

---

## 18. SOUL açısından değerlendirme

SOUL için Context Engineering'in güçlü rolü:

> **intended outcome ve current Work'e göre model-visible working set'i dynamically kurmak.**

Bu bir technology seçimi değildir.

Bir task'ta context builder:

- exact canonical source read,
- RAG,
- graph neighborhood,
- long-context package,
- cached stable prefix,
- memory recall,
- tool observation

kombinasyonunu kullanabilir.

Bu SOUL'un generality hedefiyle uyumludur çünkü mechanism task condition'a göre seçilebilir.

### Candidate SOUL context gate

1. Bu model call hangi kararı/eylemi üretecek?
2. Hangi bilgi gerçekten load-bearing?
3. Kaynak authority/freshness nedir?
4. Bu bilgi current context'te zaten var mı?
5. Retrieve mi, direct read mi, full package mı daha uygun?
6. Derived view yeterli mi, source recovery gerekli mi?
7. Context bütçesi ne?
8. Untrusted content var mı?
9. Tool output nasıl shape edilmeli?
10. Memory recall current state ile conflict ediyor mu?
11. Context sufficiency nasıl falsify edilecek?

Bu **architecture specification değildir**; decision frame'dir.

---

## 19. Development OS açısından değerlendirme

Development OS'nin mevcut progressive retrieval yaklaşımı Context Engineering açısından güçlü bir örnektir:

```text
AGENT/router
→ current STATE
→ INDEX
→ relevant package
→ synthesis/finding
→ load-bearing source recovery
```

Bu sistem yalnız context-window limitation workaround değildir. Aynı zamanda:

- authority routing,
- freshness,
- current vs historical discrimination,
- information prioritization,
- bounded source loading

yapar.

OpenAI'nin harness engineering deneyiminde giant instruction manual yerine short map + structured repo system-of-record + progressive disclosure'a geçiş bu yönde bağımsız practitioner evidence sağlar. [S2]

### Ama önemli sınır

Repository'de iyi routing olması, runtime'ın onu her seferinde uyguladığını otomatik kanıtlamaz.

Bu nedenle Dev OS açısından context engineering iki parçaya ayrılır:

```text
context information architecture
+
context-loading enforcement
```

İlki repo ile kurulabilir; ikincisi harness/runtime coverage problemidir.

---

## 20. Decision boundary

### Use Context Engineering lens when

- agent yanlış source'a dayanıyor,
- important context kayboluyor,
- context aşırı büyüyor,
- retrieval var ama output hâlâ yanlış,
- memory var ama doğru zamanda görünmüyor,
- historical/current karışıyor,
- tool outputs modeli boğuyor,
- long-running task'ta compaction sonrası drift oluşuyor,
- subagent handoff'ta critical detail kayboluyor.

### Context Engineering tek başına yetmez when

- doğru context var ama tool permission yanlış,
- memory write yanlış/fraudulent bilgi persist ediyor,
- model capability task için yetersiz,
- verifier hiç çalışmıyor,
- external action side effect güvenli değil,
- persistent state update edilmiyor.

Bunlar memory, harness, model adaptation veya environment problemleri olabilir.

---

## 21. Bulgular

### F-CTX-01 — Context Engineering'in ana nesnesi current model-visible working set'tir

**Confidence:** high  
**Basis:** Anthropic context engineering definition + current agent systems practice. [S1]

### F-CTX-02 — Context Engineering Prompt Engineering'den geniştir

**Confidence:** high  
**Basis:** retrieval, tool state, memory, compaction ve subagent context mekanizmaları. [S1][S3]

### F-CTX-03 — “More context” güvenilir default değildir

**Confidence:** high  
**Basis:** Anthropic context-budget framing, OpenAI repository guidance, existing long-context evidence. [S1][S2]

### F-CTX-04 — RAG bir Context Engineering mechanism'i olabilir; ikisi eş anlamlı değildir

**Confidence:** high as synthesis  
**Basis:** RAG pipeline + context assembly distinction; `01-RAG.md`.

### F-CTX-05 — Memory'nin read path'i Context Engineering'e bağlanır

**Confidence:** high  
**Basis:** persisted notes/memory recalled into context; agent-memory designs. [S1]

### F-CTX-06 — Long Context context engineering'i ortadan kaldırmaz

**Confidence:** high  
**Basis:** `05-LONG-CONTEXT.md` + context construction requirements.

### F-CTX-07 — CAG context correctness değil, repeated-context compute/reuse mechanism'idir

**Confidence:** high  
**Basis:** `04-CAG.md`.

### F-CTX-08 — Tool observation shape context quality'nin first-class parçasıdır

**Confidence:** high  
**Basis:** SWE-agent ACI evidence. [S3]

### F-CTX-09 — Compaction ve sub-agent summaries derived views'dur; omission/fidelity riski taşır

**Confidence:** high  
**Basis:** Anthropic compaction/sub-agent guidance + source-view reasoning. [S1]

### F-CTX-10 — Development OS progressive retrieval Context Engineering açısından güçlü pattern'dir, fakat runtime enforcement ayrı problemdir

**Confidence:** high as project-specific synthesis  
**Basis:** current repo design + OpenAI progressive-disclosure evidence. [S2]

---

## 22. Açık sorular

1. SOUL Work classes için gerçek context budget dağılımları nedir?
2. Hangi Work'te retrieval, full package veya hybrid daha güvenilir?
3. Context source priority hangi metadata ile temsil edilmeli?
4. Historical/current conflicts real benchmark'ta ne kadar hata yaratıyor?
5. Compaction hangi fidelity threshold ile kullanılmalı?
6. Subagent summary'leri source refs taşımak zorunda mı?
7. Tool outputs için ideal truncation/shape workload'a göre nasıl belirlenmeli?
8. Context sufficiency için independent oracle nasıl kurulmalı?
9. Memory recall ile canonical state conflict'inde precedence nasıl belirlenecek?
10. Context security boundary runtime'da nasıl enforce edilecek?
11. Model upgrade context-selection policy'sini ne kadar invalidate eder?
12. Progressive retrieval'ın cost/quality frontier'i full-context ile nasıl karşılaştırılır?

---

## 23. Araştırma sınırları

- Local SOUL/Dev OS benchmark yapılmadı.
- Context ordering için universal rule ilan edilmedi.
- Anthropic/OpenAI engineering posts general law sayılmadı.
- Existing long-context results tüm future models'a sabitlenmedi.
- Context Engineering ile Prompt Engineering arasında kesin endüstri standardı formal boundary varmış gibi davranılmadı.
- Agent memory'yi yalnız context teknikleri içine indirgemedik.
- Runtime enforcement olmadan documentation correctness'ı operational guarantee saymadık.

---

## 24. Source ledger

**[S1] Anthropic (2025). _Effective context engineering for AI agents_.**  
https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents  
Use: context definition, finite-resource framing, just-in-time retrieval, compaction, structured note-taking/agentic memory, sub-agent context isolation.

**[S2] OpenAI (2026). _Harness engineering: leveraging Codex in an agent-first world_.**  
https://openai.com/index/harness-engineering/  
Use: giant AGENTS.md failure, repository system-of-record, short map, progressive disclosure, agent legibility and mechanical knowledge-base maintenance.  
Limit: internal coding-agent experience.

**[S3] Yang, J. et al. (2024). _SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering_. NeurIPS 2024.**  
https://arxiv.org/abs/2405.15793  
Use: agent-centric tool/observation design affects performance; concise search/view feedback.

**[S4] Existing package evidence:**  
`research/ai-knowledge-strategies/01-RAG.md`  
`research/ai-knowledge-strategies/04-CAG.md`  
`research/ai-knowledge-strategies/05-LONG-CONTEXT.md`  
Use: project-local previously researched mechanism boundaries. These are synthesis inputs, not independent external evidence.

---

## 25. Current handoff

**Completed:** Context Engineering bounded research.  
**Result:** Context Engineering is best understood as inference-time working-set formation and maintenance, not as prompt wording or maximum-context loading. Retrieval, Long Context, caching, memory recall, tool-output shaping, compaction and sub-agent isolation are mechanisms/inputs within this broader problem.  
**Key Development OS finding:** progressive retrieval is epistemically valuable beyond token saving, but repository routing and runtime enforcement must be distinguished.  
**Architecture decision:** none.  
**Next research object:** agent memory systems / “Memory Engineering”.