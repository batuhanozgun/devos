#!/usr/bin/env python3
"""records.py: the builder's file records (W-C00-12 tranche 1b-i).

Run from the repository root.

  records.py render [--check]          write (or compare) the generated blocks of plan/ledger.md and DURUM.md
  records.py brief <ID> --role <role>  print a task brief for a work item
  records.py brief run --role producer print the run brief
  records.py durum                     print the generated DURUM.md to stdout
  records.py lease --session <ID> [--note TEXT] [--release]
                                       rewrite the Run lock row and print its Record changes line

Homes (02_memory.md section 3): work items and stages in plan/work/<ID>.md; decisions in
plan/decisions/<ID>.md; the current state in plan/ledger.md section 1. Everything this script
writes is generated from those homes; nothing here is a home. Readiness follows
03_work_model.md section 3 (three-valued: an unresolved reference makes an item not ready).
"""
import argparse
import hashlib
import re
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

import yaml

ROOT = Path(".")
WORK = ROOT / "plan/work"
DECISIONS = ROOT / "plan/decisions"
LEDGER = ROOT / "plan/ledger.md"
DURUM = ROOT / "DURUM.md"
LOGDIR = ROOT / "plan/ledger"
TR = timezone(timedelta(hours=3))  # Europe/Istanbul, fixed UTC+3 since 2016

ACC_RE = re.compile(r"<!-- acceptance -->\n(.*?)\n<!-- /acceptance -->", re.S)
NOTE_RE = re.compile(r"<!-- note (N-\d+)((?: [a-z_]+=[^ >]+)*) -->\n(.*?)\n<!-- /note -->", re.S)
GEN_RE = r"(<!-- generated:{name} -->\n)((?:(?!<!-- /?generated).)*?)(\n<!-- /generated -->)"

ROLE_FILES = {
    "producer": "CLAUDE.md and plan/Builder_Operating_Model.md section 3.1 (the producer has no separate role file, 04_roles.md section 3)",
    "verifier": "plan/builder/REVIEW_PROMPT.md",
    "critic": ".claude/agents/critic.md",
    "triager": ".claude/agents/triager.md",
    "researcher": ".claude/agents/researcher.md",
    "counter-designer": "plan/builder/roles/counter-designer.md",
    "probe": "plan/builder/roles/probe.md",
}


class RecordError(Exception):
    pass


# ---------------------------------------------------------------- loading

def split_front(text, path):
    if not text.startswith("---\n"):
        raise RecordError(f"{path}: no front matter")
    end = text.index("\n---\n", 4)
    meta = yaml.safe_load(text[4:end]) or {}
    return meta, text[end + 5:]


def load_records(root=ROOT):
    items, decisions = {}, {}
    for p in sorted((root / "plan/work").glob("*.md")):
        meta, body = split_front(p.read_text(), p)
        if meta.get("id") != p.stem:
            raise RecordError(f"{p}: id '{meta.get('id')}' does not match the file name")
        m = ACC_RE.search(body)
        meta["_acceptance"] = m.group(1) if m else None
        notes = []
        for nm in NOTE_RE.finditer(body):
            attrs = dict(a.split("=", 1) for a in nm.group(2).split())
            notes.append({"id": nm.group(1), "status": attrs.get("status", "open"),
                          "origin": attrs.get("origin", ""), "blocks": attrs.get("blocks") == "true",
                          "text": nm.group(3)})
        meta["_notes"] = notes
        meta["_path"] = str(p.relative_to(root))
        items[meta["id"]] = meta
    ddir = root / "plan/decisions"
    if ddir.exists():
        for p in sorted(ddir.glob("*.md")):
            meta, body = split_front(p.read_text(), p)
            if meta.get("id") != p.stem:
                raise RecordError(f"{p}: id '{meta.get('id')}' does not match the file name")
            meta["_path"] = str(p.relative_to(root))
            decisions[meta["id"]] = meta
    return items, decisions


def children(items, pid):
    return sorted((i for i in items.values() if i.get("parent") == pid), key=lambda i: sortkey(i["id"]))


