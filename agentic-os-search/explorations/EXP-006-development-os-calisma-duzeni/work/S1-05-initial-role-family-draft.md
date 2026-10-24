# S1-05 — İlk rol ailesi taslağı

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst iş:** [S1](S1-role-responsibility-consolidation.md)  
**Tarih:** 26 Eylül 2026.  
**Durum:** Aday konsolidasyon taslağı. Nihai rol düzeni, ajan sayısı veya mimari değildir.

## 1. Bu turda ne yapıyoruz?

Amaç R1–R25'i isim benzerliğine göre azaltmak değil.

Amaç şunu görmek:

> Aynı temel başarı yönüyle çalışan sorumluluklar hangi ailede toplanabilir; hangi uzmanlık ve yetki farkları gerçek rol ayrımı gerektirir?

S1-02/S1-03'ten gelen kural korunur: **aynı aile, aynı etkin görevlendirme demek değildir.**

## 2. İlk rol ailesi taslağı

### F1 — Tasarlama / Oluşturma

**Başarı yönü:** Neyin kurulması veya nasıl yapılandırılması gerektiğini doğru biçimde belirlemek.

İlk karşılıklar:
- R1 — ortak çalışma tabanı tasarımı
- R7 — rol/aktör oluşumu
- R10 — Work oluşumu ve planlama
- R13 — Environment/capability tasarımı
- R16 — cross-ground composition tasarımı
- R19 — working-system formation
- R24 — evaluation tasarımı
- R4'ün tasarım tarafı

Bunlar tek rol değildir. Aynı aile içinde farklı uzmanlık alanlarıdır.

### F2 — Teknik Gerçekleştirme / Üretim

**Başarı yönü:** Tasarlanmış veya kararlaştırılmış gereği gerçek, kullanılabilir ve sınanabilir artefakta dönüştürmek.

Örnek çıktı:
- kod;
- ayar;
- script/hook;
- prosedür;
- entegrasyon;
- veri/şema değişikliği;
- mekanizma uyarlaması.

**Mevcut R1–R25 listesinde bu başarı yönünün açık genel sahibi yok.**

S1-04'teki G1 açığı buraya oturuyor.

Bu henüz yeni kalıcı R26 veya ayrı ajan kararı değildir. Bir F1 rolü aynı somut görevde yeterli uzmanlık/araç/yetkiyle F2 görevlendirmesini de taşıyabilir. Ancak üretim yükü örtük kalmamalıdır.

### F3 — İşletim / Stewardship / Koordinasyon

**Başarı yönü:** Kurulmuş veya aktif sistemi/işi doğru durumda tutmak ve akışını işletmek.

İlk karşılıklar:
- R4 — Information lifecycle stewardship tarafı
- R5 — context/retrieval
- R11 — Work admission/coordination
- R14 — Environment operations/readiness
- R20 — Working Configuration assembly/operation
- R21 — continuity/re-entry
- R25 — evaluation campaign operation

Bu aile “her şeyi yöneten koordinatör” değildir. Her role kendi nesnesi ve kapsamı gerekir.

### F4 — Yönetişim / Kontrol

**Başarı yönü:** Yapılabilir olan ile yapılmasına izin verilen şeyi ayırmak; mandate, authority, gate ve control sınırlarını korumak.

İlk karşılıklar:
- R9 — actor authority/delegation/governance
- R17 — cross-ground control/transition

İnsan müşterinin **yetki** çekirdeği bu aileyle ilişkilidir ama yapay zekâ kendi mandate'ini yaratamaz.

### F5 — Doğrulama / Güvence

**Başarı yönü:** İstenen sonuca ulaşmak değil, belirli bir iddia için kanıtın gerçekten yeterli olup olmadığını doğru hükmetmek.

İlk karşılıklar:
- R2 — davranış
- R6 — Information integrity
- R8 — actor competence
- R12 — Work progress/closure
- R15 — Environment effect
- R18 — integrated/composite claim

S1-01 sonucu korunur: ortak aile olabilir; aynı uzmanlık veya tek verifier olmak zorunda değildir.

### F6 — Teşhis / Toparlanma

