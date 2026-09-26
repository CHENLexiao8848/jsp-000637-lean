# JSP-000838: mathematical correspondence, prior comparison and preserved proof history

Prepared 2026-09-26 for [awards PR #707](https://github.com/TheJustinSunPrize/awards/pull/707).

Selected proof **A = `48fd10d0009408a1a3cdd1640bc22884facf00c3`**, repository [CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean), branch `codex/jsp-000301-000139-000838`, project root `packages/jsp-000838/proof`. A documentation/evidence commit containing this report does not replace A as the proof under review.

## 1. Exact mathematical sources

The original orientation problem is in P. Erdős, *Some unsolved problems in graph theory and combinatorial analysis* (1971), **§7, p.99**, within pp.97–109 ([original scan](https://www.renyi.hu/~p_erdos/1971-25.pdf)). The current statement is [Erdős Problem 1006](https://www.erdosproblems.com/1006), not Problem 838: JSP identifiers and Erdős identifiers are different systems.

The complete mathematical negative answer is due to **Jaroslav Nešetřil and Vojtěch Rödl**, *On a probabilistic graph-theoretical method*, Proceedings of the American Mathematical Society **72**(2) (1978), **417–421**, [DOI](https://doi.org/10.1090/S0002-9939-1978-0507350-7). The relevant locations are **Theorem 2, pp.418–419; Corollary 3, p.419; Corollary 4, pp.419–420**. The first gives the ordered-template result, the second its ordered-cycle consequence, and the last the Hasse-subgraph obstruction. These printed page locations were checked in the [full text uploaded by author Jaroslav Nešetřil](https://www.researchgate.net/publication/239285245_On_a_probabilistic_graph-theoretical_method); the AMS scan URL returned an access error in this review. No paper is imported as a formal proof assumption.

The selected source specializes the argument to `s=5` and uses a different finite carrier proof. It does not formalize the paper's general all-girth theorem or claim a new mathematical solution. Sources and the comparison below are submitted for maintainer mathematical review; no completed prize review or independent human referee approval is asserted.

## 2. Definitions and every quantifier of the submitted claim

The exact definitions are in [`Defs.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/Defs.lean) and [`Cycles.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/Cycles.lean).

| Formal definition | Meaning and scope |
| --- | --- |
| `NoShortCycles s G` | Every Mathlib closed walk satisfying `Walk.IsCycle` has length at least `s`. `NoShortCycles 5` excludes all triangles and four-cycles, including non-induced copies. |
| `IsOrientation G D` | For every pair, adjacency holds exactly when one of the two directed arcs holds, and the relation is asymmetric. Hence every graph edge receives exactly one direction and no extra arcs exist. |
| `Acyclic D` | For every vertex `v`, there is no nonempty directed closed walk `Relation.TransGen D v v`. |
| `reverseEdge D u v` | Removes exactly the arc `u→v` and inserts exactly `v→u`, retaining every other arc. |
| `IsRobustAcyclicOrientation G D` | Exact orientation, initial acyclicity, and acyclicity after reversing **each individual arc present in D**. |
| `IsCoverGraph G` | There is a partial order on the same vertex type whose undirected Hasse graph equals `G`. |

`NoShortCycles` is explicitly linked to Mathlib extended girth by `noShortCycles_iff_le_egirth`. The separate `no_C3_copy` and `no_C4_copy` theorems exclude arbitrary subgraph embeddings. The use of `Walk.IsCycle` avoids weakening the question to induced cycles. A forest may satisfy the definition, as it should; the constructed counterexample has ordered five-cycles and is not a forest.

The main theorems in [`Main.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/Main.lean) are:

```lean
theorem jsp_000838_counterexample :
    ∃ (n : ℕ) (G : SimpleGraph (Fin n)), NoShortCycles 5 G ∧
      ∀ D, ¬ IsRobustAcyclicOrientation G D

theorem jsp_000838_conjecture_false :
    ¬ (∀ (n : ℕ) (G : SimpleGraph (Fin n)), NoShortCycles 5 G →
      ∃ D, IsRobustAcyclicOrientation G D)
```

The witness's size is `n=2^96`. It is one finite simple graph, with the orientation quantified **after** the graph: the same graph defeats every orientation. No source theorem, high-girth existence statement, counting inequality or unverified certificate appears as an added premise of either terminal theorem. The second theorem negates the full affirmative finite-graph question. A finite counterexample also disproves any broader affirmative formulation including infinite graphs. No classification of infinite graphs or all-girth strengthening is claimed.

The Hasse extension is explicit: `exists_noShortCycles_not_hasse_subgraph` in [`SourceTheorem.lean`, line 100](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/SourceTheorem.lean#L100) rules out an arbitrary subgraph embedding into the Hasse graph of **any** ambient partial order, without requiring the ambient type to be finite. It is stronger than merely saying that `G` is not itself an induced Hasse graph on the same vertices. Its scope remains `s=5`.

## 3. Mathematical argument actually implemented

### 3.1 A finite separated carrier

Set `N=2^96`, `d=2^20`, and `M=120·96·N`. The module [`Carrier.lean`](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/Carrier.lean) proves by induction that there is a family of `M` five-element subsets of `Fin N`. Every vertex belongs to at most `d` blocks. When a new block is inserted, any two of its distinct vertices avoid a route of at most three steps in the old block shadow (two vertices are shadow-adjacent when they share an old block).

The inductive construction excludes vertices whose block load is saturated and short shadow neighborhoods around already chosen vertices. Double counting gives total load `5·|B|`, so fewer than half the vertices are saturated under `10M<dN`. A closed shadow neighborhood has at most `1+5d` vertices, hence a three-step neighborhood has at most `(1+5d)^3`. The second parameter inequality, `10(1+5d)^3<N`, leaves room to choose five mutually separated unsaturated vertices. Both inequalities are proved by exact arithmetic for the displayed parameters. The carrier is a proved finite existence result; the development does not enumerate an astronomical adjacency list or claim to output a practical minimal graph.

### 3.2 Paste five-cycles without creating short cycles

Choose one relabelled five-cycle in each block and take the union of their edges. The insertion invariant ensures that this pasting preserves absence of triangles and quadrilaterals. A new short cycle using both old and new edges would give an old shadow route of at most three steps between two vertices of the new block. Purely old cycles are excluded inductively, and a cycle lying entirely inside the new five-cycle cannot have length three or four.

The modules `Gluing.lean`, `LocalCycle.lean` and `Pasting.lean` prove the adjacency-level cases and their preservation; `Cycles.lean` converts them to the standard simple-cycle condition. All cases are proved rather than supplied as a high-girth oracle.

### 3.3 One labelling works for every vertex order

Each block has `5!=120` permutation labels. Given any vertex ranking, at least one specified label places its five vertices in increasing order along the four-edge path with the endpoint shortcut. Consequently at most `119^M` assignments miss all prescribed labels for that ranking. There are at most `N^N` rankings, so at most `N^N·119^M` assignments can be bad for some ranking. The strict inequality

`N^N · 119^M < 120^M`

therefore leaves a labelling good for every ranking. `FiniteChoice.lean` proves this finite union bound by a cardinality contradiction and proves the required numerical inequality from `2·119^120<120^120`, amplified symbolically. Labels producing the same undirected graph do not invalidate the argument: the count is over label assignments, and the successful assignment supplies a graph. No distinct-graph count is assumed.

`exists_ordered_graph_of_carrier` and `exists_noShortCycles_ordered_five` in `SourceTheorem.lean` assemble this construction. For every bijective rank, the graph contains distinct vertices `v0<…<v4` with edges `v0v1,v1v2,v2v3,v3v4,v0v4`.

### 3.4 Every orientation fails robustness; Hasse exclusion

An acyclic orientation of a finite graph has a topological ranking. On the ordered five-cycle supplied for that ranking, all four path edges point forward, as does the endpoint shortcut. Reversing the shortcut creates a directed closed walk. Thus an orientation is either already cyclic or loses acyclicity after one edge reversal. `OrderedObstruction.lean`, `Reachability.lean` and `ReverseEdge.lean` prove these steps internally, and `Main.lean` produces the counterexample and universal negation.

For the historical Hasse formulation, robustness implies that each arc is a cover in the reachability partial order: an intermediate reachable vertex would supply an alternate directed path and make reversal cyclic. `HasseBridge.lean` proves equality with the Hasse graph, without a finiteness requirement. `CoverObstruction.lean` also treats an arbitrary embedding into an ambient Hasse graph. Pulling back cover directions gives an acyclic orientation; the ordered five-cycle would force a cover with an intermediate chain, contradicting the definition of a cover. This works even when the ambient poset is infinite.

## 4. Complete prior formalization and contribution comparison

The complete prior source is [plby/lean-proofs, `Erdos1006.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos1006.lean), at **`8822f7ddef30fadbd92e1c6ab4ed897af356af5e`**, with its three imported support files `Erdos1006/Core.lean`, `Erdos1006/Counting.lean`, and `Erdos1006/NesetrilRodl.lean` at that same commit. [Issue #24](https://github.com/TheJustinSunPrize/awards/issues/24) registers existing reproduction evidence; registration does not determine authorship or prize acceptance.

| Aspect | Pinned plby source | Submitted A |
| --- | --- | --- |
| Literal orientation counterexample | `erdos1006_orientation_counterexample`, main line 41 | `jsp_000838_counterexample`, Main line 6, via the robust-orientation negation |
| Complete negative answer | `not_erdos_1006`, main line 57; `erdos1006_universal_claim_false`, line 66 | `jsp_000838_conjecture_false`, Main line 13 |
| Carrier method | Finite average-bad-witness count, removal of bad block roots, short Berge-cycle exclusion (`Counting.lean`) | Greedy block insertion, bounded loads and three-step shadow separation (`Carrier.lean`) |
| Proved carrier vertex count | `2^64` (`Counting.lean`, line 278) | `2^96` (`Carrier.lean`, line 142) |
| Ordered-template step | Relabelled C5 pasting and finite `119/120` union count | Same high-level method, separately organized finite count and gluing modules |
| Interface to girth | Explicit triangle/four-cycle predicates | Mathlib `Walk.IsCycle`/extended-girth and arbitrary C3/C4-copy bridges |
| Hasse formulation in inspected files | The four inspected files establish the orientation result; no separate Hasse-subgraph theorem was located there | Explicit same-vertex reachability-order bridge and arbitrary Hasse-subgraph obstruction, including infinite ambient posets |

The prior proof is complete for the same original question. Its carrier size is **smaller** than the selected implementation's: no improved size bound, minimality, new negative solution, or first complete formalization is claimed. The greedy carrier and additional interfaces are concrete formalization work for assessment; the central ordered-cycle/counting strategy is shared published mathematics. The Hasse consequence is also in the 1978 paper, so its Lean interface is not a new mathematical result.

The plby main header credits Nešetřil/Rödl for the informal result and Codex/GPT-5.6 Sol for formalization; it and the supporting files also preserve the Apache-2.0 notices naming **Aristotle and Boris Alexeev**. Those existing credits must not be collapsed into repository ownership or attributed to this submitter. The selected 18-file `JSP000838` proof imports Mathlib and its own modules, not these plby files. Its [attribution](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/ATTRIBUTION.md) describes a separately developed, AI-assisted local implementation. This review records that provenance statement and concrete code differences; it does not independently establish the full development history or award priority.

## 5. Original history and relocation

Before relocation, the proof was public in [CHENLexiao8848/awards at `cee43256a4674c25eb1f4dab64d91d8a7647a584`](https://github.com/CHENLexiao8848/awards/tree/cee43256a4674c25eb1f4dab64d91d8a7647a584/submissions/jsp-000838), under `submissions/jsp-000838/proof`. The selected A moves it to `packages/jsp-000838/proof` in the existing proof repository. **Correction to the historical migration description:** all 18 Lean source texts were retained, with **LF-to-CRLF line-ending conversion and no other content change**. They were not preserved byte-for-byte. Every selected file has a different raw Git blob, but replacing only CRLF with LF reproduces its exact old Git blob. The license, toolchain, Lake configuration, dependency manifest and verifier exhibit the same newline-only conversion. The [historical migration record](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/MIGRATION.md)'s “byte-for-byte” wording is superseded by this correction. The [historical manifest](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/evidence/migration-source-hashes.json)'s hashes describe the **new CRLF bytes**, not the old LF bytes; all 18 agree with the exact new-commit CI summary. The original commit remains intact and the selected proof A need not change.

These are two locations for the same submitted proof history, not two independent formalization claims. The previous Git commit must remain linked as provenance evidence. Relocation and catalog-format correction are administrative contributions; they must not be described as new mathematics or a new date of proof creation. Old wording such as “already-reviewed source” means the recorded local/source checks, not completed organizer or independent human approval.

A later documentation commit B should preserve A's proof, toolchain and dependency lock, and identify A as the verification target. Do not use a documentation-only hash as if it were a newly compiled proof revision.

## 6. Verification scope and reproduction

The selected [local summary](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/evidence/summary.json) records Windows checks on 2026-09-17, status `PASS`, and `clean_requested:false`. It is historical local evidence and is **not by itself a clean build**. The separate [selected-SHA Linux CI run 35226624341](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341), [job 105219764302](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764302), supplies a distinct successful Ubuntu 24.04 reproduction. On 2026-09-26, its actual ZIP artifact, workflow and job log were retrieved and inspected. Artifact `jsp-000838-verification`, ID [10499142078](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/artifacts/10499142078), is **6,597 bytes** with SHA-256 **`a2eee9c44184ad300b96e4aa4f9d1a211df99217e829d92fcc400fe986686812`**, matching GitHub metadata. All 22 recorded input hashes (18 Lean files, toolchain, Lake configuration, full lock and verifier) bind to A; all nine actual dependency checkout revisions agree with the manifest.

The [fixed workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/.github/workflows/jsp-batch.yml) disables the GitHub project cache while permitting pinned Mathlib caches. Both project-cache restore and save are explicitly skipped in the actual log; the exact commit contains no project `.lake` or `.olean` files. The actual build contains 17 newly built modules, including the root module, and successful completion of **1,302 jobs**. The eighteenth Lean file is the separately elaborated axiom audit. All six verifier commands return exit 0. These records support fresh compilation of the submitted project even though `clean_requested:false`; they do not support a claim that `--clean` ran or that Mathlib was rebuilt from source.

The workflow subsequently runs `lake env leanchecker --verbose JSP000838.Main`. Its successful shell step and newly generated `kernel-replay.txt` support Main-entry replay against imported dependencies. The uploaded `leanchecker-result.json`, `leanchecker-fresh.txt` and `leanchecker.txt` are preserved older files, not new whole-environment replay results. `kernel-replay-result.json` is also historical; the actual new shell step/log supplies the current replay evidence. No new all-local-module or full-Mathlib replay is asserted. The original artifact currently expires on 2026-12-16, so the inspected logs should be preserved alongside this report.

Lean is pinned to **4.34.0**, Mathlib to **`5ed2965256430c3649e86755f9576b54eca72435`** in the lock. The existing `AxiomAudit.lean` checks nine declarations: carrier existence, the general carrier-to-graph step, ordered-five-cycle existence, non-cover and non-Hasse-subgraph conclusions, the robust-orientation Hasse bridge, the reversal obstruction, and both terminal targets. Each of the nine actual CI axiom reports uses only `propext`, `Classical.choice`, `Quot.sound`. In particular:

```text
'JSP000838.jsp_000838_counterexample' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.jsp_000838_conjecture_false' depends on axioms: [propext, Classical.choice, Quot.sound]
```

For isolated reproduction:

```sh
git clone --branch codex/jsp-000301-000139-000838 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 48fd10d0009408a1a3cdd1640bc22884facf00c3
cd packages/jsp-000838/proof
lake exe cache get
python3 verify.py --clean --output-dir ../evidence-reproduced
lake env leanchecker --verbose JSP000838.Main
```

`--clean` removes only this project's build directory, preserving fixed dependency caches; it does not rebuild all Mathlib or constitute a second independent checker. The verifier checks actual toolchain and dependency identity, all 18 Lean files, all nine named axiom outputs and unchanged source hashes. The entry-module replay imports dependencies. Historical full-environment replay and newer targeted replay are different operations and must not be conflated. This documentation review does not claim a new Lean execution.

## 7. Contribution and review status

The mathematical solution remains Nešetřil–Rödl (1978). The contribution submitted by `CHENLexiao8848` is the described Codex-assisted local formalization, finite greedy carrier, exact graph/orientation/Hasse interfaces, preserved source history and reproducibility work. No exclusive manual authorship or independent human verification is claimed. The recipient label in the historical attribution is a proposed identifier pending organizer confirmation, not an approved award recipient.

This documentation can support statement, source and verification review. It cannot by itself decide whether another implementation of a known complete result meets originality, priority or prize eligibility requirements. Those questions remain with the maintainers.

## Permanent verification and migration records

The [preserved exact-version CI evidence and migration comparison](ci-evidence-review-20260926.md) contains the original Linux command summary, build, nine-target axiom and Main-entry replay logs, all artifact hashes, and both old LF/new CRLF source hashes and Git blobs. The [corrected migration note](MIGRATION.md) explicitly replaces the earlier byte-identity claim. Neither document changes proof A or claims a new Lean execution.
