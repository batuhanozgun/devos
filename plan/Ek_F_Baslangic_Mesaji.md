# Ek F — Başlangıç mesajı / Opening message

**Sürüm:** 2.0 (D-010 ve PC-06, 5 Ekim 2026). Önceki sürüm (1.4) git geçmişinde.

**Batu için:**

1. Claude uygulamasından Claude Code'da yeni bir oturum aç. Ortam olarak `devos-kurulum`'u, depo olarak **yalnız** `devos`'u seç. `agentic-os-search`'ü ekleme: birden çok depolu oturumda koruma kancası yüklenmeyebilir. Kütüphane gerektiğinde oturum onu sonradan, salt okunur olarak ekler.
2. İzin modu: **Accept edits**. Model: **Opus 5.5**, ultracode açık.
3. Aşağıdaki çizginin altındaki metnin tamamını kopyalayıp ilk mesaj olarak yapıştır. Metin İngilizce, çünkü DevOS'un içindeki dil İngilizce; oturum seninle Türkçe konuşur.

Oturum açılışta model, mod ve koruma kancasını kontrol eder; bir eksik varsa ne değiştireceğini kısa bir mesajla söyler. Kurulumun tamamını bu tek oturum yürütür; aşama geçişlerinde senden bir şey beklemez. Yalnız şu üç yerde yazarsın: (1) bu ilk mesaj, bir kez; (2) sana ait kararların cevabı, bu oturuma (kararlar "Batu'dan beklenenler" issue'sunda da toplanır); (3) 5 saatlik ya da haftalık kullanım limiti dolarsa, sıfırlandıktan sonra bir "devam" mesajı. Durumu `devos` deposundaki `DURUM.md`'den görürsün.

---

/goal You are the working session (the executor) of the DevOS installation, in the devos repository. Your rules are CLAUDE.md and plan/Installation_Working_Order.md: read the working order first and run its opening check, then carry out the installation plan (plan/DevOS_Kurulum_Plani.md, stages C00 to C12) step by step in plan order, from where plan/ledger.md shows the work stands. A stage boundary is not a stop: when a stage is accepted, go straight on to the next. This goal is met only when stage C12 is accepted and your final message shows the proof: C12's acceptance record with acceptance accepted (plan/work/C12.md until the ledger moves to the database at the end of C02, its database record after that), the verdict it names, the full SHA of the merge commit that brought C12's results to main, and the unedited output of tools/stop_check.sh ending in STOP_CHECK PASS. Anything less is not met. Three states are temporary and count as not yet met, never as impossible: waiting for Batu's decision or action, a usage limit, and a blocker you cannot pass yet. The work goes on when Batu answers in this session, when the limit resets and Batu writes "devam", or when the blocker is resolved. Before you end a turn in one of these states, finish and merge all work that does not depend on it, then name the state with its evidence and paste the unedited output of tools/stop_check.sh. Talk to Batu in Turkish, briefly, one topic at a time, and bring him only his own decisions.
