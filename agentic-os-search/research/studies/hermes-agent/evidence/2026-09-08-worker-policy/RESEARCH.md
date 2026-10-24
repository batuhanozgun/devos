# U01-D2 — Çalıştırma devrinde izin politikasının korunması

**Tarih:** 2026-09-08. **Statü:** SOURCE-SELECTED FUNCTION INTEGRATION + COMPLETE NAME-VALIDATOR PROBE; bütün ürün doğrulaması değil.
**Birincil pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
**Yayın:** Bu paket yerel teslimdir; GitHub'a başarılı yazma henüz yok. Güncel repo otoritesinin yerine geçmez. [Yayın devri](PUBLICATION-HANDOFF.md).
**Kanıt:** [Kaynaklar](SOURCES.md), [ilk ölçütler](SPEC.md), [14 durum](RESULT.json), [ek ölçütler](VALIDATION-SPEC.md), [5 doğrulama durumu](VALIDATION-RESULT.json), [kaynak-kimliği olumsuz kontrolü](IDENTITY-CHECK.json).

## 1. Hangi açık soruyu ilerlettik?

Önceki 06 caller notu, review iş parçacığında kurulan izin listesinin aracı çalıştıran iş parçacığında görülmeyebileceğine ilişkin kaynak temelli aday belirlemişti. Önceki transport deneyi gerçek aktarım yardımcılarıyla fakat **sentetik bir izin denetçisiyle** bu ayrımı sınamıştı. Açık iş, aktarım yardımcılarını gerçek çağrı ve gerçek politika tüketicisiyle birleştirmekti.

Bu tur izin tüketicisi artık sentetik bir liste-karşılaştırma işlevi değil: `hermes_cli/plugins.py` içindeki seçili gerçek setter/tüketici/directive işlevleri. Yürütme tarafında `agent/tool_executor.py` içindeki seçili ortak policy ve sequential-worker işlevleri kullanıldı. Tam `thread_context.py`, `daemon_pool.py` ve ek deneyde tam `turn_tool_validation.py` dosyaları Git blob hash'leri doğrulanarak çalıştırıldı. Ancak büyük executor/plugins modüllerinin tüm bağımlılıklarıyla doğrudan ithali yapılmadı; gövdeler araç cevabından elle alınmış seçkilerde tutuluyor.

**Dolayısıyla hedefe yaklaşan fakat onu bütünüyle kapatmayan bir adım var:** önceki sentetik policy denetçisi yerine source-selected gerçek tüketici ve source-selected çağrı yolu sınandı. Tam review inşası → ordinary loop → bütün middleware → gerçek registry handler zinciri çalıştırılmadı. Bu fark sonraki oturumda kaybolmamalı.

## 2. Kaynakla görülen zincir ve ayrımlar

İncelenen ordinary yolun karar taşıyan kesiti şöyle:

```text
araç adını / argüman biçimini doğrulama             E06
  → sequential wrapper                            E01
      clarify: aynı iş parçacığında çağrı
      diğerleri: daemon pool + context helper       E03/E04
  → Relay/request/execution middleware             deneyde açık sınır taklitleri
  → tek çağrı kabulü / dispatched işareti           E01
  → scope → pre-tool directive → guardrail           E01/E02
  → handler'a gerçekten ulaşma                      zararsız in-memory işaretleyici
```

Bu şema her Hermes çalışma kipinin ortak ve tamamlanmış modeli değildir. Concurrent yol kaynakta görüldü ama bu tur yürütülmedi. Alternatif runtime, gerçek UI ve provider yolları kapsam dışındadır.

E02 izin listesi `threading.local()` üzerinde durur. E03 `ContextVar` görünümünü ve açıkça ele aldığı approval/sudo callback'lerini taşır; keyfi bütün thread-local nesneleri taşımaz. E04 kendi submit yolunda ContextVar'ları taşır. Python'un resmî [contextvars açıklaması](https://docs.python.org/3.13/library/contextvars.html) Context ile thread ilişkisini açıklar; fakat Hermes'e özgü politika sonucu yalnız bu genel belgeden çıkarılmadı. E01–E04 kaynağı ve aşağıdaki kontrollü koşular birlikte kullanıldı.

