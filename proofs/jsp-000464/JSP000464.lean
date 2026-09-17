/-
SPDX-License-Identifier: Apache-2.0
Attributed formal proof from plby/lean-proofs at
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, ErdosProblems/Erdos574.lean.
This is the disproof of the conjectured universal asymptotic, not a claim to
determine every extremal number exactly.
-/
import ErdosProblems.Erdos574

namespace Formalization20

open Filter Asymptotics

theorem jsp_000464 :
    ¬ (∀ k : ℕ, 2 ≤ k →
      (fun n : ℕ ↦ (Erdos574.consecutiveCycleExtremalNumber k n : ℝ)) ~[atTop]
        (fun n : ℕ ↦ ((n : ℝ) / 2) ^ (1 + 1 / (k : ℝ)))) :=
  Erdos574.not_erdos_574

#print axioms jsp_000464

end Formalization20