**Başarı yönü:** Bir failure/change olduğunda sorunun doğru nedenini ve doğru geri dönüş noktasını bulmak; sistemi doğru katmanda toparlamak.

İlk karşılıklar:
- R3 — cross-domain diagnosis/rework routing
- R22 — change impact/recovery

Ayrı kalıp kalmayacakları açık. R3 neden/katman bulmaya, R22 recovery yönetmeye daha yakındır.

### F7 — Öğrenme / Uyarlama

**Başarı yönü:** Gerçek experience'i yanlış genellemeden gelecekteki davranış, yöntem veya configuration değişikliğine dönüştürmek.

İlk karşılık:
- R23 — learning/adaptation

Şimdilik tek adaydır; bu, ayrı fiziksel aktör gerektiği anlamına gelmez.

## 3. Bu taslağın söylediği ana şey

R1–R25 muhtemelen 25 bağımsız rol değildir.

Büyük kısmı şu biçimde okunabilir:

```text
rol ailesi / başarı yönü
        ×
uzmanlık alanı
        ×
somut scope
        ×
aktöre özgü bağlam + araç + yetki
        =
etkin rol
```

Örnek:

- F1 Tasarlama × Work alanı → R10-benzeri rol
- F3 İşletim × Work alanı → R11-benzeri rol
- F5 Güvence × Work alanı → R12-benzeri rol
- F1 Tasarlama × Environment → R13-benzeri rol
- F3 İşletim × Environment → R14-benzeri rol
- F5 Güvence × Environment → R15-benzeri rol

Bu tekrar deseni özellikle B3–B6'da güçlüdür.

## 4. Kullanıcının aktör/motivasyon itirazıyla ilişki

Aile ortak başarı yönünü gösterir.

Etkin rol ise ayrıca şunları gerektirir:

- hangi uzmanlık;
- hangi bağlam;
- hangi kaynaklara erişim;
- hangi araçlar;
- hangi yetki;
- ne zaman tetiklenecek;
- ne teslim edecek;
- sonucu kim kullanacak;
- hangi durumda duracak/escalate edecek.

Bu nedenle **“aynı aile” = “aynı prompt içinde hepsini ver” değildir.**

Bir aktör zaman içinde farklı ailelerde rol üstlenebilir. Çatışan başarı yönleri aynı reasoning episode'unda birleştirilecekse bunun güvenilirliği ayrıca gösterilmelidir.

## 5. Şimdiden görünür olan üç sorun

### P1 — F2 Teknik Gerçekleştirme mevcut ilk rol listesinde açık değil

Bu gerçek bir coverage açığı adayıdır.

Bütün M1–M9 mekanik sorumlulukların kim tarafından geliştirileceği ileride bu aile üzerinden tekrar kontrol edilmelidir.

### P2 — R4 iki aileyi birden taşıyor olabilir

R4'ün mevcut adı ve tanımı hem Information düzenini **tasarlama** hem de yaşam döngüsünü **stewardship** altında tutuyor.

Bu nedenle R4'ün F1 ve F3 arasında bölünmesi veya aynı actor'un iki ayrı görevlendirme kipinde taşıması değerlendirilmelidir.

### P3 — Teknik karar sorumluluğu henüz ayrı aile olarak kesinleşmedi

Şimdilik domain tasarım kararları F1 içinde; authority/mandate F4 içinde görünüyor.

Bunun yeterli olup olmadığı ayrıca sınanmalı. Sırf “karar veriyor” diye yeni yönetici ailesi açılmadı.

## 6. Sonraki sınırlı iş

Bu aile taslağını hemen doğru kabul etme.

Sıradaki iş:

1. R1–R25'in tamamını bu yedi aileye tek tek yerleştir.
2. Her yerleştirmede başarı yönü gerçekten uyuyor mu kontrol et.
3. Bir aday iki aileye düşüyorsa nedenini aç.
4. Sahipsiz sorumluluk var mı bak.
5. Özellikle F2'nin B1–B9 boyunca hangi gerçek üretim işlerini taşıması gerektiğini kontrol et.

Bu kontrol tamamlanmadan aileleri nihai DevOS rolleri sayma.
