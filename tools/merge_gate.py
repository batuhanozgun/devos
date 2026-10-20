#!/usr/bin/env python3
"""merge_gate.py: the merge gate that guard rule M7 runs before every merge (D-010; PC-06;
plan/Installation_Working_Order.md; W-C02-24 M1b).

Usage, from the repository root: python3 tools/merge_gate.py --pr N --head SHA
                             or: python3 tools/merge_gate.py --items REV   (the listing below; reads only)

It fetches main and the pull request's head from origin; the head must be SHA (40 characters). A head whose
diff from its merge base with main is class normal passes, unless it touches what an open item declares (the writes:
rule below) and is not records-only. Any other head passes only when the pull request adds or changes a checker
verdict file evidence/<stage>/checks/CHK-<stage>-<nnn>.md that covers it: its front matter names in reviewed_head the
head, or a commit X of this pull request (an ancestor of the head, not an ancestor of the merge base) with X..head
class normal; it has verdict PASS or PASS-WITH-CONDITIONS; it repeats no key; it carries REQUIRED_KEYS, each in its
grammar (W-C02-24 B1; the reason IDs in square brackets are tools/test_merge_gate.py's REASONS); and it meets the
rules below. Anything else fails closed, with the reason.

Class high: .claude/**, tools/**, .github/workflows/**, methods/**, supabase/migrations/**, supabase/functions/**,
pipelines/**, tests/C02/W-C02-07/shared/** (the token formats guard rule L4 reads at every call; N-270), CLAUDE.md, .gitattributes, plan/Installation_Working_Order.md (successor of the retired
plan/Builder_Operating_Model.md), plan/Ek_A_Rol_Sozlesmeleri.md, plan/Ek_D_Dusunme_Protokolleri.md and
.github/CODEOWNERS; any path whose file name is CLAUDE.md or that has a .claude/ component; a file or symbolic link
at the path methods, pipelines, supabase, supabase/migrations, supabase/functions, .github or .github/workflows, or
named .claude at any depth (it would redirect the listed paths below it); deleting a plan/work/*.md file, or
changing or removing an existing <!-- acceptance --> block or an existing whole-line <!-- approach --> block in one
(adding a block where none existed is class normal). A change to .claude/hooks/owned_ids.txt that only adds recorder
lines (session_... or trig_...) is class normal. Plan 6.7's high-impact path list (PC-08) is among these paths; case
(28) of tools/test_merge_gate.py checks that against the plan.

The verdict's rules (W-C02-24 M1b; working order sections 9 and 10):
- The revert route, evaluated first: item: revert <sha> covers the head when <sha> is a merge commit on origin/main
  and the inverse of <sha> against its first parent, applied to origin/main (git merge-tree), gives exactly the head's
  tree, the pull request's verdict files aside. A conflict refuses (R-CONFLICT): that is the route's limit. The route
  needs no producer_run, floor or own_breaks, and the writes: rule does not apply to it.
- Condition lines between the whole-line markers <!-- conditions --> and <!-- /conditions -->:
  C<n> · type: <defect | missing evidence | preference | scope conflict> · blocks: <producer task | merge |
  acceptance | none> · closure: <diff-confirmed | scoped re-review | full fresh check> · <text>. A defect or missing
  evidence blocks something, a preference or scope conflict blocks none. A column-0 C<n> · type: line outside the
  markers refuses. A verdict with a blocks: merge line covers only when each such line's closure is diff-confirmed,
  reviewed_head..head changes a path other than the verdict files, and that range is class normal.
- producer_run: none only for a revert, stage or branch verdict. A head touching FLOOR_PATHS needs a floor class and
  own_breaks that are not none.
- The writes: rule. Each item's state and its approach block's writes: line are read at the merge base, never at the
  head (closed: declined, cancelled, or accepted with accepted_by an evidence/ file, as tools/records.py reads it).
  A path an open item's writes: lists needs a verdict whose item: lists it too; a head that touches the file of an
  open item whose writes: does not parse (or that WRITES_EXEMPT lists) needs a verdict whose item: is that item. A
  records-only head (every path class normal and under RECORD_PREFIXES or RECORD_FILES) needs no verdict.
The gate reads a verdict's form, not its origin: whether a diff-confirmed closure was made, and whether the checker
ran tools/subagent_audit.py launch and calls for producer_run, are the binding checker's (working order section 10).

--items REV prints one line per plan/work/*.md at REV: "ITEM <path> <open|closed> writes=<none|ok|unparsed|exempt>"
and, for unparsed or exempt, the reason; it exits 0.

Output: reason lines, then GATE PASS (exit 0) or GATE FAIL (exit 1); GATE ERROR (exit 2) when it cannot run.
"""
import argparse
import difflib
import os
import re
import subprocess
import sys

