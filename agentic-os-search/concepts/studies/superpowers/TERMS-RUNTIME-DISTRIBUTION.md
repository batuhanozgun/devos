# Superpowers — Görsel yardımcı, dağıtım ve etkin sürüm

2026-09-20, **B6-T9 / U07-KAYNAK-KAYDI-TAMAM / PAKET-KISMİ**. [TERMS.md](TERMS.md)'nin bağlı parçasıdır. Önceki ENTRY, WORK, VERIFICATION-DELIVERY ve EVOLUTION-EVALUATION kayıtları korunur. Gerçek kapsam ve devam [READING.md](READING.md)'dedir. Bu dosya mevcut araştırmadaki kullanımları çıkarır; yeni host testi, güvenlik incelemesi, dağıtım işlemi veya ortak tanım üretimi değildir.

## 1. Kaynak kimliği ve anlatımın statüsü

Araştırma deposu **batuhanozgun/agentic-os-search**; sabit araştırma/P2 ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**; Superpowers paket tree'si **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. Bu turun başlangıç main'i **5229f57b304ed246bbdb471f5091827c68123f01**. Önceki concepts kapanışından fark yalnız studies CATALOG/INDEX ve yeni ponytail/META yoluydu; Superpowers ve concepts değişmemişti.

| Kod | Sabit araştırma kaynağı | Bu kayıttaki rol |
|---|---|---|
| A | [U07A-visual-companion-lifecycle.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U07A-visual-companion-lifecycle.md) | §1–10 tam okuma; görsel etkileşim, erişim, oturum ve kayıt ömürleri. |
| LA | [SOURCE-LEDGER-U07A.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U07A.md) | S71–S78/E13–E14 kimlikleri ve kaynak/deney sınırları; tam okuma. |
| E13-R/O | [U07A betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U07A-companion-client-probes.mjs) / [sonucu](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U07A-companion-client-probes-results.json) | İkisi tam okundu; geçmiş exact-helper/fake-DOM gözlemi, bu tur çalıştırılmadı. |
| B | [U07B-distribution-versioning-and-support.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U07B-distribution-versioning-and-support.md) | §1–9 tam okuma; farklı dağıtım yolları, sürüm kipleri ve destek temsilleri. |
| LB | [SOURCE-LEDGER-U07B.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U07B.md) | S79–S102/E15–E16, dış belge ve yürütme sınırları; tam okuma. |
| E15-R/O | [U07B betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U07B-version-probes.py) / [sonucu](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U07B-version-probes-results.json) | İkisi tam okundu; geçmiş JSON-only sürüm yardımcısı örnekleri, bu tur koşulmadı. |
| S02/S03 | [Erişilebilirlik/dağıtım sentezi](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S02-availability-runtime-and-distribution.md) / [Niyet/plan/bağlam sentezi](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md) | Önceki B6 tam okumalarına ek, bu tur tam yeniden erişim; U07 bağları kontrol edildi. Yeni bağımsız kanıt veya iki yeni dosya sayılmaz. |

Araştırmanın dış ana hedefi **obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797**, manifest bağlamı 6.3.0. Bu kimlik araştırma ref'inden ayrıdır; güncel ürün/host API'leri yeniden doğrulanmadı. Türkçe karşılıklar kaynak bağlantılı parafrazdır. Ürüne atfedilen talimat, araştırmacının kod/deney açıklaması, onun çıkarımı ve yeni aktarım açıklaması birbirinin yerine geçmez. S/E/F/Q adresleri kaynak araştırmaya; SP adresleri görünür P2 kullanım dökümüne aittir.

Kullanıcı okuma anındaki anlam seçimlerini denetleyemediği için önemli yorum, belirsizlik ve değişiklik görünür tutulur. Ortak sözcükler aynı anlamı garanti etmez; kullanıcı onayı, kaynak kullanımı ve çıkarıcı yorumu teknik doğruluk yerine konmaz. Atfı okumak atfedilen dış kodu yeniden okumak veya çalıştırmak değildir.

## 2. Görsel kanalın amacı, sunumu ve erişimi

