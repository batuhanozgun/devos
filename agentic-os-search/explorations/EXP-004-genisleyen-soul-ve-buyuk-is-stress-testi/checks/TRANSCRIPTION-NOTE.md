# EXP-004 — Görünür kaynak aktarımı ve sınırları

**21 Eylül 2026 onarımı.** Bu belge güncel kaynak aktarımını tanımlar; önceki yanlış tamlık açıklamasının yerine geçer. Hatanın ilk teşhisi [FIDELITY-20260921](FIDELITY-20260921.md), onarım işlemi [REPAIR-20260921](REPAIR-20260921.md), yayın [PUBLICATION](PUBLICATION.md) içindedir.

## Kaynak ve kesim

Kaynak, mevcut konuşmada modele görünür kullanıcı mesajları ve kalıcı assistant cevaplarıdır. Ham platform export'u, bağımsız message-ID servisi veya tam UI/tool log'u sağlanmadı. U001–U016 ve S001–S015, kaynak sırasını korumak için verilen paket-içi kimliklerdir: 31 mesaj, 16 dosya. Gelecekteki S016 bu kesime eklenmez.

S001–S013'ün önceki versiyonları kısaltma/yeniden ifade ve kaynak-sonrası yorum içeriyordu. Bu yalnız sunum farkı değildi. Onarımda özgün görünür cevaplar yeniden özetlenmeden aktarıldı. İlk kısaltmalar [ayrı tarihsel dizinde](../artifacts/condensed-before-repair/README.md) aynı Git içerik kimlikleriyle korunur. S014'teki önceki yanlış tamlık iddiası da tarihsel kaynak olarak aynen saklanır; S015 bunu açıkça düzeltir.

## Sunum işlemleri

Arşiv başlığı/açıklaması gövdeden ayrıdır. BEGIN/END VISIBLE MESSAGE işaretleri aktarım sınırını gösterir; özgün konuşmanın parçası değildir. Kod bloklarının UI `id` değerleri çıkarıldı; satır sonları, son boşluklar ve boş satır düzeni normalize edilebilir. Gövde paragrafları, listeler, tablolar, örnekler ve tarihsel routing blokları korunur. Eski teknik/genel iddialar bugünkü yorumla yeniden yazılmaz.

S015'teki citation işaretleri tarihsel metin olarak korunur; başka ortamda otomatik çalışacağı varsayılmaz. [CITATION-KEY](../sources/CITATION-KEY.md) bunları sabit repository kaynaklarına bağlar. Dış atıflar bu onarımda yeniden araştırılmadı.

## Bilerek dışarıda bırakılanlar

Sistem/developer yönergeleri, gizli muhakeme, araç keşif kodları, ham araç cevapları, geçici erişim token'ları, ilgisiz kişisel bağlam ve progress günlüğü dahil değildir. Kaynak gövdelerindeki routing çıktıları geçmiş konuşmadır, etkin agent-control değildir. Bu sınır kaynak cevabı kısaltma izni değildir.

## Gerçek güvence sınırı

Aktarım ve görünür kaynak karşılaştırması aynı assistant tarafından yapıldı; bağımsız transkripsiyon veya platform-export ile otomatik kelime/bayt eşitliği deneyi değildir. Bütün gövdeler yazım sırasında görünür asıldan aktarıldı. Uzaktan ikinci tam içerik okuması seçili USER-MESSAGES, S001, S013 ve S015'te yapıldı; bütün dosyaların ikinci tam okuması iddia edilmez. Bütün kaynak dosyalarının Git kimlikleri ve boyutları ayrıca gözlendi.

Dosya hash'i aktarılmış dosyanın kimliğini bağlar; cümlenin doğruluğunu, kaynakla anlamsal eşitliğini veya gelecekte doğru kullanılacağını tek başına kanıtlamaz. Bu ayrım kapanışta korunur.
