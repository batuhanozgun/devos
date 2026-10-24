# Superpowers — Test, doğrulama, teslim ve kayıt koruma

2026-09-20, **B6-T7 / U04-U05-KAYNAK-KAYDI-TAMAM / PAKET-KISMİ**. [TERMS.md](TERMS.md)'nin bağlı parçasıdır. Giriş ve görev/inceleme kayıtları [ENTRY](TERMS-ENTRY.md) ve [WORK](TERMS-WORK.md)'te korunur; güncel okuma/aktarım ve devam [READING.md](READING.md)'dedir. Bu dosya genel test kuramı, yeni ürün değerlendirmesi veya ortak sözlük değildir.

## 1. Kaynak ve aktarım kapsamı

Araştırma deposu `batuhanozgun/agentic-os-search`; sabit araştırma/P2 ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**, paket tree **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. B6-T7 başlangıç main'i **1bdd7066bff2eadcddc0237c926f7f1daef1f376**; önceki concepts kapanışından fark yalnız ECC/katalog yollarıdır. İncelenen dış ürün ayrı kimliktir: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest bağlamı 6.3.0. Güncel dış ürün/host davranışı bu tur doğrulanmadı.

| Kod | Sabit araştırma kaynağı | Bu turdaki rol |
|---|---|---|
| N04 | [U04-testing-diagnosis-and-verification.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U04-testing-diagnosis-and-verification.md) | §1–10 tam okuma; test, teşhis, doğrulama iddiası ve tanılama gözlemi. |
| L04 | [SOURCE-LEDGER-U04.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U04.md) | S44–S54 ve E09/E10 kaynak kimlikleri/kanıt sınıfları; tam okuma. |
| E09-R/O | [U04 betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U04-diagnostic-probes.py) / [kayıtlı sonuç](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U04-diagnostic-probes-results.json) | İkisi tam okundu. Geçmiş kontrollü npm-stub koşusu; bu tur çalıştırılmadı. |
| N05 | [U05-delivery-cleanup-and-retention.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U05-delivery-cleanup-and-retention.md) | §1–10 tam okuma; insanın bitiş seçimi, gerçek etki ve farklı saklama yolları. |
| L05 | [SOURCE-LEDGER-U05.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U05.md) | S55–S57, yeniden kullanılan kaynaklar, Git belge atıfları ve E11/E12 sınırları; tam okuma. |
| E11-R/O | [U05 betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U05-lifecycle-probes.py) / [kayıtlı sonuç](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U05-lifecycle-probes-results.json) | İkisi tam okundu; sentetik Git örnekleri ve tek exact S32 helper'ı. S55 metninin veya gerçek agent'ın yürütülmesi değil. |
| S04 | [S04-execution-verification-and-delivery.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S04-execution-verification-and-delivery.md) | §1–8 tam okuma; U02–U05'in bağımlı ilişki görünümü. U07/U08 ve bütünsel bağları sonraki gruplarla kontrol edilecek. |

Türkçe açıklamalar kaynak bağlantılı parafrazdır. Ürüne atfedilen talimat, önceki araştırmacının kod/deney aktarımı, onun çıkarımı ve bu aktarımın kapsam açıklaması ayrı tutulur. S/E/F/Q numaraları kaynak araştırmanın adresleridir; SP kimlikleri görünür P2 kullanım adresleridir. Atfedilen dış dosyayı okumakla onu anlatan araştırmayı okumak aynı değildir. Bu tur hiçbir ürün betiği, model, host veya test suite'i çalıştırılmadı.

İki neden: kullanıcı okuma anındaki anlam seçimlerini denetleyemediğinden önemli dayanak/yorum/belirsizlik/değişiklik görünür olmalı; aynı sözcük aynı anlamı garanti etmediğinden kullanıcı onayı, kaynak kullanımı ve çıkarıcı yorumu teknik doğruluk yerine geçmemeli. Bu kayıt bağımsız doğrulama değildir.

## 2. Test, beklenti ve yanlışın ayırt edilmesi

