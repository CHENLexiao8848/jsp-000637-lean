import ErdosProblems.Erdos808Disproof

/-! JSP-000665 / Erdős808: the graph-restricted strong sum-product conjecture
is false. This adapter states the explicit exponent gap for arbitrarily large
finite sets of distinct positive integer labels. -/

namespace LeanForty.Problem000665

open Filter
noncomputable section
attribute [local instance] Classical.propDecidable Classical.decEq

theorem strong_sum_product_false : ¬ Erdos808.StrongErdos808 :=
  Erdos808.erdos808_disproved

/-- Uniformly cofinal counterexamples for c=29/34 and epsilon=1/68. -/
theorem explicit_counterexamples (N : ℕ) :
    ∃ q : ℕ, N ≤ Fintype.card (Erdos808.CounterVertex q) ∧
      (Fintype.card (Erdos808.CounterVertex q) : ℝ) ^ ((63 : ℝ) / 34) ≤
        ((Erdos808.counterGraph q).edgeFinset.card : ℝ) ∧
      max ((Erdos808.edgeSums (Erdos808.counterEmbedding q) (Erdos808.counterGraph q)).card : ℝ)
          ((Erdos808.edgeProducts (Erdos808.counterEmbedding q) (Erdos808.counterGraph q)).card : ℝ) <
        (Fintype.card (Erdos808.CounterVertex q) : ℝ) ^ ((125 : ℝ) / 68) := by
  have hboth := Erdos808.counterGraph_edge_threshold_eventually.and
    (Erdos808.counterGraph_output_small_eventually.and
      (eventually_ge_atTop (max (4 * N) 2)))
  obtain ⟨q, hedge, hout, hq⟩ := hboth.exists
  have hq2 : 2 ≤ q := (le_max_right _ _).trans hq
  have hN : 4 * N ≤ q := (le_max_left _ _).trans hq
  have hpow : q ≤ q ^ 17 := le_self_pow (by omega) (by norm_num)
  have hcard := Erdos808.counterVertex_card_quarter hq2
  exact ⟨q, by omega, hedge, hout⟩

/-- The labels are genuinely positive distinct natural numbers. -/
theorem positive_injective_labels (q : ℕ) :
    Function.Injective (Erdos808.counterLabel q) ∧
      ∀ x, 0 < Erdos808.counterLabel q x :=
  ⟨Erdos808.counterLabel_injective q, Erdos808.counterLabel_pos q⟩

end
end LeanForty.Problem000665
