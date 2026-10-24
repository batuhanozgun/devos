> **30 Eylül 2026 — tarihsel bootstrap yöntem değerlendirmesi.** Aşağıdaki Foundation durumu, gstack karşılaştırması, G1-R1'in askıya alınması ve seçenek önerileri 7 Eylül'deki bağlama aittir; bugünkü araştırma aşamasını veya kurulum sırasını belirlemez. Araştırmayı okumak ile seçilen yöntemin yeterliğini göstermek arasındaki ayrım korunur; eski yöntem seçimi yeniden açılmaz.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Özgün araştırma ve değerlendirme gövdesi aşağıda korunur; bakımın tek devam kaydı [REPOSITORY-TRANSITION](../../../../../REPOSITORY-TRANSITION.md)'dir.

---

# Foundation, araştırma kullanımı ve bootstrap yönteminin yeniden değerlendirilmesi

**Review ID:** DEVOS-METHOD-REASSESSMENT-2026-09-07  
**Statü:** BOUNDED SOURCE-BASED METHOD REVIEW / RECOMMENDATION; yeni uygulama, deney veya Foundation yetkisi değildir.  
**Tetikleyici:** Kullanıcı G1-R1 mesajını henüz göndermediğini söyledi; Foundation'ın bu aşamaya gelip gelmediğini, araştırma kullanımı ve gstack alternatiflerinin yeterliliğini sorguladı. Teknik olmamasının çalışmayı yanlış değerlendirmesine yol açıp açmadığını da bir ihtimal olarak sundu.  
**Güncel checkpoint:** `../../../STATE.md`.

## 1. Kısa hüküm

Kullanıcının yöntem ve öncelik kaygısı maddi dayanak taşıyor. Bunu teknik bilgisizliğe, gereksiz endişeye veya yapay zekâya aşırı güvensizliğe bağlayan kanıt yok. Ancak 'ilgili hiçbir zemin araştırılmadı', 'araştırma reposu kullanılmıyor' ve 'gstack'e hiç bakılmadı' sonuçları mevcut kaynak izleriyle desteklenmiyor.

Daha isabetli eleştiri: **ilgili araştırmayı okumak ve tekil hatayı doğru teşhis etmek, seçilen birleşik başlangıç/izolasyon yönteminin minimum yeterli ve bu aşamada gerekli olduğunu kanıtlamaz.** Temel ayrımlardan belirli mekanizmaya geçişte orantılılık, alternatif ve zorunlu bağımlılık gerekçesi yeterince açık değildir.

SOUL amacı terk edilmiş değildir; kullanıcıyı rutin teknik koordinasyondan çıkarma ve anlamlı fresh-session işi ise henüz gösterilmemiştir. G1-R1 teknik olarak makul bir devam adayıdır; yalnız parser hatasının bilinmesi onu zorunlu sonraki iş yapmaz. Önceki 'şimdi gönder' tavsiyesi bu yöntem konuşması sırasında askıdadır. Kullanıcı henüz göndermemiştir; ne R1 ne başka bir görev başlatıldı.

## 2. Foundation'ın gerçekten bulunduğu yer

Bu tur güncel `research/soul-foundations/STATE.md` ve `INDEX.md` doğrudan okundu. Dört zemin, Binding, Composite Standing, Control, Transition parent/Propagation ve Actual Causal Contribution kabul edilmiş; Contrastive/Interventional sonuç kullanıcı değerlendirmesini bekliyor; Feedback/Adaptation aktif değil. Bu kayıt bütün Development OS'nin pratik tasarımını tamamlanmış göstermez.

`control-constraint/KEY.md` de doğrudan okundu. Exact protected effect, governing basis/objective, applicability, exception/default ve coverage ayrımlarını taşıyor. 'Bir yol engellendi' ile 'istenmeyen etki bütün kapsamda denetlendi' farklı. Aynı kaynak, keyfî bir sınırlama veya mekanizmanın tek başına Control olmadığını söylüyor. Bu ayrım yalnız daha fazla kontrol eklemeyi değil, **hangi korumanın hangi amaç için gerekli olduğunu** açıklamayı da gerektiriyor.

