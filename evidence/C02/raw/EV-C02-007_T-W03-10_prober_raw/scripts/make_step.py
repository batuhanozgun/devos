# usage: python3 -I make_step.py <migrate.yml> <job> <workdir> <script out> <mode>
# mode: asis | widened | nothing.  Writes a bash script that runs the job's listing step run text unchanged except
# w="$(mktemp -d)" -> a literal work dir; env: the workflow's three lists (widened mode: extended by the planted names),
# PG* for the throwaway socket, GITHUB_OUTPUT a literal file. 'nothing' mode: the heredoc query gets "where false".
import sys, yaml, shlex
yml, job, wd, out, mode = sys.argv[1:6]
doc = yaml.safe_load(open(yml, encoding="utf-8"))
env = dict(doc["env"])
run = [s for s in doc["jobs"][job]["steps"] if s.get("id") == "listing"][0]["run"]
assert run.count('w="$(mktemp -d)"') == 1
run = run.replace('w="$(mktemp -d)"', 'w=' + shlex.quote(wd))
if mode == "widened":
    env["W03_EXCLUDED_SCHEMAS"] += " w03_fixture_probe"
    env["W03_EXCLUDED_ROLES"] += " w03_fixture_probe_role"
elif mode == "nothing":
    assert run.count("\n) s\n") == 1
    run = run.replace("\n) s\n", "\n) s where false\n")
elif mode != "asis":
    raise SystemExit("bad mode")
sock = "/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/pg/sock"
hdr = [f"export {k}={shlex.quote(env[k])}" for k in ("W03_EXCLUDED_SCHEMAS", "W03_SCHEMA_ENTRY_ONLY", "W03_EXCLUDED_ROLES")]
hdr += [f"export PGHOST={shlex.quote(sock)}", "export PGPORT=54716", "export PGUSER=postgres", "export PGDATABASE=postgres",
        f"export GITHUB_OUTPUT={shlex.quote(wd + '/github_output')}", "mkdir -p " + shlex.quote(wd)]
open(out, "w", encoding="utf-8").write("\n".join(hdr) + "\n" + run)
