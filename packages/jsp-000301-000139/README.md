# Complete proofs: JSP-000301 and JSP-000139

This package contains the complete scoped powerful-number counterexample and the general asymptotic answer for triangle-free diameter-two graphs. Lean 4.34.0 and Mathlib 5ed2965256430c3649e86755f9576b54eca72435 are pinned by the included toolchain and manifest.

## JSP-000301

`Jsp.Powerful301.answer` in [Powerful301.lean](Jsp/Powerful301.lean) negates the universal square assertion. The companion `counterexample` proves that 12167 and 12168 are positive powerful numbers and neither is a square. Powerful means that the square of every prime divisor divides the number; squares use standard `IsSquare`. This completely answers the catalog's expressly scoped yes/no question, not the separate counting problem Erdős 365.

## JSP-000139 / Erdős 133

`Jsp.Graph139Upper.answer` in [Graph139Upper.lean](Jsp/Graph139Upper.lean) proves, for every n≥121, both a universal Moore lower bound n≤Δ²+1 and the existence of a triangle-free n-vertex graph of extended diameter≤2 with Δ²≤857435524n. These imply the full order-of-growth answer Θ(√n), and refute divergence of the minimum degree bound divided by √n. The deliberately loose constant is not an optimal-leading-constant claim.

The upper construction uses the symmetric parabola `(x, ±x²)`, x≠0, over fields q=11^(2k+1). All required field properties, sum-freeness, completeness, Cayley graph properties and arbitrary-order bounded vertex duplication are proved. The upper bound does not assume an unproved graph or finite-field existence statement. Graphs use standard Mathlib `SimpleGraph`, `CliqueFree`, `ediam` and `maxDegree`.

## Attribution and overlap

CHENLexiao8848 prepared and publishes these Lean formalizations with OpenAI Codex assistance. This does not assert manual authorship or independent human review. The mathematical counterexample for 301 is the known example already displayed in the official record; the asymptotic result for 139 is credited in the literature to Hanson and Seyffarth, with later work by Haviv and Levy. No new mathematical discovery is claimed.

The six Lean modules were developed in the local project rather than copied from another proof repository. Existing related formalizations and submissions are acknowledged: [301 PR #13](https://github.com/TheJustinSunPrize/awards/pull/13), [#33](https://github.com/TheJustinSunPrize/awards/pull/33), [139 PR #111](https://github.com/TheJustinSunPrize/awards/pull/111), and the [complete plby Erdos133 proof](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos133.lean). No first-formalization priority or award entitlement is claimed. This package's 139 implementation uses a parabola-over-finite-fields construction and includes both bounds, whereas #111 describes only the Moore-bound component.

## Reproduce

From this package directory after installing elan:

```bash
lake exe cache get
python scripts/verify.py
```

The verifier builds, audits four declarations against the exact standard-axiom allowlist, and replays all six local mathematical modules with `leanchecker`. Replay uses the same Lean kernel and imports pinned Mathlib; it is not an independently implemented second checker or `--fresh` replay of all Mathlib. Evidence records actual exit codes, source hashes and sanitized logs.

Only this package is submitted for these two IDs. Single numerical witnesses for JSP-000307 and JSP-000598 are not included as full proofs: their original problems require infinitely many examples (official correction issues [#14](https://github.com/TheJustinSunPrize/awards/issues/14), [#20](https://github.com/TheJustinSunPrize/awards/issues/20)).

License: [MIT](LICENSE) for this package; dependencies retain their own licenses.
