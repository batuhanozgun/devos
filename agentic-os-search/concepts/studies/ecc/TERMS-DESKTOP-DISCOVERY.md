# ECC — Desktop discovery and local action uses

2026-09-23 · **C6 post-U12 transfer / U18-G extraction.** Bu dosya desktop dashboard'ın source discovery, representation, refresh ve local terminal/document action kullanımlarını taşır. DD kimlikleri generic “dashboard” tanımı veya browser dashboard için proxy değildir.

Source package:
- U18-G Note46 + U18-G sources + MR47 + publication.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; no GUI/browser/server/terminal/model launch or user-config mutation.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-DD01–DD40 | [Note46](../../../research/studies/ecc/notes/46-DESKTOP-DASHBOARD-DISCOVERY-AND-ACTION-BOUNDARIES.md) §§1–8 → [U18-G ledger](../../../research/studies/ecc/evidence/U18-G-SOURCES.md) → [MR47](../../../research/studies/ecc/ROUND-U18-G.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-G.md) | SOURCE OBSERVATION + TEST SOURCE INSPECTED + bounded Python interface contracts/conditional deductions; no GUI/terminal/browser execution. |

Desktop source discovery, displayed standing and OS dispatch are separate evidence objects; source-study claims are not runtime observations.

## 1. Desktop explorer and displayed standing

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-DD01 — desktop dashboard | Tkinter repository-component explorer. | Live Rust/Node operator, scheduler or agent supervisor değil. |
| ECC-DD02 — component root | Selected filesystem source tree used for agents/skills/commands/rules discovery. | Installed-host registry or active runtime root değil. |
| ECC-DD03 — agent discovery | Direct Markdown scan + simple frontmatter name/description extraction. | Recursive semantic agent inventory/host activation değil. |
| ECC-DD04 — skill discovery | Skill subdirectory scan and simple category/description projection. | SKILL semantics/loader state or executable capability proof değil. |
| ECC-DD05 — command discovery | Direct command Markdown filename/heading projection. | Slash-command registration/host admission guarantee değil. |
| ECC-DD06 — rule discovery | One-level Markdown rule scan. | Active policy/enforcement or complete recursive rule inventory değil. |
| ECC-DD07 — hard-coded fallback catalogue | Empty discovery result replaced by example records. | Observed source content veya installed capability değil. |
| ECC-DD08 — count/Ready presentation | UI counts/status derived from returned lists including fallbacks. | Nonzero count = discovered/usable component proof değil. |
| ECC-DD09 — fallback provenance loss | Fallback and observed records share list/status without explicit origin field. | User necessarily misled or component unavailable globally değil. |
| ECC-DD10 — fallback skill shape mismatch | Fallback skill lacks `path`, detail callback assumes it. | Executed GUI crash incident değil; conditional consumer mismatch. |
| ECC-DD11 — skill short-description projection | First nonempty non-heading line used as skill description. | YAML/frontmatter semantic description parser değil. |
| ECC-DD12 — frontmatter delimiter description | A normal opening `---` can become displayed short description. | Source skill content corrupt or host misreads it değil. |
| ECC-DD13 — static GUI version text | Header/About version label. | Package/runtime version readback değil. |
| ECC-DD14 — loaded dataset | In-memory agents/skills/commands/rules from last load/refresh. | Current editable path/action target automatically same değil. |
| ECC-DD15 — selected action root | Current path-entry value used by terminal/document callbacks. | Lists have been refreshed from same root guarantee değil. |
| ECC-DD16 — A/B root drift | User can load A, edit/select B without refresh, then actions target B while lists show A. | Automatic wrong-project code mutation proof değil. |
| ECC-DD17 — manual refresh | Explicit reload of four datasets and primary tab/count/status state. | Filesystem watcher/atomic snapshot or all filter/view state refresh değil. |
| ECC-DD18 — stale filter option set | Refresh doesn't rebuild every category/language option or reapply all active filters/count labels. | Entire GUI stale or unusable guarantee değil. |
| ECC-DD19 — repository explorer standing | Source catalogue/manual refresh role. | Authoritative execution/installed-state view değil. |

