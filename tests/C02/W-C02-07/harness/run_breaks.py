#!/usr/bin/env python3
"""W-C02-07's break harness (README 5.2; harness/README.md). Python standard library only; run with `python3 -I`.

Synthetic (plan Section 8 item 13): it builds throwaway PostgreSQL clusters of its own, writes only synthetic data into
them, and deletes them. It holds no credential to devos-test or devos and cannot reach either: it accepts no host,
port or connection string, clears every PG* variable from its children's environment, starts its server with TCP
switched off (listen_addresses = '') and connects only through its own abstract-namespace socket, named at random.

For each break patch: (1) positive control: a fresh cluster with supabase/migrations/ applied runs the patch's test
files, each of which must PASS (or, before the build exists, give COULD NOT CHECK); (2) break: a fresh cluster, the
same migrations plus exactly this patch, the same files: the cases that turn bad must equal the patch's expect-red
list, every named file that holds an expected red case must end in FAIL, and every other named file must end as it
did in the positive control (phase C5, CHK-C02-030 C3: a break may leave a named file green, as W-C02-03's B3 and B4
leave one of their two files); (3) restore: a fresh unpatched cluster runs the files again.

W-C02-07's SQL files and programs are staged in tests/C02/W-C02-07/job/ (README 5.1 (c); phase C5, the executor's
decision on CHK-C02-030 C1); a bare name in a patch's header is looked for there first, then in
supabase/migrations/tests/ (W-C02-03's files), so the harness always runs the staged file.

Exit 0: every break shown and every control passed. 1: a break not shown, or a control that failed. 3: could not
check (no build yet, a server that could not start, a refused input). The last line says which.
"""
import argparse
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile

SEP = "\x1f"
OUTCOMES = {"ok", "bad", "could_not_check"}
MARK = re.compile(r"(\S+) (PASS|FAIL|COULD NOT CHECK) \(")
HEADER = re.compile(r"^--\s*w07-break:\s*test=([^;]+);\s*expect-red=(.*)$")
W03 = {  # W-C02-03's breaks (T-W03-06, T-W03-07, "Break attempt"), run with w03.throwaway = 'yes'
    "B1_answers_without_comparing.sql": ["S02", "S03", "S04", "S05", "S06", "S07", "S08", "S09"] + [f"C{i:02d}" for i in range(2, 14)],
    "B2_skips_function_versions.sql": ["S06", "S07", "S08", "S09", "C07"],
    "B3_skips_migrations.sql": ["S02", "S03", "S04", "S05", "S09"],
    "B4_could_not_check_as_clean.sql": [f"C{i:02d}" for i in range(2, 14)],
}
W03_TESTS = ["supabase/migrations/tests/w03_drift_detects.sql", "supabase/migrations/tests/w03_drift_could_not_check.sql"]
STAGED = "tests/C02/W-C02-07/job"  # W-C02-07's staged SQL files and programs (README 5.1 (c))
JOB_DIR = "supabase/migrations/tests"  # the migration job's folder: W-C02-03's files, and the build items' copies


class Refused(Exception):
    pass


def clean_env():
    env = {k: v for k, v in os.environ.items() if not k.startswith("PG") and k not in ("DATABASE_URL",)}
    env["LC_ALL"] = "C"
    return env


def check_sql_file(path):
    text = path.read_text()
    for n, line in enumerate(text.splitlines(), 1):
        if line.lstrip().startswith("\\"):
            raise Refused(f"{path}: line {n} is a psql meta-command (EV-C02-001 section 10)")
    return text


