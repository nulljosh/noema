import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w296 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, true, 0), (0, 2, 2, false, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w296_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 2, 2, 4, 2], [0, 1, 5, 3, 3, 4, 2, 4, 2], [6, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [1, 5, 5, 3, 4, 4, 4, 4, 4], [6, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [4], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 4), (0, 5), (1, 0), (1, 1), (1, 4), (1, 5), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 0), (3, 1), (3, 3), (3, 4), (3, 5), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0), (6, 1), (6, 4), (6, 5), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w296_never_halts : ¬ Halts m_w296 := never_halts m_w296 m_w296_cert (by decide +kernel)

def m_w297 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 0, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w297_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 2, 4, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [2, 4, 2, 4, 4, 4, 4, 4, 4], [3, 4, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w297_never_halts : ¬ Halts m_w297 := never_halts m_w297 m_w297_cert (by decide +kernel)

def m_w298 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w298_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 2, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 2, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 2, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w298_never_halts : ¬ Halts m_w298 := never_halts m_w298 m_w298_cert (by decide +kernel)

def m_w299 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 1), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w299_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 4, 1, 1, 1, 1, 1, 1], [1, 4, 4, 1, 1, 1, 1, 1, 1], [6, 3, 1, 1, 1, 1, 1, 1, 1], [6, 5, 4, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w299_never_halts : ¬ Halts m_w299 := never_halts m_w299 m_w299_cert (by decide +kernel)

def m_w300 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w300_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 2, 5], [0, 1, 1, 4, 3, 3, 3, 3, 3], [5, 2, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 5, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w300_never_halts : ¬ Halts m_w300 := never_halts m_w300 m_w300_cert (by decide +kernel)

def m_w301 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 0)] }
def m_w301_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 2, 2, 2], [0, 1, 1, 4, 3, 3, 3, 3, 3], [2, 2, 2, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 2, 2, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w301_never_halts : ¬ Halts m_w301 := never_halts m_w301 m_w301_cert (by decide +kernel)

def m_w302 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w302_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 2, 2], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 2, 2, 4, 4, 4, 4, 4, 4], [4, 2, 2, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w302_never_halts : ¬ Halts m_w302 := never_halts m_w302 m_w302_cert (by decide +kernel)

def m_w303 : Machine := { S := 3, n := 2, rules := [(0, 0, 0, true, 1), (0, 1, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 0)] }
def m_w303_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 4, 5, 2, 5], [0, 1, 1, 3, 4, 4, 4, 4, 4], [5, 2, 5, 4, 4, 4, 4, 4, 4], [4, 2, 5, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [4], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 4), (1, 0), (1, 1), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (3, 4), (4, 0), (4, 1), (4, 4), (5, 0), (5, 1), (5, 4), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w303_never_halts : ¬ Halts m_w303 := never_halts m_w303 m_w303_cert (by decide +kernel)

def wSmall38 : List Machine := [m_w296, m_w297, m_w298, m_w299, m_w300, m_w301, m_w302, m_w303]
theorem wSmall38_never_halt : ∀ x ∈ wSmall38, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w296_never_halts, List.forall_mem_cons.2 ⟨m_w297_never_halts, List.forall_mem_cons.2 ⟨m_w298_never_halts, List.forall_mem_cons.2 ⟨m_w299_never_halts, List.forall_mem_cons.2 ⟨m_w300_never_halts, List.forall_mem_cons.2 ⟨m_w301_never_halts, List.forall_mem_cons.2 ⟨m_w302_never_halts, List.forall_mem_cons.2 ⟨m_w303_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
