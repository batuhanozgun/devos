# Harness Engineering — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `02-AGENT-MEMORY-ENGINEERING.md`  
**Research object:** model-external runtime, interfaces, controls, orchestration, feedback and work-continuity mechanisms that turn an LLM into an operating agent system  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to AI Knowledge Strategies:** harness can select/govern context, memory, retrieval, graph, model adaptation and execution mechanisms; it is not a sixth peer “knowledge strategy”  
**Verification status:** cross-source synthesis; no local harness ablation, end-to-end reliability benchmark or production security test executed

---

## 1. Araştırma sorusu

> **Harness Engineering hangi model-external system responsibilities'ı kapsar, tool/interface/context/memory/verification/orchestration neden model capability kadar yük taşıyabilir, harness hangi failure mode'ları önlemeye çalışır ve SOUL / Development OS açısından mevcut repository-control yaklaşımı bu lens altında nasıl değerlendirilmelidir?**

Bu dosya şu sorularla aynı değildir:

- “Multi-agent kullanalım mı?”
- “Agent framework seçelim mi?”
- “System prompt ne olsun?”
- “Tool calling nasıl yapılır?”
- “Codex/Claude Code hangisi daha iyi?”
- “AGENT.md bir harness midir?”

---

## 2. Minimum tanım

2026 source-code study harness'i, LLM'yi dünya ile loop, tools, context management, safety controls, orchestration ve extension surfaces üzerinden bağlayan runtime olarak tanımlar. [S1]

OpenAI'nin “Harness engineering” framing'i problemi daha geniş operational seviyede ele alır: modelin faydalı iş yapabilmesi için environment, tools, abstractions, repository knowledge, feedback loops, observability ve enforceable architecture constraints tasarlanır. [S2]

Bu araştırma için:

> **Harness Engineering = model capability'sini güvenilir, bounded ve recoverable Work'e çevirmek için agent loop'u, tool/environment interfaces'ini, context/memory plumbing'ini, authority/permission controls'ü, orchestration'ı, verification/feedback loops'u, observability'yi ve persistent work artefacts'ını tasarlama ve sürekli yeniden kalibre etme disiplinidir.**

Bu tanım harness'i yalnız SDK/framework ile eşitlemez.

---

## 3. “Model + prompt + tools” neden eksik framing olabilir?

Bir model tool kullanabiliyor olabilir; fakat şu sorular açık kalır:

- hangi tool ne zaman görünür?
- tool description yeterli mi?
- tool input/output modeli doğru affordance'a yönlendiriyor mu?
- tool permission sınırı nerede uygulanıyor?
- side effect öncesi approval var mı?
- tool fail olduğunda retry policy ne?
- model yanlış completion ilan ederse kim test ediyor?
- next session current Work'i nasıl recover ediyor?
- context nereden ve hangi authority ile assemble ediliyor?
- memory ne zaman yazılıyor?
- run ne zaman duruyor/escalate ediyor?
- failure nasıl trace ediliyor?

Bu sorular modelin raw intelligence'ından çok **operating system around the model** problemidir.

---

## 4. Harness'in candidate subsystem'leri

Tek bir universal taxonomy yoktur. Farklı harness'ler farklı kapsam kullanır. Fakat current sources'tan tekrar eden problem yüzeyleri çıkarılabilir.

### 4.1. Agent loop / lifecycle

Minimum:

```text
observe/context
→ model reason/decide
→ act/tool/respond
→ observe result
→ continue/stop
```

Harness:
- max turns,
- stop conditions,
- timeout,
- retry,
- interruption/resume

gibi lifecycle semantics'i belirler.

### 4.2. Tool / Agent-Computer Interface

- tool set,
- schemas,
- feedback format,
- tool discovery,
- action granularity,
- error messages,
- environment access.

SWE-agent, model için özel ACI tasarımının repository navigation/edit/test performansını anlamlı biçimde etkilediğini gösterir. [S3]

### 4.3. Context management

- what enters each call,
- retrieval,
- compaction,
- tool-result shaping,
- source ordering,
- subagent context isolation.

Context Engineering burada harness'in bir subsystem/problem surface'i olabilir.

### 4.4. Session / memory state

- persist/resume,
- read/write triggers,
- checkpoints,
- handoff artefacts,
- current progress,
- learned memory.

### 4.5. Orchestration

