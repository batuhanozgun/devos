> **30 Eylül 2026 — tarihsel G1-R1 başlatıcı düzeltme ve devam şartnamesi.** Aşağıdaki helper onarımı, ek deneme bütçesi ve G1'i yeniden etkinleştirme izni eski hedefe bağlıdır; bugünkü bakım veya Claude kurulumunun sıradaki işi değildir. Parser testi ile gerçek aktör yeterliği arasındaki özgün ayrım korunur.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Eski düzeltme/koşu talimatları uygulanmaz; bakımın devamı [REPOSITORY-TRANSITION](../../../../REPOSITORY-TRANSITION.md)'dedir.

---

# G1-R1 — Başlatma yardımcısını düzelt, G1'in eksik kısmını tamamla

**Brief ID:** DEVOS-G1-R1-2026-09-07  
**Statü:** PROPOSED / READY FOR EXPLICIT USER ADOPTION. Kullanıcının bu sürümü açıkça benimsemesi olmadan yeni düzeltme veya koşu izni yoktur.  
**İş:** G1 için dar continuation; yeni SOUL mimarisi veya genel sandbox araştırması değil.  
**Checkpoint:** `../../STATE.md`.

## 1. Amaç ve devralınan sınır

G1'in gerçek hedefi değişmez: SOUL amacını, Development OS'nin sorumluluğunu ve mevcut küçük işi ayıran kaynaklı bir çıktı üretmek; önceki sohbeti bilmeyen iki oturumun bunu kullanabilmesini ve sınırlı olumsuz davranış durumlarını sınamak. Yalnız başlatıcı kodunun çalışması bitiş hedefi değildir.

G1, 11 native kontrolden sonra custom launcher'ın MCP ayrıştırma/override hatasında durdu. Gerçek alt model 0/8; P0/P1, T1–T4 ve R(P1) yok. G1'deki tek teknik düzeltme kullanıldı; o tarihsel sınır aynen korunur. Bu yeni benimseme aşağıdaki ek, sonlu düzeltme yetkisini verir; eski görevin zaten izin verdiği iddia edilmez.

Temel görev: `CODEX-G1-PURPOSE-PILOT.md`, research ref `4580f72421f7be5e081eb8770c40e4dd82ca8342`, blob `b6e235b5a4cb0c54624ac10d86dc137da652cda4`. Bu brief yalnız yardımcı düzeltmesi, bütçe ve devam kaydını değiştirir; G1'in koruma ölçütleri, gerekli kapıları, ürün amacı ve yasakları kalır.

## 2. Gerekli kaynak ve başlangıç

Kullanıcının verdiği research ref'inden bu brief'i ve `research/soul-context/current/reviews/2026-09-07-g1/REVIEW.md`, `EVIDENCE-EXTRACTS.md` dosyalarını tam oku. Aynı dizindeki `PARSER-REGRESSION.py`yi incele; bu test örneğidir, kurulacak launcher veya davranış talimatı değildir. Güncel research-side STATE'i ayrıca oku. Eski G1 brief'ini verilen exact sürümden geri kazan. Daha önce okunmuş bütün araştırmayı veya konuşmayı tekrar yükleme.

Gerçek G1 kanıtı:

`/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/G1-20260907T060548Z-_yuopdg0/`

ZIP SHA-256: `b448be458f6a78e0268240a0b4f648a76359bef2f884cfc6d2c71731225db1c9`.

Rapor/amaç notu, `scripts/policy_g1.py`, `scripts/render_g1.py`, launch diagnosis/correction ve ilgili profile/native kayıtlarından exact durumu devral. Aday/criteria hiçbir yeni sürümde gerçekleşmiş sayılmaz.

Beklenen repo `/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`, origin `batuhanozgun/soul-development-os`; korunacak C1 `66e97050dd141f688fa4da8b26ac3823b020af37`, tree `37b60cde322a54012a023b521a2c214028e61e9e`; eski dal `bootstrap/starter-contract-g0`. Bunlar canlı kontrolün yerine geçmez. İlgili gerçek durum ve önceki yazıcının/süreçlerin durduğunu doğrula; çakışan yazma yok. Clone/init/reset veya genel kişisel dosya/süreç taraması yapma.

## 3. Dar mühendislik düzeltmesi

