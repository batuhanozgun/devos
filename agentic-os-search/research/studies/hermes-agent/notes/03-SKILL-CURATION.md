# U01-C — Beceri kütüphanesinin bakımı, izin sınırları ve değişiklik kanıtı

**Tarih:** 2026-09-07. **Statü:** SOURCE-GROUNDED PARTIAL MECHANISM NOTE / STATIC REVIEW ONLY.  
**Birincil snapshot:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.  
**İlişki:** [02-BACKGROUND-LEARNING](02-BACKGROUND-LEARNING.md) deneyimden aday bellek/beceri değişikliğine geçişi araştırıyor. Bu not, oluşmuş beceri kütüphanesinin korunması, arşivlenmesi ve birleştirilmesini ayrı bir mekanizma olarak inceliyor. U01'in veya bütün HERMES'in kapanışı değildir.

## 1. Kaynak sürümünü ve mevcut çalışmayı uzlaştırma

Bu ek incelemenin ilk okumaları upstream `d8a07768c5ee59afae62e9fb51d45e1e30aa74da` üzerinden yapıldı. Research main'in `e6bc6cd98e31922c4cfd1c3b46e88c04aec2ca00` sürümündeki mevcut paket geri kazanıldığında birincil pin'in `c4a5de...` olduğu görüldü. İkinci paket veya ikinci kaynak otoritesi oluşturulmadı.

GitHub'ın `c4a5de...` → `d8a077...` commit karşılaştırması bir commit ve beş değişmiş path döndürdü: bir contributor kaydı, `hermes_cli/pt_input_extras.py`, keypad testi ve iki CLI belge yolu. Bu notun kaynakları bu değişiklik kümesinde değildir. Dolayısıyla aynı dosya içeriklerinin birincil pin ile bağlanması mümkündür; **paketin pin'i değiştirilmedi**. Sonraki code-search sonuçları daha yeni bir ref gösterdiğinde yalnız dosya keşfi için kullanıldı; içerik tekrar `c4a5de...` ile istendi. Bu, bütün güncel upstream'in yeniden doğrulandığı anlamına gelmez.

