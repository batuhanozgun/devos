# U01-M3 — Gerçek onay çağrısı: erişim, profil, bellek ve görünürlük

**Araştırma tarihi:** 2026-09-10. **Primary pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
**Statü:** PINNED ACTUAL-CALLER SOURCE TRACE + EXACT SLASH-POLICY COMPONENT EXECUTION. Tam gateway/CLI/ürün testi değildir.

[Kaynak defteri](SOURCES.md), [önceden yazılan senaryolar](SPEC.md), [gerçek sonuç](POLICY-RESULT.json), [koşu kodu](policy_probe.py).

## 1. Araştırma sorusu ve gerçek ilerleme

Önceki M2, beş tam modülle bellek dosyası, canlı nesne, frozen snapshot ve pending apply/cleanup sınırlarını sınamıştı. Ancak ortak komuta hangi gerçek kullanıcı yüzeyinin hangi store'u verdiği ve onaya kimin ulaşabileceği açık kalmıştı. Bu tur o eksik dış halkalar kaynak kod üzerinden bağlandı. Ayrıca ek slash yetkisi mekanizmasının kendisi bir tam modülle çalıştırıldı.

Bu not M2'nin 12 senaryosunu yeniden koşmaz; Q26 worker davranışına yeni bir tam-runtime hükmü vermez. Araştırma HERMES'in çalışma modelidir, güvenlik açığı üretme veya yalnız hata sayısını çoğaltma işi değildir.

## 2. Tek bir “onay kontrolü” değil, birbirine bağlanan kararlar

İncelenen normal dış-mesaj yolu şu ayrımları taşır:

`transport/route → external-user admission → slash-command access → idle/busy dispatch → actual handler → profile-scoped pending record + supplied store → mutation/result/cleanup → later prompt visibility`.

Bu bir bütün ürün yürütme izi değildir; aşağıdaki named source geçişlerinden kurulmuş kaynak modelidir. Internal events, adapter callbacks, plugin interceptions ve diğer UI'ler otomatik eşdeğer sayılmaz.

### 2A. Mesajın kabulü

**SOURCE OBSERVATION — M3-S03/S04/S06/S07:** Primary multiplex message wrapper, kaynak üzerinde transport authorization home'u saklarken işlem için routed profile home altında `_handle_message` çağırır. Inbound `_hm_admit_event`, açıkça reddedilmiş profile route'u düşürür; normal dış mesajda `_is_user_authorized_for_source` kontrolünden geçmeyen çağrıyı durdurur. Pre-dispatch hook'un `allow` sonucu bu sonraki auth kontrolünün yerine geçmez. Internal event dalı daha erken ayrılır; bunun dış kullanıcı tarafından taklit edilebildiği gösterilmiş değildir.

Authorization wrapper, `_authorization_profile_home` varsa `_is_user_authorized` çağrısını o home kapsamına alır. Böylece bir botun transport ayarları ile işlem yapılacak runtime home aynı olmak zorunda değildir. **Ancak “bütün yetki tek transport profiline bağlıdır” sonucu fazla güçlüdür:** aynı authz mixin'indeki pairing-store seçimi `source.profile` kullanır; transport adapter ownership ve env/config allowlist kararları da ayrı yollardır. Bu alanlar tek profile etiketi altında birleştirilmemelidir.

**Karşı sınır:** Authz kodu çeşitli meşru grant yolları içerir: örneğin chat allowlist, pairing, açık allow-all veya trusted adapter/upstream delegasyonu. Bu yüzden “her onaylayan bireysel allowlist'te bulunur” varsayımı desteklenmez. Hangi deployment'ta hangi grant'ın aktif olduğu ayrıca config/adapter bağlamı gerektirir. Bu tur gerçek kullanıcı doğrulanmadı.

### 2B. Sohbet erişimi ile komut yetkisi farklıdır

**SOURCE OBSERVATION — M3-S04/S05/S09:** Idle command çözümlemesi, tanınan komut için `_check_slash_access` çağırır. Bu işlev `policy_for_source(self.config, source)` sonucuna bakar. İlgili DM veya group yönetici listesi boşsa ikinci gate kapalıdır. Etkin olduğunda yönetici bütün komutlara, diğer kabul edilmiş kullanıcılar izin verilen komut adları ve help/whoami tabanına erişir.

