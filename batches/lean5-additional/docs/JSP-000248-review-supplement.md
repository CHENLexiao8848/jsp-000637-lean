# JSP-000248 / PR #781: mathematical source, full density argument and attribution

Prepared 26 September 2026 by AI-assisted source review, not independent human mathematical verification. This supplement concerns the unchanged contribution repository `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-additional-20260917`, commit `a4d83d426d9ee2d92511857831e27b70216aedfe`, package `batches/lean5-additional`. Execution evidence is reported separately; no new Lean build was run for this mathematical review.

## Mathematical sources and the actual proof route

[Erdős Problem 292](https://www.erdosproblems.com/292) asks about the density of integers occurring as the largest denominator in an Egyptian-fraction representation of 1. **Greg Martin** proved the stronger exceptional-set estimate in *Denser Egyptian Fractions*, Acta Arithmetica 95 (2000), 231–260, [DOI](https://doi.org/10.4064/aa-95-3-231-260). In the fixed [arXiv:math/9811112v1](https://arxiv.org/pdf/math/9811112v1), **Theorem 4 is on printed p.3 and its proof is in §7, pp.24–25**. These are preprint page numbers. The theorem gives density zero, with quantitative bounds, for numbers that cannot be the largest denominator. The corresponding density-one conclusion is the scope submitted here; the quantitative exceptional-set bound is not formalized by this package.

The reused Lean proof follows a different route. It invokes **Thomas F. Bloom's positive-upper-density theorem**, *On a density conjecture about unit fractions*, [arXiv:2112.03726v1](https://arxiv.org/pdf/2112.03726v1), **Theorem 2 on p.1; its deduction is in §2.2, pp.6–7, using the analytic results proved later in that paper**. This theorem says that any subset of positive integers with positive upper density contains a finite subset whose reciprocal sum is 1. This mathematical dependency should be credited separately from Martin's earlier resolution of the specific largest-denominator question.

The original [Unit fractions formalization project](https://b-mehta.github.io/unit-fractions/) identifies **Thomas F. Bloom and Bhavik Mehta** as its authors. The selected proof snapshot restores the `UnitFractions` development through plby's pinned source tree; the complete dependency's mathematical and formalization credit is not transferred to the submitter by that restoration. Plby's `Erdos292.lean` header separately identifies Codex and GPT-5.6 Sol for its density-one corollary.

## Complete density-one argument

Let $A$ consist of natural numbers $n$ for which there is a finite set

$$S\subseteq\{1,\ldots,n\},\qquad n\in S,\qquad \sum_{m\in S}\frac1m=1.$$

Let $B=\mathbb N\setminus A$. Suppose, towards a contradiction, that $B$ has positive upper density. Removing zero does not change upper density. Bloom's proved theorem then produces a finite set of positive elements $T\subseteq B$ with reciprocal sum 1. Equivalently, the formal proof first obtains a natural-number finite set and erases zero; since the rational convention gives $1/0=0$, this erasure leaves its sum unchanged.

The remaining set $T$ is nonempty, since its reciprocal sum is 1 rather than 0. Let $n=\max T$. Every $m\in T$ satisfies $1\le m\le n$ and $n\in T$, so $T$ itself proves $n\in A$. But $T\subseteq B$ also gives $n\in B$, a contradiction. Therefore the upper density of $B$ is zero.

For each positive $N$, the partial densities satisfy $0\le |B\cap[0,N)|/N\le1$. Nonnegativity together with upper limit zero gives convergence of this ratio to zero. The exact complementary counting identity is

$$\frac{|A\cap[0,N)|}{N}=1-\frac{|B\cap[0,N)|}{N}.$$

Hence $|A\cap[0,N)|/N\to1$. The value at $N=0$ is immaterial to a limit at infinity. The natural half-open interval convention is equivalent to the ordinary positive-integer counting convention up to at most an endpoint contribution divided by $N$. This proves density one of the full set, rather than density of a selected subfamily or a finite obstruction calculation.

Bloom's theorem is a proved imported result, not an extra assumption left in the submitted statement. Its full mathematical publication and formal source dependency are identified above. The argument after applying that theorem is exactly the already existing plby proof, not a new reduction by this submitting account.

## Formal statement and exact local changes

The [fixed local entry](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/LeanTwenty/JSP000248.lean) defines `JSP000248.Attainable` by a `Finset ℕ`, containment in `Finset.Icc 1 n`, membership of the largest denominator and equality of the rational reciprocal sum to 1. A finite set enforces distinct denominators; the interval excludes zero; no unproved existence or density assumption is imposed.

Its only public terminal, `JSP000248.solution`, is

```lean
Tendsto (fun N : ℕ =>
  (((Finset.range N).filter Attainable).card : ℝ) / N) atTop (𝓝 1)
```

The proof is exactly an application of the pre-existing `Erdos292.tendsto_partial_density_largestDenominators`. The [fixed upstream file](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos292.lean) already contains this explicit limit and the equivalent `erdos_292` density statement. Thus the local interface does not add a previously missing convergence theorem or enlarge the mathematical scope.

The local [compatibility patch list](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/patches/unitfractions-v434.json) replaces twelve specified uses of product comparison lemmas by their Mathlib 4.34 nonnegative variants, in five `UnitFractions` files. These are compatibility edits to existing proof terms; they do not introduce a new analytic theorem, a stronger bound or a new density argument. The unchanged `Erdos292` file and exactly restored/patched dependencies are distinguished by the source lock.

The submitter's claim is limited to this interface, compatibility work, restoration and reproducibility material, developed and published with OpenAI Codex assistance. No mathematical-discovery credit, authorship of the reused complete proof, first formalization or independent human review is claimed. Other PRs cited in the original submission are related records; their being partial or closed cannot establish that the already inspected complete plby theorem was absent.

## Review limitation

The mathematical and formal statement cover the full density-one question. The unresolved issue is the significance and qualification of the submitter's own limited changes in a largely reused complete proof. Documentation, restored source hashes and successful checking can substantiate reproducibility, but do not establish original complete-proof authorship or prize entitlement. The mathematical review and attribution requirements should be evaluated on that candid basis; an original-contribution checklist should not be affirmed for someone else's entire formalization.
