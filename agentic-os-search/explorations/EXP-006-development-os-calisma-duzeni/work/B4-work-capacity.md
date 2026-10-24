# B4 — SOUL'un Work kapasitesini geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B4'ün hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey bir “task tracker”, sabit workflow veya tek bir project-manager rolü değildir.

Hedef; SOUL'un amaç ve değişen çalışma anlayışından **gerekli Work'ü keşfedebilmesi**, Work'ü anlamlı düzeylerde ve ilişkilerle yapılandırabilmesi, aday işi yürütmeye kabul etmekle gerçek yürütmeyi ayırabilmesi, yaşayan planı gerçek Work ile birlikte güncelleyebilmesi, bağımlılık/koordinasyon/akışı yönetebilmesi ve kapanış–yeniden açılma–recovery kararlarını doğru statüyle taşıyabilmesidir.

Bu kapasite en azından şu ayrımları korumalıdır:

- amaç / aranan sonuç ≠ Work ≠ yöntem;
- candidate/possible Work ≠ eligible/applicable Work ≠ admitted/committed Work ≠ active execution;
- plan/prescribed Work ≠ actual enacted Work;
- alt Work'lerin kapanması ≠ üst sonucun gerçekleşmesi;
- readiness ≠ Environment capability ≠ Actor authorization;
- execution complete ≠ verified ≠ validated/fit ≠ accepted;
- failure ≠ terminal yok oluş; yeni Work üretebilir;
- bounded Work ≠ continuing/supporting Work;
- Work hakkında yazılan kayıt ≠ gerçek Work durumu.

## Development OS'un B4 için gerekli kabiliyet ve sorumlulukları

### B4-C1 — Amaçtan Work çerçevesi kurmak

Development OS, mevcut amaç/sonuç anlayışını doğrudan görev adına çevirmemelidir.

Şunları ayırabilmelidir:

- neyin gerçekleşmesi isteniyor;
- bu sonuç için hangi uğraş/Work alanları gerekli olabilir;
- hangi yöntemler yalnız alternatif gerçekleştirme yollarıdır;
- hangi Work daha geniş bir faaliyetin/parçanın içinde anlam kazanır.

Amaç, Work ve yöntemin birbirine karışmaması; yöntem değişse bile üst gereğin kaybolmamasıdır.

### B4-C2 — Aday Work keşfetmek ve doğuş gerekçesini korumak

Development OS yalnız kullanıcının açıkça verdiği işleri kaydetmez.

Gerekli olduğunda üretim, araştırma/investigation, karar hazırlama, doğrulama, koordinasyon, support/enablement, recovery/repair ve meta-work gibi yeni Work adayları keşfedebilmelidir.

Her adayın hangi ihtiyaç, koşul, bulgu veya failure'dan doğduğu korunmalıdır. “Bulundu” olması otomatik commitment değildir.

RPD burada aday Work keşfinin yöntemlerinden biridir; B4 RPD ile özdeş değildir.

### B4-C3 — Work'ü yaşayan ve çoğul bir plan içinde yapılandırmak

Development OS, işi yalnız düz task listesine dönüştürmemelidir.

Belirli girişim için gerektiğinde üst/alt contribution ilişkileri, alternatif refinement/method yolları, bağımlılıklar, koşullu dallar, kısmi sıralamalar, gelecekte ayrıntılandırılacak Work, bütün içindeki mevcut odak ve geri dönüş noktaları korunabilmelidir.

Planın ayrıntı seviyesi zamanla artabilir. Plan değişikliği otomatik scope drift değildir; learning-driven elaboration olabilir.

### B4-C4 — Aday Work'ü seçmek, önceliklendirmek ve admission/frontier oluşturmak

Development OS her aday işi yürütmeye açmamalıdır.

Şunları ayırabilmelidir: aday mevcut mu; şu anda applicable/eligible mı; alternatiflere göre seçilmeli mi; commitment/admission verildi mi; gerçekten başlanabilir mi; yürütme başladı mı.

Öncelik tek bir timeless sayı değildir; değer, urgency, dependency, capacity, risk ve diğer adaylarla ilişkili olabilir.

