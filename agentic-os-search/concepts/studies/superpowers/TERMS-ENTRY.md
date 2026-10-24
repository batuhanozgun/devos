# Superpowers — Giriş, skill seçimi ve host aktarımı

2026-09-19, **B6-T5 / ENTRY-SOURCE-RECORD-COMPLETE / PACKAGE-PARTIAL**. Bu dosya [TERMS.md](TERMS.md)'nin giriş bölümüdür; ayrı araştırma, güncel ürün rehberi veya ortak sözlük değildir. Paket okuma/aktarım durumu [READING.md](READING.md)'dedir. P2 pilotu tamamlanmıştır; bu kalıcı paket henüz tamamlanmamıştır.

## 1. Kaynaklar ve kayıt anahtarı

Araştırma repository'si `batuhanozgun/agentic-os-search`; kaynak ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**. B6-T5 başlangıç main'i **1108a483a811c3d5e22595f99179e51da8479f16** aynı Superpowers paket tree'sini taşır: **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. Araştırmanın incelediği dış ürün ise ayrı kimliktir: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest bağlamı 6.3.0. Bu tur dış ürünün güncel sürümü veya host API'leri yeniden doğrulanmadı.

| Kod | Sabit araştırma kaynağı | Bu kayıttaki rol |
|---|---|---|
| N01 | [notes/U01-entry-routing-and-bootstrap.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U01-entry-routing-and-bootstrap.md) | İstek yolları, bootstrap, shell taşıması ve sınırlı deney yorumu. |
| N01B | [notes/U01B-host-delivery-and-continuity.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U01B-host-delivery-and-continuity.md) | Host aileleri, çağırma, önbellek, tekrar ekleme ve devam sınırları. |
| L0 | [SOURCE-LEDGER.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER.md) | N01/N01B'nin S00–S27 dış kaynak kimlikleri; sonraki U02 kaynakları da var, bu onların mekanizma okuması değil. |
| E01-R / E01-O | [U01 runner](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U01-hook-probes.py) / [kayıtlı çıktı](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U01-hook-probes-results.json) | Araştırmacının betiği ve geçmiş gözlem; bu tur ikisi okundu, çalıştırılmadı. |
| E03-R / E03-O | [U01B runner](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U01B-opencode-probes.mjs) / [kayıtlı çıktı](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U01B-opencode-probes-results.json) | Aynı ayrım; yerel callback deneyi gerçek host oturumu sayılmaz. |
| S02 | [syntheses/S02-availability-runtime-and-distribution.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S02-availability-runtime-and-distribution.md) | Bağımlı sentez; giriş/aktarımı ilişkilendirir. U07 tabanlı dağıtım/görsel kısımlarının kalıcı kontrolü sonraki grupta. |

SP numaraları görünür P2-T1 ve P2-T5 pilot adresleridir; silinmedi veya kavram sayacına çevrilmedi. Kaynak metni ile pilot satırları bu tur karşılaştırıldı. Türkçe açıklamalar kaynak bağlantılı parafrazdır. **Ürüne atfedilen talimat**, **araştırmanın kod/gözlem aktarımı**, **araştırmacı yorumu/ölçütü** ve gerektiğinde **yeni çıkarım açıklaması** ayrı tutulur. Kaynakta OBSERVATION yazması bizim dış kodu bu tur çalıştırdığımız anlamına gelmez. Farklı adlar aynı satırda karşılaştırılabilir; eş anlamlılık kararı değildir.

## 2. Yöntemi taşıyan içerik ve çalışma ortamı

