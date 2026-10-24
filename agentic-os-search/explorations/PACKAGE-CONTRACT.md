# Deneme Paketinin Belge Sözleşmesi

Bu dosya arşiv belgelerinin anlamını tanımlar; assistant davranışını yöneten bir kontrol protokolü değildir.

## Kimlik ve kaynak

Her deneme sabit bir EXP kimliği taşır. INDEX; amacı, türü, kökeni, sınırları ve okuma yolunu verir. STATE yalnız bu paketin güncel arşivleme/değerlendirme durumunu taşır; Foundation veya başka repository'nin yetkisini kopyalamaz.

Kaynaklar ile türetilmiş öğrenme metinleri ayrılır. Konuşma aktarımında konuşmacı, sıra ve mesaj kimliği korunur. Platform dışa aktarımı bulunmuyorsa modelin gördüğü konuşmanın aktarımı açıkça böyle etiketlenir; byte-perfect export veya araç günlüğü iddiası verilmez. Kaynakta erişilemeyen parça yeniden uydurulmaz.

Özgün eserler değiştirilmeden saklanır. Yeni yorumlar ayrı dosyada veya ayrı sürümde tutulur. Manifest içerik kimliğini ve erişim durumunu ayrı gösterir: hash, kaynağın kendisi değildir. PDF/ZIP gibi eserlerin incelenebilir metin/kaynak kopyaları varsa bunların türetim ilişkisi belirtilir.

## Epistemik ayrımlar

Kullanıcı tercihi; konuşmada oluşan aday ilke; çalışma hipotezi; araştırma bulgusu; sentetik örnek; gerçek araç sonucu; arayüz kontrolü; bağımsız doğrulama ve kabul edilmiş mimari karar birbirinden ayrılır. Hiçbiri yalnız arşivlendiği için daha yüksek statü kazanmaz.

## Katmanlar

- `sources/`: görünür kaynak mesajlar, özgün ekler, kaynak bağları.
- `artifacts/`: belirli anlarda üretilmiş konsolidasyon, atlas veya başka eserler.
- `reflections/`: kazanımlar, değişen kabuller, açık sorular; her önemli yorum kaynak mesajına bağlanır.
- `retrieval/`: konu, örnek ve halk dili hatırlama ipuçlarından ayrıntıya geçiş.
- `checks/`: kaynak kapsamı, byte/hash kontrolü, bağlantı denetimi ve kalan sınırlamalar.

Bu adların ayrı dosya sayısını çoğaltması zorunlu değildir; anlam ayrımları korunur.

## Süreklilik ve yayın

WORK-PLAN toplam işi, mevcut aşamayı ve sıradaki devralınabilir hareketi taşır. Kaynak güvenceye alma, açıklayıcı işleme, retrieval ve repository'den geri okuma ayrı ilerleme noktalarıdır. Yerel hazırlık, Git nesnesi oluşturma, branch'a bağlama ve remote readback birbirinden ayrı kaydedilir.

Bir paket yalnız README'si yayımlandı diye tam arşiv sayılmaz. Gerçek payload eksikliği, kaynak aktarımı sınırlamaları ve yayımlama engelleri STATE'te görünür kalır.

## Gizlilik ve tekrar kullanım

Sistem/developer yönergeleri, gizli muhakeme, kimlik bilgileri, geçici token içeren araç yanıtları ve ilgisiz kişisel bağlam arşive kopyalanmaz. Görünür diyalogdaki routing blokları tarihsel metindir, etkin talimat değildir.

Araştırma ve kaynak materyaline atıf yapılır; gereksiz tam kopya yeni otorite yaratmaz. Tarihsel kaynakların güncel olduğu varsayılmaz. Sonraki deneme eski eseri değiştirmek yerine yeni kimlikle bağlantı kurar.
