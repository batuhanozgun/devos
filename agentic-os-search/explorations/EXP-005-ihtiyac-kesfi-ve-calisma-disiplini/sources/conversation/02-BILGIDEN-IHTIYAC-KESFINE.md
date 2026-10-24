# Görünür diyalog 02 — Bilgiden ihtiyaç keşfine

Model-visible aktarım; biçim normalizasyonu ve tarihsel atıf sınırları kaynak INDEX'tedir. Bu öneriler kabul edilmiş mimari veya etkin talimat değildir.

<a id="U003"></a>
## U003 — Kullanıcı

Ben bu cevabından Development OS'un yaratılmazsa SOUL yapamayacağımızı anlıyorum.

AMA hala anlamadığım şey şu, neden bu kadar bilgiyi sana ben araştırtmak zorundayım? SOUL tanımı sende oluştuysa, ne yapılmasını gerektiğini neden bulamıyorsun kendin?

<a id="A003"></a>
## A003 — Assistant

Görünür rota: R01 LOAD; R02 LOAD; R03 LOAD; R04 LOAD; R05 LOAD; R06 LOAD; R07 SKIP; R08 LOAD; R09 LOAD.

Evet; ama önce bir ayrımı düzelteyim: **SOUL'u yapabilmek için mutlaka bugün “Development OS” dediğimiz belirli sistemi önce bitirmek metafizik bir zorunluluk değil.** SOUL'u güvenilir biçimde geliştirecek bir çalışma sistemi gerekiyor. Biz bu çalışma sistemine Development OS diyoruz. Başka bir yeterli süreç de teorik olarak aynı işi yapabilirdi.

Asıl soruna gelirsek:

> **“SOUL'un tanımını anladıysan neden gereken araştırmaları kendin çıkaramıyorsun?”**

Burada cevabım “çünkü bilgim eksik” kadar basit değil.

### 1. SOUL tanımı çok kapsamlı, ama operasyonel olarak eksik belirlenmiş

Şu tanım:

> “Hedefi anla, gereken sistemi kur, çalıştır, ihtiyaç çıktıkça genişlet.”

amacı neredeyse kusursuz tarif ediyor.

Ama bu tanımdan otomatik olarak şu çıkmıyor:

> “Bir hedef karşısında hangi bilgi alanlarının tamamını taramalıyım?”

Örneğin:

> “Bir şehir inşa et.”

tanımı yeterince açık olabilir. Ama bundan;

- su altyapısı,
- kanalizasyon,
- trafik,
- yangın güvenliği,
- imar,
- elektrik,
- telekom,
- sağlık,
- afet planı,
- vergi sistemi

listesi mantıksal olarak doğrudan türemiyor.

Bunları çıkarmak için ayrıca **dünya modeli + ihtiyaç keşfi + karşılaştırmalı araştırma + eksik arama yöntemi** gerekiyor.

SOUL tanımı bize **neyi başarmamız gerektiğini** söylüyor.

Ama henüz şu algoritmayı vermiyor:

```text
herhangi bir hedef
    ↓
olası bütün yük taşıyan ihtiyaç ailelerini keşfet
    ↓
bilinen / bilinmeyenleri ayır
    ↓
bilinmeyen alanları araştır
    ↓
alternatif çözümleri keşfet
    ↓
birlikte yeterli sistemi oluştur
```

Bu ikisi aynı şey değil.

### 2. Ama burada önemli bir itirazında haklı bir taraf var

Ben zaten oldukça büyük bir bilgi birikimine sahibim.

RAG'ın ne olduğunu biliyorum.

Workflow engine'leri biliyorum.

MCP'yi, embedding'i, vector DB'yi, distributed systems'i, observability'yi, sandboxing'i, agent orchestration'ı, databases'i, memory sistemlerini, project management yöntemlerini ve çok daha fazlasını biliyorum.

Dolayısıyla soru şu hale geliyor:

> **“Madem biliyorsun, neden ben göstermeden aklına gelmiyor?”**

