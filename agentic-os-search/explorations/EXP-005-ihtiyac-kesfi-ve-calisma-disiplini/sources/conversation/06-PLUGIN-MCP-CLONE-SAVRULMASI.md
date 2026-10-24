# Görünür diyalog 06 — Plugin, MCP ve clone arasında yön değiştirme

**Tarihsel kayıt, kurulum rehberi değildir.** Bu bölümdeki ürün/yüzey ve güvenlik iddiaları yeni doğrulanmış bilgi olarak kullanılmamalıdır. Kodlar arşivlenen konuşmanın parçasıdır; çalıştırılmayacaktır.

<a id="U025"></a>
## U025 — Kullanıcı

nası vereceğiz? MCP mi? Plugin mi?

<a id="A025"></a>
## A025 — Assistant

Görünür rota: LOAD R01,R03,R05,R08; SKIP R02,R04,R06,R07,R09.

**MCP veya Plugin ile başlamazdım.** En temiz çözüm: **Codex Cloud environment setup sırasında private Research reposunu read-only olarak clone etmek.**

Codex Cloud ortamları setup script, environment variable ve **secret** destekliyor. Setup script internete erişebiliyor; secret’lar yalnız setup aşamasında mevcut olup agent çalışmaya başlamadan kaldırılıyor. Bu bizim durumumuz için tam uygun. [Konuşmadaki bağlantı: https://developers.openai.com/fr-FR/docs/environments/cloud-environment?utm_source=chatgpt.com]

### Yapılacaklar

1. GitHub’da **fine-grained PAT** oluştur:
   - yalnız `batuhanozgun/agentic-os-search`
   - **Contents: Read-only**
   - başka yazma yetkisi verme.
2. Codex Cloud → ilgili **Environment** → **Secrets** bölümüne:
   - `RESEARCH_GITHUB_TOKEN`
   olarak ekle.
3. Aynı environment’ın **Setup script**’ine Research reposunu clone eden adım koy:

```bash
cat >/tmp/research-git-askpass.sh <<'SH'
#!/bin/sh
case "$1" in
  *Username*) echo "x-access-token" ;;
  *Password*) echo "$RESEARCH_GITHUB_TOKEN" ;;
esac
SH

chmod 700 /tmp/research-git-askpass.sh

GIT_TERMINAL_PROMPT=0 \
GIT_ASKPASS=/tmp/research-git-askpass.sh \
git clone https://github.com/batuhanozgun/agentic-os-search.git \
  /workspace/agentic-os-search

rm -f /tmp/research-git-askpass.sh

git -C /workspace/agentic-os-search \
  remote set-url origin https://github.com/batuhanozgun/agentic-os-search.git
```

Böylece agent çalışmaya başladığında:

```text
/workspace/soul-development-os_02
/workspace/agentic-os-search
```

ikisini de okuyabilir; fakat GitHub token artık agent’ın ortamında bulunmaz. Codex’in setup script’lerinin internet erişimine sahip olması ve secret’ların agent aşamasından önce kaldırılması resmi davranış. [Aynı Cloud environments bağlantısı.]

### GitHub bağlantısını da kontrol et

Codex Cloud kurulumunda GitHub bağlarken Codex’in erişebileceği repository’leri seçebiliyorsun; **iki repoya da Codex GitHub erişimi vermek** mantıklı. [https://developers.openai.com/pt-BR/docs/cloud?utm_source=chatgpt.com]

Ama bizim yaşadığımız durumda task shell’inde ikinci private repo için Git credential bulunmadı. Bu yüzden sadece GitHub bağlantısını açıp “artık `git clone` çalışır” diye varsaymam. **Setup-secret + read-only clone** daha deterministik.

### MCP / Plugin?

- **Plugin:** Hayır. ChatGPT’deki GitHub bağlantısını Codex Cloud shell credential’ı gibi düşünmemeliyiz.
- **MCP:** Teknik olarak yapılabilir ama bu problem için gereksiz bir katman. Üstelik yine authentication kurman gerekir.
- **Read-only clone:** Şu anki ihtiyacımız için en küçük ve denetlenebilir çözüm.

Bunu kurduktan sonra **yeni göreve başlamadan önce yalnız bir preflight yaptırırız**:

> `/workspace/agentic-os-search` mevcut mu, `AGENT.md`, Foundation, studies ve explorations gerçekten okunabiliyor mu?

PASS olmadan substantive çalışma başlamaz.

<a id="U026"></a>
## U026 — Kullanıcı

yahu neden mcp ya da plugin ile başlamazdın neden? bunu bana açıklar mısın?

<a id="A026"></a>
## A026 — Assistant

Görünür rota: LOAD R01,R03,R05; SKIP R02,R04,R06,R07,R08,R09.

Çünkü ben önce **“Codex’in Research reposunu normal bir filesystem gibi görmesi en deterministik yol olur”** diye düşündüm. O yüzden clone + read-only credential önerdim.

Ama bunu fazla hızlı genelledim. Bizim asıl ihtiyacımız **Research reposunu yazmak değil, güvenilir biçimde okumak**. Bu açıdan **GitHub app/plugin aslında ilk denenmesi gereken daha temiz yol olabilir.**

### Ayrım şu

**Plugin / GitHub app**
- Codex, yetkilendirilmiş private GitHub reposundaki içeriği arayıp okuyabilir. Codex task görünümünde plugin’ler `Sources` üzerinden kullanılabiliyor. [https://help.openai.com/en/articles/20001256/?utm_source=chatgpt.com]
- Shell’e GitHub token vermek zorunda kalmazsın.
- Read-only erişim için daha az risklidir.
- Bizim “Research kütüphanesini oku” ihtiyacımıza doğrudan uyuyor.

**MCP**
- Aslında daha alt seviye bir entegrasyon mekanizmasıdır. Bir plugin zaten bir MCP server içerebilir. Yani “plugin mi MCP mi?” tam olarak aynı seviyede iki alternatif değil. [https://developers.openai.com/plugins/concepts/plugins?site_locale=en&utm_source=chatgpt.com]
- Özel bir MCP kurarsak çok kontrollü GitHub/research araçları verebiliriz.
- Ama server, auth, deployment ve Codex surface uyumluluğu gibi ek altyapı çıkar. Bu yüzden hazır GitHub bağlantısı yeterliyse gereksiz olabilir.

**Clone**
- Research reposu gerçek dosyalar olarak `/workspace/...` altında olur.
- `git diff`, `grep`, script, exact commit snapshot, offline karşılaştırma gibi filesystem-native işler çok kolaylaşır.
- Ama credential yönetimi getirir ve bizim salt-okuma ihtiyacımız için daha ağırdır.

### Dolayısıyla şu an tercihim

Önce **Codex Cloud task → Sources → GitHub/plugin** yoluyla `batuhanozgun/agentic-os-search` reposunu erişilebilir yapmayı denerdim.

Ve daha hiçbir substantive iş başlatmadan şu preflight’ı yaptırırdım:

> `agentic-os-search` içinde `AGENT.md`, `research/soul-foundations/STATE.md`, `research/studies/CATALOG.md` ve belirli bir exact ref’teki dosyayı gerçekten okuyabiliyor musun?

**Geçerse:** plugin ile devam.

**Dosyayı exact ref/path üzerinden güvenilir okuyamıyorsa veya repo çapında gereken çalışmayı yapamıyorsa:** o zaman read-only clone’a geçeriz.

**MCP’yi ise**, GitHub plugin yetersiz kalır ve Research erişimini kalıcı/özel bir araç kontratı haline getirmek istersek düşünürüz.

Yani önceki “MCP/plugin ile başlamazdım” cümlem fazla kategorikti. **Bu kullanımda plugin, clone’dan bile daha uygun ilk seçenek olabilir.**

<a id="U027"></a>
## U027 — Kullanıcı

anlamıyorum ki, repo benim, nasıl ulaşıyorsa ulaşsın, clone yapınca mevcut halini kopyalıp kendine mi yapıştıracak?

<a id="A027"></a>
## A027 — Assistant

Görünür rota: LOAD R01,R03,R05; SKIP R02,R04,R06,R07,R08,R09.

Evet, **clone tam olarak buna yakın bir şey yapıyor.**

GitHub’daki:

```text
batuhanozgun/agentic-os-search
```

reposunun bir kopyasını Codex’in çalışma ortamına indiriyor:

```text
GitHub'daki gerçek repo
        ↓ clone
Codex Cloud içindeki çalışma kopyası
```

Örneğin:

```text
/workspace/agentic-os-search/
```

altında bütün dosyaları görür:

```text
AGENT.md
research/
  soul-foundations/
  studies/
explorations/
concepts/
...
```

Sonra normal dosya okuyormuş gibi çalışabilir.

### Önemli fark

**GitHub hâlâ asıl kaynak.** Clone sadece çalışma kopyası.

Repo GitHub’da değişirse Codex’in elindeki kopya otomatik olarak değişmez. Gerektiğinde:

```text
git fetch
```

ile GitHub’daki yeni durumu görür.

İstersek belirli bir commit’i de okuyabilir:

```text
git checkout 08b91f...
```

Bu bizim araştırma sistemimiz açısından özellikle iyi çünkü **“hangi sürümü okudun?”** sorusunun cevabı net olur.

### Neden token gerekiyor?

Repo private olduğu için GitHub:

> “Bu repoyu görmeye yetkin var mı?”

diye soruyor.

Token sadece Codex’e:

> “Batu bu private repoyu okumama izin verdi.”

kanıtını sağlıyor.

Token’ı **read-only** yaparsak Research reposunu değiştiremez.

Yani sonuçta oldukça basit:

```text
SOUL DevOS repo      → Codex'in çalıştığı repo

Research repo        → yanına read-only clone

Codex
  ├─ DevOS üzerinde çalışır
  └─ Research'ü okuyup bilgi kaynağı olarak kullanır
```

Bizim ihtiyacımız açısından bu yapı gayet doğal. Ben plugin/MCP seçeneklerini fazla karmaşıklaştırdım. **Repo senin, Codex'in ikinci private repo olarak read-only clone etmesi yeterli olabilir.**

<a id="U028"></a>
## U028 — Kullanıcı

iyi ama biz araştırma reposuna yeni araştırma ekleyince ne olacak? görebilecek mi otomatik?

<a id="A028"></a>
## A028 — Assistant

Görünür rota: LOAD R01,R03,R05,R09; SKIP R02,R04,R06,R07,R08.

**Otomatik olarak değil.** Clone, alındığı andaki kopyadır.

Ama bunu kolayca doğru hale getiririz:

```text
Her yeni Codex işi başlarken
↓
git fetch / pull
↓
Research reposunun güncel main'i alınır
↓
Codex güncel araştırmaları görür
```

Yani bugün yeni bir araştırma eklersek, sonraki Codex oturumu başlangıçta Research reposunu günceller ve onu görür.

Uzun süren bir çalışma sırasında Research’e yeni şey eklenirse de Codex isterse tekrar:

```bash
git fetch origin
```

yapıp güncel hali alabilir.

Bence doğru yapı şu:

> **Research reposu GitHub’da canlı kaynak olmaya devam eder; Codex her işe girişte read-only çalışma kopyasını günceller.**

Böylece statik bir eski kopyaya mahkûm olmaz.

<a id="U029"></a>
## U029 — Kullanıcı

onun yerine her ihtiyaçta bağlanıp okuması daha kolay değil mi?

<a id="A029"></a>
## A029 — Assistant

Görünür rota: LOAD R01,R03,R05,R09; SKIP R02,R04,R06,R07,R08.

**Evet. Bizim kullanımımızda bu daha doğal görünüyor.**

Yani:

```text
DevOS çalışıyor
↓
bir bilgi ihtiyacı keşfediyor
↓
GitHub bağlantısıyla agentic-os-search'e gidiyor
↓
ilgili Foundation / study / exploration dosyalarını o anda okuyor
↓
gerekirse başka ilgili kaynakları keşfediyor
↓
işine geri dönüyor
```

Bunun önemli avantajı: **Research reposu her zaman GitHub’daki güncel haliyle okunur.** Clone’ın eski kalması / `fetch` unutulması problemi olmaz. GitHub bağlantısı da private repo içeriğini izin verilen repository’lerden **on demand** çekebiliyor; sürekli senkronize bir kopya oluşturmuyor. [https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt?utm_source=chatgpt.com]

Codex task görünümünde de desteklenen plugin’ler **Sources → Use plugins** üzerinden kullanılabiliyor. [https://help.openai.com/en/articles/20001256/?utm_source=chatgpt.com]

Benim şu an tercih edeceğim yapı:

```text
soul-development-os_02
→ Codex'in aktif çalışma reposu

agentic-os-search
→ GitHub üzerinden read-only canlı bilgi kaynağı
```

Yani **Research repo’yu ikinci çalışma reposu yapmak zorunda değiliz.**

Tek kritik koşul: Codex’in GitHub source/plugin üzerinden **private `agentic-os-search` reposunu gerçekten okuyabildiğini önce test etmeliyiz.** Ayrıca karar-kritik bir araştırmayı kullanırken hangi repo/path/ref’i okuduğunu kaydetmeli.

Eğer bu erişim düzgün çalışıyorsa, **clone etmeye gerek görmüyorum.** Clone ancak Codex source bağlantısı exact sürüm/path okumasında yetersiz kalırsa ikinci seçenek olur.

<a id="U030"></a>
## U030 — Kullanıcı

hangisini öneriyorsun anlamadım, bir o yana bir bu yana kayıyor tercihlerin.

<a id="A030"></a>
## A030 — Assistant

Görünür rota: LOAD R01,R03,R05,R09; SKIP R02,R04,R06,R07,R08.

Haklısın; tercihi netleştireyim:

**Benim önerim: Research reposuna GitHub bağlantısı/plugin üzerinden ihtiyaç oldukça canlı erişim.**

Yani:

```text
Codex → çalışırken ihtiyaç keşfeder
      → GitHub üzerinden agentic-os-search'e bağlanır
      → ilgili güncel dosyaları okur
      → işine devam eder
```

**Clone’ı şu an önermiyorum.** Onu yalnız GitHub bağlantısı Codex içinde yeterli erişim sağlamazsa fallback olarak kullanırız.

Neden bu tercih?

- Research sürekli değişiyor → her seferinde güncel halini görür.
- İkinci repo kopyası/senkronizasyon problemi olmaz.
- Research, çalışma reposu değil **bilgi kaynağı** olarak kalır.
- Codex yalnız ihtiyaç duyduğu dosyaları okur.
- Private repo erişimi GitHub yetkilendirmesi üzerinden yönetilir.

Dolayısıyla sıradaki iş çok basit:

> **Codex Cloud’a `agentic-os-search` GitHub erişimini verip, gerçekten okuyabildiğini küçük bir preflight ile doğrulamak.**

Bu çalışırsa tercihimiz kesin olarak **on-demand GitHub erişimi**. Clone’a geçmeyiz.

<a id="U031"></a>
## U031 — Kullanıcı

tamam onu yapsın o zaman. Nasıl yapacak onu?

<a id="A031"></a>
## A031 — Assistant

Görünür rota: LOAD R01,R03,R05; SKIP R02,R04,R06,R07,R08,R09.

Şöyle yapalım. **GitHub plugin’i zaten hesabında kurulu görünüyor.** Şimdi onu Codex görevine kaynak olarak vermen gerekiyor.

1. Codex’te ilgili task’ı aç.
2. **Sources** bölümünü aç.
3. **Use plugins** seç.
4. **GitHub**’ı seç. Codex’in desteklenen task görünümünde plugin kullanımı resmi olarak bu yoldan yapılıyor. [https://help.openai.com/en/articles/20001256/]
5. GitHub yeniden yetki isterse bağlan ve private repo erişiminde **`batuhanozgun/agentic-os-search`** reposunun izinli olduğundan emin ol. Plugin, GitHub hesabının vermediği repo erişimini kendi başına aşamaz. [Aynı bağlantı.]

Sonra **hemen çalışmaya devam ettirme**. Önce şu mesajı gönder:

> Henüz substantive çalışmaya devam etme. GitHub kaynağını kullanarak `batuhanozgun/agentic-os-search` reposuna gerçekten erişebildiğini doğrula. Güncel `main` commit SHA’sını belirle ve en az şu dosyaları doğrudan GitHub kaynağından oku: `AGENT.md`, `research/soul-foundations/STATE.md`, `research/studies/CATALOG.md`, `explorations/INDEX.md`. Her biri için okuduğun repo/path/ref bilgisini raporla. Erişim başarılıysa yalnız `RESEARCH-ACCESS-PASS` bildir; erişemediğin bir şey varsa çalışmayı başlatma ve tam engeli bildir.

**Bu PASS olmadan devam ettirmiyoruz.**

Sonrasında Codex’in çalışma şekli şu olacak:

```text
ihtiyaç keşfeder
→ GitHub plugin ile agentic-os-search'te arar
→ ilgili güncel araştırmayı okur
→ kaynağın path/ref'ini kaydeder
→ DevOS işine geri döner
```

Yani Research reposunu clone etmiyoruz; **gerektikçe GitHub’daki canlı kaynaktan okuyoruz.**

<a id="U032"></a>
## U032 — Kullanıcı

yok öyle bir yer.

<a id="A032"></a>
## A032 — Assistant

Görünür rota: LOAD R01,R03,R05; SKIP R02,R04,R06,R07,R08,R09.

Evet. **Senin kullandığın Codex Cloud ekranında `Sources → Use plugins` yok.** Ben dokümandaki “supported Codex task view” ifadesini senin kullandığın yüzeye yanlış genelledim. Özelliklerin yüzeye/hesaba göre değişebildiği resmi dokümanda da açıkça belirtiliyor. [https://help.openai.com/en/articles/20001256/?utm_source=chatgpt.com]

Bu yüzden artık net önerim şu:

> **Bu iş için plugin’i bırakıyoruz. Codex Cloud environment setup sırasında `agentic-os-search` reposunu read-only clone edeceğiz.**

Codex Cloud zaten her görev için bir container oluşturuyor, setup script çalıştırabiliyor ve secret’ları yalnız setup sırasında kullanıp agent başlamadan kaldırıyor. Bu tam bizim ihtiyacımıza uygun. [https://developers.openai.com/ja-JP/docs/environments/cloud-environment]

Pratik yapı şöyle olacak:

```text
/workspace/soul-development-os_02     ← çalıştığı repo
/workspace/agentic-os-search          ← salt-okunur Research kaynağı
```

Research’in güncelliği için de **setup/maintenance sırasında latest `main` alınacak**. Codex Cloud cached environment yeniden kullanıldığında maintenance script çalıştırabiliyor; bunu Research checkout’unu güncellemek için kullanabiliriz. [Aynı environments bağlantısı.]

Yani önceki “her ihtiyaçta plugin ile canlı bağlansın” fikrini geri çekiyorum. **Senin mevcut Codex Cloud yüzeyinde güvenilir ve uygulanabilir yol: read-only clone + her task başlangıcında/maintenance’ta güncelleme.**

İstersen bir sonraki mesajda sana sadece **nereye tıklayacağını ve yapıştıracağın setup/maintenance scriptini** vereyim.
