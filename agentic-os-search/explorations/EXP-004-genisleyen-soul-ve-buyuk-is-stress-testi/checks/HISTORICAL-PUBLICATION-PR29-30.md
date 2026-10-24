# EXP-004 — Yayın ve doğrulama kaydı

**21 Eylül 2026. Durum: MAIN YAYINI TAMAMLANDI / sınırlı repository readback gerçekleştirildi.**

## Yayın kimlikleri

| Yüzey | Kimlik |
|---|---|
| Başlangıç main | `25c2e6615990c4ad9a8acdd508ae5a6acab95b5d` |
| Çalışma dalı | `archive/exp-004-expanding-soul-20260921` |
| PR | [#29](https://github.com/batuhanozgun/agentic-os-search/pull/29) |
| PR head | `2ed6255f391d71b6be4d3a4b16cf35b703c8a110` |
| Merge commit | `46ab3ff5993683c6124d7786533529e0f6147914` |
| Kapanış dalı | `archive/exp-004-close-20260921` |

PR #29 exact expected head ile merge edildi; GitHub `merged: true` döndürdü.

## Değişiklik kapsamı

Başlangıç main → merge karşılaştırması:
- status: ahead;
- 36 commit (35 archive branch commit'i + merge);
- **34 changed files**;
- yalnız `explorations/**`.

Değişiklikler:
- yeni EXP-004 package;
- `explorations/INDEX.md`;
- `explorations/CATALOG.md`.

Foundation, studies, concepts, agent-control ve target repositories bu arşiv kapsamına girmedi.

## Source identity ve readback

SOURCE-MANIFEST:
- 14 source files;
- U001–U014: 14 user messages;
- S001–S013: 13 assistant substantive responses;
- total 27 substantive messages;
- recorded total text length: 74,544 characters.

Main üzerinden geri okunan kritik yüzeyler:
- package `INDEX.md` — blob `ae5490ef1fdb25e830418bba5496b6e0499a8396`;
- initial archive `STATE.md` — blob `e3c7bb43ca80d4a4bf353774cdbda7f7b4c95705`;
- `SOURCE-MANIFEST.json` — blob `66a3a8906183bc7df32f9632e1a8830f38ebded7`;
- conversation `INDEX.md` — blob `6bff25b2994d138c48a7084d770b8ac6a49e99d5`;
- `USER-MESSAGES.md` — blob `202b4476b1c6b86a6a12e15e86588b9aacb8e174`;
- `assistant/S013.md` — blob `0160921f0fb5999165d0ad6543675e01581c331f`;
- `CONSOLIDATION.md` — blob `e2867cf73cdda72655afad422bb8be8423fe43f2`;
- library `explorations/INDEX.md` — blob `3f01f80392224782dab315be49740f8979db84e4`;
- library `explorations/CATALOG.md` — blob `4f3b055a91f77277c43462389342f97a4e7462a5`.

Manifest içindeki USER-MESSAGES ve S013 source blob kimlikleri main readback ile aynı bulundu. Bütün 14 source gövdesi archive branch üzerinde blob SHA için geri okunmuştu; publication sonrası main'de seçili kritik source/readback yapıldı. Bu, platform conversation ile byte-perfect eşitlik veya bütün dosyaların ikinci kez tam semantic audit'i değildir.

## Retrieval kontrolü

Conversation INDEX, user source, S013, consolidation ve library routers main üzerinden açıldı. EXP-004 kütüphane INDEX/CATALOG'da bulunur; cumulative route EXP-001→EXP-004 için 122 substantive source message'a yönlendirir.

## Kanıt sınırı

Bu aynı assistant'ın archive/transfer/readback kontrolüdür. Şunları doğrulamaz:
- exploration modelinin bilimsel doğruluğu;
- Foundation completeness;
- SOUL architecture;
- actual agent/runtime behavior;
- external study currentness;
- future session comprehension.

Source files manual model-visible transcription'dır; raw platform export değildir. Routing/progress tool surfaces ayrı substantive source messages olarak arşivlenmedi. Ayrıntı [TRANSCRIPTION-NOTE](TRANSCRIPTION-NOTE.md).

## Kapanış

Source preservation, derived model archive, library routing, main merge ve readback tamamlandı. Kullanıcıdan upload/merge beklenmiyor. Bu arşivleme işi kendi kapsamı içinde kapalıdır.
