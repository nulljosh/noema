/-
Soundness of FAR certificates for Turing machines run from a blank tape.

A machine lists rules (q, a, w, right, n): in state q reading a, write w, move right if `right`, go to state n.
A missing rule is a halt. `Halts M` says the run from blank reaches a configuration with no rule.
A certificate is a DFA over words (tape letters 0..S-1, head letters S + S*q + a) plus witness sets.
`Checks M C` is a finite list of local facts that `decide` settles; `never_halts` turns them into ¬ Halts M.
-/
set_option autoImplicit false
set_option linter.unusedSimpArgs false

namespace FAR

abbrev Rule := Nat × Bool × Nat

structure Machine where
  S : Nat
  n : Nat
  rules : List (Nat × Nat × Nat × Bool × Nat)

def Machine.get (M : Machine) (q a : Nat) : Option Rule :=
  (M.rules.find? (fun r => r.1 == q && r.2.1 == a)).map (fun r => r.2.2)

/-- State, cells left of the head (nearest first), the head cell, cells right of the head (nearest first).
Every cell beyond the lists is 0. -/
structure Config where
  q : Nat
  L : List Nat
  a : Nat
  R : List Nat

def step (M : Machine) (c : Config) : Option Config :=
  match M.get c.q c.a with
  | none => none
  | some (w, true, n) => some ⟨n, w :: c.L, c.R.headD 0, c.R.tail⟩
  | some (w, false, n) => some ⟨n, c.L.tail, c.L.headD 0, w :: c.R⟩

def run (M : Machine) : Nat → Config → Option Config
  | 0, c => some c
  | k + 1, c => (step M c).bind (run M k)

def blank : Config := ⟨0, [], 0, []⟩

def Halts (M : Machine) : Prop :=
  ∃ k c, run M k blank = some c ∧ M.get c.q c.a = none

structure Cert where
  delta : List (List Nat)
  acc : List Bool
  reachAll : List Nat
  good : List Nat
  reachTape : List Nat
  rel : List (Nat × Nat)
  z : List Nat
  z2 : List Nat

def Cert.d (C : Cert) (s x : Nat) : Nat := (C.delta.getD s []).getD x 0
def Cert.ac (C : Cert) (s : Nat) : Bool := C.acc.getD s false
def Cert.run (C : Cert) (s : Nat) (w : List Nat) : Nat := w.foldl C.d s

def letter (M : Machine) (q a : Nat) : Nat := M.S + M.S * q + a
def Machine.nl (M : Machine) : Nat := M.S + M.S * M.n

/-- The two-letter window a rule rewrites, before and after, with neighbour symbol b. -/
def before (M : Machine) : Nat × Nat × Nat × Bool × Nat → Nat → List Nat
  | (q, a, _, true, _), b => [letter M q a, b]
  | (q, a, _, false, _), b => [b, letter M q a]

def after (M : Machine) : Nat × Nat × Nat × Bool × Nat → Nat → List Nat
  | (_, _, w, true, n), b => [w, letter M n b]
  | (_, _, w, false, n), b => [letter M n b, w]

abbrev Checks (M : Machine) (C : Cert) : Prop :=
  0 < M.S ∧ 0 < M.n ∧
  (∀ r ∈ M.rules, r.2.2.1 < M.S ∧ r.2.2.2.2 < M.n) ∧
  -- E: an undefined head letter, read from any reachable state, leads into `good`, which only accepts.
  0 ∈ C.reachAll ∧
  (∀ s ∈ C.reachAll, ∀ x ∈ List.range M.nl, C.d s x ∈ C.reachAll) ∧
  (∀ s ∈ C.good, C.ac s = true ∧ ∀ x ∈ List.range M.nl, C.d s x ∈ C.good) ∧
  (∀ s ∈ C.reachAll, ∀ q ∈ List.range M.n, ∀ a ∈ List.range M.S,
    M.get q a = none → C.d s (letter M q a) ∈ C.good) ∧
  -- I1: zeros, the blank head letter, zeros: never accepted.
  0 ∈ C.z ∧
  (∀ s ∈ C.z, C.d s 0 ∈ C.z ∧ C.d s (letter M 0 0) ∈ C.z2) ∧
  (∀ s ∈ C.z2, C.d s 0 ∈ C.z2 ∧ C.ac s = false) ∧
  -- I3: every rule window, after a tape-only prefix, maps into rel, which carries acceptance forward.
  0 ∈ C.reachTape ∧
  (∀ s ∈ C.reachTape, ∀ x ∈ List.range M.S, C.d s x ∈ C.reachTape) ∧
  (∀ p ∈ C.rel, (C.ac p.1 = true → C.ac p.2 = true) ∧
    ∀ x ∈ List.range M.S, (C.d p.1 x, C.d p.2 x) ∈ C.rel) ∧
  (∀ s ∈ C.reachTape, ∀ r ∈ M.rules, ∀ b ∈ List.range M.S,
    (C.run s (after M r b), C.run s (before M r b)) ∈ C.rel)

