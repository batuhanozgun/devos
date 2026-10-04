#!/usr/bin/env python3
"""records.py: the builder's file records (W-C00-12 tranche 1b-i).

Run from the repository root.

  records.py render [--check]          write (or compare) the generated blocks of plan/ledger.md and DURUM.md
  records.py brief <ID> --role <role>  print a task brief for a work item
  records.py brief run --role producer print the run brief
  records.py durum                     print the generated DURUM.md to stdout
  records.py lease --session <ID> [--note TEXT] [--release]
                                       rewrite the Run lock row and write its Record changes line
                                       under a new log entry of its own

Homes (02_memory.md section 3): work items and stages in plan/work/<ID>.md; decisions in
plan/decisions/<ID>.md; the current state in plan/ledger.md section 1. Everything this script
writes is generated from those homes; nothing here is a home. Readiness follows
03_work_model.md section 3 (three-valued: an unresolved reference makes an item not ready).
"""
import argparse
import hashlib
import re
import subprocess
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

import yaml

sys.dont_write_bytecode = True
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
    if not text.startswith("---\n") or "\n---\n" not in text[3:]:
        raise RecordError(f"{path}: no front matter")
    end = text.index("\n---\n", 3)
    meta = yaml.safe_load(text[4:end]) or {}
    return meta, text[end + 5:]


def load_records(root=ROOT):
    ROOT_FOR_ACCEPT[0] = Path(root)
    items, decisions = {}, {}
    for p in sorted((root / "plan/work").glob("*.md")):
        meta, body = split_front(p.read_text(), p)
        if meta.get("id") != p.stem:
            raise RecordError(f"{p}: id '{meta.get('id')}' does not match the file name")
        m = ACC_RE.search(body)
        meta["_acceptance"] = m.group(1) if m else None
        notes = []
        if len(re.findall(r"<!-- note ", body)) != len(NOTE_RE.findall(body)):
            raise RecordError(f"{p}: a note marker does not match the note format")
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
            on = d.get("on", d.get(True, "accepted"))  # YAML 1.1 reads an unquoted `on:` key as True
            out.append({"id": d.get("id"), "on": on, "reason": d.get("reason", "")})
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
    m = re.fullmatch(r"L-(\d+)", str(item.get("rechecked", "L-0")))
    if not m:
        return "unknown", f"malformed rechecked value '{item.get('rechecked')}'"
    since = int(m.group(1))
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

ROOT_FOR_ACCEPT = [ROOT]


def is_accepted(item):
    """Accepted only when `accepted_by` names an existing file (critic of 1b-i, finding 2). Whether that file is
    a bound verdict or deterministic evidence is the work check's job (W-R1, tranche 1b-ii)."""
    if item.get("acceptance") != "accepted":
        return False
    ab = item.get("accepted_by")
    # only evidence counts: a README or a log file cannot lift a gate (N-049, R-W12-3 F-3; tranche 1b-ii)
    return bool(ab) and str(ab).startswith("evidence/") and (ROOT_FOR_ACCEPT[0] / str(ab)).is_file()


def acceptance_unresolved(item):
    return item.get("acceptance") == "accepted" and not is_accepted(item)


def is_closed(item):
    return item.get("admission") == "declined" or item.get("execution") == "cancelled" or is_accepted(item)