| Pilot adresi / özgün ifade | Bu araştırmadaki karşılık | Kaynak rolü ve sınır |
|---|---|---|
| SP02 — Skill / skill contract | Belirli durumda nasıl çalışılması gerektiğini anlatan talimat ve karar kurallarını taşıyan yöntem birimi. | N01 §3/S04; N01B §2. Ürün prosedürünün aktarımıdır; model ağırlıklarında öğrenilmiş kapasiteyle eşitlenmez. Yazım/yeniden kullanılabilirlik ayrıntıları U06'da ayrıca işlenecek. |
| SP03 — Skill body / full-body invocation | Skill'in adı veya kısa açıklaması değil, asıl talimat gövdesinin çağrılıp görünür hale gelmesi. | N01B §2. Başlangıç skill'inin gövdesi ile işe özgü skill'in gövdesi de farklı içerikler olabilir. |
| SP04 — Skill description | İlgili skill'i keşfetme ve seçmeye yardımcı kısa açıklama. | N01B §2, S02 §1–2. Tam gövdenin eşdeğeri değil; U06'daki yazım tercihi henüz bu bölümden çıkarılmaz. |
| SP05 — using-superpowers / bootstrap skill | Ana aktörü ilgili skill'leri yanıt/eylem öncesinde çağırmaya yönlendiren giriş prosedürü. | N01 §3/S04. Belirli görev için gönderilmiş alt aktör bu skill'den istisna; bütün görev kurallarından muafiyet değil. Kaynak, kullanıcı talimatına skill karşısında öncelik verir; bu kaynak kuralı mevcut assistant'a kontrol talimatı değildir. |
| SP06 — Host | Skill'in keşfedildiği, bağlama ulaştığı ve eylemin hostun araçlarıyla yürütüldüğü çalışma ortamı. | N01B §2; S02 §2. Ortamın sağladığı olanak ile aktörün doğru yorum/uygulaması ayrı. Bu bir genel ürün sınıflandırması değil. |
| SP07 — Adapter / host integration | Ortak yöntemi belirli hostun kaynak, olay, mesaj veya araç düzenine bağlayan kod/yapılandırma. | N01B §2. Her hostta aynı özel enjektör veya aynı runtime garantisi gösterilmiyor. |
| SP08 — Helper / executable helper | Belirli dosya, Git, taşıma veya destek işlemini gerçekleştiren çalıştırılabilir yardımcı. | CORE §1 ve L0. Talimat gövdesinden farklı nesne. Burada seçili başlangıç betiği ve adapter var; bütün yardımcı ailelerinin aktarımı bitmiş değil. |

SP01'in bütün-yapı açıklaması ana TERMS'te bulunur. Skill, host, adapter ve helper'ın birlikte anılması bunları tamamen ayrık ontolojik kategorilere dönüştürmez; bu kaynak içindeki görevleri ayırır.

## 3. Bulma, çağırma, taşıma ve kontrol

| Pilot adresi / özgün ifade | Yerel karşılık | Kaynak / niteleyici |
|---|---|---|
| SP09 — Discovery / native discovery | Kullanılabilir skill'in bulunması veya hostun kendi mekanizmasıyla sunulması. | N01 §4; N01B §2. Keşfedilmiş olmak mevcut istekte çağrılmış olmak değil. |
| SP10 — Invocation / skill selection | .a seçim: mevcut istek için ilgili skill'i belirleme; .b invocation: onu çağırma. | N01 §3; N01B §2. Dosyanın listelenmesiyle aynı olay değil. |
| SP11 — Delivery / injection | .a delivery: içeriği tüketiciye ulaştırma; .b injection: belirli mesaj/bağlam yüzeyine ekleme yolu. | N01 §4; N01B §2. Manifestte bildirim, yerel callback çağrısı ve gerçek host tüketimi farklı kanıtlar. |
| SP12a — Event registration | Hangi olayda hangi işlemin çağrılacağının bildirilmesi. | N01 §4/S05. Bildirim, olayın gerçekleştiğini göstermiyor. |
| SP12b — Hook işlemi/betiği | Olayla ilişkili başlangıç işlemini yapan kod/betik. | N01 §4–5/S06/S11. Üretilen çıktının host tarafından kullanılması ayrıca koşul. P2-T5 ayrımı korundu. |
| SP13 — Callback / message transform | Hostun çağırması beklenen kaynak/mesaj dönüştürme işlevi. | N01B §2–3. Yerel işlev çağrısını gerçek host zamanlaması veya tüketimi saymıyoruz. |
| SP14 — Context envelope / wrapper text | Talimat gövdesinin çevresindeki taşıyıcı biçim/metin. | N01 §4–6. Dolu ve geçerli dış biçim, kullanılabilir gövdeyi garanti etmez. |
| SP15 — Wrapper, çalıştırma betiği | Başlangıç betiğini uygun kabuk/ortama yönlendiren çalıştırıcı. | N01B §2/§4, L0/S11. SP14'teki metinsel sarmalayıcı değil. |
| SP16 — Tool mapping | Yöntemin istediği işlemlerin host araçları, roller ve istisnalarla nasıl yürütüleceğini anlatan eşleme. | N01B §5. Salt fonksiyon adı çevirisi değil; kimin çalıştığını veya ilerlemenin nerede tutulduğunu değiştirebilir. |
| SP17 — Fallback | Beklenen araç/olanak yokken alternatif yürütme yolu. | N01B §5. İşin sürmesi, ilk yolun bağlam ayrımı veya inceleme özelliğinin korunduğunu kanıtlamaz. |
| SP18 — Marker / deduplication predicate | .a daha önce eklenmiş içeriği işaretlemesi beklenen metin; .b bu işarete göre yeniden eklememeye karar veren koşul. | N01B §3/§6. Genel işaretin anılması ile gerçek/güncel gövdenin bulunması farklı. |

