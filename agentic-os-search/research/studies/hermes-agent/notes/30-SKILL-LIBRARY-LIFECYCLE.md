# 30 — Becerinin saklanması, yönetilmesi ve yeniden kullanılması

**2026-09-13 / U15 / Q59 SOURCE ADVANCED, NOT EXECUTED.** Primaryc4a5deeffa959f8ebc891e02c5bcf767aff1dd2a / manifest0.21.0. [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md), [A](../evidence/2026-09-13-skill-library/SYNC-AND-LOCAL-STATE.md)/[A SOURCES](../evidence/2026-09-13-skill-library/SYNC-SOURCES.md), [B](../evidence/2026-09-13-skill-library/ARCHIVE-LEDGER-AND-DISCOVERY.md)/[B SOURCES](../evidence/2026-09-13-skill-library/DISCOVERY-SOURCES.md), [NOT RUN](../evidence/2026-09-13-skill-library/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-13-skill-library/PUBLICATION.md).

## HERMES-native modele eklenen bağ

Synthesis01, deneyimden öneri/approval ve maintenance'i açıklıyordu. U14 install/update'in kütüphaneyi eşitlediği çağıranları açtı. U15 bunları **dağıtılan kaynak → yerel baseline/değişiklik kararı → bakım/arşiv/geçmiş → geri alma → list/index/view → gözlenen kullanım** zincirinde birleştirir. Bu bir final CORE değil, dört provisional sentez ve note29 ile birlikte okunacak kaynak ekidir.

Normal bundled sync, son dağıtılan içerik baseline'ını current source ve local file ile karşılaştırır: pristine kopyayı yeniler, değişmiş yerel kopyayı korur, kayıtlı kullanıcı silmesini hemen yeniden yaratmaz. Ancak ad, path, origin hash ve kullanıcı niyeti aynı kimlik değildir. V1 ilk-baseline alma, upstream removal/reintroduction ve reset/restore farklı sınırlara sahiptir. Opt-out consumer essential `hermes-agent` istisnası taşır; U14 caller'ın daha geniş blank-state dili bu alt kodla daralır.

## Yönetim ve geri alma nesneleri

Curator-management opt-in tarihsel authorship değildir; kullanıcının adoption'ı yetki değişimidir. Physical archive, sidecar lifecycle ve yeniden seed etmeme suppression'ı ayrı yazılabilir. Ledger her filesystem değişimini izleyen global gate değildir: katılan hook'ların before/after dosyalarını best-effort kaydeder, tek-entry rollback ise zorunlu güvenlik kaydıyla başlar.

Tek mutation rollback'i entry dosyalarını geri getirir; bütün usage/suppression/cron ilişkilerini otomatik geri almaz. Whole-tree snapshot daha geniş kayıt kümesini taşır, fakat Hub/Git metadata'yı dışlar ve canlı cron'un yalnız aynı-ID skill alanlarını uzlaştırır. Bu, bugünkü işleri tümüyle geçmişe döndürmeden bir ilişkiyi geri alma mekanizmasıdır; cron restore hatasıyla skill-tree başarısı ayrı kalabilir.

## Gerçek sonraki tüketici

Listede first-wins isim seçimi vardır; full `skill_view` çoklu ad adayını reddedebilir. Official-optional restore backup'ının `.restore-backups` yolu generic index exclusion'da değildir: aynı adla kalmış kopya, uygun koşullarda canonical kopyayla yükleme çakışması oluşturabilir. Bu actual incident değil, source-composition sonucudur; `.archive` dışlanması ve explicit category yolu karşı durumlardır.

System-prompt index kısa metadata taşır; tool list, in-process/disk cache ve explicit full read farklı tazelik kuralları kullanır. Setup-needed view success taşıyabilir. Repeat-view dedup önceki içeriğe yönlendiren stub dönebilir. Actual `skill_view` wrapper'ı başarılı yüklemeyi view/use sayar; **yüklenmiş veya yeniden kullanılmış diye kaydedilmiş olmak etkili öğrenme/görev başarısı değildir.** Gerçek model isteği ve davranışı bu tur ölçülmedi.

## Kanıt ve devam

14 primary path'ın dokuzu A+B birleşiminde tam metin, beşi selected (iki test dosyası dahil). Hiçbir HERMES modülü/sync/restore/curator/model/DB/OS/suite çalıştırılmadı; no RESULT/PASS. Tam metin full local-byte/AST/dependency closure değil. Normal kontroller ve karşı yollar kaydedildi; source sınırları data-loss/kalite gözlemine yükseltilmedi.

A main'den geri okunduktan sonra B; B geri okunduktan sonra kapsam değerlendirmesi yapıldı. **Next Q60 evaluation/task quality:** gerçek test/eval runner ve oracle hangi başarıyı hangi nesnede ölçüyor? Q59 remote Hub/org authority, all writers/ledger, cache/first request ve fault sınırları hâlâ maddidir. Dört provisional synthesis, eski evidence ve Foundation/control korunur; mimari/adoption yoktur.
