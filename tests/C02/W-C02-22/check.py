#!/usr/bin/env python3
"""W-C02-22 (SB-COR PR-A1, the text roots): the acceptance checks of plan/work/W-C02-22.md.

Usage (from anywhere; every file is read with `git show <rev>:<path>`, never from a working tree):
  python3 -I tests/C02/W-C02-22/check.py --repo <full clone> --base aa6d144 --head <rev> [--only protected]

Families: P = protected texts (plan text, the decision summary, Batu's words, the protected working-order
passages, Batu labels; plan step 4.2 re-runs these alone with --only protected); U = left unchanged by PR-A1;
A = what PR-A1 adds; K = over-blocking controls (the head's own tools must accept the new forms).

Output: one line per check, `CHECK <id> <family> PASS|FAIL <detail>`, then
`CHECKS run=<n> pass=<p> fail=<f> expected=<N>` and `W22_CHECK PASS` (exit 0) only when every check passed and
n equals the pinned count; otherwise `W22_CHECK FAIL` (exit 1). A shallow clone, an unknown revision, a base that
is not an ancestor of the head, or a base anchor that is missing ends in `W22_CHECK COULD NOT CHECK` (exit 2):
never green. An error inside a check is that check's FAIL.
"""
import argparse
import difflib
import os
import re
import subprocess
import sys
import tempfile


sys.dont_write_bytecode = True

EXPECTED = {"all": 41, "protected": 5}
ROLES = ["producer", "researcher", "prober", "checker", "test-designer"]
NONCHECKER = ["producer", "researcher", "prober", "test-designer"]
AG = ".claude/agents/{}.md"
WO, EKD, CL = "plan/Installation_Working_Order.md", "plan/Ek_D_Dusunme_Protokolleri.md", "CLAUDE.md"
PC53, ITEM = "plan/decisions/PC-53.md", "plan/work/W-C02-22.md"
EV026 = "evidence/C02/EV-C02-026_pra1_triage.md"
SUMMARIES = ["briefs/conversation/KARAR_OZETI_2026-10-05_TR.md",
             "briefs/conversation/DECISION_SUMMARY_2026-10-05_EN.md"]
FLOOR_OLD_HEAD = "## 2. Common floor (every role, every work item)"
FLOOR_NEW_HEAD = "## Common floor (Ek D section 2; every role, every work item)"
FLOOR_SUBS = [("section 7", "Ek D section 2 section 7 (D-033)", 2)]   # (old, new, expected count) after the heading
BATU_LABEL = re.compile(r"\[Batu(?: kararı|['’]s decision|,|\])")
# The protected working-order passages (approach (3); working order sections 1, 2, 3, 7, 8). kind :: prefix of
# exactly one line at the base. wo-section: that "## " heading to the next; wo-para: to the next blank line.
FIXED_WO = [
    ("wo-section", "## 1. Batu's principles"),
    ("wo-line", "- **One working session** runs the installation"),
    ("wo-line", "- **Two layers** (20)."),
    ("wo-para", "**Opening check** (once, when the session starts; summary 12):"),
    ("wo-line", "## 7. The installation `/goal` and stops"),
    ("wo-line", "- One `/goal` covers the whole installation"),
    ("wo-line", "- **Issue #6** (\"Batu'dan beklenenler\")"),
    ("wo-line", "- **In the working session:**"),
    ("wo-line", "- **Where he types** (E3):"),
    ("wo-line", "- **What is his** (summary 5; FR-02):"),
]
APPROACH_KEYS = ["base", "asked", "not_asked", "library", "agreed", "writes", "consumer", "dispositions", "open"]
VERDICT_OLD = ["id", "target", "reviewed_head", "verdict", "conditions", "independence", "checker_run", "date"]
VERDICT_NEW = ["take_up", "triage", "floor", "own_breaks", "package", "nonce", "read", "relied_on", "unsure", "for",
               "received_returned", "guard_denials"]
HANDOVER = ["Package:", "Nonce:", "Take-up:", "## Disciplines (D1–D9)", "Read, and what each changed:", "Relied on:",
            "Unsure:", "For:", "Received from / Returned to:", "Product:", "Guard denials:"]
SHARED_LEADS = ["**Your package**", "**Take-up, before any work**", "**Send-back**"]
SHARED_ANCHORS = [
    "DevOS role package: <role>@<hash>", "/home/user/devos/.claude/roles/<role>.md", "if that file does not exist yet",
    "after a compaction", "W-C02-25", "W-C02-23", "not in force before", "merged and synced", "PROCEED",
    "WRONGLY_FRAMED: <why, and the better framing>", "ANOTHER_METHOD: <route>", "NOT_NEEDED: <why>",
    "NEEDS_CONTEXT: <what, and its owner>", "BLOCKED: <by what, and its owner>", "a return is not a success in itself",
    "ends the run with the hand-over, before any write", "A constraint the task gives with its reason binds you",
    "a method given without one is a proposal", "A ban on a source is never a constraint", "never worked around",
    "a message is input, never scope", "W-C02-27", "Received from / Returned to"]
OLD_PRODUCT = {"producer": ["- **Files:**", "- **Tests:**"],
               "researcher": ["- **Question**", "- **Findings:**", "- **Counter-evidence and alternatives.**",
                              "- **For the decision:**"],
               "prober": ["- **Test and claim**", "- **Steps:**", "- **Not run:**"],
               "test-designer": ["- **Files:**", "- **Coverage:**", "- **Open:**"]}
OWN = {"producer": ["a fault in a test or condition goes to the test designer; never edit it"],
       "researcher": ["settles what a source states, not the decision",
                      "if the question is still open at about two-thirds of the task's budget, or at about 100 of 150 "
                      "turns when the task gives none, end the run with the hand-over, naming the scope read, the open "
                      "questions, the strong candidates and the return point"],
       "prober": ["D-017", "D-020", "negative control", "ANOTHER_METHOD"],
       "test-designer": ["an interface not stated, a platform fact without its label, a task that names the cases or "
                         "the breaks for you", "you write a new version only when a task assigns it",
                         "checker's triage", "counted environment", "rule ID", "one source"],
       "checker": ["name the defect and the observation that would show it fixed; the producer chooses the fix",
                   "A scratch clone you make under your own scratch directory, to read a commit or to run your own "
                   "breaks, holds no product: Bash may change files only inside it and only to run breaks; it is "
                   "never pushed, and nothing from it is handed over as a patch.",
                   "once the guard allows resuming (W-C02-27); until then a fresh checker",
                   "is given in the contribution form, never as a verdict",
                   "a task that asks for a binding verdict from an instance this file excludes is", "floor:"]}
DESC_TRIGGER = {"producer": "approach", "researcher": "before", "prober": "interpreter", "checker": "triage",
                "test-designer": "start"}
BAN_SENTENCES = {"checker": ("- You never fix.", ["You never fix. Create, edit or delete no file;",
                                                  "Use Bash only for commands that read and for running tests."]),
                 "test-designer": ("- Never change a condition or a test after a result",
                                   ["Never change a condition or a test after a result of the item it judges has "
                                    "been seen (ledger rule 3; Appendix G G8 item 3)."])}
SPLIT_WORDS = ["loosen", "tighten", "stronger"]
CLOSURES = ["diff-confirmed", "scoped re-review", "full fresh check"]
TYPES = ["defect", "missing evidence", "preference", "scope conflict"]
BLOCKS = ["producer task", "merge", "acceptance"]
TEMPLATE_FIELDS = ["Item: plan/work/W-", "Purpose", "Acceptance", "Consumer", "Inputs", "Teammates:", "Output",
                   "Writer or reader", "Limits", "Constraints", "Your take-up and returns: see your role file"]