| Adres / özgün ifade | Bu araştırmadaki kullanım | Dayanak ve sınır |
|---|---|---|
| SP122.a/b — Visual companion / dialogue side channel | .a belirli soruya görsel sunum ve geri bildirim desteği; .b asıl konuşmayı tamamlayan kanal. | A §2/S71. Her soruyu tarayıcıya taşıyan bütün workflow veya onay hizmeti değil. |
| SP28.visual — Companion offer acceptance / design approval | Yardımcıyı başlatma teklifinin kabulüyle belirli tasarımın onaylanması ayrı kararlar. | A §2. Başlatma kabulü her sonraki soruda kullanma veya uygulamaya geçme izni değildir; launcher'ın opt-in browser-open seçeneği saklanmış insan onayı doğrulayıcısı değil. |
| SP123.a/b/c — Screen / frame / full document | .a gösterilen HTML içeriği; .b sunumu çevreleyen şablon; .c varsayılan frame'i atlayabilen tam belge. | A §7–8. Screen dosyası kabul edilmiş tasarım sürümü değildir. Tam belgeler de helper alır. |
| SP124.a/b — Session directory / content directory | .a başlatma örneğinin kayıt ve içerik dizini; .b sunucunun ekran okuduğu alt alan. | A §4/S72–73. Her başlangıç yeni session dizini oluşturur; önceki ekranları geri getirdiği gösterilmez. |
| SP125 — Project-scoped port/token | Proje düzeyinde saklanan tercihli bağlantı noktası ve anahtar. | A §4. Yeniden kullanılması session içeriğinin veya iş durumunun geri kazanılması değildir. |
| SP126.a/b — Access authentication / shared key | .a HTTP/WS erişiminin doğrulanması; .b istemcilerin kullandığı ortak anahtar. | A §3. Anahtara sahip olma, adlı insan kimliği veya tasarım kararına yetki değildir. |
| SP131.a/b — Local hosting / external branding resource | .a sunucunun yerelde çalışması; .b frame/waiting sayfasının dış görsel kaynağı kullanması. | A §8. Yerel sunum tümüyle çevrimdışı sunum değildir; kaynak yolu görülmesi gerçek ağ isteği veya alınmış telemetry kanıtı değildir. |

A §2'nin akışı: ekran yazılır, açıklanır ve kullanıcıya dönülür; terminal yanıtından sonra aktör etkileşim dosyasını okuyup insanın metniyle birlikte yorumlar. Tıklamadan otomatik onay/plan ilerlemesi yokluğu, kaynağın diyalog tercihiyle birlikte korunur; ürüne tarayıcıyı bağımsız onay servisi yapma yükümlülüğü icat edilmez.

**U07-A01 — Erişim/servis kontrollerinin yerel dili:** loopback bind, query/cookie ile anahtar, HttpOnly/SameSite=Strict, sessionStorage, supplied-Origin kontrolü, owner-only dosya kipleri/umask, regular-file seçimi, symlink/multiple-link reddi, WebSocket payload sınırı ve frame-ancestor CSP A §3'te anlatılır. Bunlar araştırmanın koddan aktardığı mekanizmalardır; yeni güvenlik testi veya tüm HTML/script içeriğinin temizlendiği iddiası değildir. Cookie ile reconnection için tutulan anahtar aynı saklama yüzeyi değildir. HTTP/WS biçimi, başka bir taşımanın korumasını doğrulamaz. Bu kayıt anahtar değerini veya gerçek kullanıcı verisini taşımaz.

Varsayılan dış görsel no-referrer ile ve kapatma seçeneğiyle anlatılır. Yerleşik görselin kapatılması, aktörün yazdığı her HTML'de dış kaynak bulunmadığını göstermez. Dış kaynağın markup'ı ve koşulu kaydedilir; ziyaretçi izleme veya içerik sızması gözlendi denmez (A §8).

## 3. Bağlantı, seçim ve kayıt ömürleri

