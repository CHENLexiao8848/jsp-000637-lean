import Mathlib.FieldTheory.Finite.GaloisField
import Mathlib.Tactic

/-! Finite fields of order 11^(2k+1) for the parabola construction. -/
namespace Jsp.Graph139Fields
noncomputable section
attribute [local instance] Classical.propDecidable

instance : Fact (Nat.Prime 11) := ⟨by norm_num⟩

abbrev FieldAt (k : ℕ) := GaloisField 11 (2*k+1)
instance (k : ℕ) : Fintype (FieldAt k) := Fintype.ofFinite _

theorem card_field (k : ℕ) : Fintype.card (FieldAt k) = 11^(2*k+1) := by
  rw [← Nat.card_eq_fintype_card]
  exact GaloisField.card 11 (2*k+1) (by omega)

theorem cardinal_mod_three (k : ℕ) : 11^(2*k+1) % 3 = 2 := by
  rw [pow_add, pow_mul, pow_one, Nat.mul_mod, Nat.pow_mod]
  norm_num

theorem cardinal_mod_four (k : ℕ) : 11^(2*k+1) % 4 = 3 := by
  rw [pow_add, pow_mul, pow_one, Nat.mul_mod, Nat.pow_mod]
  norm_num

variable {K : Type*} [Field K] [Fintype K]

theorem cube_root_eq_one (hcard : Fintype.card K % 3 = 2) (t : K)
    (ht : t^3=1) : t=1 := by
  have ht0 : t ≠ 0 := by intro h; simp [h] at ht
  have hq := FiniteField.pow_card t
  have hdecomp : Fintype.card K = 3*(Fintype.card K / 3)+2 := by omega
  rw [hdecomp, pow_add, pow_mul, ht, one_pow, one_mul] at hq
  have hm : t * (t-1) = 0 := by linear_combination hq
  exact sub_eq_zero.mp ((mul_eq_zero.mp hm).resolve_left ht0)

theorem quadratic_zero (hcard : Fintype.card K % 3 = 2) (h3 : (3:K) ≠ 0)
    (x y : K) (h : x^2+x*y+y^2=0) : x=0 ∧ y=0 := by
  by_cases hy : y=0
  · subst y
    simp only [mul_zero, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, add_zero] at h
    exact ⟨(pow_eq_zero_iff (by decide : 2 ≠ 0)).mp h, rfl⟩
  · have ht : (x/y)^2+x/y+1=0 := by
      field_simp
      linear_combination h
    have hp : (x/y)^3=1 := by linear_combination (x/y-1)*ht
    have he := cube_root_eq_one hcard (x/y) hp
    rw [he] at ht
    norm_num at ht
    exact (h3 ht).elim

theorem square_or_neg_square (hc : ringChar K ≠ 2)
    (hcard : Fintype.card K % 4 = 3) (b : K) : IsSquare b ∨ IsSquare (-b) := by
  by_cases hb : b=0
  · simp [hb]
  have hodd : Odd (Fintype.card K / 2) := by
    apply Nat.odd_iff.mpr
    omega
  rcases FiniteField.pow_dichotomy hc hb with hp | hp
  · exact Or.inl ((FiniteField.isSquare_iff hc hb).mpr hp)
  · right
    apply (FiniteField.isSquare_iff hc (neg_ne_zero.mpr hb)).mpr
    rw [neg_pow, hodd.neg_one_pow, hp]
    simp

theorem two_ne_zero (k : ℕ) : (2 : FieldAt k) ≠ 0 := by
  exact (CharP.cast_eq_zero_iff (FieldAt k) 11 2).not.mpr (by decide)

theorem three_ne_zero (k : ℕ) : (3 : FieldAt k) ≠ 0 := by
  exact (CharP.cast_eq_zero_iff (FieldAt k) 11 3).not.mpr (by decide)

theorem field_quadratic_zero (k : ℕ) (x y : FieldAt k) :
    x^2+x*y+y^2=0 → x=0 ∧ y=0 :=
  quadratic_zero (by rw [card_field]; exact cardinal_mod_three k) (three_ne_zero k) x y

theorem field_square_or_neg_square (k : ℕ) (b : FieldAt k) :
    IsSquare b ∨ IsSquare (-b) := by
  apply square_or_neg_square ?_ ?_ b
  · rw [ringChar.eq (FieldAt k) 11]
    decide
  · rw [card_field]
    exact cardinal_mod_four k

end
end Jsp.Graph139Fields
