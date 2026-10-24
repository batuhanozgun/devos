# EXP-002 — Yeniden kullanım nitelendirmeleri

**Statü:** Konuşmayı arşivlerken yapılan assistant değerlendirmesi. Bunlar özgün U/S mesajları veya kullanıcının önceden kabul ettiği yeni kararlar değildir. Kaynak metinler değişmeden tutulur. Amaç konuşmanın canlı, bazen kesin üslubunun sonraki oturumda kanıt veya tasarım zorunluluğuna dönüşmesini önlemektir.

## Q01 — Tek amaç güçlü bir çalışma sezgisi; güvenilirlik teoremi değil

U002–U004 / S002–S004'te savunulan ayrım, bir rolün kapanış teşvikiyle kendi doğrulamasını bozmasını önlemeyi hedefler. Bu konuşma tek terminal amacın drift için yeterli olduğunu veya her durumda birden çok hedefin yanlış olduğunu sınamadı. Amaçların açıklığı, yetki, girdiler, kabul ölçütleri ve gerçek çalışma koşulları ayrıca önemini korur. Aynı fikre birlikte katılmak bağımsız kanıt değildir.

## Q02 — Verifier'ın amacı ret sayısını veya gecikmeyi artırmak olmamalı

S003'teki “kabul edilmemesi için neden ara / yanlış olan şeyi bul” dili, üretimin kapanış baskısından ayrılmış araştırıcı yönü anlatıyor. Bunu literal ödül tanımına çevirmek, geçerli ürüne itiraz üretmeyi başarı sayma riskini taşır. Kanıt desteklediğinde olumlu hüküm, kusur olduğunda olumsuz hüküm, yeterli kanıt yokken sınırlı hüküm mümkün kalmalıdır. Bu cümle arşivleme değerlendirmesidir; yeni verifier protokolü veya benimsenmiş kriter değildir.

Benzer şekilde builder'ın üretime yönelmesi, hızın doğruluk ve güvenlikten üstün seçilmesi anlamına gelmez. Kullanıcının örneği iki çalışma yönünü ayırır; kalite yükümlülüğünü üreticiden silmez.

## Q03 — Rol ayrımı bağımsız doğrulamayla eşit değil

Farklı rol, taze çağrı veya farklı isim, aynı varsayım/kaynak/yanılgıların paylaşılmasını dışlamaz. Ortak SOUL kültürü de ortak kör noktaları taşıyabilir. Konuşmada maker/verifier ayrımı arzulandı; bağımsızlık, oracle uygunluğu veya hata yakalama etkinliği deneyle gösterilmedi. Testlerin geçmesi de sınanmayan bütün özelliklerde hatasızlık iddiası değildir.

**Kaynak bağları:** [S003](../sources/conversation/assistant/S003.md), [S004](../sources/conversation/assistant/S004.md), [multi-agent referansı](../sources/RESEARCH-REFERENCES.md).

## Q04 — Çalışma düzeni, kullanıcının sonucunu ikame etmemeli

S006'da “temel ürün çalışma düzenidir” denmesi SOUL'un araç/organizasyon kurma kapasitesini vurguluyordu. Kullanıcı ABC istediğinde yalnız iyi bir ekip veya harness teslim etmek ABC'nin gerçekleştiği anlamına gelmez. Üretim sisteminin kalitesi ile onun kullanıcıya sağladığı sonuç ayrı değerlendirilmeli. System Formation ifadesi merkezileşmiş tek yönetici zorunluluğu da üretmez.

## Q05 — Anlama ve kurma ayrı işlerdir; bütünsel seri kapı değiller

S007–S008'deki oklar, zorunlu global sıra gibi okunmamalı. EXP-001'de C'nin tamamen bitmesini beklemeden başlanabilir sınırlı işler ayrılmıştı. Yeni ekip problem keşfini sürdürürken başka bir iş başlayabilir. Her yeni bilgi bütün sistemi yeniden kurmayı veya yeni aktör eklemeyi zorunlu kılmaz.

## Q06 — Baz yapı listesi ve küçüklük önerisi açık

S011'in “küçük ama güçlü çekirdek” ifadesi ölçülmüş optimum veya kullanıcı tarafından seçilmiş mimari değildir. Aynı cevap hem baştan uzman bulundurmayabileceğini hem bazı sabit iç rollerin bulunabileceğini söylüyordu. Hangi doğrulama, keşif ve kurma sorumluluklarının baştan bulunacağı çözülmedi. Kimlik/registry/memory/observability başlıklarının ayrı servisler, dosyalar veya ajanlar olması da kararlaştırılmadı.