| Adres / ifade | Yerel karşılık | Kaynak ve sınır |
|---|---|---|
| SP127.a/b/c — Reconnect / capped backoff / paused state | .a bağlantıyı yeniden kurma; .b artışı sınırlı tekrar aralıkları; .c uzun kesintide gösterilen duraklama durumu. | A §4/E13. İşin devam durumu veya önceki ekranın geri dönmesi değildir. |
| SP128 — Event queue | Gönderilemeyen olayların ilgili helper örneğinin belleğinde bekletilmesi. | A §4/§6. Yeni helper örneğinde otomatik geri gelen kalıcı günlük değil. |
| SP129.a/b — state/events / session log | .a belirli seçim olayları için tüketiciye gösterilen dosya; .b daha geniş sunucu stdout kaydı. | A §5/§7. Farklı içerik, erişim yolu ve saklama ömürleri var. |
| SP130.a/b — Instance marker / owner-PID watchdog | .a durdurulacak sürecin o başlangıca aitliğini sınayan işaret; .b sahip sürecin canlılığına göre izleme. | A §7. Aynı kontrol değil; PID, erişilebilir tarayıcı ve geçerli güncel içerik de aynı hazır-olma gözlemi değil. |
| SP132.a/b/c — Click event / brainstorm.choice / choice–value | .a normal DOM tıklamasının payload'ı; .b açık seçim API'si; .c üretim ve kalıcı dosya koşulunun kullandığı farklı alan adları. | A §5/E13 C02–03. Aynı kullanıcı niyetini çağrıştırmaları aynı veri sözleşmesi olduklarını göstermez. |
| SP133.a/b — selectedChoice / selected state | .a son tıklanan değeri taşıyan değişken; .b arayüzde seçili durum veya küme. | A §6/E13 C04/C09. Seçimi kaldıran tıklama da son değeri taşıyabilir. |
| SP134 — Screen/session/revision binding | Olayı ilgili ekran, oturum ve sürüme bağlama gereksinimini adlandıran araştırmacı ayrımı. | A §6. Varsayılan payload'daki isteğe bağlı DOM id veya timestamp bu bağın otomatik karşılığı değil. |

**Üretim, iletim ve tüketim:** Normal click payload'ı `choice` taşır. Varsayılan `brainstorm.choice(value, metadata)` ise `value` taşır; metadata ile ayrıca `choice` sağlanabilir. Araştırmanın okuduğu sunucu dedicated dosyaya eklemeyi truthy `event.choice` koşuluna bağlar. Exact helper'ın geçmiş client deneyinde varsayılan alan farkı gözlenmiş; server append sonucu koddan çıkarılmıştır. Server koşulmamıştır. Olağan click'ler aynı hata diye nitelenmez; genel console log yolu bulunduğu için hiçbir kayıt kalamaz da denmez (A §5).

**Olay ile durum:** Geçmiş multiselect örneğinde A'ya iki tıklama A'yı seçip seçimini kaldırır; iki olay da A bildirir ve `selectedChoice` A kalır. Bu, yalnız son tıklamadan final küme çıkarma iddiasını sınırlar. Bütün olay geçmişi ve bilinen UI durumu hiçbir zaman yorumlanamaz sonucu değildir. Gerçek kullanıcıda yanlış onay gözlenmemiştir (A §6).

**U07-A02 — Koşullu endpoint reuse ve recovery:** Tercihli port doluyken örtük anahtar yolu yeni port/anahtar seçebilir ve proje düzeyindeki dosyaları ezmez; explicit environment token varsa bu fallback reddedilir. Her aynı-proje yeniden başlatması aynı endpoint'i geri getirir diye genellenmez. Tombstoned recovery'de kuyruk gönderimi keyed navigation'dan önce olabilir. Kısa reconnect deneyine server reload mesajı verilmemiştir; buradan gerçek watcher arızası çıkarılmaz (A §4/E13 C05–08).

**U07-A03 — Screen selection / file watcher / shutdown:** Sunucu en yeni eligible HTML'yi mtime üzerinden seçer; bu explicit yayın manifesti veya commit'li tasarım kimliği değildir. Yeni HTML adı events dosyasını temizler, `screen-added` ve reload üretir; bilinen dosyanın üzerine yazmak events kaydını korur. Başarılı explicit stop genel log'u kaldırabilir. Stop betiğinin lexical `/tmp/*` koşulu, project-dir kullanılmış olsa bile bu yol altındaki session'ı silme dalına sokar; server idle shutdown ise aynı temizlik işlemi değildir. Bunlar kaynak-kod açıklamalarıdır, bu tur yürütülmüş stop/restart değil (A §7).

