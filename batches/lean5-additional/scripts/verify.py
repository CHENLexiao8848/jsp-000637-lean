#!/usr/bin/env python3
"""Fetch pinned originals, reconstruct exact verified sources, and optionally check Lean."""
import argparse,hashlib,json,os,pathlib,re,subprocess,urllib.request
from datetime import datetime,timezone
ROOT=pathlib.Path(__file__).resolve().parents[1]
DEP=ROOT/'.lake/upstream-src'
ALLOWED={'propext','Classical.choice','Quot.sound'}
def load(p):return json.loads(p.read_text(encoding='utf-8-sig'))
def sha(b):return hashlib.sha256(b).hexdigest()
def normalized(b):return b.decode('utf-8-sig').replace('\r\n','\n')
def checked_path(rel):
    target=(DEP/rel).resolve()
    if not target.is_relative_to(DEP.resolve()):raise RuntimeError('Invalid dependency path')
    return target
def apply_patch(file):
    lines=file.read_text(encoding='utf-8').splitlines(keepends=True)
    i=0;target=None
    while i<len(lines):
        line=lines[i]
        if line.startswith('+++ b/'):
            target=checked_path(line[6:].strip());i+=1;continue
        if not line.startswith('@@ '):i+=1;continue
        i+=1;old=[];new=[]
        while i<len(lines) and not lines[i].startswith(('@@ ','diff --git','--- a/')):
            s=lines[i]
            if s.startswith((' ','-')):old.append(s[1:])
            if s.startswith((' ','+')):new.append(s[1:])
            if s.startswith('\\ No newline'):raise RuntimeError('Unsupported missing newline')
            i+=1
        before=''.join(old);after=''.join(new)
        current=target.read_text(encoding='utf-8')
        if current.count(before)!=1:raise RuntimeError('Patch context mismatch: '+str(target))
        target.write_text(current.replace(before,after,1),encoding='utf-8',newline='\n')
def prepare():
    lock=load(ROOT/'upstream-lock.json')
    if lock['commit']!='8822f7ddef30fadbd92e1c6ab4ed897af356af5e':raise RuntimeError('Unexpected pin')
    if all(checked_path(x['path']).exists() and sha(checked_path(x['path']).read_bytes())==x['verified_sha256'] for x in lock['files']):return
    for item in lock['files']:
        cached=ROOT/'.lake/originals'/item['path']
        data=cached.read_bytes() if cached.exists() else urllib.request.urlopen(item['url'],timeout=90).read()
        if sha(data)!=item['original_sha256']:raise RuntimeError('Original hash mismatch: '+item['path'])
        cached.parent.mkdir(parents=True,exist_ok=True);cached.write_bytes(data)
        target=checked_path(item['path']);target.parent.mkdir(parents=True,exist_ok=True)
        target.write_text(normalized(data),encoding='utf-8',newline='\n')
        if item['extracted']:
            original=ROOT/'artifacts/sources/upstream-audit'/item['path']
            original.parent.mkdir(parents=True,exist_ok=True);original.write_bytes(data)
    subprocess.run(['node','scripts/extract-erdos402-eventual.mjs'],cwd=ROOT,check=True)
    extraction=load(ROOT/'extraction-lock.json')
    if sha((ROOT/'artifacts/audit/erdos402-eventual-base.lean').read_bytes())!=extraction['extractedSha256']:raise RuntimeError('Extraction hash mismatch')
    for e in load(ROOT/'scripts/patches/unitfractions-v434.json')['edits']:
        target=checked_path(e['file']);current=target.read_text(encoding='utf-8')
        if e['before'] not in current:raise RuntimeError('Rename patch mismatch '+e['file'])
        target.write_text(current.replace(e['before'],e['after']),encoding='utf-8',newline='\n')
    apply_patch(ROOT/'scripts/patches/pnt-v434.patch')
    apply_patch(ROOT/'scripts/patches/erdos402-eventual-v434.patch')
    for item in lock['files']:
        if sha(checked_path(item['path']).read_bytes())!=item['verified_sha256']:raise RuntimeError('Reconstruction hash mismatch '+item['path'])
    print('PASS: reconstructed '+str(len(lock['files']))+' exact verified source modules',flush=True)
def check_sources():
    for item in load(ROOT/'source-lock.json'):
        if sha((ROOT/item['path']).read_bytes())!=item['sha256']:raise RuntimeError('Changed published file '+item['path'])
def verify(p,fetch_cache):
    out=ROOT/'verification'/p['jsp'];out.mkdir(parents=True,exist_ok=True)
    record={'problem':p['jsp'],'started_utc':datetime.now(timezone.utc).isoformat(),'checks':[],'status':'running'}
    def save():(out/'verification.json').write_text(json.dumps(record,indent=2),encoding='utf-8')
    def run(args,name):
        r=subprocess.run(args,cwd=ROOT,text=True,encoding='utf-8',errors='replace',stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
        sanitized=r.stdout.replace(str(ROOT),'$BATCH').replace(ROOT.as_posix(),'$BATCH')
        sanitized=re.sub(r'[Cc]:[\\/]Users[\\/][^\\/\s]+','$USER',sanitized)
        (out/name).write_text(sanitized,encoding='utf-8')
        record['checks'].append({'command':args,'exit_code':r.returncode,'log':name});save()
        if r.returncode:raise RuntimeError('Command failed: '+str(args))
        return r.stdout
    try:
        if fetch_cache:run(['lake','exe','cache','get'],'cache.log')
        run(['lake','build',p['module']],'build.log')
        audit=out/'Audit.lean';audit.write_text('import '+p['module']+'\n\n'+'\n'.join('#print axioms '+t for t in p['theorems'])+'\n',encoding='utf-8')
        log=run(['lake','env','lean','-j1',audit.relative_to(ROOT).as_posix()],'axioms.log')
        for theorem in p['theorems']:
            match=re.search(re.escape(theorem)+r"' depends on axioms: \[([^\]]*)\]",log)
            if not match:raise RuntimeError('Missing axiom report '+theorem)
            if {s.strip() for s in match[1].split(',') if s.strip()}-ALLOWED:raise RuntimeError('Unexpected axiom '+theorem)
        check_sources();record['status']='passed';save();print('PASS '+p['jsp'],flush=True)
    except Exception as e:record['status']='failed';record['error']=str(e);save();raise
def main():
    a=argparse.ArgumentParser();a.add_argument('--problem');a.add_argument('--prepare-only',action='store_true');a.add_argument('--fetch-cache',action='store_true');args=a.parse_args()
    os.environ.setdefault('LEAN_NUM_THREADS','1');check_sources();prepare()
    if args.prepare_only:return
    selected=[p for p in load(ROOT/'proofs.json') if not args.problem or p['jsp']==args.problem]
    if not selected:raise RuntimeError('Unknown problem')
    for i,p in enumerate(selected):verify(p,args.fetch_cache and i==0)
if __name__=='__main__':main()