def sortkey(i):
    return [int(x) if x.isdigit() else x for x in re.split(r"(\d+)", i)]


def ancestors(items, iid):
    out, cur = [], items.get(iid)
    while cur is not None and cur.get("parent"):
        cur = items.get(cur["parent"])
        if cur is None:
            break
        out.append(cur)
    return out


def stage_of(items, iid):
    for a in [items[iid]] + ancestors(items, iid):
        if a.get("kind") == "stage":
            return a
    return None


def deps(item):
    out = []
    for d in item.get("depends_on") or []:
        if isinstance(d, str):
            out.append({"id": d, "on": "accepted", "reason": ""})
        else:
            out.append({"id": d.get("id"), "on": d.get("on", "accepted"), "reason": d.get("reason", "")})
    return out


# ---------------------------------------------------------------- staleness (W-R9)

def record_changes(root=ROOT):
    """(entry number, segment) for every Record changes segment of the log."""
    out = []
    for p in sorted((root / "plan/ledger").glob("*-log.md")):
        num = 0
        for line in p.read_text().splitlines():
            h = re.match(r"### L-(\d+)", line)
            if h:
                num = int(h.group(1))
            if line.startswith("- **Record changes:**"):
                for seg in line.split(";"):
                    out.append((num, seg))
    return out


def qualification(item, decisions, changes):
    """('current'|'stale'|'unknown', reason)."""
    since = int(str(item.get("assumes_checked", "L-0")).split("-")[1])
    for a in item.get("assumes") or []:
        d = decisions.get(a)
        if d is None and re.match(r"(D|PC|FR)-\d", a):
            return "unknown", f"assumed record {a} not found"
        if d is not None and d.get("status") in ("superseded", "retired", "reopened"):
            return "stale", f"assumed {a} is {d['status']}"
        for num, seg in changes:
            if num > since and re.search(r"(?<![\w-])" + re.escape(a) + r"(?![\w-])", seg) and \
                    re.search(r"·\s*(correction|supersession|retirement)\b", seg):
                return "stale", f"assumed {a} changed in L-{num:03d}"
    return "current", ""


# ---------------------------------------------------------------- readiness (03 section 3)

def is_accepted(item):
    return item.get("acceptance") == "accepted"


def is_closed(item):
    return item.get("admission") == "declined" or item.get("execution") == "cancelled" or is_accepted(item)


def readiness(items, decisions, changes, iid):
    """(True|False|None, reason). None means unknown, which is not ready."""
    it = items[iid]
    if it.get("kind") != "item":
        return False, f"{it.get('kind')} record"
    adm = it.get("admission")
    if adm == "candidate":
        return False, "candidate (not admitted)"
    if adm != "admitted":
        return (False, f"admission {adm}") if adm == "declined" else (None, f"admission '{adm}' unknown")
    ex = it.get("execution")
    if ex not in ("planned", "waiting"):
        if ex in ("running", "finished", "cancelled"):
            return False, f"execution {ex}"
        return None, f"execution '{ex}' unknown"
    q, why = qualification(it, decisions, changes)
    if q != "current":
        return (False if q == "stale" else None), f"{q}: {why}"
    stage = stage_of(items, iid)
    if stage is None:
        return None, "no stage ancestor"
    hold = stage.get("hold_until")
    if hold:
        h = items.get(hold)
        if h is None:
            return None, f"stage hold target {hold} not found"
        if not is_accepted(h) and iid != hold and hold not in [a["id"] for a in ancestors(items, iid)]:
            return False, f"stage {stage['id']} on hold until {hold} is accepted"
    for d in deps(it):
        t = items.get(d["id"])
        if t is None:
            return None, f"depends on {d['id']}, which is not found"
        if d["on"] == "finished":
            if not d["reason"]:
                return None, f"edge to {d['id']} marked on: finished without a reason"
            if t.get("execution") != "finished" and not is_accepted(t):
                return False, f"depends on {d['id']} (on: finished; not finished)"
        elif not is_accepted(t):
            return False, f"depends on {d['id']} (not accepted)"
    for pf in it.get("platform") or []:
        st = pf.get("status")
        if st != "observed":
            probe = pf.get("probe") or "a probe (to be named)"
            return False, f"platform fact '{pf.get('fact')}' {st or 'unknown'}: run {probe} first"
    for n in it["_notes"]:
        if n["status"] == "open" and n["blocks"]:
            return False, f"open blocking note {n['id']}"
    for w in it.get("waits_for") or []:
        d = decisions.get(w)
        if d is None:
            return None, f"waits for {w}, which is not found"
        if d.get("status") == "open":
            return False, f"waits for Batu's decision {w}"
    return True, "ready"


