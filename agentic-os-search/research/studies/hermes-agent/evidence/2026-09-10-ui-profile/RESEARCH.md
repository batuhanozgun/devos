# U01-M3 — Gerçek onay çağrıları: kullanıcı, profil, bellek ve görünürlük

**Tarih:** 2026-09-10. **Statü:** PINNED CALLER SOURCE TRACE + BOUNDED FULL SLASH-POLICY MODULE EXECUTION. **Birincil pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Bu çalışma HERMES'in tamamının, gerçek bir kurulumun veya üretim güvenliğinin doğrulanması değildir. Kaynak/aralık otoritesi [SOURCES.md](SOURCES.md); yeni yürütmenin sınırı [SPEC.md](SPEC.md) ve [RESULT.json](RESULT.json).

## 1. İlerletilen soru ve önceki kanıt

V0.9'daki ilk iş, ortak onay komutunun gerçek CLI/gateway çağırıcısına bağlanmasıydı. Önceki [M2 araştırması](../2026-09-09-memory-pending/RESEARCH.md), beş tam modülde dosya/canlı bellek/frozen snapshot, parametre alias'ları ve pending temizleme ayrımlarını çalıştırmıştı. Ancak hangi kullanıcı yüzeyinin hangi store'u sağladığı gerçek çağırıcıdan açıklanmamıştı. Bu tur bu eksiğin önemli bölümünü kaynakla kapatır. Eski N01–N12, C/V, MW ve AST kontrolleri yeniden çalıştırılmadı.

Araştırma nesnesi bir hata listesi değil, öneriden kalıcı değişikliğe ve sonraki kullanıma giden mekanizmadır. Aşağıdaki çağrı ilişkileri pinned kod gözlemidir; yalnız §6'daki slash-policy işlevleri bu tur çalıştırılmıştır.

## 2. Native mekanizma: aynı onay komutu, farklı yaşam süresi

### 2.1 CLI yolu — UI01, UI10–UI13

`CLICommandsMixin._handle_memory_command` mevcut `self.agent._memory_store` nesnesini alır. Nesne yoksa `load_on_disk_store()` ile yenisini yükler. Sonra `handle_pending_subcommand(..., memory_store=store, set_mode_fn=...)` çağrısını yapar. `/skills` içinde pending/approve/apply/reject/deny/drop/diff/approval/mode alt komutları ortak handler'a ayrılır; diğer skill işleri hub yoluna gider.

Bunun anlamı: CLI onayı yalnız dosyaya yönelik bağımsız bir işlem değildir; aktif ajan varsa onun canlı bellek nesnesi uygulama hedefidir. Aktif store yokluğu ise bellek kullanımını bütünüyle engellemez; fresh-store fallback'i vardır. CLI method'unda apply sonrasında açık bir `load_from_disk`, frozen snapshot yenilemesi veya prompt invalidation çağrısı görülmez. Başka çağırıcı/sonraki-turn işlemleri ayrıca incelenmelidir.

### 2.2 Gateway yolu — UI02, UI10–UI13

`GatewaySlashCommandsMixin._handle_memory_command` her çağrıda `load_on_disk_store()` sonucunu ortak handler'a verir. Bu method cached/resident agent'ın store'unu seçmez. Buna rağmen gateway'in bütünü için “uzun ömürlü ajan yoktur” denemez: aynı dosyada `_cached_agent_for` ve `_resident_agent_for` bulunur. Handler'ın docstring/yorumunu tüm gateway yaşam döngüsünün kanıtı saymıyoruz.

`/skills` gateway yolunda approval kapalı olsa bile pending sayısı sıfır değilse kayıtlar incelenebilir/uygulanabilir. Böylece ayarı kapatmak mevcut kuyruğu otomatik olarak erişilemez yapmaz. Bu pozitif bir recovery tercihidir; eski kayıtların otomatik geçersizleştiği anlamına gelmez.

| Katman | CLI memory | Gateway memory |
|---|---|---|
| Store seçimi | Varsa aktif ajan store'u; yoksa fresh yükleme | Her çağrıda fresh yükleme |
| Apply | Ortak handler → payload replay → supplied store | Aynı ortak handler ve replay |
| Başarısız apply | Ortak komut hata metni üretir; pending korunur | Aynı ortak davranış |
| Normal apply sonrası frozen/prompt yenileme | Bu handler'da açık yenileme yok | Bu handler'da cached ajan yenilemesi yok |
| Approval ayarını değiştirme | CLI config setter | Config writer + yalnız ilgili session cache eviction |