B4 Work-level selection/admission semantiğini taşır. Actor authority B3; gerçek Environment capacity/actionability B5; bunların birlikte readiness'i B6'da birleşir.

### B4-C5 — Bağımlılık, concurrency ve koordinasyon Work'ünü yönetmek

Development OS, “blocked/ready” gibi durumları yalnız item-local status olarak ele almamalıdır.

Prerequisite / producer-consumer ilişkileri, shared-resource contention, partial order, paralel ilerleyebilen dallar, synchronization noktaları, handoff, merge/integration, bekleme ve change sonrası yeniden koordinasyon yönetilebilmelidir.

Koordinasyonun kendisi gerçek Work olabilir; görünmez “administrative overhead” sayılmamalıdır.

### B4-C6 — Planlanan Work ile gerçek yürütmeyi ayrı izlemek

Development OS, plan dosyasını actual Work sanmamalıdır.

Belirli Work için gerektiğinde planlanan yöntem/sıra, gerçekten başlatılan execution/run, suspension, failure, termination, completion, sapma/adaptation ve fiilî sonuç/etki hakkında evidence ayrı tutulabilmelidir.

Planın değişmesi ile gerçek dünyada işin değişmiş olması aynı şey değildir.

B2 actual state hakkındaki Information'ı korur; B4 hangi Work semantiğinin izlenmesi gerektiğini tanımlar.

### B4-C7 — Yerel ilerleme ile bütünsel progress/flow'u ayırmak

Development OS, daha çok aktif iş veya daha çok kapanmış alt görev gördüğünde otomatik “ilerliyoruz” dememelidir.

Alt işin üst sonuca katkısı, waiting vs processing, effort vs duration vs elapsed time, WIP/congestion, bottleneck, downstream overload ve local optimization'ın bütün Work'e etkisi değerlendirilebilmelidir.

Progress gerekirse item, network ve system-flow seviyelerinde farklı görünebilir.

### B4-C8 — Kapanışın ne anlama geldiğini belirlemek

Development OS, tek bir done etiketiyle kapanışı temsil etmemelidir.

Gerektiğinde ayrı sorular sormalıdır: execution gerçekten kapandı mı; beklenen Work çıktısı üretildi mi; requirement verification gerekli mi ve geçti mi; intended-use validation/fitness sağlandı mı; üst hedef/target condition gerçekleşti mi; acceptance için yetkili hüküm var mı; parent Work'ün kapanış koşulu ayrıca sağlandı mı.

B9 bütün SOUL yeterliğini test edecektir; B4 burada SOUL'un günlük Work closure kapasitesini geliştirir.

### B4-C9 — Değişiklik, failure, rework ve recovery'den yeni Work üretmek

Development OS, failure veya yeni bilgi geldiğinde Work'ü yalnız “cancelled” veya “done değil” diye bırakmamalıdır.

Gerekirse diagnosis, remediation, retry, compensation, reconciliation, revalidation, replanning ve yeniden koordinasyon Work'leri açılabilmelidir.

Ayrıca değişiklik normal progressive elaboration, yeni bilgiyle adaptive replanning, scope/goal change, yanlış plan/failure veya uncontrolled drift olarak ayrılabilmelidir.

B8 daha geniş continuity/change/recovery kapasitesini ele alacaktır; B4 bunun Work üretme ve Work state tarafını taşır.

### B4-C10 — Bounded ve continuing Work'ü ayırmak

Her anlamlı Work tek final done durumuna sahip değildir.

Development OS; tek sonuçla kapanması beklenen bounded Work, süreğen stewardship, recurring/triggered Work, monitoring/support ve dönemsel episode'lar arasında ayrım yapabilmelidir.

Bir episode tamamlanırken standing/continuing responsibility açık kalabilir.

### B4-C11 — Work-system failure'ını teşhis etmek

Work kötü ilerlediğinde sorun otomatik “yanlış plan” değildir.

