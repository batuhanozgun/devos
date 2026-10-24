# Üçüncü video — Agent hafızası: hatırlamak, güncellemek ve unutmak

**2026-09-16 / PxuMqeIqCEo.** *AI Agent Memory Masterclass | How Agents Remember and Forget*. İlk kaynak incelemesi ve sınırlı birincil-kaynak karşı kontrolü. Bir hafıza ürününün kurulumu, davranış testi veya SOUL mimari kararı değildir. V01 video, V02 yüklenen İngilizce SRT; W01 ayrı eşlikçi yazı; D01–D05 dış birincil kaynaklardır. Kimlik ve kapsam: [SOURCE](SOURCE.md). Proje açısından aday çıkarımlar: [ASSESSMENT](SOUL-DEVOS-ASSESSMENT.md).

## 1. Kaynağın sorusu

Video, bir coding agentın kullanıcının kısa cevap tercihini, proje düzenini ve onay beklentisini hatırlıyormuş gibi görünmesiyle başlıyor. Anlattığı olağan kullanımda oturum kapanması model ağırlıklarını kendiliğinden güncellemiyor; çevredeki sistem seçtiği bilgiyi saklıyor ve daha sonraki bağlama geri getiriyor. İncelemenin nesnesi bu oturumlar arası taşıma düzeni; bütün öğrenme biçimleri veya modelin eğitimle kazanmış bilgisi değil. [V02 00:03–01:37]

Kaynağın hafıza sorusu, neyin saklanacağı, geri çağrılacağı, güncelleneceği ve unutulacağıdır. Harness anlatısına bunu gelecekteki eylemi şekillendirecek durumun taşınması olarak bağlar. RAG'i mevcut yanıt için bilgi getirme sorusu, hafızayı ise zaman ve iş akışları arasında neyin süreceği sorusu olarak yan yana koyar. Bu, iki yöntemin asla kesişmediği iddiası değildir. Aynı retrieval yöntemi geçmiş oturumlara veya dış belgelere uygulanabilir; soru ile kullanılan mekanizma farklı ayrımlardır. [V02 00:54–01:37; son cümleler analitik yorum]

**Videonun ana tezi:** agent hafızası yalnız bir depo değil, zaman içinde bağlam oluşturma işidir. Bu ifade kaynağa aittir. İnceleme, tezin yararlı açıklamasını ve fazla geniş okunmaması gereken yerlerini birlikte korur.

## 2. İçerik haritası ve okuma kapsamı

| Yaklaşık zaman | Kaynağın bölümü | Temel soru |
|---|---|---|
| 00:03–01:37 | Hatırlama görünümü, harness ve RAG bağı | Oturumdan oturuma ne taşınıyor? |
| 01:37–05:45 | CrikIT örneği ve çıplak oturum sınırı | Geçmiş iş, güncel durum ve onay nasıl birleşir? |
| 05:45–08:27 | Working memory | Modelin önünde şimdi ne var? |
| 08:27–10:43 | Episodic memory | Belirli bir zamanda ne oldu? |
| 10:43–14:02 | Semantic memory | Proje ve kullanıcı hakkında hangi bilgi geçerli sayılıyor? |
| 14:02–16:48 | Procedural memory | İş hangi yöntemle yürütülmeli? |
| 16:48–21:36 | Bağlam oluşturma, aynı isteğin uçtan uca karşılığı, ürün örnekleri | Saklanan bilgiler nasıl kullanılabilir girdiye dönüşüyor? |
| 21:36–22:49 | Çelişkiler | Benzer kayıtlar bugünkü karar için eşdeğer mi? |
| 22:49–25:27 | Unutma, bakım, büyük bağlam penceresi | Eski bilgi ne zaman önceliğini kaybetmeli? |
| 25:27–27:18 | Harness/sandbox bağlantısı, beş değerlendirme sorusu | Gerçekte ne görülüyor, ne hatırlanıyor ve ne geçerli? |

