"""Build selected complete theorem closures and reject unapproved axioms."""
from pathlib import Path
import hashlib,json,os,re,shutil,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
expected=json.loads((ROOT/'expected_sources.json').read_text(encoding='utf-8'))
for rel,h in expected.items():
    assert hashlib.sha256((ROOT/rel).read_bytes()).hexdigest()==h,rel
rows=json.loads((ROOT/'problems.json').read_text(encoding='utf-8'))
arg=sys.argv[1] if len(sys.argv)>1 else 'all'
selected=rows if arg=='all' else [r for r in rows if r['jsp']=='JSP-'+arg]
assert selected,'Unknown JSP suffix'
lake=shutil.which('lake')
assert lake,'Install elan/Lean and add lake to PATH'
out=ROOT/'reproduction';out.mkdir(exist_ok=True)
env=os.environ.copy();env['LEAN_NUM_THREADS']='1'
report=[]
for row in selected:
    id=row['jsp'][4:]
    commands=[['build','LeanForty.Problem'+id],['env','lean','-j1',row['audit']]]
    for idx,args in enumerate(commands):
        log=out/(id+('-build.log' if idx==0 else '-axioms.log'))
        with log.open('w',encoding='utf-8') as f:
            r=subprocess.run([lake,*args],cwd=ROOT,env=env,stdout=f,stderr=subprocess.STDOUT)
        if r.returncode: print('Failed '+str(log));sys.exit(r.returncode)
    text=log.read_text(encoding='utf-8')
    for name in row['expected_audits']:
        marker=chr(39)+name+chr(39)+' depends on axioms:'
        assert marker in text,name
        part=text.split(marker,1)[1].split('[',1)[1].split(']',1)[0]
        axioms={a.strip() for a in part.split(',') if a.strip()}
        assert axioms <= {'propext','Classical.choice','Quot.sound'},(name,axioms)
    assert 'sorryAx' not in text and 'Lean.ofReduceBool' not in text
    report.append({'jsp':row['jsp'],'build_exit':0,'audit_exit':0,'audit_count':len(row['expected_audits'])})
(out/'verification.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps(report))