theorem run_append (C : Cert) (s : Nat) (u v : List Nat) : C.run s (u ++ v) = C.run (C.run s u) v := by
  simp [Cert.run, List.foldl_append]

theorem closed_run (C : Cert) (X : List Nat) (P : Nat → Prop) (hc : ∀ s ∈ X, ∀ x, P x → C.d s x ∈ X) :
    ∀ (w : List Nat) (s : Nat), s ∈ X → (∀ x ∈ w, P x) → C.run s w ∈ X
  | [], _, hs, _ => hs
  | x :: w, s, hs, hw => by
    show C.run (C.d s x) w ∈ X
    exact closed_run C X P hc w _ (hc s hs x (hw x (by simp))) (fun y hy => hw y (by simp [hy]))

theorem rel_sound (C : Cert) (S : Nat)
    (hR : ∀ p ∈ C.rel, (C.ac p.1 = true → C.ac p.2 = true) ∧ ∀ x ∈ List.range S, (C.d p.1 x, C.d p.2 x) ∈ C.rel) :
    ∀ (y : List Nat) (p q : Nat), (p, q) ∈ C.rel → (∀ x ∈ y, x < S) →
      C.ac (C.run p y) = true → C.ac (C.run q y) = true
  | [], _, _, hpq, _, ha => (hR _ hpq).1 ha
  | x :: y, p, q, hpq, hy, ha =>
    rel_sound C S hR y (C.d p x) (C.d q x)
      ((hR _ hpq).2 x (List.mem_range.2 (hy x (by simp)))) (fun e he => hy e (by simp [he])) ha

def Valid (M : Machine) (c : Config) : Prop :=
  c.q < M.n ∧ c.a < M.S ∧ (∀ x ∈ c.L, x < M.S) ∧ (∀ x ∈ c.R, x < M.S)

theorem get_mem (M : Machine) (q a : Nat) (r : Rule) (h : M.get q a = some r) :
    (q, a, r) ∈ M.rules := by
  unfold Machine.get at h
  cases hf : M.rules.find? (fun r => r.1 == q && r.2.1 == a) with
  | none => simp [hf] at h
  | some t =>
    simp [hf] at h
    have hm := List.mem_of_find?_eq_some hf
    have hp := List.find?_some hf
    simp at hp
    obtain ⟨h1, h2⟩ := hp
    subst h
    have : t = (q, a, t.2.2) := by
      obtain ⟨t1, t2, t3⟩ := t
      simp_all
    rw [← this]
    exact hm

def rep (M : Machine) (c : Config) (i j : Nat) : List Nat :=
  List.replicate i 0 ++ c.L.reverse ++ letter M c.q c.a :: (c.R ++ List.replicate j 0)

theorem nl_ge (M : Machine) : M.S ≤ M.nl := by
  unfold Machine.nl; omega

