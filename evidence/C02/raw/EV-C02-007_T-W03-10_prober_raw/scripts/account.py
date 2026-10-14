# usage: python3 -I account.py <listing json> <migrations dir> <mode: real|any> [<planted json>]
# The account step: for each listed object, the migration file (version, name) whose text (comments removed) creates it.
# 'any' is the break copy: it accepts every object as accounted without looking. With <planted json> (objects known to
# have no migration), the break check reports whether the step flags each of them as unaccounted.
import sys, json, os, re
lst = json.load(open(sys.argv[1])); mdir = sys.argv[2]; mode = sys.argv[3]
planted = json.load(open(sys.argv[4])) if len(sys.argv) > 4 else None
files = sorted(f for f in os.listdir(mdir) if f.endswith(".sql"))
texts = {f: re.sub(r"--[^\n]*", "", open(os.path.join(mdir, f), encoding="utf-8").read()) for f in files}
def creators(obj):
    kind, rest = obj.split(" ", 1)
    q = lambda s: re.escape(s)
    if kind == "schema":
        pat = rf"create\s+schema\s+(if\s+not\s+exists\s+)?{q(rest)}\b"
    elif kind in ("table", "view"):
        pat = (rf"create\s+table\s+(if\s+not\s+exists\s+)?{q(rest)}\b" if kind == "table"
               else rf"create\s+(or\s+replace\s+)?view\s+{q(rest)}\b")
    elif kind == "function":
        name, args = rest.split("(", 1)
        pat = rf"create\s+(or\s+replace\s+)?function\s+{q(name)}\s*\(\s*{q(args[:-1])}\s*\)"
    elif kind == "role":
        pat = rf"create\s+role\s+{q(rest)}\b"
    elif kind == "extension":
        pat = rf"create\s+extension\s+(if\s+not\s+exists\s+)?{q(rest)}\b"
    else:
        return []
    return [f for f in files if re.search(pat, texts[f], re.I)]
PROBE = re.compile(r"probe|token|hash", re.I)
rows, unaccounted = [], []
for o in lst:
    if mode == "any":
        acc = "accepted (break copy: no lookup)"
    else:
        c = creators(o)
        acc = "; ".join(f"{f[:14]} {f[15:-4]}" for f in c) if c else ("there before C02 (default schema)" if o == "schema public" else "NO ACCOUNT")
        if not c and o != "schema public":
            unaccounted.append(o)
    flag = "PROBE-KIND NAME" if PROBE.search(o.split(" ", 1)[1]) else ""
    rows.append((o, acc, flag))
print("| object | migration (version name) | probe-kind name scan |")
print("|---|---|---|")
for o, a, f in rows:
    print(f"| {o} | {a} | {f or '-'} |")
print(f"objects={len(lst)} unaccounted={len(unaccounted)} {unaccounted} probe-kind names={[o for o, a, f in rows if f]}")
print("account step result:", "RED (an object without an account)" if unaccounted else "GREEN (every object accounted)")
if planted is not None:
    caught = [p for p in planted if p in unaccounted]
    print(f"break check on planted objects with no migration: flagged {len(caught)}/{len(planted)} ->",
          "the step catches them" if len(caught) == len(planted) else "FAIL: the step accepts a planted object with no migration")
