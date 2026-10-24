# DevOS — Sistematik ihtiyaç keşfinin geliştirilmesi ve gerçek kullanımda doğrulanması

Görev kimliği: `DEVOS02-NEED-DISCOVERY-20260922`
Sürüm: 1.0 — 22 Eylül 2026
Hedef repository: `batuhanozgun/soul-development-os_02`
Araştırma kaynağı: `batuhanozgun/agentic-os-search` — salt okunur.

## 0. Belgenin statüsü

Bu dosya Chat ortamında hazırlanmış bir devir sözleşmesi önerisidir. Dosyanın hazırlanması, indirilmesi veya bir kaynak klasöründe bulunması görevi başlatmaz ve kendi başına yetki oluşturmaz. Kullanıcı bu exact dosyayı Codex'e ekleyerek görev ve aşağıdaki sınırları benimsediğini açıkça bildirdiğinde yeni görev yetkisi oluşur. Platform, güvenlik ve kullanıcı durdurma kuralları üstündür.

Hazırlayan oturum hedef repoya veya Research reposuna yazmadı; Codex çalıştırmadı; yerel süreçleri ve davranış deneylerini gözlemlemedi. Bu belgedeki repository gözlemleri, belirtilen kaynak metinlerin okunmasına dayanır; eski deneylerin bağımsız yeniden doğrulanması değildir. Başlarken gerçek güncel durumu yeniden kazan.

## 1. Amaç: kullanıcının yerine teknik eksikleri keşfedebilmek

SOUL hedefi, kullanıcının istediği sonuca uygun çalışma sistemini oluşturmak, işletmek, gerçek sonucunu değerlendirmek ve gerekince genişletmek veya değiştirmektir. Development OS ise SOUL'u araştırmak, tasarlamak, geliştirmek ve doğrulamak için kullanılan çalışma düzenidir.

Bu görevin hedefi bütün SOUL'u yapmak veya bütün Development OS'u tamamlamak değildir. Mevcut DevOS'un, kullanıcının teknik ihtiyaçları ve araştırma kaynaklarını tek tek söylemesine dayanmadan şu işi yapmasını sağlamak ve gerçek kullanımda sınamaktır:

**Hedef → gerekli koşullar ve araştırılacak belirsizlikler → uygun bilgi/kaynak/yöntem keşfi → gerekçeli seçim → yararlı işi gerçekleştirme → sonucu ve yeni ihtiyacı değerlendirme → hedefe geri dönme.**

Kullanıcı olağan teknik araştırma yönünü seçen, eksik gereksinimleri hatırlatan, yöntem tasarlayan, test yazan veya üretilen çözümü teknik olarak onaylayan kişi olmayacak. Araştırma, planlama, kapsam içi teknik karar, uygulama, deney, eleştiri, onarım ve entegrasyon sorumluluğu bu görevi yürüten sistemdedir. Gerçek ürün tercihi, para harcama ve verilmemiş dış etki yetkisini keşfetmek, bunları kullanıcı adına uydurma hakkı vermez.

Bir ihtiyacı bulmak yeterli değildir: onu hedefe bağlı araştırmaya ve işe dönüştürmeli; edinilen bilgi gerçekten kararı veya uygulamayı beslemeli; açık inceleme kesintiden sonra sürdürülebilmelidir. Gereksiz ihtiyaç, araç ve araştırma üretmemek de başarı kapsamındadır.

## 2. Sohbetten devralınan görüşlerin sınırı

Önceki sohbet, erken çözüm seçimi, mevcut çerçeve içinde kalma, araştırmanın gerektiği anda kullanılmaması ve aynı çerçeveye dayanan öz değerlendirme gibi olası açıklamalar üretti. Bunlar kanıtlanmış tek kök neden değildir. Kaynak erişimi, bağlamın fiilen sunulması, yöntem seçimi, çalışma yetkisi, görev aktarımı veya doğrulamanın yetersizliği gibi alternatifleri de incele.