theorem transfer (M : Machine) (C : Cert) (h : Checks M C) (x y : List Nat) (t : Nat × Nat × Nat × Bool × Nat)
    (ht : t ∈ M.rules) (b : Nat) (hb : b < M.S) (hx : ∀ e ∈ x, e < M.S) (hy : ∀ e ∈ y, e < M.S)
    (ha : C.ac (C.run 0 (x ++ after M t b ++ y)) = true) : C.ac (C.run 0 (x ++ before M t b ++ y)) = true := by
  obtain ⟨-, -, -, -, -, -, -, -, -, -, h0T, hT, hR, hW⟩ := h
  have hs : C.run 0 x ∈ C.reachTape :=
    closed_run C C.reachTape (· < M.S) (fun s hs x hx => hT s hs x (List.mem_range.2 hx)) x 0 h0T hx
  rw [run_append, run_append] at ha ⊢
  exact rel_sound C M.S hR y _ _ (hW _ hs t ht b (List.mem_range.2 hb)) hy ha

theorem accept_of_halt (M : Machine) (C : Cert) (h : Checks M C) :
    ∀ (k : Nat) (c : Config) (i j : Nat), Valid M c → k ≤ i → k ≤ j →
      ∀ c', run M k c = some c' → M.get c'.q c'.a = none → C.ac (C.run 0 (rep M c i j)) = true
  | 0, c, i, j, hv, _, _, c', hr, hg => by
    obtain ⟨hS, -, -, h0A, hA, hG, hE, -⟩ := h
    simp [run] at hr
    subst hr
    obtain ⟨hq, ha, hL, hR⟩ := hv
    have hnl := nl_ge M
    have hA' : ∀ s ∈ C.reachAll, ∀ x, x < M.nl → C.d s x ∈ C.reachAll :=
      fun s hs x hx => hA s hs x (List.mem_range.2 hx)
    have hpre : C.run 0 (List.replicate i 0 ++ c.L.reverse) ∈ C.reachAll :=
      closed_run C _ (· < M.nl) hA' _ 0 h0A (by
        intro e he
        simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he
        rcases he with ⟨-, rfl⟩ | he
        · omega
        · have := hL e he; omega)
    have hgood := hE _ hpre c.q (List.mem_range.2 hq) c.a (List.mem_range.2 ha) hg
    have hpost : C.run (C.d (C.run 0 (List.replicate i 0 ++ c.L.reverse)) (letter M c.q c.a))
        (c.R ++ List.replicate j 0) ∈ C.good :=
      closed_run C _ (· < M.nl) (fun s hs x hx => (hG s hs).2 x (List.mem_range.2 hx)) _ _ hgood (by
        intro e he
        simp only [List.mem_append, List.mem_replicate] at he
        rcases he with he | ⟨-, rfl⟩
        · have := hR e he; omega
        · omega)
    have : rep M c i j = (List.replicate i 0 ++ c.L.reverse) ++ (letter M c.q c.a :: (c.R ++ List.replicate j 0)) := by
      simp [rep]
    rw [this, run_append]
    exact (hG _ hpost).1
  | k + 1, c, i, j, hv, hi, hj, c', hr, hg => by
    have hrules := h.2.2.1
    simp only [run] at hr
    cases hs : step M c with
    | none => simp [hs] at hr
    | some c1 =>
      rw [hs] at hr
      simp only [Option.bind] at hr
      obtain ⟨hq, ha, hL, hRv⟩ := hv
      unfold step at hs
      cases hgc : M.get c.q c.a with
      | none => simp [hgc] at hs
      | some r =>
        obtain ⟨w, dir, n⟩ := r
        have hm := get_mem M c.q c.a _ hgc
        have hw := (hrules _ hm).1
        have hn := (hrules _ hm).2
        simp only at hw hn
        cases dir with
        | true =>
          simp [hgc] at hs
          subst hs
          cases hRc : c.R with
          | cons b R' =>
            have hb : b < M.S := hRv b (by simp [hRc])
            have hv1 : Valid M ⟨n, w :: c.L, b, R'⟩ :=
              ⟨hn, hb, by simp; exact ⟨hw, hL⟩, fun x hx => hRv x (by simp [hRc, hx])⟩
            have ih := accept_of_halt M C h k ⟨n, w :: c.L, b, R'⟩ i j hv1 (by omega) (by omega) c'
              (by simpa [hRc] using hr) hg
            have e1 : rep M c i j = (List.replicate i 0 ++ c.L.reverse) ++ before M (c.q, c.a, w, true, n) b ++
                (R' ++ List.replicate j 0) := by simp [rep, before, hRc]
            have e2 : rep M ⟨n, w :: c.L, b, R'⟩ i j = (List.replicate i 0 ++ c.L.reverse) ++
                after M (c.q, c.a, w, true, n) b ++ (R' ++ List.replicate j 0) := by simp [rep, after]
            rw [e1]
            rw [e2] at ih
            exact transfer M C h _ _ _ hm b hb
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with ⟨-, rfl⟩ | he; exact h.1; exact hL e he)
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with he | ⟨-, rfl⟩
                  · exact hRv e (by simp [hRc, he])
                  · exact h.1) ih
          | nil =>
            obtain ⟨j', rfl⟩ : ∃ j', j = j' + 1 := ⟨j - 1, by omega⟩
            have hv1 : Valid M ⟨n, w :: c.L, 0, []⟩ := ⟨hn, h.1, by simp; exact ⟨hw, hL⟩, by simp⟩
            have ih := accept_of_halt M C h k ⟨n, w :: c.L, 0, []⟩ i j' hv1 (by omega) (by omega) c'
              (by simpa [hRc] using hr) hg
            have e1 : rep M c i (j' + 1) = (List.replicate i 0 ++ c.L.reverse) ++
                before M (c.q, c.a, w, true, n) 0 ++ List.replicate j' 0 := by
              simp [rep, before, hRc, List.replicate_succ]
            have e2 : rep M ⟨n, w :: c.L, 0, []⟩ i j' = (List.replicate i 0 ++ c.L.reverse) ++
                after M (c.q, c.a, w, true, n) 0 ++ List.replicate j' 0 := by simp [rep, after]
            rw [e1]
            rw [e2] at ih
            exact transfer M C h _ _ _ hm 0 h.1
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with ⟨-, rfl⟩ | he; exact h.1; exact hL e he)
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rw [he.2]; exact h.1) ih
        | false =>
          simp [hgc] at hs
          subst hs
          cases hLc : c.L with
          | cons b L' =>
            have hb : b < M.S := hL b (by simp [hLc])
            have hv1 : Valid M ⟨n, L', b, w :: c.R⟩ :=
              ⟨hn, hb, fun x hx => hL x (by simp [hLc, hx]), by simp; exact ⟨hw, hRv⟩⟩
            have ih := accept_of_halt M C h k ⟨n, L', b, w :: c.R⟩ i j hv1 (by omega) (by omega) c'
              (by simpa [hLc] using hr) hg
            have e1 : rep M c i j = (List.replicate i 0 ++ L'.reverse) ++ before M (c.q, c.a, w, false, n) b ++
                (c.R ++ List.replicate j 0) := by simp [rep, before, hLc]
            have e2 : rep M ⟨n, L', b, w :: c.R⟩ i j = (List.replicate i 0 ++ L'.reverse) ++
                after M (c.q, c.a, w, false, n) b ++ (c.R ++ List.replicate j 0) := by simp [rep, after]
            rw [e1]
            rw [e2] at ih
            exact transfer M C h _ _ _ hm b hb
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with ⟨-, rfl⟩ | he
                  · exact h.1
                  · exact hL e (by simp [hLc, he]))
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with he | ⟨-, rfl⟩
                  · exact hRv e he
                  · exact h.1) ih
          | nil =>
            obtain ⟨i', rfl⟩ : ∃ i', i = i' + 1 := ⟨i - 1, by omega⟩
            have hv1 : Valid M ⟨n, [], 0, w :: c.R⟩ := ⟨hn, h.1, by simp, by simp; exact ⟨hw, hRv⟩⟩
            have ih := accept_of_halt M C h k ⟨n, [], 0, w :: c.R⟩ i' j hv1 (by omega) (by omega) c'
              (by simpa [hLc] using hr) hg
            have e1 : rep M c (i' + 1) j = List.replicate i' 0 ++ before M (c.q, c.a, w, false, n) 0 ++
                (c.R ++ List.replicate j 0) := by
              simp [rep, before, hLc, List.replicate_succ']
            have e2 : rep M ⟨n, [], 0, w :: c.R⟩ i' j = List.replicate i' 0 ++
                after M (c.q, c.a, w, false, n) 0 ++ (c.R ++ List.replicate j 0) := by simp [rep, after]
            rw [e1]
            rw [e2] at ih
            exact transfer M C h _ _ _ hm 0 h.1
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rw [he.2]; exact h.1)
              (by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; rcases he with he | ⟨-, rfl⟩
                  · exact hRv e he
                  · exact h.1) ih

theorem never_halts (M : Machine) (C : Cert) (h : Checks M C) : ¬ Halts M := by
  rintro ⟨k, c, hk, hg⟩
  have ha := accept_of_halt M C h k blank k k ⟨h.2.1, h.1, by simp [blank], by simp [blank]⟩
    (Nat.le_refl k) (Nat.le_refl k) c hk hg
  obtain ⟨-, -, -, -, -, -, -, h0z, hz, hz2, -⟩ := h
  have zeros : ∀ e ∈ List.replicate k 0, e = 0 := by intro e he; simp only [List.mem_append, List.mem_replicate, List.mem_reverse] at he; exact he.2
  have h1 : C.run 0 (List.replicate k 0) ∈ C.z :=
    closed_run C C.z (· = 0) (fun s hs x hx => by subst hx; exact (hz s hs).1) _ 0 h0z zeros
  have h2 : C.run (C.d (C.run 0 (List.replicate k 0)) (letter M 0 0)) (List.replicate k 0) ∈ C.z2 :=
    closed_run C C.z2 (· = 0) (fun s hs x hx => by subst hx; exact (hz2 s hs).1) _ _ (hz _ h1).2 zeros
  have e : rep M blank k k = List.replicate k 0 ++ [letter M 0 0] ++ List.replicate k 0 := by
    simp [rep, blank]
  rw [e, run_append, run_append] at ha
  have := (hz2 _ h2).2
  simp only [Cert.run, List.foldl] at ha this
  rw [this] at ha
  exact Bool.false_ne_true ha

/-- The same machine with every move flipped. It runs the mirror image of the original from blank. -/
def Machine.mirror (M : Machine) : Machine :=
  { M with rules := M.rules.map (fun r => (r.1, r.2.1, r.2.2.1, !r.2.2.2.1, r.2.2.2.2)) }

def flip (c : Config) : Config := ⟨c.q, c.R, c.a, c.L⟩

theorem get_mirror (M : Machine) (q a : Nat) :
    M.mirror.get q a = (M.get q a).map (fun r => (r.1, !r.2.1, r.2.2)) := by
  simp only [Machine.get, Machine.mirror, List.find?_map]
  show Option.map _ (Option.map _ (List.find? (fun r => r.1 == q && r.2.1 == a) M.rules)) = _
  cases M.rules.find? (fun r => r.1 == q && r.2.1 == a) <;> rfl

theorem step_mirror (M : Machine) (c : Config) : step M.mirror (flip c) = (step M c).map flip := by
  unfold step
  simp only [flip, get_mirror]
  cases M.get c.q c.a with
  | none => rfl
  | some r =>
    obtain ⟨w, dir, n⟩ := r
    cases dir <;> rfl

theorem run_mirror (M : Machine) : ∀ k c, run M.mirror k (flip c) = (run M k c).map flip
  | 0, _ => rfl
  | k + 1, c => by
    simp only [run, step_mirror]
    cases step M c with
    | none => rfl
    | some c1 => exact run_mirror M k c1

theorem never_halts_of_mirror (M : Machine) (C : Cert) (h : Checks M.mirror C) : ¬ Halts M := by
  rintro ⟨k, c, hk, hg⟩
  apply never_halts M.mirror C h
  refine ⟨k, flip c, ?_, ?_⟩
  · have := run_mirror M k blank
    rw [hk] at this
    exact this
  · simp [flip, get_mirror, hg]

end FAR
