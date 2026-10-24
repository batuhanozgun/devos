# EXP-004 — Konsolidasyon: Genişleyen SOUL ve büyük-iş çalışma sistemi

Bu metin kaynak diyalogun yerine geçmeyen türetilmiş sentezdir. Kaynak sıra: [conversation INDEX](../sources/conversation/INDEX.md). Araştırma yolları: [RESEARCH-REFERENCES](../sources/RESEARCH-REFERENCES.md).

## 1. Başlangıç sorusu: SOUL ne kurmalı?

Kullanıcı, SOUL'un büyük bir işi yapmak için kuracağı yapı hakkında beş başlangıç adayı verdi: agent'lar, roller, yapılacak iş, uzun soluklu iş planı/workflow ve memory. Amaç bu listeyi onaylatmak değil, repository birikiminin “bu da lazım” diyebileceği bir konuşma yürütmekti.

İlk düzeltme agent-merkezli çerçevenin gevşetilmesi oldu. Merkezde “agent takımı” değil, gerçekleştirilmek istenen bir durum ve onu meydana getirecek çalışma sistemi düşünüldü. Actor bir LLM agent, insan, verifier, deterministic service veya başka katılımcı olabilir.

## 2. On alan ve ilk temizleme

İlk sentezde Purpose/Target, Work, Actors, Information, Environment, Composition/Control, Execution, Verification/Acceptance, Continuity/Recovery ve Learning/Adaptation olmak üzere on sorumluluk alanı çıktı.

Bunların aynı seviyede olmadığı görüldü. Foundation'ın dört ground'u daha temel state/problem alanları olarak kaldı:

```text
Work
Actors
Information
Environment
```

Composition araştırmasının dört ana semantiği bunları bağlayan üst seviye oldu:

```text
Binding
Standing / Qualification
Control / Constraint
Transition / Effect / Feedback
```

Execution, verification, recovery ve adaptation ise bu zemin üzerinde çalışan Work/lifecycle davranışları olarak yeniden konumlandı. Purpose/Mission da beşinci ground olarak sabitlenmedi; Work/Actors/Information/Environment ve Composition üzerinden oluşan amaç-odaklı composite state olabileceği düşünüldü.

## 3. Büyük-iş varsayımı ve test yöntemi

Küçük iş bazı ihtiyaçları görünmez yapabileceği için kullanıcı özellikle SOUL'un büyük bir iş kurduğunu varsaymayı istedi. Sentetik test nesnesi bir yıllık 4. sınıf matematik soru bankasını üretip yayımlayan ve sürdüren büyük program olarak seçildi. Bu eğitim-domain kararı değil, çalışma sistemi test fixture'ıdır.

Test kuralı: model yeni bir problemde hemen genişletilmeyecek; önce mevcut ayrımların sorunu doğal biçimde taşıyıp taşımadığı kontrol edilecek. Gözlemler `represented`, `mechanism missing`, `model ambiguity` veya `candidate primitive` gibi statülerle düşünüldü. Model yeni first-order ground gerektirmeden stress'i taşıyorsa bu kaydedilecek, fakat completeness iddiası yapılmayacaktı.

## 4. Mission formation: object work'ten önce sistem-forming Work

Ham istekten doğrudan “müfredatı araştır, soruları yaz, yayınla” planına geçmek erken bulundu. İlk admitted Work, işin kendisini yapmak değil Mission'ı qualify etmek oldu.

```text
raw request
→ provisional Mission
→ decision-critical gaps
→ Mission-qualification Work
```

Burada request received, Mission understood, Mission sufficiently qualified ve production ready ayrıldı. Kullanıcının “ilk iş işi yapmak değil işi ortaya çıkarmak oldu” gözlemi, sonraki testlerin ana hattına dönüştü.

## 5. Need / Condition ≠ Work ≠ Action

Work discovery stress testinde hedefe ulaşmak için önce dünyada hangi koşulların doğru hale gelmesi gerektiği soruldu. Müfredat kapsamı, pedagojik uygunluk, doğruluk, üretim kapasitesi, yayın ve bakım gibi “required condition”lar henüz task değildi.

Geçici ayrım:

```text
Target
→ Need / Required Condition
→ possible Method
→ Decision
→ Work
→ Action
```

