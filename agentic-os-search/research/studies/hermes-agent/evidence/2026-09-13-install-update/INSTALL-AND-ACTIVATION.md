# U14-A — Kaynak kurulumundan komut ve etkin çalışma bağlamına

**2026-09-13 / Q58-A / PINNED SOURCE STUDY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. [Kaynak/okuma kapsamı](INSTALL-SOURCES.md), [STATE](../../STATE.md), [PLAN](../../RESEARCH-PLAN.md). Yeni kurulum, shell script çalıştırması, package resolution, servis veya model koşusu yapılmadı. Kodda görülen mekanizma ve koşullu çıkarım, kurulu ürün gözlemi değildir.

## 1. Giriş ve anlamlı araştırma birimi

Sohbetin U12 açıklamasına karşı güncel main U13/v0.26 idi. U13/Q57 yeniden yapılmadı. Final publication makbuzu `40a7f952f04b893b2dd0ffdb3df551adfca75c4a` ile uzlaştırıldı; tek-path compare, actual main ve içerik geri okuması tamamlandı. Q58 başlangıç planı `1d65fd3e701dcd7c3c84b7efebb99666ca9377e0` main/ref, tam metin ve yalnız plan farkıyla doğrulandıktan sonra bu A kaynak dilimi başladı.

U13 kapsam kararı, yürütme/devam/delegation modelinin nasıl kurulu bir sistem olarak ortaya çıktığını henüz açıklamadığımızı gösteriyordu. Bu birim **kaynak → kurulum hedefi → bağımlılık ortamı → komut → kullanıcı durumu/profil → çalışma girişinin kabulü** zinciridir. Dosya sayısı veya tüm platformları tüketmek ölçüt değildir. Normal Linux/macOS shell yolu, aynı kurucunun mevcut checkout ve aşamalı/noninteractive yollarıyla karşı okunur; ayrı `hermes update` yaşamı sonraki B dilimidir.

## 2. Dağıtım nesnesi sıradan bir wheel değildir

README shell/PowerShell installer ve sonrasında `hermes`, `hermes setup`, `hermes gateway`, `hermes update` yollarını gösterir. Bunlar hedefin doküman talimatlarıdır; araştırmacı bu komutları çalıştırmadı. [S01]

`pyproject.toml` paket adı/sürümü, Python `>=3.11,<3.14`, core/optional dependencies, build backend ve üç console entrypoint tanımlar. Core girişindeki yorum bütün doğrudan bağımlılıkların exact-pin olduğunu söylese de gerçek listede sürüm aralıkları da vardır. Bu yüzden yorumun tamamını geçerli paket sözleşmesi saymıyoruz. `[tool.uv]` override ve exclude-newer/exemption politikaları ayrı resolver girdileridir; bunların varlığı mevcut makinede hangi paketlerin bulunduğunu söylemez. [S02]

`setup.py` normal wheel/sdist build yollarına ret ekler; Nix build işareti olan yolu ayrı tutar. Gerekçe olarak source layout'tan çözülen bundled assets'i belirtir. Gerçek kodda `sdist` ve import edilebildiğinde `bdist_wheel` sınıfları kontrol edilir; editable install farklı build yoludur. **Pyproject dosyasının bulunması, her dağıtım biçiminin aynı çalışma varlıklarını taşıdığı anlamına gelmez.** Nix builder'ın tam uygulaması veya yayımlanmış binary içerikleri bu dilimde doğrulanmadı. [S06]

## 3. Kod alanı, kullanıcı verisi ve komut alanı ayrı seçilir

Shell kurucu `HERMES_HOME` ile `INSTALL_DIR`'ı ayrı tutar. Explicit `--dir` / `HERMES_INSTALL_DIR` korunur. Varsayılan non-root kaynak ağacı home altındadır; yeni Linux-root kurulumunda FHS kod/komut alanları seçilir, eski home-altı Git checkout varsa o düzen korunur. Termux ayrı prefix ve Python yolu kullanır. [S03: resolve_install_layout/get_command_link_dir]

Dolayısıyla aynı home verisi birden fazla kod/çalıştırıcıyla ilişkilendirilebilir. Kurulum yöntemi `.install_method` işareti, ana akış sonunda kod dizinine yazılır; kullanıcı home'una yazılmamasının kaynak gerekçesi host ile container'ın paylaşılan veri alanında birbirinin yöntemini ezmemesidir. İşaret hangi kod ağacının nasıl yönetileceğine aittir; modelin hazır olması veya çalışan process'in kimliğinin makbuzu değildir. [S03: main/complete stage]

Burada custom-home bağının bütün launch biçimlerinde kusursuz taşındığı iddia edilmiyor. İncelenen shell launcher Python ve kaynak entrypoint adresini açık taşır; home/profil ayrıca environment/startup politikasından gelir. Alternatif home parametresi, kalıcı shell ayarı ve child environment için bütün yollar ayrıca ölçülmelidir.

