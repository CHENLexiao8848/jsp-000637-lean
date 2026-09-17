import ErdosProblems.Erdos832

/-! JSP-000688's linked current catalog entry / Erdős832.
The workbook title mentions the distinct fixed-three-color problem; this
module proves the linked large-chromatic-number conjecture false at rank four.
The scope discrepancy is tracked separately and is not erased by compilation. -/

namespace LeanForty.Problem000688

theorem binomial_conjecture_false : ¬ Erdos832.Erdos832Claim :=
  Erdos832.not_erdos_832

/-- Arbitrarily large exact chromatic numbers violate the lower bound itself,
not merely its proposed equality characterization. -/
theorem strict_counterexamples (K : ℕ) :
    ∃ k ≥ K, ∃ H : Erdos832.FiniteHypergraph,
      H.IsUniform 4 ∧ H.HasChromaticNumber k ∧
        H.edges.card < (3 * (k - 1) + 1).choose 4 := by
  let n := K + 9
  let k := 2 ^ n
  let H := Erdos832.constructionHypergraph (n + 1)
  have hn : 9 ≤ n := by omega
  have hk512 : 512 ≤ k := by
    change 2 ^ 9 ≤ 2 ^ n
    exact Nat.pow_le_pow_right (by decide) hn
  have hKpow : K ≤ 2 ^ K := by
    have h := Nat.mul_le_pow (a := 2) (by decide) K
    omega
  have hKk : K ≤ k := hKpow.trans (Nat.pow_le_pow_right (by decide) (by omega))
  have hbad : ¬H.Colorable (k - 1) := Erdos832.construction_not_colorable n
  obtain ⟨H', _, hcard, huniform, hchi⟩ :=
    Erdos832.FiniteHypergraph.exists_spanning_exact_chromatic
      (H := H) (r := 4) (k := k) (by omega) (by omega)
      (Erdos832.constructionHypergraph_uniform (n + 1)) hbad
  exact ⟨k, hKk, H', huniform, hchi,
    hcard.trans_lt (Erdos832.construction_strict_bound n hn)⟩

end LeanForty.Problem000688
