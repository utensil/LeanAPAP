import Mathlib.GroupTheory.OrderOfElement
import LeanAPAP.Mathlib.Algebra.GroupPower.Order

/-!
### TODO

Rename `exists_pow_eq_one` to `isOfFinOrder_of_finite`
-/

open Fintype Function

section Monoid
variable {α : Type*} [Monoid α] {a : α}

lemma IsOfFinOrder.pow {n : ℕ} : IsOfFinOrder a → IsOfFinOrder (a ^ n) := by
  simp_rw [isOfFinOrder_iff_pow_eq_one]
  rintro ⟨m, hm, ha⟩
  exact ⟨m, hm, by simp [pow_right_comm _ n, ha]⟩

end Monoid

section Group
variable {α : Type*} [Group α] [Fintype α] {n : ℕ}

@[to_additive (attr := simp) mod_card_nsmul]
lemma pow_mod_card (a : α) (n : ℕ) : a ^ (n % card α) = a ^ n :=
  mul_left_injective (a ^ (card α * (n / card α))) $ by
    simp_rw [←pow_add, Nat.mod_add_div, pow_add, pow_mul, pow_card_eq_one, one_pow, mul_one]

@[to_additive]
lemma Nat.Coprime.pow_bijective (hn : n.Coprime (card α)) : Bijective fun a : α ↦ a ^ n := by
  refine' (bijective_iff_injective_and_card _).2 ⟨_, rfl⟩
  cases subsingleton_or_nontrivial α
  · exact injective_of_subsingleton _
  obtain ⟨m, hm⟩ := Nat.exists_mul_emod_eq_one_of_coprime hn Fintype.one_lt_card
  refine' LeftInverse.injective fun a ↦ _
  · exact fun a ↦ a ^ m
  rw [←pow_mul, ←pow_mod_card, hm, pow_one]

end Group

section LinearOrderedSemiring
variable {α : Type*} [LinearOrderedSemiring α] {a : α}

protected lemma IsOfFinOrder.eq_one (ha₀ : 0 ≤ a) : IsOfFinOrder a → a = 1 := by
  rw [isOfFinOrder_iff_pow_eq_one]
  rintro ⟨n, hn, ha⟩
  exact (pow_eq_one_iff_of_nonneg ha₀ hn.ne').1 ha

end LinearOrderedSemiring

section LinearOrderedRing
variable {α : Type*} [LinearOrderedRing α] {a : α}

protected lemma IsOfFinOrder.eq_neg_one (ha₀ : a ≤ 0) (ha : IsOfFinOrder a) : a = -1 :=
  (sq_eq_one_iff.1 $ ha.pow.eq_one $ sq_nonneg a).resolve_left $ by
    rintro rfl; exact one_pos.not_le ha₀

end LinearOrderedRing
