import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Combinatorics.SimpleGraph.Clique
import Mathlib.Combinatorics.SimpleGraph.Diam
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

/-!
# JSP-000139: lower bound and Cayley graph construction bridge

The official question asks for the asymptotic minimum maximum degree among
triangle-free graphs of diameter at most two. Its known answer is Theta(sqrt n).
This module proves the universal Moore lower bound, n <= Delta^2 + 1, using the
standard Mathlib graph, degree, and extended-diameter definitions. It applies
even without the triangle-free hypothesis. The constructive upper bound and
complete asymptotic answer are proved in `Jsp.Graph139Upper`.

Sources:
* https://www.erdosproblems.com/133
* https://web.math.princeton.edu/~nalon/PDFS/remark1901.pdf
-/

namespace Jsp.Graph139

open Finset SimpleGraph

variable {V : Type*} (G : SimpleGraph V)

/-- A direct, connectivity-safe formulation of diameter at most two. -/
def DiameterAtMostTwo : Prop :=
  ∀ v w, v = w ∨ G.Adj v w ∨ ∃ u, G.Adj v u ∧ G.Adj u w

/-- The combinatorial formulation agrees with Mathlib's extended diameter. -/
theorem diameterAtMostTwo_iff_ediam_le_two :
    DiameterAtMostTwo G ↔ G.ediam ≤ 2 := by
  rw [SimpleGraph.ediam_le_iff]
  constructor
  · intro h v w
    apply le_of_not_gt
    intro hd
    obtain ⟨hn, ha, hc⟩ := SimpleGraph.two_lt_edist_iff.mp hd
    rcases h v w with he | ha' | ⟨u, hvu, huw⟩
    · exact hn he
    · exact ha ha'
    · have hu : u ∈ G.commonNeighbors v w := ⟨hvu, huw.symm⟩
      simp [hc] at hu
  · intro h v w
    by_cases he : v = w
    · exact Or.inl he
    by_cases ha : G.Adj v w
    · exact Or.inr (Or.inl ha)
    right; right
    have hc : (G.commonNeighbors v w).Nonempty := by
      by_contra hn
      have hz : G.commonNeighbors v w = ∅ := Set.not_nonempty_iff_eq_empty.mp hn
      exact (not_lt_of_ge (h v w)) (SimpleGraph.two_lt_edist_iff.mpr ⟨he, ha, hz⟩)
    obtain ⟨u, hu⟩ := hc
    exact ⟨u, hu.1, hu.2.symm⟩

variable [Fintype V] [DecidableEq V] [DecidableRel G.Adj]

/-- Count all vertices by their distance-zero, one, and two positions from v. -/
theorem card_le_one_add_degree_mul (h : DiameterAtMostTwo G) (v : V) :
    Fintype.card V ≤ 1 + G.degree v + G.degree v * (G.maxDegree - 1) := by
  let second := (G.neighborFinset v).biUnion (fun w => (G.neighborFinset w).erase v)
  have hcover : (univ : Finset V) ⊆ ({v} ∪ G.neighborFinset v) ∪ second := by
    intro w _
    by_cases hw : w = v
    · simp [hw]
    rcases h v w with he | ha | ⟨u, hvu, huw⟩
    · exact (hw he.symm).elim
    · exact mem_union_left _ (mem_union_right _ ((G.mem_neighborFinset v w).mpr ha))
    · apply mem_union_right
      apply mem_biUnion.mpr
      exact ⟨u, (G.mem_neighborFinset v u).mpr hvu,
        mem_erase.mpr ⟨hw, (G.mem_neighborFinset u w).mpr huw⟩⟩
  have hsecond : second.card ≤ G.degree v * (G.maxDegree - 1) := by
    apply (card_biUnion_le_card_mul _ _ (G.maxDegree - 1) ?_)
    intro w hw
    have hv : v ∈ G.neighborFinset w :=
      (G.mem_neighborFinset w v).mpr ((G.mem_neighborFinset v w).mp hw).symm
    rw [card_erase_of_mem hv, G.card_neighborFinset_eq_degree]
    exact Nat.sub_le_sub_right (G.degree_le_maxDegree w) 1
  calc
    Fintype.card V = (univ : Finset V).card := (card_univ).symm
    _ ≤ (({v} ∪ G.neighborFinset v) ∪ second).card := card_le_card hcover
    _ ≤ ({v} ∪ G.neighborFinset v).card + second.card := card_union_le _ _
    _ ≤ (({v} : Finset V).card + (G.neighborFinset v).card) + second.card :=
      Nat.add_le_add_right (card_union_le _ _) _
    _ ≤ 1 + G.degree v + G.degree v * (G.maxDegree - 1) := by
      simpa using Nat.add_le_add_left hsecond (1 + G.degree v)

/-- Moore bound: every finite graph of diameter at most two has n <= Delta² + 1. -/
theorem moore_bound (h : DiameterAtMostTwo G) :
    Fintype.card V ≤ G.maxDegree ^ 2 + 1 := by
  cases isEmpty_or_nonempty V with
  | inl hi => simp
  | inr hn =>
    let v : V := Classical.choice hn
    have hc := card_le_one_add_degree_mul G h v
    have hd := G.degree_le_maxDegree v
    by_cases hz : G.maxDegree = 0
    · simp only [hz, Nat.zero_sub, mul_zero, add_zero] at hc
      simp only [hz] at hd
      have hv : G.degree v = 0 := Nat.eq_zero_of_le_zero hd
      simpa [hz, hv] using hc
    · have hs : G.maxDegree - 1 + 1 = G.maxDegree := Nat.sub_add_cancel (by omega)
      have hm := Nat.mul_le_mul_right (G.maxDegree - 1) hd
      nlinarith

