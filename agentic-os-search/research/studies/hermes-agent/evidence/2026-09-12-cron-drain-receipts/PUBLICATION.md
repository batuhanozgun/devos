# U08 — Yayın ve geri okuma makbuzu

**2026-09-12 / PUBLISHED TO MAIN — CONTENT VERIFIED.** Özgün U08 teslimi main'e yayımlandı. Bu yayın checkpoint'inde yeni HERMES araştırması veya davranış koşusu yapılmadı. [STATE](../../STATE.md) U08 / v0.21; bütün araştırma ACTIVE PARTIAL. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [MANIFEST](MANIFEST.json), [RESULT](RESULT.json).

## Gerçek yayın

İçerik commit'i **`e30f6ee6a027ec247fd3dff6cb28f9a3d7ade1ca`**, parent `4c372138b7d652b1921e96ef9158b32b05c05fc8`, tree `e748b074612e24c055fd258c80e9ba1f56f2e8f2`. Parent, U07'den sonraki iki Foundation commit'ini içerir; bunlar korunur. Native compare ahead_by=1, behind_by=0; **21 yol, 14 yeni ve 7 güncelleme; silme/taşıma yok.** Yalnız HERMES package ve CATALOG Hermes satırı değişti.

Ref güncellemesinden hemen önce main yeniden okunup aynı parent doğrulandı. `update_ref(main, force=false)` sonrasında gerçek `git/ref/heads/main`, yukarıdaki içerik commit'ini döndürdü. Ardından bağlı immutable commit'ten STATE tam metni geri okundu. Bu makbuz yalnız PUBLICATION üzerinde bir sonraki kayıt güncellemesidir; kendi gelecek commit kimliğini tahmin etmez. Onun gerçek main/ref/diff/content kontrolü ayrıca yapılır. Branch/PR veya force push yoktur.

## İçerik ve sadakat doğrulaması

Teslim ZIP SHA-256 `4a1eda333c689efe90f51d34822bb0d2e3daa29f829337d79a83b851ab1de0ca`. Read-only validator 21 aday dosyayı, altı baseline kopyasını, 12 ham arşiv üyesini ve source/SPEC/probe/RESULT/effect bağlarını doğruladı. Hiçbir HERMES probe'u yeniden çalıştırılmadı.

21 dosyanın içerik kimliği yerel hazırlanmış dosyalarla bağlandı: yedi current Hermes girişinin blob/boyutları native directory tree'den; note23 ve coverage tam dosya geri okumalarından; 11 evidence dosyası yerel hesaplanan ve remote bağlı **`6eab7e183ea213693edc466d715f829fe5ec9fed`** alt-ağaç eşitliğinden doğrulandı. CATALOG'un beklenen blob'u `74025c4fef92c79907364f9e31c2a00a79f0de83`, bütün üst ağaçlar yeniden hesaplanıp remote root ile eşleştirilerek bağlandı. Ağacın eşitliği ad/mod/blob kimliklerini kapsar; yalnız dosya varlığı kontrolü değildir.

**11 dosya özgün teslimle byte-eşittir:** araştırma, kaynak defterleri, SPEC, RESULT, MANIFEST, artifact kaydı, raw arşiv, NOT RUN, note23 ve coverage. **10 dosya yalnız yayın/güncel yetki devri için uzlaştırıldı:** current entries/map, CATALOG Hermes satırı, evidence README/PUBLICATION. Aday aktarımda fark edilen note23 ve katalog metin sapmaları main ilerletilmeden özgün/beklenen byte'lara düzeltildi; beklentiler hatalı aktarımı onaylamak için değiştirilmedi.

CATALOG'da HERMES satırı dışındaki byte'lar baseline ile aynı; native compare 1 addition / 1 deletion gösterdi. Foundation, soul-context, AGENT/agent-control, explorations, diğer studies, HERMES METHOD, notes01–22, eski evidence ve synthesis01–03 diff'te yoktur. Synthesis subtree `49d86a6d6c70317c2098b6f9153e8cfe02c4f43d` ve eski evidence subtree kimlikleri korunur.

