# JSP-000746 — preserved CI and certificate evidence, 2026-09-26

This report preserves existing exact-version evidence for [PR #738](https://github.com/TheJustinSunPrize/awards/pull/738). No new Lean compilation or kernel replay was run for this review. The proof target remains **`060945b90e39e6ce77731e31879d83075309bee5`** in `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-completed-20260917`, package `batches/lean5`.

## Fixed source and CI provenance

- [Proof and interfaces](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean).
- [CNF](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Certificates/JSP000746.cnf) and [LRAT](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Certificates/JSP000746.lrat).
- [Fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/scripts/verify.py), [source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/source-lock.json) and [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/.github/workflows/lean5.yml).
- [Run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), dedicated [job 105218613134](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613134): success at the selected proof SHA.
- Artifact `10499052980`, `lean5-JSP-000746`: 6,285 ZIP bytes, SHA256 `912da742447d4bbc194dab04b90128167502b9d555f884119419d9bb9b6ef93b`. Its recorded expiry is 2026-12-16T13:18:54Z.

ZIP integrity, all seven extracted artifact files and 16 selected fixed Git blobs were checked. The CI's 27 source records match the fixed lock. Eight relevant available inputs were independently rehashed: proof, both certificates, toolchain, lakefile, manifest, problem metadata and upstream lock. The other 19 batch records were compared to the manifest, not independently downloaded and rehashed. This report does not claim to review all ten batch problems.

The actual job used a fresh hosted Ubuntu checkout with no project-cache restoration and no tracked project oleans. It downloaded pinned dependency caches, built `LeanTwenty.Problem000746` in 3,112 jobs, audited the three named declarations and replayed that entry module. All nine dependency checkouts match the lock. Actual toolchain output reports Lean 4.34.0, Linux x86_64, commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`; Mathlib is `5ed2965256430c3649e86755f9576b54eca72435`. No explicit `lake clean` or rebuild of all dependencies occurred.

The fixed verifier checks source hashes before and after and writes a failed result on an unsuccessful command or axiom check. The actual job printed:

```text
2026-09-17T13:27:34.8864820Z PASS JSP-000746
```

## Targets and scope

All three observed targets have exactly `[propext, Classical.choice, Quot.sound]`:

- `JSP000746.finite_certificate`: the propositional result generated from the actual CNF/LRAT by `lrat_proof`.
- `JSP000746.erdos_895`: the finite threshold result, choosing 18.
- `JSP000746.on_integers`: every triangle-free graph on the integers has positive `a<b` with `a+b≤18` and all three required nonedges.

`Fin n` value `i` represents label `i+1`; the code's `c.val=a.val+b.val+1` therefore means the third label is the sum of the first two. The smaller-label inequality and positive offset ensure three distinct vertices. Restriction to 18 labels proves all `n≥18`, and the integer interface performs its own embedding. The proof does not establish threshold minimality or resolve a general finite-sums/Hindman-set statement.

The replay covers `LeanTwenty.Problem000746` only, using Lean's bundled kernel with pinned imported dependencies. It is not a second independently implemented Lean checker or a `--fresh` replay of all Mathlib. This is submitter-controlled CI, not independent human mathematical review or organizer acceptance.

## Auxiliary SAT-data check performed during this review

An additional Python check verified that the CNF has precisely 153 unordered-edge variables and 888 clauses: 816 forbid triangles and 72 forbid an independent positive sum triple. Its complete clause multiset and the 153 Lean adjacency arguments match the same edge order. The checker then verified all 2,123 learned-clause additions using their positive unit-propagation hints, processing 307 deletion commands and 33,108 hints, until empty clause 3011. There are no negative RAT hints in this certificate.

For each addition it negates the proposed clause, checks each referenced current clause is unit or conflicting under the accumulated assignment, and requires a contradiction. It never invokes a SAT solver or regenerates a certificate. This is an auxiliary finite-certificate/data check; it is not new Lean execution, independent human review or an independent implementation of Lean's kernel.

The fixed package does not supply a solver version, SAT-generation program or command history sufficient to establish who regenerated this precise LRAT file. The CNF matches the earlier plby CNF; different LRAT bytes do not establish an independently originated encoding or proof route. Certificate correctness and contribution provenance must be assessed separately.

The exact auxiliary result and six complete short CI files follow. The cache-download progress log is omitted from the body; its digest is listed with the other artifact members. Every embedded artifact file was extracted back from this Markdown and rehashed to match the downloaded ZIP member. The original CI record has no per-log digest fields, so this preservation explicitly adds them.

| Artifact member | Bytes | SHA256 |
|---|---:|---|
| `axioms.log` | 254 | `1e150687e8234d22a22773ca4681dfb6983eb0d5bdef2e3794bcf5d17049e73f` |
| `build.log` | 478 | `3b1e63826df0c9e01a6a0deae46b1aee698309d6b4a678d5cf7cc549997a5442` |
| `Audit.lean` | 146 | `fa0831684836d01a1e0cec8c071ca752edfb9554a5292f087c07433a12ffe178` |
| `cache.log` | 9730 | `96285bc4c7c16b60c00f04957f37f3490ef0119cf91d332d9c562e8dcd53bbc3` |
| `kernel.log` | 35 | `1f3669f12215007649c5275837d401c51d7a7a06414be6ddf782e40d1fbb13b9` |
| `toolchain.log` | 1669 | `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de` |
| `verification.json` | 6435 | `428e5e6fa206f9f4ed8dfd259c5b9ab09df242e022a28313e3d6e6f6b1656db6` |

## Auxiliary check result

```json
{
  "method": "Exact CNF graph mapping plus positive-hint RUP verification of every LRAT addition",
  "status": "passed",
  "scope": "Auxiliary finite certificate check, not a new Lean build or independently implemented Lean kernel",
  "variables": 153,
  "clauses": 888,
  "triangle_clauses": 816,
  "sum_triple_clauses": 72,
  "graph_labels": "Fin 18 values i represent positive integer i+1",
  "sum_constraint": "c.val = a.val + b.val + 1 with a.val < b.val",
  "variable_binding_matches_153_Lean_arguments": true,
  "cnf_clause_multiset_matches_graph_constraints": true,
  "lrat_additions_checked": 2123,
  "lrat_deletion_commands": 307,
  "clauses_deleted": 1055,
  "positive_hints_checked": 33108,
  "rat_steps": 0,
  "final_empty_clause": 3011,
  "elapsed_seconds": 0.031,
  "files": [
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
      "path": "LeanTwenty/Problem000746.lean",
      "sha256": "fe741e61ded3523cb4bc0e785475f9ce7e8f41ec24ef6cad45170540042f79ed",
      "bytes": 5730
    }
  ]
}
```

## `Audit.lean`

SHA256: `fa0831684836d01a1e0cec8c071ca752edfb9554a5292f087c07433a12ffe178`; original final newline: `true`.

<!-- BEGIN artifact: Audit.lean -->
```lean
import LeanTwenty.Problem000746