def state_label(items, decisions, changes, iid):
    it = items[iid]
    if it.get("kind") == "root":
        return "root"
    if it.get("admission") == "candidate":
        return "candidate"
    if it.get("admission") == "declined":
        return "declined"
    ex = it.get("execution")
    if ex == "cancelled":
        return "cancelled"
    if is_accepted(it):
        return "accepted"
    if ex == "finished":
        return "finished, not accepted"
    if ex == "running":
        c = it.get("claimed_by")
        return f"running ({c})" if c else "running"
    if it.get("kind") == "stage":
        return ex or "unknown"
    r, why = readiness(items, decisions, changes, iid)
    return "ready" if r else ("unknown: " + why if r is None else "blocked: " + why)


def bucket(label):
    return label.split(" ")[0].split(":")[0].rstrip(",")


# ---------------------------------------------------------------- views

def esc(s):
    return str(s).replace("|", "\\|").replace("\n", " ")


def view_frontier(items, decisions, changes):
    ready, running, rest = [], [], []
    for iid in sorted(items, key=sortkey):
        it = items[iid]
        if it.get("kind") != "item" or it.get("admission") != "admitted" or is_closed(it):
            continue
        if it.get("execution") == "running":
            running.append(f"- `{iid}` {it.get('title', '')}: claimed by `{it.get('claimed_by') or 'nobody'}`")
            continue
        if it.get("execution") == "finished":
            rest.append(f"- `{iid}`: finished, waiting for acceptance")
            continue
        r, why = readiness(items, decisions, changes, iid)
        if r:
            ready.append(f"- `{iid}` {it.get('title', '')}")
        else:
            rest.append(f"- `{iid}`: {why}" + ("" if r is False else " (unknown is not ready)"))
    out = ["**Ready (startable now):**", *(ready or ["- none"]), "",
           "**Running:**", *(running or ["- none"]), "",
           "**Not ready, with the first unmet condition:**", *(rest or ["- none"]), "",
           "Selection among ready items: critical path first, heavy items preferably 23:00–08:00 Turkey time, "
           "one logged sentence of reason (`plan/builder/w-c00-12/03_work_model.md` section 3). "
           "Candidates never appear here; they are in the zoom view."]
    return "\n".join(out)


def counts(items, decisions, changes, ids):
    c = {}
    for i in ids:
        b = bucket(state_label(items, decisions, changes, i))
        c[b] = c.get(b, 0) + 1
    return ", ".join(f"{k} {v}" for k, v in sorted(c.items())) or "no items"


def descendants(items, iid):
    out = []
    for ch in children(items, iid):
        out.append(ch["id"])
        out.extend(descendants(items, ch["id"]))
    return out


