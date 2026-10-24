# S1-12 — F6 Teşhis / Etki Analizi / Recovery Yönlendirme ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

R3 failure/root-cause routing ile R22 change-impact/recovery sorumluluğunun gerçekten aynı aileye ait olup olmadığı sınandı.

Önceki ad **Teşhis / Toparlanma** idi. İnceleme, “toparlanma” kelimesinin recovery'yi bizzat uygulama anlamı taşıyabildiğini gösterdi.

Aday yeni ad:

> **F6 — Teşhis / Etki Analizi / Recovery Yönlendirme**

## Sonuç

**F6 tek bir aile olarak ayakta kalıyor.**

Ortak başarı yönü:

> Failure, değişiklik veya unknown effect sonrasında neyin yanlış/şüpheli olduğunu, hangi sonuçların geçerliliğini kaybetmiş olabileceğini ve sistemin hangi Work üzerinden güvenilir ilerlemeye dönmesi gerektiğini doğru belirlemek.

İki ana specialization:

| Aday | F6 uzmanlığı |
|---|---|
| R3 | causal diagnosis / root-cause routing |
| R22 | change-impact / invalidation / recovery-path selection |

## R3 ile R22 neden aynı familyada?

R3 şu soruya bakar:

> Sorunun nedeni hangi katmanda ve hangi Work yeniden açılmalı?

R22 şu soruya bakar:

> Bu failure/değişiklikten ne etkilendi ve hangi recovery/requalification yolu açılmalı?

Biri daha causal, diğeri daha impact/response yönelimlidir.

Ama ikisinin ortak başarısı:

> **Yanlış şeyi düzeltmeden, doğru geri dönüş yolunu bulmak.**

## F3 sınırı

R22 recovery'yi kendi başına uygulayan operator değildir.

R22:
- selective invalidation belirler;
- retry/rollback/compensation/reconciliation gibi recovery türünü seçer;
- hangi Work'ün yeniden açılacağını üretir;
- hangi qualification'ın tekrar gerektiğini belirler.

Recovery'nin fiilî uygulanması ise işin türüne göre:
- F1 redesign,
- F2 implementation/repair,
- F3 operational retry/rebind/reconfigure,
- F4 authority/control değişikliği,
- F5 requalification

tarafına gider.

Bu nedenle R22'nin F3'e temas etmesi, F3 familyasına taşınmasını gerektirmiyor.

## Önemli ayrım: root cause her recovery'den önce zorunlu değil

Unknown effect veya yüksek riskli durumda sistem önce:
- ilgili standing'i unknown/stale yapabilir;
- Work'ü durdurabilir;
- readback/reconciliation isteyebilir;
- güvenli recovery yolunu açabilir.

Tam root cause daha sonra bulunabilir.

Bu nedenle F6 içinde iki specialization ayrı tutulmalıdır:

```text
causal diagnosis
≠
impact / invalidation / recovery routing
```

Aynı aktör ikisini taşıyabilir; her vakada ikisinin de tamamlanması zorunlu değildir.

## F5 sınırı

F6 failure'ın nedenini ve geri dönüş yolunu belirler.

F5 ise:
- failure claim'ini,
- recovery sonrası state'i,
- yeniden qualification sonucunu

sınar.

F6'nın “sorun düzeldi” demesi F5 assurance yerine geçmez.

## Araştırma karşı-kontrolü

**Superpowers:** hypothesis-led diagnosis ve correction/review ayrı sorumluluklar olarak görünür. Diagnosis'ın çıktısı doğrudan aynı düzeltmeyi tekrarlamak değildir.

**Work-management corpus:** reopen, retry, revise, compensate, redispatch gibi backward movements aynı şey değildir. Bu, R22'nin recovery türünü ayırma sorumluluğunu destekler.

**gstack:** investigation/causal control ile repair/recovery ayrı yüzeylerdir; ayrıca failure → source change → eval gibi geri dönüş yolları vardır. Bu, causal diagnosis ile recovery response'un aynı problem ailesinde farklı işlevler olduğunu gösterir.

Bu kaynaklar F6 familyasını kanıtlamaz; ayrımın gerçek sistemlerde tekrar ettiğini gösterir.

## F6 family contract adayı

Bir F6 görevlendirmesinde en az şunlar açık olmalı:

1. Gözlenen failure/change/unknown effect nedir?
2. Hangi evidence gerçek, hangisi yalnız rapor/temsil?
3. Hangi makul nedenler ayrıştırılmalı?
4. Hangi prior standing/result stale veya unknown olabilir?
5. Hangi Work yeniden açılmalı?
6. Recovery tipi ne: retry, repair, rollback, compensation, reconciliation, reconfiguration, revalidation vb.?
7. Hangi familya recovery Work'ünü fiilen taşıyacak?
8. Hangi claim'ler F5 tarafından yeniden sınanmalı?

## S1 sonucu

- **S1-12-A1:** R3 ve R22 tek F6 familyasının iki specialization'ı olarak modellenebilir.
- **S1-12-A2:** Family adı aday olarak **Teşhis / Etki Analizi / Recovery Yönlendirme** olmalıdır.
- **S1-12-A3:** R22 recovery'yi fiilen işletmekten çok recovery Work'ünü seçer ve yönlendirir; bu nedenle birincil familyası F6'dır, F3 değildir.
- **S1-12-A4:** Tam root cause her recovery kararı için önkoşul değildir; impact/invalidation/reconciliation bazı durumlarda önce gelebilir.
- **S1-12-A5:** F6 recovery'nin başarısını kendi hükmüyle kapatmaz; ilgili F5 requalification gerekir.

## Sonraki adım

Sıradaki familya **F7 Öğrenme / Uyarlama**.

Şu an yalnız R23 var.

Bu nedenle soru birleştirme değil:

> F7 gerçekten ayrı bir başarı yönü mü, yoksa F6 failure response + F1 redesign + F3 lifecycle operation birleşiminin adı mı?

Ayrıca "öğrenme" ile gerçek system adaptation'ın aynı sorumluluk olup olmadığı sınanacaktır.
