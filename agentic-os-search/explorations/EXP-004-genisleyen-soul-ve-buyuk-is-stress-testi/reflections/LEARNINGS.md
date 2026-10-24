# EXP-004 — Kaynak bağlı kazanımlar

Türetilmiş exploration değerlendirmesidir; araştırma bulgusu veya kabul edilmiş mimari değildir. U/S kimlikleri [diyalog dizininden](../sources/conversation/INDEX.md) açılır.

| ID | Kazanım / ayrım | Kaynak ve durum |
|---|---|---|
| L01 | Başlangıçtaki agent/role/workflow/memory listesi yararlıydı, fakat sistemi agent-merkezli ve task-manager benzeri daraltma riski taşıyordu. | U001/S001; assistant sentezi. |
| L02 | Büyük-iş varsayımı kapasite sınırını bulmak için bilinçli test koşulu oldu; küçük işte görünmeyen ihtiyaçlar modelden çıkarılmadı. | U002/S002. |
| L03 | On başlık aynı ontolojik seviyede değil; dört Foundation ground daha temel state/problem alanları, Composition ilişkisel semantik, execution/verification/recovery/adaptation yaşam-döngüsü Work'ü gibi göründü. | U003/S003; Foundation yeniden kullanımı. |
| L04 | Mission beşinci ground olmaktan çok, purpose-oriented Work + Actors + Information + Environment ve Composition üzerinden oluşan qualified composite state adayıdır. | S006 Test 1; sentetik hipotez. |
| L05 | Büyük işte ilk substantive Work object work olmayabilir; Mission qualification, required-condition discovery ve Work discovery de Work'tür. | U007/S007, S008. |
| L06 | Need / Condition, Method, Decision, Work ve Action'ı birbirine indirmek Work discovery'yi bozar. | S008; RPD ile karşılaştırmalı exploration sonucu. |
| L07 | Plan actual Work değildir; Work hakkındaki living Information representation'dır ve stale/yanlış olabilir. | S008; Foundation Work sınırı. |
| L08 | Büyük iş tek `next_task` yerine actionable frontier taşıyabilir; ready, priority, selected, assigned, claimed ve executing ayrı standing'lerdir. | S008. |
| L09 | Role Actor değildir. Work demand → capability/competence/authority requirements → role → Actor akışı, “task başına agent” refleksinden daha güçlüdür. | S009. |
| L10 | Capability, competence, authority, responsibility, assignment, claim ve liveness ayrı tutulmalıdır. | S009; Actors Foundation/studies ile uyumlu. |
| L11 | SOUL'un kendi iç Actor/role organizasyonu ile hedef iş için kurduğu organization farklı analiz seviyeleri olabilir. | U009/S009; açık ayrım. |
| L12 | SOUL ile generated working system arasında sert builder/product kopuşu varsaymak gerekmeyebilir; baz SOUL Work'e göre genişleyen yaşayan sistem hipotezine döndü. | U010/S010; kullanıcı farkındalığı + assistant stress-test sentezi. |
| L13 | System Information, Actor Context ve actual use aynı değildir; context Actor/Work-conditioned view'dür. | S010. |
| L14 | Memory tek store değildir; canonical state, durable history/evidence, derived views, Actor-local state ve reusable learned knowledge ayrı taşıyıcı rollerdir. | S010/S013. |
| L15 | Information adequacy Information'ın tekil özelliği değil, Information × Work × Actor × use üzerinden Composite Standing olabilir. | S010. |
| L16 | Tool existence, capability materialization, Actor access, credential/permission, authority, health ve effect sufficiency ayrıdır. | S011. |
| L17 | Work identity ile execution attempt ayrılmalı; `Run / Execution Attempt` bu nedenle güçlü aday runtime nesnesi oldu. | S011; adopted schema değil. |
| L18 | Tool/API success, realized effect, Work success, accepted result ve Mission outcome farklıdır; unknown/partial effect recovery'de reality reconciliation gerektirebilir. | S011. |
| L19 | Verification claim/criterion/object/revision-specific Work'tür; başka Actor etiketi bağımsız doğrulama değildir ve verifier ilgili hata sınıfına duyarlı olmalıdır. | S012. |
| L20 | Epistemic qualification ile governance acceptance/progression kararı ayrıdır; acceptance residual risk'i silemez veya truth yaratamaz. | S012. |
| L21 | `Qualification Case` object/revision, claim, criterion, evidence, method/oracle, verifier ve currentness'i birlikte taşıyabilecek güçlü aday çalışma nesnesidir. | S012; adopted değil. |
| L22 | Actor continuity, Run continuity ve Work continuity aynı değildir. Actor kaybı Work kaybı olmamalıdır. | S013. |
| L23 | Handoff source of truth değil derived view olmalıdır; canonical current state değişince stale olabilir. | S013. |
| L24 | Persistence continuity değildir; reconcile, invalidate, recompute standing ve redispatch gibi davranışlar gerekir. | S013. |
| L25 | Binding change-impact/freshness/invalidation için yük taşıyabilir; dependency identity otomatik invalidation effect değildir. | S013. |
| L26 | Recovery failure bir system-design failure'ı gösterebilir; yeni Actor yaratmak yerine critical state materialization/role boundary gibi meta-work gerekebilir. | S013 + R06 uygulaması. |
| L27 | Stress test boyunca yeni first-order Foundation ground zorunluluğu çıkmadı; bu sonuç yalnız bu sentetik kesimin sınırlı başarısıdır. | S006–S013; completeness/independent verification değil. |
