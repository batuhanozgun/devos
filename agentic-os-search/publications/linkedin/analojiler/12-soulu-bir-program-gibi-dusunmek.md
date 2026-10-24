# SOUL'u Bir Program Gibi Düşünmek: Görünmez Muhakemeyi Mekanizma Haline Getirmek

SOUL üzerine düşünürken bir noktada aklıma şu analoji gelmişti:

Biz LLM ile doğal dil üzerinden konuşuyoruz. Kullanıcı kelimelerle bir talep veriyor; model yine kelimelerle cevap veriyor veya GitHub'a bağlanmak, dosya oluşturmak, araç çağırmak gibi aksiyonlar alıyor.

Yüzeyden bakıldığında bu oldukça “insansı” veya akışkan görünüyor. Ama biraz daha mekanik bakınca ortada aslında şuna benzeyen bir yapı var:

girdi → çalışan yapı → çıktı

Bu açıdan SOUL'un çalışma biçimini bir programın çalışma mimarisine benzetmiştim.

Bu, “SOUL aslında deterministik bir yazılımdır” demek değildir. LLM'in üretimi olasılıksaldır; aynı input her zaman birebir aynı output'u vermeyebilir.

Analojinin amacı başka: SOUL'un davranışını oluşturan görünmez parçaları ve aralarındaki geçişleri, bir programın mimarisini inceler gibi açık hale getirebilir miyiz?

Bir yazılım sistemini incelerken yalnız son çıktıya bakmayız. Input nereden geliyor, hangi modül önce çalışıyor, hangi fonksiyon hangi fonksiyonu çağırıyor, hangi veri nerede okunuyor, hangi koşul hangi branch'e götürüyor, hangi çıktı başka bir modülün girdisi oluyor gibi ilişkileri görebiliriz.

SOUL benzeri bir sistemde de bir control dosyası “Bu durumda şu protokolü oku.” diyebilir. O protokol “Şu durumda canonical state'e dön.” diyebilir. State başka bir araştırma router'ına yönlendirebilir. Router ilgili kaynağa götürebilir.

Bu teknik olarak function call ile aynı şey değildir. Ama mimari olarak benzer bir yönlendirme ilişkisi vardır:

A görünür → B'yi aktive eder → B, C'ye gitmeyi gerektirir → C current reasoning'e yeni bilgi getirir

Bu ilişkileri çizilebilir hale getirirsek SOUL'un çalışma biçimi daha az mistik görünür.

Örneğin şöyle bir çalışma kuralımız olduğunu düşünelim:

“Yeni kullanıcı talebini kaydet; fakat henüz üstlenme kararı verilmediyse aktif Work gibi gösterme.”

Bu yalnızca güzel yazılmış bir cümle değildir. Aslında davranışsal bir mekanizma tarif ediyor.

Bir talep geldi. Sistem bazı ayrımlar yapmalı:
- talep geldi mi?
- kayda geçti mi?
- değerlendirilmiş mi?
- üstlenildi mi?
- Work'e dönüştü mü?
- plan içinde mi?

Böylece tek bir doğal dil kuralının altında farklı state'ler vardır.

Bütün bunların gerçek implementasyonda enum veya state machine olması gerektiğini söylemiyorum. Ama SOUL'u tasarlarken bu şekilde düşünmek çok faydalı olabilir.

Çünkü “Agent talebi doğru değerlendirsin.” gibi soyut bir cümle yerine “Hangi bilgi hangi durumda hangi kararı tetikliyor?” sorusunu sorabiliriz.

Doğal dil ile sistem tasarlarken ciddi bir risk var. Bir cümle kulağa doğru gelebilir: “SOUL önce kullanıcı amacını anlamalıdır.” Ama bunun gerçekten çalışan bir sisteme karşılığı nedir?

Ne zaman “anlamış” sayılır? Hangi bilgiye bakar? Belirsizliği nasıl temsil eder? Eksik bilgi olduğunda ne yapar? Ne zaman Work başlatabilir? Yeni bilgi gelirse eski anlayışı nasıl değiştirir?

