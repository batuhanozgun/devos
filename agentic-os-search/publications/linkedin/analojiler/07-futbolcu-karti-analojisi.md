# Futbolcu Kartı Analojisi: Uzmanlık Farklı, Entelektüel Taban Yüksek

SOUL üzerine düşünürken Actor'ların hepsinin aynı yeteneklere sahip olması gerektiğini düşünmüyorum. Tam tersine, uzmanlaşmanın gerekli olduğunu düşünüyorum.

Bir Actor güvenlik açıklarını bulmakta çok iyi olabilir ama kod üretiminde ortalama olabilir. Bir başkası yazılım mimarisinde çok güçlü olabilir ama başka bir uzmanlık alanında zayıf olabilir. Araştırmacı, verifier, builder, planner veya başka rollerin farklı kuvvetleri olması doğaldır.

Fakat burada başka bir soru ortaya çıkıyor: Uzmanlıkları farklı olsa bile bütün SOUL Actor'larında yüksek olmasını istediğimiz ortak yetenekler var mı?

Bunu anlatmak için futbolcu kartı analojisini kullanmıştım.

Bir futbol oyunundaki oyuncu kartlarını düşünelim.

Forvetin özellikleri şöyle olabilir:
- şut: 9/10
- bitiricilik: 9/10
- top kontrolü: 8/10
- kalecilik: 2/10

Kalecinin ise:
- refleks: 10/10
- elle kontrol: 9/10
- pozisyon alma: 9/10
- şut: 3/10

olabilir.

Bunda problem yoktur. Zaten bütün oyuncuların aynı özelliklerde yüksek olması beklenmez. Bir forveti iyi forvet yapan özelliklerle kaleciyi iyi kaleci yapan özellikler farklıdır.

SOUL Actor'larını da buna benzer düşünüyorum. Bir security Actor için security reasoning = 10 iken production coding = 5 olabilir. Bir builder için bunun tersi olabilir. Bir araştırmacının kaynak tarama ve hipotez üretme yeteneği çok yüksekken, başka bir Actor'ın sistem tasarımı daha güçlü olabilir.

Bu, uzmanlaşmadır.

Ancak futbolcu kartında başka tür özellikler de vardır: dayanıklılık, oyun görüşü, rakibi okuyabilme, pozisyon farkındalığı, takım oyunu, karar verme, çevresinde olanı anlayabilme.

Bunlar yalnızca tek bir mevkinin özellikleri değildir. Forvetin de oyun görüşüne ihtiyacı vardır. Orta sahanın da vardır. Defansın da vardır. Kalecinin de vardır.

Rolleri farklı olsa bile bazı temel futbol zekâsı ve fiziksel kapasite özelliklerinin bütün oyuncularda belirli bir seviyenin üzerinde olması takımın genel kalitesini ciddi biçimde etkiler.

SOUL için düşündüğüm entelektüel taban buna benziyor.

Bir Actor'ın belirli bir konuda uzman olmaması kabul edilebilir. Ama bunun “O zaman bu Actor yüzeysel düşünebilir.” anlamına gelmemesi gerekir.

Örneğin bir security verifier'ın kod üretme yeteneği builder kadar yüksek olmayabilir. Fakat şunların yine yüksek olmasını isterim:
- problemi doğru anlamaya çalışma,
- varsayımlarını sorgulama,
- eksik bilgi olduğunu fark etme,
- kendi yanılabilirliğini hesaba katma,
- kaynak ile çıkarımı ayırabilme,
- başka Actor'ların çalışmalarının sonuçlarını anlayabilme,
- sistemin genel amacıyla kendi lokal görevini ilişkilendirebilme,
- çelişki gördüğünde durup değerlendirebilme,
- gerektiğinde farklı perspektif arayabilme.

Bunlar güvenlik uzmanlığı değildir. Bunlar daha genel entelektüel çalışma yetenekleridir.

Futbol analojisinin özünü şöyle ifade edebilirim: Takımdaki herkes iyi şut çekmek zorunda değildir. Ama herkes oyunun içinde olduğunu anlayabilmelidir.

