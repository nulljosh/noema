import FarCerts.Basic

set_option maxRecDepth 100000

namespace FAR

def m_w56 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (1, 0, 1, false, 1), (1, 1, 0, true, 1), (1, 2, 0, true, 0)] }
def m_w56_cert : Cert := {
  delta := [[0, 0, 1, 2, 2, 3, 2, 2, 4], [0, 1, 1, 4, 3, 3, 2, 2, 4], [5, 2, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 2, 3, 3, 3, 3, 3, 3, 3], [5, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, true, false, true, true, false],
  reachAll := [0, 1, 2, 3, 4, 5], good := [3], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (0, 3), (1, 0), (1, 1), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 3), (4, 4), (5, 0), (5, 1), (5, 3), (5, 5)],
  z := [0], z2 := [2, 5] }
theorem m_w56_never_halts : ¬ Halts m_w56 := never_halts m_w56 m_w56_cert (by decide +kernel)

def m_w57 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 1, false, 0), (0, 2, 2, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w57_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 3, 1, 4], [3, 1, 4, 4, 4, 4, 4, 4, 4], [4, 1, 4, 4, 4, 4, 4, 4, 4], [3, 4, 4, 4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4, 4, 4, 4]],
  acc := [true, false, true, false, true],
  reachAll := [0, 1, 2, 3, 4], good := [4], reachTape := [0],
  rel := [(0, 0), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 0), (3, 3), (3, 4), (4, 0), (4, 4)],
  z := [0], z2 := [1, 3] }
theorem m_w57_never_halts : ¬ Halts m_w57 := never_halts m_w57 m_w57_cert (by decide +kernel)

def m_w58 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 1, 0, false, 0), (0, 2, 2, true, 1), (1, 0, 1, false, 0), (1, 1, 1, true, 1)] }
def m_w58_cert : Cert := {
  delta := [[0, 0, 0, 1, 2, 2, 1, 1, 3], [1, 1, 3, 3, 3, 3, 3, 3, 3], [2, 1, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3]],
  acc := [true, false, true, true],
  reachAll := [0, 1, 2, 3], good := [3], reachTape := [0],
  rel := [(0, 0), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3), (2, 0), (2, 2), (2, 3), (3, 0), (3, 3)],
  z := [0], z2 := [1] }
theorem m_w58_never_halts : ¬ Halts m_w58 := never_halts m_w58 m_w58_cert (by decide +kernel)

def m_w59 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 1, false, 1)] }
def m_w59_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 5, 6], [1, 1, 1, 1, 1, 1, 1, 1, 1], [7, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [7, 6, 3, 1, 1, 1, 1, 1, 1], [7, 5, 3, 1, 1, 1, 1, 1, 1], [1, 5, 3, 1, 1, 1, 1, 1, 1], [7, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6, 7], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 7), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 7), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (6, 0), (6, 1), (6, 3), (6, 6), (7, 0), (7, 1), (7, 7)],
  z := [0], z2 := [2, 7] }
theorem m_w59_never_halts : ¬ Halts m_w59 := never_halts m_w59 m_w59_cert (by decide +kernel)

def m_w60 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 1), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 0, true, 1)] }
def m_w60_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 1, 1, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 1, 1, 1, 1], [6, 1, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 3), (5, 5), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w60_never_halts : ¬ Halts m_w60 := never_halts m_w60 m_w60_cert (by decide +kernel)

def m_w61 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 1), (1, 2, 2, true, 1)] }
def m_w61_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w61_never_halts : ¬ Halts m_w61 := never_halts m_w61 m_w61_cert (by decide +kernel)

def m_w62 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, true, 0), (1, 2, 2, true, 1)] }
def m_w62_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 3], [1, 1, 1, 1, 1, 1, 1, 1, 1], [4, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false],
  reachAll := [0, 1, 2, 3, 4], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4)],
  z := [0], z2 := [2, 4] }
theorem m_w62_never_halts : ¬ Halts m_w62 := never_halts m_w62 m_w62_cert (by decide +kernel)

def m_w63 : Machine := { S := 3, n := 2, rules := [(0, 0, 2, true, 1), (0, 2, 2, false, 0), (1, 0, 1, false, 0), (1, 1, 2, false, 1), (1, 2, 2, true, 1)] }
def m_w63_cert : Cert := {
  delta := [[0, 1, 0, 2, 1, 3, 4, 4, 5], [1, 1, 1, 1, 1, 1, 1, 1, 1], [6, 4, 3, 1, 1, 1, 1, 1, 1], [1, 4, 3, 1, 1, 1, 1, 1, 1], [6, 1, 4, 1, 1, 1, 1, 1, 1], [6, 4, 5, 1, 1, 1, 1, 1, 1], [6, 1, 1, 1, 1, 1, 1, 1, 1]],
  acc := [true, true, false, true, false, false, false],
  reachAll := [0, 1, 2, 3, 4, 5, 6], good := [1], reachTape := [0, 1],
  rel := [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2), (2, 3), (2, 6), (3, 0), (3, 1), (3, 3), (4, 0), (4, 1), (4, 4), (4, 6), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 0), (6, 1), (6, 6)],
  z := [0], z2 := [2, 6] }
theorem m_w63_never_halts : ¬ Halts m_w63 := never_halts m_w63 m_w63_cert (by decide +kernel)

def wSmall8 : List Machine := [m_w56, m_w57, m_w58, m_w59, m_w60, m_w61, m_w62, m_w63]
theorem wSmall8_never_halt : ∀ x ∈ wSmall8, ¬ Halts x :=
  List.forall_mem_cons.2 ⟨m_w56_never_halts, List.forall_mem_cons.2 ⟨m_w57_never_halts, List.forall_mem_cons.2 ⟨m_w58_never_halts, List.forall_mem_cons.2 ⟨m_w59_never_halts, List.forall_mem_cons.2 ⟨m_w60_never_halts, List.forall_mem_cons.2 ⟨m_w61_never_halts, List.forall_mem_cons.2 ⟨m_w62_never_halts, List.forall_mem_cons.2 ⟨m_w63_never_halts, fun _ h => nomatch h⟩⟩⟩⟩⟩⟩⟩⟩

end FAR
