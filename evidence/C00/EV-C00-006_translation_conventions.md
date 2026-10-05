# EV-C00-006 · Translation conventions and glossary (W-C00-06, plan C00 step 0)

**What this is.** The shared decisions of the plan-package translation, written before any translator writes (single-writer rule, plan K-7 item 3; Ek D section 2, "ortak kararlar yazmadan önce kayda geçer"). Every translator and every fidelity checker of W-C00-06 works from this file. Decided by the executor (a technical decision, plan 0.3 item 11); changed only by a new revision of this file recorded in the C00 log.

**Source.** The Turkish plan package at `devos` commit `3de3a17a9c230a36c600fb918b6dd76086956527` (main after L-136). From that commit until the translation merges, no change is made to the Turkish text of the files below (log entry L-137). Until the fidelity review passes, the Turkish text is binding (plan 0.6 item 1).

## 1. Scope and layout

1. **Files translated** (plan C00 step 0: the plan, Appendices A–G and the rationale documents): `plan/DevOS_Kurulum_Plani.md`, `plan/Ek_A_Rol_Sozlesmeleri.md`, `plan/Ek_B_Veri_Modeli.md`, `plan/Ek_C_Testler.md`, `plan/Ek_D_Dusunme_Protokolleri.md`, `plan/Ek_E_Iletisim.md`, `plan/Ek_F_Baslangic_Mesaji.md`, `plan/Ek_G_Isleyis_Kurallari.md`, `plan/Calisma_Duzeni_Karsilastirmali_Arastirma.md`, `plan/Uyandirma_ve_Kapasite_Arastirmasi.md`, `plan/Inceleme_Degerlendirmesi_Claude.md`, `plan/Inceleme_Degerlendirmesi_ChatGPT.md`.
2. **In place.** Each English text replaces the Turkish text at the same path, in one merge, after the fidelity review passes. That merge makes the English text the only binding text and removes the Turkish versions from the repository (plan 0.6 item 1; they stay in git history at the source commit). File names stay as they are: renaming them to English names touches about thirty referring files, among them the installation `/goal` itself, and is not translation; it is recorded as a proposal (with note N-003) for W-C00-10.
3. **A translation, not a rewrite** (plan 0.6 item 1). Every sentence, list item, table cell, heading, label, number, date and link is carried over; nothing is added, dropped, merged, summarised, reordered or "improved". A wrong, stale or contradictory statement in the source is translated as it stands and reported as a proposal (section 4).
4. **One note is added**, directly under the title of each file, in italics: `*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*` Nothing else is added except what section 3 requires.

## 2. Form

