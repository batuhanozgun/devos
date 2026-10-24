# B5 — SOUL'un Environment kapasitesini geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B5'in hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey bir “tool registry” veya tek bir host/runtime seçimi değildir.

Hedef; SOUL'un belirli Work için **hangi gerçek ortam koşullarına, kaynaklara, araçlara, arayüzlere ve çalışma yüzeylerine ihtiyaç duyduğunu anlayabilmesi; bunları gerçekten provision edip kullanılabilir durumda tutabilmesi; aktörün bunlarla güvenilir biçimde etkileşebilmesi; ve yapılan eylemlerin gerçek Environment durumunda hangi etkiyi oluşturduğunu gözleyebilmesi**dir.

B5 yalnız Technical Work Environment değildir. Foundation Environment iki geniş yüzeyi birlikte korur:

- **Work Conditions:** Work'ün yapılabilmesi için gereken realized koşullar;
- **Domain Reality:** Work'ün hakkında olduğu veya etkilediği gerçek durum/dinamikler.

Bu nedenle bir tool call'un dönmesi veya bir süreç kaydının success olması, hedef Environment'ta beklenen etkinin gerçekten oluştuğunu tek başına göstermez.

## Development OS'un B5 için gerekli kabiliyet ve sorumlulukları

### B5-C1 — Work ve actor ihtiyacından Environment gereksinimi çıkarmak

Development OS, “hangi tool lazım?” sorusuyla başlamamalıdır.

Belirli Work ve actor için gerektiğinde compute/runtime, workspace/filesystem, sandbox/isolation, tool/service/API, data/source erişimi, network, credential/identity binding, resource/capacity, interface/coupling surface, temporal window, safety/operating condition ve domain observation/effect surface gereksinimlerini ayırabilmelidir.

Çıktı önce teknoloji adı değil, **Environment requirement** olmalıdır.

### B5-C2 — Kayıtlı capability ile fiilen mevcut capability'yi ayırmak

Bir capability kataloğunda bir aracın var görünmesi fiilî kullanılabilirlik değildir.

Development OS gerektiğinde kaynağın gerçekten mevcut, doğru sürümde, erişilebilir, initialized/healthy, ilgili actor/work tarafından kullanılabilir, yeterli capacity'de ve gerekli bağımlılıkları ayakta olup olmadığını gözleyebilmelidir.

Önemli ayrım: exists ≠ accessible ≠ available ≠ healthy ≠ sufficient.

### B5-C3 — Uygun Environment configuration'ını seçmek

Development OS her Work'ü aynı ortamda çalıştırmayı varsaymamalıdır.

İhtiyaca göre mevcut host'u kullanma, ayrı workspace/sandbox oluşturma, farklı tool/interface bağlama, özel runtime/service kullanma, başka execution environment'a geçme veya daha basit bir ortamla yetinme seçeneklerini değerlendirebilmelidir.

Claude Code, Codex, Hermes veya başka bir sistem ancak bu gereksinimlere cevap veren aday taşıyıcılar olabilir; B5 bunlardan birini varsayılan mimari ilan etmez.

### B5-C4 — Environment'ı provision etmek ve aktöre bağlamak

Seçilen Environment yalnız tasarım olarak kalmamalıdır.

Development OS teknik olarak mümkün olduğunda workspace/runtime oluşturma, tool/service bağlama, gerekli data/source yüzeylerini sunma, dependency/configuration hazırlama, network/interface erişimi açma, credential/identity'yi doğru actor-role scope'una bağlama ve environment'ı devralınabilir hâle getirme işlerini gerçekleştirebilmeli veya gerçekleştirilmesini sağlayabilmelidir.

Yetki kaynağı B3/R9'dur; technical effect power bunu ikame etmez.

### B5-C5 — Aktör–Environment arayüzünü kullanılabilir ve okunabilir hâle getirmek

