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
import FarCerts.Small1
import FarCerts.Small2
import FarCerts.Small3
import FarCerts.Small4
import FarCerts.Small5
import FarCerts.Small6
import FarCerts.Small7
import FarCerts.Small8
import FarCerts.Small9
import FarCerts.Small10
import FarCerts.Small11
import FarCerts.Small12

set_option maxRecDepth 100000

namespace FAR

def cyc3 : List Machine := ((cycles1 ++ cycles2 ++ cycles3 ++ cycles4 ++ cycles5).filter (·.1.n == 3)).map (·.1)
theorem cyc3_never_halt : ∀ x ∈ cyc3, ¬ Halts x := by
  intro x hx
  unfold cyc3 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (forall_append (cycles1_never_halt) cycles2_never_halt) cycles3_never_halt) cycles4_never_halt) cycles5_never_halt) y (List.mem_filter.1 hy).1

def tr3 : List Machine := ((translated1 ++ translated2 ++ translated3 ++ translated4 ++ translated5 ++ translated6 ++ translated7 ++ translated8 ++ translated9 ++ translated10 ++ translated11 ++ translated12 ++ translated13 ++ translated14 ++ translated15 ++ translated16 ++ translated17 ++ translated18 ++ translated19 ++ translated20 ++ translated21 ++ translated22 ++ translated23 ++ translated24 ++ translated25 ++ translated26 ++ translated27 ++ translated28 ++ translated29 ++ translated30 ++ translated31).filter (·.1.n == 3)).map (·.1)
theorem tr3_never_halt : ∀ x ∈ tr3, ¬ Halts x := by
  intro x hx
  unfold tr3 at hx
  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx
  exact (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (forall_append (translated1_never_halt) translated2_never_halt) translated3_never_halt) translated4_never_halt) translated5_never_halt) translated6_never_halt) translated7_never_halt) translated8_never_halt) translated9_never_halt) translated10_never_halt) translated11_never_halt) translated12_never_halt) translated13_never_halt) translated14_never_halt) translated15_never_halt) translated16_never_halt) translated17_never_halt) translated18_never_halt) translated19_never_halt) translated20_never_halt) translated21_never_halt) translated22_never_halt) translated23_never_halt) translated24_never_halt) translated25_never_halt) translated26_never_halt) translated27_never_halt) translated28_never_halt) translated29_never_halt) translated30_never_halt) translated31_never_halt) y (List.mem_filter.1 hy).1