- single-agent,
- manager + subagents,
- handoffs,
- parallel workers,
- planner/generator/evaluator,
- role-specific contexts.

### 4.6. Authority / guardrails / permissions

- allowed tools,
- approval gates,
- input/output/tool checks,
- sandboxing,
- least privilege,
- irreversible action boundaries.

### 4.7. Verification / feedback loops

- tests,
- evaluator agents,
- deterministic checks,
- acceptance criteria,
- rework loop,
- escalation.

### 4.8. Observability

- traces,
- logs,
- tool calls,
- cost/token use,
- guardrail outcomes,
- failure paths.

### 4.9. Work artefacts / system of record

- plans,
- progress files,
- decisions,
- repository state,
- feature checklist,
- evidence/handoff.

Bu özellikle long-running sessions için continuity substrate'dır.

---

## 5. Harness Engineering neden yalnız orchestration değildir?

Multi-agent orchestration harness'in bir parçası olabilir; fakat harness daha geniştir.

OpenAI'nin 2026 experience report'unda major leverage:

- app/log/metrics'i agent-readable yapmak,
- repo knowledge'ı system-of-record yapmak,
- giant instructions yerine progressive disclosure,
- custom linters ile architecture invariants enforce etmek,
- recurring doc gardening / cleanup,
- agent'ın real system'i boot/test edebilmesi

üzerinden gelir. [S2]

Bu nedenle yalnız:

```text
planner → coder → reviewer
```

çizmek Harness Engineering'in küçük bir kısmını gösterir.

---

## 6. Environment legibility first-class capability'dir

OpenAI deneyiminde early bottleneck model incapability değil, underspecified environment idi. Agent'ın gerekli tools, abstractions ve internal structure'a sahip olmaması progress'i sınırlıyordu. [S2]

Bu şu ayrımı destekler:

```text
model cannot solve
        vs
model cannot see / operate / verify environment
```

aynı failure değildir.

SOUL açısından bu özellikle önemli olabilir çünkü general-purpose agentic system farklı Work'lerde farklı Environment affordances'ına ihtiyaç duyar.

Harness lens şu soruyu sorar:

> Modelin görevi yapabilmesi için environment hangi capabilities'i **legible ve operable** hale getirmeli?

---

## 7. Tool interface model capability'yi çarpan etkisiyle değiştirebilir

SWE-agent'ın ACI araştırması tool/interface design'ın model davranışını maddi biçimde değiştirebildiğini gösterir. Search output'un concise olması, file viewer'ın bounded context göstermesi, syntax-invalid edit'in linter tarafından reddedilmesi gibi choices yalnız UX değildir; agent performance controls'üdür. [S3]

Bu nedenle:

> **Tool erişimi var/yok binary'si yetersizdir; action/observation interface'in şekli harness quality'nin parçasıdır.**

Bu aynı zamanda Context Engineering ile overlap'tir: tool output context üretir.

---

## 8. Repository “system of record” ve progressive disclosure

OpenAI giant `AGENTS.md` deneyiminin failure'ları:

- scarce context'i crowd out,
- too much guidance → no guidance,
- monolithic manual hızla stale olur,
- mechanical freshness/ownership/cross-link checks zordur.

Bunun yerine short map + structured `docs/` system-of-record + progressive disclosure + linters/doc-gardening kullanılmıştır. [S2]

Bu Development OS açısından güçlü bir independent engineering analogue'dur.

Ancak iki caveat gerekir:

1. OpenAI'nin sonucu coding-agent context'indedir; SOUL'a universal architecture law olarak taşınamaz.
2. Repository'de bilgi olması yeterli değildir; runtime'ın onu doğru durumda discover/load etmesi gerekir.

---

## 9. Documentation → enforcement ayrımı

Harness'in en kritik işlerinden biri desired behavior'ı yalnız text guidance olarak bırakmayıp mümkün olduğunda mekanik constraint'e çevirmektir.

OpenAI architecture dependency directions, logging conventions ve structural rules için custom lints/tests kullandığını raporlar. [S2]

Bu şu hierarchy'yi düşündürür:

```text
prose preference
< explicit protocol
< runtime guard/check
< deterministic invariant enforcement
```

Bu mutlak doğruluk hierarchy'si değildir; yalnız enforcement strength ayrımıdır.

### Önemli boundary

Her prose rule deterministic enforcement'a çevrilemez.

