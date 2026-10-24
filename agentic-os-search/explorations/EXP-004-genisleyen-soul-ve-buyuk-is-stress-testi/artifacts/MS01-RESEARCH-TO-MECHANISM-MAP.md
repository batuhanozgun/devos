# MS01 — Araştırmadan mekanizmaya: EXP-004 SOUL bileşimi

**2026-09-21 / Açıklama C / SOMUT KAVRAMSAL BİLEŞİM — REVIEW READY.** Bu belge, [MS01 v0.1 ana taslağının](MS01-SOUL-WORKING-SYSTEM-DRAFT.md) araştırma kökenini ve bir örnek gerçekleştirme düzenini görünür kılar. Yeni SOUL ürünü, kurulmuş paket entegrasyonu, mimari kabulü veya canlı deney değildir. MS01'in K1–K7 sorumlulukları ve P1–P9 tercihleri korunur; aşağıdaki okuyuş onları araştırmadaki mekanizmalarla ilişkilendirir.

**Başlangıç main:** `397a00042171eee39e38ad2b27d4ba72894d4043`. **Güncel kullanıcı yönü:** Foundation/studies'te incelenmiş yapıların bu örnek SOUL'da hangi amaç ve çıktılar için kullanıldığını açıklamak; konuşmayı yalnız ilkelerle değil, EXP-004'e özgü somut bir SOUL yapısıyla tamamlamak. Kullanıcı genel/nihai SOUL'u veya implementasyon başlatmayı istemiyor. Bu paragraf yetki özetidir, korunmuş kaynak konuşma arşivine eklenmiş transkript değildir.

## 1. Hangi anlamda bu araştırmalarla oluşturduk?

Bu SOUL'u hazır ürünleri birbirine kurarak değil, araştırılmış mekanizmaların seçilmiş özelliklerini bir çalışma düzeninde birleştirerek kurguladık. Beads kurulmadı; Beads'te incelenen kalıcı iş, hazır iş kümesi ve koşullu sahiplenme deseni kullanıldı. Aynı ayrım diğer ürünler için de geçerli.

Üç katkı türü ayrıdır:

- **Mekanizma uyarlaması:** kaynaktaki işlemin ilişkisi ve akışı taslakta korunur; nesne, alan veya yetki koşulu değişebilir.
- **Sınır/düzeltme katkısı:** araştırma, hangi eşitlemenin yanlış olacağını gösterir. Bu, kaynağın bütün mekanizmasının alındığı anlamına gelmez.
- **EXP-004 sentezi:** farklı girdilerden burada kurulan kayıt/işleyiş bağlantısıdır. Bunun literatürde ilk kez bulunduğu veya tek mümkün çözüm olduğu ileri sürülmez.

A/B kaynak defterleri geçmişte neyin kullanıldığını taşır. Bu harita geçmişi yeniden yazmaz: örneğin Hermes'in kısa indeks→tam içerik yükleme yolu ve gstack'in native PreToolUse bağlantısı bu tur doğrudan kaynakla daha açık eşleştirildi. Önceki genel taslakta bu ayrıntıların aynı açıklıkta seçilmiş olduğu iddia edilmez. Sonradan bulunan benzerlik, tarihsel tasarım kökeni diye kaydedilmez.

## 2. Bu örnekteki SOUL'un somut düzeni

Bu belgeyi okumak için bir örnek bileşim seçiyoruz; evrensel agent sayısı veya deployment topolojisi değil:

