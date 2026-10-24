# Hermes Agent — Araştırma planı

**v0.28 / 2026-09-13 — U15 skill-library lifecycle; next Q60 evaluation/task quality.** [STATE](STATE.md) work authority, [METHOD](METHOD.md) yöntem, [INDEX](INDEX.md) evidence, [MAP](CURRENT-RESEARCH-MAP.md) orientation, [PUBLICATION](evidence/2026-09-13-skill-library/PUBLICATION.md) yayın. Primaryc4a5deeffa959f8ebc891e02c5bcf767aff1dd2a / manifest0.21.0.

## Devralma ve tamamlanan kaynak dilimleri

Başlangıçc76dfd796996e96824d9860b0735a60a663ed7a0 U14/v0.27 yayımlıydı. Opening2bcdf606 actual ref/full PLAN/tek-path compare→A39bb5929 actual main/full note+source+STATE→B666038a7 actual main/full note+source+NOT RUN+STATE→current scope/next seçimi. Eski evidence tekrar edilmedi; publication source doğruluğunun bağımsız runtime deneyi değildir.

[Note30](notes/30-SKILL-LIBRARY-LIFECYCLE.md)→[A](evidence/2026-09-13-skill-library/SYNC-AND-LOCAL-STATE.md) + [B](evidence/2026-09-13-skill-library/ARCHIVE-LEDGER-AND-DISCOVERY.md). A bundled/source-baseline/local protection/deletion/external/optout; B management/usage/archive/ledger/snapshot/list/index/load zincirini açar. Synthesis01 ve notes03/04/08'in approval/curator çalışması korundu; aynı deneyler yeniden yapılmadı.

**Q59 SOURCE ADVANCED, bütün library veya reliability/quality kapanışı değil.** 14 primary path full/selected kaynak defterlerinde; yeni sync/restore/curator/model/DB/OS/suite koşusu yok. V1 baseline ve reset, backup collision ve usage-vs-quality çıkarımları gerçek kullanıcı incident'i değildir. U15 eski dört provisional senteze kaynak ekidir, final CORE veya yeni merkezi sentez değildir.

## Kapsam dengesi: neden Q60?

[U13 coverage](inventory/SCOPE-REVIEW-2026-09-13-U13.md) runtime/delivery/delegation hattı derinleşirken F12 distribution/change ve F04 library/eval'in açık kaldığını kaydetti. U14 source installation/update bağını; U15 operational skill lifecycle ile actual discovery/load tüketicisini açtı. Bu, bütün skill veya bütün arıza uzayının araştırıldığı iddiası değildir.

Üç seçenek tartıldı. Yerel sync/rollback'in her fault kombinasyonuna devam etmek güveni artırabilir ama geniş açıklamayı tek seam'e toplar. Uzak Hub/org publisher/proposal/approval/sync araştırması değerlidir ve maddi Q59 residual'dır; yalnız reader-side org gating bunu kapatmadı. **Evaluation/task-quality ailesi** ise mevcut öğrenme ve reuse iddialarına ne tür kanıt gerektiğini ayıracak, henüz benzer native açıklaması olmayan daha geniş bağdır. Önce bu aileye girilir; remote governance kapanmış veya önemsiz sayılmaz.

U15'in gerçek `skill_view` handler'ı yüklemeyi use sayar; setup-needed ve dedup ayrı davranır. Bir becerinin loaded/reused veya restored olması, görevin daha iyi yapıldığı gözlemi değildir. Dolayısıyla artık yalnız 'hangi varlık kullanıldı?' değil **'hangi başarının hangi ölçümü var?'** sorusunu açmak gerekir. Bu seçim evaluation'ın sonucu değil, kaynaklara dayalı araştırma-yön kararıdır.

## İlk sonraki yetkili iş — Q60

**Soru:** HERMES'te test/eval yapılandırması nasıl gerçek çalıştırılan hedefe, görev girdisine, sonuç artefaktına, oracle'a ve raporlanan başarıya dönüşür? Mekanizma doğruluğu, ajan görev başarısı ve gelecekteki öğrenme faydası birbirinden nasıl ayrılır?