Örneğin:
- nuanced research framing,
- epistemic uncertainty,
- user intent,
- novel design trade-off

model judgment gerektirebilir.

Harness'in işi judgement'ı yok etmek değil; **mekanik olanı mekanikleştirmek ve judgement-required surface'i görünür bırakmak** olabilir.

---

## 10. Guardrails coverage problemi

OpenAI Agents SDK current docs input, output ve tool guardrails'i ayrı aileler olarak ele alır. Input/output agent-level guardrails'in workflow içinde her agent/tool'da otomatik koşmadığını; tool guardrails'in function-tool invocation etrafında çalıştığını açıkça belirtir. [S4]

Bu somut örnek şu genel ilkeyi gösterir:

> **Bir guardrail'in varlığı, bütün risk yollarında coverage olduğu anlamına gelmez.**

Harness verification şu soruyu sormalıdır:

- hangi action path guardrail'i bypass ediyor?
- handoff'ta policy devam ediyor mu?
- hosted/builtin tool farklı pipeline mı kullanıyor?
- side effect guardrail'den önce oluşabiliyor mu?
- output guardrail external effect'i geri alabiliyor mu?

Bu doğrudan verification-independence / coverage problemidir.

---

## 11. Verification harness'in first-class parçasıdır

Anthropic planner/generator/evaluator harness deneyiminde evaluator running application'ı acceptance criteria'ya karşı Playwright ile test edip concrete bugs üretir; solo run'ın kaçırdığı central functionality failure'larını yakalar. [S5]

Fakat aynı kaynak evaluator'ın da:

- legitimate issue'ları rationalize edip approve edebildiğini,
- superficial testing yapabildiğini,
- nested bugs kaçırabildiğini

raporlar. [S5]

Dolayısıyla:

> **Evaluator eklemek verification problem'i çözmek değildir; evaluator'ın oracle, coverage ve error sensitivity'si ayrıca doğrulanmalıdır.**

Multi-agent ≠ independent verification.

---

## 12. Long-running continuity: handoff bir harness capability'sidir

Anthropic'in 2025 long-running harness çalışması, context windows arasında her new session'ın previous work memory'si olmadan başlayabildiği problemi initializer + incremental coding agent + persistent artifacts ile ele alır. [S6]

Key pattern:

```text
initial environment / feature state
        ↓
agent works bounded increment
        ↓
commits/progress artefacts
        ↓
next fresh session recovers state
```

Bu Development OS'nin cold-start / handoff hedefiyle doğrudan karşılaştırılabilir.

Buradaki insight:

> long-running autonomy yalnız longer context değil, **recoverable external work state** gerektirir.

---

## 13. Harness ile Context Engineering ilişkisi

Harness şunları belirleyebilir:

- context builder ne zaman çalışır,
- hangi sources available,
- retrieval tool ne,
- context max budget,
- compaction threshold,
- subagent'e ne aktarılır,
- tool result nasıl trim edilir.

Context Engineering ise bu mechanisms'in current inference utility'sini optimize eder.

Bu yüzden iki disiplin ayrı fakat nested/overlapping olabilir.

> **Harness context plumbing'i işletir; Context Engineering plumbing'den geçen working set'in kalitesini tasarlar.**

---

## 14. Harness ile Memory Engineering ilişkisi

Harness:

- memory write trigger,
- session checkpoint,
- recall timing,
- verification-before-persist,
- access controls,
- compaction,
- cleanup/forgetting jobs

gibi lifecycle'i operationalize eder.

Memory Engineering ise hangi memory'nin hangi semantics/governance ile yaşaması gerektiğini tanımlar.

Dolayısıyla:

> **Memory policy ile memory execution aynı şey değildir.**

Bir `MEMORY.md` dosyasının varlığı memory harness değildir; write/read/update lifecycle'in gerçekten koşması gerekir.

---

## 15. Harness ile Fine-Tuning ilişkisi

Fine-Tuning model layer'ını değiştirir; Harness model-external runtime'dır.

Harness:
- hangi model/adaptor kullanılacağını route edebilir,
- model version'ı bind edebilir,
- eval threshold koyabilir,
- rollout/rollback yapabilir.

Fakat fine-tuned behavior harness'in kendisi değildir.

Bu ayrım useful çünkü bir failure için iki farklı müdahale yolu vardır:

```text
model lacks capability
→ adaptation/model change candidate

model has capability but environment/control path inadequate
→ harness change candidate
```

