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

theorem first_descent_32k_plus_11 (k : Nat) :
    FirstDescent (32 * k + 11) 8 := by
  have h1 : step (32 * k + 11) = 96 * k + 34 := by
    unfold step
    split <;> omega
  have h2 : step (96 * k + 34) = 48 * k + 17 := by
    unfold step
    split <;> omega
  have h3 : step (48 * k + 17) = 144 * k + 52 := by
    unfold step
    split <;> omega
  have h4 : step (144 * k + 52) = 72 * k + 26 := by
    unfold step
    split <;> omega
  have h5 : step (72 * k + 26) = 36 * k + 13 := by
    unfold step
    split <;> omega
  have h6 : step (36 * k + 13) = 108 * k + 40 := by
    unfold step
    split <;> omega
  have h7 : step (108 * k + 40) = 54 * k + 20 := by
    unfold step
    split <;> omega
  have h8 : step (54 * k + 20) = 27 * k + 10 := by
    unfold step
    split <;> omega
  unfold FirstDescent
  constructor
  · simp only [orbit, h1, h2, h3, h4, h5, h6, h7, h8]
    omega
  · intro s before
    have cases : s = 0 ∨ s = 1 ∨ s = 2 ∨ s = 3 ∨ s = 4 ∨ s = 5 ∨ s = 6 ∨ s = 7 := by omega
    rcases cases with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
      simp only [orbit, h1, h2, h3, h4, h5, h6, h7] <;> omega

theorem first_descent_32k_plus_23 (k : Nat) :
    FirstDescent (32 * k + 23) 8 := by
  have h1 : step (32 * k + 23) = 96 * k + 70 := by
    unfold step
    split <;> omega
  have h2 : step (96 * k + 70) = 48 * k + 35 := by
    unfold step
    split <;> omega
  have h3 : step (48 * k + 35) = 144 * k + 106 := by
    unfold step
    split <;> omega
  have h4 : step (144 * k + 106) = 72 * k + 53 := by
    unfold step
    split <;> omega
  have h5 : step (72 * k + 53) = 216 * k + 160 := by
    unfold step
    split <;> omega
  have h6 : step (216 * k + 160) = 108 * k + 80 := by
    unfold step
    split <;> omega
  have h7 : step (108 * k + 80) = 54 * k + 40 := by
    unfold step
    split <;> omega
  have h8 : step (54 * k + 40) = 27 * k + 20 := by
    unfold step
    split <;> omega
  unfold FirstDescent
  constructor
  · simp only [orbit, h1, h2, h3, h4, h5, h6, h7, h8]
    omega
  · intro s before
    have cases : s = 0 ∨ s = 1 ∨ s = 2 ∨ s = 3 ∨ s = 4 ∨ s = 5 ∨ s = 6 ∨ s = 7 := by omega
    rcases cases with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;>
      simp only [orbit, h1, h2, h3, h4, h5, h6, h7] <;> omega

#print axioms first_descent_four_k_plus_one
#print axioms first_descent_32k_plus_11
#print axioms first_descent_32k_plus_23

end Noema
