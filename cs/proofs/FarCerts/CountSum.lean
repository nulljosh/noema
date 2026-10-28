/-
Counting halting tables: the encoding, sums over completions and the halting weight. CountTree.lean builds the
tree on these.

A table is a list of 2n entries, entry 2q + a for state q reading a, each a choice below b = 4n + 4 as in
A004147: 0 to 3 halt, and 4 + x writes x % 2, moves right when x / 2 % 2 = 1 and goes to state x / 4. A partial
table has `none` where nothing is chosen yet. `Sm b f p` adds f over every completion of p. `F B w t` is w (k + 1)
when table t takes k steps and then halts, k ≤ B, and 0 otherwise.

`tree` runs a partial table from blank. Where it reaches an undefined entry after k steps, the 4 halting choices
finish every completion there, and each other choice is a child that resumes from the same configuration. If it
runs past step B without reaching one, no completion halts within B. `tree_sound` turns a successful run into
the value of `Sm`, so `decide` only has to replay the tree, not every table.
-/
import FarCerts.Explore

set_option autoImplicit false

namespace FAR
namespace Count

def ruleAt (c : Nat) : Option Rule :=
  if c < 4 then none else some ((c - 4) % 2, (c - 4) / 2 % 2 == 1, (c - 4) / 4)

/-- The rules of entries i, i + 1, ... -/
def rulesFrom : Nat → List (Option Nat) → List (Nat × Nat × Nat × Bool × Nat)
  | _, [] => []
  | i, o :: p => ((o.bind ruleAt).map fun r => (i / 2, i % 2, r)).toList ++ rulesFrom (i + 1) p

def mach (p : List (Option Nat)) : Machine := { S := 2, n := p.length / 2, rules := rulesFrom 0 p }

def look (p : List (Option Nat)) (q a : Nat) : Option Rule :=
  if a < 2 then (p.getD (2 * q + a) none).bind ruleAt else none