Her problemi fine-tuning veya prompt ile çözmeye çalışmak yanlış layer olabilir.

---

## 16. Harness complexity bir maliyettir

Anthropic'in 2026 harness work'ü ilk full harness'in bulky, slow ve expensive olduğunu; sonra components'i tek tek kaldırıp load-bearing olup olmadığını test ettiklerini raporlar. [S5]

Bu önemli counterweight'tir.

Harness complexity:
- token cost,
- latency,
- coordination overhead,
- debugging surface,
- new failure modes,
- stale assumptions

üretir.

Dolayısıyla:

> **More harness ≠ better harness.**

Harness component eklemek için measurable failure class ve falsifiable expected value olmalıdır.

---

## 17. Harness model-dependent'tir ve zamanla stale olabilir

Anthropic'in explicit dersi:

> her harness component modelin neyi kendi başına yapamadığına dair bir assumption taşır; model capability arttıkça bu assumption stale olabilir. [S5]

Opus 4.6 ile önceki sprint decomposition'ın kaldırılması ve evaluator value boundary'sinin task difficulty'ye göre değişmesi buna concrete example'dır. [S5]

Bu nedenle harness lifecycle:

```text
model/version change
→ re-benchmark
→ component ablation
→ simplify / add new capability
```

olmalıdır.

SOUL generality açısından fixed scaffolding'in kendisi rigidity kaynağı olabilir.

---

## 18. Observability yoksa harness optimize edilemez

OpenAI agent'a logs, metrics ve traces görünür kıldığını; OpenAI Agents SDK ise LLM generations, tool calls, handoffs, guardrails ve custom events'i tracing altında topladığını belirtir. [S2][S7]

Observability iki role sahiptir:

### 18.1. Agent capability

Agent kendi environment outcome'unu görebilir.

### 18.2. System verification / debugging

Engineer/verifier failure'ın:
- context,
- memory,
- tool,
- model,
- guardrail,
- orchestration

hangi aşamasında olduğunu ayırabilir.

No trace → “agent kötü cevap verdi” aggregate symptom'ında kalırız.

---

## 19. Harness security ve authority

Agent action sistemi olduğunda harness şu boundaries'i taşır:

- least privilege,
- credentials/tool scope,
- filesystem/network sandbox,
- human approval,
- irreversible side effects,
- cross-tenant separation,
- untrusted input/context,
- escalation.

Model “yapmak istiyor” diye authority kazanmaz.

Harness'in önemli görevi:

> **reasoning capability ile action authority'yi ayırmak.**

Bu SOUL Actors/authority araştırmasıyla ileride ilişki kurabilir; ancak current Foundations relation/control composition yetkilendirilmediği için burada architecture mapping yapılmaz.

---

## 20. Harness'in failure taxonomy'si

### A. Perception/context failure

Gerekli source görünmüyor veya noise fazla.

### B. Tool/interface failure

Capability var fakat affordance kötü veya observation anlaşılmaz.

### C. Authority failure

Agent izin verilmemiş action yapabiliyor veya gerekli action'a erişemiyor.

### D. Orchestration failure

Yanlış decomposition, duplicate work, handoff loss, uncontrolled parallelism.

### E. Memory/state failure

Progress kayboluyor, stale state resume ediliyor.

### F. Verification failure

Test yanlış şeyi ölçüyor, evaluator kör, check coverage eksik.

### G. Stop/retry failure

Premature completion, infinite loop, retry storm, cost explosion.

### H. Observability failure

Failure görünür değil; root cause ayrıştırılamıyor.

### I. Entropy/drift failure

Agent repository/process içinde low-quality patterns'i çoğaltıyor; documentation/invariants stale oluyor.

### J. Model-harness mismatch

Harness old model weakness'ını compensate etmek için gereksiz complexity taşıyor veya new model failure mode'una kör.

---

## 21. Harness evaluation nasıl yapılmalı?

Harness'i yalnız end-to-end success rate ile değerlendirmek yetersiz olabilir.

### 21.1. Baseline

Same model + minimal/simple harness.

### 21.2. Component ablation

Her component çıkarıldığında:
- success,
- error class,
- cost,
- latency

nasıl değişiyor?

Anthropic'in methodical simplification yaklaşımı bunun practitioner örneğidir. [S5]

### 21.3. Negative tests

