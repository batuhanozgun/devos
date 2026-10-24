# ECC — Bağlamlı kullanım kayıtları

2026-09-23 · **C1–C5 SOURCE-FAMILY TRANSFER COMPLETE / C6 VERSION-QUALIFIED COMPLETE / ECC PACKAGE COMPLETE @ source tree e33ea2998ecd3c0e05a3f2c3dcf095b697b81544.**

Bu dosya Concepts kullanım girişidir. [READING](READING.md) actual dosya/sürüm/okuma ve C6b kapanış hesabını, [global STATE](../../STATE.md) program yetkisini taşır. [C6-RECONCILIATION](C6-RECONCILIATION.md) ve [167 yapraklı manifest](C6-SOURCE-MANIFEST.tsv) C6a tarihsel snapshot'ıdır; E01–E03 okuma durumunun yeni karşılığı current READING'dedir. Kaynak ECC araştırması ayrıdır: bu turun 7ce22d4 snapshot'ında U18-F IN PROGRESS, son completed U18-E. Bu kaynak next'i Concepts yetkisine dönüştürülmez.

## 1. Bağlı kullanım dosyaları

| Kaynak ailesi | Bağlamlı kullanım kaydı | Aktarım durumu |
|---|---|---|
| U01–U02 / C1 | [TERMS-SURFACES-INSTALLATION.md](TERMS-SURFACES-INSTALLATION.md), S01–S56 | Önceki source-family aktarımı korunur |
| U03–U04 / C2 | [TERMS-WORK-EXECUTION-MEMORY.md](TERMS-WORK-EXECUTION-MEMORY.md), W01–W89 | Önceki source-family aktarımı korunur |
| U05–U06 / C3 | [TERMS-LEARNING-GOVERNANCE.md](TERMS-LEARNING-GOVERNANCE.md), L01–L114 | C6b raw-evidence refinement dahil; source-family aktarımı korunur |
| U07–U09 / C4 | [TERMS-REVIEW-RUNTIME-OPERATOR.md](TERMS-REVIEW-RUNTIME-OPERATOR.md), R01–R176 | Önceki aktarım korunur |
| U10-A / C5a | [TERMS-EVALUATION-REGISTRY.md](TERMS-EVALUATION-REGISTRY.md), E01–E50 | Complete |
| U10-B / C5a | [TERMS-OFFLINE-CAPSULES.md](TERMS-OFFLINE-CAPSULES.md), O01–O69 | Complete |
| U11-A / C5b | [TERMS-NATIVE-REVIEW.md](TERMS-NATIVE-REVIEW.md), N01–N77 | Complete |
| U11-B / C5b | [TERMS-SCHEDULED-WORK.md](TERMS-SCHEDULED-WORK.md), SC01–SC61 | Complete |
| U11-C / C5b | [TERMS-REMOTE-REQUESTS.md](TERMS-REMOTE-REQUESTS.md), RD01–RD70 | Complete |
| U11-D / C5b | [TERMS-BACKLOG-COORDINATION.md](TERMS-BACKLOG-COORDINATION.md), BC01–BC70 | Complete |
| U11-E / C5b | [TERMS-TEMPLATE-LAUNCH.md](TERMS-TEMPLATE-LAUNCH.md), TL01–TL74 | Complete |
| U12-A / C5c | [TERMS-EXECUTION-PROFILES.md](TERMS-EXECUTION-PROFILES.md), EP01–EP84 | Complete |
| U12-B1 / C5c | [TERMS-OPENCODE-CALLBACKS.md](TERMS-OPENCODE-CALLBACKS.md), OC01–OC92 | Complete |
| U12-B2 / C5c | [TERMS-OPENCODE-INSTALLATION.md](TERMS-OPENCODE-INSTALLATION.md), OD01–OD91 | Complete |
| U12-C / C5c | [TERMS-PYTHON-PROVIDERS-AND-TOOLS.md](TERMS-PYTHON-PROVIDERS-AND-TOOLS.md), PY01–PY108 | Complete |
| E01–E05 araştırma düzeneği / C6b | [TERMS-EARLY-PROBE-EVIDENCE.md](TERMS-EARLY-PROBE-EVIDENCE.md), PE01–PE34 | Driver/raw-evidence aktarımı complete; C6 bütünü değil |
| Package history / coverage / closure / C6 | [TERMS-PACKAGE-COVERAGE.md](TERMS-PACKAGE-COVERAGE.md), PC01–PC45 | History/current-plan/inventory reconciliation complete |
| U14 readiness / telemetry / cost-context-resource | [TERMS-OBSERVABILITY-RESOURCES.md](TERMS-OBSERVABILITY-RESOURCES.md), OR01–OR82 | C6 post-U12 transfer complete |
| U15 assembly / integration / information-use | [TERMS-ASSEMBLY-INTEGRATION-INFORMATION.md](TERMS-ASSEMBLY-INTEGRATION-INFORMATION.md), AI01–AI92 | C6 post-U12 transfer complete |
| U16 maintenance / shared configuration / recovery | [TERMS-MAINTENANCE-RECOVERY.md](TERMS-MAINTENANCE-RECOVERY.md), ML01–ML63 | C6 post-U12 transfer complete |
| U13 release qualification / scanner / advisory | [TERMS-RELEASE-SUPPLY-CHAIN.md](TERMS-RELEASE-SUPPLY-CHAIN.md), RS01–RS80 | Dedicated C6 transfer complete |
| U17 guidance / procedure / E10 recovery | [TERMS-GUIDANCE-PROCEDURES-E10.md](TERMS-GUIDANCE-PROCEDURES-E10.md), GH01–GH55 | C6 post-U12 transfer complete |
| U18-A–C scorecard / reputation gate / consult | [TERMS-SCORECARD-REPUTATION-CONSULT.md](TERMS-SCORECARD-REPUTATION-CONSULT.md), IX01–IX66 | C6 existing-source transfer complete |
| U18-D–F Itô / Nasiko / NanoClaw | [TERMS-EXTERNAL-CLIENTS-CONTEXT.md](TERMS-EXTERNAL-CLIENTS-CONTEXT.md), EC01–EC83 | C6 existing-source transfer complete |
| U18-G desktop explorer | [TERMS-DESKTOP-DISCOVERY.md](TERMS-DESKTOP-DISCOVERY.md), DD01–DD40 | C6 desktop source transfer complete |
| U18-H browser dashboard | [TERMS-BROWSER-DASHBOARD.md](TERMS-BROWSER-DASHBOARD.md), BD01–BD53 | Source answer plus later publication closure transferred; U18-I remains NOT STARTED |