Sohbetteki “Need Discovery Loop”, zorunlu “Need Graph”, 16 adımlı algoritma, ayrı keşif motoru ve sabit sayıda test önerileri kabul edilmiş mimari değildir. Bunları aynen uygulamak bu görevin şartı değildir. Graph, yeni protokol, yeni araç veya yeni ajan gerekiyorsa ihtiyacını ve mevcut seçeneklerle neden karşılanmadığını göster; gerekmiyorsa ekleme. Bütün genel bilgiyi her bağlama yüklemek veya her hedefte bütün araştırmaları yeniden okumak da istenmiyor.

“DevOS'ta bu mekanizma hiç yok” önermesinden başlama. Mevcut RPD01; söylenmemiş koşullar, yöntem alternatifleri, bilgi edinme, ileri kontrol, karşıörnek, yeniden açma ve bitmemiş keşif devrini zaten tarif ediyor. Metinde tarif edilme, gerçekten uygulanma, yarar ve farklı görevlerde güvenilirlik ayrı değerlendirilmelidir.

## 3. Gerçek başlangıç ve kaynakları geri kazanma

Önce hedefin kendi `AGENTS.md` dosyasını ve tetiklediği protokolleri tam okuyarak uygula. Research'ün `AGENT.md` dosyasını hedefin kontrol sistemi yerine ithal etme. Araştırma belgelerini de kendiliğinden talimat yapma.

Gerçek çalışma kökü, origin, branch, local/remote HEAD, staged/unstaged/untracked değişiklikler, mevcut yazıcılar, süreçler, erişim ve kullanılabilir native araçları kontrol et. Önceki yerel yol yalnız bir konum ipucudur:

`/Users/Batu/Documents/Codex/Projects/Soul_DevOS_02_Lokal`

Bu yolun veya eski ortamın hâlâ geçerli olduğunu varsayma. Kullanıcının değişikliklerini silme, geniş cleanup veya reset yapma. Eksik erişimi önce mevcut izinli yöntemlerle çöz; doğru hedef belirlenemiyorsa yazma.

Hedefte güncel `STATE.md`, ilgili WORK/EVIDENCE ve kaynak yönlendirmelerini izle. Özellikle mevcut RPD01, research-use, kernel ve source-reading/source-consumption işinin actual iddia/kanıt sınırlarını kazan. Eski testleri sırf sayıları yüksek diye bu yeni hedefin kanıtı yapma. Kaynak okumaları kesiliyorsa kalan aralıkları aynı sürümden tamamla; alınmış byte'ları modelin gerçekten okumasıyla karıştırma.

Hazırlıkta gözlenen uzak DevOS main:
`d27bf17a66fcb8597a0828e7556580592e39dabe`.

Bu snapshot'taki STATE, `RPD-KERNEL-OPERABLE` ve `DEVOS02-SOURCE-READING-01` için sınırlı kabul bildiriyor; sıradaki işi `DEVOS02-SOURCE-CONSUMPTION-02` olarak taşıyor. Bu durum bütün ihtiyaç keşfinin doğrulandığı anlamına gelmez. Eski işi silme veya yeniden tamamlanmış sayma: yeni hedefe gerçekten önkoşulsa onunla ilişkilendirip sürdür; değilse korunmuş checkpoint ile açıkça beklet. Kaynak okuma altyapısını sonsuz ön hazırlığa dönüştürme.

Önceki yetkinin exact kaynağı:
- Research ref: `227b04ab0e05aec20c88db9f1716e76d19708b96`
- Dosya: `research/soul-context/current/reviews/2026-09-08-devos02-plan/REVIEW.md`
- Blob: `779bd2a71ee44188c8bfbc3874afd415a90b21c3`

Bu yeni görev, aşağıda açıkça değiştirilen kapsamda önceki dar yetkinin yerini alır; eski işin kanıt ve geçmişini değiştirmez. Diğer korumalar geçerlidir.

Research için hazırlıkta gözlenen main:
`08b91f01f4bd3cdeee0f72eca61e96c5e1676482`.

Bu ref, bütün repository'nin hazırlayan oturum tarafından tam okunduğu anlamına gelmez. Güncel girişleri yeniden okuyup kullandığın exact sürümleri kaydet. Başlangıç rotaları:

