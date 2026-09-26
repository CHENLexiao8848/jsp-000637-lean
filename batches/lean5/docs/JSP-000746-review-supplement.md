# JSP-000746 / Erdős 895: statement, finite certificate and contribution review

Prepared 2026-09-26 for [PR #738](https://github.com/TheJustinSunPrize/awards/pull/738). The proof under review remains `060945b90e39e6ce77731e31879d83075309bee5` in `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean5-completed-20260917`, package `batches/lean5`. This later documentation does not replace the selected proof or claim prize acceptance.

## Mathematical provenance and source limits

The [Erdős Problems entry 895](https://www.erdosproblems.com/895) attributes the explicit finite bound `n≥18` to **Ben Barber**, reporting a SAT computation by personal communication. No separately published paper or theorem/page reference for that computation was established in this review. The complete finite proof object used here is the pinned CNF/LRAT certificate and Lean graph correspondence described below; its mathematical and formal statement review is requested, not represented as already approved.

The qualitative result predates that computation: T. Łuczak, V. Rödl and T. Schoen, *Independent finite sums in graphs defined on the natural numbers*, **Discrete Mathematics 181** (1998), **289–294**, [DOI](https://doi.org/10.1016/S0012-365X(97)00064-2). The directly inspected [Gunderson–Leader–Prömel–Rödl author manuscript](https://www.cs.umd.edu/~gasarch/TOPICS/vdw/ArithSeqInGraphs.pdf), **Question 1.2 / Theorem 1.3, p.2**, credits this result and states the stronger finite-generator theorem. The manuscript became *Independent arithmetic progressions in clique-free graphs on the natural numbers*, **JCTA 93** (2001), **1–17**, [DOI](https://doi.org/10.1006/jcta.1999.3007). No internal pinpoint in the unretrieved 1998 article is asserted.

**Finite versus infinite sums.** GLPR pp.1–2 distinguish the affirmative fixed finite-generator assertion from an infinite sequence's entire finite-sums assertion, refuted by Deuber–Gunderson–Hindman–Strauss (JCTA **78**, 1997, **171–198**). A generic “Hindman extension remains open” claim is therefore not adopted. Both strengthenings are outside this selected Lean proof.

## Exact statements and quantifiers

All target locations refer to [fixed `LeanTwenty/Problem000746.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean).

| Declaration | Location | Statement |
| --- | --- | --- |
| `IndependentSum` | [line 18](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L18) | There are `a,b,c : Fin n` with `a.val<b.val`, `c.val=a.val+b.val+1`, and all three unordered pairs nonadjacent. |
| `finite_certificate` | [line 25](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L25) | The fixed CNF is propositionally unsatisfiable, reconstructed from its LRAT trace. |
| `eighteen` | [line 29](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L29) | Every triangle-free graph on `Fin 18` has `IndependentSum`. |
| `finite_bound` | [line 196](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L196) | The same conclusion holds for every natural `n≥18` and every triangle-free graph on `Fin n`. |
| `erdos_895` | [line 205](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L205) | There is one uniform `N` such that every `n≥N` and every triangle-free `Fin n` graph has the triple; the proof takes `N=18`. |
| `on_integers` | [line 211](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Problem000746.lean#L211) | For every triangle-free `SimpleGraph ℤ`, there are `0<a<b`, `a+b≤18`, and pairwise nonadjacency of `a,b,a+b`. |

`Fin n` vertex `i` represents the positive label `i.val+1`. Thus `c.val=a.val+b.val+1` is exactly the ordinary integer equation `(c.val+1)=(a.val+1)+(b.val+1)`. It is not modular addition on `Fin n`, and it does not permit a spurious zero-labelled witness. Since `a.val<b.val` and `c.val=a.val+b.val+1>b.val`, all three vertices are distinct. In the integer theorem, `0<a<b` directly gives `a<b<a+b`. `CliqueFree 3` is the ordinary triangle-free condition on a simple undirected graph.

The finite theorem quantifies over **every** labelled graph of every order `n≥18`, not over selected SAT examples. The threshold does not depend on the graph. The integer graph may be infinite; no finiteness, density, coloring or bounded-degree hypothesis is added. Restricting it to labels `1,…,18` is part of the proved argument.

The source proves that 18 is **sufficient**. It supplies no counterexample at 17, no least-threshold equivalence and no edge-minimality theorem. Those are not needed to answer the original existence question and are not claimed as checked results here. The result does not quantify over arbitrary finite-sums generator counts or an infinite Hindman sequence.

## Complete finite proof specification

Let the 153 Boolean variables be the unordered edges of the labelled vertex set `{1,…,18}`, in lexicographic order. Variable `x_{ab}` means that `{a,b}` is an edge. A triangle-free graph with no distinct independent sum triple would satisfy the following two families of clauses:

1. For every `1≤a<b<c≤18`, the clause `¬x_ab ∨ ¬x_ac ∨ ¬x_bc`. There are `binom(18,3)=816` clauses.
2. For every `1≤a<b` with `a+b≤18`, the clause `x_ab ∨ x_a,a+b ∨ x_b,a+b`. There are `sum_{a=1}^8 (18−2a)=72` clauses.

No additional graph symmetry, coloring, order, degree or density restrictions are added. Every forbidden counterexample supplies a satisfying assignment of these 888 clauses, and conversely a satisfying assignment defines such a simple graph. In the actual file the labels are shifted down by one, matching `c.val=a.val+b.val+1` in `IndependentSum`.

The complete [CNF](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Certificates/JSP000746.cnf) and [LRAT certificate](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/Certificates/JSP000746.lrat) are fixed inputs, with SHA256 values:

```text
CNF   260b7c50fac4fcc4525f7253eb37a8750bf744cff5bb41e92a314cdea1ccab45
LRAT  55172fa9925cb62926d91a078590e9480b294b5c7727e27e8b68858ca20ac20b
```

The trace has 2,123 clause additions, 307 deletion commands and 33,108 positive clause hints, ending in empty clause 3011. All additions are reverse-unit-propagation steps; no RAT step is used. To justify one such addition `C`, assume every literal of `C` is false and follow the listed existing clauses, each propagating its sole undecided literal or producing a contradiction. This proves that the current clauses imply `C`. Deleting a clause does not invalidate the implication from the original CNF to the remaining clauses. Induction through the finite trace proves that the original CNF implies the empty clause and is unsatisfiable. The immutable trace provides all individual inference data; it is not replaced by an unverified SAT solver's `UNSAT` status.

Mathlib's `lrat_proof` command translates this input into ordinary propositional proof terms checked by Lean's kernel. `finite_certificate` is instantiated with the 153 graph adjacency propositions in the same lexicographic order. In `eighteen`, triangle-freeness disproves every triangle-clause violation, while the assumed absence of `IndependentSum` disproves every sum-clause violation. The certificate leaves no possible counterexample, proving the 18-vertex theorem. The closure audit of both the certificate and final graph theorems reports only the three standard axioms.

For `n≥18`, the embedding `Fin 18 ↪ Fin n` preserves the first 18 labels. Pulling back a triangle-free graph along this embedding remains triangle-free, and transporting the witnesses preserves their natural-number sum identity. This proves `finite_bound`, and hence `erdos_895` with `N=18`.

For an integer graph, use `Fin 18 ↪ ℤ`, `i ↦ (i.val : ℤ)+1`. Pull back the graph, apply `eighteen`, and transport the three adjacencies. The identity for `c` proves that its integer image is the sum of the other two, while `c.val<18` gives `a+b≤18`. The positive shift and `a.val<b.val` prove positivity and distinctness. This is the entire proof of the literal integer-graph statement.

On 2026-09-26, a separate small Python audit checked the complete clause multiset, all 153 bindings to the Lean adjacency arguments, and every positive-hint RUP step to the final empty clause. This is auxiliary certificate verification, not a new Lean execution or an independent Lean kernel. The exact-SHA Lean CI remains the formal execution evidence.

## Comparison with existing proofs and source provenance

The [pinned plby proof](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895.lean), commit `8822f7ddef30fadbd92e1c6ab4ed897af356af5e`, already has the same explicit finite result. Its [`finite_eighteen`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895.lean#L225), [`explicit_bound`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895.lean#L243) and [`erdos_895`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895.lean#L268) cover `n=18` and every `n≥18`, with the same distinct positive-label convention. The header credits Ben Barber for the mathematical result and Codex/GPT-5.6 Sol for formalization. Those attributions remain theirs.

The plby proof also uses Mathlib `lrat_proof` on the standard 153-variable, 888-clause encoding. Direct comparison with its immutable files shows:

| Input | Comparison |
| --- | --- |
| [`Certificate.cnf`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895/Certificate.cnf) | Exactly byte-identical to the submitted CNF: 12,986 bytes, SHA256 `260b7c50fac4fcc4525f7253eb37a8750bf744cff5bb41e92a314cdea1ccab45`. |
| [`Certificate.lrat`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos895/Certificate.lrat) | Different trace bytes: prior 218,950 bytes, SHA256 `2f8729bd57e5ee6d24292e2b51fc72afad884bedf5234b808615568fe9bac582`; submitted 218,957 bytes with the hash above. |
| Graph interface | Both convert the certificate to triangle-free graph statements and restrict larger graphs to the first 18 labels. The selected local source also declares the literal `SimpleGraph ℤ` interface. |

The encoding is canonical for this variable ordering; byte identity alone does not establish copying, and different trace bytes do not establish independent generation. The selected source and attribution file describe the SAT/LRAT files as locally generated. **This review did not find the original generation script, solver version, command line or solver-run transcript at the selected proof tree.** The older wording is therefore treated as a submitter provenance statement, not an independently verified historical fact. Rechecking the fixed certificate establishes its correctness, not who generated it or when.

Other overlapping public records make the contribution boundary narrower:

- [Issue #18](https://github.com/TheJustinSunPrize/awards/issues/18) already registers a certificate-based 18-vertex result and a 17-vertex counterexample. Its attached complete package was not rebuilt during this review.
- [PR #165](https://github.com/TheJustinSunPrize/awards/pull/165) links [xpzwzwz's `Main.lean` at `927bc61467102b7bcc34e07419dc585e3c370ee3`](https://github.com/xpzwzwz/jsp-000746-lean/blob/927bc61467102b7bcc34e07419dc585e3c370ee3/JSP000746/Main.lean#L777), whose `erdos_895` gives the positive distinct sum triple bounded by 18 on natural-number graphs. The terminal source was inspected; its imported proof modules were not rebuilt here.
- [PR #402](https://github.com/TheJustinSunPrize/awards/pull/402) links [an explicit integer endpoint](https://github.com/ketianzhang1-lang/jsp-000301-lean/blob/4dfb40abe0cd1e538bbfccb1cc50f4829fb7383a/projects/jsp-000746-sharp/JSP000746.lean#L14) and [a least-threshold equivalence](https://github.com/ketianzhang1-lang/jsp-000301-lean/blob/4dfb40abe0cd1e538bbfccb1cc50f4829fb7383a/projects/jsp-000746-sharp/JSP000746Sharp.lean#L86) at `4dfb40abe0cd1e538bbfccb1cc50f4829fb7383a`. The latter reuses the credited plby upper proof and adds a checked 17-vertex witness. These terminal files were inspected without a fresh build. Thus a literal integer interface and sharpness are not unique to this submission.
- [PR #1164](https://github.com/TheJustinSunPrize/awards/pull/1164) describes another complete certificate implementation with an integer endpoint and 17-vertex witness. [PR #2546](https://github.com/TheJustinSunPrize/awards/pull/2546) describes a qualitative implementation via ultrafilters and compactness. Their descriptions are disclosed as related submissions; their full source and verification dependencies were not audited here. The historical correction above was checked in a primary author manuscript rather than accepted solely from a competing PR.

This comparison identifies public overlap, not award acceptance or a full priority chronology. PR numbers, Git timestamps and catalog `Lean: No` labels do not establish who first completed a valid formalization.

The concrete artifact offered for review is the selected local graph declaration, its embedded certificate trace, the finite restriction and the explicit integer transport, together with fixed inputs and verification evidence. These local declarations import standard Mathlib rather than `Erdos895`; that does not establish clean-room development or novelty of the method. No new mathematical result, new SAT encoding, first kernel check, first formalization, sharper bound, shortest certificate, generation independence or measured performance improvement is claimed.

CHEN LEXIAO (@CHENLexiao8848) organized and published the batch with substantial OpenAI Codex assistance, as disclosed in the fixed [README](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/README.md), [ATTRIBUTION](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/ATTRIBUTION.md) and [per-problem statement](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/docs/JSP-000746.md). Repository ownership is evidence of where the artifact is published, not sole authorship of its mathematical or formal ideas. The mathematical sources and earlier formal authors retain their credits. No independent human verifier is claimed. The unresolved certificate-generation history limits the stronger originality claims that can honestly be made from this package alone.

## Verification and reproduction

The existing [GitHub run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772), dedicated [JSP-000746 job 105218613134](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613134), succeeded at the exact selected proof SHA on 2026-09-17. Its artifact records an actual build of `LeanTwenty.Problem000746` completing 3,112 jobs, a separate three-target axiom audit, and entry-module replay. This review reuses that execution after inspecting its fixed inputs and artifact; no new Lean run was performed on 2026-09-26. Dependency caches were used, and the replay imports dependencies using Lean's own kernel. It is neither a second kernel implementation nor a fresh replay of all Mathlib.

The [companion evidence review](JSP-000746-verification-review-20260926.md) preserves exact artifact identity, target outputs, source/lock checks and the auxiliary SAT audit. The audited target closures are:

```text
JSP000746.erdos_895        [propext, Classical.choice, Quot.sound]
JSP000746.on_integers     [propext, Classical.choice, Quot.sound]
JSP000746.finite_certificate [propext, Classical.choice, Quot.sound]
```

Use the selected [toolchain](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/lean-toolchain), [lakefile](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/lakefile.toml), [lockfile](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/lake-manifest.json), [source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/source-lock.json), [external-source lock](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/upstream-lock.json) and [verifier](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/scripts/verify.py):

```sh
git clone --branch codex/lean5-completed-20260917 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 060945b90e39e6ce77731e31879d83075309bee5
cd batches/lean5
python3 scripts/verify.py --problem JSP-000746 --fetch-cache
```

The verifier prepares the frozen batch's locked external sources, builds the selected target, regenerates its axiom audit and replays `LeanTwenty.Problem000746`. This theorem's source directly imports only Mathlib; the batch contains additional unrelated results whose attribution and verification must not be credited to this target. Normal proof verification uses the published certificate and does not require regenerating a SAT search. Lean is `leanprover/lean4:v4.34.0`; Mathlib is `5ed2965256430c3649e86755f9576b54eca72435`.

The finite and integer statements cover the original three-point question. Mathematical correspondence, the value and authorship of this later implementation, originality under the submission rules, and any award remain for maintainer review. Reproducibility evidence does not remove the overlap or prove independent certificate provenance.
