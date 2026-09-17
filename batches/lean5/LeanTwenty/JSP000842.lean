import ErdosProblems.Erdos1012

/-!
# JSP-000842 / Erdős 1012

Woodall's theorem gives the cutoff 2k+3 and all cycle lengths from 3 to n-k.
Source: plby/lean-proofs@8822f7ddef30fadbd92e1c6ab4ed897af356af5e,
retrieved and kernel-checked as an external dependency.
-/

namespace JSP000842

open Classical in
theorem all_lengths {n k : ℕ} (hn : 2 * k + 3 ≤ n)
    (G : SimpleGraph (Fin n))
    (hedges : (n - k - 1).choose 2 + (k + 2).choose 2 + 1 ≤ G.edgeFinset.card) :
    ∀ d, 3 ≤ d → d ≤ n - k →
      ∃ (v : Fin n) (p : G.Walk v v), p.IsCycle ∧ p.length = d :=
  Erdos1012.woodall hn G hedges

open Classical in
/-- The requested long cycle, with the explicit uniform cutoff. -/
theorem solution : ∀ k : ℕ, ∀ n : ℕ, 2 * k + 3 ≤ n →
    ∀ G : SimpleGraph (Fin n),
      (n - k - 1).choose 2 + (k + 2).choose 2 + 1 ≤ G.edgeFinset.card →
        ∃ (v : Fin n) (p : G.Walk v v), p.IsCycle ∧ p.length = n - k := by
  intro k n hn G hedges
  exact all_lengths hn G hedges (n - k) (by omega) le_rfl

#print axioms solution
#print axioms all_lengths

end JSP000842
