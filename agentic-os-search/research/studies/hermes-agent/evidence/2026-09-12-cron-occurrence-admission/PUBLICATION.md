# U09 — Yayın ve geri okuma makbuzu

**2026-09-12 / PUBLISHED TO MAIN — CONTENT VERIFIED.** U09 kaynak araştırması main'e yayımlandı. Önce U08 yayını doğrulandı, ardından kayıtlı Q47 birimi araştırıldı ve bu U09 kaydı oluşturuldu. [STATE](../../STATE.md) U09 / plan v0.22; bütün HERMES araştırması ACTIVE PARTIAL. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md).

## Gerçek yayın ve eşzamanlı çalışma

- U09 araştırma tabanı: `c370cbc88823f7ee4d07aa6c97b75cf509129254`, doğrulanmış U08 yayın makbuzu.
- Yayın hazırlığında main, yalnız Foundation yollarını değiştiren `2ecb29498e0bb826aa3f1bc7ebdf2921b3c45f9f` commit'ine ilerledi. Native compare bu ayrımı gösterdi; U09 dosyaları yeni parent'ın `9c57f131f39596d8128d38bc46b6250779960501` ağacı üzerine bağlandı. Foundation değişikliği bu tur oluşturulmadı veya bir aktöre atfedilmedi.
- **U09 içerik commit'i: `8be4dd485a0d303ecaa879dc692b55c29be08e32`.** Parent yukarıdaki 2ecb2949; root tree `45c2ae830d15a9a81586d5069141136ed1a81040`.
- Native compare: ahead_by=1, behind_by=0; **14 yol, 6 yeni dosya ve 8 güncelleme, silme/taşıma yok.** Yalnız HERMES package ve CATALOG Hermes satırı; CATALOG 1 addition / 1 deletion.
- Ref güncellemesinden hemen önce gerçek main yeniden okundu ve aynı parent doğrulandı. `update_ref(main, force=false)` sonrası gerçek `git/ref/heads/main`, içerik commit'ini gösterdi. Sonrasında bağlı immutable commit'ten STATE, RESEARCH ve plan tam içerikleri geri okundu.

Bu makbuz, doğrulanmış içerik yayınının ardından yalnız PUBLICATION.md üzerinde yapılan kayıt güncellemesidir. Kendi gelecek commit kimliğini tahmin etmez; makbuz commit'inin main/ref/diff/content kontrolü ayrıca yapılır. Yeni branch, PR veya force push kullanılmadı.

## İçerik sadakati ve geri okuma kapsamı

Yerel hazırlanmış 14 dosyanın Git blob SHA, byte boyutu ve SHA-256 değerleri yeniden hesaplandı. Uzak kimlik bağları: CATALOG native studies tree'sinden; yedi current Hermes girişi native package tree'sinden; beş evidence dosyası native evidence tree'sinden; note24 tam dosya geri okumasından tek tek eşleştirildi. Hepsi beklenen içerikle eşleşti.

U09 evidence alt ağacı ayrıca yerel ad/mod/blob birleşiminden hesaplandı ve uzaktaki bağlı **`c41cc7ca845508bf09741d48a26ff40d54dbd6b6`** ağacıyla eşleşti. Bu kimlik beş dosyanın içeriğini birlikte bağlar; yalnız dosya varlığı kontrolü değildir. İlk aday SOURCES üst satırındaki ref yazım sapması main ilerletilmeden düzeltildi; hash beklentileri hatalı metni onaylamak için değiştirilmedi.

