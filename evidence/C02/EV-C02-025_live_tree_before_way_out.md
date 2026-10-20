---
id: EV-C02-025
title: "The live working tree's state before N-315's way out (2026-10-20, about 07:21Z)"
stage: C02
kind: observation
source: "the executor's read-only commands in /home/user/devos, session session_01JPgLGMqfEiAks5dTpBsCdB, the container's git and coreutils"
---

# EV-C02-025 · The live tree before N-315's way out

Filed by the executor (L-433; N-315's triage, round 2: the checker's MISSING_EVIDENCE 5 and the test designer's MISSING_EVIDENCE 3). Recorded so that no clearing of the live tree, planned or not (a new session, or a worker restart), loses what it held. Where it ran: the session's container, `/home/user/devos`, at about 2026-10-20T07:21Z.

- `git rev-parse HEAD`: `62d2be88889a8316afe0d0e6f03a1fc4b01ab005` (branch `claude/keen-curie-sia2bs`; `main` on GitHub is `253260cb3b04ccfa10df2f852f8947a49ac62e69`).
- `git status --porcelain --untracked-files=all --ignored`: ` M DURUM.md`, ` M plan/ledger.md`; nothing untracked, nothing ignored.
- `git stash list`: empty. `git log --oneline --branches --not --remotes`: empty (no local-only commit). `git worktree list`: `/home/user/devos  62d2be8 [claude/keen-curie-sia2bs]` only.
- `sha256sum`: `DURUM.md` `8502369b784836b952fafd33e8bdf91dfa589cfba0d559d2d978c1e607f30d41`; `plan/ledger.md` `aa1fa59efe3d2b6d9b6e09550fefa5e9dc5ded83b1f1eb33e8d1f21818728b15`; the `git diff -U0` output below `9c449c4d9a9c7cfebf9cf069063de01621b6d36c64db585ed49543e9cd9b8f10`. (`git hash-object` is not on the guard's git list, #297.)
- `git diff -U0`, verbatim: two stamp lines, nothing else.

```
diff --git a/DURUM.md b/DURUM.md
index 6b11c41..03d8c1b 100644
--- a/DURUM.md
+++ b/DURUM.md
@@ -5 +5 @@
-**Son güncelleme:** 20 Ekim 2026, 09:42 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.
+**Son güncelleme:** 20 Ekim 2026, 09:57 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.
diff --git a/plan/ledger.md b/plan/ledger.md
index f66d2c6..f284fe2 100644
--- a/plan/ledger.md
+++ b/plan/ledger.md
@@ -28 +28 @@
-| Rendered | Written by `tools/records.py render` from the clock; `DURUM.md`'s update line comes from here. | 2026-10-20T06:42Z |
+| Rendered | Written by `tools/records.py render` from the clock; `DURUM.md`'s update line comes from here. | 2026-10-20T06:57Z |
```
