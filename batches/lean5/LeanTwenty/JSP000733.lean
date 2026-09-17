import LeanTwenty.External.Erdos882.Core

/-!
# JSP-000733 / Erdős problem 882

The maximum size of a subset of `{1,...,n}` whose nonempty subset sums
are primitive is asymptotic to `log₂ n`. The lower-bound construction uses
the Apache-licensed core in `External/Erdos882`; the extremal function,
upper bound and asymptotic completion below are new.
-/

open Filter Finset
open scoped BigOperators Topology

namespace JSP000733

/-- Divisibility among nonempty subset sums forces equality of the sums. -/
def PrimitiveSums (A : Finset ℕ) : Prop :=
  ∀ S ⊆ A, ∀ T ⊆ A, S.Nonempty → T.Nonempty →
    (∑ a ∈ S, a) ∣ (∑ a ∈ T, a) → (∑ a ∈ S, a) = (∑ a ∈ T, a)

def Admissible (n : ℕ) (A : Finset ℕ) : Prop :=
  A ⊆ Icc 1 n ∧ PrimitiveSums A

noncomputable def maximumSize (n : ℕ) : ℕ := by
  classical
  exact ((Icc 1 n).powerset.filter (PrimitiveSums ·)).sup card

lemma card_le_maximumSize {n : ℕ} {A : Finset ℕ} (h : Admissible n A) :
    A.card ≤ maximumSize n := by
  classical
  exact le_sup (f := card) (mem_filter.mpr ⟨mem_powerset.mpr h.1, h.2⟩)

lemma maximumSize_attained (n : ℕ) :
    ∃ A, Admissible n A ∧ A.card = maximumSize n := by
  classical
  let C := (Icc 1 n).powerset.filter (PrimitiveSums ·)
  have hp : PrimitiveSums ∅ := by
    intro S hS T hT _ _ _
    have hSe : S = ∅ := subset_empty.mp hS
    have hTe : T = ∅ := subset_empty.mp hT
    simp [hSe, hTe]
  have he : ∅ ∈ C := mem_filter.mpr ⟨mem_powerset.mpr (empty_subset _), hp⟩
  obtain ⟨A, hA, hmax⟩ := exists_mem_eq_sup C ⟨∅, he⟩ card
  exact ⟨A, ⟨mem_powerset.mp (mem_filter.mp hA).1, (mem_filter.mp hA).2⟩, hmax.symm⟩

def construction (m : ℕ) : Finset ℕ :=
  (range m).image (fun i => 2 ^ m - 2 ^ i)

lemma construction_inj (m : ℕ) :
    Set.InjOn (fun i : ℕ => 2 ^ m - 2 ^ i) (range m) := by
  intro i hi j hj hij
  dsimp only at hij
  have hi' : 2 ^ i < 2 ^ m := Nat.pow_lt_pow_right (by decide) (mem_range.mp hi)
  have hj' : 2 ^ j < 2 ^ m := Nat.pow_lt_pow_right (by decide) (mem_range.mp hj)
  have hp : (2 : ℕ) ^ i = 2 ^ j := by omega
  exact Nat.pow_right_injective (by decide) hp

lemma construction_card (m : ℕ) : (construction m).card = m := by
  rw [construction, card_image_of_injOn (construction_inj m), card_range]

lemma construction_admissible {m n : ℕ} (h : 2 ^ m ≤ n) :
    Admissible n (construction m) := by
  constructor
  · intro a ha
    obtain ⟨i, hi, rfl⟩ := mem_image.mp ha
    have hip : 2 ^ i < 2 ^ m := Nat.pow_lt_pow_right (by decide) (mem_range.mp hi)
    exact mem_Icc.mpr ⟨by omega, (Nat.sub_le _ _).trans h⟩
  · intro S hS T hT hSne hTne hdvd
    obtain ⟨I, hI, rfl⟩ := subset_image_iff.mp hS
    obtain ⟨J, hJ, rfl⟩ := subset_image_iff.mp hT
    have hIne : I.Nonempty := by simpa using hSne
    have hJne : J.Nonempty := by simpa using hTne
    have hIsum : (∑ a ∈ I.image (fun i => 2 ^ m - 2 ^ i), a) =
        ∑ i ∈ I, (2 ^ m - 2 ^ i) := sum_image (fun i hi j hj hij =>
          construction_inj m (hI hi) (hI hj) hij)
    have hJsum : (∑ a ∈ J.image (fun i => 2 ^ m - 2 ^ i), a) =
        ∑ i ∈ J, (2 ^ m - 2 ^ i) := sum_image (fun i hi j hj hij =>
          construction_inj m (hJ hi) (hJ hj) hij)
    rw [hIsum, hJsum] at hdvd ⊢
    by_cases heq : I = J
    · rw [heq]
    · exact (Erdos882.no_div m I J hI hJ hIne hJne heq hdvd).elim

