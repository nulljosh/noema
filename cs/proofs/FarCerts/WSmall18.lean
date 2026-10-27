import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w136 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 1, true, 0)] }
def m_w136_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 2, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [1, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w136_never_halts : ¬ Halts m_w136 := never_halts m_w136 m_w136_cert (by decide +kernel)

def m_w137 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, true, 1)] }
def m_w137_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w137_never_halts : ¬ Halts m_w137 := never_halts m_w137 m_w137_cert (by decide +kernel)

def m_w138 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 0, false, 0), (1, 1, 0, false, 1), (1, 2, 2, true, 0)] }
def m_w138_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [4, 3, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 4] }
theorem m_w138_never_halts : ¬ Halts m_w138 := never_halts m_w138 m_w138_cert (by decide +kernel)

def m_w139 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 0), (1, 2, 0, true, 1)] }
def m_w139_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 3, 4, 3], [1, 3, 1, 3, 3, 3, 2, 3, 2], [5, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w139_never_halts : ¬ Halts m_w139 := never_halts m_w139 m_w139_cert (by decide +kernel)

def m_w140 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 0), (1, 2, 0, false, 1)] }
def m_w140_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 3, 4, 3], [1, 3, 1, 3, 3, 3, 2, 3, 2], [2, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [2, 3, 2, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w140_never_halts : ¬ Halts m_w140 := never_halts m_w140 m_w140_cert (by decide +kernel)

def m_w141 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 2, false, 1), (1, 1, 2, true, 0)] }
def m_w141_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 6, 7], [1, 0, 1, 8, 6, 6, 7, 9, 7], [10, 4, 7, 7, 7, 7, 7, 7, 7], [7, 4, 7, 7, 7, 7, 7, 7, 7], [7, 6, 7, 7, 7, 7, 7, 7, 7], [10, 7, 5, 7, 7, 7, 7, 7, 7], [10, 6, 5, 7, 7, 7, 7, 7, 7], [7, 7, 7, 7, 7, 7, 7, 7, 7], [10, 6, 7, 7, 7, 7, 7, 7, 7], [7, 7, 5, 7, 7, 7, 7, 7, 7], [10, 7, 7, 7, 7, 7, 7, 7, 7]],
  acc := [true, true, false, true, true, false, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], good := [7], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 7), (1, 0), (1, 1), (1, 7), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (2, 10), (3, 0), (3, 1), (3, 3), (3, 7), (4, 0), (4, 1), (4, 3), (4, 4), (4, 7), (5, 0), (5, 1), (5, 5), (5, 7), (5, 9), (5, 10), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (6, 10), (7, 0), (7, 1), (7, 7), (8, 0), (8, 1), (8, 2), (8, 3), (8, 4), (8, 7), (8, 8), (8, 10), (9, 0), (9, 1), (9, 7), (9, 9), (10, 0), (10, 1), (10, 7), (10, 10)],
  z := [0], z2 := [2, 10] }
theorem m_w141_never_halts : ¬ Halts m_w141 := never_halts m_w141 m_w141_cert (by decide +kernel)

def m_w142 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 0, true, 1), (1, 0, 2, false, 1), (1, 1, 2, true, 0), (1, 2, 0, false, 0)] }
def m_w142_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 6, 5], [1, 3, 3, 3, 3, 3, 5, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [5, 3, 5, 3, 3, 3, 3, 3, 3], [7, 3, 5, 3, 3, 3, 3, 3, 3], [3, 3, 5, 3, 3, 3, 3, 3, 3], [7, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 3), (7, 7)],
  z := [0], z2 := [2, 5, 7] }
theorem m_w142_never_halts : ¬ Halts m_w142 := never_halts m_w142 m_w142_cert (by decide +kernel)

def m_w143 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 2, 0, false, 1), (1, 0, 2, false, 1), (1, 1, 2, false, 0), (1, 2, 2, true, 0)] }
def m_w143_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 4, 5, 4], [1, 3, 0, 3, 3, 6, 2, 3, 2], [2, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [2, 3, 4, 3, 3, 3, 3, 3, 3], [6, 3, 2, 3, 3, 3, 3, 3, 3], [3, 3, 5, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [3], reachTape := [0, 1, 3],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (6, 0), (6, 1), (6, 3), (6, 6)],
  z := [0], z2 := [2] }
theorem m_w143_never_halts : ¬ Halts m_w143 := never_halts m_w143 m_w143_cert (by decide +kernel)

def wSmall18 : List Machine := [m_w136, m_w137, m_w138, m_w139, m_w140, m_w141, m_w142, m_w143]
theorem wSmall18_never_halt : ∀ x ∈ wSmall18, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w136_never_halts, List.forall_mem_cons.2 ⟨m_w137_never_halts, List.forall_mem_cons.2 ⟨m_w138_never_halts, List.forall_mem_cons.2 ⟨m_w139_never_halts, List.forall_mem_cons.2 ⟨m_w140_never_halts, List.forall_mem_cons.2 ⟨m_w141_never_halts, List.forall_mem_cons.2 ⟨m_w142_never_halts, List.forall_mem_cons.2 ⟨m_w143_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
