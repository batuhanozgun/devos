# keel — okuma defteri

Repo: `batuhanozgun/keel`  
Rol: somutlaşmış ürün/mekanizma yüzeyi  
Statü: **source/mechanism ledger; current next-action authority değildir**

## Neden önemli

KEEL, durumsuz ajanlarla yazılım projesi kurup yürütmek için geliştirilmiş bir işletim disiplini. SOUL'un doğrudan öncülü olduğu varsayılmıyor; fakat oturum sürekliliği, rol/motivasyon ayrımı, insan karar kapıları, mekanik iz ve doğrulama gibi problemler üzerinde somut tasarım deneyimi taşıyor.

SOUL genel amaçlı bir agentic architecture hedeflediği için KEEL'deki her mekanizma iki soruyla okundu:

1. Hangi gerçek problem/failure mode'u çözmeye çalışıyor?
2. Çözüm yazılım-projesi/Claude Code bağlamına mı özgü, yoksa daha genel bir ilke mi taşıyor?

## Okuma kaydı — öz-anlatı / kurucu model

| Kaynak | SHA | Tür | Maddi bulgu |
|---|---|---|---|
| `README.md` | `a221d174` | full | KEEL, dağınıklık/unutkanlık sorununa kanon, roller, kutular, mühürler ve kokpit ile cevap veren kurulum sistemi; "bilerek az anla, çalışan sistem bırak" merkezi |
| `GENESIS.md` | `a04b8060` | full | product plan yapmayan tek-seferlik kurucu; sabit plan, mühürler, çıkış ölçütleri, state dosyası ve mekanik sıra |
| `00_genesis/DEFO_MODELI.md` | `e9bddf5e` | full | on davranış defosu ve "öğüt yerine gözlemlenebilir iz/mekanik kapı" ilkesi |

## Seçici mekanik karşı-okuma

### Kurulum state'i ve oturumlar arası devam

| Kaynak | SHA | Tür | Mekanik bulgu |
|---|---|---|---|
| `00_genesis/GENESIS_DURUM.md` | `270e9153` | full | state tek makine-okur blokta: `Adım`, `Durum`, `Tamamlanan`; eski çift yazım ölçülmüş çelişki ürettiği için kaldırılmış |
| `.claude/settings.json` | `0d4db024` | full | `kurulum-surucu.sh` gerçek `Stop`, `acilis.sh` gerçek `SessionStart`, `kapanis.sh` gerçek `SessionEnd`, `file-guard.sh` gerçek `PreToolUse` kancalarına bağlı |
| `tools/guard/kurulum-surucu.sh` | `a386e36a` | selective code | eksik/tekrarlı alan, bilinmeyen durum, erken `.kurulum-tamam`, bayat `başlamadı`, tanınmayan adım ve kesintili tamamlanan-sıra fail-closed `exit 2`; sınırı açık: işin gerçekten yapıldığını değil state/sıra tutarlılığını ölçer |

Hüküm: durumsuz devam mekanizmasının bugünkü ağaçta gerçek kod karşılığı var; görev doğruluğunu kanıtlamaz.

### Guard ve rol sınırı

| Kaynak | SHA | Tür | Mekanik bulgu |
|---|---|---|---|
| `tools/guard/README.md` | `dbcd0b03` | contract | `[SERT]`, `[SORULUR]`, rol kafesi, Bash/MCP dikişleri ve fail-yönleri tarifli; belge tek başına kanıt sayılmadı |
| `tools/guard/file-guard.sh` | `67abfd4f` | selective code | yazma/MCP/Bash kararları gerçek PreToolUse kodunda; kritik veri dosyaları okunamazsa çeşitli hatlarda fail-closed; `[SERT]`ten sonra rol kafesi uygulanıyor |
| `tools/guard/file-guard.sh` rol-kafesi bölümü | `67abfd4f` | code | `.aktif-rol` bozuksa yazma engelleniyor; `yazamaz` rol yalnız geçerli kendi rol evine yazabiliyor ve kendi `ROL.md` sözleşmesi özellikle engelli |
| `.claude/agents/dogrulayici.md` | `6027a304` | full | doğrulayıcı araç listesi yalnız `Read, Grep, Glob`; yazma aracı yok; çalıştırma gerektiren doğrulama başka denetçi katmanına bırakılıyor |

Hüküm: rolün kendi sözleşmesini/koruma katmanını sessizce yeniden yazmasını azaltan gerçek mekanik sınırlar var; tam güvenlik sınırı değildir.

### Bekçi ve falsification yüzeyi

