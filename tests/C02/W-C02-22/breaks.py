#!/usr/bin/env python3
"""W-C02-22: the breaks of check.py (Appendix C, C0: a break attempt per rule), and its "filled but meaningless" head.

Usage: python3 -I tests/C02/W-C02-22/breaks.py --repo <full clone> --base aa6d144 --main <rev> [--only <break id>...]

It clones --repo into a temporary directory (never writes to --repo), and there:
1. builds the STUB head on top of --main: every PR-A1 form check.py pins, filled with placeholder words, plus a
   `records.py render`. It is the format gate's "filled but meaningless" example (C0): check.py must pass it with all
   its checks, which shows what a green run does not prove (the content is the binding checker's product-only reading);
2. runs check.py at --main (A red, the rest green) and at the stub (all green);
3. for each break, commits one mutation on --main (P and U breaks, protected and unchanged texts) or on the stub
   (A and K breaks, what PR-A1 adds and the controls) and runs check.py at it: the break counts only when the named
   check turns FAIL. A break whose text is not there is NOT APPLICABLE, never a pass.

At the product head the binding checker makes its own mutations of the real head (its floor); this runner is the
test designer's evidence that each check can turn red, made before the product exists.
Output: `BREAK <id> <check> <base> BROKE|NOT SENSITIVE|NOT APPLICABLE <other checks turned red>`, then
`BREAKS run=<n> broke=<b>` and `W22_BREAKS PASS` (exit 0) only when every break broke and both reference runs held.
"""
import argparse
import difflib
import os
import re
import shutil
import subprocess
import sys
import tempfile
import unicodedata

sys.dont_write_bytecode = True
HERE = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, HERE)
import check as C  # noqa: E402  (the pinned strings come from check.py itself: one source)


class NotApplicable(Exception):
    pass


class W:
    """A scratch clone."""

    def __init__(self, d):
        self.d = d

    def git(self, *a, ok=False):
        r = subprocess.run(["git", "-C", self.d, "-c", "user.name=w22-breaks", "-c", "user.email=w22@invalid",
                            "-c", "commit.gpgsign=false", *a], capture_output=True, text=True)
        if r.returncode and not ok:
            raise RuntimeError(f"git {' '.join(a)[:80]}: {r.stderr.strip()[:200]}")
        return r.stdout.strip()

    def p(self, path):
        return os.path.join(self.d, path)

    def read(self, path):
        with open(self.p(path), encoding="utf-8") as f:
            return f.read()

    def write(self, path, text):
        os.makedirs(os.path.dirname(self.p(path)) or ".", exist_ok=True)
        with open(self.p(path), "w", encoding="utf-8") as f:
            f.write(text)

    def sub(self, path, old, new, count=1):
        t = self.read(path)
        if old not in t:
            raise NotApplicable(f"{path}: {old[:40]!r} not found")
        self.write(path, t.replace(old, new, count))

    def line(self, path, prefix, fn):
        """Replace the first line starting with prefix by fn(line) (a list of lines; [] deletes it)."""
        ls = self.read(path).split("\n")
        i = next((k for k, x in enumerate(ls) if x.startswith(prefix)), None)
        if i is None:
            raise NotApplicable(f"{path}: no line starting {prefix[:40]!r}")
        self.write(path, "\n".join(ls[:i] + fn(ls[i]) + ls[i + 1:]))

    def commit(self, msg):
        self.git("add", "-A")
        self.git("commit", "-qm", msg, "--allow-empty")
        return self.git("rev-parse", "HEAD")


# ---------------------------------------------------------------- the stub ("filled but meaningless")

