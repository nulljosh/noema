import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w32 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 1, false, 0), (1, 0, 2, false, 0), (1, 1, 0, false, 1), (1, 2, 2, true, 0)] }
def m_w32_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 3, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 3, 4, 1, 1, 1, 1, 1, 1], [1, 3, 4, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w32_never_halts : ¬ Halts m_w32 := never_halts m_w32 m_w32_cert (by decide +kernel)

def m_w33 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 2, false, 0), (0, 2, 0, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w33_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w33_never_halts : ¬ Halts m_w33 := never_halts m_w33 m_w33_cert (by decide +kernel)

def m_w34 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 0, true, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w34_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [2, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w34_never_halts : ¬ Halts m_w34 := never_halts m_w34 m_w34_cert (by decide +kernel)

def m_w35 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w35_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 5, 6, 5], [3, 3, 7, 2, 3, 4, 3, 3, 3], [8, 3, 5, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 5, 3, 3, 3, 3, 3, 3], [2, 3, 3, 3, 3, 3, 3, 3, 3], [4, 3, 3, 3, 3, 3, 3, 3, 3], [1, 1, 1, 3, 3, 3, 5, 6, 5], [8, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [3], reachTape := [0, 1, 3, 7],
  rel := [(0, 0), (0, 1), (0, 3), (0, 7), (1, 0), (1, 1), (1, 3), (1, 7), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 7), (2, 8), (3, 0), (3, 1), (3, 3), (3, 7), (4, 0), (4, 1), (4, 3), (4, 4), (4, 7), (5, 0), (5, 1), (5, 3), (5, 5), (5, 6), (5, 7), (5, 8), (6, 0), (6, 1), (6, 3), (6, 6), (6, 7), (7, 0), (7, 1), (7, 3), (7, 7), (8, 0), (8, 1), (8, 3), (8, 7), (8, 8)],
  z := [0], z2 := [2, 8] }
theorem m_w35_never_halts : ¬ Halts m_w35 := never_halts m_w35 m_w35_cert (by decide +kernel)

def m_w36 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 0, false, 1), (1, 0, 2, false, 0), (1, 2, 0, true, 0)] }
def m_w36_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 1, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w36_never_halts : ¬ Halts m_w36 := never_halts m_w36 m_w36_cert (by decide +kernel)

def m_w37 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w37_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 5, 1, 1, 1, 1, 1, 1], [1, 1, 5, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [6, 4, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w37_never_halts : ¬ Halts m_w37 := never_halts m_w37 m_w37_cert (by decide +kernel)

def m_w38 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 1), (1, 1, 1, false, 0), (1, 2, 2, true, 1)] }
def m_w38_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w38_never_halts : ¬ Halts m_w38 := never_halts m_w38 m_w38_cert (by decide +kernel)

def m_w39 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 2, true, 1)] }
def m_w39_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 3, 4], [1, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 3, 2, 2, 2, 2, 2, 2, 2], [2, 3, 2, 2, 2, 2, 2, 2, 2]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [2], reachTape := [0],
  rel := [(0, 0), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 2), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (4, 0), (4, 2), (4, 4)],
  z := [0], z2 := [1] }
theorem m_w39_never_halts : ¬ Halts m_w39 := never_halts m_w39 m_w39_cert (by decide +kernel)

def wSmall5 : List Machine := [m_w32, m_w33, m_w34, m_w35, m_w36, m_w37, m_w38, m_w39]
theorem wSmall5_never_halt : ∀ x ∈ wSmall5, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w32_never_halts, List.forall_mem_cons.2 ⟨m_w33_never_halts, List.forall_mem_cons.2 ⟨m_w34_never_halts, List.forall_mem_cons.2 ⟨m_w35_never_halts, List.forall_mem_cons.2 ⟨m_w36_never_halts, List.forall_mem_cons.2 ⟨m_w37_never_halts, List.forall_mem_cons.2 ⟨m_w38_never_halts, List.forall_mem_cons.2 ⟨m_w39_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
