# A5 — son karşılaştırma ve teslim

**1 Ekim 2026 / REPO-SEPARATION-20260929. FINAL DELIVERY — 1 Ekim kapanış düzeltmeleriyle güncellendi.**

Önceki A5 karşılaştırma sayıları kendi snapshot kapsamıyla aşağıda korunur; güncel kapanış ve toplamlar §10’dadır.

Bu kayıt, görev belgesindeki §7 teslimini ve `8cd01e4afdcd0d37960b05930c91e1244678be6e` başlangıcından A4 kapanış commit'i `7dba57d439a783039fe53b53039fd82eed3c6c36` üzerine yapılan A5 kapanış düzeltmelerine kadar son karşılaştırmayı taşır.

## 1. Son karşılaştırma

A5 başlamadan önce GitHub compare sonucu:

- base: `8cd01e4afdcd0d37960b05930c91e1244678be6e`
- A4 kapanış head: `7dba57d439a783039fe53b53039fd82eed3c6c36`
- ahead: **37 commit**
- changed paths: **141**
- added: **58**
- modified: **83**
- deleted: **0**
- renamed/moved: **0**
- toplam deletions: **12 satır**, tamamı kök `README.md` içindeki eski yönlendirme metninin yerini yeni araştırma/kurulum ayrımının almasıdır.

Bu final teslim kaydı eklendiğinde değişen/eklenen toplam yol sayısı **142** olur. A5 kapanışında ayrıca kök README, arşiv README ve REPOSITORY-TRANSITION içindeki stale bakım yönleri güncellenir; bunlar zaten yukarıdaki compare kümesinde mevcut yollardır.

`AGENT.md` veya `agent/**` compare kümesinde değildir; control katmanı değiştirilmedi. `MOVES.md` ve compare sonucu birlikte gerçek dosya taşıması olmadığını gösterir.

## 2. Araştırma / kurulum ayrımı nasıl yapıldı?

Toplu yeniden yapılandırma yerine **yerinde statü ve routing ayrımı** kullanıldı:

- bağımsız araştırma alanları yerinde ve kendi current research state'leriyle korundu;
- eski DevOS/Codex/P5 çalışma kayıtları silinmedi veya içerik olarak yeniden yazılmadı;
- yüksek-riskli eski girişlerin başına tarihsel/statü notları eklendi;
- kök ve alan router'ları bugünkü DevOS kurulumunun bu depoda olmadığını açıkça ayırdı;
- geçerli kurulum planının tek evi dışarıdaki `devos/plan/` olarak gösterildi;
- eski rapor/paketler ayrı tarihsel arşiv alanında, kaynak kimlikleri ve epistemik sınırlarla tutuldu;
- dosya taşıması yapılmadığı için `MOVES.md` boş taşıma tablosunu ve no-move kararını taşır.

## 3. Bölüm 3 dışında yapılan ek değişiklikler ve gerekçeleri

Görev §3'teki açık maddelere ek olarak:

1. **Repository-wide A4 envanter ve risk taraması** yapıldı — kullanıcının §5 “depoyu baştan sona tara” talebini karşılamak ve yalnız önceden adı verilen dosyalara güvenmemek için.
2. **299 entry/state yüzeyi** ilk 100 satır + kalan gövde olarak tarandı — eski yönün doğrudan girişlerde saklı kalma riskini azaltmak için.
3. **1.799 göreli Markdown linki** disposition edildi — kırık linkleri ve staging-relative linkleri ayırmak için.
4. **Hermes prepared-delivery içindeki 7 staging-relative link** değiştirilmedi — `PREPARED_NOT_PUBLISHED` payload semantiğini ve kayıtlı hash kimliklerini bozmamak için.
5. **A3 kaynak kimlik/erişim ayrımı** kuruldu — P5 S paketini K paketiyle, “SOUL ve DevOS” raporunu başka SOUL metinleriyle sessizce ikame etmemek için.
6. **A5 new-reader walkthrough** sırasında kök README ve arşiv README’de kalan stale “tarama açık / sıradaki iş A4” yönleri kapatıldı.