### Seçilmiş host yolları — kaynak matrisi, güncel kurulum rehberi değil

| Host / L0 kaynağı | Araştırmanın gördüğü yerel yol | Açık sınır |
|---|---|---|
| Claude odaklı shell — S04–S06/S11 | SessionStart bildirimi → wrapper → using-superpowers okuma → iç içe JSON bağlam çıktısı. | Olayın hostta gerçekleşmesi ve yükleyici davranışı deneyde yok. |
| Cursor — S06/S11/S24/S25 | skills/hooks bildirimi, lowercase sessionStart ve snake_case ek bağlam. | Seçilmiş hook dosyasında ayrı compaction kaydı olmaması hostun hiçbir yerde devam sağlamadığı anlamına gelmez. |
| Codex — S07/S08/S18 | Skills yolu ve boş hooks nesnesi; rehberde native discovery/description üzerinden giriş. | Shell yolunu buraya kopyalamayız. Gerçek izin/araç sürümü ve çağırma davranışı bu tur doğrulanmadı. |
| OpenCode — S12/S14 | Config callback ile skills yolu; uygun ilk user mesajına transform ile ekleme; modül önbelleği. | Kaynak ve eski yerel callback gözlemi var; gerçek host oturumu yok. |
| Pi — S13/S14/S19 | Kaynak keşfi; kayıt başına bayrak; olaylarla ekleme ve baştaki compactionSummary mesajlarından sonra yerleştirme. | Özetleri korumak onların sadakatini doğrulamak değil. Kaynak/mocked test aktarımı, canlı Pi koşusu değil. |
| Gemini — S15–S17 | Manifestin GEMINI.md'yi bildirmesi, göreli include'lar ve araç eşlemesi. | Gerçek include açılması ve hostun kullanımı gözlenmiş sayılmaz. |
| Kimi — S23 | sessionStart.skill ve skillInstructions alanlarında giriş/rol eşlemeleri. | Manifest bildirimi, özel JS callback veya gözlenmiş host koşusuyla aynı değil. |
| Hermes — S20–S22 | Kurulum yolu çözümü, kayıt anında içerik oluşturma, skill kaydı, ilk-tur hook'u. | Namespace/fallback path ve first-turn anlamlarının hostta karşılığı açık sınırdır. |

Bu sekiz satır sekiz doğrulanmış host sertifikası değildir. S02'deki Devin ve diğer dağıtım yollarının U07 kaynakları sonraki aktarımda kontrol edilecek. N01B §9'daki Antigravity yol uyuşmazlığı, destek yokluğu kararı yapılmadı.

## 4. Ömür, yeniden yükleme ve devam

