"""Reproduce one complete attributed Lean package (Python stdlib only)."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import time

parser = argparse.ArgumentParser()
parser.add_argument('--replay', action='store_true')
parser.add_argument('--hash-only', action='store_true')
args = parser.parse_args()
root = Path(__file__).resolve().parent
os.chdir(root)
meta = json.loads((root / 'submission.json').read_text(encoding='utf-8'))
prior = json.loads((root / 'evidence/verification.json').read_text(encoding='utf-8'))
out = root / 'verification-output'
out.mkdir(exist_ok=True)
result = {'jsp': meta['jsp'], 'commands': [], 'hashes_valid': False,
          'replay_requested': args.replay, 'completed': False}

def save():
    (out / 'verification.json').write_text(json.dumps(result, indent=2), encoding='utf-8')

def run(command, logname):
    started = time.time()
    with (out / logname).open('w', encoding='utf-8') as log:
        proc = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT,
                              env={**os.environ, 'LEAN_NUM_THREADS': '2'}, text=True)
    result['commands'].append({'command': command, 'exit_code': proc.returncode,
                               'seconds': round(time.time() - started, 2), 'log': logname})
    save()
    if proc.returncode:
        raise SystemExit('Failed command; see ' + str(out / logname))
    return (out / logname).read_text(encoding='utf-8')

for record in prior['source_records'] + [{'path': prior['wrapper']['file'],
                                         'sha256': prior['wrapper']['sha256']}]:
    p = root / record['path']
    if hashlib.sha256(p.read_bytes()).hexdigest() != record['sha256']:
        raise SystemExit('Source hash mismatch: ' + record['path'])
result['hashes_valid'] = True
save()
if args.hash_only:
    print('Source hashes verified:', meta['jsp'])
    raise SystemExit(0)
version = run(['lake', 'env', 'lean', '--version'], 'toolchain.log')
if 'version 4.33.0' not in version:
    raise SystemExit('Wrong Lean toolchain')
if (root / 'lean-toolchain').read_text().strip() != prior['toolchain']:
    raise SystemExit('Wrong toolchain pin')
resolved = json.loads((root / 'lake-manifest.json').read_text())
mathlib = next(p for p in resolved['packages'] if p['name'] == 'mathlib')
if mathlib['rev'] != prior['mathlib_commit']:
    raise SystemExit('Wrong Mathlib pin')
run(['lake', 'build', Path(meta['wrapper']).stem], 'build.log')
output = run(['lake', 'env', 'lean', '-j1', meta['wrapper']], 'axioms.log')
axioms = {name: [x.strip() for x in text.split(',') if x.strip()]
          for name, text in re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", output)}
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
for name in meta['decls']:
    if name not in axioms or not set(axioms[name]) <= allowed:
        raise SystemExit('Missing or forbidden axiom report: ' + name)
result['axioms'] = axioms
if args.replay:
    for index, mod in enumerate([r['module'] for r in prior['source_records']] + [Path(meta['wrapper']).stem]):
        run(['lake', 'env', 'leanchecker', '--verbose', mod], 'replay-' + str(index) + '.log')
result['completed'] = True
save()
print('Build and named-theorem axiom audit PASS:', meta['jsp'])
