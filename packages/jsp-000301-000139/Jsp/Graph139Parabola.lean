import Jsp.Graph139

/-! Symmetric complete sum-free sets from a parabola over a finite field. -/

namespace Jsp.Graph139Parabola

noncomputable section
open Finset Jsp.Graph139
attribute [local instance] Classical.propDecidable

variable {K : Type*} [Field K] [Fintype K]

def parabolaSet : Finset (K × K) :=
  (univ.image fun x : K => (x, x ^ 2)) ∪ (univ.image fun x : K => (x, -(x ^ 2))) |>.erase 0

theorem mem_parabolaSet (z : K × K) :
    z ∈ parabolaSet ↔ z.1 ≠ 0 ∧ (z.2 = z.1 ^ 2 ∨ z.2 = -(z.1 ^ 2)) := by
  rcases z with ⟨a, b⟩
  simp only [parabolaSet, mem_erase, mem_union, mem_image, mem_univ, true_and,
    Prod.mk.injEq]
  constructor
  · rintro ⟨hz, (⟨x, rfl, rfl⟩ | ⟨x, rfl, rfl⟩)⟩ <;>
      constructor
    · intro h; simp [h] at hz
    · exact Or.inl rfl
    · intro h; simp [h] at hz
    · exact Or.inr rfl
  · rintro ⟨ha, hb⟩
    refine ⟨by simpa using fun h : a = 0 ∧ b = 0 => ha h.1, ?_⟩
    rcases hb with hb | hb
    · exact Or.inl ⟨a, rfl, hb.symm⟩
    · exact Or.inr ⟨a, rfl, hb.symm⟩

theorem parabola_neg_mem (z : K × K) (hz : z ∈ parabolaSet) : -z ∈ parabolaSet := by
  rw [mem_parabolaSet] at hz ⊢
  refine ⟨neg_ne_zero.mpr hz.1, ?_⟩
  rcases hz.2 with h | h
  · right; simp [h]
  · left; simp [h]

theorem parabola_card : (parabolaSet (K := K)).card ≤ 2 * Fintype.card K := by
  apply card_erase_le.trans
  exact (card_union_le _ _).trans (by
    have h1 := card_image_le (s := (univ : Finset K)) (f := fun x : K => (x,x^2))
    have h2 := card_image_le (s := (univ : Finset K)) (f := fun x : K => (x,-(x^2)))
    simpa [two_mul] using Nat.add_le_add h1 h2)

variable (h2 : (2 : K) ≠ 0)
    (hquad : ∀ x y : K, x ^ 2 + x * y + y ^ 2 = 0 → x = 0 ∧ y = 0)
include h2

omit [Fintype K] in
private theorem cancel_two {x : K} (h : 2 * x = 0) : x = 0 :=
  (mul_eq_zero.mp h).resolve_left h2

include hquad in
theorem parabola_sum_free (u : K × K) (hu : u ∈ parabolaSet)
    (v : K × K) (hv : v ∈ parabolaSet) : u + v ∉ parabolaSet := by
  intro hw
  rw [mem_parabolaSet] at hu hv hw
  rcases u with ⟨a,b⟩
  rcases v with ⟨c,d⟩
  change a + c ≠ 0 ∧ (b + d = (a + c) ^ 2 ∨ b + d = -((a + c) ^ 2)) at hw
  rcases hu with ⟨ha, hb | hb⟩ <;> rcases hv with ⟨hc, hd | hd⟩ <;>
    rcases hw with ⟨hac, he | he⟩
  · have h : 2 * (a*c) = 0 := by linear_combination hb + hd - he
    exact (mul_ne_zero ha hc) (cancel_two h2 h)
  · have h : 2 * (a^2+a*c+c^2) = 0 := by linear_combination he - hb - hd
    exact ha (hquad a c (cancel_two h2 h)).1
  · have h : 2 * (c*(a+c)) = 0 := by linear_combination hb + hd - he
    exact (mul_ne_zero hc hac) (cancel_two h2 h)
  · have h : 2 * (a*(a+c)) = 0 := by linear_combination he - hb - hd
    exact (mul_ne_zero ha hac) (cancel_two h2 h)
  · have h : 2 * (a*(a+c)) = 0 := by linear_combination hb + hd - he
    exact (mul_ne_zero ha hac) (cancel_two h2 h)
  · have h : 2 * (c*(a+c)) = 0 := by linear_combination he - hb - hd
    exact (mul_ne_zero hc hac) (cancel_two h2 h)
  · have h : 2 * (a^2+a*c+c^2) = 0 := by linear_combination hb + hd - he
    exact ha (hquad a c (cancel_two h2 h)).1
  · have h : 2 * (a*c) = 0 := by linear_combination he - hb - hd
    exact (mul_ne_zero ha hc) (cancel_two h2 h)