| Adres / özgün ifade | Bu araştırmadaki kullanım | Dayanak ve sınır |
|---|---|---|
| SP62.a — TDD / test-driven-development | Uygulama öncesi beklenen başarısızlığı görme, ardından davranışı sağlama ve düzenleme boyunca testleri koruma prosedürü; aynı zamanda özel skill adı. | N04 §2/S44. Yazılı prosedür, gözlenmiş agent davranışı veya genel TDD üstünlüğü değildir. |
| SP62.b/c/d — RED / GREEN / refactor | .b beklenen nedenle başarısız test; .c uygulama sonrasında geçen test; .d davranış korunurken düzenleme. | N04 §2. Yazım/setup hatası ya da ilgisiz hata amaçlanan RED değildir; her yeşil sonuç bütün gereksinim kapsamını kanıtlamaz. |
| SP63.a — Test oracle | Doğru/yanlış davranışı ayırt ederken kullanılan beklenti ve gözlem dayanağı. | N04 §2/S47. Testin koşması veya önce başarısız olması beklentinin doğruluğunu bağımsız kanıtlamaz. |
| SP63.b — Independently derived expectation | Beklentinin sınanan üretim kodu veya onun yardımcılarıyla aynı hesabı tekrar ederek değil, ayrı kurulması. | N04 §2. Literal ve elle kontrol edilmiş fixture örnekleri var; her fixture'ın doğru olduğu sonucu verilmez. |
| SP64 — Mental mutation check | Yanlış argüman/dal, eksik durum değişimi veya geçersiz girdi olsaydı testin bunu ayırt edip etmeyeceğini düşünme talimatı. | N04 §2. Otomatik mutation-testing motoru veya fiilen çalıştırılmış mutation deneyi değildir. |
| SP171.a/b/c — Test double / spy / mock | Sınır sözleşmesindeki argüman, sıra ve çağrı sayısı gibi davranışları kontrollü bağımlılıklar üzerinden gözleme bağlamları. | N04 §2/S47. Kaynak bu üçünün ayrı genel tanımını kurmuyor; birlikte anılmaları eş anlamlılık kararı değildir. Mock'un varlığı gerçek etkiyi sınamak değildir; her spy'ı yasaklayan kural da çıkarılmaz. |

N04 §2'nin temel ayrımı ve S04 §4: **testin uygulamadan önce yazıldığı**, **ilgili yanlışı ayırt ettiği** ve **sonucunun mevcut kod/girdi/ortama uygulanabildiği** farklı iddialardır. Sağlam bir testin sonradan yazılması test-first geçmişi oluşturmaz; eski yanlış beklentiyi tekrar çalıştırmak da beklentiyi onarmaz. Bu, kaynak araştırmanın analitik açıklamasıdır; yeni bir test standardı kabulü değil.

Kaynağın TDD kontrol listesinde her yeni işlev/metot için test dili varken destek rehberi, davranış bakımından anlamı olmayan basit yönlendirme ve insan metnine nitelendirme getirir. İşlev sayısını başarı ölçütü yapmadım; örtüşmeyi evrensel bir öncelik kuralıyla çözmüş saymadım. N04 ayrıca çalışma zamanında üretilmiş metni sınayan assertion ile yalnız kaynak metnini aramanın farklı olduğunu gösterir (§9). Bir string assertion'ın varlığı tek başına testin yüzeysel olduğu anlamına gelmez.

## 3. Teşhis, koşul ve alınan inceleme

