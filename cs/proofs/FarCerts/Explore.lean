/-
The symmetries busy.py uses, and the checker that replays its tree. See Tree.lean for the plan.
-/
import FarCerts.Tree

set_option autoImplicit false

namespace FAR

theorem haltsAt_mirror (M : Machine) (k : Nat) : haltsAt M.mirror k = haltsAt M k := by
  unfold haltsAt
  have := run_mirror M k blank
  rw [show flip blank = blank from rfl] at this
  rw [this]
  cases run M k blank with
  | none => rfl
  | some c => simp only [Option.map, flip, get_mirror]; cases M.get c.q c.a <;> rfl

theorem wf_mirror {M : Machine} (h : WF M) : WF M.mirror := by
  intro q a r hr
  rw [get_mirror] at hr
  cases hg : M.get q a with
  | none => rw [hg] at hr; cases hr
  | some r0 => rw [hg] at hr; obtain rfl := Option.some.inj hr; exact ⟨(h _ _ _ hg).1, (h _ _ _ hg).2⟩

/-- Swap states 1 and 2. -/
def sw : Nat → Nat
  | 1 => 2
  | 2 => 1
  | s => s

theorem sw_sw : ∀ s, sw (sw s) = s
  | 0 => rfl
  | 1 => rfl
  | 2 => rfl
  | _ + 3 => rfl

theorem sw_lt : ∀ s, s < 3 → sw s < 3
  | 0, _ => by decide
  | 1, _ => by decide
  | 2, _ => by decide
  | _ + 3, h => by omega

theorem sw_beq (x q : Nat) : (sw x == q) = (x == sw q) := by
  rw [Bool.eq_iff_iff]; simp only [beq_iff_eq]
  exact ⟨fun h => by rw [← h, sw_sw], fun h => by rw [h, sw_sw]⟩

def Machine.swap (M : Machine) : Machine :=
  { M with rules := M.rules.map (fun r => (sw r.1, r.2.1, r.2.2.1, r.2.2.2.1, sw r.2.2.2.2)) }

theorem get_swap (M : Machine) (q a : Nat) :
    M.swap.get q a = (M.get (sw q) a).map (fun r => (r.1, r.2.1, sw r.2.2)) := by
  simp only [Machine.get, Machine.swap, List.find?_map]
  have : ((fun r : Nat × Nat × Nat × Bool × Nat => r.1 == q && r.2.1 == a) ∘
      (fun r : Nat × Nat × Nat × Bool × Nat => (sw r.1, r.2.1, r.2.2.1, r.2.2.2.1, sw r.2.2.2.2))) =
      (fun r : Nat × Nat × Nat × Bool × Nat => r.1 == sw q && r.2.1 == a) := by
    funext r; simp only [Function.comp, sw_beq]
  rw [this]
  cases M.rules.find? (fun r => r.1 == sw q && r.2.1 == a) <;> rfl

def rn (c : Config) : Config := ⟨sw c.q, c.L, c.a, c.R⟩

theorem step_swap (M : Machine) (c : Config) : step M.swap (rn c) = (step M c).map rn := by
  unfold step
  simp only [rn, get_swap, sw_sw]
  cases M.get c.q c.a with
  | none => rfl
  | some r => obtain ⟨w, dir, n⟩ := r; cases dir <;> rfl

theorem run_swap (M : Machine) : ∀ k c, run M.swap k (rn c) = (run M k c).map rn
  | 0, _ => rfl
  | k + 1, c => by
    simp only [run, step_swap]
    cases step M c with
    | none => rfl
    | some c1 => exact run_swap M k c1

theorem haltsAt_swap (M : Machine) (k : Nat) : haltsAt M.swap k = haltsAt M k := by
  unfold haltsAt
  have := run_swap M k blank
  rw [show rn blank = blank from rfl] at this
  rw [this]
  cases run M k blank with
  | none => rfl
  | some c => simp only [Option.map, rn, get_swap, sw_sw]; cases M.get c.q c.a <;> rfl

