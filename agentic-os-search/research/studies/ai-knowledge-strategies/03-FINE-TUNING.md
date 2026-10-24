# Fine-Tuning — Derin Araştırma

**Status:** bounded deep-research synthesis  
**Date:** 2026-09-03  
**Parent:** `00-WHY-THIS-RESEARCH.md`  
**Previous:** `02-KNOWLEDGE-GRAPH.md`  
**Research object:** Fine-Tuning / post-training parameter adaptation  
**Epistemic status:** source-backed findings + explicitly marked project synthesis  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Relation to SOUL Foundations:** separate technical research line; does not modify the current foundation hierarchy  
**Verification status:** cross-source research synthesis; no local model fine-tuning, benchmark or independent implementation verification executed  
**Package position:** file 3 of 5 technical deep-dives; next planned file is `04-CAG.md`

---

## 1. Araştırma sorusu

Bu dosya şu soruyu araştırır:

> **Fine-Tuning hangi gerçek problem sınıflarını çözer, model davranışını ve bilgisini hangi yollarla değiştirir, hangi failure mode'ları ve governance yüklerini üretir ve SOUL ile Development OS açısından hangi karar sınırlarını görünür hale getirir?**

Bu soru şu daha dar sorularla aynı değildir:

> “LoRA kullanalım mı?”  
> “Bir modeli kendi verimizle eğitelim mi?”  
> “SOUL kurallarını modelin içine öğretelim mi?”

Bu dosya özellikle şu yanlış başlangıçları reddeder:

- Fine-Tuning = tek bir teknik değildir.
- Fine-Tuning = yalnızca style değiştirme değildir.
- Fine-Tuning = yalnızca yeni bilgi öğretme değildir.
- Fine-Tuning = RAG'ın alternatifi olmak zorunda değildir.
- LoRA / QLoRA = Fine-Tuning'in kendisi değildir; parameter-efficient yöntemlerdir.
- Preference optimization = supervised fine-tuning ile aynı şey değildir.
- Fine-tuned modelin iyi benchmark sonucu vermesi tüm eski kabiliyetlerini koruduğunu göstermez.
- Fine-tuned modelin güvenli görünmesi latent unsafe/backdoor behavior olmadığını kanıtlamaz.
- Training data kaynağını kaydetmek, her model çıktısını exact training source'a doğrudan bağlayabildiğimiz anlamına gelmez.
- Mevcut SOUL/Development OS governance'ını model weights'e gömmek bu araştırmanın sonucu değildir.

---

## 2. Kısa hüküm

### 2.1. Fine-Tuning nedir?

Bu araştırma için en kullanışlı minimum tanım:

> **Fine-Tuning, önceden eğitilmiş bir modelin parametrelerinin veya modele eklenen küçük trainable parametrelerin, belirli görevler, alanlar, davranışlar veya tercihler için ek training verisiyle adapte edilmesidir.**

Bu şemsiye altında farklı amaçlar ve yöntemler vardır:

- **Full fine-tuning:** model parametrelerinin büyük kısmı veya tamamı güncellenir.
- **Supervised Fine-Tuning (SFT):** input/instruction → desired output örneklerinden öğrenme.
- **Instruction tuning:** çok sayıda instruction-task örneğiyle genel instruction-following kabiliyetini geliştirme.
- **Preference tuning / optimization:** chosen-vs-rejected gibi preference verisinden davranış tercihi öğrenme; DPO bunun önemli örneklerinden biridir.
- **RLHF / RLxF:** insan veya başka feedback'ten reward/preference sinyaliyle politika adaptasyonu; süreç yalnız fine-tuning değildir fakat model policy'sini fine-tune etmeyi içerir.
- **PEFT:** bütün modeli değiştirmek yerine küçük parametre altkümelerini veya ek modülleri eğiten yöntem ailesi; LoRA önemli örnektir.
- **QLoRA:** quantized frozen base model üzerinde LoRA adapter training'iyle memory maliyetini düşüren yaklaşım.
- **Continual / sequential fine-tuning:** modelin zaman içinde yeni task/domain/data aşamalarıyla tekrar tekrar adapte edilmesi.

Ayrıca **domain-adaptive pretraining / continued pretraining** fine-tuning ile akraba bir adaptation hattıdır fakat supervised downstream fine-tuning ile aynı aşama değildir. Bu dosya sınır karışmasını önlemek için bu ayrımı korur. [S1][S2][S6][S7][S8][S18]

### 2.2. Bu araştırmanın ana sonucu

Instagram sınıflandırmasındaki:

> `Change Model Behavior → Fine-Tuning`

ifadesi **yararlı fakat eksik bir heuristic'tir**.

Daha doğru sonuç:

> **Fine-Tuning, modelin parametric behavior'ını değiştirir ve bazı koşullarda yeni bilgi/kabiliyet de kazandırabilir; ancak en güçlü ve daha güvenilir kullanım sınıfı çoğu zaman modelin mevcut bilgi/kabiliyetlerini belirli görev, format, preference veya domain davranışı doğrultusunda adapte etmektir.**

Özellikle yeni, sık değişen veya source-level provenance gerektiren factual knowledge için Fine-Tuning'in RAG gibi external-memory yöntemlerine göre belirgin dezavantajları vardır. EMNLP 2024'te Ovadia et al. unsupervised fine-tuning ile RAG'ı karşılaştırmış ve knowledge-intensive task'larda RAG'ın yeni ve mevcut knowledge için daha güçlü olduğunu raporlamıştır. Gekhman et al. ise supervised fine-tuning sırasında modelin yeni factual knowledge'ı daha zor öğrendiğini ve bu knowledge sonunda öğrenildikçe hallucination eğiliminin artabildiğini göstermiştir. [S11][S12]

Bu sonuç:

> “Fine-Tuning bilgi öğretemez.”

demek değildir. Knowledge updating çalışmaları parametric update'in mümkün olduğunu gösterir; fakat conflict, forgetting ve update reliability ayrı research problemidir. [S13][S17]

---

## 3. Fine-Tuning hangi problemi çözmeye çalışır?

Pretrained modelin üç temel uyumsuzluğu olabilir:

