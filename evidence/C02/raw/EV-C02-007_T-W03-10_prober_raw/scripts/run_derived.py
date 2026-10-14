# usage: python3 -I run_derived.py <derived.sql> <out file>
# Sends the derived file's whole text as one query string (psql -c), as a one-statement connection would.
import sys, subprocess, os
sql = open(sys.argv[1], encoding="utf-8").read()
env = {"PATH": "/usr/bin:/bin", "PGHOST": "/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/pg/sock",
       "PGPORT": "54716", "PGUSER": "postgres", "PGDATABASE": "postgres"}
p = subprocess.run(["/usr/bin/psql", "-X", "-q", "-A", "-t", "-c", sql], capture_output=True, text=True, env=env)
open(sys.argv[2], "w", encoding="utf-8").write(p.stdout)
open(sys.argv[2] + ".err", "w", encoding="utf-8").write(p.stderr)
print(f"derived run exit={p.returncode} stdout_lines={len(p.stdout.splitlines())} stderr={p.stderr!r}")
