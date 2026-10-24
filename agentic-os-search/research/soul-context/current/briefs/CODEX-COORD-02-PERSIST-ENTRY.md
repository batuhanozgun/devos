> **30 Eylül 2026 — tarihsel COORD-02 yerel kalıcılaştırma görevi.** Aşağıdaki yeni dal, STATE ve iş kaydı yazma izinleri eski C1/COORD-01 zincirine aittir; bugünkü DevOS'u başlatmaz veya yeni kurucuya yazma yetkisi vermez. Yeni oturum kullanımının o tarihte sınanmadığı bilgisi dahil özgün kayıt korunur.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Eski yerel hazırlık yeniden uygulanmaz; bakımın devamı [REPOSITORY-TRANSITION](../../../../REPOSITORY-TRANSITION.md)'dedir.

---

# COORD-02 — Amaç ve güncel iş girişini kalıcı adaya bağla

**Görev ID:** DEVOS-COORD-02-2026-09-07  
**Statü:** ÖNERİ / açık kullanıcı benimsemesi bekleniyor. Bu dosyanın bulunması yetki değildir.  
**Yetki:** Kullanıcının bu sürümü benimseyen yeni görev mesajı yalnız aşağıdaki yerel hazırlığı yetkilendirir.  
**Güncel research checkpoint:** `../../STATE.md`.

## 1. Sonuç ve sınır

COORD-01'de önerdiğin en küçük iyileştirmeyi uygula: **STATE'de kısa SOUL–Development OS amaç bağı ve doğru güncel iş referansı; ayrıntı için bir yeni iş kaydı.** Yeni protokol/rol/orkestrasyon sistemi kurma.

Bu, kaynaklı devam kaydının yerel aday olarak hazırlanmasıdır. İşletim kabulü, AGENTS değişikliği, ürün işi, G1 yeniden denemesi veya yeni ana oturum testinin geçtiği anlamına gelmez. Ayrı yeni ana oturumun hazırlanan kaydı kullanması sonraki gözlemdir; bu oturum onun yerine geçmez.

Amacı yöntemden ayır, belirsizlikte kaynağa dön, araştırma/çıkarım/kabulü ayır. Önceki asistanın önerisine gerekçeli itiraz edebilirsin. Sınırlar içindeki metin/link/kayıt düzeltmeleri için rutin onay turu açma; erişim, kapsam ve kabul hakkını genişletme.

## 2. Kaynak ve başlangıç

Kullanıcı mesajındaki research ref'inden bu dosyayı ve `research/soul-context/current/reviews/2026-09-07-coord-01/REVIEW.md` dosyasını tam oku. Güncel research STATE'yi ayrıca oku. Aynı dizindeki CODEX-RESPONSE.md kullanıcı aktarımıdır, yerel dosyanın byte kopyası değildir.

Gerçek yerel kaynağı oku:
`/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/COORD-01-20260907T083600Z-01a07aff/RESULT.md`

Aynı dizindeki mevcut küçük devir/sonuç izlerini gerektiği kadar kontrol et; dosya adlarını tahmin etme. Ayrı yeni bir audit sistemi oluşturma. Aktarılan raporla maddi çelişki varsa kaydet; ona bağlı ilerlemeyi durdur. RESULT'a erişemiyorsan onu yeniden üretip eski dosyaymış gibi sunma.

Kaynak amaç için COORD-01'in kullandığı `b62c9d0013aebce9c0b78035d5bd9a3b41b791a5` ref'indeki opening vision ve DEVELOPMENT-OS-BOOTSTRAP rotalarını koru. Gerekli kısmı tekrar kontrol et; tüm Foundation/studies/eski ZIP'leri yeniden okuma. Research `AGENT.md` / `agent/**` talimatlarını ithal etme.

Beklenen çalışma kökü `/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`; origin `batuhanozgun/soul-development-os`; başlangıç dalı `bootstrap/starter-contract-g0`; C1 `66e97050dd141f688fa4da8b26ac3823b020af37`, tree `37b60cde322a54012a023b521a2c214028e61e9e`.

Default cwd, Git kökü/origin/HEAD ve staged/unstaged/untracked durumu salt okunur kontrol et. Son native yardımcının tamamlanması/yazıcının bırakması için mevcut ilgili kayıt yeterliyse genel süreç taraması yapma. Çakışan aktif yazıcı veya açıklanamayan fark varsa reset/stash/clean/force ile düzeltme; ilgili yazmayı durdur.

## 3. İzinli değişiklik

Başlangıç beklenen C1 ve temiz durumla tutarlıysa **C1'den yeni yerel `bootstrap/coordination-entry` dalını oluşturup o dala geçebilirsin**. Kullanıcıdan dalı elle oluşturmasını isteme. Dal zaten varsa ona aitlik ve ref durumunu çözmeden değiştirme. G0 dalını veya main'i ilerletme; eski commit'leri yeniden yazma.

Repository'de yalnız:

1. `STATE.md` güncellenir.
2. `work/COORD-02.md` oluşturulur.

`AGENTS.md`, `work/BOOTSTRAP-001.md` ve `.gitkeep` byte olarak değişmez. Diğer repository dosyaları, G0/D1/G1/COORD-01 eski kanıtları değişmez. Dış rapor gerekiyorsa yalnız Run-Evidence altında yeni ve çakışmayan `COORD-02-*` alanına yaz; fiziksel yol/symlink kapsamını kontrol et.