Zamanlar SRT çıpalarıdır; doğrulanmış YouTube chapter metadata'sı değildir. 636 cue'nin bütün metni üç ardışık aralıkta okundu; videodan 22 farklı zamandaki kare, üç temas sayfasında incelendi. 04:05 ve 22:30 kareleri ayrıca tam çözünürlükte açıldı. Tam ses–altyazı hizalaması veya kesintisiz izleme yapılmadı. Tekrarlanan/örtüşen cue'ler ayrı bağımsız kanıt değildir. [SOURCE; evidence/MEDIA-READING.json]

## 3. Dört hafıza işlevi, tek değişmeyen örnek

### Örnek: CrikIT issue #9

Yayıncı, kriket ligi uygulamasındaki oyuncu profilinin üyelik değiştiği hâlde eski kulübü göstermesini örnekliyor. Bunun gerçek işten sadeleştirilmiş bir anlatım olduğunu söylüyor; asıl issue veya özel çalışma kayıtları bu araştırmada açılmadı. İstek, belirli issue'yu ve atanan kişiyi bulmayı, önceki onaylı iş akışını uygulamayı, proje kurallarını korumayı gerektiriyor. [V02 01:47–05:45]

04:05 karesi proje adını **CrikIT**, insan-dostu adı **Buddy Bean Town**, GitHub eşlemesini `buddybeantown` ve onay işaretini `@codex implement` olarak gösteriyor. SRT'deki değişken yazımları bu görsel ve W01 ile ayırdık; sesi doğrulayarak düzelttiğimizi iddia etmiyoruz. Bu işaret yayıncının anlattığı özel otomasyon sözleşmesidir; her Codex kurulumunun evrensel onay kuralı değildir. [V01 245s; W01]

### Working memory — çalışma hafızası

Videoda bu terim, modelin mevcut çağrıda görebildiği aktif bağlamı ifade eder: güncel istek, konuşma, talimatlar, sunulmuş dosya içeriği ve araç sonuçları. Eski bir mesaj hâlâ görünürse model onu kullanabilir. Kalıcı saklama ve yeniden yükleme düzeni olmayan yeni oturumda ise aynı bilginin kendiliğinden bulunması beklenmez. Buradaki yeni oturum örneği, özellikle bütün saklama mekanizmalarının kaldırıldığı senaryodur; bütün gerçek sohbet ürünlerinin oturum yönetimine dair ölçüm değildir. [V02 02:06–03:34; 05:45–08:27]

Kaynağın masa benzetmesinde büyük bağlam daha geniş masadır. Ancak masanın genişlemesi, gerekli kaydı seçme veya güncelliğini belirleme sorununu çözmez. Kaynak, fazla ve ilgisiz içerikle performansın kötüleşebileceğini savunur; videoda bunun için kontrollü model karşılaştırması bulunmaz. Bağlam kapasitesi, bu kapasitenin etkili kullanımı ve oturumlar arası süreklilik ayrı sorulardır.

### Episodic memory — olay/deneyim hafızası

Belirli bir inceleme, debugging oturumu, araç çağrısı veya PR takibi, zamanıyla birlikte geri çağrılır. CrikIT örneğinde eski çalışmanın onay eksikliği nedeniyle durduğunu öğrenmek, işin neden orada kaldığını açıklar. Fakat o eski kayıt, bugün hâlâ onay bulunmadığını tek başına göstermez. [V02 08:27–10:43]

Kaynak Markdown, SQLite/tam metin araması, vektör arama ve zamansal grafik gibi depolama/erişim seçenekleri sayar; ürün seçmekten çok doğru olayı ve yeterli bağlamını bulmaya odaklanır. İyi sonuç bütün günlükleri yığmak değil, gereken olayı bulurken ne zaman geçerli olduğunu kaybetmemektir. Bu işlevlerden hiçbiri zorunlu olarak ayrı veri tabanı gerektirmez.

### Semantic memory — bilgi hafızası

Proje dizini, uygulama kökü, kişi–hesap eşlemesi, kullanıcı tercihleri ve geçerli iş kuralları bu başlıktadır. Her kullanımda bu bilginin ilk öğrenildiği olayı yeniden anlatmadan kullanılabilmesi, episodic hafızadan ayrılır. [V02 10:43–14:02]

