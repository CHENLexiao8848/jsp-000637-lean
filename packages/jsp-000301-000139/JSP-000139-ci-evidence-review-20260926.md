# JSP-000139: preserved exact-version CI evidence

Reviewed and preserved on 2026-09-26 for [awards PR #741](https://github.com/TheJustinSunPrize/awards/pull/741). **The existing Linux CI passed at the selected proof commit on 2026-09-17. This is a review and preservation of that historical execution, not a new Lean run on 2026-09-26.**

Selected proof A: `48fd10d0009408a1a3cdd1640bc22884facf00c3`, original repository [https://github.com/CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean), branch `codex/jsp-000301-000139-000838`, package `packages/jsp-000301-000139`. Later documentation on that branch does not replace A. The companion [mathematical solution and contribution supplement](JSP-000139-review-supplement.md) explains the graph bounds, their mathematical implication for the extremal function, and the statement correspondence still requiring review.

## Exact CI and artifact identity

- [Run 35226624341](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341), with `head_sha=48fd10d0009408a1a3cdd1640bc22884facf00c3`, succeeded.
- The relevant [job 105219764607](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764607) is `verify (jsp-000301-000139, packages/jsp-000301-000139)`. The separate JSP-000838 job is not evidence for this proof.
- [Artifact 10499027839](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/artifacts/10499027839), `jsp-000301-000139-verification`, is **3,659 bytes**; ZIP SHA-256 `9902778d3a87418b462bed65c4a841f56051ee3fa100d2bb840773aa79da41f0`. The digest was independently recomputed and matches GitHub metadata and the upload log. ZIP integrity and every extracted member's bytes were checked.
- GitHub listed expiry `2026-12-16T13:22:08Z`. The short current-run records are preserved below, including full source and command hashes, to avoid relying solely on the expiring Actions artifact.

## JSP-000139 verification scope

The package has **five JSP-000139 mathematical modules**: `Jsp.Graph139`, `Jsp.Graph139Fields`, `Jsp.Graph139Parabola`, `Jsp.Graph139Blowup` and `Jsp.Graph139Upper`. The sixth shared mathematical module, `Jsp.Powerful301`, belongs to another problem. `Jsp.lean` is the aggregate; `Audit.lean` is the separate audit entry. There are eight Lean files across the shared package.

The [fixed workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/.github/workflows/jsp-batch.yml) uses a fresh Ubuntu 24.04.5 checkout, pinned Mathlib caches and disabled GitHub project caching. The actual restore/save steps are skipped. No `.lake` directory or `.olean` is tracked in this package at A. The build log explicitly records **Built** for all five graph modules, `Jsp.Powerful301` and the aggregate `Jsp`, ending with **3,123 jobs** completed successfully. The audit entry was elaborated separately. This supports fresh project compilation with dependency caches; neither an explicit `lake clean` nor a source rebuild of Mathlib occurred in the recorded run.

The current CI record ran from `2026-09-17T13:24:55.608898+00:00` to `2026-09-17T13:26:06.744673+00:00`. All **nine shared-package commands** returned exit 0: toolchain check, build, audit, and six individual module replays. Each log matches its recorded SHA-256 and a timed `PASS` line in the original job transcript. Five of those replay commands belong to JSP-000139; the sixth, Powerful301, does not add to this problem's verification scope.

The two submitted JSP-000139 declarations, `Jsp.Graph139Upper.answer` and `Jsp.Graph139Upper.upper_bound`, both report only `propext`, `Classical.choice` and `Quot.sound`. Their actual signatures and axioms appear below. The shared audit also prints two JSP-000301 targets; those original lines are preserved for record integrity and are **excluded** from the JSP-000139 conclusion.

Each graph-module replay uses `lake env leanchecker --verbose MODULE`, Lean's bundled kernel and imported dependencies. This is sequential replay of all **five local graph modules**, not a separately implemented checker or `--fresh` replay of all Mathlib. The aggregate and audit entry are built/elaborated but are not separate replay targets.

## Statement and review limitations

The checked terminal statements are integer graph bounds: for every `n≥121`, a universal Moore lower bound `n≤Δ²+1`, and existence of a triangle-free graph on exactly `Fin n` with `ediam≤2` and `Δ²≤857435524n`. There is no extra graph-existence, field-existence or convergence premise in those signatures.

A does **not** define the extremal function `f`, nor contain an explicit `IsTheta` or real-ratio limit theorem for it. The companion supplement derives the asymptotic and non-divergence conclusions mathematically from these integer bounds and gives the proposed correspondence. Those deductions must not be represented as additional compiled Lean targets. If literal extremal-function or limit targets are required by the approved statement, an added Lean bridge and verification would be necessary; this documentation does not create such a bridge.

All checks remain submitter-controlled machine verification. This report is not independent human mathematical review, maintainer acceptance, evidence of priority, or an award decision. The stronger complete prior plby formalization and its smaller upper constant are compared in the companion supplement.

## Inputs, dependencies and historical records

All 26 downloaded package files reproduce their Git blob IDs in the fixed complete, non-truncated tree. All **12 CI input hashes** reproduce the selected bytes: eight Lean files, manifest, Lake configuration, toolchain and verifier. Their full SHA-256 mapping is in the original `verification.json` below. The verifier checks that these inputs remain unchanged during its commands.

The actual dependency checkout lines match all nine manifest revisions. The job does not separately record dependency `git status`; it does record fresh clones at those revisions, and the inspected verifier does not edit dependencies. Mathlib was obtained from its pinned dependency cache.

| Dependency | Pinned and logged checkout |
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

The committed `artifacts/verification.json` describes an earlier local run ending at 13:20:59Z. The downloaded artifact contains this later Linux record and regenerated logs. The fixed verifier rewrites the logs, and the timed `PASS` lines establish that the commands ran again. This package has no extra old full-environment replay files packaged as current results. A lexical scan of all eight Lean inputs found none of the forbidden placeholder/unsafe tokens checked by the review; that scan supplements compilation and does not replace statement review.

## Artifact file hashes

The embedded records are the actual artifact bytes, UTF-8 with LF line endings. The shared Powerful301 replay is hash-identified only because it is outside this proof's scope; the other nine original records are embedded verbatim.

| Original file | SHA-256 | Preservation |
| --- | --- | --- |
| `Jsp.Graph139.log` | `0dc47010f370ccc41e3ea2492a706518d3c79f3253d5af8aa5decbb018c6e447` | Original full text below |
| `Jsp.Graph139Blowup.log` | `4e9b19734f729fa67331def650125d08684e86516cb2626e5bdaf3fe2b68f928` | Original full text below |
| `Jsp.Graph139Fields.log` | `7ee9c70a65ec9c61a0fb9aec11a9e8a689727fb4e99213daa642366aed5bd490` | Original full text below |
| `Jsp.Graph139Parabola.log` | `64b13f08bc030027598bf9061e4215ef7973ee0f809936f5df0eafdd729eda12` | Original full text below |
| `Jsp.Graph139Upper.log` | `86752ec5b4e98076033614ecda00a3d879a2031225f4649442fb2662fc9bcf2e` | Original full text below |
| `Jsp.Powerful301.log` | `0a8c3bd34dde2bfd8589f6f2ae4bfd094dfd56e7ca462a7c20e9dd72754aa641` | Other problem; hash only |
| `axioms.log` | `a6af308f1a7ed9a16a6dec96ff743e5900b39638e7a191457768fcfa3f7f5ae2` | Original full text below |
| `build.log` | `89475da1a04e9138a332f352af6adc68ee8833d9781a25b4e0417bf1b230329d` | Original full text below |
| `toolchain.log` | `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d` | Original full text below |
| `verification.json` | `f0cd97bfd896e7def990aee9aa0a15443c37e1d15b981a2c89a0025312c54b76` | Original full text below |

## Original job-log excerpts

These exact lines connect checkout, skipped project caches, each command completion and the uploaded artifact. Other job-log lines are omitted.

```text
2026-09-17T13:22:15.5893748Z 48fd10d0009408a1a3cdd1640bc22884facf00c3
2026-09-17T13:22:28.0052697Z ##[end-action id=__leanprover_lean-action.__actions_cache;outcome=skipped;conclusion=skipped;duration_ms=0]
2026-09-17T13:24:55.2815285Z ##[end-action id=__leanprover_lean-action.__actions_cache_2;outcome=skipped;conclusion=skipped;duration_ms=0]
2026-09-17T13:24:56.3971105Z PASS toolchain.log
2026-09-17T13:25:15.7983671Z PASS build.log
2026-09-17T13:25:18.3563400Z PASS axioms.log
2026-09-17T13:25:26.4293849Z PASS Jsp.Powerful301.log
2026-09-17T13:25:34.4468714Z PASS Jsp.Graph139.log
2026-09-17T13:25:42.5507259Z PASS Jsp.Graph139Fields.log
2026-09-17T13:25:50.6506781Z PASS Jsp.Graph139Parabola.log
2026-09-17T13:25:58.6659226Z PASS Jsp.Graph139Blowup.log
2026-09-17T13:26:06.7436425Z PASS Jsp.Graph139Upper.log
2026-09-17T13:26:08.5162954Z SHA256 digest of uploaded artifact zip is 9902778d3a87418b462bed65c4a841f56051ee3fa100d2bb840773aa79da41f0
2026-09-17T13:26:08.7619877Z Artifact jsp-000301-000139-verification.zip successfully finalized. Artifact ID 10499027839
2026-09-17T13:26:08.7622330Z Artifact jsp-000301-000139-verification has been successfully uploaded! Final size is 3659 bytes. Artifact ID is 10499027839
```

## verification.json

Original SHA-256: `f0cd97bfd896e7def990aee9aa0a15443c37e1d15b981a2c89a0025312c54b76`.

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

## toolchain.log

Original SHA-256: `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d`.

```text
Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)
```

## build.log

Original SHA-256: `89475da1a04e9138a332f352af6adc68ee8833d9781a25b4e0417bf1b230329d`.

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

## axioms.log

Original SHA-256: `a6af308f1a7ed9a16a6dec96ff743e5900b39638e7a191457768fcfa3f7f5ae2`.

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

## Jsp.Graph139.log

Original SHA-256: `0dc47010f370ccc41e3ea2492a706518d3c79f3253d5af8aa5decbb018c6e447`.

```text
replaying Jsp.Graph139
```

## Jsp.Graph139Fields.log

Original SHA-256: `7ee9c70a65ec9c61a0fb9aec11a9e8a689727fb4e99213daa642366aed5bd490`.

```text
replaying Jsp.Graph139Fields
```

## Jsp.Graph139Parabola.log

Original SHA-256: `64b13f08bc030027598bf9061e4215ef7973ee0f809936f5df0eafdd729eda12`.

```text
replaying Jsp.Graph139Parabola
```

## Jsp.Graph139Blowup.log

Original SHA-256: `4e9b19734f729fa67331def650125d08684e86516cb2626e5bdaf3fe2b68f928`.

```text
replaying Jsp.Graph139Blowup
```

## Jsp.Graph139Upper.log

Original SHA-256: `86752ec5b4e98076033614ecda00a3d879a2031225f4649442fb2662fc9bcf2e`.

```text
replaying Jsp.Graph139Upper
```

## Reproduction at A

These instructions request a fresh local project build. They do not claim that the historical CI explicitly ran `lake clean`.

```sh
git clone --branch codex/jsp-000301-000139-000838 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 48fd10d0009408a1a3cdd1640bc22884facf00c3
cd packages/jsp-000301-000139
lake exe cache get
lake clean
python3 scripts/verify.py
lake env lean Audit.lean
```

The [pinned verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/scripts/verify.py) builds, audits both problems and invokes the five graph replays plus the other shared module. The [pinned audit source](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Audit.lean) explicitly checks and prints both submitted JSP-000139 targets. Reproduction results, statement approval and contributor eligibility are separate questions.
