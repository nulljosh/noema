/-
Soundness of the cycle decider: a run from blank that reaches the same configuration at steps i and i + p,
with p > 0, repeats it forever, so it never reaches a configuration with no rule.
`cycles M i p` is the check `decide` runs; `never_halts_of_cycle` turns it into ¬ Halts M.
-/
import FarCerts.Basic

set_option autoImplicit false

namespace FAR

deriving instance DecidableEq for Config

theorem run_add (M : Machine) : ∀ (a b : Nat) (c : Config), run M (a + b) c = (run M a c).bind (run M b)
  | 0, b, c => by simp [run]
  | a + 1, b, c => by
    rw [Nat.add_right_comm]
    simp only [run]
    cases step M c with
    | none => rfl
    | some d => exact run_add M a b d

theorem run_periodic (M : Machine) (i p : Nat) (c : Config) (hi : run M i blank = some c)
    (hp : run M p c = some c) : ∀ n, run M (i + n * p) blank = some c
  | 0 => by simpa using hi
  | n + 1 => by
    rw [Nat.succ_mul, ← Nat.add_assoc, run_add, run_periodic M i p c hi hp n]
    exact hp

def cycles (M : Machine) (i p : Nat) : Bool :=
  0 < p && match run M i blank, run M (i + p) blank with
    | some c, some d => c == d
    | _, _ => false

theorem never_halts_of_cycle (M : Machine) (i p : Nat) (h : cycles M i p = true) : ¬ Halts M := by
  rintro ⟨k, c', hk, hg⟩
  cases h1 : run M i blank with
  | none => simp [cycles, h1] at h
  | some c =>
    cases h2 : run M (i + p) blank with
    | none => simp [cycles, h1, h2] at h
    | some d =>
      simp [cycles, h1, h2] at h
      obtain ⟨hp0, rfl⟩ := h
      have hp : run M p c = some c := by rw [← h2, run_add, h1]; rfl
      have hstop : run M (k + 1) blank = none := by
        rw [run_add, hk]
        show (step M c').bind (run M 0) = none
        simp [step, hg]
      obtain ⟨m, hm⟩ : ∃ m, i + (k + 1) * p = (k + 1) + m := by
        have := Nat.le_mul_of_pos_right (k + 1) hp0
        generalize (k + 1) * p = t at *
        exact ⟨i + t - (k + 1), by omega⟩
      have := run_periodic M i p c h1 hp (k + 1)
      rw [hm, run_add, hstop] at this
      cases this

/-- Every listed machine passes the cycle check, so none of them halts. -/
theorem all_cycle (xs : List (Machine × Nat × Nat)) (h : xs.all (fun x => cycles x.1 x.2.1 x.2.2) = true) :
    ∀ x ∈ xs, ¬ Halts x.1 :=
  fun x hx => never_halts_of_cycle _ _ _ (List.all_eq_true.1 h x hx)

end FAR