def view_zoom(items, decisions, changes):
    stages = sorted((i for i in items.values() if i.get("kind") == "stage"), key=lambda i: sortkey(i["id"]))
    lines = ["**Horizontal: every stage, one line each.**", "",
             "| Stage | Title | State | Items by state | Open notes |", "|---|---|---|---|---|"]
    for s in stages:
        lines.append(f"| `{s['id']}` | {esc(s.get('title', ''))} | {state_label(items, decisions, changes, s['id'])} "
                     f"| {counts(items, decisions, changes, descendants(items, s['id']))} "
                     f"| {sum(1 for i in [s['id']] + descendants(items, s['id']) for n in items[i]['_notes'] if n['status'] == 'open')} |")
    claimed = [i for i in items.values() if i.get("kind") == "item" and i.get("execution") == "running"
               and i.get("claimed_by")]
    path = set()
    for c in claimed:
        path.add(c["id"])
        path.update(a["id"] for a in ancestors(items, c["id"]))
    lines += ["", "**Vertical: the active branch expanded; siblings one line; the rest collapsed.**", ""]
    if not claimed:
        lines.append("- no claimed item; no active branch")
        return "\n".join(lines)

    def note_tag(it):
        op = [n["id"] for n in it["_notes"] if n["status"] == "open"]
        return f" · open notes: {', '.join(op)}" if op else ""

    def walk(iid, depth):
        it = items[iid]
        lab = state_label(items, decisions, changes, iid)
        cand = " [candidate]" if it.get("admission") == "candidate" else ""
        kids = children(items, iid)
        if iid in path or depth == 0:
            lines.append(f"{'  ' * depth}- `{iid}` {it.get('title', '')}{cand}: {lab}{note_tag(it)}")
            for k in kids:
                walk(k["id"], depth + 1)
        else:
            sub = f" · {len(kids)} children ({counts(items, decisions, changes, descendants(items, iid))})" if kids else ""
            lines.append(f"{'  ' * depth}- `{iid}` {it.get('title', '')}{cand}: {lab}{note_tag(it)}{sub}")

    for s in stages:
        if s["id"] in path:
            walk(s["id"], 0)
    return "\n".join(lines)


def view_index(items, decisions, changes):
    lines = ["| ID | Item | State | v1.7 status (verbatim) | Evidence | File |", "|---|---|---|---|---|---|"]
    for iid in sorted(items, key=sortkey):
        it = items[iid]
        if it.get("kind") != "item":
            continue
        lines.append(f"| `{iid}` | {esc(it.get('title', ''))} | {esc(state_label(items, decisions, changes, iid))} "
                     f"| {esc(it.get('legacy_status', '—'))} | {esc(it.get('evidence', '—'))} | `{it['_path']}` |")
    return "\n".join(lines)


def view_decisions(decisions):
    lines = ["| ID | What | Class | Status | File |", "|---|---|---|---|---|"]
    for did in sorted(decisions, key=sortkey):
        d = decisions[did]
        lines.append(f"| `{did}` | {esc(d.get('title', ''))} | {d.get('class', '')} | {d.get('status', '')} "
                     f"| `{d['_path']}` |")
    return "\n".join(lines)


def note_summary(n):
    """The note's first content line: the second paragraph when the first is a provenance header."""
    paras = [x for x in re.split(r"\n\s*\n", n["text"].strip()) if x.strip()]
    return (paras[1] if len(paras) > 1 else paras[0]).splitlines()[0] if paras else ""


def view_notes(items):
    lines = ["| Note | On | Origin | Status | First line |", "|---|---|---|---|---|"]
    other = {}
    for iid in sorted(items, key=sortkey):
        for n in items[iid]["_notes"]:
            if n["status"] != "open":
                other.setdefault(n["status"], []).append(n["id"])
                continue
            first = note_summary(n)
            if len(first) > 140:
                first = first[:137] + "..."
            lines.append(f"| `{n['id']}` | `{iid}` | {esc(n['origin'])} | open{' (blocks)' if n['blocks'] else ''} "
                         f"| {esc(first)} |")
    lines.append("")
    why = {"answered": "the design answers them; checked at W-C00-12's composition review",
           "closed": "closed with their disposition"}
    for st, ids in sorted(other.items()):
        lines.append(f"Notes `{st}` ({why.get(st, 'kept on their items')}): {len(ids)} ({', '.join(ids)}).")
    return "\n".join(lines)


# ---------------------------------------------------------------- state file

def state_rows(text):
    rows = {}
    sec = text.split("## 1. Current state", 1)[1].split("\n---", 1)[0]
    for line in sec.splitlines():
        if line.startswith("| ") and not line.startswith("| Item") and not line.startswith("|---"):
            c = [x.strip() for x in re.split(r"(?<!\\)\|", line.strip())[1:-1]]
            if len(c) == 3:
                rows[c[0]] = (c[1], c[2])
    return rows


