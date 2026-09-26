# JSP-000637: preserved fixed-source CI evidence

Reviewed 2026-09-26 for [PR #712](https://github.com/TheJustinSunPrize/awards/pull/712). The selected proof is `048e06a544c77a9c15044bdf14b8619debadf888`, branch `main`, in `CHENLexiao8848/jsp-000637-lean`. This is a documentation review of an unchanged proof, not a new Lean execution or an award decision.

## Exact source and contribution

All **30** tracked files matched their fixed Git blobs; all **seven** CI-recorded input SHA256 values matched those bytes. The present named branch contains the selected proof. Comparing the independently fetched [upstream Erdős777 source](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos777.lean) with the local vendor file gives exactly two changed hunks: the version comment and the proof of the unchanged Mantel/Turán bound, adapted to `SimpleGraph.turanNumber_two` and `Nat.mul_div_le`. The local `Jsp637` wrapper directly aliases the three existing yes/no/yes results and combines them. Full mathematical proof ownership is not transferred by that port.

Upstream SHA256 `669aec65a87d49ce7b1996434a3491cd1d4fec98270a0a0f61e1eae650d8f181`; ported core SHA256 `d98c6976eed71ceaab4cbfe1ad55849567a064973b3437ac139c64a32280daa3`. The fixed [port diff](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/artifacts/port.diff) agrees with this source comparison. The [attribution record](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/vendor/plby/UPSTREAM.md) retains mathematical authors and original formal-author/license notices.

## Successful fixed-SHA CI

[Run 35223597379](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35223597379), [job 105209503434](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35223597379/job/105209503434), succeeded on 2026-09-17 at exactly the selected commit. Artifact **10498016360**, `jsp-000637-verification`, has **3833 bytes** and ZIP SHA256 **`74b25b39281e68b5e123592ac591ad1620b0014ee0ea6f864b2a240815210265`**, independently matching GitHub's artifact digest.

The recovered current CI build reports **8926 jobs**, including actual `Built ErdosProblems.Erdos777` and `Built Jsp637`, followed by five target axiom audits and separate module replays of those two modules. All four timed commands returned zero and their `.exitcode` files agree. All five targets depend only on `propext`, `Classical.choice` and `Quot.sound`; there is no `sorryAx`, native-decision axiom or additional mathematical axiom in these reported terminal dependencies. Each exact declaration and output appears in the preserved audit below.

The [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/.github/workflows/lean.yml) explicitly disables the GitHub project cache and starts from a fresh hosted checkout. It obtains Mathlib dependency caches. The nine actual dependency checkout revisions in the job log match the [fixed manifest](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/lake-manifest.json); Mathlib is `5ed2965256430c3649e86755f9576b54eca72435`, with Lean 4.34.0 selected by [lean-toolchain](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/lean-toolchain). The `lean_version` field inside the report is a script literal, not captured `lean --version` output; the installation log and fixed toolchain bind the actual tool selection. No explicit `lake clean`, rebuilding of all Mathlib, independently implemented checker or human verification is claimed. Module replay uses Lean's own bundled kernel with imported dependencies.

The [fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/scripts/verify.ps1) regenerated `verification.json`, `source-hashes.json`, build/audit/two replay logs, combined replay log and four exit-code files. The ZIP also contains **`provenance-check.json` from the committed earlier record**, which this script does not regenerate; it must not be read as a newly executed CI provenance command. Its upstream hash was independently checked in this review. Historical committed [artifacts/verification.json](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/048e06a544c77a9c15044bdf14b8619debadf888/artifacts/verification.json) is a separate earlier run, not the timed Linux record below.

## Reproduction

```sh
git clone --branch main https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 048e06a544c77a9c15044bdf14b8619debadf888
lake exe cache get
lake clean
pwsh -File scripts/verify.ps1
```

The explicit clean command above is a proposed reproduction instruction. The existing CI's fresh project checkout is distinguished from such a command. The verifier performs build, `lake env lean Audit.lean`, and the two module replays and rejects missing targets/unexpected axioms. Source correspondence and original authorship still require separate review.

## Downloaded artifact integrity

The original record did not include per-log hash fields. The ZIP digest above plus the newly calculated hashes below preserve the recovered bytes, without retrospectively adding fields to the old record. Original archive expiry is 2026-12-16; the short current CI files below are preserved for later review.

| Member | Bytes | SHA256 |
| --- | --- | --- |
| `axioms.log` | 1134 | `3d1cf8cdc394fd5da09b25a4043cf5668818b644dfc02b230467429cce94fcee` |
| `axioms.log.exitcode` | 2 | `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa` |
| `kernel-entry.log` | 17 | `5783a36fac36521a88bb5904968b5257526f70b3c0190ba6fd1713c2f26e9260` |
| `kernel-entry.log.exitcode` | 2 | `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa` |
| `kernel-replay.log` | 50 | `6c73a7aa045dd00ef710d2a100d82cca03cf03e8124473780e3e66b42d4c6fea` |
| `kernel-upstream.log` | 33 | `a241ca1039cc6edc67e90948e619353af6e4bcd924ee0469f982c26fada41db4` |
| `kernel-upstream.log.exitcode` | 2 | `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa` |
| `lake-build.log` | 367 | `87fdc44282b1a0cd6c67e1e9151877868d00187e3183b7f65b30411cb71e5561` |
| `lake-build.log.exitcode` | 2 | `9a271f2a916b0b6ee6cecb2426f0b3206ef074578be55d9bc94f6f3fe3ab86aa` |
| `provenance-check.json` | 140 | `7d27d0b8bec6d2e65e1dd841ff2f2bc7be3afe7569c57359bfeaaf0a39ac5605` |
| `source-hashes.json` | 868 | `9e04bc74f0cd0f18d237cdacb3602ceda3b08cd8ec213521337576b5f0411961` |
| `verification.json` | 2428 | `10ffe5f3f913fa06f50974f551230e5fc29c2e7fbdca96230ffc7ab531bc9cd2` |

## `verification.json`

<!-- BEGIN artifact: verification.json -->
```json
{
  "status": "passed",
  "started_utc": "2026-09-17T12:54:19.9811569Z",
  "theorem": "Jsp637.jsp_000637",
  "lean_version": "4.34.0",
  "mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "checks": [
    {
      "command": "lake build",
      "exit_code": 0,
      "started_utc": "2026-09-17T12:54:20.3750256Z",
      "ended_utc": "2026-09-17T12:54:55.4437558Z",
      "log": "artifacts/lake-build.log"
    },
    {
      "command": "lake env lean Audit.lean",
      "exit_code": 0,
      "started_utc": "2026-09-17T12:54:55.4518834Z",
      "ended_utc": "2026-09-17T12:54:58.9479996Z",
      "log": "artifacts/axioms.log"
    },
    {
      "command": "lake env leanchecker --verbose ErdosProblems.Erdos777",
      "exit_code": 0,
      "started_utc": "2026-09-17T12:54:58.9726864Z",
      "ended_utc": "2026-09-17T12:55:04.1878664Z",
      "log": "artifacts/kernel-upstream.log"
    },
    {
      "command": "lake env leanchecker --verbose Jsp637",
      "exit_code": 0,
      "started_utc": "2026-09-17T12:55:04.1887421Z",
      "ended_utc": "2026-09-17T12:55:08.8606409Z",
      "log": "artifacts/kernel-entry.log"
    }
  ],
  "source_hashes": [
    {
      "path": "Jsp637.lean",
      "sha256": "f93ebb92fc2313aaf7bb8c3310ea1fec02f93c7e348541e2fbb0da49f916e4f3"
    },
    {
      "path": "vendor/plby/ErdosProblems/Erdos777.lean",
      "sha256": "d98c6976eed71ceaab4cbfe1ad55849567a064973b3437ac139c64a32280daa3"
    },
    {
      "path": "Audit.lean",
      "sha256": "73d5e95e615d2333d1c796442d72061833a02be489ca13f0ce0d99aed38a23bd"
    },
    {
      "path": "lean-toolchain",
      "sha256": "8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632"
    },
    {
      "path": "lakefile.toml",
      "sha256": "c6a44145889dd7aa618c670db6d6eda19b5f923d4e63f961c4c7cd8589625d5f"
    },
    {
      "path": "lake-manifest.json",
      "sha256": "f60ad86e9ef519ba0eac36c94a952c2566394d5370e6d2735635c8cda03e1b28"
    },
    {
      "path": "scripts/verify.ps1",
      "sha256": "621d53868a960c08abe823035f582f3b663250cf49ac3a1cd1d8dad6abbb573d"
    }
  ],
  "allowed_axioms": [
    "propext",
    "Classical.choice",
    "Quot.sound"
  ],
  "replay_scope": "Both local proof modules; imported Mathlib, not a fresh replay of all Mathlib",
  "attribution": "Apache-2.0 reuse, compatibility port and reproduction; no first-formalization claim",
  "completed_utc": "2026-09-17T12:55:08.8665891Z"
}
```
<!-- END artifact: verification.json -->

## `source-hashes.json`

<!-- BEGIN artifact: source-hashes.json -->
```json
[
  {
    "path": "Jsp637.lean",
    "sha256": "f93ebb92fc2313aaf7bb8c3310ea1fec02f93c7e348541e2fbb0da49f916e4f3"
  },
  {
    "path": "vendor/plby/ErdosProblems/Erdos777.lean",
    "sha256": "d98c6976eed71ceaab4cbfe1ad55849567a064973b3437ac139c64a32280daa3"
  },
  {
    "path": "Audit.lean",
    "sha256": "73d5e95e615d2333d1c796442d72061833a02be489ca13f0ce0d99aed38a23bd"
  },
  {
    "path": "lean-toolchain",
    "sha256": "8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632"
  },
  {
    "path": "lakefile.toml",
    "sha256": "c6a44145889dd7aa618c670db6d6eda19b5f923d4e63f961c4c7cd8589625d5f"
  },
  {
    "path": "lake-manifest.json",
    "sha256": "f60ad86e9ef519ba0eac36c94a952c2566394d5370e6d2735635c8cda03e1b28"
  },
  {
    "path": "scripts/verify.ps1",
    "sha256": "621d53868a960c08abe823035f582f3b663250cf49ac3a1cd1d8dad6abbb573d"
  }
]
```
<!-- END artifact: source-hashes.json -->

## `lake-build.log`

<!-- BEGIN artifact: lake-build.log -->
```text
✔ [8922/8926] Built Mathlib.Probability.Kernel.Invariance (1.6s)
✔ [8923/8926] Built Mathlib (4.0s)
ℹ [8924/8926] Built ErdosProblems.Erdos777 (20s)
info: vendor/plby/ErdosProblems/Erdos777.lean:1773:0: 'Erdos777.erdos_777' depends on axioms: [propext, Classical.choice, Quot.sound]
✔ [8925/8926] Built Jsp637 (3.1s)
Build completed successfully (8926 jobs).
```
<!-- END artifact: lake-build.log -->

## `axioms.log`

<!-- BEGIN artifact: axioms.log -->
```text
Jsp637.jsp_000637 :
  (∀ (ε : ℝ),
      0 < ε →
        ∃ N,
          ∀ (n : ℕ),
            N ≤ n → ∀ (F : Finset (Finset (Fin n))), ↑F.card ≤ (2 - ε) * 2 ^ (↑n / 2) → Jsp637.edgeCount F < 2 ^ n) ∧
    (¬∀ (c : ℝ),
          0 < c →
            ∃ C,
              0 < C ∧
                ∀ (n : ℕ) (F : Finset (Finset (Fin n))),
                  c * ↑F.card ^ 2 ≤ ↑(Jsp637.edgeCount F) → ↑F.card ≤ C * 2 ^ (↑n / 2)) ∧
      ∀ (ε : ℝ),
        0 < ε →
          ∃ δ,
            0 < δ ∧
              ∀ (n : ℕ) (F : Finset (Finset (Fin n))),
                ↑F.card ^ (2 - δ) < ↑(Jsp637.edgeCount F) → ↑F.card < (2 + ε) ^ (↑n / 2)
'Jsp637.first_question' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp637.second_question' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp637.third_question' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp637.jsp_000637' depends on axioms: [propext, Classical.choice, Quot.sound]
'Erdos777.erdos_777' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `kernel-upstream.log`

<!-- BEGIN artifact: kernel-upstream.log -->
```text
replaying ErdosProblems.Erdos777
```
<!-- END artifact: kernel-upstream.log -->

## `kernel-entry.log`

<!-- BEGIN artifact: kernel-entry.log -->
```text
replaying Jsp637
```
<!-- END artifact: kernel-entry.log -->
