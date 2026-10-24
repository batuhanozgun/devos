# EXP-002 — Terimlerin konuşmadaki geçici anlamları

Bu belge teknik standart sözlüğü değildir. Terimin bu konuşmada neyi işaret ettiğini ve nerede açık kaldığını korur. Özellikle kullanıcı [U009–U010](../sources/conversation/USER-MESSAGES.md#u009) ile “agent” kelimesinin bazen rolü, bazen dosyalardan oluşan yapıyı anlattığını belirtti. Sonraki yorumlar yalnız kelimeye değil işleve dayanmalıdır.

| Terim | Konuşmadaki kullanım | Kaynak / açık sınır |
|---|---|---|
| SOUL | İstenen sonuca yönelik çalışma sistemini anlayan, kuran, işleten, gözleyen ve uyarlayan aday bütün | S006; kapsam ve gerçek mimari açık. |
| Development OS | SOUL'u araştırma, tasarlama, geliştirme ve doğrulama gibi daha dar amaca yönelik gerçek çalışma düzeni | U018/S018; bu tanım actual kurulum state'i değildir. |
| Baz SOUL | Belirli kullanıcı talebinden önce mevcut çalışma zemini ve kurma kabiliyetleri | U011/S011; ayrı ürün, küçük çekirdek veya sabit rol listesi seçilmedi. |
| Çalışma sistemi | İşler, aktörler, bilgi, ortam ve bunlar arasındaki yetki/bağımlılık/kontrol/etki ilişkileriyle birlikte düşünülen düzen | S006–S008/S015; nihai veri modeli değil. |
| System Formation / Work-System Synthesis | Amaca uygun çalışma düzenini keşfetme ve oluşturma kapasitesi için geçici ad | S007; zorunlu tek ajan/modül değil. |
| Model | Akıl yürütme ve diğer kapasitelere katkı sağlayan temel model; S010'da daha kısa anlatıldı | Model, rol veya çalışan sistemin tamamıyla eşit değil. |
| Actor / aktör | Bir çalışma sorumluluğunu üstlenen katılımcı/birim | S004/S010; somut model, insan veya başka yürütme biçimi ayrı belirlenir. |
| Role / rol | Belirli sorumlulukla hangi katkının yapılacağı | S004; sadece unvan değildir. |
| Role-instance | Belirli iş/amaç/yetki/bağlam altında somut üstlenilen rol için kullanılan ifade | S003–S004; evrensel nesne şeması seçilmedi. |
| Identity / rol kimliği | Rolün hangi çalışma yönü ve sınırlarla hareket ettiğini belirtmek için kullanıldı; daha geniş kimlik kapsamı açık bırakıldı | S004/S011; authentication kimliğiyle otomatik eşitleme yok. |
| Agent | Kullanıcının bazen aktör, bazen rol, bazen model+dosya+araç+yetki bütününü anlatan geniş kelimesi | U009/S009; belirli agent framework tanımı dayatılmadı. |
| Terminal motivasyon / terminal amaç | Rolün başarı yönü; fonksiyon sayısı veya beceri puanı değil | U003/S003, S013; tek hedefin güvenilirlik sağladığı kanıtlanmadı. |
| SOUL-native intellectual baseline | Bütün akıl yürüten rollerde arzulanan yüksek ortak entelektüel çalışma standardı | U012–U014/S012–S014; geçici ad, benchmark veya parametre eğitimi değil. |
| Role-specific competence | Rolün alanına özgü yeterlilik profili | S013–S014; genel becerilerden tamamen bağımsız ayarlanabildiği gösterilmedi. |
| Intellectual inheritance / kurumsal bilgi / çalışma kültürü | Araştırma birikimi, ayrımlar ve nerede nasıl kullanılacağını bilme eğiliminin yeni aktöre taşınması düşüncesi | U012/S012/S017; aktarım mekanizması ve etki kanıtı açık. |
| Internalized core / recoverable deep knowledge | Başlangıçta etkin olması istenen temel anlayış ile gerektiğinde geri çağrılan derin kaynak ayrımı | S012; “internalized” teknik olarak fine-tuned demek değil. |
| Harness | Model/aktörün araç, bağlam, kayıt ve kontrol altında çalışmasını mümkün kılan dış düzen olarak kullanıldı | S007/S011/S016; SOUL buna indirgenmedi; kendi harness'ı olabilir. |
| Context / memory | Şimdiki çalışma bağlamı ile zamanlar arası bilgi/kayıt yaşamının farklı yönleri | S012/S016; tek başına context kapasitesi kalıcı bellek kabul edilmedi. |
| RAG / KG / fine-tuning / CAG / long context | Bilgiyle çalışma seçeneklerine ilişkin araştırma örnekleri | U008/S008/S016; aynı problemi çözen, birbirini dışlayan eşdeğer seçenekler değildir; seçim yapılmadı. |
| Authority / capability | Yetkili olma ile fiilen yapabilmenin farklı yüzleri | S004/S015–S016; yönergeyi veya araç erişimini tek başına yeterli saymama. |
| Verification / observability | Doğruluğu değerlendirme ve fiilî çalışma hakkında görünürlük kazanmanın farklı sorumlulukları | S003/S011/S016; gözlem, doğruluk veya bağımsızlık garantisi değildir. |
| Workspace / sandbox | Çalışmanın yaşayacağı alan ve etkilerin sınırlandırılmasına ilişkin örnekler | S011/S016; workspace varlığı izolasyon kanıtı değil. |
| Work state / continuity / recovery | Neyin yapıldığını, yarım kaldığını, hangi sorumlulukla nereden devam edileceğini koruma ve geri kazanma | S008/S011/S017; somut store/scheduler seçimi yok. |
| Loop engineering / graph engineering | U001'in başlık adayları | Ayrı tam açıklama yapılmadı; graph yapısı, loop sözleşmesi veya bir ürün seçilmedi. |
| Goal maintenance / tool selection / policies | Başlangıçta sayıldı; amaç, araç/yetki ve çalışma düzeni içinde kısmen konuşuldu | Tam mekanizma tarifleri tamamlanmadı. |

## Kaynağa dönüş

[S004](../sources/conversation/assistant/S004.md) → rol ayrımı; [S009](../sources/conversation/assistant/S009.md) / [S010](../sources/conversation/assistant/S010.md) → terim uyarısı; [S012](../sources/conversation/assistant/S012.md) → birikim; [S013](../sources/conversation/assistant/S013.md) / [S014](../sources/conversation/assistant/S014.md) → üç eksen; [S016](../sources/conversation/assistant/S016.md) → araştırma terimleri. Yeni EXP bu anlamları açık gerekçeyle değiştirebilir.
