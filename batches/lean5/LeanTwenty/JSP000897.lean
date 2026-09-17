import LeanTwenty.Upstream.Erdos1079

/-!
# JSP-000897 / Erdős 1079

A graph at the Turán threshold has a vertex with linear degree and a
neighborhood at the next Turán threshold. Above the threshold, both edge
inequalities are strict. The chosen vertex has maximum degree.
The Apache-licensed upstream proof is attributed and pinned in NOTICE.md.
-/

namespace JSP000897

open Classical in
theorem solution {n r : ℕ} (hr : 4 ≤ r) (hn : 2 ≤ n)
    (G : SimpleGraph (Fin n))
    (hG : Erdos1079.cliqueExtremalNumber n r ≤ Erdos1079.edgeCount G) :
    ∃ v : Fin n, G.degree v = G.maxDegree ∧ n ≤ 2 * G.degree v ∧
      Erdos1079.cliqueExtremalNumber (G.degree v) (r - 1) ≤
        Erdos1079.linkEdgeCount G v :=
  Erdos1079.erdos_problem_1079 hr hn G hG

open Classical in
theorem strict_solution {n r : ℕ} (hr : 4 ≤ r) (hn : 2 ≤ n)
    (G : SimpleGraph (Fin n))
    (hG : Erdos1079.cliqueExtremalNumber n r < Erdos1079.edgeCount G) :
    ∃ v : Fin n, G.degree v = G.maxDegree ∧ n ≤ 2 * G.degree v ∧
      Erdos1079.cliqueExtremalNumber (G.degree v) (r - 1) <
        Erdos1079.linkEdgeCount G v :=
  Erdos1079.erdos_1079 hr hn G hG

#print axioms solution
#print axioms strict_solution

end JSP000897
