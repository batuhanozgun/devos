# Ek B — Veri modeli

**Sürüm:** 1.1 (plan 2.1 ile uyumlu) · **Tarih:** 29 Eylül 2026 · **Statü:** [Öneri]. C02'de test projesinde uygulanır; kuralların çalıştığı Ek C testleriyle gösterilir.

**Kaynaklar:** P4 v4 raporu §8–§18 ve §30 (durum eksenleri, hazır olma ve üstlenme, talep-katkı-kullanım, bilgi aileleri, bağlam sözleşmeleri, ilişki sorguları, işlem niyeti, yayın, kurtarma, bileşik ürün, öğrenme); P5 v2 rehberi §7 (nesne tablosu); kurulum planı 2.0 Bölüm 4 ve 6 (bu sürümde eklenen aileler: karar kuralları, gereksiz önkoşul kuralı, öğrenme, sınav koşusu, kullanıcı modeli, kısıt, emek politikası, çıkmaz yol, sızıntı parmak izi).

**Okuyucu:** Kurucu. Alan adları İngilizce, açıklamalar Türkçedir.

---

## 1. Değişmez ilkeler

Bu ilkeler her aile için geçerlidir; bir aile bunlardan birini bozuyorsa tasarım hatasıdır.

1. **Tek yazma yolu.** Ajanlar ve işler yalnız `devos_api` şemasındaki fonksiyonları çağırır. `devos_private` şemasındaki tablolara doğrudan yazma bütün uygulama rollerine kapalıdır (erişim kuralları + yetki kaldırma). Fonksiyonlar tanımlayıcı yetkisiyle çalışır ve çağıranın rolünü kendileri denetler.
2. **Durum ve olay birlikte.** Her durum değişikliği aynı işlem içinde bir olay (`event`) üretir; işlem geri alınırsa ikisi birlikte geri alınır (F06). Aynı değişikliğin birebir tekrarı yeni olay üretmez.
3. **Revizyon.** Anlamı olan her nesne bir `revision` numarası taşır. Güncelleme eski revizyonu değiştirmez; yeni revizyon ve gerekçe üretir. Başka nesnelere yapılan atıflar hangi revizyona yapıldığını taşır.
4. **Kapsam ve revizyon denetimi.** Bir işlem, işin kapsamı ile hedefin ve kaynağın kapsamını ve revizyonunu birlikte denetler. Yalnız birini denetlemek F05 hatasıdır.
5. **Durum eksenleri ayrıdır.** Bir işin yürütme, geçerlilik, kabul ve dış etki durumları ayrı alanlardır; tek bir "bitti" alanı yoktur.
6. **Üç değerli mantık.** Hazır olma ve destek grupları doğru, yanlış ya da bilinmiyor değerini alır. ALL grubunda bir yanlış sonucu yanlış yapar; yanlış yokken bilinmiyor varsa sonuç bilinmiyordur. ANY grubunda bir doğru yeterlidir; doğru yokken bilinmiyor varsa sonuç bilinmiyordur. Boş grup hazır sayılmaz.
7. **Kısa işlem.** Ajanın uzun çalışması boyunca veritabanı işlemi açık tutulmaz. Ajan değişmez bir girdi anlık görüntüsüne dayanır; sonunda kısa bir işlem kabul ya da çatışma üretir. Çatışma çalışmayı çöpe atmaz; sonuç aday olarak korunur.
8. **Kimlik zinciri.** Rol sınıfı, çağrının taşıdığı **ortam belirtecinden** çıkarılır (belirtecin yalnız özeti `env_tokens` tablosunda durur). Bir işle ilgili her etki, `claim` sırasında yalnız o oturuma dönen **üstlenme belirtecini** ister (özeti `assignment` kaydında durur). Oturum kimliği ve rol adı beyandır: kayda yazılır, `declared` olarak etiketlenir, yetki kararı bunlara dayanmaz. Yetki ayrılığı kuralları ortam düzeyinde tanımlanır. Yetki dönemi ayrı bir kavramdır.
9. **Yetki dönemi.** Tek bir küresel `authority_epoch` sayacı vardır. Geri yükleme ve anahtar değişimi dönemi artırır; eski dönemin üstlenmeleri ve izinleri etki üretemez.
10. **Gizlilik sınıfı.** Her bilgi kaydı `public` ya da `private` sınıfı taşır. Özel kaynaktan türetilen içerik varsayılan olarak `private_derived` sınıfındadır; açık depoya DevOS'un kendi sentezi, kaynak kimlikleri ve DevOS'un tasarım belgeleri girebilir; kütüphanedeki araştırma içeriğinden aynen ya da anlamca yakın aktarım ve konuşma dökümlerinden aktarım giremez (plan, K8). İkinci model ailesine yalnız `public` içerik gider.
11. **Silme.** Bir kaynağın saklama izni geri çekildiğinde ham gövde, parçalar, vektörler, arama dizinleri, bağlam paketleri ve türetilmiş alıntılar birlikte ele alınır. Yalnız "silindi" işareti koymak yeterli değildir. Yedekler geri yüklendiğinde güncel saklama politikası yeniden uygulanmadan arama ve bağlam hizmeti açılmaz.
12. **Biçim kapısı.** Veritabanı bir alanın dolu olduğunu zorlayabilir, içeriğinin anlamlı olduğunu değil. Bu tür kurallar `format_gate` diye etiketlenir; içerik denetim ortamında ve örneklemle değerlendirilir.
13. **Dil.** Kayıtların ve alanların dili İngilizcedir; yalnız Batu'nun sözlerinin aslı (`*_original_tr`) ve Batu'ya gösterilen metinler (`*_tr`) Türkçedir. Kütüphaneden gelen kaynaklar kendi dilleriyle saklanır ve `language` alanı taşır.