| Somut taşıyıcı | MS01 sorumluluğu | Çalışırken ortaya çıkardığı şey |
|---|---|---|
| **Bir Host Runtime ve tek mantıksal ortak-durum yazıcısı** | K6; K7'nin mekanik geçişleri | Aktör/izin bağlama, Run ve claim, korunan durum geçişi, araç etkisi kaydı, yeniden giriş çağrısı. |
| **B0 koordinatör rolü** | K1/K2 ve K4'ün muhakeme kısmı | Mission yorumu, ihtiyaç ve inquiry önerileri, yöntem/aktör seçimi, atama ve ana karara dönüş. |
| **Üretim ve inceleme için ayrı çalışma bağlamları** | K5; gerekli durumda alan araştırması | Soru/metin adayı, ayrı çözüm veya editoryal değerlendirme, QC ve revizyon önerisi. Aynı model kullanılabilir; bu bağımsızlık garantisi değildir. |
| **Kalıcı Working State + asıl kaynak/ürün deposu** | Ortak kayıt yüzeyi; K2/K3/K7 tüketir | Work, karar, Run, kaynak sürümü, açık sorular, candidate/current ayrımı ve geri erişilebilir prose. Belirli DB veya dosya formatı seçilmedi. |
| **İndeksli Method Library ve seçilmiş Working Configuration** | K4 seçer, K3 yükler, host sınırlar | Kısa yöntem tanımı→belirli içerik/sürüm→bu Work'te etkin yöntem ve araç kapsamı. Kütüphaneye yazılan her şey talimat olmaz. |
| **Kullanıcı/owner ve gerçekten sağlanmış diğer insan katkısı** | Amaç/tercih ve verilmiş delegasyonun kaynağı | Gerekli scope veya yaratıcı tercih kararı; ayrıca gerçekten alınmışsa uzman/okur kanıtı. Gizli sürekli teknik işçi varsayılmaz. |

İşe özgü uzmanlık gerektiren araştırma ayrı Work olarak atanabilir; her ihtiyaca kalıcı yeni agent eklemek zorunlu değildir. B0'ın genel muhakemesi başlangıçta vardır varsayımıyla kullanılır; bütün alanlarda yeterli olduğu varsayılmaz. K3'ün kaynak seçimi model ve erişim araçlarının ortak işidir. K7 sürekli çalışan ayrı bir akıl olmak zorunda değildir; değişiklik/kesinti üzerine açılan inceleme ve uzlaştırma işleri olabilir.

Bu örneğin kısa tarifi: **kalıcı iş durumu üzerinde çalışan, yöntemleri gerektiğinde yükleyen, üretici ve inceleyici bağlamlarını ayıran, modelin önerilerini hostun koruduğu yetkili geçişlerle uygulayan SOUL.** Aşağıdaki mekanizmalar bu bütünün parçalarıdır; ürünlerin tüm mimarileri yan yana yapıştırılmamıştır.

## 3. Araştırma → kaynak mekanizma → SOUL'daki kullanım

### M01 — RPD: önkoşul keşfi ve bitmemiş araştırmadan ana işe dönüş

**Kaynak:** [RPD ASSESSMENT §§2–3](../../../research/studies/recursive-prerequisite-discovery/ASSESSMENT.md); bu, özgün eklerin repository değerlendirmesidir. Kaynak ihtiyaç/koşul/yöntem/karar/eylem ayrımını ve odak soru, alternatifler, beklenen alt sonuç, geri dönüş noktası taşıyan keşif sürekliliğini açıklar.

**SOUL'daki kullanım:** K1, amaçtan doğrudan task listesi üretmek yerine eksik koşul veya araştırılacak soru açar. K2 bunu inquiry Work yapar; `return_to` hangi üst karara dönüleceğini taşır. Yönteme özgü önkoşul, hedefin değişmez koşulu sayılmaz.

**Amaç/çıktı:** Kullanıcının gizli önkoşul keşif işçisi olmaması; araştırmadan ihtiyaç adayı, uygulanabilir yöntem seçimi ve ana işe dönüş üretmek. Bankada değerlendirme yöntemini araştıran I1, örnek üretiminin yöntem kararına döner. Romanda anlatıcı mesafesi denemesi, doğrudan final ürün değil yaratıcı seçim girdisidir.

**Aktarım:** Kavramsal yöntem ve süreklilik uyarlaması. Özgün RPD ekleri bu tur yeniden erişilmiş değildir; prototip store'u, hook'u veya bütün mimarisi alınmadı. İpucusuz keşif başarısı açık G01'dir.

