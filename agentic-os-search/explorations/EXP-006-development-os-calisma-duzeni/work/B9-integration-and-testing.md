# B9 — Ortaya çıkan SOUL'u bütün olarak birleştirmek ve gerçek görevlerle sınamak

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B9'un hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey yalnız bir test suite veya birkaç başarılı demo değildir.

Hedef; SOUL hakkında ileri sürülen capability iddialarını **önceden tanımlanmış, hata-duyarlı, exact target/version'a bağlı ve mümkün olduğunca bağımsız kanıt yollarıyla** sınayabilmek; B1–B8 kapasitelerinin tek tek varlığını değil gerçek bir amaç altında birlikte çalışmasını gösterebilmek; başarısızlıkları fail-visible tutmak; ve çıkan verdict'in scope'unu olduğundan geniş göstermemektir.

B9'un ana sorusu:

> **Yaptığımız şey gerçekten SOUL gibi davranıyor mu, yoksa yalnız SOUL'u tarif eden ve bazı parçaları çalışan bir sistem mi?**

## Test edilmesi gereken ana SOUL capability claim'leri

B9 tek bir başarı metriği varsaymaz. En azından şu iddia aileleri ayrı fakat aynı campaign içinde ilişkilendirilebilir:

1. **Goal/need discovery:** görünür talebin ötesindeki kritik ihtiyaç/Work'ü gerektiğinde keşfedebiliyor mu?
2. **Working-system formation:** görev için gerekli actor/information/work/environment/control configuration'ını keşfedip kurabiliyor mu?
3. **Competence and governance:** doğru role/actor'ı seçiyor, competence/authority sınırlarını koruyor mu?
4. **Information use:** doğru/current bilgiyi bulup seçiyor, context'e taşıyor ve gerçekten kullanıyor mu?
5. **Work progression:** living plan, dependencies, admission, coordination ve closure'ı doğru yönetiyor mu?
6. **Environment/effect:** gerçek araç/ortamda actionability sağlıyor ve actual effect'i doğru gözlüyor mu?
7. **Cross-ground integrity:** readiness/authorization/verification/acceptance gibi birleşik hükümleri doğru kuruyor mu?
8. **Scale-appropriate formation:** basit işi gereksiz sistemle şişirmeden, zor işi de eksik scaffolding'le bırakmadan uygun sistemi seçiyor mu?
9. **Continuity/recovery:** actor/session/change/failure altında Work ve configuration continuity'sini koruyup doğru recovery üretiyor mu?
10. **Learning/adaptation:** experience'i yanlış genellemeden future behavior/configuration'a taşıyor mu?

Bu liste nihai benchmark taxonomy değildir; SOUL hedefinden türeyen current claim coverage map'idir.

## Development OS'un B9 için gerekli kabiliyet ve sorumlulukları

### B9-C1 — Test claim'ini exact ve falsifiable biçimde tanımlamak

Development OS her testten önce neyin sınandığını açıkça bağlamalıdır:

- capability claim;
- exact SOUL/configuration/model/version;
- target task/domain;
- expected observable behavior/effect;
- acceptance/verification criterion;
- hangi failure'ın kırmızı üretmesi gerektiği;
- testin neyi **kanıtlamadığı**.

“SOUL çalışıyor mu?” gibi tek geniş soru doğrudan oracle olamaz.

### B9-C2 — Claim'e uygun oracle ve evidence yolunu seçmek

Her claim aynı tür kanıtla doğrulanmamalıdır.

Gerektiğinde:

- deterministic test/check;
- authoritative readback;
- exact source comparison;
- execution trace/log;
- controlled fixture;
- domain-specific evaluator;
- human acceptance;
- adversarial review;
- cross-run comparison

gibi farklı evidence yolları seçilebilmelidir.

Teknik correctness için müşteri beğenisi; müşteri kabulü için de unit test tek başına yeterli oracle değildir.

### B9-C3 — Scenario portfolio'sunu capability coverage'a göre kurmak

Tek görev veya tek domain general-purpose SOUL iddiasını taşıyamaz.

Development OS test campaign'ini farklı failure yüzeylerini açacak görevlerle kurabilmelidir. Örneğin:

- kısa/basit iş — gereksiz system formation testi;
- uzun/çok-turlu iş — Work/continuity testi;
- araştırma ağırlıklı iş — Information/source fidelity testi;
- domain uzmanlığı gerektiren iş — role/competence acquisition testi;
- dış effect içeren iş — Environment/authority/readback testi;
- değişen koşullu iş — reconfiguration/change impact testi;
- failure/partial effect içeren iş — recovery/reconciliation testi;
- tekrar eden/benzer iş — adaptation/lesson reuse testi.

