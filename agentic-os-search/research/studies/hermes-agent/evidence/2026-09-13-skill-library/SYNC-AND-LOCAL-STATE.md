# U15-A — Dağıtılan beceri ile yerel kütüphanenin eşitlenmesi

**2026-09-13 / Q59-A / PINNED SOURCE STUDY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest0.21.0. [Kaynaklar](SYNC-SOURCES.md), [STATE](../../STATE.md), [PLAN](../../RESEARCH-PLAN.md). Bu dilimde HERMES modülü, sync, curator, installer, model veya upstream test çalıştırılmadı.

## 1. Önceki öğrenme modeliyle ilişki

U14, install/update/startup'ın beceri eşitlemesini çağırdığını gösteriyordu; alt tüketiciyi açıklamış saymıyordu. Synthesis01 ve notes03/04/08, proposal/approval/rollback ve curator kararlarını zaten içeriyor. U15-A bu eski deneyleri tekrarlamaz: **dağıtım kaynağı → yerel dosya → eşitleme kaydı → değişikliği koruma/silme/taşıma kararı** bağına iner. A'nın main/ref/content doğrulamasından sonra ledger/archive/discovery tüketicisine geçilecektir.

Actual başlangıç `c76dfd796996e96824d9860b0735a60a663ed7a0` U14 ile uyumluydu. Q59 açılışı `2bcdf606afaad1788faf46d9bfd7fc19cee3b733`, actual main/ref/tam plan ve tek-path compare ile doğrulandıktan sonra kaynak araştırması başladı. Eski U04-A/B ve U13 seçki sonuçları korunur; yeni veya bağımsız doğrulama yapılmış sayılmaz.

## 2. Tek beceri nesnesi yerine birkaç kimlik

`sync_skills`, bundled source dizini ile aktif profilin skills dizinini ayırır. Kaynak dizini environment override veya repo-relative varsayımdan gelir. Home/skills/manifest erişicileri import-time değerlerini doğrudan dondurmaz; explicit module patch yoksa call-time profile home'u yeniden çözer. Bu, çok-profilli uzun yaşayan süreçte hedefi yeniden bağlayan gerçek koddur, bütün caller'ların doğru profil kullandığının uçtan uca kanıtı değildir. [S01]

Manifest v2 satırları **beceri adı → origin hash** taşır. Ad, SKILL.md frontmatter'ından veya dizin adından türetilir; fiziksel hedef ise bundled source'un kategoriye göre göreli yolunu korur. Aynı ad ile aynı yol birbirinin yerine geçmez. `_dir_hash`, dosya yolları ve içeriklerinden MD5 üretir; üretilmiş belirli cache dizinleri ve yanında `.py` olan bytecode dosyaları dışlanır. Generic cache, her dotfile veya source-less bytecode otomatik dışlanmaz. Bu bir updater baseline'ıdır; tarihsel yazarlık, semantik doğruluk veya güvenlik denetimi değildir. [S01,S03]

Hash okuyucu OSError'ı bastırabilir; dolayısıyla hata altında dönen digest'in bütün paketin eksiksiz okunduğunu kanıtladığı varsayılmaz. Legacy hash eşleşmesi cache'i dahil ederek ayrıca denenir; sırf cache var diye farklı içeriğe yeni baseline atılmaz. İlgili gerçek filesystem/fault davranışı bu tur ölçülmedi. [S01,S03]

## 3. Normal eşitlemenin karar tablosu

Aşağıdaki tablo, suppression/external/rename gibi önceki kontroller engellemediğinde temel dalları gösterir. U, local content hash; O, manifest origin; B, current bundled hash'tir. [S01]

| Durum | Gerçek kaynak kararı | Tek başına göstermediği |
|---|---|---|
| Manifest'te yok, hedef yok | Source dizini kopyalanır; başarılı kopyadan sonra ad/B kaydedilir | Manifest write'ın kalıcı başarıyla bittiği |
| Manifest'te yok, hedef var ve U=B | Dosya ezilmez; B ile baseline alınır | Dosyanın tarihsel olarak installer tarafından yazıldığı |
| Manifest'te yok, hedef var ve U≠B | Yerel kopya korunur; bu farklı kopyaya bundled baseline verilmez | O içeriğin gelecekte otomatik güncellemeyi kabul ettiği |
| O dolu ve B=O | Kullanıcı kopyasını hash'lemeden skip | Yerel dosyanın değiştirilmemiş olduğu veya user_modified listesinin tam olduğu |
| O dolu, B≠O ve U origin ile eşleşiyor | Yedekli dizin değiştirme; sonra manifest B olur | Bütün kütüphane/ledger/cache'in tek işlemde değiştiği |
| O dolu, B≠O ve U origin ile eşleşmiyor | user_modified olarak tutulur; dosya değiştirilmez | İçeriğin kaliteli veya kullanıcının bilinçli değişikliği olduğu |
| Manifest'te ad var, hedef yok | Orphan/rename recovery'den sonra hâlâ yoksa user-deleted diye skip | Silmeyi kimin, neden yaptığı |
| Eski v1 ad var, O boş | İlk tur U baseline alınır ve skip edilir | U'nun özgün dağıtım kopyası olduğu |

