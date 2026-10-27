import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w200 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w200_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w200_never_halts : ¬ Halts m_w200 := never_halts m_w200 m_w200_cert (by decide +kernel)

def m_w201 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (0, 2, 0, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w201_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 3, 1], [1, 3, 1, 3, 3, 3, 3, 3, 3], [2, 3, 1, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w201_never_halts : ¬ Halts m_w201 := never_halts m_w201 m_w201_cert (by decide +kernel)

def m_w202 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 1), (1, 0, 2, false, 0), (1, 1, 1, true, 1), (1, 2, 1, false, 1)] }
def m_w202_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 4, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [5, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [5, 4, 1, 1, 1, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (5, 0), (5, 1), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w202_never_halts : ¬ Halts m_w202 := never_halts m_w202 m_w202_cert (by decide +kernel)

def m_w203 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 0), (0, 2, 2, false, 1), (1, 0, 2, false, 0), (1, 2, 1, true, 1)] }
def m_w203_cert : Cert := {
  delta := [[0, 1, 0, 2, 3, 4, 3, 5, 3], [0, 1, 5, 6, 3, 5, 4, 5, 4], [7, 5, 3, 5, 5, 5, 5, 5, 5], [5, 5, 4, 5, 5, 5, 5, 5, 5], [7, 5, 4, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [5, 5, 3, 5, 5, 5, 5, 5, 5], [7, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, false, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [5], reachTape := [0, 1, 5],
  rel := [(0, 0), (0, 1), (0, 5), (1, 0), (1, 1), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (2, 6), (2, 7), (3, 0), (3, 1), (3, 3), (3, 5), (3, 6), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 5), (6, 6), (7, 0), (7, 1), (7, 5), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w203_never_halts : ¬ Halts m_w203 := never_halts m_w203 m_w203_cert (by decide +kernel)

def m_w204 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, true, 0), (0, 2, 2, false, 0), (1, 0, 2, false, 0), (1, 2, 2, true, 1)] }
def m_w204_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 1, 3, 4, 1], [3, 4, 1, 4, 4, 4, 4, 4, 4], [4, 4, 1, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w204_never_halts : ¬ Halts m_w204 := never_halts m_w204 m_w204_cert (by decide +kernel)

def m_w205 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 1), (1, 2, 1, true, 1)] }
def m_w205_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [2, 1, 4, 1, 1, 1, 1, 1, 1], [3, 1, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w205_never_halts : ¬ Halts m_w205 := never_halts m_w205 m_w205_cert (by decide +kernel)

def m_w206 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 2, false, 0), (1, 1, 2, false, 0), (1, 2, 1, true, 0)] }
def m_w206_cert : Cert := {
  delta := [[0, 0, 1, 2, 3, 1, 4, 5, 4], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [1, 1, 4, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 5), (4, 6), (5, 0), (5, 1), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w206_never_halts : ¬ Halts m_w206 := never_halts m_w206 m_w206_cert (by decide +kernel)

def m_w207 : Machine := { S := 3, n := 2, rules := [(0, 0, 1, true, 1), (0, 1, 0, false, 1), (1, 0, 2, false, 0), (1, 2, 0, true, 0)] }
def m_w207_cert : Cert := {
  delta := [[0, 1, 2, 3, 4, 5, 6, 5, 6], [2, 5, 2, 5, 5, 5, 7, 5, 7], [1, 1, 5, 3, 4, 5, 5, 5, 5], [8, 5, 7, 5, 5, 5, 5, 5, 5], [5, 5, 7, 5, 5, 5, 5, 5, 5], [5, 5, 5, 5, 5, 5, 5, 5, 5], [4, 5, 5, 5, 5, 5, 5, 5, 5], [3, 5, 5, 5, 5, 5, 5, 5, 5], [8, 5, 5, 5, 5, 5, 5, 5, 5]],
  acc := [true, true, true, false, true, true, true, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7, 8], good := [5], reachTape := [0, 1, 2, 5],
  rel := [(0, 0), (0, 1), (0, 2), (0, 5), (1, 0), (1, 1), (1, 2), (1, 5), (2, 0), (2, 1), (2, 2), (2, 5), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 8), (4, 0), (4, 1), (4, 2), (4, 4), (4, 5), (5, 0), (5, 1), (5, 2), (5, 5), (6, 0), (6, 1), (6, 2), (6, 5), (6, 6), (7, 0), (7, 1), (7, 2), (7, 5), (7, 6), (7, 7), (7, 8), (8, 0), (8, 1), (8, 2), (8, 5), (8, 8)],
  z := [0], z2 := [3, 8] }
theorem m_w207_never_halts : ¬ Halts m_w207 := never_halts m_w207 m_w207_cert (by decide +kernel)

def wSmall26 : List Machine := [m_w200, m_w201, m_w202, m_w203, m_w204, m_w205, m_w206, m_w207]
theorem wSmall26_never_halt : ∀ x ∈ wSmall26, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w200_never_halts, List.forall_mem_cons.2 ⟨m_w201_never_halts, List.forall_mem_cons.2 ⟨m_w202_never_halts, List.forall_mem_cons.2 ⟨m_w203_never_halts, List.forall_mem_cons.2 ⟨m_w204_never_halts, List.forall_mem_cons.2 ⟨m_w205_never_halts, List.forall_mem_cons.2 ⟨m_w206_never_halts, List.forall_mem_cons.2 ⟨m_w207_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
