# EXP-004 — U016: genişleme, kapsama ve çağrışım sınırları

**Tür:** Kullanıcı açıklamasının kaynak bağlı yorumu; yeni stress testi, araştırma sonucu veya mimari karar değil. **Kaynak:** [U016](../sources/conversation/USER-MESSAGES.md#u016). Önceki bağlam [U010](../sources/conversation/USER-MESSAGES.md#u010), [S010](../sources/conversation/assistant/S010.md) ve [S015/T08](../sources/conversation/assistant/S015.md).

## Kullanıcının açıkladığı niyet

“SOUL büyüyor” yalnız yeni parçaların sayısının artması anlamında düşünülmemişti. Kullanıcı, yapıdan kopan bağımsız bir sistem kurmaktan çok, yeni işlevlerin gelişmesiyle birlikte mevcut işlevlerin yeni aktör ve kaynakları da kapsamasını hayal ettiğini açıkladı. “Dikey/yatay” sözcükleri bu düşünceyi anlatmak için kullanıldı; ölçekleme standardı veya evrensel sınıflandırma kabul edilmedi.

İki dosyayı kontrol eden baz işlevin yeni aktörün dosyalarını da kapsaması, somut bir açıklayıcı örnektir. Buradan iki dosya şartı, merkezi dosya denetleyicisi, her dosyanın mutlaka aynı yöntemle denetlenmesi, tek repository/process veya yeni klasör yasağı çıkmaz. Örnek, mevcut sorumlulukların yeni kapsamla ilişkisini görünür yapar; nasıl gerçekleştirileceği açıktır.

T08'in sadeleştirme/geri alma ihtimali, kullanıcının bunları reddettiği anlamına gelmez. Önceki “büyüme” sözünü otomatik sınırsız ekleme hedefi saymak daraltıcı olurdu. Bu yorumun yeni bir zorunlu “yatay/dikey SOUL mimarisi”ne dönüşmesi de aynı sorunu yeniden yaratır.

## Dilin yön verme ve daraltma riski

Kullanıcı, cümlesinin assistant'ın çerçevesini etkilediğini fakat bu iç etkiyi doğrudan denetleyemediğini belirtti. Bu, kullanıcının daha kusursuz teknik örnek üretme yükümlülüğü değildir. Kullanıcı niyeti, örnek, henüz seçilmemiş yöntem, teknik kanıt ve assistant çıkarımı ayrı tutulmalıdır. Olumlu geri bildirim teknik modelin bağımsız doğrulanması sayılmaz.

Bu kayıt kontrol protokolü eklemez; konuşmada yaşanan anlam/çerçeve olayını ve kullanıcının düzeltmesini korur. Sonraki oturum U010'u tek başına okuyup U016 açıklamasını atlamamalıdır.

## Branch çağrışımı

Kullanıcı, T08'deki v1/v2 ve değişiklikleri gözleyip kabul etme anlatısının GitHub branch yapısını hatırlattığını söyledi; açıkça araç veya yöntem önermediğini de ekledi. Bu nedenle çağrışım, aday değişikliği yürürlükteki düzenden ayırıp değerlendirme fikriyle ilişkilendirilebilir; Git/GitHub, branch/merge akışı, release sistemi veya deney izolasyonu seçilmiş değildir.

Bu repository onarımının bir Git dalında yürütülmesi de SOUL'un gelecekteki mimarisinde aynı mekanizmanın benimsenmesi değildir. Çağrışım ayrı, bu turun arşivleme işlemi ayrıdır. Branch özellikleri veya üretim etkileri hakkında yeni teknik araştırma yapılmadı.

## Çalışma yönü

U016'nın önceliği açık arşiv eksikliğini onarmaktır. T09 bu tur çalıştırılmaz. T08 ve kullanıcının bu açıklaması geri kazanıldıktan sonra aynı büyük-iş kavramsal çalışması sürdürülebilir; yeni mimari/uygulama yetkisi oluşmaz.