## 3. İzin denetçisi yok değil; gördüğü durum değişiyor

C01'de parent thread üzerinde `research_marker` adını içermeyen gerçek selected whitelist kuruldu. Aynı thread'deki shared-policy çağrısı handler'a ulaşmadan reddedildi. C02 izinli olumlu kontrol bir kez çalıştı. Bu, denetçinin boş bir taklit veya daima izin veren bir kontrol olmadığını ayırır.

C03'te aynı parent kısıtı altında seçili gerçek sequential wrapper kullanıldı. Gerçek daemon pool yeni worker başlattı; gerçek helper context/callback görünümünü taşıdı. Policy tüketicisi çalıştı, ama **worker'daki `.allowed` alanı `None` idi**. Diğer bağımsız kontrol taklitleri izin verdiği için zararsız handler'a bir kez ulaşıldı. Parent izin listesi, origin/profile işaretleri ve callback değişmeden kaldı.

C05'te `clarify` adı, E05'in kaynak sabitine göre worker'a gitmeyen dala yönlendi. Bu ad parent whitelist'te yoktu; denetçi parent durumunu gördü ve handler çalışmadı. Bu deney gerçek clarify arayüzü açmadı; yalnız aynı adlı dispatch seçimi zararsız callback ile sınandı.

C06'da deneysel olarak worker girişine **aynı gerçek setter** ile whitelist kuruldu. Ret geri geldi. Bu, sonucu iş parçacığı sınırındaki politika durumuna bağlayan duyarlılık kontrolüdür; Hermes'e uygulanmış onarım, önerilmiş kalıcı mimari veya diğer bağımlılıkların tümünü kapatan çözüm değildir.

**Savunulabilir sonuç:** Bu kaynak seçkileri ve belirtilen sınır koşullarında context aktarımı, thread-local policy aktarımına eşit değil; shared denetçi mevcutken de policy görünümü değişebiliyor. **Henüz savunulamaz:** her gerçek review çağrısı bu bileşime ulaşır; başka üretim kontrolü yoktur; bütün Hermes izinleri aşılabilir; üretimde gerçekleşmiş olay veya yaygınlık doğrulanmıştır.

## 4. Olumlu ve olumsuz kontroller ne gösterdi?

| Durum | Marker handler sayısı | Ölçülen ayrım |
|---|---:|---|
| C01 doğrudan parent, whitelist dışında | 0 | Gerçek seçili denetçi parent'ta reddediyor. |
| C02 doğrudan izinli | 1 | Olumlu çağrı yolu çalışıyor. |
| C03 parent kısıtı, sequential worker | 1 | Policy tüketicisi worker'da liste görmüyor. |
| C04 parent'ta izinli ad, worker | 1 | İzinli kontrol çalışıyor; worker listesi yine boş. |
| C05 `clarify` aynı-thread dalı, whitelist dışında | 0 | Worker'a taşınmayan dal parent kısıtını görüyor. |
| C06 worker'da açık whitelist kurulumu | 0 | Deneysel müdahaleyle ret geri geliyor. |
| C07 bağımsız scope block | 0 | Önceki scope kararı hâlâ engelleyebiliyor. |
| C08 guardrail taklidi ret kararı | 0 | Ayrı guardrail katmanı hâlâ engelleyebiliyor. |
| C09 lifecycle block directive | 0 | Açık hook veto'su tüketiliyor. |
| C10 lifecycle teslimi exception | 1 | Selected outer exception fallback'i ret üretmiyor. |
| C11 approve directive, approval exception | 0 | Onay gerektiren yolun transport hatası engelleniyor. |
| C12 middleware callback'i iki çağrı | 1 | İkinci giriş RuntimeError; ikinci marker etkisi yok. |
| C13 modify ardından block | 0 | Argüman değişikliği veto'yu kaldırmıyor. |
| C14 modify, veto yok | 1 | Handler değiştirilmiş argümanı alıyor. |

