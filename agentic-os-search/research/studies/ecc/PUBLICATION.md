# ECC — U00 Publication Receipt

**Date:** 2026-09-17. Bu kayıt yayın/erişim ve bounded self-review kanıtıdır; ECC runtime doğrulaması veya bağımsız yeni-oturum deneyi değildir. Current work authority STATE'tedir.

## Published sequence

| Step | Commit | Scope |
|---|---|---|
| ECC package | `07bdb0cb6f89d2d0c13e806cb5cc190a3c05d1de` | 10 yeni dosya altında `research/studies/ecc/` |
| Catalog discovery | `13444b7ee8612c7055173b077daccc9f257cd975` | CATALOG.md: yalnız 1 ECC satırı eklendi |
| Index discovery | `e328fc9fcd20c8c241b87970a8a272c180faf898` | studies INDEX.md: yalnız 1 route ve 1 package satırı eklendi |

Bu receipt yukarıdaki yayımlanmış checkpoint'i kaydeder. Kendi commit hash'ini kendi içine yazmaya çalışmaz; ardından STATE'in U00 yayın durumunu kapatan küçük güncelleme aynı package içinde yapılır.

## Actual concurrency event — preserved, not a pending merge

İlk input main `e3af9d9fc40391ebb31b2a8972fd5e1b7994d52f` idi. ECC için tree `1b1883f6747af571ea07cc2e2add1e3ac85d1c70` ve commit `057444e4ab72fc688247a8a408371f53498ba915` nesnesi oluşturuldu, fakat main güncellemesi non-fast-forward 422 ile reddedildi. Bu commit main'e yayımlanmadı.

Güncel main `4d40d238935a89f30f172f4c15fcd7c0cd573b12` olarak yeniden okundu. Exact compare yalnız `research/studies/superpowers/STATE.md` değişimini gösterdi. Yeni root tree üzerine yalnız ECC subtree `16002cd488ae2210702c57cc97f482f641aa1af6` bağlandı; commit `07bdb0c...` force olmadan main'e alındı. Ortak dosyalar güncel içerik ve blob SHA ile ayrı güncellendi.

Eski unreferenced commit nesnesi eksik yayın, açılmış branch veya kullanıcıdan beklenen merge işi değildir. Yeni branch yaratılmadı; history force edilmedi; Superpowers'ın eşzamanlı state güncellemesi korunmuştur.

## Checks actually performed

1. GitHub compare `4d40d238935a89f30f172f4c15fcd7c0cd573b12...e328fc9fcd20c8c241b87970a8a272c180faf898`: 3 commit; yalnız 10 ECC dosyası + CATALOG/INDEX değişti. Ortak dosyalarda sırasıyla 1 ve 2 ekleme, 0 silme. Foundation/control/diğer study değişikliği yok.
2. Main üzerinden ECC META, STATE, INDEX, PLAN, METHOD-REVIEW tam geri okundu. METHOD 1–59 ve 60–EOF aralıklarıyla tamamı geri okundu; iki parçada aynı blob `7a6537b4a3d953c05c3671895a718ab41fd973ff`.
3. Main CATALOG satırları 13–22 ve studies INDEX satırları 50–70 geri okundu: ECC→META→STATE/METHOD/PLAN yolu ve 'U01 not started' statüsü mevcut.
4. Bounded self-review: yöntem/plan v0.1; U00 planlama teslimatı; U01 sonraki mantıklı iş; kurulum/adoption/design yetkisi yok; prior screening tam araştırma sayılmıyor. Bu içerik tutarlılığı değerlendirmesi aynı assistant tarafından yapıldı.

Readback snapshot identities:

| File | Blob |
|---|---|
| META.md | `c38e2ee12fef5283e554a1f808e46c846138b17d` |
| INDEX.md | `f8ced6372fd7e1af89daa0b1ef3ea8bb09ebb1a1` |
| METHOD.md | `7a6537b4a3d953c05c3671895a718ab41fd973ff` |
| PLAN.md | `fbd40bcfe581531751e900f725e03eac92b8acbc` |
| METHOD-REVIEW.md | `c6edbf278ffd375d569d97bbdee2635ae78cbde8` |
| STATE.md before closure wording update | `1b91aadad6fb8214d914951c67c7c4bb14508ecc` |
| library CATALOG.md | `3e6ee9da22d2dcdb1aa30ae401fb53ab9a50084f` |
| library INDEX.md | `6a3b0bf65431ac83b51db0cafd2edb8ed2633323` |

