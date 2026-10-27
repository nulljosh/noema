/-
Soundness of the translated-cycler decider. At step i the head sits on the right edge (R = []) in state q
reading a, and A is the nearest d cells to its left. If p > 0 steps from ⟨q, A, a, []⟩ never read past A
and end in state q reading a on the right edge again, with A still the nearest d cells, the same p steps
repeat forever whatever lies beyond A. Left-moving cyclers are checked on the mirror machine.
-/
import FarCerts.Cycle

set_option autoImplicit false

namespace FAR

/-- A step that fails when the head would move left off the end of L, as well as on a halt. -/
def stepSafe (M : Machine) (c : Config) : Option Config :=
  match M.get c.q c.a with
  | none => none
  | some (w, true, n) => some ⟨n, w :: c.L, c.R.headD 0, c.R.tail⟩
  | some (w, false, n) =>
    match c.L with
    | [] => none
    | x :: L => some ⟨n, L, x, w :: c.R⟩

def runSafe (M : Machine) : Nat → Config → Option Config
  | 0, c => some c
  | k + 1, c => (stepSafe M c).bind (runSafe M k)

/-- c with X past the far end of its left list. -/
def app (c : Config) (X : List Nat) : Config := ⟨c.q, c.L ++ X, c.a, c.R⟩

theorem step_safe (M : Machine) (c e : Config) (X : List Nat) (h : stepSafe M c = some e) :
    step M (app c X) = some (app e X) := by
  rcases c with ⟨q, L, a, R⟩
  unfold stepSafe at h
  unfold step app
  simp only at h ⊢
  cases hg : M.get q a with
  | none => simp [hg] at h
  | some r =>
    obtain ⟨w, b, n⟩ := r
    cases b with
    | true => simp [hg] at h; subst h; simp
    | false =>
      cases L with
      | nil => simp [hg] at h
      | cons x L => simp [hg] at h; subst h; simp

theorem run_safe (M : Machine) (X : List Nat) :
    ∀ (k : Nat) (c e : Config), runSafe M k c = some e → run M k (app c X) = some (app e X)
  | 0, c, e, h => by simp [runSafe] at h; subst h; rfl
  | k + 1, c, e, h => by
    simp only [runSafe] at h
    cases hs : stepSafe M c with
    | none => simp [hs] at h
    | some c1 =>
      simp [hs] at h
      simp only [run, step_safe M c c1 X hs]
      exact run_safe M X k c1 e h

theorem never_halts_of_runs (M : Machine) (i p : Nat) (hp0 : 0 < p)
    (h : ∀ n, ∃ c, run M (i + n * p) blank = some c) : ¬ Halts M := by
  rintro ⟨k, c', hk, hg⟩
  have hstop : run M (k + 1) blank = none := by
    rw [run_add, hk]
    show (step M c').bind (run M 0) = none
    simp [step, hg]
  obtain ⟨m, hm⟩ : ∃ m, i + (k + 1) * p = (k + 1) + m := by
    have := Nat.le_mul_of_pos_right (k + 1) hp0
    generalize (k + 1) * p = t at *
    exact ⟨i + t - (k + 1), by omega⟩
  obtain ⟨c, hc⟩ := h (k + 1)
  rw [hm, run_add, hstop] at hc
  cases hc

def tcycles (M : Machine) (i p d : Nat) : Bool :=
  0 < p && match run M i blank with
    | none => false
    | some c => c.R == [] && decide (d ≤ c.L.length) &&
      match runSafe M p ⟨c.q, c.L.take d, c.a, []⟩ with
      | none => false
      | some e => e.q == c.q && e.a == c.a && e.R == [] && e.L.take d == c.L.take d && decide (d ≤ e.L.length)

theorem never_halts_of_tcycle (M : Machine) (i p d : Nat) (h : tcycles M i p d = true) : ¬ Halts M := by
  cases hc : run M i blank with
  | none => simp [tcycles, hc] at h
  | some c =>
    cases he : runSafe M p ⟨c.q, c.L.take d, c.a, []⟩ with
    | none => simp [tcycles, hc, he] at h
    | some e =>
      simp only [tcycles, hc, he, Bool.and_eq_true, beq_iff_eq, decide_eq_true_eq] at h
      obtain ⟨hp0, ⟨hR, hd⟩, ⟨⟨⟨hq, ha⟩, heR⟩, hA⟩, hed⟩ := h
      have hR' : c.R = [] := by simpa using hR
      apply never_halts_of_runs M i p hp0
      -- invariant: the run at i + n p is ⟨q, A ++ Z, a, []⟩ for some Z
      suffices key : ∀ n, ∃ Z, run M (i + n * p) blank = some ⟨c.q, c.L.take d ++ Z, c.a, []⟩ by
        intro n; obtain ⟨Z, hZ⟩ := key n; exact ⟨_, hZ⟩
      intro n
      induction n with
      | zero =>
        refine ⟨c.L.drop d, ?_⟩
        rw [List.take_append_drop, Nat.zero_mul, Nat.add_zero, hc]
        rcases c with ⟨q, L, a, R⟩
        simp only at hR'
        subst hR'
        rfl
      | succ n ih =>
        obtain ⟨Z, hZ⟩ := ih
        refine ⟨e.L.drop d ++ Z, ?_⟩
        rw [Nat.succ_mul, ← Nat.add_assoc, run_add, hZ]
        have := run_safe M Z p _ e he
        simp only [app] at this
        show run M p ⟨c.q, c.L.take d ++ Z, c.a, []⟩ = _
        rw [this]
        have hL : e.L = c.L.take d ++ e.L.drop d := by
          rw [← hA]; exact (List.take_append_drop d e.L).symm
        rcases e with ⟨eq, eL, ea, eR⟩
        simp only at hq ha heR hL ⊢
        subst hq ha heR
        rw [← List.append_assoc, ← hL]

theorem never_halts_of_tcycle_mirror (M : Machine) (i p d : Nat) (h : tcycles M.mirror i p d = true) :
    ¬ Halts M := by
  rintro ⟨k, c, hk, hg⟩
  apply never_halts_of_tcycle M.mirror i p d h
  refine ⟨k, flip c, ?_, ?_⟩
  · have := run_mirror M k blank
    rw [hk] at this
    exact this
  · simp [flip, get_mirror, hg]

/-- Every listed machine (a flag for the mirror, then i, p, d) passes the check, so none of them halts. -/
def tcheck (x : Machine × Bool × Nat × Nat × Nat) : Bool :=
  tcycles (if x.2.1 then x.1.mirror else x.1) x.2.2.1 x.2.2.2.1 x.2.2.2.2

theorem all_tcycle (xs : List (Machine × Bool × Nat × Nat × Nat)) (h : xs.all tcheck = true) :
    ∀ x ∈ xs, ¬ Halts x.1 := by
  intro x hx
  have hx' := List.all_eq_true.1 h x hx
  unfold tcheck at hx'
  cases hm : x.2.1 with
  | true => rw [hm] at hx'; exact never_halts_of_tcycle_mirror _ _ _ _ hx'
  | false => rw [hm] at hx'; exact never_halts_of_tcycle _ _ _ _ hx'

end FAR