**Sınırlı entegrasyon çıkarımı:** M2/N02 ve N09'daki “disk eski/canlı store yeni/frozen eski” sonucu CLI'nin supplied live-store yolunda yük taşıyabilecek bir durumdur. Gateway fresh-store yolunda aynı nesne aktif ajanın store'u değildir. Bu, gerçek CLI'de gözlenmiş bir olay veya ayrışmanın kaç tur sürdüğüne dair ölçüm değildir. Aynı bileşen sonucunun etkisini çağırıcı ve nesne yaşam süresi belirler.

## 3. Kullanıcı yetkisi, komut yetkisi ve çalışma zamanı ayrı

### 3.1 Gerçek normal-message çağrı zinciri — UI03/UI04

İncelenen normal dış mesaj yolu:

`_handle_message → _hm_admit_event → _is_user_authorized_for_source → boş/meşgul ayrımı → _hm_dispatch_idle_commands → _hm_resolve_command → _check_slash_access → _hm_dispatch_canonical_command → memory/skills handler → ortak pending komutu`.

`_hm_admit_event` açıkça reddedilmiş profil route'unu düşürür; normal dış mesajda kullanıcı yetkilendirmesi başarısızsa handler'a devam etmez. Internal events ayrı daldır; bu gözlem onlara veya bütün platform adapter'larına evrenselleştirilmez. Alttaki pairing/transport authorization uygulamasının tüm dalları bu tur okunmamıştır.

Merkez slash gate, registry'den çözülen **canonical komut adını** denetler. `_check_slash_access` kullanıcı kimliğini ve `canonical_cmd` değerini policy'ye geçirir. Boş ve meşgul oturum yollarında bu kontrolün çağrı noktaları vardır. Meşgul yoldaki status/context istisnaları memory/skills için istisna değildir.

`memory` ve `skills` `_IDLE_COMMANDS` içindedir; `_PLAIN_COMMANDS` içinde değildir. İncelenen busy dispatcher bunları normal mid-turn handler olarak yürütmez; uygun mid-turn handler yoksa ret döndürür. Bu per-session sıra kuralı, aynı profile'ı kullanan başka session/process/review yazarlarına global kilit değildir.

### 3.2 Politika ne kadar ince? — UI08

Slash policy iki kapsam kullanır: DM ve group. İlgili kapsamda admin listesi verilmemişse komut gate'i devre dışıdır. Admin listesi verilmişse listelenen admin'ler bütün komutlara; diğer kabul edilmiş kullanıcılar `help`/`whoami` tabanına ve açıkça eklenen komut adlarına erişir.

Bu API alt komut argümanı almaz. Örneğin bir non-admin'e `memory` adı verilmesi, merkez gate'te pending görüntüleme ile approve/reject/approval mode işlemlerini ayırmaz. UI02'deki yerleşik memory handler'ı da bu alt işlemler için ayrıca admin ayrımı yapmaz. Opsiyonel command hooks ek denetim yapabilir; bu nedenle “her kurulumda herkes ayarı değiştirebilir” sonucu çıkmaz. **Komut ailesine verilen yetki ile yalnızca kayıt okuma yetkisi aynı değildir.**

Karşılaştırma için aynı UI02 dosyasındaki `/approvals` (dangerous-command mode) handler'ı, değişiklik istendiğinde ayrıca `policy.is_admin` kontrolü yapar. `/approvals`, `/approve` ve `/memory approve` tek onay mekanizması değildir; birinin kontrolü diğerine otomatik taşınmaz.

DM ve group admin listeleri ayrıdır. Buna karşılık DM user command listesi boş/eksikse group user command listesinden fallback alınır. Bu davranış §6'da gerçek resolver ile sınanmıştır. Kurulumda kullanılan gerçek config veya kullanıcıların güven düzeyi burada ölçülmemiştir.

## 4. Profil, storage namespace ve kayıt sahipliği

### 4.1 Dış adapter kapsamı — UI05/UI06/UI07