theorem wf_swap {M : Machine} (h : WF M) : WF M.swap := by
  intro q a r hr
  rw [get_swap] at hr
  cases hg : M.get (sw q) a with
  | none => rw [hg] at hr; cases hr
  | some r0 =>
    rw [hg] at hr; obtain rfl := Option.some.inj hr
    exact ⟨(h _ _ _ hg).1, sw_lt _ (h _ _ _ hg).2⟩

def zeroOnly (M : Machine) : Bool := M.rules.all (fun t => t.1 == 0 && t.2.2.2.2 == 0)

theorem ext_swap {m M : Machine} (hz : zeroOnly m = true) (h : Ext m M) : Ext m M.swap := by
  intro q a r hr
  have hm := List.all_eq_true.1 hz _ (get_mem m q a r hr)
  simp only [Bool.and_eq_true, beq_iff_eq] at hm
  obtain ⟨rfl, hn⟩ := hm
  rw [get_swap, show sw 0 = 0 from rfl, h _ _ _ hr]
  obtain ⟨w, d, n⟩ := r
  simp only at hn
  subst hn
  rfl

def setRule (M : Machine) (q a : Nat) (r : Rule) : Machine := { M with rules := M.rules ++ [(q, a, r)] }

theorem ext_set {m M : Machine} {q a : Nat} {r : Rule} (h : Ext m M) (hr : M.get q a = some r) :
    Ext (setRule m q a r) M := by
  intro q' a' r' h'
  simp only [Machine.get, setRule, List.find?_append] at h'
  cases hf : m.rules.find? (fun t => t.1 == q' && t.2.1 == a') with
  | some t =>
    apply h
    unfold Machine.get
    rw [hf]
    rw [hf] at h'
    exact h'
  | none =>
    rw [hf] at h'
    cases hp : (q == q' && a == a') with
    | false => simp only [List.find?_cons, hp, List.find?_nil] at h'; cases h'
    | true =>
      simp only [List.find?_cons, hp] at h'
      have e : r = r' := Option.some.inj h'
      simp only [Bool.and_eq_true, beq_iff_eq] at hp
      obtain ⟨rfl, rfl⟩ := hp
      rw [← e]; exact hr

/-- The rules busy.py tries at an undefined (q, a), in the order its stack pops them. -/
def choices (m : Machine) (q : Nat) : List Rule :=
  let moves := if m.rules.isEmpty then [true] else [false, true]
  let nexts := if zeroOnly m && q == 0 then [0, 1] else [0, 1, 2]
  ([0, 1].flatMap fun w => moves.flatMap fun d => nexts.map fun n => (w, d, n)).reverse

theorem mem_choices (m : Machine) (q w n : Nat) (d : Bool) (hw : w < 2) (hn : n < 3)
    (hd : d = true ∨ m.rules.isEmpty = false) (hs : n < 2 ∨ (zeroOnly m && q == 0) = false) :
    (w, d, n) ∈ choices m q := by
  simp only [choices, List.mem_reverse, List.mem_flatMap, List.mem_map]
  refine ⟨w, by have : w = 0 ∨ w = 1 := (by omega); rcases this with rfl | rfl <;> simp, d, ?_, n, ?_, rfl⟩
  · cases he : m.rules.isEmpty <;> cases d <;> simp_all
  · have : n = 0 ∨ n = 1 ∨ n = 2 := by omega
    cases hz : (zeroOnly m && q == 0) <;> simp only [hz] at hs ⊢ <;> rcases this with rfl | rfl | rfl <;> simp_all