class Cluster:
    def __init__(self, a, label):
        self.a, self.label = a, label
        self.dir = pathlib.Path(tempfile.mkdtemp(prefix="w07h-", dir=a.workdir))
        # A Linux abstract-namespace socket (PostgreSQL 14 and later): no file path, so no path-length limit, and
        # a random name that only this run knows. TCP stays off.
        self.data, self.sock = self.dir / "data", "@" + self.dir.name
        if a.os_user:
            subprocess.run(["chown", "-R", a.os_user, str(self.dir)], check=True)
        self.port = str(a.port)

    def pg(self, prog, *args):
        cmd = [str(pathlib.Path(self.a.pg_bin) / prog), *args]
        if self.a.os_user:
            cmd = ["runuser", "-u", self.a.os_user, "--", *cmd]
        return subprocess.run(cmd, env=clean_env(), capture_output=True, text=True)

    def start(self):
        r = self.pg("initdb", "-D", str(self.data), "-U", "w07_superuser", "--auth=trust", "-E", "UTF8", "--no-locale")
        if r.returncode:
            raise Refused(f"initdb failed: {r.stderr.strip()[-300:]}")
        opts = f"-c listen_addresses='' -k {self.sock} -p {self.port} -c fsync=off"
        r = self.pg("pg_ctl", "-D", str(self.data), "-o", opts, "-w", "-l", str(self.dir / "server.log"), "start")
        if r.returncode:
            raise Refused(f"the throwaway server did not start: {r.stderr.strip()[-300:]}")

    def psql(self, user, db, *args, sql=None):
        cmd = [str(pathlib.Path(self.a.pg_bin) / "psql"), "-X", "-q", "-h", str(self.sock), "-p", self.port, "-U", user,
               "-d", db, "-v", "ON_ERROR_STOP=1", *args]
        return subprocess.run(cmd, env=clean_env(), capture_output=True, text=True, input=sql, timeout=900)

    def setup(self, migrations):
        """Stand-ins for what Supabase supplies (README 5.2), then the migrations as postgres. Never supabase_admin."""
        stand_in = """
            create role anon nologin; create role authenticated nologin; create role authenticator nologin;
            create role service_role nologin;
            create role postgres login nosuperuser createdb createrole;
            grant anon, authenticated, authenticator, service_role to postgres;
            create database w07_throwaway owner postgres;
            alter database w07_throwaway set w07.throwaway = 'yes';
            alter database w07_throwaway set w03.throwaway = 'yes';
        """
        r = self.psql("w07_superuser", "postgres", "-f", "-", sql=stand_in)
        if r.returncode:
            raise Refused(f"stand-ins failed: {r.stderr.strip()[-300:]}")
        r = self.psql("w07_superuser", "w07_throwaway", "-c", """
            create schema extensions authorization postgres;
            do $$ begin create extension if not exists pgcrypto with schema extensions;
                  exception when others then raise notice 'pgcrypto not available'; end $$;
            create schema supabase_migrations authorization postgres;
            create table supabase_migrations.schema_migrations (version text primary key, statements text[], name text);
            alter table supabase_migrations.schema_migrations owner to postgres;
        """)
        if r.returncode:
            raise Refused(f"stand-ins failed: {r.stderr.strip()[-300:]}")
        applied = []
        for f in sorted(p for p in pathlib.Path(migrations).glob("*.sql") if p.is_file()):
            check_sql_file(f)
            r = self.psql("postgres", "w07_throwaway", "-f", str(f))
            if r.returncode:
                raise Refused(f"migration {f.name} failed on the throwaway database: {r.stderr.strip()[-300:]}")
            version, _, name = f.stem.partition("_")
            self.psql("postgres", "w07_throwaway", "-c",
                      f"insert into supabase_migrations.schema_migrations (version, name) values ('{version}', '{name}')")
            applied.append(f.name)
        return applied

    def version(self):
        r = self.psql("postgres", "w07_throwaway", "-A", "-t", "-c", "show server_version")
        return r.stdout.strip()

    def stop(self):
        self.pg("pg_ctl", "-D", str(self.data), "-m", "immediate", "stop")
        shutil.rmtree(self.dir, ignore_errors=True)


def run_program(cl, path):
    """A program the migration job runs (README 5.1 (b); N-255), here on the throwaway database, run as the job runs it:
    its one JSON object on standard input has exactly the four keys, with no endpoint, key or token here; a program
    that declares "# w07-needs-database: yes" among its first ten lines gets this cluster's socket as its libpq
    environment (and the server's bin directory as its PATH), nothing else; any other program gets no environment at
    all (the job's env -i)."""
    try:
        with open(path, encoding="utf-8") as f:
            head = [next(f, "").rstrip("\n") for _ in range(10)]
    except OSError:
        head = []
    env = {}
    if "# w07-needs-database: yes" in head:
        env = {"PGHOST": str(cl.sock), "PGPORT": cl.port, "PGUSER": "postgres", "PGDATABASE": "w07_throwaway",
               "PATH": str(pathlib.Path(cl.a.pg_bin)), "LC_ALL": "C"}
    payload = {"endpoint": None, "apikey": None, "tokens": {}, "revoked_token": None}
    return subprocess.run([sys.executable, "-I", str(path)], env=env, capture_output=True, text=True,
                          input=json.dumps(payload), timeout=5400)


