# U15-B — Beceri geçmişinden yeniden keşfe ve kullanıma

**2026-09-13 / Q59-B / PINNED SOURCE STUDY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest0.21.0. [A eşitleme](SYNC-AND-LOCAL-STATE.md), [A kaynakları](SYNC-SOURCES.md), [B kaynakları](DISCOVERY-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md). Kaynak gözlemi, koşullu çıkarım, test kodu okuması ve gerçek yürütme ayrı statülerdir.

## 1. A'dan devralınan gerçek durum

A **39bb5929f1962e0ebf1b6c1a3897aff6e963b14f**, parent2bcdf606, root774444978b2b105c7ded5058062b121f3097d4df; iki yeni evidence ve STATE. Main nonforce ilerletilip actual ref ve üç dosya tam geri okunduktan sonra B başladı. A'nın özgün metinleri burada yeniden yazılmadı. Eski synthesis01/notes03/04/08 bulguları kullanıldı; eski approval veya curator deneyi tekrar edilmedi.

A, dosya ile son dağıtılan içerik baseline'ını ve yerel değişiklik kararını açtı. B'nin hedefi bu dosyanın **bakım yetkisi, arşiv/geçmiş/geri alma kayıtları ve gerçek keşif/yükleme tüketicisi** içindeki yaşamıdır. Uzak Skills Hub veya org sync servisinin bütün yayın/onay protokolü bu birimle kapanmaz.

## 2. Farklı sorulara cevap veren kayıtlar

| Kayıt / görünüm | Hangi soruya cevap verir? | Neyle karıştırılmaz? |
|---|---|---|
| `.bundled_manifest` | Bu ada son hangi içerik baseline'ı atanmış? | Tarihsel yazar veya bütün revision geçmişi |
| `.hub/lock.json` | Hub/official operasyonel kurulum ve sahiplik bilgisi | Her içeriğin yeni scan'den geçtiği |
| `.usage.json` | Görülme/yüklenme/düzenlenme, bakım opt-in, state/pin | Başarılı görev, dosyanın gerçek yazarı |
| `.curator_suppressed` | Hangi pruned built-in yeniden tohumlanmamalı? | Diskte dosya bulunamazlığı veya loader'ın genel deny listesi |
| `.archive/` | Aktif taramadan ayrılmış fiziksel paket | Yalnız JSON state=archived |
| `.curator_ledger.jsonl` + content blobs | Hook'a katılan mutation'ın önce/sonra dosyaları ve aktörü | Bütün filesystem değişikliklerinin eksiksiz kaydı |
| Curator whole-tree snapshot | Seçili beceri ağacı, sidecar'lar ve ayrıca cron referans kopyası | Her home verisi ve bütün mevcut çalışma durumunun tam geri alınması |
| Liste / system-prompt index / skill_view | Önerilen isim, kısa açıklama ve yüklenmiş içerik | Aynı seçim, aynı tazelik veya görevde etkin kullanım |

Bu nesneler tek 'beceri durumu' kaydına indirgenemez. Normal yaşamın anlaşılması, bunların hangi sırada ve hangi hata koşulunda birbirini etkilediğini gerektirir. [S01–S04,S06–S13]

## 3. Köken etiketi, bakım yetkisi ve gözlenen kullanım

`skill_usage` dosya içine telemetry yazmak yerine adla anahtarlanan sidecar kullanır. Güncelleme `_usage_file_lock` altında read-modify-write ve atomic helper ile yapılır; kaydın yazısı başarısızsa sonuç None/False kalabilir. Ortamda OS lock desteği yoksa farklı dal vardır; bu kodu bütün platformlarda çalıştırılmış exclusion garantisi saymadık. [S06]

Gerçek `_is_curator_managed_record` açıkça `created_by:agent` alanını **curator-management opt-in** diye tüketir. `adopt_skill`, uygun yerel dosyaya bu alanı yazıp tekrar okuyarak kabulü denetler; onun tarihsel yazarını değiştirmez. Hub/external ve bundled için farklı eligibility kuralları vardır. CLI'da bulk adoption yeni otomatik arşiv yetkisi yarattığından confirmation ister. `provenance()` fonksiyonunun 'agent' fallback'i yerel elle yazılmış becerileri de kapsar; adından 'LLM tarafından üretildi' hükmü çıkarmak yanlış olur. [S06,S09]

