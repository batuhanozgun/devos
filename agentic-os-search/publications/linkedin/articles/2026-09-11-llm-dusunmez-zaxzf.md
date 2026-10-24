# LLM Düşünmez - Olasılıksal Olarak En Uygun Kelimeleri Sıralar

- Yazar: Batuhan Özgün
- Yayın tarihi (LinkedIn): 11 Eylül 2026
- Kaynak: [LinkedIn makalesi](https://www.linkedin.com/pulse/llm-d%25C3%25BC%25C5%259F%25C3%25BCnmez-olas%25C4%25B1l%25C4%25B1ksal-olarak-en-uygun-kelimeleri-batuhan-%25C3%25B6zg%25C3%25BCn-zaxzf/)
- Alınma tarihi: 2026-09-16
- Arşiv notu: LinkedIn makalesinin görünen gövde metni aktarılmıştır; yazım ve anlatım korunmuştur. Görseller kopyalanmamıştır; görsel altyazıları korunmuştur. Son paragraf ve ardından gelen yorumlar sınırı görülmüştür.

- Duyuru gönderisi: [Arşiv kopyası](../posts/7504240409825533952-llm-dusunmez-makale-duyurusu.md) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7504240409825533952/)

---

Geçen gün bir arkadaşıma yapay zeka konusunda bildiğim kadarıyla ve dilim döndüğünce öğrendiklerimi anlattım. O benden daha çok ChatGPT'de ya da Claude'de proje oluşturmak, Cowork'te çalışmak, Claude Code nedir falan gibi sorularına cevap istiyordu ama anlatırken bir şey fark ettim, LLM'in cevaplarının nasıl oluştuğunu tam olarak bilmiyordu, aklında bir şeyler vardı ama mekanizmanın ne olduğuna hakim değildi ama hepimiz gibi maruz kaldığı bütün sosyal medya ve sosyal hayattaki bilgiler neticesinde bir anlam yüklemişti, aklında LLM'in ne olduğuna dair belli belirsiz bir tanım vardı ve LLM'i bir uygulama olarak kullanmak yerine ona insan muamelesi yapıyordu.

Burada LLM'in çıktı üretme sürecini akademik ya da bilimsel seviyede anlatmak benim ne haddime ne de bilgi seviyeme uygun ama kullandığım bir uygulamanın çalışma mekanizmasını kullanımımın kalitesini değerlendirebilecek kadar bilmem gerektiğini düşündüğüm için bir kaç şey öğrendim ya da anladım diyeyim.

### BÖLÜM 1: LLM'İN ÇALIŞMA MANTIĞI

Hemen konuya gireyim, LLM sizi anlamıyor, insan gibi de düşünmüyor. **Hatta hiç düşünmüyor dememde de sakınca yok.** Hemen akılınıza "akıl yürütme", "thinking" gibi şeyler gelecek biliyorum. **Yine de *inatla* "hiç düşünmüyor" diyorum.** İddia etmiyorum, gerçeği söylüyorum. LLM'in verdiği çıktıların tamamamı (literally tamamı) tek bir mekanizmadan çıkıyor, istisnasız. Bu benim yorumum değil, araştırmaların sonunda vardığım hipotez de değil. Gerçek.

Anlatayım dilim döndüğünce;

Mekanizmayı da en basit, sığ haliyle anlatmaya çalışayım, dünyadaki kurulmuş bütün cümlelerin yazılı olduğu bir dosyanızın olduğunu varsayın, ben size gelip bir kelime söyleyeyim ve siz de sonraki kelimenin ne olacağını tahmin edin. Sadece elinizdeki dosyaya bakıp cevap vereceksiniz.

A olsun seçtiğim o kelime ve A kelimesinin geçtiği bütün cümlelere baktığınızda A kelimesinden sonra en çok B kelimesinin geldiğini görün ve bana cevabı B olarak verin.

Sonra baktığınız cümlelerde **A kelimesinin sadece en başta olduğu durumlarda** ise aslında C kelimesinin daha uygun olduğunu fark edin ve artık sadece kelimeye değil kelimenin yerine de bakmaya başlayın.

