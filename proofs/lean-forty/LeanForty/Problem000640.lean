import ErdosProblems.Erdos780

/-! JSP-000640 / Erdős 780: the Alon–Frankl–Lovász matching theorem.
The proof is the pinned public plby formalization. The adapter exposes the
matching as actual finite subsets and explicitly proves distinctness. -/

namespace LeanForty.Problem000640

theorem monochromatic_matching {n k r t : ℕ} (hr : 1 ≤ r) (ht : 1 ≤ t)
    (hn : k * r + (t - 1) * (k - 1) ≤ n)
    (c : Erdos780.Edge n r → Fin t) : Erdos780.HasMonoMatching c k :=
  Erdos780.erdos_780 hr ht hn c

/-- All selected edges have exactly r vertices, are pairwise disjoint,
have the same color, and are distinct. No restriction to fixed parameters. -/
theorem distinct_monochromatic_edges {n k r t : ℕ} (hr : 1 ≤ r) (ht : 1 ≤ t)
    (hn : k * r + (t - 1) * (k - 1) ≤ n)
    (c : Erdos780.Edge n r → Fin t) :
    ∃ color : Fin t, ∃ e : Fin k → Erdos780.Edge n r,
      Function.Injective e ∧ (∀ i, c (e i) = color) ∧
      (∀ i, (e i).1.card = r) ∧
      ∀ i j : Fin k, i ≠ j → Disjoint (e i).1 (e j).1 := by
  obtain ⟨color, e, hmono, hdisj⟩ := monochromatic_matching hr ht hn c
  refine ⟨color, e, ?_, hmono, fun i => (e i).2, hdisj⟩
  intro i j hij
  by_contra hne
  have hd := hdisj i j hne
  rw [hij] at hd
  have hempty : (e j).1 = ∅ := by simpa using hd
  have hcard := (e j).2
  rw [hempty, Finset.card_empty] at hcard
  omega

end LeanForty.Problem000640