### M02 — Beads: kalıcı iş, ready frontier, claim ve liveness

**Kaynak:** [Beads FINDINGS §§1–7](../../../research/studies/beads/FINDINGS.md), [kaynak defteri](../../../research/studies/beads/SOURCE-LEDGER.md). Araştırmadaki native `bd ready`, açık iş listesinden farklı koşullu bir kümedir. `discovered-from` kökeni korur; otomatik blocker değildir. `claim.go` içindeki row-version koşullu yazım, yarışan sahiplenmeyi denetler. Lease/liveness, işin etkisine ilişkin kanıt değildir.

**SOUL'daki kullanım:** K2 kalıcı Work Model'den hazır adayları çıkarır; K4/K3 gerçek aktör, kaynak ve yöntemi bağlar. K6, güncel revision/claim ve kaynak ayırmasını korunan geçişte denetler. K7, kayıp aktörün işini kayıttan devralır; etkisizlik varsaymadan gerçek sonuçla uzlaştırır.

**Amaç/çıktı:** Sohbetten bağımsız iş devamı, aynı işi iki aktörün yetkisiz sahiplenmemesi, kaynak yokken açık işi hazır sanmama. Çıktılar: gerekçeli frontier, geçerli claim/Run ve recovery sırasında açık etki durumu.

**Aktarım:** Araştırılmış koordinasyon deseninin uyarlaması; CAS Beads'in icadı diye sunulmaz. Beads'in hazır-küme koşulları SOUL'un tüm koşulları değildir. Dolt, bütün edge sözlüğü ve Gas Town entegrasyonu seçilmedi. Tek mission commit sınırı da Beads'i kullanmış olmanın otomatik sonucu değil, MS01'in yerel tercihidir.

### M03 — Superpowers: controller, task brief, review ve progress ledger

**Kaynak:** [Superpowers S03 §§2–5](../../../research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md), [S05](../../../research/studies/superpowers/syntheses/S05-native-system-model.md); native `subagent-driven-development/SKILL.md`.

Kaynaktaki controller yalnız sıradaki işi söylemez; task brief'i, ortak kısıtları, ilgili kararları ve rapor yolunu çalışan aktöre taşır. İş sonucu incelemeye döner, kararlar progress ledger'da korunur. Native akış görev incelemesiyle bütün dalın son incelemesini de ayırır.

**SOUL'daki kullanım:** Bu sorumluluğu K2 koordinasyon, K3 context ve K5 üretim/inceleme arasında görünür böldük. B0 ilgili işi seçer; K3 Work Brief/Scene Brief kurar; üretici candidate verir; inceleyen QC veya problem bildirir; yetkili karar K6'dan geçer. K7 yeniden girişte kayıtlı ilerleme ve dayanağı okur.

**Amaç/çıktı:** Her aktöre bütün konuşmayı vermeden gerekli anlamı taşımak; DONE mesajını kabul saymamak; tamamlanan işi yeni oturumda kör tekrar etmemek. Çıktı bir görev paketi, ürün adayı, değerlendirme ve kapsamlı karar kaydıdır.

**Aktarım:** Göreve bağlı devir ve review çevrimi uyarlanıyor. Her göreve zorunlu yeni agent, aynı fix-round sayıları, otomatik temizlik veya kaynakta controller'a verilen bütün takdir kopyalanmıyor. Native skill'in iddiaları gerçekleşmiş SOUL yeterliği değildir.

### M04 — OpenSpec: proposed change, current spec ve yaşayan artefaktlar

**Kaynak:** [OpenSpec FINDINGS §§1–10](../../../research/studies/openspec/FINDINGS.md). `specs/` ile `changes/<change>/` ayrıdır; proposal/delta-spec/design/tasks farklı içerik rolleri taşır. Artefakt üretim readiness'i ile apply readiness ayrı; dosya varlığı anlamsal kabul değildir. Plan ve tasarım yürütme sırasında geri beslemeyle değişebilir.

