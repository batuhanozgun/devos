# U01-M4 — Onaylanmış bellek ve saklanmış sistem mesajı

**2026-09-10 / PINNED SELECTED SOURCE + BOUNDED COMPOSITION EXPERIMENT.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Bu çalışma gerçek CLI/gateway, bütün compression zinciri veya modele hazırlanan son isteğin doğrulaması değildir. [Kaynaklar](SOURCES.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [kod](probe.py).

## 1. Sorunun değişen açıklama düzeyi

Önceki 11/M2, diskteki içerik, canlı MemoryStore ve sistem mesajı için dondurulmuş bellek görünümünü ayırmıştı. 12/UI ve 13/SA gerçek onay çağırıcılarını bağladı: CLI mevcut store'u kullanabilir; gateway onayında fresh store verilir. Ancak yeni store'un son model bağlamını yenilediği gösterilmemişti.

Bu tur bu varsayımın bir sonraki sınırını açar: **oturum veritabanında saklanan tam sistem mesajı**, yeni bellek nesnesinden bağımsız bir yeniden kullanım kaynağıdır. Dolayısıyla onayın başarılı olması, yeni nesne oluşturmak ve model bağlamını yeniden kurmak aynı geçiş değildir.

## 2. Pinned kod ne yapıyor?

### 2.1 Geri yükleme seçicisi — M4-S01

`_restore_or_build_system_prompt`, konuşma geçmişi ve session DB varsa kayıtlı `system_prompt` alanını okur. Kullanılabilir metin çalışma kimliğiyle uyumluysa ve Bot Chat yenilenme koşulu oluşmamışsa bu metni aynen `_cached_system_prompt` alanına koyar. Bu dal tam prompt builder'ını çağırmaz. Araç prefix'i ve plugin/static-prefix restore yardımcıları ayrıca çalışır.

Uyumluluk denetçisi Model, Provider, prompt'un kendi host bloğundaki çalışma dizini ve Platform alanlarını karşılaştırır. **Bu işlev bellek dosyası sürümünü karşılaştırmaz.** Bu sınırlı yokluk yalnız incelenen işlev içindir; bütün sistemde bellek-tazelik kontrolü bulunmadığı söylenmez.

Geçmiş yoksa, saklı metin kullanılamazsa veya çalışma kimliği uyuşmazsa build dalı seçilir. DB okuma hatası da uyarı ve build fallback'ine gider. Yeni metnin DB'ye yazılmasındaki hata ayrı yakalanır. Bu kaynak yolları, hem eski metnin yeniden kullanımını hem yeniden kurma seçeneklerini taşır; yalnız eski-kalır iddiası eksiktir.

### 2.2 Bellek yenilemesi ile prompt yenilemesi — M4-S02

`_memory_parts`, enabled memory/user hedeflerinin `format_for_system_prompt` çıktılarını alır. Önceki tam MemoryStore kaynağında bu, frozen snapshot'tır. Tam prompt builder kaynakta stable/context/volatile katmanlarını birleştirir; bellek volatile bölümde yer alır. Bu bölümün adı her tur otomatik yenilendiği anlamına gelmez.

`invalidate_system_prompt` cached tam/static mesajı temizler, plugin snapshot'ını önceki görünüm olarak saklar ve belleği diskten yükler. **Bu işlev tek başına DB stored prompt'unu değiştirmez.** Sonradan hangi caller'ın doğrudan build/persist yaptığı veya restore seçicisini çağırdığı ayrıca belirleyicidir.

Saklanmış yanıtın kuyruğundan tam görülen `reconstruct_static_prefix`, tam stored metni yeniden yazmak yerine uygun static prefix'i yeniden kurar; eşleşmezse static alanını bırakır ve başarısız eşleşmeyi not eder. Deneyde bu yardımcı gözlemci taklidiyle temsil edildi; gerçek işlev çalıştırılmadı. Kaynak kontrolü kapsamı artırır, yeni bir bağımsız deney sayılmaz.

### 2.3 Gerçek döngüye bağlantı — M4-S03

`run_conversation`, seçiciyi `build_turn_context` işlevine parametre olarak verir. Dönen bağlam `_LoopState` içine aktarılır; ordinary loop'ta iteration hazırlama, request assembly, preflight ve API retry aşamaları ayrıdır. Ayrıca opt-in app-server yolu ordinary loop öncesinde ayrılır. Bu nedenle seçicinin çıktısını otomatik olarak son provider isteği ilan etmek doğru değildir. İlgili phase implementasyonlarına erişim bu tur tamamlanamadı.

## 3. Çalıştırılan yeni deney

Beş tam M2 kaynak modülü ve eski setup/helper kodu Git kimlikleriyle doğrulanarak kullanıldı. Yeni kaynaklardan altı complete definition elle seçildi: dört restore/uyumluluk işlevi ve iki bellek/prompt işlevi. Seçki hash'leri koşuyu bağlar; tam upstream parent byte doğrulaması değildir.

Session DB, agent nesnesi, sadeleştirilmiş builder, bazı callback'ler ve capability probe'u sentetiktir. Gerçek geçici dosyalar, memory/pending uygulaması ve selected işlev gövdeleri kullanıldı. Ağ engellendi; eski N/A/SA/AP test paketleri çalıştırılmadı. Aynı M2 fixture'ını kullanmanın ortak hata riski korunur.

**Koşu:** `2026-09-10T16:11:51.320434+00:00`, Python/platform ve exact kod/SPEC kimliği RESULT içindedir. Sekiz deney grubu ve kendi karşı kontrolleri kaydedildi; bunlar ürün PASS toplamı değildir.

| Grup | Gözlem | İddia sınırı |
|---|---|---|
| V01 | Gerçek common approval diski/canlı store'u yeniledi; fresh store yeni metni biçimledi. Buna rağmen uyumlu eski DB prompt'u seçildi; reduced builder çağrı sayısı sıfırdı. | Kontrollü DB ve seçili restore bileşimi; gerçek gateway turu değil. |
| V02 | Boş geçmiş, null stored prompt ve DB-read arızası yeni snapshot'tan build'e gitti. | Gerçek session-create veya DB onarımı testi değil. |
| V03 | Model/provider/platform/cwd uyumsuzluklarında build seçildi. | O işlevin runtime uyumluluğu; bellek faydası veya tüm freshness kuralı değil. |
| V04 | Reload cached metni değiştirmedi. Invalidate snapshot'ı yenileyip cache'i temizledi fakat DB'yi değiştirmedi; ardından elle restore çağrılınca eski metin döndü. Explicit reduced build+persist sonrasında yeni metin restore edildi. | **Harness sırası, actual compression sırası değildir; compression kusuru ilan edilmez.** |
| V05 | Onaylı silme diski boşalttı, fresh store boş blok verdi. Eski stored prompt seçimi silinen marker'ı korudu; kontrollü fresh build kaldırdı. | Modelin gerçekte silinen bilgiyi gördüğü/hatırladığı kanıtı değil. |
| V06 | Pre-commit writer arızası Approved 0/Failed ve pending koruması üretti; live/disk ayrışması reload ile toparlandı, selector eski diskle uyumlu mesajı seçti. | Eski M2 fault'unun selector bileşimindeki kullanımı; yeni tür memory kusuru değil. |
| V07 | Fake DB read+write hatası altında yeni cached metin üretilirken eski DB kaldı; hatalar kaldırılınca eski kayıt yeniden seçilebildi. | İki sentetik DB arızası; SQLite veya üretim olay oranı değil. |
| V08 | Kontrollü capability-stale cevabı build dalını açtı; probe exception'ı reuse fallback'ine döndü. | Gerçek Bot Chat capability resolver'ı veya çalışma koşulu değil. |

Sekiz grubun yazılmış beklentileri eşleşti. Gerçek pre-import guard, değiştirilmiş full memory modülünü reddetti. Seçki dosyasına yapılan değişiklik local hash guard'ında reddedildi. Ayrı comparator mutantları (daima uyumlu/daima uyumsuz), V03 ve V01'in yanlış seçimleri ayırabildiğini gösterdi. Bu kontroller bütün test yüzeyinin eksiksizliğini veya manual selection'ın upstream parent'la tam eşitliğini kanıtlamaz.

## 4. Savunulabilir sonuç ve açık karşı açıklamalar

**Dar sonuç:** Kullanılabilir ve uyumlu saklı sistem mesajının seçilmesi, yeni bellek snapshot'ından prompt build edilmesine alternatif bir yoldur. Yeni store ve başarılı onay tek başına bu yolu ortadan kaldırmaz. Silme de aynı görünürlük sorusunun ters yönüdür.

**Olumlu sınır:** Tazelik sonsuza kadar kaybolmuş değildir; selected kaynak ve deney, kullanılabilir eski metin bulunmaması, runtime uyumsuzluğu, capability refresh ve açık build/persist gibi yeni metne giden yolları da ayırır. Hangisinin gerçek kullanıcı akışında ne zaman tetiklendiği ayrıca araştırılır.

**Henüz söylenemeyen:** Gerçek CLI veya gateway'in kaç tur eski bilgi kullandığı, actual compression/keep-prompt'un eski DB'yi yeniden seçtiği, bütün alternative runtime'ların eşdeğerliği, provider'ın aldığı son mesaj veya modelin bilgiyi nasıl kullandığı. Deney endpoint'i cached-prompt seçimi; hazırlanan gerçek request değildir.

Source request'lerinin 429 ile engellenmesi kaynağın yokluğu değildir. Bu tur bounded köprü açıldı fakat uçtan uca görünürlük kapanmadı. Tam bu ayrım sonraki sentezin kenar etiketinde korunur.

## 5. Araştırmanın devamına etkisi

Aynı dar selector/approval örneklerini çoğaltmak artık en yüksek değerli hareket değil. [Geçici alt-sistem sentezi](../../synthesis/01-LEARNING-AND-CHANGE-PROVISIONAL.md), mevcut kanıtı bir araya getirir; prompt/request boşluğunu gizlemez.

Sonraki aktif çalışma geniş kaynak-topoloji kontrolü ve genel turn/context/session modelidir. `turn_context`, request assembly ve compression/cached-agent yaşam döngüsü bu genel modelin yük taşıyan bağlantıları olarak geri açılır. Böylece tek bir onay edge-case'i bütün HERMES'i durdurmaz. Ledger/backup/restore/sync, skill-cache ve curator report/cron köprüleri de bu karşı okumayla önceliklendirilir. Gerçek kullanım/öğrenme faydası hâlâ ayrı açık sorudur.
