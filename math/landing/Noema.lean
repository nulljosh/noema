import Lean

set_option autoImplicit false
set_option warningAsError true

namespace Noema

-- Ordinary Collatz: an odd update and the next halving are separate steps.
def step (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

def orbit : Nat → Nat → Nat
  | 0, n => n
  | t + 1, n => step (orbit t n)

def FirstDescent (n t : Nat) : Prop :=
  orbit t n < n ∧ ∀ s : Nat, s < t → n ≤ orbit s n

theorem first_descent_four_k_plus_one (k : Nat) (positive : 1 ≤ k) :
    FirstDescent (4 * k + 1) 3 := by
  have h1 : step (4 * k + 1) = 12 * k + 4 := by
    unfold step
    split <;> omega
  have h2 : step (12 * k + 4) = 6 * k + 2 := by
    unfold step
    split <;> omega
  have h3 : step (6 * k + 2) = 3 * k + 1 := by
    unfold step
    split <;> omega
  unfold FirstDescent
  constructor
  · simp only [orbit, h1, h2, h3]
    omega
  · intro s before
    have cases : s = 0 ∨ s = 1 ∨ s = 2 := by omega
    rcases cases with rfl | rfl | rfl <;> simp only [orbit, h1, h2] <;> omega

#print axioms first_descent_four_k_plus_one

end Noema