| Yüzey | Kimlik / gerçek okuma |
|---|---|
| STATE | `47b546f9af6ce8b4630e8c6fb226c75c748fe5ca`; main sonrası tam metin geri okuma |
| Note23 | `063c70da529aca3bf2abc5378a9cfdc8bde3365c`; aynı içerik commit'inden tam metin |
| Coverage | `d42ad4fd0474c085aa1fc13ad1f8081a6b22ff40`; tam metin |
| RESULT | `7fa940557140c3c2ea82546caffc906fa65548b6`; 2.840 byte; native/raw eşit ve evidence-tree üzerinden bağlı |
| RESEARCH | `cbe68154bdf92a32eaec136c9104bd8da8922eb9`; 20.038 byte; yerel tam okuma + tree eşitliği |
| Raw archive | `1a6bdb8690a1c0cfe7dcadd622148ad0b74939dd`; 11.352 byte, 12 üye; create_blob sonucu da eşleşti |

Raw RESULT SHA-256 `91833c4ae0b9f229a1c82f6edaa4a25bfc9b39ebc061c9e1811dbe32247dbfa0`; arşiv SHA-256 `4160254a832787443c170dc579fbc8eb043aba6915034f60ef2a70a71b9f23e0`. Uzak binary yeniden indirilip çalıştırılmadı. Hash/tree/parse doğrulaması aktarım sadakatidir, semantik doğruluk veya actual gateway/transport/network/SessionDB/model doğrulaması değildir.

## Tarihçe ve devam yetkisi

MANIFEST, ARTIFACT-CHECKS, SOURCES, RESEARCH ve eski STATE tarihçe bölümündeki local/unpublished/NOT PUBLISHED alanları **ilk teknik turun korunmuş kaydıdır**. Güncel U08 yayını bu üst bölümde doğrulanmıştır; eski capability eksikliği artık güncel engel diye kullanılmaz. Write eylemlerinin neden tekrar sunulduğu teşhis edilmez.

Yeni oturum STATE/INDEX → note23 → U08 kaynak/kanıt yolu üzerinden U08'i geri kazanabilir; eski sohbet ZIP'i gerekmez. Önceki U04–U07 yayınları yeniden yapılacak iş değildir. B01–B03 ve N00–N02 yeniden üretilmedi; Q40/Q42/Q48/Q50 dahil açık doğrulamalar kapanmadı. Kullanıcının bu tur onayladığı sırada, yayın ve makbuz doğrulaması sonrası Q47 occurrence/late callback/claim/rearm araştırmasına, ardından Q49 run_job/context'e devam yetkisi vardır. Bu makbuz Q47'nin yapıldığını söylemez.

---

## İlk U08 girişimi — özgün tarihsel kayıt

Aşağıdaki yayın yokluğu ve capability cümleleri ilk teknik tura aittir. Özgün araştırma ve deney kimliklerini değiştirmez.

# U08 — Yerel teslim ve gerçek repository durumu

**2026-09-12 / NOT PUBLISHED TO MAIN — NATIVE WRITE ACTIONS NOT EXPOSED.** Bu dosya bir remote yayın başarı makbuzu değildir. Yeni kaynak araştırması ve bounded native async-bridge koşusu yerelde saklandı. Önceki U07 yayını tamamdır; yeni bekleyen birim U08. [STATE](../../STATE.md), [RESEARCH](RESEARCH.md), [MANIFEST](MANIFEST.json).

## Gerçek repo okumaları

Araştırma başında main: `188095b930ac77f8d2a5dd605191a09a369a57ce`. Kapanışta yeniden okunan main: **`a6c47ef3ff697c2d23c492dcf4ccfa32003040da`**. Native compare status=ahead, ahead_by=1, behind_by=0; yalnız `research/soul-foundations/**` yolları değişti. HERMES/CATALOG/agent-control değişen yollarda yoktu. Yeni ref'ten HERMES STATE 1–16 satırları yeniden U07/v0.20 ve **`26d9b5c590b856c439869f4affe80c1c4ff6835c`** blob'unu gösterdi.