def run_file(cl, path):
    if path.suffix == ".py":
        r = run_program(cl, path)
        lines, marks = r.stdout.splitlines(), MARK.findall(r.stdout)
        split = lambda line: [x.strip() for x in (line.split("\t") if "\t" in line else line.split(" | ", 2))]
    else:
        r = cl.psql("postgres", "w07_throwaway", "-A", "-t", "-F", SEP, "-f", str(path))
        lines, marks = r.stdout.splitlines(), MARK.findall(r.stderr)
        split = lambda line: line.split(SEP)
    cases = {}
    for line in lines:
        parts = split(line)
        if len(parts) == 3 and parts[1] in OUTCOMES:
            cases[parts[0]] = (parts[1], parts[2])
    result = marks[-1][1] if marks else "ERROR"
    return {"file": str(path), "result": result, "cases": cases, "bad": sorted(k.split()[0] for k, v in cases.items() if v[0] == "bad"),
            "tail": "" if marks else (r.stderr or r.stdout).strip()[-400:]}


def phase(a, label, migrations, tests, patch=None):
    cl = Cluster(a, label)
    try:
        cl.start()
        applied = cl.setup(migrations)
        if patch is not None:
            r = cl.psql("postgres", "w07_throwaway", "-f", str(patch))
            if r.returncode:
                return {"label": label, "error": f"the patch failed to apply: {r.stderr.strip()[-300:]}", "version": cl.version()}
        return {"label": label, "version": cl.version(), "migrations": len(applied), "files": [run_file(cl, t) for t in tests]}
    finally:
        cl.stop()


def control_state(ph):
    if "error" in ph:
        return "error"
    res = {f["result"] for f in ph["files"]}
    if res == {"PASS"}:
        return "pass"
    if res <= {"PASS", "COULD NOT CHECK"}:
        return "could_not_check"
    return "fail"


def files_as_shown(pos, brk):
    """CHK-C02-030 C3: under the break, every named file that holds a red case ends in FAIL, and every other named
    file ends as it did in the positive control. The files are in the same order in both phases. A red case is always
    an expected one here, since the caller has already required the red set to equal expect-red."""
    pf, bf = pos.get("files", []), brk.get("files", [])
    if len(pf) != len(bf):
        return False
    for p, b in zip(pf, bf):
        if b["bad"]:
            if b["result"] != "FAIL":
                return False
        elif b["result"] != p["result"]:
            return False
    return True


def parse_patch(path, repo, w03_dir):
    text = check_sql_file(path)
    if "supabase/migrations" in str(path.resolve().relative_to(repo.resolve())) if path.resolve().is_relative_to(repo.resolve()) else False:
        raise Refused(f"{path}: a break patch under supabase/migrations/ would be applied by the migration job")
    if not (("w07.throwaway" in text or "w03.throwaway" in text) and "supabase_admin" in text):
        raise Refused(f"{path}: no guard block (README 5.2)")
    if path.name in W03 and path.parent.resolve() == w03_dir.resolve():
        return [repo / t for t in W03_TESTS], sorted(W03[path.name])
    m = HEADER.match(text.splitlines()[0])
    if not m:
        raise Refused(f"{path}: the first line is not a w07-break header")
    # A bare name is a staged file of tests/C02/W-C02-07/job/, else a file of supabase/migrations/tests/ (README
    # sections 1 and 5.1 (c)), else the canary's own file; a path is from the repository root.
    # A path to a W-C02-07 file under supabase/migrations/tests/ (twelve patches name their file so, from before the
    # staging) means the staged file: the copy there is byte for byte the staged one, or not yet made.
    def resolve(t):
        if t.startswith(JOB_DIR + "/w07_") and t.count("/") == JOB_DIR.count("/") + 1:
            return repo / STAGED / t.rsplit("/", 1)[1]
        if "/" in t:
            return repo / t
        for d in (STAGED, JOB_DIR):
            p = repo / d / t
            if p.is_file():
                return p
        return repo / t
    tests = [resolve(t.strip()) for t in m.group(1).split(",") if t.strip()]
    for t in tests:
        if not t.is_file():
            raise Refused(f"{path}: test file {t} not found")
        if t.suffix == ".py":
            if t.parent.resolve() not in ((repo / STAGED).resolve(), (repo / JOB_DIR).resolve()):
                raise Refused(f"{path}: a program it runs must be one the migration job runs, staged ({STAGED}/) "
                              f"or copied ({JOB_DIR}/)")
        else:
            check_sql_file(t)
    return tests, sorted(x.strip() for x in m.group(2).split(",") if x.strip())


