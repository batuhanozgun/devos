# C01 sonda deneme (probe) kurulumu — senin adımların (Türkçe)

Bu dosya, C01'de senden istenecek adımları toplar. Üç bölüm var: kurulum
(W-C01-05), bir soru (W-C01-13) ve silme (W-C01-29). Her adım tek bir iştir ve
sonunda ne görmen gerektiğini yazdım (Ek E bölüm 7). Hiçbir adımda sohbete anahtar
ya da belirteç yazman istenmez (Ek E bölüm 6).

**Önemli:** Hiçbir adım ücretli bir özelliği açmaz. "Usage credits" (kullanım
kredisi) ve "fast mode" kapalı kalsın; bu adımların hiçbiri onları açmaz.

---

## Bölüm 1 — Kurulum (W-C01-05)

Bu bölüm, W-C01-02, W-C01-03 ve W-C01-04 `main`'e girdikten sonra tek seferde
gönderilir. (Section 12 madde 0.)

### Ortamlar

1. `claude.ai/code` → mesaj kutusunun üstündeki, o anki ortamın adını gösteren
   bulut simgesine tıkla → **Cloud** → **Add cloud environment**. **Name**
   alanına `devos-probe-a` yaz. **Network access** alanını **Full** seç.
   **Create environment** düğmesine bas.
   *Sonunda:* ortam listesinde `devos-probe-a` görünür.

2. Aynı yolla ikinci ortamı oluştur: **Name** `devos-probe-b`, **Network access**
   **Full**, **Create environment**.
   *Sonunda:* listede `devos-probe-b` de görünür.

3. `devos-probe-a` ortamının üstüne gel → sağda çıkan ayar (dişli) simgesine bas
   → **Edit environment**. **Environment variables** alanına, her satır bir
   `KEY=value` olacak şekilde şunları ekle:
   - `DEVOS_PROBE_C01=1`
   - `PROBE_SUPABASE_URL=https://cqbzxexxwrrbrlszoseg.supabase.co`
   - `PROBE_SUPABASE_ANON_KEY=` — eşittir işaretinden sonrasına, Supabase'de
     `devos-test` projesinin **API** ayarlarındaki **publishable (anon)**
     anahtarını kendin kopyala yapıştır. (Bu anahtar gizli değildir, plan 6.2; yine
     de değerini sen giriyorsun, ben yazmıyorum.) Kaydet.
   *Sonunda:* üç değişken `devos-probe-a` ortamında görünür.

4. Aynı üç değişkeni `devos-probe-b` ortamına da ekle (3. adımdaki gibi). Kaydet.
   *Sonunda:* üç değişken `devos-probe-b` ortamında da görünür.

### Deneme şeması ve belirteçler (Supabase `devos-test`)

5. Supabase'de `devos-test` projesini aç → **SQL Editor**. Sana vereceğim probe
   metnini (`P3_probe_schema.sql`) bir kez çalıştır.
   *Sonunda:* "Success" görürsün; hata yoksa tamamdır.

6. Aynı SQL ekranında şu tek satırı çalıştır:
   `select public.probe_c01_issue_token('probe_a');`
   Çıkan değer `devos-probe-a`'nın belirtecidir ve bir kez gösterilir. Değeri
   kopyala. Sonra `devos-probe-a` ortamını düzenlemeye aç → **API credentials**
   bölümü → **Add credential** → **Credential type** varsayılan **Bearer** kalsın
   → **Name**: `probe-token` → **Allowed websites**:
   `cqbzxexxwrrbrlszoseg.supabase.co` → **Custom headers** satırında **Name**:
   `X-Probe-Token`, **Prefix** alanını **boşalt**, **Value**: az önce kopyaladığın
   belirteci yapıştır → **Connect**. (Belirteci yalnız bu alana yapıştır; başka
   hiçbir yere yazma. Kaydettikten sonra değeri bir daha göremezsin.)
   *Sonunda:* `devos-probe-a` ortamının API credentials listesinde `probe-token`
   adlı bir kayıt, karşısında `cqbzxexxwrrbrlszoseg.supabase.co` ile görünür.

7. Aynı işi `devos-probe-b` için yap: SQL ekranında
   `select public.probe_c01_issue_token('probe_b');` çalıştır, çıkan belirteci
   kopyala, `devos-probe-b` ortamını düzenle → **API credentials** → **Add
   credential** → **Bearer** → **Name** `probe-token` → **Allowed websites**
   `cqbzxexxwrrbrlszoseg.supabase.co` → **Custom headers**: **Name**
   `X-Probe-Token`, **Prefix** boş, **Value** belirteç → **Connect**.
   *Sonunda:* `devos-probe-b` ortamının listesinde de `probe-token` kaydı görünür.

### Rutinler (routines)

8. `claude.ai/code/routines` → **New routine**. Ad: `probe-c01-a`. Talimat
   kutusuna sana vereceğim `routine_a_instruction.md` metnini yapıştır.
   Talimat kutusundaki model seçicisinden **claude-opus-5-5**'i seç. Repository
   olarak yalnız **devos**'u seç. Ortam olarak (talimat kutusunun altındaki bulut
   simgesi) **devos-probe-a**'yı seç. **Select a trigger**: bir **Schedule** seç
   ve çok ileri bir tarih/zaman ver (örneğin bir ay sonrası), ya da tetikleyici
   boş bırakılabiliyorsa boş bırak — çalışmalar **Run now** ile başlayacak.
   **Connectors** bölümünde, GitHub dışındaki tüm bağlayıcıları (connector)
   **kaldır**; GitHub bağlantısını kaldırma (kopyalama/klonlama için gerekli).
   **Create**'e bas.
   *(Bulgu:)* Section 12 madde 0 "tüm bağlayıcıları kaldır" diyor; GitHub'ı ayrık
   tutuyoruz, çünkü silinirse depo klonlanamaz. Bu fark aşağıda bulgu olarak
   listelendi.
   *Sonunda:* `probe-c01-a` rutini listede görünür, bağlayıcı listesinde yalnız
   GitHub (varsa) kalır.