def stub(w):
    name_of = {r: r for r in C.ROLES}
    # CLAUDE.md: the floor and three lines
    base_floor = None
    ek = w.read(C.EKD).split("\n")
    i = ek.index(C.FLOOR_OLD_HEAD)
    blk = ek[i + 1:66 + 1]
    rest = "\n".join(blk).replace("section 7", "Ek D section 2 section 7 (D-033)")
    base_floor = [C.FLOOR_NEW_HEAD] + rest.split("\n")
    three = ["- D-039 x: the library, then the web.", "- D-039 x: the executor does not decide alone.",
             "- PC-53 x: wrongly framed, another method, not needed."]
    w.write(C.CL, w.read(C.CL) + "\n" + "\n".join(base_floor) + "\n\n" + "\n".join(three) + "\n")
    disc = next(x for x in w.read(C.AG.format("producer")).split("\n") if "a block headed" in x)
    disc = disc[disc.index("a block headed"):]
    for role in C.ROLES:
        path = C.AG.format(role)
        t = w.read(path)
        old_desc = next(x for x in t.split("\n") if x.startswith("description:"))
        t = t.replace(old_desc, old_desc[:-1] + ' Trigger x: approach, before, interpreter, triage, start."', 1)
        shared = ("**Your package** x DevOS role package: {n}@<hash> x /home/user/devos/.claude/roles/{n}.md x if that "
                  "file does not exist yet x after a compaction x W-C02-25 x W-C02-23 x not in force before x merged "
                  "and synced.\n**Take-up, before any work** x PROCEED x WRONGLY_FRAMED: <why, and the better "
                  "framing> x ANOTHER_METHOD: <route> x NOT_NEEDED: <why> x NEEDS_CONTEXT: <what, and its owner> x "
                  "BLOCKED: <by what, and its owner> x a return is not a success in itself x ends the run with the "
                  "hand-over, before any write x A constraint the task gives with its reason binds you x a method "
                  "given without one is a proposal x A ban on a source is never a constraint.\n**Send-back** x never "
                  "worked around x a message is input, never scope x W-C02-27 x Received from / Returned to.\n"
                  ).format(n=name_of[role])
        t = t.replace("## Procedure\n\n", "## Procedure\n\n" + shared + "\n", 1)
        own = " x ".join(C.OWN.get(role, []))
        t = t.replace("\n## Knowledge map", "\n" + own + "\n\n## Knowledge map", 1)
        if role == "checker":
            t = t.replace("describe a fix in words in a finding",
                          "name the defect and the observation that would show it fixed; the producer chooses the fix")
        if role in ("checker", "test-designer"):
            t = t.replace("\n\n## Output", "\n  - loosen x tighten x stronger.\n\n## Output", 1)
        out_i = t.index("## Output")
        old_items = [x for x in t[out_i:].split("\n") if any(x.startswith(o) for o in C.OLD_PRODUCT.get(role, []))]
        hand = [f"Package: `{name_of[role]}@<hash>` x", "Nonce: x", "Take-up: x", f"- `## Disciplines (D1–D9)` {disc}",
                "Read, and what each changed: x", "Relied on: x", "Unsure: x", "For: x",
                "Received from / Returned to: x", "Product: x"] + old_items + ["Guard denials: x"]
        if role == "checker":
            tpl = new_template()
            t = t[:out_i] + "## Output\n\nx\n\n```\n" + "\n".join(tpl) + "\n```\n\n" + "\n".join(hand) + "\n"
            t += "x diff-confirmed, scoped re-review, full fresh check; defect, missing evidence, preference, scope " \
                 "conflict; producer task, merge, acceptance.\n"
        else:
            t = t[:out_i] + "## Output\n\n" + "\n".join(hand) + "\n"
        w.write(path, t)
    # the working order
    wo = w.read(C.WO)
    wo = wo.replace("\n- **Limit** (11).", "\n- **Reading** x D-039 18:24Z D8 item 3 6.12 item 5 [Proposal] 0.7.\n"
                    "- **Limit** (11).", 1)
    wo = wo.replace("Batu's new answers (section 8);", "Batu's new answers (section 8), the executor's package;", 1)
    wo = wo.replace("\n2. **Acceptance before results.**",
                    "\n1a. **Team triage x.** T5 checks it (W-C02-24; not in force before it is merged and synced). "
                    "x settles what a source states, not the decision x is a minimum x presence only x never sent "
                    "again unchanged x no single score x diff-confirmed, scoped re-review, full fresh check; defect, "
                    "missing evidence, preference, scope conflict; producer task, merge, acceptance.\n"
                    "2. **Acceptance before results.**", 1)
    wo = wo.replace("\n3. **Split and delegate.**", "\n2a. **Shared pull request x.** x\n3. **Split and delegate.**", 1)
    rows = ["| Output | Consumer | Gate | Break |", "|---|---|---|---|"] + \
        [f"| {n}. x{n} | x | x | x |" for n in range(1, 6)] + \
        ["| 6. a hand-over | its named consumer | no gate on the content | x |",
         "| 7. the checker's triage | x | T5 x (W-C02-24; not in force before it is merged and synced) | x |"]
    wo = wo.replace("\n\n**Where a result ran**", "\n\n" + "\n".join(rows) + "\n\n**Where a result ran**", 1)
    wo = wo.replace("before a third attempt.\n", "before a third attempt. Rounds x that leave a blocking condition "
                    "open count.\n", 1)
    tmpl = ("**Task** x: `Item: plan/work/W-…md`; Purpose; Acceptance; Consumer; Inputs; `Teammates:`; Output; "
            "Writer or reader; Limits; Constraints; Your take-up and returns: see your role file.\n\n"
            "**Approach** x:\n\n```\n<!-- approach -->\n" + "\n".join(f"{k}: x" for k in C.APPROACH_KEYS) +
            "\n<!-- /approach -->\n```\n\n")
    wo = wo.replace("## 9. Record formats\n\n", "## 9. Record formats\n\n" + tmpl, 1)
    s = wo.index("**Checker verdict**")
    a = wo.index("```\n", s)
    b = wo.index("```\n", a + 4)
    wo = wo[:a] + "```\n" + "\n".join(new_template()) + "\n" + wo[b:]
    w.write(C.WO, wo)
    # the item file, PC-53 and the round notes
    w.write(C.ITEM, "---\nid: W-C02-22\nkind: item\nparent: C02\ntitle: \"x\"\nadmission: admitted\n"
                    "execution: planned\nacceptance: proposed\ndepends_on: []\n---\n\n# x\n\n## Acceptance\n\n"
                    "<!-- acceptance -->\nx\n<!-- /acceptance -->\n\n## Approach\n\n<!-- approach -->\n" +
            "\n".join(f"{k}: x" for k in C.APPROACH_KEYS) + "\n<!-- /approach -->\n")
    base_wo = subprocess.run(["git", "-C", w.d, "show", "HEAD:" + C.WO], capture_output=True, text=True).stdout
    pairs = []
    bl, hl = base_wo.split("\n"), wo.split("\n")
    for op, i1, i2, j1, j2 in difflib.SequenceMatcher(None, bl, hl, autojunk=False).get_opcodes():
        if op != "equal":
            pairs.append("Old:\n```text\n" + "\n".join(bl[i1:i2]) + "\n```\nNew:\n```text\n" + "\n".join(hl[j1:j2]) +
                         "\n```\n")
    prot = [f"- {k} :: {p}" for k, p in C.FIXED_WO] + [f"- path :: {p}" for p in C.SUMMARIES] + \
        ["- batu-records :: answer_original_tr"]
    w.write(C.PC53, "---\nid: PC-53\ntitle: \"x\"\nkind: plan-change\nclass: technical\nstatus: open\n---\n\n# PC-53\n\n"
                    "<!-- protected -->\n" + "\n".join(prot) + "\n<!-- /protected -->\n\n" + " x ".join(C.PC53_WORDS) +
            "\n\n" + "\n".join(pairs) + "\n```text\n" + "\n".join(three) + "\n```\n")
    w.write(C.EV026, "# EV-C02-026 x\n\n" + ("Take-up: x\n\n## Disciplines (D1–D9)\n" +
                                             "\n".join(f"D{n}: no" for n in range(1, 10)) + "\n\n") * 5)
    r = subprocess.run([sys.executable, "-I", "tools/records.py", "render"], capture_output=True, text=True, cwd=w.d)
    if r.returncode:
        raise RuntimeError(f"render failed in the stub: {r.stdout[-200:]} {r.stderr[-200:]}")


