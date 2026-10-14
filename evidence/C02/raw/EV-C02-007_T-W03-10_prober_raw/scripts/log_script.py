# usage: python3 -I log_script.py <log> <start line number of '##[group]Run'> <step run text file>
import sys, re
log, start, runf = sys.argv[1], int(sys.argv[2]), sys.argv[3]
lines = open(log, encoding="utf-8").read().split("\n")
assert "##[group]Run " in lines[start - 1], lines[start - 1]
out = []
for l in lines[start:]:
    body = l[29:] if re.match(r"^\d{4}-\d\d-\d\dT[\d:.]+Z ", l) else l
    if body.startswith("\x1b[36;1m"):
        out.append(body[len("\x1b[36;1m"):].removesuffix("\x1b[0m"))
    else:
        break
printed = "\n".join(out)
run = open(runf, encoding="utf-8").read()
print("printed lines:", len(out), " run lines:", run.count("\n"))
print("printed == step run text (trailing newline aside):", printed.rstrip("\n") == run.rstrip("\n"))
import difflib
for d in difflib.unified_diff(run.rstrip("\n").split("\n"), printed.rstrip("\n").split("\n"), "step", "log", lineterm="", n=1):
    print(repr(d))