def readiness(items, decisions, changes, iid):
    """(True|False|None, reason). Every condition is evaluated; a false one dominates an unknown one
    (Ek B section 1 item 6); None means unknown, which is not ready. The reason shown is the first
    false condition, else the first unknown one."""
    it = items[iid]
    if it.get("kind") != "item":
        return False, f"{it.get('kind')} record"
    false, unknown = [], []
    adm = it.get("admission")
    if adm == "candidate":
        false.append("candidate (not admitted)")
    elif adm == "declined":
        false.append("admission declined")
    elif adm != "admitted":
        unknown.append(f"admission '{adm}' unknown")
    ex = it.get("execution")
    if ex in ("running", "finished", "cancelled"):
        false.append(f"execution {ex}")
    elif ex not in ("planned", "waiting"):
        unknown.append(f"execution '{ex}' unknown")
    q, why = qualification(it, decisions, changes)
    if q == "stale":
        false.append(f"stale: {why}")
    elif q != "current":
        unknown.append(f"{q}: {why}")
    stage = stage_of(items, iid)
    if stage is None:
        unknown.append("no stage ancestor")
    else:
        hold = stage.get("hold_until")
        if hold:
            h = items.get(hold)
            if h is None:
                unknown.append(f"stage hold target {hold} not found")
            elif iid != hold and hold not in [a["id"] for a in ancestors(items, iid)] and not is_accepted(h):
                (unknown if acceptance_unresolved(h) else false).append(
                    f"stage {stage['id']} on hold until {hold} is accepted"
                    + (" (its acceptance names no existing accepted_by file)" if acceptance_unresolved(h) else ""))
        for d in deps(stage):  # a stage's own order applies to every item in it (critic of 1b-i, finding 8)
            t = items.get(d["id"])
            if t is None:
                unknown.append(f"stage {stage['id']} depends on {d['id']}, which is not found")
            elif not is_accepted(t):
                false.append(f"stage {stage['id']} depends on {d['id']} (not accepted)")
    for d in deps(it):
        t = items.get(d["id"])
        if t is None:
            unknown.append(f"depends on {d['id']}, which is not found")
        elif d["on"] == "finished":
            if not d["reason"]:
                unknown.append(f"edge to {d['id']} marked on: finished without a reason")
            elif t.get("execution") != "finished" and not is_accepted(t):
                false.append(f"depends on {d['id']} (on: finished; not finished)")
        elif d["on"] != "accepted":
            unknown.append(f"edge to {d['id']} has an unknown 'on' value")
        elif acceptance_unresolved(t):
            unknown.append(f"depends on {d['id']} (accepted, but accepted_by names no existing file)")
        elif not is_accepted(t):
            false.append(f"depends on {d['id']} (not accepted)")
    for pf in it.get("platform") or []:
        if not isinstance(pf, dict):  # R-W12-3 F-9: unknown, not a crash
            unknown.append(f"platform entry '{pf}' is not a mapping")
            continue
        st = pf.get("status")
        if st != "observed":
            probe = pf.get("probe") or "a probe (to be named)"
            false.append(f"platform fact '{pf.get('fact')}' {st or 'unknown'}: run {probe} first")
    for n in it["_notes"]:
        if n["status"] == "open" and n["blocks"]:
            false.append(f"open blocking note {n['id']}")
    for w in it.get("waits_for") or []:
        d = decisions.get(w)
        if d is None:
            unknown.append(f"waits for {w}, which is not found")
        elif d.get("status") == "open":
            false.append(f"waits for Batu's decision {w}")
    if false:
        return False, false[0]
    if unknown:
        return None, unknown[0]
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
    if acceptance_unresolved(it):
        return "unknown: accepted without an existing accepted_by file"
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
           "Selection among ready items: critical path first, one logged sentence of reason (`plan/builder/design/03_work_model.md` section 3). "
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

    printed = set()

    def walk(iid, depth):
        it = items[iid]
        printed.add(iid)
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
    # an open note stays visible on its item wherever the item sits (M-R3; T-M11; tranche 1b-ii)
    rest = [i for i in sorted(items, key=sortkey) if i not in printed and items[i].get("kind") == "item"
            and any(n["status"] == "open" for n in items[i]["_notes"])]
    if rest:
        lines += ["", "**Items with open notes outside the expanded branch:**", ""]
        lines += [f"- `{i}` {items[i].get('title', '')}: {state_label(items, decisions, changes, i)}{note_tag(items[i])}"
                  for i in rest]
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
    why = {"answered": "the W-C00-12 design answers them, but an answer takes effect only when the tranche that builds "
                       "it merges; checked at W-C00-12's composition review, not closed",
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


def stamp_rendered(text, now=None):
    """Write the Rendered row's As-of from the clock (critic of 1b-i, finding 5): DURUM.md's update line
    comes from here, never from a typed cell."""
    now = (now or datetime.now(timezone.utc)).strftime("%Y-%m-%dT%H:%MZ")
    lines = text.splitlines(keepends=True)
    hits = [n for n, l in enumerate(lines) if l.startswith("| Rendered |")]
    if len(hits) != 1:
        raise RecordError(f"plan/ledger.md: expected one Rendered row, found {len(hits)}")
    lines[hits[0]] = f"| Rendered | Written by `tools/records.py render` from the clock; `DURUM.md`'s update line comes from here. | {now} |\n"
    return "".join(lines)


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
    holder, state, when = lease_state(lock)
    if state == "released":
        run = f"Çalışan oturum yok; son oturum {tr_time(when)} (Türkiye saati) itibarıyla işi bıraktı."
    elif holder and state == "expires":
        run = f"`{holder}`; kilit {tr_time(when)} (Türkiye saati) tarihine kadar geçerli."
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
    asof = rows.get("Rendered", ("", ""))[1].strip()
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
        if not target_sha or not target_sha.strip():
            raise RecordError("a verifier brief needs --target-sha (R-R3a)")
        r = subprocess.run(["git", "rev-parse", "--verify", "-q", f"{target_sha.strip()}^{{commit}}"],
                           capture_output=True, text=True)
        if r.returncode != 0:  # R-W12-3 F-4: the SHA must resolve to a commit
            raise RecordError(f"--target-sha {target_sha.strip()} does not resolve to a commit (R-R3a)")
        target_sha = r.stdout.strip()
        if not failure_classes or any(not f.strip() for f in failure_classes):
            raise RecordError("a verifier brief needs a non-empty --failure-classes list with no blank entry (R-R3a)")
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
    # R-W12-3 F-8: answered notes are answers that take effect only when their tranche builds them
    ans = [(a["id"], n) for a in [it] + ancestors(items, iid) for n in a["_notes"] if n["status"] == "answered"]
    lines += ["Answered notes on this item and its ancestors (the design answers them; the answer takes effect "
              "only when the tranche that builds it merges):"]
    lines += [f"- {n['id']} on {a}: {note_summary(n)[:160]}" for a, n in ans] or ["- none"]
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
    se = state_rows(LEDGER.read_text()).get("Standing exceptions", ("", ""))[0] if LEDGER.exists() else ""
    if se:
        lines += ["Standing exceptions (plan/ledger.md section 1):", "", se, ""]
    lines += ["Frontier (generated):", "", view_frontier(items, decisions, changes), "",
              "Boot order: " + ROLE_FILES["producer"] + ". Take or confirm the lease before any record write."]
    return finish(lines, "run", "producer")


def finish(lines, iid, role):
    text = "\n".join(lines) + "\n"
    h = hashlib.sha256(text.encode()).hexdigest()[:16]
    return text + f"\nTask-Brief: {iid} {role} {h}\n"


# ---------------------------------------------------------------- lease

LEASE_TAIL = re.compile(r"\b(Expires|Released) (\d{4}-\d\d-\d\dT\d\d:\d\dZ)\s*$")


def lease_state(lock):
    """(holder, 'expires'|'released'|None, time) of a Run lock cell, or of the whole row. Only the tail that
    `lease()` writes counts, so a time named inside the note cannot be read as the lease state (N-055)."""
    lock = lock.strip()
    if lock.startswith("| Run lock |"):
        cells = [c.strip() for c in re.split(r"(?<!\\)\|", lock)[1:-1]]
        lock = cells[1] if len(cells) > 1 else ""
    holder = re.match(r"`(session_[A-Za-z0-9]+)`", lock)
    tail = LEASE_TAIL.search(lock)
    return (holder.group(1) if holder else None, tail.group(1).lower() if tail else None,
            tail.group(2) if tail else None)



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
            new = render_ledger(text if a.check else stamp_rendered(text), items, decisions, changes)
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
            sa = state_rows(new).get("summary_tr", ("", ""))[1].strip()
            try:
                age = datetime.now(timezone.utc) - datetime.strptime(sa, "%Y-%m-%dT%H:%MZ").replace(tzinfo=timezone.utc)
                if age > timedelta(minutes=15):
                    print(f"note: summary_tr was last written at {sa}; update it if the state changed")
            except ValueError:
                print("note: summary_tr has no readable As-of time")
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
            lock = state_rows(text).get("Run lock", ("", ""))[0]
            held = re.search(r"`(session_[A-Za-z0-9]+)`", lock)
            exp = re.search(r"Expires (\d{4}-\d\d-\d\dT\d\d:\d\dZ)", lock)
            if held and held.group(1) != a.session and exp and datetime.strptime(exp.group(1), "%Y-%m-%dT%H:%MZ").replace(
                    tzinfo=timezone.utc) > datetime.now(timezone.utc):
                print(f"WARNING: overwriting the unexpired lease of {held.group(1)} (expires {exp.group(1)}); "
                      "this is allowed only for a hand-over from your parent run (operating model section 2.2)")
            new, line = lease(text, a.session, a.note, a.release)
            new = render_ledger(stamp_rendered(new), items, decisions, changes)
            LEDGER.write_text(new)
            DURUM.write_text(durum(new, items, decisions, changes))
            logs = sorted(LOGDIR.glob("*-log.md"))
            if logs:  # the row and its Record changes line are written together (02 section 7, K2 walk-through),
                # under an entry of their own, so that the line is not attributed to the previous entry (R-W12-4 m-6)
                nums = [int(n) for f in logs for n in re.findall(r"(?m)^### L-(\d+) ", f.read_text())]
                eid = f"L-{(max(nums) if nums else 0) + 1:03d}"
                what = "released" if a.release else "taken or renewed"
                lt = logs[-1].read_text()
                logs[-1].write_text(lt + ("" if lt.endswith("\n") else "\n") +
                                    f"\n### {eid} · {datetime.now(timezone.utc):%Y-%m-%d} · Lease {what} by "
                                    f"`{a.session}`\n\n- **Record changes:** {line}\n")
                print(f"{line} (written as {eid} in {logs[-1]})")
            else:
                print(line)
    except (RecordError, OSError, ValueError, yaml.YAMLError) as e:
        print(f"records.py: {e}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