Work execution yeni Condition veya yeni Work keşfedebildiği için Work discovery recursive oldu. Plan da actual Work değil, Work hakkındaki yaşayan Information representation olarak konumlandı.

Tek generic task graph'ın kayıp üretebileceği görüldü; en az Need/Condition relations, Work relations ve Artifact/Information relations kavramsal olarak ayrıştı. Bu üç ayrı fiziksel graph mimarisi kabul edilmedi.

## 6. Work lifecycle ve actionable frontier

Discovered Work otomatik active Work olmadı. Work proposed, qualified/selected ve admitted ayrımları doğdu. Admitted Work de hemen executable değildi.

Stress testte şu non-collapse hattı güçlendi:

```text
open
≠ ready
≠ high priority
≠ selected
≠ assigned
≠ claimed
≠ executing
```

Tek “next task” yerine bir `actionable frontier` kavramı daha uygun göründü. Ready standing yalnız dependency graph'tan değil, Work prerequisites + Information adequacy + qualified Actor + Environment capability + Control permission birlikteliğinden hesaplanabilir.

## 7. Work demand → capability → role → Actor

Actionable frontier oluşunca Actor tasarımı ele alındı. Her task için bir agent yaratmak yerine Work'ün gerektirdiği capability ve competence analiz edildi; role buradan türedi, Actor daha sonra bu role'u realize eden instance/participant olarak seçildi.

```text
Work demand
→ capability requirements
→ competence requirements
→ authority envelope
→ role
→ Actor class
→ Actor instance
→ qualification / assignment / claim
```

Capability, competence, authority, responsibility, assignment, claim ve liveness ayrı tutuldu. Organization yeni ground yapılmadı; Actors + bindings + authority/responsibility + Work relations üzerinden collective configuration olarak taşınabildi.

SOUL'un kendi iç organization'ı (System Former, Work Discoverer, Researcher, Critic vb.) ile hedef iş için oluşturduğu Actor organization'ı ayrıca ayrılabilecek bir seviye olarak açık kaldı.

## 8. SOUL / generated system sınırı yumuşadı

Kullanıcı, SOUL'u uzaya giden mekikten ayrılan bir builder gibi değil, “hazır bir paket olup yapılacak işe göre genişleyen” yapı olarak düşünmenin daha uygun göründüğünü belirtti. Stress test bu hipotezi zayıflatmadı.

Daha uygun geçici model:

```text
BASE SOUL
→ Mission'la karşılaşır
→ Work keşfeder
→ roles/Actors ekler
→ Information/memory/context düzeni kurar
→ Environment capabilities bağlar/kurar
→ control/verification/recovery organları ekler
→ EXPANDED SOUL / WORKING SYSTEM
→ iş ilerledikçe tekrar yapılandırılır
```

Bu, SOUL ve generated working system'in aynı yaşayan sistemin farklı oluşum evreleri olabileceği hipotezidir; runtime kanıtı değildir.

## 9. Information, context ve memory

Actor'ların bütün sistemi görmesi gerekmiyor. Information'ın sistemde var olması, ilgili Actor'a uygun olması, erişilebilir olması, model-visible context'e girmesi ve gerçekten kullanılması farklı durumlar olarak ayrıldı.

```text
Information exists
≠ relevant
≠ available-to Actor
≠ exposed in working context
≠ actually used
```

Context, ayrı truth store'dan ziyade belirli Actor + Work + situation için seçilmiş model-visible working representation olarak ele alındı. Information adequacy consumer-relative Composite Standing olarak görüldü.

Memory de tek bir store olmadı. Canonical current state, durable history/evidence, derived views, Actor-local state ve reusable learned knowledge ayrımları belirginleşti.

## 10. Environment ve gerçek execution

Environment tool catalog olarak değil actual operating reality olarak ele alındı:

```text
tool exists
≠ currently available
≠ Actor can access
≠ credentialed
≠ authorized
≠ healthy
≠ sufficient for intended effect
```

SOUL'un işi yapmak için kendi Environment'ını da genişletebilmesi görüldü: database, parser, browser, evaluation runner, publishing/monitoring gibi capabilities Work tarafından talep edilebilir.

Work identity ile gerçek yürütme denemesi ayrıldı. Buradan `Run / Execution Attempt` aday nesnesi çıktı.

```text
Work W
├─ Run R1 failed
├─ Run R2 partial
└─ Run R3 realized
```

