import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w176 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 0)] }
def m_w176_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w176_never_halts : ¬ Halts m_w176 := never_halts m_w176 m_w176_cert (by decide +kernel)

def m_w177 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 0)] }
def m_w177_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [1, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w177_never_halts : ¬ Halts m_w177 := never_halts m_w177 m_w177_cert (by decide +kernel)

def m_w178 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w178_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 1, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 1, 2, 1, 1, 1, 1, 1, 1], [1, 1, 2, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w178_never_halts : ¬ Halts m_w178 := never_halts m_w178 m_w178_cert (by decide +kernel)

def m_w179 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w179_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w179_never_halts : ¬ Halts m_w179 := never_halts m_w179 m_w179_cert (by decide +kernel)

def m_w180 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w180_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w180_never_halts : ¬ Halts m_w180 := never_halts m_w180 m_w180_cert (by decide +kernel)

def m_w181 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w181_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [1, 1, 5, 1, 1, 1, 1, 1, 1], [6, 5, 1, 1, 1, 1, 1, 1, 1], [6, 5, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w181_never_halts : ¬ Halts m_w181 := never_halts m_w181 m_w181_cert (by decide +kernel)

def m_w182 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (0, 2, 1, true, 0), (1, 0, 2, false, 0), (1, 2, 0, true, 0)] }
def m_w182_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w182_never_halts : ¬ Halts m_w182 := never_halts m_w182 m_w182_cert (by decide +kernel)

def m_w183 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 2, false, 0), (1, 0, 2, false, 0), (1, 1, 1, true, 0), (1, 2, 0, false, 1)] }
def m_w183_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 2, 4, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 1, 2, 1, 1, 1, 1, 1, 1], [1, 1, 2, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, true],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2] }
theorem m_w183_never_halts : ¬ Halts m_w183 := never_halts m_w183 m_w183_cert (by decide +kernel)

def wSmall23 : List Machine := [m_w176, m_w177, m_w178, m_w179, m_w180, m_w181, m_w182, m_w183]
theorem wSmall23_never_halt : ∀ x ∈ wSmall23, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w176_never_halts, List.forall_mem_cons.2 ⟨m_w177_never_halts, List.forall_mem_cons.2 ⟨m_w178_never_halts, List.forall_mem_cons.2 ⟨m_w179_never_halts, List.forall_mem_cons.2 ⟨m_w180_never_halts, List.forall_mem_cons.2 ⟨m_w181_never_halts, List.forall_mem_cons.2 ⟨m_w182_never_halts, List.forall_mem_cons.2 ⟨m_w183_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