def main():
    here = pathlib.Path(__file__).resolve().parent
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--repo", default=str(here.parents[3]), help="repository root (default: this file's)")
    ap.add_argument("--pg-bin", default=os.environ.get("W07_PG_BIN", "/usr/lib/postgresql/17/bin"))
    ap.add_argument("--migrations", help="migrations directory (default: <repo>/supabase/migrations)")
    ap.add_argument("--patch", action="append", default=[], help="a patch file; repeatable (default: every Group's breaks/*.sql)")
    ap.add_argument("--w03", action="store_true", help="also run W-C02-03's breaks B1 to B4")
    ap.add_argument("--canary", action="store_true", help="run only the harness's own canary (no build needed)")
    ap.add_argument("--expected-major", default="17", help="the projects' major version; results on another count as self-checks only")
    ap.add_argument("--os-user", help="when run as root: the OS user that runs initdb and the server")
    ap.add_argument("--workdir", default=tempfile.gettempdir())
    ap.add_argument("--port", default=54329, type=int)
    a = ap.parse_args()
    repo = pathlib.Path(a.repo)
    w03_dir = repo / "tests/C02/W-C02-03/breaks"
    try:
        if os.geteuid() == 0 and not a.os_user:
            raise Refused("run as root without --os-user: initdb refuses root")
        if not (pathlib.Path(a.pg_bin) / "initdb").exists():
            raise Refused(f"no PostgreSQL binaries in {a.pg_bin}")
        if a.canary:
            migrations, patches = here / "canary" / "migrations", [here / "canary" / "B-CANARY-1_check_dropped.sql"]
            repo = here / "canary"
        else:
            migrations = pathlib.Path(a.migrations) if a.migrations else repo / "supabase/migrations"
            patches = [pathlib.Path(p) for p in a.patch] or sorted((repo / "tests/C02/W-C02-07/breaks").glob("B-*.sql"))
            if a.w03:
                patches += [w03_dir / n for n in sorted(W03)]
        plan = [(p, *parse_patch(p, repo, w03_dir)) for p in patches]
    except Refused as e:
        print(f"HARNESS COULD NOT CHECK (refused: {e})")
        sys.exit(3)
    summary = []
    for patch, tests, expect in plan:
        try:
            pos = phase(a, "positive control", migrations, tests)
            brk = phase(a, "break", migrations, tests, patch)
            res = phase(a, "restore", migrations, tests)
        except (Refused, subprocess.TimeoutExpired) as e:
            summary.append({"patch": patch.name, "verdict": "could not check", "why": str(e)})
            print(json.dumps(summary[-1]))
            continue
        red = sorted({c for f in brk.get("files", []) for c in f["bad"]})
        pos_s, res_s = control_state(pos), control_state(res)
        if pos_s == "could_not_check" or res_s == "could_not_check":
            verdict = "could not check (the unpatched run gave COULD NOT CHECK)"
        elif "error" in brk:
            verdict = "not shown (" + brk["error"] + ")"
        elif pos_s != "pass" or res_s != "pass":
            verdict = "control failed"
        elif red == expect and red and files_as_shown(pos, brk):
            verdict = "shown"
        else:
            verdict = "not shown"
        counts = pos.get("version", "").split(".")[0] == a.expected_major
        summary.append({"patch": patch.name, "verdict": verdict, "expect_red": expect, "red": red,
                        "positive_control": pos_s, "restore": res_s, "server_version": pos.get("version"),
                        "counts": "yes" if counts else f"no: self-check on {pos.get('version')}, not the projects' {a.expected_major}",
                        "files": {ph["label"]: [{k: f[k] for k in ("file", "result", "bad", "tail")} for f in ph.get("files", [])]
                                  for ph in (pos, brk, res)}})
        print(json.dumps(summary[-1]))
    shown = sum(s["verdict"] == "shown" for s in summary)
    cnc = sum(s["verdict"].startswith("could not check") for s in summary)
    if shown == len(summary):
        print(f"HARNESS PASS ({shown}/{len(summary)} breaks shown)")
        sys.exit(0)
    if shown + cnc == len(summary):
        print(f"HARNESS COULD NOT CHECK ({cnc} of {len(summary)} could not be checked, {shown} shown)")
        sys.exit(3)
    print(f"HARNESS FAIL ({len(summary) - shown - cnc} of {len(summary)} not shown or failed its control)")
    sys.exit(1)


if __name__ == "__main__":
    main()