Bu sorular cevaplanmadıkça elimizde ilke vardır ama mekanizma olmayabilir.

Program analojisi bizi şunu sormaya zorluyor: “Tamam, bu ilke sistem içinde nasıl akıyor?”

Bu soru soyut prensip ile işletilebilir sistem arasındaki boşluğu görünür hale getirir.

Bu analojinin amacı “SOUL'daki bütün reasoning'i if/else'e dönüştürelim.” değildir. LLM'in değerli taraflarından biri zaten açık uçlu reasoning yapabilmesidir. Her davranışı deterministik workflow'a kapatırsak SOUL'un asıl yeteneğini kaybedebiliriz.

İstenen daha çok şudur: Olasılıksal reasoning'in hangi sistemsel sınırlar ve bilgi akışları içinde gerçekleştiğini anlayabilelim.

Actor'ın hangi cevabı vereceğini önceden bilemeyebiliriz. Ama hangi kaynakları görmesi gerektiğini, hangi authority sınırında, hangi Work üzerinde, hangi rol amacıyla, hangi doğrulama sonrasında ve hangi state'i güncelleyerek çalışacağını belirleyebiliriz.

Yani çıktının içeriği olasılıksal olabilir; çalışma mekanizmasının bazı sözleşmeleri açık olabilir.

LLM Actor'ın reasoning'i olasılıksal olabilir. Ama çevresindeki bazı şeyler daha deterministik tasarlanabilir: hangi canonical state okunacak, hangi Actor hangi authority'ye sahip, hangi Work current, hangi kayıt değiştirildi, hangi verifier sonucu üretildi, hangi kullanıcı kararı mevcut.

Bu sayede bütün sistemi tamamen deterministik hale getirmeden Actor'ın serbest reasoning yaptığı kontrollü bir çalışma alanı oluşturabiliriz.

Bir mekanizma haritası yalnız component isimleri koymamalı; nesneleri, işlemleri, ilişkileri ve özellikle geçiş koşullarını göstermeli.

SOUL yalnız metinsel prensipler halinde anlatıldığında bazı eksikler görünmeyebilir. Örneğin “Work doğrulanır.” kulağa mantıklı gelir. Ama mekanizma olarak çizdiğimizde sorular çıkar: verifier'ı kim seçiyor, hangi kaynakları görüyor, verification başarısızsa nereye dönülüyor, kararı kim kabul ediyor?

Bu nedenle görselleştirme yalnız sunum amacı taşımaz. Bir tasarım testi haline gelir.

SOUL'un amacı LLM reasoning'ini mekanik kurallarla değiştirmek değildir. Daha çok reasoning'in etrafındaki çalışma sistemini açık hale getirmektir.

SOUL'u bir program mimarisi gibi düşünmek “SOUL normal bir uygulamadır.” demek değildir. Bu, düşünceyi somutlaştırmak için kullanılan bir lens'tir.

Development OS açısından bunun doğrudan anlamı şudur: Soyut ilkeleri çalışabilir mekanizmalara dönüştürmek gerekir.

Araştırmadan “Verifier builder'dan epistemik olarak ayrılmalıdır.” bulgusu geliyorsa, bunu yalnız dokümana yazmak yetmez. Bu ayrımın hangi Actor düzeniyle sağlanacağını, hangi context'in ayrılacağını, verification'ın ne zaman tetikleneceğini ve verdict'in neyi değiştireceğini düşünmek gerekir.

SOUL'u kullanıcı mesajı girip mucizevi biçimde doğru sonuç çıkan bir kara kutu olarak değil; context, bilgi, state, Work, Actor, authority, reasoning, validation ve feedback ilişkilerinin incelenebilir olduğu bir mekanizma olarak düşünmek istiyorum.

SOUL'un düşünmesini tamamen deterministik hale getirmek değil; SOUL'un hangi mekanizma içinde düşündüğünü incelenebilir hale getirmek istiyorum.
