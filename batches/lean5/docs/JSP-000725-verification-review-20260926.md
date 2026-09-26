# JSP-000725: fixed-source and preserved CI review

Reviewed 2026-09-26 for [PR #730](https://github.com/TheJustinSunPrize/awards/pull/730). This report concerns unchanged proof `060945b90e39e6ce77731e31879d83075309bee5` in `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-completed-20260917`, package `batches/lean5`. The present branch contains the pin. No new Lean execution or proof modification was performed.

## Source and scope of this verification

The fixed [entry](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/JSP000725.lean) imports the attributed complete earlier proof and exposes `JSP000725.solution`. The advertised scope is: Disjoint subset-sum layers: asymptotic 2 sqrt N, eventual exact cardinality. This source-level description remains subject to mathematical and statement correspondence review; a technical CI result is not a mathematical priority or award decision.

All **93 repository Git blobs** (62 in this package), all **27** [local-source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/source-lock.json) hashes, and all **48** independently retrieved [upstream lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/upstream-lock.json) hashes matched. External sources are fixed at plby `8822f7ddef30fadbd92e1c6ab4ed897af356af5e`; no floating source was substituted. The selected entry's local/external source import closure contains **42 Lean files**. The shared record contains other problems' source hashes, but their mathematical results or CI jobs are not attributed to this entry.

The complete core is reused with retained notices. The local contribution recorded at the proof pin is: Reuses the complete plby proof with a direct JSP interface to the asymptotic and eventual exact formula. That interface/port work does not by itself establish original complete-proof authorship by the submitting account. No new mathematics, firstness or independent human verification is claimed.

## Dedicated successful CI at the selected SHA

[Run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), dedicated [job 105218612728](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218612728), succeeded on 2026-09-17. Both run metadata and the checkout log identify exactly the selected SHA. The recovered `lean5-JSP-000725` artifact **10499657507** is **7665 bytes**, ZIP SHA256 **`2fa131bdebe13569081bcce1aa2272b843faee5aa0dfb7141a6e50f1ad62dc5b`**, independently matching GitHub's digest.

The actual job built **8966 jobs**, including `Built LeanTwenty.JSP000725`. It then separately audited exactly **3 advertised targets** and replayed `LeanTwenty.JSP000725`. The five timed commands (Lean version, dependency cache, project build, terminal audit, entry-module replay) all returned zero. The generated `Audit.lean` exactly matches the pinned verifier's import and target recipe; every target reports `[propext, Classical.choice, Quot.sound]`, without `sorryAx`, `Lean.ofReduceBool` or an extra mathematical axiom. The output below is the actual current CI artifact, not an older committed local log.

The hosted workflow starts from a fresh project checkout with no project-cache restore or tracked project oleans. Mathlib dependency caches are used. This is not an explicit `lake clean` invocation, a rebuild of all imported dependencies or an independently implemented proof checker. The bundled Lean kernel replay covers the entry module with its dependencies imported, not a separate `--fresh` replay of the whole dependency graph.

The actual version output identifies Lean **4.34.0**. All nine dependency checkouts in the combined toolchain/cache transcripts match the fixed [manifest](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/lake-manifest.json), including Mathlib **`5ed2965256430c3649e86755f9576b54eca72435`**. The verifier checks all local source hashes before and after the run and downloads the 48 dependencies against immutable content hashes. The original report did not record per-log hashes; the downloaded ZIP digest and this review's per-member hashes provide byte preservation without rewriting historical records.

## Reproduction

Use Python **3.12 or newer**, because the fixed verifier uses that language syntax, plus Lean/elan and the fixed dependency environment.

```sh
git clone --branch codex/lean5-completed-20260917 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 060945b90e39e6ce77731e31879d83075309bee5
cd batches/lean5
python3 scripts/verify.py --prepare-only
lake exe cache get
lake clean
python3 scripts/verify.py --problem JSP-000725
```

The explicit clean command is a reproduction instruction, not a newly executed check. The fixed [verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/scripts/verify.py), [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/.github/workflows/lean5.yml), [toolchain](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/lean-toolchain) and lock files define the original procedure. The named axiom audits and single entry replay are preserved below.

## Artifact member integrity

The original archive expires 2026-12-16. All seven member hashes are preserved; six short members are embedded. The larger cache transcript remains represented by its exact digest, dependency pins above and linked CI job. The source locks bind the original inputs independently of artifact retention.

| Member | Bytes | SHA256 |
| --- | --- | --- |
| `Audit.lean` | 149 | `4dd3e374008e6d2c3a01c7cef69adfb77e9e4a12f827062258e770a21c26d74f` |
| `axioms.log` | 261 | `5b570051068987e94bd6f4858a02046c721a0d8c22a678cd3c9974a82d8e7574` |
| `build.log` | 7352 | `149f8f96f0e37b9da91ff3bd324b3c357e39880904444656e7e24ad705bcd08b` |
| `cache.log` | 11053 | `78b3416999d32e0e4b30ef19cdc835ffcb0eb347bd4e86f824c11b1cd49e02e1` |
| `kernel.log` | 31 | `6385c3c473bd9cf204740489f450164ad4a330311e3b7a1aca050615036cdff4` |
| `toolchain.log` | 1669 | `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de` |
| `verification.json` | 6434 | `b683267749594d828309a08d0b6b6a4c78227bd1562a35de11c790a0e1b3d3c8` |

## `verification.json`

Original final newline: `false`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "problem": "JSP-000725",
  "status": "passed",
  "started_utc": "2026-09-17T13:19:12.347548+00:00",
  "theorems": [
    "JSP000725.solution",
    "JSP000725.eventual_exact",
    "JSP000725.eventual_cardinal_bound"
  ],
  "allowed_axioms": [
    "Classical.choice",
    "Quot.sound",
    "propext"
  ],
  "lean": "4.34.0",
  "mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "source_hashes": [
    {
      "path": "LeanTwenty/JSP000759.lean",
      "sha256": "8d71bc141d32ce4da7b5637a8cbcdced605d0dbf1d19902367d1b663adbb3247",
      "bytes": 9858
    },
    {
      "path": "LeanTwenty/Problem000746.lean",
      "sha256": "fe741e61ded3523cb4bc0e785475f9ce7e8f41ec24ef6cad45170540042f79ed",
      "bytes": 5730
    },
    {
      "path": "LeanTwenty/JSP000690.lean",
      "sha256": "9dea96349e7f72d78b456d7273cdb03c8d46208aa23c60ef0a79ac6ee5a52795",
      "bytes": 6307
    },
    {
      "path": "LeanTwenty/JSP000897.lean",
      "sha256": "04ec9c946fe06fd0e7ed53b8efa9314577b84bb61eb6a56d5d2c4b794632275b",
      "bytes": 1235
    },
    {
      "path": "LeanTwenty/Upstream/Erdos1079.lean",
      "sha256": "e3aa40e54458784d54a72482a7716be65f582a8691899efe36dde9e3cc07509e",
      "bytes": 18718
    },
    {
      "path": "LeanTwenty/JSP000896.lean",
      "sha256": "b4a7537d1ac2187ebda2f33e6016b27f8197edf0dc6b2845ed989d3020a2a5bb",
      "bytes": 890
    },
    {
      "path": "LeanTwenty/Upstream/Erdos1078.lean",
      "sha256": "79055365caf42f6ec4e3c7ff5bd7863a73af74b2c798951aa516facbdf94130c",
      "bytes": 37800
    },
    {
      "path": "LeanTwenty/JSP000842.lean",
      "sha256": "02dcab35cf9a72a6b4097caa204fe64fa23ef505083c8d8cb06ea09ee5814f97",
      "bytes": 1102
    },
    {
      "path": "LeanTwenty/JSP001021.lean",
      "sha256": "d7e3c477bfb46608db6afecaaa715cd906f8d9319212fd159e95454296234b0f",
      "bytes": 3381
    },
    {
      "path": "LeanTwenty/Upstream/Erdos1216.lean",
      "sha256": "96d70169d8946ed780c9419139bc34cddc38f836c344ae0b47ff28c0a39cc3fa",
      "bytes": 48635
    },
    {
      "path": "LeanTwenty/Upstream/Erdos1216/Certificates.lean",
      "sha256": "da9a1c93e177bc814ef80984c5afed176777547ffcaf449b327023bbd98b27c0",
      "bytes": 3263124
    },
    {
      "path": "LeanTwenty/JSP000653.lean",
      "sha256": "b01200abec3ef792d1cad24e88f46b551a53af5348bd895b07224bc6411d38d9",
      "bytes": 1473
    },
    {
      "path": "LeanTwenty/JSP000733.lean",
      "sha256": "61d6035f89ac432767ef13dd06e3992dad8ae8b658f97872c1981c4348d95d9b",
      "bytes": 10063
    },
    {
      "path": "LeanTwenty/External/Erdos882/Core.lean",
      "sha256": "c00a0906cfe3f0dcb7cc8e7cb968e0711cb39c7b04833d48f289759aa6b83fb6",
      "bytes": 26074
    },
    {
      "path": "LeanTwenty/JSP000725.lean",
      "sha256": "8866113ea9d0bd63f41ff36566251e4285875f8f078152a70714d541afd5b9f0",
      "bytes": 1771
    },
    {
      "path": "LeanTwenty.lean",
      "sha256": "d6c66c86a314af12d73ee96d69f765db5605855c56064651584c957cdde57c4f",
      "bytes": 493
    },
    {
      "path": "lean-toolchain",
      "sha256": "8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632",
      "bytes": 25
    },
    {
      "path": "lake-manifest.json",
      "sha256": "c910a858577ad46005840705bb04421e3c5367f713536472abd07e198a901f97",
      "bytes": 3511
    },
    {
      "path": "LeanTwenty/Certificates/JSP000746.cnf",
      "sha256": "260b7c50fac4fcc4525f7253eb37a8750bf744cff5bb41e92a314cdea1ccab45",
      "bytes": 12986
    },
    {
      "path": "LeanTwenty/Certificates/JSP000746.lrat",
      "sha256": "55172fa9925cb62926d91a078590e9480b294b5c7727e27e8b68858ca20ac20b",
      "bytes": 218957
    },
    {
      "path": "LeanTwenty/External/Erdos882/LICENSE",
      "sha256": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
      "bytes": 11358
    },
    {
      "path": "LeanTwenty/External/Erdos882/NOTICE.md",
      "sha256": "a59d9d37245e18984764dd39d8bbad8caf5ebb85307fa828821664762c83b376",
      "bytes": 503
    },
    {
      "path": "LeanTwenty/Upstream/NOTICE.md",
      "sha256": "d2596184fd29fac17272cfa74c119ac1b9a37a4a280ac7c04e2f199357830f15",
      "bytes": 1141
    },
    {
      "path": "licenses/Apache-2.0.txt",
      "sha256": "cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30",
      "bytes": 11358
    },
    {
      "path": "lakefile.toml",
      "sha256": "cde26a663f61ee2593fa768a6d683b797d3b614f7ff48ae393a1bc07b9917be0",
      "bytes": 278
    },
    {
      "path": "proofs.json",
      "sha256": "179941858f184f3a3136d27da40058aae6ce4a6c513cc9c58f0e8fbb62cf0f52",
      "bytes": 7540
    },
    {
      "path": "upstream-lock.json",
      "sha256": "02bd63c567ea09ac03d6a91a47194fb365b108b9a7c6eeefa96ca165559f4720",
      "bytes": 11286
    }
  ],
  "checks": [
    {
      "command": [
        "lake",
        "env",
        "lean",
        "--version"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:19:12.352135+00:00",
      "ended_utc": "2026-09-17T13:20:07.586400+00:00",
      "log": "toolchain.log"
    },
    {
      "command": [
        "lake",
        "exe",
        "cache",
        "get"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:20:07.586763+00:00",
      "ended_utc": "2026-09-17T13:21:09.516452+00:00",
      "log": "cache.log"
    },
    {
      "command": [
        "lake",
        "build",
        "LeanTwenty.JSP000725"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:21:09.516803+00:00",
      "ended_utc": "2026-09-17T13:27:57.638510+00:00",
      "log": "build.log"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "verification/JSP-000725/Audit.lean"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:27:57.639138+00:00",
      "ended_utc": "2026-09-17T13:28:02.503615+00:00",
      "log": "axioms.log"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "LeanTwenty.JSP000725"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:28:02.504422+00:00",
      "ended_utc": "2026-09-17T13:28:13.355579+00:00",
      "log": "kernel.log"
    }
  ],
  "replay_scope": "Entry module using Lean bundled kernel; imports dependencies, not --fresh",
  "verification_kind": "submitter-run, not independent human review",
  "completed_utc": "2026-09-17T13:28:13.368957+00:00"
}
```
<!-- END artifact: verification.json -->

## `Audit.lean`

Original final newline: `true`.

<!-- BEGIN artifact: Audit.lean -->
```lean
import LeanTwenty.JSP000725

#print axioms JSP000725.solution
#print axioms JSP000725.eventual_exact
#print axioms JSP000725.eventual_cardinal_bound
```
<!-- END artifact: Audit.lean -->

## `build.log`

Original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
✔ [8365/8421] Built Mathlib.Probability.Kernel.Invariance (1.5s)
✔ [8922/8927] Built Mathlib (3.4s)
✔ [8923/8927] Built ErdosProblems.Erdos874.Asymptotics (6.5s)
✔ [8924/8927] Built ErdosProblems.Erdos874.Foundations (4.1s)
✔ [8925/8929] Built ErdosProblems.Erdos874.ExactUpper (5.3s)
✔ [8926/8929] Built ErdosProblems.Erdos874.Tail (8.6s)
✔ [8927/8929] Built ErdosProblems.Erdos874.RestrictedGrowth (4.6s)
✔ [8928/8930] Built ErdosProblems.Erdos874.FreimanDimension (4.9s)
✔ [8929/8937] Built ErdosProblems.Erdos874.FreimanNormalization (4.6s)
✔ [8930/8939] Built ErdosProblems.Erdos13.Erdos13MulStab (5.0s)
✔ [8931/8939] Built ErdosProblems.Erdos13.Erdos13Kneser (6.8s)
⚠ [8932/8939] Built ErdosProblems.Erdos874.ProgressionExtraction (4.8s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/ProgressionExtraction.lean:287:18: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/ProgressionExtraction.lean:287:32: `dif_pos` has been deprecated: Use `dite_eq_left` instead
⚠ [8933/8941] Built ErdosProblems.Erdos13.Erdos13Additive (13s)
warning: .lake/upstream-src/ErdosProblems/Erdos13/Erdos13Additive.lean:385:36: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos13/Erdos13Additive.lean:400:35: `if_neg` has been deprecated: Use `ite_eq_right` instead
✔ [8934/8941] Built ErdosProblems.Erdos874.LongProgression (6.0s)
✔ [8935/8943] Built ErdosProblems.Erdos874.LevSmelianski (4.1s)
✔ [8936/8943] Built ErdosProblems.Erdos874.PopularPairs (7.0s)
✔ [8937/8943] Built ErdosProblems.Erdos874.FreimanNormalizedCore (4.1s)
⚠ [8938/8943] Built ErdosProblems.Erdos874.RestrictedSums (5.7s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/RestrictedSums.lean:272:27: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RestrictedSums.lean:272:41: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RestrictedSums.lean:272:55: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RestrictedSums.lean:273:4: `dif_pos` has been deprecated: Use `dite_eq_left` instead
✔ [8939/8944] Built ErdosProblems.Erdos874.NearIndexFiber (5.6s)
✔ [8940/8945] Built ErdosProblems.Erdos874.FreimanThreeKInductive (4.6s)
✔ [8941/8945] Built ErdosProblems.Erdos874.LayerSelection (6.9s)
✔ [8942/8946] Built ErdosProblems.Erdos874.FreimanThreeKMinusFour (4.3s)
✔ [8943/8946] Built ErdosProblems.Erdos874.ModularDecomposition (4.4s)
✔ [8944/8947] Built ErdosProblems.Erdos874.FreimanEngine (7.3s)
⚠ [8945/8947] Built ErdosProblems.Erdos874.ResidueSubgroup (5.7s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/ResidueSubgroup.lean:51:24: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/ResidueSubgroup.lean:92:24: `if_neg` has been deprecated: Use `ite_eq_right` instead
✔ [8946/8951] Built ErdosProblems.Erdos874.SubgroupGenerators (1.5s)
⚠ [8947/8953] Built ErdosProblems.Erdos874.ConvexTranslate (8.4s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/ConvexTranslate.lean:725:29: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: .lake/upstream-src/ErdosProblems/Erdos874/ConvexTranslate.lean:744:29: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
✔ [8948/8954] Built ErdosProblems.Erdos874.MixedSumPath (4.8s)
✔ [8949/8954] Built ErdosProblems.Erdos874.RegularSpan (18s)
⚠ [8950/8955] Built ErdosProblems.Erdos874.ResidueAlignment (9.2s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/ResidueAlignment.lean:393:8: `dif_pos` has been deprecated: Use `dite_eq_left` instead
⚠ [8951/8955] Built ErdosProblems.Erdos874.RoughUpper (14s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/RoughUpper.lean:345:18: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RoughUpper.lean:345:47: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RoughUpper.lean:353:23: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RoughUpper.lean:366:18: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/RoughUpper.lean:367:18: `dif_pos` has been deprecated: Use `dite_eq_left` instead
✔ [8952/8956] Built ErdosProblems.Erdos874.AlignedBlockSum (6.6s)
✔ [8953/8956] Built ErdosProblems.Erdos874.SmallFourLayer (8.3s)
✔ [8954/8958] Built ErdosProblems.Erdos874.ModularStructure (32s)
✔ [8955/8958] Built ErdosProblems.Erdos874.StrausUpper (4.0s)
✔ [8956/8958] Built ErdosProblems.Erdos874.Thresholds (43s)
✔ [8957/8960] Built ErdosProblems.Erdos874.Structure (6.9s)
✔ [8958/8961] Built ErdosProblems.Erdos874.CentralSpan (15s)
✔ [8960/8966] Built ErdosProblems.Erdos874.LayerOrdering (4.2s)
⚠ [8961/8966] Built ErdosProblems.Erdos874.LocalDensity (9.3s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:958:30: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:960:8: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:966:8: `if_neg` has been deprecated: Use `ite_eq_right` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:988:28: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:1005:23: `if_pos` has been deprecated: Use `ite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:1010:23: `if_neg` has been deprecated: Use `ite_eq_right` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/LocalDensity.lean:1136:22: `dif_pos` has been deprecated: Use `dite_eq_left` instead
✔ [8962/8966] Built ErdosProblems.Erdos874.DensityEndgame (8.3s)
⚠ [8963/8966] Built ErdosProblems.Erdos874.CentralExtractor (42s)
warning: .lake/upstream-src/ErdosProblems/Erdos874/CentralExtractor.lean:594:34: `dif_neg` has been deprecated: Use `dite_eq_right` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/CentralExtractor.lean:596:10: `dif_pos` has been deprecated: Use `dite_eq_left` instead
warning: .lake/upstream-src/ErdosProblems/Erdos874/CentralExtractor.lean:613:10: `dif_neg` has been deprecated: Use `dite_eq_right` instead
✔ [8964/8966] Built ErdosProblems.Erdos874.EndpointOrientation (15s)
✔ [8965/8966] Built ErdosProblems.Erdos874 (3.9s)
ℹ [8966/8966] Built LeanTwenty.JSP000725 (3.9s)
info: LeanTwenty/JSP000725.lean:47:0: 'JSP000725.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
info: LeanTwenty/JSP000725.lean:48:0: 'JSP000725.eventual_exact' depends on axioms: [propext, Classical.choice, Quot.sound]
info: LeanTwenty/JSP000725.lean:49:0: 'JSP000725.eventual_cardinal_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
Build completed successfully (8966 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

Original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
'JSP000725.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000725.eventual_exact' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000725.eventual_cardinal_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `kernel.log`

Original final newline: `true`.

<!-- BEGIN artifact: kernel.log -->
```text
replaying LeanTwenty.JSP000725
```
<!-- END artifact: kernel.log -->

## `toolchain.log`

Original final newline: `true`.

<!-- BEGIN artifact: toolchain.log -->
```text
info: downloading https://releases.lean-lang.org/lean4/v4.34.0/lean-4.34.0-linux.tar.zst
info: installing /home/runner/.elan/toolchains/leanprover--lean4---v4.34.0
info: mathlib: cloning https://github.com/leanprover-community/mathlib4.git
info: mathlib: checking out revision '5ed2965256430c3649e86755f9576b54eca72435'
info: plausible: cloning https://github.com/leanprover-community/plausible
info: plausible: checking out revision '118aa17ee84656b8bd727fef7c458ee8c833385c'
info: LeanSearchClient: cloning https://github.com/leanprover-community/LeanSearchClient
info: LeanSearchClient: checking out revision 'ddf04cf3949fa556442341e87d47f9f6e6074707'
info: importGraph: cloning https://github.com/leanprover-community/import-graph
info: importGraph: checking out revision 'e928b72544873815af278d38681b31c0293588e3'
info: proofwidgets: cloning https://github.com/leanprover-community/ProofWidgets4
info: proofwidgets: checking out revision '106ff4fafc74ef4ac99d81dbf3ab399118f497a5'
info: aesop: cloning https://github.com/leanprover-community/aesop
info: aesop: checking out revision '355695d523e41d0554926416cba2a2b3544fbbc9'
info: Qq: cloning https://github.com/leanprover-community/quote4
info: Qq: checking out revision '6a489d9af5d0c47e5b259e2e8bcdfc1811b5a259'
info: batteries: cloning https://github.com/leanprover-community/batteries
info: batteries: checking out revision 'f2effa3d803fda822b1f97b806c47cf2adfbcbc2'
info: Cli: cloning https://github.com/leanprover/lean4-cli
info: Cli: checking out revision 'e92c9f15fdfacc8536f31cfb3b7ad26c3c8cd204'
Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)
```
<!-- END artifact: toolchain.log -->
