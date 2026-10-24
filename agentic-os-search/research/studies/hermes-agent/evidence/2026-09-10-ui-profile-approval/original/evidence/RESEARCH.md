# U01-M3 — Gerçek onay girişleri, profil yönlendirmesi ve bellek bağlama

**Tarih:** 2026-09-10. **Statü:** PINNED SELECTED SOURCE TRACE + ONE FULL-MODULE ACCESS-POLICY DIAGNOSTIC. Tam HERMES/UI/worker doğrulaması değildir.

**Research tabanı:** `batuhanozgun/agentic-os-search@91af4415c22e05b80484b935383ceeb04a3c5b7b`, plan v0.9. **Upstream pin:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Kaynak kimlikleri ve okuma derinliği [SOURCES](SOURCES.md); yeni dar koşu [ACCESS-RESULT](ACCESS-RESULT.json), [SPEC](SPEC.md), [kod](access_probe.py).

## 1. Araştırma sorusu ve gerçek ilerleme

Önceki M2, ortak memory/pending işlevlerinde disk, canlı nesne, frozen snapshot, hata yanıtı ve pending kaydının ayrı değişebildiğini göstermişti. Ancak gerçek arayüzün hangi nesneyi verdiği ve onay komutuna kimin erişebildiği açık kalmıştı. Bu tur aynı N01–N12 örneklerini tekrar etmez; gerçek CLI/gateway çağrı noktalarını ve onların dışındaki kabul/yönlendirme katmanlarını açar.

Kaynaklardan kurulan bounded geçiş:

`adapter / mesaj kaynağı → profil kapsamı ve mesaj kabulü → canonical komut erişimi → idle/busy dispatch → /memory veya /skills handler → verilen store / ortak apply → sonuç ve pending temizliği → ayrı prompt/reload yaşam döngüsü`.

Bu satır, bütün geçişlerin canlı sistemde beraber çalıştırıldığı anlamına gelmez. Özellikle son prompt/request halkası ve bazı adapter varyantları hâlâ açıktır. HERMES-native mekanizma araştırması sürer; Foundation veya mimari benimseme kararı verilmez.

## 2. CLI ve gateway aynı komuta aynı bellek nesnesini vermiyor

**OBSERVATION — UI01, UI02, M2-S02/S03.** CLI'nin `_handle_memory_command` işlevi, mevcut `self.agent._memory_store` varsa onu verir. Yoksa `load_on_disk_store()` ile yeni nesne oluşturur. Ardından `handle_pending_subcommand(wa.MEMORY, args, memory_store=store, ...)` çağrılır. Bu artık ortak handler'ın docstring'inden çıkarılmış bir tahmin değil, gerçek CLI callsite'ıdır.

Gateway `_handle_memory_command` her çağrıda `load_on_disk_store()` verir. Bu yükleyici normal dalda güncel config'den limit ve etkinlik bayraklarını alır, sonra diski yükler. Config/nesne kurma bölümündeki exception varsayılan `MemoryStore()` yoluna döner; `load_from_disk()` bu try bloğunun dışındadır. Dolayısıyla docstring'deki 'never raises' ifadesi, her dosya sistemi hatasının yutulduğu şeklinde okunmamalıdır. Bu dal bu tur çalıştırılmadı.

**M2 ile birlikte sınırlı çıkarım:** M2/N02–N09'daki 'dosya eski, canlı nesne yeni' durumu, CLI'nin gerçekten çalışan store'u verdiği dalda daha uzun yaşayan bir nesneye dokunabilir. Gateway handler'ın yeni oluşturduğu nesne ise doğrudan aynı cached-agent nesnesi değildir. Arayüz etkisinin süresi, hata yakalayan üst katman ve sonraki reload hâlâ ayrı sorulardır; M2'nin sentetik yazma hatası bu tur gerçek CLI'ye enjekte edilmedi.

CLI `_save_write_approval`, `<subsystem>.write_approval` ayarını `_save` üzerinden kaydeder. Bu ayarın değiştirilmesi, store'un memory/user etkinlik bayraklarıyla veya frozen snapshot yenilenmesiyle aynı işlem değildir.

## 3. Mesaj kabulü ile onay komutunu kullanma hakkı ayrı katmanlar

**OBSERVATION — UI03/UI04/UI05/UI06.** `run_inbound._hm_admit_event` normal dış mesajı `_is_user_authorized_for_source` üzerinden geçirir. Profile-route rejection ayrıca düşürülür. Internal işaretli olayların ayrı dalı vardır; bu dalın bütün üreticileri burada denetlenmedi. Yetkisiz göndericinin pairing yolu, bir memory yazısına onay verme işlemi değildir.

Bundan sonra cold-path canonical komut kapısı ve running-agent yolu `_check_slash_access` çağırır. Bu işlev `policy_for_source(self.config, source)` ve `policy.can_run(source.user_id, canonical_cmd)` kullanır. Anahtarlar platform ile DM/grup kapsamıdır. İncelenen çağrıya subcommand/pending-id gönderilmez.

