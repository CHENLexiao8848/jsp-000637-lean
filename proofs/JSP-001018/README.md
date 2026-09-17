# JSP-001018 / Erdős 1213: complete Lean proof

Main theorem: `JSP001018.erdos1213_int` in [JSPProofs/JSP001018.lean](JSPProofs/JSP001018.lean).
This standalone package is published on branch `codex/jsp-001018-proof` of the
existing CHENLexiao8848/jsp-000637-lean repository. The repository name reflects
an earlier proof; this subdirectory has its own complete build configuration.

## Statement and scope

For all positive integers A and K, there exists F such that every strictly
increasing finite integer sequence a(0),...,a(s-1), with a(0)=A, adjacent
gaps at most K and a(s-1)>F, contains two distinct nonempty index intervals
with equal sums. The conclusion uses actual `Finset.Ico` sums and verifies
that both intervals lie inside the sequence. No additional hypothesis
stands in for an unproved step. The two intervals need not be adjacent,
disjoint, or of equal length.

An explicit sufficient threshold is
`F(A,K) = A + K * (2 * 2^(2*(A+3*K+2)))`.
This proves the full existence question. It does not claim the stronger
published quantitative refinement `F(A,K) = O(A exp(O(K)))`.

The [statement correspondence](STATEMENT.md) explains all hypotheses,
indexing conventions, and the mathematical argument.

## Reproduce

Requires elan/Lean and PowerShell 7 (`pwsh`); the Lean dependency is pinned.
Run from this directory:

```powershell
lake exe cache get
pwsh -NoProfile -File scripts/verify.ps1
```

The script performs `lake build`, explicit axiom auditing, and
`lake env leanchecker --verbose JSPProofs.JSP001018`. Successful evidence
is recorded with input hashes under [evidence](evidence).

- Lean: `leanprover/lean4:v4.34.0`.
- Mathlib: `5ed2965256430c3649e86755f9576b54eca72435`.
- Other dependencies: exact revisions in `lake-manifest.json`.
- Permitted axioms: `propext`, `Classical.choice`, `Quot.sound`.
- No `sorry`, `admit`, added axiom, `native_decide`, or external proof oracle.

`leanchecker` replays this proof module with the same Lean kernel implementation
and pinned imported dependencies. It is not an independently implemented
second checker or a complete replay of Mathlib. No independent human review
or award eligibility is asserted.

## Attribution and prior work

The historical mathematical result is due to N. Hegyvári, *On consecutive sums
in sequences*, Acta Mathematica Hungarica 48 (1986), 193–200,
[DOI](https://doi.org/10.1007/BF01949064). The precise problem is
[Erdős 1213](https://www.erdosproblems.com/1213), catalogued as
[JSP-001018](https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-1001-1022.md#JSP-001018).

This dyadic pigeonhole implementation was developed with OpenAI Codex at
CHENLexiao8848’s request. CHENLexiao8848 is the human operator, maintainer and
submitter; the Lean code and proof organization were generated with Codex
assistance. This is not a claim of sole manual authorship, first mathematical
discovery, first formalization, or independent verification.

Earlier public formalization and submissions are acknowledged:

- [plby/lean-proofs, immutable Erdős 1213 source](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos1213.lean)
- [Official issue #27](https://github.com/TheJustinSunPrize/awards/issues/27)
- [Official PR #45](https://github.com/TheJustinSunPrize/awards/pull/45)

This package contains a separate dyadic-domain proof and an explicit integer
interface, rather than a copy or port of that earlier Lean file. Existing
proofs may have sharper bounds. The actual submitted contribution is this
alternative complete implementation, its scope correspondence, and reproducible
verification. The source uses Mathlib lemmas with their existing authorship.

License: Apache-2.0, as in the repository [LICENSE](../../LICENSE).
