import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w16 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w16_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [2, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w16_never_halts : ¬ Halts m_w16 := never_halts m_w16 m_w16_cert (by decide +kernel)

def m_w17 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w17_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w17_never_halts : ¬ Halts m_w17 := never_halts m_w17 m_w17_cert (by decide +kernel)

def m_w18 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 0, true, 1), (1, 2, 2, true, 1)] }
def m_w18_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [5, 3, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w18_never_halts : ¬ Halts m_w18 := never_halts m_w18 m_w18_cert (by decide +kernel)

def m_w19 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 2, false, 0), (1, 2, 0, true, 0)] }
def m_w19_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 3, 4, 1, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [5, 3, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w19_never_halts : ¬ Halts m_w19 := never_halts m_w19 m_w19_cert (by decide +kernel)

def m_w20 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 2, true, 1)] }
def m_w20_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w20_never_halts : ¬ Halts m_w20 := never_halts m_w20 m_w20_cert (by decide +kernel)

def m_w21 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 2, true, 0)] }
def m_w21_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w21_never_halts : ¬ Halts m_w21 := never_halts m_w21 m_w21_cert (by decide +kernel)

def m_w22 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 2, false, 0)] }
def m_w22_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w22_never_halts : ¬ Halts m_w22 := never_halts m_w22 m_w22_cert (by decide +kernel)

def m_w23 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w23_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 2, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 2, 4, 1, 1, 1, 1, 1, 1], [1, 2, 4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w23_never_halts : ¬ Halts m_w23 := never_halts m_w23 m_w23_cert (by decide +kernel)

def wSmall3 : List Machine := [m_w16, m_w17, m_w18, m_w19, m_w20, m_w21, m_w22, m_w23]
theorem wSmall3_never_halt : ∀ x ∈ wSmall3, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w16_never_halts, List.forall_mem_cons.2 ⟨m_w17_never_halts, List.forall_mem_cons.2 ⟨m_w18_never_halts, List.forall_mem_cons.2 ⟨m_w19_never_halts, List.forall_mem_cons.2 ⟨m_w20_never_halts, List.forall_mem_cons.2 ⟨m_w21_never_halts, List.forall_mem_cons.2 ⟨m_w22_never_halts, List.forall_mem_cons.2 ⟨m_w23_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