Tam `slash_access.py` kaynak mantığında, ilgili kapsamın admin listesi boşsa ek slash gate kapalıdır. Bu, internetteki herkesin gateway'e erişebildiği anlamına gelmez: normal mesaj kabulü önceki ayrı kapıdır. Gate etkinse adminler tüm canonical komutları; diğer kullanıcılar help/whoami tabanını ve yapılandırılmış komut listesini kullanabilir.

**Granularity sonucu:** Standart kapı `memory` adını yetkilendirir; `memory pending`, `memory approve` ve `memory approval off` için ayrı izin nesneleri üretmez. Ortak handler daha sonra bu alt-komutları ayırır. Buradan 'gerçek bir yetkisiz kullanıcı ayarı değiştirdi' sonucu çıkarılmaz. İsteğe bağlı hook'lar ek kontrol getirebilir; bu tur onların tümü incelenmedi. Desteklenen ayrım, bu yerleşik kapının yetki biriminin canonical komut olmasıdır.

## 4. Çalışan ajan varken onay komutunun konumu

**OBSERVATION — UI04.** `memory` ve `skills`, `_IDLE_COMMANDS` içindedir; `_PLAIN_COMMANDS` veya özel busy-handler haritasında değildir. İncelenen `_dispatch_busy_slash_command`, uygun mid-run handler bulamadığında komutu reddeden yanıt döndürür. Normal pending komutunun 'busy' mesaj yolunda doğrudan mutator'a düşeceği varsayımı bu kaynakla desteklenmez.

**Sınır:** Bu aynı konuşmanın running-agent yolundaki kontrolü açıklar. Başka session, process, CLI, background review veya aynı profile bağlı diğer yazarların tümünü kilitlediğini göstermez. 'Busy komutu reddediyor' ile 'profil belleğine başka hiç kimse yazamaz' aynı garanti değildir. Gerçek concurrency testi yapılmadı.

## 5. Mesajı kabul eden profil ile çalışma profili aynı kimlik olmak zorunda değil

**OBSERVATION — UI07/UI08/UI09.** Adapter bağlantısındaki callback wiring, primary message handler'ı kurar. Multiplex etkinse `_make_default_profile_message_handler` seçilir. Bu wrapper launch/transport home'unu `source._authorization_profile_home` alanında tutar; kaynağın route bilgisinden çalışma home'unu çözer ve `_async_profile_runtime_scope(profile_home)` altında `_handle_message` çağırır. Explicit route rejection, inbound fail-closed kapısına taşınır.

`run.py._is_user_authorized_for_source` transport'un profilini esas alma sözleşmesini taşır; `authz_mixin` ayrıca `_transport_adapter_ref` üzerinden gerçekten kayıtlı receiving adapter'ı çözer. `source.profile` çalışma yönlendirmesi nedeniyle adapter profilinden farklı olabilir. Bu nedenle yalnız bir `profile` alanına bakarak bütün yetki ve depolama ilişkisini açıklamak eksiktir.

Tam okunan `profile_routing.py`, route discriminator'larını birlikte eşleştirir; daha özgül route'ları öne alır. Route eşleşmesi tek başına kullanıcı authorization kararı değildir. `_make_profile_message_handler` adlı secondary-adapter wrapper ise oluşturulduğu profile home'una bağlanır; onun bütün route/relay varyantlarının primary wrapper ile eşdeğerliği kurulmadı.

**Yük taşıyan ayrım:** admission identity, transport ownership, routed execution home ve MemoryStore nesnesi dört farklı rol taşır. Bunları ayırmak çoklu profilde yanlış hedef varsayımını azaltır; tüm profile izolasyonunun doğrulandığı iddiasını üretmez. Gerçek secret/credential okunmadı veya kullanılmadı.

## 6. Yazının onaylanması, onay modunun değişmesi ve cached agent yenilemesi farklı

**OBSERVATION — UI02/UI10.** Gateway `_write_approval_setter` dosya yolunu `_gateway_config_home()/config.yaml` ile kurar, ilgili bölümün `write_approval` değerini yazar ve o session key için `_evict_cached_agent` çağırır. Ancak bu callback ortak command dispatcher tarafından `approval`/`mode` alt-komutunda kullanılır. `approve <id>` dalında `_approve` çağrılır; başarılı apply ve pending silme çalışır. Bu iki dal birbirinin yerine geçmez.

Gateway memory handler'ın gövdesinde approve sonrasında resident store'u yenileyen veya cached prompt'u invalid eden ek çağrı görülmedi. Aynı kaynak ailesi `_cached_agent_for`, `_resident_agent_for` ve ayrı agent-cache mekanizması da taşır. Bu, handler docstring'indeki 'gateway has no long-lived agent' cümlesinin bütün gateway mimarisini anlatan evrensel bir varsayım olarak kullanılamayacağını gösterir.