def new_template():
    keys = [k for k in C.VERDICT_OLD if k != "date"] + ["date"] + C.VERDICT_NEW
    vals = {"id": "CHK-<stage>-<nnn>", "target": "<x>", "reviewed_head": "<sha>", "verdict": "<PASS | FAIL>",
            "conditions": "none | see markers", "independence": "\"x\"", "checker_run": "<x>", "date": "<YYYY-MM-DD>"}
    fm = [f"{k}: {vals.get(k, '<x>')}" for k in keys]
    return ["---"] + fm + ["---", "", "## Disciplines (D1–D9)", "", "<nine lines>", "", "<!-- conditions -->",
                           "C<n> · type: <defect | missing evidence> · blocks: <producer task | merge | acceptance> · "
                           "closure: <diff-confirmed | scoped re-review | full fresh check> · <x>",
                           "<!-- /conditions -->", "", "## Findings", "", "<x>"]


# ---------------------------------------------------------------- the breaks

def nfd_line(w, path, prefix):
    def f(x):
        y = unicodedata.normalize("NFD", x)
        if y == x:
            raise NotApplicable("the line has no decomposable character")
        return [y]
    w.line(path, prefix, f)


def swap(w, path, a, b):
    ls = w.read(path).split("\n")
    i = next((k for k, x in enumerate(ls) if x.startswith(a)), None)
    j = next((k for k, x in enumerate(ls) if x.startswith(b)), None)
    if i is None or j is None:
        raise NotApplicable("lines to swap not found")
    ls[i], ls[j] = ls[j], ls[i]
    w.write(path, "\n".join(ls))