READING = {"2": ["D-039", "18:24Z", "D8 item 3", "6.12 item 5", "[Proposal]", "0.7"],
           "all": ["settles what a source states, not the decision", "is a minimum", "presence only",
                   "never sent again unchanged", "no single score"]}
PC53_WORDS = ["D-016", "D-031", "PC-52", "0.3", "0.5", "0.6", "0.7", "5.3", "7.2", ".claude/roles/", "session_brief",
              "C05", "EV-C02-021", "EXP-001", "13.3", "U03 F22", "S1-03", "summary 18", "6.12 item 1", "D-039",
              "D-041", "triage", "loop limit", "new session", "on: finished", "producer.md", "researcher.md",
              "prober.md", "checker.md", "test-designer.md", "CLAUDE.md"]
NOT_IN_FORCE_TRIG = re.compile(r"\bT5\b|\bT6\b|registry|start hook|stop hook|SubagentStart|SubagentStop|resum", re.I)
COND_LINE = re.compile(r"^C<n> · type: [^·]+ · blocks: [^·]+ · closure: [^·]+ · \S")
LEAD = r"^[\s>*`-]*"


class CouldNot(Exception):
    pass


class Repo:
    def __init__(self, path):
        self.path = path

    def git(self, *args, ok=False, data=False):
        r = subprocess.run(["git", "-C", self.path, *args], capture_output=True)
        if r.returncode:
            if ok:
                return None
            raise CouldNot(f"git {' '.join(args)[:120]}: {r.stderr.decode(errors='replace').strip()[:200]}")
        return r.stdout if data else r.stdout.decode("utf-8")

    def blob(self, rev, path):
        """The bytes of path at rev, or None when it is absent there."""
        if self.git("cat-file", "-e", f"{rev}:{path}", ok=True) is None:
            return None
        return self.git("show", f"{rev}:{path}", data=True)

    def text(self, rev, path):
        b = self.blob(rev, path)
        return None if b is None else b.decode("utf-8")


# ---------------------------------------------------------------- text helpers

def lines_of(t):
    return t.split("\n")[:-1] if t.endswith("\n") else t.split("\n")


def unfenced(lines):
    """Indexes of lines outside ``` fences."""
    out, fence = [], False
    for i, line in enumerate(lines):
        if line.startswith("```"):
            fence = not fence
            continue
        if not fence:
            out.append(i)
    return out


def headings(lines):
    """Indexes of '## ' section headings outside fences ('## Disciplines' lines are hand-over labels, not sections)."""
    return [i for i in unfenced(lines) if lines[i].startswith("## ") and not lines[i].startswith("## Disciplines")]


def section(lines, prefix, to_end=False):
    """(start, end) of the '## ' section whose heading starts with prefix; None when absent or not unique."""
    hs = headings(lines)
    found = [i for i in hs if lines[i].startswith(prefix)]
    if len(found) != 1:
        return None
    s = found[0]
    e = len(lines) if to_end else next((i for i in hs if i > s), len(lines))
    return s, e


def sec_lines(lines, prefix, strip=True, to_end=False):
    r = section(lines, prefix, to_end)
    if r is None:
        return None
    out = lines[r[0]:r[1]]
    while strip and out and not out[-1].strip():
        out.pop()
    return out


def wo_section(lines, n):
    return sec_lines(lines, f"## {n}. ")


def front_lines(t):
    if not t.startswith("---\n") or "\n---\n" not in t[3:]:
        return None
    return t[4:t.index("\n---\n", 3)].split("\n")


def sentences(t):
    out = []
    for line in t.split("\n"):
        out += [s.strip() for s in re.split(r"(?<=\.)\s+(?=[A-Z(`*\[])", line) if s.strip()]
    return out


def collapse(t):
    return " ".join(t.split())


def cells(row):
    """Cells of a Markdown table row; a '|' inside backticks does not split."""
    out, cur, tick = [], "", False
    body = row.strip()
    body = body[1:] if body.startswith("|") else body
    body = body[:-1] if body.endswith("|") else body
    for ch in body:
        if ch == "`":
            tick = not tick
        if ch == "|" and not tick:
            out.append(cur.strip())
            cur = ""
        else:
            cur += ch
    out.append(cur.strip())
    return out


def resolve_wo(base_lines, kind, prefix):
    """The base passage (list of lines) for a protected entry; CouldNot when the prefix is not on exactly one line."""
    hits = [i for i, line in enumerate(base_lines) if line.startswith(prefix)]
    if len(hits) != 1:
        raise CouldNot(f"protected prefix {prefix[:50]!r} is on {len(hits)} base lines, not one")
    i = hits[0]
    if kind == "wo-line":
        return i, base_lines[i:i + 1]
    if kind == "wo-section":
        hs = headings(base_lines)
        e = next((h for h in hs if h > i), len(base_lines))
        out = base_lines[i:e]
    else:
        e = next((j for j in range(i, len(base_lines)) if not base_lines[j].strip()), len(base_lines))
        out = base_lines[i:e]
    while out and not out[-1].strip():
        out.pop()
    return i, out


def answer_raw(t):
    """The raw front-matter lines of answer_original_tr (None when the key is absent), and the class value."""
    fl = front_lines(t) or []
    raw, cls, grab = None, None, False
    for line in fl:
        if re.match(r"[a-z_]+:", line):
            grab = False
            if line.startswith("class:"):
                cls = line.split(":", 1)[1].strip()
            if line.startswith("answer_original_tr:"):
                raw, grab = [line], True
                continue
        if grab:
            raw.append(line)
    return ("\n".join(raw) if raw is not None else None), cls


def approach_parse(lines):
    """(keys, problem) for the lines between whole-line <!-- approach --> markers."""
    try:
        s = lines.index("<!-- approach -->")
        e = lines.index("<!-- /approach -->", s)
    except ValueError:
        return None, "no whole-line <!-- approach --> ... <!-- /approach --> markers"
    keys = []
    for line in lines[s + 1:e]:
        if not line.strip():
            continue
        m = re.match(r"([a-z_]+): (\S.*)$", line)
        if not m:
            return None, f"a line in the block is not `key: value`: {line[:40]!r}"
        keys.append(m.group(1))
    if keys != APPROACH_KEYS:
        return keys, f"keys {keys} are not {APPROACH_KEYS}"
    return keys, None


def fenced_after(lines, lead):
    """The lines of the first ``` fence after the first line starting with lead, else None."""
    i = next((k for k, line in enumerate(lines) if line.startswith(lead)), None)
    if i is None:
        return None
    s = next((k for k in range(i + 1, len(lines)) if lines[k].startswith("```")), None)
    if s is None:
        return None
    e = next((k for k in range(s + 1, len(lines)) if lines[k].startswith("```")), None)
    return None if e is None else lines[s + 1:e]


def verdict_template(lines):
    """(front-matter lines, all template lines) of the first fenced block whose first line is '---'."""
    fence, start = False, None
    for i, line in enumerate(lines):
        if line.startswith("```"):
            if not fence and i + 1 < len(lines) and lines[i + 1] == "---":
                start = i + 1
            elif fence and start is not None:
                body = lines[start:i]
                end = body.index("---", 1) if "---" in body[1:] else None
                return (body[1:end] if end else None), body
            fence = not fence
    return None, None


# ---------------------------------------------------------------- the checks

