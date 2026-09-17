/-
SPDX-License-Identifier: Apache-2.0
Mathematical result: Peter B. Borwein.
Formal proof reused from plby/lean-proofs commit
8822f7ddef30fadbd92e1c6ab4ed897af356af5e, ErdosProblems/Erdos1050.lean.
The local port narrows imports only; the mathematical statement and proof are unchanged.
-/
import ErdosProblems.Erdos1050

namespace Formalization20

/-- Irrationality of the original convergent series, indexed from n=1. -/
theorem jsp_000870 :
    Irrational (∑' n : ℕ+, 1 / ((2 : ℝ) ^ (n : ℕ) - 3)) :=
  Erdos1050.erdos_1050

#print axioms jsp_000870

end Formalization20
