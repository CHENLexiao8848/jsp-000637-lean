import ErdosProblems.Erdos803

/-! JSP-000660 / Erdős803 has a negative answer. This adapter makes the
negated absolute-constant assertion and its cofinal counterexamples explicit. -/

namespace LeanForty.Problem000660

open Filter SimpleGraph
noncomputable section
attribute [local instance] Classical.propDecidable Classical.decEq

theorem not_absolute_regularization : ¬ Erdos803.Erdos803Statement :=
  Erdos803.not_erdos_803

/-- For each proposed pair of absolute constants, one fixed m fails at
arbitrarily large host orders. All m-vertex subgraphs are quantified. -/
theorem cofinal_counterexamples (ε : ℝ) (hε : 0 < ε) (D : ℝ) (hD : 1 ≤ D) :
    ∃ m : ℕ, 1 ≤ m ∧ ∀ N : ℕ, ∃ n ≥ N, ∃ G : SimpleGraph (Fin n),
      (n : ℝ) * Real.log n ≤ (G.edgeSet.ncard : ℝ) ∧
      ∀ H : G.Subgraph, H.verts.ncard = m → H.coe.IsBalanced D →
        (H.edgeSet.ncard : ℝ) < ε * (m : ℝ) * Real.log m := by
  by_contra h
  push_neg at h
  apply not_absolute_regularization
  refine ⟨ε, hε, D, hD, ?_⟩
  intro m hm
  obtain ⟨N, hN⟩ := h m hm
  apply Filter.eventually_atTop.mpr
  refine ⟨N, ?_⟩
  intro n hn G hG
  exact hN n hn G hG

end
end LeanForty.Problem000660