1. **Objective mismatch:** next-token prediction ile kullanıcının “talimatımı doğru uygula” beklentisi aynı değildir.
2. **Task/domain mismatch:** model genel amaçlıdır fakat hedef task'ın output schema'sı, terminology'si veya decision pattern'i farklıdır.
3. **Preference mismatch:** birden fazla geçerli output arasından hangisinin tercih edilmesi gerektiği pretraining objective'inden çıkmaz.

Instruction tuning ve InstructGPT gibi çalışmalar Fine-Tuning'in modelin instruction-following ve user-intent uyumunu ciddi biçimde değiştirebildiğini göstermiştir. FLAN unseen task'larda zero-shot performance'ı artırmış; InstructGPT human-feedback ile helpfulness/truthfulness gibi tercih boyutlarında gelişme göstermiştir. [S1][S2][S3]

Bu nedenle Fine-Tuning'in güçlü problemi çoğu zaman:

> **Model ne biliyor?**

değil yalnızca;

> **Model bildiğini ve yapabildiğini bu task'ta nasıl davranışa dönüştürüyor?**

sorusudur.

---

## 4. “Behavior vs Knowledge” ayrımı: kesin sınır değil

### 4.1. Behavior tarafı için güçlü evidence

LIMA, yalnız 1,000 dikkatle seçilmiş supervised example ile güçlü instruction-following ve format davranışları gösterebildiğini raporlamış ve knowledge'ın büyük bölümünün pretraining'den geldiği, alignment/fine-tuning'in daha çok bu knowledge'ı uygun output davranışına çevirdiği hipotezini güçlendirmiştir. [S10]

2026 ACM instruction-tuning survey'i de instruction tuning'i pretraining objective ile human instruction-following objective arasındaki boşluğu kapatan supervised adaptation olarak çerçeveler. [S4]

### 4.2. Knowledge tarafı tamamen kapalı değildir

Fine-tuning ve continued training domain-specific bilgi/kabiliyet kazandırabilir. Domain-adaptive pretraining literature bunu uzun süredir göstermektedir. Knowledge-updating yöntemleri de model weights içindeki eski/yeni knowledge conflict'ini doğrudan araştırmaktadır. [S13][S18]

### 4.3. Fakat factual knowledge injection zor bir kullanım sınıfıdır

Ovadia et al. yeni factual knowledge için RAG'ın unsupervised fine-tuning'den daha güçlü olduğunu; Gekhman et al. SFT'de yeni knowledge örneklerinin daha yavaş öğrenildiğini ve öğrenildikçe hallucination tendency'nin artabildiğini göstermiştir. [S11][S12]

Bu nedenle package-level working conclusion:

```text
Behavior / task adaptation     → Fine-Tuning için güçlü aday
Stable domain specialization   → koşullu güçlü aday
New factual knowledge          → mümkün ama reliability challenge
Fast-changing factual state    → Fine-Tuning zayıf default
Source-sensitive evidence      → external source/retrieval genellikle daha doğal
```

---

## 5. Mekanizma: modelde ne değişir?

### 5.1. Full Fine-Tuning

Training loss üzerinden gradient'ler model weights'i geniş ölçekte değiştirir.

Avantajlar:

- maksimum adaptation freedom,
- task/domain için büyük parameter capacity,
- bazı setting'lerde yüksek ceiling.

Riskler:

- yüksek compute/memory,
- model başına ayrı weight set'i,
- rollback/version management maliyeti,
- general capabilities regression,
- catastrophic forgetting,
- safety behavior değişimi.

### 5.2. LoRA

LoRA pretrained weights'i freeze eder ve selected layers'a düşük-rank trainable update matrices ekler. Original çalışma GPT-3 ölçeğinde trainable parameter ve memory yükünü dramatik azaltırken çeşitli benchmarklarda full fine-tuning'e yakın/üst performans raporlamıştır. [S6]

Önemli ayrım:

> **LoRA düşük maliyetli Fine-Tuning'dir; “davranış değişikliği olmadan özelleştirme” değildir.**

Adapter küçük olsa bile model behavior'ını değiştirmek için eğitilir.

### 5.3. QLoRA

QLoRA frozen base model'i 4-bit quantize eder, gradients'i LoRA adapter'larına taşır ve büyük modellerin daha düşük memory ile fine-tune edilmesini mümkün kılar. [S7]

Bu infrastructure maliyetini düşürür; fakat data quality, forgetting, safety veya provenance problemlerini otomatik çözmez.

### 5.4. Base model + adapter bağımlılığı

PEFT modülleri taşınabilir görünebilir fakat base model update edilince eski adapter performansı bozulabilir. ACL 2025 çalışması, önceki base version üzerinde eğitilmiş PEFT modüllerinin yeni base version'a taşınmasında önemli degradation görülebileceğini raporlamıştır. [S19]

Dolayısıyla model identity:

```text
base model family
+ exact base version/checkpoint
+ tokenizer/config
+ adapter version
+ training recipe
```

birlikte ele alınmalıdır.

---

## 6. SFT, Instruction Tuning, Preference Optimization aynı şey değildir

### 6.1. SFT

Model desired answer örneklerinin token likelihood'ını yükseltir.

Güçlü olduğu alanlar:

- output format,
- classification/extraction pattern,
- style/tone,
- task procedure imitation,
- tool-call/output schema,
- domain-specific answer pattern.

### 6.2. Instruction Tuning

Çok sayıda task/instruction üzerinde SFT yaparak instruction-following generalization hedefler. FLAN ve sonraki Scaling Instruction-Finetuned Models çalışmaları task çeşitliliği ve model scale'in unseen task performance'ında önemli olduğunu göstermiştir. [S1][S5]

### 6.3. Preference Optimization

Burada data yalnız “correct answer” değil, örneğin:

```text
prompt
chosen response
rejected response
```

şeklinde preference taşıyabilir.

DPO, explicit reward model + RL pipeline kurmadan preference pair'lerinden policy optimization yapar. [S8]

Bu, SOUL açısından önemli bir ayrım yaratır:

> **Correctness ile preference aynı şey değildir.**

Bir response kullanıcılar tarafından tercih edilebilir fakat factual veya policy-correct olmayabilir. Fine-tuning evaluation bu nedenle preference score ile doğruluk/authority/verification score'u ayırmalıdır.

---