Bu nedenle iki ters genelleme de yanlıştır: “ortak onay handler'ında user-id argümanı yok, herkes yazabilir” denemez; çünkü önceki giriş ve komut kontrolleri vardır. “Sohbet edebilen herkes yalnız kendisine ait pending kaydı onaylar” da bu kaynaklardan çıkmaz; ortak replay işlevi böyle bir kişi-bağlı kayıt kontrolü yapmaz.

**SOURCE OBSERVATION — M3-S09:** Policy resolver verilen `gateway_config.platforms[source.platform]` ve chat_type üzerinden çalışır; `source.profile` alanını doğrudan kullanmaz. Bu turdaki differential test, aynı verilen config ile yalnız profile adını değiştirdiğinde kararın aynı kaldığını doğruladı. **Bu, gerçek multiplex deployment'ın yanlış profile policy uyguladığını kanıtlamaz.** Verilen config'in lifecycle'ı, per-profile değişimleri ve adapter-specific admission ayrı incelenmelidir. İsim/profil etiketi tek başına authorization nesnesi değildir.

### 2C. Ajan meşgulken aynı yol kullanılmıyor

**SOURCE OBSERVATION — M3-S04/S05:** `/memory` ve `/skills`, idle handler tablosundadır; plain mid-run tablosunda değildir. Busy dispatcher special handler veya plain handler bulamazsa komutu reddeden metin döndürür. Normal inbound busy yolu komut erişimini ayrıca kontrol eder.

Bu, bir UI düğmesinin veya ortak helper'ın doğrudan çağrılmasıyla normal gateway mesajının eşdeğer olmadığını gösterir. **Sınır:** In-process busy seçimi bütün profildeki diğer session'ları, başka process'leri veya bütün background yazarları kilitleyen global transaction değildir. Buradan M2'nin eşzamanlılık soruları kapanmaz.

## 3. Gerçek CLI ve gateway hangi store'u veriyor?

| Kaynakta açılan yüzey | Ortak onaya verilen bellek | Bu kaynakta görülen yenileme davranışı |
|---|---|---|
| CLI `_handle_memory_command` | `self.agent._memory_store` varsa o canlı nesne; yoksa `load_on_disk_store()` | Handler, var olan canlı store'u yeniden yüklemiyor; fallback yeni store yüklüyor. |
| Gateway `_handle_memory_command` | Her çağrıda `load_on_disk_store()` sonucu | Ortak onaya açıkça yeni disk görünümü veriliyor; cached agent'ın store'u seçilmiyor. |
| Ortak `handle_pending_subcommand` | Caller'ın verdiği store | `_apply_one` bunu `apply_memory_pending`'e geçiriyor; gerçek UI kimliği parametre olarak bu helper'a taşınmıyor. |

**Kaynaklar:** M3-S01/S02 ve eski M2-S02/S03; yalnız ortak helper docstring'ine dayanılmadı, actual callsite gövdeleri açıldı.

**M2 ile birleşen koşullu çıkarım:** M2'nin hata anında canlı-store/disk ayrışması, CLI aynı nesneyi elinde tuttuğunda sonraki kullanımlar için anlam taşıyabilir. Gateway onay handler'ı ise kısa ömürlü fresh store verir. Bu iki yüzeyde hata sonrası etkilerin süresi aynı varsayılmamalıdır. Bu tur gerçek CLI veya cached-gateway üzerinde yazma hatası oluşturulmadığı için etki süresi runtime doğrulanmış değildir.

Gateway handler'ının docstring'i uzun ömürlü ajan olmadığı izlenimi verse de aynı kaynak ailesinde cached/resident agent helpers vardır. Güvenilir gözlem “bu onay handler'ı fresh store geçiriyor”dur; “gateway'de hiçbir uzun ömürlü ajan bulunmaz” değildir.

## 4. Profil/home, pending kayıt ve onaylayan kimlik

**SOURCE OBSERVATION — M3-S03/S06/S08 ve M2 arşivi:** Pending dosyası `get_hermes_home()/pending/<subsystem>/<id>.json` altında seçilir; bellek yükleyici de active home altındaki memories'e gider. Primary multiplex wrapper routed home kapsamında handler'ı çağırır. `_gateway_config_home` varsa home override'ını, yoksa launch home'u seçer. Gateway approval-mode setter bu yolu kullanarak config yazar ve ilgili session'ın cached agent'ını evict eder.

