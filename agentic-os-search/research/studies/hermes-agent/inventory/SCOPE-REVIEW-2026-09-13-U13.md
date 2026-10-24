# U13 sonrası — Kapsam dengesi ve sonraki geniş araştırma

**2026-09-13 / RESEARCH-PROCESS ASSESSMENT, yeni upstream bulgusu veya tamamlanma yüzdesi değil.** Bu değerlendirme U13-A ve B main'e yazılıp geri okunduktan sonra yapıldı. Work authority [STATE](../STATE.md), sıra [PLAN](../RESEARCH-PLAN.md). Kullanıcının devam yetkisi mevcut HERMES-native araştırma kapsamındadır; kurulum yapmak, ürün güncellemek veya SOUL mimarisi tasarlamak için yetki değildir.

## 1. Değerlendirme girdisi ve tarih ayrımı

Current U12 map/STATE/plan ve U13 A/B bulguları; [10 Eylül ilk kapsam değerlendirmesi](SCOPE-REVIEW-2026-09-10.md), [U02 F01–F12 kapsam haritası](CORE-COVERAGE-2026-09-10.md), [ilk topoloji](STRUCTURE.md), [synthesis01](../synthesis/01-LEARNING-AND-CHANGE-PROVISIONAL.md), bu tur yeniden okunan synthesis02/04 ve korunan synthesis03. Dört historical coverage/synthesis dosyası B readback'inden sonra tam tekrar okundu. Historical “ilk next” cümleleri güncel iş yönü sayılmadı.

U13 source oku ve dar diagnostic, tüm alt kaynakların full-byte/OS/DB doğrulaması değildir. Bu karşılaştırma da bağımsız verifier veya yeni davranış koşusu değildir; kapsam yönetimi kararıdır. F01–F12 kalıcı ontoloji değil, eski topolojiye ait çalışma lensidir.

## 2. U02'de açık olan ailelerin bugünkü farklı durumu

| Bölge | Artık elde olan açıklama | Hâlâ açık / korunacak |
|---|---|---|
| Tur, context, session (F01–03) | U02 loop/context; U05–06 lease/history; U13 gerçek parent turn source bağı | Exact model request, tüm DB/quiet/restart yolları ve fidelity |
| Kalıcı görev ve zaman (F10) | U03 task/run/claim, U04 goal/loop/heartbeat, U07–10 cron occurrence/execution/result/delivery | Gerçek worker/NAS/clock/transport/quality ve seçki-fidelity |
| Runtime ve araçlar (F05–08) | U11 ordinary/native ownership; U12 final-argument tool policy, child context/role/budget/workspace/control | Full provider/native/credential/OS ve bütün plugin/child varyantları |
| UI ve sonucu kullanma (F09/F11) | U13 normal CLI ve TUI/desktop completion→history→actual run_conversation; restored/interim ayrımı | Messaging adapters/API, actual ack/claim expiry/crash; tüm UI eşdeğerliği yok |
| Öğrenme ve kütüphane (F04) | Derin U01 mekanizmaları, synthesis01; U12 summary→memory-hook tüketimi | Skill ledger, backup/restore/sync, curator-report/task references, future-use ve kalite hâlâ maddi |
| Dağıtım, değişim ve değerlendirme (F12) | Kök topology'de pyproject/setup/lock/package, scripts/docker/nix/native ve apps/bootstrap-installer listelenmiş; tests/evals dizinleri görünür | Kurulan yazılım/ayar/profilin etkin runtime'a dönüşmesi, updater/activation/rollback ve eval kabulünün native yaşam döngüsü henüz aynı derinlikte açıklanmamış |

Sonuç “öğrenme bitti” değildir. İlk turda öğrenmeye aşırı yoğunlaşma riski vardı; ardından yürütme/devam/zaman/delegation omurgası genişledi. Şimdi aynı kontrol pencerelerini sonsuzca çoğaltmak yerine dağıtım/değişim tarafında henüz kurulmamış bir açıklama kazanmak daha yüksek kapsam değerine sahip.

## 3. Adayların karşılaştırılması

**Q57'yi bütün arıza matrisiyle bitirmek:** gerçek ağ/DB/OS güvenini artırabilir; fakat araştırmanın amacı ürün sertifikasyonu değildir. Normal consumer oku ve ayırıcı ret/ack farkı artık açıklanabilir. Kalanlar açık residual ve tekrar açma koşuluyla tutulur; bunları bitirmek genişlemenin ön koşulu yapılmaz.

