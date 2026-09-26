# JSP-000733 / Erdős 882 — mathematical and contribution review supplement

Prepared on 2026-09-26 for [PR #731](https://github.com/TheJustinSunPrize/awards/pull/731), incorporating the same contribution previously registered in [#798](https://github.com/TheJustinSunPrize/awards/pull/798). This is one formalization record. This supplement changes no proof source and makes no new mathematical discovery, first-formalization or award-priority claim.

The selected proof is **`060945b90e39e6ce77731e31879d83075309bee5`** in `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-completed-20260917`, package `batches/lean5`. The later documentation version containing this file is not the proof version checked by the CI. The exact target is [`JSP000733.solution`, line 217](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/JSP000733.lean#L217).

## 1. Mathematical source and proposed scope

The [original problem, Erdős 882](https://www.erdosproblems.com/882), asks how large a subset of `{1,…,n}` can be when its distinct nonempty subset-sum values never divide one another. The historical question is listed in P. Erdős, *Some of my new and almost new problems and results in combinatorial number theory*, in *Number theory (Eger, 1996)* (1998), pp.169–180, [DOI](https://doi.org/10.1515/9783110809794.169). No internal page/theorem pinpoint within that original article is claimed here; the numbered problem page supplies the question location.

The relevant published solution is P. Erdős, V. Lev, G. Rauzy, C. Sándor and A. Sárközy, *Greedy algorithm, arithmetic progressions, subset sums and divisibility*, **Discrete Mathematics 200 (1999), 119–135**, [DOI](https://doi.org/10.1016/S0012-365X(98)00385-9), [publisher record](https://www.sciencedirect.com/science/article/pii/S0012365X98003859). The public [author manuscript](https://math.haifa.ac.il/seva/Papers/greeda.dvi), linked from [Lev's publication list](https://math.haifa.ac.il/seva/pub_list.html), states **Theorem 5 on manuscript p.8** and proves it in **§8, manuscript pp.12–13**. These are author-manuscript page numbers, not journal page numbers. The inspected source is the 21-page DVI author manuscript; no separate PDF rendering is represented as having been inspected.

That theorem gives a stronger upper estimate, with a half-log-log term, as well as the construction lower bound. The present Lean terminal establishes the complete **leading asymptotic**

$$
f(n)/\log_2 n\longrightarrow 1,
$$

where `f(n)` is the actual maximum in the finite extremal problem. It does not prove an exact pointwise formula, the half-log-log refinement, or a bounded additive error. Sections 2–3 below give a complete mathematical proof of the selected terminal and its source correspondence. Mathematical review and approval of this proposed statement as the prize's required scope remain pending; the proof is not described as completing every stronger refinement of the problem. If a different or sharper approved target is required, documentation cannot substitute for its missing formal proof.

## 2. Complete mathematical proof of the selected statement

Call a finite set `A⊆{1,…,n}` admissible if for all nonempty subsets `S,T⊆A`, divisibility `sum(S) | sum(T)` forces equality of the two sums. This does **not** assume that different subsets have different sums. Let `f(n)` be the largest possible cardinality of an admissible set. This maximum exists: the collection is finite and contains the empty set, including when `n=0`.

### 2.1 Construction lower bound

For `m≥1`, put `B=2^m` and

$$A_m=\{B-2^i:0\leq i<m\}.$$

It consists of `m` distinct positive integers at most `B−1`. Write `p(u)` for the number of ones in the binary expansion of `u`. A nonempty subset of the index set corresponds to a unique integer `u∈[1,B−1]`, and its sum of elements of `A_m` is

$$x(u)=Bp(u)-u.$$

Suppose `x(u)=q x(v)` for positive integer `q` and `u,v∈[1,B−1]`. These sums are positive. If `q=1`, reduction modulo `B` and the ranges of `u,v` give `u=v`, hence equal sums. If `q≥2`, the equation gives an integer `t` such that

$$u=qv+Bt,\qquad p(u)=q p(v)+t.$$

For every `w∈[0,B−1]`, the elementary binary identity is

$$p(w)=w-\sum_{j=1}^{m}\left\lfloor w/2^j\right\rfloor.$$

Using `u=qv+Bt` in this identity is legitimate even if `t` is negative, because `B/2^j` is an integer. The two displayed relations and `sum_{j=1}^m B/2^j=B−1` imply

$$\sum_{j=1}^{m}\left\lfloor qv/2^j\right\rfloor
=q\sum_{j=1}^{m}\left\lfloor v/2^j\right\rfloor.$$

Every term on the left is at least the corresponding term on the right. But choose `j` with `v<2^j≤2v`; since `1≤v<B`, such a `j` lies in `{1,…,m}`. At this index the right term is zero while the left is at least one, because `q≥2`. This contradicts the equality. Thus no unequal nonempty subset-sum values of `A_m` divide one another. For `m=0` the construction is empty and admissible directly.

For any `n>0`, choose `m=⌊log₂ n⌋`. Then `2^m≤n`, so this construction gives

$$f(n)\geq\lfloor\log_2 n\rfloor.$$

This construction and its binary divisibility argument are credited to Erdős–Lev–Rauzy–Sándor–Sárközy, not to the current submitter. In the selected Lean proof, the central nondivisibility lemma is imported from the attributed ToshiDad core. The chosen `m` gives the lower bound needed for this terminal; it is not a claim of a sharper new construction.

### 2.2 Deriving injectivity and the counting bound

Suppose an admissible set has two different subsets `S,T` with equal sums. Remove their intersection and write `U=S\T`, `V=T\S`. Positivity of every element shows both residual sets are nonempty: if one were empty its zero sum would force the other to be empty as well, contradicting `S≠T`. They are disjoint and have the same positive sum `s`.

The nonempty subsets `U` and `U∪V` then have sums `s` and `2s`. The former divides the latter, while they are unequal. This violates admissibility. Therefore all subset sums, including that of the empty subset, are distinct.

If `|A|=k`, these `2^k` sums are integers in `[0,kn]`. Consequently

$$2^k\leq kn+1.$$

Applying this to a maximizing set gives `2^{f(n)}≤n f(n)+1`. This elementary counting estimate is sufficient for the leading asymptotic; it is weaker than the sharper upper estimate in the published Theorem 5.

### 2.3 Limit argument

Write `k=f(n)`. The lower bound makes `k→∞` as `n→∞`. For `n≥2`, `k≥1`, and the counting bound and the floor-log lower bound give

$$2^k\leq kn+1\leq(k+1)n,\qquad n<2^{k+1}.$$

Taking natural logarithms and dividing by `k` yields

$$\log 2-\frac{\log(k+1)}k
\leq\frac{\log n}k
\leq\log 2+\frac{\log 2}k.$$

Both error terms tend to zero, so `log(n)/f(n)→log 2>0`. Taking the reciprocal in this eventually positive expression proves `f(n)/log₂(n)→1`. Initial values `n=0,1` do not affect this limit. No convergence hypothesis or desired conclusion has been assumed.

## 3. Exact Lean statement and correspondence

All rows refer to the [same fixed entry source](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/JSP000733.lean).

| Mathematical object or step | Fixed declaration / line | Scope |
| --- | --- | --- |
| Divisibility condition on subset-sum values | `JSP000733.PrimitiveSums`, 18 | Quantifies over every pair of nonempty subsets; equality of sums, not equality of subsets, is the required consequence. |
| Original interval restriction | `JSP000733.Admissible`, 22 | `A ⊆ Finset.Icc 1 n`; all elements are positive. |
| Actual finite maximum and existence | `maximumSize`, 25; `maximumSize_attained`, 34 | Supremum of cardinalities of the finite family; attainment proved, not assumed. |
| Explicit lower construction | `construction`, 47; `construction_admissible`, 62; `lower_bound`, 85 | Uses the bundled `Erdos882.no_div`; gives `Nat.log 2 n ≤ maximumSize n` for `n>0`. |
| Consequence of primitivity | `subset_sums_injective`, 94 | Injectivity for all subsets derived locally. |
| Counting upper bound | `counting_bound`, 133; `maximum_counting_bound`, 150 | `2 ^ maximumSize n ≤ maximumSize n * n + 1` for every natural `n`. |
| Analytic completion | `maximumSize_tendsto`, 155; `logarithmic_bounds`, 161; `log_div_maximum_tendsto`, 198 | Proves divergence of the maximum and squeezes the logarithmic ratio. |
| Advertised terminal | `JSP000733.solution`, 217 | The unconditional leading limit below; sole separately audited terminal. |

```lean
theorem JSP000733.solution :
  Tendsto (fun n : ℕ => (JSP000733.maximumSize n : ℝ) / Real.logb 2 n)
    atTop (𝓝 1)
```

The source writes the theorem inside namespace `JSP000733`. Both the statement and proof are in that file; there is no unconnected challenge wrapper. The natural-to-real coercions and totalized divisions at small `n` are handled by eventual positivity. The terminal has no additional finiteness, injectivity, convergence or unproved lower/upper-bound assumption.

## 4. Reused code and concrete local additions

The bundled [`Core.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/External/Erdos882/Core.lean) is byte-identical to [`ToshiDad/erdos-882/Erdos882.lean`](https://github.com/ToshiDad/erdos-882/blob/6ea233aed4b3efce92e2754177ef15c4085f8732/Erdos882.lean) at **`6ea233aed4b3efce92e2754177ef15c4085f8732`**: 26,074 bytes, SHA256 `c00a0906cfe3f0dcb7cc8e7cb968e0711cb39c7b04833d48f289759aa6b83fb6`. Its [upstream Apache-2.0 license](https://github.com/ToshiDad/erdos-882/blob/6ea233aed4b3efce92e2754177ef15c4085f8732/LICENSE), [bundled license](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/External/Erdos882/LICENSE) and [notice](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/External/Erdos882/NOTICE.md) are retained. This is an explicitly reused dependency, not code newly authored by CHENLexiao8848.

The selected ToshiDad core proves the construction's nondivisibility lemma; it does not provide the present maximum, counting upper bound or final limit. The local entry supplies those remaining definitions and proofs. Removing the local injectivity/counting/asymptotic argument leaves only a lower construction. Thus there are substantive local proof components relative to this dependency, but that comparison does not establish global novelty or independent provenance.

The source header's word “new” is interpreted only in this dependency-relative sense. The same mathematical result and broad counting/squeeze method already occur in the earlier complete development described below. The fixed source and [attribution record](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/ATTRIBUTION.md), together with the [publication commit](https://github.com/CHENLexiao8848/jsp-000637-lean/commit/060945b90e39e6ce77731e31879d83075309bee5), identify the concrete artifact offered for review. They do not independently certify clean-room development, exclusive human authorship or prize priority.

CHEN LEXIAO / @CHENLexiao8848 organized and published the local completion with substantial OpenAI Codex assistance. ToshiDad's [fixed README](https://github.com/ToshiDad/erdos-882/blob/6ea233aed4b3efce92e2754177ef15c4085f8732/README.md) credits Claude/Claude Code assistance and also recognizes earlier plby work. The upstream authors retain their contributions. A redistribution license permits the stated reuse; it does not confer authorship of that code or determine prize eligibility. No independent human mathematical verifier is identified for this submission.

## 5. Earlier complete and sharper work

[PR #31](https://github.com/TheJustinSunPrize/awards/pull/31) was public before #731. Its fixed initial commit **`83f20bbe58d116a9a290c86821fa4ee1a29dd3eb`** already contains an explicit final leading-asymptotic theorem, together with its proof components. The four relevant source files were inspected for this comparison, not rebuilt here.

| Present local component | Earlier #31 component at that fixed commit |
| --- | --- |
| Finite maximum, attainment and construction interface | [`Erdos882Existing.lean`](https://github.com/zifanersuotang/awards/blob/83f20bbe58d116a9a290c86821fa4ee1a29dd3eb/submissions/jsp-000733/Erdos882Existing.lean), existing plby-attributed lower construction, `maximumSize`, `maximumSize_attained`, `erdos_882`. |
| Primitive sums imply injectivity; counting bound | [`Erdos882Upper.lean`](https://github.com/zifanersuotang/awards/blob/83f20bbe58d116a9a290c86821fa4ee1a29dd3eb/submissions/jsp-000733/Erdos882Upper.lean), `subset_sum_injective_of_primitive`, `pow_card_le_mul_add_one`, `maximumSize_pow_le`. |
| Analytic completion | [`AsymptoticCore.lean`](https://github.com/zifanersuotang/awards/blob/83f20bbe58d116a9a290c86821fa4ee1a29dd3eb/submissions/jsp-000733/AsymptoticCore.lean), `PrimitiveSubsetSums.asymptotic_of_counting_bounds`. |
| Unconditional final result | [`Erdos882Asymptotic.lean`, line 21](https://github.com/zifanersuotang/awards/blob/83f20bbe58d116a9a290c86821fa4ee1a29dd3eb/submissions/jsp-000733/Erdos882Asymptotic.lean#L21), `Erdos882.maximumSize_asymptotic`. |

In particular, the earlier theorem does not merely assume the needed counting bound: its local upper module proves that bound before applying the generic analytic lemma. The different organization, lower-core choice and Lean 4.34 packaging here do not create a first complete proof claim.

As of this review, #31 is closed and unmerged. A [2026-09-21 collaborator review comment](https://github.com/TheJustinSunPrize/awards/pull/31#issuecomment-5755236875) rejects it on identity/attribution and upstream authorization/licensing grounds. That outcome does **not** establish that the mathematical theorem is false or remove its earlier public code from the prior-work record. The review comment is an outcome for that submission; this supplement does not convert all of its requested evidence into a new universal repository policy. The current submission's explicit Apache-licensed core and separated local contribution address the specific provenance distinction, while organizer judgment of original contribution and eligibility remains necessary.

[PR #264](https://github.com/TheJustinSunPrize/awards/pull/264) registers the known half-log-log upper refinement, and [#276](https://github.com/TheJustinSunPrize/awards/pull/276) registers a sharper finite/additive upper-bound development. Their public descriptions were reviewed as related claims; their proof projects and associated newer manuscript were not independently rebuilt or fully referee-checked in this review. Neither sharper conclusion is claimed by the selected `JSP000733.solution`. Their existence is another reason not to advertise this leading limit as a new optimal bound.

## 6. Verification and version boundaries

The companion [preserved CI evidence report](JSP-000733-verification-review-20260926.md) gives the exact environment, source hashes, artifact identity and raw short logs. The existing [run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), [job 105218613081](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613081), actually built the bundled core and entry at the selected proof SHA, completed 8,925 jobs, audited the sole advertised terminal and replayed the entry module. Its terminal output is:

```text
'JSP000733.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The environment is Lean `v4.34.0` and Mathlib `5ed2965256430c3649e86755f9576b54eca72435`, with nine dependency commits pinned by the manifest. From the fixed package, run `python3 scripts/verify.py --problem JSP-000733 --fetch-cache`; on an existing checkout, an optional preceding `lake clean` gives an explicitly cleaned local reproduction. The preserved hosted CI used a fresh project checkout and dependency caches, without an explicit `lake clean` command.

The entry replay uses Lean's bundled kernel and pinned imports; it is not a separate implementation or `--fresh` replay of every imported module. No new Lean compilation was performed on 2026-09-26. The current work verified provenance, hashes, source correspondence and the preserved exact-version run. Success is technical evidence, not independent human review, acceptance or priority adjudication.

## 7. One contribution and preservation of both PR histories

Both #731 and #798 select the same proof A and the same earlier documentation commit **`9f28d066505b97e06fa6aed534069f58b4f5fc9c`**, whose [topic note](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/9f28d066505b97e06fa6aed534069f58b4f5fc9c/batches/lean5/docs/JSP-000733.md) already acknowledges #31. Their added Lean/Attribution catalog rows are identical. #798's distinct history is a fresh catalog-only base after the September 17 catalog simplification, not a newer proof or another contribution. Its body reports catalog validation; that report is not being recast as another independently verified Lean run.

| Public record | Preserved pre-consolidation head | Branch | Catalog base snapshot |
| --- | --- | --- | --- |
| #731, created 2026-09-17 13:24:16 UTC | `78936ef903a1b65b85ac9a473e02ced9467876ff` | `codex/jsp-000733` | `82be4c4913b8fe394d68d1391f4c221fde947211` |
| #798, created 2026-09-17 15:25:07 UTC | `8b2e2a3ed789436b1af6ac4191dec8aa5093c316` | `codex/jsp-000733-resubmit-20260917` | `fc2dff1417559e13620a58eaffd1a6ecb554902f` |

The primary review entry is #731; #798 is a duplicate to be closed only after the consolidated #731 materials are publicly checked. Both branches, commits and linked records are retained. This does not request a second prize or a new priority date. A chronology of public source availability is useful evidence, but PR numbers and Git timestamps alone do not settle authorship or prize priority.

The remaining questions are maintainer approval of the proposed statement, mathematical review, recognition of the actual local contribution in light of the licensed reuse and earlier complete result, and any eligibility/award decision. No change to organizer-controlled eligibility or candidate status is requested.
