/-
A004147(3), A386859(3) and the 3-state runtime spectrum, machine-checked without listing the 16^6 tables.
`tree_sound` (CountTree.lean) turns a replay of the tree into a sum over every table, and BB(3) (BB3Tree.lean)
says a table that halts does so within 21 steps, so `F 20` loses nothing. The kernel cannot replay all 1.1 million
steps at once, so `count_lean.py` cuts the tree into 182 pieces (Count3G*.lean), each checked alone; the top of
the tree then reads their values in the order it meets them.
-/
import FarCerts.Count3Pieces
import FarCerts.BB3Tree

set_option maxRecDepth 100000

namespace FAR
namespace Count

/-- Every entry of a full table is a choice below b. -/
theorem compl_lt {b : Nat} : ∀ (m : Nat) (t : List (Option Nat)), Compl b (List.replicate m none) t →
    ∀ i c, t.getD i none = some c → c < b
  | 0, [], _, i, c, h => by simp at h
  | m + 1, some d :: t, h, 0, c, hc => by simp at hc; subst hc; exact h.1
  | m + 1, some _ :: t, h, i + 1, c, hc => compl_lt m t h.2 i c (by simpa using hc)
  | 0, _ :: _, h, _, _, _ | m + 1, [], h, _, _, _ | m + 1, none :: _, h, _, _, _ => by
    simp [List.replicate, Compl] at h

theorem compl_of_all (b : Nat) : ∀ (l : List Nat), l.all (· < b) = true → Compl b (List.replicate l.length none) (l.map some)
  | [], _ => trivial
  | x :: l, h => by
    simp only [List.all_cons, Bool.and_eq_true, decide_eq_true_eq] at h
    exact ⟨h.1, compl_of_all b l h.2⟩

theorem wf3 {t : List (Option Nat)} (ht : Compl 16 (List.replicate 6 none) t) : WF 2 3 (mach t) := by
  intro q a r hr
  rw [get_mach] at hr; unfold look at hr
  split at hr
  · cases hc : t.getD (2 * q + a) none with
    | none => rw [hc] at hr; cases hr
    | some c =>
      have := compl_lt 6 t ht _ c hc
      rw [hc] at hr; simp only [Option.bind, ruleAt] at hr
      split at hr
      · cases hr
      · cases hr; constructor <;> simp <;> omega
  · cases hr

/-- By BB(3), a table halts exactly when F 20 (fun _ => 1) counts it. F 20 id gives its halting step. -/
theorem halts_iff3 {t : List (Option Nat)} (ht : Compl 16 (List.replicate 6 none) t) :
    (∃ k, haltsAt (mach t) k = true) ↔ F 20 (fun _ => 1) t = 1 := by
  constructor
  · rintro ⟨k, hk⟩
    exact F_halt hk (bb3_steps_le _ (wf3 ht) k hk)
  · intro h
    cases ha : (List.range 21).any (haltsAt (mach t)) with
    | true =>
      obtain ⟨j, _, hj⟩ := List.any_eq_true.1 ha
      exact ⟨j, hj⟩
    | false =>
      rw [F_zero (fun j hj => by
        have := List.any_eq_false.1 ha j (List.mem_range.2 (by omega))
        simpa using this)] at h
      cases h

/-- A004147(3) = 7571840: that many 3-state, 2-symbol tables halt from a blank tape. -/
theorem a004147_3 : Sm 16 (F 20 (fun _ => 1)) (List.replicate 6 none) = 7571840 :=
  count_of_tree 16 20 6 7 _ _ (chk_ok _ _ _ _ _ _ pieces3_ok).1 _ [] (by decide +kernel)

/-- A386859(3) = 13141792: their halting steps add up to that. -/
theorem a386859_3 : Sm 16 (F 20 id) (List.replicate 6 none) = 13141792 :=
  count_of_tree 16 20 6 7 _ _ (chk_ok _ _ _ _ _ _ pieces3_ok).2 _ [] (by decide +kernel)

/-- One table for each halting time; table k takes k steps and halts. -/
def wit : List (List Nat) :=
  [[3, 10, 0, 0, 0, 0], [13, 5, 11, 11, 2, 14], [12, 13, 0, 14, 8, 7], [13, 15, 11, 13, 11, 0],
   [9, 15, 12, 3, 15, 3], [11, 2, 13, 4, 3, 5], [9, 3, 12, 13, 7, 7], [12, 9, 13, 1, 7, 10],
   [10, 9, 5, 14, 9, 1], [15, 3, 8, 5, 10, 11], [12, 11, 7, 0, 8, 9], [12, 14, 7, 2, 8, 9],
   [11, 3, 13, 14, 4, 5], [10, 1, 13, 11, 14, 5], [13, 7, 12, 2, 6, 9], [10, 13, 5, 11, 9, 1],
   [13, 2, 11, 6, 8, 11], [11, 8, 14, 15, 5, 1], [9, 5, 12, 1, 15, 6], [11, 2, 12, 14, 13, 5],
   [11, 0, 9, 14, 13, 5]]

theorem wit_ok : (List.range 21).all (fun k => let l := wit.getD k [];
    l.length == 6 && l.all (· < 16) && haltsAt (mach (l.map some)) k) = true := by decide +kernel

/-- The 3-state runtime spectrum: a table takes exactly k steps and halts iff k ≤ 20, so 21 halting times. -/
theorem spectrum3 (k : Nat) :
    (∃ t, Compl 16 (List.replicate 6 none) t ∧ haltsAt (mach t) k = true) ↔ k ≤ 20 := by
  constructor
  · rintro ⟨t, ht, hk⟩
    exact bb3_steps_le _ (wf3 ht) k hk
  · intro hk
    have h := List.all_eq_true.1 wit_ok k (List.mem_range.2 (by omega))
    simp only [Bool.and_eq_true, beq_iff_eq] at h
    obtain ⟨⟨hl, ha⟩, hh⟩ := h
    refine ⟨_, ?_, hh⟩
    have := compl_of_all 16 _ ha
    rwa [hl] at this

-- the same tree code gives the two 2-state counts Count2.lean gets by listing all 12^4 tables
example : Sm 12 (F 5 (fun _ => 1)) (List.replicate 4 none) = 9784 :=
  count_of_tree 12 5 4 5 _ [] (fun _ h => nomatch h) _ [] (by decide +kernel)
example : Sm 12 (F 5 id) (List.replicate 4 none) = 13504 :=
  count_of_tree 12 5 4 5 _ [] (fun _ h => nomatch h) _ [] (by decide +kernel)
-- sabotage: one step short of BB(2) the 2-state count drops, and a wrong stored value is caught
example : tree 12 4 (fun _ => 1) 5 (List.replicate 4 none) 0 blank [] ≠ some (9784, []) := by decide +kernel
example : chk 16 20 7 (fun _ => 1) id (g0.map fun g => (g.1, g.2.1, g.2.2.1, g.2.2.2.1 + 1, g.2.2.2.2)) = false := by
  decide +kernel

end Count
end FAR
