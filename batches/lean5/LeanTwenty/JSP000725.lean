import ErdosProblems.Erdos874

/-!
# JSP-000725 / Erdős 874

For subsets of `[1,N]`, equality of two subset sums must imply equality
of their cardinalities. The largest admissible cardinality is asymptotic
to `2 * sqrt N`; in fact it eventually equals `floor(sqrt(4*N+1)) - 1`.

The full Deshouillers–Freiman proof is imported from the pinned external
dependency recorded in `artifacts/audit/prepared-Erdos874.json`.
-/

namespace JSP000725

open Filter
open scoped BigOperators Topology

/-- The requested asymptotic for the actual maximum cardinality. -/
theorem solution :
    Tendsto (fun N : ℕ => (Erdos874.k N : ℝ) / Real.sqrt N)
      atTop (𝓝 2) :=
  Erdos874.erdos_874

/-- The stronger eventual exact formula. -/
theorem eventual_exact :
    ∀ᶠ N : ℕ in atTop,
      Erdos874.k N = Nat.sqrt (4 * N + 1) - 1 := by
  simpa only [Erdos874.strausLength] using Erdos874.erdos_874_eventual_exact

/-- Direct formulation for any bounded set whose subset sums determine sizes. -/
theorem eventual_cardinal_bound :
    ∀ᶠ N : ℕ in atTop, ∀ A : Finset ℤ,
      A ⊆ Finset.Icc 1 (N : ℤ) →
      (∀ B : Finset ℤ, B ⊆ A → ∀ C : Finset ℤ, C ⊆ A →
        (∑ x ∈ B, x) = ∑ x ∈ C, x → B.card = C.card) →
      A.card ≤ Nat.sqrt (4 * N + 1) - 1 := by
  filter_upwards [eventual_exact] with N hN
  intro A hA hsum
  have hpos : ∀ x ∈ A, (0 : ℤ) < x := by
    intro x hx
    exact (by omega : (0 : ℤ) < 1).trans_le (Finset.mem_Icc.mp (hA hx)).1
  have hadm : Erdos874.IsAdmissible A :=
    (Erdos874.isAdmissible_iff_card_eq_of_sum_eq hpos).2 hsum
  exact (Erdos874.card_le_k ⟨hA, hadm⟩).trans_eq hN

#print axioms solution
#print axioms eventual_exact
#print axioms eventual_cardinal_bound

end JSP000725
