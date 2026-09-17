import ErdosProblems.Erdos797
import Mathlib.Combinatorics.SimpleGraph.Acyclic

/-! JSP-000655 / Erdős797: the AMR estimates and subquadratic consequence.
The underlying proof is the pinned public formalization. This adapter also
checks that the coloring definition means every two color classes induce a forest. -/

namespace LeanForty.Problem000655

open SimpleGraph

theorem acyclicColoring_iff_two_color_forests {V C : Type*}
    (G : SimpleGraph V) (c : V → C) :
    Erdos797.IsAcyclicColoring G c ↔
      (∀ ⦃u v⦄, G.Adj u v → c u ≠ c v) ∧
      ∀ a b : C, (G.induce {u | c u = a ∨ c u = b}).IsAcyclic := by
  classical
  constructor
  · rintro ⟨hproper, hcycle⟩
    refine ⟨hproper, ?_⟩
    intro a b v w hw
    let e := SimpleGraph.Embedding.induce (G := G) {u | c u = a ∨ c u = b}
    apply hcycle (w.map e.toHom) (hw.map e.injective)
    refine ⟨a, b, ?_⟩
    intro u hu
    rw [SimpleGraph.Walk.support_map] at hu
    obtain ⟨x, hx, hxu⟩ := List.mem_map.mp hu
    change (x : V) = u at hxu
    rw [← hxu]
    exact x.property
  · rintro ⟨hproper, hforest⟩
    refine ⟨hproper, ?_⟩
    intro v w hw
    rintro ⟨a, b, htwo⟩
    let S : Set V := {u | c u = a ∨ c u = b}
    have hS : ∀ u ∈ w.support, u ∈ S := htwo
    have hmap : ((w.induce S hS).map
        (SimpleGraph.Embedding.induce (G := G) S).toHom).IsCycle := by
      simpa using hw
    exact hforest a b (w.induce S hS) hmap.of_map

/-- Upper and lower AMR estimates in exact integer-power form, plus f(d)=o(d²). -/
theorem amr_estimates :
    (∀ d : ℕ, 1 ≤ d → Erdos797.extremalAcyclicNumber d ^ 3 ≤ 1024 ^ 3 * d ^ 4) ∧
    (∀ d : ℕ, Erdos797.LowerBound.lowerD 1 ≤ d →
      d ^ 4 ≤ 2 ^ 67 * Nat.log 2 d * Erdos797.extremalAcyclicNumber d ^ 3) ∧
    ((fun d : ℕ => (Erdos797.extremalAcyclicNumber d : ℝ)) =o[Filter.atTop]
      (fun d : ℕ => (d : ℝ) ^ 2)) := Erdos797.erdos_797

/-- Every graph of maximum degree at most d admits an acyclic coloring
with the extremal palette size; the infimum in f is actually attained. -/
theorem optimal_palette_exists (d n : ℕ) (G : SimpleGraph (Fin n))
    (hG : Erdos797.graphMaxDegree G ≤ d) :
    ∃ c : Fin n → Fin (Erdos797.extremalAcyclicNumber d),
      (∀ ⦃u v⦄, G.Adj u v → c u ≠ c v) ∧
      ∀ a b, (G.induce {u | c u = a ∨ c u = b}).IsAcyclic := by
  obtain ⟨c, hc⟩ := Erdos797.LowerBound.extremalAcyclicNumber_spec d n G hG
  exact ⟨c, (acyclicColoring_iff_two_color_forests G c).mp hc⟩

end LeanForty.Problem000655
