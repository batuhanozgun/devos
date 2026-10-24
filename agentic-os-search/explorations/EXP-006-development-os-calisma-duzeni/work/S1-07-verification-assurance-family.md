# S1-07 — F5 Doğrulama / Güvence ailesinin sınanması

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst iş:** [S1](S1-role-responsibility-consolidation.md)  
**Tarih:** 26 Eylül 2026.  
**Durum:** Aday family consolidation. Nihai rol düzeni veya bağımsız doğrulama mimarisi değildir.

## 1. Ne yaptık?

R2, R6, R8, R12, R15 ve R18'in gerçekten aynı rol ailesine ait olup olmadığı sınandı.

Soru:

> Bunların başarı yönü aynı mı, yoksa yalnız isimleri “reviewer/verifier” olduğu için yanlış biçimde birleştiriyor muyuz?

## 2. Sonuç

**Aday hüküm: F5 tek bir Doğrulama / Güvence ailesi olarak korunabilir.**

Altı adayın ortak başarı yönü:

> **Belirli bir iddia hakkında, üreticinin isteğinden bağımsız biçimde, uygun kanıtın neyi desteklediğini ve neyi desteklemediğini doğru hükmetmek.**

Farkları başarı yönünde değil; **doğruladıkları claim familyasında, gereken uzmanlıkta ve kanıt erişiminde**.

## 3. Altı adayın uzmanlık kipleri

| Eski aday | F5 içindeki uzmanlık kipi | Ana soru |
|---|---|---|
| R2 | Behavior assurance | Aktör beklenen çalışma davranışını gerçekten gösteriyor mu? |
| R6 | Information assurance | Kaynak, currentness, seçim, exposure ve use zinciri iddiayı taşıyor mu? |
| R8 | Actor qualification assurance | Bu actor bu role/scope için gerçekten yeterli mi? |
| R12 | Work assurance | Work gerçekten ilerledi mi; hangi closure standing destekleniyor? |
| R15 | Environment/effect assurance | Gerçek Environment state/effect iddia edildiği gibi mi? |
| R18 | Composition/integrated assurance | Yerel doğrulardan çıkarılan birleşik hüküm gerçekten destekleniyor mu? |

Bu tablo altı ayrı fiziksel verifier gerektirmez.

## 4. Ortak F5 sözleşmesi

Bir F5 görevlendirmesinde en az şu unsurlar görünür olmalı:

1. **Claim:** Tam olarak hangi iddia sınanıyor?
2. **Target:** Hangi exact nesne/sürüm/scope?
3. **Criterion/oracle:** Hangi durumda claim desteklenmiş veya başarısız sayılır?
4. **Evidence path:** Hangi kanıta doğrudan ulaşılmalı?
5. **Independence boundary:** Üreticiyle hangi hata kaynakları ortak?
6. **Verdict set:** Destekleniyor / başarısız / doğrulanamıyor / sınanmadı gibi fail-visible sonuçlar.
7. **Freshness:** Target veya load-bearing dependency değişirse eski verdict otomatik current kalmaz.
8. **No silent repair:** Verifier nesneyi değiştirirse o değişiklik bakımından üretici konumuna geçer; eski verdict yeni nesneye taşınmaz.

Bunlar family-level reasoning contract adayıdır. Her uzmanlık kendi yöntem ve kanıt ihtiyacını ekler.

## 5. Neden ayrı ailelere bölmedik?

### R8 qualification neden ayrı aile değil?
Qualification, “bu actor bu scope için yeterli mi?” claim'inin doğrulanmasıdır. Başarı yönü yine doğru evidence-bounded hüküm vermektir.

### R15 observation neden ayrı aile değil?
R15'in authoritative readback/actual effect gözlemi özel bir evidence path'tir. Gözlem tek başına başarı yönü değildir; gözlem, claim hakkında hüküm için kullanılır.

### R12 closure neden ayrı aile değil?
Work closure çok katmanlıdır; execution complete, verified, valid-fit ve accepted ayrılır. R12'nin görevi bunları doğru ayırıp desteklenen standing'i söylemektir. Acceptance yetkisini kendisi üretmez.