1. Markdown structure is kept exactly: heading levels, numbering, list nesting, tables (same rows and columns), bold and italics where the source has them, code blocks, blockquotes, horizontal rules, the ✔ and ✘ marks.
2. Kept unchanged: identifiers and names (`K-1`…`K-11`, `C00`…`C12`, `DR01`…`DR16`, `D1`…`D9`, `F01`…`F08`, `N01`…`N28`, `K01`…`K13`, `U-1`…`U-7`, `G1`…`G10`, `H0`…`H10`, `B1`…`B3`, `K1`…`K9`, `PC-01`…`PC-06`, `D-010`, `FR-02`, criterion numbers), file paths, repository names, environment names (`devos-kurulum`, `devos-calisma`, `devos-denetim`, `devos-sinav`), database role names (`devos_calisma`, …), schema, table, field and function names, URLs, product names, numbers and dates (dates written in English: "29 September 2026").
3. A Turkish proper title or quoted Turkish label that refers to something that exists in Turkish (for example the issue title "Batu'dan beklenenler") stays in Turkish, followed once by an English gloss in parentheses.
4. Turkish text inside code blocks is translated (for example the draft `CLAUDE.md` in Appendix D section 2), because it is DevOS text, which is English (plan 0.6).
5. Status labels (plan 0.2): **[Batu kararı]** → **[Batu's decision]**; **[Öneri]** → **[Proposal]**; **[Doğrulandı]** → **[Verified]**; **[Doğrulama bekliyor]** → **[Awaiting verification]**; **[Varsayım]** → **[Assumption]**; **[Açık sorun]** → **[Open problem]**. A label's qualifier is translated with it (for example "[Doğrulama bekliyor: C01]" → "[Awaiting verification: C01]"; "[Batu kararı K6]" → "[Batu's decision K6]"; "[Batu, 29 Eylül 2026]" → "[Batu, 29 September 2026]").
6. Recurring field words: "Amaç" → "Purpose"; "Yapılacaklar" → "Tasks"; "Kabul" → "Acceptance"; "Kriterler" → "Criteria"; "İhtiyaç" → "Need"; "Mekanizma" → "Mechanism"; "Koşullar" → "Conditions"; "Başarısızlık halinde" → "On failure"; "Sınama" → "Testing"; "Statü" → "Status"; "Seçim" → "Choice"; "Önerim" → "My recommendation"; "Ek" (appendix) → "Appendix"; "Bölüm" → "Section"; "madde" → "item".
7. The plan's voice is kept: where the source addresses Batu as "sen", the English uses "you"; where the author writes "Önerim", "my recommendation".

## 3. Batu's own decisions keep their Turkish original

Plan 0.6 item 2: Batu's decisions, constraints and expectations are recorded with their Turkish original and their English interpretation. The Turkish plan text is today the original record of many of them, and step 0 removes it. So:

1. A **labelled passage** is any passage the source marks as Batu's: a label "[Batu kararı …]" or "[Batu, <date>]", or wording that attributes the passage to Batu as his decision, request or expectation (for example "Batu'nun açık talebi", Ek E section 5). Its extent: the sentence, list item, table row or paragraph that carries the label; when the label is in a heading, the whole section under that heading up to the next heading of the same or a higher level; when a label at the end of a paragraph names what it covers ("[Batu kararı: tek yazar ilkesi ve depo kararları]"), the paragraph and the parts it names.
2. The English text translates the passage and keeps the label, followed by `(original: TR-<code>)`.
3. Each translated file ends with a section `## Turkish originals of Batu's decisions` that lists, in order, one entry per labelled passage: `**TR-<code>** · <location in the file> · ` followed by the Turkish source text of the passage **copied byte for byte** (Markdown included; a multi-line passage as a blockquote whose lines are the source lines). Codes are given per translator (section 5) so that parts assemble without renumbering.
4. A file with no labelled passage has no such section.

## 4. What a translator reports, not changes

The final report lists separately: (a) **proposals**: improvements, errors, stale facts, contradictions or unclear passages noticed in the source, each with its location, what is wrong and the suggested change (plan 0.6 item 1: "çeviri sırasında fark edilen iyileştirmeler ayrı öneri olarak kaydedilir"); (b) **translation choices**: any term or passage where the English rendering was uncertain, with the alternatives considered; (c) the list of labelled passages and their codes.

## 5. Glossary (Turkish → English)

Existing English records of the repository already use most of these terms (stage titles in `plan/work/`, `plan/Installation_Working_Order.md`, `.claude/agents/`, the decision summary `briefs/conversation/DECISION_SUMMARY_2026-10-05_EN.md`); the glossary follows them. A term not listed is translated plainly and, if it recurs, reported as a translation choice.

**Actors and roles**

| Turkish | English |
|---|---|
| kurucu; kurucu Claude Code oturumu | builder; builder Claude Code session |
| çalışma oturumu | working session |
| koordinatör (ajan) | coordinator (agent) |
| alt ajan | subagent |
| ekip | team |
| rol; rol sözleşmesi; rol paketi | role; role contract; role package |
| Üretici; Araştırmacı; Sınayıcı; Denetçi; Karşı tasarımcı; Test tasarımcısı | Producer; Researcher; Prober; Checker; Counter-designer; Test designer |
| denetim oturumu; denetim ortamı | audit session; audit environment |
| sınav oturumu; sınav ortamı | exam session; exam environment |
| makine hesabı | machine account |
| aktör | actor |

**Work, state and records**

| Turkish | English |
|---|---|
| aşama | stage |
| iş; iş kaydı; iş listesi | work (a work item); work record; work list |
| görev (Ek B 3.1 `Mission`) | mission |
| görev (an assigned task, elsewhere) | task |
| amaç | purpose (goal where the source means an end state) |
| kabul; kabul koşulu | acceptance; acceptance condition |
| hüküm; bağlayıcı hüküm | verdict; binding verdict |
| inceleme; bağımsız inceleme | review; independent review |
| denetim (as in the environment, purpose and silent-failure checks) | audit |
| çerçeve denetimi; çerçeve incelemesi | frame review |
| denetim izi | audit trail |
| doğrulama; doğrulayıcı | verification; verifier |
| sınama; test | testing; test |
| sınav; gizli sınav; sınav seti | exam; hidden exam; exam set |
| yeterlik; yeterlik profili | competence; competence profile |
| karar; karar kaydı; karar kanalı | decision; decision record; decision channel |
| yüksek etkili | high-impact |
| kısıt; kısıt sorgulama | constraint; constraint questioning |
| kullanıcı modeli | user model |
| kayıt ailesi | record family |
| durum; durum geçişi; durum özeti | state; state transition; state brief |
| olay | event |
| gözlem | observation |
| niyet kaydı | intent record |
| işlem (database transaction) / işlem (operation, Ek B `Operation`) | transaction / operation |
| talep; katkı; tüketim kaydı, kullanım kaydı (`UseReceipt`) | request; contribution; use receipt |
| bulgu | finding |
| kanıt; ham kanıt; kanıt zarfı; kanıt katmanı | evidence; raw evidence; evidence envelope; evidence layer |
| bağımsızlık düzeyi | independence level |
| olumlu kontrol; olumsuz kontrol; bozma testi, bozma denemesi | positive control; negative control; break test, break attempt |
| ayar soruları; son değerlendirme soruları | tuning questions; final evaluation questions |
| arama ölçüsü | search benchmark |
| defter; kurulum defteri | ledger; installation ledger |

**Mechanisms and design**

| Turkish | English |
|---|---|
| kural kapısı; biçim kapısı; bilişsel kapı | rule gate; format gate; cognitive gate |
| kimlik zinciri | identity chain |
| ortam belirteci; üstlenme belirteci; üstlenme; yetki dönemi | environment token; claim token; claim; authority epoch |
| etki kanalı; etki kanalı envanteri; dış etki | effect channel; effect channel inventory; external effect |
| güven sınırları | trust boundaries |
| sızıntı kontrolü; parmak izi | leak check; fingerprint |
| açık depo; gizli depo | public repository; private repository |
| herkese açık anahtar; gizli (servis) anahtarı | public (publishable) key; secret (service) key |
| kütüphane; araştırma kütüphanesi | library; research library |
| içe alma | ingestion |
| kelime araması; anlam araması; ilişki sorgusu; birleşik arama | keyword search; semantic search; relation query; hybrid search |
| anlam modeli; anlam vektörü | embedding model; embedding vector |
| kaynak gövdesi | source body |
| bağlam; bağlam paketi | context; context package |
| "nerede bulurum" rehberi | "where do I find it" guide |
| öncül; öncül envanteri; sıfırdan seçim testi | premise; premise inventory; from-scratch test |
| çerçeve körlüğü; sıkışma sinyali; karşı tasarım | frame blindness; squeeze signal; counter-design |
| mekanizma varsayım envanteri | mechanism assumption inventory |
| çıkmaz yol | dead end |
| belirti; hata sınıfı; yetenek eksikliği; yetenek eksikliği adayı | symptom; failure class; capability gap; capability gap candidate |
| kusur | defect |
| ders; öğrenme | lesson; learning |
| emek; emek derinliği; emek politikası; uzman değerlendirmesi | effort; effort depth; effort policy; expert assessment |
| niteleyici | qualifier |
| ortak taban | common floor |
| ortak kurallar | common rules |
| düşünme disiplini; düşünme protokolü | thinking discipline; thinking protocol |
| uzmanlık paketi; bilgi haritası; mesleki süreklilik | expertise package; knowledge map; professional continuity |
| tek yazar ilkesi / kuralı | single-writer principle / rule |
| parçalı iş; yapılandırılmış devir; devir | chunked work; structured hand-over; hand-over |
| döngü sınırları; "ilerleme yok" tespiti | loop limits; "no progress" detection |
| kilitlenme | deadlock |
| sensiz akış (criterion 9) | flow without Batu |
| çalışma düzeni | working order |
| ortam | environment |
| oturum ömrü; kum havuzu | session lifetime; sandbox |
| kullanım; kullanım hakkı; kullanım sınırı | usage; usage allowance; usage limit |
| kesinti | interruption (of a session or work); outage (of a service) |
| yedek; geri yükleme; yeniden bağlama; kurtarma | backup; restore; reconnection; recovery |
| yayın; yayın işi | release; release job |
| birleştirme, birleşme | merge |
| dal; dal koruması | branch; branch protection |
| bileşik ürün; bütün ürün | composite product; whole product |
| süreç sınırı; amaç denetimi; varsayım envanteri | process limit; purpose audit; assumption inventory |
| bütünleşik sınama; gözetimsiz çalışma; sağlayıcı bağımsızlığı | integrated testing; unattended operation; provider independence |
| model erişim ara katmanı; ikinci model geçidi | model access layer; second-model gateway |
| hazırlık planı | preparation plan |
| gerekçe belgeleri; değerlendirme ve araştırma belgeleri | rationale documents; evaluation and research documents |
| yönetici (GitHub admin) | administrator |
