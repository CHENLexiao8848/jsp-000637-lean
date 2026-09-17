import ErdosProblems.Erdos801

/-! JSP-000658 / Erdős801. A small independence number forces a small dense
induced subgraph. The public upstream theorem is instantiated with explicit
absolute constants; its edge counter is linked here to Mathlib's induced graph. -/

namespace LeanForty.Problem000658

open SimpleGraph

noncomputable section
attribute [local instance] Classical.propDecidable

theorem indepNum_le_iff {V : Type*} [Fintype V] (G : SimpleGraph V) (a : ℕ) :
    G.indepNum ≤ a ↔ ∀ I : Finset V, G.IsIndepSet I → I.card ≤ a := by
  constructor
  · intro h I hI
    exact hI.card_le_indepNum.trans h
  · intro h
    obtain ⟨I, hI⟩ := G.exists_isNIndepSet_indepNum
    rw [← hI.card_eq]
    exact h I hI.isIndepSet

theorem edgeCountInside_eq_induced {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) (S : Finset V) :
    Erdos801.edgeCountInside G S = (G.induce (S : Set V)).edgeFinset.card := by
  classical
  exact Erdos801.card_edgesInside_eq_induce G S

/-- Full eventual theorem, with positive absolute constant C and fixed N. -/
theorem dense_small_set :
    ∃ C N : ℕ, 0 < C ∧ ∀ n ≥ N, ∀ G : SimpleGraph (Fin n),
      G.indepNum ≤ Nat.sqrt n →
        ∃ S : Finset (Fin n), S.card ≤ Nat.sqrt n ∧
          Nat.sqrt n * Nat.log 2 n ≤ C * Erdos801.edgeCountInside G S :=
  Erdos801.erdos_801

/-- Original hypothesis phrased directly as a bound on every independent set,
and the conclusion as the actual edge count of an induced subgraph. -/
theorem dense_induced_subgraph {n : ℕ} (hn : 2 ^ (2 ^ 11) ≤ n)
    (G : SimpleGraph (Fin n))
    (hI : ∀ I : Finset (Fin n), G.IsIndepSet I → I.card ≤ Nat.sqrt n) :
    ∃ S : Finset (Fin n), S.card ≤ Nat.sqrt n ∧
      Nat.sqrt n * Nat.log 2 n ≤ 2 ^ 24 * (G.induce (S : Set (Fin n))).edgeFinset.card := by
  classical
  obtain ⟨S, hS, he⟩ := Erdos801.erdos_801_explicit hn G ((indepNum_le_iff G _).mpr hI)
  exact ⟨S, hS, by simpa only [edgeCountInside_eq_induced] using he⟩

end

end LeanForty.Problem000658
