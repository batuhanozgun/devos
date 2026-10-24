# S1-08 — F1 Tasarlama / Oluşturma ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

R1, R4'ün tasarım tarafı, R7, R10, R13, R16, R19 ve R24'ün gerçekten aynı başarı yönünde olup olmadığı sınandı.

## Sonuç

**F1 tek bir Tasarlama / Oluşturma ailesi olarak ayakta kalıyor.**

Ortak başarı yönü:

> Amaç, ihtiyaç, kısıt ve mevcut gerçeklerden downstream gerçekleştirme/işletimin kullanabileceği açık, gerekçeli ve sınanabilir bir tasarım/oluşum çıktısı üretmek.

Farkları tasarladıkları nesnededir.

| Eski aday | F1 uzmanlığı |
|---|---|
| R1 | ortak çalışma davranışı / baseline design |
| R4'ün tasarım tarafı | Information lifecycle / source-of-truth / currentness design |
| R7 | role & actor formation design |
| R10 | Work formation / living-plan design |
| R13 | Environment & capability design |
| R16 | cross-ground binding / qualification design |
| R19 | mission-specific working-system formation |
| R24 | evaluation design |

## Ortak F1 sözleşmesi

Bir F1 görevlendirmesinde en az şunlar görünür olmalı:

1. Hangi ihtiyaç/problem tasarlanıyor?
2. Hangi mevcut gerçekler, kısıtlar ve yetki sınırları geçerli?
3. Hangi alternatifler değerlendirildi?
4. Çıktı tam olarak hangi downstream sorumluluğa teslim edilecek?
5. Tasarımın uygulanabilir sayılması için hangi önkoşullar gerekli?
6. Hangi iddia daha sonra sınanmalı?
7. Yeni kanıt geldiğinde tasarım hangi koşulda yeniden açılmalı?
8. Tasarım üretmek, implementasyonun yapılmış veya başarılı olduğunu kanıtlamaz.

Family-level başarı, "güzel plan yazmak" değil; gerçekleştirme ve sınama tarafından tüketilebilir doğru tasarım üretmektir.

## Sınır vakaları

### R10 neden F1?
R10 admitted Work'ü işletmez. Amaç ve gelişen anlayıştan Work yapısını ve living planı oluşturur. İşletim R11'e geçer.

### R16 neden F1?
R16 gate'i işletmez. Exact binding ve composite-standing semantiğini tasarlar. Operasyonel control R17'dir.

### R19 neden özel?
R19 diğer F1 uzmanlıklarının üstünde mission-level composition yapar: hangi capacity/configuration set'inin gerektiğini tasarlar.

Bu nedenle R19, **system-level formation specialization** olarak F1'de kalır; diğer F1 uzmanlıklarını kendinde eritmez.

### R24 neden F1?
R24 doğrulama hükmü vermez; doğrulamanın claim/scenario/oracle/coverage tasarımını üretir. Bu nedenle F5 değil F1'dir.

Ancak target system'i tasarlayan aktörün evaluation criterion'unu da tasarlaması criterion/independence riski yaratabilir. Aynı familyada olmak aynı effective assignment demek değildir.

## R4 düzeltmesi

S1-06'da R4 F1+F3 dual-family adayı olarak işaretlenmişti.

Asıl B2 tanımı yeniden okunduğunda R4'ün ana işi:
- bilgi sınıfları ve source-of-truth sınırı;
- provenance/currentness/version/statü gereksinimi;
- write/update/supersede/retention/forgetting davranışının tasarımı;
- index/locator requirement;
- lifecycle failure araştırmasıdır.

Bu tanım **Information lifecycle'ı fiilen işletme sorumluluğunu açıkça taşımıyor.**

Bu nedenle aday düzeltme:

- R4'ün ana familyası **F1** olsun.
- R4'teki failure araştırması F6/R3 ile yeniden normalize edilsin.
- Information lifecycle'ın gerçek F3 işletim sorumluluğu ayrıca coverage kontrolünde aransın.

Yani R4'ü sırf "Steward" adı nedeniyle F3 saymak doğru görünmüyor.

## Araştırma karşı-kontrolü

Superpowers'ta agreement/spec/plan üretimi ile implementation ve review ayrı katkılardır. Work-management araştırması planning artifact, work item ve execution state'in aynı şey olmadığını gösterir. Bu, F1'in F2/F3/F5'ten ayrılmasını destekleyen bounded evidence'tır.

Bu örnekler F1 familyasını kanıtlamaz; ayrımın gerçek sistemlerde karşılığı olduğunu gösterir.

## S1 sonucu

- R1/R7/R10/R13/R16/R19/R24 → F1 specialization'ları olarak modellenebilir.
- R4'ün design kısmı da F1'e oturur; F3 ataması geri açıldı.
- R19 system-level formation; R24 evaluation-design specialization'ıdır.
- Aynı F1 actor birden fazla specialization taşıyabilir; uzmanlık, scope ve independence gereksinimleri ayrıca sağlanmalıdır.
- F1 tasarım çıktısı F2 gerçekleştirme, F3 işletim, F4 control veya F5 assurance'ın yerine geçmez.

## Sonraki adım

Sıradaki aile **F2 Teknik Gerçekleştirme / Üretim**.

Burada mevcut R adayı yok. Bu yüzden soru birleştirme değil coverage sorusudur:

> F2 gerçekten ayrı bir başarı-yönü ailesi mi, yoksa F1 tasarımcılarının veya F3 işletim rollerinin bir çalışma kipi mi?

B1–B9'daki gerçek üretim/uyarlama yükleri bu soruyla karşılaştırılacak.
