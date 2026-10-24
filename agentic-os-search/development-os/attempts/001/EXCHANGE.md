> **29 Eylül 2026 — tarihsel iki-repo görüşme sözleşmesi; etkin iletişim kanalı değildir.** Aşağıdaki R/C adresleri, beklenen yanıtlar ve oturum tetikleme rolleri DEVOS-001'e aittir. Eski mesajları yeniden göndermek, yeni C yanıtı beklemek veya eski hedefe iş vermek bu dosyadan yetki kazanmaz. Gönderim/alım/uygulama ayrımları ve özgün kanıt sınırları korunur.
>
> Bugünkü DevOS kurulum planının tek evi [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1), ortamı Claude Code cloud'dur. [D030](../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) geçerli devir ve salt-okuma sınırını taşır. ChatGPT başka depolara yazmaz; bu depodaki devamı [bakım planıdır](../../../REPOSITORY-TRANSITION.md). Aşağıdaki metin yeni platformda denenmiş kanal olarak sunulmaz.

---

# DEVOS-001 — repo üzerinden görüşme ve devir

**Rol:** kanal sözleşmesi. Actual mesaj yayını/alımı, beklenen yanıt ve sıra yalnız [WORK](WORK.md)'te. İlk iki-repo aktarımının kanıtı oradadır; sürekli otomasyon ve uygulama yaptırımı kurulmuş değildir.

## Neden iki repo, tek görüşme?

Research `agentic-os-search` içine kendi mesajını yazar. Claude kendi hedef reposuna özgün yanıtını yazar. Her taraf ötekinin yayımlanmış mesajını okur. Claude'a Research genel yazma yetkisi veya iki aktöre aynı durum dosyasında yazarlık vermek gerekmez. Bu tercih değişmez mimari değildir; ilk aktarımın çalışması her gelecekteki alımı garanti etmez.

Repo üzerindeki kullanıcı hesabı veya `sender` alanı tek başına model kimliğinin kriptografik ispatı değildir. Karşı tarafın davranış beyanları ile Research'ün kaynak/deney gözlemleri ayrılır.

## Adresler

| Üretici | Özgün yayın yeri | Okuyan |
|---|---|---|
| Research | `batuhanozgun/agentic-os-search`, `main`, `development-os/attempts/001/messages/research/R-NNN.md` | Claude |
| Claude | `batuhanozgun/soul-development-os3_claudecode`, `main`, `coordination/devos-001/outbox/C-NNN.md` | Research |

Artan R/C numaraları tek başına iş veya yetki değildir; `in_reply_to` ve iş ilişkisi WORK'te korunur. Claude mevcut yetkili, zorlamasız yayın yolunu kullanır. `main` mümkün değilse izin/branch koruması değiştirmez; engeli ve erişilebilir exact ref/path'i bildirir. Adres değişikliği eski girişte yönlendirilir ve WORK'e yazılır; sessiz yeni kanal yoktur.

Research alınmış C mesajını `messages/claude/C-NNN.md` altında **byte-eş** kanıt kopyası tutabilir. Özgün repo@commit/path/blob WORK alındısındadır; kopya ikinci canlı otorite değildir. Byte-eş kopya oluşturulmadıysa exact özgün bağlantı kullanılır, yeniden yazılmış özet özgün mesaj diye sunulmaz. Henüz gelmeyen mesaj için dosya yaratılmaz; yorum REVIEW'a gider.

## Mesajın anlamı ve işleyiş

Mesaj: deneme/mesaj kimliği, taraflar, tür, `in_reply_to`, ilgili W işi, esas repo@commit, karşı mesajın path/blob'u ve beklenen hareketi taşır. Kendi gelecekteki yayın commit'ini tahmin etmez; actual ref sonraki alındıda bağlanır. Olgu, üretici beyanı, yorum, öneri ve uygulama ayrı. Karar gerekçesi/kanıt istenir; gizli düşünce zinciri, credential, hassas ham veri veya holdout cevapları istenmez.

