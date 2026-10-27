import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w40 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 0, false, 0), (1, 2, 2, true, 1)] }
def m_w40_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [4, 1, 3, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 4, 6] }
theorem m_w40_never_halts : ¬ Halts m_w40 := never_halts m_w40 m_w40_cert (by decide +kernel)

def m_w41 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 2, true, 0)] }
def m_w41_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 3, 2, 2, 4], [1, 3, 3, 3, 3, 3, 3, 3, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 3), (4, 0), (4, 3), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w41_never_halts : ¬ Halts m_w41 := never_halts m_w41 m_w41_cert (by decide +kernel)

def m_w42 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 2, true, 0)] }
def m_w42_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 3, 2, 2, 4], [1, 3, 3, 3, 3, 3, 3, 3, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 3), (4, 0), (4, 3), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w42_never_halts : ¬ Halts m_w42 := never_halts m_w42 m_w42_cert (by decide +kernel)

def m_w43 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 1), (1, 2, 2, false, 0)] }
def m_w43_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 4, 4, 3], [0, 0, 0, 5, 5, 5, 6, 4, 3], [6, 4, 3, 4, 4, 4, 4, 4, 4], [6, 6, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 3, 4, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w43_never_halts : ¬ Halts m_w43 := never_halts m_w43 m_w43_cert (by decide +kernel)

def m_w44 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 2, true, 1), (1, 2, 2, false, 0)] }
def m_w44_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w44_never_halts : ¬ Halts m_w44 := never_halts m_w44 m_w44_cert (by decide +kernel)

def m_w45 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w45_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w45_never_halts : ¬ Halts m_w45 := never_halts m_w45 m_w45_cert (by decide +kernel)

def m_w46 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 1), (1, 2, 1, true, 0)] }
def m_w46_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 2, 3, 3, 4], [0, 0, 0, 5, 5, 5, 6, 3, 2], [6, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [6, 6, 2, 3, 3, 3, 3, 3, 3], [3, 3, 2, 3, 3, 3, 3, 3, 3], [6, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w46_never_halts : ¬ Halts m_w46 := never_halts m_w46 m_w46_cert (by decide +kernel)

def m_w47 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 1, true, 0)] }
def m_w47_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 3, 3, 4], [1, 1, 3, 3, 3, 3, 2, 2, 3], [5, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 3, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w47_never_halts : ¬ Halts m_w47 := never_halts m_w47 m_w47_cert (by decide +kernel)

def wSmall6 : List Machine := [m_w40, m_w41, m_w42, m_w43, m_w44, m_w45, m_w46, m_w47]
theorem wSmall6_never_halt : ∀ x ∈ wSmall6, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w40_never_halts, List.forall_mem_cons.2 ⟨m_w41_never_halts, List.forall_mem_cons.2 ⟨m_w42_never_halts, List.forall_mem_cons.2 ⟨m_w43_never_halts, List.forall_mem_cons.2 ⟨m_w44_never_halts, List.forall_mem_cons.2 ⟨m_w45_never_halts, List.forall_mem_cons.2 ⟨m_w46_never_halts, List.forall_mem_cons.2 ⟨m_w47_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