def replace_block(text, name, content):
    pat = re.compile(GEN_RE.format(name=re.escape(name)), re.S)
    if not pat.search(text):
        raise RecordError(f"plan/ledger.md: generated block '{name}' missing")
    return pat.sub(lambda m: m.group(1) + content + m.group(3), text, count=1)


def render_ledger(text, items, decisions, changes):
    for name, content in [("frontier", view_frontier(items, decisions, changes)),
                          ("zoom", view_zoom(items, decisions, changes)),
                          ("work-index", view_index(items, decisions, changes)),
                          ("decisions-index", view_decisions(decisions)),
                          ("open-notes", view_notes(items))]:
        text = replace_block(text, name, content)
    return text


# ---------------------------------------------------------------- DURUM.md (M-R15)

USAGE_TR = {"allowed": "izinli", "allowed_warning": "uyarı düzeyinde", "rejected": "sınırda (bekleme)",
            "limited": "sınırda (bekleme)"}


def tr_time(iso):
    t = datetime.strptime(iso, "%Y-%m-%dT%H:%MZ").replace(tzinfo=timezone.utc).astimezone(TR)
    months = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim",
              "Kasım", "Aralık"]
    return f"{t.day} {months[t.month - 1]} {t.year}, {t:%H:%M}"


def durum(text, items, decisions, changes):
    rows = state_rows(text)
    summary, summary_asof = rows.get("summary_tr", ("", ""))
    lock = rows.get("Run lock", ("", ""))[0]
    usage = rows.get("Usage", ("", ""))[0]
    wakes = rows.get("Armed wakes", ("", ""))[0]
    open_batu = [d for d in sorted(decisions, key=sortkey) if decisions[d].get("class") == "batu"
                 and decisions[d].get("status") == "open"]
    if open_batu:
        expected = ("Şu kararlar senin: " + ", ".join(f"`{d}` ({decisions[d].get('title_tr') or decisions[d].get('title', '')})"
                                                       for d in open_batu)
                    + ". Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.")
    else:
        expected = "Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok."
    holder = re.search(r"`(session_[A-Za-z0-9]+)`", lock)
    exp = re.search(r"Expires (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", lock)
    rel = re.search(r"Released (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", lock)
    if rel:
        run = f"Çalışan oturum yok; son oturum {tr_time(rel.group(1))} (Türkiye saati) itibarıyla işi bıraktı."
    elif holder and exp:
        run = f"`{holder.group(1)}`; kilit {tr_time(exp.group(1))} (Türkiye saati) tarihine kadar geçerli."
    else:
        run = "bilinmiyor (kilit satırı okunamadı)."
    um = re.search(r"`(five_hour|seven_day)`\s+`(\w+)`", usage)
    ur = re.search(r"resets (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", usage)
    if um:
        win = "beş saatlik" if um.group(1) == "five_hour" else "haftalık"
        u = f"\"{USAGE_TR.get(um.group(2), um.group(2))}\" düzeyinde ({win} pencere)"
        if ur:
            u += f"; pencere {tr_time(ur.group(1))} (Türkiye saati) tarihinde yenileniyor"
        u += "."
    else:
        u = "bilinmiyor (kullanım satırı okunamadı)."
    stage = [s for s in items.values() if s.get("kind") == "stage" and s.get("execution") == "running"]
    st = ", ".join(f"{s['id']} ({s.get('title_tr') or s.get('title', '')})" for s in stage) or "yok"
    hold = [s for s in stage if s.get("hold_until") and not is_accepted(items.get(s["hold_until"], {}))]
    hold_line = "".join(f" {s['id']}'ın geri kalan işleri `{s['hold_until']}` kabul edilene kadar bekliyor."
                        for s in hold)
    ready = [i for i in sorted(items, key=sortkey) if readiness(items, decisions, changes, i)[0] is True]
    running = [i for i in sorted(items, key=sortkey) if items[i].get("kind") == "item"
               and items[i].get("execution") == "running"]
    nxt = (", ".join(f"`{i}`" for i in running) + " sürüyor" if running else "") + \
          ("; başlatılabilir: " + ", ".join(f"`{i}`" for i in ready) if ready else "")
    body = summary.replace("<br>", "\n")
    asof = summary_asof.strip()
    upd = tr_time(asof) if re.fullmatch(r"\d{4}-\d\d-\d\dT\d\d:\d\dZ", asof) else "bilinmiyor"
    out = f"""# DevOS kurulum durumu

**Senden beklenen:** {expected}

**Son güncelleme:** {upd} (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** {st}.{hold_line}

**Çalışan oturum:** {run}

**Sıradaki işler:** {nxt or "yok"}. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** {u}

**Kurulu uyandırmalar:** {"yok" if wakes.strip() in ("", "none") else wakes}

**Şu an**

{body}

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
"""
    return out


