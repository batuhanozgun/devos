# U07 — Yayın ve geri okuma makbuzu

**2026-09-11 / PUBLISHED TO MAIN — CONTENT VERIFIED.** Kullanıcının yeniden gönderme isteğiyle özgün U07 teslimi yayımlandı. Bu tur yeni HERMES araştırması, probe, model/provider çağrısı veya bağımsız tekrar yapılmadı. [STATE](../../STATE.md) U07 / plan v0.20; bütün HERMES araştırması hâlâ ACTIVE PARTIAL RESEARCH. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [MANIFEST](MANIFEST.json), [RESULT](RESULT.json).

## Gerçek yayın ve kapsam

Başlangıçta ve ref güncellemesinden hemen önce okunan main: `d928ee14b16a277c010a966816fc2c4097944aab`. Paket tabanıyla aynıydı; eşzamanlı head farkı yoktu.

**İçerik commit'i: `56ffbfa608d6734ade1850198350726db0c5d05e`.** Parent yukarıdaki main; içerik tree'si `7c83e20423d244440ec8e2bea111892eb78616fa`. Native compare ahead_by=1, behind_by=0 ve merge-base=d928 gösterdi. **19 yol: 12 yeni dosya, 7 güncelleme; silme veya taşıma yok.** CATALOG için tek satır ekleme/çıkarma, diğer değişikliklerin tamamı HERMES package içindedir.

`main` ref'i `force=false` ile ilerletildi. Ardından gerçek `git/ref/heads/main` yeniden okundu ve `56ffbfa608d6734ade1850198350726db0c5d05e` döndü. Bu makbuz, doğrulanmış içerik yayınının ardından yalnız PUBLICATION.md'yi günceller; kendi sonraki commit kimliğini önceden bildiğini iddia etmez. Makbuzun ref/diff/content geri okuması ayrıca yapılır. Yeni branch, PR veya force push yoktur.

İlk teknik turda sunulmayan native write eylemleri bu yeniden gönderme turunda sunuldu ve kullanıldı. Bu değişikliğin nedenine veya repository izinlerine ilişkin teşhis yapılmadı. Eski başarısız girişim aşağıda korunur; artık güncel yayın engeli değildir.

## Aktarım sadakati ve doğrulama sınırı

Teslim ZIP SHA-256: `473b3ad8ad78692455cb2cdb895174fb05063b869a16688fa8263ed23fd57b40`. Read-only paket validator'ı 19 candidate yol, 24 regular arşiv üyesi, sekiz SQLite snapshot'ı ve source/SPEC/probe/RESULT bağlarını doğruladı. HERMES probe'u çalıştırılmadı; mevcut DB kopyaları immutable/read-only incelendi.

GitHub'da **dokuz dosyanın blob kimliği doğrudan** okundu: CATALOG, altı current entry, note22 ve coverage. **Kalan on evidence dosyası**, yerel bytes'tan hesaplanan Git tree ile uzak bağlı subtree'nin aynı olmasıyla birlikte doğrulandı: `95f95020decd615fbfee3d85a99da7bd139f025d`. Bu eşleşme dosya adlarını, modlarını ve bütün içerik blob'larını bağlar; yalnız dosya varlığı kontrolü değildir. Raw archive create_blob dönüşü ayrıca yerel beklenen blob ile eşleşti.

**On dosya özgün teslimle byte-eşit kaldı:** RESEARCH, SOURCES.md/json, SPEC, RESULT, MANIFEST, ARTIFACT-CHECKS, raw archive, note22 ve coverage. **Dokuz dosya yalnız yayın devri için uzlaştırıldı:** STATE/INDEX/META/PLAN/OPEN-QUESTIONS/SOURCE-LEDGER, CATALOG HERMES satırı, evidence README ve PUBLICATION. Son makbuz güncellemesi deney veya araştırma içeriğini değiştirmez.

CATALOG baseline blob `8483cbd792542561eef926a83fc66349dcc06a17`, yayımlanan blob `68f7a083b9b1a6ca84e4b259783d5bcc00271eda`. HERMES satırı çıkarıldığında kalan byte'lar aynıdır; native compare da 1 addition / 1 deletion gösterdi. Foundation, soul-context, agent-control, explorations, diğer studies, HERMES METHOD, notes01–21, eski evidence ve merkezi syntheses01–03 değişen yollar arasında yoktur. Synthesis subtree `49d86a6d6c70317c2098b6f9153e8cfe02c4f43d` ve U04-A/B evidence subtree kimlikleri korunmuştur.

## Önemli içerik kimlikleri