## 4. İstenen ref, hazır checkout ve etkin ref aynı soru değildir

Kurucu varsayılan branch'i klonlar; yeni checkout'un materyalizasyonu başarısızsa sonraki adıma geçmemeye çalışan kontroller vardır. Commit'siz yarım eski checkout ayrı `.broken-*` konumuna taşınabilir. Mevcut Git checkout'ta yerel dosya değişiklikleri için stash, hedef branch fetch/checkout ve fast-forward; bu mümkün değilse managed tree'yi uzak branch'e reset etme yolu vardır. Git olmayan mevcut dizin reddedilir. [S03: clone_repo]

Yerel değişiklik korumasını mutlaklaştırmıyoruz: npm lockfile değişiklikleri ayrı heuristikle churn sayılıp stash öncesinde atılabilir; yerel commit geçmişi ile dirty dosya değişiklikleri aynı yedek nesnesi değildir. Stash'in varlığı, değişikliklerin yeni sürüme başarılı uygulandığı anlamına gelmez. Restore conflict'inde stash tutulurken working tree temizlenebilir; kullanıcı değişikliği mevcut dosyalarda etkin olmayabilir. [S03: discard_update_lockfile_churn/clone_repo]

`--commit` hex biçim kontrolünden ve gerekirse fetch'ten geçer. Hedef commit mevcut HEAD'in strict ancestor'ıysa, force seçeneği yokken pin isteği uyarıyla göz ardı edilebilir; diğer durumda detached checkout yapılır. Bu rollback'i önlemeyi amaçlayan kaynak politikasıdır. **Pin argümanının metinde bulunması exact hedefin mutlaka etkin olduğu ispatı değildir; effective HEAD gerekir.** Gerçek eski/fresh kurulumda hangi SHA'nın seçildiği bu tur ölçülmedi. [S03: clone_repo tail]

## 5. Tek kurulum akışı birden fazla bağımlılık sonucuna ulaşabilir

Normal venv kurulumu belirli Python ile ortam oluşturur; var olan venv yeniden yaratılabilir. İlgili interpreter sonraki uv çağrılarına yeniden bağlanır. Staged bootstrap'ta her stage ayrı process olduğundan önceki export ve cwd'nin kendiliğinden taşınmadığı açıkça ele alınır. [S03: setup_venv/install_deps/require_install_dir]

İlk dependency yolu, `uv.lock` varsa proje ayarlarını belirli alt süreçte tekrar görünür kılıp `uv sync --extra all --locked` çağırır. Ambient user/system uv config'i boş XDG konumlarına yönlendirilir; bütün HOME sıfırlanmaz. Böylece lockfile ile resolver policy uyumu korunmaya çalışılır. `all` adlı curated extra ile bütün extras aynı seçenek değildir. Bu tur lockfile'ın bütün çözümü veya hash kontrollerinin actual çalışması test edilmedi. [S02,S03]

Locked sync başarısız veya lock yoksa `uv pip install -e` tabanlı yeniden çözümleme dalları vardır: curated all, bilinen bozuk extras çıkarılmış varyant ve son çare core. Başarı halinde akış devam eder; fallback seçildiyse eksik optional özellik uyarısı vardır. Termux ayrı pip/constraints ve broad→baseline→base sırası kullanır. Bu yollar aynı dependency graph veya aynı lockfile doğrulaması değildir. **“Kurulum başarılı” bazı koşullarda çalışabilir çekirdeği anlatır; bütün yeteneklerin aynı sürümlerle hazır olduğu makbuzu değildir.** [S03: install_deps]

Python paketi dışında Node/TUI/browser bileşenleri de bulunur. Bazı yardımcı araç kurulumları hata halinde uyarıyla sürer ve first-use kurulumuna bırakılabilir. Ana akışta Node dependencies başarısızlığı ise erken dönüş oluşturabilir. Aynı script'te bulunmaları bütün adımların aynı failure policy'yi taşıdığı anlamına gelmez. [S03: install_node_deps tail/browser/computer-use/main]

## 6. Kurulu komutun hangi Python ve kaynakla başladığı

Installer venv yolunda üretilen shell shim, inherited PYTHONPATH/PYTHONHOME'u temizler ve seçilmiş interpreter ile checkout içindeki `hermes` dosyasını exec eder. Root launcher doğrudan `hermes_cli.main.main` çağırır. `hermes-agent` ve ACP için ayrı shim girişleri vardır. Böylece package entrypoint adı, PATH'te bulunan dosya ve ithal edilen modül kökü birbirine bağlanır; yalnız package install exit-code'una dayanılmaz. [S02,S03,S04]

Bunun kapsamı da sınırlıdır: `setup_path` prerequisite bulamazsa uyarıp sıfır dönüş yapabilen yol taşır. PATH düzenlemesi shell türüne ve root/Termux düzenine bağlıdır; installer process'inin export'u kullanıcının halen açık başka shell'inin environment'ını değiştirmez. README'deki shell reload önerisi bu sınırla tutarlıdır. Fresh shell/root belirli bir probe bulunur, fakat bütün kullanıcı komut çözümlerinin ölçülmüş olduğu iddia edilmez. [S01,S03]

