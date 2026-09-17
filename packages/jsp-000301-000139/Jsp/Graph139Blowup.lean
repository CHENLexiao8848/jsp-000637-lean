import Jsp.Graph139
import Mathlib.Data.Nat.Log

/-!
# Bounded blow-ups for the degree/diameter construction

A surjective map from `Fin n` to `Fin m` with fibers of size at most `c`
transfers triangle-freeness and diameter two, multiplying maximum degree by at most `c`.
-/

namespace Jsp.Graph139Blowup

noncomputable section
attribute [local instance] Classical.propDecidable

open SimpleGraph Jsp.Graph139

theorem exists_neighbor_of_diameter {V : Type*} [Nontrivial V]
    (G : SimpleGraph V) (hd : DiameterAtMostTwo G) (v : V) :
    ∃ w, G.Adj v w := by
  obtain ⟨w, hw⟩ := exists_ne v
  rcases hd v w with he | ha | ⟨u, hu, _⟩
  · exact (hw he.symm).elim
  · exact ⟨w, ha⟩
  · exact ⟨u, hu⟩

def projection {m n : ℕ} (hm : 0 < m) (v : Fin n) : Fin m :=
  ⟨v.val % m, Nat.mod_lt _ hm⟩

theorem projection_surjective {m n : ℕ} (hm : 0 < m) (hmn : m ≤ n) :
    Function.Surjective (projection (n := n) hm) := by
  intro v
  refine ⟨⟨v.val, lt_of_lt_of_le v.isLt hmn⟩, ?_⟩
  apply Fin.ext
  exact Nat.mod_eq_of_lt v.isLt

theorem blowup_triangle_free {V W : Type*} {G : SimpleGraph V}
    (ht : G.CliqueFree 3) (f : W → V) :
    (G.comap f).CliqueFree 3 := by
  intro s hs
  obtain ⟨a, b, c, hab, hac, hbc, _⟩ := SimpleGraph.is3Clique_iff.mp hs
  exact ht {f a, f b, f c} (SimpleGraph.is3Clique_triple_iff.mpr ⟨hab, hac, hbc⟩)

theorem blowup_diameter {V W : Type*} {G : SimpleGraph V}
    (hd : DiameterAtMostTwo G) (hne : ∀ v, ∃ w, G.Adj v w)
    (f : W → V) (hf : Function.Surjective f) :
    DiameterAtMostTwo (G.comap f) := by
  intro v w
  by_cases he : v = w
  · exact Or.inl he
  rcases hd (f v) (f w) with heq | ha | ⟨u, hvu, huw⟩
  · obtain ⟨u, hu⟩ := hne (f v)
    obtain ⟨z, hz⟩ := hf u
    right; right
    refine ⟨z, ?_, ?_⟩
    · change G.Adj (f v) (f z)
      simpa [hz] using hu
    · change G.Adj (f z) (f w)
      simpa [hz, ← heq] using hu.symm
  · exact Or.inr (Or.inl ha)
  · obtain ⟨z, hz⟩ := hf u
    right; right
    exact ⟨z, by simpa [hz] using hvu, by simpa [hz] using huw⟩

theorem blowup_degree {m n c : ℕ} (hm : 0 < m) (hn : n ≤ m * c)
    (G : SimpleGraph (Fin m)) (v : Fin n) :
    (G.comap (projection hm)).degree v ≤ c * G.degree (projection hm v) := by
  classical
  let f := projection (n := n) hm
  let H := G.comap f
  let encode : H.neighborSet v → G.neighborSet (f v) × Fin c :=
    fun w => (⟨f w.val, w.property⟩,
      ⟨w.val.val / m, (Nat.div_lt_iff_lt_mul hm).mpr
        (lt_of_lt_of_le w.val.isLt (by simpa [mul_comm] using hn))⟩)
  have hinj : Function.Injective encode := by
    intro x y h
    have hr : x.val.val % m = y.val.val % m :=
      congrArg (fun z : G.neighborSet (f v) × Fin c => z.1.val.val) h
    have hq : x.val.val / m = y.val.val / m :=
      congrArg (fun z : G.neighborSet (f v) × Fin c => z.2.val) h
    apply Subtype.ext
    apply Fin.ext
    have hx := Nat.mod_add_div x.val.val m
    have hy := Nat.mod_add_div y.val.val m
    rw [hr, hq] at hx
    exact hx.symm.trans hy
  have hc := Fintype.card_le_of_injective encode hinj
  simpa [Fintype.card_prod, G.card_neighborSet_eq_degree,
    H.card_neighborSet_eq_degree, mul_comm, H, f] using hc

theorem blowup_maxDegree {m n c : ℕ} (hm : 0 < m) (hn : n ≤ m * c)
    (G : SimpleGraph (Fin m)) :
    (G.comap (projection (n := n) hm)).maxDegree ≤ c * G.maxDegree := by
  classical
  apply SimpleGraph.maxDegree_le_of_forall_degree_le
  intro v
  exact (blowup_degree hm hn G v).trans (Nat.mul_le_mul_left c (G.degree_le_maxDegree _))

/-- Transfer a graph to every larger order up to a fixed multiple. -/
theorem exists_blowup {m n c : ℕ} (hm : 2 ≤ m) (hmn : m ≤ n) (hn : n ≤ m * c)
    (G : SimpleGraph (Fin m)) (ht : G.CliqueFree 3) (hd : G.ediam ≤ 2) :
    ∃ H : SimpleGraph (Fin n), H.CliqueFree 3 ∧ H.ediam ≤ 2 ∧
      H.maxDegree ≤ c * G.maxDegree := by
  classical
  have hm0 : 0 < m := by omega
  have : Nontrivial (Fin m) := Fin.nontrivial_iff_two_le.mpr hm
  have hdiam := (diameterAtMostTwo_iff_ediam_le_two G).mpr hd
  refine ⟨G.comap (projection hm0), blowup_triangle_free ht _, ?_, blowup_maxDegree hm0 hn G⟩
  apply (diameterAtMostTwo_iff_ediam_le_two _).mp
  exact blowup_diameter hdiam (exists_neighbor_of_diameter G hdiam) _
    (projection_surjective hm0 hmn)

end
end Jsp.Graph139Blowup
