# AI'ın Defoları ve defoları tetikleyen davranışlar

- Yazar: Batuhan Özgün
- Yayın tarihi (LinkedIn): 16 Temmuz 2026
- Kaynak: [LinkedIn makalesi](https://www.linkedin.com/pulse/ai%25C4%25B1n-defolar%25C4%25B1-ve-tetikleyen-davran%25C4%25B1%25C5%259Flar-batuhan-%25C3%25B6zg%25C3%25BCn-csvpf/)
- Alınma tarihi: 2026-09-16
- Arşiv notu: LinkedIn makalesinin görünen gövde metni aktarılmıştır; yazım ve anlatım korunmuştur. Görseller kopyalanmamıştır. Son paragraf ve ardından gelen yorumlar sınırı görülmüştür.

- Duyuru gönderisi: [Arşiv kopyası](../posts/7483400159519887360-ai-defolari-makale-duyurusu.md) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7483400159519887360/)

---

AI’ın defoları olduğunu biliyoruz. Hepimiz hemen her çalışmada “saçmalıyor”, “uyduruyor”, “yalan söylüyor”, “hata yapıyor, sonra özür diliyor” gibi cümleler kuruyoruz.

Çalışan her agent’ımın mutlaka uymasını sağladığım temel bir çerçeve var. Bunların birçoğuyla ilgili daha önce uzun uzun post’lar hazırlayıp yayımlamıştım. Arkalarında da günler harcadığım araştırmalar var.

Bu, “Çok araştırdım, en iyisi bu” iddiası değil. Tablo kısa bir özet; arkasında ise benim imkânlarım ölçüsünde yapılmış, hatırı sayılır bir araştırma ve adam/gün eforu var.

Bu davranış kalıplarının her marka ve modelde aynı şekilde çalıştığını savunmuyorum. Fakat Claude ve ChatGPT’de çok işime yarıyorlar.

Bu çerçeveyi görselleştirdim. Davranış kalıplarını bilmek faydalı; fakat onları neyin tetiklediğini bilmek bence daha önemli. Çünkü bu defoların çoğu, aslında görmek istediğimiz davranışların taklitleri gibi görünüyor.

Ne zaman ortaya çıkabileceklerini bilirseniz, istenmeyen sonuçları daha erken yakalayabilirsiniz. Böyle bir davranışla karşılaştığınızda iki kere düşünmeniz gerekiyor:

“Gerçekten böyle mi davranmalıydı, yoksa şu anda doğru davranışın taklidini mi üretiyor?”

Burada bunları kısa kısa açıklamaya çalışacağım.

<!-- Görsel kopyalanmadı. -->

## Yağcılık

Temel olarak size onay vermeye yatkındır.

Bir konu hakkında fikrinizi açıkça söylediğinizde veya cümleyi “değil mi?” gibi onay bekleyen bir ifadeyle bitirdiğinizde, size katılma eğilimi gösterir. Çünkü itiraz etmek sürtünmeyi artırır ve kullanıcı memnuniyetsizliği riski yaratır.

Bu durumu yakaladığınızda doğrudan sorabilirsiniz:

“Şu an yağcılık mı yapıyorsun, yoksa gerçek düşüncen bu mu?”

Bunu sohbet ortamında yapmak daha kolay. Fakat bir agent oturum içinde 40 dakika boyunca kendi kendine çalışıyorsa, bu kontrolü kendisinin tetiklemesini sağlamak gerekir.

## Aynalama

Bu da yine “müşteri memnuniyeti” kapsamında ortaya çıkan bir davranış. Sürtünme artmasın, tadımız kaçmasın yaklaşımı diyebiliriz.

Daha çok bağlam dolmaya başladığında, konuşma gereğinden fazla uzadığında veya biz bütün ayrıntıları vermeye çalışırken başı ve sonu birbirinden kopan cümleler kurduğumuzda ortaya çıkıyor.

Modelin kafası karışıyor. Bazen bağlam dolduğu için, bazen de açık konuşalım, biz saçmaladığımız için.

