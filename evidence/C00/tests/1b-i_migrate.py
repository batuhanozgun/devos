#!/usr/bin/env python3
"""One-off migration for W-C00-12 tranche 1b-i. Reads plan/ledger.md at the base commit (from git),
writes plan/work/*.md and plan/decisions/*.md. Run from the repository root."""
import re
import subprocess
import sys
from pathlib import Path

import yaml

BASE = sys.argv[1]
src = subprocess.run(["git", "show", f"{BASE}:plan/ledger.md"], capture_output=True, text=True, check=True).stdout
W = Path("plan/work")
DD = Path("plan/decisions")
W.mkdir(parents=True, exist_ok=True)
DD.mkdir(parents=True, exist_ok=True)


def cells(row):
    c = [x.strip() for x in row.strip().split("|")[1:-1]]
    return c


def fm(d):
    return "---\n" + yaml.safe_dump(d, sort_keys=False, allow_unicode=True, width=100000) + "---\n"


note_n = [0]
notes = {}  # target id -> list of (text, status, origin)


def note(target, text, status, origin):
    notes.setdefault(target, []).append((text, status, origin))


# ---- work items (ledger section 2)
sec2 = src.split("## 2. Work list: C00", 1)[1].split("\n---", 1)[0]
items = {}
for line in sec2.splitlines():
    if line.startswith("| W-C00-"):
        c = cells(line)
        assert len(c) == 5, (c[0], len(c))
        items[c[0]] = c

titles = {k: v[1] for k, v in items.items()}
EXEC = {"W-C00-01": "finished", "W-C00-02": "finished", "W-C00-03": "waiting", "W-C00-04": "finished",
        "W-C00-05": "finished", "W-C00-06": "planned", "W-C00-07": "planned", "W-C00-08": "planned",
        "W-C00-09": "planned", "W-C00-10": "planned", "W-C00-11": "planned", "W-C00-12": "running"}
CLAIM = {"W-C00-12": "session_01S1vPB2jo4bzk1w8XqWekj6"}

# ---- open items (section 5)
sec5 = src.split("## 5. Open items", 1)[1]
rows = []
cur = None
for line in sec5.splitlines():
    if line.startswith("| OI-") or line.startswith("| ~~OI-"):
        if cur:
            rows.append(cur)
        cur = line
    elif cur is not None and line.startswith("- "):
        cur += "\n" + line
    elif cur is not None and line.strip() == "":
        rows.append(cur)
        cur = None
if cur:
    rows.append(cur)
oi = {}
for r in rows:
    c = [x.strip() for x in r.strip().split(" | ")]
    c[0] = c[0].lstrip("| ").strip()
    c[-1] = c[-1].rstrip(" |").strip()
    assert len(c) == 3, (c[0], len(c))
    oid = re.search(r"OI-\d+", c[0]).group(0)
    oi[oid] = c

OI_TARGET = {"OI-001": ("C01", "open"), "OI-002": ("W-C00-03", "open"), "OI-003": ("C00", "open"),
             "OI-004": ("C01", "open"), "OI-005": ("C01", "open"), "OI-006": ("C02", "open"),
             "OI-007": ("C02", "open"), "OI-008": ("W-C00-02", "closed"), "OI-010": ("W-C00-12", "answered"),
             "OI-012": ("W-C00-12.1", "closed")}
for oid, (tgt, st) in OI_TARGET.items():
    c = oi[oid]
    note(tgt, f"**{c[0]}** (moved verbatim from `plan/ledger.md` section 5)\n\n**Item:** {c[1]}\n\n**Position:** {c[2]}",
         st, oid)

# OI-011 split into its input list and 24 items
o11 = oi["OI-011"][1]
pos, starts = 0, []
for n in range(1, 25):
    i = o11.index(f"({n}) ", pos)
    starts.append(i)
    pos = i + 1
for head in ["Structural: ", "Working with Batu: ", "Added later on 2026-10-02 from the same conversation: "]:
    j = o11.index(head)
    k = min(s for s in starts if s > j)
    starts[starts.index(k)] = j
pieces = [o11[:starts[0]]] + [o11[starts[i]:(starts[i + 1] if i + 1 < 24 else len(o11))] for i in range(24)]
assert "".join(pieces) == o11
OI11_TARGET = {10: ("W-C00-06", "open"), 12: ("W-C00-06", "open"), 16: ("W-C00-07", "open"),
               18: ("C04", "open"), 19: ("C04", "open"), 21: ("C04", "open")}
