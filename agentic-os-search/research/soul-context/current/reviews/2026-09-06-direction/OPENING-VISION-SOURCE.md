> **30 Eylül 2026 — tarihsel kaynak aktarımı; etkin kontrol veya güncel SOUL mimarisi değildir.** Aşağıdaki metin, 6 Eylül'deki incelemede korunan önceki assistant cevabıdır. İçindeki Routing gate bugünkü okuyucunun kontrol sonucu değildir; mimari adları ve “bugün/sonraki” ifadeleri kendi bağlamına aittir. Kaynak gövdesi ayırıcıdan sonra değiştirilmeden korunur.
>
> Güncel yetki/statü [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. [Özgün byte-sadık kaynak](https://github.com/batuhanozgun/agentic-os-search/blob/9620dfdeda71f25580f6945c2bb3a11c19b78703/research/soul-context/current/reviews/2026-09-06-direction/OPENING-VISION-SOURCE.md) ve [tarihli incelemedeki kaynak kimlikleri](REVIEW.md) bu yeni notu değil, aşağıdaki gövdeyi tanımlar.

---

Routing gate
R01 Varsayımlar: LOAD
R02 Kanıt-dışı etki: LOAD
R03 Amaç–uyum: LOAD
R04 Doğrulama geçerliliği: LOAD
R05 Kaynak–temsil ayrımı: LOAD
R06 Nedensel derinlik: SKIP
R07 Çalışma sürekliliği: SKIP
R08 Canonical çalışma preflight'ı: LOAD
R09 Aday araştırma kütüphanesi: LOAD

Bence bugün, KEEL'i, ilk SOUL tanımını, dört Foundation araştırmasını ve son candidate studies'i birlikte düşündüğümüzde cevabım eskisine göre **daha net** olur:

> **SOUL aslında bir “agent sistemi” değil, bir çalışma sistemi kurucusu olmalı.**
>
> Kullanıcının istediği sonucu almalı; o sonucun gerçekleşebilmesi için gereken **doğru çalışma sistemini kurmalı, işletmeli, gerçeklikle sürekli karşılaştırmalı, gerektiğinde yeniden düzenlemeli ve bütün bunları yetki/evidence/control altında yapabilmeli.**

Bu, SOUL'un ilk vizyonuyla çok uyumlu: mevcut kaynak zaten kullanıcının agent organizasyonunu, workflow'u, memory'yi, toolchain'i, verification yapısını önceden tasarlamak zorunda olmaması gerektiğini; bunların SOUL tarafından gereken işe göre oluşturulmasını söylüyordu. Fakat bugünkü araştırmalar bunun **içeriğinin ne olması gerektiğini** bize eskisinden çok daha iyi anlatıyor.

## Benim kafamdaki SOUL artık şöyle

SOUL'un sürekli cevaplayabilmesi gereken yedi soru olduğunu düşünüyorum:

1. **Gerçekte ne var ve ne durumda?**
2. **Biz bunun hakkında ne biliyoruz / neyi nasıl temsil ediyoruz?**
3. **Hangi işin yapılması gerekiyor ve şu anda gerçekten ne yapılıyor?**
4. **Kim/ne bu sistemde hangi kapasite, rol, yetki ve sorumlulukla bulunuyor?**
5. **Bunların birbirleriyle tam ilişkileri ve geçerli koşulları neler?**
6. **Yaptığımız şey gerçekten amaçlanan etkiyi yarattı mı?**
7. **Yeni gerçeklik karşısında çalışma sistemi değişmeli mi?**

İlk dört soru doğrudan araştırdığımız dört zemine denk geliyor:

```text
ENVIRONMENT
Gerçekte ne var / ne mümkün / mevcut koşullar ne?

INFORMATION
Ne biliyoruz / neyi temsil ediyoruz / bilgi nereden geldi / güncel mi?

WORK
Neye ulaşmaya çalışıyoruz / hangi işler seçildi / yapılıyor / doğrulandı?

ACTORS
Kim/ne dahil / hangi rolde / ne yapabilir / neye yetkili / kim sorumlu?
```

Bunların hiçbiri diğerinin yerine geçemiyor. Foundation araştırmasının bence en büyük kazanımlarından biri bu oldu. Örneğin `Work tamamlandı`, `hedef durum gerçekten oluştu`, `kanıt bunu destekliyor` ve `yetkili aktör kabul etti` aynı şey değil. Aynı şekilde bir Actor'ın teknik olarak bir şeyi yapabiliyor olması, onu yapmaya yetkili olduğu anlamına gelmiyor.

Ama **SOUL dört ayrı veri kutusundan ibaret olamaz.**

Asıl önemli şey bunların birbirine bağlanması.

---

# SOUL'un kalbi: Working System Model

Bugün SOUL'un içinde olması gerektiğini en güçlü düşündüğüm yapı, yaşayan bir **Working System Model**.

Bu model yalnızca “task listesi” veya “memory” olmayacak.

Aynı anda şunları taşıyacak:

```text
Environment reality
Information state
Work state
Actor state

+ bunların arasındaki exact relations
+ mevcut qualification/standing
+ control/authority
+ transitions/effects
+ evidence/freshness
```

Foundation'ın Cross-Ground Composition araştırması tam burada önemli hale geliyor. Binding, Composite Standing, Control ve Transition ayrı problem bölgeleri olarak ortaya çıktı.

Örneğin SOUL yalnızca şunu bilmemeli:

> “Test geçti.”

Şunu bilmeli:

> Hangi test, hangi implementation versiyonunu, hangi environment'ta, hangi oracle ile, hangi zamanda sınadı; sonuç hâlâ current mı; bu sonuç hangi Work acceptance condition'ını destekliyor; o koşul gerçekleşince hangi Actor'ın hangi transition'ı authorize etmesine izin veriliyor?

Bana göre burada **KEEL'den SOUL'a gerçek sıçrama** var.

KEEL önemli ayrımları dosya, hook, guard, rol kafesi, verifier, freshness gibi mekanizmalarla mekanikleştirmeye başladı. Bunların gerçek kod karşılıklarının önemli bölümü de mevcut.

SOUL ise aynı disiplini belirli bir yazılım workflow'una bağlamak yerine:

> **Her çalışma sistemi için gerekli gerçeklik ve kontrol modelini kurabilmeli.**

---

# Bunun üzerinde bir **System Formation** yeteneği olmalı

Eski SOUL'daki **Genesis** fikrini bugün atmazdım. Tam tersine çok daha ciddi hale getirirdim.

Genesis'in görevi “hangi agentları spawn edelim?” olmamalı.

Şunu çözmeli:

> **Bu outcome'un güvenilir biçimde üretilebilmesi için nasıl bir çalışma sistemi gerekiyor?**

Bunu belirlerken örneğin:

- gereken Work yapısını,
- bağımlılıkları,
- gerekli bilgi kaynaklarını,
- context stratejisini,
- persistent state/memory ihtiyacını,
- gerekli Actor/rolleri,
- capability'leri,
- delegation yapısını,
- authority sınırlarını,
- verification yollarını,
- human decision noktalarını,
- environment gereksinimlerini,
- recovery mekanizmalarını

çıkarmalı.

Ve önemli olan:

**Bunların hepsini her görevde kurmamalı.**

Multi-agent araştırmasından çıkan en değerli fikirlerden biri burada: SOUL sabit Sequential / Parallel / Hierarchical / Generator-Critic pattern'lerinden birini seçen router olmamalı. **Mevcut iş için minimum gerekli coordination/control topology'sini türetmeli.**

Basit bir iş:

```text
1 agent
+ 1 kaynak
+ basit verification
```

ile çözülebiliyorsa SOUL küçük kalmalı.

Başka bir iş:

```text
researcher A
researcher B
      ↓
reconciliation
      ↓
builder
      ↓
deterministic verification
      ↓
adversarial review
      ↓
human authority gate
```

gerektiriyorsa bunu kurabilmeli.

**Generality = her şeyi yapmak değil, gereken sistemi doğru boyutta kurabilmek.**

---

# SOUL'un ayrı bir **Epistemic System**'i olmalı

Bunu artık “memory sistemi” diye adlandırmak bana yetersiz geliyor.

Context/Memory/Harness araştırması sayesinde önemli bir ayrım ortaya çıktı:

```text
persistence ≠ memory ≠ retrieval ≠ context ≠ source truth
```

Bir bilgi diskte olabilir ama kullanılmayabilir.

Memory'de olabilir ama yanlış zamanda retrieve edilebilir.

Retrieve edilmiş olabilir ama stale olabilir.

Context'e girmiş olabilir ama yanlış source'tan gelmiş olabilir.

Model doğru şeyi görmüş olabilir ama yanlış çıkarım yapabilir.

Harness doğru context'e rağmen yanlış permission uygulayabilir.

Dolayısıyla SOUL bence yalnız **“hatırlayan”** değil;

**neyi bildiğinin epistemik statüsünü yöneten** bir sistem olmalı.

Şunları ayırabilmeli:

- observation,
- source claim,
- evidence,
- inference,
- assumption,
- hypothesis,
- decision,
- current fact,
- historical fact,
- stale representation,
- conflicting information,
- unknown,
- unverifiable.

Ve bilgi teknolojisini koşula göre seçmeli:

```text
direct source read
RAG
search
knowledge graph
long context
cache
persistent memory
human clarification
...
```

RAG veya KG, SOUL'un temel mimarisi olmamalı. Bunlar **belirli bilgi problemleri için seçilebilecek mekanizmalar** olmalı.

---

# Çok güçlü bir **Governance / Control sistemi** olmalı

Bence bu SOUL'un karakterini belirleyen alanlardan biri.

SOUL yalnızca:

> “Agent X bunu yapabilir.”

dememeli.

Şunları ayrı ayrı bilmesi gerekiyor:

```text
can do
≠
may do
≠
was instructed to do
≠
has authority to decide
≠
is accountable
```

Foundation Actors araştırması bunu çok güçlü biçimde destekliyor.

Ve control tarafında:

```text
policy
≠ authority
≠ decision
≠ enforcement
≠ monitoring
≠ compliance
```

ayrımını korumalı.

Burada KEEL'in mekanikleştirme refleksini kesinlikle korurdum:

> Kritik bir ayrım deterministik olarak korunabiliyorsa yalnız prompt'a yazıp modele hatırlatmakla yetinme.

SOUL'un ilk non-negotiable'larında da bu çizgi zaten güçlü: authority bounded olmalı, producer kendi başarısını certify etmemeli, repeated failures mümkünse controls'a dönüşmeli, critical control state onu ihlal edebilecek bileşenin insafında olmamalı.

---

# Bir **Reality Verification** yeteneği olmalı

Bu da yeni araştırmalarla zihnimde çok daha merkezî hale geldi.

SOUL:

```text
command issued
```

ile

```text
effect happened
```

arasındaki farkı bilmeli.

Hatta:

```text
effect happened locally
```

ile

```text
desired target state is now actually true
```

arasındaki farkı da bilmeli.

gstack araştırmasının çok iyi gösterdiği döngü buydu:

```text
SITUATE
→ KNOW
→ QUALIFY
→ GOVERN
→ ACT
→ VERIFY REALITY
→ REFRESH / RECOVER / LEARN
```

Bence SOUL'da **readback** first-class kavram olmalı.

Bir agent “deploy ettim” dediği için deploy edilmiş sayılmamalı.

Bir test process'i exit 0 verdi diye claim doğrulanmış sayılmamalı.

Bir dosya yazıldı diye intended outcome gerçekleşmiş sayılmamalı.

Ve completion:

> agent'ın söylediği bir cümle değil, **kanıtlanmış bir system standing** olmalı.

Bu fikir SOUL'un orijinal Definition'ında zaten vardı; bugünkü araştırmalar bunun neden gerekli olduğunu ve kaç ayrı zeminin birleşmesi gerektiğini çok daha iyi gösteriyor.

---

# SOUL **capability oluşturabilmeli**

İlk SOUL vizyonundaki bu fikir bence hâlâ çok önemli.

Sistem bir işi yapmak için eksik capability gördüğünde hemen:

> “Bunu yapamam.”

veya

> “Kullanıcı bana şu aracı kursun.”

dememeli.

Şunu yapabilmeli:

```text
missing capability detected
↓
capability need defined
↓
research / discover / build / integrate
↓
isolate
↓
test
↓
verify
↓
qualify
↓
admit into working system
```

İlk SOUL vizyonunda bu açıkça vardı.

Fakat bugünkü farkındalıkla buna şunu eklerdim:

**Capability availability, Actor authorization ve Work admission birbirinden ayrı olmalı.**

Bir capability'nin mevcut olması, otomatik kullanılabileceği anlamına gelmez.

---

# Ve sonunda **Recovery / Adaptation / Evolution**

SOUL yalnız başarılı yolu çalıştıran sistem olmamalı.

Şunları normal state olarak taşımalı:

- blocked,
- partial,
- stale,
- conflicted,
- unknown,
- unverifiable,
- failed,
- degraded.

Sonra ne yapacağını belirleyebilmeli:

```text
retry?
repair?
re-plan?
change actor?
change information strategy?
acquire capability?
change environment?
escalate?
ask human?
abandon?
```

Daha da önemlisi, tekrar eden failure'ları yalnız o task içinde onarmamalı.

Doğrulanmış bir öğrenme:

```text
episode result
→ candidate lesson
→ evidence
→ evaluation
→ governed system change
```

yolundan geçebilmeli.

Ama çalışan sistem kendi correctness kurallarını sessizce değiştirememeli. Bu nedenle eski **Evolution** kavramını da korurdum.

Burada bir epistemik sınır önemli: Foundation'daki **Cross-Ground Feedback / Adaptation henüz araştırılıp kabul edilmiş değil**; şu anda önerilen sonraki frontier konumunda. Dolayısıyla bu bölüm bugün Foundation sonucu değil; eski SOUL intent'i + KEEL/gstack/Anthropic gibi candidate evidence ile güçlü biçimde desteklenen tasarım hipotezi.

---

# O zaman eski `Core → Genesis → Runtime → Evolution` ne oluyor?

Bence **çöpe gitmiyor. Fakat anlamı değişiyor.**

Bugün şöyle okurdum:

### **Core**

SOUL'un sabit workflow'u değil.

Working-system grammar'ı ve değiştirilemez temel ayrımlar:

- Environment / Information / Work / Actors,
- binding,
- standing/qualification,
- authority/control,
- transition/effect,
- evidence,
- uncertainty,
- verification,
- governance.

### **Genesis**

Outcome'dan hareketle **task-specific working system formation**.

Ne kadar Work, hangi Actors, hangi Information architecture, hangi Environment capabilities ve hangi controls gerektiğini türetir.

### **Runtime**

Kurulan sistemi gerçekten işletir:

```text
situate
→ know
→ qualify
→ govern
→ act
→ verify reality
→ continue/recover
```

### **Evolution**

Gerçek çalışma sonuçlarından kontrollü biçimde öğrenir; capability ve mekanizmaları geliştirir fakat kendi temel kontrol modelini sessizce değiştiremez.

Bu bana ilk SOUL tanımındaki Core/Genesis/Runtime/Evolution fikrinden **daha olgun ama onunla çelişmeyen** bir SOUL çıkarıyor. İlk Definition zaten bu dört concern'i tarif ediyordu; Foundation araştırması şimdi onların içinde **neyin modellenmesi gerektiğine dair bir temel** sağlamaya başladı.

## Tek cümleye indirirsem

Ben artık istediğin SOUL'u şöyle tarif ederdim:

> **SOUL; bir intended outcome'u alıp, gerçek Environment'ı, mevcut Information'ı, gereken Work'ü ve ilgili Actors'ı anlayan; bunların arasındaki ilişkileri, standing'leri, authority/control'ü ve transitions'ı açıkça kurarak minimum yeterli task-specific çalışma sistemini oluşturan; o sistemi kontrollü biçimde işleten, yaptığı etkinin gerçekten gerçekleştiğini kanıtla kontrol eden, continuity'yi koruyan ve sonuçlardan governed biçimde öğrenerek kendini yeniden düzenleyebilen bir meta-operating system olmalı.**

Ve bence burada önemli bir yön değişikliği var:

**SOUL'un asıl ürünü agent değildir. Workflow da değildir.**

Asıl ürünü, belirli bir outcome için **doğru çalışma sisteminin kendisidir**.

Agentlar, modeller, memory, RAG, knowledge graph, verifier, tool, workflow, hierarchy, human gate, browser, repository, sandbox… bunların tamamı o çalışma sisteminin **gerektiğinde oluşturulan parçalarıdır**.

Bana göre araştırmaların bizi getirdiği en kuvvetli farkındalık şu anda tam olarak bu.