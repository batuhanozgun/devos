#!/usr/bin/env bash
# Checks that no name of the account's third-party services appears in the tracked tree.
# The names are NOT stored in this repository's current tree: they are derived at run time
# from the display-name deny list in .claude/settings.json at commit 3cd686a (removed later),
# so that this check does not re-publish them (R-C00-BOM-4 B2).
# Usage: tools/check_service_names.sh   -> exit 0 and "SERVICE_NAMES CLEAN" if none found.
set -u
names=$(git show 3cd686a:.claude/settings.json 2>/dev/null | python3 -c '
import json,sys
d=json.load(sys.stdin)["permissions"]["deny"]
out=set()
for n in d:
    n=n.replace("mcp__","")
    for part in n.replace("_-_","_").split("_"):
        if len(part)>=4 and part.lower() not in {"google","claude","career","intelligence","network","analytics","drive","calendar","docs","flow"}:
            out.add(part)
    out.add(n.replace("_"," "))
print("\n".join(sorted(out)))') || { echo "cannot derive names"; exit 2; }
[ -n "$names" ] || { echo "cannot derive names"; exit 2; }
pat=$(printf '%s\n' "$names" | python3 -c 'import re,sys;print("|".join(re.escape(l.strip()) for l in sys.stdin if l.strip()))')
hits=$(git grep -n -i -E "\b($pat)\b" -- . | wc -l)
if [ "$hits" -eq 0 ]; then echo "SERVICE_NAMES CLEAN (pattern derived from 3cd686a; $(printf '%s\n' "$names" | wc -l) terms)"; exit 0; fi
echo "SERVICE_NAMES FOUND in $hits line(s):"; git grep -n -i -E "\b($pat)\b" -- . | cut -d: -f1,2
exit 1