note("W-C00-12", "**OI-011, input list** (moved verbatim from `plan/ledger.md` section 5; the inputs are answered "
     "through acceptance clauses (a2) to (m), `plan/builder/w-c00-12/08_oi011_dispositions.md` introduction)\n\n"
     + pieces[0].strip(), "answered", "OI-011")
item20 = None
for n in range(1, 25):
    tgt, st = OI11_TARGET.get(n, ("W-C00-12", "answered"))
    if n == 17:
        st = "closed"
    disp = f"Disposition: `plan/builder/w-c00-12/08_oi011_dispositions.md` section 1, row {n}."
    note(tgt, f"**OI-011 item {n}** (moved verbatim from `plan/ledger.md` section 5). {disp}\n\n" + pieces[n].strip(),
         st, f"OI-011#{n}")
    if n == 20:
        item20 = (tgt, len(notes[tgt]))
POINTERS20 = {"C03": "agent governance and activity monitoring (and G-001)",
              "C06": "workflow engines and observability; voice channels for the decision channel",
              "C07": "conversational agent builders as SOUL comparators",
              "C08": "deployment hosts", "C11": "model hubs"}

# 06 section 3a g notes
G = {"C03": "the reviewer role moves to the audit environment with its own token",
     "C04": "lenses and heritage re-anchored to `Source` IDs and searched through DevOS search",
     "C09": "the recovery drill also restores the builder's state from `main` and the database (CD §3 says C08–C09)"}
for st_, t in G.items():
    note(st_, f"**Counter-design hand-over note** (`plan/builder/w-c00-12/06_counter_design_comparison.md` section 3a "
              f"row g, adopted): {t}.", "open", "06#3a-g")

# ---- number notes in a stable order and keep pointers for item 20
order = ["W-C00-02", "W-C00-03", "W-C00-06", "W-C00-07", "W-C00-12", "W-C00-12.1", "C00", "C01", "C02", "C03",
         "C04", "C06", "C07", "C08", "C09", "C11"]
numbered = {}
ids = {}
for t in order:
    for k, (text, st, origin) in enumerate(notes.get(t, [])):
        note_n[0] += 1
        nid = f"N-{note_n[0]:03d}"
        numbered.setdefault(t, []).append((nid, text, st, origin))
        ids[(t, k)] = nid
n20 = ids[(item20[0], item20[1] - 1)]
for st_, t in POINTERS20.items():
    note_n[0] += 1
    numbered.setdefault(st_, []).append((f"N-{note_n[0]:03d}",
        f"**Design reference for this stage** from OI-011 item 20 ({n20} on `W-C00-12`, verbatim there): {t}.",
        "open", "OI-011#20"))
EXTRA = [("C08", "N-038", "C09", "the recovery drill also restores the builder's state (06 section 3a row g names C08–C09)", "06#3a-g"),
         ("C00", "OI-004", "C01", "the commit identity is checked first in C00 step 1 (B3 check), then in C01 row 11", "OI-004"),
         ("C05", "OI-007", "C02", "the behavioural part of the FND-001 regression test (the DR10 hidden exam) belongs to C05", "OI-007")]
for tgt, ref, home, t, origin in EXTRA:
    nid = ref if ref.startswith("N-") else next(n for n, _, _, o in numbered.get(home, []) if o == ref)
    note_n[0] += 1
    numbered.setdefault(tgt, []).append((f"N-{note_n[0]:03d}", f"**Pointer** to {nid} on `{home}` (verbatim there): {t}.", "open", origin))
assert set(notes) <= set(order), set(notes) - set(order)


def notes_md(t):
    out = []
    for nid, text, st, origin in numbered.get(t, []):
        out.append(f"<!-- note {nid} status={st} origin={origin} -->\n{text}\n<!-- /note -->")
    return ("\n## Notes\n\n" + "\n\n".join(out) + "\n") if out else ""


