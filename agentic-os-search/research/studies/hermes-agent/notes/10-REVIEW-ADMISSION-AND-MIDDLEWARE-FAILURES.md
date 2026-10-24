# U01-D3 — Review kabulü ve middleware hata sınırları

**Tarih:** 2026-09-09. **Pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. **Statü:** pinned source trace + bounded range-fidelity cross-check + exact middleware component execution. Tam HERMES doğrulaması değil.

[Tam araştırma](../evidence/2026-09-09-review-middleware/RESEARCH.md), [J kaynak defteri](../evidence/2026-09-09-review-middleware/SOURCES.md), [deney/tekrar yolu](../evidence/2026-09-09-review-middleware/README.md), [sekiz middleware sonucu](../evidence/2026-09-09-review-middleware/MIDDLEWARE-RESULT.json), [22 tanımlık AST cross-check](../evidence/2026-09-09-review-middleware/RANGE-FIDELITY.json), [SPEC](../evidence/2026-09-09-review-middleware/SPEC.md), [yayın kaydı](../evidence/2026-09-09-review-middleware/PUBLICATION.md).

## Ne ilerledi?

Gerçek review kurulumunun parent toolset'lerini koruduğu, constructor'ın valid_tool_names kümesini şemalardan ürettiği ve daha dar review izninin ayrı thread-local whitelist olarak kurulduğu kaynakta bağlandı. Tool-round'un validate/filter/persist-before-execute sırası ve Relay'nin koşullu dalları açıldı. Bu kaynak bağı, önceki sentetik geniş ad-kümesi deneyini ilerletir; gerçek bütün AIAgent/PluginManager/Relay/executor koşusu değildir.

Eski seçkilerin 15 executor ve 7 plugin tanımı, yeniden transkribe edilmiş pinned kaynak aralıklarıyla AST düzeyinde eşleşti; sentetik AST değişikliği yakalandı. **Tam yerel büyük orijinallerin hash kontrolü ve eski verify_excerpts.py koşusu yapılmadı.** İki taraf da assistant transkripsiyonu olduğu için ortak hata riski vardır; bu daha dar kontrol tam-fidelity kapanışı değildir.

Tam Git blob kimliği doğrulanmış middleware modülünde MW01–MW08 çalıştırıldı. Kendi erken callback hatasında devam; short-circuit'te sıfır handler; downstream exception'da tek giriş ve asıl hata; başarıdan sonraki callback hatası/ikinci next girişiminde tek etki ve ilk sonucun korunması ayrıldı. Fake registry, callback ve in-memory handler sınırı açık. Gerçek modülün import guard'ı bozuk kopyayı reddetti. Eski C/V testleri tekrarlanmadı; sayılar ürün PASS ölçüsü değil.

## Güncel karar ve devam

Q26'nın genel runtime erişilebilirliği açık tutulur; U01-D kapanmış sayılmaz. V0.7'nin öngördüğü sınırlı geçişle sıradaki aktif kaynak işi **gerçek CLI/gateway pending onayı → onaylayan/profil/home/store bağlamı**dır. Aynı seçili fixture'ı çoğaltmak yerine daha geniş öğrenme zinciri ilerletilir. Tam orijinal/gerçek runtime imkânı oluştuğunda veya iddia adoption/tasarım için yük taşıdığında Q26'nın ileri sınaması tekrar açılır.

Sonra memory M01/M02, ledger/backup/sync, skill/cache ve curator nested batch/report/cron. Geniş F01–F12 kapsamı ve önce native model sonra dört-alan/SOUL/Development OS sırası korunur. Güncel otorite [STATE](../STATE.md), [plan v0.8](../RESEARCH-PLAN.md); yöntem [METHOD](../METHOD.md). Önceki 01–09 notları ve kanıtlar değişmez.