| Yüzey | Doğrulanan Git blob / kapsam |
|---|---|
| STATE.md | `26d9b5c590b856c439869f4affe80c1c4ff6835c`; main ilerledikten sonra içerik commit'inden tam metin geri okundu. U07/v0.20, yetki, açık sorular ve cold-start yolu mevcut. |
| notes/22 | `a2817b4cafc7de8715c311ed221d96d792a4dfbd`; immutable içerik commit'inden tam metin geri okundu. |
| CRON-COVERAGE | `2e20ad932ef02dca02f14ec8d1c9c18b469ed899`; aynı şekilde tam metin geri okundu. |
| RESULT.json | `bcf896971c559fb21fa4453e1a6be0d500e3b330`; 18.713 byte; özgün arşiv kopyasıyla eşit ve evidence-tree üzerinden bağlı. |
| SPEC.md | `9ad48c81732becdf9a009781e2dd1f8f8db889e7`; arşiv kopyasıyla eşit, aynı tree doğrulaması. |
| RESEARCH.md | `b010e776fba8717de0e411d38eb8251384f09da9`; 22.484 byte; yerel tam okuma ve uzak evidence-tree kimliği. |
| MANIFEST.json | `b9962f5692f42b91a29025760375a9ed9ee72fb4`; özgün manifest korunur. |
| diagnostic-evidence.tar.xz | `b42a8116e38fa7fe2d58fff52476e7b347c7e191`; 13.912 byte; 24 regular üye. Uzak binary yeniden indirilip çalıştırılmadı. |

Raw RESULT SHA-256 `c53f850cceaad5e84eb800ce88b02c9a4eb227a00d82ee1714aecaefe7b51719`; archive SHA-256 `4fdf2481f64ef6b1ee1ac177f43f727958f7769cf976276266be71a570b9644b`. Hash/tree/parse kontrolü aktarım sadakatidir; semantik doğruluk, actual SessionDB/gateway/network/OS restart/model kalitesi veya bağımsız replication kanıtı değildir. U07'nin D01–D06, N00–N02 ve attempt-00 kayıtları aynı kalmıştır.

## Tarihsel unpublished ifadeler ve yeni oturum

**MANIFEST.json içindeki `publication_status: local delivery; not published to main` alanı, ilk teslim anına ait özgün metadata'dır.** Note22, RESEARCH, SOURCES ve coverage içindeki unpublished/NOT PUBLISHED açıklamaları da kendi tarihsel banner'larıyla korunur. Bunlar güncel yayın hükmünü geçersiz kılmaz; güncel work authority STATE, yayın makbuzu bu üst bölümdür. İlk başarısızlık kaydı veya paket-local validator sonucu güncel main statüsü sanılmamalıdır.

**Yeni oturumun U07'yi geri kazanması için eski sohbet ZIP'ine gerek yoktur.** Canonical STATE/INDEX/plan → note22 → evidence README/PUBLICATION/SOURCES/RESEARCH/SPEC/RESULT/MANIFEST/raw yolu kullanılabilir. U04–U06 tekrar yapılacak işler değildir. Q40/Q42 ve diğer açık doğrulamalar kapanmadı. Sonraki mantıksal teknik birim actual cron gateway drainer/status receipt, ardından occurrence/rearm ve run_job/context'tir; bu yayın isteği yeni araştırmayı otomatik başlatmadı.

---

## İlk U07 girişimi — tarihsel özgün kayıt

Aşağıdaki “NOT PUBLISHED”, “main U06” ve “write yok” ifadeleri ilk teknik turun anlık durumudur. Güncel yayın hükmü bu dosyanın üst bölümünden okunur; aşağıdaki tarihçe yeni bir engel veya yeniden yapılacak deney değildir.

# U07 — Yayın yapılamadı: write eylemleri bu tur sunulmadı

**2026-09-11 / NOT PUBLISHED TO MAIN.** Bu dosya bir yayın başarı makbuzu değildir. Yeni U07 source study ve sınırlı queue/SQLite koşusu yerel teslimde korunur. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json).

## Gerçek canonical durum

Başlangıçta ve teknik çalışma/teslim hazırlığı sonunda `git/ref/heads/main` bağlı GitHub üzerinden tekrar okundu:

**`d928ee14b16a277c010a966816fc2c4097944aab` — U06/v0.19 yayın makbuzu.**

Son ek STATE readback: `main` üzerinden 1–24 satırları U06/v0.19 başlığını ve `34a0b9894c6d05fbf5f07e50e127c0b18ab92963` blob'unu tekrar döndürdü. Bu gerçek uzak okuma yalnız yayımlanmış U06'yı doğrular; yerel U07 dosyalarını uzaktan doğrulamış değildir.

U06 içerik commit'i `8779ce350b32d5a1ccee6fa48c31604dd93616cc` main'dedir. U04-A/B, U05 ve U06 yayınları tamamlanmış iştir; eski U06 ZIP'ini yeniden göndermek gerekmez. **Yeni bekleyen çalışma yalnız U07'dir.** Candidate v0.20 dosyaları remote main'e bağlanmadı; yeni oturum yalnız main okursa U07'yi bulamaz.

## Bu tur sunulan capability

