# B3 — SOUL'un Actors kapasitesini geliştirmek

**Parent:** [WORK](../WORK.md)  
**Statü:** EXPLORED / candidate decomposition.  
**Authority notu:** Bu dosya B-dalı reference decomposition'ıdır; current sequencing authority değildir. Current yön `../STATE.md → ../HANDOFF.md → ../WORK.md` yolundan alınır. Bu dosyadaki tarihsel next/return ifadeleri current talimat sayılmaz.

## B3'ün hedef çıktısı

Development OS'un burada üretmeye çalıştığı şey bir “agent üretme fonksiyonu” değildir.

Hedef; SOUL'un bir Work veya sistem ihtiyacından **gerekli rol/katılım biçimini çıkarabilmesi**, bu rolü taşıyabilecek aktörü seçip/oluşturup doğru kapsamda bağlayabilmesi, yeterlilik–yetki–sorumluluk ayrımlarını koruyabilmesi ve aktör/rol ilişkisini zaman içinde güvenilir biçimde yönetebilmesidir.

Bu kapasite en azından şu ayrımları kaybetmemelidir:

- persistent actor/bearer ≠ role/position;
- role assignment ≠ o anda aktif rol/katılım;
- capability ≠ competence ≠ permission/authority ≠ obligation;
- performer ≠ decider ≠ authorizer ≠ principal/representative ≠ accountable party;
- delegation ≠ impersonation ≠ kendi adına hareket;
- Actor capability ≠ Environment access/actionability;
- Work requiredness/admission ≠ Actor obligation/authorization;
- Work acceptance state ≠ authority to accept;
- çok sayıda aktör ≠ otomatik group/corporate Actor.

## Development OS'un B3 için gerekli kabiliyet ve sorumlulukları

### B3-C1 — Work ihtiyacından rol/katılım gereksinimini keşfetmek

Development OS, hazır bir rol kataloğundan isim seçmek yerine Work'ün ne tür bir katkı, karar pozisyonu, inceleme veya sorumluluk gerektirdiğini çıkarabilmelidir.

Çıktı önce “bir agent lazım” değildir. Örneğin:

- üretme;
- inceleme;
- karar hazırlama;
- karar verme;
- yetkilendirme;
- uzmanlık sağlama;
- gözetim;
- temsil/delegasyon;
- devam eden stewardship

gibi rol/katılım gereksinimleri ortaya çıkabilir.

Hangi Work'ün gerekli olduğunu keşfetmek B4 ile kesişir; B3'ün işi bu Work talebini **Actor/role gereksinimine çevirmektir.**

### B3-C2 — Rol sözleşmesini tanımlamak

Bir rol yalnız isim veya prompt etiketi olmamalıdır.

Development OS, gerektiği ölçüde şunları tanımlayabilmelidir:

- rolün amacı ve başarı yönü;
- beklenen katkı/sorumluluk;
- role özgü yeterlilik gereksinimi;
- R1'den gelen ortak çalışma tabanı;
- karar/öneri/etki yetkisi;
- obligation/duty varsa kapsamı;
- hangi bilgi ve araçlara ihtiyaç duyduğu;
- hangi kararları veremeyeceği;
- hangi durumlarda başka role/escalation'a dönmesi gerektiği;
- hangi rol kombinasyonlarının aynı actor/session içinde çatışabileceği;
- rolün ne zaman aktif sayıldığı ve ne zaman bittiği.

Bu, henüz teknik agent manifest şeması değildir; semantic role contract gereksinimidir.

### B3-C3 — Uygun aktör/bearer adayını oluşturmak veya bağlamak

Development OS, rol ile rolü taşıyan aktörü ayırmalıdır.

Bir rol için:

- mevcut AI actor yeterli mi;
- aynı actor başka bir role ayrı instantiation ile girebilir mi;
- yeni AI actor/oturum/model instance gerekir mi;
- insan/haricî uzman gerçekten mevcut mu;
- deterministik program/servis rolün bir bölümünü taşıyabilir mi

değerlendirilebilir.

Kimlik/continuity korunmalıdır: actor değişse de rol veya Work devam edebilir; aynı actor da zaman içinde farklı roller taşıyabilir.