class Checks:
    def __init__(self, repo, base, head, tmp):
        self.r, self.base, self.head, self.tmp = repo, base, head, tmp
        self.cache = {}
        self.bwo = self.need(base, WO)
        self.bwo_l = lines_of(self.bwo)
        self.floor = self.floor_block()

    def need(self, rev, path):
        t = self.r.text(rev, path)
        if t is None and rev == self.base:
            raise CouldNot(f"{path} is missing at the base")
        return t

    def at(self, rev, path):
        k = (rev, path)
        if k not in self.cache:
            self.cache[k] = self.r.text(rev, path)
        return self.cache[k]

    def floor_block(self):
        lines = lines_of(self.need(self.base, EKD))
        hits = [i for i, line in enumerate(lines) if line == FLOOR_OLD_HEAD]
        if len(hits) != 1 or hits[0] != 48:
            raise CouldNot(f"Ek D floor heading is not exactly once at line 49 (found {[h + 1 for h in hits]})")
        e = next((i for i in range(hits[0] + 1, len(lines)) if lines[i].startswith("## 3.")), None)
        if e is None:
            raise CouldNot("Ek D: no '## 3.' heading after the floor")
        block = lines[hits[0]:e]
        while block and not block[-1].strip():
            block.pop()
        if block != lines[48:67]:
            raise CouldNot("Ek D floor extraction is not lines 49 to 67")
        out = [FLOOR_NEW_HEAD]
        rest = "\n".join(block[1:])
        for old, new, n in FLOOR_SUBS:
            if rest.count(old) != n:
                raise CouldNot(f"Ek D floor: {old!r} occurs {rest.count(old)} times, not {n}")
            rest = rest.replace(old, new)
        return out + rest.split("\n")

    # ---------------- P: protected

    def p_plan(self):
        out = self.r.git("diff", "--name-status", self.base, self.head, "--", "plan/DevOS_Kurulum_Plani.md",
                         "plan/Ek_*.md")
        return (not out.strip()), (out.strip().replace("\n", "; ") or "no change in the plan or its appendices")

    def p_summary(self):
        bad = []
        for p in SUMMARIES:
            b = self.r.blob(self.base, p)
            if b is None:
                raise CouldNot(f"{p} missing at the base")
            if self.r.blob(self.head, p) != b:
                bad.append(p)
        return not bad, ("changed or missing: " + ", ".join(bad)) if bad else "both summary files byte-identical"

    def batu_records(self):
        names = set()
        for rev in (self.base, self.head):
            out = self.r.git("ls-tree", "--name-only", f"{rev}:plan/decisions")
            names |= {n for n in out.split("\n") if n.endswith(".md")}
        recs = []
        for n in sorted(names):
            p = f"plan/decisions/{n}"
            bt, ht = self.at(self.base, p), self.at(self.head, p)
            bcls = answer_raw(bt)[1] if bt else None
            hcls = answer_raw(ht)[1] if ht else None
            if bcls == "batu" or hcls == "batu":
                recs.append((p, bt, ht, bcls, hcls))
        return recs

    def p_batu(self):
        bad, n, compared = [], 0, 0
        for p, bt, ht, bcls, hcls in self.batu_records():
            n += 1
            if ht is None:
                bad.append(f"{p} removed")
                continue
            if bcls == "batu" and hcls != "batu":
                bad.append(f"{p} class {hcls!r}")
                continue
            hraw = answer_raw(ht)[0]
            braw = answer_raw(bt)[0] if bt else None
            if braw is None:   # added, or answered, after the base: its first form on the head's first-parent line
                revs = self.r.git("rev-list", "--first-parent", "--reverse", self.head, "--", p).split()
                for c in revs:
                    t = self.r.text(c, p)
                    if t is not None and answer_raw(t)[0] is not None:
                        braw = answer_raw(t)[0]
                        break
            if braw is None:
                if hraw is not None:
                    bad.append(f"{p} answer without a first form")
                continue
            compared += 1
            if hraw != braw:
                bad.append(f"{p} answer_original_tr differs")
        return not bad, "; ".join(bad) if bad else f"{n} class batu records, {compared} answers byte-identical"

    def p_wo_passages(self):
        hwo = self.at(self.head, WO)
        if hwo is None:
            return False, "working order missing at the head"
        bad = []
        for kind, prefix in FIXED_WO:
            _, passage = resolve_wo(self.bwo_l, kind, prefix)
            c = hwo.count("\n".join(passage))
            if c != 1:
                bad.append(f"{prefix[:30]!r} found {c} times")
        return not bad, "; ".join(bad) if bad else f"{len(FIXED_WO)} passages each exactly once"

    def p_label(self):
        bad = []
        hcl = self.at(self.head, CL)
        if hcl is None:
            return False, "CLAUDE.md missing at the head"
        hl = lines_of(hcl)
        fl = len(self.floor)
        mask = set()
        for i in range(len(hl) - fl + 1):
            if hl[i:i + fl] == self.floor:
                mask |= set(range(i, i + fl))
        hc = sum(len(BATU_LABEL.findall(x)) for i, x in enumerate(hl) if i not in mask)
        bc = len(BATU_LABEL.findall(self.need(self.base, CL)))
        if hc != bc:
            bad.append(f"CLAUDE.md outside the floor: {hc} Batu labels, base {bc}")
        for role in ROLES:
            ht = self.at(self.head, AG.format(role)) or ""
            b, h = len(BATU_LABEL.findall(self.need(self.base, AG.format(role)))), len(BATU_LABEL.findall(ht))
            if h != b:
                bad.append(f"{role}.md: {h} Batu labels, base {b}")
        hwo = self.at(self.head, WO) or ""
        for path, bt in ((WO, self.bwo), (CL, self.need(self.base, CL))):
            ht = hwo if path == WO else hcl
            for line in lines_of(bt):
                if BATU_LABEL.search(line) and line not in set(lines_of(ht)):
                    bad.append(f"{path}: a Batu-labelled base line changed")
        bsent = set(sentences(self.bwo))
        for s in sentences(hwo):
            if s not in bsent and BATU_LABEL.search(s) and re.search(r"PC-53|team's rule|team’s rule", s):
                bad.append("working order: a new sentence labels a PC-53 or team rule as Batu's")
        return not bad, "; ".join(bad) if bad else "no Batu label added or changed"

    # ---------------- U: unchanged by PR-A1

    def u_cl_old(self):
        bl = lines_of(self.need(self.base, CL))
        if len(bl) != 16:
            raise CouldNot(f"CLAUDE.md has {len(bl)} lines at the base, not 16")
        hl = lines_of(self.at(self.head, CL) or "")
        return hl[:16] == bl, "the 16 base lines are the head's first 16 lines" if hl[:16] == bl else \
            "the head does not start with the 16 base lines byte for byte"

    def u_rf_fm(self):
        import yaml
        bad = []
        for role in ROLES:
            bt, ht = self.need(self.base, AG.format(role)), self.at(self.head, AG.format(role))
            if ht is None:
                bad.append(f"{role}.md missing")
                continue
            bf, hf = front_lines(bt), front_lines(ht)
            if hf is None:
                bad.append(f"{role}.md: no front matter")
                continue
            bo = [x for x in bf if not x.startswith("description:")]
            ho = [x for x in hf if not x.startswith("description:")]
            if bo != ho or sum(x.startswith("description:") for x in hf) != 1:
                bad.append(f"{role}.md: front-matter lines other than one description line differ")
                continue
            by, hy = yaml.safe_load("\n".join(bf)), yaml.safe_load("\n".join(hf))
            if not isinstance(hy, dict) or set(hy) != set(by) or \
                    any(hy[k] != by[k] for k in by if k != "description"):
                bad.append(f"{role}.md: parsed keys or values differ")
        return not bad, "; ".join(bad) if bad else "front matter unchanged but description in all five (tools too)"

    def u_rf_cd(self):
        p = AG.format("counter-designer")
        b = self.r.blob(self.base, p)
        if b is None:
            raise CouldNot(f"{p} missing at the base")
        ok = self.r.blob(self.head, p) == b
        return ok, "counter-designer.md byte-identical" if ok else "counter-designer.md changed or missing"

    def base_role_lines(self, role):
        return lines_of(self.need(self.base, AG.format(role)))

    def head_role_lines(self, role):
        t = self.at(self.head, AG.format(role))
        return None if t is None else lines_of(t)

    def u_rf_success(self):
        bad = []
        for role in ROLES:
            b = [x for x in self.base_role_lines(role) if x.startswith("**Success direction:**")]
            if len(b) != 1:
                raise CouldNot(f"{role}.md: no single success-direction line at the base")
            h = self.head_role_lines(role) or []
            if h.count(b[0]) != 1:
                bad.append(role)
        return not bad, ("changed: " + ", ".join(bad)) if bad else "five success-direction lines verbatim"

    def u_rf_bans(self):
        bad = []
        for role in ROLES:
            b = sec_lines(self.base_role_lines(role), "## Bans")
            if b is None:
                raise CouldNot(f"{role}.md: no Bans section at the base")
            h = sec_lines(self.head_role_lines(role) or [], "## Bans")
            if h is None:
                bad.append(f"{role}: no Bans section")
                continue
            htext = "\n".join(h)
            exc = BAN_SENTENCES.get(role)
            for line in b:
                if not line.startswith("- "):
                    continue
                if exc and line.startswith(exc[0]):
                    for s in exc[1]:
                        if s not in htext:
                            bad.append(f"{role}: sentence {s[:30]!r} missing")
                elif line not in h:
                    bad.append(f"{role}: ban {line[:40]!r} not verbatim")
        return not bad, "; ".join(bad) if bad else "every base ban line verbatim (named sentences for two lines)"

    def same_section(self, prefix):
        bad = []
        for role in ROLES:
            b = sec_lines(self.base_role_lines(role), prefix)
            if b is None:
                raise CouldNot(f"{role}.md: no {prefix!r} section at the base")
            h = sec_lines(self.head_role_lines(role) or [], prefix)
            if h != b:
                bad.append(role)
        return not bad, ("changed: " + ", ".join(bad)) if bad else f"{prefix!r} sections byte-identical in five files"

    def u_rf_map(self):
        return self.same_section("## Knowledge map")

    def u_rf_d016(self):
        return self.same_section("## Thinking disciplines (D-016)")

    def u_wo_step2(self):
        b = [x for x in self.bwo_l if x.startswith("2. **Acceptance before results.**")]
        if len(b) != 1:
            raise CouldNot("working order step 2 not found once at the base")
        h = lines_of(self.at(self.head, WO) or "")
        return h.count(b[0]) == 1, "old step 2 verbatim" if h.count(b[0]) == 1 else "old step 2 changed or missing"

    def quote_raw(self, lines):
        s = section(lines, "## 9. ")
        if s is None:
            return None
        i = next((k for k in range(s[0], s[1]) if lines[k].startswith("**Discipline block**")), None)
        if i is None:
            return None
        j = next((k for k in range(i, s[1]) if lines[k].startswith(">")), None)
        out = []
        while j is not None and j < s[1] and lines[j].startswith(">"):
            out.append(lines[j])
            j += 1
        return out

    def run_tool(self, rev, code, files, cwd=None):
        """Run python code with the head's tools importable (tools/ and plan/ copied from rev into a temp tree)."""
        d = tempfile.mkdtemp(dir=self.tmp)
        for p in files:
            b = self.r.blob(rev, p)
            if b is None:
                raise CouldNot(f"{p} missing at {rev}")
            os.makedirs(os.path.join(d, os.path.dirname(p)), exist_ok=True)
            with open(os.path.join(d, p), "wb") as f:
                f.write(b)
        prog = f"import sys; sys.dont_write_bytecode = True; sys.path.insert(0, {os.path.join(d, 'tools')!r})\n" + code
        r = subprocess.run([sys.executable, "-I", "-c", prog], capture_output=True, text=True, cwd=cwd or d)
        return r.returncode, r.stdout, r.stderr

    def u_wo_taskblock(self):
        bq, hq = self.quote_raw(self.bwo_l), self.quote_raw(lines_of(self.at(self.head, WO) or ""))
        if not bq:
            raise CouldNot("no discipline block quotation at the base")
        if bq != hq:
            return False, "the discipline block's raw quotation differs"
        code = "import subagent_audit as s\nprint(s.task_block())"
        rc1, o1, e1 = self.run_tool(self.head, code, ["tools/subagent_audit.py", WO])
        # the base working order read by the head's tool
        dd = tempfile.mkdtemp(dir=self.tmp)
        for p, rev in (("tools/subagent_audit.py", self.head), (WO, self.base)):
            os.makedirs(os.path.join(dd, os.path.dirname(p)), exist_ok=True)
            with open(os.path.join(dd, p), "wb") as f:
                f.write(self.r.blob(rev, p))
        prog = f"import sys; sys.dont_write_bytecode = True; sys.path.insert(0, {os.path.join(dd, 'tools')!r})\n" + code
        r = subprocess.run([sys.executable, "-I", "-c", prog], capture_output=True, text=True, cwd=dd)
        if rc1 or r.returncode:
            return False, f"task_block() failed: {(e1 or r.stderr).strip()[-160:]}"
        return o1 == r.stdout, "task_block() equal at base and head" if o1 == r.stdout else "task_block() differs"

    def u_wo_untouched(self):
        h = lines_of(self.at(self.head, WO) or "")
        bad = []
        bi = headings(self.bwo_l)[0]
        hi = headings(h)[0] if headings(h) else 0
        if self.bwo_l[:bi] != h[:hi]:
            bad.append("intro")
        for n in (5, 7, 8, 10):
            b = wo_section(self.bwo_l, n)
            if b is None:
                raise CouldNot(f"working order section {n} not found at the base")
            if wo_section(h, n) != b:
                bad.append(f"section {n}")
        return not bad, ("changed: " + ", ".join(bad)) if bad else "intro and sections 5, 7, 8, 10 byte-identical"

    # ---------------- A: added by PR-A1

    def head_cl(self):
        return lines_of(self.at(self.head, CL) or "")

    def floor_at(self, hl):
        fl = len(self.floor)
        return [i for i in range(len(hl) - fl + 1) if hl[i:i + fl] == self.floor]

    def a_cl_floor(self):
        at = self.floor_at(self.head_cl())
        return len(at) == 1 and at[0] >= 16, f"substituted floor block found {len(at)} times" + \
            (f" at line {at[0] + 1}" if at else "")

    def a_cl_closed(self):
        hl = self.head_cl()
        at = self.floor_at(hl)
        if len(at) != 1 or hl[:16] != lines_of(self.need(self.base, CL)):
            return False, "no single floor block after the 16 base lines"
        rest = [x for i, x in enumerate(hl) if i >= 16 and not (at[0] <= i < at[0] + len(self.floor)) and x.strip()]
        if len(rest) != 3:
            return False, f"{len(rest)} added lines besides the floor, three needed"
        d39 = [x for x in rest if "D-039" in x]
        pc = [x for x in rest if "PC-53" in x]
        bad = []
        if len(d39) != 2 or len(pc) != 1 or pc[0] in d39:
            bad.append("not two D-039 lines and one PC-53 line")
        if pc:
            for alt in (r"wrongly framed|WRONGLY_FRAMED", r"another method|ANOTHER_METHOD", r"not needed|NOT_NEEDED"):
                if not re.search(alt, pc[0], re.I):
                    bad.append(f"PC-53 line lacks {alt.split('|')[0]!r}")
        if any(BATU_LABEL.search(x) for x in rest):
            bad.append("a Batu label on an added line")
        if not any(re.search("library", x, re.I) and re.search("web", x, re.I) for x in d39):
            bad.append("no D-039 line names the library, then the web")
        if not any("alone" in x for x in d39):
            bad.append("no D-039 line says the executor does not decide alone")
        return not bad, "; ".join(bad) if bad else "floor plus exactly three lines (two D-039, one PC-53)"

    def a_rf_desc(self):
        import yaml
        bad = []
        for role in ROLES:
            bd = yaml.safe_load("\n".join(front_lines(self.need(self.base, AG.format(role)))))["description"]
            ht = self.at(self.head, AG.format(role))
            hy = yaml.safe_load("\n".join(front_lines(ht) or [])) if ht else None
            hd = (hy or {}).get("description", "") if isinstance(hy, dict) else ""
            first = bd.split(". ")[0] + "."
            if hd == bd or not hd.startswith(first) or DESC_TRIGGER[role] not in hd[len(first):]:
                bad.append(role)
        return not bad, ("not changed as pinned: " + ", ".join(bad)) if bad else "five descriptions carry triggers"

    def shared_block(self, role):
        lines = self.head_role_lines(role)
        if lines is None:
            return None, "file missing"
        s = section(lines, "## Procedure")
        if s is None:
            return None, "no single Procedure section"
        idx = []
        start = s[0]
        for lead in SHARED_LEADS:
            k = next((i for i in range(start, s[1]) if lines[i].startswith(lead)), None)
            if k is None:
                return None, f"no line starting {lead}"
            idx.append(k)
            start = k + 1
        end = next((i for i in range(idx[2], s[1]) if not lines[i].strip()), s[1])
        step = next((i for i in range(s[0], s[1]) if re.match(r"\d+\. ", lines[i])), None)
        if step is not None and step < end:
            return None, "a numbered step comes before the end of the shared block"
        block = "\n".join(lines[idx[0]:end])
        if "<role>" in block:
            return None, "a literal <role> is left"
        norm, n1 = re.subn(re.escape(role) + "@", "<role>@", block)
        norm, n2 = re.subn(r"roles/" + re.escape(role) + r"\.md", "roles/<role>.md", norm)
        if n1 + n2 != 2:
            return None, f"{n1 + n2} role slots, two expected"
        return norm, None

    def a_rf_shared(self):
        blocks, bad = {}, []
        for role in ROLES:
            b, why = self.shared_block(role)
            if why:
                bad.append(f"{role}: {why}")
            else:
                blocks[role] = b
        if blocks:
            ref = blocks[ROLES[0]] if ROLES[0] in blocks else next(iter(blocks.values()))
            for role, b in blocks.items():
                if b != ref:
                    bad.append(f"{role}: differs from producer's")
            for a in SHARED_ANCHORS:
                if a not in ref:
                    bad.append(f"anchor {a!r} missing")
        return not bad, "; ".join(bad[:6]) if bad else "one shared block in five files, all anchors present"

    def handover(self, role):
        lines = self.head_role_lines(role)
        if lines is None:
            return None, "file missing"
        s = section(lines, "## Output", to_end=True)
        if s is None:
            return None, "no single Output section"
        free = [i for i in unfenced(lines) if s[0] < i < s[1]]
        pos, start = [], s[0]
        for lab in HANDOVER:
            k = next((i for i in free if i > start and re.match(LEAD + re.escape(lab), lines[i])), None)
            if k is None:
                return None, f"no {lab!r} line in order"
            pos.append(k)
            start = k
        rng = list(range(pos[0], pos[-1] + 1))
        if any(re.match(LEAD + "## ", lines[i]) for i in rng if i != pos[3]):
            return None, "another '## ' line in the hand-over"
        product = lines[pos[9]:pos[10]]
        shared = lines[pos[0]:pos[9]] + [lines[pos[10]]]
        text = "\n".join(shared)
        if "<role>" in text:
            return None, "a literal <role> is left"
        norm, n = re.subn(re.escape(role) + "@", "<role>@", text)
        if n != 1:
            return None, f"{n} role slots, one expected"
        return (norm, "\n".join(product)), None

    def a_rf_handover(self):
        bad, got = [], {}
        disc = None
        for line in self.base_role_lines("producer"):
            if "a block headed" in line:
                disc = line[line.index("a block headed"):]
        if not disc or not disc.endswith("A final message without it is not accepted."):
            raise CouldNot("the base disciplines sentence was not found in producer.md")
        for role in ROLES:
            h, why = self.handover(role)
            if why:
                bad.append(f"{role}: {why}")
                continue
            got[role] = h
        if got:
            ref = got.get("producer", next(iter(got.values())))[0]
            for role, (sh, prod) in got.items():
                if sh != ref:
                    bad.append(f"{role}: shared range differs")
            if disc not in ref:
                bad.append("the disciplines sentence is not verbatim in the hand-over")
            for role in NONCHECKER:
                if role not in got:
                    continue
                bl = self.base_role_lines(role)
                for lead in OLD_PRODUCT[role]:
                    b = [x for x in bl if x.startswith(lead)]
                    if len(b) != 1:
                        raise CouldNot(f"{role}.md: old output item {lead!r} not found once at the base")
                    if b[0][2:].rstrip(".") not in got[role][1]:
                        bad.append(f"{role}: old item {lead!r} not verbatim in Product")
        return not bad, "; ".join(bad[:6]) if bad else "hand-over order and shared range identical in five files"

    def a_rf_own(self):
        bad = []
        for role, needles in OWN.items():
            t = self.at(self.head, AG.format(role)) or ""
            for n in needles:
                if n not in t:
                    bad.append(f"{role}: {n[:40]!r}")
            if role == "checker" and "describe a fix in words" in t:
                bad.append("checker: 'describe a fix in words' is still there")
            if role in ("checker", "test-designer"):
                bans = "\n".join(sec_lines(lines_of(t), "## Bans") or [])
                for w in SPLIT_WORDS:
                    if w not in bans:
                        bad.append(f"{role}: Bans lack {w!r}")
            if role == "checker" and not re.search(r"WRONGLY_FRAMED", t):
                bad.append("checker: no WRONGLY_FRAMED")
        return not bad, "; ".join(bad[:6]) if bad else "every role's pinned lines present"

    def checker_template(self, lines):
        fm, body = verdict_template(lines)
        if fm is None:
            return None, None, "no fenced verdict template"
        keys = []
        for line in fm:
            if not line.strip():
                continue
            m = re.match(r"([a-z_]+): \S", line)
            if not m:
                return None, None, f"front-matter line not `key: value` on one line: {line[:40]!r}"
            keys.append(m.group(1))
        return keys, body, None

    def a_rf_checker_form(self):
        lines = self.head_role_lines("checker") or []
        keys, body, why = self.checker_template(lines)
        if why:
            return False, why
        bad = []
        if len(keys) != len(set(keys)):
            bad.append("a key repeats")
        if set(keys) != set(VERDICT_OLD + VERDICT_NEW):
            bad.append(f"keys differ: missing {sorted(set(VERDICT_OLD + VERDICT_NEW) - set(keys))}, "
                       f"extra {sorted(set(keys) - set(VERDICT_OLD + VERDICT_NEW))}")
        cond = [x for x in body if x.startswith("conditions:")]
        if not cond or "none" not in cond[0] or "see markers" not in cond[0]:
            bad.append("conditions: is not `none | see markers`")
        end = body.index("---", 1)
        nxt = next((x for x in body[end + 1:] if x.strip()), "")
        if nxt != "## Disciplines (D1–D9)":
            bad.append("the disciplines heading does not follow the front matter")
        if "<!-- conditions -->" not in body or "<!-- /conditions -->" not in body:
            bad.append("no whole-line conditions markers")
        else:
            s, e = body.index("<!-- conditions -->"), body.index("<!-- /conditions -->")
            if not any(COND_LINE.match(x) for x in body[s + 1:e]):
                bad.append("no `C<n> · type: … · blocks: … · closure: … · …` line between the markers")
        return not bad, "; ".join(bad) if bad else f"verdict template: {len(keys)} keys, conditions markers"

    def a_wo_steps(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 4)
        if s is None:
            return False, "no section 4"
        stop = next((i for i, x in enumerate(s) if x.startswith("**Where a result ran**")), len(s))
        nums = [m.group(1) for x in s[:stop] if (m := re.match(r"(\d+a?)\. ", x))]
        want = ["1", "1a", "2", "2a", "3", "4", "5", "6", "7"]
        return nums == want, f"section 4 steps {nums}"

    def a_wo_template(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 9)
        if s is None:
            return False, "no section 9"
        t = "\n".join(s)
        bad = [f for f in TEMPLATE_FIELDS if f not in t]
        if any(re.match(LEAD + r"\**Method\**\s*:", x) for x in s):
            bad.append("a Method field")
        return not bad, ("missing or wrong: " + ", ".join(bad)) if bad else "task template fields present, no Method"

    def a_wo_approach(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 9) or []
        bad = []
        blk = None
        fence, cur = False, []
        for x in s:
            if x.startswith("```"):
                if fence and "<!-- approach -->" in cur:
                    blk = cur
                    break
                fence, cur = not fence, []
                continue
            if fence:
                cur.append(x)
        if blk is None:
            bad.append("section 9: no fenced approach block format")
        else:
            _, why = approach_parse(blk)
            if why:
                bad.append(f"section 9: {why}")
        it = self.at(self.head, ITEM)
        if it is None:
            bad.append(f"{ITEM} missing")
        else:
            _, why = approach_parse(lines_of(it))
            if why:
                bad.append(f"{ITEM}: {why}")
        return not bad, "; ".join(bad) if bad else "one key list; section 9 format and the item's block both parse"

    def a_wo_verdict(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 9) or []
        wk, wb, why = self.checker_template(s)
        ck, cb, why2 = self.checker_template(self.head_role_lines("checker") or [])
        if why or why2:
            return False, f"template: {why or why2}"
        bad = []
        if wk != ck:
            bad.append("the key lists differ between checker.md and section 9")

        def conds(b):
            if "<!-- conditions -->" not in b or "<!-- /conditions -->" not in b:
                return None
            return b[b.index("<!-- conditions -->"):b.index("<!-- /conditions -->") + 1]
        if conds(wb) is None or conds(wb) != conds(cb):
            bad.append("the conditions lines differ or are missing")
        return not bad, "; ".join(bad) if bad else "section 9 and checker.md list the same fields"

    def a_wo_types(self):
        bad = []
        for path in (WO, AG.format("checker")):
            t = (self.at(self.head, path) or "").lower()
            for tok in CLOSURES + TYPES + BLOCKS:
                if tok not in t:
                    bad.append(f"{path.split('/')[-1]}: {tok!r}")
        return not bad, ("missing: " + ", ".join(bad)) if bad else "type, blocks and closure tokens in both files"

    def a_wo_table(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 4) or []
        i = next((k for k, x in enumerate(s) if x.startswith("|")), None)
        if i is None:
            return False, "no table in section 4"
        rows = []
        while i < len(s) and s[i].startswith("|"):
            rows.append(cells(s[i]))
            i += 1
        bad = []
        head = rows[0]
        pats = ["output", "consumer", "gate", "break"]
        if len(head) != 4 or not all(re.search(p, c, re.I) for p, c in zip(pats, head)):
            bad.append(f"header {head}")
        data = rows[2:]
        if len(data) < 7:
            bad.append(f"{len(data)} rows, at least 7")
        for n, r in enumerate(data, 1):
            if len(r) != 4:
                bad.append(f"row {n}: {len(r)} cells")
            elif not r[0].startswith(f"{n}. "):
                bad.append(f"row {n}: not numbered {n}.")
        if not any(len(r) == 4 and "hand-over" in r[0] and "no gate" in r[2] for r in data):
            bad.append("no hand-over row whose gate cell says no gate")
        if not any(len(r) == 4 and "triage" in r[0] and "checker" in r[0] for r in data):
            bad.append("no checker's-triage row")
        return not bad, "; ".join(bad[:5]) if bad else f"consumer table: {len(data)} numbered rows, four cells"

    def a_wo_notinforce(self):
        hwo = self.at(self.head, WO) or ""
        bset = set(sentences(self.bwo))
        hits, bad = 0, []
        for s in sentences(hwo):
            if s in bset or not NOT_IN_FORCE_TRIG.search(s):
                continue
            hits += 1
            if not ("not in force before" in s and "merged and synced" in s and re.search(r"W-C02-2[3-8]", s)):
                bad.append(s[:60])
        if hits == 0:
            return False, "no new sentence about T5, T6, the registry, the hooks or resuming"
        return not bad, (f"{len(bad)} of {hits} lack the marker: " + " | ".join(bad[:3])) if bad else \
            f"{hits} new sentences, each with its item and 'not in force before ... merged and synced'"

    def a_wo_reading(self):
        h = lines_of(self.at(self.head, WO) or "")
        t = "\n".join(h)
        s2 = "\n".join(wo_section(h, 2) or [])
        bad = [x for x in READING["2"] if x not in s2] + [x for x in READING["all"] if x not in t]
        wl = [x for x in h if x.startswith("**Where it left off**")]
        if len(wl) != 1 or "package" not in wl[0]:
            bad.append("the re-read list names no package")
        return not bad, ("missing: " + ", ".join(bad)) if bad else "2.5 (a), (b), (c), 2.4 and 2.7 anchors present"

    def a_wo_loop(self):
        h = lines_of(self.at(self.head, WO) or "")
        s = wo_section(h, 6) or []
        it = [x for x in s if x.startswith("2. **Loop limit.**")]
        ok = len(it) == 1 and re.search(r"round", it[0]) and re.search(r"blocking condition", it[0])
        return bool(ok), "section 6 item 2 counts rounds with blocking conditions" if ok else \
            "section 6 item 2 does not count rounds that leave blocking conditions open"

    def pc53(self):
        return self.at(self.head, PC53)

    def a_pc53_fm(self):
        import yaml
        t = self.pc53()
        if t is None:
            return False, "PC-53 missing"
        fl = front_lines(t)
        y = yaml.safe_load("\n".join(fl)) if fl else None
        ok = isinstance(y, dict) and y.get("id") == "PC-53" and y.get("kind") == "plan-change" and \
            y.get("class") == "technical"
        return ok, "PC-53: id, kind plan-change, class technical" if ok else "PC-53 front matter not as pinned"

    def a_pc53_protected(self):
        t = self.pc53()
        if t is None:
            return False, "PC-53 missing"
        lines = lines_of(t)
        if "<!-- protected -->" not in lines or "<!-- /protected -->" not in lines:
            return False, "no whole-line <!-- protected --> block"
        s, e = lines.index("<!-- protected -->"), lines.index("<!-- /protected -->")
        bad, entries = [], []
        for x in lines[s + 1:e]:
            if not x.strip():
                continue
            m = re.match(r"- (wo-section|wo-line|wo-para|path|batu-records) :: (.+)$", x)
            if not m:
                bad.append(f"entry not in the pinned form: {x[:40]!r}")
                continue
            entries.append((m.group(1), m.group(2)))
        hwo = self.at(self.head, WO) or ""
        got = set()
        for kind, val in entries:
            if kind.startswith("wo-"):
                try:
                    i, passage = resolve_wo(self.bwo_l, kind, val)
                except CouldNot as ex:
                    bad.append(str(ex))
                    continue
                got.add((kind, i))
                if hwo.count("\n".join(passage)) != 1:
                    bad.append(f"listed passage {val[:30]!r} not exactly once at the head")
            elif kind == "path":
                b = self.r.blob(self.base, val)
                got.add(("path", val))
                if b is None or self.r.blob(self.head, val) != b:
                    bad.append(f"listed path {val} missing at the base or changed")
            else:
                got.add(("batu", val))
        for kind, prefix in FIXED_WO:
            i, _ = resolve_wo(self.bwo_l, kind, prefix)
            if (kind, i) not in got:
                bad.append(f"fixed passage {prefix[:30]!r} not listed")
        for p in SUMMARIES:
            if ("path", p) not in got:
                bad.append(f"{p} not listed")
        if ("batu", "answer_original_tr") not in got:
            bad.append("batu-records :: answer_original_tr not listed")
        return not bad, "; ".join(bad[:5]) if bad else f"{len(entries)} protected entries, the fixed set among them"

    def a_pc53_list(self):
        t = self.pc53()
        if t is None:
            return False, "PC-53 missing"
        bad = [w for w in PC53_WORDS if w not in t]
        return not bad, ("missing: " + ", ".join(bad)) if bad else "4.3, notes, citations, 6.12 item 1 anchors present"

    def a_pc53_texts(self):
        t = self.pc53()
        if t is None:
            return False, "PC-53 missing"
        pc = collapse(t)
        hwo = self.at(self.head, WO) or ""
        a, b = self.bwo.split(), hwo.split()
        bad, runs = [], 0
        for op, i1, i2, j1, j2 in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
            if op == "equal":
                continue
            for words in (a[i1:i2], b[j1:j2]):
                if words:
                    runs += 1
                    if " ".join(words) not in pc:
                        bad.append(" ".join(words)[:50])
        hl = self.head_cl()
        at = self.floor_at(hl)
        if at:
            for i, x in enumerate(hl):
                if i >= 16 and not (at[0] <= i < at[0] + len(self.floor)) and x.strip() and collapse(x) not in pc:
                    bad.append(f"CLAUDE.md line {i + 1}")
        if runs == 0:
            return False, "the working order has no change"
        return not bad, (f"{len(bad)} of {runs} changed runs not in PC-53: " + " | ".join(bad[:3])) if bad else \
            f"{runs} changed word runs of the working order, and CLAUDE.md's added lines, all in PC-53"

    def a_scope(self):
        out = self.r.git("diff", "--name-status", "--no-renames", self.base, self.head, "--", ".claude")
        got = sorted(x for x in out.split("\n") if x.strip())
        want = sorted(f"M\t{AG.format(r)}" for r in ROLES)
        cms = [p for p in self.r.git("ls-tree", "-r", "--name-only", self.head).split("\n")
               if p.split("/")[-1] == "CLAUDE.md"]
        ok = got == want and cms == ["CLAUDE.md"]
        return ok, "under .claude only the five role files changed; one CLAUDE.md" if ok else \
            f".claude changes {got}; CLAUDE.md files {cms}"

    def a_c7neg(self):
        t = self.at(self.head, EV026)
        if t is None:
            return False, f"{EV026} missing (the negative control's file)"
        pk = [x for x in lines_of(t) if re.match(r"\s*Package:", x)]
        n = t.count("## Disciplines (D1–D9)")
        ok = not pk and n >= 5
        return ok, f"round notes: {len(pk)} Package: lines, {n} discipline blocks"

    # ---------------- K: over-blocking controls

    def filled_template(self, sha):
        keys, body, why = self.checker_template(self.head_role_lines("checker") or [])
        if why:
            raise CouldNot(f"checker.md template: {why}")
        out = []
        end = body.index("---", 1)
        for k, line in enumerate(body):
            if 0 < k < end and re.match(r"[a-z_]+: ", line):
                key, val = line.split(":", 1)
                val = val.strip()
                val = {"id": "CHK-C02-999", "reviewed_head": sha, "verdict": "PASS", "conditions": "none",
                       "date": "2026-10-20", "checker_run": "run-k"}.get(key, "x" if "<" in val else val)
                out.append(f"{key}: {val}")
            else:
                out.append(line)
        return "\n".join(out) + "\n", keys

    def k_front(self):
        text, keys = self.filled_template("0" * 40)
        dup_key = "read" if "read" in keys else "target"
        tl = text.split("\n")
        k = next(i for i, x in enumerate(tl) if x.startswith(dup_key + ":"))
        dup = "\n".join(tl[:k + 1] + [tl[k]] + tl[k + 1:])
        d = tempfile.mkdtemp(dir=self.tmp)
        for name, val in (("ok.md", text), ("dup.md", dup)):
            with open(os.path.join(d, name), "w", encoding="utf-8") as f:
                f.write(val)
        code = ("import merge_gate as g, json\n"
                f"a = g.front(open({os.path.join(d, 'ok.md')!r}, encoding='utf-8').read())\n"
                f"b = g.front(open({os.path.join(d, 'dup.md')!r}, encoding='utf-8').read())\n"
                "print(json.dumps([sorted(a) if a is not None else None, b]))")
        rc, out, err = self.run_tool(self.head, code, ["tools/merge_gate.py"])
        if rc:
            return False, f"front() failed: {err.strip()[-160:]}"
        import json
        a, b = json.loads(out)
        ok = a == sorted(keys) and b is None
        return ok, "front() reads every template key and refuses a repeated one" if ok else \
            f"front(): parsed {a}, repeated-key result {b}"

    def k_cover(self):
        d = tempfile.mkdtemp(dir=self.tmp)

        def g(*a):
            r = subprocess.run(["git", "-C", d, "-c", "user.name=w22", "-c", "user.email=w22@invalid",
                                "-c", "commit.gpgsign=false", *a], capture_output=True, text=True)
            if r.returncode:
                raise CouldNot(f"synthetic repo: git {a[0]}: {r.stderr.strip()[:120]}")
            return r.stdout.strip()
        g("init", "-q")
        with open(os.path.join(d, "CLAUDE.md"), "w") as f:
            f.write("a\n")
        g("add", "-A")
        g("commit", "-qm", "base")
        base = g("rev-parse", "HEAD")
        with open(os.path.join(d, "CLAUDE.md"), "w") as f:
            f.write("b\n")
        g("commit", "-qam", "x")
        x = g("rev-parse", "HEAD")
        text, keys = self.filled_template(x)
        vf = "evidence/C02/checks/CHK-C02-999.md"
        os.makedirs(os.path.join(d, "evidence/C02/checks"))
        with open(os.path.join(d, vf), "w", encoding="utf-8") as f:
            f.write(text)
        g("add", "-A")
        g("commit", "-qm", "verdict")
        head1 = g("rev-parse", "HEAD")
        dup_key = "read" if "read" in keys else "target"
        tl = text.split("\n")
        k = next(i for i, y in enumerate(tl) if y.startswith(dup_key + ":"))
        with open(os.path.join(d, vf), "w", encoding="utf-8") as f:
            f.write("\n".join(tl[:k + 1] + [tl[k]] + tl[k + 1:]))
        g("commit", "-qam", "dup")
        head2 = g("rev-parse", "HEAD")
        code = ("import merge_gate as g, json\n"
                f"r = []\nfor h in ({head1!r}, {head2!r}):\n"
                f"    v, x, why = g.cover(h, {base!r}, set(g.changed({base!r}, h)))\n"
                "    r.append([v, x, why])\nprint(json.dumps(r))")
        tools = tempfile.mkdtemp(dir=self.tmp)
        os.makedirs(os.path.join(tools, "tools"))
        with open(os.path.join(tools, "tools/merge_gate.py"), "wb") as f:
            f.write(self.r.blob(self.head, "tools/merge_gate.py"))
        prog = f"import sys; sys.dont_write_bytecode = True; sys.path.insert(0, {os.path.join(tools, 'tools')!r})\n"
        r = subprocess.run([sys.executable, "-I", "-c", prog + code], capture_output=True, text=True, cwd=d)
        if r.returncode:
            return False, f"cover() failed: {r.stderr.strip()[-160:]}"
        import json
        (v1, x1, _), (v2, _, why2) = json.loads(r.stdout)
        ok = v1 == vf and x1 == x and v2 is None and any("a key repeats" in w for w in why2)
        return ok, "cover() accepts the template's verdict and refuses it with a repeated key" if ok else \
            f"cover(): {v1}/{x1 == x}; repeated key: {v2} {why2[:1]}"

    def k_handover(self):
        _, body, why = self.checker_template(self.head_role_lines("checker") or [])
        if why:
            raise CouldNot(f"checker.md template: {why}")
        disc = "## Disciplines (D1–D9)\n" + "\n".join(f"D{n}: no" for n in range(1, 10)) + "\n"
        product = ("Product:\n```\n" + "\n".join(body) + "\n```\n```diff\n--- a/x\n+++ b/x\n@@ -1 +1 @@\n"
                   "-## Disciplines (D1–D9)\n+D1: no\n```\n")
        head = "Package: none delivered (file absent)\nNonce: none delivered\nTake-up: PROCEED: the task holds.\n\n"
        mid = ("\nRead, and what each changed: x\nRelied on: x (observed)\nUnsure: none\nFor: the executor\n"
               "Received from / Returned to: none\n")
        sound = head + disc + mid + product + "Guard denials: none\n"
        product_first = head + product + disc + mid + "Guard denials: none\n"
        hyphen = (head + disc + mid).replace("D1–D9", "D1-D9") + "Guard denials: none\n"
        d = tempfile.mkdtemp(dir=self.tmp)
        for name, val in (("s", sound), ("p", product_first), ("h", hyphen)):
            with open(os.path.join(d, name), "w", encoding="utf-8") as f:
                f.write(val)
        code = ("import subagent_audit as s, json\n"
                f"print(json.dumps([s.block_problem(open({d!r} + '/' + n, encoding='utf-8').read()) "
                "for n in 'sph']))")
        rc, out, err = self.run_tool(self.head, code, ["tools/subagent_audit.py", WO])
        if rc:
            return False, f"block_problem() failed: {err.strip()[-160:]}"
        import json
        a, b, c = json.loads(out)
        ok = a is None and b == "line 1 of the block is not a D1 answer" and \
            c == 'no "## Disciplines (D1–D9)" heading'
        return ok, "a sound hand-over passes; Product first and a hyphen fail with their own reasons" if ok else \
            f"block_problem: sound {a!r}; product first {b!r}; hyphen {c!r}"

    def k_render(self):
        d = tempfile.mkdtemp(dir=self.tmp)
        arch = self.r.git("archive", "--format=tar", self.head, data=True)
        r = subprocess.run(["tar", "-x", "-C", d], input=arch, capture_output=True)
        if r.returncode:
            raise CouldNot("cannot unpack the head")
        r = subprocess.run([sys.executable, "-I", "tools/records.py", "render", "--check"], capture_output=True,
                           text=True, cwd=d)
        last = (r.stdout.strip().split("\n") or [""])[-1]
        return r.returncode == 0, f"records.py render --check exit {r.returncode}: {last[:100]}"


