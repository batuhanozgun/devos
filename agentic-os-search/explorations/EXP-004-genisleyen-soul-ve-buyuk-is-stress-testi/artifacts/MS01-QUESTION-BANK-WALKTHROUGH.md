# MS01 — Soru-bankası üzerinde ilk mekanizma yürüyüşü

**2026-09-21 / Checkpoint A / KURGUSAL YÜRÜYÜŞ, NOT RUN.** [Ana taslak](MS01-SOUL-WORKING-SYSTEM-DRAFT.md) K1–K7'nin birlikte ne yaptığını açar. Buradaki MC/W/R/CP/QC/D/SC kimlikleri açıklayıcı fixture kimlikleridir; repository'de gerçek öğrenci, kaynak dosyası, agent oturumu veya araç işlemi oluşturulmadı. Aşağıdaki küçük soru metinleri bu not için üretilmiş örneklerdir; gerçek yıllık soru-bankası üretimi değildir.

**Başlangıç ref:** `0dd58080eeea4ee8c7eaaaef0902d02fce825edc`. T1–T15'i tekrar yapılmış saymıyoruz. Onların hata koşullarını yeni MS01 mekanizmalarına uygulayan aynı-assistant thought walkthrough yapıyoruz.

## 1. Vakanın girdisi ve sahte kanıt üretmeme sınırı

Ham talep: «Bir eğitim yılı için 4. sınıf matematik soru bankası ve bunu üretecek sürdürülebilir düzen oluştur.» B0 bunun gerçek ülkesini, müfredat yılını, öğrenci profilini veya yayın iznini uydurmaz. Mission Contract önce `MC1-draft` olur. W01, ilk talebi üretime çevirmek değil, amaç ve çalışma sınırını oluşturmaktır.

İşleyişi gösterebilmek için bu notta açık bir sentetik devam koşulu veriyoruz: owner, aynı yıllık büyük hedef altında, önce iki örnek soruluk **iç inceleme dilimine** izin vermiş olsun. Örneklerde öğrenciye yapılacak işlemi doğrudan söylemeden uygun yaklaşımı seçmeye dönük alıştırma amaçlansın. Yıllık program, gerçek müfredat uygunluğu, öğrenci kazanımı veya dış yayın başarısı bu dilimle tamamlanmış sayılmasın. Bu seçim önceki kullanıcı brief'ine gerçek karar olarak eklenmez.

Fixture kaynağı `FS1@v1` yalnız şu düşünsel koşulu taşır: «Örnek alıştırmalar eşit paylaşım ve eşit gruplardan toplam bulmayı ayırt etmeye elverişli olacak.» FS1 gerçek resmî kaynak değildir; kaynak okuma/admission hareketini göstermek için verilen öncüldür. Gerçek uygulamada ülke/yıl/müfredat ve pedagojik dayanak ayrı kaynak çalışması ister. Burada sahte alıntı, hayalî uzman veya öğrenci sonucu kanıt yapılmaz.

## 2. Başlangıç: araştırmacıyı oluşturmadan önce B0 çalışır

Host, başlangıç grant'i `D0` altında B0'ı çağırır. D0 yalnız mevcut izinli kaynakları inceleme, taslak hazırlama ve Work önerme hakkı içerir; dış yayın veya ortak kural değişikliği içermez.

K1, ham talep ile yorumunu ayırarak `MC1-draft` üretir. İç inceleme dilimi ve karşılanmamış yıllık hedef bu kayıtta ayrı durur. K6, owner'ın sentetik kapsam kararını `D1` olarak bağlar; `MC1@v1` ilgili iç çalışma için etkin olur. Bu aşamada herhangi bir eğitim ürünü onaylanmadı.

**Durum değişimi:** W01 completed-for-framing; Mission open; kaynak incelemesi W02 ve ilk yöntem/örnek oluşturma W03 proposed. B0'ın varlığı bu işlerin tamamında uzman olduğuna kanıt değildir.

## 3. Önceden işaretlenmemiş ilişki için ilk somut keşif hareketi

K1, «iki soru yaz» listesinden başlamak yerine MC1'in hedefi ile FS1'deki koşulu birlikte okur. Üretim ve kullanım yolu şu açık soruya yol açabilir: «Sorunun aritmetik olarak doğru olması, öğrenciye seçmesi istenen yaklaşımı gerçekten seçtirmeye elverişli olmasıyla aynı mı?»

Bu yürüyüşte bu soru modelin ürettiği **kurgulanmış ara ürün**dür; bir modelin ipucusuz keşif başarısını ölçmüş değiliz. B0'ın somut yöntemi, hedeflenen kullanımın adımlarını izlemek ve mevcut üretim/doğrulama yolunun hangi adımı açıklamadığını sormaktır. FS1'i sadece başlık eşleştirmesiyle Work listesine dönüştürmez.