| Pilot adresi / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SP19 — Module-scoped cache | İçeriğin yüklenmiş modülün ömrü boyunca saklanması; farklı factory çağrılarının aynı kaydı paylaşabilmesi. | N01B §3; E03-R/O. Tekil host session'ıyla zorunlu aynı ömür değil. |
| SP20 — Registration-time content / closure | Kayıt anında oluşturulmuş içeriğin sonraki hook çağrılarında kullanılması. | N01B §3/S20. Her çağrıda kaynak dosyanın yeniden okunması değil. |
| SP21 — Re-injection | Uygun yeni mesajlara mevcut içeriğin tekrar eklenmesi. | N01B §3/§6. Tekrar eklemek güncel dosyayı yeniden okumak anlamına gelmez. |
| SP22 — Refresh / reload | .a kaynak dosyadaki güncellemenin yeniden edinilmesi; .b yüklenmiş modülün yenilenmesi bağlamları. | N01B §3/§6. Sohbeti baştan başlatmayla eşdeğerlik gösterilmedi. |
| SP23 — Procedure re-entry | Nasıl çalışılacağını anlatan prosedüre yeniden ulaşılması. | N01B §8; S02 §4. Devam eden işin karar ve durumunu tek başına geri getirmez. |
| SP24 — Work recovery | İşin plan konumu, karar, inceleme ve geçerli kanıt durumuyla geri kazanılması. | N01B §8; S02 §4. Giriş fonksiyonlarının bunu sağlamaması, başka Superpowers mekanizmaları olmadığı iddiası değil; U02/U03'e bağlanır. |

N01B'nin dört ayrı ömrü: **kaynak dosya sürümü → yüklenmiş/kaydedilmiş adapter → host oturumu/olayı → tekil mesaj dizisi**. Bunlar zorunlu dört sistem modülü değil, güncellik ve tekrar eklemeyi farklı durumlara bağlayan açıklamadır. Caching, kaynakta olası verimlilik tercihi olarak da korunur; sırf eski içeriği tutmasıyla bütün önbellekler yanlış ilan edilmez.

## 5. İstek yolları ve prosedürün kapsamı

| Pilot adresi / ifade | Kaynağın kullandığı anlam | Sınır |
|---|---|---|
| SP25 — Spike | Yapılabilirlik için önerilen deneme, onay, inceleme ve bulgu/öneri raporu. | N01 §2/S10. Üretilen kod atılabilir denemedir; tutulması yeni istek olarak ele alınır. |
| SP26 — Bounded | Depodaki mevcut ve anlaşılabilir akışta dar değişiklik; kısa sohbet tasarımı/onay sonrası uygulama. | N01 §2. Ayrı yazılı spec/uygulama planı zorunlu değil. Yeni projeyi yalnız tanıdık olduğu için bounded saymama sınırı korunur. |
| SP27 — Architectural | Yeni proje/alt sistem veya önemli yapı/arayüz değişikliği; alternatifler, tasarım, yazılı spec, öz inceleme, kullanıcı incelemesi ve planlama. | N01 §2. Her isteğin tek zorunlu yolu değil. |
| SP28 — Approval | Bu girişte seçilen yolun önerdiği iş/tasarım için istenen onay. | N01 §2. Hazırlık azalsa da onay talimatı korunur. Sonraki bütün etkilere sınırsız yetki veya gözlenmiş kullanıcı davranışı değil. U02/U03/U05'in diğer onayları ayrıca aktarılacak. |
| SP29 — Scope/path upgrade | Yeni karmaşıklıkla daha kapsamlı hazırlık yoluna geçme. | N01 §2. Kaynak iş ortasında daha hafif yola düşürmeyi aynı serbestlikle vermiyor; fiilî doğru sınıflandırma bu tur sınanmadı. |

Üç yol, yazılı plan → SDD gibi tek çizgiyi bütün isteklere yaymayı engeller. N01'in U02'ye bıraktığı görev/plan/çalışma alanı ilişkileri burada tamamlanmış değildir. CORE'un bunları özetlemesi, detay kaynağın kalıcı aktarımının yerine geçmez.

## 6. P2 pilotunun kapanışında eklenen adresler