### B3-C4 — Role özgü yeterliliği / competence'i sınamak

Rol etiketi yeterlilik kanıtı değildir.

Development OS, bir aktörün belirli rol ve kapsam için yeterli olup olmadığını sınayabilmelidir:

- gerekli alan bilgisi/skill var mı;
- görevin karmaşıklığına uygun mu;
- gerekli yöntemleri uygulayabiliyor mu;
- hangi sınırda yeterli olduğu gösterildi;
- küçük test başarısı ne kadar genellenebilir;
- daha güçlü model/uzman/araç desteği gerekiyor mu?

R2 ortak SOUL çalışma tabanını doğrular; B3-C4 ise **role özgü yeterliliği** değerlendirir.

### B3-C5 — Yetki, izin, obligation ve delegation ilişkisini kurmak

Development OS, “yapabiliyor” ile “yapmaya yetkili”yi ayırmalıdır.

Bir actor-role ilişkisi için gerektiğinde:

- authority/permission kaynağı;
- principal/represented party;
- scope;
- süre;
- hangi karar/etki türlerini kapsadığı;
- delegation verilip verilemeyeceği;
- delegation zincirinin sınırı;
- revocation/deactivation koşulu;
- obligation'ın authority'den ayrı durumu

tanımlanmalıdır.

AI kendi authority'sini kendisi üretemez. Delegated authority, kaynak yetkinin kapsamını sessizce aşamaz.

### B3-C6 — Role assignment ile aktif katılımı ve separation-of-duty'yi ayırmak

Bir aktöre rol atanmış olması, o rolün her bağlamda aktif olduğu anlamına gelmez.

Development OS:

- hangi actor'un hangi Work/episode'da hangi rolle aktif olduğunu;
- hangi rol kombinasyonlarının birlikte kullanılamayacağını;
- producer/verifier gibi ayrımların ne zaman ayrı role-instantiation gerektirdiğini;
- assignment'ın obligation veya Work execution ile karıştırılmamasını

yönetebilmelidir.

Gerçek Work admission/dispatch B4; runtime enforcement B5/B6 ile kesişir.

### B3-C7 — Aktör/rol yaşam döngüsünü ve reassignment'ı yönetmek

Aktör veya oturum kaybolduğunda Work ve standing responsibility kaybolmamalıdır.

Development OS:

- rol activate/deactivate;
- actor replacement;
- reassignment;
- delegation transfer/revocation;
- actor/session retirement;
- standing responsibility'nin yeni Work episode'larına tekrar bağlanması

gibi değişiklikleri anlam kaybı olmadan yönetebilmelidir.

Bu alan B8 continuity/recovery ile güçlü biçimde kesişir.

### B3-C8 — Eylem, karar, yetkilendirme ve attribution'ı ayırmak

SOUL'un yaptığı işlerde “kim yaptı?” tek bir soru değildir.

Development OS gerektiğinde ayrı izleyebilmelidir:

- kim operasyonel olarak eylemi yaptı;
- kim kararı verdi;
- kim yetkilendirdi;
- kimin adına hareket edildi;
- hangi role/context altında yapıldı;
- hangi çıktı/etki kime causal/provenance olarak bağlanıyor;
- hangi sorumluluk/accountability ilişkisinin ayrıca kurulması gerekiyor.

Bir AI'nin operasyonel olarak eylemi üretmesi, bütün normatif/kurumsal attribution'ın AI'ye ait olduğu anlamına gelmez.

B2 kayıt/provenance'ı, B6 cross-ground control'u taşır; B3 burada Actor anlamını korur.

### B3-C9 — Multi-actor ve collective düzenlerde Actor seviyelerini ayırmak

SOUL gerektiğinde birden fazla actor kullanabilmelidir; fakat “multi-agent team” otomatik ayrı bir corporate Actor değildir.

Development OS:

- parallel actor collection;
- coordinated/shared activity;
- manager/coordinator role;
- delegation chains;
- group-level decision procedure;
- member-level participation;
- bireysel vs group-level attribution/accountability

ayrımlarını gerektiği yerde koruyabilmelidir.