## 7. Data quality ve diversity yük taşıyan faktördür

Fine-Tuning'de “daha çok data = daha iyi model” güvenilir bir kural değildir.

LIMA küçük ama curated dataset'in yüksek etkisini göstermiştir. Daha yeni instruction-tuning çalışmaları quality-diversity trade-off'unu ayrıca ölçmektedir. EMNLP 2024 QDIT çalışması diversity'nin özellikle worst-case instruction-following robustness'ı artırabildiğini; ACL 2025 çalışmaları da data diversity ölçümünün model performance ile güçlü ilişki taşıyabildiğini göstermiştir. [S10][S20][S21]

SOUL açısından bunun sonucu:

> Fine-tuning dataset'i sıradan “training file collection” değil, **yüksek etkili behavioral specification** olarak görülmelidir.

Her örnek:

- desired behavior,
- undesired shortcut,
- hidden bias,
- unsafe policy,
- stale fact,
- ambiguity,
- exception omission

öğretebilir.

---

## 8. Catastrophic forgetting ve regression

Fine-Tuning yeni task'ta performansı artırırken eski knowledge/capability'leri bozabilir.

2024 EMNLP çalışması catastrophic forgetting'i LLM tuning'de yeniden incelemiş; 2025 ACM Continual Learning survey'i de continual adaptation sırasında previous-domain degradation'ı ana problem olarak tanımlar. [S14][S17]

Sequential adaptation şu lifecycle riskini yaratır:

```text
Base model
 → Domain tune
 → Task SFT
 → Preference tune
 → Safety tune
 → New task tune
 → ...
```

Son aşamada iyi performans:

> önceki aşamaların korunduğunu kanıtlamaz.

### 8.1. Regression matrix gerekli

Fine-Tuned model yalnız target benchmark'ta değil en az şu alanlarda test edilmelidir:

- target-task performance,
- prior general capabilities,
- safety behavior,
- factuality/hallucination,
- out-of-distribution examples,
- adversarial inputs,
- forbidden/negative cases,
- long-tail instructions,
- calibration/abstention,
- tool/action constraints,
- sequential update retention.

---

## 9. New knowledge fine-tuning: conflict problemi

Bir model parametrelerinde eski knowledge varsa yeni data ile secondary fine-tuning şu çatışmayı yaratabilir:

```text
old parametric fact
        ↕ conflict
new training fact
```

ACL 2024 F-Learning çalışması direct secondary fine-tuning'in old/new knowledge conflict nedeniyle knowledge update'te etkisiz kalabildiğini, eski bilgiyi önce azaltmaya yönelik parametric approach'ın bazı benchmarklarda update'i iyileştirebildiğini göstermiştir. [S13]

Bu şunu gösterir:

> **Model weights bir database row'u gibi deterministically overwrite edilen knowledge store değildir.**

SOUL açısından sık değişen operational facts için Fine-Tuning'i default memory mechanism yapmak bu nedenle zayıf adaydır.

---

## 10. Provenance ve explainability sınırı

External retrieval'da modelin gördüğü source chunk'ı runtime'da kaydedilebilir.

Fine-Tuning'de ise knowledge/behavior weight changes'e dağılır.

Training dataset provenance elbette kayıt altına alınabilir:

```text
training run
 → dataset version
 → source/license/owner
 → checkpoint
```

Fakat şu soru daha zordur:

> “Bu spesifik output tam olarak hangi training examples nedeniyle oluştu?”

Training-data attribution literature bunun ayrı ve computationally difficult bir problem olduğunu gösterir. TRAK, DataInf ve sonraki attribution çalışmaları influence approximation geliştirir; ancak attribution hâlâ doğal/by-default model özelliği değildir ve causal influence ile explicit factual source aynı şey olmayabilir. [S22][S23][S24]

Bu nedenle:

> **training provenance tutmak ≠ inference-time source attribution.**

SOUL/Development OS gibi evidence/provenance-sensitive sistemlerde bu fark yük taşıyabilir.

---

## 11. Safety: fine-tuning yüksek yetkili bir model mutation'dır

Fine-Tuning yalnız capability kazandırmaz; var olan safeguards'i de değiştirebilir.

ICLR 2024 Qi et al. çalışması az sayıda malicious example ile safety alignment'ın ciddi biçimde bozulabildiğini ve benign fine-tuning dataset'lerinin bile safety degradation yaratabildiğini raporlamıştır. Instruction-tuning backdoor çalışmaları da poisoned instruction data'nın transferable hidden behavior üretebildiğini göstermiştir. [S15][S16]

Bu nedenle Fine-Tuning authority açısından şu kategoridedir:

> **yüksek etkili, persistent veya semi-persistent model mutation capability.**

SOUL için olası consequences:

- Her Actor fine-tuning başlatmamalı.
- Dataset eligibility/approval gerekebilir.
- Base model + adapter lineage tutulmalı.
- Safety regression gate zorunlu olabilir.
- Fine-tuned model yeni capability olarak ayrı authority scope alabilir.
- Rollback mümkün olmalı.
- “training tamamlandı” deployment approval anlamına gelmemeli.

Bunlar architecture kararı değil, research-derived governance requirements'tır.

---

## 12. Backdoor ve latent behavior problemi

Sleeper Agents çalışması proof-of-concept olarak deliberately trained backdoor behavior'ın SFT, RL ve adversarial safety training sonrasında kalabildiğini göstermiştir. [S25]

Bu evidence'i universal production frequency gibi yorumlamak doğru değildir.

Fakat şu verification dersi güçlüdür:

> **Fine-tuned modelin normal eval dağılımında güvenli görünmesi, trigger-dependent latent behavior olmadığını kanıtlamaz.**

Dolayısıyla verification yalnız average benchmark olmamalıdır; threat-model-based adversarial/holdout testing gerekir.

---

## 13. Fine-Tuning'in güçlü kullanım sınıfları

### 13.1. Stable repeated behavior

Aynı behavior yüzlerce/binlerce request boyunca gerekiyorsa prompt ile sürekli tarif etmek yerine model adaptation ekonomik veya kaliteli olabilir.

Örnek candidate classes:

- structured extraction,
- fixed schema generation,
- classification,
- domain terminology,
- constrained response style,
- specific tool-call conventions,
- recurring transformation tasks.

