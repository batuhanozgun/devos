# EXP-002 — Açık kalan sorular

**Statü:** Konuşmadan geri çağrılabilir sorular; önceliklendirilmiş araştırma planı, yetkili iş kuyruğu veya mimari gereksinim listesi değil. Özellikle [U017](../sources/conversation/USER-MESSAGES.md#u017) bu değerlendirmeden otomatik araştırma yönü çıkarmamayı istedi.

## O01

**Ortak entelektüel taban nasıl sağlanır?**

Araştırmayı bilen, ihtiyacını fark eden ve yerinde kullanan bir aktör nasıl hazırlanır? Hangi ayrımlar başlangıçta etkin olmalı, hangi ayrıntılar gerektiğinde çağrılmalı? Aktarıldığını ne gösterebilir? Bilginin saklanması, bulunması ve davranışa katkısı nasıl ayırt edilir?

**Kaynak:** U012–U014; [S012](../sources/conversation/assistant/S012.md), [S013](../sources/conversation/assistant/S013.md), [S014](../sources/conversation/assistant/S014.md), [S017](../sources/conversation/assistant/S017.md). Prompt, skill, retrieval, fine-tuning veya başka yol seçilmedi.

## O02

**Rol amaçları ve değerlendirme sınırları**

Kapanış baskısı ile yanlışlama sorumluluğu nasıl ayrılır? Hangi durumda ayrı aktör, ayrı çağrı veya başka düzen gerekir? Aynı entelektüel kültürü taşıyan rollerin ortak yanılgıları nasıl fark edilir? Bir verifier ne zaman yeterli kanıtla durur?

**Kaynak:** U002–U004; [S002](../sources/conversation/assistant/S002.md), [S003](../sources/conversation/assistant/S003.md), [S004](../sources/conversation/assistant/S004.md), [arşiv nitelendirmeleri](QUALIFICATIONS.md). Konuşma bu ayrımların etkinliğini test etmedi; repairer veya integrator için ayrı fiziksel ajan zorunluluğu yok.

## O03

**Talep öncesi baz yapı**

Hangi sorumluluklar başlangıçta hazırdır? Hangileri sonradan oluşur? SOUL'un kendi harness'ı ve kullanıcı işi için yapılandırdığı sistemin sınırı nerededir? Sabit iç roller nelerdir?

**Kaynak:** U008, U011; [S008](../sources/conversation/assistant/S008.md), [S011](../sources/conversation/assistant/S011.md). S011 sonunda bu dal önerildi ama bağımsız ve tamamlanmış rol listesi üretilmedi.

## O04

**Oluşturma, kurulum ve değişiklik sorumluluğu**

Gerekli çalışma düzenini düşünmek, onu eleştirmek ve fiilen oluşturmak aynı rolün işi mi? System Formation tek mekanizma mı, dağıtılmış sorumluluk mu? Yeni ihtiyacı işteki aktör mü, üst gözlem mi, ikisi mi fark eder? İhtiyacın dile gelmesi hangi kabul/yetkiyle gerçek değişikliğe dönüşür?

**Kaynak:** [S007](../sources/conversation/assistant/S007.md), U008/S008, [S017](../sources/conversation/assistant/S017.md). Tekil merkezi controller veya sürekli aktif süreç seçilmedi.

## O05

**Ortak plan ve çalışma ilişkileri**

Work, aktör ve rol/iş ilişkilerinden hangisi nasıl temsil edilir? Başlangıçta genel kalan plan nasıl derinleşir? Yeni sistem gereksinimi hangi üst amaca bağlanır? İşin bir dalını sürdürürken başka dala ilişkin bulgu nasıl korunur?

**Kaynak:** S007'nin kapanış sorusu; EXP-001 [S017](../../EXP-001-soul-calisma-modeli/sources/conversation/assistant/S017.md). EXP-002 yaşayan planı veri şemasına veya seçilmiş graph modeline dönüştürmedi.

## O06

**Bilgi ihtiyacının teşhisi ve mekanizma seçimi**

“Bilgi büyüdü” gözlemi gerçekten bellek/retrieval değişikliği gerektiriyor mu? Darboğaz context, temsil, erişim, güncellik, yetki veya kullanım davranışında mı? Hangi seçenek hangi koşulda yeterli? İşte kurulan çözümün etkisi nasıl okunur?

**Kaynak:** U008, U012; [S008](../sources/conversation/assistant/S008.md), [S012](../sources/conversation/assistant/S012.md), [S016](../sources/conversation/assistant/S016.md). RAG adı örnek kaldı; benchmark veya ürün seçimi yok.

## O07

**Genel standart, uzmanlık ve ölçek**

Bütün akıl yürüten rollerde arzulanan genel standardın işteki karşılığı ne? Uzmanlık profili ve gerekli model kapasitesi nasıl belirlenir? Mesleki standart korunurken katılım, maliyet ve zaman nasıl dengelenir?

**Kaynak:** U013–U014; S013–S014; S017; EXP-001 S011. Temsili futbolcu puanları ölçüm veya eşik değildir. Küçük çekirdek varsayımı seçilmiş optimum sayılmaz.

## O08

**Development OS'ta öğrenme ve SOUL'a geçiş**

Hangi sorular gerçek geliştirme ortamında yanıtlanabilir? Development OS'un kendini geliştirmesi hangi yetki ve doğrulama altında olur? Burada kazanılan deneyim hangi SOUL kullanım koşullarına taşınabilir?

**Kaynak:** [U018–U019](../sources/conversation/USER-MESSAGES.md#u018), [S018](../sources/conversation/assistant/S018.md). Uygulamaya geçiş, actual repository state'i ve ayrı kullanıcı yönü gerektiren sonraki aşamadır.

## O09

**Başta sayılan fakat ayrıntılandırılmayan terimler**

U001'de loop engineering, graph engineering ve çok sayıda başka terim sayıldı. Konuşma bunların tümünü bağımsız başlıklarla tanımlayıp SOUL'a eşlemedi. Goal maintenance, work state, tool selection, policies ve recovery bazı yerlerde anıldı ama eksiksiz mekanizma sözleşmeleri kurulmadı. Üçüncü maddeyi tam bir teknik sözlük veya tamamlanmış mimari kapsam incelemesi sayma.

**Kaynak:** [U001](../sources/conversation/USER-MESSAGES.md#u001), [terim notları](TERMS.md). Bunları şimdi tamamlamak bu arşivleme işinin parçası değildir.