## 2. Terminal and document action boundary

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-DD20 — terminal path canonicalization | Selected path resolved/canonicalized before launch. | Later terminal process remains confined to that path değil. |
| ECC-DD21 — directory qualification | Runtime helper refuses non-directory/missing target. | User intent/project identity/auth authority proof değil. |
| ECC-DD22 — Windows terminal launch | `cmd.exe` with cwd/new-console settings. | Actual Windows console readiness/completion verified değil. |
| ECC-DD23 — macOS terminal launch | `open -a Terminal <dir>` separate path arg. | Terminal app opens/uses expected final cwd guarantee değil. |
| ECC-DD24 — Linux terminal launch | Fixed bash script with selected directory as positional arg. | “No shell interpreter” değil; explicit bash exists despite outer shell=False. |
| ECC-DD25 — process dispatch | Popen creation attempt and immediate exception handling. | Child success/completion/returncode observed değil. |
| ECC-DD26 — discarded process handle | Helper does not retain/poll/wait Popen result. | OS app completion receipt veya later failure feedback değil. |
| ECC-DD27 — document fixed-name action | README.md/AGENTS.md target under selected root. | General file browser or arbitrary document access mechanism değil. |
| ECC-DD28 — canonical document containment | Resolved target must remain under resolved base. | Immutable check-to-open binding or universal filesystem sandbox değil. |
| ECC-DD29 — file-URI browser dispatch | Qualified document sent to `webbrowser.open`. | Browser actually opened/displayed document proof değil. |
| ECC-DD30 — ignored browser boolean | Return value from `webbrowser.open` not used for visible failure state. | Missing/containment errors also ignored değil; those have separate handling. |
| ECC-DD31 — best-effort maximize | zoomed/attribute fallbacks for window state. | GUI/runtime readiness or platform equivalence değil. |

## 3. Distribution and test surfaces

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-DD32 — full-clone requirement | Troubleshooting explicitly directs desktop use from full repository clone. | Plugin/npm installation necessarily contains GUI entry proof değil. |
| ECC-DD33 — package dashboard script | package.json maps desktop/browser launch commands. | Built package actually includes/executes root Python GUI guarantee değil. |
| ECC-DD34 — browser alternative | Separate `dashboard:web` JavaScript implementation. | Desktop findings automatically apply to HTTP/browser surface değil. |
| ECC-DD35 — runtime-helper test | Tests Tk-independent terminal/maximize helper behavior via snippets. | Full GUI/fallback/refresh/browser completion test değil. |
| ECC-DD36 — Linux argument test | Dangerous-looking path remains argv data in helper test. | Shell command executed or whole Linux terminal security verified değil. |
| ECC-DD37 — simulated Windows kwargs test | Checks shape of Windows launch arguments. | Real Windows process behavior verified değil. |
| ECC-DD38 — missing-directory test | Runtime helper refusal for invalid directory. | GUI source/data validity or installed component presence proof değil. |
| ECC-DD39 — selected pack-test prefix | npm publish-surface source partially inspected. | Actual package contents/desktop usability publication result değil. |
| ECC-DD40 — browser lead | dashboard-web.js1–140 only qualified separate U18-H source. | Browser routes/guards/content/actions/security already researched değil. |

## 4. U18-G non-collapse

- source files ≠ installed capability;
- fallback example ≠ observed component;
- component count ≠ active component count;
- Ready label ≠ runtime readiness;
- loaded dataset ≠ selected action root;
- refresh success ≠ complete view refresh;
- canonical path ≠ later process confinement;
- process creation ≠ application completion;
- document containment ≠ browser success;
- desktop dashboard ≠ live operator;
- desktop dashboard ≠ browser dashboard.

U18-G answers only Q08d1 desktop source scope. Q08d2/browser is genuine unread source-study work and remains NOT STARTED here; Q08d3 stronger installed/runtime/view-fidelity questions also remain open.
