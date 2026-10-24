# EXP-002 — Yeniden kullanılabilir düşünce kayıtları

Bu kayıtlar özgün konuşmanın yerine geçmez. “Kazanım”, konuşmada belirginleşen ayrımı anlatır; yöntem başarısı, bağımsız deney veya benimsenmiş mimari anlamına gelmez. Arşivleme sırasında eklenen eleştirel sınırlar [QUALIFICATIONS](QUALIFICATIONS.md) içindedir.

## L01

**Talep, konuşmanın amacı ve örnek birbirinden ayrılmalı.** U001'in hedefi SOUL'u bir turda tasarlamak değil; önceki denemeyi kullanarak tanımı ve anlayışı açmaktı. U008'deki ABC/dört ajan/RAG örneği, böyle bir sistemi kullanıcı açısından tasavvur etmeye yaradı.

**Yeniden kullanım:** Yeni EXP, ürün adı veya örnek sayısına kilitlenmeden tartışmanın asıl sorusunu devralabilir. **Sınır:** Dört ajan veya RAG, seçilmiş mekanizma değildir.

**Kaynak:** [U001](../sources/conversation/USER-MESSAGES.md#u001), [U008](../sources/conversation/USER-MESSAGES.md#u008), [S007](../sources/conversation/assistant/S007.md), [S008](../sources/conversation/assistant/S008.md).

## L02

**Tek motivasyon, tek fonksiyon demek değildi.** İlk governing mandate yorumu, kullanıcının kapanış baskısı ile doğruluğu sorgulama yönü arasındaki ayrımını tam karşılamadı. Builder/test örneği bu eksiği düzeltti. Bir rol birçok işlev kullanabilir; mesele hangi başarı yönüyle kullandığıdır.

**Yeniden kullanım:** Rol tasarlarken yalnız görev listesini değil, hangi sonucun rolü başarılı saydırdığını da tartışma girdisi yapar. **Sınır:** Her rolün mutlaka tek matematiksel hedef fonksiyonuyla modellenmesi veya her rol ayrımının drift'i önlemesi kanıtlanmadı.

**Kaynak:** [U002–U003](../sources/conversation/USER-MESSAGES.md#u002), [S002](../sources/conversation/assistant/S002.md), [S003](../sources/conversation/assistant/S003.md).

## L03

**Ayrım temel modelin kimliğinden çok işte üstlenilen rolde kuruldu.** Aynı temel modelin builder veya verifier olarak farklı çağrılarda kullanılabileceği; o andaki rol, amaç ve yetki sınırının açık olması düşünüldü.

**Yeniden kullanım:** Model, aktör ve rol-instance'ı birbiri yerine kullanmayı önler. **Sınır:** Farklı isim veya taze çağrı epistemik bağımsızlık kanıtı değildir. Identity'nin bütün kapsamı karara bağlanmadı.

**Kaynak:** [U004](../sources/conversation/USER-MESSAGES.md#u004), [S003](../sources/conversation/assistant/S003.md), [S004](../sources/conversation/assistant/S004.md).

## L04

**SOUL'un akıl yürütmesi çalışma düzeninin kurulmasına da uzanabilir.** S006'daki tanım yalnız problemi çözmeyi değil, gereken çalışma sistemini oluşturma/işletme/değerlendirme/uyarlamayı kapsadı. System Formation geçici adı bu kapasiteyi işaret etti.

**Yeniden kullanım:** Çözüm çıktısı ile onu mümkün kılan organizasyonun keşfini ayrı incelemeye yarar. **Sınır:** Tek merkez ajan, belirli servis veya modüler mimari seçilmedi. Kullanıcı amacı, sistem kurma faaliyetinin kendisiyle ikame edilemez.

**Kaynak:** [S006](../sources/conversation/assistant/S006.md), [U007](../sources/conversation/USER-MESSAGES.md#u007), [S007](../sources/conversation/assistant/S007.md).

## L05

**Kurulan ilk sistem, problemin daha iyi anlaşılmasına katılır.** İlk ekip yalnız execution kuyruğu değildir. Araştırır, ihtiyaç bulur, değişiklik gereksinimini görünür kılar. Bu bilgiyle yapı yeniden düzenlenebilir.

**Yeniden kullanım:** EXP-001'in C ↔ plan ↔ Work düşüncesini çalışma sisteminin oluşumuna taşır. **Sınır:** Her yeni ihtiyaç yeni ajan, bütün ihtiyaçların keşfi de tüm işlerin önkoşulu değildir. İhtiyacı keşfetmekle değişikliğe yetkili olmak ayrıdır.

**Kaynak:** [U008](../sources/conversation/USER-MESSAGES.md#u008), [S008](../sources/conversation/assistant/S008.md), [EXP-001 devri](../sources/PREDECESSOR-EXP001.md).

## L06

**Baz SOUL ile amaca göre oluşturulan sistem ayrılabilir.** SOUL'un kendi runtime, kayıt, yetki ve kurma kabiliyetleri olabilir. Kullanıcı işi için yapılandırılan düzen farklılaşabilir. “SOUL yalnız harness değildir” ifadesi, “SOUL'un harness'ı yoktur” demek değildir.

**Yeniden kullanım:** Başlangıçta gerekli olanla talep sırasında oluşturulanı tartışmayı sağlar. **Sınır:** Sabit rollerin sayısı, iki ayrı fiziksel katman veya küçük çekirdeğin üstünlüğü belirlenmedi.

**Kaynak:** [U008](../sources/conversation/USER-MESSAGES.md#u008), [U011](../sources/conversation/USER-MESSAGES.md#u011), [S008](../sources/conversation/assistant/S008.md), [S011](../sources/conversation/assistant/S011.md).

## L07

**Bilginin bulunması ile onu kullanmaya yönelmek ayrı gereksinimlerdir.** Batu yalnız erişim izni değil, araştırmanın varlığının farkında olma, ilgili sorunu tanıma, alternatifleri bilme ve gerektiğinde kaynağa dönme anlayışını istedi.

**Yeniden kullanım:** “Kütüphaneyi aktöre açtık” ile “aktör birikimi işinde kullanabiliyor” arasındaki boşluğu görünür kılar. **Sınır:** Bu davranışı sağlayacak retrieval, eğitim veya bağlam mekanizması seçilmedi; fiilî aktarım ölçülmedi.

**Kaynak:** [U012](../sources/conversation/USER-MESSAGES.md#u012), [S012](../sources/conversation/assistant/S012.md), [S016](../sources/conversation/assistant/S016.md).

## L08

**Ortak entelektüel taban ile role özgü yeterlilik ayrı eksenlerdir.** Futbolcu kartı benzetmesi, bütün akıl yürüten aktörlerde güçlü genel problem/sistem görüşü ve araştırma disiplini arzusunu belirginleştirdi. Her rol aynı uzmanlıkta yüksek olmak zorunda değil.

**Yeniden kullanım:** “Dar amaçlı ama dar görüşlü değil” ifadesi; uzmanlığa indirgenmemiş aktör hazırlığı. **Sınır:** Puanlar temsiliydi. Genel/özel beceri bağımsızlığı veya her aktörde bu seviyeye ulaşılacağı gösterilmedi. Deterministik araçlara entelektüellik yüklenmez.

**Kaynak:** [U013–U014](../sources/conversation/USER-MESSAGES.md#u013), [S013](../sources/conversation/assistant/S013.md), [S014](../sources/conversation/assistant/S014.md).

## L09

**SOUL birikiminin aktöre geçmesi, her dosyanın her çağrıya konması olarak tanımlanmadı.** Ortak temel ayrımlar ile gerektiğinde geri çağrılan ayrıntılı kaynaklar ayrıldı. Model kapasitesi, çalışma kültürü, deneyim, rol ve yerel iş bağlamı birbirine indirgenmedi.

**Yeniden kullanım:** Bilgi mirası ve güncel işe hazırlık problemini ayrı katmanlar olarak düşünmeye yarar. **Sınır:** “Internalized” ağırlıklara öğrenme anlamında doğrulanmış teknik terim değil; hangi mekanizmayla sağlanacağı açık.

**Kaynak:** [S012](../sources/conversation/assistant/S012.md), [S017](../sources/conversation/assistant/S017.md), EXP-001 [S011](../../EXP-001-soul-calisma-modeli/sources/conversation/assistant/S011.md).

## L10

**Foundation, studies ve explorations farklı türden katkılar sağlar.** Konuşmadaki özetle Foundation ayrım/problem zemini; studies aday mekanizma/örnek/karşıörnek; explorations bunlardan beslenen bütünsel düşünce provasıdır.

**Yeniden kullanım:** Tasarım hayalini araştırma bulgusu sanmayı veya hazır ürünü evrensel SOUL mimarisi yapmayı önler. **Sınır:** S015–S017 nicel readiness ölçümü veya repository'nin tam bağımsız audit'i değildi; kütüphane sınırı bütün çözüm uzayı değildir.

**Kaynak:** [S015](../sources/conversation/assistant/S015.md), [S016](../sources/conversation/assistant/S016.md), [S017](../sources/conversation/assistant/S017.md), [referanslar](../sources/RESEARCH-REFERENCES.md).

## L11

**Açık soru, otomatik araştırma görevi değildir.** U017 bu değerlendirmeden araştırmaya yön verecek bir kural çıkarılmamasını açıkça söyledi. İçselleştirme, sabit roller ve SOUL sınırı gibi sorular gelecekte kullanılabilir düşünce malzemesi olarak kaldı.

**Yeniden kullanım:** Yeni oturum, buradaki boşlukları active Work sanmaz. **Sınır:** Bu açık soruların hiçbirini henüz cevaplanmış veya yürütülmek üzere yetkilendirilmiş sayma.

**Kaynak:** [U017](../sources/conversation/USER-MESSAGES.md#u017), [S017](../sources/conversation/assistant/S017.md), [OPEN-QUESTIONS](OPEN-QUESTIONS.md).

## L12

**Development OS, SOUL'a giden daha dar amaçlı gerçek çalışma sistemi olarak konumlandı.** SOUL'u yalnız sohbetle tamamlamak yerine, kalıcı aktör/bilgi/iş/ortam düzeniyle araştırmak, geliştirmek ve doğrulamak düşüncesi belirginleşti. Development OS bazı fikirlerin yaşanacağı ve sınanacağı yer olabilir.

**Yeniden kullanım:** Research + explorations ile actual development arasındaki hazırlık ve devir ilişkisi. **Sınır:** Tek üst amaç kolay kurulum veya güvenilirlik kanıtı değildir; Development OS'taki sonuçlar bütün SOUL işlerine otomatik genellenmez. Bu arşiv existing Codex yetkisini sıfırlamaz, yeni implementasyon başlatmaz.

**Kaynak:** [U018–U019](../sources/conversation/USER-MESSAGES.md#u018), [S018](../sources/conversation/assistant/S018.md).

## L13

**Denemelerin değeri yalnız son tanımda değil, değişim izindedir.** EXP-002'nin önceki denemeye eklenmek yerine kendi kimliğiyle korunması ve ileride birlikte tam okunması istendi. Yanlış yorumlar, düzeltmeler ve henüz açık kalan kavramlar bu nedenle kaynakla birlikte saklanır.

**Yeniden kullanım:** Yeni EXP, neyi devraldığını ve neyi değiştirdiğini gösterebilir; aynı düşünceyi yeniden keşfetme veya tekrarını kanıt sayma riski azalır. **Sınır:** Bu kayıtlar assistant kontrol talimatı veya kabul edilmiş mimari otoritesi değildir.

**Kaynak:** [U005](../sources/conversation/USER-MESSAGES.md#u005), [S005](../sources/conversation/assistant/S005.md), [U019](../sources/conversation/USER-MESSAGES.md#u019), [toplu okuma yolu](../retrieval/CUMULATIVE-READING.md).