K2, `I1` inquiry Work'ünü açar: «Alıştırmanın sağladığı yardım ile amaçlanan yaklaşım seçimini ayıran inceleme biçimi öner.» `return_to = W03-method-choice`. I1'in sonucu yeni bir sonsuz araştırma zinciri değil, hangi inceleme yönteminin ilk dilime bağlanacağı kararıdır. Başka yeni bir pedagojik soru bulunursa onun hangi kararı gerçekten engellediği ayrıca değerlendirilir.

İlgili yeterlik veya kaynak erişimi bulunamazsa I1 açık kalır; dar aritmetik üretimi araştırma adayı olarak sürebilir, geniş uygunluk iddiası ilerlemez. Öğrenci/uzman verisi yokluğu olumlu yeterlik diye yorumlanmaz.

## 4. İşi yapacak bileşim: SC1

K4, ilk dilim için şu konfigürasyonu önerir:

| Rol / araç | Bağlanan iş ve girdi | Yetki / sonuç sınırı |
|---|---|---|
| B0 koordinasyon rolü | MC1, Work Model ve açık I1 sorusu | İş önerir/atar; owner kapsamını değiştiremez. |
| A1 üretim rolü | İç örnek brief'i, FS1 ve seçilmiş üretim yöntemi | Soru ve çözüm adayı; kendi eserini son kabul statüsüne taşıyamaz. |
| A2 çözüm/inceleme rolü | Soru metni; ilgili incelemede üreticinin çözümü başlangıç girdisi yapılmaz | Çözüm ve gerekçe üretir; aynı model kullanılıyorsa bağımsız insan doğrulaması sayılmaz. |
| Hesap aracı | 24/6 ve 6×24 gibi açık işlem ifadeleri | Aritmetik yardımcı sonuç; beceri seçimi, müfredat veya öğrenme oracle'ı değildir. |

A1/A2 yeni eğitilmiş modeller değil, mevcut taşıyıcıya bağlanan rol/çağrı örnekleridir. Bu basit alıştırma için ayrı model ailesini zorunlu kılmıyorum; aynı-model ortak hata riski sonucu sınırlar. Daha güçlü alan iddiası gerekiyorsa K4 ayrı yeterlik/dayanak edinme Work'ü açar.

`SC1` ayrıca kaynak erişim kapsamı, yazılabilir candidate alanı, gereken QC'ler ve iç incelemeye teslim yetkisini taşır. Dış yayın aracı yoktur. Böylece «uzman agent oluşturduk» yerine hangi somut işin hangi bilgi/araçla yapılabileceği görünür olur.

## 5. T08'in arızası: iyi görünen özet başlatma izni değildir

FS1'in bir kapsam yorumu `A-SCOPE@v1` olarak henüz incelemedeyken bir özetin «kapsam belirlendi» dediğini düşünelim. W03'ün committed örnek üretimine geçişi, scope yorumunun ilgili kullanımda kabulünü gerektiriyor olsun.

K3, CP03'e A-SCOPE kimliğini, sürümünü ve actual karar statüsünü ekler. Özetin cümlesi acceptance record yerine geçmez. K6'nın `before_work_start` noktası D-scope kararının bulunmadığını görür. **W03 için Run yaratılmaz.** Ret nedeni «kaynak yok» değil, «gerekli scope kabulü yok»tur.

K2 bunun yerine `W02-review-scope` işini açar. Bu işin girdisi zaten aday scope'tur; aynı kabul koşuluyla bloklanmaz. K5 kaynak–yorum bağını değerlendirir; fixture içinde uygun bulunduğu varsayılan iç kapsam, yetkili karar yoluyla `D2` olur. Olumsuz veya belirsiz sonuçta üretim kabulü doğmaz.

Artık W03 için K6, MC1/FS1/A-SCOPE/D2/SC1/CP03 revision bağlarını ve aktör erişimini kontrol edip claim ile `R03` denemesini oluşturur. Bu geçiş yerel düşünsel kontroldür; K5'in yorumunun eğitimsel doğruluğunu kod doğrulamış sayılmaz.

## 6. Gerçek üretim hareketini atlamamak

A1'in ilk adayında şu küçük parça olsun:

> Bölme işlemiyle çözünüz. 24 kart 6 çocuğa eşit paylaştırılıyor. Her çocuk kaç kart alır?

Üretici çözümü: 24/6 = 4. A2'nin ayrı çözüm türetmesi ve hesap aracı da aynı aritmetik sonuca ulaşmış olsun. Burada yalnız mekanizmayı işletmek için olumlu alt sonuç varsayıyoruz; araç çağrısı veya model deneyi yapılmadı.