Capability'nin var olması, aktörün onu etkili kullanabildiğini göstermez.

Development OS tool/interface affordance'larını, input/output biçimini, hata ve durum geri bildirimini, actor'un ortam durumunu görebilmesini, tool sonucunu yanlış yorumlama riskini ve gerekli source/readback yolunu değerlendirebilmelidir.

Model sabitken kötü bir arayüz de başarısızlık üretebilir.

### B5-C6 — Readiness, health, capacity ve sufficiency'yi değerlendirmek

Environment'ın var olması yeterli değildir.

Development OS belirli Work için Environment'ın hazır mı, degraded mı, capacity bakımından yeterli mi, shared contention içeriyor mu, required dependency'leri hazır mı, güvenli/uygun operating condition sağlanıyor mu ve koşulların Work sırasında bozulup bozulamayacağını değerlendirebilmelidir.

B4 Work readiness'i, B3 actor competence/authority'yi taşır. B5 realized Environment condition'ı taşır. Tam situated actionability B6'da birleşecektir.

### B5-C7 — Isolation, boundary ve kaynak kullanım koşullarını kurmak

Bazı Work'ler için environment yalnız enable eden değil aynı zamanda sınırlandıran bir yüzeydir.

Development OS gerektiğinde filesystem/network isolation, sandbox, resource limits/budgets, tenant/project separation, destructive/irreversible operation boundaries ve secret/credential exposure boundaries gereksinimlerini kurabilmelidir.

Normatif authority R9/M1 ile; gerçek teknik isolation/enforcement B5 mekanikleriyle ilgilidir.

### B5-C8 — Eylem isteği, tool invocation ve gerçekleşmiş effect'i ayırmak

Development OS şu zinciri tek olay saymamalıdır: actor istedi → tool çağrıldı → success döndü → hedef gerçekten değişti.

Gerektiğinde intended action, exact target/payload, tool invocation, provider/runtime response, partial/unknown effect, authoritative readback ve actual Environment effect ayrı izlenmelidir.

Timeout veya bağlantı kaybı etki olmadı kanıtı değildir. Tool success da gerçek outcome başarısı değildir.

### B5-C9 — Domain Reality'yi gözlemek ve gerçek sonucu Work kaydından bağımsız değerlendirmek

SOUL yalnız çalışma ortamını değil, Work'ün etkilediği gerçek domain'i de gözleyebilmelidir.

Development OS gerektiğinde before/after realized state, domain condition, gerçekleşen değişim, gecikmiş/partial/reversed effect, unintended side effect ve dış disturbance gibi gerçeklikleri gözlenebilir kılmalıdır.

Work closure B4'te; bunun gerçek Environment'ta karşılığının bulunup bulunmadığı B5'tedir.

### B5-C10 — Environment drift ve dependency değişikliğini fark etmek

Environment statik kabul edilmemelidir.

Development OS tool/service version değişimi, dependency kaybı, credential expiration/revocation, network/configuration değişimi, model-harness compatibility değişimi, capacity daralması veya dış sistem değişimi gibi olayların önceki readiness/actionability hükümlerini geçersiz kılabileceğini fark edebilmelidir.

B8 daha geniş change/recovery lifecycle'ını taşıyacaktır; B5 Environment-side invalidation sinyalini ve yeniden qualification ihtiyacını üretir.

### B5-C11 — Environment failure'ını teşhis etmek

Bir actor işi yapamadığında sorun otomatik actor yetersiz veya tool bozuk değildir.

Development OS required capability yokluğu, access yokluğu, authority yokluğu, service degradation, capacity yetersizliği, kötü interface, dependency/common-mode failure, isolation sorunu, unknown effect, effect var ama outcome yok veya Environment değiştiği halde stale kayıt/context kullanılması gibi failure sınıflarını ayırabilmelidir.

Bu teşhis mevcut R3'ü B5'e de genişletmeye adaydır.

## B5 sınırı

