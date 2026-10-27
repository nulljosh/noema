/-
The tree busy.py grows, replayed and checked. `explore` runs a partial machine from blank. If it halts within 20
steps on an undefined (q, a), every way to define that rule is a child, except those the two symmetries cover:
the first move goes right (`Machine.mirror` runs the mirror image) and a node that only ever uses state 0 never
picks state 2 (`Machine.swap` renames states 1 and 2). A machine that defines all but the missing rule has no
children, since defining it leaves nothing to halt on. A machine that does not halt within 20 steps must extend
the head of one of three queues of machines proved never to halt. `explore_sound` turns a successful run into
`Covered S N B`: every S-symbol, N-state machine that extends the node and halts does so within B steps. The step
bound B and the shape are parameters, so the same replay checks BB(3) (S = 2, N = 3, B = 20) and BB(2,3) (S = 3,
N = 2, B = 37). N stays at most 3, since the state-renaming symmetry is only the swap of states 1 and 2.
-/
import FarCerts.Cycle
import FarCerts.Halt

set_option autoImplicit false

namespace FAR

/-- Every rule writes a symbol below S and goes to a state below N. -/
def WF (S N : Nat) (M : Machine) : Prop := ∀ q a r, M.get q a = some r → r.1 < S ∧ r.2.2 < N

/-- M defines every rule m defines, the same way. -/
def Ext (m M : Machine) : Prop := ∀ q a r, m.get q a = some r → M.get q a = some r

def Covered (S N B : Nat) (m : Machine) : Prop := ∀ M, WF S N M → Ext m M → ∀ k, haltsAt M k = true → k ≤ B

theorem step_ext {m M : Machine} (h : Ext m M) (c d : Config) (hs : step m c = some d) : step M c = some d := by
  unfold step at hs ⊢
  cases hg : m.get c.q c.a with
  | none => simp [hg] at hs
  | some r => rw [h _ _ _ hg]; rw [hg] at hs; exact hs

theorem run_ext {m M : Machine} (h : Ext m M) : ∀ j c d, run m j c = some d → run M j c = some d
  | 0, _, _, hr => hr
  | j + 1, c, d, hr => by
    simp only [run] at hr ⊢
    cases hs : step m c with
    | none => simp [hs] at hr
    | some c1 => rw [step_ext h c c1 hs]; rw [hs] at hr; exact run_ext h j c1 d hr