sys.dont_write_bytecode = True

HIGH_PREFIXES = (".claude/", "tools/", ".github/workflows/", "methods/", "supabase/migrations/", "supabase/functions/",
                 "pipelines/", "tests/C02/W-C02-07/shared/")   # the last: the token formats guard rule L4 reads (N-270)
HIGH_FILES = {"CLAUDE.md", ".gitattributes", "plan/Installation_Working_Order.md", "plan/Ek_A_Rol_Sozlesmeleri.md",
              "plan/Ek_D_Dusunme_Protokolleri.md", ".github/CODEOWNERS"}
# A file or symbolic link standing at one of these paths (a listed directory or its parent) redirects what the list
# names below it while no listed path is in the diff; so does one named .claude at any depth.
HIGH_DIR_PATHS = {"methods", "pipelines", "supabase", "supabase/migrations", "supabase/functions", ".github",
                  ".github/workflows"}
OWNED = ".claude/hooks/owned_ids.txt"
ACC_OPEN, ACC_CLOSE = "<!-- acceptance -->", "<!-- /acceptance -->"
APP_OPEN, APP_CLOSE = "<!-- approach -->", "<!-- /approach -->"          # whole lines (as guard rule T5 reads them)
COND_OPEN, COND_CLOSE = "<!-- conditions -->", "<!-- /conditions -->"    # whole lines
RECORDER_LINE = re.compile(r"(session|trig)_[A-Za-z0-9]+")
VERDICT_PATH = re.compile(r"evidence/([^/]+)/checks/CHK-\1-\d{3,}\.md")
SHA40 = re.compile(r"[0-9a-f]{40}")
COVERING = {"PASS", "PASS-WITH-CONDITIONS"}
# W-C02-23 (SB-COR 2.3): every input of tools/check_role_packages.py; a prefix ends with "/". W-C02-25 adds its agent
# hooks, whose start hook delivers the packages.
ROLE_PACKAGE_TRIGGER = (".claude/roles/", ".claude/hooks/reread_after_compact.py", "tools/check_role_packages.py",
                        ".claude/hooks/agent_hooks.py")

# W-C02-24 M1b. The binding template's front-matter keys, in order: one list with .claude/agents/checker.md and the
# working order's section 9 (tools/test_merge_gate.py compares the three).
VERDICT_KEYS = ("id", "target", "item", "reviewed_head", "verdict", "conditions", "independence", "checker_run", "date",
                "take_up", "triage", "floor", "own_breaks", "shared_with_producer", "producer_run", "package", "nonce",
                "read", "relied_on", "unsure", "for", "received_returned", "guard_denials")
REQUIRED_KEYS = ("reviewed_head", "verdict", "conditions", "independence", "checker_run", "item", "triage", "floor",
                 "own_breaks", "shared_with_producer", "producer_run")             # the keys the gate reads
REVERT_OPTIONAL = ("producer_run", "floor", "own_breaks")                          # the revert route needs none of them
FLOOR_PATHS = (".claude/hooks/", ".claude/settings.json", ".github/workflows/", "supabase/migrations/", "tools/")
FLOOR_CLASSES = ("guard", "merge gate", "leak check", "CI gate", "migration", "schema rules", "test oracle", "hook")
RECORD_PREFIXES, RECORD_FILES = ("plan/", "evidence/"), {"DURUM.md"}
# Open items whose writes: line does not parse and stays as written, with the reason; the gate treats each as an
# unparsed line (a head touching its file needs a verdict naming it). CHK-C02-142 F6.
WRITES_EXEMPT = {"W-C02-22": "its build merged before the writes: grammar; its line is the agreed approach's prose, "
                             "kept as agreed (CHK-C02-142 F6)"}

