# B7 — SOUL'un işe göre çalışma sistemi kurma ve genişletme kapasitesini geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B7'nin hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey her işe aynı “agent takımı” veya sabit harness template'ini uygulamak değildir.

Hedef; SOUL'un bir amaç ve gelişen Work anlayışı için **hangi çalışma sistemi kapasitesinin gerçekten gerekli olduğunu keşfedebilmesi**, mevcut baz kapasiteyi ve dış imkânları kullanarak yeterli fakat gereksiz şişmemiş bir **Working Configuration** oluşturabilmesi, bu konfigürasyonu gerçek role–information–work–environment–control bağlarıyla etkinleştirebilmesi ve ihtiyaç değiştikçe sistemi genişletip sadeleştirebilmesidir.

Bu, EXP-004'teki “SOUL hazır bir paket, işe göre genişliyor” düşüncesini mekanik mimari karara çevirmeden korur. Genişleme yalnız yeni actor eklemek değildir; yeni işlev geldiğinde mevcut Information, control, verification, Work ve recovery kapsamlarının da etkilenip etkilenmediği değerlendirilmelidir.

## Development OS'un B7 için gerekli kabiliyet ve sorumlulukları

### B7-C1 — Amaç ve Work'ten çalışma sistemi gereksinimlerini keşfetmek

Development OS doğrudan “kaç agent / hangi tool?” diye başlamamalıdır.

Belirli amaç ve Work için hangi kapasite ailelerinin gerektiğini keşfedebilmelidir:

- ortak çalışma davranışı / intellectual baseline;
- bilgi yaşamı ve context;
- rol/actor ve competence;
- Work planning/coordination/closure;
- Environment capability/effect;
- cross-ground control/qualification;
- domain-specific method/knowledge;
- verification intensity ve independence;
- gerekirse human contribution/decision.

Her kapasitenin gerçekten gerekli olup olmadığı gerekçelendirilmelidir. B1–B6'nın varlığı her mission'da hepsinin aynı yoğunlukta instantiate edilmesini gerektirmez.

### B7-C2 — Mevcut baz kapasiteyi ve gerçek kullanılabilirliği çıkarmak

SOUL her işte sıfırdan başlamamalıdır.

Development OS şu soruları cevaplayabilmelidir:

- baz SOUL'da hangi genel kabiliyetler zaten var;
- hangi actor/model/role taşıyıcıları mevcut;
- hangi Information/research/method library mevcut;
- hangi Work/control mekanikleri zaten reusable;
- hangi Environment/tool/runtime gerçekten available;
- hangileri yalnız kayıtta mevcut fakat stale/unavailable;
- hangi kapasite mevcut olsa da bu scope için yeterli değil.

Bu inventory yalnız registry okuması değildir; B2/B3/B5 currentness ve qualification sonuçlarına dayanmalıdır.

### B7-C3 — Capability gap analizi yapmak

Development OS gerekli sistem ile mevcut sistem arasındaki farkı çıkarabilmelidir.

Gap şu türlerden biri olabilir:

- bilgi/araştırma eksikliği;
- role/competence eksikliği;
- method eksikliği;
- Work yönetimi/coordination eksikliği;
- tool/environment/access eksikliği;
- control/enforcement eksikliği;
- verification/evidence yolu eksikliği;
- cross-ground binding/coverage eksikliği.

Gap adı, çözümü önceden belirlememelidir. Örneğin competence gap her zaman yeni agent; Information gap her zaman RAG; Environment gap her zaman custom runtime demek değildir.

### B7-C4 — Gap için reuse / configure / acquire / create / defer seçeneklerini değerlendirmek

Development OS her boşlukta yeni bileşen üretmemelidir.

Bir capability ihtiyacı için sırasıyla şu tür seçenekler değerlendirilebilir:

- mevcut kapasiteyi olduğu gibi reuse etmek;
- mevcut kapasiteyi yeni scope/context/config ile kullanmak;
- mevcut actor'a yeni role instantiation vermek;
- dış capability/tool/source/uzman bağlamak;
- yeni actor/method/mechanism oluşturmak;
- yeterli ve güvenli yol yoksa Work'ü defer etmek veya unavailable bırakmak.

Seçim; yeterlilik, authority, Environment fit, cost, complexity, risk, verification ve recovery yüküne göre yapılmalıdır.

