# EXP-004 — Açık sorular

Bunlar araştırma/implementasyon kuyruğu değildir; sonraki exploration veya yetkili design çalışmasında geri çağrılabilecek sorulardır.

## O01 — Baz SOUL tam olarak nedir?

Hangi system-forming capacities iş gelmeden önce kalıcı olmalı? Work discovery, Actor formation, context formation, Environment provisioning, qualification ve recovery'nin hangisi baz capability, hangisi Work sırasında materialize edilen yapı?

## O02 — SOUL'un kendi organization'ı ile target organization ilişkisi

SOUL içindeki System Former / Planner / Critic / Verifier gibi roller ile hedef iş için yaratılan Actors aynı substrate üzerinde mi yaşar? Bir Actor hem SOUL meta-work hem object work yapabilir mi? Authority ve responsibility nasıl ayrılır?

## O03 — Mission composite state mi, ayrı persistent object mi?

Mission yeni Foundation ground olmayabilir; fakat runtime sistemde stable identity, versioning, authority ve change-impact gerektiren özel bir object olarak materialize edilmesi gerekir mi?

## O04 — Need / Condition / Work / Artifact ilişkileri nasıl temsil edilmeli?

Tek graph semantik kayıp yaratıyor mu? Ayrı fiziksel graph'lar gerekir mi, yoksa typed relation'lı ortak substrate yeterli mi? AND/OR prerequisites, alternatives ve method-dependent requirements nasıl korunur?

## O05 — Work admission ve frontier nasıl hesaplanmalı?

Ready standing hangi ground/bindings closure'ına bağlı? Priority/selection/capacity ve human authority nasıl eklenir? Actionable frontier büyük ve değişken olduğunda hangi heuristics kullanılır?

## O06 — Actor topology nasıl seçilmeli?

Ne zaman uzmanlaşmış çok Actor, ne zaman geniş rol, ne zaman deterministic service, ne zaman human? Coordination/context-transfer maliyeti, competence, independence ve capacity birlikte nasıl optimize edilir?

## O07 — Context adequacy ve source-view currentness

Belirli Actor/Work için context'in yeterli olduğunu nasıl ölçeriz? Canonical Information değişince hangi derived view'lar invalidate edilir? Qualifier/provenance kaybı nasıl önlenir?

## O08 — Memory sınırı

Canonical current state, history/evidence, learned knowledge, Actor-local notes ve derived views için retention/authority/revision/forgetting kuralları nasıl farklılaşır? “Memory” hangi noktada yararlı umbrella, hangi noktada zararlı collapse?

## O09 — Run / Execution Attempt gerekli primitive mi?

Retry, partial effect, unknown effect, external idempotency, Actor death ve reality reconciliation için ayrı Run identity gerçekten gerekli mi? Hangi Work türlerinde overkill olur?

## O10 — Qualification Case gerekli primitive mi?

Object/revision + claim + criterion + evidence + oracle + verdict/currentness tek kayıt ailesinde mi taşınmalı? Verification, validation, acceptance ve outcome standing'leri hangi ortak grammar'ı paylaşır, hangileri ayrılmalıdır?

## O11 — Acceptance / authority conflict

Verifier disagreement, residual risk ve multiple authorities durumunda progression nasıl kararlaştırılır? “Authorized to proceed” ile “evidence supports success” kullanıcıya ve downstream Actors'a nasıl birlikte gösterilir?

## O12 — Continuity ve invalidation

Source/Environment/Mission değişikliğinin downstream standing'lere etkisi nasıl bulunur? Dependency relation ile invalidation/control effect ayrımı nasıl kodlanır? Over-invalidation ve stale-use arasında denge nasıl kurulur?

## O13 — Feedback / learning / persistent adaptation

Bir outcome veya incident'in kaydedilmesi ile future behavior'ın gerçekten değişmesi nasıl ayrılır? Method/control değişikliği hangi evidence/authority ile accepted olur? Adaptation'ın kendisi nasıl verify edilir?

## O14 — Meta-work admission

SOUL kendi sistemini değiştirme Work'ünü ne zaman admit eder? Her failure sistem redesign'ı gerektirmeden proximate fix ile systemic fix nasıl ayrılır?

## O15 — Domain overfit

Matematik soru-bankası fixture'ında çalışan model; fiziksel operasyon, şirket kuruluşu, bilimsel araştırma, yasal süreç veya büyük software product gibi farklı domain'lerde nerede kırılır?

## O16 — Development OS prototip sınırı

Hangi candidate object/standing'ler prototip olmadan değerlendirilemez? Session/Actor kill, stale-context, partial-effect, verifier-conflict, source-update ve recovery için hangi executable fixtures kurulmalı?

## O17 — Sistem boyutu ve ekonomi

SOUL Work'e göre sürekli genişlerse ne zaman pruning/consolidation gerekir? Actor/tool/memory/control eklemenin cost/latency/complexity yükü nasıl standing ve Work selection'a dahil olur?