EXP-001'in mesleki standart vurgusu, küçük işi düşük standartla ele almayı dışlayan bir kullanıcı yaklaşımıdır. Gereken yapının kapsamını incelemek ile baştan “az mekanizma daha iyidir” demek aynı şey değildir.

## Q07 — Entelektüel mirasın istenmesi, aktarıldığını göstermiyor

U012–U014 / S012–S014, bilgiye erişimin ötesinde farkındalık ve kullanım eğilimi istedi. “Internalized”, “SOUL-native” ve “kültür” bu ihtiyacı adlandırdı; model ağırlıklarının eğitildiği veya her role kalıcı yetkinlik geçtiği gösterilmedi. Dosya okuma, bağlam oluşturma ve model eğitimi eşdeğer teknik işlemler sayılmamalı.

Bütün verinin bütün aktörlere açılması da bu hedefin gereği değildir. Rol için ilgili ve izinli bilgi ile ortak genel çalışma standardı ayrı düşünülür. Bu konuşma erişim modeli seçmedi.

## Q08 — Futbolcu kartı ne ölçüm ne beceri bağımsızlığı iddiası

9/10 vb. değerler anlatım aracıydı. Genel ve uzmanlık becerilerinin birbirinden tamamen bağımsız ayarlanabildiği gösterilmedi. Bir güvenlik rolü için kod üretimi ikincil olabilir; bu, işin gerektirdiği kod anlama veya sistem bilgisinin gereksiz olduğu anlamına gelmez. Ortak yüksek entelektüel taban hedefi akıl yürüten rollere ilişkindir; deterministik servis ve araçların hepsine aynı nitelik yüklenmez.

## Q09 — Çözüm adları aynı sınıflandırma ekseninde değil

S008'de RAG, retrieval, knowledge graph ve long context yan yana anıldı. Bunları birbirini dışlayan eşdeğer seçenekler gibi almak doğru bir çıkarım olmaz. Konuşmadaki amaç belirli teknolojiye erken kilitlenmemekti. [İlgili research paketi](../../../research/studies/ai-knowledge-strategies/META.md) mekanizmaların farklı sorunları ele aldığı ve birleşebildiği sınırını taşır. Bu arşiv yeni teknik karşılaştırma yapmadı.

## Q10 — Araştırma birikimi ve fiilî doğrulama aynı şey değil

S015–S017'nin “güçlü / orta / zayıf” gibi hükümleri kavramsal değerlendirmeydi; readiness benchmark'ı veya bütün research corpus'un yeniden tam audit'i değildi. gstack gibi kaynakta uygulanmış mekanizmaları okumak, SOUL'da uçtan uca çalıştırma değildir. Studies birbirini aynı temel kaynak üzerinden destekliyorsa bağımsız kanıt sayısı kendiliğinden artmaz.

## Q11 — Development OS ilişkisinde bootstrap ve genelleme sınırı

U018/S018'de dar üst amaç, Development OS'u başlatmayı daha yönetilebilir kılan bir düşünce olarak ele alındı. Dar amacın tek başına başarılı kurulum sağlayacağı veya bir modelin başlangıç kapasitesinin yeterli olduğu doğrulanmadı. Development OS'un SOUL'u geliştirirken üreteceği deneyim başka kullanım alanlarına otomatik genellenmez. Kendi düzenini değiştirmek, kendi yetkisini veya owner hedefini kendiliğinden değiştirmek değildir.

“İleride yaratmaya başlayacağız” yönü, daha önceki Codex/Development OS çalışmalarının yok sayılması veya yeniden başlatılması anlamına gelmez. Güncel actual state ve yetki, ilgili repository ve [context girişinde](../../../research/soul-context/STATE.md) ayrıca geri kazanılır.

## Q12 — Kaynak sadakati ve adlandırma sınırı

Konuşmadaki model/mod adları, tarihli ürün bilgisi veya seçilebilir arayüz özelliği için kanıt değildir; kaynak metni koruma amacıyla tutulmuştur. “Model = akıl yürütme kapasitesi” ve “rol kimliği” gibi ifadeler de bu sohbetin yardımcı tanımlarıdır; tam ontoloji değildir. U001'de adı geçen loop/graph engineering dahil bütün terimler işlenmiş sayılamaz.

Bu nitelendirmeler yeni araştırma görevi, agent-control değişikliği veya mimari kararı yaratmaz. Sonraki deneme bunları da sorgulayabilir.
