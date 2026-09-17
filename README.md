# JSP-000637 / Erdős 777

This branch also hosts reusable, separately buildable submission packages for [JSP-000301 and JSP-000139](packages/jsp-000301-000139/README.md), and the [preserved JSP-000838 proof from PR #707](packages/jsp-000838/MIGRATION.md). The original 637 package below remains unchanged. See the branch's [batch verification workflow](.github/workflows/jsp-batch.yml).

Complete Lean proof of all three Daykin–Erdős questions: **yes, no, yes**. The entry theorem is `Jsp637.jsp_000637` in [Jsp637.lean](Jsp637.lean); the full proof is [Erdos777.lean](vendor/plby/ErdosProblems/Erdos777.lean).

[中文提交 SOP](docs/SUBMISSION_SOP.zh-CN.md) · [Attribution](vendor/plby/UPSTREAM.md) · [Verification](artifacts/verification.json)

## Scope

+ For every ε > 0, eventually in n, m ≤ (2−ε) 2^(n/2) implies e(F) < 2^n.
+ The assertion that every positive density c admits a uniform bound m ≤ C(c) 2^(n/2) is false, using an unbounded counterexample family with e(F) ≥ m²/16.
+ For every ε > 0, some δ > 0 works for every n: e(F) > m^(2−δ) implies m < (2+ε)^(n/2). Small dimensions are included.

Here `F : Finset (Finset (Fin n))`, m = |F|, and e(F) counts unordered pairs of distinct comparable members. There are no loops or repeated sets, and half-exponents use real division. [Original problem](https://www.erdosproblems.com/777).

## Attribution

This proof already existed in [plby/lean-proofs](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos777.lean). Copyright and Apache-2.0 notices are preserved. The source credits the Lean-Proofs Authors and identifies Codex / GPT-5.6 Sol as formal tools/authors; no human authorship is inferred from those labels.

CHENLexiao8848 publishes a v4.34 compatibility port, explicit catalog statement wrapper, and reproduction evidence. The mathematical solution and original formalization are not claimed as newly discovered by this account. The port updates the Mantel bound using `SimpleGraph.turanNumber_two`. No first-formalization priority, independent human review, or award entitlement is claimed.

Mathematical sources: [Alon–Frankl 1985](https://doi.org/10.1007/bf02582924) and [Alon–Das–Glebov–Sudakov 2015](https://doi.org/10.1016/j.jctb.2015.05.009).

## Reproduce

Lean `v4.34.0`; Mathlib `5ed2965256430c3649e86755f9576b54eca72435`. All dependencies are pinned. After installing elan, run from a fresh checkout:

```powershell
./scripts/verify.ps1 -FetchCache
```

Or run the individual commands:

```bash
lake exe cache get
lake build
lake env lean Audit.lean
lake env leanchecker --verbose ErdosProblems.Erdos777
lake env leanchecker --verbose Jsp637
```

The five audited declarations depend only on `propext`, `Classical.choice`, and `Quot.sound`. Kernel replay checks all local declarations in both modules while importing Mathlib; it is not `--fresh` over all Mathlib or a separate checker implementation. Run the two replays sequentially to limit memory.

The [Linux workflow](.github/workflows/lean.yml) starts from a fresh checkout and publishes build, axiom, and replay evidence. The script records real exit codes and source hashes.

## Prize submission

The official [submission rules](https://github.com/TheJustinSunPrize/awards/blob/main/CONTRIBUTING.md#external-solver-and-lean-submissions) accept references and catalog updates, not Lean source files. Prior evidence is recorded in [Issue #19](https://github.com/TheJustinSunPrize/awards/issues/19). Submission, CI, catalog flags and contribution credits do not establish an award.