## Method execution observation and limits

Non-force yayın kuralı bu olayda stale main'i bastırmayı engelledi; yeniden bağlama ve diff kontrolü eşzamanlı işi korudu. Bu gerçek bir operasyonel örnektir. Bütün concurrency durumlarının güvenli olduğunu veya araştırma yönteminin odağı/kaliteyi uzun vadede koruduğunu kanıtlamaz.

Bütün package dosyaları için otomatik link/semantic test suite çalıştırılmadı; named core entry readbacks ve Git diff kapsamı kontrol edildi. Gerçek cold-start ile başka bir model/oturumun doğru işi devraldığı henüz sınanmadı. ECC kurulmadı, ürün testleri veya live-host/model/effectiveness deneyleri çalıştırılmadı. U00 plan/yöntem kaydı tamamlanır; U01 kaynak haritası sonraki ayrı birimdir.

## U01-A — 2026-09-17 — Published source/local slice

The U00 receipt above is preserved historically. Current work authority remains STATE. U01-A adds real source research and a bounded local probe; broad U01 remains PARTIAL, U01-B is next, METHOD stays 0.1 and PLAN is 0.2.

| Publication | Actual commit | Scope |
|---|---|---|
| U01-A package | `3778884121b2aa48e8e0d6077d50a3c5f65e3761` | 16 ECC paths: 8 new evidence/map/note files, 8 updated entry/plan/log files |
| Catalog status | `6666d58a025cb9d1d5e01501460043886e31ec8c` | ECC row only |
| Library route | `c9c4714154b6d22109e32c955a8aa3d4454b6c5a` | ECC route only |

### Concurrency and exact scope

Initial staging used main `5272ee899d575c1be99c4467295d5cc00f34a2e0`. Before publication main was re-read at `2dc8dc326fb4ba8a2d7ba7cdf5bbae06a7922083`; compare showed new candidate entries and Superpowers state, no ECC mutation. Only the prepared ECC subtree was attached to that current tree. A non-force update of commit `e181e1608857d4437b08861d087f071ba461b3fb` was rejected with 422 because main advanced again.

The new main `b44c03032adb06ead2dee1f075e9016e42ddd72d` added two Superpowers evidence files. Its exact compare was checked; only ECC subtree `7d8f874eb6732febba184e920264a04367cacd37` was attached to current tree `2345f2df3100d75bcf3ba8c92bdddbce6860bec3`, producing the published package commit above. No force or separate branch was used. The rejected/unreferenced commit is not pending user upload or merge work.

Compare `b44c030...3778884` shows one commit and exactly 16 ECC paths; METHOD and WHY were preserved. METHOD-REVIEW, RESEARCH-LOG and SOURCE-LEDGER are additions-only, preserving the U00 records. Compare `b44c030...c9c4714` shows four commits, the 16 ECC paths, one-line replacements in CATALOG and library INDEX, plus a concurrently added Superpowers note. That extra note is not ECC work and was preserved rather than attributed to this study. No Foundation/control changes appear in either comparison.

### Readback and byte identity

Main readbacks performed: complete Note 01, STATE before final publication-wording closure, PLAN v0.2, raw RESULTS.json and PROBE-PLAN.json; current MR01 in METHOD-REVIEW; runner metadata/header; ECC catalog row and library route. The runner was not mechanically reread end-to-end from GitHub, but its returned blob identity matches the exact locally executed file. This is byte identity, not a new execution.

| Artifact | Verified Git blob |
|---|---|
| Note 01 | `972eef37fe698c576ffe9e2b84b49ade10c55f55` |
| PLAN v0.2 | `b5ff2101572bf9c2f3329fe8a473a9b217fa2584` |
| METHOD-REVIEW with MR01 | `ee620791d1981af4eacc9f95aea91918383d1a1d` |
| Probe plan, matches local bytes | `223222466e1d23b2665014b01019a9ae42a9033b` |
| Probe runner, matches executed local bytes | `589c9a31634df43fe96fc9f92c3e105b4ea4b163` |
| Raw results, matches local bytes | `de5989d3c0bcfba1d1614cb2749b961267d26249` |
| Catalog at readback | `0d828da61866bc0c5112d83348917c4eb737508a` |
| Library index at readback | `75b0c350d4f6327dbe27fd0f4e8845029799c758` |