| Adres / ifade | Yerel kullanım | Dayanak ve sınır |
|---|---|---|
| SP65.a — Systematic debugging | Yeniden üretme, hata/veri/ortam akışını izleme, çalışan örnekle karşılaştırma, hipotez, bir değişkeni değiştirme ve yeniden değerlendirme döngüsü. | N04 §3/S48. Burada yeni neden teşhisi yapmıyoruz; kaynakta tarif edilen yöntem kaydediliyor. |
| SP65.b — Root-cause tracing | Geçersiz değeri, çıktıda göründüğü noktadan onu üreten çağrı/başlatmaya doğru geriye izleyen destek tekniği. | N04 §3/S49. SP65.a'nın bütününün eş anlamlısı değil. İzleme imkânsızlığındaki fallback nitelemesi korunur. |
| SP66 — Defense-in-depth | Giriş, iş kuralı, ortam kontrolleri ve tanılama günlüklerinin birlikte ele alınması. | N04 §3/S50. Önleme ile kayıt/gözleme ayrı işlevdir; çok kontrol otomatik bağımsızlık veya hatanın imkânsızlığı değildir. |
| SP67 — Condition-based waiting | Tahmini gecikme yerine ilgili koşulun yeniden okunması ve timeout ile bekleme. | N04 §4/S51–S52. Zamana bağlı davranış sınanıyorsa gerekçeli süre beklemesi dışlanmıyor. |
| SP67.a/b/c — Event type / event count / custom predicate | .a olay türü; .b sayısı; .c örneğin tool-call ID'yi eşleştiren özel koşul üzerinden bekleme örnekleri. | N04 §4. Önceki eşleşen olay type/count koşulunu sağlayabilir; mevcut belirli işlemin tamamlanması ayrıca bağlanmalıdır. Bu, her occurrence sorgusunu hatalı kılmaz. |
| SP68.a/b — Receiving code review / pushback | .a geri bildirimi anlamak ve kod/bağlamla değerlendirmek; .b gerekçeli karşı çıkmak. | N04 §5/S46. Öneri kendiliğinden uygulama emri veya teknik doğruluk değildir; insan talebi ile dış önerinin süreç rolleri de ayrıdır. |
| SP172 — YAGNI | İnceleme önerisindeki gereksiz görünen eklemeyi kullanım araması ve sorgulamayla ele alan örnekte geçer. | N04 §5. Genel açılım/tanım eklenmedi; aramada kullanım bulamamak bütün tüketicilerin yokluğu yapılmadı. |

N04 §3'te üç başarısız düzeltme sonrası mimari konuşma kuralı ile SDD'nin görev-inceleme turları farklı döngülere aittir. Sayının dolması mimarinin yanlışlığını bilimsel olarak kanıtlamaz. Kaynaktaki yüzde, hız ve hata-imkânsızlığı söylemleri hedef yazarın iddia/gerekçeleridir; burada doğrulanmış istatistik yapılmadı. Çevresel/zamansal/dış nedenlerde araştırmayı belgeleyip uygun handling/monitoring ile çıkma yolu da korunur. Sınırsız kök-neden araştırması yükümlülüğü üretilmedi.

S52, Lace'e özgü tipler kullanan TypeScript örneği olarak anlatılır; genel ve bağımsız çalıştırılmış runtime değildir. Bu paket onu betimlediği için mevcut aşamada Lace'i ayrıca araştırmak gerekmez.

## 4. Doğrulama iddiası ve kanıtın uygulanabilirliği

| Adres / ifade | Bu bağlamdaki karşılık | Dayanak ve sınır |
|---|---|---|
| SP69 — Verification-before-completion | Söylenecek iddiaya uygun komutu belirleme, çalıştırma, bütün çıktıyı/çıkışı okuma ve desteklenen sonucu bildirme prosedürü. | N04 §6/S45. Skill adı, yürütülebilir verifier framework veya gerçekleşmiş kontrol demek değil. |
| SP70.a — Fresh evidence / current-message run | Genel skill'in olumlu iş durumu iddiası için mevcut mesajda yeni koşu istemesi. | N04 §7. Nitelemenin iddia/aktör/aşamaya bağlanması gerekir. |
| SP70.b — Reused evidence / same-code report | Özel görev/re-review şablonlarının aynı kod için mevcut raporu kullanması; belirli yanıtsız şüphede odaklı test veya eksik metni geri kazanma. | N04 §7; WORK/SP33. Raporu okumak yeniden koşmak değildir; yaş tek başına geçersizlik, yenilik tek başına yeterlilik değildir. |
| U04-U01 — Regression sensitivity check | Geçen test → düzeltmeyi kaldırınca başarısızlık → düzeltmeyi geri koyunca geçme örneği. | N04 §6. İlgili yanlışın ayırt edilmesini sorgular; tüm gereksinimler veya bütün değişikliğin TDD geçmişi için kanıt değildir. |

N04 §6 farklı iddiaları ayırır: build/lint; test sonucu/gereksinim kapsamı; kodu değiştirme/eski semptomun giderilmesi; child'ın DONE beyanı/VCS değişikliğinin anlamı. Aynı yeşil durum hepsinin yerine kullanılmaz. Kaynağın gereksinim kontrol listesi de gereksinimin kendisini otomatik doğru yapmaz.