theorem run_ext_or {m M : Machine} (h : Ext m M) : ∀ j c d, run M j c = some d →
    (∃ i e, run m i c = some e ∧ m.get e.q e.a = none) ∨ run m j c = some d
  | 0, _, _, hr => Or.inr hr
  | j + 1, c, d, hr => by
    cases hg : m.get c.q c.a with
    | none => exact Or.inl ⟨0, c, rfl, hg⟩
    | some r =>
      have hs : step m c = step M c := by unfold step; rw [hg, h _ _ _ hg]
      simp only [run] at hr
      cases hM : step M c with
      | none => simp [hM] at hr
      | some c1 =>
        rw [hM] at hr
        rcases run_ext_or h j c1 d hr with ⟨i, e, he, hge⟩ | hr'
        · exact Or.inl ⟨i + 1, e, by simp only [run]; rw [hs, hM]; exact he, hge⟩
        · exact Or.inr (by simp only [run]; rw [hs, hM]; exact hr')

theorem halts_of_ext {m M : Machine} (h : Ext m M) (hM : Halts M) : Halts m := by
  obtain ⟨k, c, hk, hg⟩ := hM
  rcases run_ext_or h k blank c hk with hm | hm
  · exact hm
  · refine ⟨k, c, hm, ?_⟩
    cases hgm : m.get c.q c.a with
    | none => rfl
    | some r => rw [h _ _ _ hgm] at hg; cases hg

theorem haltsAt_spec {M : Machine} {k : Nat} (h : haltsAt M k = true) :
    ∃ c, run M k blank = some c ∧ M.get c.q c.a = none := by
  unfold haltsAt at h
  cases hc : run M k blank with
  | none => simp [hc] at h
  | some c => exact ⟨c, rfl, by simpa [hc] using h⟩

theorem haltsAt_of {M : Machine} {k : Nat} {c : Config} (hr : run M k blank = some c)
    (hg : M.get c.q c.a = none) : haltsAt M k = true := by
  unfold haltsAt; rw [hr]; simp [hg]

theorem step_none {M : Machine} {c : Config} (h : step M c = none) : M.get c.q c.a = none := by
  unfold step at h
  cases hg : M.get c.q c.a with
  | none => rfl
  | some r => obtain ⟨w, d, n⟩ := r; cases d <;> simp [hg] at h

theorem halt_unique {M : Machine} {k k' : Nat} (h : haltsAt M k = true) (h' : haltsAt M k' = true) : k = k' := by
  obtain ⟨c, hc, hg⟩ := haltsAt_spec h
  obtain ⟨c', hc', hg'⟩ := haltsAt_spec h'
  have stuck : ∀ (d : Config), M.get d.q d.a = none → ∀ j, run M (j + 1) d = none := by
    intro d hd j; simp only [run]; unfold step; rw [hd]; rfl
  rcases Nat.lt_trichotomy k k' with hlt | heq | hgt
  · obtain ⟨j, rfl⟩ : ∃ j, k' = k + (j + 1) := ⟨k' - k - 1, by omega⟩
    rw [run_add, hc] at hc'
    simp [stuck c hg j] at hc'
  · exact heq
  · obtain ⟨j, rfl⟩ : ∃ j, k = k' + (j + 1) := ⟨k - k' - 1, by omega⟩
    rw [run_add, hc'] at hc
    simp [stuck c' hg' j] at hc

/-- A configuration of an S-symbol, N-state run. -/
def V3 (S N : Nat) (c : Config) : Prop := c.q < N ∧ c.a < S ∧ (∀ x ∈ c.L, x < S) ∧ (∀ x ∈ c.R, x < S)

theorem step_V3 {S N : Nat} {M : Machine} (hw : WF S N M) (c d : Config) (hv : V3 S N c) (hs : step M c = some d) :
    V3 S N d := by
  obtain ⟨-, -, hL, hR⟩ := hv
  unfold step at hs
  cases hg : M.get c.q c.a with
  | none => simp [hg] at hs
  | some r =>
    obtain ⟨w, dir, n⟩ := r
    obtain ⟨hw1, hn⟩ := hw _ _ _ hg
    simp only at hw1 hn
    cases dir <;> simp [hg] at hs <;> subst hs
    · refine ⟨hn, ?_, ?_, ?_⟩
      · cases hc : c.L with
        | nil => exact Nat.lt_of_le_of_lt (Nat.zero_le _) hw1
        | cons b t => exact hL b (by simp [hc])
      · intro x hx; cases hc : c.L with
        | nil => simp [hc] at hx
        | cons b t => exact hL x (by simp [hc] at hx; simp [hc, hx])
      · intro x hx; simp at hx; rcases hx with rfl | hx
        · exact hw1
        · exact hR x hx
    · refine ⟨hn, ?_, ?_, ?_⟩
      · cases hc : c.R with
        | nil => exact Nat.lt_of_le_of_lt (Nat.zero_le _) hw1
        | cons b t => exact hR b (by simp [hc])
      · intro x hx; simp at hx; rcases hx with rfl | hx
        · exact hw1
        · exact hL x hx
      · intro x hx; cases hc : c.R with
        | nil => simp [hc] at hx
        | cons b t => exact hR x (by simp [hc] at hx; simp [hc, hx])

theorem run_V3 {S N : Nat} {M : Machine} (hw : WF S N M) : ∀ j c d, V3 S N c → run M j c = some d → V3 S N d
  | 0, c, d, hv, hr => by simp [run] at hr; subst hr; exact hv
  | j + 1, c, d, hv, hr => by
    simp only [run] at hr
    cases hs : step M c with
    | none => simp [hs] at hr
    | some c1 => rw [hs] at hr; exact run_V3 hw j c1 d (step_V3 hw c c1 hv hs) hr

/-- A machine with all S * N rules never halts. -/
theorem full_no_halt {S N : Nat} {M : Machine} (hS : 0 < S) (hN : 0 < N) (hw : WF S N M)
    (hf : ∀ q a, q < N → a < S → M.get q a ≠ none) (k : Nat) : haltsAt M k ≠ true := by
  intro h
  obtain ⟨c, hc, hg⟩ := haltsAt_spec h
  obtain ⟨hq, ha, -, -⟩ := run_V3 hw k blank c ⟨hN, hS, by simp [blank], by simp [blank]⟩ hc
  exact hf c.q c.a hq ha hg

end FAR