B3 bütün multi-agent orchestration'ı çözmez; bunun Actor semantiğini taşır. Work koordinasyonu B4, runtime/topology B5/B6'dır.

### B3-C10 — Actor-system failure'ını teşhis etmek

Bir rol veya actor kötü sonuç verdiğinde sorun otomatik “yanlış model” değildir.

Development OS şunları ayırabilmelidir:

- role ihtiyacı yanlış mı çıkarıldı;
- role contract yanlış mı;
- yanlış actor bağlandı mı;
- competence yetersiz mi;
- authority eksik/fazla mı;
- assignment/active-role karıştı mı;
- delegation/representation yanlış mı;
- gerekli Information/context eksik mi;
- Environment actionability yok mu;
- Work yanlış mı kurulmuş;
- verification/oracle yanlış mı?

Bu teşhis B1/B2'deki R3 rolünü yeni kopya üretmeden genişletmeye adaydır.

## B3 sınırı

B3 tek başına:

- hangi Work'lerin yapılacağını belirlemez — B4;
- gerekli Information/context sistemini kurmaz — B2;
- teknik tool/runtime/access sağlamaz — B5;
- bütün cross-ground readiness/effect control'u çözmez — B6;
- continuity/recovery'nin bütününü çözmez — B8.

B3, SOUL'un **kim/ne hangi rolde, hangi yeterlilik ve yetkiyle, kimin adına, hangi episode'da ve hangi sorumluluk ilişkisiyle katılıyor?** sorularını güvenilir biçimde yönetebilme kapasitesini Development OS'un nasıl geliştireceğini ele alır.

## B3'ten türeyen Development OS taşıyıcıları

### R7 — Role & Actor Formation Designer / Rol ve Aktör Oluşum Tasarımcısı

**Taşıdığı B3 sorumlulukları:** C1, C2, C3'ün tasarım tarafı, C6'nın rol/katılım tasarımı, C7'nin lifecycle tasarımı ve C9'un formation tarafı.

Temel amacı:

> Work ihtiyacını, role özgü amaç/yeterlilik/yetki/sorumluluk gereksinimleri olan bir role ve bu rolü taşıyabilecek actor oluşum planına dönüştürmek.

Bu rol:

- Work'ten role ihtiyacını çıkarır;
- role contract üretir;
- common baseline ile role-specific competence'i ayırır;
- mevcut actor mu yeni actor mu gerektiğini değerlendirir;
- active role / assigned role ayrımını taşır;
- separation-of-duty gereksinimlerini belirtir;
- reassignment/lifecycle gereksinimi üretir;
- multi-actor yapıda hangi actor/role ilişkilerinin gerektiğini tasarlar.

**Sınır:** competence'i kendi tasarım beyanıyla kanıtlamaz; authority'yi kendisi üretmez; gerçek runtime actor creation/provisioning B5/B6 ile kesişir.

### R8 — Actor Qualification Reviewer / Aktör Yeterlilik Doğrulayıcısı

**Taşıdığı B3 sorumluluğu:** C4; C3/C6 için fit değerlendirmesi.

Temel amacı:

> Belirli actor'un belirli role ve kapsam için gerçekten yeterli olup olmadığını iddiaya uygun kanıtla sınamak.

Bu rol:

- role etiketi/model itibarı ile gösterilmiş yeterliliği ayırır;
- qualification'ın scope'unu açık tutar;
- role özgü bilgi/yöntem/skill eksiklerini bulur;
- küçük başarıyı geniş uzmanlık diye genellemez;
- gerekirse başka actor/model/uzman/araç ihtiyacını görünür kılar.

**R2 ile farkı:** R2 ortak SOUL-native çalışma davranışını sınar. R8 role özgü competence/fit'i sınar. İleride tek verification organization altında birleşebilirler; şu aşamada başarı iddiaları farklıdır.

### R9 — Actor Governance Steward / Aktör Yetki ve Yönetişim Sorumlusu

**Taşıdığı B3 sorumlulukları:** C5, C6'nın authority tarafı, C7'nin grant/delegation lifecycle'ı, C8 ve C9'un governance/attribution tarafı.

Temel amacı:

> Actor'ların hangi yetki, obligation, delegation ve attribution ilişkisiyle çalıştığını meşru kaynak ve scope'a bağlı tutmak.