**Q24 açık kalır:** Eski değişmemiş raporun ne dediğini aktarmak, yeni koşu iddiasından farklıdır; odaklı komut, tam suite koşusuyla aynı şey değildir. Bunlar kaynak araştırmacısının açıklayıcı ayrımlarıdır, genel skill'in literal same-message kuralına kaynakta tanımlanmış eksiksiz istisna sistemi değildir. İncelenen sözleşmeler raporu tüm kod/worktree, test/oracle, girdi ve ortam kimliğiyle mekanik olarak bağlayıp her ilgili değişiklikte geçersiz kılmıyor. Bu kaynak kapsamındaki sınırdır; başka yerde hiçbir destek yok iddiası değil.

N04'ün analitik kontrolü, kanıtın hangi iddia/nesne/komut/çıktı/zaman/ortamla ilgili olduğunu ve hangisinin değiştiğini sorar. Bu öneri kaydedildi; yeni mimari veya veri şeması olarak benimsenmedi.

## 5. Tanılama yardımcısı ve clean/exit kullanımları

| Adres / ifade | Araştırmadaki kullanım | Dayanak ve sınır |
|---|---|---|
| SP71 — Find-polluter / pollution | Seçilmiş test dosyalarından hangisinin belirtilen dosya sistemi hedefini oluşturduğunu arayan yardımcı ve aranan yan etki. | N04 §8, L04/S53. Bütün test doğruluğunu veya bütün kirlenme biçimlerini denetleyen sistem değil. |
| SP173 — Bisection | Kaynağın destek anlatımındaki etiket; araştırmanın incelediği yardımcı, seçilen dosyaları sırayla yürütür ve hedef oluşunca durur. | N04 §8, L04. Etiketten ikili arama algoritması uygulandığı sonucu çıkarılmaz. |
| U04-U02.a/b/c/d — Clean niteleyicileri | .a WORK'teki başlangıç test baseline'ı; .b ilgisiz dosya değişikliği olmaması; .c inceleme sonucu; .d yardımcının aranan yan etki için kullandığı final mesaj. | N04 §8–9 ve WORK. Bunlar aynı nesneyi nitelemez; bütün sisteme tek clean bayrağı olarak taşınmaz. |
| U04-U03 — Exit status / claim-scope challenge | Yardımcı çıkışı, çağrılan test başlatıcısının çıkışı ve araştırmacının mesaj kapsamına verdiği hüküm ayrı sonuçlar. | E09-R/O. Yardımcıdaki exit 1 hem eksik argüman hem hedef bulundu durumunda görülebilir; runner exit 0 bütün ölçütler geçti demek değildir. |

E09-R/O tam birlikte okundu. Yedi kayıtlı vaka: argüman reddi, iki adayın hedef oluşturmadan çağrılması, hedefin bir çağrıda bulunması, hiç aday olmaması, hedef önceden var olduğu için bütün adayların atlanması, başlatıcının 127 dönmesi, hedef oluşmadan test başarısızlığı. Kaydedilmiş dört mekanizma/kapsam beklentisi karşılandı; üç claim-scope ölçütü başarısız. Ayrı first-party fixture kaydı exit 0 ve beş PASS assertion satırı içeriyor. Bunlar bu tur koşulmuş testler veya genel ürün puanı değildir.

**Önemli niteleme:** Başlatıcının hatası ya da test başarısızlığı, belirli yan etkiyi aramaya devam etmeyi anlamsız kılmayabilir. Bunun testler geçti sonucuna dönüşmesi ayrı sorundur. Sıfır aday ve önceden var olan hedef durumlarında stdout önce sıfır/atlama bilgisini de gösterir; tam çıktı bütünüyle gizli başarısızlık diye anlatılmaz. Araştırmacının eleştirdiği, koşulsuz final all-tests-clean mesajının gözlem kapsamıdır; ürünün vaat ettiği fail-closed API icat edilmez.