Development OS; amaç/Work çerçevesi, eksik Work keşfi, refinement/dependency, premature admission, priority/capacity, coordination/handoff, actor/authority, Information/context, Environment actionability, actual Work–record uyuşmazlığı, closure/oracle veya false terminality gibi nedenleri ayırabilmelidir.

Bu teşhis mevcut R3'ün cross-domain değişiklik analizi rolünü B4'e genişletmeye adaydır.

## B4 sınırı

B4 tek başına aktörün yetkisini/competence'ini belirlemez — B3; gerekli bilgi/context mekanizmasını kurmaz — B2; tool/runtime/resource availability sağlamaz — B5; readiness/authority/effect gibi cross-ground bileşimleri tek başına çözmez — B6; continuity/recovery'nin tüm sistem seviyesini çözmez — B8.

B4, SOUL'un **neyi Work saydığı, neyi henüz aday tuttuğu, nasıl yapılandırdığı, neyi ne zaman yürütmeye aldığı, gerçek ilerlemeyi nasıl izlediği ve ne zaman kapatıp/reopen ettiği** kapasiteyi Development OS'un nasıl geliştireceğini ele alır.

## B4'ten türeyen Development OS taşıyıcıları

### R10 — Work Formation & Planning Designer / İş Oluşum ve Yaşayan Plan Tasarımcısı

**Taşıdığı B4 sorumlulukları:** C1, C2, C3 ve C9'un replanning/formation tarafı.

Temel amacı:

> Amaç ve gelişen anlayıştan gerekli Work adaylarını keşfetmek, bunların neden var olduğunu korumak ve bütünü kaybetmeden yaşayan Work/plan yapısına dönüştürmek.

Bu rol amaç / Work / yöntem ayrımını korur; aday Work keşfeder; Work'ü anlamlı units/networks/refinements halinde yapılandırır; alternative/conditional yolları saklar; planı progressive elaboration ile günceller; yeni bilgi/failure sonucu gerekli Work değişikliklerini önerir.

**R7 ile farkı:** R10 “hangi Work var ve nasıl ilişkileniyor?” sorusunu taşır. R7 bu Work ihtiyacından “hangi rol/actor katkısı gerekir?” sorusuna geçer.

### R11 — Work Admission & Coordination Steward / İş Kabul ve Koordinasyon Sorumlusu

**Taşıdığı B4 sorumlulukları:** C4, C5, C6'nın admission/coordination tarafı, C7'nin flow tarafı ve C10'un operational control tarafı.

Temel amacı:

> Aday Work'ler arasından hangisinin ne zaman commitment/admission alabileceğini ve yürüyen Work'lerin dependency, concurrency, handoff ve system-flow açısından nasıl birlikte ilerleyeceğini yönetmek.

Bu rol candidate / eligible / admitted / active ayrımını korur; frontier/priority kararlarını gerekçelendirir; dependency ve partial-order ilişkilerini izler; coordination Work'ü görünür tutar; paralellik, waiting, synchronization ve bottleneck etkisini değerlendirir; planlanan ile actual Work arasındaki sapmayı görünür kılar; local progress'in system progress olmadığını hesaba katar.

**Sınır:** Gerçek actor authority R9/B3; actual Environment capacity B5; mekanik dispatch/claim/enforcement B5/B6'dır.

### R12 — Work Progress & Closure Reviewer / İş İlerleme ve Kapanış Doğrulayıcısı

**Taşıdığı B4 sorumlulukları:** C7'nin progress-evaluation tarafı, C8, C9'un reopen/recovery değerlendirmesi ve C10'un closure ayrımı.

Temel amacı:

> Work'ün gerçekten anlamlı ilerleme gösterip göstermediğini ve kapanış iddiasının hangi seviyede geçerli olduğunu bağımsız biçimde sınamak.

Bu rol alt görev kapanışını üst outcome'a eşitlemez; execution complete / verified / valid-fit / accepted ayrımlarını korur; parent closure condition'ı ayrıca değerlendirir; failure sonrası gerekli recovery/rework Work'ünü görünür kılar; bounded episode kapanışı ile continuing responsibility'nin sürmesini ayırır; “çok şey yaptık” ile “hedefe ilerledik” iddiasını ayırır.