Bu kaynakta iki işlem farklıdır: **`approval on/off` config değiştirmesi** setter/eviction yolundan geçer; **`approve <id>` kayıt uygulaması** common apply yolundan geçer. Mode setter'ın cache eviction yapması, her approve işleminde cache'in yenilendiğinin kanıtı değildir.

**SOURCE OBSERVATION — eski exact write_approval / commands:** Pending record id, subsystem, action, summary, origin, creation time ve payload taşır. Common helper, onaylayanın user-id'sini almaz; payload'ı uygular. `origin=background_review`, onaylayan kişinin kimliği değildir. Bu kayıt seviyesinde `approved_by` ilişkisi kurulmuş sayılmaz. **Global audit yokluğu iddiası yapılmıyor:** dış event/session/log/ledger sistemleri ayrı kanıt gerektirir.

**TEST SOURCE INSPECTED — M3-S10:** Upstream regression, routed scope içinde memory/skills `approval on` çağrılarını yapıp default config bytes'ının değişmediğini kontrol ediyor. Ama scope test tarafından önceden açılıyor, event source=None ve eviction no-op. Bu testin kodu incelendi; çalıştırılmadı. Normal mesajın route/admission zincirini, gerçek kullanıcı yetkisini veya cache yenilenmesini bu fixture kanıtlamaz.

## 5. Önizlem, uygulama ve kuyruğu temizleme

**SOURCE OBSERVATION — M3-S02:** Gateway skills onayı kapalı olsa bile bekleyen kayıtlar varsa pending komutlarına geçer; böylece önceden hazırlanmış kayıtların sırf mode değişti diye erişimi kesilmez. Hiç kayıt yok ve mode değiştirme komutu da değilse gate-off mesajı döner.

Gateway `diff` çıktısını 3000 karakterden sonra kesiyor ve `~/.hermes/pending/skills/<id>.json` yolunu gösteriyor. Bu, actual UI'nin her diff'i eksiksiz gösterdiği varsayımını sınırlar. İşaret edilen dosya serialized pending record'dur; mutable target'tan hesaplanan diff'in sabit bir kopyası değildir. Ayrıca gösterilen metin literal default path'tir; active routed home başka olduğunda gerçek pending yolu ile gösterim aynı kabul edilmemelidir. **Bu tur farklı profilde gerçek UI yönlendirme deneyi yapılmadı.**

M2/N11'de görülen apply-success/pending-unlink-failure ayrımı common handler'da hâlâ açıklayıcıdır: apply başarılıysa discard çağrılır, fakat discard boolean'ı başarı sayacını kontrol etmez. Bu tur N11 tekrarlanmadı. Gerçek arayüze bağlanan source trace, eski sonucu otomatik bütün deployment'lara genellemez.

U01B2'nin canlı önizlem/hedef revizyonu bulgusuyla birlikte: kullanıcıya gösterilen metin, saklanan öneri, onaylanan hedef revision ve uygulama sonrası durum ayrı kayıt/ölçüm yüzeyleridir. Bu ayrım üst araştırma modeline taşınabilir; bir ürün açığı veya SOUL mimari kararı olarak otomatik benimsenmez.

## 6. Kaydetmekten sonraki model görünümüne geçiş

**SOURCE OBSERVATION — M3-S12/S13:** `_memory_parts`, enabled target'lar için store'un `format_for_system_prompt` çıktısını kullanır; önceki M2 kaynağında bu frozen snapshot'tır. `build_turn_context`, cached system prompt None değilse restore/build çağırmadan onu kullanır. `invalidate_system_prompt` cached prompt'ları temizler ve memory store'u diskten yükler; sonraki build artık yeni snapshot'ı kullanabilir.

Bu yüzden beş ayrı olay izlenmelidir:

`pending apply → kalıcı dosya → store/snapshot reload → cached prompt invalidation/rebuild → gerçek request seçimi`.

Normal approve handler'larında doğrudan invalidate çağrısı görülmedi. Bu sınırlı yokluk, o handler gövdeleri içindir; tüm caller/adapter/compaction yollarında invalidation bulunmadığı iddia edilmez. System-prompt modülü rebuild'i compression sınırına bağlayan açıklamalar taşır; bütün compression/failure/keep-prompt/restore dalları bu tur kapanmadı. Modül başlığındaki “yalnız compression” cümlesini bütün ürün için evrensel yasa yapmıyoruz.