**Hemen skill-ledger/sync'e dönmek:** değerli, synthesis01'deki kalıcı bilgi yaşamını tamamlayabilecek adaydır. Ancak derin U01 çekirdeği varken F12'de baştan sona kurulmuş benzer açıklama yoktur. Bu aday silinmez; Q58 sonrası coverage seçiminin ilk karşı adaylarından biridir. Burada eski onay/restore testlerini tekrar koşmakla ledger/sync araştırmasının aynı olmadığı özellikle korunur.

**Kurulum→etkin runtime→güncelleme/yeniden başlatma kimliği:** seçilen sonraki geniş kaynak birimidir. U11/U12 etkin sağlayıcı/araç/profilin kimde olduğunu açtı; fakat o dosya, bağımlılık, config ve entrypoint'in hangi işlemle mevcut çalışan sistem hâline geldiğini açıklamadı. Bu yeni kenar, mevcut runtime modelini başka bir yaşam evresine bağlar; sırf dosya listesindeki boş başlık değil.

**Nihai CORE/dört-alan sentezi:** henüz erken. Öğrenme kütüphanesi, dağıtım/değişim ve değerlendirme çevrimi açıklanmadan temiz tek model kurmak, kalan alanları varsayımla doldurma riski taşır. Dört provisional synthesis ve source amendments korunur.

## 4. Yeni bounded soru — Q58

**HERMES kaynak/dağıtım paketi ve bağımlılıkları nasıl kurulmuş bir komuta, profile/home/config alanına ve etkin runtime'a dönüşür; güncelleme bu kimlikleri ve kalıcı kullanıcı durumunu nasıl değiştirir veya korur?**

Gerçek başlangıç route'u inventory/STRUCTURE'daki pinned root tree `f54f5e9d2682bf11f164de7b34ee10ec121b6434`; README, pyproject/setup/lock/entrypoint yüzeyi ve onun gerçekten işaret ettiği installer/updater. `scripts/` ve `apps/bootstrap-installer/` alternatif yüzeyler olarak keşfedilir; dosya adı hafızadan uydurulmaz. Varsayılan kaynak/CLI yolu ile maddi fark gösteren bir update/refusal/interruption veya desktop/bootstrap yolu yeterli ilk karşılaştırmadır; bütün işletim sistemleri/platformları otomatik kapsam değildir.

Ayrımlar: repository ref ≠ release etiketi ≠ indirilen paket ≠ kurulu dependency/config ≠ aktif process; dosyanın değişmesi ≠ çalışan servisin yeni kodla başlaması; yedek varlığı ≠ doğru revision'a geri dönebilme. Bunlar sonuç değil, sınanacak framing seçenekleridir. Kaynak aksini gösterirse birim yeniden ayrılır.

Çıkış ölçütü: bir normal kurulum/activation ve bir değişim yolunun girdi kimliği, yazdığı/koruduğu durum, çalıştırdığı gerçek entrypoint ve tamamlanma makbuzu kaynaklarla açıklanabilmeli. Actual kurulum/update, kişisel home/credential okuma, servis başlatma veya ürün benimsemesi yoktur. Sürüm güncelliği gerektiğinde ayrı yeniden doğrulanır; mevcut araştırma pini kendiliğinden yükseltilmez.

## 5. Sonraki sorumluluk ve açık sınırlar

Q58 bu turun teknik sonucu değildir; **ilk sonraki yetkili araştırma sorusudur**. Yeni aile çalışması başlatılmadı. Bu tur U13 source/diagnostic ve kapsam kararını kalıcılaştırıp kullanıcıya döner. Q58'in anlamlı ilk dilimi yayımlandıktan sonra F04 ledger/sync/curator ve F12 eval/quality karşılaştırılarak sıradaki açıklama seçilir; önceden değişmez çok-turlu iş listesi yaratılmaz.

Q57'nin full-parent fidelity, actual DB ack, claimNone telafisi, CLI volatile queue/restart, notification task-context ve actual request soruları açık. Q54, Q55/Q56, U10 Q49/Q51/Q52 ve önceki fidelity/quality/whole-worker borçları korunur. Yeni kanıt veya güçlü reliability/adoption kullanımı ilgili residual'ı tekrar açar. Erteleme kapanış değildir. Foundation/control/diğer studies değişmez.
