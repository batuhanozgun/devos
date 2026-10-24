> **29 Eylül 2026 — tarihsel ilk Claude taslağı; bugünkü kurulum planı değildir.** Aşağıdaki topoloji, fiziksel yerleşim, kabul paketi ve “sonraki P4 işi” eski öneridir. Yeni kararın da Claude Code cloud olması bu taslağı yeniden etkinleştirmez. DevOS'un tek geçerli kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır (devir sürümü 2.1); güncel yetki ayrımı [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır.
>
> Özgün teknik öneriler, kullanıcı sınırları, kaynak okuma kapsamı ve dar yerel test kaydı aşağıda aynen korunur. Bunlar yeni hedefte doğrulanmış davranış veya yeni kurulum görevi değildir. Claude Code ve DevOS bu depoyu yalnız okur; ChatGPT'nin bu devirdeki işi [araştırma/kurulum ayrımı bakımıdır](../../../REPOSITORY-TRANSITION.md).

---

# P4-01 — Claude çalışma biçimi ve fiziksel çalışma alanı

**Üst iş:** [WORK/P4](../WORK.md). **Tarih:** 27 Eylül 2026.  
**Başlangıç:** `agentic-os-search@79a748aa7a81473b5f9d4426dc2863f37116e231`.  
**Statü:** INITIAL TECHNICAL BASELINE / CONDITIONAL DESIGN / NOT DEPLOYED. Kullanıcının P3 devir sonucundan sonraki “devam et” yönü P4 tasarımını açtı. Bu dosyadaki teknik tercihler assistant önerisidir; kullanıcı kabulü, hedef Claude yeterliği veya P5 kurulum yetkisi değildir.

## 1. Başlangıç tasarım tercihi

**Bir ana Claude cloud oturumu + adlandırılmış, mesajlaşabilen özel alt ajanlar; kalıcı iş/bilgi için Git ile sürümlenen çalışma alanı.** Ajan takımlarını başlangıç düzeninin zorunlu temeli yapmıyorum.

Ana oturum **DevOS İşletim Koordinatörü / DR06-Y** sorumluluğunu taşır: etkinleştirme, gerçek çalışma durumu, kontrollü kayıt/yayın ve yeniden giriş. **SOUL Geliştirme Koordinatörü / DR06-G ayrı, adlandırılmış görevlendirmedir.** İş önceliği ve katkıların birleşimi G'dedir; ana oturumun çağırma aracına sahip olması bütün ürün kararlarını ona vermez.

Alt ajanları yalnız tek seferlik soru-cevap makineleri olarak kullanma önerisi değildir. Yetkili katkılar karşılıklı soru, araştırma ve inceleme isteyebilir. Var olan alıcıyla doğrudan mesaj; henüz oluşturulmamış veya yeniden atanması gereken rol için Y üzerinden etkinleştirme kullanılır. Roller gerekince çalışır; tüm kadro sürekli açık tutulmaz.

**Bu tercih koşulludur:** Adlandırılmış alt ajanların doğru alıcıyla devamı, cloud'daki gerçek araç/yükleme davranışı ve yazma sınırları hedefte gösterilmeden tasarım uygulamaya hazır ilan edilmez. Bir alternatifin belgede mümkün olması K1/K2'nin sağlandığı değildir.

## 2. Neden bu yol; neyi elemedik?

| Seçenek | Bu görev için değerlendirme |
|---|---|
| Tek genel oturum, roller yalnız sırayla takılan şapkalar | Basit fakat G/Y ve üretici/inceleyici bağlam ayrımı için başlangıç tercihim değil. Ana oturumun her konuya tek hakem olmasını istemiyoruz. |
| Ana Y oturumu + özel, adlandırılmış alt ajanlar | İlk tercih. Rol/araç/girdi sözleşmesini somutlaştırırken kalıcı işin oturumdan bağımsız kalmasını sağlar. Doğrudan katkı alışverişi tasarımın parçasıdır; bütün konuşmaları Y'nin yeniden özetlemesi gerekmez. |
| Ana Y lead + ajan takımı; gerektiğinde izole üreticiler | Güçlü alternatif. Süregelen akran koordinasyonu bu yolda belirgin biçimde daha güvenilir çıkarsa tercih değişir. Ek takım görev durumu bizim kalıcı iş kayıtlarımızın ikinci otoritesi yapılmaz. |
| Bağımsız cloud oturumları / özel dış orkestratör | Bu aşamada gerekçelendirilmedi. Kullanıcının rutin rol tetiklemesini kaldırmak için önce yerleşik yollar değerlendirilir; sınırsız gözetimsizlik veya yeni platform hedefi açılmaz. |