`first_party_fixture_test`, `stub_invocations`, `invocation_count`, `pollution_exists`, `blanket_clean_claim`, `polluter_reported`, `kind`, `criterion`, `observed`, `result`, `stdout/stderr` yerel deney/kayıt alanlarıdır. Stub çağrı günlüğü ve dosya gözlemi helper'ın final cümlesinden farklı gözlem yüzeyleri sağlar; bu tüm araştırmanın bağımsız replikasyonu değildir. Tam koşu yeni test gibi sunulmadı.

## 6. Teslim yolları ve farklı sonuç nesneleri

| Adres / ifade | Bu araştırmadaki kullanım | Kaynak ve sınır |
|---|---|---|
| SP72.a/b — Finishing / integration authority | .a kabul edilen işten sonraki bitiş prosedürü; .b merge/yayın/koruma kararının ilgili insana ait olması. | N05 §2/S55. Görev kabulü bütün sonraki etkileri yetkilendirmez. Kaynakta sıradan menüden önce full test suite istenir. |
| SP73.a/b — Local merge / merged-result verification | .a seçilen base ile birleştirme; .b oluşan birleşik durumun yeniden test edilmesi. | N05 §2–3. Dal testi ile yeni birleşik sonuç aynı nesne değildir. Base belirsizse bağlamdan belirleme/onay istenir; main otomatik varsayılmaz. |
| SP74.a/b — Push / pull request | .a dal/ref içeriğinin hedef depoya aktarılması; .b forge üzerinde inceleme/birleştirme talebinin oluşturulması. | N05 §2–4. Push başarısı PR varlığı değildir; çalışma ortamının gerçek yetenekleri ayrıca koşuldur. |
| SP75 — Keep | Entegrasyonu erteleme, dal/çalışma alanını mevcut durumuyla koruma ve bunu bildirme. | N05 §2. Detached keep yeni adlı yerel dal oluşturmaz; yayın değildir. |
| SP76 — Discard | Açık vazgeçme isteği ve ayrıca belirtilmiş onaydan sonra uygulanan silme yolu. | N05 §2. Varsayılan bitiş seçeneği değildir. Bu kaynak talimatı kendi çalışma alanımızda silme yetkisi üretmez. |
| SP174a/b/c — Named branch / detached HEAD / MERGE_HEAD | .a adlı dal durumu; .b adlı yerel dal üstünde bulunmama; .c çatışmalı örnekte bitmemiş birleştirmeyi gösteren Git işareti. | N05 §2–4/E11-R/O. Detached durum, teknik erişim/yetki veya çalışma alanı sahibiyle eşitlenmez; çatışma otomatik rollback değildir. |

Kaynak, adlı dal için local merge/push-and-PR/keep, detached için push-as-new-branch-and-PR/keep yollarını ayırır. Menülerdeki aynı seçenek numarasını aynı eylem saymamak gerekir. Menü metni runtime dispatcher veya gerçekleşmiş etki değildir. Push reddinin otomatik force-push'a çevrilmemesi kaynak prosedürünün başka bir sınırıdır (N05 §2).

E11-R/O'da ayrı dallar `a + b <= 1` testinden geçerken çatışmasız birleşik sonuç geçmeyebiliyor. Bu, kaynakta zaten istenen merged-result testinin gereğini açıklayan sentetik karşı örnektir; Superpowers'ın retest kuralının başarısızlığı değildir. Başka örnekte merge çatışması `MERGE_HEAD` ve unmerged dosyayla kalır; fixture temizliği sürdürmemiştir. Bu seçim agent'ın doğru davrandığına kanıt değildir.

N05'in nesne ayrımı: **incelenmiş commitler; test edilmiş çalışma kopyası; güncellenmiş base; birleşmiş yerel sonuç; hedef ref; oluşturulmuş PR**. İşlemler tek atomik başarı/rollback olayı olarak gösterilmez. Eski Codex referansındaki host kısıtı hedef yazarın tarihli talimatıdır, bu tur doğrulanmış OpenAI ürün belgesi değildir.

## 7. Temizlik, sahiplik, karar ve kanıtın korunması