AGP = C.AG.format
BREAKS = [
    # P: protected (on main)
    ("B01", "P-PLAN", "main", lambda w: w.write("plan/Ek_Z_probe.md", "probe\n")),
    ("B02", "P-PLAN", "main", lambda w: w.line("plan/DevOS_Kurulum_Plani.md", "#", lambda x: [x + " "])),
    ("B03", "P-SUMMARY", "main", lambda w: w.sub(C.SUMMARIES[0], "ı", "i")),
    ("B04", "P-SUMMARY", "main", lambda w: w.sub(C.SUMMARIES[1], "the ", "the  ")),
    ("B05", "P-BATU", "main", lambda w: w.line("plan/decisions/D-010.md", "answer_original_tr:",
                                               lambda x: [x.replace("briefs/", "brief/", 1)])),
    ("B06", "P-BATU", "main", lambda w: nfd_line(w, "plan/decisions/D-041.md", "answer_original_tr:")),
    ("B07", "P-BATU", "main", lambda w: w.sub("plan/decisions/D-039.md", "\nclass: batu\n", "\nclass: technical\n")),
    ("B08", "P-WO-PASSAGES", "main", lambda w: w.sub(C.WO, "Batu teknik karar vermez.", "Batu teknik karar vermez!")),
    ("B09", "P-WO-PASSAGES", "main", lambda w: nfd_line(w, C.WO, "5. Batu teknik karar vermez.")),
    ("B10", "P-WO-PASSAGES", "main", lambda w: w.sub(C.WO, "purpose and direction, scope", "purpose, direction, scope")),
    ("B11", "P-WO-PASSAGES", "main", lambda w: w.line(C.WO, "- **Two layers** (20).", lambda x: [x, x])),
    ("B12", "P-LABEL", "main", lambda w: w.line(AGP("producer"), "Installation helper role",
                                                lambda x: [x + " [Batu's decision D-039]"])),
    ("B13", "P-LABEL", "stub", lambda w: w.sub(C.CL, "- PC-53 x:", "- PC-53 x [Batu, 2026-10-20]:")),
    ("B14", "P-LABEL", "main", lambda w: w.line(C.WO, "3. **Split and delegate.**",
                                                lambda x: [x + " PC-53 is the team's rule [Batu kararı]."])),
    # U: left unchanged by PR-A1 (on main)
    ("B15", "U-CL-OLD", "main", lambda w: w.sub(C.CL, "No paid feature is enabled", "No paid feature is enabled.")),
    ("B16", "U-CL-OLD", "main", lambda w: w.line(C.CL, "- **Money.**", lambda x: [])),
    ("B17", "U-RF-FM", "main", lambda w: w.line(AGP("producer"), "model: inherit", lambda x: [x, "effort: high"])),
    ("B18", "U-RF-FM", "main", lambda w: w.line(AGP("checker"), "model: inherit", lambda x: [x, "omitClaudeMd: true"])),
    ("B19", "U-RF-FM", "main", lambda w: w.line(AGP("prober"), "tools:", lambda x: [x + ", SendMessage"])),
    ("B20", "U-RF-CD", "main", lambda w: w.sub(AGP("counter-designer"), "the", "The")),
    ("B21", "U-RF-CD", "main", lambda w: w.write(AGP("counter-designer"), w.read(AGP("counter-designer")) + "\n")),
    ("B22", "U-RF-SUCCESS", "main", lambda w: w.sub(AGP("checker"), " Rejecting sound work is a failure too.", "")),
    ("B23", "U-RF-SUCCESS", "main", lambda w: w.line(AGP("test-designer"), "**Success direction:**", lambda x: [])),
    ("B24", "U-RF-BANS", "main", lambda w: w.sub(AGP("prober"), "never report a step you did not run as run",
                                                 "report a step you did not run only when asked")),
    ("B25", "U-RF-BANS", "main", lambda w: w.sub(AGP("checker"), "- You never fix. ", "- ")),
    ("B26", "U-RF-BANS", "main", lambda w: w.sub(AGP("test-designer"), "(ledger rule 3; Appendix G G8 item 3). If",
                                                 "(ledger rule 3). If")),
    ("B27", "U-RF-MAP", "main", lambda w: w.line(AGP("researcher"), "- `research/studies/public-apis/`", lambda x: [])),
    ("B28", "U-RF-MAP", "main", lambda w: w.sub(AGP("producer"), "(reuse first, smallest", "(reuse, smallest")),
    ("B29", "U-RF-D016", "main", lambda w: w.sub(AGP("producer"), "a hint and not evidence", "evidence")),
    ("B30", "U-RF-D016", "main", lambda w: w.sub(AGP("checker"), "## Thinking disciplines (D-016)",
                                                 "## Thinking disciplines")),
    ("B31", "U-WO-STEP2", "main", lambda w: w.sub(C.WO, "it is never loosened afterwards", "it is not loosened")),
    ("B32", "U-WO-STEP2", "main", lambda w: w.sub(C.WO, "\n2. **Acceptance before results.**",
                                                  "\n2b. **Acceptance before results.**")),
    ("B33", "U-WO-TASKBLOCK", "main", lambda w: w.sub(C.WO, "and evaluate all nine for this task",
                                                      "and evaluate the nine for this task")),
    ("B34", "U-WO-TASKBLOCK", "main", lambda w: w.sub(C.WO, "\n## 9. Record formats", "\n```\n## 9. Record formats")),
    ("B35", "U-WO-UNTOUCHED", "main", lambda w: w.sub(C.WO, "**What it does.**", "**What it does**")),
    ("B36", "U-WO-UNTOUCHED", "main", lambda w: w.sub(C.WO, "Reasoning may propose", "Reasoning can propose")),
    # A: what PR-A1 adds (on the stub)
    ("B37", "A-CL-FLOOR", "stub", lambda w: w.line(C.CL, "5. Notice the limit of your knowledge", lambda x: [])),
    ("B38", "A-CL-FLOOR", "stub", lambda w: w.sub(C.CL, "[Proposal:", "[Proposal (team):")),
    ("B39", "A-CL-CLOSED", "stub", lambda w: w.write(C.CL, w.read(C.CL) + "- x\n")),
    ("B40", "A-CL-CLOSED", "stub", lambda w: w.sub(C.CL, ", not needed.", ".")),
    ("B41", "A-RF-DESC", "stub", lambda w: w.sub(AGP("producer"), ' Trigger x: approach, before, interpreter, triage, '
                                                 'start."', '"')),
    ("B42", "A-RF-DESC", "stub", lambda w: w.line(AGP("checker"), "description:",
                                                  lambda x: [x.replace("triage", "tri")])),
    ("B43", "A-RF-SHARED", "stub", lambda w: w.sub(AGP("prober"), " x NOT_NEEDED: <why>", "")),
    ("B44", "A-RF-SHARED", "stub", lambda w: w.sub(AGP("researcher"), "never worked around", "never worked round")),
    ("B45", "A-RF-HANDOVER", "stub", lambda w: swap(w, AGP("prober"), "Unsure: x", "For: x")),
    ("B46", "A-RF-HANDOVER", "stub", lambda w: w.sub(AGP("test-designer"), "- `## Disciplines (D1–D9)` a block",
                                                     "- `## Disciplines (D1-D9)` a block")),
    ("B47", "A-RF-HANDOVER", "stub", lambda w: w.line(AGP("researcher"), "- **Findings:**", lambda x: [])),
    ("B48", "A-RF-OWN", "stub", lambda w: w.sub(AGP("producer"), C.OWN["producer"][0], "x")),
    ("B49", "A-RF-OWN", "stub", lambda w: w.sub(AGP("checker"), "; name the defect and the observation that would "
                                                "show it fixed; the producer chooses the fix. Use",
                                                "; describe a fix in words in a finding. Use")),
    ("B50", "A-RF-CHECKER-FORM", "stub", lambda w: w.line(AGP("checker"), "read: <x>", lambda x: [x, x])),
    ("B51", "A-RF-CHECKER-FORM", "stub", lambda w: w.line(AGP("checker"), "relied_on: <x>",
                                                          lambda x: ["relied_on:", "  - x"])),
    ("B52", "A-WO-STEPS", "stub", lambda w: w.sub(C.WO, "\n1a. **Team triage x.**", "\n2. **Team triage x.**")),
    ("B53", "A-WO-STEPS", "stub", lambda w: w.line(C.WO, "2a. **Shared pull request x.**", lambda x: [])),
    ("B54", "A-WO-TEMPLATE", "stub", lambda w: w.line(C.WO, "**Task** x:", lambda x: [x, "Method: how to do it"])),
    ("B55", "A-WO-TEMPLATE", "stub", lambda w: w.sub(C.WO, " `Teammates:`;", "")),
    ("B56", "A-WO-APPROACH", "stub", lambda w: w.sub(C.WO, "\nnot_asked: x\n", "\nnot asked: x\n")),
    ("B57", "A-WO-APPROACH", "stub", lambda w: w.line(C.ITEM, "library: x", lambda x: [])),
    ("B58", "A-WO-VERDICT", "stub", lambda w: w.line(C.WO, "triage: <x>", lambda x: [])),
    ("B59", "A-WO-VERDICT", "stub", lambda w: w.line(C.WO, "C<n> · type:", lambda x: [x.replace("closure:", "close:")])),
    ("B60", "A-WO-TYPES", "stub", lambda w: w.write(AGP("checker"), w.read(AGP("checker")).replace(
        "scoped re-review", "scoped review"))),
    ("B61", "A-WO-TYPES", "stub", lambda w: w.write(C.WO, w.read(C.WO).replace("diff-confirmed", "diff confirmed"))),
    ("B62", "A-WO-TABLE", "stub", lambda w: w.sub(C.WO, "| 3. x3 | x | x | x |", "| 3. x3 | x | x |")),
    ("B63", "A-WO-TABLE", "stub", lambda w: w.sub(C.WO, "| no gate on the content |", "| a gate |")),
    ("B64", "A-WO-NOTINFORCE", "stub", lambda w: w.sub(C.WO, "T5 checks it (W-C02-24; not in force before it is merged "
                                                       "and synced).", "T5 checks it (W-C02-24).")),
    ("B65", "A-WO-NOTINFORCE", "stub", lambda w: w.sub(C.WO, "**Shared pull request x.** x",
                                                       "**Shared pull request x.** x The registry holds every agent.")),
    ("B66", "A-WO-READING", "stub", lambda w: w.sub(C.WO, " D8 item 3", "")),
    ("B67", "A-WO-READING", "stub", lambda w: w.sub(C.WO, " x presence only", "")),
    ("B68", "A-WO-LOOP", "stub", lambda w: w.sub(C.WO, " Rounds x that leave a blocking condition open count.", "")),
    ("B69", "A-WO-LOOP", "stub", lambda w: w.sub(C.WO, "leave a blocking condition open", "leave a blocking finding "
                                                 "open")),
    ("B70", "A-PC53-FM", "stub", lambda w: w.sub(C.PC53, "class: technical", "class: batu")),
    ("B71", "A-PC53-FM", "stub", lambda w: w.sub(C.PC53, "kind: plan-change\n", "")),
    ("B72", "A-PC53-PROTECTED", "stub", lambda w: w.line(C.PC53, "- wo-line :: - **What is his**", lambda x: [])),
    ("B73", "A-PC53-PROTECTED", "stub", lambda w: w.sub(C.PC53, "- wo-section :: ", "- wo-section: ")),
    ("B74", "A-PC53-LIST", "stub", lambda w: w.write(C.PC53, w.read(C.PC53).replace("D-041", "D-04l"))),
    ("B75", "A-PC53-LIST", "stub", lambda w: w.write(C.PC53, w.read(C.PC53).replace("on: finished", "on finished"))),
    ("B76", "A-PC53-TEXTS", "stub", lambda w: w.sub(C.WO, "**Shared pull request x.** x",
                                                    "**Shared pull request x.** x Extra words not in the record.")),
    ("B77", "A-PC53-TEXTS", "stub", lambda w: w.sub(C.CL, "- D-039 x: the library, then the web.",
                                                    "- D-039 x: the library first, then the web.")),
    ("B78", "A-SCOPE", "stub", lambda w: w.write(".claude/settings.json", w.read(".claude/settings.json") + " ")),
    ("B79", "A-SCOPE", "stub", lambda w: w.write(".claude/roles/producer.md", "x\n")),
    ("B80", "A-C7NEG", "stub", lambda w: w.write(C.EV026, w.read(C.EV026) + "Package: none delivered\n")),
    ("B81", "A-C7NEG", "stub", lambda w: os.remove(w.p(C.EV026))),
    # K: the controls (on the stub)
    ("B82", "K-RENDER", "stub", lambda w: w.sub("DURUM.md", "\n", "\n\n")),
    ("B83", "K-RENDER", "stub", lambda w: w.sub(C.ITEM, 'title: "x"', 'title: "y"')),
    ("B84", "K-FRONT", "stub", lambda w: w.line(AGP("checker"), "target: <x>", lambda x: [x, x])),
    ("B85", "K-COVER", "stub", lambda w: w.line(AGP("checker"), "reviewed_head: <sha>", lambda x: ["reviewed: <sha>"])),
    ("B86", "K-HANDOVER", "stub", lambda w: w.sub("tools/subagent_audit.py",
                                                  'return f"line {n} of the block is not a D{n} answer"',
                                                  "return None")),
]