Üç düzey ayrı tutulmalı:

1. Foundation: hangi olgusal/anlamsal ayrımlar karıştırılmamalı?
2. Bu projeye özgü tasarım kararı: başlangıç işi hangi etkileri taşıyor; hangi güvence hangi aşamada zorunlu; mevcut alternatifler neden yeterli/yetersiz?
3. Yerel mühendislik: belirli Codex sürümü, CLI/config davranışı ve yardımcı kod nasıl çalışıyor?

Foundation'ın daha fazla ilerlemesi ikinci düzeye girdi verebilir; üçüncü düzeydeki TOML hatasını veya sürüme bağlı platform davranışını kendiliğinden çözmez. Tüm Foundation bitmeden sınırlı, geri alınabilir bootstrap deneyi yapılmasının yanlış olduğu gösterilmiş değil. Buna karşılık başlangıç prototipini araştırmadan türetilmiş nihai çalışma mimarisi saymak da doğru değil.

Foundation guardrail'leri kendi hattını korur. Daha önce ayrıca yetkilendirilmiş Development OS deneyleriyle karıştırılmaz; bu değerlendirme yeni Foundation araştırması başlatmaz.

## 3. Araştırma kullanımı: kayıt var, optimal yöntem ispatı yok

S1'in korunmuş yanıtı, Context/Memory/Harness, Foundation Standing/Control, multi-agent ve gstack koordinasyon sentezini seçici kullandığını bildiriyor. Bu, Codex'in okuma raporudur; her zihinsel kullanımın bağımsız doğrulaması değildir.

Araştırma asistanının S1 REVIEW kaynak bölümünde gerçekten şu dayanaklar kayıtlı:

- Context/Memory/Harness çapraz sentezi: kalıcılık, bağlam ve kullanım ayrımı; zorunlu ayrı yazılım katmanları türetilmemesi.
- `S3-EVALUATION-UNCERTAINTY-INVALIDATION.md`: değerlendirme, kanıt, kabul ve sürüme bağlı geçerlilik.
- `K3-MODALITY-GATE-AUTHORITY-PATH-BYPASS.md`: yetki, karar ve etkin denetim yolunun ayrılması.

G1 incelemesinde ise doğrudan paket/code kanıtı, sürümlü Codex override kaynağı ve TOML davranışı kullanıldı. Bu anlık teknik doğrulamalar araştırmasız tahmin değildir. Fakat üç belge seçimi, tek düzeltme sayacı, 8 alt koşu ve belirli launcher/izolasyon düzeni Foundation'ın zorunlu sonuçları değildir; yerel tasarım tercihleridir.

İncelenen S1/G1 karar izleri, bizim belirli launcher yöntemimizle gstack'in ilgili işletim seçeneklerini aynı amaç/risk/host koşullarında yeterince karşılaştırmıyor. Bu, 'gstack hiç okunmadı' demekten daha dar ve desteklenebilir eksiktir. Bu tur yapılan okuma geçmiş kararları geriye dönük araştırılmış yapmaz.

## 4. gstack'ten gerçekten ilgili karşılaştırmalar

Bu tur catalog → gstack META/INDEX/STATE/CORE → seçili coordination, host-portability ve v1.80 revalidation bölümleri okundu. Ardından güncel upstream main `0530392821c277b95e5cd65aa9d9fda4248718b2` olarak gözlendi; aşağıdaki üç dosyaya seçici geri dönüldü. Bu, bütün study'nin yeni HEAD'e yeniden doğrulanması veya repin değildir.

### A. Bağlam ayrımı ile dosya izolasyonu farklı amaçlar

