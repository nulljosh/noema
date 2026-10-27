import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w104 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 0), (1, 2, 1, false, 0)] }
def m_w104_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w104_never_halts : ¬ Halts m_w104 := never_halts m_w104 m_w104_cert (by decide +kernel)

def m_w105 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_w105_cert : Cert := {
  delta := [[0, 1, 2, 3, 1, 4, 5, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 7, 7, 1], [8, 5, 1, 1, 1, 1, 1, 1, 1], [1, 7, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 2, 9, 1, 4, 1, 1, 1], [9, 1, 1, 1, 1, 1, 1, 1, 1], [8, 1, 1, 1, 1, 1, 1, 1, 1], [8, 7, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, true, false, true, true, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], good := [1], reachTape := [0, 1, 2, 6],
  rel := [(0, 0), (0, 1), (0, 2), (0, 6), (1, 0), (1, 1), (1, 2), (1, 6), (2, 0), (2, 1), (2, 2), (2, 6), (3, 0), (3, 1), (3, 2), (3, 3), (3, 6), (3, 8), (4, 0), (4, 1), (4, 2), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 5), (5, 6), (6, 0), (6, 1), (6, 2), (6, 6), (7, 0), (7, 1), (7, 2), (7, 5), (7, 6), (7, 7), (7, 8), (8, 0), (8, 1), (8, 2), (8, 6), (8, 8), (9, 0), (9, 1), (9, 2), (9, 3), (9, 4), (9, 6), (9, 8), (9, 9)],
  z := [0], z2 := [3, 8] }
theorem m_w105_never_halts : ¬ Halts m_w105 := never_halts m_w105 m_w105_cert (by decide +kernel)

def m_w106 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 0, false, 1), (1, 2, 2, false, 0)] }
def m_w106_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 4], [0, 0, 0, 3, 3, 3, 6, 5, 4], [6, 5, 4, 5, 5, 5, 5, 5, 5], [5, 5, 4, 5, 5, 5, 5, 5, 5], [6, 5, 4, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [6, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 5), (4, 0), (4, 1), (4, 3), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w106_never_halts : ¬ Halts m_w106 := never_halts m_w106 m_w106_cert (by decide +kernel)

def m_w107 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 1), (1, 1, 2, true, 1), (1, 2, 2, false, 0)] }
def m_w107_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w107_never_halts : ¬ Halts m_w107 := never_halts m_w107 m_w107_cert (by decide +kernel)

def m_w108 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 1), (1, 1, 0, true, 1), (1, 2, 2, false, 0)] }
def m_w108_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 5, 1, 1, 1, 1, 1, 1], [1, 3, 5, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w108_never_halts : ¬ Halts m_w108 := never_halts m_w108 m_w108_cert (by decide +kernel)

def m_w109 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 1), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w109_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1], [4, 5, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 4] }
theorem m_w109_never_halts : ¬ Halts m_w109 := never_halts m_w109 m_w109_cert (by decide +kernel)

def m_w110 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 0, false, 1), (1, 1, 2, true, 0), (1, 2, 1, false, 0)] }
def m_w110_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 2, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w110_never_halts : ¬ Halts m_w110 := never_halts m_w110 m_w110_cert (by decide +kernel)

def m_w111 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 1), (1, 0, 0, false, 1), (1, 1, 1, true, 0), (1, 2, 1, false, 0)] }
def m_w111_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 5, 6], [1, 0, 4, 4, 3, 4, 2, 6, 4], [2, 6, 4, 4, 4, 4, 4, 4, 4], [4, 6, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [7, 4, 4, 4, 4, 4, 4, 4, 4], [2, 4, 4, 4, 4, 4, 4, 4, 4], [7, 6, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [4], reachTape := [0, 1, 4],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 5), (6, 6), (7, 0), (7, 1), (7, 3), (7, 4), (7, 5), (7, 7)],
  z := [0], z2 := [2] }
theorem m_w111_never_halts : ¬ Halts m_w111 := never_halts m_w111 m_w111_cert (by decide +kernel)

def wSmall14 : List Machine := [m_w104, m_w105, m_w106, m_w107, m_w108, m_w109, m_w110, m_w111]
theorem wSmall14_never_halt : ∀ x ∈ wSmall14, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w104_never_halts, List.forall_mem_cons.2 ⟨m_w105_never_halts, List.forall_mem_cons.2 ⟨m_w106_never_halts, List.forall_mem_cons.2 ⟨m_w107_never_halts, List.forall_mem_cons.2 ⟨m_w108_never_halts, List.forall_mem_cons.2 ⟨m_w109_never_halts, List.forall_mem_cons.2 ⟨m_w110_never_halts, List.forall_mem_cons.2 ⟨m_w111_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