- `README.md` → `research/INDEX.md`.
- `research/soul-foundations/STATE.md` → yönlendirdiği handoff/reuse kaynakları.
- `research/studies/CATALOG.md` → problemle ilişkili paket META/STATE/INDEX ve gerekli asıl bulgular.
- `explorations/INDEX.md` → EXP-004'ün STATE/INDEX'i, MS01 ana taslağı, araştırma–mekanizma eşlemesi ve açık mekanizmalar.

RPD, iş yönetimi, Context/Memory/Harness, Superpowers, gstack ve ilgili diğer araştırmalar başlangıç adaylarıdır; kapalı liste değildir. Gerekli karar yükünü taşıyan kaynaklara gerçekten in. Kataloğu okumak tek başına araştırmayı kararda kullanmak değildir; bir terimin bulunmaması da yokluk kanıtı değildir. Güncel teknik iddialar için yetkili dış kaynakları doğrula. Concepts veya kapalı explorations programını yeniden başlatma.

## 4. Çalışma: önce mevcut davranış, sonra gerekçeli değişiklik

İlk teslimat olarak bir plan verip kullanıcı cevabı bekleme. Plan, kaynak okuma ve başlangıç tespiti işin iç adımlarıdır. Aşağıdaki ayrımları koruyarak araştırma–tasarım–uygulama–deney–onarım–entegrasyon döngüsünü yönet:

**Başlangıç davranışı.** Mevcut olağan DevOS girişini gerçek native görevlerde gözle. Söylenmemiş teknik koşulu bulabildiği, bulamadığı ve görevin gereksiz araştırma istemediği durumları ayır. Yalnız başarısız örnek seçme; gerçekten yeterli mevcut yolu da koru. Eksik bilgi erişilebilir kaynak/ortamdan keşfedilebilir olmalı; kullanıcı tercihi veya erişilemez gizli gerçek tahmin ettirilmemeli.

**İşlevsel açıklık.** Sonuçları metinde olmayan, tanımlanmış ama uygulanmayan, uygulanmış ama yararı gösterilmemiş, ortamdan engellenmiş ve mevcut yöntemle yeterli şeklinde değerlendir. Salt satır sayısı veya checklist doluluğundan yetenek hükmü çıkarma. En güçlü alternatif nedenin farklı bir düzeltme gerektirip gerektirmediğini sına.

**Yöntem seçimi ve uygulama.** Genel model bilgisi, kaynak okuma, mevcut kontrol, iş bölümü, bağlam kurma, dış araştırma ve varsa küçük araç desteği arasından gereken birleşimi seç. Her önemli değişiklik için hangi gözlenen açığı kapattığını, daha basit alternatifi ve regresyon riskini belirt. Ayrı bir motoru veya yalnız Markdown çözümünü peşinen seçme. Mevcut normal giriş ve iş/kanıt/süreklilik sistemi içinde gerçekten kullanılır hale getir.

**Hedefe dönüş.** Keşif araştırmayı; araştırma karar veya uygulamayı; alt sonuç üst hedefi beslemeli. Bulgu listesi üretip ana işi açık bırakma. Yeni kaynak bazen mevcut çerçeveyi değiştirmeli veya gereksiz bir parça kurmama sonucuna götürmelidir; her okumadan zorla yeni bulgu çıkarma.

## 5. Doğrulama ve kullanıcıya bağımlılığı azaltma

Uygulamanın final sonuçları görülmeden önce sınama kapsamını, kabul kurallarını ve başarısızlık tanımlarını kaydet. Ölçütlerin amaç için yeterli olup olmadığını üretici tasarımına bağlı olmayan bir başlangıçtan eleştir. Teknik kabul ve onarımı kullanıcıya yaptırma.

Değerlendirme en az şu farklı yükleri karşılamalı; bunlar zorunlu modül veya her işe uygulanacak uzun form listesi değildir:

