"""Extract the complete original-conjecture disproof; keep ancillary bounds separate."""
import hashlib
import json
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / ".source-cache/Erdos808.lean"
original = SOURCE.read_text(encoding="utf-8")
start = original.index("/-! ## The complementary Alon--Ruzsa--Solymosi lower bound -/")
end = original.index("/-! ## The prime block and the sifted interval -/")
prime_start = original.index("lemma blockPrime_le_seventh_eventually :")
prime_end = original.index("/-- Positive integers at most", prime_start)
old_bound = original[prime_start:prime_end]
new_bound = ("lemma blockPrime_le_seventh_eventually :" + chr(10)
    + "    ∀ᶠ q : ℕ in atTop, ∀ i : Fin q, blockPrime q i ≤ q ^ 7 :=" + chr(10)
    + "  LeanForty.prime_block_le_seventh_eventually" + chr(10) + chr(10))
text = original[:start] + original[end:]
text = text.replace(old_bound, new_bound)
text = text.replace("import Mathlib" + chr(10) + "import PrimeNumberTheoremAnd.Consequences" + chr(10)
    + "import Util.IncidenceGeometry.SzemerediTrotter",
    "import LeanForty.PrimeBlockBound" + chr(10)
    + "import LeanForty.GraphImports" + chr(10)
    + "import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics" + chr(10)
    + "import Mathlib.Combinatorics.Pigeonhole")
text = text.replace("#print axioms erdos808_quantitative_bound" + chr(10), "")
text = text.replace("namespace Erdos808" + chr(10),
    "namespace Erdos808" + chr(10) + chr(10)
    + "local notation " + chr(34) + "nth_prime" + chr(34) + " => Nat.nth Nat.Prime" + chr(10), 1)
notice = ("/- Local adaptation: complete disproof extracted; complementary incidence lower-bound section omitted."
    + chr(10) + "The polynomial prime-block bound is proved from Mathlib Chebyshev, replacing external PNT. -/" + chr(10))
text = notice + text
destination = ROOT / "vendor/plby/ErdosProblems/Erdos808Disproof.lean"
if destination.exists() and destination.read_text(encoding="utf-8") != text:
    raise RuntimeError("Refusing to overwrite edited extraction")
destination.write_text(text, encoding="utf-8", newline="")
record = {
  "repo": "https://github.com/plby/lean-proofs", "commit": "8822f7ddef30fadbd92e1c6ab4ed897af356af5e",
  "scope": "Complete negation of original StrongErdos808; ancillary ARS incidence lower bound is not claimed.",
  "upstream_sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
  "local_path": str(destination.relative_to(ROOT)), "local_sha256": hashlib.sha256(destination.read_bytes()).hexdigest(),
  "changes": ["Omit independently headed complementary lower-bound section and its print command",
      "Replace external PNT use by local Chebyshev polynomial prime lemma with same statement",
      "Narrow imports and retain all original proof/definition text outside documented sections"]}
(ROOT / "reproduction/extraction_808.json").write_text(json.dumps(record, indent=2), encoding="utf-8")
print(json.dumps({"lines": len(text.splitlines()), "full_disproof_retained": True}))