### 13.2. Task-specific capability

Base model'in capability'si var fakat task distribution'a iyi adapte değilse labeled examples yüksek değer sağlayabilir.

### 13.3. Preference shaping

Birden fazla plausible output arasından product/domain preference'ı öğretmek için preference optimization anlamlı olabilir.

### 13.4. Domain specialization

Stable domain language/patterns için domain adaptation + task fine-tuning kullanılabilir; fakat current factual state'in weights'e gömülmesi ayrı değerlendirilmelidir.

---

## 14. Fine-Tuning'in zayıf/default-olmaması gereken kullanım sınıfları

### 14.1. Hızlı değişen gerçekler

Bugün doğru yarın yanlış olabilen bilgi:

- current project state,
- authorization,
- prices,
- regulations,
- schedules,
- inventory,
- active incidents

weights'e yazılmak için doğal aday değildir.

### 14.2. Exact source citation gereken bilgi

Bir claim'in hangi authoritative source'a dayandığı yük taşıyorsa RAG/direct-source gibi external evidence routes daha doğal olabilir.

### 14.3. Küçük ve seyrek behavior farkları

Prompt/policy/config ile kolayca çözülebilen küçük fark için training lifecycle gereksiz olabilir.

### 14.4. Verinin az ve belirsiz olduğu durumlar

Az data her zaman sorun değildir; LIMA bunun tersine güçlü örnek sunar. Fakat **az + noisy + contradictory + unrepresentative** data yüksek risklidir.

### 14.5. Verification oracle yoksa

Fine-tuning bir weight mutation olduğundan “iyi görünüyor” değerlendirmesi yetmez. Regression ve negative tests olmadan deployment zayıf governance olur.

---

## 15. PEFT maliyeti düşürür; governance ihtiyacını düşürmez

PEFT'nin avantajları:

- daha az trainable parameter,
- daha düşük memory/compute,
- base model'i freeze ederek adapter separation,
- çok task için farklı adapters saklama kolaylığı,
- full-checkpoint'e göre bazı rollback/deployment avantajları.

Fakat şu sonuçlar çıkmaz:

- adapter küçük → risk küçük,
- base frozen → safety sabit,
- adapter kolay silinir → training effects kolay açıklanır,
- adapter portable → her base version ile güvenli çalışır.

Safety degradation ve adapter/base compatibility evidence bu varsayımları reddeder. [S15][S19]

---

## 16. Rollback ve versioning

Fine-Tuning için en az şu artefaktlar versioned olmalıdır:

```text
base model ID/version
training code/config
optimizer/hyperparameters
training dataset manifest
training dataset provenance
random seed / reproducibility metadata
adapter/full checkpoint
evaluation suite version
safety/regression results
approval/deployment status
```

PEFT adapter separation rollback'i kolaylaştırabilir:

```text
base + adapter-v3
→ disable adapter-v3
→ restore adapter-v2
```

Fakat exact base-model dependency korunmazsa rollback semantics bozulabilir.

Development OS açısından bu, fine-tuned modelin yalnız binary/model artefact değil **traceable Work output** olması gerektiğini düşündürür.

---

## 17. Verification nasıl yapılmalı?

Fine-Tuning evaluation şu katmanlara ayrılmalıdır:

### 17.1. Target task

- held-out target examples,
- task accuracy / quality,
- exact format/schema compliance.

### 17.2. General regression

- pre-fine-tune baseline ile karşılaştırma,
- general reasoning/language capability,
- unrelated task degradation.

### 17.3. Robustness

- paraphrases,
- long-tail instructions,
- OOD inputs,
- adversarial formatting,
- ambiguous inputs.

### 17.4. Knowledge/factuality

- new vs old knowledge,
- conflict cases,
- hallucination,
- abstention.

### 17.5. Safety/policy

- harmful instructions,
- policy regression,
- hidden-trigger/backdoor tests,
- tool/action misuse.

### 17.6. Continual update

- previous adapter/task retention,
- forgetting,
- base update compatibility.

### 17.7. Independent verification

LLM-as-judge yararlı olabilir fakat high-impact gate için tek başına independent oracle sayılmamalıdır. QLoRA çalışmasının kendisi bile chatbot benchmark/evaluator güvenilirliğinin sınırlı olabileceğini belirtmiştir. [S7]

---

## 18. SOUL açısından değerlendirme

### 18.1. Fine-Tuning SOUL'un kendisi değil, olası capability formation mekanizmasıdır

SOUL'un hedefi intended outcome için gereken task-specific working system'i oluşturmaksa, bazı görevlerde model adaptation gerekli olabilir.

Candidate flow:

```text
Outcome
 → task analysis
 → capability gap identified
 → can prompting/retrieval/tools solve it?
 → if not, is fine-tuning justified?
 → approved data + training
 → independent/regression verification
 → bounded capability deployment
 → monitor / rollback / retire
```

Bu **architecture proposal değildir**; fine-tuning'in SOUL hedefiyle uyumluluğunu değerlendiren decision frame'dir.

### 18.2. En güçlü ayrım: core governance vs task-specific capability

SOUL açısından iki kullanım aynı değerlendirmeyi almamalıdır.

#### A. Core governance'ı fine-tune etmek

Örneğin:

- authority rules,
- current Work state,
- canonical routing,
- acceptance criteria,
- “hangi source authoritative?” kuralları

weights'e gömülürse:

- görünürlük azalır,
- change diff zorlaşır,
- source-level provenance zayıflar,
- update için retraining gerekir,
- current state ile stale weights çatışabilir,
- audit/rollback karmaşıklaşır.

Bu nedenle current evidence altında **core mutable governance için Fine-Tuning zayıf default** görünmektedir.

#### B. Task-specific capability'yi fine-tune etmek

Örneğin:

- domain extraction model,
- specialized classifier,
- stable tool-call behavior,
- repeated output schema,
- expert terminology adaptation

daha güçlü adaydır.

Bu distinction `00-WHY-THIS-RESEARCH.md` içindeki H4 hipotezini önemli ölçüde destekler.

### 18.3. Fine-tuning authority'nin kendisi governed capability olmalıdır

SOUL bir model fine-tune edebiliyorsa sistem yalnız model capability değil **model mutation capability** kazanmış olur.