Karar ölçütleri: K1 talep→çalışma→yanıt→kullanım; K2 rutin kullanıcı tetiklemesiz devam; D021 alan düzeni; görev ve oturumdan bağımsız kayıt; sınırlı yazma ve uygun güvence; gereksiz altyapı/bağlam yükünden kaçınma. Sayısal üstünlük puanı veya performans iddiası üretmedim.

**Tercihi değiştiren gözlem:** G koordinasyonu ve uzmanların karşılıklı katkısı seçilen alt ajan yolunda kayboluyor, sürekli yeni kullanıcı mesajı gerektiriyor veya konuşmayı Y üzerinde anlam kaybettirerek yeniden kurmayı zorunlu kılıyorsa takım alternatifi yeniden karşılaştırılır. Yalnız daha çok paralellik veya takım adı yeterli gerekçe değildir.

## 3. Rolün gerçek çalıştırmaya bağlanması

| P2/P3 sorumluluğu | Önerilen çalıştırma ve araç sınırı |
|---|---|
| DR06-Y | Ana cloud oturumu. Çalıştırma/yanıt/bakım kuyruğu ve kayıtların yayımlanması; teknik içerik hükmünü ilgili sahibinden alır. |
| DR06-G | Ayrı adlandırılmış özel alt ajan; ihtiyaçlar, bağımlılıklar, öncelik ve sonuç birleştirme. Mevcut iş kayıtlarını okuyup değişiklik önerir; ürünün bütün alan kararlarını üstlenmez. |
| DR01; DR02/DR03 | Planlama ve alana özel tasarım çağrıları. Alan profili açıkça seçilir; tek evrensel kapasite uzmanı varsayılmaz. |
| DR07/DR08 | Gerektikçe alan bakımı ve bağlam hazırlığı. Üreticiler kendi içeriğinin sahibi kalır. Yeni dosya/bağ/güncelleme önerisi ve kaynak görünümü üretirler; DR07 ürün kararını vermez. |
| DR09/DR10/DR12 | Katılım, gerçek ortam ve yetki ihtiyacı ayrı değerlendirilir. Mevcut kurala göre rutin kontroller küçük mekanik yordamlarla yapılabilir; hüküm gerektiğinde ilgili rol çalışır. |
| DR04/DR11/DR05 | Sınama tasarımı, koşu ve uygulama ayrı görevlendirmeler. Dosya değiştiren/komut çalıştıran üretim, kendi çalışma kopyasında yürür; sonuç aday değişiklik ve kanıt olarak döner. |
| DR13-G ve DR13-Y | Ayrı isimli, üreticinin konuşmasını kopyalamayan inceleme çağrıları. G ürün/iş iddiasına, Y gerçek çalışma ve alan düzenine bakar. Başlangıçta doğrudan dosya yazma ve sınırsız shell verilmez; gerekiyorsa ayrı koşu talep ederler. |
| DR14/DR15/DR16 | Teşhis, yöntem değerlendirme ve araştırma, açık G/Y hedefiyle ihtiyaç üzerine. Yeni kalıcı talimat veya kapsam yaratma yetkisi çıkmaz. |

Her çağrı: **rol + uzmanlık + Work kimliği + hedef/temel sürüm + gerekli kaynaklar + kapsam/yetki + beklenen çıktı + tüketici/dönüş noktası**. İş ve görevlendirme/deneme kimlikleri ayrılır. Alıcı adı tek başına rol kimliği sayılmaz; yeniden atamada eski ve yeni aktör ID'si karıştırılmaz.