def far3 : List Machine := [m_s3_0, m_s3_1, m_s3_2, m_s3_3, m_s3_4, m_s3_5, m_s3_6, m_s3_7, m_s3_8, m_s3_9, m_s3_10, m_s3_11, m_s3_12, m_s3_13, m_s3_14, m_s3_15, m_s3_16, m_s3_17, m_s3_18, m_s3_19, m_s3_20, m_s3_21, m_s3_22, m_s3_23, m_s3_24, m_s3_25, m_s3_26, m_s3_27, m_s3_28, m_s3_29, m_s3_30, m_s3_31, m_s3_32, m_s3_33, m_s3_34, m_s3_35, m_s3_36, m_s3_37, m_s3_38, m_s3_39, m_s3_40, m_s3_41, m_s3_42, m_s3_43, m_s3_44, m_s3_45, m_s3_46, m_s3_47, m_s3_48, m_s3_49, m_s3_50, m_s3_51, m_s3_52, m_s3_53, m_s3_54, m_s3_55, m_s3_56, m_s3_57, m_s3_58, m_s3_59, m_s3_60, m_s3_61, m_s3_62, m_s3_63, m_s3_64, m_s3_65, m_s3_66, m_s3_67, m_s3_68, m_s3_69, m_s3_70, m_s3_71, m_s3_72, m_s3_73, m_s3_74, m_s3_75, m_s3_76, m_s3_77, m_s3_78, m_s3_79, m_s3_80, m_s3_81, m_s3_82, m_s3_83, m_s3_84, m_s3_85, m_s3_86, m_s3_87, m_s3_88, m_s3_89, m_s3_90, m_s3_91]
theorem far3_never_halt : ∀ x ∈ far3, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_s3_0_never_halts, List.forall_mem_cons.2 ⟨m_s3_1_never_halts, List.forall_mem_cons.2 ⟨m_s3_2_never_halts, List.forall_mem_cons.2 ⟨m_s3_3_never_halts, List.forall_mem_cons.2 ⟨m_s3_4_never_halts, List.forall_mem_cons.2 ⟨m_s3_5_never_halts, List.forall_mem_cons.2 ⟨m_s3_6_never_halts, List.forall_mem_cons.2 ⟨m_s3_7_never_halts, List.forall_mem_cons.2 ⟨m_s3_8_never_halts, List.forall_mem_cons.2 ⟨m_s3_9_never_halts, List.forall_mem_cons.2 ⟨m_s3_10_never_halts, List.forall_mem_cons.2 ⟨m_s3_11_never_halts, List.forall_mem_cons.2 ⟨m_s3_12_never_halts, List.forall_mem_cons.2 ⟨m_s3_13_never_halts, List.forall_mem_cons.2 ⟨m_s3_14_never_halts, List.forall_mem_cons.2 ⟨m_s3_15_never_halts, List.forall_mem_cons.2 ⟨m_s3_16_never_halts, List.forall_mem_cons.2 ⟨m_s3_17_never_halts, List.forall_mem_cons.2 ⟨m_s3_18_never_halts, List.forall_mem_cons.2 ⟨m_s3_19_never_halts, List.forall_mem_cons.2 ⟨m_s3_20_never_halts, List.forall_mem_cons.2 ⟨m_s3_21_never_halts, List.forall_mem_cons.2 ⟨m_s3_22_never_halts, List.forall_mem_cons.2 ⟨m_s3_23_never_halts, List.forall_mem_cons.2 ⟨m_s3_24_never_halts, List.forall_mem_cons.2 ⟨m_s3_25_never_halts, List.forall_mem_cons.2 ⟨m_s3_26_never_halts, List.forall_mem_cons.2 ⟨m_s3_27_never_halts, List.forall_mem_cons.2 ⟨m_s3_28_never_halts, List.forall_mem_cons.2 ⟨m_s3_29_never_halts, List.forall_mem_cons.2 ⟨m_s3_30_never_halts, List.forall_mem_cons.2 ⟨m_s3_31_never_halts, List.forall_mem_cons.2 ⟨m_s3_32_never_halts, List.forall_mem_cons.2 ⟨m_s3_33_never_halts, List.forall_mem_cons.2 ⟨m_s3_34_never_halts, List.forall_mem_cons.2 ⟨m_s3_35_never_halts, List.forall_mem_cons.2 ⟨m_s3_36_never_halts, List.forall_mem_cons.2 ⟨m_s3_37_never_halts, List.forall_mem_cons.2 ⟨m_s3_38_never_halts, List.forall_mem_cons.2 ⟨m_s3_39_never_halts, List.forall_mem_cons.2 ⟨m_s3_40_never_halts, List.forall_mem_cons.2 ⟨m_s3_41_never_halts, List.forall_mem_cons.2 ⟨m_s3_42_never_halts, List.forall_mem_cons.2 ⟨m_s3_43_never_halts, List.forall_mem_cons.2 ⟨m_s3_44_never_halts, List.forall_mem_cons.2 ⟨m_s3_45_never_halts, List.forall_mem_cons.2 ⟨m_s3_46_never_halts, List.forall_mem_cons.2 ⟨m_s3_47_never_halts, List.forall_mem_cons.2 ⟨m_s3_48_never_halts, List.forall_mem_cons.2 ⟨m_s3_49_never_halts, List.forall_mem_cons.2 ⟨m_s3_50_never_halts, List.forall_mem_cons.2 ⟨m_s3_51_never_halts, List.forall_mem_cons.2 ⟨m_s3_52_never_halts, List.forall_mem_cons.2 ⟨m_s3_53_never_halts, List.forall_mem_cons.2 ⟨m_s3_54_never_halts, List.forall_mem_cons.2 ⟨m_s3_55_never_halts, List.forall_mem_cons.2 ⟨m_s3_56_never_halts, List.forall_mem_cons.2 ⟨m_s3_57_never_halts, List.forall_mem_cons.2 ⟨m_s3_58_never_halts, List.forall_mem_cons.2 ⟨m_s3_59_never_halts, List.forall_mem_cons.2 ⟨m_s3_60_never_halts, List.forall_mem_cons.2 ⟨m_s3_61_never_halts, List.forall_mem_cons.2 ⟨m_s3_62_never_halts, List.forall_mem_cons.2 ⟨m_s3_63_never_halts, List.forall_mem_cons.2 ⟨m_s3_64_never_halts, List.forall_mem_cons.2 ⟨m_s3_65_never_halts, List.forall_mem_cons.2 ⟨m_s3_66_never_halts, List.forall_mem_cons.2 ⟨m_s3_67_never_halts, List.forall_mem_cons.2 ⟨m_s3_68_never_halts, List.forall_mem_cons.2 ⟨m_s3_69_never_halts, List.forall_mem_cons.2 ⟨m_s3_70_never_halts, List.forall_mem_cons.2 ⟨m_s3_71_never_halts, List.forall_mem_cons.2 ⟨m_s3_72_never_halts, List.forall_mem_cons.2 ⟨m_s3_73_never_halts, List.forall_mem_cons.2 ⟨m_s3_74_never_halts, List.forall_mem_cons.2 ⟨m_s3_75_never_halts, List.forall_mem_cons.2 ⟨m_s3_76_never_halts, List.forall_mem_cons.2 ⟨m_s3_77_never_halts, List.forall_mem_cons.2 ⟨m_s3_78_never_halts, List.forall_mem_cons.2 ⟨m_s3_79_never_halts, List.forall_mem_cons.2 ⟨m_s3_80_never_halts, List.forall_mem_cons.2 ⟨m_s3_81_never_halts, List.forall_mem_cons.2 ⟨m_s3_82_never_halts, List.forall_mem_cons.2 ⟨m_s3_83_never_halts, List.forall_mem_cons.2 ⟨m_s3_84_never_halts, List.forall_mem_cons.2 ⟨m_s3_85_never_halts, List.forall_mem_cons.2 ⟨m_s3_86_never_halts, List.forall_mem_cons.2 ⟨m_s3_87_never_halts, List.forall_mem_cons.2 ⟨m_s3_88_never_halts, List.forall_mem_cons.2 ⟨m_s3_89_never_halts, List.forall_mem_cons.2 ⟨m_s3_90_never_halts, List.forall_mem_cons.2 ⟨m_s3_91_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩⟩

/-- No 2-symbol, 3-state machine halts after more than 20 steps from blank. -/
theorem bb3_steps_le : ∀ M, WF M → ∀ k, haltsAt M k = true → k ≤ 20 :=
  bb3_of_explore (cyc3, tr3, far3) ⟨cyc3_never_halt, tr3_never_halt, far3_never_halt⟩ (by decide +kernel)

def champion : Machine := { S := 2, n := 3, rules := [(0, 0, 1, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 2), (2, 0, 1, false, 2), (2, 1, 1, false, 0)] }

/-- BB(3) = 21: one machine takes 20 steps and halts on its 21st, and none takes longer. -/
theorem bb3 : (∃ M, WF M ∧ haltsAt M 20 = true) ∧ ∀ M, WF M → ∀ k, haltsAt M k = true → k ≤ 20 :=
  ⟨⟨champion, wf_of_rules (by decide), by decide +kernel⟩, bb3_steps_le⟩

-- sabotage: the replay fails without one never-halting machine, and the champion is not halted at 21
example : (explore 8 root (cyc3, tr3, far3.tail)).isSome = false := by decide +kernel
example : haltsAt champion 21 = false := by decide +kernel

end FAR