**SOUL'daki kullanım:** K1/K7'nin Change Proposal'ı current Mission veya seçilmiş tasarımı sessiz değiştirmez. Revision Package, aday tasarımı eski dayanakla ilişkilendirir. Seçilmiş tasarım, gerçekten yazılmış eser ve teslim kararı ayrı kalır.

**Amaç/çıktı:** Romanın B motivasyonunu inceleyebilmek fakat A metnini bir anda B'nin tamamlanmış eseri saymamak. Çıktı: aday değişiklik, etki/revizyon işleri, seçilmiş Design Baseline ve değişiklik tamamlanınca yeni Assembly Snapshot.

**Aktarım:** Aday/mevcut ayrımı ve yaşayan plan yaklaşımı; OpenSpec klasör yapısı veya default workflow'u değil. Assembly Snapshot ve teslim birleşimi OpenSpec'ten birebir alınmış nesneler değildir; EXP-004 sentezidir. Beads ready ile OpenSpec artifact ready aynı mekanizma diye birleştirilmez.

### M05 — gstack: farklı incelemeler ve teslim anında qualification

**Kaynak:** [gstack review/QA/ship sentezi §§1–3](../../../research/studies/gstack/syntheses/review-qa-ship-delivery-qualification.md). Native `/review`, `/qa-only` ve `/ship` farklı sorular sorar. Araştırma bunu delivery-qualification stack olarak yorumlar; bu ifade araştırmanın sentez adıdır. Ship, ilgili artefaktlara göre kanıtı tüketir veya yeniden üretir; bütün eski workflow'ların sırayla koşulmuş olması aynı şart değildir.

**SOUL'daki kullanım:** K5'in ayrı QC'leri, K6'nın `before_result_admission` ve teslim kararı birlikte çalışır. Gerekli yeterlik türüyle onu sağlayan tarihsel workflow ayrılır. Bankada matematik doğruluğu, amaç/biçim ve öğrenci sonucu; romanda tutarlılık, metnin sunduğu dayanak ve gerçek okur etkisi ayrı kalır.

**Amaç/çıktı:** Yerel veya eski incelemeden doğrudan geniş teslim hükmü çıkarmamak. Çıktı: iddia/sürüm/kullanım bağlı QC, açık eksikler ve exact teslim kararı. Eksik kanıt uygun yeni incelemeyle tamamlanabilir; sırf eski tören yok diye iş beklemez.

**Aktarım:** Değerlendirme yollarını ve teslimde kanıt bileşimini uyarlıyoruz. gstack'in opt-out/konfigürasyonları, yazılım release akışı veya bütün ürün güvencesi taşınmıyor. `Qualification Case` bizim yerel kayıt adımızdır; native gstack sınıfı diye sunulmaz.

### M06 — gstack: araç öncesi hook / interposition

**Kaynak:** [guarded-action sentezi §1](../../../research/studies/gstack/syntheses/guarded-action-security-review.md) ve araştırma pin'indeki `careful/SKILL.md.tmpl`: `PreToolUse` + `Bash` matcher → `check-careful.sh` → allow/ask/deny türü sonuç. Kaynak, oturuma bağlı opt-in ve best-effort sınırını açık taşır.

**SOUL'daki kullanım:** Aynı kontrol türü K6'nın `before_effect` noktasında bulunur: model/aktör araç etkisi ister → host aktör/grant/hedef/payload/basis'i değerlendirir → çağrı geçirilir, bekletilir veya reddedilir. Kaynakta shell tehlike deseni incelenirken burada tam bu etkiye verilmiş izin ve gereken kabul de bağlanır.

**Amaç/çıktı:** Yayımlama veya ortak yazma gibi etkilerin yalnız modelin hatırladığı bir yönergeye bağlı kalmaması. Çıktı izinli etki isteği ya da gerekçeli ret/beklemedir.

