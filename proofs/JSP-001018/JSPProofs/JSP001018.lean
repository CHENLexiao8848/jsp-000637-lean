import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

/-!
JSP-001018 / Erdős 1213: bounded gaps force repeated interval sums.
The intervals are distinct; they need not be adjacent or have equal length.
The proof uses dyadic blocks and the pigeonhole principle.
-/

namespace JSP001018

open Finset

def blockSum (a : ℕ → ℕ) (i l : ℕ) : ℕ :=
  ∑ t ∈ range l, a (i + t)

def DyadicDomain (R : ℕ) :=
  Σ r : Fin R, Fin (2 ^ r.val) × Fin (2 ^ (2 * R - r.val))

instance (R : ℕ) : Fintype (DyadicDomain R) := inferInstanceAs
  (Fintype (Σ r : Fin R, Fin (2 ^ r.val) × Fin (2 ^ (2 * R - r.val))))

def blockStart {R : ℕ} (x : DyadicDomain R) : ℕ := x.2.2.val
def blockLength {R : ℕ} (x : DyadicDomain R) : ℕ := 2 ^ x.1.val + x.2.1.val

theorem card_dyadicDomain (R : ℕ) :
    Fintype.card (DyadicDomain R) = R * 2 ^ (2 * R) := by
  change Fintype.card (Σ r : Fin R, Fin (2 ^ r.val) ×
    Fin (2 ^ (2 * R - r.val))) = _
  rw [Fintype.card_sigma]
  have hterm (r : Fin R) :
      Fintype.card (Fin (2 ^ r.val) × Fin (2 ^ (2 * R - r.val))) =
        2 ^ (2 * R) := by
    simp only [Fintype.card_prod, Fintype.card_fin, ← pow_add]
    congr 1
    omega
  simp_rw [hterm]
  simp

theorem blockLength_pos {R : ℕ} (x : DyadicDomain R) : 0 < blockLength x := by
  have : 0 < 2 ^ x.1.val := pow_pos (by omega) _
  simp only [blockLength]
  omega

theorem blockLength_lt {R : ℕ} (x : DyadicDomain R) :
    blockLength x < 2 ^ (x.1.val + 1) := by
  have := x.2.1.isLt
  simp only [blockLength, pow_succ]
  omega

theorem blockPair_injective (R : ℕ) :
    Function.Injective (fun x : DyadicDomain R ↦ (blockStart x, blockLength x)) := by
  intro x y h
  have hs : blockStart x = blockStart y := congrArg Prod.fst h
  have hl : blockLength x = blockLength y := congrArg Prod.snd h
  have hr : x.1.val = y.1.val := by
    have hx := blockLength_lt x
    have hy := blockLength_lt y
    have hxl : 2 ^ x.1.val ≤ blockLength x := Nat.le_add_right _ _
    have hyl : 2 ^ y.1.val ≤ blockLength y := Nat.le_add_right _ _
    by_contra hn
    rcases lt_or_gt_of_ne hn with hlt | hgt
    · have hp : 2 ^ (x.1.val + 1) ≤ 2 ^ y.1.val :=
        Nat.pow_le_pow_right (by omega) (by omega)
      omega
    · have hp : 2 ^ (y.1.val + 1) ≤ 2 ^ x.1.val :=
        Nat.pow_le_pow_right (by omega) (by omega)
      omega
  rcases x with ⟨r, t, i⟩
  rcases y with ⟨s, u, j⟩
  have hrs : r = s := Fin.ext hr
  subst s
  have htu : t = u := Fin.ext (by simpa [blockLength] using hl)
  have hij : i = j := Fin.ext hs
  subst u
  subst j
  rfl

theorem blockSum_le (a : ℕ → ℕ) (A K i l : ℕ)
    (h : ∀ t < l, a (i + t) ≤ A + K * (i + t)) :
    blockSum a i l ≤ l * (A + K * (i + l)) := by
  calc
    blockSum a i l ≤ ∑ _t ∈ range l, (A + K * (i + l)) := by
      apply Finset.sum_le_sum
      intro t ht
      have htlt := mem_range.mp ht
      exact (h t htlt).trans
        (Nat.add_le_add_left (Nat.mul_le_mul_left K (by omega)) A)
    _ = l * (A + K * (i + l)) := by simp

