"""Build, audit and sequentially replay the exact submitted source."""
from pathlib import Path
import datetime, hashlib, json, os, re, subprocess
root=Path(__file__).resolve().parents[1]
out=root/'artifacts'
out.mkdir(exist_ok=True)
os.chdir(root)
targets=['Jsp.Powerful301.answer','Jsp.Powerful301.counterexample','Jsp.Graph139Upper.answer','Jsp.Graph139Upper.upper_bound']
modules=['Jsp.Powerful301','Jsp.Graph139','Jsp.Graph139Fields','Jsp.Graph139Parabola','Jsp.Graph139Blowup','Jsp.Graph139Upper']
inputs=sorted([*root.glob('Jsp/*.lean'),root/'Jsp.lean',root/'Audit.lean',root/'lean-toolchain',root/'lakefile.toml',root/'lake-manifest.json',Path(__file__).resolve()])
def hashes():return {p.relative_to(root).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
record={'status':'running','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'source_hashes':hashes(),'checks':[],'allowed_axioms':['propext','Classical.choice','Quot.sound'],'replay_scope':'six local modules, same kernel, importing pinned dependencies'}
def save(): (out/'verification.json').write_text(json.dumps(record,indent=2)+chr(10),encoding='utf-8')
def run(args,name):
 p=subprocess.run(args,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,encoding='utf-8',errors='replace')
 s=p.stdout.replace(str(root),'<PROOF_ROOT>').replace(str(Path.home()),'<HOME>')
 (out/name).write_text(s,encoding='utf-8')
 record['checks'].append({'command':args,'exit_code':p.returncode,'log':name,'sha256':hashlib.sha256(s.encode()).hexdigest()})
 save()
 if p.returncode:raise RuntimeError('Failed '+name)
 print('PASS '+name,flush=True)
 return s
save()
try:
 version=run(['lake','env','lean','--version'],'toolchain.log')
 assert 'version 4.34.0,' in version
 manifest=json.loads((root/'lake-manifest.json').read_text(encoding='utf-8-sig'))
 assert next(p for p in manifest['packages'] if p['name']=='mathlib')['rev']=='5ed2965256430c3649e86755f9576b54eca72435'
 run(['lake','build'],'build.log')
 ax=run(['lake','env','lean','Audit.lean'],'axioms.log')
 found=dict(re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",ax))
 for t in targets:
  assert t in found
  assert {s.strip() for s in found[t].split(',') if s.strip()}<=set(record['allowed_axioms'])
 for m in modules:run(['lake','env','leanchecker','--verbose',m],m+'.log')
 assert hashes()==record['source_hashes']
 record['status']='passed'
 record['completed_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat()
 save()
except Exception:
 record['status']='failed';save();raise
