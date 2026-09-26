# JSP-000331 — preserved fixed-version CI evidence, 2026-09-26

This report preserves the existing successful GitHub CI for [PR #782](https://github.com/TheJustinSunPrize/awards/pull/782). No new Lean build, explicit clean or separate kernel replay was performed in this review. The fixed proof is `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-additional-20260917`, commit **`a4d83d426d9ee2d92511857831e27b70216aedfe`**, package `batches/lean5-additional`.

## Provenance and verified scope

- [Entry](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/LeanTwenty/JSP000331.lean), [fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/verify.py), [source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/source-lock.json), [upstream lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/upstream-lock.json), and [attribution](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/ATTRIBUTION.md).
- [Run 35236431959](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35236431959), dedicated [job 105253430291](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35236431959/job/105253430291): success at the selected SHA.
- Artifact `10503509299`, `lean5-additional-JSP-000331`: 5,477 ZIP bytes, SHA256 `877f9ecd89d801bf2752d681993e520e4f7b3b14021e01656c21aaae41c349b2`, matching GitHub's artifact digest. Recorded expiry: 2026-12-16T14:51:58Z.

All 29 selected fixed Git blobs (the complete 28-file package plus workflow) and all 27 source-lock records were independently checked against downloaded bytes. The artifact ZIP and all five extracted members passed integrity and byte checks. The actual job checked out the fixed SHA and printed the 25-module reconstruction success shown below. The immutable verifier authenticates original sources, performs the explicit extraction/compatibility patches, checks every reconstructed source hash, then builds and audits the chosen problem. This review did not independently redownload or reconstruct all 25 upstream files; it verified the fixed recipe, locks, checkout and actual CI record.

The run used a fresh hosted Ubuntu checkout without project-cache restoration or tracked package oleans. It downloaded Mathlib dependency caches and Lean 4.34.0 for Linux; all nine actual dependency checkout revisions in `cache.log` match the manifest, including Mathlib `5ed2965256430c3649e86755f9576b54eca72435`. The recipe does not produce a separate `lean --version` line. There was no explicit `lake clean`, and no separately invoked `leanchecker` step.

The build actually reports `Built LeanTwenty.JSP000331` and `Build completed successfully (3693 jobs)`. The public interface and underlying theorem both have exactly the three standard dependencies `[propext, Classical.choice, Quot.sound]`. They are **JSP000331.solution** and **Erdos402.erdos_402**. The CI's three recorded commands—cache retrieval, selected module build and the generated two-target axiom audit—all exit zero. No other batch problem's result is used to justify these targets.

The local interface proves one uniform threshold `N₀≥2` for all sufficiently large finite positive-natural sets, with two distinct witnesses and rational gcd bound. It applies the reused complete eventual `Erdos402.erdos_402` and derives distinctness locally. It does not formalize the stronger all-cardinality conclusion. The declaration-closure extraction and alternate PNT dependency are integration work: the PNT proof is reused from another pinned plby module, not a newly authored prime number theorem.

The earlier committed local evidence and publication records are historical. The successful exact-SHA Linux job above supplies the current reproducibility evidence and supersedes old PR wording that the new workflow was merely queued/not claimed passed. Neither successful CI nor this byte review establishes independent human mathematical review, original complete-proof ownership, firstness, eligibility or organizer acceptance. Core proof attribution remains with its upstream authors; only the specifically described local additions may be claimed by the submitting account.

## Actual job success echoes

```text
2026-09-17T14:52:08.1267356Z PASS: reconstructed 25 exact verified source modules
2026-09-17T14:55:56.6923092Z PASS JSP-000331
```

Reproduce from the fixed package with `python3 scripts/verify.py --problem JSP-000331 --fetch-cache`. For a deliberate new project-library clean, first restore with `--prepare-only`, retrieve the dependency cache and run `lake clean LeanTwenty ErdosProblems UnitFractions PrimeNumberTheoremAnd`, then invoke the selected verifier. These are instructions, not a new execution result.

## Preserved artifact files

Four full artifact members follow; the cache progress log is omitted from the body but included in the hash table. Each embedded file was extracted back from this Markdown and matched byte-for-byte and by SHA256 to the downloaded ZIP member. The original CI JSON has no per-log hash fields; this report supplies them.

| Member | Bytes | SHA256 |
| --- | ---: | --- |
| `Audit.lean` | 95 | `133770043b4ec93f114a4778f222cf301a1485e2fae02702a303cc54c6800d07` |
| `build.log` | 8751 | `f53b31bc09d24277895f387de69207623afd2f20bc12dcbb5ce02debf170013c` |
| `axioms.log` | 160 | `39474a0ad9b62abe3200b911976fb392c0efe9f50709e1079f8980ab1bb2d0de` |
| `cache.log` | 12485 | `2a763c5c09a4a63e9f4af294ef4979b60b00ffbe3320acfe325718b21b7b426b` |
| `verification.json` | 620 | `beb39c50769e0dac54f4a2d3bb236f1c21fd52b046d8ebe42b82e6e7ede1fc8a` |

## `Audit.lean`

SHA256 `133770043b4ec93f114a4778f222cf301a1485e2fae02702a303cc54c6800d07`; original final newline: `true`.

<!-- BEGIN artifact: Audit.lean -->
```lean
import LeanTwenty.JSP000331

#print axioms JSP000331.solution
#print axioms Erdos402.erdos_402
```
<!-- END artifact: Audit.lean -->

## `build.log`

SHA256 `f53b31bc09d24277895f387de69207623afd2f20bc12dcbb5ce02debf170013c`; original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
✔ [2817/2827] Built PrimeNumberTheoremAnd.Mathlib.Analysis.SpecialFunctions.Log.Basic (1.6s)
✔ [2825/2828] Built ErdosProblems.Erdos49.PNT.Auxiliary (1.0s)
⚠ [2826/2930] Built ErdosProblems.Erdos49.PNT.MellinCalculus (8.1s)
warning: .lake/upstream-src/ErdosProblems/Erdos49/PNT/MellinCalculus.lean:602:15: `if_neg` has been deprecated: Use `ite_eq_right` instead
warning: .lake/upstream-src/ErdosProblems/Erdos49/PNT/MellinCalculus.lean:1037:23: `if_pos` has been deprecated: Use `ite_eq_left` instead
⚠ [3658/3661] Built PrimeNumberTheoremAnd.Sobolev (5.5s)
warning: .lake/upstream-src/PrimeNumberTheoremAnd/Sobolev.lean:307:42: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
✔ [3660/3671] Built PrimeNumberTheoremAnd.Fourier (2.6s)
✔ [3668/3674] Built ErdosProblems.Erdos49.PNT.Rectangle (3.0s)
✔ [3672/3679] Built ErdosProblems.Erdos49.PNT.Tactic.AdditiveCombination (1.7s)
✔ [3675/3681] Built ErdosProblems.Erdos49.PNT.ZetaConj (2.1s)
✔ [3676/3682] Built ErdosProblems.Erdos49.PNT.ResidueCalcOnRectangles (8.1s)
✔ [3677/3682] Built ErdosProblems.Erdos49.PNT.EulerMaclaurin (2.0s)
✔ [3678/3683] Built PrimeNumberTheoremAnd.Mathlib.Algebra.Notation.Support (767ms)
✔ [3680/3683] Built ErdosProblems.Erdos49.PNT.ZetaBounds (22s)
✔ [3682/3693] Built PrimeNumberTheoremAnd.SmoothExistence (2.6s)
⚠ [3691/3693] Built ErdosProblems.Erdos49.PNT.MediumPNT (30s)
warning: .lake/upstream-src/ErdosProblems/Erdos49/PNT/MediumPNT.lean:320:10: `mul_lt_one_of_nonneg_of_lt_one_left` has been deprecated: No replacement, use constituent lemmas from proof.
info: .lake/upstream-src/ErdosProblems/Erdos49/PNT/MediumPNT.lean:3553:0: 'MediumPNT' depends on axioms: [propext, Classical.choice, Quot.sound]
⚠ [3692/3693] Built ErdosProblems.Erdos402 (18s)
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:96:2: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:93:19: Variable name `hb0` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hb0

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:169:6: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:177:6: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:187:6: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:229:13: Variable name `α` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _α

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:359:6: Try `simp at this` instead of `simpa using this`

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:734:2: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1229:13: Variable name `l` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _l

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1237:15: Variable name `hN` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hN

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1312:31: This simp argument is unused:
  m

Hint: Omit it from the simp argument list.
  [apply] simp [squareMomentSide, s, hs]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1337:33: This simp argument is unused:
  s

Hint: Omit it from the simp argument list.
  [apply] simp only [squareMomentSide, m, lo]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1337:36: This simp argument is unused:
  m

Hint: Omit it from the simp argument list.
  [apply] simp only [squareMomentSide, s, lo]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1337:39: This simp argument is unused:
  lo

Hint: Omit it from the simp argument list.
  [apply] simp only [squareMomentSide, s, m]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1343:17: Variable name `hN` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hN

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1876:6: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:1868:13: This simp argument is unused:
  Real.rpow_natCast

Hint: Omit it from the simp argument list.
  [apply] simp only [Real.rpow_one] at hratio

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:2617:13: Variable name `p` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _p

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:2617:24: Variable name `α` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _α

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:2998:30: This simp argument is unused:
  mul_comm

Hint: Omit it from the simp argument list.
  [apply] simp only [mul_assoc, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:3001:30: This simp argument is unused:
  mul_comm

Hint: Omit it from the simp argument list.
  [apply] simp only [mul_assoc, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:3012:30: This simp argument is unused:
  mul_comm

Hint: Omit it from the simp argument list.
  [apply] simp only [mul_assoc, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:3015:30: This simp argument is unused:
  mul_comm

Hint: Omit it from the simp argument list.
  [apply] simp only [mul_assoc, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
warning: .lake/upstream-src/ErdosProblems/Erdos402.lean:3084:57: Variable name `hpupper` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hpupper

Note: This linter can be disabled with `set_option linter.unusedVariables false`
✔ [3693/3693] Built LeanTwenty.JSP000331 (2.3s)
Build completed successfully (3693 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256 `39474a0ad9b62abe3200b911976fb392c0efe9f50709e1079f8980ab1bb2d0de`; original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
'JSP000331.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
'Erdos402.erdos_402' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `verification.json`

SHA256 `beb39c50769e0dac54f4a2d3bb236f1c21fd52b046d8ebe42b82e6e7ede1fc8a`; original final newline: `false`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "problem": "JSP-000331",
  "started_utc": "2026-09-17T14:52:08.126948+00:00",
  "checks": [
    {
      "command": [
        "lake",
        "exe",
        "cache",
        "get"
      ],
      "exit_code": 0,
      "log": "cache.log"
    },
    {
      "command": [
        "lake",
        "build",
        "LeanTwenty.JSP000331"
      ],
      "exit_code": 0,
      "log": "build.log"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "-j1",
        "verification/JSP-000331/Audit.lean"
      ],
      "exit_code": 0,
      "log": "axioms.log"
    }
  ],
  "status": "passed"
}
```
<!-- END artifact: verification.json -->
