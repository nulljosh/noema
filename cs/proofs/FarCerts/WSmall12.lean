import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w88 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w88_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 2, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 2, 1, 1, 1, 1, 1, 1, 1], [1, 2, 1, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w88_never_halts : ¬ Halts m_w88 := never_halts m_w88 m_w88_cert (by decide +kernel)

def m_w89 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 0)] }
def m_w89_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w89_never_halts : ¬ Halts m_w89 := never_halts m_w89 m_w89_cert (by decide +kernel)

def m_w90 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 0)] }
def m_w90_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w90_never_halts : ¬ Halts m_w90 := never_halts m_w90 m_w90_cert (by decide +kernel)

def m_w91 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w91_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [1, 5, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [6, 5, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w91_never_halts : ¬ Halts m_w91 := never_halts m_w91 m_w91_cert (by decide +kernel)

def m_w92 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w92_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w92_never_halts : ¬ Halts m_w92 := never_halts m_w92 m_w92_cert (by decide +kernel)

def m_w93 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w93_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w93_never_halts : ¬ Halts m_w93 := never_halts m_w93 m_w93_cert (by decide +kernel)

def m_w94 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, true, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 0)] }
def m_w94_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w94_never_halts : ¬ Halts m_w94 := never_halts m_w94 m_w94_cert (by decide +kernel)

def m_w95 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 0)] }
def m_w95_cert : Cert := {
  delta := [[0, 0, 0, 1, 1, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w95_never_halts : ¬ Halts m_w95 := never_halts m_w95 m_w95_cert (by decide +kernel)

def wSmall12 : List Machine := [m_w88, m_w89, m_w90, m_w91, m_w92, m_w93, m_w94, m_w95]
theorem wSmall12_never_halt : ∀ x ∈ wSmall12, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w88_never_halts, List.forall_mem_cons.2 ⟨m_w89_never_halts, List.forall_mem_cons.2 ⟨m_w90_never_halts, List.forall_mem_cons.2 ⟨m_w91_never_halts, List.forall_mem_cons.2 ⟨m_w92_never_halts, List.forall_mem_cons.2 ⟨m_w93_never_halts, List.forall_mem_cons.2 ⟨m_w94_never_halts, List.forall_mem_cons.2 ⟨m_w95_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