Stop, eşleşen process marker'ını kontrol eder; belirsiz/eski PID için yanlış sürece sinyal göndermek yerine metadata'yı temizleyip durumu kaydeder. Eşleşen süreç için bekleme/escalation ve canlılık kontrolü vardır. Windows-benzeri başlatma veya başta ölü owner-PID watchdog yolunu değiştirir. Bu korumalar korunur; ne name-only kill ne tüm platformlarda garanti diye aktarılır.

## 4. Client deneyinin kayıt dili

E13-R/O'da dokuz vaka ve iki karşılanmamış daha güçlü ölçüt ayrı tutulur. `observation_verified`, kaydedilen davranış beklentisinin gerçekleşmesini; `criterion_met`, ayrıca yazılmış koşulu; `classification`, vakanın rolünü anlatır. Sayılar bağımsız kavram sayısı veya genel ürün puanı değildir.

C01 anahtarlı/cookie-only URL üretimini; C02 click payload'ını; C03 value/choice farkını ve metadata olumlu kontrolünü; C04 seçimi kaldıran tıklamayı; C05 eski zaman damgalı kuyruğun recovery öncesi gönderimini; C06 reload-mesajsız kısa reconnect'i; C07 eski/yeni helper örneğinin ayrı kuyruğunu; C08 backoff sınırını; C09 yanlış son-tıklama oracle'ının reddini kapsar. Dokuz observation doğrulanmış olarak kayıtlı, iki explicit criterion karşılanmamıştır. Runner çıkışı tüm güçlü koşulların geçtiği anlamına gelmez.

Deney fake DOM, in-memory WS, sentetik saat/timer ve exact helper ile yapılmış geçmiş kaynak çalışmasıdır. Yeni VM, yeni helper örneğini temsil eder; bütün browser storage ömrünü değil. No server/browser/host/security koşusu sınırı korunur. S77'nin başlığı pure/source dese de dosyada actual-helper mocked browser bölümü bulunduğu araştırmada belirtilir; test başlığı bütün gövdenin türü yapılmaz. S77 veya diğer upstream suite'ler bu tur çalıştırılmadı (A §9/LA).

## 5. Paket oluşturma, senkronizasyon ve kaynak seçimi

| Adres / ifade | Bu araştırmadaki kullanım | Kaynak ve sınır |
|---|---|---|
| SP135.a/b — Standalone archive / rootless package | Seçilmiş Git ref'i ve ek metadata girdileriyle yerel ZIP/tar.gz üretimi; arşiv kökünde paket içeriği. | B §2–3. Yayın, kabul veya çalışan hostta etkinleşme değil. |
| SP136 — Legacy fork sync | Çalışma kopyasından seçilen içeriği hedef metadata'sıyla birleştirip preview ve isteğe bağlı commit/push/PR yoluna taşıma. | B §2/§4. Arşiv yolu ile aynı girdi, payload veya bitiş değil; PR'ı merge etmez. |
| SP137.a/b — Positive selection / exclusion list | .a dahil edilecek kök yolların seçimi; .b dışlanacak yollar üzerinden kapsam kurma. | B §2. Root scripts dışarıda diye skills altındaki runtime yardımcıları da dışarıda sayılmaz. |
| SP138 — Per-skill metadata / agents/openai.yaml | Builder'ın önceki paketten her skill için aldığı ek metadata dosyası. | B §3. Varlık/sayı kontrolü YAML anlamını veya yayıncı kimliğini doğrulamaz. |
| SP139.a/b — Archive normalization / artifact digest | .a sıralama/zaman/arşiv özelliklerini düzenleme; .b üretilen paket baytlarının özeti. | B §3. Bütün girdilerin doğru/onaylı olduğu veya platformlar arası aynı baytların elde edildiği gösterilmez. EVOLUTION/SP114'ün sonuç digest'iyle aynı nesne değil. |
| SP140.a/b — Preview / dry-run | .a önerilen hedef değişikliğini gösterme; .b nihai apply/push/PR öncesinde dönme kipi. | B §4. Geçici clone/overlay ve auth kontrolü gibi hazırlık hiç yapılmadı anlamına gelmez. |
| SP175 — No-op | Hedefte uygulanacak değişiklik bulunmaması. | B §4. Değişiklikleri uygulamadan gösteren dry-run ile aynı durum değil. |
| SP176 — allow-dirty | Arşiv builder'ının kirli checkout ile çalışmasına izin veren seçenek. | B §3. Kaynak yine seçilen Git ref'i; commit edilmemiş değişiklikler kendiliğinden arşive girmez. |

