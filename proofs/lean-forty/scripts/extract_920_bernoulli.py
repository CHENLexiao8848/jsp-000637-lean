"""Extract only the fully proved finite Bernoulli interface used by 920."""
import hashlib
import json
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
src = ROOT / ".source-cache/Erdos202.lean"
original = src.read_text(encoding="utf-8")
notice = "/- Local adaptation: narrowed Mathlib imports for Lean 4.34.0 verification; mathematical body unchanged. -/" + chr(10)
original = original.removeprefix(notice).replace("import LeanForty.RamseyImports", "import Mathlib")
lines = original.splitlines(keepends=True)
ranges = [(964, 971), (1437, 1449), (1477, 1509), (2278, 2399)]
parts = []
for first, last in ranges:
    block = "".join(lines[first - 1:last])
    if first == 1477:
        block = "omit [DecidableEq α] in" + chr(10) + block
    parts.append(block)
out = ("/- Extracted finite Bernoulli lemmas from the pinned Erdos202 public source."
    + chr(10) + "Original source credits Claude and Pawan Sasanka Ammanamanchi; see provenance_920.json."
    + chr(10) + "No Erdős202 main theorem is imported or claimed. -/" + chr(10)
    + "import LeanForty.RamseyImports" + chr(10)
    + "namespace Erdos202.ParkPham" + chr(10)
    + "open Finset" + chr(10) + "open scoped BigOperators" + chr(10)
    + "variable {α : Type*} [DecidableEq α]" + chr(10)
    + (chr(10).join(parts)) + chr(10) + "end Erdos202.ParkPham" + chr(10))
dest = ROOT / "vendor/plby/ErdosProblems/Erdos920/Bernoulli.lean"
dest.write_text(out, encoding="utf-8", newline="")
averaging = ROOT / "vendor/plby/ErdosProblems/Erdos920/Averaging.lean"
text = averaging.read_text(encoding="utf-8").replace("import ErdosProblems.Erdos202", "import ErdosProblems.Erdos920.Bernoulli")
averaging.write_text(text, encoding="utf-8", newline="")
record = {"source": str(src.relative_to(ROOT)), "source_sha256": hashlib.sha256(src.read_bytes()).hexdigest(),
    "ranges": ranges, "output": str(dest.relative_to(ROOT)), "output_sha256": hashlib.sha256(dest.read_bytes()).hexdigest(),
    "scope": "Same proved Bernoulli definitions and marginal identities; no omitted assumptions."}
(ROOT / "reproduction/extraction_920_bernoulli.json").write_text(json.dumps(record, indent=2), encoding="utf-8")
print(json.dumps({"extracted_lines": len(out.splitlines()), "ranges": ranges}))
