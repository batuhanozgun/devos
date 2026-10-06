# C01 sonda deneme (probe) kurulumu — senin adımların (Türkçe)

Bu dosya, C01'de senden istenecek adımları toplar. Dört bölüm var: kurulum, bir
soru, silme ve yalnız gerekirse çalışacak adımlar. Her adım tek bir iştir ve
sonunda ne görmen gerektiğini yazdım. Hiçbir adımda sohbete anahtar ya da belirteç
yazman istenmez.

**Önemli:** Hiçbir adım ücretli bir özelliği açmaz. "Usage credits" (kullanım
kredisi) ve "fast mode" kapalı kalsın; bu adımların hiçbiri onları açmaz.

Bazı adımların yanında **(plan değişikliği bekliyor)** yazıyor. Bu, o adımın
planın bugünkü metninde olmadığını gösterir; plan değişmeden bu adım senden
istenmez.

---

## Bölüm 1 — Kurulum

Bu bölüm sana tek seferde gönderilir.

1. **(plan değişikliği bekliyor)** Supabase'de `devos-test` projesinin
   **Project Settings** bölümünde API anahtarlarının listelendiği sayfayı aç;
   **publishable** (eski adıyla **anon**) yazan anahtarın yanındaki kopyala
   düğmesine bas. (Bu anahtar gizli değildir; **secret** ya da **service_role**
   yazan anahtarı kopyalama.)
   *Sonunda:* anahtar panoya kopyalanmış olur (sohbete yazma).

2. `claude.ai/code` → bulut simgesi → **Cloud** → **Add cloud environment**.
   **Name**: `devos-probe-a`. **Network access**: **Full**. Aynı pencerede
   **Environment variables** alanına üç satır ekle:
   `DEVOS_PROBE_C01=1`,
   `PROBE_SUPABASE_URL=https://cqbzxexxwrrbrlszoseg.supabase.co`,
   `PROBE_SUPABASE_ANON_KEY=` (eşittirden sonra 1. adımda kopyaladığın anahtarı
   yapıştır). **Create environment**.
   *Sonunda:* listede `devos-probe-a` ve içinde üç değişken görünür.

3. Aynı yolla `devos-probe-b` ortamını oluştur: **Network access Full**, aynı üç
   değişken (anahtar aynı). **Create environment**.
   *Sonunda:* listede `devos-probe-b` ve içinde üç değişken görünür.

4. Supabase'de `devos-test` → **SQL Editor** → sana vereceğim probe metnini
   (`P3_probe_schema.sql`) bir kez çalıştır.
   *Sonunda:* "Success" görürsün; hata yoksa tamamdır.

5. Aynı SQL ekranında tek satır çalıştır:
   `select public.probe_c01_issue_token('probe_a');`
   *Sonunda:* `devos-probe-a`'nın belirteci bir kez gösterilir; değerini kopyala.

6. `devos-probe-a` ortamını düzenlemeye aç → **API credentials** → **Add
   credential**: **Credential type** varsayılan **Bearer**; **Name** `probe-token`;
   **Allowed websites** `cqbzxexxwrrbrlszoseg.supabase.co`; **Custom headers**
   satırında **Name** `X-Probe-Token`, **Prefix** alanını **boşalt**, **Value** 5.
   adımda kopyaladığın belirteç. **Connect**. (Belirteci yalnız bu alana yapıştır.)
   *Sonunda:* `devos-probe-a`'nın API credentials listesinde `probe-token` kaydı,
   karşısında `cqbzxexxwrrbrlszoseg.supabase.co` ile görünür.

7. SQL ekranında tek satır çalıştır:
   `select public.probe_c01_issue_token('probe_b');`
   *Sonunda:* `devos-probe-b`'nin belirteci bir kez gösterilir; değerini kopyala.

8. `devos-probe-b` ortamını düzenlemeye aç → **API credentials** → **Add
   credential** → 6. adımdaki aynı alanlar, **Value** 7. adımın belirteci. **Connect**.
   *Sonunda:* `devos-probe-b`'nin listesinde de `probe-token` kaydı görünür.

