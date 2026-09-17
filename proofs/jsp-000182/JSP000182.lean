/- SPDX-License-Identifier: Apache-2.0
Reuses the attributed canonical Ramsey proof in plby/lean-proofs at
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, ErdosProblems/Erdos190.lean.
H is the least positive interval size for all finite vertex colorings.
-/
import ErdosProblems.Erdos190

namespace Formalization20

open Filter

theorem jsp_000182 :
    Tendsto (fun k : ℕ ↦ (Erdos190.H k : ℝ) ^ (1 / (k : ℝ)) / (k : ℝ))
      atTop atTop := Erdos190.erdos_190

theorem jsp_000182_threshold_spec (k : ℕ) :
    0 < Erdos190.H k ∧ Erdos190.Good k (Erdos190.H k) := Erdos190.H_spec k

theorem jsp_000182_threshold_minimal {k N : ℕ}
    (hN : 0 < N) (hgood : Erdos190.Good k N) : Erdos190.H k ≤ N :=
  Erdos190.H_minimal hN hgood

#print axioms jsp_000182
#print axioms jsp_000182_threshold_spec
#print axioms jsp_000182_threshold_minimal

end Formalization20