### STATE'nin işi

- COORD-01'de önerilen kısa ürün amacı paragrafını, Development OS'nin bu ürüne hizmet ettiğini ve mevcut başlangıcın sınırlı aday olduğunu açıkça göstererek ekle. Mimari adları zorunlu bileşene dönüştürme; amaç beyanından işlem yetkisi çıkarma.
- Amaç için sürümlü kaynak linki ver.
- Güncel iş, gerçek yetki, sonuç ve devam için `work/COORD-02.md`ye bağlan.
- G0/BOOTSTRAP-001'i tarihsel, korunmuş iş olarak erişilebilir tut; başarısız/çalıştırılmamış durumları silme.
- Kapanışta bu hazırlığın tamamlanmış/yarım durumunu ve **yeni ana oturum kullanımının henüz sınanmadığını** göster. Aktif yazmayı kapat. Verilmemiş sıradaki işi aktif veya yetkili gösterme; B0/işletim kabulü yoktur.

### Yeni iş kaydının işi

- Gerçek COORD-02 kullanıcı yetkisini, exact brief/ref'i ve izinli etkileri kaydet; mesaj zamanı/kimliği görünmüyorsa uydurma. Bu kayıt yetki aktarımıdır, kriptografik yetki kanıtı değildir.
- COORD-01 sonucunun kısa ve kendi başına anlaşılır özünü, native devir bildiriminin dayanak/sınırını, yerel RESULT yolunu ve hesaplanan hash'ini koru. Research-side korunmuş yanıt/review'a sürümlü link ver. Yeni oturumun yalnız Mac'teki dış bir dosyayı bulmasına bağlı kalacak boş bir link listesi üretme; tam günlükleri de kopyalama.
- Yapılan değişikliği, kaynak bağını, kontrolleri, açık kalan noktaları ve yazıcının bırakmasını kaydet.
- Sonraki yeni ana oturumun değerlendireceği kapsamı belirt: amacı ve son tamamlanan işi geri kazanmak; eski görevleri yeniden başlatmamak; verilmemiş uygulama yetkisi türetmemek; bir sonraki sorumluluğu dayanağıyla ayırmak. Bu değerlendirme henüz çalışmadı ve ayrı başlangıç mesajıyla etkinleşecek.

## 4. Kontrol ve teslim

Kontrol bu iki dosyanın etkisine orantılı olsun: tam diff, doğru ve erişilebilir linkler, kaynakla tutarlı amaç, gerçek grant kapsamı, eski dosyaların değişmemesi, aday/kabul ayrımı ve boşta bırakılmamış güncel iş durumu. Yerel RESULT'taki iddiayı bu asistanın bağımsız gözlemi gibi yazma.

Koordinatör tek yazıcıdır. Somut bir yorum ihtiyacı varsa en fazla bir native salt-okur yardımcı kullanabilirsin; zorunlu onay töreni değildir, bağımsız işletim kabulü sayılmaz. Yardımcı kaynaklı görüş verir, dosya yazmaz; yeni takım veya CLI alt süreç kurmaz.

Yalnız bu iki dosyayı açıkça stage edip gerekli yerel snapshot commit'ini oluşturabilirsin. Toplu stage, amend/rebase, force, main merge, push/PR/issue veya Git ayarı değişikliği yok. Mevcut platform onaylarını koru. Hook/izin/kimlik engelini bypass etme; commit oluşmazsa hazırlanmış yerel değişiklikleri doğru statüyle raporla. Kendi commit hash'ini kendi içine yerleştirmek için sonsuz commit üretme; exact son ref'i teslim mesajında ver.

Hedef: tek sınırlı hazırlık, yaklaşık 30 dakikalık çalışma bütçesi; bu süre başarı garantisi veya mekanik timeout değildir. Kapsam/bütçe/bağlam biterse mevcut durumu devret, yeni alt iş açma. Eski görev bütçeleri sıfırlanmaz; bu yalnız ayrı kullanıcı benimsemesiyle doğan yeni dar iştir.

Türkçe teslim: **gerçek branch/HEAD**, iki dosyanın tam metni veya incelenebilir tam diff, kontroller ve sınırları, son Git durumu, korunmuş eski ref/dosyalar, varsa yardımcı katkısı, yazıcının bıraktığı kayıt ve yeni oturumun giriş noktası. Esas içeriği mevcut sohbette ver; yalnız yerel ZIP linkine bağlama.

**Dur:** Bu yerel hazırlığı teslim et. Yeni ana oturumu alt ajan/fork/CLI ile taklit edip başarı sayma. Hazırlık yapan oturumun dosyaları yeniden okuması fresh-session sonucu değildir. Sonraki yeni sohbet gerçek teslim ref'inden açılacaktır.

Claude/başka sağlayıcı çağrısı, gstack kurulumu, G1-R1, yeni paket/credential, config/izin değişikliği, dış servis yazması, ürün veya gözetimsiz çalışma bu yetkiye dahil değildir. Değişen iki kayıt, C1 çalışma sözleşmesinin genel olarak kabul edildiği anlamına gelmez.