### What these checks do not establish

E01 observed the unchanged checker against three synthetic caches, not a Codex session or real installed cache. The missing-hook challenge was a false-green; it is not three passing product tests. Upstream native-hook tests were read but not run. No full recursive inventory, registry tarball, hook-body/host execution, independent cold-start or method-effectiveness experiment was completed. No full automatic link/semantic suite was run. Source-bound notes, exact raw artifacts and explicit U01-B continuation are durable; future understanding and behavioural benefit remain separate claims.

This receipt records known published commits and completed checks; it does not self-reference its own future commit hash. A following STATE-only update closes the publication wording without advancing the study to U01-B.

## U01-B — 2026-09-17 — Published source channel/materialization study

Earlier receipts remain historical. U01-B is a bounded source result, P1 inventory stays PARTIAL, METHOD remains 0.1 and PLAN is 0.3. No new ECC execution occurred.

| Publication | Actual commit / action | Scope |
|---|---|---|
| Prepared ECC change | `d637cac34df94bbb0b3b43382614a37b1ba20a89` | 11 ECC-local paths: 3 new note/source/discovery files, 8 updated current/chronological files |
| Main integration | PR #3; merge `ca843d3e02de43b3d448e054138d229ad8f0a0d3` | GitHub returned merged=true; expected PR head was checked |
| Catalog status | `cdb1a13a7c24f39b8ee7e086da6031578673e93e` | One ECC row replaced |
| Library route | `8dcd51f0db04a69d33804032446150d9bdae847b` | One ECC route replaced |

### Actual publication adaptation

Staging began from `afe8710cd9f95264611de6c8be1bc93c3cef844c`. Main advanced through other studies. Exact compares showed no ECC edits, so only prepared ECC subtree `bf17b681f779fda0b1d1e5a8e0baba3fa5d25767` was reattached to current trees. Direct non-force updates of `6bb28ab6420200b1dcdb40e91a15d9a359e6cedd` and then `d637cac34df94bbb0b3b43382614a37b1ba20a89` were rejected with non-fast-forward 422 as main advanced again.

Rather than force stale state or continue an unbounded retry loop, branch `research/ecc-u01b-20260917` was created at the prepared commit. PR #3's actual changed filenames were checked: exactly the 11 ECC paths. It was then merged immediately using the expected head SHA. The branch is a merged publication artifact, not pending owner upload/approval. The unused first commit is not a missing result. This is a publication-workflow adaptation within the authorized repository scope, not upstream reporting or a new research phase.

Compare `dd3b19010c4ebdc2d12a3b7b33ce7826852808f6...d637cac34df94bbb0b3b43382614a37b1ba20a89` confirmed exactly 11 ECC paths. METHOD-REVIEW, RESEARCH-LOG and SOURCE-LEDGER had additions only, zero deletions; METHOD, WHY, U01-A note/evidence and original frontier were preserved. Compare merge `ca843d3...8dcd51f` showed one-line replacement each in CATALOG/INDEX and concurrent spec-kit/work-management changes. Those other changes were preserved and are not ECC work.

### Readbacks actually completed

From main: full Note 02, full U01-B source ledger, full STATE before this final publication-wording update, and full PLAN v0.3. Shared CATALOG lines18–23 and INDEX lines55–68 were read back and carry U01-B → U02-A plus the explicit partial/no-execution boundary. These are access/content checks and bounded same-assistant consistency review, not an independent fresh-session trial or a full automated link/semantic suite.

| Readback | Git blob |
|---|---|
| Note 02 | `786514f0fc6cd4287b1a1197eb32ac5c4081ffc8` |
| U01-B sources | `271b53c98fad2b25232c5aaf73571cba56f27745` |
| PLAN v0.3 | `4278fb3047c4ae95486375281270bd2c2e8a035e` |
| STATE before final publication wording | `ffada0905df3a2d063ef092ff8e8328fe98a2e9e` |
| Catalog | `47008f1bd8e83a3441780d8c8178d3ba20bf2e69` |
| Library index | `b09efbde4a0f1dc7ba01c6ed66b29e09d4e0344e` |