Koordinasyon sentezi, fresh-context reviewer ile shared-worktree child'ı ayırıyor; bütün yardımcıların ayrı dosya güvenlik alanı olduğu iddia edilmiyor. Bazı güven artırıcı uzman kanalları başarısız olduğunda eksik coverage görünür kalırken üst iş devam edebiliyor. Buna karşılık durdurulamayan yazıcının ortak dosyalara müdahalesi gibi etki riski, üst işi durduruyor.

Çıkarım: hangi eksikliğin bütün işi bloke edeceği rolün işlevine, korunan etkiye ve kabul iddiasına göre belirlenebilir. Bu örnek, mevcut G1 erişim koşulunu sessizce kaldırma yetkisi veya her riske fail-open reçetesi değildir.

### B. Yeteneğin eksikliği her zaman bütün kurulumu iptal etmez

Kaydedilmiş v1.80 revalidation, Chromium edinimi başarısızken skill kaydının devam etmesini, browser gerektiren capability'nin ise eksik kalmasını anlatıyor. Bu tarihsel sürüm örneğidir; yeni HEAD'deki tüm setup davranışı bu tur tekrar okunmadı.

Çıkarım: 'çalışma düzeninin asgari başlangıcı', 'tüm araçlar kullanılabilir' ve 'her iş kabul edilmiş' aynı eşik olmak zorunda değil. Etkilenmeyen işe geçmek ancak onun kendi yeterlilik/izin koşulları sağlanıyorsa mümkündür.

### C. Hazır Codex işletim yardımcıları ve test örnekleri var

Güncel `bin/gstack-codex-probe` kaynak incelemesi auth/configured-model round-trip, sürüm, zaman aşımı, cache ve ayrı hata durumları için somut yardımcı kod gösteriyor. `test/codex-hardening.test.ts` başlangıç bölümü, bu yardımcıları sentetik HOME/env altında sınayan test düzenini gösteriyor. Kod okunmuştur; bu tur gstack testleri veya yardımcıları çalıştırılmamıştır.

Bunlar özel yardımcı yazmadan önce incelenecek yeniden kullanım/karşılaştırma adaylarıdır. Bizim MCP parser hatasını ve tam G1 güvenlik koşullarını aynen karşıladıkları gösterilmedi. Kayıtlı hesap dışında auth kurma veya yeni paket yükleme önerilmiyor.

### D. Codex-native kullanım ile Claude→Codex ikinci görüşü aynı değil

Güncel `hosts/codex.ts`, `codex` skill'ini üretimden dışlıyor ve Codex'e shell-out yapan cross-model resolver'ları bastırıyor. Kaynak bunu Claude'un Codex'ten ikinci görüş alması ile Codex içinde aynı modele yeniden danışmayı ayırmak için yapıyor.

Bu, bizim fresh-session davranış testlerimizi geçersiz kılmaz: onlar dış-model çeşitliliği ölçmüyor. Ancak gstack'in `/codex` wrapper'ını, Codex üzerinde aynı işi çözen doğrudan hazır Development OS diye sunmayı engeller. Host uyarlama ve güvence eşdeğerliği ayrıca değerlendirilmelidir.

## 5. Yöntemsel eksik ve sorumluluk

G0 → D1 → G1 hattındaki tekil kontroller bilgi kazandırdı. G1'in 11 native kontrolü geçmesi, önceki dosya sınırı sorununda ilerlemedir. Gerçek ajan/pilot ise başlamadı. Son hatanın belirli olması, bütün hattın en iyi başlangıç yolu olduğunu göstermez.

Saptanan sınırlı eksik: epistemik bağımsızlık, talimat kaynağı ayrımı, dosya-yazma koruması, özel veri erişimi ve kalıcı işletim kabulünü aynı birleşik giriş kapısına bağlamanın **bu ilk iş için neden gerekli olduğu**, rakip daha küçük düzenlere göre yeterince açık değil. Bunların her biri gerçek bir ihtiyaç olabilir; tek tek haklı görünmeleri aynı anda bütün işin önkoşulu olmalarını kanıtlamaz.

