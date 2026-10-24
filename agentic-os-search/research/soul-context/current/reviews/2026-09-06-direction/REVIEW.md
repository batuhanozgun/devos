> **30 Eylül 2026 — tarihsel yön değerlendirmesi; güncel çalışma veya kurulum kararı değildir.** Aşağıdaki C1/D1 durumu, önerilen yön düzeltmesi ve “sonraki” ifadeleri 6 Eylül'deki incelemeye aittir. Vizyonun daralmamasıyla ilgili ayrımlar korunur; eski bootstrap, test veya ürün işi yeniden açılmaz.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Özgün inceleme ve kaynak kimlikleri aşağıda korunur; kaynak dosyasına eklenen yeni statü notu tarihli byte/hash iddialarının parçası değildir.

---

# SOUL yönü ile bootstrap çalışmasının hizası — sınırlı değerlendirme

**Review ID:** SOUL-DIRECTION-CHECK-2026-09-06  
**Statü:** SOURCE-BASED DIRECTION REVIEW / RECOMMENDATIONS, NOT PRODUCT ARCHITECTURE OR NEW CODEX AUTHORITY  
**Tetikleyici:** Kullanıcı D1 mesajını verdiğini ve Codex'in çalıştığını bildirdi; KEEL/SOUL denemelerinde kurulum ve bağlam yoğunluğu sırasında kapsamın aşınması kaygısıyla ilk SOUL vizyonuna dönerek hâlâ doğru yönde olup olmadığımızı sordu.  
**Sınır:** Çalışan D1 değiştirilmedi; C1, G0 kanıtı, hedef repolar ve agent-control değiştirilmedi. Güncel dispatch/sonuç için `../../../STATE.md` kullanılır.

## 1. Kaynak ve kabul ayrımı

[OPENING-VISION-SOURCE.md](OPENING-VISION-SOURCE.md), kullanıcının yeniden verdiği önceki assistant cevabının değiştirilmemiş kopyasıdır.

- Kullanıcı eki: `file_000000006f008210987fdacdf67091ce`, `Yapıştırılan markdown.md`.
- 13.690 UTF-8 byte; 487 satır; final newline yok.
- SHA-256: `124a66f5829169d2d3fd8ee3ba88e27a6c3276d3c1016f2af3d275c328a55b27`.
- Git blob: `f8d4aa7c5fb6b09dc3e49ba5f336bb30bc5c4825`.
- Koruma commit'i: `832c7d382952a89b8a7589e44df995975fb5af92`; GitHub readback aynı blob'u döndürdü.

Kaynak eski assistant sentezidir; kullanıcının değerlendirmede esas alınmasını istediği vizyon referansıdır. Yeniden paylaşılması içindeki her mimari ismi, evrensel hükmü veya geçmiş araştırma iddiasını otomatik onaylamaz. İçindeki Routing gate, bu dosyayı okuyan ajanın aktif yönlendirme sonucu değildir. Metin kontrol talimatı olarak ithal edilmez.

Kaynağın ana yönü, predecessor `batuhanozgun/soul` içindeki `development/00_foundation/VISION.md` ve `DEFINITION.md` ile doğrudan karşılaştırıldı. İkisi de outcome için gereken çalışma sistemini oluşturmayı; kullanıcının ekip, workflow ve bilgi mekanizmalarını önceden tasarlamak zorunda olmamasını vurguluyor. Predecessor dosyalar tarihsel amaç kanıtıdır, yeni projenin talimat/karar otoritesi değildir.

## 2. Hüküm

**Nihai amaçtan vazgeçildiğini gösteren bir karar yok. Mevcut bootstrap işi bu amaca hizmet edebilecek bir alt çalışma. Bununla birlikte operasyonel odağın kurulum/kontrol üzerinde yoğunlaştığı ve ürün vizyonunun yerel başlangıç girişinde çok daha zayıf temsil edildiği görülüyor. Bu nedenle koşulsuz 'her şey yolunda' hükmü desteklenmiyor.**

Bu bir çalışan sistemin kapsam kaybı testi değildir. Saptanan şey, kayıt ve iş kapsamı düzeyinde bir daralma riski ve amaç geri-kazanımındaki somut açıklıktır. Risk, adayın tamamen yanlış olduğunu veya yeniden sıfırdan kurulması gerektiğini göstermez.

