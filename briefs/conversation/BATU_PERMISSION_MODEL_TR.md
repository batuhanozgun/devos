# Batu leaves auto mode: written reasons for every block, explicit rules, Opus 5.5 with ultracode for every session (D-008)

**Provenance.** Batu wrote these texts on 2026-10-04 in his conversation session `session_01Q32nLatKbtDDY1zSVQZiKX` (an answer given in a builder chat is accepted, operating model section 6). The Turkish texts below are verbatim; the times are the session's message times. Between them, the conversation session explained what had blocked the day's runs (Claude Code's auto-mode classifier and its rule texts), proposed the Accept edits mode with the builder's own written rule file, and stated the costs (summarised under "What he was told"; the conversation itself is not copied here).

## Original (Turkish, verbatim)

### (1) 15:01:39Z

> Gerekçe de yazsın o zaman, gerekçe yazmayınca biz nasıl anlayacağız neden yaptığını. Hem de öyle yüzeysel değil, ne yaşandıysa detayıyla yazsın. Denetim yapılamıyor sistemde.
>
> Bu sorunu çöz. ayrıca açtığın oturumlardaki modeli Opus 5.5 ve eforu da ultracode yap. kural olarak belirle bunu. geçici olmasını istemiyorum.

### (2) 15:13:59Z and 15:14:37Z

> o zaman auto mode'da çalışmayalım

> bak başka seçenekler de var

(With a screenshot of the session's mode menu: Auto, Accept edits, Plan.)

### (3) 17:00:14Z, a question that states his expectation

> peki birleştirme neden incelemesiz yapılıyor? Kurala takılan şey inceleme ise inceleme yaptıralım. Olmaz mı? Bu inceleme kim tarafından yapılmalı?
>
> bir de birleştirme dediğimiz şey ne?
>
> Bunları iyi anlamak lazım.

### (4) 17:04:49Z

> tamam yapacak bir şey yok o zaman öyle yapılacak.

## What he was told before (4) (the conversation session's summary, not a transcript)

- The blocks of the day came from Claude Code's auto mode, not from DevOS: a separate model judges each step and gives only a rule name. Its merge rule wants a human's approval, and it does not count another Claude session's review, or a session the builder started, as one.
- Proposal: leave auto mode for Accept edits, and write every allowed and every forbidden action into the builder's own rule file. The file lets the allowed ones through by itself and refuses the others with their written reason; nobody is asked. Explicit bans besides: writing straight to the main record, deleting history, sending data to outside addresses, using account connections.
- Gain: every refusal comes with a written reason that can be read at any time.
- Cost 1: Anthropic's check also catches dangers nobody listed in advance, for example a hidden instruction in a document that makes a session send data out. That protection goes; only the rules the builder writes remain.
- Cost 2: if the rule list is incomplete, work stops at the first gap until the list is completed.
- Important changes still pass an independent Claude session's review, for quality.

## English interpretation

1. **Auditability is the requirement.** A block without a detailed written reason makes the system impossible to audit. Every block must say in detail what happened and why (text 1). This is his expectation of the working system, not a technical design choice; the design is the builder's.
2. **Model and effort are a standing rule.** Every session the builder opens runs on Opus 5.5 with ultracode effort, permanently (text 1).
3. **No auto mode.** The system runs in Accept edits, with the builder's own written rules deciding, as proposed (texts 2 and 4), and he accepted the stated costs (text 4).
4. **Reviews stay.** He expects merges to be reviewed, and asked who should review (text 3). His answer (4) accepts that important changes are reviewed by an independent Claude session, not by him.
5. **What he did not do.** He gave no technical approval and no permission for any refused action. Recorded as decision D-008 (`plan/decisions/D-008.md`), carried out as item W-C00-12.6.