/-- If an extension M defines the rule m lacks at c, one symmetric copy of M extends a child of m. -/
theorem sym_child {m M : Machine} {c : Config} (hext : Ext m M) (hw : WF M) (r : Rule) (hr : M.get c.q c.a = some r) :
    ∃ M2, ∃ r2 ∈ choices m c.q, WF M2 ∧ (∀ k, haltsAt M2 k = haltsAt M k) ∧ Ext m M2 ∧ M2.get c.q c.a = some r2 := by
  obtain ⟨w, d, n⟩ := r
  obtain ⟨hw1, hn⟩ := hw _ _ _ hr
  simp only at hw1 hn
  -- first the mirror, at the root only
  obtain ⟨M1, d1, h1w, h1k, h1e, h1g, h1d⟩ : ∃ M1 d1, WF M1 ∧ (∀ k, haltsAt M1 k = haltsAt M k) ∧ Ext m M1 ∧
      M1.get c.q c.a = some (w, d1, n) ∧ (d1 = true ∨ m.rules.isEmpty = false) := by
    cases d with
    | true => exact ⟨M, true, hw, fun _ => rfl, hext, hr, Or.inl rfl⟩
    | false =>
      cases he : m.rules.isEmpty with
      | false => exact ⟨M, false, hw, fun _ => rfl, hext, hr, Or.inr rfl⟩
      | true =>
        have hnil : m.rules = [] := List.isEmpty_iff.1 he
        refine ⟨M.mirror, true, wf_mirror hw, haltsAt_mirror M, ?_, ?_, Or.inl rfl⟩
        · intro q a r h; simp [Machine.get, hnil] at h
        · rw [get_mirror, hr]; rfl
  cases hz : (zeroOnly m && c.q == 0 && n == 2) with
  | false =>
    refine ⟨M1, (w, d1, n), mem_choices m c.q w n d1 hw1 hn h1d ?_, h1w, h1k, h1e, h1g⟩
    cases hzq : (zeroOnly m && c.q == 0) with
    | false => exact Or.inr rfl
    | true => left; rw [hzq] at hz; simp at hz; omega
  | true =>
    simp only [Bool.and_eq_true, beq_iff_eq] at hz
    obtain ⟨⟨hzm, hq⟩, rfl⟩ := hz
    refine ⟨M1.swap, (w, d1, 1), mem_choices m c.q w 1 d1 hw1 (by decide) h1d (Or.inl (by decide)), wf_swap h1w,
      fun k => (haltsAt_swap M1 k).trans (h1k k), ext_swap hzm h1e, ?_⟩
    rw [hq] at h1g
    rw [get_swap, hq]
    show (M1.get 0 c.a).map _ = _
    rw [h1g]; rfl

abbrev Qs := List Machine × List Machine × List Machine

def extB (x M : Machine) : Bool := x.rules.all (fun t => M.get t.1 t.2.1 == some t.2.2)

theorem ext_of_extB {x M : Machine} (h : extB x M = true) : Ext x M := by
  intro q a r hr
  have := List.all_eq_true.1 h _ (get_mem x q a r hr)
  simpa using this

def pop1 (M : Machine) : List Machine → Option (List Machine)
  | x :: xs => if extB x M then some xs else none
  | [] => none

/-- A leaf must extend the head of one of the three queues, which is then dropped. -/
def pop (M : Machine) (Q : Qs) : Option Qs :=
  match pop1 M Q.1 with
  | some xs => some (xs, Q.2.1, Q.2.2)
  | none => match pop1 M Q.2.1 with
    | some ys => some (Q.1, ys, Q.2.2)
    | none => (pop1 M Q.2.2).map fun zs => (Q.1, Q.2.1, zs)

def Good (Q : Qs) : Prop := (∀ x ∈ Q.1, ¬ Halts x) ∧ (∀ x ∈ Q.2.1, ¬ Halts x) ∧ ∀ x ∈ Q.2.2, ¬ Halts x

