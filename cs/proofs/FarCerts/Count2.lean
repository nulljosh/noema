import FarCerts.BB2Tree

set_option maxRecDepth 100000

namespace FAR

/-- One table entry in the A004147 convention, 12 choices: 0 to 3 halt (a halting row keeps a write and a move,
which never act), 4 to 11 write, move and go on. Choices are read mod 12, so every list is a table. -/
def entry (q a c : Nat) : List (Nat × Nat × Nat × Bool × Nat) :=
  if c % 12 < 4 then [] else [(q, a, (c % 12 - 4) % 2, (c % 12 - 4) / 2 % 2 == 1, (c % 12 - 4) / 4)]

def table2 (t : List Nat) : Machine :=
  { S := 2, n := 2, rules := entry 0 0 (t.getD 0 0) ++ entry 0 1 (t.getD 1 0) ++ entry 1 0 (t.getD 2 0) ++ entry 1 1 (t.getD 3 0) }

/-- All 12^4 = 20,736 tables, each once. -/
def tables2 : List (List Nat) :=
  (List.range 12).flatMap fun a => (List.range 12).flatMap fun b =>
    (List.range 12).flatMap fun c => (List.range 12).map fun d => [a, b, c, d]

/-- The step a machine halts on, looking only up to the BB(2) bound. -/
def haltStep (M : Machine) : Option Nat := ((List.range 6).find? (haltsAt M ·)).map (· + 1)

theorem entry_wf (q a c : Nat) : ∀ x ∈ entry q a c, x.2.2.1 < 2 ∧ x.2.2.2.2 < 2 := by
  intro x hx
  unfold entry at hx
  split at hx
  · simp at hx
  · simp only [List.mem_singleton] at hx
    subst hx
    constructor <;> simp <;> omega

theorem table2_wf (t : List Nat) : WF 2 2 (table2 t) := by
  apply wf_of_rules
  rw [List.all_eq_true]
  intro x hx
  simp only [table2, List.mem_append] at hx
  have h : x.2.2.1 < 2 ∧ x.2.2.2.2 < 2 := by
    rcases hx with ((h | h) | h) | h <;> exact entry_wf _ _ _ x h
  simp [h.1, h.2]

/-- By BB(2), a table halts from blank exactly when haltStep finds a step, so the bounded search loses nothing. -/
theorem halts_iff (t : List Nat) : (∃ k, haltsAt (table2 t) k = true) ↔ (haltStep (table2 t)).isSome := by
  simp only [haltStep, Option.isSome_map, List.find?_isSome, List.mem_range]
  constructor
  · rintro ⟨k, hk⟩
    exact ⟨k, by have := bb2_steps_le _ (table2_wf t) k hk; omega, hk⟩
  · rintro ⟨k, _, hk⟩
    exact ⟨k, hk⟩

/-- A004147(2) = 9784: that many 2-state, 2-symbol tables halt from a blank tape. -/
theorem a004147_2 : (tables2.filter fun t => (haltStep (table2 t)).isSome).length = 9784 := by decide +kernel

/-- A386859(2) = 13504: their halting steps add up to that. -/
theorem a386859_2 : (tables2.filterMap fun t => haltStep (table2 t)).sum = 13504 := by decide +kernel

-- the list really has 12^4 entries; a wrong count or sum fails the two decides above
example : tables2.length = 20736 := by decide +kernel

end FAR
