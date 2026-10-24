# B6 — Dört zemini birbirine doğru bağlayan düzeni geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B6'nın hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey dört ayrı modülü birbirine bağlayan bir integration layer değildir.

Hedef; SOUL'un Information, Actors, Work ve Environment tarafındaki ayrı gerçekleri **aynı exact scope / target / actor / work / time / version bağlamında doğru ilişkilendirebilmesi**, bunlardan readiness/actionability/verification/acceptance gibi birleşik hükümleri yanlış collapse etmeden türetebilmesi, kritik davranış ve effect yollarını uygun kontrol altında tutabilmesi ve değişikliklerin bu birleşik hükümleri ne zaman geçersizleştirdiğini fark edebilmesidir.

B6'nın temel failure sınıfı şudur:

> **Tek tek doğru ground-local bilgilerden yanlış bir cross-ground hüküm üretmek.**

Örneğin actor yetkin, tool erişilebilir ve Work aday olarak hazır görünebilir; fakat doğru authority veya gerekli current Information yoksa “başlanabilir” sonucu yine yanlış olabilir.

## B6 için somut ilişki haritası

| Birleşik soru | Information ne taşır? | Actors ne taşır? | Work ne taşır? | Environment ne taşır? | Yanlış kısa yol |
|---|---|---|---|---|---|
| **Bu Work şimdi gerçekten başlanabilir mi?** | gerekli/current bilgi ve evidence | competence, active role, authority/obligation | admitted Work, dependency/frontier | actual access, tool, resource, capacity, condition | bir tanesi doğruysa ready saymak |
| **Bu actor bu etkiyi yaratabilir ve yaratmaya yetkili mi?** | grant/policy/target bilgisinin current temsili | actor identity, role, authority/delegation | exact Work/operation | actual technical reach/effect path | technical reach = authority |
| **Bu gate/control gerçekten korunuyor mu?** | governing basis ve evidence | legitimate authority / separation-of-duty | protected transition/Work step | enforcement point ve alternate effect paths | bir yol bloklandı = effect kontrol edildi |
| **İstenen değişiklik gerçekten oldu mu?** | operation record/readback/evidence | performer/authorizer/attribution | attempted/executed Work | realized state/effect | request veya success response = realized effect |
| **Sonuç gerçekten doğrulandı/kabul edildi mi?** | evidence, criterion, exact target/version | verifier/accepter authority | verification/validation/acceptance Work | actual target condition | done = verified = accepted |
| **Bir şey değişti; ne yeniden değerlendirilmeli?** | changed record/version/provenance | role/grant/authority değişimi | affected Work/dependency | changed condition/capability/effect | dependency değişti = bütün eski sonuçlar false |

Bu tablo bir schema değildir; B6'nın hangi birleşik soruları koruması gerektiğini görünür kılar.

## Development OS'un B6 için gerekli kabiliyet ve sorumlulukları

### B6-C1 — Exact cross-ground binding kurmak

Development OS relation'ları generic link olarak tutmamalıdır.

Bir hüküm decision-critical ise gerektiği ölçüde exact actor/bearer, role, Work, target, Information/source/version, Environment surface, operation, scope ve time bağları korunmalıdır.

Örnek: aynı actor aynı Work üzerinde bir anda producer, başka anda verifier olabilir. Aynı policy başka version/operation için geçerli olmayabilir. Anchor doğru olsa bile semantic position veya scope yanlışsa ilişki de yanlıştır.

### B6-C2 — Ground-local gerçeklerden Composite Standing / Qualification türetmek

Development OS readiness, actionability, eligibility, sufficiency, verified, accepted veya deployable gibi birleşik statüleri tek ground'dan çıkarmamalıdır.

Bir composite standing için:

- exact focus;
- criterion/requirement;
- gerekli bindings;
- constitutive cross-ground facts;
- scope/time/version;
- currentness/validity dependencies

gerekli ölçüde açık olmalıdır.

Sonuç yalnız true/false olmayabilir. Unknown, not evaluated, not applicable veya stale durumları yanlışlıkla false/true'ya çevrilmemelidir.

### B6-C3 — Readiness / actionability hükmünü bileşik olarak kurmak