Arşiv `.codex-plugin`, assets, skills ve seçili kök belgeleri alır; root hooks/tests/docs/development scripts ve diğer host manifestlerini almaz. Skills içindeki runtime/reference ve host açıklamaları korunabilir. Eski sync ise root hooks'u korur, working-tree ve exclusion yolu kullanır. Aynı source SHA veya version label aynı paket anlamına gelmez (B §2/S02 §3).

**U07-B01 — Assembly-input identity / provenance:** Kaynak Git ref'i, önceki paket metadata baytları/kipleri, builder/toolchain ve geçerli archive attributes ayrı girdiler olabilir. Builder supplied path'in official diye anılmasından yayıncı doğrulaması çıkmaz. Eksik metadata/sayı uyuşmazlığını reddeden somut kontrol de yok sayılmaz. B/LB'nin Git archive atfı bu tur dış belge yeniden doğrulaması değildir. Paketleme çalıştırılmadı (B §3).

Sync hedefi koruyan ayrı preview clone, local overlay, destination-owned metadata, dirty subtree refusal ve no-op kontrolleri anlatır. Buna karşılık dirty/non-main source ve uygun untracked içerik kullanılabilir; üretilen HEAD permalink tek başına bütün girdileri yeniden kurmaya yetmez. Exclusion listesindeki `.agents/` ve `.hermes-plugin/` açıklığı, kaynak düzeyinde filtre kapsamıdır; gözlenmiş yanlış sevkiyat değildir. Sentetik sync-test hook'ları güncel hostta hook zorunluluğuna çevrilmez (B §4/§7).

## 6. Sürüm kipleri ve koşulların sonuçta korunması

| Adres / ifade | Yerel kullanım | Kaynak ve sınır |
|---|---|---|
| SP141 — Version check / --check | Bildirilmiş manifest alanlarının varlığını ve sürüm uyumunu sınayan kip. | B §5. Genel bütün manifest keşfi veya release yeterlilik kontrolü değil. |
| SP142 — Advisory audit / --audit | Check çıktısını gösterebilen, ama durum kodunu bastırıp mevcut yaygın sürüm metnini tarayan uyarı kipi. | B §5. Başarılı audit çıkışı strict check geçişi değildir. |
| SP143.a/b — Version bump / partial mutation | .a alanların sırayla değiştirilmesi; .b hata öncesi bazı yazmaların gerçekleşmiş olması. | B §5. Nonzero sonuç otomatik rollback, zero sonuç bütün envanter tamam demek değildir. |
| SP144.a/b — Acquisition cache / module cache | .a edinilen paket/ref'i tutan katman; .b yüklenmiş adapter içeriğinin belleği. | B §6, ENTRY/SP19–22. Aynı restart'ın ikisini de yenilediği varsayılmaz. |

E15-R/O sekiz geçmiş JSON-only vaka içerir. C01 tam JSON check/bump/check ve gerçek alan değişimini; C02 check FAIL/audit zero farkını; C03 ortadaki eksik dosyada zero bump ve eksik envanteri; C04 son eksik dosyada önceki yazmalar sonrası nonzero sonucu; C05 bozuk existing JSON'u yazma öncesi reddetmeyi; C06 eski sürümde kalan undeclared dosyayı; C07 current-version eşleşmesini gerçekten raporlamayı; C08 exit-code-only oracle'ını reddetmeyi kapsar. İki güçlü ölçüt karşılanmamıştır; olumlu ve koruyucu kontroller birlikte tutulur.

