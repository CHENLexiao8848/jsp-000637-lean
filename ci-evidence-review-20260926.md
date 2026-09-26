# JSP-000759: preserved exact-version CI evidence and review

Reviewed and preserved on 2026-09-26 for [awards PR #739](https://github.com/TheJustinSunPrize/awards/pull/739). **The selected proof's existing CI build, two-target axiom audit and entry-module replay passed on 2026-09-17. This document rechecks and preserves those historical results; no new Lean execution was performed on 2026-09-26.**

Proof repository: [CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean); branch `codex/lean5-completed-20260917`; selected proof commit `060945b90e39e6ce77731e31879d83075309bee5`; project root `batches/lean5`; module `LeanTwenty.JSP000759`. This later documentation version does not replace the selected proof commit. The companion [mathematical counterexample and contribution review](review-supplement.md) supplies the complete argument and explicit scope.

## CI identity and artifact preservation

- [Workflow run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), attempt 1, records `head_sha=060945b90e39e6ce77731e31879d83075309bee5`, status `completed` and conclusion `success`.
- [JSP-000759 job 105218613312](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613312) is the relevant completed job; other problems in the batch are outside this review's proof scope.
- [Artifact 10499013470](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/artifacts/10499013470), `lean5-JSP-000759`, is **6,647 bytes**. Its independently recomputed ZIP SHA-256 is `d1ae21204b4c5a56b0e6487d9084afbc49c3f826a07464ef5050fe3639efac72`, matching both freshly retrieved GitHub metadata and the original upload log.
- ZIP integrity was checked, and all seven extracted members matched their archive bytes. The short proof-verification records are preserved verbatim below. The longer dependency-download progress log is identified by its original byte hash rather than embedded; no project proof check depends on that progress text.
- GitHub metadata listed artifact expiry as `2026-12-16T13:18:54Z` when retrieved. Preserving these source-bound records as Markdown avoids relying on the temporary Actions artifact for the terminal build/audit/replay evidence.

## What the evidence establishes

The [fixed workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/.github/workflows/lean5.yml) starts from a fresh GitHub-hosted Ubuntu checkout, restores no local project proof-artifact cache, and runs the selected verification script with Python 3.12. The job log identifies Ubuntu 24.04.5, Python 3.12.14 and the exact proof commit. Inspection of the complete selected tree found no tracked `.lake` directory or project `.olean` in this package. The build log explicitly says `Built LeanTwenty.JSP000759 (8.4s)` and `Build completed successfully (3107 jobs)`. This supports fresh CI compilation of this module, using pinned Mathlib dependency caches rather than rebuilding all dependencies from source.

The five command records in the original `verification.json` below all report exit 0: toolchain identification, dependency cache retrieval, target module build, two-target axiom audit and entry replay. The audit declares exactly `JSP000759.solution` and `JSP000759.no_five_paths`, each with only `propext`, `Classical.choice` and `Quot.sound`. Four nonfatal linter warnings remain in the original build transcript.

The recorded replay covers `LeanTwenty.JSP000759` through Lean's bundled checker with imported dependencies. It is not `--fresh` replay of all Mathlib and not a second independently implemented checker. The workflow is submitter-controlled. This evidence review does not establish independent human review, maintainer approval, authorship, priority or prize eligibility.

## Fixed inputs rechecked on 2026-09-26

Six downloaded inputs were individually rehashed against the selected source lock and CI record. Nine Git blob checks additionally bind those inputs, the source lock, the script and the workflow to the selected commit tree. All 27 records in the batch source lock equal the CI record; the other 21 unrelated batch files were not separately downloaded and rehashed in this review. The target proof imports only Mathlib.

| Rehashed selected-project file | SHA-256 |
| --- | --- |
| `LeanTwenty/JSP000759.lean` | `8d71bc141d32ce4da7b5637a8cbcdced605d0dbf1d19902367d1b663adbb3247` |
| `lean-toolchain` | `8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632` |
| `lake-manifest.json` | `c910a858577ad46005840705bb04421e3c5367f713536472abd07e198a901f97` |
| `lakefile.toml` | `cde26a663f61ee2593fa768a6d683b797d3b614f7ff48ae393a1bc07b9917be0` |
| `proofs.json` | `179941858f184f3a3136d27da40058aae6ce4a6c513cc9c58f0e8fbb62cf0f52` |
| `upstream-lock.json` | `02bd63c567ea09ac03d6a91a47194fb365b108b9a7c6eeefa96ca165559f4720` |

All nine dependency checkout revisions in the original toolchain log match the selected manifest:

| Package | Revision |
| --- | --- |
| `mathlib` | `5ed2965256430c3649e86755f9576b54eca72435` |
| `plausible` | `118aa17ee84656b8bd727fef7c458ee8c833385c` |
| `LeanSearchClient` | `ddf04cf3949fa556442341e87d47f9f6e6074707` |
| `importGraph` | `e928b72544873815af278d38681b31c0293588e3` |
| `proofwidgets` | `106ff4fafc74ef4ac99d81dbf3ab399118f497a5` |
| `aesop` | `355695d523e41d0554926416cba2a2b3544fbbc9` |
| `Qq` | `6a489d9af5d0c47e5b259e2e8bcdfc1811b5a259` |
| `batteries` | `f2effa3d803fda822b1f97b806c47cf2adfbcbc2` |
| `Cli` | `e92c9f15fdfacc8536f31cfb3b7ad26c3c8cd204` |

## Artifact member hashes

These hashes were recomputed from the original ZIP members. The embedded logs and audit source retain their original text and LF line endings. The original `verification.json` ends at `}` with no final newline; the newline separating that character from its closing Markdown fence is formatting only and must be excluded when reconstructing the hashed file. The `/home/runner` path in the toolchain log is the original public hosted-runner path.

| Member | SHA-256 | Preserved below |
| --- | --- | --- |
| `Audit.lean` | `ecefbaf0ffd9db092d9d2f0033bf3bf3a0c9893668ee9342d8c40cc2090343ba` | Full original text |
| `axioms.log` | `822a62580ef44981c681f5806e90d9468d6f0ff9f805f74c313d62a8cb42ea3e` | Full original text |
| `build.log` | `506cc974eabd5e5e08c537766dcec83d4c0871784723cf48bd3f5a50ee8fc513` | Full original text |
| `cache.log` | `c76c512fec891276c3253be81946a90bf8d05dd9103e8a44958998e1c42e3fc2` | Hash only |
| `kernel.log` | `53bc98a0d7a971e479be1899e06f9673068f3aa9d9817087b23e2118bbed266f` | Full original text |
| `toolchain.log` | `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de` | Full original text |
| `verification.json` | `49c9e9ca918d1b53ae365ef8ff7dfd5aff0ee3b032f22c00f2e17b8ef7748477` | Full original text |

## Original job-log excerpts

The following exact lines tie the checkout to the artifact upload; other job-log lines are omitted.

```text
2026-09-17T13:26:52.2581609Z 060945b90e39e6ce77731e31879d83075309bee5
2026-09-17T13:29:10.0066489Z SHA256 digest of uploaded artifact zip is d1ae21204b4c5a56b0e6487d9084afbc49c3f826a07464ef5050fe3639efac72
2026-09-17T13:29:10.2135070Z Artifact lean5-JSP-000759.zip successfully finalized. Artifact ID 10499013470
2026-09-17T13:29:10.2136915Z Artifact lean5-JSP-000759 has been successfully uploaded! Final size is 6647 bytes. Artifact ID is 10499013470
```

## verification.json

Original SHA-256: `49c9e9ca918d1b53ae365ef8ff7dfd5aff0ee3b032f22c00f2e17b8ef7748477`.

```json
{
  "problem": "JSP-000759",
  "status": "passed",
  "started_utc": "2026-09-17T13:26:53.702452+00:00",
  "theorems": [
    "JSP000759.solution",
    "JSP000759.no_five_paths"
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
      "started_utc": "2026-09-17T13:26:53.708049+00:00",
      "ended_utc": "2026-09-17T13:27:43.066940+00:00",
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
      "started_utc": "2026-09-17T13:27:43.067266+00:00",
      "ended_utc": "2026-09-17T13:28:41.751679+00:00",
      "log": "cache.log"
    },
    {
      "command": [
        "lake",
        "build",
        "LeanTwenty.JSP000759"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:28:41.752024+00:00",
      "ended_utc": "2026-09-17T13:28:52.590655+00:00",
      "log": "build.log"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "verification/JSP-000759/Audit.lean"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:28:52.591194+00:00",
      "ended_utc": "2026-09-17T13:28:55.320912+00:00",
      "log": "axioms.log"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "LeanTwenty.JSP000759"
      ],
      "exit_code": 0,
      "started_utc": "2026-09-17T13:28:55.321598+00:00",
      "ended_utc": "2026-09-17T13:29:09.314862+00:00",
      "log": "kernel.log"
    }
  ],
  "replay_scope": "Entry module using Lean bundled kernel; imports dependencies, not --fresh",
  "verification_kind": "submitter-run, not independent human review",
  "completed_utc": "2026-09-17T13:29:09.327338+00:00"
}
```

## build.log

Original SHA-256: `506cc974eabd5e5e08c537766dcec83d4c0871784723cf48bd3f5a50ee8fc513`.

```text
⚠ [3107/3107] Built LeanTwenty.JSP000759 (8.4s)
warning: LeanTwenty/JSP000759.lean:156:12: Variable name `x` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _x

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: LeanTwenty/JSP000759.lean:156:14: Variable name `y` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _y

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: LeanTwenty/JSP000759.lean:157:18: Variable name `x` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _x

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: LeanTwenty/JSP000759.lean:230:20: Unused tactic linter: `norm_num` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
info: LeanTwenty/JSP000759.lean:232:0: 'JSP000759.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
info: LeanTwenty/JSP000759.lean:233:0: 'JSP000759.no_five_paths' depends on axioms: [propext, Classical.choice, Quot.sound]
Build completed successfully (3107 jobs).
```

## Audit.lean

Original SHA-256: `ecefbaf0ffd9db092d9d2f0033bf3bf3a0c9893668ee9342d8c40cc2090343ba`.

```lean
import LeanTwenty.JSP000759

#print axioms JSP000759.solution
#print axioms JSP000759.no_five_paths
```

## axioms.log

Original SHA-256: `822a62580ef44981c681f5806e90d9468d6f0ff9f805f74c313d62a8cb42ea3e`.

```text
'JSP000759.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000759.no_five_paths' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## kernel.log

Original SHA-256: `53bc98a0d7a971e479be1899e06f9673068f3aa9d9817087b23e2118bbed266f`.

```text
replaying LeanTwenty.JSP000759
```

## toolchain.log

Original SHA-256: `96ce379e441b32899159b48ef33979997d4e25efb235234987ee22a2766820de`.

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

## Reproduction

Use the exact selected SHA, toolchain and dependency lock. The companion mathematical supplement contains a targeted Lake recipe that builds this module, prints both axiom reports and replays the entry. To run the original batch verifier, use Python **3.12 or later** and `python3.12 scripts/verify.py --problem JSP-000759 --fetch-cache` from `batches/lean5`. The batch script fetches other hash-pinned batch sources before target selection; those sources are not imported by this proof. These instructions are not a claim of a new execution in this evidence review.
