# JSP-000301 — two-version verification evidence, 2026-09-26

This report supports the consolidated review in [PR #740](https://github.com/TheJustinSunPrize/awards/pull/740), preserving the alternate implementation in [PR #752](https://github.com/TheJustinSunPrize/awards/pull/752). Both prove the same catalog-scoped negative assertion using the known pair 12167 and 12168. They form one contribution review, not two separate prize claims. No new Lean compilation or replay was performed for this evidence review.

## A: main #740 implementation and exact-SHA GitHub CI

Repository `CHENLexiao8848/jsp-000637-lean`, branch `codex/jsp-000301-000139-000838`, proof commit **`48fd10d0009408a1a3cdd1640bc22884facf00c3`**, package `packages/jsp-000301-000139`.

- [Fixed `Jsp/Powerful301.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Jsp/Powerful301.lean): 2,516 bytes, SHA256 `a76765dc02bb9fccdf0e06120adfe1fa9b20e02f83fbffdfad47471094748936`.
- [Public audit source](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Audit.lean), [fixed verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/scripts/verify.py), and [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/.github/workflows/jsp-batch.yml).
- [Run 35226624341](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341), dedicated shared-package [job 105219764607](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764607): success at the exact A proof SHA.
- Artifact `10499027839`, `jsp-000301-000139-verification`: 3,659 ZIP bytes, SHA256 `9902778d3a87418b462bed65c4a841f56051ee3fa100d2bb840773aa79da41f0`, matching GitHub's digest. Its recorded expiry is 2026-12-16T13:22:08Z.

The ZIP and all ten extracted members passed integrity/byte checks. All 26 package Git blobs plus the fixed workflow, 12 CI source input hashes, nine actual dependency checkout pins and nine command log hashes/exit codes/timed PASS echoes were checked. Actual toolchain output is Lean 4.34.0 on Linux x86_64, commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`; Mathlib is pinned to `5ed2965256430c3649e86755f9576b54eca72435`.

The job used a fresh hosted Ubuntu checkout, skipped project-cache restoration and saving, and downloaded Mathlib dependency caches. The fixed Git tree contains no tracked package `.lake` or `.olean` files. The shared package reports a successful **3,123-job build** and actually builds `Jsp.Powerful301`, five JSP-000139 mathematical modules and the root library. There was no explicit `lake clean`; this is fresh-project compilation with cached dependencies.

The JSP-000301 audit consists of exactly two target outputs, each with `[propext, Classical.choice, Quot.sound]`:

| Target | Verified statement |
| --- | --- |
| `Jsp.Powerful301.answer` | The universal assertion that consecutive positive powerful numbers include a square is false. |
| `Jsp.Powerful301.counterexample` | There is `n` such that `n` and `n+1` are powerful and neither is a square. |

The specific module replay is `lake env leanchecker --verbose Jsp.Powerful301`, exit zero, with output `replaying Jsp.Powerful301`. The other two axiom outputs and five mathematical-module replays in this shared artifact belong to JSP-000139, not JSP-000301. They are preserved in the unedited shared logs below for integrity but do not increase this problem's target/module counts. The CI verification record runs from 2026-09-17 13:24:55 to 13:26:06 UTC.

The repository's committed `artifacts/` files are historical copies. All ten newly downloaded CI members differ in raw bytes from those committed copies. The fixed verifier regenerates them and the actual job's nine timed PASS echoes substantiate the current execution. The files embedded below are from the downloaded same-SHA CI artifact, not substituted committed transcripts.

Reproduce A from the fixed package with:

```bash
lake exe cache get
python3 scripts/verify.py
```

## B: preserved #752 implementation and historical local clean build

Repository `CHENLexiao8848/awards`, branch `codex/four-lean-proofs-20260917`, proof commit **`ea6e7fc0a5893edd13335acc4e1ebd00cd261782`**, package `proofs/chen-lexiao-four-20260917/proof`.

- [Fixed `Problems/JSP000301.lean`](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Problems/JSP000301.lean): 2,569 bytes, SHA256 `3260101c1ce1e4053bc9aaa6c0c2319ce276280df683bef830b4aae559e78664`.
- [Verification report](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/report.json), [fixed verifier](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verify.py), and [checksum manifest](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/SHA256SUMS).
- [Build transcript](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/build.log), [public axiom audit](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/axioms.log), [module replay](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/kernel-replay.log), and [audit source](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Audit.lean).

All 61 package Git blobs, 18 unchanged before/after input hashes, 41 logged command hashes/arguments/exit codes, 60 checksum entries and nine dependency revisions/clean tracked statuses before and after were rechecked. The report records a successful Lean 4.34.0 arm64 macOS execution on 2026-09-17 from 09:48:38 to 09:55:31 UTC with the same Mathlib pin. It explicitly ran `lake clean pinnacleLean`, built all eight local modules in **2,055 jobs**, audited 11 package declarations and replayed eight modules, retaining dependency caches.

For JSP-000301 specifically, it actually built and replayed `Problems.JSP000301` and printed the axioms of **one** terminal, `JSP000301.conjecture_false`: `[propext, Classical.choice, Quot.sound]`. The companion `JSP000301.exists_consecutive_powerful_not_square` was compiled and its signature printed with `#check`, but it has no separate `#print axioms` output in the recorded audit. Thus B is not described as having two individually axiom-audited targets. The 11-target/eight-module totals span the four-problem package.

These are consistent submitter-provided historical local logs, not the GitHub Linux run of A or new execution today. The three GitHub workflows inspected at B's proof SHA are catalog/data checks, not Lean proof compilation. Reproduce B with `python3 verify.py` in its fixed package; the default protocol includes the local-library clean, build, public audit and local-module replay.

## Scope and limits

Both versions define `Powerful n` by positivity and the universal condition that the square of every prime divisor divides `n`; neither bounds the primes or the integer. Both use standard `IsSquare` and prove all conditions for consecutive 12167 and 12168. Their statements completely refute the selected catalog's yes/no assertion. Neither claims a counting theorem or infinitude of such pairs. Different tactic imports or proof bodies do not by themselves establish independent provenance or priority.

Both replay protocols use Lean's bundled kernel with pinned imported dependencies. They are not a second independently implemented checker or a `--fresh` replay of all Mathlib. A has one JSP-000301 module among six mathematical modules; B has one JSP-000301 module among eight local modules in its separate package. Successful submitter-controlled records do not establish independent human mathematical review, organizer acceptance, award eligibility or originality.

B's original transcripts remain permanently linked at the fixed commit. The following table records every member of A's downloaded CI artifact; the five complete short files relevant to the shared build and JSP-000301 audit/replay are embedded below. The five JSP-000139 replay logs are omitted from the body but retain their byte lengths and hashes in the table. Every embedded file was extracted back from this Markdown and rehashed against the original ZIP member, with original final-newline status recorded explicitly.


| Artifact member | Bytes | SHA256 |
|---|---:|---|
| `Jsp.Graph139.log` | 23 | `0dc47010f370ccc41e3ea2492a706518d3c79f3253d5af8aa5decbb018c6e447` |
| `Jsp.Graph139Fields.log` | 29 | `7ee9c70a65ec9c61a0fb9aec11a9e8a689727fb4e99213daa642366aed5bd490` |
| `Jsp.Graph139Blowup.log` | 29 | `4e9b19734f729fa67331def650125d08684e86516cb2626e5bdaf3fe2b68f928` |
| `Jsp.Graph139Parabola.log` | 31 | `64b13f08bc030027598bf9061e4215ef7973ee0f809936f5df0eafdd729eda12` |
| `Jsp.Graph139Upper.log` | 28 | `86752ec5b4e98076033614ecda00a3d879a2031225f4649442fb2662fc9bcf2e` |
| `axioms.log` | 1023 | `a6af308f1a7ed9a16a6dec96ff743e5900b39638e7a191457768fcfa3f7f5ae2` |
| `Jsp.Powerful301.log` | 26 | `0a8c3bd34dde2bfd8589f6f2ae4bfd094dfd56e7ca462a7c20e9dd72754aa641` |
| `build.log` | 355 | `89475da1a04e9138a332f352af6adc68ee8833d9781a25b4e0417bf1b230329d` |
| `toolchain.log` | 106 | `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d` |
| `verification.json` | 3870 | `f0cd97bfd896e7def990aee9aa0a15443c37e1d15b981a2c89a0025312c54b76` |

## `build.log`

SHA256: `89475da1a04e9138a332f352af6adc68ee8833d9781a25b4e0417bf1b230329d`; original final newline: `true`.

<!-- BEGIN artifact: build.log -->
```text
✔ [3092/3123] Built Jsp.Powerful301 (4.2s)
✔ [3093/3123] Built Jsp.Graph139Fields (4.3s)
✔ [3118/3123] Built Jsp.Graph139 (2.8s)
✔ [3119/3123] Built Jsp.Graph139Parabola (2.6s)
✔ [3120/3123] Built Jsp.Graph139Blowup (2.7s)
✔ [3121/3123] Built Jsp.Graph139Upper (6.1s)
✔ [3122/3123] Built Jsp (1.7s)
Build completed successfully (3123 jobs).
```
<!-- END artifact: build.log -->

## `axioms.log`

SHA256: `a6af308f1a7ed9a16a6dec96ff743e5900b39638e7a191457768fcfa3f7f5ae2`; original final newline: `true`.

<!-- BEGIN artifact: axioms.log -->
```text
Jsp.Powerful301.answer :
  ¬∀ (n : ℕ), Jsp.Powerful301.Powerful n → Jsp.Powerful301.Powerful (n + 1) → IsSquare n ∨ IsSquare (n + 1)
Jsp.Powerful301.counterexample :
  ∃ n, Jsp.Powerful301.Powerful n ∧ Jsp.Powerful301.Powerful (n + 1) ∧ ¬IsSquare n ∧ ¬IsSquare (n + 1)
Jsp.Graph139Upper.answer (n : ℕ) :
  121 ≤ n →
    (∀ (G : SimpleGraph (Fin n)), G.CliqueFree 3 → G.ediam ≤ 2 → n ≤ G.maxDegree ^ 2 + 1) ∧
      ∃ G, G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧ G.maxDegree ^ 2 ≤ 857435524 * n
Jsp.Graph139Upper.upper_bound (n : ℕ) (hn : 121 ≤ n) :
  ∃ G, G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧ G.maxDegree ^ 2 ≤ 857435524 * n
'Jsp.Powerful301.answer' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp.Powerful301.counterexample' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp.Graph139Upper.answer' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp.Graph139Upper.upper_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```
<!-- END artifact: axioms.log -->

## `Jsp.Powerful301.log`

SHA256: `0a8c3bd34dde2bfd8589f6f2ae4bfd094dfd56e7ca462a7c20e9dd72754aa641`; original final newline: `true`.

<!-- BEGIN artifact: Jsp.Powerful301.log -->
```text
replaying Jsp.Powerful301
```
<!-- END artifact: Jsp.Powerful301.log -->

## `toolchain.log`

SHA256: `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d`; original final newline: `true`.

<!-- BEGIN artifact: toolchain.log -->
```text
Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)
```
<!-- END artifact: toolchain.log -->

## `verification.json`

SHA256: `f0cd97bfd896e7def990aee9aa0a15443c37e1d15b981a2c89a0025312c54b76`; original final newline: `true`.

<!-- BEGIN artifact: verification.json -->
```json
{
  "status": "passed",
  "started_utc": "2026-09-17T13:24:55.608898+00:00",
  "source_hashes": {
    "Audit.lean": "752845d471cecfd547adc5110a4586b41f39a933420689eb1f0721dd997f1079",
    "Jsp/Graph139.lean": "8070a9dfd11f746ba2275fafc6d8f8468a4520b38aa4a518d81c8228dfffb2a2",
    "Jsp/Graph139Blowup.lean": "7d04c3017cfd75a76c795c723fc758f7f1cc3f4395bade8a66a6a9ac879fb6e3",
    "Jsp/Graph139Fields.lean": "5bfb3f2f8cf6bbff473080346c5e2a39b42e28b4c909dbd30f414444ccb3305b",
    "Jsp/Graph139Parabola.lean": "a47534931ebb9173006ba74577722f47191620019d8b2723695afe45d6b48d11",
    "Jsp/Graph139Upper.lean": "de18a1b0939fc36a95da5bedc6130d3b0c07be5688475241789fd475650716cc",
    "Jsp/Powerful301.lean": "a76765dc02bb9fccdf0e06120adfe1fa9b20e02f83fbffdfad47471094748936",
    "Jsp.lean": "d00af2a27a7d99edc3e3c2a027f59031a46b848a5e7c8a6e509c5087ded05627",
    "lake-manifest.json": "bffcad8355f4ce032e76f94ee4e1a438a6b3d25b74764fcc4fc331d8186b190d",
    "lakefile.toml": "795b00ad5b8b59e8d46647c32e0e39e1e4040b60367732859a1b9578f35ab846",
    "lean-toolchain": "8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632",
    "scripts/verify.py": "8882d0c7380ef813fe48ed1bcd3cc1d719cb37ab07f1181127f6065c683e9d73"
  },
  "checks": [
    {
      "command": [
        "lake",
        "env",
        "lean",
        "--version"
      ],
      "exit_code": 0,
      "log": "toolchain.log",
      "sha256": "cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d"
    },
    {
      "command": [
        "lake",
        "build"
      ],
      "exit_code": 0,
      "log": "build.log",
      "sha256": "89475da1a04e9138a332f352af6adc68ee8833d9781a25b4e0417bf1b230329d"
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "Audit.lean"
      ],
      "exit_code": 0,
      "log": "axioms.log",
      "sha256": "a6af308f1a7ed9a16a6dec96ff743e5900b39638e7a191457768fcfa3f7f5ae2"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Powerful301"
      ],
      "exit_code": 0,
      "log": "Jsp.Powerful301.log",
      "sha256": "0a8c3bd34dde2bfd8589f6f2ae4bfd094dfd56e7ca462a7c20e9dd72754aa641"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Graph139"
      ],
      "exit_code": 0,
      "log": "Jsp.Graph139.log",
      "sha256": "0dc47010f370ccc41e3ea2492a706518d3c79f3253d5af8aa5decbb018c6e447"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Graph139Fields"
      ],
      "exit_code": 0,
      "log": "Jsp.Graph139Fields.log",
      "sha256": "7ee9c70a65ec9c61a0fb9aec11a9e8a689727fb4e99213daa642366aed5bd490"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Graph139Parabola"
      ],
      "exit_code": 0,
      "log": "Jsp.Graph139Parabola.log",
      "sha256": "64b13f08bc030027598bf9061e4215ef7973ee0f809936f5df0eafdd729eda12"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Graph139Blowup"
      ],
      "exit_code": 0,
      "log": "Jsp.Graph139Blowup.log",
      "sha256": "4e9b19734f729fa67331def650125d08684e86516cb2626e5bdaf3fe2b68f928"
    },
    {
      "command": [
        "lake",
        "env",
        "leanchecker",
        "--verbose",
        "Jsp.Graph139Upper"
      ],
      "exit_code": 0,
      "log": "Jsp.Graph139Upper.log",
      "sha256": "86752ec5b4e98076033614ecda00a3d879a2031225f4649442fb2662fc9bcf2e"
    }
  ],
  "allowed_axioms": [
    "propext",
    "Classical.choice",
    "Quot.sound"
  ],
  "replay_scope": "six local modules, same kernel, importing pinned dependencies",
  "completed_utc": "2026-09-17T13:26:06.744673+00:00"
}
```
<!-- END artifact: verification.json -->