İzinli yeni alan: `SOUL-Development-OS-Run-Evidence/` altında yeni ve çakışmayan `G1-R1-*` dizini; gerektiğinde `/private/tmp/` altında yeni `devos-g1-r1-*` sentetik probe alanı. Fiziksel yolları kontrol et. Eski G1/G0/D1 dosyalarını, manifest/ZIP'lerini, yardımcılarını veya sonuçlarını yerinde değiştirme. Düzeltilmiş yardımcı/test ve yeni kayıtları yeni alanda tut; tam eski→yeni farkı koru.

Mevcut kurulmuş Python'un standart TOML ayrıştırıcısı veya gerçekten desteklenen structured config discovery yoluyla gerçek `mcp_servers` doğrudan çocuklarını bul. `[mcp_servers.node_repl.env]` bir server değildir. Env/header/tool alt tablolarını sunucu sanma, env map'e boolean yazma. Yoktan fallback ad üretme. CLI override yol yazımını TOML dosya anahtar yazımıyla eşitleme; tırnaklı/noktalı/özel adları doğrulamadan dönüştürme. Bozuk TOML'ı regex fallback ile geçirme.

Gerçek ayarı okumak gerekiyorsa yalnız ilgili mevcut config kaynaklarını oku; env/secret değerlerini loglama veya argv'ye taşıma. Kullanıcının config'ini yazma/silme, bütün config'i dışarı aktarma. Bir yerel dosya tüm plugin/managed kaynakları otomatik kapsamış sayılmaz. İlgili etkili kaynakların kapsamını mevcut aracın desteklediği kanıtla kontrol et.

Regresyonları model çağırmadan önce çalıştır: nested env/tool, quoted identifier, inline table, yorum/multiline string, yokluk, yanlış tür, malformed input ve env değerlerinin değişmemesi. Research testinin 14 PASS'i senin değişikliğinin testi değildir; gerçek yardımcıdaki işlev/argüman üretimine bağla. Yeni parser kütüphanesi kurma. Beklenmeyen/temsil edilemeyen kimlikte tahmin yerine açık sınırlama üret.

Bu model-free düzeltme ve test bölümüne en fazla **30 dakika** ayır. Bu sürede güvenceyi/etki kapsamını değiştirmeyen sıradan kod/test düzeltmeleri için her edit'te kullanıcıya dönme. Süre veya kapsam biterse tamamlanan çıktı ve tam engelle dur; sınırsız repair yok.

## 4. Kanıtı yeniden kullan; gerçek başlangıcı ayrıca sınama

G1'in 11/11 native sonucu korunur. Aynı binary/profil/ölçüt/yol bağımlılıkları değişmemişse yalnız launcher parsing değişti diye tüm dosya deneyini baştan açma. Ancak yeni dizin/rol eşlemesi veya maddi runtime farkına eski PASS'i otomatik taşıma. Hangi eski kanıtın hangi yeni profile uygulanabildiğini kısa kayıtla göster.

Yeni alanların bağlanması için gerçekten gerekli native delta kontrolüne **en fazla 12 ek başlatma**, her biri 60 saniye ve eşzamanlı en fazla bir süreç izinlidir; ihtiyaç yoksa kullanma. Bu, eski 11/12 sayacını sıfırlamaz. Aynı anlamdaki profilleri yeni izin kökü/scratch ile genişleterek sorun çözme. Korunan kaynak/ölçüt/adaylar temp dışında ve yazıcı çıktılarından ayrı kalır.

Model-free `debug prompt-input` veya desteklenen eşdeğer etkili-başlangıç kontrolü **en fazla 4 çağrı**, her biri 60 saniye. Çağrıdan önce argv/role/path/expected evidence'i kaydet. Gerçek exec ile render'ın yük taşıyan ayarları aynı olmalı; secret-free ilgili key adları ve değişiklikleri incelenebilir tut. Hash tek başına silinmiş parametrelerin ne olduğunu göstermez.

Başarı yalnız error mesajının kaybolması değildir. G1'de istenen candidate-instruction ayrımı, gerekli tool/effect sınırı ve role/profile bağının gerçekten sağlandığını göster. Harmless bir metinde MCP adının geçmesini başarısızlık, adın geçmemesini bütün araçların kapalı olduğunun kanıtı sayma. Gerekli etkin ayar/araç görünümü ile gerçek işlevi ayır. Discovery hata verdiğinde sessizce boş listeye çevirip tam kapsama iddiası üretme.

