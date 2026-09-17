import LeanTwenty.Upstream.Erdos1216

/-!
# JSP-001021 / Erdős problem 1216

Reid–Parker's counterexample to the proposed extremal formula is `f 14 = 5`,
whereas `floor(log₂ 14) + 1 = 4`. The imported proof checks its finite
classification certificates in Lean's kernel.

This file also transfers its bit-vector tournament theorem to an arbitrary
finite type with a tournament relation, making the encoding's coverage explicit.
-/

namespace JSP001021

/-- Exactly one of the two directions is present between distinct vertices. -/
def IsTournament {α : Type*} (R : α → α → Prop) : Prop :=
  (∀ x, ¬ R x x) ∧ ∀ x y, x ≠ y → (R x y ↔ ¬ R y x)

noncomputable section
attribute [local instance] Classical.propDecidable

open Erdos1216

private def matrixBit (R : Fin 14 → Fin 14 → Prop) (k : Fin 196) : Bool := by
  classical
  exact decide (R ⟨k.val / 14, by omega⟩ ⟨k.val % 14, by omega⟩)

private def encode (R : Fin 14 → Fin 14 → Prop) : Tournament 14 :=
  BitVec.cast List.length_ofFn (BitVec.ofBoolListLE (List.ofFn (matrixBit R)))

private lemma encode_get (R : Fin 14 → Fin 14 → Prop) (i j : Fin 14) :
    (encode R).getLsbD (i.val * 14 + j.val) = decide (R i j) := by
  classical
  have hidx : i.val * 14 + j.val < 196 := by omega
  have hdiv : (i.val * 14 + j.val) / 14 = i.val := by omega
  have hmod : (i.val * 14 + j.val) % 14 = j.val := by omega
  simp only [encode, BitVec.getLsbD_cast, BitVec.getLsbD_ofBoolListLE,
    List.getD_eq_getElem?_getD, List.getElem?_ofFn, hidx, ↓reduceDIte,
    Option.getD_some, matrixBit]
  congr 2 <;> apply Fin.ext <;> assumption

private lemma encode_arc (R : Fin 14 → Fin 14 → Prop) (hR : IsTournament R)
    (i j : Fin 14) : (encode R).arc i j = true ↔ R i j := by
  classical
  by_cases hij : i = j
  · subst j
    simp [Tournament.arc, hR.1]
  · by_cases hlt : i < j
    · simp [Tournament.arc, hij, hlt, encode_get]
    · simp only [Tournament.arc, hij, hlt, ↓reduceIte, encode_get]
      by_cases hji : R j i <;> simp [hji, hR.2 i j hij]

/-- Every tournament on fourteen labeled vertices contains a transitive five-set. -/
theorem labeled_fourteen (R : Fin 14 → Fin 14 → Prop) (hR : IsTournament R) :
    ∃ v : Fin 5 → Fin 14, Function.Injective v ∧
      ∀ i j, i < j → R (v i) (v j) := by
  obtain ⟨v, hv, he⟩ := directed_ramsey_five_fourteen.2 (encode R)
  exact ⟨v, hv, fun i j hij => (encode_arc R hR _ _).mp (he i j hij)⟩

/-- The result applies to every finite tournament, independently of its labels. -/
theorem every_fourteen {α : Type*} [Fintype α] (hcard : Fintype.card α = 14)
    (R : α → α → Prop) (hR : IsTournament R) :
    ∃ v : Fin 5 → α, Function.Injective v ∧
      ∀ i j, i < j → R (v i) (v j) := by
  let e := (Fintype.equivFinOfCardEq hcard).symm
  let S : Fin 14 → Fin 14 → Prop := fun i j => R (e i) (e j)
  have hS : IsTournament S := by
    refine ⟨fun i => hR.1 (e i), ?_⟩
    intro i j hij
    exact hR.2 (e i) (e j) (fun he => hij (e.injective he))
  obtain ⟨v, hv, he⟩ := labeled_fourteen S hS
  exact ⟨e ∘ v, e.injective.comp hv, he⟩

/-- The exact value and the negative answer to the original equality conjecture. -/
theorem solution : Erdos1216.f 14 = 5 ∧ ¬ Erdos1216.ProposedFormula :=
  ⟨Erdos1216.f_fourteen_eq_five, Erdos1216.not_erdos_1216⟩

end

end JSP001021