**Temel kazanım:** koruma, yalnız dosyanın varlığına veya bir 'user' etiketine değil, geçmişteki bir içerik baseline'ına bağlıdır. Bu baseline kaybolduğunda veya ilk defa tahmin edildiğinde aynı dosya farklı geçişlere açık olabilir.

## 4. İlk gözlemi köken saymanın sınırı: v1 geçişi

Eski v1 manifest'te yalnız ad varsa uygulama kullanıcı kopyasının hash'ini yeni origin olarak kaydeder. Bu tur dosyayı korur. Ancak **koşullu ikinci-tur çıkarımı** önemlidir: yerel U, bundled B'den farklıysa ve arada başka değişiklik yoksa sonraki sync'te O=U, B≠O ve user_matches_origin=True olur; mevcut güncelleme dalı bundled içeriği kabul edebilir. İlk migrasyonun skip etmesi, bütün sonraki sync'lerde özelleştirmenin korunması teoremi değildir. [S01]

Bu gerçek kullanıcı dosyasının ezildiği gözlemi değildir. Daha önce v2'ye geçmiş manifest, farklı caller, opt-out/suppression veya araya giren değişiklik sonucu değiştirebilir. İlk yerel gözlemin 'son bizim dağıttığımız içerik' yerine kullanılmasının neyi mümkün kıldığını kaynak sırasıyla ayırıyoruz. Upstream test suite'in bu durumu hiç kapsamadığına dair yokluk iddiası yoktur.

## 5. Silme, arşivleme, yol değişimi ve upstream kaldırma

Curator suppression listesi eşitlemenin başında okunur; suppressed nonessential beceriler kopyalanmaz. Hedef yoksa önce `.bak` orphan'ı geri taşıma denenir. Sonra aynı frontmatter adına sahip aktif bir kopya, origin hash'le eşleşiyor ve hub install path'i değilse yeni canonical konuma taşınabilir. Değiştirilmiş eski kopya tutulur ve otomatik güncelleme alamadığı bildirilir. Bunlar 'dosya yok → kullanıcı sildi' çıkarımından önceki telafi yollarıdır. [S01]

Upstream'in tamamen kaldırdığı ad normal kipte manifest'ten temizlenir; bu dal yerel aktif dizini silmez. Bu nedenle **upstream katalogda yok ≠ yerel kütüphaneden yok**. Ters yönde, local deletion koruması adın manifest'te kalmasına bağlıdır: upstream kaldırma sırasında kayıt unutulmuş ve daha sonra aynı beceri yeniden dağıtılmışsa, hedef yokken yeni beceri olarak kopyalanması kaynakla mümkündür. Bu, kalıcı user-intent tombstone'unun bağımsız bir kayıt olarak tutulduğu anlamına gelmez. [S01]

Recovery ve kopyalama sırası tek transaction değildir. `_replace_skill_dir` eski hedefi `.bak`'a taşır, yeni dizini kopyalar, hata halinde geri yüklemeye çalışır. Başarılı kopya sonrası eski backup cleanup best-effort'tur. İlk kopya hatası manifest'e ad yazmaz; fakat yarım hedef dosyaları kalıp kalmadığı yeni denemenin dalını değiştirir. İncelenen test kesitindeki failing-copy fixture hemen exception üretir; gerçek partial-file/crash koşullarının tamamını ölçmez. [S01,S05]

## 6. Opt-out, bütün becerileri yok etme değildir

S01 `sync_skills`, `.no-bundled-skills` olduğunda yalnız ESSENTIAL_SKILLS'i seçer. S04'te bu küme `hermes-agent` içerir; disabled listelerinden de çıkarılır. Suppression kontrolü essentials'a istisna tanır. Opt-out, mevcut dosyaları otomatik silmez; nonessential manifest kayıtları da bu kipte upstream kaldırılmış sanılarak temizlenmez. [S01,S04]

Buna karşılık opt-out komutunun bazı başarı metinleri ve U14'te okunan installer yardım metni 'hiç seed etmeme/boş başlangıç' yönünde daha geniş konuşur. **U14 source caller açıklamasını burada daraltıyoruz:** onun yardımcıya devrettiği güncel pinned consumer, essential istisnası taşır. U14 özgün kanıtı yeniden yazılmadı; bu ek onun alt mekanizmasını açıklar. Mutable web belgesinin boş-kütüphane dili de ayrı target claim'dir, current implementation revalidation değildir. [S02,S04,W01; U14-A]

Essential olması bütün koşullarda dosyanın zorla geri yaratılması demek değildir: normal manifest/deleted veya dış kaynak dalları yine dikkate alınmalıdır. `opt-out --remove` tarzı operation, pristine dosyaları kaldırmak için ayrı yordamdır; broad source üzerindeki bütün lifecycle eşdeğerliği iddia edilmez.