Sonra D kelimesinin de neredeyse C kadar çok kullanıldığını ve bazı durumlarda da D kelimesinin daha uygun olabileceğini fark edin, o yüzden artık tek cevap vermek yerine **önce bir alternatif kelimeler listesi yaratın (bana göstermeyin) seçenekler de C, D, E, F olsun ve bundan sonra en çok kullanılanı değil de C ve D arasında kalırsanız ikisinden birini şansa seçmeye karar verin.** Artık bir LLM gibi A'dan sonra bazen C bazen de D kelimesini seçeceksiniz.

Ben size A + X + Y kelimelerinden oluşan bir cümle verirsem de önce A, X ve Y kelimeleri için ve kelimelerin cümlede verdiğim sırasını da işin içine dahil ederek, dünyadaki bütün cümleler içinde A + X + Y'ye verilebilecek cevabı yukarıdaki anlattığım mekanizmayı her adımda yeninden çalıştırarak ve sonuçları birikimli olarak bir sonraki turda kullanarak bulun. Bu kadar basit değil ama şöyle yapmış olun, A ve X ve de Y geçen cümlelerden sonra hangi kelime ya da kelimeler gelmiş diye bakın. En çok tekrarlananı seçip cevap verin.

Biraz daha ileri gidip, dünyadaki bütün cümleleri alt alta kocaman bir liste olarak tutmak yerine, dünyadaki bütün cümlelerde kullanılmış kelimelerin diğer kelimelerle kullanım sıklığını ölçtüğünüz bir tablo yaratın, basit bir şey olsun, yani yukarıdaki bahsettiğimiz A kelimesinin B kelimesine olan bağınının güçlülüğüne 90 puan (puanı 90 kere geçmiş diye yorumlamanızda sorun yok) verin. C'ye de 80 verin. Sonra kelimenin yerine göre bakma kuralınızı da dahil edin, A kelimesinin cümle sırasında ilk sırada yer almasına göre B'nin puanını 70'e düşürün, aynı koşul için C'ye 78 verin. D'ye de 77 verin.

Artık iki boyutlu bir **vektör** oluşturdunuz, ilk boyuta göre A kelimesi hiçbir koşul olmadığında B'ye, cümlenin başında olması durumunda baktığımız boyuta göre C'ye daha yakın.

Şimdi A kelimesine başka boyutlar ekleyin, mesela A kelimesi "sıfat" olarak kullanılırsa o zaman D kelimesinin sonraki kelime olma olasılığı dünyadaki tüm cümlelerinizin olduğu listenize baktığınızda daha doğru olsun. (yani daha sık tekrarlansın)

Eğer A kelimesi cümlenin başındaysa ve sıfat olarak kullanılmışsa artık vereceğiniz cevap E olsun.

Sonra dünyada kullanılmış bütün cümlelerdeki bütün kelimeler için bu ilişkiyi kurun, ilişkileri kurarken de zaman, mekan, sıfat, fiil, rakam, miktar, olumlu, olumsuz, büyüklük, küçüklük, kod, işaret, kıslatma, emir, duygu, düşünce, küfür, siyaset, din, cinsiyet vs. aklınıza gelebilecek bütün alternatif kullanım türlerine göre boyutlar ekleyin.

> Yani "basık" kelimesi için "hava basık" ile "oda basık" arasındaki farkı anlayabileceğiniz boyutlar oluşturun. (nasıl yapacaksanız artık 😁) "Basık" kelimesini bir boyuttan bakınca "hava basık" derkenki "basık" anlamını içersin, diğer boyuttan bakınca "oda basık" anlamını içersin.

Böylece bir A kelimesinden sonra farklı boyutlarda B, C ve D kelimelerinin gelebileceğini bulabileceğiniz bir kaynağınız oldu. Buradaki boyutu paralel gerçeklikler gibi düşünebilirsiniz. A kelimesi birinci boyutta fiil olduğunda A kelimesinden sonra en çok B kelimesi kullanılmış o yüzden o boyutta sonraki kelime B ama aynı A kelimesi başka boyutta D kelimesi ile daha çok kullanılmış. Paralel evrenlerdeki A kelimesinin hali diyebiliriz buna. (Hepsi Spiderman ama başka bir boyutta biri Tom Holland, diğeri Andrew Garfield)

