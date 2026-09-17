import LeanForty.ChordSemantics
import ErdosProblems.Erdos767

/-!
JSP-000628 / Erdős 767. The extremal number is exactly
`(k+1)*n - (k+1)^2` for positive k and n ≥ 3*k+3.
The underlying proof is the pinned public plby formalization. This adapter
also states the bound and an attaining graph with an arbitrary common
cycle vertex, using the independently checked rotation equivalence.
-/

namespace LeanForty.Problem000628

open SimpleGraph

noncomputable section
attribute [local instance] Classical.propDecidable

theorem forbidden_configuration_iff {V : Type*} (k : ℕ) (G : SimpleGraph V) :
    HasIncidentChords k G ↔ Erdos767.HasCycleWithKIncidentChords k G :=
  hasIncidentChords_iff_based k G

/-- Exact extremal number, uniformly in all positive k and all n≥3k+3. -/
theorem exact_extremal_number (k n : ℕ) (hk : 0 < k) (hn : 3 * k + 3 ≤ n) :
    Erdos767.chordCycleExtremalNumber k n = (k + 1) * n - (k + 1) ^ 2 :=
  Erdos767.erdos_767 k n hk hn

/-- Direct graph formulation: the claimed bound holds for every admissible
n-vertex graph, and is attained by an admissible n-vertex graph. -/
theorem sharp_bound_and_attainment (k n : ℕ) (hk : 0 < k)
    (hn : 3 * k + 3 ≤ n) :
    (∀ G : SimpleGraph (Fin n), ¬HasIncidentChords k G →
      G.edgeFinset.card ≤ (k + 1) * n - (k + 1) ^ 2) ∧
    ∃ G : SimpleGraph (Fin n), ¬HasIncidentChords k G ∧
      G.edgeFinset.card = (k + 1) * n - (k + 1) ^ 2 := by
  have heq := exact_extremal_number k n hk hn
  constructor
  · intro G hG
    rw [← heq]
    apply Erdos767.card_edgeFinset_le_chordCycleExtremalNumber
    intro hbad
    exact hG ((forbidden_configuration_iff k G).mpr hbad)
  · obtain ⟨G, hG, hcard⟩ := Erdos767.exists_extremizer k n
    refine ⟨G, ?_, hcard.trans heq⟩
    intro hbad
    exact hG ((forbidden_configuration_iff k G).mp hbad)

end

end LeanForty.Problem000628
