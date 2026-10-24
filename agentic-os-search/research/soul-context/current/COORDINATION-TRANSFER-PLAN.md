> **29 Eylül 2026 — tarihsel koordinasyon devir planı; etkin görev veya mandat değildir.** Aşağıdaki Codex pilotu, B–D geçişleri, hedef depolar, sonraki eylemler ve Claude'u daha sonra ekleme seçeneği 7 Eylül'deki plana aittir. Eski plan yeniden yürütülmez; özgün gerekçeler ve kanıt sınırları korunur.
>
> Güncel devir [D030](../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. ChatGPT'nin bu devirdeki işi [depo bakım planıdır](../../../REPOSITORY-TRANSITION.md), eski koordinasyon pilotu değildir.

---

# Geliştirme koordinasyonunu devretme planı

**Plan ID:** DEVOS-COORDINATION-TRANSFER-2026-09-07  
**Rol:** research-side süreç planı; ürün mimarisi veya kalıcı ajan-kontrol dosyası değildir.  
**Yetki durumu:** Kullanıcı, koordinasyonu geliştirme ortamına devretme yönünü benimseyip süreci planlamamızı istedi. Bu planın ayrıntıları öneridir; planlama izni Codex'te yürütme, hedef repo değişikliği veya Claude'a veri gönderme izni değildir.  
**Güncel durum / gönderim / sonraki sorumluluk:** `../STATE.md`.

## 1. Hedef ve somut ilk kazanım

SOUL, amaçlanan sonuç için işe uygun çalışma sistemini oluşturabilmeli, işletebilmeli ve kanıta göre uyarlayabilmelidir. Development OS bunun geliştirme düzenidir. Araştırma browser'da devam edebilir; her geliştirme alt adımının ChatGPT → Batu → Codex mesaj taşımasına bağlı olması kalıcı tasarım değildir.

İlk kazanım: **Bir Codex koordinatörü, bir yardımcıya anlamlı ve sınırlı kaynak inceleme işi verir; sonucu doğrudan alır, kaynakla değerlendirir ve kullanılabilir devam kaydını üretir. Batu iki aktör arasında mesaj taşımaz.** Bu ilk iş bittikten sonra sonucun araştırma tarafına bir kez aktarılması hâlâ gerekebilir; bunu bütün insan relay'inin kalkması diye sunmayacağız.

İlk pilot, C1'in SOUL amacı ve mevcut yetki/kapsamı yeni oturuma ne kadar doğru taşıdığını değerlendirir. Somut ürün; kaynaklara bağlı amaç/kapsam ayrımı, en küçük gerekli düzeltme önerisi ve yeni oturumun kullanabileceği devam kaydıdır. Mevcut adayı değiştirmez, kabul etmez ve yalnız vizyon tekrarıyla başarılı sayılmaz.

## 2. Seçilen küçük yol ve alternatiflerin durumu

| Seçenek | Bu planın tercihi / nedeni |
|---|---|
| Codex koordinatörü + mevcut yerleşik yardımcı | İlk deneme. Mevcut hesap/araç ortamında tek devir ilişkisini sınar; özel başlatıcı geliştirmeyi önkoşul yapmaz. Yerelde kullanılabilirliği henüz gözlenmedi. |
| G1-R1 özel başlatıcı düzeltmesi | Askıda tutulur. G1'in özel güvence deneyi için anlamlı olabilir; bu yeni kaynak/devir işinin zorunlu bağımlılığı olduğu gösterilmedi. |
| Codex + Claude | Sonraki, ayrı değerlendirilecek genişleme. Ayrı-model eleştirisi yararlı olabilir; sürüm, hesap, çağrı/geri dönüş, veri paylaşımı ve maliyet henüz açık. İlk native devrin koşulu değildir. |
| gstack veya yeni orkestrasyon sistemi kurmak | İlk işte seçilmedi. gstack araştırması karşılaştırma girdisidir; kurulumu veya wrapper'ları bizim host/iş/güvence ihtiyacının hazır karşılığı sayılmaz. |
| Tek ajanla her şeyi sürdürmek | Kaynak çıktısını üretebilir; fakat seçilen otomatik görev–sonuç devri iddiasını sınamaz. Native devir yoksa tek-ajan çıktısı kısmi çalışma diye korunur, pilot geçmiş sayılmaz. |

Codex rolünü başka bir uygulamada açmak bu ChatGPT konuşmasını, gizli talimatları, bütün bağlamı veya performansı aynen taşımak değildir. İlk koordinatör yeni bir Codex sohbetinde başlar; eski uzun sohbeti canlı eş-koordinatör yapmayız. Eski işin dosyalarını kaynak olarak kullanırız.

## 3. İş sırası ve yetki geçişleri

### A — İlk görev sözleşmesi ve kaynak rotası

Bu planla birlikte hazırlanan `briefs/CODEX-COORD-01-NATIVE-HANDOFF.md`, ilk görevin geçici çalışma sözleşmesini, sınırını, kaynaklarını ve sonuç ölçütlerini tek yerde taşır. Kullanıcı onu belirli sürümden benimseyen yürütme mesajını gönderdiğinde yalnız o pilot yetkilendirilir.

Kalıcı AGENTS/CLAUDE/config dosyası kurmayı ilk devirden önce zorunlu yapmayız; fakat aktörü yönergesiz de bırakmayız. Görev sözleşmesi daha ilk kaynak seçimi ve delegasyonda uygulanır. Araştırma R01–R09'u aynen ithal etmez; amaca göre kısa geliştirme ilkeleri kullanır.

### B — COORD-01: mevcut kabiliyetle gerçek kaynak işi

Tek yeni koordinatör, aynı SOUL-Development-OS projesinin doğru çalışma kopyasında başlar. Önce yalnız ilgili gerçek durum ve yerleşik devir/sonuç alma imkanını kontrol eder; genel araç envanterini veya G0/D1/G1 deneylerini baştan açmaz.

Kullanılabilir native yol varsa, aynı görev içinde bir yardımcıya sınırlı inceleme verir. Koordinatörün işi kaynak seçimi, delegasyon, bulgunun doğrulanması/itirazı ve bütünleştirmedir; her alt soruyu Batu'ya taşımaz. Yardımcı varsayılan olarak hiçbir dosyayı değiştirmez; sonuç döndürür. Koordinatör yalnız yeni izinli çıktı alanına kayıt bırakır.

Teslimat bir `RESULT.md` dosyasıdır: esas kaynak değerlendirmesi, yardımcı katkısı ve ona verilen gerekçeli karşılık, açık eksikler, tam kaynak/aday kimlikleri ve devir bölümü. Gerekli küçük ham devir izleri aynı yeni alanda korunur; yeni test framework'ü veya genel log toplama sistemi kurulmaz. Esas sonuç sohbet içinde de verilir; kullanıcı telefondaysa yalnız yerel ZIP bağlantısına mahkûm edilmez.

**Bitiş:** kaynak işi tamamlanır ve gerçek devir kanıtlanır; veya devrin tam engeli ve etkilenmeyen tamamlanmış kısım açıkça döner. Bir teknik imkanın bulunması tek başına sonuç değildir.

### C — Sınırlı kalıcılaştırma ve gerçekten yeni oturumdan devam

B'nin sonucunu değerlendiririz. Yeterliyse ayrı, sürümlü yetkiyle yalnız gerekli geliştirme giriş/kayıt değişikliğini yaparız. Mevcut AGENTS/STATE/work adayını çöpe atmak veya büyük protokol mimarisi kurmak gerekmez. Tam değişiklik ve kabul kapsamı sonuç görüldükten sonra belirlenir; bu plan o dosyaları şimdiden değiştirmez.

Ardından önceki sohbeti taşımayan yeni bir ana oturum, kısa bir giriş referansından amacı/yetkiyi/sonucu geri kazanıp bir sonraki sınırlı işi yürütür veya tamamlanmış işi doğru saptar. B'deki yardımcı konuşması buna eşdeğer değildir. Oturum başlatmak ile aktörler arasında teknik mesaj taşımak da ayrı eylemlerdir.

**Bitiş:** yalnız dosya varlığı değil, taze ana oturumun kaydı kullanması, yapılmış işi tekrarlamaması ve doğru sınırda devam etmesi gözlenir. Otomatik talimat keşfi sınanıyorsa açıkça 'dosyayı oku' talimatıyla yapılan çalışma onun kanıtı sayılmaz.

### D — Normal geliştirme işine geçiş ve koordinasyonun devri

Dar kapsamda iş/devir kanıtı yeterli olunca, yerel kayıtlardan öte `soul-development-os` kendi erişilebilir current-state otoritesini üstlenir. Gerekli özel repo yayını/branch/PR yolu ayrıca yetkilendirilip gerçekten doğrulanır; böylece her tur ZIP taşıma zorunluluğu azaltılır. Yayın başarıyla geri okunmadan 'GitHub'da erişilebilir' denmez.

Koordinatör artık izinli normal araştırma/tasarım/geliştirme işini seçer veya kapsam dışında ise önerir; gerektiğinde yardımcı çağırır. Araştırma asistanı günlük mikro-talimat vericisi olmaktan çıkar, araştırma ve dönemsel yön/kanıt değerlendirmesinde kalır. Kendi kurallarını değiştirme, ürün yayını, yeni bütçe ve geniş yetki ayrı karar sınırlarıdır.

Claude Code, yalnız ihtiyaç gösteren işe ve açık veri/hesap/kullanım iznine bağlı bir ayrı-model inceleme seçeneği olarak eklenebilir. Sürekli üç kişilik yönetim veya uzman ordusu şart değildir. B–D geçişleri planın varlığından otomatik yetki almaz.

## 4. İlk pilotun güvenceleri neden G1'den farklı?

Bu yeni soru **iş devri ve kaynak kullanımının gözlenmesi** hakkındadır. C1'i işletimde kabul etme, adayın kendi denetimini değiştirmesine dayanıklı bağımsız doğrulama veya bütün Mac'e karşı izolasyon sertifikasyonu değildir. Eski G1 koşulları kaldırılmaz; farklı ve daha dar bir iş tanımlanır.

| Risk / iddia | COORD-01'de gereken karşılık | Bu tur kanıtlanmayan |
|---|---|---|
| Yanlış amacın korunması | Ham amaç kaynağı, mevcut durum ve C1 karşılaştırması; hipotez ve kabul ayrımı | Tam ürün mimarisi |
| Kullanıcının mesaj taşıması | Gerçek native görev, sonuç ve koordinatörün sonucu kullanma izi | 24/7 otomatik uyanma veya bütün relay'in kaldırılması |
| Yetkisiz değişiklik | Proje/kontrol/kanıt dosyalarına yazma yok; yalnız ayrı çıktı; mevcut platform onayları korunur | Tüm araçlarda tam teknik yazma-erişim izolasyonu |
| Ajanların birbirini onaylaması | Gerekçeli bulgu, doğrudan kaynak ve kabul/red/koşullu karşılık; zorunlu fikir birliği yok | Bağımsız güvenlik doğrulaması veya farklı-model çoğunluğuyla doğruluk |
| Bağlamın kaybolması | Sürümlü kaynaklar ve devam kaydı; ayrı sonraki fresh-session deneyi | COORD-01 tek başına kesintisiz kendini idame |

Yerleşik alt ajan mevcut izinleri/bağlamı devralabilir; 'incelemeci' veya 'read-only görev' adı teknik sınır değildir. Bu artık dosya erişimi penetrasyon testi değil, mevcut platform korumaları altında işbirlikçi kaynak incelemesidir. Bilinen koruma arızasını atlama, Full Access'e geçme veya kişisel sırları deneye verme yok. Etkin sınırla görev arasında maddi çelişki varsa bağlı devir durur. Sistem dosyası/credential/MCP env taraması ve özel kapatma başlatıcısı yoktur.

## 5. Başarı ölçütü ve büyümeyi durdurma

COORD-01 için sonuç görmeden önce sabitlenecek beş beklenti:

1. Amaç, Development OS rolü ve geçerli görevi kaynakla doğru ayıran kullanılabilir çıktı.
2. Gerçek yardımcı görevi ve sonucu; kullanıcının aktörler arası metin taşımasının bu iş için sıfır olması.
3. Koordinatörün en az bir maddi bulgu/teyit/itirazı kaynağa göre ele alması. Hata veya fikir ayrılığı üretmek zorunlu değildir.
4. Yeni oturumun gerekecek kaynakları, kesin sınırı ve ilk sorumluluğu bulabildiği devir kaydı.
5. Yetkisiz etki/başarı iddiası olmaması; gözlenemeyen erişim, araç veya bağlam bağımsızlığının açık kalması.

İlk pilot bir koordinatör ve bir yardımcı ilişkisiyle sınırlıdır. Bir görev ve gerektiğinde aynı yardımcıya en fazla iki açıklama/düzeltme dönüşü; kendi alt ajanlarını açma yok. Bu sayılar bilimsel optimum değil, tek devir ilişkisini ölçen maliyet/kapsam tercihidir. Yeni kod altyapısı geliştirmeyiz. Kabiliyet yolu kısa kontrolde yoksa, daha fazla ayar değiştirerek denemeyi büyütmeyiz.

Bütün plan için kesin süre sözü yok; sonraki aşamaların süresi gerçek sonuçlara bağlıdır. İlk görevde duvar-saati/çağrı sınırları ve durma koşulları brief'te tanımlıdır. Başarısız iletişim veya eksik kaynak yüzünden uydurma sonuç üretmek yerine kısmi çıktı korunur. Eski yapılan işler ve başarısızlıklar silinmez; 'bir sonraki denemede kesin olur' varsayımı yoktur.

## 6. Araştırmadan tercihe iz

Plan, araştırma sonucunun zorunlu mimari türevi değildir. Dayanak ve tasarım yorumu ayrı:

- Foundation Control/Standing: korunan etki, uygulanabilir yetki ve kanıt/kabul ayrımı → ilk işin etkisine orantılı güvence, eski PASS'i başka iddiaya taşımama. Kaynak rotaları: `research/soul-foundations/05_relation-control-composition/control-constraint/KEY.md`, `composite-standing/S3-EVALUATION-UNCERTAINTY-INVALIDATION.md`.
- `research/studies/multi-agent-patterns/META.md` ve `SOUL-DEVELOPMENT-OS-ASSESSMENT.md` §§4–6 → önce gerekli devir ilişkisi; sabit büyük ekip değil. Bu kaynak tarihsel değerlendirmedir, güncel Foundation yetkisi değildir.
- `research/studies/gstack/` META/coordination/host syntheses ve yöntem incelemesindeki seçici upstream kontrol → bağlam ayrımı, dosya izolasyonu ve dış-model çeşitliliği ayrı; gstack kurulumunu otomatik seçmeme. Tüm güncel upstream yeniden araştırılmadı; adoption yapılmıyor.
- Context/Memory/Harness kaynakları ve mevcut C1 amaç açığı → görev sonucu ile kalıcı durum ayrı, kısa girişten gerekli kaynağa dönme.
- Bu konuşmada tam okunmuş protokoller bu asistanın kontrol katmanıdır; yukarıdaki araştırma kanıtlarının yerine kullanılmaz.

Bu planlama turunda güncel STATE/INDEX/collaboration kaydı ve catalog yeniden okundu; aynı konuşmada okunmuş bridge, method, Foundation ve ilgili study kaynakları yeniden kullanım girdileridir. Tüm araştırma korpusu yeniden okunmuş değildir.

## 7. Güncel ürün belgesi ve yerel doğrulama sınırı

2026-09-07'de resmi OpenAI Subagents belgesi yeniden kontrol edildi: yerel app/CLI/IDE'de native görev ve sonuç toplama; talimatla delegasyon; sandbox/izin ve bağlama ilişkin miras; özel ajan yapılandırması. `https://developers.openai.com/codex/multi-agent` → `https://learn.chatgpt.com/docs/agent-configuration/subagents` (özellikle Availability, Orchestration, Approvals). Belgede örneğin özel config tanımlanabilmesi, bizim ilk pilotta onu yazmamız gerektiğini göstermez. Kurulu sürüm/oturumda erişim henüz test edilmedi.

Claude headless belgesi de kontrol edildi: `https://code.claude.com/docs/en/headless`. Programatik çağrı teknik olarak mümkün olmakla birlikte doküman abonelik programatik kullanımına ayrı Agent SDK kredi koşulları ve bare-mode kimlik doğrulama farkı anlatıyor. Kullanıcının hesabı/maliyeti gözlenmedi; 'kurulu olduğuna göre ücretsiz/sınırsız' sonucu yok. Bu yüzden Claude ilk native pilotun gizli önkoşulu veya otomatik fallback'i değildir.

## 8. Hazırlanmış ilk eylem ve mevcut sınır

İlk yürütme adayı: **DEVOS-COORD-01-2026-09-07**, `briefs/CODEX-COORD-01-NATIVE-HANDOFF.md`.

Kullanıcı uygulamaya geçmek istediğinde aynı SOUL-Development-OS projesinde yeni Codex sohbetine bu sürümlü brief'i benimseyen kısa görev mesajı verilir. Şimdi planı hazırlamak, o mesajın verildiği veya native aktörün çalıştığı anlamına gelmez. Sonraki aşamalar, ilk çıktının gerçekten ne gösterdiğine ve ayrıca devredilmiş yetkiye bağlıdır.

G1-R1 askıda; C1/G0/D1/G1 korunur. Research agent-control, Foundation, studies, predecessor ve hedef repolara bu planla müdahale edilmez. Bir sonraki işe geçişin otoritesi bu belgenin tarihsel gelecek zamanları değil, güncel `../STATE.md` ve gerçek kullanıcı yetkisidir.