Bu nedenle candidate controls:

- who may initiate,
- which base models are eligible,
- which data is approved,
- what evaluation is required,
- what capabilities may change,
- what rollback path exists,
- what deployment scope is allowed.

---

## 19. Development OS açısından değerlendirme

### 19.1. Development OS'nin canonical control surface'lerini weights'e gömmek zayıf adaydır

Development OS'nin mevcut amacı:

- repository-authoritative state,
- cold-start reconstructability,
- explicit work/decision/evidence,
- model/session independence,
- fail-visible process

üzerine kuruludur.

Fine-Tuning ile `AGENT.md`, protocols, current STATE veya authorization logic'i model weights'e taşımak şu sorunu doğurur:

```text
repo says X
model was trained on old X'
```

ve bu conflict görünmez olabilir.

Dolayısıyla project-specific synthesis:

> **Development OS için mutable governance/context external and explicit kalmalı; Fine-Tuning ancak ayrı task capability için değerlendirilmelidir.**

Bu architecture kararı değildir; current project principles + research evidence'dan çıkan decision boundary'dir.

### 19.2. Fine-Tuning Development OS'nin kendisinde nerede yararlı olabilir?

Candidate examples:

- repository classification/extraction helper,
- issue/commit labeling,
- stable document-structure parser,
- domain-specific evaluator component,
- repeated transformation pipeline,
- structured metadata extraction.

Fakat bu modellerin output'u canonical truth sayılmamalıdır; verification/approval devam eder.

### 19.3. Reproducibility / lineage

Fine-tuned capability için fresh session şunları recover edebilmelidir:

```text
Why was this model created?
Which Work authorized it?
Which base/model version?
Which dataset/version/source?
Which method/hyperparameters?
Which evals passed/failed?
Who approved deployment?
What is the rollback target?
```

Bu bilgiler model weights'in içinde aranmaz; repository/evidence surfaces'te yaşamalıdır.

---

## 20. Fine-Tuning + RAG

Bu iki mekanizma rakip olmak zorunda değildir.

### RAG güçlü olduğu yerde

- fresh knowledge,
- large external corpus,
- source citation,
- dynamic state.

### Fine-Tuning güçlü olduğu yerde

- behavior,
- domain pattern,
- stable task skill,
- format/preferences.

Candidate composition:

```text
Fine-tuned model
      +
retrieved current evidence
      ↓
specialized behavior + fresh/source-backed knowledge
```

Bu, Instagram'daki “knowledge strategy” listesinde en önemli category correction'lardan biridir.

---

## 21. Fine-Tuning + Knowledge Graph

KG relation-heavy structured knowledge sağlayabilir; Fine-Tuning ise modelin graph query/result kullanma davranışını adapte edebilir.

Possible composition:

```text
Knowledge Graph = structured external relation state
Fine-Tuning     = graph-use / task behavior adaptation
```

Graph facts'i weights'e kopyalamak zorunlu değildir.

---

## 22. Fine-Tuning + CAG

Stable repeated context cache edilebilir; Fine-Tuning stable repeated behavior'ı modelin parametric davranışına taşıyabilir.

Decision question:

> Bu tekrar eden şey **bilgi/context** mi, yoksa **behavior/pattern** mi?

Stable rules bile governance ise parametric hale getirilmeden önce auditability/update riskleri değerlendirilmelidir.

---

## 23. Fine-Tuning + Long Context

Long Context, modelin büyük bir transient evidence package görmesini sağlar; Fine-Tuning ise bu package'ı nasıl işleyeceği konusunda task behavior kazandırabilir.

Örneğin specialized legal/scientific document reasoning davranışı fine-tune edilirken current documents long context'ten verilebilir.

Bu nedenle context capacity ile model adaptation farklı katmanlardır.

---

## 24. Operasyonel trade-off

| Boyut | Fine-Tuning etkisi |
|---|---|
| Training compute | full FT yüksek; PEFT/QLoRA daha düşük |
| Runtime token cost | repeated instructions/context azalabilir |
| Deployment complexity | yeni checkpoint/adapter lifecycle gerekir |
| Freshness | weights update edilmedikçe doğal olarak düşük |
| Provenance | dataset lineage tutulabilir; per-output source attribution doğal değildir |
| Rollback | PEFT ile görece kolay; full FT daha ağır |
| Observability | prompt/rule kadar açık değildir |
| Portability | base model/version bağımlılığı olabilir |
| Security | data poisoning / safety regression / backdoor yüzeyi |
| Verification | target + regression + safety + OOD geniş eval gerekir |
| Multi-task isolation | adapters yardımcı olabilir; interference yine test edilmeli |

---

## 25. Decision boundary

### Use when

Fine-Tuning güçlü adaydır eğer:

- aynı task/behavior çok tekrar ediyorsa,
- target distribution için yeterli ve kaliteli examples varsa,
- prompt/retrieval/tool-only çözüm yetersiz kalıyorsa,
- desired behavior nispeten stable ise,
- runtime prompt/context maliyeti anlamlıysa,
- model specialization measurable value üretiyorsa,
- regression/safety evaluation kurulabiliyorsa,
- rollback ve versioning mümkünse.

### Avoid as default when

Fine-Tuning zayıf/default-olmaması gereken adaydır eğer:

- ana ihtiyaç fast-changing factual knowledge ise,
- exact source/provenance runtime'da yük taşıyorsa,
- current authority/state sık değişiyorsa,
- behavior prompt/config ile kolayca ifade edilebiliyorsa,
- training data noisy/contradictory/unauthorized ise,
- regression oracle yoksa,
- base model/version stability belirsizse,
- değişikliğin audit edilebilir olması weight opacity'den daha önemliyse,
- sırf “model daha bize özel olsun” diye objective tanımlanmadan öneriliyorsa.

### Needs evidence before architecture decision