## 4. Arşiv ve açık sınırlar

Yedi tarihsel kaynak ailesinin durumu:

- P4 v3 — arşivde
- P4 v4 — arşivde
- P5 K00–K15 — arşivde
- P5 v2 Codex arayüzü — arşivde
- SOUL Academy — arşivde
- **P5 S00–S12 — erişim engeli; özgün paket bulunamadı**
- **SOUL ve DevOS — kullanıcının sağladığı özgün rapor arşivde; boyut/SHA-256/Git blob §10’da**

Dolayısıyla güncel A3 **6/7 ve kısmi** kalır. Yalnız P5 S00–S12 kalıcı açık erişim sınırıdır; K00–K15 onun yerine geçmez. Eksik içerik üretilmedi ve “hiçbir yerde yok” iddiası kurulmadı.

## 5. Yön/statü ve link teyidi

A4 kapanışında:

- eski-yön göstergeleri için repository-wide sorgular ve entry/state doğrudan okumaları yapıldı;
- 299/299 entry/state yüzeyinin giriş penceresi ve kalan gövdesi tarandı;
- genişletilmiş link kontrolünde 1.799 göreli Markdown linkinin 1.792'si snapshot yoluna doğrudan çözüldü;
- kalan 7 link Hermes prepared-delivery staging payload'ında hedef-konum relative link olarak gerekçeli korundu;
- **actionable kırık link bulunmadı**;
- eski Codex/P5/DEVOS yönünü bugünkü kurulum yetkisi gibi taşıyan yeni actionable entry/state kaydı bulunmadı.

Bu hüküm bütün 928 study yaprağının semantik olarak yeniden doğrulandığı anlamına gelmez. Package-local `current/next` dili kendi araştırma statüsü olarak korunmuştur.

## 6. Commit bağlantıları

Karşılaştırma zincirindeki ana kilometre taşları:

- Başlangıç: [`8cd01e4a`](https://github.com/batuhanozgun/agentic-os-search/commit/8cd01e4afdcd0d37960b05930c91e1244678be6e)
- A1 başlangıç/kök ayrımı: [`ab8ef329`](https://github.com/batuhanozgun/agentic-os-search/commit/ab8ef329aa4841fae2b836c91e74e68ad1c4c9e5)
- A2 ana yön ve D030: [`8612f132`](https://github.com/batuhanozgun/agentic-os-search/commit/8612f1320dbfeeef089964d4c48025051f1bb0e6)
- A2 doğrudan girişler: [`f690aa6b`](https://github.com/batuhanozgun/agentic-os-search/commit/f690aa6bf5398d90bef2b7ee0b1b74ff52ba96c7)
- A2 current girişleri: [`cd35ef63`](https://github.com/batuhanozgun/agentic-os-search/commit/cd35ef63d9a80dd6ff224726d2b083fa386a3c59)
- A2 current/review kapanışı: [`bc015e2f`](https://github.com/batuhanozgun/agentic-os-search/commit/bc015e2f97beb9c281bd54a071916324459bc502)
- A3 arşiv ZIP yüklemesi: [`93216f73`](https://github.com/batuhanozgun/agentic-os-search/commit/93216f73ea565ed3ba22e4ba0e18e2144e1368c4)
- A4 geniş entry taraması snapshot: [`8f9984f8`](https://github.com/batuhanozgun/agentic-os-search/commit/8f9984f895398ca5cf7c7efa46dc53f2fe1dc1ed)
- A4 link taraması kapanışı: [`d10be854`](https://github.com/batuhanozgun/agentic-os-search/commit/d10be854b4d5bc59ac525b2b06e25c5dba364fae)
- A4 gövde taraması kapanışı: [`7dba57d4`](https://github.com/batuhanozgun/agentic-os-search/commit/7dba57d439a783039fe53b53039fd82eed3c6c36)

Bu dosyayı ve A5 kapanış router güncellemelerini taşıyan final commit, bu kaydın yayımlandığı commit'tir; kullanıcıya final yanıtta doğrudan bağlantı verilir.

## 7. Değiştirilen ve eklenen dosyaların tam listesi

**Taşınan:** yok.  
**Silinen:** yok.

### Eklenen — 59

- `MOVES.md`
- `REPOSITORY-TRANSITION.md`
- `archives/devos-pre-claude-2026-09-29/A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip`
- `archives/devos-pre-claude-2026-09-29/README.md`
- `archives/devos-pre-claude-2026-09-29/SOURCE-IDENTITIES.json`
- `archives/devos-pre-claude-2026-09-29/academy/SOUL_ACADEMY_EXPLORATORY_CONCEPT_NOTE.md`
- `maintenance/2026-09-29-research-installation-separation/A2-BRIEFS.md`
- `maintenance/2026-09-29-research-installation-separation/A2-CLOSE.md`
- `maintenance/2026-09-29-research-installation-separation/A2-CORE.md`
- `maintenance/2026-09-29-research-installation-separation/A2-CURRENT-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A2-DIRECT-ENTRIES.md`
- `maintenance/2026-09-29-research-installation-separation/A2-P1-P3.md`
- `maintenance/2026-09-29-research-installation-separation/A2-READING.md`
- `maintenance/2026-09-29-research-installation-separation/A2-REVIEWS-CLOSE.md`
- `maintenance/2026-09-29-research-installation-separation/A2-REVIEWS.md`
- `maintenance/2026-09-29-research-installation-separation/A3-ACCESS-GAPS.md`
- `maintenance/2026-09-29-research-installation-separation/A3-INTAKE.md`
- `maintenance/2026-09-29-research-installation-separation/A4-DIRECTIONAL-SCAN-01.md`
- `maintenance/2026-09-29-research-installation-separation/A4-DIRECTIONAL-SCAN-02.md`
- `maintenance/2026-09-29-research-installation-separation/A4-ENTRY-BODY-SCAN-04.md`
- `maintenance/2026-09-29-research-installation-separation/A4-ENTRY-LINK-SCAN-02.md`
- `maintenance/2026-09-29-research-installation-separation/A4-ENTRY-LINK-SCAN-03.md`
- `maintenance/2026-09-29-research-installation-separation/A4-ENTRY-SURFACE-SCAN-03.md`
- `maintenance/2026-09-29-research-installation-separation/A4-ENVIRONMENT-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-ENVIRONMENT-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-EXP001-005-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-EXPLORATIONS-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-HISTORY-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-HISTORY-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-REMAINDER-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-REMAINDER-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-INITIAL-SCAN.md`
- `maintenance/2026-09-29-research-installation-separation/A4-INTEGRATION-FRONTIER-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-INTEGRATION-FRONTIER-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-INVENTORY-EXPANSION.md`
- `maintenance/2026-09-29-research-installation-separation/A4-LINK-ARCHIVE-CHECK-01.md`
- `maintenance/2026-09-29-research-installation-separation/A4-PATH-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-RELATION-CONTROL-COMPOSITION-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-RELATION-CONTROL-COMPOSITION-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-RESEARCH-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-RESEARCH-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-SCOPED-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-SELECTION-DYNAMICS-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-SELECTION-DYNAMICS-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-STUDIES-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-STUDIES-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-SUFFICIENCY-REUSE-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-SUFFICIENCY-REUSE-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A4-TOP-LEVEL-ADEQUACY-INVENTORY.json`
- `maintenance/2026-09-29-research-installation-separation/A4-TOP-LEVEL-ADEQUACY-INVENTORY.md`
- `maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md`
- `maintenance/2026-09-29-research-installation-separation/BASELINE.json`
- `maintenance/2026-09-29-research-installation-separation/REQUEST.md`
- `maintenance/2026-09-29-research-installation-separation/baseline/README.md`
- `research/soul-context/current/README.md`

### Değiştirilen — 83

- `concepts/INDEX.md`
- `development-os/attempts/001/BRIEF.md`
- `development-os/attempts/001/EXCHANGE.md`
- `development-os/attempts/001/messages/research/R-001.md`
- `development-os/attempts/001/messages/research/R-002.md`
- `development-os/attempts/001/messages/research/R-003.md`
- `development-os/attempts/001/messages/research/R-004.md`
- `development-os/attempts/001/messages/research/R-005.md`
- `development-os/attempts/001/messages/research/R-006.md`
- `development-os/attempts/001/METHOD.md`
- `development-os/attempts/001/reading/COVERAGE.md`
- `development-os/attempts/001/reading/F00-CONTEXT-AND-USE.md`
- `development-os/attempts/001/reading/F08-FOUNDATION-FRAME.md`
- `development-os/attempts/001/reading/F08-RECONCILIATION.md`
- `development-os/attempts/001/REVIEW.md`
- `development-os/attempts/001/WORK.md`
- `development-os/attempts/002/README.md`
- `development-os/INDEX.md`
- `explorations/CATALOG.md`
- `explorations/EXP-006-development-os-calisma-duzeni/ACTORS.md`
- `explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md`
- `explorations/EXP-006-development-os-calisma-duzeni/HANDOFF.md`
- `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-split-WORK-MAP.md`
- `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-work-system-INDEX.md`
- `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-work-system-STATE.md`
- `explorations/EXP-006-development-os-calisma-duzeni/history/README.md`
- `explorations/EXP-006-development-os-calisma-duzeni/INDEX.md`
- `explorations/EXP-006-development-os-calisma-duzeni/STATE.md`
- `explorations/EXP-006-development-os-calisma-duzeni/WORK.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P1-01-claude-cloud-environment-map.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P2-01-named-role-contracts.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P3-01-work-information-discussion.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P4-01-cloud-runtime-and-workspace-design.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P4-02-soul-derived-report-v2.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P4-03-unbounded-stress-test-handoff.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P4-04-unbounded-stress-test-report-v3.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P4-05-codex-environment-revision-v4.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/P5-01-codex-build-installation-package.md`
- `explorations/EXP-006-development-os-calisma-duzeni/work/p5/CODEX_START.md`
- `explorations/INDEX.md`
- `README.md`
- `research/INDEX.md`
- `research/soul-context/current/briefs/CODEX-COORD-01-NATIVE-HANDOFF.md`
- `research/soul-context/current/briefs/CODEX-COORD-02-PERSIST-ENTRY.md`
- `research/soul-context/current/briefs/CODEX-COORD-03-PUBLISH-ENTRY.md`
- `research/soul-context/current/briefs/CODEX-COORDINATION-HANDOFF.md`
- `research/soul-context/current/briefs/CODEX-DESIGN-01-FIRST-SOUL-SCENARIO.md`
- `research/soul-context/current/briefs/CODEX-DEVOS-AGENT-CONTROL.md`
- `research/soul-context/current/briefs/CODEX-DEVOS-CONSTRUCTION-PLAN.md`
- `research/soul-context/current/briefs/CODEX-G0-D1-BOUNDARY-DIAGNOSIS.md`
- `research/soul-context/current/briefs/CODEX-G1-PURPOSE-PILOT.md`
- `research/soul-context/current/briefs/CODEX-G1-R1-LAUNCHER-CONTINUATION.md`
- `research/soul-context/current/briefs/CODEX-STAGE-1-BOOTSTRAP-DESIGN.md`
- `research/soul-context/current/briefs/CODEX-STAGE-1A-STARTER-CONTRACT.md`
- `research/soul-context/current/briefs/CODEX-STAGE-2-G0-EXPERIMENT.md`
- `research/soul-context/current/claude-code-devos-preparation/CLAUDE-TASK-01.md`
- `research/soul-context/current/claude-code-devos-preparation/OWNER-CONTEXT.md`
- `research/soul-context/current/claude-code-devos-preparation/SOURCE-REGISTER.md`
- `research/soul-context/current/claude-code-devos-preparation/WORK.md`
- `research/soul-context/current/COORDINATION-TRANSFER-PLAN.md`
- `research/soul-context/current/DEVELOPMENT-OS-BOOTSTRAP.md`
- `research/soul-context/current/reviews/2026-09-06-direction/OPENING-VISION-SOURCE.md`
- `research/soul-context/current/reviews/2026-09-06-direction/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-06-g0/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-06-stage-1/CODEX-RESPONSE.md`
- `research/soul-context/current/reviews/2026-09-06-stage-1/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-06-stage-1a/CODEX-RESPONSE.md`
- `research/soul-context/current/reviews/2026-09-06-stage-1a/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-collaboration/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-coord-01/CODEX-RESPONSE.md`
- `research/soul-context/current/reviews/2026-09-07-coord-01/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-coord-02/FRESH-SESSION-REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-coord-02/IDENTITY-RESOLUTION.md`
- `research/soul-context/current/reviews/2026-09-07-coord-02/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-coord-03/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-d1/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-g1/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-07-method/REVIEW.md`
- `research/soul-context/current/reviews/2026-09-08-devos02-plan/REVIEW.md`
- `research/soul-context/INDEX.md`
- `research/soul-context/README.md`
- `research/soul-context/repos/soul/README.md`
- `research/soul-context/STATE.md`

## 8. Kullanıcı kararı gerektiren / emin olunamayan noktalar

Mevcut bakım kapsamında kullanıcı kararı gerektiren yeni bir yön sorusu kalmadı.

Açık kalan tek unsur **P5 S00–S12 kaynak erişim engelidir**. Yeni özgün kaynak veya somut erişim kanıtı gelirse A3 yalnız bu kalem için yeniden açılır; A4/A5 veya eski DevOS kurulumu otomatik yeniden açılmaz.

## 9. Son durum

Araştırma ile tarihsel DevOS kurulum çalışmasının repository içi ayrımı tamamlandı. DevOS kurucusunun bu depodan eski Codex/P5/DEVOS-001/002 yönünü canlı kurulum görevi olarak devralmaması için current router/state yüzeyleri ve yüksek-riskli girişler statülendirildi.

Bakım çalışması **tamamlandı; bilinen tek kalıcı sınır P5 S00–S12 nedeniyle A3’ün 6/7 arşiv kapsamıdır.**

## 10. 1 Ekim — beş maddelik kapanış düzeltmesi

**Yetki ve kaynak:** Batu’nun [Devam Noktasını Doğrulama](chatgpt-conversation://6abe56e3-eb84-83eb-9d4b-bcb211813b70) konuşmasındaki beş maddelik kapanış talebi, bu devam konuşmasında aynen aktarılan talep ve 1 Ekim’de sağlanan dosya. Başlangıç main `59b8b8edda8e993cbc0a01980dea998d4e94ac73`.

1. **SOUL ve DevOS:** Kullanıcı dosyanın istenen rapor olduğunu açıkça teyit etti. `archives/devos-pre-claude-2026-09-29/soul-and-devos/SOUL_ve_DevOS.md` özgün baytlarla arşivlendi. Boyut **147006 byte**; SHA-256 **`0f8221445a59eccf1a52efa3d2fe3c7fac642d1370aff99acdc1894fbcfdc3c2`**; Git blob **`bcf79ccfcc21e1b8c294bd60cc17b065ce19e15a`**. Kimlik envanteri şema 3’tür; dosya bağımsız repository yoludur, mevcut ZIP’e eklenmiş değildir. Kaynak iddiaları ve mimari yeterliği yeniden doğrulanmadı.
2. **P5 S00–S12:** Tek kalıcı açık kaynak erişim sınırı. Beklenen kimlikler korunur; K00–K15 yerine geçmez. Yeni özgün kaynak/somut erişim kanıtı olmadan arama tekrarlanmaz.
3. **Foundation:** `research/soul-foundations/STATE.md` ve `research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md` başına 1 Ekim tarihli kısa D030 notu eklendi. İki özgün gövde ve dosya sonları byte düzeyinde korundu; araştırma statüsü yeniden yazılmadı.
4. **Baseline README:** Tarihsel snapshot gövdesi korundu; başına 13 göreli linkin `8cd01e4afdcd0d37960b05930c91e1244678be6e` köküne göre olduğunu ve kopyanın konumundan canlı link olmadığını açıklayan not eklendi. §5’teki önceki link taraması snapshot kopyasının bu 13 linkini kapsamlı doğrulamış sayılmaz.
5. **Tam tarama kaynağı:** Kullanıcı, Claude’un `8cd01e4`..`59b8b8ed` aralığını salt okuma ile denetlediğini ve bütün depoda `Codex / current / next / güncel / sıradaki` otomatik taraması yapıldığını bildirdi. Kullanıcının aktardığı sonuç: eski yönü güncel gösteren ifadeler tarihli notların altında veya araştırma içeriğindedir; yukarıdaki iki Foundation yönlendirmesi dışında yön sorunu bulunmamıştır. Bu, **kullanıcı tarafından aktarılan dış denetim sonucudur**; ham tarama çıktısı bu tur görülmedi ve bağımsız yeniden tarama olarak sunulmaz. 928 studies yaprağı yeniden okunmadı. Bildirilen Foundation sorunları bu tur kapatıldı.

### Bu kapanışın tam değişiklik listesi

**Eklenen — 1:**

- `archives/devos-pre-claude-2026-09-29/soul-and-devos/SOUL_ve_DevOS.md`

**Değiştirilen — 9:**

- `README.md` — güncel açık sınırı 6/7 ve yalnız S00–S12 olarak düzeltme.
- `REPOSITORY-TRANSITION.md` — arşiv tablosu, durum ve kapanış/devam uyumu.
- `archives/devos-pre-claude-2026-09-29/README.md` — arşiv erişimi, rapor kimlik tablosu, tek açık sınır.
- `archives/devos-pre-claude-2026-09-29/SOURCE-IDENTITIES.json` — özgün rapor kimliği ve ayrı dosya/ZIP ayrımı.
- `maintenance/2026-09-29-research-installation-separation/A3-ACCESS-GAPS.md` — eski gövde korunarak başta güncel engel durumu.
- `maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md` — bu teslim ve kaynak/denetim sınırları.
- `maintenance/2026-09-29-research-installation-separation/baseline/README.md` — yalnız snapshot bağlantı bağlamı notu.
- `research/soul-foundations/STATE.md` — yalnız D030 başlangıç notu.
- `research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md` — yalnız D030 başlangıç notu.

Kök README ve A3-ACCESS-GAPS ek güncellemeleri stale iki-engel durumunu yeni okuyucuya aktarmamak içindir. Diğer tarihli A2/A3/A4 kayıtları kendi snapshot kapsamıyla korunur.

**Güncel başlangıç karşılaştırması:** `8cd01e4` → bu kapanışı yayımlayan commit: **39 commit, 145 yol; 60 added, 85 modified; 0 deleted, 0 renamed/moved.** Önceki §7’nin 59/83 listesi `59b8b8ed` teslimine aittir. Yeni arşiv dosyası added sayısına, iki Foundation yolu modified sayısına eklenir; bu turdaki diğer yollar önceki karşılaştırmada zaten bulunuyordu.

**Doğrulama:** Ekli kaynak/arşiv byte eşliği, SHA-256 ve Git blob eşliği; üç snapshot/Foundation dosyası ile A3 erişim kaydında önek dışındaki eski byte’ların korunması; yeni göreli hedefler ve D030 anchor; kontrol katmanı, studies, eski ZIP/Academy ve MOVES değişmezliği; silme/taşıma yokluğu. Yayın öncesi main delta/yazar ve yayın sonrası uzak main ile on dosyanın blob kimliği kontrol edilir. Bu kaydı taşıyan commit kapanış commit’idir; kendi SHA’sı dosya içine öz-referans olarak yazılmaz, kullanıcıya doğrudan verilir.

**Sonuç:** Beş kapanış düzeltmesi uygulandı; aktif bakım işi yok. Arşiv 6/7; tek kalıcı açık sınır P5 S00–S12.
