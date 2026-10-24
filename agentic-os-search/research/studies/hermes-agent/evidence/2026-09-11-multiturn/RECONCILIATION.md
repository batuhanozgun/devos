# U04-A / U04-B — Teslim uzlaştırması

**2026-09-11. Kapsam: bilinen 21-durumlu U04 tesliminin yayınlanması; bütün geçmiş sohbet artefaktlarının envanteri değildir.** Kullanıcının son yetkisi yeniden göndermeyi denemektir. Bu tur yeni HERMES araştırması veya deney yapılmadı.

## 1. Neden yeni dosyaları mevcut U04'ün üzerine yazmadık?

İlk main kontrolü `a0585203ca0a2bdd1cc8441aa152d7e4a72128cf` gösterdi. Bu commit'teki STATE/INDEX/PLAN/META ve note18, 15-gruplu başka bir U04 kaydını ve üçüncü provisional sentezi taşıyordu. Bekleyen ZIP farklı bir probe, SPEC, raw RESULT ve 21 durum içeriyordu. Konuların örtüşmesi dosya/koşu kimliklerinin eşitliği değildir.

| Kimlik | U04-A — önceden main'de | U04-B — bekleyen teslim |
|---|---|---|
| Canonical evidence yolu | `2026-09-11-multi-turn-continuity/` | `2026-09-11-multiturn/delivery/` |
| Recorded UTC başlangıcı | `2026-09-11T06:10:29.139368+00:00` | `2026-09-11T06:11:47.964054+00:00` |
| Vaka ID'leri | G01–G10, H01–H05; 15 grup | G01–G12, H01–H09; 21 durum |
| Raw RESULT SHA-256 | `ae5b94ce2e4c540ef72074e4e37bd3f20fe60615c8e126781615b1e08ce7ebf3` | `42929ea7388c9426bcdd08507ce953f14a5ff887296ac9143bbd7bd672d213a7` |
| Probe SHA-256 | `c7e3f2c51d631c8ac6ef4eaf0ad7d980526bbb38e38e82f4ce4cd5e0fd4d2d1e` | `9fb2bef88e069d99233d978c02603cf15acc0aa7b38af0b5e8dc42a13b8e1a38` |
| Ham kayda erişim | [A arşivi](../2026-09-11-multi-turn-continuity/diagnostic-evidence.tar.xz) | [B tam RESULT](delivery/evidence/RESULT.json) |

A karşılaştırması [SPEC](../2026-09-11-multi-turn-continuity/SPEC.md), [SOURCES](../2026-09-11-multi-turn-continuity/SOURCES.md), [derived summary](../2026-09-11-multi-turn-continuity/RESULT-SUMMARY.json) ve [RESEARCH](../2026-09-11-multi-turn-continuity/RESEARCH.md) üzerinden yapıldı; bu tur A raw arşivi tekrar çalıştırılmadı. B ham RESULT/SPEC/probe/input dosyaları doğrudan okundu ve kimlikleri denetlendi. Bu işlem iki koşunun bağımsız tekrar doğrulaması değildir.

## 2. Örtüşme ve maddi farklar

| Konu | Ayrım |
|---|---|
| Own-run terminal ve sahiplik | A'da helper status callback'leri sentetik. B:G02/G03, manuel `goal_run_status` seçkisini gerçek azaltılmış SQLite kayıtlarına bağlar; task writers/get_task fixture'dır. B bu nedenle full Kanban DB koşusu değildir. |
| Block outcome / receipt | A:G04 budget dalında False/exception; B:G08/G09 judge BLOCKED dalında False/exception. Benzer sınır, aynı ID veya aynı scenario değildir. |
| Judge sırasında sahiplik kaybı | A:G06 ve B:G10 kontrollü callback sıralaması taşır. Gerçek process yarışı veya fiziksel iptal kanıtı sayılmaz. |
| Heartbeat yazı hatası | A:H04 fire sonrası live/durable ayrışmasını; B:H07 ilk set sonrası canlı active fakat fresh load'da kayıtsızlığı taşır. |
| İki stale manager | A:H05'e aittir; B:H05 abandon senaryosudur. A kaydı korunur. |
| Session migration | B:H08 normal aktarım; B:H09 selective child-write fault'ta helper True, child yok, parent cleared. A:H04'e mal edilmez; actual Hermes SessionDB/compaction/driver olayı değildir. |
| History'nin yeniden seçilmesi | A:S10 facade admission history substitution okumasını taşır. B'nin daha dar CLI görünümü bu bulguyu silmez; lower lease consumer açık kalır. |
| Negatif kontroller | A superseded/finalize/source identity; B selected run-ID/WAIT/source identity değişikliklerini ayırır. İki paketin kontrol sayıları başarı puanı olarak toplanmaz. |