| Pilot adresi / özgün ifade | Kaynak bağlamındaki kullanım | Dayanak |
|---|---|---|
| SP161 — Process skills | Çalışma yaklaşımını yönlendiren, bootstrap'ın öncelik verdiği skill'ler. | N01 §3/S04. Bütün skill'ler için evrensel taksonomi değil. |
| SP162 — HARD-GATE / mandatory workflow | Güçlü ifadelerle belirtilmiş çalışma yükümlülüğü. | Araştırma METHOD §5; N01 §3. Sözcüğün kendisi mekanik engelleme garantisi değil. |
| SP163a — SessionStart / startup / clear / compact | .1 olay adı; .2–4 seçili shell eşlemesindeki olay durumları. | N01 §4. Yapılandırma adları; bu tur gerçek olay teslimi yok. |
| SP163b — session_start / session_compact / agent_end | Pi adapter'ının ekleme bayrağıyla ilişkilendirdiği ayrı olay adları. | N01B §2–3. Shell adlarının yalnız başka yazımı sayılmaz. |
| SP163c — pre_llm_call / is_first_turn | Hermes'in içerik eklediği çağrı noktası ve koşulu. | N01B §2–3. Koşulun hosttaki bütün yaşam döngüsü anlamı çözülmüş değil. |
| SP164 — Qualified skill name / namespace / alias | Namespaced superpowers:skill-name ile yalın ad/farklı yol gösterimlerinin erişim ilişkisi. | N01B §5; L0/S20/S22. Alias olasılığı ne kesin eşdeğerlik ne de kesin lookup hatasıdır. |
| SP165 — undefined / null / string cache state | OpenCode anlatımında henüz yüklenmemiş, eksik dosya sonucu ve oluşturulmuş içerik durumları. | N01B §3. Bütün memory sistemlerinin genel şeması değil. |
| SP166 — Fail-open / fail-closed | Araştırmanın eksik kaynak/okuma hatasında ilerleme veya durma yollarını nitelemek için kullandığı karşılaştırma. | N01B §4; S02 §6. Bütün Superpowers veya bütün güvenlik kontrolleri için tek kural yok. |

**Yerel alan/işlev adları:** `additional_context`, `additionalContext`, `hookSpecificOutput.additionalContext`, `hookEventName` (N01 §4, E01-R/extract); `config`, `experimental.chat.messages.transform`, `skills.paths`, `parts`, `info.role` (N01B §2/§6, E03-R); `resources_discover`, `injectBootstrap`, `compactionSummary`, `sessionStart.skill`, `skillInstructions` (N01B §2–3). Bunlar ilgili taşıma/kayıt yüzeyinin adları; yeni genel kavram veya güncel host API belgesi değiller. Cursor ortam işaretinin diğerleriyle birlikte bulunduğunda seçilmesi, yalnız incelenen shell dalının önceliğidir.

## 7. Araştırmacının deney ve sonuç dili

| Pilot adresi / ifade | Bu araştırmadaki anlam | Kanıtın sınırı |
|---|---|---|
| SP35 — Fixture / sentinel / mock | .a deney koşulunu kuran geçici yapı; .b belirli içeriği ayırt eden işaret; .c gerçek hostun sınırlı yüzeyini taklit eden nesne. | E01-R/E03-R. Araştırmanın test unsurlarıdır, Superpowers'ın ürün modülleri değil. |
| SP36 — Criterion / observed / result | .a beklenen ölçüt; .b kaydedilen gözlem; .c o ölçüte göre sonuç. | E01-O/E03-O. Aynı PASS farklı ölçütün karşılandığını gösterebilir. |
| SP37 — Mechanism check / health challenge | .a belirli mekanizma davranışını gözleme; .b kullanılabilir başlangıca ilişkin araştırmacı koşulunu sınama. | N01 §5–6; N01B §6; E01/E03. Sağlık koşulları ürüne gizlice yüklenen resmî vaatler değil. |
| SP38 — Oracle negative control | Seçilmiş yanlış örneği kontrolün reddedebildiğini sınama. | E01-R'de yanlış event; E03-R'de yalnız marker. Bu tek karşı örnek bütün ölçütleri geçerli kılmaz. |

**E01 geçmiş kaydı:** dört taşıma/fixture koşulu PASS, iki eksik/boş gövde sağlık koşulu FAIL, bir yanlış-event negatif kontrolü PASS. Bunlar yeni testlerimiz değil. Betik JSON biçimini, tekil marker'ı ve sondaki newline'lar çıkarıldıktan sonraki fixture içeriğini sınar; dosyanın her baytının taşındığı iddiası yok. Sağlık koşulu bakımından `exit_code: 0`, kullanılabilir gövde bulunduğunu söylemez.

