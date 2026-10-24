> **30 Eylül 2026 — tarihsel iş devri ve ortam seçenekleri değerlendirmesi.** Aşağıdaki Codex merkezli aday, yerel CLI/Claude seçenekleri, G1-R1 durumu ve platform gözlemleri 7 Eylül'deki tartışmaya aittir. Bugünkü ortam kararı yeniden açılmaz; eski yardımcı çağrısı, sağlayıcı aktarımı veya pilot izni doğmaz. Rol/oturum, iletişim/kalıcılık ve kapasite/yetki ayrımları korunur.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Bakımın devamı [REPOSITORY-TRANSITION](../../../../../REPOSITORY-TRANSITION.md)'dedir; aşağıdaki eski yöntem seçimi değildir.

---

# Development OS — ajanlar arası iş devri seçenekleri

**Review ID:** DEVOS-COLLABORATION-OPTIONS-2026-09-07  
**Statü:** BOUNDED FEASIBILITY / METHOD DISCUSSION; proposed roles, not installed or accepted architecture.  
**Tetikleyici:** Kullanıcı, Research danışmanlığının bir karşılığını Codex içinde çalıştırmayı, mevcut Codex aktörüyle doğrudan iş devrini ve kurulu olduğunu bildirdiği Claude Code'u eklemeyi önerdi. Amaç rutin ChatGPT↔Batu↔Codex mesaj taşımasını kaldırmak; araştırmayı burada sürdürebilmek.  
**Güncel checkpoint:** `../../../STATE.md`.

## 1. Hüküm ve yetki sınırı

İstenen etkileşimin teknik dayanakları mevcut: Codex yerleşik alt ajanları, iki ürünün programatik CLI girişleri, Codex MCP/App Server ve Claude'un kendi oturumları arasındaki mesajlaşma. Aynı uygulamada iki sohbet açmak bunların yapılandırıldığını göstermez. Belgelendirilmiş özellik, kullanıcının kurulu sürümünde/hesabında gözlenmiş yetenek değildir.

Asıl öneri yeni bir kalıcı üçlü ekip kurmak değil, geliştirme koordinasyonunu uygun yürütme ortamına taşımaktır. Küçük aday: tek geliştirme koordinatörü, gerektiğinde sınırlı üretici/incelemeci; Claude ayrı model görüşü için çağrılabilir. Koordinatörün Codex olması mevcut erişim/iş bağlamını koruyan başlangıç adayıdır, kanıtlanmış üstünlük değildir. Claude merkezli düzen de karşılaştırılabilir.

G1-R1 hâlâ kullanıcı tarafından gönderilmemiş/askıdadır. Bu inceleme aktör başlatmaz, görev/mesaj göndermez, yerel veya global talimat değiştirmez, C1'i değiştirmez, yeni model sağlayıcısına özel kaynak aktarma izni vermez. Foundation ve ürün işi etkinleştirilmez.

## 2. Aktarılabilecek olan rol; otomatik oturum özdeşliği değil

Bu ChatGPT konuşmasının canlı durumu, araç bağlantıları, hesap yetkileri, gizli runtime talimatları veya tam bağlam kapasitesi Codex'te yeni sohbet açmakla taşınmış sayılmaz. Taşınabilecek girdiler: SOUL amacı, araştırma kaynaklarına sürümlü rotalar, güncel iş/yetki durumu ve geliştirme için ayrıca değerlendirilecek açık davranış ilkeleri.

Yeni aktör bunları geri kazanabilir; aynı zihinsel durum veya aynı performans garanti edilemez. Bu sohbetin etkin bağlamının tam 1M olduğu independently measured değildir. Modelin azami penceresi, ürünün etkin penceresi, sıkıştırma eşiği ve plan kullanımı ayrıdır. Bu nedenle rollerin dağıtımı kesin doğrulanmamış bir token sayısına bağlanmamalı.

Araştırma burada sürebilir; geliştirme aktörleri gerekli araştırmayı seçici okuyup teknik işi kendi ortamında yürütür. Research evidence otomatik mimari karar veya execution grant değildir. Bu browser oturumunun kullanıcının Mac oturumlarını yöneten kurulmuş canlı kontrol kanalı yoktur. Plugin keşfi de bu tur böyle bir kanalı doğrulamadı; bu tüm ürünlerde iletişimin imkânsız olduğu iddiası değildir.

## 3. Güncel resmi kaynakların desteklediği imkânlar

### Codex içinde delegasyon

OpenAI'nin güncel Subagents belgesi, yerleşik alt ajan işlerini ve sonuçların ana konuşmaya dönmesini CLI/app/IDE için açıklıyor. Özel ajan yönergeleri/model ayarları da tanımlanabiliyor. Bu, iki elle açılmış bağımsız UI sohbetinin otomatik eşleştiği anlamına gelmez. Native delegasyon, kendi başlatıcımızı yazmadan değerlendirilecek bir aday yoldur; özel bağımsız reviewer/sandbox ölçütlerini otomatik sağlamaz.