No ECC installer, test, host/model, new local probe, actual cache or registry tarball was run/read as runtime evidence in U01-B. The large recursive response was not a fully reviewed inventory. Source-level channel/materialization findings are published; ownership-helper closure and actual host consumption remain open. U02-A is the next bounded source question, not already completed work. The subsequent STATE wording update records this completed publication without adding scientific evidence.

## U02-A — 2026-09-17 — Published ownership/checkpoint/projection source study

Current study remains ACTIVE/PARTIAL; METHOD 0.1, PLAN 0.4; next U03-A is not started. This receipt records repository publication and bounded self-review, not new ECC execution.

| Published artifact | Actual commit |
|---|---|
| U02-A source ledger | `81cb96382401507855de5e31c71e5a7211c8fe07` |
| Note 03 | `8193ab44ac72911e223181ecc5444a655da497fb` |
| Package INDEX | `2195f262b21ebe0571a3819cb004c0d11dd62e3c` |
| META | `540375ffcc3e657a31a3898026eac0050e940531` |
| PLAN 0.4 | `2c82c41200adb7038b344101358f9788fa0af263` |
| QUESTIONS | `a7a0e904f73ed168c93ef635bd1cebf43582cbc7` |
| RESEARCH-LOG | `c2a62d72aeb1219534fccbb2f009e922659db830` |
| METHOD-REVIEW / MR03 | `4c0f63588152b352ef9aef3449c0ab1e70bb9253` |
| SOURCE-LEDGER | `1d0f85649750d900f27dd61447b3835e52c6ae47` |
| Shared ECC catalog row | `8f6516f59d5aa5d387de99f8a49e00a810b69771` |
| Shared ECC route | `6b482713275d1d4c2954bb4a0f9a1216bc7cd55c` |

All were direct contents-API writes on main. A stale CATALOG update at blob `88be5ac...` was rejected with 409; no stale content was applied. The current catalog was recovered in full at `5cd1303...`, including the other work-management studies' closure changes, before the successful ECC update. No force, new branch or new PR was used in U02-A. Prior PR #3 is already merged, not pending work.

### Checks completed before this receipt

- Main Note 03 was read through 1–70 and 71–EOF, same blob `06077976b0ba350adc0b07e35f6e4c3f3f680703`.
- Main U02-A source ledger was read in full, blob `9ddb1fa9606e3f1a72bcd1eb3efcbeea29ea7fcb`.
- PLAN 0.4 lines 1–65 were read back, blob `3196144f08bf3adb3204b88ed1915350032a5d73`: completed U02-A, exact U03-A next sources, P1 partial and Q03b/Q03c limits present. This is selected readback, not a claim that every updated file was fully reread.
- Compare `ab15db506a841720d75cb81c3dec536e55350251...6b482713275d1d4c2954bb4a0f9a1216bc7cd55c` showed the nine changed ECC core paths and concurrent other-study/library changes. ECC METHOD-REVIEW, RESEARCH-LOG and SOURCE-LEDGER had respectively 14/16/8 additions and zero deletions. METHOD, WHY and earlier evidence were not changed.
- Exact commit patches for the two shared updates were read. Library INDEX changed only its ECC route. CATALOG changed only the ECC row semantically, plus removal of its final newline; no other catalog entry was altered by the successful ECC commit. Concurrent ERPNext, Superpowers and work-management changes in the larger comparison are not ECC work.

The following STATE-only closure update records current work and publication; this receipt does not self-reference its own commit or claim a future readback already occurred. No owner upload/merge is required for the published artifacts.

### Scientific and operational limits

S48/S50 tests were inspected, NOT RUN. Q03b is an unexecuted source-derived interrupted-guided-retry counter-path, not an observed incident. No ECC installer/helper, host, model, database or new local probe was executed. P1 remains incomplete; full repair/uninstall, merged-JSON ownership and crash/concurrent-writer validation remain open. No automated full link/semantic suite or independent cold-start trial was performed. These publication checks preserve access and bounded consistency, not general methodology or runtime efficacy.

## U03-A — 2026-09-17 — Published Work/session source study and E02

