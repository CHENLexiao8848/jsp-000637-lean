import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

/-!
# JSP-000690 / Erdős problem 834: the chromatic interpretation

An explicit 3-uniform hypergraph on nine vertices is critically 3-chromatic
and has minimum degree seven. This formalizes the chromatic interpretation
of the question, as selected by the current JSP catalog. It does not conflate
chromatic criticality with transversal-number criticality.

The 22-edge witness is Ruiliang Li's construction, Theorem 1.2 and equation (5)
of https://arxiv.org/abs/2512.24850v1. Vertices are relabelled from 1,...,9
to 0,...,8. All finite certificates below are checked by the Lean kernel.
-/

namespace JSP000690

abbrev Hypergraph := Finset (Finset (Fin 9))

/-- Weak proper coloring: each edge receives at least two different colors. -/
def ProperColoring (H : Hypergraph) {k : ℕ} (c : Fin 9 → Fin k) : Prop :=
  ∀ e ∈ H, ∃ u ∈ e, ∃ v ∈ e, c u ≠ c v

def Colorable (H : Hypergraph) (k : ℕ) : Prop :=
  ∃ c : Fin 9 → Fin k, ProperColoring H c

def ThreeUniform (H : Hypergraph) : Prop :=
  ∀ e ∈ H, e.card = 3

def degree (H : Hypergraph) (v : Fin 9) : ℕ :=
  (H.filter (fun e => v ∈ e)).card

/-- Delete a vertex and all its incident edges. Keeping its now-isolated
label does not affect existence of a proper coloring. -/
def deleteVertex (H : Hypergraph) (v : Fin 9) : Hypergraph :=
  H.filter (fun e => v ∉ e)

/-- Chromatic number exactly three, and every single edge or vertex deletion
admits a proper two-coloring. -/
def CriticallyThreeChromatic (H : Hypergraph) : Prop :=
  Colorable H 3 ∧ ¬ Colorable H 2 ∧
    (∀ e ∈ H, Colorable (H.erase e) 2) ∧
    (∀ v : Fin 9, Colorable (deleteVertex H v) 2)

def witness : Hypergraph :=
  {{0, 1, 2}, {0, 1, 8}, {0, 2, 7}, {0, 3, 5}, {0, 3, 7}, {0, 3, 8},
   {0, 4, 6}, {0, 4, 7}, {0, 4, 8}, {0, 5, 6}, {1, 2, 5}, {1, 2, 6},
   {1, 3, 8}, {1, 4, 8}, {1, 5, 6}, {2, 3, 7}, {2, 4, 7}, {2, 5, 6},
   {3, 5, 7}, {3, 5, 8}, {4, 6, 7}, {4, 6, 8}}

set_option maxRecDepth 100000
set_option maxHeartbeats 0

theorem witness_uniform : ThreeUniform witness := by
  unfold ThreeUniform
  decide +kernel

theorem witness_degree : ∀ v : Fin 9,
    degree witness v = if v = 0 then 10 else 7 := by
  decide +kernel

theorem witness_not_two_colorable : ¬ Colorable witness 2 := by
  unfold Colorable ProperColoring
  decide +kernel

theorem witness_three_colorable : Colorable witness 3 := by
  refine ⟨![0, 0, 1, 0, 0, 1, 2, 1, 1], ?_⟩
  unfold ProperColoring
  decide +kernel

theorem witness_edge_critical :
    ∀ e ∈ witness, Colorable (witness.erase e) 2 := by
  intro e he
  simp only [witness, Finset.mem_insert, Finset.mem_singleton] at he
  rcases he with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact ⟨![0, 0, 0, 0, 0, 1, 1, 1, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 0, 1, 1, 1, 1, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 0, 1, 1, 1, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 0, 0, 0, 0, 1, 1, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 0, 1, 0, 1, 1, 0, 0, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 0, 0, 1, 1, 0, 1, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 0, 0, 0, 1, 0, 1, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 0, 1, 1, 0, 0, 1, 0, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 0, 1, 0, 0, 1, 1, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![0, 1, 1, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 0, 0, 0, 0, 1, 1, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 0, 0, 0, 1, 0, 1, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 0, 1, 1, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 1, 0, 0, 1, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 0, 1, 1, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 0, 0, 1, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 0, 0, 0, 1, 0, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 0, 0, 0, 1, 1, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 0, 0, 1, 0, 0, 1], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 0, 0, 1, 0, 1, 0], by unfold ProperColoring; decide +kernel⟩

theorem witness_vertex_critical :
    ∀ v : Fin 9, Colorable (deleteVertex witness v) 2 := by
  intro v
  fin_cases v
  · exact ⟨![0, 1, 1, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 0, 1, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 0, 1, 1, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 0, 0, 1, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 1, 0, 0, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 1, 0, 0, 1, 0, 0], by unfold ProperColoring; decide +kernel⟩
  · exact ⟨![1, 1, 0, 0, 0, 1, 0, 1, 0], by unfold ProperColoring; decide +kernel⟩


/-- Positive answer to the chromatic interpretation of JSP-000690. -/
theorem solution : ∃ H : Hypergraph,
    ThreeUniform H ∧ CriticallyThreeChromatic H ∧
    (∀ v : Fin 9, 7 ≤ degree H v) ∧ (∃ v : Fin 9, degree H v = 7) := by
  refine ⟨witness, witness_uniform,
    ⟨witness_three_colorable, witness_not_two_colorable,
      witness_edge_critical, witness_vertex_critical⟩, ?_, ?_⟩
  · intro v
    rw [witness_degree v]
    split <;> norm_num
  · exact ⟨1, by decide +kernel⟩

#print axioms solution

end JSP000690