9. **(plan değişikliği bekliyor)** `claude.ai/code/routines` → **New routine**
   formunu doldur: ad `probe-c01-a`; talimat kutusuna `routine_a_instruction.md`
   dosyasının metnini yapıştır; model seçicide **Opus 5.5**; repository yalnız
   **devos**; ortam **devos-probe-a**; formun altındaki **Connectors** bölümünde
   **GitHub dışındaki tüm bağlayıcıları kaldır** (GitHub'ı kaldırma). Henüz
   **Create**'e basma.
   *Sonunda:* form dolu; bağlayıcılarda yalnız GitHub kalır.

10. **(plan değişikliği bekliyor)** Aynı formda **Select a trigger** → **GitHub
    event**: olay **Pull request → opened**; repository **batuhanozgun/devos**;
    **Head branch** filtresi, işleç **matches regex**, değer
    `^claude/probe-c01-go-a-[0-9]+$`. Sonra **Create**.
    *Sonunda:* `probe-c01-a` rutini listede, tetikleyicisi bu GitHub olayıdır.

11. **(plan değişikliği bekliyor)** Aynı yolla `probe-c01-b` formunu doldur:
    talimat kutusuna `routine_b_instruction.md` dosyasının metni; model **Opus
    5.5**; repository **devos** ve **devos-evals** (ikisi); ortam **devos-probe-b**;
    GitHub dışı bağlayıcıları kaldır. Henüz **Create**'e basma.
    *Sonunda:* form dolu; bağlayıcılarda yalnız GitHub kalır.

12. **(plan değişikliği bekliyor)** Aynı formda **Select a trigger** → **GitHub
    event**: **Pull request → opened**; **batuhanozgun/devos**; **Head branch**,
    **matches regex**, `^claude/probe-c01-go-b-[0-9]+$`. Sonra **Create**.
    *Sonunda:* `probe-c01-b` rutini listede, tetikleyicisi bu GitHub olayıdır.

Bu kadarını yapınca bana haber ver; çalışmaları ben başlatırım.

---

## Bölüm 2 — Soru

Bu soru, deneme sürecinde makine hesabı `devos`'ta bir konu (issue) açıp seni
**atadığında** (assign) sorulur:

- `#6` numaralı konuda: makine hesabının açıp sana atadığı o deneme konusundan
  GitHub uygulaması seni haberdar etti mi? (Evet / Hayır) — tek cümlelik cevabını
  `batuhanozgun` hesabından yaz.

---

## Bölüm 3 — Silme

Probe'lar bittiğinde haber vereceğim; sonra:

13. `devos-probe-a` ortamını düzenlemeye aç → **API credentials** → `probe-token`
    kaydının yanından sil.
    *Sonunda:* `devos-probe-a`'nın listesinde `probe-token` kalmaz.

14. Aynı yolla `devos-probe-b`'nin `probe-token` kaydını sil.
    *Sonunda:* `devos-probe-b`'nin listesinde `probe-token` kalmaz.

15. **(plan değişikliği bekliyor)** `devos-probe-a` ortamını düzenlemeye aç →
    **Archive**.
    *Sonunda:* `devos-probe-a` arşivlenmiş görünür ve yeni oturum başlatamaz.

16. **(plan değişikliği bekliyor)** Aynı yolla `devos-probe-b` ortamını arşivle.
    *Sonunda:* `devos-probe-b` arşivlenmiş görünür.

17. `probe-c01-a` rutininin adının yanındaki menü → **Delete**.
    *Sonunda:* `probe-c01-a` listede kalmaz.

18. Aynı yolla `probe-c01-b` rutinini sil.
    *Sonunda:* `probe-c01-b` listede kalmaz.

19. **(plan değişikliği bekliyor; yalnız gerekirse)** Satır 8'in denemesi `devos`
    üzerinde `claude/` dışında bir dal oluşturduysa, sana söyleyeceğim dalı GitHub'da
    elle sil (depo → Branches → ilgili dalın yanındaki silme simgesi).
    *Sonunda:* o dal listede kalmaz.

Not: `devos-test`'teki probe şeması ve belirteç özetleri (hash) burada silinmez;
onları C02'nin ilk göç (migration) işlemi kaldıracak. Bu senin bir adımın değildir.

---

## Bölüm 4 — Yalnız gerekirse çalışacak adımlar

Bunlar ancak ben söylersem gönderilir; olağan akışta istenmez.

20. **(plan değişikliği bekliyor)** Bir probe çalışması, ilgili pull request
    açıldıktan 15 dakika içinde başlamadıysa: sana söyleyeceğim rutinin sayfasında
    (`claude.ai/code/routines` → rutinin adı) **Run now**'a bas.
    *Sonunda:* o rutinin yeni bir oturumu başlar.

21. **(plan değişikliği bekliyor)** Bir deneme belirteci kendi ortamının ayar alanı
    dışında bulunursa: `devos-test` → **SQL Editor**'de tek satır çalıştır (sızan
    belirteç `devos-probe-b`'ninse `'probe_b'`):
    `select public.probe_c01_revoke_tokens('probe_a');`
    *Sonunda:* bir sayı görürsün (silinen kayıt sayısı).

22. O ortamın **API credentials** bölümünde `probe-token` kaydını sil.
    *Sonunda:* listede `probe-token` kalmaz.

23. SQL ekranında o ortamın tek satırını yeniden çalıştır (5. ya da 7. adım).
    *Sonunda:* yeni belirteç bir kez gösterilir; değerini kopyala.

24. O ortama `probe-token` kaydını yeniden ekle (6. ya da 8. adım, **Value** 23.
    adımın belirteci).
    *Sonunda:* ortamın listesinde yeniden `probe-token` görünür.