theorem find_rulesFrom (q a : Nat) : ∀ (p : List (Option Nat)) (i : Nat),
    ((rulesFrom i p).find? (fun r => r.1 == q && r.2.1 == a)).map (fun r => r.2.2) =
      if i ≤ 2 * q + a ∧ a < 2 then (p.getD (2 * q + a - i) none).bind ruleAt else none
  | [], i => by simp [rulesFrom]
  | o :: p, i => by
    have ih := find_rulesFrom q a p (i + 1)
    simp only [rulesFrom, List.find?_append]
    by_cases hi : i = 2 * q + a ∧ a < 2
    · obtain ⟨rfl, ha⟩ := hi
      have h1 : (2 * q + a) / 2 = q := by omega
      have h2 : (2 * q + a) % 2 = a := by omega
      have ih' : ((rulesFrom (2 * q + a + 1) p).find? (fun r => r.1 == q && r.2.1 == a)).map (fun r => r.2.2) = none := by
        rw [ih, if_neg (by omega)]
      cases hr : o.bind ruleAt with
      | none => simp only [hr, Option.map_none, Option.toList_none, List.find?_nil, Option.none_or, ih', Nat.le_refl,
          ha, and_self, if_true, Nat.sub_self, List.getD_cons_zero]
      | some r =>
        -- by hand: simp's beq_self_eq_true pulls in Classical.choice
        rw [if_pos ⟨Nat.le_refl _, ha⟩, Nat.sub_self, List.getD_cons_zero, hr]
        have hb : ((2 * q + a) / 2 == q && (2 * q + a) % 2 == a) = true := by
          rw [h1, h2, show (q == q) = true from beq_iff_eq.2 rfl, show (a == a) = true from beq_iff_eq.2 rfl]; rfl
        show ((([((2 * q + a) / 2, (2 * q + a) % 2, r)]).find? (fun r => r.1 == q && r.2.1 == a)).or _).map _ = some r
        have hf := @List.find?_cons_of_pos (Nat × Nat × Nat × Bool × Nat) (fun t => t.1 == q && t.2.1 == a)
          ((2 * q + a) / 2, (2 * q + a) % 2, r) [] hb
        rw [hf]; rfl
    · -- omega must not see a negated conjunction, which would pull in Classical.choice
      have hi' : i ≠ 2 * q + a ∨ 2 ≤ a := by
        by_cases h : i = 2 * q + a
        · exact Or.inr (Nat.le_of_not_lt fun ha => hi ⟨h, ha⟩)
        · exact Or.inl h
      clear hi
      have hb : (i / 2 == q && i % 2 == a) = false := by
        cases h1 : (i / 2 == q) <;> cases h2 : (i % 2 == a) <;> try rfl
        rw [beq_iff_eq] at h1 h2
        exact absurd (by rcases hi' with h | h <;> omega : False) id
      have hne : ∀ (x : Option Rule), ((x.map fun r => (i / 2, i % 2, r)).toList.find?
          (fun r => r.1 == q && r.2.1 == a)) = none := by
        intro x; cases x with
        | none => rfl
        | some r => simp only [Option.map_some, Option.toList_some, List.find?_singleton, hb]; rfl
      rw [hne, Option.none_or, ih]
      by_cases h3 : i + 1 ≤ 2 * q + a ∧ a < 2
      · rw [if_pos h3, if_pos ⟨by omega, h3.2⟩]
        obtain ⟨j, hj⟩ : ∃ j, 2 * q + a - i = j + 1 := ⟨2 * q + a - i - 1, by omega⟩
        rw [hj, show 2 * q + a - (i + 1) = j by omega]; rfl
      · rw [if_neg h3, if_neg (fun h => h3 ⟨by clear h3; rcases hi' with h' | h' <;> omega, h.2⟩)]

theorem get_mach (p : List (Option Nat)) (q a : Nat) : (mach p).get q a = look p q a := by
  have := find_rulesFrom q a p 0
  simp only [Nat.zero_le, true_and, Nat.sub_zero] at this
  unfold Machine.get mach look; rw [this]

/-- t fills every `none` of p with a choice below b and agrees with p elsewhere. -/
def Compl (b : Nat) : List (Option Nat) → List (Option Nat) → Prop
  | [], [] => True
  | none :: p, some c :: t => c < b ∧ Compl b p t
  | some c :: p, some d :: t => c = d ∧ Compl b p t
  | _, _ => False

theorem compl_getD {b : Nat} : ∀ (p t : List (Option Nat)), Compl b p t → ∀ i c, p.getD i none = some c →
    t.getD i none = some c
  | [], [], _, _, _, h => by simp at h
  | none :: p, some _ :: t, h, 0, _, hc => by simp at hc
  | none :: p, some _ :: t, h, i + 1, c, hc => by simpa using compl_getD p t h.2 i c (by simpa using hc)
  | some _ :: p, some _ :: t, h, 0, c, hc => by simp at hc; simp [← hc, h.1]
  | some _ :: p, some _ :: t, h, i + 1, c, hc => by simpa using compl_getD p t h.2 i c (by simpa using hc)
  | [], _ :: _, h, _, _, _ | _ :: _, [], h, _, _, _ | none :: _, none :: _, h, _, _, _
  | some _ :: _, none :: _, h, _, _, _ => by simp [Compl] at h

theorem ext_compl {b : Nat} {p t : List (Option Nat)} (h : Compl b p t) : Ext (mach p) (mach t) := by
  intro q a r hr
  rw [get_mach] at hr ⊢
  unfold look at hr ⊢
  by_cases ha : a < 2
  · rw [if_pos ha] at hr ⊢
    cases hp : p.getD (2 * q + a) none with
    | none => rw [hp] at hr; cases hr
    | some c => rw [compl_getD p t h _ c hp]; rw [hp] at hr; exact hr
  · rw [if_neg ha] at hr; cases hr

theorem ext_set {p : List (Option Nat)} {e x : Nat} (he : p.getD e (some 0) = none) :
    Ext (mach p) (mach (p.set e (some x))) := by
  intro q a r hr
  rw [get_mach] at hr ⊢
  unfold look at hr ⊢
  split at hr
  · by_cases hi : 2 * q + a = e
    · subst hi
      have : p.getD (2 * q + a) none = none := by
        simp only [List.getD_eq_getElem?_getD] at he ⊢; cases h : p[2 * q + a]? <;> simp_all
      rw [this] at hr; cases hr
    · simp only [List.getD_eq_getElem?_getD, List.getElem?_set_ne (Ne.symm hi)] at hr ⊢
      rw [if_pos (by assumption)]; exact hr
  · cases hr

def Sm (b : Nat) : (List (Option Nat) → Nat) → List (Option Nat) → Nat
  | f, [] => f []
  | f, none :: p => ((List.range b).map fun c => Sm b (fun t => f (some c :: t)) p).sum
  | f, some c :: p => Sm b (fun t => f (some c :: t)) p

def nones : List (Option Nat) → Nat
  | [] => 0
  | none :: p => nones p + 1
  | some _ :: p => nones p

theorem sum_const {α : Type} (x : Nat) : ∀ (l : List α), (l.map fun _ => x).sum = l.length * x
  | [] => by simp
  | _ :: l => by simp [sum_const x l, Nat.succ_mul, Nat.add_comm]

theorem sum_add {α : Type} (f g : α → Nat) : ∀ (l : List α), (l.map fun c => f c + g c).sum = (l.map f).sum + (l.map g).sum
  | [] => by simp
  | _ :: l => by simp [sum_add f g l]; omega

theorem sum_swap {α β : Type} (g : α → β → Nat) (l2 : List β) : ∀ (l1 : List α),
    (l1.map fun x => (l2.map (g x)).sum).sum = (l2.map fun c => (l1.map fun x => g x c).sum).sum
  | [] => by simp only [List.map_nil, List.sum_nil]; exact ((sum_const 0 l2).trans (Nat.mul_zero _)).symm
  | x :: l1 => by simp only [List.map_cons, List.sum_cons]; rw [sum_swap g l2 l1, sum_add]

theorem sum_congr {α : Type} {f g : α → Nat} : ∀ (l : List α), (∀ x ∈ l, f x = g x) → (l.map f).sum = (l.map g).sum
  | [], _ => rfl
  | x :: l, h => by simp only [List.map_cons, List.sum_cons]; rw [h x (by simp), sum_congr l (fun y hy => h y (by simp [hy]))]

theorem Sm_congr {b : Nat} : ∀ (p : List (Option Nat)) (f g : List (Option Nat) → Nat),
    (∀ t, Compl b p t → f t = g t) → Sm b f p = Sm b g p
  | [], f, g, h => h [] trivial
  | none :: p, f, g, h => by
    unfold Sm
    exact sum_congr _ fun c hc => Sm_congr p _ _ fun t ht => h _ ⟨List.mem_range.1 hc, ht⟩
  | some c :: p, f, g, h => Sm_congr p _ _ fun t ht => h _ ⟨rfl, ht⟩

theorem Sm_const (b v : Nat) : ∀ (p : List (Option Nat)), Sm b (fun _ => v) p = v * b ^ nones p
  | [] => by simp [Sm, nones]
  | none :: p => by
    simp only [Sm, nones, Sm_const b v p, sum_const, List.length_range, Nat.pow_succ]
    rw [Nat.mul_comm b, Nat.mul_assoc]
  | some c :: p => by simp only [Sm, nones]; exact Sm_const b v p

theorem Sm_split (b : Nat) : ∀ (p : List (Option Nat)) (f : List (Option Nat) → Nat) (e : Nat),
    p.getD e (some 0) = none → Sm b f p = ((List.range b).map fun c => Sm b f (p.set e (some c))).sum
  | [], _, _, h => by simp at h
  | none :: p, f, 0, _ => by simp [Sm]
  | some _ :: p, f, 0, h => by simp at h
  | some d :: p, f, e + 1, h => by
    simp only [Sm, List.set_cons_succ]
    exact Sm_split b p _ e (by simpa using h)
  | none :: p, f, e + 1, h => by
    simp only [Sm, List.set_cons_succ]
    rw [sum_congr _ fun c _ => Sm_split b p (fun t => f (some c :: t)) e (by simpa using h)]
    exact sum_swap (fun c x => Sm b (fun t => f (some c :: t)) (p.set e (some x))) _ _

theorem nones_set : ∀ (p : List (Option Nat)) (e x : Nat), p.getD e (some 0) = none →
    nones (p.set e (some x)) + 1 = nones p
  | [], _, _, h => by simp at h
  | none :: p, 0, _, _ => by simp [nones]
  | some _ :: p, 0, _, h => by simp at h
  | none :: p, e + 1, x, h => by simp only [List.set_cons_succ, nones]; rw [← nones_set p e x (by simpa using h)]
  | some _ :: p, e + 1, x, h => by simp only [List.set_cons_succ, nones]; exact nones_set p e x (by simpa using h)

theorem compl_set {b : Nat} : ∀ (p t : List (Option Nat)) (e x : Nat), Compl b (p.set e (some x)) t →
    p.getD e (some 0) = none → t.getD e none = some x
  | [], _, _, _, _, h => by simp at h
  | none :: p, some _ :: t, 0, x, h, _ => by simp [Compl] at h; simp [h.1]
  | some _ :: p, _, 0, _, _, h => by simp at h
  | none :: p, some _ :: t, e + 1, x, h, he => by
    simpa using compl_set p t e x (by simpa [Compl] using h.2) (by simpa using he)
  | some _ :: p, some _ :: t, e + 1, x, h, he => by
    simpa using compl_set p t e x (by simpa [Compl] using h.2) (by simpa using he)
  | none :: _, [], 0, _, h, _ | none :: _, none :: _, 0, _, h, _ | none :: _, [], _ + 1, _, h, _
  | none :: _, none :: _, _ + 1, _, h, _ | some _ :: _, [], _ + 1, _, h, _
  | some _ :: _, none :: _, _ + 1, _, h, _ => by simp [Compl] at h

/-- w (k + 1) if the table takes k steps and halts, k ≤ B; otherwise 0. -/
def F (B : Nat) (w : Nat → Nat) (t : List (Option Nat)) : Nat :=
  ((List.range (B + 1)).map fun j => if haltsAt (mach t) j then w (j + 1) else 0).sum

theorem sum_zero {α : Type} (g : α → Nat) : ∀ (l : List α), (∀ x ∈ l, g x = 0) → (l.map g).sum = 0
  | [], _ => rfl
  | x :: l, h => by simp only [List.map_cons, List.sum_cons]; rw [h x (by simp), sum_zero g l (fun y hy => h y (by simp [hy]))]

theorem F_zero {B : Nat} {w : Nat → Nat} {t : List (Option Nat)} (h : ∀ j ≤ B, haltsAt (mach t) j = false) :
    F B w t = 0 :=
  sum_zero _ _ fun j hj => by rw [h j (by simp at hj; omega)]; rfl

theorem sum_one (g : Nat → Nat) (k v : Nat) (hg : ∀ j, g j = if j = k then v else 0) : ∀ N, k < N →
    ((List.range N).map g).sum = v
  | 0, h => by omega
  | N + 1, h => by
    rw [List.range_succ, List.map_append, List.sum_append]
    by_cases hk : k = N
    · subst hk
      rw [sum_zero g _ (fun j hj => by rw [hg]; simp at hj; simp; omega)]
      simp [hg]
    · rw [sum_one g k v hg N (by omega)]; simp [hg, Ne.symm hk]

theorem F_halt {B k : Nat} {w : Nat → Nat} {t : List (Option Nat)} (h : haltsAt (mach t) k = true) (hk : k ≤ B) :
    F B w t = w (k + 1) := by
  unfold F
  refine sum_one _ k _ (fun j => ?_) _ (by omega)
  by_cases hj : j = k
  · subst hj; simp [h]
  · have : haltsAt (mach t) j = false := by
      cases hh : haltsAt (mach t) j
      · rfl
      · exact absurd (halt_unique hh h) hj
    simp [this, hj]

theorem get_of_step {M : Machine} {c d : Config} (h : step M c = some d) : M.get c.q c.a ≠ none := by
  intro hg; unfold step at h; rw [hg] at h; cases h

/-- Every configuration a run passes through has a rule. -/
theorem run_live (M : Machine) : ∀ k c d, run M k c = some d → ∀ j < k, ∃ e, run M j c = some e ∧ M.get e.q e.a ≠ none
  | 0, _, _, _, j, hj => by omega
  | k + 1, c, d, h, j, hj => by
    simp only [run] at h
    cases hs : step M c with
    | none => simp [hs] at h
    | some c1 =>
      rw [hs] at h
      cases j with
      | zero => exact ⟨c, rfl, get_of_step hs⟩
      | succ j =>
        obtain ⟨e, he, hg⟩ := run_live M k c1 d h j (by omega)
        exact ⟨e, by simp only [run]; rw [hs]; exact he, hg⟩

theorem firstStuck_none (M : Machine) : ∀ f k c, firstStuck M f k c = none →
    ∀ j < f, ∃ e, run M j c = some e ∧ M.get e.q e.a ≠ none
  | 0, _, _, _, j, hj => by omega
  | f + 1, k, c, h, j, hj => by
    simp only [firstStuck] at h
    cases hs : step M c with
    | none => simp [hs] at h
    | some d =>
      rw [hs] at h
      cases j with
      | zero => exact ⟨c, rfl, get_of_step hs⟩
      | succ j =>
        obtain ⟨e, he, hg⟩ := firstStuck_none M f (k + 1) d h j (by omega)
        exact ⟨e, by simp only [run]; rw [hs]; exact he, hg⟩

theorem not_halt_ext {m M : Machine} (h : Ext m M) {j : Nat} {d : Config} (hr : run m j blank = some d)
    (hg : m.get d.q d.a ≠ none) : haltsAt M j = false := by
  unfold haltsAt
  rw [run_ext h j blank d hr]
  cases hm : m.get d.q d.a with
  | none => exact absurd hm hg
  | some r => simp [h _ _ _ hm]

end Count
end FAR