CLI startup kaynak kökünü path'e bağlar, stdlib erken recovery çağrısı ve ardından profil ön çözümlemesi yapar. Açık profil flag'i, profile-dir HERMES_HOME ve sticky active_profile farklı öncelik yollarıdır. Supervised gateway için sticky default seçimi kısıtlanır; sabit servis kimliğinin kullanıcı arayüzündeki profil değişiminden kaymaması amaçlanır. Bulunamayan açık profil ret üretebilir, beklenmeyen resolver exception'ı başka fallback taşır. [S05]

Profil çözümlemesinden sonra dotenv yükleyici ve config köprüsü çağrılır. `update` için dış secret-manager fetch'i atlama argümanı vardır; bütün config/dotenv'i atlama değildir. `main()` recovery/bytecode ve seçili hızlı yolların ardından parser/command handler'a; komutsuz yolda chat'e gider. Managed-container config varsa process başka ortamda exec edilebilir. Bu **kaynak girişine kadar bağdır**; `.env`nin tam precedence algoritması, bütün fast paths ve gerçek ilk model isteği bu A'da çalıştırılmadı. [S05]

## 7. Kullanıcı durumunun hazırlanması, etkin servis değildir

Template adımı home veri dizinlerini oluşturur, `.env` ve config dosyalarını yoksa kopyalar, var olanları genel olarak korur; `.env` iznini daraltır. Ancak “keep existing” ifadesi bütün yardımcılar için immutability garantisi değildir: browser environment düzeltme çağrıları ve seçili stale override temizleme kodu da vardır. Persona dosyası yoksa başlangıç metni yazılır. Kaynak içindeki bu persona bizim agent-control talimatımız değildir. [S03]

Beceri tohumlama ayrı mekanizmadır: no-skills işareti sonraki sync için opt-out taşır; diğer yolda `tools/skills_sync.py` çağrılır ve uygun boş hedefte basit kopya fallback'i bulunur. Sync consumer'ın actual manifest/deletion/user-edit politikası bu A'nın açık alt sınırıdır; çağıran log'unu “her özelleştirme her koşulda korunur” hükmüne yükseltmedik. [S03]

Setup skip/no-tty ile tamamlanabilir. Gateway setup ise messaging yapılandırması ve kullanıcı/tty koşullarına bağlıdır; service install ve service start ayrı çağrılar ve farklı hata mesajlarıdır. Kurulu komut ve config varlığı, gateway'in çalışan veya model credential'ının kullanılabilir olduğu anlamına gelmez. Gerçek token veya kullanıcı home'u bu araştırmada okunmadı. [S03: run_setup_wizard/maybe_start_gateway]

## 8. Stage makbuzunu ne kadar güçlü okuyabiliriz?

Bootstrap stage manifest'i runtime/configuration ve user-input ihtiyacını ayırır. Noninteractive setup/gateway stage, `ok:true` ile birlikte `skipped:true` dönebilir. Stage gövdesi subshell'de çalıştırılıp exit status JSON'a aktarılır; complete stage başarı metni/marker/yöntem işareti üretir. Bu raporlama protokolü ile bütün kullanıcı ayarlarının tamamlanmış olması veya servis health'i aynı kanıt değildir. [S03: emit_manifest/run_stage_body/run_stage_protocol]

Olumlu sınırlar korunur: source identity kontrolü, yeni tree materyalizasyonu, lock-first kurulum, interpreter/shim bağlama, profil ayrımı ve açık skipped durumu vardır. Buna karşılık başarının tek boolean'ını ref/dependency/config/command/active-process eşdeğerliği saymak yanlıştır. Herhangi bir actual install failure, güvenlik ihlali veya yanlış-profile olayı gözlenmedi.

## 9. Çıkış ve sonraki soru

Normal source install→komut/profil/command entry zinciri ve mevcut checkout/staged/noninteractive varyantları kaynak düzeyinde açıklandı. Bütün asset/OS/lock/runtime yolları bitirilmedi. Tam okunan iki küçük dosya dışındaki okumalar seçilidir; hiçbir upstream modül import edilmedi, installer veya package manager çalıştırılmadı. [INSTALL-SOURCES](INSTALL-SOURCES.md) gerçek aralıkları taşır.

A main/ref/content olarak doğrulandıktan sonra **Q58-B**: actual `hermes update` consumer'ı, install-method eligibility, kaynak/bağımlılık değişimi, snapshot/marker ve restart/activation makbuzları. İlk kaynak navigation'ı `hermes_cli/update_cmd.py`; exact pin yeniden okunmalıdır. Mevcut installer'ın stash yolu bütün updater recovery'si sayılmaz. Eski U13 ve daha önceki runtime/fidelity/quality doğrulamaları açık kalır.