Kaynak önce bilgiyi zamanından bağımsız kullanılan standing knowledge olarak anlatır; sonra dosyaların taşınabildiğini, onay durumunun değişebildiğini ve eski tercihlerin yeni istekle çatışabildiğini açıkça söyler. Bu iki kısmı birlikte okumak gerekir. **Bilgiyi öğrenme olayını yeniden oynatmadan kullanmak, bilginin zamansız veya değişmez olması değildir.** Bu cümle bizim yorum sınırımızdır; kaynağın bakım uyarısını korur, açılıştaki basitleştirmeyi sessizce genişletmez.

Videonun örneğinde debugging sırasında istenen kısa yanıt tercihi, daha sonraki kapsamlı rapor isteğini otomatik geçersiz kılmamalıdır. Kaynak, saklama kadar güncelleme ve kullanım dışı bırakma sorumluluğunu da bu hafızanın parçası sayar.

### Procedural memory — yöntem hafızası

Runbook, checklist, skill ve işin nasıl ilerleyeceğini belirleyen uygulama kodu bu başlıktadır. Videonun ayrımı nettir: uygulama için onay gerektiğini bilmek bir kural bilgisidir; issue'yu getir, yorumları incele, öneriyi ve ardından gelen onayı doğrula, onboarding belgesini oku, sınırlandırılmış dizinlerde çalış, odaklı testleri yap, draft PR aç ve sonucu bildir dizisi bir prosedürdür. [V02 14:02–16:48]

Kaynak prosedürü yalnız prompt olarak düşünmez; tool schema ve orchestration kodu da taşıyabilir. Bu, her prosedürün her ayrıntısının modele metin olarak verilmesini gerektirmez. Bununla birlikte bir şemada `approval_comment_id` alanı istemek, verilen yorumun gerçekten ilgili, geçerli ve yetkili olduğunu tek başına kanıtlamaz. Alanın biçimini kontrol etmek ile bu iş için onay bulunduğunu kontrol etmek farklıdır. Bu son ayrım analitik karşı örnektir; yayıncının otomasyonunda açık gösterdiğimiz anlamına gelmez.

**Birleştirici sonuç:** aynı işte mevcut istek, geçmiş olay, güncel bilgi ve uygulanacak yöntem birlikte gerekir. Bunlar dört zorunlu servis veya birbirinden kopuk dört klasör değil, kaynağın dört açıklama işlevidir.

## 4. Context builder: depodan karar girdisine

Kaynağın çizimi solda kalıcı depoları, ortada context builder'ı, sağda aktif bağlam ve modeli gösterir. Ortadaki işlevler **retrieve → rank → resolve → assemble** olarak yazılıdır: getir, önceliklendir, çelişkileri ele al, bağlamı oluştur. Modelin gerekirse araçlarla yeni bilgi istemesi de anlatımda yer alır. Bu nedenle çizimi bütün retrieval'ın tek seferde ve modelden tamamen bağımsız bittiği bir uygulama sözleşmesi saymıyoruz. [V01 1040/1210/1280s; V02 16:48–21:36]

CrikIT isteği artık şöyle ele alınabilir: geçmiş incelemenin neden durduğu bulunur; güncel issue ve yorumlar kontrol edilir; proje kökü ve kişi eşlemesi alınır; geçerli prosedür uygulanır. Hafıza eski bir cevabı tekrar etmek değil, bu bilgileri bugünkü işe uygun biçimde birleştirmektir. Kaynaktaki iyi cevap da yorumları doğrulamayı içerir; yalnız eski onay kelimesini bulup hemen düzenleme yapmayı değil.

**Analitik sınır:** modelin yeni bir dış bilgiyi kullanması için bu bilginin erişilebilir girdisine ulaşması gerekir. Fakat bütün agent sisteminin bütün davranışı prompt'ta görünmek zorunda değildir: kaynak, biraz önce görünmeyen orchestration kodunu da prosedür saymıştır. Modelin eğitimle kazanılmış bilgisi de ortadan kalkmaz. Son sloganı bütün sistem hakkında literal eksiksizlik iddiasına çevirmemek gerekir. D01 karşı kontrolü bu kapsam farkını somutlaştırır.

## 5. Çelişki: benzerlik, güncellik ve yetki aynı şey değil

