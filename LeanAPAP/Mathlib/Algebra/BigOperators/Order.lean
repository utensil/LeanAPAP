import Mathlib.Algebra.BigOperators.Order
import Mathlib.Algebra.BigOperators.Ring

open scoped BigOperators

namespace Finset
variable {α 𝕜 : Type*} [LinearOrderedCommRing 𝕜]

lemma sum_mul_sq_le_sq_mul_sq (s : Finset α) (f g : α → 𝕜) :
    (∑ i in s, f i * g i) ^ 2 ≤ (∑ i in s, f i ^ 2) * ∑ i in s, g i ^ 2 := by
  have h : 0 ≤ ∑ i in s, (f i * ∑ j in s, g j ^ 2 - g i * ∑ j in s, f j * g j) ^ 2 :=
    sum_nonneg fun i _ ↦ sq_nonneg _
  simp_rw [sub_sq, sum_add_distrib, Finset.sum_sub_distrib, mul_pow, mul_assoc, ←mul_sum, ←
    sum_mul, mul_left_comm, ←mul_assoc, ←sum_mul, mul_right_comm, ←sq, mul_comm, sub_add,
    two_mul, add_sub_cancel, sq (∑ j in s, g j ^ 2), ←mul_assoc, ←mul_sub_right_distrib] at h
  obtain h' | h' := (sum_nonneg fun i _ ↦ sq_nonneg (g i)).eq_or_lt
  · have h'' : ∀ i ∈ s, g i = 0 := fun i hi ↦ by
      simpa using (sum_eq_zero_iff_of_nonneg fun i _ ↦ sq_nonneg (g i)).1 h'.symm i hi
    rw [←h', sum_congr rfl (show ∀ i ∈ s, f i * g i = 0 from fun i hi ↦ by simp [h'' i hi])]
    simp
  · rw [←sub_nonneg]
    exact nonneg_of_mul_nonneg_left h h'

end Finset