K5 iki farklı Qualification Case üretir: `QC-math@v1`, verilen işlemin/sorunun dar aritmetik doğruluğunu destekler; `QC-fit@v1`, MC1'in işlemi doğrudan söylememe koşuluyla uyumsuz başlığı gösterir. İkinci kontrol sadece üreticinin doğru cevabını kopyalamaz; soru metni, görev amacı ve yardım koşulunu karşılaştırır. Soru matematiksel olarak yanlış diye silinmez, ama bu iç amaç için kabul edilmez.

K6, R03'ün sonuçlandığını ve candidate artifact'i kaydeder; W03'ü otomatik accepted yapmaz. K2, QC-fit'in somut bulgusunu W04 revision Work'üne ve I1'in ana yöntem kararına taşır. Böylece çıktı, kanıt, karar ve yeni Work gerçekten farklı yönlere gider.

## 7. Revizyon ve kapsamı sınırlı kabul

A1, yeni aday `A-SET@v2` içinde başlığı kaldırıp iki farklı ilişki taşıyan örnek önerir:

> 1. 24 kart 6 çocuğa eşit paylaştırılıyor. Her çocuk kaç kart alır?
>
> 2. Her birinde 24 kart bulunan 6 kutuda toplam kaç kart vardır?

Çözüm adayları 4 ve 144'tür. Başlık kaldırılması tek başına yeterli sayılmaz: K5 yeniden metnin ilişkiyi anlaşılır sunduğunu, doğrudan işlem komutu vermediğini ve çözümün kurulan koşullarla uyduğunu değerlendirir. Tek başına bu iki örnekle yaş uygunluğu, yıllık kapsam veya öğrenme etkisi doğrulanmaz.

`QC-math@v2` ve `QC-format@v2` olumlu kabul edilmiş olsun. Yetkili `D3`, yalnız iki örneğin **iç inceleme dilimine** verilmesini kabul eder. `QC-learner-outcome` ve gerçek müfredat uygunluğu hâlâ açık. Sonraki gerçek ürün amacı bunları gerektirirse ilgili gate kapalıdır.

K2'nin durumu: ilk örnek dilimi hazır; yıllık program tamamlanmadı. «İki soru kabul edildi» sonucu «öğrenciler bağımsız yöntem seçebiliyor» diye raporlanmaz. Ama gerekli her empirik çalışma bitmedi diye bu izinli iç inceleme dilimi de süresiz bekletilmez.

## 8. Kaynak değişimi: eski Run'dan gelen geç çıktı

Yıllık programın sonraki grubu için `R07`, FS1@v1 ve SC1 altında çalışırken kaynak/yerleştirme koşuluna ilişkin yeni `FS1@v2` geldiğini varsayalım. Değişiklik, eşit grup pratiğinin hangi sırada kullanılacağına ilişkin olsun; mevcut aritmetik sonuçları tek başına çürütmesin.

K6 kaynak revision değişimini olay olarak yazar. K7, bilinen `uses/supports` bağlarından kapsam/yerleştirme QC'sini ve ilgili Work'leri etki incelemesine alır. K1/K5, başka etkilenmiş ama önceden bağlanmamış ilişki var mı diye sınırlı inceleme yapar. Kapsam dışı matematik kanıtları tarihsel ve uygun kullanımda korunabilir.

R07'nin ürünü geç gelirse K6 başlangıç basis'i ile güncel kabul dayanağının farkını görür. Candidate kaydedilir, fakat güncel kapsam için otomatik accepted yapılmaz. K7 uyarlama, kısmi yeniden inceleme veya etkisizliğin gerekçelendirilmesi seçeneklerini açar. İlgili yerleştirme/yayın etkisi bekler; bütün bağımsız yazım ve kaynak işleri durmak zorunda değildir.

**Bu yürüyüşün mekanizma düzeltmesi:** Başlangıçta bütün şartların sağlanması daha sonraki sonuç kabulüne yetmez. `before_result_admission` yalnız dosya biçimini değil, Run'ın dayandığı maddi kaynak/karar sürümlerini de bağlamalıdır.

## 9. Kesinti: işlemin sonucu bilinmiyorsa tekrar yazma

Kabul edilmiş iç dilimin teslim hedefinde yazılması için K6 `OP1` etki niyetini kaydetsin. Adaptör yazma isteğini yollasın; cevap dönmeden aktör/bağlantı kaybolsun. Günlükte niyet var, kesin etki gözlemi yok. Doğru durum `effect unknown`dur.

Yeni oturumda Host `on_resume` ile K7'yi çağırır. Yeni B0 sohbetin son cümlesinden değil MC1, güncel D kararları, Work/Runs ve OP1'den başlar. Önce eski claim dönemi geçersizleştirilir; geç gelen eski aktör ortak state'i sessizce yazamaz. Ardından OP1 hedefi okunur.