- bad tool input,
- permission violation,
- stale state,
- missing evidence,
- evaluator-blind bug,
- retry failure.

### 21.4. Coverage

Guard/test hangi execution modes'ta koşmuyor?

### 21.5. Recovery

Failure sonrası system:
- rollback,
- resume,
- escalate,
- handoff

yapabiliyor mu?

### 21.6. Model-version portability

Same harness new model'da lift veriyor mu yoksa overhead mı?

### 21.7. Cost-adjusted value

Harness 20x maliyetle 2x quality veriyorsa task value bunu haklı çıkarıyor mu?

Universal answer yoktur.

---

## 22. SOUL açısından değerlendirme

SOUL'un intended outcome'a göre task-specific working system oluşturma hedefi Harness Engineering ile güçlü şekilde kesişir.

Çünkü task-specific system şu dimensions'i seçmek zorunda kalabilir:

- required tools,
- environment access,
- context strategy,
- memory strategy,
- verification intensity,
- actor/authority boundary,
- orchestration pattern,
- stop/escalation conditions,
- model/capability.

Bu şu olasılığı destekler:

> **SOUL yalnız task'i çözmeye çalışan agent değil, task için uygun working harness/capability configuration'ını kuran veya seçen bir sistem olmak zorunda kalabilir.**

Ancak bu cümle **research implication**'dır, architecture decision değildir.

### Critical caution

Harness template'i sabit ve her task'a aynı şekilde zorunlu tutulursa SOUL generality yerine fixed workflow system'e dönüşebilir.

Bu nedenle harness selection'ın kendisi task conditions'e duyarlı olmalıdır.

---

## 23. Development OS açısından değerlendirme

Development OS mevcut haliyle Harness Engineering'in birçok problemine dokunur:

### Context formation

- canonical cold-start,
- routing gate,
- progressive retrieval.

### Persistent continuity

- repository state,
- handoff,
- current/next Work separation.

### Reasoning controls

- conditional protocols,
- source fidelity,
- assumption management,
- verification discipline.

### Authority / scope

- current authorization,
- phase boundary,
- agent-control vs project-work separation.

### Verification

- review/independence/coverage discipline.

### Fakat önemli sınır

Browser ChatGPT + Project Instructions + GitHub repository ortamında bazı kontroller:

- runtime tarafından deterministic enforce edilen code constraints değil,
- modelin canonical control files'ı okuyup uygulamasına bağlı reasoning controls'dür.

Dolayısıyla Development OS'yi doğrudan “tam harness” ilan etmek doğru değildir.

Daha doğru araştırma hükmü:

> **Development OS bir harness lensiyle analiz edilebilecek güçlü external control/state/continuity surfaces taşır; fakat repository-level control representation ile underlying runtime enforcement capacity ayrılmalıdır.**

---

## 24. Development OS ile OpenAI Harness Engineering arasındaki dikkat çekici paralellik

Bağımsız olarak gelişmiş iki yaklaşımda şu pattern'ler kesişiyor:

| Development OS / current repo | OpenAI harness experience |
|---|---|
| canonical repo state | repository knowledge system-of-record |
| short AGENT router | short AGENTS.md map |
| progressive retrieval | progressive disclosure |
| STATE / handoff | versioned plans / progress artefacts |
| protocol routing | contextual guidance / skills / structured docs |
| source freshness concerns | doc gardening / freshness checks |
| verification protocols | tests/reviews/evaluation harnesses |

Bu resemblance architecture validation değildir.

Fakat şu hipoteze external support verir:

> **Agent-readable, repository-local, progressively disclosed, mechanically/explicitly validated knowledge and work state long-running agent engineering için güçlü bir pattern olabilir.**

Bu hipotezin SOUL/Dev OS'de actual value'su local benchmarks ile test edilmelidir.

---

## 25. Harness ile multi-agent relation

Multi-agent yalnız bir orchestration option'dır.

OpenAI Agents SDK manager-as-tools ve handoff gibi farklı patterns sağlar. [S8]

Anthropic subagents context isolation/parallel exploration için value gösterebilir; evaluator-generator loop verification lift sağlayabilir. [S5]

Ama multi-agent şu riskleri ekler:

- context handoff loss,
- duplicated work,
- shared wrong assumptions,
- authority confusion,
- coordination cost,
- false verifier independence.

Dolayısıyla Harness Engineering'in sorusu:

> “Kaç agent?”