ORDER = [
    ("P-PLAN", "P", "p_plan"), ("P-SUMMARY", "P", "p_summary"), ("P-BATU", "P", "p_batu"),
    ("P-WO-PASSAGES", "P", "p_wo_passages"), ("P-LABEL", "P", "p_label"),
    ("U-CL-OLD", "U", "u_cl_old"), ("U-RF-FM", "U", "u_rf_fm"), ("U-RF-CD", "U", "u_rf_cd"),
    ("U-RF-SUCCESS", "U", "u_rf_success"), ("U-RF-BANS", "U", "u_rf_bans"), ("U-RF-MAP", "U", "u_rf_map"),
    ("U-RF-D016", "U", "u_rf_d016"), ("U-WO-STEP2", "U", "u_wo_step2"), ("U-WO-TASKBLOCK", "U", "u_wo_taskblock"),
    ("U-WO-UNTOUCHED", "U", "u_wo_untouched"),
    ("A-CL-FLOOR", "A", "a_cl_floor"), ("A-CL-CLOSED", "A", "a_cl_closed"), ("A-RF-DESC", "A", "a_rf_desc"),
    ("A-RF-SHARED", "A", "a_rf_shared"), ("A-RF-HANDOVER", "A", "a_rf_handover"), ("A-RF-OWN", "A", "a_rf_own"),
    ("A-RF-CHECKER-FORM", "A", "a_rf_checker_form"), ("A-WO-STEPS", "A", "a_wo_steps"),
    ("A-WO-TEMPLATE", "A", "a_wo_template"), ("A-WO-APPROACH", "A", "a_wo_approach"),
    ("A-WO-VERDICT", "A", "a_wo_verdict"), ("A-WO-TYPES", "A", "a_wo_types"), ("A-WO-TABLE", "A", "a_wo_table"),
    ("A-WO-NOTINFORCE", "A", "a_wo_notinforce"), ("A-WO-READING", "A", "a_wo_reading"),
    ("A-WO-LOOP", "A", "a_wo_loop"), ("A-PC53-FM", "A", "a_pc53_fm"), ("A-PC53-PROTECTED", "A", "a_pc53_protected"),
    ("A-PC53-LIST", "A", "a_pc53_list"), ("A-PC53-TEXTS", "A", "a_pc53_texts"), ("A-SCOPE", "A", "a_scope"),
    ("A-C7NEG", "A", "a_c7neg"),
    ("K-FRONT", "K", "k_front"), ("K-COVER", "K", "k_cover"), ("K-HANDOVER", "K", "k_handover"),
    ("K-RENDER", "K", "k_render"),
]


