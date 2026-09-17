import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic

/-!
# JSP-000301

The scoped yes/no question has a negative answer: 12167 and 12168 are
consecutive positive powerful numbers and neither is a square.
A positive integer is powerful when the square of every prime divisor divides it.
Source: https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000301
-/

namespace Jsp.Powerful301

def Powerful (n : ℕ) : Prop :=
  0 < n ∧ ∀ p : ℕ, p.Prime → p ∣ n → p ^ 2 ∣ n

theorem powerful_12167 : Powerful 12167 := by
  refine ⟨by norm_num, ?_⟩
  intro p hp hd
  have hpow : p ∣ 23 ^ 3 := by norm_num at *; exact hd
  have heq : p = 23 :=
    (Nat.prime_dvd_prime_iff_eq hp (by norm_num)).mp (hp.dvd_of_dvd_pow hpow)
  subst p
  norm_num

theorem powerful_12168 : Powerful 12168 := by
  refine ⟨by norm_num, ?_⟩
  intro p hp hd
  have hprod : p ∣ (2 ^ 3 * 3 ^ 2) * 13 ^ 2 := by norm_num at *; exact hd
  rcases hp.dvd_or_dvd hprod with h23 | h13
  · rcases hp.dvd_or_dvd h23 with h2 | h3
    · have heq : p = 2 :=
        (Nat.prime_dvd_prime_iff_eq hp (by norm_num)).mp (hp.dvd_of_dvd_pow h2)
      subst p
      norm_num
    · have heq : p = 3 :=
        (Nat.prime_dvd_prime_iff_eq hp (by norm_num)).mp (hp.dvd_of_dvd_pow h3)
      subst p
      norm_num
  · have heq : p = 13 :=
      (Nat.prime_dvd_prime_iff_eq hp (by norm_num)).mp (hp.dvd_of_dvd_pow h13)
    subst p
    norm_num

private theorem not_isSquare_between {n : ℕ} (hlo : 110 ^ 2 < n)
    (hhi : n < 111 ^ 2) : ¬ IsSquare n := by
  rintro ⟨k, hk⟩
  by_cases h : k ≤ 110
  · nlinarith
  · have h' : 111 ≤ k := by omega
    nlinarith

theorem not_isSquare_12167 : ¬ IsSquare (12167 : ℕ) :=
  not_isSquare_between (by norm_num) (by norm_num)

theorem not_isSquare_12168 : ¬ IsSquare (12168 : ℕ) :=
  not_isSquare_between (by norm_num) (by norm_num)

/-- A counterexample with all the conditions of the scoped question. -/
theorem counterexample :
    ∃ n : ℕ, Powerful n ∧ Powerful (n + 1) ∧ ¬ IsSquare n ∧ ¬ IsSquare (n + 1) := by
  exact ⟨12167, powerful_12167, powerful_12168, not_isSquare_12167, not_isSquare_12168⟩

/-- Therefore the proposed universal statement is false. -/
theorem answer :
    ¬ (∀ n : ℕ, Powerful n → Powerful (n + 1) → IsSquare n ∨ IsSquare (n + 1)) := by
  intro h
  rcases h 12167 powerful_12167 powerful_12168 with h1 | h2
  · exact not_isSquare_12167 h1
  · exact not_isSquare_12168 h2

end Jsp.Powerful301