| Kaynak | SHA | Tür | Mekanik bulgu |
|---|---|---|---|
| `tools/bekci/README.md` | `91aa2d6b` | contract | sabit çekirdek + proje ayarı, makine satırı ve ayrı exit-code sözleşmesi |
| `tools/bekci/test/` | — | index | tavan, şema, koruma, golden bağ, tek-ev ve bozma testleri ayrı dosyalar |
| `tools/bekci/test/bozma.test.mjs` | `3f5cb93e` | full test definition | temiz kurulumdan sonra 9 kasıtlı mutasyonun `durduran`/`kilit` ve exit code değiştirmesi bekleniyor |

**Verification sınırı:** mutation testleri bu oturumda fresh olarak koşturulamadı. GitHub Actions run görülmedi; release commit'indeki `1202 test yeşil` ifadesi commit-yazarı beyanıdır.

Hüküm: test tasarımı falsification-capable görünüyor; fresh pass doğrulanmış değil.

### Karne / doğrulama / kapanış

| Kaynak | SHA | Tür | Mekanik bulgu |
|---|---|---|---|
| `.claude/agents/dogrulayici.md` | `6027a304` | full | kaynaksız iddia geçersiz; doğrulanamayana YEŞİL denmez; dosya-gerçeği katmanı salt-okur |
| `tools/sevk/sevk.sh` | `68f2a7d7` | selective code | kapalı görev için taze `YEŞİL` karne aranıyor; yok/bayat ise `dogrulayici` çağrılıyor; kırmızı/doğrulanamadı ayrı akış |
| `tools/sevk/sevk.sh` kapanış dalı | `68f2a7d7` | code | kapanış karnesi son iş zarfından sonra taze olmalı; KIRMIZI düzeltme adresine, DOĞRULANAMADI sahibin kararına gider |
| `.claude/settings.json` + `tools/sevk/zarf-bicim-kapisi.sh` | `0d4db024` / current | wiring+code | SubagentStop zarf kapısı hook'a bağlı; schema/çatallar/kanıt alanları makinece değerlendiriliyor |

Hüküm: kendi beyanıyla yeşil kapanışı azaltan gerçek sevk/karne karşılığı var; ortak model/çerçeve hatası nedeniyle epistemik bağımsızlık sınırlı.

### İnsan-okur ↔ makine-durum ayrımı

- `GENESIS_DURUM`: state tek makine bloğunda; insan düzyazısında tekrar yok.
- bekçi: karar metin kelimesi taramasından değil makine satırı + exit code'dan türetiliyor.
- `sevk.sh`: kapalı görev tablosunu tek başına yeterli saymayıp zarf/karne tazeliğine bakıyor.

Hüküm: geçmiş dış-göz seansındaki bazı insan-belgesi/makine-durum kusurları azaltılmış; sistem bütünü hâlâ Markdown + dosya sözleşmelerine dayanıyor.

### Ders → ihtiyaç anı / bağlam köprüsü

| Kaynak | SHA | Tür | Mekanik bulgu |
|---|---|---|---|
| `00_genesis/ROL_SKILL_KALIBI.md` | `92d04fef` | full | rol töreni ROL.md → DURUM.md → PANO sırasını zorunlu okuma olarak işaretliyor; bilgi kopyalanmıyor |
| `00_genesis/SOZLESME_KALIBI.md` | `f37a3d0a` | selective/full visible | role özel `Açılış ek-okumaları` alanı var; ilk kutudaki kayıt düzeni sonradan bu alanı güncelliyor |
| `00_genesis/ILK_KUTU_KALIBI.md` | `c47f3c9b` | full | her rol süreçte neye ihtiyaç duyduğunu/hafızasız oturum için ne kaydedileceğini cevaplıyor; `KAYIT_DUZENI.md` ve rol ek-okumaları oluşuyor |
| `tools/guard/acilis.sh` | `c932a041` | selective code | belirli olayları SessionStart'ta görünür kılıyor; genel semantik lesson retrieval yapmıyor |

Hüküm: ders→ihtiyaç köprüsü kısmen mekanikleşmiş, tamamen çözülmüş değil.

## Bounded mekanik hüküm

KEEL öz-anlatısındaki temel mekanizmaların önemli kısmının bugünkü ağaçta hook wiring, fail-closed state parser, rol kafesi, salt-okur doğrulayıcı, taze-karne sevki ve kasıtlı bozma testleri gibi gerçek karşılıkları var.

Sınırlar:

1. önemli garantiler Claude Code hook/tool metadata'sına özgü;
2. farklı koltuklar aynı temel model/çerçeve hatasını paylaşabilir;
3. genel lesson→need-time retrieval hâlâ tamamlanmış görünmüyor;
4. fresh execution bu context turunda yeniden doğrulanmadı.

Bu ledger source/mechanism evidence'tır. Eski `sonraki yüksek-bilgi adımı` working tree'den çıkarılmıştır; güncel çalışma talimatı değildir.