Bu kaynağınıza farklı dilleri, farklı kodları da eklerseniz daha fazla konuda çıktı verebilir duruma gelirsiniz. Burada özellikle belirtmek istiyorum, insan olarak sözcüklere alışığız ama aslında dağarcığımızda sadece sözcük yok bizim de, gündelik hayatta matematik de kullanıyoruz, alışveriş yaparken iki parça bir şey aldığımızda, kasada ikisinin parasını ayrı ayrı ödemiyoruz ikisini toplayıp ödüyoruz, kasiyer bize girdi veriyor "Ödeme yap" biz de cevap olarak "Ödeme yaptım" çıktısını vermiyoruz çıktı olarak "100 TL + 60 TL = 160 TL" kodunu çalıştırıyoruz ama "160 TL" diye kasiyerin suratına bağırmıyoruz, 160 TL bizi cüzdanımıza yönlendiriyor, cüzdandan 100'lük, 50'lik ve 10'luk çıkartıp uzatıyoruz. "Ödeme yap" girdisi bizi, bu bağlantıları kurmamıza neden oluyor. **Erken bir örnek olmuş olabilir ama özetle o dünyadaki bütün sözcükler kaynağının içinde kodlar da var demek istiyorum.**

O yüzden aslında bu kelimeler diye adlandırdığımız listedeki öğeler sadece kelime olmadığı için "**token**" diyoruz. Her bir kelimeye token dersek, kelime olmayan metinsel simgelere de token demek için bir format gerekir. Örneğin bir excel formülü yazdığınızı düşünün ***"IF(A=B; 1; 0)"***. Şimdi bu formülü LLM'in bir kelime olarak kabul etmesi mümkün değil ama kullanmak için bir şekilde anlamlı parçalara bölmesi lazım, işte o her anlamılı parçaya aslında "TOKEN" deniyor. Her kelime bir token değil, daha doğrusu farklı sistemler (chatgpt, claude, gemini vb.) farklı "tokenlaştırma" yaklaşımları sergileyebiliyor ama bu bizim için detay.

Bir örnek üzerinden aktarmaya çalışayım; (bunu kendiniz de deneyebilirsiniz) "bugün hava çok" ile başlayan cümleyi tamamlasını isteyin, sadece tek bir kelime ile cümleyi tamamlasın, muhtemelen "güzel" kelimesini seçecek. Yukarda konuştuğumuz çalışma mekanizmasında başka hiçbir değişken olmazsa "bugün", "hava" ve "çok" kelimelerinden sonra gelmesi en muhtemel kelimeyi "güzel" olarak seçecek.

- **Sizin hangi ülkede olduğunuzdan bağımsız** ; *Kuzey Kutbun'da mısınız? Ekvator'da mısınız?*
- **Havanın durumundan bağımsız;** *yağmurlu mu?, güneşli mi?, karlı mı?*
- **Sizin hangi tür havaya "güzel" diyebileceğinizden de bağımsız;** *size göre hafif yağmurlu hava pencereden seyrederken çok güzel olabilir.*