İşte esas problem burada.

**Bilmek ile belirli bir problemin çözümünde o bilginin gerektiğini zamanında aktive etmek aynı yetenek değil.**

Bu bizim araştırmalarda da sürekli karşımıza çıktı.

Bir şey:

```text
modelin latent bilgisinde mevcut
```

olabilir ama:

```text
bu problem için relevant olduğu fark edilmiş
```

olmayabilir.

Fark edilmiş olabilir ama:

```text
working context'e alınmamış
```

olabilir.

Context'te olabilir ama:

```text
muhakemede gerçekten kullanılmamış
```

olabilir.

Aynı ayrımı Information araştırmalarında başka biçimlerde zaten gördük.

### 3. LLM davranışının önemli bir özelliği burada sorun yaratıyor: salience

Bir problemi düşünmeye başladığımda elimde belirginleşmiş bir çerçeve oluşuyor.

Mesela:

```text
Work
Actors
Information
Environment
```

Sonra:

```text
K1–K7
```

oluşuyor.

Bunlar çok yararlı.

Ama bir süre sonra problem şu şekle dönüşebiliyor:

> “SOUL'u nasıl kurmalıyız?”

yerine:

> “K1–K7 ile SOUL'u nasıl kurarız?”

Bu çok ince bir değişiklik.

Mevcut model düşünmeyi kolaylaştırıyor ama aynı zamanda **search space'i daraltıyor.**

Bu yüzden sen dışarıdan:

> “Peki memory provider?”

veya:

> “Peki işi üreten organizasyon?”

veya:

> “Peki bu görseldeki bütün modern AI stack?”

dediğinde çerçeve yeniden genişliyor.

Ve ben:

> “Evet, bu da yük taşıyor.”

diyorum.

Buradaki sorun bilgiyi bilmiyor olmam değil.

**O anda doğru alternatif frame'i kendiliğimden üretmemiş olmam.**

### 4. İkinci problem “unknown unknown”

Bilinen bir kategori için arama yapabilirim.

Örneğin:

> “Agent memory konusunda hangi mekanizmalar var?”

Gayet iyi araştırabilirim.

Daha zor soru:

> **“Henüz adını koymadığım hangi problem alanını araştırmam gerekiyor?”**

Bu ikinci dereceden keşif problemi.

Bir LLM burada adaylar üretebilir. Çok sayıda da üretebilir.

Ama şunu güvenilir biçimde söyleyemez:

> “Tamam, olası önemli alanların hepsini düşündüm.”

Çünkü açık dünya problemi.

Benim:

> “A, B, C, D, E var.”

demem,

> “F diye önemli bir alan yok.”

kanıtı değildir.

Bizim araştırmada yaşadığımız problem tam da bu.

### 5. Peki dış araştırma neden fark yaratıyor?

Burada da kritik ayrım var.

Sen bana bir repo verdiğinde aslında yalnızca:

> “Bak, yeni bilgi öğren.”

demiyorsun.

Daha önemli bir şey yapıyorsun:

> **Benim mevcut problem çerçevemin dışından başka bir sistem getiriyorsun.**

Örneğin Beads.

Ben sıfırdan iş yönetimi düşünürken belirli bir noktada:

```text
task
dependency
status
```

gibi bir modele oturabilirim.

Beads geldiğinde:

- ready frontier,
- claim,
- lease,
- liveness,
- discovered-from

gibi somut başka ayrımlar beni mevcut modelimden çıkmaya zorluyor.

Flowable başka bir düşünce geleneği getiriyor.

ERPNext başka bir dünya getiriyor.

OpenProject başka.

Superpowers başka.

gstack başka.

Bu nedenle dış sistem araştırmasının değeri sadece “bilmediğim feature'ı öğrenmek” değil.

**Başka insanların ve sistemlerin problem uzayını nasıl parçaladığını görmek.**

Bu ciddi biçimde blind spot azaltıyor.