Bütün kullanım kimlikleri ECC- öneki taşır. Bunlar bağımsız kavram, kanıt veya ilerleme yüzdesi değildir. PE satırları ürün mimarisinin yeni parçaları değil, mevcut araştırmanın deney/kayıt kullanımlarıdır. C6b'de C3 dosyası raw E05 refinement'i aldı ve PE dosyası E04/E05 ile genişledi. Bağlı kullanım dosyalarının paket-geneli source/rol/ilişki kontrolü henüz kapanmadı.

## 2. Package-level expressions — korunur

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-P01 — ECC | Procedural assets, install/distribution, work/runtime, memory/learning, evaluation and governance surfaces taşıyan external target. | Tek uniformly integrated runtime olarak varsayılmaz. |
| ECC-P02 — source surface | Repo'daki authored/configured mechanism surface. | Installed/live/effective behavior değil. |
| ECC-P03 — mechanism slice | Bounded trigger→selection→effect→acceptance/failure chain araştırma birimi. | Whole subsystem veya whole product değil. |
| ECC-P04 — bounded source answer | Exact pinned source + declared evidence class altında answered question. | Product-wide/current empirical closure değil. |
| ECC-P05 — local execution | Exact isolated fixture'da unchanged source behavior observation. | Live host/model/product validation değil. |
| ECC-P06 — source-derived counter-path | Multiple code paths together imply a reachable contrast/failure condition. | Observed production incident değil. |
| ECC-P07 — evidence class | Target claim/source observation/test inspected/local execution gibi claim-strength qualifier. | Tek eksenli confidence score değil. |
| ECC-P08 — installed ≠ discoverable ≠ selected ≠ followed ≠ effective | ECC METHOD'in recurring distinction. | Universal ontology değil; source-study methodological boundary. |
| ECC-P09 — recorded ≠ accepted | Stored/report state ile governance/work acceptance ayrımı. | Every record untrusted demek değil. |
| ECC-P10 — test-green ≠ valid oracle | Passing/expected test result'in measured claim'e uygun oracle olma gereği. | Tests useless demek değil. |

## 3. C6b'nin yeni karşılaştırması

E01/E02/E03'ün üç driver'ı, üç planı, üç ham sonuç dosyası ve üç README'si tam okundu. S/W dosyaları da full kaynak-kayıt karşılaştırmasına alındı. Yeni PE dosyası §5, bütün 14 kayıtlı vakanın kullanım karşılığını gösterir. Bu tur hiçbir betik/target yeniden çalıştırılmadı.

**S12–S14:** E01 source prediction ile tam referans-varlığı ölçütü ayrı. PE03/PE04/PE05, eksik hook'un kaçırıldığı vakada true prediction match'in ürün güvencesi olmadığını açıklar. PE02 empty/dummy baseline'ı çalışır cache diye yükseltmez. Eksik MCP ret kontrolü korunur.

**W01–W11:** E02 helper'ın claim/move anlamları değişmedi. PE06/PE07 gerçek helper ile fake store/temsil edilen SQL sıra varsayımını ayırır; PE08/PE09 istenen limit/id ve double yazılarını ayrı adresler. W11 zaten blockedBy'nin illustrative metadata olduğunu söylüyordu; bu tur bir eski hatayı düzeltmiş sayılmıyoruz.

