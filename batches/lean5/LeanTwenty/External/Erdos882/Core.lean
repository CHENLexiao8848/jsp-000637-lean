/-
Erdős Problem 882 — lower-bound construction (ELRSS99).
Proof architecture: everything reduces to the recursion pc n = n % 2 + pc (n / 2)
plus strong induction. See erdos882_proof.md for the paper proof.
-/
import Mathlib

namespace Erdos882

/-- Binary digit sum (popcount). -/
def pc (n : Nat) : Nat := (Nat.digits 2 n).sum

/-- THE workhorse: recursion for pc. Everything below inducts through this. -/
lemma pc_rec (n : Nat) (hn : n ≠ 0) : pc n = n % 2 + pc (n / 2) := by
  unfold pc
  rw [Nat.digits_def' (by norm_num : 1 < 2) (Nat.pos_of_ne_zero hn)]
  simp [List.sum_cons]

@[simp] lemma pc_zero : pc 0 = 0 := rfl

lemma pc_two_mul (n : Nat) : pc (2 * n) = pc n := by
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · simp
  · rw [pc_rec (2 * n) (by omega)]
    simp [Nat.mul_div_cancel_left n (by norm_num : 0 < 2), Nat.mul_mod_right]

/-- pc (n+1) ≤ pc n + 1 (aux for subadditivity and g-monotonicity). -/
lemma pc_succ_le (n : Nat) : pc (n + 1) ≤ pc n + 1 := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · rw [pc_rec 1 one_ne_zero]; simp
    rw [pc_rec (n+1) (by omega), pc_rec n hn.ne']
    rcases Nat.mod_two_eq_zero_or_one n with h0 | h1
    · have hm : (n+1) % 2 = 1 := by omega
      have hd : (n+1) / 2 = n / 2 := by omega
      rw [h0, hm, hd]
      omega
    · have hm : (n+1) % 2 = 0 := by omega
      have hd : (n+1) / 2 = n / 2 + 1 := by omega
      rw [h1, hm, hd]
      have hlt : n / 2 < n := Nat.div_lt_self hn (by omega)
      have := ih (n / 2) hlt
      omega

/-- L2: subadditivity of the binary digit sum. -/
lemma pc_add_le (a b : Nat) : pc (a + b) ≤ pc a + pc b := by
  have H : ∀ n a b, a + b = n → pc (a + b) ≤ pc a + pc b := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      intro a b hab
      rcases Nat.eq_zero_or_pos a with rfl | ha
      · simp
      rcases Nat.eq_zero_or_pos b with rfl | hb
      · simp
      have hab_pos : 0 < a + b := by omega
      rw [pc_rec a ha.ne', pc_rec b hb.ne', pc_rec (a+b) hab_pos.ne']
      rcases Nat.mod_two_eq_zero_or_one a with ha0 | ha1
      · rcases Nat.mod_two_eq_zero_or_one b with hb0 | hb1
        · have hab_mod : (a+b) % 2 = 0 := by omega
          have hab_div : (a+b) / 2 = a/2 + b/2 := by omega
          rw [ha0, hb0, hab_mod, hab_div]
          have hlt : a/2 + b/2 < n := by omega
          have := ih (a/2 + b/2) hlt (a/2) (b/2) rfl
          omega
        · have hab_mod : (a+b) % 2 = 1 := by omega
          have hab_div : (a+b) / 2 = a/2 + b/2 := by omega
          rw [ha0, hb1, hab_mod, hab_div]
          have hlt : a/2 + b/2 < n := by omega
          have := ih (a/2 + b/2) hlt (a/2) (b/2) rfl
          omega
      · rcases Nat.mod_two_eq_zero_or_one b with hb0 | hb1
        · have hab_mod : (a+b) % 2 = 1 := by omega
          have hab_div : (a+b) / 2 = a/2 + b/2 := by omega
          rw [ha1, hb0, hab_mod, hab_div]
          have hlt : a/2 + b/2 < n := by omega
          have := ih (a/2 + b/2) hlt (a/2) (b/2) rfl
          omega
        · have hab_mod : (a+b) % 2 = 0 := by omega
          have hab_div : (a+b) / 2 = a/2 + b/2 + 1 := by omega
          rw [ha1, hb1, hab_mod, hab_div]
          have hstep := pc_succ_le (a/2 + b/2)
          have hlt : a/2 + b/2 < n := by omega
          have hsub := ih (a/2 + b/2) hlt (a/2) (b/2) rfl
          omega
  exact H (a+b) a b rfl

/-- L2': pc (q * T) ≤ pc q * pc T. -/
lemma pc_mul_le (q T : Nat) : pc (q * T) ≤ pc q * pc T := by
  induction q using Nat.strong_induction_on with
  | _ q ih =>
    rcases Nat.eq_zero_or_pos q with rfl | hq
    · simp
    have hq' : q / 2 < q := Nat.div_lt_self hq (by omega)
    have hkey : q * T = 2 * (q/2 * T) + (q%2) * T := by
      have hqmod : 2 * (q/2) + q%2 = q := Nat.div_add_mod q 2
      calc q * T = (2 * (q/2) + q%2) * T := by rw [hqmod]
        _ = 2 * (q/2 * T) + (q%2) * T := by ring
    rw [hkey]
    have hrT : pc ((q%2) * T) ≤ (q%2) * pc T := by
      rcases Nat.mod_two_eq_zero_or_one q with h | h
      · rw [h]; simp
      · rw [h, one_mul, one_mul]
    calc pc (2 * (q/2 * T) + (q%2) * T)
        ≤ pc (2 * (q/2 * T)) + pc ((q%2) * T) := pc_add_le _ _
      _ = pc (q/2 * T) + pc ((q%2) * T) := by rw [pc_two_mul]
      _ ≤ pc (q/2) * pc T + pc ((q%2) * T) := by
          exact Nat.add_le_add_right (ih (q/2) hq') _
      _ ≤ pc (q/2) * pc T + (q%2) * pc T := Nat.add_le_add_left hrT _
      _ = (pc (q/2) + q%2) * pc T := by ring
      _ = pc q * pc T := by rw [pc_rec q hq.ne']; ring

/-- L3: non-overlapping digits: pc (k * 2^m + U) = pc k + pc U for U < 2^m. -/
lemma pc_split (k U m : Nat) (hU : U < 2 ^ m) :
    pc (k * 2 ^ m + U) = pc k + pc U := by
  induction m generalizing U with
  | zero =>
    simp at hU
    subst hU
    simp
  | succ m ih =>
    rcases Nat.eq_zero_or_pos U with rfl | hU_pos
    · have : k * 2^(m+1) = 2 * (k * 2^m) := by ring
      rw [Nat.add_zero, this, pc_two_mul]
      have h0 : (0 : Nat) < 2^m := Nat.two_pow_pos m
      have := ih 0 h0
      simp at this
      simpa using this
    · have hu : U / 2 < 2^m := by
        have h2 : 2^(m+1) = 2 * 2^m := by ring
        omega
      have hkey : k * 2^(m+1) + U = 2 * (k * 2^m + U/2) + U%2 := by
        have h2 : 2^(m+1) = 2 * 2^m := by ring
        have hU_split : 2 * (U/2) + U%2 = U := Nat.div_add_mod U 2
        calc k * 2^(m+1) + U
            = k * (2 * 2^m) + (2 * (U/2) + U%2) := by rw [h2, hU_split]
          _ = 2 * (k * 2^m + U/2) + U%2 := by ring
      rw [hkey]
      have h2W_pos : 2 * (k * 2^m + U/2) + U%2 ≠ 0 := by
        have hU_split : 2 * (U/2) + U%2 = U := Nat.div_add_mod U 2
        have : 2 * (U/2) + U%2 ≥ 1 := by omega
        have : 2 * (k * 2^m + U/2) + U%2 ≥ 2 * (U/2) + U%2 := by
          have : k * 2^m + U/2 ≥ U/2 := by omega
          omega
        omega
      rw [pc_rec _ h2W_pos]
      have hU2 : U%2 < 2 := Nat.mod_lt U (by omega)
      have hmod : (2 * (k * 2^m + U/2) + U%2) % 2 = U%2 := by omega
      have hdiv : (2 * (k * 2^m + U/2) + U%2) / 2 = k * 2^m + U/2 := by omega
      rw [hmod, hdiv, ih (U/2) hu, pc_rec U hU_pos.ne']
      ring

/-- g n = n - pc n (in ℕ; note pc n ≤ n so no truncation issues). -/
def g (n : Nat) : Nat := n - pc n

lemma pc_le_self (n : Nat) : pc n ≤ n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · simp
    have h : n/2 < n := Nat.div_lt_self hn (by omega)
    rw [pc_rec n hn.ne']
    have := ih (n/2) h
    have := Nat.div_add_mod n 2
    omega

/-- L4: g is monotone (from pc_succ_le). -/
lemma g_mono : Monotone g := by
  apply monotone_nat_of_le_succ
  intro n
  unfold g
  have h1 := pc_succ_le n
  have h2 := pc_le_self n
  have h3 := pc_le_self (n+1)
  omega

/-- Step characterization: g (n+1) = g n ↔ n even (else strictly increases). -/
lemma g_succ_eq_iff (n : Nat) : g (n + 1) = g n ↔ n % 2 = 0 := by
  unfold g
  have hpn := pc_le_self n
  have hpsn := pc_le_self (n+1)
  have hstep := pc_succ_le n
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · rw [pc_rec 1 one_ne_zero]; simp
  have hpcn : pc n = n%2 + pc (n/2) := pc_rec n hn.ne'
  have hpcs : pc (n+1) = (n+1)%2 + pc ((n+1)/2) := pc_rec (n+1) (by omega)
  have hpn2 := pc_le_self (n/2)
  have hpn3 := pc_le_self (n/2 + 1)
  have hnat := Nat.div_add_mod n 2
  rcases Nat.mod_two_eq_zero_or_one n with h | h
  · have hd : (n+1)/2 = n/2 := by omega
    have hm : (n+1)%2 = 1 := by omega
    rw [hm, hd] at hpcs
    rw [h] at hpcn
    constructor
    · intro _; exact h
    · intro _; omega
  · have hd : (n+1)/2 = n/2 + 1 := by omega
    have hm : (n+1)%2 = 0 := by omega
    rw [hm, hd] at hpcs
    rw [h] at hpcn
    have hstep2 := pc_succ_le (n/2)
    constructor
    · intro heq
      exfalso
      omega
    · intro h0
      omega

/-- L4 equality: if g k = g q with k < q then k = q - 1 and (q-1) % 2 = 0. -/
lemma g_eq_of_lt {k q : Nat} (h : k < q) (hg : g k = g q) :
    k = q - 1 ∧ (q - 1) % 2 = 0 := by
  have hconst : ∀ i, k ≤ i → i ≤ q → g i = g k := by
    intro i hki hiq
    have h1 : g k ≤ g i := g_mono hki
    have h2 : g i ≤ g q := g_mono hiq
    omega
  by_cases hk : k = q - 1
  · refine ⟨hk, ?_⟩
    have hqm1 : q - 1 + 1 = q := by omega
    have hgeq : g ((q-1) + 1) = g (q-1) := by
      rw [hqm1, ← hk]
      exact hg.symm
    exact (g_succ_eq_iff (q-1)).mp hgeq
  · exfalso
    have hk2 : k + 2 ≤ q := by omega
    have hg1 : g (k+1) = g k := hconst (k+1) (by omega) (by omega)
    have hg2 : g (k+2) = g (k+1) := by
      have h_kp1_k : g (k+1) = g k := hg1
      have h_kp2_k : g (k+2) = g k := hconst (k+2) (by omega) hk2
      omega
    have h1 := (g_succ_eq_iff k).mp hg1
    have h2 := (g_succ_eq_iff (k+1)).mp hg2
    omega

/-- L5: for q ≥ 2, pc q < q. -/
lemma pc_lt_self {q : Nat} (hq : 2 ≤ q) : pc q < q := by
  rw [pc_rec q (by omega)]
  have h1 := pc_le_self (q/2)
  have h2 := Nat.div_add_mod q 2
  omega

/-- Auxiliary: ∑_{i ∈ range n} 2^i < 2^n. -/
lemma sum_range_two_pow_lt (n : Nat) : ∑ i ∈ Finset.range n, 2^i < 2^n := by
  induction n with
  | zero => simp
  | succ k ih => rw [Finset.sum_range_succ, pow_succ]; omega

/-- pc of ∑_{i∈S} 2^i equals |S| (distinct powers of two), via pc_split. -/
lemma pc_sum_pow {m : Nat} (S : Finset Nat) (hS : S ⊆ Finset.range m) :
    pc (∑ i ∈ S, 2 ^ i) = S.card := by
  have H : ∀ (S : Finset Nat), ∀ (m : Nat), S ⊆ Finset.range m →
      pc (∑ i ∈ S, 2^i) = S.card := by
    intro S
    induction S using Finset.strongInduction with
    | _ S ih =>
      intro m hS
      rcases Finset.eq_empty_or_nonempty S with rfl | hne
      · simp
      set j := S.max' hne with hj_def
      have hjS : j ∈ S := S.max'_mem hne
      set T := S.erase j with hT_def
      have hj_notin_T : j ∉ T := Finset.notMem_erase j S
      have hSj : S = insert j T := (Finset.insert_erase hjS).symm
      have hT_sub_j : T ⊆ Finset.range j := by
        intro i hi
        have hiS : i ∈ S := Finset.mem_of_mem_erase hi
        have hine : i ≠ j := Finset.ne_of_mem_erase hi
        have hile : i ≤ j := S.le_max' i hiS
        simp only [Finset.mem_range]
        omega
      have hT_ss : T ⊂ S := by
        rw [hSj]
        exact Finset.ssubset_insert hj_notin_T
      have ihT := ih T hT_ss j hT_sub_j
      have hsum : ∑ i ∈ S, 2^i = 2^j + ∑ i ∈ T, 2^i := by
        conv_lhs => rw [hSj]
        exact Finset.sum_insert hj_notin_T
      rw [hsum]
      have hT_bound : ∑ i ∈ T, 2^i < 2^j := by
        have h1 : ∑ i ∈ T, 2^i ≤ ∑ i ∈ Finset.range j, 2^i :=
          Finset.sum_le_sum_of_subset_of_nonneg hT_sub_j (fun _ _ _ => Nat.zero_le _)
        have h2 := sum_range_two_pow_lt j
        omega
      have h1eq : (2:Nat)^j + ∑ i ∈ T, 2^i = 1 * 2^j + ∑ i ∈ T, 2^i := by ring
      rw [h1eq, pc_split 1 (∑ i ∈ T, 2^i) j hT_bound, ihT]
      have hpc1 : pc 1 = 1 := by rw [pc_rec 1 one_ne_zero]; simp
      rw [hpc1, hSj, Finset.card_insert_of_notMem hj_notin_T]
      ring
  exact H S m hS

/-- Subset sums in (s,T) coordinates: Σ_{i∈S}(2^m - 2^i) = |S|·2^m - Σ_{i∈S}2^i. -/
lemma sum_eq {m : Nat} (S : Finset Nat) (hS : S ⊆ Finset.range m) :
    ∑ i ∈ S, (2 ^ m - 2 ^ i) = S.card * 2 ^ m - ∑ i ∈ S, 2 ^ i := by
  induction S using Finset.induction with
  | empty => simp
  | insert j T hj ih =>
    have hT_sub : T ⊆ Finset.range m :=
      fun x hx => hS (Finset.mem_insert.mpr (Or.inr hx))
    have hj_mem : j ∈ Finset.range m := hS (Finset.mem_insert_self j T)
    have hjm : j < m := Finset.mem_range.mp hj_mem
    have h2j_le : 2^j ≤ 2^m := Nat.pow_le_pow_right (by omega) (by omega)
    have hT_sum_le : ∑ i ∈ T, 2^i ≤ T.card * 2^m := by
      calc ∑ i ∈ T, 2^i ≤ ∑ i ∈ T, 2^m := by
            apply Finset.sum_le_sum
            intro i hi
            have : i < m := Finset.mem_range.mp (hT_sub hi)
            exact Nat.pow_le_pow_right (by omega) (by omega)
        _ = T.card * 2^m := by rw [Finset.sum_const, smul_eq_mul]
    rw [Finset.sum_insert hj, Finset.sum_insert hj,
        Finset.card_insert_of_notMem hj, ih hT_sub]
    have hmul : (T.card + 1) * 2^m = T.card * 2^m + 2^m := by ring
    omega

/-- T-bounds: 1 ≤ Σ_{i∈S}2^i ≤ 2^m - 1 for nonempty S ⊆ range m. -/
lemma sum_pow_bounds {m : Nat} (S : Finset Nat) (hS : S ⊆ Finset.range m)
    (hne : S.Nonempty) : 1 ≤ ∑ i ∈ S, 2 ^ i ∧ ∑ i ∈ S, 2 ^ i ≤ 2 ^ m - 1 := by
  obtain ⟨j, hj⟩ := hne
  refine ⟨?_, ?_⟩
  · have hj_pos : 1 ≤ 2^j := Nat.two_pow_pos j
    have hsum : 2^j ≤ ∑ i ∈ S, 2^i :=
      Finset.single_le_sum (f := fun i => 2^i) (fun _ _ => Nat.zero_le _) hj
    omega
  · have h1 : ∑ i ∈ S, 2^i ≤ ∑ i ∈ Finset.range m, 2^i :=
      Finset.sum_le_sum_of_subset_of_nonneg hS (fun _ _ _ => Nat.zero_le _)
    have h2 := sum_range_two_pow_lt m
    omega

/-- L1 (injectivity): ∑_{i∈S} 2^i is injective on subsets of range m. -/
lemma sum_pow_inj : ∀ (n : Nat) (S₁ S₂ : Finset Nat),
    S₁ ⊆ Finset.range n → S₂ ⊆ Finset.range n →
    ∑ i ∈ S₁, (2:Nat)^i = ∑ i ∈ S₂, 2^i → S₁ = S₂ := by
  intro n
  induction n with
  | zero =>
    intro S₁ S₂ h₁ h₂ _
    simp only [Finset.range_zero, Finset.subset_empty] at h₁ h₂
    rw [h₁, h₂]
  | succ n ih =>
    intro S₁ S₂ h₁ h₂ heq
    have hsum_lt : ∀ (S : Finset Nat), S ⊆ Finset.range n → ∑ i ∈ S, (2:Nat)^i < 2^n := by
      intro S hS
      calc ∑ i ∈ S, (2:Nat)^i
          ≤ ∑ i ∈ Finset.range n, 2^i :=
             Finset.sum_le_sum_of_subset_of_nonneg hS (fun _ _ _ => Nat.zero_le _)
        _ < 2^n := sum_range_two_pow_lt n
    have shrink : ∀ (S : Finset Nat), S ⊆ Finset.range (n+1) → n ∉ S →
        S ⊆ Finset.range n := by
      intro S hS hnn i hi
      have hin : i ≠ n := fun h => hnn (h ▸ hi)
      have := hS hi
      simp only [Finset.mem_range] at this ⊢
      omega
    have shrink_erase : ∀ (S : Finset Nat), S ⊆ Finset.range (n+1) →
        S.erase n ⊆ Finset.range n := by
      intro S hS i hi
      have hiS : i ∈ S := Finset.mem_of_mem_erase hi
      have hin : i ≠ n := Finset.ne_of_mem_erase hi
      have := hS hiS
      simp only [Finset.mem_range] at this ⊢
      omega
    by_cases hn₁ : n ∈ S₁
    · by_cases hn₂ : n ∈ S₂
      · have hs₁ := shrink_erase S₁ h₁
        have hs₂ := shrink_erase S₂ h₂
        have hsum₁ : ∑ i ∈ S₁, (2:Nat)^i = 2^n + ∑ i ∈ S₁.erase n, 2^i := by
          conv_lhs => rw [← Finset.insert_erase hn₁]
          exact Finset.sum_insert (Finset.notMem_erase _ _)
        have hsum₂ : ∑ i ∈ S₂, (2:Nat)^i = 2^n + ∑ i ∈ S₂.erase n, 2^i := by
          conv_lhs => rw [← Finset.insert_erase hn₂]
          exact Finset.sum_insert (Finset.notMem_erase _ _)
        rw [hsum₁, hsum₂] at heq
        have heq' : ∑ i ∈ S₁.erase n, (2:Nat)^i = ∑ i ∈ S₂.erase n, 2^i := by omega
        have := ih (S₁.erase n) (S₂.erase n) hs₁ hs₂ heq'
        rw [← Finset.insert_erase hn₁, ← Finset.insert_erase hn₂, this]
      · exfalso
        have hs₂ := shrink S₂ h₂ hn₂
        have hbnd : ∑ i ∈ S₂, (2:Nat)^i < 2^n := hsum_lt S₂ hs₂
        have hge : (2:Nat)^n ≤ ∑ i ∈ S₁, 2^i :=
          Finset.single_le_sum (f := fun i => (2:Nat)^i) (fun _ _ => Nat.zero_le _) hn₁
        omega
    · by_cases hn₂ : n ∈ S₂
      · exfalso
        have hs₁ := shrink S₁ h₁ hn₁
        have hbnd : ∑ i ∈ S₁, (2:Nat)^i < 2^n := hsum_lt S₁ hs₁
        have hge : (2:Nat)^n ≤ ∑ i ∈ S₂, 2^i :=
          Finset.single_le_sum (f := fun i => (2:Nat)^i) (fun _ _ => Nat.zero_le _) hn₂
        omega
      · exact ih S₁ S₂ (shrink S₁ h₁ hn₁) (shrink S₂ h₂ hn₂) heq

/-- **Main theorem** (ELRSS99): distinct nonempty subset sums of
{2^m - 2^i : i < m} never divide one another. -/
theorem no_div (m : Nat) (S₁ S₂ : Finset Nat)
    (h₁ : S₁ ⊆ Finset.range m) (h₂ : S₂ ⊆ Finset.range m)
    (hne₁ : S₁.Nonempty) (hne₂ : S₂.Nonempty) (hne : S₁ ≠ S₂) :
    ¬ (∑ i ∈ S₁, (2 ^ m - 2 ^ i)) ∣ (∑ i ∈ S₂, (2 ^ m - 2 ^ i)) := by
  intro hdvd
  obtain ⟨q, hq⟩ := hdvd
  set s := S₁.card with hs_def
  set t := S₂.card with ht_def
  set T := ∑ i ∈ S₁, (2:Nat)^i with hT_def
  set U := ∑ i ∈ S₂, (2:Nat)^i with hU_def
  set x := ∑ i ∈ S₁, (2^m - (2:Nat)^i) with hx_def
  set y := ∑ i ∈ S₂, (2^m - (2:Nat)^i) with hy_def
  have hpcT : pc T = s := pc_sum_pow S₁ h₁
  have hpcU : pc U = t := pc_sum_pow S₂ h₂
  have hs_pos : 1 ≤ s := Finset.card_pos.mpr hne₁
  have ht_pos : 1 ≤ t := Finset.card_pos.mpr hne₂
  obtain ⟨T_ge1, T_le⟩ := sum_pow_bounds S₁ h₁ hne₁
  obtain ⟨U_ge1, U_le⟩ := sum_pow_bounds S₂ h₂ hne₂
  have h2m_pos : (0 : Nat) < 2^m := Nat.two_pow_pos m
  have hT_lt : T < 2^m := by omega
  have hU_lt : U < 2^m := by omega
  have hx_eq : x = s * 2^m - T := sum_eq S₁ h₁
  have hy_eq : y = t * 2^m - U := sum_eq S₂ h₂
  have hT_le_smul : T ≤ s * 2^m := by
    have : 2^m ≤ s * 2^m := Nat.le_mul_of_pos_left _ hs_pos
    omega
  have hU_le_tmul : U ≤ t * 2^m := by
    have : 2^m ≤ t * 2^m := Nat.le_mul_of_pos_left _ ht_pos
    omega
  have hx_pos : 0 < x := by
    rw [hx_eq]
    have : 2^m ≤ s * 2^m := Nat.le_mul_of_pos_left _ hs_pos
    omega
  have hy_pos : 0 < y := by
    rw [hy_eq]
    have : 2^m ≤ t * 2^m := Nat.le_mul_of_pos_left _ ht_pos
    omega
  have hq_pos : 1 ≤ q := by
    rcases Nat.eq_zero_or_pos q with rfl | h
    · simp at hq; omega
    · exact h
  -- L1: x = y ⟹ S₁ = S₂
  have h_xy_ne : x ≠ y := by
    intro hxy
    apply hne
    have hnat_eq : s*2^m + U = t*2^m + T := by
      have h1 : x + T = s*2^m := by rw [hx_eq]; omega
      have h2 : y + U = t*2^m := by rw [hy_eq]; omega
      omega
    have hst : s = t := by
      by_contra hst
      rcases lt_or_gt_of_ne hst with h | h
      · have hst1 : s + 1 ≤ t := by omega
        have hmul : (s+1) * 2^m ≤ t * 2^m := Nat.mul_le_mul_right _ hst1
        have hexp : (s+1) * 2^m = s*2^m + 2^m := by ring
        omega
      · have hst1 : t + 1 ≤ s := by omega
        have hmul : (t+1) * 2^m ≤ s * 2^m := Nat.mul_le_mul_right _ hst1
        have hexp : (t+1) * 2^m = t*2^m + 2^m := by ring
        omega
    have hTU : T = U := by
      have h := hnat_eq
      rw [hst] at h
      omega
    exact sum_pow_inj m S₁ S₂ h₁ h₂ hTU
  have hq_ge2 : 2 ≤ q := by
    rcases Nat.lt_or_ge q 2 with h | h
    · exfalso
      interval_cases q
      rw [Nat.mul_one] at hq
      exact h_xy_ne hq.symm
    · exact h
  -- ℕ key equation: q*s*2^m + U = q*T + t*2^m
  have hnat : q*s*2^m + U = q*T + t*2^m := by
    have hyq : y = q * x := by rw [hq]; ring
    have hA : y + U = t*2^m := by rw [hy_eq]; omega
    have hB : x + T = s*2^m := by rw [hx_eq]; omega
    have hB2 : q*x + q*T = q*(s*2^m) := by
      calc q*x + q*T = q*(x + T) := by ring
        _ = q*(s*2^m) := by rw [hB]
    have hB3 : q*x + q*T = q*s*2^m := by rw [hB2]; ring
    have hA2 : q*x + U = t*2^m := by rw [← hyq]; exact hA
    omega
  -- t ≤ q*s
  have hqs_ge_t : t ≤ q*s := by
    by_contra hlt
    have h1 : q*s + 1 ≤ t := by omega
    have h2 : (q*s + 1) * 2^m ≤ t * 2^m := Nat.mul_le_mul_right _ h1
    have hexp : (q*s + 1) * 2^m = q*s*2^m + 2^m := by ring
    omega
  set k := q*s - t with hk_def
  have hk_eq_qst : q*s = k + t := by omega
  -- k*2^m + U = q*T
  have h_kmul : k * 2^m + U = q * T := by
    have hkmul_eq : k * 2^m = q*s*2^m - t*2^m := by
      rw [hk_def, Nat.sub_mul]
    have h_t_le : t*2^m ≤ q*s*2^m := Nat.mul_le_mul_right _ hqs_ge_t
    omega
  -- k ≤ q - 1
  have h_k_le : k ≤ q - 1 := by
    have h_T1 : T + 1 ≤ 2^m := by omega
    have h_qT_bnd : q*T + q ≤ q*2^m := by
      have : q*(T + 1) ≤ q*2^m := Nat.mul_le_mul_left q h_T1
      have h_expand : q*(T+1) = q*T + q := by ring
      omega
    by_contra hkq
    have hk_ge_q : q ≤ k := by omega
    have h_km : q*2^m ≤ k*2^m := Nat.mul_le_mul_right _ hk_ge_q
    omega
  -- Case analysis
  rcases Nat.eq_zero_or_pos k with hk0 | hk_pos
  · -- k = 0
    have hkzero : k * 2^m = 0 := by rw [hk0]; ring
    have hqTU : q*T = U := by omega
    have hqs_eq_t : q*s = t := by omega
    have hpcqT : pc (q*T) = t := by rw [hqTU]; exact hpcU
    have hbnd : pc (q*T) ≤ pc q * s := by
      have := pc_mul_le q T
      rw [hpcT] at this
      exact this
    have h1 : q * s ≤ pc q * s := by
      have : t = pc (q * T) := hpcqT.symm
      omega
    have h2 : q ≤ pc q := Nat.le_of_mul_le_mul_right h1 hs_pos
    have h3 := pc_lt_self hq_ge2
    omega
  · -- k ≥ 1
    have hqT_split : q*T = k*2^m + U := h_kmul.symm
    have hpc_qT : pc (q*T) = pc k + t := by
      rw [hqT_split, pc_split k U m hU_lt, hpcU]
    have hbnd : pc (q*T) ≤ pc q * s := by
      have := pc_mul_le q T
      rw [hpcT] at this
      exact this
    have h1 : pc k + t ≤ pc q * s := by rw [← hpc_qT]; exact hbnd
    -- g(k) ≥ g(q) * s
    have hpc_k := pc_le_self k
    have hpc_q := pc_le_self q
    have hpcq_lt := pc_lt_self hq_ge2
    have h_gk_ge_gqs : (q - pc q) * s ≤ k - pc k := by
      have hqmul : pc q * s ≤ q * s := Nat.mul_le_mul_right s hpc_q
      have hqmul_add : (q - pc q) * s + pc q * s = q * s := by
        rw [Nat.sub_mul, Nat.sub_add_cancel hqmul]
      have h_key : (q - pc q) * s + pc q * s = k + t :=
        hqmul_add.trans hk_eq_qst
      have h_o_sub : (q - pc q) * s = k + t - pc q * s := by
        have hle : pc q * s ≤ k + t := by omega
        omega
      rw [h_o_sub]
      omega
    -- g(k) ≤ g(q): via g_mono
    have hk_lt_q : k < q := by omega
    have hk_le_q : k ≤ q := by omega
    have h_gk_le_gq : k - pc k ≤ q - pc q := by
      have := g_mono hk_le_q
      unfold g at this
      exact this
    rcases Nat.lt_or_ge 1 s with hs2 | hs1
    · -- s ≥ 2
      have h2gq : 2 * (q - pc q) ≤ (q - pc q) * s := by
        have h_a : 2 * (q - pc q) ≤ s * (q - pc q) :=
          Nat.mul_le_mul_right _ (by omega : 2 ≤ s)
        have h_b : s * (q - pc q) = (q - pc q) * s := by ring
        omega
      have h_chain : (q - pc q) * s ≤ q - pc q :=
        le_trans h_gk_ge_gqs h_gk_le_gq
      omega
    · -- s = 1
      have hs_eq : s = 1 := by omega
      have hgeq_val : k - pc k = q - pc q := by
        have h1' := h_gk_ge_gqs
        rw [hs_eq, Nat.mul_one] at h1'
        omega
      have hgeq : g k = g q := by unfold g; exact hgeq_val
      obtain ⟨hk_val, hqm1_even⟩ := g_eq_of_lt hk_lt_q hgeq
      have h_qs_val : q * s = q := by rw [hs_eq]; ring
      have h_t_eq : t = 1 := by omega
      obtain ⟨i, hi_eq⟩ : ∃ i, S₁ = {i} := Finset.card_eq_one.mp hs_eq
      obtain ⟨j, hj_eq⟩ : ∃ j, S₂ = {j} := Finset.card_eq_one.mp h_t_eq
      have hi_mem : i ∈ S₁ := by rw [hi_eq]; exact Finset.mem_singleton_self i
      have hj_mem : j ∈ S₂ := by rw [hj_eq]; exact Finset.mem_singleton_self j
      have hi_lt_m : i < m := Finset.mem_range.mp (h₁ hi_mem)
      have hj_lt_m : j < m := Finset.mem_range.mp (h₂ hj_mem)
      have hT_val : T = 2^i := by rw [hT_def, hi_eq, Finset.sum_singleton]
      have hU_val : U = 2^j := by rw [hU_def, hj_eq, Finset.sum_singleton]
      have hx_val : x = 2^m - 2^i := by
        have := hx_eq
        rw [hs_eq, Nat.one_mul, hT_val] at this
        exact this
      have hy_val : y = 2^m - 2^j := by
        have := hy_eq
        rw [h_t_eq, Nat.one_mul, hU_val] at this
        exact this
      have hy_gt_x : x < y := by
        rw [hq]
        have : x = x * 1 := (Nat.mul_one x).symm
        calc x = x * 1 := (Nat.mul_one x).symm
          _ < x * q := Nat.mul_lt_mul_of_pos_left (by omega : 1 < q) hx_pos
      have h_2i_lt : (2:Nat)^i < 2^m := pow_lt_pow_right₀ (by omega : 1 < 2) hi_lt_m
      have h_2j_lt : (2:Nat)^j < 2^m := pow_lt_pow_right₀ (by omega : 1 < 2) hj_lt_m
      have h_2i_gt_2j : (2:Nat)^j < 2^i := by
        have h_xy : (2:Nat)^m - 2^i < 2^m - 2^j := by rw [← hx_val, ← hy_val]; exact hy_gt_x
        omega
      have hj_lt_i : j < i := (pow_lt_pow_iff_right₀ (by omega : 1 < 2)).mp h_2i_gt_2j
      have h_eq_main : (q-1)*2^m + 2^j = q*2^i := by
        have := h_kmul
        rw [hk_val] at this
        rw [hT_val, hU_val] at this
        exact this
      have hmj : m - j ≥ 1 := by omega
      have hij : i - j ≥ 1 := by omega
      have h_2m_split : (2:Nat)^m = 2^j * 2^(m-j) := by
        rw [← pow_add]; congr 1; omega
      have h_2i_split : (2:Nat)^i = 2^j * 2^(i-j) := by
        rw [← pow_add]; congr 1; omega
      have h_2j_pos : 0 < (2:Nat)^j := Nat.two_pow_pos j
      have h_eq_factored : 2^j * ((q-1) * 2^(m-j) + 1) = 2^j * (q * 2^(i-j)) := by
        calc 2^j * ((q-1) * 2^(m-j) + 1)
            = (q-1) * (2^j * 2^(m-j)) + 2^j := by ring
          _ = (q-1) * 2^m + 2^j := by rw [← h_2m_split]
          _ = q * 2^i := h_eq_main
          _ = q * (2^j * 2^(i-j)) := by rw [← h_2i_split]
          _ = 2^j * (q * 2^(i-j)) := by ring
      have h_eq_div : (q-1) * 2^(m-j) + 1 = q * 2^(i-j) :=
        Nat.eq_of_mul_eq_mul_left h_2j_pos h_eq_factored
      have h_2mj_even : (2:Nat)^(m-j) % 2 = 0 := by
        have hsplit : (2:Nat)^(m-j) = 2^(m-j-1) * 2 := by
          conv_lhs => rw [show m - j = (m - j - 1) + 1 from by omega]
          exact pow_succ 2 (m-j-1)
        omega
      have h_2ij_even : (2:Nat)^(i-j) % 2 = 0 := by
        have hsplit : (2:Nat)^(i-j) = 2^(i-j-1) * 2 := by
          conv_lhs => rw [show i - j = (i - j - 1) + 1 from by omega]
          exact pow_succ 2 (i-j-1)
        omega
      have h_LHS_mod : ((q-1) * 2^(m-j) + 1) % 2 = 1 := by
        have : ((q-1) * 2^(m-j)) % 2 = 0 := by
          rw [Nat.mul_mod, h_2mj_even, Nat.mul_zero, Nat.zero_mod]
        omega
      have h_RHS_mod : (q * 2^(i-j)) % 2 = 0 := by
        rw [Nat.mul_mod, h_2ij_even, Nat.mul_zero, Nat.zero_mod]
      rw [h_eq_div] at h_LHS_mod
      omega

end Erdos882