theorem parabola_complete (hsq : ∀ b : K, IsSquare b ∨ IsSquare (-b)) (z : K × K) :
    z ∈ parabolaSet ∨ ∃ u ∈ parabolaSet, ∃ v ∈ parabolaSet, u + v = z := by
  rcases z with ⟨a,b⟩
  by_cases ha : a = 0
  · subst a
    right
    by_cases hb : b = 0
    · subst b
      refine ⟨(1,1), ?_, (-1,-1), ?_, ?_⟩
      · simp [mem_parabolaSet]
      · simp [mem_parabolaSet]
      · ext <;> simp
    · rcases hsq (b/2) with ⟨t,ht⟩ | ⟨t,ht⟩
      · have ht0 : t ≠ 0 := by
          intro h; simp [h, h2] at ht; exact hb ht
        refine ⟨(t,t^2), by simp [mem_parabolaSet, ht0],
          (-t,t^2), by simp [mem_parabolaSet, ht0], ?_⟩
        ext
        · simp
        · dsimp
          have hh : b = t * t * 2 := (div_eq_iff h2).mp ht
          linear_combination -hh
      · have ht0 : t ≠ 0 := by
          intro h; simp [h, h2] at ht; exact hb ht
        refine ⟨(t,-(t^2)), by simp [mem_parabolaSet, ht0],
          (-t,-(t^2)), by simp [mem_parabolaSet, ht0], ?_⟩
        ext
        · simp
        · dsimp
          have hd : b / 2 = -(t*t) := (neg_eq_iff_eq_neg).mp ht
          have hh : b = -(t*t) * 2 := (div_eq_iff h2).mp hd
          linear_combination -hh
  · let x := (b/a+a)/2
    let y := a-x
    have hxy : x ^ 2 - y ^ 2 = b := by
      dsimp [x,y]
      have h4 : (4 : K) ≠ 0 := by
        convert mul_ne_zero h2 h2 using 1
        norm_num
      field_simp [ha, h2, h4]
      ring
    by_cases hx : x = 0
    · left
      rw [mem_parabolaSet]
      refine ⟨ha, Or.inr ?_⟩
      simpa [hx,y] using hxy.symm
    by_cases hy : y = 0
    · left
      rw [mem_parabolaSet]
      refine ⟨ha, Or.inl ?_⟩
      have hxa : x = a := by dsimp [y] at hy; linear_combination -hy
      simpa [hy,hxa] using hxy.symm
    · right
      refine ⟨(x,x^2), by simp [mem_parabolaSet,hx],
        (y,-(y^2)), by simp [mem_parabolaSet,hy], ?_⟩
      ext
      · dsimp [y]; ring
      · simpa only [Prod.snd_add, sub_eq_add_neg] using hxy

include hquad in
theorem parabola_properties (hsq : ∀ b : K, IsSquare b ∨ IsSquare (-b)) :
    SymmetricCompleteSumFree (parabolaSet (K := K)) :=
  ⟨parabola_neg_mem, parabola_sum_free h2 hquad, parabola_complete h2 hsq⟩

end
end Jsp.Graph139Parabola