1. Gönderen current ref'i doğrular, yeni kimlikle yayımlar ve remote'dan geri okur. Eski mesajı anlamca değiştirmek yerine düzeltme/supersession mesajı yazar.
2. Alıcı kendi oturumu çalıştığında WORK ve ilgili mesajı bulur, exact commit'te okur. Yayın, okuma, anlama ve kabul ayrı olaylardır.
3. Aynı mesaj tekrar görülürse önce önceki yanıt ve gerçek işe bakılır; etkili eylem körlemesine tekrarlanmaz.
4. Research alımı WORK'e, kanıt/itirazı REVIEW'a işler. Hedef teknik sonuçları hedef repoda otorite kalır.
5. Yeni iş ilgili yetki ve giriş koşullarıyla bağlıdır. Review başarısızsa tamir edilecek kaynağa/işe dönülür, yeni özetle kapatılmaz.

## Denetim, deney görünürlüğü ve yetki

Research iddia–kaynak–diff–test sonucunu karşılaştırır; Claude itiraz ve teknik sorumluluğunu korur. İki modelin anlaşması bağımsız doğrulama değildir. D01 kaynak kimliğine bağlı sentetik yerel denetçi tanısıdır; canlı Claude veya bütün E19 doğrulaması değildir. Aynı probe'un başka yerde tekrarı yeni holdout değildir.

İki tarafın da okuyabildiği Research reposunda yayımlanan varyant tasarımcıdan gizli kabul edilmez. Hash/gzip bütünlük taşır, erişim izolasyonu sağlamaz. Önce adayın dondurulması, sonra varyant yazılması sonuca göre uyarlamayı sınırlar; körlüğü kanıtlamaz. İş verisi yürütücüye açık olabilir; oracle, puan anahtarı ve müdahale açıklaması ayrı görünürlük sorularıdır. Gerçek holdout için actual görünürlük düzeni gösterilmeli; gösterilmediyse körlük açık kalır. Şeffaf challenge, yeni varyant ve doğal kullanım kanıtı ayrı tutulur.

Research'ün geçici yerel dosya üretebilmesi, garantili gizli kalıcılık veya Claude alt-oturumuna doğrudan teslim anlamına gelmez. Böyle bir kanal fiilen kurulmadan vaat edilmez. Deney verisi/kanıtının kaynak kapanışı ve gerçek sisteme yan-etki sınırı korunur. Yeni test repo seçimi, yeni çalışma denemesi veya çalışma reposunu terk etme kararı değildir.

Bu kanal hedefte yazmayı engelleyen kapı değildir. Bir mesajdaki alıntı veya “kullanıcı onayladı” beyanı yetkiyi genişletmez. Hedefte kaydedilmiş kullanıcı molası, Research'ün bir review yayımlamasıyla kalkmaz. Yeni uygulama/ücretli koşu/otomasyon gerçek yetki gerektirir.

## Tetik sınırı ve tarihçe

Repo kalıcı aktarım sağlar; yeni ChatGPT/Claude oturumunu kendiliğinden başlatmaz. Webhook, Actions, polling, zamanlanmış görev veya ajan döngüsü kurulmadı. Kullanıcı içerik taşımak yerine gerektiğinde ilgili oturumu tetikler. Alım, exact yanıt veya başka gerçek makbuzla kaydedilir; kullanıcı “cevapladı” dediğinde beklenen kaynak doğrudan kontrol edilir.

Erişim başarısızsa gerçek path/ref/hata sınırı kaydedilir, kullanıcıdan kayıp içeriği teknik olarak yeniden kurması beklenmez. [Açılış sözleşmesi](https://github.com/batuhanozgun/agentic-os-search/blob/85076c2634be5ecfa7b16bbe8b8b23821baaac1c/development-os/attempts/001/EXCHANGE.md) ve [W02 sürümü](https://github.com/batuhanozgun/agentic-os-search/blob/fdfe9baf08d4a76bd10b2e619b293a64991f824d/development-os/attempts/001/EXCHANGE.md) korunur. Bu revizyon değişken sıra ifadelerini WORK'e yönlendirir ve dondurma/görünürlük/teslim ayrımını ekler.