`bump_use`, ilk/tekrar kullanım ve patch-generation sonrası yeniden yüklenmeyi kaydedebilir. Gerçek `skill_view` tool handler'ı başarılı yanıtı parse ettikten sonra view ve use sayaçlarını artırır. **Buradaki use, yükleme yolu gözlemidir; görevin bittiğini veya cevabın düzeldiğini ölçmez.** Setup-needed fakat success=True dönen bir görünüm de bu üst başarı koşulundan geçebilir. Hook ancak usage yazısı landed olduğunda emit edilir; bu iyi bir kayıt sınırıdır ama modelin talimatları uygulaması veya etkili olması ayrı ölçümdür. [S06,S08,S13]

## 4. Arşivleme ve geri getirmenin gerçek etkisi

`archive_skill` active skill'i frontmatter adına göre bulur; eligibility ve dış-sahiplik kontrollerinden sonra `.archive/` altına, kategori yapısını düzleştirerek taşır. İsim çakışmasında timestamp suffix kullanılır. `_relocate` önce best-effort ledger-before capture, sonra rename/cross-device move, ardından bundled suppression, state ve ledger-after kaydı yapar. **Başarılı move ile bütün sidecar ve ledger yazılarının başarısı aynı kabul değildir.** [S06]

`restore_skill` source archive'ı ad veya sınırlı timestamp pattern'iyle seçer; aktif hedef varsa veya yeni Hub/bundled sahipliğiyle çakışıyorsa reddedebilir. Başarılı taşımada suppression temizlenmeye ve state active yapılmaya çalışılır. Restore flat layout'a döner, önceki kategori otomatik yeniden kurulmaz. CLI bu sonucu exit-code'a taşır; tek dosya hareketi ile bütün eski düzenin geri dönmesi eşitlenmez. [S06,S09]

Discovery'nin gerçek iterator'ı `.archive` ve `.curator_backups` altını dışlar. Buna karşılık bu tarayıcı `.usage.json` state veya suppression listesine bakarak her beceriyi engellemez. Dolayısıyla fiziksel paket geri gelip sidecar archived kalmışsa, dosyanın yeniden keşfedilebilmesi kaynakla mümkündür. Suppression daha sonraki tohumlamayı etkiler; genel bir okuma-yasağı değildir. Bu koşul actual kullanıcı ortamında çalıştırılmadı. [S04,S06,S08]

## 5. Ledger: kalıcı açıklama, evrensel mutation kapısı değil

Ledger, önce/sonra dosya listelerini SHA-256 ile adlanan bloblara ve JSONL mutation kaydına bağlar. Actor explicit context override, background-review veya varsayılan agent yolundan türetilir; CLI tekil arşiv/restore için user override'ını finally'de geri bırakır. Actor alanı hangi çağrı yolunun sorumlu sayıldığına ilişkin kayıttır; bağımsız insan kimliği doğrulaması değildir. [S07,S09]

Normal capture/append failure mutation'ı durdurmaz; ledger config ile de kapatılabilir. S01'in tam okunan bundled sync yolu, bu ledger hook'larını kendiliğinden çağıran genel bir filesystem izleyicisi değildir. Bu yüzden 'her mutation history' doküman dilini bütün yazarlara ve sync yollarına genişletmiyoruz. JSONL kaydının DB dışında durması, bütün filesystem/backup/crash durumlarında eksiksiz kaldığı kanıtı değildir. [S01,S07]

Delete/archive/purge before-capture, eksik package dosyalarını **en yeni curator snapshot'ından tamamlayabilir**. Var olan current hash'ler kazanır; yalnız eksik yollar eklenir. Bu yararlı bir tamamlama mekanizmasıdır, fakat before görünümü bazen tek anda alınmış saf bir snapshot yerine farklı kayıtlardan birleşmiş olabilir. Tam paket diye etiketlenmesi, her destek dosyasının tam o mutation öncesindeki sürüme ait olduğunun bağımsız kanıtı değildir. [S07]

## 6. Tek mutation rollback'i ile bütün kütüphane rollback'i

`rollback_entry` önce entry yollarını home sınırında denetler, gerekli before bloblarını kontrol eder ve mevcut touched-file durumunu **zorunlu güvenlik entry'sine** kaydeder. Capture veya append başarısızsa dosya değişimine başlamaz. Bu, normal telemetry hook'undan daha güçlü ve gerçekten farklı bir kabul koşuludur. Sonra before dosyalarını sırayla yazar ve after-only dosyalarını kaldırır. Yazı dizisi tek atomic filesystem transaction değildir; final audit append veya bazı remove hataları aynı biçimde veto değildir. [S07]