değil:

> **Hangi decomposition/control topology bu Work için measurable value üretir?**

---

## 26. Decision boundary

### Harness Engineering lens güçlü when

- model capability var ama reliable execution yok,
- tools yanlış/opaque,
- agent environment'i göremiyor,
- long-running Work drift ediyor,
- session handoff zayıf,
- tests/review/QA inconsistent,
- permissions/side effects riskli,
- context/memory policies uygulanmıyor,
- agent premature completion ilan ediyor,
- cost/retry uncontrolled,
- model upgrade sonrası eski scaffolding gereksizleşiyor.

### Harness değişikliği doğru cevap olmayabilir when

- model core capability task için yetersiz,
- authoritative source hiç yok,
- user goal belirsiz,
- success criterion tanımsız,
- environment fiziksel olarak capability sağlamıyor,
- extra orchestration measurable value üretmiyor.

---

## 27. Bulgular

### F-HRN-01 — Harness model-external runtime/control substrate olarak anlamlı bir engineering object'tir

**Confidence:** high  
**Basis:** OpenAI/Anthropic engineering evidence + current source-code study. [S1][S2][S5][S6]

### F-HRN-02 — Harness Engineering orchestration'dan geniştir

**Confidence:** high  
**Basis:** environment legibility, tools, repo knowledge, constraints, verification, observability. [S2][S3]

### F-HRN-03 — Tool/ACI design model sabitken performance'ı maddi biçimde etkileyebilir

**Confidence:** high  
**Basis:** SWE-agent. [S3]

### F-HRN-04 — Repository-local system-of-record + short map + progressive disclosure current coding-agent practice'ta güçlü pattern'dir

**Confidence:** high for cited case; medium-high for broader generalization  
**Basis:** OpenAI harness engineering. [S2]

### F-HRN-05 — Prose control ve mechanical/runtime enforcement ayrılmalıdır

**Confidence:** high as systems conclusion  
**Basis:** OpenAI linter/invariant practice + guardrail coverage semantics. [S2][S4]

### F-HRN-06 — Evaluator/multi-agent eklemek independent verification garantisi değildir

**Confidence:** high  
**Basis:** Anthropic evaluator limitations + verification theory. [S5]

### F-HRN-07 — Long-running Work external recoverable state/handoff gerektirebilir; longer context tek çözüm değildir

**Confidence:** high  
**Basis:** Anthropic long-running harness. [S6]

### F-HRN-08 — Harness components model-specific assumptions taşır ve model upgrades sonrası yeniden test edilmelidir

**Confidence:** high  
**Basis:** Anthropic harness ablation / Opus 4.6 simplification. [S5]

### F-HRN-09 — Context ve memory harness'in altında operationalized olabilir; bu nedenle üçlü strict equal-layer taxonomy değildir

**Confidence:** high as synthesis  
**Basis:** harness definition + context/memory docs. [S1][S4][S7]

### F-HRN-10 — Development OS harness-engineering problem space'inin önemli parçalarını zaten temsil eder, fakat full runtime harness olduğu kanıtlanmamıştır

**Confidence:** high as project-specific synthesis  
**Basis:** current repository control/state design + runtime-enforcement boundary.

### F-HRN-11 — SOUL için harness configuration'ın task-specific olması generality hedefiyle fixed universal scaffolding'den daha uyumlu görünüyor

**Confidence:** medium-high as project-specific research implication  
**Basis:** task-specific system goal + model/task-dependent harness evidence. [S5]

---

## 28. Açık sorular

1. SOUL'un minimum harness responsibility set'i nedir?
2. Hangi controls model-level reasoning protocol, hangileri deterministic runtime enforcement olmalı?
3. Tool capabilities nasıl dynamically acquire/discover edilir?
4. Tool descriptions/interfaces agent için nasıl benchmark edilir?
5. Context/memory policy harness'ta hangi lifecycle events'e bağlanmalı?
6. Actor authority runtime tool permissions'a nasıl map edilir? (Architecture phase yetkili olduğunda.)
7. Stop/retry/escalation policies task riskine göre nasıl değişmeli?
8. Verification topology hangi Work classes'ta deterministic vs agent evaluator olmalı?
9. Multi-agent hangi conditions altında cost-adjusted lift üretir?
10. Harness component ablation SOUL benchmark'ında nasıl yapılır?
11. Model upgrade hangi harness assumptions'i invalidate eder?
12. Dev OS reasoning controls'ünün actual browser/runtime coverage'ı nasıl ölçülür?
13. Repository state ile runtime session state arasındaki contract ne olmalı?
14. Observability/tracing hangi epistemic decisions'i reconstruct edebilmeli?
15. Harness entropy/doc drift automated olarak nasıl detect edilir?
16. Security/permission controls prompt injection'dan bağımsız nasıl enforce edilir?