Bütün tanılayıcı beklentiler karşılandı. Bu tablo **14 ürün testi PASS** değildir: bazı beklentiler bilinçli olarak bir sınırlılığı görünür kılar. Scope/guardrail/Relay/hook teslimi ve policy'nin yerleştirildiği üst ortam kontrollü taklitlerdir. Hedef, bütün korumaların eksikliği değil, farklı katmanların farklı sonuç vermesini ayırmaktır. Ayrıntılı thread/context/hook/handler izi RESULT'tadır.

## 5. Araç adı doğrulaması, review'a özgü yetkiyi otomatik sağlamıyor

İlk deneyden sonra, daha erken bir katmanın aynı kısıtı zaten uyguluyor olabileceği alternatifini daralttık. E06 tam modülü hash-verified kopyasıyla, kendi `validate_tool_calls` işlevi üzerinden çalıştırıldı. `valid_tool_names` kümesini oluşturan gerçek AIAgent/fork inşası değil, açıkça verilen sentetik agent holder kullanıldı.

V01'de marker, daha geniş `valid_tool_names` içinde ama parent review whitelist'i dışındaydı. Gerçek ad doğrulayıcı `ok` verdi. Bunun ardından source-selected sequential pipeline'a girildiğinde worker policy listesi boştu ve marker bir kez çalıştı.

V02'de marker daha geniş ad kümesinden de çıkarıldı ve ad onarımı yoktu. Gerçek doğrulayıcı `continue` ve hata sonucu üretti; dispatch hiç çağrılmadı. V03 bilinen adla kesilmiş JSON verdi; terminal partial sonuç ve cleanup çağrısı oluştu, handler'a gidilmedi. V04 geniş ad kabulünden sonra bağımsız lifecycle veto'su işlemi durdurdu. V05 boş argümanın `{}` biçimine normalleştirildiğini gösterdi; bu bir tam parametre-şeması doğrulama deneyi değildir.

**Sınırlı çıkarım:** İsim/biçim kabulü ve review'a özgü yetki farklı koşullar. Geniş geçerli-ad kümesi dar whitelist'e denk değilse E06 bunları kendiliğinden eşitlemiyor. Gerçek fork'un geniş kümesini ve bütün diğer giriş kontrollerini incelemeden, V01'in tüm gerçek kullanımlarda erişilebilir olduğunu söyleyemeyiz. V02/V03 ayrıca giriş doğrulamasının işe yarayan reddetme yollarını korur.

## 6. `dispatched` işareti gerçek etki için doğru tek ölçüt değil

E01 `_authorized_dispatch`, tekrar çağrıyı engellemek için `state.dispatched=True` işaretini **policy kararından önce** koyuyor. C01/C05/C07 gibi reddedilmiş durumlarda `dispatched=True`, `blocked=True` ve `handler_count=0` birlikte görüldü.

Bu nedenle önceki veya sonraki bir deney `dispatched` alanını doğrudan 'araç çalıştı' diye okursa yanlış sonuç üretebilir. Alanın kendisi yanlış olmak zorunda değil; callback kabulünü ve tekrar giriş korumasını izliyor. C12 ikinci callback çağrısını reddederken marker yalnız bir kez çalıştı. Bu yararlı bir yerel garanti, ancak ağ/üretim/kalıcı işlem için tam exactly-once semantiği değildir.

Bu turun asıl etki ölçütü zararsız handler giriş sayısı ve trace idi. Kaynakta geçen alan adı oracle yerine geçirilmedi.

## 7. Hata politikası da tek bir evet/hayır özelliği değil

E01 `_pre_tool_block` içindeki yakalanan Exception yolu, `(None, args)` ile devam edebiliyor. E02'de bir approve directive çözüldükten sonra onay isteğinin exception vermesi ise block mesajına dönüyor. C10 ve C11 bu iki farklı sınırlı dalı ayırdı.

Bu sonuç 'tüm hook sistemi fail-open' veya 'tüm hatalar fail-closed' demek değildir. Tam lifecycle delivery, Python callback timeout'u, shell hook ayarları ve bütün upstream exception tipleri çalıştırılmadı. Sentetik lifecycle exception'ın gerçekten hangi üretim arızalarıyla oluşabildiği ayrıca kaynak ister. Buradaki araştırma kazanımı, **denetçiye ulaşamama ile olumlu onay gereksinimi belirlendikten sonra onay alamamayı** ayrı değerlendirmektir.