**Aktarım:** Hook'un çağrıldığı yer ve araçtan önce müdahale deseni; kaynak güvenlik güvencesi değil. MS01'in atlanamaz effect-boundary hedefi kaynaktaki `/careful`dan daha güçlü bir mühendislik yüküdür. `before_work_start`, `before_result_admission`, `after_state_change`, `on_resume` adlarının hepsi gstack'te varmış gibi söylenmez; bunlar bizim kontrol sözleşmemizdir.

### M07 — Hermes: skill indeksi, seçilmiş içeriği yükleme ve kütüphane yaşamı

**Kaynak:** [Hermes U15-B §§2–8](../../../research/studies/hermes-agent/evidence/2026-09-13-skill-library/ARCHIVE-LEDGER-AND-DISCOVERY.md), [primary rotaları](../../../research/studies/hermes-agent/evidence/2026-09-13-skill-library/DISCOVERY-SOURCES.md). `prompt_builder.py` kısa ad/açıklama indeksini üretir; seçilen beceri `skill_view` ile yüklenir. Liste, dosya, yükleme, kullanım sayacı ve bakım yetkisi farklıdır.

**SOUL'daki kullanım:** Method Library'nin somut okuma yolu: K4 kısa yöntem tanımını aday olarak bulur; K3 seçilen yöntemin belirli kaynak/sürümünü getirir; K4 o Work için uygunluğu ve gerçek araç ihtiyacını değerlendirir; seçilmiş yöntem Working Configuration'a, yüklenen içerik Run context'ine bağlanır. Arama eşleşmesi tek başına etkin kural veya kalite onayı değildir.

**Amaç/çıktı:** Bütün yöntem kitaplığını her çağrıya taşımadan ilgili yönteme erişmek; eski veya yalnız yüklenmiş beceriyi gösterilmiş yeterlik sanmamak. Çıktı selected method binding, gerçek sunulan içerik ve gerektiğinde qualification Work'üdür.

**Aktarım:** A/B'deki genel library/config ayrımı, bu tur indeks→yükleme mekanizmasıyla açık somutlaştırıldı. Hermes'in kısmen ilgili her beceriyi yükleme talimatı, otomatik beceri düzeltme davranışı ve curator'ın bütün arşiv/rollback düzeni aynen alınmadı. Yeni yerel yöntemin baz davranışa geçişi EXP-004'te ayrı yetkili Change Proposal kalır.

### M08 — Context/Memory/Harness ve Re3/DOC: üretime bilgi sağlama

**Kaynak:** [Context/Memory/Harness synthesis §2](../../../research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md); Re3'ün Draft Module'ü, plan ve mevcut hikâye bilgisiyle yakın prose'u yeniden kurulan üretim girdisine bağlar. DOC ayrıntılı outline ile üretim kontrolünü birlikte ele alır; gelecekteki olay bilgisini erken açma riskini de tartışır. Bunlar önceki roman çalışmalarının dış dayanaklarıdır; ayrı studies paketleriymiş gibi sayılmadı.

**SOUL'daki kullanım:** Kalıcı Narrative Ledger asıl metni ikame etmez. K3, yazılacak sahnenin amacı + ilgili seçilmiş tasarım + karakterin o andaki bilgisi + yakın asıl metin + açık sorularla bağlam kurar. K5 devam metnini üretir; ürün yeniden plan/ilişki değerlendirmesine döner. Bu örnekte yaşayan plan korunur.

**Amaç/çıktı:** Yazarı yalnız son konuşma parçasıyla bırakmamak; planın kaydedilmesiyle üretimde kullanılmasını ayırmak. Çıktı Scene Brief/Context Package, yeni prose ve gerekirse yaratıcı değişiklik önerisidir.

**Aktarım:** Tekrarlanan bağlam kurma ve plan–üretim bağı uyarlanır. Re3'ün tüm reranker/edit modülleri veya DOC'nin eğitilmiş token-düzeyi controller'ı seçilmedi. DOC controller'ı K6 yetki kapısı değildir. Reading Pass ve plan-aware/text-grounded inceleme, T14/DQ02'nin EXP-004 sentezidir; Re3/DOC'nin hazır reader motoru diye sunulmaz.

