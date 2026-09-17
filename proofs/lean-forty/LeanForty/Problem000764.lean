import ErdosProblems.Erdos920

/-! JSP-000764 / Erdős920: a uniform-in-order lower estimate for the
maximum chromatic number of K_k-free n-vertex graphs, for every k≥4. -/

namespace LeanForty.Problem000764

open Filter

theorem chromatic_lower_bound (k : ℕ) (hk : 4 ≤ k) :
    ∃ c : ℝ, 0 < c ∧
      (fun n : ℕ => (n : ℝ) ^ (1 - 1 / ((k : ℝ) - 1)) / Real.log n ^ c)
        =O[atTop] (fun n : ℕ => (Erdos920.f k n : ℝ)) := by
  obtain ⟨c, hc, hbound⟩ := Erdos920.erdos_920 k hk
  refine ⟨(c : ℝ), by exact_mod_cast hc, ?_⟩
  simpa only [Real.rpow_natCast] using hbound

/-- The construction actually gives the fixed logarithmic loss exponent two. -/
theorem logarithmic_exponent_two (k : ℕ) (hk : 4 ≤ k) :
    (fun n : ℕ => (n : ℝ) ^ (1 - 1 / ((k : ℝ) - 1)) / Real.log n ^ 2)
      =O[atTop] (fun n : ℕ => (Erdos920.f k n : ℝ)) := by
  obtain ⟨A, hA, hRamsey⟩ :=
    Erdos920.RamseyPackaging.bradac_ramsey_lower_bound_eventually_of_package k
      (by omega) (Erdos920.Construction.dStarFamily (k - 2) (by omega))
  exact Erdos920.Inversion.isBigO_problem920_of_eventual_ramsey_lower_bound
    k (by omega) (Ramsey.ramseyNumber k) (fun n => (Erdos920.f k n : ℝ))
    A hA hRamsey (fun {n m} hm hlt => Erdos920.real_div_le_f_of_lt_ramseyNumber hm hlt)

/-- Every finite graph in the defining class is bounded by the maximum,
and that maximum is finite and no larger than n. -/
theorem extremal_number_bounds {k n : ℕ} (G : SimpleGraph (Fin n))
    (hG : G.CliqueFree k) :
    G.chromaticNumber.toNat ≤ Erdos920.f k n ∧ Erdos920.f k n ≤ n :=
  ⟨Erdos920.chromaticNumber_toNat_le_f G hG, Erdos920.f_le_vertices k n⟩

end LeanForty.Problem000764