ITEM_ID = re.compile(r"W-C\d{2}-\d{2}(?:\.\d+)?")
NONE_REASON = re.compile(r"none[:, ]\s*\S.*")
TRIAGE_PATH = re.compile(r"(evidence/C\d\d/[A-Za-z0-9_.-]+\.md)(?:[\s,;:].*)?")
FLOOR_ITEM = re.compile(r"(guard|merge gate|leak check|ci gate|migration|schema rules|test oracle|hook)s?(\s*\(.*\))?",
                        re.I | re.S)
RECORD_ID = re.compile(r"(?<![A-Za-z0-9])(?:EV-C\d\d-\d{3,}|CHK-C\d\d-\d{3,}|N-\d+|L-\d+)(?!\d)")
REPO_PATH = re.compile(r"(?:^|[\s(])(?:[\w.-]+/)+(?:[\w.-]*\.[A-Za-z0-9]+)?(?=$|[\s,;:)])")
AGENT_ID = re.compile(r"a[0-9a-f]{16}")
WRITES_PART = re.compile(r"[A-Za-z0-9_.@+-]+(?:/[A-Za-z0-9_.@+-]+)*/?")
COND_LINE = re.compile(r"C\d+ · type: (defect|missing evidence|preference|scope conflict) · blocks: "
                       r"(producer task|merge|acceptance|none) · closure: "
                       r"(diff-confirmed|scoped re-review|full fresh check) · \S.*")
COND_START = re.compile(r"C\d+ · type:")


class GateError(Exception):
    pass


def git(*args, ok=False):
    """stdout of a git command; None on failure when ok, otherwise GateError."""
    r = subprocess.run(["git", *args], capture_output=True, text=True)
    if r.returncode:
        if ok:
            return None
        raise GateError(f"git {' '.join(args)[:100]}: {r.stderr.strip()[:200]}")
    return r.stdout


def show(rev, path):
    r = subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True)
    return "" if r.returncode else r.stdout


def exists(rev, path, kind=None):
    """True when rev holds path (of the object type kind, when given)."""
    r = subprocess.run(["git", "cat-file", "-t", f"{rev}:{path}"], capture_output=True, text=True)
    return r.returncode == 0 and (kind is None or r.stdout.strip() == kind)


def changed(base, head):
    return [p for p in git("diff", "--name-only", "-z", "--no-renames", base, head).split("\0") if p]


def recorder_only(old, new):
    """True when new differs from old only by added recorder lines."""
    a, b = old.splitlines(), new.splitlines()
    return all(t == "equal" or (t == "insert" and all(RECORDER_LINE.fullmatch(x.strip()) for x in b[j1:j2]))
               for t, _, _, j1, j2 in difflib.SequenceMatcher(None, a, b, autojunk=False).get_opcodes())


def acceptance_blocks(text):
    """The text of each <!-- acceptance --> block, in order (an unclosed block runs to the end of the file)."""
    return [part.split(ACC_CLOSE)[0] for part in text.split(ACC_OPEN)[1:]]


def approach_blocks(text):
    """The lines of each approach block between whole-line markers, in order (an unclosed one runs to the end and is
    marked so); a marker inside a sentence is not read."""
    out, cur = [], None
    for line in text.split("\n"):
        if cur is None:
            if line == APP_OPEN:
                cur = []
        elif line == APP_CLOSE:
            out.append(cur)
            cur = None
        else:
            cur.append(line)
    return out + ([cur + ["\0unclosed"]] if cur is not None else [])


def high_paths(base, head):
    """The class-high paths that base..head touches; empty means class normal."""
    out = []
    for p in changed(base, head):
        parts = p.split("/")
        if p == OWNED:
            if not recorder_only(show(base, p), show(head, p)):
                out.append(f"{p} (not only added recorder lines)")
        elif (p.startswith(HIGH_PREFIXES) or p in HIGH_FILES or parts[-1] == "CLAUDE.md" or ".claude" in parts[:-1]
              or p in HIGH_DIR_PATHS or parts[-1] == ".claude"):
            out.append(p)
        elif p.startswith("plan/work/") and p.endswith(".md"):
            old_text = show(base, p)
            if git("cat-file", "-e", f"{head}:{p}", ok=True) is None:
                out.append(f"{p} (work item file deleted)")
            elif acceptance_blocks(old_text) and acceptance_blocks(show(head, p)) != acceptance_blocks(old_text):
                out.append(f"{p} (an existing acceptance block changed or removed)")
            elif approach_blocks(old_text) and approach_blocks(show(head, p)) != approach_blocks(old_text):
                out.append(f"{p} (an existing approach block changed or removed)")
    return out