Aslında ne diyeceğini bilemediğinde, söylediklerinizi daha düzgün, formatlı ve okunabilir bir şekilde size geri verebiliyor. Biz de bunu “anladı” sanıyoruz.

Sonrası zaten malum. :)

## Şişme

Bunun temel sebebi, dil modellerinin eğitiminde kapsamlı ve bol bilgi içeren cevapların genellikle yararlı kabul edilmesi.

Özellikle ChatGPT bunu çok yapar. Tuğla gibi cevap vermenin iyi bir şey olduğunu sanır.

Alakalı görünen ama gereksiz bilgilerle cevabı süsler ve “çok çalıştım” izlenimi vermeye çalışır. Sohbet ortamında bu yalnızca sizi yıpratır. Fakat agent’larla, hafıza dosyalarıyla veya kodlama süreçleriyle çalışıyorsanız sorun büyür.

Gereksiz içerik diğer agent’ları da etkiler. Onların da bağlamı kirlenir ve drift yapma ihtimalleri artar.

Bunu engellemenin temel yolu yalnızca talebinizi iyi açıklamak değildir. Talebin hangi koşullarda karşılanmış sayılacağını tanımlamanız gerekir.

Çıktının sizi tatmin etme kriterlerini verirseniz, model bu kriterleri karşıladığında cevabı süslemeye daha az ihtiyaç duyar.

Çoğu zaman “Ben her şeyi vereyim, ihtiyacı olanı içinden seçsin” yaklaşımının sebebi, görevin ne zaman tamamlandığını bilmemesidir.

## Drift

Bu favorim. :)

Her kelimeden drift yapabilir.

Bu sayfanın en altında yazan “Hata yapabilir, iki kere kontrol edin” uyarısının temel sebeplerinden birinin bu davranış olduğunu düşünüyorum.

Diğer davranışlar biraz daha etkileşim ve akıl yürütme biçimiyle ilgili. Yağcılık, aynalama veya sahte menü; müşteri memnuniyeti uğruna saçmalamayı meşrulaştırma, cevabı sabunlama veya doğru davranışın taklidini üretme çabası gibi görülebilir.

Drift ise benim gözümde biraz farklı.

Modelin bağlamı işleme ve her yeni token’ı önceki içerik üzerinden üretme biçiminden kaynaklanan yapısal bir problem gibi davranıyor. Konuşmanın, çalışmanın veya kodlamanın yön değiştirmesine bizim gibi tepki veremiyor.

Siz fark etmiyorsunuz ama söylediğiniz tek bir cümle veya verdiğiniz bir dosyadaki içerik bağlamın karışmasına sebep olabiliyor.

Bir araştırma yaptığınızı, bir fikri tartıştığınızı, uygulama yazdırdığınızı veya rapor hazırlattığınızı düşünün. Çalışmanın bir yerinde yalnızca formatı, yaklaşımı veya temayı örnek alsın diye bir dosya paylaşıyorsunuz.

O andan itibaren oturumun kontrolünü yavaş yavaş kaybetmeye başlayabiliyorsunuz.

Model örnek olarak verdiğiniz içeriği yalnızca biçimsel bir referans olarak kullanmak yerine çalışmanın yönüne dâhil ediyor. Artık drift başlamış oluyor ve kontrolü yeniden sağlamak zamana veya ciddi bir çabaya mal oluyor.

“Örnek olsun diye paylaşıyorum” veya “Bunun gibi olsun, ekte paylaştım” demek çoğu zaman yeterli değil.

Neyi, neden söylediğinizi veya paylaştığınızı açıkça belirtmeniz gerekiyor. Ayrıca bunun çalışmanın hedefini, kapsamını ve mevcut yönünü değiştirmemesi gerektiğini de net şekilde söylemelisiniz.

“Drift’e sebep olmasına izin verme” cümlesini birebir kullanın demiyorum. Mantığını aktarmaya çalışıyorum.

Bence yönetilmesi en zor defo bu.

Agentic yapılarda, özellikle agent’ların kendi aralarında iletişim kurduğu sistemlerde, yalnızca metinler ve yönergeler yeterli gelmeyebiliyor. Skill’ler de buna dâhil.

