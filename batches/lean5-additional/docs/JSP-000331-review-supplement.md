# JSP-000331 / PR #782: eventual Graham bound, exact scope and local contribution

Prepared 26 September 2026 by AI-assisted source review, not independent human mathematical verification. This supplement concerns repository `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-additional-20260917`, fixed proof commit `a4d83d426d9ee2d92511857831e27b70216aedfe`, package `batches/lean5-additional`. Execution and source-restoration evidence are reported separately; no Lean build was run for this mathematical review.

## Mathematical source and completeness of the selected scope

The [JSP-000331 catalog](https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000331) explicitly asks about **every sufficiently large finite set**, rather than the stronger assertion for every nonempty cardinality in [Erdős Problem 402](https://www.erdosproblems.com/402). The intended integer domain is the positive integers of Graham's gcd problem, represented in Lean by naturals with `0 ∉ A`; a claim for arbitrary negative integers would not have this meaning.

The sufficiently-large result was established earlier by Mario Szegedy and Alexandru Zaharescu; these credits should not be erased in favor of a later full-range theorem. A public historical source is Zaharescu's [*On a conjecture of Graham*, February 1986 preprint](https://imar.ro/~increst/1986/5_1986.pdf), **§3, Proposition 2**, beginning on PDF page 5 (including its cover), later published in Journal of Number Theory 27 (1987), 33–40. The scanned preprint explicitly asserts the sufficiently-large result. The catalog also cites Szegedy, Combinatorica 6 (1986), 67–71, [DOI](https://doi.org/10.1007/bf02579410).

A complete stronger mathematical publication is **R. Balasubramanian and K. Soundararajan, *On a conjecture of R. L. Graham*, Acta Arithmetica 75 (1996), 1–38**: [public full paper](https://matwbn.icm.edu.pl/ksiazki/aa/aa75/aa7511.pdf). **Theorem 1.1 is on p.2**; its supporting argument occupies §§2–6, with **§6, “Completion of the proof,” beginning on p.34**. The original PDF was obtained and the theorem and proof structure inspected. The theorem proves the gcd quotient bound for normalized sets of size at least five, including a stronger equality characterization. Its introduction credits the earlier sufficiently-large results.

Only the eventual bound is submitted in Lean. The fixed upstream formal source itself identifies a remaining gap between its checked finite cases and a non-effective threshold for the stronger all-cardinality project. Extracting the complete eventual theorem does not close that gap or formalize Theorem 1.1 in its full strength.

## Complete mathematical deduction for the catalog statement

For a finite positive-integer set $A$ of cardinality $n\ge5$, let $d=\gcd(A)>0$ and let $B=\{a/d:a\in A\}$. Division by the common positive divisor preserves distinctness and cardinality and gives $\gcd(B)=1$. The published Theorem 1.1 supplies $x,y\in B$ with

$$\frac{x}{\gcd(x,y)}\ge n.$$

Writing $a=dx$ and $b=dy$, the identity $\gcd(dx,dy)=d\gcd(x,y)$ gives

$$n\gcd(a,b)\le a,\qquad\text{equivalently}\qquad
\gcd(a,b)\le\frac a{|A|}.$$

These are distinct witnesses: if $a=b$, positivity and $\gcd(a,a)=a$ give $na\le a$, hence $n\le1$, contradicting $n\ge5$. Thus the published result in particular answers the catalog's eventual question. This is a complete deduction from the precisely cited stronger proved theorem; the publication contains its full proof. **It does not claim the submitted Lean theorem supplies the explicit threshold 5** or formalizes every case or equality statement in the paper.

The extracted formal proof takes a non-effective asymptotic route instead. It normalizes the set internally, proves the bound for all cardinalities above one uniform threshold, then removes normalization. The upstream route combines prime-collision counts, a first-moment upper bound and proved short-interval prime estimates. For sufficiently large $N$, it uses $G$ comparable to $N/\log^4 N$; the two prime-count lower bounds have sizes $G/(4\log N)$ and $G/(2\log N)$. The proved first-moment bounds make the collision upper bound smaller than their product, contradicting a putative bad set. These estimates and their eventual validity are proved in the retained dependency closure, not left as hypotheses of the final statement.

This explains the non-effective uniform threshold in the selected theorem. The final quantified result ranges over **every** finite positive set above that threshold. It does not assume gcd normalization, squarefreeness, a prime cardinality, a particular prime certificate or a prime-number-theorem conclusion as an unproved premise. Those are internal constructions or proved imported results.

## Formal statement and the local distinctness deduction

The [fixed local entry](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/LeanTwenty/JSP000331.lean) proves `JSP000331.solution`:

```lean
∃ N₀ : ℕ, 2 ≤ N₀ ∧ ∀ A : Finset ℕ, N₀ ≤ A.card → 0 ∉ A →
  ∃ a ∈ A, ∃ b ∈ A, a ≠ b ∧
    (Nat.gcd a b : ℚ) ≤ (a : ℚ) / A.card
```

The imported `Erdos402.erdos_402` already proves the same eventual rational gcd bound, with an explicit nonempty assumption and without a separate distinctness conjunct. The interface chooses `max 2 N` as its threshold. Cardinality at least two supplies nonemptiness; if the imported witnesses were equal, clearing the positive cardinality denominator would give `A.card * a ≤ a` with `a>0`, contradicting `A.card≥2`. This simple corollary accounts for the entire local mathematical addition in the wrapper. It does not produce a new gcd bound, an effective threshold or a missing all-cardinality case.

The ratio is a rational division, not truncated natural division. Witnesses are actual elements of the finite set; the threshold is independent of that set. Sets of size zero or one lie outside the selected sufficiently-large domain by construction. The negative-integer domain, a smallest threshold and the equality classification are not asserted.

## Exact upstream reuse and the PNT replacement

The [fixed original `Erdos402.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos402.lean#L7980) already includes the complete eventual theorem. Its header names Balasubramanian and Soundararajan for the mathematical source, Formal Conjectures authors for the statement, and Codex/GPT-5.6 Sol for formalization. The [local extraction script](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/extract-erdos402-eventual.mjs) selects 138 source declarations reachable from that theorem, preserves their source text apart from separately recorded compatibility patches, and keeps the author/source notices. The omitted finite certificate branch is not needed for the eventual endpoint.

The local proof of this eventual theorem is therefore an attributed extraction and port of an already complete theorem. A smaller selected closure is useful for reproducibility, but is not a new proof of all of Graham's conjecture. A lexical extraction recipe alone would not establish completeness; successful checking of the actual reconstructed import closure and the final theorem's axioms is the relevant separate verification evidence.

The import replacement points to [plby's `Erdos49/PNT/MediumPNT.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos49/PNT/MediumPNT.lean), with its recorded dependency closure. It is a **reused alternative proved PNT implementation**, not a new PNT proof authored by the submitter. The [PNT compatibility patch](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/patches/pnt-v434.patch) changes elaboration details in two files; the [eventual-proof patch](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/a4d83d426d9ee2d92511857831e27b70216aedfe/batches/lean5-additional/scripts/patches/erdos402-eventual-v434.patch) changes a division-lemma API use. These should be described as compatibility edits with retained credit, rather than new analytic estimates.

Related [PR #170](https://github.com/TheJustinSunPrize/awards/pull/170) uses the same upstream eventual result and also already includes the distinct-witness corollary: its fixed [Correspondence.lean](https://github.com/LenChild/awards/blob/77099a994ca59e9cf916ea2b26fd0cbb9f65bc81/submissions/jsp-000331-LenChild/JSP331/Correspondence.lean#L7) proves `distinct_of_gcd_bound`, and [Proof.lean](https://github.com/LenChild/awards/blob/77099a994ca59e9cf916ea2b26fd0cbb9f65bc81/submissions/jsp-000331-LenChild/JSP331/Proof.lean#L22) raises the threshold to `max N 2`. These fixed source diffs and the current PR description were inspected. The present local interface additionally incorporates `2 ≤ N₀` into its existential statement and derives nonemptiness from the cardinality bound, but does not add a mathematical conclusion missing from that earlier bridge. PR #170 is closed without merger; that state is not a mathematical refutation and does not erase its published proof. No firstness inference follows from a catalog label saying `Lean proof: No`.

## Attribution and substantive limitation

CHENLexiao8848 publishes the AI-assisted extraction, dependency integration, compatibility changes, distinct-witness interface and reproducibility material. These are the actual local changes offered for contribution review. They do not transfer credit for the 138 reused declarations, the underlying PNT development or the known mathematical result. No independent human review, original complete-formalization priority or award entitlement is asserted.

The selected statement is complete for the catalog's eventual question; a requirement to prove every cardinality would be a different scope and remains unfulfilled by this selected formal source. The main present qualification limitation is that the complete proof is largely upstream reuse and the additional mathematical interface is an elementary corollary. Better documentation can expose these facts accurately, but cannot establish a new original full proof or automatic prize qualification. Maintain this limitation explicitly when completing the own-contribution declaration.