### M09 — Leantime: teslimat ilerlemesi ve amaç sonucu

**Kaynak:** [Leantime FINDINGS §§1–5](../../../research/studies/leantime/FINDINGS.md). Goal/metric, milestone ve executable task ilişkili fakat farklıdır; goal ilerlemesi milestone tamamlanma yüzdesine indirgenmez.

**SOUL'daki kullanım:** K2, Work/teslimat durumunu ve Mission'ın amaç hakkındaki kanıtını ayrı taşır. QC ve Decision bu iki soruyu tek DONE durumuna eritmez.

**Amaç/çıktı:** İki örnek sorunun iç incelemeye teslimiyle yıllık programın veya öğrenme sonucunun tamamlanmasını karıştırmamak; romanda sahnelerin bitmesini bütün eser başarısı sanmamak. Çıktı: tamamlanan kapsam, gerçek teslim durumu ve hâlâ açık amaç kanıtı.

**Aktarım:** Hedef–teslimat ilişkisinin uyarlaması. Leantime'ın tüm sprint/program yapısı veya edebî kaliteyi yüzdeleştiren bir skor kullanılmadı.

## 4. Foundation bu bileşimin neresinde?

Foundation yalnız genel kontrol listesi değildir; bu taslakta aşağıdaki ilişkilerin ne anlama geldiğini belirginleştiren girdidir. Bununla birlikte bir araştırma dalı otomatik bir servis olmaz.

| Foundation girdisi | MS01'de somut karşılık | Örnek sonucu |
|---|---|---|
| **Work + Actors + Environment** | Work/Run/rol/yetki ve gerçek araç/çalışma koşulları ayrı kayıt ve geçişlerle taşınır. | Rol yaratmak çalışan araç veya yeterli uzmanlık yaratmaz; frontier aktör/ortamla birlikte değerlendirilir. |
| **Information State ve Use-Conditioned Selection** | Kaynak, özet, karakter inancı, tasarım kararı ve fiilen sunulan context ayrıdır. | Aynı kaba özetle gizlenen mektubu kimin gördüğü ayrımı, K3/K5'te asıl pasajları birlikte getirme işine dönüşür. |
| **Binding / Composite Standing** | QC'nin nesne/sürüm/birleşim/kullanım/ölçüt bağı; Decision'ın ayrı yetkisi. | Doğru soru, onaylı soru ve yayımlanmış soru aynı durum değildir. Her QC'nin Foundation anlamında composite olduğu da iddia edilmez. |
| **Revision M1/M2/M5** | K7 destek bağını, değişen basis'i, korunacak içeriği ve yeniden değerlendirmeyi taşır. | Derya'nın motivasyonu değişince aynı davranış metni korunabilir, fakat eski edebî gerekçesi otomatik korunmaz. |
| **Transition / Persistent Adaptation** | Run ile etki; Method Entry ile etkin configuration ve kalıcı davranış ayrılır. | Zaman aşımı etkisizlik değildir; ders kaydı yöntemin öğrenildiği veya başka işte faydalı olduğu anlamına gelmez. |

Doğrudan bu tur geri açılan ayrıntılı dayanaklar: [Composite Standing STATE](../../../research/soul-foundations/05_relation-control-composition/composite-standing/STATE.md) ve [Revision M5](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/derivation-transformation/maintained-information-revision/M5-SYNTHESIS-DECISION-AND-PARENT-DELTA.md). Diğerlerinin önceki doğrudan okuma ve reuse kapsamı A/B ve DQ kaynak defterlerinde korunur. [Foundation STATE](../../../research/soul-foundations/STATE.md) accepted/historical durumunu; [REUSE](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md) derin kaynak rotalarını verir. M5'in eski proposal başlığı güncel kabul altında tarihsel checkpoint'tir.

## 5. Birlikte çalışan örnek: romanda yeni gerekçe bulunması