theorem pop1_spec {M : Machine} {l l' : List Machine} (h : pop1 M l = some l') (hl : ∀ x ∈ l, ¬ Halts x) :
    (∀ x ∈ l', ¬ Halts x) ∧ ∃ x, ¬ Halts x ∧ Ext x M := by
  cases l with
  | nil => simp [pop1] at h
  | cons x xs =>
    simp only [pop1] at h
    cases hb : extB x M with
    | false => simp [hb] at h
    | true =>
      simp [hb] at h; subst h
      exact ⟨fun y hy => hl y (by simp [hy]), x, hl x (by simp), ext_of_extB hb⟩

theorem pop_spec {M : Machine} {Q Q' : Qs} (h : pop M Q = some Q') (hQ : Good Q) :
    Good Q' ∧ ∃ x, ¬ Halts x ∧ Ext x M := by
  obtain ⟨h1, h2, h3⟩ := hQ
  unfold pop at h
  cases ha : pop1 M Q.1 with
  | some xs =>
    simp only [ha] at h; cases h
    obtain ⟨g, e⟩ := pop1_spec ha h1
    exact ⟨⟨g, h2, h3⟩, e⟩
  | none =>
    simp only [ha] at h
    cases hb : pop1 M Q.2.1 with
    | some ys =>
      simp only [hb] at h; cases h
      obtain ⟨g, e⟩ := pop1_spec hb h2
      exact ⟨⟨h1, g, h3⟩, e⟩
    | none =>
      simp only [hb] at h
      cases hc : pop1 M Q.2.2 with
      | none => simp [hc] at h
      | some zs =>
        simp only [hc, Option.map] at h; cases h
        obtain ⟨g, e⟩ := pop1_spec hc h3
        exact ⟨⟨h1, h2, g⟩, e⟩

theorem leaf_covered {x m : Machine} (hx : ¬ Halts x) (he : Ext x m) : Covered m := by
  intro M _ hm k hk
  obtain ⟨c, hc, hg⟩ := haltsAt_spec hk
  exact absurd (halts_of_ext (fun q a r h => hm _ _ _ (he _ _ _ h)) ⟨k, c, hc, hg⟩) hx

def firstStuck (M : Machine) : Nat → Nat → Config → Option (Nat × Config)
  | 0, _, _ => none
  | f + 1, k, c => match step M c with
    | none => some (k, c)
    | some d => firstStuck M f (k + 1) d

theorem firstStuck_spec (M : Machine) : ∀ f k c k' e, firstStuck M f k c = some (k', e) →
    ∃ j, k' = k + j ∧ j < f ∧ run M j c = some e ∧ M.get e.q e.a = none
  | 0, _, _, _, _, h => by simp [firstStuck] at h
  | f + 1, k, c, k', e, h => by
    simp only [firstStuck] at h
    cases hs : step M c with
    | none =>
      simp only [hs] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
      exact ⟨0, rfl, by omega, rfl, step_none hs⟩
    | some d =>
      simp only [hs] at h
      obtain ⟨j, hj, hjf, hr, hg⟩ := firstStuck_spec M f (k + 1) d k' e h
      exact ⟨j + 1, by omega, by omega, by simp only [run]; rw [hs]; exact hr, hg⟩

/-- Every rule but the one missing at c is defined. -/
def full (M : Machine) (c : Config) : Bool :=
  (List.range 3).all fun q => (List.range 2).all fun a => (q == c.q && a == c.a) || (M.get q a).isSome