def front(text):
    """The top-level `key: value` lines of the front matter (quotes stripped); None when there is none or when a
    key repeats (fail closed: which occurrence counts would be ambiguous)."""
    if not text.startswith("---\n") or "\n---" not in text[3:]:
        return None
    meta = {}
    for line in text[4:text.index("\n---", 3)].splitlines():
        m = re.match(r"([a-z_]+):(.*)", line)
        if m:
            if m.group(1) in meta:
                return None
            meta[m.group(1)] = m.group(2).strip().strip("\"'")
    return meta


def unquote(value):
    v = value.strip()
    return v[1:-1].strip() if len(v) >= 2 and v[0] == v[-1] and v[0] in "\"'" else v


def verdict_front(text):
    """(keys, body) of a verdict file: each top-level key with the list of its values, a value wrapped in quotes read
    without them; (None, None) when there is no front matter."""
    if not text.startswith("---\n") or "\n---" not in text[3:]:
        return None, None
    end = text.index("\n---", 3)
    keys = {}
    for line in text[4:end].splitlines():
        m = re.match(r"([a-z_]+):(.*)", line)
        if m:
            keys.setdefault(m.group(1), []).append(unquote(m.group(2)))
    rest = text[end + 4:]
    return keys, rest.split("\n", 1)[1] if "\n" in rest else ""


# ---------------------------------------------------------------- items and their writes: lines (B5)

def writes_of(text, iid):
    """(form, paths, note): form none (no approach block), ok, or unparsed; paths the parsed writes: parts."""
    blocks = approach_blocks(text)
    if not blocks:
        return "none", [], ""
    if len(blocks) > 1:
        return "unparsed", [], "more than one approach block"
    lines = [x for x in blocks[0] if x.startswith("writes:")]
    if len(lines) != 1:
        return "unparsed", [], f"{len(lines)} writes: lines in the approach block"
    value = lines[0][len("writes:"):].strip()
    if value == "none":
        return "ok", [], ""
    parts = value.split("; ")
    for part in parts:
        if not WRITES_PART.fullmatch(part) or {".", ".."} & set(part.rstrip("/").split("/")):
            return "unparsed", [], "not \"; \"-separated repository paths or dir/ prefixes"
        if part == f"plan/work/{iid}.md":
            return "unparsed", [], "it lists the item's own file"
    return "ok", parts, ""


def item_closed(meta, rev):
    """tools/records.py's is_closed, read at rev: declined, cancelled, or accepted with accepted_by naming a file under
    evidence/. An item without readable front matter (or with a repeated key) counts as open."""
    if meta is None:
        return False
    if meta.get("admission") == "declined" or meta.get("execution") == "cancelled":
        return True
    ab = meta.get("accepted_by", "")
    return meta.get("acceptance") == "accepted" and ab.startswith("evidence/") and exists(rev, ab, "blob")


def read_items(rev):
    """{item id: (path, open, form, paths, note)} for each plan/work/*.md at rev."""
    out = {}
    for p in git("ls-tree", "-z", "--name-only", rev, "plan/work/").split("\0"):
        if not re.fullmatch(r"plan/work/[^/]+\.md", p):
            continue
        iid, text = p[len("plan/work/"):-len(".md")], show(rev, p)
        form, paths, note = writes_of(text, iid)
        if form == "unparsed" and iid in WRITES_EXEMPT:
            form, note = "exempt", WRITES_EXEMPT[iid]
        out[iid] = (p, not item_closed(front(text), rev), form, paths, note)
    return out


def listers(items, path):
    """The open items whose parsed writes: lists path (a literal path, or a dir/ prefix of it)."""
    return sorted(i for i, (_, is_open, _, paths, _) in items.items() if is_open and
                  any(path == w or (w.endswith("/") and path.startswith(w)) for w in paths))


def unparsed_touched(items, touched):
    """The open items whose writes: does not parse (or is exempt) and whose own file the head touches."""
    return sorted(i for i, (p, is_open, form, _, _) in items.items() if is_open and form in ("unparsed", "exempt")
                  and p in touched)