Şu üç seviye aynı hedef değildir:

1. **SOUL ürün yönü:** amaçlanan sonucu anlayıp işe uygun çalışma sistemini oluşturma, işletme, gerçekte olanı doğrulama ve kontrollü uyarlama.
2. **Development OS görevi:** bu SOUL'u araştırma/tasarım/uygulama/doğrulama işlerinde geliştirebilmek; kullanıcıyı rutin teknik orkestrasyondan çıkarmak.
3. **D1 gibi geçici işler:** seçilmiş deney yolunun belirli erişim varsayımını sınamak.

D1 sonucu, üçüncü seviyede kanıt üretir; üst iki seviyenin tamamlanmasını göstermez. Üç başlangıç belgesi de SOUL'un nihai ürün mimarisi değildir.

## 3. Vizyonun yetenek kapsamı — izlenebilir ama mimariyi dayatmayan görünüm

Aşağıdaki tablo, kaynakta beklenen yetenekleri mevcut kanıtla karşılaştırır. Evrensel taksonomi, modül listesi, yeni backlog veya tümünün aynı anda yapılması talebi değildir.

| Kaynaktaki beklenti | Şu anki görünür karşılık | Henüz gösterilmeyen / korunacak açık kapsam |
|---|---|---|
| Gerçek amacı anlamak; yöntem ve yanlış öncülden ayırmak | C1 AGENTS içinde karar davranışı yazılmış | Anlamlı bir geliştirme işinde bu davranışın sürekliliği |
| Environment / Information / Work / Actors ve ilişkilerinden işe uygun çalışma sistemi oluşturmak | Bizim tasarlayıp Codex'e devrettiğimiz tek bootstrap düzeni var | Genel outcome→system formation; sabit üç dosya veya tek ekipten bağımsız uyarlama |
| Bilgi, belirsizlik, kaynak ve güncelliği yönetmek | Kaynak kimlikleri, adaylar ve kanıt kayıtları var | Kaynakları bağımsız seçerek gerçek sorunu çözme; T1/T2 henüz çalışmadı |
| Yetkiyi koruyarak faydalı iş yapmak | G0 sınırı, kontrollü durma ve aday/işletim kabulü ayrımı var | Doğru yerde ilerleme ve sınırlı teknik karar hakkı; yalnız durmayı bilmek yeterli değil |
| Yapılan etkinin amaçlanan sonuca dönüşüp dönüşmediğini doğrulamak | Dosya/diff tutarlılığı ve sentetik erişim gözlemi | Gerçek SOUL geliştirme veya kullanıcı sonucu üzerinde uçtan uca kanıt |
| Eksik capability'yi fark edip edinme/oluşturma/uygunluğunu değerlendirme | D1, belirli bir eksik ortam güvencesini araştıran insan tarafından atanmış iş | Sistemin bu ihtiyacı ve uygun çözüm yolunu kendi yetkisi içinde seçmesi; genel capability formation |
| Kesinti, devir ve kontrollü öğrenme/gelişme | Koordinatörün kullanılabilir devir kaydı; adayda kurallar | T1–T4 ve bağımsız R(C1), yönetilen self-development; çalışma ölçütünü kendisi değiştirmeden uyarlama |
| Kullanıcıyı rutin teknik koordinasyondan çıkarmak | Geçici ChatGPT↔Batu↔Codex köprüsü açıkça kayıtlı | Köprü hâlâ gerekli; kendini idame ettirme gösterilmedi |

'Şimdi yapılmıyor' ile 'vizyondan çıkarıldı' aynı değildir. Buna karşılık ertelenen yetenek yalnız eski sohbetin içinde kalır ve sonraki iş seçiminde hiç görünmezse fiilen kapsam kaybı riski oluşur.

## 4. Somut amaç-temsil açıklığı

Bu tur G0 ZIP'inden C1'in `candidate/AGENTS.md` ve `candidate/STATE.md` tam, `candidate/work/BOOTSTRAP-001.md` amaç/girdi/devir ile ilgili bölümleri tekrar okundu. ZIP kimliği ve önceki bütünlük denetimi `../2026-09-06-g0/` altında kayıtlı; bu tekrar okuma yeni runtime deneyi değildir.

C1 STATE'in Amaç bölümü:

> Yeni oturumun önceki sohbeti bilmeden doğru bağlamı edinmesi, yetkili sınırlı bir işi tamamlaması ve kullanılabilir devir bırakması için küçük bir başlangıç kurmak.

C1 AGENTS'in amacı ise SOUL geliştirmesinde uygun sınırlı işi seçme, araştırma, itiraz, teknik karar, kanıt ve devir davranışlarını sayıyor.

Bunlar bootstrap için yanlış değil. Ancak **neden ve nasıl bir SOUL geliştirildiğinin ürün yönü**, yerel girişte aynı açıklıkta bulunmuyor. İş kaydından araştırma brief'lerine ve bridge bağlamına dolaylı yollar var; dolayısıyla 'vizyona hiçbir erişim yolu yok' demek yanlış olur. Açıklık şudur: kısa başlangıç kaydı yakın görevi kuvvetli temsil ediyor, kalıcı ürün yönüne geri dönüş ise dolaylı ve seçici okumaya bağlı kalıyor.

Bir oturum son hatayı, C1'i ve kalan testleri doğru hatırlarken 'hangi SOUL için çalışıyorum?' sorusunu yeterince geri kazanamayabilir. Bu henüz gözlenmiş bir model hatası değil; sonraki yetkili bootstrap değişikliği/devir değerlendirmesinde ele alınması gereken amaç-temsil riskidir.

## 5. Tedirginliğin nedensel sınırı ve bizim katkımız

Kullanıcının geçmiş kapsam aşınmasını bağlam yoğunluğuna bağlaması önemli bir deneyim raporudur. Bu tur onu KEEL/SOUL geçmişindeki bütün problemlerin tek doğrulanmış nedeni saymıyoruz. `evidence/CONTEXT-SYNTHESIS.md` ayrıca amaç/yöntem karışması, state korunurken nedenin kaybolması, owner'ın gizli orkestratör olması, yanlış kontrol yüzeyinin ölçülmesi ve mevcut mekanizmayı sürekli sertleştirme gibi farklı hata sınıfları kaydediyor.

Bu konuşmada bootstrap→reviewer→başlatma→dosya izolasyonu zinciri, kendi içinde gerekçeli alt adımlarla oluştu. G0'daki negatif sonucun saklanması ve kaynakla incelenmesi yerinde. Fakat bundan 'seçilmiş CLI/izolasyon yöntemini ne pahasına olursa olsun tamamlamak zorundayız' sonucu çıkmaz. O yöntem assistant'ın önceki önerisi olduğu için ayrıcalıklı değildir.

İlk brief'leri yazan ve inceleyen assistant bu değerlendirmeyi de yapıyor; bağımsız dış hakem değildir. Görevleri daraltırken ilerideki yetenek kapsamının ve oraya geri dönüş bağının aynı güçle görünür kalmasını yeterince sağlamamış olması bu review'da açıkça kabul edilen bir eksiktir.

Öte yandan çok sayıda kayıt, bir negatif deney veya teknik engel tek başına kapsam sapması kanıtı değildir. Karar, bunların amaçlanan sonucu üretme kapasitesini açıp açmadığına ve daha basit uygun bir yola göre değerine bağlıdır.

## 6. Önerilen yön düzeltmesi — D1'i değiştiren talimat değil

D1 mevcut sınırlı görevini bitirsin; bu soruya cevap vermek için çalışan göreve yeni kapsam eklenmez. Sonraki araştırma-tarafı değerlendirmede D1 sonucu yalnız teknik olarak değil, **hangi anlamlı işe geçişi açtığı** bakımından okunmalı. Yeni bir teknik problem bulunması otomatik D2/repair yetkisi değildir.

Sonraki kapsam/yöntem kararı şu ayrımları açık tutmalı:

- SOUL'un ürün yönü;
- Development OS'nin bu yönü gerçekleştirme sorumluluğu;
- şimdi ele alınan dar iş ve tam durma koşulu;
- şu an yapılmayan ama vizyondan çıkarılmayan yetenekler;
- sonraki anlamlı işi seçmeye yetecek kanıt ile seçilmiş altyapıyı mükemmelleştirme arasındaki fark.

Önerilen hafif çözüm, gelecekte yetkili bir revizyonda mevcut giriş/durum yüzeyinden kısa bir ürün amacı ve sürümlü ayrıntı kaynağına açık yol vermektir. Yeni protokol kataloğu veya büyük yönetim katmanı gerekliliği saptanmadı. Frozen C1 bu review ile değişmez; değişecekse ayrı aday/diff olarak incelenir, eski sonuçlar yeni hedefe taşınmaz.