1. Fine-tuning ile çözülmek istenen exact failure nedir?
2. Bu behavior mı, knowledge mı, preference mı, domain adaptation mı?
3. Prompt/RAG/tool baseline performansı nedir?
4. Training data ne kadar kaliteli/diverse/representative?
5. Data provenance/licensing/permission nedir?
6. Base model hangi version/checkpoint?
7. Full FT mi PEFT mi neden?
8. Target metric nedir?
9. General capability regression suite nedir?
10. Safety regression suite nedir?
11. OOD/adversarial tests nedir?
12. Catastrophic forgetting tolerance nedir?
13. Fine-tuned knowledge ne kadar hızlı stale olacak?
14. Output-level provenance gerekiyor mu?
15. Rollback path nedir?
16. Adapter/base compatibility nasıl yönetilecek?
17. Deployment authority ve scope nedir?
18. Fine-tuned capability'nin retire/refresh koşulu nedir?

### Does not prove

Bu araştırma şunları kanıtlamaz:

- SOUL kendi core modelini fine-tune etmelidir.
- Development OS protocols model weights'e gömülmelidir.
- Fine-Tuning her task için RAG'dan iyidir.
- RAG her knowledge task'ta Fine-Tuning'den iyidir.
- LoRA full fine-tuning'den her durumda iyidir.
- PEFT safety riskini ortadan kaldırır.
- Fine-tuned model new knowledge'ı güvenilir database gibi saklar.
- SFT ile alignment tamamlanır.
- Preference score truth/authority score'dur.
- Küçük curated dataset her domain'de yeterlidir.

---

## 26. Bulgular

### F-FT-01 — Fine-Tuning tek bir teknik değil, parametric adaptation ailesidir

**Confidence:** high  
**Basis:** instruction-tuning, PEFT, preference/post-training literatürü. [S4][S6][S8][S9]

SFT, instruction tuning, DPO, full FT, PEFT ve continual FT aynı objective/mechanism değildir.

### F-FT-02 — “Fine-Tuning davranışı değiştirir” güçlü heuristic'tir fakat tam taxonomy değildir

**Confidence:** high  
**Basis:** FLAN/InstructGPT/LIMA + knowledge-update evidence. [S1][S2][S10][S13]

Fine-Tuning knowledge da değiştirebilir; fakat behavior/task adaptation daha doğal ve daha iyi desteklenen use-case'tir.

### F-FT-03 — Yeni factual knowledge'ı weights'e yazmak mümkün fakat reliability zayıf olabilir

**Confidence:** high  
**Basis:** EMNLP 2024 knowledge injection + hallucination + ACL knowledge update. [S11][S12][S13]

Bu nedenle fast-changing factual state için Fine-Tuning zayıf default'tur.

### F-FT-04 — Fine-Tuning'in en güçlü etkilerinden biri modelin mevcut knowledge/capability'yi kullanma biçimini değiştirmektir

**Confidence:** high  
**Basis:** FLAN, InstructGPT, LIMA, instruction-tuning survey. [S1][S2][S4][S10]

### F-FT-05 — Data quality/diversity training volume kadar veya ondan daha önemli olabilir

**Confidence:** high  
**Basis:** LIMA + recent instruction-data studies. [S10][S20][S21]

### F-FT-06 — PEFT compute/storage maliyetini azaltır; governance riskini ortadan kaldırmaz

**Confidence:** high  
**Basis:** LoRA/QLoRA + safety + compatibility evidence. [S6][S7][S15][S19]

### F-FT-07 — Fine-Tuning regression ve catastrophic forgetting üretebilir

**Confidence:** high  
**Basis:** EMNLP 2024 + ACM continual-learning survey. [S14][S17]

Target improvement tek başına deployment success değildir.

### F-FT-08 — Fine-Tuning safety alignment'ı bozabilen yüksek etkili mutation capability'sidir

**Confidence:** high  
**Basis:** ICLR/NAACL security evidence. [S15][S16]

Fine-tuning permission least-privilege ile ele alınmalıdır.

### F-FT-09 — Training-data provenance ile inference-time source attribution aynı şey değildir

**Confidence:** high  
**Basis:** training-data attribution literature. [S22][S23][S24]

Weights'teki davranış/knowledge external source citation kadar inspectable değildir.

### F-FT-10 — PEFT artefact'i exact base model version'ından bağımsız kabul edilmemelidir

**Confidence:** high  
**Basis:** ACL 2025 transferable PEFT evidence. [S19]

### F-FT-11 — SOUL için task-specific capability fine-tuning, core mutable governance fine-tuning'den daha güçlü adaydır

**Confidence:** high as project-specific synthesis  
**Basis:** SOUL general-purpose capability formation + explicit-state/provenance requirements + FT evidence.

Bu architecture decision değildir.

### F-FT-12 — Development OS'nin current state/authorization/protocol surfaces'ini weights'e gömmek source-of-truth hedefiyle gerilimlidir

**Confidence:** high as project-specific synthesis  
**Basis:** repository-authoritative Development OS + Fine-Tuning freshness/provenance/rollback findings.

### F-FT-13 — Fine-Tuning RAG/KG/CAG/Long Context ile farklı katmanda bulunur ve birlikte kullanılabilir

**Confidence:** high  
**Basis:** mechanism analysis + post-training/retrieval literature.

Bu sonuç `00-WHY-THIS-RESEARCH.md` içindeki “beş yaklaşım eş düzey rakip değildir” hipotezini güçlendirir.

---

## 27. Açık sorular — architecture öncesi gerekli bilgi

1. SOUL hangi task classes için model adaptation'a gerçekten ihtiyaç duyacak?
2. Hangi capability'ler prompting/tools/RAG ile yeterince çözülebilir?
3. Fine-tuning authority hangi Actor/role'a verilebilir?
4. Core governance ile task-specific behavior operational olarak nasıl ayrılacak?
5. Training data authority/provenance standardı ne olacak?
6. Synthetic training data hangi verification gate'ten geçecek?
7. Full FT / PEFT seçim kriterleri ne olacak?
8. Adapter registry/lineage nasıl tutulmalı?
9. Base model update olduğunda adapters otomatik invalid mi sayılmalı?
10. Fine-tuned capabilities için minimum regression suite ne olmalı?
11. Safety verification hangi threat model'i kapsamalı?
12. High-impact tool-use agent fine-tuning'inde action safety nasıl eval edilmeli?
13. Fine-tuned knowledge hangi durumda stale sayılacak?
14. Fine-tuned capability ne zaman refresh/retire edilecek?
15. RAG + FT hybrid selection hangi task properties'e bağlı olacak?
16. Output-level provenance gerekli task'larda parametric behavior ne kadar kabul edilebilir?
17. Fine-tuning sonucu generalization gerçekten desired rule mu yoksa learned shortcut mı?