Araştırmanın tanımladığı daha güçlü iddialar, zero bump'ın her declared dosyanın yeni sürümde bulunduğunu ve post-bump all-clear'ın hiç undeclared eski manifest kalmadığını göstermesidir. Kaydedilen dosya durumları bu iddiaları karşılamaz. Tam stdout ise missing/SKIP/drift bilgilerini de taşır; tüm iz bu koşulları gizliyor denmez. C04'ün shell sıra açıklaması araştırmacıya aittir; burada yeni kök-neden deneyi yapılmadı. Üretimin dokuz manifestli/YAML yolu ve S101'in YAML testi okunmuş atıftır; bu tur veya E15 JSON örnekleriyle koşulmuş sayılmaz.

`runs/argument/exit/stdout/stderr`, `files`, `criterion_met`, `first_file_unchanged`, `incorrect_oracle_rejected` alanları belirli koşulların kayıtlarıdır. Gerçek dosya durumunu okumak ile komutun final metnine bakmak farklı gözlem yüzeyleridir. E13'ün `observation_verified` alanı veya başka testin PASS etiketiyle tek ürün başarı bayrağına birleştirilmez.

## 7. Etkinleşme, altyapı kontrolü ve destekleyici temsil

| Adres / ifade | Bu araştırmadaki kullanım | Kaynak ve sınır |
|---|---|---|
| SP145 — Active procedure identity / activation | Edinilen dosyalardan ayrı olarak mevcut host/modül/oturumda hangi yönlendirmenin etkin olduğu. | B §6/S02 §3–4. Agent'ın kendi yöntemini anlatması exact bayt veya fayda doğrulaması değil. |
| SP146.a/b — Task/checklist artifact / manage_task | .a görev listesi temsili; .b kaynak mapping'inde süreç yönetimi aracı. | B §6/S92. Aynı task sözcüğü aynı işlevi göstermiyor; bugünkü API sözleşmesi değil. |
| SP147.a/b/c/d — Process DSL / DOT / Graphviz / SVG | .a kaynağın süreç gösterimine verdiği ad; .b diagram dili; .c çizim aracı; .d üretilen görsel temsil. | B §8/S96–97. Renderer blokları çıkarıp birleştirerek SVG üretimini ister; workflow yürütmez veya onayları uygulamaz. |
| SP148 — Spec-document-reviewer template | Depoda erişilebilir inceleyici prompt şablonu. | B §8/S99. Varsayılan brainstorming inline öz inceleme ve insan incelemesi anlatır; şablon varlığı ek zorunlu reviewer değildir. Hiç optional caller yok sonucu da verilmez. |
| SP149.a/b — Authoring reference / authoring–consuming agent | .a kopyalanmış yazım rehberi; .b yöntemi yazan ve kullanan aktör örnekleri. | B §8/S98. Örnek eval JSON'u built-in runner değil; scripti okumak ve çalıştırmak ayrılıyor. Görseller render edilmedi, güncel vendor politikası doğrulanmadı. |

**U07-B02 — Host-native discovery / integration declaration:** Metadata-only Devin yolu, özel injector olmadan native discovery anlatır; Antigravity seçili hook/reference eşlemesini kullanır. Porting rehberindeki universal injection dili, bu somut yolları injector modeline zorlayacak üst kural yapılmaz. Özel injector bulunmaması skill kullanılamaz sonucunu vermez. Kimi release/explicit branch ve fresh session; OpenCode package lock/cache açıklamaları kaynak yazarının tarihli rehberleridir, canlı host doğrulaması değildir (B §6).

**U07-B03 — Infrastructure check / active release gate:** Shell linter'ın changed/all/explicit dosya seçimi, isteğe bağlı formatlama, ShellCheck ve syntax kontrolü; pre-commit'in Python eval kontrolleri ayrı kapsamlar. Hook tanımının bulunması kurulup koştuğunu veya release'i engellediğini göstermez. Testing rehberinin geniş infrastructure etiketi gerçek Claude-session senaryolarını yok saydırmaz; historical Python Drill ile ayrı Quorum pin'i birleştirilmez (B §7/LB).