Tek bir şey yapar; dünyadaki bütün kelimelerin olduğu kaynağına bakıp, olasılıksal olarak sonraki kelimenin en yüksek ihtimalle "güzel" kelimesinin olacağını görür ve konuşma penceresine bunu gönderir. *(Google'da arama çubuğuna kelime yazdıkça sonraki kelimeyi önermesi/yazdığımızın yanında göstermesi gibi, sadece "**az biraz daha**" gelişmişi.)*

Bir insandan bunu isterseniz (yani sadece cümleyi tamamla deseniz bile) muhtemelen havaya bir bakış atıp cevap verir. Sadece cümleyi tamamlamasını istediğimiz halde, bir ihtimal gözü havaya kayar ve deneyiminden yararlanır. Hava nasıl diye sormadığımız halde, yine de havanın durumuna göre cevap verebilir. Onun yerine **"Hava bugün nasıl?"** diye sorsak, insan çok daha büyük bir ihtimalle gördüğü, hissettiği havanın durumunu söyleyecektir.

LLM için iş burada daha farklı bir hal alıyor. **Mekanizma aynı değişen bir şey yok**, sadece "her zaman sonraki token'i tahmin ediyor" ama sonraki token bu sefer "güzel" cevabına götürmüyor onu.

Örneğin bugün kelimesi onu oluşturduğu tabloda tarih bilgisini sorgulayan (uyduruyorum kodu) **"TODAY()"** koduna götürüyor, (*çünkü bu sorudaki "bugün" kelimesi boyutsal olarak kod çalıştırılmasına sebebiyet veren bir boyutta, eğitiminde bunu öğrenmiş)* bu çıktı henüz ön yüzde gösterilmiyor, bu kod LLM'in çalıştığı uygulamada (ChatGPT, Claude vs.) bugünün tarihini dönen bir uygulamada çalışıyor, (burada LLM uygulamayı çağırmıyor, çıktısı LLM'in çalıştığı ortamda kodu çalıştırıyor, nerden baktığınıza bağlı) ve kodun sonucu tarih olarak LLM'e geri dönüyor, LLM artık bugünün tarihine ulaştı ama yukarıda bahsettiğim döngüler devam ediyor, henüz çıktı vermedi, **"Hava 11.09.2026'da nasıl?"** şekline dönüşen bağlam bu sefer LLM'in (yine kodu uyduruyorum 😊) "**LOCATION()**" token'ine götürüyor, bu kod konumu veriyor, bağlam değişiyor **"Hava 11.09.2026'da İstanbul'da nasıl?"** hala kullanıcıya çıktı yok, mekanizma bu sefer hava durumu bilgisini almak üzere çalışıyor, hava için dış veri kaynağına sorgu atan koda ulaşıyor (artık o kodu uyduramayacağım bile 😳) sonuç 28 derece dönüyor. Çıktı "İstanbul'da hava 28 derece" gibi bir cevap olabilir ya da mekanizmanın biraz daha devam edip "İstanbul'da hava günlük güneşlik" şeklinde de olabilir. Hatta lokasyon bilgisi sırasında "kullanıcıya sor, bulamadım" tadında bir "token" bile çıkmış olabilirdi bu senaryoda.

Bu mekanizmayı bir hayal etmenizi istiyorum, böyle basit sorular sormuyoruz LLM'e. 10 cümle, 2 paragraf, 30 sayfa PDF dokümanı gibi girdiler veriyoruz. Bu mekanizmanın kurulabilmiş olması bile muazzam bir durum ama yine de mekanizma bu kadar, başka bir şey yok. Sihirli ya da bilinçli bir tercih yok, empati, sempati, kan, ter, gözyaşı yok. Tamamen olasılık hesaplaması. Akıl yürütme de (yani o "thinking") aynı mekanizma, mekanizmanın tekrar tekrar çalışması, sonuca 3 döngüde değil 13 döngüde (ya da adım demek daha doğru) gitmesi, adım sayısı sayısı artınca bağlantılar daha fazla kullanılmış oluyor. Hava durumu örneğinde, tekrarlı şekilde çıktıları girdi olarak kullanmayıp hemen çıktı üretseydi "güzel" diye cevaplayacaktı. Mekanizmayı daha uzun kullandığında, daha fazla olasılığı ortaya koyduğunda, *(tarih, lokasyon, dışardan derece bilgisi gibi)* olasılıklardan ortaya çıkan örüntü vereceği cevabın doğruluğunu artırıyor.

Bu aşamada bu bölümü kapatmak istiyorum. Yapay zeka düşünmüyor, bizi anlamıyor ya da hissetmiyor. Sezmiyor, derin düşünmüyor, akıl yürütmüyor. Girdiye göre örüntülerden çıktı üretiyor. "**Girdiye göre**" ne girdiyse onun arkadaki mekanizmasının kurduğu olasılıksal hesaplamalardan çıktı üretiyor.

Bunu şu an için biz normal kullanıcıların değiştirme şansı yok, müdahale edebildiğimiz tek kısım "Girdi" kısmı.

Ben "araba yıkama" örneğini bu anlamda çok değerli buluyorum. Bilmeyenler için hemen aşağıya görseli ekleyeyim, bir yerden almadım, bu yazıyı yazarken, chatGPT'yi açıp yazdım, sağ yukarda tarihi ve saati görebilirsiniz. Siz de deneyin.

