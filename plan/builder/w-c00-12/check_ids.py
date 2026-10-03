#!/usr/bin/env python3
"""Consistency check for W-C00-12 revision 3 (self-checks S-2, S-3, S-4 of REVISION_3_INTENT.md).

Run from the repository root: python3 plan/builder/w-c00-12/check_ids.py
Prints IDS OK, or one line per problem followed by IDS FAIL. Reads files only.
"""
import re
import sys
from pathlib import Path

D = Path("plan/builder/w-c00-12")
PIECES = ["02_memory.md", "03_work_model.md", "04_roles.md", "05_continuity.md"]
CITERS = PIECES + ["06_counter_design_comparison.md", "07_mechanism_map.md",
                   "08_oi011_dispositions.md", "11_test_register.md", "12_tranche_plan.md",
                   "13_r-w12-2_dispositions.md"]
TEST_CITERS = PIECES + ["07_mechanism_map.md", "08_oi011_dispositions.md", "12_tranche_plan.md",
                        "13_r-w12-2_dispositions.md"]
RULE = re.compile(r"\b(?:[MWRC]-R\d+a?|H-(?:AL|OWN|REV|BRF|BOOT|CMP|READ|PRB))\b")
TEST = re.compile(r"\bT-(?:M|W|R|C|MAP)\d+[a-z]?\b|\bT-(?:0[1-9]|1\d|2\d)\b|\bT-H\d\b")
# Tests kept from the operating model (section 13), not part of the register.
OM_TESTS = {"T-H1", "T-H2", "T-H3", "T-H4", "T-H5", "T-H6", "T-H7", "T-A1a", "T-A1b", "T-A1c",
            "T-A2", "T-A2r", "T-B1", "T-B1r", "T-E1", "T-E2", "T-D1"}

errors = []


def cells(line):
    return [c.strip() for c in line.strip().strip("|").split("|")]


def norm_status(s):
    s = re.sub(r"[*_]", "", s).strip().lower()
    return s.split()[0] if s else ""


def norm_tranche(s):
    return frozenset(re.findall(r"\bW-C00-06\b|\b1[a-d]?\b|\b[23]\b|existing", s))


reg = Path(D / "11_test_register.md").read_text()
sec1, sec2 = reg.split("## 2. Tests", 1)

# Register section 1: mechanisms.
register = {}
for line in sec1.splitlines():
    if not line.startswith("| "):
        continue
    c = cells(line)
    if len(c) != 8 or not RULE.fullmatch(c[0]):
        continue
    if c[0] in register:
        errors.append(f"register: duplicate row {c[0]}")
    register[c[0]] = c
    for name, val in zip(["ID", "Mechanism", "Status", "T", "Scope", "Basis", "Cost", "Tests"], c):
        if not val:
            errors.append(f"register: {c[0]} has an empty {name} cell (S-4)")

# Register section 2: tests.
tests = set()
for line in sec2.splitlines():
    if not line.startswith("| T-"):
        continue
    c = cells(line)
    ids = [t.strip() for t in c[0].split(",")]
    tests.update(ids)
    if len(c) != 6:
        errors.append(f"register: test row {c[0]} has {len(c)} columns, expected 6")
        continue
    state = c[5].lower()
    if not any(w in state for w in ("retired", "deferred")):
        for name, val in zip(["Mechanism", "Procedure", "PASS only if"], c[1:4]):
            if not val or val == "—":
                errors.append(f"register: test {c[0]} has an empty {name} cell (S-4)")
        if c[4] in ("", "—") and "observation" not in state:
            errors.append(f"register: test {c[0]} has no FAIL condition (S-4)")

# Every test named in a register mechanism row exists.
for rid, c in register.items():
    for t in TEST.findall(c[7]):
        if t not in tests and t not in OM_TESTS:
            errors.append(f"register: {rid} names test {t}, which has no test row")

# Pieces: rule tables agree with the register; no change-list sections.
piece_rules = {}
for name in PIECES:
    text = (D / name).read_text()
    if re.search(r"^## Revision 2", text, re.M):
        errors.append(f"{name}: a '## Revision 2' section remains (S-3)")
    for line in text.splitlines():
        if not line.startswith("| "):
            continue
        c = cells(line)
        if len(c) == 6 and re.fullmatch(r"[MWRC]-R\d+a?", c[0]):
            piece_rules[c[0]] = (name, c)
for rid, (name, c) in piece_rules.items():
    r = register.get(rid)
    if r is None:
        errors.append(f"{name}: rule {rid} has no register row")
        continue
    if norm_status(c[2]) != norm_status(r[2]):
        errors.append(f"{name}: {rid} status '{c[2]}' differs from the register's '{r[2]}'")
    if norm_tranche(c[3]) != norm_tranche(r[3]):
        errors.append(f"{name}: {rid} tranche '{c[3]}' differs from the register's '{r[3]}'")
    for t in TEST.findall(c[5]):
        if t not in tests:
            errors.append(f"{name}: {rid} names test {t}, which has no register test row")
for rid in register:
    if re.fullmatch(r"[MWRC]-R\d+a?", rid) and rid not in piece_rules:
        errors.append(f"register: {rid} is not defined in any piece's rule table")

# Citations resolve (S-2).
for name in CITERS:
    for n, line in enumerate((D / name).read_text().splitlines(), 1):
        for rid in RULE.findall(line):
            if rid not in register:
                errors.append(f"{name}:{n}: {rid} does not resolve to a register row")