def items_listing(rev):
    if git("rev-parse", "--verify", "-q", f"{rev}^{{commit}}", ok=True) is None:
        raise GateError(f"{rev!r} is not a commit here")
    for iid, (p, is_open, form, _, note) in sorted(read_items(rev).items(), key=lambda kv: kv[1][0]):
        print(f"ITEM {p} {'open' if is_open else 'closed'} writes={form}" + (f" {note}" if note else ""))
    return 0


# ---------------------------------------------------------------- the verdict's keys, conditions and routes

def item_kind(value):
    """("item", id) | ("stage", v) | ("branch", v) | ("revert", sha) | None."""
    if ITEM_ID.fullmatch(value):
        return "item", value
    if re.fullmatch(r"stage C\d{2}", value):
        return "stage", value
    if re.fullmatch(r"branch SB-[A-Z0-9-]+", value):
        return "branch", value
    if re.fullmatch(r"revert [0-9a-f]{40}", value):
        return "revert", value[len("revert "):]
    return None


def floor_ok(value):
    """B1's floor: grammar: none and a reason, or classes split at ";" or "," outside parentheses, each optionally
    followed by one balanced parenthesis."""
    if NONE_REASON.fullmatch(value):
        return True
    parts, cur, depth = [], "", 0
    for ch in value:
        depth += (ch == "(") - (ch == ")")
        if depth < 0:
            return False
        if ch in ";," and depth == 0:
            parts.append(cur)
            cur = ""
        else:
            cur += ch
    if depth:
        return False
    for part in parts + [cur]:
        m = FLOOR_ITEM.fullmatch(part.strip())
        if not m:
            return False
        if m.group(2):
            paren, d = m.group(2).strip(), 0
            for i, ch in enumerate(paren):
                d += (ch == "(") - (ch == ")")
                if d == 0 and i != len(paren) - 1:
                    return False                     # one parenthesis only, and nothing after it
    return True


def shared_ok(value):
    return value == "none" or bool(RECORD_ID.search(value) or REPO_PATH.search(value))


def key_problems(v, kind, base, head):
    """The grammar problems of B1's keys and conditions: (reason lines)."""
    out = []
    if kind is None:
        out.append(f"[K-FORM-item] item: {v['item'][:80]!r} is not W-C<dd>-<dd>[.<n>], stage C<dd>, branch "
                   "SB-<NAME> or revert <40 lowercase hex>")
    elif kind[0] == "item" and not exists(base, f"plan/work/{kind[1]}.md"):
        out.append(f"[K-ITEMFILE] item: plan/work/{kind[1]}.md is not at the merge base {base[:12]}")
    t = v["triage"]
    m = TRIAGE_PATH.fullmatch(t)
    if m and not exists(head, m.group(1)):
        out.append(f"[K-TRIAGEPATH] triage: {m.group(1)} is not at the head")
    elif not m and not NONE_REASON.fullmatch(t):
        out.append(f"[K-FORM-triage] triage: {t[:80]!r} is neither an evidence/C<dd>/<name>.md path (then text) nor "
                   "none, then \":\", \",\" or a space and a reason")
    if v.get("floor") and not floor_ok(v["floor"]):
        out.append(f"[K-FORM-floor] floor: {v['floor'][:80]!r} is neither none and a reason nor a list (\";\" or \",\") "
                   f"of the floor classes {', '.join(FLOOR_CLASSES)}, each optionally followed by one parenthesis "
                   "that holds its paths and any other part")
    if not shared_ok(v["shared_with_producer"]):
        out.append(f"[K-FORM-shared_with_producer] shared_with_producer: {v['shared_with_producer'][:80]!r} is neither "
                   "none nor text naming a record by a repository path or an EV-, CHK-, N- or L- ID")
    if v.get("producer_run") and v["producer_run"] != "none" and not AGENT_ID.fullmatch(v["producer_run"]):
        out.append(f"[K-FORM-producer_run] producer_run: {v['producer_run'][:80]!r} is neither an agent ID "
                   "a<16 lowercase hex> nor none")
    if v["conditions"] not in ("none", "see markers"):
        out.append(f"[K-FORM-conditions] conditions: {v['conditions'][:80]!r} is neither none nor see markers")
    return out