Tool invocation success, realized effect, Work success ve target outcome ayrıldı. Partial/unknown effect durumunda kör retry yerine authoritative reality readback / reconciliation gerekebileceği görüldü.

## 11. Verification / Qualification / Acceptance

“Done” tek standing olamaz. Bir sonuç için artifact integrity, mathematical correctness, curriculum fit, pedagogy, integration ve user outcome gibi farklı claim'ler olabilir. Verification belirli object/revision + claim + criterion + method/oracle + evidence + verifier üzerinden qualification üretir.

Bu nedenle verification da Work'tür. Başka Actor ID'si otomatik bağımsızlık değildir; oracle ilgili yanlışta kırmızı verebilmeli ve verdict değişen nesneye göre stale olabilir.

Buradan `Qualification Case` aday runtime/work nesnesi çıktı:

```text
object / revision
claim
criterion / scope
method / oracle
evidence
verifier
result / uncertainty
currentness
optional recognition / decision
```

Epistemic standing ile governance decision ayrıldı:

```text
evidence supports X
≠ authorized Actor accepts/progresses X
```

Acceptance residual risk'i silemez ve truth üretmez. Accepted artifact'ın production'a doğru entegre edilmesi ve Mission outcome ayrıca doğrulanmalıdır.

## 12. Continuity / Recovery

Uzun işte Actor kaybı, stale Information, unknown effect, Mission değişimi ve derived view staleness birlikte stress edildi.

Kritik non-collapse:

```text
Actor state
≠ Run state
≠ Work state
```

Actor kaybı Work kaybı olmamalıdır. Yeni Actor geçmiş conversation'ı körlemesine devam etmek yerine canonical current state + relevant history + actual Environment readback'ten türetilen re-entry context ile devam etmelidir.

Handoff source of truth değil derived view olarak konumlandı. Persistence continuity için gerekli olabilir, fakat yeterli değildir:

```text
continuity
≈ persistence
+ authority/currentness
+ recovery
+ reconciliation
+ stale-state invalidation
+ standing recomputation
+ redispatch
```

Binding'in yalnız navigation değil, change-impact/freshness/invalidation için de kritik olduğu görüldü. Dependency identity otomatik invalidation effect değildir; change + relation + impact evaluation yeni standing üretir.

## 13. Recovery failure'dan meta-work'e

A101 kaybolduğunda yalnız “yeni Actor yaratmak” semptom çözümü olabilir. Critical state Actor context'inde sıkışmışsa sistemik problem Work continuity'nin Actor continuity'ye bağlanmış olmasıdır. SOUL bu olaydan yeni meta-work çıkarabilir: Actor-local state azaltma, intermediate artifacts, role split veya deterministic capture.

Bu, SOUL'un object work kadar working-system meta-work'ü de yürütmesi hipotezini kuvvetlendirdi.

## 14. Stress testin şu anki sonucu

İlk beşli “agent + role + iş + plan + memory” şu daha geniş problem modeline dönüştü:

```text
state/problem grounds:
  Work
  Actors
  Information
  Environment

composition:
  Binding
  Standing / Qualification
  Control / Constraint
  Transition / Effect / Feedback

operating behaviors:
  Mission formation
  Work discovery/admission/readiness
  Actor/context/environment formation
  execution / readback
  qualification / acceptance
  recovery / replan / adaptation
  meta-work
```

Bu bir kabul edilmiş architecture değil. Fakat research corpusunun ayrımlarını kullanarak yapılan ilk kapsamlı stress test, şu ana kadar yeni first-order ground talep etmeden çok sayıda kritik non-collapse ayrımı görünür hale getirdi.

## 15. Sonraki kırılma noktaları

Açık sonraki testler:
- Feedback ile gerçek Persistent Adaptation farkı;
- SOUL'un kendi iç Actor organization'ı ile target Actor organization'ının ilişkisi;
- system-forming capability'nin ne kadarının baz SOUL'da kalıcı, ne kadarının Work ile materialize olduğu;
- organization/cost/capacity optimization;
- farklı bir büyük domain ile eğitim fixture'ına overfit kontrolü;
- hangi aday runtime objects gerçekten implementation sırasında gerekli;
- Development OS'un bu keşfi nasıl prototipleyeceği ve hangi benchmark/failure injection'ların kullanılması gerektiği.

Bu sorular otomatik çalışma kuyruğu değildir.
