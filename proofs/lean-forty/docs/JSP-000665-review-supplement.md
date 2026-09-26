# JSP-000665 / PR #787: mathematical argument and contribution review

Reviewed 26 September 2026. This is AI-assisted source review, not independent human mathematical verification. This review read the fixed local interface, the Chebyshev lemma, the exact reconstructed plby disproof and its original source. It did not run Lean. The separate verification review is responsible for execution and source-restoration evidence.

## Mathematical source and exact scope

The original source entry is [Erdős Problem 808](https://www.erdosproblems.com/808), also available as its [LaTeX record](https://www.erdosproblems.com/latex/808). The selected question is the strong graph-restricted sum-product conjecture, not the unrestricted sum-product conjecture for complete graphs.

Noga Alon, Imre Z. Ruzsa and József Solymosi, [*Sums, products, and ratios along the edges of a graph*, arXiv:1802.06405v1](https://arxiv.org/pdf/1802.06405v1), submitted 18 February 2018, provides the mathematical solution. **Conjecture 2 is on printed p.1; Theorem 3 and its complete construction/proof are on printed p.2.** Theorem 4, pp.2–3, supplies a stronger range of counterexamples for every fixed $0<c<1$. Published version: Publicacions Matemàtiques 64 (2020), 143–155, [DOI](https://doi.org/10.5565/publmat6412006). These pinpoint pages refer to the identified arXiv v1, not an inferred journal-page offset.

Theorem 3 gives arbitrarily large integer-labelled graphs whose restricted sum and product sets are substantially smaller than their edge counts. The submitted fixed Lean implementation uses a coarse prime-block specialization of that construction; its particular exponents are not claimed to reproduce the paper's strongest estimates. The complete argument actually corresponding to the submitted source is set out below.

The selected formal target is a literal negation of a universal conjecture: for every positive $c,\varepsilon$, all sufficiently large sets and graphs should satisfy the proposed lower bound. One fixed positive pair $(c,\varepsilon)$ with arbitrarily large counterexamples refutes that entire conjecture. It need not prove Theorem 4's separate assertion for every $c$. The extracted source omits the original plby file's independent complementary incidence lower bound; no proof of that extra theorem is claimed.

## Complete argument corresponding to the submitted implementation

Fix a sufficiently large natural parameter $q$. Let

$$p_i=p_{q^2+i}\quad(0\le i<q),$$

where the primes are indexed from zero. These are distinct primes, each at least $q^2$, and the local lemma below gives $p_i\le q^7$ once $q\ge64$.

Let $U$ be the integers $1\le u\le q^{15}$ that are divisible by none of these $q$ primes. For a fixed prime $p_i\ge q^2$, at most $q^{13}$ numbers in this interval are multiples of $p_i$. The union bound therefore removes at most $q^{14}$ numbers. Thus, for $q\ge2$,

$$q^{15}/2\le |U|\le q^{15}.$$

Put $D=\prod_i p_i$. The vertices are triples $(u,i,j)$ with $u\in U$ and $i\ne j$, with positive integer label

$$a(u,i,j)=u p_j\prod_{k\ne i}p_k=u p_jD/p_i.$$

These labels are injective. The only block prime absent as a divisor of the label is $p_i$, so equality of labels first identifies $i$. Cancelling the common positive $D/p_i$ leaves $u p_j=v p_l$. Since neither $u$ nor $v$ has a block prime divisor, primality identifies $j=l$; cancellation then gives $u=v$. This establishes a finite set of distinct positive natural labels, without assuming injectivity or importing a finite search assertion.

Join $(u,i,j)$ to $(v,j,i)$ for every $u,v\in U$. Reversal makes adjacency symmetric; $i\ne j$ excludes loops. There are

$$n=|U|q(q-1),\qquad 2m=n|U|$$

vertices and twice as many edges as half the degree sum. Consequently

$$q^{17}/4\le n\le q^{17},\qquad m\ge q^{32}/16.$$

For adjacent vertices, the product is $uvD^2$, so there are at most $q^{30}$ distinct edge products. The sum is

$$\Bigl(\prod_{k\ne i,j}p_k\Bigr)(u p_j^2+v p_i^2).$$

For fixed $(i,j)$ the positive parenthesized numerator is at most $2q^{29}$, using $u,v\le q^{15}$ and $p_i,p_j\le q^7$. Taking the union over at most $q^2$ ordered index pairs bounds the number of edge sums by $2q^{31}$. This counts values, not edges or multiplicities; using both orders merely overcounts a containing set and is harmless.

Set $c=29/34$ and $\varepsilon=1/68$. For all sufficiently large $q$,

$$n^{1+c}=n^{63/34}\le q^{63/2}\le q^{32}/16\le m,$$

while

$$\max(|A+_GA|,|A\cdot_GA|)\le2q^{31}
< (q^{17}/4)^{125/68}\le n^{125/68}=n^{1+c-\varepsilon}.$$

The two strict exponent gaps, $32>63/2$ and $125/4>31$, absorb the fixed constants; no unproved density or asymptotic hypothesis remains. Since $n\ge q^{17}/4$, the examples are arbitrarily large. Concretely, for any prescribed $N$, select $q$ beyond the finitely many asymptotic thresholds and at least $\max(4N,2)$; then $q^{17}\ge q\ge4N$ and $n\ge N$. This is exactly the cofinality step added in `explicit_counterexamples`.

The finite vertex type equipped with an injective label map is equivalent to a graph on its finite image set. The standard Mathlib `SimpleGraph` handles unordered, loop-free edges; `edgeSums` and `edgeProducts` are actual finite images of addition and multiplication. The positivity theorem proves that this counterexample also meets the positive-integer interpretation even though `StrongErdos808` quantifies over natural embeddings that could in general include zero.

### Sum versus maximum

The paper writes Conjecture 2 with the **sum** of the two image cardinalities; the selected Lean final theorem uses their **maximum**, matching the “one of the resulting value sets” formulation. The universally quantified conjectures are mathematically equivalent after adjusting $\varepsilon$, because

$$\max(S,P)\le S+P\le2\max(S,P),$$

and a fixed factor two is eventually absorbed by any positive exponent margin. For example, the displayed maximum counterexamples also give

$$S+P<2n^{250/136}<n^{251/136}
=n^{1+c-1/136}$$

for sufficiently large $n$. Thus the negative resolution transfers to the paper's sum formulation. **The fixed Lean interface does not separately formalize this last sum inequality, nor a sum endpoint at the same $\varepsilon=1/68$.** Describe the formal conclusion exactly and retain this elementary informal equivalence; do not list a nonexistent sum theorem as audited.

## The actual local addition: Chebyshev replaces the external PNT step

The original fixed [plby `Erdos808.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos808.lean#L1050) already proves `blockPrime_le_seventh_eventually` using `nth_prime_asymp` from `PrimeNumberTheoremAnd.Consequences`. It already proves the complete final disproof, the same prime-block construction and the same final exponent pair. This was not an incomplete upstream proof awaiting a missing number-theoretic assumption.

The local [`LeanForty/PrimeBlockBound.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/LeanForty/PrimeBlockBound.lean#L9) supplies a different proof of that sufficient polynomial estimate. It invokes Mathlib's [`Chebyshev.pi_ge`](https://github.com/leanprover-community/mathlib4/blob/5ed2965256430c3649e86755f9576b54eca72435/Mathlib/NumberTheory/Chebyshev.lean#L747):

$$\pi(x)\log x\ge x\log2-\log(x+1)\quad(x>1).$$

Take $x=q^7$, $q\ge64$. The elementary logarithmic bounds used are $\log2\ge1/2$, $\log q\le q$, and $\log(q^7+1)\le1+7q$, while $\log(q^7)\le7q$. If $\pi(q^7)\le q^2+q$, these give

$$q^7/2-1-7q\le 7q\pi(q^7)\le7q^3+7q^2,$$

which is impossible for $q\ge64$: $q^7/2\ge q^4/2\ge32q^3$, whereas $7q^3+7q^2+7q+1\le22q^3$. Therefore $\pi(q^7)>q^2+q$, so each of the first $q$ primes starting at index $q^2$ is at most $q^7$. The formal source then packages the explicit $q\ge64$ theorem as the eventual statement expected by the reused construction.

This is a concrete local proof change and a smaller external dependency requirement for the selected disproof. It also makes the threshold of this particular auxiliary estimate explicit. It does not improve the ultimate counterexample exponents, solve another case of the original conjecture, or establish that Chebyshev-based arguments were mathematically unknown. Mathlib's Chebyshev development credits Alastair Irving, Terry Tao and Ruben Van de Velde and notes material upstreamed from the PrimeNumberTheoremAnd project; removing the external project import does not make these underlying library results the submitter's work.

## Exact reuse and authorship boundary

The supplied extractor retains plby's definitions, graph construction, injectivity argument, counting arguments, power comparisons and disproof. It removes the unrelated incidence section, replaces just the sufficient prime bound, narrows imports and introduces the local `nth_prime` notation. The original headers identify mathematical authors Alon, Ruzsa and Solymosi; formal-author notices name Codex/GPT-5.6 Sol and Codex/Boris Alexeev. Those notices must remain attached to the restored proof.

The local interface adds a cofinality corollary `explicit_counterexamples`, a paired positivity/injectivity theorem, and a named alias of the already complete disproof. The body of `explicit_counterexamples` packages the same eventual inequalities and cardinal lower bound already available upstream; its explicit $N$ quantifier is a useful interface, not a newly completed mathematical case. `positive_injective_labels` pairs two existing upstream theorems. The Chebyshev proof, interface code, extraction protocol and reproducibility records are the specific local additions offered for contribution review.

Earlier [PR #551](https://github.com/TheJustinSunPrize/awards/pull/551) also presents a complete same-problem formalization, with a different parameter choice, and provides a fixed full mathematical write-up. Its posted claims should be distinguished from its actual independently checked source; no rebuild of that prior submission is asserted here. In any case plby's fully inspected fixed source alone rules out a first-complete-formalization claim.

**Qualification boundary:** the whole proof is largely an attributed upstream adaptation. It should not be submitted as an original complete proof authored by the account, or as a registration of plby's contribution on its behalf. The rule requiring an own original contribution is a substantive question for the maintainers even when the local Chebyshev lemma is useful. The appropriate request is review of the precisely delimited local changes; neither successful integration nor a local auxiliary theorem automatically establishes complete original formalization credit or prize entitlement. List the submitter's own repository under Proof submission, and disclose plby as the exact upstream source under Attribution/Dependencies, rather than presenting someone else's repository as an own submission object.
