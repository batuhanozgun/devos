# EXP-004 / T10 — Yeni katılım, etki yolları ve denetim kapsamı

**Tarih:** 2026-09-21. **Tür:** T09 sonrasındaki kavramsal devamın türetilmiş çalışma kaydı; tam konuşma transkripti değildir. **Yetki:** Kullanıcının «Test bizi çok titiz bir yapıya doğru götürüyor, bu çok iyi. Devam et lütfen.» mesajı. **Kapsam:** Aynı büyük soru-bankası programına yeni aktör, araç veya yürütme yolu katıldığında ortak yükümlülüklerin fiilî kapsamı. Canlı ajan, yayın, güvenlik saldırısı, deney veya SOUL prototipi çalıştırılmadı.

## 1. Devralınan nokta

[STATE](../STATE.md), [INDEX](../INDEX.md) ve [T09](T09-CONCURRENT-CHANGE-AND-SHARED-CONSTRAINTS.md) tam geri okundu. Bilinen kaynak onarımı kapalıdır; eski kaynak kesimi ve manifest değiştirilmez. T09 yerel uygunlukların ortak uygunluğu, tekil hazırlığın ortak kaynak taahhüdünü, güvenli uç durumların güvenli geçişi garanti etmediğini gösteren kurulu karşıörnekler taşıyordu.

T10'un sorusu: Sisteme yeni katılan parça işini yapabiliyor olsa da, mevcut kalite/bilgi/yetki/kaynak/süreklilik yükümlülükleri bu yeni katılımda gerçekten işler mi? U016'nın yeni işlevlerle mevcut işlevlerin kapsamının birlikte genişlemesi açıklaması kullanılır; bu açıklama teknik kanıt, tek merkezî denetleyici veya klasör/servis şeması değildir. Kullanıcının titizlik yönündeki olumlu değerlendirmesi kontrol sayısını artırmanın doğruluğuna kanıt sayılmaz.

## 2. Kurulu vaka: eski kontrol bozulmadan kapsam dışında yeni yol

Programın eski yolu: metin soru üretimi → uygun bağımsız kontrol → ilgili sürüme bağlı yayın kabulü → yayın aracı. Bu örnekte korunacak koşul, ilgili soru sürümünün gereken kontrol ve kabulü olmadan öğrenciye yayımlanmamasıdır. Kontrolün yapılması kusursuz matematiksel/pedagojik doğruluk kanıtı sayılmaz.

Yeni görsel-düzenleme aktörü, soruları diyagram ve çalışma sayfasına dönüştürür. Kullandığı yeni aracın çıktıyı doğrudan yayın alanına aktarma yolu olduğunu varsayıyoruz. Eski yayın aracındaki kontrol aynen çalışmaktadır; yeni yol ondan geçmemektedir. Böylece eski kontrolün bütün yerel testleri geçerken yeni yol üzerinden denetimsiz çıktı yayımlanabilir.

Bu, gözlenmiş ürün olayı değil, açıkça kurulmuş mantıksal karşıörnektir. Yeni aktör kötü niyetli olmak zorunda değildir. Yakın neden yeni yayın yolunun kontrolü atlamasıdır; vaka içindeki daha genel açık, parçanın kendi iş başarısını sisteme katılım yeterliliği sayıp etki yollarını kapsama değerlendirmesine almamaktır. Gerçek olayda bu teşhis ayrı iz/kanıt gerektirir.

Yeni klasörü dosya taramasına eklemek bu örneği tek başına çözmez. Çıktı hiç o klasörden geçmeyebilir; bir servis, başka aktör veya yayın kanalına aktarılabilir. Korunan soru «bu dosya tarandı mı?» değil «ilgili çıktı hangi yollarla kullanıcıya ulaşabilir ve bu yollarda yükümlülük nasıl karşılanıyor?» olur.

## 3. Aynı yükümlülük, aynı kontrol tekniği demek değil

Metin için yeterli kontrol, görsel çıktının kesir çizgisini, eksi işaretini veya diyagram-yanıt ilişkisini koruduğunu göstermeyebilir. Bu, gerçek bir müfredat/ürün bulgusu değil, biçim dönüşümünün hangi iddiayı değiştirebileceğine ilişkin kurulu varyanttır. T6'nın nesne/sürüm/kriter sınırı burada yeni tüketim biçimine uygulanır.

Yükümlülüklerin ilgili yeni çıktılara uygulanması ile eski bütün kontrollerin aynen kopyalanması ayrıdır. Mevcut kontrol yeterli olabilir, uyarlanması gerekebilir, farklı kontrol gerekebilir veya belirli iş için ilgisiz olabilir. Geçerli kanıt uygun kapsamda yeniden kullanılabilir; her değişiklikte tüm ürünü baştan denetleme kuralı konmaz.