Yeni motivasyon ortaya çıktığında K1, RPD'den uyarlanan sorguyla hangi önceki ilişkinin yeniden inceleneceğini açar. K2 bunu kalıcı Work ve `return_to` bağına dönüştürür; Beads'teki köken/bağımlılık ayrımı korunur. K4, ilgili inceleme yöntemini kısa kitaplık görünümünden seçer; K3, Hermes benzeri seçilmiş yüklemeyle yöntem içeriğini ve ilgili asıl pasajları sağlar.

Üretici ve inceleyici, Superpowers'tan uyarlanan görev/rapor sınırlarıyla çalışır. Üretimde Re3/DOC'den beslenen plan–yakın prose bağlamı kullanılır. Yeni yön, OpenSpec'teki öneri/current ayrımına benzer biçimde Change Proposal olarak kalır; tasarım kararı verildiğinde metnin fiilen değişmesi için Revision Work açılır.

K7, Foundation Revision'ın koruma/destek ayrımıyla gereksiz metin kaybını önlemeyi hedefler. İnceleme sonuçları gstack'in farklı qualification yollarını örnek alan ayrı QC'lere dönüşür. K6'nın etki kapısı, yalnız doğru birleşim için verilmiş yetkili teslimi geçirir. Bütün sahneler teslim edilse de Leantime'daki hedef/teslimat ayrımı nedeniyle edebî veya gerçek okur etkisi ayrı hüküm kalır.

Bu akışta ürünler birbirlerinin API'sini çağırmıyor. Tek kurgusal SOUL'un kayıt, model ve host mekanizmaları, seçilmiş araştırma özelliklerini beraber gerçekleştiriyor. Soru-bankası için aynı omurga korunur; roman yazım yöntemi yerine soru üretimi, ayrı çözüm, hesap kontrolü ve uygunluk incelemesi bağlanır. Bu yüzden ortaya çıkan şey bir ürün listesi değil, belirli bir işleyen bileşim taslağıdır.

## 6. Kendi sentezimiz ve bilerek alınmayanlar

**MS01'in yerel sentezi:** B0 bootstrap rolü ve ilk grant; K1–K7'ye sorumluluk dağılımı; mission başına tek mantıksal commit yolu; QC/Decision/Run bağları; beş kontrol noktası; Assembly Snapshot, Design/Delivery ayrımı; Reading Pass/Open Threads; Narrative Ledger'ın kaynak/statü disiplini; yeni katılımın context/etki/recovery kapsamına birlikte bağlanması. Bunların benzerleri başka sistemlerde bulunabilir; burada özgünlük patenti veya kaynaklarda yokluk iddiası yoktur.

**İsim benzerliği sınaması:** [Gas Town META](../../../research/studies/gastown/META.md)'daki Hook, aktöre iliştirilmiş iş kuyruğu/pinned bead rolünü taşır. MS01'in `before_effect` hook'u ise çağrı öncesi müdahale noktasıdır. Aynı sözcük ikisini aynı mekanizma yapmaz. Gas Town bu tur isim/işlev karşılaştırması için geri çağrıldı; Mayor/Witness/Deacon/Refinery topolojisi mevcut SOUL'un alınmış bileşen listesine eklenmedi.

OpenSpec ve Beads'in iki ready anlamı da korunur. Yöntem kütüphanesi bulunması bütün Hermes'in alındığını; generic effect broker bulunması gstack'in bütün güvenlik/host özelliklerinin alındığını göstermez. RAG, knowledge graph, vector DB, fine-tuning veya belirli bir framework bu taslağın seçilmiş altyapısı değildir. Onlara ileride gerek duyulması mümkün; mevcut düzene sonradan eklenmiş gibi anlatılmaz.

## 7. Okuma, kanıt ve süreklilik sınırı

