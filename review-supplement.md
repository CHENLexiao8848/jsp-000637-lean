# JSP-000759: exact counterexample, scope, attribution and verification

Prepared 2026-09-26 for [awards PR #739](https://github.com/TheJustinSunPrize/awards/pull/739).

This report concerns unchanged proof version **A = `060945b90e39e6ce77731e31879d83075309bee5`**, in [CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean), branch `codex/lean5-completed-20260917`. Its project root is `batches/lean5`; its only local proof module for this result is `LeanTwenty/JSP000759.lean`. A later documentation/evidence commit containing this report is not a new proof version.

## 1. Question, mathematical sources and review status

The [current Erdős Problem 915 statement](https://www.erdosproblems.com/915) asks whether every graph with `1+n(m−1)` vertices and `1+n choose(m,2)` edges has two vertices joined by `m` disjoint paths. The word “disjoint” has two different interpretations. The JSP-000759 catalog title explicitly concerns **internally vertex-disjoint** paths. The selected theorem refutes the universal assertion under that interpretation. It makes no assertion about edge-disjoint paths.

Historical references retained in the catalog are:

- B. Bollobás and P. Erdős, *Extremal problems in graph theory*, Mat. Lapok 13 (1962), 143–152: origin of the question.
- J. L. Leonard, *On a conjecture of Bollobás and Erdős*, Periodica Mathematica Hungarica 3 (1973), 281–284: historical negative result.
- B. A. Sørensen and C. Thomassen, *On k-rails in graphs*, Journal of Combinatorial Theory, Series B 17 (1974), 143–159, [DOI / publisher record](https://doi.org/10.1016/0095-8956(74)90082-3): subsequent extremal results and the standard k-rail interpretation. The publisher's abstract defines the paths as sharing precisely their endvertices.

These bibliography entries identify historical mathematical credit. This review did not recover a full primary scan establishing an exact theorem/page origin for the particular 17-vertex adjacency list, and does not invent such a citation. The immediate source of that **exact graph and separator data** is the pinned [plby formalization](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos915.lean), `counterEdges` at line 217, `counterexample` at line 234, and separators at lines 258–286. Its header credits Sørensen/Thomassen for the informal mathematics and Codex/GPT-5.6 Sol for formalization. Sections 2–3 below give a complete elementary mathematical argument for this precise witness, so the submission does not rely on an unlocated paper theorem as a proof premise.

No completed prize mathematical review, independent human referee approval, mathematical novelty or new-witness discovery is claimed. The original question/statement correspondence remains for maintainer review.

## 2. Exact formal statement and definitions

In [the fixed submitted file](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/batches/lean5/LeanTwenty/JSP000759.lean), `Interior p x` means that `x` is in the path's support and differs from both endpoints (line 26). `DisjointFamily` (line 30) requires both an **injective** family of paths and disjoint interiors for every pair of distinct indices. `HasPaths G m` (line 34) quantifies over two distinct endpoints and a family indexed by `Fin m` of Mathlib `SimpleGraph.Path` values.

Mathlib paths are simple paths, not arbitrary walks. Injectivity is essential because the path consisting of the direct endpoint edge has empty interior; repeating that same path cannot manufacture arbitrarily many paths. Shared endpoints are allowed, but shared internal vertices are not. This is the internally vertex-disjoint interpretation, not edge-disjointness alone.

`ProposedClaim` (line 38) universally quantifies over natural `m≥2`, `n≥1`, every finite vertex type and every simple graph satisfying **exact** vertex and edge counts:

```lean
Fintype.card V = 1 + n * (m - 1)
G.edgeSet.ncard = 1 + n * Nat.choose m 2
```

| Target | Source line | Meaning |
| --- | --- | --- |
| `JSP000759.edge_count` | 165 | The explicit witness has exactly 41 undirected edges. |
| `JSP000759.no_five_paths` | 203 | No pair of distinct vertices of this witness has five internally vertex-disjoint paths. |
| `JSP000759.solution` | 227 | `¬ ProposedClaim`: the universal internally vertex-disjoint assertion is false. |

The two advertised terminal audit targets are `solution` and `no_five_paths`. `edge_count` is included as a proved dependency in the terminal proof; it is not a separately reported target in the preserved two-target audit.

For `m=5,n=4`, `1+4(5−1)=17` and `1+4 choose(5,2)=41`. Thus a single proved counterexample negates the universal assertion. It is not an affirmative theorem checked only up to a cutoff. Conversely, it is not a classification of each fixed `m`, an exact general threshold function, or a resolution of both meanings of “disjoint”. In particular, no positive claims for `m=2,3,4`, negative family for every `m≥5`, or Mader edge-disjoint theorem are submitted here.

## 3. Complete mathematical proof for the exact witness

### Proposition 1: the finite graph and its counts

Take vertices `0,…,16` and the following 41 unordered edges, writing each edge with its smaller endpoint first:

```text
(0,1) (0,2) (0,3) (0,4) (0,5) (0,6) (0,7) (0,8) (0,13) (0,14)
(1,2) (1,3) (1,4) (1,9) (1,10) (1,11) (1,12)
(2,9) (2,10) (2,13) (2,14) (2,15) (2,16)
(3,5) (3,8) (4,6) (4,7) (5,6) (5,7) (6,8) (7,8)
(9,11) (9,12) (10,11) (10,12) (11,12)
(13,15) (13,16) (14,15) (14,16) (15,16)
```

There are no loops or repeated unordered edges. Counting the entries gives 41 edges on 17 vertices. The degrees are `10,8,8` at vertices `0,1,2`, respectively, and `4` at each of the other 14 vertices. In particular, the degree sum is `10+8+8+14·4=82=2·41`. This graph data is exactly the graph data in the pinned plby source; it is not a new construction.

### Lemma 2: degree and separator bounds

In an injective family of internally disjoint simple paths from `u` to `v`, the first neighbors of `u` are distinct. If two paths first visit a vertex other than `v`, that vertex would be internal to both. If the first neighbor is `v`, simplicity forces the path to be the unique direct edge; injectivity permits it at most once. Therefore the family's size is at most the degree of `u`, and reversing the paths gives the same bound at `v`.

Suppose a set `S`, disjoint from the endpoints, separates `u` from `v` after the edge `uv` is deleted. Any simple `u`–`v` path either is the direct edge or visits an element of `S` internally. Assign each non-direct path one such element. Disjoint interiors force these chosen elements to differ; there is at most one direct path. Thus the family has at most `|S|+1` members. This argument is implemented in `hitting_bound` for arbitrary family size and finite `S`, together with `side_constant` and `separator_hits`.

### Proposition 3: no pair supports five paths

The degree bound shows that both endpoints of any five-path family would have to be in `{0,1,2}`. For the three possible unordered pairs, use the following certificates. In the last column, after deleting `S`, the displayed side is separated from its complement except for the direct endpoint edge.

| Endpoints | Separator `S` | One side after deleting `S` |
| --- | --- | --- |
| `0,1` | `{2,3,4}` | `{1,9,10,11,12}` |
| `1,2` | `{0,9,10}` | `{2,13,14,15,16}` |
| `2,0` | `{1,13,14}` | `{0,3,4,5,6,7,8}` |

Every separator has three vertices and omits both endpoints. Inspecting the edge list shows that the only crossing edge left in each row is the direct endpoint edge. The separator bound therefore permits at most `3+1=4` internally disjoint paths for each pair. Reversing the paths covers both orders of the endpoints. All other pairs were excluded by the degree bound, proving `no_five_paths`.

Finally, the counts in Proposition 1 satisfy the conjectured threshold exactly at `m=5,n=4`. Applying the purported universal claim to this graph would give five paths, contradicting Proposition 3. This proves `solution : ¬ ProposedClaim` with no additional hypothesis.

The finite graph facts are checked with `decide +kernel` in the selected Lean proof, while the path and separator implications are symbolic proofs. The supplementary 2026-09-26 Python inspection independently re-counted the same edges/degrees and cut crossings as a documentation check; it is not the proof premise and is not reported as a new Lean or independent-human verification.

## 4. Prior full proof and attributable implementation differences

The exact prior comparator is [plby/lean-proofs, `Erdos915.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos915.lean), version `8822f7ddef30fadbd92e1c6ab4ed897af356af5e`.

| Item | Prior plby implementation | Selected implementation A |
| --- | --- | --- |
| Exact graph | `counterEdges` / `counterexample`, lines 217/234 | Same 41 edges in `edges` / `witness`, lines 145/154 |
| Path convention | Injective path family, pairwise disjoint interiors, lines 41–60 | Equivalent explicit pair-of-indices formulation, lines 26–42 |
| Degree reduction | `card_le_degree_of_disjoint_paths`, line 62; endpoint reversal | `degree_bound`, line 50; `family_reverse`, line 74 |
| Three-separator proof | `not_five_disjoint_paths_of_three_separator`, line 176, using an `Option` slot for the direct edge | `hitting_bound`, line 88, gives general `m≤S.card+1`, also using `Option S` slots |
| Cuts | Three separate separator/side/crossing declarations | Same cuts indexed by `Fin 3` and one `cut_certificate` |
| Complete counterexample result | `counterexample_edge_count`, line 246; `counterexample_has_no_five_paths`, line 336; `not_erdos_915`, line 362 | `edge_count`, `no_five_paths`, `solution` |

The prior proof already has the **same mathematical graph, degree argument, separator strategy and direct-edge counting mechanism**, and already negates the same universal assertion. Therefore no new witness, proof route, completed theorem scope or first formalization is claimed. The selected implementation's general hitting lemma, unified finite-cut encoding, syntax/interfaces and packaging are the specific local work submitted for review. A nonidentical implementation does not, by itself, establish original authorship or a qualifying prize contribution.

The submitted file imports only Mathlib modules, not plby's `Erdos915.lean`; the batch's external source preparation also serves other problems and is not a proof dependency of this target. The source header's phrase “independently authored” records the project's local-development claim. It must not be read as independent discovery of the mathematics, an independent historical authorship audit, or proof that the route was developed without consulting the prior source. The known graph and strategy are expressly attributed.

A further open submission, [#874](https://github.com/TheJustinSunPrize/awards/pull/874), selects CollinYuanjieRen/awards version `a5fff14aba307a833c4103e7c559d4dc2f569840`. Its fixed [`Main.lean`](https://github.com/CollinYuanjieRen/awards/blob/a5fff14aba307a833c4103e7c559d4dc2f569840/submissions/jsp-000759-cyr/MerLeanExperiment/Main.lean) bundles broader results for each `m` and the edge-disjoint reading. Its [README](https://github.com/CollinYuanjieRen/awards/blob/a5fff14aba307a833c4103e7c559d4dc2f569840/submissions/jsp-000759-cyr/README.md) credits the 17-vertex graph and separator strategy to plby and #739. This report inspected its stated source scope but did not rebuild or independently validate that submission. It must be disclosed as broader competing work, not described as a maintainer-accepted result or as evidence that A proves those extra conclusions.

## 5. Roles and unresolved award questions

Historical mathematical credit remains with the cited authors. The exact witness and strategy came from the pinned plby record; its stated formal-author labels are Codex and GPT-5.6 Sol. The submitted local code was developed with OpenAI Codex assistance under the direction of `CHENLexiao8848`, whose documented roles include publishing and submitting the implementation. Repository ownership is not a claim of mathematical discovery or sole manual authorship. No independent human verifier is claimed.

The requested review concerns the attributable local implementation, interfaces and verification package. Whether that contribution is sufficiently original and meets applicable prize requirements is unresolved. Neither successful builds, another submitter's attribution of #739, nor chronological PR numbering establishes eligibility or priority by itself. Do not replace these limitations with a claim that the PR is already approved for a prize.

## 6. Rechecked exact-SHA CI evidence

Unlike a summary-only local record, the preserved [GitHub Actions run 35226287772](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772) is for the exact selected commit A. It completed successfully on 2026-09-17. The specific [JSP-000759 job 105218613312](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/job/105218613312) used an Ubuntu 24.04.5 hosted runner, a fresh checkout, Python 3.12.14 and Lean 4.34.0, with pinned Mathlib dependency caches. The fixed [workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/060945b90e39e6ce77731e31879d83075309bee5/.github/workflows/lean5.yml) has no restoration of locally compiled project proof artifacts.

The actual [artifact 10499013470](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226287772/artifacts/10499013470), `lean5-JSP-000759`, was retrieved and inspected on 2026-09-26. The ZIP is **6,647 bytes**, SHA-256 **`d1ae21204b4c5a56b0e6487d9084afbc49c3f826a07464ef5050fe3639efac72`**, matching both GitHub artifact metadata and the original upload log. It contains `verification.json`, `build.log`, `axioms.log`, `Audit.lean`, `kernel.log`, `toolchain.log` and `cache.log`.

| Actual 2026-09-17 command | Recorded result |
| --- | --- |
| `lake env lean --version` | Exit 0; Lean 4.34.0, Linux x86-64; exact Mathlib revision `5ed2965256430c3649e86755f9576b54eca72435` is recorded. |
| `lake exe cache get` | Exit 0; fixed dependency cache retrieval. |
| `lake build LeanTwenty.JSP000759` | Exit 0; log explicitly says **Built LeanTwenty.JSP000759 (8.4s)** and successful completion, 3,107 jobs. |
| `lake env lean verification/JSP-000759/Audit.lean` | Exit 0; both advertised terminal targets report only the standard three axioms. |
| `lake env leanchecker --verbose LeanTwenty.JSP000759` | Exit 0; replay of the entry module, using its imported dependencies. |

The build retained four nonfatal linter warnings: three unused-variable warnings and one unused `norm_num` tactic warning. They are not hidden or represented as a warning-free build. The replay is Lean's bundled checker using imported dependencies, not a second independent checker or a `--fresh` replay of all Mathlib.

The actual terminal output is:

```text
'JSP000759.solution' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000759.no_five_paths' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The main proof's byte hash is `8d71bc141d32ce4da7b5637a8cbcdced605d0dbf1d19902367d1b663adbb3247`, matching the published source lock, existing local evidence, fetched fixed source and archived CI record. On 2026-09-26 six relevant downloaded manifest entries were rehashed: the target source, toolchain, Lake configuration, dependency lock, proof registry and upstream lock; all six matched. The CI record's complete 27-entry batch source list equals the fixed published source lock. The remaining unrelated batch files were not freshly downloaded/rehashed for this review.

These are newly inspected **historical executions**, not a new local build on 2026-09-26 and not an independent human review. The old PR paragraph saying the CI “remains queued” is obsolete and should be removed. No source change is required to reuse these exact-version results.

## 7. Reproduction

For a targeted reproduction with a fresh local module build:

```sh
git clone --branch codex/lean5-completed-20260917 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 060945b90e39e6ce77731e31879d83075309bee5
cd batches/lean5
lake exe cache get
lake clean
lake build LeanTwenty.JSP000759
lake env lean LeanTwenty/JSP000759.lean
lake env leanchecker --verbose LeanTwenty.JSP000759
```

The source file itself ends with `#print axioms solution` and `#print axioms no_five_paths`. Its direct Lean command therefore prints both terminal results. Keep the exact dependency lock.

To reproduce the original automated verifier, use Python **3.12 or later** and run `python3.12 scripts/verify.py --problem JSP-000759 --fetch-cache` from `batches/lean5`. The script has Python-3.12 f-string syntax; “Python 3” without a version is insufficient. The original batch verifier fetches all hash-pinned external batch sources and checks all batch source hashes even when this one target is selected; those external sources are not imported by `JSP000759.lean`. Its entry-module checker replay imports dependencies. The commands are reproduction instructions, not claims of a new execution in this review.

## 8. Permanent verification evidence

The [preserved CI artifact and evidence review](ci-evidence-review-20260926.md) contains the original build, audit and replay logs, the original machine-readable result, exact artifact and file hashes, and the reviewed input identity. It records the actual 2026-09-17 execution at proof A; preservation on 2026-09-26 is not a new Lean run or independent human review.