Kaleciye “Forvet kadar iyi şut çekmiyorsun.” diye kızmak anlamsızdır. Aynı şekilde araştırma Actor'ına “Neden production builder kadar iyi kod yazmıyorsun?” demek gereksiz olabilir.

Ama kalecinin oyunu hiç okuyamaması, takım arkadaşlarının pozisyonlarını anlamaması, oyunun durumunu fark etmemesi başka tür bir problemdir. Çünkü artık sorun uzmanlaşma farkı değil, oyunun kendisini anlayamama problemidir.

SOUL Actor'larında da buna benzer bir beklentim var. Her Actor bütün işi yapabilmek zorunda değildir. Ama yaptığı parçanın neden var olduğunu, hangi amaca hizmet ettiğini, hangi başka Work'lerle ilişkili olduğunu, hangi bilgiye dayandığını ve sonucunun neyi değiştirebileceğini yeterli ölçüde anlayabilmelidir.

Gerçek futbolda iyi bir oyuncunun önünde yalnızca top yoktur. Oyuncu aynı anda takım arkadaşlarının konumu, rakibin dizilişi, boş alan, skor, zaman, takımın oyun planı ve kendi görevinin bir bölümünü takip eder.

Fakat bu onun her yere koşması gerektiği anlamına gelmez. İyi bir orta saha oyuncusu bütün sahayı görebilir ama bu “Kalecinin yerine de geç.” anlamına gelmez.

Bu ayrım SOUL için özellikle değerli. Actor'ların dar amaçlı ama geniş görüşlü olmasını isterim.

Görevi dar olabilir. Görüş alanı dar olmak zorunda değildir.

Burada builder–verifier analojisiyle de bağlantı kurulabilir. Bir Actor'ın terminal amacı dar ve açık olmalıdır. Verifier verifier'dır. Builder builder'dır. Fakat bu rol ayrımı Actor'ı zihinsel olarak daraltmamalıdır.

Dar terminal amaç ≠ dar entelektüel kapasite.

Futbol diliyle: Mevkisi belli olsun; oyun görüşü yüksek olsun.

İlk analojide özellikle stamina, yani dayanıklılık örneğini kullanmıştım. SOUL açısından stamina'yı yalnız fiziksel dayanıklılık gibi düşünmüyorum. Daha çok çalışma boyunca entelektüel standardı koruyabilmek gibi bir karşılığı var.

Bir Actor ilk turda çok dikkatli, beşinci turda yüzeysel, uzun işte context'i kaybeden, zor problemde varsayımlarını sorgulayıp kolay problemde bunu bırakan bir yapıya dönüşmemeli.

İş uzun sürdüğünde de düşünme disiplinini koruyabilmeli.

Gerçek futbol takımında bütün oyuncuların bütün genel özelliklerinin çok yüksek olması mümkün olmayabilir. Ama SOUL fiziksel dünyanın aynı sınırlamalarına sahip olmak zorunda değildir. Dolayısıyla Actor tasarımında daha iddialı olabiliriz.

Örneğin bütün Actor'larda yüksek reasoning, sistem görüşü, problem framing, contradiction detection, evidence sensitivity, context awareness, uncertainty awareness ve communication discipline isteyebiliriz. Buna karşılık uzmanlık yetenekleri ciddi biçimde farklılaşabilir.

Bu, bütün Actor'ları aynı hale getirmek değildir. Ortak yüksek taban + gerçek uzmanlaşma modelidir.

Development OS, SOUL Actor'larını tasarlarken yalnızca researcher, builder, verifier, planner, security expert, architect gibi bir rol listesi oluşturmamalıdır. Bunun yanında daha temel bir soru sormalıdır:

Bütün bu Actor'larda hangi genel bilişsel ve epistemik özelliklerin yüksek olması gerekiyor?

Uzmanlaşma, düşünme kalitesinin daralması anlamına gelmemelidir. Forvet kaleci değildir. Kaleci orta saha değildir. Fakat hepsi futbolcudur ve oyunu anlamaları gerekir.
