import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w64 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w64_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 2, 1, 1, 1, 1, 1, 1], [1, 4, 2, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w64_never_halts : ¬ Halts m_w64 := never_halts m_w64 m_w64_cert (by decide +kernel)

def m_w65 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, false, 0), (1, 2, 2, true, 1)] }
def m_w65_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w65_never_halts : ¬ Halts m_w65 := never_halts m_w65 m_w65_cert (by decide +kernel)

def m_w66 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 1), (1, 2, 2, true, 1)] }
def m_w66_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w66_never_halts : ¬ Halts m_w66 := never_halts m_w66 m_w66_cert (by decide +kernel)

def m_w67 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w67_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w67_never_halts : ¬ Halts m_w67 := never_halts m_w67 m_w67_cert (by decide +kernel)

def m_w68 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 2, 1, true, 0)] }
def m_w68_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 0, 1, 5, 5, 3, 2, 4, 3], [2, 4, 3, 4, 4, 4, 4, 4, 4], [5, 2, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [2, 4, 3, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2] }
theorem m_w68_never_halts : ¬ Halts m_w68 := never_halts m_w68 m_w68_cert (by decide +kernel)

def m_w69 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w69_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [7, 6, 1, 1, 1, 1, 1, 1, 1], [7, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w69_never_halts : ¬ Halts m_w69 := never_halts m_w69 m_w69_cert (by decide +kernel)

def m_w70 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w70_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w70_never_halts : ¬ Halts m_w70 := never_halts m_w70 m_w70_cert (by decide +kernel)

def m_w71 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 0), (1, 2, 0, true, 1)] }
def m_w71_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w71_never_halts : ¬ Halts m_w71 := never_halts m_w71 m_w71_cert (by decide +kernel)

def wSmall9 : List Machine := [m_w64, m_w65, m_w66, m_w67, m_w68, m_w69, m_w70, m_w71]
theorem wSmall9_never_halt : ∀ x ∈ wSmall9, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w64_never_halts, List.forall_mem_cons.2 ⟨m_w65_never_halts, List.forall_mem_cons.2 ⟨m_w66_never_halts, List.forall_mem_cons.2 ⟨m_w67_never_halts, List.forall_mem_cons.2 ⟨m_w68_never_halts, List.forall_mem_cons.2 ⟨m_w69_never_halts, List.forall_mem_cons.2 ⟨m_w70_never_halts, List.forall_mem_cons.2 ⟨m_w71_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
