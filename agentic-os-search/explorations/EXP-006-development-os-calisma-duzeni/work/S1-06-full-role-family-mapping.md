# S1-06 — R1–R25 tam aile eşlemesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst iş:** [S1](S1-role-responsibility-consolidation.md)  
**Tarih:** 26 Eylül 2026.  
**Durum:** Aday tam eşleme. Nihai DevOS rol düzeni değildir.

## 1. Ne yaptık?

S1-05'te çıkarılan yedi aileye R1–R25'in tamamı tek tek yerleştirildi.

Amaç rol adlarını azaltmak değil; her adayın **birincil başarı yönünü** bulmak ve iki aileye taşan ya da sahipsiz kalan sorumlulukları görmekti.

## 2. Tam eşleme

| Aday | Birincil aile | Not |
|---|---|---|
| R1 Ortak Çalışma Tabanı Tasarımcısı | **F1 Tasarlama/Oluşturma** | Ortak davranış standardını tasarlar. |
| R2 Davranış Doğrulayıcısı | **F5 Doğrulama/Güvence** | Davranış iddiasını sınar. |
| R3 Davranış Teşhisçisi / Değişiklik Analisti | **F6 Teşhis/Toparlanma** | Failure nedenini ve geri dönüş dalını bulur. |
| R4 Information Steward | **F1 + F3** | Bilgi düzenini tasarlama ile yaşam döngüsünü işletme aynı adayda karışmış. Gerçek dual-family adayı. |
| R5 Context & Retrieval Curator | **F3 İşletim/Stewardship** | Belirli Work/Actor için context'i fiilen kurar ve sunar. |
| R6 Information Integrity Reviewer | **F5 Doğrulama/Güvence** | Information claim'ini sınar. |
| R7 Role & Actor Formation Designer | **F1 Tasarlama/Oluşturma** | Role/actor formation'ı tasarlar. |
| R8 Actor Qualification Reviewer | **F5 Doğrulama/Güvence** | Actor competence/fit iddiasını sınar. |
| R9 Actor Governance Steward | **F4 Yönetişim/Kontrol** | Authority/delegation/obligation sınırlarını korur. |
| R10 Work Formation & Planning Designer | **F1 Tasarlama/Oluşturma** | Work ve living planı oluşturur. |
| R11 Work Admission & Coordination Steward | **F3 İşletim/Stewardship** | Work flow/admission/coordination'ı işletir. |
| R12 Work Progress & Closure Reviewer | **F5 Doğrulama/Güvence** | Progress/closure claim'ini sınar. |
| R13 Environment & Capability Formation Designer | **F1 Tasarlama/Oluşturma** | Environment çözümünü tasarlar. |
| R14 Environment Operations & Readiness Steward | **F3 İşletim/Stewardship** | Kurulu Environment'ı hazır ve current tutar. Küçük teknik uyarlama taşıyabilir ama F2 otomatik sahibi değildir. |
| R15 Environment Reality & Effect Reviewer | **F5 Doğrulama/Güvence** | Actual state/effect claim'ini sınar. |
| R16 Cross-Ground Composition Designer | **F1 Tasarlama/Oluşturma** | Binding ve composite-standing semantiğini tasarlar. |
| R17 Cross-Ground Control & Transition Steward | **F4 Yönetişim/Kontrol** | Gate/enforcement/transition control'ünü yönetir. |
| R18 Composition Integrity Reviewer | **F5 Doğrulama/Güvence** | Integrated/composite claim'i sınar. |
| R19 Working System Formation Designer | **F1 Tasarlama/Oluşturma** | Mission-specific working system'i tasarlar. |
| R20 Working Configuration Assembly Steward | **F3 İşletim/Stewardship** | Configuration'ın assemble/activate/reconfigure edilmesini koordine eder. |
| R21 Continuity & Re-entry Steward | **F3 İşletim/Stewardship** | Work/state continuity ve re-entry'yi işletir. |
| R22 Change Impact & Recovery Steward | **F6 Teşhis/Toparlanma** | Change/failure sonrası invalidation ve recovery'yi yönetir. Recovery operasyonu nedeniyle F3'e temas eder fakat başarı yönü F6'dır. |
| R23 Learning & Adaptation Steward | **F7 Öğrenme/Uyarlama** | Experience'i kontrollü adaptation'a dönüştürür. |
| R24 SOUL Evaluation Architect | **F1 Tasarlama/Oluşturma** | Evaluation system/claim/scenario/oracle tasarlar. |
| R25 Evaluation Campaign Steward | **F3 İşletim/Stewardship** | Evaluation campaign'i fiilen işletir. |

## 3. Ailelere göre görünüm

### F1 — Tasarlama/Oluşturma
R1, R4'ün tasarım tarafı, R7, R10, R13, R16, R19, R24.

### F2 — Teknik Gerçekleştirme/Üretim
**R1–R25 içinde birincil sahibi yok.**

S1-04'te tanımlanan teknik gerçekleştirme görevlendirmesi bu boşluğu dolduran ilk adaydır.

