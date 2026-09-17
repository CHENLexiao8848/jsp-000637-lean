import ErdosProblems.Erdos402

/-!
JSP-000331 asks for Graham's gcd bound for all sufficiently large finite sets
of positive integers. The attached catalog explicitly includes this eventual
quantifier. This interface also makes the two witnesses distinct.

The proof dependency is the pinned, privately retrieved Erdos402 eventual
argument; provenance and extraction are recorded in gcd402-extraction.json.
The stronger statement for every nonempty cardinality is not asserted here.
-/

namespace JSP000331

/-- Every sufficiently large finite positive-integer set has a distinct pair
with gcd at most the first element divided by the size of the set. -/
theorem solution :
    ∃ N₀ : ℕ, 2 ≤ N₀ ∧ ∀ A : Finset ℕ, N₀ ≤ A.card → 0 ∉ A →
      ∃ a ∈ A, ∃ b ∈ A, a ≠ b ∧
        (Nat.gcd a b : ℚ) ≤ (a : ℚ) / A.card := by
  obtain ⟨N, hN⟩ := Erdos402.erdos_402
  refine ⟨max 2 N, le_max_left _ _, ?_⟩
  intro A hcard hzero
  have htwo : 2 ≤ A.card := (le_max_left _ _).trans hcard
  have hnonempty : A.Nonempty := Finset.card_pos.mp (by omega)
  obtain ⟨a, ha, b, hb, hab⟩ := hN A ((le_max_right _ _).trans hcard) hzero hnonempty
  refine ⟨a, ha, b, hb, ?_, hab⟩
  intro heq
  subst b
  have haPos : 0 < a := Nat.pos_of_ne_zero (by
    intro ha0
    subst a
    exact hzero ha)
  have hbound := (Erdos402.gcd_cast_le_div_iff (Finset.card_pos.mpr hnonempty)).1 hab
  simp only [Nat.gcd_self] at hbound
  nlinarith

end JSP000331
