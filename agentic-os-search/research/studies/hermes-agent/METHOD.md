# Hermes Agent — Kaynak temelli, yinelemeli araştırma yöntemi

**Sürüm:** 0.2 / 2026-09-07. Çalışma yöntemi bu study'ye aittir; agent-control kuralı değildir. Gstack METHOD'unun kanıt/sentez yaklaşımı uyarlanmıştır; başlıkları ve sonuçları aktarılmamıştır.

## 1. Sabit kaynak ve ayrı güncellik hattı

Birincil kaynak `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

Her yük taşıyan gözlem path + ref + mümkünse blob SHA + sembol/bölüm ile bağlanır. Daha yeni HEAD okunursa ayrı revalidation notu olur. Kaynak değişti diye her okuma grubu baştan başlamaz; iddia ve bağımlılık etkisi değerlendirilir. Doküman, manifest, kaynak, test, dağıtılmış binary ve gerçek çalışan ortam ayrı nesnelerdir.

## 2. En küçük anlamlı araştırma birimi

Birim sabit sayıda dosya değil, bir **davranış geçişi veya mekanizma** ve onu taşıyan kanıt kümesidir:

`niyet/kontrat → çağıran yol → uygulama → durum/etki → test/oracle → hata/geri dönüş → yeniden kullanım`.

Her mekanizmada bütün halkalar bulunmak zorunda değildir. Bulunmayan veya okunmayan halka açıkça kaydedilir; dosyanın sonuna ulaşmak mekanizmanın kapandığı anlamına gelmez. Büyük facade dosyasında bir işlev diğer modüle devredilmişse o sınır takip edilir.

## 3. İki yönlü ilerleme

Aşağıdan yukarı: pinned kaynak → mekanizma notları → HERMES-native alt-sistem sentezleri → sistem ilişkileri → çekirdek model.

Yukarıdan aşağı karşı okuma: her üst sentez, kendi dışarıda bıraktığı kaynak bölgesine ve karşı örneğe geri gönderilir. İlk ayrıştırma görünmeyen mekanizmayı bastırıyorsa plan değiştirilir. Kanıt ilişkisi ağaç değil, çoktan-çoğa bir ağdır; sentezin hiyerarşik olması provenance'ı tek ebeveynli yapmaz.

## 4. İnceleme matrisi

Her çalışma ailesi için şu boyutlar ayrı izlenir: giriş/yürütme yolu; sözleşme; uygulama; kalıcı durum; yetki/kontrol; başarısızlık/iyileşme; testin neyi ayırt ettiği; kaynak ve sürüm bağımlılığı.

CLI, gateway, cron, alt ajan, review fork, API/ACP, desktop/web/TUI yolları birbirinin otomatik temsilcisi değildir. Her kombinasyon körlemesine okunmaz; **maddi davranış farkı** varsa ayrı örnek gerekir. Ortak çekirdek kullanımı path eşdeğerliğinin kanıtı değildir.

Envanter rolleri: kritik çekirdek; varyant yürütme yüzeyi; uzantı; test/eval; generated/compat; doküman; asset/yerelleştirme. Bu roller araştırma önceliği içindir. Bir asset veya UI sonradan yetki/persistence taşıyorsa yeniden sınıflandırılır.

## 5. Kanıt statüleri

- **TARGET CLAIM:** HERMES yazarlarının/belgelerinin iddiası.
- **OBSERVATION:** belirtilen kaynakta doğrudan görülen yapı veya kontrol akışı.
- **INFERENCE:** birden fazla gözlemden kurulan, sınırı belirtilmiş sonuç.
- **HYPOTHESIS / OPEN:** ek kaynak veya karşı sınama gerektiren yorum.
- **TEST SOURCE INSPECTED:** testin kodu incelendi; koşturuldu demek değildir.
- **EXECUTED / OBSERVED RESULT:** ancak gerçekten yapılan koşu ve artefakt kimliği varsa kullanılır.

Kod yorumu geçmiş bir sorunu anlatıyorsa, yorumun varlığı gözlemdir; geçmiş olayın bağımsız doğrulanması değildir. Aramada bulunamama, kaynakta yokluk değildir. Tam dosya okuması ile seçili aralık ayrı kaydedilir.

## 6. Birimden senteze yükseltme

Bir mekanizma üst modele taşınmadan önce: neyi yaptığı; hangi giriş yoluna bağlı olduğu; hangi durumu değiştirdiği; en güçlü başarısız/alternatif yol; doğrulama dayanağı; açık sınırlar recover edilebilir olmalıdır.

Belge ve kod çelişirse çelişki korunur, ilgili çalışma yolu okunur. Kodun varlığı canlı ürün başarısına yükseltilmez. Test için fixture, mock, oracle ve negatif örnek incelenir. Sadece constructor parametresi yakalayan test bütün dispatch güvenliğini kanıtlamaz. Aynı modelin ikinci bakışı bağımsız araştırma diye adlandırılmaz.

## 7. Plan revizyonu

Yeni mekanizma, farklı etki alanı, kaynaklar arası çelişki, bypass veya yetersiz test kapsamı bulunursa şu kayıt bırakılır: hangi kanıt geldi; önceki planın hangi varsayımı değişti; hangi birim bölündü/birleşti/yeniden açıldı; sonraki okuma neden değişti.

Planı korumak için bulgu bastırılmaz; ilginç olduğu için ilgisiz dal sınırsız büyütülmez. Her tur en azından o turun gerçek durumunu, kaynak derinliğini ve kullanılabilir ilk devam noktasını kaydeder. Bu ilke her tur yeni dosya üretme kotası değildir.

## 8. Geç aşama projeksiyonu

HERMES-native model yeterince kararlı olduğunda Information, Work, Actors, Environment için ayrı açıklamalar üretilir. Alanlar arası mekanizmalar tek alana zorlanmaz. Foundation'ın güncel durumu o aşamada yeniden okunur; candidate bulgu Foundation düğümü veya mimari kararı olmaz.

SOUL/Development OS değerlendirmesi: neyin tekrar kullanılabileceği kadar neyin uyumsuz, koşullu, pahalı veya henüz doğrulanmamış olduğunu da taşımalıdır. Araştırma tamamlanması benimseme yetkisi vermez.

## 9. Bounded completion ölçütü

Kapanış ancak araştırma sorusu için bütün yük taşıyan mekanizma aileleri açıklanmış, bilinen büyük ilgili bölge açıklamasız bırakılmamış, kaynak izleri geri açılabilir, karşı örnek ve varyant yollar incelenmiş, üst model ilk çerçeveden bağımsız omission/distortion turundan geçmiş, güncellik ve yürütme sınırları görünür olmuşsa önerilir.

Bu ölçüt tüm repository'nin byte-byte okunmasını veya bütün testlerin koşmasını iddia etmez. Kapsam dışı/örneklenen bölgeler ve gerekçeleri açık olmalıdır. Devam eden kritik boşluklar 'küçük ayrıntı' diye kapanamaz. Yalnız dosya/saat/token/test sayısıyla yüzde tamamlanma verilmez.

## 10. Repo yayını ve eşzamanlılık

Bu çalışma yalnız `research/studies/hermes-agent/**` ve onu keşfettiren studies katalog/index eklerini değiştirir. Ortak dosya yazılmadan güncel içerik/ref okunur; yalnız ilgili ek korunur. Birden fazla dosya mümkünse tek tree/commit ile yayımlanır. Ref güncellemesi force olmadan yapılır; eşzamanlı head değişirse eski ağacı zorla yazmak yerine yeniden bağlanır. Son commit'in dosya kapsamı ve giriş dosyaları geri okunur. Foundation, context/Codex ve control dosyaları yeni study bahanesiyle değiştirilmez.