### F3 — İşletim/Stewardship/Koordinasyon
R4'ün stewardship tarafı, R5, R11, R14, R20, R21, R25.

### F4 — Yönetişim/Kontrol
R9, R17.

### F5 — Doğrulama/Güvence
R2, R6, R8, R12, R15, R18.

### F6 — Teşhis/Toparlanma
R3, R22.

### F7 — Öğrenme/Uyarlama
R23.

## 4. Eşlemenin açtığı sorunlar

### P1 — F2 gerçek coverage açığı
Bu artık yalnız tek örnekte görülen G1 açıklığı değil.

R1–R25'in tamamına bakıldığında **kod/prosedür/entegrasyon/mekanik üretme başarı yönünü birincil amaç olarak taşıyan mevcut rol yok.**

Bu, mutlaka ayrı fiziksel rol/ajan gerektiğini göstermez. F1 veya F3 ailesindeki yeterli bir aktör F2 görevlendirmesi taşıyabilir. Fakat görevlendirme görünür olmalıdır.

### P2 — R4 gerçek bir karışık rol adayı
R4 hem Information düzenini tasarlıyor hem de lifecycle stewardship yapıyor.

Bu iki başarı yönü aynı aktörde taşınabilir; fakat aynı şey değildir. S1'de R4'ün bölünmesi veya iki ayrı görevlendirme kipiyle çalışması ayrıca değerlendirilmelidir.

### P3 — R22 dual-family sınırına yakın
R22'nin nedeni/impact/recovery seçimi F6'dır. Recovery Work'ünü fiilen koordine etmesi F3'e temas eder.

Şimdilik ayrı aileye bölünmedi; başarı yönü “failure sonrası doğru toparlanma” olduğu için F6'da tutuldu.

### P4 — Teknik karar için ayrı aile henüz gerekmedi
“Karar vermek” tek başına başarı yönü olarak görülmedi.

- Tasarım kararı → F1.
- Operasyon/admission kararı → F3.
- Authority/permission kararı → F4.
- Failure/recovery kararı → F6.

Bu dağılım yetersiz çıkarsa ayrı karar familyası yeniden açılır.

### P5 — Araştırma ayrı aile olarak açılmadı
Araştırma şu an bir **yöntem/kabiliyet** olarak görülüyor.

F1 tasarım için araştırabilir; F5 doğrulama için bağımsız kaynak arayabilir; F6 teşhis için araştırabilir; F7 öğrenme için araştırabilir.

“Researcher” ancak araştırmanın kendisi ayrı ve sürekli bir başarı yönü/çıktı üretmeye başlarsa ayrı rol ailesi adayı olur.

## 5. Araştırma örnekleriyle kısa karşı-kontrol

- Superpowers'ta implementer, reviewer ve controller farklı başarı yönleri taşır. Bu F2/F5/F3 ayrımının mümkün bir örneğidir; evrensel şema değildir.
- Work-management araştırması authority, assignment, claim, liveness ve integration authority'nin aynı şey olmadığını; completion ve verification'ın da ayrı standings olduğunu gösterir. Bu F3/F4/F5 ayrımını destekleyen bounded evidence'tır.
- Harness Engineering araştırması model-external controls, context/memory plumbing, orchestration, verification ve observability'nin farklı system responsibilities olduğunu gösterir. Bu mekanik sorumlulukların yalnız prompt/rol metnine indirgenmemesi için design pressure sağlar.

Bu kaynaklar yedi aileyi kanıtlamaz; taslağın bazı ayrımlarının gerçek örneklerde de ortaya çıktığını gösterir.

## 6. Şimdiki çalışma hipotezi

İlk sade model:

```text
AI Actor
  ↓
Family / başarı yönü
  ×
uzmanlık alanı
  ×
scope
  ×
actor operating profile
  =
etkin rol
```

Family, ortak başarı yönüdür.

Uzmanlık alanı örneğin Information, Actors, Work, Environment veya cross-ground olabilir.

Operating profile; context, tools, authority, trigger, handoff ve sınama koşullarını taşır.

## 7. Sonraki adım

Şimdi aile sayısını artırmak veya azaltmak yerine **ilk gerçek aile konsolidasyonunu** sınamak gerekir.

En iyi başlangıç F5 Doğrulama/Güvence'dir; çünkü:
- altı mevcut aday aynı başarı yönünde görünüyor;
- uzmanlık farkları açık;
- independence ve actor-conditioning tartışması burada yük taşıyor;
- aile yaklaşımının işe yarayıp yaramadığını güçlü biçimde sınayabilir.

Sonraki soru:

> R2, R6, R8, R12, R15 ve R18 gerçekten tek “Doğrulama/Güvence” rol ailesinin uzmanlık kipleri mi; yoksa bazıları başarı yönü veya gerekli epistemik konum nedeniyle ayrı aile/rol olarak kalmalı?

Bu çözülmeden yedi aile nihai kabul edilmez.