lemma lower_bound {n : ℕ} (hn : 0 < n) : Nat.log 2 n ≤ maximumSize n := by
  have h := card_le_maximumSize (construction_admissible
    (m := Nat.log 2 n) (Nat.pow_log_le_self 2 hn.ne'))
  rwa [construction_card] at h

lemma sum_pos_of_subset {n : ℕ} {A S : Finset ℕ}
    (hA : A ⊆ Icc 1 n) (hS : S ⊆ A) (hne : S.Nonempty) : 0 < ∑ a ∈ S, a := by
  exact sum_pos (fun a ha => (mem_Icc.mp (hA (hS ha))).1) hne

lemma subset_sums_injective {n : ℕ} {A : Finset ℕ} (hA : Admissible n A) :
    Set.InjOn (fun S : Finset ℕ => ∑ a ∈ S, a) A.powerset := by
  intro S hS T hT heq
  dsimp only at heq
  have hSA := mem_powerset.mp hS
  have hTA := mem_powerset.mp hT
  let U := S \ T
  let V := T \ S
  have hUA : U ⊆ A := (sdiff_subset).trans hSA
  have hVA : V ⊆ A := (sdiff_subset).trans hTA
  have huv : Disjoint U V := disjoint_sdiff_sdiff
  have hsum : (∑ a ∈ U, a) = ∑ a ∈ V, a := by
    have hST := sum_sdiff (inter_subset_left (s₁ := S) (s₂ := T)) (f := id)
    have hTS := sum_sdiff (inter_subset_right (s₁ := S) (s₂ := T)) (f := id)
    simp only [id_eq, sdiff_inter_self_left, sdiff_inter_self_right] at hST hTS
    dsimp [U, V]
    omega
  by_contra hne
  have hUne : U.Nonempty := by
    by_contra hU
    have hU0 : U = ∅ := not_nonempty_iff_eq_empty.mp hU
    have hV0 : V = ∅ := by
      by_contra hV
      have hvp := sum_pos_of_subset hA.1 hVA (nonempty_iff_ne_empty.mpr hV)
      simp [hU0] at hsum
      omega
    apply hne
    exact Subset.antisymm (sdiff_eq_empty_iff_subset.mp hU0)
      (sdiff_eq_empty_iff_subset.mp hV0)
  have hup := sum_pos_of_subset hA.1 hUA hUne
  have hunion : U ∪ V ⊆ A := union_subset hUA hVA
  have hdouble : (∑ a ∈ U ∪ V, a) = 2 * ∑ a ∈ U, a := by
    rw [sum_union huv, ← hsum]
    omega
  have hdvd : (∑ a ∈ U, a) ∣ ∑ a ∈ U ∪ V, a := by rw [hdouble]; exact dvd_mul_left _ _
  have hbad := hA.2 U hUA (U ∪ V) hunion hUne (hUne.mono subset_union_left) hdvd
  rw [hdouble] at hbad
  omega

lemma counting_bound {n : ℕ} {A : Finset ℕ} (hA : Admissible n A) :
    2 ^ A.card ≤ A.card * n + 1 := by
  have hsub : A.powerset.image (fun S => ∑ a ∈ S, a) ⊆ Icc 0 (A.card * n) := by
    intro x hx
    obtain ⟨S, hS, rfl⟩ := mem_image.mp hx
    have hs := mem_powerset.mp hS
    apply mem_Icc.mpr
    constructor
    · omega
    · calc
        (∑ a ∈ S, a) ≤ ∑ a ∈ S, n := sum_le_sum (fun a ha => (mem_Icc.mp (hA.1 (hs ha))).2)
        _ = S.card * n := by simp
        _ ≤ A.card * n := Nat.mul_le_mul_right n (card_le_card hs)
  have hc := card_le_card hsub
  rw [card_image_of_injOn (subset_sums_injective hA), card_powerset] at hc
  simpa using hc

lemma maximum_counting_bound (n : ℕ) :
    2 ^ maximumSize n ≤ maximumSize n * n + 1 := by
  obtain ⟨A,hA,hcard⟩ := maximumSize_attained n
  simpa [hcard] using counting_bound hA

lemma maximumSize_tendsto : Tendsto maximumSize atTop atTop := by
  refine tendsto_atTop.2 fun b => ?_
  filter_upwards [eventually_ge_atTop (2 ^ b)] with n hn
  have hnpos : 0 < n := lt_of_lt_of_le (by positivity) hn
  exact (Nat.le_log_of_pow_le (by decide) hn).trans (lower_bound hnpos)

lemma logarithmic_bounds {n : ℕ} (hn : 2 ≤ n) :
    Real.log 2 - Real.log ((maximumSize n : ℝ) + 1) / maximumSize n ≤
        Real.log n / maximumSize n ∧
    Real.log n / maximumSize n ≤
        Real.log 2 + Real.log 2 / maximumSize n := by
  have hnpos : 0 < n := by omega
  have hk : 1 ≤ maximumSize n := by
    have hlog : 1 ≤ Nat.log 2 n := by
      apply (Nat.le_log_iff_pow_le (by decide) hnpos.ne').2
      simpa using hn
    exact hlog.trans (lower_bound hnpos)
  have hkr : 0 < (maximumSize n : ℝ) := by exact_mod_cast hk
  have hnr : 0 < (n : ℝ) := by exact_mod_cast hnpos
  have hln2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hc : (2 : ℝ) ^ maximumSize n ≤
      ((maximumSize n : ℝ) + 1) * n := by
    have hc' : (2 : ℝ) ^ maximumSize n ≤ (maximumSize n : ℝ) * n + 1 := by
      exact_mod_cast maximum_counting_bound n
    have hn1 : (1 : ℝ) ≤ n := by exact_mod_cast hnpos
    nlinarith
  have hlogc := Real.log_le_log (by positivity : 0 < (2 : ℝ) ^ maximumSize n) hc
  rw [Real.log_pow, Real.log_mul (by positivity) hnr.ne'] at hlogc
  have hnp : n < 2 ^ (maximumSize n + 1) := by
    exact (Nat.lt_pow_succ_log_self (by decide) n).trans_le
      (Nat.pow_le_pow_right (by decide) (Nat.add_le_add_right (lower_bound hnpos) 1))
  have hnpr : (n : ℝ) < (2 : ℝ) ^ (maximumSize n + 1) := by exact_mod_cast hnp
  have hlogn := Real.log_lt_log hnr hnpr
  rw [Real.log_pow] at hlogn
  push_cast at hlogn
  constructor
  · apply (le_div_iff₀ hkr).2
    field_simp
    nlinarith
  · apply (div_le_iff₀ hkr).2
    field_simp
    nlinarith

lemma log_div_maximum_tendsto :
    Tendsto (fun n : ℕ => Real.log n / maximumSize n) atTop (𝓝 (Real.log 2)) := by
  have hk : Tendsto (fun n : ℕ => (maximumSize n : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp maximumSize_tendsto
  have hlog : Tendsto (fun n : ℕ =>
      Real.log ((maximumSize n : ℝ) + 1) / maximumSize n) atTop (𝓝 0) := by
    have h := (Real.tendsto_pow_log_div_mul_add_atTop 1 (-1) 1 one_ne_zero).comp
      (hk.atTop_add (tendsto_const_nhds (x := (1 : ℝ))))
    simpa only [Function.comp_def, pow_one, one_mul, add_neg_cancel_right] using h
  have hsmall := hk.const_div_atTop (Real.log 2)
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le'
    (g := fun n : ℕ => Real.log 2 - Real.log ((maximumSize n : ℝ) + 1) / maximumSize n)
    (h := fun n : ℕ => Real.log 2 + Real.log 2 / maximumSize n)
    (by simpa using tendsto_const_nhds.sub hlog)
    (by simpa using tendsto_const_nhds.add hsmall)
  · filter_upwards [eventually_ge_atTop 2] with n hn using (logarithmic_bounds hn).1
  · filter_upwards [eventually_ge_atTop 2] with n hn using (logarithmic_bounds hn).2

/-- The extremal cardinality is asymptotic to the logarithm to base two. -/
theorem solution :
    Tendsto (fun n : ℕ => (maximumSize n : ℝ) / Real.logb 2 n) atTop (𝓝 1) := by
  have hln : Real.log 2 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  have h := tendsto_const_nhds.div log_div_maximum_tendsto hln
    (a := Real.log 2)
  simp only [div_self hln] at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 2, maximumSize_tendsto.eventually_ge_atTop 1] with n hn hk
  have hkr : (maximumSize n : ℝ) ≠ 0 := by exact_mod_cast (by omega : maximumSize n ≠ 0)
  have hnr : Real.log (n : ℝ) ≠ 0 :=
    ne_of_gt (Real.log_pos (by exact_mod_cast hn))
  dsimp
  rw [Real.logb]
  field_simp

#print axioms solution

end JSP000733
