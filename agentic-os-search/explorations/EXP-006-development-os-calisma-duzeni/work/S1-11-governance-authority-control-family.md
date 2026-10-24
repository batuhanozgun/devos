# S1-11 — F4 Yönetişim / Yetki / Kontrol ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

R9 Actor Governance ile R17 Cross-Ground Control aynı başarı yönünün specialization'ları mı diye sınandı.

İnsan müşterinin daha önce kabul edilen **yetki** çekirdeğiyle AI governance sorumluluğunun sınırı ayrıca açıldı.

## Sonuç

**F4 tek bir Yönetişim / Yetki / Kontrol ailesi olarak ayakta kalıyor.**

Ortak başarı yönü:

> Eylem, delegation ve geçişlerin meşru mandate/yetki sınırları içinde kalmasını; teknik olarak mümkün olan ile yapılmasına yetki verilenin karıştırılmamasını; gerekli control/gate kapsamının korunmasını sağlamak.

İki ana specialization:

| Aday | F4 içindeki uzmanlık |
|---|---|
| R9 | authority / delegation / obligation / attribution governance |
| R17 | exact action/effect control / gate / enforcement-coverage / transition governance |

## R9 ile R17 neden aynı familyada?

R9 şu soruya bakar:

> Kim, kimin adına, hangi kapsamda ne yapmaya yetkili?

R17 şu soruya bakar:

> Bu exact action/effect gerçekten o governing basis ve control kapsamı altında mı gerçekleşiyor?

Biri normative authority state'ini, diğeri o state'in concrete action/transition üzerindeki control bağını taşır.

Başarı yönleri çelişmez; farklı katmanlardır.

## Korunması gereken ayrım

F4 içinde şu şeyler collapse edilmez:

```text
mandate / authority source
≠ delegation
≠ permission / grant
≠ technical capability
≠ enforcement mechanism
≠ realized effect
```

Bir actor teknik olarak bir şeyi yapabiliyor diye yetkili olmaz.

Bir policy veya grant kaydı var diye enforcement'ın gerçekten kapsamı koruduğu da kanıtlanmaz.

## İnsan müşterinin sınırı

İnsan müşterinin rolündeki **yetki**, F4'ün üstünde kaybolmaz.

Aday model:

```text
İnsan / principal
    → üst mandate ve kapsamın meşru kaynağı

F4 governance
    → mandate'i temsil et, delegation/scope'u yönet,
      exact effect için governing basis/control'u koru

Mekanik enforcement
    → verilen control kararını teknik effect yolunda uygula
```

AI:
- kendi üst mandate'ini yaratamaz;
- mandate'i sessizce genişletemez;
- verilen kapsam içinde alt delegation ve operasyon kararları taşıyabilir;
- belirsiz veya kapsam değiştirici durumda yetki kaynağına geri dönmelidir.

Bu, müşterinin her teknik kararı vermesi demek değildir.

## F2 ve F3 sınırı

F4 control ihtiyacını ve meşru transition sınırını yönetir.

- yeni guard/hook/policy-engine mekanizmasını geliştirmek → **F2**
- kurulu control mekanizmasını operational olarak active/current tutmak → gerektiğinde **F3**
- hangi action'ın hangi mandate/grant/gate altında meşru olduğunu yönetmek → **F4**

M1/M6 gibi mechanical enforcement sorumlulukları AI familyasının yerine geçmez.

## Research karşı-kontrolü

**Work-management corpus:** authority, assignment, claim, liveness ve integration authority'yi ayrı standing'ler olarak korur. Bu, R9'un yalnız assignment/coordination'a indirgenmemesini destekler.

**Harness Engineering:** allowed tools, approval gates, sandboxing, least privilege ve irreversible-action boundaries model-external control yüzeyleridir. Bu, F4 kararının yalnız prompt dili olmadığını; F2/F3 mekaniklerine bağlanması gerektiğini gösterir.

**Keel:** rol sınırlarında yalnız sözleşme değil mekanik guard/gate kullanır. Bu, policy/role statement ile enforcement'ın aynı olmadığını gösteren source example'dır; Keel'in mekanizması DevOS'a benimsenmiş değildir.

Bu kaynaklar F4'ün tek doğru familya olduğunu kanıtlamaz.

## F4 family contract adayı

Bir F4 görevlendirmesinde en az şunlar açık olmalı:

1. Üst mandate/authority source nedir?
2. Exact actor, role, Work, target ve scope nedir?
3. Hangi delegation/grant current?
4. Hangi decision/gate gerekiyor?
5. Hangi effect yolları control kapsamına giriyor?
6. Revocation/change sonrası hangi standing'ler invalid olur?
7. Hangi noktada AI karar verebilir, hangi noktada principal'a dönmelidir?
8. Enforcement var mı ve coverage iddiası nasıl sınanacak?

## S1 sonucu

- **S1-11-A1:** R9 ve R17 tek F4 familyasının iki specialization'ı olarak modellenebilir.
- **S1-11-A2:** R9 authority-state/governance; R17 exact-effect/control specialization'ıdır.
- **S1-11-A3:** İnsan müşteri F4 AI rolüne erimez; üst mandate/yetkinin meşru kaynağı olarak ayrı kalır.
- **S1-11-A4:** AI verilen mandate içinde delegation/control kararı taşıyabilir; kendi mandate'ini genişletemez.
- **S1-11-A5:** Mechanical enforcement F4'ün kendisi değildir; F2/F3 tarafından gerçekleştirilip işletilebilir ve F5 tarafından sınanabilir.

## Sonraki adım

Sıradaki familya **F6 Teşhis / Toparlanma**.

Soru:

> R3 failure/root-cause routing ile R22 change-impact/recovery gerçekten aynı başarı yönünün iki specialization'ı mı; yoksa “neden bulmak” ile “toparlanmayı yönetmek” F6 ve F3 arasında ayrılmalı mı?
