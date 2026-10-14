# usage: python3 -I derive.py <listing.sql> <lists.txt> <derived file> <out mechanically derived>
# Applies only the changes the derived file's header names, then compares with the derived file's non-comment body.
import sys, ast
src, lists, derived, out = sys.argv[1:5]
vals = {}
for ln in open(lists, encoding="utf-8"):
    k, v = ln.rstrip("\n").split("=", 1)
    vals[k] = ast.literal_eval(v)
lines = open(src, encoding="utf-8").read().split("\n")
drop = {"\\set ON_ERROR_STOP on", "begin transaction isolation level repeatable read, read only;",
        "\\echo W03LISTING :w03_listing", "commit;"}
kept = [l for l in lines if l not in drop]
print("lines removed:", [l for l in lines if l in drop])
text = "\n".join(kept)
n_gset = text.count(" \\gset")
text = text.replace(")::text as w03_listing \\gset", ")::text as w03_listing;")
print("gset occurrences:", n_gset)
for var, key in (("ex_schemas", "W03_EXCLUDED_SCHEMAS"), ("entry_only", "W03_SCHEMA_ENTRY_ONLY"), ("ex_roles", "W03_EXCLUDED_ROLES")):
    assert "'" not in vals[key]
    print(f":'{var}' occurrences:", text.count(f":'{var}'"))
    text = text.replace(f":'{var}'", "'" + vals[key] + "'")
print("remaining backslashes:", text.count("\\"), " remaining psql vars:", text.count(":'"))
open(out, "w", encoding="utf-8").write(text)
d = open(derived, encoding="utf-8").read()
body = "\n".join(l for l in d.split("\n") if not l.startswith("--"))
print("derived header lines:", sum(1 for l in d.split("\n") if l.startswith("--")))
print("mechanical == derived body:", text == body)
if text != body:
    import difflib
    sys.stdout.writelines(difflib.unified_diff(text.splitlines(True), body.splitlines(True), "mechanical", "derived"))
