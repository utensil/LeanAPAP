import Mathlib.Data.Nat.Factorial.BigOperators

open Finset

open scoped Nat BigOperators

namespace Nat
variable {α : Type*} (s : Finset α) (f : α → ℕ)

--TODO: Golf mathlib proof
-- private lemma prod_factorial_dvd_factorial_sum : ∏ i in s, (f i)! ∣ (∑ i in s, f i)! := by
--   induction' s using Finset.cons_induction_on with a s has ih
--   · simp
--   rw [prod_cons, sum_cons]
--   exact (mul_dvd_mul_left _ ih).trans (Nat.factorial_mul_factorial_dvd_factorial_add _ _)

end Nat