#print axioms JSP000746.erdos_895
#print axioms JSP000746.on_integers
#print axioms JSP000746.finite_certificate
```
<!-- END artifact: Audit.lean -->

## `build.log`

SHA256: `3b1e63826df0c9e01a6a0deae46b1aee698309d6b4a678d5cf7cc549997a5442`; original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
ℹ [3112/3112] Built LeanTwenty.Problem000746 (11s)
info: LeanTwenty/Problem000746.lean:237:0: 'JSP000746.finite_certificate' depends on axioms: [propext, Classical.choice, Quot.sound]
info: LeanTwenty/Problem000746.lean:238:0: 'JSP000746.erdos_895' depends on axioms: [propext, Classical.choice, Quot.sound]
info: LeanTwenty/Problem000746.lean:239:0: 'JSP000746.on_integers' depends on axioms: [propext, Classical.choice, Quot.sound]
Build completed successfully (3112 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256: `1e150687e8234d22a22773ca4681dfb6983eb0d5bdef2e3794bcf5d17049e73f`; original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
'JSP000746.erdos_895' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000746.on_integers' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000746.finite_certificate' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `kernel.log`

SHA256: `1f3669f12215007649c5275837d401c51d7a7a06414be6ddf782e40d1fbb13b9`; original final newline: `true`.

<!-- BEGIN artifact: kernel.log -->
```text
replaying LeanTwenty.Problem000746
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

SHA256: `428e5e6fa206f9f4ed8dfd259c5b9ab09df242e022a28313e3d6e6f6b1656db6`; original final newline: `false`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "problem": "JSP-000746",
  "status": "passed",
  "started_utc": "2026-09-17T13:25:14.562656+00:00",
  "theorems": [
    "JSP000746.erdos_895",
    "JSP000746.on_integers",
    "JSP000746.finite_certificate"
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
      "started_utc": "2026-09-17T13:25:14.565723+00:00",
      "ended_utc": "2026-09-17T13:26:02.995019+00:00",
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
      "started_utc": "2026-09-17T13:26:02.995314+00:00",
      "ended_utc": "2026-09-17T13:27:07.462411+00:00",
      "log": "cache.log"
    },
    {
      "command": [
        "lake",
        "build",
        "LeanTwenty.Problem000746"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:27:07.471985+00:00",
      "ended_utc": "2026-09-17T13:27:20.859847+00:00",
      "log": "build.log"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "verification/JSP-000746/Audit.lean"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:27:20.866634+00:00",
      "ended_utc": "2026-09-17T13:27:23.796695+00:00",
      "log": "axioms.log"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "LeanTwenty.Problem000746"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:27:23.797242+00:00",
      "ended_utc": "2026-09-17T13:27:34.876494+00:00",
      "log": "kernel.log"
    }
  ],
  "replay_scope": "Entry module using Lean bundled kernel; imports dependencies, not --fresh",
  "verification_kind": "submitter-run, not independent human review",
  "completed_utc": "2026-09-17T13:27:34.886044+00:00"
}
```
<!-- END artifact: verification.json -->