| Yüzey | İçerik blob'u / doğrulama |
|---|---|
| STATE.md | `4895dc1f0112051f5396afddedd4dcd4101b2a17`; 8.781 byte; main sonrası tam metin okundu. |
| RESEARCH-PLAN.md | `613ed62bbc82eccd23e5646e39057698a2ad2eb5`; 4.419 byte; main sonrası tam metin, Q49 next ve açık validation ayrımı. |
| RESEARCH.md | `23c8bee2ea88238fdc6987d5959a4881da2ead54`; 15.326 byte; main sonrası 1–54 ve 55–EOF aralıksız tam geri okuma. |
| SOURCES.md | `d66020508f15d3b725f612fda7ad83c042db6ff2`; 6.779 byte; yerel tam metin + native blob/boyut ve subtree eşitliği. Uzak tam metin bu yayın adımında yeniden okunmuş sayılmaz. |
| CHECKS-NOT-RUN.md | `c3528f59bb746bbbbcb0e3f8bc79f507fee64a7e`; 2.919 byte; aynı native metadata/subtree bağı. |
| Note24 | `10ca0d11cae57ba6b40e67cd21c309516597a87a`; 2.980 byte; aynı immutable içerik commit'inden tam metin okundu. |
| CATALOG | `bf16c458a143ff755a772562ca6c20310beffc16`; 9.201 byte; HERMES satırı çıkarıldığında kalan byte'lar U08 baseline ile aynı. |

Foundation, soul-context, AGENT/agent-control, explorations, diğer studies, HERMES METHOD, notes01–23 ve bütün eski evidence/synthesis dosyaları değişen yollarda yoktur. Eski evidence alt-ağaçları korunur; U08 evidence `0677589d2de8fb83f50bd1523267c72c8d4bfd2c`, üç merkezi synthesis `49d86a6d6c70317c2098b6f9153e8cfe02c4f43d`. U04-A/B ayrımı ve original delivery kayıtları yeniden yazılmadı.

## Doğrulamanın neyi kanıtlamadığı

**U09'da yeni HERMES davranış koşusu yoktur.** Kaynak ve test kodu okuması, gerçek API/NAS/store/clock/process/crypto veya çift çalıştırma deneyi değildir. RESEARCH içindeki T0–T4 tablosu koşullu kaynak çıkarımıdır. Source-only birim için RESULT.json ya da ham deney arşivi üretilmedi. Yerel link/hash/parse ve bu yayın kontrolleri transfer/süreklilik doğrulamasıdır; bağımsız araştırma, semantik doğruluk veya ürün güvenilirliği kanıtı değildir. Eski U04–U08 deneyleri yeniden çalıştırılmadı.

## Yeni oturumun devralacağı durum

**U08 ve U09 artık eski sohbet ZIP'ine ihtiyaç duyulmadan repository'den geri kazanılabilir.** STATE/INDEX → note24 → U09 RESEARCH/SOURCES/NOT RUN yolu current'tır. U08'in eski local/unpublished alanları kendi ilk teknik tesliminin tarihçesidir; U08 makbuzunun doğrulanmış üst bölümü korunur. U09'un aşağıdaki hazırlanma kaydı da güncel yayın engeli değildir.

İlk yeni geniş kaynak birimi **Q49 — accepted scheduled snapshot → run_job/script/no_agent/monitor/agent/profile/model/tools/session/history**. Q47'nin gerçek late-callback/store/NAS deneyleri, Q40/Q42 ve Q48/Q50 dahil diğer doğrulama borçları açık kalır. Üç merkezi sentez provisional; bütün HERMES, final CORE, dört-alan veya architecture/adoption tamamlanmış sayılmaz.

---

## Yayın öncesi hazırlanma kaydı — tarihsel

# U09 — Yayın checkpoint'i

**2026-09-12 / CONTENT PREPARED — MAIN/READBACK NOT YET VERIFIED.** Bu başlık gerçek ref/diff/content kontrolünden sonra güncellenecek. Source-only U09, daha önce bu tur yayımlanıp doğrulanan U08'den ayrıdır. [STATE](../../STATE.md), [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md).

Araştırma ve hazırlanmış içerik tabanı `c370cbc88823f7ee4d07aa6c97b75cf509129254`. Kapsam yalnız HERMES package ve CATALOG Hermes satırı. U08 dahil bütün eski evidence/not/synthesis/METHOD, Foundation, agent-control ve diğer studies korunur. Yeni davranış koşusu yok; yerel link/hash ve publication kontrolleri de davranış testi değildir. Başarı ancak gerçek nonforce main ref, scoped diff ve içerik geri okumasıdır.