Progressive giriş: pinned inventory/root `tests/`, `evals/`, bunların README/manifest/runner ve CI çağrı bağlantıları. Defaultbranch araması yalnız navigation; hükümler exact pin'den. Önce native test/eval ailelerini ve hedef nesnelerini ayır; görünürdeki benchmark adını measured capability sanma.

İlk doğal A: bir deterministic mechanism test veya regression runner'ın configuration→fixture/dependency→actual target→assertion→report zinciri. Sonra maddi farklı task/eval/model-judge veya end-to-end yol; yoksa yokluk ilan etmeden discovery sınırını kaydet. Fixture/mock ve gerçek üretim nesnesi, loaded artefact ve effective request, test discovery ve gerçekten executed case, count/pass ve intended success ayrı tutulur.

B veya sonraki doğal dilim, ilk okumaların ortaya çıkardığı gerçek ilişkiye göre seçilir: örneğin test verdict'inin CI/admission consumer'ı veya skill/memory müdahalesinin future-task faydasını ölçen eval. Böyle bir mekanizma bulunmuş gibi önceden ilan edilmez. Oracle bağımsızlığı, error sensitivity, negative controls, target/source/config identity, flaky/skip/error disposition ve model/provider maliyeti ayrı değerlendirilir.

Çıkış: en az iki maddi farklı test/eval yolunun neyi gerçekten ölçtüğünü, hangi sonuçların hangi iddiayı desteklemediğini ve downstream kararın sınırını kaynakla açıklayabilmek. Bütün suite'i koşmak veya bütün test dosyalarını okumak kota değildir. `Not found` ile source'da hiç yok birbirine eşitlenmez. Ölçüm nesnesi tanımlanmadan boş başarı skoru üretilmez.

**Q60 henüz başlamadı.** Yeni tur önce U15 actual publication/current main ve mandatory cold-start'ı doğrular; anlamlı opening'i yazıp geri okur; sonra ilk kaynak dilimi. Ücretli/provider/model/production/evaluation service başlatma veya user credential kullanımı yok. Zararsız yerel diagnostic ancak exact target/fidelity/oracle ve önceden kayıtlı kapsamla ayrıca yürütülebilir; source okumak test çalıştırmak değildir.

## Korunan işler ve residual'lar

Q59 uzak Hub/org governance, bütün writer/ledger coverage, clone/readiness/preprocess/cache/first request, filesystem/rollback/suppression/manifest integration ve future-task kalite maddi açık alanlardır. [U15 NOT RUN](evidence/2026-09-13-skill-library/CHECKS-NOT-RUN.md). Q58 actual install/update/solver/mutex/DB/fleet/receipt; Q57 manual-parent/host/claim/ack/crash; Q54–56; U10Q49/Q51/Q52; Q40/Q42/Q47/Q48/Q50 ve eski Q07/Q22/Q26/Q29/Q38 korunur. Erteleme kapanış değildir; yeni karşı kanıt veya strong reuse exact ölçümü yeniden açar.

Her büyük dilim main/ref/content/scope doğrulanmadan ikincisi biriktirilmez. Concurrent main korunur, force yok; yayın engelinde mevcut dilim çözülür. Yalnız Hermes package+CATALOG HERMES satırı. METHOD, notes01–29, U04–U14 original evidence, synthesis01–04 ve U15 A/B/source/NOT RUN değiştirilmez. Foundation/context/Codex/control/diğer studies/upstream/adoption/izinler değişmez.

[Exact Q59 opening](https://github.com/batuhanozgun/agentic-os-search/blob/2bcdf606afaad1788faf46d9bfd7fc19cee3b733/research/studies/hermes-agent/RESEARCH-PLAN.md)→[U14 planı](https://github.com/batuhanozgun/agentic-os-search/blob/c76dfd796996e96824d9860b0735a60a663ed7a0/research/studies/hermes-agent/RESEARCH-PLAN.md) tarihsel sıra ve sınırları korur. Yöntem kaynak→mekanizma→alt-sistem→ilişki→CORE→ayrı dört-alan değerlendirmesi; dosya/test sayısı tamamlanma yüzdesi değildir.