theorem dyadic_bounds {R : ℕ} (x : DyadicDomain R) :
    blockLength x ≤ 2 ^ R ∧
    blockLength x * blockStart x ≤ 2 * 2 ^ (2 * R) := by
  have hl := blockLength_lt x
  have hi : blockStart x < 2 ^ (2 * R - x.1.val) := x.2.2.isLt
  constructor
  · exact (Nat.le_of_lt hl).trans
      (Nat.pow_le_pow_right (by omega) (by have := x.1.isLt; omega))
  · calc
      blockLength x * blockStart x ≤
          2 ^ (x.1.val + 1) * 2 ^ (2 * R - x.1.val) :=
        Nat.mul_le_mul (Nat.le_of_lt hl) (Nat.le_of_lt hi)
      _ = 2 * 2 ^ (2 * R) := by
        rw [← pow_add]
        have he : x.1.val + 1 + (2 * R - x.1.val) = 2 * R + 1 := by
          have := x.1.isLt
          omega
        rw [he, pow_succ, Nat.mul_comm]

theorem dyadic_indices {R : ℕ} (x : DyadicDomain R) :
    blockStart x + blockLength x ≤ 2 * 2 ^ (2 * R) := by
  have hi : blockStart x < 2 ^ (2 * R - x.1.val) := x.2.2.isLt
  have hp : 2 ^ (2 * R - x.1.val) ≤ 2 ^ (2 * R) :=
    Nat.pow_le_pow_right (by omega) (by omega)
  have hl := (dyadic_bounds x).1
  have hq : 2 ^ R ≤ 2 ^ (2 * R) :=
    Nat.pow_le_pow_right (by omega) (by omega)
  omega

theorem dyadic_sum_le (a : ℕ → ℕ) (A K R : ℕ)
    (h : ∀ j < 2 * 2 ^ (2 * R), a j ≤ A + K * j)
    (x : DyadicDomain R) :
    blockSum a (blockStart x) (blockLength x) ≤ (A + 3 * K) * 2 ^ (2 * R) := by
  have hb := blockSum_le a A K (blockStart x) (blockLength x) (by
    intro t ht
    apply h
    have := dyadic_indices x
    omega)
  obtain ⟨hl, hli⟩ := dyadic_bounds x
  have hlM : blockLength x ≤ 2 ^ (2 * R) :=
    hl.trans (Nat.pow_le_pow_right (by omega) (by omega))
  have hl2 : blockLength x * blockLength x ≤ 2 ^ (2 * R) := by
    calc
      _ ≤ 2 ^ R * 2 ^ R := Nat.mul_le_mul hl hl
      _ = _ := by rw [← pow_add]; congr 1; omega
  have hA := Nat.mul_le_mul_left A hlM
  have hK := Nat.mul_le_mul_left K hli
  have hK2 := Nat.mul_le_mul_left K hl2
  nlinarith

theorem exists_equal_blocks_of_linear_bound (a : ℕ → ℕ) (A K : ℕ)
    (h : ∀ j < 2 * 2 ^ (2 * (A + 3 * K + 2)), a j ≤ A + K * j) :
    ∃ i l j m : ℕ,
      0 < l ∧ 0 < m ∧ (i, l) ≠ (j, m) ∧
      i + l ≤ 2 * 2 ^ (2 * (A + 3 * K + 2)) ∧
      j + m ≤ 2 * 2 ^ (2 * (A + 3 * K + 2)) ∧
      blockSum a i l = blockSum a j m := by
  let R := A + 3 * K + 2
  let M := 2 ^ (2 * R)
  let f : DyadicDomain R → Fin ((A + 3 * K) * M + 1) := fun x ↦
    ⟨blockSum a (blockStart x) (blockLength x),
      Nat.lt_succ_of_le (dyadic_sum_le a A K R h x)⟩
  have hc : Fintype.card (Fin ((A + 3 * K) * M + 1)) <
      Fintype.card (DyadicDomain R) := by
    rw [Fintype.card_fin, card_dyadicDomain]
    have hM : 0 < M := pow_pos (by omega) _
    change (A + 3 * K) * M + 1 < R * M
    dsimp [R]
    nlinarith
  obtain ⟨x, y, hxy, heq⟩ := Fintype.exists_ne_map_eq_of_card_lt f hc
  refine ⟨blockStart x, blockLength x, blockStart y, blockLength y,
    blockLength_pos x, blockLength_pos y, ?_, dyadic_indices x, dyadic_indices y, ?_⟩
  · exact fun hh ↦ hxy (blockPair_injective R hh)
  · exact congrArg Fin.val heq

