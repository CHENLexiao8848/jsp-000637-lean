# JSP-000733 — preserved CI evidence, 2026-09-26

This report preserves existing exact-version evidence for [PR #731](https://github.com/TheJustinSunPrize/awards/pull/731) and its duplicate [PR #798](https://github.com/TheJustinSunPrize/awards/pull/798). Both select the same proof; this is one contribution record. No new Lean compilation or kernel replay was run for this review. The tested proof is **`060945b90e39e6ce77731e31879d83075309bee5`** in `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-completed-20260917`, package `batches/lean5`.

## Fixed source and CI provenance

- [Entry proof](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/JSP000733.lean) and [bundled ToshiDad lower-bound core](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/External/Erdos882/Core.lean).
- [Fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/scripts/verify.py), [source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/source-lock.json), and [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/.github/workflows/lean5.yml).
- [Run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), dedicated [job 105218613081](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613081): success at the selected proof SHA.
- Artifact `10499526724`, `lean5-JSP-000733`: 6,090 ZIP bytes, SHA256 `f532b063b9e14067fe7beff91012f44fd5caba457280a5a42ba32ceeec49a34e`, matching GitHub's artifact digest. Its recorded expiry is 2026-12-16T13:18:54Z.

ZIP integrity and all seven extracted members were checked. Seventeen selected fixed Git blobs matched the proof tree. The CI's 27 source records match the fixed lock; nine relevant available inputs were independently rehashed: entry, core, core license/notice, toolchain, lakefile, dependency manifest, proof list, and upstream lock. The other 18 batch records were compared to the fixed manifest, not independently downloaded and rehashed. This report does not audit all ten batch problems.

The actual job used a fresh hosted Ubuntu checkout with no project-cache restoration or tracked project oleans. It downloaded dependency caches and actually built both `LeanTwenty.External.Erdos882.Core` and `LeanTwenty.JSP000733`; the build reports 8,925 jobs. All nine dependency checkouts match the lock. The toolchain reports Lean 4.34.0, Linux x86_64, commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`; Mathlib is `5ed2965256430c3649e86755f9576b54eca72435`. There was no explicit `lake clean` or rebuild of all cached dependencies.

The fixed verifier checks source hashes before and after the build/audit/replay and writes a failed result for an unsuccessful command or axiom check. All five recorded commands exited zero; verification ended at 2026-09-17 13:24:16 UTC and the dedicated job printed `PASS JSP-000733`. The old local evidence JSON and log describe earlier cached local verification and are separate from this successful exact-SHA CI. Later documentation corrections are likewise not additional proof executions.

## Terminal and scope

The generated audit imports the entry and checks the sole advertised terminal, `JSP000733.solution`:

```lean
Tendsto (fun n : ℕ => (maximumSize n : ℝ) / Real.logb 2 n) atTop (𝓝 1)
```

Its observed axioms are exactly `[propext, Classical.choice, Quot.sound]`. `maximumSize` is the actual finite extremal cardinality, with a proved attainment lemma. Admissible sets lie in `Finset.Icc 1 n`; the primitive-sums condition says divisibility between nonempty subset-sum values forces those values to be equal. Injectivity of the subset-sum map is proved locally, not assumed. The proof combines the imported construction with local counting and a limit argument. The final target has no additional positive-`n`, convergence, or desired-conclusion assumption. It establishes the leading asymptotic, not an exact formula or a half-log-log/bounded-additive-error refinement.

The replay covers `LeanTwenty.JSP000733` only, using Lean's bundled kernel with pinned imported dependencies. It does not separately replay the bundled core or all Mathlib under `--fresh`, and is not a second independently implemented checker. The core is compiled by the same run. This is submitter-controlled technical evidence, not independent human mathematical review, organizer acceptance, or a decision about contribution priority over earlier complete implementations.

From the fixed package, reproduce with `python scripts/verify.py --problem JSP-000733 --fetch-cache`. The original artifact's six short audit files are preserved below; the cache-download progress log is omitted from the body and included in the member digest table. Each embedded file was extracted back from this Markdown and rehashed against its exact ZIP member. The original CI record has no per-log digest fields; this preservation supplies them. The original JSON's absent final newline is explicitly recorded.


| Artifact member | Bytes | SHA256 |
|---|---:|---|
| `Audit.lean` | 62 | `92110fad5ae3ff8c0c5005719832a8ac382ba37edafe5cb34d06b262766a4059` |
| `axioms.log` | 80 | `cb764a647697992a15f8b76becafe25678f4c76dfd397bb013c0537eeac81e76` |
| `build.log` | 378 | `22d575daa63c8cb45b8c8360b9209337f432bc204a41971d4c7da25590fd1f11` |
| `cache.log` | 9083 | `f50690a3e29eaf86df1568933ce102627a71f3eaec65dcdb6c0b808c240c95be` |
| `kernel.log` | 31 | `cb3dcd6201dd8e3cb26754868180cb20e52b1f44d5b8ca23e2b649087b369a9a` |
| `toolchain.log` | 1669 | `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de` |
| `verification.json` | 6361 | `231d2de7aaff1f5d1250fde1e7993503dd45316708171987d40189f46571e8a1` |

## `Audit.lean`

SHA256: `92110fad5ae3ff8c0c5005719832a8ac382ba37edafe5cb34d06b262766a4059`; original final newline: `true`.

<!-- BEGIN artifact: Audit.lean -->
```lean
import LeanTwenty.JSP000733

#print axioms JSP000733.solution
```
<!-- END artifact: Audit.lean -->

## `build.log`

SHA256: `22d575daa63c8cb45b8c8360b9209337f432bc204a41971d4c7da25590fd1f11`; original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
✔ [8365/8375] Built Mathlib.Probability.Kernel.Invariance (1.5s)
✔ [8923/8925] Built Mathlib (3.3s)
✔ [8924/8925] Built LeanTwenty.External.Erdos882.Core (8.5s)
ℹ [8925/8925] Built LeanTwenty.JSP000733 (6.0s)
info: LeanTwenty/JSP000733.lean:232:0: 'JSP000733.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
Build completed successfully (8925 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256: `cb764a647697992a15f8b76becafe25678f4c76dfd397bb013c0537eeac81e76`; original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
'JSP000733.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `kernel.log`

SHA256: `cb3dcd6201dd8e3cb26754868180cb20e52b1f44d5b8ca23e2b649087b369a9a`; original final newline: `true`.

<!-- BEGIN artifact: kernel.log -->
```text
replaying LeanTwenty.JSP000733
```
<!-- END artifact: kernel.log -->

## `toolchain.log`

SHA256: `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de`; original final newline: `true`.

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

## `verification.json`

SHA256: `231d2de7aaff1f5d1250fde1e7993503dd45316708171987d40189f46571e8a1`; original final newline: `false`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "problem": "JSP-000733",
  "status": "passed",
  "started_utc": "2026-09-17T13:21:48.870080+00:00",
  "theorems": [
    "JSP000733.solution"
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
      "started_utc": "2026-09-17T13:21:48.874815+00:00",
      "ended_utc": "2026-09-17T13:22:37.556804+00:00",
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
      "started_utc": "2026-09-17T13:22:37.557144+00:00",
      "ended_utc": "2026-09-17T13:23:34.809167+00:00",
      "log": "cache.log"
    },
    {
      "command": [
        "lake",
        "build",
        "LeanTwenty.JSP000733"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:23:34.809549+00:00",
      "ended_utc": "2026-09-17T13:24:00.956263+00:00",
      "log": "build.log"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "verification/JSP-000733/Audit.lean"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:24:00.956839+00:00",
      "ended_utc": "2026-09-17T13:24:05.917972+00:00",
      "log": "axioms.log"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "LeanTwenty.JSP000733"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:24:05.947995+00:00",
      "ended_utc": "2026-09-17T13:24:16.908026+00:00",
      "log": "kernel.log"
    }
  ],
  "replay_scope": "Entry module using Lean bundled kernel; imports dependencies, not --fresh",
  "verification_kind": "submitter-run, not independent human review",
  "completed_utc": "2026-09-17T13:24:16.918574+00:00"
}
```
<!-- END artifact: verification.json -->

