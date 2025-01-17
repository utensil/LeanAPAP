import Mathlib.Logic.Basic

lemma Iff.ne {α β : Sort _} {a₁ a₂ : α} {b₁ b₂ : β} (h : a₁ = a₂ ↔ b₁ = b₂) : a₁ ≠ a₂ ↔ b₁ ≠ b₂ :=
  h.not