- İpucu verilmeyen fakat kaynaklardan bulunabilen kritik ihtiyacı keşfetme; başlangıçtaki yanlış yöntem/çerçeveye itiraz edebilme.
- Mevcut araştırmada farklı isimle duran bir mekanizmayı işlev ve hata üzerinden bulma; gerektiğinde kütüphane dışındaki ilgili bilgi alanına kendiliğinden araştırma açma.
- Gereksiz ihtiyaç, uydurma bağımlılık veya pahalı altyapı eklememe; basit yeterli işte ilerleyebilme.
- Yeni kanıtla yöntemi/üst ihtiyacı yeniden açma ve etkilenmeyen doğru işi koruma.
- Normal girişte ve üretici sohbetini almayan yeni native bağlamda davranışın çalışması; açık keşfin anlamlı sonraki işle sürmesi.
- Keşfedilen ihtiyacın en az bir gerçek DevOS işinde yararlı çıktı, doğrulama ve üst işe dönüş üretmesi. Oyuncak graph, sayfalama CLI'si veya rapor bu bütünün yerine geçirilmez.

Birbirinden gerçekten farklı görev ve çözüm koşullarını kullan; aynı kaynak okuma örneğinin isimleri değiştirilmiş varyantlarını alanlar arası yeterlik sayma. Güvenli yazılım-dışı görev örnekleri değerlendirmeye katılabilir; bunlar gerçek kullanıcı ürünlerini üretme yetkisi değildir. Görev çeşitliliğinin hangi kör noktaları sınadığını gerekçelendir.

Mevcut güçlü başlangıç yöntemi ile aday değişikliği karşılaştır. Aynı model/araç erişimi, görev bilgisi ve karşılaştırılabilir toplam emek/bütçe altında çalış; önemli farkları kaydet. Sadece “daha çok ajan ve daha uzun süre” verilerek alınan farkı mekanizma başarısı diye sunma. Kritik atlamalar, yanlış ihtiyaçlar, araştırmanın karara katkısı, yararlı tamamlanma, kaynak maliyeti ve devir başarısını birlikte değerlendir. Değişiklik gerekmiyorsa bunu da kabul et; sırf yeni kod çıkarabilmek için mevcut yöntemi zayıf gösterme.

Geliştirme örnekleri ile son değerlendirme örneklerini ayır. Mümkün gerçek ayrı bağlam/rol üzerinden üreticiye gösterilmemiş varyantlar oluştur; aynı konuşmada görünmüş cevabı “gizli test” diye sunma. Başarıyı yalnız beklenen sözcüklerin geçmesine bağlama: başka doğru çözümü kabul edebilen işlevsel oracle kullan. Yanlış/eksik sonuca kırmızı verebildiğini de sınama nesnesi yap. Aynı model ailesinin ortak körlüğünü ve sınırlı örneklemin sınırını açık tut.

Kasıtlı kaynak eksiltme, sürüm değiştirme veya erişim engeli gibi olumsuz deneyleri görev için ayrılmış güvenli örnekler üzerinde yap. Araştırma kaynaklarını, gerçek kullanıcı verisini veya mevcut işi bozma. Değişen oracle/ölçüt yeni kanıtla yeniden sınanır; ilk başarısız koşu kayıttan çıkarılmaz. Yeni bulgu sayısının azalması tek başına yeterlilik değildir.

Native test/ayrı bağlam çalıştırılamıyorsa konuşma içi rol oyununu yerine koyma. İlgili iddiayı doğrulanmamış bırak; mevcut izinli alternatiflerle ilerle ve gerçek engeli ayır.

## 6. Kullanıcının benimsemesiyle geçerli olacak uygulama sınırı

Bu görev için yalnız hedef DevOS repository'sinde gerekli araştırma, tasarım, uygulama, test, iç inceleme, onarım ve teknik entegrasyon yetkilidir. Yeni bir genel SOUL ürün geliştirme yetkisi değildir.

**Kayıt ve kod:** Mevcut `STATE.md` ve etkilenen iş kayıtları; bu görev için `work/<görev-kimliği>/` altında kapsamlı fakat gereksiz çoğaltılmamış WORK/EVIDENCE, deney ve kaynak izleri; gerekçeli `tools/` ve `tests/` değişiklikleri. Mevcut kod yerleşimi yeterli değilse hedef repo içinde bu yeteneğe özgü dar kod paketi oluşturulabilir. Her yazımdan önce exact yollar ve sahipleri iş kaydında belirlenir. Kapsam dışı kod ve geçmiş deney kanıtı korunur.