S98'in fragility'ye uygun ayrıntı, selective loading ve baseline-first önerileri kendi kopya metin statüsünde korunur. Yerel trigger-only preference ile what-and-when rehberi arasından evrensel kazanan seçilmez. Yöntemi tarif etme, render etme, kullanıma sunma ve gerçekten yürütme farklıdır.

## 8. İlişki görünümü ve önceki kayıtlara etkisi

A'nın görsel kanalı: **ilgili görsel ihtiyaç → teklifin kabulü → session/erişim ve ekran → etkileşim payload'ı → belirli kayıt yüzeyine ulaşma → terminal konuşmasıyla yorumlama → ayrı insan kararı**. Her ok otomatik motor adımı değildir. Kullanıcı etkileşti, olay gönderildi, son seçili durum biliniyor ve belirli tasarım onaylandı farklı iddialardır.

B/S02'nin dağıtım görünümü: **kaynak/kanal seçimi → paket oluşturma/edinme → kurulu dosyalar → host/modül/oturum etkinleşmesi → keşif/yükleme → kullanım → gözlenen sonuç**. Kaynak SHA, sürüm etiketi, girdiler, artifact digest ve active procedure identity ilişkili ama farklıdır. Bunlar zorunlu ayrı servisler veya CMH'den devralınmış katmanlar değildir.

S02/S03 tam yeniden okundu: erişilebilirlik/çalışma devamı ve görsel kanal bağları bu U07 kaynaklarıyla karşılandı. S04 §5'in version-helper atfı §6'ya; S01'in support/dağıtım bağlantısı §5/§7'ye bağlandı. S05/S06 ve U08-A/B/C kaynak hesapları henüz okunup aktarılmış sayılmıyor. S03'ün kamu discussion/I01-I02 bağı U08-A'da kontrol edilecek.

## 9. Pilot bağı, kapsam kontrolü ve durma sınırı

Görünür P2-T4/T5'in SP122–SP149/SP175–SP176 kayıtları A/B/LA/LB ve dört betik/sonuç üzerinden karşılaştırıldı. Adresler korundu; farklı nesneler alt adreslerle açıldı. SP28.visual, önceki onay kayıtlarını silmeden yeni bağlamı taşır. SP130 stop-marker ile watchdog ayrımı, lexical tmp koşulu, occupied-port/explicit-token koşulu ve kaynak/paket/etkin sürüm farklılıkları açıklaştırıldı. Önceki ana kullanım düzenini tersine çeviren bir fark bulunmadı; daha kesin koşullar eklendi.

Kaynakta literal ad olarak geçen cookie/sessionStorage, Origin, payload, mtime, file watcher, ref/manifest, overlay, rsync, archive attributes, tracked/untracked/ignored, pre-commit ve renderer combine kendi bağlamlarıyla korunur. Hepsine dış sözlükten genel tanım eklenmez. Sentetik key, saat, dosya adı ve sürüm değerleri gerçek sır veya bağımsız kavram sayılmaz. Kaynakların gelecekte araştırılmasını istediği Q41–46 yeni kampanya yetkisi değildir.

A §1–10, B §1–9, LA/LB kaynak/kanıt tabloları, E13'ün dokuz ve E15'in sekiz vaka ailesinden kalıcı kayda dönülerek kapsam kontrolü yapıldı. Açıklanmış U07 kullanımlarında bu kontrolde somut aktarım eksiği bırakılmadı. Kontrol aynı assistant'ın kaynak/pilot karşılaştırmasıdır; bağımsız doğrulama veya sıfır atlama garantisi değildir. Ürün kurulmaması/deney yapılmaması kaynak aktarımını eksik kılmaz; fakat ürün davranışı doğrulandı da denmez.

**Sıradaki iş S05/S06 ile üç U08 kaynak kaydının kalıcı aktarımı ve bütün paketin son kapsam/delta kontrolüdür. U07 tamam, Superpowers paketi kısmi; ortak referans aşaması başlamadı.**