**R2/R6/R8 ile ilişki:** Bunların hepsi verification ailesine benzeyebilir ama doğruladıkları iddia farklıdır: R2 ortak davranış; R6 bilgi zinciri; R8 role competence; R12 Work progress/closure.

İleride bunların tek verification organization içinde birleşip birleşmeyeceği ayrıca değerlendirilebilir.

### Mevcut rollerin B4 ile ilişkisi

- **R3** B4-C11 Work failure diagnosis'ı da taşıyacak şekilde genişlemeye adaydır.
- **R5** belirli Work için context kurar; Work'ün ne olduğu ve current state'i R10/R11'den gelir.
- **R7** R10'un keşfettiği Work taleplerinden rol/actor gereksinimi çıkarır.
- **R9** admission/termination/acceptance gibi Work kararlarının actor-side authority sınırını korur.

### M3 — Work state / admission / transition mekanik sorumluluğu

B4 ilk kez ayrı bir Work-mechanics gereksinimini görünür kılıyor.

Bu bir yapay zekâ rolü değildir.

Gelecekte gerçek sistemde persistent Work identity; candidate/eligible/admitted/active state ayrımları; dependency ve return-to bağları; claim/reservation/dispatch; guarded state transitions; suspension/resume/termination; actual Run/effect ile Work standing'in uzlaştırılması; stale/late result admission kontrolü; Work history ve reopening bağı gibi mekanik sorumluluklar gerekebilir.

**Sınır:** Bu mekanizma gerçek Work truth'unu kendiliğinden üretmez. Bir kayıt active diye yazıyor diye fiilî execution kanıtlanmış olmaz. Teknik implementation B5/B6'da ele alınacaktır; Information persistence M2 ile ilişkilidir.

## İnsan müşterinin B4'teki yeri

B4 müşteriye project-manager rolü yüklemez.

Müşteri üst mandate/yetki kaynağı, gerektiğinde kapsam/amaç değişikliğinin yetkili tarafı ve nihai kabul makamı olarak kalır.

Hangi alt işin keşfedileceği, nasıl ayrıştırılacağı, dependency/priority/frontier'ın nasıl yönetileceği veya hangi recovery Work'ünün açılacağı varsayılan olarak müşterinin teknik koordinasyon yükü değildir.

## İlk B4 rol akışı

```text
amaç / gelişen anlayış
    ↓
R10 Work Formation & Planning Designer
    │ Work candidates + living plan + dependencies
    ↓
R11 Work Admission & Coordination Steward
    │ selected/admitted frontier + coordination
    ├──────────────► R7 role/actor formation
    ├──────────────► R5 context formation
    ├──────────────► R9 authority boundary
    ↓
M3 + ileride B5/B6
    │ actual dispatch / transition / run bağları
    ↓
gerçek yürütme
    ↓
R12 Work Progress & Closure Reviewer
    │ progress / closure / reopen evidence
    ↓
R3 failure diagnosis
    └──────────────► R10/R11 veya ilgili B dalı
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B4'ten çıkan artefakt/sözleşme adayları

- **Work Candidate / Origin:** neden bu Work var, hangi ihtiyaç/bulgu/failure'dan doğdu.
- **Living Work Plan:** üst-alt contribution, alternative refinement, dependency, conditional branch, focus ve return-to ilişkileri.
- **Admission / Frontier Decision:** adayın neden seçildiği/ertelendiği/reddedildiği ve hangi koşullarda başlanabilir olduğu.
- **Coordination / Dependency View:** ordering, concurrency, shared resource, waiting, handoff ve synchronization.
- **Actual Work / Run Standing:** planlanan ile fiilî yürütmenin ayrıldığı current görünüm.
- **Progress / Flow Evidence:** yerel ve system-level ilerlemenin dayanakları.
- **Closure / Reopen Case:** execution, verification, fitness, acceptance ve parent outcome ayrımı.
- **Recovery / Rework Work:** failure/değişiklikten doğan yeni Work ve geri dönüş noktası.

Bunlar kesin dosya, tablo veya servis adları değildir.