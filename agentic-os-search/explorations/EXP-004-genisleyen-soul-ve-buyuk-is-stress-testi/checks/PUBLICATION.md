# EXP-004 — Kaynak onarımı: gerçek yayın ve kontrol kaydı

**21 Eylül 2026. MAIN YAYINI VE BELİRTİLEN GERİ OKUMALAR TAMAMLANDI.** Bu kayıt kaynak sadakatiyle Git transferini ayrı değerlendirir. İlk PR #29/#30 yayın metni [HISTORICAL-PUBLICATION](HISTORICAL-PUBLICATION-PR29-30.md) içinde değişmeden korunur; eski tamlık iddiası güncel hüküm değildir.

## Yayın kimlikleri

| Yüzey | Gözlenen kimlik |
|---|---|
| Başlangıç ve gerçek merge ilk parent | `fb488942ddbd951f3ce5887c1acdab2c3aac8bc6` |
| Onarım dalı | `repair/exp-004-source-fidelity-20260921` |
| PR | [#31](https://github.com/batuhanozgun/agentic-os-search/pull/31) |
| Exact expected / yayımlanan head | `ade5055d3bce16c988f658b15d0a4cc7545530d0` |
| Gerçek merge commit | `b949fe66454a1943ac9c99827e79f68f962658be` |
| Head ve merge ortak root tree | `4551c2022c13bceab8947468e4dc3bf2d6620e60` |
| Tam kaynak payload checkpoint'i | `f1e93a9f052fb98b3f2e28e987233f3b51193534` |
| Assistant kaynak alt-ağacı | `ba3111b97927ebb231947b2a500eee1d534a5a16` |
| Kullanıcı kaynağı blob'u | `1866f243b3771a2d0152bc6b20f67c1a7f3f80c3` |

GitHub merge cevabı `merged: true` verdi. Ardından Git commit nesnesinden gerçek parent'lar ve root tree okundu; merge ağacı yayımlanan head'le tam aynıdır. Main okuması da yeni içerikleri döndürdü. İlk PR cevabındaki geçici mergeable=false değeri tek başına conflict sayılmadı; gerçek merge sonucu kaydedildi.

## Kapsam kontrolü

Başlangıç→head karşılaştırması **50 yol**, PR metadata'sı da 50 changed_files gösterdi. Fark yalnız EXP-004 ve `explorations/INDEX.md` / `CATALOG.md` içindedir. 22 ekleme ve 28 değiştirme, dosya silme yok. Merge ilk parent başlangıç main ile aynı ve root tree head'le eşit olduğundan bu kapsam merge için de korunmuştur.

T1–T7 CONSOLIDATION ve T08 continuation notu değişmedi; önceki EXP kaynakları, Foundation, studies, concepts, agent-control ve target repository'leri değiştirilmedi. Bu bütün repository'nin yeni denetimi veya kusursuzluk sertifikası değildir.

## İçerik kimliği ve tarihsel koruma

[Manifest](../SOURCE-MANIFEST.json): 31 görünür mesaj, 16 kaynak dosyası, arşiv başlıkları dahil 182.486 UTF-8 byte. Boyutlar Git tree/contents kayıtlarından; toplamı ayrıca hesaplandı. Bu yerel yeniden-indirme/SHA-256 deneyi değildir.

Eski 13 yoğunlaştırılmış görünümün ağacı `1d644cc987d82e57b057d27baea4f84ba87755c6`; eski manifest `66a3a8906183bc7df32f9632e1a8830f38ebded7`; eski PUBLICATION `d77f7952249f2e2447247ccd1549161f6360f34b`; ilk FIDELITY `00d77d111f5d58b4e5d18c9bdbfd0fe2f8f06273`. Bunlar Git nesneleri olarak aynı kimliklerle açık tarihsel konumlara bağlandı. Yeni kaynaklar bu eski metinleri görünmez biçimde ortadan kaldırmadı.

## Yapılan metin okumaları

Kaynak payload ref'inde USER-MESSAGES, S001, S013 ve S015 uzaktan başlangıç–son aralıklarıyla tam geri okundu. Bütün kaynak gövdeleri yazım sırasında görünür özgün yanıtlardan aktarıldı; bütün 16 dosyanın Git kimlik/byte kayıtları alındı. Bütün dosyaların uzaktan ikinci tam metin okuması iddia edilmez. Ayrıntılı aralıklar [REPAIR](REPAIR-20260921.md) içinde.

Merge sonrası main'den tam geri okunan kritik metinler:
- SOURCE-MANIFEST: blob `7d54d859ee36679d504d3d66e6ac42b96d452c88`;
- STATE'in bu kapanış öncesi içerik-onarıldı checkpoint'i: `eb66a912796b90740cde39e3a98e02bcd069f2be`;
- package INDEX: `94001b0d8d10169a391d57cd010406f2c586c395`;
- kaynak diyalog INDEX: `1c73b29aad82ad02faf68ba7a64d61ce4e4370b8`;
- U016 FRAME-CLARIFICATION: `0ab496cd9740fafb1ea1efb4bbde1717f8e9f338`;
- kütüphane CATALOG: `ee6d1e277e26bb78125952b9ca4138d7e50f5583`.

Bunlar kaynak/özet ayrımını, 31 mesajlık sırayı, 126 mesajlık kümülatif adreslemeyi ve U016'nın araç/mimari seçimi yapılmamasını main üzerinde yeniden gösterdi. Kaynak hash'leri tek başına doğal-dil sadakati oracle'ı sayılmadı. Otomatik bütün-repo link-crawler veya bağımsız fresh-session anlama testi yapılmadı.

## Kapanış sınırı

Bu metin, STATE, WORK-PLAN ve REPAIR; gerçekleşmiş PR #31 ve yukarıdaki readback'lerin ardından yapılan package-local kapanıştır. Kendi gelecekteki commit kimliğini uydurmaz; terminal ref/diff/readback ayrıca kontrol edilir. Kaynak gövdeleri, manifest ve türetilmiş model bu kapanışta değişmez.

Bilinen arşiv eksikliği bu kapsamda kapalıdır; kullanıcıdan upload veya merge beklenmez. Tam görünür metin aktarımı ham platform export'u veya bağımsız transkripsiyon değildir. Modelin teknik doğruluğu, SOUL etkinliği, kalıcı davranış iyileşmesi veya önceki üç EXP'nin yeniden denetimi iddia edilmez. Bu tur T09 başlatılmadı.
