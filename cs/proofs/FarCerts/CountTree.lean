/-
The tree that counts halting tables, and its soundness: a successful run equals `Sm`, the sum over every
completion (CountSum.lean). Stored subtree values let a big tree be checked in small pieces.
-/
import FarCerts.CountSum

set_option autoImplicit false

namespace FAR
namespace Count

abbrev Stored := List (List (Option Nat) × Nat)

/-- Run g on each x in turn, passing the stored list along, and add the values. -/
def chain (g : Nat → Stored → Option (Nat × Stored)) : List Nat → Stored → Option (Nat × Stored)
  | [], S => some (0, S)
  | x :: xs, S => (g x S).bind fun r => (chain g xs r.2).map fun r2 => (r.1 + r2.1, r2.2)

theorem chain_spec (g : Nat → Stored → Option (Nat × Stored)) (h : Nat → Nat) (P : Stored → Prop) :
    ∀ (xs : List Nat), (∀ x ∈ xs, ∀ S v S', P S → g x S = some (v, S') → h x = v ∧ P S') →
    ∀ S v S', P S → chain g xs S = some (v, S') → (xs.map h).sum = v ∧ P S'
  | [], _, S, v, S', hS, hc => by
    simp only [chain, Option.some.injEq, Prod.mk.injEq] at hc
    obtain ⟨rfl, rfl⟩ := hc; exact ⟨rfl, hS⟩
  | x :: xs, hg, S, v, S', hS, hc => by
    simp only [chain] at hc
    cases h1 : g x S with
    | none => rw [h1] at hc; cases hc
    | some r =>
      obtain ⟨v1, S1⟩ := r
      rw [h1] at hc
      cases h2 : chain g xs S1 with
      | none => simp only [Option.bind_some, h2, Option.map_none] at hc; cases hc
      | some r2 =>
        obtain ⟨u, S2⟩ := r2
        simp only [Option.bind_some, h2, Option.map_some, Option.some.injEq, Prod.mk.injEq] at hc
        obtain ⟨rfl, rfl⟩ := hc
        obtain ⟨e1, p1⟩ := hg x (List.mem_cons_self) S v1 S1 hS h1
        obtain ⟨e2, p2⟩ := chain_spec g h P xs (fun y hy => hg y (List.mem_cons_of_mem _ hy)) S1 u S2 p1 h2
        exact ⟨by simp only [List.map_cons, List.sum_cons]; rw [e1, e2], p2⟩

