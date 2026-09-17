import ErdosProblems.Erdos833

/-! JSP-000689 / Erdős833. Uniform hypergraphs of chromatic number three
have an exponentially large vertex degree, with one absolute base 10/9. -/

namespace LeanForty.Problem000689

universe u
variable {V : Type u} [Fintype V] [DecidableEq V]

/-- The same explicit absolute base works for all ranks r≥2. -/
theorem exponential_degree (H : Erdos833.Hypergraph V) (r : ℕ) (hr : 2 ≤ r)
    (hu : Erdos833.IsUniform H r) (hχ : Erdos833.HasChromaticNumber H 3) :
    ∃ v : V, ((10 : ℝ) / 9) ^ r ≤ Erdos833.degree H v := by
  have hn : ¬ Erdos833.Colorable H 2 := hχ.2 2 (by omega)
  by_cases hs : r ≤ 6
  · obtain ⟨v, hv⟩ := Erdos833.exists_degree_two_of_not_colorable H r hr hu hn
    exact ⟨v, (Erdos833.ten_ninth_pow_le_two hs).trans (by exact_mod_cast hv)⟩
  · obtain ⟨v, hv⟩ := Erdos833.erdos_lovasz_degree_bound_real H r hr hu hn
    exact ⟨v, (Erdos833.ten_ninth_pow_le_erdos_bound (by omega)).trans hv⟩

/-- Quantitative Erdős–Lovász estimate, for every non-two-colorable uniform hypergraph. -/
theorem erdos_lovasz_bound (H : Erdos833.Hypergraph V) (r : ℕ) (hr : 2 ≤ r)
    (hu : Erdos833.IsUniform H r) (hn : ¬Erdos833.Colorable H 2) :
    ∃ v : V, (2 : ℝ) ^ (r - 1) / (4 * r) ≤ Erdos833.degree H v :=
  Erdos833.erdos_lovasz_degree_bound_real H r hr hu hn

/-- Degree counts exactly the distinct edges in the hypergraph containing v. -/
theorem explicit_incident_edge_count (H : Erdos833.Hypergraph V) (r : ℕ) (hr : 2 ≤ r)
    (hu : Erdos833.IsUniform H r) (hχ : Erdos833.HasChromaticNumber H 3) :
    ∃ v : V, ((10 : ℝ) / 9) ^ r ≤ ((H.filter fun e => v ∈ e).card : ℝ) :=
  exponential_degree H r hr hu hχ

end LeanForty.Problem000689
