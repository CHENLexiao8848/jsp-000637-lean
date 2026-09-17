import ErdosProblems.Erdos795

/-!
# JSP-000653 / Erdős 795

The maximum cardinality of a subset of [1,N] with distinct subset products
is π(N)+π(floor(sqrt N))+o(sqrt N/log N). The imported source includes both
the prime/prime-square construction and the matching asymptotic upper bound.
Original proof: plby/lean-proofs, pinned in artifacts/audit/prepared-Erdos795.json.
The dependency is retrieved separately; this wrapper does not claim its authorship.
-/

namespace JSP000653

open Filter Asymptotics

/-- Matching lower construction and signed asymptotic error for the true maximum. -/
theorem solution :
    (∀ N, Nat.primeCounting N + Nat.primeCounting (Nat.sqrt N) ≤ Erdos795.g N) ∧
    (fun N : ℕ => (Erdos795.g N : ℝ) - Nat.primeCounting N -
      Nat.primeCounting (Nat.sqrt N)) =o[atTop]
      (fun N : ℕ => Real.sqrt N / Real.log N) :=
  ⟨Erdos795.baseline_le_g, Erdos795.erdos_795_signed_error_isLittleO⟩

/-- A direct interface for any set of positive integers with injective subset products. -/
theorem cardinal_bound {N : ℕ} {A : Finset ℕ} (hN : 1 ≤ N)
    (hA : A ⊆ Finset.Icc 1 N)
    (hproducts : Set.InjOn (fun S : Finset ℕ => ∏ a ∈ S, a) (A.powerset : Set (Finset ℕ))) :
    A.card ≤ Nat.primeCounting N + Nat.primeCounting (Nat.sqrt N) +
      Erdos795.finiteError N :=
  Erdos795.card_le_primeCounting_add_sqrt_add_finiteError hN hA hproducts

#print axioms solution
#print axioms cardinal_bound

end JSP000653