Normal uzman/inceleyici için salt-okur araç havuzu önerisi: kaynak okuma/arama, gerekirse WebSearch/WebFetch ve SendMessage. `Bash`'i tutup yalnız Write/Edit'i kaldırmak salt-okurluk sayılmaz. Üreticinin komut yetkisi ayrıca sınırlandırılır. Bir makaledeki veya repo dosyasındaki talimat, DevOS kontrol talimatı olarak benimsenmez.

Motivasyon ayrı otomatik ajan değil, rolün başarı yönü olarak kalır. Tek agent sayısı dondurulmadı: aynı sözleşmenin farklı iş/uzmanlık örnekleri olabilir. Ancak bu taslak G/Y koordinasyonunu ve G/Y güvenceyi ayrı çağrı/bağlam olarak somutlaştırır; bağımsız doğruluk garantisi vermez.

## 4. Önerilen fiziksel yerleşim

**Bir operasyon deposu içinde ayrı `soul/` ve `devos/` alanlarını tercih ediyorum.** Araştırma deposu ayrı kaynak olarak kalır. Hedef repo henüz seçilmedi/oluşturulmadı; aşağıdaki yollar gelecekteki operasyon deposunun tasarım önerisidir, Research reposuna şimdi kurulmaz.

```text
<operasyon-deposu>/
  CLAUDE.md                       # ortak sınırlar, Y açılışı, kısa okuma rotası
  .claude/
    agents/                       # gerçek rol tanımı ve araç sınırları
      development-coordinator.md
      ...                         # gereken adlandırılmış rol/profiller
      product-reviewer.md
      workspace-reviewer.md
    skills/<yontem>/SKILL.md       # yürürlüğe alınmış yeniden kullanım yöntemi
    settings.json                 # gözden geçirilmiş izin/olay bağlantıları
  soul/                           # SOUL ürününün geçerli geliştirme içeriği
  devos/
    MISSION.md                    # hedef, meşru sınırlar ve durma koşulları
    STATE.md                      # kısa current giriş; ayrıntıların kopyası değil
    work/<is-id>.md               # iş, katkı, bağımlılık, açık soru/itiraz
    changes/<degisiklik-id>/       # aday patch, temel sürüm ve inceleme bağları
    knowledge/                    # üretilen bulgu, karar gerekçesi ve kanıt
    references/                   # kaynak adresi/ref ve doğrulanmış okuma rotası
    runs/<deneme-id>.md            # atama/deneme, dönüş ve yayın durumu
    library/                      # yeniden kullanım adayları ve katalog
    archive/                      # yalnız gerektiğinde; current rotanın dışında
  scripts/devos/                  # P5'te gerekçelendirilecek dar kontrol yordamları
  .claude/worktrees/              # geçici üretim kopyaları; Git'e iç içe eklenmez
```

`...` placeholder'dır; boş rol/klasör üretilmeyecek. Rolün etkin tanımı `.claude/agents/` dosyasıdır; ayrıca aynı metnin ayrı `rol.md` kopyası tutulmaz. Aile/DR/GY eşlemesi küçük bir katalog/bağdır, çalıştırma ağacı değildir. Ortak ayrıntılı yöntem aktif skill'e taşınır; rol amacı ve yetki sınırı skill'in tesadüfen yüklenmesine bırakılmaz.

Aktif skill ile `devos/library/` aynı içeriğin iki yetkili kopyası olmaz: library adayı uygun değerlendirmeden sonra aktif kaynağa taşınabilir; katalog oraya işaret eder. Arşiv/yedek, `.claude/agents/` veya aktif skill taraması altında bırakılmaz. Dosya taşınınca ilgili giriş ve bağlantılar da değişir.

İşin kararı/kanıtı kendi iş veya bilgi kaydında tek evde yaşar; runs dosyası bunları tekrarlamaz, kim ve hangi temelde çalıştı bilgisini bağlar. Her mesaja ayrı dosya şartı yoktur. Geçici scratch, atanmış aday değişiklik ve geçerli ürün birbirinden ayrılır.

Research erişimi için ilk tercih bağlı kaynak deposunun salt-okur, ref'i bilinen görünümüdür. Erişim doğrulanmadan bütün birikim yüklenmiş sayılmaz. Gerektiğinde seçili kaynak snapshot'ı orijin/ref ve yenileme kuralıyla tutulabilir; sessiz fork yapılmaz. Research `AGENT.md/agent/**` dosyaları DevOS'a otomatik kontrol kaynağı olarak içe alınmaz.

