/- SPDX-License-Identifier: Apache-2.0
Mathematical theorem: Bukh--Sudakov. Reuses plby/lean-proofs at
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, ErdosProblems/Erdos637.lean.
The output degrees are measured inside the selected induced subgraph.
-/
import ErdosProblems.Erdos637

namespace Formalization20

theorem jsp_000518 :
    ∀ C : ℝ, 0 < C →
      ∃ α : ℝ, 0 < α ∧ ∃ β : ℝ, 0 < β ∧
      ∃ N : ℕ, ∀ n ≥ N, ∀ G : SimpleGraph (Fin n),
        Erdos88.RamseyFree C G → ∃ W : Finset (Fin n),
          α * (n : ℝ) ≤ W.card ∧
          β * Real.sqrt n ≤ Erdos637.numDistinctDegrees G W :=
  Erdos637.erdos_637

#print axioms jsp_000518

end Formalization20