<!-- Görsel kopyalanmadı. -->
ChatGPT 5.5 Hızlı

Buradaki model 5.5 ve düşünmenin en düşük olduğu seçenekte verildi. Geçici ve kişiselleştirmelerin kapalı olduğu modda yaptım.

Aynı soruyu 5.6 Sol ve düşünmenin en düşük olduğu (en hızlı) seçenekte sordum;

<!-- Görsel kopyalanmadı. -->
ChatGPT 5.6 Hızlı

Bizim yazdığımız her kelime ve çıktı olarak bize ulaşan her cevap bu mekanizmadan geçiyor. **AMA girdilerin mekanizmada sırayla işlenmesi sırasında bir bağlamdan doğru bir şekilde devam edebilmek ile bir talebin tamamını doğru şekilde modellemek aynı şey değil.**

Ne demek istiyorum, modellemeyi girdinin kriterleri olarak düşünün, "hava nasıl?" diye sordum ama neden sordum? Ne yapacağım bu bilgi ile? LLM'in olduğu yerin havasını mı sordum, benim bulunduğum yerin havasını mı sordum? Kimin havası bu hava? (model oluşturacağım diye saçmalayan😂) Yoksa "hava nasıl bir şey" anlamında mı sordum? Bazen de "onu demek istemedim yani X derken şu anlamda X" diye açıklarken buluyoruz ya kendimizi.

Burada bahsettiğimiz modelleme girdide olmayan (ya da olan) girdinin kapsamını ve çıktının kullanım amacını anlamamızı sağlayan bilgiler ya da sorgular havuzu gibi düşünün. O influencer'ların bize anlattığı açık olun, detay verin dediği şeyler.

Şimdi burda konuyu araba örneğinden ilerleteceğim, farz edin ki ben bir insan olarak gerçekten araba yıkamacıya arabayı götürmem gerektiği konusunda fikri olmayan biriyim. Arabanın yıkanan bir şey olduğunu duymuşum, arabanın kirlendiğinde yıkanabileceğini öğrenmişim ama arabayı yıkamaya "götürüp" öyle temizlenmesini sağlamam gerektiğini bilmiyorum.

Niye böyle saçmalıyorum, çünkü biz yapay zekadan bu tarz taleplerde bulunuyoruz, "bir web sayfası yapacağım (arabam kirli), öyle çok büyük bir şey istemiyorum (25m)". "Bir rapor hazırla, sadece grafik olsun", "araştırma yap ama özet geç", "sence A mı B mi?" "Hangisi daha iyi?", "Doğrusu neyse onu yap".

Araba yıkma örneğinde bence ben bir insan olarak gayet açıktım, "arabanın kirli" olduğu detayını verdim. Çok yakın olduğunu da söyledim. Sadece kafamı karıştıran çözemediğim konu arabayı götürmeme gerek olup olmadığıydı. Aslında ben araba yıkmaya arabayı götürmem gerektiğini bilmiyorum araba yıkamacıya ulaşmamın arabanın temizlenmesine sebep olacağını sanıyorum. **Ve daha önemlisi LLM'in talebimdeki saçmalığı fark edip doğru yönlendirmeyi yapacağını varsayıyordum.** ***LLM düşünüyor çünkü 😇.***

Onun yerine LLM'in token mekanizmasının farkında olsaydım, muhtemelen aşağıdaki gibi yaklaşırdım. Yine hata yapan ChatGPT 5.5 - Fast modeldeyim ama bu sefer daha fazla girdi veriyorum ve verdiğim girdilerin yakacağı sinyalleri tahmin ederek yazıyorum. Aynı model, aynı mekanizma, sadece daha doğru bir damara bastım.

<!-- Görsel kopyalanmadı. -->
ChatGPT 5.5 - Hızlı

Yönlendirmeyi daha LLM mekaniğine göre değiştiriyorum; bu sefer tokenların tamamını dahil etmesini sağladım

<!-- Görsel kopyalanmadı. -->
ChatGPT 5.5 - Hızlı

