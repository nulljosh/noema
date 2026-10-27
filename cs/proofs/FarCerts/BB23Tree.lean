import FarCerts.Explore
import FarCerts.WCycles1
import FarCerts.WCycles2
import FarCerts.WCycles3
import FarCerts.WCycles4
import FarCerts.WTranslated1
import FarCerts.WTranslated2
import FarCerts.WTranslated3
import FarCerts.WTranslated4
import FarCerts.WTranslated5
import FarCerts.WTranslated6
import FarCerts.WTranslated7
import FarCerts.WTranslated8
import FarCerts.WTranslated9
import FarCerts.WTranslated10
import FarCerts.WTranslated11
import FarCerts.WTranslated12
import FarCerts.WTranslated13
import FarCerts.WTranslated14
import FarCerts.WTranslated15
import FarCerts.WTranslated16
import FarCerts.WTranslated17
import FarCerts.WTranslated18
import FarCerts.WTranslated19
import FarCerts.WTranslated20
import FarCerts.WTranslated21
import FarCerts.WTranslated22
import FarCerts.WTranslated23
import FarCerts.WTranslated24
import FarCerts.WTranslated25
import FarCerts.WTranslated26
import FarCerts.WTranslated27
import FarCerts.WTranslated28
import FarCerts.WTranslated29
import FarCerts.WTranslated30
import FarCerts.WTranslated31
import FarCerts.WTranslated32
import FarCerts.WTranslated33
import FarCerts.WTranslated34
import FarCerts.WTranslated35
import FarCerts.WSmall1
import FarCerts.WSmall2
import FarCerts.WSmall3
import FarCerts.WSmall4
import FarCerts.WSmall5
import FarCerts.WSmall6
import FarCerts.WSmall7
import FarCerts.WSmall8
import FarCerts.WSmall9
import FarCerts.WSmall10
import FarCerts.WSmall11
import FarCerts.WSmall12
import FarCerts.WSmall13
import FarCerts.WSmall14
import FarCerts.WSmall15
import FarCerts.WSmall16
import FarCerts.WSmall17
import FarCerts.WSmall18
import FarCerts.WSmall19
import FarCerts.WSmall20
import FarCerts.WSmall21
import FarCerts.WSmall22
import FarCerts.WSmall23
import FarCerts.WSmall24
import FarCerts.WSmall25
import FarCerts.WSmall26
import FarCerts.WSmall27
import FarCerts.WSmall28
import FarCerts.WSmall29
import FarCerts.WSmall30
import FarCerts.WSmall31
import FarCerts.WSmall32
import FarCerts.WSmall33
import FarCerts.WSmall34
import FarCerts.WSmall35
import FarCerts.WSmall36
import FarCerts.WSmall37
import FarCerts.WSmall38
import FarCerts.WSmall39
import FarCerts.WSmall40
import FarCerts.WSmall41
import FarCerts.WSmall42

set_option maxRecDepth 100000

namespace FAR

def cyc23 : List Machine := ((wCycles1 ++ wCycles2 ++ wCycles3 ++ wCycles4).filter (fun x => x.1.n == 2 && x.1.S == 3)).map (·.1)
theorem cyc23_never_halt : ∀ x ∈ cyc23, ¬ Halts x := by
  intro x hx
  unfold cyc23 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (wCycles1_never_halt) wCycles2_never_halt) wCycles3_never_halt) wCycles4_never_halt) y (List.mem_filter.1 hy).1