**E03 geçmiş kaydı:** sekiz mekanizma kontrolü PASS, iki sağlık koşulu FAIL, bir negatif kontrol PASS. `cached_old_content` kontrolü V2 yazıldıktan sonra aynı modülün V1'i vermesini bekler. Buradaki PASS güncellik başarısı değil, belirtilmiş önbellek davranışının gözlenmesidir. `fresh_module_reads_update` yeni modül kimliğini kullanır; gerçek host session restart'ıyla aynı işlem olarak kaydedilmez. Eksik dosyanın onarılmasından sonraki aynı/farklı modül kontrolleri de bu ömür ayrımını taşır.

`EXTREMELY_IMPORTANT` yalnız anıldığında eklemenin baskılanması ve boş içerikte `ALREADY LOADED` yazısı oluşması, N01B'nin belirli callback/fixture gözlemleridir. Kaynağın yerel açıklaması korunur; biz burada yeni kök-neden teşhisi, yaygınlık ölçümü veya düzeltme yapmadık. Genel kullanıcı etkisi ve gerçek host davranışı ayrıca açık. Kaynağın S26/S27 test okumaları bu tur upstream suite koşusu sayılmaz.

## 8. Kaynak-içi ilişki görünümü ve kalan kapsam

**Yöntem içeriği → hosta özgü keşif/taşıma → modele görünür içerik → uygun skill seçimi/çağırma → host araçlarıyla eylem → sonuç.** N01 §4, N01B §2 ve S02 §1'in açıklayıcı ilişkisi; her ok ayrı modül veya otomatik garanti değildir.

**Ayrı devam sorusu:** hangi yöntem içeriği etkin? Hangi işin hangi karar/kanıt durumu geri kazanıldı? N01B §8'in ayrımı SP23/SP24'tedir; ikinci soru U02 ve sonraki notlarda açılır. Dört ömrün veya farklı host yollarının üstüne CMH'nin üçlü şeması dayatılmadı.

L0'daki skill adları kaynak kataloğudur: brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills. Listedeki adın varlığı bütün gövdelerin bu tur okunması değildir. LLM/model/agent/SDK/framework/inference/effort gibi genel adlar geçer; kaynak burada hepsinin genel sınırını vermediğinden hafızadan sözlük eklenmez.

N01 Q01–Q08 ve N01B Q09–Q12 kaynak araştırmanın tarihsel soru/ilerleme kimlikleridir. Q04/Q05'in görev/bağlam tarafı ve sonraki çalışma yetkileri bu dosyada çözülmüş sayılmaz. Görsel yardımcı, dağıtım, yöntem yazımı ve inceleme döngüsü sonraki kalıcı aktarım gruplarındadır; bu bölümün açılmasına gerekçe olan yeni genel araştırma borcu değildir.

## 9. Aktarım ve değişiklik izi

B6-T5: P2-T1'deki SP02–SP29/SP35–SP38 ve P2-T5'teki SP12a/b/SP161–SP166, kaynak notları ve ilgili betik/çıktılarla karşılaştırılarak kalıcılaştırıldı. SP01 ana TERMS'te. SP30–SP34'ün CORE kaynaklı erken görünümü U02/U03 ayrıntılarıyla birlikte sonraki parçada kontrol edilecek; silinmiş veya genel tanımla doldurulmuş değil.

Korunan niteleyiciler: görevli alt aktörün yalnız bootstrap istisnası; kayıt/çağrı/tüketim; iki wrapper; mapping'in iş düzenine etkisi; modül ile oturum ömrü; yalnız marker ile gerçek gövde; prosedür dönüşü ile iş kurtarma; test toplama başarısı ile ölçütün sonucu. Kayıtlara gerektiğinde alt adres eklemek yeni eş anlamlılık kabulü değildir.

N01 §1–9, N01B §1–10 ve E01/E03 kaynaklarının kullanım karşılıkları bu parçada kontrol edildi. S02'nin girişle ilgili bölümleri bağlandı; U07'ye dayanan kısımları sonraki parçada tamamlanacak. Bütün 52 dosyanın kalıcı aktarımı ve paket son kontrolü açık. Bu kaynak/pilot karşılaştırması aynı assistant'ın çalışmasıdır; bağımsız doğrulama, canlı host deneyi veya sıfır atlama garantisi değildir.