Bir Work'ün gerçekten başlanabilir/actionable olması gerektiğinde şu tür girdiler birlikte değerlendirilmelidir:

- Work admitted mı ve dependencies uygun mu;
- actor doğru role bağlı ve yeterli mi;
- actor gerekli authority/obligation ilişkisine sahip mi;
- gerekli Information/context current ve yeterli mi;
- Environment capability/access/capacity gerçekten mevcut mu;
- ilgili control/gate koşulları sağlanıyor mu.

Bu bileşik hükümde eksik veya uncertain bir parça varsa sistem bunu görünür tutmalıdır; kalan parçaların doğru olması eksik parçayı telafi etmez.

### B6-C4 — Assignment, admission, authorization ve execution'ı birlikte ama ayrı tutmak

Development OS şu geçişleri birbirine eşitlememelidir:

- actor role assignment;
- Work admission/commitment;
- actor obligation;
- authority/permission;
- technical dispatch/claim;
- actual execution.

Bir actor Work'e atanmış olabilir ama Work henüz admitted olmayabilir; Work admitted olabilir ama o actor yetkili olmayabilir; yetkili olabilir ama Environment actionability bulunmayabilir.

### B6-C5 — Context/evidence exposure ile operative use'ı ayırmak

Doğru Information'ın actor'a görünür olması cross-ground başarı için yeterli değildir.

Development OS kritik durumda:

- hangi Information'ın seçildiğini;
- actor'a gerçekten neyin sunulduğunu;
- hangi source/version'a dayandığını;
- karar/eylemde gerçekten kullanılıp kullanılmadığını

ayırt edebilmelidir.

B2 Information lifecycle'ı, B1 davranışı taşır; B6 bunların exact Work/Actor/Environment episode'una bağlanmasını korur.

### B6-C6 — Control/gate semantiğini policy, authority, decision ve enforcement'tan ayırmak

Bir kontrolün doğru işlemesi tek bir policy dosyası veya guardrail çağrısı değildir.

Development OS gerektiğinde şu katmanları ayrı tutabilmelidir:

- governing basis / invariant;
- exact governed action/effect;
- applicability;
- legitimate authority;
- evaluation/gate decision;
- enforcement/intervention;
- monitoring/evidence;
- exception/waiver/precedence.

Review Work'ünün bitmesi gate'in geçtiği; gate kararı da teknik olarak effect yolunun kapandığı anlamına gelmez.

### B6-C7 — Control objective ile enforcement point kapsamını ayırmak

En kritik kontrol hatalarından biri local enforcement başarısını end-to-end control sanmaktır.

Development OS:

- korunmak istenen exact effect'i;
- effect'e ulaşabilecek Actor/tool/service yollarını;
- hangi yolların gerçekten enforcement altında olduğunu;
- bypass/alternate path ihtimalini

gerektiği ölçüde değerlendirebilmelidir.

Bir tool path'in deny edilmesi, başka actor/credential/service yoluyla aynı protected effect'in oluşamayacağını kanıtlamaz.

### B6-C8 — Intent, Work execution, Environment effect ve observation zincirini korumak

Development OS şu claim'leri ayırmalıdır:

- değişiklik istendi;
- onaylandı/committed;
- Work yürütüldü;
- effect local olarak gerçekleşti;
- gerekli scope'a propagate oldu;
- observation/readback bunu gördü.

Local realization full propagation değildir. Observation da actual transition'ın kendisi değildir.

### B6-C9 — Verification, validation ve acceptance'i cross-ground olarak birleştirmek

Development OS kapanışta şu sıçramayı yapmamalıdır:

> execution complete → verified → fit/valid → accepted

Doğru qualification gerektiğinde exact target/version, criterion, evidence, verifier competence/independence, actual Environment condition, Work result ve authorized accepter birlikte değerlendirilmelidir.

Müşterinin **kabul** yetkisi burada özellikle korunur: teknik verifier acceptance yerine geçmez; müşteri kabulü de teknik verification kanıtı değildir.

### B6-C10 — Change impact ve invalidation'ı relation-aware yapmak

Bir dependency değiştiğinde Development OS yalnız dosya timestamp'ine bakmamalıdır.

Örneğin:

- source/version değişti;
- actor authority revoke edildi;
- Environment capability değişti;
- Work scope değişti;
- criterion/policy değişti

ise hangi binding, standing, control, plan, qualification veya prior result'ın yeniden değerlendirilmesi gerektiği bulunabilmelidir.

Önemli ayrım:

> dependency changed → re-evaluation gerekebilir ≠ önceki standing otomatik false oldu.

B8 bunun zaman içindeki continuity/recovery işletimini daha geniş ele alacaktır.

### B6-C11 — Attribution, provenance, causal contribution ve accountability'yi ayırmak

Bir effect olduğunda Development OS yalnız log zincirinden “kim sorumlu?” sonucuna atlamamalıdır.

Ayrı tutulması gerekebilir:

- hangi Information/source kullanıldı;
- hangi actor operasyonel olarak eylemi yaptı;
- kim authorize etti / kimin adına yapıldı;
- hangi Work ve mechanism effect'e katkıda bulundu;
- actual causal contribution ne kadar gösterildi;
- accountability hangi actor/forum ilişkisine ait.

Provenance ≠ causation ≠ responsibility ≠ accountability.

### B6-C12 — Cross-ground inconsistency ve failure'ı teşhis etmek

Development OS ground'lar arası uyuşmazlığı görünür kılabilmelidir.

Örnekler:

- Work active, fakat Environment unavailable;
- actor assigned, fakat authority revoked;
- policy current, enforcement stale;
- source güncellendi, context eski;
- tool success yazıyor, readback effect yok;
- verification passed, fakat yanlış target version test edilmiş;
- customer accepted, fakat technical evidence eksik.

Bu teşhis mevcut R3'ün en doğal cross-domain kullanım alanlarından biridir.

## B6 sınırı

B6 tek başına işe göre bütün sistemi seçip kurmaz — B7; uzun dönem continuity/recovery/learning lifecycle'ını tamamlamaz — B8; tüm SOUL'un end-to-end yeterliğini kanıtlamaz — B9.

B6'nın görevi **ground-local doğruları anlam kaybetmeden ilişkilendirmek, birleşik standing/control/transition hükümleri üretmek ve bunların source facts ile enforcement/effect gerçekliğinden kopmasını önlemektir.**

## B6'dan türeyen Development OS taşıyıcıları

### R16 — Cross-Ground Composition Designer / Çapraz-Zemin İlişki Tasarımcısı

**Taşıdığı B6 sorumlulukları:** C1, C2, C3, C4, C5 ve C9'un qualification tasarım tarafı.

Temel amacı:

> Information–Actors–Work–Environment arasında hangi exact binding'lerin ve birleşik qualification'ların gerekli olduğunu tanımlamak; generic relation veya tek-ground shortcut'larının yanlış hüküm üretmesini engellemek.

Bu rol exact anchors/semantic positions/scope-time bağlarını tasarlar; readiness/actionability gibi composite standings'in hangi facts ve criteria ile kurulacağını belirler; verification/acceptance gibi cross-ground qualification semantiğini korur.

**Sınır:** source ground'ların gerçeklerini kendi başına üretmez; enforcement yapmaz; actual effect'i doğrulamaz.

### R17 — Cross-Ground Control & Transition Steward / Kontrol ve Geçiş Sorumlusu

**Taşıdığı B6 sorumlulukları:** C6, C7, C8 ve C10'un operational control/propagation tarafı.

Temel amacı:

> Exact action/effect üzerinde governing basis, authority, gate, enforcement coverage ve realized transition/propagation ilişkilerinin birlikte doğru işlemesini yönetmek.

Bu rol policy/decision/enforcement ayrımını korur; protected effect ile enforcement point scope'unu karşılaştırır; bypass/alternate-path riskini görünür kılar; intended/committed/realized/observed değişiklikleri ayırır; dependency değişikliklerinin hangi derived standing/control'leri re-evaluation'a göndereceğini belirler.

**R9 ile farkı:** R9 Actor authority/delegation semantiğini taşır. R17 authority dahil birçok ground'u bir exact governed effect/transition üzerinde birleştirir.

### R18 — Composition Integrity Reviewer / Birleşim Bütünlüğü Doğrulayıcısı