def lengthBound (A K : ℕ) : ℕ := 2 * 2 ^ (2 * (A + 3 * K + 2))

def valueBound (A K : ℕ) : ℕ := A + K * lengthBound A K

theorem linear_bound_of_gaps (a : ℕ → ℕ) (A K s : ℕ)
    (hzero : a 0 = A) (hgap : ∀ j, j + 1 < s → a (j + 1) - a j ≤ K) :
    ∀ j < s, a j ≤ A + K * j := by
  intro j hj
  induction j with
  | zero => simp [hzero]
  | succ j ih =>
    have hprev := ih (by omega)
    have hstep := hgap j hj
    have : a (j + 1) ≤ a j + K := by omega
    calc
      a (j + 1) ≤ a j + K := this
      _ ≤ (A + K * j) + K := Nat.add_le_add_right hprev K
      _ = A + K * (j + 1) := by ring

theorem blockSum_eq_sum_Ico (a : ℕ → ℕ) (i l : ℕ) :
    blockSum a i l = ∑ j ∈ Ico i (i + l), a j := by
  rw [sum_Ico_eq_sum_range]
  simp [blockSum]

theorem blockInterval_injective {i l j m : ℕ} (hl : 0 < l) (hm : 0 < m)
    (h : Ico i (i + l) = Ico j (j + m)) : (i, l) = (j, m) := by
  have hi : i ∈ Ico j (j + m) := h ▸ (mem_Ico.mpr (by omega))
  have hj : j ∈ Ico i (i + l) := h.symm ▸ (mem_Ico.mpr (by omega))
  have hij : i = j := by
    have := mem_Ico.mp hi
    have := mem_Ico.mp hj
    omega
  have hcard := congrArg Finset.card h
  simp only [Nat.card_Ico, Nat.add_sub_cancel_left] at hcard
  exact Prod.ext hij hcard

/-- Full existence statement for a finite positive increasing integer sequence.
The natural-number representation is lossless because all its terms are positive.
The proof actually needs only the upper gap bound, so monotonicity is unnecessary. -/
theorem bounded_gap_equal_intervals (a : ℕ → ℕ) (A K s : ℕ)
    (hs : 0 < s) (hzero : a 0 = A)
    (hgap : ∀ j, j + 1 < s → a (j + 1) - a j ≤ K)
    (hlast : valueBound A K < a (s - 1)) :
    ∃ i l j m : ℕ,
      0 < l ∧ 0 < m ∧ i + l ≤ s ∧ j + m ≤ s ∧
      Ico i (i + l) ≠ Ico j (j + m) ∧
      (∑ t ∈ Ico i (i + l), a t) = ∑ t ∈ Ico j (j + m), a t := by
  have hlin := linear_bound_of_gaps a A K s hzero hgap
  have hlen : lengthBound A K ≤ s := by
    by_contra hnot
    have hb := hlin (s - 1) (by omega)
    have hm : K * (s - 1) ≤ K * lengthBound A K :=
      Nat.mul_le_mul_left K (by omega)
    dsimp [valueBound] at hlast
    omega
  have hbounded : ∀ j < lengthBound A K, a j ≤ A + K * j := by
    intro j hj
    exact hlin j (by omega)
  obtain ⟨i, l, j, m, hl, hm, hne, hi, hj, heq⟩ :=
    exists_equal_blocks_of_linear_bound a A K hbounded
  refine ⟨i, l, j, m, hl, hm, hi.trans hlen, hj.trans hlen, ?_, ?_⟩
  · exact fun he ↦ hne (blockInterval_injective hl hm he)
  · simpa only [blockSum_eq_sum_Ico] using heq

