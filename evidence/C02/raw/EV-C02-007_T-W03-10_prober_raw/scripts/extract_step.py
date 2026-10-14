# usage: python3 -I extract_step.py <migrate.yml> <outdir> <tag>
# Writes, for each job with a step id 'listing': the step's run text, the heredoc listing.sql (python extraction),
# and a bash snippet that writes listing.sql with bash's own heredoc processing (literal output path).
import sys, os, hashlib, yaml
yml, outdir, tag = sys.argv[1], sys.argv[2], sys.argv[3]
doc = yaml.safe_load(open(yml, encoding="utf-8"))
env = doc.get("env", {})
with open(os.path.join(outdir, f"{tag}_lists.txt"), "w", encoding="utf-8") as f:
    for k in ("W03_EXCLUDED_SCHEMAS", "W03_SCHEMA_ENTRY_ONLY", "W03_EXCLUDED_ROLES"):
        f.write(f"{k}={env.get(k)!r}\n")
        print(f"{tag} {k}={env.get(k)!r}")
start = "cat > \"$w/listing.sql\" <<'SQL'\n"
for job, j in doc["jobs"].items():
    for st in j.get("steps", []):
        if st.get("id") != "listing":
            continue
        run = st["run"]
        p = os.path.join(outdir, f"{tag}_{job}_listing_step_run.txt")
        open(p, "w", encoding="utf-8").write(run)
        i = run.index(start) + len(start)
        k = run.index("\nSQL\n", i)
        sql = run[i:k + 1]
        q = os.path.join(outdir, f"{tag}_{job}_listing.sql")
        open(q, "w", encoding="utf-8").write(sql)
        lit = os.path.join(outdir, f"{tag}_{job}_bash")
        snippet = "set -euo pipefail\n" + run[run.index(start):k + 5].replace("$w", lit) 
        open(os.path.join(outdir, f"{tag}_{job}_heredoc_snippet.sh"), "w", encoding="utf-8").write(snippet)
        print(f"{tag} job={job} step name={st.get('name')!r} if={st.get('if')!r}")
        print(f"  run sha256={hashlib.sha256(run.encode()).hexdigest()} bytes={len(run.encode())}")
        print(f"  listing.sql sha256={hashlib.sha256(sql.encode()).hexdigest()} bytes={len(sql.encode())} lines={sql.count(chr(10))}")