Kapsama genişlemesi veri erişimini de sınırsız genişletmez. Örneğin görsel düzenleme için sorunun içeriği gerekebilir, öğrenci kimliği veya bütün çalışma geçmişi gerekmeyebilir. Dış hizmete bilgi gönderme varsa bu veri akışının kapsamı ayrıca değerlendirilir. Bu bir hukuk/telif tavsiyesi veya gerçek öğrenci verisi işleme kararı değildir.

## 4. Dolaylı etki ve meşru delegasyon

Yeni aktörün yayın aracı yokken yayın yapabilen başka bir aktöre talep gönderebildiğini varsayalım. İkinci aktörün talebi gerekli kabulü kontrol etmeden uygulaması aynı etki açığını başka yoldan yaratır. «Doğrudan yayın yetkisi yok» bu bileşimin güvenli olduğuna yeterli kanıt değildir.

Meşru delegasyon yasaklanmıyor: ikinci aktör kendi geçerli yetkisi altında talebi değerlendirebilir ve gerekli şartlar karşılanmışsa gerçekleştirebilir. Talebin gelişi, yetki veya kabul yerine geçmez. Yeni alt aktör oluşturma da üst aktörün bütün erişimlerinin otomatik kopyası değildir. Uygulanabilir kısıtlar/kanıt yükümlülükleri ile verilmiş etki yetkisi ayrı tutulur.

Anthropic'in doğrudan yeniden açılan birinci taraf anlatısı, model güncellemesinden sonra olay-müdahale aktörünün Slack üzerinden daha güçlü başka bir aktörden düzeltmeyi göndermesini istediğini; insan inceleme kapısının bunu yakaladığını bildiriyor. Bu, üretime denetimsiz geçişin gerçekleştiği veya SOUL'un bütün delegasyonunun güvensiz olduğu kanıtı değildir. İletişim erişiminin etki sınırına dahil edilmesi için somut karşıörnek sağlar.

MCP güvenlik rehberindeki token-passthrough uyarısı da bağlantı/kimlik aracısının aşağı akışta kendiliğinden uygun yetki ve denetim sağlamadığını gösteren dar teknik örnektir. MCP veya bir token modeli seçilmiyor; protokol yetkilendirmesi iş sonucunun doğruluğu/kabulüyle eşitlenmiyor.

## 5. Oluşturma ile kapsamlı kabul ayrılır

Yeni aktör veya aracın kurulması, ilgili görevlerde yetkinliği, çalışma ortamına erişimi ve belirli etkilere kabulü farklı standing'lerdir. Tek bir global «güvenilir aktör» bayrağı yerine, mevcut iş/rol/araç/yol/çıktı/veri/sürüm için neyin kabul edildiği sorulur. Her boyut için zorunlu fiziksel alan veya yeni Activation Case ilan edilmiyor.

Bu vaka için aday süreç:

- Yeni yeteneğin sağlayacağı iş ve erişebileceği doğrudan/dolaylı etkiler belirlenir; bilinmeyen yollar işaretlenir.
- İlgili kalite, yetki, veri, kaynak, iz ve kurtarma sorumlulukları mevcut düzene bağlanır.
- Yeni aktör uygun sınırlı ortamda taslak üretir; canlı yayın gücü başlangıçta verilmek zorunda değildir.
- Doğru akışın çalışması yanında yanlış/eksik kabulün kritik etkiye dönüşememesi sınanır.
- Geçerli kapsam ve gerçek tüketici/etki yolu yeterince gösterilirse o kapsam etkinleştirilir; maddi değişimde yeniden değerlendirilir.

Bu, bütün SOUL'u sürekli tek insanın onayına bağlayan evrensel süreç değildir. Güvenilir mevcut sınırı gerçekten kullanan yeni katılım, aynı denetimi yeniden kurmak yerine uygun kanıtı yeniden kullanabilir. Yeni kaynak tanıtma, alt aktör yaratma, yeni yayın hedefi veya fallback ekleme gibi maddi farklar salt ad/sayı artışı değildir.

## 6. Kapsanan, uygulanan ve gözlenmiş olan

Üç soru ayrılır:

1. Hangi etkiler, yollar, nesneler ve çalışma kipleri yükümlülüğe tabidir?
2. Bunların hangisinde uygun kontrol fiilen uygulanır?
3. Bunların hangisi için gözlem/sınama kanıtı vardır ve bu kanıt neyi gösterir?