Kurguladığımız olumlu dalda hedefte tam kabul edilen A-SET@v2 kimliği/sürümü bulunur. K7 bu gözlemi Effect Record'a bağlar; aynı yazma ikinci kez yapılmaz. Bu, dar teslim etkisini uzlaştırır; öğrencilerin sonucu kullandığı veya öğrendiği anlamına gelmez.

Diğer dalda hedef okunamıyorsa etkisizlik varsayılmaz. İdempotent/koşullu tekrar imkânı doğrulanmamışsa ilgili etki bekler veya yetkili onarım kararına taşınır. Kayıt geri yüklemek haricî etkiyi geri almak değildir. Host ile dış sistemin tek atomik transaction paylaşmadığı açık kalır.

## 10. Yöntemi geliştirmek ve büyümeyi görünür yapmak

Örneğin I1 sonucundan «bağımsızlık iddiasıyla kullanılan yardım koşullarını birlikte incele» yöntem adayı çıkabilir. K5'in bulgusu Method Library'ye kaynak ve sınırlarıyla kaydedilir. Bu, etkin SC1'i değiştirmez.

K4, sonraki ilgili Work için bu adayı seçmeyi önerir; kapsam içindeki yöntem kararıyla `SC2` oluşabilir. Mevcut R07 otomatik SC2'ye geçirilmez. Ortak bazın bütün görevlerini değiştirmek ise ayrıca Change Proposal ve uygun yetki gerektirir. Dersin bulunması, seçimi, uygulanması ve faydası ayrı kanıt yükleridir.

Yeni bir kontrol aracı gerekirse K4 yalnız katalog satırı eklemez: gerçek giriş/çıkış, izin, etkiler, K6 adaptörü, K3 bağlamı ve K7 recovery yolu bağlanır. Böylece SOUL yeni rol/yöntem eklerken mevcut kontrolün kapsadığı yolları da genişletir. Bu koşullar sağlanamazsa dar local model yolu veya mevcut yöntem korunabilir; büyüme zorunlu değildir.

## 11. Son tablo: ne kapandı, ne açık?

| Nesne | Fixture sonundaki durum | Gerçek kanıt statüsü |
|---|---|---|
| MC1 / yıllık program | Büyük hedef açık; iç dilim sınırı belirli | Varsayımsal mission, gerçek ürün değil. |
| W01/W02/W03/W04 | İlgili framing/review/örnek/revizyon yolu tasvir edildi | Çalıştırılmadı. |
| A-SET@v2 / D3 / OP1 | Olumlu dalda iç inceleme için kabul ve teslim uzlaştırıldı | Kurgulanmış geçiş; yayımlanmış soru bankası yok. |
| R07 | Güncel dayanak uyumu için yeniden değerlendirmede | Geç gelen çıktı otomatik current yapılmadı. |
| QC-math / QC-format | Yalnız kurulu küçük iddialar için destek düşünülüyor | Örnek hesaplar denetlenebilir; pedagojik/agent efficacy değil. |
| QC-learner-outcome / gerçek müfredat | Açık | Öğrenci/uzman çalışması ve gerçek müfredat araştırması yok. |
| Method Entry / SC2 | Kayıt ve kullanım seçimi ayrı gösterildi | Baz SOUL'a gerçek rollout yapılmadı. |

Bu son durum bir yıllık programın başarıyla tamamlandığı sahte happy path değildir. Hedef ürünün kabulü ile sınırlı iç ilerleme, kaynak değişimi ve belirsiz etki aynı kurguda birlikte tutulmuştur. Yıllık kapanış için kalan kapsamların üretimi, bütünleştirilmesi, uygun değerlendirmesi ve yetkili teslimi K2/K5/K6 üzerinden sürer; bugün yapılmış sayılmaz.

## 12. Taslakta ortaya çıkan somut kazanım

Aynı yürüyüşte yeni ihtiyaç Work'e, Work aktör/yöntem/context bileşimine, candidate çıktı QC ve karara, kaynak değişikliği güncel kullanıma, kesinti ise etki uzlaştırmasına bağlandı. B0'ın muhakemesi ile K6'nın yaptırımı ayrı taşıyıcılara kondu. Bir start hook'un yeterli olmadığı; sonuç kabulü ve gerçek etki öncesinde güncel dayanağın yeniden bağlanması gerektiği somutlaştırıldı.

Açık sorunlar [G01–G07](MS01-COVERAGE-AND-OPEN-MECHANISMS.md) içindedir. Bu açıklamanın takip edilebilir olması mekanizmaların gerçekten çalıştığının kanıtı değildir. Roman aynı taslakta henüz yürütülmedi; sonraki iş o yürüyüşle taslağı düzeltmektir, yeni bağımsız DQ05 değildir.
