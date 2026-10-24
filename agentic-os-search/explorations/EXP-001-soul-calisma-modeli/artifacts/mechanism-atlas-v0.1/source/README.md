# SOUL Mekanizma Atlası v0.1

**Tarih:** 10 Eylül 2026. **Statü:** konuşmadan türetilmiş aday işleyiş modeli.

## Başlangıç

`SOUL_Mekanizma_Atlasi_v0_1.html` dosyasını bir tarayıcıda açın. İçeriği, çizimleri, model verisini ve JavaScript kodunu kendi içinde taşır. Hesap açma, sunucu, paket kurulumu veya ağ bağlantısı gerekmez. Kaynak bağlantılarına tıklamak internet erişimi gerektirir.

İlk görünüm genel haritadır. Bir kutuyu seçin; sağ panelde sözleşmesi ve iç görünüm bağlantısı açılır. Oklar kendi koşulunu, taşıdığı bilgiyi ve neyi kanıtlamadığını gösterir. Alt haritalar aynı kimlikleri kullanır. Menüdeki demo, hazırlanmış anlatım adımlarıdır; ajan çalıştırmaz.

Küçük ekranda menü düğmesini kullanın. Grafik kaydırılabilir; `Öğeler ve oklar` aynı görünümün okunabilir liste karşılığıdır. `Sığdır` tüm grafiği gösterir; `+`/`−` okunabilir yakınlığa geçer. `/` aramayı açar; Tab ve Enter ile kutu/ok seçilebilir; Escape paneli kapatır. URL'nin `#view=...&item=...` bölümü seçimi taşır. Harita üzerindeki düzenleme sürüklemesi veya kaydedilen proje değişikliği yoktur.

PDF, aynı modelin 51 sayfalık ayrı okuma düzenidir. İçindekiler, işlem/ilişki kimlikleri ve kaynaklar bağlantılıdır. HTML'deki `PDF / yazdır` tam okuma görünümünü açar; yalnız seçili haritayı yazdırmaz. Hazır PDF bu pakettedir.

## Kapsam

22 işlem sözleşmesi, 11 bilgi nesnesi, 8 üst görünüm grubu, 71 ilişki, 7 harita, 10 demo adımı, 12 açık mekanizma, 12 çalışma ilkesi ve 21 hayali dosya.

M düğümü bir işlem sorumluluğudur; ayrı ajan, servis veya fiziksel dosya olmak zorunda değildir. I düğümü bilgi temsilidir. G grubu seçici üst görünüm; E/B ilişkileri model önerileridir. Q kayıtları çözülmemiş mekanizmalardır. R kayıtları hayali uygulama/işletim dosyalarını gösterir; bu paket o dosyaları gerçekten oluşturmaz.

Aşağıdakiler ayrıdır: kaynak, araştırma dayanağı, benimsenmiş çalışma kuralı, anlık durum, değişiklik önerisi, kabul edilmiş durum ve gerçek dünya etkisi. Kutuların/okların varlığı model muhakemesinin doğruluğunu, yetkiyi veya fiilî uygulamayı kanıtlamaz.

## İlk okunacak yol

Genel harita → Talep ve keşif → İş ve aktör hazırlığı → Uygulama demosu → Açık mekanizmalar.

D04 adımındaki D-02, form demo bulgusunun özgün kimliğidir; D04 ile aynı kimlik sistemi değildir. D09, ilk demoda gerçekleşmiş bir olay değil, sonraki uzmanlık sürekliliği tartışmasının açıkça işaretlenmiş aday devamıdır.

## Düzenlenebilir kaynaklar

- `model.json`: başlıklar, sözleşmeler, ilişki anlamları, kaynaklar, ilkeler, açık noktalar, demo ve kayıtların ortak içerik modeli.
- `build_atlas.py`: JSON'dan SVG/DOT, özel PDF okuma görünümü ve tek dosyalık HTML üretir.
- `app.js`, `style.css`, `template.html`: gezinme, seçme, filtreleme, demo, dışa aktarma ve ekran/baskı düzeni.
- `gorseller/*.dot`, `gorseller/*.svg`: 7 haritanın düzenlenebilir çizim kaynakları ve vektör çıktıları. DOT/SVG dosyaları `model.json`dan türetilir.
- `render_and_test.py`: tam HTML'yi Chromium'a yükler, arayüz/model kontrollerini yapar ve PDF üretir.
- `DOGRULAMA.json`: bu teslimatta gerçekten koşulan 24 kontrol, kullanılan yöntem ve sınırları.
- `dayanak/SOUL_Calisma_Anlayisi_Konsolidasyon_v0_1.md`: esas konsolidasyon metninin hash-eşit kopyası. Atlas bu metnin yerine geçen özet değildir.

Bu bir görsel model inceleyicisidir; düğüm ekleyip sürükleyerek mimari tasarlayan bir düzenleyici değildir. İçerik değişikliği JSON üzerinden yapılır. Yeni düğüm veya görünüm eklenirse üretim betiğindeki yerleşim kısıtları da değerlendirilmelidir.

## Yeniden üretim

Hazır HTML'yi okumak için aşağıdaki kurulum gerekmez. Yalnız dosyaları yeniden üretmek için Python, Graphviz `dot` ve PDF/tarayıcı denetimi için Playwright + PyMuPDF gerekir.

```sh
python build_atlas.py
python -m pip install playwright pymupdf
python -m playwright install chromium
python render_and_test.py
```

Graphviz işletim sistemine uygun biçimde kurulmuş ve `dot` komutu PATH'te bulunmalıdır. Tarayıcı yolunu gerektiğinde `CHROMIUM_EXECUTABLE` ortam değişkeniyle verebilirsiniz. Hazır arayüz, hiçbir üçüncü taraf JavaScript paketi yüklemez. Model içindeki kaynak hash'leri, ilgili belge sürümüne bağlanmak içindir.

## Doğrulama ve sınırlar

Kimlik ve uç bağları, 7 SVG, konsolidasyon hash bağı, sentetik sayı örnekleri, 7 harita/liste, düğüm/ok seçimi, alt görünüm, klavye, arama, 10 demo adımı, 6/15/21 kayıt filtreleri, bütün 71 ilişkinin bulunabilirliği, dışa aktarma, URL geçmişi ve 51 PDF sayfası denetlendi. 1440×1000 masaüstü ve 390×844 mobil boyutları kullanıldı. JavaScript hatası veya sayfanın başlattığı ağ isteği gözlenmedi.

Bu ortamın yönetilen Chromium'u `file://` ve localhost navigasyonunu engelledi. Tarayıcı politikası değiştirilmedi; teslim edilen HTML'nin tamamı Playwright `set_content` ile aynı motorun sayfasına yüklendi. Ağ kapalıyken bu içerik ve etkileşimler ayrıca denendi. Dolayısıyla doğrudan dosyayı çift tıklayarak açma yolu bu ortamda gözlenmedi; sayfa içi işleyiş denetlendi. Safari/Firefox ve gerçek mobil cihaz testi yapılmadı.

Bunlar belge ve arayüz denetimleridir. Gerçek SOUL, gerçek form uygulaması, canlı ajan/harness performansı, bağımsız ikinci araştırmacı veya nihai uzmanlık yeterliliği doğrulanmadı. Sayısal örnekler sentetiktir. Görsel inceleme üretici tarafından yapıldı.

Araştırma repository'si, Foundation kabul durumu veya agent-control dosyaları değiştirilmedi. Bu atlas kendi başına davranış protokolü ya da mimari benimsemesi değildir. 12 Q kaydı, hangi açıklıkların hâlâ korunması gerektiğini gösterir.