22:30 karesi eski olayı onaysız, güncel thread'i ise `@codex implement` içeren durum olarak karşılaştırır. SRT bunu bir retrieval sorunundan öte durum sorunu olarak ele alır: o zaman ne doğruydu, şimdi ne doğru, hangi prosedür geçerli, ilerlemeden ne doğrulanmalı? [V02 21:36–22:49; V01 1350s]

İki kayıt farklı zamanları anlatıyorsa ikisi de tarihsel olarak doğru olabilir. Yanlışlık, birini yanlış zamana ilişkin karar için kullanmaktan doğar. Buna karşılık aynı zamana ilişkin farklı kaynaklar gerçekten çelişiyorsa, yalnız tarihe göre sıralamak yetmeyebilir. Kaynağın slaytındaki timing-versus-similarity karşıtlığını bu sınırla taşıyoruz.

**Analitik karşı durum:** sonradan eklenmiş bir yorum yanlış issue'ya aitse, yetkisiz biri tarafından yazılmışsa veya sadece eski bir onayı alıntılıyorsa en yeni metin olması yeterli değildir. Öte yandan eski bir politika hâlâ geçerli olabilir. Bu örnekler bir ürün saldırı testi değildir; yeni=geçerli ve eski=yanlış kısayollarını ayırır.

Kaynağın vektör veri tabanı eleştirisi, benzerlik aramasının tek başına bu anlamı kurmamasıdır. Buradan hiçbir vektör sisteminin metadata, zaman filtresi veya başka doğrulayıcıyla birlikte çalışamayacağı sonucu çıkmaz. D04–D05 tarih ve farklı retrieval yollarının birlikte bulunabildiğine ilişkin sınırlı ürün-belgesi karşılığı sağlar; herhangi bir ürünü doğruluk hakemi yapmaz.

## 6. Unutmak: her eski kaydı silmek değil

Video her hafıza işlevi için farklı bakım ihtiyacı sayar: aktif bağlamda seçim, olay hafızasında sıkıştırma, bilgi hafızasında çelişki çözümü, yöntem hafızasında bakım. Eski olay tarih olarak korunabilir ama güncel talimatla aynı öncelikte kullanılmamalıdır. [V02 22:49–25:27]

Kaynağın dört pratik stratejisi:

| Strateji | Kaynağın işlevi | Korunan sınır |
|---|---|---|
| Temporal decay | Eski kaydın önceliğini azaltmak; pinned, kullanılan veya kalıcı politikaya bağlı kayıtları ayırmak | Yaş, doğruluk veya yetkinin tek ölçütü değildir. |
| Contradiction handling | Güncel durumu yenileyip önceki durumu tarih olarak korumak | Yeni iddianın gerçekten geçerli değişiklik olduğu belirlenmelidir. |
| Compression | Oturumdan özet, gerektiğinde daha genel bilgi/yöntem çıkarmak | Özetleme bir iddiayı doğrulanmış olguya veya yetkili kurala yükseltmez. |
| Manual curation | Kritik proje kuralları ve prosedürler için sahiplik | İnsan onayı da tek başına teknik etkililik deneyi değildir. |

İlk iki sütun V02 24:06–24:55'ten kaynak açıklamasıdır; son sütun bizim analitik sınırlamamızdır. Her birini ayrı ürün veya zorunlu otomasyon olarak önermiyoruz.

Kaynağın session→summary→fact→procedure yolu olası bir birikim anlatısıdır. Tek bir olaydan çıkmış özetin genel bir yöntem olarak benimsenebilmesi ek uygunluk ve kanıt soruları doğurur. Kaynak bu soruların tamamını uygulanmış bir algoritma veya deneyle çözmüyor. Unutma bölümü ayrıca kişisel verinin bütün kopyalardan silinmesine dair bir veri-silme garantisi sunmuyor; burada öncelik, bakım ve geri çağırma semantiği inceleniyor.

## 7. Sınırlı birincil-kaynak kontrolleri