9. Aynı yolla ikinci rutini oluştur: ad `probe-c01-b`, talimat
   `routine_b_instruction.md`, model **claude-opus-5-5**, repository **devos** ve
   **devos-evals** (ikisi birden), ortam **devos-probe-b**, tetikleyici 8. adımdaki
   gibi, **Connectors**'ta GitHub dışındakileri kaldır. **Create**.
   *Sonunda:* `probe-c01-b` rutini de listede görünür.

Bu kadarını yapınca bana haber ver; gerisini ben yürütürüm. Çalışmaları **Run
now** ile başlatmanı ayrıca, tek tek isteyeceğim.

---

## Bölüm 2 — Soru (W-C01-13, satır 6)

Bu soru, deneme sürecinde makine hesabı `devos` üzerinde senin adına bir konu
(issue) açtığında sorulur:

- `#6` numaralı konuda, GitHub uygulaması seni o deneme konusundan haberdar etti
  mi? (Evet / Hayır) — tek cümlelik cevabını `batuhanozgun` hesabından yaz.

---

## Bölüm 3 — Silme (W-C01-29)

Probe'lar bittiğinde haber vereceğim; sonra:

10. Her iki probe ortamının **API credentials**'ındaki `probe-token` kaydını sil
    (ortamı düzenlemeye aç → kaydın yanındaki sil). *Sonunda:* listede
    `probe-token` kalmaz.

11. Her iki probe ortamını **arşivle**: ortamı düzenlemeye aç → **Archive**.
    *(Bulgu:)* Platform ortamı silmeye izin vermiyor, yalnız arşivlemeye; Section
    12 madde 0 "probe ortamlarını silmek" diyor. Bu fark aşağıda bulgu olarak
    listelendi. *Sonunda:* ortam "archived" görünür ve yeni oturum başlatamaz.

12. Her iki probe rutinini sil: rutin adının yanındaki menü → **Delete**.
    *Sonunda:* rutinler listede kalmaz.

13. *(Yalnız gerekirse — bulgu.)* Satır 8'in denemesi `devos` üzerinde `claude/`
    dışında bir dal (branch) oluşturduysa, o dalı GitHub'da elle sil (depo →
    Branches → ilgili dalın yanından sil). Bunu sana, hangi dal olduğunu
    söyleyerek tek tek ileteceğim. *(Platform ve güvenlik kancası dal silmeyi
    reddediyor; bu yüzden bu bir senin adımın.)*

Not: `devos-test`'teki probe şeması ve belirteç özetleri (hash) burada silinmez;
onları C02'nin ilk göç (migration) işlemi kaldıracak. Bu bir senin adımın değil.

---

## Bölüm 4 — Yalnız bir belirteç dışarı sızarsa (N-124)

Bu bölüm ancak bir deneme belirteci kendi ortamının ayar alanı dışında bulunursa
sana gönderilir; öyle bir şey olmazsa hiç gönderilmez. Hangi ortam olduğunu
söyleyerek isteyeceğim.

14. Supabase'de `devos-test` → **SQL Editor**'de şu tek satırı çalıştır (sızan
    belirteç `devos-probe-b`'ninse `'probe_b'` yaz):
    `select public.probe_c01_revoke_tokens('probe_a');`
    *Sonunda:* bir sayı görürsün (silinen kayıt sayısı, genellikle 1).

15. O ortamın **API credentials** listesindeki `probe-token` kaydını sil (ortamı
    düzenlemeye aç → kaydın yanındaki sil). *Sonunda:* listede `probe-token`
    kalmaz.

16. Yeni belirteç için 6. adımı (ya da `devos-probe-b` için 7. adımı) baştan yap.
    *Sonunda:* ortamın listesinde yeniden `probe-token` görünür.

## Section 12 madde 0'ın sözünün ötesine geçen adımlar (bulgular)

Aşağıdakiler, working order bölüm 8'e göre, sana sorulmadan önce bir bulgu olarak
kaydedilir (plan Section 14 ile ele alınır). Bu dosya onları işaretler; kararı ben
vermem.

- **F-1 (8. ve 9. adım):** "Tüm bağlayıcıları kaldır" yerine "GitHub dışındaki
  bağlayıcıları kaldır". Gerekçe: GitHub kaldırılırsa depo klonlanamaz
  (setup-facts raporu, `routines` ve `cloud-environments` sayfaları).
- **F-2 (11. adım):** "Ortamı silmek" platformda yok; karşılığı "API credential'ı
  sil, sonra ortamı arşivle" (setup-facts raporu, `cloud-environments` sayfası).
- **F-3 (13. adım):** `claude/` dışındaki bir dalın silinmesi senin bir adımın;
  git proxy'si ve güvenlik kancası dal silmeyi reddediyor.
- **F-4 (14.–16. adım, yalnız gerekirse):** Sızan bir deneme belirtecinin C02'den
  önce iptal edilip yenilenmesi (plan C01 satır 3'ün başarısızlık yolu: "ayar
  alanı dışında bulunan belirteç iptal edilir ve yenilenir"); Section 12 madde 0
  bunu saymıyor ve ben iptal edemem (Supabase erişimim yalnız okuma). Not N-124.