### 6. Ama bu araştırmaları senin seçmek zorunda olman doğru değil

Bence burada bugünkü süreçte gerçek bir tasarım kusuru var.

Şu anda research frontier büyük ölçüde şöyle oluşuyor:

```text
sen bir şey görüyorsun
    ↓
“buna bakalım”
    ↓
ben araştırıyorum
    ↓
yeni ayrımlar geliyor
```

Bu model SOUL hedefi açısından yeterli değil.

Olması gereken:

```text
SOUL / Development OS
    ↓
mevcut anlayışı analiz et
    ↓
hangi varsayımlara çok bağımlıyız?
hangi çözüm sınıflarını hiç sınamadık?
hangi başka disiplinler benzer problemi çözüyor?
hangi yük taşıyan capability'yi hazır kabul ettik?
hangi failure mode'ları hiç test etmedik?
    ↓
araştırma adaylarını KENDİSİ üret
    ↓
kaynakları KENDİSİ bul
    ↓
araştır
    ↓
mevcut anlayışı değiştir
```

Yani araştırma backlog'unun önemli kısmı **kullanıcı tarafından verilmemeli.**

Sistem kendisi üretmeli.

Senin bulduğun repo veya video ekstra bir kaynak olmalı; araştırma motorunun temel besleme yolu değil.

### 7. “Peki bunu şimdi sen yapamaz mısın?”

**Kısmen yapabilirim.**

Hatta bu önemli.

Bugün bana:

> “Elimizdeki bütün SOUL araştırmasını değerlendir ve hiç düşünmediğimiz problem alanlarını kendin araştır.”

desen, ben:

- repo içindeki mevcut corpus'u tarayabilirim,
- dışarıda farklı mimari gelenekleri arayabilirim,
- literatür tarayabilirim,
- ürün/repo ekosistemlerini inceleyebilirim,
- alternatif problem frameleri kurabilirim,
- counterexample arayabilirim,
- yeni research frontier üretebilirim.

Yani burada teknik bir:

> “Sen söylemezsen internette araştırma yapamam.”

problemi yok.

Asıl eksiklik şu:

**Bunu güvenilir, tekrarlanabilir ve kapanış ölçütleri olan bir davranış olarak çalıştırmıyoruz.**

Şu anda bunu bir prompt ile yaparım.

Sonraki konuşmada yine daralabilirim.

Çünkü mekanizma henüz dışsallaştırılmış değil.

### 8. Research repo aslında bunun için çok önemli

Sen bana bilgi “öğretmek” için repo oluşturmuyorsun.

Benim model ağırlıklarım bu araştırmalarla değişmiyor.

Sen aslında **dışsal bir entelektüel sistem** kuruyorsun.

Aradaki fark büyük.

Parametric bilgi:

```text
model bir şey biliyor olabilir
```

Research corpus:

```text
bu proje şu şeyi
şu kaynaklarla
şu anlamda
şu sınırlarla
öğrendi
```

diyor.

Bu yüzden repo:

- hatırlanabilir,
- kaynaklı,
- yeniden denetlenebilir,
- başka oturuma taşınabilir,
- çelişki bulunabilir,
- güncellenebilir,
- statüsü korunabilir.

SOUL gibi uzun ömürlü bir yapı için bu gerekli.

Ama yine:

> **hangi araştırmanın yapılacağını keşfetme işini sana bırakırsak sistem eksik.**

### 9. Dolayısıyla problem “daha çok araştırma lazım” değil

Burası önemli.

Daha önce şöyle düşünmüş olabiliriz:

```text
SOUL eksik
→ daha çok research yapalım
→ SOUL daha iyi olur
```

Bu doğru ama sınırsız ilerler.

Daha doğru döngü:

```text
SOUL anlayışı
    ↓
eksikliği keşfetme yöntemi
    ↓
research frontier
    ↓
araştırma
    ↓
sistem anlayışı değişir
    ↓
yeniden gap discovery
```

