# JSP-001018 — preserved CI evidence review, 2026-09-26

This document preserves the short outputs of the existing successful CI for [PR #723](https://github.com/TheJustinSunPrize/awards/pull/723). No new Lean execution was performed for this report. The exact proof remains **`26ca7691dfee68c8f2865381cbc3e33bd5914fff`** in `CHENLexiao8848/jsp-000637-lean`, branch `codex/jsp-001018-proof`, package `proofs/JSP-001018`.

## Version and provenance

- [Fixed proof](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/JSPProofs/JSP001018.lean); terminal theorem `JSP001018.erdos1213_int` at line 251.
- [Fixed audit](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/Audit.lean), [verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/scripts/verify.ps1), and [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/.github/workflows/jsp-001018.yml).
- [CI run 35226032048](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226032048), [job 105217730851](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226032048/job/105217730851): success at the exact proof SHA.
- Artifact `10499031214`, `jsp-001018-verification`: 2,045 ZIP bytes; SHA256 `d4ae416364a0047491839ce389d0351dc7550e06344d93264d68d4f3ca30304f`, matching GitHub metadata and upload output. The artifact's recorded expiry is 2026-12-16T13:16:23Z; its four complete short files are preserved below.

All **14 package Git blob IDs, seven CI input hashes, nine dependency revisions, three command-log hashes, ZIP integrity and extracted-file bytes** were checked. The fixed source file SHA256 is `8a561afac62a7c942bb98d6ec935bb9322dfb6f9ba930fd7700ce8ac4ceaa445`. The verifier checks that its seven inputs stay unchanged throughout the run. The branch contained the proof SHA at review time.

## Execution and scope

The actual job log shows a fresh hosted Ubuntu 24.04.5 checkout of this SHA, Lean 4.34.0 Linux x86_64 (compiler commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`), and fresh dependency checkouts matching all nine lock entries. Mathlib is `5ed2965256430c3649e86755f9576b54eca72435`. Project-cache restore and save were skipped; only pinned dependency caches were used. There are no tracked project `.olean` files or `.lake` files at the proof SHA. The saved build actually **Built** both the proof module and root import, finishing 3,094 jobs. This is fresh project compilation, without an explicit `lake clean` or a rebuild of all dependencies.

The fixed PowerShell verifier regenerated the four files below. The job printed these timed command results:

```text
2026-09-17T13:18:34.9380017Z Passed: lake build
2026-09-17T13:18:37.3780792Z Passed: lake env lean Audit.lean
2026-09-17T13:18:42.4079706Z Passed: lake env leanchecker --verbose JSPProofs.JSP001018
```

The three audited declarations are `JSP001018.erdos1213_int`, `JSP001018.erdos1213`, and `JSP001018.bounded_gap_equal_intervals`; all use exactly `[propext, Classical.choice, Quot.sound]`. Replay covers **`JSPProofs.JSP001018` only**, with the same Lean kernel and imported pinned dependencies. It is not a second independently implemented checker or a `--fresh` replay of all Mathlib.

The terminal integer theorem proves the general existence of a threshold and two nonempty, distinct index intervals with equal actual integer sums. It does not require the two intervals to be mutually adjacent, disjoint or equal in length. This evidence does not establish the sharper published quantitative bound, first formalization, independent human review or award eligibility.

The repository also contains earlier local evidence. The current CI build log and verification JSON differ from those committed records. Its axiom and replay logs have identical bytes to the earlier outputs, but their current execution is supported by the fixed verifier and the timed CI success messages above. The report's version labels are constants in the script; actual compiler and dependency identities were separately checked against the job log. There is no separate dependency `git status` record; the job instead supplies fresh pinned checkouts, and the fixed verifier contains no dependency-edit step.

The following blocks preserve each artifact file's exact UTF-8 content, including its final newline. Their SHA256 values were recomputed before embedding and checked again after extracting the blocks from this document.

## `build.log`

SHA256: `77a78c7389854447ddc5954709ed4e906bb0969c9449fa8477c33ade4c94a74f`

<!-- BEGIN artifact: build.log -->
```text
ℹ [3092/3094] Built JSPProofs.JSP001018 (3.2s)
info: JSPProofs/JSP001018.lean:247:0: 'JSP001018.erdos1213' depends on axioms: [propext, Classical.choice, Quot.sound]
info: JSPProofs/JSP001018.lean:294:0: 'JSP001018.erdos1213_int' depends on axioms: [propext, Classical.choice, Quot.sound]
✔ [3093/3094] Built JSPProofs (1.7s)
Build completed successfully (3094 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256: `a507d3a5e79d56d647df69806d145f91f7fed8852df38b3d99dc5dd1a471f43d`

<!-- BEGIN artifact: axioms.log -->
```text
JSP001018.erdos1213_int (A K : ℕ) (hA : 1 ≤ A) (_hK : 1 ≤ K) :
  ∃ F,
    ∀ (s : ℕ) (a : ℕ → ℤ),
      0 < s →
        a 0 = ↑A →
          (∀ (j : ℕ), j + 1 < s → a j < a (j + 1)) →
            (∀ (j : ℕ), j + 1 < s → a (j + 1) - a j ≤ ↑K) →
              ↑F < a (s - 1) →
                ∃ i l j m,
                  0 < l ∧
                    0 < m ∧
                      i + l ≤ s ∧
                        j + m ≤ s ∧
                          Finset.Ico i (i + l) ≠ Finset.Ico j (j + m) ∧
                            ∑ t ∈ Finset.Ico i (i + l), a t = ∑ t ∈ Finset.Ico j (j + m), a t
'JSP001018.erdos1213_int' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP001018.erdos1213' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP001018.bounded_gap_equal_intervals' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `kernel-replay.log`

SHA256: `7fb7d522dba80ce351215d819c4ca070aa75c3a02c7b46b28099bee2cdf616f8`

<!-- BEGIN artifact: kernel-replay.log -->
```text
replaying JSPProofs.JSP001018
```
<!-- END artifact: kernel-replay.log -->

## `verification.json`

SHA256: `ea26f587e4ba2ea37aff27f0f9456677b0aed02b0253036108d1746d036509e1`

<!-- BEGIN artifact: verification.json -->
```json
{
  "status": "passed",
  "started_utc": "2026-09-17T13:18:27.7919163Z",
  "theorem": "JSP001018.erdos1213_int",
  "lean_version": "4.34.0",
  "mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "allowed_axioms": [
    "propext",
    "Classical.choice",
    "Quot.sound"
  ],
  "source_hashes": [
    {
      "path": "JSPProofs/JSP001018.lean",
      "sha256": "8a561afac62a7c942bb98d6ec935bb9322dfb6f9ba930fd7700ce8ac4ceaa445"
    },
    {
      "path": "JSPProofs.lean",
      "sha256": "0a8e239f26911440575c7c87d249c69ccb3c3b000c9ca4e2e275a34fcbc54deb"
    },
    {
      "path": "Audit.lean",
      "sha256": "b6c0ad0f0791fa01c7acd5d250b9ba5ed54e2b0f7416cc6c9db17523d0dd7302"
    },
    {
      "path": "lean-toolchain",
      "sha256": "8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632"
    },
    {
      "path": "lakefile.toml",
      "sha256": "c5ceae19ae010c359e911edf56b030b72453fb651a4d1813d2f4bcfc11ea1161"
    },
    {
      "path": "lake-manifest.json",
      "sha256": "32435e5a61192a76731d2eb80a1339678374b9b3662ebff980d29561869f974e"
    },
    {
      "path": "scripts/verify.ps1",
      "sha256": "9dc4951f1c9c6467b82a6ca4cc436fbbefe0fab7ee21e4e076a41c38a719bf70"
    }
  ],
  "checks": [
    {
      "command": "lake build",
      "exit_code": 0,
      "started_utc": "2026-09-17T13:18:28.2364357Z",
      "ended_utc": "2026-09-17T13:18:34.9289690Z",
      "log": "evidence/build.log",
      "sha256": "77a78c7389854447ddc5954709ed4e906bb0969c9449fa8477c33ade4c94a74f"
    },
    {
      "command": "lake env lean Audit.lean",
      "exit_code": 0,
      "started_utc": "2026-09-17T13:18:34.9378733Z",
      "ended_utc": "2026-09-17T13:18:37.3726284Z",
      "log": "evidence/axioms.log",
      "sha256": "a507d3a5e79d56d647df69806d145f91f7fed8852df38b3d99dc5dd1a471f43d"
    },
    {
      "command": "lake env leanchecker --verbose JSPProofs.JSP001018",
      "exit_code": 0,
      "started_utc": "2026-09-17T13:18:37.4011962Z",
      "ended_utc": "2026-09-17T13:18:42.4065651Z",
      "log": "evidence/kernel-replay.log",
      "sha256": "7fb7d522dba80ce351215d819c4ca070aa75c3a02c7b46b28099bee2cdf616f8"
    }
  ],
  "replay_scope": "JSPProofs.JSP001018 only, using pinned imported dependencies and the same Lean kernel",
  "completed_utc": "2026-09-17T13:18:42.4135016Z"
}
```
<!-- END artifact: verification.json -->

