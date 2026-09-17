#!/usr/bin/env python3
"""Reproduce a pinned proof, audit its axioms and replay its entry module."""
import argparse, hashlib, json, os, pathlib, re, subprocess, sys, urllib.request
from datetime import datetime, timezone
ROOT = pathlib.Path(__file__).resolve().parents[1]
ALLOWED = {"propext", "Classical.choice", "Quot.sound"}
def read_json(p):
    return json.loads(p.read_text(encoding="utf-8-sig"))
def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()
def prepare():
    lock = read_json(ROOT / "upstream-lock.json")
    for item in lock["files"]:
        dest = ROOT / ".lake/upstream-src" / item["path"]
        if not dest.exists():
            url = f"{lock["repository"].replace("github.com", "raw.githubusercontent.com")}/{lock["commit"]}/src/latest/{item["path"]}"
            data = urllib.request.urlopen(url, timeout=90).read()
            if hashlib.sha256(data).hexdigest() != item["sha256"]:
                raise RuntimeError("Downloaded source hash mismatch: " + item["path"])
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(data)
        if digest(dest) != item["sha256"]:
            raise RuntimeError("External source hash mismatch: " + item["path"])
def check_sources():
    items = read_json(ROOT / "source-lock.json")
    for item in items:
        if digest(ROOT / item["path"]) != item["sha256"]:
            raise RuntimeError("Local source changed: " + item["path"])
    return items
def now():
    return datetime.now(timezone.utc).isoformat()
def clean_log(text):
    text = text.replace(str(ROOT), "$BATCH").replace(str(ROOT).replace("\\", "/"), "$BATCH")
    text = re.sub(r"[Cc]:[\\/]Users[\\/][^\\/\s]+", "$USER", text)
    return text
def verify(proof, fetch_cache):
    out = ROOT / "verification" / proof["jsp"]
    out.mkdir(parents=True, exist_ok=True)
    record = {"problem": proof["jsp"], "status": "running", "started_utc": now(),
              "theorems": proof["theorems"], "allowed_axioms": sorted(ALLOWED),
              "lean": "4.34.0", "mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
              "source_hashes": check_sources(), "checks": [],
              "replay_scope": "Entry module using Lean bundled kernel; imports dependencies, not --fresh",
              "verification_kind": "submitter-run, not independent human review"}
    def save():
        (out / "verification.json").write_text(json.dumps(record, indent=2), encoding="utf-8")
    def run(args, log):
        start = now()
        result = subprocess.run(args, cwd=ROOT, text=True, encoding="utf-8", errors="replace",
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        text = clean_log(result.stdout)
        (out / log).write_text(text, encoding="utf-8")
        record["checks"].append({"command": args, "exit_code": result.returncode,
                                 "started_utc": start, "ended_utc": now(), "log": log})
        save()
        if result.returncode:
            raise RuntimeError(f"Command failed ({result.returncode}): {args}; {out.name}/{log}")
        return text
    save()
    try:
        version = run(["lake", "env", "lean", "--version"], "toolchain.log")
        if "version 4.34.0" not in version: raise RuntimeError("Wrong Lean version")
        if fetch_cache: run(["lake", "exe", "cache", "get"], "cache.log")
        run(["lake", "build", proof["module"]], "build.log")
        audit = out / "Audit.lean"
        audit.write_text("import " + proof["module"] + "\n\n" +
                         "\n".join("#print axioms " + t for t in proof["theorems"]) + "\n", encoding="utf-8")
        text = run(["lake", "env", "lean", audit.relative_to(ROOT).as_posix()], "axioms.log")
        for name in proof["theorems"]:
            match = re.search(re.escape(name) + r"' depends on axioms: \[([^\]]*)\]", text)
            if not match: raise RuntimeError("Missing axiom output: " + name)
            used = {s.strip() for s in match.group(1).split(",") if s.strip()}
            if used - ALLOWED: raise RuntimeError("Unexpected axioms: " + str(used - ALLOWED))
        run(["lake", "env", "leanchecker", "--verbose", proof["module"]], "kernel.log")
        check_sources()
        record["status"] = "passed"
        record["completed_utc"] = now()
        save()
        print("PASS " + proof["jsp"], flush=True)
    except Exception as exc:
        record["status"] = "failed"
        record["error"] = str(exc)
        save()
        raise
def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--problem")
    parser.add_argument("--fetch-cache", action="store_true")
    parser.add_argument("--prepare-only", action="store_true")
    args=parser.parse_args()
    os.environ.setdefault("LEAN_NUM_THREADS", "1")
    prepare()
    if args.prepare_only: return
    proofs=read_json(ROOT / "proofs.json")
    if args.problem:
        proofs=[p for p in proofs if p["jsp"]==args.problem]
        if not proofs: raise RuntimeError("Unknown problem")
    for i, proof in enumerate(proofs): verify(proof, args.fetch_cache and i==0)
if __name__ == "__main__": main()