[Karşılaştırma](https://github.com/NousResearch/hermes-agent/compare/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a...d8a07768c5ee59afae62e9fb51d45e1e30aa74da).

## 2. Bulunan mekanizma: tek bir öğrenme döngüsü değil

Kodda en az şu ayrı geçişler görünür:

```text
beceri dosyası + kullanım kaydı + yönetim politikası
  ├─ zaman/kullanım tabanlı otomatik bakım
  │    → aktif / eski / arşivlenmiş durumu
  └─ ayrıca etkinleştirilen LLM birleştirmesi
       → aday içerik değişikliği / hedefe birleştirme / arşivleme
            → dosya etkisi + yan kayıtlar + görev referansları
                 → sonraki işte bulunma ve kullanılma [tam izlenmedi]
                      → gerçekten daha iyi sonuç [doğrulanmadı]
```

**OBSERVATION:** `agent/curator.py` içinde bakım varsayılan olarak etkin, LLM consolidation varsayılan olarak kapalıdır. `run_curator_review` bu iki yolu ayırır. `tools/skill_usage.py` kullanım ve yaşam döngüsünü ayrı kaydeder. **INFERENCE:** otomatik bakımın varlığını otomatik LLM öğrenmesi, LLM'nin metin değiştirmesini de doğrulanmış kalite artışı olarak adlandırmak aşırı güçlü olur. [H18, H19]

## 3. Yönetim yetkisi, dosyanın yazarı ve kullanım aynı bilgi değil

`created_by: agent` alanı ilk bakışta yazarlık kaydı gibi görünür. `_is_curator_managed_record` ve `adopt_skill` ise bunu otomatik bakıma dahil olma politikası olarak kullanır. Kullanıcı tarafından sahiplenilen bir becerinin bu alana geçirilmesi, dosyayı tarihsel olarak ajanın yazdığını kanıtlamaz. Adoption kullanım saatini de sıfırlamaz; zaten uzun süredir kullanılmayan bir beceri bir sonraki bakımda eski sayılabilir. [H19]

Ayrıca `is_agent_created`, `is_curation_eligible`, `is_curator_managed`, `provenance` ve `telemetry_provenance` aynı soruyu cevaplamaz. Örneğin `provenance` yerel elle yazılmış dosyaları da `agent` etiketi altında temsil edebilir; `curated_report` ise politika ve pin durumuna göre daha dar ve amaca özgü bir küme kurar. İsimlere bakıp tek bir sahiplik modeli varsaymak yerine tüketen fonksiyona inmek gerekir. [H19]

**Araştırma değeri:** kaynak kökeni, bakım yetkisi, kullanıcı tercihleri ve gözlenen kullanım için farklı alanlara ihtiyaç olup olmadığına dair somut bir karşılaştırma örneği. Bu örnek SOUL için benimsenmiş veri modeli değildir.

## 4. Otomatik bakımın güçlü ayrımları ve sınırları

`should_run_now` ilk gözlemde hemen bakım başlatmak yerine zamanı kaydeder ve bir aralık erteler. `apply_automatic_transitions`, yeni görülen kayıtsız becerilere başlangıç kaydı bırakır; pin'li veya cron tarafından referans verilen becerileri atlar; çok yeni ve hiç kullanılmamış bir beceriyi sırf kullanım sayısı sıfır diye arşivlemez. Eski hale gelmiş bir beceri tekrar etkin kullanılırsa aktif duruma dönebilir. Bunlar sadece prompt önerileri değil, incelenmiş kontrol akışlarıdır. [H18, H19]

Varsayılan `prune_builtins=True` yolu, paketle gelen becerileri de otomatik arşivleme adaylarına katabilir. Hub ve dış dizin kaynakları ayrı ele alınır. Bastırma kaydı, arşivlenen yerleşik becerinin güncellemede yeniden kopyalanmaması için yazılır; gerçek update-time tüketici bu tur okunmadı. [H18, H19]

**TEST SOURCE INSPECTED:** `tests/agent/test_curator.py` 1–440 aralığında pin koruması, ilk çalışmanın ertelenmesi, cron referansının isim/absolute-path biçimleri, referans verilmemiş eski becerinin hâlâ arşivlenmesi ve hub koruması için test kodu var. Bazıları gerçek geçici jobs/skill dosyalarını ve `cron.jobs` çözümlemesini kullanır. Fixture LLM review'u taklit eder; ayrıca bazı testler built-in pruning'i varsayılan ürün ayarından farklı biçimde kapatır. Testleri okumak koşmak değildir; bu not başarılı test sonucu bildirmez. [H20]

**Açık sınır:** `_cron_referenced_skills` hata durumunda boş küme döndürüyor. `maybe_run_curator` idle kontrolünü ancak çağıran ölçüm sağladıysa uyguluyor. Bu dallar, ilgili bağımlılık hatasında veya çağıran kipinde korumanın nasıl değişebileceğini gösterir; gerçek caller seti, hata koşusu ve canlı sonuç bu tur incelenmedi. [H18]

## 5. Otomatik arşivleme ile LLM mutasyonu farklı izin yolları

`skills/AGENTS.md` özeti bundled/hub becerilerini bakımın bütünüyle dışında anlatıyor. Kullanıcı belgesi ve otomatik bakım kodu ise bundled pruning'i varsayılan olarak açık gösteriyor. Bu pin içinde gerçek bir belge/kapsam uyuşmazlığıdır; zaman içindeki hangi değişiklikten doğduğu araştırılmadı. [H16–H19]

Ancak bundan “LLM her yerleşik beceriyi değiştirebilir” sonucu çıkmaz. `_run_llm_review` bir AIAgent kurar; araç kümesi `skills`, kökeni `background_review`, context/memory yüklemesi kapalıdır ve recursive nudges devre dışıdır. Genel terminal aracı bu constructor'da verilmez. `tools/skill_manager_guards.py` içindeki background guard ise bundled/hub/external veya yönetim politikası bulunmayan hedeflere yazmayı reddeden kurallar içerir. Otomatik arşivleyici doğrudan `skill_usage.archive_skill` yoluna gider; aynı guard yolunu kullandığı varsayılmaz. [H18, H19, H05]

**Henüz çözülmemiş somut gerilim:** curator prompt'una eklenen built-in pruning notu, LLM'nin bundled hedefleri arşivleyebileceğini söylerken background write guard bunları reddeder. Prompt ayrıca bazı prunings için boş `absorbed_into` anlatır; `_curator_consolidation_delete_guard` background delete için boş hedefi reddeder. Bunlar incelenmiş kontrat/guard farklarıdır. Tam dispatcher/batch/apply zinciri okunmadan hangi kullanıcı çağrısında hangi sonucun oluştuğu veya bütün yolların reddi iddia edilmez. [H18, H05, H22 SELECTED]

Aynı ayrım `dry_run` için de gerekir. Otomatik state transitions atlanır; LLM yoluna report-only banner verilir. H20'deki ilgili test, prompt'un bu banner'ı içerdiğini kontrol eder ve bunun modelin `skill_manage` çağırmasına karşı prompt düzeyinde bir kontrol olduğunu açıkça belirtir. Bu test mekanik olarak yazılamayan bir ortamı sınamıyor. İncelenmemiş alt yolların tamamı hakkında containment hükmü yoktur. [H18, H20; H13'teki threat-model ayrımı]