def condition_lines(body):
    """(lines, problems): the (type, blocks, closure) of each line between the markers, and the reason lines."""
    lines, out, inside = [], [], False
    for n, line in enumerate(body.split("\n"), 1):
        if line.rstrip() in (COND_OPEN, COND_CLOSE):
            if (line.rstrip() == COND_OPEN) == inside:
                out.append(f"[C-FORM] body line {n}: a conditions marker out of order")
            inside = line.rstrip() == COND_OPEN
        elif inside and line.strip():
            m = COND_LINE.fullmatch(line.rstrip())
            if not m:
                out.append(f"[C-FORM] body line {n} between the markers does not parse as C<n> · type: <defect | "
                           "missing evidence | preference | scope conflict> · blocks: <producer task | merge | "
                           "acceptance | none> · closure: <diff-confirmed | scoped re-review | full fresh check> · <text>")
                continue
            t, b, c = m.groups()
            if (t in ("defect", "missing evidence")) == (b == "none"):
                out.append(f"[C-CONTRA] body line {n}: type {t} with blocks: {b} (a defect or missing evidence blocks "
                           "something; a preference or scope conflict blocks none)")
            lines.append((t, b, c))
        elif not inside and COND_START.match(line):
            out.append(f"[C-OUTSIDE] body line {n}: a condition line at column 0 outside the conditions markers")
    if inside:
        out.append("[C-FORM] the conditions markers are not closed")
    return lines, out


def revert_route(sha, head, in_pr):
    """None when the head is exactly the inverse of merge commit sha applied to origin/main; else the reason."""
    main = "refs/remotes/origin/main"
    if git("cat-file", "-e", f"{sha}^{{commit}}", ok=True) is None or \
            git("merge-base", "--is-ancestor", sha, main, ok=True) is None:
        return f"[R-NOTMAIN] revert {sha[:12]}: not a commit on origin/main"
    parents = git("rev-list", "--parents", "-n", "1", sha).split()
    if len(parents) < 3:
        return f"[R-NOTMERGE] revert {sha[:12]}: not a merge commit"
    r = subprocess.run(["git", "merge-tree", "--write-tree", f"--merge-base={sha}", main, parents[1]],
                       capture_output=True, text=True)
    if r.returncode == 1:
        return (f"[R-CONFLICT] revert {sha[:12]}: its inverse conflicts with origin/main; the revert route's limit: a "
                "revert that conflicts with later changes is not judged by its tree and needs an ordinary verdict")
    if r.returncode:
        raise GateError(f"git merge-tree for revert {sha[:12]}: {r.stderr.strip()[:200]}")
    tree = r.stdout.split("\n", 1)[0].strip()
    extra = [p for p in changed(tree, head) if not (VERDICT_PATH.fullmatch(p) and p in in_pr)]
    if extra:
        return (f"[R-TREE] revert {sha[:12]}: the inverse applied to origin/main differs from the head's tree in "
                + ", ".join(extra[:4]) + (" ..." if len(extra) > 4 else ""))
    return None