Bu rol:

- principal/authority source'u korur;
- permission/authority/obligation ayrımını gözetir;
- delegation scope/history/revocation gereksinimini yönetir;
- actor'un teknik effect gücünü meşru authority sanmaz;
- performer/decider/authorizer/on-behalf-of ayrımını korur;
- separation-of-duty ve group decision procedure gereksinimlerini görünür tutar;
- accountability/attribution için gereken Actor-side semantiği tanımlar.

**Sınır:** gerçek credential/tool enforcement M1 ve ileride B5/B6'dır. R9'un “yetkili” demesi teknik enforcement değildir.

### Mevcut rollerin B3 ile ilişkisi

- **R1** common intellectual baseline'ı sağlar; R7 role-specific contract'a bunu girdi olarak kullanır.
- **R2** common baseline davranışını sınar; R8 role-specific competence'i sınar.
- **R3** B3-C10 failure diagnosis'ı da taşıyacak şekilde cross-domain genişlemeye adaydır.
- **R4/R5/R6** actor standing/role/grant/context hakkındaki Information'ın doğru yaşaması, seçilmesi ve sınanması için B3 ile ilişkilidir; B3 onların yerine geçmez.

### Mekanik sorumluluklar

B3 yeni bağımsız bir M kimliği üretmiyor.

Mevcut **M1 — mekanik davranış/enforcement** gereksinimi B3 ile genişler:

- gerçek actor identity binding;
- active role/grant enforcement;
- separation-of-duty;
- izin dışı effect'i engelleme;
- revoked/stale authority'yi reddetme.

Mevcut **M2 — Information persistence/retrieval/exposure** ise actor/role/grant/delegation kayıtlarının kalıcı ve doğru görünürlüğünü destekler.

Gerçek actor provisioning, credential binding ve runtime lifecycle B5/B6'da yeniden açılacaktır.

## İnsan müşterinin B3'teki yeri

B3 müşteriye yeni teknik koordinasyon rolü yüklemez.

Müşteri:

- üst mandate/yetkinin kaynağı;
- gerektiğinde belirli delegation veya kapsam değişikliğinin principal'ı;
- nihai kabul makamı

olarak kalır.

Bu, müşterinin her alt role tek tek izin vermesi gerektiği anlamına gelmez. Development OS, verilen mandate içinde delegation/operasyon alanını tasarlayabilir; fakat kendi mandate'ini sessizce genişletemez.

## İlk B3 rol akışı

```text
Work ihtiyacı
   ↓
R7 Role & Actor Formation Designer
   │ role contract + actor requirement
   ├──────────────► R1 ortak baseline girdisi
   ↓
R8 Actor Qualification Reviewer
   │ competence / fit evidence
   ↓
R9 Actor Governance Steward
   │ authority / delegation / attribution scope
   ↓
M1/M2 + ileride B5/B6
   │ identity / grant / record / runtime binding
   ↓
aktif actor-role participation
   ↓
R2/R8/R6 ilgili davranış-yeterlilik-bilgi doğrulamaları
   ↓
R3 failure diagnosis → ilgili B dalını yeniden aç
```

Bu sabit workflow veya fiziksel agent topolojisi değildir.

## B3'ten çıkan artefakt/sözleşme adayları

- **Role Requirement / Role Contract:** amaç, sorumluluk, competence, authority, sınırlar ve active-context koşulları.
- **Actor Binding / Role Activation Record:** hangi bearer'ın hangi role hangi episode/scope'ta bağlı olduğu.
- **Qualification Evidence:** actor-role competence/fit kanıtı ve sınırı.
- **Authority / Delegation Grant:** source, principal, scope, süre, delegation/revocation koşulları.
- **Participation / Attribution Record:** performer, decider, authorizer, on-behalf-of ve ilgili role/context ayrımları.
- **Actor Lifecycle Change:** activate/deactivate/reassign/replace/retire ve etkileri.
- **Actor Failure / Change Proposal:** sorunun hangi Actor/Work/Information/Environment ilişkisine ait olduğu.

Bunlar kesin dosya, tablo veya servis adları değildir.
