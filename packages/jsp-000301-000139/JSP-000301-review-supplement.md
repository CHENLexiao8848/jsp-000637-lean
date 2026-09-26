# JSP-000301: complete mathematical argument, statement correspondence and contribution review

Prepared 26 September 2026 for the consolidated review in [awards PR #740](https://github.com/TheJustinSunPrize/awards/pull/740), retaining the additional implementation originally submitted in [#752](https://github.com/TheJustinSunPrize/awards/pull/752). This document concerns unchanged proof versions A and B below. It supplies the complete mathematical argument; it does not report a new Lean execution or an award determination.

## 1. The exact question and its historical source

The [JSP-000301 catalog entry](https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000301) asks whether two consecutive positive powerful integers must include a square. Its 13 September 2026 scope correction expressly selects this yes/no question and excludes the separate counting question in [Erdős Problem 365](https://www.erdosproblems.com/365). **The corresponding Erdős number is 365, not 301.** A positive integer is powerful when the square of every prime divisor also divides it. A counterexample to the universal assertion fully answers this selected question.

The current catalog and the [Erdős source record](https://www.erdosproblems.com/latex/365) attribute the counterexample to **Solomon W. Golomb, “Powerful Numbers,” American Mathematical Monthly 77(8) (1970), 848–852**: [publisher bibliographic record](https://www.tandfonline.com/doi/abs/10.1080/00029890.1970.11992598), [catalog DOI](https://doi.org/10.2307/2317020). The publisher record verifies the title, author, original volume/year and page range; the later online-publication date is not the discovery date. The complete Golomb article was not obtained for this review, so no unverified internal page or theorem number is supplied for this pair. The attribution above follows the explicitly identified problem record. The complete arithmetic proof actually offered for review is Section 2 of this supplement.

David T. Walker, “Consecutive Integer Pairs of Powerful Numbers and Related Diophantine Equations,” Fibonacci Quarterly 14 (1976), 111–116, is a related later source: [publisher PDF](https://www.fq.math.ca/Scanned/14-2/walker.pdf), [DOI](https://doi.org/10.1080/00150517.1976.12430562). Its introduction on p.111 distinguishes pairs containing a square from pairs containing neither square; Section 3 and Theorem 3.5 on pp.115–116 provide a stronger infinite-family treatment. That full paper was inspected. The present Lean files do **not** formalize that infinitude argument. B's historical source comment links Walker alone; this supplement corrects the attribution of the particular known counterexample without altering B's frozen source. Walker is not credited here with first discovering the displayed pair.

No original proposal year is established by this review. No “1976 to 2026” prize-duration claim is made.

## 2. Complete mathematical solution to the selected question

Define

$$
P(n)\iff n>0\ \text{and}\ \forall p\in\mathbb N,
\quad (p\text{ prime and }p\mid n)\Longrightarrow p^2\mid n.
$$

We prove that there is an $n$ for which $P(n)$ and $P(n+1)$ hold but neither integer is a square. Set $n=12167$. Direct multiplication gives

$$
12167=23^3,\qquad 12168=2^3\cdot3^2\cdot13^2=12167+1.
$$

Both numbers are positive. Let $p$ be **any** prime dividing 12167. A prime dividing a power divides its base, so $p\mid23$. Since 23 is prime, $p=23$. Thus $p^2=23^2\mid23^3=12167$, proving $P(12167)$.

Next let $p$ be **any** prime dividing 12168. A prime dividing a product divides a factor; applying this fact twice gives $p\mid2^3$, $p\mid3^2$ or $p\mid13^2$. Prime divisibility of powers and the primality of 2, 3 and 13 then imply $p\in\{2,3,13\}$. Each possible square divides 12168:

$$
12168=4\cdot3042=9\cdot1352=169\cdot72.
$$

This proves $P(12168)$. The finite list of possible primes is a **conclusion** of the unrestricted prime-divisibility argument, not a restriction in the definition of powerful.

For the square condition, compute

$$
110^2=12100<12167<12168<12321=111^2.
$$

For either $m\in\{12167,12168\}$, suppose $m=k^2$ for some natural number $k$. If $k\le110$, monotonicity of squaring on nonnegative integers gives $m\le12100$, a contradiction. Otherwise $k\ge111$, giving $m\ge12321$, again a contradiction. These two alternatives exhaust **all** possible natural square roots; no bounded search assumption is used. An integer square root would have a natural absolute value with the same square, so the usual positive-integer interpretation agrees with this natural-number formulation.

Consequently

$$
\exists n\in\mathbb N,\quad P(n)\land P(n+1)\land
\neg\operatorname{IsSquare}(n)\land\neg\operatorname{IsSquare}(n+1).
$$

If the proposed universal statement held, applying it to $n=12167$ and the two powerful facts would assert that at least one of these two numbers is a square, contradicting the two nonsquare facts. Therefore

$$
\neg\bigl(\forall n\in\mathbb N,\quad
P(n)\Longrightarrow P(n+1)\Longrightarrow
\operatorname{IsSquare}(n)\lor\operatorname{IsSquare}(n+1)\bigr).
$$

This is the complete negative answer. It proves neither that the witness is smallest nor that infinitely many such pairs exist. It supplies no bound on their counting function, classification of Pell-type equations or result for the separate JSP-000302 question.

## 3. Fixed formal statements and full correspondence

**A, primary #740 implementation:** repository `CHENLexiao8848/jsp-000637-lean`, branch `codex/jsp-000301-000139-000838`, commit `48fd10d0009408a1a3cdd1640bc22884facf00c3`, package `packages/jsp-000301-000139`.

**B, retained #752 implementation:** repository `CHENLexiao8848/awards`, branch `codex/four-lean-proofs-20260917`, commit `ea6e7fc0a5893edd13335acc4e1ebd00cd261782`, package `proofs/chen-lexiao-four-20260917/proof`.

| Item | A | B |
| --- | --- | --- |
| Definition | [`Jsp.Powerful301.Powerful`, line 15](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Jsp/Powerful301.lean#L15) | [`JSP000301.Powerful`, line 17](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Problems/JSP000301.lean#L17) |
| Full existential counterexample | [`Jsp.Powerful301.counterexample`, line 61](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Jsp/Powerful301.lean#L61) | [`JSP000301.exists_consecutive_powerful_not_square`, line 59](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Problems/JSP000301.lean#L59) |
| Full negative answer | [`Jsp.Powerful301.answer`, line 66](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/Jsp/Powerful301.lean#L66) | [`JSP000301.conjecture_false`, line 63](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/Problems/JSP000301.lean#L63) |

Both definitions are literally `0 < n ∧ ∀ p : ℕ, p.Prime → p ∣ n → p ^ 2 ∣ n`. Both use Mathlib's standard `Nat.Prime`, divisibility and `IsSquare`. Positivity is part of each powerful hypothesis, so $n=0$ is excluded by the original positive-integer assumption rather than by an extra theorem assumption. There are no missing small cases: one explicit witness refutes a universal implication, and no assertion about every powerful pair is needed.

The submitted statements are proposed for semantic review against the catalog scope; this review has not found a separate organizer-approved Lean challenge file. Each statement and its proof are in the same fixed file. The complete existential conjunction verifies positivity via `Powerful`, both prime-square divisibility properties, consecutiveness via `n+1`, and both nonsquare conclusions. The negative answer contains no unproved mathematical hypothesis.

A and B use the same mathematical route. Their different imports, namespaces, divisor-lemma interfaces and local proof syntax make them distinct source files, not distinct mathematical solutions or automatically independent formalizations. Both specialize the elementary argument to the known pair; neither expands the catalog's mathematical scope.

## 4. Earlier complete formalizations and contribution boundaries

Three earlier public source versions were inspected, not merely their PR titles:

| Earlier record | Fixed source and complete covered result | Consequence for the present contribution |
| --- | --- | --- |
| [#13](https://github.com/TheJustinSunPrize/awards/pull/13), administratively migrated to [#2110](https://github.com/TheJustinSunPrize/awards/pull/2110) | [56647563, `Proof.lean`, commit `6cb739bbb676a44223111e1f6f627241191862a0`](https://github.com/56647563/jsp-000301-lean-proof/blob/6cb739bbb676a44223111e1f6f627241191862a0/Proof.lean#L91), `JSP000301.counterexample` and `original_claim_false`. Uses a finite certificate with a proved bridge covering every possible divisor and every possible square root. | Its finite verification does not make the final theorem a bounded or partial version of the catalog question. Closing the old PR for migration does not erase that proof or priority evidence. |
| [#17](https://github.com/TheJustinSunPrize/awards/pull/17) | [Redchar1992, `JSP301/Proof.lean`, commit `94c99f824c0deb2f0a163ba1b07ad95c7995100d`](https://github.com/Redchar1992/jsp-000301-lean/blob/94c99f824c0deb2f0a163ba1b07ad95c7995100d/JSP301/Proof.lean#L81), full counterexample and negative answer with standard Mathlib definitions. General lemmas prove powerful squares, cubes, products and the interval-between-squares criterion. | A direct arithmetic, standard-definition implementation already existed. The current specialized prime cases are not the first direct proof or a demonstrated improvement on its more general helper lemmas. |
| [#33](https://github.com/TheJustinSunPrize/awards/pull/33) | [3immense, `submissions/jsp-000301-mathlib/Proof.lean`, commit `cde8a5d196a847fe9eb341e605e97ec6182567f2`](https://github.com/3immense/awards/blob/cde8a5d196a847fe9eb341e605e97ec6182567f2/submissions/jsp-000301-mathlib/Proof.lean#L111), full counterexample and negative answer, standard definitions, and an exponent-of-factorization equivalence. | #33 is genuinely another JSP-000301 submission and remains a relevant reference. Its closure/rejection comment concerned direct source delivery and missing compliant external proof pointers; it did not identify a failed mathematical theorem. |

These earlier sources were read for statement and method comparison, not rebuilt in this review. Their public existence is sufficient to rule out an unqualified first-formalization claim here, without declaring any of them accepted for a prize. PR numbering or a local Git timestamp alone is not used to decide priority. Their closure status does not imply the prior mathematical or formal work ceased to exist.

The submitter, **CHEN LEXIAO (@CHENLexiao8848)**, selected and directed the projects and publishes the local Lean implementations and verification materials with substantial **OpenAI Codex assistance**. [A's fixed authorship and overlap record](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000301-000139/README.md#attribution-and-overlap) and [B's contribution record](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/CONTRIBUTIONS.md) identify those roles. A's original comparison omitted #17; it is explicitly added above. B's existing disclosure already acknowledges #13 and #17.

The proposed credit is limited to the actual additional local implementation, packaging and reproducibility work represented by A and B. The submitter does not claim Golomb's mathematical discovery, Walker's infinite-family theorem, authorship of the earlier proofs, manual authorship of every proof term or an independent human verification. Neither package imports those prior proof files; absence of an import does not independently establish clean-room provenance. Repository ownership, different proof syntax and successful compilation alone do not establish originality or entitlement to a prize.

The present record has a substantive contribution/priority limitation: complete prior implementations, including the direct arithmetic route, already exist. No new mathematical result, stronger quantitative statement or previously absent semantic case has been demonstrated. Better documentation can make the submission reviewable but cannot remove that limitation.

## 5. Verification scope, reproduction and trust

Both selected projects pin Lean 4.34.0 and Mathlib `5ed2965256430c3649e86755f9576b54eca72435`. Their manifests and original verification scripts remain fixed. Use a fresh checkout at the selected SHA, fetch the pinned Mathlib cache, and run the corresponding verifier. Do not run `lake update`.

For A, in `packages/jsp-000301-000139`, run `lake exe cache get`, `lake clean`, then `python3 scripts/verify.py`. The extra `lake clean` is an explicit clean-project reproduction instruction, not a claim that the recorded CI executed that command. The exact-version [Linux job 105219764607](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764607) used a fresh checkout without restored project build artifacts; it built `Jsp.Powerful301`, checked both A terminal declarations and replayed that mathematical module. Shared package totals also include JSP-000139 and must not be treated as extra JSP-000301 targets or modules.

For B, in `proofs/chen-lexiao-four-20260917/proof`, run `lake exe cache get` then `python3 verify.py`. The [fixed historical report](https://github.com/CHENLexiao8848/awards/blob/ea6e7fc0a5893edd13335acc4e1ebd00cd261782/proofs/chen-lexiao-four-20260917/proof/verification/report.json) records an explicit `lake clean pinnacleLean`, build, audit and local-module replay. Its package totals cover four problems. B's three catalog/data GitHub checks are not proof-compilation CI.

The existing logs separately report `[propext, Classical.choice, Quot.sound]` for **A's `answer`, A's `counterexample`, and B's `conjecture_false`**. B's companion `exists_consecutive_powerful_not_square` is compiled and its type printed by `#check`; the fixed audit does not separately print its axioms. It is not represented as a fourth individually audited target. The proof sources contain no `sorry`, `admit` or custom mathematical axiom replacing proof steps.

The [dated verification review](JSP-000301-verification-review-20260926.md) preserves the exact version bindings and evidence. It distinguishes A's actual Linux CI from committed historical local copies, and B's historical clean-build evidence from later reinspection. This September 26 review did not run Lean again. Build and module replay use the same Lean kernel and cached pinned dependencies; they are neither a separate proof-assistant implementation nor independent human mathematical review. Mathematical correspondence, authorship, priority and qualification remain subject to the maintainers' substantive review.

## 6. Consolidation without loss of history

#740 is the main entry for this one catalog contribution. The obsolete claim in its previous body that there was no same-contribution PR by this account is withdrawn: #752 overlaps and is preserved here as version B. Both immutable proof versions, original PR history and public branches are retained. A later documentation commit is not a replacement proof SHA, a new completion date or another award opportunity. Closure of the secondary entry after complete public readback is administrative consolidation, not withdrawal of B's evidence or an assertion of acceptance.