**Dar davranış entegrasyonu:** Bu kullanıcı görevi, ihtiyaç keşfi ve araştırmayı kullanma davranışını iyileştirmek için gerekli ve gerekçelendirilmiş hedef `AGENTS.md` yönlendirme değişikliklerini, `devos-agent/protocols/reasoning/` altındaki ilgili metinleri ve `devos-agent/protocols/work-tracking/research-use.md` içindeki ilgili değişiklikleri açıkça kapsar. Genel kontrol sistemini yeniden yazma, yetki/genel güvenlik sınırını kaldırma veya başarısız testi geçirecek biçimde kabul standardını gevşetme yetkisi vermez. Yeni kontrol şart değil; mevcut mekanizma yeterliyse koru. Değişiklik öncesi ayrı içerik incelemesi, sonrasında canonical tam okuma ve actual giriş/regresyon kontrolü gerekir.

**Git:** Mevcut private hedef repo içinde göreve özgü branch ve gerekirse worktree oluşturulabilir; normal commit/push ve yeterli inceleme/deneyden sonra normal main entegrasyonu ve uzak exact readback kapsam içindedir. Eski genel branch yasağı yalnız bu görev için bu kapsamla değiştirilir. Main'e doğrulanmamış çalışma davranışı kurma. Başka yazıcının değişikliklerini ezme; force push, geçmiş silme, geniş reset/cleanup, başka repo yazımı, release/tag ve kamuya açma yetkisi yoktur. Platformun zorunlu onayları korunur. Kullanıcıdan rutin teknik merge onayı bekleme; gerçek yetki/çakışma engelini ayrı bildir.

**Ortam ve harcama:** Mevcut yetkili native araçlar, yerel test ortamı ve mevcut kullanım kotasıyla çalış. Yeni ücretli servis/API harcaması, hesap/credential, global veya `.codex` izin genişletme, güvenlik atlama, production etkisi, özel kaynakları izinsiz üçüncü tarafa yükleme, sürekli servis/scheduler veya kendiliğinden yeniden başlayan sınırsız döngü yoktur. Dış arama sorgularına private repo içeriğini veya sırları taşıma. Mevcut izinli zemin yetmiyorsa önce gerçek alternatifleri değerlendir; yoksa gerekli erişim/karar engelini açıkça belirt.

**Research sınırı:** `agentic-os-search` bütünü salt okunurdur. Yeni öğrenme ve uygulama kanıtını bu DevOS işinin kendi kayıtlarında kaynaklı tut. Research agent-control, Foundation, studies, concepts ve explorations durumlarını değiştirme; eski kabul iddialarını yeniden yazma.

## 7. Kullanıcıdan teknik cevap beklemeden sürdürme

Bu görevde olağan aşamalar arasında “plan uygun mu?”, “devam edeyim mi?”, “hangi teknik yöntemi seçelim?” diye durma. Gerekli yöntemi kaynak ve kanıtla seç; ilerleme mesajını onay kapısı yapma. Yerel alt işin bitmesini kök görevin bitmesi sayma. Planlama, kaynak envanteri veya test sayısı raporu tek başına teslim değildir.

Önceki görevdeki iki alt iş/60 dakika sınırı, bu yeni görevde kullanıcıya dönerek yeniden teknik onay isteme zorunluluğu değildir; bunun yerine ara checkpoint üret. Mevcut eşzamanlı aktör tavanı, tek-yazıcı, bounded child çalışma ve aynı kusura yönelik sınırlı yeniden deneme korumalarını tut. Platform/kota sınırları değişmez; limitsiz kaynak kullanımı yetkisi yoktur. Sonuç vermeyen aynı yaklaşımı isim değiştirerek sonsuz kez tekrarlama: neden ve alternatif yöntemi değerlendir.