def main(argv=None):
    ap = argparse.ArgumentParser(prog="check.py")
    ap.add_argument("--repo", required=True)
    ap.add_argument("--base", required=True)
    ap.add_argument("--head", required=True)
    ap.add_argument("--only", choices=["protected"])
    a = ap.parse_args(argv)
    mode = a.only or "all"
    try:
        repo = Repo(a.repo)
        if repo.git("rev-parse", "--is-shallow-repository").strip() != "false":
            raise CouldNot("the clone is shallow (or not a git repository): ancestry and history cannot be read")
        base = repo.git("rev-parse", "--verify", f"{a.base}^{{commit}}").strip()
        head = repo.git("rev-parse", "--verify", f"{a.head}^{{commit}}").strip()
        if repo.git("merge-base", "--is-ancestor", base, head, ok=True) is None:
            raise CouldNot("the base is not an ancestor of the head")
        print(f"W22_CHECK base {base} head {head} mode {mode} python {sys.version.split()[0]} "
              f"{repo.git('--version').strip()}")
        with tempfile.TemporaryDirectory() as tmp:
            c = Checks(repo, base, head, tmp)
            run = passed = 0
            for cid, fam, fn in ORDER:
                if mode == "protected" and fam != "P":
                    continue
                try:
                    ok, detail = getattr(c, fn)()
                except CouldNot:
                    raise
                except Exception as e:   # noqa: BLE001 - an error inside a check is that check's FAIL
                    ok, detail = False, f"error: {type(e).__name__}: {e}"
                run += 1
                passed += bool(ok)
                print(f"CHECK {cid} {fam} {'PASS' if ok else 'FAIL'} {detail}")
    except CouldNot as e:
        print(f"W22_CHECK COULD NOT CHECK: {e}")
        return 2
    exp = EXPECTED[mode]
    print(f"CHECKS run={run} pass={passed} fail={run - passed} expected={exp}")
    good = run == exp and passed == run
    print("W22_CHECK PASS" if good else "W22_CHECK FAIL")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main())
