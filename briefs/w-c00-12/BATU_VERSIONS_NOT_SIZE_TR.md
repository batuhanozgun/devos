# "First" is not "small": versions and phases, not a size rule (input to W-C00-12)

**Provenance.** Batu wrote this himself, in chat with builder session `session_016Hi3ZYgAf2amYNGc43a3tr`, on 2026-10-03 at about 19:10Z. He was answering the builder's concern that the W-C00-12 design had grown large (about 1,800 lines of design text, 74 mechanism rows) and that the first tranche should be checked for being "really small". He asked that both the builder and the sessions working on the tranches understand it. The Turkish text below is his message, verbatim; the builder's short assessment follows.

## Original (Turkish, verbatim)

Kaygını anladım. ama küçük başlayıp büyümesi diye tek yönlü düşünme. Bunu bir versiyon ya da faz olarak düşün. henüz bilmiyorsun ama belki en küçük hali 1800 satırdı belki de 1800 satır ile başlayan versiyon sonrasında küçülür, daha kompakt olur. İlk parti küçük olacak diye zorunlu bir kural yok. düşününce bir anlamda haklısın, ilk parti sonraki partilerden küçük olmalı diye yaygın bir inanış var ama bu her şey için geçerli değil, her iki olasılığı da düşünmelisin. nerde ilk parti küçük olmalı diye yazıyorsa, onunla ilgili çalışacak oturumların da senin de şunu anlamasını istiyorum, sorgulamayı elden bırakmadan çalışmaya devam etmek lazım, "ilk parti küçük" demek gerçek anlamıyla küçük olacağı anlamına gelmeyebilir, "ilk hali" anlamına gelebilir, belki de sonraki aşamalarda küçülecek, kod satırı azalcak ama kalite aynı kalacak bunu henüz bilmiyoruz.

## Builder's assessment (English)

1. **The bias was the builder's.** The design does not contain a rule that the first tranche must be small. The tranche plan stages work by trigger and gate (`plan/builder/w-c00-12/12_tranche_plan.md`). The "small" framing came from the builder's own message to Batu, and from the Turkish briefing draft's wording "Önce küçük bir ilk parti" (`plan/builder/w-c00-12/09_batu_briefing_tr.md`, item 6). It is the framing problem of `BATU_GROWTH_AND_FRAMING_TR.md` in the builder's own sentence: "grow from small" hides "start complete, then compact".
2. **Size is not the measure; fit is.** R-W12-1's cause K4 already said that proportionality was judged by rule count rather than by timing. The question for each tranche is not "is it small?" but four questions:
   - does every mechanism in it answer a demonstrated demand;
   - does it have a test;
   - is it needed now rather than on a later trigger;
   - can it be removed when it stops paying (plan §6.12 item 4)?
   A first version that is larger but complete can be the right one. A later version may then be more compact at the same quality, for example by merging mechanisms or replacing hand rules with one generated view. Both directions stay open.
3. **What follows for the runs.** No new acceptance condition and no new rule. The runs should:
   - read "first tranche" as "first version";
   - keep questioning its size in both directions while working;
   - plan a compaction review between versions, as well as additions, through the mechanism assumption inventory (§6.12 item 4).
   The briefing wording "küçük bir ilk parti" should become "ilk sürüm" or similar.
