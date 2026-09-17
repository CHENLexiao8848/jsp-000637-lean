import LeanTwenty.Upstream.Erdos1078

/-!
# JSP-000896 / Erdős 1078

Haxell's sufficient degree threshold for a balanced multipartite graph.
The integer inequality avoids rounding and division: the missing degree is
strictly less than `r*n/(2*(r-1))`. This is the published asymptotic threshold,
not a claim that the later exact threshold is also sharp here.
The Apache-licensed upstream proof is attributed and pinned in NOTICE.md.
-/

namespace JSP000896

theorem solution {r n : ℕ} (hr : 2 ≤ r) (hn : 0 < n)
    (G : SimpleGraph (Fin r × Fin n))
    (hpart : Erdos1078.IsPartite G Prod.fst)
    (hdegree : ∀ x,
      2 * (r - 1) * ((r - 1) * n - Erdos1078.graphDegree G x) < r * n) :
    ∃ f : Fin r → Fin r × Fin n,
      (∀ i, (f i).1 = i) ∧ ∀ i j, i ≠ j → G.Adj (f i) (f j) :=
  Erdos1078.erdos_1078 hr hn G hpart hdegree

#print axioms solution

end JSP000896