| Adres / ifade | Yerel kullanım | Dayanak ve sınır |
|---|---|---|
| SP77.a/b/c — Scratch / worktree / branch cleanup | .a SDD'nin geçici plan dizinini kaldırma; .b dış çalışma kopyasını kaldırma; .c dalı silme. | N05 §5–7. Ayrı nesneler, ayrı koşullar/sonuçlar. PR/keep dış worktree'yi koruyabilir; iç scratch'in daha önce silinmediğini göstermez. |
| SP78.a — Decision disclosure | `Ruling:` kayıtlarını sırası ve yanlışsa maliyetiyle son insan-görünür mesaja, gerekli maddi artıklarla birlikte taşıma yükümlülüğü. | N05 §7/S30. Kaynakta gerçek bir koruma talimatı var; yükümlülük gerçekleşmiş alım/okuma kaydı değildir. |
| SP78.b — Evidence retention / archival | İleride gerekli test/rapor/inceleme malzemesinin saklanması. | N05 §7, S04 §7 araştırmacı ayrımı. Kararların aktarılması her test çıktısının arşivlenmesi değildir; bütün scratch baytlarını sonsuza kadar saklama zorunluluğu da kurulmaz. |
| SP79 — Workspace ownership / host-owned workspace | Çalışma alanını kimin yönettiği ve temizleyebileceği sorusu; kaynak belirli yol/dal durumlarından politika çıkarır. | N05 §4–5. Yol adı/detached durum gerçek sahiplik sicili değildir. Host exit aracının olası etkisi kaynakta doğrulanmamış koşul kalır. |
| U05-U01 — Refusal-conditioned no-force safeguard | Olağan worktree kaldırma reddedilirse status gösterme, insanın commit/taşıma/silme kararına dönme; kendiliğinden force'a yükseltmeme. | N05 §6, CORE/CLOSURE-AUDIT LC2. Koruma, reddi tetikleyen koşullara bağlı; bütün only-copy kayıtlara evrensel garanti değildir. |

Üç taşıyıcı ayrımı korunur: gerçekten commit edilmiş kod/spec/plan; insana aktarılmış karar ve artık risk; yok sayılan/geçici ayrıntılı rapor ve test kanıtı. Bunları araştırma üç zorunlu depolama servisi olarak tanımlamaz (N05 §7/S04 §7).

**Eşleştirilmiş geçmiş gözlem:** Sıradan untracked not kaldırmayı reddettirip kalır; S32'nin self-ignored dizinindeki sentetik ledger normal status'ta görünmez ve force kullanılmadan olağan worktree kaldırmayla kaybolur. Sonuncu araştırmacının daha güçlü saklama çıkarımına karşı FAIL'dir. Ürüne tüm scratch'i arşivleme vaadi yüklenmedi; gerçek kullanıcı verisi kaybı veya modelin aktarım yükümlülüğünü atlaması gözlenmedi. Koruma önce yapılsaydı durum farklı olabilirdi; fixture bunu yapmaz.

Diğer kayıtlı vakalar: yeşil birleşim sonrası worktree/dal temizliği ve commit'in base tarihinde kalması; korunan named dış worktree yüzünden dal silmenin reddi; detached HEAD'den yerel bare hedefe explicit refspec ile aktarım; bitmemiş merge çatışması. Yedi vakanın altısında belirtilen gözlem karşılanmış, bir retention challenge başarısız. Uzak hedef yalnız geçici yerel dosya sistemi; forge PR yok. Betiğin stdout/stderr/exit izleri `<TMP>`/`<PINNED_S32>` yol normalleştirmesiyle saklanmış; gerçek repo mutation'ımızla karıştırılmaz.

## 8. Sınama dilinin ilave kaynak sınırları

N05 §8/L05'teki path-policy testi kaynak/spec/plan metin eşleşmelerini sınar; çalışma alanının kurucusunu veya gerçek kayıt saklamayı gözlemez. Native-preference testi ise eylem odaklı agent senaryosu içerir: salt metin örneği değildir. Fakat incelenen GREEN/PRESSURE koşulunda literal `git worktree add` yokluğu yeterli olabilir; ayrıca hesaplanan native-tool anılması o dalın zorunlu koşulu değildir. Script, RED/GREEN arasında yüklü skill sürümünü kendi başına değiştirmez. Bunlar yeni model koşusu, geçmiş oran doğrulaması veya bütün upstream testlerinin yokluğu değildir.