Daha fazla uzatmayacağım 😉 Asıl söylemek istediğim ise şu; LLM'in arkasındaki mekanizmanın çıktı verme şekli sadece girdilerin ne olduğuyla bağlantılı değil yani "daha iyi anlatayım, daha detaylı anlatayım, daha çok düşün diyeyim, analiz et diyeyim gibi insansı yönlendirmeler yerine LLM'in çalışma mekanizmasına dokunacak, ondaki olasılıksal sonuçları çoğaltacak, daha fazla işlem yapmasını, hatta daha fazla token tüketmesini ve daha fazla detay yakalamış olmasını sağlamaya çalışmak gerekiyor.

Bir uygulamayı kullanırken, aynı tuşa basıp her işlemi yapmasını beklemediğimiz, her beklediğimiz çıktı için farklı tuşa basmamız gerektiğini bildiğimiz gibi LLM'in de tuşlarını arkadaki mekanizmayı tetikleyen tokenlardan oluşan girdi olduğunu bilmemiz gerekiyor.

BÖLÜM 2: LLM'İN DOĞRU CEVAP VERMESİNİ SAĞLAMAK

O zaman araba yıkama örneğindeki gibi, LLM'nin benin neyi bilip neyi bilmediğimi, hangi varsayımlarla cevap vereceğini tahmin edip o noktaları kapatacak şekilde girdi sağlamam (chat'e yazmam) lazım.

Bu da bizi şuraya götürüyor; *"Bildiğim konuda LLM'i yönlendirecek doğru cümleleri kurma ihtimalim yüksek ama bilmediğim konuda yönlendirme yapma ihtimalim çok daha düşük"*, hatta bence bilmediğin konuda **sonuç alma ihtimalin neredeyse 0.**

Ben sadece bildiğim konularda LLM'i kullanacaksam, o zaman sadece "Daha hızlı" iş yapan bir şeye dönüşür. Ne yapılacağını biliyorum, nasıl yapılacağını biliyorum. Bunu çok iyi tarif edebiliyorum. LLM'in olası hata noktalarını, yanlış yapacağı yerleri biliyorum. Buna göre önlemimi alıp o açıkları da kelimelerle tarif ediyorum. LLM'e sadece "yapmak/yaratmak" kalıyor. Bu yöntemle çalışılabilir, hatta şu anda Instagram'da, Youtube'da gördüğünüz bütün Influencer'ların "yazılımcı" olanları (ben teknik insanlara yazılımcı diyorum 😊) "Yaptım!" diye anlattıkları her şeyi zaten nasıl yapacaklarını bildikleri konularda LLM'i kullanıp yaptıklarını gösteriyorlar. Instagram'da bir de "post paylaşmak" üzerine LLM'i fabrikaya çevirmiş bir kitle var, bunların paylaşımlarımdaki her madde (skill, yapı, repo) paylaşım kalitesini ya da paylaşım etkileşimini artırmak üzerine. Yani ben bir tane insan kaynakları uzmanının "borsa takip uygulaması yaptım" dediğini görmedim, ya da bir tane finansçının "sağlık uygulaması yaptım" dediğini de görmedim. Herkes kendi alanında LLM'i kullanarak, uzman olduğu / bildiği konuda ona doğru girdileri vererek elde ettiği sonuçlarla tatmin oluyor.

Benim bakış açıma göre, dünyanın bilgisine ulaşabilme potansiyeline sahip bu uygulamayı sadece söyleyebildiklerimle yönlendirerek, sonucunda kas gücü olarak kullanmak LLM kullanmak değil. Olasılıksal noktaları benim belirlediğim LLM'e sadece eylemi bıraktığım alan LLM'in en değersiz kullanım biçimi. O yüzden "bildiğim konuda doğru cümlelerle yönlendirmem gerek" LLM'e girişin konusu. Tabi ki doğru cümlelerle yönlendirmek lazım ama burada bahsettiğim, yönlendirme yapılacak işi, alınacak kararı, atılacak adımı, planı LLM'in uzmanlık gerektiren konularda bağlamını o uzmanlıkla doldurup sonra çalışmasını sağlamak olmalı. Yoksa "şimdi kodu buna göre yaz" demek LLM'in en verimsiz kullanıldığı alan.