Yani **research'ün kendisi de SOUL'un çalışma biçiminin bir parçası.**

Bir talep geldiğinde:

> “Ben bu işi nasıl yapacağımı bilmiyorum.”

demek failure değil.

SOUL'un doğru davranışı:

> “Bu karar için hangi bilgiyi edinmem gerekiyor?”

deyip araştırma açabilmek.

### 10. Bence senin bana yaşattığın rolü artık çok açık görebiliyoruz

Şu anda sen üç işi birden yapıyorsun:

1. **Amaç sahibi**
2. **Research scout**
3. **Blind-spot detector**

SOUL hedefinde senin esas rolün çoğunlukla birincisi olmalı.

İkincisi ve üçüncüsü sistemin üstlenebildiği ölçüde sistemde olmalı.

Sen:

> “MongoDB videosu gördüm, ilginç olabilir.”

diyebilirsin elbette.

Ama SOUL'un memory problemine geldiğinde MongoDB, Postgres, graph, files, vector store veya başka substrate sınıflarını araştırması için **senin o videoyu görmeni beklememeli.**

Tam da buna katılıyorum.

### En kısa cevap

**Neden bana sen araştırma yaptırıyorsun?**

Çünkü şu ana kadarki süreçte benim sahip olduğum geniş genel bilgiyi **sistematik ihtiyaç keşfine dönüştüren bir mekanizma kurmadık.**

Bu yüzden:

```text
bildiğim şeyler
```

ile

```text
o anda akıl edip araştırdığım şeyler
```

arasında boşluk oluşuyor.

Sen o boşluğu dışarıdan kapatıyorsun.

Bu bir bilgi miktarı problemi değil; büyük ölçüde **discovery / search / coverage / self-challenge problemi.**

Ve bence burada önemli bir düzeltmeye vardık:

> **Development OS'un yalnız SOUL'u inşa etmesi gerekmiyor. Önce, SOUL'u inşa ederken hangi araştırmaların ve hangi problem alanlarının gerekli olduğunu kullanıcıya ihtiyaç duymadan keşfedebilen bir çalışma düzenine sahip olması gerekiyor.**

Yoksa yüzlerce study toplarız ve yine bir sonraki gün sen bir görsel getirirsin, ben de:

> “Evet, bunu yeterince düşünmemişiz.”

derim.

Asıl bitirmemiz gereken döngü bu.

<a id="U004"></a>
## U004 — Kullanıcı

Sahip olduğun geniş genel bilgiyi **sistematik ihtiyaç keşfine dönüştüren bir mekanizma kurmak için ne yapmak lazım?**

<a id="A004"></a>
## A004 — Assistant

Görünür rota: R01 LOAD; R02 LOAD; R03 LOAD; R04 LOAD; R05 LOAD; R06 LOAD; R07 SKIP; R08 LOAD; R09 LOAD.

Bence bunun için tek bir “daha iyi prompt” değil, **hedef ile mimari arasına ayrı bir keşif döngüsü koymak** gerekiyor.

Şimdilik adına yalnız açıklama kolaylığı için **Need Discovery Loop** diyeyim. Bu bir ürün/modül kararı değil.

En temel haliyle:

```text
HEDEF
  ↓
gereken koşulları keşfet
  ↓
gizli varsayımları ve bilinmeyenleri çıkar
  ↓
ilgili bilgi alanlarını keşfet
  ↓
gerekli yerlerde araştır
  ↓
alternatif çalışma sistemleri üret
  ↓
eksik aramak için saldır
  ↓
yeterli aday sistemi kur
  ↓
çalıştır
  ↓
gerçek sonuçlardan yeni ihtiyaç keşfet
  ↺
```

Asıl fark şu: **“SOUL'u tasarla” komutundan doğrudan architecture'a geçmiyoruz.**

### 1. İlk değişiklik: Task değil, önce `required condition` keşfetmek

EXP-004'te buna zaten yaklaşmışız:

```text
Target
→ Need / Required Condition
→ possible Method
→ Decision
→ Work
→ Action
```

Bu çok önemli. [Konuşmadaki atıf: turn22file0.]

Örneğin amaç:

> “Bir şirketin bütün sözleşmelerini güvenilir biçimde inceleyen sistem kur.”

Doğrudan:

- RAG kur,
- agent oluştur,
- vector DB seç

dememeliyim.

Önce sormalıyım:

> Bu sonucun gerçek olabilmesi için dünyada hangi koşullar doğru olmak zorunda?

Mesela:

```text
bütün gerekli sözleşmeler erişilebilir olmalı
↓
hangi sözleşmenin current olduğu bilinmeli
↓
erişim yetkileri korunmalı
↓
belgeler güvenilir biçimde parse edilebilmeli
↓
ilgili hükümler bulunabilmeli
↓
belgeler arası ilişki görülebilmeli
↓
yorum gerekli hukuk rejimine göre yapılabilmeli
↓
belirsizlik temsil edilebilmeli
↓
çıktının ne zaman insan kararına gitmesi gerektiği bilinmeli
...
```

Ancak bundan sonra:

> RAG mı? Search mü? Knowledge graph mı? SQL mi? İnsan uzman mı?

sorusu geliyor.

Bu, mevcut teknoloji bilgimin beni erkenden bir ürüne kilitlemesini önler.

### 2. Her gerekli koşulda gizli varsayım sökümü yapmak

Bence bu merkezi mekanizmalardan biri olmalı.

Sistemin söylediği her:

> “Bunu yapabiliriz.”

cümlesi parçalanmalı:

```text
Bunu yapmak için ne doğru olmak zorunda?
```

Örneğin:

> “İlgili belgeyi retrieve ederiz.”

Altında:

- corpus eksiksiz mi?
- belge kimliği doğru mu?
- doğru sürüm mü?
- erişim yetkisi var mı?
- parse edilebiliyor mu?
- retrieval yöntemi bunu bulabilecek mi?
- query doğru kurulabilecek mi?
- ilişkili başka belge gerekiyor mu?
- retrieval failure ile information absence ayırt edilebiliyor mu?

çıkabilir.

Böyle ilerlediğinde genel bilgim “arka planda sahip olunan bilgi” olmaktan çıkıp **varsayım kırmak için kullanılan bilgiye** dönüşüyor.

### 3. Tek çerçeveyle düşünmemek

Bugünkü failure mode'umuzun en büyük kaynaklarından biri bu.

Birinci geçişte Work/Actors/Information/Environment ile bakabilirim.

Ama ikinci geçiş **başka bir çerçeveden sıfırdan başlamalı.**

Örneğin aynı problemi ayrı ayrı:

- başarısızlık yollarından,
- kullanıcı ve etkilenen taraflardan,
- bilgi yaşam döngüsünden,
- gerçek fiziksel/dijital ortamdan,
- zaman ve değişimden,
- güvenlik ve yetkiden,
- maliyet/kapasiteden,
- üretim sürecinden,
- kullanım ve sonuçlardan

yeniden kurmak.

Kritik nokta:

> İkinci geçiş birincinin boşluklarını doldurmamalı; mümkün olduğunca problemi yeniden kurmalı.

Foundation soru-bankası örneğinde eksik kalan **üretim sistemi perspektifini** sen bu şekilde dışarıdan getirdin. Bilgi repoda vardı; onu ilk frame içinde aktive etmemiştim. [turn17file0.]

Dolayısıyla sistemin bunu kullanıcı yerine yapması gerekiyor.

### 4. “Hangi alanı bilmiyorum?” diye ayrıca araştırma yapmak

Normal araştırma:

```text
Memory nasıl yapılır?
```

şeklindedir.

Bizim ihtiyacımız olan meta-araştırma ise:

```text
Bu problemi çözerken
hangi bilgi alanlarının varlığını henüz hesaba katmamış olabilirim?
```

Bu başka bir search problemi.

