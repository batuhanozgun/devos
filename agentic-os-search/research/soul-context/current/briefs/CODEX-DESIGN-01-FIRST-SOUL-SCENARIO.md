> **29 Eylül 2026 — tarihsel ilk SOUL senaryosu görev önerisi; bugünkü ilk iş değildir.** Aşağıdaki DESIGN-01, küçük örnek seçimi, eski aday dal ve yazma izni 7 Eylül'deki öneriye aittir. Yeni SOUL işi veya backlog'u bu metinden seçilmez; eski öneri yeniden uygulanmaz. Özgün kapsam, kaynak ve kanıt sınırları korunur.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); yeni ürün deposu `soul-system`. Claude Code ve DevOS bu depoyu yalnız okur. Bu tarihi tasarım görevinin bulunması ürün tercihi, kurulum yetkisi veya gerçekleşmiş test değildir.

---

# DESIGN-01 — İlk SOUL kullanım senaryosu ve gözlenebilir başarı koşulları

**Görev ID:** DEVOS-DESIGN-01-2026-09-07  
**Statü:** ÖNERİ; kullanıcı belirtilen sürümü yeni mesajıyla benimsemeden yürütme yetkisi yoktur.  
**Güncel research checkpoint:** `../../STATE.md`.

## 1. Beklenen sonuç

Development OS'nin ilk sınırlı normal araştırma/tasarım işini yürüt: **SOUL'un ilk küçük örneği, hangi somut kullanıcı isteğini hangi gözlenebilir sonuçla karşılamalı?** Kaynaklara dayanan tek kullanım senaryosu ve davranış hedefi öner. Bu, ürün kodu, kabul edilmiş gereksinim seti, nihai mimari veya bütün SOUL yol haritası değildir.

Çıktı, Batu'nun teknik ayrıntı bilmeden şu soruya cevap verebilmesini sağlamalı: “Bu örnek yapılsa, SOUL benden hangi işi almış olacak ve işe yaradığını nasıl anlayacağım?” İlk örnek geniş vizyonun yerine geçmez. Şimdilik gösterilmeyen yetenekler ertelenmiş olarak görünür kalır, ürün kapsamından sessizce silinmez.

Amaç hazırlık mekanizmalarını yeniden sınamak değil, mevcut çalışma düzenini yararlı bir tasarım sonucu üretmek için kullanmaktır. COORD-03 kapanmıştır; yeni-oturum, hash, sandbox, launcher veya gönderim deneyini bağımsız bir işe dönüştürme. Bu görevde senaryo yalnız tasarlanır; örnekte anlatılan işlemleri gerçek sistemlerde gerçekleştirme.

## 2. Kaynaklar ve gerçek başlangıç

Bu brief'i tam oku. Yerel proje girişinden güncel amaç/yetki/durumunu geri kazan. Araştırma tarafındaki `research/soul-context/STATE.md` ve `current/reviews/2026-09-07-coord-03/REVIEW.md` dosyalarını da oku: kapanışın doğrudan uzak erişimi doğrulandı; bellekten tamamen bağımsız başlangıç veya genel işletim kabulü doğrulanmadı.

Beklenen proje kökü `/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`; origin `https://github.com/batuhanozgun/soul-development-os.git`; dal `bootstrap/coordination-entry`; başlangıç HEAD `c1401f4b427886c92363aa553ba9c6a5abc310fb`. Gerçek cwd/kök/ref ve ilgili değişiklikleri gözlemle. Açıklanamayan farkı reset/stash/clean/dal değişimiyle gizleme. Kendi bu görevine ait kayıtlı ilerleme varsa onu başlangıç ihlali saymadan aynı kapsamda değerlendir. Çakışan yazıcıda bağlı yazmayı durdur.

Amaç dayanağı, hedef STATE'nin bağladığı sürümlü `OPENING-VISION-SOURCE.md` ve `DEVELOPMENT-OS-BOOTSTRAP.md`dir. İlki önceki assistant sentezidir; mimari adları kabul edilmiş bileşen listesi değildir. Kaynakların görev için gerekli kapsamını doğrudan oku ve kaydet; yalnız geçmiş sohbet/bellek özetiyle hüküm verme.

Araştırma girişleri: `research/soul-foundations/STATE.md` ve `INDEX.md`; `research/studies/CATALOG.md`. Bunları okuyup yalnız seçilen sorunun gerektirdiği Foundation dosyalarına ve ilgili study META/INDEX/bulgularına derinleş. Özellikle gstack, multi-agent-patterns ve context-memory-harness-engineering adayları karşılaştırma sağlayabilir; hepsinin tamamını okumak veya birini kurmak zorunlu değildir. Bir study'den önemli bir sonuç kullanıyorsan katalog özetinde kalma. Her önemli öneride kaynak bulgusu ile kendi tasarım tercihini ayır.