**Açık soru:** Bir onaydan sonraki ilk normal gateway turunda mevcut agent tekrar kullanılıyor mu; farklı cache/config/turn/compression yolu belleği yeniden yüklüyor mu; modele hazırlanan gerçek istekte hangi sürüm var? Bu tur yalnız `_agent_config_signature` ve cache-busting config girişleri seçili olarak incelendi. Bellek dosyası değişikliğinin bütün cache key/refresh yüzeylerinde bulunmadığı iddia edilmiyor. 'Onaylanan bilgi hiç kullanılmıyor' veya 'mutlaka hemen kullanılıyor' sonuçlarının ikisi de erken olur.

**Test kaynağı sınırı — UI11:** `test_slash_config_writes_routed_profile.py` gerçek handler'ları bir önceden kurulmuş `_profile_runtime_scope` içinde `approval on` ile çağırıp routed config'in değiştiğini, default config'in korunmasını kontrol eder. `_evict_cached_agent` fake/no-op'tur. Test bu tur okunmuştur, çalıştırılmamıştır. Bu test pending apply, gerçek dış mesaj kabulü veya sonraki prompt tazeliğinin kanıtı değildir.

## 7. Skill onayının platforma özgü sunumu

CLI, tanıdığı pending/approve/reject/diff/approval alt-komutlarını ortak handler'a verir; diğer skill hub işleri ayrı yoldadır. Gateway skills handler'ı da ortak pending komutlarını kullanır. Gate kapalı ve hiç pending yoksa yardım yanıtı verir; gate kapalı fakat pending hâlâ varsa kayıtları ulaşılmaz bırakmamak için ortak handler'a devam eder. `approval`/`mode` bu gate-off yardım koşulundan ayrılır. UI02 kaynakta görülen bu davranış, eski 'gate kapandıysa pending artık uygulanamaz' varsayımını sınırlar.

Tam skill diff'in chat'te gösterim sınırı, gerçek `apply_skill_pending` origin/ownership bağlamı ve U01B2 default-name payload sorusu bu tur kapatılmadı. Ortak komutun varlığı bu aralıkların bütünlüğünü garanti etmez.

## 8. Yeni dar yürütme: altı access-policy durumu

UI05'in 5666 byte tam kaynak kopyası `072042...` Git blob kimliğiyle eşleşti; ancak bundan sonra import edildi. Yalnız standard-library bağımlılıkları ve sentetik config/source/user-id verileri kullanıldı. Aynı pre-import kontrolü değiştirilmiş byte'ları reddetti. SPEC kaynak okumasından sonra, kayıtlı koşudan önce yazıldı; çalışma kaynak-bilgili keşifsel tanılayıcıdır, bağımsız doğrulama değildir.

| Durum | Gözlenen ayrım |
|---|---|
| AP01 | Admin listesi yokken user command listesi tek başına kısıt etkinleştirmedi. |
| AP02 | Etkin DM admin kapısında üye memory reddedildi; admin ve keşif tabanı farklı davranış verdi. |
| AP03 | `/MeMoRy` canonical `memory` iznine dönüştü; `memory approve` literal'i ayrı subcommand yetkisi oluşturmadı. |
| AP04 | DM/grup admin listeleri ayrı kaldı; eksik grup-admin listesi o kapsamın gate'ini kapattı. |
| AP05 | Boş DM komut listesi grup komutlarına fallback yaptı, grup-admin kimliği taşınmadı. |
| AP06 | Gated memory eksik user id ile reddedildi; help tabanı ve eksik-config disabled policy ayrı kaldı. |

Altı tanılayıcı beklenti karşılandı. Bu sayı ürün güvenliği/başarı yüzdesi değildir. Gerçek GatewayRunner, adapter, CLI, pending yazımı, tehdit tarayıcısı, provider veya model isteği çalıştırılmadı. Önceki M2, MW veya C/V koşuları tekrarlanmadı.

## 9. Araştırmanın yeni devam noktası

M2'de açık olan 'gerçek arayüz hangi store'u veriyor?' sorusu standard CLI ve gateway handler'larında artık source-backed olarak cevaplanmıştır. Mesaj kabulü/komut erişimi/primary profile wrapper/busy-path sınırı da eklenmiştir. Bunlar canlı bütün sistem verdict'ine yükseltilmez.

**İlk sonraki ayırıcı iş:** Onaylanmış bir memory yazısının ardından aynı gateway session'da agent cache seçimi → MemoryStore reload/frozen snapshot → cached system prompt → API request oluşturma yolunu pinned kaynakta bağlamak. Normal yazı onayı ile approval-mode config değişimini ayrı senaryolar tut; `Approved 1` mesajını model-visible yenilik oracle'ı yapma. Doğrudan model/provider çağrısı gerektirmeyen kaynak veya kontrollü request-construction gözlemi tercih edilir.

Secondary/relay route varyantları ve gerçek skill apply origin/ownership/default-name bağı ilgili kaynak soruları olarak açık kalır. Q26/Q29'un tam-original/whole-worker koşulları korunur. Ardından ledger/backup/restore/sync, skill/cache reuse, curator nested batch/report/cron ve geniş F01–F12 planına dönülür. Bu dilim ne bütün öğrenme sistemini bitirir ne yeni kurulum/mimari yetkisi verir.