B:SOURCES'taki full/selected/reused okumalar o özgün dilimin iddialarıdır; bu yayın turunda yeniden upstream okuması yapılmış gibi sunulmaz. A ve B aynı primary pin'i ve birçok kaynak/araştırmacı varsayımını paylaşır. Yerel hash eşleşmesi, manuel seçkilerin tam parent byte/AST sadakatini veya gerçek model kalitesini ispatlamaz.

## 3. Otorite ve soru kimlikleri

Mevcut merkezi synthesis/03, note18 ve tüm A evidence değiştirilmeden korunur. B'nin iki sentez metni ve note18 adayı `delivery/` içinde özgün artefakt olarak kalır; merkezi dosyaların yerine uygulanmaz. Yeni canonical giriş note19, plan v0.17 publication reconciliation'dır. Üç provisional merkez sentezi bulunur; dördüncü completed model veya native CORE ilan edilmez.

B'nin `repo-updates/OPEN-QUESTIONS.md` dosyasındaki numaralar, o eski adayın yerel önerileridir. Mevcut canonical Q40–Q44 yeniden numaralandırılmaz:

| B adayındaki soru | Korunan canonical karşılık |
|---|---|
| B-draft Q40 state_meta/migration | Q41 |
| B-draft Q41 restart/route/in-flight | Q42 |
| B-draft Q42 ownership during judge | Q43 |
| B-draft Q43 failed block reconciliation | Q36 |
| B-draft Q44 gate fingerprint | Q44 |
| B-draft Q45 loop stop semantics | Q45 olarak açık candidate soru |

Canonical Q40 ilk giriş olarak actual session lease/history sorusudur. Sıra değişmedi: turn facade lease/history → gerekli manager save/migration ve driver recovery. B:H09 bu zincir için ayırıcı kayıt, actual DB tüketicisinin yerine geçecek fixture değildir.

## 4. Aktarım ve yayın kontrolleri

Özgün ZIP 73,425 byte, SHA-256 `b2a36c43160af93b1bbb66f3cca0685a4289ecd7f05a0d781e44535ad7420008`. Güvenli çıkarılan 33 regular dosyanın byte'ları değiştirilmedi. Native `delivery/` Git tree kimliği `d01c92f7414713300934be3bb4e3d40ac57631b3`; yerelde tüm dosyalardan hesaplanan kimlikle GitHub create_tree dönüşü eşleşti. [DELIVERY-MANIFEST](DELIVERY-MANIFEST.json), özgün [MANIFEST.sha256](delivery/MANIFEST.sha256) ve tam ham kayıt birbirine bağlıdır. Sadece JSON/Python parse, hash ve kayıtlı input/probe/SPEC tutarlılığı kontrol edildi; probe ve hazırlık script'i gerçek repoya karşı çalıştırılmadı.

İlk kontrolden sonraki main `bc9f404e064bea91284e34f1a864397df172e857` oldu. Karşılaştırma yalnız Foundation değişiklikleri gösterdi; bunlar korunur. Yeni dizin bu ref'te mevcut değildi. Yayın adayı güncel main tree'sinden kurulur; sadece HERMES çalışma alanı ve katalogdaki HERMES satırı değişir. Ref force olmadan ilerletilir; gerekiyorsa anlık PR merge kullanılır. Ayar, izin, credential veya başka repo değiştirilmez. Bu tur yazma araçları gerçekten çalıştı; bundan önceki erişim hatalarının kök nedeni çıkarılmaz.

Son başarı hükmü Git nesnesi üretiminden değil, main referansı ve bu dosyalar üzerindeki gerçek geri okumadan gelir. Commit'in kendi kimliğini metin içine önceden tahmin etmiyoruz. Eski `delivery/` yayın-engeli ifadeleri creation-time kaydıdır ve bu uzlaştırma onları current blocker olmaktan çıkarır.
