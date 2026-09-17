import Mathlib.Combinatorics.SimpleGraph.Clique
import Mathlib.Tactic
import Mathlib.Tactic.Sat.FromLRAT

/-!
# JSP-000746 / Erdos 895

For all n >= 18, every triangle-free graph on labels 1,...,n contains
three distinct independent vertices a, b, a+b. The finite threshold was
reported by Ben Barber: https://www.erdosproblems.com/895 .

The SAT instance and LRAT certificate are generated locally. The certificate
is translated to ordinary proof terms and checked by Lean's kernel.
-/

namespace JSP000746

def IndependentSum {n : Nat} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ a b c : Fin n, a.val < b.val ∧ c.val = a.val + b.val + 1 ∧
    ¬G.Adj a b ∧ ¬G.Adj a c ∧ ¬G.Adj b c

set_option maxHeartbeats 0
set_option maxRecDepth 10000

lrat_proof finite_certificate
  (include_str "Certificates/JSP000746.cnf")
  (include_str "Certificates/JSP000746.lrat")

theorem eighteen (G : SimpleGraph (Fin 18)) (hG : G.CliqueFree 3) :
    IndependentSum G := by
  by_contra hno
  have htriangle (i j k : Fin 18) : ¬(G.Adj i j ∧ G.Adj i k ∧ G.Adj j k) := by
    intro h
    exact hG {i,j,k} (SimpleGraph.is3Clique_triple_iff.mpr h)
  have hsum (i j k : Fin 18) (hij : i.val < j.val)
      (hk : k.val = i.val + j.val + 1) :
      ¬(¬G.Adj i j ∧ ¬G.Adj i k ∧ ¬G.Adj j k) := by
    intro h
    exact hno ⟨i,j,k,hij,hk,h⟩
  have h := finite_certificate
    (G.Adj 0 1)
    (G.Adj 0 2)
    (G.Adj 0 3)
    (G.Adj 0 4)
    (G.Adj 0 5)
    (G.Adj 0 6)
    (G.Adj 0 7)
    (G.Adj 0 8)
    (G.Adj 0 9)
    (G.Adj 0 10)
    (G.Adj 0 11)
    (G.Adj 0 12)
    (G.Adj 0 13)
    (G.Adj 0 14)
    (G.Adj 0 15)
    (G.Adj 0 16)
    (G.Adj 0 17)
    (G.Adj 1 2)
    (G.Adj 1 3)
    (G.Adj 1 4)
    (G.Adj 1 5)
    (G.Adj 1 6)
    (G.Adj 1 7)
    (G.Adj 1 8)
    (G.Adj 1 9)
    (G.Adj 1 10)
    (G.Adj 1 11)
    (G.Adj 1 12)
    (G.Adj 1 13)
    (G.Adj 1 14)
    (G.Adj 1 15)
    (G.Adj 1 16)
    (G.Adj 1 17)
    (G.Adj 2 3)
    (G.Adj 2 4)
    (G.Adj 2 5)
    (G.Adj 2 6)
    (G.Adj 2 7)
    (G.Adj 2 8)
    (G.Adj 2 9)
    (G.Adj 2 10)
    (G.Adj 2 11)
    (G.Adj 2 12)
    (G.Adj 2 13)
    (G.Adj 2 14)
    (G.Adj 2 15)
    (G.Adj 2 16)
    (G.Adj 2 17)
    (G.Adj 3 4)
    (G.Adj 3 5)
    (G.Adj 3 6)
    (G.Adj 3 7)
    (G.Adj 3 8)
    (G.Adj 3 9)
    (G.Adj 3 10)
    (G.Adj 3 11)
    (G.Adj 3 12)
    (G.Adj 3 13)
    (G.Adj 3 14)
    (G.Adj 3 15)
    (G.Adj 3 16)
    (G.Adj 3 17)
    (G.Adj 4 5)
    (G.Adj 4 6)
    (G.Adj 4 7)
    (G.Adj 4 8)
    (G.Adj 4 9)
    (G.Adj 4 10)
    (G.Adj 4 11)
    (G.Adj 4 12)
    (G.Adj 4 13)
    (G.Adj 4 14)
    (G.Adj 4 15)
    (G.Adj 4 16)
    (G.Adj 4 17)
    (G.Adj 5 6)
    (G.Adj 5 7)
    (G.Adj 5 8)
    (G.Adj 5 9)
    (G.Adj 5 10)
    (G.Adj 5 11)
    (G.Adj 5 12)
    (G.Adj 5 13)
    (G.Adj 5 14)
    (G.Adj 5 15)
    (G.Adj 5 16)
    (G.Adj 5 17)
    (G.Adj 6 7)
    (G.Adj 6 8)
    (G.Adj 6 9)
    (G.Adj 6 10)
    (G.Adj 6 11)
    (G.Adj 6 12)
    (G.Adj 6 13)
    (G.Adj 6 14)
    (G.Adj 6 15)
    (G.Adj 6 16)
    (G.Adj 6 17)
    (G.Adj 7 8)
    (G.Adj 7 9)
    (G.Adj 7 10)
    (G.Adj 7 11)
    (G.Adj 7 12)
    (G.Adj 7 13)
    (G.Adj 7 14)
    (G.Adj 7 15)
    (G.Adj 7 16)
    (G.Adj 7 17)
    (G.Adj 8 9)
    (G.Adj 8 10)
    (G.Adj 8 11)
    (G.Adj 8 12)
    (G.Adj 8 13)
    (G.Adj 8 14)
    (G.Adj 8 15)
    (G.Adj 8 16)
    (G.Adj 8 17)
    (G.Adj 9 10)
    (G.Adj 9 11)
    (G.Adj 9 12)
    (G.Adj 9 13)
    (G.Adj 9 14)
    (G.Adj 9 15)
    (G.Adj 9 16)
    (G.Adj 9 17)
    (G.Adj 10 11)
    (G.Adj 10 12)
    (G.Adj 10 13)
    (G.Adj 10 14)
    (G.Adj 10 15)
    (G.Adj 10 16)
    (G.Adj 10 17)
    (G.Adj 11 12)
    (G.Adj 11 13)
    (G.Adj 11 14)
    (G.Adj 11 15)
    (G.Adj 11 16)
    (G.Adj 11 17)
    (G.Adj 12 13)
    (G.Adj 12 14)
    (G.Adj 12 15)
    (G.Adj 12 16)
    (G.Adj 12 17)
    (G.Adj 13 14)
    (G.Adj 13 15)
    (G.Adj 13 16)
    (G.Adj 13 17)
    (G.Adj 14 15)
    (G.Adj 14 16)
    (G.Adj 14 17)
    (G.Adj 15 16)
    (G.Adj 15 17)
    (G.Adj 16 17)
  simp (disch := decide) only [htriangle, hsum, or_false] at h

