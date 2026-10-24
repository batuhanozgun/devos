# U14-A — Kaynak ve okuma kapsamı

**2026-09-13 / SOURCE ONLY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Araştırma](INSTALL-AND-ACTIVATION.md). Native 1-based aralıklar; FULL READ metin kapsamıdır, full-byte/dependency/execution değildir.

| ID | Immutable kaynak / Git blob | Gerçek okuma |
|---|---|---|
| S01 | [README.md](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/README.md) / `c05112266746ff99a3326a62c38c33fbc08ecd23` | SELECTED 1–160. Install/getting-started/platform ve komut girişleri. Marketing/security yorumları bağımsız kanıt yapılmadı. |
| S02 | [pyproject.toml](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/pyproject.toml) / `12c672ff3cdacd9d045d60d1cc4248e0aeba6f72` | SELECTED: 1–240 isteği optional-dependencies içinde kesildi; görünür project/core bölümü ve optional başlangıcı kullanıldı, FULL denmedi. 370–550 ayrı tam aralık: build/entrypoint/uv policy ve exemption listesi. Tüm extras/lock graph okunmadı. |
| S03 | [scripts/install.sh](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/scripts/install.sh) / `eec308a5de78053bd3af8968df1ff2eb5a587fb4` | SELECTED 1–240,240–440,430–505;1430–1665,1650–1885,1880–2140,2140–2400;2800–3040;3260–3540;3650–3795,3790–4070(EOF). Clone/ref, venv/deps, layout/path/template, setup/gateway başlangıcı, staged main ve seçili desktop helpers. 3041 sonrası bütün gateway tail, tüm prerequisites/timeout/npm/browser/desktop ve marker helper gövdeleri full değil. |
| S04 | [hermes](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes) / `3172ca91ca2bbb3d16f6fbc4000f387bf4f4610c` | FULL READ. Checked-in launcher→main. |
| S05 | [hermes_cli/main.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/main.py) / `8c733250677fc6992a81c78d27af81f4c1074b40` | SELECTED 1–240,350–575,570–740,2400–2580,3300–3500(EOF). Bootstrap/early recovery caller, profile resolver/override, dotenv/config caller, actual main/default chat; dashboard runtime selected karşı yüzey. Full fast-path/chat/gateway/config/recovery closure değil. |
| S06 | [setup.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/setup.py) / `328d53678adf5a2093fc730c2ea6344da7cad4bf` | FULL READ 1–240(EOF). Build guards/root-module discovery, not executed; actual setuptools/Nix build doğrulanmadı. |

Pinned root tree `f54f5e9d2682bf11f164de7b34ee10ec121b6434` native GET ile açıldı; büyük JSON görünümü kesildi, whole-tree audit sayılmadı. `scripts/install.sh` ve `hermes_cli/update_cmd.py` default-branch araması `b6b53c69a6ed49cb099cf1bfe76b5e6edd718e5a` pointer'ları verdi; A sonuçları yukarıdaki exact pin'e bağlandı. Updater B'den önce yapılmış sayılmaz.

## W01 — mutable dış yönlendirme

2026-09-13 web search, resmî `https://hermes-agent.nousresearch.com/docs/getting-started/updating`, platform-support, profiles ve desktop/skills sayfalarının seçili search görünümlerini sağladı. Bunlar navigation ve daha sonraki karşı okuma adaylarıdır; pinned source veya tam güncel-ürün doğrulaması değildir. Pricing/CVE/security/history iddiaları yeni araştırma sonucu yapılmadı. Public pinned raw install.sh web açma denemesi cache miss verdi.

## Erişim, preflight ve doğrulama sınırı

Yerel urllib raw-source denemesi DNS `Temporary failure in name resolution` ile başarısız oldu; downloader denemesi kaynak-URL kabul koşulunda reddedildi. Tam kaynak byte kopyası indirilmiş/hash'lenmiş sayılmaz. Connector metin okumaları sürdü; credential, izin veya ağ kısıtı değiştirilmedi.

İlk main93d6b144 U13'ü taşıyordu. U13 current/source/diagnostic/SPEC/MANIFEST/NOT RUN ve scope review tam geri kazanıldı. Publication uzlaştırması40a7f952 ve Q58 opening1d65fd3e actual ref/content/scope ile doğrulandı. AGENT fresh; değişmeyen R01–R09 ve önceki mandatory U04/U10–U12/synthesis okumaları aynı conversation kapsamında yeniden kullanıldı. Control dosyaları araştırma corpus'u değildir.

**Yeni behavioral execution/import/model/tool/installer/package-resolution/DB/service/network-runtime/OS test veya upstream suite yok.** RESULT/PASS sayısı üretilmedi. Source yorumundaki vaka/süre/başarı ve dependency-security nitelemeleri bağımsız saha kanıtı değildir. Kendi repo yazma/geri okuma kontrollerimiz HERMES kurulum davranışını doğrulamaz.
