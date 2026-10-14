# usage: python3 -I evaluate.py <step workdir> [<derived out>]
# Reads the step's own out/control files (W03LISTING line) and the derived one-row output; prints the lists,
# criterion (ii) [(d) and (e) shown], positive control (i) [auth.users without the exclusion list], and same-list.
import sys, json, os
wd = sys.argv[1]
def w03(name):
    p = os.path.join(wd, name)
    for ln in open(p, encoding="utf-8"):
        if ln.startswith("W03LISTING "):
            return json.loads(ln[len("W03LISTING "):])
    return None
items, control = w03("out"), w03("control")
print("step listing (with exclusion list):", json.dumps(items))
print("step control (without exclusion list): count", None if control is None else len(control),
      "; 'table auth.users' in it:", None if control is None else ("table auth.users" in control))
D = ["schema w03_fixture_probe", "table w03_fixture_probe.token_hashes"]
E = ["role w03_fixture_probe_role"]
if items is not None:
    shown = {x: (x in items) for x in D + E}
    print("criterion (ii) members:", shown)
    print("criterion (ii): (d) and (e) shown ->", "GREEN" if all(shown.values()) else "RED")
if len(sys.argv) > 2:
    raw = open(sys.argv[2], encoding="utf-8").read().strip()
    der = json.loads(raw) if raw else None
    print("derived listing:", json.dumps(der))
    print("same list (derived == step):", der == items)
