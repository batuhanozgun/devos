#!/usr/bin/env python3
"""Validate and optionally prepare U04 files in an existing local clone.
No network, credentials, git commit, branch mutation or push. Defaults to dry-run.
Refuses changed current files and pre-existing new targets before any mutation.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import tempfile

BASE = Path(__file__).resolve().parent

def blob(data: bytes) -> str:
    return hashlib.sha1(f'blob {len(data)}\0'.encode()+data).hexdigest()

def below(root: Path, relative: str) -> Path:
    p = root / relative
    resolved = p.resolve()
    if not resolved.is_relative_to(root.resolve()) or p.is_symlink():
        raise ValueError(f'unsafe target: {relative}')
    return p

def replace_one(text: str, old: str, new: str) -> str:
    if text.count(old)!=1:
        raise ValueError(f'expected one exact text marker, found {text.count(old)}: {old[:100]}')
    return text.replace(old,new,1)

def make_plan(repo: Path, manifest: dict) -> dict[str,bytes]:
    # Validate every immutable payload before using it.
    for rel,sha in manifest['payload_sha256'].items():
        if hashlib.sha256(below(BASE,rel).read_bytes()).hexdigest()!=sha:
            raise ValueError('payload changed: '+rel)
    old={}
    for rel,sha in manifest['expected_existing_blobs'].items():
        p=below(repo,rel)
        data=p.read_bytes()
        if blob(data)!=sha:
            raise ValueError(f'canonical target changed: {rel}; reconcile before applying')
        old[rel]=data.decode('utf-8')
    prepared={}
    for src,dst in manifest['copies'].items():
        p=below(repo,dst)
        if dst not in old and p.exists():
            raise ValueError('new target already exists: '+dst)
        prepared[dst]=below(BASE,src).read_bytes()
    prefix='research/studies/hermes-agent/'
    idxpath=prefix+'INDEX.md'; idx=old[idxpath]
    idx=replace_one(idx,'[v0.15](RESEARCH-PLAN.md)','[v0.16](RESEARCH-PLAN.md)')
    marker='| Question | First route |\n|---|---|'
    idx=replace_one(idx,marker,marker+'\n| How do persistent instructions continue, wait, stop and reactivate? | **[synthesis/03](synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md)** → [18/U04](notes/18-MULTITURN-CONTINUATION-AND-REACTIVATION.md) → [SOURCES](evidence/2026-09-11-multiturn/SOURCES.md) |')
    idx=replace_one(idx,'actual Kanban goal-loop/worker continuation, then goal/loop/heartbeat distinctions',
                         'actual SessionDB/state_meta, session migration and host reactivation')
    idx=replace_one(idx,'| Scope rebalance and source inventory |',
        '| Multi-turn continuation, waiting and reactivation | **[18](notes/18-MULTITURN-CONTINUATION-AND-REACTIVATION.md)**, [U04 raw evidence](evidence/2026-09-11-multiturn/evidence/RESULT.json) |\n| Scope rebalance and source inventory |')
    idx=replace_one(idx,'No third completed synthesis, native CORE, four-area projection or architecture/adoption is asserted.',
        'The third synthesis is provisional; final native CORE, four-area projection and architecture/adoption are not complete.')
    prepared[idxpath]=idx.encode()
    catalog='research/studies/CATALOG.md';text=old[catalog]
    rows=[line for line in text.splitlines() if line.startswith('| `hermes-agent` |')]
    if len(rows)!=1: raise ValueError('expected exactly one Hermes catalog row')
    replacement=(BASE/'repo-updates/catalog-row.txt').read_text().strip()
    prepared[catalog]=replace_one(text,rows[0],replacement).encode()
    ledgerpath=prefix+'SOURCE-LEDGER.md';text=old[ledgerpath]
    text=replace_one(text,'/ plan v0.15.','/ plan v0.16.')
    text=replace_one(text,'## Açık bağımlılıklar',(BASE/'repo-updates/ledger-addition.md').read_text()+'## Açık bağımlılıklar')
    prepared[ledgerpath]=text.encode()
    for rel in prepared:
        if not(rel.startswith(prefix) or rel==catalog):
            raise ValueError('mutation exceeds authorized scope: '+rel)
    return prepared

def apply(repo: Path, plan: dict[str,bytes]) -> None:
    # Keep in-memory originals for best-effort rollback of local file replacement.
    old={rel:(below(repo,rel).read_bytes() if below(repo,rel).exists() else None) for rel in plan}
    written=[]
    try:
        for rel,data in plan.items():
            p=below(repo,rel);p.parent.mkdir(parents=True,exist_ok=True)
            with tempfile.NamedTemporaryFile(dir=p.parent,prefix='.u04-',delete=False) as f:
                temp=Path(f.name);f.write(data);f.flush();os.fsync(f.fileno())
            os.replace(temp,p);written.append(rel)
    except BaseException:
        for rel in reversed(written):
            p=below(repo,rel)
            if old[rel] is None:p.unlink(missing_ok=True)
            else:p.write_bytes(old[rel])
        raise

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('repository',type=Path)
    ap.add_argument('--apply',action='store_true',help='write validated files locally; never commit or push')
    args=ap.parse_args();repo=args.repository.resolve()
    if not(repo/'.git').exists():ap.error('target must be an existing Git clone/worktree')
    manifest=json.loads((BASE/'publication_manifest.json').read_text())
    plan=make_plan(repo,manifest)
    if args.apply:apply(repo,plan)
    print(json.dumps({'mode':'applied-local-only' if args.apply else 'checked-no-write',
                      'files':[{'path':p,'git_blob':blob(b)} for p,b in sorted(plan.items())],
                      'git_commit_or_push_performed':False},ensure_ascii=False,indent=2))

if __name__=='__main__':main()