'Küçük bootstrap' hedefinin yanında giderek özel bir test/başlatma altyapısı inşa edildi. Bu sadece kullanıcının teknik anlamamasıyla açıklanamaz. Önceki G1 incelemesi zaten tek düzeltme sayacının rutin mühendislik işini kullanıcıya geri yüklediğini kabul etmişti. Yeni değerlendirme bunun bir üst sorusunu açık tutuyor: bu birleşik deney yolu ilk anlamlı işe erişim için ne kadar gerekli?

Bu, doğrulanmış tek tarihsel kök neden veya bütün tasarımın reddi değildir. İlk görevleri hazırlayan asistan bu değerlendirmeyi de yapıyor; bağımsız dış hakem değil. Kontrol ihtiyacını inkâr etmek veya başarısız sonuçları silmek çözüm değildir.

## 6. Şimdiki öneri ve durma noktası

G1-R1 kullanıcı tarafından gönderilmedi. Yeni talimat üretmeden, bu konuşmada önce **minimum başlangıç işletiminin kapsamı ve ona orantılı güvence** kararı netleştirilmeli. Olasılıklar: mevcut dar R1'i sürdürmek; normal kaynak/devir işiyle yüksek-etkili kontrol değişikliğini ayrı aşamalara almak; ilgili gstack mekanizmasını yalnız uygun kısmı için kullanmak. Hiçbiri bu kayıtla uygulanmış veya yetkilendirilmiş değil.

Bütün Foundation'ın bitmesini beklemek zorunlu sonuç değil. Aynı şekilde 'bir sonraki bug düzelince her şey yoluna girer' beklentisi de kanıt değil. Sonraki karar, hangi somut yararlı işi açtığı ve hangi tehlikeyi hangi maliyetle engellediğiyle gerekçelendirilmeli.

Eski G0/D1/G1, C1, AGENTS, main ve tüm başarısız/yapılmamış deney statüleri korunur. Bu review yeni aday, parser düzeltmesi, test, ürün mimarisi veya güvence muafiyeti oluşturmaz. Eski R1 brief'i tarihsel bir öneri olarak değişmeden durur; şu an gönderilecek varsayılan görev değildir.

## Kaynak kimlikleri ve sınırlar

- Research main başlangıcı: `af3e5075eb4c2019f3c7195e030961f628a0b4df`.
- Foundation STATE blob `049ec467cd4eccaf814249982b74525dcd3d8abb`; INDEX `87585253995f0eb673b14042636600fcd9394c72`; Control KEY `b88b7c78ce0816ff793fda79f272508f3e7afd18`.
- S1 REVIEW `b788ee43c01dd8f375c5a02274d29191310f5cd3`; G1 REVIEW `527aa6b24543e955d28ce3a7cecb7b383e5415ef`; korunmuş S1 yanıtı ve kullanıcı G1 raporu ilgili önceki dizin/eklerde.
- gstack META `f2ad498742f026aa84578e82ec7fd0cf6843da65`; CORE `94f1457fc536602cb22c4979577ff9e1d4660c5e`; coordination `d08fe28d822b8c77bda3769f5143e2ab23f6b352`; host-portability `dbe09c8ae2c059cb481bae968ba8007d3fb299cf`; v1.80 revalidation `5a6b0a32b8858b4fcfc7f4f881ba15107637bf83`. Son üç dosyada seçili ilgili bölümler kullanıldı; bütün upstream yeniden araştırılmadı.
- Upstream selective current reads at `0530392821c277b95e5cd65aa9d9fda4248718b2`: `bin/gstack-codex-probe` başlangıç/auth/model/version/timeout bölümleri; `hosts/codex.ts` tam (blob `b46e9222495eada3da68debaae6dab6d9d57167c`); `test/codex-hardening.test.ts` 1–150 (blob `e203f1589d3a5ad897ee3ca97e45e23b99bc899f`). Current-main observation is not a whole-repository freshness audit.