## 6. R18 neden özel?

R18 diğer beşinden yalnız domain farkıyla ayrılmıyor.

R18 **ikinci-seviye/composite assurance** yapıyor:

- R6 Information standing;
- R8 actor qualification;
- R12 Work standing;
- R15 actual effect;
- diğer ground-local facts

gibi girdilerden çıkan **birleşik hükmü** sınar.

Bu nedenle F5 içinde iki seviye adayı görünür:

```text
F5 local/specialist assurance
    → behavior / information / actor / work / environment

F5 composite assurance
    → exact binding + local standings → integrated verdict
```

R18 yine F5 ailesindedir; fakat aynı effective role'ın bütün yerel verdict'leri üretip sonra kendi verdict'lerini birleştirmesi common-mode/self-review riskini büyütür.

**Aday kural:** Load-bearing composite verdict'te R18-benzeri görevlendirme, en azından composite claim'in üreticisinden epistemik olarak ayrıştırılmalı. Her local verifier'dan ayrı fiziksel model zorunlu değildir; kullanılan evidence ve oracle'a göre independence kurulmalıdır.

## 7. Aynı aktör ne zaman birden fazla F5 kipini taşıyabilir?

Taşıyabilir, eğer:

- gerekli uzmanlıkların hepsine sahipse;
- exact target ve claim'leri karıştırmıyorsa;
- evidence yollarına doğrudan ulaşabiliyorsa;
- bir claim'deki üretici rolü diğer claim'in assurance'ını kirletmiyorsa;
- independence gereksinimi aynı actor kullanımını geçersiz kılmıyorsa.

Örnek: aynı verifier bir küçük görevde hem Information source/currentness hem Work closure claim'ini inceleyebilir.

Ama bu iki ayrı claim'dir; tek “genel yeşil” verdict'e eritilmez.

## 8. Araştırma karşı-kontrolü

Superpowers örneğinde tek task reviewer hem spec compliance hem quality verdict'i verebilir. Bu, bir verifier'ın birden fazla claim taşıyabileceğini gösterir; iki verdict'i bağımsız kanıt yapmaz. Aynı kaynak, production/review/disposition ve local/final review ayrımlarını da korur.

Work-management araştırması actor completion, work-item closure, integrated effect ve desired outcome'un aynı standing olmadığını gösterir. Bu, F5'in uzmanlık ve claim-scope ayrımlarını koruması gerektiğini destekler.

Bu kaynaklar F5'in tek doğru family olduğunu kanıtlamaz; family modelinin iki önemli koşulunu destekler:
- farklı claim'ler aynı verifier tarafından taşınabilir;
- farklı claim'ler tek verdict'e collapse edilmemelidir.

## 9. S1 için konsolidasyon sonucu

**S1-07-A1:** R2/R6/R8/R12/R15/R18, tek F5 Doğrulama/Güvence ailesinin specialization'ları olarak modellenebilir.

**S1-07-A2:** Bu konsolidasyon altı uzmanlığı silmez. Rol familyası ortak başarı yönü ve reasoning contract taşır; specialization claim/evidence/domain farkını taşır.

**S1-07-A3:** R18, F5 içinde composite-assurance specialization'ıdır; gerekirse farklı effective assignment/independence topology ister.

**S1-07-A4:** Böylece ileride nihai rol düzeninde altı kalıcı üst rol yerine “F5 Verifier/Assurance + specialization” modeli mümkündür. Bu henüz kabul edilmiş DevOS kadrosu değildir.

## 10. Sonraki adım

F5 family yaklaşımının işe yaradığına dair ilk olumlu sonuç oluştu.

Sıradaki aile **F1 Tasarlama/Oluşturma** olarak açılabilir.

Soru:

> R1, R4'ün tasarım tarafı, R7, R10, R13, R16, R19 ve R24 gerçekten tek “Tasarlama/Oluşturma” ailesinin uzmanlık kipleri mi; yoksa planlama, system formation veya evaluation design farklı başarı yönleri nedeniyle ayrılmalı mı?

F1 açılırken R4'ün F1/F3 karışıklığı ayrıca çözülecektir.
