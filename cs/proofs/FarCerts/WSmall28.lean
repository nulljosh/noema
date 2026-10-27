import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w216 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, false, 0), (1, 2, 0, true, 1)] }
def m_w216_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w216_never_halts : ¬ Halts m_w216 := never_halts m_w216 m_w216_cert (by decide +kernel)

def m_w217 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1)] }
def m_w217_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w217_never_halts : ¬ Halts m_w217 := never_halts m_w217 m_w217_cert (by decide +kernel)

def m_w218 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 0, true, 1)] }
def m_w218_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 3, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w218_never_halts : ¬ Halts m_w218 := never_halts m_w218 m_w218_cert (by decide +kernel)

def m_w219 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 1), (0, 2, 1, true, 1), (1, 0, 1, false, 0), (1, 1, 0, true, 0)] }
def m_w219_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 3, 4, 4, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 3, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w219_never_halts : ¬ Halts m_w219 := never_halts m_w219 m_w219_cert (by decide +kernel)

def m_w220 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 1, false, 0), (1, 2, 2, true, 0)] }
def m_w220_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 3, 4, 4, 4], [0, 1, 0, 2, 3, 3, 5, 4, 3], [5, 4, 3, 4, 4, 4, 4, 4, 4], [5, 5, 3, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 4), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w220_never_halts : ¬ Halts m_w220 := never_halts m_w220 m_w220_cert (by decide +kernel)

def m_w221 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 0, false, 0), (1, 0, 1, false, 0), (1, 2, 2, true, 0)] }
def m_w221_cert : Cert := {
  delta := [[0, 1, 1, 2, 3, 4, 5, 5, 5], [0, 1, 0, 6, 4, 6, 3, 5, 3], [3, 5, 3, 5, 5, 5, 5, 5, 5], [2, 3, 4, 5, 5, 5, 5, 5, 5], [6, 3, 4, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [4, 5, 3, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, false, true, true, true],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [5], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6)],
  z := [0], z2 := [2, 3] }
theorem m_w221_never_halts : ¬ Halts m_w221 := never_halts m_w221 m_w221_cert (by decide +kernel)

def m_w222 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w222_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 2, 1, 1, 1, 1, 1, 1], [1, 4, 2, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w222_never_halts : ¬ Halts m_w222 := never_halts m_w222 m_w222_cert (by decide +kernel)

def m_w223 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 1, true, 1), (1, 2, 1, true, 1)] }
def m_w223_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w223_never_halts : ¬ Halts m_w223 := never_halts m_w223 m_w223_cert (by decide +kernel)

def wSmall28 : List Machine := [m_w216, m_w217, m_w218, m_w219, m_w220, m_w221, m_w222, m_w223]
theorem wSmall28_never_halt : ∀ x ∈ wSmall28, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w216_never_halts, List.forall_mem_cons.2 ⟨m_w217_never_halts, List.forall_mem_cons.2 ⟨m_w218_never_halts, List.forall_mem_cons.2 ⟨m_w219_never_halts, List.forall_mem_cons.2 ⟨m_w220_never_halts, List.forall_mem_cons.2 ⟨m_w221_never_halts, List.forall_mem_cons.2 ⟨m_w222_never_halts, List.forall_mem_cons.2 ⟨m_w223_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