B5 tek başına actor authority/obligation'ı belirlemez — B3; Work selection/admission'ı belirlemez — B4; Information/provenance/context semantiğini kurmaz — B2; cross-ground actionability hükmünün tamamını tek başına vermez — B6; continuity/recovery'nin bütününü çözmez — B8.

B5, SOUL'un **gerçek dünyada nerede ve hangi koşullarda çalıştığını, neye fiilen erişebildiğini, ortamı nasıl kurup kullanabildiğini ve eylemlerinin gerçek Environment'taki karşılığını nasıl gözlediğini** Development OS'un nasıl geliştireceğini ele alır.

## B5'ten türeyen Development OS taşıyıcıları

### R13 — Environment & Capability Formation Designer / Ortam ve Kabiliyet Oluşum Tasarımcısı

**Taşıdığı B5 sorumlulukları:** C1, C3, C4'ün tasarım tarafı, C5'in interface requirement tarafı ve C7'nin environment-boundary tasarımı.

Temel amacı:

> Work ve actor gereksinimlerini, gerekli Environment capability/configuration/provisioning planına dönüştürmek.

Bu rol Work/role'den Environment requirement çıkarır; mevcut ortamı kullanma ile yeni ortam kurma seçeneklerini karşılaştırır; host/runtime/workspace/tool/data/network/interface gereksinimini tasarlar; actor-environment coupling'in nasıl kurulacağını belirler; isolation/resource boundary gereksinimlerini çıkarır; environment complexity eklemeden önce ihtiyacı gerekçelendirir.

**Sınır:** actual availability/readiness'i kendi tasarım beyanıyla kanıtlamaz; authority üretmez; tool/provider seçimi ancak gereksinim ve sınama üzerinden yapılır.

### R14 — Environment Operations & Readiness Steward / Ortam İşletim ve Hazırlık Sorumlusu

**Taşıdığı B5 sorumlulukları:** C2, C4'ün operasyon tarafı, C6, C7'nin operating tarafı ve C10.

Temel amacı:

> Seçilmiş Environment'ın gerçek durumda provision edilmiş, erişilebilir, healthy, yeterli ve sürdürülebilir biçimde Work'e hizmet ettiğini yönetmek.

Bu rol capability inventory ile actual availability'yi uzlaştırır; provisioning/configuration durumunu izler; dependency/health/capacity/contention koşullarını değerlendirir; environment drift'i fark eder; readiness hükmünü koşullar değişince yeniden açar; teardown/rebuild/rebind ihtiyacını görünür kılar.

**R11 ile farkı:** R11 Work admission/coordination'ı yönetir; R14 Environment'ın Work'ü gerçekten destekleyebilecek durumda olup olmadığını yönetir.

### R15 — Environment Reality & Effect Reviewer / Ortam Gerçekliği ve Etki Doğrulayıcısı

**Taşıdığı B5 sorumlulukları:** C5'in observation tarafı, C8, C9 ve C11'in bağımsız inceleme tarafı.

Temel amacı:

> Tool/runtime kayıtlarından bağımsız olarak gerçek Environment durumunun ve eylemin gerçekleşmiş etkisinin iddia edildiği gibi olup olmadığını sınamak.

Bu rol tool success ile actual effect'i ayırır; timeout/partial/unknown effect durumlarını görünür tutar; authoritative readback veya uygun observation arar; Work completion ile gerçek domain outcome'u eşitlemez; unintended side effect veya disturbance'ı arar; environment-side failure ile actor/work/information failure'ını ayırmaya yardım eder.

**R12 ile farkı:** R12 Work progress/closure iddiasını sınar. R15 gerçek Environment state/effect iddiasını sınar.

### Mevcut rollerin B5 ile ilişkisi