**D01 / CoALA:** W01'in bağladığı `2309.02427v3` makalesinin §4.1'i dört terimi kullanır; fakat working memory'yi yalnız o anki prompt değil, çağrılar arasında taşınan ve prompt'un bir kısmından üretildiği veri yapısı olarak tanımlar. Procedural memory kapsamına model ağırlıkları ve agent kodunu da alır. Bu, videonun pratik daraltmasını evrensel tanım saymamayı gerektirir. Oturum kapanmasının kendi başına ağırlık güncellememesiyle eğitimde kazanılmış bilginin varlığı çelişmez. Makalenin tamamı veya deneyleri araştırılmadı; yalnız terim/kapsam karşı kontrolüdür.

**D02 / LangChain–LangGraph:** Güncel kavramsal belge kısa/uzun süreli hafızayı thread kapsamıyla ayırır ve kısa süreli state'in checkpoint ile saklanmasını açıklar. Semantic memory ile semantic search de ayrı kavramlardır. Videonun yeni oturum örneği saklama olmayan kurguya bağlı kalmalıdır; kısa süreli adı verilen bütün state'in süreç kapanınca silindiği sonucu geçersizdir. Bu belge okumasıdır, checkpoint çalıştırması değildir.

**D03 / HERMES:** Güncel belgenin persistent-memory ve session-search bölümleri, oturum başındaki sabit memory görünümüyle sonradan disk üzerinde yapılan değişikliği ayırır; araç yanıtları canlı durumu gösterebilir. Bu, her turn için bağlam oluşturulmasının bütün depoları her turn yeniden okumak demek olmadığını somutlaştırır. Kaynağın ürün eşlemesi böylece bir işlev örneği olarak korunur. Güncel doküman, projedeki sabit sürümlü HERMES araştırmasının yerine konmadı; kod veya model çağrısı yapılmadı.

**D04–D05 / Graphiti:** Doküman zamansal metadata, tarihsel bağlam ve karma aramayı birlikte tanımlar. Episode eklemede referans zamanı sağlanır; bulk giriş yolunun edge invalidation yapmadığı ayrıca belirtilir. Tarih destekleyen ürün adı, bütün giriş yollarında çelişkilerin aynı biçimde çözüldüğünün kanıtı değildir. Bu koşullu API-belgesi gözlemi, yanlış sonuç üretildiğine veya bütün ürünün etkisizliğine ilişkin deney değildir.

Bu kontroller kaynağın ana sorusunu daraltıp netleştirir. CoALA, HERMES veya Graphiti için ayrı uzun araştırma başlatmaz; Letta/Mem0/diğer ürün isimleri keşif referansı olarak kalır, karşılaştırmalı üstünlük sonucu üretilmez.

## 8. Sonuç ve dönüş sınırı

Videonun beş sorusu kaynağın kendi değerlendirme çerçevesidir: model şimdi ne görüyor; hangi geçmiş oturum gerekli; hangi bilgi güncel; hangi iş akışı geçerli; ne önceliğini kaybetmeli ve prosedürlerin sahibi kim? [V02 25:48–27:18; V01 1555s]

Bizim sentezimiz: **hafızanın değeri yalnız doğru kaydı bulmakta değil, o kaydın bugünkü işte ne anlama geldiğini korumaktadır.** Olay geçmişi, güncel durum ve yöntem aynı karar içinde birleşebilir; fakat birbirinin yerine geçmez. Büyük bağlam, daha çok kayıt veya daha güçlü arama bu ayrımı tek başına sağlamaz.

Kaynağın ana bölgeleri, dört işlevi, aynı iş üzerinden birleşimi ve unutma/çelişki açıklaması kayıtlı derinlikte ele alındı. Yeni bir model, hafıza sistemi, retrieval benchmark'ı, otomasyon veya fault testi çalıştırılmadı. Tam ses sadakati ve yayıncının özel uygulamasının fiilî davranışı açık kalır. [REVIEW](evidence/REVIEW-AND-LIMITS.md)

İlk kaynak incelemesi kullanıcı değerlendirmesine döner. Daha güçlü teknik veya proje uygulama iddiaları ancak seçilmiş gerçek soruyla ele alınır; ilk videonun U05'ine, bütün hafıza ürünlerine veya yeni benchmark kampanyasına otomatik geçiş yoktur. [STATE](STATE.md) / [PLAN](RESEARCH-PLAN.md).