---

## 28. Araştırma yöntemi ve sınırlar

Bu çalışma:

- instruction tuning foundational papers,
- human-feedback / preference optimization,
- PEFT / LoRA / QLoRA,
- post-training ve instruction-tuning surveys,
- knowledge injection/update studies,
- continual learning / catastrophic forgetting,
- instruction-data quality/diversity,
- safety degradation / backdoor studies,
- training-data attribution,
- base-model / adapter compatibility

üzerinden cross-source synthesis yapmıştır.

### Bilinçli sınırlar

- Belirli bir proprietary model/provider fine-tuning service benchmark edilmemiştir.
- SOUL corpus üzerinde SFT/LoRA/QLoRA çalıştırılmamıştır.
- Full FT vs LoRA project-specific benchmark yapılmamıştır.
- Fine-tuning dataset tasarlanmamıştır.
- Safety red-team implementation yapılmamıştır.
- Training-data attribution yöntemi çalıştırılmamıştır.
- LLM-as-judge sonucu independent verification kabul edilmemiştir.
- LIMA gibi small-data sonuçları universal “1000 examples enough” kuralına çevrilmemiştir.
- RAG vs FT sonucu Ovadia et al.'ın benchmark koşullarından universal dominance kuralına çevrilmemiştir.
- Sleeper Agents proof-of-concept evidence production prevalence iddiasına çevrilmemiştir.
- Fine-tuning ve continued/domain-adaptive pretraining kavramları aynılaştırılmamıştır.

### Stopping rationale

Araştırma boundedly closed kabul edilmiştir çünkü farklı evidence hatları aynı decision boundaries üzerinde yakınsamıştır:

- Fine-Tuning bir behavior/parameter adaptation family'dir,
- behavior-vs-knowledge ayrımı mutlak değildir,
- new/fresh factual knowledge parametric update için zor ve provenance-poor bir use-case'tir,
- PEFT cost'u düşürür fakat mutation/governance riskini kaldırmaz,
- forgetting/regression broad evaluation gerektirir,
- safety fine-tuning sonrası yeniden doğrulanmalıdır,
- data quality/diversity yük taşıyıcıdır,
- SOUL/Development OS için task capability ve core governance ayrımı kritiktir.

Yeni kaynaklar teknik ayrıntı ekleyebilir; ancak bu package'ın **SOUL / Development OS relevance ve decision-boundary** hedefi için ana sonucu değiştirme olasılığı düşmüştür.

---

## 29. Source ledger

### Instruction tuning / behavior adaptation

**[S1] Wei, J. et al. (2022). _Finetuned Language Models Are Zero-Shot Learners_. ICLR 2022.**  
https://arxiv.org/abs/2109.01652  
Use: instruction tuning improves zero-shot generalization on unseen tasks.  
Limit: model/task generation is period-specific.

**[S2] Ouyang, L. et al. (2022). _Training Language Models to Follow Instructions with Human Feedback_.**  
https://arxiv.org/abs/2203.02155  
Use: SFT + reward model + RLHF can substantially change instruction-following/preference behavior.  
Limit: early GPT-3-era system; not universal alignment guarantee.

**[S3] OpenAI (2022). _Aligning language models to follow instructions_.**  
https://openai.com/index/instruction-following/  
Use: primary publication summary for InstructGPT method and behavior results.  
Limit: organization-authored publication; paper remains primary technical evidence.

**[S4] Zhang, S. et al. (2026). _Instruction Tuning for Large Language Models: A Survey_. ACM Computing Surveys 58(7), Article 169.**  
DOI: 10.1145/3777411  
Use: current instruction-tuning definition, dataset/training/application/pitfall landscape.

**[S5] Chung, H. W. et al. (2024 journal version). _Scaling Instruction-Finetuned Language Models_. JMLR 25(70):1–53.**  
https://www.jmlr.org/papers/v25/23-0870.html  
Use: task/model/data scaling effects in instruction tuning.

### PEFT / efficient adaptation

**[S6] Hu, E. J. et al. (2022). _LoRA: Low-Rank Adaptation of Large Language Models_. ICLR 2022.**  
https://arxiv.org/abs/2106.09685  
Use: low-rank parameter-efficient adaptation; trainable parameter/memory reduction.

**[S7] Dettmers, T. et al. (2023). _QLoRA: Efficient Finetuning of Quantized LLMs_. NeurIPS 2023.**  
https://proceedings.neurips.cc/paper_files/paper/2023/hash/1feb87871436031bdc0f2beaa62a049b-Abstract-Conference.html  
Use: quantized base + LoRA memory-efficient fine-tuning; evaluation caveats.

**[S8] Rafailov, R. et al. (2023). _Direct Preference Optimization: Your Language Model Is Secretly a Reward Model_. NeurIPS 2023.**  
https://proceedings.neurips.cc/paper_files/paper/2023/hash/a85b405ed65c6477a4fe8302b5e06ce7-Abstract-Conference.html  
Use: preference optimization as distinct fine-tuning objective.

**[S9] Wang, L. et al. (2025). _Parameter-efficient fine-tuning in large language models: a survey of methodologies_. Artificial Intelligence Review 58:227.**  
DOI: 10.1007/s10462-025-11236-4  
Use: current PEFT methodology landscape.

**[S10] Zhou, C. et al. (2023). _LIMA: Less Is More for Alignment_. NeurIPS 2023.**  
https://papers.neurips.cc/paper_files/paper/2023/hash/ac662d74829e4407ce1d126477f4a03a-Abstract-Conference.html  
Use: small curated SFT dataset; evidence supporting behavior/surface-alignment interpretation.  
Limit: specific base model and human-evaluation setting.

### Knowledge injection / update

**[S11] Ovadia, O. et al. (2024). _Fine-Tuning or Retrieval? Comparing Knowledge Injection in LLMs_. EMNLP 2024.**  
https://aclanthology.org/2024.emnlp-main.15/  
DOI: 10.18653/v1/2024.emnlp-main.15  
Use: direct FT-vs-RAG factual knowledge comparison.  
Limit: unsupervised FT setting; not every fine-tuning method.