---

## 29. Araştırma sınırları

- Harness Engineering settled mature discipline gibi sunulmadı; 2026'da hızla oluşan bir alan olarak tutuldu.
- Coding-agent evidence bütün agent domains'e otomatik genellenmedi.
- OpenAI/Anthropic internal cases controlled universal benchmarks sayılmadı.
- Multi-agent superiority iddiası verilmedi.
- Evaluator output independent verification sayılmadı.
- Agents SDK implementation details universal architecture prescription yapılmadı.
- Development OS “tam harness” olarak sınıflandırılmadı.
- SOUL architecture veya implementation seçilmedi.

---

## 30. Source ledger

**[S1] Barbaste, P. et al. (2026). _Harness Engineering: Anatomy, Architecture, and Evolution of Coding Agents — A Source-Code Study of Eleven Systems_.**  
https://arxiv.org/abs/2609.00006  
Use: model + harness framing; harness runtime scope; empirical comparison of production coding harnesses.  
Limit: very recent preprint; coding-agent-specific.

**[S2] OpenAI (2026). _Harness engineering: leveraging Codex in an agent-first world_.**  
https://openai.com/index/harness-engineering/  
Use: environment underspecification, agent legibility, repository system-of-record, progressive disclosure, mechanical invariants, observability, feedback loops and entropy management.  
Limit: one internal product/team experience.

**[S3] Yang, J. et al. (2024). _SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering_. NeurIPS 2024.**  
https://arxiv.org/abs/2405.15793  
Use: ACI/tool/feedback design impacts agent performance.

**[S4] OpenAI Agents SDK. _Guardrails_. Current read 2026-09-03.**  
https://openai.github.io/openai-agents-js/guides/guardrails/  
Use: input/output/tool guardrail families and concrete workflow coverage boundaries.  
Limit: framework-specific.

**[S5] Anthropic (2026). _Harness design for long-running application development_.**  
https://www.anthropic.com/engineering/harness-design-long-running-apps  
Use: planner/generator/evaluator design, evaluator limitations, component ablation, cost, model-dependent/stale scaffolding.  
Limit: engineering case study; exact cost/performance not universal.

**[S6] Anthropic (2025). _Effective harnesses for long-running agents_.**  
https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents  
Use: fresh-session memory gap, initializer + incremental agent, progress/commit artefacts for continuity.

**[S7] OpenAI Agents SDK. _Tracing_. Current read 2026-09-03.**  
https://openai.github.io/openai-agents-js/guides/tracing/  
Use: LLM/tool/handoff/guardrail/custom-event observability example.  
Limit: framework-specific.

**[S8] OpenAI Agents SDK. _Agents_. Current read 2026-09-03.**  
https://openai.github.io/openai-agents-python/agents/  
Use: manager-as-tools, handoffs, lifecycle hooks and dynamic instructions as concrete orchestration surfaces.  
Limit: framework-specific.

**[S9] Anthropic (2024). _Building effective agents_.**  
https://www.anthropic.com/engineering/building-effective-agents  
Use: simplest-sufficient-system principle, workflow/agent patterns and tool-interface design guidance.

---

## 31. Current handoff

**Completed:** Harness Engineering bounded research.  
**Result:** Harness Engineering is best understood as the model-external operating/control substrate that makes agent capability usable: loop, interfaces, environment legibility, context/memory plumbing, authority, orchestration, verification, observability and continuity. It is broader than multi-agent orchestration and overlaps with Context/Memory Engineering.  
**Key Development OS finding:** current repository/control design has strong harness-like surfaces and striking parallels with recent agent-first engineering practice, but repository instructions must not be confused with deterministic runtime enforcement.  
**Critical lifecycle finding:** harness components encode model-capability assumptions and must be re-benchmarked/ablated as models change.  
**Architecture decision:** none.  
**Next research object:** cross-layer synthesis across Context / Memory / Harness and the five AI Knowledge Strategies.