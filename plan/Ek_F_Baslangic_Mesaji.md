# Appendix F — Opening message

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*

**Version:** 2.0 (D-010 and PC-06, 5 October 2026). The previous version (1.4) is in the git history.

**For Batu:**

1. From the Claude app, open a new session in Claude Code. Choose `devos-kurulum` as the environment and **only** `devos` as the repository. Do not add `agentic-os-search`: in a session with more than one repository the guard hook may not be loaded. In Accept edits mode the platform does not let the session add the library (`agentic-os-search`); it is added only as your decision D-014 (a) sets out: first you turn on push e-mail notifications on the library, then you switch the session to Auto mode for a short while, in which it only adds the library, read-only, and you switch it back to Accept edits mode. On 6 October 2026 the library was attached read-only in such a short Auto window; that the e-mails are on rests on your word. A new session, or a library lost from the session, needs the short Auto step again.
2. Permission mode: **Accept edits**. Model: **Opus 5.5**, ultracode on.
3. Copy the whole text under the line below and paste it as the first message. The text is in English because the language inside DevOS is English; the session speaks Turkish with you.

At the opening, the session checks the model, the mode and the guard hook; if something is missing, it tells you in a short message what to change. This single session runs the whole installation; it expects nothing from you at stage transitions. You write in only these three places: (1) this first message, once; (2) the answers to the decisions that belong to you, to this session (the decisions are also gathered in the "Batu'dan beklenenler" ("What is expected from Batu") issue); (3) if the 5-hour or the weekly usage limit runs out, a "devam" ("continue") message after it resets. You see the state in `DURUM.md` in the `devos` repository.

**Text shown to Batu (Turkish, verbatim):**

**Batu için:**

1. Claude uygulamasından Claude Code'da yeni bir oturum aç. Ortam olarak `devos-kurulum`'u, depo olarak **yalnız** `devos`'u seç. `agentic-os-search`'ü ekleme: birden çok depolu oturumda koruma kancası yüklenmeyebilir. Accept edits modunda platform, oturumun kütüphaneyi (`agentic-os-search`) eklemesine izin vermez; kütüphane yalnız D-014 kararındaki (a) seçeneğine göre eklenir: önce kütüphanede push e-postalarını açarsın, sonra oturumu kısa bir süre Auto moduna alırsın; oturum bu sürede yalnız kütüphaneyi salt okunur olarak ekler ve sen oturumu yeniden Accept edits moduna alırsın. 6 Ekim 2026'da kütüphane böyle kısa bir Auto süresinde salt okunur olarak eklendi; e-postaların açık olduğu senin sözüne dayanır. Yeni bir oturumda ya da kütüphane oturumdan kaybolursa kısa Auto adımı yeniden gerekir.
2. İzin modu: **Accept edits**. Model: **Opus 5.5**, ultracode açık.
3. Aşağıdaki çizginin altındaki metnin tamamını kopyalayıp ilk mesaj olarak yapıştır. Metin İngilizce, çünkü DevOS'un içindeki dil İngilizce; oturum seninle Türkçe konuşur.

Oturum açılışta model, mod ve koruma kancasını kontrol eder; bir eksik varsa ne değiştireceğini kısa bir mesajla söyler. Kurulumun tamamını bu tek oturum yürütür; aşama geçişlerinde senden bir şey beklemez. Yalnız şu üç yerde yazarsın: (1) bu ilk mesaj, bir kez; (2) sana ait kararların cevabı, bu oturuma (kararlar "Batu'dan beklenenler" issue'sunda da toplanır); (3) 5 saatlik ya da haftalık kullanım limiti dolarsa, sıfırlandıktan sonra bir "devam" mesajı. Durumu `devos` deposundaki `DURUM.md`'den görürsün.

---

/goal You are the working session (the executor) of the DevOS installation, in the devos repository. Your rules are CLAUDE.md and plan/Installation_Working_Order.md: read the working order first and run its opening check, then carry out the installation plan (plan/DevOS_Kurulum_Plani.md, stages C00 to C12) step by step in plan order, from where plan/ledger.md shows the work stands. A stage boundary is not a stop: when a stage is accepted, go straight on to the next. This goal is met only when stage C12 is accepted and your final message shows the proof: C12's acceptance record with acceptance accepted (plan/work/C12.md until the ledger moves to the database at the end of C02, its database record after that), the verdict it names, the full SHA of the merge commit that brought C12's results to main, and the unedited output of tools/stop_check.sh ending in STOP_CHECK PASS. Anything less is not met. Three states are temporary and count as not yet met, never as impossible: waiting for Batu's decision or action, a usage limit, and a blocker you cannot pass yet. The work goes on when Batu answers in this session, when the limit resets and Batu writes "devam", or when the blocker is resolved. Before you end a turn in one of these states, finish and merge all work that does not depend on it, then name the state with its evidence and paste the unedited output of tools/stop_check.sh. Talk to Batu in Turkish, briefly, one topic at a time, and bring him only his own decisions.
