/-
SPDX-License-Identifier: Apache-2.0
Mathematical theorem: V. A. Tashkinov.
Reuses the attributed full proof in plby/lean-proofs at
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, ErdosProblems/Erdos715.lean.
The subgraph is nonempty, may omit vertices, and need not be induced.
-/
import ErdosProblems.Erdos715

namespace Formalization20

universe u

open scoped Classical in
theorem jsp_000584 {V : Type u} [Fintype V] [Nonempty V]
    (G : SimpleGraph V) (hreg : G.IsRegularOfDegree 4) :
    Erdos182.ContainsRegularSubgraph G 3 :=
  Erdos715.erdos_715 G hreg

open scoped Classical in
theorem jsp_000584_exists_degree :
    ∃ r : ℕ, ∀ (V : Type u) [Fintype V] [Nonempty V],
      ∀ G : SimpleGraph V, G.IsRegularOfDegree r →
        Erdos182.ContainsRegularSubgraph G 3 :=
  Erdos715.erdos_715_exists_degree

#print axioms jsp_000584
#print axioms jsp_000584_exists_degree

end Formalization20