"Bugün hava çok" cümlesini tamamlarken sadece 3 kelimeden yola çıkıp 4. kelimeyi bulmaya çalışan mekanizmanın 4. kelimeye ilk durakta gitmemesini sağlamak gerekiyor. 4 kelimeyi bulduğunda doğruluğundan emin olacağımız bir 4. kelime bulmasını sağlamamız gerekiyor. 4. kelimeyi bulduğunda o kelimenin hangi koşullarda doğru olacağını, o koşulların netleşmeden 4. kelimeye ulaşılamayacağını, o koşulların cevaplarını bulmak için mekanizmasının el verdiği kadar çok olasılığı, token'ı, thinking'i (adına ne derseniz) ortaya çıkarmasını ve sonra o koşulları tek tek sınayarak, elemesini ve doğru sonuca ulaşmasını sağlamak gerekiyor.

Mesela, vereceği cevapta, cevaba karar kıldığında içinde varsayım var mı yoksa tamamı kanıtlanabilir gerçeklerden mi oluşuyor cevabı oluşturan parametreler? Varsayım varsa, varsayımların hangileri cevabı nasıl değiştiriyor ve hangi varsayım diğer cevabın kullanıcıya sunulma olasılığını 0'a indiriyor ya da yaklaştırıyor.

Örnekle anlatayım, "Bugün hava çok" sonucunda verilebilecek cevapların altındaki varsayımlar olduğunu düşünelim, örnek kolay olduğu için varsayımları burada sıralamıyorum, (lokasyon, zaman, tarih, günün anı, konumun koordinatları vs. gibi bilgileri varsayıyor olabilir LLM) çıktılar ne olabilir bu durumda, güzel, sıcak, soğuk, yağmurlu vb. Şimdi havanın hem sıcak hem de soğuk olma ihtimali olamayacağına göre, sıcak çıktısını sağlayan varsayım ile soğuk çıktısını sağlayan varsayım, iki uç kutupta çıktı üretilmesine sebep oluyorsa, LLM'in vereceği cevap %50 ihtimalle yanlış/doğru olacaktır. LLM'in bize %50 ihtimalle yanlış cevap verme olasılığı üzerinden cevap vermesini istemeyiz diye düşünüyorum. Bu durumda LLM'in mekanizmasının içine gönderdiğimiz girdinin başına "iyi düşün" yazmak cevabın %100 doğru sonuç vermesini sağlar mı? Yoksa "iyi düşünden" çok daha "iyi" çalışacak, mekanizmanın daha derinlere inerek sonuç üretmesini sağlayacak başka bir şeyler yapabilir miyiz?

Burada "doğru cevap vermesini sağlamak için 5 skill" paylaşımı yapmayacağım. Sadece bir bakış açısı kazandırmak adına, yazının son kısmına ufak bir ekleme gibi düşünün. Bir cümle söyleyerek, bir dosya vererek ya da "konuşa konuşa kıvama getirdim, artık anlamıştır niyetimi" gib yaklaşımların yetersiz olduğundan. Yapısal ve metodoloji içeren, sistemsel yönlendirmeden bahsediyorum.

Yazının bu aşamadan sonrası artık Prompt Engineering > Context Engineering > Agentic AI > Harness Engineering diye giden bir serüvene dönüşeceği için burada bitirmek gerekir.

Bütün bu yazının özeti şu; LLM’e insan gibi davranmayı bırakıp, nasıl çalıştığını bildiğimiz bir sistem gibi davranmaya başlamamız gerekiyor. Ondan “daha iyi düşünmesini” istemek yerine, hangi koşulları sınaması gerektiğini, neyi bilmediğini fark etmesini, hangi varsayımlarla ilerlediğini ve hangi noktada dışarıdan bilgiye ihtiyaç duyduğunu tarif edebilmeliyiz. Sonuç, LLM’in bizi ne kadar iyi “anladığından” değil; doğru sonuca giden yolu ne kadar iyi kurduğumuzdan çıkıyor. **Mesele ona doğru cevabı söylemek değil; yanlış cevaba kolayca ulaşamayacağı bir çalışma düzeni kurmak.**