**W42–W52:** E03 raw/parsed handoff, completed/accepted work ve generic failure/diagnostic ayrımları korunur. PE11/PE12 sahte program ve onun aldığı prompt/argv'nin gerçek model uyumu olmadığını; PE13 provider exit ve wrapper exit'in ayrı alanlar olduğunu gösterir. PE16 yalnız özel TMPDIR gözlemidir, bütün üretilmiş değerin silindiği veya hiç etki olmadığı hükmü değildir.

**Plan ve kontrol:** PE14 plan bayt kimliği, PE15 çalışma boyunca değişmezlik, PE10 vaka check'i ve PE17 toplam kriter eşleşmesi ayrı kullanımlardır. E03'te planUnchanged, ayrıca kodlanmış specifications/check'leri doğrulamaz. E01 plan girdisini kullanırken E02 vaka koşullarını kodda taşır. Plan–driver–raw sonuç karşılaştırması bu nedenle ayrıca yapılmıştır; yeni experiment veya bağımsız bilimsel doğrulama değildir.

S/W metinlerini değiştirmeyi gerektiren maddi çelişki saptanmadı. Bu sonuç yalnız incelenen erken-evidence ilişkileri içindir; diğer installation/memory/live pane/rollback iddialarının yeni doğrulanması değildir.

## 4. Önceki ilişki ve düzeltmelerin tam kaydı

Bu router'ın U12 ve C6a dahil önceki tam metni [3acfa615 TERMS](https://github.com/batuhanozgun/agentic-os-search/blob/3acfa615092cfc264df126a800c8d7c74ed646fd/concepts/studies/ecc/TERMS.md), blob **0acc3d16473855bffb8b9fd39d1eb05675eb66ac**, olarak korunur. U12-B2/C'nin geniş ilişki açıklamaları, bütün önceki düzeltmeler ve daha eski router bağlantıları oradadır. Bu tarihsel tam kaynak C6 girdisidir; next ifadeleri güncel iş değildir. Yerel TERMS dosyalarındaki yorum geçmişleri de değişmedi.

Önemli geri çağırma adresleri korunur: O03/O69 capsule/journal; N21/N76 ve N32/N77; SC47/SC61; TL38/TL74, TL50/TL73 ve TL72; EP29/EP84 ve EP33/EP83; OC75 araştırmacı değişimi; OD17/OD90, OD65/OD91; PY19/PY106, PY31/PY107, PY47/PY108 ve PY66/PY80/PY83 kanıt etiketleri. Birbirine benzer evaluation, claim, retry, completed ve authority sözcükleri ayrı kaynak/consumer bağlamlarında kalır. PE ekleri bunları tek ortak tanıma dönüştürmez.

## 5. Exact next ve açık kapsam

**C6 complete for source tree e33ea2998ecd3c0e05a3f2c3dcf095b697b81544.** Linked TERMS/router audit and final source census are closed; future source-study material after this tree is later delta, not silently included. İki E05 kimliği ayrı, E06 excluded kalır.

C6a'nın U5 driver listesi ve üç usable R carrier E01–E05 için scoped olarak kapandı. Değiştirilmemiş 41f6603 TSV'si C6a anını gösterir; bugünkü kapanış onun üzerine sürümlü eklemedir. Kalan root/master-history/inventory, U13 ve census sonrası source delta, linked TERMS + router semantik kontrolü ve final current census açık. Metadata'da yeni kaynakların özetlerini okumak gövde aktarımı değildir.

ECC paketi kapanmadan work-management-project-control'e geçilmez; B7 geçmeden B8 ortak referans başlamaz. Amaç kaynak bağlamını taşımaktır, kaynak-study'nin sonraki teknik sorusunu çözmek veya mimari karar vermek değildir.

## 6. İki risk

Batu okuma anındaki anlam seçimlerini denetleyemediğinden dayanak/yorum/belirsizlik/değişim görünür kalmalıdır. Ortak sözcükler ortak anlamı garanti etmez; kaynak kullanımı, araştırmacı/extractor yorumu ve kullanıcı onayı teknik doğrulama bakımından ayrı tutulur. Bu tur plan, prediction ve criterion etiketlerinin fiilen neyi ölçtüğü somut ayrımlardır. Aynı-assistant karşılaştırma ve readback bağımsız doğrulama değildir.

## 7. C6 closure route

- [Final reconciliation](C6-FINAL-RECONCILIATION.md)
- [Final source manifest](C6-FINAL-SOURCE-MANIFEST.tsv): 247 leaves, exact path/blob coverage basis
- [TERMS audit](C6-TERMS-AUDIT.md): 26 linked files, 1,974 usage IDs, P01–P10, source-role/link and relation checks

This router is package-complete only for the named source tree. Source-study remains ACTIVE/PARTIAL; U18-H publication is included, while future U18-I files are not preclaimed.