## 6. Değişiklik raporu, içerik koruma doğrulaması değil

`_diff_and_classify` önce/sonra beceri isimlerini karşılaştırır. `_reconcile_classification`, silme anındaki `absorbed_into` beyanını, modelin YAML özetini ve tool-argument içindeki isim referanslarını kullanarak “birleştirildi” veya “budandı” sınıfı üretir. Hedefin var olması ve birleştirme beyanı, eski dosyadaki her gerekli bilgi/parçanın yeni hedefte korunduğunu kendi başına kanıtlamaz. [H18]

Rapor için toplanan tool arguments 400 karakterden sonra kesilir. Uzun bir mutation'ın tüm içeriğini bu rapordan geri kurmak mümkün değildir. Ayrı ledger/blob deposu farklı bir kanıt yüzeyidir; onun tam capture/rollback zinciri burada okunmadı. Dolayısıyla kısa rapor ile tam denetim izi eşitlenmez. [H18, H19]

`bump_use` ve `bump_patch`, tekrar kullanım ile bir patch'ten sonra kullanım gibi olayları kaydeder. Bu görünür ölçüler gelecekte görev başarısı, doğruluk veya faydanın arttığını ölçmüyor. **Sınırlı hüküm:** incelenen bu ölçümler kalite artışının yeterli oracle'ı değildir. Repository'nin hiçbir yerinde kalite değerlendirmesi bulunmadığı iddia edilmiyor. [H19]

## 7. Geri alınabilirlik tek, atomik bir özellik değil

`run_curator_review` mutasyon öncesi snapshot almaya çalışır; snapshot exception'ı loglandıktan sonra otomatik bakım devam eder. Bu yol “yedek alınamadıysa hiçbir şey değişmez” sözleşmesi değildir. [H18]

`skill_usage._relocate` fiziksel taşıma, bastırma kaydı, lifecycle state ve ledger işlemlerini ayırır. Dosya taşıma başarılı olup sonraki best-effort kayıtlardan biri başarısız olabilir. Bu gözlem bütün rollback yollarının çalışmadığı anlamına gelmez; “dosya etkisi oldu”, “kayıt kalıcılaştı” ve “tam geri alma mümkündür” farklı iddialardır. [H19]

Bir başka bağlantı `_write_run_report` içindedir: consolidation sonuçlarına göre cron skill referanslarının yeniden yazılması burada çağrılır. Rapor dizini kurulamazsa bu noktaya ulaşılmaz; rewrite hatası da sonuçtaki error alanıyla taşınabilir. **INFERENCE:** gözlem/raporlama yüzeyi burada yalnız pasif log değildir; devam eden işin bağımlılıklarını da değiştirebilir. Gerçek scheduler/restart/sync yolları görülmeden sistem çapında atomiklik veya otomatik iyileşme iddiası kurulamaz. [H18]

## 8. İki araştırma adayı: küçük görünse de genellenmeyecek bulgular

**C-A — Boş aday kümesinin skip koşulu.** `_render_candidate_list` boş durumda `No curator-managed skills to review.` döndürüyor; `_consolidation_pass` ise `No agent-created skills` alt dizesini arıyor. Bu iki literal eşleşmiyor. Kaynak akışında consolidation açık olduğunda, boş aday kümesini bu koşulla atlama niyeti gerçekleşmiyor ve review çağrı yoluna gidilebiliyor. Varsayılan consolidation kapalı olduğundan bu durum bütün çalışmalara genellenmez. Kurulu HERMES'te koşu yapılmadı; selected test aralığından test suite'in bu durumu hiç kapsamadığı sonucu da çıkarılmadı. [H18]