# ---------------------------------------------------------------- briefs (W-R5, 03 section 9)

def chain(items, iid):
    nodes = list(reversed([items[iid]] + ancestors(items, iid)))
    out = []
    for n in nodes:
        if n.get("kind") == "root":
            out.extend(n.get("purpose_chain") or [])
        else:
            out.append(f"{n['id']}: {n.get('title', '')}")
    return " → ".join(out)


def brief_item(items, decisions, changes, iid, role, target_sha=None, failure_classes=None):
    if iid not in items:
        raise RecordError(f"no work item {iid}")
    if role not in ROLE_FILES:
        raise RecordError(f"unknown role '{role}'")
    if role == "verifier":
        if not target_sha:
            raise RecordError("a verifier brief needs --target-sha (R-R3a)")
        if not failure_classes:
            raise RecordError("a verifier brief needs a non-empty --failure-classes list (R-R3a)")
    it = items[iid]
    parent = it.get("parent")
    sib = [s for s in children(items, parent) if s["id"] != iid] if parent else []
    down = [i for i in sorted(items, key=sortkey) if any(d["id"] == iid for d in deps(items[i]))]
    lines = [f"# Task brief: {iid}, role {role}", "",
             f"Purpose chain: {chain(items, iid)}",
             f"Scope: {it.get('scope', 'unknown')}",
             f"Record: {it['_path']}", ""]
    if role == "verifier":
        lines += [f"Target SHA: {target_sha}", "Failure classes to look for:",
                  *[f"- {f}" for f in failure_classes], "",
                  "Claims to test (the item's acceptance block, verbatim):"]
    else:
        lines.append("Acceptance block (verbatim):")
    lines += ["", it.get("_acceptance") or "(no acceptance block)", "",
              "Siblings:", *([f"- {s['id']} {s.get('title', '')}: {state_label(items, decisions, changes, s['id'])}"
                             for s in sib] or ["- none"]),
              "Downstream (items that depend on this one):",
              *([f"- {d}: {state_label(items, decisions, changes, d)}" for d in down] or ["- none"]),
              f"Parent composition: {parent or 'none'}"
              + (" (the parent is done only after its own composition check, not from its children)" if parent else ""),
              "Assumes:", *([f"- {a}: {decisions[a].get('status') if a in decisions else 'see its home'}"
                             for a in it.get("assumes") or []] or ["- nothing recorded"]),
              "Open notes on this item and its ancestors:"]
    on = [(a["id"], n) for a in [it] + ancestors(items, iid) for n in a["_notes"] if n["status"] == "open"]
    lines += [f"- {n['id']} on {a}: {note_summary(n)[:160]}" for a, n in on] or ["- none"]
    rf = ROLE_FILES[role]
    built = Path(rf.split(" ")[0]).exists()
    lines += ["", f"Role file: {rf}" + ("" if built else " (not yet built; tranche 1c)"),
              "Common floor: plan/Ek_A_Rol_Sozlesmeleri.md section 2 and plan/Ek_D_Dusunme_Protokolleri.md section 2 "
              "(by reference)."]
    return finish(lines, iid, role)