theorem finite_bound {n : Nat} (hn : 18 ≤ n)
    (G : SimpleGraph (Fin n)) (hG : G.CliqueFree 3) : IndependentSum G := by
  let e : Fin 18 ↪ Fin n := Fin.castLEEmb hn
  let H := G.comap e
  have hH : H.CliqueFree 3 :=
    hG.comap (SimpleGraph.Embedding.comap e G).isContained
  obtain ⟨a,b,c,hab,hc,hab',hac',hbc'⟩ := eighteen H hH
  exact ⟨e a,e b,e c,hab,hc,hab',hac',hbc'⟩

theorem erdos_895 : ∃ N : Nat, ∀ n ≥ N, ∀ G : SimpleGraph (Fin n),
    G.CliqueFree 3 → IndependentSum G :=
  ⟨18, fun _ hn G hG => finite_bound hn G hG⟩

/-- The integer-vertex version in the spreadsheet, with positive distinct
vertices and an explicit bound on their sum. -/
theorem on_integers (G : SimpleGraph ℤ) (hG : G.CliqueFree 3) :
    ∃ a b : ℤ, 0 < a ∧ a < b ∧ a + b ≤ 18 ∧
      ¬G.Adj a b ∧ ¬G.Adj a (a+b) ∧ ¬G.Adj b (a+b) := by
  let e : Fin 18 ↪ ℤ :=
    ⟨fun i => (i.val : ℤ) + 1, by
      intro i j h
      apply Fin.ext
      dsimp at h
      omega⟩
  have hH : (G.comap e).CliqueFree 3 :=
    hG.comap (SimpleGraph.Embedding.comap e G).isContained
  obtain ⟨a,b,c,hab,hc,hab',hac',hbc'⟩ := eighteen (G.comap e) hH
  have hc' : e c = e a + e b := by
    change (c.val : ℤ) + 1 = ((a.val : ℤ) + 1) + ((b.val : ℤ) + 1)
    omega
  refine ⟨e a,e b,?_,?_,?_,hab',?_,?_⟩
  · change 0 < (a.val : ℤ) + 1
    omega
  · change (a.val : ℤ) + 1 < (b.val : ℤ) + 1
    omega
  · rw [← hc']
    change (c.val : ℤ) + 1 ≤ 18
    omega
  · simpa only [SimpleGraph.comap_adj, hc'] using hac'
  · simpa only [SimpleGraph.comap_adj, hc'] using hbc'

#print axioms finite_certificate
#print axioms erdos_895
#print axioms on_integers

end JSP000746
