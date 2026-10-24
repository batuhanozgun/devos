# U10 — Yayın ve geri okuma makbuzu

**2026-09-12 / PUBLISHED TO MAIN — CONTENT VERIFIED.** U10 kaynak araştırması, özgün selector kanıtı ve yeni provisional synthesis04 main'e yayımlandı. [STATE](../../STATE.md) U10 / plan v0.23; bütün HERMES ACTIVE PARTIAL. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json), [NOT RUN](CHECKS-NOT-RUN.md).

## Gerçek yayın ve kapsam

Araştırma tabanı `938359a1c4b0a01dd7bab5f4647e0474872b2078`. Hazırlık sırasında main, yalnız Foundation yollarını değiştiren `0e74f1052695875acc0ce0596a4f3619e59aba12` commit'ine ilerledi. Native compare: ahead_by=1, behind_by=0, HERMES/CATALOG/control değişikliği yok. U10, bu yeni parent'ın `2e5c6efc19b22826092a7a51d3b4f4788e039670` ağacına scoped override olarak yeniden bağlandı; diğer çalışma korunur ve bu tura atfedilmez.

**İçerik commit'i `d1b045a66b7a07d62d135c025bf5a1d4ab741022`; root tree `2da35efe7e5dbe36447268081c68727492e2c91c`; parent `0e74f1052695875acc0ce0596a4f3619e59aba12`.** Native compare tam **21 yol: 13 yeni dosya, 8 güncelleme**, silme/taşıma yok. Yalnız Hermes package ve CATALOG Hermes satırı; katalog farkı 1 addition/1 deletion.

Ref güncellemesinden hemen önce main yeniden okunup aynı parent doğrulandı. `update_ref(main, force=false)` sonrası gerçek main içerik commit'ini döndürdü. Bağlı immutable commit'ten STATE, plan, synthesis04, note25, RESULT ve RESEARCH'in 1–63 + 64–EOF metinleri geri okundu. Yeni branch/PR/force push veya izin ayarı değişikliği yok.

Bu makbuz, tamamlanmış içerik doğrulamasını kaydeden yalnız PUBLICATION.md güncellemesidir. Kendi gelecek commit kimliğini tahmin etmez; dönen makbuz commit'i, actual main/ref/diff ve dosya içeriği ayrıca kontrol edilir.

## İçerik sadakati

21 hazırlanmış dosyanın Git blob SHA'ları yerelde yeniden hesaplanıp gönderilen/geri okunan kimliklere bağlandı. Yedi Hermes current entry için native directory metadata ve STATE/plan tam metni; katalog için immutable file SHA; note25/synthesis04 için tam dosya; coverage için immutable file SHA kontrolü kullanıldı. Bu bütün eski dosyaların yeniden tam okunması iddiası değildir.

On evidence dosyasının ad/mod/blob birleşiminden yerelde hesaplanan alt-ağaç, remote **`6904a9768679f250a032c8b7d4b8d34310fa1232`** ile eşleşti. Native tree geri okuması her dosyanın beklenen blob ve boyutunu gösterdi. Bu ağaç final root'a exact path ile bağlandı; RESEARCH/RESULT/PUBLICATION dosyaları bağlı içerik commit'inden de geri okundu. Binary arşivin create_blob sonucu beklenen kimlikle eşleşti; uzaktan binary yeniden indirilip çalıştırılmadı.

| Yüzey | Beklenen ve bağlı Git blob |
|---|---|
| STATE | `8f6db112d545bf8bbb1c3aa3b69bf52af0a415c1` |
| PLAN | `e31cd8d10b996dda0abaa19a33148ef981e29079` |
| Synthesis04 | `e3ccfb7efd3a330ae4699ae8482a41fde27c934e` |
| Note25 | `4f2d7556d4ae8e45cfe3c2a3552fcce7f5581d50` |
| RESEARCH | `a9511ea6f6009b1f5f9c5b01f5ee751a70ab79ca` |
| RESULT | `b342f94a1b0f20fa19a0c02cfc83fc698bb81ca2` |
| Raw archive | `dba6e9f0a44c950a0dda234e763da7e87ecc6ab4` |
| CATALOG | `d85bf24ce90f24571d9bbfb2a3aa0fbe9682ef08` |

