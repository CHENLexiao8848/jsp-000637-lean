# JSP-001018 / Erdős 1213: mathematical solution, statement correspondence and contribution review

Prepared on 2026-09-26 for [awards PR #723](https://github.com/TheJustinSunPrize/awards/pull/723). This is a documentation supplement to a fixed proof version, not a new proof revision or a claim of accepted mathematical review, priority or award eligibility.

## 1. Fixed version and mathematical provenance

The original question is [Erdős 1213](https://www.erdosproblems.com/1213), catalogued as JSP-001018. For positive integers $A,K$, it asks for a finite threshold such that a strictly increasing finite integer sequence starting at $A$, with adjacent gaps at most $K$ and last term above that threshold, contains two distinct nonempty consecutive index intervals with equal sums. “Consecutive” describes each interval internally; the two intervals are not required to be mutually adjacent, disjoint or equal in length.

The historical mathematical solution is attributed to **N. Hegyvári**, *On consecutive sums in sequences*, **Acta Mathematica Hungarica 48** (1986), 193–200, [DOI 10.1007/BF01949064](https://doi.org/10.1007/BF01949064). The article and problem page are the historical references. The full original article was not independently inspected for an internal theorem/page pinpoint during this review; the article's page range must not be mistaken for such a pinpoint. Other formalization repositories identify their sharper result with Hegyvári's Theorem 3. Section 2 below instead supplies the complete mathematical argument actually implemented in the submitted source, with exact corresponding Lean declarations. Review of that supplied argument is requested together with the formalization. No journal acceptance or independent human review of this alternative implementation is asserted.

- Original proof repository: [CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean).
- Named branch: `codex/jsp-001018-proof`.
- Fixed proof commit **A**: `26ca7691dfee68c8f2865381cbc3e33bd5914fff`.
- Standalone package: [`proofs/JSP-001018`](https://github.com/CHENLexiao8848/jsp-000637-lean/tree/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018).
- Complete proof: [`JSPProofs/JSP001018.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/JSPProofs/JSP001018.lean).
- Terminal integer theorem: [`JSP001018.erdos1213_int`, line 251](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/JSPProofs/JSP001018.lean#L251).
- Source SHA256: `8a561afac62a7c942bb98d6ec935bb9322dfb6f9ba930fd7700ce8ac4ceaa445`.

The repository's name comes from an earlier problem. This package has its own toolchain, manifest, build configuration, audit and verifier. This supplementary document may be added in a later descendant documentation commit **B**; the proof, source hashes and CI evidence in this review continue to refer to **A**.

## 2. Complete mathematical argument for the submitted threshold

**Proposition.** For $A,K\geq1$, put

$$
R=A+3K+2,\qquad M=2^{2R},\qquad F(A,K)=A+2KM.
$$

Every finite strictly increasing integer sequence $a_0,\ldots,a_{s-1}$ with $s>0$, $a_0=A$, $a_{j+1}-a_j\leq K$ for $j+1<s$, and $a_{s-1}>F(A,K)$, has two distinct nonempty index intervals contained in $[0,s)$ whose sums are equal.

**Proof.** The first value and strict increase make every value positive. Induction using the gap bound gives $a_j\leq A+Kj$ for $j<s$. If $s<2M$, then $a_{s-1}\leq A+K(s-1)\leq A+2KM$, contradicting the last-term hypothesis. Hence $s\geq2M$.

For each integer $r$ with $0\leq r<R$, select every pair of a block length and a block start of the form

$$
\ell=2^r+t\quad(0\leq t<2^r),\qquad
0\leq i<2^{2R-r}.
$$

There are $2^r2^{2R-r}=M$ pairs at each scale and $RM$ pairs in total. The length ranges $[2^r,2^{r+1})$ of different scales are disjoint, so different choices give different pairs $(i,\ell)$.

Each chosen length is positive and satisfies $\ell\leq2^R$, $\ell i\leq2M$, and $\ell^2\leq M$. Also $i<M$ and $\ell\leq M$, so $i+\ell\leq2M\leq s$: all blocks are valid. Their sums are nonnegative integers and satisfy

$$
\begin{aligned}
S(i,\ell)&=\sum_{t=0}^{\ell-1}a_{i+t}
\leq \ell\bigl(A+K(i+\ell)\bigr)\\
&=A\ell+K\ell i+K\ell^2
\leq (A+3K)M.
\end{aligned}
$$

There are at most $(A+3K)M+1$ possible sum values. Since $M\geq1$ and $R=A+3K+2$,

$$
(A+3K)M+1 < RM.
$$

The pigeonhole principle therefore gives two different selected pairs with the same sum. Nonempty half-open integer intervals determine their first index and their cardinality, hence their start and length. Different selected pairs consequently give different intervals. This proves the proposition. $\square$

This threshold establishes the original existence question for all parameters. It grows exponentially in $A$, and this proof does **not** establish the sharper known dependence linear in $A$ and exponential in $K$. That quantitative improvement is not being claimed as a new result or silently included among the checked terminal statements.

## 3. Exact formal correspondence and checked scope

All declarations below are in the fixed proof file linked above. Its local dependencies are Mathlib imports, not imports of one of the other submitted proof repositories.

| Mathematical object or step | Declaration / representation at A |
| --- | --- |
| Sum of a block starting at $i$ with length $\ell$ | `blockSum`, `∑ t ∈ range l, a (i+t)` |
| Selected finite family of blocks | `DyadicDomain`, `blockStart`, `blockLength` |
| Exactly $RM$ blocks and pair uniqueness | `card_dyadicDomain`, `blockPair_injective` |
| Positive lengths, valid indices and sum bound | `blockLength_pos`, `dyadic_bounds`, `dyadic_indices`, `dyadic_sum_le` |
| Pigeonhole collision, symbolic in $A,K$ | `exists_equal_blocks_of_linear_bound` |
| Explicit threshold $A+2KM$ | `lengthBound` and `valueBound`, lines 169–171 |
| Linear upper bound from adjacent gaps | `linear_bound_of_gaps` |
| Actual index-interval sums and different finite sets | `blockSum_eq_sum_Ico`, `blockInterval_injective` |
| Natural-valued finite sequence conclusion | `bounded_gap_equal_intervals`, line 208 |
| Quantified positive-parameter natural statement | `erdos1213`, line 234 |
| Quantified original integer-valued statement | `erdos1213_int`, line 251 |

The integer terminal statement takes `A K : ℕ` with `1 ≤ A` and `1 ≤ K`, and produces `F : ℕ`. This covers every positive integer first term and positive integer gap bound; their natural representatives are exact. It then universally quantifies `s : ℕ` and `a : ℕ → ℤ`, assumes `0 < s`, `a 0 = (A : ℤ)`, adjacent strict increase for `j+1 < s`, adjacent integer gaps at most `(K : ℤ)`, and `(F : ℤ) < a (s-1)`.

The output lengths `l,m` are strictly positive, both endpoints `i+l,j+m` are at most `s`, the two `Finset.Ico` intervals are unequal as finite sets, and their actual integer sums are equal. Only the first `s` entries are used. The function on all natural indices is a representation of a finite sequence; arbitrary extensions beyond that finite domain are irrelevant. The theorem proves nonnegativity on the finite domain, applies `toNat`, and transports both sums back to the integers. No positivity or cast identity needed for that conversion is left as an unproved assumption. The core natural theorem needs only the upper gap bound; the terminal integer statement retains the original strict-increase condition.

The zero-length case is excluded by the original nonempty-sequence setup. Intervals of length zero are excluded explicitly. Singleton and other short sequences are not silently omitted: the last-term premise is simply impossible when the threshold is not crossed. There is no upper bound on the sequence length, no bounded computational search replacing the general proof, and no extra existence hypothesis supplying the desired collision.

## 4. Prior work and concrete contribution limits

The historical mathematics remains Hegyvári's. The following public material must be considered when assessing novelty and priority. The comparison below is based on the cited fixed source, not merely on catalog labels or PR opening order. This review did not rebuild the other authors' projects, and it does not certify their CI or award eligibility.

| Public source | Content visible in the cited version | Consequence for this submission |
| --- | --- | --- |
| [plby, `Erdos1213.lean` at `8822f7dd…`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos1213.lean), also [issue #27](https://github.com/TheJustinSunPrize/awards/issues/27) and [PR #45](https://github.com/TheJustinSunPrize/awards/pull/45) | `erdos_1213` proves the existence conclusion. `explicitBound = 4^K*A + 2*K*(4^K)^2`, and `explicitBound_le` gives `≤ 3*A*32^K`. The construction uses sliding windows and bins of possible sums. | A complete public implementation already exists, with a stronger dependence on $A$. The current dyadic-domain implementation is not a first formalization or a quantitative improvement over that proof. |
| [Trevor Morris / gotrevor, `Statement.lean` at `efc72e14…`](https://github.com/gotrevor/lean-gallery/blob/efc72e14c2030842a44dbc7e42850981886fdd03/LeanGallery/Combinatorics/Erdos1213/Statement.lean), registered in [PR #1223](https://github.com/TheJustinSunPrize/awards/pull/1223) | `erdos_1213` gives a last-term bound `(A+K/2)*exp(K+1)+K*exp(2*K+2)` under distinctness of all interval sums. `erdos_1213_f_finite` bounds the supremum of attainable last terms. The linked `Basic`, `Counting`, `Analytic` and `Main` files supply definitions and proofs. | This is another public complete formalization, including a sharper quantitative result. Its README's own priority wording is not adopted here as an independently established priority finding. |
| [zjukop3, `RepeatedSums.lean` at `83213ad6…`](https://github.com/zjukop3/jsp-001018-repeated-sums/blob/83213ad65cde76ff80819be5d4877d55c3665b7e/RepeatedSums.lean), [PR #755](https://github.com/TheJustinSunPrize/awards/pull/755) | `jsp_001018` and `erdos_1213_int` supply complete integer interfaces. `harmonic_threshold`, `bound_comparison` and `bound_exponential` establish a harmonic-counting bound `K*4^K*(A/K+4^K+1) ≤ 3*A*32^K`, with natural division. | An explicit integer interface is not unique to this submission. This competing implementation also has a stronger quantitative bound. |
| [CN-F90, `JSP001018.lean` at `d21ae5ec…`](https://github.com/CN-F90/JSP-001018-Lean/blob/d21ae5ec35c36122ca0ac2b6d226fa42c2c47bcc/JSP001018.lean), [PR #827](https://github.com/TheJustinSunPrize/awards/pull/827) | Its terminal theorem states the complete natural existence result, and its source describes a dyadic family of lengths and starts with a different coarse threshold. Only the terminal file was inspected for this comparison, not a fresh build of its imported local modules. | The general idea of dyadic counting must not be presented as unique to this submission. Distinct implementations or constants alone do not prove historical independence. |

As checked on 2026-09-26, #755, #827 and #1223 were open and unmerged. #45 was closed and unmerged; its maintainer requested migration to the catalog-only submission format. Closing that PR does not erase the public proof or establish a mathematical rejection. The proof file in #45 is byte-identical to the pinned plby file, so these are not counted as two independent proof implementations.

Other related submissions were found, including [#1205](https://github.com/TheJustinSunPrize/awards/pull/1205) (a claimed extension to arbitrary multiplicity) and [#1622](https://github.com/TheJustinSunPrize/awards/pull/1622) (another claimed complete formalization). Their PR descriptions were inspected, but their complete source dependencies and builds were not audited here. They are disclosed as related submissions, not certified results or verified priority determinations. Mathematical-solver registrations and Lean-author registrations also require separate contribution assessment.

The concrete object offered for review in #723 is the local finite dependent-type family `DyadicDomain`, its exact cardinality and injectivity proofs, the uniform sum-bound/pigeonhole assembly, the nonempty-interval injectivity lemma, and the checked conversion to a literal integer interval-sum statement. These are present as local declarations in A. This is a description of the submitted implementation, not evidence that its proof strategy or mathematical theorem was first discovered by the submitter.

## 5. Authors, repository provenance and review request

The fixed [README](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/26ca7691dfee68c8f2865381cbc3e33bd5914fff/proofs/JSP-001018/README.md) states that the implementation and proof organization were developed with OpenAI Codex assistance at **CHENLexiao8848**'s request. The human account is the operator, maintainer and submitter. The contribution is not represented as sole manual authorship, a new mathematical discovery, first formalization, or independent verification. Mathlib results retain their existing attribution. The repository is Apache-2.0 licensed.

The source at A, its commit/branch history, the fixed README and the same-commit CI run are public evidence of the submitted artifact and its disclosed development roles. Repository ownership and successful compilation are not by themselves proof of exclusive authorship or priority. No unobserved private development history or independent human review is invented here. This is a self-submission seeking contribution recognition; eligibility and any priority among overlapping public work remain for the maintainers to assess.

## 6. Verification evidence and remaining decisions

The companion [exact-SHA CI evidence report](JSP-001018-verification-review-20260926.md) preserves the small original artifact logs and verification record from [run 35226032048](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226032048). It distinguishes that successful 2026-09-17 Linux CI from this 2026-09-26 source/evidence review. No new Lean execution is claimed today. The selected proof commit and dependency revisions are fixed; the existing CI built the project on a fresh checkout with pinned dependency caches, elaborated the separate audit, and replayed the one local proof module.

The three audited target closures are `JSP001018.bounded_gap_equal_intervals`, `JSP001018.erdos1213`, and `JSP001018.erdos1213_int`; all report only `[propext, Classical.choice, Quot.sound]`. Replay uses Lean's own kernel and imported dependencies, not an independently implemented second checker or a fresh replay of all Mathlib.

The supplied proposition and source correspondence are ready for mathematical and statement review. The fixed CI supports build and axiom verification. Neither substitutes for the independent mathematical review and maintainer acceptance required by the [submission rules](https://github.com/TheJustinSunPrize/awards/blob/1d1db84a39201357236183f0bbd620e2b220747e/CONTRIBUTING.md). Recognition of this alternative implementation, original contribution, priority and any prize remain unresolved review decisions. No eligibility, candidate or award status is changed by this document.