«Eski yayın aracına gelen 100 isteğin 100'ü incelendi» doğru olabilir. Yeni yoldan gelen 20 çıktı bu aracın kaydına hiç girmiyorsa bunun bütün yayınların denetlendiği diye okunması yanlıştır. Sayılar yalnız örnek; ölçüm yoktur. Denetleyicinin kendi gördüğü olayları payda yapması, görmediği yolları tespit etmez.

Etki alanındaki gerçekleşmiş çıktılar ve çalışma yollarıyla karşılaştırma, iz boşluğu/kapasama açığı bulabilir; bunun gözlem erişimi, kapsamı ve bağımsızlık sınırı ayrıca korunur. Bilinmeyen yol yokmuş gibi %100 kapsam iddiası üretilmez. Varlık → uygulanma → test geçişi → gerçek fayda ayrı kalır.

## 7. Yaşam döngüsü ve uygun sınırlama

Normal iş akışı yanında toplu işlem, retry/fallback, yeniden başlatma, gecikmiş kuyruk işi, bakım veya insan tarafından taşıma gibi kapsam-içi yollar yükümlülüğü kaldırmaz. Bunlar yeni birer ürün talebi değil, korunmak istenen etkinin yolu değişebildiğine ilişkin karşı durumlar. Eski onay/kontrol sürümü veya iptal edilmiş yetki yeniden kullanımda otomatik güncel sayılmaz.

Saltzer–Schroeder'in complete mediation ilkesi erişim kontrolünü başlangıç, kurtarma, kapanış ve bakım dahil ele alır; ekonomi ve asgari yetki ilkeleri de daha fazla mekanizmayı otomatik daha iyi saymamayı destekler. Bu erişim-güvenliği ilkelerinin kalite/kapsam problemimize uygulanması burada yapılan analojidir; tüm SOUL doğruluğunu o makale kanıtlamaz.

Kontrol hizmeti erişilemiyorsa her işin durması veya kontrolün sessizce atlanması tek seçenekler değildir. Vakamızda canlı yayın bekletilirken, güvenli sınırları gerçekten kurulmuş taslak üretimi veya ilgisiz araştırma sürebilir. Yetkili, kapsamlı ve izlenebilir bir alternatif varsa kullanılabilir; kapasite eksikliği zorunlu kabul koşulunu kaldırma izni vermez. Dış yol denetlenemiyorsa erişimi sınırlama, başka yol, uygun insan/dış kontrol veya açık «bu etki bu düzenle desteklenmiyor» sonucu gerekebilir. Her şeyi kaydetme de gizlilik/maliyet açısından otomatik çözüm değildir.

## 8. Kırmızı ve yeşil karşı durumlar — yürütülmedi

| Kimlik | Kurulu karşı durum | Beklenen ayrım |
|---|---|---|
| C10-1 | Kabul eksik çıktı eski veya yeni yayın yolunda | Korunan yayına geçmemeli; sadece eski yolu sınamak yetmez. |
| C10-2 | Güncel uygun kanıt/kabul ve yetkili yol mevcut | Geçerli yayın mümkün olmalı; bütün yeni katılımlar reddedilmemeli. |
| C10-3 | Onay metin sürümüne ait, görsel dönüşüm maddi içeriği değiştirmiş | Eski onayla yeni iddia/sürüm otomatik geçmemeli. |
| C10-4 | Yetkisiz aktör, başka aktöre yayın talebi gönderiyor | Talep kabul sayılmamalı; geçerli delegasyon ise şartlarıyla mümkün. |
| C10-5 | Normal yol güvenli, retry veya bakım yolu denetimsiz | Aynı yükümlülük ilgili alternatif yolda da korunmalı. |
| C10-6 | Kontrol servisi yok; taslak ortamı gerçekten yalıtılmış | Canlı etki beklerken güvenli kapsam ilerleyebilmeli. |
| C10-7 | İzler yalnız eski yola ait | Tüm sistem için kapsam/fayda iddiası verilmemeli. |
| C10-8 | Yeni yol aynı uygun zorunlu etki sınırından geçiyor; kapsam değişmiyor | Gerekçeli mevcut güvence yeniden kullanılabilmeli, kör mükerrer kontrol eklenmemeli. |

Bunlar kasıtlı seçilmiş mantıksal/operasyonel sınama şartlarıdır. Çalışan kod, canlı ajan veya bağımsız deney bu kontrollerden geçirilmedi. Yeni aktörün beyanı tek başına etkin sınır veya test sonucu değildir.

## 9. Modele katkı ve sonraki sınır

T10'un katkısı «daha fazla kontrol» değil, yeni katılımın yalnız işlevsel değil, ilgili ortak yükümlülükler bakımından da kabul edilmesidir. Yeteneğin kurulması, kontrollerin kopyalanması ve gerçek kapsama eşitlenmez. U016'daki mevcut işlevin yeni katılımı kapsaması açıklaması için daha somut ihtiyaçlar ortaya çıktı; fiziksel merkezileşme veya tüm bilginin herkese açılması sonucu çıkmadı.