**Geri alınan nesne entry'deki dosyalardır.** Archive mutation'ının skill dosyalarını geri getirmek, `.usage.json`, suppression ve cron ilişkilerini otomatik tersine çeviren bir transaction değildir. CLI `_rollback_ledger_entry` de bu helper'ın sonucunu raporlar; ek policy reconciliation yapmaz. Buna karşılık whole-tree snapshot aşağıdaki daha geniş nesneyi taşır. [S07,S09]

`curator_backup.snapshot_skills` skill ağacını, usage/state/manifest/suppression ve archive içeriğini kapsar; `.hub`, `.git`, backup deposu hariçtir. Cron dosyası ayrı kopyalanır; onun okunamaması snapshot'ın bütünüyle başarısız olmasını gerektirmez. Whole-tree rollback mandatory safety snapshot'tan sonra current entries'yi staging'e taşır, target arşivi açar, extraction error'da staging'i geri getirmeye çalışır. Target backup pruning'den korunur. [S10]

Başarılı extraction sonrası cron'un yalnız halen var olan aynı-ID işlerindeki `skills`/`skill` alanları uzlaştırılır; diğer canlı alanlar ve yeni işler korunur, sonradan silinmiş işler yeniden yaratılmaz. Bu gerçek ilişki korumasıdır. Ancak cron reconciliation hatası beceri ağacı geri almasını False yapmaz; mesaj/report ayrı kalır. Excluded nested metadata yalnız parent yeniden varsa taşınır; kaynaktaki açık sınır, her dışlanmış alt ağacın safety snapshot ile geri alınabilir olmadığıdır. **Bütün ağacı geri almak da bütün sistemi geçmiş zamana döndürmek değildir.** [S09,S10]

## 7. Aktif dosyadan listeye ve açık yüklemeye

Actual scan yolu project trust/quarantine, profile-local, external ve aktif org mirror gibi farklı kaynakları ele alır. Project trust bir kez verilmiş olsa da scan gate vardır; scanner failure ilgili project yolunda quarantine oluşturabilir. Aktif org marker'ı olmayan mirror normal iterator'a girmez. Bu client-side okuma koşullarını org publisher'ın gerçek kimlik/onay protokolünü doğrulamış saymıyoruz. [S04,S08]

`skills_list` metadata taraması isimde first-wins uygular ve kısa cache kullanır. `skill_view` ise bütün direct/recursive name/path adaylarını toplar; aynı project tier önceliği ayrıldıktan sonra birden fazla aday varsa **refusing-to-guess** sonucu verir. Bu bilinçli koruma, listeleme algoritmasının aynı isim için tek satır göstermesiyle birlikte bulunur. **Listede bir isim görülmesi tekil yüklenebilir hedef bulunduğu anlamına gelmez.** [S08]

A'nın official-optional restore'unda yerel farklı kopya `.restore-backups/<timestamp>/...` altına taşınır, canonical source kopyası oluşturulur. S04'ün exact exclusion setinde `.restore-backups` yoktur; iterator generic dot-directory filtresi de uygulamaz. Eski kopya aynı frontmatter adını taşıyorsa, fresh scan bu backup'ı da aday olarak görebilir. `skills_list` birini seçebilir; bare-name `skill_view` ise eski backup ve canonical kopya arasında collision reddine ulaşabilir. Canonical categorized path kullanımı veya üstün trusted-project adayı sonucu değiştirebilir. **Bu, iki gerçek kaynak consumer'ının koşullu bileşimidir; actual restore/loader koşusu veya kullanıcı incident'i değildir.** `.archive`'ın gerçekten dışlanması güçlü karşı durumdur. [S03,S04,S08]

Ayrıca create_dir ile external_dirs aynı yüzey değildir: prompt builder `get_all_skills_dirs()[1:]` üzerinden create_dir'ı dahil edebilirken bu `skills_tool` search-dir helper'ı yalnız project/local/external listesini kullanır. Yalnız create_dir olarak yapılandırılmış farklı konumdaki içerik için index→skill_view eşdeğerliği ayrıca ölçülmelidir; source config varyantı bütün kurulumlara genellenmez. [S04,S08,S11]

## 8. İndeks, içerik ve önbelleğin farklı tazeliği

