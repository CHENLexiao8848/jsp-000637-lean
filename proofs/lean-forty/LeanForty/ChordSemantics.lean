import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Walk.Chord

/-! The common endpoint of the incident chords may be any cycle vertex.
Rotating the cycle makes that endpoint the base without changing any chord. -/

namespace LeanForty

open SimpleGraph
open scoped SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {b v x y : V}

theorem isChord_rotate_iff [DecidableEq V] (c : G.Walk b b)
    (hv : v ∈ c.support) :
    (c.rotate v hv).IsChord s(x, y) ↔ c.IsChord s(x, y) := by
  simp only [SimpleGraph.Walk.isChord_sym2Mk,
    (c.rotate_edges v hv).perm.mem_iff, SimpleGraph.Walk.mem_support_rotate_iff]

/-- Ordinary statement: choose a cycle, any one of its vertices, and k
distinct neighbors that are joined to it by non-rim edges. -/
def HasIncidentChords (k : ℕ) (G : SimpleGraph V) : Prop :=
  ∃ (b : V) (c : G.Walk b b), c.IsCycle ∧
    ∃ v ∈ c.support, ∃ f : Fin k → V,
      Function.Injective f ∧ ∀ i, c.IsChord s(v, f i)

theorem hasIncidentChords_iff_based (k : ℕ) (G : SimpleGraph V) :
    HasIncidentChords k G ↔
      ∃ (v : V) (c : G.Walk v v), c.IsCycle ∧
        ∃ f : Fin k → V, Function.Injective f ∧ ∀ i, c.IsChord s(v, f i) := by
  classical
  constructor
  · rintro ⟨b, c, hc, v, hv, f, hf, hchords⟩
    refine ⟨v, c.rotate v hv, hc.rotate hv, f, hf, ?_⟩
    intro i
    exact (isChord_rotate_iff c hv).mpr (hchords i)
  · rintro ⟨v, c, hc, f, hf, hchords⟩
    exact ⟨v, c, hc, v, c.start_mem_support, f, hf, hchords⟩

end LeanForty