theorem full_spec {m M : Machine} {c : Config} (h : full m c = true) (he : Ext m M) (r : Rule)
    (hM : M.get c.q c.a = some r) : ∀ q a, q < 3 → a < 2 → M.get q a ≠ none := by
  intro q a hq ha
  have := List.all_eq_true.1 (List.all_eq_true.1 h q (List.mem_range.2 hq)) a (List.mem_range.2 ha)
  simp only [Bool.or_eq_true, Bool.and_eq_true, beq_iff_eq] at this
  rcases this with ⟨rfl, rfl⟩ | hs
  · rw [hM]; simp
  · obtain ⟨r', hr'⟩ := Option.isSome_iff_exists.1 hs
    rw [he _ _ _ hr']; simp

theorem node_covered {m : Machine} {k : Nat} {c : Config} (hr : run m k blank = some c) (hk : k ≤ 20)
    (kids : ∀ M, WF M → Ext m M → ∀ r, M.get c.q c.a = some r → ∀ k', haltsAt M k' = true → k' ≤ 20) :
    Covered m := by
  intro M hw he k' hk'
  cases hM : M.get c.q c.a with
  | none => rw [← halt_unique (haltsAt_of (run_ext he k blank c hr) hM) hk']; exact hk
  | some r => exact kids M hw he r hM k' hk'

def exploreList (g : Machine → Qs → Option Qs) : List Machine → Qs → Option Qs
  | [], Q => some Q
  | N :: Ns, Q => (g N Q).bind (exploreList g Ns)

def explore : Nat → Machine → Qs → Option Qs
  | 0, _, _ => none
  | f + 1, m, Q =>
    match firstStuck m 21 0 blank with
    | none => pop m Q
    | some (_, c) =>
      if 6 ≤ m.rules.length + 1 then (if full m c then some Q else none)
      else exploreList (explore f) ((choices m c.q).map (setRule m c.q c.a)) Q

theorem exploreList_spec (g : Machine → Qs → Option Qs)
    (ih : ∀ N Q Q', g N Q = some Q' → Good Q → Good Q' ∧ Covered N) :
    ∀ Ns Q Q', exploreList g Ns Q = some Q' → Good Q → Good Q' ∧ ∀ N ∈ Ns, Covered N
  | [], Q, Q', h, hQ => by simp [exploreList] at h; subst h; exact ⟨hQ, by simp⟩
  | N :: Ns, Q, Q', h, hQ => by
    simp only [exploreList] at h
    cases hg : g N Q with
    | none => simp [hg] at h
    | some Q1 =>
      rw [hg] at h
      obtain ⟨g1, c1⟩ := ih N Q Q1 hg hQ
      obtain ⟨g2, c2⟩ := exploreList_spec g ih Ns Q1 Q' h g1
      exact ⟨g2, fun x hx => by simp at hx; rcases hx with rfl | hx; exact c1; exact c2 x hx⟩

theorem explore_sound : ∀ f m Q Q', explore f m Q = some Q' → Good Q → Good Q' ∧ Covered m
  | 0, _, _, _, h, _ => by simp [explore] at h
  | f + 1, m, Q, Q', h, hQ => by
    simp only [explore] at h
    cases hs : firstStuck m 21 0 blank with
    | none =>
      simp only [hs] at h
      obtain ⟨g, x, hx, he⟩ := pop_spec h hQ
      exact ⟨g, leaf_covered hx he⟩
    | some kc =>
      obtain ⟨k, c⟩ := kc
      simp only [hs] at h
      obtain ⟨j, -, hj, hr, hg⟩ := firstStuck_spec m 21 0 blank k c hs
      split at h
      · cases hf : full m c with
        | false => simp [hf] at h
        | true =>
          simp [hf] at h; subst h
          exact ⟨hQ, node_covered hr (by omega)
            fun M hw he r hM k' hk' => absurd hk' (full_no_halt hw (full_spec hf he r hM) k')⟩
      · obtain ⟨g, hall⟩ := exploreList_spec (explore f) (explore_sound f) _ Q Q' h hQ
        refine ⟨g, node_covered hr (by omega) fun M hw he r hM k' hk' => ?_⟩
        obtain ⟨M2, r2, hmem, hw2, hk2, he2, hg2⟩ := sym_child he hw r hM
        exact hall (setRule m c.q c.a r2) (List.mem_map.2 ⟨r2, hmem, rfl⟩) M2 hw2 (ext_set he2 hg2) k'
          (by rw [hk2]; exact hk')

theorem wf_of_rules {M : Machine} (h : M.rules.all (fun t => t.2.2.1 < 2 && t.2.2.2.2 < 3) = true) : WF M := by
  intro q a r hr
  have := List.all_eq_true.1 h _ (get_mem M q a r hr)
  simp only [Bool.and_eq_true, decide_eq_true_eq] at this
  exact this

theorem forall_append {α : Type} {P : α → Prop} {l1 l2 : List α} (h1 : ∀ x ∈ l1, P x) (h2 : ∀ x ∈ l2, P x) :
    ∀ x ∈ l1 ++ l2, P x :=
  fun x hx => (List.mem_append.1 hx).elim (h1 x) (h2 x)

def root : Machine := { S := 2, n := 3, rules := [] }

/-- If the replay of busy.py's tree succeeds, no 2-symbol, 3-state machine halts after more than 20 steps. -/
theorem bb3_of_explore (Q : Qs) (hQ : Good Q) (h : (explore 8 root Q).isSome = true) :
    ∀ M, WF M → ∀ k, haltsAt M k = true → k ≤ 20 := by
  obtain ⟨Q', hQ'⟩ := Option.isSome_iff_exists.1 h
  intro M hw k hk
  exact (explore_sound 8 root Q Q' hQ' hQ).2 M hw (fun q a r h => by simp [Machine.get, root] at h) k hk

end FAR