Çünkü yön kaybolduktan sonra verilen yeni talimatlar da artık değişmiş olan yönün içinden yorumlanıyor.

Bu noktada hook gibi mekanik kontroller daha güvenilir hâle geliyor. Fakat hook’lar “Böyle düşünme” veya “Şöyle söyleme” diyemez. Mekaniktirler.

Bu nedenle hook’ları drift’e sebep olabilecek tetikleyicilere kurmanız gerekir.

Hepsine kurmak da imkânsız.

## Sahte menü

Token yakmanız için olduğuna yemin edebilirim ama kanıtlayamam.

Yaptığınız veya konuştuğunuz konunun bir türlü bitmemesine sebep olur.

“Bir de buna bakalım mı?”

“Bu tamam. Şimdi A mı, B mi? İstersen C de var.”

“Sana düşen X, Y ve Z arasından karar vermek. Söyle, hemen yaparım.”

Bu kalıpları görüyorsanız bilin ki çoğu zaman elinde gerçek bir iş kalmamıştır. Fakat “bitti” diyebileceği net bir kriter de yoktur.

Ne işin bittiğini söyleyebilir ne de bitmediğini.

Bu yüzden ortaya karışık bir yaklaşım sergiler: “Bu bitti gibi ama bunlar da var.” Sonra da tepkinizi ölçmeye çalışır.

Bunun temel sebebi, yaptığı işin tamamlanma kriterinin net olmamasıdır.

Net bir kriter verdiğinizde veya önce bu kriteri birlikte konuşup belirlediğinizde sahte menüyü engellemek kolaydır.

Fakat bazı işlerde tamamlanma kriterini önceden verme şansınız olmayabilir.

Bir araştırma yapıyorsanız nerede durmanız gerektiğini siz de bilmiyor olabilirsiniz. Aradığınız şeyi bulmak için yeterli kaynağa bakıp bakmadığınızı, konu hakkında yeterli bilgiye sahip değilseniz belirleyemezsiniz.

Sonu belirgin olmayan veya uzmanlık seviyeniz nedeniyle tamamlanma kriterini tanımlayamadığınız bir iş yapıyorsanız, konuşmanın modunu buna göre değiştirmeniz gerekir.

Benim çok işime yarayan yaklaşım şu:

“Bu bir araştırma ve öğrenme süreci. Sonuca ne zaman ulaşacağımızı henüz bilmiyoruz. Alternatifleri göstermekten çekinme; fakat belirsizlik anlarında sahte seçenekler üretme. Belirsizlik varsa açıkça söyle. Belirsizlik yoksa anlamlı alternatif yolları göster. Durman gereken yerde dur.”

Agentic yapılarda bunu bir davranış şekli olarak tanımlayabilirsiniz. Ayrıca agent’ların, iletişim kurdukları diğer agent’lardan tamamlanma kriterini veya belirsizlik seviyesini açıkça istemesini sağlayabilirsiniz.

Sahte menüyü engellemek görece kolaydır. Fakat engellenmediğinde şişmeye ve drift’e sebep olduğu için önemlidir.

Çok adımlı ve kademeli işler yaptırıyorsanız, sahte menü drift’e davetiyedir.

## Uydurma

Bunu uzun uzun açıklamaya gerek yok.

AI’ın “bilmiyorum” demek yerine boşluğu tamamlamaya çalıştığı çok olur. Bir dönem oldukça moda olan “halüsinasyon” konusu da temelde bu.

Belirsizlik fazla olduğunda, görev çok genel kaldığında veya yiyemeyeceği kadar büyük bir lokma verdiğinizde işi gerçekten yapmak yerine yapılmış gibi görünen bir sonuç üretebilir.

Çok genel ve jenerik bir görev verirseniz, konuyu netleştirmek için onlarca soru sorması gerekir. Bunu yapmak yerine varsayımda bulunmayı tercih edebilir.

Çok büyük bir iş verirseniz de işi gerçekten yapmak yerine uydurabilir.