for name in TEST_CITERS:
    for n, line in enumerate((D / name).read_text().splitlines(), 1):
        for t in TEST.findall(line):
            if t not in tests and t not in OM_TESTS:
                errors.append(f"{name}:{n}: test {t} does not resolve to a register test row")

# Gates (12 section 2.2): every active test in exactly one gate; every active rule has a test
# in a tranche gate other than "composition" (critic finding 1).
plan = (D / "12_tranche_plan.md").read_text()
gates = {}
gsec = plan.split("### 2.2 Gates", 1)[1].split("### 2.3", 1)[0]
for line in gsec.splitlines():
    c = cells(line) if line.startswith("| ") else []
    if len(c) == 2 and c[0] not in ("Gate", "---"):
        for t in TEST.findall(c[1]):
            gates.setdefault(t, []).append(c[0])
active_tests = set()
for line in sec2.splitlines():
    if line.startswith("| T-"):
        c = cells(line)
        if len(c) == 6 and not any(w in c[5].lower() for w in ("retired", "deferred")):
            active_tests.update(t.strip() for t in c[0].split(","))
for t in sorted(active_tests):
    if len(gates.get(t, [])) != 1:
        errors.append(f"gates: active test {t} is in {len(gates.get(t, []))} gates, expected 1")
for t in gates:
    if t not in active_tests and t not in OM_TESTS:
        errors.append(f"gates: {t} is gated but not an active register test")
for rid, c in register.items():
    if c[2].split()[0].strip("*_").lower() != "active":
        continue
    tg = [g for t in TEST.findall(c[7]) for g in gates.get(t, []) if g != "composition"]
    if c[3] == "existing" and any(t in OM_TESTS for t in TEST.findall(c[7])) and "T-H4" in gates:
        tg = tg or ["existing"]
    if not tg:
        errors.append(f"gates: active rule {rid} has no test in a tranche gate")

# Deferred and retired rules cited as if active (R-W12-2 B-2, condition C2). A table cell, or a
# prose line, that names a deferred or retired rule must say so in the same cell or line. Exempt:
# the rule's own ID in its own row (register section 1, the pieces' rule tables, 12 section 3),
# the register's Basis cells, and deferred or retired test rows, which say so in their State cell. Files that hold history rows (06, 10) are not scanned.
MARK = re.compile(r"deferr|defer|retire|merged|supersed|withdrawn|re-admi", re.I)
inactive = {rid for rid, c in register.items() if norm_status(c[2]) in ("deferred", "retired")}
SCAN = PIECES + ["07_mechanism_map.md", "08_oi011_dispositions.md", "11_test_register.md",
                 "12_tranche_plan.md", "13_r-w12-2_dispositions.md"]
for name in SCAN:
    in_reg_sec1 = name == "11_test_register.md"
    for n, line in enumerate((D / name).read_text().splitlines(), 1):
        if in_reg_sec1 and line.startswith("## 2. Tests"):
            in_reg_sec1 = False
        if line.startswith("| "):
            c = cells(line)
            if RULE.fullmatch(c[0]) and (name in PIECES or in_reg_sec1 or name == "12_tranche_plan.md"):
                # The rule's own row (12 section 3 lists deferred rules, one row each): its own ID
                # is exempt, other IDs in the row are not; the register's Basis cell is history.
                own = c[0]
                if name == "12_tranche_plan.md" or (in_reg_sec1 and len(c) == 8 and MARK.search(c[2])):
                    continue  # the row itself is a deferred or retired rule, stated in its row
                units = c[1:5] + c[6:] if in_reg_sec1 and len(c) == 8 else c[1:]
                for u in units:
                    for rid in (set(RULE.findall(u)) & inactive) - {own}:
                        if not MARK.search(u):
                            errors.append(f"{name}:{n}: {rid} is {norm_status(register[rid][2])} but cited without saying so")
                continue
            if name == "11_test_register.md" and not in_reg_sec1 and len(c) == 6 and MARK.search(c[5]):
                continue  # a deferred or retired test row says so in its State cell
            units = c
        else:
            units = [line]
        for u in units:
            for rid in set(RULE.findall(u)) & inactive:
                if not MARK.search(u):
                    errors.append(f"{name}:{n}: {rid} is {norm_status(register[rid][2])} but cited without saying so")

# A test cited in 08 must not be deferred or retired (08 cites tests as evidence of answers).
test_state = {}
for line in sec2.splitlines():
    if line.startswith("| T-"):
        c = cells(line)
        if len(c) == 6:
            for t in c[0].split(","):
                test_state[t.strip()] = c[5].lower()
for n, line in enumerate((D / "08_oi011_dispositions.md").read_text().splitlines(), 1):
    if not line.startswith("| "):
        continue  # evidence is cited in the table rows; prose reopen triggers may name future tests
    for t in TEST.findall(line):
        st = test_state.get(t, "")
        if "deferred" in st or "retired" in st:
            errors.append(f"08_oi011_dispositions.md:{n}: test {t} is not active but is cited as evidence")

for e in errors:
    print(e)
print(f"rules in register: {len(register)}; rules in pieces: {len(piece_rules)}; tests: {len(tests)}")
print("IDS OK" if not errors else f"IDS FAIL ({len(errors)} problems)")
sys.exit(1 if errors else 0)
