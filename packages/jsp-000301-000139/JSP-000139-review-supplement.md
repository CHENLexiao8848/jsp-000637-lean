# JSP-000139: complete argument, statement correspondence and prior comparison

Prepared 2026-09-26 for [awards PR #741](https://github.com/TheJustinSunPrize/awards/pull/741). Selected proof **A = `48fd10d0009408a1a3cdd1640bc22884facf00c3`**, [CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean), branch `codex/jsp-000301-000139-000838`, package `packages/jsp-000301-000139`. Later documentation/evidence commits do not replace A as the verified proof version.

## 1. Mathematical sources and the question answered

This is JSP-000139 / [Erdős Problem 133](https://www.erdosproblems.com/133), concerning the minimum possible maximum degree of a triangle-free graph of given order and diameter two. It is not the minimum degree of a particular graph. Write

`f(n) = min { maxDegree(G) : G is a triangle-free n-vertex graph of diameter 2 }`.

The original cited source is P. Erdős, *Some old and new problems in various branches of combinatorics*, Discrete Mathematics **165/166** (1997), **227–231**, [DOI](https://doi.org/10.1016/S0012-365X(96)00173-2). A precise readable restatement is **Problem 1.3, p.2**, of Noga Alon's [*Triangle-free graphs of diameter 2*](https://web.math.princeton.edu/~nalon/PDFS/remark1901.pdf); its p.4 correction credits the earlier constant-factor solution. The question asks for the growth order of `f` and whether `f(n)/sqrt(n)` tends to infinity. The answer is `f(n)=Θ(sqrt(n))`, so the proposed divergence is false.

The historical order-of-growth result is credited to **D. Hanson and K. Seyffarth**, *k-saturated graphs of prescribed maximum degree*, Congressus Numerantium **42** (1984), **169–182**. This review did not retrieve that original article or verify its internal theorem/page numbering. The bibliographic details and historical credit are supported by the author-uploaded Füredi–Seress paper below, **§6, p.23 and reference [7], p.24**; the published author's institutional bibliography also records volume 42, pp.169–182. Alon's note has inconsistent reference numbering and different bibliographic pagination, so it is not used to assert a pinpoint theorem in the 1984 article.

Directly inspected complete mathematical sources include:

- **Z. Füredi and Á. Seress**, *Maximal triangle-free graphs with restrictions on the degrees*, Journal of Graph Theory **18**(1) (1994), **11–24**, [DOI](https://doi.org/10.1002/jgt.3190180103), [author-uploaded scan](https://users.renyi.hu/~furedi/PUBS3/furedi_118_seress_Maximal-triangle%E2%80%90free-graphs-with-restrictions-on-the-degrees.pdf). **Theorem 6.1 and its proof, p.23**, give `f(n) ≤ (2/√3)(√n+n^(7/24))` for sufficiently large `n`; the construction refers to **Example 2.2, pp.13–14**. This stronger quantitative bound is not claimed as formalized by A.
- **Ishay Haviv and Dan Levy**, *Symmetric complete sum-free sets in cyclic groups*, Israel Journal of Mathematics **227**(2) (2018), **931–956**, [DOI](https://doi.org/10.1007/s11856-018-1754-5), [fixed arXiv v2 manuscript](https://arxiv.org/pdf/1703.04118v2). **Theorem 1.5, manuscript p.3**, gives size `O(√n)` for every sufficiently large cyclic group; **§1.2, p.4**, explains the Cayley graph application; **Theorem 4.6 and its proof, pp.17–18**, imply Theorem 1.5. These page numbers refer to the inspected arXiv manuscript, not the journal pagination.

A uses a finite-field symmetric-parabola construction and bounded vertex duplication, not the specific cyclic-group or projective-plane constructions in those papers. The source comparison did not identify an independently verified first literature occurrence of this exact parabola variant. The complete argument matching A is therefore supplied below rather than attributed to an unverified paper theorem. No new mathematical discovery, optimal leading constant, independent human referee approval or first formalization is claimed. This is material for maintainer mathematical review.

## 2. Exact formal targets and correspondence

[`Jsp/Graph139Upper.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Jsp/Graph139Upper.lean) contains:

```lean
theorem upper_bound (n : ℕ) (hn : 121 ≤ n) :
    ∃ G : SimpleGraph (Fin n), G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧
      G.maxDegree^2 ≤ 857435524*n

theorem answer : ∀ n : ℕ, 121 ≤ n →
    (∀ G : SimpleGraph (Fin n), G.CliqueFree 3 → G.ediam ≤ 2 →
      n ≤ G.maxDegree^2+1) ∧
    (∃ G : SimpleGraph (Fin n), G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧
      G.maxDegree^2 ≤ 857435524*n)
```

These are `Jsp.Graph139Upper.upper_bound` at **line 69** and `Jsp.Graph139Upper.answer` at **line 88**. Every sufficiently large integer `n` is included, not only finite-field orders. There is no additional field-existence, graph-existence, sum-free-set, asymptotic or convergence premise. The lower bound in `Graph139.lean` is stronger in scope than necessary: it does not require triangle-freeness.

| Formal object | Mathematical meaning |
| --- | --- |
| `SimpleGraph (Fin n)` | Undirected loopless simple graph with exactly `n` labelled vertices. Any finite graph with `n` vertices can be relabelled this way. |
| `G.CliqueFree 3` | No three mutually adjacent vertices; precisely triangle-free. |
| `G.ediam ≤ 2` | Mathlib extended diameter, so disconnected graphs with infinite distances cannot pass. |
| `DiameterAtMostTwo G` | Every pair is equal, adjacent, or has a common neighbor. The equivalence with `ediam ≤ 2` is proved at `Graph139.lean:34`. |
| `G.maxDegree` | Largest ordinary vertex degree, not a minimum-degree quantity. |

For the submitted range `n≥121`, triangle-freeness and diameter at most two imply diameter **exactly** two: a graph of diameter at most one is complete, and a complete graph on at least three vertices is not triangle-free. Thus this convention does not weaken the original diameter-two question. Small exceptional orders below 121 do not affect the growth-order or limit question, and no exact small-order classification is claimed.

A does **not** define an extremal function or contain a theorem literally named `IsTheta` or `not_tendsto` for it. Its formal deliverable is the displayed pair of uniform graph bounds. Their complete mathematical implication is as follows: the upper theorem makes the finite class defining `f(n)` nonempty; minimize the integer maximum degree within that finite class. Apply the universal lower bound to a minimizing graph and the upper bound to the constructed graph to obtain, for every `n≥121`,

`√(n−1) ≤ f(n) ≤ 29282√n`, since `29282²=857435524`.

For this range, `√(n−1)≥(1/2)√n`. These fixed positive constants give `f(n)=Θ(√n)`, and `f(n)/√n≤29282` eventually, excluding divergence to infinity. This is a mathematical corollary of A's checked inequalities, not a claim that A separately kernel-checks the real-analysis formulation. A maintainer may request that additional formal interface, but there is no missing graph construction or missing family of orders behind the result.

## 3. Complete argument matching the five graph modules

### 3.1 Universal Moore lower bound

Fix a vertex `v` in a graph of diameter at most two and let `Δ` be its maximum degree. Every vertex is `v`, a neighbor of `v`, or a neighbor other than `v` of one of those neighbors. Taking a union and allowing overcounting gives

`n ≤ 1+deg(v)+deg(v)(Δ−1) ≤ 1+Δ²`.

The proof treats `Δ=0` separately so natural subtraction is valid, and treats the empty vertex type without selecting a vertex. In the submitted range the graph is nonempty. `Graph139.card_le_one_add_degree_mul`, `moore_bound`, and `moore_bound_of_ediam_le_two` establish these statements and connect the covering argument to Mathlib extended diameter.

### 3.2 The finite fields and two needed algebraic facts

For every natural `k`, let `K=GF(11^(2k+1))` and `q=|K|=11^(2k+1)`. The field is instantiated using Mathlib `GaloisField`; its cardinality and characteristic are checked. Then `q≡2 (mod 3)` and `q≡3 (mod 4)`, and 2 and 3 are nonzero in `K`.

First, the only cube root of unity in `K` is 1. For a nonzero `t` with `t³=1`, the field identity `t^q=t` and `q≡2 (mod 3)` give `t²=t`, hence `t=1`. Consequently

`x²+xy+y²=0 ⇒ x=y=0`.

If `y≠0`, division by `y²` would make `t=x/y` satisfy `t²+t+1=0`; multiplying by `t−1` gives `t³=1`, forcing `t=1` and then `3=0`, a contradiction. The case `y=0` follows from `x²=0`.

Second, every `b` is a square or its negative is a square. The zero case is immediate; for nonzero `b`, Euler's finite-field square criterion and the odd number `(q−1)/2` show that negation interchanges the square/nonsquare alternatives. `Graph139Fields.lean` proves precisely these facts, including the cardinality congruences. No finite-field or quadratic-form existence oracle is assumed.

### 3.3 A symmetric complete sum-free parabola

In the additive group `K×K`, put

`S = {(x,x²),(x,−x²) : x∈K, x≠0}`.

It has at most `2q` elements, omits zero, and is invariant under negation. To prove sum-freeness, suppose two points with nonzero first coordinates `a,c` sum to a point of `S`; also `a+c≠0`. Comparing the signs of the three second coordinates yields one of

`2ac=0`, `2a(a+c)=0`, `2c(a+c)=0`, or `2(a²+ac+c²)=0`.

The first three contradict the nonzero factors. The fourth contradicts the quadratic-form fact just proved. These cover all eight sign choices, as implemented in `parabola_sum_free`.

To prove completeness, take `z=(a,b)`. If `a≠0`, let `x=(b/a+a)/2` and `y=a−x`, so `x+y=a` and `x²−y²=b`. If `x=0` or `y=0`, then `z` itself lies in `S`; otherwise

`z=(x,x²)+(y,−y²) ∈ S+S`.

If `a=0,b=0`, use `(1,1)+(-1,-1)`. If `a=0,b≠0`, either `b/2=t²` or `−b/2=t²` with `t≠0`; then use `(t,t²)+(-t,t²)` or `(t,−t²)+(-t,−t²)` respectively. Hence `K×K = S ∪ (S+S)`, while sum-freeness makes the union disjoint. `Graph139Parabola.lean` proves all these cases and packages them as `SymmetricCompleteSumFree`.

### 3.4 Cayley graph at each field order

Make vertices `K×K` adjacent exactly when their difference lies in `S`. Symmetry gives an undirected graph and exclusion of zero gives no loops. A triangle would provide two elements of `S` whose sum lies in `S`; thus the graph is triangle-free. Completeness puts every pair at distance at most two. Every neighborhood is a translate of `S`, so the graph is regular of degree `|S|≤2q` and has `q²` vertices. These are the `addCayley_*` theorems in `Graph139.lean`; `Graph139Upper.family` relabels the vertices by `Fin (q²)`.

### 3.5 Extend to every sufficiently large order

The base orders are

`m_k=q_k²=121·14641^k`.

For every `n≥121`, the proved logarithmic choice supplies `k` with `m_k≤n<14641m_k`. Project `Fin n` onto `Fin m_k` by reduction modulo `m_k`. It is surjective and has fibers of size at most `14641`. Replace each base vertex by its fiber, with every pair between two fibers adjacent exactly when the base vertices are adjacent.

A triangle in this duplicated graph would project to a triangle in the base. For two vertices with distinct images, lift a base edge or two-step path. For two vertices in the same fiber, use a base neighbor and a lift of it; such a neighbor exists because the base graph is nontrivial and has diameter at most two. This handles the potentially missed same-fiber case. Each degree increases by at most the maximum fiber size: the code injects a neighbor into its base neighbor paired with its quotient index. Thus

`Δ ≤ 14641·2q = 29282q`, and `Δ²≤857435524q²≤857435524n`.

`Graph139Blowup.lean` proves the generic bounded-fiber construction, and `Graph139Upper.lean` proves the choice of base order and final estimate. The looseness of the constant comes partly from the wide ratio between successive field orders. No optimal constant, exact extremal value, regularity of the final duplicated graph, or minimal construction is claimed.

## 4. Complete prior proof and attributable differences

The complete comparison source is [plby/lean-proofs `Erdos133.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos133.lean), fixed commit **`8822f7ddef30fadbd92e1c6ab4ed897af356af5e`**. Its header credits the historical Hanson–Seyffarth result and Codex/GPT-5.6 Sol for formalization. Those contributions are not claimed by this account.

| Aspect | Pinned plby source | Selected A |
| --- | --- | --- |
| Lower bound | Moore counting proof, line 64 | Moore counting proof with Mathlib extended-diameter bridge, `Graph139.lean:94/112` |
| Base construction | Pairs of elements of `Bool×Fin k`, using a fixed-point-free involution, `baseGraph`, line 185 | Symmetric parabola over `GF(11^(2k+1))` and its additive Cayley graph |
| Every-order extension | At most one extra copy of each selected base vertex; degree factor two | General modulo projection with fiber cap `c`, specialized to `c=14641` |
| Upper bound | `f(n)≤4√n` for every `n≥64`, line 511 | Graph existence with `Δ≤29282√n` for every `n≥121` |
| Extremal/asymptotic interface | Defines `erdos133Function` at line 57, proves `erdos133_isTheta` at line 557 and ratio nondivergence at line 579 | Checks uniform graph inequalities; the mathematical extremal/limit consequence is explained above, without a separate literal real-analysis target |
| Complete result | `erdos_133`, line 597 | `Graph139Upper.answer`, line 88, in the explicit-bounds formulation |

The prior proof is complete and has a substantially stronger explicit upper bound and smaller threshold. This submission does not close an unfilled upper-bound gap, improve that bound, or supply a first complete formalization. [PR #111](https://github.com/TheJustinSunPrize/awards/pull/111) is a different partial Moore-bound observation; as retrieved on 2026-09-26 it is closed, not merged, and its own body says it does not solve the full catalog question. Comparing only with #111 would omit the strongest relevant prior work.

The concrete work offered for assessment is the five-module field/parabola/Cayley/bounded-fiber implementation, with its standard graph interfaces and reproducibility evidence. Those modules import Mathlib and one another, not the pinned plby source. The original README says they were developed locally with OpenAI Codex assistance. This is a development-history assertion, not an independent provenance audit. Shared strategy elements—Moore counting, Cayley graphs and vertex duplication—remain established mathematics. Repository control and timestamps do not alone establish priority or originality.

The shared package has **six mathematical modules across two problems**, of which **five** are graph modules for JSP-000139. `Jsp.Powerful301` belongs to another PR and is not an additional contribution or axiom target for this submission. Neither its result nor any work on JSP-000078 is included here.

## 5. Exact-version verification and reproduction

The dedicated [run 35226624341](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341), [301/139 job 105219764607](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764607), passed at A. The dedicated artifact **10499027839**, `jsp-000301-000139-verification`, is **3,659 bytes**, ZIP SHA-256 **`9902778d3a87418b462bed65c4a841f56051ee3fa100d2bb840773aa79da41f0`**, matching GitHub metadata. It was retrieved and independently checked on 2026-09-26; no new Lean execution is claimed.

All 26 retrieved package Git blobs and all 12 CI input hashes agree with A. The actual job's nine dependency revisions match the fixed manifest. Lean is **4.34.0** and Mathlib is **`5ed2965256430c3649e86755f9576b54eca72435`**. The fresh Ubuntu checkout restored no project cache and contained no tracked `.olean` or package `.lake`. The build newly compiled all five graph modules, the other problem's module and the root; it completed **3,123 jobs**. This supports fresh project compilation with pinned dependency caches, not a Mathlib source rebuild or an explicit `lake clean` command.

The actual audit includes:

```text
'Jsp.Graph139Upper.upper_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'Jsp.Graph139Upper.answer' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Both exact signatures are printed. The script runs `leanchecker --verbose` separately for each of the five graph modules; each has exit 0, a matching log hash and a timed `PASS` in the actual job log. Across the shared package, all nine verifier commands succeed: toolchain, build, audit and six mathematical-module replays. The separate JSP-000838 job in the same run is not evidence for this proof. The old committed local `verification.json` ending at 13:20:59Z is not confused with the current Linux execution at 13:24:55Z–13:26:06Z.

```sh
git clone --branch codex/jsp-000301-000139-000838 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 48fd10d0009408a1a3cdd1640bc22884facf00c3
cd packages/jsp-000301-000139
lake exe cache get
python3 scripts/verify.py
```

For a new explicitly cleaned project reproduction one may run `lake clean` before the verifier. That is an optional future command, not a claim about the preserved historical run. All module replays use the same bundled Lean kernel and imported pinned dependencies; this is not an independent checker or `--fresh` replay of all Mathlib. Checks are submitter-controlled and establish neither independent human review nor contribution eligibility.

## 6. Review and attribution status

The historical result remains credited to Hanson–Seyffarth, with the stronger and alternative constructions expressly disclosed. `CHENLexiao8848` directed and published the described Codex-assisted local formalization. No sole manual authorship, independent human verification, first-formalization priority or award entitlement is asserted. The additional field construction and interfaces can be assessed as an implementation contribution, but the existence of another complete proof with better constants is a material limit on any originality or priority claim. No documentation update can decide those award questions for the maintainers.

## 7. Permanent source-bound CI evidence

The [preserved CI records and evidence review](JSP-000139-ci-evidence-review-20260926.md) contains the original Linux verification record, all twelve input hashes, raw build and target-axiom logs, the five graph-module replay logs and timed job excerpts. It distinguishes the other shared problem and the earlier committed local record. This document and the preserved evidence describe proof A; they do not add Lean targets for the extremal function or change the selected proof version.