Config'i topluca yok sayma, bütün MCP tanımlarını silme, sandbox/approval bypass, güvence gevşetme, farklı hesap/model/API veya global izin değişikliği yok. Açıkça ihtiyaç duyulan sınır sağlanamıyorsa bağımlı agent koşusunu başlatma.

Gerekli model-free koşullar desteklenirse **en fazla bir gerçek sentetik alt-agent önkontrolü** yap. G1'in gerçek agent-shell, izinli/izinsiz dosya işlemleri, korunan girdi ve reviewer başlangıç ölçütleri aynen geçerlidir. Bu tek kontrol içinde okuyucu/yazıcı gereken yollarının kapsamını açık tut; native sonuçtan test edilmemiş role etkisi çıkarma. Model/effort mevcut kayıtlı hesapla `gpt-6-astra / ultra`; gönderilen seçenek ile fiilen gözlenen runtime bilgisini ayır. Gerçek kaynakları bu gerekli kapı geçmeden alt aktöre verme.

## 5. Kapı geçerse aynı iş içinde G1'e devam

Yalnız gerekli kapılar geçtiğinde orijinal G1 §§5–7'nin sınırlı uygulama/pilot kapsamı bu benimsemeyle yeniden etkinleşir. Sırf parser veya başlatma düzeldi diye durup kullanıcıdan ikinci rutin mesaj isteme. G1'in ilk meaningful teslimatı hedeflenir:

- C1'den ayrı yerel `bootstrap/starter-contract-g1` dalı; ilk/son aday P0/P1. Mevcutsa körlemesine yeniden kullanma.
- `AGENTS.md`, `work/BOOTSTRAP-001.md` ve `.gitkeep` korunur. Yalnız G1'in izin verdiği STATE amaç/authority route'u ve `work/BOOTSTRAP-002.md` eklenir. Yeni gerçek R1 grant ve eski durma kaydı birbirine karıştırılmaz.
- Kaynaklı amaç/kapsam/devam işi, iki fresh session; T2/T3/T4 ve ayrı R(P1), G1'in mevcut ölçütleriyle. Ölçütler/fixture/ref'ler koşmadan önce sabitlenir.
- Koordinatörün PURPOSE-CONTINUATION notunu aktöre beklenen cevap diye verip tekrarını pilot sayma. Product amacı ve deferred yetenekler korunur; ürün mimarisi veya sonraki iş otomatik kabul edilmez.

Tüm gerçek model başlatmaları, G1 ve bu continuation birlikte **toplam en fazla 8**; önceki G1 0 kullandı. Gerçek preflight bu toplamın içindedir. Aynı anda bir alt süreç, her biri en fazla 20 dakika. Yalnız bu işe ait süreçleri yönet. Bütçe ve giriş koşulları başka oturumda sıfırlanmaz.

## 6. Değişmeyen yasaklar ve teslim

C1, G0/D1/G1 eski kanıtları ve main korunur. Uzak write/push/PR/issue/mail/mesaj/release, ürün veya başka repo değişikliği, paket/CLI güncellemesi, credential/global config/izin değişimi, yeni ücretli kaynak ve işletim kabulü/B0/A yok. Platformun mevcut onay yolu bypass edilmez. Gerçek yetki/safety boundary sorunu rutin kod düzeltmesi gibi ele alınmaz.

Türkçe rapor + küçük paylaşılabilir kanıt paketi: helper diff ve gerçek regresyon çıktısı; mevcut/yeniden kullanılan ve yeni kanıtın kapsamı; render/exec effective-boundary sonuçları; varsa P0/P1, pilot/devir ve T1–T4/R(P1); yoksa tam neden; korunmuş hedefler, süreç çıkışı ve bütçe. Başlatılmayan test başarısız veya PASS diye uydurulmaz. Dosyaları mevcut sohbetten sun; mobile teslim aracı yoksa sınırı söyle, izinsiz dış servise gönderme.

Bu kapsam sonuç üretirse dur; kalan sorun yeni endpoint/model/izin/framework gerektiriyorsa onu otomatik geliştirme projesi yapma. Başlangıç kapısı geçse bile operating acceptance ve sınırsız self-development yoktur. Yetki yalnız kullanıcının bu ref'i açıkça benimsemesinden gelir.