def run_check(w, base, head):
    r = subprocess.run([sys.executable, "-I", os.path.join(HERE, "check.py"), "--repo", w.d, "--base", base,
                        "--head", head], capture_output=True, text=True)
    res = {}
    for line in r.stdout.split("\n"):
        m = re.match(r"CHECK (\S+) \S+ (PASS|FAIL)", line)
        if m:
            res[m.group(1)] = m.group(2)
    return r.returncode, res, r.stdout


def main(argv=None):
    ap = argparse.ArgumentParser(prog="breaks.py")
    ap.add_argument("--repo", required=True)
    ap.add_argument("--base", required=True)
    ap.add_argument("--main", required=True)
    ap.add_argument("--only", nargs="*")
    a = ap.parse_args(argv)
    tmp = tempfile.mkdtemp(prefix="w22-breaks-")
    try:
        d = os.path.join(tmp, "clone")
        subprocess.run(["git", "clone", "-q", "--no-checkout", a.repo, d], check=True)
        w = W(d)
        main_sha = w.git("rev-parse", a.main)
        w.git("checkout", "-q", "--detach", main_sha)
        stub(w)
        stub_sha = w.commit("stub: filled but meaningless")
        rc_m, res_m, _ = run_check(w, a.base, main_sha)
        rc_s, res_s, out_s = run_check(w, a.base, stub_sha)
        ref_ok = rc_m == 1 and all(v == ("FAIL" if k.startswith("A-") else "PASS") for k, v in res_m.items()) and \
            rc_s == 0 and len(res_s) == C.EXPECTED["all"]
        print(f"REFERENCE main {main_sha[:12]}: exit {rc_m}; A checks FAIL, others PASS: "
              f"{all(v == ('FAIL' if k.startswith('A-') else 'PASS') for k, v in res_m.items())}")
        print(f"REFERENCE stub {stub_sha[:12]}: exit {rc_s}; "
              f"{sum(v == 'PASS' for v in res_s.values())}/{len(res_s)} PASS (the filled-but-meaningless head)")
        if rc_s:
            print(out_s)
        run = broke = 0
        for bid, cid, on, fn in BREAKS:
            if a.only and bid not in a.only:
                continue
            run += 1
            w.git("checkout", "-q", "--force", "--detach", main_sha if on == "main" else stub_sha)
            w.git("clean", "-qfdx")
            try:
                fn(w)
            except NotApplicable as e:
                print(f"BREAK {bid} {cid} {on} NOT APPLICABLE {e}")
                continue
            sha = w.commit(f"break {bid}")
            rc, res, _ = run_check(w, a.base, sha)
            ref = res_m if on == "main" else res_s
            others = sorted(k for k, v in res.items() if v == "FAIL" and ref.get(k) == "PASS" and k != cid)
            ok = res.get(cid) == "FAIL"
            broke += ok
            print(f"BREAK {bid} {cid} {on} {'BROKE' if ok else 'NOT SENSITIVE'}"
                  + (f" also: {', '.join(others)}" if others else ""))
        print(f"BREAKS run={run} broke={broke}")
        good = ref_ok and run == broke
        print("W22_BREAKS PASS" if good else "W22_BREAKS FAIL")
        return 0 if good else 1
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


if __name__ == "__main__":
    sys.exit(main())