**Taşıdığı B6 sorumlulukları:** C2/C3/C5/C7/C8/C9/C11/C12'nin bağımsız assurance tarafı.

Temel amacı:

> Ground-local gerçeklerden türetilen birleşik hükmün exact binding, scope, evidence, authority, enforcement ve actual effect açısından gerçekten desteklenip desteklenmediğini sınamak.

Bu rol özellikle yanlış target/version, stale grant, incomplete context, local-only enforcement, unknown effect, false propagation completeness, verification/acceptance collapse ve provenance→causation sıçramalarını arar.

**R6/R12/R15 ile farkı:** R6 Information zincirini, R12 Work progress/closure'ı, R15 Environment effect'i sınar. R18 bunların **birleşiminden çıkan hükmü** sınar.

### Mevcut rollerin B6 ile ilişkisi

- **R3** cross-ground failure diagnosis'ın owner'ı olmaya daha da yaklaşır.
- **R5/R6** context/evidence tarafını sağlar ve sınar.
- **R8/R9** competence ve authority tarafını sağlar.
- **R11/R12** Work admission/progress/closure tarafını sağlar.
- **R14/R15** actual Environment readiness/effect tarafını sağlar.
- **R16/R17/R18** bunların üstünde yeni bir super-agent olarak değil, cross-ground semantic/control sorumlulukları olarak konumlanır.

## Mekanik sorumluluk

### M6 — Cross-Ground Binding & Guarded-Transition Substrate

Bu bir AI rolü değildir.

Aday mekanik sorumluluklar:

- exact actor-role-work-target-version-environment binding;
- current grant/policy/criterion binding;
- precondition/standing checks;
- guarded Work/effect transitions;
- separation-of-duty ve required concurrence enforcement;
- M1/M3/M5 üzerindeki exact scope correlation;
- transition/effect correlation identifiers;
- invalidation/re-evaluation triggers;
- stale grant/context/config/result kullanımını bloke edecek mekanik destek;
- alternate effect path/coverage için gözlenebilirlik noktaları.

M6 bir universal rule engine veya transaction manager kararı değildir. B6'nın semantic ihtiyaçlarını teknik olarak gerçekleştirebilecek candidate responsibility set'idir.

## İnsan müşterinin B6'daki yeri

B6 müşteriyi integration coordinator yapmaz.

Müşteri:

- mandate/yetki kaynağı;
- gerektiğinde kapsam/değer tercihi için principal;
- nihai acceptance makamı

olarak kalır.

Teknik readiness, evidence sufficiency, control coverage veya actual effect doğrulamasını müşterinin bilmesi beklenmez. Aynı şekilde müşterinin “kabul ediyorum” demesi bu teknik claim'leri otomatik doğru yapmaz.

## İlk B6 ilişki akışı

```text
R4/R5 + R7/R9 + R10/R11 + R13/R14
        │ ground-local facts / requirements
        ▼
R16 Cross-Ground Composition Designer
        │ exact bindings + composite standings
        ▼
R17 Cross-Ground Control & Transition Steward
        │ gate / authority / enforcement / propagation
        ▼
M1–M6 mechanical surfaces
        │ actual governed execution/effect
        ▼
R6 / R12 / R15 local assurance
        │
        ▼
R18 Composition Integrity Reviewer
        │ composite claim assurance
        ▼
R3 failure diagnosis → ilgili B dalını yeniden aç
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B6'dan çıkan artefakt/sözleşme adayları

- **Exact Binding Case:** exact anchors, semantic positions, scope/time/version.
- **Composite Standing Case:** readiness/actionability/qualification kriteri, constitutive facts ve currentness dependencies.
- **Control Case:** governing basis, authority, decision, enforcement, coverage, exception/waiver.
- **Transition / Propagation Case:** intended/committed/realized/observed değişiklik ve realized scope.
- **Verification / Acceptance Case:** exact target, criterion, evidence, verifier, accepter ve ayrı sonuçlar.
- **Invalidation / Re-evaluation Case:** hangi dependency değişti ve hangi derived hükümler yeniden açılmalı.
- **Attribution / Contribution Case:** performer, authorizer, provenance, effect contribution ve accountability ayrımları.

Bunlar kesin schema, database table, service veya runtime seçimi değildir.