def brief_run(items, decisions, changes):
    stages = [s for s in items.values() if s.get("kind") == "stage" and s.get("execution") == "running"]
    if len(stages) != 1:
        raise RecordError(f"a run brief needs exactly one running stage, found {len(stages)}")
    s = stages[0]
    lines = ["# Run brief: role producer", "",
             f"Purpose chain: {chain(items, s['id'])}", f"Scope: {s.get('scope', 'unknown')}", "",
             f"Active stage {s['id']} acceptance (verbatim from {s['_path']}):", "",
             s.get("_acceptance") or "(none)", ""]
    if s.get("hold_until"):
        lines += [f"Stage hold: {s['id']} items wait until {s['hold_until']} is accepted.", ""]
    lines += ["Frontier (generated):", "", view_frontier(items, decisions, changes), "",
              "Boot order: " + ROLE_FILES["producer"] + ". Take or confirm the lease before any record write."]
    return finish(lines, "run", "producer")


def finish(lines, iid, role):
    text = "\n".join(lines) + "\n"
    h = hashlib.sha256(text.encode()).hexdigest()[:16]
    return text + f"\nTask-Brief: {iid} {role} {h}\n"


# ---------------------------------------------------------------- lease

def lease(text, session, note, release, now=None):
    now = now or datetime.now(timezone.utc)
    stamp = now.strftime("%Y-%m-%dT%H:%MZ")
    if release:
        tail = f"Released {stamp}"
    else:
        tail = "Expires " + (now + timedelta(hours=3)).strftime("%Y-%m-%dT%H:%MZ")
    body = f"`{session}`" + (f" ({note})" if note else "") + f". {tail}"
    new = f"| Run lock | {esc(body)} | {stamp} |"
    lines = text.splitlines(keepends=True)
    hits = [n for n, l in enumerate(lines) if l.startswith("| Run lock |")]
    if len(hits) != 1:
        raise RecordError(f"plan/ledger.md: expected one Run lock row, found {len(hits)}")
    lines[hits[0]] = new + "\n"
    return "".join(lines), f"plan/ledger.md Run lock · supersession · {'release' if release else 'lease take or renewal'} by {session}"


# ---------------------------------------------------------------- main

def main(argv=None):
    ap = argparse.ArgumentParser(prog="records.py")
    sub = ap.add_subparsers(dest="cmd", required=True)
    r = sub.add_parser("render")
    r.add_argument("--check", action="store_true")
    b = sub.add_parser("brief")
    b.add_argument("id")
    b.add_argument("--role", required=True)
    b.add_argument("--target-sha")
    b.add_argument("--failure-classes", nargs="*")
    sub.add_parser("durum")
    l_ = sub.add_parser("lease")
    l_.add_argument("--session", required=True)
    l_.add_argument("--note", default="")
    l_.add_argument("--release", action="store_true")
    a = ap.parse_args(argv)
    try:
        items, decisions = load_records()
        changes = record_changes()
        text = LEDGER.read_text()
        if a.cmd == "render":
            new = render_ledger(text, items, decisions, changes)
            d_new = durum(new, items, decisions, changes)
            if a.check:
                bad = []
                if new != text:
                    bad.append("plan/ledger.md")
                if not DURUM.exists() or DURUM.read_text() != d_new:
                    bad.append("DURUM.md")
                if bad:
                    print("RENDER DIFFERS: " + ", ".join(bad))
                    return 1
                print("RENDER OK")
                return 0
            LEDGER.write_text(new)
            DURUM.write_text(d_new)
            print("rendered plan/ledger.md and DURUM.md")
        elif a.cmd == "brief":
            if a.id == "run":
                if a.role != "producer":
                    raise RecordError("a run brief has role producer")
                sys.stdout.write(brief_run(items, decisions, changes))
            else:
                sys.stdout.write(brief_item(items, decisions, changes, a.id, a.role, a.target_sha,
                                            a.failure_classes))
        elif a.cmd == "durum":
            sys.stdout.write(durum(text, items, decisions, changes))
        elif a.cmd == "lease":
            new, line = lease(text, a.session, a.note, a.release)
            LEDGER.write_text(new)
            print(line)
    except (RecordError, OSError, yaml.YAMLError) as e:
        print(f"records.py: {e}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
