import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Tactic

/-!
# JSP-000759 / Erdős problem 915

The assertion for internally vertex-disjoint paths is false. We verify a
17-vertex, 41-edge counterexample. Its only vertices of degree at least five
are 0, 1, 2; deleting the direct edge between any two of them leaves a
separator of size three. This mathematical witness was recorded in
plby/lean-proofs, Erdős915 (revision 8822f7ddef30fadbd92e1c6ab4ed897af356af5e);
the formal proof below is independently authored using a general separator bound.

The historical internally disjoint interpretation is the k-rail problem of
Bollobás–Erdős, disproved by Leonard and studied by Sørensen–Thomassen.
-/

namespace JSP000759

open scoped Sym2

variable {V : Type*} {G : SimpleGraph V} {u v : V}

/-- Membership in the interior excludes both endpoints. -/
def Interior (p : G.Path u v) (x : V) : Prop :=
  x ∈ p.val.support ∧ x ≠ u ∧ x ≠ v

/-- All paths are distinct, including any path consisting of a single edge. -/
def DisjointFamily {m : ℕ} (p : Fin m → G.Path u v) : Prop :=
  Function.Injective p ∧
    ∀ i j, i ≠ j → ∀ x, Interior (p i) x → ¬ Interior (p j) x

def HasPaths (G : SimpleGraph V) (m : ℕ) : Prop :=
  ∃ u v, u ≠ v ∧ ∃ p : Fin m → G.Path u v, DisjointFamily p

/-- The exact finite assertion from the original problem. -/
def ProposedClaim : Prop :=
  ∀ m n : ℕ, 2 ≤ m → 1 ≤ n →
    ∀ (V : Type) [Fintype V] (G : SimpleGraph V),
      Fintype.card V = 1 + n * (m - 1) →
      G.edgeSet.ncard = 1 + n * Nat.choose m 2 → HasPaths G m

private lemma first_step_internal (p : G.Path u v) (hne : u ≠ v)
    (hend : p.val.snd ≠ v) : Interior p p.val.snd := by
  have hadj := p.val.adj_snd (SimpleGraph.Walk.not_nil_of_ne hne)
  exact ⟨List.mem_of_mem_tail (p.val.snd_mem_tail_support
    (SimpleGraph.Walk.not_nil_of_ne hne)), hadj.ne.symm, hend⟩

private lemma degree_bound [Fintype V] [DecidableRel G.Adj]
    {m : ℕ} (hne : u ≠ v) (p : Fin m → G.Path u v)
    (hp : DisjointFamily p) : m ≤ G.degree u := by
  classical
  let next : Fin m → G.neighborSet u := fun i =>
    ⟨(p i).val.snd, (p i).val.adj_snd (SimpleGraph.Walk.not_nil_of_ne hne)⟩
  have hinj : Function.Injective next := by
    intro i j heq
    have hs : (p i).val.snd = (p j).val.snd := congrArg Subtype.val heq
    by_cases hi : (p i).val.snd = v
    · have short (k : Fin m) (hk : (p k).val.snd = v) : (p k).val.length ≤ 1 := by
        have hmem := (p k).val.mk_start_snd_mem_edges
          (SimpleGraph.Walk.not_nil_of_ne hne)
        rw [hk] at hmem
        exact ((p k).property.length_eq_one_of_mem_edges hmem).le
      apply hp.1
      exact Subtype.ext (SimpleGraph.Walk.eq_of_length_le_one (short i hi)
        (short j (hs.symm.trans hi)))
    · by_contra hij
      exact hp.2 i j hij _ (first_step_internal _ hne hi)
        (hs ▸ first_step_internal (p j) hne (hs.symm ▸ hi))
  simpa only [Fintype.card_fin, G.card_neighborSet_eq_degree] using
    Fintype.card_le_of_injective next hinj

private lemma family_reverse {m : ℕ} {p : Fin m → G.Path u v}
    (hp : DisjointFamily p) : DisjointFamily (fun i => (p i).reverse) := by
  constructor
  · intro i j heq
    apply hp.1
    apply Subtype.ext
    exact SimpleGraph.Walk.reverse_injective (congrArg Subtype.val heq)
  · intro i j hij x hi hj
    apply hp.2 i j hij x
    · simpa [Interior, and_comm, and_left_comm] using hi
    · simpa [Interior, and_comm, and_left_comm] using hj

