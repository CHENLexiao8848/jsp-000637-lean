import Mathlib.NumberTheory.Chebyshev
import Mathlib.Tactic

/-! A polynomial bound sufficient for the complete Erdős808 counterexample.
Only Chebyshev's elementary prime-counting estimate is used. -/

namespace LeanForty

theorem prime_block_le_seventh {q : ℕ} (hq : 64 ≤ q) (i : Fin q) :
    Nat.nth Nat.Prime (q ^ 2 + i) ≤ q ^ 7 := by
  have hqR : (64 : ℝ) ≤ q := by exact_mod_cast hq
  have hqpos : (0 : ℝ) < q := by linarith
  have hq1 : (1 : ℝ) ≤ q := by linarith
  have hx : (1 : ℝ) < (q : ℝ) ^ 7 := by nlinarith [pow_le_pow_right₀ hq1 (show 1 ≤ 7 by norm_num)]
  have hlogpos : 0 < Real.log ((q : ℝ) ^ 7) := Real.log_pos hx
  have hlog2 : (1 / 2 : ℝ) ≤ Real.log 2 := by
    have h := Real.one_sub_inv_le_log_of_pos (by norm_num : (0 : ℝ) < 2)
    norm_num at h ⊢
    exact h
  have hlogq : Real.log (q : ℝ) ≤ q := Real.log_le_self hqpos.le
  have hlogx : Real.log ((q : ℝ) ^ 7) ≤ 7 * q := by
    rw [Real.log_pow]
    norm_num
    linarith
  have hlogxp : Real.log ((q : ℝ) ^ 7 + 1) ≤ 1 + 7 * q := by
    have hmul : (q : ℝ) ^ 7 + 1 ≤ 2 * (q : ℝ) ^ 7 := by linarith
    have hmono := Real.log_le_log (by positivity : (0 : ℝ) < (q : ℝ) ^ 7 + 1) hmul
    rw [Real.log_mul (by norm_num) (by positivity)] at hmono
    have htwo : Real.log (2 : ℝ) ≤ 1 := by
      have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
      norm_num at h
      exact h
    linarith
  have hpi := Chebyshev.pi_ge (q ^ 7)
  norm_num only [Nat.cast_pow, Nat.cast_add, Nat.cast_one] at hpi
  have hpi' := (div_le_iff₀ hlogpos).mp hpi
  have hpi0 : (0 : ℝ) ≤ Nat.primeCounting (q ^ 7) := by positivity
  have hmul := mul_le_mul_of_nonneg_left hlogx hpi0
  have hhalf := mul_le_mul_of_nonneg_left hlog2 (show 0 ≤ (q : ℝ) ^ 7 by positivity)
  have hpow : (q : ℝ) ^ 4 ≤ (q : ℝ) ^ 7 := pow_le_pow_right₀ hq1 (by norm_num)
  have hq2 : (64 : ℝ) * q ≤ (q : ℝ) ^ 2 := by nlinarith
  have hq3 : (64 : ℝ) * (q : ℝ) ^ 2 ≤ (q : ℝ) ^ 3 := by nlinarith
  have hq4 : (64 : ℝ) * (q : ℝ) ^ 3 ≤ (q : ℝ) ^ 4 := by nlinarith
  have hcount : q ^ 2 + q < Nat.primeCounting (q ^ 7) := by
    by_contra h
    have h' : (Nat.primeCounting (q ^ 7) : ℝ) ≤ (q : ℝ) ^ 2 + q := by exact_mod_cast (le_of_not_gt h)
    have hbound := mul_le_mul_of_nonneg_right h' (show (0 : ℝ) ≤ 7 * q by positivity)
    nlinarith
  have hi : (i : ℕ) < q := i.isLt
  have hidx : q ^ 2 + (i : ℕ) < Nat.primeCounting (q ^ 7) := by omega
  have hlt : Nat.nth Nat.Prime (q ^ 2 + i) < q ^ 7 + 1 :=
    (Nat.lt_nth_iff_count_lt Nat.infinite_setOfPred_prime).mp hidx
  omega

theorem prime_block_le_seventh_eventually :
    ∀ᶠ q : ℕ in Filter.atTop, ∀ i : Fin q, Nat.nth Nat.Prime (q ^ 2 + i) ≤ q ^ 7 :=
  Filter.eventually_atTop.mpr ⟨64, fun q hq => prime_block_le_seventh hq⟩

end LeanForty
