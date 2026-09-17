import ErdosProblems.Erdos292

/-!
# JSP-000248 / Erdős 292

The set of possible largest denominators in representations of 1 as sums
of distinct unit fractions has natural density one. The imported proof
uses the stronger positive-upper-density unit fraction theorem.
Original formalization is separately retrieved and pinned, with attribution
in the upstream source.
-/

namespace JSP000248

open Filter
open scoped BigOperators Topology

def Attainable (n : ℕ) : Prop :=
  ∃ S : Finset ℕ, S ⊆ Finset.Icc 1 n ∧ n ∈ S ∧
    (∑ m ∈ S, (1 : ℚ) / m) = 1

open Classical in
/-- Counting with [0,N) gives the standard natural-density formulation. -/
theorem solution :
    Tendsto (fun N : ℕ =>
      (((Finset.range N).filter Attainable).card : ℝ) / N) atTop (𝓝 1) := by
  exact Erdos292.tendsto_partial_density_largestDenominators

#print axioms solution

end JSP000248