GitHub create_tree discovery boş döndü; full GitHub listesi 48 read/search eylemi sundu, dosya/commit/ref write eylemi göstermedi. Son write query de boştu. Plugin directory GitHub'ın installed/enabled olduğunu doğruladı; bu nedenle plugin yok veya repo bağlantısı kesildi denmedi. Yerel ortamda gh komutu yoktu; credential aranmadı, izin/ayar değişmedi, yeni plugin/bağlantı kurulmadı.

**Create/update/commit/update_ref/write çağrısı yapılmadı; branch/PR oluşturulmadı.** Read aracına gizli write semantiği yüklenmedi, alternatif endpoint/encoding ile kısıt dolaşılmadı. Araçların bu tur write eylemi sunmaması GitHub repository izninin iptal edildiğine kanıt değildir. Önceki U06'daki tool safety block da farklı olaydır; bu kayıtta U06 başarısızlığı güncelmiş gibi tekrarlanmaz. Neden capability setinin değiştiğine teşhis verilmez.

Bağımsız kaynak erişim sınırı da vardı: upstream gateway/run.py 3150–3325 isteği 429; bu source-read engeli publication capability yokluğuyla birleştirilmez. Diğer cron kaynakları okunabildi, native queue diagnostic kurulabildi.

## Yerel olarak doğrulanan

Full queue kaynağı `689fd620d6193003bbd168a0e62770a0d0306ac6` ve MIT license `75410e73319c72cd3e991a501c5455eb78f38375` Git blob'larıyla eşleşti. SPEC/probe/input/RESULT bağları doğrulandı. Altı ordinary vaka ve N00–N02'nin özgün kayıtları, attempt-00 metadata hatası, stdout/stderr ve sekiz final DB snapshot'ı korunur.

24 regular üyeli raw archive 13.912 byte; SHA-256 `4fdf2481f64ef6b1ee1ac177f43f727958f7769cf976276266be71a570b9644b`, Git blob `b42a8116e38fa7fe2d58fff52476e7b347c7e191`. Native SPEC/RESULT arşiv kopyalarıyla byte-eşittir. Artifact kontrolleri yeni HERMES davranış deneyi veya independent replication değildir. Sekiz final DB snapshot'ı immutable read ile integrity=ok verdi; boş WAL/bookkeeping ve bytecode exclusion'ları manifestte açıkça listelendi, behavioral failure dışlanmadı.

Beş eski entry ile CATALOG baseline'ı eski U06 paketinden ancak yayımlanmış exact blob eşleşmesiyle materyalize edildi; current v0.19 dosyaları bu tur GitHub'dan da okundu. Eski unpublished U06 STATE/PUBLICATION/README baseline yapılmadı. Current STATE blob'u `34a0b9894c6d05fbf5f07e50e127c0b18ab92963`tir. Yeni candidate STATE bu exact snapshot üzerine tasarlanmış tam replacement adayıdır, yapılmış remote mutation değildir.

CATALOG baseline blob `8483cbd792542561eef926a83fc66349dcc06a17`; candidate'da yalnız HERMES satırı değişir. HERMES satırı çıkarıldığında kalan byte'lar aynı. Diğer yeni/current candidate yollar yalnız `research/studies/hermes-agent/**` içindedir. Foundation/control/context/diğer studies/eski Hermes not/evidence/synthesis/METHOD için candidate mutation yoktur.

## Gelecek yayın kapısı

Önce güncel main ve kontrol/STATE okunmalı. Bu teslimin üst README/PUBLICATION-HANDOFF, PACKAGE-MANIFEST ve evidence MANIFEST dosyaları doğrulanmalı. U07'nin source/RESULT/probe/SPEC/log/DB kanıtı yeniden üretilmemeli. Mevcut main ilerlediyse exact baseline compare yapılmalı; başka çalışma üzerine eski tree zorlanmamalıdır. Yeni hedef dosyası zaten varsa içeriği karşılaştırılmadan overwrite edilmemelidir.

Write aracı gerçekten sunulduğunda yalnız scoped değişiklikler hazırlanır; current STATE/META/INDEX/plan/ledger/questions/catalog ile bu PUBLICATION ve evidence README gerçek yayın durumuna göre uzlaştırılır. Note22/source/research/coverage içindeki ilk unpublished kayıtlar tarihsel ilk teslim anıdır; raw deney içeriği değiştirilmez. Ref force=false ilerletilir. Başarı ancak gerçek main ancestry, scoped diff, dosya kimlikleri ve gerekli içerik readback'iyle kaydedilir. O aşamada bu başarısız-publication kaydı tarihsel bölüm olarak korunabilir.

**Şu anda main yayını veya remote candidate içerik readback'i yoktur.** Sonraki teknik iş actual cron drainer/status consumer, occurrence/rearm ve run_job bağlamıdır; yayın açığı bunu yeniden araştırma kotasına dönüştürmez. Q40/Q42 ve diğer eski doğrulama borçları kapanmadı.