def judge(vf, head, base, in_pr, items):
    """(problems, how): why the verdict file vf does not cover the head, or how it covers it."""
    keys, body = verdict_front(show(head, vf))
    if keys is None:
        return ["[K-FRONT] no front matter"], None
    rep = [k for k, vals in keys.items() if len(vals) > 1]
    if rep:
        return [f"[K-REPEAT-{k}] a key repeats: {k}" for k in rep], None
    v = {k: vals[0] for k, vals in keys.items()}
    kind = item_kind(v.get("item", ""))
    revert = kind is not None and kind[0] == "revert"
    absent = [k for k in REQUIRED_KEYS if not v.get(k) and not (revert and k in REVERT_OPTIONAL)]
    if absent:
        return [f"[K-ABSENT-{k}] the {k} field is missing" for k in absent], None
    if v["verdict"] not in COVERING:
        return [f"[V-VERDICT] verdict {v['verdict']!r} is not PASS or PASS-WITH-CONDITIONS"], None
    conds, cprob = condition_lines(body)
    merge_open = any(b == "merge" for _, b, _ in conds)
    x = v["reviewed_head"]
    if not SHA40.fullmatch(x):
        return [f"[V-HEAD] reviewed_head {x!r} is not a full 40-character SHA"], None
    if x != head and git("merge-base", "--is-ancestor", x, head, ok=True) is None:
        return [f"[V-HEAD] reviewed_head {x[:12]} is neither the head nor an ancestor of it"], None
    if git("merge-base", "--is-ancestor", x, base, ok=True) is not None:
        return [f"[V-HEAD] reviewed_head {x[:12]} is an ancestor of the merge base, not a commit of this pull "
                "request"], None
    if x != head and (hp := high_paths(x, head)):
        return [f"[{'D-HIGHLATER' if merge_open else 'V-LATER'}] {x[:12]}..head touches class-high paths: "
                f"{', '.join(hp[:4])}"], None
    out = key_problems(v, kind, base, head)
    if out:
        return out, None
    out = list(cprob)
    if v["conditions"] == "see markers" and not conds:
        out.append("[C-EMPTY] conditions: see markers, and no well-formed condition line stands between the markers")
    if v["conditions"] == "none" and conds:
        out.append("[C-NONELINES] conditions: none, but condition lines stand between the markers")
    if v["verdict"] == "PASS" and any(b != "none" for _, b, _ in conds):
        out.append("[C-PASSBLOCK] verdict PASS with a blocking condition line")
    if v["verdict"] == "PASS-WITH-CONDITIONS" and v["conditions"] == "none":
        out.append("[C-PWCNONE] verdict PASS-WITH-CONDITIONS with conditions: none")
    if out:
        return out, None
    if merge_open:
        out += [f"[D-CLOSURE] a blocks: merge condition with closure {c}, not diff-confirmed"
                for _, b, c in conds if b == "merge" and c != "diff-confirmed"]
        if not [p for p in changed(x, head) if not (VERDICT_PATH.fullmatch(p) and p in in_pr)]:
            out.append(f"[D-NOLATER] a blocks: merge condition, and nothing but verdict files follows reviewed_head "
                       f"{x[:12]}")
        if out:
            return out, None
    if revert:                                       # the revert route: before producer_run, floor and writes:
        why = revert_route(kind[1], head, in_pr)
        return ([why], None) if why else ([], f"reviewed_head {x[:12]}; the revert route: the inverse of "
                                              f"{kind[1][:12]} on origin/main gives the head's tree")
    touched = changed(base, head)
    if v["producer_run"] == "none" and kind[0] == "item":
        out.append(f"[P-NONE] producer_run: none for item: {kind[1]} (only a revert, stage or branch verdict, or a "
                   "records-only head, has none)")
    floor = [p for p in touched if any(p == f or (f.endswith("/") and p.startswith(f)) for f in FLOOR_PATHS)]
    if floor and NONE_REASON.fullmatch(v["floor"]):
        out.append(f"[F-NONE] floor: none, and the head touches floor paths: {', '.join(floor[:4])}")
    if floor and v["own_breaks"].lower().startswith("none"):
        out.append(f"[F-BREAKS] own_breaks: none, and the head touches floor paths: {', '.join(floor[:4])}")
    own = kind[1] if kind[0] == "item" else None
    for p in touched:
        who = listers(items, p)
        if who and own not in who:
            out.append(f"[W-ITEM] {p} is in the writes: of open item(s) {', '.join(who)} at the merge base, not in "
                       f"that of item: {v['item']}")
    for iid in unparsed_touched(items, set(touched)):
        if own != iid:
            out.append(f"[W-UNPARSED] the head touches plan/work/{iid}.md, whose writes: does not parse or is exempt; "
                       f"only a verdict whose item: is {iid} covers it")
    return out, None if out else f"reviewed_head {x[:12]}"


def cover(head, base, in_pr, items):
    """(verdict file, how, why): the verdict covering head, (None, None) when none does, and why the verdict files
    the pull request adds or changes do not cover it. Only those files count."""
    why = []
    listing = git("ls-tree", "-r", "-z", "--name-only", head, "--", "evidence")
    for vf in sorted(p for p in listing.split("\0") if VERDICT_PATH.fullmatch(p) and p in in_pr):
        problems, how = judge(vf, head, base, in_pr, items)
        if not problems:
            return vf, how, why
        why += [f"{vf}: {p}" for p in problems]
    return None, None, why


def role_packages(base, head):
    """When base..head touches ROLE_PACKAGE_TRIGGER, run this tree's check_role_packages.py (never the head's copy)
    with --rev head, print its lines, and return the reason to refuse on any nonzero exit; otherwise None."""
    if not any(p == t or (t.endswith("/") and p.startswith(t))
               for p in changed(base, head) for t in ROLE_PACKAGE_TRIGGER):
        return None
    tool = os.path.join(os.path.dirname(os.path.abspath(__file__)), "check_role_packages.py")
    r = subprocess.run([sys.executable, "-I", tool, "--rev", head], capture_output=True, text=True, errors="replace")
    for line in (r.stdout + r.stderr).splitlines():
        print(f"  {line}")
    return f"the role-package check refused the head (exit {r.returncode}; tools/check_role_packages.py)" \
        if r.returncode else None


