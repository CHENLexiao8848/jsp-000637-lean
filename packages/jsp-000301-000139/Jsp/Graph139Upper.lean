import Jsp.Graph139Fields
import Jsp.Graph139Parabola
import Jsp.Graph139Blowup
import Mathlib.Data.Fintype.EquivFin

/-!
# JSP-000139: asymptotically sharp degree bound

The explicit parabola family over fields of size 11^(2k+1), followed by bounded
vertex blow-ups, supplies every sufficiently large order. Together with the
Moore bound this establishes the order of growth Theta(sqrt n). The deliberately
loose upper constant is not a claim about the optimal leading constant.
-/
namespace Jsp.Graph139Upper
noncomputable section
attribute [local instance] Classical.propDecidable
open SimpleGraph Jsp.Graph139 Jsp.Graph139Fields Jsp.Graph139Parabola Jsp.Graph139Blowup

theorem family (k : ℕ) :
    ∃ G : SimpleGraph (Fin ((11^(2*k+1))^2)),
      G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧ G.maxDegree ≤ 2*11^(2*k+1) := by
  let K := FieldAt k
  let S := parabolaSet (K := K)
  have hs : SymmetricCompleteSumFree S :=
    parabola_properties (two_ne_zero k) (field_quadratic_zero k) (field_square_or_neg_square k)
  let H := SimpleGraph.addCayley (S : Set (K × K))
  have hp := addCayley_properties S hs
  have hc : Fintype.card (K × K) = (11^(2*k+1))^2 := by
    simp [K, Fintype.card_prod, card_field, pow_two]
  let e := (Fintype.equivFinOfCardEq hc).symm
  let G := H.comap e
  refine ⟨G, blowup_triangle_free hp.1 e, ?_, ?_⟩
  · apply (diameterAtMostTwo_iff_ediam_le_two G).mp
    have hd := (diameterAtMostTwo_iff_ediam_le_two H).mpr hp.2.1
    exact blowup_diameter hd (exists_neighbor_of_diameter H hd) e e.surjective
  · have hm : G.maxDegree = S.card := (SimpleGraph.Iso.comap e H).maxDegree_eq.trans hp.2.2
    have hh : G.maxDegree ≤ 2*11^(2*k+1) := hm.le.trans
      ((parabola_card (K := K)).trans (by simp [K, card_field]))
    convert! hh using 1
    unfold SimpleGraph.maxDegree SimpleGraph.degree
    congr 3
    funext v
    congr 1
    ext w
    simp only [SimpleGraph.mem_neighborFinset]

theorem family_order (k : ℕ) : (11^(2*k+1))^2 = 121*14641^k := by
  calc
    (11^(2*k+1))^2 = 11^(4*k+2) := by rw [←pow_mul]; congr 1; omega
    _ = 11^2 * (11^4)^k := by rw [←pow_mul, ←pow_add]; congr 1; omega
    _ = 121*14641^k := by norm_num

theorem exists_family_below {n : ℕ} (hn : 121 ≤ n) :
    ∃ k : ℕ, (11^(2*k+1))^2 ≤ n ∧ n < 14641*(11^(2*k+1))^2 := by
  have hp : 0 < n/121 := Nat.div_pos hn (by decide)
  let k := Nat.log 14641 (n/121)
  refine ⟨k, ?_, ?_⟩
  · rw [family_order]
    exact (Nat.mul_le_mul_left 121 (Nat.pow_log_le_self 14641 hp.ne')).trans
      (by simpa [mul_comm] using Nat.div_mul_le_self n 121)
  · have hh : n/121 < 14641^(k+1) :=
      Nat.lt_pow_of_log_lt (by decide) (Nat.lt_succ_self k)
    have hx : n < 14641^(k+1)*121 := (Nat.div_lt_iff_lt_mul (by decide)).mp hh
    rw [family_order]
    convert hx using 1
    ring

/-- An explicit all-sufficiently-large-n upper bound; no unproved existence hypotheses. -/
theorem upper_bound (n : ℕ) (hn : 121 ≤ n) :
    ∃ G : SimpleGraph (Fin n), G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧
      G.maxDegree^2 ≤ 857435524*n := by
  obtain ⟨k, hm, hnm⟩ := exists_family_below hn
  obtain ⟨G, ht, hd, hdeg⟩ := family k
  have hm2 : 2 ≤ (11^(2*k+1))^2 := by
    rw [family_order]
    have hp : 1 ≤ 14641^k := Nat.one_le_pow _ _ (by decide)
    omega
  obtain ⟨H, hHt, hHd, hHdeg⟩ := exists_blowup (c := 14641) hm2 hm
    (by simpa [mul_comm] using hnm.le) G ht hd
  refine ⟨H,hHt,hHd,?_⟩
  have hbound : H.maxDegree ≤ 29282*11^(2*k+1) := by
    exact hHdeg.trans (by nlinarith)
  have hs := Nat.pow_le_pow_left hbound 2
  nlinarith

/-- The asymptotic answer: the minimum possible maximum degree is of order sqrt(n).
The lower bound is universal and the upper bound exhibits a graph at every n≥121. -/
theorem answer : ∀ n : ℕ, 121 ≤ n →
    (∀ G : SimpleGraph (Fin n), G.CliqueFree 3 → G.ediam ≤ 2 → n ≤ G.maxDegree^2+1) ∧
    (∃ G : SimpleGraph (Fin n), G.CliqueFree 3 ∧ G.ediam ≤ 2 ∧
      G.maxDegree^2 ≤ 857435524*n) := by
  intro n hn
  refine ⟨?_, upper_bound n hn⟩
  intro G _ hd
  simpa using moore_bound_of_ediam_le_two G hd

end
end Jsp.Graph139Upper