def tr23 : List Machine := ((wTranslated1 ++ wTranslated2 ++ wTranslated3 ++ wTranslated4 ++ wTranslated5 ++ wTranslated6 ++ wTranslated7 ++ wTranslated8 ++ wTranslated9 ++ wTranslated10 ++ wTranslated11 ++ wTranslated12 ++ wTranslated13 ++ wTranslated14 ++ wTranslated15 ++ wTranslated16 ++ wTranslated17 ++ wTranslated18 ++ wTranslated19 ++ wTranslated20 ++ wTranslated21 ++ wTranslated22 ++ wTranslated23 ++ wTranslated24 ++ wTranslated25 ++ wTranslated26 ++ wTranslated27 ++ wTranslated28 ++ wTranslated29 ++ wTranslated30 ++ wTranslated31 ++ wTranslated32 ++ wTranslated33 ++ wTranslated34 ++ wTranslated35).filter (fun x => x.1.n == 2 && x.1.S == 3)).map (·.1)
theorem tr23_never_halt : ∀ x ∈ tr23, ¬ Halts x := by
  intro x hx
  unfold tr23 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (wTranslated1_never_halt) wTranslated2_never_halt) wTranslated3_never_halt) wTranslated4_never_halt) wTranslated5_never_halt) wTranslated6_never_halt) wTranslated7_never_halt) wTranslated8_never_halt) wTranslated9_never_halt) wTranslated10_never_halt) wTranslated11_never_halt) wTranslated12_never_halt) wTranslated13_never_halt) wTranslated14_never_halt) wTranslated15_never_halt) wTranslated16_never_halt) wTranslated17_never_halt) wTranslated18_never_halt) wTranslated19_never_halt) wTranslated20_never_halt) wTranslated21_never_halt) wTranslated22_never_halt) wTranslated23_never_halt) wTranslated24_never_halt) wTranslated25_never_halt) wTranslated26_never_halt) wTranslated27_never_halt) wTranslated28_never_halt) wTranslated29_never_halt) wTranslated30_never_halt) wTranslated31_never_halt) wTranslated32_never_halt) wTranslated33_never_halt) wTranslated34_never_halt) wTranslated35_never_halt) y (List.mem_filter.1 hy).1

def far23 : List Machine := wSmall1 ++ wSmall2 ++ wSmall3 ++ wSmall4 ++ wSmall5 ++ wSmall6 ++ wSmall7 ++ wSmall8 ++ wSmall9 ++ wSmall10 ++ wSmall11 ++ wSmall12 ++ wSmall13 ++ wSmall14 ++ wSmall15 ++ wSmall16 ++ wSmall17 ++ wSmall18 ++ wSmall19 ++ wSmall20 ++ wSmall21 ++ wSmall22 ++ wSmall23 ++ wSmall24 ++ wSmall25 ++ wSmall26 ++ wSmall27 ++ wSmall28 ++ wSmall29 ++ wSmall30 ++ wSmall31 ++ wSmall32 ++ wSmall33 ++ wSmall34 ++ wSmall35 ++ wSmall36 ++ wSmall37 ++ wSmall38 ++ wSmall39 ++ wSmall40 ++ wSmall41 ++ wSmall42
theorem far23_never_halt : ∀ x ∈ far23, ¬ Halts x :=
  forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (wSmall1_never_halt) wSmall2_never_halt) wSmall3_never_halt) wSmall4_never_halt) wSmall5_never_halt) wSmall6_never_halt) wSmall7_never_halt) wSmall8_never_halt) wSmall9_never_halt) wSmall10_never_halt) wSmall11_never_halt) wSmall12_never_halt) wSmall13_never_halt) wSmall14_never_halt) wSmall15_never_halt) wSmall16_never_halt) wSmall17_never_halt) wSmall18_never_halt) wSmall19_never_halt) wSmall20_never_halt) wSmall21_never_halt) wSmall22_never_halt) wSmall23_never_halt) wSmall24_never_halt) wSmall25_never_halt) wSmall26_never_halt) wSmall27_never_halt) wSmall28_never_halt) wSmall29_never_halt) wSmall30_never_halt) wSmall31_never_halt) wSmall32_never_halt) wSmall33_never_halt) wSmall34_never_halt) wSmall35_never_halt) wSmall36_never_halt) wSmall37_never_halt) wSmall38_never_halt) wSmall39_never_halt) wSmall40_never_halt) wSmall41_never_halt) wSmall42_never_halt

/-- No 3-symbol, 2-state machine halts after more than 37 steps from blank. -/
theorem bb23_steps_le : ∀ M, WF 3 2 M → ∀ k, haltsAt M k = true → k ≤ 37 :=
  bb_of_explore (by decide) (cyc23, tr23, far23) ⟨cyc23_never_halt, tr23_never_halt, far23_never_halt⟩ (by decide +kernel)

def champion23 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }

/-- BB(2,3) = 38: one machine takes 37 steps and halts on its next, and none takes longer. -/
theorem bb23 : (∃ M, WF 3 2 M ∧ haltsAt M 37 = true) ∧ ∀ M, WF 3 2 M → ∀ k, haltsAt M k = true → k ≤ 37 :=
  ⟨⟨champion23, wf_of_rules (by decide), by decide +kernel⟩, bb23_steps_le⟩

-- sabotage: the replay fails without one never-halting machine, and the champion is not halted later
example : (explore 3 2 37 8 (root 3 2) (cyc23, tr23, far23.tail)).isSome = false := by decide +kernel
example : haltsAt champion23 38 = false := by decide +kernel

end FAR