Görev hazırlanırken Foundation STATE dört temel zemini ve ilgili birleşim sonuçlarını kabul edilmiş; Contrastive / Interventional Causal Effect sonucunu değerlendirme bekler; Feedback / Adaptation hattını inactive gösteriyordu. Güncel statüyü tekrar kontrol et. Tamamlanmamış araştırmayı tamamlanmış temel sayma, Foundation işini veya HERMES araştırmasını bu görevin içinde devralma. Kritik zemin eksikliği varsa ilgili öneriyi koşullu bırak ya da daha az bağımlı senaryo seç; boşluğu uydurma ve bütün araştırmayı otomatik beklemeye alma.

Yeni dış olgu gerekiyorsa mevcut web/GitHub okuma araçlarıyla seçici birincil kaynak araştırması yapabilirsin. Özel içerik/kimlik bilgisini açık arama sorgusuna koyma. Belleği kaynak yerine kullanma; maddi bir belleğe dayanırsan kaynağını ve sınırını ayır. Research AGENT.md / agent/** dosyalarını kendi kontrol zincirine ithal etme.

## 3. Tasarımın cevaplayacağı sorular

Kısa biçimde birkaç makul ilk senaryoyu karşılaştır, sonra birini gerekçesiyle öner. Seçim; kullanıcı değeri, geniş SOUL yönünü temsil etmesi, gözlenebilirlik, mevcut koşullarda ileride sınanabilirlik ve kurulum yükü üzerinden yapılmalı. Geliştirme/araştırma bağlamımıza yakın, düşük etkili bir örnek tercih et; ilave hesap veya ücretli altyapı kurmayı ilk örneğin gizli koşulu yapma.

Seçilen tek senaryoda şunları somutlaştır:

- Kullanıcının vereceği gerçekçi ilk istek ve sonunda elde edeceği somut sonuç.
- SOUL'un kullanıcıdan istemeden üstleneceği çalışma organizasyonu: gerekli bilgiyi, işleri, kabiliyetleri ve katılımı hangi ihtiyaca göre belirleyecek? Bunları sabit modüllere/rol ordusuna çevirmeden anlat. Eksik ve karar-kritik bilgi için insana dönmek meşrudur.
- İnsanda kalan amaç/kapsam/onay kararları ile sistemin teknik seçim alanı. “Yapabilir” ile “yetkilidir” ayrımı.
- Başarıyı ve başarısızlığı ayıracak birkaç gözlenebilir koşul; yalnız iyi rapor veya ajanın “tamam” demesi yeterli olmasın.
- Normal akış ve tek anlamlı değişmiş-koşul örneği: örneğin kaynaklar çelişiyor, gerekli kabiliyet bulunmuyor veya hedef değişiyor. Varsayımsal tasarım örneğini gerçek çalıştırma/test diye sunma.
- Aynı senaryoyu normal tek ajan + iyi görev mesajıyla çözme alternatifi. SOUL'un ek çalışma düzeni gerçekten nerede değer katıyor? Ek değeri henüz gösterilemiyorsa bunu açıkça söyle; sırf SOUL'u haklı çıkarmak için karmaşıklık üretme.
- İlk örnekte kapsanan/ertelenen yetenekler ve öneri yeterince gerekçeliyse bir sonraki uygulanabilir küçük iş. Önerilen sonraki iş bu görevle yetkilendirilmez.

Teknoloji yığını, servis/veritabanı şeması, nihai ürün mimarisi veya kapsamlı yol haritası seçme. Gerekli somut kabiliyetleri söyleyebilirsin; bunları kurulmuş/mevcut kabul etme. Araştırma ilkeleri seçtiğin senaryoyu zorunlu kılmaz; gerekçeni sen üret.

## 4. İşin organizasyonu ve teknik takdir

Kaynak seçimi, işin parçalanması, karşılaştırma, dar araştırma ve taslak düzeltmelerini sen yönet. Rutin alt adımlar için Batu'dan teknik mesaj taşımasını veya onay vermesini isteme. Aynı zamanda amaca/kapsama/yetkiye maddi değişikliği rutin düzeltme gibi ele alma.

Gerekli gördüğünde **en fazla bir mevcut native salt-okur yardımcıya** sınırlı kaynak incelemesi veya öneriye karşı inceleme görevi vermen açıkça kapsam içindedir. Yardımcı dosya yazmaz, başka yardımcı başlatmaz, başka sağlayıcıya geçmez. Sonucunu doğrudan al ve kaynakla benimse/reddet/koşullu bırak. Yardımcı zorunlu bir tören veya bağımsız kabul makamı değildir; gerekli değilse kullanma. Native yol yoksa özel launcher yazma; bağımsız tamamlanabilen tasarım işini bitir ve sınırı belirt.

Tek yazıcı koordinatördür. Mevcut platform onaylarını koru; model/effort/sağlayıcı veya kalıcı ayar değiştirme. Bir çalışma oturumu, yaklaşık 60 dakikalık hedef bütçe; mekanik timeout veya başarı garantisi değildir. Kapanış/devir için pay bırak. Süre/bağlam/kritik kaynak engelinde en iyi desteklenen kısmi sonucu koru, yeni bir kurulum veya sınırsız araştırma projesine geçme.

## 5. İzinli kayıt ve paylaşım

Kullanıcının bu brief'i açıkça benimsemesiyle yalnız şu iki repository yolu yazılabilir:

1. `work/DESIGN-01.md`: esas Türkçe tasarım önerisi, kısa kaynak izi, gerçek görev yetkisi, gerekçe/karşı inceleme, açık noktalar, sonuç ve devir aynı kayıtta.
2. `STATE.md`: mevcut geniş amacı ve eski kabul/deney statülerini değiştirmeden bu güncel işe ve kapanışına yönlendirme.

Ayrı protokol/rol/durum/sonuç belgeleri çoğaltma. Önceki AGENTS.md, .gitkeep, iş kayıtları ve kanıtlar korunur. Bu bir aday tasarım çalışmasıdır; `soul-production`, araştırma/predecessor repoları ve ürün kodu yazma kapsamı dışındadır.

Yerel metin/link/diff kontrolü, bu iki yolun açıkça stage edilmesi ve mevcut `bootstrap/coordination-entry` dalında normal commit/push kapsam içindedir. Gönderimden önce origin kimliğini, private durumunu ve uzak ref'in beklenen geçmişle tutarlılığını yeniden gözle. Yalnız `refs/heads/bootstrap/coordination-entry` gönderilir; en fazla iki içerik/kapanış commit'i ve normal gönderim. Force, main/G0 ilerletme, yeni dal/tag, PR/merge/issue, ayar/izin/credential/paket/servis değişikliği yoktur. Standart platform onayı kullanılabilir; kimlik bilgisi arayıp kopyalama veya güvenlik sınırını aşma yoktur.

Yayını gerçekleşmeden başarılı yazma. Son gerçek uzak HEAD ve exact iki dosyayı geri oku; son teslim kimliğini sohbette ver. Kendi commit kimliğini kendi içine yazmak için yeni kapanış döngüsü açma. Gönderim engelliyse içerik çalışmasını boşa atma: yerel sonucu ve tam engeli mevcut sohbette ver, başka kanala kendiliğinden taşıma.

## 6. Teslim ve dur

Önce teknik olmayan bir Türkçe esas sonuç ver: **“Önerdiğim ilk örnek şu; sana şu işi yaptırmayacak; şunu gözlersek başarılı sayacağız.”** Sonra gerekli gerekçe, kaynak ve açık noktalar. Uzak dosya bağlantıları ile exact HEAD'i ekle; kaynak incelemesi ve varsayımsal akışı yapılmış ürün testi gibi gösterme.

İşin kabul edilebilir çıktısı; seçilmiş ve gerekçeli tek senaryo, açık kullanıcı değeri, uygun daha basit alternatifle karşılaştırma, gözlenebilir koşullar, ertelenen kapsam ve araştırma/öneri ayrımıdır. Erişilebilir kayıt tek başına içeriğin doğru olduğunu kanıtlamaz; sonraki değerlendirme esas öneriye bakacaktır.

Bu tasarım ve izinli kayıt/yayın teslimiyle dur. Seçtiğin senaryoyu uygulamaya, ürün mimarisini sabitlemeye, AGENTS/otoriteyi değiştirmeye, B0/işletim kabulüne, Claude/gstack kurulumuna, G1-R1'e veya gözetimsiz devam zincirine geçme. Aktif yardımcı/yazıcı durumunu doğru kapat; sonraki öneriyi yetkili iş diye yazma.

## Hazırlama gerekçesi ve kaynak sınırı

COORD-03 erişimi tamamlandıktan sonra kullanıcı somut sonraki hareketi sordu. Research-side tercih, yeniden kurulum tasarımı yerine ürün yönüne bağlı küçük bir davranış önerisini ilk normal Development OS işi yapmaktır. Bu bir öneridir; kullanıcının sorusu hedefte bu işi çalıştırmış veya ürün yönünü daraltmış sayılmaz.

Hazırlıkta current bridge STATE, bootstrap bağlamı, hedef dal/STATE, Foundation STATE ve studies CATALOG doğrudan okundu; gstack META/CORE seçici yeniden kullanım için açıldı. gstack'in artifakt, amaçlanan etki/gerçek sonuç ve yetki ayrımları karşılaştırma girdisidir; hazır mimari olarak benimsenmedi ve tüm güncel upstream yeniden doğrulanmadı. OpenAI'nin resmi Subagents belgesi 2026-09-07'de kontrol edildi; mevcut native delegasyon olanağı yeni özel altyapı gerekliliği değildir. Yerel kabiliyet beyanları COORD kayıtlarının sınırlarıyla kalır.
