import FarCerts.Explore
import FarCerts.Cycles1
import FarCerts.Cycles2
import FarCerts.Cycles3
import FarCerts.Cycles4
import FarCerts.Cycles5
import FarCerts.Translated1
import FarCerts.Translated2
import FarCerts.Translated3
import FarCerts.Translated4
import FarCerts.Translated5
import FarCerts.Translated6
import FarCerts.Translated7
import FarCerts.Translated8
import FarCerts.Translated9
import FarCerts.Translated10
import FarCerts.Translated11
import FarCerts.Translated12
import FarCerts.Translated13
import FarCerts.Translated14
import FarCerts.Translated15
import FarCerts.Translated16
import FarCerts.Translated17
import FarCerts.Translated18
import FarCerts.Translated19
import FarCerts.Translated20
import FarCerts.Translated21
import FarCerts.Translated22
import FarCerts.Translated23
import FarCerts.Translated24
import FarCerts.Translated25
import FarCerts.Translated26
import FarCerts.Translated27
import FarCerts.Translated28
import FarCerts.Translated29
import FarCerts.Translated30
import FarCerts.Translated31

set_option maxRecDepth 100000

namespace FAR

def cyc2 : List Machine := ((cycles1 ++ cycles2 ++ cycles3 ++ cycles4 ++ cycles5).filter (fun x => x.1.n == 2 && x.1.S == 2)).map (·.1)
theorem cyc2_never_halt : ∀ x ∈ cyc2, ¬ Halts x := by
  intro x hx
  unfold cyc2 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (forall_append (cycles1_never_halt) cycles2_never_halt) cycles3_never_halt) cycles4_never_halt) cycles5_never_halt) y (List.mem_filter.1 hy).1

def tr2 : List Machine := ((translated1 ++ translated2 ++ translated3 ++ translated4 ++ translated5 ++ translated6 ++ translated7 ++ translated8 ++ translated9 ++ translated10 ++ translated11 ++ translated12 ++ translated13 ++ translated14 ++ translated15 ++ translated16 ++ translated17 ++ translated18 ++ translated19 ++ translated20 ++ translated21 ++ translated22 ++ translated23 ++ translated24 ++ translated25 ++ translated26 ++ translated27 ++ translated28 ++ translated29 ++ translated30 ++ translated31).filter (fun x => x.1.n == 2 && x.1.S == 2)).map (·.1)
theorem tr2_never_halt : ∀ x ∈ tr2, ¬ Halts x := by
  intro x hx
  unfold tr2 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (translated1_never_halt) translated2_never_halt) translated3_never_halt) translated4_never_halt) translated5_never_halt) translated6_never_halt) translated7_never_halt) translated8_never_halt) translated9_never_halt) translated10_never_halt) translated11_never_halt) translated12_never_halt) translated13_never_halt) translated14_never_halt) translated15_never_halt) translated16_never_halt) translated17_never_halt) translated18_never_halt) translated19_never_halt) translated20_never_halt) translated21_never_halt) translated22_never_halt) translated23_never_halt) translated24_never_halt) translated25_never_halt) translated26_never_halt) translated27_never_halt) translated28_never_halt) translated29_never_halt) translated30_never_halt) translated31_never_halt) y (List.mem_filter.1 hy).1

/-- No 2-symbol, 2-state machine halts after more than 5 steps from blank. -/
theorem bb2_steps_le : ∀ M, WF 2 2 M → ∀ k, haltsAt M k = true → k ≤ 5 :=
  bb_of_explore (by decide) (cyc2, tr2, []) ⟨cyc2_never_halt, tr2_never_halt, fun _ h => nomatch h⟩ (by decide +kernel)

def champion2 : Machine := { S := 2, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 1, false, 1), (1, 0, 1, false, 0)] }

/-- BB(2) = 6: one machine takes 5 steps and halts on its next, and none takes longer. -/
theorem bb2 : (∃ M, WF 2 2 M ∧ haltsAt M 5 = true) ∧ ∀ M, WF 2 2 M → ∀ k, haltsAt M k = true → k ≤ 5 :=
  ⟨⟨champion2, wf_of_rules (by decide), by decide +kernel⟩, bb2_steps_le⟩

-- sabotage: the replay fails with one step fewer, and the champion is not halted later
example : (explore 2 2 4 6 (root 2 2) (cyc2, tr2, [])).isSome = false := by decide +kernel
example : haltsAt champion2 6 = false := by decide +kernel

end FAR