**Açık ayırıcı soru:** Mevcut session prompt'u DB'den yeniden restore edildiğinde, yeni AIAgent/new store bile eski sistem mesajını tekrar kullanabilir mi; hangi invalidation/compaction yolu yeni dosya içeriğini gerçekten request'e taşır? Bu turun source trace'i buna önkoşul sağlar, fakat gerçek outbound request yakalanmadı ve provider çağrılmadı.

## 7. Çalıştırılan yeni kanıt: sekiz ek-komut-yetkisi senaryosu

S09 tam 5666 byte olarak canonical Git hash'ine eşleştirildi. SPEC ilk koşudan önce yazıldı. Python 3.13.5/Linux, UTC `2026-09-10T05:12:08.954654+00:00`; tam sonuç POLICY-RESULT.json'dadır.

| ID | Gözlenen ayrım |
|---|---|
| SA01 | Yönetici listesi yokken bu ikinci gate kapalı; sırf user-command listesi bulunması kısıtlamayı etkinleştirmiyor. |
| SA02 | DM admin listesi guest memory/skills'i reddediyor; help/whoami tabanı ve admin izinleri korunuyor. |
| SA03 | Config command adı normalize ediliyor; memory grant kaldırılınca ret geri geliyor; caller'ın canonical adı kullanması gerekiyor. |
| SA04 | DM admin listesi group gate'i tek başına etkinleştirmiyor; iki scope etkinse DM admin'i group admin'i sayılmıyor. |
| SA05 | DM command listesi boşken group command-list fallback'i var; group administrator kimlikleri ödünç alınmıyor. |
| SA06 | Aynı verilen config ile yalnız source.profile değişimi karar değiştirmiyor; config değişimi kararı değiştiriyor. |
| SA07 | Config/platform config eksikliği bu ek gate'i kapatıyor; bu, önceki admission'ın olmadığı anlamına gelmiyor. |
| SA08 | Boş/None chat_type group dalına gidiyor; normal dm ile aynı değil. Gerçek adapter source normalizasyonu bu deneyin dışında. |

Sekiz önceden kaydedilmiş tanılayıcı beklenti karşılandı. Ayrıca bozuk kaynak kopyası aynı gerçek pre-import guard tarafından reddedildi. Bunlar ürün başarı puanı, kullanıcı kimlik doğrulaması, whole-gateway deployment güvenliği veya bağımsız araştırmacı doğrulaması değildir. Test sadece S09'u ithal eder; source/config fake holder'dır. M2 veya worker deneyleri tekrarlanmadı.

## 8. Sonuç, kalan sorular ve araştırma sırası

**Bu tur cevaplanan sınırlı soru:** Gerçek CLI/gateway onay callsite'ları, ek gateway admission/command/busy kontrolleri ve verilen live/fresh store bağlantısı kaynakta açıldı. Onay, profil/home, kişi kimliği, etkiler, cleanup ve prompt görünümü tek olay değil. Bu mekanizma daha önce yalnız ortak helper deneyiyle açıklanamıyordu.

**Kapanmayan:** Bütün transport'larda uçtan uca çalıştırma, gerçek identity/profile/config lifecycle, gerçek cached agent ve request readback, skill replay'in ownership/ledger yan etkileri, cross-session/process locking, Q26 tam worker/fidelity. SA06 profile duyarlılığı bir deployment kusuru hükmü değildir; SA08 normal adapter'ların eksik chat_type ürettiği iddiası değildir.

**Sonraki öncelik:** Yeni kanıtın canonical yayını kapanmadıysa önce yayın. Sonra `_restore_or_build_system_prompt` ve compression/keep-prompt/cached-agent yaşam döngüsünü exact kaynakla takip edip, provider'a bağlanmadan hazırlanmış request/prompt değişimini ölçen sınırlı test mümkün mü belirle. İlgili halka kapandığında ledger/backup/restore/sync → skill/cache → curator nested batch/report/cron sırası korunur. Aynı sekiz veya eski on iki fixture'ın tekrar sayısı artırılarak ilerleme üretilmez.

F01–F12 geniş araştırması, önce HERMES-native model sonra dört-alan/SOUL/Development OS değerlendirmesi korunur. Bu bir kurulum, benimseme, mimari veya upstream onarım kararı değildir.