Sistem sınırı, kabul edilebilir etkiler, denetlenebilen yollar ve kalan belirsizlik görünür olmalı. Kabul edilen katılım sürekli değişebilir; otomatik kalıcı güvenilirlik belgesi değildir. T10 yeni bir Foundation ground veya zorunlu servis/şema ilan etmez; geniş kategorilere yerleştirmenin uygulama yeterliliği olmadığını korur.

Bir sonraki doğal karşı-test, doğru kontrolleri korurken araştırma/denetim yükü nedeniyle işin hiç bitirilememesidir: hangi kanıt ne zaman yeterli, hangi iş öncelikli, hangi gecikme kabul edilebilir, hangi karar mevcut yetkiyle kapanabilir? Bu soru burada çalıştırılmadı. Ardından modelin farklı büyük-domain karşı testine taşınması hâlâ açıktır. Kullanıcının devam yönü bunları uygulama/ürün seçimi yetkisine dönüştürmez.

## 10. Kaynaklar ve okuma kapsamı

Repository başlangıç main: `7de46ddbae29366cb4338b41f57d844a611a43d8`.

- EXP-004 STATE, INDEX ve T09: tam okuma; T09 uzun ilk yanıtı 75–140 aralığıyla tamamlandı. Güncel kullanıcı yönü ve aynı konuşmada görünür U016/T08 bağlamı kullanıldı.
- `research/studies/CATALOG.md`: 1–46 satır seçici keşif, tüm katalog/studies okuması değil.
- `research/studies/anthropic-ai-native-sdlc-playbook/META.md` (`7e89a64f594c989453195931388d57657ee9d0f7`) ve STATE (`522d1d874e3a194849885182b33666c7117e03d1`): tam. Araştırma 2026-09-04 tarihli bounded candidate çalışmasıdır; genelleyici üstünlük/ürün performansı iddiaları bu tura taşınmadı. Önemli transitive-etki örneği doğrudan birinci taraf kaynakta yeniden açıldı.
- `research/soul-foundations/05_relation-control-composition/control-constraint/STATE.md` (`fdbf3fe6973cd3bc982d394993a3309eb7178049`): tam. Korunan etki/uygulama noktası, yetki/karar/uygulama/iz ayrımları. Kapalı araştırma yeniden başlatılmadı.
- Anthropic, [How Anthropic secures its AI-native software development lifecycle](https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle): 2026-09-21 erişimi; özellikle Monitor ve Governance, yaklaşık satır 332–365. Aktörden aktöre erişim örneği birinci taraf anlatısıdır, bağımsız tekrar değildir; insan kapısının yakaladığı olay yayımlanmış yetkisiz değişiklik diye sunulmaz. Üretkenlik oranları/ürün vaadi kullanılmadı.
- Saltzer & Schroeder, [Basic Principles of Information Protection](https://web.mit.edu/Saltzer/www/publications/protection/Basic.html): 2026-09-21 erişimi; özellikle §I.A.3 complete mediation, economy of mechanism, least privilege ve ilkelerin mutlak kural olmadığı sınır. HTML okuması; tüm makale/figür/PDF okuması değil. Dar güvenlik ilkesinden genel kaliteye geçiş exploration çıkarımıdır.
- MCP [Security Best Practices](https://modelcontextprotocol.io/specification/2025-11-25/basic/security_best_practices): 2026-09-21 erişiminde `docs/2025-11-25/tutorials/security/security_best_practices` yoluna yönlendi; özellikle Token Passthrough bölümü, satır 180–208. Amaç/audience denetlenmeden token iletmenin kontrol ve iz sorunları. Tüm protokol denetimi, güncel ürün garantisi veya MCP adoption yok.

Dış kaynak araması narrow primary-source check'tir; yeni candidate study veya kapsamlı security research kampanyası değildir. Agent-control dosyaları araştırma delili olarak kullanılmadı.

## 11. Süreklilik ve yayın

Bu not ile güncel STATE/INDEX ve explorations INDEX/CATALOG, dar bir değişiklikte güncellenir. Kaynak gövdeleri, kaynak sayımı/manifest, onarım kayıtları, T1–T9 eserleri, Foundation, studies, concepts ve agent-control değiştirilmez. Git nesnesinin oluşturulması ile main'e yayın ve geri okuma farklıdır; kendi gelecekteki commit'inin veya yapılmamış kontrollerin kimliği burada üretilmez. Yeni devam notu tam mesaj arşivi sayılmaz.
