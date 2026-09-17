# JSP-000633: exact comparison with the finite guarantee in PR #454

## Contribution and requested assessment

The complete JSP-000633 proof in [official PR #744](https://github.com/TheJustinSunPrize/awards/pull/744) gives a uniformly no-smaller integer Sidon-subset certificate than the one extracted below from the earlier PR #454. For fixed k=4, its leading constant is 24.29% larger; as k increases the improvement tends to 25.99%. The exponent 2/3 and the order k^(-1/3) are unchanged.

Please assess this quantified increment, the independently written implementation and reproduction evidence for attributable contribution credit and any applicable nomination or award consideration. Please identify whether this strengthening of an already-formalized problem is eligible under the applicable process. This requests a reasoned contribution assessment, not an award announcement or payment entitlement.

This note supplements #744. It is not a second submission of the original problem. It does not claim the best known mathematical constant, first formalization of the original problem, or the strongest bound obtainable by reoptimizing the competitor's proof.

## Fixed sources and identical conventions

| Implementation | Fixed proof revision | Declarations |
| --- | --- | --- |
| CHENLexiao8848, official #744 | ea6e7fc0a5893edd13335acc4e1ebd00cd261782; CHENLexiao8848/awards; branch codex/four-lean-proofs-20260917 | JSP000633.representations, BoundedRepresentations, IsSidon, finite_bound |
| CollinYuanjieRen, earlier #454 | ea595e8a8a96f1fbd5a097fb8517ca19ef5f6904; CollinYuanjieRen/awards | Erdos772.rep, RepBounded, IsSidon, exists_s, H_lower, exists_sidon_subset |

Fixed links: [user theorem](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Problems/JSP000633.lean#L289), [competitor definitions](https://github.com/CollinYuanjieRen/awards/blob/ea595e8a8a96f1fbd5a097fb8517ca19ef5f6904/submissions/jsp-000633-cyr/Erdos772Sidon/Definitions.lean#L22), [competitor finite bounds](https://github.com/CollinYuanjieRen/awards/blob/ea595e8a8a96f1fbd5a097fb8517ca19ef5f6904/submissions/jsp-000633-cyr/Erdos772Sidon/Bounds.lean#L19), [competitor deletion theorem](https://github.com/CollinYuanjieRen/awards/blob/ea595e8a8a96f1fbd5a097fb8517ca19ef5f6904/submissions/jsp-000633-cyr/Erdos772Sidon/Alteration.lean#L5).

Both count ordered pairs (a,b) in A x A with a+b=m, including a=b. Both define Sidon by a+b=c+d implying equality of the unordered pairs, including repeated terms. Let k>=1 and n=|A|>=0. For small k, some cardinalities have no admissible set; universal claims can then be vacuous. Examples below use k>=4 and concern guaranteed sizes, not exact extrema or observed subset sizes.

## Exact integer guarantees

Write C=24k+4. In the earlier package, exists_s selects the largest integer s satisfying 6ks^3<=n^2; the deletion theorem yields s<=2|B|. Thus

$$s=\left\lfloor\left(\frac{n^2}{6k}\right)^{1/3}\right\rfloor,\qquad L(k,n)=\left\lceil\frac{s}{2}\right\rceil.$$

The user's finite_bound proves n^2<=C|B|^3, giving

$$U(k,n)=\left\lceil\left(\frac{n^2}{24k+4}\right)^{1/3}\right\rceil.$$

### Uniform dominance, with rounding retained

For every integer k>=1 and n>=0, U(k,n)>=L(k,n).

If L=0 this is immediate. Otherwise let t=L-1>=0. Since s>=2t+1 and 6ks^3<=n^2,

$$n^2-Ct^3\ge6k(2t+1)^3-(24k+4)t^3$$

$$=(24k-4)t^3+72kt^2+36kt+6k>0.$$

Hence (n^2/C)^(1/3)>t and U>=t+1=L. This is an elementary derivation from the pinned formal results. The comparison theorem itself has not been newly formalized or kernel-checked in this evidence update.

### Reproducible examples

| k | n | Earlier guarantee L | User guarantee U |
| ---: | ---: | ---: | ---: |
| 4 | 1,000 | 17 | 22 |
| 10 | 1,000 | 13 | 17 |
| 100 | 1,000 | 6 | 8 |
| 4 | 1,000,000 | 1,733 | 2,155 |
| 10 | 1,000,000 | 1,277 | 1,601 |
| 100 | 1,000,000 | 593 | 747 |

For fixed k and n tending to infinity, the ratio of the leading coefficients is

$$R(k)=\left(\frac{48k}{24k+4}\right)^{1/3}.$$

At k=4 this is approximately 1.242893; as k tends to infinity it tends to 2^(1/3), approximately 1.259921. These percentages concern the extracted asymptotic guarantee, not every finite n or the actual optimal Sidon subset.

## Attribution and prior work

The original mathematics is credited to Noga Alon and Paul Erdos (1985). The earlier complete plby formalization and its registration in [issue #19](https://github.com/TheJustinSunPrize/awards/issues/19) and [PR #40](https://github.com/TheJustinSunPrize/awards/pull/40) are acknowledged. [PR #454](https://github.com/TheJustinSunPrize/awards/pull/454) predates #744 and independently resolves the original question. This note does not dispute those contributions or priority.

The prior #744 comparison with the pinned plby coefficient 4096(k+1)^3 remains valid, but is not the sole benchmark. #454 already has a cubic inequality with linear k dependence. Relative to #454, the advance documented here is an explicit constant and finite-certificate improvement, not an exponent improvement or a new order of k dependence.

CHEN LEXIAO (@CHENLexiao8848) directed the project and commissioned the AI-assisted proof implementation and evidence preparation. OpenAI Codex assisted with this comparison. This does not imply sole manual authorship or independent human verification.

## Verification and limits

The existing [proof verification report](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/report.json) records a successful Lean 4.34 build, named-theorem axiom audits and local-module kernel replay for the unchanged proof package. Permitted axioms are propext, Classical.choice and Quot.sound. This update does not modify that proof or substitute Python checks for Lean validation.

Run python verify_comparison.py in this directory. The dependency-free script uses exact integer cube roots, checks certificate boundaries and all 200,100 pairs with 1<=k<=100 and 0<=n<=2000, and reproduces the table. It prints JSON and does not access the network or write files. The finite test supports the formula implementation; the algebraic argument above supplies the unbounded comparison on paper. No competing Lean project was rebuilt for this note.

Source URLs, revisions and hashes are in sources.json; exact local output is results.json. No third-party proof text is copied into this evidence package. Broader literature novelty, first publication of this precise strengthening, official eligibility and award value remain unestablished and require review.