---

## 2. Veritabanı rolleri ve erişim

| Veritabanı rolü | Kim kullanır | Ne yapabilir | Yapamaz |
|---|---|---|---|
| `devos_kurulum` | Kurucu (A aşaması) | Kurulum işlemleri; C12'de kapatılır | Belirteç üretme |
| `devos_calisma` | Çalışma ortamı | Görev dışındaki iş açma, ihtiyaç ve karar kaydı, üstlenme, katkı ve aday yazma, bulgu, bağlam, öneri, dış etki niyeti | Bağlayıcı hüküm, kabul, sürüm etkinleştirme, kural değişikliğini onaylama, sınav kayıtlarını okuma |
| `devos_denetim` | Denetim ortamı | İnceleme, hüküm, kabul, kural ve kontrol değişikliği incelemesi, yüksek etkili birleşme için yetki onayı, kurtarma aşaması ilerletme | Ürün ve aday yazma, sınav kayıtlarını okuma |
| `devos_sinav` | Sınav ortamı | Sınav görevlerini sıradan iş olarak açma, sınav koşusu ve yeterlik yazma | Ürün yazma, hüküm yazma |
| `devos_ingest` | `devos-backup`'taki aktarım işi | Yalnız kaynak, parça, vektör ve parmak izi yazma | Diğer her şey |
| `devos_ci` | PR kontrolleri ve yayın işi | Okuma: inceleme hükmü, karar, güncel yetki ve dönem, parmak izi eşleşmesi; gözlem yazma | Hüküm ya da karar yazma |
| `devos_backup` | Yedek işi | Salt okuma; yalnız `mark_exported` fonksiyonu | Diğer her yazma |
| `devos_batu` | Yalnız B3 (b) seçilirse: karar paneli | Yalnız kendisine atanmış kararları okuma ve cevaplama | Diğer her şey |

- Ajan ortamlarında Supabase'in gizli (servis) anahtarı bulunmaz; ortamlar herkese açık anahtar ve ortam belirteci taşır. Her `devos_api` fonksiyonu önce belirteci doğrular ve rol sınıfını buradan çıkarır.
- Belirteçler `devos_private.issue_env_token(role_class)` ile üretilir; bu fonksiyonu yalnız proje sahibi (Batu, Supabase panelinden) çalıştırabilir. Fonksiyon belirteci bir kez döndürür ve yalnız özetini saklar. `revoke_env_token` aynı yetkiyle çalışır ve yetki dönemini artırır.
- Her fonksiyonun başında izin verilen roller denetlenir. Rol listesi fonksiyonun tanımında durur ve Ek C'deki yetki testleriyle sınanır.

---

## 3. Kayıt aileleri

Her aile için: amaç, temel alanlar, kurallar, durumlar ve geçişler. "Kim" sütunu Bölüm 2'deki rolleri kullanır.

### 3.1 Mission — yetkili amaç