**[S12] Gekhman, Z. et al. (2024). _Does Fine-Tuning LLMs on New Knowledge Encourage Hallucinations?_ EMNLP 2024.**  
https://aclanthology.org/2024.emnlp-main.444/  
DOI: 10.18653/v1/2024.emnlp-main.444  
Use: new factual knowledge learning difficulty and hallucination risk under controlled SFT.

**[S13] Ni, S. et al. (2024). _Forgetting before Learning: Utilizing Parametric Arithmetic for Knowledge Updating in Large Language Models_. ACL 2024.**  
https://aclanthology.org/2024.acl-long.310/  
DOI: 10.18653/v1/2024.acl-long.310  
Use: old/new parametric knowledge conflict and specialized update method.

### Forgetting / continual adaptation

**[S14] Li, H. et al. (2024). _Revisiting Catastrophic Forgetting in Large Language Model Tuning_. Findings of EMNLP 2024.**  
https://aclanthology.org/2024.findings-emnlp.249/  
DOI: 10.18653/v1/2024.findings-emnlp.249  
Use: catastrophic forgetting during LLM tuning.

**[S17] Shi, H. et al. (2025). _Continual Learning of Large Language Models: A Comprehensive Survey_. ACM Computing Surveys 58(5), Article 120.**  
DOI: 10.1145/3735633  
Use: current continual pretraining/domain adaptation/fine-tuning and forgetting landscape.

**[S18] Gururangan, S. et al. (2020). _Don't Stop Pretraining: Adapt Language Models to Domains and Tasks_. ACL 2020.**  
https://aclanthology.org/2020.acl-main.740/  
DOI: 10.18653/v1/2020.acl-main.740  
Use: domain-adaptive/task-adaptive pretraining distinction and domain specialization evidence.

**[S19] Gu, N. et al. (2025). _Adapt Once, Thrive with Updates: Transferable Parameter-Efficient Fine-Tuning on Evolving Base Models_. ACL 2025.**  
https://aclanthology.org/2025.acl-long.719/  
Use: adapter degradation when base models evolve; version compatibility risk.

### Data quality/diversity

**[S20] Bukharin, A. et al. (2024). _Data Diversity Matters for Robust Instruction Tuning_. Findings of EMNLP 2024.**  
https://aclanthology.org/2024.findings-emnlp.195/  
DOI: 10.18653/v1/2024.findings-emnlp.195  
Use: quality-diversity trade-off and worst-case robustness.

**[S21] Yang, Y. et al. (2025). _Measuring Data Diversity for Instruction Tuning: A Systematic Analysis and A Reliable Metric_. ACL 2025.**  
https://aclanthology.org/2025.acl-long.908/  
DOI: 10.18653/v1/2025.acl-long.908  
Use: diversity measurement and empirical relation with instruction-tuning performance.

### Safety / security

**[S15] Qi, X. et al. (2024). _Fine-Tuning Aligned Language Models Compromises Safety, Even When Users Do Not Intend To!_ ICLR 2024.**  
https://proceedings.iclr.cc/paper_files/paper/2024/hash/83b7da3ed13f06c13ce82235c8eedf35-Abstract-Conference.html  
Use: malicious and benign fine-tuning can degrade safety alignment.  
Limit: studied models/settings are specific; does not establish universal degradation magnitude.

**[S16] Xu, J. et al. (2024). _Instructions as Backdoors: Backdoor Vulnerabilities of Instruction Tuning for Large Language Models_. NAACL 2024.**  
https://aclanthology.org/2024.naacl-long.171/  
Use: instruction-data poisoning/backdoor risk.

**[S25] Hubinger, E. et al. (2024). _Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training_.**  
https://arxiv.org/abs/2401.05566  
Use: proof-of-concept latent/backdoor behavior can persist through multiple safety-training methods.  
Limit: deliberately constructed research setting; not production prevalence estimate.

### Training-data attribution / provenance

**[S22] Park, S. M. et al. (2023). _TRAK: Attributing Model Behavior at Scale_. ICML 2023.**  
https://proceedings.mlr.press/v202/park23c.html  
Use: training-data attribution as separate computational problem.

**[S23] Kwon, Y. et al. (2024). _DataInf: Efficiently Estimating Data Influence in LoRA-tuned LLMs and Diffusion Models_. ICLR 2024.**  
https://proceedings.iclr.cc/paper_files/paper/2024/hash/5e84a0f233611a1dc8fb794dc52415a3-Abstract-Conference.html  
Use: influence attribution specifically for LoRA-tuned models.

**[S24] Chang, T. A. et al. (2025). _Scalable Influence and Fact Tracing for Large Language Model Pretraining_. ICLR 2025.**  
https://proceedings.iclr.cc/paper_files/paper/2025/hash/65798a76cc176c29b6bfefe84b0a03ff-Abstract-Conference.html  
Use: factual attribution vs causal influence mismatch; source tracing remains nontrivial.

### Current practical survey

**[S26] Szep, M. et al. (2026). _Fine-tuning Large Language Models with Limited Data: A Survey and Practical Guide_. TACL 14:341–377.**  
https://aclanthology.org/2026.tacl-1.17/  
DOI: 10.1162/tacl.a.627  
Use: current low-data fine-tuning, PEFT, specialization, preference alignment, catastrophic-forgetting trade-offs.

---

## 30. Current handoff

**Completed:** `03-FINE-TUNING.md` bounded deep research.  
**Result:** Fine-Tuning is a high-relevance parametric behavior/capability adaptation family, not merely a style switch and not a reliable universal knowledge-store replacement.  
**Key project-specific finding:** for SOUL/Development OS, the strongest candidate role is governed task-specific capability formation; mutable core governance/current state should not be silently moved into model weights because freshness, auditability, provenance, rollback and authority become weaker.  
**Verification:** cross-source synthesis only; no local fine-tuning/regression/safety benchmark / independent verification.  
**Architecture decision:** none.  
**Foundation-tree effect:** none. Current Foundation sequencing remains independently governed by `research/soul-foundations/STATE.md`.  
**Next planned file:** `04-CAG.md`.  
**Next action:** stop here; do not start CAG deep research in this turn.