## 5. K1/K2'nin somut çağrı yolu

1. Kullanıcı yetkili çalışmayı başlatır. Y oturumu `MISSION → STATE → açık iş/itiraz/deneme` yolunu okur; ilk kezse G koordinasyonu, planlama ve gerekli uzmanları hedef/birikimle çalıştırır. Hazır SOUL backlog'u yoktur.
2. İş sahibi bilgi/inceleme ihtiyacını bağlı soruyla açar. Var olan adlandırılmış rol uygun kapsamda doğrudan SendMessage ile yanıtlayabilir. Rol yoksa Y onu oluşturur. Her mesaja iki koordinatör onayı yoktur.
3. Talep ve sonucu yönlendirmede Work/request kimliği, kaynak/target sürümü ve tüketici korunur. Native dönüşün çağıran ajana gitmesi tek başına doğru işin güncellendiği sayılmaz; ilgili kalıcı durum da bağlanır.
4. Alan sahibi yanıtı kullanır veya gerekçeli karşılık verir. G koordinasyonu bağımlı işi açar/bekletir; Y uygun sonraki çalışmayı çağırır. Küçük danışma aynı işte kalabilir; ayrı sahip/bekleme/devir doğarsa ayrı izlenir.
5. Y'nin durma koşulu bütün SOUL'un bitmesi değildir. Yetkili çalışma sınırı, gerçek engel, kullanıcı durdurması veya yeterli devam kaydıyla ara verilebilir. Hazır katkı varken unutulan çağrı tespit edilmeli; sonsuz tekrar kancası kurulmaz.

Mesaj/oturum geçmişi geçici taşıyıcıdır; kalıcı Work kaydının yerine geçmez. Native task list kullanılırsa türetilmiş kısa çalışma görünümüdür, ikinci bağımsız backlog değil. G koordinatörü de dahil kritik hükmün sahibi kayıtta açık kalır; Y sonuçları kendi ürün kararı olarak yeniden yazmaz.

## 6. Paralel üretim ve kontrollü yayın

**Üretim paralel, aynı geçerli branch'e yayın sıralı olsun.** Bu, bütün içeriği tek modelin üretmesi değil; bir operasyon deposu/çalışma episode'unda son değişikliğin kontrollü tek yoldan geçirilmesi tercihidir. Y yayın yolunu işletir; içerik kabulünü üretici ve uygun inceleyici sağlar.

Üreticiye özel worktree/snapshot verilir. Başlangıç SHA'sı açıkça doğrulanır; varsayılan branch'in o anki iş temeli olduğu varsayılmaz. Aday çıktılar patch/commit ve değişiklik kaydıyla teslim edilir; kalıcı olacak ara bulgular da checkpoint olarak kaydedilir. VM'de kalmış worktree veya yanıt verilmemiş özel bağlam uzaktan dayanıklı kayıt değildir.

Yayın yolu şu karşılaştırmaları yapacak şekilde tasarlanır:
- beklenen current temel ve maddi bağımlılıklar hâlâ uygun mu;
- yazan görevlendirme hâlâ yetkili mi; değişen yollar kendi kapsamı içinde mi;
- gereken içerik hükmü ve sürüme bağlı açık itirazların karşılığı var mı;
- ürün, ilgili iş/karar ve giriş güncellemeleri aynı anlamlı değişiklikte tutarlı mı?

Uygun değişiklik staging üzerinden bir Git commit'ine alınır; aynı nesne eski tüm-dosya kopyasıyla ezilmez. İçerik ve kayıtların aynı depoda olması bu yüzden ilk tercihtir. Okuyucu mümkün olduğunda ilan edilmiş commit/snapshot'tan okur; yayın sırasında değişen canlı dosya ağacı kendi başına tutarlı görünüm kabul edilmez. Bir Git commit'inin bulunması semantik onay değildir; kaydedilmiş adaylar aday kalır.

