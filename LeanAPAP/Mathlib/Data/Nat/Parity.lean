import Mathbin.Data.Nat.Prime
import Mathbin.Data.Nat.Parity

#align_import mathlib.data.nat.parity

namespace Nat

variable {n : ℕ}

@[simp]
theorem coprime_two_left : coprime 2 n ↔ Odd n := by
  rw [prime_two.coprime_iff_not_dvd, odd_iff_not_even, even_iff_two_dvd]

@[simp]
theorem coprime_two_right : n.coprime 2 ↔ Odd n :=
  coprime_comm.trans coprime_two_left

alias ⟨coprime.odd_of_left, _root_.odd.coprime_two_left⟩ := coprime_two_left

alias ⟨coprime.odd_of_right, _root_.odd.coprime_two_right⟩ := coprime_two_right

end Nat