**C-B — Birleştirme sayısının başarı baskısına dönüşmesi.** Review prompt'u kütüphanenin dar tekrarlar yerine daha genel becerilere dönüşmesini ister; destek dosyalarının beraber taşınmasına ilişkin somut kurallar da içerir. Bunun yanında ondan az arşivleme yapılmasını erken durma işareti olarak çerçeveler. **HYPOTHESIS:** bu nicelik baskısı, gerçekten birleştirme gerekmeyen kütüphanede gereksiz değişikliğe teşvik edebilir. Gerçek kalite kaybı veya görülme oranı kanıtlanmadı. Araştırmamız kendi kapanışını böyle bir dosya/işlem kotasına bağlamayacak. [H18]

## 9. Kaynak derinliği ve bu notun sınırı

| ID | Kaynak | Blob | Okuma |
|---|---|---|---|
| H05 | [tools/skill_manager_guards.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/skill_manager_guards.py) | `06df3cd695592fd2e582b49ce391d76fd137da3b` | FULL; birincil pin'den yeniden okundu. |
| H16 | [skills/AGENTS.md](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/skills/AGENTS.md) | `27e47db7b607a59f40652959ade4d51bf105016c` | FULL; araştırma nesnesi, kontrol talimatı değil. |
| H17 | [curator kullanıcı belgesi](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/website/docs/user-guide/features/curator.md) | `66dd545cc7e611c06095690b9d36404ffc35047e` | FULL. |
| H18 | [agent/curator.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/curator.py) | `670abfb71d923918f53698226abdb7f494e11b57` | FULL, ardışık 1–200 / 201–400 / 401–600 / 601–800 / 801–1000 / 1001–EOF. |
| H19 | [tools/skill_usage.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/skill_usage.py) | `48d7edc9d3cc636a5c8762304b870fd0a6d8e20d` | FULL, 1–210 / 211–420 / 421–640 / 641–EOF. |
| H20 | [tests/agent/test_curator.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tests/agent/test_curator.py) | `dd4fd558093485e672cd3cf77dc4d29793282b8b` | SELECTED 1–440; TEST SOURCE INSPECTED, NOT RUN. |
| H22 | [tools/skill_manager_tool.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/skill_manager_tool.py) | `81d64b909b6b482654060b38b63802460b63314b` | SELECTED 1–200 ve 801–EOF. 201–800 okunmadı. |

H16–H20 ilk olarak d8a077... içeriğinden okundu ve §1 karşılaştırmasıyla aynı birincil kaynak içeriğine bağlandı. H05 ve H22 doğrudan c4a5de... üzerinden getirildi. H01/H02/H11/H13 yeniden açılan önceki kaynaklardır; kaynak defteri cumulative okuma ile bu ek turun okumasını ayırır.

Son H22 201–400 isteği GitHub 429/fail-fast yanıtıyla içerik getirmedi. Bu aralık okunmuş sayılmadı; başka endpoint veya indirme yoluyla sınırın etrafından dolaşılmadı. HERMES kurulmadı, agent/model çağrısı veya test koşusu yapılmadı; upstream'e değişiklik/issue gönderilmedi. Statik self-review bağımsız model araştırması değildir.

## 10. Devam noktası ve bounded sonuç

Sonraki yüksek değerli iş, H22'nin 201–800 aralığını ve oradan ulaşılan batch/dispatch/apply yollarını tamamlamaktır. Şemada `operations` batch biçimi var; curator raporunun düz argüman yorumuyla gerçek ilişki henüz çözülmedi. Başka okuma grubunun bulgusunu bu boşluğu doldurmuş saymayacağız.

Ardından U01'de açık kalan trigger/cancellation, pending replay, ledger/backup ve sonraki session/skill-load yolları izlenir. Curator'ın cron referansı, güncelleme bastırması ve org sync bağımlılıkları ilgili ailelerle bağlanır. Öğrenme kalitesi, tekrar kullanım sayısından ayrı aranır. Bilinen geniş gateway/UI/provider/runtime bölgeleri bu yerel inceleme ilginç olduğu için ertelenmiş küçük ayrıntılara dönüştürülmez.

**Savunulabilir sonuç:** HERMES'te beceri kütüphanesini sürdüren somut politika, kayıt, zaman tabanlı bakım ve isteğe bağlı LLM düzenleme mekanizmaları var. Bunların farklı yetki ve etki yolları bulunuyor; kaynaklar arası bazı açıklama farkları ve araştırılması gereken hata yolları da var. **Henüz savunulamayan sonuç:** bu mekanizmaların birleşimi güvenilir, semantik olarak kayıpsız veya sonuç kalitesini artırdığı doğrulanmış bir öğrenme sistemi oluşturur.