Cloud'un izinli session branch'i uzaktaki dayanıklı çalışma checkpoint'i olur; her ara rol için `main` merge'i veya kullanıcı onayı gerekmez. Ayrı branch/PR'nin ürün ana dalına kabulü ayrı sınırdır. Yerel aday branch'lerini ayrı ayrı push edebilme varsayımı yapılmaz. Doğrulanmış push'tan önce VM kaybolursa son dayanıklı checkpoint'ten sonraki çalışma kaybolabilir; sınırsız kayıpsızlık iddiası yoktur.

### Koruma seviyesi: henüz kapanmamış teknik yük

Native worktree, talimat ve Git sürüm kontrolünü tam güvenlik duvarı diye sunmuyorum. Shell, Git'in paylaşılan yönetim alanı, API, MCP ve kontrol dosyası değişiklikleri alternatif yazma yollarıdır. Üreticinin root/current'a ve kontrol yordamına dolaylı yazamaması; görevli değişince eski çalıştırmanın yayın yapamaması hedefte gösterilmelidir. Genel Bash veya API erişimini koruyup “yalnız bu dosyaya yaz” demek yeterli değildir.

Tercih edilen dar yayın yordamı eski temel ve etkin görevlendirme kontrolünü yapar; izin/sandbox/hook bunun atlanmasını engellemelidir. Bunların hedef cloud kipinde yeterli olmadığı görülürse paralel mutasyon açılmaz. Güvenli alternatif, salt-okur uzmanların aday üretip yalnız sınırlı yürütme kanalının yazması veya izolasyon biçiminin değiştirilmesidir; H3/H5 sessizce düşürülmez. Ayrıntılı izin matrisi ve gerçek sınır doğrulaması P4'ün kalan yüküdür.

## 7. Olay bağlantıları, bakım ve yeniden giriş

| Bağlantı adayı | Görevi / sınırı |
|---|---|
| SessionStart | Hedef/ref/erişim/yarım deneme kontrolü ve current okuma rotası. Agentic çalışmayı shell betiğinin tek başına yaptığı varsayılmaz. |
| PreToolUse | Etkin görevlendirme, mutation/yayın kapsamı ve yasak doğrudan yolları uygun tool girdisinde kontrol etmek. Keyfî komut metni filtrelemesi OS sınırı değildir. |
| SubagentStart | Rol/görev kimliği ve gerekli bağlamın verilmesi; creation-blocking kapısı olarak kullanılmaz. |
| SubagentStop / ana oturuma sonuç dönüşü | Sonuç/aday/checkpoint yolunu koruma. Child'ı devam ettirme ile parent'a sonuç ulaştırma farklı bağlardır. Background dönüş yolunun hedefte ayrıca gözlenmesi gerekir. |
| Stop / yeniden giriş | Yetkili hazır katkı, kayıp tüketim veya eksik devam kaydı için sınırlı kontrol; kullanıcı durdurmasını aşmak veya sonsuz loop yaratmak için değil. |
| Değişiklik ve devir bakımı | DR07/DR08: current yol, kaynak/statü, arşiv exclusion ve tüketici bağını günceller. Kozmetik kusur bütün ekibi durdurmaz. |

Kesintiden sonra önce remote checkpoint ve gerçek yayın sonucu karşılaştırılır. Uygulandı/uygulanmadı/kısmi/bilinmiyor ayrı tutulur. İleti onayı kaybolduğu için aynı değişiklik yeniden uygulanmaz. İş ve açık itiraz korunur; uygun yeni role doğru sürümle verilir. Eski actor ID'si, alıcı adı veya belleği yeni yetkinin yerine geçmez.

## 8. Birincil kaynak kontrolü ve yerel gözlem

**27 Eylül 2026'da resmî web metinlerinin ilgili bölümleri yeniden okundu.** Tüm belgeler, tüm bağlantılar veya hedef kurulu sürüm tam doğrulandı denmez. Aşağıdaki kısa kaynak olguları ile yukarıdaki kendi tasarım tercihlerimiz ayrıdır.