/-- JSP-001018 / Erdős 1213, with an explicit (non-optimal) bound. -/
theorem erdos1213 (A K : ℕ) (_hA : 1 ≤ A) (_hK : 1 ≤ K) :
    ∃ F : ℕ, ∀ (s : ℕ) (a : ℕ → ℕ), 0 < s → a 0 = A →
      (∀ j, j + 1 < s → a j < a (j + 1)) →
      (∀ j, j + 1 < s → a (j + 1) - a j ≤ K) →
      F < a (s - 1) →
      ∃ i l j m : ℕ,
        0 < l ∧ 0 < m ∧ i + l ≤ s ∧ j + m ≤ s ∧
        Ico i (i + l) ≠ Ico j (j + m) ∧
        (∑ t ∈ Ico i (i + l), a t) = ∑ t ∈ Ico j (j + m), a t := by
  refine ⟨valueBound A K, ?_⟩
  intro s a hs hzero _hmono hgap hlast
  exact bounded_gap_equal_intervals a A K s hs hzero hgap hlast

#print axioms erdos1213

/-- The original integer-sequence formulation. The Nat result is transferred
using positivity of every term, proved from the positive first term and gaps. -/
theorem erdos1213_int (A K : ℕ) (hA : 1 ≤ A) (_hK : 1 ≤ K) :
    ∃ F : ℕ, ∀ (s : ℕ) (a : ℕ → ℤ), 0 < s → a 0 = (A : ℤ) →
      (∀ j, j + 1 < s → a j < a (j + 1)) →
      (∀ j, j + 1 < s → a (j + 1) - a j ≤ (K : ℤ)) →
      (F : ℤ) < a (s - 1) →
      ∃ i l j m : ℕ,
        0 < l ∧ 0 < m ∧ i + l ≤ s ∧ j + m ≤ s ∧
        Ico i (i + l) ≠ Ico j (j + m) ∧
        (∑ t ∈ Ico i (i + l), a t) = ∑ t ∈ Ico j (j + m), a t := by
  refine ⟨valueBound A K, ?_⟩
  intro s a hs hzero hmono hgap hlast
  have hpos : ∀ j < s, 0 ≤ a j := by
    intro j hj
    induction j with
    | zero => omega
    | succ j ih =>
      have hprev := ih (by omega)
      have hstep := hmono j hj
      omega
  let b : ℕ → ℕ := fun j ↦ (a j).toNat
  have hb0 : b 0 = A := by simp [b, hzero]
  have hbgap : ∀ j, j + 1 < s → b (j + 1) - b j ≤ K := by
    intro j hj
    have h1 := hpos j (by omega)
    have h2 := hpos (j + 1) hj
    have hg := hgap j hj
    dsimp [b]
    omega
  have hblast : valueBound A K < b (s - 1) := by dsimp [b]; omega
  obtain ⟨i, l, j, m, hl, hm, hi, hj, hne, heq⟩ :=
    bounded_gap_equal_intervals b A K s hs hb0 hbgap hblast
  refine ⟨i, l, j, m, hl, hm, hi, hj, hne, ?_⟩
  have hsum (i l : ℕ) (hil : i + l ≤ s) :
      (∑ t ∈ Ico i (i + l), b t : ℕ) = ∑ t ∈ Ico i (i + l), a t := by
    push_cast
    apply sum_congr rfl
    intro t ht
    have htlt := (mem_Ico.mp ht).2
    exact Int.toNat_of_nonneg (hpos t (by omega))
  have hc := congrArg (fun n : ℕ ↦ (n : ℤ)) heq
  rw [hsum i l hi, hsum j m hj] at hc
  exact hc

#print axioms erdos1213_int

end JSP001018