### B7-C5 — En küçük yeterli Working Configuration'ı tasarlamak

Development OS seçilen parçaları yalnız listememelidir.

Bir Working Configuration gerektiğinde şunların birlikte uygulanabilir kombinasyonunu tanımlamalıdır:

- aktif Work/frontier;
- actor-role bindings;
- role-specific competence ve common baseline;
- Information/context/source bindings;
- method/strategy;
- tool/environment configuration;
- authority/grants;
- controls/gates;
- verification/acceptance yolu;
- effect/readback/observability;
- failure/recovery yolu.

Aktör, yöntem, kaynak ve araç ayrı ayrı mevcut diye configuration hazır sayılmaz. Aynı exact scope ve izinli çalışma yolunda birlikte kullanılabilir olmaları gerekir.

### B7-C6 — Working Configuration'ı gerçek sistemde assemble ve activate etmek

Configuration yalnız öneri veya belge olarak kalmamalıdır.

Development OS ilgili B sahiplerini kullanarak:

- role/actor instantiation;
- context/information preparation;
- Work bindings;
- Environment provisioning;
- grants/controls;
- verification hooks;
- effect/readback paths

gibi gerekli parçaların gerçekten kurulmasını ve aynı configuration identity altında bağlanmasını sağlayabilmelidir.

Bu işlem tek bir merkezi orchestrator veya tek atomic commit mimarisi gerektirmez. Gereken şey, hangi configuration'ın gerçekten active olduğunun ve hangi parçaların yalnız candidate kaldığının karışmamasıdır.

### B7-C7 — Configuration readiness ve joint fit'i sınamak

Component-level başarı sistem-level readiness kanıtı değildir.

Development OS configuration aktive edilmeden veya kritik Work'e girmeden önce gerektiğinde şunları sınayabilmelidir:

- gerekli parçaların hepsi gerçekten mevcut mu;
- exact versions/scopes uyumlu mu;
- actor competence + authority + context + Environment birlikte actionable mı;
- verification/control/effect path kapalı mı;
- hidden dependency veya coverage gap var mı;
- configuration amacı karşılamak için yeterli, fakat gereksiz ağır mı.

Bu yeni bir verifier rolü gerektirmiyor: R18 Composition Integrity Reviewer bu composite qualification'ı taşımaya adaydır.

### B7-C8 — Genişlemenin mevcut sistem kapsamını nasıl değiştirdiğini değerlendirmek

Yeni bir actor/tool/method/source eklemek yalnız registry satırı eklemek değildir.

Development OS her genişlemede gerektiği ölçüde şu soruları yeniden açmalıdır:

- yeni actor hangi Information/context'e girecek;
- Work coordination/frontier nasıl değişecek;
- authority/control kapsamı genişliyor mu;
- yeni effect path veya bypass oluşuyor mu;
- verification coverage değişiyor mu;
- recovery/continuity kapsamı yeni parçayı taşıyor mu;
- mevcut kayıt/observability yüzeyi yeni parçayı görebiliyor mu.

Bu, kullanıcının EXP-004'te tarif ettiği “yeni işlevlerle mevcut işlevlerin kapsamının da genişlemesi” düşüncesinin Work-level karşılığıdır.

### B7-C9 — Çalışma sırasında configuration'ı reconfigure etmek

Mission başında kurulan sistem immutable değildir.

Yeni Work, yeni bilgi, failure, capability loss veya değişen risk karşısında Development OS:

- yeni kapasite ekleme;
- role/actor değiştirme;
- method değiştirme;
- tool/environment değiştirme;
- control/verification yoğunluğunu değiştirme;
- kullanılmayan kapasiteyi devreden çıkarma

kararlarını üretebilmelidir.

Reconfiguration, üst amaç/mandate'i sessizce değiştirmemelidir. Actual activation/effect yine B6/B5 kontrollerine tabidir.

### B7-C10 — Gereksiz sistem büyümesini ve meta-recursion'ı sınırlamak

System formation kendi başına sonsuz bir proje olmamalıdır.

Development OS:

- basit Work'te gereksiz multi-agent/harness kurmama;
- sırf yeni mekanizma mevcut diye kullanmama;
- aynı işlevi sağlayan duplicate kapasite oluşturmama;
- formation Work'ünü asıl teslimatı sürekli erteleyen meta-work'e çevirmeme;
- bütün gelecekteki ihtiyaçları baştan çözmeye çalışma yerine bounded formation kullanma

disiplinini taşımalıdır.

En küçük sistem hedefi “en az bileşen” değil, **mevcut koşullarda yeterli ve yönetilebilir sistem** olmalıdır.

### B7-C11 — Configuration lifecycle ve retirement'ı yönetmek

İş bittiğinde veya ihtiyaç ortadan kalktığında her role/tool/configuration aktif kalmamalıdır.

Development OS gerektiğinde:

- role deactivation;
- grant revocation;
- environment teardown;
- tool unbinding;
- temporary context/method kaldırma;
- reusable lesson/capability'yi uygun library/state'e taşıma;
- Work/evidence/history'yi silmeden operational component'i retire etme

işlerini yönetebilmelidir.

B8 uzun dönem continuity ve learning lifecycle'ını daha geniş ele alacaktır.

### B7-C12 — System-formation failure'ını teşhis etmek

Configuration başarısız olduğunda Development OS şu nedenleri ayırabilmelidir:

- ihtiyaç/gap yanlış keşfedildi;
- gereksiz kapasite eklendi;
- gerekli kapasite hiç eklenmedi;
- yanlış actor/method/tool seçildi;
- component'ler ayrı ayrı iyi ama birlikte uyumsuz;
- activation incomplete;
- authority/control/effect path eksik;
- environment değişti;
- configuration fazla karmaşık ve kendi coordination maliyeti başarısızlık üretiyor.

Bu teşhis mevcut R3'ün cross-domain failure diagnosis rolünü B7'ye de genişletir.

## B7 sınırı

B7 tek başına uzun dönem state continuity/recovery/learning'i çözmez — B8. Ortaya çıkan bütün SOUL'un farklı gerçek görevlerde yeterli olduğunu kanıtlamaz — B9.

B7'nin işi, **belirli bir amaç için gerekli çalışma sistemini keşfetmek, yeterli parçaları seçmek, birlikte uygulanabilir configuration kurmak ve ihtiyaç değiştikçe kontrollü biçimde genişletmek/sadeleştirmektir.**

## B7'den türeyen Development OS taşıyıcıları

### R19 — Working System Formation Designer / Çalışma Sistemi Oluşum Tasarımcısı

**Taşıdığı B7 sorumlulukları:** C1, C2'nin requirement-facing tarafı, C3, C4, C5, C8 ve C9'un reconfiguration tasarım tarafı.

Temel amacı:

> Amaç ve Work için hangi çalışma sistemi kapasitesinin gerçekten gerektiğini keşfetmek; mevcut kapasiteyi ve gap'leri değerlendirip yeterli Working Configuration'ı tasarlamak.

Bu rol:

- capability requirement çıkarır;
- base capability/current inventory'yi kullanır;
- gap analizi yapar;
- reuse/configure/acquire/create/defer seçeneklerini karşılaştırır;
- component listesi değil birlikte uygulanabilir configuration tasarlar;
- genişlemenin existing control/context/verification/recovery kapsamına etkisini hesaba katar;
- gereksiz complexity'yi sınırlar.

**R16 ile farkı:** R16 exact cross-ground semantic binding/qualification'ı tasarlar. R19 belirli mission için **hangi kapasite ve configuration'ın var olması gerektiğine** karar verir ve R16'yı gerektiği yerde kullanır.

### R20 — Working Configuration Assembly Steward / Çalışma Konfigürasyonu Kurulum Sorumlusu

**Taşıdığı B7 sorumlulukları:** C2'nin actual-currentness tarafı, C6, C8'in coverage realization tarafı, C9'un operational reconfiguration tarafı ve C11.

Temel amacı:

> R19'un seçtiği configuration'ın ilgili capability sahipleri üzerinden gerçekten kurulmasını, bağlanmasını, active/candidate sınırının korunmasını ve yaşam döngüsünün yönetilmesini koordine etmek.

Bu rol kendi başına bütün parçaları üretmez. R4/R5 Information, R7–R9 Actors, R10/R11 Work, R13/R14 Environment ve R16/R17 control/composition sahiplerini çağırır; gerekli configuration değişikliklerinin birlikte tamamlanmasını takip eder.