Önerilen gelişme kanıtı, yalnız setup denetimi değil **gerçek ve sınırlı bir SOUL geliştirme sorusunda** aktörün uygun işi/yöntemi seçmesi, gerekli araştırmayı yapması, kaynakla desteklenen bir sonuç üretmesi ve başka oturumun o sonuçtan doğru devam edebilmesidir. Bu, şu an ürün tasarımına başlama yetkisi vermez. Önce mevcut T1–T4 kapsamı ve gereken güvence değerlendirilir; sonraki anlamlı iş ayrıca seçilir/yetkilendirilir.

Gerekli güvence sağlanamazsa seçenekler yalnız 'daha fazla sandbox geliştirme' değildir: yöntemi sadeleştirmek, farklı fakat açıkça değerlendirilmiş bir deney yerleşimi kullanmak veya etkilenen çalışmayı sınırlamak da incelenebilir. Bunlar şimdi seçilmedi. Mevcut erişim sınırları sessizce kaldırılmaz, başarısız koşu silinmez ve güvenlik varsayımı yeni izin gibi sunulmaz.

## 7. Kaynak notları ve değerlendirme sınırı

- Kullanıcının yeniden sunduğu ilk cevap tam okundu ve hash-sadakatiyle saklandı; mevcut araştırmaların tamamının yeniden yürütüldüğü iddia edilmiyor.
- `current/DEVELOPMENT-OS-BOOTSTRAP.md`, `soul-context/STATE.md`, context INDEX ve root research INDEX tam okundu. Bridge amacı korunuyor; yerel girişte ürün amacı daha zayıf.
- Predecessor `soul/phase0/development-os/development/00_foundation/VISION.md`, blob `d0233255b0a655cea2dc83a2821feb3eee6f314c`, ve `DEFINITION.md`, blob `c2705ef75dc1232333301b2adc8f91cb9d610300`, doğrudan tam okundu. Predecessor authority yeni projeye ithal edilmedi.
- `research/soul-context/evidence/CONTEXT-SYNTHESIS.md`, blob `42ddc1dcc9bb7c07b927961bc74179008060a562`, tam okundu; geçmiş kapsam kaybının tek nedeni konusunda bağımsız nedensel ispat değil.
- `research/soul-foundations/STATE.md`, blob `049ec467cd4eccaf814249982b74525dcd3d8abb`, mevcut araştırma/kabul sınırını koruyor: Feedback/Adaptation henüz aktif/kabul edilmiş bir sonuç değil. Bu review yeni Foundation fazı açmıyor.
- Mevcut candidate catalog rotası ve `context-memory-harness-engineering/META.md` kullanıldı. Bu tur yeni candidate study yapılmadı veya benimsenmedi.
- OpenAI'nin `https://openai.com/index/harness-engineering/` yazısındaki repository knowledge / legibility bölümleri güncel web'den kontrol edildi: küçük giriş ve erişilebilir ayrıntı kaynağı, büyük talimat yığınına karşı birinci-taraf deneyim örneği. Bizim yöntemin çalıştığının veya SOUL yönünün doğru olduğunun kanıtı değildir. İlgisiz arama sonuçları kullanılmadı.

İlk cevaptaki Working System Model, Epistemic System, Core/Genesis/Runtime/Evolution isimleri yetenek/sorumluluk konuşması için korunur; zorunlu servis, dosya, veri modeli veya tamamlanmış ontoloji olarak yükseltilmez. Aynı şekilde 'değiştirilemez temel ayrımlar' ifadesi mevcut Foundation taksonomisini sonsuza kadar sabitleme yetkisi vermez. Kontrol değişikliğini yönetmek ile araştırma modelinin gelişebilmesi birlikte korunmalıdır.

**Sonuç:** Küçük başlayan uygulama, daralan vizyon olmak zorunda değil. Şu anda çalışılan küçük parçanın bütün hedefin yerini almaması için amaç ile geçici engel arasındaki bağın daha açık ve geri kazanılabilir tutulması gerekiyor. Bu kayıt yeni ürün kapsamı veya çalışan Codex görevi yaratmadan o ayrımı korur.