Her anlamlı sonuçta hedef, kapsam, exact kaynak/yöntem sürümü, yapılan işlem, başarısızlık, açık soru, sıradaki somut işlem ve üst işe dönüş repository'de bulunabilir olmalı. Devir, gizli düşünce zinciri değil gözlenebilir problem ve kanıt durumudur.

Gerçek platform/erişim/kota veya devredilmemiş kullanıcı kararı engelinde bunu çözülmüş sayma. Güvenli bağımsız işler varsa sürdür; yoksa engeli ve kaldığın yeri kaydet. Bu durum görev başarısı değildir. Platform yeni çağrı gerektiriyorsa bunu gizleme; dosyaların kendiliğinden iş başlatacağını varsayma. Kullanıcı iptali her zaman geçerlidir.

## 8. Tamamlanma: belgelenmiş niyet değil normal girişte gösterilmiş davranış

Teknik tamamlanma şu sonuçların birlikte bulunmasını gerektirir:

1. Mevcut DevOS davranışının kaynak ve actual deney temelli başlangıç değerlendirmesi; mevcut yeterli mekanizmalar ile gerçek açıklıkların ayrılması.
2. Gerekçeli değişikliklerin normal DevOS çalışma yoluna entegre edilmesi veya değişiklik gerekmiyorsa mevcut yolun bu hedefi karşıladığının uygun kanıtı.
3. Önceden belirlenen kapsamda üreticiden ayrıştırılmış değerlendirme, görülmemiş varyantlar, olumsuz kontroller, eski yararlı davranışların regresyon kontrolü ve gerçek native kullanım.
4. Kullanıcının teknik ipucu vermediği anlamlı bir DevOS işinde keşif → araştırma → karar/uygulama → doğrulama → üst hedefe dönüşün gözlenmesi; kesintili/yeni bağlam devamının ayrıca gösterilmesi.
5. Exact sürüme bağlı değişiklik ve deney kayıtları, main entegrasyonu/uzak geri okuma, açık sınırlamalar ve yeni oturum için tek anlamlı devam yolu.

Başarısız bir yükü kriterden çıkarıp işi tamamlanmış ilan etme. Sınırlı deneyden “bütün bilinmeyen ihtiyaçları bulur”, “artık hata yapmaz”, “SOUL tamamlandı” veya yöntem üstünlüğü çıkarma. Kanıt yeterli değilse iş kısmi/engelli kalır; yalnız başarı dili değişerek kapanmaz.

Nihai kullanıcı bildirimi; önce ne atlandığını, şimdi hangi gerçek görevlerde neyin değiştiğini, uygulanan exact sürümü, sonuç/başarısızlık kanıtlarını ve devam eden sınırları açıkça gösterir. Teknik değerlendirmeyi tekrar kullanıcıya yaptırmaz. Görev başarıyla tamamlandığında ayrıca yetkilendirilmemiş SOUL ürün inşasına veya sınırsız başka DevOS işine geçmez.

## 9. Hazırlık kaynaklarının gözlem sınırı

22 Eylül 2026'da GitHub üzerinden gözlenenler:

- DevOS main ref: `d27bf17a66fcb8597a0828e7556580592e39dabe`.
- DevOS `STATE.md` blob: `31a1ce4ddf76803e1cc1657aaa5da5596418f975`.
- RPD protokolü blob: `dbb5f1365c1e3fa917ed589c8c51492372b80d28`; tam metin okundu.
- `work/devos-source-reading/WORK.md` blob: `6b0a6faf551256e4f2f15e9aca0b3b9956052560`; tam metin okundu.
- Önceki exact REVIEW blob: `779bd2a71ee44188c8bfbc3874afd415a90b21c3`; kesilen çıktılar örtüşen aralıklarla tamamlanarak okundu.
- Research main ref: `08b91f01f4bd3cdeee0f72eca61e96c5e1676482`; o ref'teki bütün dosyalar tam okunmuş sayılmaz.

Bu gözlemler yerel checkout, aktif süreçler, kullanıcının kurulu Codex sürümü, native deneylerin güncel geçerliliği veya yeni görevin başarı kanıtı değildir. Kaynak sürümleri değişmişse farkı değerlendir; eski snapshot'a zorla geri dönme.