Scenario diversity, yalnız konu çeşitliliği değil **failure-surface çeşitliliği** taşımalıdır.

### B9-C4 — Testin aranan davranışı öğretmesini engellemek

Hidden-need discovery veya spontaneous recovery gibi iddialarda test prompt'u aranan açığı açıkça söylememelidir.

Development OS:

- challenge'ın hedef kusuru doğrudan tarif edip etmediğini;
- test fixture'ın çözümü ipucu olarak verip vermediğini;
- evaluator prompt'unun producer'a sızıp sızmadığını;
- previous-run artefact'larının holdout davranışı contaminate edip etmediğini

kontrol edebilmelidir.

İpucunu kaldırmak gerekli bilgi/evidence erişimini kaldırmak anlamına gelmez.

### B9-C5 — End-to-end system-formation davranışını sınamak

Test yalnız prebuilt configuration içinde task execution yapmamalıdır.

SOUL'a uygun testte gerektiğinde şu zincir görünür olmalıdır:

> amaç → Work/need discovery → capability gap → Working Configuration formation → readiness → execution/effect → verification/acceptance → continuation/adaptation

Testin kapsamına göre bütün halkaların her senaryoda aktif olması gerekmez; fakat system-formation iddiası preconfigured hidden owner work ile sahte biçimde karşılanmamalıdır.

### B9-C6 — Negative, adversarial ve failure-injection testleri kurmak

Happy path başarısı safety/reliability iddiası için yeterli değildir.

Development OS uygun olduğunda:

- stale source/context;
- wrong target/version;
- insufficient authority;
- inaccessible/unhealthy tool;
- bypass path;
- corrupted/incomplete handoff;
- partial/unknown effect;
- failed verifier/oracle;
- conflicting evidence;
- invalidated dependency;
- duplicate/late result

gibi durumları test edebilmelidir.

Kontrolün yanlış durumda kırmızı verip veremediği bizzat sınanmalıdır.

### B9-C7 — Change, continuity ve recovery davranışını aktif olarak sınamak

Fresh-session continuation yalnız dosya okunmasıyla test edilmiş sayılmaz.

Test gerektiğinde actor/session kesintisi, environment drift, source/version change, authority revocation, configuration change veya failure enjekte edip şunları gözlemlemelidir:

- doğru state recover edildi mi;
- stale actor/result engellendi mi;
- selective invalidation doğru mu;
- recovery modu failure'a uygun mu;
- post-recovery requalification yapıldı mı;
- Work doğru noktadan devam etti mi.

### B9-C8 — Learning/adaptation iddiasını ayrı test etmek

Lesson kaydı veya sonraki cevap benzerliği adaptation kanıtı değildir.

Development OS gerektiğinde:

- acquisition;
- retention;
- expression;
- scope/conditions;
- carrier/support dependence;
- stale lesson removal

iddialarını ayıran testler kurabilmelidir.

Testin kendisinin sistemi öğretmesi ile daha önce öğrenilmiş disposition'ın expression göstermesi ayrılmalıdır.

### B9-C9 — Verification yolunun bağımsızlık ve hata-duyarlılığını sınamak

Verifier veya evaluator'ın varlığı güveni otomatik artırmaz.

Development OS:

- producer ile ortak assumptions/sources/oracle'ları;
- aynı-model/common-framing riskini;
- deterministic oracle mümkünken model judgment kullanımını;
- testin intentional mutation/bad fixture karşısında kırmızı verip vermediğini;
- verifier'ın doğru target/version'a baktığını;
- review sonrası artefact değiştiyse verdict freshness'ını

değerlendirebilmelidir.

Different model ≠ independent proof; same model ≠ useless review. Güven iddiası doğrulamanın gerçek ayrıştırma gücüne göre sınırlandırılmalıdır.

### B9-C10 — Kriter bütünlüğünü ve post-hoc uyarlamayı korumak

Development OS test sonucu görüldükten sonra başarı kriterini sessizce değiştirmemelidir.

Criterion/threshold/fixture/oracle değişecekse:

- neden değiştiği;
- exploratory mi confirmatory mi olduğu;
- eski verdict'in geçerliliği;
- fresh rerun/holdout gerekip gerekmediği

görünür tutulmalıdır.

Testi geçirecek şekilde değiştirilen test, aynı run'ın bağımsız doğrulaması sayılamaz.

### B9-C11 — Exact target/version/environment ve reproducibility bağını korumak