/-- The same Moore bound stated directly with Mathlib's extended diameter. -/
theorem moore_bound_of_ediam_le_two (h : G.ediam ≤ 2) :
    Fintype.card V ≤ G.maxDegree ^ 2 + 1 :=
  moore_bound G ((diameterAtMostTwo_iff_ediam_le_two G).mpr h)




/-! ## Reduction of the upper bound to small complete sum-free sets -/

section Cayley

variable {A : Type*} [AddCommGroup A] [Fintype A] [DecidableEq A]

/-- Precisely the additive-combinatorics input used by the known constructions. -/
structure SymmetricCompleteSumFree (S : Finset A) : Prop where
  neg_mem : ∀ x ∈ S, -x ∈ S
  sum_free : ∀ x ∈ S, ∀ y ∈ S, x + y ∉ S
  complete : ∀ z : A, z ∈ S ∨ ∃ x ∈ S, ∃ y ∈ S, x + y = z

variable (S : Finset A) (hS : SymmetricCompleteSumFree S)
include hS

omit [Fintype A] [DecidableEq A] in
theorem zero_not_mem : (0 : A) ∉ S := by
  intro h
  exact hS.sum_free 0 h 0 h (by simpa using h)

-- Symmetry and sum-freeness remove the redundant orientation and loop guards.
omit [Fintype A] [DecidableEq A] in
theorem addCayley_adj_iff (u v : A) :
    (SimpleGraph.addCayley (S : Set A)).Adj u v ↔ v - u ∈ S := by
  rw [SimpleGraph.addCayley_adj]
  constructor
  · rintro ⟨_, hv | hu⟩
    · simpa [sub_eq_add_neg, add_comm] using hv
    · have hh := hS.neg_mem _ hu
      simpa [sub_eq_add_neg, add_comm] using hh
  · intro hv
    constructor
    · intro he
      subst v
      exact zero_not_mem S hS (by simpa using hv)
    · left
      simpa [sub_eq_add_neg, add_comm] using hv

omit [Fintype A] in
/-- A sum-free symmetric generating set gives a triangle-free graph. -/
theorem addCayley_triangle_free :
    (SimpleGraph.addCayley (S : Set A)).CliqueFree 3 := by
  intro s hs
  obtain ⟨a, b, c, hab, hac, hbc, _⟩ := SimpleGraph.is3Clique_iff.mp hs
  rw [addCayley_adj_iff S hS] at hab hac hbc
  have hn := hS.sum_free (b - a) hab (c - b) hbc
  apply hn
  convert hac using 1; abel

omit [Fintype A] [DecidableEq A] in
/-- Completeness of the generating set puts every vertex within two edges. -/
theorem addCayley_diameter_at_most_two :
    DiameterAtMostTwo (SimpleGraph.addCayley (S : Set A)) := by
  intro u v
  rcases hS.complete (v - u) with hv | ⟨x, hx, y, hy, hxy⟩
  · exact Or.inr (Or.inl ((addCayley_adj_iff S hS u v).mpr hv))
  · right; right
    refine ⟨u + x, (addCayley_adj_iff S hS u (u + x)).mpr ?_,
      (addCayley_adj_iff S hS (u + x) v).mpr ?_⟩
    · simpa using hx
    · have he : v - (u + x) = y := by
        calc
          v - (u + x) = (v - u) - x := by abel
          _ = (x + y) - x := by rw [hxy]
          _ = y := by abel
      simpa [he] using hy

/-- Each neighborhood is a translate of S, so the degree is exactly |S|. -/
theorem addCayley_degree (v : A) :
    (SimpleGraph.addCayley (S : Set A)).degree v = S.card := by
  let H := SimpleGraph.addCayley (S : Set A)
  have hn : H.neighborFinset v = S.image (v + ·) := by
    ext w
    rw [SimpleGraph.mem_neighborFinset, addCayley_adj_iff S hS]
    constructor
    · intro hw
      exact mem_image.mpr ⟨w - v, hw, by abel⟩
    · rintro hw
      obtain ⟨x, hx, rfl⟩ := mem_image.mp hw
      simpa using hx
  change (H.neighborFinset v).card = S.card
  rw [hn, card_image_of_injective]
  exact fun _ _ hh => add_left_cancel hh

/-- Exact degree, triangle-freeness, and standard extended diameter together. -/
theorem addCayley_properties :
    (SimpleGraph.addCayley (S : Set A)).CliqueFree 3 ∧
    (SimpleGraph.addCayley (S : Set A)).ediam ≤ 2 ∧
    (SimpleGraph.addCayley (S : Set A)).maxDegree = S.card := by
  refine ⟨addCayley_triangle_free S hS,
    (diameterAtMostTwo_iff_ediam_le_two _).mp (addCayley_diameter_at_most_two S hS), ?_⟩
  apply le_antisymm
  · exact SimpleGraph.maxDegree_le_of_forall_degree_le _ _
      (fun v => le_of_eq (addCayley_degree S hS v))
  · have hd := (SimpleGraph.addCayley (S : Set A)).degree_le_maxDegree (0 : A)
    simpa only [addCayley_degree S hS] using hd

end Cayley

end Jsp.Graph139





