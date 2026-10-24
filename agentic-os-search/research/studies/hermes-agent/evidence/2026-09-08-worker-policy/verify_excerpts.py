#!/usr/bin/env python3
"""Compare retained selected definitions with a locally available pinned source tree.

No downloads. This optional source-fidelity check requires the complete original
large modules, which were not materialized in this research environment.
It is not a product execution test. Every selected function/class is compared by
AST including its docstring, excluding source positions and module scaffolding.
"""
from __future__ import annotations
import argparse, ast, hashlib, json
from pathlib import Path
ROOT=Path(__file__).resolve().parent
SOURCES={
 'excerpts/tool_executor.selected.py':('agent/tool_executor.py','799199c10f9930da77c01da2324373614b27cb78'),
 'excerpts/plugins.selected.py':('hermes_cli/plugins.py','da8d7e2c68b2346e6ecc15567d755d96085ef767'),
}
def git_blob(b:bytes)->str:
    return hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
def definitions(tree:ast.Module)->dict[str,ast.AST]:
    out={}
    for node in tree.body:
        if isinstance(node,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef)):out[node.name]=node
        elif isinstance(node,ast.Assign):
            for t in node.targets:
                if isinstance(t,ast.Name):out[t.id]=node
        elif isinstance(node,ast.AnnAssign) and isinstance(node.target,ast.Name):out[node.target.id]=node
    return out

def main()->int:
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--source-root',type=Path,required=True)
    ap.add_argument('--output',type=Path)
    args=ap.parse_args();rows=[]
    for excerpt,(source,wanted) in SOURCES.items():
        original=(args.source_root/source).read_bytes()
        got=git_blob(original)
        if got!=wanted:raise ValueError(f'Wrong original source: {source}: {got} != {wanted}')
        canonical=definitions(ast.parse(original.decode('utf-8')))
        selected=definitions(ast.parse((ROOT/excerpt).read_text(encoding='utf-8')))
        # The logger and imports are the explicitly-added local module scaffolding.
        for name,node in selected.items():
            if name=='logger':continue
            other=canonical.get(name)
            rows.append({'source':source,'symbol':name,'equal':other is not None and
                         ast.dump(node,include_attributes=False)==ast.dump(other,include_attributes=False)})
    result={'kind':'SOURCE_FIDELITY_ONLY','all_equal':all(r['equal'] for r in rows),'symbols':rows}
    text=json.dumps(result,indent=2)+'\n'
    if args.output:args.output.write_text(text,encoding='utf-8')
    print(text,end='')
    return 0 if result['all_equal'] else 1
if __name__=='__main__':raise SystemExit(main())
