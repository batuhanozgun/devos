# U07 — Cron scheduling, execution ve delivery kanıt paketi

**2026-09-11 / U07 yayın checkpoint'i.** İlk yerel teslimdeki yayın engeli tarihsel olarak korunur; bu aktarım yeni deney değildir. Güncel gerçek yayın durumu [PUBLICATION](PUBLICATION.md)'dan, çalışma kapsamı [STATE](../../STATE.md)'ten okunur. Önceki U06 yayını tamamlanmıştır; bu ayrı yeni U07 kaydıdır.

## Okuma yolu

[RESEARCH](RESEARCH.md) native açıklamayı; [SOURCES](SOURCES.md)/[SOURCES.json](SOURCES.json) pinned path/ref/blob/range statülerini; [SPEC](SPEC.md) önceden belirlenen ayırıcı kontrolleri; [RESULT](RESULT.json) özgün ham sonucu taşır. [MANIFEST](MANIFEST.json) tek raw arşiv ve 24 regular üyeyi bağlar. [ARTIFACT-CHECKS](ARTIFACT-CHECKS.json) transfer/parse/DB-snapshot kontrolüdür, yeni behavioral run değildir.

Yeni source kapsamı job/registration, ticker/dispatch, attempt audit, external worker handoff ve delivery queue'dur; bütün cron veya HERMES değildir. Yeni yürütme **yalnız full byte-matched `cron/delivery_queue.py` + gerçek temp SQLite/WAL**. Home/time/schema/WAL/redaction/process-tag bağımlılıkları açık seams; send callback sentetik. Actual SessionDB, gateway, model/provider/network, cross-process/OS restart veya upstream suite yoktur.

## Ham kayıt

[diagnostic-evidence.tar.xz](diagnostic-evidence.tar.xz), source/LICENSE, pre-run SPEC/inputs, exact probe, raw RESULT, stdout/stderr, D01–D06/N01/N02 final database backups, mutant girdileri ve başarısız attempt-00'ı içerir. Bytecode ve sonradan read-only incelemede oluşmuş SQLite yardımcı dosyaları ayrıdır: WAL'ların boş olduğu, her main DB'nin immutable integrity check ile tek başına okunabildiği denetlendi; gerekçeli exclusion listesi manifesttedir. Hiçbir vaka veya başarısız oracle kaydı çıkarılmadı.

Archive SHA-256: `4fdf2481f64ef6b1ee1ac177f43f727958f7769cf976276266be71a570b9644b`.
Raw RESULT SHA-256: `c53f850cceaad5e84eb800ce88b02c9a4eb227a00d82ee1714aecaefe7b51719`.
Original queue Git blob: `689fd620d6193003bbd168a0e62770a0d0306ac6`.

## Sınırlı yeniden üretim

Arşiv hash'ini ve regular/safe member yollarını doğrulayıp **yeni, boş bir yerel dizine** aç. Ardından o kopyada `python diagnostic/probe.py` çalıştırılır; yalnız standart Python kitaplığı gerekir. Koşu yeni RESULT ve DB'ler üretir; bu yeni çıktı özgün kaydın yerine konmamalıdır. Çalıştırılmış sürüm Linux/Python3.13.5/SQLite3.46.1'dir; başka ortam eşdeğerliği otomatik kabul edilmez. Probe network/subprocess çağrılarını audit guard ile reddeder, synthetic home ve geçici queue DB'leri kullanır; ürün kurulumu yapmaz.

Bu yeniden üretim yolu actual gateway/SessionDB testine dönüşmez. D01 callback_count=0 kurulum açıklamasıdır; asıl kanıt None dönüşü + pending DB'dir. D06 SQL trigger fault gerçek queue transaction'ını keser ama gerçek disk/OS arızasını temsil ettiğine dair genel hüküm taşımaz. Üst delivered classification yalnız source inference olarak kalır.

## Devam

Actual gateway drainer/profile/transport ve queued/delivered/finished tüketicisi; ardından occurrence/late callback/rearm ve shared run_job/script/agent bağlamı. U06 startup ve actual-DB quiet history borçları açık ertelemedir. [Coverage](../../inventory/CRON-COVERAGE-2026-09-11.md). Eski A/B/L sonuçları tekrar koşulmadı veya toplu başarı puanı yapılmadı.