/-- The tree from partial table p, which has run k steps from blank to c. S lists stored subtree values in the
order the tree meets them; a node at the head of S takes its stored value instead of being expanded. Each stored
value is checked on its own (`chk`), which keeps every kernel check small. -/
def tree (b B : Nat) (w : Nat → Nat) : Nat → List (Option Nat) → Nat → Config → Stored → Option (Nat × Stored)
  | 0, _, _, _, _ => none
  | f + 1, p, k, c, S =>
    if S.head?.map (·.1) = some p then some ((S.headD ([], 0)).2, S.tail) else
    match firstStuck (mach p) (B + 1 - k) k c with
    | none => some (0, S)
    | some (k', d) =>
      if d.a < 2 ∧ (p.getD (2 * d.q + d.a) (some 0)).isNone then
        chain (fun x S => if x < 4 then some (w (k' + 1) * b ^ (nones p - 1), S)
          else tree b B w f (p.set (2 * d.q + d.a) (some x)) k' d S) (List.range b) S
      else none

theorem tree_sound (b B : Nat) (w : Nat → Nat) : ∀ (f : Nat) (p : List (Option Nat)) (k : Nat) (c : Config)
    (S : Stored) (v : Nat) (S' : Stored), run (mach p) k blank = some c → (∀ e ∈ S, Sm b (F B w) e.1 = e.2) →
    tree b B w f p k c S = some (v, S') → Sm b (F B w) p = v ∧ ∀ e ∈ S', Sm b (F B w) e.1 = e.2
  | 0, _, _, _, _, _, _, _, _, h => by simp [tree] at h
  | f + 1, p, k, c, S, v, S', hr, hS, h => by
    simp only [tree] at h
    split at h
    · rename_i hp
      cases S with
      | nil => simp at hp
      | cons e S0 =>
        simp only [List.head?_cons, Option.map_some, Option.some.injEq] at hp
        simp only [List.headD_cons, List.tail_cons, Option.some.injEq, Prod.mk.injEq] at h
        obtain ⟨rfl, rfl⟩ := h
        refine ⟨?_, fun x hx => hS x (List.mem_cons_of_mem _ hx)⟩
        rw [← hp]; exact hS e List.mem_cons_self
    -- every configuration before step k has a rule, so no completion halts there
    have early : ∀ t, Compl b p t → ∀ j < k, haltsAt (mach t) j = false := fun t ht j hj => by
      obtain ⟨e, he, hg⟩ := run_live _ k blank c hr j hj
      exact not_halt_ext (ext_compl ht) he hg
    split at h
    · rename_i hn
      simp only [Option.some.injEq, Prod.mk.injEq] at h; obtain ⟨rfl, rfl⟩ := h
      refine ⟨?_, hS⟩
      rw [Sm_congr p _ (fun _ => 0), Sm_const, Nat.zero_mul]
      intro t ht
      apply F_zero
      intro j hj
      by_cases hjk : j < k
      · exact early t ht j hjk
      · obtain ⟨e, he, hg⟩ := firstStuck_none _ _ _ _ hn (j - k) (by omega)
        have : run (mach p) j blank = some e := by
          rw [show j = k + (j - k) by omega, run_add, hr]; exact he
        exact not_halt_ext (ext_compl ht) this hg
    · rename_i k' d hs
      obtain ⟨j, rfl, hj, hrj, hgd⟩ := firstStuck_spec _ _ _ _ _ _ hs
      split at h
      · rename_i hc
        obtain ⟨ha, hn⟩ := hc
        have he : p.getD (2 * d.q + d.a) (some 0) = none := Option.isNone_iff_eq_none.1 hn
        have hrk : run (mach p) (k + j) blank = some d := by rw [run_add, hr]; exact hrj
        rw [Sm_split b p _ _ he]
        refine chain_spec _ _ (fun S => ∀ e ∈ S, Sm b (F B w) e.1 = e.2) _ (fun x hx S0 u S1 hS0 hu => ?_) S v S' hS h
        split at hu
        · rename_i hx4
          simp only [Option.some.injEq, Prod.mk.injEq] at hu; obtain ⟨rfl, rfl⟩ := hu
          refine ⟨?_, hS0⟩
          rw [Sm_congr _ _ (fun _ => w (k + j + 1)), Sm_const]
          · rw [← nones_set p _ x he, Nat.add_sub_cancel]
          intro t ht
          apply F_halt _ (by omega)
          apply haltsAt_of (run_ext (ext_compl ht) _ _ _ (run_ext (ext_set he) _ _ _ hrk))
          rw [get_mach]; unfold look
          rw [if_pos ha, compl_set p t _ x ht he]
          simp [ruleAt, hx4]
        · exact tree_sound b B w f _ _ _ S0 u S1 (run_ext (ext_set he) _ _ _ hrk) hS0 hu
      · cases h

/-- The tree from the empty table counts every table of length l. -/
theorem count_of_tree (b B l f : Nat) (w : Nat → Nat) (S : Stored) (hS : ∀ e ∈ S, Sm b (F B w) e.1 = e.2)
    (v : Nat) (S' : Stored) (h : tree b B w f (List.replicate l none) 0 blank S = some (v, S')) :
    Sm b (F B w) (List.replicate l none) = v :=
  (tree_sound b B w f _ 0 blank S v S' rfl hS h).1

/-- Entries (p, k, c, v1, v2): p has run k steps from blank to c, and its tree gives v1 under w1 and v2 under w2.
Each list is one kernel check, so a large tree can be checked in pieces of bounded size. -/
def chk (b B f : Nat) (w1 w2 : Nat → Nat) (G : List (List (Option Nat) × Nat × Config × Nat × Nat)) : Bool :=
  G.all fun g => decide (run (mach g.1) g.2.1 blank = some g.2.2.1) &&
    decide (tree b B w1 f g.1 g.2.1 g.2.2.1 [] = some (g.2.2.2.1, [])) &&
    decide (tree b B w2 f g.1 g.2.1 g.2.2.1 [] = some (g.2.2.2.2, []))

theorem chk_flatten (b B f : Nat) (w1 w2 : Nat → Nat) (L : List (List (List (Option Nat) × Nat × Config × Nat × Nat)))
    (h : ∀ G ∈ L, chk b B f w1 w2 G = true) : chk b B f w1 w2 L.flatten = true := by
  unfold chk; rw [List.all_eq_true]
  intro g hg
  obtain ⟨G, hG, hgG⟩ := List.mem_flatten.1 hg
  exact List.all_eq_true.1 (h G hG) g hgG

theorem chk_ok (b B f : Nat) (w1 w2 : Nat → Nat) (G : List (List (Option Nat) × Nat × Config × Nat × Nat))
    (h : chk b B f w1 w2 G = true) :
    (∀ e ∈ G.map (fun g => (g.1, g.2.2.2.1)), Sm b (F B w1) e.1 = e.2) ∧
    (∀ e ∈ G.map (fun g => (g.1, g.2.2.2.2)), Sm b (F B w2) e.1 = e.2) := by
  constructor <;> intro e he <;> obtain ⟨g, hg, rfl⟩ := List.mem_map.1 he <;>
    have hc := List.all_eq_true.1 h g hg <;> simp only [Bool.and_eq_true, decide_eq_true_eq] at hc
  · exact (tree_sound b B w1 f _ _ _ [] _ [] hc.1.1 (fun _ h => nomatch h) hc.1.2).1
  · exact (tree_sound b B w2 f _ _ _ [] _ [] hc.1.1 (fun _ h => nomatch h) hc.2).1

end Count
end FAR