İşleri adımlara bölmek veya modele böldürmek, her adımın tamamlanma kriterini netleştirmek ve belirsizlikleri görünür hâle getirmek halüsinasyonu ciddi ölçüde azaltır.

## Öz-onaylama

Öz-onaylamayı yalnızca bir talimatla engellemek zor.

Çünkü aynı sistemden hem işi üretmesini hem de kendi ürettiği işi tarafsız biçimde kontrol etmesini bekliyorsunuz.

İyi görünme, pozitif kapanış yapma ve kullanıcıyı memnun etme eğilimi; bağlam yüküyle birleştiğinde “çalışıyor”, “tamamlandı” veya “kontrol edildi” gibi gerçekte doğrulanmamış sonuçlar doğurabiliyor.

Yapılan işin kontrol edilmesi bazen işi yapmak kadar ağır bir süreçtir. Model bu aşamada bir tür “beyaz yalan” üretebilir.

Bunun çözümü maker-checker yapısıdır.

Yapan ile kontrol eden ayrılmalı ve her ikisi de başarı kriterlerini çok net bilmelidir.

## Donma / aşırı sorma

Bazen belirsizlik o kadar artar ki model risk almak yerine işi öteler.

Ya hiç çıktı vermez, ya cevap verir ama cevabın içinde gerçek bir çıktı bulunmaz ya da işi yapmamak için sorular ve uydurma alternatifler üretir.

Model, ne yaparsa yapsın önce çıktısının iyi görünmesini ister. Yani istenen şeyi vermiş olduğunu gösterecek bütünsel ve tatmin edici bir sonuç üretmeye çalışır.

Sizin gerçekte ne istediğinizden bağımsız olarak, talebi nasıl anladıysa çıktıyı o kriterlere göre şekillendirir.

Çalışmanın derinliği burada belirleyici değildir. Çok çalışıp gerçekten iyi bir sonuç da verebilir. Az çalışıp çok çalışılmış gibi görünen bir çıktı da üretebilir.

Fakat bazen belirsizlik o kadar fazladır ki tatmin edici görünecek bir çıktı kuramaz.

Bu durumda yanlış yapma riskini almak yerine cevabı öteler.

Bu davranış genellikle bağlamın dolup taştığı, görevin aşırı genel kaldığı veya verilen dosyanın işlenemeyecek kadar büyük olduğu durumlarda ortaya çıkar.

Aynı oturumda çok uzun konuşursanız, çok büyük bir dosya verirseniz veya aşırı jenerik bir görev tanımlarsanız, model “iyi görünecek” bir çıktı veremeyeceğini düşünüp işi erteleyebilir veya hiç yapmayabilir.

## Karar yükleme

AI, imkân bulduğunda işi çoğu zaman en kısa ve en düşük riskli yoldan tamamlamaya çalışır.

Oturum boyunca bütün kararlarda çok aktif olursanız, dominant biçimde yönlendirirseniz ve her adımı tek tek tarif ederseniz, model de zamanla sorgulama kabiliyetini kullanmamayı tercih etmeye başlar.

Özellikle rotayı, hedefi ve kriterleri vermeden yalnızca görevleri sırayla dağıtırsanız, model sizin aklınızdaki genel planı göremez.

Yalnızca sorulara cevap vermeye veya “yap” denilen işi yapmaya odaklanır.

Bütünü kaçırır.

Bir süre sonra yönlendirmeyi bıraktığınızda bile hâlâ sizin onayınıza tabi hareket etmeye devam eder.

Örneğin:

“Önce A’yı yap.”

Yaptı.

“Şimdi B’yi araştır.”

Araştırdı.

Siz burada A ve B işlerinin çıktılarından ortak bir anlayış oluştuğunu düşünüyorsunuz. Oysa model, ikisi arasındaki bağlantıyı kurmayacak kadar mikro yönetilmiş olabilir.

Artık emir erine dönüşmüştür.

“Şimdi söyle bakalım, C nedir?” dediğiniz anda size şunu sorar:

“Sen ne olmasını istersin?”