# ---- write work items
for iid, c in items.items():
    meta = {"id": iid, "kind": "item", "parent": "C00", "title": c[1], "scope": "installation",
            "admission": "admitted", "execution": EXEC[iid], "acceptance": "proposed"}
    if iid in CLAIM:
        meta["claimed_by"] = CLAIM[iid]
    if iid in ("W-C00-06", "W-C00-07", "W-C00-08", "W-C00-09"):
        meta["depends_on"] = ["W-C00-12"]
    if iid == "W-C00-10":  # its acceptance names the findings of 03, 07, 08 and 09 (critic of 1b-i, finding 7)
        meta["depends_on"] = ["W-C00-12", "W-C00-07", "W-C00-08", "W-C00-09",
                              {"id": "W-C00-03", "on": "finished",
                               "reason": "W-C00-03's final version is made at W-C00-10 itself; its first version is enough to start"}]
    if iid == "W-C00-11":  # the stage closure review checks every C00 item
        meta["depends_on"] = ["W-C00-12"] + [f"W-C00-{n:02d}" for n in range(1, 11)]
    meta["legacy_status"] = c[3]
    meta["evidence"] = c[4]
    meta["migrated_in"] = "W-C00-12 tranche 1b-i"
    if iid == "W-C00-12":
        meta["composition"] = ("acceptance (d): the outside review of purpose and robustness, and the composition "
                               "review of `plan/builder/w-c00-12/12_tranche_plan.md` section 2 item 3")
    body = (f"# {iid} · {c[1]}\n\nMigrated from `plan/ledger.md` section 2 in W-C00-12 tranche 1b-i. The acceptance "
            f"text below is byte-identical to its source cell (W-R16, T-W10). `acceptance: proposed` is the truthful "
            f"mapping of the v1.7 status, kept verbatim in `legacy_status` (`plan/builder/w-c00-12/14_tranche_1b-i_intent.md` section 2).\n\n"
            f"## Acceptance\n\n<!-- acceptance -->\n{c[2]}\n<!-- /acceptance -->\n")
    (W / f"{iid}.md").write_text(fm(meta) + "\n" + body + notes_md(iid))

# ---- W-C00-12 children (tranche parts)
parts = [("W-C00-12.1", "Tranche 1a: probes", "finished", None,
          "Its contents and its (empty) gate are `plan/builder/w-c00-12/12_tranche_plan.md` section 2.1 row 1a and "
          "section 2.2 row 1a; the deferral of H-PRB and P-W12-3 (L-044) is checked by the session Verifier of tranche "
          "1b-i (row 1a's Review cell).", []),
         ("W-C00-12.2", "Tranche 1b-i: records and render", "running", "session_01S1vPB2jo4bzk1w8XqWekj6",
          "As `plan/builder/w-c00-12/12_tranche_plan.md` section 2.1 row 1b-i, with the gate tests of section 2.2 row "
          "1b-i passing, the conditions C1 (b, c), C2 and C4 of `plan/builder/w-c00-12/13_r-w12-2_dispositions.md` "
          "section 1 met in the text, and a session Verifier PASS bound to the PR head.",
          [{"id": "W-C00-12.1", "on": "finished",
            "reason": "1a's deferral is judged by this part's session Verifier (12 section 2.1, row 1a)"}]),
         ("W-C00-12.3", "Tranche 1b-ii: checks and stop", "planned", None,
          "As `plan/builder/w-c00-12/12_tranche_plan.md` section 2.1 row 1b-ii, with the gate tests of section 2.2 row "
          "1b-ii passing, the conditions C1 (a) and C5 of `plan/builder/w-c00-12/13_r-w12-2_dispositions.md` section 1 "
          "met in the text, and a session Verifier PASS bound to the PR head.", ["W-C00-12.2"]),
         ("W-C00-12.4", "Tranche 1c: hooks, CLAUDE.md, roles", "planned", None,
          "As `plan/builder/w-c00-12/12_tranche_plan.md` section 2.1 row 1c, with the gate tests of section 2.2 row 1c "
          "passing, the conditions C3 and C6 of `plan/builder/w-c00-12/13_r-w12-2_dispositions.md` section 1 met in "
          "the text, and a session Verifier PASS bound to the PR head, with T-R1 planted problems.", ["W-C00-12.3"]),
         ("W-C00-12.5", "Tranche 1d: workflows, retirement, plan text", "planned", None,
          "As `plan/builder/w-c00-12/12_tranche_plan.md` section 2.1 row 1d, with the gate tests of section 2.2 row 1d "
          "passing and a session Verifier PASS bound to the PR head.", ["W-C00-12.4"])]