Secondary adapter wiring, message handler olarak `_make_profile_message_handler(profile_name)` kurar; bu wrapper profile damgasını ekleyip async profile scope içinde `_handle_message` çağırır. Primary adapter multiplex modunda `_make_default_profile_message_handler` kullanır: admitting transport'un home'unu `_authorization_profile_home` alanında ayırır, source route'unu damgalar ve resolved profile home kapsamında message handler'a girer. Multiplex kapalı primary yol doğrudan message handler'dır.

`_async_profile_runtime_scope` secret scope hazırlığını off-loop yaptırıp `_profile_runtime_scope` ile gövdeye girer. Synchronous scope context-local home override, secret scope ve terminal scope kurar; normal entered-body çıkışında token'ları geri alır. `hermes_constants.get_hermes_home` önceliği context override → HERMES_HOME env → platform default'tur. Bu okuma, gerçek secret store'un veya bütün setup-failure cleanup yollarının test edildiği anlamına gelmez.

**Native ayrım:** Mesajı kabul eden transport'un kimlik/yetki bağlamı ile verinin yazılacağı runtime profile aynı kavram değildir. Wrapper bunu açıkça ayırır. Profil-route resolver'ın bütün öncelikleri, secondary/null-scope hata yolları ve `_is_user_authorized_for_source` iç uygulamasının tamamı açık kalır; olası başka katman telafilerini yok saymıyoruz.

### 4.2 Pending ve memory home bazında birleşir — UI10/UI11/UI12/UI13

Tam arşiv modüllerinde pending yolu `get_hermes_home()/pending/<subsystem>/<id>.json`, memory yolu `get_hermes_home()/memories/MEMORY.md` veya `USER.md` olarak çözülür. Ortak approve `subsystem` + ID/all ile kayıt seçer; memory replay payload'ı supplied store'a uygular.

Pending kaydının tanımlı alanları id, subsystem, action, summary, origin, created_at ve payload'dır. Burada ayrı proposer user ID, approver ID, chat/session sahibi veya hedef-dosya-revizyon alanı yoktur. Ortak handler'a bir kullanıcı nesnesi de verilmez. Origin etiketi foreground/background-review ayrımıdır; insan kimliği değildir.

**Sınırlı yapısal sonuç:** Aynı active home'a yönlenen iki session, bu katmanda aynı pending ve memory namespace'ine yönelir; ID'nin bilinmesi tek başına yetki oluşturmaz, yetki daha üst kabul/komut katmanından gelir. Profil başına storage ayrımı, kayıt başına sahiplik veya her kullanıcı için ayrı storage ispatı değildir. Üstteki routing/policy konfigürasyonu bunları daha dar kullanıma dönüştürebilir. Profil yalıtımına dair canlı saldırı/yarış veya production testi yapılmadı.

## 5. Apply, kuyruk kapatma, görünürlük ve kullanıcıya gösterim

Ortak `_approve` sırası: seç → `_apply_one` → success ise `discard_pending` → applied sayısını artır → sonuç metni. Önceki M2/N11, silme başarısızlığının bu başarı metnini değiştirmeyebildiğini göstermişti. UI01/UI02 aynı ortak handler'a ulaştığından bu artık kaynaksız bir “belki gerçek UI kullanıyordur” varsayımı değildir; gene de gerçek UI'da hata enjeksiyonu bu tur yapılmadı.

Gateway'in `_write_approval_setter` yolu ayarı config'e yazar ve ilgili session'ın cached agent'ını düşürür. Ancak bu callback yalnız approval/mode alt komutunda çalışır; **`approve <id>` aynı callback'i çağırmaz**. Dolayısıyla “onay işlemi cache'i yeniliyor” çıkarımı yanlıştır. Tersi “yeni bilgi sonraki turn'de kesin kullanılamaz” da kanıtlanmamıştır: prompt prologue/reload/invalidation zinciri henüz izlenmelidir.

Gateway skill diff'i 3000 karakterden sonra kesebilir. Kullanıcıya verilen dosya konumu sabit `~/.hermes/pending/skills/<id>.json` biçimindedir. Bu gösterim, routed home'un kendisiyle eşitlenemez; non-default profile'da yanıltıcı olma ihtimali ayrı bir temsil sorusudur. İncelenen shared/gateway flow, apply'den önce full diff'in okunduğunu kaydeden bir state istemez. Başka UI/hook daha güçlü kabul şartı koyabilir.