- **R3** B5-C11 failure diagnosis'ı da taşıyacak şekilde genişlemeye adaydır.
- **R5** actor'a Environment hakkında hangi Information'ın sunulacağını kurar; R14 actual Environment state'i sağlar.
- **R7/R8** actor'ın rol ve competence tarafını taşır; R13/R14 Environment fit/actionability'nin condition tarafını taşır.
- **R9** authority/delegation sınırını korur; credential veya technical reach bunu ikame etmez.
- **R11** Work admission/coordination için R14'ün readiness/capacity bilgisini kullanabilir.
- **R12** closure değerlendirmesinde R15'in actual effect evidence'ına ihtiyaç duyabilir.

## Mekanik sorumluluklar

### M4 — Environment Provisioning & Isolation Substrate

Bu bir AI rolü değildir.

Aday mekanik sorumluluklar: runtime/process/session oluşturma; workspace/filesystem; sandbox/container/isolation; tool/service bindings; network/data mounts; dependency/configuration setup; resource limits; health/liveness/readiness probes; cleanup/teardown/rebuild.

Bu substrate Environment'ı doğru seçtiğini kanıtlamaz; R13/R14'ün kararlarını teknik olarak gerçekleştirebilecek yüzeydir.

### M5 — Effect Execution, Readback & Observability Substrate

Bu da AI rolü değildir.

Aday mekanik sorumluluklar: exact operation/target/payload binding; tool/API invocation; operation identity/idempotency desteği; timeout/partial/unknown result durumunu koruma; authoritative readback; logs/metrics/traces; actual actor/tool/environment event gözlenebilirliği; effect sonucu ile Work/Information kayıtlarının uzlaştırılmasına veri sağlama.

M1 authority/enforcement, M3 Work transition ve M5 effect execution birlikte ileride B6'da cross-ground control olarak yeniden ele alınacaktır.

## İnsan müşterinin B5'teki yeri

B5 müşteriyi runtime operator veya environment engineer yapmaz.

İnsan bazı durumlarda kendisine ait credential/hesap için yetki vermek, dış sisteme erişim onayı sağlamak veya fiziksel/kurumsal olarak yalnız kendisinin sağlayabileceği bir kaynağı temin etmek zorunda olabilir.

Bu durum teknik environment keşfi, configuration, health/readiness veya effect verification yükünü genel olarak müşteriye taşımaz.

## İlk B5 rol akışı

```text
Work + role requirements
      ↓
R13 Environment & Capability Formation Designer
      │ environment requirements / configuration
      ▼
R9 authority boundary + M1 grant enforcement
      │
      ▼
M4 provision / bind / isolate
      │
      ▼
R14 Environment Operations & Readiness Steward
      │ actual availability / health / capacity
      ├──────────────► R11 Work admission/coordination
      ▼
actor + M5 effect execution
      │
      ▼
R15 Environment Reality & Effect Reviewer
      │ actual state/effect evidence
      ├──────────────► R12 Work closure
      ▼
R3 failure diagnosis
      └──────────────► R13/R14 veya ilgili B dalı
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B5'ten çıkan artefakt/sözleşme adayları

- **Environment Requirement:** Work/Actor için gerekli capability, interface, resource, condition ve observation yüzeyi.
- **Environment Configuration:** seçilmiş host/runtime/workspace/tool/data/network/isolation bileşimi.
- **Provisioning / Binding Record:** neyin gerçekten oluşturulduğu ve hangi actor/work scope'una bağlandığı.
- **Readiness / Health Case:** availability, dependency, capacity, compatibility ve temporal validity değerlendirmesi.
- **Effect Intent / Operation Record:** exact hedef, işlem ve payload.
- **Effect / Readback Evidence:** tool response'tan ayrı actual effect gözlemi.
- **Environment Drift / Invalidation Event:** önceki readiness/actionability hükmünü etkileyen değişiklik.
- **Environment Failure / Change Proposal:** failure sınıfı ve yeniden açılacak Work.

Bunlar kesin dosya, tablo, servis veya ürün adları değildir.