Bu Foundation commit'i bu tur oluşturulmadı; bir aktör/diğer çalışma aracına atfedilmedi. HERMES yayını daha sonra **güncel main'i koruyarak** yapılmalı; başlangıç root tree'si üzerine force yazılmamalı. Dosya-baseline kimliklerinin aynı olması bütün root tree'nin aynı olduğu anlamına gelmez.

## Capability sınırı

Create-tree / create discovery boş döndü. Full GitHub listesi 48 read/search eylemi sundu. Update-file sorgusu benzer read araçlarını döndürdü; actual update_file yoktu. Son create_commit sorgusu altı commit-read/search aracı döndürdü; actual create_commit yoktu. Plugin directory GitHub'ı installed/enabled gösterdi. Bu bilgi bağlantının/izinlerin değişme nedenini teşhis etmez.

**Bu tur create/update/blob/tree/commit/ref yazısı, branch/PR veya upstream değişikliği yapılmadı.** Read tool'u gizli write için kullanılmadı. Credential aranmadı, izin/ağ/plugin ayarı değiştirilmedi. Önceki U06 security block ve U07 yayın geçmişi farklı olaylardır; bu engelin nedeni olarak gösterilmez.

## Saklanan kanıt

S04 tam original async_utils.py byte kimliği Git blob ile eşleşti. SPEC/probe/input/result hash bağları, yerel effect dosyaları, stdout/stderr, runtime excerpt/fingerprint ve lisanslar raw arşivdedir. Native SPEC ve RESULT raw arşiv kopyalarıyla aynı byte'lardır. B01–B03 tek recorded run; N01/N02 validator kontrolleri source mutant değildir. Yeni ağ/SessionDB/full-gateway/gerçek duplicate testi yapılmadı.

Yerel [ARTIFACT-CHECKS](ARTIFACT-CHECKS.json) ve teslimin validator çıktısı **artifact transfer/readback** kontrolüdür, ikinci davranış koşusu veya independent replication değildir. Arşive koşudan sonra yalnız lisans bildirimleri eklendi; source/SPEC/probe/INPUTS/RESULT/effect/log yeniden üretilmedi.

## Baseline ve scoped candidate

INDEX, META, OPEN-QUESTIONS, PLAN, SOURCE-LEDGER ve CATALOG yerel baseline'ları, eski teslim metni ile yeniden okunan current publication metni birleştirildikten sonra **tam current Git blob eşleşmesiyle** kabul edildi. Eşleşmeyen ara baseline'lar kullanılmadı. STATE bu tur canonical'dan tam okundu; baseline JSON'da expected blob/byte metadata'sı taşınır, yerel byte-eşit STATE baseline kopyası iddia edilmez. Candidate STATE tam replacement önerisidir; yayında gerçek head içeriği ayrıca karşılaştırılır.

Yalnız `research/studies/hermes-agent/**` ile CATALOG Hermes satırı değişiklik adayıdır. Diğer katalog satırları ve rehberi current baseline ile byte-eşittir. Eski notes01–22, tüm U04–U07 evidence, METHOD ve merkezi synthesis01–03 candidate değişiklik listesinde yoktur. Yeni derived map state authority değildir.

## Yayın devri

Sonraki yayın, teslim üst README/BASELINE/PACKAGE-MANIFEST/PUBLICATION-HANDOFF üzerinden başlayabilir. Önce current AGENT/STATE/main; sonra yeni head ile path-level karşılaştırma. Yeni dosya zaten varsa kör overwrite yapılmaz. Ham deneyler tekrar çalıştırılmaz. U08 root entry/CATALOG/README/PUBLICATION içindeki local/not-published durumları yalnız gerçekleşen publication'a göre uzlaştırılır; raw manifest ilk teslim anını tarihsel metadata olarak tutabilir.

Gerçek native write eylemleri sunulduğunda scoped content commit, nonforce ref ve actual main/diff/content/hash readback gerekir. Bu dosya gelecekteki commit'i tahmin etmez. **Şu an U08 remote publication veya remote U08 content readback yoktur.** Kullanıcının eski U07 ZIP'ini yeniden göndermesi gerekmiyor; korunması gereken yeni paket U08'dir.