| Kaynak | Bu tur yük taşıyan dar olgu |
|---|---|
| [A1 Subagents](https://code.claude.com/docs/en/sub-agents) — scope, tools, startup, resume | Özel tanımlar YAML/Markdown'dur. Adlandırılmış alt ajanlar SendMessage kullanabilir; alıcı ve çalışma kipine bağlı araç/sonuç davranışı vardır. Non-fork bağlamı ana konuşmayı otomatik devralmaz. Bu yüzden araç/girdi ve request–consumer eşlemesi açık tasarlandı. |
| [A2 Agent teams](https://code.claude.com/docs/en/agent-teams) — compare, architecture, definitions, permissions | Takımlar deneysel; shared tasks, doğrudan iletişim ve üyelik yaşamı sunar. Tanımın her alanı aynı uygulanmaz; örneğin skill preload'u taşınmaz. Task kayıtları yereldir. Takım bayrağıyla adlandırılmış çağrı teammate olabilir. Bu nedenle başlangıç tercihi takımlar kapalı; geçiş açıkça yapılmalıdır. |
| [A3 Cloud environments](https://code.claude.com/docs/en/cloud-environments) — proxy, carry-over, setup | Repo ayar/tanımları cloud'a taşınır. Git push oturumun çalışma branch'iyle; API erişimi bağlı repo kapsamıyla sınırlıdır. Setup ile SessionStart farklıdır. Research erişimi ve restart gerçek hedefte kontrol edilmelidir. |
| [A4 Claude on the web](https://code.claude.com/docs/en/claude-code-on-the-web) — context, subagents/teams | Web kaynağı repo alt ajanlarını ve team env bayrağını anlatır. Belgesel destek actual sürüm/izin ve K1/K2 başarısı değildir. |
| [A5 Worktrees](https://code.claude.com/docs/en/worktrees) — isolation, base | Worktree üretim kopyasını ayırır; varsayılan temel remote default branch olabilir. `worktree.baseRef: head` mevcut HEAD'den başlatma seçeneğidir; özel branch değeri kabul etmez. Native kontrolün kapsamı araç/yol bazlıdır. Bu nedenle her üretimde exact başlangıç SHA'sı kontrol edilir. |
| [A6 Permissions](https://code.claude.com/docs/en/permissions) — Bash, file access, sandbox | Dosya aracı izinleri keyfî subprocess'in tüm dosya erişimini engellemez. Argüman eşleştirmesi tek başına yeterli değildir; sandbox farklı bir koruma katmanıdır. Dolaylı yazma açık yük tutuldu. |
| [A7 Hooks](https://code.claude.com/docs/en/hooks) — common fields, SubagentStart/Stop, Stop | Hook girdilerinde scope'a göre session/agent kimliği bulunur. SubagentStart oluşturmayı engellemez; bağlam ekler. SubagentStop'un block sonucu child'ı sürdürür; bunu parent orchestration sanmamak gerekir. Hook tanımının olması fiilî kontrol kanıtı değildir. |
| [A8 Memory](https://code.claude.com/docs/en/memory) | CLAUDE.md davranış bağlamıdır, izin duvarı değildir. Auto memory'ye tek kalıcı proje otoritesi yüklenmedi. |
| [A9 Git update-ref](https://git-scm.com/docs/git-update-ref), [A10 Git worktree](https://git-scm.com/docs/git-worktree) | Beklenen eski OID ile ref güncelleme yapılabilir. Worktree'ler repository yönetim bilgisini paylaşır; dosya ayrımı bütün yazma yetkisinin ayrılması değildir. |

P1-01 tarihsel kaynak haritası korunur; bu ek P4'ün güncel teknik seçimine dayanak olan tazelemedir. Plugin'e bağımlı yol seçilmediğinden eski Q03 çelişkisi bu tur çözülmüş sayılmadı. Diğer Q açıkları aşağıdaki kabul kapılarına bağlandı.

**Yerel Git probe — hedef Claude testi değil:** Geçici, dış bağlantısı olmayan repoda Git 2.47.3 ile iki aday aynı r0 temelinden oluşturuldu. `git update-ref <ref> A r0` exit 0; ardından `git update-ref <ref> B r0` exit 128 verdi ve A korundu. Aynı ref'e eski OID şartı olmadan B yazılması exit 0 ile başarılı oldu. Pozitif/negatif sonuç birlikte şunu gösterir: beklenen temel kontrolü ilgili stale yazıyı yakalar, fakat yayın yolunu atlama yetkisini ortadan kaldırmaz. Eşzamanlı cloud ajanı, ağ kesintisi, gerçek reviewer veya çok dosyalı publication deneyi yapılmadı. Geçici repo silindi; gözlemler burada korunmuştur.

**Research yeniden kullanımı:** P3'ün tam H1–H6 devri ve P2 sözleşmeleri kullanıldı. Önceki görünür Information I1–I5/Revision M5, Beads, Gas Town ve Hermes Note30 kapsamları; iş/deneme, source→view→use, arşiv keşfi ve yayın/etki ayrımlarını taşıdı. Bunlar seçilmiş ürünler değil, failure karşılaştırma dayanaklarıdır. Bütün Foundation/studies veya kaynakların özgün deneyleri yeniden okunmadı. Canonical başlangıç/okuma rotası INDEX→STATE→HANDOFF→WORK→DECISIONS→ACTORS→U002→P1→P2→P3'tür; aynı konuşmadaki tam değişmemiş gövdeler yeniden kullanıldı, eksik/kesilmiş yeni gövdeler bölüm aralıklarıyla tamamlandı.

## 9. H1–H6 karşılığı ve P4'ün kapanmamış kapıları

| Yük | Bu taslakta karşılığı | Hedefte gereken kanıt |
|---|---|---|
| H1 rol/etkinleşme | Ana Y, ayrı G koordinasyonu; özel rol dosyaları, açık expertise ve çağrı kimliği | Gerçek tanım/araçların yüklenmesi; ana oturumun G kararını gasp etmeden routine çağrıyı sürdürmesi |
| H2 alan/current erişim | Aynı operasyon deposunda soul/devos ayrımı; küçük current giriş, kaynak ref'leri ve aktif/arşiv ayrımı | Research erişimi; yeni cloud oturumunun doğru çalışma branch/checkpoint'ini ve gerekli kaynağı bulması |
| H3 değişiklik/yayın | Özel üretim kopyası, aday patch, sıralı kontrollü yayın ve exact temel | İki eski temelli yazının ezmemesi; doğrudan/dolaylı root/API/control değişikliğinin sınırlandırılması |
| H4 talep/tüketim | SendMessage + kalıcı request/consumer bağı; Y'nin eksik rolü oluşturması | A→B→A ile kaynaklı sonucun doğru kararda kullanımı; normal rol geçişi kullanıcı komutu beklemez |
| H5 kesinti/eski yazıcı | Push'lanmış checkpoint; deneme/yayın ayrımı; yeniden girişte uzlaştırma | Kayıp ACK/VM, geç cevap, iptal edilmiş görevli ve eski temel denemesinde güvenli karşılık |
| H6 güvence/bakım | G/Y incelemesi, candidate/current ayrımı, kapsamlı yeniden kullanım ve arşiv kontrolü | Yanlış role/sürüme bağlanmış sonucu ve aktif keşfe sızan eski kopyayı yakalama; kozmetik kusurla tüm akışı durdurmama |

**Açık olan:** Hedef operasyon reposu/bağlı Research erişimi, gerçek cloud sürüm/araç havuzu ve özellikle shell/API/eski-yazıcı sınırının yeterliği. Sonuç, belgeler + dar yerel Git probe'udur; P4 geçiş ölçütleri tümüyle sağlandı denmez.

**Sonraki bütünlüklü P4 işi:** Bu topoloji ve alan yerleşimine göre rol→araç→okuma/yazma/yayın yetki matrisini ve hedef cloud için tek kabul denemesi paketini tamamlamak. Pakette tanım yükleme, A→B→A, kalıcı checkpoint ve doğrudan/dolaylı eski-yazıcı karşı vakaları birlikte bulunmalı. Gerçek hedef bilgisi/çalıştırma kanıtı gerektiğinde açıkça istenir; bu arada P5 kurulumuna sessiz geçilmez. Yeni genel P3 audit'i veya bütün aileleri yeniden sınıflandırma yoktur.

**Durma:** Teknik başlangıç tercihi kullanıcıya değerlendirme için sunulur. P4 açık; P5 ajan/skill/hook dosyaları oluşturulmadı, hedef repo açılmadı, SOUL geliştirme işi seçilmedi. EXP-006'daki bu kaydın yayımlanması, tasarlanan DevOS yayın kanalının kanıtı değildir.