**Bu tur:** AGENT güncel main'den tam yeniden okundu (`aea3dd845e0f0bbcfb34465edb23782e99f95c80`); R01–R09 bu konuşmada önceden tam okunmuş canonical sürümleriyle etkin kaldı. Güncel main yukarıdaki ref'te doğrulandı; EXP-004 STATE tam yeniden okundu. INDEX, RV01, MS01 B'nin ana taslağı/romanı/kapsamı ve banka A, aynı konuşmanın önceki tam canonical okumalarıyla kullanıldı; hepsi bu tur yeniden fetch edilmiş sayılmaz. T/S/DQ kaynakları kendi gerçek önceki okuma sınırlarını korur.

Yeni doğrudan repository okumaları: CATALOG 17–46 seçici; RPD META tam, ASSESSMENT 1–140 isteğinde görünen §§1–5 seçici; gstack META tam, INDEX 1–110, guarded-action 1–130 ve review/QA/ship 1–145 seçici; Hermes META tam, U15-B 1–140 isteğinde §§1–7 ve §8 başlangıcı, DISCOVERY-SOURCES tam; Superpowers S03 tam; OpenSpec FINDINGS 1–170, Leantime FINDINGS 1–150 seçici; Foundation global STATE/REUSE, Composition INDEX, Composite Standing STATE, Derivation INDEX ve M5 tam; Gas Town META 1–100 seçici. Tam çıktı dönmeyen bir istek full read sayılmadı. Önceki META/STATE kabul sınırlarıyla kullanılan paketlerin eski pending etiketleri yeni kuyruk yapılmadı.

**Bu tur primary kod/metin dönüşleri:** gstack `careful/SKILL.md.tmpl` @ `0d1bd5616c0ef096bb7ccee336f63c60ee408618`, 1–100/EOF tam, blob `8fba18fb0bc699d68058bb569a55a2aa535ebb93`; Hermes `agent/prompt_builder.py` @ `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, 1210–1325 seçici, blob `2f3608249845d3f19e78adc60778444d79275eb2`; Superpowers `skills/subagent-driven-development/SKILL.md` @ `b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, 1–135 seçici, blob `aac35b91c07af15eca580a205eb0c894b86e87c8`. Kaynaktaki talimat dili bu araştırma assistant'ının davranış yetkisi değildir. Dosyalar çalıştırılmadı; bütün çağrı/host/dependency kapsamı doğrulanmadı. Beads primary claim kodu A'daki gerçek seçici okumasıyla kullanıldı; yeni koşu yapılmadı.

**Web, 2026-09-21:** [Re3 v3 HTML](https://arxiv.org/html/2210.06774v3) abstract/giriş ve §§3.1–3.4 görünen yöntem metni; [DOC v3 HTML](https://arxiv.org/html/2212.10077v3) §3.1 ve §3.3.1/future-context çevresi doğrudan geri açıldı. Tam paper/ek, şekil, dataset, kod veya deney kampanyası değil. Bu eski yöntemler bugünkü model başarısı veya tam Türkçe roman yeterliği olarak kullanılmadı. PDF kullanılmadı.

**Sonuç:** MS01'in araştırma-beslemeli somut bileşimi açıklanmıştır. A/B'deki tamamlanmış yürüyüşler tekrar yapılmadı; yeni T16/DQ05 veya genel araştırma kampanyası yoktur. G01–G07 kanıt açıkları [mevcut kapsam kaydında](MS01-COVERAGE-AND-OPEN-MECHANISMS.md) devam eder. Kullanıcının bu açıklama talebi MS01'in önceki bilimsel/mimari iddialarını kabul ettiği anlamına gelmez; somut taslak değerlendirmesi kullanıcıya döner.

Yayın kapsamı bu yeni eşleme ile EXP-004 STATE/INDEX yönlendirmeleridir. MS01 A/B ana metinleri, soru-bankası/roman yürüyüşleri, önceki kaynaklar/manifest/onarım, Foundation, studies, concepts, diğer EXP'ler ve agent-control değiştirilmez. Korunmuş 31 kaynak mesajı ve 126 adres sayımı artmaz. Bu not gelecekteki commit/readback'i başarılı saymaz; teknik yayın ile kavramsal/operasyonel doğrulama ayrı kalır.
