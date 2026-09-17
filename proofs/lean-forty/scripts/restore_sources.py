"""Restore pinned public dependencies and require exact tested bytes."""
from pathlib import Path
import concurrent.futures, hashlib, json, subprocess, sys, urllib.request
ROOT=Path(__file__).resolve().parents[1]
def sha(b): return hashlib.sha256(b).hexdigest()
def safe_path(rel):
    p=(ROOT/rel).resolve()
    p.relative_to(ROOT.resolve())
    return p
spec=json.loads((ROOT/'sources.json').read_text(encoding='utf-8'))
(ROOT/'reproduction').mkdir(exist_ok=True)
def restore(row):
    p=safe_path(row['path'])
    if p.exists() and sha(p.read_bytes())==row['expected_sha256']:return row['path']
    if p.exists():raise RuntimeError('Refusing to overwrite unexpected local bytes: '+row['path'])
    with urllib.request.urlopen(row['url'],timeout=60) as r:raw=r.read()
    assert sha(raw)==row['upstream_sha256'],row['url']
    if row['line_edits']:
        lines=raw.decode('utf-8').splitlines(keepends=True)
        for edit in reversed(row['line_edits']):
            lines[edit['start']:edit['end']]=[edit['replacement']]
        raw=''.join(lines).encode('utf-8')
    assert sha(raw)==row['expected_sha256'],row['path']
    p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(raw)
    return row['path']
with concurrent.futures.ThreadPoolExecutor(max_workers=5) as pool:
    done=list(pool.map(restore,spec['files']))
for script in ['extract_808_disproof.py','extract_920_bernoulli.py']:
    subprocess.run([sys.executable,str(ROOT/'scripts'/script)],cwd=ROOT,check=True)
for rel,h in spec['generated'].items():assert sha(safe_path(rel).read_bytes())==h,rel
expected=json.loads((ROOT/'expected_sources.json').read_text(encoding='utf-8'))
for rel,h in expected.items():assert sha(safe_path(rel).read_bytes())==h,rel
report={'restored_downloads':len(done),'generated':len(spec['generated']),'all_tested_source_hashes_match':True}
(ROOT/'reproduction/restoration.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps(report))
