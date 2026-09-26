# JSP-000248 — preserved fixed-version CI evidence, 2026-09-26

This report preserves the existing successful GitHub CI for [PR #781](https://github.com/TheJustinSunPrize/awards/pull/781). No new Lean build, explicit clean or separate kernel replay was performed in this review. The fixed proof is `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-additional-20260917`, commit **`a4d83d426d9ee2d92511857831e27b70216aedfe`**, package `batches/lean5-additional`.

## Provenance and verified scope

- [Entry](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/LeanTwenty/JSP000248.lean), [fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/verify.py), [source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/source-lock.json), [upstream lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/upstream-lock.json), and [attribution](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/ATTRIBUTION.md).
- [Run 35236431959](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35236431959), dedicated [job 105253430780](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35236431959/job/105253430780): success at the selected SHA.
- Artifact `10504020168`, `lean5-additional-JSP-000248`: 4,601 ZIP bytes, SHA256 `79add10c3b56c7b6a98b37963a46847428c9a8ae29c2e4efd039c896591f0442`, matching GitHub's artifact digest. Recorded expiry: 2026-12-16T14:51:58Z.

All 29 selected fixed Git blobs (the complete 28-file package plus workflow) and all 27 source-lock records were independently checked against downloaded bytes. The artifact ZIP and all five extracted members passed integrity and byte checks. The actual job checked out the fixed SHA and printed the 25-module reconstruction success shown below. The immutable verifier authenticates original sources, performs the explicit extraction/compatibility patches, checks every reconstructed source hash, then builds and audits the chosen problem. This review did not independently redownload or reconstruct all 25 upstream files; it verified the fixed recipe, locks, checkout and actual CI record.

The run used a fresh hosted Ubuntu checkout without project-cache restoration or tracked package oleans. It downloaded Mathlib dependency caches and Lean 4.34.0 for Linux; all nine actual dependency checkout revisions in `cache.log` match the manifest, including Mathlib `5ed2965256430c3649e86755f9576b54eca72435`. The recipe does not produce a separate `lean --version` line. There was no explicit `lake clean`, and no separately invoked `leanchecker` step.

The build actually reports `Built LeanTwenty.JSP000248` and `Build completed successfully (8934 jobs)`. The public interface and underlying theorem both have exactly the three standard dependencies `[propext, Classical.choice, Quot.sound]`. They are **JSP000248.solution** and **Erdos292.erdos_292**. The CI's three recorded commands—cache retrieval, selected module build and the generated two-target axiom audit—all exit zero. No other batch problem's result is used to justify these targets.

The local `Attainable` definition describes a finite set of distinct positive denominators, includes its largest denominator and sums their reciprocals to one. The limit interface for all natural `N` is a direct application of the existing upstream density theorem. Lean 4.34 product-lemma compatibility changes are not a new proof of the density theorem. The upstream route also relies on the independently credited UnitFractions development. No stronger quantitative exceptional-set estimate is claimed.

The earlier committed local evidence and publication records are historical. The successful exact-SHA Linux job above supplies the current reproducibility evidence and supersedes old PR wording that the new workflow was merely queued/not claimed passed. Neither successful CI nor this byte review establishes independent human mathematical review, original complete-proof ownership, firstness, eligibility or organizer acceptance. Core proof attribution remains with its upstream authors; only the specifically described local additions may be claimed by the submitting account.

## Actual job success echoes

```text
2026-09-17T14:52:16.6697391Z PASS: reconstructed 25 exact verified source modules
2026-09-17T14:56:44.3699918Z PASS JSP-000248
```

Reproduce from the fixed package with `python3 scripts/verify.py --problem JSP-000248 --fetch-cache`. For a deliberate new project-library clean, first restore with `--prepare-only`, retrieve the dependency cache and run `lake clean LeanTwenty ErdosProblems UnitFractions PrimeNumberTheoremAnd`, then invoke the selected verifier. These are instructions, not a new execution result.

## Preserved artifact files

Four full artifact members follow; the cache progress log is omitted from the body but included in the hash table. Each embedded file was extracted back from this Markdown and matched byte-for-byte and by SHA256 to the downloaded ZIP member. The original CI JSON has no per-log hash fields; this report supplies them.

| Member | Bytes | SHA256 |
| --- | ---: | --- |
| `axioms.log` | 160 | `7460dba9e4722b7ebcce9b6753750bb671556bbb054ae5731c5f12ce8cb6a3c2` |
| `build.log` | 3522 | `d45fe97272b7739b19645802a651a1c73d9a381cab461033be1ca44b2faf0500` |
| `Audit.lean` | 95 | `7e2f2a4aaef46ed13b04bad770c526d6652c0b99095a079d89b36c4a4060a31e` |
| `cache.log` | 10957 | `674d2142d2f029566e59347395623219e26084fd877d2a864fb413ab7b5b1bfa` |
| `verification.json` | 620 | `f2d270163de0e0773a6a7ded463bedfa066609e5b7caa6e13c11bd4b5c6fbbdb` |

## `Audit.lean`

SHA256 `7e2f2a4aaef46ed13b04bad770c526d6652c0b99095a079d89b36c4a4060a31e`; original final newline: `true`.

<!-- BEGIN artifact: Audit.lean -->
```lean
import LeanTwenty.JSP000248

#print axioms JSP000248.solution
#print axioms Erdos292.erdos_292
```
<!-- END artifact: Audit.lean -->

## `build.log`

SHA256 `d45fe97272b7739b19645802a651a1c73d9a381cab461033be1ca44b2faf0500`; original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
✔ [8365/8464] Built Mathlib.Probability.Kernel.Invariance (1.3s)
✔ [8922/8924] Built Mathlib (2.9s)
✔ [8923/8928] Built UnitFractions.Definitions (4.5s)
✔ [8924/8929] Built UnitFractions.ForMathlib.IntegralRPow (1.9s)
✔ [8926/8934] Built UnitFractions.ForMathlib.Misc (3.7s)
⚠ [8927/8934] Built UnitFractions.ForMathlib.BasicEstimates (13s)
warning: .lake/upstream-src/UnitFractions/ForMathlib/BasicEstimates.lean:274:8: `Finset.prod_le_prod'` has been deprecated: Use `Finset.prod_le_prod` instead
warning: .lake/upstream-src/UnitFractions/ForMathlib/BasicEstimates.lean:1262:8: `Finset.sum_nonneg'` has been deprecated: Use `Finset.sum_nonneg` instead

Note: The updated constant has a different type:
  ∀ {ι : Type u_1} {N : Type u_5} [inst : AddCommMonoid N] [inst_1 : Preorder N] {f : ι → N} {s : Finset ι}
    [AddLeftMono N], (∀ i ∈ s, 0 ≤ f i) → 0 ≤ ∑ i ∈ s, f i
instead of
  ∀ {ι : Type u_1} {N : Type u_5} [inst : AddCommMonoid N] [inst_1 : Preorder N] {f : ι → N} {s : Finset ι}
    [AddLeftMono N], (∀ (i : ι), 0 ≤ f i) → 0 ≤ ∑ i ∈ s, f i
warning: .lake/upstream-src/UnitFractions/ForMathlib/BasicEstimates.lean:1271:8: `Finset.sum_nonneg'` has been deprecated: Use `Finset.sum_nonneg` instead

Note: The updated constant has a different type:
  ∀ {ι : Type u_1} {N : Type u_5} [inst : AddCommMonoid N] [inst_1 : Preorder N] {f : ι → N} {s : Finset ι}
    [AddLeftMono N], (∀ i ∈ s, 0 ≤ f i) → 0 ≤ ∑ i ∈ s, f i
instead of
  ∀ {ι : Type u_1} {N : Type u_5} [inst : AddCommMonoid N] [inst_1 : Preorder N] {f : ι → N} {s : Finset ι}
    [AddLeftMono N], (∀ (i : ι), 0 ≤ f i) → 0 ≤ ∑ i ∈ s, f i
warning: .lake/upstream-src/UnitFractions/ForMathlib/BasicEstimates.lean:1750:81: `if_pos` has been deprecated: Use `ite_eq_left` instead
⚠ [8928/8934] Built UnitFractions.AuxiliaryLemmas (17s)
warning: .lake/upstream-src/UnitFractions/AuxiliaryLemmas.lean:671:14: `List.pow_card_le_prod` has been deprecated: Use `List.pow_length_le_prod` instead
⚠ [8929/8934] Built UnitFractions.Fourier (11s)
warning: .lake/upstream-src/UnitFractions/Fourier.lean:429:8: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/UnitFractions/Fourier.lean:454:8: `if_neg` has been deprecated: Use `ite_eq_right` instead
✔ [8930/8934] Built UnitFractions.MainResults (53s)
⚠ [8931/8934] Built UnitFractions.FinalResults (22s)
warning: .lake/upstream-src/UnitFractions/FinalResults.lean:178:44: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/UnitFractions/FinalResults.lean:186:12: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/UnitFractions/FinalResults.lean:194:12: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/UnitFractions/FinalResults.lean:195:12: `if_neg` has been deprecated: Use `ite_eq_right` instead
warning: .lake/upstream-src/UnitFractions/FinalResults.lean:245:53: `if_pos` has been deprecated: Use `ite_eq_left` instead
✔ [8932/8934] Built UnitFractions.ErdosProblems (10s)
ℹ [8933/8934] Built ErdosProblems.Erdos292 (3.4s)
info: .lake/upstream-src/ErdosProblems/Erdos292.lean:124:0: 'Erdos292.erdos_292' depends on axioms: [propext, Classical.choice, Quot.sound]
ℹ [8934/8934] Built LeanTwenty.JSP000248 (3.2s)
info: LeanTwenty/JSP000248.lean:29:0: 'JSP000248.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
Build completed successfully (8934 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256 `7460dba9e4722b7ebcce9b6753750bb671556bbb054ae5731c5f12ce8cb6a3c2`; original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
'JSP000248.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
'Erdos292.erdos_292' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `verification.json`

SHA256 `f2d270163de0e0773a6a7ded463bedfa066609e5b7caa6e13c11bd4b5c6fbbdb`; original final newline: `false`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "problem": "JSP-000248",
  "started_utc": "2026-09-17T14:52:16.669913+00:00",
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
        "LeanTwenty.JSP000248"
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
        "verification/JSP-000248/Audit.lean"
      ],
      "exit_code": 0,
      "log": "axioms.log"
    }
  ],
  "status": "passed"
}
```
<!-- END artifact: verification.json -->