**Alanlar:** `id`, `revision`, `purpose`, `scope`, `constraints` (Constraint atıfları), `acceptance` (kabul sınırı), `owner_authority` (Batu'nun karar kaydına atıf), `status` (active / paused / closed).

**Kurallar:** Görev ancak Batu'ya ait bir kararla açılır ya da genişletilir. İç işlerin açılması görev kapsamını genişletemez.

### 3.2 Need ve Inquiry — ihtiyaç ve keşif

**Alanlar:** `id`, `mission_ref`, `condition` (neyin eksik olduğu), `origin` (hedefin gereği / seçilen yöntemin gereği / yalnız faydalı), `method_ref`, `why_needed` (**zorunlu**: hangi karar ya da eylem bu olmadan yanlış olur), `evidence_for`, `evidence_against`, `assumptions`, `alternatives` (en az bir alternatif yol ya da "alternatif yok" gerekçesi), `consumer`, `return_to`, `uncertainty`, `status` (open / investigating / resolved / dropped / superseded).

**Kurallar:**
- `why_needed` boşsa kayıt reddedilir (gereksiz önkoşul freni, plan K-1).
- `origin = method` olan bir ihtiyaç, yöntem değişince otomatik olarak yeniden değerlendirmeye düşer.
- Inquiry sonucu `return_to`'ya bağlanır; sonuç dönmeden inquiry kapatılamaz.

### 3.3 Work ve WorkStanding — iş ve durumları

**Work alanları:** `id`, `revision`, `mission_ref`, `mission_revision`, `scope`, `purpose`, `input_refs`, `target_refs`, `consumer`, `return_to`, `stop_rule`, `acceptance_ref`, `impact_class` (routine / high), `effort_policy_ref`, `method_refs`.

**WorkStanding (ayrı eksenler):**

| Eksen | Değerler |
|---|---|
| `execution` | planned, ready, running, waiting, finished, cancelled |
| `qualification` | current, stale, needs_review |
| `acceptance` | proposed, accepted, rejected |
| `effect` | none, prepared, observed, unknown |

**Kurallar:**
- `ready` bir sorgunun anlık sonucudur; üstlenme işlemi aynı koşulları yeniden denetler.
- `execution = finished` iken `acceptance` otomatik `accepted` olmaz.
- Bir işin girdisi değişirse `qualification = stale` olur; eski çıktı silinmez.
- Yeniden açma: dayanağı değişen işler aday inceleme kümesine alınır; otomatik iptal edilmez.
- İptal edilmiş üstlenmenin geç sonucu aday kanıt olarak saklanır, güncel ürüne karışmaz.

### 3.4 Relation — türlendirilmiş ilişki

**Alanlar:** `id`, `type`, `from_ref` (+revizyon), `to_ref` (+revizyon), `scope`, `hard` (hazır olmayı etkiler mi), `group_id` ve `group_mode` (ALL / ANY), `validity` (current / stale / retracted), `use` (hangi kullanım için geçerli).

**İlişki türleri (başlangıç listesi):** `depends_on` (sert bağımlılık), `supports`, `challenges`, `derived_from` (kaynak türetme), `supersedes`, `uses` (katkı kullanımı), `part_of` (bileşik ürün), `reviews`, `blocks_effect`, `about` (açıklayıcı).

**Kurallar:**
- Sert bağımlılıklarda döngü reddedilir; açıklayıcı ilişkilerde döngü serbesttir.
- Aynı ilişkinin birebir tekrarı yeni kayıt ve olay üretmez.
- Bir destek kaynağı bayatlayınca destekledikleri otomatik yanlış sayılmaz; destek yeterliği yeniden değerlendirmeye düşer.

### 3.5 Assignment — üstlenme

**Alanlar:** `id`, `work_ref`, `work_revision`, `declared_session_id` (beyan), `role_class` (belirteçten), `claim_token_hash`, `generation` (aynı iş için kaçıncı üstlenme), `authority_epoch`, `lease_expires_at`, `last_heartbeat_at`, `status` (active / released / expired / revoked).

**Kurallar:**
- Bir iş için aynı anda tek aktif üstlenme olabilir; bu, veritabanı düzeyinde benzersizlik kısıtıyla zorlanır.
- Oturum düzenli yaşam sinyali gönderir; süre dolarsa üstlenme `expired` olur ve iş yeniden hazır olabilir.
- Etki üreten her işlem üstlenme belirtecini ister ve üstlenmenin hâlâ aktif, kuşağının güncel ve döneminin geçerli olduğunu denetler. Aynı ortamdaki başka bir oturum başkasının üstlenmesiyle işlem yapamaz.

### 3.6 Grant — izin

**Alanlar:** `id`, `issuer`, `subject` (rol sınıfı ya da üstlenme), `scope`, `permitted_effects`, `revision`, `expires_at`, `revoked_at`, `authority_epoch`.

**Kurallar:** İzin, işin serbest metninden türetilmez. Geri alınmış izinle hazırlık ya da yeniden deneme reddedilir. Bir işlem makbuzunu okumak, etkiyi yeniden yetkilendirmek değildir.

### 3.7 Request, Contribution, UseReceipt — talep, katkı, kullanım

**Request alanları:** `id`, `sender_work`, `recipient` (iş ya da rol), `requested_contribution`, `parent_decision`, `scope`, `source_depth`, `format`, `urgency`, `deadline_reason`, `return_to`, `status` (sent / accepted / narrowed / rejected / fulfilled / withdrawn).

**Contribution alanları:** `id`, `request_ref`, `content_ref` (ürün ya da bulgu revizyonları), `scope`, `rationale`, `uncertainty`, `intended_use`, `qualifiers`, `limitations`, `status` (candidate / delivered / superseded).

**Alt ajan görev tanımı (`Request` içinde, oturum içi talepler için de):** `objective` ve bağlı olduğu karar, `expected_output_format`, `sources_and_tools`, `boundaries` (yapmayacakları), `effort_budget`, `write_target` (sonucun yazılacağı kayıt), `writer` (bu ürünün tek yazarı mı, yalnız okuyucu mu).

**UseReceipt alanları:** `id`, `consumer_work`, `consumer_revision`, `contribution_ref`, `disposition` (used / used_conditionally / not_used / opened_question), `rationale`, `changed_decision_ref`.

**Kurallar:**
- Kullanım kaydını yalnız tüketici yazar; üretici tüketici adına yazamaz.
- Aynı talebin yeniden teslimi yeni iş başlatmaz; aynı kimlikle farklı içerik çatışma olarak görünür.
- "Cevap geldi" ile "kullanıldı" ayrıdır.

### 3.8 Source, Chunk, Finding — kaynak, parça, bulgu

**Üç ayrı alan (her kaynak ve bulgu için):** `source_type` (foundation / candidate_study / context / exploration / historical_record / archived_report / legacy_repo), `epistemic_status` (observation / user_decision / inference / hypothesis / proposal), `current_authority` (can_open_work / instruction / information_only). Eski bir gerçek gözlem tarihsel bir belgede durduğu için hipoteze dönüşmez; eski bir karar tarihsel olduğu için bugün talimat sayılmaz.

**Gövde okuma:** `read_source(source_ref, revision, span)` kaynağın tam gövdesini ya da istenen aralığını döndürür; gizlilik süzgecinden geçer; okuma `DispatchReceipt` olarak kaydedilir.

**Source alanları:** `id`, `revision`, `origin_repo`, `origin_path`, `origin_commit`, `branch`, `body_ref` (dosya deposundaki gövde), `content_owner`, `kind` (original / derived), `authority_status` (foundation / candidate / context / protocol_input / exploratory / historical / historical_trial / exploratory_note), `privacy_class`, `language`, `retention` (keep / archive / retract), `ingested_at`.

**Chunk alanları:** `id`, `source_ref`, `source_revision`, `span` (başlangıç ve bitiş), `heading_path`, `text`, `tsv_tr`, `tsv_en`, `tsv_simple`, `embedding` (boyutu C04'te seçilen modele göre), `embedding_model`, `privacy_class`, `authority_status`.

**Finding alanları:** `id`, `revision`, `claim`, `source_spans`, `qualifiers`, `counter_evidence_searched` (zorunlu: aranan ve bulunan karşı kanıt ya da "bulunamadı"), `confidence`, `open_questions`, `fresh_until` (değişebilir bilgiler için), `status` (candidate / reviewed / accepted_for_use / stale / withdrawn), `use_scope`.

**Kurallar:**
- Değişebilir bilgi taşıyan bulgu, tarihsiz ya da yalnız ikincil kaynaklı olarak `accepted_for_use` durumuna geçemez.
- Tarihsel statülü kaynaklar arama sıralamasında güncel bilgiyi gölgelemez; sonuçta statüleri görünür.
- Parçaların vektörleri ve dizinleri kaynak revizyonuna bağlıdır; kaynak değişince yeniden üretilir.
- Model değişince bütün vektörler yeniden üretilir; iki modelin vektörü aynı sorguda karıştırılmaz.

### 3.9 ContextRequest, ContextPackage, DispatchReceipt — bağlam

**ContextRequest alanları:** `id`, `revision`, `work_ref`, `assignment_ref`, `target_refs`, `use` (discovery / design / production / review / acceptance / recovery), `mandatory_obligations` (her biri: ne bilinmeli, neden, hangi derinlikte), `access_limit`, `consumer`.

**ContextPackage alanları:** `id`, `request_ref`, `request_revision`, `obligation_coverage` (her zorunlu ihtiyaç için kaynak parçaları), `unmet_obligations`, `view_ref`, `view_hash`, `unknown_need_checklist_ref`, `cache_key`.

**DispatchReceipt alanları:** `id`, `package_ref`, `session_id`, `runtime_info`, `observed_extra_context` (gözlenebildiği kadarıyla), `limitations`.

**Kurallar:**
- Paketi hazırlayan, zorunlu ihtiyaç listesini kısaltamaz; değişiklik yeni talep revizyonu gerektirir (F02).
- Karşılanmamış zorunlu ihtiyacı olan paket kabul edilmez; eksik için keşif başlayabilir.
- Bütçe daraldığında önce tekrar eden ve karar değeri düşük içerik azaltılır; zorunlu karşı kanıt ve yetki sınırı çıkarılmaz.
- Önbellek anahtarı iş ve kullanım, hedef ve kaynak revizyonları, izin görünümü, rol ve yöntem sürümleri ve dizin sürümünü içerir (Ek G).

### 3.10 Artifact ve Assembly — ürün ve bileşik ürün

**Artifact alanları:** `id`, `revision`, `path`, `commit`, `kind`, `status` (candidate / current / superseded).

**Assembly alanları:** `id`, `name`, `design_baseline` (niyet revizyonu), `working_assembly` (gerçekleşmiş parça revizyonlarının sırası), `delivery_baseline` (kabul edilmiş bütün), `snapshot_id`.

**Kurallar:** Tasarımın değişmesi çalışma halinin ya da teslim halinin değiştiği anlamına gelmez. Her inceleme incelediği anlık görüntünün kimliğini taşır.

### 3.11 Review, Verdict, Acceptance — inceleme, hüküm, kabul

**Review alanları:** `id`, `target_ref` (+revizyon ya da anlık görüntü), `claim`, `criterion` (+sürüm), `use`, `basis_refs` (hükmün dayandığı kaynak, karar ve politika revizyonlarının tam kümesi), `reviewer_declared_session`, `reviewer_role_class` (belirteçten), `independence_level` (same_session / same_model_other_session / other_view / other_model_family / batu_expert), `view_ref`.

**Verdict alanları:** `id`, `review_ref`, `result` (pass / fail / conditional), `evidence_refs`, `objections`, `limits`.

**Acceptance alanları:** `id`, `target_ref`, `accepted_use`, `scope`, `current_evidence`, `residual_decisions`, `owner_authority`.

**Kurallar:**
- İnceleyen oturum, incelenen ürünü üreten ya da değişikliği öneren oturum olamaz.
- Bağımsızlık düzeyi kayıtta durur; kabul iddiası bu düzeyle sınırlıdır.
- Kullanıcının bir tercihi onaylaması teknik bir olgunun kanıtı sayılmaz.
- Bağlayıcı hüküm ve kabul yalnız `devos_denetim` rolüyle yazılır; `devos_calisma` kendi ürettiğini onaylayamaz.
- `basis_refs`, `criterion` ya da `use` değişince hüküm bayatlar ve yeniden kabul gerekir; aynı ürünün başka bir kullanımına eski hüküm otomatik taşınmaz.
- Doğrulayıcı aynı eylemde onarım yapmaz: bir `Review` kaydıyla aynı işlemde hedef ürünün yeni revizyonu yazılamaz.

### 3.12 Operation ve Observation — dış etki

**Operation alanları:** `id`, `idempotency_namespace`, `idempotency_key`, `effect_class`, `target`, `expected_base`, `payload_hash`, `work_ref`, `assignment_ref`, `generation`, `authority_epoch`, `grant_ref`, `read_set`, `status` (prepared / attempted / observed / conflicted / abandoned), `attempts`.

**Observation alanları:** `id`, `operation_ref`, `source` (gözlemin güvenilir kaynağı), `observed_at`, `observed_effect` (applied / not_applied / unknown), `details`.

**Kurallar:**
- Aynı anahtar ve aynı tam niyet: mevcut kayıt döner. Aynı anahtar ve farklı niyet: çatışma (F01).
- Etki anında güncel iş, bağımlılıklar, üstlenme, izin ve okuma kümesi yeniden denetlenir (F08). Hangi bağımlılıkların okuma kümesine gireceği işlem türüne göre sunucu tarafında belirlenir; ajanın yazdığı kısa bir listeye bırakılmaz.
- Gözlemler eklenir, silinmez; sonraki "bilinmiyor" önceki "uygulandı"yı silmez (F07).

### 3.13 Event — olay

**Alanlar:** `id`, `aggregate_type`, `aggregate_id`, `aggregate_revision`, `tx_id`, `event_type`, `payload`, `created_at`, `exported_at`.

**Kurallar:** Olay kimliğinin büyümesi tek başına küresel sıra değildir; dışa aktarım ve izleme işlem kimliği ve nesne revizyonuyla çalışır. Olay kaydı saatlik dışa aktarımın kaynağıdır.

### 3.14 Release — kurallar, roller, yöntemler

**Alanlar:** `id`, `kind` (common_rules / role / method / config), `name`, `version`, `content_ref` (commit), `applicability`, `owner`, `trial_ref` (sınav koşusu), `rollback_to`, `status` (proposed / trial / active / retired).

**Kurallar:** Bir yöntem dosyasının depoda bulunması etkin olduğu anlamına gelmez; etkinlik sürüm kaydıyla belirlenir. Öneren rol aynı sürümü etkinleştiremez.

### 3.15 Competence ve EvalRun — yeterlik ve sınav

**Competence alanları:** `id`, `role`, `task_class`, `model_and_settings`, `tools_and_context_method`, `eval_refs`, `result_summary`, `known_limits`, `retest_triggers`, `valid_for_release`.

**EvalRun alanları:** `id`, `eval_set_id` (yalnız kimlik; içerik `devos-evals`'te), `eval_set_version`, `subject_role`, `subject_release`, `runner_session`, `results` (olumlu ve olumsuz örnekler ayrı), `run_at`.

**Kurallar:** Model, rol metni, araç seti ya da bağlam yöntemi değişince ilgili yeterlik `retest_required` olur. `EvalRun` ve `Competence` yalnız `devos_sinav` rolüyle yazılır ve okunur. Sınav görevleri çalışma ortamına sıradan `Work` olarak açılır; `Work` kaydında görevin sınav olduğu çalışma ortamının göremeyeceği bir alanda tutulur.

**Ortak kanıt zarfı (`EvidenceEnvelope`, bütün kanıtlar için):** `claim`, `target_commit`, `deployment_config_ref`, `criterion_version`, `inputs_ref`, `observations_ref`, `raw_evidence_ref` (özel içerik veritabanında ya da gizli dosya deposunda), `independence_level`, `evidence_layer` (structural / semantic / behavioral), `run_at`. Farklı hedefte ya da sürümde alınmış bir `pass`, yeni kurulumu kapatamaz.

### 3.16 UserModel ve Constraint — kullanıcı modeli ve kısıt

**UserModel alanları:** `id`, `domain`, `level` (expert / knowledgeable / limited), `evidence_original_tr` (Batu'nun Türkçe ifadesi, aynen), `evidence_interpretation_en`, `decision_types_owned`, `updated_at`.

**Constraint alanları:** `id`, `statement` (İngilizce), `statement_original_tr` (Batu'nun Türkçe ifadesi, aynen), `source` (Batu kararı), `kind` (bütçe / araç / kapsam / zaman / diğer), `questionable` (her zaman true), `conflicts` (tespit edilen çelişkiler), `status` (active / revised / withdrawn).

**Kural:** Bir kısıtla işin gereği arasında çelişki kaydedildiğinde otomatik bir Batu kararı açılır (3.17).

### 3.17 Decision — karar

**Alanlar:** `id`, `revision`, `class` (routine / high_impact / batu), `question` (İngilizce), `presented_text_tr` (`batu` sınıfında Batu'ya gösterilen Türkçe metin), `answer_original_tr` (Batu'nun cevabı, aynen), `answer_interpretation_en`, `why_this_owner`, `options` (her biri: tanım, amaç, fayda, bedel, risk), `alternatives_considered`, `single_viable_path_reason`, `premises`, `criteria`, `evidence_refs`, `assumptions`, `reversibility`, `reopen_triggers`, `recommendation`, `recommendation_rationale`, `if_unanswered`, `status` (draft / open / answered / accepted / superseded / withdrawn), `answer`, `answered_by`, `answer_channel_ref`, `answered_at`.

**Kurallar:**
- `high_impact` ve `batu` sınıfı kararlar, alternatif araştırmasının sonucu (karşılaştırılan seçenekler ya da `single_viable_path_reason`, ya da `open_exploration` durumu), ölçütler, kanıt, varsayımlar, `premises` (öncül envanteri), geri alınabilirlik ve yeniden açma koşulları girilmeden `open` durumuna geçemez (biçim kapısı).
- `batu` sınıfı kararın cevabı yalnız Batu'nun kimliğinden gelebilir: B3 (a) seçilirse cevap Batu'nun GitHub hesabından geldiği doğrulanarak işlenir; (b) seçilirse yalnız `devos_batu` rolüyle.
- Yeni karar açılırken ilgili eski kararlar sorgulanır ve kayda bağlanır; eski karar yalnız yeni maddi bilgi ya da değişen hedefle yeniden açılır.

### 3.18 EffortPolicy — emek politikası

**Alanlar:** `id`, `work_ref`, `level` (high varsayılan), `expert_assessment_ref` (uzman değerlendirmesi; hiçbir işte boş olamaz), `reduction_reason`, `approved_by_role_class` (`devos_denetim`), `non_removable_steps` (doğrulama, alternatif araştırması, yüksek etkili işlerde dış kaynak araştırması).

**Kural:** `expert_assessment_ref` ve `non_removable_steps` hiçbir işte boşaltılamaz (biçim kapısı); azaltma yalnız denetim ortamının onayıyla.

### 3.19 DeadEnd — çıkmaz yol

**Alanlar:** `id`, `attempted_path`, `context`, `why_abandoned`, `salvaged_knowledge`, `do_not_retry_unless`, `related_refs`.

**Kural:** Yeni bir iş açılırken benzer çıkmaz yollar aranır ve bulunanlar kayda bağlanır.

### 3.20 Learning — öğrenme

**Alanlar:** `id`, `class` (observation / incident / finding / pattern / failure_class / capability_gap_candidate / capability_gap / good_example / bad_example / eval / method / proposal), `mas_failure_class` (specification / inter_agent_misalignment / verification / none), `statement`, `evidence_refs`, `versions_involved`, `generalization_level`, `applies_when`, `does_not_apply_when`, `status`.

**Kurallar:** Kötü örnek, neden kötü olduğunu taşımadan kaydedilemez. Tek bir güçlü olay `capability_gap_candidate` olarak kaydedilebilir; `capability_gap`'e geçiş yeniden üretim, nedensel ayrım ya da karşı örnek kanıtı ister (olay sayısı tek başına yeterli değildir).

### 3.21 Budget ve Usage — sınır ve kullanım

**Alanlar:** `id`, `surface` (routine_runs / session_usage / supabase_db_size / storage / actions_minutes / second_model_quota), `limit_value`, `limit_source` (hesaptan okunan ya da belge), `observed_usage`, `observed_at`, `reservations`, `uncertainty`.

**Kural:** Bir sınırın belirlenen eşiğine yaklaşıldığında karar kaydı açılır; kapsam sessizce daraltılmaz.

### 3.22 Recovery — kurtarma

**Alanlar:** `id`, `backup_ref`, `restored_into_project`, `authority_epoch_before`, `authority_epoch_after`, `revoked_assignments`, `pending_effects_reconciled`, `reopen_stage` (read_only / candidate / publish), `retention_policy_reapplied`.

**Kural:** Kurtarma kaydı `reopen_stage` sırasını atlayamaz.

### 3.23 LeakFingerprint — sızıntı parmak izi

**Alanlar:** `hash` (özel kaynak parçalarından üretilen kayan pencere özetleri), `source_ref`. İçerik tutulmaz. Yalnız `devos_ingest` yazar, `devos_ci` okur.

---

### 3.24 SessionRecord ve LaunchRecord — oturum ve başlatma

**SessionRecord alanları:** `id`, `role_class` (belirteçten), `declared_session_id`, `routine_ref`, `started_at`, `last_seen_at`, `ended_at`, `handoff_ref` (yapılandırılmış devir kaydı).

**LaunchRecord alanları (acil API tetikleri için):** `id`, `routine_ref`, `reason`, `intent_at`, `returned_session_id`, `result` (started / uncertain / failed / reconciled), `reconciled_by`.

**Kurallar:** Cevabı kaybolan bir başlatma `uncertain` kalır; yeniden denemeden önce oturum listesinde ve `SessionRecord`'da karşılığı aranır. Kör tekrar yasaktır.

### 3.25 ProtocolAudit — düşünme disiplini denetim izi

**Alanlar:** `id`, `work_ref`, `turn_ref`, `role_class`, `protocol_release`, `results` (D1–D9 için: loaded / skipped + reason / unavailable), `recorded_at`.

**Kural:** Gerekli bir disiplin `unavailable` ise ilgili iş aynı turda ilerleyemez.

### 3.26 Premise, FrameReview, MechanismAssumption — çerçeve denetimi

**Premise alanları:** `id`, `design_ref`, `statement`, `origin` (user_decision / source / prior_design / assumption), `still_valid`, `from_scratch_test` (sıfırdan seçer miydik?), `reviewed_at`.

**FrameReview alanları:** `id`, `trigger` (squeeze_signal / major_design / phase_gate), `design_ref`, `counter_design_ref` (mevcut tasarımı görmeyen oturumun tasarımı), `comparison`, `decision_ref`.

**MechanismAssumption alanları:** `id`, `mechanism_ref`, `compensates_for` (modelin tek başına yapamadığı şey), `last_tested_at`, `test_result`, `retest_triggers` (model ya da platform değişikliği).

**Kurallar:** Aynı konuda ikinci bir düzeltme mekanizması önerildiğinde (`Learning.class = proposal` ve aynı `failure_class`) bir `FrameReview` işi kendiliğinden açılır. Büyük tasarım kararlarının `Decision` kaydı `premises` taşımadan açılamaz.

### 3.27 EnvToken — ortam belirteci

**Alanlar:** `id`, `role_class`, `token_hash`, `issued_at`, `revoked_at`, `authority_epoch`.

**Kural:** Belirtecin kendisi hiçbir tabloda ve kayıtta tutulmaz.

## 4. `devos_api` fonksiyonları

Her fonksiyon: izin verilen roller, denetlenen koşullar, ürettiği olay. Başarısızlıkta gerekçeli hata döner ve reddedilen deneme kaydedilir.

| Grup | Fonksiyonlar | Önemli denetimler |
|---|---|---|
| Oturum | `session_brief(role)`, `register_session`, `record_handoff`, `record_launch`, `reconcile_launch` | Rol sınıfı belirteçten; `role` parametresi yalnız hangi rol paketinin yükleneceğini seçer. Belirsiz başlatma kör tekrar edilmez |
| Görev ve ihtiyaç | `open_mission`, `revise_mission`, `record_need`, `resolve_need` | Görev yalnız Batu kararıyla; ihtiyaçta `why_needed` zorunlu |
| İş | `admit_work`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` | Kapsam ve revizyon; görev revizyonuna bağ |
| Hazır olma ve üstlenme | `ready_works()`, `claim(work_id)` → üstlenme belirteci, `heartbeat`, `release` | Tek aktif üstlenme; dönem ve kuşak; etkiler üstlenme belirteci ister |
| İlişki | `relate`, `retract_relation`, `affected_entities(root, limits)`, `explain_paths(root, target, limits)` | Sert bağımlılıkta döngü reddi; sonuç tamlık bilgisi taşır |
| Talep-katkı-kullanım | `send_request`, `answer_request`, `deliver_contribution`, `record_use` | Kullanımı yalnız tüketici yazar |
| Bilgi | `record_finding`, `review_finding`, `search(query, modes, filters)`, `read_source(source, revision, span)`, `ingest_source` (yalnız `devos_ingest`) | Değişebilir bilgide tarih ve birincil kaynak; gizlilik süzgeci önce uygulanır; üç statü alanı |
| Bağlam | `request_context`, `build_package`, `record_dispatch` | Zorunlu ihtiyaçlar kısaltılamaz |
| Ürün | `register_artifact`, `update_assembly`, `snapshot_assembly` | Tasarım ve çalışma hali ayrı |
| İnceleme | `open_review`, `record_verdict`, `accept` | Yalnız `devos_denetim`; `basis_refs` zorunlu; aynı işlemde onarım yok |
| Dış etki | `prepare_operation`, `record_attempt`, `record_observation` | Tam niyet; etki anında yeniden denetim |
| Karar | `open_decision`, `answer_decision`, `link_prior_decisions` | Sınıfa göre zorunlu alanlar; cevap kimliği |
| Öğrenme ve sınav | `record_learning`, `record_eval_run`, `propose_release`, `activate_release`, `rollback_release` | Öneren etkinleştiremez; sınav gerekli |
| Sınırlar | `record_usage`, `budget_status` | Eşikte karar açılır |
| Kullanıcı ve politika | `record_constraint`, `revise_constraint`, `update_user_model`, `set_effort_policy`, `record_dead_end`, `grant`, `revoke_grant` | Emek azaltımı yalnız denetim onayıyla; kısıt değişikliği karar kaydıyla |
| Disiplin ve çerçeve | `record_protocol_audit`, `record_premises`, `open_frame_review`, `record_mechanism_assumption` | Gerekli disiplin yoksa iş ilerlemez; büyük tasarımda öncüller zorunlu |
| Yedek | `mark_exported` (yalnız `devos_backup`) | Başka yazma yok |
| Kurtarma | `begin_recovery`, `advance_recovery_stage` | Sıra atlanmaz; dönem artışı |

---

## 5. Zamanlanmış işler

| İş | Sıklık | Çıktısı |
|---|---|---|
| Hazır iş işaretleme | Her birkaç dakikada | İşlerin hazır durumuna geçmesi (tetik göndermez; oturumlar zamanlanmıştır) |
| Süresi dolmuş üstlenmeler | Her birkaç dakikada | `expired` üstlenmeler, işin yeniden hazır olması |
| Kilitlenme taraması | Saatlik | Bekleme döngüleri için karar kaydı |
| Bayat kayıt ve bağlantı denetimi | Günlük | Bayat bulgular, kırık atıflar için bakım işi |
| Amaç denetimi | Günlük | Göreve bağı zayıf işler için bakım işi |
| Yetenek eksikliği taraması | Haftalık | Tekrarlayan hata örüntüleri için öğrenme kaydı |
| Sınır takibi | Saatlik | Eşik yaklaşınca karar kaydı; routine bütçesi |
| Sessiz başarısızlık örneklemesi | Haftalık | "Tamamlandı" ve "geçti" sayılmış işlerden örneklem için denetim işi |
| Varsayım envanteri sınaması | Aylık ve model ya da platform değişikliğinde | `MechanismAssumption` sınama işleri |
| Kısıt çelişkisi taraması | Her çalışma oturumu açılışında | Koordinatör için kısıt listesi; denetim her incelemede ayrıca bakar |

Sıklıklar başlangıç değerleridir; C06 ve C11'deki gözlemlerle gerekçeli olarak değiştirilir.

---

## 6. Oturum başlatma sözleşmesi

- Olağan akışta oturumlar zamanlanmış routine'lerle başlar (plan Bölüm 6.4); veritabanı tetik göndermez.
- Acil durumlarda (Batu'nun beklenen kararı geldi ve iş bekliyor; kurtarma) yedek bütçeden API tetiği kullanılır. Tetik yalnız iş kimliğini gönderir; oturum asıl bilgiyi veritabanından okur.
- Her tetik `LaunchRecord` olarak kaydedilir; belirsiz sonuç uzlaştırılmadan tekrarlanmaz.
- Her oturum açılışta `register_session` ile kendini kaydeder.
- **Bağımsız izleme:** DevOS bileşenlerinden bağımsız bir yol (örneğin `devos-backup`'ta zamanlanmış bir GitHub Actions işi), son oturum kaydının, son yedeğin ve son içe almanın zamanını denetler; beklenen aralık aşılırsa Batu'ya atanmış bir issue açar. Bu yol, routine'lerin kendini kapatmasını ve Actions dakikalarının bitmesini de fark eder. Ayrıca `agentic-os-search`'te makine hesabının yaptığı her commit'i Batu'ya bildirir (tek yazar ilkesinin gözlemi).

---

## 7. Arama ayrıntısı

- **Kelime araması:** `tsv_tr` (Türkçe), `tsv_en` (İngilizce), `tsv_simple` (dile bağlı olmayan; teknik terimler ve kimlikler).
- **Anlam araması:** C04'te seçilen model; sorgu vektörü oturumun kendi makinesinde üretilir.
- **Birleştirme:** Kelime ve anlam sonuçları sıra tabanlı bir birleştirme yöntemiyle birleştirilir; birleştirme ayarı C04 ölçüsüyle seçilir.
- **Statü:** Sonuçlar otorite statüsünü taşır; tarihsel kaynaklar aynı ilgideki güncel kaynağın önüne geçmez.
- **Devam sorguları:** Sınırlı bir ilişki ya da arama sorgusunun devamı aynı anlık görüntüye (snapshot, revizyon, politika) bağlıdır; bu arada veri değişirse devam bilgisi geçersiz olur ve sorgu açıkça yeniden başlar. Farklı anlık görüntülerden gelen parçalar tek bir "tam" sonuç olarak birleştirilmez.
- **Gizlilik:** Süzgeç aramadan önce uygulanır; bir rolün göremeyeceği sonuçların varlığı da sızdırılmaz. Görülemeyen bölge yüzünden tamlık sınırlıysa bu, içerik açıklanmadan belirtilir.

---

## 8. C02'de kanıtla seçilecek ayrıntılar

Bunlar bu ekte bilinçli olarak açık bırakılmış uygulama ayrıntılarıdır. Her birinde başlangıç önerisi vardır; seçim C02'de, Ek C'deki testlerle ve gerekçesiyle yapılır.

| Konu | Başlangıç önerisi | Neye göre seçilecek |
|---|---|---|
| Eşzamanlılık denetimi | Üstlenmede satır kilidi ve benzersizlik kısıtı; kritik geçişlerde daha sıkı yalıtım | Eşzamanlılık testleri ve hata sıklığı |
| Revizyon saklama biçimi | Güncel tablo + ekleme yapılan geçmiş tablosu | Sorgu basitliği ve boyut |
| Vektör dizini | Seçilen modelin boyutuna uygun yaklaşık en yakın komşu dizini | C04 arama ölçüsü ve boyut |
| Parça boyutu | Başlık yapısına saygılı, yaklaşık bir iki paragraflık parçalar | C04 arama ölçüsü |
| Ortam belirtecinin veritabanına ulaşma yolu | Claude ortamının API credential özelliğiyle ayrı bir istek başlığında taşınır; `devos_api` fonksiyonları başlığı okuyup özetini `env_tokens` ile karşılaştırır | C01 #3 gözlemi; C02 olumsuz testleri. Başlık yolu çalışmazsa belirteci doğrulayan bir Edge Function kapısı |