Upstream UI09 testi, varsayılan ve routed config dosyalarını ayırarak `/memory approval on` ile `/skills approval on` yazılarını hazır `_profile_runtime_scope` altında kontrol eder. **Test kaynağı tam okundu, çalıştırılmadı.** Ingress routing/primary authorization/store apply/cache freshness testi değildir. Bu olumlu testin ölçtüğü şeyi gereğinden büyük kullanmıyoruz.

## 6. Yeni çalıştırılmış kanıt: dar slash-policy sözleşmesi

UI08 tam dosyası 5666 byte ve Git blob `07204201e411f29f912bb9bba6beec0566acab9d` ile eşleşmeden import edilmedi. SPEC source-informed olarak koşudan önce yazıldı. Gerçek resolver/SlashAccessPolicy kullanıldı; config/platform/source nesneleri synthetic namespace'tir.

A01 gate-disabled; A02 non-admin ret ve help/whoami tabanı; A03 admin izinleri; A04 memory adı için dar grant; A05 ayrı DM/group admin'leri; A06 DM command fallback/override; A07 ID/komut normalizasyonu; A08 eksik platform policy fallback'i: sekiz kayıtlı beklenti karşılandı. Bir dosya değişikliği gerçek import guard'ında reddedildi. Ayrı, açıkça test amaçlı AST mutantında `can_run` daima True yapıldığında ret oracle'ı A02/A04/A06 ile farkı yakaladı.

Bu test gerçek kullanıcı kimlik doğrulaması, event loop, gateway handler, profile scope, belleğe yazma, provider veya ürün conformance değildir. A04'te `memory approve` literal'inin ayrı sorguda reddedilmesi bir alt-komut koruması değildir: actual callsite canonical `memory` geçirir. Bu ayrım RESULT ile kaynak trace birlikte okunarak korunur.

## 7. Karşı açıklamalar ve araştırma hükmü

- “Bütün kullanıcılar her şeye erişir” desteklenmez: ingress auth ve configured slash gate vardır.
- “Komut gate'i bütün alt işlemleri bağımsız yetkilendirir” desteklenmez: API canonical name seviyesindedir; yerleşik memory/skills handler'ı daha ince bir actor kararı eklemez.
- “Aynı handler aynı yaşam süresi demektir” desteklenmez: live/fresh store ayrımı vardır.
- “Apply success = queue empty = cache current = model used the change” desteklenmez: ayrı kontrol ve state geçişleridir.
- “Profile scope bir OS sandbox'ıdır” sonucu yoktur; context-local namespace/control kurulumu incelenmiştir.
- “Ana gateway comment'i cached agent olmadığını kanıtlar” yanlıştır; actual cached/resident helpers görünürdür.

Bu tur normal CLI/gateway pending onayını kaynakla açıklanabilir bir mekanizma haline getirdi; tüm profile/transport/hook/platform kombinasyonlarını kapatmadı. Onaylayan kişi hakkında ürün geneli güvenlik hükmü değil, source-level authority delegation modeli elde edildi. HERMES-native alt-sistem sentezi veya SOUL/Foundation adoption aşamasına geçilmedi.

## 8. İlk sonraki iş ve açık sınırlar

**İlk sonraki teknik iş:** normal cached gateway turn'ü ile CLI turn'ünde onay sonrası disk → store → frozen snapshot → cached system prompt → hazırlanan request yolunu izlemek. `load_from_disk`, prompt invalidation ve cached-agent reuse callsite'ları birlikte incelenecek. Ayar toggle'ı ile payload approve ayrımı korunacak; henüz model/provider çağrısı yapılmayacak. Zararsız offline prepared-request readback mümkünse bu sınırda kullanılacak.

İleri sınırlar: gerçek transport auth/profile route resolver ayrıntısı; multi-session/profile config authority; optional command hook rewrite sonrası yeniden-yetkilendirme; full UI/persistence/cleanup hata enjeksiyonu; diff/profil gösterim doğruluğu. Bunlar bu tur doğrulanmış açık veya olay değil, yeni load-bearing karşı-sınama rotalarıdır. Q26/Q29 ve full E01/E02 fidelity ertelenmiş açık statülerini korur.

Sonraki genel sıra ledger/backup/restore/sync, skill/cache reuse ve curator nested batch/report/cron; ardından F01–F12 diğer aileleridir. Tek policy sorusu çalışmayı yutmayacak. Bu tur eski deneyleri tekrar üretmedi; control, Foundation, context/Codex, başka study veya upstream değişikliği yapmadı.