for pid, title, ex, claim, acc, dep in parts:
    meta = {"id": pid, "kind": "item", "parent": "W-C00-12", "title": title, "scope": "installation",
            "admission": "admitted", "execution": ex, "acceptance": "proposed"}
    if claim:
        meta["claimed_by"] = claim
    if dep:
        meta["depends_on"] = dep
    meta["admitted_in"] = "L-046"
    body = (f"# {pid} · {title}\n\nA child of W-C00-12, created in tranche 1b-i because W-C00-12's work has started "
            f"(`plan/builder/w-c00-12/03_work_model.md` section 7). Its acceptance points to the tranche plan; it "
            f"restates no rule.\n\n## Acceptance\n\n<!-- acceptance -->\n{acc}\n<!-- /acceptance -->\n")
    (W / f"{pid}.md").write_text(fm(meta) + "\n" + body + notes_md(pid))

# ---- stages and root
STAGES = [("C00", "Start, function comparison and independent review of the plan", "Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi"),
          ("C01", "Platform verification", "Platform doğrulaması"),
          ("C02", "Data model, rule gate and identity chain", "Veri modeli, kural kapısı ve kimlik zinciri"),
          ("C03", "Trust boundaries and effect channels", "Güven sınırları ve etki kanalları"),
          ("C04", "Knowledge, search and context", "Bilgi, arama ve bağlam"),
          ("C05", "Common rules, roles and methods", "Ortak kurallar, roller ve yöntemler"),
          ("C06", "Working order, audit and decision channel", "Çalışma düzeni, denetim ve karar kanalı"),
          ("C07", "First real loop: the cognitive gate", "İlk gerçek döngü: bilişsel kapı"),
          ("C08", "Model access layer, release, whole product and the SOUL repository", "Model erişim ara katmanı, yayın, bütün ürün ve SOUL deposu"),
          ("C09", "Outage, backup, restore and reconnection", "Kesinti, yedek, geri yükleme ve yeniden bağlama"),
          ("C10", "Learning, purpose audit, process limit and assumption inventory", "Öğrenme, amaç denetimi, süreç sınırı ve varsayım envanteri"),
          ("C11", "Integrated testing, unattended operation, capacity and provider independence", "Bütünleşik sınama, gözetimsiz çalışma, kapasite ve sağlayıcı bağımsızlığı"),
          ("C12", "Hand-over", "Devir")]
sec3 = src.split("### C00\n", 1)[1].split("\n---", 1)[0].strip("\n")
prev = None
for sid, en, tr in STAGES:
    meta = {"id": sid, "kind": "stage", "parent": "INSTALL", "title": en, "title_tr": tr,
            "scope": "installation", "admission": "admitted",
            "execution": "running" if sid == "C00" else "planned", "acceptance": "proposed"}
    if prev:
        meta["depends_on"] = [prev]
    if sid == "C00":
        meta["hold_until"] = "W-C00-12"
    meta["plan_section"] = f"plan/DevOS_Kurulum_Plani.md section 9, {sid}"
    if sid == "C00":
        acc = sec3
        lead = ("The acceptance text below is byte-identical to `plan/ledger.md` section 3 (C00) at the migration's base "
                "commit (W-R16, T-W10). `hold_until: W-C00-12` encodes the Stage row's hold (R-W12-2 B-1 b): the render "
                "applies it to every item of this stage except W-C00-12 and its children, including items created later.")
    else:
        acc = None
        lead = (f"A planned stage. Its items are created when its discovery item starts (`plan/builder/w-c00-12/03_work_model.md` "
                f"section 10). Its acceptance conditions are the \"Kabul\" conditions of {sid} in `plan/DevOS_Kurulum_Plani.md` "
                f"section 9 (Turkish, binding until the translation fidelity review passes, plan 0.6). They enter this file as "
                f"its acceptance block when the stage starts; there is no block before that, so adding it then is a new block "
                f"(class normal), not a change to an existing one.")
    body = f"# {sid} · {en}\n\n{lead}\n" + (f"\n## Acceptance\n\n<!-- acceptance -->\n{acc}\n<!-- /acceptance -->\n" if acc else "")
    (W / f"{sid}.md").write_text(fm(meta) + "\n" + body + notes_md(sid))
    prev = sid
root = {"id": "INSTALL", "kind": "root", "title": "DevOS installation, stages C00 to C12", "scope": "installation",
        "purpose_chain": ["SOUL: Batu's goal (plan/DevOS_Kurulum_Plani.md section 1.1)",
                          "DevOS: the system that builds SOUL",
                          "Installation C00–C12: builds DevOS (plan section 9)"]}
(W / "INSTALL.md").write_text(fm(root) + "\n# Installation root\n\nThe top of every purpose chain that "
    "`tools/records.py brief` prints. It points to the plan; it restates no purpose text.\n")
print("notes:", note_n[0])
