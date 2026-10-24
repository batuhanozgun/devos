# EXP-003 — Konuşmaya özgü terim kullanımları

Ortak sözlük veya concepts kabulü değildir. U001'in yerel adlandırması ve sonraki açıklamalar korunur. Kaynaklar [diyalog dizininde](../sources/conversation/INDEX.md).

| Terim | Bu konuşmadaki işlevi | Korunacak sınır |
|---|---|---|
| Eğitim bilgisi / sabit bilgi | Modelin eğitimden taşıdığı bilgi. | Bu konuşmada 'hafıza' ile karışmasın diye ayrı ad; model geliştirme araştırması yapılmadı. |
| Bağlam | İlgili yanıt/çağrı için erişilebilir bilgi. | Kalıcı depoyla veya bütün agent runtime state'iyle eşitlenmez. |
| Ek hafıza | Eğitim dışında sürdürülen ve sonraki kullanımda geri çağrılabilen bilgi; tartışmanın odaklandığı anlamda bunun yaşamını yöneten mekanizma. | İçerik, taşıyıcı ve yönetim birbirinden ayrılmalı; zorunlu dosya biçimi yok. |
| Yaratmak / okumak / düzenlemek | Kalıcı bilgi yüzeyine yöneltilen geniş işlem kümeleri adayı. | Tam üç zorunlu primitive bulunduğu kanıtlanmadı. |
| Mekanizma / yönetim | İşlemlerin amaç, koşul, sıra, hedef ve bilgiye göre örgütlenmesi. | Aynı seviyede dördüncü depolama işlemi değil. |
| Dosya / içerik / bilgi | Taşıyıcı kimliği, metin/byte dizisi ve onun yorumlanan anlamı için ayrı analiz düzeyleri. | Her cümle bağımsız atomik fact değildir; anlam ve eşdeğerlik bağlama bağlıdır. |
| Bilginin varlığını bilmek | Ayrıntıyı yüklemeden bir erişim/yönlendirme temsiline sahip olmak. | Kaydın bulunması, erişimi, geçerliliği ve fiilî kullanımı aynı değil. |
| Katman / kategori | Seçici erişim ve düzenleme için kullanıcı sezgisi. | Tek ağaç, zorunlu üç katman veya graph database seçimi değil. |
| Sağlam / stable / yıpranmayan | Kullanım değerinin, anlamın ve sürekliliğin değişim boyunca korunması hedefi. | Sıfır hata, her hatayı tespit veya mutlak geri alınabilirlik garantisi değil. |
| Marjinal fayda | Yeni araştırmanın eldeki bilgiye ve sonraki tercihlere eklediği değer sorusu. | S009/S010 yüzdeleri bir ölçüm değildir; toplamsal kaynak puanı kullanılmaz. |
| En iyi yapı | U011'de gelecekte araştırma ve uygulamayla ulaşılmak istenen yeterlilik iddiası. | Bugünkü başarı, evrensel üstünlük veya seçilmiş mimari değildir. |

`Formation/Derivation/Selection/Exposure/Records` bu diyalogda Foundation araştırmasına geri dönüş yolları olarak kullanılır. Create/read/revise ile bire bir eşleme, servis ağacı veya her kayıtta zorunlu metadata alanları üretmez.