/-- A path meeting a small interior hitting set, with at most one direct
path as exception, occupies one of at most `S.card + 1` distinct slots. -/
private lemma hitting_bound [DecidableEq V] {m : ℕ}
    (p : Fin m → G.Path u v) (hp : DisjointFamily p) (S : Finset V)
    (hit : ∀ i, (p i).val.length ≤ 1 ∨ ∃ x ∈ S, Interior (p i) x) :
    m ≤ S.card + 1 := by
  classical
  have pick (i : Fin m) : ∃ slot : Option S,
      (slot = none → (p i).val.length ≤ 1) ∧
      (∀ x : S, slot = some x → Interior (p i) x) := by
    rcases hit i with hi | ⟨x, hx, hxi⟩
    · exact ⟨none, fun _ => hi, by simp⟩
    · exact ⟨some ⟨x, hx⟩, by simp, by simpa using hxi⟩
  choose slot hshort hinterior using pick
  have hinj : Function.Injective slot := by
    intro i j hij
    cases hsi : slot i with
    | none =>
      apply hp.1
      exact Subtype.ext (SimpleGraph.Walk.eq_of_length_le_one
        (hshort i hsi) (hshort j (hij.symm.trans hsi)))
    | some x =>
      by_contra hne
      exact hp.2 i j hne x (hinterior i x hsi)
        (hinterior j x (hij.symm.trans hsi))
  simpa using Fintype.card_le_of_injective slot hinj

/-- A walk avoiding both a separator and one exceptional edge remains on
one side of any cut whose only crossing edge is that exception. -/
private lemma side_constant [DecidableEq V] (S : Finset V) (side : V → Bool)
    (edge : Sym2 V)
    (cut : ∀ x y, G.Adj x y → x ∉ S → y ∉ S → s(x,y) ≠ edge →
      side x = side y) {a b : V} (w : G.Walk a b)
    (avoid : ∀ x ∈ w.support, x ∉ S) (noedge : edge ∉ w.edges) :
    side a = side b := by
  induction w with
  | nil => rfl
  | @cons a c b hac w ih =>
    have ac : side a = side c := cut a c hac (avoid a (by simp))
      (avoid c (by simp)) (by intro h; apply noedge; simp [h])
    exact ac.trans (ih (fun x hx => avoid x (by simp [hx]))
      (fun h => noedge (by simp [h])))

private lemma separator_hits [DecidableEq V] (S : Finset V) (side : V → Bool)
    (hu : u ∉ S) (hv : v ∉ S) (hdiff : side u ≠ side v)
    (cut : ∀ x y, G.Adj x y → x ∉ S → y ∉ S → s(x,y) ≠ s(u,v) →
      side x = side y) (p : G.Path u v) :
    p.val.length ≤ 1 ∨ ∃ x ∈ S, Interior p x := by
  classical
  by_cases he : s(u,v) ∈ p.val.edges
  · exact Or.inl (p.property.length_eq_one_of_mem_edges he).le
  · right
    by_contra hn
    apply hdiff
    apply side_constant S side s(u,v) cut p.val ?_ he
    intro x hx hS
    apply hn
    exact ⟨x, hS, hx, fun h => hu (h ▸ hS), fun h => hv (h ▸ hS)⟩

private def edges : Finset (ℕ × ℕ) :=
  {(0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8),
   (0, 13), (0, 14), (1, 2), (1, 3), (1, 4), (1, 9), (1, 10), (1, 11),
   (1, 12), (2, 9), (2, 10), (2, 13), (2, 14), (2, 15), (2, 16),
   (3, 5), (3, 8), (4, 6), (4, 7), (5, 6), (5, 7), (6, 8), (7, 8),
   (9, 11), (9, 12), (10, 11), (10, 12), (11, 12),
   (13, 15), (13, 16), (14, 15), (14, 16), (15, 16)}

/-- Explicit graph, given by 41 undirected edges on 17 vertices. -/
def witness : SimpleGraph (Fin 17) where
  Adj x y := x ≠ y ∧ ((x.val, y.val) ∈ edges ∨ (y.val, x.val) ∈ edges)
  symm.symm x y h := ⟨h.1.symm, h.2.symm⟩
  loopless.irrefl x h := h.1 rfl