Study remains ACTIVE/PARTIAL. METHOD 0.1, PLAN 0.5; next U03-B is selected, not started. This receipt records publication and bounded self-review. E02 is new local helper evidence; no live board/SQLite/provider/agent experiment is implied.

| Publication | Actual commit / action |
|---|---|
| Six new note/source/E02 files | `bdfe933425c6fd56cdb3aaf85774e0c39267df50` |
| Main integration | PR #4, merge `b111300ec519a8cf784f5fd3fe04646e6b353b5a` |
| PLAN 0.5 | `e17551ee15bd763e0bcb0ebb5dcf761493effe59` |
| QUESTIONS | `8473704d2891d25327918a09a097d3a378bce17e` |
| META | `cd0720b92d9fc3b01a0a0093dbaf85ac8464234e` |
| Package INDEX | `828cbce0a55d7ccb963e66d44fc4c370ed14da88` |
| RESEARCH-LOG | `d6d00a63f67976b8de667890b8803237e7815670` |
| MR04 | `eb5c1c89e636eeef0d1d9a13e6b6fe442c629384` |
| SOURCE-LEDGER | `e749405d1eb6c82fbbf3f342a9316e9aed141774` |
| ECC catalog row | `b4e6a8058d235e91cba6c8b629bebe1d21b48d31` |
| ECC library route | `6a8ef6075f45d4e748d8a74b89f533a9721404d2` |

### Concurrency and scope checks

Initial input/staging parent was `2e6455b0967235ae59bc0d36182fbc8b7762c5e6`. Non-force update of the six-file commit was rejected with 422. Fresh main was `dbb5271d8109c2f7fb95c6cb1872b884329b8f64`; exact compare showed concurrent Superpowers/catalog edits, no ECC edits. Branch `research/ecc-u03a-20260917` preserved the prepared commit. PR #4's changed-file list was inspected: exactly the six new ECC files, no deletions. GitHub merged it with the expected head SHA. This is own-repository publication, not upstream reporting or an independent reviewer verdict; no owner merge is pending.

Compare `b111300...6a8ef607` showed nine commits and nine changed paths: seven ECC current/chronological files plus one-line replacements in shared CATALOG/INDEX. METHOD-REVIEW and RESEARCH-LOG each had 16 additions/zero deletions; SOURCE-LEDGER had 8 additions/zero deletions. Earlier findings/raw E01, METHOD, WHY, Foundation/control and other studies were not changed by this continuation batch. The concurrent work before merge is not attributed to ECC.

### Readbacks and exact bytes actually checked

Main Note 04 was read in contiguous ranges 1–85 and 86–EOF, blob `64c49aa5f2319c7506fc5cbcf5f9497242f1cd9d`. Main U03-A source ledger was fully read, blob `f6835186e966632bed5326f65167e394bbb72e14`. Main raw E02 RESULTS was fully read and matches local blob `48b4a5e6f3bd4b399731937947ab51c25e4937da`. Main PLAN 0.5 was read through EOF, blob `0525aa107f5cbbfa800c2abc1d13861821b44dc8`.

Before merge, the prepared probe-directory metadata was checked against local Git blobs: plan `f85e0407f0fa558bc2f6f1f1854e02412b8e7bfb`, runner `70b085de4e53ca56952cd223d6ee55125c233165`, results `48b4a5e6f3bd4b399731937947ab51c25e4937da`. All matched. The expected-head merge preserved that source commit. This byte check is not another test run. Local plan SHA-256 was separately rechecked after execution against the pre-execution file; the original plan/command/results remain in the E02 dossier.

The following STATE-only update closes current work/publication and is then read back. This receipt does not claim that future read already happened or embed its own future commit hash. Not every updated file received a full post-write reread; the checks above and the exact diff scope are the actual performed checks.

### Scientific limits and next boundary

E02 runs only unchanged S59 with an in-memory store double. Six criteria matches include a real refusal, not six product-safety passes. S67's tests were inspected, NOT RUN. GitHub sync closure, import overwrite and default snapshot/SQLite integration findings remain source-bound; there was no remote sync or real database/host run. SQL/FK, authentication, concurrent claims, live dispatch/resume and efficacy are not tested. P1 and Q03b/c/Q04b/c remain open; U03-B will inspect actual runtime control. No automated full link/semantic suite or independent cold-start/method comparison was performed.