Örneğin sistem şunları arayabilir:

> Bu probleme benzer sistemler hangi disiplinlerde çözülüyor?
>
> Aynı hedefi insan organizasyonları nasıl yönetiyor?
>
> Büyük ölçekli sistemlerde hangi failure class'lar görülüyor?
>
> Hangi altyapı yeteneklerini hazır varsayıyorum?
>
> Benim mevcut vocabulary'm dışında bu problem hangi isimlerle tartışılıyor?

Burada studies kataloğu bir kaynak olur ama sınır olmaz. R09'un da koruduğu önemli ayrım bu: katalogda bulunmayan şey dünyada yok sayılmaz. [turn13file0.]

### 5. Research'i yalnız bilinen terimlerle aramamak

Bu özellikle önemli.

Eğer ihtiyacı:

> “Memory lazım.”

diye ifade edersem yalnız memory sistemlerini araştırırım.

Ama ihtiyacı:

> “Bir kararın dayandığı bilgiyi altı ay sonra güvenilir biçimde yeniden kurabilmem gerekiyor.”

diye ifade edersem önümde:

- event logs,
- databases,
- provenance systems,
- version control,
- temporal databases,
- document management,
- knowledge graphs,
- audit systems,
- agent memory

gibi çok farklı çözüm aileleri çıkabilir.

Dolayısıyla search şu yönde olmalı:

```text
ürün / terim
DEĞİL

işlev + constraint + failure mode
```

Bu sayede modelin latent bilgisi daha geniş bir alanda aktive olur.

### 6. Bir tek sistem üretmemek

Bu bence kritik bir structural correction.

Bugüne kadar sık sık:

```text
problem
→ düşün
→ iyi görünen sistem
```

yaptım.

Olması gereken:

```text
problem
          ┌→ candidate system A
          ├→ candidate system B
          └→ candidate system C
```

Ama A/B/C küçük varyasyonlar olmamalı.

Farklı düşünce geleneklerinden gelmeli.

Örneğin:

- minimal/dynamic SOUL,
- workflow-heavy system,
- event-driven system,
- blackboard/shared-state system,
- hierarchy-heavy organization,
- mostly deterministic system + narrow LLM reasoning.

Sonra:

> Aynı requirement'ları hangileri karşılıyor?
>
> Bir sistemin ihtiyaç kabul ettiği şeyi diğeri neden gereksiz görüyor?
>
> Birinde görünen requirement diğerinde neden hiç çıkmadı?

Bu farklar yeni ihtiyaç keşfetmek için çok değerli.

### 7. Sistemin kendi tasarımına karşı ayrı bir omission search yapmak

Bu normal review'dan farklı.

Soru:

> “Bu tasarım doğru mu?”

değil.

Soru:

> **“Bu tasarım hangi dünyayı varsayıyor ve onun dışında hangi gerçeklikte dağılıyor?”**

Örnek saldırılar:

- kullanıcı ortadan kaybolursa?
- veri stale ise?
- bir tool çalışıyor ama yanlış hesaba bağlıysa?
- provider timeout verirse?
- iki agent aynı şeyi değiştirirse?
- task başarılı ama hedef gerçekleşmezse?
- model bilmediği bir alanı bildiğini sanarsa?
- yeni bir düzenleyici gereklilik çıkarsa?
- iş 3 saat değil 2 yıl sürerse?
- 1 kullanıcı değil 50.000 kullanıcı varsa?
- model context'e doğru kaynak hiç gelmezse?
- bütün testler aynı yanlış specification'a dayanıyorsa?

EXP-004'teki G01–G07 bu tür açıklıkları taşıyor; özellikle G01'in eksik ihtiyaç keşfi ve G02'nin doğru bağlam/anlam problemi SOUL'un merkezine çok yakın. [turn43file0, turn44file0.]

### 8. Omission auditor, üreticinin düşünme yolundan mümkün olduğunca bağımsız olmalı

Bu önemli çünkü aynı LLM:

```text
tasarımı yaptı
↓
tasarımın neden iyi olduğunu biliyor
↓
aynı varsayımlarla review yaptı
```

durumunda ortak körlük taşır.

Bağımsızlık sadece:

> başka agent çağır

değil.

Şunlar değişebilir:

- kaynaklar,
- decomposition,
- problem framing,
- model,
- review prompt'u,
- domain analogy,
- failure fixtures.

Bizim verification protokolümüzün temel mantığı da bu: ikinci aktörün varlığı tek başına bağımsızlık yaratmaz. [turn8file0.]

### 9. İhtiyaçların bir `Need Graph` içinde tutulması gerekiyor

Bu çok faydalı olur.

Her düğüm kabaca:

```text
Need N37

required condition:
  X doğru olmak zorunda

why:
  hedefin Y kısmı aksi halde gerçekleşmiyor

status:
  candidate / supported / rejected / unresolved

depends_on:
  N12, N18

possible mechanisms:
  A / B / C

evidence:
  ...

unknowns:
  ...

failure if omitted:
  ...

return_to:
  bu araştırma bittiğinde hangi karara dönecek?
```

Bu task graph değil.

Çünkü:

```text
Need
≠ Work
≠ Method
≠ Tool
```

Aynı Need için beş farklı yöntem olabilir.

Bir yöntem değişince hedef koşulu değişmemeli.

EXP-004'ün bu non-collapse ayrımı zaten güçlü bir başlangıç. [turn22file0.]

### 10. Her `unknown` otomatik research candidate olmalı — ama her biri araştırılmamalı

Burada maliyet kontrolü gerekiyor.

Her açık soru için:

```text
Bu bilinmez yanlış varsayılırsa tasarım değişir mi?
```

Evet:

→ research.

Hayır:

→ taşı.

Bu, sonsuz araştırmayı engeller.

Örneğin MongoDB'nin belirli bir minor özelliği architecture kararını değiştirmeyecekse araştırmaya gerek olmayabilir.

Ama:

> “Bu storage backend tenant isolation sağlayabiliyor mu?”

mimariyi değiştiriyorsa yüksek bilgi değerine sahip.

### 11. Research → Requirement dönüşümü otomatik olmamalı

Bir repo bize güzel bir mekanizma gösterdi diye:

```text
Beads'te lease var
→ SOUL'da lease olmalı
```

diyemeyiz.

Doğru sıra:

```text
Need
↓
candidate mechanism
↓
problem-fit
↓
alternative mechanisms
↓
constraints
↓
qualification
↓
admission
```

EXP-004'ün research→mechanism haritasının güçlü taraflarından biri de bunu ayırmasıydı: araştırılan ürünler kurulmadı; mekanizma özellikleri uyarlanarak kullanıldı. [turn29file0, turn30file0.]

### 12. Tasarım bitince keşif bitmemeli

SOUL'un system formation'ı yalnız başlangıçta çalışan Genesis işi olursa yeterli değil.

Runtime yeni bilgi üretir.

Örneğin:

```text
beklenmeyen failure
↓
mevcut sistem modelinde açıklanamıyor
↓
yeni condition keşfi
↓
research
↓
working configuration değişikliği
```

Yani:

```text
DISCOVER
→ FORM
→ RUN
→ OBSERVE
→ DISCOVER
→ REFORM
```

SOUL'un gerçek genişleme davranışı burada.

EXP-004'teki baz SOUL → Working Configuration → yeniden yapılandırma fikri bununla uyumlu. [turn25file0.]

### En zor soru: “Tamam, artık eksik yok” ne zaman diyeceğiz?

**Asla kesin olarak söyleyemeyiz.**

Bu önemli.

Açık dünyada:

> “İlgili bütün ihtiyaçları keşfettim.”

ispatlanabilir bir iddia değil.

Ama daha güçlü bir bounded criterion kurabiliriz.

Örneğin sistem ancak şu durumda bir sonraki aşamaya geçebilir:

1. Birden fazla materially different framing uygulanmış.
2. Gizli varsayımlar çıkarılmış.
3. İlgili research library taranmış.
4. Library dışından alternatif bilgi alanları aranmış.
5. En az bir rival working-system framing'i değerlendirilmiş.
6. Ayrı omission/failure saldırısı yapılmış.
7. Yeni turlarda çıkan **material yeni need** sayısı belirgin biçimde azalmış.
8. Açık kalan unknown'ların hangileri olduğu biliniyor.
9. Açık unknown'ların mevcut aşamayı bloke edip etmediği açıklanabiliyor.
10. Sistem yanlışsa geri dönmenin yolu var.

Bu:

> **“complete”**

değil.

Şu:

> **“current decision için bounded-sufficient.”**

Foundation'ın yeterlilik yaklaşımında da benzer epistemik sınır korunuyor: yapısal kapsama, evrensel mühendislik yeterliği olarak sunulmuyor. [turn16file0.]

### Bütününü tek algoritmaya indirirsem

```text
INPUT
  user objective
  actual environment
  current knowledge
  constraints / authority

1. FORM TARGET
   Kullanıcının istediği gerçek durum ne?

2. DERIVE CONDITIONS
   Bu sonucun gerçekleşmesi için ne doğru olmak zorunda?

3. EXPOSE ASSUMPTIONS
   Hangi capability, bilgi, aktör, ortam, yetki
   hazır varsayılıyor?

4. MULTI-FRAME DISCOVERY
   Problemi farklı ve mümkün olduğunca bağımsız
   lenslerden yeniden kur.

5. BUILD NEED GRAPH
   Need / condition / unknown / dependency ayrımlarını koru.

6. ACTIVATE KNOWLEDGE
   Genel model bilgisi + Foundation + studies +
   explorations + mevcut dünya bilgisi.

7. DISCOVER KNOWLEDGE GAPS
   Hangi alanları bilmiyoruz?
   Hangi farklı disiplinler bu problemi çözüyor?

8. RESEARCH HIGH-VALUE GAPS
   Kararı değiştirecek unknown'ları araştır.

9. GENERATE RIVAL SYSTEMS
   Farklı solution traditions üzerinden adaylar oluştur.

10. FALSIFY / OMISSION ATTACK
    Her adayın görünmeyen world assumptions'ını kırmaya çalış.

11. SELECT / FORM WORKING SYSTEM
    Need'leri karşılayan minimum yeterli configuration'ı oluştur.

12. QUALIFY
    Bu configuration'ın gerekli capability'leri gerçekten var mı?

13. RUN
    Gerçek işte kullan.

14. OBSERVE REALITY
    Tool success değil gerçek effect/outcome'u değerlendir.

15. REDISCOVER
    Yeni evidence → yeni Need / invalidated assumption / research.

16. REFORM
    Sistemi kontrollü biçimde genişlet/daralt/değiştir.
```

Bu döngü SOUL'un belki de en merkezi davranışıdır.

### Bunun pratik sonucu

Bence Development OS'ta yapılacak ilk büyük iş:

**SOUL mimarisi çizmek değil, bu discovery mechanism'i prototiplemek ve test etmek** olabilir.

Örneğin 10–20 birbirinden çok farklı, önceden gizlenmiş gereksinimleri bulunan problem veririz.

Sistem:

1. ne gerektiğini kendisi keşfeder,
2. araştırma frontier'ını kendisi üretir,
3. kaynakları kendisi bulur,
4. çalışma sistemi önerir.

Sonra bağımsız bir holdout setiyle:

> Hangi kritik ihtiyacı hiç görmedi?

diye test ederiz.

Çünkü bu capability çalışmıyorsa, **geri kalan SOUL mimarisi ne kadar sofistike olursa olsun kullanıcı yine eksik-bulucu olarak kalır.**

Bence şu anda araştırma projemizin en değerli potansiyel dönüm noktası tam olarak burada.