instance : DecidableRel witness.Adj := fun _ _ =>
  inferInstanceAs (Decidable (_ ≠ _ ∧ (_ ∈ edges ∨ _ ∈ edges)))

set_option maxRecDepth 10000
set_option maxHeartbeats 0

theorem edge_count : witness.edgeSet.ncard = 41 := by
  rw [Set.ncard_eq_toFinset_card']
  decide +kernel

private lemma low_degree : ∀ x : Fin 17, x ≠ 0 → x ≠ 1 → x ≠ 2 →
    witness.degree x = 4 := by
  decide +kernel

private def separator (k : Fin 3) : Finset (Fin 17) :=
  ![{2, 3, 4}, {0, 9, 10}, {1, 13, 14}] k

private def leftEnd (k : Fin 3) : Fin 17 := ![0, 1, 2] k
private def rightEnd (k : Fin 3) : Fin 17 := ![1, 2, 0] k
private def partition (k : Fin 3) (x : Fin 17) : Bool :=
  decide (x ∈ (![{1, 9, 10, 11, 12}, {2, 13, 14, 15, 16},
    {0, 3, 4, 5, 6, 7, 8}] k : Finset (Fin 17)))

private lemma cut_certificate : ∀ k : Fin 3,
    (separator k).card = 3 ∧ leftEnd k ∉ separator k ∧
    rightEnd k ∉ separator k ∧ partition k (leftEnd k) ≠ partition k (rightEnd k) ∧
    ∀ x y : Fin 17, witness.Adj x y → x ∉ separator k → y ∉ separator k →
      s(x,y) ≠ s(leftEnd k, rightEnd k) → partition k x = partition k y := by
  decide +kernel

private lemma no_five_at_cut (k : Fin 3) :
    ¬ ∃ p : Fin 5 → witness.Path (leftEnd k) (rightEnd k), DisjointFamily p := by
  rintro ⟨p, hp⟩
  obtain ⟨hcard, hu, hv, hdiff, hcut⟩ := cut_certificate k
  have hle := hitting_bound p hp (separator k) (fun i =>
    separator_hits (separator k) (partition k) hu hv hdiff hcut (p i))
  omega

private lemma no_five_at_cut_reverse (k : Fin 3) :
    ¬ ∃ p : Fin 5 → witness.Path (rightEnd k) (leftEnd k), DisjointFamily p := by
  rintro ⟨p, hp⟩
  exact no_five_at_cut k ⟨fun i => (p i).reverse, family_reverse hp⟩

/-- All pairs of distinct endpoints fail to support five internally disjoint paths. -/
theorem no_five_paths : ¬ HasPaths witness 5 := by
  rintro ⟨u, v, huv, p, hp⟩
  have hu : u = 0 ∨ u = 1 ∨ u = 2 := by
    by_contra hn
    have hd := low_degree u (by tauto) (by tauto) (by tauto)
    have hb := degree_bound huv p hp
    omega
  have hv : v = 0 ∨ v = 1 ∨ v = 2 := by
    by_contra hn
    have hd := low_degree v (by tauto) (by tauto) (by tauto)
    have hb := degree_bound huv.symm (fun i => (p i).reverse) (family_reverse hp)
    omega
  rcases hu with rfl | rfl | rfl <;> rcases hv with rfl | rfl | rfl
  · exact huv rfl
  · exact no_five_at_cut 0 ⟨p, hp⟩
  · exact no_five_at_cut_reverse 2 ⟨p, hp⟩
  · exact no_five_at_cut_reverse 0 ⟨p, hp⟩
  · exact huv rfl
  · exact no_five_at_cut 1 ⟨p, hp⟩
  · exact no_five_at_cut 2 ⟨p, hp⟩
  · exact no_five_at_cut_reverse 1 ⟨p, hp⟩
  · exact huv rfl

/-- Negative answer to the internally vertex-disjoint path assertion. -/
theorem solution : ¬ ProposedClaim := by
  intro h
  exact no_five_paths (h 5 4 (by omega) (by omega) (Fin 17) witness
    (by decide) (by norm_num; exact edge_count))

#print axioms solution
#print axioms no_five_paths

end JSP000759