Kaynak: https://learn.chatgpt.com/docs/agent-configuration/subagents (2026-09-07; eski developers.openai.com/codex/multi-agent yönlenmesi).

### Codex ↔ Claude Code çağrı ve geri dönüş

`codex exec` programatik görev yürütüp çıktıyı başka süreçlere verir; kayıtlı CLI kimliğini kullanabilir. `claude -p` de programatik görev, sonuç biçimi ve belirli oturumu sürdürme imkânı sunar. Bu iki destekli girişten, izinli bir koordinatörün diğerini çağırması ve cevabı kullanması teknik olarak çıkarılabilir. Bu tur kullanıcının ortamında iki yönlü çalıştırma yapılmadı. Bir görev sonucuyla program akışına geri dönmek, ana ajanı yeniden iç içe spawn etmek değildir.

Kaynaklar: https://learn.chatgpt.com/docs/non-interactive-mode ; https://code.claude.com/docs/en/headless .

### Daha zengin oturum kontrolü

Codex MCP Server, `codex` ile başlatma ve `codex-reply` ile thread kimliğine devam sunar. App Server; thread/turn başlatma, sürdürme ve olay akışı sunar. Bunlar daha geniş entegrasyon seçenekleri; ilk iletişim için SDK, kalıcı sunucu veya yeni framework zorunlu değildir. MCP arayüzü tek başına genel ekip protokolü, tüm araçlarda aynı izin veya otomatik karşılıklı uyanma anlamına gelmez.

Kaynaklar: https://learn.chatgpt.com/docs/mcp-server ; https://learn.chatgpt.com/docs/app-server ; https://openai.com/index/unlocking-the-codex-harness/ .

### Claude'un kendi oturumlarında mesajlaşma

Güncel Cross-session messaging belgesi v2.1.224+ macOS/Linux için `ListAgents` / `SendMessage` yolunu açıklıyor. Boşta alıcıda yeni tur açılması destekleniyor; sağlayıcı/ayar/erişilebilirlik şartları var. Bu, Claude↔Claude yeteneğidir; Codex'in otomatik bu ağa katıldığının kanıtı değildir.

Agent teams ayrıca ortak iş/iletişim düzeni sunuyor; deneysel ve varsayılan kapalı. Belgelenen in-process resume/iş durumu/kapanış kısıtları uzun süreli devam için maddidir. Teams'i kurmadan da sınırlı CLI çağrısı veya native subagent değerlendirilebilir.

Kaynaklar: https://code.claude.com/docs/en/cross-session-messaging ; https://code.claude.com/docs/en/agent-teams .

## 4. Araştırma dayanağı ve taşınabilirlik sınırı

Bu turun okuma rotası: current STATE; aynı konuşmada tam okunmuş bridge ve son yöntem değerlendirmesi; candidate CATALOG/gstack girişleriyle mevcut kaynak rotası; `multi-agent-patterns/META.md` tam ve `SOUL-DEVELOPMENT-OS-ASSESSMENT.md` §§1–6 seçici yeniden okuma. Önceki gstack coordination/host bölümleri bağlam/fresh-context, ortak dosya alanı ve model çeşitliliğini ayrı tutan karşılaştırma girdileridir. Bu tur gstack kurulmadı veya yeniden pinlenmedi.

Multi-agent assessment'taki eski Foundation aşaması tarihsel çalışma kapsamıdır, güncel yetki değildir. En ilgili çıkarımı: sıra, eşzamanlılık, devir yetkisi, eleştiri/doğrulama ve insan karar hakkı ayrı tasarım ilişkileridir; sabit ekip sayısı veya her işte aynı workflow zorunlu değildir.

Bu nedenle iki ajan aynı fikirde diye doğruluk oluşmaz. Claude'un farklı model ailesi bazı ortak hata risklerini azaltabilecek ayrı görüş verir; aynı kaynak/çerçeve/oracle hatası kalabilir. Salt okunur eleştiri ile üreticinin kendini kabul etmesi ayrılmalı. Ekip üyelerinin birbiriyle iletişimi, kalıcı source/work/evidence kayıtlarının yerine geçmemeli.

## 5. Önerilen küçük çalışma biçimi — henüz seçilmedi

Önerilen ilk aday, kalıcı birbirini tetikleyen üç denk yönetici değil:

- Kullanıcı: amaç, değer, önemli kapsam/bütçe ve kabul sınırları.
- Geliştirme koordinatörü: güncel kaynak/yetkiyi geri kazanır; uygun işi seçer/devreder; kanıtı bütünleştirir; ne zaman duracağını bilir. Nihai doğruluk otoritesi değildir.
- Gerektiğinde üretici veya incelemeci: açık ve sonlu bir iş; belirli çıktı; ilgili en az araç/etki kapsamı. Claude bu incelemeci olabilir; ayrı Codex üretici yalnız gerekli bağlam ayrımı veya paralellik varsa eklenir.
- Research burada: temel/derin araştırma, kaynak ve yön sorgulaması; her rutin teknik turda zorunlu relay değil.

Muhtemel akış: yetkili sınırlı iş → taslak/kanıt → çağrılan inceleme → gerekçeli düzeltme veya uyuşmazlık kaydı → ölçüte göre kapanış/insan kararı. Koordinatör dönünce devam eder; karşılıklı sonsuz A→B→A→B süreç doğurma yok. Düşük-risk işi ve yüksek-etkili control değişikliği aynı kabul kapısına zorlanmaz; mevcut G1 koşulları ise bu incelemeyle kaldırılmaz.

İlk başarı: kullanıcı mesaj taşımadan belirli bir iş sonucunun diğer aktör tarafından kullanılması ve izinli devam/kapanışın kaydı. Çok ajan, uzun sohbet, araç çağrısı veya fikir birliği başarı ölçütü değildir. İlk girişten sonraki rutin devri otomatikleştirmek ile Mac/ana süreç kapalıyken 24/7 görev uyandırmak ayrı kabiliyetlerdir.

## 6. Davranış disiplini ve gerçek yetki

Codex AGENTS.md/özel ajan yönergeleri ve Claude CLAUDE.md/özel alt ajan tanımları destekli taşıyıcılardır. Ortak ilkeler için tek sürümlü geliştirme kaynağına ince host girişleri düşünülebilir. Research AGENT/agent/** dosyalarını körlemesine ithal etmek veya kaynak dosyasını kendiliğinden aktif talimat saymak yok.

Taşınacak disiplin: amaç–yöntem ayrımı, karar-kritik varsayım, kaynak/çıkarım/karar statüsü, gerekçeli itiraz, orantılı kontrol, izinli devam ve güvenilir devir. Bütün protokolleri her uzmana yüklemek yerine gerekli tetikleyici/rol bağlamı seçilir. Talimat yüklenmesi davranış garantisi değildir; güvenlik gerektiren etki yalnız talimatla sınırlandırılmış sayılmaz.

Kaynaklar: https://learn.chatgpt.com/docs/agent-configuration/agents-md ; https://code.claude.com/docs/en/sub-agents ; https://code.claude.com/docs/en/memory .

## 7. Açık uygulama önkoşulları

Kullanıcı Claude Code'un kurulu olduğunu bildirdi. Claude sürümü, giriş/planı, otomatik çağrı izni, mevcut oturuma erişim ve gerçek görev dönüşü henüz ölçülmedi. Güncel doküman özellikleri son bildirilen Codex 0.153.4 çalışma yolunda ayrıca sınanmalıdır; güncelleme/kurulum izni bu incelemeden çıkmaz.

Codex noninteractive kayıtlı kimliği kullanabilir. Claude'un normal programatik kullanımı ile `--bare` aynı auth yolu değildir: güncel headless belge bare modunun subscription login kullanmadığını söylüyor. Bu bir bare/API seçimi önerisi değildir. Plan/sağlayıcı/çağrı yoluna göre maliyet ve erişim ayrıca kontrol edilmelidir. Ücretsiz, sınırsız, yeni API anahtarı gerektirir veya kesin gerektirmez hükmü yok.

Yerel orkestrasyon modeli Mac'in içinde çalıştırmak demek değildir; yerel araç/build/oturum süreçleri yine kaynak tüketir. Kısıtlı Mac için başlangıçta sıralı tek alt çalışma önerilir; paralellik ancak ölçülen faydayla artar. Kaynaklı materyalin Claude'a verilmesi sağlayıcılar arası veri aktarımıdır; önce kapsam/izin belirlenir, kimlik bilgileri aktarılmaz. Farklı uygulamalar otomatik farklı dosya/hesap yetkisi oluşturmaz.

Maliyet/ortam kaynakları: https://code.claude.com/docs/en/costs ; https://code.claude.com/docs/en/how-claude-code-works .

## 8. Son durum

Bu bir desteklenmiş imkân değerlendirmesi ve küçük çalışma düzeni önerisidir. Mevcut teknik engeller çözülmüş, araştırma danışmanı taşınmış, Claude takıma alınmış, yeni protokoller yüklenmiş veya rutin insan koordinasyonu kaldırılmış sayılmaz. Bir sonraki karar, minimum başlangıç işiyle orantılı yöntem ve yetki seçimi olarak kullanıcıyla konuşulur; G1-R1 otomatik tekrar gündeme alınmaz.
