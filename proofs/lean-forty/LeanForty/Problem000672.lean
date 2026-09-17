import ErdosProblems.Erdos815

/-! JSP-000672 / Erdős815: arbitrarily large degree-three-critical graphs
without a 23-cycle, disproving the proposed eventual all-length assertion. -/

namespace LeanForty.Problem000672

open SimpleGraph
noncomputable section
attribute [local instance] Classical.propDecidable Classical.decEq

theorem eventual_all_cycles_false : ¬ Erdos815.Erdos815Statement :=
  Erdos815.not_erdos_815

/-- Every requested size threshold is surpassed by an actual C23-free graph
with exactly 2n-2 edges and the required criticality for all proper subsets. -/
theorem arbitrarily_large_counterexamples (N : ℕ) :
    ∃ n ≥ N, ∃ G : SimpleGraph (Fin n),
      G.edgeFinset.card = 2 * n - 2 ∧
      (∀ s : Set (Fin n), s ≠ Set.univ → (G.induce s).minDegree ≤ 2) ∧
      ∀ (v : Fin n) (w : G.Walk v v), w.IsCycle → w.length ≠ 23 := by
  obtain ⟨n, hn, G, hG, hfree⟩ :=
    Erdos815.arbitraryCounterexamples_to_fin Erdos815.nps_arbitrarily_large_counterexamples N
  refine ⟨n, hn, G, ?_, hG.2, ?_⟩
  · simpa using hG.1
  · intro v w hw hlen
    exact hfree ((SimpleGraph.cycleGraph_isContained_iff (by decide : 2 < 23)).mpr
      ⟨v, w, hw, hlen⟩)

/-- On each nonempty proper vertex set the minimum-degree condition supplies
a concrete vertex of degree at most two. -/
theorem proper_subset_low_degree {V : Type*} [Fintype V] (G : SimpleGraph V)
    (hG : Erdos815.DegreeThreeCritical G) (s : Set V)
    (hne : s.Nonempty) (hproper : s ≠ Set.univ) :
    ∃ v : s, (G.induce s).degree v ≤ 2 := by
  letI : Nonempty s := hne.to_subtype
  obtain ⟨v, hv⟩ := (G.induce s).exists_minimal_degree_vertex
  exact ⟨v, hv ▸ hG.2 s hproper⟩

end
end LeanForty.Problem000672
