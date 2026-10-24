# HERMES — İlk kaynak topolojisi

**Snapshot:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; tree `f54f5e9d2682bf11f164de7b34ee10ec121b6434`.

## Kapsamın dürüst tanımı

T00 kök Git tree yanıtı ve T01 apps tree yanıtı tam listelendi; ikisinde de `truncated:false` vardı. Bu, recursive bütün repository ağacının veya bütün içeriklerin okunduğu anlamına gelmez. Kaynak kodu toplamı, tüm test sayısı ve Gstack'e göre büyüklük karşılaştırması hesaplanmadı. Belgelerdeki sayılar envanter yerine kullanılmadı.

## Kök dizinlerin kapsam rotası

Aşağıdaki dizinler T00'da doğrudan gözlendi. Rol adları ilk yönlendirme yorumudur; alt içeriklerin tamamının sınıflandırıldığı iddiası değildir.

| İlk rota | Gözlenen kök dizinler |
|---|---|
| Ajan ve model bağlama | `agent/`, `hermes_cli/`, `providers/` |
| Araç ve uzantılar | `tools/`, `plugins/`, `skills/`, `optional-skills/`, `optional-mcps/` |
| Mesaj/görev girişleri | `gateway/`, `cron/`, `acp_adapter/` |
| Kullanıcı/uygulama yüzeyleri | `apps/`, `web/`, `tui_gateway/`, `ui-tui/` |
| Native/dağıtım | `native/`, `docker/`, `nix/`, `scripts/` |
| Test/araştırma üretimi | `tests/`, `tests-js/`, `evals/`, `datagen-config-examples/`, `mcp-research-data/` |
| Belge/asset/geliştirme çevresi | `website/`, `docs/`, `assets/`, `locales/`, `contributors/`, `.github/` |

T01, `apps/` altında `bootstrap-installer/`, `desktop/`, `shared/` dizinlerini gösterir. Masaüstü yüzeyi yalnız README'deki CLI/gateway açıklamasına indirgenmeyecek.

Kök dosya aileleri: `run_agent.py`, `cli.py`, `model_tools.py`, `toolsets.py`, `toolset_distributions.py`; `hermes_state.py` ve `hermes_state_*` ailesi; bootstrap/constants/logging/watchdog/time; batch/mini-SWE/trajectory; `mcp_serve.py`; pyproject/setup/lock/package/Docker/Nix yapılandırmaları; AGENTS/SOUL/SECURITY/README/CONTRIBUTING; compat manifestleri. Bu liste çalışma rotasıdır, tam blob manifesti değildir; exact kaynak T00'dan yeniden açılabilir.

## Yeniden giriş için kritik tree kimlikleri

| Bölge | Pinned tree SHA |
|---|---|
| `agent/` | `5028af770da8c915a43a1e5973a9d1a1dd40d844` |
| `tools/` | `9b6579f2df1f32a8df5650d65f35e30e2176449c` |
| `tests/` | `7967385c51f0faa79333c1ded2cd715cfaa5e510` |
| `plugins/` | `05cd25f0fdbaff8c9b8ba82c86bf477a3a168e6f` |
| `gateway/` | `868a244e853702cb720416f03f89926a7a51ae10` |
| `hermes_cli/` | `0f8012dbfed8eb900db48a7bea732557ba77181d` |
| `apps/` | `d6ec471bf1d4acfb42fef4b82b22ce91a2c50437` |
| `native/` | `ce2ff0fa43dd3a78baa61bdc7c6b2c169b4d32bf` |
| `website/` | `cb57855ea4c518a289309328e726e49069898035` |

## Neden düz dosya özeti değil?

H02 mimari rehberi, `run_agent.py`nin facade olduğunu; döngünün `agent/conversation_loop.py` ve `agent/turn_*.py`ye, state'in `hermes_state_*` dosyalarına ayrıldığını söylüyor. H04'te gerçek review kodu da başka modüllere uzanıyor. Dolayısıyla bir dosyayı bitirmek bir davranışı bitirmek değildir.

Öte yandan benzer adlı veya facade'dan import edilen her dosya aynı derinlikte okunmak zorunda değildir. Mevcut mekanizma sorusunu taşıyan yol izlenir; dışarıda kalan önemli bölge coverage tablosunda görünür kalır. UI/kanal/env varyantlarının kontrol/persistence semantiği farklıysa ortak çekirdeğe dayanıyor diye atlanmaz.

## Açık envanter işi

Aile bazında alt tree'leri çıkar; kritik dosyaları, generated/compat alanlarını ve test/eval karşılıklarını ayır. Büyük yanıt kesilirse alt tree bazında devam et. Dosya listelenmesi ve içeriğinin okunması ayrı ilerleme ölçüleridir. U01 dışında bilinen geniş bölgeler henüz açıklanmadığı için bu aşama bütün HERMES kapanışını taşımaz.

Kaynak kimlikleri: [SOURCE-LEDGER](../SOURCE-LEDGER.md), T00/T01/H02/H04/H11.