`build_skills_system_prompt`, beceri içeriklerinin tamamını değil kısa açıklama/ad indeksini üretir. Available tools/toolsets, session platform, disabled set, profile home ve project tier görünürlüğü etkiler. `system_prompt._skills_prompt`, gerçek ajanın tool seti ve kendi profile-home çözümünü bu builder'a geçirir; `build_system_prompt_parts` üretilen indeksi volatile band'a yerleştirir. **Volatile burada her model isteğinde dosya yeniden okunuyor demek değildir.** [S11,S12]

İndeksin in-process LRU katmanı anahtarı tutuyorsa disk manifest'ini yeniden doğrulamadan dönebilir; ayrıca disk snapshot'ın SKILL/DESCRIPTION mtime-size manifest'i vardır. Tool listesinde ise ayrı signature ve TTL cache vardır. Explicit `skill_view` mevcut dosyayı yükler ve preprocess/readiness/provenance alanlarıyla JSON'a dönüştürür. Bunlar farklı derived view'lardır; cache invalidation'ın bütün writer→host→first request yolları bu B'de kapatılmadı. [S08,S11,S12]

Repeat-view dedup, aynı task ve kaynak path/mtime/size koşulunda full içerik yerine `content_returned:false` stub döndürür. Setup-needed görünümü cache'e almaması olumlu kontroldür; readiness dosya değişmeden değişebilir. Ama dedup return'ü yeni içerik okuması veya yeni kullanım sayacı değildir. Compression'da reset edilmek üzere helper vardır; bütün compression caller'ları bu tur yeniden izlenmedi. Eski görünümün bağlamda gerçekten korunması, alias/config değişimi ve freshness ayrı sınırlar olarak kalır. [S08,S13]

## 9. Yükleme, hazır olma ve görevde etkili kullanma

`skill_view` platform/disabled kontrolünden geçtikten sonra required-environment/credential readiness'i oluşturur. Setup eksik olsa da başarıyla içerik taşıyan, `setup_needed` diyen yanıt üretebilir; gerçek tool handler buna view/use yazabilir. Dolayısıyla **yüklenmiş içerik ≠ kullanılabilir bütün araç/credential'lar ≠ uygulanan prosedür ≠ başarılı görev**. Bu sözleşme görevin gerçek readiness ve kabulünün ayrıca ele alınmasını gerektirir; kullanıcı credentials'ı bu araştırmada okunmadı. [S08]

Üst sistem-prompt guidance, ilgili beceriyi yüklemeyi ve iyileştirmeyi ister; bu metnin bulunması modelin uyduğunun deneyi değildir. B'nin son bağlandığı noktalar actual index assembly ve tool-result payload'dır; gerçek ağ isteği, modelin davranışı veya task-quality delta gözlenmedi. U11 native backend'in farklı sahiplik yolu ordinary skill-view sonuçlarına otomatik eşitlenmez. [S11,S12; U11]

## 10. Kanıt düzeyi, karşı yollar ve devam

S14 seçili upstream testleri foreground/background mutation actor'ını, exact pre-patch text'e rollback'i, dış-yol ve eksik-blob reddini somut dosya assertion'larıyla sınayacak biçimde yazılmıştır. Bu tur koşturulmadı. Negatif kontrollerin kaynakta varlığı gözlemdir; geçen test veya tüm sidecar/cron/discovery entegrasyonu kanıtı değildir. Eski U01 approval, U13 diagnostic ve U14 source sonuçları yeniden test edilmedi.

Q59 normal bundled-change/local-protection ile arşiv/rollback/discovery hattını kaynak düzeyinde ilerletti. Uzak Hub/org push/pull/onay/merge, tüm writer-to-ledger kapsamı, exact filesystem/concurrency/rollback/effect, cache/first-request ve future-task kalite açık kalır. Bu yeni açıklama eski dört senteze ektir, final CORE veya SOUL mimarisi değildir.

Bu B main'e yazılıp geri okununca kapsam dengesi yeniden ele alınır. **Sonraki güçlü geniş aday evaluation/future-task efficacy'dir:** loaded/reused/synced/accepted kayıtlarının ötesinde ne gerçekten test ediliyor, oracle neyi ayırt ediyor ve iddia hangi çalışma nesnesine bağlanıyor? Uzak-library governance da maddi Q59 residual olarak görünür kalır; bütün lokal sync fault'larını bitirmek kalite araştırmasının ön koşulu değildir.