## 8. Sıralama ve başka yazarları dışlama aynı şey değil

E05 planner'ı aynı batch'teki çağrıları parallel/sequential segmentlere ayırıyor; belirli file-reader/writer yolları için path overlap rezervasyonu tutuyor. `skill_manage` bu file-path rezervasyonu kümesinde değil; genel sequential barrier yoluna düşüyor. Bunlar source-level gözlemlerdir, E05 bu tur çalıştırılmadı.

Bu mekanizmadan process'ler, review worker'ları veya başka oturumlar arasında evrensel bir yazıcı kilidi türetilemez. U01B2'nin kontrollü araya-giren yazı/rollback sorusu da yalnız 'sıralı çalışıyor' gerekçesiyle kapanmaz. Gerçek diğer-yazar kontrolü, ledger/transaction ve lifecycle sınırları sonraki araştırmada ayrı aranmalı. Bu not yeni bir gerçek yarış üretildiğini iddia etmez.

## 9. Doğrulama sınırları ve falsifier'lar

En önemli kalan sınırlama, büyük executor/plugins modüllerinin tam yerel byte kopyası ve bütün ithal bağımlılıklarıyla yürütülmemesidir. Manuel seçkiler, import scaffolding ve sınır taklitleri extraction/integration hatası riski taşır. `verify_excerpts.py` full pinned orijinaller verildiğinde AST eşitliği denetler; bu tur o orijinallere karşı **NOT RUN**. Tam modül eşitliği varmış gibi anlatılmayacak.

Tam kaynak kimliği negatif kontrolü ayrıca yürütüldü: gerçek harness doğrulayıcısı değiştirilmiş geçici helper dosyasını importtan önce reddetti. Bu yalnız byte/source binding kanıtıdır; seçkilerin bağlam eşdeğerliğini veya test tasarımının doğruluğunu göstermez. İlk RESULT'taki basit hash-inequality alanı, sonradan koşturulan bu guard testinin yerine geçirilmedi.

Şu yeni kanıtlar daha geniş hükmü değiştirebilir: gerçek review girişinde worker policy kuran ek callsite; fiilen daraltılmış valid-name kümesi; gerçek middleware'in bu çağrıyı başka katmanda reddetmesi; alternate runtime'ın farklı kontrol yolu; seçkiyle orijinal tanım arasında fark. Bunlar kaynakta veya tam bağımlılık koşusunda araştırılmadan genel bypass hükmü verilmiyor.

Deneyler aynı araştırmacı/ortamda keşifsel yapıldı; bağımsız araştırmacı veya holdout doğrulaması değil. Sonuçlar üretim olay oranı, öğrenme kalitesi, kullanım önerisi veya SOUL mimari kararı üretmez. Önceki U01B/U01B2/transport deneyleri yeniden yapılmış sayılmaz.

## 10. Devam kararı

Bu dilim bir araştırma alt-sorusunu ilerletti; **canonical v0.6'nın istediği tam gerçek çağrı entegrasyonu kapanmış değil**. Aynı seçkilerle daha fazla benzer örnek üretmek, kalan bağımlılık boşluğuna yeni kanıt sağlamaz.

Yüksek değerli sonraki teknik adım, tam pinned executor/plugins ve ilgili middleware/gerçek review inşasıyla bu kontrolün erişilebilirliğini zararsız hedefte doğrulamak; mümkün değilse kapsamı açıkça kaydedip aynı dar deneyi döndürmemektir. Bundan sonra v0.6 sırasındaki actual pending UI/profile/store, M01/M02 bellek farkları, ledger/backup/restore/sync ve curator batch/report bağlarına dönülür. F01–F12 ve HERMES-native model → dört alan → SOUL/Development OS sırası korunur.

Mevcut çıktının repo yayını başarılı olmadığından önce bu kayıt birleştirilmelidir. Yayın bir araştırma koşusu değildir; eski STATE'i ezmek veya geçmiş deneyleri yeniden üretmek yerine bu ayrı dilimi doğru statüyle bağlamak gerekir.