Bu anlam, WORK/SP170'in description/drill ayrımını geri almaz. Bir testin eylem senaryosu olması, çıktıyı değerlendiren koşulun gerçek eylemi ayırt ettiğini tek başına göstermez. Buna karşılık N04'ün çalıştırılmış first-party fixture'ının metin assertion'ları yürütülen helper çıktısına bakar; hepsi kaynak-grep diye birleştirilmez.

Yalnız adı geçen yerel teknik alanlar/işlemler: call-ID, timeout, HEAD/index, refspec, forge, ignored/untracked, `MERGE_HEAD`, `force_used`, `cleanup_attempted`, `rollback_performed`, `remote_ref_matches_commit`. Her birine dış sözlükten genel tanım yazılmaz; kaynağın kullandığı rol korunur. Geçici yol, örnek sayı ve sentineller bağımsız kavram sayılmaz.

## 9. İlişki görünümü, yorum izi ve kapanış sınırı

S04 §1–8'in bağlantısı: **yürütmeye alınmış görev/bağlam → uygulama ve rapor → kapsamı belirli inceleme → düzeltme veya gerekçeli sonuçlandırma → nitelendirilmiş görev tamamlanması → insana ait entegrasyon seçimi → yeni sonuç nesnesinin doğrulanması → ilgili kayıt ve kararların korunması**. İlk adım işe alınmayı, sonraki tamamlanma adımı sonucun değerlendirilmesini anlatır. Bu özellikle planlı SDD yolunun açıklamasıdır; her isteğin tek hattı veya çalıştırılabilir bir durum makinesi değildir.

P2-T2/P2-T5'in görünür SP62–SP79 ve SP171–SP174 kayıtları kaynakla karşılaştırıldı; önceki numaralar korunup gerektiğinde alt adres verildi. Yeni U04/U05 adresleri kaynaktaki ek yerel kullanımları gösterir. SP67'de gerekçeli zaman beklemesi ve mevcut-işlem bağının ayrımı; SP65'te çevresel çıkış/fallback; SP77–78'de koşullu temizlik ve gerçek karar aktarımı yükümlülüğü belirginleştirildi. Önceki ana açıklamayı tersine çeviren bir fark saptanmadı. Bir niteleyiciyi daha açık taşımak, dış kaynağı düzeltmek değildir.

WORK §4'teki (SP33) kanıt-tekrar-kullanımı açıklaması, burada SP70 ve N04/Q24 ile bağlandı. WORK'ün U05'e bıraktığı gerçek teslim/koruma kapsamı burada karşılandı; ENTRY/WORK içindeki eski next cümleleri üretim checkpoint'leridir. Güncel iş ana TERMS ve READING'dedir. Q20 özel/genel insan/controller kuralları, Q24 kanıt uygulaması, Q26–29 sahiplik/koruma/kısmi etki gibi kaynak soruları çözülmüş ilan edilmez; bunlar yeni ürün/literatür kampanyası değildir.

Yayın geri okumasında iki yerel düzeltme yapıldı: akışın ilk adımındaki kabul edilmiş ifadesi, sonuç kabulüyle karışmaması için yürütmeye alınmış olarak daraltıldı; WORK'te olmayan SP70'e atıf, gerçek WORK §4/SP33 ile bu dosyanın SP70 bağlantısına çevrildi. Kayıtların diğer anlamları ve kaynak kimlikleri değiştirilmedi.

N04 ve N05'in bütün onar bölümünden, L04/L05 kayıtlarından ve iki betik/sonuç çiftinin vaka/alanlarından bu parça kontrol edildi. S04'ün U02/U03 ilişkileri WORK'e bağlandı; U07 version-helper ve U08-A yeniden giriş atıfları sonraki kaynak grubunda kalır. Dokuz dosyanın tam okuması bütün 52 dosyanın kalıcı aktarımını tamamlamaz. Sonraki iş U06 yöntem yazımı ve değerlendirmesidir. Kontrol aynı assistant'ın kaynak/pilot karşılaştırmasıdır; bağımsız doğrulama, yeni test koşusu, sıfır atlama garantisi veya ortak tanım kabulü değildir.
