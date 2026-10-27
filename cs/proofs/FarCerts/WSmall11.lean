import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w80 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 0, false, 0)] }
def m_w80_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 4], [0, 0, 1, 5, 5, 6, 7, 4, 2], [7, 4, 2, 4, 4, 4, 4, 4, 4], [2, 7, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [2, 7, 5, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 7), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6), (7, 0), (7, 1), (7, 4), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w80_never_halts : ¬ Halts m_w80 := never_halts m_w80 m_w80_cert (by decide +kernel)

def m_w81 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w81_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w81_never_halts : ¬ Halts m_w81 := never_halts m_w81 m_w81_cert (by decide +kernel)

def m_w82 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w82_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w82_never_halts : ¬ Halts m_w82 := never_halts m_w82 m_w82_cert (by decide +kernel)

def m_w83 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 1, 0, false, 0)] }
def m_w83_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w83_never_halts : ¬ Halts m_w83 := never_halts m_w83 m_w83_cert (by decide +kernel)

def m_w84 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w84_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 8, 1, 1, 1, 1, 1, 1, 1], [7, 5, 1, 1, 1, 1, 1, 1, 1], [1, 8, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 7), (8, 0), (8, 1), (8, 3), (8, 6), (8, 8)],
  z := [0], z2 := [2, 7] }
theorem m_w84_never_halts : ¬ Halts m_w84 := never_halts m_w84 m_w84_cert (by decide +kernel)

def m_w85 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w85_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 3, 1, 1, 1, 1, 1, 1, 1], [7, 5, 1, 1, 1, 1, 1, 1, 1], [1, 3, 1, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w85_never_halts : ¬ Halts m_w85 := never_halts m_w85 m_w85_cert (by decide +kernel)

def m_w86 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w86_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 2, 5], [5, 0, 5, 5, 3, 5, 6, 2, 5], [6, 2, 5, 5, 5, 5, 5, 5, 5], [5, 2, 5, 5, 5, 5, 5, 5, 5], [6, 3, 5, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w86_never_halts : ¬ Halts m_w86 := never_halts m_w86 m_w86_cert (by decide +kernel)

def m_w87 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_w87_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 4, 5], [6, 6, 5, 5, 5, 5, 7, 7, 5], [8, 4, 5, 5, 5, 5, 5, 5, 5], [5, 7, 5, 5, 5, 5, 5, 5, 5], [5, 3, 5, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [1, 1, 1, 9, 3, 3, 5, 5, 5], [8, 3, 5, 5, 5, 5, 5, 5, 5], [8, 5, 5, 5, 5, 5, 5, 5, 5], [8, 7, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, true, true, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], good := [5], reachTape := [0, 1, 5, 6],
  rel := [(0, 0), (0, 1), (0, 5), (0, 6), (1, 0), (1, 1), (1, 5), (1, 6), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (2, 8), (3, 0), (3, 1), (3, 3), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (5, 6), (6, 0), (6, 1), (6, 5), (6, 6), (7, 0), (7, 1), (7, 4), (7, 5), (7, 6), (7, 7), (7, 8), (8, 0), (8, 1), (8, 5), (8, 6), (8, 8), (9, 0), (9, 1), (9, 2), (9, 3), (9, 5), (9, 6), (9, 8), (9, 9)],
  z := [0], z2 := [2, 8] }
theorem m_w87_never_halts : ¬ Halts m_w87 := never_halts m_w87 m_w87_cert (by decide +kernel)

def wSmall11 : List Machine := [m_w80, m_w81, m_w82, m_w83, m_w84, m_w85, m_w86, m_w87]
theorem wSmall11_never_halt : ∀ x ∈ wSmall11, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w80_never_halts, List.forall_mem_cons.2 ⟨m_w81_never_halts, List.forall_mem_cons.2 ⟨m_w82_never_halts, List.forall_mem_cons.2 ⟨m_w83_never_halts, List.forall_mem_cons.2 ⟨m_w84_never_halts, List.forall_mem_cons.2 ⟨m_w85_never_halts, List.forall_mem_cons.2 ⟨m_w86_never_halts, List.forall_mem_cons.2 ⟨m_w87_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