Bir verdict yalnız sınadığı nesneye aittir.

Development OS:

- exact SOUL build/configuration;
- model/provider/version;
- active Working Configuration;
- source/data version;
- environment/tool versions;
- authority/grants;
- test fixture/oracle version

bağlarını gerektiği ölçüde korumalıdır.

Load-bearing dependency değişirse eski verdict otomatik current kalmamalıdır.

### B9-C12 — Generality ve transfer iddiasını scope'uyla sınamak

Tek domain veya tek task başarısı “general-purpose SOUL” kanıtı değildir.

Development OS:

- task/domain çeşitliliği;
- seen vs holdout tasks;
- familiar vs novel capability gap;
- low-risk vs controlled higher-complexity cases;
- text-only vs external-effect cases;
- short vs long-running Work

gibi eksenlerde coverage'ı görünür tutabilmelidir.

Sonuç “bu test setinde şu claim'ler desteklendi” olarak sınırlandırılmalı; evrensel yeterlik ima edilmemelidir.

### B9-C13 — Complexity ve harness contribution'ını test etmek

SOUL'un daha büyük sistem kurması otomatik başarı değildir.

Development OS gerektiğinde baseline/ablation ile:

- bu rol/mekanizma gerçekten failure class'ı azaltıyor mu;
- maliyet/latency/coordination yükü ne;
- component çıkarılınca ne kayboluyor;
- yeni model/version ile eski scaffolding hâlâ gerekli mi

sorularını sınayabilmelidir.

More harness ≠ better harness.

### B9-C14 — Failure'ı doğru B dalına geri yönlendirmek

End-to-end test kırmızı verdiğinde sonuç “SOUL başarısız” etiketiyle kapanmamalıdır.

Development OS evidence üzerinden failure'ın:

- B1 behavior;
- B2 Information;
- B3 Actor;
- B4 Work;
- B5 Environment;
- B6 composition/control;
- B7 system formation;
- B8 continuity/recovery/learning;
- veya test/oracle'ın kendisi

ile ilgili olup olmadığını teşhis edip ilgili Work'ü reopen edebilmelidir.

R3 burada ana diagnosis rolü olmaya devam eder.

### B9-C15 — Teknik verdict ile müşteri acceptance'ını ayırmak

Test campaign teknik ve operasyonel iddialar hakkında evidence üretir. Müşteri kabulü ayrı bir Actor hükmüdür.

SOUL testleri “müşteri kabul etti” diye technical gaps'i yok sayamaz; aynı şekilde testler yeşil diye müşterinin ihtiyacının karşılandığına otomatik hükmedemez.

## B9 sınırı

B9 canlı SOUL benchmark campaign'ini bu exploration içinde yürütmez. Buradaki amaç Development OS'un SOUL'u **nasıl test edebilir kapasitede olması gerektiğini** çıkarmaktır.

B9 sonunda B1–B9 candidate Work decomposition tamamlanır; bu, R1–R25'in nihai organizasyon veya Development OS mimarisi olduğu anlamına gelmez.

## B9'dan türeyen Development OS taşıyıcıları

### R24 — SOUL Evaluation Architect / SOUL Değerlendirme Tasarımcısı

**Taşıdığı B9 sorumlulukları:** C1, C2, C3, C4, C5, C6, C7, C8, C9'un design tarafı, C10, C12 ve C13.

Temel amacı:

> SOUL capability claim'lerini falsifiable test iddialarına, scenario portfolio'suna, oracle/evidence yollarına ve coverage planına dönüştürmek.

Bu rol:

- test claim ve non-claim sınırını tanımlar;
- scenario/failure-surface coverage tasarlar;
- hidden-requirement leakage'i önlemeye çalışır;
- oracle/independence ihtiyacını belirler;
- negative/mutation/recovery/adaptation testleri tasarlar;
- generality ve ablation kapsamını planlar;
- criterion'ı sonuçtan önce mümkün olduğunca sabitler.

**Sınır:** Testi tasarlaması sonucu kendi lehine verdict üretme yetkisi vermez.

### R25 — Evaluation Campaign Steward / Değerlendirme Kampanyası Sorumlusu

**Taşıdığı B9 sorumlulukları:** C5–C11'in execution/evidence tarafı, C13'ün run tarafı ve campaign traceability.

Temel amacı:

> R24'ün evaluation planını exact target/version/environment üzerinde gerçekten işletmek; test run'larını, evidence'ı, failures/unknowns ve verdict freshness'ını campaign boyunca doğru bağlarla korumak.

Bu rol:

- exact test target/configuration'ı bind eder;
- scenario run'larını koordine eder;
- environment/fixture/oracle version'larını korur;
- negative/mutation/continuity testlerini çalıştırır veya çalıştırılmasını sağlar;
- evidence completeness ve missing-run durumunu fail-visible tutar;
- artefact/config değişince stale verdict'i yeniden açar;
- campaign sonucu ile customer acceptance'ı karıştırmaz.

### Yeni end-to-end verifier rolü açılmadı

B9 için ayrıca R26 oluşturulmadı.

**R18 — Composition Integrity Reviewer**, B9'da per-scenario ve campaign-level integrated claims'in exact binding/evidence/authority/effect açısından desteklenmesini incelemeye genişleyebilir.

Yerel verifier roller de kendi claim'lerinde kullanılmaya devam eder:

- R2 behavior;
- R6 Information integrity;
- R8 actor qualification;
- R12 Work progress/closure;
- R15 Environment effect;
- R18 integrated/composite claims.

R24/R25'in varlığı bu verifier'ları epistemik olarak bağımsız yapmaz; test topology'si claim bazında ayrıca kurulmalıdır.

### Mevcut rollerin B9 ile ilişkisi

- **R3** failed evaluation'ın root-cause routing'ini taşır.
- **R18** integrated verdict assurance'a genişler.
- **R21/R22/R23** continuity/recovery/adaptation testlerinin target capability sahipleridir; evaluation owner değildir.
- **R19/R20** test campaign için ayrı Working Configuration gerekiyorsa formation/assembly sağlar.

## Mekanik sorumluluk

### M9 — Evaluation Harness, Evidence Capture & Test-Isolation Substrate

Bu bir AI rolü değildir.

Aday mekanik sorumluluklar:

- exact test target/configuration binding;
- fixture/seed/input isolation;
- test-run identity;
- deterministic check execution;
- negative/mutation/failure injection desteği;
- trace/log/effect/readback capture;
- oracle/result binding;
- producer/evaluator context separation desteği;
- holdout contamination kontrol yüzeyleri;
- baseline/ablation run correlation;
- verdict→target/version freshness binding;
- reproducible rerun için gerekli environment/config capture.

M9 bütün doğrulamayı otomatik doğru yapmaz. Oracle, coverage ve independence semantiği R24/R18 tarafından ayrıca değerlendirilir.

## İnsan müşterinin B9'daki yeri

Müşteri teknik test engineer veya benchmark designer olmak zorunda değildir.

Müşteri:

- gerçek ihtiyacın ve değer/acceptance criteria'nın kaynağı;
- gerektiğinde testin temsil etmesi gereken kullanım bağlamını açıklayan principal;
- nihai acceptance makamı

olarak kalır.

Teknik oracle, fixture, failure injection, mutation test veya verification-independence tasarımını müşterinin üretmesi beklenmez.

## İlk B9 evaluation akışı

```text
SOUL capability claims + target use contexts
              ↓
R24 SOUL Evaluation Architect
   │ claim / scenario / oracle / coverage plan
   ▼
R19/R20 test Working Configuration gerekirse
   │
   ▼
R25 Evaluation Campaign Steward + M9
   │ exact runs / traces / effects / failures
   ├──────────────► R2/R6/R8/R12/R15 local verification
   ▼
R18 Composition Integrity Reviewer
   │ integrated evidence / verdict scope
   ▼
R3 diagnosis
   └──────────────► ilgili B1–B8 Work'ü reopen

müşteri acceptance ── ayrı Actor hükmü
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B9'dan çıkan artefakt/sözleşme adayları

- **SOUL Capability Claim Matrix:** hangi capability claim'i hangi kapsamda test ediliyor.
- **Evaluation Plan:** scenario portfolio, oracle, failure injection, coverage ve independence planı.
- **Test Target Manifest:** exact SOUL/config/model/source/environment/authority/fixture versions.
- **Evaluation Run / Evidence Case:** run identity, inputs, actual traces/effects, unknowns ve raw evidence.
- **Negative / Mutation Result:** testin yanlış durumda kırmızı verebildiğine dair evidence.
- **Continuity / Recovery Test Case:** interruption/change/failure ve doğru re-entry/recovery sonucu.
- **Adaptation Test Case:** acquisition/retention/expression ayrımlı evidence.
- **Ablation / Baseline Case:** component contribution ve cost/complexity etkisi.
- **Integrated Verdict:** hangi claim'lerin hangi kapsamda desteklendiği, hangilerinin fail/unknown/not-tested kaldığı.

Bunlar kesin benchmark framework, CI platformu, test runner veya metric seti değildir.