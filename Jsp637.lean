import ErdosProblems.Erdos777

/-!
# JSP-000637: the three Daykin–Erdős questions on comparable pairs

The catalog entry corresponds to Erdős Problem 777.  This module states all
three answers explicitly, using a finite family of subsets of `Fin n` and
the number of unordered edges in its simple comparability graph.

The proof is adapted from the Apache-2.0 formalization by the Lean-Proofs
Authors, pinned in `vendor/plby/UPSTREAM.md`.  This is a verified reuse and
Lean/Mathlib v4.34 port, not a claim of a new first formalization.
-/

namespace Jsp637

/-- The actual unordered edge count, with strict containment as adjacency. -/
noncomputable def edgeCount {n : ℕ} (F : Finset (Finset (Fin n))) : ℕ :=
  (Erdos777.comparableGraph F).edgeFinset.card

/-- Question 1: below `(2 - ε) 2^(n/2)` vertices, eventually fewer than `2^n` edges. -/
theorem first_question :
    ∀ ε : ℝ, 0 < ε →
      ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ F : Finset (Finset (Fin n)),
        (F.card : ℝ) ≤ (2 - ε) * (2 : ℝ) ^ ((n : ℝ) / 2) →
        edgeCount F < 2 ^ n :=
  Erdos777.firstQuestion_true

/-- Question 2: positive edge density does not imply the proposed uniform bound. -/
theorem second_question :
    ¬ (∀ c : ℝ, 0 < c →
      ∃ C : ℝ, 0 < C ∧ ∀ n : ℕ, ∀ F : Finset (Finset (Fin n)),
        c * (F.card : ℝ) ^ 2 ≤ (edgeCount F : ℝ) →
        (F.card : ℝ) ≤ C * (2 : ℝ) ^ ((n : ℝ) / 2)) :=
  Erdos777.secondQuestion_false

/-- Question 3: a suitable power-saving density forces the stated size bound. -/
theorem third_question :
    ∀ ε : ℝ, 0 < ε →
      ∃ δ : ℝ, 0 < δ ∧ ∀ n : ℕ, ∀ F : Finset (Finset (Fin n)),
        (F.card : ℝ) ^ (2 - δ) < (edgeCount F : ℝ) →
        (F.card : ℝ) < (2 + ε) ^ ((n : ℝ) / 2) :=
  Erdos777.thirdQuestion_true

/-- Complete resolution of JSP-000637 / Erdős 777: yes, no, yes. -/
theorem jsp_000637 :
    (∀ ε : ℝ, 0 < ε →
      ∃ N : ℕ, ∀ n : ℕ, N ≤ n → ∀ F : Finset (Finset (Fin n)),
        (F.card : ℝ) ≤ (2 - ε) * (2 : ℝ) ^ ((n : ℝ) / 2) →
        edgeCount F < 2 ^ n) ∧
    (¬ (∀ c : ℝ, 0 < c →
      ∃ C : ℝ, 0 < C ∧ ∀ n : ℕ, ∀ F : Finset (Finset (Fin n)),
        c * (F.card : ℝ) ^ 2 ≤ (edgeCount F : ℝ) →
        (F.card : ℝ) ≤ C * (2 : ℝ) ^ ((n : ℝ) / 2))) ∧
    (∀ ε : ℝ, 0 < ε →
      ∃ δ : ℝ, 0 < δ ∧ ∀ n : ℕ, ∀ F : Finset (Finset (Fin n)),
        (F.card : ℝ) ^ (2 - δ) < (edgeCount F : ℝ) →
        (F.card : ℝ) < (2 + ε) ^ ((n : ℝ) / 2)) :=
  ⟨first_question, second_question, third_question⟩

end Jsp637