def gate(pr, head):
    """(ok, lines)."""
    if not SHA40.fullmatch(head):
        return False, [f"--head {head!r} is not a full 40-character SHA"]
    if (git("rev-parse", "--is-shallow-repository", ok=True) or "").strip() == "true" and \
            git("fetch", "-q", "--unshallow", "origin", ok=True) is None:
        return False, ["cannot unshallow the repository, so ancestry cannot be checked"]
    if git("fetch", "-q", "origin", "+refs/heads/main:refs/remotes/origin/main", ok=True) is None:
        return False, ["cannot fetch main from origin"]
    if git("fetch", "-q", "origin", f"+refs/pull/{pr}/head:refs/devos-gate/pr-{pr}", ok=True) is None:
        return False, [f"cannot fetch the head of pull request #{pr}"]
    got = git("rev-parse", f"refs/devos-gate/pr-{pr}").strip()
    if got != head:
        return False, [f"pull request #{pr} has head {got}, not the SHA given; the head moved"]
    base = (git("merge-base", "origin/main", head, ok=True) or "").strip()
    if not base:
        return False, [f"{head[:12]} has no merge base with origin/main"]
    refused = role_packages(base, head)
    if refused:
        return False, [refused]
    touched = changed(base, head)
    high = high_paths(base, head)
    items = read_items(base)
    if not high:
        declared = [p for p in touched if listers(items, p)]
        unparsed = unparsed_touched(items, set(touched))
        if all(p.startswith(RECORD_PREFIXES) or p in RECORD_FILES for p in touched) or not (declared or unparsed):
            return True, [f"class normal: {base[:12]}..{head[:12]}"]
        lines = [f"class normal, but not records-only, and it touches what open items declare at the merge base: "
                 + ", ".join((declared + [f"plan/work/{i}.md" for i in unparsed])[:6])]
        vf, how, why = cover(head, base, set(touched), items)
        if vf:
            return True, lines + [f"covered by {vf} ({how})"]
        tail = ([f"[W-NOVERDICT] no covering verdict for the declared paths {', '.join(declared[:4])}"] if declared
                else []) + ([f"[W-UNPARSED] no covering verdict naming {', '.join(unparsed)}"] if unparsed else [])
        return False, lines + why + ["; ".join(tail)]
    lines = ["class high: " + ", ".join(high[:6]) + (" ..." if len(high) > 6 else "")]
    vf, how, why = cover(head, base, set(touched), items)
    if vf:
        return True, lines + [f"covered by {vf} ({how})"]
    return False, lines + why + [
        "no checker verdict file that this pull request adds or changes covers it "
        "(evidence/<stage>/checks/CHK-<stage>-<nnn>.md with reviewed_head the head or a commit X of this pull "
        "request, not an ancestor of the merge base, where X..head is class normal; verdict PASS or "
        "PASS-WITH-CONDITIONS; no repeated key; the keys and rules of W-C02-24 M1b)"]


def main(argv=None):
    ap = argparse.ArgumentParser(prog="merge_gate.py")
    ap.add_argument("--pr", type=int)
    ap.add_argument("--head")
    ap.add_argument("--items", metavar="REV", help="list each plan/work/*.md at REV: state and writes: form")
    a = ap.parse_args(argv)
    if a.items is not None:
        if a.pr is not None or a.head is not None:
            ap.error("--items stands alone")
        try:
            return items_listing(a.items)
        except (GateError, OSError, ValueError) as e:
            print(f"GATE ERROR: {type(e).__name__}: {e}")
            return 2
    if a.pr is None or a.head is None:
        ap.error("--pr and --head are required")
    try:
        ok, lines = gate(a.pr, a.head)
    except (GateError, OSError, ValueError) as e:
        print(f"GATE ERROR: {type(e).__name__}: {e}")
        return 2
    for line in lines[:-1]:
        print(f"  {line}")
    print(f"GATE {'PASS' if ok else 'FAIL'}: PR #{a.pr} head {a.head[:12]}: {lines[-1]}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