Katalogda Hermes satırı çıkarıldığında kalan bytes baseline ile aynıdır. Foundation, soul-context, AGENT/agent-control, explorations, diğer studies, HERMES METHOD, notes01–24, bütün önceki evidence ve synthesis01–03 değişen yollarda yoktur. Yeni synthesis04 eski üç dosyaya eklenmiştir; onların yerini almaz. U04-A/B ayrımı ve B'nin 33 original dosyası korunur.

## Ham kanıt ve doğrulamanın sınırı

Raw archive 13.228 byte ve 33 dosya üyesidir; üyeler yerel roundtrip'te exact bytes ile eşleşti. SHA-256 `be1354b2d5c47155e9866fb6596c3692bbeb1ea96a7dd7cd19897fcd1eb17036`. Bu 33 üye U04-B'nin 33 dosyası değildir; sayısal tesadüf case eşitliği yaratmaz.

Özgün RESULT SHA-256 `cdf30b7cb1b599b3b87d2d757bfaa26ed93508669f0c26f0b6c639b95b0537f7`. Recorded run UTC `2026-09-12T07:25:53.109130+00:00`–`2026-09-12T07:25:53.118497+00:00`. Altı descriptive selector vakası, bir identity ve iki source-mutant kontrolü; tek başarılı behavioral run. İlk parse-failure probe/stdout/stderr ve son print ifadesinin dar düzeltmesi korunur; SPEC/source/fixtures/oracles değişmedi.

Yayın aşamasındaki read-only validator source/SPEC/probe/RESULT, 10 input ve 8 output kaydının byte ilişkilerini kontrol etti; target'ı yeniden çalıştırmadı. JSON/AST ve 104 yeni internal link kontrolü yapıldı. 34 eski link hedefi canonical rotalardan yeniden kullanıldı; bütün eski evidence için taze recursive walk yapıldığı söylenmez. ARTIFACT-CHECKS içindeki `remote_publication_verified=false` paketleme anının kaydıdır; güncel yayın authority bu makbuzun üst bölümüdür. Raw deneyler yayın sonrası durumla yeniden yazılmaz.

Hash/tree/parse/link/readback kontrolleri aktarım ve süreklilik doğrulamasıdır; yeni HERMES davranış deneyi, bağımsız replication veya semantik kalite kanıtı değildir. Gerçek run_job/AIAgent/script subprocess/monitor persistence/SessionDB/network/provider/NAS/OS/ilk model request çalıştırılmadı. U10 selector bulgusu bu sınırları veya eski Q40/Q42/Q47/Q48/Q50 borçlarını kapatmaz.

## Devam

U10, STATE/INDEX → note25 → kaynak/araştırma/ham kanıt ve synthesis04 yolu ile eski sohbet ZIP'ine ihtiyaç duyulmadan geri kazanılır. U08/U09 ve bütün eski yayınlar tamamlanmış iş olarak korunur. İlk yeni geniş kaynak birimi **Q53 provider/runtime/backend sahipliği**; Q49/Q51/Q52 ve önceki residual doğrulamalar ayrı açık hatlardır. HERMES bütünü, dört-alan, architecture/adoption tamamlanmış değildir.

---

## Yayın öncesi hazırlanma kaydı — tarihsel

# U10 — Yayın ve geri okuma makbuzu

**2026-09-12 / PREPARED — MAIN/READBACK NOT YET VERIFIED.** Bu dosyanın üst bölümü gerçek nonforce ref, scope/diff ve içerik geri okumasından sonra güncellenecek. Yerel dosya/tree/blob varlığı yayın değildir. [STATE](../../STATE.md), [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [MANIFEST](MANIFEST.json).

Araştırma tabanı 938359a1c4b0a01dd7bab5f4647e0474872b2078. Kapsam Hermes package + CATALOG Hermes satırı; U04–U09 ve daha eski evidence/notlar, METHOD, synthesis01–03, Foundation ve agent-control korunur. Yeni synthesis04 provisional eklenir; eski sentezler değiştirilmez. Publication kontrolü yeni behavioral run veya bağımsız replication değildir. Eşzamanlı main değişirse eski root force edilmez; scoped değişiklikler yeniden bağlanır.