**R11 ile farkı:** R11 mission Work'ünün admission/coordination'ını taşır. R20, o Work'ü yapacak **çalışma sisteminin kurulma/reconfiguration Work'ünü** koordine eder.

### Yeni verifier rolü açılmadı

B7-C7 için yeni R21 oluşturulmadı.

**R18 — Composition Integrity Reviewer**, exact cross-ground facts/bindings üzerinden “bu Working Configuration gerçekten ready/fit mi?” composite standing'ini sınayabilecek doğal role sahiptir.

Bu seçim, her yeni B dalının yeni verifier üretmesi gerekmediğini gösterir.

### Mevcut rollerin B7 ile ilişkisi

- **R3** formation failure diagnosis'ı taşır.
- **R4/R5** Information/context capability'lerini sağlar.
- **R7/R8/R9** role/actor/competence/authority formation'ını sağlar.
- **R10/R11/R12** Work structure/coordination/closure tarafını sağlar.
- **R13/R14/R15** Environment capability/readiness/effect tarafını sağlar.
- **R16/R17/R18** cross-ground fit/control/integrity tarafını sağlar.
- **R19/R20** bu kapasite sahiplerini mission-specific working system formation amacıyla seçip koordine eder; onların uzmanlıklarını kendinde eritmez.

## Mekanik sorumluluk

### M7 — Working Configuration Binding & Activation Substrate

Bu bir AI rolü değildir.

Aday mekanik sorumluluklar:

- configuration identity/version;
- exact component bindings: actor-role, Work, method, Information/context, tool/environment, grant/control;
- candidate / staged / active / retired configuration ayrımı;
- active scope ve mission/work binding;
- component version/currentness binding;
- activation/deactivation/rebinding desteği;
- configuration diff/change trace;
- incomplete activation veya stale component kullanımını fail-visible kılacak durum;
- M1–M6 mekaniklerinin aynı active configuration ile ilişkilendirilmesi.

M7 tek bir merkezi config service veya atomic commit mimarisi kararı değildir. Working Configuration'ın gerçek teknik identity/activation yüzeyine duyulan sorumluluğu belirtir.

## İnsan müşterinin B7'deki yeri

B7 müşteriyi solution architect veya system configurator yapmaz.

Müşteri mandate, kapsam/değer tercihi ve kabul sınırlarında kalır. Yeni configuration verilmiş mandate'i aşan credential, dış hesap, harcama, irreversible effect veya başka authority gerektiriyorsa ilgili insan yetkisi gerekir.

Hangi actor/tool/context/control kombinasyonunun teknik olarak gerekli olduğunu keşfetmek müşterinin yükü değildir.

## İlk B7 formation akışı

```text
amaç + current Work + mevcut baz SOUL
              ↓
R19 Working System Formation Designer
   │ requirements / gaps / reuse-create decisions
   ▼
R4/R7/R10/R13/R16 ... capability owners
   │ component formation / preparation
   ▼
R20 Working Configuration Assembly Steward
   │ assemble / bind / activate / expand / retire
   ▼
M7 + M1–M6
   │ active Working Configuration
   ▼
R18 Composition Integrity Reviewer
   │ joint readiness / fit
   ▼
R11 mission Work admission
   │
   ▼
execution
   │
   ▼
R3 failure diagnosis → R19 reformation gerekirse
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B7'den çıkan artefakt/sözleşme adayları

- **System Requirement Set:** bu mission için gerekli capacity families ve gerekçeleri.
- **Capability Inventory / Gap Case:** mevcut gerçek kapasite, yeterlilik ve eksikler.
- **Formation Decision:** reuse/configure/acquire/create/defer seçimi ve dayanağı.
- **Working Configuration:** active Work için birlikte uygulanabilir actor–information–method–work–environment–control bileşimi.
- **Configuration Qualification Case:** joint readiness/fit ve kalan unknown/gap'ler.
- **Extension Impact Case:** yeni capability'nin mevcut context/control/verification/recovery kapsamına etkisi.
- **Reconfiguration / Retirement Case:** ekleme, değiştirme, sadeleştirme veya devreden çıkarma gerekçesi.

Bunlar kesin schema, service, folder, config formatı veya runtime seçimi değildir.