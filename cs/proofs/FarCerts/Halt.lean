/-
Halting, checked by running. `haltsAt M k` runs M for k steps from blank and checks that no rule applies there.
`run` fails at the first configuration with no rule, so k is the first halt: the machine takes k steps and then
halts on its (k + 1)-th, the count busy beaver uses.
-/
import FarCerts.Basic

set_option autoImplicit false

namespace FAR

def haltsAt (M : Machine) (k : Nat) : Bool :=
  match run M k blank with
  | some c => (M.get c.q c.a).isNone
  | none => false

theorem halts_of_haltsAt (M : Machine) (k : Nat) (h : haltsAt M k = true) : Halts M := by
  unfold haltsAt at h
  cases hc : run M k blank with
  | none => simp [hc] at h
  | some c => exact ⟨k, c, hc, by simpa [hc] using h⟩

/-- Every listed machine halts after the listed number of steps. -/
theorem all_halt (xs : List (Machine × Nat)) (h : xs.all (fun x => haltsAt x.1 x.2) = true) :
    ∀ x ∈ xs, Halts x.1 :=
  fun x hx => halts_of_haltsAt _ _ (List.all_eq_true.1 h x hx)

end FAR
