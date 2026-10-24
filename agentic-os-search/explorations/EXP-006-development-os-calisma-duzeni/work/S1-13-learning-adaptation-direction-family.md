# S1-13 — F7 Öğrenme / Adaptasyon Yönlendirme ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

R23 Learning & Adaptation Steward'ın gerçekten ayrı bir başarı yönü taşıyıp taşımadığı sınandı.

Soru:

> F7 ayrı bir familya mı; yoksa F6 diagnosis + F1 redesign + F2 implementation + F3 lifecycle operation birleşiminin yalnızca genel adı mı?

## Sonuç

**F7 ayrı bir rol ailesi olarak ayakta kalıyor.**

Aday ad:

> **F7 — Öğrenme / Adaptasyon Yönlendirme**

Ortak başarı yönü:

> Realized experience, outcome, feedback veya yeni kanıtın gelecekte yeniden kullanılabilir bir değişiklik üretmesi gerekip gerekmediğini doğru değerlendirmek; gerekliyse bu değişikliğin scope/provenance koşullarını koruyarak uygun Development OS Work'üne yönlendirmek ve adaptation iddiasının yaşam döngüsünü takip etmek.

Buradaki başarı "her deneyimden bir şey eklemek" değildir. **No-change** da doğru sonuç olabilir.

## F6 ile farkı

F6:
- failure nedenini;
- change impact'i;
- recovery yolunu

bulur.

F7:
- bu experience'in gelecekte reusable bir ders, yöntem veya system change üretmesi gerekip gerekmediğini değerlendirir.

Bir failure recovery ile kapanabilir ama kalıcı öğrenme gerektirmeyebilir.

Tersine, F7 yalnız failure'dan doğmaz:
- başarılı pattern;
- yeni araştırma;
- performance evidence;
- tekrar eden friction;
- değişen Environment/model/domain

gibi girdiler de adaptation adayı üretebilir.

## F1 / F2 / F3 ile farkı

F7 adaptation'ı tek başına gerçekleştirmez.

Örnek akış:

```text
experience / feedback / evidence
        ↓
F7  promote? no-change? scope?
        ↓
gerekirse F1 redesign
        ↓
F2 realization / modification
        ↓
F3 deployment / lifecycle operation
        ↓
F5 acquisition / retention / expression assurance
```

Yetki veya mandate değişiyorsa F4 de devreye girer.

Bu nedenle F7, F1/F2/F3'ün yerine geçmez; **experience → reusable change** eşiğini ve döngüsünü taşır.

## Storage neden öğrenme değil?

Foundation'daki kabul edilmiş Persistent Adaptation sonucu şu ayrımları korur:

- stored record ≠ operative retained change;
- historical acquisition ≠ current retention ≠ current expression;
- changed bytes/parameters ≠ behavioral change;
- retained change ≠ benefit / authority / transfer.

Bu nedenle lesson dosyası yazmak veya configuration değiştirmek tek başına F7 başarısı değildir.

B8'deki acquisition / retention / expression ayrımı bu yüzden korunur.

## Acquisition / retention / expression ayrı familyalar mı?

Şimdilik hayır.

Foundation çalışmasında bunlar gerçek failure/evidence ayrımları olarak korunmuş, fakat ayrı immediate child'lara bölünmemiştir.

F7 için de aynı disiplin adaydır:

- acquisition;
- retention;
- expression;
- benefit;
- transfer

ayrı claim/facet'lerdir; otomatik ayrı role familyası değildir.

Gereken assurance F5 tarafından claim bazında yapılır.

## F3 Information Lifecycle ile sınır

F3 Information Lifecycle Operations:
- lesson kaydını yazar;
- update/supersede/archive/deprecate işlemlerini yürütür;
- current kayıt durumunu korur.

F7 ise:

> Bu experience reusable lesson olmalı mı; scope'u ne; ne zaman stale sayılmalı; hangi future behavior değişikliği bekleniyor?

sorusunu taşır.

Dolayısıyla memory/knowledge operasyonu ile learning direction aynı şey değildir.

## Araştırma karşı-kontrolü

**Persistent Adaptation Foundation:** history-linked retained response change'i ayrı bounded problem olarak koruyor; storage, acquisition, retention, expression, benefit ve authority'yi collapse etmiyor. Bu rol tasarımını otomatik belirlemez ama F7'nin problem yüzeyinin diğer familyalara tamamen indirgenemediğine güçlü pressure sağlar.

**Superpowers:** method-change loop normal work execution'dan ayrı tutuluyor. Observed problem otomatik daha fazla instruction'a dönüşmüyor; intervention seçimi ve evaluation ayrı süreç.

**gstack:** repeated failures'ın reusable helper/runtime rule/test/control'e yükselmesi self-development yüzeyinde ayrıca izleniyor. Aynı çalışma feedback'in otomatik Work admission'a dönüşmemesi gerektiğini de vurguluyor.

**Memory Engineering:** write/manage/read lifecycle, stored text ile operative future use'un aynı olmadığını gösteriyor.

Bu kaynaklar tek bir F7 rol yapısını kanıtlamaz; ayrı success direction ihtiyacını destekler.

## F7 family contract adayı

Bir F7 görevlendirmesinde en az şunlar açık olmalı:

1. Hangi realized experience/outcome/feedback değerlendiriliyor?
2. Kaynağı, target'ı ve evidence statüsü nedir?
3. Tek vaka mı, tekrar eden pattern mi, hangi alternatif açıklamalar var?
4. Reusable change gerçekten gerekli mi; no-change mümkün mü?
5. Lesson/adaptation hangi scope ve koşullarda geçerli?
6. Hangi familya change Work'ünü taşımalı?
7. Hangi adaptation claim'leri F5 tarafından sınanmalı?
8. Acquisition, retention ve expression hangi horizon/support altında değerlendirilecek?
9. Ne zaman lesson/method/configuration stale/deprecated edilmeli?
10. Adaptation üst mandate'i değiştiriyorsa hangi F4/principal yetkisi gerekir?

## S1 sonucu

- **S1-13-A1:** F7 ayrı başarı yönü taşıyan aday role familyasıdır.
- **S1-13-A2:** Family adı aday olarak **Öğrenme / Adaptasyon Yönlendirme** olmalıdır; adaptation implementation'ı kendisi sahiplenmez.
- **S1-13-A3:** R23, F7'nin mevcut ana adayıdır.
- **S1-13-A4:** Acquisition/retention/expression ayrı claim/facet olarak korunur; şimdilik ayrı familya veya kalıcı rol yapılmaz.
- **S1-13-A5:** F7'nin çıktısı çoğunlukla candidate lesson/change + scope + downstream Work'tür; actual redesign/implementation/operation F1/F2/F3'e gider.
- **S1-13-A6:** Learning'in başarı ölçütü değişiklik miktarı değildir; gerekçeli no-change, deprecation veya simplification da başarılı sonuç olabilir.

## Sonraki adım

İlk taslaktaki **F1–F7'nin tamamı artık ayrı ayrı sınandı.**

Sıradaki iş yeni familya açmak değil:

> **Bütün aile modelini yeniden bir araya getirip coverage ve çakışma denetimi yapmak.**

Bu turda özellikle:
- düzeltilmiş family isimleri;
- mevcut specialization'lar;
- F2 primary-owner açığı;
- F3 Information Lifecycle Operations açığı;
- R1–R25'in yeni eşlemesi;
- B1–B9 sorumluluklarının sahipsiz kalıp kalmadığı;
- research / decision / coordination gibi kavramların ayrıca familya gerektirip gerektirmediği

tek bir konsolide haritada yeniden sınanmalıdır.