## 7. Dış kaynak ve official-optional geçişi

External_dirs indeksi hem dizin hem frontmatter adlarını kullanır. Dış kaynak aynı adı sağlıyorsa sync yerel shadow yaratmaktan kaçınır; mevcut yerel hedef ancak current bundled hash'le aynıysa silinebilir. Hub install path'leri rename-recovery'de ayrıca korunur. Loader'ın bütün çakışma çözümü bu A'nın devam sorusudur; sync'in defer kararı loader'ın başarıyla yüklediğini göstermez. [S01,S03,S04]

Aynı sync sonunda official optional provenance backfill çalışabilir. Mevcut yerel dosya optional source'la içerik olarak eşleşiyorsa `.hub/lock.json` içine source=official, trust_level=builtin ve **scan_verdict=backfilled** yazılır; unique yer-değiştirmiş aynı dizin adı da incelenir. Bu yeni indirme veya yeni scan değildir. Eş içerik, operasyonel kayıt sınıfını yeniden kurmak için kullanılır; dosyanın geçmişte nereden indirildiği çıkarılamaz. Değiştirilmiş veya belirsiz birden çok hedef kopya otomatik sahiplenilmez. [S03]

Official optional restore, farklı mevcut kopyaları `.restore-backups` altına taşıyıp canonical kaynak kopyasını oluşturabilir. Bu backup ile normal sync `.bak` kurtarması, curator archive ve ledger revision aynı nesne değildir. Backup'ın sonraki scanner tarafından nasıl ele alındığı B'nin açık consumer sorusudur. [S03]

## 8. Reset'in nesnesi ve sonuç sözleşmesi

`reset_bundled_skill(restore=False)` manifest entry'sini kaldırır, sonra **genel sync** çağırır. Yerel dosya current bundled'a eşitse yeni baseline oluşur; gerçekten farklıysa S01'in yeni-hedef-var dalı onu korur ve baseline vermez. Bu yüzden başarı mesajındaki 'current copy üzerinden re-baseline ve sonraki değişiklikleri kabul' ifadesi her farklı kopya için taşınamaz. Testteki normal reset örneği, kullanıcının önceden current bundled içeriğini elle kopyaladığı özel durumu sınar. [S01,S02,S05]

`restore=True` hedefi manifest temizliğinden önce siler; silme exception'ında manifest korunur. Source upstream'de yoksa baştan ret vardır. Sonraki sync ise suppression, opt-out, external veya copy-failure sonucuyla hedefi oluşturmadan dönebilir. Wrapper, returned sync listesinde hedefin gerçekten kopyalandığını veya dosyanın hash'ini ayrıca doğrulamadan `ok=True, action=restored` oluşturur. **Bu koşullu result-composition sınırıdır; actual false-success deneyi değildir.** Genel sync başka becerileri de ele alır; tek isimli operation bütün etkilerinin tek beceriye ait olduğu anlamına gelmez. [S01,S02]

Manifest yazısı atomic helper'a devredilir ama wrapper exception'ı loglayıp yutar. Dosya etkisi ile manifest'in kalıcı yazısı ayrı başarılardır. Sync result dict'i önce biriktirilmiş listeleri döndürür; bunlar tek başına committed tracking makbuzu değildir. Helper'ın bütün OS atomikliği veya concurrent sync davranışı bu A'da sınanmadı. [S01,S03]

## 9. Test kaynağı, karşı örnekler ve kapsam

S05'in seçili upstream testleri gerçek temp-path dosyaları ve patch edilmiş path/bağımlılıklarla manifest formatını, normal seeding, user deletion, copy error, scope guard ve reset'in belirli başarı/ret yollarını kontrol ediyor. Bu tur bunlar koşturulmadı. Reset'in çalışan eş-içerik örneği, genel reset sonucu hakkındaki aşırı geniş olumsuz hükme karşı örnektir; pristine-update/modified-keep ve recovery kontrolleri de gerçektir. 'Hiç koruma yok' sonucu yanlış olur.

Büyük çerçeve salt hata listesi değildir: kaynak paketi ile kullanıcıya ait gelişen kütüphane, geçmiş içerik baseline'ı ve origin/management kayıtlarıyla ilişkilendiriliyor. Bu düzen birçok normal değişikliği korur; aynı zamanda dosya, metadata, policy ve discovery'nin farklı yaşamları olduğunu görünür kılar. Learned-content truth/future-task quality ayrıca ölçülmelidir.

## 10. A'dan sonraki iş

A main/ref/content/scope doğrulamasından sonra B: actual skill_usage suppression/archiving/restore, ledger ve discovery/read consumer'ı; mümkünse kayıtlı metinden model-visible beceriye kadar bağ. Eski curator planning/approval deneyi tekrarlanmaz. Henüz yeni behavioral RESULT, quality veya full dependency/byte-fidelity verdict'i yoktur. Q58 ve daha önceki bütün residual'lar korunur.
